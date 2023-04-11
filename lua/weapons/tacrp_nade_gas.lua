AddCSLuaFile()

SWEP.Base = "tacrp_base_nade"
SWEP.Spawnable = TacRP.AreTheGrenadeAnimsReadyYet
SWEP.IconOverride = "entities/tacrp_ammo_gas.png"

// names and stuff
SWEP.PrintName = "CS Gas Grenade"
SWEP.Category = "Tactical RP" // "Tactical RP (Arctic)"

SWEP.ViewModel = "models/weapons/cstrike/c_eq_smokegrenade.mdl"
SWEP.WorldModel = "models/weapons/w_eq_smokegrenade.mdl"

SWEP.ViewModelFOV = 65

SWEP.Slot = 4

SWEP.PrimaryGrenade = "gas"

SWEP.AnimationTranslationTable = {
    ["prime_grenade"] = "pullpin",
    ["throw_grenade"] = "throw",
    ["throw_grenade_underhand"] = "throw",
}


SWEP.TTTReplace = {["weapon_ttt_smokegrenade"] = 0.25, ["weapon_zm_molotov"] = 0.25}

SWEP.Attachments = {}