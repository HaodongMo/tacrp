ATT.PrintName = "Pistol Brace"
ATT.Icon = Material("entities/tacrp_att_acc_brace.png", "mips smooth")
ATT.Description = "The ATF is gonna get your ass."
ATT.Pros = {"Recoil", "Sway"}
ATT.Cons = {"Handling", "Deploy Time"}

ATT.Category = "acc_brace"

ATT.SortOrder = 3

ATT.Mult_RecoilKick = 0.3
ATT.Mult_RecoilSpreadPenalty = 0.75

ATT.Add_Sway = -0.8
ATT.Add_ScopedSway = -0.8

ATT.Add_AimDownSightsTime = 0.06
ATT.Add_SprintToFireTime = 0.1

ATT.Add_HipFireSpreadPenalty = 0.005

ATT.Mult_DeployTimeMult = 1.5