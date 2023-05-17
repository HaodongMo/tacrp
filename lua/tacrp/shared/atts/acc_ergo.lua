ATT.PrintName = "Ergo Grip"
ATT.FullName = "Ergonomic Grip"
ATT.Icon = Material("entities/tacrp_att_acc_ergo.png", "mips smooth")
ATT.Description = "Grooved grip makes aiming faster and moving while shooting easier."

ATT.Category = "acc"

ATT.SortOrder = 2

if engine.ActiveGamemode() == "terrortown" then
    ATT.Pros = {"stat.shootingspeed"}

    ATT.Add_ShootingSpeedMult = 0.15
else
    ATT.Pros = {"stat.shootingspeed", "stat.aimdownsights"}

    ATT.Add_ShootingSpeedMult = 0.08
    ATT.Mult_AimDownSightsTime = 0.85
end