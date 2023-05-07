ATT.PrintName = "Buckshot"
ATT.FullName = "40mm Buckshot Grenades"
ATT.Icon = Material("entities/tacrp_att_ammo_40mm_buck.png", "mips smooth")
ATT.Description = "Flat-top grenade firing pellets like a shotgun."
ATT.Pros = {"Direct fire", "Door breach"}
ATT.Cons = {"No explosion"}

ATT.Category = "ammo_40mm"

ATT.SortOrder = 2

ATT.ShootEnt = false

ATT.NoRanger = false

ATT.Damage_Max = 10
ATT.Damage_Min = 3
ATT.Num = 24
ATT.Range_Min = 100
ATT.Range_Max = 1500
ATT.PenetrationOverride = 0

ATT.Spread = 0.05
ATT.ShotgunPelletSpread = 0.015

ATT.MuzzleVelocity = 9500

ATT.Override_Sound_ShootAdd = "^TacRP/weapons/m4star10/fire-2.wav"
ATT.Pitch_Shoot = 95

ATT.DoorBreach = true
ATT.DoorBreachThreshold = 120

ATT.InstalledElements = {"buck"}

if engine.ActiveGamemode() == "terrortown" then
    ATT.Free = true
end