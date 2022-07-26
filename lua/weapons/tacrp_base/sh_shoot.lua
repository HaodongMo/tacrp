function SWEP:StillWaiting()
    if self:GetNextPrimaryFire() > CurTime() then return true end
    if self:GetNextSecondaryFire() > CurTime() then return true end
    if self:GetAnimLockTime() > CurTime() then return true end
    if self:GetCustomize() then return true end
    if self:GetPrimedGrenade() then return true end

    return false
end

function SWEP:SprintLock()
    if self:GetSprintLockTime() > CurTime() then return true end
    if self:GetIsSprinting() then return true end

    return false
end

function SWEP:PrimaryAttack()
    if self:GetOwner():IsNPC() then
        self:NPC_PrimaryAttack()
        return
    end

    if self:GetReloading() then
        self:SetEndReload(true)
    end

    if self:StillWaiting() then
        return
    end

    if self:GetValue("Melee") and self:GetOwner():KeyDown(IN_USE) then
        self.Primary.Automatic = false
        self:Melee()
        return
    end

    if self:GetCurrentFiremode() < 0 and self:GetBurstCount() >= -self:GetCurrentFiremode() then return end

    if self:Clip1() < self:GetValue("AmmoPerShot") then
        self.Primary.Automatic = false
        if self:GetBlindFire() then
            self:PlayAnimation("blind_dryfire")
        else
            self:PlayAnimation("dryfire")
        end
        self:EmitSound(self:GetValue("Sound_DryFire"), 75, 100, 1, CHAN_BODY)
        self:SetBurstCount(0)
        self:SetNextPrimaryFire(CurTime() + 0.1)
        return
    end

    self:SetBaseSettings()

    if self:SprintLock() then return end

    if self:GetSafe() then self:ToggleSafety(false) return end

    local seq = "fire"

    local idle = true

    local mult = self:GetValue("ShootTimeMult")

    if self:GetValue("LastShot") and self:Clip1() == 1 then
        seq = self:TranslateSequence("lastshot")
        idle = false
    end

    if self:GetBlindFire() then
        seq = "blind_" .. seq
    end

    if self:GetValue("Akimbo") and !self:GetBlindFire() then
        if self:GetNthShot() % 2 == 0 then
            seq = "shoot_left"
        else
            seq = "shoot_right"
        end

        if self:GetValue("LastShot") then
            if self:Clip1() == 0 then
                seq = seq .. "_lastshot"
            elseif self:Clip1() == 1 then
                seq = seq .. "_second_2_lastshot"
            end
        end
    end

    if self:GetScopeLevel() > 0 and self:HasSequence(seq .. "_iron") then
        self:PlayAnimation(seq .. "_iron", mult, false, idle)
    elseif self:HasSequence(seq .. "1") then
        local seq1 = seq .. "1"
        if self:GetScopeLevel() < 1 then
            seq1 = seq .. tostring(self:GetBurstCount() + 1)
        end

        if self:HasSequence(seq1) then
            self:PlayAnimation(seq1, mult, false, idle)
        elseif self:GetScopeLevel() < 1 then
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

    local ejectdelay = self:GetValue("EjectDelay")

    if ejectdelay == 0 then
        self:DoEject()
    else
        self:SetTimer(ejectdelay, function()
            self:DoEject()
        end)
    end

    self:GetOwner():DoAnimationEvent(self:GetValue("GestureShoot"))

    local pvar = self:GetValue("ShootPitchVariance")

    local sshoot = self:GetValue("Sound_Shoot")

    if self:GetValue("Silencer") then
        sshoot = self:GetValue("Sound_Shoot_Silenced")
    end

    if istable(sshoot) then
        sshoot = table.Random(sshoot)
    end

    self:EmitSound(sshoot, self:GetValue("Vol_Shoot"), self:GetValue("Pitch_Shoot") + util.SharedRandom("TacRP_sshoot", -pvar, pvar), self:GetValue("Loudness_Shoot"), CHAN_WEAPON)

    local delay = 60 / self:GetValue("RPM")

    local curatt = self:GetNextPrimaryFire()
    local diff = CurTime() - curatt

    if diff > engine.TickInterval() or diff < 0 then
        curatt = CurTime()
    end

    self:SetNextPrimaryFire(curatt + delay)

    self:TakePrimaryAmmo(self:GetValue("AmmoPerShot"))

    self:SetNthShot(self:GetNthShot() + 1)

    self:DoEffects()

    local spread = self:GetSpread()

    local dir = self:GetShootDir()

    if self:GetValue("ShootEnt") then
        self:ShootRocket()
    else
        if IsFirstTimePredicted() then

            local hitscan = !GetConVar("tacrp_physbullet"):GetBool()

            -- If the bullet is going to hit something very close in front, use hitscan bullets instead
            -- This uses the aim direction without random spread, which may result in hitscan bullets in distances where it shouldn't be.
            if !hitscan then
                local threshold = dir:Forward() * math.max(self:GetValue("MuzzleVelocity"), 12000) * engine.TickInterval() * 2
                local inst_tr = util.TraceLine({
                    start = self:GetMuzzleOrigin(),
                    endpos = self:GetMuzzleOrigin() + threshold,
                    mask = MASK_SHOT_HULL,
                    filter = self:GetOwner():GetVehicle(),
                })
                debugoverlay.Line(self:GetMuzzleOrigin(), self:GetMuzzleOrigin() + threshold, 1, inst_tr.Hit and Color(255, 0, 255) or Color(255, 200, 255))
                if inst_tr.Hit and !inst_tr.HitSky then
                    hitscan = true
                end
            end

            if !hitscan then
                for i = 1, self:GetValue("Num") do
                    local new_dir = dir + (spread * AngleRand() / 3.6)
                    TacRP:ShootPhysBullet(self, self:GetMuzzleOrigin(), new_dir:Forward() * self:GetValue("MuzzleVelocity"))
                end
            else
                self:GetOwner():LagCompensation(true)
                local tr = self:GetValue("TracerNum")

                -- if self:GetValue("ScopeOverlay") and self:GetScopeLevel() > 0 then
                --     tr = 0
                -- end

                self:GetOwner():FireBullets({
                    Damage = self:GetValue("Damage_Max"),
                    Force = 8,
                    Tracer = tr,
                    TracerName = "tacrp_tracer",
                    Num = self:GetValue("Num"),
                    Dir = dir:Forward(),
                    Src = self:GetMuzzleOrigin(),
                    Spread = Vector(spread, spread, spread),
                    IgnoreEntity = self:GetOwner():GetVehicle(),
                    Callback = function(att, btr, dmg)
                        local range = (btr.HitPos - btr.StartPos):Length()

                        self:AfterShotFunction(btr, dmg, range, self:GetValue("Penetration"), {})
                        if SERVER then
                            debugoverlay.Cross(btr.HitPos, 4, 5, Color(255, 0, 0), false)
                        else
                            debugoverlay.Cross(btr.HitPos, 4, 5, Color(255, 255, 255), false)
                        end
                    end
                })

                self:GetOwner():LagCompensation(false)
            end
        end
    end

    self:ApplyRecoil()

    self:SetBurstCount(self:GetBurstCount() + 1)

    self:DoBulletBodygroups()

    if self:Clip1() == 0 then self.Primary.Automatic = false end
end

function SWEP:AfterShotFunction(tr, dmg, range, penleft, alreadypenned, forced)
    if !forced and !IsFirstTimePredicted() and !game.SinglePlayer() then return end
    local dmgv = self:GetDamageAtRange(range)

    local bodydamage = self:GetValue("BodyDamageMultipliers")

    local dmgbodymult = 1

    if bodydamage[tr.HitGroup] then
        dmgbodymult = dmgbodymult * bodydamage[tr.HitGroup]
    end

    if IsValid(tr.Entity) and !tr.Entity:IsNextBot() and GetConVar("TacRP_bodydamagecancel"):GetBool() and TacRP.CancelMultipliers[tr.HitGroup] then
        dmgbodymult = dmgbodymult / TacRP.CancelMultipliers[tr.HitGroup]
    end

    dmgv = dmgv * dmgbodymult

    local pendelta = penleft / self:GetValue("Penetration")

    pendelta = math.Clamp(pendelta, 0.1, 1)

    dmgv = dmgv * pendelta

    if self:GetOwner():IsNPC() and !GetConVar("TacRP_npc_equality"):GetBool() then
        dmgv = dmgv * 0.25
    end

    dmg:SetDamage(dmgv)

    if tr.Entity and alreadypenned[tr.Entity] then
        dmg:SetDamage(0)
    elseif tr.Entity then
        alreadypenned[tr.Entity] = true
    end

    if self:GetValue("ExplosiveDamage") > 0 then
        util.BlastDamage(self, self:GetOwner(), tr.HitPos, self:GetValue("ExplosiveRadius"), self:GetValue("ExplosiveDamage"))
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

    if self:GetValue("Num") > 1 then
        dmg:SetDamageType(DMG_BUCKSHOT)
    end

    self:Penetrate(tr, range, penleft, alreadypenned)
end

function SWEP:GetDamageAtRange(range)
    local d = 1

    local r_min = self:GetValue("Range_Min")
    local r_max = self:GetValue("Range_Max")

    if range <= r_min then
        d = 0
    elseif range >= r_max then
        d = 1
    else
        d = (range - r_min) / (r_max - r_min)
    end

    local dmgv = Lerp(d, self:GetValue("Damage_Max"), self:GetValue("Damage_Min"))

    dmgv = math.ceil(dmgv)

    return dmgv
end

function SWEP:GetShootDir()
    local dir = self:GetOwner():EyeAngles()

    if self:GetBlindFireCorner() then
        dir.y = dir.y + 75
    end

    local u, r, f = dir:Up(), dir:Right(), dir:Forward()

    local oa = self:GetFreeAimOffset() + self:GetSwayAngles()

    dir:RotateAroundAxis(u, oa.y)
    -- dir:RotateAroundAxis(r, oa.r)
    dir:RotateAroundAxis(r, -oa.p)

    return dir
end

function SWEP:ShootRocket(dir)
    if CLIENT then return end

    local src = self:GetMuzzleOrigin()
    dir = dir or self:GetShootDir()

    local num = self:GetValue("Num")
    local ent = self:GetValue("ShootEnt")

    local spread

    if self:GetOwner():IsNPC() then
        spread = self:GetNPCSpread()
    else
        spread = self:GetSpread()
    end

    for i = 1, num do
        local dispersion = Angle(math.Rand(-1, 1), math.Rand(-1, 1), 0)

        dispersion = dispersion * spread * 36

        local rocket = ents.Create(ent)
        if !IsValid(rocket) then return end

        rocket:SetPos(src)
        rocket:SetOwner(self:GetOwner())
        rocket:SetAngles(dir + dispersion)
        rocket:Spawn()

        local phys = rocket:GetPhysicsObject()

        if phys:IsValid() then
            phys:ApplyForceCenter((dir + dispersion):Forward() * self:GetValue("ShootEntForce"))
        end
    end
end

function SWEP:GetSpread(baseline)
    local spread = self:GetValue("Spread")

    if self:GetScopeLevel() == 0 then
        spread = spread + self:GetValue("HipFireSpreadPenalty")
    else
        spread = spread + self:GetValue("ScopedSpreadPenalty")
    end

    if baseline then return spread end

    spread = spread + (self:GetRecoilAmount() * self:GetValue("RecoilSpreadPenalty"))

    local spd = math.min(self:GetOwner():GetAbsVelocity():Length(), 250)

    spd = spd / 250

    spread = spread + (spd * self:GetValue("MoveSpreadPenalty"))

    if !self:GetOwner():OnGround() then
        spread = spread + self:GetValue("MidAirSpreadPenalty")
    end

    if self:GetOwner():OnGround() and self:GetOwner():Crouching() then
        spread = spread + self:GetValue("CrouchSpreadPenalty")
    end

    if self:GetBlindFire() then
        spread = spread + self:GetValue("BlindFireSpreadPenalty")
    end

    local quickscopetime = CurTime() - self:GetLastScopeTime()

    local qsd = quickscopetime / self:GetValue("QuickScopeTime")

    if qsd < 1 then
        spread = spread + Lerp(qsd, self:GetValue("QuickScopeSpreadPenalty"), 0)
    end

    spread = math.max(spread, 0)

    return spread
end

function SWEP:FireAnimationEvent( pos, ang, event, options )
    return true
end