ATT.PrintName = "Concussion" --"LVG"
ATT.FullName = "40mm Concussion Grenades"

ATT.Icon = Material("entities/tacrp_att_ammo_40mm_concussion.png", "mips smooth")
ATT.Description = "Low velocity grenade made to incapacitate targets with indirect fire."
ATT.Pros = {"Ricochet on impact", "Stuns targets"}
ATT.Cons = {"Muzzle Velocity", "Damage"}

ATT.Category = "ammo_40mm"

ATT.SortOrder = 3

ATT.ShootEnt = "tacrp_proj_40mm_lvg"
ATT.Mult_ShootEntForce = 0.5

ATT.InstalledElements = {"lvg"}

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end