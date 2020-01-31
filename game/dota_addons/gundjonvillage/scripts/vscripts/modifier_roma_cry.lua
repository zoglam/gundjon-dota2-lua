modifier_roma_cry = class({})

-- При активации из roma_cry.lua
function modifier_roma_cry:OnCreated( kv )
	self.cry_strength = self:GetAbility():GetSpecialValueFor( "cry_strength" )
	self.cry_damage = self:GetAbility():GetSpecialValueFor( "cry_damage" )
	self.cry_tick = self:GetAbility():GetSpecialValueFor( "cry_tick" )
	if IsServer() then
		local animationCryOnEnemy = "particles/units/heroes/hero_sven/sven_warcry_buff.vpcf"
		local nFXIndex = ParticleManager:CreateParticle(animationCryOnEnemy, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControlEnt( nFXIndex, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_head", self:GetCaster():GetOrigin(), true )
		self:AddParticle( nFXIndex, false, false, -1, false, true )
	end
	self:StartIntervalThink( self.cry_tick )
	self:OnIntervalThink()
end

--------------------------------------------------------------------------------

function modifier_roma_cry:OnRefresh( kv )
	if IsServer() then
		self.cry_strength = self:GetAbility():GetSpecialValueFor( "cry_strength" )
		self.cry_damage = self:GetAbility():GetSpecialValueFor( "cry_damage" )
	end
end

--------------------------------------------------------------------------------

function modifier_roma_cry:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EXTRA_STRENGTH_BONUS,
	}
	return funcs
end

--------------------------------------------------------------------------------

function modifier_roma_cry:GetModifierExtraStrengthBonus()
	return self.cry_strength
end

--------------------------------------------------------------------------------

function modifier_roma_cry:OnIntervalThink()
	if IsServer() then
		local flDamagePerTick = self.cry_tick * self.cry_damage
		if self:GetCaster():IsAlive() then
			local damage = {
				victim = self:GetParent(),
				attacker = self:GetCaster(),
				damage = flDamagePerTick,
				damage_type = DAMAGE_TYPE_PURE,
				ability = self:GetAbility()
			}
			ApplyDamage( damage )
		end
	end
end