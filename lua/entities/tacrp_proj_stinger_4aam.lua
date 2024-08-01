AddCSLuaFile()

ENT.Base                     = "tacrp_proj_stinger"
ENT.PrintName                = "FIM-92 Missile (4AAM)"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/rocket_deployed.mdl"

ENT.IsRocket = true // projectile has a booster and will not drop.

ENT.InstantFuse = false // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = true // projectile explodes on impact.

ENT.ExplodeOnDamage = false
ENT.ExplodeUnderwater = true

ENT.FlareSizeMin = 150
ENT.FlareSizeMax = 200

ENT.SafetyFuse = 0.1
ENT.ImpactDamage = 150

ENT.SteerSpeed = 200
ENT.SeekerAngle = 90

ENT.LeadTarget = true
ENT.SuperSteerTime = 0.5
ENT.SuperSteerSpeed = -90 // yes this is intentionally negative

ENT.MaxSpeed = 6000
ENT.Acceleration = 2000

ENT.SteerDelay = 0
ENT.FlareRedirectChance = 0.1

ENT.AudioLoop = "TacRP/weapons/rpg7/rocket_flight-1.wav"

ENT.SmokeTrail = true

ENT.FlareColor = Color(255, 230, 200)

DEFINE_BASECLASS(ENT.Base)

function ENT:Detonate()
    local attacker = self.Attacker or self:GetOwner()
    local dir = self:GetForward()
    local src = self:GetPos() - dir * 64

    local mult = TacRP.ConVars["mult_damage_explosive"]:GetFloat()

    local dmg = DamageInfo()
    dmg:SetAttacker(attacker)
    dmg:SetDamageType(DMG_BLAST)
    dmg:SetInflictor(self)
    dmg:SetDamageForce(self:GetVelocity() * 100)
    dmg:SetDamagePosition(src)
    dmg:SetDamage(150 * mult)
    util.BlastDamageInfo(dmg, self:GetPos(), 256)

    local fx = EffectData()
    fx:SetOrigin(self:GetPos())
    util.Effect("HelicopterMegaBomb", fx)

    self:EmitSound("^tacrp/weapons/grenade/40mm_explode-" .. math.random(1, 3) .. ".wav", 115)

    self:Remove()
end