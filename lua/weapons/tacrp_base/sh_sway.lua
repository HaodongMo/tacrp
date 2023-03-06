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
    --local stunned = self:GetOwner():GetNWFloat("TacRPStunStart", 0) + self:GetOwner():GetNWFloat("TacRPStunDur", 0) > CurTime()
    if !self:IsSwayEnabled() then return Angle(0, 0, 0) end
    local swayamt = self:GetSwayAmount()
    local swayspeed = 1

    -- if stunned then
    --     local d = (CurTime() - self:GetOwner():GetNWFloat("TacRPStunStart", 0)) / self:GetOwner():GetNWFloat("TacRPStunDur", 0)
    --     swayamt = swayamt + Lerp(d, 5, 0)
    --     swayspeed = swayspeed * Lerp(d, 0.98, 1)
    -- end

    local ct = CLIENT and UnPredictedCurTime() or CurTime()

    local ang = Angle(math.sin(ct * 0.6 * swayspeed) + (math.cos(ct * 2) * 0.5), math.sin(ct * 0.4 * swayspeed) + (math.cos(ct * 1.6) * 0.5), 0)

    ang = ang * swayamt

    return ang
end

function SWEP:IsSwayEnabled()
    return GetConVar("tacrp_sway"):GetBool()
end