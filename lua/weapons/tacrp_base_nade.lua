AddCSLuaFile()

SWEP.Base = "tacrp_base"

// spawnable
SWEP.Spawnable = false
SWEP.AdminOnly = false

// names and stuff
SWEP.PrintName = "Arctic's Tactical RP Base Grenade"
SWEP.Category = "Tactical RP" // "Tactical RP (Arctic)"

SWEP.SubCatTier = "9Special"
SWEP.SubCatType = "9Throwable"

SWEP.Description = ""

SWEP.ViewModel = "models/weapons/cstrike/c_eq_fraggrenade.mdl"
SWEP.WorldModel = "models/weapons/w_eq_fraggrenade.mdl"

SWEP.ViewModelFOV = 65

SWEP.NoRanger = true
SWEP.NoStatBox = true
SWEP.NPCUsable = false

SWEP.Slot = 4

SWEP.FreeAim = false

SWEP.DrawCrosshair = true
SWEP.DrawCrosshairInSprint = true
SWEP.CrosshairStatic = true

SWEP.Scope = false
SWEP.CanBlindFire = false
SWEP.CanQuickNade = false

SWEP.Firemode = 0

SWEP.Ammo = ""
SWEP.PrimaryGrenade = ""

function SWEP:GiveDefaultAmmo()
end

function SWEP:ThinkSprint()
end

function SWEP:ThinkSights()
end

function SWEP:ThinkGrenade()
    if self:GetPrimedGrenade() and self:GetAnimLockTime() < CurTime() and !self:GetOwner():KeyDown(self.GrenadeDownKey) then
        self:ThrowGrenade()
        self:SetPrimedGrenade(false)
    end
end

function SWEP:PrimaryAttack()

    self.Primary.Automatic = false
    self.Secondary.Automatic = false

    if self:GetValue("Melee") and self:GetOwner():KeyDown(IN_USE) then
        self:Melee()
        return
    end

    if self:StillWaiting() then
        return
    end

    self:SetBaseSettings()

    local stop = self:RunHook("Hook_PreShoot")
    if stop then return end

    self.GrenadeDownKey = IN_ATTACK
    self.GrenadeThrowOverride = false

    self:PrimeGrenade()

    self:RunHook("Hook_PostShoot")
end

function SWEP:SecondaryAttack()

    self.Primary.Automatic = false
    self.Secondary.Automatic = false

    if self:StillWaiting() then
        return
    end

    self:SetBaseSettings()

    local stop = self:RunHook("Hook_PreShoot")
    if stop then return end

    self.GrenadeDownKey = IN_ATTACK2
    self.GrenadeThrowOverride = true

    self:PrimeGrenade()

    self:RunHook("Hook_PostShoot")
end

function SWEP:Reload()
end