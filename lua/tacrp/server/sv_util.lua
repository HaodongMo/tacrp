function TacRP.Flashbang(pos, radius, time_max, time_min, time_stunadd)

    for _, k in ipairs(ents.FindInSphere(pos, radius)) do
        if k:IsPlayer() then
            local dist = k:EyePos():Distance(pos)
            local dp = (k:EyePos() - pos):Dot(k:EyeAngles():Forward())

            local time = Lerp( dp, time_max, time_min )

            time = Lerp( dist / radius, time, time_min )

            if !k:VisibleVec( pos ) then
                time = 0
            else
                k:SetNWFloat("TacRPStunStart", CurTime())
                k:SetNWFloat("TacRPStunDur", time + (time_stunadd or 0.5))
            end

            net.Start("tacrp_flashbang")
                net.WriteFloat(time)
            net.Send(k)
        end
    end


end