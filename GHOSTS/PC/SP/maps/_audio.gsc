/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_audio.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 58
 * Decompile Time: 948 ms
 * Timestamp: 10/27/2023 1:27:12 AM
*******************************************************************/

//Function Number: 1
init_audio()
{
	if(isdefined(level._audio))
	{
		return;
	}

	setdvarifuninitialized("debug_audio","0");
	setdvarifuninitialized("debug_headroom","-1");
	setdvarifuninitialized("music_enable","1");
	level._audio = spawnstruct();
	level._audio.using_string_tables = 0;
	level._audio.progress_trigger_callbacks = [];
	level._audio.var_61DB = [];
	init_tracks();
	init_filter();
	init_occlusion();
	maps\_audio_ambient::init_ambient();
	init_mix();
	init_reverb();
	func_45BF();
	init_whizby();
	func_45D2();
	thread level_fadein();
}

//Function Number: 2
aud_set_spec_ops()
{
}

//Function Number: 3
aud_add_progress_map(param_00,param_01)
{
	level._audio.var_61DB[param_00] = param_01;
}

//Function Number: 4
func_47DA()
{
	if(!isdefined(level._audio.deathsdoor_enabled))
	{
		return 1;
	}

	return level._audio.deathsdoor_enabled;
}

//Function Number: 5
aud_enable_deathsdoor_audio()
{
	level.player.disable_breathing_sound = 0;
	level._audio.deathsdoor_enabled = 1;
}

//Function Number: 6
aud_disable_deathsdoor_audio()
{
	level.player.disable_breathing_sound = 1;
	level._audio.deathsdoor_enabled = 0;
}

//Function Number: 7
func_6649()
{
	if(func_47DA() || isdefined(level._audio.in_deathsdoor))
	{
		level._audio.in_deathsdoor = undefined;
		level.player clearclienttriggeraudiozone();
	}
}

//Function Number: 8
func_6E7B()
{
	level._audio.in_deathsdoor = 1;
	if(func_47DA())
	{
		if(isdefined(level.deathsdooroverride))
		{
			level.player setclienttriggeraudiozonepartial(level.deathsdooroverride,"reverb","mix","filter");
		}

		level.player setclienttriggeraudiozonepartial("deathsdoor","reverb","mix","filter");
	}
}

//Function Number: 9
func_836B(param_00)
{
	if(isdefined(param_00._audio_trigger))
	{
	}

	param_00._audio_trigger = 1;
	var_01 = undefined;
	if(isdefined(param_00.ambient))
	{
		var_01 = strtok(param_00.ambient," ");
	}
	else if(isdefined(param_00.script_audio_zones))
	{
		var_01 = strtok(param_00.script_audio_zones," ");
	}
	else if(isdefined(param_00.audio_zones))
	{
		var_01 = strtok(param_00.audio_zones," ");
	}

	if(isdefined(var_01) && var_01.size == 2)
	{
	}
	else if(isdefined(var_01) && var_01.size == 1)
	{
		for(;;)
		{
			param_00 waittill("trigger",var_02);
			func_6FD2(var_01[0],param_00.var_6B9E);
		}
	}

	if(isdefined(param_00.var_6B42))
	{
		if(!isdefined(level._audio.var_61DB[param_00.var_6B42]))
		{
			maps\_audio_code::debug_error("Trying to set a progress_map_function without defining the envelope in the level.aud.envs array.");
			param_00.var_6B42 = undefined;
		}
	}

	if(!isdefined(param_00.var_6B3B))
	{
		param_00.var_6B3B = "blend";
	}

	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	if(isdefined(param_00.target))
	{
		if(!isdefined(param_00 common_scripts\utility::func_39BD()))
		{
			maps\_audio_code::debug_error("Audo Zone Trigger at " + param_00.origin + " has defined a target, " + param_00.target + ", but that target doesn\'t exist.");
		}

		if(isdefined(param_00 func_39BF()))
		{
			var_03 = param_00 get_target_ent_origin();
			if(!isdefined(param_00 get_target_ent_target_ent()))
			{
				maps\_audio_code::debug_error("Audo Zone Trigger at " + param_00.origin + " has defined a target, " + func_39BF() + ", but that target doesn\'t exist.");
			}

			var_04 = param_00 func_39C1();
		}
		else
		{
			var_06 = param_00 common_scripts\utility::func_39BD();
			var_07 = 2 * param_00.origin - var_06.origin;
			var_08 = vectortoangles(var_07);
			var_03 = param_00 get_target_ent_origin();
			var_04 = var_03 + var_07;
			if(angleclamp180(var_08[0]) < 45)
			{
				var_03 = (var_03[0],var_03[1],0);
				var_04 = (var_04[0],var_04[1],0);
			}
		}

		var_05 = distance(var_03,var_04);
	}

	var_09 = 0;
	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(maps\_utility::func_4840() && var_02 != level.player)
		{
			continue;
		}

		if(isdefined(var_03) && isdefined(var_04))
		{
			var_0A = func_8369(var_03,var_04,var_05,var_02.origin);
			if(var_0A < 0.5)
			{
				var_09 = 0;
			}
			else
			{
				var_09 = 1;
			}
		}

		var_0B = undefined;
		var_0C = func_3A04(var_01,var_09);
		var_0D = get_zone_to(var_01,var_09);
		if(isdefined(var_0C) && isdefined(var_0D))
		{
			var_0B = maps\_audio_code::func_3A03(var_0C,var_0D);
			if(!isdefined(var_0B))
			{
			}

			var_0B["mode"] = param_00.var_6B3B;
			if(var_09)
			{
				var_0E = var_0B["filter1"];
				var_0F = var_0B["filter2"];
				var_0B["filter1"] = var_0F;
				var_0B["filter2"] = var_0E;
				var_0E = undefined;
				var_0F = undefined;
			}
		}

		var_10 = -1;
		var_0A = -1;
		while(var_02 istouching(param_00))
		{
			if(isdefined(param_00.var_6B40))
			{
				var_11 = func_836A(var_03,var_04,var_02.origin);
				if(isdefined(level._audio.trigger_functions[param_00.var_6B40]))
				{
					[[ level._audio.trigger_functions[param_00.var_6B40] ]](var_11);
				}
			}

			if(isdefined(var_03) && isdefined(var_04))
			{
				var_0A = func_8369(var_03,var_04,var_05,var_02.origin);
				if(isdefined(param_00.var_6B42))
				{
					var_0A = func_10F7(var_0A,level._audio.var_61DB[param_00.var_6B42]);
				}

				if(var_0A != var_10)
				{
					if(isdefined(var_0B))
					{
						func_8368(var_0A,var_0B,var_09);
					}

					var_10 = var_0A;
				}
			}

			if(isdefined(param_00.script_audio_update_rate))
			{
				wait(param_00.script_audio_update_rate);
				continue;
			}

			wait(0.05);
		}

		if(isdefined(var_03) && isdefined(var_04))
		{
			if(var_0A > 0.5)
			{
				if(isdefined(var_01) && isdefined(var_01[1]))
				{
					maps\_audio_code::func_6E6C(var_01[1]);
				}

				var_0A = 1;
			}
			else
			{
				if(isdefined(var_01) && isdefined(var_01[0]))
				{
					maps\_audio_code::func_6E6C(var_01[0]);
				}

				var_0A = 0;
			}

			if(isdefined(var_0B))
			{
				func_8368(var_0A,var_0B,var_09);
			}
		}
	}
}

//Function Number: 10
func_8369(param_00,param_01,param_02,param_03)
{
	var_04 = vectornormalize(param_01 - param_00);
	var_05 = param_03 - param_00;
	var_06 = vectordot(var_05,var_04);
	var_06 = var_06 / param_02;
	return clamp(var_06,0,1);
}

//Function Number: 11
func_836A(param_00,param_01,param_02)
{
	var_03 = vectornormalize(param_01 - param_00);
	var_04 = param_02 - param_00;
	var_05 = vectordot(var_04,var_03);
	return var_03 * var_05 + param_00;
}

//Function Number: 12
func_8368(param_00,param_01,param_02)
{
	param_00 = clamp(param_00,0,1);
	if(param_02)
	{
		param_00 = 1 - param_00;
	}

	var_03 = param_01["mode"];
	if(var_03 == "blend")
	{
		var_04 = 1 - param_00;
		var_05 = param_00;
		maps\_audio_code::blend_zones(var_04,var_05,param_01,param_02);
	}

	if(param_00 < 0.33)
	{
		func_6FD2(param_01["zone_from"]);
	}

	if(param_00 > 0.66)
	{
		func_6FD2(param_01["zone_to"]);
	}
}

//Function Number: 13
func_39BF()
{
	var_00 = common_scripts\utility::func_39BD();
	return var_00.target;
}

//Function Number: 14
get_target_ent_origin()
{
	var_00 = common_scripts\utility::func_39BD();
	return var_00.origin;
}

//Function Number: 15
get_target_ent_target_ent()
{
	var_00 = common_scripts\utility::func_39BD();
	return var_00 common_scripts\utility::func_39BD();
}

//Function Number: 16
func_39C1()
{
	var_00 = get_target_ent_target_ent();
	return var_00.origin;
}

//Function Number: 17
func_3A04(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return undefined;
	}

	if(param_01)
	{
		return param_00[1];
	}

	return param_00[0];
}

//Function Number: 18
get_zone_to(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return undefined;
	}

	if(param_01)
	{
		return param_00[0];
	}

	return param_00[1];
}

//Function Number: 19
func_10F7(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_01.size;
	var_04 = param_01[0];
	for(var_05 = 1;var_05 < param_01.size;var_05++)
	{
		var_06 = param_01[var_05];
		if(param_00 >= var_04[0] && param_00 <= var_06[0])
		{
			var_07 = var_04[0];
			var_08 = var_06[0];
			var_09 = var_04[1];
			var_0A = var_06[1];
			var_0B = param_00 - var_07 / var_08 - var_07;
			var_02 = var_09 + var_0B * var_0A - var_09;
			break;
		}
		else
		{
			var_04 = var_06;
		}
	}

	return var_02;
}

//Function Number: 20
aud_map_range(param_00,param_01,param_02,param_03)
{
	var_04 = param_00 - param_01 / param_02 - param_01;
	var_04 = clamp(var_04,0,1);
	return func_10F7(var_04,param_03);
}

//Function Number: 21
func_119F(param_00)
{
}

//Function Number: 22
play_linked_sound(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02))
	{
		param_02 = "oneshot";
	}

	var_05 = spawn("script_origin",param_01.origin);
	if(isdefined(param_04))
	{
		var_05 linkto(param_01,"tag_origin",param_04,(0,0,0));
	}
	else
	{
		var_05 linkto(param_01);
	}

	if(param_02 == "loop")
	{
		param_01 thread func_5CEF(var_05,param_03);
	}

	var_05 thread func_5CEE(param_02,param_00,param_03);
	return var_05;
}

//Function Number: 23
func_5CEE(param_00,param_01,param_02)
{
	if(param_00 == "loop")
	{
		level endon(param_02 + "internal");
		self playloopsound(param_01);
		level waittill(param_02);
		if(isdefined(self))
		{
			self stoploopsound(param_01);
			wait(0.05);
			self delete();
		}
	}

	if(param_00 == "oneshot")
	{
		self playsound(param_01,"sounddone");
		self waittill("sounddone");
		if(isdefined(self))
		{
			self delete();
		}
	}
}

//Function Number: 24
func_5CEF(param_00,param_01)
{
	level endon(param_01);
	while(isdefined(self))
	{
		wait(0.1);
	}

	level notify(param_01 + "internal");
	if(isdefined(param_00))
	{
		param_00 stoploopsound();
		wait(0.05);
		param_00 delete();
	}
}

//Function Number: 25
level_fadein()
{
	if(!isdefined(level._audio.var_4DA4))
	{
		level._audio.var_4DA4 = 1;
	}

	wait(0.05);
	levelsoundfade(1,level._audio.var_4DA4);
}

//Function Number: 26
init_tracks()
{
	level._audio.ambient_track = spawnstruct();
	level._audio.ambient_track.current = create_track_struct();
	level._audio.ambient_track.var_6165 = create_track_struct();
}

//Function Number: 27
create_track_struct()
{
	var_00 = spawnstruct();
	var_00.name = "";
	var_00.volume = 0;
	var_00.fade = 0;
	return var_00;
}

//Function Number: 28
func_1D2C(param_00)
{
	param_00.name = "";
	param_00.volume = 0;
	param_00.fade = 0;
}

//Function Number: 29
func_6E6F(param_00,param_01,param_02,param_03)
{
	param_00.var_6165 func_6FAE(param_00.current.name,param_00.current.volume,param_00.current.fade);
	param_00.current func_6FAE(param_01,param_02,param_03);
}

//Function Number: 30
func_6FAE(param_00,param_01,param_02)
{
	self.name = param_00;
	self.volume = param_01;
	self.fade = param_02;
}

//Function Number: 31
func_6E2D(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	func_6E6F(level._audio.ambient_track,param_00,param_02,param_01);
	maps\_audio_code::set_hud_value("ambient",param_00);
	maps\_audio_code::set_hud_name_percent_value("ambient_from","");
	maps\_audio_code::set_hud_name_percent_value("ambient_to","");
	ambientplay(param_00,param_01,param_02);
}

//Function Number: 32
func_7C0B(param_00,param_01)
{
	if(param_00 == "")
	{
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(level._audio.ambient_track.current.name == param_00)
	{
		level._audio.ambient_track.current = level._audio.ambient_track.var_6165;
		maps\_audio_code::set_hud_value("ambient","");
		maps\_audio_code::set_hud_name_percent_value("ambient_from","");
		maps\_audio_code::set_hud_name_percent_value("ambient_to","");
		func_1D2C(level._audio.ambient_track.var_6165);
	}
	else if(level._audio.ambient_track.var_6165.name == param_00)
	{
		func_1D2C(level._audio.ambient_track.var_6165);
	}

	ambientstop(param_01,param_00);
}

//Function Number: 33
func_7C0C(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	func_1D2C(level._audio.ambient_track.current);
	func_1D2C(level._audio.ambient_track.var_6165);
	ambientstop(param_00);
}

//Function Number: 34
func_52FB(param_00)
{
	var_01 = 0.009;
	var_02 = level._audio.ambient_track.current;
	var_03 = level._audio.ambient_track.var_6165;
	if(param_00.size == 1)
	{
		var_02 func_6FAE(param_00[0].alias,param_00[0].volume,param_00[0].fade);
	}
	else if(param_00.size == 2)
	{
		var_03 func_6FAE(param_00[0].alias,param_00[0].volume,param_00[0].fade);
		var_02 func_6FAE(param_00[1].alias,param_00[1].volume,param_00[1].fade);
	}

	for(var_05 = 0;var_05 < param_00.size;var_05++)
	{
		var_06 = param_00[var_05].alias;
		var_07 = max(param_00[var_05].volume,0);
		var_08 = clamp(param_00[var_05].fade,0,1);
		if(var_06 != "")
		{
			if(var_07 < var_01)
			{
				ambientstop(var_08,var_06);
				continue;
			}

			ambientplay(var_06,var_08,var_07,0);
		}
	}
}

//Function Number: 35
func_2C90(param_00)
{
	if(param_00 == "none")
	{
		return "";
	}

	return param_00;
}

//Function Number: 36
func_45D2()
{
	level._audio.zone = spawnstruct();
	level._audio.zone.var_21E6 = "";
	level._audio.zone.cached = [];
}

//Function Number: 37
func_6FD2(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
	}

	if(level._audio.zone.var_21E6 == param_00)
	{
	}

	if(level._audio.zone.var_21E6 != "")
	{
		func_7C58(level._audio.zone.var_21E6,param_01);
	}

	level._audio.zone.var_21E6 = param_00;
	if(isdefined(level._audio.zone.cached[param_00]) && isdefined(level._audio.zone.cached[param_00]["state"]) && level._audio.zone.cached[param_00]["state"] != "stopping")
	{
		maps\_audio_code::debug_error("set_zone( \" + param_00 + "\" ) being called even though audio zone, \" + param_00 + "\", is already started.");
	}

	if(!isdefined(param_01))
	{
		param_01 = 2;
	}

	maps\_audio_code::cache_zone(param_00);
	maps\_audio_code::func_2402("ZONE START: " + param_00);
	level._audio.zone.cached[param_00]["state"] = "playing";
	maps\_audio_code::set_hud_value("zone",param_00);
	var_03 = level._audio.zone.cached[param_00];
	if(isdefined(var_03["ambience"]))
	{
		if(var_03["ambience"] != "")
		{
			func_6E2D(var_03["ambience"],param_01);
		}
		else
		{
			func_7C0C(param_01);
		}
	}

	if(isdefined(var_03["ambient_name"]))
	{
		if(var_03["ambient_name"] != "")
		{
			maps\_audio_code::set_hud_value("ambient_elem",var_03["ambient_name"]);
			maps\_audio_code::set_hud_name_percent_value("ambient_elem_from","","");
			maps\_audio_code::set_hud_name_percent_value("ambient_elem_to","","");
			maps\_audio_ambient::func_79EF(var_03["ambient_name"]);
		}
		else
		{
			maps\_audio_code::set_hud_value("ambient_elem","");
			maps\_audio_code::set_hud_name_percent_value("ambient_elem_from","","");
			maps\_audio_code::set_hud_name_percent_value("ambient_elem_to","","");
			maps\_audio_ambient::func_7C1A();
		}
	}

	if(isdefined(var_03["occlusion"]))
	{
		if(var_03["occlusion"] != "")
		{
			func_6F37(var_03["occlusion"]);
		}
		else
		{
			deactivate_occlusion();
		}
	}

	if(isdefined(var_03["filter"]))
	{
		if(var_03["filter"] != "")
		{
			func_6EB5(var_03["filter"],0);
			level.player seteqlerp(1,level._audio.filter.var_2F8D);
		}
	}

	if(isdefined(var_03["reverb"]))
	{
		if(var_03["reverb"] != "")
		{
			func_6F84(var_03["reverb"]);
		}
		else
		{
			clear_reverb();
		}
	}

	if(isdefined(var_03["mix"]))
	{
		if(var_03["mix"] != "")
		{
			func_6F26(var_03["mix"],param_01);
		}

		clear_mix();
	}
}

//Function Number: 38
func_7C59(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	maps\_audio_code::func_2402("ZONE STOP ALL");
	foreach(var_02 in level._audio.zone.cached)
	{
		func_7C58(var_02["name"],param_00);
	}
}

//Function Number: 39
func_7C58(param_00,param_01)
{
	if(isdefined(level._audio.zone.cached[param_00]) && isdefined(level._audio.zone.cached[param_00]["state"]) && level._audio.zone.cached[param_00]["state"] != "stopping")
	{
		if(!isdefined(param_01))
		{
			param_01 = 1;
		}

		var_02 = level._audio.zone.cached[param_00];
		maps\_audio_code::func_2402("ZONE STOP " + param_00);
		if(isdefined(var_02["ambience"]))
		{
			func_7C0B(var_02["ambience"],param_01);
		}

		if(isdefined(var_02["ambient_name"]))
		{
			maps\_audio_ambient::func_7C0A(var_02["ambient_name"]);
		}

		level._audio.zone.cached[param_00]["state"] = "stopping";
	}
}

//Function Number: 40
init_filter()
{
	level._audio.filter = spawnstruct();
	level._audio.filter.var_2F8D = 0;
	level._audio.filter.current = [];
	level._audio.filter.current[0] = "";
	level._audio.filter.current[1] = "";
	level._audio.filter.var_6165 = [];
	level._audio.filter.var_6165[0] = "";
	level._audio.filter.var_6165[1] = "";
}

//Function Number: 41
func_6EB5(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(level._audio.filter.current[param_01] == param_00)
	{
	}

	if(isdefined(level._audio.in_deathsdoor))
	{
		level._audio.var_2384.filter[param_01] = param_00;
	}

	if(level._audio.filter.current[param_01] != param_00)
	{
		maps\_audio_code::func_2402("filter DeactivateEq() index=" + param_01,2);
		level.player deactivateeq(param_01);
	}

	func_6E6E(param_01,param_00);
	level.player seteqfromtable(maps\_audio_code::get_map_soundtable(),param_00,param_01);
}

//Function Number: 42
func_6E6E(param_00,param_01)
{
	if(param_01 == "deathsdoor")
	{
	}

	level._audio.filter.var_6165[param_00] = level._audio.filter.current[param_00];
	level._audio.filter.current[param_00] = param_01;
	maps\_audio_code::set_hud_name_percent_value("filter_" + param_00,param_01,"last");
}

//Function Number: 43
clear_filter(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	func_6E6E(param_00,"");
	maps\_audio_code::func_2402("filter DeactivateEq() index=" + param_00,2);
	level.player deactivateeq(param_00);
	maps\_audio_code::set_hud_name_percent_value("filter_" + param_00,"","last");
}

//Function Number: 44
init_occlusion()
{
	level._audio.occlusion = spawnstruct();
	level._audio.occlusion.current = "";
	func_6F37("default");
}

//Function Number: 45
func_6F37(param_00)
{
	if(level._audio.occlusion.current == param_00)
	{
	}

	thread func_6F38(param_00);
}

//Function Number: 46
func_6F38(param_00)
{
	if(level._audio.occlusion.current == param_00)
	{
	}

	level._audio.occlusion.current = param_00;
	maps\_audio_code::func_2402("occlusion SetOcclusionFromTable() name=" + param_00,2);
	maps\_audio_code::set_hud_value("occlusion",param_00);
	level.player setocclusionfromtable(maps\_audio_code::get_map_soundtable(),param_00);
}

//Function Number: 47
deactivate_occlusion()
{
	maps\_audio_code::func_2402("occlusion DeactivateAllOcclusion() ");
	level.player deactivateallocclusion();
}

//Function Number: 48
init_reverb(param_00)
{
	level._audio.var_668D = spawnstruct();
	level._audio.var_668D.current = "";
}

//Function Number: 49
func_6F84(param_00)
{
	if(!isdefined(param_00))
	{
	}

	if(level._audio.var_668D.current == param_00)
	{
	}

	if(isdefined(level._audio.in_deathsdoor) && param_00 != "deathsdoor")
	{
		level._audio.var_2384.var_668D = param_00;
	}

	level._audio.var_668D.current = param_00;
	maps\_audio_code::func_2402("reverb SetReverbFromTable(): name=" + param_00,2);
	level.player setreverbfromtable(maps\_audio_code::get_map_soundtable(),param_00,"snd_enveffectsprio_level");
}

//Function Number: 50
clear_reverb()
{
	maps\_audio_code::func_2402("deactivatereverb");
	level.player deactivatereverb("snd_enveffectsprio_level",2);
	level._audio.var_668D.current = "";
	maps\_audio_code::set_hud_value("reverb","");
}

//Function Number: 51
init_mix()
{
	level._audio.mix = spawnstruct();
	level._audio.mix.current = "";
	level._audio.mix.var_6165 = "";
	func_6F26("default");
}

//Function Number: 52
func_6F26(param_00,param_01)
{
	if(level._audio.mix.current == param_00)
	{
	}

	change_mix(param_00,"default",param_01);
}

//Function Number: 53
change_mix(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = "default";
	}

	if(param_00 == param_01)
	{
	}

	if(isdefined(param_02))
	{
		level.player setvolmodfromtable(maps\_audio_code::get_map_soundtable(),param_00,param_02);
	}
	else
	{
		level.player setvolmodfromtable(maps\_audio_code::get_map_soundtable(),param_00);
	}

	maps\_audio_code::set_hud_value("mix",param_00);
	level._audio.mix.var_6165 = level._audio.mix.current;
	level._audio.mix.current = param_00;
}

//Function Number: 54
clear_mix(param_00)
{
	if(level._audio.mix.current == "")
	{
	}

	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	change_mix("default",level._audio.mix.current);
}

//Function Number: 55
init_whizby()
{
	level._audio.var_8DE7 = spawnstruct();
	level._audio.var_8DE7.current = "";
	thread func_6FC9("default");
}

//Function Number: 56
func_6FC9(param_00)
{
	if(level._audio.var_8DE7.current == param_00)
	{
	}

	level._audio.var_8DE7.current = param_00;
	level.player setwhizbyfromtable(maps\_audio_code::get_map_soundtable(),param_00);
}

//Function Number: 57
func_45BF()
{
	level._audio.timescale = spawnstruct();
	level._audio.timescale.current = "";
	func_6FAC("default");
}

//Function Number: 58
func_6FAC(param_00)
{
	if(level._audio.timescale.current == param_00)
	{
	}

	level._audio.timescale.current = param_00;
	level.player settimescalefactorfromtable(maps\_audio_code::get_map_soundtable(),param_00);
}