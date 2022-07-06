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

ENT.Delay = 2.5

ENT.BounceSounds = {
    "TacRP/weapons/grenade/flashbang_bounce-1.wav",
    "TacRP/weapons/grenade/flashbang_bounce-2.wav",
    "TacRP/weapons/grenade/flashbang_bounce-3.wav",
}

ENT.ExplodeSounds = {
    "TacRP/weapons/grenade/flashbang_explode-1.wav",
}

function ENT:Detonate()
    util.BlastDamage(self, self:GetOwner(), self:GetPos(), 150, 25)

    local fx = EffectData()
    fx:SetOrigin(self:GetPos())

    if self:WaterLevel() > 0 then
        util.Effect("WaterSurfaceExplosion", fx)
        self:Remove()
        return
    else
        util.Effect("TacRP_flashexplosion", fx)
    end

    local flashorigin = self:GetPos()

    local flashpower = 1024
    local targets = ents.FindInSphere(flashorigin, flashpower)

    for _, k in pairs(targets) do
        if k:IsPlayer() then
            local dist = k:EyePos():Distance(flashorigin)
            local dp = (k:EyePos() - flashorigin):Dot(k:EyeAngles():Forward())

            local time = Lerp( dp, 2.5, 0.25 )

            time = Lerp( dist / flashpower, time, 0 )

            if k:VisibleVec( flashorigin ) then
                k:ScreenFade( SCREENFADE.IN, Color( 255, 255, 255, 255 ), 2.5, time )
            end

            k:SetDSP( 37, false )
        end
    end

    self:EmitSound(table.Random(self.ExplodeSounds), 125)

    self:Remove()
end