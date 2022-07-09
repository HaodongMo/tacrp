ATT.PrintName = "Subsonic"
ATT.Icon = Material("entities/tacrp_att_acc_tmj.png", "mips smooth")
ATT.Description = "Bullets with reduced load."
ATT.Pros = {"Hidden tracers", "Recoil"}
ATT.Cons = {"Muzzle velocity", "Range"}

ATT.Category = {"ammo_rifle", "ammo_pistol"} // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Mult_RecoilKick = 0.75
ATT.Mult_RecoilSpreadPenalty = 0.5
ATT.TracerNum = 0
ATT.Mult_MuzzleVelocity = 0.75
ATT.Mult_Vol_Shoot = 0.95
ATT.Mult_Range_Max = 0.75
ATT.Mult_Range_Min = 0.75