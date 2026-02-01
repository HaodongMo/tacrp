function SWEP:StillWaiting(cust, reload, dualPrimary)
    if self:GetNextPrimaryFire() > CurTime() then return true end
    // For DualAkimbo primary attack, don't block on secondary fire timing
    if !dualPrimary and self:GetNextSecondaryFire() > CurTime() and (!reload or !(reload and self:GetReloading())) then return true end
    // For DualAkimbo, don't block on AnimLockTime (animations don't prevent shooting)
    if !dualPrimary and self:GetAnimLockTime() > CurTime() and (!reload or !(reload and self:GetReloading())) then return true end
    if !cust and self:GetBlindFireFinishTime() > CurTime() then return true end
    if !cust and self:GetCustomize() then return true end
    if self:GetPrimedGrenade() then return true end

    return false
end

function SWEP:SprintLock(shoot)
    if self:GetSprintLockTime() > CurTime() or self:GetIsSprinting() or self:ShouldLowerWeapon() then
        return true
    end

    if shoot and self:DoForceSightsBehavior() and (self:GetSprintDelta() > 0 or self:GetSightDelta() < 0.75) and !self:GetBlindFire() then
        return true
    end

    if self:GetValue("CannotHipFire") and self:GetSightAmount() < 1 and !self:GetBlindFire() then
        return true
    end

    return false
end

local function anglerotate(main, off)
    local forward, up, right = main:Forward(), main:Up(), main:Right()

    main:RotateAroundAxis(right, off.p)
    main:RotateAroundAxis(up, off.y)
    main:RotateAroundAxis(forward, off.r)

    return main
end

function SWEP:PrimaryAttack()
    if self:GetOwner():IsNPC() then
        self:NPC_PrimaryAttack()
        return
    end

    if self:GetValue("Melee") and self:GetOwner():KeyDown(IN_USE) and !(self:GetValue("RunawayBurst") and self:GetBurstCount() > 0) then
        -- self.Primary.Automatic = false
        self:SetSafe(false)
        self:Melee()
        return
    end

    -- if self:GetJammed() then return end
    if self:GetCurrentFiremode() < 0 and self:GetBurstCount() >= -self:GetCurrentFiremode() then return end

    if self:GetReloading() and self:GetValue("ShotgunReload") then
        if TacRP.ConVars["reload_sg_cancel"]:GetBool() and !self:GetValue("ShotgunFullCancel") then
            self:CancelReload(false)
            self:Idle()
        else
            self:CancelReload(true)
        end
    end

    if self:SprintLock(true) then return end
    if DarkRP and self:GetNWBool("TacRP_PoliceBiocode") and !self:GetOwner():isCP() then return end
    if self:GetSafe() and !self:GetReloading() then self:ToggleSafety(false) return end
    // For DualAkimbo, don't block primary on secondary timing or AnimLockTime
    if self:StillWaiting(nil, nil, self:GetValue("DualAkimbo")) then return end

    if self:GetValue("RequireLockOn") and !(IsValid(self:GetLockOnEntity()) and CurTime() > self:GetLockOnStartTime() + self:GetValue("LockOnTime")) then return end

    if self:Clip1() < self:GetValue("AmmoPerShot") or self:GetJammed() then
        local ret = self:RunHook("Hook_PreDryfire")
        if ret != true then
            self.Primary.Automatic = false
            if self:GetValue("DualAkimbo") then
                // Don't play dryfire animation while the other gun is cooling
                local coolingTime = 0.5
                local rightCooling = self.LastSecondaryFireTime and CurTime() - self.LastSecondaryFireTime < coolingTime
                if !rightCooling then
                    local rightEmpty = self:Clip2() < self:GetValue("AmmoPerShot")
                    if rightEmpty then
                        // Both guns empty - use standard dryfire
                        if self:GetBlindFire() then
                            self:PlayAnimation("blind_dryfire")
                        else
                            self:PlayAnimation("dryfire")
                        end
                    elseif self:HasSequence("dryfire_left") then
                        // Only left gun empty, right has ammo - use partial dryfire if available
                        self:PlayAnimation("dryfire_left")
                    end
                    // If no partial dryfire animation, skip animation (just play sound)
                end
            else
                if self:GetBlindFire() then
                    self:PlayAnimation("blind_dryfire")
                else
                    self:PlayAnimation("dryfire")
                end
            end
            self:EmitSound(self:GetValue("Sound_DryFire"), 75, 100, 1, CHAN_ITEM)
            self:SetBurstCount(0)
            self:SetNextPrimaryFire(CurTime() + 0.2)
            self:RunHook("Hook_PostDryfire")
            return
        end
    end

    if util.SharedRandom("tacRP_shootChance", 0, 1) <= self:GetJamChance(false) then
        local ret = self:RunHook("Hook_PreJam")
        if ret != true then
            if self:GetBurstCount() == 0 then
                self.Primary.Automatic = false
            end
            if self:GetBlindFire() then
                self:PlayAnimation("blind_dryfire")
            else
                self:PlayAnimation("dryfire")
            end
            self:EmitSound(self:GetValue("Sound_Jam"), 75, 100, 1, CHAN_ITEM)
            self:SetBurstCount(0)
            self:SetPatternCount(0)
            self:SetNextPrimaryFire(CurTime() + self:GetValue("JamWaitTime"))
            // For DualAkimbo, don't block secondary fire on primary jam
            if !self:GetValue("DualAkimbo") then
                self:SetNextSecondaryFire(CurTime() + self:GetValue("JamWaitTime"))
            end
            if self:GetValue("JamTakesRound") then
                self:TakePrimaryAmmo(self:GetValue("AmmoPerShot"))
            end
            if self:Clip1() > 0 and !self:GetValue("JamSkipFix") then
                self:SetJammed(true)
            end
            self:RunHook("Hook_PostJam")
            return
        end
    end

    self:SetBaseSettings()

    local stop = self:RunHook("Hook_PreShoot")
    if stop then return end

    local seq = "fire"

    local idle = true

    local mult = self:GetValue("ShootTimeMult")

    if self:GetValue("LastShot") and self:Clip1() == self:GetValue("AmmoPerShot") then
        seq = self:TranslateSequence("lastshot")
        idle = false
    end

    if self:GetBlindFire() then
        seq = "blind_" .. seq
    end

    if self:GetValue("Akimbo") and !self:GetBlindFire() then
        if self:GetValue("DualAkimbo") then
            // DualAkimbo: PrimaryAttack always fires left gun
            local aps = self:GetValue("AmmoPerShot")
            local rightEmpty = self:Clip2() == 0
            local coolingTime = 0.5
            local rightJustFired = self.LastSecondaryFireTime and CurTime() - self.LastSecondaryFireTime < coolingTime
            local leftLastShot = self:Clip1() == aps

            // Check if right gun fired recently - use shoot_both if so
            local simultaneousLeeway = 0.05
            local rightFiredRecently = self.LastSecondaryFireTime and CurTime() - self.LastSecondaryFireTime < simultaneousLeeway

            if rightFiredRecently and self:HasSequence("shoot_both") then
                // Both guns firing nearly simultaneously
                // Check for last shot variants
                local rightNowEmpty = self:Clip2() == 0  // Right already fired, check if it's now empty
                if leftLastShot and rightNowEmpty and self:HasSequence("shoot_both_lastshot") then
                    seq = "shoot_both_lastshot"
                    idle = false
                elseif leftLastShot and self:HasSequence("shoot_both_left_lastshot") then
                    seq = "shoot_both_left_lastshot"
                    idle = false
                elseif rightNowEmpty and self:HasSequence("shoot_both_right_lastshot") then
                    seq = "shoot_both_right_lastshot"
                    idle = false
                else
                    seq = "shoot_both"
                end
            elseif leftLastShot and self:GetValue("LastShot") then
                // This shot empties the left gun
                if rightEmpty then
                    // Both guns will be empty - lastshot
                    seq = "shoot_left_lastshot"
                else
                    // Only left gun empty, right still has ammo - second_2_lastshot
                    seq = "shoot_left_second_2_lastshot"
                end
                idle = false
            elseif rightEmpty and self:HasSequence("shoot_left_second_empty") then
                // Right gun empty (slide locked), left gun still has ammo
                seq = "shoot_left_second_empty"
            elseif rightJustFired and !self.RightCoolingShown and self:HasSequence("shoot_left_cooling") then
                // Right gun just fired (slide cycling/cooling down) - only show once per shot
                seq = "shoot_left_cooling"
                self.RightCoolingShown = true
            elseif self:HasSequence("shoot_left-1") then
                seq = "shoot_left-1"
            else
                seq = "shoot_left"
            end
        elseif self:GetNthShot() % 2 == 0 then
            seq = "shoot_left"
        else
            seq = "shoot_right"
        end

        if !self:GetValue("DualAkimbo") and self:GetValue("LastShot") then
            if self:Clip1() == self:GetValue("AmmoPerShot") then
                seq = seq .. "_lastshot"
            elseif self:Clip1() == self:GetValue("AmmoPerShot") * 2 then
                seq = seq .. "_second_2_lastshot"
            end
        end
    end

    local prociron = self:DoProceduralIrons()
    if self:GetScopeLevel() > 0 and (prociron or self:HasSequence(seq .. "_iron")) and !self:GetPeeking() then
        if prociron then
            if self:GetValue("LastShot") and self:Clip1() == self:GetValue("AmmoPerShot") then
                self:PlayAnimation(self:TranslateSequence("dryfire"), mult, false)
            end
            self:SetLastProceduralFireTime(CurTime())
        else
            self:PlayAnimation(seq .. "_iron", mult, false, idle)
        end
    elseif self:HasSequence(seq .. "1") then
        local seq1 = seq .. "1"
        if !self:GetInBipod() and (self:GetScopeLevel() < 1 or self:GetPeeking()) then
            seq1 = seq .. tostring(self:GetBurstCount() + 1)
        end

        if self:HasSequence(seq1) then
            self:PlayAnimation(seq1, mult, false, idle)
        elseif self:GetScopeLevel() < 1 or self:GetPeeking() then
            for i = self:GetBurstCount() + 1, 1, -1 do
                local seq2 = seq .. tostring(i)
                if self:HasSequence(seq2) then
                    self:PlayAnimation(seq2, mult, false, idle)
                    break
                end
            end
        end
    else
        self:PlayAnimation(seq, mult, false, idle)
    end

    self:GetOwner():DoCustomAnimEvent(PLAYERANIMEVENT_ATTACK_PRIMARY, 0)

    local pvar = self:GetValue("ShootPitchVariance")

    local sshoot = self:GetValue("Sound_Shoot")

    if self:GetValue("Silencer") then
        sshoot = self:GetValue("Sound_Shoot_Silenced")
    end

    if istable(sshoot) then
        sshoot = table.Random(sshoot)
    end

    if self:GetValue("Sound_ShootAdd") then
        self:EmitSound(self:GetValue("Sound_ShootAdd"), self:GetValue("Vol_Shoot"), self:GetValue("Pitch_Shoot") + util.SharedRandom("TacRP_sshoot", -pvar, pvar), self:GetValue("Loudness_Shoot"), CHAN_BODY)
    end

    -- if we die from suicide, EmitSound will not play, so do this instead
    if self:GetBlindFireMode() == TacRP.BLINDFIRE_KYS then
        if SERVER then
            sound.Play(sshoot, self:GetMuzzleOrigin(), self:GetValue("Vol_Shoot"), self:GetValue("Pitch_Shoot") + util.SharedRandom("TacRP_sshoot", -pvar, pvar), self:GetValue("Loudness_Shoot"))
        end
    else
        self:EmitSound(sshoot, self:GetValue("Vol_Shoot"), self:GetValue("Pitch_Shoot") + util.SharedRandom("TacRP_sshoot", -pvar, pvar), self:GetValue("Loudness_Shoot"), CHAN_WEAPON)
    end

    local delay = 60 / self:GetRPM()
    -- local delay = 60 / self:GetRPM()

    local curatt = self:GetNextPrimaryFire()
    local diff = CurTime() - curatt

    if diff > engine.TickInterval() or diff < 0 then
        curatt = CurTime()
    end

    self:SetNthShot(self:GetNthShot() + 1)
    self.LastPrimaryFireTime = CurTime()
    self.LeftCoolingShown = false  // Reset so right gun can show cooling animation for this shot

    local ejectdelay = self:GetValue("EjectDelay")
    // For DualAkimbo, force left side effects (forceRight = false)
    // Note: Can't use "DualAkimbo and false or nil" because "false or nil" evaluates to nil in Lua
    local forceRight = nil
    if self:GetValue("DualAkimbo") then
        forceRight = false
        self:SetLastFiredRight(false)
    end
    if ejectdelay == 0 then
        self:DoEject(nil, forceRight)
    else
        self:SetTimer(ejectdelay, function()
            self:DoEject(nil, forceRight)
        end)
    end

    self:DoEffects(nil, forceRight)

    if self:GetValue("EffectsDoubled") then
        -- self:SetNthShot(self:GetNthShot() + 1)
        self:DoEffects(true, forceRight)
        if ejectdelay == 0 then
            self:DoEject(true, forceRight)
        else
            self:SetTimer(ejectdelay, function()
                self:DoEject(true, forceRight)
            end)
        end
        -- self:SetNthShot(self:GetNthShot() - 1)
    end

    local num = self:GetValue("Num")
    local fixed_spread = self:IsShotgun() and TacRP.ConVars["fixedspread"]:GetBool()
    local pellet_spread = self:IsShotgun() and self:GetValue("ShotgunPelletSpread") > 0 and TacRP.ConVars["pelletspread"]:GetBool()

    local spread = self:GetSpread()

    local dir = self:GetShootDir()

    local tr = self:GetValue("TracerNum")

    local shootent = self:GetValue("ShootEnt")

    if IsFirstTimePredicted() then

        local hitscan = !TacRP.ConVars["physbullet"]:GetBool()

        local dist = 100000

        -- If the bullet is going to hit something very close in front, use hitscan bullets instead
        -- This uses the aim direction without random spread, which may result in hitscan bullets in distances where it shouldn't be.
        if !hitscan and (game.SinglePlayer() or !TacRP.ConVars["client_damage"]:GetBool()) then
            dist = math.max(self:GetValue("MuzzleVelocity"), 15000) * engine.TickInterval()
                    * game.GetTimeScale()
                    * (num == 1 and 2 or 1) * (game.IsDedicated() and 1 or 2)
            local threshold = dir:Forward() * dist
            local inst_tr = util.TraceLine({
                start = self:GetMuzzleOrigin(),
                endpos = self:GetMuzzleOrigin() + threshold,
                mask = MASK_SHOT,
                filter = {self:GetOwner(), self:GetOwner():GetVehicle(), self},
            })
            if inst_tr.Hit and !inst_tr.HitSky then
                hitscan = true
            end
            -- debugoverlay.Line(self:GetMuzzleOrigin(), self:GetMuzzleOrigin() + threshold, 2, hitscan and Color(255, 0, 255) or Color(255, 255, 255))
        end

        -- Firebullets already does this so this is just placebo
        -- self:GetOwner():LagCompensation(true)

        if shootent or !hitscan or fixed_spread then
            local d = math.random() -- self:GetNthShot() / self:GetCapacity()
            for i = 1, num do
                local new_dir = Angle(dir)
                if fixed_spread then
                    local sgp_x, sgp_y = self:GetShotgunPattern(i, d)
                    // new_dir:Add(Angle(sgp_x, sgp_y, 0) * 36 * 1.4142135623730)
                    new_dir = anglerotate(new_dir, Angle(sgp_x, sgp_y, 0) * 36 * 1.4142135623730)
                    if pellet_spread then
                        // new_dir:Add(self:RandomSpread(self:GetValue("ShotgunPelletSpread"), i))
                        new_dir = anglerotate(new_dir, self:RandomSpread(self:GetValue("ShotgunPelletSpread"), i))
                    end
                else
                    // new_dir:Add(self:RandomSpread(spread, i))
                    new_dir = anglerotate(new_dir, self:RandomSpread(spread, i))
                end

                if shootent then
                    self:ShootRocket(new_dir)
                elseif hitscan then
                    self:GetOwner():FireBullets({
                        Damage = self:GetValue("Damage_Max"),
                        Force = 8,
                        Tracer = tr,
                        TracerName = "tacrp_tracer",
                        Num = 1,
                        Dir = new_dir:Forward(),
                        Src = self:GetMuzzleOrigin(),
                        Spread = Vector(),
                        IgnoreEntity = self:GetOwner():GetVehicle(),
                        Distance = dist,
                        HullSize = (self:IsShotgun() and i % 2 == 0) and TacRP.ShotgunHullSize or 0,
                        Callback = function(att, btr, dmg)
                            local range = (btr.HitPos - btr.StartPos):Length()

                            self:AfterShotFunction(btr, dmg, range, self:GetValue("Penetration"), {})
                            -- if SERVER then
                            --     debugoverlay.Cross(btr.HitPos, 4, 5, Color(255, 0, 0), false)
                            -- else
                            --     debugoverlay.Cross(btr.HitPos, 4, 5, Color(255, 255, 255), false)
                            -- end
                        end
                    })
                else
                    TacRP:ShootPhysBullet(self, self:GetMuzzleOrigin(), new_dir:Forward() * self:GetValue("MuzzleVelocity"),
                            {HullSize = (self:IsShotgun() and i % 2 == 0) and TacRP.ShotgunHullSize or 0,})
                end
            end
        else
            local new_dir = Angle(dir)
            local new_spread = spread
            -- if pellet_spread then
            --     new_spread = self:GetValue("ShotgunPelletSpread")
            --     new_dir:Add(self:RandomSpread(spread, 0))
            -- end

            -- Try to use Num in FireBullets if at all possible, as this is more performant and better for damage calc compatibility
            -- Also it generates nice big numbers in various hit number addons instead of a buncha small ones.
            self:GetOwner():FireBullets({
                Damage = self:GetValue("Damage_Max"),
                Force = 8,
                Tracer = tr,
                TracerName = "tacrp_tracer",
                Num = num,
                Dir = new_dir:Forward(),
                Src = self:GetMuzzleOrigin(),
                Spread = Vector(new_spread, new_spread, 0),
                IgnoreEntity = self:GetOwner():GetVehicle(),
                Distance = dist,
                Callback = function(att, btr, dmg)
                    local range = (btr.HitPos - btr.StartPos):Length()

                    if IsValid(btr.Entity) and (!game.SinglePlayer() and TacRP.ConVars["client_damage"]:GetBool()) then
                        if CLIENT then
                            net.Start("tacrp_clientdamage")
                                net.WriteEntity(self)
                                net.WriteEntity(btr.Entity)
                                net.WriteVector(btr.Normal)
                                net.WriteVector(btr.Entity:WorldToLocal(btr.HitPos))
                                net.WriteUInt(btr.HitGroup, 8)
                                net.WriteFloat(range)
                                net.WriteFloat(self:GetValue("Penetration"))
                                net.WriteUInt(0, 4)
                            net.SendToServer()
                        else
                            self:AfterShotFunction(btr, dmg, range, self:GetValue("Penetration"), {[btr.Entity] = true})
                        end
                    else
                        self:AfterShotFunction(btr, dmg, range, self:GetValue("Penetration"), {})
                    end

                    if SERVER then
                        debugoverlay.Cross(btr.HitPos, 4, 5, Color(255, 0, 0), false)
                    else
                        debugoverlay.Cross(btr.HitPos, 4, 5, Color(255, 255, 255), false)

                    end
                end
            })
        end

        -- self:GetOwner():LagCompensation(false)
    end

    self:ApplyRecoil()

    self:SetNextPrimaryFire(curatt + delay)
    self:TakePrimaryAmmo(self:GetValue("AmmoPerShot"))

    self:SetBurstCount(self:GetBurstCount() + 1)
    self:SetPatternCount(self:GetPatternCount() + 1)
    self:DoBulletBodygroups()

    if self:Clip1() == 0 then self.Primary.Automatic = false end

    -- FireBullets won't hit ourselves. Apply damage directly!
    if SERVER and self:GetBlindFireMode() == TacRP.BLINDFIRE_KYS and !self:GetValue("ShootEnt") then
        timer.Simple(0, function()
            if !IsValid(self) or !IsValid(self:GetOwner()) then return end
            local damage = DamageInfo()
            damage:SetAttacker(self:GetOwner())
            damage:SetInflictor(self)
            damage:SetDamage(self:GetValue("Damage_Max") * self:GetValue("Num") * self:GetConfigDamageMultiplier())
            damage:SetDamageType(self:GetValue("DamageType") or self:IsShotgun() and DMG_BUCKSHOT or DMG_BULLET)
            damage:SetDamagePosition(self:GetMuzzleOrigin())
            damage:SetDamageForce(dir:Forward() * self:GetValue("Num"))

            damage:ScaleDamage(self:GetBodyDamageMultipliers()[HITGROUP_HEAD])
            -- self:GetOwner():SetLastHitGroup(HITGROUP_HEAD)

            self:GetOwner():TakeDamageInfo(damage)
        end)
    end

    if CLIENT and self:GetOwner() == LocalPlayer() then
        self:DoMuzzleLight()
    elseif game.SinglePlayer() then
        self:CallOnClient("DoMuzzleLight")
    end

    self:SetCharge(false)

    -- Troll
    if self:GetBurstCount() >= 8 and TacRP.ShouldWeFunny(true) and (self.NextTroll or 0) < CurTime() and math.random() <= 0.02 then
        timer.Simple(math.Rand(0, 0.25), function()
            if IsValid(self) then
                self:EmitSound("tacrp/discord-notification.wav", nil, 100, math.Rand(0.1, 0.5), CHAN_BODY)
            end
        end)
        self.NextTroll = CurTime() + 180
    end

    self:RunHook("Hook_PostShoot")
end

local rings = {1, 9, 24, 45}
local function ringnum(i)
    return rings[i] or (rings[#rings] + i ^ 2)
end

local function getring(x)
    local i = 1
    while x > ringnum(i) do i = i + 1 end
    return i
end

function SWEP:GetShotgunPattern(i, d)
    local ring_spread = self:GetSpread()
    local num = self:GetValue("Num")
    if num == 1 then return 0, 0 end

    local pelspread = self:GetValue("ShotgunPelletSpread") > 0 and TacRP.ConVars["pelletspread"]:GetBool()
    if pelspread then
        ring_spread = ring_spread - self:GetValue("ShotgunPelletSpread")
    else
        d = 0
    end

    local x = 0
    local y = 0
    local red = num <= 3 and 0 or 1
    local f = (i - red) / (num - red)

    if num == 2 then
        local angle = f * 180 + (pelspread and (d - 0.5) * 60 or 0)

        x = math.sin(math.rad(angle)) * ring_spread
        y = math.cos(math.rad(angle)) * ring_spread
    elseif num == 3 then
        local angle = f * 360 + d * 180 + 30
        x = math.sin(math.rad(angle)) * ring_spread
        y = math.cos(math.rad(angle)) * ring_spread
    elseif i == 1 then
        return x, y
    -- elseif num <= 9 then
    --     local angle = 360 * (f + d - (1 / (num - 2)))
    --     x = math.sin(math.rad(angle)) * ring_spread
    --     y = math.cos(math.rad(angle)) * ring_spread
    else
        local tr = getring(num)
        local ri = getring(i)
        local rin = ringnum(ri)
        local rln = ringnum(ri - 1)

        local l = (ri - 1) / (tr - 1)
        if ri == tr then
            f = (i - rln) / ((math.min(rin, num)) - rln)
        else
            f = (i - rln) / (rin - rln)
        end

        local angle = 360 * (f + l + d)
        x = math.sin(math.rad(angle)) * ring_spread * l
        y = math.cos(math.rad(angle)) * ring_spread * l
    end

    return x, y
end

local doorclasses = {
    ["func_door_rotating"] = true,
    ["prop_door_rotating"] = true,
    ["prop_door_rotating_checkpoint"] = true
}

function SWEP:AfterShotFunction(tr, dmg, range, penleft, alreadypenned, forced)
    if !forced and !IsFirstTimePredicted() and !game.SinglePlayer() then return end

    if self:GetValue("DamageType") then
        dmg:SetDamageType(self:GetValue("DamageType"))
    elseif self:IsShotgun() then
        dmg:SetDamageType(DMG_BUCKSHOT + (engine.ActiveGamemode() == "terrortown" and DMG_BULLET or 0))
    end

    local matpen = self:GetValue("Penetration")

    if tr.Entity and alreadypenned[tr.Entity] then
        dmg:SetDamage(0)
    elseif IsValid(tr.Entity) then
        dmg:SetDamage(self:GetDamageAtRange(range))
        local bodydamage = self:GetBodyDamageMultipliers()

        if bodydamage[tr.HitGroup] then
            dmg:ScaleDamage(bodydamage[tr.HitGroup])
        end

        if tr.Entity:IsNextBot() or tr.Entity:IsNPC() then
            dmg:ScaleDamage(self:GetValue("DamageMultNPC"))
        end

        TacRP.CancelBodyDamage(tr.Entity, dmg, tr.HitGroup)

        if self:GetOwner():IsNPC() and !TacRP.ConVars["npc_equality"]:GetBool() then
            dmg:ScaleDamage(0.25)
        elseif matpen > 0 and TacRP.ConVars["penetration"]:GetBool() and !self:GetOwner():IsNPC() then
            local pendelta = penleft / matpen
            pendelta = Lerp(pendelta, math.Clamp(matpen * 0.02, 0.25, 0.5), 1)
            dmg:ScaleDamage(pendelta)
        end
        alreadypenned[tr.Entity] = true

        if tr.Entity.LVS and !self:IsShotgun() then
            dmg:ScaleDamage(0.5)
            dmg:SetDamageForce(dmg:GetDamageForce():GetNormalized() * matpen * 75)
            dmg:SetDamageType(DMG_AIRBOAT + DMG_SNIPER)
            penleft = 0
        end

        if SERVER and self:GetValue("DamageType") == DMG_BURN and IsValid(tr.Entity) then
            tr.Entity:Ignite(1, 64)
        end
    end

    if self:GetValue("ExplosiveDamage") > 0 and penleft == matpen then
        -- Add DMG_AIRBOAT to hit helicopters
        -- Need a timer here because only one DamageInfo can exist at a time
        timer.Simple(0.0001, function()
            if !IsValid(self) or !IsValid(self:GetOwner()) then return end
            local dmginfo = DamageInfo()
            dmginfo:SetAttacker(self:GetOwner())
            dmginfo:SetInflictor(self)
            dmginfo:SetDamageType(self:GetValue("ExplosiveDamageType") or (DMG_BLAST + DMG_AIRBOAT))
            dmginfo:SetDamage(self:GetValue("ExplosiveDamage"))
            util.BlastDamageInfo(dmginfo, tr.HitPos, self:GetValue("ExplosiveRadius"))
        end)
        -- penleft = 0
        --util.BlastDamage(self, self:GetOwner(), tr.HitPos, self:GetValue("ExplosiveRadius"), self:GetValue("ExplosiveDamage"))
    end

    if self:GetValue("ExplosiveEffect") then
        local fx = EffectData()
        fx:SetOrigin(tr.HitPos)
        fx:SetNormal(tr.HitNormal)

        if bit.band(util.PointContents(tr.HitPos), CONTENTS_WATER) == CONTENTS_WATER then
            util.Effect("WaterSurfaceExplosion", fx, true)
        else
            util.Effect(self:GetValue("ExplosiveEffect"), fx, true)
        end
    end

    if SERVER and IsValid(tr.Entity) and !tr.Entity.TacRP_DoorBusted
            and doorclasses[tr.Entity:GetClass()] and self:GetValue("DoorBreach") then
        if !tr.Entity.TacRP_BreachThreshold or CurTime() - tr.Entity.TacRP_BreachThreshold[1] > 0.1 then
            tr.Entity.TacRP_BreachThreshold = {CurTime(), 0}
        end

        tr.Entity.TacRP_BreachThreshold[2] = tr.Entity.TacRP_BreachThreshold[2] + dmg:GetDamage()
        if tr.Entity.TacRP_BreachThreshold[2] > (self:GetValue("DoorBreachThreshold") or 100) then
            tr.Entity:EmitSound("ambient/materials/door_hit1.wav", 80, math.Rand(95, 105))
            for _, otherDoor in pairs(ents.FindInSphere(tr.Entity:GetPos(), 72)) do
                if tr.Entity != otherDoor and otherDoor:GetClass() == tr.Entity:GetClass() then
                    local v = (otherDoor.TacRP_BreachThreshold and CurTime() - otherDoor.TacRP_BreachThreshold[1] <= 0.1) and 800 or 200
                    TacRP.DoorBust(otherDoor, tr.Normal * v, dmg:GetAttacker())
                    break
                end
            end
            TacRP.DoorBust(tr.Entity, tr.Normal * 800, dmg:GetAttacker())
            tr.Entity.TacRP_BreachThreshold = nil
        end
    end

    self:Penetrate(tr, range, penleft, alreadypenned)
end

function SWEP:GetMinMaxRange(base, static)
    local valfunc = base and self.GetBaseValue or self.GetValue

    local max, min = valfunc(self, "Damage_Max"), valfunc(self, "Damage_Min")
    return valfunc(self, "Range_Min", static, max < min), valfunc(self, "Range_Max", static, max < min)
end

function SWEP:GetDamageAtRange(range, noround)
    local d = 1

    local r_min, r_max = self:GetMinMaxRange()

    if range <= r_min then
        d = 0
    elseif range >= r_max then
        d = 1
    else
        d = (range - r_min) / (r_max - r_min)
    end

    local dmgv = Lerp(d, self:GetValue("Damage_Max"), self:GetValue("Damage_Min")) * self:GetConfigDamageMultiplier()

    if !noround then
        dmgv = math.ceil(dmgv)
    end

    return dmgv
end

function SWEP:GetShootDir(nosway)
    if !IsValid(self:GetOwner()) then return self:GetAngles() end
    local dir = self:GetOwner():EyeAngles()

    local bf = self:GetBlindFireMode()
    if bf == TacRP.BLINDFIRE_KYS then
        dir.y = dir.y + 180
    elseif bf == TacRP.BLINDFIRE_LEFT then
        dir.y = dir.y + 75
    elseif bf == TacRP.BLINDFIRE_RIGHT then
        dir.y = dir.y - 75
    end

    local u, r = dir:Up(), dir:Right()

    local oa = self:GetFreeAimOffset()
    if !nosway then
        oa = oa + self:GetSwayAngles()
    end

    dir:RotateAroundAxis(u, oa.y)
    -- dir:RotateAroundAxis(r, oa.r)
    dir:RotateAroundAxis(r, -oa.p)

    dir = dir + self:GetValue("ShootOffsetAngle")

    return dir
end

function SWEP:ShootRocket(dir)
    if CLIENT then return end

    local src = self:GetMuzzleOrigin()
    dir = dir or self:GetShootDir()

    local ent = self:GetValue("ShootEnt")

    local rocket = ents.Create(ent)
    if !IsValid(rocket) then return end

    rocket:SetPos(src)
    if self:GetBlindFireMode() != TacRP.BLINDFIRE_KYS then
        rocket:SetOwner(self:GetOwner())
    else
        rocket.Attacker = self:GetOwner()
    end
    rocket.Inflictor = self
    rocket:SetAngles(dir)
    if isfunction(rocket.SetWeapon) then
        rocket:SetWeapon(self)
    end
    if self:GetOwner():IsNPC() then
        rocket.LockOnEntity = self:GetOwner():GetTarget()
    else
        if IsValid(self:GetLockOnEntity()) and CurTime() >= self:GetValue("LockOnTime") + self:GetLockOnStartTime() then
            rocket.LockOnEntity = self:GetLockOnEntity()
        end
    end
    self:RunHook("Hook_PreShootEnt", rocket)
    rocket:Spawn()
    self:RunHook("Hook_PostShootEnt", rocket)

    rocket.IsTacRPProjectile = true

    local phys = rocket:GetPhysicsObject()

    if phys:IsValid() and self:GetValue("ShootEntForce") > 0 then
        phys:SetVelocityInstantaneous(dir:Forward() * self:GetValue("ShootEntForce"))
    end
end

function SWEP:GetSpread(baseline)
    local ply = self:GetOwner()
    local spread = self:GetValue("Spread")

    if baseline then return spread end

    local hippenalty = self:GetValue("HipFireSpreadPenalty")
    local movepenalty = self:GetValue("MoveSpreadPenalty")
    if TacRP.ConVars["oldschool"]:GetBool() or TacRP.GetBalanceMode() == TacRP.BALANCE_OLDSCHOOL then
        movepenalty = movepenalty + hippenalty * 0.25
        hippenalty = hippenalty * Lerp(12 / (self:GetValue("ScopeFOV") - 1.1), 0.05, 0.5)
    end

    if self:GetInBipod() and self:GetScopeLevel() == 0 then
        spread = spread + Lerp(1 - self:GetValue("PeekPenaltyFraction"), hippenalty, 0)
    else
        spread = spread + Lerp(self:GetSightAmount() - (self:GetPeeking() and self:GetValue("PeekPenaltyFraction") or 0), hippenalty, 0)
    end

    if !self:UseAltRecoil() then
        spread = spread + (self:GetRecoilAmount() * self:GetValue("RecoilSpreadPenalty"))
    end

    local v = ply:GetAbsVelocity()
    local spd = math.min(math.sqrt(v.x * v.x + v.y * v.y) / 250, 1)

    spread = spread + (spd * movepenalty)

    local groundtime = CurTime() - (ply.TacRP_LastOnGroundTime or 0)
    local gd = math.Clamp(!ply:IsOnGround() and 0 or groundtime / math.Clamp((ply.TacRP_LastAirDuration or 0) - 0.25, 0.1, 1.5), 0, 1) ^ 0.75

    if gd < 1 and ply:GetMoveType() != MOVETYPE_NOCLIP then
        local v = (ply:WaterLevel() > 0 or ply:GetMoveType() == MOVETYPE_LADDER) and 0.5 or 0
        spread = spread + Lerp(gd + v, self:GetValue("MidAirSpreadPenalty"), 0)
    end

    if ply:OnGround() and ply:Crouching() then
        spread = spread + self:GetValue("CrouchSpreadPenalty")
    end

    if self:GetBlindFire() then
        spread = spread + self:GetValue("BlindFireSpreadPenalty")
    end

    local quickscopetime = CurTime() - self:GetLastScopeTime()

    local qsd = (quickscopetime / self:GetValue("QuickScopeTime")) ^ 4

    if qsd < 1 then
        spread = spread + Lerp(qsd, self:GetValue("QuickScopeSpreadPenalty"), 0)
    end

    spread = math.max(spread, 0)

    return spread
end

local type_to_cvar = {
    ["2Magnum Pistol"] = "mult_damage_magnum",
    ["7Sniper Rifle"] = "mult_damage_sniper",
    -- ["5Shotgun"] = "mult_damage_shotgun",

    ["6Launcher"] = "",
    ["7Special Weapon"] = "",
    ["8Melee Weapon"] = "",
    ["9Equipment"] = "",
    ["9Throwable"] = "",
}
function SWEP:GetConfigDamageMultiplier()
    if self:IsShotgun() then
        return TacRP.ConVars["mult_damage_shotgun"]:GetFloat()
    elseif self:GetValue("PrimaryMelee") then
        return TacRP.ConVars["mult_damage_melee"]:GetFloat()
    else
        local cvar = type_to_cvar[self.SubCatType] or "mult_damage"
        return TacRP.ConVars[cvar] and TacRP.ConVars[cvar]:GetFloat() or 1
    end
end

local shotgundmgmult = {
    [HITGROUP_HEAD] = 1,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 1,
    [HITGROUP_RIGHTLEG] = 1,
    [HITGROUP_GEAR] = 1,
}

function SWEP:GetBodyDamageMultipliers(base)
    if self:IsShotgun(base) then -- Shotguns using hull traces will never hit bodygroups
        return table.Copy(shotgundmgmult)
    end

    local valfunc = base and self.GetBaseValue or self.GetValue

    local btbl = table.Copy(valfunc(self, "BodyDamageMultipliers"))

    for k, v in pairs(valfunc(self, "BodyDamageMultipliersExtra") or {}) do
        if v < 0 then
            btbl[k] = math.abs(v)
        else
            btbl[k] = btbl[k] * v
        end
    end

    local mult = TacRP.ConVars["mult_headshot"]:GetFloat()
    if mult <= 0 then
        btbl[HITGROUP_HEAD] = 1
    elseif mult <= 1 then
        btbl[HITGROUP_HEAD] = Lerp(mult, 1, btbl[HITGROUP_HEAD])
    else
        btbl[HITGROUP_HEAD] = btbl[HITGROUP_HEAD] * mult
    end

    return btbl
end

function SWEP:FireAnimationEvent( pos, ang, event, options )
    if event != 5004 then return true end
end

-- DO NOT USE AngleRand() to do bullet spread as it generates a random angle in 3 directions when we only use two (roll is not relevant!)
-- Also, multiplying by 36 is not correct! you need to also multiply by square root of 2. Trig stuff, i forgot why exactly.
-- Arctic I fixed this THREE FUCKING TIMES on your THREE FUCKING WEAPON BASES do not make me come to Australia and beat the shit out of you
function SWEP:RandomSpread(spread, seed)
    seed = (seed or 0) + self:EntIndex() + engine.TickCount()
    local a = util.SharedRandom("tacrp_randomspread", 0, 360, seed)
    local angleRand = Angle(math.sin(a), math.cos(a), 0)
    angleRand:Mul(spread * util.SharedRandom("tacrp_randomspread2", 0, 45, seed) * 1.4142135623730)

    return angleRand
end

function SWEP:IsShotgun(base)
    if base then
        return self:GetBaseValue("Num") > 1 and !self:GetBaseValue("NotShotgun")
    else
        return self:GetValue("Num") > 1 and !self:GetValue("NotShotgun")
    end
end

function SWEP:GetJamChance(base)
	
    local valfunc = base and self.GetBaseValue or self.GetValue
    local factor = valfunc(self, "JamFactor")
    if factor <= 0 or !TacRP.ConVars["can_jam"]:GetBool() then return 0 end

    local default = TacRP.AmmoJamMSB[self:GetAmmoType(base)] or 15
    local msb = (valfunc(self, "JamBaseMSB") or default) / math.sqrt(factor)

    return 1 / msb
end

function SWEP:GetRPM(base, fm)
    fm = fm or self:GetCurrentFiremode()
    local valfunc = base and self.GetBaseValue or self.GetValue
    local rpm = valfunc(self, "RPM")
    if fm == 1 then
        rpm = rpm * valfunc(self, "RPMMultSemi")
    elseif fm < 0 then
        rpm = rpm * valfunc(self, "RPMMultBurst")
    end
    return rpm
end

// Returns effective RPM for stat calculations
// DualAkimbo weapons have double the effective fire rate since both guns fire independently
function SWEP:GetEffectiveRPM(base, fm)
    local rpm = self:GetRPM(base, fm)
    local valfunc = base and self.GetBaseValue or self.GetValue
    if valfunc(self, "DualAkimbo") then
        rpm = rpm * 2
    end
    return rpm
end

// =====================================
// DualAkimbo Secondary Shooting System
// =====================================

function SWEP:GetCapacity2()
    return self:GetValue("ClipSize2")
end

function SWEP:TakeSecondaryAmmo(amt)
    self:SetClip2(math.max(self:Clip2() - amt, 0))
end

// Secondary attack for right gun in DualAkimbo mode
function SWEP:SecondaryShoot()
    if self:GetOwner():IsNPC() then return end

    // Don't let dryfire interrupt reload - check early before shotgun reload cancellation
    if self:GetReloading() and self:Clip2() < self:GetValue("AmmoPerShot") then return end

    if self:GetValue("Melee") and self:GetOwner():KeyDown(IN_USE) and !(self:GetValue("RunawayBurst") and self:GetBurstCount2() > 0) then
        self:SetSafe(false)
        self:Melee()
        return
    end

    if self:GetCurrentFiremode() < 0 and self:GetBurstCount2() >= -self:GetCurrentFiremode() then return end

    if self:GetReloading() and self:GetValue("ShotgunReload") then
        if TacRP.ConVars["reload_sg_cancel"]:GetBool() and !self:GetValue("ShotgunFullCancel") then
            self:CancelReload(false)
            self:Idle()
        else
            self:CancelReload(true)
        end
    end

    if self:SprintLock(true) then return end
    if DarkRP and self:GetNWBool("TacRP_PoliceBiocode") and !self:GetOwner():isCP() then return end
    if self:GetSafe() and !self:GetReloading() then self:ToggleSafety(false) return end

    // Only check secondary fire timing - don't block on primary fire or AnimLockTime
    // This allows both guns to fire independently
    if self:GetNextSecondaryFire() > CurTime() then return end
    if self:GetBlindFireFinishTime() > CurTime() then return end
    if self:GetCustomize() then return end
    if self:GetPrimedGrenade() then return end
    if self:GetReloading() then return end

    if self:GetValue("RequireLockOn") and !(IsValid(self:GetLockOnEntity()) and CurTime() > self:GetLockOnStartTime() + self:GetValue("LockOnTime")) then return end

    // Use Clip2 for right gun ammo
    if self:Clip2() < self:GetValue("AmmoPerShot") or self:GetJammed() then
        local ret = self:RunHook("Hook_PreDryfire")
        if ret != true then
            self.Secondary.Automatic = false
            // Don't play dryfire animation while the other gun is cooling
            local coolingTime = 0.5
            local leftCooling = self.LastPrimaryFireTime and CurTime() - self.LastPrimaryFireTime < coolingTime
            if !leftCooling then
                local leftEmpty = self:Clip1() < self:GetValue("AmmoPerShot")
                if leftEmpty then
                    // Both guns empty - use standard dryfire
                    if self:GetBlindFire() then
                        self:PlayAnimation("blind_dryfire")
                    else
                        self:PlayAnimation("dryfire")
                    end
                elseif self:HasSequence("dryfire_right") then
                    // Only right gun empty, left has ammo - use partial dryfire if available
                    self:PlayAnimation("dryfire_right")
                end
                // If no partial dryfire animation, skip animation (just play sound)
            end
            self:EmitSound(self:GetValue("Sound_DryFire"), 75, 100, 1, CHAN_ITEM)
            self:SetBurstCount2(0)
            // Only block secondary fire, not primary
            self:SetNextSecondaryFire(CurTime() + 0.2)
            self:RunHook("Hook_PostDryfire")
            return
        end
    end

    if util.SharedRandom("tacRP_shootChance2", 0, 1) <= self:GetJamChance(false) then
        local ret = self:RunHook("Hook_PreJam")
        if ret != true then
            if self:GetBurstCount2() == 0 then
                self.Secondary.Automatic = false
            end
            self:EmitSound(self:GetValue("Sound_Jam"), 75, 100, 1, CHAN_ITEM)
            self:SetBurstCount2(0)
            self:SetPatternCount(0)
            // Only block secondary fire for jam, not primary
            self:SetNextSecondaryFire(CurTime() + self:GetValue("JamWaitTime"))
            if self:GetValue("JamTakesRound") then
                self:TakeSecondaryAmmo(self:GetValue("AmmoPerShot"))
            end
            if self:Clip2() > 0 and !self:GetValue("JamSkipFix") then
                self:SetJammed(true)
            end
            self:RunHook("Hook_PostJam")
            return
        end
    end

    self:SetBaseSettings()

    local stop = self:RunHook("Hook_PreShoot")
    if stop then return end

    // Animation selection for right gun
    local seq = "shoot_right"
    local idle = true
    local mult = self:GetValue("ShootTimeMult")

    local aps = self:GetValue("AmmoPerShot")
    local leftEmpty = self:Clip1() == 0
    local coolingTime = 0.5
    local leftJustFired = self.LastPrimaryFireTime and CurTime() - self.LastPrimaryFireTime < coolingTime
    local rightLastShot = self:Clip2() == aps

    // Check if left gun fired recently - use shoot_both if so
    local simultaneousLeeway = 0.05
    local leftFiredRecently = self.LastPrimaryFireTime and CurTime() - self.LastPrimaryFireTime < simultaneousLeeway

    if leftFiredRecently and self:HasSequence("shoot_both") then
        // Both guns firing nearly simultaneously
        // Check for last shot variants
        local leftNowEmpty = self:Clip1() == 0  // Left already fired, check if it's now empty
        if rightLastShot and leftNowEmpty and self:HasSequence("shoot_both_lastshot") then
            seq = "shoot_both_lastshot"
            idle = false
        elseif rightLastShot and self:HasSequence("shoot_both_right_lastshot") then
            seq = "shoot_both_right_lastshot"
            idle = false
        elseif leftNowEmpty and self:HasSequence("shoot_both_left_lastshot") then
            seq = "shoot_both_left_lastshot"
            idle = false
        else
            seq = "shoot_both"
        end
    elseif rightLastShot and self:GetValue("LastShot") then
        // This shot empties the right gun
        if leftEmpty then
            // Both guns will be empty - lastshot
            seq = "shoot_right_lastshot"
        else
            // Only right gun empty, left still has ammo - second_2_lastshot
            seq = "shoot_right_second_2_lastshot"
        end
        idle = false
    elseif leftEmpty and self:HasSequence("shoot_right_second_empty") then
        // Left gun empty (slide locked), right gun still has ammo
        seq = "shoot_right_second_empty"
    elseif leftJustFired and !self.LeftCoolingShown and self:HasSequence("shoot_right_cooling") then
        // Left gun just fired (slide cycling/cooling down) - only show once per shot
        seq = "shoot_right_cooling"
        self.LeftCoolingShown = true
    elseif self:HasSequence("shoot_right-1") then
        seq = "shoot_right-1"
    else
        seq = "shoot_right"
    end

    local prociron = self:DoProceduralIrons()
    if self:GetScopeLevel() > 0 and (prociron or self:HasSequence(seq .. "_iron")) and !self:GetPeeking() then
        if prociron then
            if self:GetValue("LastShot") and self:Clip2() == self:GetValue("AmmoPerShot") then
                self:PlayAnimation(self:TranslateSequence("dryfire"), mult, false)
            end
            self:SetLastProceduralFireTime(CurTime())
        else
            self:PlayAnimation(seq .. "_iron", mult, false, idle)
        end
    elseif self:HasSequence(seq .. "1") then
        local seq1 = seq .. "1"
        if !self:GetInBipod() and (self:GetScopeLevel() < 1 or self:GetPeeking()) then
            seq1 = seq .. tostring(self:GetBurstCount2() + 1)
        end

        if self:HasSequence(seq1) then
            self:PlayAnimation(seq1, mult, false, idle)
        elseif self:GetScopeLevel() < 1 or self:GetPeeking() then
            for i = self:GetBurstCount2() + 1, 1, -1 do
                local seq2 = seq .. tostring(i)
                if self:HasSequence(seq2) then
                    self:PlayAnimation(seq2, mult, false, idle)
                    break
                end
            end
        end
    else
        self:PlayAnimation(seq, mult, false, idle)
    end

    self:GetOwner():DoCustomAnimEvent(PLAYERANIMEVENT_ATTACK_PRIMARY, 0)

    local pvar = self:GetValue("ShootPitchVariance")
    local sshoot = self:GetValue("Sound_Shoot")

    if self:GetValue("Silencer") then
        sshoot = self:GetValue("Sound_Shoot_Silenced")
    end

    if istable(sshoot) then
        sshoot = table.Random(sshoot)
    end

    if self:GetValue("Sound_ShootAdd") then
        self:EmitSound(self:GetValue("Sound_ShootAdd"), self:GetValue("Vol_Shoot"), self:GetValue("Pitch_Shoot") + util.SharedRandom("TacRP_sshoot2", -pvar, pvar), self:GetValue("Loudness_Shoot"), CHAN_BODY)
    end

    -- if we die from suicide, EmitSound will not play, so do this instead
    if self:GetBlindFireMode() == TacRP.BLINDFIRE_KYS then
        if SERVER then
            sound.Play(sshoot, self:GetMuzzleOrigin(), self:GetValue("Vol_Shoot"), self:GetValue("Pitch_Shoot") + util.SharedRandom("TacRP_sshoot2", -pvar, pvar), self:GetValue("Loudness_Shoot"))
        end
    else
        self:EmitSound(sshoot, self:GetValue("Vol_Shoot"), self:GetValue("Pitch_Shoot") + util.SharedRandom("TacRP_sshoot2", -pvar, pvar), self:GetValue("Loudness_Shoot"), CHAN_WEAPON)
    end

    local delay = 60 / self:GetRPM()

    local curatt = self:GetNextSecondaryFire()
    local diff = CurTime() - curatt

    if diff > engine.TickInterval() or diff < 0 then
        curatt = CurTime()
    end

    self:SetNthShot2(self:GetNthShot2() + 1)
    self.LastSecondaryFireTime = CurTime()
    self.RightCoolingShown = false  // Reset so left gun can show cooling animation for this shot
    self:SetLastFiredRight(true)

    // Force right side effects (forceRight = true)
    local ejectdelay = self:GetValue("EjectDelay")
    if ejectdelay == 0 then
        self:DoEject(nil, true)
    else
        self:SetTimer(ejectdelay, function()
            self:DoEject(nil, true)
        end)
    end

    self:DoEffects(nil, true)

    if self:GetValue("EffectsDoubled") then
        self:DoEffects(true, true)
        if ejectdelay == 0 then
            self:DoEject(true, true)
        else
            self:SetTimer(ejectdelay, function()
                self:DoEject(true, true)
            end)
        end
    end

    local num = self:GetValue("Num")
    local fixed_spread = self:IsShotgun() and TacRP.ConVars["fixedspread"]:GetBool()
    local pellet_spread = self:IsShotgun() and self:GetValue("ShotgunPelletSpread") > 0 and TacRP.ConVars["pelletspread"]:GetBool()

    local spread = self:GetSpread()
    local dir = self:GetShootDir()
    local tr = self:GetValue("TracerNum")
    local shootent = self:GetValue("ShootEnt")

    if IsFirstTimePredicted() then
        local hitscan = !TacRP.ConVars["physbullet"]:GetBool()
        local dist = 100000

        if !hitscan and (game.SinglePlayer() or !TacRP.ConVars["client_damage"]:GetBool()) then
            dist = math.max(self:GetValue("MuzzleVelocity"), 15000) * engine.TickInterval()
                    * game.GetTimeScale()
                    * (num == 1 and 2 or 1) * (game.IsDedicated() and 1 or 2)
            local threshold = dir:Forward() * dist
            local inst_tr = util.TraceLine({
                start = self:GetMuzzleOrigin(),
                endpos = self:GetMuzzleOrigin() + threshold,
                mask = MASK_SHOT,
                filter = {self:GetOwner(), self:GetOwner():GetVehicle(), self},
            })
            if inst_tr.Hit and !inst_tr.HitSky then
                hitscan = true
            end
        end

        if shootent or !hitscan or fixed_spread then
            local d = math.random()
            for i = 1, num do
                local new_dir = Angle(dir)
                if fixed_spread then
                    local sgp_x, sgp_y = self:GetShotgunPattern(i, d)
                    new_dir = anglerotate(new_dir, Angle(sgp_x, sgp_y, 0) * 36 * 1.4142135623730)
                    if pellet_spread then
                        new_dir = anglerotate(new_dir, self:RandomSpread(self:GetValue("ShotgunPelletSpread"), i))
                    end
                else
                    new_dir = anglerotate(new_dir, self:RandomSpread(spread, i))
                end

                if shootent then
                    self:ShootRocket(new_dir)
                elseif hitscan then
                    self:GetOwner():FireBullets({
                        Damage = self:GetValue("Damage_Max"),
                        Force = 8,
                        Tracer = tr,
                        TracerName = "tacrp_tracer",
                        Num = 1,
                        Dir = new_dir:Forward(),
                        Src = self:GetMuzzleOrigin(),
                        Spread = Vector(),
                        IgnoreEntity = self:GetOwner():GetVehicle(),
                        Distance = dist,
                        HullSize = (self:IsShotgun() and i % 2 == 0) and TacRP.ShotgunHullSize or 0,
                        Callback = function(att, btr, dmg)
                            local range = (btr.HitPos - btr.StartPos):Length()
                            self:AfterShotFunction(btr, dmg, range, self:GetValue("Penetration"), {})
                        end
                    })
                else
                    TacRP:ShootPhysBullet(self, self:GetMuzzleOrigin(), new_dir:Forward() * self:GetValue("MuzzleVelocity"),
                            {HullSize = (self:IsShotgun() and i % 2 == 0) and TacRP.ShotgunHullSize or 0,})
                end
            end
        else
            local new_dir = Angle(dir)
            local new_spread = spread

            self:GetOwner():FireBullets({
                Damage = self:GetValue("Damage_Max"),
                Force = 8,
                Tracer = tr,
                TracerName = "tacrp_tracer",
                Num = num,
                Dir = new_dir:Forward(),
                Src = self:GetMuzzleOrigin(),
                Spread = Vector(new_spread, new_spread, 0),
                IgnoreEntity = self:GetOwner():GetVehicle(),
                Distance = dist,
                Callback = function(att, btr, dmg)
                    local range = (btr.HitPos - btr.StartPos):Length()

                    if IsValid(btr.Entity) and (!game.SinglePlayer() and TacRP.ConVars["client_damage"]:GetBool()) then
                        if CLIENT then
                            net.Start("tacrp_clientdamage")
                                net.WriteEntity(self)
                                net.WriteEntity(btr.Entity)
                                net.WriteVector(btr.Normal)
                                net.WriteVector(btr.Entity:WorldToLocal(btr.HitPos))
                                net.WriteUInt(btr.HitGroup, 8)
                                net.WriteFloat(range)
                                net.WriteFloat(self:GetValue("Penetration"))
                                net.WriteUInt(0, 4)
                            net.SendToServer()
                        else
                            self:AfterShotFunction(btr, dmg, range, self:GetValue("Penetration"), {[btr.Entity] = true})
                        end
                    else
                        self:AfterShotFunction(btr, dmg, range, self:GetValue("Penetration"), {})
                    end
                end
            })
        end
    end

    self:ApplyRecoil()

    self:SetNextSecondaryFire(curatt + delay)
    self:TakeSecondaryAmmo(self:GetValue("AmmoPerShot"))

    self:SetBurstCount2(self:GetBurstCount2() + 1)
    self:SetPatternCount(self:GetPatternCount() + 1)
    self:DoBulletBodygroups()

    if self:Clip2() == 0 then self.Secondary.Automatic = false end

    -- FireBullets won't hit ourselves. Apply damage directly!
    if SERVER and self:GetBlindFireMode() == TacRP.BLINDFIRE_KYS and !self:GetValue("ShootEnt") then
        timer.Simple(0, function()
            if !IsValid(self) or !IsValid(self:GetOwner()) then return end
            local damage = DamageInfo()
            damage:SetAttacker(self:GetOwner())
            damage:SetInflictor(self)
            damage:SetDamage(self:GetValue("Damage_Max") * self:GetValue("Num") * self:GetConfigDamageMultiplier())
            damage:SetDamageType(self:GetValue("DamageType") or self:IsShotgun() and DMG_BUCKSHOT or DMG_BULLET)
            damage:SetDamagePosition(self:GetMuzzleOrigin())
            damage:SetDamageForce(dir:Forward() * self:GetValue("Num"))

            damage:ScaleDamage(self:GetBodyDamageMultipliers()[HITGROUP_HEAD])

            self:GetOwner():TakeDamageInfo(damage)
        end)
    end

    if CLIENT and self:GetOwner() == LocalPlayer() then
        self:DoMuzzleLight()
    elseif game.SinglePlayer() then
        self:CallOnClient("DoMuzzleLight")
    end

    self:SetCharge(false)

    self:RunHook("Hook_PostShoot")
end