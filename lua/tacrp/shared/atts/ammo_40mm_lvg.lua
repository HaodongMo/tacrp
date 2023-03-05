ATT.PrintName = "Concussion" --"LVG"
ATT.FullName = "40mm Concussion Grenades"

ATT.Icon = Material("entities/tacrp_att_ammo_40mm_lvg.png", "mips smooth")
ATT.Description = "Low velocity grenade designed for crowd control."
ATT.Pros = {"Ricochet on impact", "Stuns targets"}
ATT.Cons = {"Muzzle Velocity", "Damage"}

ATT.Category = "ammo_40mm"

ATT.SortOrder = 3.5

ATT.ShootEnt = "tacrp_proj_40mm_lvg"
ATT.Mult_ShootEntForce = 0.75

ATT.InstalledElements = {"lvg"}