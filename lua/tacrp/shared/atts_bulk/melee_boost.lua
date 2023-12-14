local ATT = {}

ATT = {}

ATT.PrintName = "Level Up"
ATT.Icon = Material("entities/npc_combine_s.png", "mips smooth")
ATT.Description = "Small boost to all attributes."
ATT.Pros = {}
ATT.Cons = {}

ATT.Category = "melee_boost"

ATT.SortOrder = 1

ATT.Add_MeleePerkStr = 0.05
ATT.Add_MeleePerkAgi = 0.05
ATT.Add_MeleePerkInt = 0.05

TacRP.LoadAtt(ATT, "melee_boost_all")

ATT = {}
ATT.PrintName = "Bulk Up"
ATT.Icon = Material("entities/npc_combine_s.png", "mips smooth")
ATT.Description = ""
ATT.Pros = {}
ATT.Cons = {}

ATT.Category = "melee_boost"

ATT.SortOrder = 2

ATT.Add_MeleePerkStr = 0.15

TacRP.LoadAtt(ATT, "melee_boost_str")

ATT = {}
ATT.PrintName = "Catch Up"
ATT.Icon = Material("entities/npc_combine_s.png", "mips smooth")
ATT.Description = ""
ATT.Pros = {}
ATT.Cons = {}

ATT.Category = "melee_boost"

ATT.SortOrder = 2

ATT.Add_MeleePerkAgi = 0.15

TacRP.LoadAtt(ATT, "melee_boost_agi")

ATT = {}
ATT.PrintName = "Wise Up"
ATT.Icon = Material("entities/npc_combine_s.png", "mips smooth")
ATT.Description = ""
ATT.Pros = {}
ATT.Cons = {}

ATT.Category = "melee_boost"

ATT.SortOrder = 2

ATT.Add_MeleePerkInt = 0.15

TacRP.LoadAtt(ATT, "melee_boost_int")