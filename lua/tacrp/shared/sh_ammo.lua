local ammotypes = {
    ["ti_flashbang"] = "Flashbangs",
    ["ti_thermite"] = "Thermite Grenades",
    ["ti_smoke"] = "Smoke Grenades",
    ["ti_c4"] = "C4 Charges",
    ["ti_gas"] = "CS Gas Grenades",
    ["ti_nuke"] = "Nuclear Devices",
    ["ti_charge"] = "Breaching Charge",
}

for i, k in pairs(ammotypes) do
    game.AddAmmoType({
        name = i
    })

    if CLIENT then
        language.Add(i .. "_ammo", k)
    end
end

if engine.ActiveGamemode() == "terrortown" then
    game.AddAmmoType({
        name = "ti_sniper",
    })
    if CLIENT then
        language.Add("ti_sniper_ammo", "Anti-Materiel Ammo")
    end
end