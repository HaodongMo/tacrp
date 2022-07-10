util.AddNetworkString("tacrp_spawnedwepatts")

hook.Add("onDarkRPWeaponDropped", "TacRP", function(ply, ent, wep)
    if wep.ArcticTacRP and wep.Attachments then
        local atts = {}
        for k, v in pairs(wep.Attachments or {}) do
            atts[k] = v.Installed and (TacRP.Attachments[v.Installed] or {}).ID
        end
        if table.Count(atts) > 0 then
            net.Start("tacrp_spawnedwepatts")
                net.WriteUInt(ent:EntIndex(), 12) -- ent won't exist on client when message arrives
                net.WriteUInt(table.Count(atts), 4)
                for k, v in pairs(atts) do
                    net.WriteUInt(k, 4)
                    net.WriteUInt(v, TacRP.Attachments_Bits)
                end
            net.Broadcast()
        end
        ent.Attachments = atts
    end
end)

hook.Add("PlayerPickupDarkRPWeapon", "TacRP", function(ply, ent, wep)
    if wep.ArcticTacRP and wep.Attachments and ent.Attachments then
        -- DarkRP will remove wep (created with ents.Create?) so we must make one ourselves here too
        local has = ply:HasWeapon(wep:GetClass())

        local class = wep:GetClass()
        wep:Remove()
        wep = ply:Give(class, true)
        wep.GaveDefaultAmmo = true -- did DefaultClip kill your father or something, arctic?

        for k, v in pairs(ent.Attachments) do
            wep.Attachments[k].Installed = TacRP.Attachments_Index[v]
        end
        wep:NetworkWeapon()

        ent.Attachments = nil -- Don't duplicate attachments

        if has then
            return true
        end

        hook.Call("playerPickedUpWeapon", nil, ply, ent, wep)
        ent:GivePlayerAmmo(ply, wep, has)
        ent:DecreaseAmount()

        return true
    end
end)