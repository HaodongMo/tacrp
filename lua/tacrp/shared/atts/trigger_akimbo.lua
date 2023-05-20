ATT.PrintName = "Akimbo"
ATT.FullName = "Akimbo Trigger"
ATT.Icon = Material("entities/tacrp_att_trigger_akimbo.png", "mips smooth")
ATT.Description = "Let'em have it!"
ATT.Pros = {"att.procon.auto", "stat.recoilkick"}
ATT.Cons = {"stat.rpm"}

ATT.Free = true

ATT.Category = "trigger_akimbo" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 0.5

ATT.Override_Firemodes = {2, -2}
ATT.Mult_RPM = 600 / 700
ATT.Mult_RecoilKick = 0.75
ATT.Mult_RecoilVisualKick = 1.25