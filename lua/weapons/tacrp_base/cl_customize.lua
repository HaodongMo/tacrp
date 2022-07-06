-- local customizedelta = 0

local function multlinetext(text, maxw, font)
    local content = {}
    local tline = ""
    local x = 0
    surface.SetFont(font)

    local newlined = string.Split(text, "\n")

    for _, line in pairs(newlined) do
        local words = string.Split(line, " ")

        for _, word in pairs(words) do
            local tx = surface.GetTextSize(word)

            if x + tx >= maxw then
                table.insert(content, tline)
                tline = ""
                x = surface.GetTextSize(word)
            end

            tline = tline .. word .. " "

            x = x + surface.GetTextSize(word .. " ")
        end

        table.insert(content, tline)
        tline = ""
        x = 0
    end

    return content
end

local lastcustomize = false

SWEP.CustomizeHUD = nil

function SWEP:CreateCustomizeHUD()
    self:RemoveCustomizeHUD()

    gui.EnableScreenClicker(true)

    local bg = vgui.Create("DPanel")

    self.CustomizeHUD = bg

    local scrw = ScrW()
    local scrh = ScrH()

    local airgap = ScreenScale(8)
    local smallgap = ScreenScale(4)

    bg:SetPos(0, 0)
    bg:SetSize(ScrW(), ScrH())
    bg.OnRemove = function(self2)
        if !IsValid(self) then return end
        self:SavePreset()
    end
    bg.Paint = function(self2, w, h)
        if !IsValid(self) then
            self2:Remove()
            gui.EnableScreenClicker(false)
        end

        local name_txt = self:GetValue("PrintName")

        surface.SetFont("TacRP_Myriad_Pro_32")
        local name_w = surface.GetTextSize(name_txt)

        surface.SetDrawColor(0, 0, 0, 150)
        surface.DrawRect(w - name_w - ScreenScale(20), airgap, name_w + ScreenScale(12), ScreenScale(34))
        TacRP.DrawCorneredBox(w - name_w - ScreenScale(20), airgap, name_w + ScreenScale(12), ScreenScale(34))

        surface.SetTextPos(w - name_w - ScreenScale(14), airgap)
        surface.SetTextColor(255, 255, 255)
        surface.DrawText(name_txt)
    end

    local stack = airgap + ScreenScale(34)

    if !self:GetValue("NoRanger") then
        local ranger = vgui.Create("DPanel", bg)
        ranger:SetPos(scrw - ScreenScale(128) - airgap, stack + smallgap)
        ranger:SetSize(ScreenScale(128), ScreenScale(64))
        stack = stack + ScreenScale(64) + smallgap
        ranger.Paint = function(self2, w, h)
            surface.SetDrawColor(0, 0, 0, 150)
            surface.DrawRect(0, 0, w, h)
            TacRP.DrawCorneredBox(0, 0, w, h)

            local dmg_max = self:GetValue("Damage_Max")
            local dmg_min = self:GetValue("Damage_Min")

            local range_min = self:GetValue("Range_Min")
            local range_max = self:GetValue("Range_Max")

            surface.SetDrawColor(255, 255, 255, 50)

            local range_1_y = 2 * (h / 5)
            local range_2_y = 4 * (h / 5)

            local range_1_x = 0
            local range_2_x = (w / 3)
            local range_3_x = 2 * (w / 3)

            if dmg_max < dmg_min then
                range_1_y = 4 * (h / 5)
                range_2_y = 2 * (h / 5)
            elseif dmg_max == dmg_min then
                range_1_y = 3 * (h / 5)
                range_2_y = 3 * (h / 5)
            end

            if range_min == 0 then
                range_2_x = 0
                range_3_x = w / 2
            end

            surface.DrawLine(range_2_x, 0, range_2_x, h)
            surface.DrawLine(range_3_x, 0, range_3_x, h)

            surface.SetDrawColor(255, 255, 255)

            for i = 0, 1 do
                surface.DrawLine(range_1_x, range_1_y + i, range_2_x, range_1_y + i)
                surface.DrawLine(range_2_x, range_1_y + i, range_3_x, range_2_y + i)
                surface.DrawLine(range_3_x, range_2_y + i, w, range_2_y + i)
            end

            local mouse_x, mouse_y = input.GetCursorPos()
            mouse_x, mouse_y = self2:ScreenToLocal(mouse_x, mouse_y)

            local draw_rangetext = true

            if mouse_x > 0 and mouse_x < w then
                if mouse_y > 0 and mouse_y < h then
                    local range = 0

                    local range_m_x = 0

                    if mouse_x < range_2_x then
                        range = range_min
                        range_m_x = range_2_x
                    elseif mouse_x > range_3_x then
                        range = range_max
                        range_m_x = range_3_x
                    else
                        local d = (mouse_x - range_2_x) / (range_3_x - range_2_x)
                        range = Lerp(d, range_min, range_max)
                        range_m_x = mouse_x
                    end

                    local dmg = self:GetDamageAtRange(range)

                    local txt_dmg1 = tostring(math.Round(dmg)) .. " DMG"

                    if self:GetValue("Num") > 1 then
                        txt_dmg1 = math.Round(dmg * self:GetValue("Num")) .. "-" .. txt_dmg1
                    end

                    surface.SetDrawColor(255, 255, 255, 255)
                    surface.DrawLine(range_m_x, 0, range_m_x, h)

                    surface.SetFont("TacRP_Myriad_Pro_8")
                    surface.SetTextColor(255, 255, 255)
                    local txt_dmg1_w = surface.GetTextSize(txt_dmg1)
                    surface.SetTextPos((w / 3) - txt_dmg1_w - (ScreenScale(2)), ScreenScale(1))
                    surface.DrawText(txt_dmg1)

                    local txt_range1 = self:RangeUnitize(range)

                    surface.SetFont("TacRP_Myriad_Pro_8")
                    surface.SetTextColor(255, 255, 255)
                    local txt_range1_w = surface.GetTextSize(txt_range1)
                    surface.SetTextPos((w / 3) - txt_range1_w - (ScreenScale(2)), ScreenScale(1 + 8))
                    surface.DrawText(txt_range1)

                    draw_rangetext = false
                end
            end


            if draw_rangetext then
                local txt_dmg1 = tostring(math.Round(dmg_max)) .. " DMG"

                if self:GetValue("Num") > 1 then
                    txt_dmg1 = math.Round(dmg_max * self:GetValue("Num")) .. "-" .. txt_dmg1
                end

                surface.SetFont("TacRP_Myriad_Pro_8")
                surface.SetTextColor(255, 255, 255)
                local txt_dmg1_w = surface.GetTextSize(txt_dmg1)
                surface.SetTextPos((w / 3) - txt_dmg1_w - (ScreenScale(2)), ScreenScale(1))
                surface.DrawText(txt_dmg1)

                local txt_range1 = self:RangeUnitize(range_min)

                surface.SetFont("TacRP_Myriad_Pro_8")
                surface.SetTextColor(255, 255, 255)
                local txt_range1_w = surface.GetTextSize(txt_range1)
                surface.SetTextPos((w / 3) - txt_range1_w - (ScreenScale(2)), ScreenScale(1 + 8))
                surface.DrawText(txt_range1)

                local txt_dmg2 = tostring(math.Round(dmg_min)) .. " DMG"

                if self:GetValue("Num") > 1 then
                    txt_dmg2 = math.Round(dmg_min * self:GetValue("Num")) .. "-" .. txt_dmg2
                end

                surface.SetFont("TacRP_Myriad_Pro_8")
                surface.SetTextColor(255, 255, 255)
                surface.SetTextPos(2 * (w / 3) + (ScreenScale(2)), ScreenScale(1))
                surface.DrawText(txt_dmg2)

                local txt_range2 = self:RangeUnitize(range_max)

                surface.SetFont("TacRP_Myriad_Pro_8")
                surface.SetTextColor(255, 255, 255)
                surface.SetTextPos(2 * (w / 3) + (ScreenScale(2)), ScreenScale(1 + 8))
                surface.DrawText(txt_range2)
            end
        end
    end

    local desc_box = vgui.Create("DPanel", bg)
    desc_box:SetSize(ScreenScale(172), ScreenScale(48))
    desc_box:SetPos(scrw - ScreenScale(172) - airgap, stack + smallgap)
    stack = stack + ScreenScale(48) + smallgap
    desc_box.Paint = function(self2, w, h)
        surface.SetDrawColor(0, 0, 0, 150)
        surface.DrawRect(0, 0, w, h)
        TacRP.DrawCorneredBox(0, 0, w, h)

        surface.SetFont("TacRP_Myriad_Pro_8")
        surface.SetTextColor(255, 255, 255)
        surface.SetTextPos(ScreenScale(6), ScreenScale(4))
        surface.DrawText("DESCRIPTION:")

        local txt = multlinetext(self:GetValue("Description"), w - ScreenScale(6 * 2), "TacRP_Myriad_Pro_8")

        for i, k in pairs(txt) do
            surface.SetFont("TacRP_Myriad_Pro_8")
            surface.SetTextColor(255, 255, 255)
            surface.SetTextPos(ScreenScale(4), ScreenScale(4 + 8 + 1) + (ScreenScale(8 * (i - 1))))
            surface.DrawText(k)
        end
    end

    local stats = {
        -- {
        --     Name = "",
        --     Value = "",
        --     LowerIsBetter = false,
        --     AggregateFunction = nil,
        --     Unit = ""
        -- }
        {
            Name = "Spread",
            Value = "Spread",
            LowerIsBetter = true,
        },
        {
            Name = "RPM",
            Value = "RPM"
        },
        {
            Name = "Penetration",
            Value = "Penetration",
            Unit = "\""
        },
        {
            Name = "Sprint To Fire",
            Value = "SprintToFireTime",
            Unit = "s",
            LowerIsBetter = true,
        },
        {
            Name = "Aim Down Sights",
            Value = "AimDownSightsTime",
            Unit = "s",
            LowerIsBetter = true,
        },
        {
            Name = "Reload Time",
            AggregateFunction = function(base)
                return self:GetReloadTime(base)
            end,
            Value = "ReloadTimeMult",
            LowerIsBetter = true,
            Unit = "s"
        },
        {
            Name = "Deploy Time",
            AggregateFunction = function(base)
                return self:GetDeployTime(base)
            end,
            Value = "DeployTimeMult",
            LowerIsBetter = true,
            Unit = "s"
        },
        {
            Name = "Muzzle Velocity",
            AggregateFunction = function(base)
                return self:GetMuzzleVelocity(base)
            end,
            Value = "MuzzleVelocity",
            LowerIsBetter = false,
            Unit = "m/s"
        },
        {
            Name = "Mag Size",
            Value = "ClipSize",
        },
        {
            Name = "Recoil",
            Value = "RecoilKick",
            LowerIsBetter = true,
        },
        {
            Name = "Recoil Time",
            Value = "RecoilResetTime",
            LowerIsBetter = true,
        },
        {
            Name = "1st Shot Recoil",
            Value = "RecoilFirstShotMult",
            LowerIsBetter = true,
        },
        {
            Name = "Recoil Spread",
            Value = "RecoilSpreadPenalty",
            LowerIsBetter = true,
        },
        {
            Name = "Mid-Air Spread",
            Value = "MidAirSpreadPenalty",
            LowerIsBetter = true,
        },
        {
            Name = "Hip Fire Spread",
            Value = "HipFireSpreadPenalty",
            LowerIsBetter = true,
        },
        {
            Name = "Move Speed",
            Value = "MoveSpeedMult"
        },
        {
            Name = "Shooting Speed",
            Value = "ShootingSpeedMult"
        },
        {
            Name = "Sighted Speed",
            Value = "SightedSpeedMult"
        },
        {
            Name = "Melee Damage",
            Value = "MeleeDamage"
        },
    }

    if !self:GetValue("NoStatBox") then

        local selftbl = self:GetTable()

        local stat_box = vgui.Create("DPanel", bg)
        stat_box:SetSize(ScreenScale(128), ScreenScale(184))
        stat_box:SetPos(scrw - ScreenScale(128) - airgap, stack + smallgap)
        stat_box.Paint = function(self2, w, h)
            surface.SetDrawColor(0, 0, 0, 150)
            surface.DrawRect(0, 0, w, h)
            TacRP.DrawCorneredBox(0, 0, w, h)

            local x_1 = w - ScreenScale(64)
            local x_2 = w - ScreenScale(32)

            surface.SetDrawColor(255, 255, 255, 100)
            surface.DrawLine(x_1, 0, x_1, h)
            surface.DrawLine(x_2, 0, x_2, h)
            surface.DrawLine(0, ScreenScale(2 + 8 + 1), w, ScreenScale(2 + 8 + 1))

            surface.SetFont("TacRP_Myriad_Pro_8")
            surface.SetTextColor(255, 255, 255)
            surface.SetTextPos(x_1 + ScreenScale(4), ScreenScale(2))
            surface.DrawText("BASE")

            surface.SetFont("TacRP_Myriad_Pro_8")
            surface.SetTextColor(255, 255, 255)
            surface.SetTextPos(x_2 + ScreenScale(4), ScreenScale(2))
            surface.DrawText("CURR")

            for i, k in pairs(stats) do
                local i2 = i - 1

                surface.SetFont("TacRP_Myriad_Pro_8")
                surface.SetTextColor(255, 255, 255)
                surface.SetTextPos(ScreenScale(2), ScreenScale(8 + 4 + 1) + (ScreenScale(8 * i2)))
                surface.DrawText(k.Name .. ":")

                local stat_base = 0
                local stat_curr = 0

                if k.AggregateFunction then
                    stat_base = math.Round(k.AggregateFunction(true), 4)
                    stat_curr = math.Round(k.AggregateFunction(false), 4)
                else
                    stat_base = math.Round(selftbl[k.Value], 4)
                    stat_curr = math.Round(self:GetValue(k.Value), 4)
                end

                local txt_base = tostring(stat_base)
                local txt_curr = tostring(stat_curr)

                if isbool(stat_base) then
                    if stat_base then
                        txt_base = "YES"
                    else
                        txt_base = "NO"
                    end

                    if stat_curr then
                        txt_curr = "YES"
                    else
                        txt_curr = "NO"
                    end
                end

                surface.SetTextColor(255, 255, 255)
                surface.SetTextPos(x_1 + ScreenScale(3), ScreenScale(8 + 4 + 1) + (ScreenScale(8 * i2)))
                surface.DrawText(txt_base .. (k.Unit or ""))

                local good = false
                local goodorbad = false

                if stat_base == stat_curr then
                    surface.SetTextColor(255, 255, 255)
                else
                    if isnumber(stat_curr) then
                        if stat_curr > stat_base then
                            good = true
                            goodorbad = true
                        else
                            goodorbad =  true
                        end
                    elseif isbool(stat_curr) then
                        if !stat_base and stat_curr then
                            good = true
                            goodorbad = true
                        else
                            goodorbad =  true
                        end
                    end
                end

                if k.LowerIsBetter then
                    good = !good
                end

                if goodorbad then
                    if good then
                        surface.SetTextColor(175, 255, 175)
                    else
                        surface.SetTextColor(255, 175, 175)
                    end
                end

                surface.SetTextPos(x_2 + ScreenScale(3), ScreenScale(8 + 4 + 1) + (ScreenScale(8 * i2)))
                surface.DrawText(txt_curr .. (k.Unit or ""))
            end
        end
    end

    local attachment_slots = {}

    local offset = (scrh - (ScreenScale(34 + 8) * table.Count(self.Attachments))) / 2

    self.Attachments["BaseClass"] = nil

    for slot, attslot in pairs(self.Attachments) do
        local atts = TacRP.GetAttsForCats(attslot.Category or "")

        attachment_slots[slot] = {}

        local slot_name = vgui.Create("DPanel", bg)
        slot_name:SetPos(airgap, offset + airgap - ScreenScale(8) + ((slot - 1) * ScreenScale(34 + 8)))
        slot_name:SetSize(ScreenScale(128), ScreenScale(8))
        slot_name.Paint = function(self2, w, h)
            local txt = attslot.PrintName or ""

            surface.SetFont("TacRP_Myriad_Pro_8")
            surface.SetTextColor(Color(255, 255, 255))
            surface.SetTextPos(0, 0)
            surface.DrawText(txt)
        end

        table.sort(atts, function(a, b)
            a = a or ""
            b = b or ""

            if a == "" or b == "" then return true end

            local atttbl_a = TacRP.GetAttTable(a)
            local atttbl_b = TacRP.GetAttTable(b)

            local order_a = 0
            local order_b = 0

            order_a = atttbl_a.SortOrder or order_a
            order_b = atttbl_b.SortOrder or order_b

            if order_a == order_b then
                return (atttbl_a.PrintName or "") < (atttbl_b.PrintName or "")
            end

            return order_a < order_b
        end)

        for i, att in pairs(atts) do
            local atttbl = TacRP.GetAttTable(att)

            local slot_panel = vgui.Create("DLabel", bg)
            table.insert(attachment_slots[slot], slot_panel)
            slot_panel:SetText("")
            slot_panel:SetMouseInputEnabled(true)
            slot_panel:SetPos(airgap + ((i - 1) * ScreenScale(34)), offset + airgap + ((slot - 1) * ScreenScale(34 + 8)))
            slot_panel:SetSize(ScreenScale(32), ScreenScale(32))
            slot_panel.DoClick = function(self2)
                if attslot.Installed then
                    if attslot.Installed == att then
                        self:Detach(slot)
                    else
                        self:Detach(slot, true)
                        self:Attach(slot, att)
                    end
                else
                    self:Attach(slot, att)
                end
            end
            slot_panel.DoRightClick = function(self2)
                if attslot.Installed then
                    if attslot.Installed == att then
                        self:Detach(slot)
                    end
                end
            end
            slot_panel.Paint = function(self2, w, h)
                local hover = self2:IsHovered()
                local attached = attslot.Installed == att

                local col_bg = Color(0, 0, 0, 150)
                local col_corner = Color(255, 255, 255)
                local col_text = Color(255, 255, 255)
                local col_image = Color(255, 255, 255)

                local has = TacRP:PlayerGetAtts(self:GetOwner(), att)

                local shownum = !GetConVar("TacRP_lock_atts"):GetBool() and !GetConVar("TacRP_free_atts"):GetBool() and !atttbl.Free

                if attached then
                    col_bg = Color(150, 150, 150, 150)
                    col_corner = Color(50, 50, 255)
                    col_text = Color(0, 0, 0)
                    col_image = Color(200, 200, 200)
                    if hover then
                        col_bg = Color(255, 255, 255)
                        col_corner = Color(150, 150, 255)
                        col_text = Color(0, 0, 0)
                        col_image = Color(255, 255, 255)
                    end
                else
                    if GetConVar("TacRP_free_atts"):GetBool() or has > 0 then
                        if hover then
                            col_bg = Color(255, 255, 255)
                            col_corner = Color(0, 0, 0)
                            col_text = Color(0, 0, 0)
                            col_image = Color(255, 255, 255)
                        end
                    else
                        if hover then
                            col_bg = Color(150, 0, 0)
                            col_corner = Color(25, 0, 0)
                            col_text = Color(0, 0, 0)
                            col_image = Color(255, 100, 100)
                        else
                            col_bg = Color(25, 0, 0)
                            col_corner = Color(255, 0, 0)
                            col_text = Color(255, 50, 50)
                            col_image = Color(200, 25, 25)
                        end
                    end
                end

                surface.SetDrawColor(col_bg)
                surface.DrawRect(0, 0, w, h)
                TacRP.DrawCorneredBox(0, 0, w, h, col_corner)

                surface.SetDrawColor(col_image)
                surface.SetMaterial(atttbl.Icon)
                surface.DrawTexturedRect(0, 0, w, h)

                local txt = atttbl.PrintName

                surface.SetFont("TacRP_Myriad_Pro_6")
                surface.SetTextColor(col_text)
                local t_w = surface.GetTextSize(txt)
                surface.SetTextPos((w - t_w) / 2, h - ScreenScale(6))
                surface.DrawText(txt)

                if shownum then
                    local numtxt = has

                    surface.SetFont("TacRP_Myriad_Pro_6")
                    surface.SetTextColor(col_text)
                    local nt_w = surface.GetTextSize(numtxt)
                    surface.SetTextPos(w - nt_w - ScreenScale(2), ScreenScale(1))
                    surface.DrawText(numtxt)
                end
            end
        end
    end
end

function SWEP:RemoveCustomizeHUD()
    if self.CustomizeHUD then
        self.CustomizeHUD:Remove()

        gui.EnableScreenClicker(false)
    end
end

function SWEP:DrawCustomizeHUD()

    local customize = self:GetCustomize()

    if customize and !lastcustomize then
        self:CreateCustomizeHUD()
    elseif !customize and lastcustomize then
        self:RemoveCustomizeHUD()
    end

    lastcustomize = self:GetCustomize()

    -- if self:GetCustomize() then
    --     customizedelta = math.Approach(customizedelta, 1, FrameTime() * 1 / 0.25)
    -- else
    --     customizedelta = math.Approach(customizedelta, 0, FrameTime() * 1 / 0.25)
    -- end

    -- local curvedcustomizedelta = self:Curve(customizedelta)

    -- if curvedcustomizedelta > 0 then
    --     RunConsoleCommand("pp_bokeh", "1")
    -- else
    --     RunConsoleCommand("pp_bokeh", "0")
    -- end

    -- RunConsoleCommand("pp_bokeh_blur", tostring(curvedcustomizedelta * 5))
    -- RunConsoleCommand("pp_bokeh_distance", 0)
    -- RunConsoleCommand("pp_bokeh_focus", tostring(((1 - curvedcustomizedelta) * 11) + 1))
end