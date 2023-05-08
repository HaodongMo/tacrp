hook.Add("PlayerBindPress", "TacRP_Binds", function(ply, bind, pressed, code)
    local wpn = ply:GetActiveWeapon()

    if !wpn or !IsValid(wpn) or !wpn.ArcticTacRP then return end

    if bind == "+zoom" and !LocalPlayer():KeyDown(IN_USE) then
        wpn.BlindFireMenuHolding = pressed
        print(wpn.BlindFireMenuHolding)
        -- if we don't block, TTT will do radio menu
        if engine.ActiveGamemode() == "terrortown" then return true end
    end

    if !pressed then return end

    if bind == "+menu_context" and !LocalPlayer():KeyDown(IN_USE) then
        if wpn:GetScopeLevel() == 0 then
            net.Start("TacRP_togglecustomize")
            net.WriteBool(!wpn:GetCustomize())
            net.SendToServer()
        elseif !GetConVar("tacrp_togglepeek"):GetBool() then
            net.Start("tacrp_togglepeek")
            net.WriteBool(true) -- release is handled in sh_scope
            net.SendToServer()
        else
            net.Start("tacrp_togglepeek")
            net.WriteBool(!wpn:GetPeeking())
            net.SendToServer()
        end

        return true
    end

    if GetConVar("tacrp_toggletactical"):GetBool() and bind == "impulse 100" and wpn:GetValue("CanToggle") then
        net.Start("tacrp_toggletactical")
        net.SendToServer()
        wpn:SetTactical(!wpn:GetTactical())

        surface.PlaySound("tacrp/firemode.wav")

        if ply:FlashlightIsOn() then return false end -- if hl2 flahslight is on we will turn it off as expected
        return true -- we dont want hl2 flashlight
     end
end)

TacRP.Complaints = {}

function TacRP.GetBind(binding)
    local bind = input.LookupBinding(binding)

    if !bind then
        if !TacRP.Complaints[binding] then
            TacRP.Complaints[binding] = true

            if binding == "grenade1" or binding == "grenade2" then
                LocalPlayer():PrintMessage(HUD_PRINTTALK, "Bind +grenade1 and +grenade2 to use TacRP quick grenades!")
            end
        end
        return "!"
    end

    return string.upper(bind)
end