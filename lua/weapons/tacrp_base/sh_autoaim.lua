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
        local lockontarget = nil

        if lastlockonentity and IsValid(lastlockonentity) then
            // check if it remains within seeker cage

            local player_aim_vector = owner:GetAimVector()
            local target_angle = math.deg(math.acos(player_aim_vector:Dot((lastlockonentity:WorldSpaceCenter() - owner:GetShootPos()):GetNormalized())))

            local dist = (lastlockonentity:WorldSpaceCenter() - owner:GetShootPos()):Length()

            if target_angle < self:GetValue("LockOnTrackAngle") and dist < self:GetValue("LockOnRange") then
                lockontarget = lastlockonentity
            end
        else
            local tr = util.TraceLine(
                {
                    start = owner:GetShootPos(),
                    endpos = owner:GetShootPos() + owner:GetAimVector() * self:GetValue("LockOnRange"),
                    ignoreworld = true,
                    filter = function(target)
                        if target == owner then return false end
                        if target:IsPlayer() then return true end
                        if (target:IsNPC() or target:IsNextBot()) then return true end
                        if (target.LVS and target:GetHP() > 0) or target.Targetable then return true end
                        if TacRP.LockableEntities[target:GetClass()] then return true end
                        if TacRP.FlareEntities[target:GetClass()] then return true end
                    end
                }
            )

            lockontarget = tr.Entity
        end

        if lockontarget and IsValid(lockontarget) then
            local occlusion_tr = util.TraceLine({
                start = owner:GetShootPos(),
                endpos = lockontarget:WorldSpaceCenter(),
                mask = MASK_SHOT,
                filter = function(ent)
                    if ent == lockontarget or ent == owner or ent:GetOwner() == lockontarget then return false end
                    if ent:IsVehicle() and ent:GetDriver() == owner then return false end
                    if ent:GetClass() == "lvs_wheeldrive_wheel" or scripted_ents.IsBasedOn(ent:GetClass(), "tacrp_proj_base") then return false end
                    return true
                end
            })
            if occlusion_tr.Hit then lockontarget = nil end
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