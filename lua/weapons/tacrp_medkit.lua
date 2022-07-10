SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()
DEFINE_BASECLASS( "tacrp_base" )

// names and stuff
SWEP.PrintName = "First Aid Kit"
SWEP.Category = "Tactical RP (Arctic)"

SWEP.Description = "Compact pack of medical supplies for fixing anything from gunshot wounds to broken bones and bruises. Supplies regenerate over time."

SWEP.ViewModel = "models/weapons/tacint/v_medkit.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_medkit.mdl"

SWEP.NoRanger = true
SWEP.NoStatBox = true

SWEP.Slot = 4

SWEP.NPCUsable = false
SWEP.FreeAim = false

// misc. shooting

SWEP.CanBlindFire = false

SWEP.Ammo = ""
SWEP.ClipSize = 30

// handling

SWEP.MoveSpeedMult = 1

SWEP.MeleeSpeedMult = 0.5
SWEP.MeleeSpeedMultTime = 2 // seconds to apply slow down for

SWEP.SprintToFireTime = 0.25

SWEP.Scope = false

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
    ["melee"] = {"melee1", "melee2"}
}

// attachments

SWEP.Attachments = {}

SWEP.HealTarget = nil

SWEP.LoopSound = nil

function SWEP:PrimaryAttack()
    if self:GetValue("Melee") then
        if self:GetOwner():KeyDown(IN_USE) then
            self.Primary.Automatic = true
            self:Melee()
            return
        end
    end

    if self:StillWaiting() then return end
    if self:GetCharge() then return end

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

function SWEP:Holster()
    if self.LoopSound then
        self.LoopSound:Stop()
        self.LoopSound = nil
    end

    return BaseClass.Holster(self)
end

function SWEP:SecondaryAttack()
    if self:StillWaiting() then return end
    if self:GetCharge() then return end

    if self:GetOwner():Health() >= self:GetOwner():GetMaxHealth() then return end

    self.HealTarget = self:GetOwner()

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
    if IsFirstTimePredicted() then
        if self:GetCharge() then
            if self:GetNextPrimaryFire() < CurTime() then
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
                    local hp = self.HealTarget:Health()
                    hp = hp + 3
                    hp = math.min(hp, self.HealTarget:GetMaxHealth())
                    self:SetClip1(self:Clip1() - 1)
                    self.HealTarget:SetHealth(hp)

                    self:SetNextPrimaryFire(CurTime() + 0.33)
                end
            end
        end
    end

    return BaseClass.Think(self)
end

function SWEP:Regenerate()
    if CLIENT then return end
    if self:GetNextPrimaryFire() + 0.1 > CurTime() then return end

    local amt = self:Clip1()

    amt = amt + 1

    amt = math.min(amt, 30)

    self:SetClip1(amt)
end

function SWEP:Holster()
    if self.LoopSound then
        self.LoopSound:Stop()
        self.LoopSound = nil
    end

    self:SetCharge(false)
    self.HealTarget = nil

    return BaseClass.Holster(self)
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
    self:SetClip1(30)

    self:SetCharge(false)

    timer.Create("medkit_ammo" .. self:EntIndex(), 1, 0, function()
        if !IsValid(self) then
            if self.LoopSound then
                self.LoopSound:Stop()
                self.LoopSound = nil
            end
            timer.Stop("medkit_ammo" .. self:EntIndex())
            return
        end
        if self != self:GetOwner():GetActiveWeapon() then
            if self.LoopSound then
                self.LoopSound:Stop()
                self.LoopSound = nil
            end
        end
        self:Regenerate()
    end )

    return BaseClass.Initialize(self)
end