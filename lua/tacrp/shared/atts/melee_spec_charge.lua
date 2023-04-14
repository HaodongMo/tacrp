ATT.PrintName = "Charge"
ATT.FullName = "demoknight tf2"
ATT.Icon = Material("entities/tacrp_att_melee_spec_charge.png", "mips smooth")
ATT.Description = "demoknight tf2 demoknight tf2 demoknight tf2 demoknight tf2"
ATT.Pros = {"RELOAD: Charge forwards", "Bonus damage after impact or during charge"}
ATT.Cons = {"Limited turn control"}

ATT.Category = {"melee_spec"}

ATT.SortOrder = 5

ATT.KnifeCharge = true

local chargedur = 1.5
local followup = 0.75

local function wishspeedthreshold()
    return 100 * GetConVar("sv_friction"):GetFloat() / GetConVar("sv_accelerate"):GetFloat()
end

ATT.Hook_PreShoot = function(wep)
    local ply = wep:GetOwner()

    if ply:GetNWFloat("TacRPChargeTime", 0) + chargedur + followup > CurTime() then
        wep:Melee(true)
        ply:SetNWFloat("TacRPChargeTime", 0)
        return true
    elseif ply:GetNWFloat("TacRPChargeFollowup", 0) > CurTime() then
        wep:Melee(true)
        ply:SetNWFloat("TacRPChargeFollowup", 0)
        return true
    end
end

ATT.Hook_PreReload = function(wep)
    if !IsFirstTimePredicted() then return end

    local ply = wep:GetOwner()

    if ply:GetNWFloat("TacRPChargeTime", 0) + 0.25 > CurTime() or !ply:KeyPressed(IN_RELOAD) or ply:GetMoveType() == MOVETYPE_NOCLIP or ply:GetNWFloat("TacRPCharge", 0) < 1 then return end

    ply:SetNWFloat("TacRPCharge", 0)
    ply:SetNWVector("TacRPChargeDir", Vector())
    ply:SetNWFloat("TacRPChargeTime", CurTime())

    wep:SetHoldType("melee2")

    wep:SetTimer(chargedur, function()
        wep:SetShouldHoldType()
    end)

    ply:EmitSound("TacRP.Charge.Windup", 80)

    if game.SinglePlayer() then
        wep:CallOnClient("Reload")
    end

    return true
end

ATT.Hook_PostThink = function(wep)
    local ply = wep:GetOwner()
    if (game.SinglePlayer() or IsFirstTimePredicted()) and ply:GetNWFloat("TacRPChargeTime", 0) + chargedur < CurTime() then
        ply:SetNWFloat("TacRPCharge", math.min(1, ply:GetNWFloat("TacRPCharge", 0) + FrameTime() / 1))
    end
end

local function ChargeFraction(ply)
    local g = 0.25
    return 1 - math.Clamp((ply:GetNWFloat("TacRPChargeTime", 0) + chargedur - CurTime()) / chargedur, 0, 1)
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

    local c = math.Clamp(self:GetOwner():GetNWFloat("TacRPCharge", 0), 0, 1)
    local d = 1
    if self:GetOwner():GetNWFloat("TacRPChargeTime", 0) + chargedur > CurTime() then
        c = math.Clamp((self:GetOwner():GetNWFloat("TacRPChargeTime", 0) + chargedur - CurTime()) / chargedur, 0, 1)
        d = 1 - ChargeFraction(self:GetOwner())
    end

    surface.SetDrawColor(255, 255 * d ^ 0.5, 255 * d, 100)
    surface.DrawRect(x, y, w * c, h)

    surface.SetDrawColor(255, 255, 255, 200)
end


hook.Add("StartCommand", "TacRP_Charge", function(ply, cmd)
    if ply:GetNWFloat("TacRPChargeTime", 0) + chargedur > CurTime() then
        local ang = cmd:GetViewAngles()

        cmd:SetButtons(bit.band(cmd:GetButtons(), bit.bnot(IN_DUCK + IN_JUMP + IN_FORWARD + IN_BACK + IN_MOVELEFT + IN_MOVERIGHT)))

        ply.TacRPLastAngle = ply.TacRPLastAngle or ang
        local max = FrameTime() * 360
        cmd:SetViewAngles(Angle(ang.p, math.ApproachAngle(ply.TacRPLastAngle.y, ang.y, max), 0))

        ply.TacRPLastAngle = cmd:GetViewAngles()
    else
        ply.TacRPLastAngle = nil
    end
end)

local function TracePlayerBBox(ply, pos0, pos1)
    local bb1, bb2 = ply:GetCollisionBounds()
    return util.TraceHull({
        start = pos0,
        endpos = pos1,
        mask = MASK_PLAYERSOLID,
        collisiongroup = COLLISION_GROUP_PLAYER_MOVEMENT,
        mins = bb1,
        maxs = bb2,
        filter = ply,
    })
end

--[[
-- https://github.com/ValveSoftware/source-sdk-2013/blob/master/mp/src/public/coordsize.h
local COORD_RESOLUTION = 1 / 32

local function StayOnGround(ply, mv)
    local start = mv:GetOrigin()
    start.z = start.z + 2
    local endpos = mv:GetOrigin()
    endpos.z = endpos.z - ply:GetStepSize()

    -- See how far up we can go without getting stuck
    local tr = TracePlayerBBox(ply, mv:GetOrigin(), start)
    start = tr.HitPos

    -- using trace.startsolid is unreliable here, it doesn't get set when
    --  tracing bounding box vs. terrain

    -- Now trace down from a known safe position
    local tr2 = TracePlayerBBox(ply, start, endpos)
    if (tr2.Fraction > 0 and tr2.Fraction < 1 and !tr2.StartSolid and tr2.HitNormal.z >= 0.7) then
        local flDelta = math.abs(mv:GetOrigin().z - tr2.HitPos.z)

        if flDelta > 0.5 * COORD_RESOLUTION then
            mv:SetOrigin(tr.HitPos)
        end
    end
end

-- Note we don't have out as a parameter - it's the return value!
-- https://github.com/ValveSoftware/source-sdk-2013/blob/0d8dceea4310fde5706b3ce1c70609d72a38efdf/mp/src/game/shared/gamemovement.cpp#L3145
local function ClipVelocity(ply, mv, in_vec, normal, overbounce)
    local out = Vector()
    local blocked = 0 -- Assume unblocked.
    if normal.z > 0 then
        blocked = 1 -- If the plane that is blocking us has a positive z component, then assume it's a floor.
    elseif normal.z == 0 then
        blocked = 2 -- If the plane has no Z, it is vertical (wall/step)
    end

    -- Determine how far along plane to slide based on incoming direction.
    local backoff = in_vec:Dot(normal) * overbounce

    for i = 1, 3 do
        out[i] = in_vec[i] - (normal[i] * backoff)
    end

    -- iterate once to make sure we aren't still moving through the plane
    local adjust = out:Dot(normal)
    if adjust < 0 then
        out:Sub(normal * adjust)
    end

    return out, blocked
end

local vector_origin = Vector()
local MAX_CLIP_PLANES = 5

-- https://github.com/ValveSoftware/source-sdk-2013/blob/0d8dceea4310fde5706b3ce1c70609d72a38efdf/mp/src/game/shared/gamemovement.cpp#L2560
local function TryPlayerMove(ply, mv, dest)
    local numbumps = 4
    local blocked = 0
    local numplanes = 0

    local original_velocity = mv:GetVelocity()
    local primal_velocity = mv:GetVelocity()

    local allFraction = 0
    local time_left = FrameTime()

    local new_velocity
    local end_vector

    local pm
    local planes = {}

    for bumpcount = 0, numbumps - 1 do
        if mv:GetVelocity():Length() == 0 then break end

        -- Assume we can move all the way from the current origin to the end point.
        end_vector = mv:GetOrigin() + mv:GetVelocity() * time_left

        -- See if we can make it from origin to end point.
        pm = TracePlayerBBox(ply, mv:GetOrigin(), end_vector)

        allFraction = allFraction + pm.Fraction

        -- If we started in a solid object, or we were in solid space
        --  the whole way, zero out our velocity and return that we
        --  are blocked by floor and wall.
        if pm.AllSolid then
            mv:SetVelocity(vector_origin)
            return 4
        end

        -- If we moved some portion of the total distance, then
        --  copy the end position into the pmove.origin and
        --  zero the plane counter.
        if pm.Fraction > 0 then
            if numbumps > 0 and pm.Fraction == 1 then
                -- There's a precision issue with terrain tracing that can cause a swept box to successfully trace
                -- when the end position is stuck in the triangle.  Re-run the test with an uswept box to catch that
                -- case until the bug is fixed.
                -- If we detect getting stuck, don't allow the movement
                local stuck = TracePlayerBBox(ply, pm.HitPos, pm.HitPos)
                if stuck.StartSolid or stuck.Fraction < 1 then
                    mv:SetVelocity(vector_origin)
                    break
                end
            end

            -- actually covered some distance
            mv:SetOrigin(pm.HitPos)
            mv:SetVelocity(original_velocity)
            numplanes = 0
        end

        -- If we covered the entire distance, we are done and can return.
        if pm.Fraction == 1 then
            break -- moved the entire distance
        end

        -- what???
        -- MoveHelper( )->AddToTouched( pm, mv->m_vecVelocity );

        -- If the plane we hit has a high z component in the normal, then it's probably a floor
        if pm.HitNormal.z > 0.7 then
            blocked = bit.bor(blocked, 1)
        end

        -- If the plane has a zero z component in the normal, then it's a step or wall
        if pm.HitNormal.z == 0 then
            blocked = bit.bor(blocked, 2)
        end

        -- Reduce amount of m_flFrameTime left by total time left * fraction that we covered.
        time_left = time_left * (1 - pm.Fraction)

        -- Did we run out of planes to clip against?
        if numplanes >= MAX_CLIP_PLANES then
            mv:SetVelocity(vector_origin)
            break
        end

        -- Set up next clipping plane
        planes[numplanes] = pm.HitNormal
        numplanes = numplanes + 1

        -- reflect player velocity
        -- Only give this a try for first impact plane because you can get yourself stuck in an acute corner by jumping in place
        -- pressing forward and nobody was really using this bounce/reflection feature anyway...
        if (numplanes == 1 and ply:GetMoveType() == MOVETYPE_WALK and ply:GetGroundEntity() == NULL) then
            for i = 0, numplanes - 1 do
                if planes[i].z > 0.7 then
                    new_velocity = ClipVelocity(ply, mv, original_velocity, planes[i], 1)
                    original_velocity = new_velocity
                else
                    new_velocity = ClipVelocity(ply, mv, original_velocity, planes[i], 1) -- something about bounce but it's always cancelled out by friction?
                end
            end
            mv:SetVelocity(new_velocity)
            original_velocity = new_velocity
        else
            local ii
            for i = 0, numplanes - 1 do
                ii = i
                mv:SetVelocity(ClipVelocity(ply, mv, original_velocity, planes[i], 1))
                local jj
                for j = 0, numplanes - 1 do
                    -- Are we now moving against this plane?
                    jj = j
                    if j != i and mv:GetVelocity():Dot(planes[j]) < 0 then
                        break -- not ok
                    end
                end
                if jj == numplanes - 1 then
                    break -- Didn't have to clip, so we're ok
                end
            end

            -- Did we go all the way through plane set
            if ii != numplanes then
                -- uhh
            else
                -- go along the crease
                if numplanes != 2 then
                    mv:SetVelocity(vector_origin)
                    break
                end
                local dir = planes[0]:Cross(planes[1]):Normalize()
                local d = dir:Dot(mv:GetVelocity())
                mv:SetVelocity(dir * d)
            end

            -- if original velocity is against the original velocity, stop dead
            -- to avoid tiny occilations in sloping corners
            if mv:GetVelocity():Dot(primal_velocity) < 0 then
                mv:SetVelocity(vector_origin)
                break
            end
        end
    end

    if allFraction == 0 then
        mv:SetVelocity(vector_origin)
    end

    return blocked
end
]]

local dim = Vector(24, 24, 32)
local dim2 = Vector(32, 32, 32)
hook.Add("Move", "TacRP_Charge", function(ply, mv)
    if ply:GetNWFloat("TacRPChargeTime", 0) + chargedur > CurTime() then

        -- local wep = ply:GetActiveWeapon()
        -- if !IsValid(wep) or !wep.ArcticTacRP or !wep:GetValue("KnifeCharge") then return end

        if ply:GetMoveType() != MOVETYPE_WALK then
            ply:SetNWFloat("TacRPChargeTime", 0)
            return
        end

        local pos = mv:GetOrigin()

        -- naive implementation: always move in direction of aim.
        -- does not allow for cool stuff like charge strafing
        -- local v = mv:GetVelocity().z
        -- local speed = mv:GetVelocity():Dot(ply:GetForward())
        -- mv:SetVelocity(ply:GetForward() * math.max(ply:GetRunSpeed() + (ply:IsOnGround() and 450 or 350), speed) + Vector(0, 0, v))

        -- replicate demoknight charge mechanic
        -- https://github.com/OthmanAba/TeamFortress2/blob/master/tf2_src/game/shared/tf/tf_gamemovement.cpp
        local wishspeed = 750
        local wishdir = ply:GetForward()
        local flAccelerate = GetConVar("sv_accelerate"):GetFloat()

        -- if our wish speed is too low (attributes), we must increase acceleration or we'll never overcome friction
        -- Reverse the basic friction calculation to find our required acceleration
        if wishspeed < wishspeedthreshold() then
            local flSpeed = mv:GetVelocity():Length()
            local flControl = math.min(GetConVar("sv_stopspeed"):GetFloat(), flSpeed)
            flAccelerate = (flControl * GetConVar("sv_friction"):GetFloat()) / wishspeed + 1
        end

        -- Accelerate()
        -- https://github.com/ValveSoftware/source-sdk-2013/blob/master/mp/src/game/shared/gamemovement.cpp

        local currentspeed = mv:GetVelocity():Dot(wishdir)
        local addspeed = wishspeed - currentspeed

        -- Grounded friction is constantly trying to slow us down. Counteract it!
        -- TF2 doesn't have to deal with it since it disables friction in-engine. We can't since I don't want to reimplement gamemovement.cpp
        if ply:IsOnGround() then
            addspeed = addspeed + wishspeed ^ 0.7 -- approximate grounded friciton with magic number
        end

        if addspeed > 0 then
            accelspeed = math.min(addspeed, flAccelerate * FrameTime() * wishspeed) -- * player->m_surfaceFriction but it seems like it's 1 by default?

            mv:SetVelocity(mv:GetVelocity() + accelspeed * wishdir)
        end

        -- The player will double dip on air acceleration since engine also applies its acceleration.
        -- Stop engine behavior if we're in mid-air and not colliding. If we collide, let engine kick in.
        -- In theory this will still cause double dipping as long as the player is near a thing (like sliding along a wall). Not a big enough deal though.
        if !ply:IsOnGround() then

            -- since we are about to override the rest of engine movement code, apply gravity ourselves
            if ply:WaterLevel() == 0 then
                mv:SetVelocity(mv:GetVelocity() + physenv.GetGravity() * FrameTime())
            end

            local dest = pos + mv:GetVelocity() * FrameTime()
            local tr = TracePlayerBBox(ply, pos, dest)
            -- If we made it all the way, then copy trace end as new player position.
            if tr.Fraction == 1 then
                mv:SetOrigin(tr.HitPos)
                -- mv:SetVelocity(mv:GetVelocity() - ply:GetBaseVelocity()) -- probably not relevant?
                return true
            end
        end

        -- I overthought this completely and attempted to reimplement a good chunk of HL2 movement code, but it isn't necessary (and didn't work).

        -- -- first try moving directly to the next spot
        -- tr = TracePlayerBBox(ply, pos, dest)

        -- -- If we made it all the way, then copy trace end as new player position.
        -- if tr.Fraction == 1 then
        --     mv:SetOrigin(tr.HitPos)
        --     -- we don't do anything about player->GetBaseVelocity()? is that fine?

        --     StayOnGround(ply, mv)
        --     return true
        -- end

        -- -- Don't walk up stairs if not on ground.
        -- if !ply:IsOnGround() and ply:WaterLevel() == 0 then
        --     -- pull the base velocity back out
        --     return
        -- end

        -- -- If we are jumping out of water, don't do anything more.
        -- if ply:IsFlagSet(FL_WATERJUMP) then
        --     -- base velocity?
        --     return
        -- end

        -- -- StepMove()
        -- -- Does the basic move attempting to climb up step heights.

        -- local vecEndPos = Vector(dest)

        -- -- Try sliding forward both on ground and up 16 pixels
        -- -- take the move that goes farthest
        -- local vecPos, vecVel = mv:GetOrigin(), mv:GetVelocity()

        -- -- Slide move down.
        -- TryPlayerMove(ply, mv)

        -- -- Down results.
        -- local vecDownPos, vecDownVel = mv:GetOrigin(), mv:GetVelocity()

        -- -- Reset original values.
        -- mv:SetOrigin(vecPos)
        -- mv:SetVelocity(vecVel)

        -- -- Move up a stair height.
        -- vecEndPos = mv:GetOrigin()
        -- --[[ -- what?
        -- if ( player->m_Local.m_bAllowAutoMovement )
        -- {
        --     vecEndPos.z += player->m_Local.m_flStepSize + DIST_EPSILON;
        -- }
        -- ]]

        -- tr = TracePlayerBBox(ply, mv:GetOrigin(), vecEndPos)
        -- if !tr.StartSolid and !tr.AllSolid then
        --     mv:SetOrigin(tr.HitPos)
        -- end

        -- -- Slide move up.
        -- TryPlayerMove(ply, mv)

        -- -- Move down a stair (attempt to).
        -- vecEndPos = mv:GetOrigin()
        -- --[[
        -- if ( player->m_Local.m_bAllowAutoMovement )
        -- {
        --     vecEndPos.z -= player->m_Local.m_flStepSize + DIST_EPSILON;
        -- }
        -- ]]

        -- tr = TracePlayerBBox(ply, mv:GetOrigin(), vecEndPos)

        -- -- If we are not on the ground any more then use the original movement attempt.
        -- if tr.HitNormal.z < 0.7 then
        --     mv:SetOrigin(vecDownPos)
        --     mv:SetVelocity(vecDownVel)
        --     mv:SetFinalStepHeight(mv:GetFinalStepHeight() + math.abs(mv:GetOrigin().z - vecPos.z))
        --     return
        -- end

        -- -- If the trace ended up in empty space, copy the end over to the origin.
        -- if !tr.StartSolid and !tr.AllSolid then
        --     mv:SetOrigin(tr.HitPos)
        -- end

        -- -- Copy this origin to up.
        -- local vecUpPos = mv:GetOrigin()

        -- local flDownDist = (vecDownPos.x - vecPos.x) * (vecDownPos.x - vecPos.x) + (vecDownPos.y - vecPos.y) * (vecDownPos.y - vecPos.y)
        -- local flUpDist = (vecUpPos.x - vecPos.x) * (vecUpPos.x - vecPos.x) + (vecUpPos.y - vecPos.y) * (vecUpPos.y - vecPos.y)
        -- if flDownDist > flUpDist then
        --     mv:SetOrigin(vecDownPos)
        --     mv:SetVelocity(vecDownVel)
        -- else
        --     -- copy z value from slide move
        --     local v = mv:GetVelocity()
        --     v.z = vecDownVel.z
        --     mv:SetVelocity(v)
        -- end

        -- mv:SetFinalStepHeight(mv:GetFinalStepHeight() + math.abs(mv:GetOrigin().z - vecPos.z))

        -- ----------------------------------------- StepMove() ends here

        -- -- base velocity?
        -- StayOnGround(ply, mv)

        -- return true
    end
end)

hook.Add("FinishMove", "TacRP_Charge", function(ply, mv)
    if !IsFirstTimePredicted() then return end
    if ply:GetNWFloat("TacRPChargeTime", 0) + chargedur > CurTime() then
        local wep = ply:GetActiveWeapon()
        local d = ChargeFraction(ply)

        -- https://github.com/OthmanAba/TeamFortress2/blob/1b81dded673d49adebf4d0958e52236ecc28a956/tf2_src/game/shared/tf/tf_gamemovement.cpp#L248
        -- some grace time to make point blank charges not awkward.
        if ply:GetNWFloat("TacRPChargeTime", 0) + engine.TickInterval() * 5 < CurTime() then
            if mv:GetVelocity():Length() < 300 then
                ply:LagCompensation(true)
                local tr = util.TraceHull({
                    start = ply:EyePos(),
                    endpos = ply:EyePos() + ply:GetForward() * 48,
                    filter = {ply},
                    mask = MASK_PLAYERSOLID,
                    mins = -dim,
                    maxs = dim,
                    ignoreworld = false
                })

                debugoverlay.Box(tr.HitPos, -dim, dim, FrameTime() * 10, Color(255, 255, 255, 0))

                if IsValid(tr.Entity) and tr.Entity:GetOwner() != ply then

                    if SERVER then
                        local dmginfo = DamageInfo()
                        dmginfo:SetDamage(20 + d * 40)
                        dmginfo:SetDamageForce(ply:GetForward() * 5000)
                        dmginfo:SetDamagePosition(tr.HitPos)
                        dmginfo:SetDamageType(DMG_CLUB)
                        dmginfo:SetAttacker(wep:GetOwner())
                        dmginfo:SetInflictor(wep)
                        tr.Entity:TakeDamageInfo(dmginfo)

                        local phys = tr.Entity:GetPhysicsObject()
                        if tr.Entity:IsPlayer() or tr.Entity:IsNPC() or tr.Entity:IsNextBot() then
                            tr.Entity:SetVelocity(ply:GetForward() * d * 3000 + Vector(0, 0, 250))
                        elseif IsValid(phys) then
                            phys:ApplyForceCenter(ply:GetForward() * (phys:GetMass() ^ 0.5) * 20000 * (d * 0.5 + 0.5))
                        end
                    end

                    if d >= 0.9 then
                        ply:EmitSound("TacRP.Charge.HitFlesh_Range", 80)
                    else
                        ply:EmitSound("TacRP.Charge.HitFlesh", 80)
                    end
                elseif tr.Hit then
                    ply:EmitSound("TacRP.Charge.HitWorld", 80)
                end

                -- In TF2, going below 300 velocity instantly cancels the charge.
                -- However, this feels really bad if you're trying to cancel your momentum mid-air!
                -- Let's be generous and only stop on a hit or if it's grounded.
                if ply:IsOnGround() or tr.Hit then
                    ply:SetNWFloat("TacRPChargeFollowup", CurTime() + 0.75)
                    ply:SetNWFloat("TacRPChargeStrength", d)

                    ply:SetNWFloat("TacRPChargeTime", 0)

                    util.ScreenShake(ply:EyePos(), 15, 150, d * 1, 750)
                    if IsValid(wep) and wep.ArcticTacRP then
                        wep:SetShouldHoldType()
                    end
                end

                ply:LagCompensation(false)
            elseif (ply.TacRPNextChargeTrace or 0) < CurTime() then
                ply.TacRPNextChargeTrace = CurTime() + engine.TickInterval() * 2
                ply:LagCompensation(true)
                local tr = util.TraceHull({
                    start = ply:EyePos(),
                    endpos = ply:EyePos() + ply:GetForward() * 32,
                    filter = {ply},
                    mask = MASK_PLAYERSOLID,
                    mins = -dim2,
                    maxs = dim2,
                    ignoreworld = true
                })
                debugoverlay.Box(tr.HitPos, -dim2, dim2, FrameTime() * 5, Color(255, 255, 255, 0))
                if IsValid(tr.Entity) and tr.Entity:GetOwner() != ply then
                    if SERVER then
                        local dmginfo = DamageInfo()
                        dmginfo:SetDamage(20 + d * 40)
                        dmginfo:SetDamageForce(ply:GetForward() * 5000)
                        dmginfo:SetDamagePosition(tr.HitPos)
                        dmginfo:SetDamageType(DMG_CLUB)
                        dmginfo:SetAttacker(wep:GetOwner())
                        dmginfo:SetInflictor(wep)
                        tr.Entity:TakeDamageInfo(dmginfo)

                        local phys = tr.Entity:GetPhysicsObject()
                        if tr.Entity:IsPlayer() or tr.Entity:IsNPC() or tr.Entity:IsNextBot() then
                            tr.Entity:SetVelocity(ply:GetForward() * d * 3000 + Vector(0, 0, 250))
                        elseif IsValid(phys) then
                            phys:ApplyForceCenter(ply:GetForward() * (phys:GetMass() ^ 0.5) * 20000 * (d * 0.5 + 0.5))
                        end
                    end

                    timer.Simple(0.001, function()
                        if IsValid(ply) and IsValid(tr.Entity) and (!tr.Entity:IsPlayer() or tr.Entity:Alive()) then
                            ply:SetNWFloat("TacRPChargeFollowup", CurTime() + 0.75)
                            ply:SetNWFloat("TacRPChargeStrength", d)

                            ply:SetNWFloat("TacRPChargeTime", 0)
                            if d >= 0.9 then
                                ply:EmitSound("TacRP.Charge.HitFlesh_Range", 80)
                            else
                                ply:EmitSound("TacRP.Charge.HitFlesh", 80)
                            end
                            util.ScreenShake(ply:EyePos(), 15, 150, d * 1, 750)
                            if IsValid(wep) and wep.ArcticTacRP then
                                wep:SetShouldHoldType()
                            end
                        end
                    end)

                    ply:LagCompensation(false)
                end
            end
        end
    end
end)

hook.Add("EntityTakeDamage", "TacRP_Charge", function(ent, dmginfo)
    if !IsValid(dmginfo:GetAttacker()) or !ent:IsPlayer() then return end
    local wep = ent:GetActiveWeapon()

    if !IsValid(wep) or !wep.ArcticTacRP or ent:GetNWFloat("TacRPChargeTime", 0) + chargedur > CurTime() then return end
    if !dmginfo:IsDamageType(DMG_CRUSH) then return end

    return true
end)