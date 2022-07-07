ATT.PrintName = "Red Dot"
ATT.Icon = Material("entities/tacrp_att_optic_rds.png", "mips smooth")
ATT.Description = "Tube optic that helps to improve mid-range aim."
ATT.Pros = {"Sight"}

ATT.Model = "models/weapons/tacint/addons/reddot_hq.mdl"
ATT.Scale = 0.35
ATT.ModelOffset = Vector(0, 0, 1.2)

ATT.Category = "optic_cqb" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Override_Scope = true
ATT.Override_ScopeOverlay = false
ATT.Override_ScopeFOV = 90 / 1.5
ATT.Override_ScopeLevels = 1
ATT.Override_ScopeHideWeapon = false

ATT.SightPos = Vector(0, -15, 0.1)
ATT.SightAng = Angle(0, 0, 0)

ATT.Holosight = Material("tacrp/hud/rds.png", "additive")

ATT.Holosight:SetInt("$flags", 128)