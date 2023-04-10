ATT.PrintName = "Improvised"
ATT.FullName = "RPG-7 Improvised Warhead"
ATT.Icon = Material("entities/tacrp_att_ammo_rpg_improvised.png", "mips smooth")
ATT.Description = "Straight from the bargain bin."
ATT.Pros = {"No safety fuse", "Mobility"}
ATT.Cons = {"Random trajectory and damage", "Chance of dramatic failure"}

ATT.Category = "ammo_rpg"

ATT.SortOrder = 1

ATT.Override_ShootEnt = "tacrp_proj_rpg7_improvised"
ATT.Add_ShootingSpeedMult = 0.3
ATT.Add_ReloadSpeedMult = 0.15

ATT.Override_ShootEntForce = 0

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end