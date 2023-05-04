ATT.PrintName = "Weighted"
ATT.FullName = "Weighted Trigger"
ATT.Icon = Material("entities/tacrp_att_trigger_heavy.png", "mips smooth")
ATT.Description = "Heavy trigger for sustained fire."
ATT.Pros = {"Recoil Kick", "Max recoil spread"}
ATT.Cons = {"First shot recoil"}

ATT.Category = {"trigger_semi", "trigger_auto", "trigger_burst", "trigger_akimbo", "trigger_revolver", "trigger"}

ATT.SortOrder = 3

ATT.Mult_RecoilFirstShotMult = 1.5
ATT.Mult_RecoilMaximum = 0.75
ATT.Mult_RecoilKick = 0.85