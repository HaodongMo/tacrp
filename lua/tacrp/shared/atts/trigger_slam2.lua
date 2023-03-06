ATT.PrintName = "Slamfire"
ATT.FullName = "Slamfire Trigger"
ATT.Icon = Material("entities/tacrp_att_trigger_frcd.png", "mips smooth")
ATT.Description = "Trigger that emulates automatic fire but with poor performance."
ATT.Pros = {"Fire rate", "Automatic fire"}
ATT.Cons = {"Spread", "Mobility"}

ATT.Category = "trigger_pump2"
ATT.InvAtt = "trigger_slam"

ATT.SortOrder = 1

ATT.Override_Firemodes = {2}
ATT.Mult_RecoilKick = 1.25
ATT.Mult_RecoilSpreadPenalty = 1.25
ATT.Add_RecoilMaximum = 0.5

ATT.Mult_RPM = 1.15
ATT.Mult_ShootTimeMult = 1.4
ATT.Mult_ShootingSpeedMult = 0.75