ATT.PrintName = "8x"
ATT.Icon = Material("entities/TacRP_att_optic_8x.png", "mips smooth")
ATT.Description = "Long-range two-level sniper optic."
ATT.Pros = {"Zoom"}
ATT.Cons = {"No melee attack"}

ATT.Model = "models/weapons/tacint/addons/8x.mdl"
ATT.Scale = 1
ATT.ModelOffset = Vector(-1.5, 0, -0.1)

ATT.Category = "optic_sniper" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 3

ATT.Override_Scope = true
ATT.Override_ScopeOverlay = Material("TacRP/scopes/sniper.png", "mips smooth")
ATT.Override_ScopeFOV = 90 / 8
ATT.Override_ScopeLevels = 1
ATT.Override_ScopeHideWeapon = true

ATT.Ignore = true