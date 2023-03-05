ATT.PrintName = "Akimbo"
ATT.FullName = "Akimbo Trigger"
ATT.Icon = Material("entities/tacrp_att_trigger_akimbo.png", "mips smooth")
ATT.Description = "Let'em have it!"
ATT.Pros = {"Automatic fire"}
ATT.Cons = {"Fire Rate", "Recoil Spread"}

ATT.Free = true

ATT.Category = "trigger_akimbo" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 0.5

ATT.Override_Firemode = 2
ATT.Mult_RPM = 600 / 700
ATT.Mult_RecoilSpreadPenalty = 1.25