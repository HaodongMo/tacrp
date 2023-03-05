ATT.PrintName = "Match"
ATT.FullName = "Match Rounds"
ATT.Icon = Material("entities/tacrp_att_acc_tmj.png", "mips smooth")
ATT.Description = "Bullets with greatly improved accuracy."
ATT.Pros = {"Spread", "Recoil Spread", "Muzzle Velocity"}
ATT.Cons = {"Hipfire Spread"}

ATT.Category = "ammo_rifle"

ATT.SortOrder = 2

ATT.Mult_Spread = 0.25
ATT.Mult_RecoilSpreadPenalty = 0.85
ATT.Add_HipFireSpreadPenalty = 0.01
ATT.Mult_MuzzleVelocity = 1.4