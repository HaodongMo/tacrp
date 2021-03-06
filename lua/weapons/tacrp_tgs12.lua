SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "TGS-12"
SWEP.Category = "Tactical RP (Arctic)"

SWEP.Description = "Economic pistol grip shotgun with high recoil and mobility."

SWEP.ViewModel = "models/weapons/tacint/v_tgs12_2.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_tgs12.mdl"

SWEP.Slot = 3

// "ballistics"

SWEP.Damage_Max = 100 / 7 // damage at minimum range
SWEP.Damage_Min = 100 / 10 // damage at maximum range
SWEP.Range_Min = 600 // distance for which to maintain maximum damage
SWEP.Range_Max = 3000 // distance at which we drop to minimum damage
SWEP.Penetration = 1 // units of metal this weapon can penetrate
SWEP.Num = 8

SWEP.MuzzleVelocity = 9000

SWEP.BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 1,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 0.9,
    [HITGROUP_RIGHTLEG] = 0.9,
    [HITGROUP_GEAR] = 0.9
}

// misc. shooting

SWEP.Firemode = 1

SWEP.RPM = 70

SWEP.Spread = 0.025

SWEP.ShootTimeMult = 0.9

SWEP.HipFireSpreadPenalty = 0
SWEP.MidAirSpreadPenalty = 0

SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 2
SWEP.RecoilResetTime = 0.2
SWEP.RecoilDissipationRate = 1.1
SWEP.RecoilFirstShotMult = 1 // multiplier for the first shot's recoil amount

SWEP.RecoilVisualKick = 4
SWEP.RecoilVisualShake = 2

SWEP.RecoilKick = 30

SWEP.RecoilSpreadPenalty = 0.015

SWEP.CanBlindFire = true

// handling

SWEP.MoveSpeedMult = 0.85
SWEP.ShootingSpeedMult = 0.6
SWEP.SightedSpeedMult = 0.35
SWEP.MeleeSpeedMult = 0.5
SWEP.MeleeSpeedMultTime = 2

SWEP.AimDownSightsTime = 0.25
SWEP.SprintToFireTime = 0.3

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

SWEP.SightAng = Angle(-0.2, 0, 0)
SWEP.SightPos = Vector(-2.98, -3, -2.9)

SWEP.CorrectivePos = Vector(0.09, 0, 0.05)
SWEP.CorrectiveAng = Angle(0.25, -0.05, 0)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_BACK
SWEP.HolsterPos = Vector(4, -8, -6)
SWEP.HolsterAng = Angle(0, 0, 0)

// reload

SWEP.ClipSize = 6
SWEP.Ammo = "buckshot"
SWEP.ShotgunReload = true

SWEP.ReloadTimeMult = 1

// sounds

local path = "tacrp/weapons/tgs12/"

SWEP.Sound_Shoot = "^" .. path .. "fire-1.wav"
SWEP.Sound_Shoot_Silenced = "tacrp/weapons/sg551/sg551_fire_silenced-1.wav"

SWEP.Vol_Shoot = 110
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

SWEP.AttachmentElements = {
    ["sights"] = {
        BGs_VM = {
            {5, 1}
        },
    },
}

// attachments

SWEP.Attachments = {
    [1] = {
        PrintName = "Optic",
        Category = "optic_cqb",
        Bone = "ValveBiped._ROOT_TGS12",
        InstalledElements = {"sights"},
        AttachSound = "tacrp/weapons/optic_on.wav",
        DetachSound = "tacrp/weapons/optic_off.wav",
        VMScale = 0.75,
        Pos_VM = Vector(5.25, 0, 6),
        Pos_WM = Vector(9, 1.5, -5.5),
        Ang_VM = Angle(-90, 180, 0),
        Ang_WM = Angle(0, 0, 180),
    },
    -- [2] = {
    --     PrintName = "Muzzle",
    --     Category = "silencer",
    --     Bone = "ValveBiped._ROOT_TGS12",
    --     AttachSound = "tacint/weapons/silencer_on.wav",
    --     DetachSound = "tacint/weapons/silencer_off.wav",
    --     Pos_VM = Vector(-2.2, 0, 33),
    --     Pos_WM = Vector(23, 2.5, -2.8),
    --     Ang_VM = Angle(90, 0, 0),
    --     Ang_WM = Angle(0, -3.5, 180),
    -- },
    [2] = {
        PrintName = "Tactical",
        Category = "tactical",
        Bone = "ValveBiped._ROOT_TGS12",
        AttachSound = "tacrp/weapons/flashlight_on.wav",
        DetachSound = "tacrp/weapons/flashlight_off.wav",
        InstalledElements = {"tactical"},
        VMScale = 1.25,
        Pos_VM = Vector(4, 0.25, 22),
        Pos_WM = Vector(20, 1.5, -4.5),
        Ang_VM = Angle(-90, 180, -90),
        Ang_WM = Angle(0, 0, 90),
    },
    [3] = {
        PrintName = "Accessory",
        Category = {"perk", "perk_melee", "perk_shooting", "perk_reload", "perk_duffle", "perk_extmag_shotgun"},
        AttachSound = "tacrp/weapons/flashlight_on.wav",
        DetachSound = "tacrp/weapons/flashlight_off.wav",
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

addsound("tacint_fp6.Insertshell",
    {
        "tacrp/weapons/fp6/fp6_insertshell-1.wav",
        "tacrp/weapons/fp6/fp6_insertshell-2.wav",
        "tacrp/weapons/fp6/fp6_insertshell-3.wav",
    }
)
addsound("tacint_Bekas.Insertshell", "tacrp/weapons/bekas/insertshell-1.wav")
addsound("tacint_Bekas.Movement", "tacrp/weapons/bekas/movement-1.wav")
addsound("tacint_tgs12.PumpBack", path .. "pump_backward-1.wav")
addsound("tacint_tgs12.PumpForward", path .. "pump_forward-1.wav")