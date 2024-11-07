hook.Add("PopulateWeapons", "zzz_TacRP_SubCategories", function(pnlContent, tree, anode)

    local cvar = TacRP.ConVars["subcats"]:GetInt()
    if cvar == 0 then return end

    timer.Simple(0, function()
        -- Loop through the weapons and add them to the menu
        local Weapons = list.Get("Weapon")
        local Categorised = {}
        local TacRPCats = {}

        -- Build into categories + subcategories
        for k, weapon in pairs(Weapons) do
            if !weapon.Spawnable then continue end
            if !weapons.IsBasedOn(k, "tacrp_base") then continue end

            -- Get the weapon category as a string
            local Category = weapon.Category or "Other2"
            local WepTable = weapons.Get(weapon.ClassName)
            if (!isstring(Category)) then
                Category = tostring(Category)
            end

            -- Get the weapon subcategory as a string
            local SubCategory = "Other"
            if cvar == 2 then
                if (WepTable != nil && WepTable.SubCatTier != nil) then
                    SubCategory = WepTable.SubCatTier
                    if SubCategory == "9Special" then
                        SubCategory = WepTable.SubCatType
                    end
                    if (!isstring(SubCategory)) then
                        SubCategory = tostring(SubCategory)
                    end
                end
            elseif cvar == 1 then
                if (WepTable != nil && WepTable.SubCatType != nil) then
                    SubCategory = WepTable.SubCatType
                    if (!isstring(SubCategory)) then
                        SubCategory = tostring(SubCategory)
                    end
                end
            end

            -- Insert it into our categorised table
            Categorised[Category] = Categorised[Category] or {}
            Categorised[Category][SubCategory] = Categorised[Category][SubCategory] or {}
            table.insert(Categorised[Category][SubCategory], weapon)
            TacRPCats[Category] = true
        end

        -- Iterate through each category in the weapons table
        for _, node in pairs(tree:Root():GetChildNodes()) do

            if !TacRPCats[node:GetText()] then continue end

            -- Get the subcategories registered in this category
            local catSubcats = Categorised[node:GetText()]

            if !catSubcats then continue end

            -- Overwrite the icon populate function with a custom one
            node.DoPopulate = function(self)

                -- If we've already populated it - forget it.
                if (self.PropPanel) then return end

                -- Create the container panel
                self.PropPanel = vgui.Create("ContentContainer", pnlContent)
                self.PropPanel:SetVisible(false)
                self.PropPanel:SetTriggerSpawnlistChange(false)

                -- Iterate through the subcategories
                for subcatName, subcatWeps in SortedPairs(catSubcats) do

                    -- Create the subcategory header, if more than one exists for this category
                    if (table.Count(catSubcats) > 1) then
                        local label = vgui.Create("ContentHeader", container)
                        label:SetText(string.sub(subcatName, 2))
                        self.PropPanel:Add(label)
                    end

                    -- Create the clickable icon
                    for _, ent in SortedPairsByMemberValue(subcatWeps, "PrintName") do
                        spawnmenu.CreateContentIcon(ent.ScriptedEntityType or "weapon", self.PropPanel, {
                            nicename  = ent.PrintName or ent.ClassName,
                            spawnname = ent.ClassName,
                            material  = ent.IconOverride or "entities/" .. ent.ClassName .. ".png",
                            admin     = ent.AdminOnly
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
        if (IsValid(FirstNode)) then
            FirstNode:InternalDoClick()
        end
    end)
end)



local function BuildWeaponCategories()
    local weapons = list.Get( "Weapon" )
    local Categorised = {}

    -- Build into categories
    for k, weapon in pairs( weapons ) do

        if ( !weapon.Spawnable ) then continue end

        local Category = weapon.Category or "Other"
        if ( !isstring( Category ) ) then Category = tostring( Category ) end

        Categorised[ Category ] = Categorised[ Category ] or {}
        table.insert( Categorised[ Category ], weapon )

    end

    return Categorised
end

local function AddCategory( tree, cat )
    local CustomIcons = list.Get( "ContentCategoryIcons" )

    -- Add a node to the tree
    local node = tree:AddNode( cat, CustomIcons[ cat ] or "icon16/gun.png" )
    tree.Categories[ cat ] = node

    -- When we click on the node - populate it using this function
    node.DoPopulate = function( self )

        -- If we've already populated it - forget it.
        if ( IsValid( self.PropPanel ) ) then return end

        -- Create the container panel
        self.PropPanel = vgui.Create( "ContentContainer", tree.pnlContent )
        self.PropPanel:SetVisible( false )
        self.PropPanel:SetTriggerSpawnlistChange( false )

        local weps = BuildWeaponCategories()[ cat ]
        for k, ent in SortedPairsByMemberValue( weps, "PrintName" ) do

            spawnmenu.CreateContentIcon( ent.ScriptedEntityType or "weapon", self.PropPanel, {
                nicename	= ent.PrintName or ent.ClassName,
                spawnname	= ent.ClassName,
                material	= ent.IconOverride or ( "entities/" .. ent.ClassName .. ".png" ),
                admin		= ent.AdminOnly
            } )

        end

    end

    -- If we click on the node populate it and switch to it.
    node.DoClick = function( self )

        self:DoPopulate()
        tree.pnlContent:SwitchPanel( self.PropPanel )

    end

    node.OnRemove = function( self )

        if ( IsValid( self.PropPanel ) ) then self.PropPanel:Remove() end

    end

    return node
end

hook.Add("InitPostEntity", "TacRP_OverrideSpawnmenuReloadSWEP", function()
    hook.Add( "PreRegisterSWEP", "spawnmenu_reload_swep", function( weapon, name )
        if !weapon.Spawnable or weapons.IsBasedOn(name, "tacrp_base") then return end
        timer.Simple( 0, function() AutorefreshWeaponToSpawnmenu( weapon, name ) end )
    end )
end)