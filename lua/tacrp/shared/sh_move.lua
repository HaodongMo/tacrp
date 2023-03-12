function TacRP.Move(ply, mv, cmd)
    local wpn = ply:GetActiveWeapon()
    local iscurrent = true

    if ply:GetNWFloat("TacRPLastBashed", 0) + 2 > CurTime() then
        local slow = GetConVar("tacrp_melee_slow"):GetFloat()
        local mult = slow
        if ply:GetNWFloat("TacRPLastBashed", 0) + 1.4 < CurTime() then
            mult = Lerp((CurTime() - ply:GetNWFloat("TacRPLastBashed", 0) - 1.4) / (2 - 1.4), slow, 1)
        end

        local basespd = math.min((Vector(cmd:GetForwardMove(), cmd:GetUpMove(), cmd:GetSideMove())):Length(), mv:GetMaxClientSpeed())
        mv:SetMaxSpeed(basespd * mult)
        mv:SetMaxClientSpeed(basespd * mult)
    end

    local stunstart, stundur = ply:GetNWFloat("TacRPStunStart", 0), ply:GetNWFloat("TacRPStunDur", 0)
    if stunstart + stundur > CurTime() then
        local slow = GetConVar("tacrp_flash_slow"):GetFloat()
        local mult = slow
        if stunstart + stundur * 0.7 < CurTime() then
            mult = Lerp((CurTime() - stunstart - stundur * 0.7) / (stundur * 0.3), slow, 1)
        end

        local basespd = math.min((Vector(cmd:GetForwardMove(), cmd:GetUpMove(), cmd:GetSideMove())):Length(), mv:GetMaxClientSpeed())
        mv:SetMaxSpeed(basespd * mult)
        mv:SetMaxClientSpeed(basespd * mult)
    end

    -- Remember last weapon to keep applying slowdown on shooting and melee
    if !wpn.ArcticTacRP then
        if !IsValid(ply.LastTacRPWeapon) or ply.LastTacRPWeapon:GetOwner() ~= ply then
            return
        else
            wpn = ply.LastTacRPWeapon
            iscurrent = false
        end
    else
        ply.LastTacRPWeapon = wpn
    end

    local basespd = (Vector(cmd:GetForwardMove(), cmd:GetUpMove(), cmd:GetSideMove())):Length()
    basespd = math.min(basespd, mv:GetMaxClientSpeed())

    local mult = 1

    if iscurrent and !wpn:GetSafe() then
        mult = mult * math.Clamp(wpn:GetValue("MoveSpeedMult"), 0.0001, 1)
    end

    if iscurrent and wpn:GetScopeLevel() > 0 then
        mult = mult * math.Clamp(wpn:GetValue("SightedSpeedMult"), 0.0001, 1)
    end

    if iscurrent then
        local rsmt = wpn:GetValue("ReloadSpeedMultTime")

        if wpn:GetReloading() then
            mult = mult * math.Clamp(wpn:GetValue("ReloadSpeedMult"), 0.0001, 1)
        elseif wpn:GetReloadFinishTime() + rsmt > CurTime() then
            local mt = CurTime() - wpn:GetReloadFinishTime()
            local d = mt / rsmt

            d = math.Clamp(d, 0, 1)

            mult = mult * Lerp(d, math.Clamp(wpn:GetValue("ReloadSpeedMult"), 0.0001, 1), 1)
        end
    end

    local msmt = wpn:GetValue("MeleeSpeedMultTime")

    if wpn:GetLastMeleeTime() + msmt > CurTime() then
        local mt = CurTime() - wpn:GetLastMeleeTime()
        local d = mt / msmt

        d = math.Clamp(d, 0, 1)

        mult = mult * Lerp(d, math.Clamp(wpn:GetValue("MeleeSpeedMult"), 0.0001, 1), 1)
    end


    local shotdelta = 0 -- how close should we be to the shoot speed mult
    local rpmd = wpn:GetValue("RPM") / 900
    local fulldur = Lerp(rpmd, 1, 0.25) -- time considered "during shot". cant be just primary fire since it hurts slow guns too much
    local delay = Lerp(rpmd, 0.25, 0.5)
    local shottime = wpn:GetNextPrimaryFire() - (60 / wpn:GetValue("RPM")) - CurTime() + fulldur

    -- slowdown based on recoil intensity (firing longer means heavier slowdown)
    if shottime > -delay then
        local aftershottime = math.Clamp(1 + shottime / delay, 0, 1)
        shotdelta = Lerp((wpn:GetRecoilAmount() / (wpn:GetValue("RecoilMaximum") * 0.75)) ^ 1.5, 0.25, 1) * aftershottime
    end

    -- if shottime > 0 then
    --     -- at least 0.25s of full slowdown regardless of RPM
    --     shotdelta = 1
    -- else
    --     -- recover from firing slowdown after shadow duration
    --     local delay = math.min(60 / wpn:GetValue("RPM"), 0.5)
    --     local aftershottime = -shottime / delay
    --     shotdelta = math.Clamp(1 - aftershottime, 0, 1)
    -- end

    -- if SERVER and shotdelta > 0 then print(math.Round(shottime, 2), math.Round(shotdelta, 2)) end

    local shootmove = math.Clamp(wpn:GetValue("ShootingSpeedMult"), 0.0001, 1)
    mult = mult * Lerp(shotdelta, 1, shootmove)

    mv:SetMaxSpeed(basespd * mult)
    mv:SetMaxClientSpeed(basespd * mult)

    if !iscurrent then return end

    -- Semi auto click buffer
    if !wpn.NoBuffer and !wpn:GetCharge() and (wpn:GetCurrentFiremode() == 1 or (wpn:GetCurrentFiremode() < 0 and -wpn:GetCurrentFiremode() == wpn:GetBurstCount())) and mv:KeyPressed(IN_ATTACK)
            and wpn:StillWaiting() and !wpn:GetReloading() and !wpn:GetCustomize() and wpn:Clip1() >= wpn:GetValue("AmmoPerShot")
            and wpn:GetNextSecondaryFire() < CurTime() and (wpn:GetNextPrimaryFire() - CurTime()) < 0.15 then
        wpn:SetCharge(true)
    elseif !wpn.NoBuffer and wpn:GetCharge() and !wpn:StillWaiting() and !owner and !mv:KeyDown(IN_ATTACK) then
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



    if cmd:KeyDown(IN_SPEED) and (
        -- Sprint will not interrupt a runaway burst
        (wpn:GetBurstCount() > 0 and wpn:GetValue("RunawayBurst"))
        -- Cannot sprint while reloading if convar is set
        or (!GetConVar("tacrp_arcade"):GetBool() and wpn:GetReloading())
        -- Stunned by a flashbang and cannot sprint
        or (ply:GetNWFloat("TacRPStunStart", 0) + ply:GetNWFloat("TacRPStunDur", 0) > CurTime())
    ) then
        cmd:SetButtons(cmd:GetButtons() - IN_SPEED)
    end

end

hook.Add("StartCommand", "TacRP_StartCommand", TacRP.StartCommand)