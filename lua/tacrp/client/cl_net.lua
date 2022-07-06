net.Receive("TacRP_networkweapon", function(len, ply)
    local wpn = net.ReadEntity()

    if !wpn.ArcticTacRP then return end

    wpn:ReceiveWeapon()
end)