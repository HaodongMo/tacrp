ATT.PrintName = "3GL"
ATT.FullName = "40mm Cluster Grenades"

ATT.Icon = Material("entities/tacrp_att_ammo_40mm_3gl.png", "mips smooth")
ATT.Description = "Three weak cluster grenades, fired at once."
ATT.Pros = {"Multiple projectiles"}
ATT.Cons = {"Spread", "Muzzle Velocity"}

ATT.Category = "ammo_40mm"

ATT.SortOrder = 1

ATT.ShootEnt = "tacrp_proj_40mm_3gl"
ATT.Num = 3

ATT.InstalledElements = {"3gl"}

ATT.Add_Spread = 0.02
ATT.Mult_ShootEntForce = 0.85

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end