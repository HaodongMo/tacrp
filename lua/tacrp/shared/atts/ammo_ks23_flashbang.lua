ATT.PrintName = "Zvezda Shell"
ATT.Icon = Material("entities/tacrp_att_ammo_ks23_flashbang.png", "mips smooth")
ATT.Description = "Flashbang shells that stun enemies, right from the barrel."
ATT.Pros = {"att.procon.flash"}
ATT.Cons = {"att.procon.timedfuse", "att.procon.nonlethal"}

ATT.Category = "ammo_ks23"

ATT.Override_MuzzleEffect = "muzzleflash_smg"

ATT.ShootEnt = "tacrp_proj_ks23_flashbang"

ATT.Num = 1
ATT.ShootEntForce = 1200

ATT.Ignore = false