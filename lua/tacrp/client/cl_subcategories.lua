
local fn = "Myriad Pro"--"Bahnschrift"
local sizes = {32, 24, 16, 12}
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
	["Consumer"]		= Color( 99,		133,	188 ),
	["Security"]		= Color( 144,		95,		223 ),
	["Operator"]		= Color( 220,		107,	157 ),
	["Elite"]			= Color( 255,		77,		77 ),
	["Special"]			= Color( 155,		126,	110 ),
}

local filtergroups = {
	{
		["Name"] = "Tactical Intervention",
		["Filters"] = {
			"tacrp_"
		},
	},
	{
		["Name"] = "TacRP Extras",
		["Filters"] = {
			"tacrp_ex_"
		},
	},
	{
		["Name"] = "Interops",
		["Filters"] = {
			"tacrp_io_",
		},
	},
	{
		["Name"] = "ArmaLite Revolution",
		["Filters"] = {
			"tacrp_ar_"
		},
	},
	{
		["Name"] = "Special Delivery",
		["Filters"] = {
			"tacrp_sd_"
		},
	},
	{
		["Name"] = "Iron Curtain",
		["Filters"] = {
			"tacrp_ak_"
		},
	},
	{
		["Name"] = "Heavy Duty",
		["Filters"] = {
			"tacrp_h_"
		},
	},
	{
		["Name"] = "Exo-ops",
		["Filters"] = {
			"tacrp_eo_"
		},
	},
	{
		["Name"] = "Post-apocolypse",
		["Filters"] = {
			"tacrp_h_"
		},
	},
}

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

		-- Iterate through each category in the weapons table
		for _, node in pairs(tree:Root():GetChildNodes()) do
			if !TacRPCats[node:GetText()] then continue end

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

				self.Filter_TextEntry = vgui.Create("DTextEntry", self.FilterBar)
				self.Filter_TextEntry:Dock(FILL)

				self.Filter_Options = vgui.Create("DButton", self.FilterBar)
				self.Filter_Options:Dock(RIGHT)

				function self.Filter_Options:DoClick()
					local Menu = DermaMenu()
						for i, v in ipairs(filtergroups) do
							local opt = Menu:AddOption( v.Name )
							opt:SetIsCheckable(true)
						end
					Menu:Open()
				end

				-- Create the container panel
				self.PropPanel = vgui.Create("DScrollPanel", self.GodPanel)
				self.PropPanel:Dock(FILL)

				function self.PropPanel:PaintOver(w, h)
					if vgui.GetHoveredPanel() and vgui.GetHoveredPanel().S2 then
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

							local LongLongMan = TacRP:TryTranslate(ent.WepTable.SubCatType)
							if TacRP.UseTiers() and ent.WepTable.SubCatTier and ent.WepTable.SubCatTier != "9Special" then
								LongLongMan = TacRP:GetPhrase("cust.type_tier", {tier = TacRP:TryTranslate(ent.WepTable.SubCatTier), type = LongLongMan})
							end
							qt( LongLongMan, "TacRP_S2_16", rx+8+4, ry+SUPERGAP )
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
				end
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

						function label:Paint(w, h)
							surface.SetFont("TacRP_S2_32I")
							local tns = surface.GetTextSize( self.TypeName )
							surface.SetDrawColor( 0, 0, 0, 200 )
							surface.DrawRect( 0, 2, 4+tns+4+4, 32 )
			
							qt( self.TypeName, "TacRP_S2_32I", 4, 2 )
						end
						grid = vgui.Create("DGrid", label)
						grid:Dock( TOP )
						grid:SetCols( 4 )
						grid:SetColWide( 150+5 )
						grid:SetRowHeight( 75+5 )

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
						weapon.S2 = ent

						local Text_Name = ent.PrintName
						local Text_Color = rtc[ent.WepTable.SubCatTier:Right(-2)] or color_white
						--do
						--	local h,s,v = ColorToHSV( Text_Color )
						--	s = s * 0.75
						--	Text_Color = HSVToColor( h,s,v )
						--end
						local Text_Faction = ent.WepTable.Faction

						function weapon:Paint(w, h)
							if TacRP.UseTiers() then
								surface.SetDrawColor( Text_Color.r, Text_Color.g, Text_Color.b, 255 )
								surface.SetMaterial(Material("vgui/gradient-u", "mips smooth"))
								surface.DrawTexturedRect( 0, 0, w, h )
							else
								surface.SetDrawColor( 255, 255, 255, 32 )
								surface.DrawRect( 0, 0, w, h )
							end

							surface.SetDrawColor( 255, 255, 255 )
							local themat = Material( ent.IconOverride or "entities/" .. ent.ClassName .. ".png" )
							surface.SetMaterial( themat, "mips smooth" )
						
							local blep = h*2
							surface.DrawTexturedRect( w/2 - blep/2, h/2 - blep/2, blep, blep )
		
							surface.SetFont("TacRP_S2_16")
							local tns = surface.GetTextSize(Text_Name)
							surface.SetDrawColor( 0, 0, 0, 200 )
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