ATT.PrintName = "Wide"
ATT.FullName = "Wide Trigger"
ATT.Icon = Material("entities/tacrp_att_trigger_wide.png", "mips smooth")
ATT.Description = "Large trigger assembly, easy to hold even in awkward positions."
ATT.Pros = {"stat.quickscope", "stat.peekpenalty"}
ATT.Cons = {"stat.aimdownsights"}

ATT.Category = {"trigger_revolver", "trigger_manual"}

ATT.SortOrder = 5

ATT.Mult_PeekPenaltyFraction = 0.75
ATT.Mult_QuickScopeSpreadPenalty = 0.75
-- ATT.Mult_HipFireSpreadPenalty = 0.75

ATT.Add_AimDownSightsTime = 0.03