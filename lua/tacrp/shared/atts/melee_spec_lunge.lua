ATT.PrintName = "Frenzy"
ATT.Icon = Material("entities/tacrp_att_melee_spec_lunge.png", "mips smooth")
ATT.Description = "Close the distance and overwhelm your enemies."
ATT.Pros = {"RELOAD (Ground): Pounce", "RELOAD (Ground + Crouch): Super Jump", "RELOAD (Mid-Air): Lunge", "Heal on hit"}

ATT.Category = {"melee_spec"}

ATT.SortOrder = 3

ATT.Lifesteal = 1 / 4

ATT.Hook_GetHintCapabilities = function(self, tbl)
    tbl["+reload"] = {so = 0.4, str = "Pounce / Lunge"}
    tbl["+duck/+reload"] = {so = 0.5, str = "Super Jump"}
end

local chargeamt = 0.5

local function makesound(ent, pitch)
    if TacRP.ShouldWeFunny() then
        ent:EmitSound("tacrp/amongus_loud.mp3", 75, pitch)
    else
        ent:EmitSound("npc/fast_zombie/leap1.wav", 75, pitch)
    end
end

ATT.Hook_PreReload = function(wep)
    local ply = wep:GetOwner()

    if !ply:KeyPressed(IN_RELOAD) or ply:GetMoveType() == MOVETYPE_NOCLIP or ply:GetNWFloat("TacRPDashCharge", 0) < chargeamt or (ply.TacRPNextLunge or 0) > CurTime() then return end

    ply.TacRPNextLunge = CurTime() + 1.5
    ply:SetNWFloat("TacRPDashCharge", ply:GetNWFloat("TacRPDashCharge", 0) - chargeamt)
    ply:SetNWFloat("TacRPLastLeap", CurTime())

    local ang = Angle(0, ply:GetAngles().y, 0)
    local vel

    if ply:IsOnGround() and ply:Crouching() then
        local ang2 = ply:GetAngles()
        ang2.p = math.min(-70, ang2.p)
        vel = ang2:Forward() * 800
        if SERVER then
            ply:EmitSound("physics/concrete/boulder_impact_hard" .. math.random(1, 4) .. ".wav", 70, 120, 0.5)
            makesound(ply, 100)
        end
    elseif ply:IsOnGround() then
        vel = ang:Forward() * (400 + math.max(0, 500 - ang:Forward():Dot(ply:GetVelocity()))) + Vector(0, 0, 300)
        if SERVER then
            makesound(ply, 92)
        end
    else
        local int = math.Clamp(ply:GetVelocity():Dot(ply:GetAngles():Forward()) ^ 0.9, 0, 500)
        vel = ply:GetVelocity() * -1 + ply:GetAngles():Forward() * (int + 600)
        if SERVER then
            makesound(ply, 110)
        end
    end

    ply:ViewPunch(Angle(-5, 0, 0))

    ply:DoCustomAnimEvent(PLAYERANIMEVENT_JUMP, -1)

    ply:SetVelocity(vel)

    -- so client can draw the effect. blehhhh
    if game.SinglePlayer() and SERVER then wep:CallOnClient("Reload") end

    local eff = EffectData()
    eff:SetOrigin(ply:GetPos())
    eff:SetNormal(vel:GetNormalized())
    eff:SetEntity(ply)
    util.Effect("tacrp_leapsmoke", eff)

    return true
end

ATT.Hook_PostThink = function(wep)
    local ply = wep:GetOwner()
    if (game.SinglePlayer() or IsFirstTimePredicted()) and ply:GetNWFloat("TacRPLastLeap", 0) + 1 < CurTime() then
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
    surface.DrawLine(x + w * chargeamt, y, x + w * chargeamt, y + h)
end