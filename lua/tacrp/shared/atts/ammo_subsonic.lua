ATT.PrintName = "Subsonic"
ATT.FullName = "Subsonic Rounds"
ATT.Icon = Material("entities/tacrp_att_acc_subsonic.png", "mips smooth")
ATT.Description = "Bullets with reduced powder load."
ATT.Pros = {"att.procon.notracer", "stat.recoil"}
ATT.Cons = {"stat.muzzlevelocity", "stat.range"}

ATT.Category = {"ammo_rifle", "ammo_pistol"}

ATT.SortOrder = 2

ATT.Mult_RecoilKick = 0.75
ATT.Mult_RecoilSpreadPenalty = 0.5
ATT.TracerNum = 0
ATT.Mult_MuzzleVelocity = 0.75
ATT.Mult_Vol_Shoot = 0.9
ATT.Mult_Range_Max = 0.75
-- ATT.Mult_Range_Min = 0.75