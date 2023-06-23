ATT.PrintName = "T. Silencer"
ATT.FullName = "Tactical Silencer"
ATT.Icon = Material("entities/tacrp_att_muzz_silencer.png", "mips smooth")
ATT.Description = "Muzzle device that reduces audible report and recoil."
ATT.Pros = {"stat.vol_shoot", "stat.recoil"}
ATT.Cons = {"stat.range", "stat.muzzlevelocity"}

ATT.Model = "models/weapons/tacint/addons/silencer.mdl"
ATT.Scale = 0.35

ATT.Category = "silencer"

ATT.SortOrder = 4

ATT.Add_Vol_Shoot = -20
ATT.Mult_RecoilKick = 0.85
ATT.Mult_RecoilSpreadPenalty = 0.95
ATT.Mult_Range_Max = 0.75
ATT.Mult_Range_Min = 0.75
ATT.Mult_MuzzleVelocity = 0.85

ATT.Silencer = true
ATT.Override_MuzzleEffect = "muzzleflash_suppressed"