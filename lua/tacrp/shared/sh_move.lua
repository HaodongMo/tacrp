function TacRP.CalculateMaxMoveSpeed(ply)
    local wpn = ply:GetActiveWeapon()
    local iscurrent = true

    local totalmult = 1

    if ply:GetNWFloat("TacRPLastBashed", 0) + 3 > CurTime() then
        local slow = TacRP.ConVars["melee_slow"]:GetFloat()
        local mult = slow
        if ply:GetNWFloat("TacRPLastBashed", 0) + 1.5 < CurTime() then
            mult = Lerp((CurTime() - ply:GetNWFloat("TacRPLastBashed", 0) - 1.5) / (3 - 1.5), slow, 1)
        end

        totalmult = totalmult * mult
    end

    local stunstart, stundur = ply:GetNWFloat("TacRPStunStart", 0), ply:GetNWFloat("TacRPStunDur", 0)
    if stunstart + stundur > CurTime() then
        local slow = TacRP.ConVars["flash_slow"]:GetFloat()
        local mult = slow
        if stunstart + stundur * 0.7 < CurTime() then
            mult = Lerp((CurTime() - stunstart - stundur * 0.7) / (stundur * 0.3), slow, 1)
        end

        totalmult = totalmult * mult
    end

    -- Remember last weapon to keep applying slowdown on shooting and melee
    if !wpn.ArcticTacRP then
        if !IsValid(ply.LastTacRPWeapon) or ply.LastTacRPWeapon:GetOwner() != ply then
            return
        else
            wpn = ply.LastTacRPWeapon
            iscurrent = false
        end
    else
        ply.LastTacRPWeapon = wpn
    end

    local mult = 1 * totalmult
    if iscurrent and (!wpn:GetSafe() or wpn:GetIsSprinting() or wpn:ShouldLowerWeapon()) and TacRP.ConVars["penalty_move"]:GetBool() then
        mult = mult * math.Clamp(wpn:GetValue("MoveSpeedMult"), 0.0001, 1)
    end

    -- mult2: sighted or reloading
    local mult2 = 1
    if iscurrent and wpn:GetScopeLevel() > 0 and TacRP.ConVars["penalty_aiming"]:GetBool() then
        mult2 = math.Clamp(wpn:GetValue("SightedSpeedMult"), 0.0001, 1)
    end
    if iscurrent and TacRP.ConVars["penalty_reload"]:GetBool() then
        local rsmt = wpn:GetValue("ReloadSpeedMultTime")

        if wpn:GetReloading() then
            -- mult = mult * math.Clamp(wpn:GetValue("ReloadSpeedMult"), 0.0001, 1)
            mult2 = math.min(mult2, math.Clamp(wpn:GetValue("ReloadSpeedMult"), 0.0001, 1))
        elseif wpn:GetReloadFinishTime() + rsmt > CurTime() then
            local mt = CurTime() - wpn:GetReloadFinishTime()
            local d = mt / rsmt

            d = math.Clamp(d, 0, 1)

            mult2 = math.min(mult2, Lerp(d, math.Clamp(wpn:GetValue("ReloadSpeedMult"), 0.0001, 1), 1))
            -- mult = mult * Lerp(d, math.Clamp(wpn:GetValue("ReloadSpeedMult"), 0.0001, 1), 1)
        end
    end

    -- mult3: shooting and melee
    local mult3 = 1
    if TacRP.ConVars["penalty_firing"]:GetBool() then
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
        local shootmove = math.Clamp(wpn:GetValue("ShootingSpeedMult"), 0.0001, 1)
        mult3 = Lerp(shotdelta, 1, shootmove)
    end

    if TacRP.ConVars["penalty_melee"]:GetBool() then
        local msmt = wpn:GetValue("MeleeSpeedMultTime")

        if wpn:GetLastMeleeTime() + msmt > CurTime() then
            local mt = CurTime() - wpn:GetLastMeleeTime()
            local d = mt / msmt

            d = math.Clamp(d, 0, 1) ^ 4

            mult3 = math.min(mult3,  Lerp(d, math.Clamp(wpn:GetValue("MeleeSpeedMult"), 0.0001, 1), 1))
        end
    end

    return mult * mult2 * mult3, iscurrent
end

function TacRP.Move(ply, mv, cmd)
    local wpn = ply:GetActiveWeapon()

    local basespd = math.min((Vector(cmd:GetForwardMove(), cmd:GetUpMove(), cmd:GetSideMove())):Length(), mv:GetMaxClientSpeed())

    local mult, iscurrent = TacRP.CalculateMaxMoveSpeed(ply)

    if !iscurrent then return end

    mv:SetMaxSpeed(basespd * mult)
    mv:SetMaxClientSpeed(basespd * mult)

    -- Semi auto click buffer
    if !wpn.NoBuffer and !wpn:GetCharge() and (wpn:GetCurrentFiremode() <= 1) and mv:KeyPressed(IN_ATTACK) and !wpn:GetJammed()
            and wpn:StillWaiting() and !wpn:GetReloading() and !wpn:GetCustomize() and wpn:Clip1() >= wpn:GetValue("AmmoPerShot")
            and wpn:GetNextSecondaryFire() < CurTime() and wpn:GetAnimLockTime() < CurTime() and (wpn:GetNextPrimaryFire() - CurTime()) < 0.15 then
        wpn:SetCharge(true)
    elseif !wpn.NoBuffer and wpn:GetCharge() and !wpn:StillWaiting() and !wpn:GetJammed() then
        wpn:PrimaryAttack()
    end
end

hook.Add("SetupMove", "ArcticTacRP.SetupMove", TacRP.Move)

TacRP.LastEyeAngles = Angle(0, 0, 0)
TacRP.RecoilRise = Angle(0, 0, 0)

local function tgt_pos(ent, head) -- From ArcCW & ARC9
    local mins, maxs = ent:WorldSpaceAABB()
    local pos = ent:WorldSpaceCenter()
    pos.z = pos.z + (maxs.z - mins.z) * 0.2 -- Aim at chest level
    if head and ent:GetAttachment(ent:LookupAttachment("eyes")) ~= nil then
        pos = ent:GetAttachment(ent:LookupAttachment("eyes")).Pos
    end
    return pos
end

local tacrp_aimassist = GetConVar("tacrp_aimassist")
local tacrp_aimassist_cone = GetConVar("tacrp_aimassist_cone")
local tacrp_aimassist_head = GetConVar("tacrp_aimassist_head")
local tacrp_aimassist_intensity = GetConVar("tacrp_aimassist_intensity")

function TacRP.StartCommand(ply, cmd)
    local wpn = ply:GetActiveWeapon()
    local mt_notair = ply:GetMoveType() == MOVETYPE_NOCLIP or ply:GetMoveType() == MOVETYPE_LADDER

    if !mt_notair then
        if ply:IsOnGround() and !ply.TacRP_LastOnGround then
            ply.TacRP_LastAirDuration = CurTime() - (ply.TacRP_LastLeaveGroundTime or 0)
            ply.TacRP_LastOnGroundTime = CurTime()
        elseif !ply:IsOnGround() and ply.TacRP_LastOnGround then
            ply.TacRP_LastLeaveGroundTime = CurTime()
        end
    end
    ply.TacRP_LastOnGround = ply:IsOnGround() or mt_notair

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

    if wpn:GetLastRecoilTime() + wpn:RecoilDuration() > CurTime() then
        local kick = wpn:GetValue("RecoilKick")
        local recoildir = wpn:GetRecoilDirection()
        local rec = 1
        local cfm = wpn:GetCurrentFiremode()

        if wpn:UseAltRecoil() then
            rec = 1 + math.Clamp((wpn:GetRecoilAmount() - 1) / (wpn:GetValue("RecoilMaximum") - 1), 0, 1)
            kick = kick + wpn:GetValue("RecoilSpreadPenalty") * wpn:GetValue("RecoilAltMultiplier")
            -- local recgain = rec * wpn:GetValue("RecoilSpreadPenalty") * 250
            -- kick = kick + recgain
        end

        if wpn:GetInBipod() then
            kick = kick * math.min(1, wpn:GetValue("BipodKick"))
        end

        if ply:Crouching() then
            kick = kick * math.min(1, wpn:GetValue("RecoilMultCrouch"))
        end

        if cfm < 0 then
            kick = kick * wpn:GetValue("RecoilMultBurst")
        elseif cfm == 1 then
            kick = kick * wpn:GetValue("RecoilMultSemi")
        end

        kick = kick * TacRP.ConVars["mult_recoil_kick"]:GetFloat()

        local eyeang = cmd:GetViewAngles()
        local suppressfactor = 1
        if wpn:UseRecoilPatterns() and cfm != 1 then
            local stab = math.Clamp(wpn:GetValue("RecoilStability"), 0, 0.9)
            local max = wpn:GetBaseValue("RPM") / 60 * (0.75 + stab * 0.833)
            suppressfactor = math.min(3, 1 + (wpn:GetPatternCount() / max))
        end


        local uprec = math.sin(math.rad(recoildir)) * FrameTime() * rec * kick / suppressfactor
        local siderec = math.cos(math.rad(recoildir)) * FrameTime() * rec * kick

        eyeang.p = eyeang.p + uprec
        eyeang.y = eyeang.y + siderec

        recrise = TacRP.RecoilRise

        if TacRP.ConVars["freeaim"]:GetBool() and wpn:GetValue("FreeAim") and wpn:GetScopeLevel() == 0 then
            local freeaimang = wpn:GetFreeAimAngle()
            siderec = siderec * 0.5
            freeaimang:Add(Angle(0, siderec, 0))
            wpn:SetFreeAimAngle(freeaimang)
        end

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
    if TacRP.ConVars["recoilreset"]:GetBool()
            and wpn:GetLastRecoilTime() + wpn:RecoilDuration() - (ping * 0.5) < CurTime()
            and wpn:GetRecoilAmount() == 0 then

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

    if wpn:GetInBipod() then
        local bipang = wpn:GetBipodAngle()
        local eyeang = cmd:GetViewAngles()

        local dy, dp = math.AngleDifference(bipang.y, eyeang.y), math.AngleDifference(bipang.p, eyeang.p)

        if dy < -60 then
            eyeang.y = bipang.y + 60
        elseif dy > 60 then
            eyeang.y = bipang.y - 60
        end

        if dp > 20 then
            eyeang.p = bipang.p - 20
        elseif dp < -20 then
            eyeang.p = bipang.p + 20
        end

        cmd:SetViewAngles(eyeang)

        if game.SinglePlayer() then
            ply:SetEyeAngles(eyeang)
        end
    end

    TacRP.LastEyeAngles = cmd:GetViewAngles()

    if cmd:KeyDown(IN_SPEED) and (
        -- Sprint cannot interrupt a runaway burst
        (!wpn:CanShootInSprint() and wpn:GetBurstCount() > 0 and wpn:GetValue("RunawayBurst"))

        -- Stunned by a flashbang and cannot sprint
        or (ply:GetNWFloat("TacRPStunStart", 0) + ply:GetNWFloat("TacRPStunDur", 0) > CurTime())

        -- Cannot reload and sprint (now sprint takes priority)
        -- or (!wpn:CanReloadInSprint() and wpn:GetReloading())\

        -- Trying to aim disables sprinting if option is set
        or (wpn:GetValue("Scope") and !wpn:DoOldSchoolScopeBehavior() and (ply:KeyDown(IN_ATTACK2) or wpn:GetScopeLevel() > 0) and ply:GetInfoNum("tacrp_aim_cancels_sprint", 0) > 0 and wpn:CanStopSprinting())
    ) then
        cmd:SetButtons(cmd:GetButtons() - IN_SPEED)
        cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_RUN)) -- Abuse unused IN_ enum
        ply.TacRP_SprintBlock = true -- for some reason KeyDown(IN_SPEED) doesn't seem to see the modified buttons, so we set this
    else
        ply.TacRP_SprintBlock = false
    end

    -- Used for sprint checking
    ply.TacRP_Moving = cmd:GetForwardMove() != 0 or cmd:GetSideMove() != 0

    -- Aim assist imported from ARC9
    if CLIENT and IsValid(wpn) then
		local cone = tacrp_aimassist_cone:GetFloat()
		local dist = math.min(wpn.Range_Max * 0.95, 4000) -- 4000hu is somewhat about 100m
		local inte = tacrp_aimassist_intensity:GetFloat()
		local head = tacrp_aimassist_head:GetBool()

		local fav = GetConVar("tacrp_freeaim")
		local far = wpn:GetValue("FreeAimMaxAngle")
		local swayc = GetConVar("tacrp_sway"):GetBool()
		local freeac = GetConVar("tacrp_freeaim"):GetBool()

		-- Check if current target is beyond tracking cone
		local tgt = ply.tacrp_AATarget
		if IsValid(tgt) and (tgt_pos(tgt, head) - ply:EyePos()):Cross(ply:EyeAngles():Forward()):Length() > cone * 2 then ply.tacrp_AATarget = nil end -- lost track

		-- Try to seek target if not exists
		tgt = ply.tacrp_AATarget
		if !IsValid(tgt) or (tgt.Health and tgt:Health() <= 0) or util.QuickTrace(ply:EyePos(), tgt_pos(tgt, head) - ply:EyePos(), ply).Entity ~= tgt then
			local min_diff
			ply.tacrp_AATarget = nil
			-- for _, ent in ipairs(ents.FindInCone(ply:EyePos(), ply:EyeAngles():Forward(), 244, math.cos(math.rad(cone)))) do
			for _, ent in ipairs(ents.FindInCone(ply:EyePos(), ply:EyeAngles():Forward(), dist, math.cos(math.rad(cone + (fav:GetBool() and far or 0))))) do
				if ent == ply or (!ent:IsNPC() and !ent:IsNextBot() and !ent:IsPlayer()) or ent:Health() <= 0
						or (ent:IsPlayer() and ent:Team() ~= TEAM_UNASSIGNED and ent:Team() == ply:Team()) then continue end
				local tr = util.TraceLine({
					start = ply:EyePos(),
					endpos = tgt_pos(ent, head),
					mask = MASK_SHOT,
					filter = ply
				})
				if tr.Entity ~= ent then continue end
				local diff = (tgt_pos(ent, head) - ply:EyePos()):Cross(ply:EyeAngles():Forward()):Length()
				if !ply.tacrp_AATarget or diff < min_diff then
					ply.tacrp_AATarget = ent
					min_diff = diff
				end
			end
		end

		-- Aim towards target
		tgt = ply.tacrp_AATarget
		if tacrp_aimassist:GetBool() and ply:GetInfoNum("tacrp_aimassist_cl", 0) == 1 then
			if IsValid(tgt) and !wpn:GetCustomize() then
				if !wpn.NoAimAssist then
					local ang = cmd:GetViewAngles()
					local pos = tgt_pos(tgt, head)
					local tgt_ang = (pos - ply:EyePos()):Angle() - ((swayc and wpn:GetSwayAngles()) or angle_zero) - ((freeac and wpn:GetFreeAimAngle()) or angle_zero)
					local ang_diff = (pos - ply:EyePos()):Cross(ply:EyeAngles():Forward()):Length()
					if ang_diff > 0.1 then
						ang = LerpAngle(math.Clamp(inte / ang_diff, 0, 0.01), ang, tgt_ang)
						cmd:SetViewAngles(ang)
					end
				end
			end
		end
    end
	
end

hook.Add("StartCommand", "TacRP_StartCommand", TacRP.StartCommand)