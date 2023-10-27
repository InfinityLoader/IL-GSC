/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_audio_ambient.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 275 ms
 * Timestamp: 10/27/2023 1:27:13 AM
*******************************************************************/

//Function Number: 1
init_ambient()
{
	if(isdefined(level._audio.ambient))
	{
		return;
	}

	level._audio.ambient = spawnstruct();
	level._audio.ambient.var_8090 = 0;
	level._audio.ambient.var_21E6 = "";
	level._audio.ambient.current = [];
	level._audio.ambient.current["zone"] = [];
	level._audio.ambient.var_2C07 = [];
	level._audio.ambient.cached_ambients = [];
	level._audio.ambient.cached_elems = [];
	level._audio.ambient.var_50E1 = 15;
	level._audio.ambient.sound_ents = [];
}

//Function Number: 2
func_79EF(param_00)
{
	func_79EE("zone",param_00);
}

//Function Number: 3
func_79EE(param_00,param_01,param_02,param_03,param_04)
{
	maps\_audio_code::cache_ambient(param_01);
	if(!isdefined(level._audio.ambient.cached_ambients[param_01]))
	{
	}

	level._audio.ambient.var_21E6 = param_01;
	if(!level._audio.ambient.var_8090)
	{
		level thread ambient_event_thread();
	}
}

//Function Number: 4
func_7C0A(param_00,param_01)
{
	if(param_00 == "")
	{
	}

	if(level._audio.ambient.var_21E6 == param_00)
	{
		level._audio.ambient.var_21E6 = "";
		fade_ambient_elems(param_00,param_01);
	}
}

//Function Number: 5
func_7C1A()
{
	if(level._audio.ambient.var_21E6 == "")
	{
	}

	func_7C0A(level._audio.ambient.var_21E6);
}

//Function Number: 6
func_7C08()
{
	func_7C0A(level._audio.ambient.var_21E6);
}

//Function Number: 7
fade_ambient_elems(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	foreach(var_03 in level._audio.ambient.sound_ents)
	{
		if(!isdefined(var_03.ambient) || var_03.ambient != param_00)
		{
			continue;
		}

		var_03 thread fade_ambient_elem_internal(param_01);
	}
}

//Function Number: 8
fade_ambient_elem_internal(param_00)
{
	if(isdefined(self.fading))
	{
	}

	self endon("sounddone");
	self.fading = 1;
	thread func_312E();
	self scalevolume(0,param_00);
	wait(param_00);
	self stopsounds();
	self notify("sounddone");
}

//Function Number: 9
func_312E()
{
	self waittill("sounddone");
	self scalevolume(1);
	self.fading = undefined;
}

//Function Number: 10
func_7D8F(param_00,param_01,param_02,param_03)
{
	func_7D8E(param_00,param_01);
	func_7D8E(param_02,param_03);
}

//Function Number: 11
func_7D8E(param_00,param_01)
{
	if(isdefined(param_00) && param_00 != "" && param_00 != "none")
	{
		if(param_01 == 0)
		{
			func_7C0A(param_00);
		}

		func_79EF(param_00);
	}
}

//Function Number: 12
ambient_event_thread()
{
	level endon("stop_ambient_event_thread");
	var_00 = "";
	level._audio.ambient.var_8090 = 1;
	for(;;)
	{
		var_01 = gettime();
		if(level._audio.ambient.var_21E6 != "")
		{
			var_02 = level._audio.ambient.var_21E6;
			var_03 = level._audio.ambient.cached_ambients[var_02];
			if(isdefined(var_03.var_6E10))
			{
				if(!isdefined(var_03.var_55DC))
				{
					var_03 func_6F32(1);
				}

				if(var_03.var_55DC <= var_01)
				{
					if(var_03.var_3039.size > 1)
					{
						for(var_04 = var_03 func_3973();var_04.elem == var_00;var_04 = var_03 func_3973())
						{
							wait(0.05);
						}
					}
					else
					{
						var_04 = var_04.var_3039[0];
					}

					func_5CA6(var_04,var_02);
					if(level._audio.ambient.var_21E6 != "")
					{
						var_00 = var_04.elem;
						var_03 func_6F32(1);
					}
				}
			}
			else
			{
				foreach(var_04 in var_03.var_3039)
				{
					if(!isdefined(var_04.var_55DC))
					{
						var_04 func_6F32();
					}

					if(var_04.var_55DC <= var_01)
					{
						level thread func_5CA6(var_04,var_02);
						var_04 func_6F32();
					}
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 13
func_7C09()
{
	level notify("stop_ambient_event_thread");
	level._audio.ambient.var_8090 = 0;
}

//Function Number: 14
func_5CA6(param_00,param_01)
{
	var_02 = level._audio.ambient.cached_elems[param_00.elem];
	func_5CA7(var_02,param_01);
}

//Function Number: 15
func_5CA7(param_00,param_01)
{
	var_02 = param_00["alias"];
	var_03 = get_sound_ent();
	if(!isdefined(var_03))
	{
		maps\_audio_code::func_2402("^3play_ambient_elem_oneshot cannot play, out of sound ents");
	}

	maps\_audio_code::func_2402("play_ambient_elem_oneshot -- ambient: \" + param_01 + "\" alias: \" + var_02 + "\");
	var_03.ambient = param_01;
	var_03.is_playing = 1;
	var_04 = get_elem_position(param_00);
	var_03.origin = var_04 + level.player.origin;
	var_03 playsound(var_02,"sounddone");
	var_03 waittill("sounddone");
	wait(0.1);
	var_03.ambient = undefined;
	var_03.is_playing = 0;
}

//Function Number: 16
get_elem_position(param_00)
{
	var_01 = randomfloatrange(param_00["range"][0],param_00["range"][1]);
	var_02 = undefined;
	if(isdefined(param_00["cone"]))
	{
		var_02 = randomfloatrange(param_00["cone"][0],param_00["cone"][1]);
	}
	else
	{
		var_02 = randomfloatrange(0,360);
	}

	var_03 = anglestoforward((0,var_02,0)) * var_01;
	return (var_03[0],var_03[1],0);
}

//Function Number: 17
func_6F32(param_00)
{
	if(isdefined(param_00))
	{
		var_01 = level._audio.ambient.cached_ambients[level._audio.ambient.var_21E6].data;
	}
	else
	{
		var_01 = level._audio.ambient.cached_elems[self.elem];
	}

	var_02 = randomfloatrange(var_01["time"][0],var_01["time"][1]);
	self.var_55DC = gettime() + var_02 * 1000;
}

//Function Number: 18
func_3973()
{
	var_00 = 0;
	foreach(var_02 in self.var_3039)
	{
		var_00 = var_00 + var_02.weight;
	}

	var_04 = randomfloat(var_00);
	var_05 = 0;
	var_06 = undefined;
	foreach(var_02 in self.var_3039)
	{
		var_05 = var_05 + var_02.weight;
		if(var_04 < var_05)
		{
			var_06 = var_02;
			break;
		}
	}

	return var_06;
}

//Function Number: 19
get_sound_ent()
{
	foreach(var_01 in level._audio.ambient.sound_ents)
	{
		if(!var_01.is_playing)
		{
			return var_01;
		}
	}

	if(level._audio.ambient.sound_ents.size < level._audio.ambient.var_50E1)
	{
		var_01 = spawn("script_origin",(0,0,0));
		var_01.is_playing = 0;
		level._audio.ambient.sound_ents[level._audio.ambient.sound_ents.size] = var_01;
		return var_01;
	}

	return undefined;
}