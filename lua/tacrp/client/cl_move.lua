hook.Add("CreateMove", "TacRP_CreateMove", function(cmd)
    local wpn = LocalPlayer():GetActiveWeapon()

    -- In TTT ScreenClicker isn't disabled for some reason
    if TacRP.CursorEnabled and !LocalPlayer():Alive() then
        TacRP.CursorEnabled = false
        gui.EnableScreenClicker(false)
    end

    if !IsValid(wpn) then return end
    if !wpn.ArcticTacRP then return end

    if TacRP.ConVars["autoreload"]:GetBool() then
        if wpn:Clip1() == 0 and (wpn:Ammo1() > 0 or wpn:GetInfiniteAmmo())
                and wpn:GetNextPrimaryFire() + 0.5 < CurTime() and wpn:ShouldAutoReload() then
            local buttons = cmd:GetButtons()

            buttons = buttons + IN_RELOAD

            cmd:SetButtons(buttons)
        end
    end

    if TacRP.KeyPressed_Melee then
        cmd:AddKey(TacRP.IN_MELEE)
    end

    if TacRP.KeyPressed_Customize then
        cmd:AddKey(TacRP.IN_CUSTOMIZE)
    end

    local totalmult, mult, mult2 = TacRP.CalculateMaxMoveSpeed(LocalPlayer())

    local basemove = Vector(cmd:GetForwardMove(), cmd:GetUpMove(), cmd:GetSideMove())
    local maxspeed = basemove:Length()
    local movedir = basemove:GetNormalized()

    local finalmult = math.min(totalmult, mult, mult2)

    local finalmovedir = movedir * maxspeed * finalmult

    cmd:SetForwardMove(finalmovedir[1])
    cmd:SetUpMove(finalmovedir[2])
    cmd:SetSideMove(finalmovedir[3])
end)