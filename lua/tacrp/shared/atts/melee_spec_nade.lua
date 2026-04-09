ATT.PrintName = "att.melee_spec_nade.name"
ATT.FullName = "att.melee_spec_nade.name.full"
ATT.Icon = Material("entities/tacrp_att_melee_spec_nade.png", "mips smooth")
ATT.Description = "att.melee_spec_nade.desc"
ATT.Pros = { "att.pro.melee_spec_nade1", "att.pro.melee_spec_nade2" }
ATT.Cons = { "att.con.melee_spec_nade" }

ATT.Category = {"melee_spec"}
ATT.Free = false

ATT.SortOrder = 4

ATT.Hook_PreReload = function(self)
    self.GrenadeMenuKey = IN_RELOAD
    if game.SinglePlayer() and SERVER then
        self:CallOnClient("Reload")
    end
    return true
end

ATT.Hook_GetHintCapabilities = function(self, tbl)
    tbl["+reload"] = {so = 0.4, str = "hint.quicknade.menu"}
end

ATT.QuickNadeTryImpact = true
-- ATT.Mult_QuickNadeTimeMult = 1.5