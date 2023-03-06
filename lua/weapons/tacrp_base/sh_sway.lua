function SWEP:GetSwayAmount()
    local sway = self:GetValue("Sway")

    local d = self:GetSightDelta()
    sway = Lerp(d, sway, self:GetValue("ScopedSway"))

    if self:GetBlindFire() then
        sway = sway + self:GetValue("BlindFireSway")
    end

    return sway
end

function SWEP:GetSwayAngles()
    local swayamt = self:IsSwayEnabled() and self:GetSwayAmount() or 0
    local swayspeed = 1

    if swayamt <= 0 then return Angle(0, 0, 0) end

    local ct = CLIENT and UnPredictedCurTime() or CurTime()

    local ang = Angle(math.sin(ct * 0.6 * swayspeed) + (math.cos(ct * 2) * 0.5), math.sin(ct * 0.4 * swayspeed) + (math.cos(ct * 1.6) * 0.5), 0)

    ang = ang * swayamt

    return ang
end

function SWEP:IsSwayEnabled()
    return GetConVar("tacrp_sway"):GetBool()
end