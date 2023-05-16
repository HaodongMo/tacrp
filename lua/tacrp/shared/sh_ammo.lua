local ammotypes = {
    "ti_flashbang",
    "ti_thermite",
    "ti_smoke",
    "ti_c4",
    "ti_gas",
    "ti_nuke",
    "ti_charge",
    "ti_sniper",
}

for _, i in pairs(ammotypes) do
    game.AddAmmoType({
        name = i
    })

    if CLIENT then
        language.Add(i .. "_ammo", TacRP:GetPhrase(i) or i)
    end
end

-- mean shots between jams
TacRP.AmmoJamMSB = {
    ["pistol"] = 30,
    ["smg1"] = 25,
    ["ar2"] = 20,
    ["357"] = 10,
    ["buckshot"] = 8,
    ["SniperPenetratedRound"] = 8,
}