local whitelist = {
    weapon_physgun = true,
    weapon_physcannon = true,
    gmod_tool = true,
    gmod_camera = true,
}

local function check(ply, wep)
    local limit = GetConVar("tacrp_slot_limit"):GetInt()
    local countall = GetConVar("tacrp_slot_countall"):GetBool()
    local slot = (wep.GetSlot and wep:GetSlot()) or wep.Slot
    local weps = {}
    if limit > 0 and wep.ArcticTacRP then
        for k, v in pairs( ply:GetWeapons() ) do
            if !whitelist[v:GetClass()] and (countall or v.ArcticTacRP) and (v:GetSlot() == slot) then
                table.insert(weps, v)
            end
        end

        if #weps >= limit then
            return false, weps
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
    local _, weps = check(ply, weapons.Get(wepname) or {Slot = slot[wepname]})
    if weps and !ply:HasWeapon(wepname) then
        local mode = GetConVar("tacrp_slot_action"):GetInt()
        local limit = GetConVar("tacrp_slot_limit"):GetInt()

        if mode == 0 then
            ply:ChatPrint("[TacRP] Couldn't spawn " .. weptbl.PrintName .. " due to the slot limit (max " .. limit .. ").")
            return false
        elseif mode == 1 or mode == 2 then

            local amt = #weps + 1 - limit

            local str = amt == 1 and (weps[1]:GetPrintName() .. " was") or (amt .. " weapons were")
            str = str .. (mode == 1 and " removed" or " dropped")

            for _, e in pairs(weps) do
                if mode == 1 then
                    ply:StripWeapon(e:GetClass())
                else
                    ply:DropWeapon(e, nil, ply:GetForward() * 50)
                end
                amt = amt - 1
                if amt <= 0 then break end
            end

            ply:ChatPrint("[TacRP] " .. str .. " due to the slot limit (max " .. limit .. ").")
        end
    end
end)

local function slotty()
    local ahh = GetConVar("tacrp_slot_hl2"):GetBool()
    for _, wpn in pairs(weapons.GetList()) do

        -- weapons.GetStored does not contain inherited values (like ArcticTacRP)
        local tbl = weapons.Get(wpn.ClassName)
        if !tbl.ArcticTacRP then continue end

        local tblStored = weapons.GetStored(wpn.ClassName)
        if tblStored.SlotOrig == nil then
            tblStored.SlotOrig = tblStored.Slot
        end

        tblStored.Slot = ahh and tblStored.SlotAlt or tblStored.SlotOrig
    end
end

hook.Add("InitPostEntity", "TacRP_Slot", function()
    slotty()

    -- even if the convar is replicated, the callback is not run on client
    cvars.AddChangeCallback("tacrp_slot_hl2", function(cvar, old, new)
        if CLIENT then return end
        slotty()
        timer.Simple(0, function()
            net.Start("tacrp_updateslot")
            net.Broadcast()
        end)
    end, "slotty")
end)

if CLIENT then
    net.Receive("tacrp_updateslot", slotty)
end