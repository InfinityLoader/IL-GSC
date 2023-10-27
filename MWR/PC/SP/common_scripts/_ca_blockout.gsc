/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_ca_blockout.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 210 ms
 * Timestamp: 10/27/2023 2:45:26 AM
*******************************************************************/

//Function Number: 1
init()
{
	common_scripts\utility::flag_init("ca_blockout");
	common_scripts\utility::flag_set("ca_blockout");
	setdvar("bcs_enable",0);
	delete_enemy();
	delete_multiple_trigger();
	delete_battlechatter_trigger();
	delete_flood_spawner_trigger();
	delete_camper_spawner_trigger();
	delete_truckjunk();
	delete_color_volumes();
}

//Function Number: 2
delete_enemy()
{
	var_00 = getspawnerteamarray("axis");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}

	var_04 = getaiarray("axis");
	foreach(var_06 in var_04)
	{
		var_06 delete();
	}
}

//Function Number: 3
delete_multiple_trigger()
{
	var_00 = getentarray("trigger_multiple","code_classname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(var_00[var_01].classname == "trigger_multiple_visionset")
		{
			continue;
		}

		if(isdefined(var_00[var_01].targetname) && var_00[var_01].targetname == "trigger_fog")
		{
			continue;
		}

		if(isdefined(var_00[var_01].script_noteworthy) && var_00[var_01].script_noteworthy == "skip_blockout_delete")
		{
			continue;
		}

		var_00[var_01] delete();
	}
}

//Function Number: 4
delete_battlechatter_trigger()
{
	var_00 = [];
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("trigger_radius","code_classname"));
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("trigger_disk","code_classname"));
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("trigger_multiple","code_classname"));
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("trigger_lookat","code_classname"));
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("trigger_once","code_classname"));
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("trigger_use","code_classname"));
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("trigger_damage","code_classname"));
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isdefined(var_00[var_01].script_bctrigger))
		{
			var_00[var_01] delete();
		}

		if(isdefined(var_00[var_01].script_hint))
		{
			var_00[var_01] delete();
		}
	}
}

//Function Number: 5
delete_flood_spawner_trigger()
{
	var_00 = getentarray("flood_spawner","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 6
delete_camper_spawner_trigger()
{
	var_00 = getentarray("camper_spawner","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 7
delete_fog_trigger()
{
	var_00 = getentarray("trigger_fog","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 8
delete_script_vehicle()
{
	var_00 = getentarray("script_vehicle","code_classname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 9
delete_truckjunk()
{
	var_00 = getentarray("truckjunk","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 10
delete_animated_model()
{
	var_00 = getentarray("animated_model","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 11
delete_interactive_tv()
{
	var_00 = getentarray("interactive_tv","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 12
delete_explodable_barrel()
{
	var_00 = getentarray("explodable_barrel","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 13
delete_color_volumes()
{
	var_00 = getallnodes();
	var_01 = [];
	var_01 = common_scripts\utility::array_combine(var_01,getentarray("trigger_multiple","classname"));
	var_01 = common_scripts\utility::array_combine(var_01,getentarray("trigger_radius","classname"));
	var_01 = common_scripts\utility::array_combine(var_01,getentarray("trigger_once","classname"));
	var_02 = getentarray("info_volume","classname");
	for(var_03 = 0;var_03 < var_00.size;var_03++)
	{
		if(isdefined(var_00[var_03].script_color_allies) || isdefined(var_00[var_03].script_color_axis))
		{
			var_00[var_03] disconnectnode();
		}
	}

	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(isdefined(var_01[var_03].script_color_allies) || isdefined(var_01[var_03].script_color_axis))
		{
			var_01[var_03] delete();
		}
	}

	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(isdefined(var_02[var_03].script_color_allies) || isdefined(var_02[var_03].script_color_axis))
		{
			var_02[var_03] delete();
		}
	}
}