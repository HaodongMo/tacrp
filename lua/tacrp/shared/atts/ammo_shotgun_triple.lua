ATT.PrintName = "Triple Hit"
ATT.FullName = "Triple Hit Shells"
ATT.Icon = Material("entities/tacrp_att_acc_triple.png", "mips smooth")
ATT.Description = "Fire three smaller slugs for improved accuracy."
ATT.Pros = {"Spread"}
ATT.Cons = {"Three projectiles", "Hipfire Spread"}

ATT.Category = "ammo_shotgun"

ATT.SortOrder = 1

ATT.Mult_Damage_Max = 2.5
ATT.Mult_Damage_Min = 2.5

ATT.Num = 3

ATT.Mult_Spread = 0.75
ATT.Mult_ShotgunPelletSpread = 0.75

ATT.Mult_RecoilSpreadPenalty = 0.5

ATT.Add_HipFireSpreadPenalty = 0.01

ATT.Mult_MuzzleVelocity = 1.25

ATT.Override_MuzzleEffect = "muzzleflash_slug"

ATT.Override_BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 1.5,
    [HITGROUP_CHEST] = 1.15,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
    [HITGROUP_LEFTLEG] = 0.75,
    [HITGROUP_RIGHTLEG] = 0.75,
    [HITGROUP_GEAR] = 0.75
}