EFFECT.Type = 1

EFFECT.Pitch = 100

EFFECT.Model = "models/shells/shell_57.mdl"

EFFECT.AlreadyPlayedSound = false
EFFECT.ShellTime = 0.5
EFFECT.SpawnTime = 0

EFFECT.VMContext = true

function EFFECT:Init(data)

    local att = data:GetAttachment()
    local ent = data:GetEntity()

    self.Type = data:GetFlags() or self.Type

    local typetbl = TacRP.ShellTypes[self.Type]

    if !IsValid(ent) then self:Remove() return end
    if !IsValid(ent:GetOwner()) then self:Remove() return end

    local origin, ang, dir

    if ent:GetOwner() == LocalPlayer() and ent:GetValue("ScopeHideWeapon") and ent:IsInScope() then
        origin = EyePos()
                + EyeAngles():Right() * ent.PassivePos.x
                + EyeAngles():Forward() * ent.PassivePos.y
                + EyeAngles():Up() * ent.PassivePos.z
        ang = EyeAngles()
        dir = ang:Right() -- not exactly correct but we can't rely on weapon model here
    else
        if LocalPlayer():ShouldDrawLocalPlayer() or ent:GetOwner() != LocalPlayer() then
            mdl = ent
            att = data:GetHitBox()
            self.VMContext = false
        else
            mdl = LocalPlayer():GetViewModel()
            table.insert(ent.ActiveEffects, self)
        end

        if !IsValid(ent) then self:Remove() return end
        if !mdl or !IsValid(mdl) then self:Remove() return end
        if !mdl:GetAttachment(att) then self:Remove() return end
        if !typetbl then return end

        origin = mdl:GetAttachment(att).Pos
        ang = mdl:GetAttachment(att).Ang

        -- ang:RotateAroundAxis(ang:Up(), -90)

        -- ang:RotateAroundAxis(ang:Right(), (ent.ShellRotateAngle or Angle(0, 0, 0))[1])
        -- ang:RotateAroundAxis(ang:Up(), (ent.ShellRotateAngle or Angle(0, 0, 0))[2])
        -- ang:RotateAroundAxis(ang:Forward(), (ent.ShellRotateAngle or Angle(0, 0, 0))[3])

        dir = ang:Forward()

        ang:RotateAroundAxis(ang:Forward(), 0)
        ang:RotateAroundAxis(ang:Up(), 0)
    end

    self:SetPos(origin)
    self:SetModel(typetbl.Model)
    self:SetModelScale(data:GetScale(), 0)
    self:DrawShadow(true)
    self:SetAngles(ang)

    self:SetNoDraw(true)

    self.Sounds = typetbl.Sounds

    local pb_vert = 2
    local pb_hor = 0.25

    local mag = 150

    self:PhysicsInitBox(Vector(-pb_vert,-pb_hor,-pb_hor), Vector(pb_vert,pb_hor,pb_hor))

    self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

    local phys = self:GetPhysicsObject()

    local plyvel = Vector(0, 0, 0)

    if IsValid(ent.Owner) then
        plyvel = ent.Owner:GetAbsVelocity()
    end

    phys:Wake()
    phys:SetDamping(0, 0)
    phys:SetMass(1)
    phys:SetMaterial("gmod_silent")

    phys:SetVelocity((dir * mag * math.Rand(1, 2)) + plyvel)

    phys:AddAngleVelocity(VectorRand() * 100)
    phys:AddAngleVelocity(ang:Up() * -2500 * math.Rand(0.75, 1.25))

    local smoke = true

    if smoke and IsValid(mdl) then
        local pcf = CreateParticleSystem(mdl, "port_smoke", PATTACH_POINT_FOLLOW, att)

        if IsValid(pcf) then
            pcf:StartEmission()
        end

        local smkpcf = CreateParticleSystem(self, "shellsmoke", PATTACH_ABSORIGIN_FOLLOW, 0)

        if IsValid(smkpcf) then
            smkpcf:StartEmission()
        end

        if self.VMContext then
            table.insert(ent.PCFs, pcf)
            table.insert(ent.PCFs, smkpcf)

            pcf:SetShouldDraw(false)
            smkpcf:SetShouldDraw(false)
        end
    end

    self.SpawnTime = CurTime()
end

function EFFECT:PhysicsCollide(colData)
    if self.AlreadyPlayedSound then return end
    local phys = self:GetPhysicsObject()
    phys:SetVelocityInstantaneous(colData.HitNormal * -150)

    sound.Play(self.Sounds[math.random(#self.Sounds)], self:GetPos(), 65, 100, 1)
    self:StopSound("Default.ImpactHard")
    self.VMContext = false
    self:SetNoDraw(false)

    self.AlreadyPlayedSound = true
end

function EFFECT:Think()
    if self:GetVelocity():Length() > 0 then self.SpawnTime = CurTime() end
    self:StopSound("Default.ScrapeRough")

    if (self.SpawnTime + self.ShellTime) <= CurTime() then
        if !IsValid(self) then return end
        self:SetRenderFX( kRenderFxFadeFast )
        if (self.SpawnTime + self.ShellTime + 0.25) <= CurTime() then
            if !IsValid(self:GetPhysicsObject()) then return end
            self:GetPhysicsObject():EnableMotion(false)
            if (self.SpawnTime + self.ShellTime + 0.5) <= CurTime() then
                self:Remove()
                return
            end
        end
    end
    return true
end

function EFFECT:Render()
    if !IsValid(self) then return end

    self:DrawModel()
end

function EFFECT:DrawTranslucent()
    if !IsValid(self) then return end

    self:DrawModel()
end