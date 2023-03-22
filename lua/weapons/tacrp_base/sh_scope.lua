function SWEP:ScopeToggle(setlevel)
    if (setlevel or 0) > 0 and (!self:GetValue("Scope") or self:GetPrimedGrenade()) then return end
    -- if setlevel and setlevel > 0 and self:GetAnimLockTime() > CurTime() or (!setlevel and self:GetAnimLockTime() > CurTime()) then return end
    -- if (setlevel and setlevel > 0 and self:GetReloading()) or (!setlevel and self:GetReloading()) then return end

    local level = self:GetScopeLevel()
    local oldlevel = level

    level = setlevel or (level + 1)

    if level > self:GetValue("ScopeLevels") then
        level = self:GetValue("ScopeLevels")
    end

    if self:SprintLock() or self:GetCustomize() or self:GetLastMeleeTime() + 1 > CurTime() then
        level = 0
    end

    if level == self:GetScopeLevel() then return end

    self:SetScopeLevel(level)

    if level > 0 then
        self:ToggleBlindFire(TacRP.BLINDFIRE_NONE)
    end

    if oldlevel == 0 or level == 0 then
        self:SetLastScopeTime(CurTime())
    end

    if CLIENT then
        self:GenerateAutoSight()
    end

    self:EmitSound(self:GetValue("Sound_ScopeIn"), 75, 100, 1, CHAN_ITEM)
end

function SWEP:GetShouldFOV()
    local level = self:GetScopeLevel()

    if level > 0 and !self:GetPeeking() then
        local fov = self:GetValue("ScopeFOV")

        fov = Lerp(level / self:GetValue("ScopeLevels"), 90, fov)

        return fov
    else
        return 90
    end
end

function SWEP:IsInScope()
    local sightdelta = self:Curve(self:GetSightDelta())

    return (SERVER or !self:GetPeeking()) and ((self:GetScopeLevel() > 0 and sightdelta > 0.1) or (sightdelta > 0.9))
end

function SWEP:DoScope()
    if self:IsInScope() then

        local img = self:GetValue("ScopeOverlay")

        if img then
            local h = ScrH()
            local w = ScrW()

            -- assume players have a screen that is wider than it is tall because... that's stupid

            local pos = self:GetOwner():EyePos()

            pos = pos + self:GetShootDir():Forward() * 9000

            local toscreen = pos:ToScreen()

            local x = toscreen.x
            local y = toscreen.y

            local ss = h
            local sx = x - (ss / 2)
            local sy = y - (ss / 2)

            -- local shakey = math.min(cross * 35, 3)

            -- sx = sx + math.Round(math.Rand(-shakey, shakey))
            -- sy = sy + math.Round(math.Rand(-shakey, shakey))

            surface.SetMaterial(img)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawTexturedRect(sx, sy, ss, ss)

            surface.SetDrawColor(0, 0, 0)
            surface.DrawRect(0, 0, w, sy)
            surface.DrawRect(0, sy + ss, w, h - sy)

            surface.DrawRect(0, 0, sx, h)
            surface.DrawRect(sx + ss, 0, w - sx, h)
        end
    end
end

function SWEP:GetSightDelta()
    return self:GetSightAmount()
end

function SWEP:SetSightDelta(d)
    self:SetSightAmount(d)
end

function SWEP:ThinkSights()
    if self:GetOwner():KeyDown(IN_USE) and self:GetOwner():KeyPressed(IN_ATTACK2) then
        self:ToggleSafety()
        return
    end

    local FT = FrameTime()

    if self:GetSafe() then return end

    local sighted = self:GetScopeLevel() > 0

    local amt = self:GetSightAmount()

    if sighted then
        amt = math.Approach(amt, 1, FT / self:GetValue("AimDownSightsTime"))
    else
        amt = math.Approach(amt, 0, FT / self:GetValue("AimDownSightsTime"))
    end

    self:SetSightDelta(amt)

    if CLIENT then
        self:ThinkPeek()
    end

    if sighted and !self:GetOwner():KeyDown(IN_ATTACK2) then
        self:ScopeToggle(0)
    elseif !sighted and self:GetOwner():KeyDown(IN_ATTACK2) then
        self:ScopeToggle(1)
    end
end

function SWEP:GetMagnification()
    local mag = 1

    local level = self:GetScopeLevel()

    if level > 0 then

        if self:GetPeeking() then
            return 1.25
        end

        mag = 90 / self:GetValue("ScopeFOV")

        mag = Lerp(level / self:GetValue("ScopeLevels"), 1, mag)
    end

    return mag
end

function SWEP:AdjustMouseSensitivity()
    local mag = self:GetMagnification()

    if mag > 1 then
        return 1 / mag
    end
end

function SWEP:ThinkPeek()
    if IsFirstTimePredicted() and !GetConVar("tacrp_togglepeek"):GetBool() and self:GetPeeking() ~= input.IsKeyDown(input.GetKeyCode(input.LookupBinding("menu_context") or "???")) then
        net.Start("tacrp_togglepeek")
        net.WriteBool(!self:GetPeeking())
        net.SendToServer()
    end
end

function SWEP:GetCCIP(pos, ang)
    -- get calculated point of impact

    local sp, sa = self:GetMuzzleOrigin(), self:GetShootDir()

    pos = pos or sp
    ang = ang or sa

    local v = self:GetValue("MuzzleVelocity")
    local g = 1
    local d = 1

    local vel = ang:Forward() * v
    local maxiter = 100
    local timestep = 1 / 15

    for i = 1, maxiter do
        local dir = vel:GetNormalized()
        local spd = vel:Length() * timestep
        local drag = d * spd * spd * (1 / 150000)
        local gravity = timestep * g * 600

        if spd <= 0.001 then return nil end

        local newpos = pos + (vel * timestep)
        local newvel = vel - (dir * drag) - Vector(0, 0, gravity)

        local tr = util.TraceLine({
            start = pos,
            endpos = newpos,
            filter = self:GetOwner(),
            mask = MASK_SHOT
        })

        if tr.HitSky then
            return nil
        elseif tr.Hit then
            return tr, i * timestep
        else
            pos = newpos
            vel = newvel
        end
    end

    return nil
end

function SWEP:GetCorVal()
    local vmfov = self.ViewModelFOV
    local fov = self:GetShouldFOV()

    return vmfov / (fov * 1.33333)
end