function SWEP:Think()
    local owner = self:GetOwner()

    -- if owner:KeyReleased(IN_ATTACK) then
    --     if !self:GetValue("RunawayBurst") then
    --         self:SetBurstCount(0)
    --     end
    --     if self:GetCurrentFiremode() < 0 and !self:GetValue("RunawayBurst") and self:GetBurstCount() > 0 then
    --         self:SetNextPrimaryFire(CurTime() + self:GetValue("PostBurstDelay"))
    --     end
    -- end

    -- if self:GetValue("RunawayBurst") then
    --     if self:GetBurstCount() > -self:GetCurrentFiremode() then
    --         self:SetBurstCount(0)
    --         self:SetNextPrimaryFire(CurTime() + self:GetValue("PostBurstDelay"))
    --     elseif self:GetBurstCount() > 0 then
    --         self:PrimaryAttack()
    --     end
    -- end

    if owner:KeyReleased(IN_ATTACK) then
        if !self:GetValue("RunawayBurst") then
            self:SetBurstCount(0)
        end
        if -self:GetCurrentFiremode() < 0 and !self:GetValue("RunawayBurst") and self:GetBurstCount() > 0 then
            self:SetNextPrimaryFire(CurTime() + self:GetValue("PostBurstDelay"))
        end
    end

    if self:GetValue("RunawayBurst") then
        if self:GetBurstCount() >= -self:GetCurrentFiremode() and -self:GetCurrentFiremode() > 0 then
            self:SetBurstCount(0)
            self:SetNextPrimaryFire(CurTime() + self:GetValue("PostBurstDelay"))
        elseif self:GetBurstCount() > 0 and self:GetBurstCount() < -self:GetCurrentFiremode() then
            self:PrimaryAttack()
        end
    end

    self:ThinkRecoil()

    self:ThinkSprint()

    self:ThinkGrenade()

    self:ThinkReload()

    self:ThinkSights()

    self:ThinkFreeAim()

    self:ThinkBlindFire()

    self:ProcessTimers()

    if self:GetNextIdle() < CurTime() then
        self:Idle()
    end

    if CLIENT then
        if !self.LoadedPreset then
            self.LoadedPreset = true

            if GetConVar("TacRP_autosave"):GetBool() then
                self:LoadPreset()
                self:DoDeployAnimation()
            end
        end
    end
end