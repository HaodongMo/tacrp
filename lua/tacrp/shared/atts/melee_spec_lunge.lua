ATT.PrintName = "Frenzy"
ATT.Icon = Material("entities/tacrp_att_acc_melee.png", "mips smooth")
ATT.Description = "Close the distance and ensnare your enemies."
ATT.Pros = {"RELOAD (Ground): Lunge forwards", "RELOAD (Mid-Air): Lunge towards point of aim", "Slow on Hit"}

ATT.Category = {"melee_spec"}

ATT.SortOrder = 3

ATT.MeleeSlow = true

ATT.Hook_PreReload = function(wep)
    local ply = wep:GetOwner()

    if !ply:KeyPressed(IN_RELOAD) or ply:GetNWFloat("TacRPDashCharge", 0) < 0.5 then return end

    ply:SetNWFloat("TacRPDashCharge", ply:GetNWFloat("TacRPDashCharge", 0) - 0.5)

    local ang = Angle(0, ply:GetAngles().y, 0)

    if SERVER then
        ply:EmitSound("npc/fast_zombie/leap1.wav", 80, 105)
    end

    if ply:IsOnGround() then
        ply:SetVelocity(ang:Forward() * 600 + Vector(0, 0, 250))
    else
        local dot = ply:GetAngles():Forward():Dot(ply:GetVelocity():GetNormalized())
        if dot < 0.5 then
            ply:SetVelocity(-ply:GetVelocity() + ply:GetAngles():Forward() * 500)
        else
            ply:SetVelocity(ply:GetAngles():Forward() * 400)
        end
    end

    return true
end

ATT.Hook_PostThink = function(wep)
    local ply = wep:GetOwner()
    if (game.SinglePlayer() or IsFirstTimePredicted()) and ply:GetNWFloat("TacRPDashTime", 0) + 0.3 < CurTime() then
        ply:SetNWFloat("TacRPDashCharge", math.min(1, ply:GetNWFloat("TacRPDashCharge", 0) + FrameTime() / 7.5))
    end
end

function ATT.TacticalDraw(self)
    local scrw = ScrW()
    local scrh = ScrH()

    local w = ScreenScale(128)
    local h = ScreenScale(8)

    local x = (scrw - w) / 2
    local y = (scrh - h) * 7 / 8

    surface.SetDrawColor(0, 0, 0, 100)
    TacRP.DrawCorneredBox(x, y, w, h)

    x = x + ScreenScale(1)
    y = y + ScreenScale(1)
    w = w - ScreenScale(2)
    h = h - ScreenScale(2)

    local c = math.Clamp(self:GetOwner():GetNWFloat("TacRPDashCharge", 0), 0, 1)

    surface.SetDrawColor(255, 255, 255, 100)
    surface.DrawRect(x, y, w * c, h)

    surface.SetDrawColor(255, 255, 255, 200)
    surface.DrawLine(x + w * 0.5, y, x + w * 0.5, y + h)
end
