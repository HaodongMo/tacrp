SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "Skorpion vz. 61"
SWEP.Category = "Tactical RP (Arctic)"

SWEP.Description = "Lightweight machine pistol."

SWEP.ViewModel = "models/weapons/tacint/v_skorpion.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_skorpion.mdl"

SWEP.Slot = 2

// "ballistics"

SWEP.Damage_Max = 100 / 4 // damage at minimum range
SWEP.Damage_Min = 100 / 7 // damage at maximum range
SWEP.Range_Min = 1500 // distance for which to maintain maximum damage
SWEP.Range_Max = 4000 // distance at which we drop to minimum damage
SWEP.Penetration = 2 // units of metal this weapon can penetrate

SWEP.MuzzleVelocity = 12500

// misc. shooting

SWEP.Firemodes = {
    2,
    1
}

SWEP.RPM = 700

SWEP.Spread = 0.012

SWEP.ShootSpeedMult = 0.5

// Spread penalties are in spread units and are additive
SWEP.MoveSpreadPenalty = 0.0 // spread penalty while travelling at max. 250 u/s
SWEP.MidAirSpreadPenalty = 0.0 // spread penalty for being in the air
SWEP.HipFireSpreadPenalty = 0.0 // spread penalty for not being scoped in
SWEP.ScopedSpreadPenalty = 0
SWEP.BlindFireSpreadPenalty = 0.0 // spread penalty for blind firing
SWEP.CrouchSpreadPenalty = 0

SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 10
SWEP.RecoilResetTime = 0.1// time after you stop shooting for recoil to start dissipating
SWEP.RecoilDissipationRate = 10
SWEP.RecoilFirstShotMult = 1 // multiplier for the first shot's recoil amount

SWEP.RecoilVisualKick = 0.4

SWEP.RecoilKick = 1.25

SWEP.RecoilSpreadPenalty = 0.0003 // extra spread per one unit of recoil

SWEP.CanBlindFire = true

// handling

SWEP.MoveSpeedMult = 0.95
SWEP.ShootingSpeedMult = 1 // slow down applied while shooting
SWEP.SightedSpeedMult = 0.5
SWEP.MeleeSpeedMult = 0.5
SWEP.MeleeSpeedMultTime = 2 // seconds to apply slow down for

SWEP.AimDownSightsTime = 0.275
SWEP.SprintToFireTime = 0.30 // multiplies how long it takes to recover from sprinting

// hold types

SWEP.HoldType = "revolver"
SWEP.HoldTypeSprint = "normal"
SWEP.HoldTypeBlindFire = "pistol"

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.PassiveAng = Angle(-2.5, -1, 0)
SWEP.PassivePos = Vector(0, -2, -4)

SWEP.BlindFireAng = Angle(0, 5, 0)
SWEP.BlindFirePos = Vector(0, -2, -4)

SWEP.SprintAng = Angle(30, -15, 0)
SWEP.SprintPos = Vector(5, 0, -2)

SWEP.SightAng = Angle(-4.26, -1.025, 1)
SWEP.SightPos = Vector(-5.2, -5, -2.4)

SWEP.Sway = 2
SWEP.ScopedSway = 0.25

// reload

SWEP.ClipSize = 25
SWEP.Ammo = "pistol"

SWEP.ReloadTimeMult = 1
SWEP.DropMagazineModel = "models/weapons/tacint/magazines/skorpion.mdl"
SWEP.DropMagazineImpact = "pistol"

// sounds

local path = "TacRP/weapons/skorpion/"

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
    ["fire_iron"] = "fire2_M",
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
            {3, 1}
        },
    },
    ["smallmag"] = {
        BGs_VM = {
            {2, 1}
        },
        BGs_WM = {
            {2, 1}
        }
    },
}

SWEP.Attachments = {
    [1] = {
        PrintName = "Muzzle",
        Category = "silencer",
        Bone = "Skorpion_ROOT",
        WMBone = "Bone02",
        AttachSound = "TacRP/weapons/silencer_on.wav",
        DetachSound = "TacRP/weapons/silencer_off.wav",
        VMScale = 0.75,
        WMScale = 0.75,
        Pos_VM = Vector(3.75, 0, 15),
        Ang_VM = Angle(90, 0, 180),
        Pos_WM = Vector(1.5, 1.25, -4.3),
        Ang_WM = Angle(0, 0, 0),
    },
    [2] = {
        PrintName = "Tactical",
        Category = "tactical",
        Bone = "Skorpion_ROOT",
        WMBone = "Bone02",
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
        VMScale = 0.75,
        WMScale = 0.75,
        Pos_VM = Vector(3, 0, 8),
        Ang_VM = Angle(90, 0, 0),
        Pos_WM = Vector(-4, 1.25, -3.5),
        Ang_WM = Angle(0, 0, 0),
    },
    [3] = {
        PrintName = "Accessory",
        Category = {"foldstock", "perk", "perk_melee", "perk_shooting", "perk_reload", "perk_hollowpoints"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
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

addsound("TacInt_Skorpion.Clip_Out", path .. "clip_out-1.wav")
addsound("TacInt_Skorpion.Clip_In", path .. "clip_in-1.wav")
addsound("TacInt_Skorpion.bolt_action", path .. "bolt_action-1.wav")

addsound("TacInt_pdw.fire_select", "TacRP/weapons/pdw/fire_select-1.wav")