roma_play_guitar = class({})
LinkLuaModifier("modifier_roma_play_guitar", LUA_MODIFIER_MOTION_NONE)

function roma_play_guitar:GetIntrinsicModifierName()
	return "modifier_roma_play_guitar"
end

function roma_play_guitar:OnOwnerSpawned()
        print(2)
        GetCaster():SetStackCount(2)
end
