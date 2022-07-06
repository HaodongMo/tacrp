function SWEP:SwitchFiremode()
    local fm = self:GetFiremode()

    fm = fm + 1

    if fm > #self:GetValue("Firemodes") then
        fm = 1
    end

    self:SetFiremode(fm)
end

function SWEP:GetCurrentFiremode()
    if self:GetValue("Firemodes") then
        return self:GetValue("Firemodes")[self:GetFiremode()]
    else
        return self:GetValue("Firemode")
    end
end

function SWEP:ToggleSafety(onoff)
    onoff = onoff or !self:GetSafe()

    self:SetSafe(onoff)

    if onoff == true then
        self:ToggleBlindFire(false)
    end
end