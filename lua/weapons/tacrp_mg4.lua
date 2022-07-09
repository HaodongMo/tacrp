SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "HK MG4"
SWEP.Category = "Tactical RP (Arctic)"

SWEP.Description = "Elite light machine gun that offers huge volume of fire. Despite its name, it is a very heavy weapon."

SWEP.ViewModel = "models/weapons/tacint/v_mg4.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_mg4.mdl"

SWEP.Slot = 3

// "ballistics"

SWEP.Damage_Max = 25
SWEP.Damage_Min = 20
SWEP.Range_Min = 2000 // distance for which to maintain maximum damage
SWEP.Range_Max = 5000 // distance at which we drop to minimum damage
SWEP.Penetration = 14 // units of metal this weapon can penetrate

SWEP.MuzzleVelocity = 28500

// misc. shooting

SWEP.Firemodes = {
    2,
    1
}

SWEP.RPM = 750

SWEP.Spread = 0.01

SWEP.ShootTimeMult = 0.5

SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 50
SWEP.RecoilResetTime = 0.25
SWEP.RecoilDissipationRate = 50
SWEP.RecoilFirstShotMult = 1 // multiplier for the first shot's recoil amount

SWEP.RecoilVisualKick = 0.75

SWEP.RecoilKick = 2

SWEP.RecoilSpreadPenalty = 0.0005 // extra spread per one unit of recoil

SWEP.CanBlindFire = true

// handling

SWEP.MoveSpeedMult = 0.8
SWEP.ShootingSpeedMult = 0.25
SWEP.SightedSpeedMult = 0.25
SWEP.MeleeSpeedMult = 0.5
SWEP.MeleeSpeedMultTime = 2 // seconds to apply slow down for

SWEP.AimDownSightsTime = 0.5
SWEP.SprintToFireTime = 0.5 // multiplies how long it takes to recover from sprinting

// hold types

SWEP.HoldType = "ar2"
SWEP.HoldTypeSprint = "passive"
SWEP.HoldTypeBlindFire = false

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.PassiveAng = Angle(0, 0, 0)
SWEP.PassivePos = Vector(0, -4, -5)

SWEP.BlindFireAng = Angle(0, 5, 0)
SWEP.BlindFirePos = Vector(0, -4, -3)

SWEP.SprintAng = Angle(30, -15, 0)
SWEP.SprintPos = Vector(5, 0, -2)

SWEP.SightAng = Angle(-0.11, -0.6, 0)
SWEP.SightPos = Vector(-4.55, -7.5, -3.7)

SWEP.CorrectivePos = Vector(0.025, 0, 0.125)
SWEP.CorrectiveAng = Angle(0, 0, 0)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_BACK
SWEP.HolsterPos = Vector(5, 0, -6)
SWEP.HolsterAng = Angle(0, 0, 0)

// sway

SWEP.Sway = 5
SWEP.ScopedSway = 0.5

// reload

SWEP.ClipSize = 100
SWEP.Ammo = "ar2"

SWEP.ReloadTimeMult = 1
SWEP.DropMagazineModel = "models/weapons/tacint/magazines/mg4.mdl"
SWEP.DropMagazineImpact = "metal"

SWEP.BulletBodygroups = {
    [1] = {5, 0},
    [2] = {5, 1},
    [3] = {5, 2},
    [4] = {5, 3},
    [5] = {5, 4},
    [6] = {5, 5},
    [7] = {5, 6},
}
SWEP.DefaultBodygroups = "000007"

// sounds

local path = "TacRP/weapons/mg4/"

SWEP.Sound_Shoot = "^" .. path .. "fire-1.wav"
SWEP.Sound_Shoot_Silenced = "TacRP/weapons/g36k/g36k_fire_silenced-1.wav"

SWEP.Vol_Shoot = 130
SWEP.ShootPitchVariance = 2.5 // amount to vary pitch by each shot

// effects

// the .qc attachment for the muzzle
SWEP.QCA_Muzzle = 1
// ditto for shell
SWEP.QCA_Eject = 2

SWEP.MuzzleEffect = "muzzleflash_minimi"
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
    ["fire_iron"] = {"fire4_M", "fire3_M", "fire2_M", "fire1_M"},
    ["fire1"] = "fire1_L",
    ["fire2"] = "fire2_L",
    ["fire3"] = "fire3_L",
    ["fire4"] = "fire4_L",
    ["fire5"] = "fire5_L",
    ["melee"] = {"melee1", "melee2"}
}

// attachments

SWEP.AttachmentElements = {
    ["sights"] = {
        BGs_VM = {
            {1, 1}
        },
        BGs_WM = {
            {1, 1}
        },
    },
    ["extendedbelt"] = {
        BGs_VM = {
            {2, 1}
        },
    }
}

//ValveBiped.MG4_root

SWEP.Attachments = {
    [1] = {
        PrintName = "Optic",
        Category = {"optic_cqb", "optic_medium"},
        Bone = "ValveBiped.feed_cover",
        InstalledElements = {"sights"},
        AttachSound = "TacRP/weapons/optic_on.wav",
        DetachSound = "TacRP/weapons/optic_off.wav",
        VMScale = 1.1,
        Pos_VM = Vector(-0.75, 0, -3),
        Pos_WM = Vector(8, 1.15, -7),
        Ang_VM = Angle(90, 0, 0),
        Ang_WM = Angle(0, 0, 180),
    },
    [2] = {
        PrintName = "Muzzle",
        Category = "silencer",
        Bone = "ValveBiped.MG4_root",
        AttachSound = "TacRP/weapons/silencer_on.wav",
        DetachSound = "TacRP/weapons/silencer_off.wav",
        Pos_VM = Vector(-5.5, 0, 32),
        Pos_WM = Vector(33, 1.15, -5.75),
        Ang_VM = Angle(90, 0, 0),
        Ang_WM = Angle(0, 0, 180),
    },
    [3] = {
        PrintName = "Tactical",
        Category = "tactical",
        Bone = "ValveBiped.MG4_root",
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
        InstalledElements = {"tactical"},
        Pos_VM = Vector(-5.225, -0.9, 19),
        Pos_WM = Vector(21.5, 2, -5.25),
        Ang_VM = Angle(90, 0, -90),
        Ang_WM = Angle(0, 0, 90),
    },
    [4] = {
        PrintName = "Accessory",
        Category = {"perk", "perk_melee", "perk_shooting", "perk_reload", "extendedbelt", "perk_duffle"},
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
        Category = {"ammo_rifle"},
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

addsound("TacInt_mg4.Clip_Out", path .. "clip_out-1.wav")
addsound("TacInt_mg4.Clip_In", path .. "clip_in-1.wav")
addsound("TacInt_mg4.bolt_release", path .. "bolt_release-1.wav")
addsound("TacInt_mg4.bolt_back", path .. "bolt_back-1.wav")
addsound("TacInt_mg4.bolt_forward", path .. "bolt_forward-1.wav")
addsound("TacInt_mg4.feedcover_close", path .. "feed_cover_close-1.wav")
addsound("TacInt_mg4.feedcover_open", path .. "feed_cover_open-1.wav")
addsound("TacInt_mg4.insertbullets", path .. "insert_bullets-1.wav")
addsound("TacInt_mg4.deploy", path .. "deploy-1.wav")