
local pages = {
	{
		Name = "Customize",
		Initialize = function( par )
		end,
		Paint = function( self, w, h, c )
		end,
	},
	{
		Name = "Statistics",
		Initialize = function( par )
		end,
		Paint = function( self, w, h, c )
		end,
	},
	{
		Name = "Inspect",
		Initialize = function( par )
		end,
		Paint = function( self, w, h, c )
		end,
	},
	{
		Name = "Information",
		Initialize = function( par )
		end,
		Paint = function( self, w, h, c )
		end,
	},
	{
		Name = "Terminal Effect",
		Initialize = function( par )
		end,
		Paint = function( self, w, h, c )
		end,
	},
	{
		Name = "Newsletter",
		Initialize = function( par )
		end,
		Paint = function( self, w, h, c )
		end,
	},
}

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
		mbutton:SetSize( s(96), s(24) )
		mbutton:SetPos( s(16)+s((i-1)*(96+4)), s(16) )
		mbutton:SetText( v.Name )
		function mbutton:DoClick()
			c2.Desire = i
		end

		local page = c2:Add( "DPanel" )
		page:SetSize( sw, sh )
		page:MoveToBack()

		page.Num = i
		c2.Pages[i] = page

		function page:Paint( w, h )
			surface.SetDrawColor( 0, 0, 0, 222 )
			surface.DrawRect( 0, 0, w, h )
			surface.SetDrawColor( 0, 0, 0, 222 )
			surface.DrawOutlinedRect( 0, 0, w, h, s(16) )

			v:Paint( w, h, { s=s, sw=sw, sh=sh } )
			return
		end

		local label = page:Add( "DButton" )
		label:SetSize( s(120), s(30) )
		label:SetText( v.Name )
		label:Center()
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