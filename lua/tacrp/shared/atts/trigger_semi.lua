ATT.PrintName = "Marksman"
ATT.Icon = Material("entities/tacrp_att_trigger_semi.png", "mips smooth")
ATT.Description = "Trigger that sacrfices automatic fire for precision."
ATT.Pros = {"Spread", "Recoil"}
ATT.Cons = {"Semi-automatic fire"}

ATT.Category = {"trigger_auto", "trigger_burst"} // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Override_Firemodes = {1}
ATT.Mult_Spread = 0.75
ATT.Mult_RecoilSpreadPenalty = 0.75
ATT.Mult_RecoilKick = 0.8