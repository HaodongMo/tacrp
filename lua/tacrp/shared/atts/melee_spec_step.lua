ATT.PrintName = "Airdash"
ATT.Icon = Material("entities/tacrp_att_acc_melee.png", "mips smooth")
ATT.Description = "Mobility tool used by blood-fueled robots and transgender women."
ATT.Pros = {"RELOAD: Dash in movement direction", "Invulnerable during dash"}

ATT.Category = {"melee_spec"}

ATT.SortOrder = 1

ATT.Hook_PreReload = function(wep)
    local ply = wep:GetOwner()

    if ply:GetNWFloat("TacRPDashTime", 0) + 0.25 > CurTime() or !ply:KeyPressed(IN_RELOAD) or ply:GetMoveType() == MOVETYPE_NOCLIP or ply:GetNWFloat("TacRPDashCharge", 0) < 1 / 3 then return end

    ply:SetNWFloat("TacRPDashCharge", ply:GetNWFloat("TacRPDashCharge", 0) - 1 / 3)
    ply:SetNWVector("TacRPDashDir", Vector())
    ply:SetNWFloat("TacRPDashTime", CurTime())

    if SERVER then
        ply:EmitSound("player/suit_sprint.wav", 80, 95)
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
    surface.DrawLine(x + w / 3, y, x + w / 3, y + h)
    surface.DrawLine(x + w / 3 * 2, y, x + w / 3 * 2, y + h)

end

hook.Add("SetupMove", "TacRP_Quickstep", function(ply, mv, cmd)
    if !IsFirstTimePredicted() then return end
    if ply:GetNWFloat("TacRPDashTime", 0) + 0.1 > CurTime() then
        if !ply.TacRPDashDir and !ply.TacRPDashCancel then
            ply.TacRPDashDir = TacRP.GetCmdVector(cmd, true)
            ply.TacRPDashStored = ply:GetVelocity():Length()
            ply.TacRPDashCancel = nil
            ply.TacRPDashPending = true
            ply.TacRPDashGrounded = ply:IsOnGround()

            local f, s = cmd:GetForwardMove(), cmd:GetSideMove()
            if math.abs(f + s) == 0 then f = 10000 end

            ply:ViewPunch(Angle(f / 2500, s / -5000, s / 2500))

            ply:SetVelocity(ply.TacRPDashDir * ply:GetRunSpeed() * 4)
        end

        if ply.TacRPDashGrounded and ply.TacRPDashCancel == nil and cmd:KeyDown(IN_JUMP) then
            --ply:SetVelocity(ply.TacRPDashDir * ply:GetRunSpeed() * 1 + Vector(0, 0, 5 * ply:GetJumpPower()))
            ply.TacRPDashGrounded = false
            ply.TacRPDashCancel = CurTime()
            ply:SetNWFloat("TacRPDashTime", 0)
        end
    elseif ply:GetNWFloat("TacRPDashTime", 0) + 0.1 <= CurTime() then
        if ply.TacRPDashCancel != nil and CurTime() - ply.TacRPDashCancel > 0 and !ply:IsOnGround() then
            ply:SetVelocity(ply:GetVelocity():GetNegated() + ply.TacRPDashDir * ply:GetRunSpeed() * 1.5 + Vector(0, 0, 2 * ply:GetJumpPower()))
            ply.TacRPDashCancel = nil
            ply.TacRPDashDir = nil
        elseif ply.TacRPDashDir and ply.TacRPDashCancel == nil then
            ply.TacRPDashDir = nil
            if !ply:IsOnGround() then
                ply:SetVelocity(ply:GetVelocity():GetNegated() / 1.5)
            end
        end
    end
end)

hook.Add("FinishMove", "TacRP_Quickstep", function(ply, mv)
    if ply:GetNWFloat("TacRPDashTime", 0) + 0.1 > CurTime() and ply.TacRPDashCancel == nil then
        local v = mv:GetVelocity()
        v.z = 0
        mv:SetVelocity(v)
    end
end)


hook.Add("EntityTakeDamage", "TacRP_Quickstep", function(ent, dmginfo)
    if !ent:IsPlayer() or ent:GetNWFloat("TacRPDashTime", 0) + 0.1 <= CurTime() then return end
    ent:EmitSound("weapons/fx/nearmiss/bulletltor0" .. math.random(3, 4) .. ".wav")
    return true
end)

hook.Add("PlayerSpawn", "TacRP_Quickstep", function(ply, trans)
    if trans then return end
    ply:SetNWFloat("TacRPDashCharge", 1)
    ply:SetNWFloat("TacRPNinjaSmoke", 0)
end)