ATT.PrintName = "HV"
ATT.FullName = "High Velocity Rounds"
ATT.Icon = Material("entities/tacrp_att_acc_match.png", "mips smooth")
ATT.Description = "Bullets with much higher velocity, but worsens overpenetration."
ATT.Pros = {"Range", "Muzzle Velocity"}
ATT.Cons = {"Close Range Damage"}

ATT.Category = {"ammo_amr", "ammo_sniper"}

ATT.SortOrder = 2.5

ATT.Mult_MuzzleVelocity = 1.5

ATT.Mult_Range_Max = 1.25
ATT.Mult_Damage_Max = 0.85

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end