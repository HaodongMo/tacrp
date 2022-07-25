SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "RPG-7"
SWEP.Category = "Tactical RP (Arctic)"

SWEP.Description = "Soviet rocket launcher with powerful explosion."

SWEP.ViewModel = "models/weapons/tacint/v_rpg7.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_rpg7.mdl"

SWEP.NoRanger = true

SWEP.Slot = 3

// "ballistics"

SWEP.ShootEnt = "tacrp_proj_rpg7"
SWEP.ShootEntForce = 10000

SWEP.Num = 1

// misc. shooting

SWEP.Firemode = 1

SWEP.RPM = 150

SWEP.Spread = 0.01

SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 10
SWEP.RecoilResetTime = 0.1// time after you stop shooting for recoil to start dissipating
SWEP.RecoilDissipationRate = 10
SWEP.RecoilFirstShotMult = 1 // multiplier for the first shot's recoil amount

SWEP.RecoilVisualKick = 3
SWEP.RecoilVisualShake = 0.2

SWEP.RecoilKick = 25

SWEP.RecoilSpreadPenalty = 0.35 // extra spread per one unit of recoil

SWEP.CanBlindFire = true

// handling

SWEP.MoveSpeedMult = 0.85
SWEP.ShootingSpeedMult = 0.25 // slow down applied while shooting
SWEP.SightedSpeedMult = 0.5
SWEP.MeleeSpeedMult = 0.5
SWEP.MeleeSpeedMultTime = 2 // seconds to apply slow down for

SWEP.AimDownSightsTime = 0.5
SWEP.SprintToFireTime = 0.5 // multiplies how long it takes to recover from sprinting

// hold types

SWEP.HoldType = "rpg"
SWEP.HoldTypeSprint = "passive"
SWEP.HoldTypeBlindFire = false
SWEP.HoldTypeNPC = "ar2"

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_AR2

SWEP.PassiveAng = Angle(0, 0, 0)
SWEP.PassivePos = Vector(2, -2, -6)

SWEP.BlindFireAng = Angle(0, 0, 0)
SWEP.BlindFirePos = Vector(1, -3, 0)

SWEP.BlindFireCornerAng = Angle(75, 0, 0)
SWEP.BlindFireCornerPos = Vector(8, 10, -6)

SWEP.SprintAng = Angle(40, -15, 0)
SWEP.SprintPos = Vector(4, 0, -4)

SWEP.SightAng = Angle(0.03, -0.4, 0)
SWEP.SightPos = Vector(-3.57, -6.5, -5.1)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_BACK
SWEP.HolsterPos = Vector(5, 0, -6)
SWEP.HolsterAng = Angle(0, 0, 0)

// sway

SWEP.Sway = 5
SWEP.ScopedSway = 0.25

// melee

SWEP.CanMeleeAttack = false

// reload

SWEP.ClipSize = 1
SWEP.Ammo = "rpg_round"

SWEP.BulletBodygroups = {
    [1] = {5, 1}
}

// sounds

local path = "TacRP/weapons/rpg7/"

SWEP.Sound_Shoot = "^" .. path .. "fire-1.wav"

SWEP.Vol_Shoot = 130
SWEP.ShootPitchVariance = 2.5 // amount to vary pitch by each shot

// effects

// the .qc attachment for the muzzle
SWEP.QCA_Muzzle = 1
// ditto for shell
SWEP.QCA_Eject = 2

SWEP.MuzzleEffect = "muzzleflash_1"

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
    ["blind_fire"] = "aimed_fire",
    ["blind_idle"] = "aimed_idle",
}

// attachments

SWEP.Attachments = {
    [1] = {
        PrintName = "Accessory",
        Category = {"perk", "perk_reload", "perk_blindfire", "perk_duffle"},
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

addsound("TacInt_rpg7.jingle", path .. "handling-1.wav")
addsound("TacInt_rpg7.insert_rocket", path .. "insert_rocket.wav")
addsound("TacInt_rpg7.flipup_sight", path .. "flipup_sight.wav")