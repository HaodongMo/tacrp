AddCSLuaFile()

SWEP.Base = "tacrp_base_nade"
SWEP.Spawnable = TacRP.AreTheGrenadeAnimsReadyYet
SWEP.IconOverride = "entities/tacrp_ammo_fire.png"

// names and stuff
SWEP.PrintName = "Thermite Grenade"
SWEP.Category = "Tactical RP (Special)" // "Tactical RP (Arctic)"

SWEP.ViewModel = "models/weapons/cstrike/c_eq_flashbang.mdl"
SWEP.WorldModel = "models/weapons/w_eq_flashbang.mdl"

SWEP.ViewModelFOV = 65

SWEP.Slot = 4

SWEP.PrimaryGrenade = "thermite"

SWEP.AnimationTranslationTable = {
    ["prime_grenade"] = "pullpin",
    ["throw_grenade"] = "throw",
    ["throw_grenade_underhand"] = "throw",
}

SWEP.TTTReplace = {["weapon_zm_molotov"] = 1}

SWEP.Attachments = {}