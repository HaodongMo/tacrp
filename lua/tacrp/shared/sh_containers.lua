TacRP.Containers = {
    -- {entity = entity, size = number, items = {}}
}

function TacRP.MakeContainer(ent, size)
    if ent.TacRP_ContainerID then return end
    ent.TacRP_ContainerID = table.insert(TacRP.Containers, {
        entity = ent,
        capacity = size or 100,
        weight = 0,
        items = {}
    })
end

function TacRP.ContainerSize(i)
    if !TacRP.Containers[i].weight then
        local weight = 0
        for k, v in pairs(TacRP.Containers[i].items) do
            weight = weight + v:GetWeight()
        end
        TacRP.Containers[i].weight = weight
    end
    return TacRP.Containers[i].weight
end

function TacRP.AddToContainer(ent, item)

end