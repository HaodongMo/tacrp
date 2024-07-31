SWEP.Base = "tacrp_base"
SWEP.Spawnable = true

AddCSLuaFile()

// names and stuff
SWEP.PrintName = "Stinger"
SWEP.AbbrevName = "Stinger"
SWEP.Category = "Tactical RP"

SWEP.SubCatTier = "9Special"
SWEP.SubCatType = "8Launcher"

SWEP.Description = "Homing anti-air missile launcher. High blast damage but limited effect on armored targets.\nRequires a lock-on in order to fire."
SWEP.Description_Quote = "\"A cornered fox is more dangerous than a jackal!\""

SWEP.Trivia_Caliber = "Infrared Homing Missile"
SWEP.Trivia_Manufacturer = "Raytheon Missiles and Defense"
SWEP.Trivia_Year = "1967"

SWEP.Faction = TacRP.FACTION_COALITION
SWEP.Credits = "Assets: Modern Warfare 2\nAnimations: Tactical Intervention"

SWEP.ViewModel = "models/weapons/tacint/v_stinger.mdl"
SWEP.WorldModel = "models/weapons/tacint/w_stinger.mdl"

SWEP.NoRanger = true

SWEP.Slot = 2
SWEP.SlotAlt = 4

SWEP.BalanceStats = {
    [TacRP.BALANCE_SBOX] = {
    },
    [TacRP.BALANCE_TTT] = {
    },
}

// "ballistics"

SWEP.Damage_Max = 100 // just to fool the ratings
SWEP.Damage_Min = 100
SWEP.Range_Max = 30000
SWEP.Range_Min = 5000

SWEP.ShootEnt = "tacrp_proj_stinger"
SWEP.ShootEntForce = 2000

SWEP.Num = 1

// misc. shooting

SWEP.Firemode = 1

SWEP.FiremodeName = "Single-Shot" // only used externally for firemode name distinction

SWEP.RPM = 60

SWEP.Spread = 0.01

SWEP.RecoilPerShot = 1
SWEP.RecoilMaximum = 1
SWEP.RecoilResetTime = 0.2// time after you stop shooting for recoil to start dissipating
SWEP.RecoilDissipationRate = 1
SWEP.RecoilFirstShotMult = 1 // multiplier for the first shot's recoil amount

SWEP.RecoilVisualKick = 5
SWEP.RecoilVisualShake = 0.2

SWEP.RecoilKick = 0

SWEP.RecoilSpreadPenalty = 0 // extra spread per one unit of recoil

SWEP.CanBlindFire = false

SWEP.CannotHipFire = true

// lockon

SWEP.LockOnAngle = math.cos(math.rad(5))
SWEP.LockOnRange = 40000

SWEP.LockOnTime = 1

SWEP.ProvideTargetData = true

SWEP.LockOnOutOfSights = false
SWEP.LockOnInSights = true

SWEP.ShootOffset = Vector(0, 0, 0)
SWEP.ShootOffsetAngle = Angle(0, 0, 0)

SWEP.RequireLockOn = true // Cannot shoot without a lock

// handling

SWEP.MoveSpeedMult = 0.8
SWEP.ShootingSpeedMult = 0.25
SWEP.SightedSpeedMult = 0.5

SWEP.ReloadSpeedMult = 0.2

SWEP.AimDownSightsTime = 0.6
SWEP.SprintToFireTime = 0.8 // multiplies how long it takes to recover from sprinting

SWEP.DeployTimeMult = 1.25

// hold types

SWEP.HoldType = "passive"
SWEP.HoldTypeSprint = "passive"
SWEP.HoldTypeSighted = "rpg"
SWEP.HoldTypeBlindFire = false
SWEP.HoldTypeNPC = "ar2"

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_AR2

SWEP.PassiveAng = Angle(40, -15, 0)
SWEP.PassivePos = Vector(4, 0, -4)

SWEP.SprintMidPoint = {
    Pos = Vector(0, 0, 0),
    Ang = Angle(0, 0, 0)
}

SWEP.BlindFireAng = Angle(0, 0, 0)
SWEP.BlindFirePos = Vector(1, -3, 0)

SWEP.BlindFireLeftAng = Angle(75, 0, 0)
SWEP.BlindFireLeftPos = Vector(8, 10, -6)

SWEP.BlindFireSuicideAng = Angle(0, 125, 0)
SWEP.BlindFireSuicidePos = Vector(-2, 25, -24)

SWEP.SprintAng = Angle(40, -15, 0)
SWEP.SprintPos = Vector(4, 0, -4)

SWEP.SightAng = Angle(0, 0, 0)
SWEP.SightPos = Vector(-0.62, -10, -4.57)

SWEP.HolsterVisible = true
SWEP.HolsterSlot = TacRP.HOLSTER_SLOT_SPECIAL
SWEP.HolsterPos = Vector(5, 0, -6)
SWEP.HolsterAng = Angle(0, 0, 0)

// sway

SWEP.Sway = 3
SWEP.ScopedSway = 0.25

SWEP.FreeAimMaxAngle = 5

// melee

SWEP.CanMeleeAttack = false

// reload

SWEP.ClipSize = 1
SWEP.Ammo = "rpg_round"

// sounds

local path = "TacRP/weapons/rpg7/"

SWEP.Sound_Shoot = "^" .. path .. "fire-1.wav"

SWEP.Sound_StartLockOn = "tacrp/check1.wav"
SWEP.Sound_FinishLockOn = "tacrp/locked1.wav"

SWEP.Vol_Shoot = 130
SWEP.ShootPitchVariance = 2.5 // amount to vary pitch by each shot

// effects

// the .qc attachment for the muzzle
SWEP.QCA_Muzzle = 1
// ditto for shell
SWEP.QCA_Eject = 2

SWEP.MuzzleEffect = "muzzleflash_deagle"

// anims

SWEP.AnimationTranslationTable = {
    ["deploy"] = "unholster",
    ["blind_fire"] = "aimed_fire",
    ["blind_idle"] = "aimed_idle",
}

// attachments

SWEP.Attachments = {
    [1] = {
        PrintName = "Ammo",
        Category = {"ammo_stinger"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [2] = {
        PrintName = "Accessory",
        Category = {"acc", "acc_duffle", "acc_sling"},
        AttachSound = "TacRP/weapons/flashlight_on.wav",
        DetachSound = "TacRP/weapons/flashlight_off.wav",
    },
    [3] = {
        PrintName = "Perk",
        Category = {"perk", "perk_shooting", "perk_reload"},
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

addsound("TacInt_rpg7.jingle", path .. "handling-1.wav")
addsound("TacInt_rpg7.insert_rocket", path .. "insert_rocket.wav")
addsound("TacInt_rpg7.flipup_sight", path .. "flipup_sight.wav")

if engine.ActiveGamemode() == "terrortown" then
    SWEP.AutoSpawnable = false
    SWEP.Kind = WEAPON_EQUIP
    SWEP.Slot  = 6
    SWEP.CanBuy = { ROLE_TRAITOR }
    SWEP.LimitedStock = true
    SWEP.EquipMenuData = {
        type = "Weapon",
        desc = "Rocket launcher. Can't explode at point blank.\nComes with 2 rockets.\n\nBEWARE: May be visible while holstered!",
    }

    function SWEP:TTTBought(buyer)
        buyer:GiveAmmo(1, "RPG_Round")
    end
end

function SWEP:ShouldAutoReload()
    return !self:GetValue("NoAutoReload")
end

function SWEP:DoOldSchoolScopeBehavior()
    return false
end