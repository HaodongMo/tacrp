ATT.PrintName = "Forced Reset"
ATT.Icon = Material("entities/tacrp_att_trigger_frcd.png", "mips smooth")
ATT.Description = "Trigger that emulates automatic fire but with poor performance."
ATT.Pros = {"Automatic fire"}
ATT.Cons = {"Fire rate", "Recoil spread"}

ATT.InvAtt = "trigger_frcd"

ATT.Category = "trigger_burst" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Override_Firemodes = {2}
ATT.Override_Firemode = 2
ATT.Mult_RPM = 0.8
ATT.Mult_RecoilKick = 1.2
ATT.Mult_RecoilSpreadPenalty = 1.5
ATT.Mult_RecoilMaximum = 1.2