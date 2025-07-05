SWEP.Base = "tacrp_amd65"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "Arsenal SAM7SF"
SWEP.AbbrevName = "SAM7"
SWEP.Category = "Tactical RP"

SWEP.SubCatTier = "3Security"
SWEP.SubCatType = "5Sporter"

SWEP.Description = "American semi-automatic AK pattern rifle, customized with an AR-15 style stock and Hungarian handguard.\nUses reduced capacity magazines."
SWEP.Description_Quote = "Bound to become a sought-after shooter and collectible firearm." --From the Arsenal Inc. website

SWEP.Trivia_Caliber = "7.62x39mm"
SWEP.Trivia_Manufacturer = "Arsenal Inc"
SWEP.Trivia_Year = "1998"

SWEP.Faction = TacRP.FACTION_MILITIA
SWEP.Credits = "Assets: Tactical Intervention\nModel Edit: Arctic"

SWEP.ViewModel = "models/weapons/tacint/v_civ_amd65.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_civ_amd65.mdl"

SWEP.Slot = 2

SWEP.BalanceStats = {
    [TacRP.BALANCE_SBOX] = {
        Damage_Max = 36,
        Damage_Min = 18,
        Range_Min = 1000,
        Range_Max = 3800,
        ArmorPenetration = 0.675,
        Spread = 0.002,

        RecoilKick = 7.5,

        RecoilSpreadPenalty = 0.0037,
    },
    [TacRP.BALANCE_TTT] = {
        Damage_Max = 24,
        Damage_Min = 12,
        Range_Min = 300,
        Range_Max = 1500,
        RPM = 500,

        RecoilSpreadPenalty = 0.005,
        RecoilMaximum = 10,

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
    [TacRP.BALANCE_PVE] = {
        Damage_Max = 12,
        Damage_Min = 7,

        RecoilKick = 6,

        HipFireSpreadPenalty = 0.03,
        RecoilSpreadPenalty = 0.003,
    },
    [TacRP.BALANCE_OLDSCHOOL] = {
        RecoilMaximum = 20,
        RecoilSpreadPenalty = 0.0035,
        RecoilDissipationRate = 17
    }
}

// "ballistics"
SWEP.Damage_Max = 28
SWEP.Damage_Min = 14
SWEP.Range_Min = 800
SWEP.Range_Max = 2600
SWEP.Penetration = 11
SWEP.ArmorPenetration = 0.65
SWEP.ArmorBonus = 1.25

// misc. shooting

SWEP.Firemode = 1
SWEP.Firemodes = false

SWEP.RPM = 450
SWEP.RPMMultSemi = 280 / 450

SWEP.ShootTimeMult = 1

SWEP.Spread = 0.005

SWEP.RecoilKick = 4

SWEP.RecoilSpreadPenalty = 0.0025
SWEP.HipFireSpreadPenalty = 0.03

SWEP.ClipSize = 12
SWEP.Ammo = "ar2"

SWEP.SightAng = Angle(-0.265, -0.55, -1)
SWEP.SightPos = Vector(-4.475, -7.5, -3.2)

SWEP.AnimationTranslationTable = {
    ["fire_iron"] = "fire1_M",
    ["deploy"] = "deploy",
    ["fire1"] = "fire1_M",
    ["fire2"] = "fire2_M",
    ["fire3"] = "fire3_M",
    ["fire4"] = "fire4_M",
    ["fire5"] = {"fire5_M", "fire5_L", "fire5_R"},
    ["melee"] = {"melee1", "melee2"}
}

SWEP.DropMagazineModel = "models/weapons/tacint/magazines/amd65_civ.mdl"

// attachments

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
            {3, 1}
        },
    },
    ["optic"] = {
        BGs_VM = {
            {2, 1}
        },
    },
    ["akmount"] = {
        BGs_VM = {
            {2, 0}
        },
        AttPosMods = {
            [1] = {
                Pos_VM = Vector(-4.5, 0.65, 4),
                Pos_WM = Vector(-0.3, 1, 1),
            }
        },
        SortOrder = 2,
    },
}

SWEP.ProceduralIronFire = {
    vm_pos = Vector(0, -1.5, -0.4),
    vm_ang = Angle(0, 1, 0),
    t = 0.25,
    tmax = 0.25,
    bones = {
        {
            bone = "ValveBiped.bolt_cover",
            pos = Vector(0, 0, -3),
            t0 = 0.02,
            t1 = 0.15,
        },
    },
}

local path = "TacRP/weapons/amd65/"

SWEP.Attachments = {
    [1] = {
        PrintName = "Optic",
        Category = {"optic_cqb", "optic_medium", "optic_sniper", "optic_ak"},
        Bone = "ValveBiped._ROOT_AMD65",
        WMBone = "Box01",
        InstalledElements = {"optic"},
        AttachSound = "TacRP/weapons/optic_on.wav",
        DetachSound = "TacRP/weapons/optic_off.wav",
        VMScale = 0.75,
        Pos_VM = Vector(-4.45, 0.225, 5),
        Pos_WM = Vector(0, 3, 0.5),
        Ang_VM = Angle(90, 0, 0),
        Ang_WM = Angle(0, -90, 0),
    },
    [2] = {
        PrintName = "Muzzle",
        Category = "silencer",
        Bone = "ValveBiped._ROOT_AMD65",
        WMBone = "Box01",
        AttachSound = "TacRP/weapons/silencer_on.wav",
        DetachSound = "TacRP/weapons/silencer_off.wav",
        Pos_VM = Vector(-2.65, 0.25, 26.75),
        Pos_WM = Vector(0, 25.5, -1.25),
        Ang_VM = Angle(90, 0, 0),
        Ang_WM = Angle(0, -90, 0),
    },
    [3] = {
        PrintName = "Tactical",
        Category = {"tactical", "tactical_zoom", "tactical_ebullet"},
        Bone = "ValveBiped._ROOT_AMD65",
        WMBone = "Box01",
        InstalledElements = {"tactical"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
        Pos_VM = Vector(-2.5, -0.5, 13),
        Pos_WM = Vector(0, 19, -2),
        Ang_VM = Angle(90, 0, -90),
        Ang_WM = Angle(0, -90, 180),
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

local function addsound(name, spath)
    sound.Add({
        name = name,
        channel = 16,
        volume = 1.0,
        sound = spath
    })
end

addsound("TacInt_ak47.remove_clip", "TacRP/weapons/ak47/ak47_remove_clip.wav")
addsound("TacInt_ak47.insert_clip", "TacRP/weapons/ak47/ak47_insert_clip.wav")
addsound("TacInt_AMD65.Bolt_Back", path .. "bolt_back.wav")
addsound("TacInt_AMD65.Bolt_Release", path .. "bolt_release.wav")
addsound("TacInt_amd65.Rifle_catch", path .. "rifle_catch.wav")
addsound("TacInt_AMD65.Buttstock_Lockback", path .. "buttstock_lockback.wav")