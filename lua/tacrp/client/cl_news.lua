TacRP.Version = "DEV"

TacRP.News = {
    --[[]
    {
        Title = "HTML Test",
        Type = "Update",
        Date = "2023-03-16", -- yyyy-mm-dd
        Major = true, -- if unread, brings up page on startup
        Summary = nil, -- text shown in the side tab
        Hyperlink = nil, -- if set, try to load the specified webpage instead of Contents.
        Contents = "", -- main text. use <img=PATH> to embed images
        ContentsIsHTML = false -- if set, reads Contents as HTML.
    },
    ]]
    {
        Title = "Test",
        Date = "2023-03-16",
        Major = false,
        Summary = "Blah blah blah blah blah... This will automatically make a newline and stuff. It should scale to line count.",
        Contents = [[Lorem Ipsum
        ]],
    },
    {
        Title = "Not a Rickroll",
        Type = "Source: Trust me bro",
        Date = "2023-03-16",
        Major = true,
        Summary = nil,
        Hyperlink = "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    },
    {
        Title = "Google gmod realism",
        Type = "Update",
        Date = "2023-03-16",
        Major = true,
        Summary = "Blah blah blah blah blah... This will automatically make a newline and stuff. It should scale to line count.",
        Contents = [[Are you kidding ??? What the **** are you talking about man ? You are a biggest looser i ever seen in my life ! You was doing PIPI in your pampers when i was beating players much more stronger then you! You are not proffesional, because proffesionals knew how to lose and congratulate opponents, you are like a girl crying after i beat you! Be brave, be honest to yourself and stop this trush talkings!!! Everybody know that i am very good blitz player, i can win anyone in the world in single game! And "w"esley "s"o is nobody for me, just a player who are crying every single time when loosing, ( remember what you say about Firouzja ) !!! Stop playing with my name, i deserve to have a good name during whole my chess carrier, I am Officially inviting you to OTB blitz match with the Prize fund! Both of us will invest 5000$ and winner takes it all!
<img=tacrp/news/test.jpg>
I suggest all other people who's intrested in this situation, just take a look at my results in 2016 and 2017 Blitz World championships, and that should be enough... No need to listen for every crying babe, Tigran Petrosyan is always play Fair ! And if someone will continue Officially talk about me like that, we will meet in Court! God bless with true! True will never die ! Liers will kicked off...]],
    },
}
TacRP.NewsRead = {}

function TacRP.SaveReadData()
    file.Write("tacrp_news.txt", util.TableToJSON(TacRP.NewsRead, false))
end

function TacRP.LoadReadData()
    TacRP.NewsRead = util.JSONToTable(file.Read("tacrp_news.txt", "DATA") or "") or {}
end

function TacRP.RemoveNewsPanel()
    if TacRP.NewsPanel then
        TacRP.NewsPanel:Close()
        TacRP.NewsPanel = nil
    end
end

local pattern_img = "<img=([^>]+)>"

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
    cvartext:SetText("Only show major news/updates")
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
        function btn.Paint(self, w, h)
            local down = btn.Index == TacRP.NewsPanel.Index
            local c_bg, c_cnr, c_txt = TacRP.GetPanelColors(self:IsHovered() and !down, down)
            surface.SetDrawColor(c_bg)
            surface.DrawRect(0, 0, w, h)
            TacRP.DrawCorneredBox(0, 0, w, h, c_cnr)

            if !TacRP.NewsRead[i] then
                local c_glow = TacRP.GetPanelColor("text_glow", self:IsHovered() and !down, down)
                draw.SimpleText(data.Title, "TacRP_Myriad_Pro_8_Glow", ScreenScale(2), ScreenScale(2), c_glow, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            end
            draw.SimpleText(data.Title, "TacRP_Myriad_Pro_8", ScreenScale(2), ScreenScale(2), c_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.SimpleText(data.Date or "Unknown Date", "TacRP_Myriad_Pro_6", w - ScreenScale(2), ScreenScale(9.5), c_txt, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
            draw.SimpleText(data.Type or "Article", "TacRP_Myriad_Pro_6", ScreenScale(2), ScreenScale(9.5), c_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

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
    function sbar2.btnUp:Paint(w, h)
        local c_bg, c_txt = TacRP.GetPanelColor("bg2", self:IsHovered()), TacRP.GetPanelColor("text", self:IsHovered())
        surface.SetDrawColor(c_bg)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("↑", "TacRP_HD44780A00_5x8_4", w / 2, h / 2, c_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    function sbar2.btnDown:Paint(w, h)
        local c_bg, c_txt = TacRP.GetPanelColor("bg2", self:IsHovered()), TacRP.GetPanelColor("text", self:IsHovered())        surface.SetDrawColor(c_bg)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("↓", "TacRP_HD44780A00_5x8_4", w / 2, h / 2, c_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    function sbar2.btnGrip:Paint(w, h)
        local c_bg, c_cnr = TacRP.GetPanelColor("bg2", self:IsHovered()), TacRP.GetPanelColor("corner", self:IsHovered())        surface.SetDrawColor(c_bg)
        TacRP.DrawCorneredBox(0, 0, w, h, c_cnr)
    end

    local page = pagescroll:Add("DPanel")
    page:Dock(TOP)
    page:SetSize(w_news - w_list - ScreenScale(2), ScreenScale(196))

    function page:SetPageIndex(i)

        if !TacRP.NewsRead[i] then
            timer.Remove("tacrp_news")
            timer.Create("tacrp_news", 2, 1, function()
                if TacRP.NewsPanel and TacRP.NewsPanel.Index == i then
                    TacRP.NewsRead[i] = true
                end
            end)
        end

        self:Clear()
        TacRP.NewsPanel.Index = i
        local data = TacRP.News[TacRP.NewsPanel.Index or -1]

        if data.Hyperlink then

            local html = vgui.Create("DHTML", self)
            html:Dock(FILL)
            html:OpenURL(data.Hyperlink)

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
            page_subtitle:DockMargin(ScreenScale(4), 0, ScreenScale(4), ScreenScale(8))
            page_subtitle:Dock(TOP)
            page_subtitle:SetTall(ScreenScale(14))
            page_subtitle.Paint = function() end

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

            if data.ContentsIsHTML then
                local html = vgui.Create("DHTML", self)
                html:Dock(FILL)
                html:SetHTML(data.Contents)
                html:SetAllowLua(true)
            else
                self.TextLines = TacRP.MultiLineText(data.Contents, self:GetWide() - ScreenScale(8), "TacRP_Myriad_Pro_10")
                for j, text in ipairs(self.TextLines) do
                    if string.match(text, pattern_img) then
                        local img = vgui.Create("DImage", self)
                        img:SetMaterial(Material(string.match(text, pattern_img), "smooth"))
                        -- img:SizeToContents()
                        img:Dock(TOP)
                        img:DockMargin(ScreenScale(4), ScreenScale(8), ScreenScale(4), ScreenScale(8))

                        local mat = img:GetMaterial()
                        local ratio = mat:Height() / mat:Width()
                        if mat:Width() > self:GetWide() then
                            img:SetSize(self:GetWide(), self:GetWide() * ratio)
                        end
                    else
                        local line = vgui.Create("DLabel", self)
                        line:Dock(TOP)
                        line:DockMargin(ScreenScale(4), 0, 0, 0)
                        line:SetFont("TacRP_Myriad_Pro_10")
                        line:SetTextColor(c_txt)
                        line:SetText(text)
                        line:SetTall(ScreenScale(9.5))
                    end
                end
            end

        end

        self:InvalidateLayout(true)

        self:SizeToChildren(false, true)
        self:SetTall(self:GetTall() + ScreenScale(24))
    end

    function page:Paint(w, h)
        local c_bg = TacRP.GetPanelColor("bg2")
        surface.SetDrawColor(c_bg)
        surface.DrawRect(0, 0, w, h)
        TacRP.DrawCorneredBox(0, 0, w, h)
    end

    TacRP.NewsPanel.Page = page
    buttons[isnumber(open) and open or #TacRP.News]:DoClick()
end

concommand.Add("tacrp_news", TacRP.CreateNewsPanel)

-- hook.Add("InitPostEntity", "tacrp_news", function()
--     TacRP.LoadReadData()

--     local ind, major
--     for i, v in ipairs(TacRP.News) do
--         if !TacRP.NewsRead[i] then
--             if !ind or !major then
--                 ind = i
--                 major = v.Major
--             end
--         end
--     end

--     if ind then
--         if major then
--             TacRP.CreateNewsPanel(ind)
--         elseif !GetConVar("tacrp_news_majoronly"):GetBool() then
--             chat.AddText("A new " .. string.lower(TacRP.News[ind].Type or "article") .. " for Tactical RP is released!")
--             chat.AddText("Use command 'tacrp_news' or type '/tacrp_news' to view it or suppress this message.")
--         end
--     end
-- end)

-- hook.Add("OnPlayerChat", "tacrp_news", function(ply, txt)
--     if ply == LocalPlayer() and string.lower(txt) == "/tacrp_news" then
--         TacRP.CreateNewsPanel()
--         return true
--     end
-- end)