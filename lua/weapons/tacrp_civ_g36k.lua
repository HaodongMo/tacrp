SWEP.Base = "tacrp_g36k"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "HK HK243" // technically HK243 is the sporter version of the G36, not the G36K. too lazy to model edit
SWEP.Category = "Tactical RP" // "Tactical RP (Arctic)"

SWEP.SubCatTier = "3Quality"
SWEP.SubCatType = "6Marksman Rifle"

SWEP.Description = "Semi-automatic model of an iconic polymer rifle.\nUses reduced capacity magazines."

SWEP.ViewModel = "models/weapons/tacint/v_g36k_hq.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_g36k.mdl"

SWEP.Slot = 3

SWEP.ArcadeStats = {

    Description = "Semi-automatic model of an iconic polymer rifle. Fine tuned for precision shooting.",

    Damage_Max = 22,
    Damage_Min = 18,

    Recoil_Kick = 1,
    Spread = 0.001,

    MoveSpeedMult = 0.85,
    ShootingSpeedMult = 0.75,
    SightedSpeedMult = 0.75,
    MeleeSpeedMult = 1,
    ReloadSpeedMult = 1,
}


SWEP.Firemode = 1
SWEP.Firemodes = false

SWEP.RPM = 500

SWEP.ClipSize = 15

SWEP.Attachments = {
    [1] = {
        PrintName = "Optic",
        Category = {"ironsights", "optic_cqb", "optic_medium"},
        Bone = "ValveBiped.g36k_rootbone",
        WMBone = "Box01",
        InstalledElements = {"irons"},
        AttachSound = "TacRP/weapons/optic_on.wav",
        DetachSound = "TacRP/weapons/optic_off.wav",
        VMScale = 1,
        Pos_VM = Vector(-6.4, 0.14, 7),
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
        Pos_VM = Vector(-3.45, 0.075, 24.5),
        Pos_WM = Vector(-0.25, 24, -1),
        Ang_VM = Angle(90, 0, 0),
        Ang_WM = Angle(0, -90, 0),
    },
    [3] = {
        PrintName = "Tactical",
        Category = "tactical",
        Bone = "ValveBiped.g36k_rootbone",
        WMBone = "Box01",
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
        InstalledElements = {"tactical"},
        Pos_VM = Vector(-3.75, -0.75, 17),
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