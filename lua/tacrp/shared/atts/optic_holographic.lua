ATT.PrintName = "Holographic"
ATT.Icon = Material("entities/tacrp_att_optic_holographic.png", "mips smooth")
ATT.Description = "Boxy optic that helps to improve mid-range aim."
ATT.Pros = {"Sight"}

ATT.Model = "models/weapons/tacint/addons/holosight_hq.mdl"
ATT.Scale = 0.35
ATT.ModelOffset = Vector(0, 0.05, 0)

ATT.Category = "optic_cqb" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Override_Scope = true
ATT.Override_ScopeOverlay = false
ATT.Override_ScopeFOV = 90 / 1.5
ATT.Override_ScopeLevels = 1
ATT.Override_ScopeHideWeapon = false

ATT.SightPos = Vector(-0.05, -15, 1.1)
ATT.SightAng = Angle(0, 0, 0)

ATT.Holosight = Material("tacrp/hud/eotech.png", "additive")

ATT.Holosight:SetInt("$flags", 128)