ATT.PrintName = "Concealment"
ATT.Icon = Material("entities/tacrp_att_acc_conceal.png", "mips smooth")
ATT.Description = "Make weapon not visible on your body."
ATT.Pros = {"Weapon hidden while holstered"}
// ATT.Cons = {"Slower draw speed"}

ATT.Category = "acc_holster"

ATT.SortOrder = 8

ATT.Override_HolsterVisible = false

// ATT.Mult_DeployTimeMult = 1.25

ATT.Ignore = engine.ActiveGamemode() != "terrortown"