AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "C4"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/c4_charge-1.mdl"

ENT.Sticky = true

ENT.IsRocket = false // projectile has a booster and will not drop.

ENT.InstantFuse = false // projectile is armed immediately after firing.
ENT.RemoteFuse = true // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = false // projectile explodes on impact.

ENT.ExplodeOnDamage = true // projectile explodes when it takes damage.
ENT.ExplodeUnderwater = false

ENT.Defusable = true

ENT.Delay = 0.5

ENT.ExplodeSounds = {
    "TacRP/weapons/breaching_charge-1.wav"
}

function ENT:Detonate()
    util.BlastDamage(self, self:GetOwner(), self:GetPos(), 512, 200)

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