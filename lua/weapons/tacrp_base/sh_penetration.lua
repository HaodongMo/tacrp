local function IsPenetrating(ptr, ptrent)
    if ptrent:IsWorld() then
        return !ptr.StartSolid or ptr.AllSolid
    elseif IsValid(ptrent) then
        local mins, maxs = ptrent:WorldSpaceAABB()
        local wsc = ptrent:WorldSpaceCenter()
        -- Expand the bounding box by a bit to account for hitboxes outside it
        -- This is more consistent but less accurate
        mins = mins + (mins - wsc) * 0.25
        maxs = maxs + (maxs - wsc) * 0.25
        local withinbounding = ptr.HitPos:WithinAABox(mins, maxs)
        if GetConVar("developer"):GetBool() then
            debugoverlay.Cross(ptr.HitPos, withinbounding and 2 or 6, 5, withinbounding and Color(255, 255, 0) or Color(128, 255, 0), true)
        end

        if withinbounding then return true end
    end
    return false
end

function SWEP:Penetrate(tr, range, penleft, alreadypenned)
    if !GetConVar("TacRP_penetration"):GetBool() then return end

    local hitpos, startpos = tr.HitPos, tr.StartPos
    local dir    = (hitpos - startpos):GetNormalized()

    if tr.HitSky then return end

    if penleft <= 0 then return end

    alreadypenned = alreadypenned or {}

    local skip = false

    local trent = tr.Entity

    local penmult     = TacRP.PenTable[tr.MatType] or 1
    local pentracelen = math.max(penleft * penmult / 8, 1)
    local curr_ent    = trent

    if !tr.HitWorld then penmult = penmult * 0.5 end

    if trent.mmRHAe then penmult = trent.mmRHAe end

    penmult = penmult * math.Rand(0.9, 1.1) * math.Rand(0.9, 1.1)

    local endpos = hitpos

    local td  = {}
    td.start  = endpos
    td.endpos = endpos + (dir * pentracelen)
    td.mask   = MASK_SHOT

    local ptr = util.TraceLine(td)

    local ptrent = ptr.Entity

    while !skip and penleft > 0 and IsPenetrating(ptr, ptrent) and ptr.Fraction < 1 and ptrent == curr_ent do
        penleft = penleft - (pentracelen * penmult)

        td.start  = endpos
        td.endpos = endpos + (dir * pentracelen)
        td.mask   = MASK_SHOT

        ptr = util.TraceLine(td)

        if GetConVar("developer"):GetBool() then
            local pdeltap = penleft / self:GetValue("Penetration")
            local colorlr = Lerp(pdeltap, 0, 255)

            debugoverlay.Line(endpos, endpos + (dir * pentracelen), 10, Color(255, colorlr, colorlr), true)
        end

        endpos = endpos + (dir * pentracelen)
        range = range + pentracelen
    end

    if penleft > 0 then
        if (dir:Length() == 0) then return end

        self:GetOwner():FireBullets({
            Damage = self:GetValue("Damage_Max"),
            Force = 4,
            Tracer = 0,
            Num = 1,
            Dir = dir,
            Src = endpos,
            Callback = function(att, btr, dmg)
                range = range + (btr.HitPos - btr.StartPos):Length()
                self:AfterShotFunction(btr, dmg, range, penleft, alreadypenned)

                if GetConVar("developer"):GetBool() then
                    if SERVER then
                        debugoverlay.Cross(btr.HitPos, 4, 5, Color(255, 0, 0), false)
                    else
                        debugoverlay.Cross(btr.HitPos, 4, 5, Color(255, 255, 255), false)
                    end
                end
            end
        })

        self:GetOwner():FireBullets({
            Damage = 0,
            Force = 0,
            Tracer = 0,
            Num = 1,
            Distance = 1,
            Dir = -dir,
            Src = endpos,
        })
    end
end