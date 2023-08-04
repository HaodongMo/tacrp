ATT.PrintName = "Spread Gauge"
ATT.Icon = Material("entities/tacrp_att_tac_rangefinder.png", "mips smooth")
ATT.Description = "Measures weapon stability from sway and bloom."
ATT.Pros = {"att.procon.gauge1", "att.procon.gauge2"}

ATT.Model = "models/weapons/tacint/addons/rangefinder_mounted.mdl"
ATT.Scale = 1

ATT.Category = "tactical"

ATT.SpreadGauge = true
ATT.CanToggle = true

ATT.TacticalName = "Gauge"

local mat_spread = Material("tacrp/hud/spreadgauge.png", "smooth")
local mat_spread_fire = Material("tacrp/hud/spreadgauge_fire.png", "")
local mat_spread_gauge = Material("tacrp/hud/spreadgauge_gauge.png", "")
local mat_spread_text = Material("tacrp/hud/spreadgauge_text.png", "")
local mat_cone = Material("tacrp/hud/cone.png", "smooth")
local mat_cone_text = Material("tacrp/hud/cone_text.png", "")
function ATT.TacticalDraw(self)
    local scrw = ScrW()
    local scrh = ScrH()

    local w = TacRP.SS(60)
    local h = TacRP.SS(30)

    local x = (scrw - w) / 2
    local y = (scrh - h) * 5.5 / 6

    -- if self:GetSightDelta() > 0 then
    --     y = y - self:GetSightDelta() ^ 0.5 * TacRP.SS(24)
    -- end

    surface.SetMaterial(mat_spread)
    surface.SetDrawColor(255, 255, 255, 100)
    surface.DrawTexturedRect(x, y, w, h)

    local spread = math.Clamp(math.deg(self:GetSpread())*60, 0, 999.9)
    local spread1 = math.floor(spread)
    local spread2 = math.floor((spread - spread1) * 10)
    local spread_txt1 = tostring(spread1)
    surface.SetFont("TacRP_HD44780A00_5x8_6")
    surface.SetTextColor(0, 0, 0)
    surface.SetTextPos(x + TacRP.SS(22), y + TacRP.SS(2.5))
    if spread < 10 then
        surface.SetTextColor(0, 0, 0, 100)
        surface.DrawText("00")
        surface.SetTextColor(0, 0, 0)
    elseif spread < 100 then
        surface.SetTextColor(0, 0, 0, 100)
        surface.DrawText("0")
        surface.SetTextColor(0, 0, 0)
    end
    surface.DrawText(spread_txt1)
    surface.DrawText(".")
    surface.DrawText(spread2)

    local recoil = self:GetRecoilAmount()
    local recoil_pct = math.Round( recoil, 2 )
    local recoil_per = recoil / self:GetValue("RecoilMaximum")
    surface.SetTextPos(x + TacRP.SS(22), y + TacRP.SS(11.5))
    surface.SetTextColor(0, 0, 0)

    if recoil_pct < 10 then
        surface.SetTextColor(0, 0, 0, 100)
        surface.DrawText("0")
        surface.SetTextColor(0, 0, 0)
    elseif recoil_per == 1 and math.sin(SysTime() * 60) > 0 then
        surface.SetTextColor(0, 0, 0, 150)
    end
    surface.DrawText(recoil_pct)
    
    local bleh = math.ceil(recoil_pct) - recoil_pct
    bleh = tostring(bleh)
    if (recoil_per == 1 and math.sin(SysTime() * 60) > 0) then
        surface.SetTextColor(0, 0, 0, 150)
    else
        surface.SetTextColor(0, 0, 0)
    end
    if #bleh == 1 then
        surface.DrawText(".00")
    elseif #bleh == 3 then
        surface.SetTextColor(0, 0, 0)
        surface.DrawText("0")
    end

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

    local w_cone = TacRP.SS(40)
    local x2 = (scrw - w_cone) / 2
    local y2 = y - w_cone - TacRP.SS(4)

    surface.SetMaterial(mat_cone)
    surface.SetDrawColor(255, 255, 255, 100)
    surface.DrawTexturedRect(x2, y2, w_cone, w_cone)
    surface.SetMaterial(mat_cone_text)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawTexturedRect(x2, y2, w_cone, w_cone)

    local acc_size = math.max(TacRP.GetFOVAcc(self), 1)
    local a = math.Clamp(1 - (acc_size - TacRP.SS(15)) / TacRP.SS(5), 0, 1) ^ 0.5
    surface.DrawCircle(x2 + w_cone / 2, y2 + w_cone / 2, acc_size - 1, 0, 0, 0, a * 200)
    surface.DrawCircle(x2 + w_cone / 2, y2 + w_cone / 2, acc_size + 1, 0, 0, 0, a * 200)

    local fov_mult = LocalPlayer():GetFOV() / math.max(self.TacRPLastFOV or 90, 0.00001)
    local fov_mult1 = math.floor(fov_mult)
    local fov_mult2 = math.Round(fov_mult - math.floor(fov_mult), 1) * 10
    if fov_mult2 == 10 then fov_mult1 = fov_mult1 + 1 fov_mult2 = 0 end

    surface.SetFont("TacRP_HD44780A00_5x8_6")
    surface.SetTextColor(0, 0, 0)
    surface.SetTextPos(x2 + TacRP.SS(17), y2 + TacRP.SS(2))
    surface.DrawText(fov_mult1 .. "." .. fov_mult2 .. "x")
    local sway_pct = math.Clamp(math.Round((self:IsSwayEnabled() and self:GetSwayAmount() or self:GetForcedSwayAmount()) * 100), 0, 999)
    local sway_txt = sway_pct .. "%"
    local sway_w = surface.GetTextSize("100%") -- same width per char so its ok
    surface.SetTextPos(x2 + TacRP.SS(23) - sway_w, y2 + w_cone - TacRP.SS(8.5))
    if sway_pct < 10 then
        surface.SetTextColor(0, 0, 0, 100)
        surface.DrawText("00")
        surface.SetTextColor(0, 0, 0)
    elseif sway_pct < 100 then
        surface.SetTextColor(0, 0, 0, 100)
        surface.DrawText("0")
        surface.SetTextColor(0, 0, 0)
    end
    surface.DrawText(sway_txt)
end

local circlealpha = 0
function ATT.TacticalCrosshair(self, x, y, spread, sway)
    if self:IsInScope() and !self:GetReloading() then
        circlealpha = math.Approach(circlealpha, self:GetSightAmount() ^ 2, FrameTime() * 2)
    else
        circlealpha = math.Approach(circlealpha, 0, FrameTime() * 10)
    end
    if circlealpha == 0 then return end

    surface.DrawCircle(x, y, spread - 1, 255, 255, 255, circlealpha * 100)
    surface.DrawCircle(x, y, spread + 1, 255, 255, 255, circlealpha * 100)
end

ATT.TacticalCrosshairTruePos = true