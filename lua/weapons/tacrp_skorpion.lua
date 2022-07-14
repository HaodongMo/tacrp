SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "Skorpion vz. 61"
SWEP.Category = "Tactical RP (Arctic)"

SWEP.Description = "Common machine pistol with incredibly low recoil.\nCan only mount pistol optics due to top ejection port."

SWEP.ViewModel = "models/weapons/tacint/v_skorpion.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_skorpion.mdl"

SWEP.Slot = 2

// "ballistics"

SWEP.Damage_Max = 10
SWEP.Damage_Min = 5
SWEP.Range_Min = 800 // distance for which to maintain maximum damage
SWEP.Range_Max = 3000 // distance at which we drop to minimum damage
SWEP.Penetration = 2 // units of metal this weapon can penetrate

SWEP.MuzzleVelocity = 12500

// misc. shooting

SWEP.Firemodes = {
    2,
    1
}

SWEP.RPM = 850

SWEP.Spread = 0.01

SWEP.HipFireSpreadPenalty = 0.01

SWEP.ShootTimeMult = 0.5

SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 20
SWEP.RecoilResetTime = 0.1 // time after you stop shooting for recoil to start dissipating
SWEP.RecoilDissipationRate = 20
SWEP.RecoilFirstShotMult = 1 // multiplier for the first shot's recoil amount

SWEP.RecoilVisualKick = 0.4

SWEP.RecoilKick = 1

SWEP.RecoilSpreadPenalty = 0.001

SWEP.CanBlindFire = true

// handling

SWEP.MoveSpeedMult = 0.9
SWEP.ShootingSpeedMult = 0.75
SWEP.SightedSpeedMult = 0.4
SWEP.MeleeSpeedMult = 0.5
SWEP.MeleeSpeedMultTime = 2

SWEP.AimDownSightsTime = 0.275
SWEP.SprintToFireTime = 0.30

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

SWEP.CorrectivePos = Vector(1.2, 0, -0.4)
SWEP.CorrectiveAng = Angle(5.5, -2.7, 0)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_PISTOL
SWEP.HolsterPos = Vector(0, 3, -4)
SWEP.HolsterAng = Angle(90, 0, 0)

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

SWEP.Vol_Shoot = 130
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
        PrintName = "Optic",
        Category = "optic_pistol",
        Bone = "Skorpion_ROOT",
        WMBone = "Bone02",
        AttachSound = "tacrp/weapons/optic_on.wav",
        DetachSound = "tacrp/weapons/optic_off.wav",
        VMScale = 1.2,
        WMScale = 1.2,
        Pos_VM = Vector(4.6, 0, 0.5),
        Ang_VM = Angle(90, 0, 180),
        Pos_WM = Vector(1.5, 1.25, -4.3),
        Ang_WM = Angle(0, 0, 0),
    },
    [2] = {
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
    [3] = {
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
    [4] = {
        PrintName = "Accessory",
        Category = {"foldstock", "perk", "perk_melee", "perk_shooting", "perk_reload", "perk_extmag_smg", "perk_hollowpoints", "perk_conceal"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [5] = {
        PrintName = "Bolt",
        Category = {"bolt_automatic"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [6] = {
        PrintName = "Trigger",
        Category = {"trigger_auto"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [7] = {
        PrintName = "Ammo",
        Category = {"ammo_pistol"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    }
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