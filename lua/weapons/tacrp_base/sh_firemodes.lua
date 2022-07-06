function SWEP:SwitchFiremode()
    local fm = self:GetFiremode()

    fm = fm + 1

    if fm > #self:GetValue("Firemodes") then
        fm = 1
    end

    self:SetFiremode(fm)
end

function SWEP:GetFiremodeAmount()
    if self:GetValue("Firemodes") then
        return #self:GetValue("Firemodes")
    else
        return 1
    end
end

function SWEP:GetNextFiremode()
    if self:GetValue("Firemodes") then
        local fm = self:GetFiremode()

        fm = fm + 1

        if fm > #self:GetValue("Firemodes") then
            fm = 1
        end

        return self:GetValue("Firemodes")[fm]
    else
        return self:GetValue("Firemode")
    end
end

function SWEP:GetCurrentFiremode()
    if self:GetValue("Firemodes") then
        return self:GetValue("Firemodes")[self:GetFiremode()]
    else
        return self:GetValue("Firemode")
    end
end

function SWEP:ToggleSafety(onoff)
    onoff = onoff or !self:GetSafe()

    self:SetSafe(onoff)

    if onoff == true then
        self:ToggleBlindFire(false)
    end
end

local mat_1 = Material("tacrp/hud/firemode_1.png", "mips ignorez")
local mat_2 = Material("tacrp/hud/firemode_2.png", "mips ignorez")
local mat_3 = Material("tacrp/hud/firemode_3.png", "mips ignorez")
local mat_a = Material("tacrp/hud/firemode_a.png", "mips ignorez")
local mat_s = Material("tacrp/hud/firemode_s.png", "mips ignorez")

function SWEP:GetFiremodeMat(mode)
    if mode == 0 then
        return mat_s
    elseif mode == 1 then
        return mat_1
    elseif mode == 2 then
        return mat_a
    elseif mode == -2 then
        return mat_2
    elseif mode == -3 then
        return mat_3
    end
end