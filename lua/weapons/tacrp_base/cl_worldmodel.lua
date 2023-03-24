function SWEP:DrawWorldModel()
    self:DrawCustomModel(true)

    if self:GetValue("Laser") and self:GetTactical() then
        self:SetRenderBounds(Vector(-16, -16, -16), Vector(16, 16, 15000))
    else
        self:SetRenderBounds(Vector(-16, -16, -16), Vector(16, 16, 16))
    end

    self:DrawModel()
end

hook.Add("PostDrawTranslucentRenderables", "TacRP_TranslucentDraw", function()
    for _, ply in pairs(player.GetAll()) do
        local wep = ply:GetActiveWeapon()
        if ply != LocalPlayer() and IsValid(wep) and wep.ArcticTacRP then
            wep:DrawLasers(true)
            wep:DrawFlashlightsWM()
            wep:DrawFlashlightGlares()
            wep:DoScopeGlint()
        end
    end
end)