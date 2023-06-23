ATT.PrintName = "L. Silencer"
ATT.FullName = "Lightweight Silencer"
ATT.Icon = Material("entities/tacrp_att_muzz_suppressor.png", "mips smooth")
ATT.Description = "Muzzle device reducing spread and audible report with reduced penalty."
ATT.Pros = {"stat.vol_shoot", "stat.spread"}
ATT.Cons = {"stat.range", "stat.muzzlevelocity"}

ATT.Model = "models/weapons/tacint_extras/addons/suppressor.mdl"
ATT.Scale = 1.5

ATT.ModelOffset = Vector(0.3, 0, 0.05)

ATT.Category = "silencer"

ATT.SortOrder = 5

ATT.Add_Vol_Shoot = -20
ATT.Mult_Spread = 0.7
ATT.Mult_Range_Max = 0.85
ATT.Mult_Range_Min = 0.85
ATT.Mult_MuzzleVelocity = 0.9

ATT.Add_Pitch_Shoot = 5

ATT.Silencer = true
ATT.Override_MuzzleEffect = "muzzleflash_suppressed"