
function SWEP:DrawHUD()
	local sw, sh = ScrW(), ScrH()
	local s = ScreenScaleH
	local p = LocalPlayer()
	self:DoScope()
	self:DrawCustomizeHUD()

	if self:GetValue("TacticalDraw") and self:GetTactical() then
		self:GetValue("TacticalDraw")(self)
	end

	if !self:GetCustomize() then
		if self:GetValue("BlindFireCamera") then
			self:DoCornershot()
		end

		if self:GetValue("Scope") or self:GetValue("PrimaryMelee") then
			self:DrawBreathBar(ScrW() * 0.5, ScrH() * 0.65, s(64), s(4))
		end

		self:DrawGrenadeHUD()

		self:DrawBlindFireHUD()

		do -- Health
			local Hw, Hh = s(60), s(40)
			local Hx, Hy = s(12), sh - Hh - s(12)
			GEM( s, Hx, Hy, Hw, Hh )

			qd( s, "HEALTH", "C2_3", Hx + (Hw/2), Hy + s(2), color_white, TEXT_ALIGN_CENTER )
			qd( s, p:Health(), "C2_1", Hx + (Hw/2), Hy + s(6), color_white, TEXT_ALIGN_CENTER )
		end

		do -- Ammo
			local Hw, Hh = s(60), s(40)
			local Hx, Hy = sw - Hw - s(12), sh - Hh - s(12)
			GEM( s, Hx, Hy, Hw, Hh )

			qd( s, "AMMO", "C2_3", Hx + (Hw/2), Hy + s(2), color_white, TEXT_ALIGN_CENTER )
			qd( s, self:Clip1(), "C2_1", Hx + (Hw/2), Hy + s(6), color_white, TEXT_ALIGN_CENTER )

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

	return true
end
function SWEP:DrawHUDBackground()
	return true
end