local function filledcircle(x, y, radius, seg)
    local cir = {}

    table.insert(cir, {
        x = x,
        y = y,
        u = 0.5,
        v = 0.5
    })

    for i = 0, seg do
        local a = math.rad((i / seg) * -360)

        table.insert(cir, {
            x = x + math.sin(a) * radius,
            y = y + math.cos(a) * radius,
            u = math.sin(a) / 2 + 0.5,
            v = math.cos(a) / 2 + 0.5
        })
    end

    local a = math.rad(0)

    table.insert(cir, {
        x = x + math.sin(a) * radius,
        y = y + math.cos(a) * radius,
        u = math.sin(a) / 2 + 0.5,
        v = math.cos(a) / 2 + 0.5
    })

    surface.DrawPoly(cir)
end

local currentnade
function SWEP:DrawGrenadeHUD()

    if !GetConVar("tacrp_nademenu"):GetBool() then return end

    -- adapted from tfa vox radial menu
    local nades = self:GetAvailableGrenades(false)
    local scrw = ScrW()
    local scrh = ScrH()
    local r = ScreenScale(128)
    local r2 = ScreenScale(32)
    local sg = ScreenScale(32)
    local ri = r * 0.667
    local arcdegrees = 360 / #nades
    local d = 360
    local ft = FrameTime()

    if self:GetOwner():KeyDown(IN_GRENADE2) and !self:GetPrimedGrenade() then
        self.GrenadeMenuAlpha = math.Approach(self.GrenadeMenuAlpha, 1, 15 * ft)
        if !self:GetOwner():KeyDownLast(IN_GRENADE2) then
            gui.EnableScreenClicker(true)
        end

        local cursorx, cursory = input.GetCursorPos()
        local mouseangle = math.deg(math.atan2(cursorx - scrw / 2, cursory - scrh / 2))
        local mousedist = math.sqrt(math.pow(cursorx - scrw / 2, 2) + math.pow(cursory - scrh / 2, 2))
        mouseangle = math.NormalizeAngle(360 - (mouseangle - 90) + arcdegrees)
        if mouseangle < 0 then
            mouseangle = mouseangle + 360
        end

        if mousedist > r2 then
            local i = math.floor( mouseangle / arcdegrees ) + 1
            currentnade = nades[i]
        else
            currentnade = self:GetGrenade()
        end
    else
        self.GrenadeMenuAlpha = math.Approach(self.GrenadeMenuAlpha, 0, -10 * ft)
        if self:GetOwner():KeyDownLast(IN_GRENADE2) then
            if !self:GetCustomize() then
                gui.EnableScreenClicker(false)
            end
            if currentnade then
                if currentnade.Index != self:GetGrenade().Index then
                    self:GetOwner():EmitSound("tacrp/weapons/grenade/roll-" .. math.random(1, 3) .. ".wav")
                end
                net.Start("tacrp_togglenade")
                net.WriteUInt(currentnade.Index, 4)
                net.SendToServer()

            end
        end
    end

    if self.GrenadeMenuAlpha <= 0 then
        return
    end

    local a = self.GrenadeMenuAlpha

    surface.DrawCircle(scrw / 2, scrh / 2, r, 255, 255, 255, a * 255)
    surface.SetDrawColor(0, 0, 0, a * 200)
    filledcircle(scrw / 2, scrh / 2, r, 32)
    surface.SetDrawColor(0, 0, 0, a * 255)
    surface.DrawCircle(scrw / 2, scrh / 2, r2, 255, 255, 255, a * 255)



    for i = 1, #nades do
        local rad = math.rad( d + arcdegrees * 0.5 )

        surface.SetDrawColor(255, 255, 255, a * 255)
        surface.DrawLine(
            scrw / 2 + math.cos(math.rad(d)) * r2,
            scrh / 2 - math.sin(math.rad(d)) * r2,
            scrw / 2 + math.cos(math.rad(d)) * r,
            scrh / 2 - math.sin(math.rad(d)) * r)

        local nadex, nadey = scrw / 2 + math.cos(rad) * ri, scrh / 2 - math.sin(rad) * ri
        local nade = nades[i]

        local qty = nil --"INF"

        if nade.Ammo and (nade.Secret or !GetConVar("tacrp_infinitegrenades"):GetBool()) then
            qty = self:GetOwner():GetAmmoCount(nade.Ammo)
        end

        if !qty or qty > 0 then
            surface.SetDrawColor(255, 255, 255, a * 255)
            surface.SetTextColor(255, 255, 255, a * 255)
        else
            surface.SetDrawColor(175, 175, 175, a * 255)
            surface.SetTextColor(175, 175, 175, a * 255)
        end

        if nade.Icon then
            surface.SetMaterial(nade.Icon)
            surface.DrawTexturedRect(nadex - sg * 0.5, nadey - sg * 0.5 - ScreenScale(8), sg, sg)
        end
        local nadetext = nade.PrintName .. (qty and ("x" .. qty) or "")
        surface.SetFont("TacRP_HD44780A00_5x8_8")
        local nadetextw = surface.GetTextSize(nadetext)
        surface.SetTextPos(nadex - nadetextw * 0.5, nadey + ScreenScale(4))
        surface.DrawText(nadetext)

        d = d - arcdegrees

    end

    local nade = currentnade
    if nade.Icon then
        surface.SetMaterial(nade.Icon)
        surface.SetDrawColor(255, 255, 255, a * 255)
        surface.DrawTexturedRect(scrw / 2 - sg * 0.5, scrh / 2 - sg * 0.5 - ScreenScale(8), sg, sg)
    end

    local nadetext = nade.PrintName
    surface.SetFont("TacRP_HD44780A00_5x8_8")
    local nadetextw = surface.GetTextSize(nadetext)
    surface.SetTextPos(scrw / 2 - nadetextw * 0.5, scrh / 2 + ScreenScale(6))
    surface.SetTextColor(255, 255, 255, a * 255)
    surface.DrawText(nadetext)

    if nade.Ammo and (nade.Secret or !GetConVar("tacrp_infinitegrenades"):GetBool()) then
        local qty = "x" ..  tostring(self:GetOwner():GetAmmoCount(nade.Ammo))
        surface.SetFont("TacRP_HD44780A00_5x8_8")
        local qtyw = surface.GetTextSize(qty)
        surface.SetTextPos(scrw / 2 - qtyw * 0.5, scrh / 2 + ScreenScale(16))
        surface.SetTextColor(255, 255, 255, a * 255)
        surface.DrawText(qty)
    end

end