TacRP.QuickNades = {
    ["frag"] = {
        PrintName = "FRAG",
        GrenadeEnt = "tacrp_proj_nade_frag",
        ThrowForce = 2000,
        Ammo = "grenade",
        Model = "models/weapons/tacint/v_quicknade_frag.mdl",
        Spoon = true,
        Icon = Material("TacRP/grenades/frag.png", "mips smooth")
    },
    ["flashbang"] = {
        PrintName = "FLASH",
        GrenadeEnt = "tacrp_proj_nade_flashbang",
        ThrowForce = 2000,
        Ammo = "ti_flashbang",
        Model = "models/weapons/tacint/v_quicknade_flashbang.mdl",
        Spoon = true,
        Icon = Material("TacRP/grenades/flashbang.png", "mips smooth")
    },
    ["smoke"] = {
        PrintName = "SMOKE",
        GrenadeEnt = "tacrp_proj_nade_smoke",
        ThrowForce = 2000,
        Ammo = "ti_smoke",
        Model = "models/weapons/tacint/v_quicknade_smoke.mdl",
        Spoon = true,
        Icon = Material("TacRP/grenades/smoke.png", "mips smooth")
    },
    ["gas"] = {
        PrintName = "GAS",
        GrenadeEnt = "tacrp_proj_nade_gas",
        ThrowForce = 2000,
        Ammo = "ti_gas",
        Model = "models/weapons/tacint/v_quicknade_smoke.mdl",
        Spoon = true,
        Material = "models/tacint/weapons/v_models/smoke/gas-1",
        Icon = Material("TacRP/grenades/gas.png", "mips smooth")
    },
    ["thermite"] = {
        PrintName = "FIRE",
        GrenadeEnt = "tacrp_proj_nade_thermite",
        ThrowForce = 2000,
        Ammo = "ti_thermite",
        Model = "models/weapons/tacint/v_quicknade_smoke.mdl",
        Spoon = true,
        Material = "models/tacint/weapons/v_models/smoke/thermite-1",
        Icon = Material("TacRP/grenades/thermite.png", "mips smooth")
    },
    ["c4"] = {
        PrintName = "C4",
        GrenadeEnt = "tacrp_proj_nade_c4",
        ThrowForce = 2000,
        Ammo = "ti_c4",
        Model = "models/weapons/tacint/v_quicknade_c4.mdl",
        Spoon = false,
        Secret = true,
        Icon = Material("TacRP/grenades/c4.png", "mips smooth")
    },
    ["nuke"] = {
        PrintName = "NUKE",
        GrenadeEnt = "tacrp_proj_nade_nuke",
        ThrowForce = 500,
        Ammo = "ti_nuke",
        Model = "models/weapons/tacint/v_quicknade_nuke.mdl",
        Spoon = false,
        Secret = true,
        AdminOnly = true,
        Icon = Material("TacRP/grenades/nuke.png", "mips smooth")
    },
    ["charge"] = {
        PrintName = "BREACH",
        GrenadeEnt = "tacrp_proj_nade_charge",
        ThrowForce = 2000,
        Ammo = "ti_charge",
        Model = "models/weapons/tacint/v_quicknade_door_charge.mdl",
        Spoon = false,
        Secret = false,
        Icon = Material("TacRP/grenades/c4.png", "mips smooth")
    },
}

TacRP.QuickNades_Index = {}

TacRP.QuickNades_Count = 0

for i, k in pairs(TacRP.QuickNades) do
    TacRP.QuickNades_Count = TacRP.QuickNades_Count + 1

    TacRP.QuickNades_Index[TacRP.QuickNades_Count] = i
    k.Index = TacRP.QuickNades_Count
end