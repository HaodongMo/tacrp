ATT.PrintName = "Burst"
ATT.Icon = Material("entities/tacrp_att_trigger_burst.png", "mips smooth")
ATT.Description = "Trigger that emulates burst fire."
ATT.Pros = {"Burst fire"}
ATT.Cons = {"Recoil spread"}

ATT.InvAtt = "trigger_burst"

ATT.Category = {"trigger_semi"} // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1.1

ATT.Override_Firemodes = {-3}
ATT.Mult_RecoilSpreadPenalty = 1.25
ATT.Mult_RecoilMaximum = 1.2
ATT.Override_PostBurstDelay = 0.1