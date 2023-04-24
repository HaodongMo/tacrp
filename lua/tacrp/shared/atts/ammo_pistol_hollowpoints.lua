ATT.PrintName = "Hollowpoints"
ATT.FullName = "Hollowpoint Rounds"

ATT.Icon = Material("entities/tacrp_att_acc_hollowpoints.png", "mips smooth")
ATT.Description = "Bullets that expand on hit, improving damage to flesh targets and limbs."
ATT.Pros = {"Damage", "Minimum Range"}
ATT.Cons = {"Penetration", "Maximum Range"}

--ATT.InstalledElements = {"smallmag"}

ATT.Category = "ammo_pistol"

ATT.SortOrder = 1

ATT.Mult_Damage_Max = 1.1
ATT.Mult_Damage_Min = 1.1

ATT.Mult_Range_Max = 0.85
ATT.Mult_Range_Min = 1.25

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