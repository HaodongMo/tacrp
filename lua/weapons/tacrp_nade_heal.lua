AddCSLuaFile()

SWEP.Base = "tacrp_base_nade"
SWEP.Spawnable = TacRP.AreTheGrenadeAnimsReadyYet
SWEP.IconOverride = "entities/tacrp_ammo_heal.png"

// names and stuff
SWEP.PrintName = "Medi-Smoke Canister"
SWEP.Category = "Tactical RP (Special)"

SWEP.ViewModel = "models/weapons/tacint/v_throwable_csgas.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_smoke.mdl"

SWEP.Material = "models/tacint/weapons/v_models/smoke/heal-1"

SWEP.ViewModelFOV = 65

SWEP.Slot = 4

SWEP.PrimaryGrenade = "heal"

SWEP.FiremodeName = "Throw"

SWEP.AnimationTranslationTable = {
    ["prime_grenade"] = "pullpin",
    ["throw_grenade"] = "throw",
    ["throw_grenade_underhand"] = "throw",
}


SWEP.TTTReplace = {["weapon_ttt_smokegrenade"] = 0.25, ["weapon_zm_molotov"] = 0.25}

SWEP.Attachments = {}

SWEP.HoldType = "melee"
SWEP.HoldTypeSprint = "normal"
SWEP.HoldTypeBlindFire = false