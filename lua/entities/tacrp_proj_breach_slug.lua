AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "Breaching Slug"
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
        self:GetPhysicsObject():SetDragCoefficient(5)
    end
end

function ENT:Impact(data, collider)
    if self.Impacted then return end
    self.Impacted = true

    local tgt = data.HitEntity
    local attacker = self.Attacker or self:GetOwner() or self
    local d = data.OurOldVelocity:GetNormalized()
    if IsValid(tgt) and string.find(tgt:GetClass(), "door") then
        -- if slug spent too much time in the air, it can only open doors, not breach them
        local vel = d * math.max(0, (self.SpawnTime + 0.25 - CurTime()) / 0.25) ^ 0.75 * 3000
        for _, otherDoor in pairs(ents.FindInSphere(tgt:GetPos(), 72)) do
            if tgt != otherDoor and otherDoor:GetClass() == tgt:GetClass() then
                TacRP.DoorBust(otherDoor, vel, attacker)
                break
            end
        end
        TacRP.DoorBust(tgt, vel, attacker)
    elseif IsValid(tgt) and tgt:GetClass() == "func_button" then
        -- press buttons remotely :3
        tgt:Use(attacker, self)
    end

    local dmg = DamageInfo()
    dmg:SetAttacker(attacker)
    dmg:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
    dmg:SetDamage(50)
    dmg:SetDamageType(DMG_CLUB)
    dmg:SetDamagePosition(data.HitPos)
    dmg:SetDamageForce(d * 30000)

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

hook.Add("PostEntityTakeDamage", "tacrp_proj_breach_slug", function(ent, dmg, took)
    if took and IsValid(dmg:GetInflictor()) and ent:IsPlayer()
            and dmg:GetInflictor():GetClass() == "tacrp_proj_breach_slug"
            and (!IsValid(ent:GetActiveWeapon()) or !ent:GetActiveWeapon().ArcticTacRP or !ent:GetActiveWeapon():GetValue("StunResist")) then
        ent:SetNWFloat("TacRPLastBashed", CurTime() + 3)
    end
end)