
function SWEP:DrawHUD()
end

local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = true,
	["CHudSecondaryAmmo"] = true,
}

hook.Add( "HUDShouldDraw", "TacRP_HUD2_HUDShouldDraw", function( name )
	if ( hide[ name ] ) then return false end
end )

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
			GEM( s, Hx, Hy, Hw, Hh )

			qd( s, "HEALTH", "C2_4", Hx + s(4), Hy + s(2), color_white, TEXT_ALIGN_LEFT )
			qd( s, p:Health(), "C2_1", Hx + Hw - s(4), Hy + s(3), color_white, TEXT_ALIGN_RIGHT )
			
			do -- Health
				local Hw, Hh = s(60), s(36)
				local Hx, Hy = Hx + s(60) + s(12), sh - Hh - s(12)
				GEM( s, Hx, Hy, Hw, Hh )

				qd( s, "ARMOR", "C2_4", Hx + s(4), Hy + s(2), color_white, TEXT_ALIGN_LEFT )
				qd( s, p:Armor(), "C2_1", Hx + Hw - s(4), Hy + s(3), color_white, TEXT_ALIGN_RIGHT )
			end
		end

		do -- Ammo
			local Hw, Hh = s(90), s(36)
			local Hx, Hy = sw - Hw - s(12), sh - Hh - s(12)
			GEM( s, Hx, Hy, Hw, Hh )

			qd( s, "AMMO", "C2_4", Hx + s(4), Hy + s(2), color_white, TEXT_ALIGN_LEFT )

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
			if S_AMMO == -1 then
				if S_CLIP == -1 then
				else
					qd( s, S_CLIP, "C2_1", Hx + Hw/2, Hy + s(3), color_white, TEXT_ALIGN_CENTER )
				end
			else
				qd( s, S_CLIP, "C2_1", Hx + (Hw*(5/8)) - s(0), Hy + s(3), color_white, TEXT_ALIGN_RIGHT )
				qd( s, S_AMMO, "C2_2", Hx + (Hw*(5/8)) + s(0), Hy + s(3+14), color_white, TEXT_ALIGN_LEFT )
			end

			for i=1, 6 do
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
			end
		end
	end
end)
function SWEP:DrawHUDBackground()
	return true
end