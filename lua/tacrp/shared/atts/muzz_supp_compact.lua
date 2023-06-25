ATT.PrintName = "C. Suppressor"
ATT.FullName = "Compact Suppressor"
ATT.Icon = Material("entities/tacrp_att_muzz_supp_compact.png", "mips smooth")
ATT.Description = "Short suppressor improving accuracy with low impact to effective range."
ATT.Pros = {"stat.vol_shoot", "stat.spread"}
ATT.Cons = {"stat.range", "stat.muzzlevelocity"}

ATT.Model = "models/weapons/tacint_extras/addons/suppressor.mdl"
ATT.Scale = 1.4

ATT.ModelOffset = Vector(-0.05, 0, 0.05)

ATT.Category = "silencer"

ATT.SortOrder = 5

ATT.Add_Vol_Shoot = -15
ATT.Mult_Spread = 0.75
ATT.Mult_Range_Max = 0.8
ATT.Mult_Range_Min = 0.8
ATT.Mult_MuzzleVelocity = 0.9

ATT.Add_Pitch_Shoot = 7.5

ATT.Silencer = true
ATT.Override_MuzzleEffect = "muzzleflash_suppressed"