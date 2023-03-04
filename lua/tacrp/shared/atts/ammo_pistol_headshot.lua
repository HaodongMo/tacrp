ATT.PrintName = "Skullsplitter"
ATT.FullName = "Skullsplitter Rounds"
ATT.Icon = Material("entities/tacrp_att_acc_hollowpoints.png", "mips smooth")
ATT.Description = "Specialized rounds that penetrate bones well, increasing damage to head."
ATT.Pros = {"Headshot damage"}
ATT.Cons = {"Limb damage"}

ATT.Category = "ammo_pistol"

ATT.SortOrder = 2

ATT.Override_BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 3,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 0.75,
    [HITGROUP_RIGHTARM] = 0.75,
    [HITGROUP_LEFTLEG] = 0.5,
    [HITGROUP_RIGHTLEG] = 0.5,
    [HITGROUP_GEAR] = 0.9
}