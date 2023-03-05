ATT.PrintName = "Compensator"
ATT.Icon = Material("entities/tacrp_att_muzz_pistol_comp.png", "mips smooth")
ATT.Description = "Muzzle device which reduces recoil impact."
ATT.Pros = {"Recoil", "Spread", "Minimum Range"}
ATT.Cons = {"Fire rate"}

ATT.Category = "comp_mac10"
ATT.InvAtt = "muzz_pistol_comp"
ATT.SortOrder = 1

ATT.Mult_RecoilKick = 0.6
ATT.Mult_RPM = 0.8
ATT.Mult_RecoilSpreadPenalty = 0.75
ATT.Mult_Spread = 0.75
ATT.Mult_Range_Min = 1.5

ATT.InstalledElements = {"pistol_comp"}