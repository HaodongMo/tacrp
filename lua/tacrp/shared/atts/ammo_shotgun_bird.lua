ATT.PrintName = "Birdshot"
ATT.Icon = Material("entities/tacrp_att_acc_bird.png", "mips smooth")
ATT.Description = "Fire smaller pellets in a larger spread."
ATT.Pros = {"Extra projectiles", "Recoil"}
ATT.Cons = {"Spread"}

ATT.Category = {"ammo_shotgun", "ammo_shotgun2"}

ATT.SortOrder = 2

ATT.Add_ArmorPenetration = -0.1

ATT.Mult_Damage_Min = 0.55
ATT.Mult_Damage_Max = 0.55

ATT.Mult_Num = 2
ATT.Mult_RecoilKick = 0.85

-- ATT.Add_Spread = 0.02
-- ATT.Add_ShotgunPelletSpread = 0.008

ATT.Mult_Spread = 1.75
ATT.Mult_ShotgunPelletSpread = 1.75