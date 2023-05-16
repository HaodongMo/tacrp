ATT.PrintName = "Adjust Stock"
ATT.Icon = Material("entities/tacrp_att_acc_foldstock.png", "mips smooth")
ATT.Description = "Shorten stock to improve handling somewhat at the cost of recoil."
ATT.Pros = {"Handling", "Hipfire Spread"}
ATT.Cons = {"Recoil Kick", "Scoped Sway"}

ATT.Free = true

ATT.Category = "acc_foldstock2"

ATT.SortOrder = 0.5

ATT.Mult_VisualRecoilKick = 1.65
ATT.Add_RecoilKick = 0.75
ATT.Mult_RecoilKick = 1.5
ATT.Mult_SprintToFireTime = 0.85
ATT.Mult_AimDownSightsTime = 0.85
ATT.Mult_SightedSpeedMult = 1.125
ATT.Mult_HipFireSpreadPenalty = 0.85

ATT.Add_ScopedSway = 0.1
ATT.Mult_Sway = 0.9
ATT.Add_FreeAimMaxAngle = -0.5

ATT.InstalledElements = {"foldstock"}

ATT.TryUnholster = true