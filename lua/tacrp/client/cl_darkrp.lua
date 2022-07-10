local hold_tbl = {}
net.Receive("tacrp_spawnedwepatts", function()
    local ent_index = net.ReadUInt(12)
    hold_tbl[ent_index] = {}
    local count = net.ReadUInt(4)
    for i = 1, count do
        hold_tbl[ent_index][net.ReadUInt(4)] = net.ReadUInt(TacRP.Attachments_Bits)
    end

    if IsValid(Entity(ent_index)) then
        Entity(ent_index).Attachments = hold_tbl[ent_index]
    end
end)

hook.Add("onDrawSpawnedWeapon", "TacRP", function(ent)
    local wep_tbl = weapons.Get(ent:GetWeaponClass())
    if not wep_tbl or not wep_tbl.ArcticTacRP then return end

    ent:DrawModel()

    if not ent.Attachments and hold_tbl[ent:EntIndex()] then
        ent.Attachments = table.Copy(hold_tbl[ent:EntIndex()])
        hold_tbl[ent:EntIndex()] = nil
    end

    if (EyePos() - ent:GetPos()):LengthSqr() <= 262144 then -- 512^2
        local ang = LocalPlayer():EyeAngles()

        ang:RotateAroundAxis(ang:Forward(), 180)
        ang:RotateAroundAxis(ang:Right(), 90)
        ang:RotateAroundAxis(ang:Up(), 90)

        cam.Start3D2D(ent:WorldSpaceCenter() + Vector(0, 0, (ent:OBBMaxs().z - ent:OBBMins().z) * 0.5 + 8) , ang, 0.1)
            surface.SetFont("TacRP_LondonBetween_32_Unscaled")

            local w = surface.GetTextSize(wep_tbl.PrintName)
            surface.SetTextPos(-w / 2, 0)
            surface.SetTextColor(255, 255, 255, 255)
            surface.DrawText(wep_tbl.PrintName)

            local count = table.Count(ent.Attachments or {})
            if count > 0 then
                local str = count .. " Attachments"
                local w2 = surface.GetTextSize(str)
                surface.SetTextPos(-w2 / 2, 32)
                surface.SetTextColor(255, 255, 255, 255)
                surface.DrawText(str)
            end
        cam.End3D2D()
    end

    return true
end)