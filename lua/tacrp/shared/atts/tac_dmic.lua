ATT.PrintName = "Radar"
ATT.Icon = Material("entities/tacrp_att_tac_dmic.png", "mips smooth")
ATT.Description = "Detects the position of nearby targets, but emits sound."
ATT.Pros = {"Display nearby targets"}
ATT.Cons = {"Audible to others"}

ATT.Model = "models/weapons/tacint/addons/dmic_mounted.mdl"
ATT.Scale = 1

ATT.Category = "tactical"

ATT.Minimap = true
ATT.CanToggle = true

local scantime = 1.5
local lastradar = 0
local cache_lastradarpositions
local mat_radar = Material("tacrp/hud/radar.png", "smooth")
local mat_radar_active = Material("tacrp/hud/radar_active.png", "mips smooth")
local mat_dot = Material("tacrp/hud/dot.png", "mips smooth")
local mat_tri = Material("tacrp/hud/triangle.png", "mips smooth")
function ATT.TacticalDraw(self)
    local scrw = ScrW()
    local scrh = ScrH()

    local w = ScreenScale(100)
    local h = ScreenScale(100)

    local x = (scrw - w) / 2
    local y = (scrh - h) * 0.99

    surface.SetMaterial(mat_radar)
    surface.SetDrawColor(255, 255, 255, 100)
    surface.DrawTexturedRect(x, y, w, h)

    local radarpositions = {}

    if lastradar + scantime > CurTime() then
        radarpositions = cache_lastradarpositions
    else
        local tbl = ents.FindInSphere(self:GetOwner():GetPos(), 50 / TacRP.HUToM)

        local i = 0
        for _, ent in ipairs(tbl) do
            if !((ent:IsPlayer() and ent:Alive()) or (ent:IsNPC() and ent:Health() > 0) or ent:IsNextBot()) then continue end
            if ent == self:GetOwner() then continue end

            local ang = self:GetOwner():EyeAngles()

            ang.y = ang.y + 90
            ang.p = 0
            ang.r = 0

            local relpos = WorldToLocal(ent:GetPos(), Angle(0, 0, 0), self:GetOwner():GetPos(), ang)

            local read = {
                x = -relpos.x,
                y = relpos.y,
                z = relpos.z,
            }

            table.insert(radarpositions, read)
            i = i + 1
        end

        lastradar = CurTime()
        cache_lastradarpositions = radarpositions

        if !GetConVar("tacrp_radar_quiet"):GetBool() then
            LocalPlayer():EmitSound("plats/elevbell1.wav", 60, 95 + math.min(i, 3) * 5, 0.1 + math.min(i, 3) * 0.05)
        end
    end

    surface.SetDrawColor(0, 0, 0, 255 * 2 * (1 - ((CurTime() - lastradar) / scantime)))
    surface.SetMaterial(mat_radar_active)
    surface.DrawTexturedRect(x, y, w, h)
    -- surface.SetDrawColor(255, 255, 255, 255)

    local ds = ScreenScale(4)

    for _, dot in ipairs(radarpositions) do
        local dx = x + (dot.x * TacRP.HUToM * w * (36 / 40) / 100) + (w / 2)
        local dy = y + (dot.y * TacRP.HUToM * h * (36 / 40) / 100) + (h / 2)

        local gs = ScreenScale(8)

        dx = math.Round(dx / (w / gs)) * (w / gs)
        dy = math.Round(dy / (h / gs)) * (h / gs)

        dx = dx - ScreenScale(0.5)
        dy = dy - ScreenScale(0.5)

        if math.abs(dot.z) > 128 then
            surface.SetMaterial(mat_tri)
            surface.DrawTexturedRectRotated(dx, dy, ds, ds, dot.z > 0 and 0 or 180)
        else
            surface.SetMaterial(mat_dot)
            surface.DrawTexturedRect(dx - (ds / 2), dy - (ds / 2), ds, ds)
        end
    end
end

function ATT.TacticalThink(self)
    if IsValid(self:GetOwner()) and self:GetTactical() and (SERVER and !game.SinglePlayer()) and (self.NextRadarBeep or 0) < CurTime() then
        self.NextRadarBeep = CurTime() + 1.5
        local f = RecipientFilter()
        f:AddPVS(self:GetPos())
        f:RemovePlayer(self:GetOwner())
        local s = CreateSound(self, "plats/elevbell1.wav", f)
        s:SetSoundLevel(75)
        s:PlayEx(0.25, 105)
    end
end