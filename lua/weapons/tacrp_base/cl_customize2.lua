
local s = ScreenScaleH
local fn = "Myriad Pro"--"Bahnschrift"
local sizes = {36, 18, 16, 14, 12, 10, 8, 6}
for i, v in ipairs(sizes) do
	surface.CreateFont( "TacRP_C2_"..v, {
		font = fn,
		size = s(v),
		weight = 0,
	})
	surface.CreateFont( "TacRP_C2_"..v.."I", {
		font = fn,
		size = s(v),
		italic = true,
		weight = 0,
	})
end

local cb = Color( 0, 0, 0, 127 )
local dCol = Color( 200, 200, 200 )

local COLOR_POSITIVE = Color( 120, 255, 120 )
local COLOR_NEGATIVE = Color( 255, 200, 200 )

local function genselecta( c, host, slotnum, slottab )
	if IsValid(selecta) then selecta:Remove() end
	local s = c.s
	selecta = vgui.Create( "DFrame" )
	selecta:SetSize( s(180), s(380) )
	selecta:Center()
	selecta:MakePopup()
	selecta:SetKeyboardInputEnabled( false )
	function selecta:Paint( w, h )
		return true
	end

	local sp = selecta:Add("DScrollPanel")
	sp:Dock( FILL )

	local atts = TacRP.GetAttsForCats( slottab.Category or "", c.w )

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

	for _, att in pairs( atts ) do
		local ati = TacRP.GetAttTable( att )
		local button = sp:Add( "DButton" )
		button:SetSize( 0, s(48) )
		button:Dock( TOP )
		button:DockMargin( 0, 0, 0, s(4) )
		function button:Paint( w, h )
			surface.SetDrawColor( cb )
			surface.DrawRect( 0, 0, w, h )
			surface.SetDrawColor( color_white )
			surface.DrawOutlinedRect( 0, 0, w, h, s(1) )
			draw.SimpleText( TacRP:TryTranslate( ati.PrintName ), "TacRP_C2_12", s(6), s(6), color_white )
			if slottab.Installed == att then
				draw.SimpleText( "installed", "TacRP_C2_10", s(6), s(2), color_white )
			end

			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( ati.Icon )
			surface.DrawRect( w-h-s(4), 0, h, h )
			surface.DrawTexturedRect( w-h-s(4), 0, h, h )
			return true
		end

		function button:DoClick()
			if slottab.Installed then
				if slottab.Installed == att then
					c.w:Detach( slotnum )
				else
					c.w:Detach( slotnum, true, true )
					c.w:Attach( slotnum, att )
				end
			else
				c.w:Attach( slotnum, att )
			end
			host:InvalidateLayout()
			selecta:Remove()
		end

		function button:DoRightClick()
			if slottab.Installed == att then
				c.w:Detach( slotnum )
				host:InvalidateLayout()
				selecta:Remove()
			end
		end

	end
end

local function rt( fu, w, h )
	surface.SetDrawColor( 0, 0, 0, 63 )
	surface.DrawRect( 0, 0, w, h )
	return true
end

local weh = {
	["Manufacturer"] = "Trivia_Manufacturer",
	["Production Year"] = "Trivia_Year",
	["Faction"] = function( w )
		return (TacRP:GetPhrase(TacRP.FactionToPhrase[w:GetValue("Faction")]))
	end,
}

local function DST( text, font, x, y, color, drop, xalign, yalign )
	draw.SimpleText( text, font, x, y+drop, color_black, xalign, yalign )
	return draw.SimpleText( text, font, x, y, color, xalign, yalign )
end

local grad = Material("vgui/gradient-d")
local grad2 = Material("vgui/gradient-u")

local GLEEDARKTH = HSVToColor( 0, 0, 0.25 )
GLEEDARKTH.a = 0.50*255
local GLEEDARKTX = HSVToColor( 0, 0, 0.25 )
GLEEDARKTX.a = 0.25*255

local GLEEC1 = HSVToColor( 100, 0.2, 1 )
GLEEC1.a = 4
local GLEEC2 = HSVToColor( 100, 0.4, 1 )
GLEEC2.a = 10
local GLEEDARK2 = HSVToColor( 0, 0, 0.5 )

local GLEEDARK4 = HSVToColor( 0, 0, 0.9 )
local GLEEDARK5 = HSVToColor( 0, 0, 1 )

local c_1_h = CreateClientConVar( "tacrp_c2_1_h", 20, true, false )
local c_1_s = CreateClientConVar( "tacrp_c2_1_s", 0.4, true, false )
local c_1_v = CreateClientConVar( "tacrp_c2_1_v", 1, true, false )
local c_1_a = CreateClientConVar( "tacrp_c2_1_a", (1/32), true, false )

local c_2_h = CreateClientConVar( "tacrp_c2_2_h", 20, true, false )
local c_2_s = CreateClientConVar( "tacrp_c2_2_s", 0.6, true, false )
local c_2_v = CreateClientConVar( "tacrp_c2_2_v", 1, true, false )
local c_2_a = CreateClientConVar( "tacrp_c2_2_a", (1/32), true, false )

local c_2_gd = CreateClientConVar( "tacrp_c2_graddown", 0, true, false )

function C2_UpdateColors()
	GLEEC1 = HSVToColor( c_1_h:GetFloat(), c_1_s:GetFloat(), c_1_v:GetFloat() )
	GLEEC1.a = c_1_a:GetFloat()*255
	
	GLEEC2 = HSVToColor( c_2_h:GetFloat(), c_2_s:GetFloat(), c_2_v:GetFloat() )
	--GLEEC2 = HSVToColor( ((CurTime()*360)-180)%360, 1, 1 )
	GLEEC2.a = c_2_a:GetFloat()*255
end

function C2_PaintBox( s, w, h )
	GEM( s, 0, 0, w, h )
end
Gleemax = C2_PaintBox

function C2_Outline( x, y, w, h )
	surface.SetDrawColor( 255, 255, 255 )
	surface.DrawRect( x, y, w, 1 )
	surface.SetMaterial( grad2 )
	surface.DrawTexturedRect( x, y, 1, h )
	surface.DrawTexturedRect( x+w-1, y, 1, h )
end

function C2_FullBox( s, x, y, w, h )
	surface.SetDrawColor( GLEEC1 )
	surface.DrawRect( x, y, w, h )
	surface.SetDrawColor( GLEEC2 )
	surface.SetMaterial( (c_2_gd:GetBool() and grad2) or grad )
	surface.DrawTexturedRect( x, y, w, h )

	C2_Outline( x, y, w, h )
end
GEM = C2_FullBox

-- local cb = Color( 0, 0, 0, 127 )
-- function GEM( s, x, y, w, h )
--     surface.SetDrawColor( cb )
--     return TacRP.DrawCorneredBox( x, y, w, h, color_white )
-- end


function qd( s, t, f, x, y, c, ax, ay )
	draw.SimpleText( t, f, x, y+1, GLEEDARKTH, ax, ay )
	draw.SimpleText( t, f, x+1, y+1, GLEEDARKTH, ax, ay )
	draw.SimpleText( t, f, x+1, y+2, GLEEDARKTH, ax, ay )

	draw.SimpleText( t, f, x-1, y, GLEEDARKTX, ax, ay )
	draw.SimpleText( t, f, x-1, y-1, GLEEDARKTX, ax, ay )
	draw.SimpleText( t, f, x+1, y-1, GLEEDARKTX, ax, ay )

	draw.SimpleText( t, f, x+2, y+2, GLEEDARKTX, ax, ay )
	draw.SimpleText( t, f, x+2, y, GLEEDARKTX, ax, ay )

	draw.SimpleText( t, f, x, y, c, ax, ay )
end


function qRect( x, y, ax, ay, c )
	surface.SetDrawColor( GLEEDARKTX )
	surface.DrawRect( x, y+1, ax, ay )
	surface.DrawRect( x+1, y+1, ax, ay )
	surface.DrawRect( x+1, y+2, ax, ay )

	surface.DrawRect( x-1, y, ax, ay )
	surface.DrawRect( x-1, y-1, ax, ay )
	surface.DrawRect( x+1, y-1, ax, ay )

	surface.DrawRect( x+2, y+2, ax, ay )
	surface.DrawRect( x+2, y, ax, ay )

	surface.SetDrawColor( c )
	surface.DrawRect( x, y, ax, ay )
end

local function updatestat(self, i, k)
	if k.ConVarCheck then
		if !k.ConVar then k.ConVar = GetConVar(k.ConVarCheck) end
		if k.ConVar:GetBool() == tobool(k.ConVarInvert) then return end
	end

	if k.Spacer then
		self.MiscCache["statbox"][i] = {}
		return
	end
	local value = self:GetValue(k.Value)
	local orig = self:GetBaseValue(k.Value)
	local diff = nil

	if k.HideIfSame and orig == value then return end
	if k.DefaultValue != nil and value == k.DefaultValue and orig == k.DefaultValue then return end

	if k.ValueCheck and self:GetValue(k.ValueCheck) != !k.ValueInvert then
		return
	end

	local stat_base = 0
	local stat_curr = 0

	if k.AggregateFunction then
		stat_base = k.AggregateFunction(self, true, orig)
		stat_curr = k.AggregateFunction(self, false, value)
	else
		stat_base = math.Round(orig, 4)
		stat_curr = math.Round(value, 4)
	end

	if stat_base == nil and stat_cur == nil then return end

	if k.DifferenceFunction then
		diff = k.DifferenceFunction(self, orig, value)
	elseif isnumber(stat_base) and isnumber(stat_curr) then
		if stat_curr == stat_base then
			diff = ""
		else
			diff = math.Round((stat_curr / stat_base - 1) * 100)
			if diff > 0 then
				diff = "+" .. tostring(diff) .. "%"
			else
				diff = tostring(diff) .. "%"
			end
		end
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

	if k.DisplayFunction then
		txt_base = k.DisplayFunction(self, true, orig)
		txt_curr = k.DisplayFunction(self, false, value)
	end

	if k.Unit then
		local unit = TacRP:TryTranslate(k.Unit)
		txt_base = txt_base .. unit
		txt_curr = txt_curr .. unit
	end

	local good = false
	local goodorbad = false

	if k.BetterFunction then
		goodorbad, good = k.BetterFunction(self, orig, value)
	elseif stat_base != stat_curr then
		if isnumber(stat_curr) then
			good = stat_curr > stat_base
			goodorbad = true
		elseif isbool(stat_curr) then
			good = !stat_base and stat_curr
			goodorbad = true
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
	else
		surface.SetTextColor(255, 255, 255)
	end

	self.MiscCache["statbox"][i] = {txt_base, txt_curr, goodorbad, good, diff}
end


local pages = {
	{
		Name = "Customize",
		Initialize = function( page, par, c )
			local s = c.s

			local p_left = page:Add( "DPanel" )
			p_left:SetTall( par:GetTall() )
			p_left:SetWide( par:GetWide() )
			p_left:SetMouseInputEnabled( true )
			p_left.Paint = rt
			local gapper = s(24+90+48+24)--+32+24+24)
			function p_left:Paint( w, h )
				-- surface.SetDrawColor( 25, 0, 0, 127 )
				-- surface.DrawRect( 0, 0, gapper, h )
				return true
			end
			function p_left:Think()
				p_left:SetX( page.SlidePer * (gapper or self:GetWide()) )
			end

			local slotlist = {}
			local slotlistt = {}
			for slotnum, slottab in ipairs( c.w.Attachments ) do
				local slot = p_left:Add( "DButton" )
				slotlist[slotnum] = slot
				slotlistt[slotnum] = slottab
				slot:SetSize( s(90), 0 )
				slot:SetPos( s(24), 0 )

				function slot:Paint( w, h )
					local ins = slottab.Installed
					surface.SetDrawColor( cb )
					surface.DrawRect( 0, 0, w, h )
					surface.SetDrawColor( color_white )
					surface.DrawOutlinedRect( 0, 0, w, h, s(1) )

					draw.SimpleText( slottab.PrintName, "TacRP_C2_12I", s(10), s(ins and 4 or 2), color_white )
					local tx = surface.GetTextSize( slottab.PrintName )
					if ins then
						surface.SetDrawColor( color_white )
						surface.DrawRect( s(11), s(15), tx, s(1) )
						local ati = TacRP.GetAttTable( ins )
						local attname = "none"
						if ati then
							attname = TacRP:TryTranslate( ati.PrintName )
						end
						draw.SimpleText( attname, "TacRP_C2_16", s(10), s(4+(12-2)), color_white )

						surface.SetMaterial( ati.Icon )
						surface.SetDrawColor( 255, 255, 255, 255 )
						surface.DrawTexturedRect( w-h-s(4), 0, h, h )
					end
					return true
				end

				function slot:DoRightClick()
					if slottab.Installed then
						c.w:Detach( slotnum )
						page:InvalidateLayout()
					end
				end

				function slot:DoClick()
					genselecta( c, page, slotnum, slottab )
				end
			end
			function page:PerformLayout()
				local obump = 0
				for i, v in ipairs( slotlist ) do
					local ins = slotlistt[i].Installed
					local tall = ins and s(4+(12-2)+16+2+4) or s(2+(12)+2)
					obump = obump + tall + (i!=#slotlist and s(4) or 0)
				end
				local bump = self:GetTall()/2 - obump/2
				for i, v in ipairs( slotlist ) do
					local ins = slotlistt[i].Installed
					local tall = ins and s(4+(12-2)+16+2+4) or s(2+(12)+2)
					v:SetTall( tall )
					v:SetY( bump )
					v:SetWide( ins and s(90+4+4)+tall+s(4) or s(90) )
					bump = bump + tall + s(4)
				end
			end

			local p_right = page:Add( "DPanel" )
			p_right:SetTall( par:GetTall() )
			p_right:SetWide( s(24+140+24) )
			p_right:SetMouseInputEnabled( true )
			p_right.Paint = rt
			local gapper = s(24+140+24)--+32+24+24)
			function p_right:Paint( w, h )
				--surface.SetDrawColor( 25, 0, 0, 127 )
				--surface.DrawRect( 0, 0, gapper, h )

				return true
			end
			function p_right:Think()
				p_right:SetX( ( (1-page.SlidePer) * (gapper or self:GetWide()) ) + (page:GetWide()-gapper-gapper) )
			end

			local rside = p_right:Add( "DScrollPanel" )
			rside:SetY( s(24) )
			rside:SetTall( par:GetTall() - s(24+24) )
			rside:SetX( s(24) )
			rside:SetWide( s(140) )

			rside.pnlCanvas:DockPadding(1, 1+s(2), 1, s(4))

			rside.VBar:SetWide(4)
			rside.VBar:SetHideButtons(true)

			function rside.VBar:Paint(w, h)
			end
			function rside.VBar.btnGrip:Paint(w, h)
				local todo = DisableClipping( true )
					surface.SetDrawColor( 255, 255, 255 )
					surface.DrawRect( 0, 1, 2, h-2	 )
				DisableClipping( todo )
			end


			function rside:Paint( w, h )
				Gleemax( s, w, h )
			end

			c.w.MiscCache["statbox"] = {}
			c.w.StatRows = {}

			for i, k in ipairs(c.w.StatDisplay) do
				updatestat( c.w, i, k )
			end
			
			--if !c.w.MiscCache["statbox"] then
			----	populate_stats(layout)
			--end

			local Floop = false
			for _, k in ipairs(c.w.StatDisplay) do
				local cache = c.w.MiscCache["statbox"][_]
				if !cache then continue end

				local stat = rside:Add( "DPanel" )
				stat:Dock(TOP)
				stat:SetTall(k.Spacer and s(18) or s(18))
				stat.Floop = Floop
				Floop = !Floop

				function stat:Paint(w, h)
					--surface.SetDrawColor( 0, 0, 0, (self.Floop and 30 or 70) )
					--surface.DrawRect( 0, 0, w, h )
					local tn = TacRP:TryTranslate(k.Name)
					if k.Spacer then
						surface.SetFont("TacRP_C2_16")
						local tns = surface.GetTextSize(tn)
						qRect( s(4), s(15), tns+s(4), s(1), color_white )
						qd( s, tn, k.Spacer and "TacRP_C2_16", k.Spacer and s(4), 0, color_white )
					else
						qd( s, tn, "TacRP_C2_8", s(4+4), 0, color_white )
					end

					if !k.Spacer then
						-- Base Value
						local DifferentValue = cache[2] != cache[1]
						local col = cache[4] and COLOR_POSITIVE or COLOR_NEGATIVE -- Good Change
						if DifferentValue then -- Current Value
							qd( s, cache[2], "TacRP_C2_14", s(4+4+8), s(4), col )
							
							if cache[3] then -- Good Or Bad Change
								if cache[5] then
									surface.SetFont("TacRP_C2_14")
									local tns = surface.GetTextSize(cache[2])
									qd( s, "(" .. cache[5] .. ")", "TacRP_C2_10", s(4+4+8+2)+tns, s(6.5), col )
									local bleh = s(4+4+8+2)+tns
									local tns = surface.GetTextSize("(" .. cache[5] .. ")")
									qd( s, cache[1], "TacRP_C2_10", bleh+s(2)+tns, s(6.5), dCol )
								else
									surface.SetFont("TacRP_C2_14")
									local tns = surface.GetTextSize(cache[2])
									qd( s, cache[1], "TacRP_C2_10", s(4+4+8+2)+tns, s(6.5), dCol )
								end
							end
						else
							qd( s, cache[1], "TacRP_C2_14", s(4+4+8), s(4), color_white )
						end
					end
					return
				end
			end

		end,
		Paint = function( self, w, h, c )
		end,
	},
	--{
	--	Name = "Statistics",
	--	Initialize = function( page, par, c )
	--		local s = c.s
	--	end,
	--	Paint = function( page, w, h, c )
	--		local s = c.s
	--	end,
	--},
	{
		Name = "Information",
		Initialize = function( page, par, c )
			local s = c.s
			
			local p_top = page:Add( "DPanel" )
			p_top:SetTall( par:GetTall() )
			p_top:SetWide( par:GetWide() )
			p_top:SetMouseInputEnabled( true )
			local gapper = s(48+24+24)
			function p_top:Paint( w, h )
				-- surface.SetDrawColor( 25, 0, 0, 127 )
				-- surface.DrawRect( 0, 0, w, gapper )
				return true
			end
			function p_top:Think()
				p_top:SetY( page.SlidePer * (gapper or self:GetTall()) )
			end

			
			local p_bottom = page:Add( "DPanel" )
			p_bottom:SetTall( par:GetTall() )
			p_bottom:SetWide( par:GetWide() )
			p_bottom:SetMouseInputEnabled( true )
			local gapper = s(48+24+24)
			function p_bottom:Paint( w, h )
				--surface.SetDrawColor( 25, 0, 0, 127 )
				--surface.DrawRect( 0, 0, w, gapper )
				return true
			end
			function p_bottom:Think()
				p_bottom:SetY( ( (1-page.SlidePer) * (gapper or self:GetTall()) ) + (page:GetTall()-gapper-gapper) )
			end

			local Margin_3 = 12

			do
				local header = p_top:Add( "DPanel" )
				header:SetSize( c.sw - s(48), s(40) )
				header:SetPos( s(24), s(24) )

				function header:Paint( w, h )
					Gleemax( s, w, h )

					local type_txt = TacRP.FormatTierType(c.w.SubCatType, c.w.SubCatTier, TacRP.UseTiers())
					qd( s, c.w:GetPrintName(), "TacRP_C2_36", s(Margin_3), h/2, color_white, nil, TEXT_ALIGN_CENTER )
					qd( s, type_txt, "TacRP_C2_12", w - s(Margin_3), h/2 - s(6), color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
					qd( s, c.w:GetValue("Trivia_Caliber"), "TacRP_C2_12", w - s(Margin_3), h/2 + s(6), color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )

					return true
				end
			end

			do
				local footer = p_bottom:Add( "DPanel" )
				local f_w, f_h = s(400), s(12+(12*1)+12)
				footer:SetSize( f_w, f_h )
				footer:SetPos( page:GetWide()/2 - f_w/2, f_h - s(12) )

				local tabz = {
					{ "Description" },
					{ "Trivia" },
					{ "Credits" },
				}

				for index, Taby in ipairs( tabz ) do
					tb = p_bottom:Add( "DButton" )
					Taby.Panel = tb
					tb:SetSize( s(48), s(12) )
					tb:SetPos( page:GetWide()/2 - f_w/2 + math.ceil( s((index-1))*(48+1)), 0 )
					function tb:Paint( w, h )
						Gleemax( s, w, h )
						qd( s, Taby[1], "TacRP_C2_10", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
						return true
					end

				end

				function footer:Paint( w, h )
					Gleemax( s, w, h )

					local desc = TacRP.MultiLineText( c.w.Description, w - s(12*2), "TacRP_C2_12" )

					local lines = 0
					for i, v in ipairs( desc ) do
						qd( s, v, "TacRP_C2_12", s(12), s(6+(12*(i-1))), color_white )
						lines = i
					end
					qd( s, c.w.Description_Quote, "TacRP_C2_12I", s(12), s(6+(12*(lines+1))), color_white )
				end

				function footer:PerformLayout( w, h )
					local desc = TacRP.MultiLineText( c.w.Description, w - s(12*2), "TacRP_C2_12" )
					local lines = #desc
					if c.w.Description_Quote then lines = lines + 2 end
					f_h = s(6+(12*lines)+6)

					self:SetSize( f_w, f_h )
					self:SetPos( page:GetWide()/2 - f_w/2, s(1+12) )
					gapper = f_h+s(1+12+6)
				end
			end

			do
				local footer = p_bottom:Add( "DPanel" )
				footer:Hide()
				local f_w, f_h = page:GetWide()/2 - s(400)/2 - s(24+12), s(4+(12*3)+4)
				footer:SetSize( f_w, f_h )
				footer:SetPos( s(24), c.sh - f_h - s(12) )
				function footer:Paint( w, h )
					Gleemax( s, w, h )

					local bump = 0
					for i, v in pairs( weh ) do
						qd( s, i, "TacRP_C2_10", s(8), s(12+4)+bump, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
						local txt = isfunction(v) and v(c.w) or c.w:GetValue(v) or "?"
						local ftu = "TacRP_C2_12"
						surface.SetFont(ftu)
						local tx = surface.GetTextSize(txt)
						if tx > s(180-8-8-64) then
							ftu = "TacRP_C2_10"
						end
						qd( s, txt, ftu, w-s(8), s(12+4)+bump, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
						bump = bump + s(12)
					end
				end
			end

			do
				local footer = p_bottom:Add( "DPanel" )
				footer:Hide()
				local multiline = TacRP.MultiLineText( c.w.Credits, math.huge, "TacRP_C2_12" )
				if multiline[#multiline] == " " then
					multiline[#multiline] = nil
				end
				local f_w, f_h = page:GetWide()/2 - s(400)/2 - s(24+12), s(4+(12*(#multiline))+4)
				footer:SetSize( f_w, f_h )
				footer:SetPos( c.sw - f_w - s(24), c.sh - f_h - s(12) )
				function footer:Paint( w, h )
					Gleemax( s, w, h )

					for i, line in ipairs( multiline ) do
						-- If you can find out how to do this with Lua Patterns, that'd be nice.
						local mweh = string.Explode( ": ", line )
						local reassemble = ""
						for i, v in ipairs( mweh ) do
							if i==1 then continue end
							if i!=2 then
								reassemble = reassemble .. ": "
							end
							reassemble = reassemble .. v
						end
						local ftu = "TacRP_C2_12"
						surface.SetFont(ftu)
						local tx = surface.GetTextSize(reassemble)
						if tx > (w-s(4+4+32)) then
							ftu = "TacRP_C2_10"
						end
						qd( s, mweh[1], "TacRP_C2_10", s(4), s(4+(i)*12), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
						qd( s, reassemble, ftu, w-s(4), s(4+(i)*12), color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
					end
				end
			end
		end,
		Paint = function( self, w, h, c )
		end,
	},
	{
		Name = "Terminal Effect",
		Initialize = function( page, par, c )
			local s = c.s

			local p_top = page:Add( "DPanel" )
			p_top:SetTall( par:GetTall() )
			p_top:SetWide( par:GetWide() )
			p_top:SetMouseInputEnabled( true )
			p_top.Paint = rt
			local gapper = s(24+64+24)--+32+24+24)
			function p_top:Paint( w, h )
				surface.SetDrawColor( 25, 0, 0, 32 )
				surface.DrawRect( 0, 0, w, gapper )
				return true
			end
			function p_top:Think()
				p_top:SetY( page.SlidePer * (gapper or self:GetTall()) )
			end

			do
				local header = p_top:Add( "DPanel" )
				header:SetSize( c.sw-s(48), s(64) )
				header:SetPos( s(24), s(24) )

				function header:Paint( w, h )
					Gleemax( s, w, h )

					qd( s, "DAMAGE AT RANGE", "TacRP_C2_10", s(4), s(4), color_white )

					return true
				end
			end
		end,
		Paint = function( page, w, h, c )
		end,
	},
	--[[ {
		Name = "Newsletter",
		Initialize = function( page, par, c )
		end,
		Paint = function( page, w, h, c )
			local s = c.s
			local h = math.ceil( Lerp(1+page.SlidePer, -s(20), h/2) )
			DST( "Newsletter panel goes here.", "TacRP_C2_36", w/2, h, color_white, s(1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end,
	}, ]]
	{
		Name = "Inspect",
		Initialize = function( page, par, c )
		end,
		Paint = function( page, w, h, c )
			local s = c.s
		end,
	},
}

local uio = Material( "uio/shadow.png", "" )

local c2_Currentpage = 1
local c2_Desire = 1

function SWEP:C2_Open()
	if IsValid( c2 ) then c2:Remove() end
	local s = ScreenScaleH
	local sw, sh = ScrW(), ScrH()
	c2 = vgui.Create( "DFrame" )
	c2:SetSize( sw, sh )
	c2:Center()
	c2:MakePopup()
	c2:SetPopupStayAtBack( true )
	c2:SetKeyboardInputEnabled( false )
	c2:ShowCloseButton( false )
	c2.btnMaxim:SetVisible( false )
	c2.btnMinim:SetVisible( false )
	c2.lblTitle:SetVisible( false )

	c2.TFrom = 0
	c2.TTo = c2_Desire
	c2.Prog = 0
	c2.Lastdesire = c2_Desire

	local p = LocalPlayer()
	local w = self

	function c2:Paint( w, h )
		return
	end

	function c2:OnRemove()
		if IsValid( selecta ) then selecta:Remove() end
		if IsValid(w) and TacRP.ConVars["autosave"]:GetBool() and TacRP.ConVars["free_atts"]:GetBool() then
			w:SavePreset()
		end
	end
	if !IsValid(p) then
		print("TACRP C2: the LocalPlayer is invalid")
		c2:Remove()
		return
	end
	if !IsValid(w) then
		print("TACRP C2: the weapon is invalid")
		c2:Remove()
		return
	end

	-- Back and forth
	for i=1, 2 do
		local mbutton = c2:Add("DButton")
		mbutton:SetSize( s(20), sh*(0.7) )
		mbutton:SetPos( i==2 and math.ceil( sw-s(20) ), sh*(1-0.7)/2 )
		mbutton:SetText( "MEOW" )
		function mbutton:DoClick()
			c2_Desire = math.Clamp( c2_Desire+(i==1 and -1 or 1), 1, #pages )
		end
		mbutton.Glow = 0
		function mbutton:Paint( w, h )
			surface.SetDrawColor( 255, 255, 255, self.Glow*127 )
			surface.DrawRect( 0, 0, w, h )
			return true
		end
		function mbutton:Think()
			self.Glow = math.Approach( self.Glow, self:IsHovered() and 1 or 0, FrameTime()/0.1 )
		end
	end

	-- Close button
	do
		local cl = c2:Add("DButton")
		cl:SetSize( s(12), s(12) )
		cl:SetPos( sw - s(24+12), s(24/2 - 12/2) )
		function cl:DoClick()
			-- Customizing is a predicted bind.
			-- Consider if you really want it to.
			c2:Remove()
		end
		function cl:Paint( w, h )
			Gleemax( s, w, h )
			qd( s, "×", "TacRP_C2_12", w/2 - s(0.5), h/2 - s(1.5), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			return true
		end
	end

	-- Drop Weapon
	do
		local cl = c2:Add("DButton")
		cl:SetSize( s(58), s(12) )
		cl:SetPos( sw - s(24+12+4+58), s(24/2 - 12/2) )
		function cl:DoClick()
			RunConsoleCommand("tacrp_drop")
			c2:Remove()
		end
		function cl:Paint( w, h )
			Gleemax( s, w, h )
			qd( s, "Drop Weapon", "TacRP_C2_10", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			return true
		end
	end
	-- Tabs row
	local totallength = s((#pages*80)+(#pages-1)*4)
	for i, v in ipairs( pages ) do
		local mbutton = c2:Add("DButton")
		mbutton:SetSize( s(80), s(16) )
		--mbutton:SetPos( sw/2 - totallength/2 + s((i-1)*(72+4)), s(24/2 - 18/2) )
		mbutton:SetPos( s(24) + s((i-1)*(80+4)), s(24/2 - 16/2) )
		mbutton:SetText( v.Name )
		function mbutton:DoClick()
			c2_Desire = i
		end
		function mbutton:Paint( w, h )
			Gleemax( s, w, h )
			
			qd( s, i, "TacRP_C2_10", s(3), s(1), color_white )
			qd( s, v.Name, "TacRP_C2_12", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

			if i == c2.TTo then
				local olda = GLEEC2.a
				GLEEC2.a = 255
				surface.SetDrawColor( GLEEC2 )
				GLEEC2.a = olda
				surface.SetMaterial( grad )
				local cons = math.ceil(s(2))
				surface.DrawTexturedRect( 0, h-cons, w, cons )
			end
			return true
		end
	end

	-- Generate pages
	c2.Pages = {}
	for i, v in ipairs( pages ) do
		local page = c2:Add( "DPanel" )
		page:SetSize( sw, sh )
		page:MoveToBack()

		page.Num = i
		c2.Pages[i] = page

		v.Initialize( page, c2, { w=w, s=s, sw=sw, sh=sh } )

		function page:Paint( w, h )
			--surface.SetDrawColor( 0, 0, 0, 255 )
			--surface.SetMaterial( uio )
			--surface.DrawTexturedRect( 0, 0, w, h )

			v.Paint( page, w, h, { w=w, s=s, sw=sw, sh=sh } )
			return
		end
	end

	function c2:Think()
		-- checking if the weapon isn't equipped or exists
		if !IsValid(w) then
			print("TACRP C2: the weapon is invalid")
			c2:Remove()
			return
		end
		if p:GetActiveWeapon() != w then
			print("TACRP C2: the weapon isn't equipped")
			c2:Remove()
			return
		end

		C2_UpdateColors()
	
		if c2.Lastdesire != c2_Desire then
			c2.Prog = 0
			c2.TFrom = c2.Lastdesire
			c2.TTo = c2_Desire
			c2.Lastdesire = c2_Desire
		end
		c2.Prog = math.Approach( c2.Prog, 1, FrameTime() / 0.3 )
		local sake = math.ease.OutExpo( c2.Prog )

		for i, v in ipairs( self.Pages ) do
			if i != c2.TFrom and i!= c2.TTo then
				v:Hide()
			end
			if i == c2.TFrom then
				if sake == 1 then
					v:Hide()
				else
					v:Show()
					v.SlidePer = math.Remap( sake, 0, 0.5, 0, 1 )---sake
					v.SlidePer = math.Clamp( v.SlidePer, 0, 1 )
					v.SlidePer = -v.SlidePer
				end
			end
			if i == c2.TTo then
				v:Show()
				v.SlidePer = math.Remap( sake, 0.5, 1, 0, 1 )--sake-1
				v.SlidePer = math.Clamp( v.SlidePer, 0, 1 )
				v.SlidePer = v.SlidePer-1
			end
		end
	end
end
if IsValid( c2 ) then
	c2:Remove()
	c2 = nil
	net.Start("TacRP_togglecustomize")
		net.WriteBool(false)
	net.SendToServer()
	timer.Simple( 0.1, function()
	net.Start("TacRP_togglecustomize")
		net.WriteBool(true)
	net.SendToServer()
	end)
end

function SWEP:C2_Close()
	if IsValid( c2 ) then c2:Remove() return end
end

local blocklist = {
	["slot1"] = 1,
	["slot2"] = 2,
	["slot3"] = 3,
	["slot4"] = 4,
	["slot5"] = 5,
	["slot6"] = 6,
	["slot7"] = 7,
	["slot8"] = 8,
	["slot9"] = 9,
	["slot0"] = 0,
}

hook.Add( "PlayerBindPress", "TacRP_C2_PlayerBindPress", function( ply, bind, pressed )
	if IsValid( c2 ) and blocklist[bind] then
		if pressed and blocklist[bind] >= 1 and blocklist[bind] <= #pages then
			c2_Desire = blocklist[bind]
		end
		return true
	end
end)

local hide = {
    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true,
    ["CHudGMod"] = true,
}

hook.Add("HUDShouldDraw", "TacRP_C2_HideHUD", function(name)
    if !IsValid(LocalPlayer()) then return end

	local p = LocalPlayer()
	local w = p:GetActiveWeapon()
	if IsValid( w ) and w.ArcticTacRP then
	else
		w = false
	end

	if w and w:GetCustomize() then
		if hide[name] then return false end
	end
end)

local pres = {
	["Orange Peel"] = {
		["tacrp_c2_1_h"]	= 0,
		["tacrp_c2_1_s"]	= 0.4,
		["tacrp_c2_1_v"]	= 1,
		["tacrp_c2_1_a"]	= 0.10,
		["tacrp_c2_2_h"]	= 20,
		["tacrp_c2_2_s"]	= 0.6,
		["tacrp_c2_2_v"]	= 1,
		["tacrp_c2_2_a"]	= 0.10,
		["tacrp_c2_graddown"]	= true,
	},
	["Hot Red"] = {
		["tacrp_c2_1_h"]	= 0,
		["tacrp_c2_1_s"]	= 0.8,
		["tacrp_c2_1_v"]	= 1,
		["tacrp_c2_1_a"]	= 0.25,
		["tacrp_c2_2_h"]	= 40,
		["tacrp_c2_2_s"]	= 0.8,
		["tacrp_c2_2_v"]	= 1,
		["tacrp_c2_2_a"]	= 0.25,
		["tacrp_c2_graddown"]	= true,
	},
	["Pretty Fish"] = {
		["tacrp_c2_1_h"]	= 40,
		["tacrp_c2_1_s"]	= 0.8,
		["tacrp_c2_1_v"]	= 1,
		["tacrp_c2_1_a"]	= 0.25,
		["tacrp_c2_2_h"]	= 180,
		["tacrp_c2_2_s"]	= 0.8,
		["tacrp_c2_2_v"]	= 1,
		["tacrp_c2_2_a"]	= 0.25,
		["tacrp_c2_graddown"]	= false,
	},
	["Fresh Vapor"] = {
		["tacrp_c2_1_h"]	= 285,
		["tacrp_c2_1_s"]	= 0.61,
		["tacrp_c2_1_v"]	= 1,
		["tacrp_c2_1_a"]	= 0.1,
		["tacrp_c2_2_h"]	= 200,
		["tacrp_c2_2_s"]	= 0.61,
		["tacrp_c2_2_v"]	= 0.85,
		["tacrp_c2_2_a"]	= 0.2,
		["tacrp_c2_graddown"]	= true,
	},
	["Baby Blue"] = {
		["tacrp_c2_1_h"]	= 180,
		["tacrp_c2_1_s"]	= 0.8,
		["tacrp_c2_1_v"]	= 1,
		["tacrp_c2_1_a"]	= 0.1,
		["tacrp_c2_2_h"]	= 230,
		["tacrp_c2_2_s"]	= 0.8,
		["tacrp_c2_2_v"]	= 1,
		["tacrp_c2_2_a"]	= 0.1,
		["tacrp_c2_graddown"]	= false,
	},
	["Dark Dashboard"] = {
		["tacrp_c2_1_h"]	= 180,
		["tacrp_c2_1_s"]	= 0.8,
		["tacrp_c2_1_v"]	= 1,
		["tacrp_c2_1_a"]	= 0.01,
		["tacrp_c2_2_h"]	= 230,
		["tacrp_c2_2_s"]	= 0.8,
		["tacrp_c2_2_v"]	= 1,
		["tacrp_c2_2_a"]	= 0.1,
		["tacrp_c2_graddown"]	= false,
	},
	["Dew Green"] = {
		["tacrp_c2_1_h"]	= 200,
		["tacrp_c2_1_s"]	= 0.4,
		["tacrp_c2_1_v"]	= 0.5,
		["tacrp_c2_1_a"]	= 0.2,
		["tacrp_c2_2_h"]	= 80,
		["tacrp_c2_2_s"]	= 0.6,
		["tacrp_c2_2_v"]	= 0.5,
		["tacrp_c2_2_a"]	= 0.2,
		["tacrp_c2_graddown"]	= false,
	},
	["Grass Blade"] = {
		["tacrp_c2_1_h"]	= 98,
		["tacrp_c2_1_s"]	= 0.47,
		["tacrp_c2_1_v"]	= 1,
		["tacrp_c2_1_a"]	= 0.1,
		["tacrp_c2_2_h"]	= 80,
		["tacrp_c2_2_s"]	= 0.6,
		["tacrp_c2_2_v"]	= 1,
		["tacrp_c2_2_a"]	= 0.05,
		["tacrp_c2_graddown"]	= false,
	},
	["Soft Pink"] = {
		["tacrp_c2_1_h"]	= 360,
		["tacrp_c2_1_s"]	= 0.3,
		["tacrp_c2_1_v"]	= 1,
		["tacrp_c2_1_a"]	= 0.07,
		["tacrp_c2_2_h"]	= 304,
		["tacrp_c2_2_s"]	= 0.4,
		["tacrp_c2_2_v"]	= 1,
		["tacrp_c2_2_a"]	= 0.07,
		["tacrp_c2_graddown"]	= false,
	},
	["Cookie Cream"] = {
		["tacrp_c2_1_h"]	= 0,
		["tacrp_c2_1_s"]	= 0.0,
		["tacrp_c2_1_v"]	= 0.0,
		["tacrp_c2_1_a"]	= 0.5,
		["tacrp_c2_2_h"]	= 43,
		["tacrp_c2_2_s"]	= 0.2,
		["tacrp_c2_2_v"]	= 1,
		["tacrp_c2_2_a"]	= 0.0,
		["tacrp_c2_graddown"]	= true,
	},
}

hook.Add( "PopulateToolMenu", "CustomMenuSettings", function()
	spawnmenu.AddToolMenuOption( "Options", "Tactical RP Weapons", "TacRP_C2", "Beta: Customize 2", "", "", function( panel )
		panel:Help("Presets")
		local pcom = vgui.Create( "DComboBox", panel )
		pcom:Dock(TOP)
		pcom:DockMargin( 10, 5, 10, 5 )
		for i, data in SortedPairs( pres ) do
			pcom:AddChoice( i )
		end

		function pcom:OnSelect( bleh, index )
			if pres[index] then
				for i, v in pairs( pres[index] ) do
					if v == true or v == false then
						GetConVar(i):SetBool(v)
					else
						GetConVar(i):SetFloat(v)
					end
				end
			end
		end

		panel:Help("Main Color")
		panel:NumSlider( "Main Hue", "tacrp_c2_1_h", 0, 360, 0 )
		panel:NumSlider( "Main Sat.", "tacrp_c2_1_s", 0, 1, 2 )
		panel:NumSlider( "Main Value", "tacrp_c2_1_v", 0, 1, 2 )
		panel:NumSlider( "Main Alpha", "tacrp_c2_1_a", 0, 1, 2 )
		
		panel:Help("Accent Color")
		panel:CheckBox( "Top-down Gradient", "tacrp_c2_graddown" )
		panel:NumSlider( "Accent Hue", "tacrp_c2_2_h", 0, 360, 0 )
		panel:NumSlider( "Accent Sat.", "tacrp_c2_2_s", 0, 1, 2 )
		panel:NumSlider( "Accent Value", "tacrp_c2_2_v", 0, 1, 2 )
		panel:NumSlider( "Accent Alpha", "tacrp_c2_2_a", 0, 1, 2 )
	end )
	spawnmenu.AddToolMenuOption( "Options", "Tactical RP Weapons", "TacRP_H2", "Beta: HUD 2", "", "", function( panel )
		panel:CheckBox( "Enable HUD", "tacrp_h2" )
	end )
end )