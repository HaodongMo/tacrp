local ATT = {}


------------------------------
-- #region melee_boost_all (Level Up)
------------------------------
ATT = {}

ATT.PrintName = "att.melee_boost_all.name"
ATT.Icon = Material("entities/tacrp_att_melee_boost_all.png", "mips smooth")
ATT.Description = "att.melee_boost_all.desc"
ATT.Pros = {"stat.meleeperkstr", "stat.meleeperkagi", "stat.meleeperkint"}

ATT.Category = "melee_boost"

ATT.SortOrder = 1

ATT.Add_MeleePerkStr = 0.03
ATT.Add_MeleePerkAgi = 0.03
ATT.Add_MeleePerkInt = 0.03

TacRP.LoadAtt(ATT, "melee_boost_all")

------------------------------
-- #region melee_boost_str (Bulk Up)
------------------------------
ATT = {}

ATT.PrintName = "att.melee_boost_str.name"
ATT.Icon = Material("entities/tacrp_att_melee_boost_str.png", "mips smooth")
ATT.Description = "att.melee_boost_str.desc"
ATT.Pros = {"stat.meleeperkstr"}
ATT.Cons = {"stat.meleeperkagi", "stat.meleeperkint"}

ATT.Category = "melee_boost"

ATT.SortOrder = 2

ATT.Add_MeleePerkStr = 0.2
ATT.Add_MeleePerkAgi = -0.05
ATT.Add_MeleePerkInt = -0.05

TacRP.LoadAtt(ATT, "melee_boost_str")

------------------------------
-- #region melee_boost_agi (Catch Up)
------------------------------
ATT = {}

ATT.PrintName = "att.melee_boost_agi.name"
ATT.Icon = Material("entities/tacrp_att_melee_boost_agi.png", "mips smooth")
ATT.Description = "att.melee_boost_agi.desc"
ATT.Pros = {"stat.meleeperkagi"}
ATT.Cons = {"stat.meleeperkstr", "stat.meleeperkint"}

ATT.Category = "melee_boost"

ATT.SortOrder = 3

ATT.Add_MeleePerkAgi = 0.2
ATT.Add_MeleePerkStr = -0.05
ATT.Add_MeleePerkInt = -0.05

TacRP.LoadAtt(ATT, "melee_boost_agi")

------------------------------
-- #region melee_boost_int (Wise Up)
------------------------------
ATT = {}

ATT.PrintName = "att.melee_boost_int.name"
ATT.Icon = Material("entities/tacrp_att_melee_boost_int.png", "mips smooth")
ATT.Description = "att.melee_boost_int.desc"
ATT.Pros = {"stat.meleeperkint"}
ATT.Cons = {"stat.meleeperkstr", "stat.meleeperkagi"}

ATT.Category = "melee_boost"

ATT.SortOrder = 4

ATT.Add_MeleePerkInt = 0.2
ATT.Add_MeleePerkStr = -0.05
ATT.Add_MeleePerkAgi = -0.05

TacRP.LoadAtt(ATT, "melee_boost_int")

------------------------------
-- #region melee_boost_lifesteal
------------------------------
ATT = {}

ATT.PrintName = "att.melee_boost_lifesteal.name"
ATT.Icon = Material("entities/tacrp_att_melee_boost_lifesteal.png", "mips smooth")
ATT.Description = "att.melee_boost_lifesteal.desc"
ATT.Pros = {"stat.lifesteal"}
ATT.Cons = {"stat.meleeperkstr", "stat.meleeperkagi"}

ATT.Category = "melee_boost"

ATT.SortOrder = 10

ATT.Add_Lifesteal = 0.3
ATT.Add_MeleePerkStr = -0.05
ATT.Add_MeleePerkAgi = -0.05

TacRP.LoadAtt(ATT, "melee_boost_lifesteal")

------------------------------
-- #region melee_boost_momentum
------------------------------
ATT = {}

ATT.PrintName = "att.melee_boost_momentum.name"
ATT.Icon = Material("entities/tacrp_att_melee_boost_momentum.png", "mips smooth")
ATT.Description = "att.melee_boost_momentum.desc"
ATT.Pros = {"stat.damagecharge"}
ATT.Cons = {"stat.meleeperkint"}

ATT.Category = "melee_boost"

ATT.SortOrder = 11

ATT.Add_DamageCharge = 0.003
ATT.Add_MeleePerkInt = -0.08

TacRP.LoadAtt(ATT, "melee_boost_momentum")

------------------------------
-- #region melee_boost_afterimage
------------------------------
ATT = {}

ATT.PrintName = "att.melee_boost_afterimage.name"
ATT.Icon = Material("entities/tacrp_att_melee_boost_afterimage.png", "mips smooth")
ATT.Description = "att.melee_boost_afterimage.desc"
ATT.Pros = {"stat.meleedelay"}
ATT.Cons = {"stat.meleeattackmisstime"}

ATT.Category = "melee_boost"

ATT.SortOrder = 12

ATT.Override_MeleeDelay = 0
ATT.Mult_MeleeAttackMissTime = 1.15

TacRP.LoadAtt(ATT, "melee_boost_afterimage")

------------------------------
-- #region melee_boost_shock (Shock Trooper)
------------------------------
ATT = {}

ATT.PrintName = "att.melee_boost_shock.name"
ATT.Icon = Material("entities/tacrp_att_acc_shock.png", "mips smooth")
ATT.Description = "att.melee_boost_shock.desc"
ATT.Pros = {"att.procon.gasimmune", "att.procon.flashresist", "att.procon.stunresist"}

ATT.Category = "melee_boost"
ATT.InvAtt = "perk_shock"

ATT.SortOrder = 12

ATT.GasImmunity = true
ATT.StunResist = true

TacRP.LoadAtt(ATT, "melee_boost_shock")