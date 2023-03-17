TacRP.Version = "DEV"

TacRP.News = {
    --[[]
    {
        Title = "New Article",
        Type = "Update",
        Date = "2023-03-16", -- yyyy-mm-dd
        Major = true, -- if unread, brings up page on startup
        Summary = nil, -- text shown in the side tab
        Hyperlink = nil, -- if set, loads the specified webpage instead of Contents.
        Contents = "", -- main text, uses HTML
    },
    ]]
    {
        Title = "HTML test",
        Type = "Update",
        Date = "2023-03-16", -- yyyy-mm-dd
        Major = false, -- if unread, brings up page on startup
        Summary = nil, -- text shown in the side tab
        Hyperlink = "https://theonly8z.github.io/tacrp_pages/test", -- if set, loads the specified webpage instead of Contents.
        Contents = "", -- main text, uses HTML
    },
    {
        Title = "New Newsletter System!",
        Type = "Post",
        Date = "2023-03-17",
        Major = true,
        Summary = nil,
        Contents = [[<body style="font-family:'Myriad Pro';color:white;font-size:125%;">
<p>Thank you for using Tactical RP, and welcome to our new newsletter!<br>
<span style="font-size:80%;">(If you forgot you had TacRP installed, we're sorry for distrubing your gmod session, please don't unsubscribe 🥺)</span></p>

<p>You can now catch up with updates, dev blogs, and more, all from the comfort of your own video game! Major updates and releases (like this one) will be displayed on startup, while minor posts will bring up a reminder in the chat box.<br>If you only wish to be notified of major updates, toggle the checkbox above.</p>

<p>Despite the cold reception TacRP got at launch, some of you stuck with us (or at least tolerated its presence in the weapons tab), and we cannot thank you enough for your support.</p>

<p>That's why we here at <b>Garry's Mod Tactical Realism Industries™</b><i style="font-size:50%;">(trademark pending)</i> are cooking up more good stuff for you to enjoy, including an <i>expansion pack full of new weapons</i>.</p>

<p>Here's a little sneak peak of what will come in the future:</p>

<p style="text-align:center;">
<img width="80%" src="asset://garrysmod/materials/tacrp/news/preview1.jpg"><br>
<img width="80%" src="asset://garrysmod/materials/tacrp/news/preview2.jpg"><br>
<img width="80%" src="asset://garrysmod/materials/tacrp/news/preview3.jpg"><br>
</p>

<p>If you want to keep up with development, join the Diamond Doves Discord server here:</p>
<div style="text-align: center;">
<input style="width: 50%;height: 10%;" type='button' value='Join Discord' onclick='console.log("RUNLUA:gui.OpenURL( \"https://discord.gg/gaHXusZ\" )")' />
</div>

<p>In the meantime, we hope you enjoy Tactical RP, and remember:<br>
<i>No matter what Arctic tells you, the RP actually stands for Remix Pack, not Role Play!</i></p>

<p>Yours,<br>
<b>8Z, the gmod hyperealist</b></p>
</body>]]
    },

}
TacRP.NewsRead = {}

function TacRP.SaveReadData()
    local tbl = {}
    for k, v in pairs(TacRP.NewsRead) do
        table.insert(tbl, k)
    end
    file.Write(TacRP.PresetPath .. "tacrp_news.txt", util.TableToJSON(tbl, false))
end

function TacRP.LoadReadData()
    local tbl = util.JSONToTable(file.Read(TacRP.PresetPath .. "tacrp_news.txt", "DATA") or "") or {}
    TacRP.NewsRead = {}
    for _, i in ipairs(tbl) do
        TacRP.NewsRead[i] = true
    end
end

function TacRP.RemoveNewsPanel()
    if TacRP.NewsPanel then
        TacRP.NewsPanel:Close()
        TacRP.NewsPanel = nil
    end
end


local html_head = [[<head>
<style>
@font-face {
    font-family: "Myriad Pro";
    src: url("asset://garrysmod/resource/fonts/myriad pro regular.ttf");
}
</style>
</head>]]
TacRP.NewsPanel = TacRP.NewsPanel or nil
function TacRP.CreateNewsPanel(open)
    TacRP.RemoveNewsPanel()

    local is_workshop = nil
    local last_update = nil
    steamworks.FileInfo(2588031232, function(result)
        is_workshop = tobool(result.installed)
        if is_workshop then
            last_update = os.date("%Y-%m-%d %H:%M", result.updated)
        end
    end)

    local w_news, h_news = ScreenScale(384), ScreenScale(256)

    local h_bottom = ScreenScale(8)
    local h_title = ScreenScale(24)
    local w_list = ScreenScale(96)
    local h_entry = ScreenScale(18)

    TacRP.NewsPanel = vgui.Create("DFrame")
    TacRP.NewsPanel:SetTitle("")
    TacRP.NewsPanel:SetSize(w_news, h_news)
    TacRP.NewsPanel:ShowCloseButton(false)
    TacRP.NewsPanel:MakePopup()
    TacRP.NewsPanel:Center()
    TacRP.NewsPanel:SetDeleteOnClose(true)
    TacRP.NewsPanel:SetDraggable(false)
    function TacRP.NewsPanel.Paint(self, w, h)
    end

    function TacRP.NewsPanel.OnClose()
        TacRP.SaveReadData()
    end

    local close = vgui.Create("DButton", TacRP.NewsPanel)
    close:SetSize(ScreenScale(8), ScreenScale(8))
    close:SetPos(w_news - ScreenScale(10), 0)
    close:SetText("")
    function close.Paint(self, w, h)
        local c_bg, c_cnr, c_txt = TacRP.GetPanelColors(self:IsHovered() and !self:IsDown(), self:IsDown())
        surface.SetDrawColor(c_bg)
        surface.DrawRect(0, 0, w, h)
        TacRP.DrawCorneredBox(0, 0, w, h, c_cnr)
        draw.SimpleText("X", "TacRP_HD44780A00_5x8_4", w / 2, h / 2, c_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    function close.DoClick()
        TacRP.RemoveNewsPanel()
    end

    local cvarbox = vgui.Create("DCheckBox", TacRP.NewsPanel)
    cvarbox:SetSize(ScreenScale(8), ScreenScale(8))
    cvarbox:SetPos(ScreenScale(2), 0)
    cvarbox:SetText("")
    cvarbox:SetConVar("tacrp_news_majoronly")
    function cvarbox.Paint(self, w, h)
        local c_bg, c_cnr, c_txt = TacRP.GetPanelColors(self:IsHovered(), self:GetChecked())
        surface.SetDrawColor(c_bg)
        surface.DrawRect(0, 0, w, h)
        TacRP.DrawCorneredBox(0, 0, w, h, c_cnr)
        if self:GetChecked() then
            draw.SimpleText("O", "TacRP_HD44780A00_5x8_4", w / 2, h / 2, c_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
    local cvartext = vgui.Create("DLabel", TacRP.NewsPanel)
    cvartext:SetFont("TacRP_Myriad_Pro_8")
    cvartext:SetPos(ScreenScale(12), 0)
    cvartext:SetText("Only notify major news/updates in the future")
    cvartext:SetColor(color_white)
    cvartext:SizeToContents()

    local title = vgui.Create("DPanel", TacRP.NewsPanel)
    title:SetSize(w_news, h_title)
    title:Dock(TOP)
    function title.Paint(self, w, h)
        local c_bg = TacRP.GetPanelColor("bg2")
        surface.SetDrawColor(c_bg)
        surface.DrawRect(0, 0, w, h)
        TacRP.DrawCorneredBox(0, 0, w, h)
        draw.SimpleText("Tactical RP Newsletter", "TacRP_Myriad_Pro_20", w / 2, ScreenScale(2), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end

    local bottom = vgui.Create("DPanel", TacRP.NewsPanel)
    bottom:SetSize(w_news, h_bottom)
    bottom:Dock(BOTTOM)
    function bottom.Paint(self, w, h)
        local c_bg = TacRP.GetPanelColor("bg2")
        surface.SetDrawColor(c_bg)
        surface.DrawRect(0, 0, w, h)
        TacRP.DrawCorneredBox(0, 0, w, h)

        local text
        if is_workshop == true then
            text = "Workshop Version: Last Updated " .. last_update
        elseif is_workshop == false then
            text = "GitHub Version: " .. tostring(TacRP.Version)
        end

        if text then
            draw.SimpleText(text, "TacRP_Myriad_Pro_6", ScreenScale(4), h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        draw.SimpleText("GMod Branch: " .. tostring(BRANCH), "TacRP_Myriad_Pro_6", w - ScreenScale(4), h / 2, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    end

    local newspanel = vgui.Create("DScrollPanel", TacRP.NewsPanel)
    newspanel:SetSize(w_list, h_news - h_title)
    newspanel:DockMargin(0, ScreenScale(2), 0, ScreenScale(2))
    newspanel:Dock(LEFT)
    function newspanel.Paint(self, w, h)
        local c_bg = TacRP.GetPanelColor("bg")
        surface.SetDrawColor(c_bg)
        surface.DrawRect(0, 0, w, h)
    end
    local sbar = newspanel:GetVBar()
    function sbar:Paint(w, h)
    end
    function sbar.btnUp:Paint(w, h)
        local c_bg, c_txt = TacRP.GetPanelColor("bg2", self:IsHovered()), TacRP.GetPanelColor("text", self:IsHovered())
        surface.SetDrawColor(c_bg)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("↑", "TacRP_HD44780A00_5x8_4", w / 2, h / 2, c_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    function sbar.btnDown:Paint(w, h)
        local c_bg, c_txt = TacRP.GetPanelColor("bg2", self:IsHovered()), TacRP.GetPanelColor("text", self:IsHovered())        surface.SetDrawColor(c_bg)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("↓", "TacRP_HD44780A00_5x8_4", w / 2, h / 2, c_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    function sbar.btnGrip:Paint(w, h)
        local c_bg, c_cnr = TacRP.GetPanelColor("bg2", self:IsHovered()), TacRP.GetPanelColor("corner", self:IsHovered())        surface.SetDrawColor(c_bg)
        TacRP.DrawCorneredBox(0, 0, w, h, c_cnr)
    end

    local newslist = vgui.Create("DIconLayout", newspanel)
    newslist:Dock(FILL)
    newslist:SetLayoutDir(TOP)
    newslist:SetSpaceY(ScreenScale(2))

    local buttons = {}
    for i, v in SortedPairs(TacRP.News, true) do
        local data = TacRP.News[i]
        local btn = newslist:Add("DButton")
        if data.Summary then
            btn.TextLines = TacRP.MultiLineText(data.Summary, w_list - ScreenScale(4), "TacRP_Myriad_Pro_6")
            btn:SetSize(w_list, h_entry + #btn.TextLines * ScreenScale(6.5))
        else
            btn:SetSize(w_list, h_entry)
        end
        btn:SetText("")
        btn.Index = i
        function btn.DoClick(self)
            TacRP.NewsPanel.Page:SetPageIndex(self.Index)
        end
        function btn.Paint(self2, w, h)
            local down = btn.Index == TacRP.NewsPanel.Index
            local c_bg, c_cnr, c_txt = TacRP.GetPanelColors(self2:IsHovered() and !down, down)
            surface.SetDrawColor(c_bg)
            surface.DrawRect(0, 0, w, h)
            TacRP.DrawCorneredBox(0, 0, w, h, c_cnr)

            if !TacRP.NewsRead[i] then
                local c_glow = TacRP.GetPanelColor("text_glow", self2:IsHovered() and !down, down)
                draw.SimpleText(data.Title, "TacRP_Myriad_Pro_8_Glow", ScreenScale(2), ScreenScale(2), c_glow, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            end
            draw.SimpleText(data.Title, "TacRP_Myriad_Pro_8", ScreenScale(2), ScreenScale(2), c_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.SimpleText(data.Date or "Unknown Date", "TacRP_Myriad_Pro_6", w - ScreenScale(2), ScreenScale(9.5), c_txt, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
            draw.SimpleText((data.Type or "Article") .. (data.Hyperlink and " (Web)" or ""), "TacRP_Myriad_Pro_6", ScreenScale(2), ScreenScale(9.5), c_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

            if btn.TextLines then
                for j, text in ipairs(btn.TextLines) do
                    draw.SimpleText(text, "TacRP_Myriad_Pro_6", ScreenScale(2), ScreenScale(16) + (j - 1) * ScreenScale(6.5), c_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                end
            end
        end

        buttons[i] = btn
    end

    local pagescroll = vgui.Create("DScrollPanel", TacRP.NewsPanel)
    pagescroll:Dock(FILL)
    pagescroll:DockMargin(ScreenScale(2), ScreenScale(2), 0, ScreenScale(2))
    pagescroll:InvalidateParent(true)
    function pagescroll.Paint(self, w, h)
        local c_bg = TacRP.GetPanelColor("bg")
        surface.SetDrawColor(c_bg)
        surface.DrawRect(0, 0, w, h)
    end
    local sbar2 = pagescroll:GetVBar()
    function sbar2:Paint(w, h)
    end
    function sbar2.btnUp.Paint(self2, w, h)
        local c_bg, c_txt = TacRP.GetPanelColor("bg2", self2:IsHovered()), TacRP.GetPanelColor("text", self2:IsHovered())
        surface.SetDrawColor(c_bg)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("↑", "TacRP_HD44780A00_5x8_4", w / 2, h / 2, c_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    function sbar2.btnDown.Paint(self2, w, h)
        local c_bg, c_txt = TacRP.GetPanelColor("bg2", self2:IsHovered()), TacRP.GetPanelColor("text", self2:IsHovered())        surface.SetDrawColor(c_bg)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("↓", "TacRP_HD44780A00_5x8_4", w / 2, h / 2, c_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    function sbar2.btnGrip.Paint(self2, w, h)
        local c_bg, c_cnr = TacRP.GetPanelColor("bg2", self2:IsHovered()), TacRP.GetPanelColor("corner", self2:IsHovered())        surface.SetDrawColor(c_bg)
        TacRP.DrawCorneredBox(0, 0, w, h, c_cnr)
    end

    local page = pagescroll:Add("DPanel")
    page:Dock(TOP)
    page:SetSize(w_news - w_list - ScreenScale(2), h_news - h_title - h_bottom - ScreenScale(16))

    function page:SetPageIndex(i)

        if !TacRP.NewsRead[i] then
            timer.Remove("tacrp_news")
            timer.Create("tacrp_news", 1.5, 1, function()
                if TacRP.NewsPanel and TacRP.NewsPanel.Index == i then
                    TacRP.NewsRead[i] = true
                end
            end)
        end

        self:Clear()
        TacRP.NewsPanel.Index = i
        local data = TacRP.News[TacRP.NewsPanel.Index or -1]

        if data.Hyperlink then
            self:SetSize(w_news - w_list - ScreenScale(2), h_news - h_title - h_bottom - ScreenScale(16))

            local topbar = vgui.Create("DPanel", self)
            topbar:Dock(TOP)
            topbar:SetTall(ScreenScale(8))
            function topbar.Paint(self2, w, h)
            end

            local homebutton = vgui.Create("DButton", topbar)
            homebutton:SetText("")
            homebutton:Dock(LEFT)
            homebutton:SetSize(ScreenScale(16), ScreenScale(8))
            homebutton:DockMargin(ScreenScale(2), 0, ScreenScale(2), 0)
            homebutton:SetMouseInputEnabled(true)
            function homebutton.Paint(self2, w, h)
                local hover = self2:IsHovered()
                local c_bg, c_txt = TacRP.GetPanelColor("bg", hover), TacRP.GetPanelColor("text", hover)
                surface.SetDrawColor(c_bg)
                surface.DrawRect(0, 0, w, h)
                TacRP.DrawCorneredBox(0, 0, w, h, TacRP.GetPanelColor("corner", hover))
                draw.SimpleText("HOME", "TacRP_HD44780A00_5x8_4", w / 2, h / 2, c_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
            function homebutton.DoClick(self2)
                homebutton.Page:OpenURL(data.Hyperlink)
            end

            local linkbutton = vgui.Create("DButton", topbar)
            linkbutton:SetText("")
            linkbutton:Dock(FILL)
            linkbutton:SetMouseInputEnabled(true)
            linkbutton.Hyperlink = data.Hyperlink
            function linkbutton.Paint(self2, w, h)
                surface.SetDrawColor(255, 255, 255, 255)
                surface.DrawRect(0, 0, w, h)
                TacRP.DrawCorneredBox(0, 0, w, h, Color(0, 0, 0, 255))
                local c = Color(50, 50, 255)
                if self2:IsHovered() then
                    c = Color(100, 100, 255)
                end
                draw.SimpleText(self2.Hyperlink, "TacRP_Myriad_Pro_6", w / 2, h / 2, c, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

                DisableClipping(true)
                draw.SimpleText("If the page does not load, click the link at the top to open externally.", "TacRP_Myriad_Pro_8", w / 2, h + ScreenScale(96), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                DisableClipping(false)
            end
            function linkbutton.DoClick(self2)
                gui.OpenURL(self2.Hyperlink)
            end

            local html = vgui.Create("DHTML", self)
            html:Dock(FILL)
            html:OpenURL(data.Hyperlink)
            function html.OnBeginLoadingDocument(self2, url)
                linkbutton.Hyperlink = url
            end
            homebutton.Page = html
        else

            local c_txt = TacRP.GetPanelColor("text")

            local page_title = vgui.Create("DLabel", self)
            page_title:SetFont("TacRP_Myriad_Pro_20")
            page_title:SetTextColor(c_txt)
            page_title:SetText(data.Title)
            page_title:SizeToContents()
            page_title:DockMargin(ScreenScale(4), ScreenScale(2), 0, 0)
            page_title:Dock(TOP)

            local page_subtitle = vgui.Create("DPanel", self)
            page_subtitle:DockMargin(ScreenScale(4), 0, ScreenScale(4), ScreenScale(2))
            page_subtitle:Dock(TOP)
            page_subtitle:SetTall(ScreenScale(14))
            page_subtitle.Paint = function(self2, w, h)
                surface.SetDrawColor(255, 255, 255, 255)
                surface.DrawLine(0, h - 1, w, h - 1)
            end

            local page_type = vgui.Create("DLabel", page_subtitle)
            page_type:SetFont("TacRP_Myriad_Pro_12")
            page_type:SetTextColor(c_txt)
            page_type:SetText(data.Type or "Article")
            page_type:SizeToContents()
            page_type:Dock(LEFT)

            local page_date = vgui.Create("DLabel", page_subtitle)
            page_date:SetFont("TacRP_Myriad_Pro_12")
            page_date:SetTextColor(c_txt)
            page_date:SetText(data.Date or "Unknown Date")
            page_date:SizeToContents()
            page_date:Dock(RIGHT)

            local html = vgui.Create("DHTML", self)
            html:Dock(FILL)
            html:SetHTML(html_head .. "\n" .. data.Contents)
            html:SetAllowLua(true)

            --[[]
            if data.ContentsIsHTML then
                local html = vgui.Create("DHTML", self)
                html:Dock(FILL)
                html:SetHTML(html_head .. "\n" .. data.Contents)
                html:SetAllowLua(true)
            else
                local font = "TacRP_Myriad_Pro_8"
                self.TextLines = TacRP.MultiLineText(data.Contents, self:GetWide() - ScreenScale(14), font)
                for j, text in ipairs(self.TextLines) do
                    if string.match(text, pattern_img) then
                        local img = vgui.Create("DImage", self)
                        img:SetMaterial(Material(string.match(text, pattern_img), "smooth"))
                        -- img:SizeToContents()
                        img:Dock(TOP)
                        img:DockMargin(ScreenScale(4), ScreenScale(4), ScreenScale(4), ScreenScale(4))

                        local mat = img:GetMaterial()
                        local ratio = mat:Height() / mat:Width()
                        if mat:Width() > self:GetWide() then
                            img:SetSize(self:GetWide(), self:GetWide() * ratio)
                        end
                    else
                        local line = vgui.Create("DLabel", self)
                        line:Dock(TOP)
                        line:SetFont(font)
                        line:SetTextColor(c_txt)
                        line:SetText(text)
                        line:SetTextInset(ScreenScale(4), 0)
                        line:SetAutoStretchVertical(true)
                        line:SetWrap(false)
                    end
                end
            end
            local page_padding = vgui.Create("DPanel", self)
            page_padding:DockMargin(ScreenScale(4), 0, ScreenScale(4), 0)
            page_padding:Dock(TOP)
            page_padding:SetTall(ScreenScale(4))
            page_padding.Paint = function() end
            ]]
        end

        self:InvalidateLayout(true)

        self:SizeToChildren(false, true)
    end

    function page:Paint(w, h)

        local data = TacRP.News[TacRP.NewsPanel.Index or -1]
        if data and data.Hyperlink then return end

        local c_bg = TacRP.GetPanelColor("bg2")
        surface.SetDrawColor(c_bg)
        surface.DrawRect(0, 0, w, h)
        TacRP.DrawCorneredBox(0, 0, w, h)
    end

    TacRP.NewsPanel.Page = page
    buttons[isnumber(open) and open or #TacRP.News]:DoClick()
end

concommand.Add("tacrp_news", TacRP.CreateNewsPanel)

concommand.Add("tacrp_news_clearread", function()
    file.Delete(TacRP.PresetPath .. "tacrp_news.txt")
    TacRP.NewsRead = {}
end)

local function notifynews()
    local ind, major
    for i, v in ipairs(TacRP.News) do
        if !TacRP.NewsRead[i] and (!ind or !major) then
            ind = i
            major = v.Major
        end
        if major then break end
    end

    if ind then
        if major and !GetConVar("tacrp_news_majoronly"):GetBool() then
            TacRP.CreateNewsPanel(ind)
        elseif major or !GetConVar("tacrp_news_majoronly"):GetBool() then
            chat.AddText(color_white, "------------- Tactical RP -------------")
            chat.AddText(color_white, "A new " .. string.lower(TacRP.News[ind].Type or "article") .. " was released!")
            chat.AddText(color_white, "Use command 'tacrp_news' or type '/tacrp_news' to view it and suppress this message.")
            chat.AddText(color_white, "---------------------------------------")
        end
    end
end

hook.Add("InitPostEntity", "tacrp_news", function()
    TacRP.LoadReadData()

    timer.Simple(5, function()
        notifynews()
    end)
end)
notifynews()

hook.Add("OnPlayerChat", "tacrp_news", function(ply, txt)
    if ply == LocalPlayer() and string.lower(txt) == "/tacrp_news" then
        TacRP.CreateNewsPanel()
        return true
    end
end)