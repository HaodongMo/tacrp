ATT.PrintName = "Airdash"
ATT.Icon = Material("entities/tacrp_att_acc_melee.png", "mips smooth")
ATT.Description = "Mobility tool used by blood-fueled robots and transgender women."
ATT.Pros = {"RELOAD: Dash in movement direction", "Dash redirects momentum"}

ATT.Category = {"melee_spec"}

ATT.SortOrder = 1

ATT.Hook_PreReload = function(wep)
    local ply = wep:GetOwner()

    if ply:GetNWFloat("TacRPDashTime", 0) + 0.3 > CurTime() or !ply:KeyPressed(IN_RELOAD) or ply:GetNWFloat("TacRPDashCharge", 0) < 1 / 3 then return end

    ply:SetNWFloat("TacRPDashCharge", ply:GetNWFloat("TacRPDashCharge", 0) - 1 / 3)
    ply:SetNWVector("TacRPDashDir", Vector())
    ply:SetNWFloat("TacRPDashTime", CurTime())
    ply:SetNWBool("TacRPDashGrounded", ply:IsOnGround())

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

-- safe to use since Move is followed up by FinishMove immediately... or so they say
hook.Add("Move", "TacRP_Quickstep", function(ply, mv)
    if ply:GetNWFloat("TacRPDashTime", 0) + 0.1 > CurTime() then

        if ply:GetNWVector("TacRPDashDir", Vector()) == Vector() then
            local ang = Angle(0, mv:GetAngles().y, 0)
            local vel = Vector()
            vel:Add(ang:Forward() * mv:GetForwardSpeed())
            vel:Add(ang:Right() * mv:GetSideSpeed())
            vel:Add(ang:Up() * mv:GetUpSpeed())
            if vel:LengthSqr() == 0 then vel = ang:Forward() end
            vel:Normalize()
            ply:SetNWFloat("TacRPDashStored", ply:GetVelocity():Length())
            ply:SetNWVector("TacRPDashDir", vel)
        end

        if mv:KeyPressed(IN_JUMP) then -- ply:IsOnGround() and
            -- cancel the dash
            local buffer = CurTime() - ply:GetNWFloat("TacRPDashTime", 0)
            local v = ply:GetNWVector("TacRPDashDir") * 500 --(250 + math.max(250, math.min(ply:GetRunSpeed(), ply:GetNWFloat("TacRPDashStored"))))

            mv:SetVelocity(v)
            mv:SetButtons(bit.band(mv:GetButtons(), bit.bnot(IN_JUMP)))

            ply:SetNWFloat("TacRPDashTime", 0)
            ply:SetNWVector("TacRPDashDir", Vector())

            -- Cancel sandbox jump boost.
            -- if player_manager.GetPlayerClass(ply) == "player_sandbox" and bit.band( mv:GetOldButtons(), IN_JUMP ) == 0 and ply:OnGround() then
            --     local forward = ply:GetNWVector("TacRPDashDir")
            --     local speedBoostPerc = ( ( !ply:Crouching() ) and 0.5 ) or 0.1
            --     local speedAddition = math.abs( mv:GetForwardSpeed() * speedBoostPerc )
            --     local maxSpeed = mv:GetMaxSpeed() * ( 1 + speedBoostPerc )
            --     local newSpeed = speedAddition + mv:GetVelocity():Length2D()
            --     if newSpeed > maxSpeed then
            --         speedAddition = speedAddition - (newSpeed - maxSpeed)
            --     end
            --     if mv:GetVelocity():Dot(forward) < 0 then
            --         speedAddition = -speedAddition
            --     end

            --     print(speedAddition)
            --     v = v - speedAddition * forward * 1
            --     --mv:SetVelocity(mv:GetVelocity() + speedAddition * forward * 1)
            -- end

        else
            local d = (1 - ((CurTime() - ply:GetNWFloat("TacRPDashTime", 0)) / 0.1))
            mv:SetVelocity(ply:GetNWVector("TacRPDashDir") * FrameTime() * 600 * d * math.max(ply:GetRunSpeed(), 250))
        end
    elseif ply:GetNWVector("TacRPDashDir", Vector()) != Vector() then
        mv:SetVelocity(math.min(ply:GetRunSpeed(), ply:GetNWFloat("TacRPDashStored")) * ply:GetNWVector("TacRPDashDir"))
        ply:SetNWVector("TacRPDashDir", Vector())
    end
end)

hook.Add("PlayerSpawn", "TacRP_Quickstep", function(ply)
    ply:SetNWFloat("TacRPDashCharge", 1)
end)