function SWEP:SanityCheck()
    if !IsValid(self) then return false end
    if !IsValid(self:GetOwner()) then return false end
    if !IsValid(self:GetVM()) then return false end
end

function SWEP:GetVM()
    if self:GetOwner():IsNPC() then return end
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
    tbl.BaseClass = nil -- lua tables lel
    return tbl[math.random(1, #tbl)]
end

if SERVER then
    function SWEP:PredictionFilter()
        return false
    end
else
    local isSingleplayer = game.SinglePlayer()

    function SWEP:PredictionFilter()
        return isSingleplayer
    end
end