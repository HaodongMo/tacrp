function SWEP:NPC_PrimaryAttack()
    if !IsValid(self:GetOwner()) then return end
    if self:Clip1() <= 0 then self:GetOwner():SetSchedule(SCHED_HIDE_AND_RELOAD) return end

    self:SetBaseSettings()
    self:SetShouldHoldType()

    local pvar = self:GetValue("ShootPitchVariance")

    local sshoot = self:GetValue("Sound_Shoot")

    if self:GetValue("Silencer") then
        sshoot = self:GetValue("Sound_Shoot_Silenced")
    end

    if istable(sshoot) then
        sshoot = table.Random(sshoot)
    end

    self:EmitSound(sshoot, self:GetValue("Vol_Shoot"), self:GetValue("Pitch_Shoot") + math.Rand(-pvar, pvar), 1, CHAN_WEAPON)

    local delay = 60 / self:GetValue("RPM")

    local curatt = self:GetNextPrimaryFire()
    local diff = CurTime() - curatt

    if diff > engine.TickInterval() or diff < 0 then
        curatt = CurTime()
    end

    self:SetNextPrimaryFire(curatt + delay)

    self:SetClip1(self:Clip1() - 1)

    local tr = self:GetValue("TracerNum")

    local spread = self:GetNPCBulletSpread(self:GetOwner():GetCurrentWeaponProficiency())

    spread = spread / 360
    spread = spread * 10

    spread = spread + self:GetNPCSpread()

    if self:GetValue("ShootEnt") then
        self:ShootRocket()
    else
        if GetConVar("tacrp_physbullet"):GetBool() then
            for i = 1, self:GetValue("Num") do
                local dir = self:GetOwner():GetAimVector():Angle()
                dir = dir + (spread * AngleRand() / 3.6)
                TacRP:ShootPhysBullet(self, self:GetOwner():GetShootPos(), dir:Forward() * self:GetValue("MuzzleVelocity"))
            end
        else
            self:GetOwner():FireBullets({
                Damage = self:GetValue("Damage_Max"),
                Force = 8,
                Tracer = tr,
                Num = self:GetValue("Num"),
                Dir = self:GetOwner():GetAimVector(),
                Src = self:GetOwner():GetShootPos(),
                Spread = Vector(spread, spread, spread),
                Callback = function(att, btr, dmg)
                    local range = (btr.HitPos - btr.StartPos):Length()

                    self:AfterShotFunction(btr, dmg, range, self:GetValue("Penetration"), {})

                    if GetConVar("developer"):GetBool() then
                        if SERVER then
                            debugoverlay.Cross(btr.HitPos, 4, 5, Color(255, 0, 0), false)
                        else
                            debugoverlay.Cross(btr.HitPos, 4, 5, Color(255, 255, 255), false)
                        end
                    end
                end
            })
        end
    end

    self:DoEffects()
    self:DoEject()
end

function SWEP:GetNPCBulletSpread(prof)
    local mode = self:GetCurrentFiremode()

    if mode < 0 then
        return 10 / (prof + 1)
    elseif mode == 0 then
        return 20 / (prof + 1)
    elseif mode == 1 then
        if math.Rand(0, 100) < (prof + 1) * 5 then
            return 10 / (prof + 1)
        else
            return 25 / (prof + 1)
        end
    elseif mode >= 2 then
        return 20 / (prof + 1)
    end

    return 15
end

function SWEP:GetNPCSpread()
    local spread = self:GetValue("Spread")

    local spd = math.min(self:GetOwner():GetAbsVelocity():Length(), 250)

    spd = spd / 250

    spread = spread + (spd * self:GetValue("MoveSpreadPenalty"))

    spread = math.max(spread, 0)

    return spread
end

function SWEP:GetNPCBurstSettings()
    local mode = self:GetCurrentFiremode()

    local delay = 60 / self:GetValue("RPM")

    self:SetNextPrimaryFire(CurTime() + delay)

    if !mode then return 1, 1, delay end

    if mode < 0 then
        return -mode, -mode, delay
    elseif mode == 0 then
        return 0, 0, delay
    elseif mode == 1 then
        return 0, 1, delay + math.Rand(0.3, 0.6)
    elseif mode >= 2 then
        if self:GetValue("RunawayBurst") then
            return self:Clip1(), self:Clip1(), delay
        else
            return 2, math.floor(2.5 / delay), delay
        end
    end
end

function SWEP:GetNPCRestTimes()
    return 0.33, 1
end

function SWEP:CanBePickedUpByNPCs()
    return self.NPCUsable
end

function SWEP:NPC_Reload()
    self:DropMagazine()
end

function SWEP:NPC_Initialize()
    if CLIENT then return end
    // auto attachment

    if GetConVar("TacRP_npc_atts"):GetBool() then
        for i, slot in pairs(self.Attachments) do
            local atts = TacRP.GetAttsForCats(slot.Category or "")

            local ind = math.random(0, #atts)

            if ind == 0 then
                -- slot.Installed = nil
            else
                slot.Installed = atts[ind]
            end
        end

        timer.Simple(0.25, function()
            if !IsValid(self) then return end
            self:NetworkWeapon()
        end)

        self.StatCache = {}
        self.HookCache = {}
    end

    self:SetBaseSettings()
end