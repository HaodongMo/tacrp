ATT.PrintName = "ELCAN"
ATT.Icon = Material("entities/tacrp_att_optic_elcan.png", "mips smooth")
ATT.Description = "Low power combat scope."
ATT.Pros = {"3x Zoom"}

-- model: https://gamebanana.com/mods/210646
-- scope texture: ins2
ATT.Model = "models/weapons/tacint_extras/addons/elcan.mdl"
ATT.Scale = 1
ATT.ModelOffset = Vector(-1.7, 0, -0.3)

ATT.Category = "optic_medium"

ATT.SortOrder = 3

ATT.Override_Scope = true
ATT.Override_ScopeOverlay = Material("tacrp/scopes/elcan.png", "mips smooth")
-- ATT.Override_ScopeOverlay = false
ATT.Override_ScopeFOV = 90 / 3
ATT.Override_ScopeLevels = 1
ATT.Override_ScopeHideWeapon = true

ATT.SightPos = Vector(0, -10, 1.01611)
ATT.SightAng = Angle(0, 0, 0)