ATT.PrintName = "Competition"
ATT.FullName = "Competition Trigger"
ATT.Icon = Material("entities/tacrp_att_trigger_comp.png", "mips smooth")
ATT.Description = "Lightweight trigger for sports shooting."
ATT.Pros = {"First shot recoil"}
ATT.Cons = {"Max recoil spread", "Recoil Kick"}

ATT.Category = {"trigger_semi", "trigger_auto", "trigger_burst", "trigger_akimbo", "trigger_revolver"}

ATT.SortOrder = 2

ATT.Mult_RecoilFirstShotMult = 0.75
// ATT.Mult_RecoilSpreadPenalty = 2
ATT.Mult_RecoilMaximum = 1.5

ATT.Mult_RecoilKick = 1.15