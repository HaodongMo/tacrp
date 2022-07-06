AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "Gas Grenade"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/smoke.mdl"

ENT.Material = "models/tacint/weapons/w_models/smoke/gas-1"

ENT.IsRocket = false // projectile has a booster and will not drop.

ENT.InstantFuse = true // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = false // projectile explodes on impact.

ENT.ExplodeOnDamage = false // projectile explodes when it takes damage.
ENT.ExplodeUnderwater = false

ENT.Delay = 3.5

ENT.BounceSounds = {
    "TacRP/weapons/grenade/smoke_bounce-1.wav",
    "TacRP/weapons/grenade/smoke_bounce-2.wav",
    "TacRP/weapons/grenade/smoke_bounce-3.wav",
    "TacRP/weapons/grenade/smoke_bounce-4.wav",
}

ENT.ExplodeSounds = {
    "TacRP/weapons/grenade/smoke_explode-1.wav",
}

function ENT:Detonate()
    if self:WaterLevel() > 0 then self:Remove() return end

    util.BlastDamage(self, self:GetOwner(), self:GetPos(), 150, 25)

    self:EmitSound(table.Random(self.ExplodeSounds), 75)

    local cloud = ents.Create( "TacRP_gas_cloud" )

    if !IsValid(cloud) then return end

    cloud:SetPos(self:GetPos())
    cloud:SetOwner(self:GetOwner())
    cloud:Spawn()

    self:Remove()
end