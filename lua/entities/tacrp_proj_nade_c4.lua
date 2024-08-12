AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "C4"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/c4_charge-1.mdl"

ENT.Sticky = true

ENT.IsRocket = false // projectile has a booster and will not drop.

ENT.InstantFuse = false // projectile is armed immediately after firing.
ENT.RemoteFuse = true // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = false // projectile explodes on impact.

ENT.ExplodeOnDamage = false // projectile explodes when it takes damage.
ENT.ExplodeUnderwater = false

ENT.Defusable = true
ENT.DefuseOnDamage = true

ENT.ImpactDamage = 0

ENT.Delay = 0.5

ENT.PickupAmmo = "ti_c4"

ENT.ExplodeSounds = {
    "TacRP/weapons/breaching_charge-1.wav"
}

function ENT:Detonate()
    local attacker = self.Attacker or self:GetOwner() or self

    local dmg = TacRP.ConVars["c4_damage"]:GetFloat()
    local rad = TacRP.ConVars["c4_radius"]:GetFloat()
    local p = self:GetPos() + self:GetForward() * 8

    util.BlastDamage(self, attacker, p, rad / 2, dmg)
    util.BlastDamage(self, attacker, p, rad, dmg)

    local fx = EffectData()
    fx:SetOrigin(p)

    if self:WaterLevel() > 0 then
        util.Effect("WaterSurfaceExplosion", fx)
    else
        util.Effect("Explosion", fx)

        if rad >= 400 then
            local count = 8
            for i = 1, count do
                local tr = util.TraceLine({
                    start = p,
                    endpos = p + Angle(0, i / count * 360, 0):Forward() * (rad - 200) * math.Rand(0.9, 1.1),
                    mask = MASK_SHOT,
                    filter = self,
                })
                fx:SetOrigin(tr.HitPos)
                util.Effect("HelicopterMegaBomb", fx)
            end
        end
    end

    self:EmitSound(table.Random(self.ExplodeSounds), 125)

    self:SetParent(NULL)
    for _, door in pairs(ents.FindInSphere(self:GetPos(), 256)) do
        if IsValid(door) and string.find(door:GetClass(), "door") and !door.TacRP_DoorBusted then
            local vel = (door:GetPos() - self:GetPos()):GetNormalized() * 200000
            for _, otherDoor in pairs(ents.FindInSphere(door:GetPos(), 72)) do
                if door != otherDoor and otherDoor:GetClass() == door:GetClass() then
                    TacRP.DoorBust(otherDoor, vel, attacker)
                    break
                end
            end
            TacRP.DoorBust(door, vel, attacker)
        end
    end

    self:Remove()
end

function ENT:Stuck()
    // you are already dead
    if IsValid(self:GetParent()) and self:GetParent():IsPlayer() and !IsValid(self:GetParent().nadescream) then
        self:GetParent().nadescream = self
        self:GetParent():EmitSound("vo/npc/male01/ohno.wav")
    end
end