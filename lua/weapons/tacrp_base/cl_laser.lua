local lasermat = Material("effects/laser1")
local flaremat = Material("effects/whiteflare")

function SWEP:DrawLaser(pos, ang, strength, thirdperson)
    strength = strength or 1

    local behavior = (self:GetValue("ScopeHideWeapon") and self:IsInScope())
    local vm = self:GetOwner():IsPlayer() and self:GetOwner():GetViewModel()
    local curr_seq = IsValid(vm) and vm:GetSequenceName(vm:GetSequence())

    local delta = behavior and 1 or 0

    if IsValid(vm) and TacRP.ConVars["true_laser"]:GetBool() and (self:GetBlindFireMode() <= 1) and !self:GetCustomize() and !behavior then
        local d1 = 1
        if TacRP.ConVars["laser_beam"]:GetBool() then
            d1 = math.min((CurTime() - self:GetNextPrimaryFire()) / 2, (CurTime() - self:GetNextSecondaryFire()) / 2)
        elseif self:GetValue("RPM") < 120 then
            d1 = math.min(d1, (CurTime() - self:GetNextPrimaryFire()) / 0.5)
        end

        local d2 = (curr_seq == "reload_start") and 0 or 1
        local d3 = (1 - math.min(self:GetAnimLockTime() - CurTime()) / vm:SequenceDuration(vm:GetSequence()))
        local d4 = (1 - self:GetSprintDelta()) ^ 2
        local cutoff = 0.85
        d3 = math.max(d3 - cutoff, 0) / (1 - cutoff)

        delta = math.Clamp(self:GetReloading() and 0 or math.min(d1, d2, d3, d4), 0, 1)

    end

    local pos_tr = self:GetMuzzleOrigin()

    if behavior then
        ang = self:GetShootDir()
    else
        ang = LerpAngle(delta, ang, self:GetShootDir())
    end

    local tr = util.TraceLine({
        start = pos_tr,
        endpos = pos_tr + (ang:Forward() * 30000),
        mask = MASK_SHOT,
        filter = self:GetOwner()
    })

    if tr.StartSolid then return end
    local laser_pos = tr.HitPos + tr.HitNormal
    local adjusted_pos = thirdperson and laser_pos or TacRP.FormatViewModelAttachment(self.ViewModelFOV, laser_pos, false)
    laser_pos = LerpVector(delta, laser_pos, adjusted_pos)

    if behavior then
        cam.Start3D()
        pos = pos - (ang:Forward() * 256)
    end

    if TacRP.ConVars["laser_beam"]:GetBool() then
        local width = math.Rand(0.1, 0.2) * strength
        render.SetMaterial(lasermat)
        render.DrawBeam(pos, laser_pos, width * 0.3, 0, 1, Color(200, 200, 200))
        render.DrawBeam(pos, laser_pos, width, 0, 1, Color(255, 0, 0))
    end

    if tr.Hit and !tr.HitSky then
        local mul = strength
        local rad = math.Rand(4, 6) * mul

        render.SetMaterial(flaremat)
        render.DrawSprite(laser_pos, rad, rad, Color(255, 0, 0))
        render.DrawSprite(laser_pos, rad * 0.3, rad * 0.3, Color(200, 200, 200))

        debugoverlay.Cross(tr.HitPos, 4, FrameTime() * 2, Color(255, 0, 0))
    end

    if behavior then
        cam.End3D()
    end
end

function SWEP:DrawLasers(wm)
    wm = wm or false

    for i, k in pairs(self.Attachments) do
        if !k.Installed then continue end

        local atttbl = TacRP.GetAttTable(k.Installed)

        local power = 2

        if atttbl.Laser and self:GetTactical() then
            if wm and IsValid(k.WModel) then
                if self:GetOwner():IsPlayer() then
                    self:DrawLaser(k.WModel:GetPos(), self:GetShootDir(), power, true)
                else
                    self:DrawLaser(k.WModel:GetPos(), k.WModel:GetAngles(), power, true)
                end
            elseif IsValid(k.VModel) then
                self:DrawLaser(k.VModel:GetPos() + (k.VModel:GetAngles():Up() * 0.75), k.VModel:GetAngles(), power)
            end
        end
    end
end