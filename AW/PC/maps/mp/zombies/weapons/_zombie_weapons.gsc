/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\weapons\_zombie_weapons.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 101 ms
 * Timestamp: 4/22/2024 2:13:29 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.zombie_placeable_mine_types = [];
	level.onplayerspawnedweaponsfunc = ::onplayerspawnedfunc;
	maps\mp\zombies\weapons\_zombie_explosive_drone::init();
	maps\mp\zombies\weapons\_zombie_distraction_drone::init();
	maps\mp\zombies\weapons\_zombie_dna_aoe_grenade::init();
	if(isdefined(level.zombieweaponinitfunc))
	{
		[[ level.zombieweaponinitfunc ]]();
	}
}

//Function Number: 2
onplayerspawnedfunc()
{
	thread maps\mp\zombies\weapons\_zombie_explosive_drone::onplayerspawn();
	thread maps\mp\zombies\weapons\_zombie_distraction_drone::onplayerspawn();
	thread maps\mp\zombies\weapons\_zombie_dna_aoe_grenade::onplayerspawn();
	if(isdefined(level.zombieweapononplayerspawnedfunc))
	{
		[[ level.zombieweapononplayerspawnedfunc ]]();
	}
}

//Function Number: 3
addplaceableminetype(param_00)
{
	level.zombie_placeable_mine_types[level.zombie_placeable_mine_types.size] = param_00;
}

//Function Number: 4
isplaceableminetype(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	foreach(var_02 in level.zombie_placeable_mine_types)
	{
		if(var_02 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 5
givegrenadesafterrounds()
{
	foreach(var_01 in level.players)
	{
		var_02 = var_01 getlethalweapon();
		var_03 = var_01 gettacticalweapon();
		var_04 = [var_02,var_03];
		foreach(var_06 in var_04)
		{
			if(var_06 == "none")
			{
				continue;
			}

			var_01 setweaponammoclip(var_06,var_01 getweaponammoclip(var_06) + 1);
		}
	}
}