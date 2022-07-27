function TacRP.Move(ply, mv, cmd)
    local wpn = ply:GetActiveWeapon()

    if !wpn.ArcticTacRP then return end

    local basespd = (Vector(cmd:GetForwardMove(), cmd:GetUpMove(), cmd:GetSideMove())):Length()
    basespd = math.min(basespd, mv:GetMaxClientSpeed())

    local mult = 1

    if !wpn:GetSafe() then
        mult = mult * wpn:GetValue("MoveSpeedMult")
    end

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


    local shotdelta = 0 -- how close should we be to the shoot speed mult
    local shottime = wpn:GetNextPrimaryFire() - CurTime() + 0.1

    if shottime > 0 then
        -- full slowdown for duration of firing
        shotdelta = 1
    else
        -- recover from firing slowdown after shadow duration
        local delay = math.min(60 / wpn:GetValue("RPM"), 0.5)
        local aftershottime = -shottime / delay
        shotdelta = math.Clamp(1 - aftershottime, 0, 1)
    end
    local shootmove = math.Clamp(wpn:GetValue("ShootingSpeedMult"), 0.0001, 1)
    mult = mult * Lerp(shotdelta, 1, shootmove)

    mv:SetMaxSpeed(basespd * mult)
    mv:SetMaxClientSpeed(basespd * mult)

    -- Semi auto click buffer
    if !wpn:GetCharge() and wpn:GetCurrentFiremode() < 2 and mv:KeyPressed(IN_ATTACK)
            and wpn:StillWaiting() and !wpn:GetReloading() and !wpn:GetCustomize() and wpn:Clip1() >= wpn:GetValue("AmmoPerShot")
            and wpn:GetNextSecondaryFire() < CurTime() and (wpn:GetNextPrimaryFire() - CurTime()) < 0.1 then
        wpn:SetCharge(true)
    elseif wpn:GetCharge() and !wpn:StillWaiting() and !owner and !mv:KeyDown(IN_ATTACK) then
        wpn:SetCharge(false)
        wpn:PrimaryAttack()
    end
end

hook.Add("SetupMove", "ArcticTacRP.SetupMove", TacRP.Move)

TacRP.LastEyeAngles = Angle(0, 0, 0)
TacRP.RecoilRise = Angle(0, 0, 0)

function TacRP.StartCommand(ply, cmd)
    local wpn = ply:GetActiveWeapon()

    if !wpn.ArcticTacRP then
        TacRP.RecoilRise = Angle(0, 0, 0)
        TacRP.LastEyeAngles = ply:EyeAngles()
        return
    end

    local diff = TacRP.LastEyeAngles - cmd:GetViewAngles()
    local recrise = TacRP.RecoilRise

    if recrise.p > 0 then
        recrise.p = math.Clamp(recrise.p, 0, recrise.p - diff.p)
    elseif recrise.p < 0 then
        recrise.p = math.Clamp(recrise.p, recrise.p - diff.p, 0)
    end

    if recrise.y > 0 then
        recrise.y = math.Clamp(recrise.y, 0, recrise.y - diff.y)
    elseif recrise.y < 0 then
        recrise.y = math.Clamp(recrise.y, recrise.y - diff.y, 0)
    end

    recrise:Normalize()
    TacRP.RecoilRise = recrise

    if wpn:GetLastRecoilTime() + wpn:GetValue("RecoilResetTime") > CurTime() then
        local kick = wpn:GetValue("RecoilKick")
        local recoildir = wpn:GetRecoilDirection()
        local rec = math.Clamp(wpn:GetRecoilAmount(), 0, 1)

        local eyeang = cmd:GetViewAngles()

        local uprec = math.sin(math.rad(recoildir)) * FrameTime() * rec * kick
        local siderec = math.cos(math.rad(recoildir)) * FrameTime() * rec * kick

        eyeang.p = eyeang.p + uprec
        eyeang.y = eyeang.y + siderec

        recrise = TacRP.RecoilRise

        recrise = recrise + Angle(uprec, siderec, 0)

        TacRP.RecoilRise = recrise

        cmd:SetViewAngles(eyeang)

        -- local aim_kick_v = rec * math.sin(CurTime() * 15) * FrameTime() * (1 - sightdelta)
        -- local aim_kick_h = rec * math.sin(CurTime() * 12.2) * FrameTime() * (1 - sightdelta)

        -- wpn:SetFreeAimAngle(wpn:GetFreeAimAngle() - Angle(aim_kick_v, aim_kick_h, 0))
    end

    local ping = 0

    if !game.SinglePlayer() then
        ping = ply:Ping()
    end

    -- if wpn:GetCurrentFiremode() != 1 then
    --     delay_extra = 60 / wpn:GetValue("RPM")
    -- end

    if wpn:GetLastRecoilTime() + wpn:GetValue("RecoilResetTime") - (ping * 0.5) < CurTime() and wpn:GetRecoilAmount() == 0 then
        recrise = TacRP.RecoilRise

        local recreset = recrise * FrameTime() * 6

        recrise = recrise - recreset

        recrise:Normalize()

        local eyeang = cmd:GetViewAngles()

        -- eyeang.p = math.AngleDifference(eyeang.p, recreset.p)
        -- eyeang.y = math.AngleDifference(eyeang.y, recreset.y)

        eyeang = eyeang - recreset

        cmd:SetViewAngles(eyeang)

        TacRP.RecoilRise = recrise
    end

    TacRP.LastEyeAngles = cmd:GetViewAngles()

    -- Sprint will not interrupt a runaway burst
    if wpn:GetBurstCount() > 0 and cmd:KeyDown(IN_SPEED) and wpn:GetValue("RunawayBurst") then
        cmd:SetButtons(cmd:GetButtons() - IN_SPEED)
    end
end

hook.Add("StartCommand", "TacRP_StartCommand", TacRP.StartCommand)