hook.Add("InitPostEntity", "TacRP_NPCRegister", function()
    for _, wpn in pairs(weapons.GetList()) do
        local tbl = weapons.Get(wpn.ClassName)

        if !tbl.ArcticTacRP then continue end
        if !tbl.NPCUsable then continue end
        if !tbl.Spawnable then continue end

        list.Add("NPCUsableWeapons",
            {
                class = wpn.ClassName,
                title = wpn.PrintName
            }
        )
    end
end)