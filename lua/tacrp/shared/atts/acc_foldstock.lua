ATT.PrintName = "Fold Stock"
ATT.Icon = Material("entities/tacrp_att_acc_foldstock.png", "mips smooth")
ATT.Description = "Keep stock folded, improving handling significantly at the cost of recoil."
ATT.Pros = {"rating.handling", "rating.maneuvering"}
ATT.Cons = {"stat.recoilkick", "stat.scopedsway"}

ATT.Free = true

ATT.Category = "acc_foldstock"

ATT.SortOrder = 0.5

ATT.Mult_VisualRecoilKick = 2

ATT.Mult_SightedSpeedMult = 1.25
ATT.Mult_HipFireSpreadPenalty = 0.7

ATT.Add_RecoilKick = 1
ATT.Mult_RecoilKick = 1.5

-- ATT.Mult_SprintToFireTime = 0.75
-- ATT.Mult_AimDownSightsTime = 0.75
ATT.Add_SprintToFireTime = -0.08
ATT.Add_AimDownSightsTime = -0.08

ATT.Add_ScopedSway = 0.1
ATT.Mult_ScopedSway = 2
ATT.Mult_Sway = 0.8
ATT.Add_FreeAimMaxAngle = -1

ATT.InstalledElements = {"foldstock"}

ATT.TryUnholster = true