ATT.PrintName = "Ratshot"
ATT.FullName = "Ratshot Rounds"
ATT.Icon = Material("entities/tacrp_att_ammo_amr_ratshot.png", "mips smooth")
ATT.Description = "For rodents of unusual size."
ATT.Pros = {"Extra projectiles", "Hipfire Spread"}
ATT.Cons = {"Damage", "Spread"}

ATT.Category = {"ammo_amr"}

ATT.SortOrder = 5

ATT.Mult_MuzzleVelocity = 0.75

ATT.Num = 16
ATT.Override_Damage_Max = 5
ATT.Override_Damage_Min = 2
ATT.Override_Penetration = 1

ATT.Mult_HipFireSpreadPenalty = 0.5

ATT.Add_Spread = 0.015
ATT.Add_ShotgunPelletSpread = 0.001

ATT.Override_BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 3,
    [HITGROUP_CHEST] = 1.25,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
    [HITGROUP_LEFTLEG] = 0.75,
    [HITGROUP_RIGHTLEG] = 0.75,
    [HITGROUP_GEAR] = 0.75
}