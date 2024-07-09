SWEP.Base = "tacrp_g36k"
SWEP.Spawnable = true // deprecated since SL8 is a thing now

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "HK HK243" // technically HK243 is the sporter version of the G36, not the G36K. too lazy to model edit
SWEP.AbbrevName = "HK243"
SWEP.Category = "Tactical RP"

SWEP.SubCatTier = "3Security"
SWEP.SubCatType = "5Sporter"

SWEP.Description = "Customized semi-automatic model of an iconic polymer rifle.\nUses reduced capacity magazines."

SWEP.ViewModel = "models/weapons/tacint/v_hk243.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_g36k.mdl"

SWEP.Credits = "Assets: Tactical Intervention\nModel Edit: Fesiug"

SWEP.Slot = 2

SWEP.BalanceStats = {
    [TacRP.BALANCE_SBOX] = {
        Damage_Max = 22,
        Damage_Min = 18,

        Recoil_Kick = 1,
        Spread = 0.001,
    },
    [TacRP.BALANCE_TTT] = {
        Damage_Max = 16,
        Damage_Min = 13,
        Range_Min = 500,
        Range_Max = 4000,
        RPM = 500,

        RecoilKick = 1,
        Spread = 0.001,

        BodyDamageMultipliers = {
            [HITGROUP_HEAD] = 3,
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

SWEP.Firemode = 1
SWEP.Firemodes = false

SWEP.RPM = 550
SWEP.RPMMultSemi = 400/550

SWEP.ClipSize = 15

SWEP.SightAng = Angle(0, 0.2, 0)
SWEP.SightPos = Vector(-4.02, -7.5, -3.97)

SWEP.Scope = true
SWEP.ScopeOverlay = false 
SWEP.ScopeFOV = 90 / 1.1
SWEP.ScopeLevels = 1 // 2 = like CS:S
SWEP.ScopeHideWeapon = false

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
            {2, 1}, -- inheritance
        },
    },
    ["irons"] = {
        BGs_VM = {
            {3, 1}
        },
    },
}

SWEP.Attachments = {
    [1] = {
        PrintName = "Optic",
        Category = {"optic_cqb_nookp7", "optic_medium"},
        Bone = "ValveBiped.g36k_rootbone",
        WMBone = "Box01",
        InstalledElements = {"irons"},
        AttachSound = "TacRP/weapons/optic_on.wav",
        DetachSound = "TacRP/weapons/optic_off.wav",
        VMScale = 1,
        Pos_VM = Vector(-5.9, 0.14, 3.2),
        Pos_WM = Vector(0, 0, 2.75),
        Ang_VM = Angle(90, 0, 0),
        Ang_WM = Angle(0, -90, 0),
    },
    [2] = {
        PrintName = "Muzzle",
        Category = "silencer",
        Bone = "ValveBiped.g36k_rootbone",
        WMBone = "Box01",
        AttachSound = "TacRP/weapons/silencer_on.wav",
        DetachSound = "TacRP/weapons/silencer_off.wav",
        Pos_VM = Vector(-3.45, 0.075, 30.7),
        Pos_WM = Vector(-0.25, 24, -1),
        Ang_VM = Angle(90, 0, 0),
        Ang_WM = Angle(0, -90, 0),
    },
    [3] = {
        PrintName = "Tactical",
        Category = {"tactical", "tactical_zoom", "tactical_ebullet"},
        Bone = "ValveBiped.g36k_rootbone",
        WMBone = "Box01",
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
        InstalledElements = {"tactical"},
        Pos_VM = Vector(-3.75, -0.75, 19),
        Pos_WM = Vector(0.9, 15, -1),
        Ang_VM = Angle(90, 0, -80),
        Ang_WM = Angle(-70, -90, 0),
    },
    [4] = {
        PrintName = "Accessory",
        Category = {"acc", "acc_foldstock", "acc_sling", "acc_duffle", "perk_extendedmag"},
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