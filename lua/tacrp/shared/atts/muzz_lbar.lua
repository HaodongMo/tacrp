ATT.PrintName = "Light Barrel"
ATT.Icon = Material("entities/tacrp_att_muzz_lbar.png", "mips smooth")
ATT.Description = "Lightweight barrel more accurate and effective at long range."
ATT.Pros = {"stat.spread", "stat.range"}
ATT.Cons = {"stat.sway", "stat.recoil"}

ATT.Category = {"silencer", "barrel"}

ATT.SortOrder = 1

ATT.Mult_Spread = 0.5
ATT.Mult_RecoilSpreadPenalty = 0.85
ATT.Mult_Range_Min = 0.75
ATT.Mult_Range_Max = 1.25
ATT.Mult_MuzzleVelocity = 1.25
ATT.Mult_RecoilKick = 1.25
ATT.Mult_Sway = 1.25
ATT.Mult_ScopedSway = 1.5