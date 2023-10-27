/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 134.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 2:19:59 AM
*******************************************************************/

//Function Number: 1
func_1455(param_00)
{
	if(!isdefined(level._audio))
	{
		level._audio = spawnstruct();
	}

	level._audio.var_1457 = spawnstruct();
	level._audio.var_1457.use_string_table_presets = 0;
	level._audio.var_1457.use_iw_presets = 0;
	level._audio.var_1457.var_145A = "";
}

//Function Number: 2
func_145B()
{
	level._audio.var_1457.use_string_table_presets = 1;
	level._audio.var_1457.use_iw_presets = 0;
}

//Function Number: 3
func_145C()
{
	level._audio.var_1457.use_iw_presets = 1;
	level._audio.var_1457.use_string_table_presets = 0;
}

//Function Number: 4
func_145D(param_00,param_01)
{
	param_01 = clamp(param_01,0,1);
	param_00.var_145E = param_01;
}

//Function Number: 5
func_145F(param_00,param_01)
{
	param_01 = clamp(param_01,0,1);
	param_00.var_1460 = param_01;
}

//Function Number: 6
func_1461(param_00,param_01)
{
	if(!isdefined(level._audio.var_1457.var_1462) || level._audio.var_1457.var_1462 != param_00)
	{
		level._audio.var_1457.var_1462 = param_00;
		var_02 = undefined;
		if(isdefined(param_01))
		{
			var_02 = param_01;
		}
		else
		{
			var_02 = param_00.var_1463;
		}

		level.player setreverb(param_00.priority,param_00.var_1464,param_00.var_145E,param_00.var_1460,var_02);
	}
}

//Function Number: 7
func_1465(param_00,param_01)
{
	if(level.player maps\_utility::ent_flag("player_has_red_flashing_overlay"))
	{
		if(isdefined(param_00) && param_00 != "none")
		{
			var_02 = func_1472(param_00);
			if(!isdefined(var_02))
			{
				maps\_audio::aud_print_warning("Failed to load reverb preset: " + param_00);
				return;
			}

			if(param_00 != "deathsdoor")
			{
				func_1468(param_00,var_02);
				level._audio.var_1467.var_1457 = param_00;
			}
		}
		else
		{
			func_1468("none",undefined);
			level._audio.var_1467.var_1457 = "none";
		}

		return;
	}

	if(((isdefined(param_00) && param_00 == "none") || !isdefined(param_00)) && isdefined(level._audio.var_145A))
	{
		level.player deactivatereverb("snd_enveffectsprio_level",1);
		level._audio.var_145A = undefined;
		level._audio.var_1457.var_145A = "";
		return;
	}
	else if(!isdefined(param_00) || isdefined(param_00) && param_00 == "none")
	{
		return;
	}

	var_02 = func_1472(param_00);
	if(!isdefined(var_02))
	{
		maps\_audio::aud_print_warning("Failed to load reverb preset: " + param_00);
		return;
	}

	level._audio.var_145A = param_00;
	if(param_00 != "deathsdoor")
	{
		func_1468(param_00,var_02);
	}

	if(level._audio.var_1457.var_145A != param_00)
	{
		level._audio.var_1457.var_145A = param_00;
		func_1461(var_02,param_01);
	}
}

//Function Number: 8
func_1468(param_00,param_01)
{
	if(param_00 != "deathsdoor")
	{
		level.reverb_track = param_00;
		if(param_00 == "none" && !isdefined(level.ambient_reverb["none"]))
		{
			level.ambient_reverb["none"] = 1;
			return;
		}

		if(!isdefined(level.ambient_reverb[param_00]))
		{
			level.ambient_reverb[param_00] = [];
			level.ambient_reverb[param_00]["priority"] = "snd_enveffectsprio_level";
			level.ambient_reverb[param_00]["roomtype"] = param_01.var_1464;
			level.ambient_reverb[param_00]["drylevel"] = param_01.var_145E;
			level.ambient_reverb[param_00]["wetlevel"] = param_01.var_1460;
			level.ambient_reverb[param_00]["fadetime"] = param_01.var_1463;
			return;
		}
	}
}

//Function Number: 9
func_146B()
{
	level.reverb_track = "";
	level.player deactivatereverb("snd_enveffectsprio_level",2);
	level._audio.var_145A = undefined;
	level._audio.var_1457.var_145A = "";
}

//Function Number: 10
func_146C()
{
	var_00 = undefined;
	if(isdefined(level._audio.var_1457.var_1462))
	{
		var_00 = level._audio.var_1457.var_1462;
	}

	return var_00;
}

//Function Number: 11
func_146D(param_00,param_01)
{
	var_02 = maps\_audio::get_reverb_stringtable();
	var_03 = "soundtables/common_reverb.csv";
	var_04 = [];
	if(param_01)
	{
		var_04 = func_146F(var_02,param_00);
	}

	if(!isdefined(var_04) || var_04.size == 0)
	{
		var_04 = func_146F(var_03,param_00);
	}

	if(!isdefined(var_04) || var_04.size == 0)
	{
		return;
	}

	return var_04;
}

//Function Number: 12
func_146F(param_00,param_01)
{
	var_02 = [];
	var_03 = "";
	var_04 = "";
	var_05 = 6;
	for(var_06 = 1;var_06 < var_05;var_06++)
	{
		var_03 = tablelookup(param_00,0,"reverb_names",var_06);
		var_04 = tablelookup(param_00,0,param_01,var_06);
		if(var_03 != "comments" && var_04 != "")
		{
			if(var_03 != "roomtype")
			{
				var_02[var_03] = float(var_04);
				continue;
			}

			var_02[var_03] = var_04;
		}
	}

	return var_02;
}

//Function Number: 13
func_1470()
{
	while(!isdefined(level.player))
	{
		wait 0.5;
	}

	func_1461(level._audio.var_1457.var_1471);
}

//Function Number: 14
func_1472(param_00)
{
	if(!isdefined(level._audio.var_1457.preset_cache))
	{
		level._audio.var_1457.preset_cache = [];
	}

	var_01 = func_1476();
	var_02 = [];
	if(isdefined(level._audio.level_audio_filter_function))
	{
		var_02 = [[ level._audio.level_audio_filter_function ]](param_00,var_02);
	}
	else if(isdefined(level._audio.var_1457.preset_cache[param_00]))
	{
		var_02 = level._audio.var_1457.preset_cache[param_00];
	}
	else if(level._audio.var_1457.use_string_table_presets)
	{
		var_02 = func_146D(param_00,1);
		if(!isdefined(var_02))
		{
			return;
		}

		level._audio.var_1457.preset_cache[param_00] = var_02;
	}
	else
	{
		var_02 = func_146D(param_00,0);
		if(!isdefined(var_02) || var_02.size == 0)
		{
			var_02 = maps\_audio::audio_presets_reverb(param_00,var_02);
		}

		if(!isdefined(var_02))
		{
			return;
		}

		level._audio.var_1457.preset_cache[param_00] = var_02;
	}

	var_01.name = param_00;
	var_01.var_1464 = var_02["roomtype"];
	var_01.var_145E = var_02["drylevel"];
	var_01.var_1460 = var_02["wetlevel"];
	var_01.var_1463 = var_02["fadetime"];
	return var_01;
}

//Function Number: 15
func_1476()
{
	var_00 = spawnstruct();
	var_00.var_1464 = "generic";
	var_00.var_145E = 1;
	var_00.var_1460 = 0.5;
	var_00.var_1463 = 0;
	var_00.priority = "snd_enveffectsprio_level";
	return var_00;
}