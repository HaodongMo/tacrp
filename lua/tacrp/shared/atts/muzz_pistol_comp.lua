ATT.PrintName = "Compensator"
ATT.Icon = Material("entities/tacrp_att_muzz_pistol_comp.png", "mips smooth")
ATT.Description = "Muzzle device which reduces recoil impact."
ATT.Pros = {"Recoil"}
ATT.Cons = {"Fire rate"}

ATT.Model = "models/weapons/tacint/addons/pistol_comp.mdl"
ATT.Scale = 2
ATT.ModelOffset = Vector(-17.75, 0, -3.5)

ATT.Category = "pistol_muzzle" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Mult_RecoilKick = 0.75
ATT.Mult_RPM = 0.9