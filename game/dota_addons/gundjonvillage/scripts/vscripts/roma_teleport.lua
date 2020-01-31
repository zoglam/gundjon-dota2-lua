roma_teleport = class({})

-- Когда время каста пройдет
function roma_teleport:OnChannelFinish( bInterrupted )
    if not bInterrupted then
        local caster = self:GetCaster()
        local point = self:GetCursorPosition()
        FindClearSpaceForUnit(caster, point, true) -- Телепортировать в точку point
    else -- Если прервана способность
        self:RefundManaCost() -- Вернуть потраченную ману
        self:EndCooldown() -- Обновить кулдаун        
    end
end

-- Задать время применения способности
function roma_teleport:GetChannelTime()		
	local teleport_castTime = self:GetSpecialValueFor("teleport_castTime")
	return teleport_castTime
end