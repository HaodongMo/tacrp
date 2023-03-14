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
        name = "limitslots",
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

    panel:AddControl("header", {
        description = "Interface",
    })
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
    panel:AddControl("label", {
        text = "When enabled, +grenade2 brings up a menu to select grenades. Otherwise it switches between them."
    })
    panel:AddControl("checkbox", {
        label = "Quickthrow Menu Clicking",
        command = "tacrp_nademenu_click"
    })
    panel:AddControl("label", {
        text = "When enabled, left click and right click in the quickthrow menu performs an overhand and underhand throw of the highlighted grenade."
    })
    panel:AddControl("checkbox", {
        label = "Blindfire Radial Menu",
        command = "tacrp_blindfiremenu"
    })
    panel:AddControl("label", {
        text = "When enabled, +zoom brings up a menu to change blindfire type. Otherwise it sets blindfire based on movement keys pressed."
    })
    panel:AddControl("checkbox", {
        label = "Blindfire Menu Empty Center",
        command = "tacrp_blindfiremenu_nocenter"
    })
    panel:AddControl("label", {
        text = "When enabled, center option does nothing, and bottom option will cancel blindfire instead.\nThis will hide the option to shoot yourself."
    })
    panel:AddControl("checkbox", {
        label = "Use Meters instead of HU",
        command = "tacrp_metricunit"
    })
    panel:AddControl("checkbox", {
        label = "Recoil Vignette",
        command = "tacrp_vignette"
    })
    panel:AddControl("label", {
        text = "Vignette intensity is based on amount of accumulated recoil."
    })

    panel:AddControl("header", {
        description = "\nPreference",
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
    panel:AddControl("label", {
        text = "In dark mode, flashbangs turn your screen black instead of white, and mutes audio intead of ringing."
    })

    panel:AddControl("header", {
        description = "\nMiscellaneous",
    })
    panel:AddControl("checkbox", {
        label = "Disable Suicide Mode",
        command = "tacrp_idunwannadie"
    })
    panel:AddControl("label", {
        text = "Hides the option to shoot yourself from the radial menu, and disables the SHIFT+ALT+B key combo."
    })
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
    panel:AddControl("label", {
        text = "Separate weapons based on their type (like Sidearm, Assault Rifle, Shotgun). Use ConCommand \"spawnmenu_reload\" to take effect."
    })
end

local function menu_server_ti(panel)
    panel:AddControl("checkbox", {
        label = "Enable Crosshair (for everyone)",
        command = "tacrp_crosshair"
    })
    panel:AddControl("checkbox", {
        label = "Free Attachments",
        command = "TacRP_free_atts"
    })
    panel:AddControl("checkbox", {
        label = "Attachment Locking",
        command = "TacRP_lock_atts"
    })
    panel:AddControl("label", {
        text = "In Locking mode, owning one attachment allows you to use it on multiple weapons."
    })
    panel:AddControl("checkbox", {
        label = "Lose Attachments On Death",
        command = "TacRP_loseattsondie"
    })
    panel:AddControl("checkbox", {
        label = "Attachment Entities in Spawnmenu",
        command = "TacRP_generateattentities"
    })
    panel:AddControl("checkbox", {
        label = "One Weapon Per Slot",
        command = "tacrp_limitslots"
    })
    panel:AddControl("label", {
        text = "Slot limit only counts TacRP weapons in slots 2-5. Spawning new guns will delete old guns in the slot."
    })
    panel:AddControl("checkbox", {
        label = "Supply Boxes Resupply Grenades",
        command = "TacRP_resupply_grenades"
    })
    panel:AddControl("checkbox", {
        label = "NPCs Deal Equal Damage",
        command = "TacRP_npc_equality"
    })
    panel:AddControl("checkbox", {
        label = "NPCs Get Random Attachments",
        command = "TacRP_npc_atts"
    })

    panel:AddControl("checkbox", {
        label = "Default Body Damage Cancel",
        command = "TacRP_bodydamagecancel"
    })
    panel:AddControl("label", {
        text = "Disable body damage cancel only if you have another addon that will override the hl2 limb damage multipliers."
    })
end

local function menu_balance_ti(panel)
    panel:AddControl("checkbox", {
        label = "Arcade Mode",
        command = "tacrp_arcade"
    })
    panel:AddControl("label", {
        text = "Arcade mode tweaks weapons to be similar in strength to each other and significantly increases mobility on all weapons. Recommended for Sandbox."
    })

    panel:AddControl("checkbox", {
        label = "Infinite Ammo",
        command = "tacrp_infiniteammo"
    })
    panel:AddControl("checkbox", {
        label = "Infinite Grenades",
        command = "tacrp_infinitegrenades"
    })

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
    panel:AddControl("checkbox", {
        label = "Enable Holstering",
        command = "TacRP_holster"
    })
    panel:AddControl("label", {
        text = "Play a holster animation before pulling out another weapon. If disabled, holstering is instant."
    })
    panel:AddControl("checkbox", {
        label = "Enable Fixed Shotgun Patterns",
        command = "tacrp_fixedspread"
    })
    panel:AddControl("label", {
        text = "Shotgun pellets uses a fixed pattern that covers the spread area for more consistency. They are still subject to a small amount of randomness."
    })
    panel:AddControl("checkbox", {
        label = "Enabled Fixed Pattern Randomness",
        command = "tacrp_pelletspread"
    })
    panel:AddControl("label", {
        text = "Additional random spread onto the fixed pattern. Does not affect total spread. If disabled, shotgun patterns become completely static."
    })

    panel:AddControl("slider", {
        label = "Flashbang Slow",
        command = "tacrp_flash_slow",
        type = "float",
        min = 0,
        max = 1,
    })
    panel:AddControl("slider", {
        label = "Smackdown Slow",
        command = "tacrp_melee_slow",
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

local clientmenus_ti = {
    {
        text = "Control Guide", func = menu_guide_ti
    },
    {
        text = "Client", func = menu_client_ti
    },
    {
        text = "Server", func = menu_server_ti
    },
    {
        text = "Mechanics", func = menu_balance_ti
    },
}

hook.Add("PopulateToolMenu", "TacRP_MenuOptions", function()
    for smenu, data in pairs(clientmenus_ti) do
        spawnmenu.AddToolMenuOption("Options", "Tactical RP Weapons", "TacRP_" .. tostring(smenu), data.text, "", "", data.func)
    end
end)

end