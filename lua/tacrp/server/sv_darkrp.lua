util.AddNetworkString("tacrp_spawnedwepatts")

hook.Add("onDarkRPWeaponDropped", "TacRP", function(ply, ent, wep)
    ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
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
            ent.Attachments = atts
        end
    end
    if wep:GetNWBool("TacRP_PoliceBiocode", false) then
        ent:SetNWBool("TacRP_PoliceBiocode", true)
        ent.TacRP_PoliceBiocode = true -- NWVars aren't saved in pocket but this is?? But we also need client to know so it's awkward
    end
end)

hook.Add("PlayerPickupDarkRPWeapon", "TacRP", function(ply, ent, wep)
    if wep.ArcticTacRP and wep.Attachments then
        -- DarkRP will remove wep (created with ents.Create?) so we must make one ourselves here too
        if ply:HasWeapon(wep:GetClass()) or ply:KeyDown(IN_WALK) then
            ply:PickupObject(ent)
            return true
        end -- block duplicate pickups

        local class = wep:GetClass()
        local biocoded = ent:GetNWBool("TacRP_PoliceBiocode")
        wep:Remove()
        wep = ply:Give(class, true)
        wep.GaveDefaultAmmo = true -- did DefaultClip kill your father or something, arctic?
        if biocoded then
            wep:SetNWBool("TacRP_PoliceBiocode", true)
        end

        if ent.Attachments then
            for k, v in pairs(ent.Attachments) do
                wep.Attachments[k].Installed = TacRP.Attachments_Index[v]
            end
            timer.Simple(0.1, function() if IsValid(wep) then wep:NetworkWeapon() end end)
        end

        ent.Attachments = nil -- Don't duplicate attachments

        hook.Call("playerPickedUpWeapon", nil, ply, ent, wep)
        ent:GivePlayerAmmo(ply, wep, false)
        ent:DecreaseAmount()

        return true
    end
end)

hook.Add("onPocketItemDropped", "TacRP_DarkRP", function(wep, ent, item, id)
    if ent:GetClass() ~= "spawned_weapon" then return end
    if ent.TacRP_PoliceBiocode then
        ent:SetNWBool("TacRP_PoliceBiocode", true)
    end
    local atts = ent.Attachments or {}
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
end)

local function hack()
    local spawned_weapon = (scripted_ents.GetStored("spawned_weapon") or {}).t
    if spawned_weapon and not spawned_weapon.TacRP_Hack then
        spawned_weapon.TacRP_Hack = true -- don't make this change multiple times!
        local old = spawned_weapon.StartTouch

        function spawned_weapon:StartTouch(ent)
            if ent.Attachments then return end
            old(self, ent)
        end
    end

    if DarkRP then
        hook.Add("PlayerLoadout", "TacRP_PoliceBiocode", function(ply)
            if !TacRP.ConVars["rp_biocode_cp"]:GetBool() or !ply:isCP() then return end
            timer.Simple(0.001, function()
                if !IsValid(ply) then return end
                local jobTable = ply:getJobTable()
                for _, v in pairs(jobTable.weapons or {}) do
                    local wep = ply:GetWeapon(v)
                    if IsValid(wep) then
                        wep:SetNWBool("TacRP_PoliceBiocode", true)
                        wep.TacRP_PoliceBiocode = true
                    end
                end
            end)
        end)
    end
end
hook.Add("InitPostEntity", "TacRP_SpawnedWeaponHack", hack)
hack()

