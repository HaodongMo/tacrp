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
<span style="font-size:80%;"><i>If you forgot you had TacRP installed, we're sorry for distrubing your gmod session, please don't unsubscribe</i></span></p>

<p>You can now catch up with updates, dev blogs, and more, all from the comfort of your own video game! A few posts (like this one) are embedded within the addon and will always be available, while others will be fetched remotely so you can get the hottest news without updating the addon.</p>

<p>Major updates and releases will be displayed on startup, while minor posts will bring up a reminder in the chat box. If you want to be only notified for major updates, toggle the checkbox above.</p>

<p>Despite the cold reception TacRP got at launch, some of you stuck with us (or at least tolerated its presence in the weapons tab), and we cannot thank you enough for your support. That's why we here at <b>Garry's Mod Tactical Realism Industries™</b><i style="font-size:50%;">(trademark pending)</i> are cooking up more good stuff for you to enjoy, including an <i>expansion pack full of new weapons</i>.</p>

<p>In the meantime, we hope you enjoy Tactical RP, and remember:<br>
<i>No matter what Arctic might say, the RP in TacRP stands for Remix Pack, not Role Play!</i>
<br><span style="font-size:50%;opacity:0.25;">It is seriously kind of stupid to put roleplay in your weapon pack name. Is there even a DarkRP server out there that uses these guns? Don't they all just use M9K? Why do we even make new weapon packs if a decade-old weapon base with no c_hands is enough for them? Is humanity truly doomed? sussy imposter amogus??? skull emoji</span></p>

<p>Yours,<br>
<b>8Z, the gmod hyperealist</b></p>
</body>]]
    },
    {
        Title = "Interops Update",
        Type = "Announcement",
        Date = "2023-05-14",
        Author = "8Z",
        Major = true,
        Summary = "Major update and expansion! It's here!!!",
        Contents = [[<body style="font-family:'Myriad Pro';color:white;font-size:125%;">
<p>It's here!<br></p>

<p>Alongside the release of thirty-one new weapons in the Interops pack, a long list of changes have also dropped. They've been sneakily updated (sorry) but I've finally bothered to write the patch notes for them now.</p>

<p>Without being too verbose, here is a shortlist of all the changes up until this point.</p>

<h3>Armor Penetration</h3>
<p>Combat can get really awkward with HL2 armor absorbing 80% of all damage. Now, TacRP braves the unknown to become the second addon to ever challenge this status quo! (The first being, of course, my own Danger Zone Entities. #humblebrag)<br>
Every weapon has an Armor Piercing and Armor Shredding value. The former dictates how much damage is blocked by armor and the latter determines how much damage armor takes.
All weapons have naturally been balanced to use these numbers, so you can expect a tactical experience even with armor.</p>
<p>Of course, TacRP is fully compatible with Danger Zone Entities' armor, and will use the weapons' AP value for them.</p>

<h3>TTT Support</h3>
<p>It's a match made in heaven! TacRP will now natively support TTT, and using it is as easy as installing and opening the game. In addition to compatibility, a new set of stats have been made for the mode in particular so that the weapons' balance is similar to vanilla TTT.<br>
Several guns are added as buyable equipment, like the launchers, anti-materiel snipers, and the riot shield.<br>
There's also two buyable equipment, an attachment bench (if you restrict customization), and an ammo box.</p>

<h3>Rebalance... Again</h3>
<p>I just can't help it. The default "Tactical" balance mode has been rewritten to be less slow (considering reduced movement speed in most roleplay modes), and higher-tiered weapons are less overpowered, albeit still stronger on average.<br>
With the addition of new weapons to round out the set, some category changes have also been made.</p>

<h3>Hints</h3>
<p>You can do so many things with these guns it's hard to keep track. Now, you don't have to!<br>
Hints will show up reminding you what contextually relevant buttons you can press. It'll also nag you to bind your grenade input.</p>

<h3>Stats Menu Rework</h3>
<p>The stats menu finally has a scroll bar to scroll through all those numbers. They also now show the change in difference as a percentage.</p>

<h3>Held Grenades</h3>
<p>Relevant to TTT, you can now pull out grenades as weapons. Unfortunately I was not able to get custom viewmodels for them, so bear with the CSS placeholders for a bit.<br>
Also, if you have Danger Zone Entities, you can quickthrow and switch to Bump Mines.</p>
<br>
<p>Anyways, I hope all of you have as much fun with the Interops weapons as speedonerd and I had making them. It's a pleasure seeing these old models come to life again.<br>
Be sure to check out the Interops workshop page as well as Danger Zone Entities.</p>

<p>Yours,<br>
<b>8Z, the gmod hyperealist</b></p>
</body>]],
    },
    {
        Title = "Update 8",
        Type = "Patch Notes",
        Date = "2023-05-15",
        Author = "8Z",
        Major = false,
        Summary = "Post release fixes because it keeps happening.",
        Contents = [[<body style="font-family:'Myriad Pro';color:white;font-size:125%;">
<p>No update survives first contact. As is tradition, things immediately break when I push updates. Even if the version number is my lucky number.</p>
<p>In addition to some fixes, I've also added a few small but cool things, like the ability to pick up DNA from dropped magazines in TTT, and gas effects.</p>
<ul>
<li><b>Added:</b> Overlay, motion blur and color modification when affected by gas directly (but not lingering damage).
<li><b>Added:</b> (TTT) Dropped magazines (including grenade spoons) contain DNA of the dropper and no longer fade.
<li><b>Added:</b> (TTT) Customization Bench allows you to freely customize (equivalent to free atts).
<li><b>Added:</b> (TTT) Picking up a grenade will make the player select it as a quicknade if the current selection isn't valid.
<li><b>Balance:</b> Sticky sounds (Breaching Charges, C4) and quickthrow sounds are less loud.
<li><b>Balance:</b> (TTT) Breaching Charges have a bigger blast radius, slightly lower damage and much quieter beeps.
<li><b>Balance:</b> Gas grenades no longer do damage when exploding.
<li><b>Balance:</b> Flashbang blast and effect radius now 728 (previously 512 and 1024).
<li><b>Changed:</b> (TTT) Random attachments will try to avoid duplicates and respect InvAtt.
<li><b>Fixed:</b> Various issues with the Medkit.
<li><b>Fixed:</b> Bodygroup related errors.
<li><b>Fixed:</b> Quicknade and grenade weapons do not respect ttt_no_nade_throw_during_prep.
<li><b>Fixed:</b> Gas grenade doesn't cause sway and coughing when below health threshold.
<li><b>Fixed:</b> Attachments do not sync properly if weapon is out of PVS initially (such as spawning in TTT).
</ul>
<p>I'm sure I've missed some more, so send any issues or suggestions my way!</p>
<p>Yours,<br>
<b>8Z, the gmod hyperealist</b></p>]],
    },
    {
        Title = "Update 9",
        Type = "Patch Notes",
        Date = "2023-05-16",
        Author = "8Z",
        Major = false,
        Summary = "The biggest changes tend to slip under the hood.",
        Contents = [[<body style="font-family:'Myriad Pro';color:white;font-size:125%;">
<p>A humble update. Aside from a lot of internal changes, some systems have been reworked and a new ammo attachment for pistols is added.</p>

<h3>Jamming Rework</h3>
<p>Arctic added jamming for fun and neither of us really knew what to do with it. We didn't want to just slap it on all guns just because, but there also seemed to not be any good reason to put it anywhere.
In lieu of a better idea, I've elected to give the surplus attachments some dubious upside that at the very least may be interesting.</p>

<p>Furthermore, the chance to jam is now based on ammo type, with attachments adding a "Jam Factor" instead of modifying percentage chances directly. This should help prevent pistols, shotguns and snipers from jamming too infrequently compared to automatic high fire rate guns.</p>


<h3>Free Aim Rework</h3>
<p>Free Aim was one of those features that nobody liked - admittedly, not even myself. But I couldn't not give it another chance.</p>
<ul>
<li>All weapons now have their own Free Aim Angle, typically between 2-9 degrees. Generally speaking, pistols, SMGs and stockless weapons have little free aim.
<li>Overall free aim value is much lower. Most rifles will have 4-5 degrees, and only cumbersome weapons like snipers and machine guns will have high values.
<li>Free aim point of aim moves across the screen slower.
</ul>

<h3>Mr. Worldwide</h3>
<p>Ported over the localization system used in ARC9. As of now, there are no other languages, so if you are interested in contributing your language, please contact me or make a pull request!<br>
An additional benefit is that a lot of the attachments now use consistent wording due to switching to phrases.</p>

<h3>Changelist</h3>
<ul>
<li><b>Major Change:</b> Free Aim rework.
<li><b>Major Change:</b> Jamming rework.
<li><b>Added:</b> Surplus Ammo and Surplus Bolt gained unique behavior. They still jam though.
<li><b>Added:</b> Steel Core Rounds for pistols, basically the oppposite of Hollowpoints.
<li><b>Added:</b> Localization system. Currently only Chinese Simplified is available.
<li><b>Rebalance:</b> (Arcade) Most pistols are no longer lethal on headshot without Hollowpoints/Skullsplitter.
<li><b>Rebalance:</b> Dual MTX has reduced spread and fires in runaway burst.
<li><b>Rebalance:</b> Riot Shield can now be penetrated with sufficient Material Penetration (around 30).
<li><b>Rebalance:</b> TMJ now gives flat penetration increase of 8" (generally lower than before).
<li><b>Rebalance:</b> AS-50 and Hecate II got more penetration.
<li><b>Rebalance:</b> Auto-Burst trigger no longer has downsides (it's now easy to get optimal ROF with improved buffering).
<li><b>Rebalance:</b> Sniper rifles have lower hip spread penalty (to compensate for free aim).
<li><b>Rebalance:</b> Juice up UMP45 with less recoil kick and spread.
<li><b>Rebalance:</b> Burst trigger on semi-auto guns increase RPM further and no longer increase recoil spread. Burst is now runaway and semi mode is removed.
<li><b>Rebalance:</b> Competition/Weighted trigger no longer change recoil kick.
<li><b>Changed:</b> Adjusted thresholds and criteria for some ratings.
<li><b>Changed:</b> Click buffering for burst fire now works during the whole burst and not just after the last shot.
<li><b>Changed:</b> Renamed Penetration to Material Penetration, and Armor Piercing to Armor Penetration.
<li><b>Changed:</b> Some descriptions for stats and ratings.
<li><b>Fixed:</b> When both Free Aim and Sway are on, point of aim shakes intensely while recovering from recoil.
<li><b>Fixed:</b> Safety desync causing gun able to shoot while apparently in safety.
</ul>]],
    },
    {
        Title = "Update 10",
        Type = "Patch Notes",
        Date = "2023-06-14",
        Author = "8Z",
        Major = false,
        Summary = "Minor performance and PVE Balance.",
        Contents = [[<body style="font-family:'Myriad Pro';color:white;font-size:125%;">

<h3>Changelist</h3>
<ul>
<li><b>Major Change:</b> PvE balance mode.
<li><b>Changed:</b> ConVars are now cached, which should increase performance.
<li><b>Changed:</b> Hold type while aiming.
<li><b>Changed:</b> Lasers now draw only a dot and not the beam. They are also more consistent.
</ul>]],
    },
    {
        Title = "Update 11",
        Type = "Patch Notes",
        Date = "2023-06-27",
        Author = "8Z",
        Major = false,
        Summary = "New customization menu, and more suppressors!",
        Contents = [[<body style="font-family:'Myriad Pro';color:white;font-size:125%;">
<p>The customization menu is getting a little cramped with all the tactical customization going on. The new UI should be way more concise, hiding all the options behind a click but still allowing you to see all your current choices at a glance.</p>

<p>If you're not a fan, the legacy menu option can be toggled back with the checkbox in the bottom left.</p>

<p>Besides that, there's also 2 more suppressor options to make the Muzzle slot a little less lonely. Also, they're suppressors and not silencers now.</p>

<h3>Changelist</h3>
<ul>
<li><b>Major Change:</b> Customization menu rework.
<li><b>Added:</b> Support for DynaMetR's Customizable HL2 HUD. Secondary ammo will display the type and amount of the currently selected quicknade, and ammo pickup will also display correctly.
<li><b>Added:</b> Compact Suppressor. Reduces spread, lower penalty compared to the Silencer (now Tactical Suppressor).
<li><b>Added:</b> Weighted Suppressor. Increases range and reduces recoil, but worsens ADS and sprint time.
<li><b>Added:</b> Akimbo variants for some attachments.
<li><b>Added:</b> Icons for PS90 and HK94 (thanks speedonerd).
<li><b>Rebalance:</b> Tactical Suppressor also reduces recoil spread penalty (5%).
<li><b>Rebalance:</b> Akimbo trigger has weaker RPM penalty (10%).
<li><b>Rebalance:</b> Reduced recoil spread on several assault rifles.
<li><b>Rebalance:</b> Reduced recoil on the RPG-7 drastically.
<li><b>Changed:</b> Adjusted shooting volume on some weapons for consistency. Pistol caliber weapons have ~110dB, carbines ~120dB, and the rest are ~130dB.
<li><b>Changed:</b> Stat differences are now rounded to the whole percent (due to rounding errors in the values, the extra precision is meaningless).
<li><b>Fixed:</b> Adjusted suppressor positions on some guns.
<li><b>Fixed:</b> Akimbo pistols use last shot animation correctly.
<li><b>Fixed:</b> Pre-emptively fix an upcoming issue in the June 2023 update related to loading server files in Singleplayer.
</ul>]],
    },
    {
        Title = "Update 12",
        Type = "Patch Notes",
        Date = "2023-07-18",
        Author = "8Z",
        Major = false,
        Summary = "AR Expansion, and recoil system overhaul.",
        Contents = [[<body style="font-family:'Myriad Pro';color:white;font-size:125%;">

<p>The AR Expansion Pack is out now! Get 5 new guns by clicking this (not a rickroll): <input type='submit' value='Open Workshop Page' onclick='console.log("RUNLUA:gui.OpenURL(\"https://steamcommunity.com/sharedfiles/filedetails/?id=3006376475\")")' /></p>

<p>This update introduces changes to how recoil and spread works. Before, most "Recoil" stats were actually affecting spread, and Recoil Kick was the only actual recoil stat. These stats are now renamed to Bloom, and their behavior has changed as well.</p>

<p>Under the new system, instead of your gun magically becoming less accurate as you shoot, the recoil becomes stronger instead. If you wish to revert to old behavior, untick "Bloom Modifies Recoil" in the Mechanics setting page.</p>

<p>Recoil Stability is a new stat that makes recoil go more straight up. Previously, recoil could go anywhere within a 180 degree half circle - this is equivalent to 0% stability now. Certain guns, especially high recoil rifles, have increased stability to make their recoil manageable.</p>

<p>The intent of the overall change is to improve the viability of high recoil weapons and to make medium to long range combat more viable on non-sniper rifles.</p>

<h3>Changelist</h3>
<ul>
<li><b>Major Change:</b> Alternate Recoil Mode.
<li><b>Major Change:</b> Recoil Stability stat.
<li><b>Added:</b> All weapons gain a 0.01 moving spread penalty.
<li><b>Added:</b> You can now bind +tacrp_melee to any button to quick melee. E+LMB will still work.
<li><b>Added:</b> ConVar to allow firing while sprinting, in case you're a boomer shooter enthuasist.
<li><b>Rebalance:</b> Fold Stock and Adjust Stock reduce ADS and sprint time by 0.08/0.04 seconds instead of a percentage, and recoil is reduced.
<li><b>Changed:</b> Some "Recoil" stats are now named Bloom. Their functionality remains identical.
<li><b>Fixed:</b> Certain lower resolutions unable to display attachments properly.
</ul>]],
    },
    {
        Title = "Update 13",
        Type = "Patch Notes",
        Date = "2023-07-18",
        Author = "8Z",
        Major = false,
        Summary = "Small compatability additions and balance tweaks.",
        Contents = [[<body style="font-family:'Myriad Pro';color:white;font-size:125%;">

<p>The Special Delivery expansion is out - get 21 extra special weapons for TacRP today!: <input type='submit' value='Open Workshop Page' onclick='console.log("RUNLUA:gui.OpenURL(\"https://steamcommunity.com/sharedfiles/filedetails/?id=3007840813\")")' /></p>

<p>This is a small update with mostly minor changes.</p>

<h3>Changelist</h3>
<ul>
<li><b>Added:</b> Breach Charges will attract VJ L4D Common Infected like a pipe bomb. Why? Why not?
<li><b>Added:</b> Expansion addons can now add shell ejections (used by Special Delivery for the Super X3)
<li><b>Rebalance:</b> Buffed DSA-58.
<li><b>Rebalance:</b> Some adjustments to akimbo attachments.
<li><b>Rebalance:</b> Buffed burst trigger fire rate.
<li><b>Changed:</b> When using Sliding Ability's slide, you aren't considered sprinting and can fire your gun.
<li><b>Fixed:</b> Auto-Burst doesn't work with non-runaway bursts.
</ul>]],
    },
}
TacRP.NewsRead = TacRP.NewsRead or {}
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

    local w_news, h_news = TacRP.SS(384), TacRP.SS(256)

    local h_bottom = TacRP.SS(8)
    local h_title = TacRP.SS(24)
    local w_list = TacRP.SS(96)
    local h_entry = TacRP.SS(18)

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
    close:SetSize(TacRP.SS(8), TacRP.SS(8))
    close:SetPos(w_news - TacRP.SS(10), 0)
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
    cvarbox:SetSize(TacRP.SS(8), TacRP.SS(8))
    cvarbox:SetPos(TacRP.SS(2), 0)
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
    cvarback:SetPos(TacRP.SS(11), 0)
    cvarback:SetSize(TacRP.SS(110), TacRP.SS(8))
    function cvarback.Paint(self, w, h)
        surface.SetDrawColor(0, 0, 0, 100)
        surface.DrawRect(0, 0, w, h)
        TacRP.DrawCorneredBox(0, 0, w, h)

        draw.SimpleText("Only notify on major news/updates", "TacRP_Myriad_Pro_8", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local y_title = TacRP.SS(2)
    local title = vgui.Create("DPanel", TacRP.NewsPanel)
    title:SetSize(w_news, h_title)
    title:Dock(TOP)
    function title.Paint(self, w, h)
        local c_bg = TacRP.GetPanelColor("bg2")
        surface.SetDrawColor(c_bg)
        surface.DrawRect(0, y_title, w, h - y_title)
        TacRP.DrawCorneredBox(0, y_title, w, h - y_title)
        draw.SimpleText("Tactical RP Newsletter", "TacRP_Myriad_Pro_20", w / 2, TacRP.SS(2), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
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
            draw.SimpleText(text, "TacRP_Myriad_Pro_6", TacRP.SS(4), h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        local branch = tostring(BRANCH)
        if branch == "unknown" then branch = "main" end

        draw.SimpleText("GMod Branch: " .. branch, "TacRP_Myriad_Pro_6", w - TacRP.SS(4), h / 2, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

        draw.SimpleText(TacRP.NewsResult, "TacRP_Myriad_Pro_6", w  / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local newspanel = vgui.Create("DScrollPanel", TacRP.NewsPanel)
    newspanel:SetSize(w_list, h_news - h_title)
    newspanel:DockMargin(0, TacRP.SS(2), 0, TacRP.SS(2))
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
    newslist:SetSpaceY(TacRP.SS(2))

    local buttons = {}
    function TacRP.NewsPanel.PopulateNews(self2)
        newslist:Clear()
        for i, v in ipairs(TacRP.NewsLoaded) do
            local data = v
            local btn = newslist:Add("DButton")
            if data.Summary then
                btn.TextLines = TacRP.MultiLineText(data.Summary, w_list - TacRP.SS(4), "TacRP_Myriad_Pro_6")
                btn:SetSize(w_list, h_entry + #btn.TextLines * TacRP.SS(6.5))
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
                    draw.SimpleText(data.Title, "TacRP_Myriad_Pro_8_Glow", TacRP.SS(2), TacRP.SS(2), c_glow, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                end
                draw.SimpleText(data.Title, "TacRP_Myriad_Pro_8", TacRP.SS(2), TacRP.SS(2), c_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                draw.SimpleText(data.Date or "Unknown Date", "TacRP_Myriad_Pro_6", w - TacRP.SS(2), TacRP.SS(9.5), c_txt, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
                draw.SimpleText((data.Type or "Article") .. ((data.Link or data.Hyperlink) and " (Web)" or ""), "TacRP_Myriad_Pro_6", TacRP.SS(2), TacRP.SS(9.5), c_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

                if btn.TextLines then
                    for j, text in ipairs(btn.TextLines) do
                        draw.SimpleText(text, "TacRP_Myriad_Pro_6", TacRP.SS(2), TacRP.SS(16) + (j - 1) * TacRP.SS(6.5), c_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
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
    page:DockMargin(TacRP.SS(2), TacRP.SS(2), 0, TacRP.SS(2))
    page:InvalidateParent(true)

    function page:SetPageIndex(i)

        self:Clear()
        TacRP.NewsPanel.Index = i
        local data = TacRP.NewsLoaded[TacRP.NewsPanel.Index or -1]
        local ind = data.Key

        if !TacRP.NewsRead[ind] then
            timer.Remove("tacrp_news")
            timer.Create("tacrp_news", 0.5, 1, function()
                if TacRP.NewsPanel and TacRP.NewsPanel.Index == i then
                    TacRP.NewsRead[ind] = true
                    TacRP.SaveReadData()
                end
            end)
        end

        local pagelink = data.Hyperlink or data.Link
        if pagelink then
            self:SetSize(w_news - w_list - TacRP.SS(2), h_news - h_title - h_bottom - TacRP.SS(16))

            local topbar = vgui.Create("DPanel", self)
            topbar:Dock(TOP)
            topbar:SetTall(TacRP.SS(8))
            function topbar.Paint(self2, w, h)
            end

            local homebutton = vgui.Create("DButton", topbar)
            homebutton:SetText("")
            homebutton:Dock(LEFT)
            homebutton:SetSize(TacRP.SS(16), TacRP.SS(8))
            homebutton:DockMargin(TacRP.SS(2), 0, TacRP.SS(2), 0)
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
            if BRANCH == "unknown" then
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
                    draw.SimpleText("Embedded browers do not work on your branch of GMod.", "TacRP_Myriad_Pro_8", w / 2, h + TacRP.SS(96), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    draw.SimpleText("Click here to open the tab in the overlay.", "TacRP_Myriad_Pro_8", w / 2, h + TacRP.SS(106), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    DisableClipping(false)
                end
                function linkbutton.DoClick(self2)
                    gui.OpenURL(self2.Hyperlink)
                end
            else
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
                    draw.SimpleText("If the page does not load, click the link at the top to open externally.", "TacRP_Myriad_Pro_8", w / 2, h + TacRP.SS(96), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    DisableClipping(false)
                end
                function linkbutton.DoClick(self2)
                    gui.OpenURL(self2.Hyperlink)
                end
            end


            if BRANCH != "unknown" then
                local html = vgui.Create("DHTML", self)
                html:Dock(FILL)
                html:OpenURL(pagelink)
                function html.OnBeginLoadingDocument(self2, url)
                    linkbutton.Hyperlink = url
                end
                homebutton.Page = html
            else
                local html = vgui.Create("DButton", self)
                html:SetText("")
                html:Dock(FILL)
                linkbutton.Hyperlink = pagelink
                function html.Paint(self2) end
                function html.DoClick(self2)
                    gui.OpenURL(linkbutton.Hyperlink)
                end
            end
        else
            local c_txt = TacRP.GetPanelColor("text")

            local page_title = vgui.Create("DLabel", self)
            page_title:SetFont("TacRP_Myriad_Pro_20")
            page_title:SetTextColor(c_txt)
            page_title:SetText(data.Title)
            page_title:SizeToContents()
            page_title:DockMargin(TacRP.SS(4), TacRP.SS(2), 0, 0)
            page_title:Dock(TOP)

            local page_subtitle = vgui.Create("DPanel", self)
            page_subtitle:DockMargin(TacRP.SS(4), 0, TacRP.SS(4), TacRP.SS(2))
            page_subtitle:Dock(TOP)
            page_subtitle:SetTall(TacRP.SS(14))
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
            if major and !TacRP.ConVars["news_majoronly"]:GetBool() then
                TacRP.CreateNewsPanel(ind)
            elseif major or !TacRP.ConVars["news_majoronly"]:GetBool() then
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
        if !TacRP.ConVars["checknews"]:GetBool() then return end
        notifynews()
    end)
end)

hook.Add("OnPlayerChat", "tacrp_news", function(ply, txt)
    if ply == LocalPlayer() and string.lower(txt) == "/tacrp_news" then
        LocalPlayer():ConCommand("tacrp_news")
        return true
    end
end)