ATT.PrintName = "Surplus"
ATT.FullName = "Surplus Bolt"
ATT.Icon = Material("entities/tacrp_att_bolt_surplus.png", "mips smooth")
ATT.Description = "Rust has eaten most of it away, but it still kinda works."
ATT.Pros = {"Shoots faster sometimes"}
ATT.Cons = {"Also shoots uncontrollably", "Unreliable"}

ATT.Category = {"bolt_manual", "bolt_automatic"}

ATT.SortOrder = 999

ATT.Mult_ShootChance = 0.96

ATT.Hook_PostShoot = function(wep)
    if CLIENT then return end
    if (wep.TacRP_NextSurplusBoost or 0) < CurTime() and math.random() <= 0.5 then
        wep:SetNWFloat("TacRP_SurplusBoost", CurTime() + math.Rand(0.15, 0.4))
        wep.TacRP_NextSurplusBoost = CurTime() + math.Rand(0.5, 2)
    end
end

ATT.Hook_PostJam = function(wep)
    wep:SetNWFloat("TacRP_SurplusBoost", 0)
end

ATT.Hook_PostThink = function(wep)
    if wep:GetCurrentFiremode() != 1 and wep:GetNWFloat("TacRP_SurplusBoost", 0) >= CurTime() then
        wep:PrimaryAttack()
    end
end

hook.Add("TacRP_Stat_RPM", "bolt_surplus", function(wep, data)
    if wep:GetNWFloat("TacRP_SurplusBoost", 0) >= CurTime() then
        data.mul = data.mul * 1.15
    end
end)

hook.Add("TacRP_Stat_Pitch_Shoot", "bolt_surplus", function(wep, data)
    if wep:GetNWFloat("TacRP_SurplusBoost", 0) >= CurTime() then
        data.add = data.add + 7.5
    end
end)