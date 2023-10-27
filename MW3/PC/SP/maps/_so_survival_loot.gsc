/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_so_survival_loot.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 283 ms
 * Timestamp: 10/27/2023 2:21:07 AM
*******************************************************************/

//Function Number: 1
loot_preload()
{
	for(var_00 = 0;var_00 <= 20;var_00++)
	{
		var_01 = get_loot_ref_by_index(var_00);
		if(isdefined(var_01) && get_loot_type(var_01) == "weapon")
		{
			maps\_so_survival_code::precache_loadout_item(var_01);
		}
	}

	for(var_00 = 100;var_00 <= 199;var_00++)
	{
		var_02 = get_loot_version_by_index(var_00);
		if(isdefined(var_02))
		{
			maps\_so_survival_code::precache_loadout_item(var_02);
		}
	}
}

//Function Number: 2
loot_postload()
{
}

//Function Number: 3
loot_init()
{
	loot_populate(0,20,100,199);
}

//Function Number: 4
loot_populate(param_00,param_01,param_02,param_03)
{
	level.loot_version_array = [];
	for(var_04 = param_02;var_04 <= param_03;var_04++)
	{
		var_05 = get_loot_version_by_index(var_04);
		if(isdefined(var_05) && var_05 != "")
		{
			level.loot_version_array[level.loot_version_array.size] = var_05;
		}
	}

	level.loot_info_array = [];
	for(var_04 = param_00;var_04 <= param_01;var_04++)
	{
		var_06 = get_loot_ref_by_index(var_04);
		if(!isdefined(var_06) || var_06 == "")
		{
			continue;
		}

		var_07 = get_loot_type(var_06);
		if(!isdefined(level.loot_info_array[var_07]))
		{
			level.loot_info_array[var_07] = [];
		}

		var_08 = spawnstruct();
		var_08.index = var_04;
		var_08.ref = var_06;
		var_08.type = var_07;
		var_08.name = get_loot_name(var_06);
		var_08.var_189B = get_loot_desc(var_06);
		var_08.chance = get_loot_chance(var_06);
		var_08.wave_unlock = get_loot_wave_unlock(var_06);
		var_08.wave_lock = get_loot_wave_lock(var_06);
		var_08.wave_dropped = -999;
		var_08.rank = get_loot_rank(var_06);
		var_08.versions = get_loot_versions(var_06);
		level.loot_info_array[var_07][var_06] = var_08;
	}
}

//Function Number: 5
loot_roll(param_00)
{
	if(!isdefined(level.loot_info_array) || !isdefined(level.loot_info_array["weapon"]))
	{
		return 0;
	}

	var_01 = [];
	foreach(var_03 in level.loot_info_array["weapon"])
	{
		if(level.current_wave >= var_03.wave_unlock && level.current_wave < var_03.wave_lock && level.current_wave - var_03.wave_dropped >= 2 && maps\_so_survival_code::highest_player_rank() >= var_03.rank)
		{
			var_01[var_01.size] = var_03;
		}
	}

	if(!var_01.size)
	{
		return 0;
	}

	var_01 = maps\_utility_joec::exchange_sort_by_handler(var_01,::loot_roll_compare_type_wave_dropped);
	var_05 = undefined;
	foreach(var_03 in var_01)
	{
		var_07 = common_scripts\utility::ter_op(isdefined(param_00),param_00,var_03.chance);
		if(var_07 > randomfloatrange(0,1))
		{
			var_05 = var_03.versions[randomint(var_03.versions.size)];
			var_03.wave_dropped = level.current_wave;
			break;
		}
	}

	if(isdefined(var_05))
	{
		var_09 = var_05;
		var_0A = getweaponmodel(var_09);
		self.dropweapon = 0;
		thread loot_drop_on_death("weapon_" + var_09,var_09,"weapon",var_0A,"tag_stowed_back");
		return 1;
	}

	return 0;
}

//Function Number: 6
loot_roll_compare_type_wave_dropped()
{
	var_00 = common_scripts\utility::ter_op(isdefined(self) && isdefined(self.wave_dropped),self.wave_dropped,-999);
	return var_00;
}

//Function Number: 7
loot_drop_on_death(param_00,param_01,param_02,param_03,param_04)
{
	level endon("special_op_terminated");
	var_05 = spawn("script_model",self gettagorigin(param_04));
	var_05 setmodel(param_03);
	var_05 linkto(self,param_04,(0,0,0),(0,0,0));
	common_scripts\utility::waittill_any("death","long_death");
	if(!isdefined(self))
	{
		return;
	}

	var_06 = spawn(param_00,self gettagorigin(param_04));
	if(isdefined(param_02) && param_02 == "weapon")
	{
		var_07 = int(max(1,0.4 * weaponclipsize(param_01)));
		var_08 = int(max(1,0.5 * weaponmaxammo(param_01)));
		var_06 itemweaponsetammo(var_07,var_08);
		var_09 = weaponaltweaponname(param_01);
		if(var_09 != "none")
		{
			var_0A = int(max(1,0.5 * weaponclipsize(var_09)));
			var_0B = int(max(1,0.5 * weaponmaxammo(var_09)));
			var_06 itemweaponsetammo(var_0A,var_0B,var_0A,1);
		}
	}

	var_05 unlink();
	wait 0.05;
	var_05 delete();
}

//Function Number: 8
loot_item_exist(param_00)
{
	return isdefined(level.loot_info_array) && isdefined(level.loot_info_array[param_00]);
}

//Function Number: 9
get_loot_ref_by_index(param_00)
{
	return get_ref_by_index(param_00);
}

//Function Number: 10
get_ref_by_index(param_00)
{
	return tablelookup("sp/survival_loot.csv",0,param_00,1);
}

//Function Number: 11
get_loot_type(param_00)
{
	if(loot_item_exist(param_00))
	{
		return level.loot_info_array[param_00].type;
	}

	return tablelookup("sp/survival_loot.csv",1,param_00,2);
}

//Function Number: 12
get_loot_name(param_00)
{
	if(loot_item_exist(param_00))
	{
		return level.loot_info_array[param_00].name;
	}

	return tablelookup("sp/survival_loot.csv",1,param_00,3);
}

//Function Number: 13
get_loot_desc(param_00)
{
	if(loot_item_exist(param_00))
	{
		return level.loot_info_array[param_00].var_189B;
	}

	return tablelookup("sp/survival_loot.csv",1,param_00,4);
}

//Function Number: 14
get_loot_chance(param_00)
{
	if(loot_item_exist(param_00))
	{
		return level.loot_info_array[param_00].chance;
	}

	return float(tablelookup("sp/survival_loot.csv",1,param_00,5));
}

//Function Number: 15
get_loot_wave_unlock(param_00)
{
	if(loot_item_exist(param_00))
	{
		return level.loot_info_array[param_00].wave_unlock;
	}

	return int(tablelookup("sp/survival_loot.csv",1,param_00,6));
}

//Function Number: 16
get_loot_wave_lock(param_00)
{
	if(loot_item_exist(param_00))
	{
		return level.loot_info_array[param_00].wave_lock;
	}

	return int(tablelookup("sp/survival_loot.csv",1,param_00,7));
}

//Function Number: 17
get_loot_rank(param_00)
{
	if(loot_item_exist(param_00))
	{
		return level.loot_info_array[param_00].rank;
	}

	return int(tablelookup("sp/survival_loot.csv",1,param_00,8));
}

//Function Number: 18
get_loot_version_by_index(param_00)
{
	return get_ref_by_index(param_00);
}

//Function Number: 19
get_loot_versions(param_00)
{
	if(loot_item_exist(param_00))
	{
		return level.loot_info_array[param_00].versions;
	}

	var_01 = "joe";
	var_02 = [];
	var_03 = param_00;
	if(get_loot_type(param_00) == "weapon")
	{
		var_03 = getsubstr(param_00,0,param_00.size - 3);
	}

	foreach(var_05 in level.loot_version_array)
	{
		if(issubstr(var_05,var_03))
		{
			var_02[var_02.size] = var_05;
		}
	}

	if(!var_02.size)
	{
		var_02[var_02.size] = param_00;
	}

	return var_02;
}