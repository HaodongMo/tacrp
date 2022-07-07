SWEP.ClientFreeAimAng = Angle(0, 0, 0)

function SWEP:ThinkFreeAim()
    if self:GetValue("FreeAim") then
        local diff = self:GetOwner():EyeAngles() - self:GetLastAimAngle()

        local freeaimang = Angle(self:GetFreeAimAngle())

        local max = self:GetValue("FreeAimMaxAngle")

        local sightdelta = self:Curve(self:GetSightDelta())
        local blindfiredelta = self:GetBlindFireAmount()

        max = max * Lerp(blindfiredelta, 1, 0.25)

        max = max * Lerp(sightdelta, 1, 0)

        diff.p = math.NormalizeAngle(diff.p)
        diff.y = math.NormalizeAngle(diff.y)

        diff = diff * Lerp(sightdelta, 1, 0.25)

        freeaimang.p = math.Clamp(math.NormalizeAngle(freeaimang.p) + math.NormalizeAngle(diff.p), -max, max)
        freeaimang.y = math.Clamp(math.NormalizeAngle(freeaimang.y) + math.NormalizeAngle(diff.y), -max, max)

        local ang2d = math.atan2(freeaimang.p, freeaimang.y)
        local mag2d = math.sqrt(math.pow(freeaimang.p, 2) + math.pow(freeaimang.y, 2))

        mag2d = math.min(mag2d, max)

        freeaimang.p = mag2d * math.sin(ang2d)
        freeaimang.y = mag2d * math.cos(ang2d)

        self:SetFreeAimAngle(freeaimang)

        if CLIENT then
            self.ClientFreeAimAng = freeaimang
        end
    end

    self:SetLastAimAngle(self:GetOwner():EyeAngles())
end

function SWEP:GetFreeAimOffset()
    if !GetConVar("tacrp_freeaim"):GetBool() or !self:GetValue("FreeAim") then return Angle(0, 0, 0) end
    if CLIENT then
        return self.ClientFreeAimAng
    else
        return self:GetFreeAimAngle()
    end
end