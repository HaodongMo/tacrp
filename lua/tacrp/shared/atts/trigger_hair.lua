ATT.PrintName = "Feather"
ATT.FullName = "Feather Trigger"
ATT.Icon = Material("entities/tacrp_att_trigger_hair.png", "mips smooth")
ATT.Description = "Very sensitive trigger for rapid semi-automatic fire."
ATT.Pros = {"stat.rpm"}
ATT.Cons = {"stat.recoilresettime", "stat.recoilmaximum"}

ATT.Category = {"trigger_semi", "trigger_akimbo", "trigger_revolver"}

ATT.SortOrder = 4

ATT.Mult_RPM = 1.25
ATT.Add_RecoilResetTime = 0.025
ATT.Mult_RecoilMaximum = 1.15