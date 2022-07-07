ATT.PrintName = "Iron Sights"
ATT.Icon = Material("entities/tacrp_att_optic_irons.png", "mips smooth")
ATT.Description = "Basic sights that won't be damaged by striking with the weapon."
ATT.Pros = {"Handling"}
ATT.Cons = {"No zoom"}

ATT.Free = true

ATT.InstalledElements = {"irons"}

ATT.Category = "ironsights_sniper" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 0

ATT.Override_ScopeHideWeapon = false
ATT.Override_ScopeOverlay = false // Material("path/to/overlay")
ATT.Override_ScopeFOV = 90 / 1.1
ATT.Override_ScopeLevels = 1 // 2 = like CS:S

ATT.Mult_AimDownSightsTime = 0.8
ATT.Mult_SprintToFireTime = 0.95
ATT.Add_SightedSpeedMult = 0.15