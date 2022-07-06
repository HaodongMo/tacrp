SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "Ruger Mini-14"
SWEP.Category = "Tactical RP (Arctic)"

SWEP.Description = "Cheap semi-automatic rifle with no stock and no optic mount."

SWEP.ViewModel = "models/weapons/tacint/v_m1.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_m1.mdl"

SWEP.Slot = 3

// "ballistics"

SWEP.Damage_Max = 100 / 4 // damage at minimum range
SWEP.Damage_Min = 100 / 6 // damage at maximum range
SWEP.Range_Min = 2000 // distance for which to maintain maximum damage
SWEP.Range_Max = 6000 // distance at which we drop to minimum damage
SWEP.Penetration = 7 // units of metal this weapon can penetrate

// misc. shooting

SWEP.Firemode = 1

SWEP.RPM = 450

SWEP.Spread = 0.0035

// Spread penalties are in spread units and are additive
SWEP.MoveSpreadPenalty = 0.0 // spread penalty while travelling at max. 250 u/s
SWEP.MidAirSpreadPenalty = 0.0 // spread penalty for being in the air
SWEP.HipFireSpreadPenalty = 0.0 // spread penalty for not being scoped in
SWEP.ScopedSpreadPenalty = 0
SWEP.BlindFireSpreadPenalty = 0.0 // spread penalty for blind firing
SWEP.CrouchSpreadPenalty = 0

SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 5
SWEP.RecoilResetTime = 0.25 // time after you stop shooting for recoil to start dissipating
SWEP.RecoilDissipationRate = 100
SWEP.RecoilFirstShotMult = 1 // multiplier for the first shot's recoil amount

SWEP.RecoilVisualKick = 1

SWEP.RecoilKick = 4


SWEP.RecoilSpreadPenalty = 0.0025 // extra spread per one unit of recoil

SWEP.CanBlindFire = true

// handling

SWEP.MoveSpeedMult = 0.96
SWEP.ShootingSpeedMult = 1 // slow down applied while shooting
SWEP.SightedSpeedMult = 0.5
SWEP.MeleeSpeedMult = 0.5
SWEP.MeleeSpeedMultTime = 2 // seconds to apply slow down for

SWEP.SprintToFireTime = 0.35 // multiplies how long it takes to recover from sprinting

// hold types

SWEP.HoldType = "ar2"
SWEP.HoldTypeSprint = "passive"
SWEP.HoldTypeBlindFire = false

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.PassiveAng = Angle(0, 0, 0)
SWEP.PassivePos = Vector(0, -2, -4)

SWEP.BlindFireAng = Angle(0, 5, 0)
SWEP.BlindFirePos = Vector(0, -2, -4)

SWEP.SprintAng = Angle(30, -15, 0)
SWEP.SprintPos = Vector(5, 0, -2)

SWEP.SightAng = Angle(0, -0.9, 0)
SWEP.SightPos = Vector(-5.381, -9, -1.99)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_BACK
SWEP.HolsterPos = Vector(5, -8, -6)
SWEP.HolsterAng = Angle(0, 0, 0)

SWEP.Sway = 1.5
SWEP.ScopedSway = 0.15

// reload

SWEP.ClipSize = 20
SWEP.Ammo = "smg1"

SWEP.ReloadTimeMult = 1
SWEP.DropMagazineModel = "models/weapons/tacint/magazines/m4.mdl"
SWEP.DropMagazineImpact = "metal"

// sounds

local path = "tacrp/weapons/m1/"

SWEP.Sound_Shoot = "^" .. path .. "fire-1.wav"
SWEP.Sound_Shoot_Silenced = path .. "fire_silenced-1.wav"

SWEP.Vol_Shoot = 110
SWEP.ShootPitchVariance = 2.5 // amount to vary pitch by each shot

// effects

// the .qc attachment for the muzzle
SWEP.QCA_Muzzle = 1
// ditto for shell
SWEP.QCA_Eject = 2

SWEP.MuzzleEffect = "muzzleflash_ak47"
SWEP.EjectEffect = 2

// anims

// VM:
// idle
// fire
// fire1, fire2...
// dryfire
// melee
// reload
// midreload
// prime_grenade
// throw_grenade
// throw_grenade_underhand
// deploy
// blind_idle
// blind_fire
// blind_fire1, blind_fire2...
// blind_dryfire

// WM:
// attack1
SWEP.AnimationTranslationTable = {
    ["fire1"] = "fire1_M",
    ["fire2"] = "fire2_M",
    ["fire3"] = "fire3_M",
    ["fire4"] = "fire4_M",
    ["fire5"] = "fire5_M",
    ["melee"] = {"melee1", "melee2"}
}

// attachments

SWEP.AttachmentElements = {
    ["foldstock"] = {
        BGs_VM = {
            {1, 1}
        },
        BGs_WM = {
            {1, 1}
        }
    },
    ["tactical"] = {
        BGs_VM = {
            {2, 1}
        },
    },
}


SWEP.Attachments = {
    [1] = {
        PrintName = "Muzzle",
        Category = "silencer",
        Bone = "m1_root",
        WMBone = "Box01",
        AttachSound = "tacrp/weapons/silencer_on.wav",
        DetachSound = "tacrp/weapons/silencer_off.wav",
        Pos_VM = Vector(5, 0.075, 33.5),
        Pos_WM = Vector(0.1, 29, -0.1),
        Ang_VM = Angle(90, 0, 0),
        Ang_WM = Angle(0, -90, 0),
    },
    [2] = {
        PrintName = "Tactical",
        Category = "tactical",
        Bone = "m1_root",
        WMBone = "Box01",
        AttachSound = "tacrp/weapons/flashlight_on.wav",
        DetachSound = "tacrp/weapons/flashlight_off.wav",
        InstalledElements = {"tactical"},
        Pos_VM = Vector(4, 0.75, 24),
        Pos_WM = Vector(0.9, 17, -1),
        Ang_VM = Angle(90, 0, 90),
        Ang_WM = Angle(-70, -90, 0),
    },
    [3] = {
        PrintName = "Accessory",
        Category = {"perk", "perk_melee", "perk_shooting", "perk_reload", "perk_sling"},
        AttachSound = "tacrp/weapons/flashlight_on.wav",
        DetachSound = "tacrp/weapons/flashlight_off.wav",
    },
}