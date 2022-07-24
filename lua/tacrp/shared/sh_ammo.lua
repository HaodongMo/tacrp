local ammotypes = {
    ["ti_flashbang"] = "Flashbangs",
    ["ti_thermite"] = "Fire Grenades",
    ["ti_smoke"] = "Smoke Grenades",
    ["ti_c4"] = "C4 Charges",
    ["ti_gas"] = "Gas Grenades",
    ["ti_nuke"] = "Nuclear Device",
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