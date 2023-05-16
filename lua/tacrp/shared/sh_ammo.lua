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

if engine.ActiveGamemode() == "terrortown" then

end