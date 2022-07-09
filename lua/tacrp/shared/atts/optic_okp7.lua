ATT.PrintName = "OKP-7"
ATT.Icon = Material("entities/tacrp_att_optic_okp7.png", "mips smooth")
ATT.Description = "Russian-made reflex sight."
ATT.Pros = {"Sight"}

ATT.Model = "models/weapons/tacint/addons/okp7.mdl"

ATT.Category = "optic_cqb" // can be "string" or {"list", "of", "strings"}
ATT.Scale = 1.5
ATT.ModelOffset = Vector(-1.5, 0, -0.5)

ATT.SortOrder = 1

ATT.Override_Scope = true
ATT.Override_ScopeOverlay = false
ATT.Override_ScopeFOV = 90 / 1.5
ATT.Override_ScopeLevels = 1
ATT.Override_ScopeHideWeapon = false

ATT.SightPos = Vector(0, -15, 1.4)
ATT.SightAng = Angle(0, 0, 0)

ATT.Holosight = Material("tacrp/hud/okp7.png", "smooth")

ATT.Holosight:SetInt("$flags", 128)