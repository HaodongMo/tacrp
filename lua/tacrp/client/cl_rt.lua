hook.Add("PreRender", "TACRP_PreRender", function()
    local wpn = LocalPlayer():GetActiveWeapon()

    if !wpn.ArcticTacRP then return end

    if wpn:GetValue("BlindFireCamera") then
        wpn:DoRT()
    end

    if wpn:GetValue("ThermalCamera") then
        wpn:DoThermalRT()
    end
end)