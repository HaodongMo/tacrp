ATT.PrintName = "Birdshot"
ATT.Icon = Material("entities/tacrp_att_acc_slugs.png", "mips smooth")
ATT.Description = "Fire smaller pellets in a larger spread."
ATT.Pros = {"Extra projectiles", "Recoil"}
ATT.Cons = {"Spread"}

ATT.Category = "ammo_shotgun" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Mult_Damage_Min = 0.5
ATT.Mult_Damage_Max = 0.5

ATT.Mult_Num = 2
ATT.Mult_RecoilKick = 0.75
ATT.Mult_MuzzleVelocity = 0.75
ATT.Add_Spread = 0.02
