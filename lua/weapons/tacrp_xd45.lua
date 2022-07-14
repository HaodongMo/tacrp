SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "Springfield XD-45"
SWEP.Category = "Tactical RP (Arctic)"

SWEP.Description = "Elite, fully automatic machine pistol with incredible close range power."

SWEP.ViewModel = "models/weapons/tacint/v_xd45.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_xd45.mdl"

SWEP.Slot = 2

// "ballistics"

SWEP.Damage_Max = 30
SWEP.Damage_Min = 10
SWEP.Range_Min = 500
SWEP.Range_Max = 3000
SWEP.Penetration = 4

SWEP.MuzzleVelocity = 9000

SWEP.BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 0.75,
    [HITGROUP_RIGHTLEG] = 0.75,
    [HITGROUP_GEAR] = 0.9
}

// misc. shooting

SWEP.Firemodes = {2, 1}

SWEP.RPM = 850

SWEP.Spread = 0.001

SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 8
SWEP.RecoilResetTime = 0.15 // time after you stop shooting for recoil to start dissipating
SWEP.RecoilDissipationRate = 24
SWEP.RecoilFirstShotMult = 1 // multiplier for the first shot's recoil amount

SWEP.RecoilVisualKick = 1.5

SWEP.RecoilKick = 6

SWEP.RecoilSpreadPenalty = 0.0025

SWEP.CanBlindFire = true

// handling

SWEP.MoveSpeedMult = 0.9
SWEP.ShootingSpeedMult = 0.5
SWEP.SightedSpeedMult = 0.5
SWEP.MeleeSpeedMult = 0.5
SWEP.MeleeSpeedMultTime = 2

SWEP.AimDownSightsTime = 0.25
SWEP.SprintToFireTime = 0.25

// hold types

SWEP.HoldType = "revolver"
SWEP.HoldTypeSprint = "normal"
SWEP.HoldTypeBlindFire = false

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_PISTOL

SWEP.PassiveAng = Angle(0, 0, 0)
SWEP.PassivePos = Vector(0, -2, -5)

SWEP.BlindFireAng = Angle(0, 5, 0)
SWEP.BlindFirePos = Vector(0, -2, -5)

SWEP.SprintAng = Angle(0, 30, 0)
SWEP.SprintPos = Vector(2, 0, -12)

SWEP.SightAng = Angle(-0.05, 0.12, 0)
SWEP.SightPos = Vector(-3.4, 1, -3.5)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_PISTOL
SWEP.HolsterPos = Vector(0, 3, -4)
SWEP.HolsterAng = Angle(90, 0, 0)

// reload

SWEP.ClipSize = 20
SWEP.Ammo = "pistol"

SWEP.ReloadTimeMult = 1

SWEP.DropMagazineModel = "models/weapons/tacint/magazines/p250.mdl"
SWEP.DropMagazineImpact = "pistol"

// sounds

local path = "tacrp/weapons/xd45/"

SWEP.Sound_Shoot = "^" .. path .. "fire-1.wav"
SWEP.Sound_Shoot_Silenced = "tacrp/weapons/vertec/vertec_fire_silenced-1.wav"

SWEP.Vol_Shoot = 110
SWEP.ShootPitchVariance = 2.5 // amount to vary pitch by each shot

// effects

// the .qc attachment for the muzzle
SWEP.QCA_Muzzle = 1

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
        Category = "optic_pistol",
        Bone = "xd45_rig.slide",
        WMBone = "Box01",
        AttachSound = "tacrp/weapons/optic_on.wav",
        DetachSound = "tacrp/weapons/optic_off.wav",
        VMScale = 1,
        WMScale = 1,
        Pos_VM = Vector(0, -0.5, 0.5),
        Ang_VM = Angle(0, -90, 0),
        Pos_WM = Vector(0, -1, -1),
        Ang_WM = Angle(0, -90, 0),
    },
    [2] = {
        PrintName = "Muzzle",
        Category = {"silencer", "pistol_muzzle"},
        Bone = "xd45_rig.barrel",
        WMBone = "Box01",
        AttachSound = "tacrp/weapons/silencer_on.wav",
        DetachSound = "tacrp/weapons/silencer_off.wav",
        VMScale = 0.5,
        WMScale = 0.5,
        Pos_VM = Vector(-0.5, 0, 7),
        Ang_VM = Angle(90, 0, 0),
        Pos_WM = Vector(0, 8, -1.5),
        Ang_WM = Angle(0, -90, 0),
    },
    [3] = {
        PrintName = "Tactical",
        Category = "tactical",
        Bone = "xd45_rig.xd45_ROOT",
        WMBone = "Box01",
        AttachSound = "tacrp/weapons/flashlight_on.wav",
        DetachSound = "tacrp/weapons/flashlight_off.wav",
        VMScale = 1.1,
        WMScale = 1.3,
        Pos_VM = Vector(-2, 0, 6.5),
        Ang_VM = Angle(90, 0, 180),
        Pos_WM = Vector(0, 5, -2.75),
        Ang_WM = Angle(0, -90, 180),
    },
    [4] = {
        PrintName = "Accessory",
        Category = {"perk", "perk_melee", "perk_shooting", "perk_reload", "perk_extmag_pistol", "perk_conceal"},
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

addsound("tacint_xd45.clip_in", path .. "clip_in-1.wav")
addsound("tacint_xd45.clip_out", path .. "clip_out-1.wav")
addsound("tacint_xd45.clip_slap", path .. "clip_slap-1.wav")
addsound("tacint_xd45.slide_back", {
    path .. "slide_back-1.wav",
    path .. "slide_back-2.wav",
})
addsound("tacint_xd45.slide_forward", path .. "slide_forward-1.wav")
addsound("tacint_xd45.slide_shut", {
    path .. "slide_shut-1.wav",
    path .. "slide_shut-2.wav",
    path .. "slide_shut-3.wav",
})
addsound("tacint_xd45.cock_hammer", path .. "cockhammer.wav")
addsound("tacint_xd45.safety_switch", path .. "safety_switch.wav")
