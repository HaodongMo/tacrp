ATT.PrintName = "CS Gas"
ATT.FullName = "40mm CS Gas Grenades"

ATT.Icon = Material("entities/tacrp_att_ammo_40mm_lvg.png", "mips smooth")
ATT.Description = "Low velocity containing crowd control chemicals."
ATT.Pros = {"Crowd control"}
ATT.Cons = {"Muzzle Velocity", "Damage"}

ATT.Category = "ammo_40mm"

ATT.SortOrder = 3

ATT.ShootEnt = "tacrp_proj_40mm_gas"
ATT.Mult_ShootEntForce = 0.5

ATT.InstalledElements = {"lvg"}