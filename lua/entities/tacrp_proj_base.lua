AddCSLuaFile()

ENT.Type                     = "anim"
ENT.Base                     = "base_entity"
ENT.RenderGroup              = RENDERGROUP_TRANSLUCENT

ENT.PrintName                = "Base Projectile"
ENT.Category                 = ""

ENT.Spawnable                = false
ENT.Model                    = ""

local smokeimages = {"particle/smokesprites_0001", "particle/smokesprites_0002", "particle/smokesprites_0003", "particle/smokesprites_0004", "particle/smokesprites_0005", "particle/smokesprites_0006", "particle/smokesprites_0007", "particle/smokesprites_0008", "particle/smokesprites_0009", "particle/smokesprites_0010", "particle/smokesprites_0011", "particle/smokesprites_0012", "particle/smokesprites_0013", "particle/smokesprites_0014", "particle/smokesprites_0015", "particle/smokesprites_0016"}

local function GetSmokeImage()
    return smokeimages[math.random(#smokeimages)]
end

ENT.Material = false // custom material

ENT.IsRocket = false // projectile has a booster and will not drop.

ENT.Sticky = false // projectile sticks on impact

ENT.InstantFuse = true // projectile is armed immediately after firing.
ENT.TimeFuse = false // projectile will arm after this amount of time
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = false // projectile explodes on impact.

ENT.ExplodeOnImpact = false
ENT.ExplodeOnDamage = false // projectile explodes when it takes damage.
ENT.ExplodeUnderwater = false // projectile explodes when it enters water

ENT.Defusable = false // press E on the projectile to defuse it

ENT.Delay = 5 // after being triggered and this amount of time has passed, the projectile will explode.

ENT.Armed = false

ENT.SmokeTrail = false // leaves trail of smoke

ENT.AudioLoop = nil

ENT.BounceSounds = nil

function ENT:Initialize()
    self:SetModel(self.Model)
    self:SetMaterial(self.Material or "")

    if SERVER then
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
        if self.Defusable then
            self:SetUseType(SIMPLE_USE)
        end
        self:PhysWake()

        local phys = self:GetPhysicsObject()
        if !phys:IsValid() then
            self:Remove()
        else
            phys:SetDragCoefficient(0)
        end

        if self.IsRocket then
            phys:EnableGravity(false)
        end
    end

    self.SpawnTime = CurTime()

    self.NPCDamage = IsValid(self:GetOwner()) and self:GetOwner():IsNPC() and !GetConVar("tacrp_npc_equality"):GetBool()

    if self.AudioLoop then
        self.LoopSound = CreateSound(self, self.AudioLoop)
        self.LoopSound:Play()
    end

    if self.InstantFuse then
        self.ArmTime = CurTime()
        self.Armed = true
    end
end

function ENT:OnRemove()
    if self.LoopSound then
        self.LoopSound:Stop()
    end
end

function ENT:TakeDamage(amt, atk, inf)
    self:SetOwner(atk)

    self:PreDetonate()
end

function ENT:PhysicsCollide(data, collider)
    if self.ImpactFuse and !self.Armed then
        self.ArmTime = CurTime()
        self.Armed = true

        if self:Impact(data, collider) then
            return
        end

        if self.Delay == 0 or self.ExplodeOnImpact then
            self:SetPos(data.HitPos)
            self:PreDetonate()
        end
    end

    if self.Sticky then
        self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        self:SetPos(data.HitPos)

        self:SetAngles((-data.HitNormal):Angle())

        if data.HitEntity:IsWorld() or data.HitEntity:GetSolid() == SOLID_BSP then
            self:SetMoveType(MOVETYPE_NONE)
            self:SetPos(data.HitPos)
        else
            self:SetPos(data.HitPos)
            self:SetParent(data.HitEntity)
        end

        self:EmitSound("TacRP/weapons/plant_bomb.wav")
    end

    if data.DeltaTime < 0.1 then return end
    if !self.BounceSounds then return end

    local s = table.Random(self.BounceSounds)

    self:EmitSound(s)
end

function ENT:OnThink()
end

function ENT:Think()
    if !IsValid(self) then return end

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

    if CLIENT then
        if self.SmokeTrail then
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
    end

    self:OnThink()
end

function ENT:Use(ply)
    if !self.Defusable then return end

    self:EmitSound("TacRP/weapons/rifle_jingle-1.wav")
    self:Remove()
end

function ENT:RemoteDetonate()
    self:EmitSound("TacRP/weapons/c4/relay_switch-1.wav")

    self.ArmTime = CurTime()
    self.Armed = true
end

function ENT:PreDetonate()
    if CLIENT then return end

    if !self.Detonated then
        self.Detonated = true

        if !self:GetOwner():IsValid() then self:Remove() return end

        self:Detonate()
    end
end

function ENT:Detonate()
    // fill this in :)
end

function ENT:Impact()
end

function ENT:DrawTranslucent()
    self:Draw()
end

local mat = Material("effects/ar2_altfire1b")

function ENT:Draw()
    self:DrawModel()

    if self.IsRocket then
        render.SetMaterial(mat)
        render.DrawSprite(self:GetPos() + (self:GetAngles():Forward() * -16), math.Rand(200, 250), math.Rand(200, 250), Color(255, 255, 255))
    end
end