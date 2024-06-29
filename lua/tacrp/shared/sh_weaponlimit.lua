if engine.ActiveGamemode() == "terrortown" then return end

local whitelist = {
    weapon_physgun = true,
    weapon_physcannon = true,
    gmod_tool = true,
    gmod_camera = true,
}

-- return true if within limit
-- wep is not guaranteed to be an Entity! it could be the weapon table from weapons.Get
function TacRP:CheckWeaponLimit(weplist, wep)
    local limit = TacRP.ConVars["slot_limit"]:GetInt()
    if limit == 0 then return true end
    local countall = TacRP.ConVars["slot_countall"]:GetBool()
    local slot = (wep.GetSlot and wep:GetSlot()) or wep.Slot
    local weps = {}
    for k, v in pairs(weplist) do
        if !whitelist[v:GetClass()] and (countall or v.ArcticTacRP) and (v:GetSlot() == slot) and !(v.ArcticTacRP and v:GetValue("PrimaryGrenade")) then
            table.insert(weps, v)
        end
    end

    if #weps >= limit then
        return false, weps
    end
    return true
end

hook.Add("PlayerCanPickupWeapon", "TacRP_Pickup", function(ply, wep)
    if !IsValid(wep) or !wep.ArcticTacRP then return end
    local limit, weps = TacRP:CheckWeaponLimit(ply:GetWeapons(), wep)

    if !limit then
        if TacRP.ConVars["allowdrop"]:GetBool() and ((ply:KeyDown(IN_USE) and !ply:KeyDown(IN_WALK) and ply:GetEyeTrace().Entity == wep) or wep:GetPos() == ply:GetPos()) then
            if weps[1] == ply:GetActiveWeapon() then
                timer.Simple(0, function()
                    if IsValid(ply) and IsValid(wep) and wep:GetOwner() == ply then
                        ply:SelectWeapon(wep)
                    end
                end)
            end
            TacRP.DropWeapon(ply, weps[1])
            return
        else
            return false
        end
    end

    if ply:GetInfoNum("tacrp_pickup_use", 0) == 1
            and wep:GetPos() ~= ply:GetPos() -- received through ply:Give()
            and (!ply:KeyDown(IN_USE) or ply:KeyDown(IN_WALK) or ply:GetEyeTrace().Entity ~= wep) then
        return false
    end
end)

hook.Add("AllowPlayerPickup", "TacRP_Pickup", function(ply, ent)
    if ent.ArcticTacRP and ply:GetInfoNum("tacrp_pickup_use", 0) == 1 and !ply:KeyDown(IN_WALK) then
        return false -- This prevents +USE physics pickup, to avoid awkward situations where you want to equip a weapon but
    end
end)

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
    local _, weps = TacRP:CheckWeaponLimit(ply:GetWeapons(), weapons.Get(wepname) or {Slot = slot[wepname]})
    if weps and !ply:HasWeapon(wepname) then
        local mode = TacRP.ConVars["slot_action"]:GetInt()
        local limit = TacRP.ConVars["slot_limit"]:GetInt()

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
                    TacRP.DropWeapon(ply, e)
                end
                amt = amt - 1
                if amt <= 0 then break end
            end

            ply:ChatPrint("[TacRP] " .. str .. " due to the slot limit (max " .. limit .. ").")
        end
    end
end)

local function slotty()
    local ahh = TacRP.ConVars["slot_hl2"]:GetBool()
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

    hook.Add("HUDPaint", "TacRP_WeaponLimit", function()
        local wep = LocalPlayer():GetEyeTrace().Entity
        if !IsValid(wep) or wep:GetPos():DistToSqr(EyePos()) >= 96 * 96 then return end
        local wepclass = wep:GetClass()
        if wep.IsSpawnedWeapon then
            wepclass = wep:GetWeaponClass()
            wep = weapons.Get(wepclass)
        elseif !wep.ArcticTacRP then
            return
        end

        if !GetConVar("tacrp_pickuphint"):GetBool() then return end

        local limit, weps = TacRP:CheckWeaponLimit(LocalPlayer():GetWeapons(), wep)

        local text = nil

        if !limit then
            text = "[" .. TacRP.GetBindKey("+use") .. "] "
                    .. TacRP:GetPhrase("hint.swap", {
                        weapon = TacRP:GetPhrase("wep." .. weps[1]:GetClass() .. "name") or weps[1].PrintName,
                        weapon2 = TacRP:GetPhrase("wep." .. wepclass .. "name") or wep.PrintName
                    })
        elseif TacRP.ConVars["pickup_use"]:GetBool() then
            text = "[" .. TacRP.GetBindKey("+use") .. "] "
            .. TacRP:GetPhrase("hint.pickup", {weapon = TacRP:GetPhrase("wep." .. wepclass .. "name") or wep.PrintName})
        end

        if text then
            local font = "TacRP_HD44780A00_5x8_4"
            surface.SetFont(font)
            local w, h = surface.GetTextSize(text)
            w = w + TacRP.SS(8)
            h = h + TacRP.SS(4)

            surface.SetDrawColor(0, 0, 0, 200)
            TacRP.DrawCorneredBox(ScrW() / 2 - w / 2, ScrH() / 2 + TacRP.SS(32), w, h)

            draw.SimpleText(text, font, ScrW() / 2, ScrH() / 2 + TacRP.SS(32) + h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end)


    concommand.Add("tacrp_drop", function(ply, cmd, args, argStr)
        if !TacRP.ConVars["allowdrop"]:GetBool() then return end
        local wep = ply:GetActiveWeapon()
        if !IsValid(wep) or !wep.ArcticTacRP then return end
        if !ply:Alive() then return end
        net.Start("tacrp_drop")
        net.SendToServer()
    end, "Drops the currently held TacRP weapon.")
end