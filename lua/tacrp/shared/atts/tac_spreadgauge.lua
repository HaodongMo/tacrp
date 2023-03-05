ATT.PrintName = "Spread Gauge"
ATT.Icon = Material("entities/tacrp_att_tac_rangefinder.png", "mips smooth")
ATT.Description = "Measures weapon performance over sway and recoil."
ATT.Pros = {"Display recoil, sway and spread", "Spread visualization in sights"}

ATT.Model = "models/weapons/tacint/addons/rangefinder_mounted.mdl"
ATT.Scale = 1

ATT.Category = "tactical"

ATT.SpreadGauge = true
ATT.CanToggle = true


local mat_spread = Material("tacrp/hud/spreadgauge.png", "smooth")
local mat_spread_fire = Material("tacrp/hud/spreadgauge_fire.png", "")
local mat_spread_gauge = Material("tacrp/hud/spreadgauge_gauge.png", "")
local mat_spread_text = Material("tacrp/hud/spreadgauge_text.png", "")
local mat_cone = Material("tacrp/hud/cone.png", "smooth")
local mat_cone_text = Material("tacrp/hud/cone_text.png", "")
function ATT.TacticalDraw(self)
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
    local recoil_txt = tostring(recoil_pct)
    surface.SetTextPos(x + ScreenScale(22), y + ScreenScale(11.5))
    surface.SetTextColor(0, 0, 0)

    if recoil_pct == 0 then
        recoil_txt = "000"
        surface.SetTextColor(0, 0, 0, 100)
    elseif recoil_pct < 10 then
        recoil_txt = "00" .. recoil_txt
    elseif recoil_pct < 100 then
        recoil_txt = "0" .. recoil_txt
    elseif math.sin(SysTime() * 30) > 0 then
        surface.SetTextColor(0, 0, 0, 100)
    end
    surface.DrawText(recoil_txt)

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

    local acc_size = math.max(TacRP.GetFOVAcc(self), 1)
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

local circlealpha = 0
function ATT.TacticalCrosshair(self, x, y, spread, sway)

    if self:IsInScope() and (self:GetValue("ScopeOverlay") or !self:GetReloading()) then
        circlealpha = math.Approach(circlealpha, self:GetSightAmount() ^ 2, FrameTime() * 2)
    else
        circlealpha = math.Approach(circlealpha, 0, FrameTime() * 10)
    end
    if dropalpha == 0 then return end

    surface.DrawCircle(x, y, spread - 1, 255, 255, 255, circlealpha * 100)
    surface.DrawCircle(x, y, spread + 1, 255, 255, 255, circlealpha * 100)
end