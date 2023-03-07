AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "Flash Grenade"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/flashbang.mdl"

ENT.IsRocket = false // projectile has a booster and will not drop.

ENT.InstantFuse = true // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = false // projectile explodes on impact.

ENT.ExplodeOnDamage = false // projectile explodes when it takes damage.
ENT.ExplodeUnderwater = false

ENT.Delay = 1.5

ENT.BounceSounds = {
    "TacRP/weapons/grenade/flashbang_bounce-1.wav",
    "TacRP/weapons/grenade/flashbang_bounce-2.wav",
    "TacRP/weapons/grenade/flashbang_bounce-3.wav",
}

ENT.ExplodeSounds = {
    "TacRP/weapons/grenade/flashbang_explode-1.wav",
}

function ENT:Detonate()
    util.BlastDamage(self, self:GetOwner(), self:GetPos(), 512, 10)

    local fx = EffectData()
    fx:SetOrigin(self:GetPos())

    if self:WaterLevel() > 0 then
        util.Effect("WaterSurfaceExplosion", fx)
        self:Remove()
        return
    else
        util.Effect("TacRP_flashexplosion", fx)
    end

    TacRP.Flashbang(self:GetPos(), 1024, 3, 0.25, 0.5)

    self:EmitSound(table.Random(self.ExplodeSounds), 125)

    self:Remove()
end