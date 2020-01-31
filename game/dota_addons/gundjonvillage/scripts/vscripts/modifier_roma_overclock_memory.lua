modifier_roma_overclock_memory = class({})

-- При активации из roma_cry.lua
function modifier_roma_overclock_memory:OnCreated( kv )	
	self.attackSpeed = self:GetAbility():GetSpecialValueFor( "attackSpeed" )
	self.moveSpeed = self:GetAbility():GetSpecialValueFor( "moveSpeed" )
	self.lostDamage = self:GetAbility():GetSpecialValueFor( "lostDamage" )
	self.chance = self:GetAbility():GetSpecialValueFor( "chance" )
	self.totalLostDamage = 0
	self:calculateRandomChance()
end

-- Считать новые значения
function modifier_roma_overclock_memory:OnRefresh()	
	self.attackSpeed = self:GetAbility():GetSpecialValueFor( "attackSpeed" )
	self.moveSpeed = self:GetAbility():GetSpecialValueFor( "moveSpeed" )
	self.lostDamage = self:GetAbility():GetSpecialValueFor( "lostDamage" )	
	self.chance = self:GetAbility():GetSpecialValueFor( "chance" )
	self:calculateRandomChance()
end

function modifier_roma_overclock_memory:calculateRandomChance()
	local randomValue = RandomInt(0, 99)
	if randomValue < self.chance then
		self.totalLostDamage = self.totalLostDamage - self.lostDamage		
	end
end

function modifier_roma_overclock_memory:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

-- Бонус скорости атаки
function modifier_roma_overclock_memory:GetModifierAttackSpeedBonus_Constant()
	return self.attackSpeed
end

-- Бонус скорости передвижения
function modifier_roma_overclock_memory:GetModifierMoveSpeedBonus_Constant()	
	return self.moveSpeed
end

-- Бонус к урону
function modifier_roma_overclock_memory:GetModifierPreAttack_BonusDamage()		
	return self.totalLostDamage
end