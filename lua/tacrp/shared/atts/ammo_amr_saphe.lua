ATT.PrintName = "SAPHE"
ATT.Icon = Material("entities/tacrp_att_acc_saphe.png", "mips smooth")
ATT.Description = "High explosive rounds."
ATT.Pros = {"att.procon.explosive"}
ATT.Cons = {"stat.damage", "stat.clipsize", "stat.rpm"}

ATT.Category = "ammo_amr"

ATT.SortOrder = 4

ATT.ExplosiveEffect = "Explosion"
ATT.ExplosiveDamage = 50
ATT.ExplosiveRadius = 256

ATT.Add_Damage_Max = -50
ATT.Add_Damage_Min = -25

ATT.Mult_MuzzleVelocity = 0.667

ATT.Mult_Penetration = 0

ATT.Mult_ClipSize = 0.45

ATT.Mult_RPM = 0.85
ATT.Mult_ShootTimeMult = 1 / 0.85

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end