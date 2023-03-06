AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "RPG-7 Ratshot"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/rocket_deployed.mdl"

ENT.IsRocket = true // projectile has a booster and will not drop.

ENT.InstantFuse = true // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = true // projectile explodes on impact.
ENT.TimeFuse = false

ENT.ExplodeOnDamage = false // projectile explodes when it takes damage.
ENT.ExplodeUnderwater = true

ENT.Delay = 0.15
ENT.SafetyFuse = 0

ENT.AudioLoop = "TacRP/weapons/rpg7/rocket_flight-1.wav"

ENT.SmokeTrail = true

ENT.FlareColor = Color(75, 175, 255)


DEFINE_BASECLASS(ENT.Base)

function ENT:PhysicsCollide(data, collider)
    if self:Impact(data, collider) then
        return
    end

    BaseClass.PhysicsCollide(self, data, collider)
end

function ENT:Think()
    --[[]
    if self.SpawnTime + self.SafetyFuse < CurTime() and (self.NextTraceTime or 0) < CurTime() then
        self.NextTraceTime = CurTime() + 0.1

        local dir = self:GetVelocity():GetNormalized()
        local deg = math.Clamp(1.5 - dir:Cross(Vector(0, 0, -1)):Length(), 0.5, 1)

        local tr = util.TraceHull({
            start = self:GetPos(),
            endpos = self:GetPos() + dir * (1024 * deg),
            filter = self,
            mins = Vector(-16, -16, -8),
            maxs = Vector(16, 16, 8)
        })
        if tr.Hit then
            self:PreDetonate()
        end
    end
    ]]

    BaseClass.Think(self)
end

function ENT:Impact(data, collider)
    if !self.NPCDamage then
        local ang = data.OurOldVelocity:Angle()
        local fx = EffectData()
        fx:SetOrigin(data.HitPos)
        fx:SetNormal(-ang:Forward())
        fx:SetAngles(-ang)
        util.Effect("ManhackSparks", fx)

        if IsValid(data.HitEntity) then
            local dmginfo = DamageInfo()
            dmginfo:SetAttacker(self:GetOwner())
            dmginfo:SetInflictor(self)
            dmginfo:SetDamageType(DMG_CLUB)
            dmginfo:SetDamage(500 * (self.NPCDamage and 0.5 or 1))
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
    local dir = self:GetVelocity():GetNormalized()
    local attacker = self:GetOwner() or self
    local fx = EffectData()
    fx:SetOrigin(self:GetPos())

    if self:WaterLevel() > 0 then
        util.Effect("WaterSurfaceExplosion", fx)
    else
        fx:SetMagnitude(8)
        fx:SetScale(2)
        fx:SetRadius(8)
        fx:SetNormal(dir)
        util.Effect("Sparks", fx)

        local tr = util.TraceHull({
            start = self:GetPos(),
            endpos = self:GetPos() + dir * 2048,
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

    self:FireBullets({
        Attacker = attacker,
        Damage = 5,
        Force = 1,
        Distance = 2048,
        HullSize = 16,
        Num = 48,
        Tracer = 1,
        Src = self:GetPos(),
        Dir = dir,
        Spread = Vector(1, 1, 0),
        IgnoreEntity = self,
    })
    local dmg = DamageInfo()
    dmg:SetAttacker(attacker)
    dmg:SetDamageType(DMG_BULLET + DMG_BLAST)
    dmg:SetInflictor(self)
    dmg:SetDamageForce(self:GetVelocity() * 100)
    for _, ent in pairs(ents.FindInCone(self:GetPos(), dir, 2048, 0.707)) do
        local tr = util.QuickTrace(self:GetPos(), ent:GetPos() - self:GetPos(), {self, ent})
        if tr.Fraction == 1 then
            dmg:SetDamagePosition(self:GetPos())
            dmg:SetDamage(125 * math.Rand(0.8, 1) * Lerp(tr.Fraction ^ 1.5, 0.25, 1))
            ent:TakeDamageInfo(dmg)
        end
    end

    util.BlastDamage(self, attacker, self:GetPos(), 256, 100)

    self:EmitSound("TacRP/weapons/rpg7/explode.wav", 125, 100)
    self:EmitSound("physics/metal/metal_box_break1.wav", 100, 200)

    self:Remove()
end