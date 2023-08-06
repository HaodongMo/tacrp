ATT.PrintName = "Match"
ATT.FullName = "Match Rounds"
ATT.Icon = Material("entities/tacrp_att_acc_match.png", "mips smooth")
ATT.Description = "Bullets with greatly improved accuracy."
ATT.Pros = {"stat.spread", "stat.muzzlevelocity", "stat.recoilspread"}
ATT.Cons = {"stat.hipfirespread", "att.procon.limb"}

ATT.Category = "ammo_rifle"

ATT.SortOrder = 2

ATT.Mult_Spread = 0.25
ATT.Mult_MuzzleVelocity = 1.5
ATT.Mult_RecoilSpreadPenalty = 0.85
ATT.Add_HipFireSpreadPenalty = 0.015

ATT.Override_BodyDamageMultipliersExtra = {
    [HITGROUP_LEFTARM] = 0.95,
    [HITGROUP_RIGHTARM] = 0.95,
    [HITGROUP_LEFTLEG] = 0.85,
    [HITGROUP_RIGHTLEG] = 0.85,
    [HITGROUP_GEAR] = 0.85,
}