SWEP.ViewModelVelocityPos = Vector(0, 0, 0)
SWEP.ViewModelVelocityAng = Angle(0, 0, 0)

SWEP.ViewModelPos = Vector(0, 0, 0)
SWEP.ViewModelAng = Angle(0, 0, 0)

SWEP.SwayCT = 0

SWEP.EyeDiffP = 0
SWEP.EyeDiffY = 0

function SWEP:GetViewModelSway(pos, ang)
    local d = Lerp(self:GetSightDelta(), 1, 1)
    local v = 1
    local steprate = 1

    local FT = self:DeltaSysTime() * 1 --FrameTime()
    local CT = UnPredictedCurTime() -- CurTime()

    local ea = self:GetOwner():EyeAngles()
    if !self.LastEyeAng then self.LastEyeAng = Angle( ea.p, ea.y, 0 ) end
    local lea = self.LastEyeAng
    local diff = Angle()

    self.EyeDiffP = self.EyeDiffP - math.AngleDifference( lea.p, ea.p )
    self.EyeDiffY = self.EyeDiffY - math.AngleDifference( lea.y, ea.y )

    local lp = self.EyeDiffP
    local ly = self.EyeDiffY
    diff.p = lp
    diff.y = ly
    diff:Mul( 0.04 * (1-self:GetSightDelta()) )

    local bpos, bang = Vector(), Angle()
    --bpos.z = bpos.z - diff.p
    
    bang.p = bang.p + ( diff.p * 2 )
    bang.y = bang.y + ( diff.y * 1 )

    bpos.z = bpos.z - ( diff.p / 2 )
    bpos.x = bpos.x - ( diff.y / 4 )

    bang.r = bang.r + ( diff.y * -0.5 )
    bpos.x = bpos.x - ( diff.y * 0.2 )
    bpos.y = bpos.y - math.abs( diff.y * 0.2 )


    ang:RotateAroundAxis( ang:Right(),   bang.p )
    ang:RotateAroundAxis( ang:Up(),      bang.y )
    ang:RotateAroundAxis( ang:Forward(), bang.r )
    pos = pos - ang:Right() *            bpos.x
    pos = pos + ang:Forward() *          bpos.y
    pos = pos + ang:Up() *               bpos.z

    self.EyeDiffP = self.EyeDiffP*(1-(FT)) - self.EyeDiffP*((FT)) --math.Approach(self.EyeDiffP, 0, 90 * FrameTime())
    self.EyeDiffY = self.EyeDiffY*(1-(FT)) - self.EyeDiffY*((FT)) --math.Approach(self.EyeDiffY, 0, 90 * FrameTime())
    lea:Set( ea )

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

SWEP.ViewModelSpeed = 0

function SWEP:GetViewModelBob(pos, ang)
    local step = 10
    local mag = 1

    local FT = self:DeltaSysTime() * 1 --FrameTime()
    local CT = UnPredictedCurTime() -- CurTime()

    local v = self:GetOwner():GetVelocity():Length2D()
    local walks = self:GetOwner():GetWalkSpeed()
    local runs = self:GetOwner():GetRunSpeed()

    local sprints = walks + math.max(runs - walks, walks)

    v = math.Clamp(v, 0, sprints)
    self.ViewModelSpeed = math.Approach( self.ViewModelSpeed, v, (FrameTime()/0.6) * 320 )
    v = self.ViewModelSpeed
    self.ViewModelBobVelocity = math.Approach(self.ViewModelBobVelocity, v, FT * 2400)
    local d = math.Clamp(self.ViewModelBobVelocity / sprints, 0, 1)

    self.ViewModelNotOnGround = math.Approach(self.ViewModelNotOnGround, self:GetOwner():OnGround() and 0 or 1, FT / 0.1)

    local ds = d * Lerp(self:GetSightDelta(), 1, 0)
    d = d * Lerp(self:GetSightDelta(), 1, 0.05)

    local bpos, bang = Vector(), Angle()

    local vmng = self.ViewModelNotOnGround

    bpos.x = bpos.x + ( math.sin( CT * math.pi * 2.5 ) * d * 0.5 )
    bpos.z = bpos.z - ( d * Lerp(self:GetSightDelta(), 0.25, -0.5) )
    bpos.z = bpos.z - ( math.abs( math.sin( (CT-0.25) * math.pi * 2.5 ) ) * d * 0.7 )
    bpos.y = bpos.y - ( math.abs( math.sin( (CT-0.25) * math.pi * 2.5/2 ) ) * d * 0.4 )

    bang.y = bang.y + ( math.sin( CT * math.pi * 2.5 ) * d * Lerp(self:GetSightDelta(), 1, -1) )
    bang.p = bang.p + ( math.abs( math.sin( (CT-0.25) * math.pi * 2.5 ) ) * d * 0.5 )
    

    ang:RotateAroundAxis( ang:Right(),   bang.p )
    ang:RotateAroundAxis( ang:Up(),      bang.y )
    ang:RotateAroundAxis( ang:Forward(), bang.r )
    pos = pos - ang:Right() *            bpos.x
    pos = pos + ang:Forward() *          bpos.y
    pos = pos + ang:Up() *               bpos.z

    local steprate = Lerp(d, 1, 2.5)

    steprate = Lerp(self.ViewModelNotOnGround, steprate, 0.9)

    --if IsFirstTimePredicted() or game.SinglePlayer() then
        self.BobCT = self.BobCT + (FT * steprate)
    --end

    return pos, ang
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