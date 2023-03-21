--[[]
local function lambda_fire(self, wepent, target)
    local wd = _LAMBDAPLAYERSWEAPONS[ self.l_Weapon ]

    local delay = 60 / wd.rpm
    if wd.firemode == 1 then
        delay = 60 / math.min(wd.rpm, 700) + math.Rand(0.01, 0.03)
    elseif wd.firemode < 0 then
        if (self.l_WeaponBurstCount or 0) >= -wd.firemode then
            delay = delay + wd.postburstdelay
            self.l_WeaponBurstCount = 0
        else
            self.l_WeaponBurstCount = (self.l_WeaponBurstCount or 0) + 1
        end
    end
    self.l_WeaponUseCooldown = CurTime() + delay

    self:EmitSound(wd.attacksnd, wd.attacksnd_vol, wd.attacksnd_pitch + math.Rand(-wd.attacksnd_pvar, wd.attacksnd_pvar), 1, CHAN_WEAPON)

    -- TODO deal with akimbo
    if IsFirstTimePredicted() then
        local data = EffectData()
        data:SetEntity(wepent)
        data:SetAttachment(wd.qca_muzzle)
        data:SetFlags(wd.muzzleeffect)
        util.Effect( "TacRP_muzzleeffect", data )

        data:SetFlags(wd.ejecteffect)
        data:SetAttachment(wd.qca_eject)

        util.Effect( "TacRP_shelleffect", data )
    end

    self:RemoveGesture( wd.attackanim )
    self:AddGesture( wd.attackanim )

    local dir = (target:WorldSpaceCenter() - wepent:GetPos()):GetNormalized()


    if shootent then
        if IsValid(enemy) then
            dir = dir:Angle()
            dir = dir + ((wd.spread + 0.075) * AngleRand() / 3.6)
        end
        local dispersion = Angle(math.Rand(-1, 1), math.Rand(-1, 1), 0)
        dispersion = dispersion * spread * 36

        local rocket = ents.Create(ent)
        if !IsValid(rocket) then return true end

        rocket:SetPos(wepent:GetPos())
        rocket:SetOwner(self)
        rocket:SetAngles(dir + dispersion)
        rocket:Spawn()

        local phys = rocket:GetPhysicsObject()
        if phys:IsValid() then
            phys:ApplyForceCenter((dir + dispersion):Forward() * wd.shootentforce)
        end
    else
        self:FireBullets({
            Damage = wd.damage,
            Force = 8,
            TracerName = "tacrp_tracer",
            Tracer = 1,
            Num = wd.num,
            Dir = dir,
            Src = wepent:GetPos(),
            Spread = Vector(wd.spread, wd.spread, 0),
            IgnoreEntity = self,
        })
    end

    self.l_Clip = self.l_Clip - 1

    return true
end
]]

hook.Add("InitPostEntity", "TacRP_NPCRegister", function()
    local function stat(tbl, stat)
        if tbl.ArcadeStats and tbl.ArcadeStats[stat] then
            return tbl.ArcadeStats[stat]
        end
        return tbl[stat]
    end

    for _, wpn in pairs(weapons.GetList()) do
        local tbl = weapons.Get(wpn.ClassName)

        if !tbl.ArcticTacRP then continue end
        if !tbl.NPCUsable then continue end
        if !tbl.Spawnable then continue end

        list.Add("NPCUsableWeapons",
            {
                class = wpn.ClassName,
                title = wpn.PrintName
            }
        )

        --[[]
        if istable(_LAMBDAPLAYERSWEAPONS) then

            local range_min, range_max, damage_min, damage_max = stat(tbl, "Range_Min"), stat(tbl, "Range_Max"), stat(tbl, "Damage_Min"), stat(tbl, "Damage_Max")
            local num = stat(tbl, "Num")
            local fm = tbl.Firemode
            if tbl.Firemodes and fm < 2 then
                for _, v in ipairs(tbl.Firemodes) do
                    if v == 2 or v < fm then fm = v end
                end
            end

            table.Merge( _LAMBDAPLAYERSWEAPONS, {

                [wpn.ClassName] = {
                    model = tbl.WorldModel,
                    origin = "Tactical RP",
                    prettyname = tbl.PrintName,
                    killicon = wpn.ClassName,
                    holdtype = wpn.HoldType or "smg",
                    bonemerge = true,
                    keepdistance = num > 1 and 200 or math.Clamp(range_min * 0.5, 250, 1000),
                    attackrange = damage_min < damage_max and range_max + range_min or range_min + (range_max - range_min) / 4,

                    clip = stat(tbl, "ClipSize"),
                    num = num,
                    tracername = "tacrp_tracer",
                    damage = math.max(damage_min, damage_max),
                    spread = stat(tbl, "Spread") + 0.025,

                    attackanim = tbl.GestureShoot or ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1,
                    attacksnd = tbl.Sound_Shoot,
                    attacksnd_vol = tbl.Vol_Shoot or 100,
                    attacksnd_pitch = tbl.Pitch_Shoot or 100,
                    attacksnd_pvar = tbl.ShootPitchVariance or 0,

                    rpm = stat(tbl, "RPM"),
                    firemode = fm,
                    postburstdelay = tbl.PostBurstDelay or 0,
                    qca_muzzle = tbl.QCA_Muzzle or 1,
                    qca_eject = tbl.QCA_Eject or 2,
                    ejecteffect = tbl.EjectEffect or 1,
                    shootent = tbl.ShootEnt,
                    shootentforce = tbl.ShootEntForce,
                    muzzleeffect = TacRP.MuzzleEffectsLookup[tbl.MuzzleEffect],

                    reloadtime = 1.5,
                    reloadanim = tbl.GestureReload or ACT_HL2MP_GESTURE_RELOAD_SMG1,
                    reloadanimspeed = 1,
                    reloadsounds = {},

                    islethal = true,

                    callback = lambda_fire,
                }
            })
        end
        ]]
    end

    --[[]
    if isfunction(LambdaMergeWeapons) then
        LambdaMergeWeapons()
    end
    ]]
end)