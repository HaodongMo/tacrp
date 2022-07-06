AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "RPG-7 Rocket"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/rocket_deployed.mdl"

ENT.IsRocket = true // projectile has a booster and will not drop.

ENT.InstantFuse = false // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = true // projectile explodes on impact.

ENT.ExplodeOnDamage = false // projectile explodes when it takes damage.
ENT.ExplodeUnderwater = true

ENT.Delay = 0

ENT.AudioLoop = "TacRP/weapons/rpg7/rocket_flight-1.wav"

ENT.SmokeTrail = true

function ENT:Detonate()
    if self.SpawnTime + 0.1 > CurTime() then
        local fx = EffectData()
        fx:SetOrigin(self:GetPos())
        fx:SetNormal(-self:GetAngles():Forward())
        fx:SetAngles(-self:GetAngles())
        util.Effect("ManhackSparks", fx)
        self:Remove()
        return
    end

    util.BlastDamage(self, self:GetOwner(), self:GetPos(), 100, 750)
    util.BlastDamage(self, self:GetOwner(), self:GetPos(), 400, 150)

    local fx = EffectData()
    fx:SetOrigin(self:GetPos())

    if self:WaterLevel() > 0 then
        util.Effect("WaterSurfaceExplosion", fx)
    else
        util.Effect("Explosion", fx)
    end

    self:EmitSound("TacRP/weapons/rpg7/explode.wav", 125)

    self:Remove()
end