SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "Manurhin MR96"
SWEP.Category = "Tactical RP" // "Tactical RP (Arctic)"

SWEP.SubCatTier = "2Premium"
SWEP.SubCatType = "1Sidearm"

SWEP.Description = "Magnum revolver with good handling and stopping power. Accurate, but hard to fire rapidly."

SWEP.ViewModel = "models/weapons/tacint/v_mr96.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_mr96.mdl"

SWEP.Slot = 1

SWEP.ArcadeStats = {
    MoveSpeedMult = 1,
    ShootingSpeedMult = 0.75,
    SightedSpeedMult = 1,
    MeleeSpeedMult = 1,
    ReloadSpeedMult = 1,
}

// "ballistics"

SWEP.Damage_Max = 50 // damage at minimum range
SWEP.Damage_Min = 25 // damage at maximum range
SWEP.Range_Min = 400 // distance for which to maintain maximum damage
SWEP.Range_Max = 4000 // distance at which we drop to minimum damage
SWEP.Penetration = 6 // units of metal this weapon can penetrate

SWEP.MuzzleVelocity = 12500

SWEP.BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 2.5,
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

SWEP.FiremodeName = "Double-Action" // only used externally for firemode name distinction

SWEP.RPM = 150

SWEP.Spread = 0.001

SWEP.ShootTimeMult = 1



SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 2.5
SWEP.RecoilResetTime = 0.3
SWEP.RecoilDissipationRate = 3
SWEP.RecoilFirstShotMult = 0.75 // multiplier for the first shot's recoil amount

SWEP.RecoilVisualKick = 10

SWEP.RecoilKick = 9

SWEP.RecoilSpreadPenalty = 0.035

SWEP.CanBlindFire = true

// handling


SWEP.MoveSpeedMult = 0.9
SWEP.ShootingSpeedMult = 0.4
SWEP.SightedSpeedMult = 0.5

SWEP.ReloadSpeedMult = 0.75

SWEP.AimDownSightsTime = 0.22
SWEP.SprintToFireTime = 0.3

// hold types

SWEP.HoldType = "revolver"
SWEP.HoldTypeSprint = "normal"
SWEP.HoldTypeBlindFire = "pistol"

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_REVOLVER

SWEP.PassiveAng = Angle(0, 0, 0)
SWEP.PassivePos = Vector(0, -2, -4)

SWEP.BlindFireAng = Angle(0, 5, 0)
SWEP.BlindFirePos = Vector(3, -2, -5)

SWEP.BlindFireSuicideAng = Angle(-125, 0, 45)
SWEP.BlindFireSuicidePos = Vector(25, 12, -6)

SWEP.SprintAng = Angle(0, 30, 0)
SWEP.SprintPos = Vector(2, 0, -12)

SWEP.SightAng = Angle(-0.15, 1, 0)
SWEP.SightPos = Vector(-3.5, 0, -3.7)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_PISTOL
SWEP.HolsterPos = Vector(0, 3, -4)
SWEP.HolsterAng = Angle(90, 0, 0)

SWEP.Sway = 2
SWEP.ScopedSway = 1

// reload

SWEP.ClipSize = 6
SWEP.Ammo = "357"

SWEP.ReloadTimeMult = 1

// sounds

local path = "TacRP/weapons/mr96/"

SWEP.Sound_Shoot = {
    "^" .. path .. "mr96_fire-1.wav",
    "^" .. path .. "mr96_fire-2.wav",
    "^" .. path .. "mr96_fire-3.wav",
}

SWEP.Vol_Shoot = 130
SWEP.ShootPitchVariance = 2.5 // amount to vary pitch by each shot

// effects

// the .qc attachment for the muzzle
SWEP.QCA_Muzzle = 2
SWEP.QCA_Eject = 0
SWEP.EjectEffect = 0

SWEP.MuzzleEffect = "muzzleflash_1"

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
    ["fire_iron"] = "shoot1",
    ["blind_fire"] = {"blind_shoot1", "blind_shoot2"},
    ["melee"] = {"melee1", "melee2"},
    ["jam"] = "draw"
}

// attachments

SWEP.Attachments = {
    [1] = {
        PrintName = "Optic",
        Category = {"optic_cqb", "optic_medium"},
        Bone = "ValveBiped.mr96_rootbone",
        WMBone = "Box01",
        AttachSound = "TacRP/weapons/optic_on.wav",
        DetachSound = "TacRP/weapons/optic_off.wav",
        VMScale = 1,
        WMScale = 1,
        Pos_VM = Vector(-3.9, -0.125, 6.5),
        Ang_VM = Angle(90, 0, 0),
        Pos_WM = Vector(0, 1.5, -0.8),
        Ang_WM = Angle(0, -90, 0),
    },
    [2] = {
        PrintName = "Tactical",
        Category = "tactical",
        Bone = "ValveBiped.mr96_rootbone",
        WMBone = "Box01",
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
        VMScale = 1,
        WMScale = 1,
        Pos_VM = Vector(-2.25, -0.125, 9),
        Ang_VM = Angle(90, 0, 180),
        Pos_WM = Vector(0, 8, -2.25),
        Ang_WM = Angle(0, -90, 180),
    },
    [3] = {
        PrintName = "Accessory",
        Category = {"acc", "acc_holster", "acc_brace"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [6] = {
        PrintName = "Perk",
        Category = {"perk", "perk_melee", "perk_shooting", "perk_reload"},
        AttachSound = "tacrp/weapons/flashlight_on.wav",
        DetachSound = "tacrp/weapons/flashlight_off.wav",
    },
    [4] = {
        PrintName = "Trigger",
        Category = {"trigger_revolver"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [5] = {
        PrintName = "Ammo",
        Category = {"ammo_pistol", "ammo_roulette"},
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

addsound("TacInt_MR96.Release_Cylinder", path .. "mr96_release_cylinder.wav")
addsound("TacInt_MR96.Eject_Shells", path .. "mr96_eject_shells.wav")
addsound("TacInt_MR96.Insert_Bullets", path .. "mr96_insert_bullets.wav")
addsound("TacInt_MR96.Shut_Cylinder", path .. "mr96_shut_cylinder.wav")
addsound("TacInt_MR96.Insert_Bullets-Mid", path .. "mr96_insert_bullets-mid.wav")
addsound("TacInt_MR96.Cock_Hammer", path .. "mr96_cockhammer.wav")
addsound("TacInt_MR96.Deploy", path .. "mr96_deploy.wav")