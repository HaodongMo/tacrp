local badseqs = {
    ["Unknown"] = true, -- no cower sequence
    ["head_pitch"] = true, -- antlion guards
    ["Walk_Neutral_South"] = true, -- l4d2 common inf
}

function TacRP.Flashbang(ent, pos, radius, time_max, time_min, time_stunadd)
    time_stunadd = time_stunadd or 0.5
    for _, k in ipairs(ents.FindInSphere(pos, radius)) do
        if k:IsPlayer() then
            local dist = k:EyePos():Distance(pos)
            local dp = (k:EyePos() - pos):Dot(k:EyeAngles():Forward())

            local time = Lerp( dp, time_max, time_min )

            time = Lerp( dist / radius, time, time_min )

            local tr = util.QuickTrace(pos, k:EyePos() - pos, {k, ent})

            if tr.Fraction < 1 then
                time = 0
            else
                local wep = k:GetActiveWeapon()
                if IsValid(wep) and wep.ArcticTacRP and wep:GetValue("StunResist") then
                    time = math.sqrt(time) * 0.5
                    time_stunadd = math.sqrt(time_stunadd) * 0.5
                end

                k:SetNWFloat("TacRPStunStart", CurTime())
                k:SetNWFloat("TacRPStunDur", time + time_stunadd)
            end

            net.Start("tacrp_flashbang")
                net.WriteFloat(time)
            net.Send(k)
        elseif k:IsNPC() and TacRP.ConVars["flash_affectnpcs"]:GetBool() and (k.TacRP_FlashEnd or 0) < CurTime() then
            local ret = hook.Run("TacRP_StunNPC", k, ent)
            if ret then continue end
            local t = time_max
            -- stun them if they have a good cower sequence. this doesn't affect npcs like antlion guards, manhacks etc.
            if badseqs[k:GetSequenceName(ACT_COWER)] != true then
                local tr = util.TraceLine({
                    start = pos,
                    endpos = k:EyePos(),
                    mask = MASK_SOLID,
                    filter = {ent, k}
                })
                if tr.Fraction == 1 then
                    k:SetSchedule(SCHED_COWER)
                    k:RestartGesture(ACT_COWER)
                    k:SetNPCState(NPC_STATE_NONE)
                    k.TacRP_FlashEnd = CurTime() + t - 0.01
                    timer.Simple(t, function()
                        if IsValid(k) then
                            k:SetNPCState(NPC_STATE_ALERT)
                        end
                    end)
                end
            else
                local tr = util.TraceLine({
                    start = pos,
                    endpos = k:EyePos(),
                    mask = MASK_SOLID,
                    filter = {ent, k}
                })
                if tr.Fraction == 1 then
                    k.TacRP_FlashEnd = CurTime() + t - 0.01
                    timer.Create("tacrp_flash_" .. k:EntIndex(), 0.5, math.ceil(t / 0.5), function()
                        if IsValid(k) then k:SetSchedule(SCHED_STANDOFF) end
                    end)
                    k:SetSchedule(SCHED_STANDOFF)
                end
            end
        end
    end
end

TacRP.WeaponListCache = {}
function TacRP.GetWeaponList(subcat, tier)
    if !subcat then subcat = "" end
    if !tier then tier = "" end
    if !TacRP.WeaponListCache[subcat] or !TacRP.WeaponListCache[subcat][tier] then
        TacRP.WeaponListCache[subcat] = TacRP.WeaponListCache[subcat] or {}
        TacRP.WeaponListCache[subcat][tier] = {}

        for i, wep in pairs(weapons.GetList()) do
            local weap = weapons.Get(wep.ClassName)
            if !weap or !weap.ArcticTacRP
                    or wep.ClassName == "tacrp_base" or wep.ClassName == "tacrp_base_nade" or wep.ClassName == "tacrp_base_melee"
                    or !weap.Spawnable or weap.AdminOnly
                    or (subcat == "npc" and !weap.NPCUsable)
                    or (subcat != "" and subcat != "npc" and subcat != weap.SubCatType)
                    or (tier != "" and tier != weap.SubCatTier) then
                continue
            end

            table.insert(TacRP.WeaponListCache[subcat][tier], wep.ClassName)
        end
    end
    return TacRP.WeaponListCache[subcat][tier]
end

function TacRP.GetRandomWeapon(subcat, tier)
    if !subcat then subcat = "" end
    if !tier then tier = "" end

    local tbl = TacRP.GetWeaponList(subcat, tier)
    return tbl[math.random(1, #tbl)]
end

local cats = {
    ["ClassName"] = true,
    ["PrintName"] = true,
    ["SubCatTier"] = function(wep) return string.sub(wep.SubCatTier, 1) end,
    ["SubCatType"] = function(wep) return string.sub(wep.SubCatType, 1) end,
    ["Damage_Max"] = true,
    ["Damage_Min"] = true,
    ["Raw DPS"] = function(wep)
        local valfunc = wep.GetBaseValue
        local bfm = wep:GetBestFiremode(true)
        local rrpm = wep:GetRPM(true, bfm)
        local erpm = rrpm
        local pbd = valfunc(wep, "PostBurstDelay")
        if bfm < 0 then
            erpm = 60 / ((1 / (rrpm / 60)) + (pbd / -bfm))
        end
        local num = valfunc(wep, "Num")
        local dmg = math.max(valfunc(wep, "Damage_Max"), valfunc(wep, "Damage_Min"))
        return math.Round(dmg * num * erpm / 60, 1)
    end,

    ["Range_Max"] = true,
    ["Range_Min"] = true,

    ["MuzzleVelocity"] = true,
    ["ClipSize"] = true,
    ["RPM"] = true,

    ["RecoilKick"] = true,
    ["RecoilStability"] = true,
    ["Spread"] = true,
    ["RecoilSpreadPenalty"] = true,
    ["HipFireSpreadPenalty"] = true,

    ["MoveSpeedMult"] = true,
    ["ShootingSpeedMult"] = true,
    ["SightedSpeedMult"] = true,
    ["ReloadSpeedMult"] = true,
    ["ReloadTime"] = function(wep) return math.Round(wep:GetReloadTime(true), 2) end,

    ["AimDownSightsTime"] = true,
    ["SprintToFireTime"] = true,
}

concommand.Add("tacrp_dev_dumpstats", function()
    if !game.SinglePlayer() then return end
    local str = ""
    local str_l18n = ""
    print("Dumping stats, this may lag a bit...")
    -- headers
    for k, v in pairs(cats) do
        str = str .. k .. ","
    end
    str = string.sub(str, 0, -1) .. "\n"
    timer.Simple(0.1, function()
        local ply = Entity(1)
        for _, class in SortedPairs(TacRP.GetWeaponList()) do
            local wpn = ply:Give(class, true)
            str_l18n = str_l18n .. "L[\"wep." .. class .. ".name\"] = [[" .. (wpn.PrintName or "") .. "]]" .. "\n"
            str_l18n = str_l18n .. "L[\"wep." .. class .. ".desc\"] = [[" .. (wpn.Description or "") .. "]]" .. "\n"
            str_l18n = str_l18n .. "L[\"wep." .. class .. ".desc.quote\"] = [[" .. (wpn.Description_Quote or "") .. "]]" .. "\n\n"
            for k, v in pairs(cats) do
                if v == true then
                    str = str .. (wpn[k] or "") .. ","
                else
                    str = str .. v(wpn) .. ","
                end
            end
            ply:StripWeapon(class)
            str = string.sub(str, 0, -1) .. "\n"
        end
        file.Write("tacrp_dumpstats.csv", str)
        file.Write("tacrp_l18n.txt", str_l18n)

        print("Dumped stats to tacrp_dumpstats.csv")
    end)
end, nil, "Collects some stats and dumps them to a CSV file. Singleplayer only, may lag a bit.")