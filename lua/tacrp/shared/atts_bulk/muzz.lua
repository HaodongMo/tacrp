-- muzz.lua

local ATT = {}

------------------------------
-- #region muzz_comp_mac10 (Compensator)
------------------------------
ATT = {}

ATT.PrintName = "att.muzz_pistol_comp.name"
ATT.Icon = Material("entities/tacrp_att_muzz_pistol_comp.png", "mips smooth")
ATT.Description = "att.muzz_pistol_comp.desc"
ATT.Pros = {"stat.recoil", "stat.spread", "stat.range"}
ATT.Cons = {"stat.rpm"}

ATT.Category = "comp_mac10"
ATT.InvAtt = "muzz_pistol_comp"
ATT.SortOrder = 1

ATT.Mult_RecoilKick = 0.75
ATT.Mult_RPM = 0.8
ATT.Mult_RecoilSpreadPenalty = 0.65
ATT.Mult_Spread = 0.5
ATT.Mult_Range_Max = 1.5
ATT.Mult_Range_Min = 1.5

ATT.InstalledElements = {"pistol_comp"}

TacRP.LoadAtt(ATT, "muzz_comp_mac10")
-- #endregion

------------------------------
-- #region muzz_comp_usp (Compensator)
------------------------------
ATT = {}

ATT.PrintName = "att.muzz_pistol_comp.name"
ATT.Icon = Material("entities/tacrp_att_muzz_pistol_comp.png", "mips smooth")
ATT.Description = "att.muzz_pistol_comp.desc"
ATT.Pros = {"stat.recoil", "stat.spread", "stat.range_min"}
ATT.Cons = {"stat.rpm"}

ATT.Category = "comp_usp"
ATT.InvAtt = "muzz_pistol_comp"
ATT.SortOrder = 1

ATT.Mult_RecoilKick = 0.5
ATT.Mult_RPM = 0.9
ATT.Mult_Spread = 0.75
ATT.Mult_Range_Min = 1.5

ATT.InstalledElements = {"pistol_comp"}

TacRP.LoadAtt(ATT, "muzz_comp_usp")
-- #endregion

------------------------------
-- #region muzz_hbar (Heavy Barrel)
------------------------------
ATT = {}

ATT.PrintName = "att.muzz_hbar.name"
ATT.Icon = Material("entities/tacrp_att_muzz_hbar.png", "mips smooth")
ATT.Description = "att.muzz_hbar.desc"
ATT.Pros = {"stat.scopedsway", "stat.recoil", "stat.range_min"}
ATT.Cons = {"stat.spread", "stat.range_max"}

ATT.Category = {"silencer", "barrel"}

ATT.SortOrder = 1

ATT.Add_Spread = 0.004
ATT.Mult_Spread = 1.25
ATT.Mult_Range_Min = 1.25
ATT.Mult_Range_Max = 0.66667
ATT.Mult_RecoilKick = 0.75
ATT.Mult_ScopedSway = 0.5
ATT.Mult_RecoilSpreadPenalty = 1.1

TacRP.LoadAtt(ATT, "muzz_hbar")
-- #endregion

------------------------------
-- #region muzz_lbar (Light Barrel)
------------------------------
ATT = {}

ATT.PrintName = "att.muzz_lbar.name"
ATT.Icon = Material("entities/tacrp_att_muzz_lbar.png", "mips smooth")
ATT.Description = "att.muzz_lbar.desc"
ATT.Pros = {"stat.spread", "stat.range_max"}
ATT.Cons = {"stat.scopedsway", "stat.recoil", "stat.range_min"}

ATT.Category = {"silencer", "barrel"}

ATT.SortOrder = 1

ATT.Mult_Spread = 0.5
ATT.Mult_Range_Min = 0.66667
ATT.Mult_Range_Max = 1.25
-- ATT.Mult_MuzzleVelocity = 1.25
ATT.Mult_RecoilKick = 1.25
ATT.Add_ScopedSway = 0.1

TacRP.LoadAtt(ATT, "muzz_lbar")
-- #endregion

------------------------------
-- #region muzz_pistol_comp (Compensator)
------------------------------
ATT = {}

ATT.PrintName = "att.muzz_pistol_comp.name"
ATT.Icon = Material("entities/tacrp_att_muzz_pistol_comp.png", "mips smooth")
ATT.Description = "att.muzz_pistol_comp.desc"
ATT.Pros = {"stat.recoil", "stat.spread", "stat.range_min"}
ATT.Cons = {"stat.rpm"}

ATT.Model = "models/weapons/tacint/addons/pistol_comp.mdl"
ATT.Scale = 2
ATT.ModelOffset = Vector(-17.75, 0, -3.5)

ATT.Category = "pistol_muzzle"

ATT.SortOrder = 1

ATT.Mult_RecoilKick = 0.5
ATT.Mult_RPM = 0.9
ATT.Mult_Spread = 0.75
ATT.Mult_Range_Min = 1.5

TacRP.LoadAtt(ATT, "muzz_pistol_comp")
-- #endregion

------------------------------
-- #region muzz_silencer (Tactical Suppressor)
------------------------------
ATT = {}

ATT.PrintName = "att.muzz_supp_tactical.name"
ATT.FullName = "att.muzz_supp_tactical.name.full"
ATT.Icon = Material("entities/tacrp_att_muzz_supp_tactical.png", "mips smooth")
ATT.Description = "att.muzz_supp_tactical.desc"
ATT.Pros = {"stat.vol_shoot", "stat.recoil"}
ATT.Cons = {"stat.range", "stat.muzzlevelocity"}

ATT.Model = "models/weapons/tacint/addons/silencer.mdl"
ATT.Scale = 0.35

ATT.Category = "silencer"

ATT.SortOrder = 4

ATT.Add_Vol_Shoot = -25
ATT.Mult_RecoilKick = 0.9
ATT.Mult_RecoilSpreadPenalty = 0.95
ATT.Mult_Range_Max = 0.8
ATT.Mult_Range_Min = 0.8
ATT.Mult_MuzzleVelocity = 0.85

ATT.Silencer = true
ATT.Override_MuzzleEffect = "muzzleflash_suppressed"

TacRP.LoadAtt(ATT, "muzz_silencer")
-- #endregion

------------------------------
-- #region muzz_supp_compact (Compact Suppressor)
------------------------------
ATT = {}

ATT.PrintName = "att.muzz_supp_compact.name"
ATT.FullName = "att.muzz_supp_compact.name.full"
ATT.Icon = Material("entities/tacrp_att_muzz_supp_compact.png", "mips smooth")
ATT.Description = "att.muzz_supp_compact.desc"
ATT.Pros = {"stat.vol_shoot", "stat.spread"}
ATT.Cons = {"stat.range", "stat.muzzlevelocity"}

ATT.Model = "models/weapons/tacint_extras/addons/suppressor.mdl"
ATT.Scale = 1.4

ATT.ModelOffset = Vector(-0.05, 0, 0.05)

ATT.Category = "silencer"

ATT.SortOrder = 5

ATT.Add_Vol_Shoot = -20
ATT.Mult_Spread = 0.8
ATT.Mult_Range_Max = 0.9
ATT.Mult_Range_Min = 0.9
ATT.Mult_MuzzleVelocity = 0.9

ATT.Add_Pitch_Shoot = 7.5

ATT.Silencer = true
ATT.Override_MuzzleEffect = "muzzleflash_suppressed"

TacRP.LoadAtt(ATT, "muzz_supp_compact")
-- #endregion

------------------------------
-- #region muzz_supp_weighted (Weighted Suppressor)
------------------------------
ATT = {}

ATT.PrintName = "att.muzz_supp_weighted.name"
ATT.FullName = "att.muzz_supp_weighted.name.full"
ATT.Icon = Material("entities/tacrp_att_muzz_supp_weighted.png", "mips smooth")
ATT.Description = "att.muzz_supp_weighted.desc"
ATT.Pros = {"stat.vol_shoot", "stat.range", "stat.recoil"}
ATT.Cons = {"rating.handling", "rating.maneuvering"}

ATT.Model = "models/weapons/tacint_extras/addons/suppressor_salvo.mdl"
ATT.Scale = 1.5

ATT.ModelOffset = Vector(0.4, 0, -0.05)

ATT.Category = "silencer"

ATT.SortOrder = 6

ATT.Add_Vol_Shoot = -30
ATT.Mult_RecoilKick = 0.75
ATT.Mult_RecoilSpreadPenalty = 0.9

ATT.Mult_Range_Max = 1.15
ATT.Mult_Range_Min = 1.15

ATT.Add_SprintToFireTime = 0.02
ATT.Add_AimDownSightsTime = 0.03

ATT.Add_FreeAimMaxAngle = 0.5
ATT.Add_Sway = 0.1
ATT.Add_ScopedSway = 0.05

ATT.Add_Pitch_Shoot = -7.5

ATT.Silencer = true
ATT.Override_MuzzleEffect = "muzzleflash_suppressed"

TacRP.LoadAtt(ATT, "muzz_supp_weighted")
-- #endregion


------------------------------
-- #region muzz_brake_aggressor (Aggressor Brake/A. Brake)
------------------------------
ATT = {}

ATT.PrintName = "att.muzz_brake_aggressor.name"
ATT.FullName = "att.muzz_brake_aggressor.name.full"
ATT.Icon = Material("entities/tacrp_att_muzz_brake_aggressor.png", "mips smooth")
ATT.Description = "att.muzz_brake_aggressor.desc"
ATT.Pros = {"stat.shootingspeed"}
ATT.Cons = {"stat.recoilstability", "stat.spread", "stat.vol_shoot"}

ATT.Model = "models/weapons/tacint_extras/addons/brake_aggressor.mdl"
ATT.Scale = 1.25

ATT.ModelOffset = Vector(-5.0, 0, 0)

ATT.Category = {"silencer", "brake"}

ATT.Add_ShootingSpeedMult = 0.05
ATT.Mult_RecoilStability = 0.9
ATT.Mult_Spread = 1.15
ATT.Add_Vol_Shoot = 5

ATT.SortOrder = 100

TacRP.LoadAtt(ATT, "muzz_brake_aggressor")
-- #endregion

------------------------------
-- #region muzz_brake_breaching (Breaching Brake/B. Brake)
------------------------------
ATT = {}

ATT.PrintName = "att.muzz_brake_breaching.name"
ATT.FullName = "att.muzz_brake_breaching.name.full"
ATT.Icon = Material("entities/tacrp_att_muzz_brake_breaching.png", "mips smooth")
ATT.Description = "att.muzz_brake_breaching.desc"
ATT.Pros = {"stat.meleedamage", "stat.recoilstability"}
ATT.Cons = {"stat.spread"}

ATT.Model = "models/weapons/tacint_extras/addons/brake_breacher.mdl"
ATT.Scale = 1.25

ATT.ModelOffset = Vector(-5.4, 0, 0)

ATT.Category = {"silencer", "brake"}

ATT.Mult_MeleeDamage = 1.4
ATT.Mult_Spread = 1.25
ATT.Mult_RecoilStability = 1.15

ATT.SortOrder = 101

TacRP.LoadAtt(ATT, "muzz_brake_breaching")
-- #endregion

------------------------------
-- #region muzz_brake_concussive (Concussive Brake/C. Brake)
------------------------------
ATT = {}

ATT.PrintName = "att.muzz_brake_concussive.name"
ATT.FullName = "att.muzz_brake_concussive.name.full"
ATT.Icon = Material("entities/tacrp_att_muzz_brake_concussive.png", "mips smooth")
ATT.Description = "att.muzz_brake_concussive.desc"
ATT.Pros = {"stat.recoilkick"}
ATT.Cons = {"stat.shootingspeed", "stat.spread", "stat.vol_shoot"}

ATT.Model = "models/weapons/tacint_extras/addons/brake_concussive.mdl"
ATT.Scale = 1.25

ATT.ModelOffset = Vector(-5.4, 0, 0)

ATT.Category = {"silencer", "brake"}

ATT.Mult_RecoilKick = 0.6
-- ATT.Mult_RecoilStability = 1.1

ATT.Add_ShootingSpeedMult = -0.4
ATT.Mult_Spread = 1.2

ATT.Add_Vol_Shoot = 15
ATT.Mult_Pitch_Shoot = 0.9

ATT.SortOrder = 102

ATT.Override_MuzzleEffect = "muzzleflash_pistol_deagle"

TacRP.LoadAtt(ATT, "muzz_brake_concussive")
-- #endregion