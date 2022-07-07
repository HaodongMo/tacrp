ATT.PrintName = "RMR"
ATT.Icon = Material("entities/tacrp_att_optic_rmr.png", "mips smooth")
ATT.Description = "Low profile optic sight for pistols."
ATT.Pros = {"Sight"}

ATT.Model = "models/weapons/tacint/addons/optic_rmr_hq.mdl"
ATT.Scale =  1

ATT.Category = "optic_pistol" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Override_Scope = true
ATT.Override_ScopeOverlay = false
ATT.Override_ScopeFOV = 90 / 1.25
ATT.Override_ScopeLevels = 1
ATT.Override_ScopeHideWeapon = false

ATT.SightPos = Vector(0, -10, 0.520837)
ATT.SightAng = Angle(0, 0, 0)

ATT.Holosight = Material("tacrp/hud/rds.png", "additive")

ATT.Holosight:SetInt("$flags", 128)