ATT.PrintName = "Triple Hit"
ATT.Icon = Material("entities/tacrp_att_acc_slugs.png", "mips smooth")
ATT.Description = "Fire three smaller slugs."
ATT.Pros = {"Better accuracy"}
ATT.Cons = {"Fewer projectiles"}

ATT.InstalledElements = {"smallmag"}

ATT.Category = "ammo_shotgun" // can be "string" or {"list", "of", "strings"}

ATT.SortOrder = 1

ATT.Mult_Damage_Min = 4
ATT.Mult_Damage_Max = 4

ATT.Num = 3

ATT.Mult_Spread = 0.75

ATT.Override_MuzzleEffect = "muzzleflash_slug"