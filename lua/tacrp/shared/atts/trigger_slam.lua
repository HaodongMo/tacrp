ATT.PrintName = "Slamfire"
ATT.Icon = Material("entities/tacrp_att_trigger_frcd.png", "mips smooth")
ATT.Description = "Trigger that emulates automatic fire but with poor performance."
ATT.Pros = {"Automatic fire"}
ATT.Cons = {"Recoil", "Spread"}

ATT.Category = "trigger_pump" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Override_Firemodes = {2}
ATT.Mult_RecoilKick = 1.25
ATT.Mult_RecoilSpreadPenalty = 1.25
ATT.Add_RecoilMaximum = 0.5