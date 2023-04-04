SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "FN P90"
SWEP.Category = "Tactical RP" // "Tactical RP (Arctic)"

SWEP.SubCatTier = "2Premium"
SWEP.SubCatType = "3Submachine Gun"

SWEP.Description = "Bullpup personal defense weapon with a generous top-loaded magazine. High velocity rounds retain effectiveness at range."

SWEP.ViewModel = "models/weapons/tacint/v_p90.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_p90.mdl"

SWEP.Slot = 2

SWEP.BalanceStats = {
    [TacRP.BALANCE_SBOX] = {
        Damage_Max = 15,
        Damage_Min = 13,

        MoveSpeedMult = 0.9,
        ShootingSpeedMult = 0.8,
        SightedSpeedMult = 0.85,
        MeleeSpeedMult = 1,
        ReloadSpeedMult = 1,
    },
    [TacRP.BALANCE_TTT] = {
        Damage_Max = 8,
        Damage_Min = 5,

        Range_Min = 900,
        Range_Max = 3000,

        BodyDamageMultipliers = {
            [HITGROUP_HEAD] = 2,
            [HITGROUP_CHEST] = 1,
            [HITGROUP_STOMACH] = 1,
            [HITGROUP_LEFTARM] = 1,
            [HITGROUP_RIGHTARM] = 1,
            [HITGROUP_LEFTLEG] = 0.75,
            [HITGROUP_RIGHTLEG] = 0.75,
            [HITGROUP_GEAR] = 0.9
        },

        ReloadTimeMult = 1.25,

        MoveSpeedMult = 0.95,
        ShootingSpeedMult = 0.85,
        MeleeSpeedMult = 1,
        SightedSpeedMult = 0.6,
        ReloadSpeedMult = 0.7,
    },
}

// "ballistics"

SWEP.Damage_Max = 15
SWEP.Damage_Min = 13
SWEP.Range_Min = 2000 // distance for which to maintain maximum damage
SWEP.Range_Max = 5000 // distance at which we drop to minimum damage
SWEP.Penetration = 10 // units of metal this weapon can penetrate


SWEP.BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1.25,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 0.9,
    [HITGROUP_RIGHTLEG] = 0.9,
    [HITGROUP_GEAR] = 0.9
}

SWEP.MuzzleVelocity = 22500

// misc. shooting

SWEP.Firemodes = {
    2,
    1
}

SWEP.RPM = 850

SWEP.Spread = 0.008

SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 25
SWEP.RecoilResetTime = 0.2
SWEP.RecoilDissipationRate = 30
SWEP.RecoilFirstShotMult = 1

SWEP.RecoilVisualKick = 0.5

SWEP.RecoilKick = 1

SWEP.RecoilSpreadPenalty = 0.001

SWEP.CanBlindFire = true

// handling

SWEP.MoveSpeedMult = 0.85
SWEP.ShootingSpeedMult = 0.5
SWEP.SightedSpeedMult = 0.4

SWEP.ReloadSpeedMult = 0.5

SWEP.AimDownSightsTime = 0.35
SWEP.SprintToFireTime = 0.375

// hold types

SWEP.HoldType = "smg"
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

SWEP.SightAng = Angle(0.01, 0, 0)
SWEP.SightPos = Vector(-3.705, -15, -4.6)

SWEP.CorrectivePos = Vector(0.02, 0, 0.1)
SWEP.CorrectiveAng = Angle(0, 0, 0)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_BACK
SWEP.HolsterPos = Vector(5, 6, -6)
SWEP.HolsterAng = Angle(0, 0, 0)

// reload

SWEP.ClipSize = 50
SWEP.Ammo = "smg1"

SWEP.ReloadTimeMult = 1
SWEP.DropMagazineModel = "models/weapons/tacint/magazines/p90.mdl"
SWEP.DropMagazineImpact = "plastic"

// sounds

local path = "tacrp/weapons/p90/"

SWEP.Sound_Shoot = "^" .. path .. "fire-1.wav"
SWEP.Sound_Shoot_Silenced = path .. "fire_silenced-1.wav"

SWEP.Vol_Shoot = 130
SWEP.ShootPitchVariance = 2.5 // amount to vary pitch by each shot

// effects

// the .qc attachment for the muzzle
SWEP.QCA_Muzzle = 1
// ditto for shell
SWEP.QCA_Eject = 2

SWEP.MuzzleEffect = "muzzleflash_smg"
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
    ["fire_iron"] = "dryfire",
    ["fire1"] = "fire1_M",
    ["fire2"] = "fire2_M",
    ["fire3"] = "fire3_M",
    ["fire4"] = "fire4_M",
    ["fire5"] = "fire5_M",
    ["melee"] = {"melee1", "melee2"}
}

// attachments

SWEP.AttachmentElements = {
    ["optic"] = {
        BGs_VM = {
            {1, 1}
        },
    },
}

SWEP.Attachments = {
    [1] = {
        PrintName = "Optic",
        Category = {"optic_cqb", "optic_medium", "optic_sniper"},
        Bone = "p90_ROOT",
        AttachSound = "tacrp/weapons/optic_on.wav",
        DetachSound = "tacrp/weapons/optic_off.wav",
        InstalledElements = {"optic"},
        Pos_VM = Vector(-5.2, 0, 6.5),
        Pos_WM = Vector(8, 1.5, -7),
        Ang_VM = Angle(90, 0, 0),
        Ang_WM = Angle(0, -3.5, 180),
    },
    [2] = {
        PrintName = "Muzzle",
        Category = "silencer",
        Bone = "p90_ROOT",
        AttachSound = "tacrp/weapons/silencer_on.wav",
        DetachSound = "tacrp/weapons/silencer_off.wav",
        Pos_VM = Vector(-1.85, 0, 14),
        Pos_WM = Vector(16, 2.25, -3.5),
        Ang_VM = Angle(90, 0, 0),
        Ang_WM = Angle(0, -3.5, 180),
    },
    [3] = {
        PrintName = "Tactical",
        Category = "tactical",
        Bone = "p90_ROOT",
        AttachSound = "tacrp/weapons/flashlight_on.wav",
        DetachSound = "tacrp/weapons/flashlight_off.wav",
        InstalledElements = {"rail"},
        Pos_VM = Vector(-4.35, -0.6, 7.6),
        Pos_WM = Vector(10, 1.3, -4),
        Ang_VM = Angle(90, 0, -90),
        Ang_WM = Angle(0, -3.5, -90),
    },
    [4] = {
        PrintName = "Accessory",
        Category = {"acc", "acc_sling", "acc_duffle", "acc_extmag_smg"},
        AttachSound = "tacrp/weapons/flashlight_on.wav",
        DetachSound = "tacrp/weapons/flashlight_off.wav",
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
    },
    [8] = {
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

addsound("tacint_p90.Clip_Out", path .. "clip_out.wav")
addsound("tacint_p90.Clip_In", path .. "clip_in.wav")
addsound("tacint_p90.Clip_slap", path .. "clip_slap.wav")
addsound("tacint_p90.bolt_release", path .. "bolt_release.wav")
addsound("tacint_p90.bolt_back", path .. "bolt_back.wav")
addsound("tacint_p90.bolt_forward", path .. "bolt_forward.wav")
addsound("tacint_p90.fire_select", path .. "fire_select.wav")
addsound("tacint_p90.mag_release", path .. "mag_release.wav")