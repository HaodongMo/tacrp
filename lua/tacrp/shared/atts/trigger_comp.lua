ATT.PrintName = "Competition"
ATT.FullName = "Competition Trigger"
ATT.Icon = Material("entities/tacrp_att_trigger_comp.png", "mips smooth")
ATT.Description = "Lightweight trigger for sports shooting."
ATT.Pros = {"stat.recoilfirstshot", "stat.recoilstability"}
ATT.Cons = {"stat.recoilmaximum"}

ATT.Category = {"trigger_semi", "trigger_auto", "trigger_burst", "trigger_akimbo", "trigger_revolver", "trigger"}

ATT.SortOrder = 2

ATT.Mult_RecoilFirstShotMult = 0.75
// ATT.Mult_RecoilSpreadPenalty = 2
ATT.Mult_RecoilMaximum = 1.5
ATT.Add_RecoilStability = 0.1