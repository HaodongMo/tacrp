SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "Jackal Knife"
SWEP.Category = "Tactical RP" // "Tactical RP (Arctic)"

SWEP.SubCatTier = "9Special"
SWEP.SubCatType = "9Equipment"

SWEP.Description = "Very edgy looking knife. Fast, but not very lethal.\nWORK IN PROGRESS"

SWEP.ViewModel = "models/weapons/tacint/v_knife2.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_knife2.mdl"

SWEP.NoRanger = true
SWEP.NoStatBox = true

SWEP.ArcadeStats = {
}

SWEP.Slot = 0

SWEP.NPCUsable = false

// misc. shooting

SWEP.MeleeDamage = 30
SWEP.MeleeAttackTime = 0.35

SWEP.Melee2Damage = 60
SWEP.Melee2AttackTime = 0.6
SWEP.Melee2Range = 72

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

SWEP.QuickNadeTimeMult = 0.8

SWEP.Scope = false

// hold types

SWEP.HoldType = "knife"
SWEP.HoldTypeSprint = "knife"

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_PISTOL
SWEP.GestureBash = ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
SWEP.GestureBash2 = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE

SWEP.MidAirSpreadPenalty = 0

SWEP.PassiveAng = Angle(0, 0, 0)
SWEP.PassivePos = Vector(2, 0, -5)

SWEP.SprintAng = Angle(0, 0, 0)
SWEP.SprintPos = Vector(2, 0, -5)

SWEP.SprintMidPoint = {
    Pos = Vector(2, 0, -5),
    Ang = Angle(0, 0, 0)
}

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_GEAR
SWEP.HolsterPos = Vector(2, 0, 0)
SWEP.HolsterAng = Angle(-90, -90, 15)

// sounds

local path = "tacrp/weapons/knife/"

SWEP.AnimationTranslationTable = {
    ["deploy"] = "deploy",
    ["melee"] = {"slash_left1", "slash_left2", "slash_right1", "slash_right2"},
    ["melee2"] = {"slash_forward1", "slash_forward2"},
    ["meleethrow"] = {"slash_right1", "slash_right2"},
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

SWEP.Sound_MeleeSwing = {
    path .. "swing-1.wav",
    path .. "swing-2.wav",
    path .. "swing-3.wav",
    path .. "swing-4.wav",
    path .. "swing-5.wav",
    path .. "swing-6.wav",
}

// attachments

SWEP.Attachments = {
    [1] = {
        PrintName = "Technique",
        Category = "melee_tech",
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [2] = {
        PrintName = "Special",
        Category = "melee_spec",
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
}

SWEP.FreeAim = false

SWEP.DrawCrosshair = true
SWEP.DrawCrosshairInSprint = true

local function addsound(name, spath)
    sound.Add({
        name = name,
        channel = 16,
        volume = 1.0,
        sound = spath
    })
end

function SWEP:PrimaryAttack()
    local stop = self:RunHook("Hook_PreShoot")
    if stop then return end

    self:Melee()
    return
end

function SWEP:GiveDefaultAmmo()
end