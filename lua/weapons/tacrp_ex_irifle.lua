SWEP.Base = "tacrp_base"
SWEP.Spawnable = false

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "AR2 OSIPR"
SWEP.Category = "Tactical RP"

SWEP.SubCatTier = "1Elite"
SWEP.SubCatType = "4Assault Rifle"

SWEP.Description = "Dark matter energy rifle with low recoil and total armor penetration but individual shots are fairly weak. \nUses a laser dot in place of sights and is incompatible with most attachments."

SWEP.Trivia_Caliber = "Dark Matter"
SWEP.Trivia_Manufacturer = "Combine Union"
SWEP.Trivia_Year = "Unknown"

SWEP.Faction = TacRP.FACTION_NEUTRAL
SWEP.Credits = [[
Model & Textures: Juniez
Sounds: Half-Life 2: MMod
]]

SWEP.ViewModel = "models/weapons/tacint_extras/v_irifle.mdl"
SWEP.WorldModel = "models/weapons/tacint_extras/w_irifle.mdl"

SWEP.Slot = 2
SWEP.SlotAlt = 3

SWEP.BalanceStats = {
    [TacRP.BALANCE_SBOX] = {
        Damage_Max = 28,
        Damage_Min = 22,

        ClipSize = 75,

        MoveSpeedMult = 0.75,
        ShootingSpeedMult = 0.5,
        SightedSpeedMult = 0.75,
        MeleeSpeedMult = 1,
        ReloadSpeedMult = 1,
    },
    [TacRP.BALANCE_TTT] = {

        Description = "Machine gun with high damage but very low mobility.",

        Damage_Max = 20,
        Damage_Min = 12,
        Range_Min = 750,
        Range_Max = 3000,
        ClipSize = 75,

        BodyDamageMultipliers = {
            [HITGROUP_HEAD] = 2,
            [HITGROUP_CHEST] = 1,
            [HITGROUP_STOMACH] = 1,
            [HITGROUP_LEFTARM] = 0.9,
            [HITGROUP_RIGHTARM] = 0.9,
            [HITGROUP_LEFTLEG] = 0.75,
            [HITGROUP_RIGHTLEG] = 0.75,
            [HITGROUP_GEAR] = 0.9
        },

        ReloadTimeMult = 1.2,

        MoveSpeedMult = 0.85,
        ShootingSpeedMult = 0.4,
        MeleeSpeedMult = 1,
        SightedSpeedMult = 0.5,
        ReloadSpeedMult = 0.4,
    },
    [TacRP.BALANCE_PVE] = {
        Damage_Max = 19,
        Damage_Min = 14,

        ClipSize = 100,

        MoveSpeedMult = 0.75,
        ShootingSpeedMult = 0.5,
        SightedSpeedMult = 0.75,
        MeleeSpeedMult = 1,
        ReloadSpeedMult = 1,
    },
    [TacRP.BALANCE_OLDSCHOOL] = {
        Description = "Balanced light machine gun that can put down some serious firepower.",
        ClipSize = 75,
        RecoilSpreadPenalty = 0.0013,
        ReloadTimeMult = 1.1
    }
}

SWEP.TTTReplace = TacRP.TTTReplacePreset.MachineGun

SWEP.BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 3,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
    [HITGROUP_LEFTLEG] = 0.75,
    [HITGROUP_RIGHTLEG] = 0.75,
    [HITGROUP_GEAR] = 0.75
}

SWEP.Laser = true
SWEP.LaserPower = 4
SWEP.LaserQCAttachmentVM = 1
SWEP.LaserQCAttachmentWM = 1
SWEP.LaserAlwaysAccurate = false
SWEP.CanToggle = false
SWEP.TacticalName = "Laser"

// "ballistics"

SWEP.Damage_Max = 35
SWEP.Damage_Min = 25
SWEP.Range_Min = 1200
SWEP.Range_Max = 4000
SWEP.Penetration = 10
SWEP.ArmorPenetration = 0.8

SWEP.MuzzleVelocity = 17500

// misc. shooting

SWEP.Firemode = 2

SWEP.RPM = 600

SWEP.Spread = 0.001

SWEP.ShootTimeMult = 0.5

SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 10
SWEP.RecoilResetTime = 0.15
SWEP.RecoilDissipationRate = 40
SWEP.RecoilFirstShotMult = 2

SWEP.RecoilVisualKick = 1

SWEP.RecoilKick = 5

SWEP.HipFireSpreadPenalty = 0.025
SWEP.RecoilSpreadPenalty = 0.0009
SWEP.PeekPenaltyFraction = 0.125

SWEP.CanBlindFire = true

// handling

SWEP.MoveSpeedMult = 0.85
SWEP.ShootingSpeedMult = 0.4
SWEP.SightedSpeedMult = 0.5

SWEP.ReloadSpeedMult = 0.1
SWEP.ReloadSpeedMultTime = 1

SWEP.AimDownSightsTime = 0.5
SWEP.SprintToFireTime = 0.5

SWEP.Sway = 2
SWEP.ScopedSway = 0.75

SWEP.FreeAimMaxAngle = 7

// hold types

SWEP.HoldType = "ar2"
SWEP.HoldTypeSprint = "passive"
SWEP.HoldTypeBlindFire = false

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.PassiveAng = Angle(0, 0, 0)
SWEP.PassivePos = Vector(-1, -2, -4.25)

SWEP.BlindFireAng = Angle(0, 5, 0)
SWEP.BlindFirePos = Vector(0, -4, -3)

SWEP.SprintAng = Angle(30, -15, 0)
SWEP.SprintPos = Vector(5, 0, -2)

SWEP.SightAng = Angle(-0.25, -0.6, 0)
SWEP.SightPos = Vector(-2.75, -5.5, -3)

SWEP.CorrectivePos = Vector(0.025, 0, 0.125)
SWEP.CorrectiveAng = Angle(0, 0, 0)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_BACK2
SWEP.HolsterPos = Vector(5, 0, -6)
SWEP.HolsterAng = Angle(0, 0, 0)

// reload

SWEP.ClipSize = 30
SWEP.Ammo = "ar2"

SWEP.ReloadTimeMult = 1.25
SWEP.DropMagazineModel = "models/items/combine_rifle_cartridge01.mdl"
SWEP.DropMagazineImpact = "metal"

SWEP.ReloadUpInTime = 2
SWEP.DropMagazineTime = 0.7

SWEP.BulletBodygroups = {
    [1] = {1, 0},
    [2] = {1, 1},
    [3] = {1, 2},
}

SWEP.DefaultBodygroups = "02"

// sounds

local path = "tacrp_extras/ar2/ar2_"

SWEP.Sound_Shoot = "^" .. path .."fire3.wav"
SWEP.Sound_Shoot_Silenced = "TacRP/weapons/g36k/g36k_fire_silenced-1.wav"

SWEP.Vol_Shoot = 130
SWEP.ShootPitchVariance = 2.5 // amount to vary pitch by each shot

// effects

// the .qc attachment for the muzzle
SWEP.QCA_Muzzle = 1
// ditto for shell
SWEP.QCA_Eject = 2

SWEP.MuzzleEffect = "muzzleflash_minimi"
SWEP.EjectEffect = 0

// anims

SWEP.AnimationTranslationTable = {
    ["fire_iron"] = "fire1_M",
    ["fire1"] = "fire1_M",
    ["fire2"] = "fire1_M",
    ["fire3"] = "fire1_M",
    ["fire4"] = "fire1_M",
    ["fire5"] = "fire1_M",
    ["melee"] = "melee1",
	["deploy"] = "unholster"
}

SWEP.DeployTimeMult = 1.25

// attachments

SWEP.Attachments = {
    [1] = {
        PrintName = "Optic",
        Category = "optic_irifle",
        AttachSound = "TacRP/weapons/optic_on.wav",
        DetachSound = "TacRP/weapons/optic_off.wav",
    },
    [2] = {
        PrintName = "Accessory",
        Category = {"acc", "acc_duffle", "acc_sling"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [5] = {
        PrintName = "Perk",
        Category = {"perk", "perk_melee", "perk_shooting", "perk_reload"},
        AttachSound = "tacrp/weapons/flashlight_on.wav",
        DetachSound = "tacrp/weapons/flashlight_off.wav",
    },
    [3] = {
        PrintName = "Bolt",
        Category = {"bolt_automatic"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [4] = {
        PrintName = "Trigger",
        Category = {"trigger_auto"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
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

addsound("tacint_irifle.Clip_Out", path .. "rotate.wav")
addsound("tacint_irifle.Clip_In", path .. "magin.wav")
addsound("tacint_irifle.bolt_back", path .. "reload_rotate.wav")
addsound("tacint_irifle.bolt_forward", path .. "reload_push.wav")
addsound("tacint_irifle.deploy", path .. "deploy.wav")