SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "IMI Desert Eagle"
SWEP.Category = "Tactical RP" // "Tactical RP (Arctic)"

// Model from https://gamebanana.com/mods/207737

SWEP.SubCatTier = "2Elite"
SWEP.SubCatType = "1Sidearm"

SWEP.Description = "With a rifle-inspired mechanism and a high-calibre .50 AE round, this infamous pistol needs no introduction."

SWEP.ViewModel = "models/weapons/tacint/v_deagle.mdl"
SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"

SWEP.Slot = 1

SWEP.ArcadeStats = {
    MoveSpeedMult = 1,
    ShootingSpeedMult = 0.75,
    SightedSpeedMult = 1,
    MeleeSpeedMult = 1,
    ReloadSpeedMult = 1,
}

// "ballistics"

SWEP.Damage_Max = 70 // damage at minimum range
SWEP.Damage_Min = 30 // damage at maximum range
SWEP.Range_Min = 500 // distance for which to maintain maximum damage
SWEP.Range_Max = 2000 // distance at which we drop to minimum damage
SWEP.Penetration = 5 // units of metal this weapon can penetrate

SWEP.MuzzleVelocity = 9000

SWEP.BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1.25,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
    [HITGROUP_LEFTLEG] = 0.75,
    [HITGROUP_RIGHTLEG] = 0.75,
    [HITGROUP_GEAR] = 0.75
}

// misc. shooting

SWEP.Firemode = 1

SWEP.RPM = 200

SWEP.Spread = 0.002

SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 8
SWEP.RecoilResetTime = 0.25
SWEP.RecoilDissipationRate = 10
SWEP.RecoilFirstShotMult = 0.6

SWEP.RecoilVisualKick = 1.5

SWEP.RecoilKick = 5

SWEP.RecoilSpreadPenalty = 0.01

SWEP.CanBlindFire = true

// handling

SWEP.MoveSpeedMult = 0.9
SWEP.ShootingSpeedMult = 0.5
SWEP.SightedSpeedMult = 0.5
SWEP.MeleeSpeedMult = 0.5
SWEP.ReloadSpeedMult = 0.75

SWEP.AimDownSightsTime = 0.34
SWEP.SprintToFireTime = 0.34

// hold types

SWEP.HoldType = "revolver"
SWEP.HoldTypeSprint = "normal"
SWEP.HoldTypeBlindFire = false

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_PISTOL

SWEP.PassiveAng = Angle(0, 0, 0)
SWEP.PassivePos = Vector(0, -2, -5)

SWEP.BlindFireAng = Angle(0, 5, 0)
SWEP.BlindFirePos = Vector(0, -2, -5)

SWEP.BlindFireSuicideAng = Angle(-130, -4, 45)
SWEP.BlindFireSuicidePos = Vector(25, 15, -6)

SWEP.SprintAng = Angle(0, 30, 0)
SWEP.SprintPos = Vector(2, 0, -12)

SWEP.SightAng = Angle(5.0, 0, 1)
SWEP.SightPos = Vector(-2.43, 0, -4)

SWEP.CorrectivePos = Vector(-2.05, 0, 0.1)
SWEP.CorrectiveAng = Angle(-5, 5, 0)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_PISTOL
SWEP.HolsterPos = Vector(0, 3, -4)
SWEP.HolsterAng = Angle(90, 0, 0)

// reload

SWEP.ClipSize = 7
SWEP.Ammo = "357"

SWEP.ReloadTimeMult = 1

SWEP.DropMagazineModel = "models/weapons/tacint/magazines/p250.mdl"
SWEP.DropMagazineImpact = "pistol"

// sounds

local path = "tacrp_extras/deagle/"

SWEP.Sound_Shoot = path .. "deagle-1.wav"

SWEP.Vol_Shoot = 110
SWEP.ShootPitchVariance = 2.5 // amount to vary pitch by each shot

// effects

// the .qc attachment for the muzzle
SWEP.QCA_Muzzle = 4

SWEP.MuzzleEffect = "muzzleflash_pistol"

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
    ["deploy"] = "draw",
    ["fire"] = {"shoot1", "shoot2", "shoot3"},
    ["blind_fire"] = {"blind_shoot1", "blind_shoot2", "blind_shoot3"},
    ["melee"] = {"melee1", "melee2"}
}

SWEP.ShootTimeMult = 0.5

SWEP.LastShot = true

// attachments

SWEP.Attachments = {
    [1] = {
        PrintName = "Optic",
        Category = {"optic_cqb", "optic_medium"},
        Bone = "slide",
        WMBone = "ValveBiped.Bip01_R_Hand",
        AttachSound = "tacrp/weapons/optic_on.wav",
        DetachSound = "tacrp/weapons/optic_off.wav",
        VMScale = 1,
        WMScale = 1,
        Pos_VM = Vector(0, 7, 1),
        Ang_VM = Angle(0, -90, 0),
        Pos_WM = Vector(9.5, 2, -4.75),
        Ang_WM = Angle(0, -5, 180)
    },
    [2] = {
        PrintName = "Tactical",
        Category = "tactical",
        Bone = "sphinx_ROOT",
        WMBone = "ValveBiped.Bip01_R_Hand",
        AttachSound = "tacrp/weapons/flashlight_on.wav",
        DetachSound = "tacrp/weapons/flashlight_off.wav",
        VMScale = 1.1,
        WMScale = 1.3,
        Pos_VM = Vector(-2, 0, 7),
        Ang_VM = Angle(90, 0, 180),
        Pos_WM = Vector(11, 2, -3),
        Ang_WM = Angle(0, -5, 0)
    },
    [3] = {
        PrintName = "Accessory",
        Category = {"acc", "acc_extmag_pistol", "acc_holster", "acc_brace"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [4] = {
        PrintName = "Bolt",
        Category = {"bolt_automatic"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [5] = {
        PrintName = "Trigger",
        Category = {"trigger_semi"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [6] = {
        PrintName = "Ammo",
        Category = {"ammo_pistol"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [7] = {
        PrintName = "Perk",
        Category = {"perk", "perk_melee", "perk_shooting", "perk_reload"},
        AttachSound = "tacrp/weapons/flashlight_on.wav",
        DetachSound = "tacrp/weapons/flashlight_off.wav",
    },
}

local function addsound(name, spath)
    sound.Add({
        name = name,
        channel = 16,
        volume = 1.0,
        sound = spath
    })
end

addsound("tacint_deagle.clip_in", path .. "de_clipin.wav")
addsound("tacint_deagle.clip_out", path .. "de_clipout.wav")
addsound("tacint_deagle.slide_back", path .. "slideback.wav")
addsound("tacint_deagle.slide_forward", path .. "slideforward.wav")
addsound("tacint_deagle.slide_shut", path .. "sliderelease.wav")

addsound("tacint_deagle.safety_switch", "tacrp/weapons/sphinx/safety_switch.wav")
