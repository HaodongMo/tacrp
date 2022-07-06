ATT.PrintName = "Weighted"
ATT.Icon = Material("entities/tacrp_att_trigger_heavy.png", "mips smooth")
ATT.Description = "Heavy trigger for sustained fire."
ATT.Pros = {"Improved recoil spread"}
ATT.Cons = {"Worse first shot recoil"}

ATT.Category = {"trigger_semi", "trigger_auto"}

ATT.SortOrder = 3

ATT.Add_RecoilFirstShotMult = 1
ATT.Mult_RecoilSpreadPenalty = 0.5
ATT.Mult_RecoilKick = 0.9