SWEP.LockOnEntity = NULL

SWEP.LastSearchTime = 0

SWEP.PlayedLockOnSound = false

function SWEP:ThinkLockOn()
    local owner = self:GetOwner()
    local lastlockonentity = self:GetLockOnEntity()

    local should_autoaim_scan = false

    if CLIENT then
        if self.LastSearchTime + 0.1 + engine.TickInterval() < CurTime() then
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

        if !IsValid(self:GetLockOnEntity()) then
            self.PlayedLockOnSound = false
        end
    else
        if owner:KeyPressed(TacRP.IN_RELOCK) then
            should_autoaim_scan = true
        end

        if self.LastSearchTime + 0.25 + engine.TickInterval() < CurTime() then
            should_autoaim_scan = true
            self.LastSearchTime = CurTime()
        end
    end

    if not ((self:GetSightAmount() >= 1 and self:GetValue("LockOnInSights")) or (self:GetSightAmount() < 1 and self:GetValue("LockOnOutOfSights"))) then
        self:SetLockOnEntity(nil)
        self:SetLockOnStartTime(CurTime())
    elseif should_autoaim_scan then
        local lockontargets = ents.FindInCone(owner:GetShootPos(), owner:GetAimVector(), self:GetValue("LockOnRange"), self:GetValue("LockOnAngle"))

        local lockontarget = nil
        local targeted_flare = false
        local angle = 90

        local player_aim_vector = owner:GetAimVector()

        for _, target in ipairs(lockontargets) do
            if not IsValid(target) then continue end
            if target == owner then continue end

            local try_target = nil

            if TacRP.FlareEntities[target:GetClass()] then
                try_target = target
                targeted_flare = true
            end

            if not targeted_flare then
                if target:IsPlayer() and target:Alive() then
                    try_target = target
                elseif (target:IsNPC() or target:IsNextBot()) and target:Health() > 0 then
                    try_target = target
                elseif target.LVS or target.Targetable then
                    try_target = target
                elseif TacRP.LockableEntities[target:GetClass()] then
                    try_target = target
                end
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

        if lockontarget and IsValid(lockontarget) then
            if lastlockonentity != lockontarget then
                self:SetLockOnStartTime(CurTime())
                if CLIENT and (IsFirstTimePredicted() or game.SinglePlayer()) then
                    self:EmitSound(self:GetValue("Sound_StartLockOn"))
                end
            elseif not self.PlayedLockOnSound and CurTime() > self:GetLockOnStartTime() + self:GetValue("LockOnTime") then
                if CLIENT and (IsFirstTimePredicted() or game.SinglePlayer()) then
                    self:EmitSound(self:GetValue("Sound_FinishLockOn"))
                    self.PlayedLockOnSound = true
                end
            end
            self:SetLockOnEntity(lockontarget)
            self.LockOnEntity = lockontarget
        else
            self:SetLockOnEntity(nil)
            self.PlayedLockOnSound = false
            self:SetLockOnStartTime(CurTime())
        end
    end

    if not IsValid(self:GetLockOnEntity()) then
        self:SetLockOnEntity(nil)
        self:SetLockOnStartTime(CurTime())
    end
end