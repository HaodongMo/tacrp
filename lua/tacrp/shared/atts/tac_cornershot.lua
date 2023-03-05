ATT.PrintName = "Corner-Cam"
ATT.Icon = Material("entities/tacrp_att_tac_cornershot.png", "mips smooth")
ATT.Description = "Device allowing you to blind-fire around corners."
ATT.Pros = {"Corner vision"}

ATT.Model = "models/weapons/tacint/addons/cornershot_mounted.mdl"
ATT.Scale = 1

ATT.Category = "tactical"

ATT.BlindFireCamera = true

function ATT.TacticalDraw(self)
    self:DoCornershot()
end