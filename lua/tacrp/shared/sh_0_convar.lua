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
        client = true
    },
    {
        name = "bodydamagecancel",
        default = "1",
        replicated = true
    },
    {
        name = "free_atts",
        default = "1",
        replicated = true
    },
    {
        name = "lock_atts",
        default = "1",
        replicated = true
    },
    {
        name = "loseattsondie",
        default = "1",
    },
    {
        name = "generateattentities",
        default = "1",
        replicated = true
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
        replicated = true
    },
    {
        name = "freeaim",
        default = "1",
        replicated = true
    },
    {
        name = "sway",
        default = "1",
        replicated = true
    },
    {
        name = "physbullet",
        default = "1",
        replicated = true
    },
    {
        name = "resupply_grenades",
        default = "1",
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
        default = "0"
    },
    {
        name = "true_laser",
        default = "1"
    },
    {
        name = "toggletactical",
        default = "1"
    },
    {
        name = "infiniteammo",
        default = "0"
    },
    {
        name = "infinitegrenades",
        default = "0"
    },
    {
        name = "rock_funny",
        default = "0.05"
    },
    {
        name = "arcade",
        default = "1"
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
    },
}

local prefix = "tacrp_"

for _, var in pairs(conVars) do
    local convar_name = prefix .. var.name

    if var.client and CLIENT then
        CreateClientConVar(convar_name, var.default, true)
    else
        local flags = FCVAR_ARCHIVE
        if var.replicated then
            flags = flags + FCVAR_REPLICATED
        end
        CreateConVar(convar_name, var.default, flags)
    end
end

if CLIENT then

TacRP.ControlGuide = [[
TacRP Controls:

Blind Fire Forward: +walk & +forward (ALT + W)

Blind Fire Left: +walk & +moveleft (ALT + A)

Quick Melee: +use & +attack (E + MOUSE1)

Change Firemode: +use & +reload (E + R)

Safe: +use & +attack2 (E + MOUSE2)

Customize: +menu_context (C)

Throw Grenade: +grenade1 (Not bound by default! Do 'bind g +grenade1' in console!)

Change Grenade: +grenade2 (Not bound by default! Do 'bind h +grenade2' in console!)]]

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
    panel:AddControl("checkbox", {
        label = "Auto-Save Weapon",
        command = "TacRP_autosave"
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
        label = "Draw Holstered Weapons",
        command = "tacrp_drawholsters"
    })
    panel:AddControl("checkbox", {
        label = "True Laser Position",
        command = "tacrp_true_laser"
    })
    panel:AddControl("checkbox", {
        label = "Auto Reload When Empty",
        command = "TacRP_autoreload"
    })
    panel:AddControl("checkbox", {
        label = "Immersive Ammo Names (Requires map reload)",
        command = "tacrp_ammonames"
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
    panel:AddControl("checkbox", {
        label = "Limit One Weapon Per Slot",
        command = "tacrp_limitslots"
    })
    panel:AddControl("checkbox", {
        label = "Lose Attachments On Death",
        command = "TacRP_loseattsondie"
    })
    panel:AddControl("checkbox", {
        label = "Generate Attachment Entities",
        command = "TacRP_generateattentities"
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