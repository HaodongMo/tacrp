ATT.PrintName = "Hollowpoints"
ATT.Icon = Material("entities/TacRP_att_acc_hollowpoints.png", "mips smooth")
ATT.Description = "Bullets that improve damage, but are available only in a small magazine."
ATT.Pros = {"Damage"}
ATT.Cons = {"Mag Capacity"}

ATT.InstalledElements = {"smallmag"}

ATT.Category = "perk_hollowpoints" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Override_ClipSize = 15

ATT.Mult_Damage_Min = 1.25
ATT.Mult_Damage_Max = 1.25