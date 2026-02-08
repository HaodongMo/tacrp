function SWEP:PlayAnimation(seq, mult, lock, doidle)
    mult = mult or 1
    lock = lock or false
    local anim = self:TranslateSequence(seq)
    doidle = doidle or false
    local reverse = false

    if mult < 0 then
        reverse = true
        mult = -mult
    end

    local vm = self:GetVM()

    if !IsValid(vm) then return end

    if isstring(anim) then
        seq = vm:LookupSequence(anim)
    end

    if seq == -1 then return end

    self.CurrentAnimation = anim
    self.CurrentSeqeunce = seq

    local time = vm:SequenceDuration(seq)

    time = time * mult

    vm:SendViewModelMatchingSequence(seq)

    if reverse then
        vm:SetCycle(1)
        vm:SetPlaybackRate(-1 / mult)
    else
        vm:SetCycle(0)
        vm:SetPlaybackRate(1 / mult)
    end

    if lock then
        self:SetAnimLockTime(CurTime() + time)
        if self:GetValue("DualAkimbo") then
            self:SetNextSecondaryFire(CurTime() + time)
        end
    else
        self:SetAnimLockTime(0)
        if self:GetValue("DualAkimbo") then
            self:SetNextSecondaryFire(0)
        end
    end

    if doidle and !self.NoIdle then
        self:SetNextIdle(CurTime() + time)
    else
        self:SetNextIdle(math.huge)
    end

    self:SetLastProceduralFireTime(0)

    return time
end

function SWEP:IdleAtEndOfAnimation()
    local vm = self:GetVM()
    local cyc = vm:GetCycle()
    local duration = vm:SequenceDuration()
    local rate = vm:GetPlaybackRate()

    local time = (1 - cyc) * (duration / rate)

    self:SetNextIdle(CurTime() + time)
end

function SWEP:Idle()
    if self:GetPrimedGrenade() then return end

    local leftEmpty = self:Clip1() == 0
    local rightEmpty = self:GetValue("DualAkimbo") and self:Clip2() == 0

    if self:GetBlindFire() then
        if leftEmpty and (!self:GetValue("DualAkimbo") or rightEmpty) then
            // Both guns empty (or not DualAkimbo)
            self:PlayAnimation("blind_dryfire", 0, false, false)
        else
            self:PlayAnimation("blind_idle")
        end
    else
        if self:GetValue("DualAkimbo") then
            if leftEmpty and rightEmpty then
                // Both guns empty
                self:PlayAnimation("dryfire", 0, false, false)
            elseif leftEmpty and self:HasSequence("idle_left_empty") then
                // Only left gun empty
                self:PlayAnimation("idle_left_empty")
            elseif rightEmpty and self:HasSequence("idle_right_empty") then
                // Only right gun empty
                self:PlayAnimation("idle_right_empty")
            else
                self:PlayAnimation("idle")
            end
        else
            if leftEmpty then
                self:PlayAnimation("dryfire", 0, false, false)
            else
                self:PlayAnimation("idle")
            end
        end
    end

    self:SetReady(true)
end