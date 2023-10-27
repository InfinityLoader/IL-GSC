/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: soundscripts/_snd.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 266 ms
 * Timestamp: 10/27/2023 2:05:53 AM
*******************************************************************/

//Function Number: 1
snd_init()
{
	if(!isdefined(level._snd))
	{
		level._snd = spawnstruct();
		level._snd.guid = 0;
		level._snd.default_vid_log_vol = 1;
		thread snd_init_done();
		snd_debug_init();
		soundscripts\_snd_hud::snd_hud_init();
		snd_set_soundtable_name(level.script);
		soundscripts\_snd_filters::snd_load_dsp_buses();
		soundscripts\_snd_filters::snd_filters_init();
		soundscripts\_snd_timescale::snd_timescale_init();
		soundscripts\_snd_foley::snd_foley_init();
		snd_message_init();
		soundscripts\_snd_common::snd_common_init();
	}
}

//Function Number: 2
snd_init_done()
{
	level._snd.is_first_frame = 1;
	waittillframeend;
	level._snd.is_first_frame = 0;
}

//Function Number: 3
snd_is_first_frame()
{
	return level._snd.is_first_frame;
}

//Function Number: 4
snd_message_init()
{
	level._snd.messages = [];
}

//Function Number: 5
snd_register_message(param_00,param_01)
{
	level._snd.messages[param_00] = param_01;
}

//Function Number: 6
snd_music_message(param_00,param_01,param_02)
{
	level notify("stop_other_music");
	level endon("stop_other_music");
	if(isdefined(param_02))
	{
		childthread snd_message("snd_music_handler",param_00,param_01,param_02);
		return;
	}

	if(isdefined(param_01))
	{
		childthread snd_message("snd_music_handler",param_00,param_01);
		return;
	}

	childthread snd_message("snd_music_handler",param_00);
}

//Function Number: 7
snd_message(param_00,param_01,param_02,param_03)
{
	if(isdefined(level._snd.messages[param_00]))
	{
		if(isdefined(param_03))
		{
			thread [[ level._snd.messages[param_00] ]](param_01,param_02,param_03);
			return;
		}

		if(isdefined(param_02))
		{
			thread [[ level._snd.messages[param_00] ]](param_01,param_02);
			return;
		}

		if(isdefined(param_01))
		{
			thread [[ level._snd.messages[param_00] ]](param_01);
			return;
		}

		thread [[ level._snd.messages[param_00] ]]();
		return;
	}
}

//Function Number: 8
snd_println(param_00)
{
}

//Function Number: 9
snd_printlnbold(param_00)
{
}

//Function Number: 10
snd_get_tagarg(param_00,param_01)
{
	var_02 = undefined;
	if(isarray(param_01))
	{
		var_02 = param_01[param_00];
	}

	return var_02;
}

//Function Number: 11
snd_get_secs()
{
	return gettime() * 0.001;
}

//Function Number: 12
snd_new_guid()
{
	level._snd.guid++;
	return level._snd.guid;
}

//Function Number: 13
snd_map(param_00,param_01)
{
	return piecewiselinearlookup(param_00,param_01);
}

//Function Number: 14
snd_flash_white()
{
	var_00 = newhudelem();
	var_00.x = 0;
	var_00.y = 0;
	var_00 setshader("white",640,480);
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.sort = 1;
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.alpha = 1;
	var_00.foreground = 1;
	wait(0.05);
	var_00 destroy();
}

//Function Number: 15
snd_slate(param_00)
{
}

//Function Number: 16
snd_throttle_wait()
{
	if(self.count >= self.max_calls_per_frame)
	{
		wait(0.05);
	}
	else
	{
		self.count++;
	}

	if(!self.reset_thread_sent)
	{
		thread snd_throttler_reset();
	}
}

//Function Number: 17
snd_throttler_reset()
{
	self.reset_thread_sent = 1;
	waittillframeend;
	self.reset_thread_sent = 0;
	self.count = 0;
}

//Function Number: 18
snd_get_throttler(param_00)
{
	var_01 = spawnstruct();
	var_01.name = "throttle_waiter";
	var_01.count = 0;
	var_01.reset_thread_sent = 0;
	var_02 = 10;
	if(isdefined(param_00))
	{
		var_02 = max(param_00,1);
	}

	var_01.max_calls_per_frame = var_02;
	return var_01;
}

//Function Number: 19
snd_set_soundtable_name(param_00)
{
	level._snd.soundtable = param_00;
}

//Function Number: 20
snd_get_soundtable_name()
{
	return level._snd.soundtable;
}

//Function Number: 21
snd_parse_preset_header(param_00,param_01,param_02)
{
	var_03 = [];
	for(var_04 = 0;var_04 < param_02;var_04++)
	{
		var_05 = tablelookupbyrow(param_00,param_01,var_04);
		var_03[var_05] = var_04;
	}

	return var_03;
}

//Function Number: 22
snd_parse_soundtables(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	for(var_06 = 0;var_06 < param_01.size;var_06++)
	{
		var_07 = param_01[var_06];
		var_08 = 0;
		var_09 = undefined;
		var_0A = 0;
		var_0B = 0;
		var_0C = undefined;
		var_0D = "";
		var_0E = packedtablesectionlookup(var_07,param_03,param_04);
		if(isdefined(var_0E))
		{
			while(var_0A < 10 && var_08 + var_0E[0] < var_0E[1])
			{
				var_0F = tablelookupbyrow(var_07,var_08 + var_0E[0],var_0B);
				if(var_0F != "")
				{
					var_0A = 0;
					if(!isdefined(var_09))
					{
						var_09 = snd_parse_preset_header(var_07,var_08 + var_0E[0],param_02);
						var_0B = var_09[param_03];
					}
					else
					{
						var_10 = 0;
						if(!isdefined(var_0C))
						{
							var_10 = 1;
						}
						else if(var_0F != var_0D)
						{
							var_05[var_0D] = var_0C;
							var_10 = 1;
						}

						if(var_10)
						{
							var_0C = spawnstruct();
							var_0C.name = var_0F;
							var_0C.settings = [];
							var_0D = var_0F;
						}

						var_11 = [];
						foreach(var_15, var_13 in var_09)
						{
							var_14 = tablelookupbyrow(var_07,var_08 + var_0E[0],var_13);
							if(var_15 == param_03)
							{
								if(var_14 != var_0D)
								{
									break;
								}

								continue;
							}

							if(maps\_utility::is_string_a_number(var_14))
							{
								var_11[var_15] = float(var_14);
								continue;
							}

							var_11[var_15] = var_14;
						}

						var_0C.settings[var_0C.settings.size] = var_11;
					}

					continue;
				}

				if(isdefined(var_0C))
				{
					var_05[var_0D] = var_0C;
					var_0C = undefined;
				}

				var_0A++;
				var_08++;
			}

			if(isdefined(var_0C))
			{
				var_05[var_0D] = var_0C;
				var_0C = undefined;
			}
		}
	}

	return var_05;
}

//Function Number: 23
snd_debug_init()
{
}