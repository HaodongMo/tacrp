ATT.PrintName = "Toggle Nade"
ATT.FullName = "Toggle Grenade"
ATT.Icon = Material("entities/tacrp_att_acc_grenade.png", "mips smooth")
ATT.Description = "Use the reload bind to switch between grenades."
ATT.Pros = {"RELOAD: Toggle Grenade"}

ATT.Category = {"melee_spec"}
ATT.Free = true

ATT.SortOrder = 4

ATT.Hook_PreReload = function(self)
    self.GrenadeMenuKey = IN_RELOAD
    if game.SinglePlayer() and SERVER then
        self:CallOnClient("Reload")
    end
    return true
end