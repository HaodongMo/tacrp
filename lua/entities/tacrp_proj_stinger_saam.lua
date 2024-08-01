AddCSLuaFile()

ENT.Base                     = "tacrp_proj_stinger"
ENT.PrintName                = "FIM-92 Missile (SAAM)"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/rocket_deployed.mdl"

ENT.IsRocket = true // projectile has a booster and will not drop.

ENT.InstantFuse = false // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = true // projectile explodes on impact.

ENT.ExplodeOnDamage = true
ENT.ExplodeUnderwater = true

ENT.SafetyFuse = 0.1
ENT.ImpactDamage = 150

ENT.SteerSpeed = 60
ENT.SeekerAngle = 55

ENT.LeadTarget = true
ENT.SuperSteerTime = 1
ENT.SuperSteerSpeed = 150

ENT.MaxSpeed = 4500
ENT.Acceleration = 2000

ENT.SteerDelay = 0.5
ENT.FlareRedirectChance = 0.05

ENT.AudioLoop = "TacRP/weapons/rpg7/rocket_flight-1.wav"

ENT.SmokeTrail = true

ENT.FlareColor = Color(255, 255, 255)

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
    dmg:SetDamageForce(self:GetVelocity())
    dmg:SetDamagePosition(src)
    dmg:SetDamage(900 * mult)
    util.BlastDamageInfo(dmg, self:GetPos(), 328)

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

function ENT:OnThink()
    if IsValid(self:GetOwner()) and IsValid(self:GetOwner():GetActiveWeapon())
            and self:GetOwner():GetActiveWeapon().ArcticTacRP then
        self.LockOnEntity = self:GetOwner():GetActiveWeapon():GetLockOnEntity()
    else
        self:SwitchTarget(nil)
    end
end