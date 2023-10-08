function SWEP:InBipod()
    local bip = self:GetInBipod()

    -- if !self:CanBipod() then
    --     self:ExitBipod()
    -- end

    if IsValid(self:GetOwner()) and self:GetBipodPos() != self:GetOwner():EyePos() then
        self:ExitBipod()
    end

    return bip
end

SWEP.CachedCanBipod = true
SWEP.CachedCanBipodTime = 0
SWEP.LastBipodTime = 0
local dist = 24
function SWEP:CanBipod()
    if !self:GetValue("Bipod") then return false end

    if self:GetOwner():InVehicle() then return false end

    if self.CachedCanBipodTime >= CurTime() then return tobool(self.CachedCanBipod), self.CachedCanBipod end

    local pos = self:GetOwner():EyePos()
    local angle = self:GetOwner():EyeAngles()
    if math.abs(angle.p) <= 45 then
        angle.p = 0
    end
    if self:GetOwner():GetVelocity():Length() > 0 then
        return false
    end

    local rangemult = 2
    if self:IsProne() then
        rangemult = rangemult * 1.25
    end

    local tr = util.TraceLine({
        start = pos,
        endpos = pos + (angle:Forward() * dist * rangemult),
        filter = self:GetOwner(),
        mask = MASK_PLAYERSOLID
    })

    if tr.Hit then -- check for stuff in front of us
        return false
    end

    local maxs = Vector(8, 8, 16)
    local mins = Vector(-8, -8, 0)

    angle.p = angle.p + 60

    tr = util.TraceHull({
        start = pos,
        endpos = pos + (angle:Forward() * dist * rangemult),
        filter = self:GetOwner(),
        maxs = maxs,
        mins = mins,
        mask = MASK_PLAYERSOLID
    })

    self.CachedCanBipodTime = CurTime()

    if tr.Hit then
        local tr2 = util.TraceHull({
            start = tr.HitPos,
            endpos = tr.HitPos + Vector(0, 0, -dist),
            filter = self:GetOwner(),
            maxs = maxs,
            mins = mins,
            mask = MASK_PLAYERSOLID
        })
        if tr2.Hit then
            self.CachedCanBipod = tr2
            return true, tr2
        end
    end

    self.CachedCanBipod = false
    return false
end

function SWEP:EnterBipod(sp)
    if !sp and self:GetInBipod() then return end
    local can, tr = self:CanBipod()
    if !sp and !can then return end

    if SERVER and game.SinglePlayer() then self:CallOnClient("EnterBipod", "true") end
    self.LastBipodTime = CurTime()

    local bipodang = tr.HitNormal:Cross(self:GetOwner():EyeAngles():Right()):Angle()

    debugoverlay.Axis(tr.HitPos, tr.HitNormal:Angle(), 16, 5, true)
    debugoverlay.Line(tr.HitPos, tr.HitPos + bipodang:Forward() * 32, 5, color_white, true)
    debugoverlay.Line(tr.HitPos, tr.HitPos + self:GetOwner():EyeAngles():Forward() * 32, 5, Color(255, 255, 0), true)

    self:SetBipodPos(self:GetOwner():EyePos())
    self:SetBipodAngle(bipodang)
    self.BipodStartAngle = self:GetOwner():EyeAngles()

    if game.SinglePlayer() and CLIENT then return end

    self:EmitSound(self.Sound_BipodDown, 70, 100, 1, CHAN_ITEM)
    self:SetInBipod(true)
    self:DoBodygroups()
end

function SWEP:ExitBipod(sp)
    if !sp and !self:GetInBipod() then return end

    if SERVER and game.SinglePlayer() then self:CallOnClient("ExitBipod", "true") end
    self.LastBipodTime = CurTime()

    if game.SinglePlayer() and CLIENT then return end

    self:EmitSound(self.Sound_BipodUp, 70, 100, 1, CHAN_ITEM)
    self:SetInBipod(false)
    self:DoBodygroups()
end

function SWEP:IsProne()
    if PRONE_INPRONE then
        return self:GetOwner().IsProne and self:GetOwner():IsProne()
    else
        return false
    end
end