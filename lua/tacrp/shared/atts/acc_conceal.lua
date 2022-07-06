ATT.PrintName = "Concealment"
ATT.Icon = Material("entities/tacrp_att_acc_conceal.png", "mips smooth")
ATT.Description = ""
ATT.Pros = {"Weapon not visible while holstered", "Faster draw time"}

ATT.Category = "perk_conceal" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 4

ATT.Override_HolsterVisible = false

ATT.Mult_DeployTimeMult = 0.8