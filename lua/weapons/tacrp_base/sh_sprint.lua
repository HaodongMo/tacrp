function SWEP:GetSprintToFireTime()
    return self:GetValue("SprintToFireTime")
end

function SWEP:GetIsSprinting()
    local owner = self:GetOwner()

    if !self:GetOwner():IsValid() or self:GetOwner():IsNPC() then
        return false
    end

    if owner.TacRP_SprintBlock then return false end

    local curspeed = owner:GetVelocity():Length()
    local walkspeed = owner:GetWalkSpeed()

    if TTT2 and owner.isSprinting == true then
        return (owner.sprintProgress or 0) > 0 and owner:KeyDown(IN_SPEED) and !owner:Crouching() and curspeed > walkspeed and owner:OnGround()
    elseif engine.ActiveGamemode() == "terrortown" then
        return false -- assume no sprint addon. tis silly anyways
    end

    if !owner:KeyDown(IN_FORWARD) and !owner:KeyDown(IN_BACK) and !owner:KeyDown(IN_MOVELEFT) and !owner:KeyDown(IN_MOVERIGHT) then return false end
    if !owner:KeyDown(IN_SPEED) then return false end -- SetButtons does not seem to affect this?
    if curspeed <= 0 then return false end
    if !owner:OnGround() then return false end

    return true
end

if CLIENT then

SWEP.LocalInterpolatedSprintDelta = 0

end

function SWEP:GetSprintDelta()
    return self:GetSprintAmount()
end

function SWEP:EnterSprint()
    if !self:CanShootInSprint() then
        self:ToggleBlindFire(TacRP.BLINDFIRE_NONE)
    end
    if !self:CanReloadInSprint() and self:GetReloading() then
        self:CancelReload()
        self:Idle()
    end
    self:ScopeToggle(0)

    self:SetShouldHoldType()
end

function SWEP:ExitSprint()
    local amt = self:GetSprintAmount()
    self:SetSprintLockTime(CurTime() + (self:GetSprintToFireTime() * amt))

    self:SetShouldHoldType()
end

SWEP.LastWasSprinting = false

function SWEP:ThinkSprint()
    local sprinting = self:GetIsSprinting() or self:GetSafe()

    local amt = self:GetSprintAmount()

    if self.LastWasSprinting and !sprinting then
        self:ExitSprint()
    elseif !self.LastWasSprinting and sprinting then
        self:EnterSprint()
    end

    self.LastWasSprinting = sprinting

    if sprinting then
        amt = math.Approach(amt, 1, FrameTime() / self:GetSprintToFireTime())
    else
        amt = math.Approach(amt, 0, FrameTime() / self:GetSprintToFireTime())
    end

    self:SetSprintAmount(amt)
end

function SWEP:CanShootInSprint(base)
    if base then
        return self:GetBaseValue("ShootWhileSprint")
    else
        return self:GetValue("ShootWhileSprint")
    end
end

function SWEP:CanReloadInSprint(base)
    return GetConVar("tacrp_sprint_reload"):GetBool()
end