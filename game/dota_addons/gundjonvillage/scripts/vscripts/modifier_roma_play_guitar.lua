modifier_roma_play_guitar = class({})

function modifier_roma_play_guitar:OnCreated()
        self.guitar_attack_count = self:GetAbility():GetSpecialValueFor( "guitar_attack_count" )
        self.guitar_bonus_damage = self:GetAbility():GetSpecialValueFor( "guitar_bonus_damage" )
        self.guitar_tick = self:GetAbility():GetSpecialValueFor( "guitar_tick" )        
end

function modifier_roma_play_guitar:OnRefresh()
        self.guitar_attack_count = self:GetAbility():GetSpecialValueFor( "guitar_attack_count" )
        self.guitar_bonus_damage = self:GetAbility():GetSpecialValueFor( "guitar_bonus_damage" )
end

function modifier_roma_play_guitar:DeclareFunctions()
	local funcs = {
                MODIFIER_EVENT_ON_ATTACK_LANDED,
                MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE,
	}
	return funcs
end

-- Спрять с панели Бафов, если ноль стаков способности
function modifier_roma_play_guitar:IsHidden()
        return ( self:GetStackCount() == 0 )
end

-- Если атака успешная
function modifier_roma_play_guitar:OnAttackLanded( param )
        if param.attacker == self:GetParent()  and (not self:GetParent():IsIllusion()) then
                if self:GetStackCount() == 0 then
                        self:StartIntervalThink(self.guitar_tick)
                        self:OnIntervalThink()
                end

                if self:GetStackCount() >= self.guitar_attack_count then
                        self:SetStackCount(0)
                else
                        self:IncrementStackCount()
                end
        end
end

-- Расчет бонусного урона
function modifier_roma_play_guitar:GetModifierProcAttack_BonusDamage_Pure()
        return self.guitar_bonus_damage * self:GetStackCount()
end

function modifier_roma_play_guitar:OnIntervalThink()
        if IsServer() then                
                self:SetDuration(self.guitar_tick, false)
                if self:GetStackCount() > 0 then                        
                        self:DecrementStackCount()
                end
        end
end