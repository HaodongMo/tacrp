SWEP.Sound_MeleeHit = {
    "TacRP/weapons/melee_hit-1.wav",
    "TacRP/weapons/melee_hit-2.wav"
}
SWEP.Sound_MeleeHitBody = {
    "TacRP/weapons/melee_body_hit-1.wav",
    "TacRP/weapons/melee_body_hit-2.wav",
    "TacRP/weapons/melee_body_hit-3.wav",
    "TacRP/weapons/melee_body_hit-4.wav",
    "TacRP/weapons/melee_body_hit-5.wav",
}

function SWEP:Melee()
    -- if self:GetValue("CanQuickNade") then
    --     if self:GetOwner():KeyDown(IN_USE) then
    --         self:SelectGrenade()
    --         self:EmitSound("TacRP/weapons/switch_grenade-1.wav")
    --         return
    --     end
    -- end

    -- if self:GetValue("Scope") then
    --     self:ScopeToggle()
    --     return
    -- end
    if self:StillWaiting() then return end
    if self:SprintLock() then return end
    if !self:GetValue("CanMeleeAttack") then return end

    self:PlayAnimation("melee", 1, false, true)

    self:GetOwner():DoAnimationEvent(ACT_GMOD_GESTURE_MELEE_SHOVE_1HAND)

    self:GetOwner():FireBullets({
        Damage = self:GetValue("MeleeDamage"),
        Force = 32,
        Tracer = 0,
        Distance = 64,
        HullSize = 16,
        Dir = self:GetOwner():EyeAngles():Forward(),
        Src = self:GetOwner():EyePos(),
        Spread = Vector(0, 0, 0),
        Callback = function(att, tr, dmg)
            dmg:SetDamageType(DMG_CLUB)

            if tr.Hit then
                if tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:IsNextBot() then
                    self:EmitSound(table.Random(self:GetValue("Sound_MeleeHitBody")), 75, 100, 1, CHAN_ITEM)
                else
                    self:EmitSound(table.Random(self:GetValue("Sound_MeleeHit")), 75, 100, 1, CHAN_ITEM)
                end
            end
        end
    })

    self:SetLastMeleeTime(CurTime())

    self:SetNextSecondaryFire(CurTime() + 0.5)
end