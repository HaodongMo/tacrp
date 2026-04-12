AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "40mm Baseball"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint_extras/w_baseball.mdl"
ENT.CollisionSphere = 4

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
        self.StartPos = self:GetPos()
        self.Trail = util.SpriteTrail(self, 0, color_white, true, 4, 0, 0.1, 2, "trails/tube")
    end
end

function ENT:Impact(data, collider)
    if self.Impacted then return end
    self.Impacted = true

    local attacker = self.Attacker or self:GetOwner() or self
    local d = data.OurOldVelocity:GetNormalized()
    local dist = (data.HitPos - self.StartPos):Length()
    self.Damage = Lerp(math.Clamp(dist / 2000, 0, 1), 60, 120)


    local dmg = DamageInfo()
    dmg:SetAttacker(attacker)
    dmg:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
    dmg:SetDamage(self.Damage)
    dmg:SetDamageType(DMG_CLUB)
    dmg:SetDamageForce(d * 10000)
    dmg:SetDamagePosition(data.HitPos)

    data.HitEntity.TacRPBashSlow = true

    if data.HitEntity:IsPlayer() then
        local wep = data.HitEntity:GetActiveWeapon()
        if IsValid(wep) and wep.ArcticTacRP then
            wep:SetBreath(0)
            wep:SetOutOfBreath(true)
        end
    end

    local atktr = util.TraceLine({
        start = self:GetPos(),
        endpos = data.HitPos,
        filter = self
    })

    TacRP.CancelBodyDamage(data.HitEntity, dmg, atktr.HitGroup)
    data.HitEntity:SetPhysicsAttacker(attacker, 3)
    data.HitEntity:DispatchTraceAttack(dmg, atktr)

    if IsValid(self.Trail) then
        self.Trail:Remove()
    end

    if data.HitEntity:IsPlayer() or data.HitEntity:IsNPC() or data.HitEntity:IsNextBot() then
        if dist >= 2000 then
            data.HitEntity:EmitSound("tacrp/sandman/pl_impact_stun_range.wav", 100)
        else
            data.HitEntity:EmitSound("tacrp/sandman/pl_impact_stun.wav", 90)
        end
    else
        data.HitEntity:EmitSound("tacrp/sandman/baseball_hitworld" .. math.random(1, 3) .. ".wav", 90)
    end

    SafeRemoveEntityDelayed(self, 3)
    return true
end