SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "Knife"
SWEP.Category = "Tactical RP" // "Tactical RP (Arctic)"

SWEP.SubCatTier = "9Special"
SWEP.SubCatType = "9Equipment"

SWEP.Description = "Stab."

SWEP.ViewModel = "models/weapons/tacint/v_knife.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_knife.mdl"

SWEP.NoRanger = true
SWEP.NoStatBox = true

SWEP.ArcadeStats = {
}

SWEP.Slot = 0

SWEP.NPCUsable = false

// misc. shooting

SWEP.MeleeDamage = 35
SWEP.MeleeAttackTime = 0.5

SWEP.Firemode = 2

SWEP.RPM = 120

SWEP.CanBlindFire = false

SWEP.Ammo = ""
SWEP.ClipSize = -1
SWEP.Primary.ClipSize = -1

// handling

SWEP.MoveSpeedMult = 1

SWEP.MeleeSpeedMult = 1
SWEP.MeleeSpeedMultTime = 0.5

SWEP.SprintToFireTime = 0.25

SWEP.Scope = false

// hold types

SWEP.HoldType = "knife"
SWEP.HoldTypeSprint = "knife"

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_PISTOL
SWEP.GestureBash = ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE

SWEP.PassiveAng = Angle(0, 0, 0)
SWEP.PassivePos = Vector(2, 0, -5)

SWEP.SprintAng = Angle(0, 0, 0)
SWEP.SprintPos = Vector(2, 0, -5)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_GEAR
SWEP.HolsterPos = Vector(2, 0, 0)
SWEP.HolsterAng = Angle(-90, -90, 15)

// sounds

local path = "tacrp/weapons/knife/"

SWEP.AnimationTranslationTable = {
    ["deploy"] = "deploy",
    ["melee"] = {"slash_left1", "slash_left2", "slash_right1", "slash_right2", "slash_forward1", "slash_forward2"}
}

SWEP.Sound_MeleeHit = {
    path .. "/scrape_metal-1.wav",
    path .. "/scrape_metal-2.wav",
    path .. "/scrape_metal-3.wav",
}

SWEP.Sound_MeleeHitBody = {
    path .. "/flesh_hit-1.wav",
    path .. "/flesh_hit-2.wav",
    path .. "/flesh_hit-3.wav",
    path .. "/flesh_hit-4.wav",
    path .. "/flesh_hit-5.wav",
}

// attachments

SWEP.Attachments = {
    [1] = {
        PrintName = "Accessory",
        Category = {"acc_holster"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [2] = {
        PrintName = "Perk",
        Category = {"perk_throw"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    }
}

SWEP.FreeAim = false

SWEP.DrawCrosshair = false

local function addsound(name, spath)
    sound.Add({
        name = name,
        channel = 16,
        volume = 1.0,
        sound = spath
    })
end

function SWEP:PrimaryAttack()
    self:Melee()
    return
end

function SWEP:SecondaryAttack()
end

function SWEP:GiveDefaultAmmo()
end