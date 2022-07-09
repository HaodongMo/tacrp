ATT.PrintName = "Match"
ATT.Icon = Material("entities/tacrp_att_acc_tmj.png", "mips smooth")
ATT.Description = "Bullets with greatly improved accuracy."
ATT.Pros = {"Spread", "Muzzle velocity"}
ATT.Cons = {"Hip spread"}

ATT.Category = "ammo_rifle" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Mult_Spread = 0.25
ATT.Mult_RecoilSpreadPenalty = 0.85
ATT.Add_HipFireSpreadPenalty = 0.01
ATT.Mult_MuzzleVelocity = 1.25