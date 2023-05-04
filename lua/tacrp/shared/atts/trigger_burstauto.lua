ATT.PrintName = "Auto-Burst"
ATT.FullName = "Auto-Burst Trigger"
ATT.Icon = Material("entities/tacrp_att_trigger_burstauto.png", "mips smooth")
ATT.Description = "Trigger that allows continuous burst fire while held."
ATT.Pros = {"Automatic Burst"}
ATT.Cons = {"Burst Delay"}

ATT.Category = {"trigger_burst", "trigger_burstauto"}

ATT.SortOrder = 4

ATT.AutoBurst = true
ATT.Add_PostBurstDelay = 0.05