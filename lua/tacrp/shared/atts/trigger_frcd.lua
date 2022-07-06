ATT.PrintName = "Forced Reset"
ATT.Icon = Material("entities/tacrp_att_trigger_frcd.png", "mips smooth")
ATT.Description = "Trigger that emulates automatic fire but with poor performance."
ATT.Pros = {"Automatic fire"}
ATT.Cons = {"Reduced fire rate", "Worse recoil spread"}

ATT.Category = "trigger_semi" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Override_Firemodes = {2}
ATT.Mult_RPM = 0.75
ATT.Mult_Recoil = 1.1
ATT.Mult_RecoilSpreadPenalty = 1.25