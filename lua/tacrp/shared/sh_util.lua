function TacRP.GetMoveVector(mv)
    local ang = mv:GetAngles()

    local max_speed = mv:GetMaxSpeed()

    local forward = math.Clamp(mv:GetForwardSpeed(), -max_speed, max_speed)
    local side = math.Clamp(mv:GetSideSpeed(), -max_speed, max_speed)

    local abs_xy_move = math.abs(forward) + math.abs(side)

    if abs_xy_move == 0 then
        return Vector(0, 0, 0)
    end

    local mul = max_speed / abs_xy_move

    local vec = Vector()

    vec:Add(ang:Forward() * forward)
    vec:Add(ang:Right() * side)

    vec:Mul(mul)

    return vec
end

function TacRP.GetCmdVector(cmd, defaultforward)
    local ang = Angle(0, cmd:GetViewAngles().y, 0)

    local forward = cmd:GetForwardMove() / 10000
    local side = cmd:GetSideMove() / 10000

    local abs_xy_move = math.abs(forward) + math.abs(side)
    if abs_xy_move == 0 then
        if defaultforward then
            forward = 1
        else
            return Vector()
        end
    end
    local div = (forward ^ 2 + side ^ 2) ^ 0.5

    local vec = Vector()
    vec:Add(ang:Forward() * forward / div)
    vec:Add(ang:Right() * side / div)

    return vec
end

function TacRP.CancelBodyDamage(ent, dmginfo, hitgroup)
    local tbl = TacRP.CancelMultipliers[string.lower(engine.ActiveGamemode())] or TacRP.CancelMultipliers[1]

    if IsValid(ent) and (ent:IsNPC() or ent:IsPlayer()) and TacRP.ConVars["bodydamagecancel"]:GetBool() then
        dmginfo:ScaleDamage(1 / (tbl[hitgroup] or 1))
    end

    -- Lambda Players call ScalePlayerDamage and cancel out hitgroup damage... except on the head
    if IsValid(ent) and ent.IsLambdaPlayer and hitgroup == HITGROUP_HEAD then
        dmginfo:ScaleDamage(1 / (tbl[hitgroup] or 1))
    end

    return dmginfo
end

function TacRP.EntityIsNecrotic(ent)
    if ent:IsNPC() and ent:Classify() == CLASS_ZOMBIE then return true end
    if ent.VJ_NPC_Class == "CLASS_ZOMBIE" or (istable(ent.VJ_NPC_Class) and table.HasValue(ent.VJ_NPC_Class,  "CLASS_ZOMBIE")) then return true end
    local ret = hook.Run("TacRP_EntityIsNecrotic", ent)
    if ret != nil then return ret end
    return false
end

function TacRP.FormatTierType(wtype, wtier, use_tiers)
    if wtype then
        local type_txt = string.sub(TacRP:TryTranslate(wtype), 2)
        if use_tiers and wtier and wtier != "9Special" then
            type_txt = TacRP:GetPhrase("cust.type_tier", {tier = string.sub(TacRP:TryTranslate(wtier), 2), type = type_txt})
        end
        return type_txt
    end
    return "Weapon"
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

function TacRP.Developer(i)
    return (SERVER or (CLIENT and IsValid(LocalPlayer()) and LocalPlayer():IsSuperAdmin())) and GetConVar("developer"):GetInt() >= (i or 1)
end