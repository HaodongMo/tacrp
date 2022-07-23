SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "Manurhin MR96"
SWEP.Category = "Tactical RP (Arctic)"

// Tier 3
SWEP.Description = "Premium revolver with high recoil and incredible stopping power.\nDoes increased damage to the head and upper chest."

SWEP.ViewModel = "models/weapons/tacint/v_mr96.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_mr96.mdl"

SWEP.Slot = 2

// "ballistics"

SWEP.Damage_Max = 100 / 2 // damage at minimum range
SWEP.Damage_Min = 100 / 4 // damage at maximum range
SWEP.Range_Min = 1000 // distance for which to maintain maximum damage
SWEP.Range_Max = 4000 // distance at which we drop to minimum damage
SWEP.Penetration = 6 // units of metal this weapon can penetrate

SWEP.MuzzleVelocity = 12000

SWEP.BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 2.5,
    [HITGROUP_CHEST] = 1.25,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 0.8,
    [HITGROUP_RIGHTLEG] = 0.8,
    [HITGROUP_GEAR] = 0.9
}

// misc. shooting

SWEP.Firemode = 1

SWEP.RPM = 180

SWEP.Spread = 0.001

SWEP.ShootTimeMult = 1



SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 3
SWEP.RecoilResetTime = 0.4
SWEP.RecoilDissipationRate = 5
SWEP.RecoilFirstShotMult = 1 // multiplier for the first shot's recoil amount

SWEP.RecoilVisualKick = 10

SWEP.RecoilKick = 12.5

SWEP.RecoilSpreadPenalty = 0.015 // extra spread per one unit of recoil

SWEP.CanBlindFire = true

// handling


SWEP.MoveSpeedMult = 0.9
SWEP.ShootingSpeedMult = 0.4
SWEP.SightedSpeedMult = 0.5
SWEP.MeleeSpeedMult = 0.5
SWEP.MeleeSpeedMultTime = 2

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
SWEP.BlindFirePos = Vector(0, -2, -4)

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
    ["melee"] = {"melee1", "melee2"}
}

// attachments

SWEP.Attachments = {
    [1] = {
        PrintName = "Optic",
        Category = "optic_pistol",
        Bone = "ValveBiped.mr96_rootbone",
        WMBone = "Box01",
        AttachSound = "TacRP/weapons/optic_on.wav",
        DetachSound = "TacRP/weapons/optic_off.wav",
        VMScale = 1.25,
        WMScale = 1.25,
        Pos_VM = Vector(-3.5, -0.125, 4),
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
        Category = {"perk", "perk_melee", "perk_shooting", "perk_reload", "perk_conceal"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [4] = {
        PrintName = "Trigger",
        Category = {"trigger_revolver"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [5] = {
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

addsound("TacInt_MR96.Release_Cylinder", path .. "mr96_release_cylinder.wav")
addsound("TacInt_MR96.Eject_Shells", path .. "mr96_eject_shells.wav")
addsound("TacInt_MR96.Insert_Bullets", path .. "mr96_insert_bullets.wav")
addsound("TacInt_MR96.Shut_Cylinder", path .. "mr96_shut_cylinder.wav")
addsound("TacInt_MR96.Insert_Bullets-Mid", path .. "mr96_insert_bullets-mid.wav")
addsound("TacInt_MR96.Cock_Hammer", path .. "mr96_cockhammer.wav")
addsound("TacInt_MR96.Deploy", path .. "mr96_deploy.wav")