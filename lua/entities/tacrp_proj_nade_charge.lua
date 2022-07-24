AddCSLuaFile()

ENT.Base                     = "tacrp_proj_base"
ENT.PrintName                = "C4"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/tacint/door_charge-1.mdl"

ENT.Sticky = true

ENT.IsRocket = false // projectile has a booster and will not drop.

ENT.InstantFuse = true // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = false // projectile explodes on impact.

ENT.ExplodeOnDamage = true // projectile explodes when it takes damage.
ENT.ExplodeUnderwater = false

ENT.Defusable = false

ENT.Delay = 3

ENT.ExplodeSounds = {
    "TacRP/weapons/breaching_charge-1.wav"
}

function ENT:Detonate()
    util.BlastDamage(self, self:GetOwner(), self:GetPos(), 128, 300)

    local fx = EffectData()
    fx:SetOrigin(self:GetPos())

    if self:WaterLevel() > 0 then
        util.Effect("WaterSurfaceExplosion", fx)
    else
        util.Effect("HelicopterMegaBomb", fx)
    end

    local door = self:GetParent()
    if IsValid(door) and string.find(door:GetClass(), "door") then
        local vel = self:GetForward() * -50000
        for _, otherDoor in pairs(ents.FindInSphere(door:GetPos(), 72)) do
            if door != otherDoor and otherDoor:GetClass() == door:GetClass() then
                TacRP.DoorBust(otherDoor, vel)
                break
            end
        end
        TacRP.DoorBust(door, vel)

    end

    self:EmitSound(table.Random(self.ExplodeSounds), 125)

    self:Remove()
end


local mat = Material("sprites/light_glow02_add")
function ENT:Draw()
    self:DrawModel()

    if math.ceil((CurTime() - self.SpawnTime) * 4) % 2 == 1 then
        render.SetMaterial(mat)
        render.DrawSprite(self:GetPos() + self:GetAngles():Up() * 7.5 + self:GetAngles():Right() * -4.5 + self:GetAngles():Forward() * 2, 8, 8, Color(255, 0, 0))
    end
end