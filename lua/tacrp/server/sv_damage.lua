-- affects how much armor is reduced from damage
local armorbonus = 1.0
-- affects what fraction of damage is converted to armor damage (1 means none)
-- local armorratio = 0.2

-- Simulate armor calculation
-- https://github.com/ValveSoftware/source-sdk-2013/blob/0d8dceea4310fde5706b3ce1c70609d72a38efdf/mp/src/game/server/player.cpp#L1061
local function calcarmor(dmginfo, armor, flBonus, flRatio)
    local old = GetConVar("player_old_armor"):GetBool()
    if !flBonus then
        flBonus = old and 0.5 or 1
    end
    flRatio = flRatio or 0.2

    local dmg = dmginfo:GetDamage()
    if dmginfo:IsDamageType(DMG_BLAST) and !game.SinglePlayer() then
        flBonus = flBonus * 2
    end
    if armor > 0 then
        local flNew = dmg * flRatio
        local flArmor = (dmg - flNew) * flBonus

        if !old and flArmor == 0 then
            flArmor = 1
            -- flArmor = math.max(1, flArmor)
        end

        if flArmor > armor then
            flArmor = armor * (1 / flBonus)
            flNew = dmg - flArmor
            -- m_DmgSave = armor -- ?
            armor = 0
        else
            -- m_DmgSave = flArmor
            armor = math.max(0, armor - flArmor)
        end

        dmg = flNew
    end
    return dmg, armor
end

local bitflags_blockable = DMG_BULLET + DMG_BUCKSHOT + DMG_BLAST
hook.Add("EntityTakeDamage", "Z_TacRP", function(ply, dmginfo)
    if !TacRP.ConVars["armorpenetration"]:GetBool() then return end
    if !ply:IsPlayer() or dmginfo:IsFallDamage() or dmginfo:GetDamage() < 1 then return end

    local wep = dmginfo:GetInflictor()
    if wep:IsPlayer() then wep = wep:GetActiveWeapon() end

    if !IsValid(wep) or !wep.ArcticTacRP then return end

    -- do we even have armor?
    if (engine.ActiveGamemode() == "terrortown" and !ply:HasEquipmentItem(EQUIP_ARMOR))
            or (engine.ActiveGamemode() ~= "terrortown" and ply:Armor() <= 0) then
        return
    end

    -- only handle these damage types
    if bit.band(dmginfo:GetDamageType(), bitflags_blockable) == 0 then
        return
    end

    -- if danger zone armor wants to handle it, don't do it
    if DZ_ENTS and ply:Armor() > 0 and (GetConVar("dzents_armor_enabled"):GetInt() == 2 or (GetConVar("dzents_armor_enabled"):GetInt() == 1 and ply:DZ_ENTS_HasArmor())) then
        return
    end

    local ap = wep:GetValue("ArmorPenetration")
    local ab = wep:GetValue("ArmorBonus")

    local healthdmg, newarmor = calcarmor(dmginfo, ply:Armor(), armorbonus * ab, ap)
    -- print("WANT", ply:Health() - healthdmg, newarmor, "(" .. healthdmg .. " dmg, " .. (ply:Armor() - newarmor) .. " armor)")
    ply.TacRPPendingArmor = newarmor
    ply:SetArmor(0) -- don't let engine do armor calculation
    dmginfo:SetDamage(healthdmg)
end)

hook.Add("PostEntityTakeDamage", "TacRP", function(ply, dmginfo, took)
    if !TacRP.ConVars["armorpenetration"]:GetBool() then return end
    if !ply:IsPlayer() then return end
    if ply.TacRPPendingArmor then
        ply:SetArmor(ply.TacRPPendingArmor)
        -- print("SET", ply:Armor())
        -- timer.Simple(0, function()
        --     print("POST", ply:Health(), ply:Armor())
        -- end)
    end
    ply.TacRPPendingArmor = nil
end)