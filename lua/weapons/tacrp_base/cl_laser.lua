local lasermat = Material("effects/laser1")
local flaremat = Material("effects/whiteflare")

function SWEP:DrawLaser(pos, ang, strength)
    strength = strength or 1

    local behavior = (self:GetValue("ScopeHideWeapon") and self:IsInScope())
    local alt_behavior = false -- (!self:GetReloading() and !self:GetCustomize() and self:GetSprintDelta() == 0)

    local pos_tr = pos

    if behavior then
        ang = self:GetShootDir()
    elseif alt_behavior then
        ang = self:GetShootDir()
        pos_tr = self:GetMuzzleOrigin()
    end

    -- in viewmodel drawing contexts, the end position will not look correct; this is just a tradeoff we have to take
    local tr = util.TraceLine({
        start = pos_tr,
        endpos = pos_tr + (ang:Forward() * 30000),
        mask = MASK_SHOT,
        filter = self:GetOwner()
    })

    if tr.StartSolid then return end
    local laser_pos = tr.HitPos
    local width = math.Rand(0.1, 0.2) * strength

    if behavior then
        cam.Start3D()
        pos = pos - (ang:Forward() * 256)
    -- elseif alt_behavior then
    --     cam.Start3D()
    end

    render.SetMaterial(lasermat)
    render.DrawBeam(pos, laser_pos, width * 0.3, 0, 1, Color(200, 200, 200))
    render.DrawBeam(pos, laser_pos, width, 0, 1, Color(255, 0, 0))

    if tr.Hit then
        local mul = strength
        local rad = math.Rand(4, 6) * mul

        render.SetMaterial(flaremat)
        render.DrawSprite(laser_pos, rad, rad, Color(255, 0, 0))
        render.DrawSprite(laser_pos, rad * 0.3, rad * 0.3, Color(200, 200, 200))

        debugoverlay.Cross(laser_pos, 4, FrameTime() * 2, Color(255, 0, 0))
    end

    if behavior then
        cam.End3D()
    -- elseif alt_behavior then
    --     cam.End3D()
    --     cam.IgnoreZ(true)
    end
end

function SWEP:DrawLasers(wm)
    wm = wm or false

    for i, k in pairs(self.Attachments) do
        if !k.Installed then continue end

        local atttbl = TacRP.GetAttTable(k.Installed)

        local power = 2

        if atttbl.Laser then
            if wm and IsValid(k.WModel) then
                if self:GetOwner():IsPlayer() then
                    self:DrawLaser(k.WModel:GetPos(), self:GetShootDir(), power)
                else
                    self:DrawLaser(k.WModel:GetPos(), k.WModel:GetAngles(), power)
                end
            elseif IsValid(k.VModel) then
                self:DrawLaser(k.VModel:GetPos() + (k.VModel:GetAngles():Up() * 0.75), k.VModel:GetAngles(), power)
            end
        end
    end
end