AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "Thermite Grenade"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/smoke.mdl"

ENT.Material = "models/tacint/weapons/w_models/smoke/thermite-1"

ENT.IsRocket = false // projectile has a booster and will not drop.

ENT.InstantFuse = true // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = false // projectile explodes on impact.

ENT.ExplodeOnDamage = false // projectile explodes when it takes damage.
ENT.ExplodeUnderwater = true
ENT.DefuseOnDamage = true

ENT.ImpactDamage = 1

ENT.Delay = 3

ENT.Sticky = true

ENT.ExplodeSounds = {
    "^TacRP/weapons/grenade/frag_explode-1.wav",
    "^TacRP/weapons/grenade/frag_explode-2.wav",
    "^TacRP/weapons/grenade/frag_explode-3.wav",
}

function ENT:Detonate()
    if self:WaterLevel() > 0 then self:Remove() return end
    local attacker = self.Attacker or self:GetOwner() or self

    -- local dmg = 50
    -- if self.ImpactFuse then dmg = dmg * 0.5 end
    -- util.BlastDamage(self, attacker, self:GetPos(), 350, dmg)

    self:EmitSound("ambient/fire/gascan_ignite1.wav", 80, 110)

    local cloud = ents.Create( "TacRP_fire_cloud" )

    if !IsValid(cloud) then return end

    local t = 8
    if self.ImpactFuse then t = t * 0.5 end

    cloud.FireTime = t
    cloud:SetPos(self:GetPos())
    cloud:SetAngles(self:GetAngles())
    cloud:SetOwner(attacker)
    cloud:Spawn()
    if IsValid(self:GetParent()) then
        cloud:SetParent(self:GetParent())
    elseif self:GetMoveType() == MOVETYPE_NONE then
        cloud:SetMoveType(MOVETYPE_NONE)
    end

    self:Remove()
end

ENT.NextDamageTick = 0

ENT.SmokeTrail = true
function ENT:DoSmokeTrail()
    if CLIENT and self.SmokeTrail then
        local pos = self:GetPos() + self:GetUp() * 4
        local emitter = ParticleEmitter(pos)

        local smoke = emitter:Add("particles/smokey", pos)

        smoke:SetStartAlpha(30)
        smoke:SetEndAlpha(0)

        smoke:SetStartSize(2)
        smoke:SetEndSize(math.Rand(16, 24))

        smoke:SetRoll(math.Rand(-180, 180))
        smoke:SetRollDelta(math.Rand(-1, 1))

        smoke:SetVelocity(VectorRand() * 16 + Vector(0, 0, 64))
        smoke:SetColor(200, 200, 200)
        smoke:SetLighting(false)

        smoke:SetDieTime(math.Rand(0.5, 1))
        smoke:SetGravity(Vector(0, 0, -100))
        smoke:SetNextThink( CurTime() + FrameTime() )
        smoke:SetThinkFunction( function(pa)
            if !pa then return end
            local col1 = Color(255, 135, 0)
            local col2 = Color(255, 255, 255)

            local col3 = col1
            local d = pa:GetLifeTime() / pa:GetDieTime()
            col3.r = Lerp(d, col1.r, col2.r)
            col3.g = Lerp(d, col1.g, col2.g)
            col3.b = Lerp(d, col1.b, col2.b)

            pa:SetColor(col3.r, col3.g, col3.b)
            pa:SetNextThink( CurTime() + FrameTime() )
        end )

        emitter:Finish()
    end
end