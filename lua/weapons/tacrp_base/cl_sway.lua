SWEP.ViewModelVelocityPos = Vector(0, 0, 0)
SWEP.ViewModelVelocityAng = Angle(0, 0, 0)

SWEP.ViewModelPos = Vector(0, 0, 0)
SWEP.ViewModelAng = Angle(0, 0, 0)

SWEP.SwayCT = 0

function SWEP:GetViewModelSway(pos, ang)
    local d = Lerp(self:GetSightDelta(), 1, 0.02)
    local v = 1
    local steprate = 1

    local FT = self:DeltaSysTime() * 1 --FrameTime()
    local CT = UnPredictedCurTime() -- CurTime()

    d = d * 0.25

    pos = pos + (ang:Up() * (math.sin(self.SwayCT * 0.311 * v) + math.cos(self.SwayCT * 0.44 * v)) * math.sin(CT * 0.8) * d)
    pos = pos + (ang:Right() * (math.sin(self.SwayCT * 0.324 * v) + math.cos(self.SwayCT * 0.214 * v)) * math.sin(CT * 0.76) * d)

    --if IsFirstTimePredicted() then
        self.SwayCT = self.SwayCT + (FT * steprate)
    --end

    return pos, ang
end

SWEP.ViewModelLastEyeAng = Angle(0, 0, 0)
SWEP.ViewModelSwayInertia = Angle(0, 0, 0)

function SWEP:GetViewModelInertia(pos, ang)
    local d = 1 - self:GetSightDelta()

    local diff = self:GetOwner():EyeAngles() - self.ViewModelLastEyeAng

    diff = diff / 4

    diff.p = math.Clamp(diff.p, -1, 1)
    diff.y = math.Clamp(diff.y, -1, 1)

    local vsi = self.ViewModelSwayInertia

    vsi.p = math.ApproachAngle(vsi.p, diff.p, vsi.p / 10 * FrameTime() / 0.5)
    vsi.y = math.ApproachAngle(vsi.y, diff.y, vsi.y / 10 * FrameTime() / 0.5)

    self.ViewModelLastEyeAng = self:GetOwner():EyeAngles()

    ang:RotateAroundAxis(ang:Up(), vsi.y * 12 * d)
    ang:RotateAroundAxis(ang:Right(), -vsi.p * 12 * d)

    -- pos = pos - (ang:Up() * vsi.p * 0.5 * d)
    -- pos = pos - (ang:Right() * vsi.y * 0.5 * d)

    return pos, ang
end

function SWEP:GetViewModelSmooth(pos, ang)
    return pos, ang
end

SWEP.ViewModelBobVelocity = 0
SWEP.ViewModelNotOnGround = 0

SWEP.BobCT = 0

function SWEP:GetViewModelBob(pos, ang)
    local opos, oang = Vector(), Angle(ang)

    local si = math.sin( CurTime() * math.pi * 2.1 )
    local si2 = math.sin( CurTime() * math.pi * 2.1*2 )
    local sia = math.abs( si )
    local spd = self:GetOwner():GetVelocity():Length2D()/250
    spd = math.Clamp( spd, 0, 1 )

    spd = spd * Lerp( 1-self:GetSightDelta(), 0.1, 1 )

    opos.x = 0.6 * si * spd
    opos.y = -0.1 * si2 * spd
    opos.z = -0.7 * math.abs( si ) * spd

    oang:RotateAroundAxis( ang:Right(), 0.9 * sia * spd )
    oang:RotateAroundAxis( ang:Up(), -0.2 * si * spd )
    oang:RotateAroundAxis( ang:Forward(), 1.2 * si2 * spd )

    pos = pos + ( ang:Right() * opos.x )
    pos = pos + ( ang:Forward() * opos.y )
    pos = pos + ( ang:Up() * opos.z )

    return pos, oang
end

SWEP.LastViewModelVerticalVelocity = 0
-- SWEP.ViewModelLanded = 0
-- SWEP.ViewModelLanding = 0

function SWEP:GetMidAirBob(pos, ang)
    local v = -self:GetOwner():GetVelocity().z / 200

    v = math.Clamp(v, -1, 1)

    -- if v == 0 and self.LastViewModelVerticalVelocity != 0 then
    --     self.ViewModelLanding = self.LastViewModelVerticalVelocity
    --     self.ViewModelLanded = 1
    -- end

    -- if self.ViewModelLanded > 0 then
    --     self.ViewModelLanded = math.Approach(self.ViewModelLanded, 0, FrameTime() / 0.25)

    v = Lerp(5 * FrameTime(), self.LastViewModelVerticalVelocity, v)
    -- end

    self.LastViewModelVerticalVelocity = v

    local d = self.ViewModelNotOnGround

    d = d * Lerp(self:GetSightDelta(), 1, 0.1)

    ang:RotateAroundAxis(ang:Right(), -v * d * 8 * math.sin(CurTime() * 0.15))

    return pos, ang
end

SWEP.ViewModelInertiaX = 0
SWEP.ViewModelInertiaY = 0

function SWEP:GetViewModelLeftRight(pos, ang)
    local v = self:GetOwner():GetVelocity()
    local d = Lerp(self:GetSightDelta(), 1, 0)

    v, _ = WorldToLocal(v, Angle(0, 0, 0), Vector(0, 0, 0), self:GetOwner():EyeAngles())

    local vx = math.Clamp(v.x / 200, -1, 1)
    local vy = math.Clamp(v.y / 200, -1, 1)

    self.ViewModelInertiaX = math.Approach(self.ViewModelInertiaX, vx, math.abs(vx) * FrameTime() / 0.1)
    self.ViewModelInertiaY = math.Approach(self.ViewModelInertiaY, vy, math.abs(vy) * FrameTime() / 0.1)

    pos = pos + (ang:Right() * -self.ViewModelInertiaX * 0.65 * d)
    pos = pos + (ang:Forward() * self.ViewModelInertiaY * 0.5 * d)

    return pos, ang
end