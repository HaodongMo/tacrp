local rt_w = 426
local rt_h = 240

local rtmat = GetRenderTarget("tacrp_pipscope", rt_w, rt_h, false)

local lastblindfire = false
local blindfiretime = 0

local csm_boot_1 = Material("tacrp/hud/cornershot_boot_1.png", "mips smooth")
local csm_boot_2 = Material("tacrp/hud/cornershot_boot_2.png", "mips smooth")
local csm_boot_3 = Material("tacrp/hud/cornershot_boot_3.png", "mips smooth")

local csm_1 = Material("tacrp/hud/cornershot_1.png", "mips smooth")
local csm_2 = Material("tacrp/hud/cornershot_2.png", "mips smooth")

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

function SWEP:DoRT()
    if !self:GetBlindFire() then lastblindfire = false return end
    if TacRP.OverDraw then return end

    if !lastblindfire then
        blindfiretime = 0
    end

    if lastrendertime > CurTime() - (1 / fps) then return end

    local rt = {
        x = 0,
        y = 0,
        w = rt_w,
        h = rt_h,
        angles = self:GetShootDir(),
        origin = self:GetMuzzleOrigin(),
        drawviewmodel = false,
        fov = 40,
    }

    render.PushRenderTarget(rtmat, 0, 0, rt_w, rt_h)

    if blindfiretime >= 1 or blindfiretime == 0 then
        TacRP.OverDraw = true
        render.RenderView(rt)
        TacRP.OverDraw = false
    end

    DrawColorModify({
        ["$pp_colour_addr"] = 0.25 * 132 / 255,
        ["$pp_colour_addg"] = 0.25 * 169 / 255,
        ["$pp_colour_addb"] = 0.25 * 154 / 255,
        ["$pp_colour_brightness"] = 0.2,
        ["$pp_colour_contrast"] = 0.85,
        ["$pp_colour_colour"] = 0.95,
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0
    })

    -- if blindfiretime < 0.33 then
    --     surface.SetMaterial(csm_boot_1)
    -- elseif blindfiretime < 0.66 then
    --     surface.SetMaterial(csm_boot_2)
    -- elseif blindfiretime < 1.25 then
    --     surface.SetMaterial(csm_boot_3)
    -- else
    -- end

    cam.Start2D()

    if blindfiretime < 1 then
        if blindfiretime < 0.75 then
            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(noisemats[math.random(#noisemats)])
            surface.DrawTexturedRect(0, 0, rt_w, rt_h)
        else
            surface.SetDrawColor(0, 0, 0)
            surface.DrawRect(0, 0, rt_w, rt_h)
        end

        DrawColorModify({
            ["$pp_colour_addr"] = 0.25 * 132 / 255,
            ["$pp_colour_addg"] = 0.25 * 169 / 255,
            ["$pp_colour_addb"] = 0.25 * 154 / 255,
            ["$pp_colour_brightness"] = 0.2,
            ["$pp_colour_contrast"] = 0.85,
            ["$pp_colour_colour"] = 0.95,
            ["$pp_colour_mulr"] = 0,
            ["$pp_colour_mulg"] = 0,
            ["$pp_colour_mulb"] = 0
        })
    end

    if blindfiretime < 0.2 then
        surface.SetMaterial(csm_boot_1)
    elseif blindfiretime < 0.4 then
        surface.SetMaterial(csm_boot_2)
    elseif blindfiretime < 0.6 then
        surface.SetMaterial(csm_boot_3)
    else
        if math.sin(CurTime() * 3) > 0.5 then
            surface.SetMaterial(csm_1)
        else
            surface.SetMaterial(csm_2)
        end
    end

    surface.SetDrawColor(255, 255, 255)
    surface.DrawTexturedRect(0, 0, rt_w, rt_h)
    cam.End2D()

    render.PopRenderTarget()

    blindfiretime = blindfiretime + (math.random(0, 5) * math.random(0, 5) * (1 / fps) / 6.25)

    lastblindfire = true
    lastrendertime = CurTime()
end

function SWEP:DoCornershot()

    if !self:GetBlindFire() then lastblindfire = false return end

    local w = ScreenScale(640 / 4)
    local h = ScreenScale(480 / 4)
    local x = (ScrW() - w) / 2
    local y = (ScrH() - h) / 2
    y = y + (ScrH() / 4)
    render.DrawTextureToScreenRect(rtmat, x, y, w, h)
end