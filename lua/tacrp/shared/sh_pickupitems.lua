TacRP.PickupItems = {}
TacRP.PickupItems_Index = {}
TacRP.PickupItems_Lookup = {}
TacRP.PickupItems_Count = 0
TacRP.PickupItems_Bits = 16

local MetaItem = {}
MetaItem.IsItem = true

function MetaItem:GetData(key, default)
    return self.Data[key] == nil and default or self.Data[key]
end

function MetaItem:SetData(key, value)
    self.Data[key] = value
end

function MetaItem:GetterSetter(key, default)
    self["Set" .. key] = function(self2, value)
        self:SetData(key, value)
    end
    self["Get" .. key] = function(self2, default2) return self:GetData(key, default2 or self[key]) end
end

MetaItem:GetterSetter("Name")
MetaItem:GetterSetter("Description")
MetaItem:GetterSetter("Icon")
MetaItem:GetterSetter("Model")
MetaItem:GetterSetter("Weight")
MetaItem:GetterSetter("Amount")

function MetaItem:IsValid()
    return true
end
function MetaItem:GetClass()
    return MetaItem.Class
end
function MetaItem:Populate()
    TacRP.PickupItems_Lookup[self:GetClass()] = self:GetClass()
end
function MetaItem:Write()
    net.WriteUInt(table.Count(self.Data), 8)
    for k, v in pairs(self.Data) do
        net.WriteString(k)
        net.WriteType(v)
    end
end
function MetaItem:Read()
    for i = 1, net.ReadUInt(8) do
        self:SetData(net.ReadString(), net.ReadType())
    end
end

function MetaItem:Create(pos, ang)
    -- Return a created entity.
    local ent = ents.Create(self:GetClass())
    ent:SetPos(pos)
    ent:SetAngles(ang or Angle(0, 0, 0))
    self:LoadEntityData(ent)
    ent:Spawn()

    return ent
end
function MetaItem:Pickup(ply, con, ent, i)
    -- Called just before ent is removed and item is added to container
end
function MetaItem:Drop(ply, con, ent, i)
    -- Called just after ent is created
end
function MetaItem:SaveEntityData(ent)
    -- Called before Pickup(), used to write data from entity to item
end
function MetaItem:LoadEntityData(ent)
    -- Called in Create(), used to apply data from item to entity
end

function TacRP.LoadPickupItems()
    TacRP.PickupItems_Count = 0
    TacRP.PickupItems = {}
    TacRP.PickupItems_Index = {}

    local searchdir = "TacRP/shared/items/"

    files = file.Find(searchdir .. "/*.lua", "LUA")

    for _, filename in ipairs(files) do
        if filename == "_default.lua" then continue end
        if ITEM.Ignore then continue end

        ITEM = {}

        local shortname = string.sub(filename, 1, -5)
        AddCSLuaFile(searchdir .. filename)
        include(searchdir .. filename)

        ITEM = setmetatable({}, {__index = MetaItem})
        ITEM.Class = shortname
        ITEM.ID = TacRP.PickupItems_Count

        TacRP.PickupItems_Count = TacRP.PickupItems_Count + 1
        TacRP.PickupItems[shortname] = ITEM
        TacRP.PickupItems_Index[TacRP.PickupItems_Count] = shortname

        if isfunction(ITEM.Populate) then
            ITEM:Populate()
        end

        ITEM = nil
    end

    -- Inheritance
    for _, item in pairs(TacRP.PickupItems) do
        if item.Base then
            local base = TacRP.PickupItems[item.Base]

            if base then
                setmetatable(item, {__index = base})
            else
                ErrorNoHalt( item.Class .. " tried to derive from nonexistent base " .. item.Base .. "!" )
            end
        end
    end

    TacRP.PickupItems_Bits = math.min(math.ceil(math.log(TacRP.PickupItems_Count + 1, 2)), 32)
end

TacRP.LoadPickupItems()

function TacRP.CreateItem(item_class, data)
    if isnumber(item_class) then
        item_class = TacRP.PickupItems_Index[item_class]
    end
    if !item_class then return end

    local item = {
        Class = item_class,
        Data = data or {}
    }
    setmetatable(item, {__index = item_class})
    item:Initialize()
    return item
end
