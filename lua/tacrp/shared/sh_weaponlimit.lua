local function check(ply, wep)
    local limit = GetConVar("tacrp_limitslots"):GetInt()
    local slot = (wep.GetSlot and wep:GetSlot()) or wep.Slot
    if limit > 0 and (limit > 1 or wep.ArcticTacRP) then
        for k, v in pairs( ply:GetWeapons() ) do
            if (limit > 1 or v.ArcticTacRP) and (slot == 2 or slot == 3 or slot == 4) and (v:GetSlot() == slot) then
                return false
            end
        end
    end
end

hook.Add("PlayerCanPickupWeapon", "TacRP_Pickup", check)
local slot = {
    weapon_physgun = 0,
    weapon_crowbar = 0,
    weapon_stunstick = 0,
    weapon_physcannon = 0,
    weapon_pistol = 1,
    weapon_357 = 1,
    weapon_smg1 = 2,
    weapon_ar2 = 2,
    weapon_crossbow = 3,
    weapon_shotgun = 3,
    weapon_frag = 4,
    weapon_rpg = 4,
    weapon_slam = 4,
    weapon_bugbait = 5
}
hook.Add("PlayerGiveSWEP", "TacRP_Pickup", function(ply, wepname, weptbl)
    if check(ply, weapons.Get(wepname) or {Slot = slot[wepname]}) == false then
        ply:ChatPrint("[TacRP] You already have a weapon in that slot!")
        return false
    end
end)