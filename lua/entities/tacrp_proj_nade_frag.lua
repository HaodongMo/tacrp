AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "Frag Grenade"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/frag.mdl"

ENT.IsRocket = false // projectile has a booster and will not drop.

ENT.InstantFuse = true // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = false // projectile explodes on impact.

ENT.ExplodeOnDamage = false // projectile explodes when it takes damage.
ENT.ExplodeUnderwater = false

ENT.Delay = 3.5

ENT.BounceSounds = {
    "TacRP/weapons/grenade/frag_bounce-1.wav",
    "TacRP/weapons/grenade/frag_bounce-2.wav",
    "TacRP/weapons/grenade/frag_bounce-3.wav",
}

ENT.ExplodeSounds = {
    "TacRP/weapons/grenade/frag_explode-1.wav",
    "TacRP/weapons/grenade/frag_explode-2.wav",
    "TacRP/weapons/grenade/frag_explode-3.wav",
}

function ENT:Detonate()
    util.BlastDamage(self, self:GetOwner(), self:GetPos(), 350, 110)

    local fx = EffectData()
    fx:SetOrigin(self:GetPos())

    if self:WaterLevel() > 0 then
        util.Effect("WaterSurfaceExplosion", fx)
    else
        util.Effect("Explosion", fx)
    end

    self:EmitSound(table.Random(self.ExplodeSounds), 125)

    self:Remove()
end