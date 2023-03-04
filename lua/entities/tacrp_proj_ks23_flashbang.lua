AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "KS-23 Flashbang"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/grenade_40mm.mdl"

ENT.IsRocket = false // projectile has a booster and will not drop.

ENT.InstantFuse = true // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = false // projectile explodes on impact.

ENT.ExplodeOnDamage = false // projectile explodes when it takes damage.
ENT.ExplodeUnderwater = true
ENT.ExplodeOnImpact = true

ENT.Delay = 0.2

ENT.ExplodeSounds = {
    "TacRP/weapons/grenade/flashbang_explode-1.wav",
}

ENT.AudioLoop = ""

ENT.SmokeTrail = false

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

    local flashpower = 512
    local targets = ents.FindInSphere(flashorigin, flashpower)

    for _, k in pairs(targets) do
        if k:IsPlayer() then
            local dist = k:EyePos():Distance(flashorigin)
            local dp = (k:EyePos() - flashorigin):Dot(k:EyeAngles():Forward())

            local time = Lerp( dp, 1, 0.25 )

            time = Lerp( dist / flashpower, time, 0.1 )

            if !k:VisibleVec( flashorigin ) then time = 0.1 end

            net.Start("tacrp_flashbang")
                net.WriteFloat(time)
            net.Send(k)

            -- k:ScreenFade( SCREENFADE.IN, GetConVar("tacrp_flash_dark"):GetBool() and Color(0, 0, 0, 254) or Color(255, 255, 255, 254), 1, k:VisibleVec( flashorigin ) and time or 0.1 )

            -- if GetConVar("tacrp_flash_dark"):GetBool() then
            --     k:SetDSP( 32, false )
            -- else
            --     k:SetDSP( 37, false )
            -- end

            k:SetNWFloat("TacRPStunStart", CurTime())
            k:SetNWFloat("TacRPStunDur", time + 0.25)
        end
    end

    self:EmitSound(table.Random(self.ExplodeSounds), 125)

    self:Remove()
end