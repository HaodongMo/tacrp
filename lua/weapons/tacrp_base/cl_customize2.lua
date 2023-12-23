
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
			local s = c.s
			for slotnum, slottab in ipairs( c.w.Attachments ) do
				local slot = self:Add( "DButton" )
				slot:SetSize( s(90), s(44) )
				slot:SetPos( s(24), s(24 + (44) + (slotnum-1) * (44 + 4) ) )

				function slot:Paint( w, h )
					surface.SetDrawColor( color_black )
					surface.DrawRect( 0, 0, w, h )
					surface.SetDrawColor( color_white )
					surface.DrawOutlinedRect( 0, 0, w, h, s(1) )

					draw.SimpleText( slottab.PrintName, "C2_3", s(10), s(10-2), color_white )
					surface.SetDrawColor( color_white )
					surface.DrawRect( s(8), s(10+12), w - s(8*2), s(1) )
					if slottab.Installed then
						local ati = TacRP.GetAttTable( slottab.Installed )
						local attname = "none"
						if ati then
							attname = TacRP:TryTranslate( ati.PrintName )
						end
						draw.SimpleText( attname, "C2_3", s(10), s(10+12+2), color_white )
					end
					return true
				end

				function slot:DoRightClick()
					if slottab.Installed then
						c.w:Detach( slotnum )
					end
				end

				function slot:DoClick()
					if IsValid(selecta) then selecta:Remove() end
					selecta = vgui.Create( "DFrame" )
					selecta:SetSize( s(120), s(240) )
					selecta:Center()
					selecta:MakePopup()
					selecta:SetKeyboardInputEnabled( false )
					function selecta:Paint( w, h )
						surface.SetDrawColor( color_black )
						surface.DrawRect( 0, 0, w, h )
						surface.SetDrawColor( color_white )
						surface.DrawOutlinedRect( 0, 0, w, h, s(1) )
						return true
					end

					local atts = TacRP.GetAttsForCats( slottab.Category or "" )

					for _, att in pairs( atts ) do
						local ati = TacRP.GetAttTable( att )
						local button = selecta:Add( "DButton" )
						button:SetSize( 0, s(24) )
						button:Dock( TOP )
						button:DockMargin( 0, 0, 0, s(4) )
						function button:Paint( w, h )
							surface.SetDrawColor( color_black )
							surface.DrawRect( 0, 0, w, h )
							surface.SetDrawColor( color_white )
							surface.DrawOutlinedRect( 0, 0, w, h, s(1) )
							draw.SimpleText( TacRP:TryTranslate( ati.PrintName ), "C2_3", s(6), s(6), color_white )
							if slottab.Installed == att then
								draw.SimpleText( "installed", "C2_4", s(6), s(2), color_white )
							end
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
							selecta:Remove()
						end

						function button:DoRightClick()
							if slottab.Installed == att then
								c.w:Detach( slotnum )
								selecta:Remove()
							end
						end
			
					end
				end
			end
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
		Name = "Information",
		Initialize = function( self, par, c )
			local header = self:Add( "DPanel" )
			local s = c.s
			header:SetSize( c.sw - s(48), s(48) )
			header:SetPos( s(24), s(24) )

			function header:Paint( w, h )
				surface.SetDrawColor( color_black )
				surface.DrawRect( 0, 0, w, h )

				draw.SimpleText( c.w:GetPrintName(), "C2_1", s(24), s(6), color_white )
				draw.SimpleText( c.w:GetSubClassName(TacRP.UseTiers()), "C2_2", w - s(24), s(6), color_white, TEXT_ALIGN_RIGHT )
				draw.SimpleText( c.w:GetValue("Trivia_Caliber"), "C2_2", w - s(24), s(6+18), color_white, TEXT_ALIGN_RIGHT )
				return
			end

			local footer = self:Add( "DPanel" )
			local f_w, f_h = s(400), s(12+(12*1)+12)
			footer:SetSize( f_w, f_h )
			footer:SetPos( self:GetWide()/2 - f_w/2, self:GetTall() - f_h - s(12) )
			function footer:Paint( w, h )
				surface.SetDrawColor( color_black )
				surface.DrawRect( 0, 0, w, h )

				local desc = TacRP.MultiLineText( c.w.Description, w - s(48), "C2_3" )

				local lines = 0
				for i, v in ipairs( desc ) do
					draw.SimpleText( v, "C2_3", s(24), s(12+(12*(i-1))), color_white )
					lines = i
				end
				draw.SimpleText( c.w.Description_Quote, "C2_3I", s(24), s(12+(12*(lines+1))), color_white )
			end

			local preself = self
			function footer:PerformLayout( w, h )
				local desc = TacRP.MultiLineText( c.w.Description, w - s(48), "C2_3" )
				local lines = #desc
				if c.w.Description_Quote then lines = lines + 2 end
				f_h = s(12+(12*lines)+12)

				self:SetSize( f_w, f_h )
				self:SetPos( preself:GetWide()/2 - f_w/2, preself:GetTall() - f_h - s(12) )
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
	{
		Name = "Inspect",
		Initialize = function( self, par, c )
		end,
		Paint = function( self, w, h, c )
		end,
	},
}

local uio = Material( "uio/shadow.png", "" )



local c2_Currentpage = 1
local c2_Desire = 1

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

	function c2:OnRemove()
		if IsValid( selecta ) then selecta:Remove() end
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

	c2.Pages = {}

	for i, v in ipairs( pages ) do
		local mbutton = c2:Add("DButton")
		mbutton:SetSize( s(64), s(14) )
		mbutton:SetPos( s(24)+s((i-1)*(64+4)), s(6) )
		mbutton:SetText( v.Name )
		function mbutton:DoClick()
			c2_Desire = i
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

		v.Initialize( page, c2, { w=w, s=s, sw=sw, sh=sh } )

		function page:Paint( w, h )
			surface.SetDrawColor( 0, 0, 0, 255 )
			surface.SetMaterial( uio )
			surface.DrawTexturedRect( 0, 0, w, h )
			-- surface.SetDrawColor( 0, 0, 0, 222 )
			-- surface.DrawOutlinedRect( 0, 0, w, h, s(16) )

			v.Paint( page, w, h, { w=w, s=s, sw=sw, sh=sh } )
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
			c2_Desire = 1
		elseif input.IsKeyDown( KEY_2 ) then
			c2_Desire = 2
		elseif input.IsKeyDown( KEY_3 ) then
			c2_Desire = 3
		elseif input.IsKeyDown( KEY_4 ) then
			c2_Desire = 4
		end

		c2_Currentpage = math.Approach( c2_Currentpage, c2_Desire, FrameTime() / 0.1 )

		for i, v in ipairs( self.Pages ) do
			v:SetPos( math.floor( (v.Num-c2_Currentpage) * (sw) ) )
		end
	end
end

function SWEP:C2_Close()
	if IsValid( c2 ) then c2:Remove() return end
end