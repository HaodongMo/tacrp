EFFECT.StartPos = Vector(0, 0, 0)
EFFECT.EndPos = Vector(0, 0, 0)
EFFECT.StartTime = 0
EFFECT.LifeTime = 0.15
EFFECT.LifeTime2 = 0.15
EFFECT.DieTime = 0
EFFECT.Color = Color(255, 255, 255)
EFFECT.Speed = 5000

local head = Material("particle/fire")
local tracer = Material("tacrp/tracer")

function EFFECT:Init(data)

    local hit = data:GetOrigin()
    local wep = data:GetEntity()

    if !IsValid(wep) then return end

    local speed = wep:GetValue("MuzzleVelocity") or data:GetScale()
    local start = (wep.GetTracerOrigin and wep:GetTracerOrigin()) or data:GetStart()

    if speed > 0 then
        self.Speed = speed
    end

    self.LifeTime = (hit - start):Length() / self.Speed

    self.StartTime = UnPredictedCurTime()
    self.DieTime = UnPredictedCurTime() + math.max(self.LifeTime, self.LifeTime2)

    self.StartPos = start
    self.EndPos = hit

    self.Dir = data:GetNormal()
end

function EFFECT:Think()
    return self.DieTime > UnPredictedCurTime()
end

function EFFECT:Render()

    local d = (UnPredictedCurTime() - self.StartTime) / self.LifeTime
    local startpos = self.StartPos + (d * 0.2 * (self.EndPos - self.StartPos))
    local endpos = self.StartPos + (d * (self.EndPos - self.StartPos))

    --[[]
    local col = LerpColor(d, self.Color, Color(0, 0, 0, 0))
    local col2 = LerpColor(d2, Color(255, 255, 255, 255), Color(0, 0, 0, 0))

    render.SetMaterial(head)
    render.DrawSprite(endpos, size * 3, size * 3, col)

    render.SetMaterial(tracer)
    render.DrawBeam(endpos, startpos, size, 0, 1, col)
    ]]

    local size = math.Clamp(math.log(EyePos():DistToSqr(endpos) - math.pow(256, 2)), 0, math.huge)

    local vel = self.Dir * self.Speed - LocalPlayer():GetVelocity()

    local dot = math.abs(EyeAngles():Forward():Dot(vel:GetNormalized()))
    dot = math.Clamp(((dot * dot) - 0.25) * 5, 0, 1)
    local headsize = size * dot * 2 -- * math.min(EyePos():DistToSqr(pos) / math.pow(2500, 2), 1)
    -- cam.Start3D()

    local col = Color(255, 225, 200)
    -- local col = Color(255, 225, 200)

    render.SetMaterial(head)
    render.DrawSprite(endpos, headsize, headsize, col)

    local tailpos = startpos
    if (endpos - startpos):Length() > 512 then
        tailpos = endpos - self.Dir * 512
    end
    render.SetMaterial(tracer)
    render.DrawBeam(endpos, tailpos, size * 0.75, 0, 1, col)
end
