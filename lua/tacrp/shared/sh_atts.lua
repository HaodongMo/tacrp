TacRP.Attachments = {}
TacRP.Attachments_Index = {}

TacRP.Attachments_Count = 0

TacRP.Attachments_Bits = 16

function TacRP.LoadAtts()
    TacRP.Attachments_Count = 0
    TacRP.Attachments = {}
    TacRP.Attachments_Index = {}

    local searchdir = "TacRP/shared/atts/"

    local files = file.Find(searchdir .. "/*.lua", "LUA")

    for _, filename in pairs(files) do
        AddCSLuaFile(searchdir .. filename)
    end

    files = file.Find(searchdir .. "/*.lua", "LUA")

    for _, filename in pairs(files) do
        if filename == "default.lua" then continue end

        ATT = {}

        local shortname = string.sub(filename, 1, -5)

        include(searchdir .. filename)

        if ATT.Ignore then continue end

        TacRP.Attachments_Count = TacRP.Attachments_Count + 1

        ATT.ShortName = shortname
        ATT.ID = TacRP.Attachments_Count

        TacRP.Attachments[shortname] = ATT
        TacRP.Attachments_Index[TacRP.Attachments_Count] = shortname

        if GetConVar("tacrp_generateattentities"):GetBool() and !ATT.DoNotRegister and !ATT.InvAtt and !ATT.Free then
            local attent = {}
            attent.Base = "tacrp_att"
            attent.Icon = ATT.Icon
            attent.PrintName = ATT.PrintName or shortname
            attent.Spawnable = true
            attent.AdminOnly = ATT.AdminOnly or false
            attent.AttToGive = shortname
            attent.Category = "Tactical RP - Attachments"

            print("Registering entity for " .. shortname)

            scripted_ents.Register(attent, "tacrp_att_" .. shortname)
        end
    end

    TacRP.Attachments_Bits = math.min(math.ceil(math.log(TacRP.Attachments_Count + 1, 2)), 32)
end

TacRP.LoadAtts()

function TacRP.GetAttTable(name)
    local shortname = name
    if isnumber(shortname) then
        shortname = TacRP.Attachments_Index[name]
    end

    if TacRP.Attachments[shortname] then
        return TacRP.Attachments[shortname]
    else
        assert(false, "!!!! TacRP tried to access invalid attachment " .. (shortname or "NIL") .. "!!!")
        return {}
    end
end

function TacRP.GetAttsForCats(cats)
    if !istable(cats) then
        cats = {cats}
    end

    local atts = {}

    for i, k in pairs(TacRP.Attachments) do
        local attcats = k.Category
        if !istable(attcats) then
            attcats = {attcats}
        end

        for _, cat in pairs(cats) do
            if table.HasValue(attcats, cat) then
                table.insert(atts, k.ShortName)
                break
            end
        end
    end

    return atts
end

if CLIENT then

concommand.Add("TacRP_reloadatts", function()
    if !LocalPlayer():IsSuperAdmin() then return end

    net.Start("TacRP_reloadatts")
    net.SendToServer()
end)

net.Receive("TacRP_reloadatts", function(len, ply)
    TacRP.LoadAtts()
end)

elseif SERVER then

net.Receive("TacRP_reloadatts", function(len, ply)
    if !ply:IsSuperAdmin() then return end

    TacRP.LoadAtts()

    net.Start("TacRP_reloadatts")
    net.Broadcast()
end)

end

TacRP.Benches = ents.FindByClass("tacrp_bench") or {}
TacRP.BenchDistSqr = 128 * 128

function TacRP.NearBench(ply)
    if GetConVar("tacrp_rp_requirebench"):GetBool() then
        local nearbench = false
        for i, ent in pairs(TacRP.Benches) do
            if !IsValid(ent) then table.remove(TacRP.Benches, i) continue end
            if ent:GetPos():DistToSqr(ply:GetPos()) <= TacRP.BenchDistSqr then
                nearbench = true
                break
            end
        end
        if !nearbench then return false end
    end
    return true
end

function TacRP.CanCustomize(ply, wep, att, slot)

    if !TacRP.NearBench(ply) then return false end

    return true
end