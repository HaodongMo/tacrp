ATT.PrintName = "Straight"
ATT.FullName = "Straight Trigger"
ATT.Icon = Material("entities/tacrp_att_trigger_straight.png", "mips smooth")
ATT.Description = "Narrow trigger with superior recoil performance."
ATT.Pros = {"stat.recoilspread", "stat.recoildissipation"}
ATT.Cons = {"stat.recoilresettime", "stat.shootingspeed"}

ATT.Category = {"trigger_auto", "trigger_straight"}

ATT.SortOrder = 5.5

ATT.Mult_RecoilDissipationRate = 1.15
ATT.Mult_RecoilSpreadPenalty = 0.85

ATT.Add_RecoilResetTime = 0.075
ATT.Add_ShootingSpeedMult = -0.08