ATT.PrintName = "Tactical"
ATT.FullName = "Tactical Bolt"
ATT.Icon = Material("entities/tacrp_att_bolt_tactical.png", "mips smooth")
ATT.Description = "Slower bolt speed but improve overall handling."
ATT.Pros = {"rating.mobility", "stat.recoil", "stat.muzzlevelocity"}
ATT.Cons = {"stat.rpm"}

ATT.Category = "bolt_manual"

ATT.SortOrder = 2

ATT.Mult_RPM = 0.85
ATT.Mult_ShootTimeMult = 1 / 0.85

ATT.Add_ShootingSpeedMult = 0.15
ATT.Add_SightedSpeedMult = 0.05
ATT.Mult_RecoilKick = 0.6

ATT.Mult_MuzzleVelocity = 1.15