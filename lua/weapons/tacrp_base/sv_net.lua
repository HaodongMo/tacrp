function SWEP:NetworkWeapon(sendto)
    net.Start("TacRP_networkweapon")
    net.WriteEntity(self)

    for slot, slottbl in pairs(self.Attachments) do
        if !slottbl.Installed then net.WriteUInt(0, TacRP.Attachments_Bits) continue end

        local atttbl = TacRP.GetAttTable(slottbl.Installed)

        net.WriteUInt(atttbl.ID, TacRP.Attachments_Bits)
    end

    if sendto then
        net.Send(sendto)
    else
        net.SendPVS(self:GetPos())
    end

    self:DoBodygroups(true)
    self:DoBodygroups(false)

    self.StatCache = {}
    self.HookCache = {}
end

function SWEP:ReceivePreset()
    for slot, slottbl in pairs(self.Attachments) do
        local attid = net.ReadUInt(TacRP.Attachments_Bits)

        if attid == 0 then
            slottbl.Installed = nil
        else
            local att = TacRP.Attachments_Index[attid]
            local atttbl = TacRP.GetAttTable(att)

            if !atttbl then continue end

            if TacRP:PlayerGetAtts(self:GetOwner(), att) > 0 then
                slottbl.Installed = att
            end
        end
    end

    self:NetworkWeapon()

    self.StatCache = {}
    self.HookCache = {}

    self:SetBaseSettings()

    if self:GetValue("TryUnholster") then
        self:DoDeployAnimation()
    end

    self:RestoreClip(self.Primary.ClipSize)
end