local mat_corner_ul = Material("TacRP/hud/800corner_nobg1.png", "mips smooth")
local mat_corner_ur = Material("TacRP/hud/800corner_nobg2.png", "mips smooth")
local mat_corner_br = Material("TacRP/hud/800corner_nobg3.png", "mips smooth")
local mat_corner_bl = Material("TacRP/hud/800corner_nobg4.png", "mips smooth")

function TacRP.DrawCorneredBox(x, y, w, h, col)
    col = col or Color(255, 255, 255)

    surface.DrawRect(x, y, w, h)

    surface.SetDrawColor(col)

    local s = 8

    surface.SetMaterial(mat_corner_ul)
    surface.DrawTexturedRect(x, y, s, s)

    surface.SetMaterial(mat_corner_ur)
    surface.DrawTexturedRect(x + w - s, y, s, s)

    surface.SetMaterial(mat_corner_bl)
    surface.DrawTexturedRect(x, y + h - s, s, s)

    surface.SetMaterial(mat_corner_br)
    surface.DrawTexturedRect(x + w - s, y + h - s, s, s)
end

local hide = {
    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true,
}

hook.Add("HUDShouldDraw", "TacRP_HideHUD", function(name)
    if !IsValid(LocalPlayer()) then return end

    local wpn = LocalPlayer():GetActiveWeapon()

    if !wpn.ArcticTacRP then return end

    if !GetConVar("tacrp_drawhud"):GetBool() then return end

    if hide[name] then return false end
end)

local names = {
    ["357"] = "Magnum Ammo",
    ["smg1"] = "Carbine Ammo",
    ["ar2"] = "Rifle Ammo",
    ["sniperpenetratedround"] = "Sniper Ammo",
}

hook.Add("PreGamemodeLoaded", "TacRP_AmmoName", function()
    if GetConVar("tacrp_ammonames"):GetBool() then
        for k, v in pairs(game.GetAmmoTypes()) do
            language.Add(k .. "_ammo", v)
        end
    end
end)