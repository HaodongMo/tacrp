function SWEP:SetTimer(time, callback, id)
    if !IsFirstTimePredicted() then return end

    self.ActiveTimers = self.ActiveTimers or {}
    table.insert(self.ActiveTimers, { time + CurTime(), id or "", callback })
end

function SWEP:TimerExists(id)
    if (!self.ActiveTimers) then return false end

    for _, v in pairs(self.ActiveTimers) do
        if v[2] == id then return true end
    end

    return false
end

function SWEP:KillTimer(id)
    if (!self.ActiveTimers) then return false end

    for k, v in pairs(self.ActiveTimers) do
        if v[2] == id then table.remove(self.ActiveTimers, k) end
    end
end

function SWEP:KillTimers()
    if (!self.ActiveTimers) then return end

    -- memory
    for k in pairs(self.ActiveTimers) do
        self.ActiveTimers[k] = nil
    end

    self.ActiveTimers = {}
end

function SWEP:ProcessTimers()
    if (!self.ActiveTimers) then return end

    for k, v in pairs(self.ActiveTimers) do
        if v[1] <= UCT then
            self.ActiveTimers[k] = nil
            v[3]()
        end
    end
end
