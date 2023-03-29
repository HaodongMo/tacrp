AddCSLuaFile()

SWEP.Base = "tacrp_base_nade"
SWEP.Spawnable = true
SWEP.IconOverride = "entities/tacrp_ammo_charge.png"


// names and stuff
SWEP.PrintName = "Breaching Charge"
SWEP.Category = "Tactical RP" // "Tactical RP (Arctic)"

SWEP.ViewModel = "models/weapons/cstrike/c_eq_fraggrenade.mdl"
SWEP.WorldModel = "models/weapons/w_eq_fraggrenade.mdl"

SWEP.ViewModelFOV = 65

SWEP.Slot = 4

SWEP.PrimaryGrenade = "charge"

SWEP.AnimationTranslationTable = {
    ["prime_grenade"] = "pullpin",
    ["throw_grenade"] = "throw",
    ["throw_grenade_underhand"] = "throw",
}

SWEP.Attachments = {}