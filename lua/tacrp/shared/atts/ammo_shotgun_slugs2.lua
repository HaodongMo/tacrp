ATT.PrintName = "Slugs"
ATT.FullName = "Slug Shells"
ATT.Icon = Material("entities/tacrp_att_acc_slugs.png", "mips smooth")
ATT.Description = "Fire a single projectile for medium range shooting."
ATT.Pros = {"Spread", "Range"}
ATT.Cons = {"One projectile", "Hipfire Spread"}

ATT.Category = "ammo_shotgun2"
ATT.InvAtt = "ammo_shotgun_slugs"

ATT.SortOrder = 1

ATT.Mult_Damage_Min = 6
ATT.Mult_Damage_Max = 3

ATT.Mult_Range_Max = 1.5

ATT.Num = 1

ATT.Mult_Spread = 0.33
ATT.Mult_RecoilSpreadPenalty = 0.25

ATT.Add_HipFireSpreadPenalty = 0.025

ATT.Mult_MuzzleVelocity = 1.5

ATT.Override_MuzzleEffect = "muzzleflash_slug"

ATT.Override_BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1.25,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
    [HITGROUP_LEFTLEG] = 0.75,
    [HITGROUP_RIGHTLEG] = 0.75,
    [HITGROUP_GEAR] = 0.75
}