
surface.CreateFont( "C2_1", {
	font = "Bahnschrift",
	size = ScreenScaleH(36),
	weight = 0,
})
surface.CreateFont( "C2_2", {
	font = "Bahnschrift",
	size = ScreenScaleH(18),
	weight = 0,
})
surface.CreateFont( "C2_3", {
	font = "Bahnschrift",
	size = ScreenScaleH(12),
	weight = 0,
})
surface.CreateFont( "C2_3I", {
	font = "Bahnschrift",
	size = ScreenScaleH(12),
	italic = true,
	weight = 0,
})
surface.CreateFont( "C2_4", {
	font = "Bahnschrift",
	size = ScreenScaleH(8),
	weight = 0,
})

local pages = {
	{
		Name = "Customize",
		Initialize = function( self, par, c )
		end,
		Paint = function( self, w, h, c )
		end,
	},
	{
		Name = "Statistics",
		Initialize = function( self, par, c )
		end,
		Paint = function( self, w, h, c )
		end,
	},
	{
		Name = "Inspect",
		Initialize = function( self, par, c )
		end,
		Paint = function( self, w, h, c )
		end,
	},
	{
		Name = "Information",
		Initialize = function( self, par, c )
			local header = self:Add( "DPanel" )
			local s = c.s
			header:SetSize( c.sw - s(48), s(48) )
			header:SetPos( s(24), s(24) )

			function header:Paint( w, h )
				surface.SetDrawColor( color_black )
				surface.DrawRect( 0, 0, w, h )

				draw.SimpleText( "Walther PPK", "C2_1", s(24), s(6), color_white )
				local ts = surface.GetTextSize( "Walther PPK" )
				draw.SimpleText( "Handgun", "C2_2", w - s(24), s(6), color_white, TEXT_ALIGN_RIGHT )
				draw.SimpleText( ".380 ACP", "C2_2", w - s(24), s(6+18), color_white, TEXT_ALIGN_RIGHT )
				return
			end

			local footer = self:Add( "DPanel" )
			local f_w, f_h = s(400), s(12+(12*4)+12)
			footer:SetSize( f_w, f_h )
			footer:SetPos( self:GetWide()/2 - f_w/2, self:GetTall() - f_h - s(12) )
			function footer:Paint( w, h )
				surface.SetDrawColor( color_black )
				surface.DrawRect( 0, 0, w, h )

				draw.SimpleText( "This gun was used by Louis de Francis XXIV.", "C2_3", s(24), s(12), color_white )
				draw.SimpleText( "It fires at 1,200,000 rounds per minute.", "C2_3", s(24), s(12+(12*1)), color_white )
				draw.SimpleText( "'Mucho bueno.'", "C2_3I", s(24), s(12+(12*3)), color_white )
			end
		end,
		Paint = function( self, w, h, c )
		end,
	},
	{
		Name = "Terminal Effect",
		Initialize = function( self, par, c )
		end,
		Paint = function( self, w, h, c )
		end,
	},
	{
		Name = "Newsletter",
		Initialize = function( self, par, c )
		end,
		Paint = function( self, w, h, c )
		end,
	},
}

local uio = Material( "uio/shadow.png", "" )

function SWEP:C2_Open()
	if IsValid( c2 ) then c2:Remove() return end
	local s = ScreenScaleH
	local sw, sh = ScrW(), ScrH()
	c2 = vgui.Create( "DFrame" )
	c2:SetSize( sw, sh )
	c2:Center()
	c2:MakePopup()
	c2:SetKeyboardInputEnabled( false )
	c2.btnMaxim:SetVisible( false )
	c2.btnMinim:SetVisible( false )
	c2.lblTitle:SetVisible( false )

	function c2:Paint( w, h )
		return
	end


	local p = LocalPlayer()
	local w = self
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

	c2.Currentpage = 4
	c2.Desire = 4

	c2.Pages = {}

	for i, v in ipairs( pages ) do
		local mbutton = c2:Add("DButton")
		mbutton:SetSize( s(64), s(14) )
		mbutton:SetPos( s(24)+s((i-1)*(64+4)), s(6) )
		mbutton:SetText( v.Name )
		function mbutton:DoClick()
			c2.Desire = i
		end
		function mbutton:Paint( w, h )
			surface.SetDrawColor( color_black )
			surface.DrawRect( 0, 0, w, h )
			surface.SetDrawColor( color_white )
			surface.DrawOutlinedRect( 0, 0, w, h, s(1) )
			
			draw.SimpleText( v.Name, "C2_4", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			return true
		end

		local page = c2:Add( "DPanel" )
		page:SetSize( sw, sh )
		page:MoveToBack()

		page.Num = i
		c2.Pages[i] = page

		v.Initialize( page, c2, { s=s, sw=sw, sh=sh } )

		function page:Paint( w, h )
			surface.SetDrawColor( 0, 0, 0, 255 )
			surface.SetMaterial( uio )
			surface.DrawTexturedRect( 0, 0, w, h )
			-- surface.SetDrawColor( 0, 0, 0, 222 )
			-- surface.DrawOutlinedRect( 0, 0, w, h, s(16) )

			v.Paint( page, w, h, { s=s, sw=sw, sh=sh } )
			return
		end

		-- local label = page:Add( "DButton" )
		-- label:SetSize( s(120), s(30) )
		-- label:SetText( v.Name )
		-- label:Center()
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
	
		if input.IsKeyDown( KEY_1 ) then
			self.Desire = 1
		elseif input.IsKeyDown( KEY_2 ) then
			self.Desire = 2
		elseif input.IsKeyDown( KEY_3 ) then
			self.Desire = 3
		elseif input.IsKeyDown( KEY_4 ) then
			self.Desire = 4
		end

		self.Currentpage = math.Approach( self.Currentpage, self.Desire, FrameTime() / 0.2 )

		for i, v in ipairs( self.Pages ) do
			v:SetPos( math.floor( (v.Num-self.Currentpage) * (sw) ) )
		end
	end
end

function SWEP:C2_Close()
	if IsValid( c2 ) then c2:Remove() return end
end