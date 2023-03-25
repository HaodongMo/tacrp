ATT.PrintName = "Guard"
ATT.FullName = "High Guard"

ATT.Icon = Material("entities/tacrp_att_acc_melee.png", "mips smooth")
ATT.Description = ""
ATT.Pros = {"ALT-FIRE: Block melee attacks", "Counterattack disarms"}

ATT.Category = {"melee_tech"}

ATT.SortOrder = 2

ATT.Hook_SecondaryAttack = function(wep)
    -- if wep:StillWaiting() then return end
    if wep:GetNWFloat("TacRPNextBlock", 0) > CurTime() then return end
    wep:SetNWFloat("TacRPNextBlock", CurTime() + 1)

    wep:PlayAnimation("idle_defend", 1, true)
    wep:SetHoldType("magic")
    wep:SetNWFloat("TacRPKnifeParry", CurTime() + 0.5)
    wep:EmitSound("tacrp/weapons/pistol_holster-" .. math.random(1, 4) .. ".wav", 75, 110)

    wep:SetNextIdle(CurTime() + 0.5)
    if SERVER then
        wep:SetTimer(0.5, function()
            wep:SetShouldHoldType()
        end, "BlockReset")
    end
end

ATT.Hook_PreShoot = function(wep)
    if wep:GetNWFloat("TacRPKnifeCounter", 0) > CurTime() then
        wep:Melee(true)
        return true
    end
end

hook.Add("EntityTakeDamage", "TacRP_Block", function(ent, dmginfo)
    if !IsValid(dmginfo:GetAttacker()) or !ent:IsPlayer() then return end
    local wep = ent:GetActiveWeapon()

    if !IsValid(wep) or !wep.ArcticTacRP or wep:GetNWFloat("TacRPKnifeParry", 0) < CurTime() then return end
    if !(dmginfo:IsDamageType(DMG_GENERIC) or dmginfo:IsDamageType(DMG_CLUB) or dmginfo:IsDamageType(DMG_SLASH)) then return end
    if dmginfo:GetAttacker():GetPos():DistToSqr(ent:GetPos()) >= 22500 then return end
    if (dmginfo:GetAttacker():GetPos() - ent:EyePos()):GetNormalized():Dot(ent:EyeAngles():Forward()) < 0.5 then return end

    local ang = ent:EyeAngles()
    local fx = EffectData()
    fx:SetOrigin(ent:EyePos())
    fx:SetNormal(ang:Forward())
    fx:SetAngles(ang)
    util.Effect("ManhackSparks", fx)

    wep:EmitSound("physics/metal/metal_solid_impact_hard5.wav", 90, math.Rand(105, 110))
    wep:SetNextSecondaryFire(CurTime())
    wep:Idle()
    wep:SetNWFloat("TacRPKnifeCounter", CurTime() + 1)
    wep:SetNWFloat("TacRPNextBlock", CurTime())
    wep:KillTimer("BlockReset")
    wep:SetShouldHoldType()

    return true
end)

hook.Add("EntityTakeDamage", "TacRP_Counter", function(ent, dmginfo)
    if !IsValid(dmginfo:GetAttacker()) or !dmginfo:GetAttacker():IsPlayer() or !ent:IsPlayer() then return end
    local wep = dmginfo:GetAttacker():GetActiveWeapon()

    if !IsValid(wep) or !wep.ArcticTacRP or wep:GetNWFloat("TacRPKnifeCounter", 0) < CurTime() then return end
    local dropwep = ent:GetActiveWeapon()
    if !IsValid(dropwep) or dropwep:GetHoldType() == "fists" or dropwep:GetHoldType() == "normal" or string.find(dropwep:GetClass(), "fist") or string.find(dropwep:GetClass(), "unarmed") or string.find(dropwep:GetClass(), "hand") then return end

    ent:DropWeapon(dropwep, dmginfo:GetAttacker():GetPos())
end)