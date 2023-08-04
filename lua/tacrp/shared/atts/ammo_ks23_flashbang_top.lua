ATT.PrintName = "Zvezda (Top)"
ATT.FullName = "KS-23 Zvezda Flash Shells (Top-loaded)"
ATT.Icon = Material("entities/tacrp_att_ammo_ks23_flashbang.png", "mips smooth")
ATT.Description = "Load the first round with flash rounds and the rest with standard shells."
ATT.Pros = {"att.procon.flash"}
ATT.Cons = {"att.procon.timedfuse", "att.procon.nonlethal"}

ATT.SortOrder = 1.1
ATT.Category = "ammo_ks23"
ATT.InvAtt = "ammo_ks23_flashbang"

ATT.ShootEntForce = 1200

ATT.Func_Num = function(wep, modifiers)
    if wep:Clip1() == wep:GetMaxClip1() then
        modifiers.set = 1
        modifiers.prio = 10
    end
end
ATT.Func_ShootEnt = function(wep, modifiers)
    if wep:Clip1() == wep:GetMaxClip1() then
        modifiers.set = "tacrp_proj_ks23_flashbang"
        modifiers.prio = 10
    end
end
ATT.Func_Override_MuzzleEffect = function(wep, modifiers)
    if wep:Clip1() == wep:GetMaxClip1() then
        modifiers.set = "muzzleflash_smg"
        modifiers.prio = 10
    end
end