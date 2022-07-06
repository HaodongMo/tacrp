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

    local anim = "deploy"

    if (!base and self:GetValue("TryUnholster")) or (base and self.TryUnholster) then
        anim = "unholster"
    end

    local seq = vm:LookupSequence(self:TranslateSequence(anim))
    local basetime = vm:SequenceDuration(seq)
    local mult = self.DeployTimeMult

    if !base then
        mult = self:GetValue("DeployTimeMult")
    end

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