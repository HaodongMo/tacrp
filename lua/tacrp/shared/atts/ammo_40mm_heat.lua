ATT.PrintName = "Flechette"
ATT.FullName = "40mm Flechette Grenades"

ATT.Icon = Material("entities/tacrp_att_ammo_40mm_heat.png", "mips smooth")
ATT.Description = "Flat-top grenade packing accurate flechette darts."
ATT.Pros = {"att.procon.direct", "stat.spread"}
ATT.Cons = {"att.procon.noexp"}

ATT.Category = "ammo_40mm"

ATT.SortOrder = 2.5

ATT.ShootEnt = false

ATT.InstalledElements = {"buck"} --{"heat"}

ATT.NoRanger = false

ATT.Damage_Max = 34
ATT.Damage_Min = 5
ATT.Num = 8
ATT.Range_Min = 250
ATT.Range_Max = 2000
ATT.Penetration = 6

ATT.Spread = 0.015
ATT.ShotgunPelletSpread = 0.01

ATT.MuzzleVelocity = 15000

ATT.Override_Sound_ShootAdd = "^tacrp/weapons/m4star10/fire-2.wav"
ATT.Pitch_Shoot = 110

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end