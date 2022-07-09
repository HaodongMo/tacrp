SWEP.StatCache = {}
SWEP.HookCache = {}

SWEP.ExcludeFromRawStats = {
    ["PrintName"] = true,
    ["Description"] = true
}

SWEP.IntegerStats = {
    ["ClipSize"] = true
}

function SWEP:RunHook(val, data)
    if self.HookCache[val] then
        for _, chook in pairs(self.HookCache[val]) do

            local d = chook(self, data)

            if d != nil then
                data = d
            end
        end

        return data
    end

    self.HookCache[val] = {}

    for slot, slottbl in pairs(self.Attachments) do
        if !slottbl.Installed then continue end

        local atttbl = TacRP.GetAttTable(slottbl.Installed)

        if atttbl[val] then

            table.insert(self.HookCache[val], atttbl[val])

            local d = atttbl[val](self, data)

            if d != nil then
                data = d
            end
        end
    end

    return data
end

function SWEP:GetValue(val)
    local tbl = self:GetTable()

    local stat = tbl[val]

    if self.StatCache[val] then
        return self.StatCache[val]
    end

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
    end

    for slot, slottbl in pairs(self.Attachments) do
        if !slottbl.Installed then continue end

        local atttbl = TacRP.GetAttTable(slottbl.Installed)

        if stat then
            if atttbl["Add_" .. val] then
                stat = stat + atttbl["Add_" .. val]
            end
        end
    end

    for slot, slottbl in pairs(self.Attachments) do
        if !slottbl.Installed then continue end

        local atttbl = TacRP.GetAttTable(slottbl.Installed)

        if stat then
            if atttbl["Mult_" .. val] then
                stat = stat * atttbl["Mult_" .. val]
            end
        end
    end

    if self.IntegerStats[val] then
        stat = math.Round(stat)
    end

    self.StatCache[val] = stat

    return stat
end