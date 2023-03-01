ATT.PrintName = "Telescopic"
ATT.Icon = Material("entities/tacrp_att_optic_8x.png", "mips smooth")
ATT.Description = "Long-range sniper optic."
ATT.Pros = {"8x Zoom"}

ATT.Model = "models/weapons/tacint/addons/8x.mdl"
ATT.Scale = 1
ATT.ModelOffset = Vector(-1.5, 0, -0.3)

ATT.Category = "optic_sniper"

ATT.SortOrder = 8

ATT.Override_Scope = true
ATT.Override_ScopeOverlay = Material("tacrp/scopes/sniper.png", "mips smooth")
ATT.Override_ScopeFOV = 90 / 8
ATT.Override_ScopeLevels = 1
ATT.Override_ScopeHideWeapon = true