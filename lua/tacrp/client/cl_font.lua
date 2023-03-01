local sizes_to_make = {
    4,
    6,
    8,
    10,
    12,
    14,
    16,
    32
}

local unscaled_sizes_to_make = {
    32
}

local fonts_to_make = {
    "LondonBetween",
    "Myriad Pro",
    "HD44780A00 5x8"
}

-- TacRP_HD44780A00_5x8_32

local function generatefonts()

    for _, font in pairs(fonts_to_make) do
        local fontname = string.Replace(font, " ", "_")

        for _, i in pairs(sizes_to_make) do

            surface.CreateFont( "TacRP_" .. fontname .. "_" .. tostring(i), {
                font = font,
                size = ScreenScale(i),
                weight = 0,
                antialias = true,
                extended = true, -- Required for non-latin fonts
            } )

            surface.CreateFont( "TacRP_" .. fontname .. "_" .. tostring(i) .. "_Glow", {
                font = font,
                size = ScreenScale(i),
                weight = 0,
                antialias = true,
                blursize = 6,
                extended = true,
            } )

        end

        for _, i in pairs(unscaled_sizes_to_make) do

            surface.CreateFont( "TacRP_" .. fontname .. "_" .. tostring(i) .. "_Unscaled", {
                font = font,
                size = i,
                weight = 0,
                antialias = true,
                extended = true,
            } )

        end
    end

end

generatefonts()

function TacRP.Regen(full)
    if full then
        generatefonts()
    end
end

hook.Add( "OnScreenSizeChanged", "TacRP.Regen", function() TacRP.Regen(true) end)