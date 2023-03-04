ATT.PrintName = "Hollowpoints"
ATT.FullName = "Hollowpoint Rounds"

ATT.Icon = Material("entities/tacrp_att_acc_hollowpoints.png", "mips smooth")
ATT.Description = "Bullets that expand on hit, improving limb damage."
ATT.Pros = {"Limb Damage"}
ATT.Cons = {"Penetration"}

ATT.InstalledElements = {"smallmag"}

ATT.Category = "ammo_pistol"

ATT.SortOrder = 1

ATT.Mult_Penetration = 0.2

ATT.Override_BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 1,
    [HITGROUP_RIGHTLEG] = 1,
    [HITGROUP_GEAR] = 1
}