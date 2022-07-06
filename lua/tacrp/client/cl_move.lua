hook.Add("CreateMove", "TacRP_CreateMove", function(cmd)
    local wpn = LocalPlayer():GetActiveWeapon()

    if !IsValid(wpn) then return end
    if !wpn.ArcticTacRP then return end

    if GetConVar("TacRP_autoreload"):GetBool() then
        if wpn:Clip1() == 0 and wpn:Ammo1() > 0 and wpn:GetNextPrimaryFire() + 0.5 < CurTime() then
            local buttons = cmd:GetButtons()

            buttons = buttons + IN_RELOAD

            cmd:SetButtons(buttons)
        end
    end
end)