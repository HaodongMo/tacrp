local ammotypes = {
    ["ti_flashbang"] = {
        max = "tacrp_max_grenades",
    },
    ["ti_thermite"] = {
        max = "tacrp_max_grenades",
    },
    ["ti_smoke"] = {
        max = "tacrp_max_grenades",
    },
    ["ti_c4"] = {
        max = "tacrp_max_grenades",
    },
    ["ti_gas"] = {
        max = "tacrp_max_grenades",
    },
    ["ti_nuke"] = {
        max = "tacrp_max_grenades",
    },
    ["ti_charge"] = {
        max = "tacrp_max_grenades",
    },
    ["ti_heal"] = {
        max = "tacrp_max_grenades",
    },

    -- Only used when tacrp_expandedammotypes 1
    ["ti_pistol_light"] = { -- .22LR, .380 ACP etc.
        expanded = true,
        max = 200,
    },
    ["ti_pistol_heavy"] = { -- .45 ACP, 10mm etc.
        expanded = true,
        max = 120,
    },
    ["ti_pdw"] = { -- 4.6mm, 5.7mm etc.
        expanded = true,
        max = 225,
    },
    ["ti_rifle"] = { -- above 7.62mm but below sniper caliber
        expanded = true,
        max = 50,
    },
    ["ti_sniper"] = { -- sniper, amr calibers
        expanded = true,
        max = 10,
    },
}

hook.Add("Initialize", "tacrp_ammo", function()
    local expanded = TacRP.ConVars["expandedammotypes"]:GetBool()
    for k, v in SortedPairs(ammotypes) do
        if v.expanded and not expanded then continue end
        local maxcvar = v.max
        if isnumber(v.max) then
            maxcvar = "sk_max_" .. k
            CreateConVar(maxcvar, v.max, FCVAR_REPLICATED + FCVAR_ARCHIVE)
        end
        game.AddAmmoType({
            name = k,
            maxcarry = maxcvar
        })

        if CLIENT then
            language.Add(k .. "_ammo", TacRP:GetPhrase("ammo." .. k) or k)
        end
    end
end)


local materials = {
    ["ti_flashbang"] = "tacrp/grenades/flashbang",
    ["ti_thermite"] = "tacrp/grenades/thermite",
    ["ti_smoke"] = "tacrp/grenades/smoke",
    ["ti_c4"] = "tacrp/grenades/c4",
    ["ti_gas"] = "tacrp/grenades/gas",
    ["ti_nuke"] = "tacrp/grenades/nuke",
    ["ti_charge"] = "tacrp/grenades/breach",
    ["ti_heal"] = "tacrp/grenades/heal",
    ["SniperPenetratedRound"] = "tacrp/grenades/sniper",
}

if CLIENT then
    hook.Add("InitPostEntity", "tacrp_hl2hud", function()
        if !HL2HUD then return end
        local tbl = HL2HUD.scheme.DefaultSettings().HudTextures.AmmoInv
        local tbl2 = HL2HUD.scheme.DefaultSettings().HudTextures.Ammo

        for k, v in pairs(materials) do
            local info = {
                type = 2,
                w = 64,
                h = 64,
                x = 0,
                y = 0,
                u1 = 0,
                u2 = 64,
                v1 = 0,
                v2 = 64,
                scalable = false,
                texture = surface.GetTextureID(v)
            }
            if !tbl[k] then
                tbl[k] = info
            end
            if !tbl2[k] then
                tbl2[k] = info
            end
        end
        HL2HUD.settings.ReloadScheme()
    end)
end
