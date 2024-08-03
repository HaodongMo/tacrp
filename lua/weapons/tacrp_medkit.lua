SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()
DEFINE_BASECLASS( "tacrp_base" )

// names and stuff
SWEP.PrintName = "First Aid Kit"
SWEP.Category = "Tactical RP (Special)"

SWEP.SubCatTier = "9Special"
SWEP.SubCatType = "9Equipment"

SWEP.Description = "Compact pack of medical supplies for treating wounds."
SWEP.Credits = "Model/Texture: Left 4 Dead 2\nAnimation: Arqu"

SWEP.ViewModel = "models/weapons/tacint/v_medkit.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_medkit.mdl"

SWEP.NoRanger = true
SWEP.NoStatBox = true
SWEP.HUDAmmoMeter = true

SWEP.Slot = 4

SWEP.NPCUsable = false
SWEP.FreeAim = false

// misc. shooting

SWEP.CanBlindFire = false

SWEP.Ammo = ""
SWEP.ClipSize = 30

// handling

SWEP.NoBuffer = true

SWEP.Firemode = 0

SWEP.MoveSpeedMult = 1

SWEP.MeleeSpeedMultTime = 2 // seconds to apply slow down for

SWEP.SprintToFireTime = 0.25

SWEP.MidAirSpreadPenalty = 0
SWEP.MoveSpreadPenalty = 0
SWEP.HipFireSpreadPenalty = 0

SWEP.Scope = false
SWEP.NoSecondaryMelee = true

// hold types

SWEP.HoldType = "slam"
SWEP.HoldTypeSprint = "normal"

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_PISTOL

SWEP.PassiveAng = Angle(0, 0, 0)
SWEP.PassivePos = Vector(-2, 0, -3)

SWEP.SprintAng = Angle(0, 0, 0)
SWEP.SprintPos = Vector(2, 0, -4)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_GEAR
SWEP.HolsterPos = Vector(-3, -5, 0)
SWEP.HolsterAng = Angle(-90, -90, 15)


SWEP.SprintMidPoint = {
    Pos = Vector(0.25, 2, 1),
    Ang = Angle(0, -5, 10)
}

// sounds

SWEP.AnimationTranslationTable = {
    ["deploy"] = "draw",
    ["melee"] = {"melee1", "melee2"},
}
SWEP.NoHolsterAnimation = true
SWEP.HolsterTimeMult = 0.75

// attachments

SWEP.Attachments = {
    [1] = {
        PrintName = "Perk",
        Category = {"perk_melee", "perk_throw", "perk_passive"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    }
}

function SWEP:Hook_GetHintCapabilities(tbl)
    if TacRP.ConVars["medkit_heal_others"]:GetInt() > 0 then
        tbl["+attack"] = {so = 0, str = "hint.medkit.others"}
    end
    if TacRP.ConVars["medkit_heal_self"]:GetInt() > 0 then
        tbl["+attack2"] = {so = 0.1, str = "hint.medkit.self"}
    end
end

SWEP.HealTarget = nil

SWEP.LoopSound = nil

function SWEP:PrimaryAttack()
    if self:GetValue("Melee") and self:GetOwner():KeyDown(IN_USE) then
        self.Primary.Automatic = true
        self:Melee()
        return
    end

    if self:StillWaiting() then return end
    if self:GetCharge() then return end
    if TacRP.ConVars["medkit_heal_others"]:GetInt() <= 0 then return end

    local tr = util.TraceLine({
        start = self:GetOwner():EyePos(),
        endpos = self:GetOwner():EyePos() + (self:GetOwner():EyeAngles():Forward() * 32),
        filter = self:GetOwner()
    })

    if !tr.Hit then return end
    if !tr.Entity then return end

    if !(tr.Entity:IsPlayer() or tr.Entity:IsNPC()) then return end

    if tr.Entity:Health() >= tr.Entity:GetMaxHealth() then return end

    self.HealTarget = tr.Entity

    self.Primary.Automatic = false

    self:PlayAnimation("unzip", 1, true)

    self:SetCharge(true)

    if self.LoopSound then
        self.LoopSound:Stop()
        self.LoopSound = nil
    end

    self.LoopSound = CreateSound(self, "tacrp/weapons/bandaging_1.wav")
    self.LoopSound:Play()
end

function SWEP:OnRemove()
    if self.LoopSound then
        self.LoopSound:Stop()
        self.LoopSound = nil
    end

    return BaseClass.OnRemove(self)
end

function SWEP:SecondaryAttack()
    if self:StillWaiting() or !IsFirstTimePredicted() or self:GetCharge() then return end

    if self:GetOwner():Health() >= self:GetOwner():GetMaxHealth() then return end
    if TacRP.ConVars["medkit_heal_self"]:GetInt() <= 0 then return end

    self.HealTarget = self:GetOwner()

    self.Primary.Automatic = false
    self.Secondary.Automatic = false

    self:PlayAnimation("unzip", 1, true)

    self:SetCharge(true)

    if self.LoopSound then
        self.LoopSound:Stop()
        self.LoopSound = nil
    end

    self.LoopSound = CreateSound(self:GetOwner(), "tacrp/weapons/bandaging_1.wav")
    self.LoopSound:Play()
end

function SWEP:Think()
    if IsFirstTimePredicted() and self:GetCharge() and self:GetNextPrimaryFire() < CurTime() then
        if !IsValid(self.HealTarget) or
        self:Clip1() <= 0 or
        (self.HealTarget:GetPos() - self:GetOwner():GetPos()):Length() > 64
        or
        (self.HealTarget:Health() >= self.HealTarget:GetMaxHealth()) or
        !(self:GetOwner():KeyDown(IN_ATTACK) or self:GetOwner():KeyDown(IN_ATTACK2)) then
            self.HealTarget = nil
            self:SetCharge(false)
            self:PlayAnimation("draw", 1, true)

            if self.LoopSound then
                self.LoopSound:Stop()
                self.LoopSound = nil
            end
        else
            if SERVER then
                local selfheal = self.HealTarget == self:GetOwner()
                local amt = TacRP.ConVars[selfheal and "medkit_heal_self" or "medkit_heal_others"]:GetInt()
                local ret = {amt}
                hook.Run("TacRP_MedkitHeal", self, self:GetOwner(), self.HealTarget, ret)
                amt = ret and ret[1] or amt
                self:SetClip1(self:Clip1() - 1)
                self.HealTarget:SetHealth(math.min(self.HealTarget:Health() + amt, self.HealTarget:GetMaxHealth()))
            end
            self:SetNextPrimaryFire(CurTime() + TacRP.ConVars["medkit_interval"]:GetFloat())
        end
    end

    return BaseClass.Think(self)
end

function SWEP:Regenerate()
    if CLIENT then return end
    if self:GetNextPrimaryFire() + 0.1 > CurTime() then return end
    local amt = TacRP.ConVars["medkit_regen_amount"]:GetInt()
    if amt == 0 then
        if self:Clip1() == 0 then
            self:Remove()
        end
        return
    end
    if TacRP.ConVars["medkit_regen_activeonly"]:GetBool()
            and (!IsValid(self:GetOwner()) or self:GetOwner():GetActiveWeapon() != self) then return end
    self:SetClip1(math.min(self:Clip1() + amt, self:GetValue("ClipSize")))
end

function SWEP:Holster(wep)
    if self.LoopSound then
        self.LoopSound:Stop()
        self.LoopSound = nil
    end

    self:SetCharge(false)
    self.HealTarget = nil

    return BaseClass.Holster(self, wep)
end

function SWEP:OnRemove()
    if game.SinglePlayer() then
        self:CallOnClient("OnRemove")
    end

    if self.LoopSound then
        self.LoopSound:Stop()
        self.LoopSound = nil
    end

    return BaseClass.OnRemove(self)
end

function SWEP:Initialize()

    self.ClipSize = TacRP.ConVars["medkit_clipsize"]:GetInt()

    self:SetClip1(self:GetValue("ClipSize"))

    self:SetCharge(false)

    timer.Create("medkit_ammo" .. self:EntIndex(), TacRP.ConVars["medkit_regen_delay"]:GetFloat(), 0, function()
        if !IsValid(self) then
            if self.LoopSound then
                self.LoopSound:Stop()
                self.LoopSound = nil
            end
            timer.Stop("medkit_ammo" .. self:EntIndex())
            return
        end
        if IsValid(self:GetOwner()) and self != self:GetOwner():GetActiveWeapon() then
            if self.LoopSound then
                self.LoopSound:Stop()
                self.LoopSound = nil
            end
        end
        self:Regenerate()
    end)

    return BaseClass.Initialize(self)
end

if engine.ActiveGamemode() == "terrortown" then
    SWEP.HolsterVisible = false
    SWEP.AutoSpawnable = false
    SWEP.Kind = WEAPON_EQUIP2
    SWEP.Slot  = 6
    SWEP.CanBuy = { ROLE_DETECTIVE, ROLE_TRAITOR }
    SWEP.LimitedStock = true
    SWEP.EquipMenuData = {
        type = "Weapon",
        desc = "Medical supplies for treating wounds.\nCharge regenrates over time.",
    }

    function SWEP:TTTBought(buyer)
    end
end

function SWEP:Reload()
end // do nothing