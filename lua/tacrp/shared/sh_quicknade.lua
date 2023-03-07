TacRP.QuickNades = {
    ["frag"] = {
        PrintName = "FRAG",
        GrenadeEnt = "tacrp_proj_nade_frag",
        ThrowForce = 1000,
        Ammo = "grenade",
        Model = "models/weapons/tacint/v_quicknade_frag.mdl",
        Spoon = true,
        Icon = Material("TacRP/grenades/frag.png", "mips smooth"),

        Category = "LETHAL",
        SortOrder = 1,
    },
    ["flashbang"] = {
        PrintName = "FLASH",
        GrenadeEnt = "tacrp_proj_nade_flashbang",
        ThrowForce = 1000,
        Ammo = "ti_flashbang",
        Model = "models/weapons/tacint/v_quicknade_flashbang.mdl",
        Spoon = true,
        Icon = Material("TacRP/grenades/flashbang.png", "mips smooth"),

        Category = "UTILITY",
        SortOrder = 4,
    },
    ["smoke"] = {
        PrintName = "SMOKE",
        GrenadeEnt = "tacrp_proj_nade_smoke",
        ThrowForce = 1000,
        Ammo = "ti_smoke",
        Model = "models/weapons/tacint/v_quicknade_smoke.mdl",
        Spoon = true,
        Icon = Material("TacRP/grenades/smoke.png", "mips smooth"),

        Category = "UTILITY",
        SortOrder = 5,
    },
    ["gas"] = {
        PrintName = "GAS",
        GrenadeEnt = "tacrp_proj_nade_gas",
        ThrowForce = 1000,
        Ammo = "ti_gas",
        Model = "models/weapons/tacint/v_quicknade_smoke.mdl",
        Spoon = true,
        Material = "models/tacint/weapons/v_models/smoke/gas-1",
        Icon = Material("TacRP/grenades/gas.png", "mips smooth"),

        Category = "UTILITY",
        SortOrder = 6,
    },
    ["thermite"] = {
        PrintName = "FIRE",
        GrenadeEnt = "tacrp_proj_nade_thermite",
        ThrowForce = 1000,
        Ammo = "ti_thermite",
        Model = "models/weapons/tacint/v_quicknade_smoke.mdl",
        Spoon = true,
        Material = "models/tacint/weapons/v_models/smoke/thermite-1",
        Icon = Material("TacRP/grenades/thermite.png", "mips smooth"),

        Category = "LETHAL",
        SortOrder = 2,
    },
    ["c4"] = {
        PrintName = "C4",
        GrenadeEnt = "tacrp_proj_nade_c4",
        ThrowForce = 2000,
        ThrowSpeed = 0.75,
        Ammo = "ti_c4",
        Model = "models/weapons/tacint/v_quicknade_c4.mdl",
        OverhandOnly = true,
        Spoon = false,
        Secret = true,
        SecretWeapon = "tacrp_c4_detonator",
        Icon = Material("TacRP/grenades/c4.png", "mips smooth"),

        Category = "SPECIAL",
        SortOrder = 8,
    },
    ["nuke"] = {
        PrintName = "NUKE",
        GrenadeEnt = "tacrp_proj_nade_nuke",
        ThrowForce = 500,
        ThrowSpeed = 0.75,
        Ammo = "ti_nuke",
        Model = "models/weapons/tacint/v_quicknade_nuke.mdl",
        Spoon = false,
        Secret = true,
        AdminOnly = true,
        Icon = Material("TacRP/grenades/nuke.png", "mips smooth"),

        Category = "SPECIAL",
        SortOrder = 9,
    },
    ["charge"] = {
        PrintName = "BREACH",
        GrenadeEnt = "tacrp_proj_nade_charge",
        ThrowForce = 2000,
        ThrowSpeed = 0.75,
        Ammo = "ti_charge",
        Model = "models/weapons/tacint/v_quicknade_door_charge.mdl",
        OverhandOnly = true,
        Spoon = false,
        Icon = Material("TacRP/grenades/breach.png", "mips smooth"),

        Category = "LETHAL",
        SortOrder = 3,
    },
    ["rock"] = {
        PrintName = "ROCK",
        GrenadeEnt = "tacrp_proj_nade_rock",
        ThrowForce = 3000,
        ThrowSpeed = 1.1,
        Ammo = nil,
        UnderhandSpecial = true,
        Model = "models/weapons/tacint_extras/v_quicknade_rock.mdl",
        Spoon = false,
        NoSounds = true,
        PullSound = "tacrp/weapons/pistol_holster-1.wav",
        Icon = Material("TacRP/grenades/rock.png", "mips smooth"),
        RequireStat = "ThrowRocks",

        Category = "SPECIAL",
        SortOrder = 7,
    },
}

TacRP.QuickNades_Index = {}

TacRP.QuickNades_Count = 0

for i, k in SortedPairsByMemberValue(TacRP.QuickNades, "SortOrder") do
    TacRP.QuickNades_Count = TacRP.QuickNades_Count + 1

    TacRP.QuickNades_Index[TacRP.QuickNades_Count] = i
    k.Index = TacRP.QuickNades_Count
end

function TacRP.IsGrenadeInfiniteAmmo(i)
    local nade = i
    if isstring(i) then
        nade = TacRP.QuickNades[i]
    elseif isnumber(i) then
        nade = TacRP.QuickNades[TacRP.QuickNades_Index[i]]
    end

    if !istable(nade) then return false end

    -- no ammo type means infinite ammo
    if !nade.Ammo then return true end

    -- non-admin nades are affected by infinite grenades cvar
    if !nade.AdminOnly and GetConVar("tacrp_infinitegrenades"):GetBool() then return true end

    return false
end