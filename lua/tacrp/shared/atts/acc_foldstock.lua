ATT.PrintName = "Folded Stock"
ATT.Icon = Material("entities/TacRP_att_acc_foldstock.png", "mips smooth")
ATT.Description = "Keep stock folded, improving handling at the cost of recoil."
ATT.Pros = {"Handling"}
ATT.Cons = {"First Shot Recoil"}

ATT.Free = true

ATT.Category = "foldstock" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Mult_VisualRecoilKick = 2.5
ATT.Mult_RecoilKick = 2
ATT.Mult_SprintToFireTime = 0.75

ATT.Mult_ScopedSway = 5

ATT.InstalledElements = {"foldstock"}

ATT.TryUnholster = true