SWEP.Base = "tacrp_m4"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "Colt Canada AR-15"
SWEP.Category = "Tactical RP (Arctic)"

SWEP.Description = "Semi-automatic variation of a very popular American assault rifle."

SWEP.ViewModel = "models/weapons/tacint/v_m4.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_m4.mdl"

SWEP.Slot = 3

SWEP.Firemode = 1

SWEP.Firemodes = false

local path = "TacRP/weapons/m4/m4_"

local function addsound(name, spath)
    sound.Add({
        name = name,
        channel = 16,
        volume = 1.0,
        sound = spath
    })
end

addsound("TacInt_m4.Remove_Clip", path .. "remove_clip.wav")
addsound("TacInt_m4.Insert_Clip", path .. "insert_clip.wav")
addsound("TacInt_m4.Insert_Clip-mid", path .. "insert_clip-mid.wav")
addsound("TacInt_m4.bolt_action", path .. "bolt_action.wav")
addsound("TacInt_m4.bolt_slap", path .. "bolt_slap.wav")
addsound("TacInt_m4.throw_catch", path .. "throw_catch.wav")