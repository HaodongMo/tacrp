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
        Title = "New Newsletter System!",
        Type = "Announcement",
        Date = "2023-03-17",
        Author = "8Z",
        Major = true,
        Summary = nil,
        Contents = [[<body style="font-family:'Myriad Pro';color:white;font-size:125%;">
<p>Thank you for using Tactical RP, and welcome to our new newsletter!<br>
<span style="font-size:80%;"><i>If you forgot you had TacRP installed, we're sorry for distrubing your gmod session, please don't unsubscribe</i> 🥺</span></p>

<p>You can now catch up with updates, dev blogs, and more, all from the comfort of your own video game! A few posts (like this one) are embedded within the addon and will always be available, while others will be fetched remotely so you can get the hottest news without updating the addon.</p>

<p>Major updates and releases will be displayed on startup, while minor posts will bring up a reminder in the chat box. If you want to be only notified for major updates, toggle the checkbox above.</p>

<p>Despite the cold reception TacRP got at launch, some of you stuck with us (or at least tolerated its presence in the weapons tab), and we cannot thank you enough for your support. That's why we here at <b>Garry's Mod Tactical Realism Industries™</b><i style="font-size:50%;">(trademark pending)</i> are cooking up more good stuff for you to enjoy, including an <i>expansion pack full of new weapons</i>.</p>

<p>In the meantime, we hope you enjoy Tactical RP, and remember:<br>
<i>No matter what Arctic might say, the RP in TacRP stands for Remix Pack, not Role Play!</i>
<br><span style="font-size:50%;opacity:0.25;">It is seriously kind of stupid to put roleplay in your weapon pack name. Is there even a DarkRP server out there that uses these guns? Don't they all just use M9K? Why do we even make new weapon packs if a decade-old weapon base with no c_hands is enough for them? Is humanity truly doomed? sussy imposter amogus??? 💀💀💀</span></p>

<p>Yours,<br>
<b>8Z, the gmod hyperealist</b></p>
</body>]]
    },
}
TacRP.NewsRead = {}
TacRP.NewsLoaded = nil
TacRP.NewsResult = "Uninitialized"

function TacRP.SaveReadData()
    local tbl = {}
    for k, v in pairs(TacRP.NewsRead) do
        table.insert(tbl, k)
    end
    file.Write(TacRP.PresetPath .. "tacrp_news.txt", util.TableToJSON(tbl, false))
end

local date_pattern = "(%d+)-(%d+)-(%d+)"
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

local function loadlocalandsort()
    TacRP.NewsLoaded = TacRP.NewsLoaded or {}

    for k, v in pairs(TacRP.News) do
        v.Key = k
        table.insert(TacRP.NewsLoaded, v)
    end

    table.sort(TacRP.NewsLoaded, function(a, b)
        local a_y, a_m, a_d = string.match(a.Date, date_pattern)
        local b_y, b_m, b_d = string.match(b.Date, date_pattern)
        if (a_y > b_y) or (a_y == b_y and a_m > b_m) or (a_y == b_y and a_m == b_m and a_d > b_d) then
            return true
        end
        return false
    end)
end

local function fetchnews(callback)
    if TacRP.NewsLoaded then
        if callback then
            callback()
        end
        return
    end
    TacRP.NewsResult = "Fetching news..."
    http.Fetch("https://theonly8z.github.io/tactical_realist/article_list", function(body, length, headers, code)
        local _, body_start = string.find(body, "<html lang=\"en\">", nil, true)
        local body_end = string.find(body, "</html>", nil, true)
        if body_start and body_end then
            local json = string.sub(body, body_start + 1, body_end - 1)
            local loaded = (util.JSONToTable(json) or {}).news
            if not loaded then
                loadlocalandsort()
                if callback then
                    callback()
                end
                TacRP.NewsResult = "Fetch failed: " .. #TacRP.News .. " local (cannot parse)"
                return
            end
            TacRP.NewsLoaded = {}
            for i, v in pairs(loaded or {}) do
                v.Key = v.Link
                table.insert(TacRP.NewsLoaded, v)
            end
            loadlocalandsort()

            TacRP.NewsResult = "Fetch OK: " .. #loaded .. " remote, " .. #TacRP.News .. " local"

            if callback then
                callback()
            end
        else
            loadlocalandsort()
            if callback then
                callback()
            end
            TacRP.NewsResult = "Fetch failed: " .. #TacRP.News .. " local (cannot parse)"
        end
    end, function(message)
        loadlocalandsort()
        TacRP.NewsResult = "Fetch failed: " .. #TacRP.News .. " local (" .. message .. ")"
        if callback then
            callback()
        end
    end)
end


local html_head = [[<head>
<style>
@font-face {
    font-family: "Myriad Pro";
    src: url("asset://garrysmod/resource/fonts/myriad pro regular.ttf");
}
</style>
</head>]]

local html_failed = [[<body style="font-family:'Myriad Pro';text-align:center;color:white;font-size:200%;">
<p>Failed to load this page.</p>
<p>Link: {URL}</p>
<p>Error: {ERROR}</p>
]]

TacRP.NewsPanel = TacRP.NewsPanel or nil
function TacRP.CreateNewsPanel(open)
    TacRP.RemoveNewsPanel()

    local is_workshop = nil
    local last_update = nil
    steamworks.FileInfo(2588031232, function(result)
        last_update = os.date("%Y-%m-%d %H:%M", result.updated)
        is_workshop = steamworks.ShouldMountAddon(2588031232)
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
    local cvarback = vgui.Create("DPanel", TacRP.NewsPanel)
    cvarback:SetPos(ScreenScale(11), 0)
    cvarback:SetSize(ScreenScale(110), ScreenScale(8))
    function cvarback.Paint(self, w, h)
        surface.SetDrawColor(0, 0, 0, 100)
        surface.DrawRect(0, 0, w, h)
        TacRP.DrawCorneredBox(0, 0, w, h)

        draw.SimpleText("Only notify on major news/updates", "TacRP_Myriad_Pro_8", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local y_title = ScreenScale(2)
    local title = vgui.Create("DPanel", TacRP.NewsPanel)
    title:SetSize(w_news, h_title)
    title:Dock(TOP)
    function title.Paint(self, w, h)
        local c_bg = TacRP.GetPanelColor("bg2")
        surface.SetDrawColor(c_bg)
        surface.DrawRect(0, y_title, w, h - y_title)
        TacRP.DrawCorneredBox(0, y_title, w, h - y_title)
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
            text = "Update " .. tostring(TacRP.Version) .. " | " .. "Workshop: " .. last_update
        elseif is_workshop == false then
            text = "Update " .. tostring(TacRP.Version) .. " | " .. "Workshop: Not Mounted"
        end

        if text then
            draw.SimpleText(text, "TacRP_Myriad_Pro_6", ScreenScale(4), h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        draw.SimpleText("GMod Branch: " .. tostring(BRANCH), "TacRP_Myriad_Pro_6", w - ScreenScale(4), h / 2, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

        draw.SimpleText(TacRP.NewsResult, "TacRP_Myriad_Pro_6", w  / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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
    function TacRP.NewsPanel.PopulateNews(self2)
        newslist:Clear()
        for i, v in ipairs(TacRP.NewsLoaded) do
            local data = v
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
                TacRP.NewsPanel.Page:SetPageIndex(i)
            end
            function btn.Paint(self3, w, h)
                local down = btn.Index == TacRP.NewsPanel.Index
                local c_bg, c_cnr, c_txt = TacRP.GetPanelColors(self3:IsHovered() and !down, down)
                surface.SetDrawColor(c_bg)
                surface.DrawRect(0, 0, w, h)
                TacRP.DrawCorneredBox(0, 0, w, h, c_cnr)

                if !TacRP.NewsRead[data.Key] then
                    local c_glow = TacRP.GetPanelColor("text_glow", self3:IsHovered() and !down, down)
                    draw.SimpleText(data.Title, "TacRP_Myriad_Pro_8_Glow", ScreenScale(2), ScreenScale(2), c_glow, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                end
                draw.SimpleText(data.Title, "TacRP_Myriad_Pro_8", ScreenScale(2), ScreenScale(2), c_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                draw.SimpleText(data.Date or "Unknown Date", "TacRP_Myriad_Pro_6", w - ScreenScale(2), ScreenScale(9.5), c_txt, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
                draw.SimpleText((data.Type or "Article") .. ((data.Link or data.Hyperlink) and " (Web)" or ""), "TacRP_Myriad_Pro_6", ScreenScale(2), ScreenScale(9.5), c_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

                if btn.TextLines then
                    for j, text in ipairs(btn.TextLines) do
                        draw.SimpleText(text, "TacRP_Myriad_Pro_6", ScreenScale(2), ScreenScale(16) + (j - 1) * ScreenScale(6.5), c_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                    end
                end
            end
            buttons[i] = btn
        end
        newslist:SizeToChildren(false, true)
    end
    TacRP.NewsPanel:PopulateNews()

    local page = vgui.Create("DPanel", TacRP.NewsPanel)
    TacRP.NewsPanel.Page = page
    page:Dock(FILL)
    page:DockMargin(ScreenScale(2), ScreenScale(2), 0, ScreenScale(2))
    page:InvalidateParent(true)

    function page:SetPageIndex(i)

        self:Clear()
        TacRP.NewsPanel.Index = i
        local data = TacRP.NewsLoaded[TacRP.NewsPanel.Index or -1]
        local ind = data.Key

        if !TacRP.NewsRead[ind] then
            timer.Remove("tacrp_news")
            timer.Create("tacrp_news", 1.5, 1, function()
                if TacRP.NewsPanel and TacRP.NewsPanel.Index == i then
                    TacRP.NewsRead[ind] = true
                    TacRP.SaveReadData()
                end
            end)
        end

        local pagelink = data.Hyperlink or data.Link
        if pagelink then
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
                homebutton.Page:OpenURL(pagelink)
            end

            local linkbutton = vgui.Create("DButton", topbar)
            linkbutton:SetText("")
            linkbutton:Dock(FILL)
            linkbutton:SetMouseInputEnabled(true)
            linkbutton.Hyperlink = pagelink
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
            html:OpenURL(pagelink)
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
            page_type:SetText((data.Type or "Article") .. (data.Author and (" • " .. data.Author) or ""))
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
            local url = data.ContentSource --or data.Link
            if url then
                http.Fetch(url, function(body, length, headers, code)
                    local article_start = string.find(body, "<section[^>]+>", nil, true)
                    local _, article_end = string.find(body, "</section>", nil, true)
                    if article_start and article_end then
                        body = string.sub(body, article_start, article_end)
                        html:SetHTML(html_head .. "\n" .. body)
                    else
                        html:SetHTML(body)
                    end
                end, function(message)
                    local body = html_failed
                    body = string.Replace(body, "{URL}", url)
                    body = string.Replace(body, "{ERROR}", message)
                    html:SetHTML(html_head .. "\n" .. body)
                end)
            else
                html:SetHTML(html_head .. "\n" .. data.Contents)
                html:SetAllowLua(true)
            end
        end

        self:InvalidateLayout(true)

        self:SizeToChildren(false, true)
    end

    function page:Paint(w, h)
        if !TacRP.NewsLoaded then return end
        local data = TacRP.NewsLoaded[TacRP.NewsPanel.Index or -1]
        if data and data.Hyperlink then return end

        local c_bg = TacRP.GetPanelColor("bg2")
        surface.SetDrawColor(c_bg)
        surface.DrawRect(0, 0, w, h)
        TacRP.DrawCorneredBox(0, 0, w, h)
    end

    local chosen = buttons[isnumber(open) and open or 1]
    if chosen then
        chosen:DoClick()
    end
end

concommand.Add("tacrp_news", function()
    fetchnews(function()
        local ind, major
        for i, v in ipairs(TacRP.NewsLoaded) do
            if !TacRP.NewsRead[v.Key] and (!ind or !major) then
                ind = i
                major = v.Major
            end
            if major then break end
        end

        TacRP.CreateNewsPanel(ind)
    end)
end)

concommand.Add("tacrp_news_reset", function()
    file.Delete(TacRP.PresetPath .. "tacrp_news.txt")
    TacRP.NewsRead = {}
    TacRP.NewsLoaded = nil
    TacRP.NewsResult = "Uninitialized"
end)

local function notifynews()
    TacRP.LoadReadData()

    fetchnews(function()
        local ind, major
        for i, v in ipairs(TacRP.NewsLoaded) do
            if !TacRP.NewsRead[v.Key] and (!ind or !major) then
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
                chat.AddText(color_white, "A new " .. string.lower(TacRP.NewsLoaded[ind].Type or "article") .. " was released!")
                chat.AddText(color_white, "Use command 'tacrp_news' or type '/tacrp_news' to view it and suppress this message.")
                chat.AddText(color_white, "---------------------------------------")
            end
        end
    end)
end
concommand.Add("tacrp_news_check", notifynews)

hook.Add("InitPostEntity", "tacrp_news", function()
    timer.Simple(5, function()
        if !GetConVar("tacrp_checknews"):GetBool() then return end
        notifynews()
    end)
end)

hook.Add("OnPlayerChat", "tacrp_news", function(ply, txt)
    if ply == LocalPlayer() and string.lower(txt) == "/tacrp_news" then
        LocalPlayer():ConCommand("tacrp_news")
        return true
    end
end)