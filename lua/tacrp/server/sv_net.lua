if CLIENT then return end

util.AddNetworkString("TacRP_toggleblindfire")
util.AddNetworkString("TacRP_togglecustomize")
util.AddNetworkString("TacRP_reloadatts")
util.AddNetworkString("TacRP_networkweapon")
util.AddNetworkString("TacRP_attach")
util.AddNetworkString("TacRP_receivepreset")
util.AddNetworkString("TacRP_sendattinv")
util.AddNetworkString("TacRP_sendbullet")

util.AddNetworkString("TacRP_updateholster")

net.Receive("TacRP_toggleblindfire", function(len, ply)
    local bf = net.ReadBool()

    local wpn = ply:GetActiveWeapon()

    if !wpn or !IsValid(wpn) or !wpn.ArcticTacRP then return end

    wpn:ToggleBlindFire(bf)
end)

net.Receive("TacRP_togglecustomize", function(len, ply)
    local bf = net.ReadBool()

    local wpn = ply:GetActiveWeapon()

    if !wpn or !IsValid(wpn) or !wpn.ArcticTacRP then return end

    wpn:ToggleCustomize(bf)
end)

net.Receive("TacRP_networkweapon", function(len, ply)
    local wpn = net.ReadEntity()

    if !wpn.ArcticTacRP then return end

    wpn:NetworkWeapon(ply)
end)

net.Receive("TacRP_attach", function(len, ply)
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

net.Receive("TacRP_receivepreset", function(len, ply)
    local wpn = net.ReadEntity()

    if !wpn.ArcticTacRP then return end

    wpn:ReceivePreset()
end)