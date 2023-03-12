function SWEP:PlayAnimation(seq, mult, lock, doidle)
    mult = mult or 1
    lock = lock or false
    seq = self:TranslateSequence(seq)
    doidle = doidle or false
    local reverse = false

    if mult < 0 then
        reverse = true
        mult = -mult
    end

    local vm = self:GetVM()

    if !IsValid(vm) then return end

    if isstring(seq) then
        seq = vm:LookupSequence(seq)
    end

    if seq == -1 then return end

    self.CurrentAnimation = seq

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
        self:SetNextSecondaryFire(CurTime() + time)
    else
        self:SetAnimLockTime(CurTime())
        self:SetNextSecondaryFire(CurTime())
    end

    if doidle and !self.NoIdle then
        self:SetNextIdle(CurTime() + time)
    else
        self:SetNextIdle(math.huge)
    end

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

    if self:GetBlindFire() then
        self:PlayAnimation("blind_idle")
    else
        self:PlayAnimation("idle")
    end
end