ATT.PrintName = "Concealment"
ATT.Icon = Material("entities/tacrp_att_acc_conceal.png", "mips smooth")
ATT.Description = ""
ATT.Pros = {"Weapon hidden while holstered"}
ATT.Cons = {"Slower draw speed"}

ATT.Category = "perk_conceal" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 4

ATT.Override_HolsterVisible = false

ATT.Mult_DeployTimeMult = 1.25