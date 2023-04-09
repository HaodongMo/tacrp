function TacRP.GetMoveVector(mv)
    local ang = mv:GetAngles()

    local max_speed = mv:GetMaxSpeed()

    local forward = math.Clamp(mv:GetForwardSpeed(), -max_speed, max_speed)
    local side = math.Clamp(mv:GetSideSpeed(), -max_speed, max_speed)

    local abs_xy_move = math.abs(forward) + math.abs(side)

    if abs_xy_move == 0 then
        return Vector(0, 0, 0)
    end

    local mul = max_speed / abs_xy_move

    local vec = Vector()

    vec:Add(ang:Forward() * forward)
    vec:Add(ang:Right() * side)

    vec:Mul(mul)

    return vec
end

function TacRP.GetCmdVector(cmd, defaultforward)
    local ang = Angle(0, cmd:GetViewAngles().y, 0)

    local forward = cmd:GetForwardMove() / 10000
    local side = cmd:GetSideMove() / 10000

    local abs_xy_move = math.abs(forward) + math.abs(side)
    if abs_xy_move == 0 then
        if defaultforward then
            forward = 1
        else
            return Vector()
        end
    end
    local div = (forward ^ 2 + side ^ 2) ^ 0.5

    local vec = Vector()
    vec:Add(ang:Forward() * forward / div)
    vec:Add(ang:Right() * side / div)

    return vec
end

function TacRP.CancelBodyDamage(ent, dmginfo, hitgroup)
    local tbl = TacRP.CancelMultipliers[string.lower(engine.ActiveGamemode())] or TacRP.CancelMultipliers[1]

    if IsValid(ent) and (ent:IsNPC() or ent:IsPlayer()) and GetConVar("tacrp_bodydamagecancel"):GetBool() then
        dmginfo:ScaleDamage(1 / (tbl[hitgroup] or 1))
    end

    -- Lambda Players call ScalePlayerDamage and cancel out hitgroup damage... except on the head
    if IsValid(ent) and ent.IsLambdaPlayer and hitgroup == HITGROUP_HEAD then
        dmginfo:ScaleDamage(1 / TacRP.CancelMultipliers[hitgroup])
    end

    return dmginfo
end

function TacRP.GetRandomWeapon(key)

end