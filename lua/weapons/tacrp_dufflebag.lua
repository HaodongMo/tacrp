SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "Duffle Bag"
SWEP.Category = "Tactical RP (Arctic)"

SWEP.Description = "Carry entities around."

SWEP.ViewModel = ""
SWEP.WorldModel = ""

SWEP.NoRanger = true
SWEP.NoStatBox = true

SWEP.Slot = 3

SWEP.NPCUsable = false

// misc. shooting

SWEP.Firemode = 0

SWEP.CanBlindFire = false

SWEP.Ammo = ""
SWEP.ClipSize = -1

// handling

SWEP.MoveSpeedMult = 1

SWEP.MeleeSpeedMult = 0.5
SWEP.MeleeSpeedMultTime = 2 // seconds to apply slow down for

SWEP.SprintToFireTime = 0.25

SWEP.Scope = false

// hold types

SWEP.HoldType = "normal"
SWEP.HoldTypeSprint = "normal"

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_PISTOL

SWEP.PassiveAng = Angle(0, 0, 0)
SWEP.PassivePos = Vector(0, -2, -5)

SWEP.SprintAng = Angle(0, 30, 0)
SWEP.SprintPos = Vector(2, 0, -12)

SWEP.HolsterVisible = true
SWEP.HolsterModel = "models/jessev92/payday2/item_bag_loot.mdl"
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_BACK
SWEP.HolsterPos = Vector(7, -2, 0)
SWEP.HolsterAng = Angle(10, 90, 90)

SWEP.PocketItems = 5
SWEP.Contents = {}

// sounds

// attachments

SWEP.Attachments = {}

SWEP.DrawCrosshair = false

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:GiveDefaultAmmo()
end