ATT.PrintName = "Marksman"
ATT.FullName = "Marksman Trigger"

ATT.Icon = Material("entities/tacrp_att_trigger_semi.png", "mips smooth")
ATT.Description = "Trigger that sacrfices automatic fire for precision."
ATT.Pros = {"stat.spread", "stat.recoil"}
ATT.Cons = {"att.procon.semi"}

ATT.Category = {"trigger_auto", "trigger_burst"}

ATT.SortOrder = 1

ATT.Override_Firemodes = {1}
ATT.Mult_Spread = 0.5
ATT.Mult_RecoilSpreadPenalty = 0.75
ATT.Mult_RecoilKick = 0.6
ATT.Mult_RecoilVisualKick = 0.5