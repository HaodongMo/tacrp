--[[---------------------------------------------------------
	ShellColor Material Proxy
		Sets the color of shotgun shells using the alpha
		channel as a tint mask. Color comes from ent.ShellColor
-----------------------------------------------------------]]

print("[TacRP] Loading ShellColor matproxy...")

local clrFallback = Vector(1, 1, 1) // Default red

matproxy.Add({
	name = "ShellColor",

	init = function(self, mat, values)
		-- Store the name of the variable we want to set (VMT keys are lowercase)
		self.ResultTo = values.resultvar or "$color2"
	end,

	bind = function(self, mat, ent)
		print("[ShellColor] bind called, ent:", ent, "valid:", IsValid(ent), "ShellColor:", ent and ent.ShellColor)
		if !IsValid(ent) then return end

		-- If the entity has ShellColor set, use it
		if ent.ShellColor then
			local c = ent.ShellColor
			print("[ShellColor] Setting color:", c)
			mat:SetVector(self.ResultTo, Vector(c.r / 255, c.g / 255, c.b / 255))
		else
			mat:SetVector(self.ResultTo, clrFallback)
		end
	end
})
