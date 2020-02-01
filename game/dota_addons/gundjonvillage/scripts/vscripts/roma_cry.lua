roma_cry = class({})
LinkLuaModifier("modifier_roma_cry", LUA_MODIFIER_MOTION_NONE)

-- Когда время каста пройдет
function roma_cry:OnChannelFinish( bInterrupted )
	if not bInterrupted then
		local caster = self:GetCaster()
		local cry_radius = self:GetSpecialValueFor( "cry_radius" ) 
		local cry_duration = self:GetSpecialValueFor( "cry_duration" )	
		local enemy = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetOrigin(), caster, cry_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		if #enemy > 0 then
			for _,enemy in pairs(enemy) do
				enemy:AddNewModifier( caster, self, "modifier_roma_cry", { duration = cry_duration } )
			end
		end
		local casterPosition = caster:GetAbsOrigin()
		local animationCryOnCaster = "particles/units/heroes/hero_slardar/slardar_crush_drops.vpcf"
		local nFXIndex = ParticleManager:CreateParticle(animationCryOnCaster, PATTACH_ABSORIGIN, caster )
		ParticleManager:SetParticleControlEnt( nFXIndex, 0, caster, PATTACH_ABSORIGIN, "attach_origin", casterPosition, true )
		ParticleManager:ReleaseParticleIndex( nFXIndex )
		EmitSoundOn( "gundjonvillage.cry", caster ) -- Звук проиграть
		FindClearRandomPositionAroundUnit(caster, caster, cry_radius) -- Random телепорт героя
	end
end

-- Время каста выставить
function roma_cry:GetChannelTime()		
	local cry_castTime = self:GetSpecialValueFor("cry_castTime")
	return cry_castTime
end