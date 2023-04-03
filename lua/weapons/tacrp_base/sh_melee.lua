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

    self.Primary.Automatic = true
    self.Secondary.Automatic = true

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
    if tr.Fraction == 1 or !IsValid(tr.Entity) then
        local dim = 32
        local pos2 = tr.HitPos - dir * (dim * 1.732)
        local tr2 = util.TraceHull({
            start = start,
            endpos = pos2,
            filter = filter,
            mask = MASK_SHOT_HULL,
            mins = Vector(-dim, -dim, -dim),
            maxs = Vector(dim, dim, dim)
        })
        if tr2.Fraction < 1 and IsValid(tr2.Entity) then
            local dot = (tr2.Entity:GetPos() - start):GetNormalized():Dot(dir)
            if dot >= 0.5 then
                tr = tr2
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

    local t = (alt and self:GetValue("Melee2AttackTime") or self:GetValue("MeleeAttackTime"))

    if tr.Fraction < 1 then

        TacRP.CancelBodyDamage(tr.Entity, dmginfo, tr.HitGroup)

        if IsValid(tr.Entity) and (tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:IsNextBot()) then
            self:EmitSound(self:ChooseSound(self:GetValue("Sound_MeleeHitBody")), 75, 100, 1, CHAN_ITEM)

            if self:GetValue("MeleeBackstab") then
                local ang = math.NormalizeAngle(self:GetOwner():GetAngles().y - tr.Entity:GetAngles().y)
                if ang <= 60 and ang >= -60 then
                    dmginfo:ScaleDamage(self:GetValue("MeleeBackstabMult"))
                    self:EmitSound("tacrp/riki_backstab.wav", 70, 100, 0.4)
                end
            end
        else
            self:EmitSound(self:ChooseSound(self:GetValue("Sound_MeleeHit")), 75, 100, 1, CHAN_ITEM)
        end

        if IsValid(tr.Entity) and tr.Entity:IsPlayer() and self:GetValue("MeleeSlow") then
            tr.Entity.TacRPBashSlow = true
        end

        if IsValid(tr.Entity) and !tr.HitWorld then
            --tr.Entity:TakeDamageInfo(dmginfo)
            tr.Entity:DispatchTraceAttack(dmginfo, tr)
        end
    else
        if !alt and self:GetValue("MeleeAttackMissTime") then
            t = self:GetValue("MeleeAttackMissTime")
        elseif alt and self:GetValue("Melee2AttackMissTime") then
            t = self:GetValue("Melee2AttackMissTime")
        end
    end

    self:SetLastMeleeTime(CurTime())
    self:SetNextSecondaryFire(CurTime() + t)

end

hook.Add("PostEntityTakeDamage", "tacrp_melee", function(ent, dmg, took)
    if ent.TacRPBashSlow then
        if took and ent:IsPlayer() then
            ent:SetNWFloat("TacRPLastBashed", CurTime())
        end
        ent.TacRPBashSlow = false
    end

    local wep = dmg:GetInflictor()
    if (!IsValid(wep) or !wep:IsWeapon()) and IsValid(dmg:GetAttacker()) and dmg:GetAttacker():IsPlayer() then wep = dmg:GetAttacker():GetActiveWeapon() end
    if took and (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) and IsValid(wep) and wep.ArcticTacRP and wep:GetValue("Lifesteal") then
        local v = dmg:GetDamage() * wep:GetValue("Lifesteal")
        wep:GetOwner():SetHealth(math.min(wep:GetOwner():GetMaxHealth(), wep:GetOwner():Health() + v))
    end
end)