ATT.PrintName = "Flechette"
ATT.FullName = "40mm Flechette Grenades"

ATT.Icon = Material("entities/tacrp_att_ammo_40mm_heat.png", "mips smooth")
ATT.Description = "Flat-top grenade packing accurate flechette darts."
ATT.Pros = {"Direct fire", "Accuracy"}
ATT.Cons = {"No explosion"}

ATT.Category = "ammo_40mm"

ATT.SortOrder = 2.5

ATT.ShootEnt = false

ATT.InstalledElements = {"buck"} --{"heat"}

ATT.NoRanger = false

ATT.Damage_Max = 34
ATT.Damage_Min = 12
ATT.Num = 8
ATT.Range_Min = 500
ATT.Range_Max = 3000
ATT.Penetration = 4
ATT.Spread = 0.015

ATT.MuzzleVelocity = 15000

ATT.Override_Sound_Shoot = "^tacrp/weapons/m4star10/fire-2.wav"
ATT.Pitch_Shoot = 110