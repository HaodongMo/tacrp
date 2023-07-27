ATT.PrintName = "Burst"
ATT.FullName = "Burst Trigger"
ATT.Icon = Material("entities/tacrp_att_trigger_burst.png", "mips smooth")
ATT.Description = "Trigger that sacrfices automatic fire for stability."
ATT.Pros = {"stat.rpm", "rating.control"}
ATT.Cons = {"att.procon.burst"}

ATT.Category = {"trigger_auto"}

ATT.SortOrder = 1.1

ATT.Add_PostBurstDelay = 0.1
ATT.Add_RPMMultBurst = 0.35
ATT.Override_Firemodes = {-3, 1}
ATT.Override_RunawayBurst = true

ATT.Mult_RecoilSpreadPenalty = 0.75
ATT.Mult_RecoilVisualKick = 0.85
ATT.Mult_RecoilKick = 0.75

ATT.Mult_RecoilStability = 1.25