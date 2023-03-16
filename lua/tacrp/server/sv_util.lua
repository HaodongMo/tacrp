function TacRP.Flashbang(ent, pos, radius, time_max, time_min, time_stunadd)

    for _, k in ipairs(ents.FindInSphere(pos, radius)) do
        if k:IsPlayer() then
            local dist = k:EyePos():Distance(pos)
            local dp = (k:EyePos() - pos):Dot(k:EyeAngles():Forward())

            local time = Lerp( dp, time_max, time_min )

            time = Lerp( dist / radius, time, time_min )

            local tr = util.QuickTrace(pos, k:EyePos() - pos, {k, ent})

            if tr.Fraction < 1 then
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