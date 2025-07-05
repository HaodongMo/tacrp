
local fn = "Myriad Pro"--"Bahnschrift"
local sizes = {32, 24, 20, 16, 12}
for i, v in ipairs(sizes) do
	surface.CreateFont( "TacRP_S2_"..v, {
		font = fn,
		size = v,
		weight = 0,
	})
	surface.CreateFont( "TacRP_S2_"..v.."I", {
		font = fn,
		size = v,
		italic = true,
		weight = 0,
	})
end

local function qt( text, font, w, h, alignx, aligny )
	draw.SimpleText( text, font, w-1, h-1, color_black, alignx, aligny )
	draw.SimpleText( text, font, w,   h-1, color_black, alignx, aligny )
	draw.SimpleText( text, font, w+1, h-1, color_black, alignx, aligny )

	draw.SimpleText( text, font, w-1, h, color_black, alignx, aligny )
	draw.SimpleText( text, font, w+1, h, color_black, alignx, aligny )

	draw.SimpleText( text, font, w-1, h+1, color_black, alignx, aligny )
	draw.SimpleText( text, font, w,   h+1, color_black, alignx, aligny )
	draw.SimpleText( text, font, w+1, h+1, color_black, alignx, aligny )

	draw.SimpleText( text, font, w, h, color_white, alignx, aligny )
end

local rtc = {
	["Value"]			= Color( 109,		101,	101 ),
	["Consumer"]		= Color( 99,		143,	188 ),
	["Security"]		= Color( 144,		95,		223 ),
	["Operator"]		= Color( 220,		107,	157 ),
	["Elite"]			= Color( 255,		77,		77 ),
	["Special"]			= Color( 155,		126,	110 ),
}

local filtergroups = {
	["tacrp"] = {
		Name = "Tactical Intervention",
		SortOrder = 1,
		Filters = {}
	},
	["extras"] = {
		Name = "TacRP Extras",
		SortOrder = 2,
		Filters = {
			"tacrp_ex_",
			"tacrp_civ_",
			"tacrp_ar15",
			"tacrp_ks23"
		},
	},
	["interops"] = {
		Name = "Interops",
		SortOrder = 3,
		Filters = {
			"tacrp_io_",
		},
	},
	["armaliterevolution"] = {
		Name = "ArmaLite Revolution",
		SortOrder = 4,
		Filters = {
			"tacrp_ar_"
		},
	},
	["specialdelivery"] = {
		Name = "Special Delivery",
		SortOrder = 5,
		Filters = {
			"tacrp_sd_"
		},
	},
	["bruteforce"] = {
		Name = "Brute Force",
		SortOrder = 6,
		Filters = {
			"tacrp_m_"
		},
	},
	["ironcurtain"] = {
		Name = "Iron Curtain",
		SortOrder = 7,
		Filters = {
			"tacrp_ak_"
		},
	},
	["heavyduty"] = {
		Name = "Heavy Duty",
		SortOrder = 8,
		Filters = {
			"tacrp_h_"
		},
	},
	["exoops"] = {
		Name = "Exo-ops",
		SortOrder = 9,
		Filters = {
			"tacrp_eo_"
		},
	},
	["postapocolypse"] = {
		Name = "Post-apocolypse",
		SortOrder = 10,
		Filters = {
			"tacrp_pa_"
		},
	},
}

local filtergrades = {
	["1Elite"] = true,
	["2Operator"] = true,
	["3Security"] = true,
	["4Consumer"] = true,
	["5Value"] = true,
}


function PropPanel_PaintOver(self, w, h)
    if not vgui.GetHoveredPanel() then return end
    if not vgui.GetHoveredPanel().S2 then return end

    local ent = vgui.GetHoveredPanel().S2
    local todo = DisableClipping(true)
    local rx, ry = self:CursorPos()
    rx = rx + 20
    ry = ry + 20

    local SUPERGAP = 4
    SUPERGAP = SUPERGAP + 20
    SUPERGAP = SUPERGAP + 16
    -- SUPERGAP = SUPERGAP + 14
    SUPERGAP = SUPERGAP + 4

    local drawbar = false
    if ent.WepTable.ClipSize > 0 then
        SUPERGAP = SUPERGAP + 9
        SUPERGAP = SUPERGAP + 16
        drawbar = true
    end
    if ent.WepTable.Trivia_Caliber then
        SUPERGAP = SUPERGAP + 9
        SUPERGAP = SUPERGAP + 16
        drawbar = true
    end
    if ent.WepTable.Trivia_Manufacturer then
        SUPERGAP = SUPERGAP + 9
        SUPERGAP = SUPERGAP + 16
        drawbar = true
    end
    if ent.WepTable.Trivia_Year then
        SUPERGAP = SUPERGAP + 9
        SUPERGAP = SUPERGAP + 16
        drawbar = true
    end
    if drawbar then
        SUPERGAP = SUPERGAP + 2 + 4
    end

    surface.SetDrawColor( 0, 0, 0, 200 )
    surface.DrawRect( rx, ry, 220, SUPERGAP )

    local SUPERGAP = 4

    qt( ent.PrintName, "TacRP_S2_24", rx+8, ry+SUPERGAP )
    SUPERGAP = SUPERGAP + 20

    local translated_SubCatType = string.sub(TacRP:TryTranslate(ent.WepTable.SubCatType), 2)
    if TacRP.UseTiers() and ent.WepTable.SubCatTier and ent.WepTable.SubCatTier != "9Special" then
        translated_SubCatType = TacRP:GetPhrase("cust.type_tier", {tier = string.sub(TacRP:TryTranslate(ent.WepTable.SubCatTier), 2), type = translated_SubCatType})
    end
    qt( translated_SubCatType, "TacRP_S2_16", rx+8+4, ry+SUPERGAP )
    SUPERGAP = SUPERGAP + 16

    -- qt( ent.ClassName, "TacRP_S2_12", rx+8+4, ry+SUPERGAP )
    -- SUPERGAP = SUPERGAP + 14

    local SI = 8

    if drawbar then
        SUPERGAP = SUPERGAP + 2
        surface.SetDrawColor( 0, 0, 0, 255 )
        surface.DrawRect( rx+SI, ry+SUPERGAP, 220-SI-SI+1+1, 3 )

        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.DrawRect( rx+SI+1, ry+SUPERGAP+1, 220-SI-SI, 1 )

        SUPERGAP = SUPERGAP + 4
    end

    if ent.WepTable.ClipSize > 0 then
        qt( "Capacity", "TacRP_S2_12", rx+8, ry+SUPERGAP )
        SUPERGAP = SUPERGAP + 9
        qt( ent.WepTable.ClipSize .. (ent.WepTable.ClipSize==1 and " round" or " rounds"), "TacRP_S2_16", rx+8+4, ry+SUPERGAP )
        SUPERGAP = SUPERGAP + 16
    end

    if ent.WepTable.Trivia_Caliber then
        qt( "Caliber", "TacRP_S2_12", rx+8, ry+SUPERGAP )
        SUPERGAP = SUPERGAP + 9
        qt( ent.WepTable.Trivia_Caliber, "TacRP_S2_16", rx+8+4, ry+SUPERGAP )
        SUPERGAP = SUPERGAP + 16
    end

    if ent.WepTable.Trivia_Manufacturer then
        qt( "Manufacturer", "TacRP_S2_12", rx+8, ry+SUPERGAP )
        SUPERGAP = SUPERGAP + 9
        qt( ent.WepTable.Trivia_Manufacturer, "TacRP_S2_16", rx+8+4, ry+SUPERGAP )
        SUPERGAP = SUPERGAP + 16
    end

    if ent.WepTable.Trivia_Year then
        qt( "Production Year", "TacRP_S2_12", rx+8, ry+SUPERGAP )
        SUPERGAP = SUPERGAP + 9
        qt( ent.WepTable.Trivia_Year, "TacRP_S2_16", rx+8+4, ry+SUPERGAP )
        SUPERGAP = SUPERGAP + 16
    end
    DisableClipping(todo)
end

local filteredicon_col = Color( 0, 0, 0, 63 )
local filtered_col = Color( 61, 51, 51, 63 )

hook.Add("PopulateWeapons", "zzz_TacRP_SubCategories", function(pnlContent, tree, anode)
	local cvar = TacRP.ConVars["spawnmenu_subcats"]:GetInt()
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
			weapon.WepTable = WepTable
			
			for _, v in pairs( list.Get( "NPCUsableWeapons" ) ) do
				if ( v.class == weapon.ClassName ) then
					weapon.IsNPCWeapon = true
					break
				end
			end

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
		local IconCache = {}

		-- Iterate through each category in the weapons table
		for _, node in pairs(tree:Root():GetChildNodes()) do
			if !TacRPCats[node:GetText()] then continue end

			local SPECIALMODE = (node:GetText() == "Tactical RP (Special)")

			-- Get the subcategories registered in this category
			local catSubcats = Categorised[node:GetText()]

			if !catSubcats then continue end
			node.DoPopulate = function(self)
				if (self.GodPanel) then return end

				self.GodPanel = vgui.Create("DPanel", pnlContent)
				function self.GodPanel:Paint(w, h)
				end

				self.FilterBar = vgui.Create("DPanel", self.GodPanel)
				self.FilterBar:Dock(TOP)
				self.FilterBar:SetTall(20)
				function self.FilterBar:Paint() return end

				self.Filter_TextEntry = vgui.Create("DTextEntry", self.FilterBar)
				self.Filter_TextEntry:Dock(FILL)
				self.Filter_TextEntry:SetPlaceholderText("Filter...")
				local TextInEntry = false

				-- Create the container panel
				self.PropPanel = vgui.Create("DScrollPanel", self.GodPanel)
				self.PropPanel:Dock(FILL)

				local enabled = {}
				for i, v in pairs(filtergroups) do
					enabled[i] = true
				end

				local enabled_grades = {}
				for i, v in pairs(filtergrades) do
					enabled_grades[i] = true
				end

				local function filtered( class, s2 )
					local tval = self.Filter_TextEntry:GetValue():lower()
					if TextInEntry and tval != "" then
						if string.find(class:lower(), tval, nil, true) or string.find(s2.WepTable.PrintName:lower(), tval, nil, true) or (s2.WepTable.AbbrevName and string.find(s2.WepTable.AbbrevName:lower(), tval, nil, true)) then
							return false
						else
							return true
						end
					end
					local From = "tacrp"
					if !SPECIALMODE then
						for FilterName, _ in pairs(filtergrades) do
							if !enabled_grades[FilterName] and FilterName == s2.WepTable.SubCatTier then
								return true
							end
						end
					end
					for FilterName, FilterData in pairs(filtergroups) do
						for _, ToFilter in ipairs(FilterData.Filters) do
							if class:Left(#ToFilter) == ToFilter then
								From = FilterName
								break
							end
						end
					end
					for FilterName, FilterData in pairs(filtergroups) do
						if !enabled[FilterName] and From == FilterName then
							return true
						end
					end
					return false
				end

				self.Filter_Options = vgui.Create("DButton", self.FilterBar)
				self.Filter_Options:Dock(RIGHT)
				self.Filter_Options:DockMargin( 5, 0, 0, 0 )
				self.Filter_Options:SetText("Filter")

				local AllButtons = {}
				local AllCategories = {}
				local HideIcon = false

				local function UpdateAll()
					for i, v in ipairs(AllCategories) do
						v.ItemCountFiltered = 0
					end
					for i, v in ipairs(AllButtons) do
						local Filtered = !filtered( v.S2.ClassName, v.S2 )
						v:SetVisible( (TextInEntry and Filtered) or (HideIcon and Filtered) or (!TextInEntry and !HideIcon and true) )
						if Filtered then
							v.Grid.Cate.ItemCountFiltered = v.Grid.Cate.ItemCountFiltered + 1
						end
					end
					for i, v in ipairs(AllCategories) do
						local anyonevisible = false
						for i, v in ipairs( v.Grid:GetChildren() ) do
							if v:IsVisible() then anyonevisible = true break end
						end
						v:SetVisible( anyonevisible )
					end
					self.PropPanel:InvalidateChildren( true )
				end

				function self.Filter_Options:DoClick()
					local Menu = DermaMenu()
						for filter_id, data in SortedPairsByMemberValue(filtergroups, "SortOrder") do
							local opt = Menu:AddOption( data.Name )
							opt:SetIsCheckable(true)
							opt.m_bChecked = (enabled[filter_id] or false)
							function opt:OnChecked( value )
								enabled[filter_id] = value
								UpdateAll()
							end
						end
						if !SPECIALMODE then
							Menu:AddSpacer()
							for gradename, _ in SortedPairs(filtergrades) do
								local opt = Menu:AddOption( gradename:Right(-2) )
								opt:SetIsCheckable(true)
								opt.m_bChecked = (enabled_grades[gradename] or false)
								function opt:OnChecked( value )
									enabled_grades[gradename] = value
									UpdateAll()
								end
							end
						end
						Menu:AddSpacer()
						local opt = Menu:AddOption("Hide Filtered")
						opt:SetIsCheckable(true)
						opt.m_bChecked = (HideIcon or false)
						function opt:OnChecked( value )
							HideIcon = value
							UpdateAll()
						end
					Menu:Open()
				end
				
				self.Filter_TextEntry:SetUpdateOnType(true)
				function self.Filter_TextEntry:OnValueChange(value)
					TextInEntry = value and (value!="")
					UpdateAll()
				end

                self.PropPanel.PaintOver = PropPanel_PaintOver

				--self.PropPanel:SetVisible(false)
				--self.PropPanel:SetTriggerSpawnlistChange(false)

				-- Iterate through the subcategories
				for subcatName, subcatWeps in SortedPairs(catSubcats) do

					local grid
					-- Create the subcategory header, if more than one exists for this category
					if (table.Count(catSubcats) > 1) then
						local label = vgui.Create("DCollapsibleCategory", container)
						label.TypeName = string.sub(subcatName, 2)
						label:SetLabel("")
						label:Dock(TOP)
						label:DockMargin( 0, 0, 5, 0 )
						label.Header:SetTall( 32+5 )
						label.ItemCount = 0

						table.insert( AllCategories, label )

						function label:Paint(w, h)
							surface.SetFont("TacRP_S2_32I")
							local tns = surface.GetTextSize( self.TypeName )
							surface.SetDrawColor( 0, 0, 0, 200 )
							surface.DrawRect( 0, 2, 4+tns+4+4, 32 )
			
							qt( self.TypeName, "TacRP_S2_32I", 4, 2 )

							local additional = ""
							if self.ItemCountFiltered and self.ItemCountFiltered > 0 and self.ItemCount != self.ItemCountFiltered then
								additional = " -- " .. self.ItemCountFiltered .. " shown"
							end
							qt( self.ItemCount .. " total" .. additional, "TacRP_S2_20I", 4 + tns + 4 + 4 + 4, 2 + 16, nil, TEXT_ALIGN_CENTER )
						end
						grid = vgui.Create("DGrid", label)
						grid:Dock( TOP )
						grid:SetCols( 4 )
						grid:SetColWide( 150+5 )
						grid:SetRowHeight( 75+5 )

						label.Grid = grid
						grid.Cate = label

						local ccatp = label.PerformLayout
						function label:PerformLayout(w, h)
							ccatp(label, w, h)
							grid:SetCols( math.floor(self:GetWide()/(150+5)) )
						end

						self.PropPanel:Add(label)
					else
						continue
					end

					local easystyle = {}

					for _, ent in SortedPairsByMemberValue(subcatWeps, "PrintName") do
						table.insert( easystyle, ent )
					end

					if TacRP.UseTiers() then
						table.sort( easystyle, function( a, b )
							local t_a, t_b = a.WepTable.SubCatTier:Left(1), b.WepTable.SubCatTier:Left(1)
							if t_a < t_b then
								return true
							elseif t_a > t_b then
								return false
							else
								return ((a.PrintName) < (b.PrintName))
							end
						end)
					end

					-- Create the clickable icon
					for _, ent in ipairs(easystyle) do
						local weapon = vgui.Create("DButton")
						weapon:SetSize( 150, 75 )
						grid:AddItem(weapon)
						grid.Cate.ItemCount = grid.Cate.ItemCount + 1
						table.insert( AllButtons, weapon )
						weapon.S2 = ent
						weapon.Grid = grid

						local Text_Name = ent.PrintName
						local Text_Color = rtc[ent.WepTable.SubCatTier:Right(-2)] or color_white
						--do
						--	local h,s,v = ColorToHSV( Text_Color )
						--	s = s * 0.75
						--	Text_Color = HSVToColor( h,s,v )
						--end
						local Text_Faction = ent.WepTable.Faction

						function weapon:Paint(w, h)
							local filtered = filtered( ent.ClassName, ent )
							if filtered then
								surface.SetDrawColor( filtered_col )
							elseif TacRP.UseTiers() then
								surface.SetDrawColor( Text_Color.r, Text_Color.g, Text_Color.b, 255 )
							else
								surface.SetDrawColor( 255, 255, 255, 32 )
							end
							surface.SetMaterial(Material("vgui/gradient-u", "mips smooth"))
							surface.DrawTexturedRect( 0, 0, w, h )

							surface.SetDrawColor( filtered and filteredicon_col or color_white )
							if !IconCache[ent.ClassName] then
								IconCache[ent.ClassName] = Material( ent.IconOverride or "entities/" .. ent.ClassName .. ".png" )
							end
							local themat = IconCache[ent.ClassName]
							surface.SetMaterial( themat, "mips smooth" )
						
							local blep = h*2
							surface.DrawTexturedRect( w/2 - blep/2, h/2 - blep/2, blep, blep )
		
							surface.SetFont("TacRP_S2_16")
							local tns = surface.GetTextSize(Text_Name)
							surface.SetDrawColor( 0, 0, 0, filtered and 100 or 200 )
							surface.DrawRect( 0, h - 20, 4+tns+4, 20 )
						
							-- name
							qt( Text_Name, "TacRP_S2_16", 4, h-20+1 )
		
							return true
						end
						
						function weapon:DoClick()
							RunConsoleCommand( "gm_giveswep", ent.ClassName )
							surface.PlaySound( "tacrp/weapons/c4/detonator_press.wav" )
						end

						function weapon:DoMiddleClick()
							RunConsoleCommand( "gm_spawnswep", ent.ClassName )
							surface.PlaySound( "tacrp/weapons/c4/detonator_press.wav" )
						end

						function weapon:DoRightClick()
							local menu = DermaMenu()
								menu:AddOption( "#spawnmenu.menu.copy", function() SetClipboardText( ent.ClassName ) end ):SetIcon( "icon16/page_copy.png" )
								if ( isfunction( self.OpenMenuExtra ) ) then
									self:OpenMenuExtra( menu )
								end
								menu:AddOption( "#spawnmenu.menu.spawn_with_toolgun", function() RunConsoleCommand( "gmod_tool", "creator" ) RunConsoleCommand( "creator_type", "3" ) RunConsoleCommand( "creator_name", ent.ClassName ) end ):SetIcon( "icon16/brick_add.png" )
								if ( ent.IsNPCWeapon ) then
									local opt = menu:AddOption( "#spawnmenu.menu.use_as_npc_gun", function() RunConsoleCommand( "gmod_npcweapon", ent.ClassName ) end )
									if ( ent.ClassName == GetConVarString( "gmod_npcweapon" ) ) then
										opt:SetIcon( "icon16/monkey_tick.png" )
									else
										opt:SetIcon( "icon16/monkey.png" )
									end
								end
							menu:Open()
						end

					end
				end
			end

			-- If we click on the node populate it and switch to it.
			node.DoClick = function(self)
				self:DoPopulate()
				pnlContent:SwitchPanel(self.GodPanel)
			end
		end

		-- Select the first node
		local FirstNode = tree:Root():GetChildNode(0)
		if (IsValid(FirstNode)) then
			FirstNode:InternalDoClick()
		end
	end)
end)