/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_weapon_utils.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:10:37 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/killstreaks/_killstreaks;

//Function Number: 1
isgrenadelauncherweapon(weapon)
{
	if(getsubstr(weapon,0,3) == "gl_")
	{
		return 1;
	}

	switch(weapon)
	{
		case "china_lake_mp":
		case "xm25_mp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 2
isdumbrocketlauncherweapon(weapon)
{
	switch(weapon)
	{
		case "m220_tow_mp":
		case "rpg_mp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 3
isguidedrocketlauncherweapon(weapon)
{
	switch(weapon)
	{
		case "fhj18_mp":
		case "javelin_mp":
		case "m202_flash_mp":
		case "m72_law_mp":
		case "smaw_mp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 4
isrocketlauncherweapon(weapon)
{
	if(isdumbrocketlauncherweapon(weapon))
	{
		return 1;
	}

	if(isguidedrocketlauncherweapon(weapon))
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
islauncherweapon(weapon)
{
	if(isrocketlauncherweapon(weapon))
	{
		return 1;
	}

	if(isgrenadelauncherweapon(weapon))
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
ishackweapon(weapon)
{
	if(maps/mp/killstreaks/_killstreaks::iskillstreakweapon(weapon))
	{
		return 1;
	}

	if(weapon == "briefcase_bomb_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
ispistol(weapon)
{
	return IsDefined(level.side_arm_array[weapon]);
}

//Function Number: 8
isflashorstunweapon(weapon)
{
	if(IsDefined(weapon))
	{
		switch(weapon)
		{
			case "concussion_grenade_mp":
			case "flash_grenade_mp":
			case "proximity_grenade_aoe_mp":
			case "proximity_grenade_mp":
				return 1;
		}
	}

	return 0;
}

//Function Number: 9
isflashorstundamage(weapon,meansofdeath)
{
	return isflashorstunweapon(weapon) && meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_GAS";
}