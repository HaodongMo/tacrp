SWEP.Base = "tacrp_m320"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "HK M320LE"
SWEP.AbbrevName = "M320LE"
SWEP.Category = "Tactical RP (Special)"

SWEP.NoAimAssist = true

SWEP.SubCatTier = "9Special"
SWEP.SubCatType = "6Launcher"

SWEP.Description = "Law Enforcement version of the M320 sanctioned for less-lethal munitions. Fires beanbag rounds that incapacitate on direct hit."
SWEP.Description_Quote = "That is one dangerous beanbag..."

SWEP.Trivia_Caliber = "40mm Grenades"
SWEP.Trivia_Manufacturer = "Heckler & Koch"
SWEP.Trivia_Year = "2008"

SWEP.Faction = TacRP.FACTION_NEUTRAL
SWEP.Credits = "Assets: Tactical Intervention"

SWEP.ViewModel = "models/weapons/tacint/v_m320.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_m320_civ.mdl"
SWEP.DefaultSkin = 1

SWEP.NoRanger = true

SWEP.Slot = 4

SWEP.BalanceStats = {
    [TacRP.BALANCE_SBOX] = {
    },
    [TacRP.BALANCE_TTT] = {
    },
}

// "ballistics"

SWEP.Damage_Max = 100
SWEP.Damage_Min = 100
SWEP.Range_Max = 2000
SWEP.Range_Min = 800

SWEP.ShootEnt = "tacrp_proj_40mm_beanbag"
SWEP.ShootEntForce = 7000

SWEP.Spread = 0.01

SWEP.BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 1,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 0.9,
    [HITGROUP_RIGHTLEG] = 0.9,
    [HITGROUP_GEAR] = 0.9
}

SWEP.MuzzleVelocity = 7000

SWEP.Num = 1

// sounds

local path = "TacRP/weapons/m320/"

SWEP.Sound_Shoot = "^" .. path .. "fire-1.wav"

SWEP.Vol_Shoot = 100
SWEP.ShootPitchVariance = 2.5 // amount to vary pitch by each shot

// anims

SWEP.Attachments = {
    [1] = {
        PrintName = "Ammo",
        Category = "ammo_40mm_civ",
        AttachSound = "TacRP/weapons/m320/shell_in-1.wav",
        DetachSound = "TacRP/weapons/m320/shell_out-1.wav",
    },
    [2] = {
        PrintName = "Accessory",
        Category = {"acc", "acc_foldstock2", "acc_holster"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [3] = {
        PrintName = "Perk",
        Category = {"perk", "perk_shooting", "perk_reload", "perk_melee"},
        AttachSound = "tacrp/weapons/flashlight_on.wav",
        DetachSound = "tacrp/weapons/flashlight_off.wav",
    },
}

local function addsound(name, spath)
    sound.Add({
        name = name,
        channel = 16,
        volume = 1.0,
        sound = spath
    })
end

addsound("TacInt_m320.Tube_Open", path .. "tube_open-1.wav")
addsound("TacInt_m320.Tube_close", path .. "tube_close-1.wav")
addsound("TacInt_m320.shell_out", path .. "shell_out-1.wav")
addsound("TacInt_m320.shell_in", path .. "shell_in-1.wav")
addsound("TacInt_m320.buttstock_back", path .. "buttstock_back-1.wav")
addsound("TacInt_m320.sight_flipup", path .. "sight_flipup-1.wav")

SWEP.AutoSpawnable = false