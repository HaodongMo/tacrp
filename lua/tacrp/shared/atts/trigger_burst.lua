ATT.PrintName = "Burst"
ATT.Icon = Material("entities/tacrp_att_trigger_burst.png", "mips smooth")
ATT.Description = "Trigger that sacrfices automatic fire for stability."
ATT.Pros = {"Recoil spread", "Recoil"}
ATT.Cons = {"No automatic fire"}

ATT.Category = {"trigger_auto"} // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1.1

ATT.Override_Firemodes = {-3, 1}
ATT.Override_RunawayBurst = true
ATT.Mult_RecoilSpreadPenalty = 0.75
ATT.Mult_RecoilKick = 0.75
ATT.Override_PostBurstDelay = 0.12
ATT.Mult_RPM = 1.15