-- ammo.lua

local ATT = {}

------------------------------
-- #region ammo_40mm_3gl
------------------------------
ATT = {}

ATT.PrintName = "3GL"
ATT.FullName = "40mm Cluster Grenades"

ATT.Icon = Material("entities/tacrp_att_ammo_40mm_3gl.png", "mips smooth")
ATT.Description = "Three weak cluster grenades, fired at once."
ATT.Pros = {"att.procon.moreproj"}
ATT.Cons = {"stat.spread", "stat.muzzlevelocity"}

ATT.Category = "ammo_40mm"

ATT.SortOrder = 1

ATT.ShootEnt = "tacrp_proj_40mm_3gl"
ATT.Num = 3

ATT.InstalledElements = {"3gl"}

ATT.Override_Damage_Max = 60
ATT.Override_Damage_Min = 60

ATT.Override_Spread = 0.05
ATT.Override_ShotgunPelletSpread = 0.025
ATT.Override_MidAirSpreadPenalty = 0
ATT.Override_HipFireSpreadPenalty = 0

ATT.Mult_ShootEntForce = 0.85

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_40mm_3gl")
-- #endregion

------------------------------
-- #region ammo_40mm_buck
------------------------------
ATT = {}

ATT.PrintName = "Buckshot"
ATT.FullName = "40mm Buckshot Grenades"
ATT.Icon = Material("entities/tacrp_att_ammo_40mm_buck.png", "mips smooth")
ATT.Description = "Flat-top grenade firing shotgun pellets. Weak due to low pressure curve."
ATT.Pros = {"att.procon.direct", "att.procon.doorbreach"}
ATT.Cons = {"att.procon.noexp"}

ATT.Category = "ammo_40mm"

ATT.Override_Ammo = "buckshot" -- extremely not realism

ATT.SortOrder = 2

ATT.Override_ShootEnt = false

ATT.NoRanger = false

ATT.Override_Damage_Max = 9
ATT.Override_Damage_Min = 2
ATT.Override_Num = 18
ATT.Override_Range_Min = 50
ATT.Override_Range_Max = 1200

ATT.Override_Spread = 0.05
ATT.Override_ShotgunPelletSpread = 0.05

ATT.Override_HipFireSpreadPenalty = 0
ATT.Override_MidAirSpreadPenalty = 0

ATT.Override_MuzzleVelocity = 9500

ATT.Override_Sound_ShootAdd = "^TacRP/weapons/m4star10/fire-2.wav"
ATT.Override_Pitch_Shoot = 95

ATT.DoorBreach = true
ATT.DoorBreachThreshold = 120

ATT.InstalledElements = {"buck"}

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_40mm_buck")
-- #endregion

------------------------------
-- #region ammo_40mm_gas
------------------------------
ATT = {}

ATT.PrintName = "CS Gas"
ATT.FullName = "40mm CS Gas Grenades"

ATT.Icon = Material("entities/tacrp_att_ammo_40mm_lvg.png", "mips smooth")
ATT.Description = "Grenade containing crowd control chemicals that deal lingering damage."
ATT.Pros = {"att.procon.crowd"}
ATT.Cons = {"att.procon.noexp", "att.procon.nonlethal"}

ATT.Category = {"ammo_40mm", "ammo_40mm_civ"}

ATT.SortOrder = 3.5

ATT.ShootEnt = "tacrp_proj_40mm_gas"

ATT.InstalledElements = {"lvg"}

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_40mm_gas")
-- #endregion

------------------------------
-- #region ammo_40mm_heat
------------------------------
ATT = {}

ATT.PrintName = "Flechette"
ATT.FullName = "40mm Flechette Grenades"

ATT.Icon = Material("entities/tacrp_att_ammo_40mm_heat.png", "mips smooth")
ATT.Description = "Flat-top grenade packing accurate flechette darts."
ATT.Pros = {"att.procon.direct", "stat.spread", "stat.armorpenetration"}
ATT.Cons = {"att.procon.noexp"}

ATT.Category = "ammo_40mm"

ATT.Override_Ammo = "buckshot" -- extremely not realism

ATT.SortOrder = 2.5

ATT.Override_ShootEnt = false

ATT.InstalledElements = {"buck"} --{"heat"}

ATT.Override_NoRanger = false

ATT.Override_Damage_Max = 14
ATT.Override_Damage_Min = 6
ATT.Override_Num = 8
ATT.Override_Range_Min = 500
ATT.Override_Range_Max = 2000
ATT.Override_Penetration = 6

ATT.Override_ArmorPenetration = 0.8

ATT.Override_Spread = 0.015
ATT.Override_ShotgunPelletSpread = 0.02

ATT.Override_HipFireSpreadPenalty = 0.03
ATT.Override_MidAirSpreadPenalty = 0


ATT.MuzzleVelocity = 15000

ATT.Override_Sound_ShootAdd = "^tacrp/weapons/m4star10/fire-2.wav"
ATT.Override_Pitch_Shoot = 110

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_40mm_heat")
-- #endregion

------------------------------
-- #region ammo_40mm_impact
------------------------------
ATT = {}

ATT.PrintName = "Dummy"
ATT.Icon = Material("entities/tacrp_att_ammo_40mm_smoke.png", "mips smooth")
ATT.Description = ""
ATT.Pros = {"Infinite ammo"}
ATT.Cons = {"Impact only"}

ATT.Category = {"ammo_40mm", "ammo_40mm_civ"}

ATT.ShootEnt = "tacrp_proj_40mm_impact"
ATT.Mult_ShootEntForce = 1

ATT.InfiniteAmmo = true

ATT.InstalledElements = {"smoke"}

ATT.Ignore = true

TacRP.LoadAtt(ATT, "ammo_40mm_impact")
-- #endregion

------------------------------
-- #region ammo_40mm_lvg
------------------------------
ATT = {}

ATT.PrintName = "Concussion" --"LVG"
ATT.FullName = "40mm Concussion Grenades"

ATT.Icon = Material("entities/tacrp_att_ammo_40mm_concussion.png", "mips smooth")
ATT.Description = "Low velocity grenade made to incapacitate targets with indirect fire."
ATT.Pros = {"att.procon.detdelay", "att.procon.flash"}
ATT.Cons = {"stat.muzzlevelocity", "stat.damage"}

ATT.Category = {"ammo_40mm", "ammo_40mm_civ"}

ATT.SortOrder = 3

ATT.ShootEnt = "tacrp_proj_40mm_lvg"
ATT.Mult_ShootEntForce = 0.5

ATT.InstalledElements = {"lvg"}

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_40mm_lvg")
-- #endregion

------------------------------
-- #region ammo_40mm_ratshot
------------------------------
ATT = {}

ATT.PrintName = "Ratshot"
ATT.FullName = "40mm Ratshot Grenades"
ATT.Icon = Material("entities/tacrp_att_ammo_40mm_ratshot.png", "mips smooth")
ATT.Description = "For rodents of unbelievable size."
ATT.Pros = {"att.procon.radius", "att.procon.proxfuse"}
ATT.Cons = {"stat.damage", "stat.muzzlevelocity"}

ATT.Category = "ammo_40mm"

ATT.SortOrder = 2.9

ATT.Override_Damage_Max = 80
ATT.Override_Damage_Min = 80

ATT.ShootEnt = "tacrp_proj_40mm_ratshot"
ATT.Mult_ShootEntForce = 0.75

ATT.InstalledElements = {"smoke"}

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
    ATT.Override_Damage_Max = 60
    ATT.Override_Damage_Min = 60
end

TacRP.LoadAtt(ATT, "ammo_40mm_ratshot")
-- #endregion

------------------------------
-- #region ammo_40mm_smoke
------------------------------
ATT = {}

ATT.PrintName = "Smoke"
ATT.FullName = "40mm Smoke Grenades"

ATT.Icon = Material("entities/tacrp_att_ammo_40mm_smoke.png", "mips smooth")
ATT.Description = "Grenade that produces a concealing smokescreen on impact."
ATT.Pros = {"att.procon.smoke"}
ATT.Cons = {"att.procon.noexp"}

ATT.Category = {"ammo_40mm", "ammo_40mm_civ"}

ATT.SortOrder = 4

ATT.ShootEnt = "tacrp_proj_40mm_smoke"

ATT.InstalledElements = {"smoke"}

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_40mm_smoke")
-- #endregion

------------------------------
-- #region ammo_40mm_heal
------------------------------
ATT = {}

ATT.PrintName = "Medi-Smoke"
ATT.FullName = "40mm Medi-Smoke Grenades"

ATT.Icon = Material("entities/tacrp_att_ammo_40mm_smoke.png", "mips smooth")
ATT.Description = "Grenade that produces a cloud of restorative gas on impact."
ATT.Pros = {"att.procon.heal"}
ATT.Cons = {"att.procon.noexp"}

ATT.Category = {"ammo_40mm", "ammo_40mm_civ"}

ATT.SortOrder = 4.1

ATT.ShootEnt = "tacrp_proj_40mm_heal"

ATT.InstalledElements = {"smoke"}

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_40mm_heal")
-- #endregion

------------------------------
-- #region ammo_amr_hv
------------------------------
ATT = {}

ATT.PrintName = "HV"
ATT.FullName = "High Velocity Rounds"
ATT.Icon = Material("entities/tacrp_att_acc_match.png", "mips smooth")
ATT.Description = "Bullets with much higher velocity, but worsens overpenetration."
ATT.Pros = {"stat.range", "stat.muzzlevelocity"}
ATT.Cons = {"stat.damage_max"}

ATT.Category = {"ammo_amr", "ammo_sniper"}

ATT.SortOrder = 2.5

ATT.Mult_MuzzleVelocity = 1.5

ATT.Mult_Range_Max = 1.25
ATT.Mult_Damage_Max = 0.85

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_amr_hv")
-- #endregion

------------------------------
-- #region ammo_amr_ratshot
------------------------------
ATT = {}

ATT.PrintName = "Ratshot"
ATT.FullName = "Ratshot Rounds"
ATT.Icon = Material("entities/tacrp_att_ammo_amr_ratshot.png", "mips smooth")
ATT.Description = "For rodents of unusual size."
ATT.Pros = {"att.procon.moreproj", "spacer.maneuvering"}
ATT.Cons = {"stat.damage", "stat.spread"}

ATT.Category = {"ammo_amr"}

ATT.SortOrder = 5

ATT.Mult_MuzzleVelocity = 0.75

ATT.Override_Num = 16
ATT.Override_Damage_Max = 6
ATT.Override_Damage_Min = 4
ATT.Override_Penetration = 1

ATT.Mult_HipFireSpreadPenalty = 0.5
ATT.Mult_MidAirSpreadPenalty = 0.5

ATT.Add_Spread = 0.01
ATT.Add_ShotgunPelletSpread = 0.02

ATT.Override_BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 0.75,
    [HITGROUP_RIGHTLEG] = 0.75,
    [HITGROUP_GEAR] = 0.75
}

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_amr_ratshot")
-- #endregion

------------------------------
-- #region ammo_amr_saphe
------------------------------
ATT = {}

ATT.PrintName = "SAPHE"
ATT.FullName = "Semi-Armor-Piercing High-Explosive Rounds"
ATT.Icon = Material("entities/tacrp_att_acc_saphe.png", "mips smooth")
ATT.Description = "Explosive rounds effective against both armor and personnel."
ATT.Pros = {"att.procon.explosive", "stat.penetration"}
ATT.Cons = {"stat.rpm", "stat.clipsize", "stat.muzzlevelocity"}

ATT.Category = "ammo_amr"

ATT.SortOrder = 4

ATT.ExplosiveEffect = "HelicopterMegaBomb"
ATT.ExplosiveDamage = 60
ATT.ExplosiveRadius = 200

ATT.Add_Damage_Max = -60
ATT.Add_Damage_Min = -60

ATT.Mult_MuzzleVelocity = 0.667

ATT.Mult_Penetration = 1.5

ATT.Mult_ClipSize = 0.51

ATT.Mult_RPM = 0.85
ATT.Mult_ShootTimeMult = 1 / 0.85

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_amr_saphe")
-- #endregion

------------------------------
-- #region ammo_ks23_flashbang
------------------------------
ATT = {}

ATT.PrintName = "Zvezda"
ATT.FullName = "KS-23 Zvezda Flash Shells"
ATT.Icon = Material("entities/tacrp_att_ammo_ks23_flashbang.png", "mips smooth")
ATT.Description = "Flashbang shells that stun enemies, right from the barrel."
ATT.Pros = {"att.procon.flash"}
ATT.Cons = {"att.procon.timedfuse", "att.procon.nonlethal"}

ATT.SortOrder = 1
ATT.Category = "ammo_ks23"

ATT.Override_MuzzleEffect = "muzzleflash_smg"

ATT.ShootEnt = "tacrp_proj_ks23_flashbang"

ATT.Num = 1
ATT.ShootEntForce = 1200

TacRP.LoadAtt(ATT, "ammo_ks23_flashbang")
-- #endregion

------------------------------
-- #region ammo_ks23_flashbang_top
------------------------------
ATT = {}

ATT.PrintName = "Zvezda (Top)"
ATT.FullName = "KS-23 Zvezda Flash Shells (Top-loaded)"
ATT.Icon = Material("entities/tacrp_att_ammo_ks23_flashbang.png", "mips smooth")
ATT.Description = "Load the first round with flash rounds and the rest with standard shells."
ATT.Pros = {"att.procon.flash"}
ATT.Cons = {"att.procon.firstround"}

ATT.SortOrder = 1.1
ATT.Category = "ammo_ks23"
ATT.InvAtt = "ammo_ks23_flashbang"

ATT.ShootEntForce = 1200

ATT.Func_Num = function(wep, modifiers)
    if wep:Clip1() == wep:GetMaxClip1() then
        modifiers.set = 1
        modifiers.prio = 10
    end
end
ATT.Func_ShootEnt = function(wep, modifiers)
    if wep:Clip1() == wep:GetMaxClip1() then
        modifiers.set = "tacrp_proj_ks23_flashbang"
        modifiers.prio = 10
    end
end
ATT.Func_MuzzleEffect = function(wep, modifiers)
    if wep:Clip1() == wep:GetMaxClip1() - 1 then
        modifiers.set = "muzzleflash_smg"
        modifiers.prio = 10
    end
end

TacRP.LoadAtt(ATT, "ammo_ks23_flashbang_top")
-- #endregion

------------------------------
-- #region ammo_magnum
------------------------------
ATT = {}

ATT.PrintName = "+P"
ATT.FullName = "Overpressured Rounds"
ATT.Icon = Material("entities/tacrp_att_acc_plusp.png", "mips smooth")
ATT.Description = "Bullets that maintain close range power better, but have higher recoil."
ATT.Pros = {"stat.range_min", "stat.muzzlevelocity"}
ATT.Cons = {"stat.recoilkick", "stat.spread"}

ATT.Category = {"ammo_pistol", "ammo_rifle"}

ATT.SortOrder = 5

ATT.Add_RecoilKick = 0.25
ATT.Mult_RecoilKick = 1.15
ATT.Mult_Spread = 1.25
ATT.Mult_MuzzleVelocity = 1.25
ATT.Add_Range_Min = 400
-- ATT.Mult_Range_Min = 1.25

TacRP.LoadAtt(ATT, "ammo_magnum")
-- #endregion

------------------------------
-- #region ammo_pistol_ap
------------------------------
ATT = {}

ATT.PrintName = "Steel Core"
ATT.FullName = "Steel Core Rounds"

ATT.Icon = Material("entities/tacrp_att_ammo_pistol_ap.png", "mips smooth")
ATT.Description = "Hardened bullets better penetrate armor, but destabilize ballistics."
ATT.Pros = {"att.procon.armor", "stat.penetration"}
ATT.Cons = {"stat.spread", "stat.muzzlevelocity", "stat.range"}

ATT.Category = {"ammo_pistol", "ammo_pistol_sub"}

ATT.SortOrder = 1.5

ATT.Add_Penetration = 5
ATT.Add_ArmorPenetration = 0.1
ATT.Add_ArmorBonus = 0.25

ATT.Mult_MuzzleVelocity = 0.85
ATT.Mult_Range_Max = 0.85
ATT.Mult_Spread = 1.25


TacRP.LoadAtt(ATT, "ammo_pistol_ap")
-- #endregion

------------------------------
-- #region ammo_pistol_headshot
------------------------------
ATT = {}

ATT.PrintName = "Skullsplitter"
ATT.FullName = "Skullsplitter Rounds"
ATT.Icon = Material("entities/tacrp_att_acc_skullsplitter.png", "mips smooth")
ATT.Description = "Specialized rounds that do more damage to vital body parts."
ATT.Pros = {"att.procon.head", "stat.spread"}
ATT.Cons = {"att.procon.limb", "stat.armorbonus"}

ATT.Category = {"ammo_pistol", "ammo_pistol_sub"}

ATT.SortOrder = 1.25

ATT.Mult_Spread = 0.85
ATT.Mult_ArmorBonus = 0.5

ATT.Override_BodyDamageMultipliersExtra = {
    [HITGROUP_HEAD] = 1.5,
    [HITGROUP_LEFTARM] = 0.8,
    [HITGROUP_RIGHTARM] = 0.8,
    [HITGROUP_LEFTLEG] = 0.75,
    [HITGROUP_RIGHTLEG] = 0.75,
    [HITGROUP_GEAR] = 0.75
}

TacRP.LoadAtt(ATT, "ammo_pistol_headshot")
-- #endregion

------------------------------
-- #region ammo_pistol_hollowpoints
------------------------------
ATT = {}

ATT.PrintName = "Hollow-points"
ATT.FullName = "Hollow-point Rounds"

ATT.Icon = Material("entities/tacrp_att_acc_hollowpoints.png", "mips smooth")
ATT.Description = "Bullets that expand on hit, improving damage to flesh targets and limbs."
ATT.Pros = {"att.procon.chest", "att.procon.limb"}
ATT.Cons = {"att.procon.head", "att.procon.armor", "stat.penetration"}

ATT.Category = {"ammo_pistol", "ammo_pistol_sub"}

ATT.SortOrder = 1

ATT.Mult_Penetration = 0.2
ATT.Mult_ArmorPenetration = 0.75
ATT.Mult_ArmorBonus = 0.75

ATT.Override_BodyDamageMultipliersExtra = {
    [HITGROUP_HEAD] = 0.75,
    [HITGROUP_CHEST] = 1.15,
    [HITGROUP_LEFTARM] = -1,
    [HITGROUP_RIGHTARM] = -1,
    [HITGROUP_LEFTLEG] = -1,
    [HITGROUP_RIGHTLEG] = -1,
    [HITGROUP_GEAR] = -1,
}

TacRP.LoadAtt(ATT, "ammo_pistol_hollowpoints")
-- #endregion


------------------------------
-- #region ammo_rifle_jhp
------------------------------
ATT = {}

ATT.PrintName = "JHP"
ATT.FullName = "Jacketed Hollow-point Rounds"
ATT.Icon = Material("entities/tacrp_att_ammo_rifle_jhp.png", "mips smooth")
ATT.Description = "Bullets that expand on hit, improving damage to flesh targets and limbs."
ATT.Pros = {"att.procon.chest", "att.procon.limb"}
ATT.Cons = {"stat.range", "att.procon.armor", "stat.penetration"}

ATT.Category = {"ammo_rifle", "ammo_rifle_sub"}

ATT.SortOrder = 1

ATT.Mult_Range_Min = 0.5
ATT.Mult_Range_Max = 0.85
ATT.Mult_Penetration = 0.2
ATT.Mult_ArmorPenetration = 0.75
ATT.Mult_ArmorBonus = 0.5

ATT.Override_BodyDamageMultipliersExtra = {
    [HITGROUP_CHEST] = 1.25,
    [HITGROUP_LEFTARM] = -1,
    [HITGROUP_RIGHTARM] = -1,
    [HITGROUP_LEFTLEG] = -1,
    [HITGROUP_RIGHTLEG] = -1,
    [HITGROUP_GEAR] = -1,
}


TacRP.LoadAtt(ATT, "ammo_rifle_jhp")
-- #endregion

------------------------------
-- #region ammo_pistol_match
------------------------------
ATT = {}

ATT.PrintName = "Match"
ATT.FullName = "Pistol Match Rounds"
ATT.Icon = Material("entities/tacrp_att_ammo_pistol_match.png", "mips smooth")
ATT.Description = "Bullets with improved range and accuracy."
ATT.Pros = {"stat.spread", "stat.range_max"}
ATT.Cons = {"stat.hipfirespread", "stat.peekpenalty"}

ATT.Category = {"ammo_pistol", "ammo_pistol_sub"}

ATT.SortOrder = 4.5

ATT.Mult_Spread = 0.667
ATT.Add_Range_Max = 750
ATT.Add_HipFireSpreadPenalty = 0.01
ATT.Add_PeekPenaltyFraction = 0.05

TacRP.LoadAtt(ATT, "ammo_pistol_match")
-- #endregion

------------------------------
-- #region ammo_rifle_match
------------------------------
ATT = {}

ATT.PrintName = "Match"
ATT.FullName = "Rifle Match Rounds"
ATT.Icon = Material("entities/tacrp_att_acc_match.png", "mips smooth")
ATT.Description = "Bullets with greatly improved accuracy."
ATT.Pros = {"stat.spread", "stat.muzzlevelocity", "stat.bloomintensity"}
ATT.Cons = {"stat.hipfirespread", "att.procon.limb"}

ATT.Category = {"ammo_rifle", "ammo_rifle_sub"}

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

TacRP.LoadAtt(ATT, "ammo_rifle_match")
-- #endregion

------------------------------
-- #region ammo_roulette
------------------------------
ATT = {}

ATT.PrintName = "Roulette"
ATT.FullName = "Russian Roulette"
ATT.Icon = Material("entities/tacrp_att_acc_roulette.png", "mips smooth")
ATT.Description = "A lethal game of chance. Spin the cylinder while loaded to reset the odds."
ATT.Pros = {}
ATT.Cons = {"att.procon.onebullet"}
ATT.Category = {"ammo_roulette"}

ATT.Free = true

ATT.SortOrder = -1

--ATT.Mult_ShootChance = 1 / 6
ATT.Override_ClipSize = 1
ATT.Override_AmmoPerShot = 1

ATT.Hook_PreReload = function(wep)
    if wep:StillWaiting(true) then return end
    if wep:Clip1() < 1 then return end
    if wep:Ammo1() <= 0 and !wep:GetValue("InfiniteAmmo") then return end

    if SERVER then
        wep:SetNWInt("TacRP_RouletteShot", math.random(1, wep:GetBaseValue("ClipSize")))
        wep:PlayAnimation("jam", 1, true, true)
        wep:SetNextPrimaryFire(CurTime() + 1)
        wep:GetOwner():DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM)
    end
    return true
end

ATT.Hook_EndReload = function(wep)
    if SERVER then
        wep:SetNWInt("TacRP_RouletteShot", math.random(1, wep:GetBaseValue("ClipSize")))
    end
end

ATT.Hook_PreShoot = function(wep)
    if SERVER and wep:GetNWInt("TacRP_RouletteShot", 0) == 0 then
        wep:SetNWInt("TacRP_RouletteShot", math.random(1, wep:GetBaseValue("ClipSize")))
    end

    if wep:GetNWInt("TacRP_RouletteShot") != wep:GetNthShot() % wep:GetBaseValue("ClipSize") + 1 then
        wep.Primary.Automatic = false
        if wep:GetBlindFire() then
            wep:PlayAnimation("blind_dryfire")
        else
            wep:PlayAnimation("dryfire")
        end
        wep:EmitSound(wep:GetValue("Sound_DryFire"), 75, 100, 1, CHAN_BODY)
        wep:SetBurstCount(0)
        wep:SetNthShot(wep:GetNthShot() + 1)
        wep:SetNextPrimaryFire(CurTime() + (60 / wep:GetValue("RPM")))
        wep:GetOwner():DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL)

        return true
    end
end

if engine.ActiveGamemode() == "terrortown" then
    ATT.Pros = {"att.procon.explosive"}
    ATT.ExplosiveEffect = "HelicopterMegaBomb"
    ATT.ExplosiveDamage = 60
    ATT.ExplosiveRadius = 256
end

TacRP.LoadAtt(ATT, "ammo_roulette")
-- #endregion

------------------------------
-- #region ammo_rpg_improvised
------------------------------
ATT = {}

ATT.PrintName = "Improvised"
ATT.FullName = "RPG-7 Improvised Warhead"
ATT.Icon = Material("entities/tacrp_att_ammo_rpg_improvised.png", "mips smooth")
ATT.Description = "Straight from the bargain bin."
ATT.Pros = {"att.procon.refund", "att.procon.nosafety", "rating.mobility"}
ATT.Cons = {"att.procon.projrng", "att.procon.failrng"}

ATT.Category = "ammo_rpg"

ATT.SortOrder = 1

ATT.Override_ShootEnt = "tacrp_proj_rpg7_improvised"
ATT.Add_ShootingSpeedMult = 0.3
ATT.Add_ReloadSpeedMult = 0.15

ATT.Override_ShootEntForce = 0

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

ATT.Hook_PostShootEnt = function(wep)
    if CLIENT then return end
    if wep:GetOwner():IsPlayer() and !wep:GetInfiniteAmmo() and math.random() <= 0.3 then
        wep:GetOwner():GiveAmmo(math.random(1, wep:GetValue("AmmoPerShot")), wep:GetPrimaryAmmoType(), true)
    end
end

TacRP.LoadAtt(ATT, "ammo_rpg_improvised")
-- #endregion

------------------------------
-- #region ammo_rpg_mortar
------------------------------
ATT = {}

ATT.PrintName = "Mortar"
ATT.FullName = "RPG-7 Mortar Warhead"
ATT.Icon = Material("entities/tacrp_att_ammo_rpg_mortar.png", "mips smooth")
ATT.Description = "A mortar with a booster stuck to it, for \"indirect fire\". Needs time to prime."
ATT.Pros = {"att.procon.radius"}
ATT.Cons = {"att.procon.needprime"}

ATT.Category = "ammo_rpg"

ATT.SortOrder = 3

ATT.Override_ShootEnt = "tacrp_proj_rpg7_mortar"

ATT.Override_ShootEntForce = 2500

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_rpg_mortar")
-- #endregion

------------------------------
-- #region ammo_rpg_ratshot
------------------------------
ATT = {}

ATT.PrintName = "Ratshot"
ATT.FullName = "RPG-7 Ratshot Warhead"
ATT.Icon = Material("entities/tacrp_att_ammo_rpg_ratshot.png", "mips smooth")
ATT.Description = "For rodents of unacceptable size."
ATT.Pros = {"att.procon.airburst"}
ATT.Cons = {"att.procon.timedfuse"}

ATT.Category = "ammo_rpg"

ATT.SortOrder = 2

ATT.Override_ShootEnt = "tacrp_proj_rpg7_ratshot"
ATT.Override_ShootEntForce = 1000

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_rpg_ratshot")
-- #endregion

------------------------------
-- #region ammo_rpg_harpoon
------------------------------
ATT = {}

ATT.PrintName = "Shovel"
ATT.FullName = "RPG-7 Shovel Warhead"
ATT.Icon = Material("entities/tacrp_att_ammo_rpg_improvised.png", "mips smooth")
ATT.Description = "Fire shovels, somehow. Either you're crazy, out of rockets, or both."
ATT.Pros = {"att.procon.shovel"}
ATT.Cons = {"att.procon.shovel"}

ATT.Category = "ammo_rpg"
ATT.Free = true

ATT.SortOrder = 9

ATT.Mult_HipFireSpreadPenalty = 0.5

ATT.Override_ShootEnt = "tacrp_proj_rpg7_harpoon"
ATT.Add_ShootingSpeedMult = 0.6
ATT.Add_ReloadSpeedMult = 0.4

ATT.Add_RPM = 60

ATT.ReloadTimeMult = 0.9

ATT.Mult_ShootEntForce = 0.85

ATT.Override_Sound_Shoot = "weapons/crossbow/fire1.wav"

ATT.Override_DefaultBodygroups = "02"
ATT.Override_DefaultWMBodygroups = "02"

ATT.Ammo = "xbowbolt"

ATT.Mult_ReloadTimeMult = 0.85

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_rpg_harpoon")
-- #endregion

------------------------------
-- #region ammo_shotgun_bird
------------------------------
ATT = {}

ATT.PrintName = "Birdshot"
ATT.Icon = Material("entities/tacrp_att_acc_bird.png", "mips smooth")
ATT.Description = "Fire smaller pellets in a larger spread."
ATT.Pros = {"att.procon.moreproj", "stat.recoil"}
ATT.Cons = {"stat.spread"}

ATT.Category = {"ammo_shotgun", "ammo_shotgun2"}

ATT.SortOrder = 2

ATT.Add_ArmorPenetration = -0.1

ATT.Mult_Damage_Min = 0.55
ATT.Mult_Damage_Max = 0.55

ATT.Mult_Num = 2
ATT.Mult_RecoilKick = 0.85

-- ATT.Add_Spread = 0.02
-- ATT.Add_ShotgunPelletSpread = 0.008

ATT.Mult_Spread = 1.75
ATT.Mult_ShotgunPelletSpread = 1.75

TacRP.LoadAtt(ATT, "ammo_shotgun_bird")
-- #endregion

------------------------------
-- #region ammo_shotgun_mag
------------------------------
ATT = {}

ATT.PrintName = "Magnum Buck"
ATT.FullName = "Magnum Buckshot"
ATT.Icon = Material("entities/tacrp_att_acc_magnum.png", "mips smooth")
ATT.Description = "High yield powder improves damage retention past point blank."
ATT.Pros = {"stat.range_min", "stat.muzzlevelocity"}
ATT.Cons = {"stat.recoil", "rating.mobility"}

ATT.Category = {"ammo_shotgun", "ammo_shotgun2"}

ATT.SortOrder = 3

ATT.Add_Range_Min = 250

ATT.Mult_RecoilKick = 1.5
ATT.Mult_MuzzleVelocity = 1.5

ATT.Add_Spread = 0.005
ATT.Add_ShotgunPelletSpread = 0.005

ATT.Mult_RecoilSpreadPenalty = 1.25

ATT.Mult_ShootingSpeedMult = 0.8

TacRP.LoadAtt(ATT, "ammo_shotgun_mag")
-- #endregion

------------------------------
-- #region ammo_shotgun_slugs
------------------------------
ATT = {}

ATT.PrintName = "att.ammo_shotgun_slugs.name"
ATT.FullName = "att.ammo_shotgun_slugs.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_slugs.png", "mips smooth")
ATT.Description = "att.ammo_shotgun_slugs.desc"
ATT.Pros = {"stat.spread", "stat.range"}
ATT.Cons = {"att.procon.1proj", "stat.hipfirespread"}

ATT.Category = "ammo_shotgun"

ATT.SortOrder = 4

ATT.Add_ArmorPenetration = 0.2

ATT.Mult_Damage_Min = 6
ATT.Mult_Damage_Max = 6

ATT.Mult_Range_Max = 1.5

ATT.Num = 1

ATT.Mult_Spread = 0.2
ATT.Mult_RecoilSpreadPenalty = 0.25

ATT.Add_HipFireSpreadPenalty = 0.025

ATT.Mult_MuzzleVelocity = 1.5

ATT.Override_MuzzleEffect = "muzzleflash_slug"

ATT.Override_BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1.25,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
    [HITGROUP_LEFTLEG] = 0.75,
    [HITGROUP_RIGHTLEG] = 0.75,
    [HITGROUP_GEAR] = 0.75
}

TacRP.LoadAtt(ATT, "ammo_shotgun_slugs")
-- #endregion

------------------------------
-- #region ammo_shotgun_slugs2
------------------------------
ATT = {}

ATT.PrintName = "att.ammo_shotgun_slugs.name"
ATT.FullName = "att.ammo_shotgun_slugs.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_slugs.png", "mips smooth")
ATT.Description = "att.ammo_shotgun_slugs.desc"
ATT.Pros = {"stat.spread", "stat.range"}
ATT.Cons = {"att.procon.1proj", "stat.hipfirespread"}

ATT.Category = "ammo_shotgun2"
ATT.InvAtt = "ammo_shotgun_slugs"

ATT.SortOrder = 4

ATT.Add_ArmorPenetration = 0.15

ATT.Mult_Damage_Min = 7
ATT.Mult_Damage_Max = 4.5

ATT.Mult_Range_Min = 1.5
ATT.Mult_Range_Max = 1.5

ATT.Num = 1

ATT.Mult_Spread = 0.2
ATT.Mult_RecoilSpreadPenalty = 0.25

ATT.Add_HipFireSpreadPenalty = 0.025

ATT.Mult_MuzzleVelocity = 1.5

ATT.Override_MuzzleEffect = "muzzleflash_slug"

ATT.Override_BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1.25,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
    [HITGROUP_LEFTLEG] = 0.75,
    [HITGROUP_RIGHTLEG] = 0.75,
    [HITGROUP_GEAR] = 0.75
}

TacRP.LoadAtt(ATT, "ammo_shotgun_slugs2")
-- #endregion

------------------------------
-- #region ammo_shotgun_triple
------------------------------
ATT = {}

ATT.PrintName = "att.ammo_shotgun_triple.name"
ATT.FullName = "att.ammo_shotgun_triple.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_triple.png", "mips smooth")
ATT.Description = "att.ammo_shotgun_triple.desc"
ATT.Pros = {"stat.spread"}
ATT.Cons = {"att.procon.3proj", "stat.hipfirespread"}

ATT.Category = "ammo_shotgun"

ATT.SortOrder = 5

ATT.Add_ArmorPenetration = 0.1

ATT.Mult_Damage_Max = 2.5
ATT.Mult_Damage_Min = 2.5

ATT.Num = 3

ATT.Mult_Spread = 0.33333
ATT.Mult_ShotgunPelletSpread = 0.5

ATT.Mult_RecoilSpreadPenalty = 0.5

ATT.Add_HipFireSpreadPenalty = 0.01

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

TacRP.LoadAtt(ATT, "ammo_shotgun_triple")
-- #endregion

------------------------------
-- #region ammo_shotgun_triple2
------------------------------
ATT = {}

ATT.PrintName = "att.ammo_shotgun_triple.name"
ATT.FullName = "att.ammo_shotgun_triple.name.full"
ATT.Icon = Material("entities/tacrp_att_acc_triple.png", "mips smooth")
ATT.Description = "att.ammo_shotgun_triple.desc"
ATT.Pros = {"stat.spread"}
ATT.Cons = {"att.procon.3proj", "stat.hipfirespread"}

ATT.Category = "ammo_shotgun2"
ATT.InvAtt = "ammo_shotgun_triple"

ATT.SortOrder = 5

ATT.Add_ArmorPenetration = 0.075

ATT.Mult_Damage_Max = 2
ATT.Mult_Damage_Min = 2

ATT.Num = 3

ATT.Mult_Spread = 0.33333
ATT.Mult_ShotgunPelletSpread = 0.5

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

TacRP.LoadAtt(ATT, "ammo_shotgun_triple2")
-- #endregion

------------------------------
-- #region ammo_subsonic
------------------------------
ATT = {}

ATT.PrintName = "Subsonic"
ATT.FullName = "Subsonic Rounds"
ATT.Icon = Material("entities/tacrp_att_acc_subsonic.png", "mips smooth")
ATT.Description = "Bullets with reduced powder load."
ATT.Pros = {"att.procon.notracer", "stat.recoil"}
ATT.Cons = {"stat.muzzlevelocity", "stat.range_max"}

ATT.Category = {"ammo_rifle", "ammo_pistol"}

ATT.SortOrder = 2

ATT.Mult_RecoilKick = 0.75
ATT.Mult_RecoilSpreadPenalty = 0.75
ATT.TracerNum = 0
ATT.Mult_MuzzleVelocity = 0.75
ATT.Mult_Vol_Shoot = 0.9
ATT.Mult_Range_Max = 0.75

TacRP.LoadAtt(ATT, "ammo_subsonic")
-- #endregion

------------------------------
-- #region ammo_surplus
------------------------------
ATT = {}

ATT.PrintName = "Surplus"
ATT.FullName = "Surplus Rounds"
ATT.Icon = Material("entities/tacrp_att_acc_surplus.png", "mips smooth")
ATT.Description = "Unreliable old ammo, yet you keep finding them everywhere."
ATT.Pros = {"att.procon.refund", "stat.recoil"}
ATT.Cons = {"att.procon.unreliable"}
ATT.Category = {"ammo_rifle", "ammo_sniper", "ammo_pistol", "ammo_amr", "ammo_shotgun", "ammo_shotgun2", "ammo_rifle_sub", "ammo_pistol_sub"}

ATT.SortOrder = 999

-- ATT.Mult_SupplyLimit = 2
-- ATT.Mult_ShootChance = 0.98

ATT.Mult_RecoilSpreadPenalty = 0.9
ATT.Mult_RecoilKick = 0.85

ATT.Add_JamFactor = 0.2
ATT.Add_ShootPitchVariance = 2

ATT.Hook_PostShoot = function(wep)
    if CLIENT then return end
    if wep:GetOwner():IsPlayer() and !wep:GetInfiniteAmmo() and math.random() <= 0.5 then
        wep:GetOwner():GiveAmmo(math.random(1, wep:GetValue("AmmoPerShot")), wep:GetPrimaryAmmoType(), true)
    end
end

TacRP.LoadAtt(ATT, "ammo_surplus")
-- #endregion

------------------------------
-- #region ammo_tmj
------------------------------
ATT = {}

ATT.PrintName = "TMJ"
ATT.FullName = "Total Metal Jacket Rounds"
ATT.Icon = Material("entities/tacrp_att_acc_tmj.png", "mips smooth")
ATT.Description = "Bullets with improved penetration capability."
ATT.Pros = {"att.procon.armor", "stat.penetration"}
ATT.Cons = {"stat.recoilfirstshot", "stat.recoilmaximum"}
ATT.Category = {"ammo_rifle", "ammo_sniper", "ammo_amr", "ammo_rifle_sub"}

ATT.SortOrder = 1.5

ATT.Add_Penetration = 10
ATT.Add_RecoilFirstShotMult = 1
ATT.Add_RecoilMaximum = 2
ATT.Add_ArmorPenetration = 0.05

TacRP.LoadAtt(ATT, "ammo_tmj")
-- #endregion


------------------------------
-- #region ammo_buckshot_roulette
------------------------------
ATT = {}

ATT.PrintName = "B. Roulette"
ATT.FullName = "Buckshot Roulette"
ATT.Icon = Material("entities/tacrp_att_ammo_buckshot_roulette.png", "mips smooth")
ATT.Description = "The shells enter the chamber in an unknown order."
ATT.Cons = {"att.procon.nopartialreloads"}
ATT.Category = "ammo_shotgun"

ATT.SortOrder = -1

ATT.Free = true

ATT.ShotgunFullCancel = true
ATT.Override_Firemodes = {1}
ATT.Override_Priority_Firemodes = 999

ATT.OnPresetLoad = function(wep)
    if SERVER then
        local blanks = math.random(1, wep:GetValue("ClipSize") - 1)
        wep:SetNWInt("TacRP_RouletteBlanks", blanks)

        wep:GetOwner():PrintMessage(HUD_PRINTCENTER, tostring(wep:GetValue("ClipSize") - blanks) .. " LIVE, " .. tostring(blanks) .. " BLANK.")
    end
end

ATT.OnAttach = function(wep)
    if SERVER then
        wep:SetNWInt("TacRP_RouletteBlanks", 0)
        wep:Unload()
    end
end

ATT.OnDetach = function(wep)
    if SERVER then
        wep:SetNWInt("TacRP_RouletteBlanks", 0)
        wep:Unload()
    end
end

ATT.Hook_PreReload = function(wep)
    if wep:StillWaiting(true) then return end
    if wep:Ammo1() <= 0 and !wep:GetValue("InfiniteAmmo") then return end

    if wep:Clip1() > 0 then return true end

    return
end

ATT.Hook_EndReload = function(wep)
    if SERVER then
        local blanks = math.random(1, wep:Clip1() - 1)
        wep:SetNWInt("TacRP_RouletteBlanks", blanks)

        wep:GetOwner():PrintMessage(HUD_PRINTCENTER, tostring(wep:Clip1() - blanks) .. " LIVE, " .. tostring(blanks) .. " BLANK.")
    end
end

ATT.Hook_InsertReload = function(wep)
    if SERVER then
        local blanks = math.random(1, wep:Clip1() - 1)
        wep:SetNWInt("TacRP_RouletteBlanks", blanks)
    end
end

ATT.Hook_CancelReload = function(wep)
    if SERVER then
        local blanks = wep:GetNWInt("TacRP_RouletteBlanks")

        wep:GetOwner():PrintMessage(HUD_PRINTCENTER, tostring(wep:Clip1() - blanks) .. " LIVE, " .. tostring(blanks) .. " BLANK.")
    end
end

ATT.Hook_PreShoot = function(wep)
    local chance = wep:GetNWInt("TacRP_RouletteBlanks") / wep:Clip1()

    if util.SharedRandom("tacRP_blankChance", 0, 1) <= chance then
        if SERVER then
            wep:SetNWInt("TacRP_RouletteBlanks", wep:GetNWInt("TacRP_RouletteBlanks") - 1)
        end

        wep.Primary.Automatic = false
        wep:PlayAnimation("jam")
        wep:EmitSound(wep:GetValue("Sound_DryFire"), 75, 100, 1, CHAN_BODY)
        wep:SetBurstCount(0)
        wep:SetNthShot(wep:GetNthShot() + 1)
        wep:SetNextPrimaryFire(CurTime() + math.max(60 / wep:GetValue("RPM"), 1))
        wep:GetOwner():DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL)

        wep:TakePrimaryAmmo(wep:GetValue("AmmoPerShot"))

        return true
    else
        return
    end
end

TacRP.LoadAtt(ATT, "ammo_buckshotroulette")
-- #endregion

------------------------------
-- #region ammo_shotgun_minishell
------------------------------
ATT = {}

ATT.PrintName = "Mini"
ATT.FullName = "Minishells"
ATT.Icon = Material("entities/tacrp_att_ammo_minishell.png", "mips smooth")
ATT.Description = "Short shells increase ammo capacity but don't hit as hard."
ATT.Pros = {"stat.clipsize", "stat.recoilkick"}
ATT.Cons = {"att.procon.lessproj"}

ATT.Category = "ammo_shotgun"

ATT.SortOrder = 1

ATT.Mult_Num = 0.6667
ATT.Mult_RecoilKick = 0.85
ATT.Mult_ClipSize = 1.5

ATT.Compatibility = function(wpn, cats)
    if !wpn.ShotgunReload then return false end
end

TacRP.LoadAtt(ATT, "ammo_shotgun_minishell")
-- #endregion


------------------------------
-- #region ammo_shotgun_dragon
------------------------------
ATT = {}

ATT.PrintName = "Dragon"
ATT.FullName = "Dragon's Breath"
ATT.Icon = Material("entities/tacrp_att_ammo_dragonsbreath.png", "mips smooth")
ATT.Description = "Magnesium pellets set targets on fire, but have poor range and damage."
ATT.Pros = {"att.procon.incendiary"}
ATT.Cons = {"stat.damage", "stat.muzzlevelocity", "stat.spread"}

ATT.Category = {"ammo_shotgun", "ammo_shotgun2"}

ATT.SortOrder = 6

ATT.Mult_Damage_Max = 0.75
ATT.Mult_Damage_Min = 0.5
ATT.Mult_MuzzleVelocity = 0.75
ATT.Add_Spread = 0.03
ATT.Add_ShotgunPelletSpread = 0.03

ATT.Override_ExplosiveEffect = "ManhackSparks"
-- ATT.Add_ExplosiveDamage = 1
-- ATT.Add_ExplosiveRadius = 16

ATT.Override_DamageType = DMG_BURN

TacRP.LoadAtt(ATT, "ammo_shotgun_dragon")
-- #endregion

------------------------------
-- #region ammo_shotgun_frag
------------------------------
ATT = {}

ATT.PrintName = "Frag"
ATT.FullName = "High Explosive Fragmentation"
ATT.Icon = Material("entities/tacrp_att_ammo_frag12.png", "mips smooth")
ATT.Description = "Explosive slugs deal area damage, but don't expect too much from them."
ATT.Pros = {"att.procon.explosive"}
ATT.Cons = {"stat.damage", "stat.spread", "stat.muzzlevelocity"}

ATT.Category = {"ammo_shotgun", "ammo_shotgun2"}

ATT.SortOrder = 6

ATT.Override_Damage_Min = 5
ATT.Override_Damage_Max = 5

ATT.Num = 1

ATT.Mult_Spread = 0.6

ATT.Add_HipFireSpreadPenalty = 0.025

ATT.Mult_MuzzleVelocity = 0.5

ATT.Override_MuzzleEffect = "muzzleflash_slug"

ATT.Override_ExplosiveEffect = "HelicopterMegaBomb"
ATT.Add_ExplosiveDamage = 40
ATT.Add_ExplosiveRadius = 150

TacRP.LoadAtt(ATT, "ammo_shotgun_frag")
-- #endregion


------------------------------
-- #region ammo_shotgun_breach
------------------------------
ATT = {}

ATT.PrintName = "Breach (Top)"
ATT.FullName = "Breaching Shell (Top-loaded)"
ATT.Icon = Material("entities/tacrp_att_ammo_breaching.png", "mips smooth")
ATT.Description = "Load the first round with a specialized breaching slug."
ATT.Pros = {"att.procon.doorbreach"}
ATT.Cons = {"att.procon.firstround"}

ATT.Category = {"ammo_shotgun", "ammo_shotgun2"}

ATT.SortOrder = 10

ATT.ShootEntForce = 2000

ATT.Func_Num = function(wep, modifiers)
    if wep:Clip1() == wep:GetMaxClip1() then
        modifiers.set = 1
        modifiers.prio = 10
    end
end
ATT.Func_ShootEnt = function(wep, modifiers)
    if wep:Clip1() == wep:GetMaxClip1() then
        modifiers.set = "tacrp_proj_breach_slug"
        modifiers.prio = 10
    end
end
ATT.Func_MuzzleEffect = function(wep, modifiers)
    if wep:Clip1() == wep:GetMaxClip1() - 1 then
        modifiers.set = "muzzleflash_smg"
        modifiers.prio = 10
    end
end

TacRP.LoadAtt(ATT, "ammo_shotgun_breach")
-- #endregion


------------------------------
-- #region ammo_stinger_saam
------------------------------
ATT = {}

ATT.PrintName = "Semi-Active"
ATT.FullName = "Stinger Semi-Active Missile"
ATT.Icon = Material("entities/tacrp_att_ammo_stinger.png", "mips smooth")
ATT.Description = "Powerful missiles that lock rapidly but require constant guidance."
ATT.Pros = {"att.procon.locktime", "stat.damage"}
ATT.Cons = {"att.procon.semiactive"}

ATT.Category = "ammo_stinger"

ATT.SortOrder = 1

ATT.Override_ShootEnt = "tacrp_proj_stinger_saam"

ATT.Override_LockOnAngle = math.cos(math.rad(10))
ATT.Override_LockOnTime = 0.1

ATT.NoAutoReload = true

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_stinger_saam")
-- #endregion

------------------------------
-- #region ammo_stinger_qaam
------------------------------
ATT = {}

ATT.PrintName = "Agile"
ATT.FullName = "Stinger High Agility Missile"
ATT.Icon = Material("entities/tacrp_att_ammo_stinger_qaam.png", "mips smooth")
ATT.Description = "Highly maneuverable missile with a short range and long lock time."
ATT.Pros = {"att.procon.proj.turn"}
ATT.Cons = {"att.procon.locktime"}

ATT.Category = "ammo_stinger"

ATT.SortOrder = 2

ATT.Override_ShootEnt = "tacrp_proj_stinger_qaam"

ATT.Override_LockOnRange = 16000
ATT.Override_LockOnTime = 1.5
ATT.Range_Max = 16000
ATT.Range_Min = 1000

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_stinger_qaam")
-- #endregion

------------------------------
-- #region ammo_stinger_4aam
------------------------------
ATT = {}

ATT.PrintName = "Quad"
ATT.FullName = "Stinger 4x Missile"
ATT.Icon = Material("entities/tacrp_att_ammo_stinger_4aam.png", "mips smooth")
ATT.Description = "Guided cluster missiles maximize pressure to enemy pilots."
ATT.Pros = {"att.procon.moreproj", "att.procon.proj.turn"}
ATT.Cons = {"stat.damage", "stat.spread", "att.procon.armdelay"}

ATT.Category = "ammo_stinger"

ATT.SortOrder = 3

ATT.Override_ShootEnt = "tacrp_proj_stinger_4aam"

ATT.Override_Num = 4
ATT.Override_Spread = 0.1
ATT.Override_Damage_Max = 75
ATT.Override_Damage_Min = 75
ATT.Override_LockOnAngle = math.cos(math.rad(15))

ATT.Hook_PreShoot = function(wep)
    wep.QuadShootIndex = 0
end

ATT.Hook_PreShootEnt = function(wep, ent)
    wep.QuadShootIndex = wep.QuadShootIndex + 1
end

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_stinger_4aam")
-- #endregion

------------------------------
-- #region ammo_stinger_apers
------------------------------
ATT = {}

ATT.PrintName = "Killer Bee"
ATT.FullName = "Stinger Anti-Personnel Missile"
ATT.Icon = Material("entities/tacrp_att_ammo_stinger_apers.png", "mips smooth")
ATT.Description = "For rodents of unacceptable agility."
ATT.Pros = {"att.procon.radius", "att.procon.proxfuse"}
ATT.Cons = {"stat.damage", "att.procon.armdelay"}

ATT.Category = "ammo_stinger"

ATT.SortOrder = 4

ATT.Override_ShootEnt = "tacrp_proj_stinger_apers"

ATT.Override_LockOnRange = 6000
ATT.Override_LockOnTime = 0.5
ATT.Override_LockOnAngle = math.cos(math.rad(20))

ATT.Range_Max = 6000
ATT.Range_Min = 1000

ATT.ShootOffsetAngle = Angle(-30, 0, 0)
ATT.ShootEntForce = 3000

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_stinger_apers")
-- #endregion


------------------------------
-- #region ammo_usp_9mm
------------------------------
ATT = {}

ATT.PrintName = "9x19mm"
ATT.FullName = "USP 9x19mm Conversion"
ATT.Icon = Material("entities/tacrp_ex_usp.png", "mips smooth")
ATT.Description = "Fire a smaller caliber round with higher capacity and firerate."
ATT.Pros = {"stat.clipsize", "stat.rpm", "stat.recoil"}
ATT.Cons = {"stat.damage"}

ATT.SortOrder = 0

ATT.Category = "ammo_usp"

ATT.Override_Ammo_Expanded = "pistol"

ATT.Mult_RPM = 1.15

ATT.Add_ClipSize = 3
ATT.Mult_RecoilSpreadPenalty = 0.85
ATT.Mult_RecoilKick = 0.5

ATT.Mult_Damage_Max = 24 / 28
ATT.Mult_Damage_Min = 10 / 12

ATT.Override_Sound_Shoot = "weapons/pistol/pistol_fire2.wav" -- maximum gordon freeman
ATT.Override_Sound_Shoot_Silenced = "tacrp/weapons/p2000/p2000_fire_silenced-1.wav"
ATT.Override_ShootPitchVariance = 2

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end

TacRP.LoadAtt(ATT, "ammo_usp_9mm")
-- #endregion