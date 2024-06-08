SWEP.LockOnEntity = NULL

SWEP.LastSearchTime = 0

function SWEP:ThinkLockOn()
    local owner = self:GetOwner()
    local lastlockonentity = self:GetLockOnEntity()

    local should_autoaim_scan = false

    if CLIENT then
        if self.LastSearchTime + 0.1 < CurTime() then
            should_autoaim_scan = true
            self.LastSearchTime = CurTime()
        end

        if not game.SinglePlayer() and not IsFirstTimePredicted() then
            // There is zero sense in running this very expensive block of calculations every time prediction is called
            // We have to PRETEND like we find this in the predicted blocks, but we'll actually find it the first time around
            // So... This is a shortcut!
            self:SetLockOnEntity(self.LockOnEntity)
            should_autoaim_scan = false
        end
    else
        if owner:KeyPressed(IN_BULLRUSH) then
            should_autoaim_scan = true
        end

        if self.LastSearchTime + 0.25 < CurTime() then
            should_autoaim_scan = true
            self.LastSearchTime = CurTime()
        end
    end

    if not ((self:GetSightAmount() >= 1 and self:GetValue("AutoAimInSights")) or (self:GetSightAmount() < 1 and self:GetValue("AutoAimOutOfSights"))) then
        self:SetLockOnEntity(nil)
        return
    elseif should_autoaim_scan then
        local lockontargets = ents.FindInCone(owner:GetShootPos(), owner:GetAimVector(), self:GetValue("AutoAimRange"), self:GetValue("AutoAimAngle"))

        local lockontarget = nil
        local angle = 90

        local player_aim_vector = owner:GetAimVector()

        for _, target in ipairs(lockontargets) do
            if not IsValid(target) then continue end
            if not target:IsNPC() and not target:IsPlayer() and not target:IsNextBot() then continue end
            if target == owner then continue end

            local try_target = nil
            if target:IsPlayer() and target:Alive() then
                try_target = target
            elseif (target:IsNPC() or target:IsNextBot()) and target:Health() > 0 then
                try_target = target
            end

            if try_target then
                // Dot product
                local target_angle = math.deg(math.acos(player_aim_vector:Dot((try_target:WorldSpaceCenter() - owner:GetShootPos()):GetNormalized())))

                if target_angle < angle then

                    local occlusion_tr = util.TraceLine({
                        start = owner:GetShootPos(),
                        endpos = try_target:WorldSpaceCenter(),
                        mask = MASK_SHOT,
                        filter = function(ent)
                            if ent == try_target then return false end
                            if ent == owner then return false end
                            if ent:GetOwner() == try_target then return false end
                            if ent:IsVehicle() and ent:GetDriver() == owner then return false end
                            return true
                        end
                    })

                    if occlusion_tr.Hit then continue end

                    lockontarget = try_target
                    angle = target_angle
                end
            end
        end

        if lockontarget then
            if lastlockonentity != lockontarget then
                self:SetLockOnStartTime(CurTime())
            end
            self:SetLockOnEntity(lockontarget)
            self.LockOnEntity = lockontarget
        else
            self:SetLockOnEntity(nil)
            self.LockOnEntity = nil
        end

    end

    if not IsValid(self:GetLockOnEntity()) then
        self:SetLockOnEntity(nil)
    end
end