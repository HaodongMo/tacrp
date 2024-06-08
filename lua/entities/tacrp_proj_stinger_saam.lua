AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "FIM-92 Missile (SAAM)"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/rocket_deployed.mdl"

ENT.IsRocket = true // projectile has a booster and will not drop.

ENT.InstantFuse = false // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = true // projectile explodes on impact.

ENT.ExplodeOnDamage = true
ENT.ExplodeUnderwater = true

ENT.Delay = 0
ENT.SafetyFuse = 0.15

ENT.LockOnEntity = NULL
ENT.SteerSpeed = 2000
ENT.SeekerAngle = math.cos(60)
ENT.LeadTarget = false
ENT.SuperSteerTime = 1.5
ENT.SuperSteerSpeed = 1200
ENT.BoostSpeed = 4500
ENT.SoftLaunchTime = 0.5

ENT.AudioLoop = "TacRP/weapons/rpg7/rocket_flight-1.wav"

ENT.SmokeTrail = true

ENT.FlareColor = Color(255, 255, 255)

DEFINE_BASECLASS(ENT.Base)

function ENT:Think()
    if IsValid(self.LockOnEntity) and self.SoftLaunchTime + self.SpawnTime <= CurTime() then
        local dist = self.LockOnEntity:WorldSpaceCenter():DistToSqr(self:GetPos())

        if dist < math.pow(512, 2) then
            self:PreDetonate()
        end
    end

    BaseClass.Think(self)
end

function ENT:Impact(data, collider)
    if self.SpawnTime + self.SafetyFuse > CurTime() and !self.NPCDamage then
        local attacker = self.Attacker or self:GetOwner()
        local ang = data.OurOldVelocity:Angle()
        local fx = EffectData()
        fx:SetOrigin(data.HitPos)
        fx:SetNormal(-ang:Forward())
        fx:SetAngles(-ang)
        util.Effect("ManhackSparks", fx)

        if IsValid(data.HitEntity) then
            local dmginfo = DamageInfo()
            dmginfo:SetAttacker(attacker)
            dmginfo:SetInflictor(self)
            dmginfo:SetDamageType(DMG_CRUSH + DMG_CLUB)
            dmginfo:SetDamage(100 * (self.NPCDamage and 0.5 or 1))
            dmginfo:SetDamageForce(data.OurOldVelocity * 25)
            dmginfo:SetDamagePosition(data.HitPos)
            data.HitEntity:TakeDamageInfo(dmginfo)
        end

        self:EmitSound("weapons/rpg/shotdown.wav", 80)

        for i = 1, 4 do
            local prop = ents.Create("prop_physics")
            prop:SetPos(self:GetPos())
            prop:SetAngles(self:GetAngles())
            prop:SetModel("models/weapons/tacint/rpg7_shrapnel_p" .. i .. ".mdl")
            prop:Spawn()
            prop:GetPhysicsObject():SetVelocityInstantaneous(data.OurNewVelocity * 0.5 + VectorRand() * 75)
            prop:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

            SafeRemoveEntityDelayed(prop, 3)
        end

        self:Remove()
        return true
    end
end

function ENT:Detonate()
    local attacker = self.Attacker or self:GetOwner()
    local dir = self:GetForward()
    local src = self:GetPos() - dir * 64

    local mult = TacRP.ConVars["mult_damage_explosive"]:GetFloat()
    if self.NPCDamage then
        util.BlastDamage(self, attacker, self:GetPos(), 250, 50 * mult)
    else
        util.BlastDamage(self, attacker, self:GetPos(), 250, 100 * mult)

        local dmg = DamageInfo()
        dmg:SetAttacker(attacker)
        dmg:SetDamageType(DMG_BULLET + DMG_BLAST)
        dmg:SetInflictor(self)
        dmg:SetDamageForce(self:GetVelocity() * 100)
        dmg:SetDamagePosition(src)
        for _, ent in pairs(ents.FindInCone(src, dir, 1024, math.cos(45))) do
            local tr = util.QuickTrace(src, ent:GetPos() - src, {self, ent})
            if tr.Fraction == 1 then
                dmg:SetDamage(1400 * math.Rand(0.75, 1) * Lerp((ent:GetPos():DistToSqr(src) / 4194304) ^ 0.5, 1, 0.25) * (self.NPCDamage and 0.5 or 1) * mult)
                if !ent:IsOnGround() then dmg:ScaleDamage(1.5) end
                ent:TakeDamageInfo(dmg)
            end
        end
    end

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
    self.LockOnEntity = nil

    if !IsValid(self:GetOwner()) then return end
    local wpn = self:GetOwner():GetActiveWeapon()
    if !IsValid(wpn) then return end
    if !wpn.ArcticTacRP then return end

    self.LockOnEntity = wpn:GetLockOnEntity()
end