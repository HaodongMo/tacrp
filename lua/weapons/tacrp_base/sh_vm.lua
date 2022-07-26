local customizedelta = 0
local sightdelta = 0
local sprintdelta = 0
local blindfiredelta, blindfirecornerdelta = 0, 0
local freeaim_p, freeaim_y = 0, 0

local angle_zero = Angle(0, 0, 0)
local vector_origin = Vector(0, 0, 0)

local m_appor = math.Approach
local f_lerp = Lerp
local function ApproachMod(usrobj, to, dlt)
    usrobj[1] = m_appor(usrobj[1], to[1], dlt)
    usrobj[2] = m_appor(usrobj[2], to[2], dlt)
    usrobj[3] = m_appor(usrobj[3], to[3], dlt)
end

local function LerpMod(usrobj, to, dlt, clamp_ang)
    usrobj[1] = f_lerp(dlt, usrobj[1], to[1])
    usrobj[2] = f_lerp(dlt, usrobj[2], to[2])
    usrobj[3] = f_lerp(dlt, usrobj[3], to[3])
    if clamp_ang then
        for i = 1, 3 do usrobj[i] = math.NormalizeAngle(usrobj[i]) end
    end
end

SWEP.ViewModelPos = Vector(0, 0, 0)
SWEP.ViewModelAng = Angle(0, 0, 0)

function SWEP:GetViewModelPosition(pos, ang)
    if false then
        return Vector(0, 0, 0), Angle(0, 0, 0)
    end

    local FT = self:DeltaSysTime() -- FrameTime()

    ang = ang - (self:GetOwner():GetViewPunchAngles() * 0.5)

    local oldang = Angle(0, 0, 0)

    oldang:Set(ang)

    local offsetpos = Vector(self.PassivePos)
    local offsetang = Angle(self.PassiveAng)

    local extra_offsetpos = Vector(0, 0, 0)
    local extra_offsetang = Angle(0, 0, 0)

    -- local cor_val = (self.ViewModelFOV / self:GetShouldFOV())
    local cor_val = 0.75

    -- local blindfiredelta = self:GetBlindFireAmount()
    -- local blindfirecornerdelta = self:GetBlindFireCornerAmount()
    if self:GetBlindFire() then
        blindfiredelta = math.Approach(blindfiredelta, 1, FT / 0.25)
    else
        blindfiredelta = math.Approach(blindfiredelta, 0, FT / 0.25)
    end
    if self:GetBlindFireCorner() then
        blindfirecornerdelta = math.Approach(blindfirecornerdelta, 1, FT / 0.25)
    else
        blindfirecornerdelta = math.Approach(blindfirecornerdelta, 0, FT / 0.25)
    end

    local curvedblindfiredelta = self:Curve(blindfiredelta)
    local curvedblindfirecornerdelta = self:Curve(blindfirecornerdelta)

    if blindfiredelta > 0 then
        offsetpos = LerpVector(curvedblindfiredelta, offsetpos, self:GetValue("BlindFirePos"))
        offsetang = LerpAngle(curvedblindfiredelta, offsetang, self:GetValue("BlindFireAng"))

        if curvedblindfirecornerdelta > 0 then
            offsetpos = LerpVector(curvedblindfirecornerdelta, offsetpos, self:GetValue("BlindFireCornerPos"))
            offsetang = LerpAngle(curvedblindfirecornerdelta, offsetang, self:GetValue("BlindFireCornerAng"))
        end
    end

    --local sightdelta = self:Curve(self:GetSightDelta())
    if self:GetScopeLevel() > 0 then
        sightdelta = m_appor(sightdelta, 1, FT / self:GetValue("AimDownSightsTime"))
    else
        sightdelta = m_appor(sightdelta, 0, FT / self:GetValue("AimDownSightsTime"))
    end

    local curvedsightdelta = self:Curve(sightdelta)

    -- cor_val = Lerp(sightdelta, cor_val, 1)

    if sightdelta > 0 then
        local sightpos, sightang = self:GetSightPositions()

        LerpMod(offsetpos, sightpos, curvedsightdelta)
        LerpMod(offsetang, sightang, curvedsightdelta, true)
    end

    local eepos, eeang = self:GetExtraSightPosition()

    local im = self:GetValue("SightMidPoint")

    local midpoint = curvedsightdelta * math.cos(curvedsightdelta * (math.pi / 2))
    local joffset = (im and im.Pos or Vector(0, 0, 0)) * midpoint
    local jaffset = (im and im.Ang or Angle(0, 0, 0)) * midpoint

    LerpMod(extra_offsetpos, -eepos + joffset, curvedsightdelta)
    LerpMod(extra_offsetang, -eeang + jaffset, curvedsightdelta)

    extra_offsetang.y = extra_offsetang.y - (self:GetSwayAngles().p * cor_val)
    extra_offsetang.p = extra_offsetang.p + (self:GetSwayAngles().y * cor_val)

    -- extra_offsetang.y = extra_offsetang.y - (self:GetFreeAimOffset().p * cor_val)
    -- extra_offsetang.p = extra_offsetang.p + (self:GetFreeAimOffset().y * cor_val)

    freeaim_p = f_lerp(0.5, freeaim_p, self:GetFreeAimOffset().p)
    freeaim_y = f_lerp(0.5, freeaim_y, self:GetFreeAimOffset().y)
    freeaim_p = m_appor(freeaim_p, self:GetFreeAimOffset().p, FT)
    freeaim_y = m_appor(freeaim_y, self:GetFreeAimOffset().y, FT)

    extra_offsetang.y = extra_offsetang.y - (freeaim_p * cor_val)
    extra_offsetang.p = extra_offsetang.p + (freeaim_y * cor_val)

    --if game.SinglePlayer() or IsFirstTimePredicted() then
        if self:GetCustomize() then
            customizedelta = m_appor(customizedelta, 1, FT * 1 / 0.15)
        else
            customizedelta = m_appor(customizedelta, 0, FT * 1 / 0.15)
        end
    --end

    local curvedcustomizedelta = self:Curve(customizedelta)

    if customizedelta > 0 then
        LerpMod(offsetpos, self:GetValue("CustomizePos"), curvedcustomizedelta)
        LerpMod(offsetang, self:GetValue("CustomizeAng"), curvedcustomizedelta)

        LerpMod(extra_offsetang, angle_zero, curvedcustomizedelta, true)

        -- local c_axis_x = ((gui.MouseX() / ScrW()) * 2) - 1
        -- local c_axis_y = ((gui.MouseY() / ScrH()) * 2) - 1

        -- c_axis_x = math.Clamp(c_axis_x, -1, 1)
        -- c_axis_y = math.Clamp(c_axis_y, -1, 1)

        -- if c_axis_x < 0 then
        --     extra_offsetpos = extra_offsetpos + LerpVector(-c_axis_x, Vector(0, 0, 0), self.CustomizePointLeft.Pos)
        --     extra_offsetang = extra_offsetang + LerpAngle(-c_axis_x, Angle(0, 0, 0), self.CustomizePointLeft.Ang)
        -- elseif c_axis_x > 0 then
        --     extra_offsetpos = extra_offsetpos + LerpVector(c_axis_x, Vector(0, 0, 0), self.CustomizePointRight.Pos)
        --     extra_offsetang = extra_offsetang + LerpAngle(c_axis_x, Angle(0, 0, 0), self.CustomizePointRight.Ang)
        -- end

        -- if c_axis_y < 0 then
        --     extra_offsetpos = extra_offsetpos + LerpVector(-c_axis_y, Vector(0, 0, 0), self.CustomizePointUp.Pos)
        --     extra_offsetang = extra_offsetang + LerpAngle(-c_axis_y, Angle(0, 0, 0), self.CustomizePointUp.Ang)
        -- elseif c_axis_y > 0 then
        --     extra_offsetpos = extra_offsetpos + LerpVector(c_axis_y, Vector(0, 0, 0), self.CustomizePointDown.Pos)
        --     extra_offsetang = extra_offsetang + LerpAngle(c_axis_y, Angle(0, 0, 0), self.CustomizePointDown.Ang)
        -- end
    end

    -- local sprintdelta = self:Curve(self:GetSprintDelta())
    if self.LastWasSprinting then
        sprintdelta = m_appor(sprintdelta, 1, FT / self:GetSprintToFireTime())
    else
        sprintdelta = m_appor(sprintdelta, 0, FT / self:GetSprintToFireTime())
    end
    local curvedsprintdelta = self:Curve(sprintdelta)

    if curvedsprintdelta > 0 then
        LerpMod(offsetpos, self:GetValue("SprintPos"), curvedsprintdelta)
        LerpMod(offsetang, self:GetValue("SprintAng"), curvedsprintdelta)

        LerpMod(extra_offsetang, angle_zero, curvedsprintdelta, true)
    end

    local sim = self:GetValue("SprintMidPoint")

    local spr_midpoint = curvedsprintdelta * math.cos(curvedsprintdelta * (math.pi / 2))
    local spr_joffset = (sim and sim.Pos or Vector(0, 0, 0)) * spr_midpoint
    local spr_jaffset = (sim and sim.Ang or Angle(0, 0, 0)) * spr_midpoint

    extra_offsetpos:Add(spr_joffset)
    extra_offsetang:Add(spr_jaffset)

    -- self.BobScale = Lerp(sprintdelta, 1, 3)
    -- self.BobScale = Lerp(sightdelta, self.BobScale, 0.1)
    self.SwayScale = f_lerp(sightdelta, 1, 0.1)
    self.BobScale = 0

    -- if game.SinglePlayer() or IsFirstTimePredicted() then
    --     self.ViewModelPos = LerpVector(0.8, offsetpos, self.ViewModelPos)
    --     self.ViewModelAng = LerpAngle(0.8, offsetang, self.ViewModelAng)
    -- end

    -- offsetpos = self.ViewModelPos
    -- offsetang = self.ViewModelAng

    local speed = 15 * FT * (game.SinglePlayer() and 1 or 2)

    LerpMod(self.ViewModelPos, offsetpos, speed)
    LerpMod(self.ViewModelAng, offsetang, speed, true)
    ApproachMod(self.ViewModelPos, offsetpos, speed * 0.1)
    ApproachMod(self.ViewModelAng, offsetang, speed * 0.1)

    self.ViewModelAng:Normalize()

    pos = pos + (ang:Right() * offsetpos[1])
    pos = pos + (ang:Forward() * offsetpos[2])
    pos = pos + (ang:Up() * offsetpos[3])

    ang:RotateAroundAxis(ang:Up(), offsetang[1])
    ang:RotateAroundAxis(ang:Right(), offsetang[2])
    ang:RotateAroundAxis(ang:Forward(), offsetang[3])

    pos = pos + (oldang:Right() * extra_offsetpos[1])
    pos = pos + (oldang:Forward() * extra_offsetpos[2])
    pos = pos + (oldang:Up() * extra_offsetpos[3])

    ang:RotateAroundAxis(oldang:Up(), extra_offsetang[1])
    ang:RotateAroundAxis(oldang:Right(), extra_offsetang[2])
    ang:RotateAroundAxis(oldang:Forward(), extra_offsetang[3])

    pos, ang = self:GetViewModelBob(pos, ang)
    -- pos, ang = self:GetMidAirBob(pos, ang)
    -- pos, ang = self:GetViewModelLeftRight(pos, ang)
    -- pos, ang = self:GetViewModelInertia(pos, ang)
    pos, ang = self:GetViewModelSway(pos, ang)
    -- pos, ang = self:GetViewModelSmooth(pos, ang)

    self.ViewModelPos = pos
    self.ViewModelAng = ang

    self.LastSysTime = SysTime()
    return pos, ang
end