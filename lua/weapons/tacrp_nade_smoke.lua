AddCSLuaFile()

SWEP.Base = "tacrp_base_nade"
SWEP.Spawnable = TacRP.AreTheGrenadeAnimsReadyYet
SWEP.IconOverride = "entities/tacrp_ammo_smoke.png"

// names and stuff
SWEP.PrintName = "Smoke Grenade"
SWEP.Category = "Tactical RP (Special)" // "Tactical RP (Arctic)"

SWEP.ViewModel = "models/weapons/cstrike/c_eq_smokegrenade.mdl"
SWEP.WorldModel = "models/weapons/w_eq_smokegrenade.mdl"

SWEP.ViewModelFOV = 65

SWEP.Slot = 4

SWEP.PrimaryGrenade = "smoke"

SWEP.AnimationTranslationTable = {
    ["prime_grenade"] = "pullpin",
    ["throw_grenade"] = "throw",
    ["throw_grenade_underhand"] = "throw",
}

SWEP.TTTReplace = {["weapon_ttt_smokegrenade"] = 1}

SWEP.Attachments = {}