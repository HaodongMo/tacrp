-- acc.lua

local ATT = {}

------------------------------
-- #region acc_bipod (Bipod)
------------------------------
ATT = {}
ATT.Ignore = true

ATT.PrintName = "att.acc_bipod.name"
ATT.Icon = Material("entities/tacrp_att_acc_bipod.png", "mips smooth")
ATT.Description = "att.acc_bipod.desc"
ATT.Pros = {"stat.recoilcrouch", "stat.swaycrouch"}

ATT.Category = "acc_bipod"


ATT.SortOrder = 5.5

ATT.Mult_RecoilMultCrouch = 0.2
ATT.Mult_SwayCrouchMult = 0.15

ATT.InstalledElements = {"bipod"}

TacRP.LoadAtt(ATT, "acc_bipod")
-- #endregion

------------------------------
-- #region acc_brace (Pistol Brace)
------------------------------
ATT = {}

ATT.PrintName = "att.acc_brace.name"
ATT.Icon = Material("entities/tacrp_att_acc_brace.png", "mips smooth")
ATT.Description = "att.acc_brace.desc"
ATT.Pros = {"rating.control", "rating.stability"}
ATT.Cons = {"rating.handling", "rating.maneuvering"}

ATT.Category = "acc_brace"

ATT.SortOrder = 3

ATT.Mult_RecoilKick = 0.3
ATT.Mult_RecoilSpreadPenalty = 0.75

ATT.Mult_Sway = 0.75
ATT.Add_ScopedSway = -0.2
ATT.Mult_ScopedSway = 0.75

ATT.Add_AimDownSightsTime = 0.06
ATT.Add_SprintToFireTime = 0.1

ATT.Add_HipFireSpreadPenalty = 0.0075
ATT.Add_FreeAimMaxAngle = 0.75

ATT.Mult_DeployTimeMult = 1.5
ATT.Mult_HolsterTimeMult = 1.5

TacRP.LoadAtt(ATT, "acc_brace")
-- #endregion

------------------------------
-- #region acc_cheekrest (Cheek Rest)
------------------------------
ATT = {}

ATT.PrintName = "att.acc_cheekrest.name"
ATT.Icon = Material("entities/tacrp_att_acc_cheekrest.png", "mips smooth")
ATT.Description = "att.acc_cheekrest.desc"
ATT.Pros = {"stat.scopedsway", "stat.bloomintensity"}

ATT.Category = "acc_sling"

ATT.SortOrder = 7

ATT.Mult_ScopedSway = 0.5
ATT.Mult_RecoilSpreadPenalty = 0.95

TacRP.LoadAtt(ATT, "acc_cheekrest")
-- #endregion

------------------------------
-- #region acc_conceal (Concealed Carry Holster/Concealment)
------------------------------
ATT = {}

ATT.PrintName = "att.acc_concealment.name"
ATT.FullName = "att.acc_concealment.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_conceal.png", "mips smooth")
ATT.Description = "att.acc_concealment.desc"
ATT.Pros = {"att.procon.conceal"}

ATT.Category = "acc_holster"

ATT.SortOrder = 8

ATT.Override_HolsterVisible = false

ATT.Ignore = false -- engine.ActiveGamemode() != "terrortown"

TacRP.LoadAtt(ATT, "acc_conceal")
-- #endregion

------------------------------
-- #region acc_ergo (Ergonomic Grip/Ergo Grip)
------------------------------
ATT = {}

ATT.PrintName = "att.acc_ergo.name"
ATT.FullName = "att.acc_ergo.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_ergo.png", "mips smooth")
ATT.Description = "Grooved grip makes aiming faster and moving while shooting easier."

ATT.Category = "acc"

ATT.SortOrder = 2

if engine.ActiveGamemode() == "terrortown" then
    ATT.Pros = {"stat.shootingspeed"}

    ATT.Add_ShootingSpeedMult = 0.15
else
    ATT.Pros = {"stat.shootingspeed", "stat.aimdownsights"}

    ATT.Add_ShootingSpeedMult = 0.08
    ATT.Mult_AimDownSightsTime = 0.85
end

TacRP.LoadAtt(ATT, "acc_ergo")
-- #endregion

------------------------------
-- #region acc_dual_ergo
------------------------------
ATT = {}

ATT.PrintName = "att.acc_ergo.name"
ATT.FullName = "att.acc_ergo.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_ergo.png", "mips smooth")
ATT.Description = "att.acc_dual_ergo.name.desc"

ATT.Category = "acc_dual"
ATT.InvAtt = "acc_ergo"

ATT.SortOrder = 2

ATT.Pros = {"stat.shootingspeed"}
ATT.Add_ShootingSpeedMult = 0.08

TacRP.LoadAtt(ATT, "acc_dual_ergo")
-- #endregion

------------------------------
-- #region acc_quickdraw (Quickdraw Holster)
------------------------------
ATT = {}

ATT.PrintName = "att.acc_quickdraw.name"
ATT.FullName = "att.acc_quickdraw.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_quickdraw.png", "mips smooth")
ATT.Description = "att.acc_quickdraw.name.desc"
ATT.Pros = {"stat.deploytime", "stat.reloadtime"}

ATT.Category = "acc_holster"

ATT.SortOrder = 4

--ATT.Mult_DeployTimeMult = 0.6
ATT.Mult_HolsterTimeMult = 0.5
ATT.Mult_ReloadTimeMult = 0.925

ATT.TryUnholster = true

TacRP.LoadAtt(ATT, "acc_quickdraw")
-- #endregion

------------------------------
-- #region acc_dual_quickdraw
------------------------------
ATT = {}

ATT.PrintName = "att.acc_quickdraw.name"
ATT.FullName = "att.acc_dual_quickdraw.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_quickdraw.png", "mips smooth")
ATT.Description = "att.acc_dual_quickdraw.name.desc"
ATT.Pros = {"stat.deploytime", "stat.reloadtime"}

ATT.Category = "acc_dual"
ATT.InvAtt = "acc_quickdraw"

ATT.SortOrder = 4

ATT.Mult_DeployTimeMult = 0.75
ATT.Mult_HolsterTimeMult = 0.5

ATT.Mult_ReloadTimeMult = 0.95

ATT.TryUnholster = true

TacRP.LoadAtt(ATT, "acc_dual_quickdraw")
-- #endregion

------------------------------
-- #region acc_skel (Lightweight Grip/Light Grip)
------------------------------
ATT = {}

ATT.PrintName = "att.acc_skel.name"
ATT.FullName = "att.acc_skel.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_skel.png", "mips smooth")
ATT.Description = "att.acc_skel.desc"
ATT.Pros = {"Sighted Speed", "Sprint To Fire Time"}

ATT.Category = "acc"

ATT.SortOrder = 2.1

if engine.ActiveGamemode() == "terrortown" then
    ATT.Pros = {"stat.sightedspeed"}

    ATT.Add_SightedSpeedMult = 0.12
else
    ATT.Pros = {"stat.sightedspeed", "stat.sprinttofire"}

    ATT.Add_SightedSpeedMult = 0.08
    ATT.Mult_SprintToFireTime = 0.85
end

TacRP.LoadAtt(ATT, "acc_skel")
-- #endregion

------------------------------
-- #region acc_dual_skel
------------------------------
ATT = {}

ATT.PrintName = "att.acc_skel.name"
ATT.FullName = "att.acc_skel.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_skel.png", "mips smooth")
ATT.Description = "att.acc_dual_skel.desc"

ATT.Category = "acc_dual"
ATT.InvAtt = "acc_skel"

ATT.SortOrder = 2.1

ATT.Pros = {"stat.movespeed", "stat.reloadspeed"}
ATT.Add_MoveSpeedMult = 0.08
ATT.Add_ReloadSpeedMult = 0.1

TacRP.LoadAtt(ATT, "acc_dual_skel")
-- #endregion

------------------------------
-- #region acc_duffelbag (Gun Bag)
------------------------------
ATT = {}

ATT.PrintName = "att.acc_duffelbag.name"
ATT.Icon = Material("entities/tacrp_dufflebag.png", "mips smooth")
ATT.Description = "att.acc_duffelbag.desc"
ATT.Pros = {"Conceal weapon in bag"}

ATT.Category = "acc_duffle"

ATT.SortOrder = 8

ATT.Override_HolsterVisible = true
ATT.HolsterModel = "models/jessev92/payday2/item_bag_loot.mdl"
ATT.HolsterSlot = TacRP.HOLSTER_SLOT_BACK
ATT.HolsterPos = Vector(7, -2, 0)
ATT.HolsterAng = Angle(10, 90, 90)

ATT.Ignore = true

TacRP.LoadAtt(ATT, "acc_duffelbag")
-- #endregion

------------------------------
-- #region acc_extendedbelt (Box Extender)
------------------------------
ATT = {}

ATT.PrintName = "att.acc_extendedbelt.name"
ATT.Fullname = "att.acc_extendedbelt.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_extendedbelt.png", "mips smooth")
ATT.Description = "att.acc_extendedbelt.desc"
ATT.Pros = {"stat.clipsize"}
ATT.Cons = {"stat.reloadtime"}

ATT.Category = "extendedbelt"

ATT.SortOrder = 1

ATT.Add_ClipSize = 25
ATT.Mult_ReloadTimeMult = 1.05

TacRP.LoadAtt(ATT, "acc_extendedbelt")
-- #endregion

------------------------------
-- #region acc_extmag_dual (Extended Mag)
------------------------------
ATT = {}

ATT.PrintName = "att.acc_extmag.name"
ATT.FullName = "att.acc_extmag.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_extmag_dual.png", "mips smooth")
ATT.Description = "att.acc_extmag.desc"
ATT.Pros = {"stat.clipsize"}

ATT.Category = "acc_extmag_dual"

ATT.InvAtt = "acc_extmag_rifle"

ATT.SortOrder = 1

ATT.Add_ClipSize = 4

TacRP.LoadAtt(ATT, "acc_extmag_dual")
-- #endregion

------------------------------
-- #region acc_extmag_dual2
------------------------------
ATT = {}

ATT.PrintName = "att.acc_extmag.name"
ATT.FullName = "att.acc_extmag.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_extmag_dual.png", "mips smooth")
ATT.Description = "att.acc_extmag.desc"
ATT.Pros = {"stat.clipsize"}

ATT.Category = "acc_extmag_dual2"

ATT.InvAtt = "acc_extmag_rifle"

ATT.SortOrder = 1

ATT.Add_ClipSize = 2

TacRP.LoadAtt(ATT, "acc_extmag_dual2")
-- #endregion

------------------------------
-- #region acc_extmag_dualsmg
------------------------------
ATT = {}

ATT.PrintName = "att.acc_extmag.name"
ATT.FullName = "att.acc_extmag.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_extmag_dual.png", "mips smooth")
ATT.Description = "att.acc_extmag.desc"
ATT.Pros = {"stat.clipsize"}
ATT.Cons = {"stat.reloadtime"}

ATT.Category = "acc_extmag_dualsmg"

ATT.InvAtt = "acc_extmag_rifle"

ATT.SortOrder = 1

ATT.Add_ClipSize = 8
ATT.Mult_ReloadTimeMult = 1.05

TacRP.LoadAtt(ATT, "acc_extmag_dualsmg")
-- #endregion

------------------------------
-- #region acc_extmag_pistol
------------------------------
ATT = {}

ATT.PrintName = "att.acc_extmag.name"
ATT.FullName = "att.acc_extmag.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_extmag_pistol.png", "mips smooth")
ATT.Description = "att.acc_extmag.desc"
ATT.Pros = {"stat.clipsize"}
ATT.Cons = {"stat.reloadtime"}

ATT.Category = "acc_extmag_pistol"

ATT.InvAtt = "acc_extmag_rifle"

ATT.SortOrder = 1

ATT.Add_ClipSize = 3

ATT.Mult_ReloadTimeMult = 1.03

TacRP.LoadAtt(ATT, "acc_extmag_pistol")
-- #endregion

------------------------------
-- #region acc_extmag_pistol2
------------------------------
ATT = {}

ATT.PrintName = "att.acc_extmag.name"
ATT.FullName = "att.acc_extmag.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_extmag_pistol.png", "mips smooth")
ATT.Description = "att.acc_extmag.desc"
ATT.Pros = {"stat.clipsize"}
ATT.Cons = {"stat.reloadtime"}

ATT.Category = "acc_extmag_pistol2"

ATT.InvAtt = "acc_extmag_rifle"

ATT.SortOrder = 1

ATT.Add_ClipSize = 2

ATT.Mult_ReloadTimeMult = 1.03

TacRP.LoadAtt(ATT, "acc_extmag_pistol2")
-- #endregion

------------------------------
-- #region acc_extmag_rifle
------------------------------
ATT = {}

ATT.PrintName = "att.acc_extmag.name"
ATT.FullName = "att.acc_extmag.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_extmag_rifle.png", "mips smooth")
ATT.Description = "att.acc_extmag.desc"
ATT.Pros = {"stat.clipsize"}
ATT.Cons = {"stat.reloadtime"}

ATT.Category = "perk_extendedmag"

ATT.SortOrder = 1

ATT.Add_ClipSize = 5

ATT.Mult_ReloadTimeMult = 1.05

TacRP.LoadAtt(ATT, "acc_extmag_rifle")
-- #endregion

------------------------------
-- #region acc_extmag_rifle2
------------------------------
ATT = {}

ATT.PrintName = "att.acc_extmag.name"
ATT.FullName = "att.acc_extmag.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_extmag_rifle2.png", "mips smooth")
ATT.Description = "att.acc_extmag.desc"
ATT.Pros = {"stat.clipsize"}
ATT.Cons = {"stat.reloadtime"}

ATT.Category = "acc_extmag_rifle2"

ATT.InvAtt = "acc_extmag_rifle"

ATT.SortOrder = 1

ATT.Add_ClipSize = 4

ATT.Mult_ReloadTimeMult = 1.05

TacRP.LoadAtt(ATT, "acc_extmag_rifle2")
-- #endregion

------------------------------
-- #region acc_extmag_shotgun (Leaving the original as a backup for third-party weapons/weapon packs that may rely on it)
------------------------------
ATT = {}

ATT.PrintName = "att.acc_extmag.name"
ATT.FullName = "att.acc_extmag.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_extmag_shotgun.png", "mips smooth")
ATT.Description = "att.acc_extmag.desc"
ATT.Pros = {"stat.clipsize"}
ATT.Cons = {"stat.reloadtime"}

ATT.Category = {"acc_extmag_shotgun"}

ATT.InvAtt = "acc_extmag_rifle"

ATT.SortOrder = 1

ATT.Add_ClipSize = 2

ATT.Mult_ReloadTimeMult = 1.03

TacRP.LoadAtt(ATT, "acc_extmag_shotgun")
-- #endregion

------------------------------
-- #region acc_extmag_shotgun_mag
------------------------------
ATT = {}

ATT.PrintName = "att.acc_extmag.name"
ATT.FullName = "att.acc_extmag.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_extmag_shotgun.png", "mips smooth") -- make new icon maybe?
ATT.Description = "att.acc_extmag.desc"
ATT.Pros = {"stat.clipsize"}
ATT.Cons = {"stat.reloadtime"}

ATT.Category = {"acc_extmag_shotgun_mag"}

ATT.InvAtt = "acc_extmag_rifle"

ATT.SortOrder = 1

ATT.Add_ClipSize = 5

ATT.Mult_ReloadTimeMult = 1.05

TacRP.LoadAtt(ATT, "acc_extmag_shotgun_mag")
-- #endregion

------------------------------
-- #region acc_extmag_shotgun_tube (Tube Extender)
------------------------------
ATT = {}

ATT.PrintName = "att.acc_extmag_shotgun_tube.name"
ATT.FullName = "att.acc_extmag_shotgun_tube.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_extmag_shotgun.png", "mips smooth")
ATT.Description = "att.acc_extmag.desc"
ATT.Pros = {"stat.clipsize"}
ATT.Cons = {"stat.reloadtime"}

ATT.Category = {"acc_extmag_shotgun_tube"}

ATT.InvAtt = "acc_extmag_rifle"

ATT.SortOrder = 1

ATT.Add_ClipSize = 2

ATT.Mult_ReloadTimeMult = 1.03

TacRP.LoadAtt(ATT, "acc_extmag_shotgun_tube")
-- #endregion

------------------------------
-- #region acc_extmag_smg
------------------------------
ATT = {}

ATT.PrintName = "att.acc_extmag.name"
ATT.FullName = "att.acc_extmag.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_extmag_smg.png", "mips smooth")
ATT.Description = "att.acc_extmag.desc"
ATT.Pros = {"stat.clipsize"}
ATT.Cons = {"stat.reloadtime"}

ATT.Category = "acc_extmag_smg"

ATT.InvAtt = "acc_extmag_rifle"

ATT.SortOrder = 1

ATT.Add_ClipSize = 5

ATT.Mult_ReloadTimeMult = 1.05

TacRP.LoadAtt(ATT, "acc_extmag_smg")
-- #endregion

------------------------------
-- #region acc_extmag_sniper
------------------------------
ATT = {}

ATT.PrintName = "att.acc_extmag.name"
ATT.FullName = "att.acc_extmag.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_extmag_sniper.png", "mips smooth")
ATT.Description = "att.acc_extmag.desc"
ATT.Pros = {"stat.clipsize"}
ATT.Cons = {"stat.reloadtime"}

ATT.Category = "acc_extmag_sniper"

ATT.InvAtt = "acc_extmag_rifle"

ATT.SortOrder = 1

ATT.Add_ClipSize = 2

ATT.Mult_ReloadTimeMult = 1.03

TacRP.LoadAtt(ATT, "acc_extmag_sniper")
-- #endregion

------------------------------
-- #region acc_foldstock (Fold Stock)
------------------------------
ATT = {}

ATT.PrintName = "att.acc_foldstock.name"
ATT.Icon = Material("entities/tacrp_att_acc_foldstock.png", "mips smooth")
ATT.Description = "att.acc_foldstock.desc"
ATT.Pros = {"rating.handling", "rating.maneuvering"}
ATT.Cons = {"stat.recoilkick", "stat.scopedsway"}

ATT.Free = true

ATT.Category = "acc_foldstock"

ATT.SortOrder = 0.5

ATT.Mult_RecoilVisualKick = 2

ATT.Mult_SightedSpeedMult = 1.25
ATT.Mult_HipFireSpreadPenalty = 0.7

ATT.Add_RecoilKick = 1
ATT.Mult_RecoilKick = 1.5

-- ATT.Mult_SprintToFireTime = 0.75
-- ATT.Mult_AimDownSightsTime = 0.75
ATT.Add_SprintToFireTime = -0.08
ATT.Add_AimDownSightsTime = -0.08

ATT.Add_ScopedSway = 0.1
ATT.Mult_ScopedSway = 2
ATT.Mult_Sway = 0.8
ATT.Add_FreeAimMaxAngle = -1

ATT.InstalledElements = {"foldstock"}

ATT.TryUnholster = true
ATT.Mult_HolsterTimeMult = 0.5

TacRP.LoadAtt(ATT, "acc_foldstock")
-- #endregion

------------------------------
-- #region acc_foldstock2 (Adjust Stock)
------------------------------
ATT = {}

ATT.PrintName = "att.acc_foldstock2.name"
ATT.Icon = Material("entities/tacrp_att_acc_foldstock.png", "mips smooth")
ATT.Description = "att.acc_foldstock2.name"
ATT.Pros = {"rating.handling", "rating.maneuvering"}
ATT.Cons = {"stat.recoilkick", "stat.scopedsway"}

ATT.Free = true

ATT.Category = "acc_foldstock2"

ATT.SortOrder = 0.5

ATT.Mult_RecoilVisualKick = 1.65
ATT.Mult_SightedSpeedMult = 1.125
ATT.Mult_HipFireSpreadPenalty = 0.85

ATT.Add_RecoilKick = 0.5
ATT.Mult_RecoilKick = 1.25

-- ATT.Mult_SprintToFireTime = 0.85
-- ATT.Mult_AimDownSightsTime = 0.85
ATT.Add_SprintToFireTime = -0.04
ATT.Add_AimDownSightsTime = -0.04

ATT.Add_ScopedSway = 0.1
ATT.Mult_Sway = 0.9
ATT.Add_FreeAimMaxAngle = -0.5

ATT.InstalledElements = {"foldstock"}

ATT.TryUnholster = true
ATT.Mult_HolsterTimeMult = 0.75

TacRP.LoadAtt(ATT, "acc_foldstock2")
-- #endregion

------------------------------
-- #region acc_pad (Recoil Pad)
------------------------------
ATT = {}

ATT.PrintName = "att.acc_pad.name"
ATT.Icon = Material("entities/tacrp_att_acc_pad.png", "mips smooth")
ATT.Description = "att.acc_pad.desc"
ATT.Pros = {"stat.recoilkick"}

ATT.Category = "acc_sling"

ATT.SortOrder = 6

ATT.Mult_RecoilVisualKick = 0.9

ATT.Add_RecoilKick = -0.5
ATT.Mult_RecoilKick = 0.95

TacRP.LoadAtt(ATT, "acc_pad")
-- #endregion

------------------------------
-- #region acc_sling (Sling)
------------------------------
ATT = {}

ATT.PrintName = "att.acc_sling.name"
ATT.Icon = Material("entities/tacrp_att_acc_sling.png", "mips smooth")
ATT.Description = "att.acc_sling.desc"
ATT.Pros = {"stat.deploytime", "stat.reloadtime"}

ATT.Category = {"acc_sling", "acc_slingonly"}

ATT.SortOrder = 5

ATT.Mult_DeployTimeMult = 0.75
ATT.Mult_HolsterTimeMult = 0.75
ATT.Mult_ReloadTimeMult = 0.925

TacRP.LoadAtt(ATT, "acc_sling")
-- #endregion