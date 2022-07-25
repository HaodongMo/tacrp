SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "MAC-10"
SWEP.Category = "Tactical RP (Extras)"

SWEP.Description = "Common bullet hose machine pistol. A cheaply made weapon with subpar ironsights and better suited for spray-and-pray."

SWEP.ViewModel = "models/weapons/tacint_extras/v_mac10.mdl"
SWEP.WorldModel = "models/weapons/tacint_extras/w_mac10.mdl"

SWEP.Slot = 2

// "ballistics"

SWEP.Damage_Max = 11
SWEP.Damage_Min = 5
SWEP.Range_Min = 750
SWEP.Range_Max = 3000
SWEP.Penetration = 3

SWEP.MuzzleVelocity = 10000

SWEP.BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 0.75,
    [HITGROUP_RIGHTLEG] = 0.75,
    [HITGROUP_GEAR] = 0.9
}

// misc. shooting

SWEP.Firemode = 2

SWEP.RPM = 1000

SWEP.Spread = 0.01

SWEP.HipFireSpreadPenalty = 0.015

SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 15
SWEP.RecoilResetTime = 0.1 // time after you stop shooting for recoil to start dissipating
SWEP.RecoilDissipationRate = 45
SWEP.RecoilFirstShotMult = 1 // multiplier for the first shot's recoil amount

SWEP.RecoilVisualKick = 1.5

SWEP.RecoilKick = 2

SWEP.RecoilSpreadPenalty = 0.002

SWEP.CanBlindFire = true

// handling

SWEP.MoveSpeedMult = 0.9
SWEP.ShootingSpeedMult = 0.75
SWEP.SightedSpeedMult = 0.4
SWEP.MeleeSpeedMult = 0.5
SWEP.MeleeSpeedMultTime = 2

SWEP.AimDownSightsTime = 0.275
SWEP.SprintToFireTime = 0.30

// hold types

SWEP.HoldType = "revolver"
SWEP.HoldTypeSprint = "normal"
SWEP.HoldTypeBlindFire = false

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_PISTOL

SWEP.PassiveAng = Angle(0, 0, 0)
SWEP.PassivePos = Vector(0, -2, -5)

SWEP.BlindFireAng = Angle(0, 5, 0)
SWEP.BlindFirePos = Vector(0, -2, -5)

SWEP.SprintAng = Angle(0, 30, 0)
SWEP.SprintPos = Vector(2, 0, -12)

SWEP.SightAng = Angle(-0.05, 0.12, 0)
SWEP.SightPos = Vector(-3.4, -6, -4.05)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_PISTOL
SWEP.HolsterPos = Vector(0, 3, -4)
SWEP.HolsterAng = Angle(90, 0, 0)

SWEP.Sway = 2
SWEP.ScopedSway = 0.25

// reload

SWEP.ClipSize = 40
SWEP.Ammo = "pistol"

SWEP.ReloadTimeMult = 1.2

SWEP.DropMagazineModel = "models/weapons/tacint_extras/magazines/mac10.mdl"
SWEP.DropMagazineImpact = "pistol"

// sounds

local path = "tacrp_extras/mac10/"

SWEP.Sound_Shoot = "^" .. path .. "mac10-1.wav"
SWEP.Sound_Shoot_Silenced = path .. "mac10-suppressed-1.wav"

SWEP.Vol_Shoot = 110
SWEP.Pitch_Shoot = 100
SWEP.Loudness_Shoot = 1
SWEP.ShootPitchVariance = 3

// effects

// the .qc attachment for the muzzle
SWEP.QCA_Muzzle = 1

SWEP.MuzzleEffect = "muzzleflash_pistol"

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
    ["deploy"] = "draw",
    ["fire"] = {"shoot1", "shoot2", "shoot3"},
    ["blind_fire"] = {"blind_shoot1", "blind_shoot2", "blind_shoot3"},
    ["melee"] = {"melee1", "melee2"}
}

SWEP.ShootTimeMult = 0.5

SWEP.LastShot = false

// attachmentsc

SWEP.AttachmentElements = {
    ["foldstock"] = {
        BGs_VM = {
            {1, 1}
        },
        BGs_WM = {
            {1, 1}
        }
    },
    ["pistol_comp"] = {
        BGs_VM = {
            {2, 1}
        },
        BGs_WM = {
            {2, 1}
        },
    },
}

SWEP.Attachments = {
    -- [1] = {
    --     PrintName = "Optic",
    --     Category = "optic_pistol",
    --     Bone = "xd45_rig.xd45_ROOT",
    --     WMBone = "Box01",
    --     AttachSound = "tacrp/weapons/optic_on.wav",
    --     DetachSound = "tacrp/weapons/optic_off.wav",
    --     VMScale = 1,
    --     WMScale = 1,
    --     Pos_VM = Vector(-3.7, 0, -1.5),
    --     Ang_VM = Angle(90, 0, 0),
    --     Pos_WM = Vector(0, -1, -1),
    --     Ang_WM = Angle(0, -90, 0),
    -- },
    [1] = {
        PrintName = "Muzzle",
        Category = {"comp_mac10", "silencer"},
        Bone = "xd45_rig.xd45_ROOT",
        WMBone = "Box01",
        AttachSound = "tacrp/weapons/silencer_on.wav",
        DetachSound = "tacrp/weapons/silencer_off.wav",
        VMScale = 0.75,
        WMScale = 0.75,
        Pos_VM = Vector(-2.8, 0, 11),
        Ang_VM = Angle(90, 0, 0),
        Pos_WM = Vector(0, 10, -1.6),
        Ang_WM = Angle(0, -90, 0),
    },
    [2] = {
        PrintName = "Tactical",
        Category = "tactical",
        Bone = "xd45_rig.xd45_ROOT",
        WMBone = "Box01",
        AttachSound = "tacrp/weapons/flashlight_on.wav",
        DetachSound = "tacrp/weapons/flashlight_off.wav",
        VMScale = 0.8,
        WMScale = 1,
        Pos_VM = Vector(-1.6, 0, 6),
        Ang_VM = Angle(90, 0, 180),
        Pos_WM = Vector(0, 4, -2.75),
        Ang_WM = Angle(0, -90, 180),
    },
    [3] = {
        PrintName = "Accessory",
        Category = {"foldstock", "perk", "perk_melee", "perk_shooting", "perk_reload", "perk_extmag_smg", "perk_conceal"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [4] = {
        PrintName = "Bolt",
        Category = {"bolt_automatic"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [5] = {
        PrintName = "Trigger",
        Category = {"trigger_auto"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [6] = {
        PrintName = "Ammo",
        Category = {"ammo_pistol"},
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

addsound("tacint_extras_mac10.clip_in", path .. "mac10_clipin.wav")
addsound("tacint_extras_mac10.clip_out", path .. "mac10_clipout.wav")
-- addsound("tacint_extras_mac10.clip_slap", path2 .. "clip_slap-1.wav")
addsound("tacint_extras_mac10.slide_back", path .. "mac10_boltpull.wav")
addsound("tacint_extras_mac10.slide_forward", path .. "mac10_boltpull2.wav")
addsound("tacint_extras_mac10.slide_shut", path .. "mac10_boltpull2.wav")

-- addsound("tacint_extras_mac10.slide_shut", {
--     path .. "slide_shut-1.wav",
--     path .. "slide_shut-2.wav",
--     path .. "slide_shut-3.wav",
-- })
-- addsound("tacint_extras_mac10.cock_hammer", path .. "cockhammer.wav")
-- addsound("tacint_extras_mac10.safety_switch", path .. "safety_switch.wav")
