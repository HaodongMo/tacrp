function SWEP:PrimeGrenade()
    self.Primary.Automatic = true

    if self:StillWaiting() then return end
    if self:SprintLock() then return end
    if self:GetPrimedGrenade() then return end

    local nade = self:GetGrenade()

    if nade.Ammo then
        local ammo = self:GetOwner():GetAmmoCount(nade.Ammo)

        if ammo < 1 then return end

        self:GetOwner():SetAmmo(ammo - 1, nade.Ammo)
    end

    local t = self:PlayAnimation("prime_grenade", self:GetValue("QuickNadeTimeMult"), true)

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
end

function SWEP:ThrowGrenade()
    local nade = self.CurrentGrenade or self:GetGrenade()

    local force = nade.ThrowForce
    local ent = nade.GrenadeEnt

    if !self:GetOwner():KeyDown(IN_GRENADE1) and !self:GetOwner():KeyDown(IN_ATTACK2) then
        self:PlayAnimation("throw_grenade_underhand", self:GetValue("QuickNadeTimeMult"), true, true)

        force = force * 0.5
    else
        self:PlayAnimation("throw_grenade", self:GetValue("QuickNadeTimeMult"), true, true)
    end

    if CLIENT then return end

    local rocket = ents.Create(ent or "")

    if !IsValid(rocket) then return end

    local src = self:GetOwner():EyePos()
    local ang = self:GetOwner():EyeAngles()

    rocket:SetPos(src)
    rocket:SetOwner(self:GetOwner())
    rocket:SetAngles(ang)
    rocket:Spawn()

    local phys = rocket:GetPhysicsObject()

    if phys:IsValid() then
        phys:ApplyForceCenter(ang:Forward() * force)
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

function SWEP:GetGrenade(index)
    index = index or self:GetGrenadeIndex()

    return TacRP.QuickNades[TacRP.QuickNades_Index[index]]
end

function SWEP:GetGrenadeIndex()
    return self:GetOwner():GetNWInt("ti_nade", 1)
end

function SWEP:GetNextGrenade(ind)
    local ind = ind or self:GetGrenadeIndex()

    ind = ind + 1

    if ind > TacRP.QuickNades_Count then
        ind = 1
    elseif ind < 1 then
        ind = TacRP.QuickNades_Count
    end

    local nade = self:GetGrenade(ind)

    if nade.Secret and self:GetOwner():GetAmmoCount(nade.Ammo) <= 0 then
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

    local nade = self:GetGrenade()

    if nade.Secret and self:GetOwner():GetAmmoCount(nade.Ammo) <= 0 then
        self:SelectGrenade()
    end
end

if CLIENT then

SWEP.QuickNadeModel = nil

end

function SWEP:ThinkGrenade()
    if CLIENT then
        if self:GetPrimedGrenade() and !IsValid(self.QuickNadeModel) and self:GetStartPrimedGrenadeTime() + 0.1 < CurTime() then
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

    if self:GetOwner():KeyDown(IN_GRENADE1) then
        self:PrimeGrenade()
    elseif self:GetOwner():KeyPressed(IN_GRENADE2) then
        self:SelectGrenade()
    end

    if self:GetPrimedGrenade() then
        if self:GetAnimLockTime() < CurTime() then
            self:ThrowGrenade()
            self:SetPrimedGrenade(false)
        end
    end
end