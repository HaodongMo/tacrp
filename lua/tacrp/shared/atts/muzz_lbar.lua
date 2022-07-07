ATT.PrintName = "Light Barrel"
ATT.Icon = Material("entities/tacrp_att_muzz_hbar.png", "mips smooth")
ATT.Description = "Improves recoil, at the cost of range."
ATT.Pros = {"Recoil"}
ATT.Cons = {"Range"}

ATT.Category = "silencer" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Mult_Spread = 1.25
ATT.Mult_Range_Min = 1.5
ATT.Mult_Range_Max = 0.75
ATT.Mult_MuzzleVelocity = 0.8
ATT.Mult_RecoilKick = 0.6