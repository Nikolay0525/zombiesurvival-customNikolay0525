AddCSLuaFile()

SWEP.Base = "weapon_zs_zombie"

SWEP.PrintName = "Zombie Torso"

SWEP.MeleeDelay = 0.25
SWEP.MeleeReach = 40
SWEP.MeleeDamage = math.Round(25 * (GAMEMODE.ZombieOverallDamageMul or 1))
SWEP.SwingAnimSpeed = 2.96

SWEP.DelayWhenDeployed = true

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
