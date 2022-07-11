ATT.PrintName = "Concussion" --"LVG"
ATT.Icon = Material("entities/tacrp_att_ammo_40mm_lvg.png", "mips smooth")
ATT.Description = "Bouncy grenade"
ATT.Pros = {"Bouncy"}
ATT.Cons = {"Less range"}

ATT.Category = "ammo_40mm" // can be "string" or {"list", "of", "strings"}

ATT.ShootEnt = "tacrp_proj_40mm_lvg"
ATT.Mult_ShootEntForce = 0.75

ATT.InstalledElements = {"lvg"}