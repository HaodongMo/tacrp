ATT.PrintName = "CS Gas"
ATT.Icon = Material("entities/tacrp_att_ammo_40mm_lvg.png", "mips smooth")
ATT.Description = "Grenade containing crowd control chemicals."
ATT.Pros = {"Crowd control"}
ATT.Cons = {"Less power"}

ATT.Category = "ammo_40mm" // can be "string" or {"list", "of", "strings"}

ATT.ShootEnt = "tacrp_proj_40mm_gas"
ATT.Mult_ShootEntForce = 0.5

ATT.InstalledElements = {"lvg"}