AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "RPG7 Harpoon"
ENT.Spawnable                = false

ENT.Model                    =  "models/props_junk/harpoon002a.mdl"

ENT.IsRocket = false // projectile has a booster and will not drop.

ENT.InstantFuse = false // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = true // projectile explodes on impact.

ENT.SmokeTrail = false

local path = "tacrp/weapons/knife/"
ENT.Sound_MeleeHit = {
    path .. "/scrape_metal-1.wav",
    path .. "/scrape_metal-2.wav",
    path .. "/scrape_metal-3.wav",
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
        self:GetPhysicsObject():SetMass(25)
        self:GetPhysicsObject():SetDragCoefficient(10)
        self:Ignite(30)
    end
end

function ENT:Impact(data, collider)
    local tgt = data.HitEntity
    local attacker = self.Attacker or self:GetOwner() or self
    local d = data.OurOldVelocity:GetNormalized()
    local forward = data.OurOldVelocity:Dot(self:GetAngles():Forward())
    if forward <= 100 then return true end
    if IsValid(tgt) then
        local ang = data.OurOldVelocity:Angle()
        local fx = EffectData()
        fx:SetOrigin(data.HitPos)
        fx:SetNormal(-ang:Forward())
        fx:SetAngles(-ang)
        util.Effect("ManhackSparks", fx)

        if IsValid(data.HitEntity) then
            data.HitEntity:Ignite(math.Rand(5, 10), 128)
            local dmginfo = DamageInfo()
            dmginfo:SetAttacker(attacker)
            dmginfo:SetInflictor(self)
            dmginfo:SetDamageType(DMG_CLUB)
            dmginfo:SetDamage(self.NPCDamage and 25 or math.Clamp(forward / 70, 10, 200))
            dmginfo:SetDamageForce(data.OurOldVelocity)
            dmginfo:SetDamagePosition(data.HitPos)
            data.HitEntity:TakeDamageInfo(dmginfo)
        end
    else
        local ang = data.OurOldVelocity:Angle()
        local fx = EffectData()
        fx:SetOrigin(data.HitPos)
        fx:SetNormal(-ang:Forward())
        fx:SetAngles(-ang)
        util.Effect("ManhackSparks", fx)
        if SERVER then
            self:EmitSound(istable(self.Sound_MeleeHit) and self.Sound_MeleeHit[math.random(1, #self.Sound_MeleeHit)] or self.Sound_MeleeHit, 80, 110, 1)
        end

        -- leave a bullet hole. Also may be able to hit things it can't collide with (like stuck C4)
        self:FireBullets({
            Attacker = attacker,
            Damage = self.Damage,
            Force = 1,
            Distance = 4,
            HullSize = 4,
            Tracer = 0,
            Dir = ang:Forward(),
            Src = data.HitPos - ang:Forward(),
            IgnoreEntity = self,
            Callback = function(atk, tr, dmginfo)
                dmginfo:SetDamageType(DMG_SLASH)
                dmginfo:SetInflictor(attacker)
            end
        })
    end

    if tgt:IsWorld() or (IsValid(tgt) and tgt:GetPhysicsObject():IsValid()) then
        local angles = data.OurOldVelocity:Angle()
        self:GetPhysicsObject():Sleep()

        timer.Simple(0, function()
            if tgt:IsWorld() or (IsValid(tgt) and (!(tgt:IsNPC() or tgt:IsPlayer()) or tgt:Health() > 0)) then
                self:SetSolid(SOLID_NONE)
                self:SetMoveType(MOVETYPE_NONE)

                local f = {self, self:GetOwner()}
                table.Add(f, tgt:GetChildren())
                local tr = util.TraceLine({
                    start = data.HitPos - data.OurOldVelocity,
                    endpos = data.HitPos + data.OurOldVelocity,
                    filter = f,
                    mask = MASK_SOLID,
                    ignoreworld = true,
                })

                local bone = (tr.Entity == tgt) and tr.PhysicsBone == 0
                        and tr.Entity:GetHitBoxBone(tr.HitBox, tr.Entity:GetHitboxSet())
                        or tr.PhysicsBone or -1
                local matrix = tgt:GetBoneMatrix(bone)
                if tr.Entity == tgt and matrix then
                    local bpos = matrix:GetTranslation()
                    local bang = matrix:GetAngles()
                    self:SetPos(data.HitPos)
                    self:FollowBone(tgt, bone)
                    local n_pos, n_ang = WorldToLocal(tr.HitPos + tr.HitNormal * self:GetModelRadius() * 0.5, angles, bpos, bang)
                    self:SetLocalPos(n_pos)
                    self:SetLocalAngles(n_ang)
                    debugoverlay.Cross(pos, 8, 5, Color(255, 0, 255), true)
                else
                    self:SetAngles(angles)
                    self:SetPos(data.HitPos - data.OurOldVelocity:GetNormalized() * self:GetModelRadius() * 0.5)
                    if !tgt:IsWorld() then
                        self:SetParent(tgt)
                    end
                end
            else
                self:GetPhysicsObject():SetVelocity(data.OurOldVelocity * 0.75)
                self:GetPhysicsObject():SetAngleVelocity(data.OurOldAngularVelocity)
                self.Armed = false
            end
        end)
    end
    timer.Simple(5, function()
        if IsValid(self) then
            self:SetRenderMode(RENDERMODE_TRANSALPHA)
            self:SetRenderFX(kRenderFxFadeFast)
        end
    end)
    SafeRemoveEntityDelayed(self, 7)

    return true
end

local g = Vector(0, 0, -9.81)
function ENT:PhysicsUpdate(phys)
    if !self.Armed and phys:IsGravityEnabled() and self:WaterLevel() <= 2 then
        local v = phys:GetVelocity()
        self:SetAngles(v:Angle())
        phys:SetVelocityInstantaneous(v * 0.985 + g)
    end
end

ENT.SmokeTrail = true
local smokeimages = {"particle/smokesprites_0001", "particle/smokesprites_0002", "particle/smokesprites_0003", "particle/smokesprites_0004", "particle/smokesprites_0005", "particle/smokesprites_0006", "particle/smokesprites_0007", "particle/smokesprites_0008", "particle/smokesprites_0009", "particle/smokesprites_0010", "particle/smokesprites_0011", "particle/smokesprites_0012", "particle/smokesprites_0013", "particle/smokesprites_0014", "particle/smokesprites_0015", "particle/smokesprites_0016"}
local function GetSmokeImage()
    return smokeimages[math.random(#smokeimages)]
end
function ENT:DoSmokeTrail()
    if CLIENT and self.SmokeTrail and self:GetVelocity():Length() >= 100 then
        local pos = self:GetPos() + self:GetUp() * 4
        local emitter = ParticleEmitter(pos)
        local smoke = emitter:Add(GetSmokeImage(), pos)

        smoke:SetStartAlpha(100)
        smoke:SetEndAlpha(0)

        smoke:SetStartSize(2)
        smoke:SetEndSize(math.Rand(16, 24))

        smoke:SetRoll(math.Rand(-180, 180))
        smoke:SetRollDelta(math.Rand(-1, 1))

        smoke:SetVelocity(VectorRand() * 8 + self:GetUp() * 16)
        smoke:SetColor(200, 200, 200)
        smoke:SetLighting(true)

        smoke:SetDieTime(math.Rand(0.5, 0.75))

        smoke:SetGravity(Vector(0, 0, 15))

        local fire = emitter:Add("effects/fire_cloud" .. math.random(1, 2), pos)
        fire:SetStartAlpha(150)
        fire:SetEndAlpha(0)
        fire:SetStartSize(math.Rand(2, 4))
        fire:SetEndSize(math.Rand(8, 16))
        fire:SetRoll(math.Rand(-180, 180))
        fire:SetRollDelta(math.Rand(-1, 1))
        fire:SetVelocity(VectorRand() * 16 + self:GetUp() * 16)
        fire:SetLighting(false)
        fire:SetDieTime(math.Rand(0.1, 0.3))
        fire:SetGravity(Vector(0, 0, 50))

        emitter:Finish()
    end
end