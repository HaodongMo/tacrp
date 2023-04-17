hook.Add("InitPostEntity", "TacRP_Register", function()
    for _, wpn in pairs(weapons.GetList()) do
        local tbl = weapons.Get(wpn.ClassName)

        if !tbl.ArcticTacRP or !tbl.NPCUsable or !tbl.Spawnable then continue end

        list.Add("NPCUsableWeapons",
            {
                class = wpn.ClassName,
                title = wpn.PrintName
            }
        )
    end
end)