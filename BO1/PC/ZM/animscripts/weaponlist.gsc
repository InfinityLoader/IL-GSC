#include maps\_utility;
#using_animtree ("generic_human");
usingAutomaticWeapon()
{
	if( self.weapon == "none" || !self animscripts\utility::holdingWeapon() )
	{
		return false;
	}
	if ( weaponIsSemiAuto( self.weapon ) )
	{
		return false;
	}
	if ( weaponIsBoltAction( self.weapon ) )
	{
		return false;
	}
	class = weaponClass( self.weapon );
	if ( class == "rifle" || class == "mg" || class == "smg" )
	{
		return true;
	}
	return false;
}
usingSemiAutoWeapon()
{
	return ( weaponIsSemiAuto( self.weapon ) );
}
autoShootAnimRate()
{
	if ( usingAutomaticWeapon() )
	{
		return 0.1 / weaponFireTime( self.weapon ) * GetDvarFloat( #"scr_ai_auto_fire_rate");
	}
	else
	{
		return 0.2;
	}
}
burstShootAnimRate()
{
	if (usingAutomaticWeapon())
	{
		return 0.16 / weaponFireTime( self.weapon );
	}
	else
	{
		return 0.2;
	}
}
waitAfterShot()
{
	return 0.25;
}
shootAnimTime(semiAutoFire)
{
	if( !usingAutomaticWeapon() || (IsDefined(semiAutofire) && (semiAutofire == true)))
	{
		rand = 0.5 + RandomFloat(1);
		return weaponFireTime( self.weapon ) * rand;
	}
	else
	{
		return weaponFireTime( self.weapon );
	}
}
RefillClip()
{
	assertEX( IsDefined( self.weapon ), "self.weapon is not defined for " + self.model );
	if ( self.weapon == "none" )
	{
		self.bulletsInClip = 0;
		return false;
	}
	if ( weaponClass( self.weapon ) == "rocketlauncher" )
	{
		if ( !self.a.rocketVisible )
		{
			self thread animscripts\combat_utility::showRocketWhenReloadIsDone();
		}
	}
	if ( !IsDefined( self.bulletsInClip ) )
	{
		self.bulletsInClip = weaponClipSize( self.weapon );
	}
	else
	{
		self.bulletsInClip = weaponClipSize( self.weapon );
	}
	assertEX(IsDefined(self.bulletsInClip), "RefillClip failed");
	if ( self.bulletsInClip <= 0 )
	{
		return false;
	}
	else
	{
		return true;
	}
}
precacheWeaponSwitchFx()
{
}
precacheClipFx()
{
	clipEffects = [];
	clipEffects["weapon_m16_clip"] = "weapon/shellejects/fx_clip_m16";
	clipEffects["weapon_ak47_clip"] = "weapon/shellejects/fx_clip_ak47";
	clipEffects["weapon_saw_clip"] = "weapon/shellejects/fx_clip_saw";
	clipEffects["weapon_mp5_clip"] = "weapon/shellejects/fx_clip_mp5";
	clipEffects["weapon_dragunov_clip"]	= "weapon/shellejects/fx_clip_dragunov";
	clipEffects["weapon_g3_clip"] = "weapon/shellejects/fx_clip_g3";
	clipEffects["weapon_g36_clip"] = "weapon/shellejects/fx_clip_g36";
	clipEffects["weapon_m14_clip"] = "weapon/shellejects/fx_clip_m14";
	clipEffects["weapon_ak74u_clip"]	= "weapon/shellejects/fx_clip_ak74u";
	if ( !IsDefined( anim._effect ) )
	{
		anim._effect = [];
	}
	if ( IsDefined( level.weaponClipModels ) )
	{
		for ( i = 0; i < level.weaponClipModels.size; i++ )
		{
			model = level.weaponClipModels[i];
			assert( IsDefined( model ) );
			assert( IsDefined( clipEffects[ model ] ) );
			precacheModel( model );
			anim._effect[ model ] = loadfx( clipEffects[ model ] );
		}
		level.weaponClipModels = undefined;
		level.weaponClipModelsLoaded = true;
	}
	else
	{
	}
}
add_weapon(name, type, time, clipsize, anims)
{
	assert (IsDefined(name));
	assert (IsDefined(type));
	if (!IsDefined(time))
	{
		time = 3.0;
	}
	if (!IsDefined(clipsize))
	{
		time = 1;
	}
	if (!IsDefined(anims))
	{
		anims = "rifle";
	}
	name = tolower(name);
	anim.AIWeapon[name]["type"] =	type;
	anim.AIWeapon[name]["time"] =	time;
	anim.AIWeapon[name]["clipsize"] =	clipsize;
	anim.AIWeapon[name]["anims"] =	anims;
}
addTurret(turret)
{
	anim.AIWeapon[tolower(turret)]["type"] = "turret";
} 