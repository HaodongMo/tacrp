AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "Flash Grenade"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/flashbang.mdl"

ENT.IsRocket = false // projectile has a booster and will not drop.

ENT.InstantFuse = true // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = false // projectile explodes on impact.

ENT.ExplodeOnDamage = false // projectile explodes when it takes damage.
ENT.ExplodeUnderwater = false

ENT.ImpactDamage = 1

ENT.Delay = 1.5

ENT.BounceSounds = {
    "TacRP/weapons/grenade/flashbang_bounce-1.wav",
    "TacRP/weapons/grenade/flashbang_bounce-2.wav",
    "TacRP/weapons/grenade/flashbang_bounce-3.wav",
}

ENT.ExplodeSounds = {
    "TacRP/weapons/grenade/flashbang_explode-1.wav",
}

function ENT:Detonate()
    local attacker = self.Attacker or self:GetOwner() or self

    local dmg = DamageInfo()
    dmg:SetAttacker(attacker)
    dmg:SetInflictor(self)
    dmg:SetDamageType(engine.ActiveGamemode() == "terrortown" and DMG_DIRECT or DMG_SONIC)
    dmg:SetDamagePosition(self:GetPos())
    dmg:SetDamage(3)
    util.BlastDamageInfo(dmg, self:GetPos(), 728)

    local fx = EffectData()
    fx:SetOrigin(self:GetPos())

    if self:WaterLevel() > 0 then
        util.Effect("WaterSurfaceExplosion", fx)
        self:Remove()
        return
    else
        fx:SetRadius(728)
        util.Effect("TacRP_flashexplosion", fx)
    end

    TacRP.Flashbang(self, self:GetPos(), 728, 3, 0.25, 0.5)

    self:EmitSound(table.Random(self.ExplodeSounds), 125)

    self:Remove()
end

ENT.SmokeTrail = true
function ENT:DoSmokeTrail()
    if CLIENT and self.SmokeTrail and (self.Tick or 0) % 5 == 0 then
        local pos = self:GetPos() + VectorRand() * 2
        local emitter = ParticleEmitter(pos)

        local smoke = emitter:Add("effects/spark", pos)

        smoke:SetVelocity( VectorRand() * 32 )
        smoke:SetStartAlpha( 255 )
        smoke:SetEndAlpha( 0 )
        smoke:SetStartSize( 2 )
        smoke:SetEndSize( 0 )
        smoke:SetRoll( math.Rand(-180, 180) )
        smoke:SetRollDelta( math.Rand(-32, 32) )
        smoke:SetColor( 255, 255, 255 )
        smoke:SetAirResistance( 125 )
        smoke:SetPos( pos )
        smoke:SetCollide( true )
        smoke:SetBounce( 1 )
        smoke:SetLighting( false )
        smoke:SetDieTime(math.Rand(2, 3))
        smoke:SetGravity(Vector(0, 0, 4))

        emitter:Finish()
    end
    self.Tick = (self.Tick or 0) + 1
end