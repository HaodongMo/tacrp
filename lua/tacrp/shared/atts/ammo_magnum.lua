ATT.PrintName = "Magnum"
ATT.Icon = Material("entities/tacrp_att_acc_hollowpoints.png", "mips smooth")
ATT.Description = "Bullets that improve damage, but are available only in a small magazine."
ATT.Pros = {"Damage"}
ATT.Cons = {"Mag Capacity"}

ATT.InstalledElements = {"smallmag"}

ATT.Category = {"ammo_pistol", "ammo_rifle", "ammo_shotgun"} // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Add_RecoilKick = 0.75
ATT.Mult_RecoilKick = 1.5
ATT.Mult_RecoilSpreadPenalty = 2
ATT.Mult_MuzzleVelocity = 1.25
ATT.Mult_Damage_Max = 1.25
ATT.Mult_RecoilFirstShotMult = 3