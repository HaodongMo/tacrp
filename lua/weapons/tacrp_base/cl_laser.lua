local lasermat = Material("effects/laser1")
local flaremat = Material("effects/whiteflare")

function SWEP:DrawLaser(pos, ang, strength)
    strength = strength or 1

    local behavior = self:GetValue("ScopeHideWeapon") and self:IsInScope()

    if behavior then
        ang = self:GetShootDir()
    end

    local tr = util.TraceLine({
        start = pos,
        endpos = pos + (ang:Forward() * 30000),
        mask = MASK_SHOT,
        filter = self:GetOwner()
    })

    if tr.StartSolid then return end

    local width = math.Rand(0.1, 0.2) * strength

    if behavior then
        cam.Start3D()
        pos = pos - (ang:Forward() * 256)
    end

    render.SetMaterial(lasermat)
    render.DrawBeam(pos, tr.HitPos, width * 0.3, 0, 1, Color(200, 200, 200))
    render.DrawBeam(pos, tr.HitPos, width, 0, 1, Color(255, 0, 0))

    if tr.Hit then
        local mul = strength
        local rad = math.Rand(4, 6) * mul

        render.SetMaterial(flaremat)
        render.DrawSprite(tr.HitPos, rad, rad, Color(255, 0, 0))

        render.DrawSprite(tr.HitPos, rad * 0.3, rad * 0.3, Color(200, 200, 200))
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

        if atttbl.Laser then
            if wm then
                if self:GetOwner():IsPlayer() then
                    self:DrawLaser(k.WModel:GetPos(), self:GetShootDir(), power)
                else
                    self:DrawLaser(k.WModel:GetPos(), k.WModel:GetAngles(), power)
                end
            else
                if k.VModel then
                    self:DrawLaser(k.VModel:GetPos() + (k.VModel:GetAngles():Up() * 0.75), k.VModel:GetAngles(), power)
                end
            end
        end
    end
end