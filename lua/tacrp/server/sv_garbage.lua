TacRP.ShieldPropPile    = {} -- { {Model = NULL, Weapon = NULL} }

local function SV_TacRP_CollectGarbage()
    local removed = 0

    local newpile = {}

    for _, k in pairs(TacRP.ShieldPropPile) do
        if IsValid(k.Weapon) then
            table.insert(newpile, k)

            continue
        end

        SafeRemoveEntity(k.Model)

        removed = removed + 1
    end

    TacRP.ShieldPropPile = newpile

    if GetConVar("developer"):GetBool() and removed > 0 then
        print("Removed " .. tostring(removed) .. " Shield Models")
    end
end

timer.Create("TacRP Shield Model Garbage Collector", 5, 0, SV_TacRP_CollectGarbage)