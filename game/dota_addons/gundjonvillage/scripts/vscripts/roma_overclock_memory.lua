roma_overclock_memory = class({})
LinkLuaModifier("modifier_roma_overclock_memory", LUA_MODIFIER_MOTION_NONE)

function roma_overclock_memory:OnUpgrade()
        if IsServer() then
                local caster = self:GetCaster()
                caster:AddNewModifier( caster, self, "modifier_roma_overclock_memory", nil )
	end
end