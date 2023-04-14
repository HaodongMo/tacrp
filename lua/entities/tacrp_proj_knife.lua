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

ENT.SmokeTrail = false
ENT.BounceSounds = {
    "TacRP/weapons/grenade/flashbang_bounce-1.wav",
    "TacRP/weapons/grenade/flashbang_bounce-2.wav",
    "TacRP/weapons/grenade/flashbang_bounce-3.wav",
}

ENT.Damage = 35

function ENT:Impact(data, collider)
    if self.Impacted then return end
    self.Impacted = true

    if IsValid(data.HitEntity) then
        local d = data.OurOldVelocity:GetNormalized()

        local attacker = self.Attacker or self:GetOwner() or self
        local dmg = DamageInfo()
        dmg:SetAttacker(attacker)
        dmg:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
        dmg:SetDamage(self.Damage)
        dmg:SetDamageType(DMG_SLASH)
        dmg:SetDamageForce(d * 5000)
        dmg:SetDamagePosition(data.HitPos)

        if (data.HitEntity:IsPlayer() or data.HitEntity:IsNPC() or data.HitEntity:IsNextBot()) then
            if !data.HitEntity:IsOnGround() then
                dmg:ScaleDamage(2)
                data.HitEntity:EmitSound("weapons/crossbow/bolt_skewer1.wav", 80, 110)
            end

            -- Check if the knife is a headshot
            -- Either the head is the closest bodygroup, or the direction is quite on point
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
                end
                if dist < bdist then
                    bdist = dist
                    bhg = data.HitEntity:GetHitBoxHitGroup(i, hset)
                end
            end

            if bhg == HITGROUP_HEAD or (hdot >= 0.92 and hdist < 2304) then
                dmg:ScaleDamage(2)
                data.HitEntity:EmitSound("player/headshot" .. math.random(1, 2) .. ".wav", 80, 105)
            end
        end

        data.HitEntity:TakeDamageInfo(dmg)

        self:EmitSound("tacrp/weapons/knife/flesh_hit-" .. math.random(1, 5) .. ".wav", 70, 110, 1)
    else
        local ang = data.OurOldVelocity:Angle()
        local fx = EffectData()
        fx:SetOrigin(data.HitPos)
        fx:SetNormal(-ang:Forward())
        fx:SetAngles(-ang)
        util.Effect("ManhackSparks", fx)
        self:EmitSound("tacrp/weapons/knife/scrape_metal-" .. math.random(2, 3) .. ".wav", 70, 110, 0.75)

    end

    self:Remove()
    return true
end