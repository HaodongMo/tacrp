AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "Thrown Knife"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/w_knife.mdl"

ENT.IsRocket = false

ENT.InstantFuse = false
ENT.RemoteFuse = false
ENT.ImpactFuse = true

ENT.ExplodeOnDamage = false
ENT.ExplodeUnderwater = true

ENT.Delay = 0
ENT.ImpactDamage = 0

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

ENT.Damage = 35

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

    local attacker = self.Attacker or self:GetOwner() or self
    if IsValid(data.HitEntity) then
        local d = data.OurOldVelocity:GetNormalized()

        local dmg = DamageInfo()
        dmg:SetAttacker(attacker)
        dmg:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
        dmg:SetDamage(self.Damage)
        dmg:SetDamageType(DMG_SLASH)
        dmg:SetDamageForce(d * 10000)
        dmg:SetDamagePosition(data.HitPos)

        local tgtpos = data.HitPos
        if (data.HitEntity:IsPlayer() or data.HitEntity:IsNPC() or data.HitEntity:IsNextBot()) then
            if (data.HitEntity:GetNWFloat("TacRPLastBashed", 0) + 3 >= CurTime()
                    or (data.HitEntity:GetNWFloat("TacRPStunStart", 0) + data.HitEntity:GetNWFloat("TacRPStunDur", 0) >= CurTime())) then
                dmg:ScaleDamage(1.5)
                data.HitEntity:EmitSound("weapons/crossbow/bolt_skewer1.wav", 80, 110)
            end

            -- Check if the knife is a headshot
            -- Either the head is the closest bodygroup, or the direction is quite on point
            local headpos = nil
            local pos = data.HitPos + d * 8
            local hset = data.HitEntity:GetHitboxSet()
            local hdot, bhg, bdist, hdist = 0, 0, math.huge, math.huge
            for i = 0, data.HitEntity:GetHitBoxCount(hset) or 0 do

                local bone = data.HitEntity:GetHitBoxBone(i, hset)
                local mtx = bone and data.HitEntity:GetBoneMatrix(bone)
                if !mtx then continue end
                local hpos = mtx:GetTranslation()
                local dot = (hpos - data.HitPos):GetNormalized():Dot(d)
                local dist = (hpos - pos):LengthSqr()

                if data.HitEntity:GetHitBoxHitGroup(i, hset) == HITGROUP_HEAD then
                    hdot = dot
                    hdist = dist
                    headpos = hpos
                end
                if dist < bdist then
                    bdist = dist
                    bhg = data.HitEntity:GetHitBoxHitGroup(i, hset)
                    tgtpos = hpos
                end
            end

            if bhg == HITGROUP_HEAD or (hdot >= 0.85 and hdist < 2500) then
                dmg:ScaleDamage(2)
                data.HitEntity:EmitSound("player/headshot" .. math.random(1, 2) .. ".wav", 80, 105)
                tgtpos = headpos
            end

            self:EmitSound(istable(self.Sound_MeleeHitBody) and self.Sound_MeleeHitBody[math.random(1, #self.Sound_MeleeHitBody)] or self.Sound_MeleeHitBody, 80, 110, 1)
            -- self:EmitSound("tacrp/weapons/knife/flesh_hit-" .. math.random(1, 5) .. ".wav", 80, 110, 1)

            -- local ang = data.OurOldVelocity:Angle()
            -- local fx = EffectData()
            -- fx:SetStart(data.HitPos - d * 4)
            -- fx:SetOrigin(data.HitPos)
            -- fx:SetNormal(d)
            -- fx:SetAngles(-ang)
            -- fx:SetEntity(data.HitEntity)
            -- fx:SetDamageType(DMG_SLASH)
            -- fx:SetSurfaceProp(data.TheirSurfaceProps)
            -- util.Effect("Impact", fx)

        else
            dmg:SetDamageForce(d * 30000)
            local ang = data.OurOldVelocity:Angle()
            local fx = EffectData()
            fx:SetOrigin(data.HitPos)
            fx:SetNormal(-ang:Forward())
            fx:SetAngles(-ang)
            util.Effect("ManhackSparks", fx)
            self:EmitSound(istable(self.Sound_MeleeHit) and self.Sound_MeleeHit[math.random(1, #self.Sound_MeleeHit)] or self.Sound_MeleeHit, 80, 110, 1)
            -- self:EmitSound("tacrp/weapons/knife/scrape_metal-" .. math.random(2, 3) .. ".wav", 80, 100, 0.75)
        end

        -- data.HitEntity:TakeDamageInfo(dmg)

        local atktr = util.TraceLine({
            start = self:GetPos(),
            endpos = tgtpos,
            filter = self
        })

        TacRP.CancelBodyDamage(data.HitEntity, dmg, atktr.HitGroup)
        data.HitEntity:DispatchTraceAttack(dmg, atktr)
    else
        local ang = data.OurOldVelocity:Angle()
        local fx = EffectData()
        fx:SetOrigin(data.HitPos)
        fx:SetNormal(-ang:Forward())
        fx:SetAngles(-ang)
        util.Effect("ManhackSparks", fx)
        self:EmitSound(istable(self.Sound_MeleeHit) and self.Sound_MeleeHit[math.random(1, #self.Sound_MeleeHit)] or self.Sound_MeleeHit, 80, 110, 1)
        -- self:EmitSound("tacrp/weapons/knife/scrape_metal-" .. math.random(2, 3) .. ".wav", 80, 110, 0.75)

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
                dmginfo:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
            end
        })
    end

    self:Remove()
    return true
end