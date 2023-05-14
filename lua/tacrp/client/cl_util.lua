local hudscale = GetConVar("tacrp_hudscale")
function TacRP.SS(i)
    return ScrW() / 640 * i * hudscale:GetFloat()
end