/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_achievements.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 306 ms
 * Timestamp: 10/27/2023 2:45:34 AM
*******************************************************************/

//Function Number: 1
achievements_init()
{
	level thread master_ninja_init();
	level thread retro_shooter_init();
	level thread weapon_master_init();
	level thread i_hate_dogs_init();
}

//Function Number: 2
master_ninja_init()
{
	common_scripts\utility::flag_init("master_ninja_melee_kill");
	common_scripts\utility::flag_init("master_ninja_illegal_kill");
	maps\_utility::add_global_spawn_function("axis",::master_ninja_enemy_spawned);
	common_scripts\utility::array_thread(getaiarray("axis"),::master_ninja_enemy_spawned);
	level thread master_ninja_mission_complete();
}

//Function Number: 3
master_ninja_mission_complete()
{
	level endon("master_ninja_illegal_kill");
	level waittill("achievements_level_complete");
	if(common_scripts\utility::flag("master_ninja_melee_kill") && !common_scripts\utility::flag("master_ninja_illegal_kill"))
	{
		maps\_utility::giveachievement_wrapper("MASTER_NINJA");
	}
}

//Function Number: 4
master_ninja_enemy_spawned()
{
	level endon("master_ninja_illegal_kill");
	self waittill("death",var_00,var_01);
	if(isdefined(var_00) && var_00 == level.player)
	{
		if(var_01 == "MOD_MELEE")
		{
			common_scripts\utility::flag_set("master_ninja_melee_kill");
			return;
		}

		common_scripts\utility::flag_set("master_ninja_illegal_kill");
	}
}

//Function Number: 5
retro_shooter_init()
{
	switch(level.script)
	{
		case "simplecredits":
		case "coup":
		case "aftermath":
		case "ac130":
			break;

		default:
			break;
	}
}

//Function Number: 6
retro_shooter_mission_complete()
{
	level endon("retro_shooter_player_reloaded");
	level waittill("achievements_level_complete");
	maps\_utility::giveachievement_wrapper("RETRO_SHOOTER");
}

//Function Number: 7
weapon_master_init()
{
	var_00 = get_base_weapon_list();
	maps\_utility::add_global_spawn_function("axis",::weapon_master_enemy_spawned);
	common_scripts\utility::array_thread(getaiarray("axis"),::weapon_master_enemy_spawned);
	var_01 = maps\_vehicle_code::_getvehiclespawnerarray();
	common_scripts\utility::array_thread(var_01,::maps\_utility::add_spawn_function,::weapon_master_vehicle_spawned);
	common_scripts\utility::array_thread(vehicle_getarray(),::weapon_master_vehicle_spawned);
	thread weapon_master_barrett();
}

//Function Number: 8
weapon_master_barrett()
{
	if(level.script == "sniperescape")
	{
		common_scripts\utility::waittill_any("weapon_master_barrett_kill","makarov_killed");
		weapon_master_register_kill("barrett");
	}
}

//Function Number: 9
get_base_weapon_list()
{
	var_00 = ["ak47","ak74u","barrett","beretta","c4","claymore","colt45","deserteagle","dragunov","frag","g36c","g3","javelin","m1014","m14","m16","m4","m60e4","mp5","p90","remington700","rpd","rpg","saw","skorpion","stinger","usp","uzi","winchester1200"];
	return var_00;
}

//Function Number: 10
parse_weapon_name(param_00)
{
	var_01 = tolower(param_00);
	var_02 = get_base_weapon_list();
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(issubstr(var_01,var_02[var_03]))
		{
			return var_02[var_03];
		}
	}

	return var_01;
}

//Function Number: 11
weapon_master_enemy_spawned()
{
	self waittill("death",var_00,var_01,var_02);
	if(isdefined(var_00) && var_00 == level.player && isdefined(var_02) && var_01 != "MOD_MELEE")
	{
		weapon_master_register_kill(var_02);
	}
}

//Function Number: 12
weapon_master_vehicle_damaged()
{
	level.weapon_master_explosive = "unknown";
	level.weapon_master_timestamp = 0;
	level.weapon_master_vehicle_id = "unknown";
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06);
		var_07 = "unknown";
		var_04 = tolower(var_04);
		if(var_04 == "mod_explosive" || var_04 == "mod_explosive_splash")
		{
			if(var_00 != 100)
			{
				var_07 = "c4";
			}
		}
		else if(var_04 == "mod_projectile" || var_04 == "mod_projectile_splash")
		{
			if(var_00 >= 900)
			{
				var_07 = "javelin";
			}
			else if(var_00 >= 300)
			{
				if(var_01 == level.player)
				{
					var_07 = "rpg";
				}
			}
		}

		if(var_07 != "unknown")
		{
			level.weapon_master_explosive = var_07;
			level.weapon_master_timestamp = gettime();
			level.weapon_master_vehicle_id = self;
		}
	}
}

//Function Number: 13
weapon_master_vehicle_spawned()
{
	var_00 = self;
	thread weapon_master_vehicle_damaged();
	self waittill("death",var_01,var_02,var_03);
	if(isdefined(var_01) && var_01 == level.player && isdefined(var_03) && var_02 != "MOD_MELEE")
	{
		weapon_master_register_kill(var_03);
		return;
	}

	wait(0.25);
	if(level.weapon_master_explosive == "unknown" || level.weapon_master_vehicle_id != var_00)
	{
		return;
	}

	if(abs(gettime() - level.weapon_master_timestamp) <= 1000)
	{
		weapon_master_register_kill(level.weapon_master_explosive);
	}
}

//Function Number: 14
weapon_master_register_kill(param_00)
{
	param_00 = parse_weapon_name(param_00);
	var_01 = common_scripts\utility::array_find(get_base_weapon_list(),param_00);
	if(!isdefined(var_01))
	{
		return;
	}

	if(common_scripts\utility::flag("has_cheated") || maps\_cheat::is_cheating())
	{
		return;
	}

	if(level.player getlocalplayerprofiledata("sp_weaponMaster",var_01) != "1")
	{
		level.player setlocalplayerprofiledata("sp_weaponMaster",var_01,1);
		updategamerprofileall();
		weapon_master_check_success();
	}
}

//Function Number: 15
weapon_master_check_success()
{
	var_00 = get_base_weapon_list();
	var_01 = [];
	var_02 = 0;
	for(var_03 = 0;var_03 < var_00.size;var_03++)
	{
		var_04 = level.player getlocalplayerprofiledata("sp_weaponMaster",var_03);
		var_01[var_00[var_03]] = var_04;
		if(var_04 == "1")
		{
			var_02++;
		}
	}

	if(var_02 == var_00.size || platform_tracks_progression())
	{
		maps\_utility::giveachievement_wrapper("WEAPON_MASTER");
	}
}

//Function Number: 16
i_hate_dogs_init()
{
	maps\_utility::add_global_spawn_function("axis",::i_hate_dogs_enemy_spawned);
	common_scripts\utility::array_thread(getaiarray("axis"),::i_hate_dogs_enemy_spawned);
}

//Function Number: 17
i_hate_dogs_enemy_spawned()
{
	if(!isdefined(self.classname))
	{
		return;
	}

	if(self.classname != "actor_enemy_dog")
	{
		return;
	}

	self waittill("death",var_00,var_01);
	if(isdefined(var_00) && var_00 == level.player && var_01 == "MOD_MELEE")
	{
		if(common_scripts\utility::flag("has_cheated") || maps\_cheat::is_cheating())
		{
			return;
		}

		var_02 = level.player getlocalplayerprofiledata("sp_iHateDogs");
		var_03 = 20;
		if(var_02 < var_03)
		{
			var_02++;
			level.player setlocalplayerprofiledata("sp_iHateDogs",var_02);
			updategamerprofileall();
			if(var_02 >= var_03 || platform_tracks_progression())
			{
				maps\_utility::giveachievement_wrapper("DOGS_I_HATE_DOGS");
				return;
			}
		}
	}
}

//Function Number: 18
platform_tracks_progression()
{
	return level.xb3 || level.pc;
}