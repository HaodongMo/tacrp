ATT.PrintName = "Surplus"
ATT.FullName = "Surplus Rounds"
ATT.Icon = Material("entities/tacrp_att_acc_surplus.png", "mips smooth")
ATT.Description = "Consistently unreliable old ammo, yet you keep finding them everywhere."
ATT.Pros = {"High chance to refund ammo"}
ATT.Cons = {"Unreliable"}
ATT.Category = {"ammo_rifle", "ammo_sniper", "ammo_pistol", "ammo_amr", "ammo_shotgun"}

ATT.SortOrder = 999

-- ATT.Mult_SupplyLimit = 2
ATT.Mult_ShootChance = 0.98
ATT.Add_ShootPitchVariance = 2.5

ATT.Hook_PostShoot = function(wep)
    if CLIENT then return end
    if wep:GetOwner():IsPlayer() and !wep:GetInfiniteAmmo() and math.random() <= 0.75 then
        wep:GetOwner():GiveAmmo(math.random(1, wep:GetValue("AmmoPerShot")), wep:GetPrimaryAmmoType(), true)
    end
end