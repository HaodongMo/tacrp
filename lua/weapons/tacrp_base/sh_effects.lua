function SWEP:DoEffects(alt, forceRight)
    if !IsFirstTimePredicted() then return end
    local muzz_qca, muzz_qca_wm = self:GetQCAMuzzle(alt, forceRight)

    local data = EffectData()
    data:SetEntity(self)
    data:SetAttachment(muzz_qca)
    data:SetHitBox(muzz_qca_wm or muzz_qca) // unused field (integer between 0-2047)

    util.Effect( "TacRP_muzzleeffect", data )
end

// forceRight: true = always right, false = always left, nil = use NthShot alternation
function SWEP:GetQCAMuzzle(alt, forceRight)
    if self:GetValue("EffectsAlternate") then
        local useRight = forceRight
        if forceRight == nil then
            useRight = self:GetNthShot() % 2 == (alt and 1 or 0)
        end

        if useRight then
            return self:GetValue("QCA_MuzzleR"), self:GetValue("WM_QCA_MuzzleR")
        else
            return self:GetValue("QCA_MuzzleL"), self:GetValue("WM_QCA_MuzzleL")
        end
    else
        return self:GetValue("QCA_Muzzle"), self:GetValue("WM_QCA_Muzzle")
    end
end

// forceRight: true = always right, false = always left, nil = use NthShot alternation
function SWEP:GetQCAEject(alt, forceRight)
    if self:GetValue("EffectsAlternate") then
        local useRight = forceRight
        if forceRight == nil then
            useRight = self:GetNthShot() % 2 == (alt and 1 or 0)
        end

        if useRight then
            return self:GetValue("QCA_EjectR"), self:GetValue("WM_QCA_EjectR")
        else
            return self:GetValue("QCA_EjectL"), self:GetValue("WM_QCA_EjectL")
        end
    else
        return self:GetValue("QCA_Eject"), self:GetValue("WM_QCA_Eject")
    end
end

SWEP.EjectedShells = {}

function SWEP:DoEject(alt, forceRight)
    if !IsFirstTimePredicted() then return end
    if self:GetValue("EjectEffect") == 0 then return end

    local eject_qca, eject_qca_wm = self:GetQCAEject(alt, forceRight)

    local data = EffectData()
    data:SetEntity(self)
    data:SetFlags(self:GetValue("EjectEffect"))
    data:SetAttachment(eject_qca)
    data:SetHitBox(eject_qca_wm or eject_qca) // unused field (integer between 0-2047)
    data:SetScale(self:GetValue("EjectScale"))

    util.Effect( "TacRP_shelleffect", data )
end

function SWEP:GetTracerOrigin()
    local ow = self:GetOwner()
    local wm = !IsValid(ow) or !ow:IsPlayer() or !ow:GetViewModel():IsValid() or (ow != LocalPlayer() and ow != LocalPlayer():GetObserverTarget()) or (ow == LocalPlayer() and ow:ShouldDrawLocalPlayer())
    // For DualAkimbo, use LastFiredRight NWVar to determine which muzzle to use
    local forceRight = nil
    if self:GetValue("DualAkimbo") then
        forceRight = self:GetLastFiredRight()
    end
    local att = self:GetQCAMuzzle(nil, forceRight)
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

function SWEP:GetMuzzleDevice(wm, att)
    if !wm and self:GetOwner():IsNPC() then return end

    local model = self.WModel
    local muzz = self

    if !wm then
        model = self.VModel
        muzz = self:GetVM()
    end

    if model then
        // For akimbo weapons with dual muzzle devices, determine which one based on attachment
        local wantLeft = nil
        local wantRight = nil

        if att and self:GetValue("Akimbo") then
            local qcaL = wm and self:GetValue("WM_QCA_MuzzleL") or self:GetValue("QCA_MuzzleL")
            local qcaR = wm and self:GetValue("WM_QCA_MuzzleR") or self:GetValue("QCA_MuzzleR")

            if att == qcaL then
                wantLeft = true
            elseif att == qcaR then
                wantRight = true
            end
        end

        // First pass: look for matching left/right muzzle device
        if wantLeft or wantRight then
            for i, k in pairs(model) do
                if k.IsMuzzleDevice then
                    if wantLeft and k.IsLeftMuzzle then
                        return k
                    elseif wantRight and k.IsRightMuzzle then
                        return k
                    end
                end
            end
        end

        // Fallback: return any muzzle device
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