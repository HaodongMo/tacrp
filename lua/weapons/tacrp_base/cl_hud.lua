function SWEP:ShouldDrawCrosshair()
    -- return false
end

function SWEP:DoDrawCrosshair(x, y)
    return true
end

function SWEP:GetBinding(bind)
    local t_bind = input.LookupBinding(bind)

    if !t_bind then
        t_bind = "BIND " .. bind .. "!"
    end

    return string.upper(t_bind)
end

function SWEP:DrawHUD()
    self:DoScope()

    self:DrawCustomizeHUD()

    -- if !GetConVar("TacRP_showgrenadepanel"):GetBool() then return end

    -- if self:GetValue("CanQuickNade") then
    --     local nade = self:GetGrenade()

    --     local qn_x = ScrW() / 2

    --     local icon = nade.Icon

    --     local qty = "INF"

    --     if nade.Ammo then
    --         qty = tostring(self:GetOwner():GetAmmoCount(nade.Ammo))
    --     end

    --     surface.SetDrawColor(0, 0, 0, 150)
    --     TacRP.DrawCorneredBox(qn_x - (ScreenScale(64) / 2), ScrH() - ScreenScale(24) - ScreenScale(32), ScreenScale(64), ScreenScale(48))

    --     if nade.Icon then

    --         local s = ScreenScale(24)

    --         surface.SetMaterial(icon)
    --         surface.SetDrawColor(255, 255, 255)
    --         surface.DrawTexturedRect(qn_x - (s / 2), ScrH() - ScreenScale(32) - s, s, s)

    --     end

    --     local txt = nade.PrintName .. " (x" .. qty .. ")"

    --     surface.SetFont("TacRP_LondonBetween_10")
    --     local w = surface.GetTextSize(txt)

    --     surface.SetFont("TacRP_LondonBetween_10")
    --     surface.SetTextColor(255, 255, 255, 255)
    --     surface.SetTextPos(qn_x - (w / 2), ScrH() - ScreenScale(32))
    --     surface.DrawText(txt)

    --     local throw_txt = self:GetBinding("+walk") .. " + " .. self:GetBinding("+attack")

    --     surface.SetFont("TacRP_LondonBetween_8")
    --     local throw_w = surface.GetTextSize(throw_txt)

    --     surface.SetFont("TacRP_LondonBetween_8")
    --     surface.SetTextColor(255, 255, 255, 255)
    --     surface.SetTextPos(qn_x - (throw_w / 2), ScrH() - ScreenScale(20))
    --     surface.DrawText(throw_txt)
    -- end
end

SWEP.Mat_Select = nil

function SWEP:DrawWeaponSelection(x, y, w, h, a)
    if !self.Mat_Select then
        self.Mat_Select = Material("entities/" .. self:GetClass() .. ".png")
    end

    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(self.Mat_Select)

    if w > h then
        y = y - ((w - h) / 2)
    end

    surface.DrawTexturedRect(x, y, w, w)
end

function SWEP:RangeUnitize(range)
    return tostring(math.Round(range)) .. " HU"
end