local gaA = 0
local function GetFOVAcc(wep)
    cam.Start3D()
        local lool = ( EyePos() + ( EyeAngles():Forward() ) + ( (wep:GetSpread()) * EyeAngles():Up() ) ):ToScreen()
    cam.End3D()

    local gau = ( (ScrH() / 2) - lool.y )
    gaA = math.Approach(gaA, gau, (ScrH() / 2) * FrameTime())

    return gaA
end

function SWEP:ShouldDrawCrosshair()
    -- return false
end

function SWEP:DoDrawCrosshair(x, y)
    -- return true
end

function SWEP:GetBinding(bind)
    local t_bind = input.LookupBinding(bind)

    if !t_bind then
        t_bind = "BIND " .. bind .. "!"
    end

    return string.upper(t_bind)
end

local mat_rf = Material("tacrp/hud/rangefinder.png", "mips smooth")
local mat_radar = Material("tacrp/hud/radar.png", "smooth")
local mat_radar_active = Material("tacrp/hud/radar_active.png", "mips smooth")
local mat_dot = Material("tacrp/hud/dot.png", "mips smooth")
local mat_mag = Material("tacrp/hud/mag.png", "")
local mat_vignette = Material("tacrp/hud/vignette.png", "mips smooth")

local mat_spread = Material("tacrp/hud/spreadgauge.png", "smooth")
local mat_spread_fire = Material("tacrp/hud/spreadgauge_fire.png", "")
local mat_spread_gauge = Material("tacrp/hud/spreadgauge_gauge.png", "")
local mat_spread_text = Material("tacrp/hud/spreadgauge_text.png", "")

local mat_cone = Material("tacrp/hud/cone.png", "smooth")
local mat_cone_text = Material("tacrp/hud/cone_text.png", "")

local cached_txt = ""
local cached_txt2 = ""
local lastrangefinder = 0
local lastradar = 0
local scantime = 1.5
local cache_lastradarpositions = {}

local lastammo = 0
local lastshoottime = 0
local rackrisetime = 0
local lastshotalpha = 0
local lastrow = 0

local lasthp = 0
local lasthealtime = 0
local lastdmgtime = 0
local lastarmor = 0

local faceindex = 0

function SWEP:DrawHUDBackground()
    self:DoScope()

    // if scoped, draw a vignette effect around the screen

    if self:GetSightDelta() > 0 then
        local delta = self:Curve(self:GetSightDelta())
        // surface.SetDrawColor(0, 0, 0, 255 * delta - 1)
        // surface.SetMaterial(mat_vignette)
        // surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

        surface.SetDrawColor(0, 0, 0, 255 * delta)
        surface.SetMaterial(mat_vignette)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    end

    if self:GetValue("BlindFireCamera") then
        self:DoCornershot()
    end

    if self:GetValue("Rangefinder") and self:GetTactical() then
        local txt = "NO RTN"
        local txt2 = ""
        local txt3 = ""
        local txt4 = ""

        if lastrangefinder + (1 / 30) < CurTime() then
            local tr = util.TraceLine({
                start = self:GetMuzzleOrigin(),
                endpos = self:GetMuzzleOrigin() + (self:GetShootDir():Forward() * 50000),
                mask = MASK_SHOT,
                filter = self:GetOwner()
            })

            local dist = (tr.HitPos - tr.StartPos):Length()
            local dist2 = math.Round(dist * 0.3048 / 12, 0)
            dist = math.Round(dist, 0)
            dist = math.min(dist, 99999)
            dist2 = math.min(dist2, 9999)
            txt = tostring(dist2) .. "m"
            txt2 = tostring(dist) .. "HU"

            local edmg = self:GetDamageAtRange(dist)
            edmg = math.ceil(edmg)

            txt3 = tostring(edmg) .. "DMG"

            for _ = 0, 12 - string.len(txt3) - string.len(txt) do
                txt = txt .. " "
            end

            txt = txt .. txt3

            local mult = self:GetValue("BodyDamageMultipliers")
            local min = math.min(unpack(mult))

            if edmg * min >= 100 then
                txt4 = "LETHAL"
            elseif edmg * mult[HITGROUP_LEFTLEG] >= 100 then
                txt4 = "LEGS"
            elseif edmg * mult[HITGROUP_LEFTARM] >= 100 then
                txt4 = "ARMS"
            elseif edmg * mult[HITGROUP_STOMACH] >= 100 then
                txt4 = "STMCH"
            elseif edmg * mult[HITGROUP_CHEST] >= 100 then
                txt4 = "CHEST"
            elseif edmg * mult[HITGROUP_HEAD] >= 100 then
                txt4 = "HEAD"
            else
                txt4 = tostring(math.ceil(100 / edmg)) .. (self:GetValue("Num") > 1 and "PTK" or "STK")
            end

            for _ = 0, 12 - string.len(txt4) - string.len(txt2) do
                txt2 = txt2 .. " "
            end

            txt2 = txt2 .. txt4

            cached_txt = txt
            cached_txt2 = txt2
            lastrangefinder = CurTime()
        else
            txt = cached_txt
            txt2 = cached_txt2
        end

        local scrw = ScrW()
        local scrh = ScrH()

        local w = ScreenScale(100)
        local h = ScreenScale(50)

        local x = (scrw - w) / 2
        local y = (scrh - h) * 5 / 6

        surface.SetMaterial(mat_rf)
        surface.SetDrawColor(255, 255, 255, 100)
        surface.DrawTexturedRect(x, y, w, h)

        surface.SetFont("TacRP_HD44780A00_5x8_10")
        -- local tw = surface.GetTextSize(txt)
        surface.SetTextPos(x + ScreenScale(3), y + ScreenScale(12))
        surface.SetTextColor(0, 0, 0)
        surface.DrawText(txt)

        -- local tw2 = surface.GetTextSize(txt2)
        surface.SetTextPos(x + ScreenScale(3), y + ScreenScale(22))
        surface.SetTextColor(0, 0, 0)
        surface.DrawText(txt2)
    end

    if self:GetValue("Minimap") and self:GetTactical() then
        local scrw = ScrW()
        local scrh = ScrH()

        local w = ScreenScale(100)
        local h = ScreenScale(100)

        local x = (scrw - w) / 2
        local y = (scrh - h) * 0.99

        surface.SetMaterial(mat_radar)
        surface.SetDrawColor(255, 255, 255, 100)
        surface.DrawTexturedRect(x, y, w, h)

        local radarpositions = {}

        if lastradar + scantime > CurTime() then
            radarpositions = cache_lastradarpositions
        else
            local tbl = ents.FindInSphere(self:GetOwner():GetPos(), 50 / TacRP.HUToM)

            for _, ent in ipairs(tbl) do
                if !(ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) then continue end
                if ent == self:GetOwner() then continue end

                local ang = self:GetOwner():EyeAngles()

                ang.y = ang.y + 90
                ang.p = 0
                ang.r = 0

                local relpos = WorldToLocal(ent:GetPos(), Angle(0, 0, 0), self:GetOwner():GetPos(), ang)

                local read = {
                    x = -relpos.x,
                    y = relpos.y,
                }

                table.insert(radarpositions, read)
            end

            lastradar = CurTime()
            cache_lastradarpositions = radarpositions
        end

        surface.SetDrawColor(0, 0, 0, 255 * 2 * (1 - ((CurTime() - lastradar) / scantime)))
        surface.SetMaterial(mat_radar_active)
        surface.DrawTexturedRect(x, y, w, h)
        -- surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(mat_dot)

        local ds = ScreenScale(4)

        for _, dot in ipairs(radarpositions) do
            local dx = x + (dot.x * TacRP.HUToM * w * (36 / 40) / 100) + (w / 2)
            local dy = y + (dot.y * TacRP.HUToM * h * (36 / 40) / 100) + (h / 2)

            local gs = ScreenScale(8)

            dx = math.Round(dx / (w / gs)) * (w / gs)
            dy = math.Round(dy / (h / gs)) * (h / gs)

            dx = dx - ScreenScale(0.5)
            dy = dy - ScreenScale(0.5)

            surface.DrawTexturedRect(dx - (ds / 2), dy - (ds / 2), ds, ds)
        end
    end

    if self:GetValue("SpreadGauge") and self:GetTactical() then

        local scrw = ScrW()
        local scrh = ScrH()

        local w = ScreenScale(60)
        local h = ScreenScale(30)

        local x = (scrw - w) / 2
        local y = (scrh - h) * 5.5 / 6

        -- if self:GetSightDelta() > 0 then
        --     y = y - self:GetSightDelta() ^ 0.5 * ScreenScale(24)
        -- end

        surface.SetMaterial(mat_spread)
        surface.SetDrawColor(255, 255, 255, 100)
        surface.DrawTexturedRect(x, y, w, h)

        local spread = math.Clamp(self:GetSpread() / 0.00092592592, 0, 999.9)
        local spread1 = math.floor(spread)
        local spread2 = math.floor((spread - spread1) * 10)
        local spread_txt1 = tostring(spread1)
        if spread < 10 then
            spread_txt1 = "00" .. spread_txt1
        elseif spread < 100 then
            spread_txt1 = "0" .. spread_txt1
        end
        surface.SetFont("TacRP_HD44780A00_5x8_6")
        surface.SetTextColor(0, 0, 0)
        surface.SetTextPos(x + ScreenScale(22), y + ScreenScale(2.5))
        surface.DrawText(spread_txt1)
        surface.DrawText(".")
        surface.DrawText(spread2)

        local recoil = self:GetRecoilAmount()
        local recoil_pct = math.Round(recoil / self:GetValue("RecoilMaximum") * 100)
        surface.SetTextPos(x + ScreenScale(22), y + ScreenScale(11.5))
        if recoil_pct >= 100 and math.sin(SysTime() * 20) > 0 then
            surface.SetTextColor(0, 0, 0, 100)
        else
            surface.SetTextColor(0, 0, 0)
        end
        surface.DrawText(recoil_pct)

        local last_fire = math.Clamp((self:GetNextPrimaryFire() - CurTime()) / (60 / self:GetValue("RPM")), 0, 1)
        surface.SetDrawColor(255, 255, 255, last_fire * 255)
        surface.SetMaterial(mat_spread_fire)
        surface.DrawTexturedRect(x, y, w, h)

        surface.SetDrawColor(255, 255, 255, math.abs(math.sin(SysTime())) * 200)
        surface.SetMaterial(mat_spread_gauge)
        surface.DrawTexturedRect(x, y, w, h)

        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(mat_spread_text)
        surface.DrawTexturedRect(x, y, w, h)

        local w_cone = ScreenScale(40)
        local x2 = (scrw - w_cone) / 2
        local y2 = y - w_cone - ScreenScale(4)

        surface.SetMaterial(mat_cone)
        surface.SetDrawColor(255, 255, 255, 100)
        surface.DrawTexturedRect(x2, y2, w_cone, w_cone)
        surface.SetMaterial(mat_cone_text)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawTexturedRect(x2, y2, w_cone, w_cone)

        local acc_size = math.max(GetFOVAcc(self), 1)
        local a = math.Clamp(1 - (acc_size - ScreenScale(15)) / ScreenScale(5), 0, 1) ^ 0.5
        surface.DrawCircle(x2 + w_cone / 2, y2 + w_cone / 2, acc_size - 1, 0, 0, 0, a * 200)
        surface.DrawCircle(x2 + w_cone / 2, y2 + w_cone / 2, acc_size + 1, 0, 0, 0, a * 200)

        local fov_mult = LocalPlayer():GetFOV() / math.max(self.TacRPLastFOV or 90, 0.00001)
        local fov_mult1 = math.floor(fov_mult)
        local fov_mult2 = math.Round(fov_mult - math.floor(fov_mult), 1) * 10
        if fov_mult2 == 10 then fov_mult1 = fov_mult1 + 1 fov_mult2 = 0 end

        surface.SetFont("TacRP_HD44780A00_5x8_6")
        surface.SetTextColor(0, 0, 0)
        surface.SetTextPos(x2 + ScreenScale(17), y2 + ScreenScale(2))
        surface.DrawText(fov_mult1 .. "." .. fov_mult2 .. "x")
        local sway_txt = math.Clamp(math.Round(self:GetSwayAmount() * 100), 0, 999) .. "%"
        local sway_w = surface.GetTextSize(sway_txt)
        surface.SetTextPos(x2 + ScreenScale(23) - sway_w, y2 + w_cone - ScreenScale(8.5))
        surface.DrawText(sway_txt)
    end

    self:DrawCustomizeHUD()

    if !self:GetCustomize() and GetConVar("tacrp_drawhud"):GetBool() then
        local w = ScreenScale(110)
        local h = ScreenScale(40)
        local x = ScrW() - w - ScreenScale(8)
        local y = ScrH() - h - ScreenScale(8)

        local col = Color(255, 255, 255)
        local col_hi = Color(255, 150, 0)

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

        if self:GetValue("Ammo") == "" then
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

            local qty = "INF"

            if nade.Ammo then
                qty = tostring(self:GetOwner():GetAmmoCount(nade.Ammo))
            end

            local sg = ScreenScale(14)

            if nade.Icon then
                surface.SetMaterial(nade.Icon)
                surface.SetDrawColor(255, 255, 255)
                surface.DrawTexturedRect(x + ScreenScale(2), y + h - sg - ScreenScale(1), sg, sg)
            end

            local nadetext = nade.PrintName .. "x" .. qty
            surface.SetTextPos(x + ScreenScale(4) + sg, y + h - sg + ScreenScale(1))
            surface.SetFont("TacRP_HD44780A00_5x8_8")
            surface.SetTextColor(col)
            surface.DrawText(nadetext)

            local nextnade = self:GetNextGrenade()

            local nsg = ScreenScale(10)

            if nextnade.Icon then
                surface.SetMaterial(nextnade.Icon)
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
    end

    lastammo = self:Clip1()
    lastarmor = LocalPlayer():Armor()

    if !self:GetReloading() and !self:GetCustomize() and GetConVar("developer"):GetInt() > 0 and LocalPlayer():IsAdmin() then
        local tr = util.TraceLine({
            start = self:GetMuzzleOrigin(),
            endpos = self:GetMuzzleOrigin() + (self:GetShootDir():Forward() * 50000),
            mask = MASK_SHOT,
            filter = self:GetOwner()
        })
        cam.Start3D()
            local w2s = tr.HitPos:ToScreen()
            w2s.x = math.Round(w2s.x)
            w2s.y = math.Round(w2s.y)
        cam.End3D()
        if self:StillWaiting() then
            surface.SetDrawColor(150, 150, 150, 255)
        else
            surface.SetDrawColor(255, 50, 50, 255)
        end
        surface.DrawLine(w2s.x, w2s.y - 256, w2s.x, w2s.y + 256)
        surface.DrawLine(w2s.x - 256, w2s.y, w2s.x + 256, w2s.y)
        local spread = GetFOVAcc(self)
        local recoil_txt = "Recoil: " .. tostring(math.Round(self:GetRecoilAmount() or 0, 3))
        surface.DrawCircle(w2s.x, w2s.y, spread, 255, 255, 255, 150)
        surface.DrawCircle(w2s.x, w2s.y, spread + 1, 255, 255, 255, 150)
        surface.SetFont("TacRP_Myriad_Pro_32_Unscaled")
        surface.SetTextColor(255, 255, 255, 255)
        surface.SetTextPos(w2s.x - 256, w2s.y)
        surface.DrawText(recoil_txt)
        local spread_txt = tostring("Cone: " .. math.Round(self:GetSpread(), 5))
        surface.SetTextPos(w2s.x - 256, w2s.y - 34)
        surface.DrawText(spread_txt)
        -- local tw = surface.GetTextSize(spread_txt)
        -- surface.SetTextPos(w2s.x + 256 - tw, w2s.y)
        -- surface.DrawText(spread_txt)


        local dist = (tr.HitPos - tr.StartPos):Length()
        local dist_txt = math.Round(dist) .. " HU"
        local tw = surface.GetTextSize(dist_txt)
        surface.SetTextPos(w2s.x + 256 - tw, w2s.y)
        surface.DrawText(dist_txt)

        local damage_txt = math.Round(self:GetDamageAtRange(dist)) .. " DMG"
        local tw2 = surface.GetTextSize(damage_txt)
        surface.SetTextPos(w2s.x + 256 - tw2, w2s.y - 34)
        surface.DrawText(damage_txt)
    end
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
    return tostring(math.Round(range)) .. " HU"
end