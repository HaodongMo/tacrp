// Material proxy for shotgun shell color
// The bind function is called each frame for entities using this material

local defaultColor = Vector(1, 0.2, 0.2) // Default red, matches VMT $color2

matproxy.Add({
    name = "ShellColor",
    init = function(self, mat, values)
        // Store reference to the material
        self.ResultTo = values.resultVar or "$color"
    end,
    bind = function(self, mat, ent)
        // Check if entity has a ShellColor set (from shell effect)
        if IsValid(ent) and ent.ShellColor then
            local c = ent.ShellColor
            mat:SetVector(self.ResultTo, Vector(c.r * 3 / 255, c.g * 3 / 255, c.b * 3 / 255))
        else
            mat:SetVector(self.ResultTo, defaultColor)
        end
    end
})
