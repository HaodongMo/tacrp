ATT.PrintName = "Short Dot"
ATT.Icon = Material("entities/tacrp_att_optic_shortdot.png", "mips smooth")
ATT.Description = "Medium range combat scope."
ATT.Pros = {"5x Zoom"}

-- model: gamebanana
-- scope texture: ins2
ATT.Model = "models/weapons/tacint_extras/addons/schd.mdl"
ATT.Scale = 1
ATT.ModelOffset = Vector(-2, 0, -0.3)

ATT.Category = "optic_medium"

ATT.SortOrder = 5

ATT.Override_Scope = true
ATT.Override_ScopeOverlay = Material("tacrp/scopes/shortdot.png", "mips smooth")
-- ATT.Override_ScopeOverlay = false
ATT.Override_ScopeFOV = 90 / 5
ATT.Override_ScopeLevels = 1
ATT.Override_ScopeHideWeapon = true

ATT.SightPos = Vector(0, -10, 1.01611)
ATT.SightAng = Angle(0, 0, 0)