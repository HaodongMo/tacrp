AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "RPG7 Shovel" -- not actually a harpoon lol
ENT.Spawnable                = false

ENT.Model                    =  "models/props_junk/Shovel01a.mdl"

ENT.ImpactDamage = 0

ENT.ImpactFuse = true

ENT.SmokeTrail = false

local path = "tacrp/weapons/knife/"
ENT.Sound_MeleeHit = {
    "physics/metal/metal_box_impact_hard1.wav",
    "physics/metal/metal_box_impact_hard2.wav",
    "physics/metal/metal_box_impact_hard3.wav",
}
ENT.Sound_MeleeHitBody = {
    path .. "/flesh_hit-1.wav",
    path .. "/flesh_hit-2.wav",
    path .. "/flesh_hit-3.wav",
    path .. "/flesh_hit-4.wav",
    path .. "/flesh_hit-5.wav",
}

function ENT:OnInitialize()
    if SERVER then
        self:GetPhysicsObject():SetMass(50)
        self:GetPhysicsObject():SetDragCoefficient(5)
    end
    self.Attacker = self.Attacker or self:GetOwner()
end

function ENT:Impact(data, collider)
    local tgt = data.HitEntity
    local attacker = self.Attacker or (IsValid(self:GetOwner()) and self:GetOwner()) or self
    local d = data.OurOldVelocity:GetNormalized()
    local ang = data.OurOldVelocity:Angle()

    local speed = data.Speed
    if speed <= 50 then return true end

    local dmg = self.NPCDamage and 75 or math.Clamp(speed / 15, 50, 200)

    if IsValid(tgt) then
        local dmginfo = DamageInfo()
        dmginfo:SetAttacker(attacker)
        dmginfo:SetInflictor(self)
        dmginfo:SetDamageType(DMG_CLUB)
        dmginfo:SetDamage(dmg)
        dmginfo:SetDamageForce(data.OurOldVelocity)
        dmginfo:SetDamagePosition(data.HitPos)
        tgt:TakeDamageInfo(dmginfo)

        local fx = EffectData()
        fx:SetOrigin(data.HitPos)
        fx:SetNormal(-ang:Forward())
        fx:SetAngles(-ang)
        util.Effect("ManhackSparks", fx)
    else
        local ang = data.OurOldVelocity:Angle()

        -- leave a bullet hole. Also may be able to hit things it can't collide with (like stuck C4)
        self:FireBullets({
            Attacker = attacker,
            Damage = dmg,
            Force = 1,
            Distance = 4,
            HullSize = 4,
            Tracer = 0,
            Dir = ang:Forward(),
            Src = data.HitPos - ang:Forward(),
            IgnoreEntity = self,
            Callback = function(atk, tr, dmginfo)
                dmginfo:SetDamageType(DMG_CLUB)
                dmginfo:SetInflictor(attacker)
                if tr.HitSky then
                    SafeRemoveEntity(self)
                else
                    local fx = EffectData()
                    fx:SetOrigin(data.HitPos)
                    fx:SetNormal(-ang:Forward())
                    fx:SetAngles(-ang)
                    util.Effect("ManhackSparks", fx)
                    if SERVER then
                        self:EmitSound(istable(self.Sound_MeleeHit) and self.Sound_MeleeHit[math.random(1, #self.Sound_MeleeHit)] or self.Sound_MeleeHit, 80, 110, 1)
                    end
                end
            end
        })
    end

    self:GetPhysicsObject():SetVelocityInstantaneous(data.OurNewVelocity * 0.5)

    timer.Simple(0, function()
        if IsValid(self) then
            self:SetOwner(NULL) -- lol
            self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
        end
    end)
    timer.Simple(5, function()
        if IsValid(self) then
            self:SetRenderMode(RENDERMODE_TRANSALPHA)
            self:SetRenderFX(kRenderFxFadeFast)
            self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        end
    end)
    SafeRemoveEntityDelayed(self, 7)

    return true
end

local g = Vector(0, 0, -9.81)
function ENT:PhysicsUpdate(phys)
    if !self.Armed and phys:IsGravityEnabled() and self:WaterLevel() <= 2 then
        local v = phys:GetVelocity()
        local a = v:Angle()
        a.p = a.p - 90
        self:SetAngles(a)
        phys:SetVelocityInstantaneous(v * 0.985 + g)
    end
end

ENT.SmokeTrail = false
local smokeimages = {"particle/smokesprites_0001", "particle/smokesprites_0002", "particle/smokesprites_0003", "particle/smokesprites_0004", "particle/smokesprites_0005", "particle/smokesprites_0006", "particle/smokesprites_0007", "particle/smokesprites_0008", "particle/smokesprites_0009", "particle/smokesprites_0010", "particle/smokesprites_0011", "particle/smokesprites_0012", "particle/smokesprites_0013", "particle/smokesprites_0014", "particle/smokesprites_0015", "particle/smokesprites_0016"}
local function GetSmokeImage()
    return smokeimages[math.random(#smokeimages)]
end
function ENT:DoSmokeTrail()
    if CLIENT and self.SmokeTrail and self:GetVelocity():Length() >= 100 then
        local pos = self:GetPos()
        local emitter = ParticleEmitter(pos)
        local smoke = emitter:Add(GetSmokeImage(), pos)

        smoke:SetStartAlpha(25)
        smoke:SetEndAlpha(0)

        smoke:SetStartSize(2)
        smoke:SetEndSize(math.Rand(16, 24))

        smoke:SetRoll(math.Rand(-180, 180))
        smoke:SetRollDelta(math.Rand(-1, 1))

        smoke:SetVelocity(VectorRand() * 8 + self:GetUp() * 16)
        smoke:SetColor(255, 255, 255)
        smoke:SetLighting(true)
        smoke:SetDieTime(math.Rand(0.5, 0.75))
        smoke:SetGravity(Vector(0, 0, 15))
        emitter:Finish()
    end
end