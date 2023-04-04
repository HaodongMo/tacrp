TacRP.TTTAmmoToEntity = {
    ["pistol"] = "item_ammo_pistol_ttt",
    ["smg1"] = "item_ammo_smg1_ttt",
    ["AlyxGun"] = "item_ammo_revolver_ttt",
    ["357"] = "item_ammo_357_ttt",
    ["buckshot"] = "item_box_buckshot_ttt"
}
--[[
WEAPON_TYPE_RANDOM = 1
WEAPON_TYPE_MELEE = 2
WEAPON_TYPE_NADE = 3
WEAPON_TYPE_SHOTGUN = 4
WEAPON_TYPE_HEAVY = 5
WEAPON_TYPE_SNIPER = 6
WEAPON_TYPE_PISTOL = 7
WEAPON_TYPE_SPECIAL = 8
]]

TacRP.AmmoToTTT = {
    ["357"] = "AlyxGun",
    ["SniperPenetratedRound"] = "357",
    ["ar2"] = "smg1",
}

TacRP.TTTAmmoToClipMax = {
    ["357"] = 20,
    ["smg1"] = 60,
    ["pistol"] = 60,
    ["alyxgun"] = 36,
    ["buckshot"] = 24
}

if engine.ActiveGamemode() != "terrortown" then return end

hook.Add("OnGamemodeLoaded", "TacRP_TTT", function()
    for i, wep in pairs(weapons.GetList()) do
        local weap = weapons.Get(wep.ClassName)
        if !weap or !weap.ArcticTacRP or wep.ClassName == "tacrp_base" or wep.ClassName == "tacrp_base_nade" then
            continue
        end

        if TacRP.AmmoToTTT[wep.Ammo] then
            wep.Ammo = TacRP.AmmoToTTT[wep.Ammo]
        end

        wep.AmmoEnt = TacRP.TTTAmmoToEntity[wep.Ammo] or ""
        -- You can tell how desperate I am in blocking the base from spawning
        wep.AutoSpawnable = (wep.AutoSpawnable == nil and true) or wep.AutoSpawnable
        wep.AllowDrop = wep.AllowDrop or true

        -- We have to do this here because TTT2 does a check for .Kind in WeaponEquip,
        -- earlier than Initialize() which assigns .Kind
        if !wep.Kind and !wep.CanBuy then
            if wep.PrimaryGrenade then
                wep.Slot = 3
                wep.Kind = WEAPON_NADE
                wep.spawnType = wep.spawnType or WEAPON_TYPE_NADE
            elseif wep.Slot == 0 then
                -- melee weapons
                wep.Slot = 6
                wep.Kind = WEAPON_MELEE or WEAPON_EQUIP1
                wep.spawnType = wep.spawnType or WEAPON_TYPE_MELEE
            elseif wep.Slot == 1 then
                -- sidearms
                wep.Kind = WEAPON_PISTOL
                wep.spawnType = wep.spawnType or WEAPON_TYPE_PISTOL
            else
                -- other weapons are considered primary
                -- try to determine spawntype if none exists
                if !wep.spawnType then
                    if wep.Ammo == "357" or (wep.Slot == 3 and (wep.Num or 1) == 1) then
                        wep.spawnType = WEAPON_TYPE_SNIPER
                    elseif wep.Ammo == "buckshot" or (wep.Num or 1) > 1 then
                        wep.spawnType = WEAPON_TYPE_SHOTGUN
                    else
                        wep.spawnType = WEAPON_TYPE_HEAVY
                    end
                end

                wep.Slot = 2
                wep.Kind = WEAPON_HEAVY
            end
        end

        local class = wep.ClassName
        local path = "tacrp/weaponicons/" .. class
        local path2 = "tacrp/ttticons/" .. class .. ".png"
        local path3 = "vgui/ttt/" .. class
        local path4 = "entities/" .. class .. ".png"

        if !Material(path2):IsError() then
            -- TTT icon (png)
            wep.Icon = path2
        elseif !Material(path3):IsError() then
            -- TTT icon (vtf)
            wep.Icon = path3
        elseif !Material(path4):IsError() then
            -- Entity spawn icon
            wep.Icon = path4
        elseif !Material(path):IsError() then
            -- Kill icon
            wep.Icon = path
        else
            -- fallback: display _something_
            wep.Icon = "entities/npc_headcrab.png"
        end

    end
end)