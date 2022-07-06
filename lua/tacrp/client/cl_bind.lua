hook.Add("PlayerBindPress", "TacRP_Binds", function(ply, bind, pressed, code)
    local wpn = ply:GetActiveWeapon()

    if !wpn or !IsValid(wpn) or !wpn.ArcticTacRP then return end

    if !pressed then return end

    -- print(bind)

    if bind == "+zoom" then
        if wpn:GetBlindFire() then
            net.Start("TacRP_toggleblindfire")
            net.WriteBool(false)
            net.SendToServer()
        else
            net.Start("TacRP_toggleblindfire")
            net.WriteBool(true)
            net.SendToServer()
        end

        return true
    end

    if bind == "+menu_context" then
        if !LocalPlayer():KeyDown(IN_USE) then
            if wpn:GetCustomize() then
                net.Start("TacRP_togglecustomize")
                net.WriteBool(false)
                net.SendToServer()
            else
                net.Start("TacRP_togglecustomize")
                net.WriteBool(true)
                net.SendToServer()
            end

            return true
        end
    end
end)