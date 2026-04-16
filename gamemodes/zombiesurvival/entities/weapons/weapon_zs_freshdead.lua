AddCSLuaFile()

SWEP.Base = "weapon_zs_zombie"

SWEP.PrintName = "Fresh Dead"

SWEP.MeleeDamage = math.Round(20 * (GAMEMODE.ZombieOverallDamageMul or 1))

function SWEP:Reload()
	self:SecondaryAttack()
end

function SWEP:StartMoaning()
end

function SWEP:StopMoaning()
end

function SWEP:IsMoaning()
	return false
end
