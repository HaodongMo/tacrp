function SWEP:PrimeGrenade()
    self.Primary.Automatic = true

    if self:StillWaiting() then return end
    -- if self:SprintLock() then return end
    if self:GetPrimedGrenade() then return end

    local nade = self:GetGrenade()

    if !self:CheckGrenade() then
        self:SelectGrenade()
        return
    end

    if !TacRP.IsGrenadeInfiniteAmmo(nade) then
        local ammo = self:GetOwner():GetAmmoCount(nade.Ammo)
        if ammo < 1 then return end

        self:GetOwner():SetAmmo(ammo - 1, nade.Ammo)
    end

    local t = self:PlayAnimation("prime_grenade", self:GetValue("QuickNadeTimeMult") / (nade.ThrowSpeed or 1), true)

    self:SetPrimedGrenade(true)
    self:ToggleBlindFire(false)
    self:ScopeToggle(0)

    local ct = CurTime()

    self:SetStartPrimedGrenadeTime(ct)
    self:SetAnimLockTime(ct + (t * 0.75))
    self:SetNextPrimaryFire(ct + (t * 1.1))

    self:GetOwner():DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_THROW)

    if CLIENT then return end

    self.CurrentGrenade = self:GetGrenade()

    if !nade.NoSounds then
        self:EmitSound(nade.PullSound or ("TacRP/weapons/grenade/pullpin-" .. math.random(1, 2) .. ".wav"))
    end
end

function SWEP:ThrowGrenade()
    local nade = self.CurrentGrenade or self:GetGrenade()

    local force = nade.ThrowForce
    local ent = nade.GrenadeEnt

    local src = self:GetOwner():EyePos()
    local ang = self:GetOwner():EyeAngles()
    local spread = 0

    local amount = 1

    if !self:GetOwner():KeyDown(IN_GRENADE1) and !nade.OverhandOnly then
        self:PlayAnimation("throw_grenade_underhand", self:GetValue("QuickNadeTimeMult"), true, true)

        force = force / 2
        ang:RotateAroundAxis(ang:Right(), 20)
        if nade.UnderhandSpecial then
            force = force * 0.75
            ang:RotateAroundAxis(ang:Right(), -10)
            amount = math.random(2, 4)
            spread = 0.15
        end
    else
        ang:RotateAroundAxis(ang:Right(), 5)
        self:PlayAnimation("throw_grenade", self:GetValue("QuickNadeTimeMult"), true, true)
    end

    if CLIENT then return end

    for i = 1, amount do

        local rocket = ents.Create(ent or "")

        if !IsValid(rocket) then return end

        local dispersion = Angle(math.Rand(-1, 1), math.Rand(-1, 1), 0)
        dispersion = dispersion * spread * 36

        rocket:SetPos(src)
        rocket:SetOwner(self:GetOwner())
        rocket:SetAngles(ang + dispersion)
        rocket:Spawn()
        rocket:SetPhysicsAttacker(self:GetOwner(), 10)

        if rocket.PickupAmmo and TacRP.IsGrenadeInfiniteAmmo(nade) then
            rocket.PickupAmmo = nil
        end

        local phys = rocket:GetPhysicsObject()

        if phys:IsValid() then
            phys:ApplyForceCenter((ang + dispersion):Forward() * force + self:GetOwner():GetVelocity())
            phys:AddAngleVelocity(VectorRand() * 1000)
        end

        if nade.Spoon then
            local mag = ents.Create("TacRP_droppedmag")

            if mag then
                mag:SetPos(src)
                mag:SetAngles(ang)
                mag.Model = "models/weapons/tacint/flashbang_spoon.mdl"
                mag.ImpactType = "spoon"
                mag:SetOwner(self:GetOwner())
                mag:Spawn()

                local phys2 = mag:GetPhysicsObject()

                if IsValid(phys2) then
                    phys2:ApplyForceCenter(ang:Forward() * force * 0.25 + VectorRand() * 50)
                    phys2:AddAngleVelocity(Vector(math.Rand(-300, 300), math.Rand(-300, 300), math.Rand(-300, 300)))
                end
            end
        end
    end
end

function SWEP:GetGrenade(index)
    index = index or self:GetGrenadeIndex()

    return TacRP.QuickNades[TacRP.QuickNades_Index[index]]
end

function SWEP:GetGrenadeIndex()
    return self:GetOwner():GetNWInt("ti_nade", 1)
end

function SWEP:GetNextGrenade(ind)
    ind = ind or self:GetGrenadeIndex()

    ind = ind + 1

    if ind > TacRP.QuickNades_Count then
        ind = 1
    elseif ind < 1 then
        ind = TacRP.QuickNades_Count
    end

    if !self:CheckGrenade(ind) then
        return self:GetNextGrenade(ind)
    end

    return self:GetGrenade(ind)
end

function SWEP:SelectGrenade(index)
    if !IsFirstTimePredicted() then return end
    if self:GetPrimedGrenade() then return end

    local ind = self:GetOwner():GetNWInt("ti_nade", 1)

    if index then
        ind = index
    else
        if self:GetOwner():KeyDown(IN_WALK) then
            ind = ind - 1
        else
            ind = ind + 1
        end
    end

    if ind > TacRP.QuickNades_Count then
        ind = 1
    elseif ind < 1 then
        ind = TacRP.QuickNades_Count
    end

    self:GetOwner():SetNWInt("ti_nade", ind)

    if !self:CheckGrenade(ind) then
        self:SelectGrenade()
    end
end

function SWEP:CheckGrenade(index, checkammo)
    index = index or self:GetOwner():GetNWInt("ti_nade", 1)
    local nade = self:GetGrenade(index)
    local hasammo = nade.Ammo == nil or self:GetOwner():GetAmmoCount(nade.Ammo) > 0
    if (nade.Secret and !hasammo and !self:GetOwner():HasWeapon(nade.SecretWeapon or "")) or (nade.RequireStat and !self:GetValue(nade.RequireStat)) then
        return false
    end
    if checkammo and !TacRP.IsGrenadeInfiniteAmmo(index) and !hasammo then
        return false
    end
    return true
end

function SWEP:GetAvailableGrenades(checkammo)
    local nades = {}
    for i = 1, TacRP.QuickNades_Count do
        if self:CheckGrenade(i, checkammo) then
            table.insert(nades, self:GetGrenade(i))
        end
    end
    return nades
end

if CLIENT then

SWEP.QuickNadeModel = nil

end

function SWEP:ThinkGrenade()
    if CLIENT then
        if self:GetPrimedGrenade() and !IsValid(self.QuickNadeModel) and self:GetStartPrimedGrenadeTime() + 0.1 < CurTime() and self:GetGrenade().Model then
            local nade = self:GetGrenade()
            local vm = self:GetVM()

            local model = ClientsideModel(nade.Model or "models/weapons/tacint/v_quicknade_frag.mdl")

            if !IsValid(model) then return end

            model:SetParent(vm)
            model:AddEffects(EF_BONEMERGE)
            model:SetNoDraw(true)

            if nade.Material then
                model:SetMaterial(nade.Material)
            end

            self.QuickNadeModel = model

            local tbl = {
                Model = model,
                Weapon = self
            }

            table.insert(TacRP.CSModelPile, tbl)
        elseif !self:GetPrimedGrenade() and self.QuickNadeModel then
            SafeRemoveEntity(self.QuickNadeModel)
            self.QuickNadeModel = nil
        end
    end

    if self:GetOwner():KeyPressed(IN_GRENADE1) then
        self:PrimeGrenade()
    elseif !GetConVar("tacrp_nademenu"):GetBool() and self:GetOwner():KeyPressed(IN_GRENADE2) then
        self:SelectGrenade()
    end

    if self:GetPrimedGrenade() and self:GetAnimLockTime() < CurTime() then
        self:ThrowGrenade()
        self:SetPrimedGrenade(false)
    end
end