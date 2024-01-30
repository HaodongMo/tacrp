
local fn = "Myriad Pro"--"Bahnschrift"
surface.CreateFont( "C2_1", {
	font = fn,
	size = ScreenScaleH(36),
	weight = 0,
})
surface.CreateFont( "C2_2", {
	font = fn,
	size = ScreenScaleH(18),
	weight = 0,
})
surface.CreateFont( "C2_3", {
	font = fn,
	size = ScreenScaleH(12),
	weight = 0,
})
surface.CreateFont( "C2_3I", {
	font = fn,
	size = ScreenScaleH(12),
	italic = true,
	weight = 0,
})
surface.CreateFont( "C2_4", {
	font = fn,
	size = ScreenScaleH(10),
	weight = 0,
})
surface.CreateFont( "C2_5A", {
	font = fn,
	size = ScreenScaleH(12),
	weight = 0,
	italic = true,
})
surface.CreateFont( "C2_5B", {
	font = fn,
	size = ScreenScaleH(16),
	weight = 0,
})

local cb = Color( 0, 0, 0, 127 )

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

	local atts = TacRP.GetAttsForCats( slottab.Category or "" )

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
			draw.SimpleText( TacRP:TryTranslate( ati.PrintName ), "C2_3", s(6), s(6), color_white )
			if slottab.Installed == att then
				draw.SimpleText( "installed", "C2_4", s(6), s(2), color_white )
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

					draw.SimpleText( slottab.PrintName, "C2_5A", s(10), s(ins and 4 or 2), color_white )
					local tx = surface.GetTextSize( slottab.PrintName )
					if ins then
						surface.SetDrawColor( color_white )
						surface.DrawRect( s(11), s(15), tx+s(0), s(1) )
						local ati = TacRP.GetAttTable( ins )
						local attname = "none"
						if ati then
							attname = TacRP:TryTranslate( ati.PrintName )
						end
						draw.SimpleText( attname, "C2_5B", s(10), s(4+(12-2)), color_white )

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
		end,
		Paint = function( self, w, h, c )
		end,
	},
	{
		Name = "Statistics",
		Initialize = function( page, par, c )
		end,
		Paint = function( page, w, h, c )
			local s = c.s
			draw.SimpleText( "Statistics panel goes here.", "C2_1", w/2 + s(1), h/2 + s(1), color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( "Statistics panel goes here.", "C2_1", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end,
	},
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
			--p_top:Hide()

			
			local p_bottom = page:Add( "DPanel" )
			p_bottom:SetTall( par:GetTall() )
			p_bottom:SetWide( par:GetWide() )
			p_bottom:SetMouseInputEnabled( true )
			local gapper = s(48+24+24)
			function p_bottom:Paint( w, h )
				-- surface.SetDrawColor( 25, 0, 0, 127 )
				-- surface.DrawRect( 0, h-gapper, w, gapper )
				return true
			end
			function p_bottom:Think()
				p_bottom:SetY( ( (1-page.SlidePer) * (gapper or self:GetTall()) ) - gapper )
			end


			do
				local header = p_top:Add( "DPanel" )
				header:SetSize( c.sw - s(48), s(48) )
				header:SetPos( s(24), s(24) )

				function header:Paint( w, h )
					surface.SetDrawColor( cb )
					surface.DrawRect( 0, 0, w, h )
					surface.SetDrawColor( color_black )
					surface.DrawOutlinedRect( 0, 0, w, h, s(1) )

					DST( c.w:GetPrintName(), "C2_1", s(24), s(6), color_white, s(2) )
					DST( c.w:GetSubClassName(TacRP.UseTiers()), "C2_2", w - s(24), s(6), color_white, s(1), TEXT_ALIGN_RIGHT )
					DST( c.w:GetValue("Trivia_Caliber"), "C2_2", w - s(24), s(6+18), color_white, s(1), TEXT_ALIGN_RIGHT )

					return true
				end
			end

			do
				local footer = p_bottom:Add( "DPanel" )
				local f_w, f_h = s(400), s(12+(12*1)+12)
				footer:SetSize( f_w, f_h )
				footer:SetPos( page:GetWide()/2 - f_w/2, page:GetTall() - f_h - s(12) )
				function footer:Paint( w, h )
					surface.SetDrawColor( cb )
					surface.DrawRect( 0, 0, w, h )
					surface.SetDrawColor( color_black )
					surface.DrawOutlinedRect( 0, 0, w, h, s(1) )

					local desc = TacRP.MultiLineText( c.w.Description, w - s(48), "C2_3" )

					local lines = 0
					for i, v in ipairs( desc ) do
						draw.SimpleText( v, "C2_3", s(24), s(12+(12*(i-1))+1), color_black )
						draw.SimpleText( v, "C2_3", s(24), s(12+(12*(i-1))), color_white )
						lines = i
					end
					draw.SimpleText( c.w.Description_Quote, "C2_3I", s(24), s(12+(12*(lines+1))+1), color_black )
					draw.SimpleText( c.w.Description_Quote, "C2_3I", s(24), s(12+(12*(lines+1))), color_white )
				end

				function footer:PerformLayout( w, h )
					local desc = TacRP.MultiLineText( c.w.Description, w - s(48), "C2_3" )
					local lines = #desc
					if c.w.Description_Quote then lines = lines + 2 end
					f_h = s(12+(12*lines)+12)

					self:SetSize( f_w, f_h )
					self:SetPos( page:GetWide()/2 - f_w/2, page:GetTall() - f_h - s(12) )
					gapper = f_h+s(12+12)
				end
			end

			do
				local footer = p_bottom:Add( "DPanel" )
				local f_w, f_h = page:GetWide()/2 - s(400)/2 - s(24+12), s(4+(12*3)+4)
				footer:SetSize( f_w, f_h )
				footer:SetPos( s(24), c.sh - f_h - s(12) )
				function footer:Paint( w, h )
					surface.SetDrawColor( cb )
					surface.DrawRect( 0, 0, w, h )
					surface.SetDrawColor( color_black )
					surface.DrawOutlinedRect( 0, 0, w, h, s(1) )

					local bump = 0
					for i, v in pairs( weh ) do
						DST( i, "C2_4", s(8), s(12+4)+bump, color_white, s(1), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
						local txt = isfunction(v) and v(c.w) or c.w:GetValue(v) or "?"
						local ftu = "C2_3"
						surface.SetFont(ftu)
						local tx = surface.GetTextSize(txt)
						if tx > s(180-8-8-64) then
							ftu = "C2_4"
						end
						DST( txt, ftu, w-s(8), s(12+4)+bump, color_white, s(1), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
						bump = bump + s(12)
					end
				end
			end

			do
				local footer = p_bottom:Add( "DPanel" )
				local multiline = TacRP.MultiLineText( c.w.Credits, math.huge, "C2_3" )
				if multiline[#multiline] == " " then
					multiline[#multiline] = nil
				end
				local f_w, f_h = page:GetWide()/2 - s(400)/2 - s(24+12), s(4+(12*(#multiline))+4)
				footer:SetSize( f_w, f_h )
				footer:SetPos( c.sw - f_w - s(24), c.sh - f_h - s(12) )
				function footer:Paint( w, h )
					surface.SetDrawColor( cb )
					surface.DrawRect( 0, 0, w, h )
					surface.SetDrawColor( color_black )
					surface.DrawOutlinedRect( 0, 0, w, h, s(1) )

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
						local ftu = "C2_3"
						surface.SetFont(ftu)
						local tx = surface.GetTextSize(reassemble)
						if tx > (w-s(4+4+32)) then
							ftu = "C2_4"
						end
						DST( mweh[1], "C2_4", s(4), s(4+(i)*12), color_white, s(1), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
						DST( reassemble, ftu, w-s(4), s(4+(i)*12), color_white, s(1), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
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
		end,
		Paint = function( page, w, h, c )
			local s = c.s
			local h = math.ceil( Lerp(1+page.SlidePer, -s(20), h/2) )
			DST( "Terminal Effect panel goes here.", "C2_1", w/2, h, color_white, s(1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end,
	},
	{
		Name = "Newsletter",
		Initialize = function( page, par, c )
		end,
		Paint = function( page, w, h, c )
			local s = c.s
			local h = math.ceil( Lerp(1+page.SlidePer, -s(20), h/2) )
			DST( "Newsletter panel goes here.", "C2_1", w/2, h, color_white, s(1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end,
	},
	{
		Name = "Inspect",
		Initialize = function( page, par, c )
		end,
		Paint = function( page, w, h, c )
			local s = c.s
			local h = math.ceil( Lerp(1+page.SlidePer, -s(20), h/2) )
			DST( "Inspect panel goes here.", "C2_1", w/2, h, color_white, s(1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end,
	},
}

local uio = Material( "uio/shadow.png", "" )



local c2_Currentpage = 3
local c2_Desire = 3

if IsValid( c2 ) then c2:Remove() end
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
			surface.SetDrawColor( color_black )
			surface.DrawRect( 0, 0, w, h )
			surface.SetDrawColor( color_white )
			surface.DrawOutlinedRect( 0, 0, w, h, s(1) )
			
			draw.SimpleText( "x", "C2_4", w/2, h/2 - s(1), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
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
			surface.SetDrawColor( color_black )
			surface.DrawRect( 0, 0, w, h )
			surface.SetDrawColor( color_white )
			surface.DrawOutlinedRect( 0, 0, w, h, s(1) )
			
			draw.SimpleText( "Drop Weapon", "C2_4", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			return true
		end
	end
	-- Tabs row
	local totallength = s((#pages*72)+(#pages-1)*4)
	for i, v in ipairs( pages ) do
		local mbutton = c2:Add("DButton")
		mbutton:SetSize( s(72), s(18) )
		--mbutton:SetPos( sw/2 - totallength/2 + s((i-1)*(72+4)), s(24/2 - 18/2) )
		mbutton:SetPos( s(24) + s((i-1)*(72+4)), s(24/2 - 18/2) )
		mbutton:SetText( v.Name )
		function mbutton:DoClick()
			c2_Desire = i
		end
		function mbutton:Paint( w, h )
			surface.SetDrawColor( color_black )
			surface.DrawRect( 0, 0, w, h )
			surface.SetDrawColor( color_white )
			surface.DrawOutlinedRect( 0, 0, w, h, s(1) )
			
			draw.SimpleText( i, "C2_4", s(3), s(1), color_white )
			draw.SimpleText( v.Name, "C2_4", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
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