local qualitymat = Material("tacrp/quality_overlay.png", "smooth")

local quality_to_color = {
    ["5Value"] = Color(255, 255, 255, 75),
    ["4Consumer"] = Color(200, 255, 200, 75),
    ["3Security"] = Color(50, 50, 200, 75),
    ["2Operator"] = Color(200, 40, 200, 75),
    ["1Elite"] = Color(255, 50, 50, 75),
    ["0Exotic"] = Color(225, 225, 50, 75),
}

local function DoGenericSpawnmenuRightclickMenu(self)
    local menu = DermaMenu()

    menu:AddOption("#spawnmenu.menu.copy", function()
        SetClipboardText(self:GetSpawnName())
    end):SetIcon("icon16/page_copy.png")

    if isfunction(self.OpenMenuExtra) then
        self:OpenMenuExtra(menu)
    end

    if not IsValid(self:GetParent()) or not self:GetParent().GetReadOnly or not self:GetParent():GetReadOnly() then
        menu:AddSpacer()

        menu:AddOption("#spawnmenu.menu.delete", function()
            self:Remove()
            hook.Run("SpawnlistContentChanged")
        end):SetIcon("icon16/bin_closed.png")
    end

    menu:Open()
end

local function AddWeaponToCategory( propPanel, ent )
    return spawnmenu.CreateContentIcon(ent.ScriptedEntityType or "weapon", propPanel, {
        nicename = ent.PrintName or ent.ClassName,
        spawnname = ent.ClassName,
        material = ent.IconOverride or ("entities/" .. ent.ClassName .. ".png"),
        admin = ent.AdminOnly
    })
end

spawnmenu.AddContentType("tacrp_weapon", function(container, obj)
    if not obj.material then return end
    if not obj.nicename then return end
    if not obj.spawnname then return end
    local icon = vgui.Create("ContentIcon", container)
    icon:SetContentType("weapon")
    icon:SetSpawnName(obj.spawnname)
    icon:SetName(obj.nicename)
    icon:SetMaterial(obj.material)
    icon:SetAdminOnly(obj.admin)
    icon.Quality = obj.quality
    icon:SetColor(Color(135, 206, 250, 255))
    -- Generate a nice tooltip with extra info.
    local SWEPinfo = weapons.Get(obj.spawnname)
    local toolTip = language.GetPhrase(obj.nicename)

    if not SWEPinfo then
        SWEPinfo = list.Get("Weapon")[obj.spawnname]
    end


    if SWEPinfo then
        toolTip = toolTip .. "\n"

        if SWEPinfo.Description and SWEPinfo.Description != "" then
            toolTip = toolTip .. "\n" .. SWEPinfo.Description
        end

        if SWEPinfo.Description_Quote and SWEPinfo.Description_Quote != "" then
            toolTip = toolTip .. "\n\n" .. SWEPinfo.Description_Quote
        end
    end

    icon:SetTooltip(toolTip)

    local highlight = TacRP.ConVars["spawnmenu_highlight"]:GetBool() and TacRP.UseTiers()
    if highlight then
        local oldpaint = icon.Paint
        icon.Paint = function(self2, w, h)
            surface.SetDrawColor(quality_to_color[self2.Quality] or Color(0, 0, 0, 0))
            surface.SetMaterial(qualitymat)
            surface.DrawTexturedRect(0, 0, w, h)
            oldpaint(self2, w, h)
        end
    end


    icon.DoClick = function()
        RunConsoleCommand("gm_giveswep", obj.spawnname)
        surface.PlaySound("ui/buttonclickrelease.wav")
    end

    icon.DoMiddleClick = function()
        RunConsoleCommand("gm_spawnswep", obj.spawnname)
        surface.PlaySound("ui/buttonclickrelease.wav")
    end

    icon.OpenMenuExtra = function(self, menu)
        menu:AddOption("#spawnmenu.menu.spawn_with_toolgun", function()
            RunConsoleCommand("gmod_tool", "creator")
            RunConsoleCommand("creator_type", "3")
            RunConsoleCommand("creator_name", obj.spawnname)
        end):SetIcon("icon16/brick_add.png")

        if self:GetIsNPCWeapon() then
            local opt = menu:AddOption("#spawnmenu.menu.use_as_npc_gun", function()
                RunConsoleCommand("gmod_npcweapon", self:GetSpawnName())
            end)

            if self:GetSpawnName() == GetConVarString("gmod_npcweapon") then
                opt:SetIcon("icon16/monkey_tick.png")
            else
                opt:SetIcon("icon16/monkey.png")
            end
        end
    end

    icon.OpenMenu = DoGenericSpawnmenuRightclickMenu

    if IsValid(container) then
        container:Add(icon)
    end

    return icon
end)

hook.Add("PopulateWeapons", "zzz_TacRP_SubCategories", function(pnlContent, tree, anode)
    local cvar = TacRP.ConVars["spawnmenu_subcats"]:GetInt()
    -- if cvar == 0 then return end

    local sortbytiers = TacRP.ConVars["spawnmenu_sortbytiers"]:GetBool()

    timer.Simple(0, function()
        -- Loop through the weapons and add them to the menu
        local Weapons = list.Get("Weapon")
        local Categorised = {}
        local TacRPCats = {}

        -- Build into categories + subcategories
        for k, weapon in pairs(Weapons) do
            if not weapon.Spawnable then continue end
            if not weapons.IsBasedOn(k, "tacrp_base") then continue end
            -- Get the weapon category as a string
            local Category = weapon.Category or "Other2"
            local WepTable = weapons.Get(weapon.ClassName)

            if not isstring(Category) then
                Category = tostring(Category)
            end

            -- Get the weapon subcategory as a string
            local SubCategory = "Other"

            if cvar == 2 then
                if WepTable != nil and WepTable.SubCatTier != nil then
                    SubCategory = WepTable.SubCatTier

                    if SubCategory == "9Special" then
                        SubCategory = WepTable.SubCatType
                    end

                    if not isstring(SubCategory) then
                        SubCategory = tostring(SubCategory)
                    end
                end
            elseif cvar == 1 then
                if WepTable != nil and WepTable.SubCatType != nil then
                    SubCategory = WepTable.SubCatType

                    if not isstring(SubCategory) then
                        SubCategory = tostring(SubCategory)
                    end
                end
            else
                SubCategory = "Other"
            end

            local wep = weapons.Get(weapon.ClassName)

            weapon.Quality = wep.SubCatTier

            -- Insert it into our categorised table
            Categorised[Category] = Categorised[Category] or {}
            Categorised[Category][SubCategory] = Categorised[Category][SubCategory] or {}
            table.insert(Categorised[Category][SubCategory], weapon)
            TacRPCats[Category] = true
        end

        -- Iterate through each category in the weapons table
        for _, node in pairs(tree:Root():GetChildNodes()) do
            if not TacRPCats[node:GetText()] then continue end
            -- Get the subcategories registered in this category
            local catSubcats = Categorised[node:GetText()]
            if not catSubcats then continue end

            -- Overwrite the icon populate function with a custom one
            node.DoPopulate = function(self)
                -- If we've already populated it - forget it.
                if self.PropPanel then return end
                -- Create the container panel
                self.PropPanel = vgui.Create("ContentContainer", pnlContent)
                self.PropPanel:SetVisible(false)
                self.PropPanel:SetTriggerSpawnlistChange(false)

                -- Iterate through the subcategories
                for subcatName, subcatWeps in SortedPairs(catSubcats) do
                    -- Create the subcategory header, if more than one exists for this category
                    if table.Count(catSubcats) > 1 then
                        local label = vgui.Create("ContentHeader", container)
                        label:SetText(string.sub(subcatName, 2))
                        self.PropPanel:Add(label)
                    end

                    -- Create the clickable icon
                    if sortbytiers then
                        table.sort(subcatWeps, function(a, b)
                            if (a.Quality == b.Quality) then
                                return a.PrintName < b.PrintName
                            else
                                return a.Quality < b.Quality
                            end
                        end)
                    else
                        table.SortByMember(subcatWeps, "PrintName")
                    end

                    for _, ent in ipairs(subcatWeps) do
                        spawnmenu.CreateContentIcon("tacrp_weapon", self.PropPanel, {
                            nicename = ent.PrintName or ent.ClassName,
                            spawnname = ent.ClassName,
                            material = ent.IconOverride or "entities/" .. ent.ClassName .. ".png",
                            admin = ent.AdminOnly,
                            quality = ent.Quality
                        })
                    end
                end
            end

            -- If we click on the node populate it and switch to it.
            node.DoClick = function(self)
                self:DoPopulate()
                pnlContent:SwitchPanel(self.PropPanel)
            end
        end

        -- Select the first node
        local FirstNode = tree:Root():GetChildNode(0)

        if IsValid(FirstNode) then
            FirstNode:InternalDoClick()
        end
    end)
end)

local function BuildWeaponCategories()
    local weapons = list.Get("Weapon")
    local Categorised = {}

    -- Build into categories
    for k, weapon in pairs(weapons) do
        if not weapon.Spawnable then continue end
        local Category = weapon.Category or "Other"

        if not isstring(Category) then
            Category = tostring(Category)
        end

        Categorised[Category] = Categorised[Category] or {}
        table.insert(Categorised[Category], weapon)
    end

    return Categorised
end

local function AddCategory(tree, cat)
    local CustomIcons = list.Get("ContentCategoryIcons")
    -- Add a node to the tree
    local node = tree:AddNode(cat, CustomIcons[cat] or "icon16/gun.png")
    tree.Categories[cat] = node

    -- When we click on the node - populate it using this function
    node.DoPopulate = function(self)
        -- If we've already populated it - forget it.
        if IsValid(self.PropPanel) then return end
        -- Create the container panel
        self.PropPanel = vgui.Create("ContentContainer", tree.pnlContent)
        self.PropPanel:SetVisible(false)
        self.PropPanel:SetTriggerSpawnlistChange(false)
        local weps = BuildWeaponCategories()[cat]

        for k, ent in SortedPairsByMemberValue(weps, "PrintName") do
            spawnmenu.CreateContentIcon(ent.ScriptedEntityType or "weapon", self.PropPanel, {
                nicename = ent.PrintName or ent.ClassName,
                spawnname = ent.ClassName,
                material = ent.IconOverride or ("entities/" .. ent.ClassName .. ".png"),
                admin = ent.AdminOnly
            })
        end
    end

    -- If we click on the node populate it and switch to it.
    node.DoClick = function(self)
        self:DoPopulate()
        tree.pnlContent:SwitchPanel(self.PropPanel)
    end

    node.OnRemove = function(self)
        if IsValid(self.PropPanel) then
            self.PropPanel:Remove()
        end
    end

    return node
end

local function AutorefreshWeaponToSpawnmenu(weapon, name)
    local swepTab = g_SpawnMenu.CreateMenu:GetCreationTab("#spawnmenu.category.weapons")
    if not swepTab or not swepTab.ContentPanel or not IsValid(swepTab.Panel) then return end
    local tree = swepTab.ContentPanel.ContentNavBar.Tree
    if not tree.Categories then return end
    local newCategory = weapon.Category or "Other"

    -- Remove from previous category..
    for cat, catPnl in pairs(tree.Categories) do
        if not IsValid(catPnl.PropPanel) then continue end

        for _, icon in pairs(catPnl.PropPanel.IconList:GetChildren()) do
            if icon:GetName() != "ContentIcon" then continue end

            if icon:GetSpawnName() == name then
                local added = false

                if cat == newCategory then
                    -- We already have the new category, just readd the icon here
                    local newIcon = AddWeaponToCategory(catPnl.PropPanel, weapon)
                    newIcon:MoveToBefore(icon)
                    added = true
                end

                icon:Remove()
                if added then return end
            end
        end
        -- Leave the empty categories, this only applies to devs anyway
    end

    -- Weapon changed category...
    if IsValid(tree.Categories[newCategory]) then
        -- Only do this if it is already populated.
        -- If not, the weapon will appear automatically when user clicks on the category
        if IsValid(tree.Categories[newCategory].PropPanel) then
            -- Just append it to the end, heck with the order
            AddWeaponToCategory(tree.Categories[newCategory].PropPanel, weapon)
        end
    else
        AddCategory(tree, newCategory)
    end
end

hook.Add("InitPostEntity", "TacRP_OverrideSpawnmenuReloadSWEP", function()
    hook.Add("PreRegisterSWEP", "spawnmenu_reload_swep", function(weapon, name)
        if not weapon.Spawnable or weapons.IsBasedOn(name, "tacrp_base") then return end

        timer.Simple(0, function()
            AutorefreshWeaponToSpawnmenu(weapon, name)
        end)
    end)
end)