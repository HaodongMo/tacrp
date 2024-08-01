AddCSLuaFile()

ENT.Base                     = "tacrp_proj_stinger"
ENT.PrintName                = "FIM-92 Missile (APERS)"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/rocket_deployed.mdl"

ENT.IsRocket = true // projectile has a booster and will not drop.

ENT.InstantFuse = false // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = true // projectile explodes on impact.
ENT.TimeFuse = false

ENT.ExplodeOnDamage = true
ENT.ExplodeUnderwater = true

ENT.SafetyFuse = 0.1
ENT.ImpactDamage = 150

ENT.SteerSpeed = 30
ENT.SeekerAngle = 180
ENT.SeekerExplodeRange = 728
ENT.SeekerExplodeSnapPosition = false
ENT.SeekerExplodeAngle = 20

ENT.LeadTarget = true
ENT.SuperSteerTime = 1.5
ENT.SuperSteerSpeed = 400

ENT.MaxSpeed = 2000
ENT.Acceleration = 5000

ENT.SteerDelay = 0.5
ENT.FlareRedirectChance = 0.1

ENT.AudioLoop = "TacRP/weapons/rpg7/rocket_flight-1.wav"

ENT.SmokeTrail = true

ENT.FlareColor = Color(255, 255, 255)

function ENT:OnInitialize()
    if SERVER and IsValid(self.LockOnEntity) then
        local dist = self.LockOnEntity:WorldSpaceCenter():Distance(self:GetPos())
        self.SteerDelay = math.Clamp(dist / 2000, 0.75, 3)
        self.SuperSteerTime = self.SteerDelay + 0.5
    end
end

function ENT:Detonate()
    local dir = self:GetForward()
    local attacker = self.Attacker or self:GetOwner() or self
    local src = self:GetPos() - dir * 64
    local fx = EffectData()
    fx:SetOrigin(src)

    if self:WaterLevel() > 0 then
        util.Effect("WaterSurfaceExplosion", fx)
    else
        fx:SetMagnitude(8)
        fx:SetScale(2)
        fx:SetRadius(8)
        fx:SetNormal(dir)
        util.Effect("Sparks", fx)

        local tr = util.TraceHull({
            start = src,
            endpos = src + dir * 2048,
            filter = self,
            mins = Vector(-16, -16, -8),
            maxs = Vector(16, 16, 8)
        })
        fx:SetMagnitude(4)
        fx:SetScale(1)
        fx:SetRadius(2)
        fx:SetNormal(dir)
        for i = 1, math.floor(tr.Fraction * 6) do
            fx:SetOrigin(tr.StartPos + tr.Normal * (i / 6) * 2048)
            util.Effect("Sparks", fx)
        end
    end

    local mult = TacRP.ConVars["mult_damage_explosive"]:GetFloat()

    self:FireBullets({
        Attacker = attacker,
        Damage = 5,
        Force = 1,
        Distance = 1024,
        HullSize = 16,
        Num = 48,
        Tracer = 1,
        Src = src,
        Dir = dir,
        Spread = Vector(0.5, 0.5, 0),
        IgnoreEntity = self,
    })
    local dmg = DamageInfo()
    dmg:SetAttacker(attacker)
    dmg:SetDamageType(DMG_BUCKSHOT + DMG_BLAST)
    dmg:SetInflictor(self)
    dmg:SetDamageForce(self:GetVelocity() * 100)
    dmg:SetDamagePosition(src)
    for _, ent in pairs(ents.FindInCone(src, dir, 1024, 0.707)) do
        local tr = util.QuickTrace(src, ent:GetPos() - src, {self, ent})
        if tr.Fraction == 1 then
            dmg:SetDamage(100 * math.Rand(0.75, 1) * Lerp((ent:GetPos():DistToSqr(src) / 1048576) ^ 0.5, 1, 0.25) * (self.NPCDamage and 0.5 or 1) * mult)
            if !ent:IsOnGround() then dmg:ScaleDamage(1.5) end
            ent:TakeDamageInfo(dmg)
        end
    end

    util.BlastDamage(self, attacker, src, 256, 50 * mult)

    self:EmitSound("TacRP/weapons/rpg7/explode.wav", 125, 100)
    self:EmitSound("physics/metal/metal_box_break1.wav", 100, 200)

    self:Remove()
end