TacRP.ShouldRelockTime = 0

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

    local grenade1bind = input.LookupBinding("+grenade1")

    if !grenade1bind then
        if input.IsKeyDown( KEY_G ) and !LocalPlayer():IsTyping() then
            cmd:AddKey(IN_GRENADE1)
        end
    end

    local grenade2bind = input.LookupBinding("+grenade2")

    if !grenade2bind then
        if input.IsKeyDown( KEY_H ) and !LocalPlayer():IsTyping() then
            cmd:AddKey(IN_GRENADE2)
        end
    end

    if TacRP.KeyPressed_Melee then
        cmd:AddKey(TacRP.IN_MELEE)
    end

    if TacRP.KeyPressed_Customize then
        cmd:AddKey(TacRP.IN_CUSTOMIZE)
    end

    if TacRP.KeyPressed_Tactical then
        cmd:AddKey(TacRP.IN_TACTICAL)
    end

    local lockontarget = wpn.LockOnEntity

    if lockontarget != wpn.LastLockOnEntity then
        TacRP.ShouldRelockTime = CurTime() + 0.1
    end

    if TacRP.ShouldRelockTime > CurTime() then
        cmd:AddKey(TacRP.IN_RELOCK)
    end

    local mult = TacRP.CalculateMaxMoveSpeed(LocalPlayer())

    local basemove = Vector(cmd:GetForwardMove(), cmd:GetUpMove(), cmd:GetSideMove())
    local maxspeed = basemove:Length()
    local movedir = basemove:GetNormalized()

    local finalmovedir = movedir * maxspeed * mult

    cmd:SetForwardMove(finalmovedir[1])
    cmd:SetUpMove(finalmovedir[2])
    cmd:SetSideMove(finalmovedir[3])
end)