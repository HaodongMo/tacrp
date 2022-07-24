if CLIENT then return end

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

net.Receive("tacrp_toggleblindfire", function(len, ply)
    local bf = net.ReadBool()

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

    if !wpn.ArcticTacRP then return end

    if attach then
        local att = TacRP.Attachments_Index[attid]

        wpn:Attach(slot, att, true)
    else
        wpn:Detach(slot, true)
    end
end)

net.Receive("tacrp_receivepreset", function(len, ply)
    local wpn = net.ReadEntity()

    if !wpn.ArcticTacRP then return end

    wpn:ReceivePreset()
end)