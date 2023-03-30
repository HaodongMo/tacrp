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

SWEP.Sway = 0

SWEP.QuickNadeTimeMult = 0.6

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
    elseif !self:GetPrimedGrenade() then
        local nade = TacRP.QuickNades[self:GetValue("PrimaryGrenade")]
        if !TacRP.IsGrenadeInfiniteAmmo(nade) and self:GetOwner():GetAmmoCount(nade.Ammo) == 0 then
            if SERVER then
                self:Remove()
            elseif CLIENT and IsValid(self:GetOwner():GetPreviousWeapon()) and self:GetOwner():GetPreviousWeapon():IsWeapon() then
                input.SelectWeapon(self:GetOwner():GetPreviousWeapon())
            end
        end
    end
end

function SWEP:PrimaryAttack()

    self.Primary.Automatic = false
    self.Secondary.Automatic = false
    self.GrenadeDownKey = IN_ATTACK
    self.GrenadeThrowOverride = false

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

    self:PrimeGrenade()
    self:SetNextPrimaryFire(self:GetAnimLockTime())
    self:SetNextSecondaryFire(self:GetAnimLockTime())

    self:RunHook("Hook_PostShoot")

    if game.SinglePlayer() and SERVER then self:CallOnClient("PrimaryAttack") end
end

function SWEP:SecondaryAttack()

    self.Primary.Automatic = false
    self.Secondary.Automatic = false
    self.GrenadeDownKey = IN_ATTACK2
    self.GrenadeThrowOverride = true

    if self:StillWaiting() then
        return
    end

    self:SetBaseSettings()

    local stop = self:RunHook("Hook_PreShoot")
    if stop then return end

    self:PrimeGrenade()
    self:SetNextPrimaryFire(self:GetAnimLockTime())
    self:SetNextSecondaryFire(self:GetAnimLockTime())

    self:RunHook("Hook_PostShoot")

    if game.SinglePlayer() and SERVER then self:CallOnClient("SecondaryAttack") end
end

function SWEP:Reload()
end