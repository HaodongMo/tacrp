SWEP.StatCache = {}
SWEP.HookCache = {}
SWEP.StatScoreCache = {} -- used by cust menu
SWEP.MiscCache = {}

SWEP.ExcludeFromRawStats = {
    ["PrintName"] = true,
    ["Description"] = true,
}

SWEP.IntegerStats = {
    ["ClipSize"] = true,
    ["Num"] = true,
}

function SWEP:InvalidateCache()
    self.StatCache = {}
    self.HookCache = {}
    self.StatScoreCache = {}
    self.MiscCache = {}
end

function SWEP:RunHook(val, data)
    if !self.HookCache[val] then
        self.HookCache[val] = {}
        for slot, slottbl in pairs(self.Attachments) do
            if !slottbl.Installed then continue end

            local atttbl = TacRP.GetAttTable(slottbl.Installed)

            if atttbl[val] then
                table.insert(self.HookCache[val], atttbl[val])
            end
        end
    end

    for _, chook in pairs(self.HookCache[val]) do
        local d = chook(self, data)
        if d != nil then
            data = d
        end
    end

    data = hook.Run("TacRP_" .. val, self, data) or data

    return data
end

function SWEP:GetBaseValue(val)
    local stat = self:GetTable()[val]

    local b = TacRP.GetBalanceMode()
    if b > 0 and self.BalanceStats != nil then
        for j = b, 1, -1 do
            if self.BalanceStats[b] and self.BalanceStats[b][val] then
                return self.BalanceStats[b][val]
            end
        end
    end

    -- if b > 0 and self.ArcadeStats and self.ArcadeStats[val] != nil then
    --     return self.ArcadeStats[val]
    -- end

    return stat
end

function SWEP:GetValue(val, static, invert)

    if !invert and self.StatCache[val] then
        return self.StatCache[val]
    end

    local stat = self:GetBaseValue(val)

    local priority = 0

    if !self.ExcludeFromRawStats[val] then
        for slot, slottbl in pairs(self.Attachments) do
            if !slottbl.Installed then continue end

            local atttbl = TacRP.GetAttTable(slottbl.Installed)

            local att_priority = atttbl["Priority_" .. val] or 1

            if atttbl[val] != nil and att_priority > priority then
                stat = atttbl[val]
                priority = att_priority
            end
        end
    end

    for slot, slottbl in pairs(self.Attachments) do
        if !slottbl.Installed then continue end

        local atttbl = TacRP.GetAttTable(slottbl.Installed)

        local att_priority = atttbl["Override_Priority_" .. val] or 1

        if atttbl["Override_" .. val] != nil and att_priority > priority then
            stat = atttbl["Override_" .. val]
            priority = att_priority
        end

        if isnumber(stat) and atttbl["Add_" .. val] then
            stat = stat + atttbl["Add_" .. val] * (invert and -1 or 1)
        end

        if isnumber(stat) and atttbl["Mult_" .. val] then
            if invert then
                stat = stat / atttbl["Mult_" .. val]
            else
                stat = stat * atttbl["Mult_" .. val]
            end
        end
    end

    if self.IntegerStats[val] then
        stat = math.ceil(stat)
    end

    if !invert then
        self.StatCache[val] = stat
    end

    return stat
end