ATT.PrintName = "Greased"
ATT.Icon = Material("entities/tacrp_att_bolt_greased.png", "mips smooth")
ATT.Description = "Faster firerate."
ATT.Pros = {"Cycle speed"}
ATT.Cons = {"Mobility", "Recoil", "Muzzle velocity"}

ATT.Category = "bolt_manual"

ATT.SortOrder = 1

ATT.Mult_RPM = 1.1
ATT.Mult_ShootTimeMult = 1 / 1.15

ATT.Mult_RecoilKick = 1.25
ATT.Add_ShootingSpeedMult = -0.1
ATT.Add_SightedSpeedMult = -0.05

ATT.Mult_MuzzleVelocity = 0.85