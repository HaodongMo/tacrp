L = {} -- English Content Strings

--[[
To localize an attachment (replace optic_acog with your attachment class):
L["att.optic_acog.name"] = "Attachment Name"
L["att.optic_acog.name.full"] = "Attachment Full Name"
L["att.optic_acog.desc"] = "Attachment Description"

To localize a weapon (replace tacrp_vertec with your own weapon class);
L["wep.tacrp_vertec.name.full"] = "Weapon Full Name"
L["wep.tacrp_vertec.name"] = "Weapon Name"
L["wep.tacrp_vertec.desc"] = "Weapon Description"
L["wep.tacrp_vertec.desc.quote"] = "Weapon Quote" -- this is the italics line at the bottom
L["wep.tacrp_vertec.trivia.manufacturer"] = "Trivia Manufacturer"
L["wep.tacrp_vertec.trivia.caliber"] = "Trivia Caliber"
L["wep.tacrp_vertec.trivia.year"] = "Trivia Year"
L["wep.tacrp_vertec.credits"] = "Credits List"

If this is a non-English file, remove this entire thing.
]]

///////////////////// -- [[ TacRP Base ]] --
-- Weapons
local ws = "tacrp_"
local w = ws .. "ak47"
L["wep." .. w .. ".name.full"] = "FB Beryl 96"
L["wep." .. w .. ".name"] = "Beryl 96"
L["wep." .. w .. ".desc"] = "Easy to handle rifle with low fire rate and recoil."
L["wep." .. w .. ".desc.quote"] = "Despite its looks, it is not an AK."
L["wep." .. w .. ".trivia.manufacturer"] = "FB \"Łucznik\" Radom"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "amd65"
L["wep." .. w .. ".name"] = "AMD-65"
L["wep." .. w .. ".desc"] = "Hungarian AK clone with integrated grip and wire stock. High damage, but lower range than most rifles."
L["wep." .. w .. ".trivia.manufacturer"] = "Fegyver- és Gépgyár"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "ar15"
L["wep." .. w .. ".name.full"] = "Diemaco AR-15"
L["wep." .. w .. ".name"] = "AR-15"
L["wep." .. w .. ".desc"] = "Customized semi-automatic model of an ubiquitous American rifle. Uses reduced capacity magazines."
L["wep." .. w .. ".desc.quote"] = "\"One of the most beloved and most vilified rifles in the country.\""
L["wep." .. w .. ".trivia.manufacturer"] = "Colt Canada"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "as50"
L["wep." .. w .. ".name.full"] = "AI AS50"
L["wep." .. w .. ".name"] = "AS50"
L["wep." .. w .. ".desc"] = "Semi-automatic anti-materiel rifle that can easily decimate any person at any distance. \nEquipped with a 12x scope by default. \nFar too heavy to swing, so bashing is out of the question."
L["wep." .. w .. ".trivia.manufacturer"] = "Accuracy International"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "aug"
L["wep." .. w .. ".name.full"] = "Steyr AUG A2"
L["wep." .. w .. ".name"] = "AUG A2"
L["wep." .. w .. ".desc"] = "Burst bullpup rifle with a generous magazine capacity and great handling."
L["wep." .. w .. ".trivia.manufacturer"] = "Steyr Arms"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "bekas"
L["wep." .. w .. ".name.full"] = "Molot Bekas-16M"
L["wep." .. w .. ".name"] = "Bekas-16M"
L["wep." .. w .. ".desc"] = "Accurate hunting shotgun with low damage."
L["wep." .. w .. ".trivia.manufacturer"] = "Molot"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "c4_detonator"
L["wep." .. w .. ".name"] = "C4 Detonator"
L["wep." .. w .. ".desc"] = "Device for touching off C4 charges or other types of remote explosives."
-- L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "civ_amd65"
L["wep." .. w .. ".name.full"] = "Arsenal SAM7SF"
L["wep." .. w .. ".name"] = "SAM7SF"
L["wep." .. w .. ".desc"] = "American semi-automatic AK pattern rifle, customized with an AR-15 style stock and Hungarian handguard.\nUses reduced capacity magazines."
L["wep." .. w .. ".trivia.manufacturer"] = "Arsenal Inc"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention \nModel Edit: Arctic"

w = ws .. "civ_g36k"
L["wep." .. w .. ".name.full"] = "HK HK243"
L["wep." .. w .. ".name"] = "HK243"
L["wep." .. w .. ".desc"] = "Semi-automatic model of an iconic polymer rifle.\nUses reduced capacity magazines."
L["wep." .. w .. ".desc.quote"] = "\"Weapons of war do not belong on our streets!\""
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "civ_m320"
L["wep." .. w .. ".name.full"] = "HK M320LE"
L["wep." .. w .. ".name"] = "M320LE"
L["wep." .. w .. ".desc"] = "Law Enforcement version of the M320 sanctioned for less-lethal munitions. Fires beanbag rounds that incapacitate on direct hit."
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "civ_mp5"
L["wep." .. w .. ".name.full"] = "HK HK94"
L["wep." .. w .. ".name"] = "HK94"
L["wep." .. w .. ".desc"] = "Semi-automatic model of a legendary submachine gun. \nUses reduced capacity magazines."
L["wep." .. w .. ".desc.quote"] = "Frequently seen standing in for its military counterpart."
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention \nModel Edit: speedonerd \n(it was soooo hard lol)"

w = ws .. "civ_p90"
L["wep." .. w .. ".name.full"] = "FN PS90"
L["wep." .. w .. ".name"] = "PS90"
L["wep." .. w .. ".desc"] = "Semi-automatic variation of a futuristic PDW. \nUses reduced capacity magazines."
L["wep." .. w .. ".desc.quote"] = "\"This is a weapon of terror. It's made to intimidate the enemy.\""
L["wep." .. w .. ".trivia.manufacturer"] = "FN Herstal"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention \nModel Edit: speedonerd \n(it was soooo hard lol)"

w = ws .. "dsa58"
L["wep." .. w .. ".name.full"] = "DSA SA58 OSW"
L["wep." .. w .. ".name"] = "SA58"
L["wep." .. w .. ".desc"] = "Battle rifle with slow fire rate but very high damage and armor penetration. Has a grippod that provides some stability if deployed."
L["wep." .. w .. ".desc.quote"] = "\"Shut up, clock in and load up.\""
L["wep." .. w .. ".trivia.manufacturer"] = "DS Arms"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "ex_ak47"
L["wep." .. w .. ".name"] = "AK-47"
L["wep." .. w .. ".desc"] = "Iconic Soviet assault rifle. A rugged and simple design that inspired countless clones and derivatives."
L["wep." .. w .. ".desc.quote"] = "The quintessential bad guy gun."
L["wep." .. w .. ".trivia.manufacturer"] = "Kalashnikov Concern"
L["wep." .. w .. ".credits"] = "Model: Twinke Masta, PoisonHeadcrab, Steelbeast \nTextures: Millenia, IppE, FxDarkloki, Pete \nSounds: CC5, modderfreak, .exe \nAnimations: Tactical Intervention"

w = ws .. "ex_glock"
L["wep." .. w .. ".name"] = "Glock 17"
L["wep." .. w .. ".desc"] = "Polymer pistol with larger-than-standard capacity and a fast fire rate."
L["wep." .. w .. ".desc.quote"] = "Does not show up on airport metal detectors."
L["wep." .. w .. ".trivia.manufacturer"] = "Glock Ges.m.b.H"
L["wep." .. w .. ".credits"] = "Assets: Twinke Masta \nSounds: Vunsunta \nAnimations: Tactical Intervention"

w = ws .. "ex_hecate"
L["wep." .. w .. ".name.full"] = "PGM Hécate II"
L["wep." .. w .. ".name"] = "Hécate II"
L["wep." .. w .. ".desc"] = "Heavy anti-materiel rifle that can kill in one shot. \nEquipped with a 12x scope by default. \nLight enough for swing for melee."
L["wep." .. w .. ".desc.quote"] = "Gun Runner tested, NCR approved."
L["wep." .. w .. ".trivia.manufacturer"] = "PGM Précision"
L["wep." .. w .. ".credits"] = "Assets: Toby Burnside \nSource: Fallout 4: New Vegas Project"

w = ws .. "ex_hk45c"
L["wep." .. w .. ".name.full"] = "HK HK45 Compact"
L["wep." .. w .. ".name"] = "HK45C"
L["wep." .. w .. ".desc"] = "Modern high-caliber pistol with great firepower in a handy package."
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Model: B0t, Red Crayon \nTextures: IppE, Grall19 \nSounds: DMG, xLongWayHome, Leeroy Newman \nAnimations: Tactical Intervention"

w = ws .. "ex_m4a1"
L["wep." .. w .. ".name.full"] = "Colt M4A1"
L["wep." .. w .. ".name"] = "M4A1"
L["wep." .. w .. ".desc"] = "A true American classic boasting high fire rate and balanced performance."
L["wep." .. w .. ".trivia.manufacturer"] = "Colt"
L["wep." .. w .. ".credits"] = "Model/Textures: Twinke Masta, DMG \nSounds: Teh Strelok \nAnimations: Tactical Intervention"

w = ws .. "ex_m1911"
L["wep." .. w .. ".name.full"] = "Colt M1911"
L["wep." .. w .. ".name"] = "M1911"
L["wep." .. w .. ".desc"] = "Surplus pistol from an era before tactical attachments and pistol optics, yet still hits quite hard."
L["wep." .. w .. ".desc.quote"] = "\"Hasta la vista, baby!\""
L["wep." .. w .. ".trivia.manufacturer"] = "Colt"
L["wep." .. w .. ".credits"] = "Model/Textures: Twinke Masta, DMG \nSounds: xLongWayHome, Strelok, Vunsunta \nAnimations: Tactical Intervention"

w = ws .. "ex_mac10"
L["wep." .. w .. ".name.full"] = "Ingram MAC-11"
L["wep." .. w .. ".name"] = "MAC-11"
L["wep." .. w .. ".desc"] = "A bullet hose best used for point blank spray-and-pray."
L["wep." .. w .. ".desc.quote"] = "\"Give me the motherfuckin' gun, Tre!\""
L["wep." .. w .. ".trivia.manufacturer"] = "Military Armament Corporation"
L["wep." .. w .. ".credits"] = "Model/Textures: Enron \nSounds: Vunsunta,  Erick F \nAnimations: Tactical Intervention"

w = ws .. "ex_mp9"
L["wep." .. w .. ".name.full"] = "BT MP9"
L["wep." .. w .. ".name"] = "MP9"
L["wep." .. w .. ".desc"] = "Compact polymer submachine gun packing lots of firepower in a small package."
L["wep." .. w .. ".desc.quote"] = "\"Your right hand comes off?\""
L["wep." .. w .. ".trivia.manufacturer"] = "Brügger & Thomet"
L["wep." .. w .. ".credits"] = "Assets: Logger & The Expert \nSource: Gamebanana"

w = ws .. "ex_stinger"
L["wep." .. w .. ".name.full"] = "FIM-92 Stinger"
L["wep." .. w .. ".name"] = "Stinger"
L["wep." .. w .. ".desc"] = "Homing anti-air missile launcher. High blast damage but limited effect on armored targets. \nRequires a lock-on in order to fire."
L["wep." .. w .. ".desc.quote"] = "\"A cornered fox is more dangerous than a jackal!\""
L["wep." .. w .. ".trivia.manufacturer"] = "Raytheon Missiles and Defense"
L["wep." .. w .. ".credits"] = "Assets: Modern Warfare 2 \nAnimations: Tactical Intervention"

w = ws .. "ex_ump45"
L["wep." .. w .. ".name.full"] = "HK UMP45"
L["wep." .. w .. ".name"] = "UMP45"
L["wep." .. w .. ".desc"] = "Boxy SMG developed with low production costs in mind. \nHigh damage up close, but range and rate of fire is low."
L["wep." .. w .. ".desc.quote"] = "\"The fuck are these, cocktail guns?\""
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Assets: Hellspike, Logger & Cyper \nSource: Gamebanana"

w = ws .. "ex_usp"
L["wep." .. w .. ".name.full"] = "HK USP"
L["wep." .. w .. ".name"] = "USP"
L["wep." .. w .. ".desc"] = "Tactical pistol with good damage and range."
L["wep." .. w .. ".desc.quote"] = "\"Man of few words, aren't you?\""
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Model: Thanez, Racer445 \nTextures: Thanez, fxdarkloki \nSounds: Vunsunta, BlitzBoaR \nAnimations: Tactical Intervention"

w = ws .. "fp6"
L["wep." .. w .. ".name.full"] = "HK FABARM FP6"
L["wep." .. w .. ".name"] = "FABARM FP6"
L["wep." .. w .. ".desc"] = "Combat shotgun with high fire rate and capacity."
L["wep." .. w .. ".trivia.manufacturer"] = "FABARM S.p.A."
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "g36k"
L["wep." .. w .. ".name.full"] = "HK G36K"
L["wep." .. w .. ".name"] = "G36K"
L["wep." .. w .. ".desc"] = "Assault rifle with high muzzle velocity. Well suited for medium range sustained fire. \nEquipped with a 2x scope by default."
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "gsr1911"
L["wep." .. w .. ".name.full"] = "SIG 1911 TACOPS"
L["wep." .. w .. ".name"] = "SIG 1911"
L["wep." .. w .. ".desc"] = "High damage pistol with low range and capacity. \nA tactical evolution, or some would call devolution, of a venerable classic."
L["wep." .. w .. ".trivia.manufacturer"] = "SIG Sauer, Inc."
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "hk417"
L["wep." .. w .. ".name.full"] = "HK HK417"
L["wep." .. w .. ".name"] = "HK417"
L["wep." .. w .. ".desc"] = "Battle rifle with superb damage, fire rate and precision. Capable of automatic fire, although it is very unstable."
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "k1a"
L["wep." .. w .. ".name.full"] = "Daewoo K1A"
L["wep." .. w .. ".name"] = "K1A"
L["wep." .. w .. ".desc"] = "Burst rifle with minimal recoil and good hip firing accuracy."
L["wep." .. w .. ".trivia.manufacturer"] = "Daewoo Precision"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "knife"
L["wep." .. w .. ".name"] = "Flip Knife"
L["wep." .. w .. ".desc"] = "A multi-purpose flip knife, although most of the purposes involving stabbing someone."
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "knife2"
L["wep." .. w .. ".name"] = "Jackal Knife"
L["wep." .. w .. ".desc"] = "Very edgy looking knife. Light, partially skeletized blade makes it faster to swing but do less damage."
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention (Unused)"

w = ws .. "ks23"
L["wep." .. w .. ".name"] = "KS-23"
L["wep." .. w .. ".desc"] = "Made from recycled aircraft gun barrels, this heavy shotgun fires shells with twice the diameter of typical shotshells and can easily tear apart anything it's vaguely pointed at. Able to breach doors."
L["wep." .. w .. ".trivia.manufacturer"] = "Tula Arms Plant"
L["wep." .. w .. ".credits"] = "Assets: Firearms: Source"

w = ws .. "m1"
L["wep." .. w .. ".name.full"] = "Ruger Mini-14"
L["wep." .. w .. ".name"] = "Mini-14"
L["wep." .. w .. ".desc"] = "Lightweight rifle with no stock or optic mount. \nGood hip-fire accuracy among rifles, but range is low."
L["wep." .. w .. ".desc.quote"] = "\"The one with the gun gets to tell the truth.\""
L["wep." .. w .. ".trivia.manufacturer"] = "Sturm, Ruger & Co."
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "m4"
L["wep." .. w .. ".name.full"] = "Diemaco C8A1"
L["wep." .. w .. ".name"] = "C8A1"
L["wep." .. w .. ".desc"] = "A close cousin to the classic American rifle with a slower but more controllable rate of fire."
L["wep." .. w .. ".desc.quote"] = "Green and very, very mean."
L["wep." .. w .. ".trivia.manufacturer"] = "Colt Canada"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "m4star10"
L["wep." .. w .. ".name.full"] = "Benelli M4 Super 90"
L["wep." .. w .. ".name"] = "M4 Super 90"
L["wep." .. w .. ".desc"] = "Semi-automatic shotgun with very high damage output. Reloading may be a chore."
L["wep." .. w .. ".desc.quote"] = "There's nothing seven 12 Gauge shotshells can't solve."
L["wep." .. w .. ".trivia.manufacturer"] = "Benelli Armi S.p.A."
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "m14"
L["wep." .. w .. ".name.full"] = "Springfield M1A"
L["wep." .. w .. ".name"] = "M1A"
L["wep." .. w .. ".desc"] = "Semi-automatic rifle with a lethal headshot. \nEquipped with a 6x scope by default."
L["wep." .. w .. ".desc.quote"] = "\"This my rifle! There are many like it, but this one is mine!\""
L["wep." .. w .. ".trivia.manufacturer"] = "Springfield Armory"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "m320"
L["wep." .. w .. ".name.full"] = "HK M320"
L["wep." .. w .. ".name"] = "M320"
L["wep." .. w .. ".desc"] = "Grenade launcher capable of firing a variety of payloads."
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "medkit"
L["wep." .. w .. ".name"] = "First Aid Kit"
L["wep." .. w .. ".desc"] = "Compact pack of medical supplies for treating wounds."
L["wep." .. w .. ".desc.quote"] = "\"Keep still, let me patch you up.\""
L["wep." .. w .. ".credits"] = "Model/Textures: Left 4 Dead 2 \nAnimations: Arqu"

w = ws .. "mg4"
L["wep." .. w .. ".name.full"] = "HK MG4"
L["wep." .. w .. ".name"] = "MG4"
L["wep." .. w .. ".desc"] = "Machine gun with huge volume of fire."
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "mp5"
L["wep." .. w .. ".name.full"] = "HK MP5A3"
L["wep." .. w .. ".name"] = "MP5A3"
L["wep." .. w .. ".desc"] = "Well-balanced submachine gun known for its precision."
L["wep." .. w .. ".desc.quote"] = "\"Now I have a machine gun. Ho, ho, ho.\""
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "mp7"
L["wep." .. w .. ".name.full"] = "HK MP7"
L["wep." .. w .. ".name"] = "MP7"
L["wep." .. w .. ".desc"] = "PDW with superb handling and close range effectiveness. High velocity rounds retain effectiveness at range and pierces armor easily."
L["wep." .. w .. ".desc.quote"] = "\"You forgot to cock it, muthafucka!\""
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "mr96"
L["wep." .. w .. ".name.full"] = "Manurhin MR96"
L["wep." .. w .. ".name"] = "MR96"
L["wep." .. w .. ".desc"] = "Magnum revolver with good handling and stopping power. Accurate, but hard to fire rapidly."
L["wep." .. w .. ".trivia.manufacturer"] = "Chapuis Armes"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "mtx_dual"
L["wep." .. w .. ".name"] = "Dual MTX"
L["wep." .. w .. ".desc"] = "An indulgent pair of high capacity, high damage, high quality compact pistols."
L["wep." .. w .. ".desc.quote"] = "With firepower like this, who needs aiming?"
L["wep." .. w .. ".trivia.manufacturer"] = "Detonics Defense"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "nade_charge"
L["wep." .. w .. ".name.full"] = "Breaching Charge"

w = ws .. "nade_flashbang"
L["wep." .. w .. ".name.full"] = "Flashbang"

w = ws .. "nade_frag"
L["wep." .. w .. ".name.full"] = "Frag Grenade"

w = ws .. "nade_gas"
L["wep." .. w .. ".name.full"] = "CS Gas Grenade"

w = ws .. "nade_heal"
L["wep." .. w .. ".name.full"] = "Medi-Smoke Canister"

w = ws .. "nade_smoke"
L["wep." .. w .. ".name.full"] = "Smoke Grenade"

w = ws .. "nade_thermite"
L["wep." .. w .. ".name"] = "Thermite Grenade"

w = ws .. "p90"
L["wep." .. w .. ".name.full"] = "FN P90"
L["wep." .. w .. ".name"] = "P90"
L["wep." .. w .. ".desc"] = "Bullpup PDW with a generous top-loaded magazine and controllable spread. High velocity rounds retain effectiveness at range and pierces armor easily."
L["wep." .. w .. ".desc.quote"] = "\"This is a weapon of war, it's made to kill your enemy.\""
L["wep." .. w .. ".trivia.manufacturer"] = "FN Herstal"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "p250"
L["wep." .. w .. ".name.full"] = "SIG P250"
L["wep." .. w .. ".name"] = "P250"
L["wep." .. w .. ".desc"] = "Powerful handgun that exchanges capacity for damage and precision."
L["wep." .. w .. ".trivia.manufacturer"] = "SIG Sauer, Inc."
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "p2000"
L["wep." .. w .. ".name.full"] = "HK P2000"
L["wep." .. w .. ".name"] = "P2000"
L["wep." .. w .. ".desc"] = "Well-rounded, run-of-the-mill police handgun."
L["wep." .. w .. ".desc.quote"] = "\"Raus! Raus! Raus!\""
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "pdw"
L["wep." .. w .. ".name"] = "KAC PDW"
L["wep." .. w .. ".desc"] = "Carbine caliber subcompact PDW. The perfect blend of rifle and submachine gun."
L["wep." .. w .. ".trivia.manufacturer"] = "Knight's Armament"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "riot_shield"
L["wep." .. w .. ".name"] = "Riot Shield"
L["wep." .. w .. ".desc"] = "Lightweight shield. Despite its plastic-looking core, it is capable of stopping almost all rifle caliber rounds. \nAble to sprint and melee attack without compromising the user's safety, but slows down move speed slightly."
L["wep." .. w .. ".credits"] = "Model/Textures: Tactical Intervention \nAnimations: Arqu"

w = ws .. "rpg7"
L["wep." .. w .. ".name"] = "RPG-7"
L["wep." .. w .. ".desc"] = "Soviet rocket launcher with powerful explosion. \nSafety fuse prevents point blank detonations."
L["wep." .. w .. ".desc.quote"] = "If you hear someone screaming its name, duck for cover."
L["wep." .. w .. ".trivia.manufacturer"] = "NPO Bazalt"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "sg551"
L["wep." .. w .. ".name.full"] = "SIG SG 551"
L["wep." .. w .. ".name"] = "SG 551"
L["wep." .. w .. ".desc"] = "Assault rifle with all around excellent performance, offset by a lower magazine capacity."
L["wep." .. w .. ".desc.quote"] = "\"No questions, no answers. That's the business we're in.\""
L["wep." .. w .. ".trivia.manufacturer"] = "SIG Sauer AG"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "skorpion"
L["wep." .. w .. ".name.full"] = "Skorpion vz. 61"
L["wep." .. w .. ".name"] = "Skorpion"
L["wep." .. w .. ".desc"] = "Light machine pistol with good range, recoil and spread."
L["wep." .. w .. ".trivia.manufacturer"] = "CZ Uherský Brod"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "sphinx"
L["wep." .. w .. ".name.full"] = "Sphinx 2000"
L["wep." .. w .. ".name"] = "Sphinx"
L["wep." .. w .. ".desc"] = "Premium pistol modified to be 3-round burst. High firerate but long burst delay."
L["wep." .. w .. ".trivia.manufacturer"] = "Sphinx Systems"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "spr"
L["wep." .. w .. ".name.full"] = "Remington M700 SPS"
L["wep." .. w .. ".name"] = "R700 SPS"
L["wep." .. w .. ".desc"] = "Medium range hunting rifle with a fast cycle speed. \nEquipped with a 6x scope by default."
L["wep." .. w .. ".trivia.manufacturer"] = "Remington Arms"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "superv"
L["wep." .. w .. ".name.full"] = "Kriss Vector"
L["wep." .. w .. ".name"] = "Vector"
L["wep." .. w .. ".desc"] = "Close range SMG with extremely high fire rate and practically no recoil. Low armor penetration, but can chew through it very quickly."
L["wep." .. w .. ".trivia.manufacturer"] = "Kriss USA, Inc."
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "tgs12"
L["wep." .. w .. ".name.full"] = "Tomahawk Matador"
L["wep." .. w .. ".name"] = "Matador"
L["wep." .. w .. ".desc"] = "Short barrel pistol grip shotgun. High mobility and recoil, and most effective at close range."
L["wep." .. w .. ".desc.quote"] = "For years, its true identity was a mystery."
L["wep." .. w .. ".trivia.manufacturer"] = "Tomahawk Shotguns"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "uratio"
L["wep." .. w .. ".name.full"] = "PGM Ultima Ratio"
L["wep." .. w .. ".name"] = "Ultima Ratio"
L["wep." .. w .. ".desc"] = "Lightweight sniper rifle with good damage and high mobility. \nEquipped with a 10x scope by default."
L["wep." .. w .. ".trivia.manufacturer"] = "PGM Précision"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "uzi"
L["wep." .. w .. ".name.full"] = "IMI Uzi Pro"
L["wep." .. w .. ".name"] = "Uzi Pro"
L["wep." .. w .. ".desc"] = "Balanced machine pistol with a controllable rate of fire."
L["wep." .. w .. ".trivia.manufacturer"] = "Israel Military Industries"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "vertec"
L["wep." .. w .. ".name.full"] = "Beretta 92FS Vertec"
L["wep." .. w .. ".name"] = "92FS Vertec"
L["wep." .. w .. ".desc"] = "Italian pistol with above average range and accuracy."
L["wep." .. w .. ".desc.quote"] = "\"Yippie ki-yay, motherfucker!\""
L["wep." .. w .. ".trivia.manufacturer"] = "Pietro Beretta"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

w = ws .. "xd45"
L["wep." .. w .. ".name.full"] = "Springfield XD-45"
L["wep." .. w .. ".name"] = "XD-45"
L["wep." .. w .. ".desc"] = "Automatic machine pistol with incredible close range power."
L["wep." .. w .. ".trivia.manufacturer"] = "Springfield Armory"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

-- Attachments (Non-Bulk)
L["att.melee_spec_charge.name.full"] = "demoknight tf2"
L["att.melee_spec_charge.name"] = "Charge"
L["att.melee_spec_charge.desc"] = "Advance with reckless abandon, and break some laws of physics too."
L["att.pro.melee_spec_charge1"] = "RELOAD: Charge"
L["att.pro.melee_spec_charge2"] = "WALK + RELOAD: Select Charge Mode"
L["att.pro.melee_spec_charge3"] = "Reduced Damage while Charging"
L["att.pro.melee_spec_charge4"] = "Reduced Self-Damage"

L["att.melee_spec_lunge.name"] = "Frency"
L["att.melee_spec_lunge.desc"] = "Close the distance and overwhelm your enemies."
L["att.pro.melee_spec_lunge1"] = "RELOAD: Lunge in Aim Direction"

L["att.melee_spec_nade.name.full"] = "Bombardier"
L["att.melee_spec_nade.name"] = "Bomber"
L["att.melee_spec_nade.desc"] = "Use jury-rigged impact grenades to ruin someone's day."
L["att.pro.melee_spec_nade1"] = "RELOAD: Toggle Grenades"
L["att.pro.melee_spec_nade2"] = "Grenades Explode on Impact"
L["att.con.melee_spec_nade"] = "Grenade Damage"

L["att.melee_spec_ninja.name"] = "Ninja"
L["att.melee_spec_ninja.desc"] = "Disrupt your enemies and strike with the element of surprise."
L["att.pro.melee_spec_ninja1"] = "RELOAD: Palm Strike / Climb"
L["att.pro.melee_spec_ninja2"] = "RELOAD: (Mid-Air + Crouch): Dive Kick"
L["att.pro.melee_spec_ninja3"] = "RELOAD: (Crouch): Backhop"
L["att.pro.melee_spec_ninja4"] = "Silent Footsteps"

L["att.melee_spec_scout.name.full"] = "jerma tf2"
L["att.melee_spec_scout.name"] = "Scout"
L["att.melee_spec_scout.desc"] = "Grass grows, sun shines, birds fly, and brotha' - I hurt people."
L["att.pro.melee_spec_scout1"] = "RELOAD: Launch Ball"
L["att.pro.melee_spec_scout2"] = "Ball Damage Scales with Distance"
L["att.pro.melee_spec_scout3"] = "Ball Applies Slow on Hit"
L["att.pro.melee_spec_scout4"] = "Multi Jump"

L["att.melee_spec_step.name"] = "Airdash"
L["att.melee_spec_step.desc"] = "Mobility tool used by blood-fueled robots and transgender women."
L["att.pro.melee_spec_step1"] = "RELOAD: Dash in Movement Direction"
L["att.pro.melee_spec_step2"] = "Invulnerable while Dashing"

L["att.melee_spec_block.name.full"] = "High Guard"
L["att.melee_spec_block.name"] = "Guard"
L["att.melee_spec_block.desc"] = "Defense is the best offense. It is, coincidentally, also the best defense."
L["att.pro.melee_spec_block1"] = "ALT-FIRE: Block Melee Attacks or Projectiles"
L["att.pro.melee_spec_block2"] = "Heavy Counterattack After Successful Block"

L["att.melee_spec_heavy.name.full"] = "Heavy-handed"
L["att.melee_spec_heavy.name"] = "Heavy"
L["att.melee_spec_heavy.desc"] = "A classic counter-terrorist technique: Just smack them real hard."
L["att.pro.melee_spec_heavy1"] = "ALT-FIRE: Heavy Attack"
L["att.pro.melee_spec_heavy2"] = "Backstab Damage"

L["att.melee_tech_nade.name.full"] = "Grenadier"
L["att.melee_tech_nade.name"] = "Grenade"
L["att.melee_tech_nade.desc"] = "Always good to have something handy to throw."
L["att.pro.melee_tech_nade1"] = "ALT-FIRE: Quickthrow"
L["att.pro.melee_tech_nade2"] = "Faster Quickthrow"
L["att.pro.melee_tech_nade3"] = "Throw Rocks"

L["att.melee_tech_throw.name.full"] = "Knife Throw"
L["att.melee_tech_throw.name"] = "Throw"
L["att.melee_tech_throw.desc"] = "Bar trick turned lethal."
L["att.pro.melee_tech_throw1"] = "ALT-FIRE: Throw Weapon"
L["att.pro.melee_tech_throw2"] = "Consumes Crossbow Bolt Ammo"
L["att.pro.melee_tech_throw3"] = "Bonus Headshot Damage"
L["att.pro.melee_tech_throw4"] = "Bonus Damage on Slowed/Stunned Targets"

-- Attachments (acc)
L["att.acc_bipod.name"] = "Bipod"
L["att.acc_bipod.desc"] = "Foldable support that stabilizes the weapon when deployed."

L["att.acc_brace.name"] = "Pistol Brace"
L["att.acc_brace.desc"] = "Turns your pistol into a rifle. The ATF is gonna get your ass."

L["att.acc_cheekrest.name"] = "Cheek Rest"
L["att.acc_cheekrest.desc"] = "Stabilizes your head while aiming down sights, reducing sway."

L["att.acc_dual_ergo.name.full"] = "Ergonomic Grip"
L["att.acc_dual_ergo.name"] = "Ergo Grip"
L["att.acc_dual_ergo.desc"] = "Grooved grip makes it easier to move while shooting two guns."

L["att.acc_dual_quickdraw.name.full"] = "Quickdraw Holster"
L["att.acc_dual_quickdraw.name"] = "Quickdraw"
L["att.acc_dual_quickdraw.desc"] = "A pair of strapless holster to quickly draw the weapons and hasten loading."

L["att.acc_dual_skel.name.full"] = "Lightweight Grip"
L["att.acc_dual_skel.name"] = "Light Grip"
L["att.acc_dual_skel.desc"] = "Skeletonized grip makes the guns lighter and easier to move around with."

L["att.acc_duffelbag.name"] = "Gun Bag"
L["att.acc_duffelbag.desc"] = "Hide the gun in a bag so you don't cause mass panic."

L["att.acc_ergo.desc"] = "Grooved grip makes aiming faster and moving while shooting easier."

L["att.acc_extendedbelt.name.full"] = "Box Extender"
L["att.acc_extendedbelt.name"] = "Box Ext."
L["att.acc_extendedbelt.desc"] = "Increase ammo capacity for machine guns significantly."

L["att.acc_extmag.name.full"] = "Extended Magazine"
L["att.acc_extmag.name"] = "Ext Mag"
L["att.acc_extmag.desc"] = "Slightly increase weapon capacity."

L["att.acc_foldstock.name"] = "Fold Stock"
L["att.acc_foldstock.desc"] = "Keep stock folded, improving handling significantly at the cost of recoil."

L["att.acc_foldstock2.name"] = "Adjust Stock"
L["att.acc_foldstock2.desc"] = "Shorten stock to improve handling somewhat at the cost of recoil."

L["att.acc_pad.name"] = "Recoil Pad"
L["att.acc_pad.desc"] = "Rubber pad attached to the end of the stock."

L["att.acc_quickdraw.desc"] = "Strapless holster with magazine pouches for quick drawing and loading."

L["att.acc_skel.desc"] = "Skeletonized grip makes the weapon faster to raise and keep raised."

L["att.acc_sling.name"] = "Sling"
L["att.acc_sling.desc"] = "Attach a strap to the weapon, making it easier to draw and reload."

-- Attachments (ammo)
L["att.ammo_40mm_3gl.name.full"] = "40mm Cluster Grenades"
L["att.ammo_40mm_3gl.name"] = "3GL"
L["att.ammo_40mm_3gl.desc"] = "Three weak cluster grenades, fired at once."

L["att.ammo_40mm_buck.name.full"] = "40mm Buckshot Grenades"
L["att.ammo_40mm_buck.name"] = "Buckshot"
L["att.ammo_40mm_buck.desc"] = "Flat-top grenade firing shotgun pellets. Weak due to low pressure curve."

L["att.ammo_40mm_gas.name.full"] = "40mm CS Gas Grenades"
L["att.ammo_40mm_gas.name"] = "CS Gas"
L["att.ammo_40mm_gas.desc"] = "Grenade containing crowd control chemicals that deal lingering damage."

L["att.ammo_40mm_heat.name.full"] = "40mm Flechette Grenades"
L["att.ammo_40mm_heat.name"] = "Flechette"
L["att.ammo_40mm_heat.desc"] = "Flat-top grenade packing accurate flechette darts."

L["att.ammo_40mm_lvg.name.full"] = "40mm Concussion Grenades"
L["att.ammo_40mm_lvg.name"] = "Concussion"
L["att.ammo_40mm_lvg.desc"] = "Low velocity grenade made to incapacitate targets with indirect fire."

L["att.ammo_40mm_ratshot.name.full"] = "40mm Ratshot Grenades"
L["att.ammo_40mm_ratshot.name"] = "Ratshot"
L["att.ammo_40mm_ratshot.desc"] = "For rodents of unbelievable size."

L["att.ammo_40mm_smoke.name.full"] = "40mm Smoke Grenades"
L["att.ammo_40mm_smoke.name"] = "Smoke"
L["att.ammo_40mm_smoke.desc"] = "Grenade that produces a concealing smokescreen on impact."

L["att.ammo_40mm_heal.name.full"] = "40mm Medi-Smoke Grenades"
L["att.ammo_40mm_heal.name"] = "Medi-Smoke"
L["att.ammo_40mm_heal.desc"] = "Grenade that produces a cloud of restorative gas on impact."

L["att.ammo_amr_hv.name.full"] = "High Velocity Rounds"
L["att.ammo_amr_hv.name"] = "HV"
L["att.ammo_amr_hv.desc"] = "Bullets with much higher velocity, but worsens overpenetration."

L["att.ammo_amr_ratshot.name.full"] = "Ratshot Rounds"
L["att.ammo_amr_ratshot.name"] = "Ratshot"
L["att.ammo_amr_ratshot.desc"] = "For rodents of unusual size."

L["att.ammo_amr_saphe.name.full"] = "Semi-Armor Piercing High-Explosive Rounds"
L["att.ammo_amr_saphe.name"] = "SAPHE"
L["att.ammo_amr_saphe.desc"] = "Explosive rounds effective against both armor and personnel."

L["att.ammo_ks23_flashbang.name.full"] = "KS-23 Zvezda Flash Shells"
L["att.ammo_ks23_flashbang.name"] = "Zvezda"
L["att.ammo_ks23_flashbang.desc"] = "Flashbang shells that stun enemies, right from the barrel."

L["att.ammo_ks23_flashbang_top.name.full"] = "KS-23 Zvezda Flash Shells (Top-Loaded)"
L["att.ammo_ks23_flashbang_top.name"] = "Zvezda (T)"
L["att.ammo_ks23_flashbang_top.desc"] = "Load the first round with flash rounds and the rest with standard shells."

L["att.ammo_magnum.name.full"] = "Overpressured Rounds"
L["att.ammo_magnum.name"] = "+P"
L["att.ammo_magnum.desc"] = "Bullets that maintain close range power better, but have higher recoil."

L["att.ammo_pistol_ap.name.full"] = "Steel Core Rounds"
L["att.ammo_pistol_ap.name"] = "Steel Core"
L["att.ammo_pistol_ap.desc"] = "Hardened bullets better penetrate armor, but destabilize ballistics."

L["att.ammo_pistol_headshot.name.full"] = "Skullsplitter Rounds"
L["att.ammo_pistol_headshot.name"] = "Skullsplitter"
L["att.ammo_pistol_headshot.desc"] = "Specialized rounds that do more damage to vital body parts."

L["att.ammo_pistol_hollowpoints.name.full"] = "Hollow-point Rounds"
L["att.ammo_pistol_hollowpoints.name"] = "HP"
L["att.ammo_pistol_hollowpoints.desc"] = "Bullets that expand on hit, improving damage to flesh targets and limbs."

L["att.ammo_rifle_jhp.name.full"] = "Jacketed Hollow-point Rounds"
L["att.ammo_rifle_jhp.name"] = "JHP"
L["att.ammo_rifle_jhp.desc"] = "Bullets with much higher velocity, but worsens overpenetration."

L["att.ammo_pistol_match.name.full"] = "Pistol Match Rounds"
L["att.ammo_pistol_match.name"] = "Match"
L["att.ammo_pistol_match.desc"] = "Bullets with improved range and accuracy."

L["att.ammo_rifle_match.name.full"] = "Rifle Match Rounds"
L["att.ammo_rifle_match.name"] = "Match"
L["att.ammo_rifle_match.desc"] = "Bullets with greatly improved accuracy."

L["att.ammo_roulette.name.full"] = "Russian Roulette"
L["att.ammo_roulette.name"] = "Roulette"
L["att.ammo_roulette.desc"] = "A lethal game of chance. Spin the cylinder while loaded to reset the odds."

L["att.ammo_rpg_improvised.name.full"] = "RPG-7 Improvised Warhead"
L["att.ammo_rpg_improvised.name"] = "Improvised"
L["att.ammo_rpg_improvised.desc"] = "Straight from the bargain bin."

L["att.ammo_rpg_mortar.name.full"] = "RPG-7 Mortar Warhead"
L["att.ammo_rpg_mortar.name"] = "Mortar"
L["att.ammo_rpg_mortar.desc"] = "A mortar with a booster stuck to it, for \"indirect fire\". Needs time to prime."

L["att.ammo_rpg_ratshot.name.full"] = "RPG-7 Ratshot Warhead"
L["att.ammo_rpg_ratshot.name"] = "Ratshot"
L["att.ammo_rpg_ratshot.desc"] = "For rodents of unacceptable size."

L["att.ammo_rpg_harpoon.name.full"] = "RPG-7 Shovel Warhead"
L["att.ammo_rpg_harpoon.name"] = "Shovel"
L["att.ammo_rpg_harpoon.desc"] = "Fire shovels, somehow. Either you're crazy, out of rockets, or both."

L["att.ammo_shotgun_bird.name"] = "Birdshot"
L["att.ammo_shotgun_bird.desc"] = "Fire smaller pellets in a larger spread."

L["att.ammo_shotgun_mag.name.full"] = "Magnum Buckshot"
L["att.ammo_shotgun_mag.name"] = "Magnum"
L["att.ammo_shotgun_mag.desc"] = "High yield powder improves damage retention past point blank."

L["att.ammo_shotgun_slugs.name.full"] = "Slug Shells"
L["att.ammo_shotgun_slugs.name"] = "Slugs"
L["att.ammo_shotgun_slugs.desc"] = "Fire a single projectile for medium range shooting."

L["att.ammo_shotgun_triple.name.full"] = "Triple Hit Shells"
L["att.ammo_shotgun_triple.name"] = "Triple Hit"
L["att.ammo_shotgun_triple.desc"] = "Fire three projectiles for more accuracy."

L["att.ammo_subsonic.name.full"] = "Subsonic Rounds"
L["att.ammo_subsonic.name"] = "Subsonic"
L["att.ammo_subsonic.desc"] = "Bullets with reduced powder load."

L["att.ammo_surplus.name.full"] = "Surplus Rounds"
L["att.ammo_surplus.name"] = "Surplus"
L["att.ammo_surplus.desc"] = "Unreliable old ammo, yet you keep finding them everywhere."

L["att.ammo_tmj.name.full"] = "Total Metal Jacket Rounds"
L["att.ammo_tmj.name"] = "TMJ"
L["att.ammo_tmj.desc"] = "Bullets with improved penetration capability."

L["att.ammo_buckshot_roulette.name.full"] = "Buckshot Roulette"
L["att.ammo_buckshot_roulette.name"] = "B. Roulette"
L["att.ammo_buckshot_roulette.desc"] = "The shells enter the chamber in an unknown order."

L["att.ammo_shotgun_minishell.name.full"] = "Minishells"
L["att.ammo_shotgun_minishell.name"] = "Minis"
L["att.ammo_shotgun_minishell.desc"] = "Short shells increase ammo capacity but don't hit as hard."

L["att.ammo_shotgun_dragon.name.full"] = "Dragon's Breath"
L["att.ammo_shotgun_dragon.name"] = "Dragon"
L["att.ammo_shotgun_dragon.desc"] = "Magnesium pellets set targets on fire, but have poor range and damage."

L["att.ammo_shotgun_frag.name.full"] = "High-Explosive Fragmentation Shells"
L["att.ammo_shotgun_frag.name"] = "Frag"
L["att.ammo_shotgun_frag.desc"] = "Explosive slugs deal area damage, but don't expect too much from them."

L["att.ammo_shotgun_breach.name.full"] = "Breaching Shells (Top-Loaded)"
L["att.ammo_shotgun_breach.name"] = "Breach (T)"
L["att.ammo_shotgun_breach.desc"] = "Load the first round with a specialized breaching slug."

L["att.ammo_stinger_saam.name.full"] = "FIM-92 Stinger Semi-Active Missile"
L["att.ammo_stinger_saam.name"] = "Semi-Active"
L["att.ammo_stinger_saam.desc"] = "Powerful missiles that lock rapidly but require constant guidance."

L["att.ammo_stinger_qaam.name.full"] = "FIM-92 Stinger High Agility Missile"
L["att.ammo_stinger_qaam.name"] = "Agile"
L["att.ammo_stinger_qaam.desc"] = "Highly maneuverable missile with a short range and long lock time."

L["att.ammo_stinger_4aam.name.full"] = "FIM-92 Stinger Quad Missiles"
L["att.ammo_stinger_4aam.name"] = "4x"
L["att.ammo_stinger_4aam.desc"] = "Guided cluster missiles maximize pressure to enemy pilots."

L["att.ammo_stinger_apers.name.full"] = "FIM-92 Stinger Anti-Personnel Missiles"
L["att.ammo_stinger_apers.name"] = "Killer Bee"
L["att.ammo_stinger_apers.desc"] = "For rodents of unacceptable agility."

L["att.ammo_usp_9mm.name.full"] = "HK USP 9×19mm Conversion"
L["att.ammo_usp_9mm.name"] = "9×19mm"
L["att.ammo_usp_9mm.desc"] = "Fire a smaller caliber round with higher capacity and firerate."

-- Attachments (bolt_trigger)
L["att.bolt_fine.name.full"] = "Refined Bolt"
L["att.bolt_fine.name"] = "Refined"
L["att.bolt_fine.desc"] = "A delicate bolt suitable for short bursts."

L["att.bolt_greased.name.full"] = "Greased Bolt"
L["att.bolt_greased.name"] = "Greased"
L["att.bolt_greased.desc"] = "Faster cycle speed but handling is worse."

L["att.bolt_heavy.name.full"] = "Heavy Bolt"
L["att.bolt_heavy.name"] = "Heavy"
L["att.bolt_heavy.desc"] = "Reduce recoil at the cost of fire rate."

L["att.bolt_light.name.full"] = "Light Bolt"
L["att.bolt_light.name"] = "Light"
L["att.bolt_light.desc"] = "Increase fire rate at the cost of recoil."

L["att.bolt_rough.name.full"] = "Rugged Bolt"
L["att.bolt_rough.name"] = "Rugged"
L["att.bolt_rough.desc"] = "A durable bolt suitable for long bursts."

L["att.bolt_surplus.name.full"] = "Surplus Bolt"
L["att.bolt_surplus.name"] = "Surplus"
L["att.bolt_surplus.desc"] = "Rust has eaten most of it away, but it still kinda works."

L["att.bolt_tactical.name.full"] = "Tactical Bolt"
L["att.bolt_tactical.name"] = "Tactical"
L["att.bolt_tactical.desc"] = "Heavier bolt trades cycling speed for superb control of the weapon."

L["att.bolt_refurbished.name.full"] = "Refurbished Bolt"
L["att.bolt_refurbished.name"] = "Refurbished"
L["att.bolt_refurbished.desc"] = "Fix the gun's reliability problems with some armory tweaks."

L["att.trigger_akimbo.name.full"] = "Akimbo Trigger"
L["att.trigger_akimbo.name"] = "Akimbo"
L["att.trigger_akimbo.desc"] = "Let'em have it!"

L["att.trigger_burst.name.full"] = "Burst Trigger"
L["att.trigger_burst.name"] = "Burst"
L["att.trigger_burst.desc"] = "Trigger that sacrfices automatic fire for stability."

L["att.trigger_burst2.desc"] = "Trigger that emulates burst fire."

L["att.trigger_burstauto.name.full"] = "Auto-Burst Trigger"
L["att.trigger_burstauto.name"] = "Auto-Burst"
L["att.trigger_burstauto.desc"] = "Trigger that allows continuous burst fire while held."

L["att.trigger_comp.name.full"] = "Competition Trigger"
L["att.trigger_comp.name"] = "Competition"
L["att.trigger_comp.desc"] = "Lightweight trigger for sports shooting."

L["att.trigger_comp2.desc"] = "Lightweight trigger that recovers from accuracy faster."

L["att.trigger_frcd.name.full"] = "Forced Reset Trigger"
L["att.trigger_frcd.name"] = "Forced Reset"
L["att.trigger_frcd.desc"] = "Trigger that emulates automatic fire but with poor performance."

L["att.trigger_hair.name.full"] = "Feather Trigger"
L["att.trigger_hair.name"] = "Feather"
L["att.trigger_hair.desc"] = "Very sensitive trigger for rapid semi-automatic fire."

L["att.trigger_hair_akimbo.desc"] = "Very sensitive trigger for rapid akimbo fire."

L["att.trigger_heavy.name.full"] = "Weighted Trigger"
L["att.trigger_heavy.name"] = "Weighted"
L["att.trigger_heavy.desc"] = "Heavy trigger for sustained fire."

L["att.trigger_heavy2.desc"] = "Heavy trigger that reduces mobility impact from shooting."

L["att.trigger_semi.name.full"] = "Marksman Trigger"
L["att.trigger_semi.name"] = "Marksman"
L["att.trigger_semi.desc"] = "Trigger that sacrfices automatic fire for precision."

L["att.trigger_slam.name.full"] = "Slamfire Trigger"
L["att.trigger_slam.name"] = "Slamfire"

L["att.trigger_straight.name.full"] = "Straight Trigger"
L["att.trigger_straight.name"] = "Straight"
L["att.trigger_straight.desc"] = "Narrow trigger with superior recoil performance."

L["att.trigger_wide.name.full"] = "Akimbo Trigger"
L["att.trigger_wide.name"] = "Akimbo"
L["att.trigger_wide.desc"] = "Large trigger assembly, easy to hold even in awkward positions."

L["att.trigger_dualstage.name.full"] = "Dual Stage Trigger"
L["att.trigger_dualstage.name"] = "D. Stage"
L["att.trigger_dualstage.desc"] = "Trigger that reduces firerate while aiming for better control and accuracy."

-- Attachments (melee_boost)
L["att.melee_boost_all.name"] = "Level Up"
L["att.melee_boost_all.desc"] = "Small boost to all attributes."

L["att.melee_boost_str.name"] = "Bulk Up"
L["att.melee_boost_str.desc"] = "Increase Brawn significantly at the cost of other attributes."

L["att.melee_boost_agi.name"] = "Catch Up"
L["att.melee_boost_agi.desc"] = "Increase Dexterity significantly at the cost of other attributes."

L["att.melee_boost_int.name"] = "Wise Up"
L["att.melee_boost_int.desc"] = "Increase Strategy significantly at the cost of other attributes."

L["att.melee_boost_lifesteal.name"] = "Lifestealer"
L["att.melee_boost_lifesteal.desc"] = "Restore health by dealing damage."

L["att.melee_boost_momentum.name"] = "Momentum"
L["att.melee_boost_momentum.desc"] = "Restore perk charge by dealing damage."

L["att.melee_boost_afterimage.name"] = "Afterimage"
L["att.melee_boost_afterimage.desc"] = "Swing your weapon in a flash, landing the attack instantly."

L["att.melee_boost_shock.name.full"] = "Shock Trooper"
L["att.melee_boost_shock.name"] = "S. Trooper"
L["att.melee_boost_shock.desc"] = "Reduce impact of impairing effects while weapon is held."

-- Attachments (muzz)
L["att.muzz_hbar.name"] = "Heavy Barrel"
L["att.muzz_hbar.desc"] = "Sturdy barrel with improved sway and recoil performance."

L["att.muzz_lbar.name"] = "Light Barrel"
L["att.muzz_lbar.desc"] = "Lightweight barrel more accurate and effective at long range."

L["att.muzz_pistol_comp.name"] = "Compensator"
L["att.muzz_pistol_comp.desc"] = "Muzzle device which reduces recoil impact."

L["att.muzz_supp_compact.name.full"] = "Compact Suppressor"
L["att.muzz_supp_compact.name"] = "C. Suppressor"
L["att.muzz_supp_compact.desc"] = "Short suppressor improving accuracy with low impact to effective range."

L["att.muzz_silencer.name.full"] = "Tactical Suppressor"
L["att.muzz_silencer.name"] = "T. Suppressor"
L["att.muzz_silencer.desc"] = "Balanced suppressor that reduces recoil and effective range."

L["att.muzz_supp_weighted.name.full"] = "Weighted Suppressor"
L["att.muzz_supp_weighted.name"] = "W. Suppressor"
L["att.muzz_supp_weighted.desc"] = "Heavy suppressor with superior ballistics but worse handling."

L["att.muzz_brake_aggressor.name.full"] = "Aggressor Brake"
L["att.muzz_brake_aggressor.name"] = "A. Brake"
L["att.muzz_brake_aggressor.desc"] = "Muzzle brake designed to redirect vented gases away from the shooter."

L["att.muzz_brake_breaching.name.full"] = "Breaching Brake"
L["att.muzz_brake_breaching.name"] = "B. Brake"
L["att.muzz_brake_breaching.desc"] = "Spiked muzzle brake designed for close combat."

L["att.muzz_brake_concussive.name.full"] = "Concussive Brake"
L["att.muzz_brake_concussive.name"] = "C. Brake"
L["att.muzz_brake_concussive.desc"] = "Viciously loud, uncomfortable muzzle brake for extreme recoil control."

-- Attachments (optic_tac)
L["att.optic_8x.name.full"] = "Telescopic Scope"
L["att.optic_8x.name"] = "Telescopic"
L["att.optic_8x.desc"] = "Long-range sniper optic."

L["att.optic_acog.name.full"] = "ACOG Scope"
L["att.optic_acog.name"] = "ACOG"
L["att.optic_acog.desc"] = "Medium range combat scope."

L["att.optic_elcan.name.full"] = "ELCAN Scope"
L["att.optic_elcan.name"] = "ELCAN"
L["att.optic_elcan.desc"] = "Low power combat scope."

L["att.optic_holographic.name.full"] = "Holographic Sight"
L["att.optic_holographic.name"] = "Holographic"
L["att.optic_holographic.desc"] = "Boxy optic to assist aiming at close range."

L["att.optic_irons.name"] = "Iron Sights"
L["att.optic_irons.desc"] = "Basic sights for added mobility."

L["att.optic_irons_sniper.desc"] = "Replace default scope for faster aim and better mobility."

L["att.optic_okp7.name"] = "OKP-7"
L["att.optic_okp7.desc"] = "Low profile reflex sight with minimal zoom."

L["att.optic_rds2.name.full"] = "Red Dot Sight"
L["att.optic_rds2.name"] = "Red Dot"
L["att.optic_rds2.desc"] = "Open reflex sight with a clear view."

L["att.optic_rds.name"] = "Aimpoint"
L["att.optic_rds.desc"] = "Tube optic to assist aiming at close range."

L["att.optic_rmr.name"] = "RMR"
L["att.optic_rmr.desc"] = "Low profile optic sight for pistols."

L["att.optic_rmr_rifle.desc"] = "Low profile optic sight."

L["att.optic_shortdot.name"] = "Short Dot"
L["att.optic_shortdot.desc"] = "Compact optic scope with decent magnification."

L["att.tac_cornershot.name"] = "Corner-Cam"
L["att.tac_cornershot.desc"] = "Displays point of aim while blindfiring."

L["att.tac_dmic.name"] = "Radar"
L["att.tac_dmic.desc"] = "Detects the position of nearby targets, but emits sound."

L["att.tac_flashlight.name"] = "Flashlight"
L["att.tac_flashlight.desc"] = "Emits a strong beam of light, blinding anyone staring into it."

L["att.tac_laser.name"] = "Laser"
L["att.tac_laser.desc"] = "Emits a narrow red beam and dot, indicating where the gun is pointed at."

L["att.tac_combo.name.full"] = "Laser-Light Combo"
L["att.tac_combo.name"] = "Combo"
L["att.tac_combo.desc"] = "Emits a green laser and flashlight. The light is too weak to blind others."

L["att.tac_rangefinder.name"] = "Rangefinder"
L["att.tac_rangefinder.desc"] = "Measures ballistic performance of the weapon."

L["att.tac_spreadgauge.name"] = "Spread Gauge"
L["att.tac_spreadgauge.desc"] = "Measures weapon stability from sway and bloom."

L["att.tac_magnifier.name"] = "Variable Zoom Optic (2x)"
L["att.tac_magnifier.name"] = "2x Zoom"
L["att.tac_magnifier.desc"] = "Allows all optics to access a 2x zoom level, allowing them to zoom in or out."

L["att.tac_bullet.name.full"] = "Emergency Bullet"
L["att.tac_bullet.name"] = "Emrg. Bullet"
L["att.tac_bullet.desc"] = "Press the tactical key to quickly load a single bullet for emergencies."

L["att.tac_thermal.name.full"] = "ZUMQFY Thermal Imaging Device"
L["att.tac_thermal.name"] = "Thermal-Cam"
L["att.tac_thermal.desc"] = "Display a thermal overlay which fuses with the main view while peeking."

-- Attachments (perk)
L["att.perk_aim.name"] = "Deadeye"
L["att.perk_aim.desc"] = "Zooms in your aim and makes it easier to fire while sighted."

L["att.perk_blindfire.name.full"] = "Point Shooter"
L["att.perk_blindfire.name"] = "Point Shoot"
L["att.perk_blindfire.desc"] = "Improves blindfire and peeking."

L["att.perk_hipfire.name"] = "Rambo"
L["att.perk_hipfire.desc"] = "Improves weapon accuracy while not aiming."

L["att.perk_melee.name"] = "Smackdown"
L["att.perk_melee.desc"] = "Improves melee damage, and slows struck targets."

L["att.perk_reload.name"] = "Quickload"
L["att.perk_reload.desc"] = "Improves reloading speed."

L["att.perk_speed.name"] = "Agility"
L["att.perk_speed.desc"] = "Improves weapon mobility, especially while reloading."

L["att.perk_throw.name"] = "Grenadier"
L["att.perk_throw.desc"] = "Improves quickthrow, and adds the option to throw rocks."

L["att.perk_mlg.name"] = "Stylish"
L["att.perk_mlg.desc"] = "Improves quickscoping and accuracy while jumping or moving."

///////////////////// -- [[ InterOps Weapons ]] --
-- Weapons
ws = "tacrp_io_"
w = ws .. "870"
L["wep." .. w .. ".name.full"] = "Remington 870 SPMM"
L["wep." .. w .. ".name"] = "R870 SPMM"
L["wep." .. w .. ".desc"] = "Nickel plated \"Marine Magnum\" shotgun. Poor handling, but has great capacity and firepower."
L["wep." .. w .. ".desc.quote"] = "\"THERE'S GOLD IN THEM THAR HILLS!\""
L["wep." .. w .. ".trivia.manufacturer"] = "Remington"
L["wep." .. w .. ".credits"] = "Model: Twinke Masta \nTextures: Millenia \nSounds: Vunsunta, xLongWayHome \nAnimations: Tactical Intervention"

w = ws .. "ab10"
L["wep." .. w .. ".name.full"] = "Intratec AB-10"
L["wep." .. w .. ".name"] = "AB-10"
L["wep." .. w .. ".desc"] = "Semi-automatic \"After Ban\" model of the TEC-9 with a short, non-threaded barrel. Big magazine, but unreliable."
L["wep." .. w .. ".desc.quote"] = "\"Who needs an assault weapon?\""
L["wep." .. w .. ".trivia.manufacturer"] = "Intratec"
L["wep." .. w .. ".credits"] = "Model/Textures: Payday 2 \nSounds: The_AntiPirate \nAnimations Tactical Intervention"

w = ws .. "af2011"
L["wep." .. w .. ".name.full"] = "AF2011-A1"
L["wep." .. w .. ".name"] = "AF2011"
L["wep." .. w .. ".desc"] = "Effectively two M1911s welded together, this exotic abomination fires two bullets per trigger pull."
L["wep." .. w .. ".desc.quote"] = "\"If the 1911 is so good, why isn't there a 1911 2?\""
L["wep." .. w .. ".trivia.manufacturer"] = "Arsenal Firearms"
L["wep." .. w .. ".credits"] = "Assets: Counter Strike: Online 2 \nAnimations Tactical Intervention"

w = ws .. "automag"
L["wep." .. w .. ".name.full"] = "Auto Mag Pistol"
L["wep." .. w .. ".name"] = "Auto Mag"
L["wep." .. w .. ".desc"] = "Highly accurate magnum pistol. Great handling due to its size, but can only mount pistol optics."
L["wep." .. w .. ".desc.quote"] = "\"And if properly used, it can remove the fingerprints.\""
L["wep." .. w .. ".trivia.manufacturer"] = "Auto Mag Corporation"
L["wep." .. w .. ".credits"] = "Model: RedRogueXIII \nTextures/Sounds: Futon \nAnimations Tactical Intervention"

w = ws .. "chinalake"
L["wep." .. w .. ".name.full"] = "China Lake Launcher"
L["wep." .. w .. ".name"] = "China Lake"
L["wep." .. w .. ".desc"] = "Heavy pump action grenade launcher with high muzzle velocity but poor handling."
L["wep." .. w .. ".desc.quote"] = "Only 59 of these ever existed. Where'd you get this one?"
L["wep." .. w .. ".trivia.manufacturer"] = "NAWS China Lake"
L["wep." .. w .. ".credits"] = "Assets: Counter Strike: Online 2 \nAnimations Tactical Intervention"

w = ws .. "coltsmg"
L["wep." .. w .. ".name"] = "Colt 9mm SMG"
L["wep." .. w .. ".desc"] = "AR platform burst-fire SMG. Excellent recoil control, good damage and range but limited optic options. Favored by the Department of Energy."
L["wep." .. w .. ".desc.quote"] = "Loudspeaker not included."
L["wep." .. w .. ".trivia.manufacturer"] = "Colt"
L["wep." .. w .. ".credits"] = "Assets: Twinke Masta & Kimono \nSounds: Strelok & New World Interactive \nAnimations Tactical Intervention"

w = ws .. "cx4"
L["wep." .. w .. ".name.full"] = "Beretta CX4 Storm"
L["wep." .. w .. ".name"] = "CX4 Storm"
L["wep." .. w .. ".desc"] = "Semi-automatic pistol carbine with good range. \nMediocre armor penetration, but the large frame makes the weapon quite stable."
L["wep." .. w .. ".desc.quote"] = "As famously seen in a certain PMC leader's arsenal."
L["wep." .. w .. ".trivia.manufacturer"] = "Pietro Beretta"
L["wep." .. w .. ".credits"] = "Assets: Counter Strike: Online 2 \nAnimations Tactical Intervention"

w = ws .. "degala"
L["wep." .. w .. ".name.full"] = "Desert Eagle"
L["wep." .. w .. ".name"] = "Deagle"
L["wep." .. w .. ".desc"] = "Imposing magnum pistol, as iconic as it gets. \nPowerful and high capacity, but recoil is hard to manage."
L["wep." .. w .. ".desc.quote"] = "\"You hear that, Mr. Anderson?\""
L["wep." .. w .. ".trivia.manufacturer"] = "Magnum Research"
L["wep." .. w .. ".credits"] = "Model: Vashts1985 \nTextures: Racer445 \nSounds:Vunsunta, XLongWayHome \nAnimations Tactical Intervention"

w = ws .. "fiveseven"
L["wep." .. w .. ".name.full"] = "FN Five-seveN"
L["wep." .. w .. ".name"] = "Five-seveN"
L["wep." .. w .. ".desc"] = "Bulky PDW caliber pistol with excellent capacity. \nHigh velocity rounds retain effectiveness at range and pierces armor easily."
L["wep." .. w .. ".desc.quote"] = "Is that a ferret running around?"
L["wep." .. w .. ".trivia.manufacturer"] = "FN Herstal"
L["wep." .. w .. ".credits"] = "Assets: Counter-Strike: Online 2, edited by speedonerd \nSounds: Vunsunta, Counter-Strike: Online 2 \nAnimations Tactical Intervention"

w = ws .. "fnc"
L["wep." .. w .. ".name.full"] = "FN FNC Para"
L["wep." .. w .. ".name"] = "FNC Para"
L["wep." .. w .. ".desc"] = "Lightweight assault rifle with high hipfire precision and mobility, but low range and poor armor penetration."
L["wep." .. w .. ".desc.quote"] = "\"I say what I mean and I do what I say.\""
L["wep." .. w .. ".trivia.manufacturer"] = "FN Herstal"
L["wep." .. w .. ".credits"] = "Model: Twinke Masta \nTextures: Twinke Masta, the_tub,  Xero \nSounds: Vunsunta \nAnimations Tactical Intervention"

w = ws .. "glock18"
L["wep." .. w .. ".name"] = "Glock 18C"
L["wep." .. w .. ".desc"] = "Machine pistol with high fire rate and mobility."
L["wep." .. w .. ".desc.quote"] = "\"Sooner or later, you'll have to jump.\""
L["wep." .. w .. ".trivia.manufacturer"] = "Glock Ges.m.b.H"
L["wep." .. w .. ".credits"] = "Model: Hav0k101 \nTextures: el maestro de graffiti \nSounds: BlitzBoaR, Lorn, Ghost597879, Zeven II \nAnimations Tactical Intervention"

w = ws .. "k98"
L["wep." .. w .. ".name.full"] = "Karabiner 98k"
L["wep." .. w .. ".name"] = "Kar98k"
L["wep." .. w .. ".desc"] = "Antique bolt-action rifle with an enduring design. Powerful up close, but is essentially obsolete on the modern battlefield."
L["wep." .. w .. ".desc.quote"] = "\"Do you want total war?\""
L["wep." .. w .. ".trivia.manufacturer"] = "Mauser"
L["wep." .. w .. ".credits"] = "Model: Day of Defeat: Source, edited by 8Z \nTextures: Cafe Rev., rascal, 5hifty \nSounds: rzen1th \nAnimations Cry of Fear, Lazarus"

w = ws .. "k98_varmint"
L["wep." .. w .. ".name"] = "Varmint Rifle"
L["wep." .. w .. ".desc"] = "Bolt-action rifle based on the Mauser action. Accepts ubiquitous AR-15 magazines. Lightweight, easy to use and has a generous capacity, but damage is low."
L["wep." .. w .. ".desc.quote"] = "For rodents of... unassuming size."
L["wep." .. w .. ".trivia.manufacturer"] = "All-American Firearms"
L["wep." .. w .. ".credits"] = "Model: Day of Defeat: Source, edited by 8Z \nTextures: 5hifty \nSounds: rzen1th \nAnimations: Tactical Intervention"

w = ws .. "m14"
L["wep." .. w .. ".name"] = "M14 SOPMOD"
L["wep." .. w .. ".desc"] = "Modernized short barrel rifle with improved mobility and fast automatic fire but punishing recoil. \nEquipped with a 6x scope by default."
L["wep." .. w .. ".trivia.manufacturer"] = "Troy Industries"
L["wep." .. w .. ".credits"] = "Model: General Tso & Twinke Masta \nTextures: Thanez, Twinke Masta \nSounds: Lakedown, teh strelok & Futon \nAnimations: Tactical Intervention"

w = ws .. "m16a2"
L["wep." .. w .. ".name.full"] = "Colt M16A2"
L["wep." .. w .. ".name"] = "M16A2"
L["wep." .. w .. ".desc"] = "Vintage burst assault rifle with limited optic options. Despite this, its stable recoil and high damage makes it reliable at medium range."
L["wep." .. w .. ".desc.quote"] = "\"Take clean shots, watch your background.\""
L["wep." .. w .. ".trivia.manufacturer"] = "Colt"
L["wep." .. w .. ".credits"] = "Model: Twinke Masta, SureShot, vagrant \nTextures: Stoke, modderfreak \nSounds: Vunsunta, Navaro \nAnimations: Tactical Intervention"

w = ws .. "m500"
L["wep." .. w .. ".name.full"] = "SW Model 500"
L["wep." .. w .. ".name"] = "M500"
L["wep." .. w .. ".desc"] = "Massive long barrel revolver firing a massive magnum round, reigning as the most powerful production handgun in the world."
L["wep." .. w .. ".desc.quote"] = "\"You dweebs just ruined a five year investigation!\""
L["wep." .. w .. ".trivia.manufacturer"] = "Smith & Wesson"
L["wep." .. w .. ".credits"] = "Assets: Alliance of Valiant Arms \nOriginally ported to CS 1.6 by GR_Lucia \nSounds: Ghost597879, MSKyuuni & Zira \nAnimations: Tactical Intervention"

w = ws .. "mx4"
L["wep." .. w .. ".name.full"] = "Beretta MX4 Storm"
L["wep." .. w .. ".name"] = "MX4 Storm"
L["wep." .. w .. ".desc"] = "Bulky pistol carbine with high rate of fire but mediocre armor penetration."
L["wep." .. w .. ".trivia.manufacturer"] = "Pietro Beretta"
L["wep." .. w .. ".credits"] = "Assets: Counter Strike: Online 2 \nAnimations: Tactical Intervention"

w = ws .. "p226"
L["wep." .. w .. ".name.full"] = "SIG P226"
L["wep." .. w .. ".name"] = "P226"
L["wep." .. w .. ".desc"] = "Handgun with superior range and precision but low capacity."
L["wep." .. w .. ".desc.quote"] = "\"The correct term is 'babes,' sir.\""
L["wep." .. w .. ".trivia.manufacturer"] = "SIG Sauer AG"
L["wep." .. w .. ".credits"] = "Model: SoulSlayer \nTextures: Thanez \nSounds: Anders, DMG, FxDarkloki, & Thanez \nAnimations: Tactical Intervention"

w = ws .. "rpk"
L["wep." .. w .. ".name"] = "RPK"
L["wep." .. w .. ".desc"] = "Light machine gun derived from an infantry rifle. High damage and good recoil, but mobility and spread is poor."
L["wep." .. w .. ".trivia.manufacturer"] = "Molot"
L["wep." .. w .. ".credits"] = "Assets: Call To Arms \nAnimations: Tactical Intervention"

w = ws .. "ruger"
L["wep." .. w .. ".name.full"] = "AMC Amphibian Ruger"
L["wep." .. w .. ".name"] = "Amphibian"
L["wep." .. w .. ".desc"] = "Small caliber pistol fitted with an integrated suppressor. Near-zero recoil due to weak rounds."
L["wep." .. w .. ".desc.quote"] = "\"Take comfort in knowing you never had a choice.\""
L["wep." .. w .. ".trivia.manufacturer"] = "Sturm, Ruger & Co."
L["wep." .. w .. ".credits"] = "Model: The Lama \nTextures: The Miller \nAnimations: Tactical Intervention"

w = ws .. "saiga"
L["wep." .. w .. ".name"] = "Saiga-12K"
L["wep." .. w .. ".desc"] = "High capacity shotgun feeding from a box magazine, suitable for spraying down a room."
L["wep." .. w .. ".trivia.manufacturer"] = "Kalashnikov Concern"
L["wep." .. w .. ".credits"] = "Assets: Battlefield 3 \nAnimations: Tactical Intervention"

w = ws .. "scarh"
L["wep." .. w .. ".name.full"] = "FN SCAR-H CQC"
L["wep." .. w .. ".name"] = "SCAR-H"
L["wep." .. w .. ".desc"] = "Compact, high mobility battle rifle with swift handling."
L["wep." .. w .. ".desc.quote"] = "\"Sand Bravo, we're reading 70 bogeys in your sector.\""
L["wep." .. w .. ".trivia.manufacturer"] = "FN America"
L["wep." .. w .. ".credits"] = "Assets: Counter-Strike: Online 2, edited by speedonerd \nAnimations: Tactical Intervention"

w = ws .. "sg550"
L["wep." .. w .. ".name.full"] = "SIG SG 550-1 Sniper"
L["wep." .. w .. ".name"] = "SG 550-1"
L["wep." .. w .. ".desc"] = "Carbine caliber marksman rifle with fast automatic fire. Easy to control in short bursts and has high armor penetration. Equipped with a 6x scope by default."
L["wep." .. w .. ".trivia.manufacturer"] = "SIG Sauer AG"
L["wep." .. w .. ".credits"] = "Model: Hav0c & Twinke Masta \nTextures: Twinke Masta \nSounds: Farion, Treyarch & Tactical Intervention \nAnimations: Tactical Intervention"

w = ws .. "sg550r"
L["wep." .. w .. ".name.full"] = "SIG SG550-2 SP"
L["wep." .. w .. ".name"] = "SG 550-2"
L["wep." .. w .. ".desc"] = "Long barrel rifle converted to semi-automatic for civilian markets. Easy to control and has high armor penetration."
L["wep." .. w .. ".trivia.manufacturer"] = "SIG Sauer AG"
L["wep." .. w .. ".credits"] = "Model: Hav0c & Twinke Masta \nTextures: Twinke Masta \nSounds: Farion, Treyarch & Tactical Intervention \nAnimations: Tactical Intervention"

w = ws .. "sl8"
L["wep." .. w .. ".name.full"] = "HK SL8"
L["wep." .. w .. ".name"] = "SL8"
L["wep." .. w .. ".desc"] = "Semi-automatic variant of the G36 made for precision shooting. Low fire rate, but recoil control is excellent. \nEquipped with a 2x scope but has no ironsight option."
L["wep." .. w .. ".desc.quote"] = "\"Used to be a cop myself, only for one day though.\""
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Model: Hav0c \nTextures: Twinke Masta \nSounds: KingFriday \nAnimations: Tactical Intervention"

w = ws .. "star15"
L["wep." .. w .. ".name.full"] = "Spikes Tactical AR-15"
L["wep." .. w .. ".name"] = "ST AR-15"
L["wep." .. w .. ".desc"] = "Aftermarket AR-15 fine tuned for precision shooting. \nEver the choice for lone wolves on a path of revenge, your fate will be a cacophonous funeral... and a silent farewell. Bring a detonator."
L["wep." .. w .. ".trivia.manufacturer"] = "Spikes Tactical"
L["wep." .. w .. ".credits"] = "Assets: carl ruins everything, Leon-DLL, Mira + various sources \nSounds: Insurgency, rzen1th & Tactical Intervention \nAnimations: Tactical Intervention"

w = ws .. "t850"
L["wep." .. w .. ".name.full"] = "Taurus 850 Ultralite"
L["wep." .. w .. ".name"] = "T850"
L["wep." .. w .. ".desc"] = "Snub-nosed revolver with compact form factor. Lethality falls off sharply past point blank."
L["wep." .. w .. ".desc.quote"] = "Cardio is free when you're chasing gangsters."
L["wep." .. w .. ".trivia.manufacturer"] = "Taurus"
L["wep." .. w .. ".credits"] = "Model: Fearfisch \nTextures: Millenia \nSounds: Vunsunta \nAnimations: Tactical Intervention"

w = ws .. "tec9"
L["wep." .. w .. ".name.full"] = "Intratec TEC-9"
L["wep." .. w .. ".name"] = "TEC-9"
L["wep." .. w .. ".desc"] = "Machine pistol notorious for its ease of conversion to fully automatic fire, and subsequent criminal usage."
L["wep." .. w .. ".desc.quote"] = "\"The customer is always right.\""
L["wep." .. w .. ".trivia.manufacturer"] = "Intratec"
L["wep." .. w .. ".credits"] = "Model/Texture: Payday 2 \nSounds: The_AntiPirate \nAnimations: Tactical Intervention"

w = ws .. "trg42"
L["wep." .. w .. ".name.full"] = "Sako TRG-42"
L["wep." .. w .. ".name"] = "TRG-42"
L["wep." .. w .. ".desc"] = "Magnum sniper rifle with decent handling and mobility. \nPowerful, but slow to cycle and not very stable. \nEquipped with a 12x scope by default."
L["wep." .. w .. ".trivia.manufacturer"] = "SAKO"
L["wep." .. w .. ".credits"] = "Model: Darkstorn \nTextures: SilentAssassin12 \nSounds: Vunsunta \nAnimations: Tactical Intervention"

w = ws .. "usc"
L["wep." .. w .. ".name.full"] = "HK USC"
L["wep." .. w .. ".name"] = "USC"
L["wep." .. w .. ".desc"] = "Semi-automatic carbine variant of the UMP. Uses low capacity magazines, but its long barrel and gripstock assembly provides excellent medium range performance."
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Assets: Twinke Masta, xLongWayHome, Stoke, Teh Snake & Millenia etc. \nAnimations: Tactical Intervention"

w = ws .. "val"
L["wep." .. w .. ".name"] = "AS Val"
L["wep." .. w .. ".desc"] = "Integrally-suppressed rifle with high damage output and precision, but performs poorly over long bursts."
L["wep." .. w .. ".trivia.manufacturer"] = "Tula Arms Plant"
L["wep." .. w .. ".credits"] = "Model & Textures: S.T.A.L.K.E.R. \nSounds: S.T.A.L.K.E.R. & Vunsunta \nAnimations: Tactical Intervention"

w = ws .. "vp70"
L["wep." .. w .. ".name.full"] = "HK VP70"
L["wep." .. w .. ".name"] = "VP70"
L["wep." .. w .. ".desc"] = "Polymer pistol with an innovative holster stock that allows for incredibly fast burst fire."
L["wep." .. w .. ".desc.quote"] = "\"Where's everyone going? Bingo?\""
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Model & Textures: KnechtRuprecht \nSounds: Strelok & xLongWayHome \nAnimations: Tactical Intervention, edited by speedonerd"

w = ws .. "vss"
L["wep." .. w .. ".name.full"] = "VSS Vintorez"
L["wep." .. w .. ".name"] = "Vintorez"
L["wep." .. w .. ".desc"] = "Integrally-suppressed marksman rifle with high fire rate and low recoil, but performs poorly over long bursts. \nEquipped with a 6x scope by default."
L["wep." .. w .. ".trivia.manufacturer"] = "Tula Arms Plant"
L["wep." .. w .. ".credits"] = "Model: Ettubrutesbro, Millenia & Twinke Masta \nTextures: Millenia \nSounds: S.T.A.L.K.E.R. & Vunsunta \nAnimations: Tactical Intervention"

w = ws .. "xm8car"
L["wep." .. w .. ".name.full"] = "HK XM8 Compact"
L["wep." .. w .. ".name"] = "XM8 Compact"
L["wep." .. w .. ".desc"] = "Experimental multi-purpose carbine. Easy to use, but low damage. \nHas an adjustable integrated 2-8x scope."
L["wep." .. w .. ".desc.quote"] = "\"Who loves spaghetti?!\""
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Model: End Of Days \nTextures: Copkiller, Twinke Masta & Wangchung \nAnimations: Tactical Intervention"

w = ws .. "xm8lmg"
L["wep." .. w .. ".name.full"] = "HK XM8 LMG"
L["wep." .. w .. ".name"] = "XM8 LMG"
L["wep." .. w .. ".desc"] = "Experimental multi-purpose carbine in MG configuration. Light, high capacity and low recoil, but damage is poor. \nHas an adjustable integrated 2-8x scope."
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Model: End Of Days \nTextures: Copkiller, Twinke Masta & Wangchung \nAnimations: Tactical Intervention"

-- Attachments (interops)
L["att.ammo_star15_300blk.name.full"] = "ST AR-15 .300 AC Blackout Mod Kit"
L["att.ammo_star15_300blk.name"] = ".300 BLK"
L["att.ammo_star15_300blk.desc"] = "Modification to load lower velocity bullets with better CQB potential."

L["att.ammo_star15_50beo.name.full"] = "ST AR-15 .50 Beowulf Blackout Mod Kit"
L["att.ammo_star15_50beo.name"] = ".50 BEO"
L["att.ammo_star15_50beo.desc"] = "Modification to load low capacity, high power magnum rounds."

L["att.bolt_af2011_alt.name.full"] = "AF2011-A1 Alternating Bolt"
L["att.bolt_af2011_alt.name"] = "Alternating"
L["att.bolt_af2011_alt.desc"] = "Malicious interpretation of the concept of \"double-stacked magazines\"."

L["att.muzz_comp_io_m14.desc"] = "att.muzz_pistol_comp.desc"

L["att.muzz_tec9_shroud.name.full"] = "TEC-9 Barrel Shroud"
L["att.muzz_tec9_shroud.name"] = "Shroud"
L["att.muzz_tec9_shroud.desc"] = "Barrel extension improving performance at range."

L["att.optic_ak_pso1.name.full"] = "PSO-1 Scope"
L["att.optic_ak_pso1.name"] = "PSO-1"
L["att.optic_ak_pso1.desc"] = "Russian dovetail scope with medium-long range magnification."

L["att.optic_ar_colt.name.full"] = "Colt 3x20 Scope"
L["att.optic_ar_colt.name"] = "Colt 3x20"
L["att.optic_ar_colt.desc"] = "Low power optical scope mounted on AR pattern carry handles."

L["att.optic_k98_zf41.name.full"] = "Zeiss 6x38 Scope"
L["att.optic_k98_zf41.name"] = "Zeiss"
L["att.optic_k98_zf41.desc"] = "Malicious interpretation of the concept of \"double-stacked magazines\"."

L["att.optic_xm8_4x.name.full"] = "XM8 Integrated Scope (4x)"
L["att.optic_xm8_4x.name"] = "4x"
L["att.optic_xm8_4x.desc"] = "Medium range zoom setting with ACOG reticle."

L["att.optic_xm8_6x.name.full"] = "XM8 Integrated Scope (6x)"
L["att.optic_xm8_6x.name"] = "6x"
L["att.optic_xm8_6x.desc"] = "Medium-long range zoom setting with Short Dot reticle."

L["att.optic_xm8_8x.name.full"] = "XM8 Integrated Scope (8x)"
L["att.optic_xm8_8x.name"] = "8x"
L["att.optic_xm8_8x.desc"] = "Long range zoom setting with sniper reticle."

L["att.trigger_vp70_auto.name.full"] = "Automatic"
L["att.trigger_vp70_auto.name"] = "VP-70 Auto Sear Stock"
L["att.trigger_vp70_auto.desc"] = "The engineers at H&K are frothing at their mouths as we speak."

L["att.trigger_vp70_semi.name.full"] = "VP-70 Remove Stock"
L["att.trigger_vp70_semi.name"] = "Stockless"
L["att.trigger_vp70_semi.desc"] = "Removes burst fire capability, improving handling and mobility."

///////////////////// -- [[ ArmaLite Revolution ]] --
-- Weapons
ws = "tacrp_ar_"
w = ws .. "ar15pistol"
L["wep." .. w .. ".name"] = "AR-15 Compact"
L["wep." .. w .. ".desc"] = "Stockless, extremely short barrel AR-15 configuration. \nLegally a pistol and light enough to function as a sidearm, but it is unstable and imprecise without the form factor of a rifle."
L["wep." .. w .. ".trivia.manufacturer"] = "Ultra-Tac"
L["wep." .. w .. ".credits"] = "Model/Textures: Mateusz Woliński, Jordan Whincup \nMagazine: Twinke Masta \nSounds: Teh Strelok, Vunsunta, xLongWayHome, CS:O2 \nAnimations: Tactical Intervention"

w = ws .. "gilboa"
L["wep." .. w .. ".name.full"] = "Gilboa DBR Snake"
L["wep." .. w .. ".name"] = "Gilboa DBR"
L["wep." .. w .. ".desc"] = "Unique double-barrel AR carbine. Twice the lethality as one barrel, but the design is bulky and inaccurate. \nCannot accept muzzle attachments for obvious reasons."
L["wep." .. w .. ".trivia.manufacturer"] = "Silver Shadow"
L["wep." .. w .. ".credits"] = "Assets: Counter Strike: Online 2 \nAnimations: Tactical Intervention"

w = ws .. "hk416"
L["wep." .. w .. ".name.full"] = "HK HK416"
L["wep." .. w .. ".name"] = "HK416"
L["wep." .. w .. ".desc"] = "Sleek black rifle made as a competitior to the AR-15. Accurate and low recoil at the cost of some bulk."
L["wep." .. w .. ".desc.quote"] = "An elite gun like this is all you need."
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Model: Twinke Masta, B0T, SoulSlayer \nTextures: Acid Snake, el maestro de graffiti, Antman \nSounds: Vunsunta, xLongWayHome \nAnimations: Tactical Intervention"

w = ws .. "lr300"
L["wep." .. w .. ".name.full"] = "Z-M LR-300"
L["wep." .. w .. ".name"] = "LR-300"
L["wep." .. w .. ".desc"] = "AR-derived \"Light Rifle\" with a modified gas system. Offers high fire rate and range, but stability is subpar. \nThe \"300\" denotes the rifle's maximum effective range in meters."
L["wep." .. w .. ".trivia.manufacturer"] = "Z-M Weapons"
L["wep." .. w .. ".credits"] = "Model: TheLama \nTextures: Wannabe \nSounds: NightmareMutant \nAnimations: Tactical Intervention"

w = ws .. "m16a1"
L["wep." .. w .. ".name.full"] = "Colt M16A1"
L["wep." .. w .. ".name"] = "M16A1"
L["wep." .. w .. ".desc"] = "An antique rifle recovered from the rice fields. \nBoasts high firing rate and good range, though don't expect this bucket of rust to run without a hitch or two."
L["wep." .. w .. ".desc.quote"] = "Welcome to the jungle."
L["wep." .. w .. ".trivia.manufacturer"] = "Colt"
L["wep." .. w .. ".credits"] = "Model: Hav0c \nTextures: Millenia \nCompile: The_AntiPirate \nAnimations: Tactical Intervention"

w = ws .. "m16a4"
L["wep." .. w .. ".name.full"] = "Colt M16A4"
L["wep." .. w .. ".name"] = "M16A4"
L["wep." .. w .. ".desc"] = "Modern infantry rifle with modern afforances like a top rail and RIS handguard. A well-rounded infantry weapon with good effective range."
L["wep." .. w .. ".trivia.manufacturer"] = "Colt"
L["wep." .. w .. ".credits"] = "Model: Twinke Masta, SureShot, vagrant \nTextures: Stoke, modderfreak \nSounds: Vunsunta, Navaro \nAnimations: Tactical Intervention"

w = ws .. "sr25"
L["wep." .. w .. ".name.full"] = "KAC SR-25 EMR"
L["wep." .. w .. ".name"] = "SR-25"
L["wep." .. w .. ".desc"] = "\"Enhanced Match Rifle\" made for precision shooting. \nLow capacity, but otherwise has excellent performance. \nEquipped with a 10x scope by default."
L["wep." .. w .. ".trivia.manufacturer"] = "Knight's Armament"
L["wep." .. w .. ".credits"] = "Assets: Firearms: Source \nAnimations: Tactical Intervention"

w = ws .. "vltor"
L["wep." .. w .. ".name"] = "VLTOR SBR"
L["wep." .. w .. ".desc"] = "AR pattern carbine with a unique piggyback-style handguard. Excels at close range without giving up mid-range performance."
L["wep." .. w .. ".desc.quote"] = "\"Hustle up! Get to Whiskey Hotel!\""
L["wep." .. w .. ".trivia.manufacturer"] = "VLTOR"
L["wep." .. w .. ".credits"] = "Model/Textures: Kimono \nSounds: Teh Strelok \nAnimations: Tactical Intervention"

-- Attachments (ar)
L["att.bolt_gilboa_alt.name.full"] = "Gilboa DBR Alternating Bolt"
L["att.bolt_gilboa_alt.name"] = "Alternating"
L["att.bolt_gilboa_alt.desc"] = "Separated bolts that are able to fire alternatingly, somehow."

L["att.muzz_sr25.name.full"] = "SR-25 Suppressor Shroud"
L["att.muzz_sr25.name"] = "SR-25 Supp."
L["att.muzz_sr25.desc"] = "Unique suppressor shroud that improves ballistics but lowers fire rate."

///////////////////// -- [[ Special Delivery ]] --
-- Weapons
ws = "tacrp_sd_"
w = ws .. "1022"
L["wep." .. w .. ".name.full"] = "Ruger 10/22"
L["wep." .. w .. ".name"] = "10/22"
L["wep." .. w .. ".desc"] = "Ultra-lightweight plinking rifle. Highly accurate and easy to handle, but is barely lethal unless scoring a headshot."
L["wep." .. w .. ".trivia.manufacturer"] = "Sturm, Ruger & Co."
L["wep." .. w .. ".credits"] = "Assets: No More Room in Hell \nAnimations: Tactical Intervention"

w = ws .. "1858"
L["wep." .. w .. ".name.full"] = "Remington 1858 Army"
L["wep." .. w .. ".name"] = "Army"
L["wep." .. w .. ".desc"] = "Antique percussion revolver packing a punch up close, but is terribly slow to shoot. Suitable for cowboy roleplay."
L["wep." .. w .. ".desc.quote"] = "\"Pass the whiskey!\""
L["wep." .. w .. ".trivia.manufacturer"] = "Remington Arms"
L["wep." .. w .. ".credits"] = "Assets: Nimrod Hempel (Fistful of Frags) \nAnimations: CyloWalker \nQuickthrow & melee animations: speedonerd"

w = ws .. "aac_hb"
L["wep." .. w .. ".name.full"] = "AAC Honey Badger"
L["wep." .. w .. ".name"] = "Honey Badger"
L["wep." .. w .. ".desc"] = "A lightweight assault rifle with an integral suppressor. Powerful in close quarters and has no visible tracer, but has poor performance at range."
L["wep." .. w .. ".trivia.manufacturer"] = "AAC"
L["wep." .. w .. ".credits"] = "Model: Hyper \nAnimations: Tactical Intervention"

w = ws .. "bizon"
L["wep." .. w .. ".name.full"] = "PP-19 Bizon"
L["wep." .. w .. ".name"] = "Bizon"
L["wep." .. w .. ".desc"] = "AK-derrivative SMG with a high-capacity helical magazine.  Pretty weak but easy to control and handle."
L["wep." .. w .. ".trivia.manufacturer"] = "Izhmash"
L["wep." .. w .. ".credits"] = "Model: Twinke Masta \nTextures: Milo \nSounds: Vunsunta \nAnimations: Tactical Intervention, edited by speedonerd"

w = ws .. "contender"
L["wep." .. w .. ".name.full"] = "T/C G2 Contender"
L["wep." .. w .. ".name"] = "Contender"
L["wep." .. w .. ".desc"] = "Single-shot hunting pistol. Accurate, compact and lethal, so you better make that one round count. \nEquipped with a 6x scope by default."
L["wep." .. w .. ".desc.quote"] = "\"You know what I hate? Two groups of people...\""
L["wep." .. w .. ".trivia.manufacturer"] = "Thompson/Center"
L["wep." .. w .. ".credits"] = "Model: kriboez, Doktor haus \nTextures: cR45h, syncing, tenoyl, Ultimately \nSounds: Doktor haus \nAnimations: 8Z, speedonerd"

w = ws .. "db"
L["wep." .. w .. ".name.full"] = "Stoeger Double Defense"
L["wep." .. w .. ".name"] = "Double Defense"
L["wep." .. w .. ".desc"] = "Modern-production short double-barrel shotgun.  Easy to handle, reliable and deadly in close quarters."
L["wep." .. w .. ".desc.quote"] = "\"The only thing they fear, is you.\""
L["wep." .. w .. ".trivia.manufacturer"] = "Stoeger"
L["wep." .. w .. ".credits"] = "Model: Counter-Strike: Online 2 \nSounds: Navaro & Vunsunta \nAnimations: speedonerd & 8Z"

w = ws .. "delisle"
L["wep." .. w .. ".name.full"] = "De Lisle Carbine"
L["wep." .. w .. ".name"] = "De Lisle"
L["wep." .. w .. ".desc"] = "Pistol caliber bolt-action carbine with an integrated suppressor. One of the quietest firearms ever made, its subsonic rounds have no tracer but travel slowly."
L["wep." .. w .. ".desc.quote"] = "Fired into the River Thames, not a soul heard it."
L["wep." .. w .. ".trivia.manufacturer"] = "Sterling Armaments"
L["wep." .. w .. ".credits"] = "Model: RedRougeXIII \nTextures: Storm (lovingly fixed by Unselles) \nAnimations: Tactical Intervention"

w = ws .. "dual_1911"
L["wep." .. w .. ".name"] = "Dueling Wyverns"
L["wep." .. w .. ".desc"] = "A pair of gaudy, custom made golden M1911 pistols complete with wyvern-engraved grip. Hits hard, but its low capacity can be hurting."
L["wep." .. w .. ".trivia.manufacturer"] = "Springfield Armory"
L["wep." .. w .. ".credits"] = "Model: Schmung \nTextures: Millenia \nAnimations: Tactical Intervention"

w = ws .. "dual_degala"
L["wep." .. w .. ".name"] = "Dual Eagles"
L["wep." .. w .. ".desc"] = "Pair of gaudy gold-coated Desert Eagles, as if one wasn't enough. \nTwice the insane firepower, twice the insane recoil."
L["wep." .. w .. ".desc.quote"] = "\"My blood...on their hands.\""
L["wep." .. w .. ".trivia.manufacturer"] = "Magnum Research"
L["wep." .. w .. ".credits"] = "Model: Hav0c & Stoke \nTextures: The_Tub & Stoke \nSounds: Vunsunta \nAnimations: Tactical Intervention"

w = ws .. "dual_ppk"
L["wep." .. w .. ".name"] = "Dual Agents"
L["wep." .. w .. ".desc"] = "A pair of suppressed PPK pistols. Swift and accurate, but the low capacity and mediocre damage demands a sharp eye and trigger discpline."
L["wep." .. w .. ".desc.quote"] = "You better not be picking Oddjob."
L["wep." .. w .. ".trivia.manufacturer"] = "Walther"
L["wep." .. w .. ".credits"] = "Model & Textures: Kimono \nSounds: HK & Vunsunta \nAnimations: Tactical Intervention, edited by speedonerd"

w = ws .. "dual_usp"
L["wep." .. w .. ".name"] = "Dual Matches"
L["wep." .. w .. ".desc"] = "Pair of pistols pilfered from a pair of dead metrocops. Decent damage and capacity but hefty and slow to fire."
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Model: Silvio Dante & Twinke Masta \nTextures: LoneWolf \nAnimations: Tactical Intervention"

w = ws .. "dual_uzis"
L["wep." .. w .. ".name"] = "Dual Uzis"
L["wep." .. w .. ".desc"] = "Pair of full-auto Micro Uzis. I don't know how you expect to hit anything with this getup, but you do you I guess."
L["wep." .. w .. ".desc.quote"] = "\"I'll hit you with so many rights you'll be begging for a left!\""
L["wep." .. w .. ".trivia.manufacturer"] = "Israel Military Industries"
L["wep." .. w .. ".credits"] = "Model: BrainBread 2 \nAnimations: Tactical Intervention, edited by speedonerd"

w = ws .. "dualies"
L["wep." .. w .. ".name"] = "Dueling Dragons"
L["wep." .. w .. ".desc"] = "Pair of customized pistols with a two-tone finish and dragons emblazoned on the grips.  Swift handling and decent recoil control but low stopping power."
L["wep." .. w .. ".desc.quote"] = "\"I released my finger from the trigger, and it was over.\""
L["wep." .. w .. ".trivia.manufacturer"] = "Pietro Beretta"
L["wep." .. w .. ".credits"] = "Model: Spydr \nTextures: NCFurious \nAnimations: Tactical Intervention"

w = ws .. "famas"
L["wep." .. w .. ".name"] = "FAMAS F1"
L["wep." .. w .. ".desc"] = "Burst-fire bullpup used by the French Army. High rate of fire and great accuracy is limited only by its substandard magazine capacity and pretty intense recoil. \nHas a bipod for esoteric French reasons."
L["wep." .. w .. ".trivia.manufacturer"] = "GIAT Industries"
L["wep." .. w .. ".credits"] = "Model: SnipaMasta \nTextures: SnipaMasta, Fnuxray \nAnimations: speedonerd"

w = ws .. "famas_g2"
L["wep." .. w .. ".name"] = "FAMAS G2"
L["wep." .. w .. ".desc"] = "Bullpup rifle with a blazing fast firerate, used by the French Navy. While capable of automatic fire, using burst-fire or the built-in bipod is recommended."
L["wep." .. w .. ".desc.quote"] = "\"God's got a sense of humor, alright.\""
L["wep." .. w .. ".trivia.manufacturer"] = "GIAT Industries"
L["wep." .. w .. ".credits"] = "Model: SnipaMasta \nTextures: SnipaMasta, Fnuxray \nAnimations: speedonerd"

w = ws .. "g3"
L["wep." .. w .. ".name.full"] = "HK G3A3"
L["wep." .. w .. ".name"] = "G3A3"
L["wep." .. w .. ".desc"] = "Precise heavy battle rifle with a somewhat managable automatic firemode but slow handling."
L["wep." .. w .. ".trivia.manufacturer"] = "Heckler & Koch"
L["wep." .. w .. ".credits"] = "Assets: Firearms: Source \nSounds: Nightmare Mutant & FA:S2 \nAnimations: Tactical Intervention"

w = ws .. "groza"
L["wep." .. w .. ".name.full"] = "OTs-14 \"Groza\""
L["wep." .. w .. ".name"] = "Groza-4"
L["wep." .. w .. ".desc"] = "Integrally-suppressed bullpup made from a reconfigured AK. Weak, but has great handling and stability and has no visible tracers."
L["wep." .. w .. ".desc.quote"] = "\"Get out of here, Stalker.\""
L["wep." .. w .. ".trivia.manufacturer"] = "TsKIB SOO"
L["wep." .. w .. ".credits"] = "Model: Teh Snake, edited by speedonerd \nTextures: Teh Snake \nSounds: Teh Snake & speedonerd \nAnimations: speedonerd"

w = ws .. "gyrojet"
L["wep." .. w .. ".name.full"] = "MBA Gyrojet"
L["wep." .. w .. ".name"] = "Gyrojet"
L["wep." .. w .. ".desc"] = "Experimental weapon firing self-propelled mini-rockets. While they are powerful, the rounds are prone to failure."
L["wep." .. w .. ".desc.quote"] = "\"I wonder how much his remains would go for on Ebay.\""
L["wep." .. w .. ".trivia.manufacturer"] = "MBAssociates"
L["wep." .. w .. ".credits"] = "Model & Textures: RedRougeXIII \nSounds: speedonerd, Tactical Intervention \nAnimations: speedonerd"

w = ws .. "m1carbine"
L["wep." .. w .. ".name"] = "M1 Carbine"
L["wep." .. w .. ".desc"] = "WW2-era semi-auto carbine. Intended as a defensive weapon for support troops, it is accurate and lightweight but has mediocre power."
L["wep." .. w .. ".desc.quote"] = "\"Flash.\" \"Thunder.\""
L["wep." .. w .. ".trivia.manufacturer"] = "General Motors"
L["wep." .. w .. ".credits"] = "Model & Textures: KnechtRuprecht \nSounds: NightmareMutant \nAnimations: Tactical Intervention"

w = ws .. "mp40"
L["wep." .. w .. ".name.full"] = "Steyr MP40"
L["wep." .. w .. ".name"] = "MP40"
L["wep." .. w .. ".desc"] = "WW2-era SMG with a low rate of fire and light recoil. Despite its age, it still shows up in many warzones today."
L["wep." .. w .. ".desc.quote"] = "\"Hans, your coffee sucks. I'm not drinking that crap.\""
L["wep." .. w .. ".trivia.manufacturer"] = "Steyr-Mannlicher"
L["wep." .. w .. ".credits"] = "Model: Soul-Slayer \nTextures: Kimono \nSounds: Futon & Vunsunta \nAnimations: Tactical Intervention, edited by speedonerd"

w = ws .. "pkm"
L["wep." .. w .. ".name"] = "PKM"
L["wep." .. w .. ".desc"] = "General-purpose machine gun capable of intense suppressive fire. High capacity and damage but is very, very bulky."
L["wep." .. w .. ".trivia.manufacturer"] = "Degtyaryov Plant"
L["wep." .. w .. ".credits"] = "Assets: Call to Arms \nSounds: NightmareMutant & speedonerd \nAnimations: Tactical Intervention"

w = ws .. "ppk"
L["wep." .. w .. ".name.full"] = "Walther PPK"
L["wep." .. w .. ".name"] = "PPK"
L["wep." .. w .. ".desc"] = "Compact, low-capacity pocket pistol made famous by the movies. Best suited for close range self defense."
L["wep." .. w .. ".desc.quote"] = "\"Shocking. Positively shocking.\""
L["wep." .. w .. ".trivia.manufacturer"] = "Walther"
L["wep." .. w .. ".credits"] = "Model & Textures: Kimono \nSounds: HK & Vunsunta \nAnimations: Tactical Intervention, edited by speedonerd"

w = ws .. "superx3"
L["wep." .. w .. ".name.full"] = "Winchester Super X3"
L["wep." .. w .. ".name"] = "Super X3"
L["wep." .. w .. ".desc"] = "Civilian sporting shotgun engineered for performance. Long barrel and competition choke offer great accuracy and range but poor handling."
L["wep." .. w .. ".trivia.manufacturer"] = "Winchester Repeating Arms"
L["wep." .. w .. ".credits"] = "Model, Textures & Sound: No More Room in Hell \nAnimations: Tactical Intervention"

w = ws .. "thompson"
L["wep." .. w .. ".name.full"] = "M1A1 Thompson"
L["wep." .. w .. ".name"] = "Thompson"
L["wep." .. w .. ".desc"] = "WW2-era SMG with sturdy wooden furniture. Boasts impressive close-range firepower, but is rather heavy."
L["wep." .. w .. ".desc.quote"] = "\"Eat lead, jerries!\""
L["wep." .. w .. ".trivia.manufacturer"] = "Auto-Ordnance Company"
L["wep." .. w .. ".credits"] = "Assets: Counter-Strike: Online 2 \nAnimations: Tactical Intervention"

w = ws .. "tt33"
L["wep." .. w .. ".name.full"] = "Tokarev TT-33"
L["wep." .. w .. ".name"] = "TT-33"
L["wep." .. w .. ".desc"] = "Antique pistol from beyond the Iron Curtain. High range and penetration, but has reliability issues due to its age."
L["wep." .. w .. ".desc.quote"] = "\"Perhaps you would prefer to avoid the red tape?\""
L["wep." .. w .. ".trivia.manufacturer"] = "Tula Arms Plant"
L["wep." .. w .. ".credits"] = "Model: Mr.Rifleman \nTextures: BuLL5H1T & Mr.Rifleman \nSounds: NightmareMutant \nAnimations: Tactical Intervention"

w = ws .. "vz58"
L["wep." .. w .. ".name.full"] = "Sa vz. 58"
L["wep." .. w .. ".name"] = "vz. 58"
L["wep." .. w .. ".desc"] = "High-damage assault rifle with excellent armor piercing capabilities, converted to semi auto for civilian markets."
L["wep." .. w .. ".desc.quote"] = "Despite its looks, it is definitely not an AK."
L["wep." .. w .. ".trivia.manufacturer"] = "CZ Uherský Brod"
L["wep." .. w .. ".credits"] = "Model, Textures & Sounds: No More Room in Hell \nAnimations: Tactical Intervention"

w = ws .. "wa2000"
L["wep." .. w .. ".name.full"] = "Walther WA 2000"
L["wep." .. w .. ".name"] = "WA 2000"
L["wep." .. w .. ".desc"] = "Elegant bullpup sniper rifle with high damage and high rate of fire. \nEquipped with a 12x scope by default."
L["wep." .. w .. ".desc.quote"] = "\"Names are for friends, so I don't need one.\""
L["wep." .. w .. ".trivia.manufacturer"] = "Walther"
L["wep." .. w .. ".credits"] = "Assets: Alliance of Valiant Arms \nOriginally ported to CS 1.6 by GR_Lucia \nSounds: HK & Vunsunta \nAnimations: Tactical Intervention, edited by speedonerd"

-- Attachments (sd)
L["att.bolt_gilboa_alt.name.full"] = "Gilboa DBR Alternating Bolt"
L["att.bolt_gilboa_alt.name"] = "Alternating"
L["att.bolt_gilboa_alt.desc"] = "Separated bolts that are able to fire alternatingly, somehow."

L["att.trigger_dual_uzis_semi.name.full"] = "att.trigger_semi.name.full"
L["att.trigger_dual_uzis_semi.name"] = "att.trigger_semi.name"
L["att.trigger_dual_uzis_semi.desc"] = "att.trigger_semi.desc"

L["att.tac_1858_spin.name.full"] = "Revolver Spin"
L["att.tac_1858_spin.name"] = "Spin"
L["att.tac_1858_spin.desc"] = "wheeeeeeeeeeeee"

L["att.optic_m1_scope.name.full"] = "M1 Carbine 3.5x24 Scope"
L["att.optic_m1_scope.name"] = "3.5x Scope"
L["att.optic_m1_scope.desc"] = "Optical scope with specialized mount for the M1 Carbine."

L["att.tac_1858_spin.name.full"] = "De Lisle 4x24 Scope"
L["att.tac_1858_spin.name"] = "4x Scope"
L["att.tac_1858_spin.desc"] = "Optical scope with specialized mount for the De Lisle."

L["att.muzz_supp_assassin.name.full"] = "Assassin Suppressor"
L["att.muzz_supp_assassin.name"] = "A. Suppressor"
L["att.muzz_supp_assassin.desc"] = "Extended suppressor improving range significantly at cost of stability."

L["att.ammo_gyrojet_ratshot.name.full"] = "13mm Ratshot Mini-Rockets"
L["att.ammo_gyrojet_ratshot.name"] = "Ratshot"
L["att.ammo_gyrojet_ratshot.desc"] = "Proximity fuse fragmentation mini-rockets. For rodents of unexpected size."

L["att.ammo_gyrojet_pipe.name.full"] = "15mm Boosted Pipe Grenades"
L["att.ammo_gyrojet_pipe.name"] = "Pipe"
L["att.ammo_gyrojet_pipe.desc"] = "Heavy grenades with timed fuse. Direct hits detonate instantly."

L["att.ammo_gyrojet_lv.name.full"] = "11mm Low Velocity Mini-Rockets"
L["att.ammo_gyrojet_lv.name"] = "LV"
L["att.ammo_gyrojet_lv.desc"] = "Projectiles with reduced diameter and velocity, leaving a less visible trail."

L["att.ammo_gyrojet_he.name.full"] = "13mm High-Explosive Mini-Rockets"
L["att.ammo_gyrojet_he.name"] = "HE"
L["att.ammo_gyrojet_he.desc"] = "Projectile with a small explosive charge instead of a bullet head."

L["att.ammo_1858_45colt.name.full"] = "Remington 1858 .45 Colt Conversion"
L["att.ammo_1858_45colt.name"] = ".45 Colt"
L["att.ammo_1858_45colt.desc"] = "Cartridge conversion firing larger, more powerful, but less reliable rounds."

L["att.ammo_1858_36perc.name.full"] = "Remington 1858 .36 Caliber Conversion"
L["att.ammo_1858_36perc.name"] = ".36 Percussion"
L["att.ammo_1858_36perc.desc"] = "Caliber conversion firing smaller rounds with better range."

///////////////////// -- [[ Brute Force ]] --
-- Weapons
ws = "tacrp_io_"
w = ws .. "REPLACEME"
L["wep." .. w .. ".name.full"] = "REPLACEME"
L["wep." .. w .. ".name"] = "REPLACEME"
L["wep." .. w .. ".desc"] = "REPLACEME"
L["wep." .. w .. ".desc.quote"] = "REPLACEME"
L["wep." .. w .. ".trivia.manufacturer"] = "REPLACEME"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

///////////////////// -- [[ Iron Curtain ]] --
-- Weapons
ws = "tacrp_io_"
w = ws .. "REPLACEME"
L["wep." .. w .. ".name.full"] = "REPLACEME"
L["wep." .. w .. ".name"] = "REPLACEME"
L["wep." .. w .. ".desc"] = "REPLACEME"
L["wep." .. w .. ".desc.quote"] = "REPLACEME"
L["wep." .. w .. ".trivia.manufacturer"] = "REPLACEME"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

///////////////////// -- [[ Heavy Duty ]] --
-- Weapons
ws = "tacrp_io_"
w = ws .. "REPLACEME"
L["wep." .. w .. ".name.full"] = "REPLACEME"
L["wep." .. w .. ".name"] = "REPLACEME"
L["wep." .. w .. ".desc"] = "REPLACEME"
L["wep." .. w .. ".desc.quote"] = "REPLACEME"
L["wep." .. w .. ".trivia.manufacturer"] = "REPLACEME"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

///////////////////// -- [[ ExoOps ]] --
-- Weapons
ws = "tacrp_io_"
w = ws .. "REPLACEME"
L["wep." .. w .. ".name.full"] = "REPLACEME"
L["wep." .. w .. ".name"] = "REPLACEME"
L["wep." .. w .. ".desc"] = "REPLACEME"
L["wep." .. w .. ".desc.quote"] = "REPLACEME"
L["wep." .. w .. ".trivia.manufacturer"] = "REPLACEME"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

///////////////////// -- [[ Scavenger's Spoils ]] --
-- Weapons
ws = "tacrp_io_"
w = ws .. "REPLACEME"
L["wep." .. w .. ".name.full"] = "REPLACEME"
L["wep." .. w .. ".name"] = "REPLACEME"
L["wep." .. w .. ".desc"] = "REPLACEME"
L["wep." .. w .. ".desc.quote"] = "REPLACEME"
L["wep." .. w .. ".trivia.manufacturer"] = "REPLACEME"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

///////////////////// -- [[ Danger Zone Entities ]] --
-- Weapons
ws = "tacrp_io_"
w = ws .. "REPLACEME"
L["wep." .. w .. ".name.full"] = "REPLACEME"
L["wep." .. w .. ".name"] = "REPLACEME"
L["wep." .. w .. ".desc"] = "REPLACEME"
L["wep." .. w .. ".desc.quote"] = "REPLACEME"
L["wep." .. w .. ".trivia.manufacturer"] = "REPLACEME"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"

///////////////////// -- [[ One-Offs ]] --
-- Weapons
ws = "tacrp_io_"
w = ws .. "REPLACEME"
L["wep." .. w .. ".name.full"] = "REPLACEME"
L["wep." .. w .. ".name"] = "REPLACEME"
L["wep." .. w .. ".desc"] = "REPLACEME"
L["wep." .. w .. ".desc.quote"] = "REPLACEME"
L["wep." .. w .. ".trivia.manufacturer"] = "REPLACEME"
L["wep." .. w .. ".credits"] = "Assets: Tactical Intervention"