ATT.PrintName = "BUCK"
ATT.Icon = Material("entities/TacRP_att_ammo_40mm_buck.png", "mips smooth")
ATT.Description = "Huge 40mm shotgun shell."

ATT.Category = "ammo_40mm" // can be "string" or {"list", "of", "strings"}

ATT.ShootEnt = false

ATT.Damage_Min = 100 / 16
ATT.Damage_Max = 100 / 8
ATT.Num = 24
ATT.Range_Min = 1000
ATT.Range_Min = 2000
ATT.Penetration = 1
ATT.Spread = 0.1

ATT.Override_Sound_Shoot = "^TacRP/weapons/m4star10/fire-2.wav"

ATT.InstalledElements = {"buck"}