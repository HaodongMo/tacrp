ATT.PrintName = "Ratshot"
ATT.FullName = "RPG-7 Ratshot Warhead"
ATT.Icon = Material("entities/tacrp_att_ammo_rpg_ratshot.png", "mips smooth")
ATT.Description = "For rodents of unacceptable size."
ATT.Pros = {"Airburst"}
ATT.Cons = {"Timed fuse"}

ATT.Category = "ammo_rpg"

ATT.SortOrder = 2

ATT.Override_ShootEnt = "tacrp_proj_rpg7_ratshot"
ATT.Override_ShootEntForce = 2000

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end