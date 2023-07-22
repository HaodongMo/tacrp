ATT.PrintName = "Light Grip"
ATT.FullName = "Lightweight Grip"
ATT.Icon = Material("entities/tacrp_att_acc_skel.png", "mips smooth")
ATT.Description = "Skeletonized grip makes the guns lighter and easier to move around with."

ATT.Category = "acc_dual"
ATT.InvAtt = "acc_skel"

ATT.SortOrder = 2.1

ATT.Pros = {"stat.movespeed", "stat.reloadspeed"}
ATT.Add_MoveSpeedMult = 0.08
ATT.Add_ReloadSpeedMult = 0.1