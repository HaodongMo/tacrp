AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "40mm Baton"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/flare.mdl"
ENT.CollisionSphere = 1

ENT.IsRocket = false

ENT.InstantFuse = false
ENT.RemoteFuse = false
ENT.ImpactFuse = true

ENT.ExplodeOnDamage = false
ENT.ExplodeUnderwater = true

ENT.Delay = 0
ENT.ImpactDamage = 0

ENT.SmokeTrail = false

DEFINE_BASECLASS(ENT.Base)

function ENT:Initialize()
    BaseClass.Initialize(self)
    if SERVER then
        self:GetPhysicsObject():SetDragCoefficient(0)
    end
end

function ENT:Impact(data, collider)
    if self.Impacted then return end
    self.Impacted = true

    local tgt = data.HitEntity
    local attacker = self.Attacker or self:GetOwner() or self
    local d = data.OurOldVelocity:GetNormalized()

    local dmg = DamageInfo()
    dmg:SetAttacker(attacker)
    dmg:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
    dmg:SetDamage(500)
    dmg:SetDamageType(DMG_CLUB)
    dmg:SetDamagePosition(data.HitPos)
    dmg:SetDamageForce(d * 5000)

    local atktr = util.TraceLine({
        start = self:GetPos(),
        endpos = data.HitPos,
        filter = self
    })

    -- TacRP.CancelBodyDamage(tgt, dmg, atktr.HitGroup)
    tgt:DispatchTraceAttack(dmg, atktr)

    -- leave a bullet hole. Also may be able to hit things it can't collide with (like stuck C4)
    self:FireBullets({
        Attacker = attacker,
        Damage = 0,
        Force = 1,
        Distance = 4,
        HullSize = 4,
        Tracer = 0,
        Dir = d,
        Src = data.HitPos - d,
        IgnoreEntity = self,
        Callback = function(atk, tr, dmginfo)
            dmginfo:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
        end
    })

    self:Remove()
    return true
end