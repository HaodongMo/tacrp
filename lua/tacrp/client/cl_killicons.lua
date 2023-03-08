TacRPOldKilliconDraw = TacRPOldKilliconDraw or killicon.Draw
local killicons_cachednames = {}
local killicons_cachedicons = {}
local killiconmat = Material("HUD/killicons/default")

TacRP.KillIconAlias = {
    ["tacrp_proj_rpg7"] = "tacrp_rpg7",
    ["tacrp_proj_rpg7_ratshot"] = "tacrp_rpg7",

    ["tacrp_proj_40mm_3gl"] = "tacrp_m320",
    ["tacrp_proj_40mm_gas"] = "tacrp_m320",
    ["tacrp_proj_40mm_he"] = "tacrp_m320",
    ["tacrp_proj_40mm_heat"] = "tacrp_m320",
    ["tacrp_proj_40mm_lvg"] = "tacrp_m320",
    ["tacrp_proj_40mm_smoke"] = "tacrp_m320",

    ["tacrp_proj_ks23_flashbang"] = "tacrp_ks23",

    ["tacrp_fire_cloud"] = "tacrp_proj_nade_thermite",
    ["tacrp_nuke_cloud"] = "tacrp_proj_nade_nuke",
}

TacRPNewKilliconDraw = function(x, y, name, alpha)
    name = TacRP.KillIconAlias[name] or name
    local wpn = weapons.Get(name)

    if killicons_cachednames[name] == true then
        local w, h = 64, 64
        x = x - 32
        y = y - 24

        cam.Start2D()

        local selecticon = killicons_cachedicons[name]

        if !selecticon then -- not cached
            local loadedmat = Material(wpn.IconOverride or "entities/" .. name .. ".png", "smooth mips")
            killicons_cachedicons[name] = loadedmat
            selecticon = loadedmat
        end

        surface.SetDrawColor(255, 255, 255, alpha)
        surface.SetMaterial(selecticon or killiconmat)
        surface.DrawTexturedRect(x, y, w, h)
        cam.End2D()
    else
        if killicons_cachednames[name] == nil then -- not cached yet, checking for tacrp
            if TacRP.QuickNades_EntLookup[name] then
                killicons_cachednames[name] = true
                killicons_cachedicons[name] = TacRP.QuickNades[TacRP.QuickNades_EntLookup[name]].Icon or killiconmat
            else
                killicons_cachednames[name] = (weapons.Get(name) and weapons.Get(name).ArcticTacRP) or false
            end -- weapons.get() will return nil for any hl2 base gun
        else -- we know it is totally not tacrp gun
            return TacRPOldKilliconDraw(x, y, name, alpha)
        end
    end
end

killicon.Draw = TacRPNewKilliconDraw