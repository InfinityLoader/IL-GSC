/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_audio_reverb.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 15
 * Decompile Time: 251 ms
 * Timestamp: 10/27/2023 2:33:05 AM
*******************************************************************/

//Function Number: 1
rvb_init(param_00)
{
	if(!isdefined(level._audio))
	{
		level._audio = spawnstruct();
	}

	level._audio.reverb = spawnstruct();
	level._audio.reverb.use_string_table_presets = 0;
	level._audio.reverb.use_iw_presets = 0;
	level._audio.reverb.current_reverb = "";
}

//Function Number: 2
rvb_use_string_table()
{
	level._audio.reverb.use_string_table_presets = 1;
	level._audio.reverb.use_iw_presets = 0;
}

//Function Number: 3
rvb_use_iw_presets()
{
	level._audio.reverb.use_iw_presets = 1;
	level._audio.reverb.use_string_table_presets = 0;
}

//Function Number: 4
rvb_set_dry_level(param_00,param_01)
{
	param_01 = clamp(param_01,0,1);
	param_00.drylevel = param_01;
}

//Function Number: 5
rvb_set_wet_level(param_00,param_01)
{
	param_01 = clamp(param_01,0,1);
	param_00.wetlevel = param_01;
}

//Function Number: 6
rvb_apply_reverb(param_00,param_01)
{
	if(!isdefined(level._audio.reverb.applied_reverb) || level._audio.reverb.applied_reverb != param_00)
	{
		level._audio.reverb.applied_reverb = param_00;
		var_02 = undefined;
		if(isdefined(param_01))
		{
			var_02 = param_01;
		}
		else
		{
			var_02 = param_00.fadetime;
		}

		level.player setreverb(param_00.priority,param_00.roomtype,param_00.drylevel,param_00.wetlevel,var_02);
	}
}

//Function Number: 7
rvb_start_preset(param_00,param_01)
{
	if(level.player maps\_utility::ent_flag("player_has_red_flashing_overlay"))
	{
		if(isdefined(param_00) && param_00 != "none")
		{
			var_02 = func_103A(param_00);
			if(!isdefined(var_02))
			{
				maps\_audio::aud_print_warning("Failed to load reverb preset: " + param_00);
				return;
			}

			if(param_00 != "deathsdoor")
			{
				rvbx_store_current_reverb_track(param_00,var_02);
				level._audio.deathsdoor.reverb = param_00;
			}
		}
		else
		{
			rvbx_store_current_reverb_track("none",undefined);
			level._audio.deathsdoor.reverb = "none";
		}

		return;
	}

	if(((isdefined(param_00) && param_00 == "none") || !isdefined(param_00)) && isdefined(level._audio.current_reverb))
	{
		level.player deactivatereverb("snd_enveffectsprio_level",1);
		level._audio.current_reverb = undefined;
		level._audio.reverb.current_reverb = "";
		return;
	}
	else if(!isdefined(param_00) || isdefined(param_00) && param_00 == "none")
	{
		return;
	}

	var_02 = func_103A(param_00);
	if(!isdefined(var_02))
	{
		maps\_audio::aud_print_warning("Failed to load reverb preset: " + param_00);
		return;
	}

	level._audio.current_reverb = param_00;
	if(param_00 != "deathsdoor")
	{
		rvbx_store_current_reverb_track(param_00,var_02);
	}

	if(level._audio.reverb.current_reverb != param_00)
	{
		level._audio.reverb.current_reverb = param_00;
		rvb_apply_reverb(var_02,param_01);
	}
}

//Function Number: 8
rvbx_store_current_reverb_track(param_00,param_01)
{
	if(param_00 != "deathsdoor")
	{
		level.var_1031 = param_00;
		if(param_00 == "none" && !isdefined(level.ambient_reverb["none"]))
		{
			level.ambient_reverb["none"] = 1;
			return;
		}

		if(!isdefined(level.ambient_reverb[param_00]))
		{
			level.ambient_reverb[param_00] = [];
			level.ambient_reverb[param_00]["priority"] = "snd_enveffectsprio_level";
			level.ambient_reverb[param_00]["roomtype"] = param_01.roomtype;
			level.ambient_reverb[param_00]["drylevel"] = param_01.drylevel;
			level.ambient_reverb[param_00]["wetlevel"] = param_01.wetlevel;
			level.ambient_reverb[param_00]["fadetime"] = param_01.fadetime;
			return;
		}
	}
}

//Function Number: 9
rvb_deactive_reverb()
{
	level.var_1031 = "";
	level.player deactivatereverb("snd_enveffectsprio_level",2);
	level._audio.current_reverb = undefined;
	level._audio.reverb.current_reverb = "";
}

//Function Number: 10
rvb_get_applied_reverb()
{
	var_00 = undefined;
	if(isdefined(level._audio.reverb.applied_reverb))
	{
		var_00 = level._audio.reverb.applied_reverb;
	}

	return var_00;
}

//Function Number: 11
rvbx_get_preset_from_string_table(param_00,param_01)
{
	var_02 = maps\_audio::get_reverb_stringtable();
	var_03 = "soundtables/common_reverb.csv";
	var_04 = [];
	if(param_01)
	{
		var_04 = rvbx_get_reverb_preset_from_stringtable_internal(var_02,param_00);
	}

	if(!isdefined(var_04) || var_04.size == 0)
	{
		var_04 = rvbx_get_reverb_preset_from_stringtable_internal(var_03,param_00);
	}

	if(!isdefined(var_04) || var_04.size == 0)
	{
		return;
	}

	return var_04;
}

//Function Number: 12
rvbx_get_reverb_preset_from_stringtable_internal(param_00,param_01)
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
rvbx_apply_inital_reverb()
{
	while(!isdefined(level.player))
	{
		wait 0.5;
	}

	rvb_apply_reverb(level._audio.reverb.var_1039);
}

//Function Number: 14
func_103A(param_00)
{
	if(!isdefined(level._audio.reverb.preset_cache))
	{
		level._audio.reverb.preset_cache = [];
	}

	var_01 = rvbx_create();
	var_02 = [];
	if(isdefined(level._audio.var_103C))
	{
		var_02 = [[ level._audio.var_103C ]](param_00,var_02);
	}
	else if(isdefined(level._audio.reverb.preset_cache[param_00]))
	{
		var_02 = level._audio.reverb.preset_cache[param_00];
	}
	else if(level._audio.reverb.use_string_table_presets)
	{
		var_02 = rvbx_get_preset_from_string_table(param_00,1);
		if(!isdefined(var_02))
		{
			return;
		}

		level._audio.reverb.preset_cache[param_00] = var_02;
	}
	else
	{
		var_02 = rvbx_get_preset_from_string_table(param_00,0);
		if(!isdefined(var_02) || var_02.size == 0)
		{
			var_02 = maps\_audio::audio_presets_reverb(param_00,var_02);
		}

		if(!isdefined(var_02))
		{
			return;
		}

		level._audio.reverb.preset_cache[param_00] = var_02;
	}

	var_01.name = param_00;
	var_01.roomtype = var_02["roomtype"];
	var_01.drylevel = var_02["drylevel"];
	var_01.wetlevel = var_02["wetlevel"];
	var_01.fadetime = var_02["fadetime"];
	return var_01;
}

//Function Number: 15
rvbx_create()
{
	var_00 = spawnstruct();
	var_00.roomtype = "generic";
	var_00.drylevel = 1;
	var_00.wetlevel = 0.5;
	var_00.fadetime = 0;
	var_00.priority = "snd_enveffectsprio_level";
	return var_00;
}