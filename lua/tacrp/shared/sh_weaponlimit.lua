local function check(ply, wep)
    local limit = GetConVar("tacrp_limitslots"):GetInt()
    local slot = (wep.GetSlot and wep:GetSlot()) or wep.Slot
    local weps = {}
    if limit > 0 and (limit > 1 or wep.ArcticTacRP) then
        for k, v in pairs( ply:GetWeapons() ) do
            if (limit > 1 or v.ArcticTacRP) and (slot >= 1 and slot <= 4) and (v:GetSlot() == slot) then
                table.insert(weps, v)
            end
        end
    end
    if #weps > 0 then
        return false, weps
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
    local _, weps = check(ply, weapons.Get(wepname) or {Slot = slot[wepname]})
    if weps and #weps > 0 and !ply:HasWeapon(wepname) then
        for _, e in pairs(weps) do
            ply:ChatPrint("[TacRP] " .. e:GetPrintName() .. " was removed due to the slot limit.")
            ply:StripWeapon(e:GetClass())
            --ply:DropWeapon(e, nil, ply:GetForward() * 50)
        end

        -- return false
    end
end)