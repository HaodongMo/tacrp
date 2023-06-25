ATT.PrintName = "W. Suppressor"
ATT.FullName = "Weighted Suppressor"
ATT.Icon = Material("entities/tacrp_att_muzz_supp_weighted.png", "mips smooth")
ATT.Description = "Heavy suppressor with superior ballistics but worse handling."
ATT.Pros = {"stat.vol_shoot", "stat.range", "stat.recoil"}
ATT.Cons = {"rating.handling", "rating.maneuvering"}

ATT.Model = "models/weapons/tacint_extras/addons/suppressor_salvo.mdl"
ATT.Scale = 1.5

ATT.ModelOffset = Vector(0.4, 0, -0.05)

ATT.Category = "silencer"

ATT.SortOrder = 6

ATT.Add_Vol_Shoot = -25
ATT.Mult_RecoilKick = 0.75
ATT.Mult_RecoilSpreadPenalty = 0.9

ATT.Mult_Range_Max = 1.25
ATT.Mult_Range_Min = 1.25

ATT.Add_SprintToFireTime = 0.03
ATT.Add_AimDownSightsTime = 0.03

ATT.Add_FreeAimMaxAngle = 0.5
ATT.Add_Sway = 0.1
ATT.Add_ScopedSway = 0.05

ATT.Add_Pitch_Shoot = -7.5

ATT.Silencer = true
ATT.Override_MuzzleEffect = "muzzleflash_suppressed"