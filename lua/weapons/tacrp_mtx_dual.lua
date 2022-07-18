SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "Dual MTX"
SWEP.Category = "Tactical RP (Arctic)"

// Tier 4
SWEP.Description = "An elite pair of high capacity, high damage pistols.\nWith firepower like this, who needs aiming?"

SWEP.ViewModel = "models/weapons/tacint/v_mtx_dual.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_mtx.mdl"

SWEP.Slot = 2

// "ballistics"

SWEP.Damage_Max = 25
SWEP.Damage_Min = 10
SWEP.Range_Min = 1600 // distance for which to maintain maximum damage
SWEP.Range_Max = 5000 // distance at which we drop to minimum damage
SWEP.Penetration = 1 // units of metal this weapon can penetrate

SWEP.MuzzleVelocity = 9500

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

SWEP.Firemode = 1

SWEP.RPM = 800

SWEP.Spread = 0.02

SWEP.MoveSpreadPenalty = 0
SWEP.MidAirSpreadPenalty = 0
SWEP.HipFireSpreadPenalty = 0

SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 15
SWEP.RecoilResetTime = 0.15
SWEP.RecoilDissipationRate = 15
SWEP.RecoilFirstShotMult = 1 // multiplier for the first shot's recoil amount

SWEP.RecoilVisualKick = 1

SWEP.RecoilKick = 4

SWEP.RecoilSpreadPenalty = 0.002 // extra spread per one unit of recoil

SWEP.Sway = 0.5

SWEP.CanBlindFire = false

// handling

SWEP.MoveSpeedMult = 0.88
SWEP.ShootingSpeedMult = 0.65
SWEP.SightedSpeedMult = 0.5
SWEP.MeleeSpeedMult = 0.5
SWEP.MeleeSpeedMultTime = 2

SWEP.AimDownSightsTime = 0.25
SWEP.SprintToFireTime = 0.25

// hold types

SWEP.HoldType = "duel"
SWEP.HoldTypeSprint = "normal"
SWEP.HoldTypeBlindFire = false

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_DUEL
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_DUEL

SWEP.PassiveAng = Angle(5, 0, -2)
SWEP.PassivePos = Vector(3, 0, -6)

SWEP.CustomizeAng = Angle(0, 35, 0)
SWEP.CustomizePos = Vector(1, 0, -12)

SWEP.BlindFireAng = Angle(0, 5, 0)
SWEP.BlindFirePos = Vector(0, 0, -5)

SWEP.SprintAng = Angle(0, 30, 0)
SWEP.SprintPos = Vector(1, 0, -12)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_PISTOL
SWEP.HolsterPos = Vector(0, 3, -4)
SWEP.HolsterAng = Angle(60, 5, 0)

// reload

SWEP.ClipSize = 30
SWEP.Ammo = "pistol"

SWEP.ReloadTimeMult = 1

SWEP.DropMagazineModel = "models/weapons/tacint/magazines/gsr1911.mdl"
SWEP.DropMagazineImpact = "pistol"
SWEP.DropMagazineAmount = 2

// sounds

local path = "tacrp/weapons/mtx/"

SWEP.Sound_Shoot = "^" .. path .. "fire-1.wav"

SWEP.Vol_Shoot = 110
SWEP.ShootPitchVariance = 2.5 // amount to vary pitch by each shot

// effects

// the .qc attachment for the muzzle
SWEP.QCA_Muzzle = 4

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
    ["blind_fire"] = "blind_shoot1",
    ["melee"] = {"melee1", "melee2"},
    ["shoot_left"] = {"shoot_left-1", "shoot_left-2"},
    ["shoot_right"] = {"shoot_right-1", "shoot_right-2"}
}

SWEP.LastShot = true
SWEP.Akimbo = true

// attachments

SWEP.Attachments = {
    [1] = {
        PrintName = "Accessory",
        Category = {"perk", "perk_melee", "perk_shooting", "perk_reload", "perk_conceal",},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [2] = {
        PrintName = "Trigger",
        Category = {"trigger_akimbo"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [3] = {
        PrintName = "Ammo",
        Category = {"ammo_pistol"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    }
}

SWEP.AttachmentCapacity = 30 // amount of "Capacity" this gun can accept

local function addsound(name, spath)
    sound.Add({
        name = name,
        channel = 16,
        volume = 1.0,
        sound = spath
    })
end

addsound("tacint_mtx.clip_in_left", path .. "clip_in-1.wav")
addsound("tacint_mtx.clip_in_right", path .. "clip_in-2.wav")
addsound("tacint_mtx.clip_out", path .. "clip_out.wav")
addsound("tacint_mtx.slide_back", path .. "slide_back.wav")
addsound("tacint_mtx.slide_release", path .. "slide_release.wav")
addsound("tacint_mtx.slide_shut",{
    path .. "slide_shut.wav",
    path .. "slide_shut-1.wav",
    path .. "slide_shut-2.wav",
})

SWEP.Scope = false

SWEP.FreeAim = false