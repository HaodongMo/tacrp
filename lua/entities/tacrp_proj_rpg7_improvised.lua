AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "RPG-7 Improvised Rocket"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/rocket_deployed.mdl"

ENT.IsRocket = true // projectile has a booster and will not drop.

ENT.InstantFuse = false // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = true // projectile explodes on impact.

ENT.ExplodeOnDamage = true
ENT.ExplodeUnderwater = true

ENT.Delay = 0
ENT.SafetyFuse = 0

ENT.AudioLoop = "TacRP/weapons/rpg7/rocket_flight-1.wav"

ENT.SmokeTrail = true

ENT.FlareColor = Color(255, 255, 75)

DEFINE_BASECLASS(ENT.Base)

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "NoBooster")
end

function ENT:Initialize()
    BaseClass.Initialize(self)

    if SERVER and math.random() <= 0.1 then
        self:GetPhysicsObject():EnableGravity(true)
        self:EmitSound("weapons/rpg/shotdown.wav", 80, 95)

        self:SetNoBooster(math.random() <= 0.1)

        timer.Simple(0, function()
            if !IsValid(self) then return end
            self:GetPhysicsObject():SetVelocityInstantaneous(self:GetForward() * math.Rand(50, 200) + self:GetUp() * math.Rand(50, 150))
            self:GetPhysicsObject():AddAngleVelocity(VectorRand() * 360)
        end)
    end
end

function ENT:Impact(data, collider)
    if self.Impacted then return end
    self.Impacted = true

    local attacker = self.Attacker or self:GetOwner() or self
    if IsValid(data.HitEntity) then
        local dmginfo = DamageInfo()
        dmginfo:SetAttacker(attacker)
        dmginfo:SetInflictor(self)
        dmginfo:SetDamageType(DMG_CRUSH)
        dmginfo:SetDamage(250 * (self.NPCDamage and 0.5 or 1))
        dmginfo:SetDamageForce(data.OurOldVelocity * 25)
        dmginfo:SetDamagePosition(data.HitPos)
        data.HitEntity:TakeDamageInfo(dmginfo)
    end
end


function ENT:Detonate()
    local attacker = self.Attacker or self:GetOwner()

    if math.random() <= 0.05 then
        self:EmitSound("physics/metal/metal_barrel_impact_hard3.wav", 125, 115)
        local fx = EffectData()
        fx:SetOrigin(self:GetPos(0))

        fx:SetMagnitude(4)
        fx:SetScale(4)
        fx:SetRadius(4)
        fx:SetNormal(self:GetVelocity():GetNormalized())
        util.Effect("Sparks", fx)

        for i = 1, 4 do
            local prop = ents.Create("prop_physics")
            prop:SetPos(self:GetPos())
            prop:SetAngles(self:GetAngles())
            prop:SetModel("models/weapons/tacint/rpg7_shrapnel_p" .. i .. ".mdl")
            prop:Spawn()
            prop:GetPhysicsObject():SetVelocityInstantaneous(self:GetVelocity() * 0.5 + VectorRand() * 75)
            prop:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

            SafeRemoveEntityDelayed(prop, 3)
        end

        self:Remove()
        return
    end

    if self.NPCDamage then
        util.BlastDamage(self, attacker, self:GetPos(), 350, 100)
    else
        util.BlastDamage(self, attacker, self:GetPos(), 128, math.Rand(300, 700))
        util.BlastDamage(self, attacker, self:GetPos(), 400, math.Rand(90, 120))
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

function ENT:PhysicsUpdate(phys)
    if self:GetNoBooster() then return end

    if phys:IsGravityEnabled() then
        phys:AddVelocity(self:GetForward() * math.Rand(0, 25))
        phys:AddAngleVelocity(VectorRand() * 10)

    else
        phys:AddVelocity(VectorRand() * 75)
    end

end

local smokeimages = {"particle/smokesprites_0001", "particle/smokesprites_0002", "particle/smokesprites_0003", "particle/smokesprites_0004", "particle/smokesprites_0005", "particle/smokesprites_0006", "particle/smokesprites_0007", "particle/smokesprites_0008", "particle/smokesprites_0009", "particle/smokesprites_0010", "particle/smokesprites_0011", "particle/smokesprites_0012", "particle/smokesprites_0013", "particle/smokesprites_0014", "particle/smokesprites_0015", "particle/smokesprites_0016"}

local function GetSmokeImage()
    return smokeimages[math.random(#smokeimages)]
end

function ENT:Think()
    if !IsValid(self) or self:GetNoDraw() then return end

    if !self.SpawnTime then
        self.SpawnTime = CurTime()
    end

    if !self.Armed and isnumber(self.TimeFuse) and self.SpawnTime + self.TimeFuse < CurTime() then
        self.ArmTime = CurTime()
        self.Armed = true
    end

    if self.Armed and self.ArmTime + self.Delay < CurTime() then
        self:PreDetonate()
    end

    if self.ExplodeUnderwater and self:WaterLevel() > 0 then
        self:PreDetonate()
    end

    if CLIENT and self.SmokeTrail and !self:GetNoBooster() then
        local emitter = ParticleEmitter(self:GetPos())

        local smoke = emitter:Add(GetSmokeImage(), self:GetPos())

        smoke:SetStartAlpha(50)
        smoke:SetEndAlpha(0)

        smoke:SetStartSize(10)
        smoke:SetEndSize(math.Rand(50, 75))

        smoke:SetRoll(math.Rand(-180, 180))
        smoke:SetRollDelta(math.Rand(-1, 1))

        smoke:SetPos(self:GetPos())
        smoke:SetVelocity(-self:GetAngles():Forward() * 400 + (VectorRand() * 10))

        smoke:SetColor(200, 200, 200)
        smoke:SetLighting(true)

        smoke:SetDieTime(math.Rand(0.75, 1.25))

        smoke:SetGravity(Vector(0, 0, 0))

        emitter:Finish()
    end

    self:OnThink()
end

local mat = Material("effects/ar2_altfire1b")

function ENT:Draw()
    self:DrawModel()

    if self.FlareColor and !self:GetNoBooster() then
        render.SetMaterial(mat)
        render.DrawSprite(self:GetPos() + (self:GetAngles():Forward() * -16), math.Rand(100, 150), math.Rand(100, 150), self.FlareColor)
    end
end