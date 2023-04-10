ATT.PrintName = "Mortar"
ATT.FullName = "RPG-7 Mortar Warhead"
ATT.Icon = Material("entities/tacrp_att_ammo_rpg_mortar.png", "mips smooth")
ATT.Description = "A mortar with a booster stuck to it, for \"indirect fire\". Needs time to prime."
ATT.Pros = {"Blast Radius"}
ATT.Cons = {"Weak if not primed"}

ATT.Category = "ammo_rpg"

ATT.SortOrder = 3

ATT.Override_ShootEnt = "tacrp_proj_rpg7_mortar"
ATT.Add_ShootingSpeedMult = 0.3
ATT.Add_ReloadSpeedMult = 0.15

ATT.Override_ShootEntForce = 5000

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end