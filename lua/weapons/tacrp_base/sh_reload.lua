function SWEP:Reload()
    if self:GetOwner():IsNPC() then
        self:NPC_Reload()
        return
    end

    if !self:GetOwner():KeyPressed(IN_RELOAD) then
        return
    end

    if self:GetValue("Firemodes") and self:GetOwner():KeyDown(IN_USE) then
        self:SwitchFiremode()
        self:EmitSound("tacrp/weapons/pdw/fire_select-1.wav", 75, 100, 1, CHAN_ITEM)
        return
    end

    if self:StillWaiting() then return end
    if self:GetValue("ClipSize") <= 0 then return end
    if self:Clip1() >= self:GetValue("ClipSize") then return end
    if self:Ammo1() <= 0 then return end

    -- self:ScopeToggle(0)
    self:ToggleBlindFire(false)
    self:ToggleCustomize(false)

    local anim = "reload"

    if self:GetValue("ShotgunReload") then
        anim = "reload_start"
    else
        self:SetTimer(self:GetValue("LoadInTime") * self:GetValue("ReloadTimeMult"), function()
            self:SetLoadedRounds(math.min(self:GetValue("ClipSize"), self:Clip1() + self:Ammo1()))
            self:DoBulletBodygroups()
        end)
    end

    local t = self:PlayAnimation(anim, self:GetValue("ReloadTimeMult"), true, true)
    self:GetOwner():DoAnimationEvent(self:GetValue("GestureReload"))

    if SERVER then
        self:DropMagazine()
    end

    self:SetLoadedRounds(self:Clip1())

    self:SetReloading(true)
    self:SetEndReload(false)

    self:DoBulletBodygroups()

    -- self:SetTimer(t * 0.9, function()
    --     if !IsValid(self) then return end

    --     self:SetEndReload(false)
    --     self:EndReload()
    -- end)

    self:SetReloadFinishTime(CurTime() + (t * 0.95))
end

function SWEP:DropMagazine()
    -- if !IsFirstTimePredicted() and !game.SinglePlayer() then return end
    if self:GetValue("DropMagazineModel") then
        for i = 1, self:GetValue("DropMagazineAmount") do
            local mag = ents.Create("TacRP_droppedmag")

            if mag then
                local matrix = self:GetOwner():GetBoneMatrix(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))
                local pos = matrix:GetTranslation() or self:GetOwner():EyePos() - (self:GetOwner():EyeAngles():Up() * 8)
                local ang = matrix:GetAngles() or self:GetOwner():EyeAngles()
                mag:SetPos(pos)
                mag:SetAngles(ang)
                mag.Model = self:GetValue("DropMagazineModel")
                mag.ImpactType = self:GetValue("DropMagazineImpact")
                mag:SetOwner(self:GetOwner())
                mag:Spawn()

                local phys = mag:GetPhysicsObject()

                if IsValid(phys) then
                    phys:AddAngleVelocity(Vector(math.Rand(-300, 300), math.Rand(-300, 300), math.Rand(-300, 300)))
                end
            end
        end
    end
end

function SWEP:RestoreClip(amt)
    local reserve = self:Clip1() + self:Ammo1()

    local lastclip1 = self:Clip1()

    self:SetClip1(math.min(math.min(self:Clip1() + amt, self:GetValue("ClipSize")), reserve))

    reserve = reserve - self:Clip1()

    self:GetOwner():SetAmmo(reserve, self.Primary.Ammo)

    return self:Clip1() - lastclip1
end

function SWEP:EndReload()
    if self:GetValue("ShotgunReload") then
        if self:Clip1() >= self:GetValue("ClipSize") or self:Ammo1() == 0 or self:GetEndReload() then
            // finish
            self:PlayAnimation("reload_finish", self:GetValue("ReloadTimeMult"), true, true)
            self:SetReloading(false)

            self:SetNthShot(0)

            self:DoBulletBodygroups()
        else
            local t = self:PlayAnimation("reload", self:GetValue("ReloadTimeMult"), true)

            local res = math.min(math.min(3, self:GetValue("ClipSize") - self:Clip1()), self:Ammo1())

            self:SetLoadedRounds(res)

            for i = 1, res do
                self:SetTimer(t * 0.95 * ((i - 1) / 3), function()
                    self:RestoreClip(1)
                end)
            end

            self:SetReloadFinishTime(CurTime() + (t * 0.95 * (res / 3)))

            -- self:SetTimer(t * 0.95 * (res / 3), function()
            --     if !IsValid(self) then return end

            --     self:EndReload()
            -- end)

            self:DoBulletBodygroups()
        end
    else
        self:RestoreClip(self:GetValue("ClipSize"))
        self:SetReloading(false)

        self:SetNthShot(0)
    end
end

function SWEP:ThinkReload()
    if self:GetReloading() and self:GetReloadFinishTime() < CurTime() then
        self:EndReload()
    end
end