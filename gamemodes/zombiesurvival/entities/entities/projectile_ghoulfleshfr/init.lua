INC_SERVER()

function ENT:Hit(vHitPos, vHitNormal, eHitEntity)
	if self.Exploded then return end
	self.Exploded = true
	self.DeathTime = 0

	local owner = self:GetOwner()
	if not owner:IsValid() then owner = self end

	vHitPos = vHitPos or self:GetPos()
	vHitNormal = vHitNormal or Vector(0, 0, 1)

	if eHitEntity:IsValidLivingPlayer() and gamemode.Call("PlayerShouldTakeDamage", eHitEntity, owner) then
		local frost = math.Round( 5 * (GAMEMODE.ZombieProjEffectsMul or 1))
		eHitEntity:GiveStatus("frost", frost)

		local dimvision = math.Round( 3 * (GAMEMODE.ZombieProjEffectsMul or 1))
		eHitEntity:GiveStatus("dimvision", dimvision)

		local armDamage = math.Round( 18 * (GAMEMODE.ZombieProjHitDamageMul or 1))
		eHitEntity:AddArmDamage(armDamage)
	end

	local effectdata = EffectData()
		effectdata:SetOrigin(vHitPos)
		effectdata:SetNormal(vHitNormal)
	util.Effect("hit_frost", effectdata)
end
