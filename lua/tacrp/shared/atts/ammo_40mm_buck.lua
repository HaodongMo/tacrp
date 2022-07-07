ATT.PrintName = "BUCK"
ATT.Icon = Material("entities/tacrp_att_ammo_40mm_buck.png", "mips smooth")
ATT.Description = "Huge 40mm shotgun shell."
ATT.Pros = {"Direct fire"}
ATT.Cons = {"No explosion"}

ATT.Category = "ammo_40mm" // can be "string" or {"list", "of", "strings"}

ATT.ShootEnt = false

ATT.NoRanger = false

ATT.Damage_Max = 100 / 8
ATT.Damage_Min = 100 / 16
ATT.Num = 24
ATT.Range_Min = 1000
ATT.Range_Min = 2000
ATT.Penetration = 1
ATT.Spread = 0.05

ATT.MuzzleVelocity = 9500

ATT.Override_Sound_Shoot = "^TacRP/weapons/m4star10/fire-2.wav"

ATT.InstalledElements = {"buck"}