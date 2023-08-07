ATT.PrintName = "Hollowpoints"
ATT.FullName = "Hollowpoint Rounds"

ATT.Icon = Material("entities/tacrp_att_acc_hollowpoints.png", "mips smooth")
ATT.Description = "Bullets that expand on hit, improving damage to flesh targets and limbs."
ATT.Pros = {"att.procon.limb"}
ATT.Cons = {"att.procon.armor", "stat.penetration", "stat.range"}

ATT.Category = "ammo_pistol"

ATT.SortOrder = 1

ATT.Mult_Range_Max = 0.85

ATT.Mult_Penetration = 0.2

ATT.Mult_ArmorPenetration = 0.8
ATT.Mult_ArmorBonus = 0.75

ATT.Override_BodyDamageMultipliersExtra = {
    [HITGROUP_LEFTARM] = -1,
    [HITGROUP_RIGHTARM] = -1,
    [HITGROUP_LEFTLEG] = -1,
    [HITGROUP_RIGHTLEG] = -1,
    [HITGROUP_GEAR] = -1,
}