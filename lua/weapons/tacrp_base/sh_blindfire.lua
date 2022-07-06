function SWEP:GetMuzzleOrigin()
    if self:GetOwner():IsNPC() then
        return self:GetOwner():GetShootPos()
    end

    if self:GetBlindFire() then
        local pos = self:GetOwner():EyePos()
        local eyeang = self:GetOwner():EyeAngles()

        local testpos = pos + eyeang:Up() * 24

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

local bone_mods = {
    -- ["ValveBiped.Bip01_R_UpperArm"] = Angle(0, -70, 0),
    -- ["ValveBiped.Bip01_R_Hand"] = Angle(-55, 45, -90),
    ["ValveBiped.Bip01_R_UpperArm"] = Angle(25, -50, 0),
    ["ValveBiped.Bip01_R_Hand"] = Angle(-50, 0, 0),
}

local bone_mods_pos = {
    ["ValveBiped.Bip01_R_Hand"] = Vector(0, 0, 0),
}

function SWEP:ToggleBoneMods(on)
    if on then
        for i, k in pairs(bone_mods) do
            local boneindex = self:GetOwner():LookupBone(i)

            self:GetOwner():ManipulateBoneAngles(boneindex, k)
        end

        for i, k in pairs(bone_mods_pos) do
            local boneindex = self:GetOwner():LookupBone(i)

            self:GetOwner():ManipulateBonePosition(boneindex, k)
        end
    else
        for i, k in pairs(bone_mods) do
            local boneindex = self:GetOwner():LookupBone(i)

            self:GetOwner():ManipulateBoneAngles(boneindex, Angle(0, 0, 0))
        end

        for i, k in pairs(bone_mods_pos) do
            local boneindex = self:GetOwner():LookupBone(i)

            self:GetOwner():ManipulateBonePosition(boneindex, Vector(0, 0, 0))
        end
    end
end

function SWEP:ToggleBlindFire(bf)
    if !self:GetValue("CanBlindFire") then return end

    if bf == self:GetBlindFire() then return end
    if bf and self:GetIsSprinting() then return end
    if bf and self:GetAnimLockTime() > CurTime() then return end
    if bf and self:GetPrimedGrenade() then return end
    if bf and self:GetSafe() then return end

    self:SetBlindFire(bf)
    self:ToggleCustomize(false)

    if bf then
        self:ScopeToggle(0)
    end

    self:ToggleBoneMods(bf)

    if self:StillWaiting() then self:IdleAtEndOfAnimation() return end

    self:Idle()
end