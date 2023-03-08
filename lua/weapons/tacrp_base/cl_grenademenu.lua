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

local function slicedcircle(x, y, radius, seg, ang0, ang1)
    local cir = {}

    ang0 = ang0 + 90
    ang1 = ang1 + 90

    local arcseg = math.Round(360 / math.abs(ang1 - ang0) * seg)

    table.insert(cir, {
        x = x,
        y = y,
        u = 0.5,
        v = 0.5
    })

    for i = 0, arcseg do
        local a = math.rad((i / arcseg) * -math.abs(ang1 - ang0) + ang0)

        table.insert(cir, {
            x = x + math.sin(a) * radius,
            y = y + math.cos(a) * radius,
            u = math.sin(a) / 2 + 0.5,
            v = math.cos(a) / 2 + 0.5
        })
    end

    surface.DrawPoly(cir)
end

local currentnade
local currentind
local lastmenu
function SWEP:DrawGrenadeHUD()

    if !GetConVar("tacrp_nademenu"):GetBool() then return end

    -- adapted from tfa vox radial menu
    local nades = self:GetAvailableGrenades(false)
    local scrw = ScrW()
    local scrh = ScrH()
    local r = ScreenScale(128)
    local r2 = ScreenScale(40)
    local sg = ScreenScale(32)
    local ri = r * 0.667
    local arcdegrees = 360 / #nades
    local d = 360
    local ft = FrameTime()

    local cursorx, cursory = input.GetCursorPos()
    local mouseangle = math.deg(math.atan2(cursorx - scrw / 2, cursory - scrh / 2))
    local mousedist = math.sqrt(math.pow(cursorx - scrw / 2, 2) + math.pow(cursory - scrh / 2, 2))
    mouseangle = math.NormalizeAngle(360 - (mouseangle - 90) + arcdegrees)
    if mouseangle < 0 then
        mouseangle = mouseangle + 360
    end

    if self:GetOwner():KeyDown(IN_GRENADE2) and !self:GetPrimedGrenade() then
        self.GrenadeMenuAlpha = math.Approach(self.GrenadeMenuAlpha, 1, 15 * ft)
        if !lastmenu then
            gui.EnableScreenClicker(true)
            lastmenu = true
        end

        if mousedist > r2 then
            local i = math.floor( mouseangle / arcdegrees ) + 1
            currentnade = nades[i]
            currentind = i
        else
            currentnade = self:GetGrenade()
            currentind = nil
        end
    else
        self.GrenadeMenuAlpha = math.Approach(self.GrenadeMenuAlpha, 0, -10 * ft)
        if lastmenu then
            if !self:GetCustomize() then
                gui.EnableScreenClicker(false)
            end
            if currentnade then
                if currentnade.Index != self:GetGrenade().Index then
                    self:GetOwner():EmitSound("tacrp/weapons/grenade/roll-" .. math.random(1, 3) .. ".wav")
                end
                net.Start("tacrp_togglenade")
                net.WriteUInt(currentnade.Index, 4)
                net.WriteBool(false)
                net.SendToServer()
            end
            lastmenu = false
        end
    end

    if self.GrenadeMenuAlpha <= 0 then
        return
    end

    local a = self.GrenadeMenuAlpha
    local col = Color(255, 255, 255, 255 * a)

    surface.DrawCircle(scrw / 2, scrh / 2, r, 255, 255, 255, a * 255)

    surface.SetDrawColor(0, 0, 0, a * 200)
    draw.NoTexture()
    filledcircle(scrw / 2, scrh / 2, r, 32)

    if currentind then
        surface.SetDrawColor(150, 150, 150, a * 100)
        draw.NoTexture()
        local i = currentind
        local d0 = 0 - arcdegrees * (i - 2)
        slicedcircle(scrw / 2, scrh / 2, r, 32, d0, d0 + arcdegrees)
    end

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

        if !TacRP.IsGrenadeInfiniteAmmo(nade.Index) then
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
        surface.SetTextPos(nadex - nadetextw * 0.5, nadey + ScreenScale(6))
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

    if !TacRP.IsGrenadeInfiniteAmmo(nade.Index) then
        local qty = "x" ..  tostring(self:GetOwner():GetAmmoCount(nade.Ammo))
        surface.SetFont("TacRP_HD44780A00_5x8_8")
        local qtyw = surface.GetTextSize(qty)
        surface.SetTextPos(scrw / 2 - qtyw * 0.5, scrh / 2 + ScreenScale(16))
        surface.SetTextColor(255, 255, 255, a * 255)
        surface.DrawText(qty)
    end

    -- description box is blocked in customize
    if self:GetCustomize() then return end

    local w, h = ScreenScale(96), ScreenScale(128)
    local tx, ty = scrw / 2 + r + ScreenScale(16), scrh / 2

    -- full name

    surface.SetDrawColor(0, 0, 0, 200 * a)
    TacRP.DrawCorneredBox(tx, ty - h * 0.5 - ScreenScale(28), w, ScreenScale(24), col)
    surface.SetTextColor(255, 255, 255, a * 255)

    local name = nade.FullName or nade.PrintName
    surface.SetFont("TacRP_Myriad_Pro_16")
    local name_w, name_h = surface.GetTextSize(name)
    if name_w > w then
        surface.SetFont("TacRP_Myriad_Pro_14")
        name_w, name_h = surface.GetTextSize(name)
    end
    surface.SetTextPos(tx + w / 2 - name_w / 2, ty - h * 0.5 - ScreenScale(28) + ScreenScale(12) - name_h / 2)
    surface.DrawText(name)


    -- Description

    surface.SetDrawColor(0, 0, 0, 200 * a)
    TacRP.DrawCorneredBox(tx, ty - h * 0.5, w, h, col)

    surface.SetFont("TacRP_Myriad_Pro_8")
    surface.SetTextPos(tx + ScreenScale(4), ty - h / 2 + ScreenScale(2))
    surface.DrawText("FUSE:")

    surface.SetFont("TacRP_Myriad_Pro_8")
    surface.SetTextPos(tx + ScreenScale(4), ty - h / 2 + ScreenScale(10))
    surface.DrawText(nade.DetType or "")

    surface.SetFont("TacRP_Myriad_Pro_8")
    surface.SetTextPos(tx + ScreenScale(4), ty - h / 2 + ScreenScale(22))
    surface.DrawText("DESCRIPTION:")

    surface.SetFont("TacRP_Myriad_Pro_8")
    local descmultiline = TacRP.MultiLineText(nade.Description or "", w - ScreenScale(7), "TacRP_Myriad_Pro_8")
    surface.SetTextColor(255, 255, 255, a * 255)
    for i, text in ipairs(descmultiline) do
        surface.SetTextPos(tx + ScreenScale(4), ty - h / 2 + ScreenScale(30) + (i - 1) * ScreenScale(8))
        surface.DrawText(text)
    end

    surface.SetFont("TacRP_Myriad_Pro_8")
    surface.SetDrawColor(0, 0, 0, 200 * a)


    if GetConVar("tacrp_nademenu_click"):GetBool() then

        local binded = input.LookupBinding("grenade1")

        TacRP.DrawCorneredBox(tx, ty + h * 0.5 + ScreenScale(2), w, ScreenScale(binded and 28 or 20), col)

        surface.SetTextPos(tx + ScreenScale(4), ty + h / 2 + ScreenScale(4))
        surface.DrawText("[" .. TacRP.GetBind("attack") .. "] - Throw Overhand")
        surface.SetTextPos(tx + ScreenScale(4), ty + h / 2 + ScreenScale(12))
        surface.DrawText("[" .. TacRP.GetBind("attack2") .. "] - Throw Underhand")
        if binded then
            surface.SetTextPos(tx + ScreenScale(4), ty + h / 2 + ScreenScale(20))
            surface.DrawText("Hold/Tap [" .. TacRP.GetBind("grenade1") .. "] - Over/Under")
        end
    else

        TacRP.DrawCorneredBox(tx, ty + h * 0.5 + ScreenScale(2), w, ScreenScale(20), col)

        surface.SetTextPos(tx + ScreenScale(4), ty + h / 2 + ScreenScale(4))
        surface.DrawText("Hold [" .. TacRP.GetBind("grenade1") .. "] - Throw Overhand")
        surface.SetTextPos(tx + ScreenScale(4), ty + h / 2 + ScreenScale(12))
        surface.DrawText("Tap [" .. TacRP.GetBind("grenade1") .. "] - Throw Underhand")
    end
end

hook.Add("VGUIMousePressed", "tacrp_grenademenu", function(pnl, mousecode)
    local wpn = LocalPlayer():GetActiveWeapon()
    if !(LocalPlayer():Alive() and IsValid(wpn) and wpn.ArcticTacRP and !wpn:StillWaiting() and (wpn.GrenadeMenuAlpha or 0) == 1) then return end
    if !GetConVar("tacrp_nademenu_click"):GetBool() or !currentnade then return end
    local under = (mousecode == MOUSE_RIGHT)
    wpn.GrenadeThrowOverride = under
    net.Start("tacrp_togglenade")
        net.WriteUInt(currentnade.Index, 4)
        net.WriteBool(true)
        net.WriteBool(under)
    net.SendToServer()
end)