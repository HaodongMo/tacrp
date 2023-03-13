function SWEP:GetReloadTime(base)
    local vm = self:GetVM()

    if !self:GetValue("ShotgunReload") then
        local seq = vm:LookupSequence(self:TranslateSequence("reload"))
        local basetime = vm:SequenceDuration(seq)
        local mult = self.ReloadTimeMult

        if !base then
            mult = self:GetValue("ReloadTimeMult")
        end

        return basetime * mult
    else
        local seq1 = vm:LookupSequence(self:TranslateSequence("reload_start"))
        local seq2 = vm:LookupSequence(self:TranslateSequence("reload"))
        local seq3 = vm:LookupSequence(self:TranslateSequence("reload_finish"))

        local time_1 = vm:SequenceDuration(seq1)
        local time_2 = vm:SequenceDuration(seq2)
        local time_3 = vm:SequenceDuration(seq3)

        local mult = self.ReloadTimeMult

        if !base then
            mult = self:GetValue("ReloadTimeMult")
        end

        local basetime = time_1 + (time_2 * self:GetValue("ClipSize")) + time_3

        if self:GetValue("ShotgunThreeload") then
            basetime = time_1 + (time_2 * self:GetValue("ClipSize") / 3) + time_3
        end

        return basetime * mult
    end
end

function SWEP:GetDeployTime(base)
    local vm = self:GetVM()
    local valfunc = base and self.GetBaseValue or self.GetValue

    local anim = "deploy"
    local mult = valfunc(self, "DeployTimeMult")

    if valfunc(self, "TryUnholster") then
        anim = "unholster"
    end

    local seq = vm:LookupSequence(self:TranslateSequence(anim))
    local basetime = vm:SequenceDuration(seq)

    return basetime * mult
end

function SWEP:GetMuzzleVelocity(base)
    local basetime = self:GetValue("MuzzleVelocity")

    if self:GetValue("ShootEnt") then
        basetime = self:GetValue("ShootEntForce")
    end

    if base then
        basetime = self.MuzzleVelocity

        if self.ShootEnt then
            basetime = self.ShootEntForce
        end
    end

    return math.ceil(0.3048 * basetime / 12)
end

function SWEP:GetMeanShotsToFail(base)
    local shootchance = self:GetValue("ShootChance")

    if base then
        shootchance = self.ShootChance
    end

    return 1 / (1 - shootchance)
end

function SWEP:GetBestFiremode(base)
    local valfunc = base and self.GetBaseValue or self.GetValue

    if valfunc(self, "Firemodes") then
        local bfm, bfm_i
        for k, v in pairs(valfunc(self, "Firemodes")) do
            if !bfm or v == 2 or (bfm <= 1 and v < bfm) then
                bfm = v
                bfm_i = k
            end
        end
        return bfm, bfm_i
    else
        return valfunc(self, "Firemode") or 0, 1
    end
end


local mssd_scoring = {
    [HITGROUP_HEAD]    = {0.15, 0.5, {1, 0.6,  0.3, 0.15, 0.05}},
    [HITGROUP_CHEST]   = {0.25, 0.8, {1, 0.75, 0.4, 0.2,  0.1}},
    [HITGROUP_STOMACH] = {0.25, 1,   {1, 0.8,  0.5, 0.25, 0.15, 0.05}},
    [HITGROUP_LEFTARM] = {0.2,  1,   {1, 0.85, 0.6, 0.3,  0.2,  0.1, 0.05}},
    [HITGROUP_LEFTLEG] = {0.15, 1,   {1, 0.9,  0.7, 0.4,  0.25, 0.15, 0.1}},
}

SWEP.StatGroups = {
    {
        Name = "Lethality",
        Description = {"How easily and quickly the weapon kills under ideal circumstances.", "Affected by Damage and RPM."},
        RatingFunction = function(self, base)
            local score = 0
            local valfunc = base and self.GetBaseValue or self.GetValue

            local bfm = self:GetBestFiremode(base)
            local rrpm = valfunc(self, "RPM")
            local erpm = rrpm
            local pbd = valfunc(self, "AutoBurst") and valfunc(self, "PostBurstDelay") or math.max(0.15, valfunc(self, "PostBurstDelay"))

            -- if bfm == 1 then
            --     erpm = math.min(rrpm, 600) -- you can't click *that* fast
            -- elseif bfm < 0 then
            --     erpm = 60 / ((60 / rrpm) + pbd / -bfm)
            -- end

            local num = valfunc(self, "Num")
            local bdm = self:GetBodyDamageMultipliers(base)
            local bdm_add = 0
            for k, v in pairs(mssd_scoring) do
                bdm_add = bdm_add + bdm[k] * v[1]
            end

            local d_max, d_min = valfunc(self, "Damage_Max"), valfunc(self, "Damage_Min")
            -- local dmg_max = math.max(d_max, d_min)
            local dmg_avg = Lerp(0.2, math.max(d_max, d_min), math.min(d_max, d_min)) * bdm_add

            -- dps
            local dot = dmg_avg * num * erpm / 60
            local dot_s = math.Clamp(dot / 600, 0, 1) ^ 0.8

            -- max single shot damage
            local mssd = 0
            for k, v in pairs(mssd_scoring) do
                local stk = math.ceil(100 / (dmg_avg * (bdm[k] or 1) * (num ^ v[2])))
                mssd = mssd + (v[3][stk] or 0) * v[1]
                -- print(bdm[k], stk, (mssd_scoring[k][stk] or 0))
            end

            -- avg time to kill
            local stk = math.ceil(100 / dmg_avg)
            local trpm = rrpm
            local ttk = (stk - 1) * (60 / trpm)
            if bfm < 0 then
                ttk = ttk + math.floor(ttk / -bfm) * pbd
            end
            local ttk_s = math.Clamp(1 - ttk / 1.5, 0, 1) ^ 1.5

            local scores = {mssd, ttk_s, dot_s}
            table.sort(scores)
            -- print(mssd, ttk_s, dot_s)
            return scores[3] * 70 + scores[2] * 30 + scores[1] * 0
        end,
    },
    {
        Name = "Range",
        Description = {"How well the weapon gains or loses damage over long distances.", "Affected by Minimum Range, Maximum Range, and damage falloff."},
        RatingFunction = function(self, base)
            local score = 0
            local valfunc = base and self.GetBaseValue or self.GetValue

            local d_max, d_min = valfunc(self, "Damage_Max"), valfunc(self, "Damage_Min")
            local r_min, r_max = self:GetMinMaxRange(base)

            local r_mid = r_min + (r_max - r_min) / 2
            local d_diff = math.abs(d_max - d_min) / math.max(d_max, d_min)
            if d_max > d_min then
                -- [40] 50% damage falloff range
                score = score + math.Clamp((r_mid - 1000) / 4000, 0, 1) * 40

                -- [60] damage reduction from range
                score = score + math.Clamp(1 - d_diff, 0, 1) * 60
            else
                -- [30] free points
                -- [50] 50% damage rampup range
                score = score + 30 + math.Clamp(1 - r_mid / 5000, 0, 1) * 50
                -- print(r_mid, math.Clamp(1 - r_mid / 5000, 0, 1))

                -- [20] damage reduction from range
                score = score + math.Clamp(1 - d_diff, 0, 1) * 20
            end

            return score
        end,
    },
    {
        Name = "Precision",
        Description = {"How accurate the weapon is when firing single shots or short bursts.", "Affected by Spread and various Recoil stats."},
        RatingFunction = function(self, base)
            local score = 0
            local valfunc = base and self.GetBaseValue or self.GetValue

            local bfm = self:GetBestFiremode(base)
            local erpm = valfunc(self, "RPM")
            local pbd = valfunc(self, "AutoBurst") and valfunc(self, "PostBurstDelay") or math.max(0.15, valfunc(self, "PostBurstDelay"))
            if bfm == 1 then
                erpm = math.min(erpm, 600) -- you can't click *that* fast
            elseif bfm < 0 then
                erpm = 60 / ((60 / erpm) + pbd / -bfm)
            end

            local num = valfunc(self, "Num")
            local spread = valfunc(self, "Spread") + (num > 1 and !GetConVar("tacrp_pelletspread"):GetBool() and valfunc(self, "ShotgunPelletSpread") or 0)
            local delay = 60 / valfunc(self, "RPM")
            local rps = valfunc(self, "RecoilPerShot")
            local rsp = valfunc(self, "RecoilSpreadPenalty")
            local rrt = valfunc(self, "RecoilResetTime")
            local rdr = valfunc(self, "RecoilDissipationRate")
            local dt = math.max(0, delay - rrt)
            local rbs = dt * rdr -- amount of recoil we can recover between shots even if fired ASAP

            -- [35] base spread
            local tgt = 0.02
            if num > 1 then tgt = 0.04 end
            score = score + math.Clamp(1 - spread / tgt, 0, 1) ^ 3 * 35

            -- [25] first shot spread
            local fss = valfunc(self, "RecoilFirstShotMult") * rps
            score = score + math.Clamp(1 - (fss * rsp - rbs) / 0.01, 0, 1) * 25

            -- [25] spread over 0.5 second (or one burst)
            local shots = math.floor(math.min(valfunc(self, "ClipSize"), erpm / 60 * 0.5))
            if bfm < 0 then
                shots = -bfm
            end
            if rbs <= fss then
                local so1 = (fss - rbs + shots * (rps - rbs)) * rsp
                score = score + math.Clamp(1 - so1 / 0.03, 0, 1) ^ 1.5 * 25
            else
                -- delay is so long we always get first shot
                score = score + 25
            end

            -- [15] recoil reset time
            score = score + math.Clamp(1 - math.max(0, rrt - delay) / 0.25, 0, 1) * 15

            return score
        end,
    },
    {
        Name = "Control",
        Description = {"How managable the weapon's recoil and spread is under sustained fire.", "Affected by RPM and various Recoil stats."},
        RatingFunction = function(self, base)
            local score = 0
            local valfunc = base and self.GetBaseValue or self.GetValue

            local bfm = self:GetBestFiremode(base)
            local erpm = valfunc(self, "RPM")
            local pbd = valfunc(self, "AutoBurst") and valfunc(self, "PostBurstDelay") or math.max(0.15, valfunc(self, "PostBurstDelay"))
            if bfm == 1 then
                erpm = math.min(erpm, 600) -- you can't click *that* fast
            elseif bfm < 0 then
                erpm = 60 / ((60 / erpm) + pbd / -bfm)
            end
            local delay = 60 / valfunc(self, "RPM")
            local rps = valfunc(self, "RecoilPerShot")
            local rsp = valfunc(self, "RecoilSpreadPenalty")
            local rrt = valfunc(self, "RecoilResetTime")
            local rdr = valfunc(self, "RecoilDissipationRate")
            local dt = math.max(0, delay - rrt)
            local rbs = dt * rdr -- amount of recoil we can recover between shots even if fired ASAP
            local fss = valfunc(self, "RecoilFirstShotMult") * rps
            local rmax = valfunc(self, "RecoilMaximum")

            local rk = valfunc(self, "RecoilKick")

            if rbs > fss or rsp == 0 then
                -- judge solely on recoil kick and reset time, as spread is not a factor
                return math.Clamp(1 - rk * rrt / 3, 0, 1) * 100
            end

            -- [15] maximum spread
            score = score + math.Clamp(1 - rmax * rsp / 0.1, 0, 1) * 15

            -- [25] recoil kick over 1s
            local shots = math.ceil(erpm / 60 * 1)
            score = score + math.Clamp(1 - rk * shots * rrt / 15, 0, 1) * 25
            --print("rk1", rk * shots * rrt, math.Clamp(1 - rk * shots * rrt / 15, 0, 1) * 25)

            -- [30] recoil recovery
            score = score + math.Clamp(math.max(0, (rdr / rps) - 4) / 16, 0, 1) * 30
            --print("rrec", rdr, math.Clamp(math.max(0, (rdr / rps) - 4) / 16, 0, 1) * 30)

            -- [30] spread over 1s (or 2 bursts)
            local score_sg = 30
            if bfm < 0 then
                local rbb = math.max(0, pbd - rrt) * rdr -- recovery between bursts
                local rpb = -bfm * rps - (-bfm - 1) * rbs - rbb -- recoil per full burst
                score = score + math.Clamp(1 - (rpb * rsp * 2) / 0.04, 0, 1) ^ 2 * score_sg
                --print("spb", rpb * rsp, math.Clamp(1 - (rpb * rsp * 3) / 0.04, 0, 1) ^ 2 * score_sg)
            else
                local sot = math.min(rmax, fss - rbs + shots * (rps - rbs)) * rsp
                --print("sot", sot, math.Clamp(1 - sot / 0.04, 0, 1) ^ 2 * score_sg)
                score = score + math.Clamp(1 - sot / 0.04, 0, 1) ^ 2 * score_sg
            end

            return score
        end,
    },
    {
        Name = "Handling",
        Description = {"How quickly this weapon readies from sprint, aims, deploys, and reloads.", "Affected by various Time stats, such as Aim Down Sights Time."},
        RatingFunction = function(self, base)
            local score = 0
            local valfunc = base and self.GetBaseValue or self.GetValue

            -- [32] sprint
            score = score + math.Clamp(1 - (valfunc(self, "SprintToFireTime") - 0.2) / 0.7, 0, 1) * 32

            -- [32] ads
            score = score + math.Clamp(1 - (valfunc(self, "AimDownSightsTime") - 0.2) / 0.7, 0, 1) * 32

            -- [25] reload
            if valfunc(self, "ShotgunReload") then
                local vm = self:GetVM()
                local seq1 = vm:LookupSequence(self:TranslateSequence("reload_start"))
                local seq2 = vm:LookupSequence(self:TranslateSequence("reload_finish"))

                local time = vm:SequenceDuration(seq1) + vm:SequenceDuration(seq2)
                time = time * valfunc(self, "ReloadTimeMult")

                score = score + math.Clamp(1 - (time - 0.5) / 2, 0, 1) * 25
            else
                score = score + math.Clamp(1 - (self:GetReloadTime(base) - 1.5) / 3, 0, 1) * 25
            end

            -- [11] deploy
            score = score + math.Clamp(1 - (self:GetDeployTime(base) - 0.5) / 1, 0, 1) * 11

            return score
        end,
    },
    {
        Name = "Mobility",
        Description = {"How fast the user can move while using this weapon.", "Affected by various Speed stats, such as Sighted Speed."},
        RatingFunction = function(self, base)
            local score = 0
            local valfunc = base and self.GetBaseValue or self.GetValue

            -- [40] move
            score = score + math.Clamp((valfunc(self, "MoveSpeedMult") - 0.4) / 0.6, 0, 1) * 40

            -- [30] sighted
            score = score + math.Clamp((valfunc(self, "SightedSpeedMult") - 0.2) / 0.8, 0, 1) * 30

            -- [30] shooting
            score = score + math.Clamp((valfunc(self, "ShootingSpeedMult") - 0.2) / 0.8, 0, 1) * 30

            -- [-20] reload
            score = score - math.Clamp(1 - (valfunc(self, "ReloadSpeedMult") - 0.4) / 0.6, 0, 1) * 20

            return score
        end,
    },
    {
        Name = "Sway",
        Description = {"How much the weapon's point of aim will move around.", "Affected by various Sway stats.", "NOTE: Has no effect when Sway is disabled in the options."},
        RatingFunction = function(self, base)
            local score = 0
            local valfunc = base and self.GetBaseValue or self.GetValue

            -- [55] sway
            score = score + math.Clamp(1 - valfunc(self, "Sway") / 5, 0, 1) * 55

            -- [40] sighted sway
            score = score + math.Clamp(1 - valfunc(self, "ScopedSway") / 2, 0, 1) ^ 1.5 * 40

            -- [5] blindfire sway
            score = score + math.Clamp(1 - valfunc(self, "BlindFireSway") / 2, 0, 1) * 5

            return score
        end,
    },
}