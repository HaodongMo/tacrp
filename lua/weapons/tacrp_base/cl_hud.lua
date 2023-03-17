function SWEP:ShouldDrawCrosshair()
    return GetConVar("tacrp_crosshair"):GetBool()
        and !self:GetReloading()
        and !self:GetCustomize()
        and !self:SprintLock()
        and (self:GetSightAmount() <= 0.5 or self:GetPeeking())
        and !(tobool(self:GetOwner():GetInfo("tacrp_nademenu")) and self:GetOwner():KeyDown(IN_GRENADE2))
        and !(tobool(self:GetOwner():GetInfo("tacrp_blindfiremenu")) and self:GetOwner():KeyDown(IN_ZOOM))
end

function SWEP:DoDrawCrosshair(x, y)
    local ft = FrameTime()
    self.CrosshairAlpha = self.CrosshairAlpha or 0
    if !self:ShouldDrawCrosshair() then
        self.CrosshairAlpha = math.Approach(self.CrosshairAlpha, 0, -10 * ft)
    else
        self.CrosshairAlpha = math.Approach(self.CrosshairAlpha, 1, 5 * ft)
    end

    local dev = GetConVar("developer"):GetInt() > 0 and LocalPlayer():IsAdmin()
    local tacfunc
    if self:GetValue("TacticalCrosshair") and self:GetTactical() then
        tacfunc = self:GetValue("TacticalCrosshair")
    elseif !dev and self.CrosshairAlpha <= 0 then return true end

    local dir = self:GetShootDir(true)

    local tr = util.TraceLine({
        start = self:GetMuzzleOrigin(),
        endpos = self:GetMuzzleOrigin() + (dir:Forward() * 50000),
        mask = MASK_SHOT,
        filter = self:GetOwner()
    })
    cam.Start3D()
        local w2s = tr.HitPos:ToScreen()
        x = math.Round(w2s.x)
        y = math.Round(w2s.y)
    cam.End3D()

    local spread = TacRP.GetFOVAcc(self)
    local sway = self:IsSwayEnabled() and self:GetSwayAmount() or self:GetForcedSwayAmount()

    if tacfunc then
        tacfunc(self, x, y, spread, sway)
    end

    spread = math.Round( math.max(spread, 2) + ScreenScale(sway * math.pi))

    if !dev and self.CrosshairAlpha <= 0 then return true end

    surface.SetDrawColor(50, 255, 50, 255 * self.CrosshairAlpha)

    surface.DrawRect(x, y, 1, 1)

    local w = 16
    surface.DrawLine(x, y - spread - w, x, y - spread)
    surface.DrawLine(x, y + spread, x, y + spread + w)
    surface.DrawLine(x - spread - w, y, x - spread, y)
    surface.DrawLine(x + spread, y, x + spread + w, y)

    -- Developer Crosshair
    if !self:GetReloading() and !self:GetCustomize() and dev then
        local tr2 = util.TraceLine({
            start = self:GetMuzzleOrigin(),
            endpos = self:GetMuzzleOrigin() + (self:GetShootDir():Forward() * 50000),
            mask = MASK_SHOT,
            filter = self:GetOwner()
        })
        cam.Start3D()
            local tw2s = tr2.HitPos:ToScreen()
            tw2s.x = math.Round(tw2s.x)
            tw2s.y = math.Round(tw2s.y)
        cam.End3D()
        if self:StillWaiting() then
            surface.SetDrawColor(150, 150, 150, 255)
        else
            surface.SetDrawColor(255, 50, 50, 255)
        end
        surface.DrawLine(tw2s.x, tw2s.y - 256, tw2s.x, tw2s.y + 256)
        surface.DrawLine(tw2s.x - 256, tw2s.y, tw2s.x + 256, tw2s.y)
        local spread = TacRP.GetFOVAcc(self)
        local recoil_txt = "Recoil: " .. tostring(math.Round(self:GetRecoilAmount() or 0, 3))
        surface.DrawCircle(tw2s.x, tw2s.y, spread, 255, 255, 255, 150)
        surface.DrawCircle(tw2s.x, tw2s.y, spread + 1, 255, 255, 255, 150)
        surface.SetFont("TacRP_Myriad_Pro_32_Unscaled")
        surface.SetTextColor(255, 255, 255, 255)
        surface.SetTextPos(tw2s.x - 256, tw2s.y)
        surface.DrawText(recoil_txt)
        local spread_txt = tostring("Cone: " .. math.Round(self:GetSpread(), 5))
        surface.SetTextPos(tw2s.x - 256, tw2s.y - 34)
        surface.DrawText(spread_txt)
        -- local tw = surface.GetTextSize(spread_txt)
        -- surface.SetTextPos(tw2s.x + 256 - tw, tw2s.y)
        -- surface.DrawText(spread_txt)


        local dist = (tr.HitPos - tr.StartPos):Length()
        local dist_txt = math.Round(dist) .. " HU"
        local tw = surface.GetTextSize(dist_txt)
        surface.SetTextPos(tw2s.x + 256 - tw, tw2s.y)
        surface.DrawText(dist_txt)

        local damage_txt = math.Round(self:GetDamageAtRange(dist)) .. " DMG"
        local tw2 = surface.GetTextSize(damage_txt)
        surface.SetTextPos(tw2s.x + 256 - tw2, tw2s.y - 34)
        surface.DrawText(damage_txt)
    end

    return true
end

SWEP.GrenadeMenuAlpha = 0

function SWEP:GetBinding(bind)
    local t_bind = input.LookupBinding(bind)

    if !t_bind then
        t_bind = "BIND " .. bind .. "!"
    end

    return string.upper(t_bind)
end

local mat_vignette = Material("tacrp/hud/vignette.png", "mips smooth")
local mat_radial = Material("tacrp/grenades/radial.png", "mips smooth")

local rackrisetime = 0
local lastrow = 0

local lasthp = 0
local lasthealtime = 0
local lastdmgtime = 0
local lastarmor = 0

local faceindex = 0

local shockedtime = 0
local lastblindfiremode = 0

function SWEP:DrawHUDBackground()
    self:DoScope()

    if !GetConVar("cl_drawhud"):GetBool() then return end

    -- draw a vignette effect around the screen based on recoil
    local recoil = self:GetRecoilAmount()
    if recoil > 0 and GetConVar("tacrp_vignette"):GetBool() then
        local recoil_pct = math.Clamp(recoil / self:GetValue("RecoilMaximum"), 0, 1) ^ 1.25
        local delta = self:Curve(recoil_pct)
        surface.SetDrawColor(0, 0, 0, 200 * delta)
        surface.SetMaterial(mat_vignette)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    end

    if self:GetValue("BlindFireCamera") then
        self:DoCornershot()
    end

    if self:GetValue("TacticalDraw") and self:GetTactical() then
        self:GetValue("TacticalDraw")(self)
    end

    self:DrawCustomizeHUD()

    if !self:GetCustomize() then
        local col = Color(255, 255, 255)
        local col_hi = Color(255, 150, 0)

        if GetConVar("tacrp_drawhud"):GetBool() then

            local w = ScreenScale(110)
            local h = ScreenScale(40)
            local x = ScrW() - w - ScreenScale(8)
            local y = ScrH() - h - ScreenScale(8)

            surface.SetDrawColor(0, 0, 0, 150)
            TacRP.DrawCorneredBox(x, y, w, h, col)

            surface.SetTextColor(col)
            surface.SetTextPos(x + ScreenScale(3), y + ScreenScale(1))
            surface.SetFont("TacRP_HD44780A00_5x8_8")
            surface.DrawText(self.PrintName)

            local row_size = 15

            local row1_bullets = 0
            local row2_bullets = 0
            local rackrise = 0

            local disparity = self:GetValue("ClipSize") % row_size

            local corrected = self:Clip1() - disparity

            local row = math.ceil(corrected / row_size)

            local sb = ScreenScale(4)

            local crc = self:Clip1()

            if disparity > 0 then
                crc = self:Clip1() + row_size - disparity
            end

            if crc > row_size then
                row2_bullets = math.min(row_size, self:Clip1() + disparity)
                row1_bullets = (corrected % row_size)

                if row1_bullets == 0 then
                    row1_bullets = row_size
                end

                if self:Clip1() <= row_size + disparity then
                    row2_bullets = disparity
                end

                if row < lastrow then
                    rackrisetime = CurTime()
                end

                lastrow = row
            else
                row2_bullets = self:Clip1()
            end

            if rackrisetime + 0.2 > CurTime() then
                local rackrisedelta = ((rackrisetime + 0.2) - CurTime()) / 0.2
                rackrise = rackrisedelta * (sb + ScreenScale(1))
            end

            render.SetScissorRect(x, y, x + w, y + ScreenScale(12) + sb + sb + 3, true)

            for i = 1, row1_bullets do
                if i == row1_bullets then
                    surface.SetDrawColor(col_hi)
                else
                    surface.SetDrawColor(col)
                end
                surface.DrawRect(x + ScreenScale(75 + 2) - (i * (sb + ScreenScale(1))), y + ScreenScale(12) + rackrise, sb, sb)
            end

            for i = 1, row2_bullets do
                if i == row2_bullets and row1_bullets <= 0 then
                    surface.SetDrawColor(col_hi)
                else
                    surface.SetDrawColor(col)
                end
                surface.DrawRect(x + ScreenScale(75 + 2) - (i * (sb + ScreenScale(1))), y + ScreenScale(12 + 1) + sb + rackrise, sb, sb)
            end

            render.SetScissorRect(0, 0, 0, 0, false)

            -- surface.SetDrawColor(col)
            -- surface.SetMaterial(mat_mag)
            -- surface.DrawRect(x + w - ScreenScale(31), y + ScreenScale(6), ScreenScale(5), ScreenScale(8))

            local clips = self:GetOwner():GetAmmoCount(self:GetValue("Ammo"))

            clips = math.ceil(clips)
            clips = math.min(clips, 999)

            if self:GetInfiniteAmmo() then
                clips = "INF"
            elseif self:GetValue("Ammo") == "" then
                clips = "---"
            else
                surface.SetTextColor(col)
                surface.SetTextPos(x + w - ScreenScale(31), y + ScreenScale(16))
                surface.SetFont("TacRP_HD44780A00_5x8_6")
                surface.DrawText("+")
            end

            surface.SetTextColor(col)
            surface.SetTextPos(x + w - ScreenScale(25), y + ScreenScale(12))
            surface.SetFont("TacRP_HD44780A00_5x8_10")
            surface.DrawText(clips)

            surface.SetDrawColor(col)
            surface.DrawLine(x + ScreenScale(2), y + ScreenScale(24), x + w - ScreenScale(2), y + ScreenScale(24))

            if self:GetSafe() then
                surface.SetMaterial(self:GetFiremodeMat(0))
            else
                surface.SetMaterial(self:GetFiremodeMat(self:GetCurrentFiremode()))
            end
            surface.SetDrawColor(col)
            local sfm = ScreenScale(14)
            surface.DrawTexturedRect(x + w - sfm - ScreenScale(1 + 10), y + h - sfm - ScreenScale(1), sfm, sfm)

            if self:GetFiremodeAmount() > 1 and !self:GetSafe() then
                local nextfm = TacRP.GetBind("use") .. "+" .. TacRP.GetBind("reload")

                surface.SetTextColor(col)
                surface.SetFont("TacRP_HD44780A00_5x8_4")
                local tw = surface.GetTextSize(nextfm)
                surface.SetTextPos(x + w - tw - ScreenScale(2), y + h - ScreenScale(14))
                surface.DrawText(nextfm)

                surface.SetMaterial(self:GetFiremodeMat(self:GetNextFiremode()))
                surface.SetDrawColor(col)
                local nfm = ScreenScale(8)
                surface.DrawTexturedRect(x + w - nfm - ScreenScale(4), y + h - nfm - ScreenScale(1), nfm, nfm)
            end

            if self:GetValue("CanQuickNade") then
                local nade = self:GetGrenade()

                local qty = nil --"INF"

                if !TacRP.IsGrenadeInfiniteAmmo(nade) then
                    qty = tostring(self:GetOwner():GetAmmoCount(nade.Ammo))
                end

                local sg = ScreenScale(14)

                if nade.Icon then
                    surface.SetMaterial(nade.Icon)
                    surface.SetDrawColor(255, 255, 255)
                    surface.DrawTexturedRect(x + ScreenScale(2), y + h - sg - ScreenScale(1), sg, sg)
                end

                local nadetext = nade.PrintName .. (qty and ("x" .. qty) or "")
                surface.SetTextPos(x + ScreenScale(4) + sg, y + h - sg + ScreenScale(1))
                surface.SetFont("TacRP_HD44780A00_5x8_8")
                surface.SetTextColor(col)
                surface.DrawText(nadetext)

                local mat = nil
                if !GetConVar("tacrp_nademenu"):GetBool() then
                    mat = self:GetNextGrenade().Icon
                else
                    mat = mat_radial
                end

                local nsg = ScreenScale(10)

                if mat then
                    surface.SetMaterial(mat)
                    surface.SetDrawColor(255, 255, 255)
                    surface.DrawTexturedRect(x + w - ScreenScale(41), y + h - nsg - ScreenScale(1), nsg, nsg)
                end

                local nextnadetxt = TacRP.GetBind("grenade2")

                surface.SetTextColor(col)
                surface.SetFont("TacRP_HD44780A00_5x8_4")
                local tw = surface.GetTextSize(nextnadetxt)
                surface.SetTextPos(x + w - ScreenScale(36) - (tw / 2), y + h - nsg - ScreenScale(4))
                surface.DrawText(nextnadetxt)
            end

            local l_w = ScreenScale(80)
            local l_h = ScreenScale(40)
            local l_x = ScreenScale(8)
            local l_y = ScrH() - l_h - ScreenScale(8)

            local perc = LocalPlayer():Health() / LocalPlayer():GetMaxHealth()

            surface.SetDrawColor(0, 0, 0, 150)
            TacRP.DrawCorneredBox(l_x, l_y, l_w, l_h, col)

            surface.SetTextPos(l_x + ScreenScale(4), l_y + ScreenScale(1))
            surface.SetFont("TacRP_HD44780A00_5x8_10")

            if perc <= 0.2 then
                surface.SetTextColor(col_hi)

                if math.sin(CurTime() * 7) > 0.5 then
                    surface.SetTextColor(col)
                end
            elseif perc <= 0.4 then
                surface.SetTextColor(col_hi)
            else
                surface.SetTextColor(col)
            end

            surface.DrawText("♥")

            local hpb_x = l_x + ScreenScale(14)
            local hpb_y = l_y + ScreenScale(4)
            local hpb_w = ScreenScale(2)
            local hpb_h = ScreenScale(8)

            local hpb_can = math.ceil(20 * perc)

            hpb_can = math.min(hpb_can, 20)

            for i = 1, 20 do
                if hpb_can <= 2 then
                    surface.SetDrawColor(col_hi)
                else
                    surface.SetDrawColor(col)
                end
                if hpb_can >= i then
                    surface.DrawRect(hpb_x + (i * (hpb_w + ScreenScale(1))), hpb_y, hpb_w, hpb_h)
                else
                    surface.DrawOutlinedRect(hpb_x + (i * (hpb_w + ScreenScale(1))), hpb_y, hpb_w, hpb_h)
                end
            end

            surface.SetDrawColor(col)

            surface.DrawLine(l_x + ScreenScale(2), l_y + ScreenScale(15), l_x + l_w - ScreenScale(2), l_y + ScreenScale(15))

            local face = "-_-"

            local blindfiremode = self:GetBlindFireMode()

            if blindfiremode == TacRP.BLINDFIRE_KYS then
                if lastblindfiremode != blindfiremode then
                    shockedtime = CurTime() + 1
                    faceindex = math.random(1, 2)
                end
            end

            lastblindfiremode = blindfiremode

            if lastdmgtime + 1 > CurTime() then
                face = ({
                    "#> <",
                    "(>Д<)",
                    "(@_@)",
                    "(ー;ー)",
                    "(・ロ・)",
                    "゛> <",
                    "(>_メ)",
                    "(*_*)",
                    "゜・+_+"
                })[faceindex]
            elseif shockedtime > CurTime() then
                face = ({
                    ";O-O;",
                    ";>-<;",
                })[faceindex]
            elseif blindfiremode == TacRP.BLINDFIRE_KYS then
                if math.sin(CurTime() * 1) > 0.995 then
                    face = ";>_<;"
                else
                    face = ";o_o;"
                end
            elseif lasthealtime + 1 > CurTime() then
                if perc >= 1 then
                    face = ({
                        "(^ω~)",
                        "(>ω^)",
                        "(>3^)",
                        "(^.~)",
                        "(･ω<)",
                        "(^.~)",
                        "♥(ツ)♥"
                    })[faceindex]

                    if lasthp < LocalPlayer():Health() then
                        lasthealtime = CurTime()

                        faceindex = math.random(1, 7)
                    end
                else
                    face = ({
                        "(^w^)",
                        "('3')",
                        "(♡3♡)",
                        "(ПωП)",
                        "(>3<)",
                        "('w')",
                        "TYSM!"
                    })[faceindex]
                end
            else
                if math.sin(CurTime() * 3) > 0.98 then
                    if perc < 0.1 then
                        face = "(>_<)"
                    elseif perc < 0.25 then
                        face = "(>_<)"
                    elseif perc < 0.5 then
                        face = "(>_<)"
                    elseif perc < 0.95 then
                        face = "(-_-)"
                    else
                        face = "(-_-)"
                    end
                else
                    if perc < 0.1 then
                        face = "(×_×)"
                    elseif perc < 0.25 then
                        face = "(;_;)"
                    elseif perc < 0.5 then
                        face = "(゜_゜)"
                    elseif perc < 0.95 then
                        face = "('_')"
                    else
                        face = "(^_^)"
                    end
                end

                if lasthp > LocalPlayer():Health() then
                    lastdmgtime = CurTime()

                    faceindex = math.random(1, 8)
                elseif lasthp < LocalPlayer():Health() or lastarmor < LocalPlayer():Armor() then
                    lasthealtime = CurTime()

                    faceindex = math.random(1, 7)
                end
            end

            if LocalPlayer():GetNWBool("HasGodMode") or perc > 2.5 then
                if math.sin(CurTime() * 3) > 0.96 then
                    face = "(UwU)"
                else
                    face = "(OwO)"
                end
            end

            surface.SetTextPos(l_x + ScreenScale(4), l_y + ScreenScale(22))
            surface.SetFont("TacRP_HD44780A00_5x8_10")
            surface.SetTextColor(col)
            surface.DrawText(face)

            lasthp = LocalPlayer():Health()

            local armor = self:GetOwner():Armor()

            local asq = ScreenScale(8)
            local ss = ScreenScale(4)

            local function drawarmorsquare(level, x, y)
                if level == 1 then
                    surface.SetDrawColor(col)
                    surface.DrawOutlinedRect(x, y, asq, asq)
                    surface.DrawOutlinedRect(x + 1, y + 1, asq - 2, asq - 2)
                elseif level == 2 then
                    surface.SetDrawColor(col)
                    surface.DrawRect(x + ((asq - ss) / 2), y + ((asq - ss) / 2), ss, ss)
                    surface.DrawOutlinedRect(x, y, asq, asq)
                    surface.DrawOutlinedRect(x + 1, y + 1, asq - 2, asq - 2)
                else
                    surface.SetDrawColor(col)
                    surface.DrawRect(x, y, asq, asq)
                end
            end

            local cx1 = l_x + l_w - ScreenScale(20)
            local cy1 = l_y + ScreenScale(19)
            local cx2 = cx1 + asq + 2
            local cy2 = cy1 + asq + 2

            surface.SetTextPos(cx1 - ScreenScale(10), cy1 + ScreenScale(3))
            surface.SetFont("TacRP_HD44780A00_5x8_10")
            surface.SetTextColor(col)
            surface.DrawText("⌂")

            if armor >= 100 then
                drawarmorsquare(3, cx1, cy1)
            elseif armor > 75 then
                drawarmorsquare(2, cx1, cy1)
            else
                drawarmorsquare(1, cx1, cy1)
            end

            if armor >= 75 then
                drawarmorsquare(3, cx2, cy1)
            elseif armor > 50 then
                drawarmorsquare(2, cx2, cy1)
            else
                drawarmorsquare(1, cx2, cy1)
            end

            if armor >= 50 then
                drawarmorsquare(3, cx2, cy2)
            elseif armor > 25 then
                drawarmorsquare(2, cx2, cy2)
            else
                drawarmorsquare(1, cx2, cy2)
            end

            if armor >= 25 then
                drawarmorsquare(3, cx1, cy2)
            elseif armor > 0 then
                drawarmorsquare(2, cx1, cy2)
            else
                drawarmorsquare(1, cx1, cy2)
            end
        elseif GetConVar("tacrp_minhud"):GetBool() then
            local w = ScreenScale(110)
            local h = ScreenScale(16)
            local x = ScrW() / 2 - w / 2
            local y = ScrH() - h - ScreenScale(8)

            surface.SetDrawColor(0, 0, 0, 150)
            TacRP.DrawCorneredBox(x, y, w, h, col)

            if self:GetSafe() then
                surface.SetMaterial(self:GetFiremodeMat(0))
            else
                surface.SetMaterial(self:GetFiremodeMat(self:GetCurrentFiremode()))
            end
            surface.SetDrawColor(col)
            local sfm = ScreenScale(14)
            surface.DrawTexturedRect(x + w - sfm - ScreenScale(1 + 10), y + h - sfm - ScreenScale(1), sfm, sfm)

            if self:GetFiremodeAmount() > 1 and !self:GetSafe() then
                local nextfm = TacRP.GetBind("use") .. "+" .. TacRP.GetBind("reload")

                surface.SetTextColor(col)
                surface.SetFont("TacRP_HD44780A00_5x8_4")
                local tw = surface.GetTextSize(nextfm)
                surface.SetTextPos(x + w - tw - ScreenScale(2), y + h - ScreenScale(14))
                surface.DrawText(nextfm)

                surface.SetMaterial(self:GetFiremodeMat(self:GetNextFiremode()))
                surface.SetDrawColor(col)
                local nfm = ScreenScale(8)
                surface.DrawTexturedRect(x + w - nfm - ScreenScale(4), y + h - nfm - ScreenScale(1), nfm, nfm)
            end

            if self:GetValue("CanQuickNade") then
                local nade = self:GetGrenade()

                local qty = nil --"INF"

                if !TacRP.IsGrenadeInfiniteAmmo(nade) then
                    qty = tostring(self:GetOwner():GetAmmoCount(nade.Ammo))
                end

                local sg = ScreenScale(14)

                if nade.Icon then
                    surface.SetMaterial(nade.Icon)
                    surface.SetDrawColor(255, 255, 255)
                    surface.DrawTexturedRect(x + ScreenScale(2), y + h - sg - ScreenScale(1), sg, sg)
                end

                local nadetext = nade.PrintName .. (qty and ("x" .. qty) or "")
                surface.SetTextPos(x + ScreenScale(4) + sg, y + h - sg + ScreenScale(1))
                surface.SetFont("TacRP_HD44780A00_5x8_8")
                surface.SetTextColor(col)
                surface.DrawText(nadetext)

                local mat = nil
                if !GetConVar("tacrp_nademenu"):GetBool() then
                    mat = self:GetNextGrenade().Icon
                else
                    mat = mat_radial
                end

                local nsg = ScreenScale(10)

                if mat then
                    surface.SetMaterial(mat)
                    surface.SetDrawColor(255, 255, 255)
                    surface.DrawTexturedRect(x + w - ScreenScale(41), y + h - nsg - ScreenScale(1), nsg, nsg)
                end

                local nextnadetxt = TacRP.GetBind("grenade2")

                surface.SetTextColor(col)
                surface.SetFont("TacRP_HD44780A00_5x8_4")
                local tw = surface.GetTextSize(nextnadetxt)
                surface.SetTextPos(x + w - ScreenScale(36) - (tw / 2), y + h - nsg - ScreenScale(4))
                surface.DrawText(nextnadetxt)
            end
        end
    end

    -- local ft = FrameTime()
    -- if self:GetOwner():KeyDown(IN_GRENADE2) then
    --     self.GrenadeMenuAlpha = math.Approach(self.GrenadeMenuAlpha, 1, 5 * ft)
    --     if !self.GrenadeHUD then
    --         self:CreateGrenadeHUD()
    --     end
    -- else
    --     self.GrenadeMenuAlpha = math.Approach(self.GrenadeMenuAlpha, 0, -10 * ft)
    --     if self:GetOwner():KeyDownLast(IN_GRENADE2) then
    --         gui.EnableScreenClicker(false)
    --         -- todo check grneade
    --     elseif self.GrenadeMenuAlpha == 0 and self.GrenadeHUD then
    --         self:RemoveGrenadeHUD()
    --     end
    -- end

    self:DrawGrenadeHUD()

    self:DrawBlindFireHUD()

    lastammo = self:Clip1()
    lastarmor = LocalPlayer():Armor()
end

SWEP.Mat_Select = nil

function SWEP:DrawWeaponSelection(x, y, w, h, a)
    if !self.Mat_Select then
        self.Mat_Select = Material("entities/" .. self:GetClass() .. ".png", "smooth mips")
    end

    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(self.Mat_Select)

    if w > h then
        y = y - ((w - h) / 2)
    end

    surface.DrawTexturedRect(x, y, w, w)
end

function SWEP:RangeUnitize(range)
    if GetConVar("tacrp_metricunit"):GetBool() then
        return tostring(math.Round(range * TacRP.HUToM)) .. "m"
    else
        return tostring(math.Round(range)) .. " HU"
    end
end