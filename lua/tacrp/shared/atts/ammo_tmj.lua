ATT.PrintName = "TMJ"
ATT.FullName = "Total Metal Jacket Rounds"
ATT.Icon = Material("entities/tacrp_att_acc_tmj.png", "mips smooth")
ATT.Description = "Bullets with improved penetration capability."
ATT.Pros = {"att.procon.armor", "stat.penetration"}
ATT.Cons = {"stat.recoilfirstshot"}
ATT.Category = {"ammo_rifle", "ammo_sniper", "ammo_amr"}

ATT.SortOrder = 1.5

ATT.Add_Penetration = 8
ATT.Mult_RecoilFirstShotMult = 1.5
ATT.Add_ArmorPenetration = 0.05