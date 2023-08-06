ATT.PrintName = "Steel Core"
ATT.FullName = "Steel Core Rounds"

ATT.Icon = Material("entities/tacrp_att_ammo_pistol_ap.png", "mips smooth")
ATT.Description = "Hardened bullets shatter and penetrate armor, but lower controlability."
ATT.Pros = {"att.procon.armor", "stat.penetration"}
ATT.Cons = {"stat.recoilkick"}

ATT.Category = "ammo_pistol"

ATT.SortOrder = 1

-- ATT.Mult_Damage_Max = 0.9
-- ATT.Mult_Damage_Min = 0.9

ATT.Add_Penetration = 5
ATT.Add_ArmorPenetration = 0.4
ATT.Add_ArmorBonus = 0.5

ATT.Add_RecoilKick = 1