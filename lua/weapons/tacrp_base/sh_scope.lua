function SWEP:ScopeToggle(setlevel)
    if !self:GetValue("Scope") then return end
    if setlevel and setlevel > 0 and self:GetPrimedGrenade() then return end
    -- if setlevel and setlevel > 0 and self:GetAnimLockTime() > CurTime() or (!setlevel and self:GetAnimLockTime() > CurTime()) then return end
    -- if (setlevel and setlevel > 0 and self:GetReloading()) or (!setlevel and self:GetReloading()) then return end

    local level = self:GetScopeLevel()

    local oldlevel = level

    level = setlevel or (level + 1)

    if level > self:GetValue("ScopeLevels") then
        level = 0
    end

    if self:SprintLock() then
        level = 0
    end

    if self:GetCustomize() then
        level = 0
    end

    if level == self:GetScopeLevel() then return end

    self:SetScopeLevel(level)

    if level > 0 then
        self:ToggleBlindFire(false)
    end

    if oldlevel == 0 or level == 0 then
        self:SetLastScopeTime(CurTime())
    end

    if CLIENT then
        self:GenerateAutoSight()
    end

    self:EmitSound(self:GetValue("Sound_ScopeIn"), 75, 100, 1, CHAN_ITEM)
end

function SWEP:GetShouldFOV()
    local level = self:GetScopeLevel()

    if level > 0 then
        local fov = self:GetValue("ScopeFOV")

        fov = Lerp(level / self:GetValue("ScopeLevels"), 90, fov)

        return fov
    else
        return 90
    end
end

function SWEP:IsInScope()
    local sightdelta = self:Curve(self:GetSightDelta())

    return (self:GetScopeLevel() > 0 and sightdelta > 0.1) or (sightdelta > 0.9)
end

function SWEP:DoScope()
    if self:IsInScope() then

        local img = self:GetValue("ScopeOverlay")

        if img then
            local h = ScrH()
            local w = ScrW()

            -- assume players have a screen that is wider than it is tall because... that's stupid

            local pos = self:GetOwner():EyePos()

            pos = pos + self:GetShootDir():Forward() * 9000

            local toscreen = pos:ToScreen()

            local x = toscreen.x
            local y = toscreen.y

            local ss = h
            local sx = x - (ss / 2)
            local sy = y - (ss / 2)

            -- local shakey = math.min(cross * 35, 3)

            -- sx = sx + math.Round(math.Rand(-shakey, shakey))
            -- sy = sy + math.Round(math.Rand(-shakey, shakey))

            surface.SetMaterial(img)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawTexturedRect(sx, sy, ss, ss)

            surface.SetDrawColor(0, 0, 0)
            surface.DrawRect(0, 0, w, sy)
            surface.DrawRect(0, sy + ss, w, h - sy)

            surface.DrawRect(0, 0, sx, h)
            surface.DrawRect(sx + ss, 0, w - sx, h)
        end
    end
end

function SWEP:GetSightDelta()
    return self:GetSightAmount()
end

function SWEP:SetSightDelta(d)
    self:SetSightAmount(d)
end

function SWEP:ThinkSights()
    if self:GetOwner():KeyDown(IN_USE) and self:GetOwner():KeyPressed(IN_ATTACK2) then
        self:ToggleSafety()
        return
    end

    local FT = FrameTime()

    if self:GetSafe() then return end

    local sighted = self:GetScopeLevel() > 0

    local amt = self:GetSightAmount()

    if sighted then
        amt = math.Approach(amt, 1, FT / self:GetValue("AimDownSightsTime"))
    else
        amt = math.Approach(amt, 0, FT / self:GetValue("AimDownSightsTime"))
    end

    self:SetSightDelta(amt)

    if sighted and !self:GetOwner():KeyDown(IN_ATTACK2) then
        self:ScopeToggle(0)
    elseif !sighted and self:GetOwner():KeyDown(IN_ATTACK2) then
        self:ScopeToggle(1)
    end
end

function SWEP:GetMagnification()
    local mag = 1

    local level = self:GetScopeLevel()

    if level > 0 then
        mag = 90 / self:GetValue("ScopeFOV")

        mag = Lerp(level / self:GetValue("ScopeLevels"), 1, mag)
    end

    return mag
end

function SWEP:AdjustMouseSensitivity()
    local mag = self:GetMagnification()

    if mag > 1 then
        return 1 / mag
    end
end