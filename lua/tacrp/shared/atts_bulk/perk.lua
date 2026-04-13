-- perk.lua

local ATT = {}

------------------------------
-- #region perk_aim (Deadeye)
------------------------------
ATT = {}

ATT.PrintName = "att.perk_aim.name"
ATT.Icon = Material("entities/tacrp_att_acc_aim.png", "mips smooth")
ATT.Description = "att.perk_aim.desc"
ATT.Pros = {"stat.zoom", "stat.scopedsway", "stat.movespread"}

ATT.Category = "perk_shooting"

ATT.SortOrder = 2

ATT.Mult_ScopeFOV = 0.75
ATT.Mult_ScopedSway = 0.25
ATT.Mult_MoveSpreadPenalty = 0.75

TacRP.LoadAtt(ATT, "perk_aim")
-- #endregion

------------------------------
-- #region perk_blindfire (Point Shoot)
------------------------------
ATT = {}

ATT.PrintName = "att.perk_blindfire.name"
ATT.Icon = Material("entities/tacrp_att_acc_blindfire.png", "mips smooth")
ATT.Description = "att.perk_blindfire.desc"
ATT.Pros = {"stat.peekpenalty", "stat.blindfiresway", "stat.freeaimangle"}

ATT.Category = {"perk"}

ATT.SortOrder = 7

ATT.Mult_BlindFireSway = 0.25
ATT.Mult_PeekPenaltyFraction = 0.66667
ATT.Mult_FreeAimMaxAngle = 0.75

TacRP.LoadAtt(ATT, "perk_blindfire")
-- #endregion

------------------------------
-- #region perk_hipfire (Rambo)
------------------------------
ATT = {}

ATT.PrintName = "att.perk_hipfire.name"
ATT.Icon = Material("entities/tacrp_att_acc_hipfire.png", "mips smooth")
ATT.Description = "att.perk_hipfire.desc"
ATT.Pros = {"stat.sway", "stat.hipfirespread"}

ATT.Category = "perk"

ATT.SortOrder = 2

ATT.Mult_HipFireSpreadPenalty = 0.66667
ATT.Mult_Sway = 0.66667

TacRP.LoadAtt(ATT, "perk_hipfire")
-- #endregion

------------------------------
-- #region perk_melee (Smackdown)
------------------------------
ATT = {}

ATT.PrintName = "att.perk_melee.name"
ATT.Icon = Material("entities/tacrp_att_acc_melee.png", "mips smooth")
ATT.Description = "att.perk_melee.desc"
ATT.Pros = {"stat.meleedamage", "att.procon.meleeslow"}

ATT.Category = "perk_melee"

ATT.SortOrder = 2

ATT.Mult_MeleeDamage = 35 / 25
ATT.MeleeSlow = true

TacRP.LoadAtt(ATT, "perk_melee")
-- #endregion

------------------------------
-- #region perk_reload (Quickload)
------------------------------
ATT = {}

ATT.PrintName = "att.perk_reload.name"
ATT.Icon = Material("entities/tacrp_att_acc_reload.png", "mips smooth")
ATT.Description = "att.perk_reload.desc"
ATT.Pros = {"stat.reloadtime"}

ATT.Category = "perk_reload"

ATT.SortOrder = 2

ATT.Mult_ReloadTimeMult = 0.9

TacRP.LoadAtt(ATT, "perk_reload")
-- #endregion

------------------------------
-- #region perk_speed (Agility)
------------------------------
ATT = {}

ATT.PrintName = "att.perk_speed.name"
ATT.Icon = Material("entities/tacrp_att_acc_speed.png", "mips smooth")
ATT.Description = "att.perk_speed.desc"
ATT.Pros = {"stat.movespeed", "stat.reloadspeed"}

ATT.Category = "perk"

ATT.SortOrder = 2

ATT.Add_MoveSpeedMult = 0.1
ATT.Add_ReloadSpeedMult = 0.15

TacRP.LoadAtt(ATT, "perk_speed")
-- #endregion

------------------------------
-- #region perk_throw (Grenadier)
------------------------------
ATT = {}

ATT.PrintName = "att.perk_throw.name"
ATT.Icon = Material("entities/tacrp_att_acc_grenade.png", "mips smooth")
ATT.Description = "att.perk_throw.desc"
ATT.Pros = {"att.procon.quickthrow", "att.procon.throwrocks"}

ATT.Category = {"perk", "perk_throw"}

ATT.SortOrder = 6

ATT.ThrowRocks = true
ATT.Mult_QuickNadeTimeMult = 0.5

TacRP.LoadAtt(ATT, "perk_throw")
-- #endregion

------------------------------
-- #region perk_mlg (Stylish)
------------------------------
ATT = {}

ATT.PrintName = "att.perk_mlg.name"
ATT.Icon = Material("entities/tacrp_att_acc_mlg.png", "mips smooth")
ATT.Description = "att.perk_mlg.desc"
ATT.Pros = {"stat.quickscope", "stat.midairspread", "stat.movespread"}

ATT.Category = "perk_shooting"

ATT.SortOrder = 9

ATT.Mult_QuickScopeSpreadPenalty = 0.25
ATT.Mult_MidAirSpreadPenalty = 0.25
ATT.Mult_MoveSpreadPenalty = 0.75

TacRP.LoadAtt(ATT, "perk_mlg")
-- #endregion

------------------------------
-- #region perk_shock (Shock Trooper)
------------------------------
ATT = {}

ATT.PrintName = "att.melee_boost_shock.name"
ATT.Icon = Material("entities/tacrp_att_acc_shock.png", "mips smooth")
ATT.Description = "att.melee_boost_shock.desc"
ATT.Pros = {"att.procon.gasimmune", "att.procon.flashresist", "att.procon.stunresist"}

ATT.Category = {"perk", "perk_passive"}

ATT.SortOrder = 8

ATT.GasImmunity = true
ATT.StunResist = true

TacRP.LoadAtt(ATT, "perk_shock")
-- #endregion