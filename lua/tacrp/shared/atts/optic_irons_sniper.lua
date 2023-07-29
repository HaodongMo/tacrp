ATT.PrintName = "Iron Sights"
ATT.Icon = Material("entities/tacrp_att_optic_irons.png", "mips smooth")
ATT.Description = "Replace default scope for faster aim and better mobility."
ATT.Pros = {"rating.handling", "rating.mobility"}
ATT.Cons = {"att.procon.noscope"}

ATT.Free = true

ATT.InstalledElements = {"irons"}

ATT.Category = "ironsights_sniper"

ATT.SortOrder = 0

ATT.Override_ScopeHideWeapon = false
ATT.Override_ScopeOverlay = false // Material("path/to/overlay")
ATT.Override_ScopeFOV = 90 / 1.1
ATT.Override_ScopeLevels = 1 // 2 = like CS:S

ATT.Add_AimDownSightsTime = -0.05
ATT.Add_SprintToFireTime = -0.05
ATT.Add_SightedSpeedMult = 0.1
ATT.Add_ShootingSpeedMult = 0.05
ATT.Mult_HipFireSpreadPenalty = 0.75