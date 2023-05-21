local blur = Material("pp/blurscreen")
local function drawBlurAt(x, y, w, h, amount, passes, reverse)
    -- Intensity of the blur.
    amount = amount or 5

    surface.SetMaterial(blur)
    surface.SetDrawColor(color_white)

    local scrW, scrH = ScrW(), ScrH()
    local x2, y2 = x / scrW, y / scrH
    local w2, h2 = (x + w) / scrW, (y + h) / scrH

    for i = -(passes or 0.2), 1, 0.2 do
        if reverse then
            blur:SetFloat("$blur", i * -1 * amount)
        else
            blur:SetFloat("$blur", i * amount)
        end
        blur:Recompute()

        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRectUV(x, y, w, h, x2, y2, w2, h2)
    end
end

local peekzoom = 1.2

function SWEP:ScopeToggle(setlevel)
    if (setlevel or 0) > 0 and (!self:GetValue("Scope") or self:GetPrimedGrenade()) then return end
    -- if setlevel and setlevel > 0 and self:GetAnimLockTime() > CurTime() or (!setlevel and self:GetAnimLockTime() > CurTime()) then return end
    -- if (setlevel and setlevel > 0 and self:GetReloading()) or (!setlevel and self:GetReloading()) then return end

    local level = self:GetScopeLevel()
    local oldlevel = level

    level = setlevel or (level + 1)

    if level > self:GetValue("ScopeLevels") then
        level = self:GetValue("ScopeLevels")
    end

    if self:SprintLock() or self:GetCustomize() or self:GetLastMeleeTime() + 1 > CurTime() then
        level = 0
    end

    if level == self:GetScopeLevel() then return end

    if IsFirstTimePredicted() then
        self:SetScopeLevel(level)
    end

    if level > 0 then
        self:ToggleBlindFire(TacRP.BLINDFIRE_NONE)
    end

    if oldlevel == 0 or level == 0 then
        self:SetLastScopeTime(CurTime())
    end

    if CLIENT then
        self:GenerateAutoSight()
        self.LastHintLife = CurTime()
    end

    self:EmitSound(self:GetValue("Sound_ScopeIn"), 75, 100, 1, CHAN_ITEM)

    self:SetShouldHoldType()
end

function SWEP:GetShouldFOV(ignorepeek)
    local level = self:GetScopeLevel()

    if level > 0 and (ignorepeek or !self:GetPeeking()) then
        local fov = self:GetValue("ScopeFOV")

        fov = Lerp(level / self:GetValue("ScopeLevels"), 90, fov)

        return fov
    elseif !ignorepeek and self:GetPeeking() then
        return 90 / peekzoom
    else
        return 90
    end
end

function SWEP:IsInScope()
    local sightdelta = self:Curve(self:GetSightDelta())

    return (SERVER or !self:GetPeeking()) and ((self:GetScopeLevel() > 0 and sightdelta > 0.5) or (sightdelta > 0.9))
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

            local ss = math.Round(h * (self:GetValue("ScopeOverlaySize") or 1))
            local sx = x - (ss / 2)
            local sy = y - (ss / 2)

            -- local shakey = math.min(cross * 35, 3)

            -- sx = sx + math.Round(math.Rand(-shakey, shakey))
            -- sy = sy + math.Round(math.Rand(-shakey, shakey))

            -- local int = self:CheckFlashlightPointing()
            -- if int > 0 then
            --     surface.SetDrawColor(255, 255, 255, int * 250)
            --     surface.DrawRect(0, 0, w, h)
            -- end

            surface.SetMaterial(img)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawTexturedRect(sx, sy, ss, ss)

            surface.SetDrawColor(0, 0, 0)
            surface.DrawRect(0, 0, w, sy)
            surface.DrawRect(0, sy + ss, w, h - sy)

            surface.DrawRect(0, 0, sx, h)
            surface.DrawRect(sx + ss, 0, w - sx, h)

            if self:GetReloading() then
                drawBlurAt(0, 0, w, h, 1, 1)
            end

            -- if int > 0 then
            --     surface.SetDrawColor(255, 255, 255, int * 25)
            --     surface.DrawRect(0, 0, w, h)
            -- end
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
    if !IsValid(self:GetOwner()) then return end

    if IsFirstTimePredicted() and self:GetOwner():KeyDown(IN_USE) and self:GetOwner():KeyPressed(IN_ATTACK2) then
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

    if CLIENT then
        self:ThinkPeek()
    end

    local toggle = self:GetOwner():GetInfoNum("tacrp_toggleaim", 0) == 1
    local press, down = self:GetOwner():KeyPressed(IN_ATTACK2), self:GetOwner():KeyDown(IN_ATTACK2)

    if sighted and ((toggle and press) or (!toggle and !down)) then
        self:ScopeToggle(0)
    elseif !sighted and ((toggle and press) or (!toggle and down)) then
        self:ScopeToggle(1)
    end

end

function SWEP:GetMagnification()
    local mag = 1

    local level = self:GetScopeLevel()

    if level > 0 then

        if self:GetPeeking() then
            return peekzoom
        end

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

function SWEP:ThinkPeek()
    local down = input.IsKeyDown(input.GetKeyCode(input.LookupBinding("menu_context") or "???"))
    if !GetConVar("tacrp_togglepeek"):GetBool() and self:GetPeeking() ~= down then
        net.Start("tacrp_togglepeek")
        net.WriteBool(down)
        net.SendToServer()
    end
end

function SWEP:GetCCIP(pos, ang)
    -- get calculated point of impact

    local sp, sa = self:GetMuzzleOrigin(), self:GetShootDir()

    pos = pos or sp
    ang = ang or sa

    local v = self:GetValue("MuzzleVelocity")
    local g = 1
    local d = 1

    local vel = ang:Forward() * v
    local maxiter = 100
    local timestep = 1 / 15

    for i = 1, maxiter do
        local dir = vel:GetNormalized()
        local spd = vel:Length() * timestep
        local drag = d * spd * spd * (1 / 150000)
        local gravity = timestep * g * 600

        if spd <= 0.001 then return nil end

        local newpos = pos + (vel * timestep)
        local newvel = vel - (dir * drag) - Vector(0, 0, gravity)

        local tr = util.TraceLine({
            start = pos,
            endpos = newpos,
            filter = self:GetOwner(),
            mask = MASK_SHOT
        })

        if tr.Hit then
            return tr, i * timestep
        else
            pos = newpos
            vel = newvel
        end
    end

    return nil
end

function SWEP:GetCorVal()
    local vmfov = self.ViewModelFOV
    local fov = self:GetShouldFOV()

    return vmfov / (fov * 1.33333)
end

-- function SWEP:CheckFlashlightPointing()
--     if game.SinglePlayer() then return 0 end
--     if !GetConVar("tacrp_flashlight_blind"):GetBool() then return 0 end
--     if self.FlashlightPointingCache and self.FlashlightPointingCache[2] == CurTime() then return self.FlashlightPointingCache[1] end
--     local src0 = self:GetOwner():EyePos()
--     local v = 0
--     for _, ply in pairs(player.GetAll()) do
--         if ply == self:GetOwner() or !ply:Alive() or !IsValid(ply:GetActiveWeapon()) or !ply:GetActiveWeapon().ArcticTacRP then continue end
--         --  !ply:GetActiveWeapon():GetValue("Flashlight") or !ply:GetActiveWeapon():GetTactical()
--         local src, dir = ply:GetActiveWeapon():GetMuzzleOrigin(), ply:GetActiveWeapon():GetShootDir():Forward()
--         local diff = src - src0

--         local add = 1

--         local dot = -dir:Dot(EyeAngles():Forward())
--         if dot < 0.707 then continue end
--         add = add * math.Clamp((dot - 0.707) / (1 - 0.707), 0, 1)

--         local distsqr = diff:LengthSqr()
--         add = add * (1 - math.Clamp(distsqr / 4194304, 0, 1)) ^ 1.25

--         local tr = util.QuickTrace(src, self:GetOwner():EyePos() - src, {self:GetOwner(), ply})
--         if tr.Fraction < 1 then continue end

--         v = v + add
--     end

--     self.FlashlightPointingCache = {v, CurTime()}
--     return v
-- end