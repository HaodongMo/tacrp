ATT.PrintName = "Magnum"
ATT.Icon = Material("entities/tacrp_att_acc_hollowpoints.png", "mips smooth")
ATT.Description = "Bullets that deal more damage, but have a much higher kick."
ATT.Pros = {"Damage"}
ATT.Cons = {"Recoil", "Spread"}

ATT.Category = {"ammo_pistol", "ammo_rifle"} // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Add_RecoilKick = 1
ATT.Mult_RecoilKick = 1.5
ATT.Mult_Spread = 1.5
ATT.Mult_RecoilSpreadPenalty = 2
ATT.Mult_MuzzleVelocity = 1.25
ATT.Mult_Damage_Max = 1.25
ATT.Mult_RecoilFirstShotMult = 3
ATT.Mult_Range_Min = 0.75