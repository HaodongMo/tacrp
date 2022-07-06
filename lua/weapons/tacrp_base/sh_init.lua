function SWEP:DoDeployAnimation()
    if self:GetReloading() and !self:GetValue("ShotgunReload") then
        if self:HasSequence("midreload") then
            local t = self:PlayAnimation("midreload", self:GetValue("ReloadTimeMult"), true, true)

            self:SetTimer(t, function()
                self:EndReload()
            end)
        end
    else
        if self:GetValue("TryUnholster") then
            self:PlayAnimation("unholster", self:GetValue("DeployTimeMult"), true, true)
        else
            self:PlayAnimation("deploy", self:GetValue("DeployTimeMult"), true, true)
        end
    end
end

function SWEP:Deploy()
    if self:GetOwner():IsNPC() then
        return
    end

    self:SetBaseSettings()

    self:SetNextPrimaryFire(0)
    self:SetNextSecondaryFire(0)
    self:SetAnimLockTime(0)
    self:SetSprintLockTime(0)
    self:SetLastMeleeTime(0)
    self:SetRecoilAmount(0)
    self:SetLastScopeTime(0)
    self:SetPrimedGrenade(false)

    self:DoDeployAnimation()

    self:SetBurstCount(0)
    self:SetScopeLevel(0)
    self:SetLoadedRounds(self:Clip1())
    self:SetCustomize(false)

    self:GetOwner():DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE)

    if SERVER then
        if !self.GaveDefaultAmmo then
            self:GiveDefaultAmmo()
            self.GaveDefaultAmmo = true
        end

        self:NetworkWeapon()
    end

    if CLIENT then
        self:SetupModel(true)
        self:SetupModel(false)
    end

    self:ToggleBoneMods(self:GetBlindFire())

    self:SetShouldHoldType()

    return true
end

function SWEP:GiveDefaultAmmo()
    self:SetClip1(self:GetValue("ClipSize"))
    self:GetOwner():GiveAmmo(self:GetValue("ClipSize") * 2, self:GetValue("Ammo"))
end

function SWEP:Holster()
    if self:GetOwner():IsNPC() then
        return
    end

    self:SetScopeLevel(0)
    self:ToggleBoneMods(false)
    self:KillTimers()
    self:ToggleBlindFire(false)
    self:GetOwner():SetFOV(0, 0.1)

    local holster = self:GetValue("HolsterVisible")
    if holster then
        local holsterslot = self:GetValue("HolsterSlot")
        if game.SinglePlayer() or CLIENT then
            self:GetOwner().TacRP_Holster = self:GetOwner().TacRP_Holster or {}
            self:GetOwner().TacRP_Holster[holsterslot] = self
        else
            net.Start("TacRP_updateholster")
                net.WriteEntity(self:GetOwner())
                net.WriteEntity(self)
            net.SendOmit(self:GetOwner())
        end
    end

    if game.SinglePlayer() then
        self:CallOnClient("KillModel")
    else
        if CLIENT then
            self:RemoveCustomizeHUD()
            self:KillModel()
        end
    end

    -- if CLIENT then
    --     RunConsoleCommand("pp_bokeh", "0")
    -- end

    return true
end

function SWEP:Initialize()
    self:SetShouldHoldType()

    if self:GetOwner():IsNPC() then
        self:NPC_Initialize()
        return
    end

    self:SetBaseSettings()

    self:SetLastMeleeTime(0)
    self:SetNthShot(0)

    self:ClientInitialize()
end

function SWEP:ClientInitialize()
    if SERVER then return end

    if game.SinglePlayer() and SERVER then
        self:CallOnClient("ClientInitialize")
    end

    -- local mat = Material("entities/" .. self:GetClass() .. ".png")

    -- local tex = mat:GetTexture("$basetexture")

    -- killicon.Add(self:GetClass(), tex:GetName(), Color( 255, 255, 255, 255 ) )
end

function SWEP:SetBaseSettings()
    if game.SinglePlayer() and SERVER then
        self:CallOnClient("SetBaseSettings")
    end

    local fm = self:GetCurrentFiremode()
    if fm != 1 then
        if self:GetValue("RunawayBurst") and fm < 0 then
            if self:GetValue("AutoBurst") then
                self.Primary.Automatic = true
            else
                self.Primary.Automatic = false
            end
        else
            self.Primary.Automatic = true
        end
    else
        self.Primary.Automatic = false
    end

    self.Primary.ClipSize = self:GetValue("ClipSize")
    self.Primary.Ammo = self:GetValue("Ammo")

    self.Primary.DefaultClip = self.Primary.ClipSize

    if SERVER then
        if self:GetValue("ClipSize") > 0 and self:Clip1() > self:GetValue("ClipSize") then
            self:GetOwner():GiveAmmo(self:Clip1() - self:GetValue("ClipSize"), self:GetValue("Ammo"))
            self:SetClip1(self:GetValue("ClipSize"))
        end
    end
end

function SWEP:SetShouldHoldType()
    if self:GetOwner():IsNPC() then
        self:SetHoldType(self:GetValue("HoldTypeNPC") or self:GetValue("HoldType"))

        return
    end

    if self:GetIsSprinting() or self:GetSafe() then
        if self:GetValue("HoldTypeSprint") then
            self:SetHoldType(self:GetValue("HoldTypeSprint"))

            return
        end
    end

    if self:GetBlindFire() then
        if self:GetValue("HoldTypeBlindFire") then
            self:SetHoldType(self:GetValue("HoldTypeBlindFire"))

            return
        end
    end

    if self:GetCustomize() then
        if self:GetValue("HoldTypeCustomize") then
            self:SetHoldType(self:GetValue("HoldTypeCustomize"))

            return
        end
    end

    self:SetHoldType(self:GetValue("HoldType"))
end