ATT.PrintName = "att.ammo_shotgun_triple.name"
ATT.FullName = "att.ammo_shotgun_triple.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_triple.png", "mips smooth")
ATT.Description = "att.ammo_shotgun_triple.desc"
ATT.Pros = {"stat.spread"}
ATT.Cons = {"att.procon.3proj", "stat.hipfirespread"}

ATT.Category = "ammo_shotgun2"
ATT.InvAtt = "ammo_shotgun_triple"

ATT.SortOrder = 1

ATT.Add_ArmorPenetration = 0.075

ATT.Mult_Damage_Max = 2
ATT.Mult_Damage_Min = 2

ATT.Num = 3

ATT.Mult_Spread = 0.4
ATT.Mult_ShotgunPelletSpread = 0.4

ATT.Mult_RecoilSpreadPenalty = 0.5

ATT.Add_HipFireSpreadPenalty = 0.005

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