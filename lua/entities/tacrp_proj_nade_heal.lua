AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "Medi-Gas Canister"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/smoke.mdl"

ENT.Material = "models/tacint/weapons/w_models/smoke/heal-1"

ENT.IsRocket = false // projectile has a booster and will not drop.

ENT.InstantFuse = true // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = false // projectile explodes on impact.

ENT.ExplodeOnDamage = false // projectile explodes when it takes damage.
ENT.ExplodeUnderwater = false

ENT.ImpactDamage = 1

ENT.Delay = 5

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
    local attacker = self.Attacker or self:GetOwner() or self

    // util.BlastDamage(self, attacker, self:GetPos(), 300, 10)

    self:EmitSound(table.Random(self.ExplodeSounds), 75)

    local cloud = ents.Create( "TacRP_heal_cloud" )

    if !IsValid(cloud) then return end

    cloud:SetPos(self:GetPos())
    cloud:SetOwner(attacker)
    cloud:Spawn()

    self:Remove()
end

ENT.SmokeTrail = true
local smokeimages = {"particle/smokesprites_0001", "particle/smokesprites_0002", "particle/smokesprites_0003", "particle/smokesprites_0004", "particle/smokesprites_0005", "particle/smokesprites_0006", "particle/smokesprites_0007", "particle/smokesprites_0008", "particle/smokesprites_0009", "particle/smokesprites_0010", "particle/smokesprites_0011", "particle/smokesprites_0012", "particle/smokesprites_0013", "particle/smokesprites_0014", "particle/smokesprites_0015", "particle/smokesprites_0016"}
local function GetSmokeImage()
    return smokeimages[math.random(#smokeimages)]
end
ENT.NextSmokeTime = 0
function ENT:DoSmokeTrail()
    if CLIENT and self.SmokeTrail and self.NextSmokeTime < CurTime() then
        local pos = self:GetPos() + self:GetUp() * 4
        local emitter = ParticleEmitter(pos)
        local smoke = emitter:Add(GetSmokeImage(), pos)

        smoke:SetStartAlpha(75)
        smoke:SetEndAlpha(0)

        smoke:SetStartSize(10)
        smoke:SetEndSize(math.Rand(16, 32))

        smoke:SetRoll(math.Rand(-180, 180))
        smoke:SetRollDelta(math.Rand(-1, 1))

        smoke:SetVelocity(VectorRand() * 8 + self:GetUp() * 42)

        smoke:SetColor(125, 25, 125)
        smoke:SetLighting(false)

        smoke:SetDieTime(math.Rand(1, 1.5))

        smoke:SetGravity(Vector(0, 0, 15))

        emitter:Finish()

        self.NextSmokeTime = CurTime() + 0.025
    end
end