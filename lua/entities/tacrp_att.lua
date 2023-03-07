AddCSLuaFile()

ENT.Type                     = "anim"
ENT.Base                     = "base_entity"
ENT.RenderGroup              = RENDERGROUP_TRANSLUCENT

ENT.PrintName                = "Attachment"
ENT.Category                 = "Tactical Intervention - Attachments"

ENT.Spawnable                = false
ENT.Model                    = "models/tacint/props_containers/supply_case-2.mdl"
ENT.AttToGive                = nil

function ENT:Initialize()
    local model = self.Model

    self:SetModel(model)

    if SERVER then

        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
        self:SetUseType(SIMPLE_USE)
        self:PhysWake()

        self:SetTrigger(true) -- Enables Touch() to be called even when not colliding
        self:UseTriggerBounds(true, 24)
    end
end

function ENT:GiveAtt(ply)
    if !self.AttToGive then return end

    if GetConVar("TacRP_free_atts"):GetBool() then
        ply:PrintMessage(HUD_PRINTTALK, "All attachments are free! This is not necessary!")
        return
    end

    if GetConVar("TacRP_lock_atts"):GetBool() and TacRP:PlayerGetAtts(ply, self.AttToGive) > 0 then
        ply:PrintMessage(HUD_PRINTTALK, "You already have this attachment!")
        return
    end

    TacRP:PlayerGiveAtt(ply, self.AttToGive, 1)
    TacRP:PlayerSendAttInv(ply)

    self:EmitSound("TacRP/weapons/flashlight_on.wav")
    self:Remove()
end

ENT.CollisionSoundsHard = {
    "physics/metal/metal_box_impact_hard1.wav",
    "physics/metal/metal_box_impact_hard2.wav",
    "physics/metal/metal_box_impact_hard3.wav",
}

ENT.CollisionSoundsSoft = {
    "physics/metal/metal_box_impact_soft1.wav",
    "physics/metal/metal_box_impact_soft2.wav",
    "physics/metal/metal_box_impact_soft3.wav",
}

function ENT:PhysicsCollide(data)
    if data.DeltaTime < 0.1 then return end

    if data.Speed > 25 then
        self:EmitSound(self.CollisionSoundsHard[math.random(#self.CollisionSoundsHard)])
    else
        self:EmitSound(self.CollisionSoundsSoft[math.random(#self.CollisionSoundsSoft)])
    end
end

if SERVER then

    function ENT:Use(ply)
        if !ply:IsPlayer() then return end
        self:GiveAtt(ply)
    end

elseif CLIENT then

    function ENT:DrawTranslucent()
        self:Draw()
    end

    function ENT:Draw()
        self:DrawModel()

        if (EyePos() - self:WorldSpaceCenter()):LengthSqr() <= 262144 then -- 512^2
            local ang = self:GetAngles()

            ang:RotateAroundAxis(ang:Forward(), 180)
            ang:RotateAroundAxis(ang:Right(), 90)
            ang:RotateAroundAxis(ang:Up(), 90)

            local pos = self:GetPos()

            pos = pos + ang:Forward() * 0
            pos = pos + ang:Up() * 4.1
            pos = pos + ang:Right() * -8

            cam.Start3D2D(pos, ang, 0.1)
                surface.SetFont("TacRP_LondonBetween_24_Unscaled")

                local w = surface.GetTextSize(self.PrintName)

                surface.SetTextPos(-w / 2, 0)
                surface.SetTextColor(255, 255, 255, 255)
                surface.DrawText(self.PrintName)

                surface.SetDrawColor(255, 255, 255)
                surface.SetMaterial(self.Icon or defaulticon)
                local iw = 64
                surface.DrawTexturedRect(-iw / 2, -iw - 8, iw, iw)
            cam.End3D2D()

            local ang2 = self:GetAngles()

            ang2:RotateAroundAxis(ang2:Forward(), 90)
            ang2:RotateAroundAxis(ang2:Right(), -90)
            ang2:RotateAroundAxis(ang2:Up(), 0)

            local pos2 = self:GetPos()

            pos2 = pos2 + ang2:Forward() * 0
            pos2 = pos2 + ang2:Up() * 4.1
            pos2 = pos2 + ang2:Right() * -8

            cam.Start3D2D(pos2, ang2, 0.1)
                surface.SetFont("TacRP_LondonBetween_24_Unscaled")

                local w2 = surface.GetTextSize(self.PrintName)

                surface.SetTextPos(-w2 / 2, 0)
                surface.SetTextColor(255, 255, 255, 255)
                surface.DrawText(self.PrintName)

                surface.SetDrawColor(255, 255, 255)
                surface.SetMaterial(self.Icon or defaulticon)
                local iw2 = 64
                surface.DrawTexturedRect(-iw2 / 2, -iw2 - 8, iw2, iw2)
            cam.End3D2D()
        end
    end

end