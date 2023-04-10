function SWEP:OnRestore()
end

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
    return 1 -- Hey hey hey, don't forget about me!!!
end

function SWEP:IsEquipment()
    return WEPS.IsEquipment(self)
end

SWEP.IsSilent = false

-- The OnDrop() hook is useless for this as it happens AFTER the drop. OwnerChange
-- does not occur when a drop happens for some reason. Hence this thing.
function SWEP:PreDrop()
    if SERVER and IsValid(self:GetOwner()) and self.Primary.Ammo != "none" and self.Primary.Ammo != "" then
        local ammo = self:Ammo1()

        -- Do not drop ammo if we have another gun that uses this type
        for _, w in ipairs(self:GetOwner():GetWeapons()) do
            if IsValid(w) and w != self and w:GetPrimaryAmmoType() == self:GetPrimaryAmmoType() then
            ammo = 0
            end
        end

        self.StoredAmmo = ammo

        if ammo > 0 then
            self:GetOwner():RemoveAmmo(ammo, self.Primary.Ammo)
        end
    end
end

function SWEP:DampenDrop()
    -- For some reason gmod drops guns on death at a speed of 400 units, which
    -- catapults them away from the body. Here we want people to actually be able
    -- to find a given corpse's weapon, so we override the velocity here and call
    -- this when dropping guns on death.
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:SetVelocityInstantaneous(Vector(0,0,-75) + phys:GetVelocity() * 0.001)
        phys:AddAngleVelocity(phys:GetAngleVelocity() * -0.99)
    end
end

SWEP.StoredAmmo = 0

-- Picked up by player. Transfer of stored ammo and such.
function SWEP:Equip(newowner)
    if SERVER then
        if self:IsOnFire() then
            self:Extinguish()
        end

        self.fingerprints = self.fingerprints or {}

        if !table.HasValue(self.fingerprints, newowner) then
            table.insert(self.fingerprints, newowner)
        end
    end

    if SERVER and IsValid(newowner) and self.Primary.ClipMax and self.StoredAmmo > 0 and self.Primary.Ammo != "none" and self.Primary.Ammo != "" then
        local ammo = newowner:GetAmmoCount(self.Primary.Ammo)
        local given = math.min(self.StoredAmmo, self.Primary.ClipMax - ammo)

        newowner:GiveAmmo(given, self.Primary.Ammo)
        self.StoredAmmo = 0
    end
end

function SWEP:WasBought(buyer)
end

function SWEP:TTT_PostAttachments()
end

function SWEP:TTT_Init()
    if engine.ActiveGamemode() != "terrortown" then return end

    if SERVER then
        self.fingerprints = {}
    end

    -- if SERVER and GetConVar("arccw_ttt_atts"):GetBool() then
    --     self:NPC_SetupAttachments()
    -- end

    if self.PrimaryGrenade then return end

    self.Primary.ClipMax = TacRP.TTTAmmoToClipMax[self.Ammo] or self.Primary.ClipSize * 2
    self:SetClip1(self.Primary.ClipSize)
    self.GaveDefaultAmmo = true
end

--- TTT2 uses this to populate custom convars in the equip menu
function SWEP:AddToSettingsMenu(parent)
end