SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "KAC PDW"
SWEP.Category = "Tactical RP (Arctic)"

SWEP.Description = "Elite subcompact personal defense weapon. The perfect blend of rifle and sub-machine gun."

SWEP.ViewModel = "models/weapons/tacint/v_pdw.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_pdw.mdl"

SWEP.Slot = 3

// "ballistics"

SWEP.Damage_Max = 28
SWEP.Damage_Min = 14
SWEP.Range_Min = 2000 // distance for which to maintain maximum damage
SWEP.Range_Max = 5000 // distance at which we drop to minimum damage
SWEP.Penetration = 7 // units of metal this weapon can penetrate

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

SWEP.MuzzleVelocity = 21000

// misc. shooting

SWEP.Firemodes = {
    2,
    1
}

SWEP.RPM = 800

SWEP.Spread = 0.005

SWEP.ShootTimeMult = 0.5

SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 15
SWEP.RecoilResetTime = 0.15 // time after you stop shooting for recoil to start dissipating
SWEP.RecoilDissipationRate = 20
SWEP.RecoilFirstShotMult = 1 // multiplier for the first shot's recoil amount

SWEP.RecoilVisualKick = 0.9

SWEP.RecoilKick = 3

SWEP.RecoilSpreadPenalty = 0.0005 // extra spread per one unit of recoil

SWEP.CanBlindFire = true

// handling

SWEP.MoveSpeedMult = 0.85
SWEP.ShootingSpeedMult = 0.5
SWEP.SightedSpeedMult = 0.4
SWEP.MeleeSpeedMult = 0.5
SWEP.MeleeSpeedMultTime = 2

SWEP.AimDownSightsTime = 0.275
SWEP.SprintToFireTime = 0.3
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

SWEP.SightAng = Angle(-0.95, -1.1, 1)
SWEP.SightPos = Vector(-4.78, -7.5, -3.45)

SWEP.CorrectivePos = Vector(0.5, 0, -0.55)
SWEP.CorrectiveAng = Angle(2.4, 0.34, 0)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_BACK
SWEP.HolsterPos = Vector(5, 0, -6)
SWEP.HolsterAng = Angle(0, 0, 0)

// reload

SWEP.ClipSize = 30
SWEP.Ammo = "smg1"

SWEP.ReloadTimeMult = 1
SWEP.DropMagazineModel = "models/weapons/tacint/magazines/pdw.mdl"
SWEP.DropMagazineImpact = "plastic"

// sounds

local path = "TacRP/weapons/pdw/"

SWEP.Sound_Shoot = "^" .. path .. "fire-1.wav"
SWEP.Sound_Shoot_Silenced = path .. "fire_silenced-1.wav"

SWEP.Vol_Shoot = 130
SWEP.ShootPitchVariance = 2.5 // amount to vary pitch by each shot

// effects

// the .qc attachment for the muzzle
SWEP.QCA_Muzzle = 1
// ditto for shell
SWEP.QCA_Eject = 2

SWEP.MuzzleEffect = "muzzleflash_ak47"
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
    ["foldstock"] = {
        BGs_VM = {
            {1, 1}
        },
        BGs_WM = {
            {1, 1}
        }
    },
    ["optic"] = {
        BGs_VM = {
            {2, 1}
        },
    },
    ["tactical"] = {
        BGs_VM = {
            {3, 1}
        },
    },
}

SWEP.Attachments = {
    [1] = {
        PrintName = "Optic",
        Category = {"optic_cqb", "optic_medium"},
        Bone = "pdw_ROOT",
        AttachSound = "TacRP/weapons/optic_on.wav",
        DetachSound = "TacRP/weapons/optic_off.wav",
        InstalledElements = {"optic"},
        VMScale = 1,
        Pos_VM = Vector(-4.8, -0.15, 6),
        Pos_WM = Vector(7, 1.5, -6.5),
        Ang_VM = Angle(90, 0, 0),
        Ang_WM = Angle(0, -3.5, 180),
    },
    [2] = {
        PrintName = "Muzzle",
        Category = "silencer",
        Bone = "pdw_ROOT",
        AttachSound = "TacRP/weapons/silencer_on.wav",
        DetachSound = "TacRP/weapons/silencer_off.wav",
        Pos_VM = Vector(-3.25, -0.1, 19),
        Pos_WM = Vector(24, 2.5, -5),
        Ang_VM = Angle(90, 0, 0),
        Ang_WM = Angle(0, -3.5, 180),
    },
    [3] = {
        PrintName = "Tactical",
        Category = "tactical",
        Bone = "pdw_ROOT",
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
        InstalledElements = {"tactical"},
        Pos_VM = Vector(-3.25, 0.5, 11),
        Pos_WM = Vector(14, 1.3, -5),
        Ang_VM = Angle(90, 0, 90),
        Ang_WM = Angle(0, -3.5, -90),
    },
    [4] = {
        PrintName = "Accessory",
        Category = {"foldstock", "perk", "perk_melee", "perk_shooting", "perk_reload", "perk_extendedmag", "perk_sling", "perk_duffle"},
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
        Category = {"ammo_rifle"},
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


addsound("TacInt_pdw.clip_out", path .. "clip_out-1.wav")
addsound("TacInt_pdw.clip_in", path .. "clip_in-1.wav")
addsound("TacInt_pdw.bolt_back", path .. "bolt_back-1.wav")
addsound("TacInt_pdw.bolt_shut", path .. "bolt_shut-1.wav")
addsound("TacInt_pdw.fire_select", path .. "fire_select-1.wav")
addsound("TacInt_pdw.Buttstock_Flip_Open", path .. "buttstock_flip_open-1.wav")
addsound("TacInt_pdw.Buttstock_lockdown", path .. "buttstock_lockdown-1.wav")