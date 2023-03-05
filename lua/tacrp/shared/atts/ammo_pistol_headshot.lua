ATT.PrintName = "Skullsplitter"
ATT.FullName = "Skullsplitter Rounds"
ATT.Icon = Material("entities/tacrp_att_acc_hollowpoints.png", "mips smooth")
ATT.Description = "Specialized rounds that penetrate bones well, increasing damage to head."
ATT.Pros = {"Headshot damage"}
ATT.Cons = {"Limb damage"}

ATT.Category = "ammo_pistol"

ATT.SortOrder = 1

ATT.Override_BodyDamageMultipliersExtra = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
    [HITGROUP_LEFTLEG] = 0.75,
    [HITGROUP_RIGHTLEG] = 0.75,
    [HITGROUP_GEAR] = 0.75
}