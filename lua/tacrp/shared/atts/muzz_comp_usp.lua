ATT.PrintName = "Compensator"
ATT.Icon = Material("entities/tacrp_att_muzz_pistol_comp.png", "mips smooth")
ATT.Description = "Muzzle device which reduces recoil impact."
ATT.Pros = {"Recoil"}
ATT.Cons = {"Fire rate"}

ATT.Category = "comp_usp" // can be "string" or {"list", "of", "strings"}
ATT.InvAtt = "muzz_pistol_comp"
ATT.SortOrder = 1

ATT.Mult_RecoilKick = 0.75
ATT.Mult_RPM = 0.9

ATT.InstalledElements = {"pistol_comp"}