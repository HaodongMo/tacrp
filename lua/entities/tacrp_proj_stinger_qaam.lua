AddCSLuaFile()

ENT.Base                     = "tacrp_proj_stinger"
ENT.PrintName                = "FIM-92 Missile (QAAM)"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/rocket_deployed.mdl"

ENT.IsRocket = true // projectile has a booster and will not drop.

ENT.InstantFuse = false // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = true // projectile explodes on impact.

ENT.ExplodeOnDamage = true
ENT.ExplodeUnderwater = true

ENT.GunshipWorkaround = false

ENT.SafetyFuse = 0.1
ENT.ImpactDamage = 150

ENT.SteerSpeed = 30
ENT.SeekerAngle = 75

ENT.LeadTarget = true
ENT.SuperSteerTime = 3
ENT.SuperSteerSpeed = 120

ENT.MaxSpeed = 8000
ENT.Acceleration = 8000

ENT.SteerDelay = 0.3
ENT.FlareRedirectChance = 0.05

ENT.AudioLoop = "TacRP/weapons/rpg7/rocket_flight-1.wav"

ENT.SmokeTrail = true

ENT.FlareColor = Color(175, 175, 255)