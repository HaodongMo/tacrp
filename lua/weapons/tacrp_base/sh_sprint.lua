function SWEP:GetSprintToFireTime()
    return self:GetValue("SprintToFireTime")
end

function SWEP:GetIsSprinting()
    local owner = self:GetOwner()

    if !self:GetOwner():IsValid() or self:GetOwner():IsNPC() then
        return false
    end

    local curspeed = owner:GetVelocity():Length()

    if !owner:KeyDown(IN_FORWARD) and !owner:KeyDown(IN_BACK) and !owner:KeyDown(IN_MOVELEFT) and !owner:KeyDown(IN_MOVERIGHT) then return false end
    if !owner:KeyDown(IN_SPEED) then return false end
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
    self:ToggleBlindFire(false)

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