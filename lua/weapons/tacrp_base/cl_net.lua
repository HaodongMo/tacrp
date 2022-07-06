function SWEP:ReceiveWeapon()
    for slot, slottbl in pairs(self.Attachments) do
        local attid = net.ReadUInt(TacRP.Attachments_Bits)

        if attid == 0 then
            slottbl.Installed = nil
        else
            slottbl.Installed = TacRP.Attachments_Index[attid]
        end
    end

    self:SetupModel(true)
    self:SetupModel(false)

    self.StatCache = {}
    self.HookCache = {}
end

function SWEP:RequestWeapon()
    net.Start("TacRP_networkweapon")
    net.WriteEntity(self)
    net.SendToServer()
end