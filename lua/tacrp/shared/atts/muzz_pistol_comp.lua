ATT.PrintName = "Compensator"
ATT.Icon = Material("entities/TacRP_att_muzz_pistol_comp.png", "mips smooth")
ATT.Description = "Muzzle device which reduces first shot recoil."
ATT.Pros = {"First Shot Recoil"}
ATT.Cons = {"Accumulated Recoil"}

ATT.Model = "models/weapons/tacint/addons/pistol_comp.mdl"
ATT.Scale = 2
ATT.ModelOffset = Vector(-17.75, 0, -3.5)

ATT.Category = "pistol_muzzle" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Mult_RecoilFirstShotMult = 1.5
ATT.Mult_RecoilPerShot = 0.75
ATT.Mult_RecoilMaximum = 1.25