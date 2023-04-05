ATT.PrintName = "ACOG"
ATT.Icon = Material("entities/tacrp_att_optic_acog.png", "mips smooth")
ATT.Description = "Medium range combat scope."
ATT.Pros = {"4x Zoom"}

ATT.Model = "models/weapons/tacint/addons/acog.mdl"
ATT.Scale = 0.3
ATT.ModelOffset = Vector(-1.5, 0, 0.7)

ATT.Category = "optic_medium"

ATT.SortOrder = 4

ATT.Override_Scope = true
ATT.Override_ScopeOverlay = Material("tacrp/scopes/acog.png", "mips smooth")
-- ATT.Override_ScopeOverlay = false
ATT.Override_ScopeFOV = 90 / 4
ATT.Override_ScopeLevels = 1
ATT.Override_ScopeHideWeapon = true
ATT.Override_ScopeOverlaySize = 0.85

ATT.SightPos = Vector(0, -10, 1.01611)
ATT.SightAng = Angle(0, 0, 0)