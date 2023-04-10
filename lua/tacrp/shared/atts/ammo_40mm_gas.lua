ATT.PrintName = "CS Gas"
ATT.FullName = "40mm CS Gas Grenades"

ATT.Icon = Material("entities/tacrp_att_ammo_40mm_lvg.png", "mips smooth")
ATT.Description = "Grenade containing crowd control chemicals that deal lingering damage."
ATT.Pros = {"Crowd control"}
ATT.Cons = {"Non-lethal"}

ATT.Category = "ammo_40mm"

ATT.SortOrder = 3.5

ATT.ShootEnt = "tacrp_proj_40mm_gas"

ATT.InstalledElements = {"lvg"}

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end