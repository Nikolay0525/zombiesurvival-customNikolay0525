INC_SERVER()

function SWEP:ApplyMeleeDamage(ent, trace, damage)
	if ent:IsPlayer() then
		ent:GiveStatus("dimvision", math.Round(2.5 * (GAMEMODE.ZombieHitEffectsMul or 1)))
	end

	self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage)
end
