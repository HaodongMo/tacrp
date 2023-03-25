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

function SWEP:Melee(alt)
    if !self:GetValue("CanMeleeAttack") then return end
    if self:StillWaiting(false, true) then return end
    -- if self:SprintLock() then return end

    self:CancelReload()

    self:ToggleBlindFire(TacRP.BLINDFIRE_NONE)
    self:ScopeToggle(0)

    self:EmitSound(self:ChooseSound(self:GetValue("Sound_MeleeSwing")), 75, 100, 1)

    local dmg = self:GetValue("MeleeDamage")
    local range = self:GetValue("MeleeRange")
    if alt then
        self:PlayAnimation("melee2", 1, false, true)
        self:GetOwner():DoAnimationEvent(self:GetValue("GestureBash2") or self:GetValue("GestureBash"))
        range = self:GetValue("Melee2Range") or range
        dmg = self:GetValue("Melee2Damage") or dmg
    else
        self:PlayAnimation("melee", 1, false, true)
        self:GetOwner():DoAnimationEvent(self:GetValue("GestureBash"))
    end

    local filter = {self:GetOwner()}

    table.Add(filter, self.Shields)

    local start = self:GetOwner():GetShootPos()
    local dir = self:GetOwner():GetAimVector()
    local tr = util.TraceLine({
        start = start,
        endpos = start + dir * range,
        filter = filter,
        mask = MASK_SHOT_HULL,
    })

    -- weapon_hl2mpbasebasebludgeon.cpp: do a hull trace if not hit
    if tr.Fraction == 1 then
        local dim = 32
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
            if dot < 0.5 then
                tr.Fraction = 1
            end
        end
    end

    local dmginfo = DamageInfo()
    dmginfo:SetDamage(dmg)
    dmginfo:SetDamageForce(dir * dmg * 1000)
    dmginfo:SetDamagePosition(tr.HitPos)
    dmginfo:SetDamageType(DMG_CLUB)
    dmginfo:SetAttacker(self:GetOwner())
    dmginfo:SetInflictor(self)

    if tr.Fraction < 1 then

        if IsValid(tr.Entity) and !tr.Entity:IsNextBot() and GetConVar("TacRP_bodydamagecancel"):GetBool() and TacRP.CancelMultipliers[tr.HitGroup] then
            dmginfo:ScaleDamage(1 / TacRP.CancelMultipliers[tr.HitGroup])
        end

        -- Lambda Players call ScalePlayerDamage and cancel out hitgroup damage... except on the head
        if IsValid(tr.Entity) and tr.Entity.IsLambdaPlayer and tr.HitGroup == HITGROUP_HEAD then
            dmginfo:ScaleDamage(1 / TacRP.CancelMultipliers[tr.HitGroup])
        end

        if IsValid(tr.Entity) and !tr.HitWorld and SERVER then
            --tr.Entity:TakeDamageInfo(dmginfo)
            tr.Entity:DispatchTraceAttack(dmginfo, tr)
        end

        if tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:IsNextBot() then
            self:EmitSound(self:ChooseSound(self:GetValue("Sound_MeleeHitBody")), 75, 100, 1, CHAN_ITEM)
        else
            self:EmitSound(self:ChooseSound(self:GetValue("Sound_MeleeHit")), 75, 100, 1, CHAN_ITEM)
        end

        if tr.Entity:IsPlayer() and self:GetValue("MeleeSlow") then
            tr.Entity:SetNWFloat("TacRPLastBashed", CurTime())
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
    self:SetNextSecondaryFire(CurTime() + (alt and self:GetValue("Melee2AttackTime") or self:GetValue("MeleeAttackTime")))

end