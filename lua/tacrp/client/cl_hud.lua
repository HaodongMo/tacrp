local mat_corner_ul = Material("TacRP/hud/800corner_nobg1.png", "mips smooth")
local mat_corner_ur = Material("TacRP/hud/800corner_nobg2.png", "mips smooth")
local mat_corner_br = Material("TacRP/hud/800corner_nobg3.png", "mips smooth")
local mat_corner_bl = Material("TacRP/hud/800corner_nobg4.png", "mips smooth")

function TacRP.DrawCorneredBox(x, y, w, h, col)
    col = col or Color(255, 255, 255)

    surface.DrawRect(x, y, w, h)

    surface.SetDrawColor(col)

    local s = 8

    surface.SetMaterial(mat_corner_ul)
    surface.DrawTexturedRect(x, y, s, s)

    surface.SetMaterial(mat_corner_ur)
    surface.DrawTexturedRect(x + w - s, y, s, s)

    surface.SetMaterial(mat_corner_bl)
    surface.DrawTexturedRect(x, y + h - s, s, s)

    surface.SetMaterial(mat_corner_br)
    surface.DrawTexturedRect(x + w - s, y + h - s, s, s)
end