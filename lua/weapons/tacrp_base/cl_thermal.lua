local rt_w = 240
local rt_h = 240

local rtmat = GetRenderTarget("tacrp_pipscope_thermal", rt_w, rt_h, false)

local lastthermalscope = false
local thermaltime = 0

local csm_boot_1 = Material("tacrp/hud/thermal_boot_1.png", "mips smooth")

local csm_1 = Material("tacrp/hud/thermal_1.png", "mips smooth")

local noise1 = Material("tacrp/hud/noise1.png")
local noise2 = Material("tacrp/hud/noise2.png")
local noise3 = Material("tacrp/hud/noise3.png")
local noise4 = Material("tacrp/hud/noise4.png")

local noisemats = {
    noise1,
    noise2,
    noise3,
    noise4
}

local lastrendertime = 0

local fps = 30

function SWEP:DoThermalRT()
    if self:GetScopeLevel() <= 0 or !self:GetPeeking() then lastthermalscope = false return end
    if TacRP.OverDraw then return end

    if !lastthermalscope then
        thermaltime = 0
    end

    if lastrendertime > CurTime() - (1 / fps) then return end

    local angles = self:GetShootDir()
    local origin = self:GetMuzzleOrigin()

    local rt = {
        x = 0,
        y = 0,
        w = rt_w,
        h = rt_h,
        aspect = 0.999,
        angles = angles,
        origin = origin,
        drawviewmodel = false,
        fov = 20,
        znear = 6
    }

    render.PushRenderTarget(rtmat, 0, 0, rt_w, rt_h)

    if thermaltime >= 0.75 or thermaltime == 0 then
        TacRP.OverDraw = true
        render.RenderView(rt)
        TacRP.OverDraw = false
    end

    DrawColorModify({
        ["$pp_colour_addr"] = 0.25 * 132 / 255,
        ["$pp_colour_addg"] = 0.25 * 169 / 255,
        ["$pp_colour_addb"] = 0.25 * 154 / 255,
        ["$pp_colour_brightness"] = 0.7,
        ["$pp_colour_contrast"] = 0.75,
        ["$pp_colour_colour"] = 0,
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0
    })

    if thermaltime >= 0.75 then
        local thermalents = ents.FindInCone(origin, angles:Forward(), 10000, 0.939692620) // 20 degrees

        render.SuppressEngineLighting(true)
        render.SetBlend(0.9)
        render.SetColorModulation(250, 0, 0)

        cam.Start3D(origin, angles, 20)

        for _, ent in ipairs(thermalents) do
            if ent == self:GetOwner() then continue end
            if !ent:IsValid() or ent:IsWorld() then continue end
            if ent:Health() <= 0 then continue end
            if ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() or ent:IsOnFire() then
                ent:DrawModel()
            end
            if ent:IsVehicle() or ent:IsOnFire() or ent.ArcCW_Hot or ent:IsScripted() and !ent:GetOwner():IsValid() then
                ent:DrawModel()
            end
        end

        cam.End3D()

        render.SetColorModulation(1, 1, 1)
        render.SuppressEngineLighting(false)
        render.MaterialOverride()
        render.SetBlend(1)
    end

    DrawBloom(0.25, 0.5, 8, 8, 1, 1, 0, 0, 0)

    cam.Start2D()

    render.ClearDepth()

    if thermaltime < 0.75 then
        surface.SetDrawColor(0, 0, 0)
        surface.DrawRect(0, 0, rt_w, rt_h)
    end

    if thermaltime < 0.45 then
        surface.SetMaterial(csm_boot_1)
    else
        surface.SetMaterial(csm_1)
    end

    surface.SetDrawColor(255, 255, 255)
    surface.DrawTexturedRect(0, 0, rt_w, rt_h)
    cam.End2D()

    render.PopRenderTarget()

    thermaltime = thermaltime + (math.random(0, 5) * math.random(0, 5) * (1 / fps) / 6.25)

    lastthermalscope = true
    lastrendertime = CurTime()
end

function SWEP:DoThermalCam()
    if self:GetScopeLevel() <= 0 or !self:GetPeeking() then lastthermalscope = false return end

    local w = TacRP.SS(480 / 4)
    local h = TacRP.SS(480 / 4)
    local x = (ScrW() - w) / 2
    local y = (ScrH() - h) / 2

    render.DrawTextureToScreenRect(rtmat, x, y, w, h)
end