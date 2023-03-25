AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "Thrown Knife"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/w_knife.mdl"

ENT.IsRocket = false // projectile has a booster and will not drop.

ENT.InstantFuse = false // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = true // projectile explodes on impact.

ENT.ExplodeOnDamage = false // projectile explodes when it takes damage.
ENT.ExplodeUnderwater = true

ENT.Delay = 0

ENT.SmokeTrail = false
ENT.BounceSounds = {
    "TacRP/weapons/grenade/flashbang_bounce-1.wav",
    "TacRP/weapons/grenade/flashbang_bounce-2.wav",
    "TacRP/weapons/grenade/flashbang_bounce-3.wav",
}


function ENT:Impact(data, collider)
    self:EmitSound("tacrp/weapons/knife/scrape_metal-" .. math.random(2, 3) .. ".wav", 80, 115)

    if IsValid(data.HitEntity) then
        local d = data.OurOldVelocity:GetNormalized()

        local attacker = self.Attacker or self:GetOwner() or self
        local dmg = DamageInfo()
        dmg:SetAttacker(attacker)
        dmg:SetInflictor(self)
        dmg:SetDamage(65)
        dmg:SetDamageType(DMG_SLASH)
        dmg:SetDamageForce(d * 5000)
        dmg:SetDamagePosition(data.HitPos)

        if !data.HitEntity:IsOnGround() then
            dmg:ScaleDamage(2)
            data.HitEntity:EmitSound("weapons/crossbow/bolt_skewer1.wav", 90, 110)
        end

        data.HitEntity:TakeDamageInfo(dmg)
    end

    local ang = data.OurOldVelocity:Angle()
    local fx = EffectData()
    fx:SetOrigin(data.HitPos)
    fx:SetNormal(-ang:Forward())
    fx:SetAngles(-ang)
    util.Effect("ManhackSparks", fx)

    self:Remove()
    return true
end