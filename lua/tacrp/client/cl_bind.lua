hook.Add("PlayerBindPress", "TacRP_Binds", function(ply, bind, pressed, code)
    local wpn = ply:GetActiveWeapon()

    if !wpn or !IsValid(wpn) or !wpn.ArcticTacRP then return end

    -- if we don't block, TTT will do radio menu
    if engine.ActiveGamemode() == "terrortown" and bind == "+zoom" and !LocalPlayer():KeyDown(IN_USE) then
        ply.TacRPBlindFireDown = pressed
        return true
    end

    if bind == "+showscores" then
        wpn.LastHintLife = CurTime() -- ping the hints
    end

    if bind == "+menu_context" and !LocalPlayer():KeyDown(IN_USE) then
        TacRP.KeyPressed_Customize = pressed

        return true
    end

    if TacRP.ConVars["toggletactical"]:GetBool() and bind == "impulse 100" and wpn:GetValue("CanToggle") and (!GetConVar("mp_flashlight"):GetBool() or (TacRP.ConVars["flashlight_alt"]:GetBool() and ply:KeyDown(IN_WALK)) or (!TacRP.ConVars["flashlight_alt"]:GetBool() and !ply:KeyDown(IN_WALK))) then
        TacRP.KeyPressed_Tactical = pressed

        return true
    end
end)

function TacRP.GetBind(binding)
    local bind = input.LookupBinding(binding)

    if !bind then
        if binding == "+grenade1" then
            return string.upper(input.GetKeyName(TacRP.GRENADE1_Backup))
        elseif binding == "+grenade2" then
            return string.upper(input.GetKeyName(TacRP.GRENADE2_Backup))
        end

        return "!"
    end

    return string.upper(bind)
end

function TacRP.GetBindKey(bind)
    local key = input.LookupBinding(bind)
    if !key then
        if bind == "+grenade1" then
            return string.upper(input.GetKeyName(TacRP.GRENADE1_Backup))
        elseif bind == "+grenade2" then
            return string.upper(input.GetKeyName(TacRP.GRENADE2_Backup))
        end

        return bind
    else
        return string.upper(key)
    end
end

function TacRP.GetKeyIsBound(bind)
    local key = input.LookupBinding(bind)

    if !key then
        if bind == "+grenade1" then
            return true
        elseif bind == "+grenade2" then
            return true
        end

        return false
    else
        return true
    end
end

function TacRP.GetKey(bind)
    local key = input.LookupBinding(bind)

    if !key then
        if bind == "+grenade1" then
            return TacRP.GRENADE1_Backup
        elseif bind == "+grenade2" then
            return TacRP.GRENADE2_Backup
        end

        return false
    else
        return input.GetKeyCode(key)
    end
end

TacRP.KeyPressed_Melee = false

concommand.Add("+tacrp_melee", function()
    TacRP.KeyPressed_Melee = true
end)

concommand.Add("-tacrp_melee", function()
    TacRP.KeyPressed_Melee = false
end)

TacRP.KeyPressed_Customize = false

concommand.Add("+tacrp_customize", function()
    TacRP.KeyPressed_Customize = true
end)

concommand.Add("-tacrp_customize", function()
    TacRP.KeyPressed_Customize = false
end)

TacRP.KeyPressed_Tactical = false

concommand.Add("+tacrp_tactical", function()
    TacRP.KeyPressed_Tactical = true
end)

concommand.Add("-tacrp_tactical", function()
    TacRP.KeyPressed_Tactical = false
end)