-- bolt_trigger.lua

local ATT = {}

------------------------------
-- #region bolt_fine (Refined Bolt)
------------------------------
ATT = {}

ATT.PrintName = "att.bolt_fine.name"
ATT.FullName = "att.bolt_fine.name.full"
ATT.Icon = Material("entities/tacrp_att_bolt_fine.png", "mips smooth")
ATT.Description = "att.bolt_fine.desc"
ATT.Pros = {"stat.recoildissipation"}
ATT.Cons = {"stat.recoilpershot"}

ATT.Category = "bolt_automatic"

ATT.SortOrder = 3

ATT.Mult_RecoilDissipationRate = 1.25
-- ATT.Mult_RecoilSpreadPenalty = 1.175
ATT.Mult_RecoilPerShot = 1.1

TacRP.LoadAtt(ATT, "bolt_fine")
-- #endregion

------------------------------
-- #region bolt_greased (Greased Bolt)
------------------------------
ATT = {}

ATT.PrintName = "att.bolt_greased.name"
ATT.FullName = "att.bolt_greased.name.full"
ATT.Icon = Material("entities/tacrp_att_bolt_greased.png", "mips smooth")
ATT.Description = "att.bolt_greased.desc"
ATT.Pros = {"stat.rpm"}
ATT.Cons = {"rating.mobility", "stat.recoil", "stat.muzzlevelocity"}

ATT.Category = "bolt_manual"

ATT.SortOrder = 1

ATT.Mult_RPM = 1.15
ATT.Mult_ShootTimeMult = 1 / 1.15

ATT.Add_RecoilVisualKick = 1
ATT.Mult_RecoilKick = 1.5
ATT.Add_ShootingSpeedMult = -0.1
ATT.Add_SightedSpeedMult = -0.05

ATT.Mult_MuzzleVelocity = 0.85

TacRP.LoadAtt(ATT, "bolt_greased")
-- #endregion

------------------------------
-- #region bolt_heavy (Heavy Bolt)
------------------------------
ATT = {}

ATT.PrintName = "att.bolt_heavy.name"
ATT.FullName = "att.bolt_heavy.name.full"
ATT.Icon = Material("entities/tacrp_att_bolt_heavy.png", "mips smooth")
ATT.Description = "att.bolt_heavy.desc"
ATT.Pros = {"stat.recoilkick", "stat.bloomintensity"}
ATT.Cons = {"stat.rpm"}

ATT.Category = "bolt_automatic"

ATT.SortOrder = 2

ATT.Mult_RPM = 0.85
ATT.Mult_RecoilVisualKick = 0.7
ATT.Mult_RecoilKick = 0.7
ATT.Mult_RecoilSpreadPenalty = 0.9

TacRP.LoadAtt(ATT, "bolt_heavy")
-- #endregion

------------------------------
-- #region bolt_light (Light Bolt)
------------------------------
ATT = {}

ATT.PrintName = "att.bolt_light.name"
ATT.FullName = "att.bolt_light.name.full"
ATT.Icon = Material("entities/tacrp_att_bolt_light.png", "mips smooth")
ATT.Description = "att.bolt_light.desc"
ATT.Pros = {"stat.rpm"}
ATT.Cons = {"stat.recoilkick", "stat.bloomintensity"}

ATT.Category = "bolt_automatic"

ATT.SortOrder = 1

ATT.Mult_RPM = 1.15
ATT.Mult_RecoilKick = 1.25
ATT.Mult_RecoilSpreadPenalty = 1.1

TacRP.LoadAtt(ATT, "bolt_light")
-- #endregion

------------------------------
-- #region bolt_rough (Rugged Bolt)
------------------------------
ATT = {}

ATT.PrintName = "att.bolt_rough.name"
ATT.FullName = "att.bolt_rough.name.full"
ATT.Icon = Material("entities/tacrp_att_bolt_rough.png", "mips smooth")
ATT.Description = "att.bolt_rough.desc"
ATT.Pros = {"stat.recoilpershot"}
ATT.Cons = {"stat.recoildissipation"}

ATT.Category = "bolt_automatic"

ATT.SortOrder = 4

ATT.Mult_RecoilDissipationRate = 0.75
-- ATT.Mult_RecoilSpreadPenalty = 0.825
ATT.Mult_RecoilPerShot = 0.9

TacRP.LoadAtt(ATT, "bolt_rough")
-- #endregion

------------------------------
-- #region bolt_surplus (Surplus Bolt)
------------------------------
ATT = {}

ATT.PrintName = "att.bolt_surplus.name"
ATT.FullName = "att.bolt_surplus.name.full"
ATT.Icon = Material("entities/tacrp_att_bolt_surplus.png", "mips smooth")
ATT.Description = "att.bolt_surplus.desc"
ATT.Pros = {"att.procon.surplusboost1", "stat.recoil"}
ATT.Cons = {"att.procon.surplusboost2", "att.procon.unreliable"}

ATT.Category = {"bolt_automatic", "bolt_manual"}

ATT.SortOrder = 9

ATT.Mult_RecoilSpreadPenalty = 0.8
ATT.Mult_RecoilKick = 0.75

ATT.Add_JamFactor = 0.4
-- ATT.Mult_ShootChance = 0.96

ATT.Hook_PostShoot = function(wep)
    if CLIENT then return end
    if (wep.TacRP_NextSurplusBoost or 0) < CurTime() and math.random() <= 0.5 then
        wep:SetNWFloat("TacRP_SurplusBoost", CurTime() + math.Rand(0.15, 0.4))
        wep.TacRP_NextSurplusBoost = CurTime() + math.Rand(0.5, 2)
    end
end

ATT.Hook_PostJam = function(wep)
    wep:SetNWFloat("TacRP_SurplusBoost", 0)
end

ATT.Hook_PostThink = function(wep)
    if wep:GetCurrentFiremode() != 1 and wep:GetNWFloat("TacRP_SurplusBoost", 0) >= CurTime() then
        wep:PrimaryAttack()
    end
end

hook.Add("TacRP_Stat_RPM", "bolt_surplus", function(wep, data)
    if wep:GetNWFloat("TacRP_SurplusBoost", 0) >= CurTime() then
        data.mul = data.mul * 1.15
    end
end)

hook.Add("TacRP_Stat_Pitch_Shoot", "bolt_surplus", function(wep, data)
    if wep:GetNWFloat("TacRP_SurplusBoost", 0) >= CurTime() then
        data.add = data.add + 7.5
    end
end)

TacRP.LoadAtt(ATT, "bolt_surplus")
-- #endregion

------------------------------
-- #region bolt_tactical (Tactical Bolt)
------------------------------
ATT = {}

ATT.PrintName = "att.bolt_tactical.name"
ATT.FullName = "att.bolt_tactical.name.full"
ATT.Icon = Material("entities/tacrp_att_bolt_tactical.png", "mips smooth")
ATT.Description = "att.bolt_tactical.desc"
ATT.Pros = {"stat.recoil", "stat.quickscope", "rating.mobility", "stat.muzzlevelocity"}
ATT.Cons = {"stat.rpm"}

ATT.Category = "bolt_manual"

ATT.SortOrder = 2

ATT.Mult_RPM = 0.85
ATT.Mult_ShootTimeMult = 1 / 0.85

ATT.Add_ShootingSpeedMult = 0.2
ATT.Add_SightedSpeedMult = 0.08
ATT.Mult_RecoilKick = 0.4
ATT.Mult_RecoilVisualKick = 0.5

ATT.Mult_MuzzleVelocity = 1.15
ATT.Mult_QuickScopeSpreadPenalty = 0.5
ATT.Mult_QuickScopeTime = 0.5


TacRP.LoadAtt(ATT, "bolt_tactical")
-- #endregion

------------------------------
-- #region bolt_refurbished (Refurbished Bolt)
------------------------------
ATT = {}

ATT.PrintName = "att.bolt_refurbished.name"
ATT.FullName = "att.bolt_refurbished.name.full"
ATT.Icon = Material("entities/tacrp_att_bolt_refurbished.png", "mips smooth")
ATT.Description = "att.bolt_refurbished.desc"
ATT.Pros = {"att.procon.reliability"}
ATT.Cons = {"stat.rpm", "stat.spread"}

ATT.Category = "bolt_jammable"

ATT.SortOrder = 10

ATT.Override_JamFactor = 0 -- This intentionally does not prevent surplus ammo from jamming!
ATT.Add_RPM = -50
ATT.Add_Spread = 0.003

ATT.Compatibility = function(wep)
    if wep:GetBaseValue("JamFactor") == 0 then
        return false
    end
end

TacRP.LoadAtt(ATT, "bolt_refurbished")
-- #endregion

------------------------------
-- #region trigger_akimbo (Akimbo Trigger)
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_akimbo.name"
ATT.FullName = "att.trigger_akimbo.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_akimbo.png", "mips smooth")
ATT.Description = "att.trigger_akimbo.desc"
ATT.Pros = {"att.procon.auto", "stat.recoilkick"}
ATT.Cons = {"stat.rpm"}

ATT.Free = true
ATT.Ignore = true

ATT.Category = "trigger_akimbo"

ATT.SortOrder = 0.5

ATT.Override_Firemodes = {2}
ATT.Mult_RPM = 0.9
ATT.Mult_RecoilKick = 0.75

TacRP.LoadAtt(ATT, "trigger_akimbo")
-- #endregion

------------------------------
-- #region trigger_wide (Wide Trigger)
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_wide.name"
ATT.FullName = "att.trigger_wide.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_wide.png", "mips smooth")
ATT.Description = "att.trigger_wide.desc"
ATT.Pros = {"stat.quickscope", "stat.peekpenalty", "stat.freeaimangle"}
ATT.Cons = {"stat.aimdownsights"}

ATT.Category = {"trigger_revolver", "trigger_manual"}

ATT.SortOrder = 5

ATT.Mult_PeekPenaltyFraction = 0.75
ATT.Mult_QuickScopeSpreadPenalty = 0.75
ATT.Mult_FreeAimMaxAngle = 0.85
-- ATT.Mult_HipFireSpreadPenalty = 0.75

ATT.Add_AimDownSightsTime = 0.03

TacRP.LoadAtt(ATT, "trigger_wide")
-- #endregion

------------------------------
-- #region trigger_burst (Burst Trigger)
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_burst.name"
ATT.FullName = "att.trigger_burst.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_burst.png", "mips smooth")
ATT.Description = "att.trigger_burst.desc"
ATT.Pros = {"stat.rpm", "rating.control"}
ATT.Cons = {"att.procon.burst"}

ATT.Category = {"trigger_auto"}

ATT.SortOrder = 1.1

ATT.Add_PostBurstDelay = 0.15
ATT.Add_RPMMultBurst = 0.25
ATT.Override_Firemodes = {-3, 1}
ATT.Override_RunawayBurst = true

ATT.Mult_RecoilSpreadPenalty = 0.75
ATT.Mult_RecoilVisualKick = 0.85
ATT.Mult_RecoilKick = 0.75

ATT.Mult_RecoilStability = 1.25

TacRP.LoadAtt(ATT, "trigger_burst")
-- #endregion

------------------------------
-- #region trigger_burst2
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_burst.name"
ATT.FullName = "att.trigger_burst.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_burst.png", "mips smooth")
ATT.Description = "att.trigger_burst2.desc"
ATT.Pros = {"att.procon.burst"}
ATT.Cons = {"stat.recoilkick", "stat.recoilstability"}

ATT.InvAtt = "trigger_burst"

ATT.Category = {"trigger_semi"}

ATT.SortOrder = 1.1

ATT.Override_Firemodes = {-3, 1}
ATT.Add_RPMMultBurst = 0.3
ATT.Override_RunawayBurst = true
ATT.Add_PostBurstDelay = 0.22

ATT.Mult_RecoilKick = 1.25
ATT.Mult_RecoilStability = 0.75

TacRP.LoadAtt(ATT, "trigger_burst2")
-- #endregion

------------------------------
-- #region trigger_burstauto (Auto-Burst Trigger)
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_burstauto.name"
ATT.FullName = "att.trigger_burstauto.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_burstauto.png", "mips smooth")
ATT.Description = "att.trigger_burstauto.desc"
ATT.Pros = {"att.procon.autoburst"}
ATT.Cons = {}

ATT.Category = {"trigger_burst", "trigger_burstauto", "trigger_4pos"}

ATT.SortOrder = 4

ATT.AutoBurst = true
-- ATT.Add_PostBurstDelay = 0.025
-- ATT.Add_RecoilResetTime = 0.03

TacRP.LoadAtt(ATT, "trigger_burstauto")
-- #endregion

------------------------------
-- #region trigger_comp (Competition Trigger)
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_comp.name"
ATT.FullName = "att.trigger_comp.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_comp.png", "mips smooth")
ATT.Description = "att.trigger_comp.desc"
ATT.Pros = {"stat.recoilfirstshot", "stat.recoilstability"}
ATT.Cons = {"stat.recoilmaximum"}

ATT.Category = {"trigger_semi", "trigger_auto", "trigger_burst", "trigger_akimbo", "trigger_revolver", "trigger", "trigger_4pos"}

ATT.SortOrder = 2

ATT.Mult_RecoilFirstShotMult = 0.75
ATT.Mult_RecoilMaximum = 1.5
ATT.Add_RecoilStability = 0.1

TacRP.LoadAtt(ATT, "trigger_comp")
-- #endregion

------------------------------
-- #region trigger_comp2
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_comp.name"
ATT.FullName = "att.trigger_comp.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_comp.png", "mips smooth")
ATT.Description = "Lightweight trigger that recovers from accuracy faster."
ATT.Pros = {"stat.recoildissipation", "stat.recoilstability"}
ATT.Cons = {"stat.shootingspeed"}

ATT.InvAtt = "trigger_comp"

ATT.Category = {"trigger_manual"}

ATT.SortOrder = 2

ATT.Mult_RecoilDissipationRate = 1.25
ATT.Mult_ShootingSpeedMult = 0.75
ATT.Add_RecoilStability = 0.15

TacRP.LoadAtt(ATT, "trigger_comp2")
-- #endregion

------------------------------
-- #region trigger_frcd (Forced Reset Trigger)
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_frcd.name"
ATT.FullName = "att.trigger_frcd.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_frcd.png", "mips smooth")
ATT.Description = "att.trigger_frcd.desc"
ATT.Pros = {"att.procon.auto"}
ATT.Cons = {"stat.recoilkick", "stat.bloomintensity", "stat.recoilstability"}

ATT.Category = "trigger_semi"

ATT.SortOrder = 1

ATT.Override_Firemodes = {2}
ATT.Override_Firemode = 2
ATT.Mult_RecoilKick = 1.25
ATT.Mult_RecoilSpreadPenalty = 1.15
ATT.Mult_RecoilStability = 0.5

TacRP.LoadAtt(ATT, "trigger_frcd")
-- #endregion

------------------------------
-- #region trigger_frcd2
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_frcd.name"
ATT.FullName = "att.trigger_frcd.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_frcd.png", "mips smooth")
ATT.Description = "att.trigger_frcd.desc"
ATT.Pros = {"att.procon.auto"}
ATT.Cons = {"stat.recoilkick", "stat.bloomintensity", "stat.recoilstability"}

ATT.InvAtt = "trigger_frcd"

ATT.Category = "trigger_burst"

ATT.SortOrder = 1

ATT.Override_Firemodes = {2}
ATT.Override_Firemode = 2
ATT.Mult_RecoilKick = 1.25
ATT.Mult_RecoilSpreadPenalty = 1.15
ATT.Mult_RecoilStability = 0.75

TacRP.LoadAtt(ATT, "trigger_frcd2")
-- #endregion

------------------------------
-- #region trigger_hair (Hair Trigger)
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_hair.name"
ATT.FullName = "att.trigger_hair.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_hair.png", "mips smooth")
ATT.Description = "att.trigger_hair.desc"
ATT.Pros = {"stat.rpm"}
ATT.Cons = {"stat.recoilmaximum", "stat.recoilstability", "stat.hipfirespread"}

ATT.Category = {"trigger_semi", "trigger_revolver"}

ATT.SortOrder = 4

ATT.Mult_RPMMultSemi = 1.2
ATT.Mult_RecoilMaximum = 1.25
ATT.Mult_RecoilStability = 0.5
ATT.Mult_HipFireSpreadPenalty = 1.15

TacRP.LoadAtt(ATT, "trigger_hair")
-- #endregion

------------------------------
-- #region trigger_hair_akimbo
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_hair.name"
ATT.FullName = "att.trigger_hair.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_hair.png", "mips smooth")
ATT.Description = "att.trigger_hair_akimbo.desc"
ATT.Pros = {"stat.rpm", "stat.postburstdelay"}
ATT.Cons = {"stat.recoilmaximum", "stat.recoil"}

ATT.Category = {"trigger_akimbo"}
ATT.InvATt = "trigger_hair"

ATT.SortOrder = 4

ATT.Mult_PostBurstDelay = 0.5

ATT.Mult_RPMMultSemi = 1.2
ATT.Mult_RPMMultBurst = 1.2
ATT.Mult_RecoilMaximum = 1.25
ATT.Mult_RecoilStability = 0.5
ATT.Mult_RecoilKick = 1.2

TacRP.LoadAtt(ATT, "trigger_hair_akimbo")

------------------------------
-- #region trigger_heavy (Weighted Trigger)
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_heavy.name"
ATT.FullName = "att.trigger_heavy.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_heavy.png", "mips smooth")
ATT.Description = "att.trigger_heavy.desc"
ATT.Pros = {"stat.recoilmaximum"}
ATT.Cons = {"stat.recoilfirstshot", "stat.recoilstability"}

ATT.Category = {"trigger_semi", "trigger_auto", "trigger_burst", "trigger_akimbo", "trigger_revolver", "trigger", "trigger_4pos"}

ATT.SortOrder = 3

ATT.Mult_RecoilFirstShotMult = 1.5
ATT.Mult_RecoilMaximum = 0.75
ATT.Add_RecoilStability = -0.1

TacRP.LoadAtt(ATT, "trigger_heavy")
-- #endregion

------------------------------
-- #region trigger_heavy2
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_heavy.name"
ATT.FullName = "att.trigger_heavy.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_heavy.png", "mips smooth")
ATT.Description = "att.trigger_heavy2.desc"
ATT.Pros = {"stat.shootingspeed"}
ATT.Cons = {"stat.recoildissipation", "stat.recoilstability"}

ATT.InvAtt = "trigger_heavy"

ATT.Category = {"trigger_manual"}

ATT.SortOrder = 3

ATT.Mult_RecoilDissipationRate = 0.85
ATT.Mult_ShootingSpeedMult = 1.25
ATT.Add_RecoilStability = -0.15

TacRP.LoadAtt(ATT, "trigger_heavy2")
-- #endregion

------------------------------
-- #region trigger_semi (Marksman Trigger)
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_semi.name"
ATT.FullName = "att.trigger_semi.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_semi.png", "mips smooth")
ATT.Description = "att.trigger_semi.desc"
ATT.Pros = {"stat.spread", "stat.recoil", "stat.rpm", "att.procon.reliability"}
ATT.Cons = {"att.procon.semi"}

ATT.Category = {"trigger_auto", "trigger_burst", "trigger_4pos"}

ATT.SortOrder = 1

ATT.Override_Firemodes = {1}
ATT.Mult_Spread = 0.3333
ATT.Mult_ShotgunPelletSpread = 0.5
ATT.Mult_RecoilSpreadPenalty = 0.75
ATT.Mult_RecoilKick = 0.6
ATT.Mult_RecoilVisualKick = 0.5
ATT.Mult_RecoilStability = 1.25
ATT.Add_RPM = 50
ATT.Mult_JamFactor = 0

TacRP.LoadAtt(ATT, "trigger_semi")
-- #endregion

------------------------------
-- #region trigger_slam (Slamfire Trigger)
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_slam.name"
ATT.FullName = "att.trigger_slam.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_frcd.png", "mips smooth")
ATT.Description = "att.trigger_frcd.desc"
ATT.Pros = {"stat.rpm", "att.procon.auto"}
ATT.Cons = {"stat.spread", "rating.mobility"}

ATT.Category = "trigger_pump"

ATT.SortOrder = 1

ATT.Override_Firemodes = {2}
ATT.Mult_RecoilKick = 1.25
ATT.Mult_RecoilSpreadPenalty = 1.25
ATT.Add_RecoilMaximum = 0.5

ATT.Mult_RPM = 1.15
ATT.Mult_ShootTimeMult = 1.25
ATT.Mult_ShootingSpeedMult = 0.75

TacRP.LoadAtt(ATT, "trigger_slam")
-- #endregion

------------------------------
-- #region trigger_slam2
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_slam.name"
ATT.FullName = "att.trigger_slam.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_frcd.png", "mips smooth")
ATT.Description = "att.trigger_frcd.desc"
ATT.Pros = {"stat.rpm", "att.procon.auto"}
ATT.Cons = {"stat.spread", "rating.mobility"}

ATT.Category = "trigger_pump2"
ATT.InvAtt = "trigger_slam"

ATT.SortOrder = 1

ATT.Override_Firemodes = {2}
ATT.Mult_RecoilKick = 1.25
ATT.Mult_RecoilSpreadPenalty = 1.25
ATT.Add_RecoilMaximum = 0.5

ATT.Mult_RPM = 1.15
ATT.Mult_ShootTimeMult = 1.4
ATT.Mult_ShootingSpeedMult = 0.75

TacRP.LoadAtt(ATT, "trigger_slam2")
-- #endregion

------------------------------
-- #region trigger_straight (Straight Trigger)
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_straight.name"
ATT.FullName = "att.trigger_straight.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_straight.png", "mips smooth")
ATT.Description = "att.trigger_straight.desc"
ATT.Pros = {"stat.bloomintensity", "stat.recoildissipation"}
ATT.Cons = {"stat.recoilresettime", "stat.shootingspeed"}

ATT.Category = {"trigger_auto", "trigger_straight", "trigger_4pos"}

ATT.SortOrder = 5.5

ATT.Mult_RecoilDissipationRate = 1.15
ATT.Mult_RecoilSpreadPenalty = 0.85

ATT.Add_RecoilResetTime = 0.075
ATT.Add_ShootingSpeedMult = -0.08

TacRP.LoadAtt(ATT, "trigger_straight")
-- #endregion

------------------------------
-- #region trigger_dualstage (Dual Stage Trigger/D. Stage)
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_dualstage.name"
ATT.FullName = "att.trigger_dualstage.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_dualstage.png", "mips smooth")
ATT.Description = "att.trigger_dualstage.desc"
ATT.Pros = {"att.procon.aimrecoil", "att.procon.aimspread"}
ATT.Cons = {"att.procon.aimrpm"}

ATT.SortOrder = 10

ATT.Category = {"trigger_auto", "trigger_semi", "trigger_burst", "trigger_4pos"}

ATT.Func_RPM = function(wep, data)
    if wep:GetScopeLevel() > 0 and not wep:GetPeeking() then
        data.mul = data.mul * 0.7
    end
end

ATT.Func_RecoilKick = function(wep, data)
    if wep:GetScopeLevel() > 0 and not wep:GetPeeking() then
        data.mul = data.mul * 0.5
    end
end

ATT.Func_RecoilPerShot = function(wep, data)
    if wep:GetScopeLevel() > 0 and not wep:GetPeeking() then
        data.mul = data.mul * 0.5
    end
end

ATT.Func_Spread = function(wep, data)
    if wep:GetScopeLevel() > 0 and not wep:GetPeeking() then
        data.mul = data.mul * 0.5
    end
end

TacRP.LoadAtt(ATT, "trigger_dualstage")
-- #endregion


------------------------------
-- #region trigger_tactical (Tactical Trigger)
------------------------------
ATT = {}

ATT.PrintName = "att.trigger_tactical.name"
ATT.FullName = "att.trigger_tactical.name.full"
ATT.Icon = Material("entities/tacrp_att_trigger_burstauto.png", "mips smooth")
ATT.Description = "att.trigger_tactical.desc"
ATT.Pros = {"stat.recoilburst", "stat.recoilsemi"}
ATT.Cons = {"stat.postburstdelay"}

ATT.Category = {"trigger_auto", "trigger_burstauto", "trigger_4pos"}

ATT.SortOrder = 11

ATT.Add_RecoilMultBurst = -0.15
ATT.Add_RecoilMultSemi = -0.2
ATT.Add_PostBurstDelay = 0.02

TacRP.LoadAtt(ATT, "trigger_tactical")
-- #endregion