ATT.PrintName = "Flechette"
ATT.Icon = Material("entities/tacrp_att_ammo_40mm_heat.png", "mips smooth")
ATT.Description = "Grenade packed with thin darts."
ATT.Pros = {"Direct fire", "Accuracy"}
ATT.Cons = {"No explosion"}

ATT.Category = "ammo_40mm" // can be "string" or {"list", "of", "strings"}

ATT.ShootEnt = false

ATT.InstalledElements = {"heat"}

ATT.NoRanger = false

ATT.Damage_Max = 34
ATT.Damage_Min = 12
ATT.Num = 8
ATT.Range_Min = 1500
ATT.Range_Min = 2500
ATT.Penetration = 2.5
ATT.Spread = 0.015

ATT.MuzzleVelocity = 15000

ATT.Override_Sound_Shoot = "^tacrp/weapons/m4star10/fire-2.wav"
ATT.Pitch_Shoot = 110