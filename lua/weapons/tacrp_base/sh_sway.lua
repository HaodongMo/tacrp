function SWEP:GetSwayAmount(pure)
    if self:GetOwner():IsNPC() then return 0 end

    local sway = self:GetValue("Sway")

    local d = self:GetSightDelta() - (self:GetPeeking() and self:GetValue("PeekPenaltyFraction") or 0)
    sway = Lerp(d, sway, self:GetValue("ScopedSway"))

    if self:GetBlindFire() then
        sway = sway + self:GetValue("BlindFireSway")
    end

    if self:GetOwner():Crouching() and !(self:GetOwner():KeyDown(IN_FORWARD) or self:GetOwner():KeyDown(IN_MOVELEFT) or self:GetOwner():KeyDown(IN_MOVERIGHT) or self:GetOwner():KeyDown(IN_BACK)) then
        sway = sway * self:GetValue("SwayCrouchMult")
    end

    if !pure then
        sway = sway + self:GetForcedSwayAmount()
    end

    return sway
end

function SWEP:GetForcedSwayAmount()
    local sway = 0

    if self:GetOwner():GetNWFloat("TacRPGasEnd", 0) > CurTime() then
        sway = sway + TacRP.ConVars["gas_sway"]:GetFloat() * Lerp(self:GetSightAmount(), 1, 0.25) * math.Clamp((self:GetOwner():GetNWFloat("TacRPGasEnd") - CurTime()) / 2, 0, 1)
    end

    return sway
end

function SWEP:GetSwayAngles()
    local swayamt = self:IsSwayEnabled() and self:GetSwayAmount() or self:GetForcedSwayAmount()
    local swayspeed = 1

    if swayamt <= 0 then return Angle(0, 0, 0) end

    local ct = CLIENT and UnPredictedCurTime() or CurTime()

    local ang = Angle(math.sin(ct * 0.6 * swayspeed) + (math.cos(ct * 2) * 0.5), math.sin(ct * 0.4 * swayspeed) + (math.cos(ct * 1.6) * 0.5), 0)

    ang = ang * swayamt

    return ang
end

function SWEP:IsSwayEnabled()
    return TacRP.ConVars["sway"]:GetBool()
end