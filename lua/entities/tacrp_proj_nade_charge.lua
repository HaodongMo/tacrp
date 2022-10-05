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

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "Remote")
end

DEFINE_BASECLASS(ENT.Base)

function ENT:Initialize()
    if IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() and IsValid(self:GetOwner():GetActiveWeapon()) and self:GetOwner():GetActiveWeapon():GetClass() == "tacrp_c4_detonator" then
        self.InstantFuse = false
        self.RemoteFuse = true
        self.Delay = 0.5
        self.Defusable = true
        self:SetRemote(true)
    end

    BaseClass.Initialize(self)
end

function ENT:Detonate()
    util.BlastDamage(self, self:GetOwner(), self:GetPos(), 128, 300)

    local fx = EffectData()
    fx:SetOrigin(self:GetPos())
    fx:SetNormal(self:GetForward())

    if self:WaterLevel() > 0 then
        util.Effect("WaterSurfaceExplosion", fx)
    else
        util.Effect("HelicopterMegaBomb", fx)
    end

    self:EmitSound(table.Random(self.ExplodeSounds), 115)

    local door = self:GetParent()
    self:SetParent(NULL)

    if IsValid(door) and string.find(door:GetClass(), "door") then
        local vel = self:GetForward() * -50000
        for _, otherDoor in pairs(ents.FindInSphere(door:GetPos(), 72)) do
            if door != otherDoor and otherDoor:GetClass() == door:GetClass() then
                TacRP.DoorBust(otherDoor, vel, self:GetOwner())
                break
            end
        end
        TacRP.DoorBust(door, vel, self:GetOwner())

    end

    self:Remove()
end

function ENT:OnThink()
    self.Beep = self.Beep or self.SpawnTime
    if !self:GetRemote() and SERVER and self.Beep < CurTime() then
        self.Beep = CurTime() + 0.25
        self:EmitSound("weapons/c4/c4_beep1.wav", 80, 110)
    end
end

local clr_timed = Color(255, 0, 0)
local clr_remote = Color(0, 255, 0)

local mat = Material("sprites/light_glow02_add")
function ENT:Draw()
    self:DrawModel()

    if math.ceil((CurTime() - self.SpawnTime) * (self:GetRemote() and 1 or 4)) % 2 == 1 then
        render.SetMaterial(mat)
        render.DrawSprite(self:GetPos() + self:GetAngles():Up() * 7.5 + self:GetAngles():Right() * -4.5 + self:GetAngles():Forward() * 2, 8, 8, self:GetRemote() and clr_remote or clr_timed)
    end
end