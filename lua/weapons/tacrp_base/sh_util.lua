function SWEP:SanityCheck()
    if !IsValid(self) then return false end
    if !IsValid(self:GetOwner()) then return false end
    if !IsValid(self:GetVM()) then return false end
end

function SWEP:GetVM()
    if !IsValid(self:GetOwner()) or !self:GetOwner():IsPlayer() then return end
    return self:GetOwner():GetViewModel()
end

function SWEP:Curve(x)
    return 0.5 * math.cos((x + 1) * math.pi) + 0.5
end

SWEP.LastSysTime = SysTime()
function SWEP:DeltaSysTime()
    local ret = (SysTime() - (self.LastSysTime or SysTime())) * GetConVar("host_timescale"):GetFloat()
    return ret
end

function SWEP:IsAnimLocked()
    return self:GetAnimLockTime() > CurTime()
end

function SWEP:ChooseSound(tbl)
    if !istable(tbl) then return tbl end
    tbl.BaseClass = nil -- lua tables lel
    return tbl[math.random(1, #tbl)]
end

function SWEP:OnReloaded()
    self:InvalidateCache()
    self:SetBaseSettings()

    hook.Run("TacRP_WeaponReloaded", self)
end

function SWEP:DoLowerIrons()
    if self:GetValue("Holosight") or self:GetValue("ScopeOverlay") then return false end
    local i = TacRP.ConVars["irons_lower"]:GetInt()
    return i == 2 or (i == 1 and engine.ActiveGamemode() == "terrortown")
end

function SWEP:DoProceduralIrons()
    local i = TacRP.ConVars["irons_procedural"]:GetInt()
    return self:GetValue("ProceduralIronFire") and (i == 2 or (i == 1 and self:GetValue("Holosight"))) --and (!self.LastShot or self:Clip1() > 1)
end

function SWEP:CountAttachments()
    local count = 0
    for k, v in ipairs(self.Attachments) do
        if v.Installed then count = count + 1 end
    end
    return count
end

function SWEP:GetMaxClip1()
    return self:GetCapacity()
end

function SWEP:IsDamageConstant(base)
    local valfunc = base and self.GetBaseValue or self.GetValue
    return valfunc(self, "Damage_Min") == valfunc(self, "Damage_Max")
end

function SWEP:GetPingOffsetScale()
    if game.SinglePlayer() then return 0 end

    return (self:GetOwner():Ping() - 5) / 1000
end

function SWEP:ScaleFOVByWidthRatio(fovDegrees, ratio)
    local halfAngleRadians = fovDegrees * (0.5 * math.pi / 180)
    local t = math.tan(halfAngleRadians)
    t = t * ratio
    local retDegrees = (180 / math.pi) * math.atan(t)

    return retDegrees * 2
end

function SWEP:WidescreenFix(target)
    return self:ScaleFOVByWidthRatio(target, ((ScrW and ScrW() or 4) / (ScrH and ScrH() or 3)) / (4 / 3))
end

function SWEP:UseAltRecoil(base)
    local valfunc = base and self.GetBaseValue or self.GetValue
    if valfunc(self, "AlwaysAltRecoil") then return true end
    if valfunc(self, "NeverAltRecoil") then return false end
    return TacRP.ConVars["altrecoil"]:GetBool()
end