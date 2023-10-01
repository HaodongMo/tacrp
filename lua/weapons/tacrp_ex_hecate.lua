SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "PGM Hécate II"
SWEP.Category = "Tactical RP" // "Tactical RP (Extras)"

SWEP.SubCatTier = "2Operator"
SWEP.SubCatType = "7Sniper Rifle"

SWEP.Description = "Heavy anti-materiel rifle that can kill in one shot.\nDoes not fire phantom bullets.\nEquipped with a 10x scope by default."

SWEP.ViewModel = "models/weapons/tacint_extras/v_hecate.mdl"
SWEP.WorldModel = "models/weapons/tacint_extras/w_hecate.mdl"

SWEP.Slot = 2
SWEP.SlotAlt = 3

SWEP.BalanceStats = {
    [TacRP.BALANCE_SBOX] = {
        Damage_Max = 80,
        Damage_Min = 150,
        Range_Min = 700,
        Range_Max = 5000,

        MoveSpeedMult = 0.7,
        ShootingSpeedMult = 0.5,
        SightedSpeedMult = 0.55,
        MeleeSpeedMult = 1,
        ReloadSpeedMult = 1,
    },
    [TacRP.BALANCE_TTT] = { // this is a buyable weapon in TTT
        Damage_Max = 80,
        Damage_Min = 200,
        Range_Min = 500,
        Range_Max = 5000,

        Penetration = 75,
        RecoilDissipationRate = 0.5,

        BodyDamageMultipliers = {
            [HITGROUP_HEAD] = 5,
            [HITGROUP_CHEST] = 1.25,
            [HITGROUP_STOMACH] = 1,
            [HITGROUP_LEFTARM] = 0.75,
            [HITGROUP_RIGHTARM] = 0.75,
            [HITGROUP_LEFTLEG] = 0.5,
            [HITGROUP_RIGHTLEG] = 0.5,
            [HITGROUP_GEAR] = 0.5
        },

        ReloadTimeMult = 1.75,

        MoveSpeedMult = 0.8,
        ShootingSpeedMult = 0.25,
        MeleeSpeedMult = 1,
        SightedSpeedMult = 0.4,
        ReloadSpeedMult = 0.25,
    },
    [TacRP.BALANCE_PVE] = {
        Damage_Max = 90,
        Damage_Min = 75,
        Range_Min = 4000,
        Range_Max = 8000,

        MoveSpeedMult = 0.7,
        ShootingSpeedMult = 0.5,
        SightedSpeedMult = 0.55,
        MeleeSpeedMult = 1,
        ReloadSpeedMult = 1,
    },
    [TacRP.BALANCE_OLDSCHOOL] = {
        HipFireSpreadPenalty = 0.025,
    }
}

// "ballistics"

SWEP.Damage_Max = 175 // damage at minimum range
SWEP.Damage_Min = 130 // damage at maximum range
SWEP.Range_Min = 1500 // distance for which to maintain maximum damage
SWEP.Range_Max = 9000 // distance at which we drop to minimum damage
SWEP.Penetration = 40 // units of metal this weapon can penetrate
SWEP.ArmorPenetration = 1.5
SWEP.ArmorBonus = 5

SWEP.BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 5, // nobody is surviving this
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1.25,
    [HITGROUP_LEFTARM] = 0.75,
    [HITGROUP_RIGHTARM] = 0.75,
    [HITGROUP_LEFTLEG] = 0.5,
    [HITGROUP_RIGHTLEG] = 0.5,
    [HITGROUP_GEAR] = 0.5
}

SWEP.MuzzleVelocity = 20000

SWEP.ShootTimeMult = 1.35

// misc. shooting

SWEP.Firemode = 1

SWEP.FiremodeName = "Bolt-Action" // only used externally for firemode name distinction

SWEP.RPM = 25

SWEP.Spread = 0

SWEP.HipFireSpreadPenalty = 0.06
SWEP.PeekPenaltyFraction = 0.15

SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 1
SWEP.RecoilResetTime = 0.25
SWEP.RecoilDissipationRate = 1
SWEP.RecoilFirstShotMult = 1

SWEP.RecoilVisualKick = 5
SWEP.RecoilKick = 10
SWEP.RecoilStability = 0.75

SWEP.RecoilSpreadPenalty = 0.05

SWEP.CanBlindFire = true

// handling

SWEP.MoveSpeedMult = 0.875
SWEP.ShootingSpeedMult = 0.4
SWEP.SightedSpeedMult = 0.5

SWEP.ReloadSpeedMult = 0.3

SWEP.AimDownSightsTime = 0.7
SWEP.SprintToFireTime = 0.6

SWEP.Sway = 5
SWEP.ScopedSway = 0.2

SWEP.FreeAimMaxAngle = 9

// hold types

SWEP.HoldType = "ar2"
SWEP.HoldTypeSprint = "passive"
SWEP.HoldTypeBlindFire = false

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.PassiveAng = Angle(0, 0, 0)
SWEP.PassivePos = Vector(2, -2, -6)

SWEP.BlindFireAng = Angle(0, 15, -60)
SWEP.BlindFirePos = Vector(1, -2, -1)

SWEP.BlindFireLeftAng = Angle(75, 0, 0)
SWEP.BlindFireLeftPos = Vector(8, 10, -6)

SWEP.BlindFireRightAng = Angle(-75, 0, 0)
SWEP.BlindFireRightPos = Vector(-8, 12, -4)

SWEP.BlindFireSuicideAng = Angle(0, 135, 0)
SWEP.BlindFireSuicidePos = Vector(-4, 44, -35)

SWEP.SprintAng = Angle(30, -15, 0)
SWEP.SprintPos = Vector(5, 0, -4)

SWEP.SightAng = Angle(0.02, 0.11, 0)
SWEP.SightPos = Vector(-3.835, -7.5, -4.07)

SWEP.CorrectivePos = Vector(0.025, 0, 0.1)
SWEP.CorrectiveAng = Angle(0, 0, 0)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_BACK2
SWEP.HolsterPos = Vector(5, 6, -6)
SWEP.HolsterAng = Angle(0, 0, 0)

// scope

SWEP.Scope = true
SWEP.ScopeOverlay = Material("tacrp/scopes/sniper.png", "mips smooth") // Material("path/to/overlay")
SWEP.ScopeFOV = 90 / 10
SWEP.ScopeLevels = 1 // 2 = like CS:S
SWEP.ScopeHideWeapon = true
SWEP.ScopeOverlaySize = 0.75

// reload

SWEP.ClipSize = 7
SWEP.Ammo = "SniperPenetratedRound"
SWEP.AmmoTTT = "ti_sniper"

SWEP.ReloadTimeMult = 1.4
SWEP.DropMagazineImpact = "metal"
SWEP.DropMagazineModel = "models/weapons/tacint/magazines/uratio.mdl"

SWEP.ReloadUpInTime = 1.75
SWEP.DropMagazineTime = 0.8

// sounds

local path = "tacrp_extras/hecate/ax308_"

SWEP.Sound_Shoot = {"^" .. path .. "fire_1.wav", "^" .. path .. "fire_2.wav", "^" .. path .. "fire_3.wav"}
SWEP.Sound_Shoot_Silenced = "TacRP/weapons/ak47/ak47_fire_silenced-1.wav"

SWEP.Vol_Shoot = 130
SWEP.ShootPitchVariance = 2.5 // amount to vary pitch by each shot

// effects

// the .qc attachment for the muzzle
SWEP.QCA_Muzzle = 1
// ditto for shell
SWEP.QCA_Eject = 2

SWEP.MuzzleEffect = "muzzleflash_1"
SWEP.EjectEffect = 2
SWEP.EjectDelay = 0.9

// anims

SWEP.AnimationTranslationTable = {
    ["deploy"] = "unholster",
    ["fire"] = {"shoot1", "shoot2"},
    ["blind_idle"] = "idle",
    ["blind_fire"] = "shoot1",
    ["reload"] = "reload2",
}

// attachments

SWEP.AttachmentElements = {
    ["optic"] = {
        BGs_VM = {
            {1, 1}
        },
        BGs_WM = {
            {1, 1}
        },
    },
    ["irons"] = {
        BGs_VM = {
            {2, 1}
        },
        BGs_WM = {
            {2, 1}
        },
    },
    ["tactical"] = {
        BGs_VM = {
            {3, 1}
        },
        BGs_WM = {
            {3, 1}
        },
    },
}

SWEP.Attachments = {
    [1] = {
        PrintName = "Optic",
        Category = {"ironsights_sniper", "optic_cqb", "optic_medium", "optic_sniper"},
        WMBone = "Box01",
        Bone = "ValveBiped.uratio_rootbone",
        AttachSound = "TacRP/weapons/optic_on.wav",
        DetachSound = "TacRP/weapons/optic_off.wav",
        InstalledElements = {"optic"},
        Pos_VM = Vector(-5.5, 0, 5),
        Ang_VM = Angle(90, 0, 0),
        Pos_WM = Vector(0, 5.5, 2.2),
        Ang_WM = Angle(0, -90, 0),
    },
    [2] = {
        PrintName = "Muzzle",
        Category = "barrel",
        WMBone = "Box01",
        Bone = "ValveBiped.uratio_rootbone",
        AttachSound = "TacRP/weapons/silencer_on.wav",
        DetachSound = "TacRP/weapons/silencer_off.wav",
        Pos_VM = Vector(-4.1, 0, 30),
        Ang_VM = Angle(90, 0, 0),
        Pos_WM = Vector(0, 35, 0.25),
        Ang_WM = Angle(0, -90, 0),
    },
    [3] = {
        PrintName = "Tactical",
        Category = "tactical",
        WMBone = "Box01",
        Bone = "ValveBiped.uratio_rootbone",
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
        InstalledElements = {"tactical"},
        Pos_VM = Vector(-2.25, 0, 20),
        Ang_VM = Angle(90, 0, 180),
        Pos_WM = Vector(0, 23.75, -2),
        Ang_WM = Angle(0, -90, 180),
    },
    [4] = {
        PrintName = "Accessory",
        Category = {"acc", "acc_extmag_sniper", "acc_sling", "acc_duffle", "acc_bipod"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [5] = {
        PrintName = "Bolt",
        Category = {"bolt_manual"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [6] = {
        PrintName = "Trigger",
        Category = {"trigger_manual"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [7] = {
        PrintName = "Ammo",
        Category = {"ammo_amr"},
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

addsound("tacint_extras_hecate.Clip_Out", path .. "magout.wav")
addsound("tacint_extras_hecate.Clip_In", path .. "magin.wav")
addsound("tacint_extras_hecate.Bolt_Back", path .. "boltrelease.wav")
addsound("tacint_extras_hecate.bolt_forward", path .. "boltback.wav")
addsound("tacint_extras_hecate.Bolt_Up", path .. "boltup.wav")
addsound("tacint_extras_hecate.bolt_down", path .. "boltdown.wav")

if engine.ActiveGamemode() == "terrortown" then
    SWEP.AutoSpawnable = false
    SWEP.Kind = WEAPON_HEAVY
    SWEP.CanBuy = { ROLE_TRAITOR, ROLE_DETECTIVE }
    SWEP.EquipMenuData = {
        type = "Weapon",
        desc = "Heavy bolt-action anti-materiel rifle.\nComes with 10 rounds.\n\nBEWARE: May be visible while holstered!",
    }

    function SWEP:TTTBought(buyer)
        buyer:GiveAmmo(3, "ti_sniper")
    end
end