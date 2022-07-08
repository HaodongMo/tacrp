hook.Add( "PlayerCanPickupWeapon", "TacRP_Pickup", function( ply, wep )
    if GetConVar("tacrp_limitslots"):GetBool() then
        for k, v in pairs( ply:GetWeapons() ) do
            if (wep:GetSlot() == 2 or wep:GetSlot() == 3) and (v:GetSlot() == wep:GetSlot()) then
                return false
            end
        end
        return true
    end
end )