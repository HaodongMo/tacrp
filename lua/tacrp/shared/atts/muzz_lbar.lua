ATT.PrintName = "Light Barrel"
ATT.Icon = Material("entities/tacrp_att_muzz_hbar.png", "mips smooth")
ATT.Description = "Increases precision at the cost of sway."
ATT.Pros = {"Spread", "Range"}
ATT.Cons = {"Sway", "Recoil"}

ATT.Category = {"silencer", "barrel"} // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Mult_Spread = 0.5
ATT.Mult_RecoilSpreadPenalty = 0.8
ATT.Mult_Range_Min = 0.75
ATT.Mult_Range_Max = 1.15
ATT.Mult_MuzzleVelocity = 1.25
ATT.Mult_RecoilKick = 1.25
ATT.Mult_Sway = 1.25
ATT.Mult_ScopedSway = 1.25