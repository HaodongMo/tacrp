SWEP.Base = "tacrp_mp5"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "HK HK94"
SWEP.Category = "Tactical RP"

SWEP.SubCatTier = "4Consumer"
SWEP.SubCatType = "5Sporter Carbine"

SWEP.Description = "Semi-automatic model of a legendary submachine gun.\nUses reduced capacity magazines."

SWEP.ViewModel = "models/weapons/tacint/v_hk94.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_mp5.mdl"

SWEP.Slot = 2


SWEP.BalanceStats = {
    [TacRP.BALANCE_SBOX] = {
        Description = "Semi-automatic model of a legendary submachine gun. Fine tuned for precision shooting.",

        Damage_Max = 15,
        Damage_Min = 7,

        Recoil_Kick = 1,
        Spread = 0.001,

        MoveSpeedMult = 0.9,
        ShootingSpeedMult = 0.8,
        SightedSpeedMult = 0.85,
        MeleeSpeedMult = 1,
        ReloadSpeedMult = 1,
    },
    [TacRP.BALANCE_TTT] = {
        Description = "Semi-automatic model of a legendary submachine gun. Fine tuned for precision shooting.",

        Damage_Max = 15,
        Damage_Min = 8,

        RPM = 420,

        RecoilResetTime = 0.125,
        RecoilDissipationRate = 6,
        RecoilSpreadPenalty = 0.003,
        HipFireSpreadPenalty = 0.04,

        BodyDamageMultipliers = {
            [HITGROUP_HEAD] = 3,
            [HITGROUP_CHEST] = 1.25,
            [HITGROUP_STOMACH] = 1,
            [HITGROUP_LEFTARM] = 1,
            [HITGROUP_RIGHTARM] = 1,
            [HITGROUP_LEFTLEG] = 0.75,
            [HITGROUP_RIGHTLEG] = 0.75,
            [HITGROUP_GEAR] = 0.9
        },

        ReloadTimeMult = 1,

        MoveSpeedMult = 0.95,
        ShootingSpeedMult = 0.85,
        MeleeSpeedMult = 1,
        SightedSpeedMult = 0.6,
        ReloadSpeedMult = 0.7,
    },
    [TacRP.BALANCE_PVE] = {
        Description = "Semi-automatic carbine variant of a legendary submachine gun. Fine tuned for precision shooting.",

        Damage_Max = 11,
        Damage_Min = 6,
        RPM = 360,

        ClipSize = 15,

        Spread = 0.004,
        RecoilResetTime = 0.125,
        RecoilMaximum = 8,
        RecoilDissipationRate = 6,
        RecoilSpreadPenalty = 0.002,
        HipFireSpreadPenalty = 0.02,

        MoveSpeedMult = 0.9,
        ShootingSpeedMult = 0.8,
        SightedSpeedMult = 0.85,
        MeleeSpeedMult = 1,
        ReloadSpeedMult = 1,
    },
}

SWEP.Range_Min = 1750
SWEP.Range_Max = 4500

SWEP.TTTReplace = {}

SWEP.Firemode = 1
SWEP.Firemodes = false

SWEP.RPM = 700

SWEP.RecoilKick = 1.5

SWEP.ClipSize = 20

SWEP.FreeAimMaxAngle = 3.75

SWEP.Attachments = {
    [1] = {
        PrintName = "Optic",
        Category = {"optic_cqb", "optic_medium"},
        Bone = "ValveBiped.mp5_rootbone",
        AttachSound = "TacRP/weapons/optic_on.wav",
        DetachSound = "TacRP/weapons/optic_off.wav",
        InstalledElements = {"optic"},
        Pos_VM = Vector(-6.25, -0.3, 6.5),
        Pos_WM = Vector(7, 1.5, -6.5),
        Ang_VM = Angle(90, 0, 0),
        Ang_WM = Angle(0, -3.5, 180),
    },
    [2] = {
        PrintName = "Muzzle",
        Category = "silencer",
        Bone = "ValveBiped.mp5_rootbone",
        AttachSound = "TacRP/weapons/silencer_on.wav",
        DetachSound = "TacRP/weapons/silencer_off.wav",
        Pos_VM = Vector(-4.25, -0.2, 26),
        Pos_WM = Vector(24, 2.5, -5.25),
        Ang_VM = Angle(90, 0, 0),
        Ang_WM = Angle(0, -3.5, 180),
    },
    [3] = {
        PrintName = "Tactical",
        Category = "tactical",
        Bone = "ValveBiped.mp5_rootbone",
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
        InstalledElements = {"tactical"},
        Pos_VM = Vector(-4, 0.5, 11),
        Pos_WM = Vector(14, 1.3, -5),
        Ang_VM = Angle(90, 0, 90),
        Ang_WM = Angle(0, -3.5, -90),
    },
    [4] = {
        PrintName = "Accessory",
        Category = {"acc", "acc_foldstock2", "acc_sling", "acc_duffle", "acc_extmag_smg"},
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
        Category = {"trigger_semi"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [7] = {
        PrintName = "Ammo",
        Category = {"ammo_pistol"},
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