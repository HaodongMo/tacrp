ATT.PrintName = "Burst"
ATT.FullName = "Burst Trigger"
ATT.Icon = Material("entities/tacrp_att_trigger_burst.png", "mips smooth")
ATT.Description = "Trigger that emulates burst fire."
ATT.Pros = {"att.procon.burst"}
ATT.Cons = {"stat.recoilkick", "stat.recoilstability"}

ATT.InvAtt = "trigger_burst"

ATT.Category = {"trigger_semi"}

ATT.SortOrder = 1.1

ATT.Override_Firemodes = {-3, 1}
ATT.Add_RPMMultBurst = 0.4
ATT.Override_RunawayBurst = true
ATT.Add_PostBurstDelay = 0.14

ATT.Mult_RecoilKick = 1.25
ATT.Mult_RecoilStability = 0.75