function SWEP:ViewModelDrawn()
    if IsValid(self.QuickNadeModel) then
        self.QuickNadeModel:DrawModel()
    end

    self:DrawCustomModel(false)
    self:DrawLasers()
end

function SWEP:DrawCustomModel(wm, custom_wm)

    if !wm and !IsValid(self:GetOwner()) then return end
    if !wm and self:GetOwner():IsNPC() then return end

    local mdl = self.VModel

    if wm then
        mdl = self.WModel
    end

    if !mdl then
        self:SetupModel(wm, custom_wm)

        mdl = self.VModel

        if wm then
            mdl = self.WModel
        end
    end

    local parentmdl = self

    if !wm then
        parentmdl = self:GetVM()
    elseif custom_wm then
        parentmdl = custom_wm
    end

    if !mdl then return end

    for _, model in pairs(mdl) do
        if !IsValid(model) then continue end
        local offset_pos = model.Pos
        local offset_ang = model.Ang
        local bone = model.Bone
        local atttbl = {}
        local slottbl = {}

        if model.WMBase then
            parentmdl = self:GetOwner()
        end

        if !offset_pos or !offset_ang then
            local slot = model.Slot
            slottbl = self.Attachments[slot]
            atttbl = TacRP.GetAttTable(self.Attachments[slot].Installed)

            bone = slottbl.Bone

            if wm then
                bone = slottbl.WMBone or "ValveBiped.Bip01_R_Hand"
            end

            offset_pos = slottbl.Pos_VM
            offset_ang = slottbl.Ang_VM

            if wm then
                offset_pos = slottbl.Pos_WM
                offset_ang = slottbl.Ang_WM
            end
        end

        if !bone then continue end

        local boneindex = parentmdl:LookupBone(bone)

        if !boneindex then continue end

        local bonemat = parentmdl:GetBoneMatrix(boneindex)
        if bonemat then
            bpos = bonemat:GetTranslation()
            bang = bonemat:GetAngles()
        end

        local apos, aang

        apos = bpos + bang:Forward() * offset_pos.x
        apos = apos + bang:Right() * offset_pos.y
        apos = apos + bang:Up() * offset_pos.z

        aang = Angle()
        aang:Set(bang)

        aang:RotateAroundAxis(aang:Right(), offset_ang.p)
        aang:RotateAroundAxis(aang:Up(), offset_ang.y)
        aang:RotateAroundAxis(aang:Forward(), offset_ang.r)

        local moffset = (atttbl.ModelOffset or Vector(0, 0, 0)) * (slottbl.VMScale or 1)

        apos = apos + aang:Forward() * moffset.x
        apos = apos + aang:Right() * moffset.y
        apos = apos + aang:Up() * moffset.z

        model:SetPos(apos)
        model:SetAngles(aang)
        model:SetRenderOrigin(apos)
        model:SetRenderAngles(aang)

        if model.IsHolosight and !wm then
            cam.Start3D(EyePos(), EyeAngles(), self.ViewModelFOV, 0, 0, nil, nil, 1, 10000)
            cam.IgnoreZ(true)
            self:DoHolosight(model)
            cam.End3D()
            cam.IgnoreZ(true)
        end

        if !model.NoDraw then
            model:DrawModel()
        end
    end

    if !wm then
        self:DrawFlashlightsVM()
    end
end

function SWEP:PreDrawViewModel()
    if self:GetValue("ScopeHideWeapon") then
        if self:IsInScope() then
            render.SetBlend(0)
        end
    end

    -- cam.Start3D(nil, nil, 70)

    --cam.Start3D(nil, nil, self.ViewModelFOV, nil, nil, nil, nil, 0.1, nil)
    cam.IgnoreZ(true)
    -- self:DrawEjectedShells()
end

function SWEP:PostDrawViewModel()
    --cam.End3D()
    cam.IgnoreZ(false)

    if self:GetValue("ScopeHideWeapon") then
        if self:IsInScope() then
            render.SetBlend(1)
        end
    end
end
