function SWEP:DoBodygroups(wm, custom_wm)
    if !wm and !IsValid(self:GetOwner()) then return end
    if !wm and self:GetOwner():IsNPC() then return end

    local dbg = self:GetValue("DefaultBodygroups")

    local mdl

    if wm then
        mdl = custom_wm or self
        dbg = self:GetValue("DefaultWMBodygroups")
    else
        mdl = self:GetVM()
    end

    if !IsValid(mdl) then return end

    mdl:SetBodyGroups(dbg or "")

    local eles = self:GetElements()

    for i, k in pairs(eles) do
        if wm then
            for _, j in pairs(k.BGs_WM or {}) do
                mdl:SetBodygroup(j[1], j[2])
            end
        else
            for _, j in pairs(k.BGs_VM or {}) do
                mdl:SetBodygroup(j[1], j[2])
            end
        end
    end

    local bbg = self:GetValue("BulletBodygroups")

    if bbg then
        local amt = self:Clip1()

        if self:GetReloading() then
            amt = self:GetLoadedRounds()
        end

        for c, bgs in pairs(bbg) do
            if amt < c then
                mdl:SetBodygroup(bgs[1], bgs[2])
                break
            end
        end
    end
end

function SWEP:GetElements(holster)
    local eles = {}

    for i, k in pairs(self.Attachments) do
        if k.Installed then
            table.Add(eles, k.InstalledElements or {})

            local atttbl = TacRP.GetAttTable(k.Installed)

            table.Add(eles, atttbl.InstalledElements or {})
        else
            table.Add(eles, k.UnInstalledElements or {})
        end
    end
    local eleatts = {}

    for i, k in pairs(eles) do
        if self.AttachmentElements then
            table.insert(eleatts, self.AttachmentElements[k])
        end
    end

    table.sort(eleatts, function(a, b)
        return (a.SortOrder or 1) < (b.SortOrder or 1)
    end)

    return eleatts
end

function SWEP:DoBulletBodygroups()
    self:DoBodygroups(false)
end