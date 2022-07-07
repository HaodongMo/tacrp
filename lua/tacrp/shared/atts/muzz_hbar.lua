ATT.PrintName = "Heavy Barrel"
ATT.Icon = Material("entities/tacrp_att_muzz_hbar.png", "mips smooth")
ATT.Description = "Increases the range of the weapon."
ATT.Pros = {"Range"}
ATT.Cons = {"Recoil"}

ATT.Category = "silencer" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Mult_Spread = 0.9
ATT.Mult_Range_Min = 0.75
ATT.Mult_Range_Max = 1.15
ATT.Mult_MuzzleVelocity = 1.25
ATT.Mult_RecoilKick = 1.25