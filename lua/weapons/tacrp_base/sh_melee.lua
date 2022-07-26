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

    self:GetOwner():DoAnimationEvent(self:GetValue("GestureBash"))

    local filter = {self:GetOwner()}

    table.Add(filter, self.Shields)

    local start = self:GetOwner():GetShootPos()
    local dir = self:GetOwner():GetAimVector()
    local tr = util.TraceLine({
        start = start,
        endpos = start + dir * self:GetValue("MeleeRange"),
        filter = filter,
        mask = MASK_SHOT_HULL,
    })

    -- weapon_hl2mpbasebasebludgeon.cpp: do a hull trace if not hit
    if tr.Fraction == 1 then
        local dim = 16
        local pos2 = tr.HitPos - dir * (dim * 1.732)
        tr = util.TraceHull({
            start = start,
            endpos = pos2,
            filter = filter,
            mask = MASK_SHOT_HULL,
            mins = Vector(-dim, -dim, -dim),
            maxs = Vector(dim, dim, dim)
        })
        if tr.Fraction < 1 and IsValid(tr.Entity) then
            local dot = (tr.Entity:GetPos() - start):GetNormalized():Dot(dir)
            if dot < 0.70721 then
                tr.Fraction = 1
            end
        end
    end

    local dmg = DamageInfo()
    dmg:SetDamage(self:GetValue("MeleeDamage"))
    dmg:SetDamageForce(dir * self:GetValue("MeleeDamage") * 1000)
    dmg:SetDamagePosition(tr.HitPos)
    dmg:SetDamageType(DMG_CLUB)
    dmg:SetAttacker(self:GetOwner())
    dmg:SetInflictor(self)

    if tr.Fraction < 1 then

        if IsValid(tr.Entity) and !tr.Entity:IsNextBot() and GetConVar("TacRP_bodydamagecancel"):GetBool() and TacRP.CancelMultipliers[tr.HitGroup] then
            dmg:ScaleDamage(1 / TacRP.CancelMultipliers[tr.HitGroup])
        end

        if IsValid(tr.Entity) and !tr.HitWorld and SERVER then
            --tr.Entity:TakeDamageInfo(dmg)
            tr.Entity:DispatchTraceAttack(dmg, tr)
        end

        if tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:IsNextBot() then
            self:EmitSound(table.Random(self:GetValue("Sound_MeleeHitBody")), 75, 100, 1, CHAN_ITEM)
        else
            self:EmitSound(table.Random(self:GetValue("Sound_MeleeHit")), 75, 100, 1, CHAN_ITEM)
        end

        --[[]
        if IsFirstTimePredicted() then
            if tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH or tr.MatType == MAT_ANTLION or tr.MatType == MAT_BLOODYFLESH then
                local fx = EffectData()
                fx:SetOrigin(tr.HitPos)

                util.Effect("BloodImpact", fx)
            end

            local fx = EffectData()
            fx:SetOrigin(tr.HitPos)
            fx:SetEntity(tr.Entity)
            fx:SetStart(tr.StartPos)
            fx:SetSurfaceProp(tr.SurfaceProps)
            fx:SetDamageType(DMG_CLUB)
            fx:SetHitBox(tr.HitBox)

            util.Effect("Impact", fx)
        end
        ]]
    end

    -- self:GetOwner():FireBullets({
    --     Damage = self:GetValue("MeleeDamage"),
    --     Force = 32,
    --     Tracer = 0,
    --     Distance = 64,
    --     HullSize = 16,
    --     Dir = self:GetOwner():EyeAngles():Forward(),
    --     Src = self:GetOwner():EyePos(),
    --     Spread = Vector(0, 0, 0),
    --     IgnoreEntity = self.Shields,
    --     Callback = function(att, tr, dmg)
    --         dmg:SetDamageType(DMG_CLUB)

    --         if tr.Hit then
    --             if tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:IsNextBot() then
    --                 self:EmitSound(table.Random(self:GetValue("Sound_MeleeHitBody")), 75, 100, 1, CHAN_ITEM)
    --             else
    --                 self:EmitSound(table.Random(self:GetValue("Sound_MeleeHit")), 75, 100, 1, CHAN_ITEM)
    --             end
    --         end
    --     end
    -- })

    self:SetLastMeleeTime(CurTime())
    self:SetNextSecondaryFire(CurTime() + 0.6)

end