function TacRP.Move(ply, mv, cmd)
    local wpn = ply:GetActiveWeapon()

    if !wpn.ArcticTacRP then return end

    local basespd = (Vector(cmd:GetForwardMove(), cmd:GetUpMove(), cmd:GetSideMove())):Length()
    basespd = math.min(basespd, mv:GetMaxClientSpeed())

    local mult = 1

    mult = mult * wpn:GetValue("MoveSpeedMult")

    if wpn:GetScopeLevel() > 0 then
        mult = mult * wpn:GetValue("SightedSpeedMult")
    end

    local msmt = wpn:GetValue("MeleeSpeedMultTime")

    if wpn:GetLastMeleeTime() + msmt > CurTime() then
        local mt = CurTime() - wpn:GetLastMeleeTime()
        local d = mt / msmt

        d = math.Clamp(d, 0, 1)

        mult = mult * Lerp(d, wpn:GetValue("MeleeSpeedMult"), 1)
    end

    if wpn:GetNextPrimaryFire() + 0.1 > CurTime() then
        local pft = CurTime() - wpn:GetNextPrimaryFire() - (60 / wpn:GetValue("RPM"))
        local d = pft / 0.1

        d = math.Clamp(d, 0, 1)

        mult = mult * Lerp(d, wpn:GetValue("ShootingSpeedMult"), 1)
    end

    mv:SetMaxSpeed(basespd * mult)
    mv:SetMaxClientSpeed(basespd * mult)
end

hook.Add("SetupMove", "ArcticTacRP.SetupMove", TacRP.Move)