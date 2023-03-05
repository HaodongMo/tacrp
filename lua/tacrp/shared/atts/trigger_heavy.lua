ATT.PrintName = "Weighted"
ATT.FullName = "Weighted Trigger"
ATT.Icon = Material("entities/tacrp_att_trigger_heavy.png", "mips smooth")
ATT.Description = "Heavy trigger for sustained fire."
ATT.Pros = {"Max recoil spread"}
ATT.Cons = {"First shot recoil", "Recoil recovery time"}

ATT.Category = {"trigger_semi", "trigger_auto", "trigger_burst", "trigger_akimbo", "trigger_revolver"}

ATT.SortOrder = 3

ATT.Add_RecoilFirstShotMult = 2
ATT.Add_RecoilResetTime = 0.025
// ATT.Mult_RecoilSpreadPenalty = 0.75
ATT.Mult_RecoilMaximum = 0.75
ATT.Mult_RecoilKick = 0.9