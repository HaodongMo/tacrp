ATT.PrintName = "Rangefinder"
ATT.Icon = Material("entities/tacrp_att_tac_rangefinder.png", "mips smooth")
ATT.Description = "Shows the distance to the point of impact."
ATT.Pros = {"Rangefinder"}

ATT.Model = "models/weapons/tacint/addons/rangefinder_mounted.mdl"
ATT.Scale = 1

ATT.Category = "tactical"

ATT.Rangefinder = true
ATT.CanToggle = true

local lastrangefinder = 0
local rftime = 1 / 10
local mat_rf = Material("tacrp/hud/rangefinder.png", "mips smooth")
function ATT.TacticalDraw(self)
    local txt = "NO RTN"
    local txt2 = ""
    local txt3 = ""
    local txt4 = ""

    if lastrangefinder + rftime < CurTime() then
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

        local mult = self:GetBodyDamageMultipliers() --self:GetValue("BodyDamageMultipliers")
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