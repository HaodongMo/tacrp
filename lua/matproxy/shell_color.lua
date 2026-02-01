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
		if !IsValid(ent) then return end

		local c = nil

		-- Check for direct ShellColor (shell effects)
		if ent.ShellColor then
			c = ent.ShellColor
		-- Check for weapon GetValue (weapons with shell models)
		elseif ent.GetValue then
			c = ent:GetValue("ShellColor")
		end

		if c then
			mat:SetVector(self.ResultTo, 5 * Vector(c.r / 255, c.g / 255, c.b / 255))
		else
			mat:SetVector(self.ResultTo, clrFallback)
		end
	end
})
