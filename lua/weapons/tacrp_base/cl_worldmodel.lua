function SWEP:DrawWorldModel()
    self:DrawCustomModel(true)

    if self:GetValue("Laser") and self:GetTactical() then
        self:SetRenderBounds(Vector(-16, -16, -16), Vector(16, 16, 15000))
    else
        self:SetRenderBounds(Vector(-16, -16, -16), Vector(16, 16, 16))
    end

    self:DrawModel()

end

function SWEP:DrawWorldModelTranslucent()
    self:DrawLasers(true)
    self:DrawFlashlightsWM()

    -- self:DrawFlashlightGlares()

    -- self:DoScopeGlint()
end