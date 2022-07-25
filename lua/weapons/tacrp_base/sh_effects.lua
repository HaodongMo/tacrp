function SWEP:DoEffects()
    if !IsFirstTimePredicted() then return end
    local muzz_qca = self:GetQCAMuzzle()

    local data = EffectData()
    data:SetEntity(self)
    data:SetAttachment(muzz_qca)

    util.Effect( "TacRP_muzzleeffect", data )
end

function SWEP:GetQCAMuzzle()
    if self:GetValue("Akimbo") then
        if self:GetNthShot() % 2 == 0 then
            return 4
        else
            return 3
        end
    else
        return self:GetValue("QCA_Muzzle")
    end
end

function SWEP:GetQCAEject()
    if self:GetValue("Akimbo") then
        if self:GetNthShot() % 2 == 0 then
            return 6
        else
            return 7
        end
    else
        return self:GetValue("QCA_Eject")
    end
end

SWEP.EjectedShells = {}

function SWEP:DoEject()
    if !IsFirstTimePredicted() then return end
    if self:GetValue("EjectEffect") == 0 then return end

    local eject_qca = self:GetQCAEject()

    local data = EffectData()
    data:SetEntity(self)
    data:SetFlags(self:GetValue("EjectEffect"))
    data:SetAttachment(eject_qca)

    util.Effect( "TacRP_shelleffect", data )
end

function SWEP:GetTracerOrigin()
    local ow = self:GetOwner()
    local wm = !IsValid(ow) or !ow:IsPlayer() or !ow:GetViewModel():IsValid() or ow:ShouldDrawLocalPlayer()
    local att = self:GetQCAMuzzle()
    local muzz = self

    if !wm then
        muzz = ow:GetViewModel()
    end

    if muzz and muzz:IsValid() then
        local posang = muzz:GetAttachment(att)
        if !posang then return muzz:GetPos() end
        local pos = posang.Pos

        return pos
    end
end

function SWEP:GetMuzzleDevice(wm)
    if !wm and self:GetOwner():IsNPC() then return end

    local model = self.WModel
    local muzz = self

    if !wm then
        model = self.VModel
        muzz = self:GetVM()
    end

    if model then
        for i, k in pairs(model) do
            if k.IsMuzzleDevice then
                return k
            end
        end
    end

    return muzz
end

function SWEP:DrawEjectedShells()
    local newshells = {}

    for i, k in pairs(self.EjectedShells) do
        if !k:IsValid() then continue end

        k:DrawModel()
        table.insert(newshells, k)
    end

    self.EjectedShells = newshells
end