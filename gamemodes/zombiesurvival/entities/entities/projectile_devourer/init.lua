INC_SERVER()

local vector_origin = vector_origin

function ENT:Initialize()
	self:SetModel("models/gibs/HGIBS_rib.mdl")
	self:PhysicsInitSphere(13)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetModelScale(2.2, 0)
	self:SetupGenericProjectile(false)

	self.DieTime = CurTime() + 1.1
	self.LastPhysicsUpdate = UnPredictedCurTime()
end

function ENT:PhysicsUpdate(phys)
	if not self.InitVelocity then self.InitVelocity = self:GetVelocity() end

	local dt = (UnPredictedCurTime() - self.LastPhysicsUpdate)
	self.LastPhysicsUpdate = UnPredictedCurTime()

	phys:AddVelocity(self.InitVelocity * dt * -1.8)
end

function ENT:Think()
	if self.PhysicsData then
		self:Hit(self.PhysicsData.HitPos, self.PhysicsData.HitNormal, self.PhysicsData.HitEntity)
	end

	if self.Exploded then
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	elseif self.DieTime < CurTime() then
		self:Remove()
	end
end

function ENT:OnRemove()
	local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
	util.Effect("explosion_bonemesh", effectdata)
end

function ENT:Hit(vHitPos, vHitNormal, ent)
	if self.Exploded then return end

	local owner = self:GetOwner()
	if not owner:IsValid() then owner = self end

	vHitPos = vHitPos or self:GetPos()
	vHitNormal = vHitNormal or Vector(0, 0, 1)

	if ent:IsValid() then
		if (ent.BeingControlled or ent:IsValidLivingHuman()) and owner:IsPlayer() then
			if ent:IsValidLivingHuman() then
				self.Exploded = true
				local specialDamage = math.Round( 8 * (GAMEMODE.ZombieProjHitDamageMul or 1))
				ent:TakeSpecialDamage(specialDamage, DMG_GENERIC, owner, self)
				ent:KnockDown(nil, true)

				local status = ent:GiveStatus("devourer")
				if status and status:IsValid() then
					local trinketDamage = math.Round( 5 * (GAMEMODE.ZombieProjHitDamageMul or 1))
					local notrinketDamage = math.Round( 15 * (GAMEMODE.ZombieProjHitDamageMul or 1))
					status:SetDamage(ent:HasTrinket("analgestic") and trinketDamage or notrinketDamage)
					status:SetPuller(owner)
					self:SetParent(status)
				end

				self:GetPhysicsObject():SetVelocityInstantaneous(vector_origin)
			else
				local vel = owner:GetAimVector() * -2000
				ent:GetPhysicsObject():SetVelocity(vel)
			end
		end
	end
end

function ENT:PhysicsCollide(data, phys)
	self.PhysicsData = data
	self:NextThink(CurTime())
end
