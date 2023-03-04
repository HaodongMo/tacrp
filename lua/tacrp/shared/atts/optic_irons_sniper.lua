ATT.PrintName = "Iron Sights"
ATT.Icon = Material("entities/tacrp_att_optic_irons.png", "mips smooth")
ATT.Description = "Replace default scope for faster aim and better mobility."
ATT.Pros = {"Handling", "Mobility"}
ATT.Cons = {"No Scope"}

ATT.Free = true

ATT.InstalledElements = {"irons"}

ATT.Category = "ironsights_sniper"

ATT.SortOrder = 0

ATT.Override_ScopeHideWeapon = false
ATT.Override_ScopeOverlay = false // Material("path/to/overlay")
ATT.Override_ScopeFOV = 90 / 1.1
ATT.Override_ScopeLevels = 1 // 2 = like CS:S

ATT.Mult_AimDownSightsTime = 0.8
ATT.Mult_SprintToFireTime = 0.9
ATT.Add_SightedSpeedMult = 0.1
ATT.Add_ShootingSpeedMult = 0.05
ATT.Mult_HipfireSpreadPenalty = 0.75