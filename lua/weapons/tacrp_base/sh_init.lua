function SWEP:DoDeployAnimation()
    if self:GetReloading() and self:GetValue("MidReload") and !self:GetValue("ShotgunReload") and self:HasSequence("midreload") then
        local t = self:PlayAnimation("midreload", self:GetValue("ReloadTimeMult"), true, true)

        self:SetTimer(t, function()
            self:EndReload()
        end)
    else
        self:SetReloading(false)
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
    self:SetBlindFireFinishTime(0)
    self:SetJammed(false)

    self.PreviousZoom = self:GetOwner():GetCanZoom()
    if IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() then
        self:GetOwner():SetCanZoom(false)
    end

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

    self:ToggleBlindFire(TacRP.BLINDFIRE_NONE)

    self:SetShouldHoldType()

    if !self:CheckGrenade() then
        self:SelectGrenade()
        return
    end

    return true
end

function SWEP:GiveDefaultAmmo()
    self:SetClip1(self:GetValue("ClipSize"))
    self:GetOwner():GiveAmmo(self:GetValue("ClipSize") * 2, self:GetValue("Ammo"))
end


local v0 = Vector(0, 0, 0)
local v1 = Vector(1, 1, 1)
local a0 = Angle(0, 0, 0)

function SWEP:ClientHolster()
    if game.SinglePlayer() then
        self:CallOnClient("ClientHolster")
    end

    self:GetVM():SetSubMaterial()
    self:GetVM():SetMaterial()

    for i = 0, self:GetVM():GetBoneCount() do
        self:GetVM():ManipulateBoneScale(i, v1)
        self:GetVM():ManipulateBoneAngles(i, a0)
        self:GetVM():ManipulateBonePosition(i, v0)
    end
end

function SWEP:Holster(wep)
    if game.SinglePlayer() and CLIENT then return end

    if CLIENT and self:GetOwner() != LocalPlayer() then return end

    if self:GetOwner():IsNPC() then
        return
    end

    self:SetCustomize(false)

    if self:GetReloading() and self:GetValue("ShotgunReload") then
        self:SetEndReload(false)
        self:SetReloading(false)
        self:KillTimer("ShotgunRestoreClip")
    end

    if self:GetHolsterTime() > CurTime() then return false end

    if !GetConVar("TacRP_holster"):GetBool() or (self:GetHolsterTime() != 0 and self:GetHolsterTime() <= CurTime()) or !IsValid(wep) then
        -- Do the final holster request
        -- Picking up props try to switch to NULL, by the way
        self:SetHolsterTime(0)
        self:SetHolsterEntity(NULL)
        self:SetReloadFinishTime(0)

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

        if self.PreviousZoom then
            self:GetOwner():SetCanZoom(true)
        end

        self:ClientHolster()

        return true
    else
        local reverse = 1
        local anim = "holster"

        if self:GetValue("NoHolsterAnimation") then
            anim = "deploy"
            reverse = -1
        end

        local animation = self:PlayAnimation(anim, self:GetValue("HolsterTimeMult") * reverse, true, true)
        self:SetHolsterTime(CurTime() + (animation or 0))
        self:SetHolsterEntity(wep)

        self:SetScopeLevel(0)
        self:KillTimers()
        self:ToggleBlindFire(TacRP.BLINDFIRE_NONE)
        self:GetOwner():SetFOV(0, 0.1)
    end
end

local holsteranticrash = false

hook.Add("StartCommand", "TacRP_Holster", function(ply, ucmd)
    local wep = ply:GetActiveWeapon()

    if IsValid(wep) and wep.ArcticTacRP and wep:GetHolsterTime() != 0 and wep:GetHolsterTime() <= CurTime() and IsValid(wep:GetHolsterEntity()) then
        wep:SetHolsterTime(-math.huge) -- Pretty much force it to work
        if !holsteranticrash then
            holsteranticrash = true
            ucmd:SelectWeapon(wep:GetHolsterEntity()) -- Call the final holster request
            holsteranticrash = false
        end
    end
end)

function SWEP:Initialize()
    self:SetShouldHoldType()

    if self:GetOwner():IsNPC() then
        self:NPC_Initialize()
        return
    end

    self:SetBaseSettings()

    self:SetLastMeleeTime(0)
    self:SetNthShot(0)

    self.m_WeaponDeploySpeed = 4

    self:ClientInitialize()
end

function SWEP:ClientInitialize()
    if SERVER then return end

    if game.SinglePlayer() and SERVER and IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() then
        self:CallOnClient("ClientInitialize")
    end

    if !LocalPlayer().TacRPGreet and !GetConVar("tacrp_shutup"):GetBool() then
        LocalPlayer().TacRPGreet = true
        LocalPlayer():PrintMessage(HUD_PRINTTALK, "Check Q menu -> Options/Tactical RP/Control Guide to see the controls!")
        if !input.LookupBinding("grenade1") and !input.LookupBinding("grenade2") then
            LocalPlayer():PrintMessage(HUD_PRINTTALK, "Bind +grenade1 and +grenade2 to use TacRP quick grenades!")
        end
    end

    -- local mat = Material("entities/" .. self:GetClass() .. ".png")

    -- local tex = mat:GetTexture("$basetexture")

    -- killicon.Add(self:GetClass(), tex:GetName(), Color( 255, 255, 255, 255 ) )
end

function SWEP:SetBaseSettings()
    if game.SinglePlayer() and SERVER and IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() then
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

    if self:GetIsSprinting() or self:GetSafe() and self:GetValue("HoldTypeSprint") then
        self:SetHoldType(self:GetValue("HoldTypeSprint"))
    end

    if self:GetBlindFire() then
        if self:GetBlindFireMode() == TacRP.BLINDFIRE_KYS and self:GetValue("HoldTypeSuicide") then
            self:SetHoldType(self:GetValue("HoldTypeSuicide"))
            return
        elseif self:GetValue("HoldTypeBlindFire") then
            self:SetHoldType(self:GetValue("HoldTypeBlindFire"))
            return
        end
    end

    if self:GetCustomize() and self:GetValue("HoldTypeCustomize") then
        self:SetHoldType(self:GetValue("HoldTypeCustomize"))
        return
    end

    self:SetHoldType(self:GetValue("HoldType"))
end

function SWEP:OnRemove()
    if IsValid(self:GetOwner()) then
        self:ToggleBoneMods(TacRP.BLINDFIRE_NONE)
    end
end