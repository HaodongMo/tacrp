ATT.PrintName = "Skullsplitter"
ATT.FullName = "Skullsplitter Rounds"
ATT.Icon = Material("entities/tacrp_att_acc_skullsplitter.png", "mips smooth")
ATT.Description = "Specialized rounds that do more damage to vital body parts."
ATT.Pros = {"Head and Chest damage", "Spread"}
ATT.Cons = {"Limb damage", "Armor Shredding"}

ATT.Category = "ammo_pistol"

ATT.SortOrder = 1

ATT.Mult_Spread = 0.85
ATT.Mult_ArmorBonus = 0.5

ATT.Override_BodyDamageMultipliersExtra = {
    [HITGROUP_HEAD] = 1.5,
    [HITGROUP_CHEST] = 1.2,
    [HITGROUP_LEFTARM] = 0.8,
    [HITGROUP_RIGHTARM] = 0.8,
    [HITGROUP_LEFTLEG] = 0.75,
    [HITGROUP_RIGHTLEG] = 0.75,
    [HITGROUP_GEAR] = 0.75
}