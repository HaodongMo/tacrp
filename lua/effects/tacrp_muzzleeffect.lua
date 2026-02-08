function EFFECT:Init(data)
    local wpn = data:GetEntity()

    if !IsValid(wpn) then self:Remove() return end

    if wpn:GetOwner() == LocalPlayer() and wpn:GetValue("ScopeHideWeapon") and wpn:IsInScope() then
        self:Remove()
        return
    end

    local muzzle = TacRP.MuzzleEffects[data:GetFlags() or 1] or "muzzleflash_pistol"
    if wpn.GetValue then
        muzzle = wpn:GetValue("MuzzleEffect")
    end

    local att = data:GetAttachment() or 1

    local wm = false

    if (LocalPlayer():ShouldDrawLocalPlayer() or wpn.Owner != LocalPlayer()) then
        wm = true
        att = data:GetHitBox()
    end

    local parent = wpn

    if !wm then
        parent = LocalPlayer():GetViewModel()
    end

    if wpn.GetMuzzleDevice then
        parent = wpn:GetMuzzleDevice(wm, att)
    else
        parent = self
    end

    -- if !IsValid(parent) then return end

    if muzzle then
        if !istable(muzzle) then
            muzzle = {muzzle}
        end

        for _, muzzleeffect in ipairs(muzzle) do
            local pcf = CreateParticleSystem(muz or parent, muzzleeffect, PATTACH_POINT_FOLLOW, att)

            if IsValid(pcf) then
                pcf:StartEmission()

                if (muz or parent) != vm and !wm then
                    pcf:SetShouldDraw(false)
                    table.insert(wpn.MuzzPCFs, pcf)
                end
            end
        end
    end
end

function EFFECT:Think()
    return false
end

function EFFECT:Render()
    return false
end