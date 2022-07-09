ATT.PrintName = "Duffle Bag"
ATT.Icon = Material("entities/tacrp_dufflebag.png", "mips smooth")
ATT.Description = ""
ATT.Pros = {"Conceal weapon in bag"}
ATT.Cons = {"Slower draw speed"}

ATT.Category = "perk_duffle" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 4

ATT.Override_HolsterVisible = true
ATT.HolsterModel = "models/jessev92/payday2/item_bag_loot.mdl"
ATT.HolsterSlot = TacRP.HOLSTER_SLOT_BACK
ATT.HolsterPos = Vector(7, -2, 0)
ATT.HolsterAng = Angle(10, 90, 90)

ATT.Mult_DeployTimeMult = 1.25