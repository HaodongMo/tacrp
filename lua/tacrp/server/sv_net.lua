util.AddNetworkString("tacrp_toggleblindfire")
util.AddNetworkString("tacrp_togglecustomize")
util.AddNetworkString("tacrp_reloadatts")
util.AddNetworkString("tacrp_networkweapon")
util.AddNetworkString("tacrp_attach")
util.AddNetworkString("tacrp_receivepreset")
util.AddNetworkString("tacrp_sendattinv")
util.AddNetworkString("tacrp_sendbullet")

util.AddNetworkString("tacrp_updateholster")
util.AddNetworkString("tacrp_clientdamage")
util.AddNetworkString("tacrp_container")
util.AddNetworkString("tacrp_toggletactical")
util.AddNetworkString("tacrp_doorbust")
util.AddNetworkString("tacrp_flashbang")
util.AddNetworkString("tacrp_togglenade")
util.AddNetworkString("tacrp_addshieldmodel")
util.AddNetworkString("tacrp_updateslot")
util.AddNetworkString("tacrp_givenadewep")
util.AddNetworkString("tacrp_reloadlangs")
util.AddNetworkString("tacrp_npcweapon")
util.AddNetworkString("tacrp_drop")

net.Receive("tacrp_togglenade", function(len, ply)
    local bf = net.ReadUInt(TacRP.QuickNades_Bits)
    local throw = net.ReadBool()
    local under = false
    if throw then under = net.ReadBool() end

    local wpn = ply:GetActiveWeapon()

    if !wpn or !IsValid(wpn) or !wpn.ArcticTacRP then return end

    wpn:SelectGrenade(bf)
    if throw then
        wpn:PrimeGrenade()
        wpn.GrenadeThrowOverride = under
    end
end)

net.Receive("tacrp_givenadewep", function(len, ply)
    local bf = net.ReadUInt(TacRP.QuickNades_Bits)
    local wpn = ply:GetActiveWeapon()
    if !wpn or !IsValid(wpn) or !wpn.ArcticTacRP or !TacRP.AreTheGrenadeAnimsReadyYet then return end

    local nade = TacRP.QuickNades[TacRP.QuickNades_Index[bf]]
    if !nade or !nade.GrenadeWep or !wpn:CheckGrenade(bf, true) then return end

    ply:Give(nade.GrenadeWep, true)
end)

net.Receive("tacrp_toggleblindfire", function(len, ply)
    local bf = net.ReadUInt(TacRP.BlindFireNetBits)

    local wpn = ply:GetActiveWeapon()

    if !wpn or !IsValid(wpn) or !wpn.ArcticTacRP then return end

    wpn:ToggleBlindFire(bf)
end)

net.Receive("tacrp_togglecustomize", function(len, ply)
    local bf = net.ReadBool()

    local wpn = ply:GetActiveWeapon()

    if !wpn or !IsValid(wpn) or !wpn.ArcticTacRP then return end

    wpn:ToggleCustomize(bf)
end)

net.Receive("tacrp_toggletactical", function(len, ply)
    local wpn = ply:GetActiveWeapon()

    if !wpn or !IsValid(wpn) or !wpn.ArcticTacRP or !wpn:GetValue("CanToggle") then return end

    wpn:SetTactical(!wpn:GetTactical())
end)

net.Receive("tacrp_networkweapon", function(len, ply)
    local wpn = net.ReadEntity()

    if !wpn.ArcticTacRP then return end

    wpn:NetworkWeapon(ply)
end)

net.Receive("tacrp_attach", function(len, ply)
    local wpn = net.ReadEntity()

    local attach = net.ReadBool()
    local slot = net.ReadUInt(8)
    local attid = 0

    if attach then
        attid = net.ReadUInt(TacRP.Attachments_Bits)
    end

    if ply:GetActiveWeapon() != wpn or !wpn.ArcticTacRP then return end

    if attach then
        local att = TacRP.Attachments_Index[attid]

        wpn:Attach(slot, att, true)
    else
        wpn:Detach(slot, true)
    end
end)

net.Receive("tacrp_receivepreset", function(len, ply)
    local wpn = net.ReadEntity()

    if !wpn.ArcticTacRP or wpn:GetOwner() != ply then return end
    wpn:ReceivePreset()
end)

net.Receive("tacrp_drop", function(len, ply)
    if !TacRP.ConVars["allowdrop"]:GetBool() then return end
    local wep = ply:GetActiveWeapon()
    if !IsValid(wep) or !wep.ArcticTacRP then return end
    if !ply:Alive() then return end

    if wep:GetValue("PrimaryGrenade") then
        -- Grenades don't have a clip size. this would mean players can constantly generate and drop nade sweps that do nothing.
        local nade = TacRP.QuickNades[wep:GetValue("PrimaryGrenade")]
        if TacRP.IsGrenadeInfiniteAmmo(nade) then
            return -- Disallow dropping nades when its infinite
        elseif nade.Singleton then
            if DarkRP then
                local canDrop = hook.Call("canDropWeapon", GAMEMODE, ply, wep)
                if !canDrop then
                    DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("cannot_drop_weapon"))
                    return ""
                end
                ply:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_DROP)
                ply:dropDRPWeapon(wep)
            else
                ply:DropWeapon(wep)
            end
        elseif nade.AmmoEnt and ply:GetAmmoCount(nade.Ammo) > 0 then
            ply:RemoveAmmo(1, nade.Ammo)
            local ent = ents.Create(nade.AmmoEnt)
            ent:SetPos(ply:EyePos() - Vector(0, 0, 4))
            ent:SetAngles(AngleRand())
            ent:Spawn()
            if IsValid(ent:GetPhysicsObject()) then
                ent:GetPhysicsObject():SetVelocityInstantaneous(ply:EyeAngles():Forward() * 200)
            end
            if ply:GetAmmoCount(nade.Ammo) == 0 then
                wep:Remove()
            end
        end
    else
        if DarkRP then
            local canDrop = hook.Call("canDropWeapon", GAMEMODE, ply, wep)
            if !canDrop then
                DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("cannot_drop_weapon"))
                return ""
            end
            ply:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_DROP)
            ply:dropDRPWeapon(wep)
        else
            ply:DropWeapon(wep)
        end
    end
end)
