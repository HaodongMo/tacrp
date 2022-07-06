function SWEP:ThinkRecoil()
    if (IsFirstTimePredicted() and CLIENT) or game.SinglePlayer() then
        if self:GetRecoilAmount() > 0 then
            local kick = self:GetValue("RecoilKick")
            local rec = math.min(self:GetRecoilAmount(), 1)
            local sightdelta = self:GetSightDelta()

            local aim_kick_v = rec * kick * math.sin((CurTime() - kick) * 15) * FrameTime() * (1 - sightdelta)
            local aim_kick_h = rec * kick * math.sin(CurTime() * 12.2) * FrameTime() * (1 - sightdelta)

            self:SetFreeAimAngle(self:GetFreeAimAngle() - Angle(aim_kick_v, aim_kick_h, 0))
        end
    end

    if self:GetLastRecoilTime() + self:GetValue("RecoilResetTime") < CurTime() then
        local rec = self:GetRecoilAmount()

        rec = rec - (FrameTime() * self:GetValue("RecoilDissipationRate"))

        rec = math.Clamp(rec, 0, self:GetValue("RecoilMaximum"))

        self:SetRecoilAmount(rec)
    end
end

function SWEP:ApplyRecoil()
    local rec = self:GetRecoilAmount()

    local rps = self:GetValue("RecoilPerShot")

    if rec == 0 then
        rps = rps * self:GetValue("RecoilFirstShotMult")
    end

    rec = rec + rps

    rec = math.Clamp(rec, 0, self:GetValue("RecoilMaximum"))

    self:SetRecoilDirection(util.SharedRandom("tacrp_recoildir", -180, 0))
    -- self:SetRecoilDirection(-90)
    self:SetRecoilAmount(rec)
    self:SetLastRecoilTime(CurTime())

    local vis_kick = self:GetValue("RecoilVisualKick")
    local vis_shake = 0

    vis_kick = vis_kick
    vis_shake = 0

    local vis_kick_v = vis_kick * 1
    local vis_kick_h = vis_kick * util.SharedRandom("tacrp_vis_kick_h", -1, 1)

    self:GetOwner():SetViewPunchAngles(Angle(vis_kick_v, vis_kick_h, vis_shake))

    -- self:GetOwner():SetFOV(self:GetOwner():GetFOV() * 0.99, 0)
    -- self:GetOwner():SetFOV(self:GetOwner():GetFOV(), 60 / (self:GetValue("RPM")))
end