net.Receive("TacRP_networkweapon", function()
    local wpn = net.ReadEntity()

    if !wpn.ArcticTacRP then return end

    wpn:ReceiveWeapon()
end)

net.Receive("TacRP_updateholster", function()
    local ply = net.ReadEntity()
    --local slot = net.ReadUInt(TacRP.HolsterNetBits)
    local item = net.ReadEntity()

    if !IsValid(item) then return end

    local slot = item:GetValue("HolsterSlot")

    if IsValid(item) and slot then
        ply.TacRP_Holster = ply.TacRP_Holster or {}
        if !IsValid(item) then
            ply.TacRP_Holster[slot] = nil
        else
            ply.TacRP_Holster[slot] = item
        end
    end
end)

net.Receive("tacrp_doorbust", function()
    local door = net.ReadEntity()
    if IsValid(door) then
        local mins, maxs = door:GetCollisionBounds()
        door:SetRenderBounds(mins, maxs, Vector(4, 4, 4))
    end
end)

gameevent.Listen("player_spawn")
hook.Add("player_connect", "TacRP_Holster", function(userid)
    local ply = Player(userid)
    ply.TacRP_Holster = {}
end)

net.Receive("tacrp_flashbang", function()
    local time = net.ReadFloat()
    LocalPlayer():ScreenFade( SCREENFADE.IN, GetConVar("tacrp_flash_dark"):GetBool() and Color(0, 0, 0, 254) or Color(255, 255, 255, 254), 2.5, time )

    if GetConVar("tacrp_flash_dark"):GetBool() then
        LocalPlayer():SetDSP( 32, false )
    else
        LocalPlayer():SetDSP( 37, false )
    end
end)