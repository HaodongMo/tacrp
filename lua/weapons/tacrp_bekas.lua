SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "Molot Bekas"
SWEP.Category = "Tactical RP (Arctic)"

// Tier 1
SWEP.Description = "Common hunting shotgun.\nRelatively accurate, but cannot fire rapidly."

SWEP.ViewModel = "models/weapons/tacint/v_bekas.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_bekas.mdl"

SWEP.Slot = 3

// "ballistics"

SWEP.Damage_Max = 100 / 8 // damage at minimum range
SWEP.Damage_Min = 100 / 12 // damage at maximum range
SWEP.Range_Min = 500 // distance for which to maintain maximum damage
SWEP.Range_Max = 3000 // distance at which we drop to minimum damage
SWEP.Penetration = 1 // units of metal this weapon can penetrate
SWEP.Num = 8

SWEP.MuzzleVelocity = 9000

SWEP.BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1.5,
    [HITGROUP_STOMACH] = 1.25,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 0.9,
    [HITGROUP_RIGHTLEG] = 0.9,
    [HITGROUP_GEAR] = 0.9
}

// misc. shooting

SWEP.Firemode = 1

SWEP.RPM = 70

SWEP.Spread = 0.015

SWEP.HipFireSpreadPenalty = 0
SWEP.MidAirSpreadPenalty = 0

SWEP.ScopedSpreadPenalty = 0

SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 1.5
SWEP.RecoilResetTime = 0.25 // time after you stop shooting for recoil to start dissipating
SWEP.RecoilDissipationRate = 1
SWEP.RecoilFirstShotMult = 1 // multiplier for the first shot's recoil amount

SWEP.RecoilVisualKick = 2
SWEP.RecoilVisualShake = 2

SWEP.RecoilKick = 15

SWEP.RecoilSpreadPenalty = 0.03 // extra spread per one unit of recoil

SWEP.CanBlindFire = true

// handling

SWEP.MoveSpeedMult = 0.8
SWEP.ShootingSpeedMult = 0.5
SWEP.SightedSpeedMult = 0.25
SWEP.MeleeSpeedMult = 0.5
SWEP.MeleeSpeedMultTime = 2

SWEP.AimDownSightsTime = 0.35
SWEP.SprintToFireTime = 0.35

// hold types

SWEP.HoldType = "ar2"
SWEP.HoldTypeSprint = "passive"
SWEP.HoldTypeBlindFire = false
SWEP.HoldTypeNPC = "shotgun"

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN

SWEP.PassiveAng = Angle(0, 0, 0)
SWEP.PassivePos = Vector(0, -2, -4)

SWEP.BlindFireAng = Angle(0, 5, 0)
SWEP.BlindFirePos = Vector(0, -2, -4)

SWEP.SprintAng = Angle(30, -15, 0)
SWEP.SprintPos = Vector(5, 0, -2)

SWEP.SightAng = Angle(-0.57, -0.6, 2)
SWEP.SightPos = Vector(-3.45, -5, -2.7)

SWEP.CorrectivePos = Vector(0.275, 0, -0.2)
SWEP.CorrectiveAng = Angle(1.21, 0.1, 0)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_BACK
SWEP.HolsterPos = Vector(5, 0, -6)
SWEP.HolsterAng = Angle(0, 0, 0)

// reload

SWEP.ClipSize = 6
SWEP.Ammo = "buckshot"
SWEP.ShotgunReload = true

SWEP.ReloadTimeMult = 1

// sounds

local path = "TacRP/weapons/bekas/"

SWEP.Sound_Shoot = "^" .. path .. "fire-1.wav"
SWEP.Sound_Shoot_Silenced = "TacRP/weapons/sg551/sg551_fire_silenced-1.wav"

SWEP.Vol_Shoot = 130
SWEP.ShootPitchVariance = 0 // amount to vary pitch by each shot

// effects

// the .qc attachment for the muzzle
SWEP.QCA_Muzzle = 1
SWEP.QCA_Eject = 2

SWEP.MuzzleEffect = "muzzleflash_shotgun"
SWEP.EjectEffect = 3
SWEP.EjectDelay = 0.5

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
    ["fire"] = {"shoot1", "shoot2"},
    ["blind_fire"] = {"blind_shoot1"},
    ["melee"] = {"melee1", "melee2"},
    ["reload"] = {"reload", "reload2"}
}

SWEP.ShootTimeMult = 0.75

// attachments

SWEP.Attachments = {
    [1] = {
        PrintName = "Optic",
        Category = "optic_cqb",
        Bone = "ValveBiped.bekas_rootbone",
        WMBone = "ValveBiped.Bip01_R_Hand",
        InstalledElements = {"sights"},
        AttachSound = "TacRP/weapons/optic_on.wav",
        DetachSound = "TacRP/weapons/optic_off.wav",
        VMScale = 0.75,
        Pos_VM = Vector(-2.75, 0, 8),
        Ang_VM = Angle(90, 0, 0),
        Pos_WM = Vector(11, 0.85, -7),
        Ang_WM = Angle(-25, 3.5, 180),
    },
    -- [2] = {
    --     PrintName = "Muzzle",
    --     Category = "silencer",
    --     Bone = "ValveBiped.bekas_rootbone",
    --     AttachSound = "TacRP/weapons/silencer_on.wav",
    --     DetachSound = "TacRP/weapons/silencer_off.wav",
    --     Pos_VM = Vector(-2.2, 0, 33),
    --     Pos_WM = Vector(23, 2.5, -2.8),
    --     Ang_VM = Angle(90, 0, 0),
    --     Ang_WM = Angle(0, -3.5, 180),
    -- },
    [2] = {
        PrintName = "Tactical",
        Category = "tactical",
        Bone = "ValveBiped.bekas_rootbone",
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
        InstalledElements = {"tactical"},
        VMScale = 1.25,
        Pos_VM = Vector(-1, -0.3, 24),
        Ang_VM = Angle(90, 0, -90),
        Pos_WM = Vector(25, 0, -12),
        Ang_WM = Angle(-25, 3.5, 90),
    },
    [3] = {
        PrintName = "Accessory",
        Category = {"perk", "perk_melee", "perk_shooting", "perk_reload", "perk_sling", "perk_duffle", "perk_extmag_shotgun"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [4] = {
        PrintName = "Bolt",
        Category = {"bolt_manual"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [5] = {
        PrintName = "Trigger",
        Category = {"trigger_manual", "trigger_pump"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [6] = {
        PrintName = "Ammo",
        Category = {"ammo_shotgun"},
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

addsound("TacInt_Bekas.Insertshell", path .. "insertshell-1.wav")
addsound("TacInt_Bekas.Movement", path .. "movement-1.wav")
addsound("TacInt_Bekas.PumpBack", path .. "pump_backward-1.wav")
addsound("TacInt_Bekas.PumpForward", path .. "pump_forward-1.wav")