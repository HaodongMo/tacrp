ATT.PrintName = "Heavy"
ATT.FullName = "Heavy-handed"
ATT.Icon = Material("entities/tacrp_att_melee_tech_heavy.png", "mips smooth")
ATT.Description = "A classic counter-terrorist technique: Just smack them real hard."
ATT.Pros = {"ALT-FIRE: Heavy Attack", "Backstab Damage"}

ATT.Category = {"melee_tech"}

ATT.SortOrder = 1

ATT.HeavyAttack = true

ATT.Free = true

ATT.MeleeBackstab = true
ATT.MeleeBackstabMult = 1.5

ATT.Hook_SecondaryAttack = function(self)
    self:Melee(true)

    -- Cancel demoknight charge
    local ply = self:GetOwner()
    if ply:Alive() and ply:GetNWBool("TacRPChargeState", false) then
        ply:SetNWBool("TacRPChargeState", false)
        ply:SetNWFloat("TacRPChargeTime", 0)
        ply:SetNWFloat("TacRPChargeEnd", CurTime())

        if IsValid(ply:GetNWEntity("TacRPChargeWeapon")) then
            ply:GetNWEntity("TacRPChargeWeapon"):SetBreath(0)
        end

        ply:SetCustomCollisionCheck(ply.TacRPPrevColCheck)
        if ply.TacRPPrevFlag then
            ply:RemoveEFlags(EFL_NO_DAMAGE_FORCES)
        end
        ply.TacRPPrevColCheck = nil
        ply.TacRPPrevFlag = nil

        ply:EmitSound("TacRP.Charge.End")
    end

    return true
end

ATT.Hook_GetHintCapabilities = function(self, tbl)
    tbl["+attack"] = {so = 0, str = "hint.melee.light"}
    tbl["+attack2"] = {so = 0.1, str = "hint.melee.heavy"}
end