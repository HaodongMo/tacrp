local customizedelta = 0

SWEP.ViewModelPos = Vector(0, 0, 0)
SWEP.ViewModelAng = Angle(0, 0, 0)

function SWEP:GetViewModelPosition(pos, ang)
    if false then
        return Vector(0, 0, 0), Angle(0, 0, 0)
    end

    -- pos = Vector(0, 0, 0)
    -- ang = Angle(0, 0, 0)

    ang = ang - (self:GetOwner():GetViewPunchAngles() * 0.5)

    local oldang = Angle(0, 0, 0)

    oldang:Set(ang)

    local offsetpos = Vector(0, 0, 0)
    local offsetang = Angle(0, 0, 0)

    local extra_offsetpos = Vector(0, 0, 0)
    local extra_offsetang = Angle(0, 0, 0)

    -- print(extra_offsetang)

    offsetpos:Set(self.PassivePos)
    offsetang:Set(self.PassiveAng)

    -- local cor_val = (self.ViewModelFOV / self:GetShouldFOV())
    local cor_val = 0.75

    local blindfiredelta = self:GetBlindFireAmount()
    local blindfirecornerdelta = self:GetBlindFireCornerAmount()

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

    local sightdelta = self:Curve(self:GetSightDelta())

    -- cor_val = Lerp(sightdelta, cor_val, 1)

    if sightdelta > 0 then
        local sightpos, sightang = self:GetSightPositions()

        offsetpos = LerpVector(sightdelta, offsetpos, sightpos)
        offsetang = LerpAngle(sightdelta, offsetang, sightang)
    end

    local eepos, eeang = self:GetExtraSightPosition()

    local im = self:GetValue("SightMidPoint")

    local midpoint = sightdelta * math.cos(sightdelta * (math.pi / 2))
    local joffset = (im and im.Pos or Vector(0, 0, 0)) * midpoint
    local jaffset = (im and im.Ang or Angle(0, 0, 0)) * midpoint

    extra_offsetpos = LerpVector(sightdelta, extra_offsetpos, -eepos + joffset)
    extra_offsetang = LerpAngle(sightdelta, extra_offsetang, -eeang + jaffset)

    extra_offsetang.y = extra_offsetang.y - (self:GetSwayAngles().p * cor_val)
    extra_offsetang.p = extra_offsetang.p + (self:GetSwayAngles().y * cor_val)

    extra_offsetang.y = extra_offsetang.y - (self:GetFreeAimOffset().p * cor_val)
    extra_offsetang.p = extra_offsetang.p + (self:GetFreeAimOffset().y * cor_val)

    if game.SinglePlayer() or IsFirstTimePredicted() then
        if self:GetCustomize() then
            customizedelta = math.Approach(customizedelta, 1, FrameTime() * 1 / 0.15)
        else
            customizedelta = math.Approach(customizedelta, 0, FrameTime() * 1 / 0.15)
        end
    end

    local curvedcustomizedelta = self:Curve(customizedelta)

    if customizedelta > 0 then
        offsetpos = LerpVector(curvedcustomizedelta, offsetpos, self:GetValue("CustomizePos"))
        offsetang = LerpAngle(curvedcustomizedelta, offsetang, self:GetValue("CustomizeAng"))

        extra_offsetang = LerpAngle(curvedcustomizedelta, extra_offsetang, Angle(0, 0, 0))

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
    local sprintdelta = self:Curve(self:GetSprintDelta())

    if sprintdelta > 0 then
        offsetpos = LerpVector(sprintdelta, offsetpos, self:GetValue("SprintPos"))
        offsetang = LerpAngle(sprintdelta, offsetang, self:GetValue("SprintAng"))

        extra_offsetang = LerpAngle(sprintdelta, extra_offsetang, Angle(0, 0, 0))
    end

    local sim = self:GetValue("SprintMidPoint")

    local spr_midpoint = sprintdelta * math.cos(sprintdelta * (math.pi / 2))
    local spr_joffset = (sim and sim.Pos or Vector(0, 0, 0)) * spr_midpoint
    local spr_jaffset = (sim and sim.Ang or Angle(0, 0, 0)) * spr_midpoint

    extra_offsetpos = extra_offsetpos + spr_joffset
    extra_offsetang = extra_offsetang + spr_jaffset

    -- self.BobScale = Lerp(sprintdelta, 1, 3)
    -- self.BobScale = Lerp(sightdelta, self.BobScale, 0.1)
    self.SwayScale = Lerp(sightdelta, 1, 0.1)

    self.BobScale = 0

    if game.SinglePlayer() or IsFirstTimePredicted() then
        self.ViewModelPos = LerpVector(0.8, offsetpos, self.ViewModelPos)
        self.ViewModelAng = LerpAngle(0.8, offsetang, self.ViewModelAng)
    end

    offsetpos = self.ViewModelPos
    offsetang = self.ViewModelAng
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
    pos, ang = self:GetViewModelSmooth(pos, ang)

    -- self.ViewModelPos = pos
    -- self.ViewModelAng = ang

    return pos, ang
end