AddCSLuaFile()

ENT.Type                     = "anim"
ENT.Base                     = "base_entity"
ENT.RenderGroup              = RENDERGROUP_OPAQUE

ENT.PrintName                = "Customization Bench"
ENT.Category                 = "Tactical RP"

ENT.Spawnable                = true
ENT.Model                    = "models/props_canal/winch02.mdl"

function ENT:Initialize()
    local model = self.Model

    self:SetModel(model)

    if SERVER then
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
        self:PhysWake()
    end

    -- removal is handled when checking position
    table.insert(TacRP.Benches, self)
end

function ENT:Draw()
    self:DrawModel()
end