ATT.PrintName = "Light"
ATT.FullName = "Light Bolt"
ATT.Icon = Material("entities/tacrp_att_bolt_light.png", "mips smooth")
ATT.Description = "Increase fire rate at the cost of recoil."
ATT.Pros = {"stat.rpm"}
ATT.Cons = {"stat.recoilkick", "stat.recoilspread"}

ATT.Category = "bolt_automatic"

ATT.SortOrder = 1

ATT.Mult_RPM = 1.15
ATT.Mult_RecoilKick = 1.25
ATT.Mult_RecoilSpreadPenalty = 1.1