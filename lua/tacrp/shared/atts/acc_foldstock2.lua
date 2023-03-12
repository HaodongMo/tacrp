ATT.PrintName = "Adjust Stock"
ATT.Icon = Material("entities/tacrp_att_acc_foldstock.png", "mips smooth")
ATT.Description = "Shorten stock to improve handling somewhat at the cost of recoil."
ATT.Pros = {"Handling", "Draw Speed"}
ATT.Cons = {"Recoil Kick", "Sway"}

ATT.Free = true

ATT.Category = "acc_foldstock2"

ATT.SortOrder = 0.5

ATT.Mult_VisualRecoilKick = 1.65
ATT.Mult_RecoilKick = 1.65
ATT.Mult_SprintToFireTime = 0.85
ATT.Mult_AimDownSightsTime = 0.85
ATT.Mult_SightedSpeedMult = 1.125

ATT.Mult_ScopedSway = 1.5
ATT.Mult_Sway = 1.25

ATT.InstalledElements = {"foldstock"}

ATT.TryUnholster = true