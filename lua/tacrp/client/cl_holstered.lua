hook.Add("PostPlayerDraw", "TacRP_Holster", function(ply)
    if !ply.TacRP_Holster then return end
    if ply == LocalPlayer() and !LocalPlayer():ShouldDrawLocalPlayer() then return end

    ply.TacRP_HolsterModels = ply.TacRP_HolsterModels or {}
    for i, v in ipairs(TacRP.HolsterBones) do
        local wep = ply.TacRP_Holster[i]
        if !IsValid(wep) or wep == ply:GetActiveWeapon() or !wep:GetValue("HolsterVisible") then
            SafeRemoveEntity(ply.TacRP_HolsterModels[i])
            ply.TacRP_HolsterModels[i] = nil
            ply.TacRP_Holster[i] = nil
            continue
        end

        local bone = ply:LookupBone(v[1])
        local matrix = bone and ply:GetBoneMatrix(bone)
        if !bone or !matrix then return end

        local holstermodel = wep:GetValue("HolsterModel") or wep.WorldModel

        if !ply.TacRP_HolsterModels[i] or !IsValid(ply.TacRP_HolsterModels[i])
                or ply.TacRP_HolsterModels[i]:GetModel() != holstermodel then
            SafeRemoveEntity(ply.TacRP_HolsterModels[i])
            ply.TacRP_HolsterModels[i] = ClientsideModel(holstermodel, RENDERGROUP_OPAQUE)
            ply.TacRP_HolsterModels[i]:SetNoDraw(true)
        end

        local hpos, hang = wep:GetValue("HolsterPos"), wep:GetValue("HolsterAng")
        local off = v[2] + hpos

        local pos = matrix:GetTranslation()
        local ang = matrix:GetAngles()

        pos = pos + ang:Right() * off.x + ang:Forward() * off.y + ang:Up() * off.z
        ang:RotateAroundAxis(ang:Forward(), hang.p)
        ang:RotateAroundAxis(ang:Up(), hang.y)
        ang:RotateAroundAxis(ang:Right(), hang.r)

        debugoverlay.Axis(pos, ang, 8, FrameTime() * 2, true)

        model = ply.TacRP_HolsterModels[i]
        model:SetPos(pos)
        model:SetAngles(ang)
        model:SetRenderOrigin(pos)
        model:SetRenderAngles(ang)
        model:DrawModel()
        model:SetRenderOrigin()
        model:SetRenderAngles()

        if !wep:GetValue("HolsterModel") then
            wep:DoBodygroups(true, model)
            wep:DrawCustomModel(true, ply.TacRP_HolsterModels[i])
        end
    end
end)
