INC_SERVER()

function SWEP:ApplyMeleeDamage(ent, trace, damage)
	if ent:IsPlayer() then
		ent:GiveStatus("dimvision", math.Round(6 * (GAMEMODE.ZombieHitEffectsMul or 1)))
		local gt = ent:GiveStatus("frost", math.Round(8 * (GAMEMODE.ZombieHitEffectsMul or 1)))
		local owner = self:GetOwner()

		if gt and gt:IsValid() then
			gt.Applier = owner
		end
		ent:AddLegDamageExt(math.Round(12 * (GAMEMODE.ZombieHitEffectsMul or 1)), owner, self, SLOWTYPE_COLD)
	end

	self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage)
end
