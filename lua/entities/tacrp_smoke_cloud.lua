ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Smoke Cloud"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

local smokeimages = {"particle/smokesprites_0001", "particle/smokesprites_0002", "particle/smokesprites_0003", "particle/smokesprites_0004", "particle/smokesprites_0005", "particle/smokesprites_0006", "particle/smokesprites_0007", "particle/smokesprites_0008", "particle/smokesprites_0009", "particle/smokesprites_0010", "particle/smokesprites_0011", "particle/smokesprites_0012", "particle/smokesprites_0013", "particle/smokesprites_0014", "particle/smokesprites_0015", "particle/smokesprites_0016"}

local function GetSmokeImage()
    return smokeimages[math.random(#smokeimages)]
end

ENT.TacRPSmoke = true
ENT.Particles = nil
ENT.SmokeRadius = 300
ENT.SmokeColor = Color(150, 150, 150)
ENT.BillowTime = 1
ENT.Life = 20

-- Cheap maths
ENT.SmokeRadiusSqr = ENT.SmokeRadius * ENT.SmokeRadius

AddCSLuaFile()

function ENT:Initialize()
    local mins, maxs = Vector(-self.SmokeRadius / 2, -self.SmokeRadius / 2, -self.SmokeRadius / 2), Vector(self.SmokeRadius / 2, self.SmokeRadius / 2, self.SmokeRadius / 2)
    if SERVER then
        self:PhysicsInitSphere(self.SmokeRadius / 2)
        self:SetCollisionBounds(mins, maxs)
        self:SetMoveType( MOVETYPE_NONE )
        self:DrawShadow( false )
    else

        table.insert(TacRP.ClientSmokeCache, self)

        local emitter = ParticleEmitter(self:GetPos())

        self.Particles = {}

        local amt = 20

        for i = 1, amt do
            local smoke = emitter:Add(GetSmokeImage(), self:GetPos())
            smoke:SetVelocity( VectorRand() * 8 + (Angle(0, i * (360 / amt), 0):Forward() * 250) )
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
                    // pass
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

                pa:SetStartAlpha(255 * alph)
                pa:SetEndAlpha(255 * alph)

                -- pa:SetLifeTime(pa:GetLifeTime() + FrameTime())
                pa:SetNextThink( CurTime() + FrameTime() )
            end )

            table.insert(self.Particles, smoke)
        end

        emitter:Finish()
    end

    if TacRP.ConVars["smoke_affectnpcs"]:GetBool() then
        self:EnableCustomCollisions()
        self:SetCustomCollisionCheck(true)
        self:CollisionRulesChanged()
    else
        self:SetSolid(SOLID_NONE)
    end

    self.dt = CurTime() + self.Life + self.BillowTime + 2
end

function ENT:TestCollision( startpos, delta, isbox, extents, mask )
    if (mask == MASK_BLOCKLOS or mask == MASK_BLOCKLOS_AND_NPCS) then
        local len = delta:Length()
        if len <= 256 then return false end -- NPCs can see very close

        local rad = self.SmokeRadiusSqr
        local pos = self:GetPos()
        local dir = delta:GetNormalized()

        -- Trace started within the smoke
        if startpos:DistToSqr(pos) <= rad then
            return {
                HitPos = startpos,
                Fraction = 0,
                Normal = -dir,
            }
        end

        -- Find the closest point on the original trace to the smoke's origin point
        local t = (pos - startpos):Dot(dir)
        local p = startpos + t * dir

        -- If the point is within smoke radius, the trace is intersecting the smoke
        if p:DistToSqr(pos) <= rad then
            return {
                HitPos = p,
                Fraction = math.Clamp(t / len, 0, 0.95),
                Normal = -dir,
            }
        end
    else
        return false
    end
end

hook.Add("ShouldCollide", "tacrp_smoke_cloud", function(ent1, ent2)
    if ent1.TacRPSmoke and !ent2:IsNPC() then return false end
    if ent2.TacRPSmoke and !ent1:IsNPC()  then return false end
end)

function ENT:Think()

    if SERVER then
        if self.dt < CurTime() then
            SafeRemoveEntity(self)
            return
        end

        --[[]
        if !TacRP.ConVars["smoke_affectnpcs"]:GetBool() then return end
        local targets = ents.FindInSphere(self:GetPos(), self.SmokeRadius)
        for _, k in pairs(targets) do
            if k:IsNPC() then
                local ret = hook.Run("TacRP_StunNPC", k, self)
                if ret then continue end
                k:SetSchedule(SCHED_STANDOFF)
            end
        end

        self:NextThink(CurTime() + 0.5)
        ]]
        return true
    end
end

function ENT:OnRemove()
    if CLIENT then
        timer.Simple(0, function()
            if !IsValid(self) then
                table.RemoveByValue(TacRP.ClientSmokeCache, self)
            end
        end)
    end
end

function ENT:Draw()
    return false
end