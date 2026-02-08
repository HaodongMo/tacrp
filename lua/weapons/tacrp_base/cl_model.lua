SWEP.VModel = nil
SWEP.WModel = nil

function SWEP:KillModel()
    for _, model in pairs(self.VModel or {}) do
        SafeRemoveEntity(model)
    end
    for _, model in pairs(self.WModel or {}) do
        SafeRemoveEntity(model)
    end

    self.VModel = nil
    self.WModel = nil
end

function SWEP:CreateAttachmentModel(wm, atttbl, slot, slottbl, custom_wm)
    local model = atttbl.Model

    if wm and atttbl.WorldModel then
        model = atttbl.WorldModel
    end

    local csmodel = ClientsideModel(model)

    if !IsValid(csmodel) then return end

    csmodel.Slot = slot

    local scale = Matrix()
    local vec = Vector(1, 1, 1) * (atttbl.Scale or 1)
    if wm then
        vec = vec * (slottbl.WMScale or 1)
    else
        vec = vec * (slottbl.VMScale or 1)
    end
    scale:Scale(vec)
    csmodel:EnableMatrix("RenderMultiply", scale)
    csmodel:SetNoDraw(true)

    local tbl = {
        Model = csmodel,
        Weapon = self
    }

    table.insert(TacRP.CSModelPile, tbl)

    if wm then
        table.insert(self.WModel, csmodel)
    else
        table.insert(self.VModel, csmodel)
    end

    return csmodel
end

function SWEP:SetupModel(wm, custom_wm)
    self:KillModel()

    if !wm and !IsValid(self:GetOwner()) then return end

    if !wm then
        self.VModel = {}
    else
        self.WModel = {}
    end

    if !wm and self:GetOwner() != LocalPlayer() and self:GetOwner() != LocalPlayer():GetObserverTarget() then return end

    self:DoBodygroups(wm)

    for slot, slottbl in pairs(self.Attachments) do
        if !slottbl.Installed then continue end

        local atttbl = TacRP.GetAttTable(slottbl.Installed)

        if !atttbl.Model then continue end

        // Check if this is an akimbo weapon with dual positioning for this slot
        local isDualSlot = self:GetValue("Akimbo") and slottbl.Bone_L and slottbl.Bone_R

        if isDualSlot then
            // Create left attachment model
            local csmodel_l = self:CreateAttachmentModel(wm, atttbl, slot, slottbl)
            csmodel_l.IsHolosight = atttbl.Holosight
            csmodel_l.IsLeftAttachment = true

            // Create right attachment model
            local csmodel_r = self:CreateAttachmentModel(wm, atttbl, slot, slottbl)
            csmodel_r.IsHolosight = atttbl.Holosight
            csmodel_r.IsRightAttachment = true

            if atttbl.Silencer then
                local slmodel_l = self:CreateAttachmentModel(wm, atttbl, slot, slottbl)
                slmodel_l.IsMuzzleDevice = true
                slmodel_l.IsLeftMuzzle = true
                slmodel_l.NoDraw = true

                local slmodel_r = self:CreateAttachmentModel(wm, atttbl, slot, slottbl)
                slmodel_r.IsMuzzleDevice = true
                slmodel_r.IsRightMuzzle = true
                slmodel_r.NoDraw = true
            end

            if wm then
                slottbl.WModel = csmodel_l
                slottbl.WModel_R = csmodel_r
            else
                slottbl.VModel = csmodel_l
                slottbl.VModel_R = csmodel_r
            end
        else
            local csmodel = self:CreateAttachmentModel(wm, atttbl, slot, slottbl)

            csmodel.IsHolosight = atttbl.Holosight

            if atttbl.Silencer then
                local slmodel = self:CreateAttachmentModel(wm, atttbl, slot, slottbl)
                slmodel.IsMuzzleDevice = true
                slmodel.NoDraw = true
            end

            if wm then
                slottbl.WModel = csmodel
            else
                slottbl.VModel = csmodel
            end
        end
    end

    if !wm then
        self:CreateFlashlights()

        local mat = self:GetValue("Material")

        if mat then
            local vm = self:GetOwner():GetViewModel()

            vm:SetMaterial(mat)
        end
    end
end