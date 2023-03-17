TacRP.PenTable = {
    [MAT_ANTLION]     = 0.1,
    [MAT_BLOODYFLESH] = 0.1,
    [MAT_CONCRETE]    = 0.5,
    [MAT_DIRT]        = 0.25,
    [MAT_EGGSHELL]    = 0.25,
    [MAT_FLESH]       = 0.1,
    [MAT_GRATE]       = 0.25,
    [MAT_ALIENFLESH]  = 0.25,
    [MAT_CLIP]        = 1000,
    [MAT_SNOW]        = 0.1,
    [MAT_PLASTIC]     = 0.25,
    [MAT_METAL]       = 1,
    [MAT_SAND]        = 0.5,
    [MAT_FOLIAGE]     = 0.25,
    [MAT_COMPUTER]    = 0.25,
    [MAT_SLOSH]       = 0.25,
    [MAT_TILE]        = 0.5, // you know, like ceramic armor
    [MAT_GRASS]       = 0.25,
    [MAT_VENT]        = 0.1,
    [MAT_WOOD]        = 0.25,
    [MAT_DEFAULT]     = 0.25,
    [MAT_GLASS]       = 0.1,
    [MAT_WARPSHIELD]  = 1
}

// Why the fuck is this a thing???
TacRP.CancelMultipliers = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 0.25,
    [HITGROUP_RIGHTARM] = 0.25,
    [HITGROUP_LEFTLEG] = 0.25,
    [HITGROUP_RIGHTLEG] = 0.25,
    [HITGROUP_GEAR] = 0.25
}

TacRP.PresetPath = "tacrp_presets/"

TacRP.OverDraw = false

TacRP.HUToM = 0.3048 / 12

TacRP.HolsterNetBits = 2
TacRP.HOLSTER_SLOT_BACK = 1
TacRP.HOLSTER_SLOT_PISTOL = 2
TacRP.HOLSTER_SLOT_GEAR = 3

TacRP.HolsterBones = {
    [TacRP.HOLSTER_SLOT_BACK] = {
        "ValveBiped.Bip01_Spine2",
        Vector(0, 0, 0),
        {"models/props_c17/SuitCase_Passenger_Physics.mdl", Vector(6, 4, 8), Angle(0, 0, 0)},
    },
    [TacRP.HOLSTER_SLOT_PISTOL] = {
        "ValveBiped.Bip01_R_Thigh",
        Vector(0, 0, 0),
        {"models/weapons/w_eq_eholster_elite.mdl", Vector(0, 8, -4), Angle(90, 0, 90)},
    },
    [TacRP.HOLSTER_SLOT_GEAR] = {
        "ValveBiped.Bip01_Pelvis",
        Vector(0, 10, 0),
        {"models/weapons/w_defuser.mdl", Vector(0, -10, -8), Angle(-90, -90, 0)},
    },
}

TacRP.BlindFireNetBits = 3

TacRP.BLINDFIRE_NONE  = 0
TacRP.BLINDFIRE_UP    = 1
TacRP.BLINDFIRE_LEFT  = 2
TacRP.BLINDFIRE_RIGHT = 3
TacRP.BLINDFIRE_KYS   = 4 // You should kill yourself... NOW!