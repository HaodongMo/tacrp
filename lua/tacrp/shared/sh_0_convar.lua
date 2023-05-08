// the 0 is for load order!!!

local conVars = {
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
        client = true
    },
    {
        name = "subcats",
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
    },
    {
        name = "rp_requirebench",
        default = "0",
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
        name = "font3",
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
        default = "1",
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
        max = 2,
        replicated = true,
        notify = true,
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
        name = "armorpenetration",
        default = "1",
        replicated = true,
        notify = true,
        min = 0,
        max = 1,
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
        min = 0,
    },
    {
        name = "slot_countall",
        default = "0",
        notify = true,
        min = 0,
        max = 1,
    },
    {
        name = "slot_action",
        default = "1",
        notify = true,
        min = 0,
        max = 2,
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
}

local prefix = "tacrp_"

local flags = {
    ["replicated"] = FCVAR_REPLICATED,
    ["userinfo"] = FCVAR_USERINFO,
    ["notify"] = FCVAR_NOTIFY
}
for _, var in pairs(conVars) do
    local convar_name = prefix .. var.name

    if var.client and CLIENT then
        CreateClientConVar(convar_name, var.default, true, var.userinfo)
    elseif !var.client then
        local flag = FCVAR_ARCHIVE
        for k, v in pairs(flags) do if var[k] then flag = flag + v end end
        CreateConVar(convar_name, var.default, flag, var.help, var.min, var.max)
    end
end

if CLIENT then

TacRP.ControlGuide = [[
TacRP Controls:

Blind Fire: +zoom & +forward / +moveleft / +moveright (B + W/A/D)

Suicide: +zoom & +speed & +walk (B + SHIFT + ALT)

Quick Melee: +use & +attack (E + MOUSE1)

Change Firemode: +use & +reload (E + R)

Safe: +use & +attack2 (E + MOUSE2)

Customize: +menu_context (C)

Peek: +menu_context (C) while aiming

Throw Grenade: +grenade1 (Not bound by default! Do 'bind g +grenade1' in console!)

Change Grenade: +grenade2 (Not bound by default! Do 'bind h +grenade2' in console!)
]]

local function header(panel, text)
    local ctrl = panel:Help(text)
    ctrl:SetFont("DermaDefaultBold")
    return ctrl
end

local function menu_guide_ti(panel)
    panel:AddControl("label", {
        text = TacRP.ControlGuide,
    })
    panel:AddControl("checkbox", {
        label = "Hide Control Guide Message On Startup",
        command = "tacrp_shutup"
    })
end

local function menu_client_ti(panel)

    header(panel, "Interface")
    panel:AddControl("checkbox", {
        label = "Show HUD",
        command = "TacRP_drawhud"
    })
    panel:AddControl("checkbox", {
        label = "Show Backup HUD",
        command = "tacrp_minhud"
    })
    panel:AddControl("checkbox", {
        label = "Quickthrow Radial Menu",
        command = "tacrp_nademenu"
    })
    panel:ControlHelp("When enabled, +grenade2 brings up a menu to select grenades. Otherwise it switches between them.")
    panel:AddControl("checkbox", {
        label = "Quickthrow Menu Clicking",
        command = "tacrp_nademenu_click"
    })
    panel:ControlHelp("When enabled, left click and right click in the quickthrow menu performs an overhand and underhand throw of the highlighted grenade.")
    panel:AddControl("checkbox", {
        label = "Blindfire Radial Menu",
        command = "tacrp_blindfiremenu"
    })
    panel:ControlHelp("When enabled, +zoom brings up a menu to change blindfire type. Otherwise it sets blindfire based on movement keys pressed.")
    panel:AddControl("checkbox", {
        label = "Blindfire Menu Empty Center",
        command = "tacrp_blindfiremenu_nocenter"
    })
    panel:ControlHelp("When enabled, center option does nothing, and bottom option will cancel blindfire instead.\nThis will hide the option to shoot yourself.")
    panel:AddControl("checkbox", {
        label = "Use Meters instead of HU",
        command = "tacrp_metricunit"
    })
    panel:AddControl("checkbox", {
        label = "Recoil Vignette",
        command = "tacrp_vignette"
    })
    panel:ControlHelp("Vignette intensity is based on amount of accumulated recoil.")

    header(panel, "\nHints")
    panel:AddControl("checkbox", {
        label = "Show Control Hints",
        command = "tacrp_hints"
    })
    panel:ControlHelp("Shows your currently available actions regardless of whether the HUD is enabled or not.")
    panel:AddControl("checkbox", {
        label = "Hints Always Active",
        command = "tacrp_hints_always"
    })
    panel:AddControl("checkbox", {
        label = "Hints Use Alternate Font",
        command = "tacrp_hints_altfont"
    })
    panel:AddControl("checkbox", {
        label = "Hide Startup Quickthrow Bind Reminder",
        command = "tacrp_shutup"
    })

    header(panel, "\nPreference")
    panel:AddControl("checkbox", {
        label = "Toggle Aiming",
        command = "tacrp_toggleaim"
    })
    panel:AddControl("checkbox", {
        label = "Toggle Peeking",
        command = "tacrp_togglepeek"
    })
    panel:AddControl("checkbox", {
        label = "Auto-Save Weapon",
        command = "TacRP_autosave"
    })
    panel:AddControl("checkbox", {
        label = "Auto Reload When Empty",
        command = "TacRP_autoreload"
    })
    panel:AddControl("checkbox", {
        label = "Flashbang Dark Mode",
        command = "tacrp_flash_dark"
    })
    panel:ControlHelp("In dark mode, flashbangs turn your screen black instead of white, and mutes audio intead of ringing.")
    panel:AddControl("checkbox", {
        label = "Quiet Radar",
        command = "tacrp_radar_quiet"
    })
    panel:ControlHelp("This mutes your own radar sound for yourself only. Others can still hear your radar, and you can still hear others' radars.")

    header(panel, "\nMiscellaneous")
    panel:AddControl("checkbox", {
        label = "Disable Suicide Mode",
        command = "tacrp_idunwannadie"
    })
    panel:ControlHelp("Hides the option to shoot yourself from the radial menu, and disables the SHIFT+ALT+B key combo.")
    panel:AddControl("checkbox", {
        label = "Draw Holstered Weapons",
        command = "tacrp_drawholsters"
    })
    panel:AddControl("checkbox", {
        label = "True Laser Position",
        command = "tacrp_true_laser"
    })
    panel:AddControl("checkbox", {
        label = "Immersive Ammo Names (Requires map reload)",
        command = "tacrp_ammonames"
    })
    panel:AddControl("checkbox", {
        label = "Spawnmenu Subcategories",
        command = "tacrp_subcats"
    })
    panel:ControlHelp("Separate weapons based on their type (like Sidearm, Assault Rifle, Shotgun). Use ConCommand \"spawnmenu_reload\" to take effect.")
end

local function menu_server_ti(panel)
    header(panel, "Features")
    panel:Help("Settings in this section affect ALL PLAYERS.")
    panel:AddControl("checkbox", {
        label = "Enable Crosshair",
        command = "tacrp_crosshair"
    })
    panel:AddControl("checkbox", {
        label = "Enable HUD (and Minimal HUD)",
        command = "tacrp_hud"
    })
    panel:AddControl("checkbox", {
        label = "Draw Holstered Weapons",
        command = "tacrp_visibleholster"
    })
    panel:AddControl("checkbox", {
        label = "Enable Newsletter",
        command = "tacrp_checknews"
    })
    panel:ControlHelp("If turned off, newsletter popup/notification will not happen. Players can still open the newsletter page manually.")

    local cb_irons_procedural, lb_irons_procedural = panel:ComboBox("Use Procedural Ironsights", "tacrp_irons_procedural")
    cb_irons_procedural:AddChoice("0 - Never", "0")
    cb_irons_procedural:AddChoice("1 - With Optic", "1")
    cb_irons_procedural:AddChoice("2 - Always", "2")
    cb_irons_procedural:DockMargin(8, 0, 0, 0)
    lb_irons_procedural:SizeToContents()
    panel:ControlHelp("Applies mostly to pistols. Replaces firing animation while aiming with a much less disruptive procedural effect, making aiming with the weapon's sights easier.")

    local cb_irons_lower, lb_irons_lower = panel:ComboBox("Use Lowered Ironsights", "tacrp_irons_lower")
    cb_irons_lower:AddChoice("0  - Never", "0")
    cb_irons_lower:AddChoice("1 - In TTT", "1")
    cb_irons_lower:AddChoice("2  - Always", "2")
    cb_irons_lower:DockMargin(8, 0, 0, 0)
    lb_irons_lower:SizeToContents()
    panel:ControlHelp("While aiming with ironsights, lower the weapon and draw a dot where the point of aim is (even when Enable Crosshair is off). The dot does not display weapon sway or spread.")

    header(panel, "\nAttachments")
    panel:AddControl("checkbox", {
        label = "Free Attachments",
        command = "TacRP_free_atts"
    })
    panel:AddControl("checkbox", {
        label = "Attachment Locking",
        command = "TacRP_lock_atts"
    })
    panel:ControlHelp("In Locking mode, owning one attachment allows you to use it on multiple weapons.")
    panel:AddControl("checkbox", {
        label = "Lose Attachments On Death",
        command = "TacRP_loseattsondie"
    })
    panel:AddControl("checkbox", {
        label = "Attachment Entities in Spawnmenu",
        command = "TacRP_generateattentities"
    })

    header(panel, "\nWeapon Slot Restriction")
    panel:ControlHelp("Restrict TacRP weapons for pickup/spawning based on their weapon slot.")
    panel:AddControl("slider", {
        label = "Max Per Slot (0 - no limit)",
        command = "tacrp_slot_limit",
        type = "int",
        min = 0,
        max = 3,
    })
    panel:AddControl("checkbox", {
        label = "Use HL2-style slots",
        command = "tacrp_slot_hl2"
    })
    panel:ControlHelp("Use slot 4 for MGs, shotguns and snipers, slot 5 for explosives.")
    panel:AddControl("checkbox", {
        label = "Count ALL weapons",
        command = "tacrp_slot_countall"
    })
    panel:ControlHelp("WARNING! If set, non-TacRP weapons may be dropped/removed to make room for TacRP weapons! This can have unintended consequences!")

    local cb_slot_action, lb_slot_action = panel:ComboBox("Weapon Spawning Behavior", "tacrp_slot_action")
    cb_slot_action:AddChoice("0 - Fail", "0")
    cb_slot_action:AddChoice("1 - Remove", "1")
    cb_slot_action:AddChoice("2 - Drop", "2")
    cb_slot_action:DockMargin(8, 0, 0, 0)
    lb_slot_action:SizeToContents()

    panel:ControlHelp("Only affects giving weapons with the spawnmenu.")

    header(panel, "\nNPC")
    panel:AddControl("checkbox", {
        label = "NPCs Deal Equal Damage",
        command = "TacRP_npc_equality"
    })
    panel:AddControl("checkbox", {
        label = "NPCs Get Random Attachments",
        command = "TacRP_npc_atts"
    })


    header(panel, "\nMiscellaneous")
    panel:AddControl("checkbox", {
        label = "Supply Boxes Resupply Grenades",
        command = "TacRP_resupply_grenades"
    })
    panel:AddControl("checkbox", {
        label = "Default Body Damage Cancel",
        command = "TacRP_bodydamagecancel"
    })
    panel:ControlHelp("Only disable this if another addon or gamemode is also modifying default hitgroup damage multipliers.")
end

local function menu_balance_ti(panel)
    header(panel, "Balance")
    panel:Help("Adjust weapon attributes to suit your gameplay needs.\nAutomatic sets balance to TTT in TTT, Tactical for DarkRP/Helix, and Arcade otherwise.")
    local cb_balance, lb_balance = panel:ComboBox("Weapon Balance", "tacrp_balance")
    cb_balance:AddChoice("Automatic", "-1")
    cb_balance:AddChoice("Tactical", "0")
    cb_balance:AddChoice("Arcade", "1")
    cb_balance:AddChoice("TTT", "2")
    cb_balance:DockMargin(8, 0, 0, 0)
    lb_balance:SizeToContents()

    panel:Help("Tactical: Balanced for reduced move speed. Medium TTK. Weapons are divided into 4 tiers.")
    panel:Help("Arcade: Balanced for Sandbox move speed. Low TTK. Snipers/DMRs have damage rampup.")
    panel:Help("TTT: Balanced for TTT. High TTK, reloads slow you down and take longer. Some weapons have lower fire rate.")

    header(panel, "\nAmmo & Reloading")
    panel:AddControl("checkbox", {
        label = "Infinite Ammo",
        command = "tacrp_infiniteammo"
    })
    panel:ControlHelp("Reloading does not require or consume ammo.")
    panel:AddControl("checkbox", {
        label = "Infinite Grenades",
        command = "tacrp_infinitegrenades"
    })
    panel:AddControl("checkbox", {
        label = "Allow Reload while Sprinting",
        command = "tacrp_sprint_reload"
    })
    panel:AddControl("slider", {
        label = "Default Clip Multiplier",
        command = "tacrp_defaultammo",
        type = "float",
        min = 0,
        max = 10,
    })

    header(panel, "\nFeatures")
    panel:AddControl("checkbox", {
        label = "Enable Sway",
        command = "tacrp_sway"
    })
    panel:AddControl("checkbox", {
        label = "Enable Free Aim",
        command = "tacrp_freeaim"
    })
    panel:AddControl("checkbox", {
        label = "Enable Penetration",
        command = "TacRP_penetration"
    })
    panel:AddControl("checkbox", {
        label = "Enable Physical Bullets",
        command = "TacRP_physbullet"
    })
    panel:ControlHelp("Bullets will be hitscan up to a certain range depending on muzzle velocity.")
    panel:AddControl("checkbox", {
        label = "Enable Holstering",
        command = "TacRP_holster"
    })
    panel:ControlHelp("Play a holster animation before pulling out another weapon. If disabled, holstering is instant.")
    panel:AddControl("checkbox", {
        label = "Enable Shotgun Patterns",
        command = "tacrp_fixedspread"
    })
    panel:ControlHelp("Shotgun pellets uses a pattern that covers the spread area for more consistency.")
    panel:AddControl("checkbox", {
        label = "Enable Pattern Randomness",
        command = "tacrp_pelletspread"
    })
    panel:ControlHelp("Add random spread onto the pattern. Does not affect total spread. If disabled, shotgun patterns become completely static.")
    panel:AddControl("checkbox", {
        label = "Custom Armor Penetration",
        command = "tacrp_armorpenetration"
    })
    panel:ControlHelp("Weapons use defined piercing and shredding stats to calculate damage when hitting players with HL2 suit armor, instead of using the standard 20% damage. This generally increases the weapons' effectiveness against armor.\nCompatible with Danger Zone Entities' armor.")

    header(panel, "\nSliders")
    panel:AddControl("slider", {
        label = "Flashbang Slow",
        command = "tacrp_flash_slow",
        type = "float",
        min = 0,
        max = 1,
    })
    panel:AddControl("slider", {
        label = "CS Gas Sway",
        command = "tacrp_gas_sway",
        type = "float",
        min = 0,
        max = 10,
    })
end

local function menu_atts_ti(panel)
    header(panel, "Attachment Mechanics")
    panel:AddControl("checkbox", {
        label = "Enable Scope Glint",
        command = "tacrp_glint"
    })
    panel:ControlHelp("Scopes show a visible glint. Glint size is dependent on angle of view, scope magnification and distance, and is bigger when zoomed in.")
    panel:AddControl("checkbox", {
        label = "Enable Blinding Flashlights",
        command = "tacrp_flashlight_blind"
    })
    panel:ControlHelp("Flashlight glare will obscure vision based on distance and viewing angle. Effect is more significant on scopes. If disabled, glare sprite will be visible but not grow in size.")

    header(panel, "\nAttachment Balance")
    panel:AddControl("slider", {
        label = "Smackdown Slow",
        command = "tacrp_melee_slow",
        type = "float",
        min = 0,
        max = 1,
    })
    panel:AddControl("slider", {
        label = "Radar Frequency",
        command = "tacrp_att_radartime",
        type = "float",
        min = 0.5,
        max = 10,
    })
end

local clientmenus_ti = {
    -- {
    --     text = "Control Guide", func = menu_guide_ti
    -- },
    {
        text = "Client", func = menu_client_ti
    },
    {
        text = "Server", func = menu_server_ti
    },
    {
        text = "Mechanics", func = menu_balance_ti
    },
    {
        text = "Attachments", func = menu_atts_ti
    },
}

hook.Add("PopulateToolMenu", "TacRP_MenuOptions", function()
    for smenu, data in pairs(clientmenus_ti) do
        spawnmenu.AddToolMenuOption("Options", "Tactical RP Weapons", "TacRP_" .. tostring(smenu), data.text, "", "", data.func)
    end
end)

end