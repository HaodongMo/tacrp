ATT.PrintName = "Agility"
ATT.Icon = Material("entities/tacrp_att_acc_speed.png", "mips smooth")
ATT.Description = "Reduce weapon slowdown."
ATT.Pros = {"Move Speed", "Sighted Speed"}

ATT.Category = "perk" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 2

ATT.Add_MoveSpeedMult = 0.05
ATT.Add_SightedSpeedMult = 0.1