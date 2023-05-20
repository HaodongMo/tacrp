ATT.PrintName = "Weighted"
ATT.FullName = "Weighted Trigger"
ATT.Icon = Material("entities/tacrp_att_trigger_heavy.png", "mips smooth")
ATT.Description = "Heavy trigger that reduces mobility impact from shooting."
ATT.Pros = {"stat.shootingspeed"}
ATT.Cons = {"stat.recoildissipation"}

ATT.InvAtt = "trigger_heavy"

ATT.Category = {"trigger_manual"}

ATT.SortOrder = 3

ATT.Mult_RecoilDissipationRate = 0.85
ATT.Mult_ShootingSpeedMult = 1.25