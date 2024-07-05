SWEP.Base = "tacrp_m4"
SWEP.Spawnable = true // deprecated by ST AR-15

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "Diemaco AR-15"
SWEP.AbbrevName = "AR-15"
SWEP.Category = "Tactical RP"

SWEP.SubCatTier = "4Consumer"
SWEP.SubCatType = "5Sporter"

SWEP.Description = "Customized semi-automatic model of an ubiquitous American rifle."
SWEP.Description_Quote = "\"One of the most beloved and most vilified rifles in the country\""

SWEP.ViewModel = "models/weapons/tacint/v_ar15.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_m4.mdl"

SWEP.Slot = 2


SWEP.BalanceStats = {
    [TacRP.BALANCE_SBOX] = {
        Description = "Semi-automatic model of an ubiquitous American rifle. Fine tuned for precision shooting.",

        Damage_Max = 22,
        Damage_Min = 15,
        Recoil_Kick = 1.5,
        Spread = 0.001,
    },
    [TacRP.BALANCE_TTT] = {
        Description = "Semi-automatic model of an ubiquitous American rifle. Fine tuned for precision shooting.",

        Damage_Max = 17,
        Damage_Min = 14,
        Range_Min = 600,
        Range_Max = 2500,
        RPM = 420,

        Recoil_Kick = 1.5,
        Spread = 0.001,

        RecoilDissipationRate = 12,
        RecoilSpreadPenalty = 0.002,

        BodyDamageMultipliers = {
            [HITGROUP_HEAD] = 4,
            [HITGROUP_CHEST] = 1.25,
            [HITGROUP_STOMACH] = 1,
            [HITGROUP_LEFTARM] = 0.9,
            [HITGROUP_RIGHTARM] = 0.9,
            [HITGROUP_LEFTLEG] = 0.75,
            [HITGROUP_RIGHTLEG] = 0.75,
            [HITGROUP_GEAR] = 0.9
        },
    },
}

SWEP.TTTReplace = {}

SWEP.RPM = 550
SWEP.RPMMultSemi = 400/550

SWEP.Firemode = 1
SWEP.Firemodes = false

SWEP.ClipSize = 15

SWEP.SightAng = Angle(0.22, -0.1, 0)
SWEP.SightPos = Vector(-4.15, -7.5, -4.14)

SWEP.Attachments = {
    [1] = {
        PrintName = "Optic",
        Category = {"optic_cqb_nookp7", "optic_medium"},
        InstalledElements = {"sights"},
        Bone = "ValveBiped.m4_rootbone",
        WMBone = "Box01",
        AttachSound = "TacRP/weapons/optic_on.wav",
        DetachSound = "TacRP/weapons/optic_off.wav",
        VMScale = 1,
        Pos_VM = Vector(-5.5, -0.05, 6),
        Pos_WM = Vector(0.75, 5, 1.15),
        Ang_VM = Angle(90, 0, 0),
        Ang_WM = Angle(0, -90 + 3.5, 0),
    },
    [2] = {
        PrintName = "Muzzle",
        Category = "silencer",
        Bone = "ValveBiped.m4_rootbone",
        WMBone = "Box01",
        AttachSound = "TacRP/weapons/silencer_on.wav",
        DetachSound = "TacRP/weapons/silencer_off.wav",
        Pos_VM = Vector(-3.95, 0, 26.3),
        Pos_WM = Vector(1.4, 21, -0.5),
        Ang_VM = Angle(90, 0, 0),
        Ang_WM = Angle(0, -90 + 3.5, 0),
    },
    [3] = {
        PrintName = "Tactical",
        Category = {"tactical", "tactical_zoom", "tactical_ebullet"},
        Bone = "ValveBiped.m4_rootbone",
        WMBone = "Box01",
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
        Pos_VM = Vector(-3.9, -1.2, 16.5),
        Pos_WM = Vector(2, 13, -0.5),
        Ang_VM = Angle(90, 0, -90),
        Ang_WM = Angle(-90, -90 + 3.5, 0),
    },
    [4] = {
        PrintName = "Accessory",
        Category = {"acc", "acc_foldstock2", "acc_sling", "acc_duffle", "perk_extendedmag"},
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