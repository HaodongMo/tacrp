ATT.PrintName = "Iron Sights"
ATT.Icon = Material("entities/tacrp_att_optic_irons.png", "mips smooth")
ATT.Description = "Basic sights for added mobility."
ATT.Pros = {"Handling"}
ATT.Cons = {"No zoom"}

ATT.Free = true

ATT.InstalledElements = {"irons"}

ATT.Category = "ironsights"

ATT.SortOrder = 0

ATT.Override_ScopeHideWeapon = false
ATT.Override_ScopeOverlay = false // Material("path/to/overlay")
ATT.Override_ScopeFOV = 90 / 1.1
ATT.Override_ScopeLevels = 1 // 2 = like CS:S

ATT.Mult_AimDownSightsTime = 0.95
ATT.Mult_SprintToFireTime = 0.95