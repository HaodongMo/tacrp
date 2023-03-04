ATT.PrintName = "Slugs"
ATT.FullName = "Slug Shells"
ATT.Icon = Material("entities/tacrp_att_acc_slugs.png", "mips smooth")
ATT.Description = "Shells that fire a single accurate slug."
ATT.Pros = {"Accuracy", "Range"}
ATT.Cons = {"One projectile"}

ATT.Category = "ammo_shotgun"

ATT.SortOrder = 1

ATT.Mult_Damage_Min = 6.5
ATT.Mult_Damage_Max = 6.5

ATT.Mult_Range_Max = 1.5

ATT.Num = 1

ATT.Mult_Spread = 0.33
ATT.Mult_RecoilSpreadPenalty = 0.25

ATT.Override_MuzzleEffect = "muzzleflash_slug"

ATT.Override_BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1.4,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 0.8,
    [HITGROUP_RIGHTLEG] = 0.8,
    [HITGROUP_GEAR] = 0.9
}