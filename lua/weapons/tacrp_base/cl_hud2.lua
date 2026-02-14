
-- function SWEP:DrawHUD()
-- end

local h2_enabled = CreateClientConVar( "tacrp_h2", 1, true, false )

local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = true,
	["CHudSecondaryAmmo"] = true,
}

hook.Add( "HUDShouldDraw", "TacRP_HUD2_HUDShouldDraw", function( name )
	if h2_enabled:GetBool() and ( hide[ name ] ) then return false end
end )


local fn = "Myriad Pro"--"Bahnschrift"
surface.CreateFont( "H2_General", {
	font = fn,
	size = ScreenScaleH(36),
	weight = 0,
})
surface.CreateFont( "H2_Subtitle", {
	font = fn,
	size = ScreenScaleH(10),
	weight = 0,
})
surface.CreateFont( "H2_WeaponTitle", {
	font = fn,
	size = ScreenScaleH(12),
	weight = 0,
	italic = true,
})
surface.CreateFont( "H2_FiremodeC", {
	font = fn,
	size = ScreenScaleH(10),
	weight = 0,
})
surface.CreateFont( "H2_FiremodeN", {
	font = fn,
	size = ScreenScaleH(8),
	weight = 0,
})
surface.CreateFont( "H2_DialogHeader", {
	font = fn,
	size = ScreenScaleH(10),
	weight = 0,
})
surface.CreateFont( "H2_DialogText", {
	font = fn,
	size = ScreenScaleH(12),
	weight = 0,
})

local function qtl( t, f )
	surface.SetFont( f )
	return surface.GetTextSize( t )
end

hook.Add("HUDPaint", "TacRP_HUD2", function()
	local sw, sh = ScrW(), ScrH()
	local s = ScreenScaleH
	local p = LocalPlayer()
	if !p:IsValid() then return end
	local self = p:GetActiveWeapon()
	if !self:IsValid() then return end

	if self.ArcticTacRP then
		self:DoScope()
		self:DrawCustomizeHUD()
		if self:GetValue("TacticalDraw") and self:GetTactical() then
			self:GetValue("TacticalDraw")(self)
		end
	end

    if !h2_enabled:GetBool() then return end
    C2_UpdateColors()

	if (self.ArcticTacRP and !self:GetCustomize()) or true then
		if self.ArcticTacRP then
			if self:GetValue("BlindFireCamera") then
				self:DoCornershot()
			end

			if self:GetValue("Scope") or self:GetValue("PrimaryMelee") then
				self:DrawBreathBar(ScrW() * 0.5, ScrH() * 0.65, s(64), s(4))
			end

			self:DrawGrenadeHUD()

			self:DrawBlindFireHUD()
		end

		do -- Health
			local Hw, Hh = s(60), s(36)
			local Hx, Hy = s(12), sh - Hh - s(12)
			C2_FullBox( s, Hx, Hy, Hw, Hh )

			qd( s, "HEALTH", "H2_Subtitle", Hx + s(4), Hy + s(2), color_white, TEXT_ALIGN_LEFT )
			qd( s, p:Health(), "H2_General", Hx + Hw - s(4), Hy + s(3), color_white, TEXT_ALIGN_RIGHT )
			
			do -- Health
				local Hw, Hh = s(60), s(36)
				local Hx, Hy = Hx + s(60) + s(12), sh - Hh - s(12)
				GEM( s, Hx, Hy, Hw, Hh )

				qd( s, "ARMOR", "H2_Subtitle", Hx + s(4), Hy + s(2), color_white, TEXT_ALIGN_LEFT )
				qd( s, p:Armor(), "H2_General", Hx + Hw - s(4), Hy + s(3), color_white, TEXT_ALIGN_RIGHT )
			end
		end

		do -- Ammo
			local Hw, Hh = s(140), s(19)
			local Hx, Hy = sw - Hw - s(12), sh - Hh - s(12)
			C2_FullBox( s, Hx, Hy, Hw, Hh )

			--qd( s, "AMMO", "C2_4", Hx + s(4), Hy + s(2), color_white, TEXT_ALIGN_LEFT )

			local S_CLIP, S_AMMO = self:Clip1(), p:GetAmmoCount( self:GetPrimaryAmmoType() )
			if self:GetPrimaryAmmoType() == -1 then
				S_AMMO = -1
			end
			if self:GetMaxClip1() <= 0 then
				S_CLIP = -1
			end
			if S_CLIP == -1 then
				S_CLIP = S_AMMO
				S_AMMO = -1
			end

			qd( s, self:GetPrintName(), "TacRP_C2_12I", Hx + s(4), Hy + s(3), color_white, TEXT_ALIGN_LEFT )

			if self.ArcticTacRP then
				local fm = self:GetCurrentFiremode()
				if fm == 2 then
					fm = "Full-auto"
				elseif fm == 1 then
					fm = "Semi-auto"
				elseif fm == 0 then
					fm = "Safety"
				elseif fm <= 0 then
					fm = (-fm) .. "-burst"
				end
				if self:GetSafe() then
					fm = "Safety -- " .. fm
				end
				local samed = self:GetCurrentFiremode() == self:GetNextFiremode()
				qd( s, fm, "H2_FiremodeC", Hx + Hw - s(4+1), Hy + Hh/2 + (samed and s(-0.5) or s(-3.5)), color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
				if !samed then
					local fm = self:GetNextFiremode()
					if fm == 2 then
						fm = "Full-auto"
					elseif fm == 1 then
						fm = "Semi-auto"
					elseif fm == 0 then
						fm = "Safety"
					elseif fm <= 0 then
						fm = (-fm) .. "-burst"
					end
					if self:GetSafe() then
						fm = "Safety -- " .. fm
					end
					qd( s, "[E+R] " .. fm, "H2_FiremodeN", Hx + Hw - s(4+1), Hy + s(2+7), color_white, TEXT_ALIGN_RIGHT )
				end
			end

			local MC = self:GetMaxClip1()
			local Buw, Buh
			--if MC > 40 then
			--	Buw, Buh = math.ceil(s(8)), math.ceil(s(2))
			--else
				Buw, Buh = math.ceil(s(12)), math.ceil(s(12))
			--end
			local Sx, Sy = 0, 0
			local Bobber = 0
			local Pass = 0

			local aps = 1
			if self.GetValue then
				aps = self:GetValue("AmmoPerShot")
			end

			surface.SetMaterial( Material("tacrp/h2/bullet.png", "mips smooth"))
			local BANG = 14
			for i=1, MC do
				local Dx, Dy = Hx + Hw - s(4+4) + Sx, Hy - s(4+1) + Sy
				if i<= self:Clip1() then
					surface.SetDrawColor( 32, 32, 32, 80 )
					surface.DrawTexturedRectRotated( Dx + 2, Dy + 1, Buw, Buh, BANG )
					surface.DrawTexturedRectRotated( Dx + 2, Dy + 2, Buw, Buh, BANG )
					local c1 = self:Clip1()
					local bl
					local bc
					if self.ArcticTacRP then
						bl = self:GetCurrentFiremode()
						bc = self:GetBurstCount()
						if bl < 0 then
							bl = -bl
						else
							bl = 1
							bc = 0
						end
					else
						bl = 1
						bc = 0
					end
					if ((i+aps) > self:Clip1()) then
						surface.SetDrawColor( 255, 200, 60 )
					elseif i > (c1-(bl*aps)+((bc)*aps)) then
						surface.SetDrawColor( 255, 180, 120 )
					else
						surface.SetDrawColor( 255, 255, 255 )
					end
					surface.DrawTexturedRectRotated( Dx, Dy, Buw, Buh, BANG )
				else
					if self:Clip1() == 0 and (CurTime()%0.4) > 0.3 then
						surface.SetDrawColor( 255, 0, 0, 127 )
					elseif (self:Clip1() <= self:GetMaxClip1()*0.5) and (CurTime()%0.4) < 0.1 then
						surface.SetDrawColor( 255, 0, 0, 127 )
					else
						surface.SetDrawColor( 32, 32, 32, 127 )
					end
					surface.DrawTexturedRectRotated( Dx, Dy, Buw, Buh, BANG )
				end
				Sx = Sx - math.ceil(s(4))

				Bobber = Bobber + 1
				if i!=MC and Bobber >= 30 then
					Bobber = 0
					Pass = Pass + 1
					--Sx = (Pass%2 == 1) and math.ceil( s(-2) ) or 0
					Sx = ( s(-2*Pass) )
					Sy = Sy - math.ceil( s(4) )
				end
			end
			qd( s, self:Clip1() .. " / " .. p:GetAmmoCount(self:GetPrimaryAmmoType()), "H2_FiremodeC", Hx + Hw + s(-2*Pass) - s(8), Hy + Sy - s(17), color_white, TEXT_ALIGN_RIGHT )

			if false then for i=1, 6 do
				if i==1 then
					strin = "[R]"
					strin2 = "Reload"
				elseif i==2 then
					strin = "[E] + [R]"
					strin2 = "Change Firemode"
				elseif i==3 then
					strin = "[T]"
					strin2 = "Grenade Menu"
				elseif i==4 then
					strin = "[E] + [M1]"
					strin2 = "Quick Melee"
				elseif i==5 then
					strin = "[E] + [M2]"
					strin2 = "Toggle Safety"
				elseif i==6 then
					strin = "[X]"
					strin2 = "Blindfire Menu"
				end

				local Nx, Ny = sw - s( 12 ), Hy - s(14+2) - s((8)*(i-1))

				--GEM( s, Nx, Ny, s( 140 ), s( 14 ) )
				qd( s, strin, "C2_4", Nx - s(110), Ny + s(2), color_white, TEXT_ALIGN_LEFT )
				qd( s, strin2, "C2_4", Nx, Ny + s(2), color_white, TEXT_ALIGN_RIGHT )
			end end
		end

		if false then -- Dialog
			local Hw, Hh = s(160), s(30)
			local Hx, Hy = sw/2 - Hw/2, (sh*.7) - Hh/2

			C2_FullBox( s, Hx, Hy, Hw, Hh )

			--qd( s, "WARNING", "H2_DialogHeader", Hx + Hw/2, Hy + s(4), color_white, TEXT_ALIGN_CENTER )
			--qd( s, "Firemode switched to Full-auto", "H2_DialogText", Hx + Hw/2, Hy + s(12), color_white, TEXT_ALIGN_CENTER )
			qd( s, "3-burst", "H2_DialogText", Hx + Hw/2, Hy + Hh/2 - s(10), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			qd( s, "Full-auto", "H2_DialogText", Hx + Hw/2, Hy + Hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			qd( s, "Single-fire", "H2_DialogText", Hx + Hw/2, Hy + Hh/2 + s(10), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

			local sp = qtl( "Full-auto", "H2_DialogText" )
			qd( s, ">", "H2_DialogText", Hx + (Hw/2) - (sp/2) - s(4), Hy + Hh/2, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
			qd( s, "<", "H2_DialogText", Hx + (Hw/2) + (sp/2) + s(4), Hy + Hh/2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		end
	end
end)
-- function SWEP:DrawHUDBackground()
-- 	return true
-- end