function SWEP:GetMuzzleOrigin()
    if !IsValid(self:GetOwner()) then
        return self:GetPos()
    end
    if self:GetOwner():IsNPC() then
        return SERVER and self:GetOwner():GetShootPos() or self:GetOwner():EyePos()
    end

    if self:GetBlindFire() then
        local pos = self:GetOwner():EyePos()
        local eyeang = self:GetOwner():EyeAngles()

        local testpos = pos + eyeang:Up() * 24

        if self:GetBlindFireLeft() or self:GetBlindFireRight() then
            testpos = pos + eyeang:Forward() * 24
        end

        local tr = util.TraceLine({
            start = pos,
            endpos = testpos,
            filter = self:GetOwner()
        })

        return tr.HitPos
    else
        return self:GetOwner():EyePos()
    end
end

/*

ValveBiped.Bip01_Spine
ValveBiped.Bip01_Spine1
ValveBiped.Bip01_Spine2
ValveBiped.Bip01_Spine4
ValveBiped.Bip01_Neck1
ValveBiped.Bip01_Head1
ValveBiped.forward
ValveBiped.Bip01_R_Clavicle
ValveBiped.Bip01_R_UpperArm
ValveBiped.Bip01_R_Forearm
ValveBiped.Bip01_R_Hand
ValveBiped.Anim_Attachment_RH
ValveBiped.Bip01_L_Clavicle
ValveBiped.Bip01_L_UpperArm
ValveBiped.Bip01_L_Forearm
ValveBiped.Bip01_L_Hand
ValveBiped.Anim_Attachment_LH
ValveBiped.Bip01_R_Thigh
ValveBiped.Bip01_R_Calf
ValveBiped.Bip01_R_Foot
ValveBiped.Bip01_R_Toe0
ValveBiped.Bip01_L_Thigh
ValveBiped.Bip01_L_Calf
ValveBiped.Bip01_L_Foot
ValveBiped.Bip01_L_Toe0
ValveBiped.Bip01_L_Finger4
ValveBiped.Bip01_L_Finger41
ValveBiped.Bip01_L_Finger42
ValveBiped.Bip01_L_Finger3
ValveBiped.Bip01_L_Finger31
ValveBiped.Bip01_L_Finger32
ValveBiped.Bip01_L_Finger2
ValveBiped.Bip01_L_Finger21
ValveBiped.Bip01_L_Finger22
ValveBiped.Bip01_L_Finger1
ValveBiped.Bip01_L_Finger11
ValveBiped.Bip01_L_Finger12
ValveBiped.Bip01_L_Finger0
ValveBiped.Bip01_L_Finger01
ValveBiped.Bip01_L_Finger02
ValveBiped.Bip01_R_Finger4
ValveBiped.Bip01_R_Finger41
ValveBiped.Bip01_R_Finger42
ValveBiped.Bip01_R_Finger3
ValveBiped.Bip01_R_Finger31
ValveBiped.Bip01_R_Finger32
ValveBiped.Bip01_R_Finger2
ValveBiped.Bip01_R_Finger21
ValveBiped.Bip01_R_Finger22
ValveBiped.Bip01_R_Finger1
ValveBiped.Bip01_R_Finger11
ValveBiped.Bip01_R_Finger12
ValveBiped.Bip01_R_Finger0
ValveBiped.Bip01_R_Finger01
ValveBiped.Bip01_R_Finger02

*/

local bone_list = {
    "ValveBiped.Bip01_R_UpperArm",
    "ValveBiped.Bip01_R_Forearm",
    "ValveBiped.Bip01_R_Hand",
    "ValveBiped.Bip01_L_UpperArm",
    "ValveBiped.Bip01_L_Forearm",
    "ValveBiped.Bip01_L_Hand",
}

local bone_mods = {
    -- ["ValveBiped.Bip01_R_UpperArm"] = Angle(0, -70, 0),
    -- ["ValveBiped.Bip01_R_Hand"] = Angle(-55, 45, -90),
    ["ValveBiped.Bip01_R_UpperArm"] = Angle(45, -90, 0),
    ["ValveBiped.Bip01_R_Hand"] = Angle(-90, 0, 0),
}

local bone_mods_left = {
    -- ["ValveBiped.Bip01_R_UpperArm"] = Angle(0, -70, 0),
    -- ["ValveBiped.Bip01_R_Hand"] = Angle(-55, 45, -90),
    ["ValveBiped.Bip01_R_UpperArm"] = Angle(45, 0, 0),
    ["ValveBiped.Bip01_R_Forearm"] = Angle(0, 0, 0),
    ["ValveBiped.Bip01_R_Hand"] = Angle(0, -75, 0),
}

local bone_mods_right = {
    ["ValveBiped.Bip01_R_UpperArm"] = Angle(-45, 0, 0),
    ["ValveBiped.Bip01_R_Forearm"] = Angle(0, 0, 0),
    ["ValveBiped.Bip01_R_Hand"] = Angle(35, 75, 0),
}

local bone_mods_kys = {
    ["ValveBiped.Bip01_R_UpperArm"] = Angle(5, 0, 0),
    ["ValveBiped.Bip01_R_Forearm"] = Angle(0, -5, 0),
    ["ValveBiped.Bip01_R_Hand"] = Angle(0, -165, 0),
}
local bone_mods_kys_pistol = {
    ["ValveBiped.Bip01_R_UpperArm"] = Angle(55, 0, 0),
    ["ValveBiped.Bip01_R_Forearm"] = Angle(0, -75, 5),
    ["ValveBiped.Bip01_R_Hand"] = Angle(45, -75, 0),
}
local bone_mods_kys_dual = {
    ["ValveBiped.Bip01_L_UpperArm"] = Angle(-60, 0, -45),
    ["ValveBiped.Bip01_L_Forearm"] = Angle(0, -60, -30),
    ["ValveBiped.Bip01_L_Hand"] = Angle(-30, -45, -90),
    ["ValveBiped.Bip01_R_UpperArm"] = Angle(55, 0, 30),
    ["ValveBiped.Bip01_R_Forearm"] = Angle(0, -60, 30),
    ["ValveBiped.Bip01_R_Hand"] = Angle(45, -75, 90),
}

local bone_mods_pos = {}
local bone_mods_left_pos = {}
local bone_mods_right_pos = {}
local bone_mods_kys_pos = {}

local bone_mods_index = {
    [TacRP.BLINDFIRE_UP]    = {bone_mods, bone_mods_pos},
    [TacRP.BLINDFIRE_LEFT]  = {bone_mods_left, bone_mods_left_pos},
    [TacRP.BLINDFIRE_RIGHT] = {bone_mods_right, bone_mods_right_pos},
    [TacRP.BLINDFIRE_KYS] = {bone_mods_kys, bone_mods_kys_pos},
}

function SWEP:ToggleBoneMods(on, left)

    if isnumber(on) or on == false then
        if on == TacRP.BLINDFIRE_NONE or on == false then
            for _, i in ipairs(bone_list) do
                local boneindex = self:GetOwner():LookupBone(i)
                if !boneindex then continue end

                self:GetOwner():ManipulateBoneAngles(boneindex, Angle(0, 0, 0))
                self:GetOwner():ManipulateBonePosition(boneindex, Vector(0, 0, 0))
            end
        else
            local tbl = bone_mods_index[on]
            if on == TacRP.BLINDFIRE_KYS and self:GetValue("HoldTypeSuicide") == "duel" then
                tbl = {bone_mods_kys_dual, bone_mods_kys_pos}
            elseif on == TacRP.BLINDFIRE_KYS and self:GetValue("HoldType") == "revolver" then
                tbl = {bone_mods_kys_pistol, bone_mods_kys_pos}
            end

            for i, k in pairs(tbl[1]) do
                local boneindex = self:GetOwner():LookupBone(i)
                if !boneindex then continue end

                self:GetOwner():ManipulateBoneAngles(boneindex, k)
            end

            for i, k in pairs(tbl[2]) do
                local boneindex = self:GetOwner():LookupBone(i)
                if !boneindex then continue end

                self:GetOwner():ManipulateBonePosition(boneindex, k)
            end
        end
    elseif on then
        if left then
            for i, k in pairs(bone_mods_left) do
                local boneindex = self:GetOwner():LookupBone(i)
                if !boneindex then continue end

                self:GetOwner():ManipulateBoneAngles(boneindex, k)
            end

            for i, k in pairs(bone_mods_left_pos) do
                local boneindex = self:GetOwner():LookupBone(i)
                if !boneindex then continue end

                self:GetOwner():ManipulateBonePosition(boneindex, k)
            end
        else
            for i, k in pairs(bone_mods) do
                local boneindex = self:GetOwner():LookupBone(i)
                if !boneindex then continue end

                self:GetOwner():ManipulateBoneAngles(boneindex, k)
            end

            for i, k in pairs(bone_mods_pos) do
                local boneindex = self:GetOwner():LookupBone(i)
                if !boneindex then continue end

                self:GetOwner():ManipulateBonePosition(boneindex, k)
            end
        end
    else
        for i, k in pairs(bone_mods_left) do
            local boneindex = self:GetOwner():LookupBone(i)
            if !boneindex then continue end

            self:GetOwner():ManipulateBoneAngles(boneindex, Angle(0, 0, 0))
        end

        for i, k in pairs(bone_mods_left_pos) do
            local boneindex = self:GetOwner():LookupBone(i)
            if !boneindex then continue end

            self:GetOwner():ManipulateBonePosition(boneindex, Vector(0, 0, 0))
        end

        for i, k in pairs(bone_mods) do
            local boneindex = self:GetOwner():LookupBone(i)
            if !boneindex then continue end

            self:GetOwner():ManipulateBoneAngles(boneindex, Angle(0, 0, 0))
        end

        for i, k in pairs(bone_mods_pos) do
            local boneindex = self:GetOwner():LookupBone(i)
            if !boneindex then continue end

            self:GetOwner():ManipulateBonePosition(boneindex, Vector(0, 0, 0))
        end
    end
end

function SWEP:GetBlindFireMode()
    if !self:GetBlindFire() then
        return TacRP.BLINDFIRE_NONE
    elseif self:GetBlindFireLeft() and self:GetBlindFireRight() then
        return TacRP.BLINDFIRE_KYS
    elseif self:GetBlindFireLeft() then
        return TacRP.BLINDFIRE_LEFT
    elseif self:GetBlindFireRight() then
        return TacRP.BLINDFIRE_RIGHT
    else
        return TacRP.BLINDFIRE_UP
    end
end

local bfmode = {
    [TacRP.BLINDFIRE_NONE] = {false, false, false},
    [TacRP.BLINDFIRE_UP] = {true, false, false},
    [TacRP.BLINDFIRE_LEFT] = {true, true, false},
    [TacRP.BLINDFIRE_RIGHT] = {true, false, true},
    [TacRP.BLINDFIRE_KYS] = {true, true, true},
}
function SWEP:SetBlindFireMode(mode)
    if !bfmode[mode] then
        print("[TacRP] WARNING! Trying to set invalid blindfire mode: " .. tostring(mode))
        mode = 0
    end
    self:SetBlindFire(bfmode[mode][1])
    self:SetBlindFireLeft(bfmode[mode][2])
    self:SetBlindFireRight(bfmode[mode][3])
end

function SWEP:CheckBlindFire(suicide)
    if !self:GetValue("CanBlindFire") and (!suicide or !self:GetValue("CanSuicide")) then return false end
    if (self:GetIsSprinting()
            or self:GetAnimLockTime() > CurTime()
            or self:GetPrimedGrenade()
            or self:IsInScope()
            or self:GetSafe()) then
        return false
    end
    return true
end

function SWEP:ToggleBlindFire(bf)
    local kms = bf == TacRP.BLINDFIRE_KYS or bf == TacRP.BLINDFIRE_NONE
    if bf != TacRP.BLINDFIRE_NONE and !self:CheckBlindFire(kms) then return end
    if bf == self:GetBlindFireMode() then return end

    self:ToggleCustomize(false)

    self:SetBlindFireMode(bf)

    if bf != TacRP.BLINDFIRE_NONE then
        self:ScopeToggle(0)
    end
    self:SetBlindFireFinishTime(CurTime() + (bf == TacRP.BLINDFIRE_KYS and 0.8 or 0.3))

    self:ToggleBoneMods(bf)

    self:SetShouldHoldType()

    if self:StillWaiting(true) then self:IdleAtEndOfAnimation() return end

    self:Idle()
end

function SWEP:ThinkBlindFire()
    if self:GetOwner():KeyDown(IN_ZOOM) and !tobool(self:GetOwner():GetInfo("tacrp_blindfiremenu")) then
        if self:GetOwner():KeyDown(IN_FORWARD) then
            self:ToggleBlindFire(TacRP.BLINDFIRE_UP)
        elseif self:GetOwner():KeyDown(IN_MOVELEFT) and !self:GetOwner():KeyDown(IN_MOVERIGHT) then
            self:ToggleBlindFire(TacRP.BLINDFIRE_LEFT)
        elseif self:GetOwner():KeyDown(IN_MOVERIGHT) and !self:GetOwner():KeyDown(IN_MOVELEFT)  then
            self:ToggleBlindFire(TacRP.BLINDFIRE_RIGHT)
        elseif self:GetOwner():KeyDown(IN_SPEED) and self:GetOwner():KeyDown(IN_WALK) and !tobool(self:GetOwner():GetInfo("tacrp_idunwannadie")) then
            self:ToggleBlindFire(TacRP.BLINDFIRE_KYS)
        elseif self:GetOwner():KeyDown(IN_BACK) then
            self:ToggleBlindFire(TacRP.BLINDFIRE_NONE)
        end
    end
end