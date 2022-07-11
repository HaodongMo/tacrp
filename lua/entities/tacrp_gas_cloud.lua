ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Gas Cloud"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

local smokeimages = {"particle/smokesprites_0001", "particle/smokesprites_0002", "particle/smokesprites_0003", "particle/smokesprites_0004", "particle/smokesprites_0005", "particle/smokesprites_0006", "particle/smokesprites_0007", "particle/smokesprites_0008", "particle/smokesprites_0009", "particle/smokesprites_0010", "particle/smokesprites_0011", "particle/smokesprites_0012", "particle/smokesprites_0013", "particle/smokesprites_0014", "particle/smokesprites_0015", "particle/smokesprites_0016"}

local function GetSmokeImage()
    return smokeimages[math.random(#smokeimages)]
end

ENT.Particles = nil
ENT.SmokeRadius = 256
ENT.SmokeColor = Color(125, 150, 50)
ENT.BillowTime = 5
ENT.Life = 15

ENT.TacRPSmoke = true

AddCSLuaFile()

function ENT:Initialize()
    if SERVER then
        self:SetModel( "models/weapons/w_eq_smokegrenade_thrown.mdl" )
        self:SetMoveType( MOVETYPE_NONE )
        self:SetSolid( SOLID_NONE )
        self:DrawShadow( false )
    else
        local emitter = ParticleEmitter(self:GetPos())

        self.Particles = {}

        local amt = 20

        for i = 1, amt do
            local smoke = emitter:Add(GetSmokeImage(), self:GetPos())
            smoke:SetVelocity( VectorRand() * 8 + (Angle(0, i * (360 / amt), 0):Forward() * 200) )
            smoke:SetStartAlpha( 0 )
            smoke:SetEndAlpha( 255 )
            smoke:SetStartSize( 0 )
            smoke:SetEndSize( self.SmokeRadius )
            smoke:SetRoll( math.Rand(-180, 180) )
            smoke:SetRollDelta( math.Rand(-0.2,0.2) )
            smoke:SetColor( self.SmokeColor.r, self.SmokeColor.g, self.SmokeColor.b )
            smoke:SetAirResistance( 75 )
            smoke:SetPos( self:GetPos() )
            smoke:SetCollide( true )
            smoke:SetBounce( 0.2 )
            smoke:SetLighting( false )
            smoke:SetNextThink( CurTime() + FrameTime() )
            smoke.bt = CurTime() + self.BillowTime
            smoke.dt = CurTime() + self.BillowTime + self.Life
            smoke.ft = CurTime() + self.BillowTime + self.Life + math.Rand(2.5, 5)
            smoke:SetDieTime(smoke.ft)
            smoke.life = self.Life
            smoke.billowed = false
            smoke.radius = self.SmokeRadius
            smoke:SetThinkFunction( function(pa)
                if !pa then return end

                local prog = 1
                local alph = 0

                if pa.ft < CurTime() then
                    return
                elseif pa.dt < CurTime() then
                    local d = (CurTime() - pa.dt) / (pa.ft - pa.dt)

                    alph = 1 - d
                elseif pa.bt < CurTime() then
                    alph = 1
                else
                    local d = math.Clamp(pa:GetLifeTime() / (pa.bt - CurTime()), 0, 1)

                    prog = (-d ^ 2) + (2 * d)

                    alph = d
                end

                pa:SetEndSize( pa.radius * prog )
                pa:SetStartSize( pa.radius * prog )

                alph = math.Clamp(alph, 0, 1)

                pa:SetStartAlpha(50 * alph)
                pa:SetEndAlpha(50 * alph)

                pa:SetNextThink( CurTime() + FrameTime() )
            end )

            table.insert(self.Particles, smoke)
        end

        emitter:Finish()
    end

    self.dt = CurTime() + self.Life + self.BillowTime
end

function ENT:Think()

    if SERVER then
        if !self:GetOwner():IsValid() then self:Remove() return end

        local origin = self:GetPos() + Vector(0, 0, 16)

        local dmg = DamageInfo()
        dmg:SetAttacker(self:GetOwner())
        dmg:SetInflictor(self)
        dmg:SetDamageType(DMG_NERVEGAS)
        dmg:SetDamageForce(Vector(0, 0, 0))
        dmg:SetDamagePosition(self:GetPos())
        dmg:SetDamageCustom(1024) -- immersive death

        -- util.BlastDamageInfo(dmg, self:GetPos(), 300)

        for i, k in pairs(ents.FindInSphere(origin, 300)) do
            if k:IsPlayer() or k:IsNPC() or k:IsNextBot() then
                local tr = util.TraceLine({
                    start = origin,
                    endpos = k:EyePos() or k:WorldSpaceCenter(),
                    filter = self,
                    mask = MASK_SOLID_BRUSHONLY
                })
                if tr.Fraction < 1 then continue end
                local dist = (tr.HitPos - tr.StartPos):Length()
                local delta = dist / 300

                dmg:SetDamage(10 * (1 - delta))

                k:TakeDamageInfo(dmg)
                if k:IsPlayer() then
                    k:ScreenFade( SCREENFADE.IN, Color(125, 150, 50), 2 * delta, 0 )
                end
            end
        end

        self:NextThink(CurTime() + 1)

        if self.dt < CurTime() then
            SafeRemoveEntity(self)
        end
    end

    return true
end

function ENT:Draw()
    return false
end