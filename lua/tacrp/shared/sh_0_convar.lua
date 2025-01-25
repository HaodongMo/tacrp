// the 0 is for load order!!!

local conVars = {
    {
        name = "pickuphint",
        default = "1",
        client = true
    },
    {
        name = "drawhud",
        default = "1",
        client = true
    },
    {
        name = "minhud",
        default = "1",
        client = true
    },
    {
        name = "autoreload",
        default = "1",
        client = true
    },
    {
        name = "autosave",
        default = "1",
        client = true,
        userinfo = true,
    },
    {
        name = "spawnmenu_subcats",
        default = "1",
        client = true,
    },
    {
        name = "spawnmenu_highlight",
        default = "1",
        client = true,
    },
    {
        name = "spawnmenu_sortbytiers",
        default = "1",
        client = true,
    },
    {
        name = "shutup",
        default = "0",
        client = true,
    },
    {
        name = "togglepeek",
        default = "1",
        client = true,
        userinfo = true,
    },
    {
        name = "bodydamagecancel",
        default = "1",
        replicated = true,
    },
    {
        name = "free_atts",
        default = "1",
        replicated = true,
        notify = true,
    },
    {
        name = "lock_atts",
        default = "1",
        replicated = true,
        notify = true,
    },
    {
        name = "loseattsondie",
        default = "1",
    },
    {
        name = "generateattentities",
        default = "1",
        replicated = true,
    },
    {
        name = "npc_equality",
        default = "0",
    },
    {
        name = "npc_atts",
        default = "1",
    },
    {
        name = "penetration",
        default = "1",
        replicated = true,
        notify = true,
    },
    {
        name = "freeaim",
        default = "1",
        replicated = true,
        notify = true,
    },
    {
        name = "sway",
        default = "1",
        replicated = true,
        notify = true,
    },
    {
        name = "physbullet",
        default = "1",
        replicated = true,
        notify = true,
    },
    {
        name = "resupply_grenades",
        default = "1",
    },
    {
        name = "fixedspread",
        default = "1",
        notify = true,
    },
    {
        name = "pelletspread",
        default = "1",
        notify = true,
    },
    {
        name = "client_damage",
        default = "0",
        replicated = true,
        notify = true,
    },
    {
        name = "true_laser",
        default = "1",
        client = true,
    },
    {
        name = "toggletactical",
        default = "1",
        replicated = true,
    },
    {
        name = "rock_funny",
        default = "0.05"
    },
    {
        name = "arcade",
        default = "1",
        replicated = true,
    },
    {
        name = "ammonames",
        default = "1",
        client = true
    },
    {
        name = "font1",
        default = "",
        client = true
    },
    {
        name = "font2",
        default = "",
        client = true
    },
    {
        name = "drawholsters",
        default = "1",
        client = true,
    },
    {
        name = "crosshair",
        default = "0",
        replicated = true,
        notify = true,
    },
    {
        name = "vignette",
        default = "1",
        client = true,
    },
    {
        name = "flash_dark",
        default = "0",
        client = true,
    },
    {
        name = "flash_slow",
        default = "0.4",
        min = 0,
        max = 1,
        replicated = true,
    },
    {
        name = "melee_slow",
        default = "0.4",
        min = 0,
        max = 1,
        replicated = true,
    },
    {
        name = "metricunit",
        default = "0",
        client = true,
    },
    {
        name = "nademenu",
        default = "1",
        client = true,
        userinfo = true,
    },
    {
        name = "nademenu_click",
        default = "1",
        client = true,
    },
    {
        name = "blindfiremenu",
        default = "1",
        client = true,
        userinfo = true,
    },
    {
        name = "blindfiremenu_nocenter",
        default = "0",
        client = true,
        userinfo = true,
    },
    {
        name = "gas_sway",
        default = "6",
        min = 0,
        max = 10,
        replicated = true,
    },
    {
        name = "idunwannadie",
        default = "0",
        client = true,
        userinfo = true,
    },
    {
        name = "aim_cancels_sprint",
        default = "1",
        client = true,
        userinfo = true,
        min = 0,
        max = 1,
    },
    {
        name = "holster",
        default = "1",
        replicated = true,
        notify = true,
    },
    {
        name = "news_majoronly",
        default = "0",
        client = true,
    },
    {
        name = "hud",
        default = "1",
        replicated = true,
        notify = true,
    },
    {
        name = "visibleholster",
        default = "1",
        replicated = true,
        notify = true,
    },
    {
        name = "checknews",
        default = "1",
        replicated = true,
    },
    {
        name = "radar_quiet",
        default = "0",
        client = true,
    },
    {
        name = "toggleaim",
        default = "0",
        client = true,
        userinfo = true,
    },
    {
        name = "toggleholdbreath",
        default = "0",
        client = true,
        userinfo = true,
    },
    {
        name = "flashlight_blind",
        default = "1",
        replicated = true,
        notify = true,
    },
    {
        name = "glint",
        default = "1",
        replicated = true,
        notify = true,
    },
    {
        name = "funny_loudnoises",
        default = "1",
        min = 0,
        max = 2,
        replicated = true,
    },
    {
        name = "balance",
        default = "-1",
        min = -1,
        max = 4,
        replicated = true,
        notify = true,
        callback = function(convar, old, new)
            if old != new and SERVER then
                TacRP.LoadAtts()
                TacRP.InvalidateCache()
                net.Start("tacrp_reloadatts")
                net.Broadcast()
            end
        end,
    },
    {
        name = "sprint_reload",
        default = "1",
        replicated = true,
        notify = true,
        min = 0,
        max = 1,
    },
    {
        name = "sprint_counts_midair",
        default = "0",
        replicated = true,
        notify = true,
        min = 0,
        max = 1,
    },
    {
        name = "sprint_lower",
        default = "1",
        replicated = true,
        notify = true,
        min = 0,
        max = 1,
    },
    {
        name = "reload_sg_cancel",
        default = "1",
        replicated = true,
        notify = true,
        min = 0,
        max = 1,
    },
    {
        name = "armorpenetration",
        default = "1",
        replicated = true,
        notify = true,
        min = 0,
        max = 1,
    },
    {
        name = "nearwall",
        default = "1",
        client = true,
    },
    {
        name = "hudscale",
        default = "1",
        client = true,
    },
    {
        name = "language",
        default = "",
        replicated = true,
        callback = function()
            if SERVER then
                TacRP:LoadLanguages()
                net.Start("tacrp_reloadlangs")
                net.Broadcast()
            end
        end
    },
    {
        name = "dev_benchgun",
        default = "0",
        client = true,
        noarchive = true,
    },
    {
        name = "altrecoil",
        default = "1",
        replicated = true,
        notify = true,
        min = 0,
        max = 1,
    },
    {
        name = "flashlight_alt",
        default = "0",
        client = true,
    },
    // --------------------------- Hints
    {
        name = "hints",
        default = "1",
        client = true,
    },
    {
        name = "hints_always",
        default = "0",
        client = true,
    },
    {
        name = "hints_altfont",
        default = "0",
        client = true,
    },

    // --------------------------- Movement Penalties

    {
        name = "penalty_move",
        default = "1",
        replicated = true,
        notify = true,
    },

    {
        name = "penalty_firing",
        default = "1",
        replicated = true,
        notify = true,
    },

    {
        name = "penalty_aiming",
        default = "1",
        replicated = true,
        notify = true,
    },

    {
        name = "penalty_reload",
        default = "1",
        replicated = true,
        notify = true,
    },

    {
        name = "penalty_melee",
        default = "1",
        replicated = true,
        notify = true,
    },

    // --------------------------- Ammo
    {
        name = "defaultammo",
        default = "2",
        replicated = true,
        notify = false,
        min = 0,
    },
    {
        name = "infiniteammo",
        default = "0",
        replicated = true,
        notify = true,
    },
    {
        name = "infinitelaunchers",
        default = "0",
        replicated = true,
        notify = true,
    },
    {
        name = "infinitegrenades",
        default = "0",
        replicated = true,
        notify = true,
    },

    // --------------------------- Slots
    {
        name = "slot_hl2",
        default = "0",
        replicated = true,
        notify = true,
        min = 0,
        max = 1,
    },
    {
        name = "slot_limit",
        default = "0",
        notify = true,
        replicated = true,
        min = 0,
    },
    {
        name = "slot_countall",
        default = "0",
        notify = true,
        replicated = true,
        min = 0,
        max = 1,
    },
    {
        name = "slot_action",
        default = "1",
        notify = true,
        replicated = true,
        min = 0,
        max = 2,
    },
    {
        name = "max_grenades",
        default = "9999",
        min = 0,
    },

    {
        name = "hud_ammo_number",
        default = "0",
        client = true,
        min = 0,
        max = 1
    },

    // --------------------------- Irons
    {
        name = "irons_lower",
        default = "1",
        replicated = true,
        notify = true,
        min = 0,
        max = 2,
    },
    {
        name = "irons_procedural",
        default = "1",
        notify = true,
        replicated = true,
        min = 0,
        max = 2,
    },

    // --------------------------- Attachments
    {
        name = "att_radartime",
        default = "1.5",
        replicated = true,
        min = 0.5,
    },

    // --------------------------- TTT
    {
        name = "ttt_weapon_include",
        default = "1",
        notify = true,
        replicated = true,
        min = 0,
        max = 1,
    },
    {
        name = "ttt_weapon_replace",
        default = "1", // fraction chance
        notify = true,
        replicated = true,
        min = 0,
        max = 1,
    },
    {
        name = "ttt_atts_random",
        default = "0.5", // fraction chance
        notify = true,
        replicated = true,
        min = 0,
        max = 1,
    },
    {
        name = "ttt_atts_max",
        default = "0", // fraction chance
        notify = true,
        replicated = true,
        min = 0,
    },
    {
        name = "ttt_atts_giveonspawn",
        default = "20",
        notify = true,
        replicated = true,
        min = 0,
    },
    {
        name = "ttt_cust_inno_allow",
        default = "1",
        notify = true,
        replicated = true,
        min = 0,
        max = 1,
    },
    {
        name = "ttt_cust_role_allow",
        default = "1",
        notify = true,
        replicated = true,
        min = 0,
        max = 1,
    },
    {
        name = "ttt_cust_inno_round",
        default = "1",
        notify = true,
        replicated = true,
        min = 0,
        max = 1,
    },
    {
        name = "ttt_cust_role_round",
        default = "1",
        notify = true,
        replicated = true,
        min = 0,
        max = 1,
    },
    {
        name = "ttt_cust_inno_needbench",
        default = "0",
        notify = true,
        replicated = true,
        min = 0,
        max = 1,
    },
    {
        name = "ttt_cust_role_needbench",
        default = "0",
        notify = true,
        replicated = true,
        min = 0,
        max = 1,
    },
    {
        name = "ttt_shortname",
        default = "1",
        replicated = true,
        notify = true,
        min = 0,
        max = 1,
    },
    {
        name = "ttt_magazine_dna",
        default = "1",
        replicated = true,
        notify = true,
        min = 0,
        max = 1,
    },
    {
        name = "ttt_bench_freeatts",
        default = "1",
        replicated = true,
        notify = true,
        min = 0,
        max = 1,
    },

    // Roleplay
    {
        name = "rp_requirebench",
        default = "0",
        replicated = true,
        notify = true,
    },
    {
        name = "rp_biocode_cp",
        default = "0",
        replicated = true,
        notify = true,
    },

    {
        name = "laser_beam",
        default = "0",
        replicated = true,
        min = 0,
        max = 1,
    },

    {
        name = "cust_legacy",
        default = "0",
        client = true,
        min = 0,
        max = 1,
    },
    {
        name = "muzzlelight",
        default = "1",
        client = true,
        min = 0,
        max = 1
    },
    {
        name = "recoilpattern",
        default = "1",
        replicated = true,
        notify = true,
        min = 0,
        max = 1,
    },

    {
        name = "allowdrop",
        default = "1",
        replicated = true,
        notify = true,
        min = 0,
        max = 1,
    },
    {
        name = "oldschool",
        default = "0",
        replicated = true,
        notify = true,
        min = 0,
        max = 1,
        callback = function(convar, old, new)
            if tonumber(new) == 1 and SERVER then
                TacRP.ConVars["sightsonly"]:SetBool(false)
            end
        end,
    },
    {
        name = "sightsonly",
        default = "0",
        replicated = true,
        notify = true,
        min = 0,
        max = 1,
        callback = function(convar, old, new)
            if tonumber(new) == 1 and SERVER then
                TacRP.ConVars["oldschool"]:SetBool(false)
            end
        end,
    },
    {
        name = "deploysafety",
        default = "0",
        replicated = true,
        notify = true,
        min = 0,
        max = 1,
    },


    {
        name = "cust_drop",
        default = "1",
        client = true,
        min = 0,
        max = 1,
    },
    {
        name = "pickup_use",
        default = "1",
        client = true,
        userinfo = true,
        min = 0,
        max = 1,
    },
    {
        name = "phystweak",
        default = "1",
        min = 0,
        max = 1,
        replicated = true,
    },
    {
        name = "doorbust",
        default = "1",
        min = 0,
        max = 1,
        replicated = true,
    },
    {
        name = "doorbust_time",
        default = "180",
        min = 1,
        replicated = true,
    },
    {
        name = "dynamiclight",
        default = "1",
        min = 0,
        max = 1,
        replicated = true,
    },
    {
        name = "inversepeek",
        default = "0",
        client = true,
        userinfo = true,
        min = 0,
        max = 1,
    },

    // --------------------------- Multipliers
    {
        name = "mult_damage",
        default = "1",
        min = 0.01,
        replicated = true,
    },
    {
        name = "mult_damage_shotgun",
        default = "1",
        min = 0.01,
        replicated = true,
    },
    {
        name = "mult_damage_sniper",
        default = "1",
        min = 0.01,
        replicated = true,
    },
    {
        name = "mult_damage_magnum",
        default = "1",
        min = 0.01,
        replicated = true,
    },
    {
        name = "mult_damage_explosive",
        default = "1",
        min = 0.01,
        replicated = true,
    },
    {
        name = "mult_recoil_kick",
        default = "1",
        min = 0,
        replicated = true,
    },
    {
        name = "mult_recoil_vis",
        default = "1",
        min = 0,
        replicated = true,
    },
    {
        name = "mult_reloadspeed",
        default = "1",
        min = 0.1,
        replicated = true,
    },
    {
        name = "mult_aimdownsights",
        default = "1",
        min = 0.1,
        replicated = true,
    },
    {
        name = "mult_sprinttofire",
        default = "1",
        min = 0.1,
        replicated = true,
    },
    {
        name = "mult_headshot",
        default = "1",
        min = 0,
        replicated = true,
    },
    {
        name = "mult_damage_melee",
        default = "1",
        min = 0.01,
        replicated = true,
    },

    {
        name = "recoilreset",
        default = "0",
        min = 0,
        max = 1,
        replicated = true,
    },
    {
        name = "reload_dump",
        default = "0",
        min = 0,
        max = 1,
        replicated = true,
    },
    {
        name = "ads_reload",
        default = "0",
        min = 0,
        max = 1,
        replicated = true
    },
    {
        name = "jam_autoclear",
        default = "0",
        min = 0,
        max = 1,
        replicated = true
    },
    {
        name = "expandedammotypes",
        default = "0",
        min = 0,
        notify = true,
        replicated = true,
    },
    {
        name = "dropmagazinemodel",
        default = "1",
        min = 0,
        max = 1,
        notify = true,
        replicated = true,
    },
    {
        name = "quicknade",
        default = "1",
        replicated = true,
        notify = true,
    },

    // --------------------------- Medkit
    {
        name = "medkit_clipsize",
        default = "30",
        min = 1,
        replicated = true,
    },
    {
        name = "medkit_regen_activeonly",
        default = "0",
        min = 0,
        max = 1,
        replicated = true,
    },
    {
        name = "medkit_regen_delay",
        default = "2",
        min = 0,
        replicated = true,
    },
    {
        name = "medkit_regen_amount",
        default = "1",
        min = 0,
        replicated = true,
        notify = true,
    },
    {
        name = "medkit_heal_self",
        default = "4",
        min = 0,
        replicated = true,
        notify = true,
    },
    {
        name = "medkit_heal_others",
        default = "4",
        min = 0,
        replicated = true,
        notify = true,
    },
    {
        name = "medkit_interval",
        default = "0.2",
        min = 0,
        replicated = true,
        notify = true,
    },

    // --------------------------- Riot Shield
    {
        name = "shield_melee",
        default = "1",
        min = 0,
        max = 1,
        replicated = true,
    },
    {
        name = "shield_knockback",
        default = "1",
        min = 0,
        max = 1,
        replicated = true,
    },
    {
        name = "shield_riot_resistance",
        default = "3.5",
        min = 0,
        replicated = true,
    },
    {
        name = "shield_riot_hp",
        default = "0",
        min = 0,
        replicated = true,
    },

    // --------------------------- Grenades
    {
        name = "smoke_affectnpcs",
        default = "1",
        min = 0,
        max = 1,
    },
    {
        name = "flash_affectnpcs",
        default = "1",
        min = 0,
        max = 1,
    },
    {
        name = "flash_affectplayers",
        default = "1",
        min = 0,
        max = 1,
    },
    {
        name = "gas_affectnpcs",
        default = "1",
        min = 0,
        max = 1,
    },
    {
        name = "gas_affectplayers",
        default = "1",
        min = 0,
        max = 1,
    },
    {
        name = "thermite_damage_min",
        default = "20",
        min = 0,
    },
    {
        name = "thermite_damage_max",
        default = "40",
        min = 0,
    },
    {
        name = "thermite_radius",
        default = "200",
        min = 0,
    },
    {
        name = "frag_damage",
        default = "150",
        min = 0,
    },
    {
        name = "frag_radius",
        default = "350",
        min = 0,
    },
    {
        name = "charge_damage",
        default = "500",
        min = 0,
    },
    {
        name = "charge_radius",
        default = "200",
        min = 0,
    },
    {
        name = "c4_damage",
        default = "300",
        min = 0,
    },
    {
        name = "c4_radius",
        default = "400",
        min = 0,
    },
    {
        name = "healnade_heal",
        default = "3",
        min = 0,
    },
    {
        name = "healnade_armor",
        default = "1",
        min = 0,
    },
    {
        name = "healnade_damage",
        default = "20",
        min = 0,
    },

    // Aim Assist
    {
        name = "aimassist",
        default = "0",
        replicated = true,
        notify = true,
    },
    {
        name = "aimassist_head",
        default = "0",
        replicated = true,
        notify = true,
    },
    {
        name = "aimassist_intensity",
        default = "1",
        replicated = true,
        notify = true,
    },
    {
        name = "aimassist_cone",
        default = "5",
        replicated = true,
        notify = true,
    },
    {
        name = "aimassist_cl",
        default = "1",
        client = true,
    },
    {
        name = "aimassist_multsens",
        default = "0.75",
        client = true,
    },
    {
        name = "aimsens",
        default = "1",
        client = true,
    },
}

TacRP.ConVars = {}

local prefix = "tacrp_"

function TacRP.NetworkConvar(convar, old_value, value)
    if IsValid(LocalPlayer()) and !LocalPlayer():IsAdmin() then return end
    if old_value == value then return end
    if value == true or value == false then
        value = value and 1 or 0
    end
    if IsColor(value) then
        value = tostring(value.r) .. " " .. tostring(value.g) .. " " .. tostring(value.b) .. " " .. tostring(value.a)
    end

    local command = convar .. " " .. tostring(value)

    local timername = "change" .. convar

    if timer.Exists(timername) then
        timer.Remove(timername)
    end

    timer.Create(timername, 0.25, 1, function()
        net.Start("tacrp_sendconvar")
        net.WriteString(command)
        net.SendToServer()
    end)
end

local flags = {
    ["replicated"] = FCVAR_REPLICATED,
    ["userinfo"] = FCVAR_USERINFO,
    ["notify"] = FCVAR_NOTIFY
}
for _, var in pairs(conVars) do
    local convar_name = prefix .. var.name

    if var.client and CLIENT then
        TacRP.ConVars[var.name] = CreateClientConVar(convar_name, var.default, !var.noarchive, var.userinfo)
    elseif !var.client then
        local flag = FCVAR_ARCHIVE
        for k, v in pairs(flags) do if var[k] then flag = flag + v end end
        TacRP.ConVars[var.name] = CreateConVar(convar_name, var.default, flag, var.help, var.min, var.max)
    end

    if var.callback then
        cvars.AddChangeCallback(convar_name, var.callback, "tacrp")
    end

    if CLIENT then
        cvars.AddChangeCallback(convar_name, TacRP.NetworkConvar, "tacrp_onchange")
    end
end

if CLIENT then

local function reset_cvars()
    for _, cvar in pairs(TacRP.ConVars) do
        if bit.band(cvar:GetFlags(), FCVAR_LUA_CLIENT) != 0 then
            cvar:Revert()
        end
    end
end

local function header(panel, text)
    local ctrl = panel:Help(text)
    ctrl:SetFont("DermaDefaultBold")
    return ctrl
end

local function menu_client_ti(panel)

    local btn_reset = vgui.Create("DButton")
    btn_reset:Dock(TOP)
    btn_reset:SetText("#tacrp.client.default") -- Apply Default Client Settings
    function btn_reset.DoClick(self)
        Derma_Query(
            "#tacrp.client.default.warning",
            "TacRP",
            "#openurl.yes", -- Yes
            function()
                reset_cvars()
            end,
            "#openurl.nope" -- Nope
        )
    end
    panel:AddPanel(btn_reset)

    header(panel, "#tacrp.client.interface") -- Interface
    panel:AddControl("checkbox", {
        label = "#tacrp.client.hud", -- Show HUD
        command = "TacRP_drawhud"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.client.backuphud", -- Show Backup HUD
        command = "tacrp_minhud"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.client.quickthrowradial", -- Quickthrow Radial Menu
        command = "tacrp_nademenu"
    })
    panel:ControlHelp("#tacrp.client.quickthrowradial.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.client.quickthrowclick", -- Quickthrow Menu Clicking
        command = "tacrp_nademenu_click"
    })
    panel:ControlHelp("#tacrp.client.quickthrowclick.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.client.blindfireradial", -- Blindfire Radial Menu
        command = "tacrp_blindfiremenu"
    })
    panel:ControlHelp("#tacrp.client.blindfireradial.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.client.blindfireemptymid", -- Blindfire Menu Empty Center
        command = "tacrp_blindfiremenu_nocenter"
    })
    panel:ControlHelp("#tacrp.client.blindfireemptymid.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.client.usemeters", -- Use Meters instead of Hammer Units
        command = "tacrp_metricunit"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.client.recoilvignette", -- Recoil Vignette
        command = "tacrp_vignette"
    })
    panel:ControlHelp("#tacrp.client.recoilvignette.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.client.dropweaponbutton", -- Show "Drop Weapon" Button
        command = "tacrp_cust_drop"
    })
    panel:AddControl("slider", {
        label = "#tacrp.client.hudscale", -- HUD Scale
        command = "tacrp_hudscale",
        type = "float",
        min = 0.25,
        max = 1.5,
    })
    panel:ControlHelp("#tacrp.client.hudscale.desc")

    header(panel, "#tacrp.client.hints") -- \nHints
    panel:AddControl("checkbox", {
        label = "#tacrp.client.controlhints", -- Display Control Hints
        command = "tacrp_hints"
    })
    panel:ControlHelp("#tacrp.client.controlhints.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.client.hintsalways", -- Always Display Hints
        command = "tacrp_hints_always"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.client.hintsaltfont", -- Hints Use Alternate Font
        command = "tacrp_hints_altfont"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.client.hintsquickthrowremind", -- Hide Startup Quickthrow Bind Reminder
        command = "tacrp_shutup"
    })

    header(panel, "#tacrp.client.preference") -- \nPreference
    panel:AddControl("checkbox", {
        label = "#tacrp.client.toggleaim", -- Toggle Aiming
        command = "tacrp_toggleaim"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.client.togglepeek", -- Toggle Peeking
        command = "tacrp_togglepeek"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.client.inversepeek", -- Invert Peeking
        command = "tacrp_inversepeek"
    })
    panel:ControlHelp("#tacrp.client.inversepeek.desc")

    panel:AddControl("slider", {
        label = "#tacrp.client.aimsens", -- Aiming Sensitivity
        command = "tacrp_aimsens",
        type = "float",
        min = 0.1,
        max = 1,
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.client.aimstopssprint", -- Aiming Stops Sprinting
        command = "tacrp_aim_cancels_sprint"
    })
    panel:ControlHelp("#tacrp.client.aimstopssprint.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.client.autosave", -- Auto-Save Weapon
        command = "TacRP_autosave"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.client.autoreload", -- Auto Reload When Empty
        command = "TacRP_autoreload"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.client.flashdark", -- Flashbang Dark Mode
        command = "tacrp_flash_dark"
    })
    panel:ControlHelp("#tacrp.client.flashdark.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.client.quietradar", -- Quiet Radar
        command = "tacrp_radar_quiet"
    })
    panel:ControlHelp("#tacrp.client.quietradar.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.client.pickupuse", -- Pickup Requires +USE
        command = "tacrp_pickup_use"
    })
    panel:ControlHelp("#tacrp.client.pickupuse.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.client.toggletacticalwalk", -- Toggle Tactical with +WALK
        command = "tacrp_flashlight_alt"
    })
    panel:ControlHelp("#tacrp.client.toggletacticalwalk.desc")

    panel:AddControl("checkbox", {
        label = "#tacrp.client.aimassist", -- Enable Aim Assist
        command = "tacrp_aimassist_cl"
    })
    panel:ControlHelp("#tacrp.client.aimassist.desc")

    header(panel, "#tacrp.client.spawnmenu") -- Spawnmenu
    panel:ControlHelp("#tacrp.client.spawnmenu.desc")

    panel:AddControl("checkbox", {
        label = "#tacrp.client.subcategory", -- Subcategory Headers
        command = "tacrp_spawnmenu_subcats"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.client.sortbytier", -- Sort by Tiers
        command = "tacrp_spawnmenu_sortbytiers"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.client.tierhighlight", -- Tier Highlights
        command = "tacrp_spawnmenu_highlight"
    })
    panel:ControlHelp("#tacrp.client.tierhighlight.desc")

    header(panel, "#tacrp.mechanics.misc") -- Misc.
    panel:AddControl("checkbox", {
        label = "#tacrp.client.muzzlelight", --Muzzle Light
        command = "tacrp_muzzlelight"
    })
    panel:ControlHelp("#tacrp.client.muzzlelight.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.client.nearwall", -- Near Walling
        command = "tacrp_nearwall"
    })
    panel:ControlHelp("#tacrp.client.nearwall.desc")

    panel:AddControl("checkbox", {
        label = "#tacrp.client.disablesuicide", -- Disable Suicide Mode
        command = "tacrp_idunwannadie"
    })
    panel:ControlHelp("#tacrp.client.disablesuicide.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.client.drawholstered", -- Draw Holstered Weapons
        command = "tacrp_drawholsters"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.client.truelaser", -- True Laser Position
        command = "tacrp_true_laser"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.client.immersivenames", -- Immersive Ammo Names
        command = "tacrp_ammonames"
    })
    panel:ControlHelp("#tacrp.client.immersivenames.desc")
end

local function menu_server_ti(panel)
    header(panel, "#tacrp.server.features") -- Features
    panel:Help("#tacrp.server.features.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.server.enablecrosshair", -- Enable Crosshair
        command = "tacrp_crosshair"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.server.hud", -- Allow HUD
        command = "tacrp_hud"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.server.holsteredmodels", -- Holstered Weapon Models
        command = "tacrp_visibleholster"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.server.newsletter", -- Enable Newsletter
        command = "tacrp_checknews"
    })
    panel:ControlHelp("#tacrp.server.newsletter.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.server.allowdrop", -- Allow Dropping & Swapping Weapons
        command = "tacrp_allowdrop"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.server.safeondeploy", -- Enable Safety On Deploy
        command = "tacrp_deploysafety"
    })

    local cb_irons_procedural, lb_irons_procedural = panel:ComboBox("#tacrp.server.proceduralirons", "tacrp_irons_procedural") -- Use Procedural Iron Sights
    cb_irons_procedural:AddChoice("#tacrp.server.proceduralirons.0", "0") -- 0 - Never
    cb_irons_procedural:AddChoice("#tacrp.server.proceduralirons.1", "1") -- 1 - With Optic
    cb_irons_procedural:AddChoice("#tacrp.server.proceduralirons.2", "2") -- 2 - Always
    cb_irons_procedural:DockMargin(8, 0, 0, 0)
    lb_irons_procedural:SizeToContents()
    panel:ControlHelp("#tacrp.server.proceduralirons.desc")

    local cb_irons_lower, lb_irons_lower = panel:ComboBox("#tacrp.server.loweredirons", "tacrp_irons_lower") -- Use Lowered Iron Sights
    cb_irons_lower:AddChoice("#tacrp.server.loweredirons.0", "0") -- 0 - Never
    cb_irons_lower:AddChoice("#tacrp.server.loweredirons.1", "1") -- 1 - Only in TTT
    cb_irons_lower:AddChoice("#tacrp.server.loweredirons.2", "2") -- 2 - Always
    cb_irons_lower:DockMargin(8, 0, 0, 0)
    lb_irons_lower:SizeToContents()
    panel:ControlHelp("#tacrp.server.loweredirons.desc")

    panel:AddControl("checkbox", {
        label = "#tacrp.server.aimassist", -- Allow Aim Assist
        command = "tacrp_aimassist"
    })
    panel:ControlHelp("#tacrp.server.aimassist.desc")

    panel:AddControl("slider", {
        label = "#tacrp.server.aimassistintensity", -- Aim Assist Intensity
        command = "tacrp_aimassist_intensity",
        type = "float",
        min = 0,
        max = 2,
    })
    panel:ControlHelp("#tacrp.server.aimassistintensity.desc")

    panel:AddControl("slider", {
        label = "#tacrp.server.aimassistcone", -- Aim Assist Cone
        command = "tacrp_aimassist_cone",
        type = "int",
        min = 0,
        max = 10,
    })
    panel:ControlHelp("#tacrp.server.aimassistcone.desc")

    header(panel, "#tacrp.server.slotrestrict") -- Weapon Slot Restriction
    panel:ControlHelp("#tacrp.server.slotrestrict.desc")
    panel:AddControl("slider", {
        label = "#tacrp.server.maxperslot", -- Max per Slot
        command = "tacrp_slot_limit",
        type = "int",
        min = 0,
        max = 3,
    })
    panel:ControlHelp("#tacrp.server.maxperslot.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.server.hl2slots", -- Use HL2-style Slots
        command = "tacrp_slot_hl2"
    })
    panel:ControlHelp("#tacrp.server.hl2slots.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.server.countall", -- Count ALL Weapons
        command = "tacrp_slot_countall"
    })
    panel:ControlHelp("#tacrp.server.countall.desc")

    local cb_slot_action, lb_slot_action = panel:ComboBox("#tacrp.server.spawnbehavior", "tacrp_slot_action") -- Weapon Spawning Behavior
    cb_slot_action:AddChoice("#tacrp.server.spawnbehavior.0", "0") -- 0 - Ignore
    cb_slot_action:AddChoice("#tacrp.server.spawnbehavior.1", "1") -- 1 - Remove
    cb_slot_action:AddChoice("#tacrp.server.spawnbehavior.2", "2") -- 2 - Drop
    cb_slot_action:DockMargin(8, 0, 0, 0)
    lb_slot_action:SizeToContents()

    panel:ControlHelp("#tacrp.server.spawnbehavior.desc")

    header(panel, "#tacrp.server.npc") -- \nNPC
    panel:AddControl("checkbox", {
        label = "#tacrp.server.npcequaldmg", -- NPC's Deal Equal Damage
        command = "TacRP_npc_equality"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.server.npcrandomatt", -- NPC's Get Random Attachments
        command = "TacRP_npc_atts"
    })


    header(panel, "#tacrp.mechanics.misc") -- \nMiscellaneous
    panel:AddControl("checkbox", {
        label = "#tacrp.server.clienthitreg", -- Client Authoratitive Hitreg
        command = "tacrp_client_damage"
    })
    panel:ControlHelp("#tacrp.server.clienthitreg.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.server.dropmag", -- Drop Magazine Models
        command = "tacrp_dropmagazinemodel"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.server.supplyboxgrenades", -- Supply Boxes Resupply Grenades
        command = "TacRP_resupply_grenades"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.server.canceldefaultbodydmg", -- Default Body Damage Cancel
        command = "TacRP_bodydamagecancel"
    })
    panel:ControlHelp("#tacrp.server.canceldefaultbodydmg.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.server.doorbust", -- Enable Door Busting
        command = "tacrp_doorbust"
    })
    panel:ControlHelp("#tacrp.server.doorbust.desc")
    panel:AddControl("slider", {
        label = "#tacrp.server.doorrespawntime", -- Door Respawn Time
        command = "tacrp_doorbust_time",
        type = "int",
        min = 10,
        max = 600,
    })
    panel:ControlHelp("#tacrp.server.doorrespawntime.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.server.dynamiclight", -- Enable Dynamic Lights
        command = "tacrp_dynamiclight"
    })
    panel:ControlHelp("#tacrp.server.dynamiclight.desc")
end

local function menu_balance_ti(panel)
    header(panel, "#tacrp.balance.damage") -- Damage
    panel:Help("#tacrp.balance.damage.desc")
    local cb_balance, lb_balance = panel:ComboBox("#tacrp.balance.weapontier", "tacrp_balance")
    cb_balance:AddChoice("#tacrp.balance.weapontier.3", "-1") -- [ Automatic ]
    cb_balance:AddChoice("#tacrp.balance.weapontier.0", "0") -- 0 - Tiered
    cb_balance:AddChoice("#tacrp.balance.weapontier.1", "1") -- 1 - Untiered
    cb_balance:AddChoice("#tacrp.balance.weapontier.2", "2") -- 2 - TTT
    cb_balance:DockMargin(8, 0, 0, 0)
    lb_balance:SizeToContents()
    panel:Help("#tacrp.balance.weapontier.desc")
    panel:Help("#tacrp.balance.weapontier.desc2")
    panel:Help("#tacrp.balance.weapontier.desc3")

    panel:AddControl("slider", {
        label = "#tacrp.balance.dmg", -- Overall Damage
        command = "tacrp_mult_damage",
        type = "float",
        min = 0.1,
        max = 3,
    })
    panel:ControlHelp("#tacrp.balance.dmg.desc")
    panel:AddControl("slider", {
        label = "#tacrp.balance.shotgundmg", -- Shotgun Damage
        command = "tacrp_mult_damage_shotgun",
        type = "float",
        min = 0.1,
        max = 3,
    })
    panel:AddControl("slider", {
        label = "#tacrp.balance.sniperdmg", -- Sniper Rifle Damage
        command = "tacrp_mult_damage_sniper",
        type = "float",
        min = 0.1,
        max = 3,
    })
    panel:AddControl("slider", {
        label = "#tacrp.balance.magnumdmg", -- Magnum Pistol Damage
        command = "tacrp_mult_damage_magnum",
        type = "float",
        min = 0.1,
        max = 3,
    })
    panel:AddControl("slider", {
        label = "#tacrp.balance.explosivedmg", -- Explosive Damage
        command = "tacrp_mult_damage_explosive",
        type = "float",
        min = 0.1,
        max = 10,
    })
    panel:ControlHelp("#tacrp.balance.explosivedmg.desc")
    panel:AddControl("slider", {
        label = "#tacrp.balance.meleewpndmg", -- Melee Weapon Damage
        command = "tacrp_mult_damage_melee",
        type = "float",
        min = 0.1,
        max = 3,
    })
    panel:ControlHelp("#tacrp.balance.meleewpndmg.desc")
    panel:AddControl("slider", {
        label = "#tacrp.balance.headshotmult", -- Headshot Multiplier
        command = "tacrp_mult_headshot",
        type = "float",
        min = 0,
        max = 2,
    })
    panel:ControlHelp("#tacrp.balance.headshotmult.desc")


    header(panel, "#tacrp.balance.recoil") -- \nRecoil
    panel:AddControl("checkbox", {
        label = "#tacrp.balance.bloommodrecoil", -- Bloom Modifies Recoil
        command = "tacrp_altrecoil"
    })
    panel:ControlHelp("#tacrp.balance.bloommodrecoil.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.balance.recoilpattern", -- Recoil Patterns
        command = "tacrp_recoilpattern"
    })
    panel:ControlHelp("#tacrp.balance.recoilpattern.desc")
    panel:AddControl("slider", {
        label = "#tacrp.balance.recoilkick", -- Recoil Kick
        command = "tacrp_mult_recoil_kick",
        type = "float",
        min = 0,
        max = 2,
    })
    panel:AddControl("slider", {
        label = "#tacrp.balance.visualrecoil", -- Visual Recoil
        command = "tacrp_mult_recoil_vis",
        type = "float",
        min = 0,
        max = 2,
    })

    header(panel, "#tacrp.balance.aiming") -- \nAiming
    panel:AddControl("checkbox", {
        label = "#tacrp.balance.crosshair", -- Enable Crosshair
        command = "tacrp_crosshair"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.balance.oldschoolscopes", -- Enable Old-School Scopes
        command = "tacrp_oldschool"
    })
    panel:ControlHelp("#tacrp.balance.oldschoolscopes.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.balance.sway", -- Enable Sway
        command = "tacrp_sway"
    })
    panel:ControlHelp("#tacrp.balance.sway.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.balance.freeaim", -- Enable Free Aim
        command = "tacrp_freeaim"
    })
    panel:ControlHelp("#tacrp.balance.freeaim.desc")
    panel:AddControl("slider", {
        label = "#tacrp.balance.adstime", -- Aim Down Sights Time Multiplier
        command = "tacrp_mult_aimdownsights",
        type = "float",
        min = 0.5,
        max = 1.5,
    })
    panel:AddControl("slider", {
        label = "#tacrp.balance.sprinttofiretime", -- Sprint-to-Fire Time Multiplier
        command = "tacrp_mult_sprinttofire",
        type = "float",
        min = 0.5,
        max = 1.5,
    })


    header(panel, "#tacrp.balance.ammoreload") -- \nAmmo & Reloading
    panel:AddControl("checkbox", {
        label = "#tacrp.balance.infammo", -- Infinite Ammo
        command = "tacrp_infiniteammo"
    })
    panel:ControlHelp("#tacrp.balance.infammo.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.balance.inflaunchers", -- Infinite Ammo
        command = "tacrp_infinitelaunchers"
    })
    panel:ControlHelp("#tacrp.balance.inflaunchers.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.balance.infgren", -- Infinite Grenades
        command = "tacrp_infinitegrenades"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.balance.dumpammo", -- Dump Ammo In Magazines
        command = "tacrp_reload_dump"
    })
    panel:ControlHelp("#tacrp.balance.dumpammo.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.balance.autoclearjam", -- Automatically Clear Jams
        command = "tacrp_jam_autoclear"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.balance.expandammotype", -- Expanded Ammo Types
        command = "tacrp_expandedammotypes"
    })
    panel:ControlHelp("#tacrp.balance.expandammotype.desc")
    panel:AddControl("slider", {
        label = "#tacrp.balance.defaultclipmult", -- Default Clip Multiplier
        command = "tacrp_defaultammo",
        type = "float",
        min = 0,
        max = 10,
    })
    panel:AddControl("slider", {
        label = "#tacrp.balance.reloadspeed", -- Reload Speed Multiplier
        command = "tacrp_mult_reloadspeed",
        type = "float",
        min = 0.5,
        max = 1.5,
    })
    panel:ControlHelp("\n")
end

local function menu_mechanics_ti(panel)
    header(panel, "#tacrp.mechanics.ballistics") -- Ballistics
    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.penetration", -- Enable Bullet Penetration
        command = "TacRP_penetration"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.physbullets", -- Enable Physical Bullets
        command = "TacRP_physbullet"
    })
    panel:ControlHelp("#tacrp.mechanics.physbullets.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.shotgunpattern", -- Enable Shotgun Patterns
        command = "tacrp_fixedspread"
    })
    panel:ControlHelp("#tacrp.mechanics.shotgunpattern.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.randompattern", -- Enable Pattern Randomness
        command = "tacrp_pelletspread"
    })
    panel:ControlHelp("#tacrp.mechanics.randompattern.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.customarmorpen", -- Custom Armor Penetration
        command = "tacrp_armorpenetration"
    })
    panel:ControlHelp("#tacrp.mechanics.customarmorpen.desc")

    header(panel, "#tacrp.mechanics.movement") -- \nMovement
    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.reloadsprint", -- Allow Reload while Sprinting
        command = "tacrp_sprint_reload"
    })
    panel:ControlHelp("#tacrp.mechanics.reloadsprint.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.lowersprint", -- Lower Weapon While Sprinting
        command = "tacrp_sprint_lower"})
    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.lowerair", -- Lower Weapon While Airborne
        command = "tacrp_sprint_counts_midair"})
    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.lowerhipfire", -- Lower Weapon While Not Aiming
        command = "tacrp_sightsonly"
    })
    panel:ControlHelp("#tacrp.mechanics.lowerhipfire.desc")

    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.penaltymove", -- Movement Penalty
        command = "tacrp_penalty_move"
    })
    panel:ControlHelp("#tacrp.mechanics.penaltymove.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.penaltyfire", -- Firing Movement Penalty
        command = "tacrp_penalty_firing"
    })
    panel:ControlHelp("#tacrp.mechanics.penaltyfire.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.penaltyaim", -- Aiming Movement Penalty
        command = "tacrp_penalty_aiming"
    })
    panel:ControlHelp("#tacrp.mechanics.penaltyaim.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.penaltyreload", -- Reload Movement Penalty
        command = "tacrp_penalty_reload"
    })
    panel:ControlHelp("#tacrp.mechanics.penaltyreload.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.penaltymelee", -- Melee Movement Penalty
        command = "tacrp_penalty_melee"
    })
    panel:ControlHelp("#tacrp.mechanics.penaltymelee.desc")

    header(panel, "#tacrp.mechanics.misc") -- \nMiscellaneous
    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.delayholster", -- Delayed Holstering
        command = "tacrp_holster"
    })
    panel:ControlHelp("#tacrp.mechanics.delayholster.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.shotgunreloadcancel", -- Shotgun Reload Cancel
        command = "tacrp_reload_sg_cancel"
    })
    panel:ControlHelp("#tacrp.mechanics.shotgunreloadcancel.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.reloadaim", -- Allow Aiming While Reloading
        command = "tacrp_ads_reload"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.mechanics.quicknade", -- Enable Quick Grenades
        command = "tacrp_quicknade"
    })
end

local function menu_atts_ti(panel)
    header(panel, "#tacrp.attachments.inventory") -- Attachment Inventory
    panel:AddControl("checkbox", {
        label = "#tacrp.attachments.free", -- Free Attachments
        command = "TacRP_free_atts"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.attachments.locking", -- Attachment Locking
        command = "TacRP_lock_atts"
    })
    panel:ControlHelp("#tacrp.attachments.locking.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.attachments.ondeath", -- Lose Attachments on Death
        command = "TacRP_loseattsondie"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.attachments.spawnmenu", -- Attachment Entities in Spawnmenu
        command = "TacRP_generateattentities"
    })

    header(panel, "#tacrp.attachments.mechanics") -- \nAttachment Mechanics
    panel:AddControl("checkbox", {
        label = "#tacrp.attachments.scopeglint", -- Enable Scope Glint
        command = "tacrp_glint"
    })
    panel:ControlHelp("#tacrp.attachments.scopeglint.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.attachments.blindflashlight", -- Enable Blinding Flashlight
        command = "tacrp_flashlight_blind"
    })
    panel:ControlHelp("#tacrp.attachments.blindflashlight.desc")
    panel:AddControl("checkbox", {
        label = "#tacrp.attachments.laserbeam", -- Laser beam
        command = "tacrp_laser_beam"
    })
    panel:ControlHelp("#tacrp.attachments.laserbeam.desc")

    header(panel, "#tacrp.attachments.balance") -- \nAttachment Balance
    panel:AddControl("slider", {
        label = "#tacrp.attachments.smackdown", -- Smackdown Slow
        command = "tacrp_melee_slow",
        type = "float",
        min = 0,
        max = 1,
    })
    panel:AddControl("slider", {
        label = "#tacrp.attachments.radarfreq", -- Radar Frequency
        command = "tacrp_att_radartime",
        type = "float",
        min = 0.5,
        max = 10,
    })
end


local function menu_equipment_ti(panel)
    header(panel, "#tacrp.equipment.grenades") -- Grenades
    panel:AddControl("checkbox", {
        label = "#tacrp.equipment.smokenpcs", -- Smoke affects NPCs
        command = "tacrp_smoke_affectnpcs"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.equipment.flashnpcs", -- Flashbangs affect NPCs
        command = "tacrp_flash_affectnpcs"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.equipment.flashplayers", -- Flashbangs affect Players
        command = "tacrp_flash_affectplayers"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.equipment.gasnpcs", -- CS Gas affect NPCs
        command = "tacrp_gas_affectnpcs"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.equipment.gasplayers", -- CS Gas affect Players
        command = "tacrp_gas_affectplayers"
    })
    panel:AddControl("slider", {
        label = "#tacrp.equipment.flashslow", -- Flashbang Slow
        command = "tacrp_flash_slow",
        type = "float",
        min = 0,
        max = 1,
    })
    panel:AddControl("slider", {
        label = "#tacrp.equipment.fragdmg", -- Frag Grenade Damage
        command = "tacrp_frag_damage",
        type = "int",
        min = 50,
        max = 500,
    })
    panel:AddControl("slider", {
        label = "#tacrp.equipment.fragradius", -- Frag Grenade Radius
        command = "tacrp_frag_radius",
        type = "int",
        min = 64,
        max = 512,
    })
    panel:AddControl("slider", {
        label = "#tacrp.equipment.thermitedmg", -- Thermite Starting Damage
        command = "tacrp_thermite_damage_min",
        type = "int",
        min = 1,
        max = 100,
    })
    panel:AddControl("slider", {
        label = "#tacrp.equipment.thermitedmgmax", -- Thermite Maximum Damage
        command = "tacrp_thermite_damage_max",
        type = "int",
        min = 1,
        max = 100,
    })
    panel:AddControl("slider", {
        label = "#tacrp.equipment.thermiteradius", -- Thermite Radius
        command = "tacrp_thermite_radius",
        type = "int",
        min = 64,
        max = 512,
    })
    panel:ControlHelp("#tacrp.equipment.thermiteradius.desc")
    panel:AddControl("slider", {
        label = "#tacrp.equipment.doorchargedmg", -- Door Charge Damage
        command = "tacrp_charge_damage",
        type = "int",
        min = 100,
        max = 1000,
    })
    panel:AddControl("slider", {
        label = "#tacrp.equipment.doorchargeradius", -- Door Charge Radius
        command = "tacrp_charge_radius",
        type = "int",
        min = 64,
        max = 512,
    })
    panel:AddControl("slider", {
        label = "#tacrp.equipment.c4dmg", -- C4 Damage
        command = "tacrp_c4_damage",
        type = "int",
        min = 100,
        max = 1000,
    })
    panel:AddControl("slider", {
        label = "#tacrp.equipment.c4radius", -- C4 Radius
        command = "tacrp_c4_radius",
        type = "int",
        min = 64,
        max = 512,
    })
    panel:ControlHelp("#tacrp.equipment.c4radius.desc")
    panel:AddControl("slider", {
        label = "#tacrp.equipment.medismokehealth", -- Medi-Smoke Health
        command = "tacrp_healnade_heal",
        type = "int",
        min = 0,
        max = 20,
    })
    panel:AddControl("slider", {
        label = "#tacrp.equipment.medismokearmor", -- Medi-Smoke Armor
        command = "tacrp_healnade_heal",
        type = "int",
        min = 0,
        max = 20,
    })
    panel:AddControl("slider", {
        label = "#tacrp.equipment.medismokedmg", -- Medi-Smoke Damage
        command = "tacrp_healnade_damage",
        type = "int",
        min = 0,
        max = 100,
    })
    panel:ControlHelp("#tacrp.equipment.medismokedmg.desc")
    panel:AddControl("slider", {
        label = "#tacrp.equipment.csgassway", -- CS Gas Sway
        command = "tacrp_gas_sway",
        type = "float",
        min = 0,
        max = 10,
    })

    header(panel, "#tacrp.equipment.medkit") -- \nMedkit
    panel:AddControl("checkbox", {
        label = "#tacrp.equipment.onlywhenheld", -- Only Regen Charge When Held
        command = "tacrp_medkit_regen_activeonly"
    })
    panel:AddControl("slider", {
        label = "#tacrp.equipment.maxcharge", -- Max Charge
        command = "tacrp_medkit_clipsize",
        type = "int",
        min = 10,
        max = 100,
    })
    panel:AddControl("slider", {
        label = "#tacrp.equipment.chargeregentime", -- Charge Regen Interval
        command = "tacrp_medkit_regen_delay",
        type = "float",
        min = 0.01,
        max = 5,
    })
    panel:AddControl("slider", {
        label = "#tacrp.equipment.chargeregennr", -- Charge Regen Amount
        command = "tacrp_medkit_regen_amount",
        type = "int",
        min = 0,
        max = 3,
    })
    panel:ControlHelp("#tacrp.equipment.chargeregennr.desc")

    panel:AddControl("slider", {
        label = "#tacrp.equipment.selfhealpercharge", -- Self Heal Per Charge
        command = "tacrp_medkit_heal_self",
        type = "int",
        min = 0,
        max = 10,
    })
    panel:ControlHelp("#tacrp.equipment.selfhealpercharge.desc")
    panel:AddControl("slider", {
        label = "#tacrp.equipment.healpercharge", -- Heal Per Charge
        command = "tacrp_medkit_heal_others",
        type = "int",
        min = 0,
        max = 10,
    })
    panel:ControlHelp("#tacrp.equipment.healpercharge.desc")
    panel:AddControl("slider", {
        label = "#tacrp.equipment.chargetime", -- Charge Interval
        command = "tacrp_medkit_interval",
        type = "float",
        min = 0.01,
        max = 1,
    })
    panel:ControlHelp("#tacrp.equipment.chargetime.desc")

    header(panel, "#tacrp.equipment.riotshield") -- \nRiot Shield
    panel:AddControl("checkbox", {
        label = "#tacrp.equipment.allowquickmelee", -- Allow Quick Melee
        command = "tacrp_shield_melee"
    })
    panel:AddControl("checkbox", {
        label = "#tacrp.equipment.knockbackonblock", -- Knockback On Melee Block
        command = "tacrp_shield_knockback"
    })
    panel:AddControl("slider", {
        label = "#tacrp.equipment.penetrationresist", -- Penetration Resistance
        command = "tacrp_shield_riot_resistance",
        type = "float",
        min = 0,
        max = 5,
    })
    panel:ControlHelp("#tacrp.equipment.penetrationresist.desc")
    panel:AddControl("slider", {
        label = "#tacrp.equipment.durability", -- Durability
        command = "tacrp_shield_riot_hp",
        type = "int",
        min = 0,
        max = 9999,
    })
    panel:ControlHelp("#tacrp.equipment.durability.desc")

end

local clientmenus_ti = {
    {
        text = "#tacrp.settings.client", func = menu_client_ti
    },
    {
        text = "#tacrp.settings.server", func = menu_server_ti
    },
    {
        text = "#tacrp.settings.mechanics", func = menu_mechanics_ti
    },
    {
        text = "#tacrp.settings.attachments", func = menu_atts_ti
    },
    {
        text = "#tacrp.settings.balance", func = menu_balance_ti
    },
    {
        text = "#tacrp.settings.equipment", func = menu_equipment_ti
    },
}

hook.Add("PopulateToolMenu", "TacRP_MenuOptions", function()
    for smenu, data in pairs(clientmenus_ti) do
        spawnmenu.AddToolMenuOption("Options", "Tactical RP Weapons", "TacRP_" .. tostring(smenu), data.text, "", "", data.func)
    end
end)

end