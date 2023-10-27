/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_utility.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 857
 * Decompile Time: 13856 ms
 * Timestamp: 10/27/2023 2:01:58 AM
*******************************************************************/

//Function Number: 1
set_hudoutline(param_00,param_01)
{
	var_02 = undefined;
	param_00 = tolower(param_00);
	var_03["friendly"] = 3;
	var_03["enemy"] = 4;
	var_03["objective"] = 5;
	var_03["neutral"] = 0;
	var_02 = var_03[param_00];
	self hudoutlineenable(var_02,param_01);
}

//Function Number: 2
is_coop()
{
	if(issplitscreen() || getdvar("coop") == "1")
	{
		return 1;
	}

	return 0;
}

//Function Number: 3
is_coop_online()
{
	if(issplitscreen())
	{
		return 0;
	}

	if(!is_coop())
	{
		return 0;
	}

	return 1;
}

//Function Number: 4
is_player_down(param_00)
{
	if(param_00 ent_flag_exist("laststand_downed"))
	{
		return param_00 ent_flag("laststand_downed");
	}

	if(isdefined(param_00.laststand))
	{
		return param_00.laststand;
	}

	return !isalive(param_00);
}

//Function Number: 5
is_player_down_and_out(param_00)
{
	if(!isdefined(param_00.down_part2_proc_ran))
	{
		return 0;
	}

	return param_00.down_part2_proc_ran;
}

//Function Number: 6
killing_will_down(param_00)
{
	if(laststand_enabled())
	{
		if(isdefined(level.laststand_kill_will_down_func))
		{
			return param_00 [[ level.laststand_kill_will_down_func ]]();
		}
	}

	return 0;
}

//Function Number: 7
is_survival()
{
	return is_specialop() && getdvarint("so_survival") > 0;
}

//Function Number: 8
laststand_enabled()
{
	return isdefined(level.laststand_type) && level.laststand_type > 0;
}

//Function Number: 9
is_specialop()
{
	return getdvarint("specialops") >= 1;
}

//Function Number: 10
convert_to_time_string(param_00,param_01)
{
	var_02 = "";
	if(param_00 < 0)
	{
		var_02 = var_02 + "-";
	}

	param_00 = round_float(param_00,1,0);
	var_03 = param_00 * 100;
	var_03 = int(var_03);
	var_03 = abs(var_03);
	var_04 = var_03 / 6000;
	var_04 = int(var_04);
	var_02 = var_02 + var_04;
	var_05 = var_03 / 100;
	var_05 = int(var_05);
	var_05 = var_05 - var_04 * 60;
	if(var_05 < 10)
	{
		var_02 = var_02 + ":0" + var_05;
	}
	else
	{
		var_02 = var_02 + ":" + var_05;
	}

	if(isdefined(param_01) && param_01)
	{
		var_06 = var_03;
		var_06 = var_06 - var_04 * 6000;
		var_06 = var_06 - var_05 * 100;
		var_06 = int(var_06 / 10);
		var_02 = var_02 + "." + var_06;
	}

	return var_02;
}

//Function Number: 11
round_float(param_00,param_01,param_02)
{
	param_01 = int(param_01);
	if(param_01 < 0 || param_01 > 4)
	{
		return param_00;
	}

	var_03 = 1;
	for(var_04 = 1;var_04 <= param_01;var_04++)
	{
		var_03 = var_03 * 10;
	}

	var_05 = param_00 * var_03;
	if(!isdefined(param_02) || param_02)
	{
		var_05 = floor(var_05);
	}
	else
	{
		var_05 = ceil(var_05);
	}

	param_00 = var_05 / var_03;
	return param_00;
}

//Function Number: 12
round_millisec_on_sec(param_00,param_01,param_02)
{
	var_03 = param_00 / 1000;
	var_03 = round_float(var_03,param_01,param_02);
	param_00 = var_03 * 1000;
	return int(param_00);
}

//Function Number: 13
set_vision_set(param_00,param_01)
{
	if(maps\_utility_code::init_vision_set(param_00))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	visionsetnaked(param_00,param_01);
	setdvar("vision_set_current",param_00);
}

//Function Number: 14
set_vision_set_player(param_00,param_01)
{
	if(maps\_utility_code::init_vision_set(param_00))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	self visionsetnakedforplayer(param_00,param_01);
}

//Function Number: 15
sun_light_fade(param_00,param_01,param_02)
{
	param_02 = int(param_02 * 20);
	var_03 = [];
	for(var_04 = 0;var_04 < 3;var_04++)
	{
		var_03[var_04] = param_00[var_04] - param_01[var_04] / param_02;
	}

	var_05 = [];
	for(var_04 = 0;var_04 < param_02;var_04++)
	{
		wait(0.05);
		for(var_06 = 0;var_06 < 3;var_06++)
		{
			var_05[var_06] = param_00[var_06] - var_03[var_06] * var_04;
		}

		setsunlight(var_05[0],var_05[1],var_05[2]);
	}

	setsunlight(param_01[0],param_01[1],param_01[2]);
}

//Function Number: 16
ent_flag_wait(param_00)
{
	while(isdefined(self) && !self.ent_flag[param_00])
	{
		self waittill(param_00);
	}
}

//Function Number: 17
ent_flag_wait_vehicle_node(param_00)
{
	while(isdefined(self) && !self.ent_flag[param_00])
	{
		self waittill(param_00);
	}
}

//Function Number: 18
ent_flag_wait_either(param_00,param_01)
{
	while(isdefined(self))
	{
		if(ent_flag(param_00))
		{
			return;
		}

		if(ent_flag(param_01))
		{
			return;
		}

		common_scripts\utility::waittill_either(param_00,param_01);
	}
}

//Function Number: 19
ent_flag_wait_or_timeout(param_00,param_01)
{
	var_02 = gettime();
	while(isdefined(self))
	{
		if(self.ent_flag[param_00])
		{
			break;
		}

		if(gettime() >= var_02 + param_01 * 1000)
		{
			break;
		}

		maps\_utility_code::ent_wait_for_flag_or_time_elapses(param_00,param_01);
	}
}

//Function Number: 20
ent_flag_waitopen(param_00)
{
	while(isdefined(self) && self.ent_flag[param_00])
	{
		self waittill(param_00);
	}
}

//Function Number: 21
ent_flag_assert(param_00)
{
}

//Function Number: 22
ent_flag_waitopen_either(param_00,param_01)
{
	while(isdefined(self))
	{
		if(!ent_flag(param_00))
		{
			return;
		}

		if(!ent_flag(param_01))
		{
			return;
		}

		common_scripts\utility::waittill_either(param_00,param_01);
	}
}

//Function Number: 23
ent_flag_init(param_00)
{
	if(!isdefined(self.ent_flag))
	{
		self.ent_flag = [];
		self.ent_flags_lock = [];
	}

	self.ent_flag[param_00] = 0;
}

//Function Number: 24
ent_flag_exist(param_00)
{
	if(isdefined(self.ent_flag) && isdefined(self.ent_flag[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 25
ent_flag_set_delayed(param_00,param_01)
{
	self endon("death");
	wait(param_01);
	ent_flag_set(param_00);
}

//Function Number: 26
ent_flag_set(param_00)
{
	self.ent_flag[param_00] = 1;
	self notify(param_00);
}

//Function Number: 27
ent_flag_clear(param_00,param_01)
{
	if(self.ent_flag[param_00])
	{
		self.ent_flag[param_00] = 0;
		self notify(param_00);
	}

	if(isdefined(param_01) && param_01)
	{
		self.ent_flag[param_00] = undefined;
	}
}

//Function Number: 28
ent_flag_clear_delayed(param_00,param_01)
{
	wait(param_01);
	ent_flag_clear(param_00);
}

//Function Number: 29
ent_flag(param_00)
{
	return self.ent_flag[param_00];
}

//Function Number: 30
get_closest_to_player_view(param_00,param_01,param_02,param_03)
{
	if(!param_00.size)
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = level.player;
	}

	if(!isdefined(param_03))
	{
		param_03 = -1;
	}

	var_04 = param_01.origin;
	if(isdefined(param_02) && param_02)
	{
		var_04 = param_01 geteye();
	}

	var_05 = undefined;
	var_06 = param_01 getplayerangles();
	var_07 = anglestoforward(var_06);
	var_08 = -1;
	foreach(var_0A in param_00)
	{
		var_0B = vectortoangles(var_0A.origin - var_04);
		var_0C = anglestoforward(var_0B);
		var_0D = vectordot(var_07,var_0C);
		if(var_0D < var_08)
		{
			continue;
		}

		if(var_0D < param_03)
		{
			continue;
		}

		var_08 = var_0D;
		var_05 = var_0A;
	}

	return var_05;
}

//Function Number: 31
get_closest_index_to_player_view(param_00,param_01,param_02)
{
	if(!param_00.size)
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = level.player;
	}

	var_03 = param_01.origin;
	if(isdefined(param_02) && param_02)
	{
		var_03 = param_01 geteye();
	}

	var_04 = undefined;
	var_05 = param_01 getplayerangles();
	var_06 = anglestoforward(var_05);
	var_07 = -1;
	for(var_08 = 0;var_08 < param_00.size;var_08++)
	{
		var_09 = vectortoangles(param_00[var_08].origin - var_03);
		var_0A = anglestoforward(var_09);
		var_0B = vectordot(var_06,var_0A);
		if(var_0B < var_07)
		{
			continue;
		}

		var_07 = var_0B;
		var_04 = var_08;
	}

	return var_04;
}

//Function Number: 32
flag_trigger_init(param_00,param_01,param_02)
{
	common_scripts\utility::flag_init(param_00);
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	param_01 thread maps\_utility_code::_flag_wait_trigger(param_00,param_02);
	return param_01;
}

//Function Number: 33
flag_triggers_init(param_00,param_01,param_02)
{
	common_scripts\utility::flag_init(param_00);
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	for(var_03 = 0;var_03 < param_01.size;var_03++)
	{
		param_01[var_03] thread maps\_utility_code::_flag_wait_trigger(param_00,0);
	}

	return param_01;
}

//Function Number: 34
flag_set_delayed(param_00,param_01)
{
	wait(param_01);
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 35
flag_clear_delayed(param_00,param_01)
{
	wait(param_01);
	common_scripts\utility::flag_clear(param_00);
}

//Function Number: 36
level_end_save()
{
	if(arcademode())
	{
		return;
	}

	if(level.missionfailed)
	{
		return;
	}

	if(common_scripts\utility::flag("game_saving"))
	{
		return;
	}

	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		var_01 = level.players[var_00];
		if(!isalive(var_01))
		{
			return;
		}
	}

	common_scripts\utility::flag_set("game_saving");
	var_02 = "levelshots / autosave / autosave_" + level.script + "end";
	savegame("levelend",&"AUTOSAVE_AUTOSAVE",var_02,1,1);
	common_scripts\utility::flag_clear("game_saving");
}

//Function Number: 37
add_extra_autosave_check(param_00,param_01,param_02)
{
	level._extra_autosave_checks[param_00] = [];
	level._extra_autosave_checks[param_00]["func"] = param_01;
	level._extra_autosave_checks[param_00]["msg"] = param_02;
}

//Function Number: 38
remove_extra_autosave_check(param_00)
{
	level._extra_autosave_checks[param_00] = undefined;
}

//Function Number: 39
autosave_stealth()
{
	thread autosave_by_name_thread("autosave_stealth",8,1);
}

//Function Number: 40
autosave_stealth_silent()
{
	thread autosave_by_name_thread("autosave_stealth",8,1,1);
}

//Function Number: 41
autosave_tactical()
{
	maps\_utility_code::autosave_tactical_setup();
	thread maps\_utility_code::autosave_tactical_proc();
}

//Function Number: 42
autosave_by_name(param_00)
{
	thread autosave_by_name_thread(param_00);
}

//Function Number: 43
autosave_by_name_silent(param_00)
{
	thread autosave_by_name_thread(param_00,undefined,undefined,1);
}

//Function Number: 44
autosave_by_name_thread(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.curautosave))
	{
		level.curautosave = 1;
	}

	var_04 = "levelshots/autosave/autosave_" + level.script + level.curautosave;
	var_05 = level maps\_autosave::tryautosave(level.curautosave,"autosave",var_04,param_01,param_02,param_03);
	if(isdefined(var_05) && var_05)
	{
		level.curautosave++;
	}
}

//Function Number: 45
autosave_or_timeout(param_00,param_01)
{
	thread autosave_by_name_thread(param_00,param_01);
}

//Function Number: 46
debug_message(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 5;
	}

	if(isdefined(param_03))
	{
		param_03 endon("death");
		param_01 = param_03.origin;
	}

	for(var_04 = 0;var_04 < param_02 * 20;var_04++)
	{
		if(!isdefined(param_03))
		{
		}
		else
		{
		}

		wait(0.05);
	}
}

//Function Number: 47
debug_message_ai(param_00,param_01)
{
	self notify("debug_message_ai");
	self endon("debug_message_ai");
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = 5;
	}

	for(var_02 = 0;var_02 < param_01 * 20;var_02++)
	{
		wait(0.05);
	}
}

//Function Number: 48
debug_message_clear(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		level notify(param_00 + param_03);
		level endon(param_00 + param_03);
	}
	else
	{
		level notify(param_00);
		level endon(param_00);
	}

	if(!isdefined(param_02))
	{
		param_02 = 5;
	}

	for(var_04 = 0;var_04 < param_02 * 20;var_04++)
	{
		wait(0.05);
	}
}

//Function Number: 49
precache(param_00)
{
	var_01 = spawn("script_model",(0,0,0));
	var_01.origin = level.player getorigin();
	var_01 setmodel(param_00);
	var_01 delete();
}

//Function Number: 50
closerfunc(param_00,param_01)
{
	return param_00 >= param_01;
}

//Function Number: 51
fartherfunc(param_00,param_01)
{
	return param_00 <= param_01;
}

//Function Number: 52
getclosestfx(param_00,param_01,param_02)
{
	return maps\_utility_code::comparesizesfx(param_00,param_01,param_02,::closerfunc);
}

//Function Number: 53
get_closest_point(param_00,param_01,param_02)
{
	var_03 = param_01[0];
	var_04 = distance(param_00,var_03);
	for(var_05 = 0;var_05 < param_01.size;var_05++)
	{
		var_06 = distance(param_00,param_01[var_05]);
		if(var_06 >= var_04)
		{
			continue;
		}

		var_04 = var_06;
		var_03 = param_01[var_05];
	}

	if(!isdefined(param_02) || var_04 <= param_02)
	{
		return var_03;
	}

	return undefined;
}

//Function Number: 54
get_farthest_ent(param_00,param_01)
{
	if(param_01.size < 1)
	{
		return;
	}

	var_02 = distance(param_01[0] getorigin(),param_00);
	var_03 = param_01[0];
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		var_05 = distance(param_01[var_04] getorigin(),param_00);
		if(var_05 < var_02)
		{
			continue;
		}

		var_02 = var_05;
		var_03 = param_01[var_04];
	}

	return var_03;
}

//Function Number: 55
get_within_range(param_00,param_01,param_02)
{
	var_03 = [];
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		if(distance(param_01[var_04].origin,param_00) <= param_02)
		{
			var_03[var_03.size] = param_01[var_04];
		}
	}

	return var_03;
}

//Function Number: 56
get_outside_range(param_00,param_01,param_02)
{
	var_03 = [];
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		if(distance(param_01[var_04].origin,param_00) > param_02)
		{
			var_03[var_03.size] = param_01[var_04];
		}
	}

	return var_03;
}

//Function Number: 57
get_closest_living(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 9999999;
	}

	if(param_01.size < 1)
	{
		return;
	}

	var_03 = undefined;
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		if(!isalive(param_01[var_04]))
		{
			continue;
		}

		var_05 = distance(param_01[var_04].origin,param_00);
		if(var_05 >= param_02)
		{
			continue;
		}

		param_02 = var_05;
		var_03 = param_01[var_04];
	}

	return var_03;
}

//Function Number: 58
get_highest_dot(param_00,param_01,param_02)
{
	if(!param_02.size)
	{
		return;
	}

	var_03 = undefined;
	var_04 = vectortoangles(param_01 - param_00);
	var_05 = anglestoforward(var_04);
	var_06 = -1;
	foreach(var_08 in param_02)
	{
		var_04 = vectortoangles(var_08.origin - param_00);
		var_09 = anglestoforward(var_04);
		var_0A = vectordot(var_05,var_09);
		if(var_0A < var_06)
		{
			continue;
		}

		var_06 = var_0A;
		var_03 = var_08;
	}

	return var_03;
}

//Function Number: 59
get_closest_index(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 9999999;
	}

	if(param_01.size < 1)
	{
		return;
	}

	var_03 = undefined;
	foreach(var_07, var_05 in param_01)
	{
		var_06 = distance(var_05.origin,param_00);
		if(var_06 >= param_02)
		{
			continue;
		}

		param_02 = var_06;
		var_03 = var_07;
	}

	return var_03;
}

//Function Number: 60
get_closest_exclude(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		return undefined;
	}

	var_03 = 0;
	if(isdefined(param_02) && param_02.size)
	{
		var_04 = [];
		for(var_05 = 0;var_05 < param_01.size;var_05++)
		{
			var_04[var_05] = 0;
		}

		for(var_05 = 0;var_05 < param_01.size;var_05++)
		{
			for(var_06 = 0;var_06 < param_02.size;var_06++)
			{
				if(param_01[var_05] == param_02[var_06])
				{
					var_04[var_05] = 1;
				}
			}
		}

		var_07 = 0;
		for(var_05 = 0;var_05 < param_01.size;var_05++)
		{
			if(!var_04[var_05] && isdefined(param_01[var_05]))
			{
				var_07 = 1;
				var_03 = distance(param_00,param_01[var_05].origin);
				var_08 = var_05;
				var_05 = param_01.size + 1;
			}
		}

		if(!var_07)
		{
			return undefined;
		}
	}
	else
	{
		for(var_05 = 0;var_05 < param_01.size;var_05++)
		{
			if(isdefined(param_01[var_05]))
			{
				var_03 = distance(param_00,param_01[0].origin);
				var_08 = var_05;
				var_05 = param_01.size + 1;
			}
		}
	}

	var_08 = undefined;
	for(var_05 = 0;var_05 < param_01.size;var_05++)
	{
		if(isdefined(param_01[var_05]))
		{
			var_04 = 0;
			if(isdefined(param_02))
			{
				for(var_06 = 0;var_06 < param_02.size;var_06++)
				{
					if(param_01[var_05] == param_02[var_06])
					{
						var_04 = 1;
					}
				}
			}

			if(!var_04)
			{
				var_09 = distance(param_00,param_01[var_05].origin);
				if(var_09 <= var_03)
				{
					var_03 = var_09;
					var_08 = var_05;
				}
			}
		}
	}

	if(isdefined(var_08))
	{
		return param_01[var_08];
	}

	return undefined;
}

//Function Number: 61
get_closest_player(param_00)
{
	if(level.players.size == 1)
	{
		return level.player;
	}

	var_01 = common_scripts\utility::getclosest(param_00,level.players);
	return var_01;
}

//Function Number: 62
get_closest_player_healthy(param_00)
{
	if(level.players.size == 1)
	{
		return level.player;
	}

	var_01 = get_players_healthy();
	var_02 = common_scripts\utility::getclosest(param_00,var_01);
	return var_02;
}

//Function Number: 63
get_players_healthy()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(is_player_down(var_02))
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 64
get_closest_ai(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		var_03 = getaiarray(param_01);
	}
	else
	{
		var_03 = getaiarray();
	}

	if(var_03.size == 0)
	{
		return undefined;
	}

	if(isdefined(param_02))
	{
		var_03 = common_scripts\utility::array_remove_array(var_03,param_02);
	}

	return common_scripts\utility::getclosest(param_00,var_03);
}

//Function Number: 65
get_closest_ai_exclude(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		var_03 = getaiarray(param_01);
	}
	else
	{
		var_03 = getaiarray();
	}

	if(var_03.size == 0)
	{
		return undefined;
	}

	return get_closest_exclude(param_00,var_03,param_02);
}

//Function Number: 66
get_progress(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = distance(param_00,param_01);
	}

	param_03 = max(0.01,param_03);
	var_04 = vectornormalize(param_01 - param_00);
	var_05 = param_02 - param_00;
	var_06 = vectordot(var_05,var_04);
	var_06 = var_06 / param_03;
	var_06 = clamp(var_06,0,1);
	return var_06;
}

//Function Number: 67
can_see_origin(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!point_in_fov(param_00))
	{
		return 0;
	}

	if(!sighttracepassed(self geteye(),param_00,param_01,self))
	{
		return 0;
	}

	return 1;
}

//Function Number: 68
point_in_fov(param_00)
{
	var_01 = anglestoforward(self.angles);
	var_02 = vectornormalize(param_00 - self.origin);
	var_03 = vectordot(var_01,var_02);
	return var_03 > 0.766;
}

//Function Number: 69
stop_magic_bullet_shield()
{
	self notify("stop_magic_bullet_shield");
	if(isai(self))
	{
		self.attackeraccuracy = 1;
	}

	self.magic_bullet_shield = undefined;
	self.damageshield = 0;
	self notify("internal_stop_magic_bullet_shield");
}

//Function Number: 70
magic_bullet_death_detection()
{
}

//Function Number: 71
magic_bullet_shield(param_00)
{
	if(isai(self))
	{
	}
	else
	{
		self.health = 100000;
	}

	self endon("internal_stop_magic_bullet_shield");
	if(isai(self))
	{
		self.attackeraccuracy = 0.1;
	}

	self notify("magic_bullet_shield");
	self.magic_bullet_shield = 1;
	self.damageshield = 1;
	self.noragdoll = 1;
}

//Function Number: 72
disable_long_death()
{
	self.a.disablelongdeath = 1;
}

//Function Number: 73
enable_long_death()
{
	self.a.disablelongdeath = 0;
}

//Function Number: 74
enable_blood_pool()
{
	self.skipbloodpool = undefined;
}

//Function Number: 75
disable_blood_pool()
{
	self.skipbloodpool = 1;
}

//Function Number: 76
deletable_magic_bullet_shield()
{
	magic_bullet_shield(1);
}

//Function Number: 77
get_ignoreme()
{
	return self.ignoreme;
}

//Function Number: 78
set_ignoreme(param_00)
{
	self.ignoreme = param_00;
}

//Function Number: 79
set_ignoreall(param_00)
{
	self.ignoreall = param_00;
}

//Function Number: 80
set_ignoresonicaoe(param_00)
{
	self.ignoresonicaoe = param_00;
}

//Function Number: 81
set_favoriteenemy(param_00)
{
	self.favoriteenemy = param_00;
}

//Function Number: 82
get_pacifist()
{
	return self.pacifist;
}

//Function Number: 83
set_pacifist(param_00)
{
	self.pacifist = param_00;
}

//Function Number: 84
ignore_me_timer(param_00)
{
	self notify("new_ignore_me_timer");
	self endon("new_ignore_me_timer");
	self endon("death");
	if(!isdefined(self.ignore_me_timer_prev_value))
	{
		self.ignore_me_timer_prev_value = self.ignoreme;
	}

	var_01 = getaiarray("bad_guys");
	foreach(var_03 in var_01)
	{
		if(!isalive(var_03.enemy))
		{
			continue;
		}

		if(var_03.enemy != self)
		{
			continue;
		}

		var_03 clearenemy();
	}

	self.ignoreme = 1;
	wait(param_00);
	self.ignoreme = self.ignore_me_timer_prev_value;
	self.ignore_me_timer_prev_value = undefined;
}

//Function Number: 85
delete_exploder(param_00)
{
	common_scripts\_exploder::delete_exploder_proc(param_00);
}

//Function Number: 86
hide_exploder_models(param_00)
{
	common_scripts\_exploder::hide_exploder_models_proc(param_00);
}

//Function Number: 87
show_exploder_models(param_00)
{
	common_scripts\_exploder::show_exploder_models_proc(param_00);
}

//Function Number: 88
stop_exploder(param_00)
{
	common_scripts\_exploder::stop_exploder_proc(param_00);
}

//Function Number: 89
get_exploder_array(param_00)
{
	return common_scripts\_exploder::get_exploder_array_proc(param_00);
}

//Function Number: 90
flood_spawn(param_00)
{
	maps\_spawner::flood_spawner_scripted(param_00);
}

//Function Number: 91
set_ambient(param_00,param_01)
{
	soundscripts\_audio_zone_manager::azm_start_zone(param_00,param_01);
}

//Function Number: 92
force_crawling_death(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = 4;
	}

	thread force_crawling_death_proc(param_00,param_01,param_02,param_03);
}

//Function Number: 93
override_crawl_death_anims()
{
	if(isdefined(self.a.custom_crawling_death_array))
	{
		self.a.array["crawl"] = self.a.custom_crawling_death_array["crawl"];
		self.a.array["death"] = self.a.custom_crawling_death_array["death"];
		self.a.crawl_fx_rate = self.a.custom_crawling_death_array["blood_fx_rate"];
		if(isdefined(self.a.custom_crawling_death_array["blood_fx"]))
		{
			self.a.crawl_fx = self.a.custom_crawling_death_array["blood_fx"];
		}
	}

	self.a.array["stand_2_crawl"] = [];
	self.a.array["stand_2_crawl"][0] = %dying_stand_2_crawl_v3;
	if(isdefined(self.nofallanim))
	{
		self.a.pose = "prone";
	}

	self orientmode("face angle",self.a.force_crawl_angle);
	self.a.force_crawl_angle = undefined;
}

//Function Number: 94
force_crawling_death_proc(param_00,param_01,param_02,param_03)
{
	self.forcelongdeath = 1;
	self.a.force_num_crawls = param_01;
	self.noragdoll = 1;
	self.nofallanim = param_03;
	self.a.custom_crawling_death_array = param_02;
	self.crawlingpainanimoverridefunc = ::override_crawl_death_anims;
	self.maxhealth = 100000;
	self.health = 100000;
	enable_long_death();
	if(!isdefined(param_03) || param_03 == 0)
	{
		self.a.force_crawl_angle = param_00 + 181.02;
		return;
	}

	self.a.force_crawl_angle = param_00;
	thread animscripts\notetracks::notetrackposecrawl();
}

//Function Number: 95
never_saw_it_coming()
{
	self endon("death");
	for(;;)
	{
		var_00 = self ishighjumping();
		if(var_00)
		{
			var_01 = common_scripts\utility::waittill_any_return("exo_dodge","player_boost_land","disable_high_jump");
			if(!isdefined(var_01) || var_01 == "player_boost_land" || var_01 == "disable_high_jump")
			{
				continue;
			}

			if(!isdefined(self.never_saw_it_coming))
			{
				self.never_saw_it_coming = 1;
			}

			common_scripts\utility::waittill_any("player_boost_land","disable_high_jump");
			wait 0.05;
			self.never_saw_it_coming = undefined;
		}

		wait 0.05;
	}
}

//Function Number: 96
check_man_overboard()
{
	if(getdvar("mapname","undefined") != "sanfran_b")
	{
		return;
	}

	if(!isdefined(level.player.man_overboard) || !level.player.man_overboard)
	{
		level.player.man_overboard = 1;
	}

	wait(2);
	level.player.man_overboard = undefined;
}

//Function Number: 97
monitor_genius_achievement(param_00,param_01,param_02)
{
	if(param_01 != "MOD_GRENADE")
	{
		param_00.genius_achievement = undefined;
		return;
	}

	if(!isdefined(param_00.genius_achievement))
	{
		param_00.genius_achievement = 1;
	}
	else
	{
		param_00.genius_achievement++;
	}

	if(param_00.genius_achievement == 4)
	{
		giveachievement_wrapper("SMART_GRENADE_KILL");
	}

	wait(0.1);
	param_00.genius_achievement = undefined;
}

//Function Number: 98
start_monitor_escape_artist()
{
	add_global_spawn_function("axis",::monitor_escape_artist);
	common_scripts\utility::array_thread(getaiarray("axis"),::monitor_escape_artist);
	level.grenade_id = 0;
	level.player.escape_artist = [];
}

//Function Number: 99
monitor_escape_artist()
{
	for(;;)
	{
		var_00 = undefined;
		self waittill("grenade_fire",var_00,var_01);
		var_00.unique_id = level.grenade_id;
		level.grenade_id++;
		var_00.owner = self.unique_id;
		var_00 thread escape_artist_distance();
		var_00 thread escape_artist();
	}
}

//Function Number: 100
escape_artist_distance()
{
	var_00 = level.player;
	var_01 = self.unique_id;
	while(isdefined(self))
	{
		var_02 = var_00.origin - self.origin;
		var_03 = getweaponexplosionradius("fraggrenade") + 23;
		var_04 = squared(var_03);
		var_05 = lengthsquared(var_02);
		if(var_05 > var_04)
		{
			if(isdefined(var_00.escape_artist[self.unique_id]))
			{
				var_00.escape_artist[self.unique_id] = undefined;
			}

			continue;
		}

		if(!isdefined(var_00.escape_artist[self.unique_id]))
		{
			if(isdefined(self.owner))
			{
				var_00.escape_artist[self.unique_id] = 1;
			}
		}

		wait 0.05;
	}

	if(isdefined(var_00.escape_artist[var_01]))
	{
		var_00.escape_artist[var_01] = undefined;
	}
}

//Function Number: 101
escape_artist()
{
	var_00 = level.player;
	while(isdefined(self))
	{
		if(isdefined(var_00.escape_artist[self.unique_id]))
		{
			var_01 = level.player common_scripts\utility::waittill_any_timeout(4,"exo_dodge");
			if(isdefined(var_01) && var_01 == "exo_dodge")
			{
				thread check_grenade_dmg();
			}

			continue;
		}

		wait 0.05;
	}
}

//Function Number: 102
check_grenade_dmg()
{
	level.player endon("death");
	while(isdefined(self))
	{
		var_00 = level.player waittill_dmg_timeout(1,"damage");
		if(isdefined(var_00) && isarray(var_00))
		{
			if(var_00[5] == "MOD_GRENADE_SPLASH" && !isdefined(level.player.escape_artist_failure))
			{
				if(var_00[2].unique_id == self.owner && isdefined(level.player.escape_artist[self.unique_id]))
				{
					level.player.escape_artist_failure = 1;
				}
			}

			continue;
		}

		wait 0.05;
	}

	if(!isdefined(level.player.escape_artist_failure))
	{
		level.player escape_artist_success();
		return;
	}

	level.player.escape_artist_failure = undefined;
}

//Function Number: 103
escape_artist_success()
{
	var_00 = self getlocalplayerprofiledata("ach_escapeArtist") + 1;
	if(var_00 == 20)
	{
		giveachievement_wrapper("GRENADE_DODGE");
	}

	self setlocalplayerprofiledata("ach_escapeArtist",var_00);
}

//Function Number: 104
waittill_dmg_timeout(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 != "death")
	{
		self endon("death");
	}

	var_02 = spawnstruct();
	if(isdefined(param_01))
	{
		childthread common_scripts\utility::waittill_string_parms(param_01,var_02);
	}

	var_02 childthread common_scripts\utility::_timeout(param_00);
	var_02 waittill("returned",var_03);
	var_02 notify("die");
	return var_03;
}

//Function Number: 105
shock_ondeath()
{
	precacheshellshock("default");
	self waittill("death");
	if(isdefined(self.specialdeath))
	{
		return;
	}

	if(getdvar("r_texturebits") == "16")
	{
		return;
	}

	self shellshock("default",3);
}

//Function Number: 106
playerwatch_unresolved_collision()
{
	self endon("death");
	self endon("stop_unresolved_collision_script");
	reset_unresolved_collision_handler();
	childthread playerwatch_unresolved_collision_count();
	for(;;)
	{
		if(self.unresolved_collision)
		{
			self.unresolved_collision = 0;
			if(self.unresolved_collision_count >= 20)
			{
				if(isdefined(self.handle_unresolved_collision))
				{
					self [[ self.handle_unresolved_collision ]]();
				}
				else
				{
					default_unresolved_collision_handler();
				}
			}
		}
		else
		{
			reset_unresolved_collision_handler();
		}

		wait(0.05);
	}
}

//Function Number: 107
playerwatch_unresolved_collision_count()
{
	for(;;)
	{
		self waittill("unresolved_collision");
		self.unresolved_collision = 1;
		self.unresolved_collision_count++;
	}
}

//Function Number: 108
reset_unresolved_collision_handler()
{
	self.unresolved_collision = 0;
	self.unresolved_collision_count = 0;
}

//Function Number: 109
default_unresolved_collision_handler()
{
	var_00 = getnodesinradiussorted(self.origin,300,0,200,"Path");
	if(var_00.size)
	{
		self cancelmantle();
		self dontinterpolate();
		self setorigin(var_00[0].origin);
		reset_unresolved_collision_handler();
		return;
	}

	self kill();
}

//Function Number: 110
stop_playerwatch_unresolved_collision()
{
	self notify("stop_unresolved_collision_script");
	reset_unresolved_collision_handler();
}

//Function Number: 111
delete_on_death_wait_sound(param_00,param_01)
{
	param_00 endon("death");
	self waittill("death");
	if(isdefined(param_00))
	{
		if(param_00 iswaitingonsound())
		{
			param_00 waittill(param_01);
		}

		param_00 delete();
	}
}

//Function Number: 112
is_dead_sentient()
{
	return issentient(self) && !isalive(self);
}

//Function Number: 113
play_sound_on_tag(param_00,param_01,param_02,param_03,param_04)
{
	if(is_dead_sentient())
	{
		return;
	}

	if(!soundexists(param_00))
	{
		return;
	}

	var_05 = spawn("script_origin",(0,0,0));
	var_05 endon("death");
	thread delete_on_death_wait_sound(var_05,"sounddone");
	if(isdefined(param_01))
	{
		var_05 linkto(self,param_01,(0,0,0),(0,0,0));
	}
	else
	{
		var_05.origin = self.origin;
		var_05.angles = self.angles;
		var_05 linkto(self);
	}

	var_05 playsound(param_00,"sounddone");
	if(isdefined(param_02))
	{
		if(!isdefined(maps\_utility_code::wait_for_sounddone_or_death(var_05)))
		{
			var_05 stopsounds();
		}

		wait(0.05);
	}
	else
	{
		var_05 waittill("sounddone");
	}

	if(isdefined(param_03))
	{
		self notify(param_03);
	}

	var_05 delete();
}

//Function Number: 114
play_sound_on_tag_endon_death(param_00,param_01)
{
	play_sound_on_tag(param_00,param_01,1);
}

//Function Number: 115
play_sound_on_entity(param_00,param_01)
{
	play_sound_on_tag(param_00,undefined,undefined,param_01);
}

//Function Number: 116
play_loop_sound_on_tag(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_origin",(0,0,0));
	var_04 endon("death");
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(param_02)
	{
		thread common_scripts\utility::delete_on_death(var_04);
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(param_03)
	{
		thread delete_on_removed(var_04);
	}

	if(isdefined(param_01))
	{
		var_04 linkto(self,param_01,(0,0,0),(0,0,0));
	}
	else
	{
		var_04.origin = self.origin;
		var_04.angles = self.angles;
		var_04 linkto(self);
	}

	var_04 playloopsound(param_00);
	self waittill("stop sound" + param_00);
	var_04 stoploopsound(param_00);
	var_04 delete();
}

//Function Number: 117
delete_on_removed(param_00)
{
	param_00 endon("death");
	while(isdefined(self))
	{
		wait(0.05);
	}

	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 118
save_friendlies()
{
	var_00 = getaiarray("allies");
	var_01 = 0;
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(isdefined(var_00[var_02].script_friendname))
		{
			continue;
		}

		game["character" + var_01] = var_00[var_02] codescripts\character::save();
		var_01++;
	}

	game["total characters"] = var_01;
}

//Function Number: 119
spawn_failed(param_00)
{
	if(!isalive(param_00))
	{
		return 1;
	}

	if(!isdefined(param_00.finished_spawning))
	{
		param_00 common_scripts\utility::waittill_either("finished spawning","death");
	}

	if(isalive(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 120
spawn_setcharacter(param_00)
{
	codescripts\character::precache(param_00);
	self waittill("spawned",var_01);
	if(spawn_failed(var_01))
	{
		return;
	}

	var_01 codescripts\character::new();
	var_01 codescripts\character::load(param_00);
}

//Function Number: 121
key_hint_print(param_00,param_01)
{
	iprintlnbold(param_00,param_01["key1"]);
}

//Function Number: 122
view_tag(param_00)
{
	self endon("death");
	for(;;)
	{
		maps\_debug::drawtag(param_00);
		wait(0.05);
	}
}

//Function Number: 123
assign_animtree(param_00)
{
	if(isdefined(param_00))
	{
		self.animname = param_00;
	}

	self useanimtree(level.scr_animtree[self.animname]);
}

//Function Number: 124
assign_model()
{
	if(isarray(level.scr_model[self.animname]))
	{
		var_00 = randomint(level.scr_model[self.animname].size);
		self setmodel(level.scr_model[self.animname][var_00]);
		return;
	}

	self setmodel(level.scr_model[self.animname]);
}

//Function Number: 125
spawn_anim_model(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = (0,0,0);
	}

	var_03 = spawn("script_model",param_01);
	var_03.animname = param_00;
	var_03 assign_animtree();
	var_03 assign_model();
	if(isdefined(param_02))
	{
		var_03.angles = param_02;
	}

	return var_03;
}

//Function Number: 126
trigger_wait(param_00,param_01)
{
	var_02 = getent(param_00,param_01);
	if(!isdefined(var_02))
	{
		return;
	}

	var_02 waittill("trigger",var_03);
	level notify(param_00,var_03);
	return var_03;
}

//Function Number: 127
trigger_wait_targetname(param_00)
{
	return trigger_wait(param_00,"targetname");
}

//Function Number: 128
set_flag_on_dead(param_00,param_01)
{
	thread set_flag_on_func_wait_proc(param_00,param_01,::waittill_dead,"set_flag_on_dead");
}

//Function Number: 129
set_flag_on_dead_or_dying(param_00,param_01)
{
	thread set_flag_on_func_wait_proc(param_00,param_01,::waittill_dead_or_dying,"set_flag_on_dead_or_dying");
}

//Function Number: 130
set_flag_on_spawned(param_00,param_01)
{
	thread set_flag_on_func_wait_proc(param_00,param_01,::empty_func,"set_flag_on_spawned");
}

//Function Number: 131
empty_func(param_00)
{
}

//Function Number: 132
set_flag_on_spawned_ai_proc(param_00,param_01)
{
	self waittill("spawned",var_02);
	if(spawn_failed(var_02))
	{
		return;
	}

	param_00.ai[param_00.ai.size] = var_02;
	ent_flag_set(param_01);
}

//Function Number: 133
set_flag_on_func_wait_proc(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.ai = [];
	foreach(var_06 in param_00)
	{
		var_06 ent_flag_init(param_03);
	}

	common_scripts\utility::array_thread(param_00,::set_flag_on_spawned_ai_proc,var_04,param_03);
	foreach(var_06 in param_00)
	{
		var_06 ent_flag_wait(param_03);
	}

	[[ param_02 ]](var_04.ai);
	common_scripts\utility::flag_set(param_01);
}

//Function Number: 134
set_flag_on_trigger(param_00,param_01)
{
	if(!common_scripts\utility::flag(param_01))
	{
		param_00 waittill("trigger",var_02);
		common_scripts\utility::flag_set(param_01);
		return var_02;
	}
}

//Function Number: 135
set_flag_on_targetname_trigger(param_00)
{
	if(common_scripts\utility::flag(param_00))
	{
		return;
	}

	var_01 = getent(param_00,"targetname");
	var_01 waittill("trigger");
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 136
is_in_array(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(param_00[var_02] == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 137
waittill_dead(param_00,param_01,param_02)
{
	var_0A = spawnstruct();
	if(isdefined(param_02))
	{
		var_0A endon("thread_timed_out");
		var_0A thread waittill_dead_timeout(param_02);
	}

	var_0A.count = param_00.size;
	if(isdefined(param_01) && param_01 < var_0A.count)
	{
		var_0A.count = param_01;
	}

	common_scripts\utility::array_thread(param_00,::waittill_dead_thread,var_0A);
	while(var_0A.count > 0)
	{
		var_0A waittill("waittill_dead guy died");
	}
}

//Function Number: 138
waittill_dead_or_dying(param_00,param_01,param_02)
{
	var_03 = [];
	foreach(var_05 in param_00)
	{
		if(isalive(var_05) && !var_05.ignoreforfixednodesafecheck)
		{
			var_03[var_03.size] = var_05;
		}
	}

	param_00 = var_03;
	var_07 = spawnstruct();
	if(isdefined(param_02))
	{
		var_07 endon("thread_timed_out");
		var_07 thread waittill_dead_timeout(param_02);
	}

	var_07.count = param_00.size;
	if(isdefined(param_01) && param_01 < var_07.count)
	{
		var_07.count = param_01;
	}

	common_scripts\utility::array_thread(param_00,::waittill_dead_or_dying_thread,var_07);
	while(var_07.count > 0)
	{
		var_07 waittill("waittill_dead_guy_dead_or_dying");
	}
}

//Function Number: 139
waittill_dead_thread(param_00)
{
	self waittill("death");
	param_00.count--;
	param_00 notify("waittill_dead guy died");
}

//Function Number: 140
waittill_dead_or_dying_thread(param_00)
{
	common_scripts\utility::waittill_either("death","pain_death");
	param_00.count--;
	param_00 notify("waittill_dead_guy_dead_or_dying");
}

//Function Number: 141
waittill_dead_timeout(param_00)
{
	wait(param_00);
	self notify("thread_timed_out");
}

//Function Number: 142
waittill_aigroupcleared(param_00)
{
	while(level._ai_group[param_00].spawnercount || level._ai_group[param_00].aicount)
	{
		wait(0.25);
	}
}

//Function Number: 143
waittill_aigroupcount(param_00,param_01)
{
	while(level._ai_group[param_00].spawnercount + level._ai_group[param_00].aicount > param_01)
	{
		wait(0.25);
	}
}

//Function Number: 144
get_ai_group_count(param_00)
{
	return level._ai_group[param_00].spawnercount + level._ai_group[param_00].aicount;
}

//Function Number: 145
get_ai_group_sentient_count(param_00)
{
	return level._ai_group[param_00].aicount;
}

//Function Number: 146
get_ai_group_ai(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level._ai_group[param_00].ai.size;var_02++)
	{
		if(!isalive(level._ai_group[param_00].ai[var_02]))
		{
			continue;
		}

		var_01[var_01.size] = level._ai_group[param_00].ai[var_02];
	}

	return var_01;
}

//Function Number: 147
waittill_notetrack_or_damage(param_00)
{
	self endon("damage");
	self endon("death");
	self waittillmatch(param_00,"single anim");
}

//Function Number: 148
get_living_ai(param_00,param_01)
{
	var_02 = get_living_ai_array(param_00,param_01);
	if(var_02.size > 1)
	{
		return undefined;
	}

	return var_02[0];
}

//Function Number: 149
get_living_ai_array(param_00,param_01)
{
	var_02 = getaispeciesarray("all","all");
	var_03 = [];
	var_04 = var_02;
	var_06 = getfirstarraykey(var_04);
	if(isdefined(var_06))
	{
		var_05 = var_04[var_06];
		if(!isalive(var_05))
		{
			continue;
		}

		switch(param_01)
		{
			case "targetname":
				break;

			case "script_noteworthy":
				break;
		}
	}
}

//Function Number: 150
get_vehicle(param_00,param_01)
{
	var_02 = get_vehicle_array(param_00,param_01);
	if(!var_02.size)
	{
		return undefined;
	}

	return var_02[0];
}

//Function Number: 151
get_vehicle_array(param_00,param_01)
{
	var_02 = getentarray(param_00,param_01);
	var_03 = [];
	var_04 = [];
	foreach(var_06 in var_02)
	{
		if(var_06.code_classname != "script_vehicle")
		{
			continue;
		}

		var_04[0] = var_06;
		if(isspawner(var_06))
		{
			if(isdefined(var_06.last_spawned_vehicle))
			{
				var_04[0] = var_06.last_spawned_vehicle;
				var_03 = array_merge(var_03,var_04);
			}

			continue;
		}

		var_03 = array_merge(var_03,var_04);
	}

	return var_03;
}

//Function Number: 152
get_living_aispecies(param_00,param_01,param_02)
{
	var_03 = get_living_aispecies_array(param_00,param_01,param_02);
	if(var_03.size > 1)
	{
		return undefined;
	}

	return var_03[0];
}

//Function Number: 153
get_living_aispecies_array(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = "all";
	}

	var_03 = getaispeciesarray("allies",param_02);
	var_03 = common_scripts\utility::array_combine(var_03,getaispeciesarray("axis",param_02));
	var_04 = [];
	var_05 = 0;
	if(var_05 < var_03.size)
	{
		switch(param_01)
		{
			case "targetname":
				break;

			case "script_noteworthy":
				break;
		}
	}
}

//Function Number: 154
gather_delay_proc(param_00,param_01)
{
	if(isdefined(level.gather_delay[param_00]))
	{
		if(level.gather_delay[param_00])
		{
			wait(0.05);
			if(isalive(self))
			{
				self notify("gather_delay_finished" + param_00 + param_01);
			}

			return;
		}

		level waittill(param_00);
		if(isalive(self))
		{
			self notify("gather_delay_finished" + param_00 + param_01);
		}

		return;
	}

	level.gather_delay[param_00] = 0;
	wait(param_01);
	level.gather_delay[param_00] = 1;
	level notify(param_00);
	if(isalive(self))
	{
		self notify("gat    her_delay_finished" + param_00 + param_01);
	}
}

//Function Number: 155
gather_delay(param_00,param_01)
{
	thread gather_delay_proc(param_00,param_01);
	self waittill("gather_delay_finished" + param_00 + param_01);
}

//Function Number: 156
death_waiter(param_00)
{
	self waittill("death");
	level notify(param_00);
}

//Function Number: 157
getchar(param_00)
{
	if(param_00 == 0)
	{
		return "0";
	}

	if(param_00 == 1)
	{
		return "1";
	}

	if(param_00 == 2)
	{
		return "2";
	}

	if(param_00 == 3)
	{
		return "3";
	}

	if(param_00 == 4)
	{
		return "4";
	}

	if(param_00 == 5)
	{
		return "5";
	}

	if(param_00 == 6)
	{
		return "6";
	}

	if(param_00 == 7)
	{
		return "7";
	}

	if(param_00 == 8)
	{
		return "8";
	}

	if(param_00 == 9)
	{
		return "9";
	}
}

//Function Number: 158
getlinks_array(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = param_00[var_03];
		var_05 = var_04.script_linkname;
		if(!isdefined(var_05))
		{
			continue;
		}

		if(!isdefined(param_01[var_05]))
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	return var_02;
}

//Function Number: 159
array_merge_links(param_00,param_01)
{
	if(!param_00.size)
	{
		return param_01;
	}

	if(!param_01.size)
	{
		return param_00;
	}

	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = param_00[var_03];
		var_02[var_04.script_linkname] = 1;
	}

	for(var_03 = 0;var_03 < param_01.size;var_03++)
	{
		var_04 = param_01[var_03];
		if(isdefined(var_02[var_04.script_linkname]))
		{
			continue;
		}

		var_02[var_04.script_linkname] = 1;
		param_00[param_00.size] = var_04;
	}

	return param_00;
}

//Function Number: 160
array_merge(param_00,param_01)
{
	if(param_00.size == 0)
	{
		return param_01;
	}

	if(param_01.size == 0)
	{
		return param_00;
	}

	var_02 = param_00;
	foreach(var_04 in param_01)
	{
		var_05 = 0;
		foreach(var_07 in param_00)
		{
			if(var_07 == var_04)
			{
				var_05 = 1;
				break;
			}
		}

		if(var_05)
		{
			continue;
		}
		else
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 161
array_exclude(param_00,param_01)
{
	var_02 = param_00;
	for(var_03 = 0;var_03 < param_01.size;var_03++)
	{
		if(is_in_array(param_00,param_01[var_03]))
		{
			var_02 = common_scripts\utility::array_remove(var_02,param_01[var_03]);
		}
	}

	return var_02;
}

//Function Number: 162
array_compare(param_00,param_01)
{
	if(param_00.size != param_01.size)
	{
		return 0;
	}

	foreach(var_05, var_03 in param_00)
	{
		if(!isdefined(param_01[var_05]))
		{
			return 0;
		}

		var_04 = param_01[var_05];
		if(var_04 != var_03)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 163
getlinkedvehiclenodes()
{
	var_00 = [];
	if(isdefined(self.script_linkto))
	{
		var_01 = common_scripts\utility::get_links();
		foreach(var_03 in var_01)
		{
			var_04 = getvehiclenodearray(var_03,"script_linkname");
			var_00 = common_scripts\utility::array_combine(var_00,var_04);
		}
	}

	return var_00;
}

//Function Number: 164
draw_line(param_00,param_01,param_02,param_03,param_04)
{
	wait(0.05);
}

//Function Number: 165
draw_line_to_ent_for_time(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_05 = gettime() + param_05 * 1000;
	while(gettime() < param_05)
	{
		wait(0.05);
		if(!isdefined(param_01) || !isdefined(param_01.origin))
		{
			return;
		}
	}
}

//Function Number: 166
draw_line_from_ent_for_time(param_00,param_01,param_02,param_03,param_04,param_05)
{
	draw_line_to_ent_for_time(param_01,param_00,param_02,param_03,param_04,param_05);
}

//Function Number: 167
draw_line_from_ent_to_ent_for_time(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 endon("death");
	param_01 endon("death");
	param_05 = gettime() + param_05 * 1000;
	while(gettime() < param_05)
	{
		wait(0.05);
	}
}

//Function Number: 168
draw_line_from_ent_to_ent_until_notify(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_00 endon("death");
	param_01 endon("death");
	param_05 endon(param_06);
	wait(0.05);
}

//Function Number: 169
draw_line_until_notify(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_05 endon(param_06);
	common_scripts\utility::draw_line_for_time(param_00,param_01,param_02,param_03,param_04,0.05);
}

//Function Number: 170
draw_line_from_ent_to_vec_for_time(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_06 = gettime() + param_06 * 1000;
	param_01 = param_01 * param_02;
	while(gettime() < param_06)
	{
		wait(0.05);
		if(!isdefined(param_00) || !isdefined(param_00.origin))
		{
			return;
		}
	}
}

//Function Number: 171
draw_circle_until_notify(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(isdefined(param_07))
	{
		var_08 = param_07;
	}
	else
	{
		var_08 = 16;
	}

	var_09 = 360 / var_08;
	var_0A = [];
	for(var_0B = 0;var_0B < var_08;var_0B++)
	{
		var_0C = var_09 * var_0B;
		var_0D = cos(var_0C) * param_01;
		var_0E = sin(var_0C) * param_01;
		var_0F = param_00[0] + var_0D;
		var_10 = param_00[1] + var_0E;
		var_11 = param_00[2];
		var_0A[var_0A.size] = (var_0F,var_10,var_11);
	}

	thread draw_circle_lines_until_notify(var_0A,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 172
draw_circle_for_time(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 16;
	var_07 = 360 / var_06;
	var_08 = [];
	for(var_09 = 0;var_09 < var_06;var_09++)
	{
		var_0A = var_07 * var_09;
		var_0B = cos(var_0A) * param_01;
		var_0C = sin(var_0A) * param_01;
		var_0D = param_00[0] + var_0B;
		var_0E = param_00[1] + var_0C;
		var_0F = param_00[2];
		var_08[var_08.size] = (var_0D,var_0E,var_0F);
	}

	thread draw_circle_lines_for_time(var_08,param_02,param_03,param_04,param_05);
}

//Function Number: 173
draw_circle_lines_for_time(param_00,param_01,param_02,param_03,param_04)
{
	for(var_05 = 0;var_05 < param_00.size;var_05++)
	{
		var_06 = param_00[var_05];
		if(var_05 + 1 >= param_00.size)
		{
			var_07 = param_00[0];
		}
		else
		{
			var_07 = param_00[var_05 + 1];
		}

		thread common_scripts\utility::draw_line_for_time(var_06,var_07,param_01,param_02,param_03,param_04);
	}
}

//Function Number: 174
draw_circle_lines_until_notify(param_00,param_01,param_02,param_03,param_04,param_05)
{
	for(var_06 = 0;var_06 < param_00.size;var_06++)
	{
		var_07 = param_00[var_06];
		if(var_06 + 1 >= param_00.size)
		{
			var_08 = param_00[0];
		}
		else
		{
			var_08 = param_00[var_06 + 1];
		}

		thread draw_line_until_notify(var_07,var_08,param_01,param_02,param_03,param_04,param_05);
	}
}

//Function Number: 175
clear_enemy_passthrough()
{
	self notify("enemy");
	self clearenemy();
}

//Function Number: 176
battlechatter_off(param_00)
{
	level notify("battlechatter_off_thread");
	maps\_dds::dds_disable(param_00);
	animscripts\battlechatter::bcs_setup_chatter_toggle_array();
	if(isdefined(param_00))
	{
		set_battlechatter_variable(param_00,0);
		var_01 = getaiarray(param_00);
	}
	else
	{
		foreach(param_00 in level.teams)
		{
			set_battlechatter_variable(param_00,0);
		}

		var_01 = getaiarray();
	}

	if(!isdefined(level.chatinitialized) || !level.chatinitialized)
	{
		return;
	}

	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		var_01[var_04].battlechatter = 0;
	}

	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		var_05 = var_01[var_04];
		if(!isalive(var_05))
		{
			continue;
		}

		if(!var_05.chatinitialized)
		{
			continue;
		}

		if(!var_05.isspeaking)
		{
			continue;
		}

		var_05 maps\_utility_code::wait_until_done_speaking();
	}

	var_06 = gettime() - level.lastteamspeaktime["allies"];
	if(var_06 < 1500)
	{
		wait(var_06 / 1000);
	}

	if(isdefined(param_00))
	{
		level notify(param_00 + " done speaking");
		return;
	}

	level notify("done speaking");
}

//Function Number: 177
battlechatter_on(param_00)
{
	thread battlechatter_on_thread(param_00);
	maps\_dds::dds_enable(param_00);
}

//Function Number: 178
battlechatter_on_thread(param_00)
{
	level endon("battlechatter_off_thread");
	animscripts\battlechatter::bcs_setup_chatter_toggle_array();
	while(!isdefined(level.chatinitialized))
	{
		wait(0.05);
	}

	common_scripts\utility::flag_set("battlechatter_on_thread_waiting");
	wait(1.5);
	common_scripts\utility::flag_clear("battlechatter_on_thread_waiting");
	if(isdefined(param_00))
	{
		set_battlechatter_variable(param_00,1);
		var_01 = getaiarray(param_00);
	}
	else
	{
		foreach(param_00 in level.teams)
		{
			set_battlechatter_variable(param_00,1);
		}

		var_01 = getaiarray();
	}

	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		var_01[var_04] set_battlechatter(1);
	}
}

//Function Number: 179
set_battlechatter(param_00)
{
	dds_exclude_this_ai(!param_00);
	if(!isdefined(level.chatinitialized) || !level.chatinitialized)
	{
		return;
	}

	if(self.type == "dog")
	{
		return;
	}

	if(param_00)
	{
		if(isdefined(self.script_bcdialog) && !self.script_bcdialog)
		{
			self.battlechatter = 0;
			return;
		}

		self.battlechatter = 1;
		return;
	}

	self.battlechatter = 0;
	if(isdefined(self.isspeaking) && self.isspeaking)
	{
		self waittill("done speaking");
	}
}

//Function Number: 180
set_team_bcvoice(param_00,param_01)
{
	if(!level.chatinitialized)
	{
		return;
	}

	var_02 = getarraykeys(level.countryids);
	var_03 = common_scripts\utility::array_contains(var_02,param_01);
	if(!var_03)
	{
		return;
	}

	var_04 = getaiarray(param_00);
	foreach(var_06 in var_04)
	{
		var_06 set_ai_bcvoice(param_01);
		wait 0.05;
	}
}

//Function Number: 181
set_ai_bcvoice(param_00)
{
	if(!level.chatinitialized)
	{
		return;
	}

	var_01 = getarraykeys(level.countryids);
	var_02 = common_scripts\utility::array_contains(var_01,param_00);
	if(!var_02)
	{
		return;
	}

	if(self.type == "dog")
	{
		return;
	}

	if(isdefined(self.isspeaking) && self.isspeaking)
	{
		self waittill("done speaking");
		wait(0.1);
	}

	animscripts\battlechatter_ai::removefromsystem();
	waittillframeend;
	self.voice = param_00;
	animscripts\battlechatter_ai::addtosystem();
}

//Function Number: 182
flavorbursts_on(param_00)
{
	thread set_flavorbursts_team_state(1,param_00);
}

//Function Number: 183
flavorbursts_off(param_00)
{
	thread set_flavorbursts_team_state(0,param_00);
}

//Function Number: 184
set_flavorbursts_team_state(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "allies";
	}

	if(!level.chatinitialized)
	{
		return;
	}

	wait(1.5);
	level.flavorbursts[param_01] = param_00;
	var_02 = [];
	var_02 = getaiarray(param_01);
	common_scripts\utility::array_thread(var_02,::set_flavorbursts,param_00);
}

//Function Number: 185
set_flavorbursts(param_00)
{
	self.flavorbursts = param_00;
}

//Function Number: 186
friendlyfire_warnings_off()
{
	var_00 = getaiarray("allies");
	foreach(var_02 in var_00)
	{
		if(isalive(var_02))
		{
			var_02 set_friendlyfire_warnings(0);
		}
	}

	level.friendlyfire_warnings = 0;
}

//Function Number: 187
friendlyfire_warnings_on()
{
	var_00 = getaiarray("allies");
	foreach(var_02 in var_00)
	{
		if(isalive(var_02))
		{
			var_02 set_friendlyfire_warnings(1);
		}
	}

	level.friendlyfire_warnings = 1;
}

//Function Number: 188
set_friendlyfire_warnings(param_00)
{
	if(param_00)
	{
		self.friendlyfire_warnings_disable = undefined;
		return;
	}

	self.friendlyfire_warnings_disable = 1;
}

//Function Number: 189
dds_set_player_character_name(param_00)
{
	if(!isplayer(self))
	{
		return;
	}

	switch(param_00)
	{
		case "reznov":
		case "hudson":
		case "mason":
			break;

		default:
			break;
	}
}

//Function Number: 190
dds_exclude_this_ai(param_00)
{
	if(isai(self) && isalive(self))
	{
		if(param_00)
		{
			self.dds_disable = 1;
			return;
		}

		self.dds_disable = 0;
		return;
	}
}

//Function Number: 191
get_obj_origin(param_00)
{
	var_01 = getentarray("objective","targetname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02].script_noteworthy == param_00)
		{
			return var_01[var_02].origin;
		}
	}
}

//Function Number: 192
get_obj_event(param_00)
{
	var_01 = getentarray("objective_event","targetname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02].script_noteworthy == param_00)
		{
			return var_01[var_02];
		}
	}
}

//Function Number: 193
waittill_objective_event()
{
	maps\_utility_code::waittill_objective_event_proc(1);
}

//Function Number: 194
waittill_objective_event_notrigger()
{
	maps\_utility_code::waittill_objective_event_proc(0);
}

//Function Number: 195
debugorigin()
{
	self notify("Debug origin");
	self endon("Debug origin");
	self endon("death");
	for(;;)
	{
		var_00 = anglestoforward(self.angles);
		var_01 = var_00 * 30;
		var_02 = var_00 * 20;
		var_03 = anglestoright(self.angles);
		var_04 = var_03 * -10;
		var_03 = var_03 * 10;
		wait(0.05);
	}
}

//Function Number: 196
get_linked_structs()
{
	var_00 = [];
	if(isdefined(self.script_linkto))
	{
		var_01 = common_scripts\utility::get_links();
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = common_scripts\utility::getstruct(var_01[var_02],"script_linkname");
			if(isdefined(var_03))
			{
				var_00[var_00.size] = var_03;
			}
		}
	}

	return var_00;
}

//Function Number: 197
get_last_ent_in_chain(param_00)
{
	var_01 = self;
	if(isdefined(var_01.target))
	{
		wait(0.05);
		if(isdefined(var_01.target))
		{
			switch(param_00)
			{
				case "vehiclenode":
					break;

				case "pathnode":
					break;

				case "ent":
					break;

				case "struct":
					break;

				default:
					break;
			}
		}
	}
}

//Function Number: 198
player_seek(param_00)
{
	var_01 = spawn("script_origin",level.player.origin);
	var_01 linkto(level.player);
	if(isdefined(param_00))
	{
		thread timeout(param_00);
	}

	self setgoalentity(var_01);
	if(!isdefined(self.oldgoalradius))
	{
		self.oldgoalradius = self.goalradius;
	}

	self.goalradius = 300;
	common_scripts\utility::waittill_any("goal","timeout");
	if(isdefined(self.oldgoalradius))
	{
		self.goalradius = self.oldgoalradius;
		self.oldgoalradius = undefined;
	}

	var_01 delete();
}

//Function Number: 199
timeout(param_00)
{
	self endon("death");
	wait(param_00);
	self notify("timeout");
}

//Function Number: 200
set_forcegoal()
{
	if(isdefined(self.set_forcedgoal))
	{
		return;
	}

	self.oldfightdist = self.pathenemyfightdist;
	self.oldmaxdist = self.pathenemylookahead;
	self.oldmaxsight = self.maxsightdistsqrd;
	self.pathenemyfightdist = 8;
	self.pathenemylookahead = 8;
	self.maxsightdistsqrd = 1;
	self.set_forcedgoal = 1;
}

//Function Number: 201
unset_forcegoal()
{
	if(!isdefined(self.set_forcedgoal))
	{
		return;
	}

	self.pathenemyfightdist = self.oldfightdist;
	self.pathenemylookahead = self.oldmaxdist;
	self.maxsightdistsqrd = self.oldmaxsight;
	self.set_forcedgoal = undefined;
}

//Function Number: 202
array_removedead_keepkeys(param_00)
{
	var_01 = [];
	var_02 = getarraykeys(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(!isalive(param_00[var_04]))
		{
			continue;
		}

		var_01[var_04] = param_00[var_04];
	}

	return var_01;
}

//Function Number: 203
array_removedead(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 204
array_removedead_or_dying(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		if(var_03 doinglongdeath())
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 205
array_remove_nokeys(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		if(param_00[var_03] != param_01)
		{
			var_02[var_02.size] = param_00[var_03];
		}
	}

	return var_02;
}

//Function Number: 206
array_remove_index(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size - 1;var_02++)
	{
		if(var_02 == param_01)
		{
			param_00[var_02] = param_00[var_02 + 1];
			param_01++;
		}
	}

	param_00[param_00.size - 1] = undefined;
	return param_00;
}

//Function Number: 207
array_notify(param_00,param_01,param_02)
{
	foreach(var_04 in param_00)
	{
		var_04 notify(param_01,param_02);
	}
}

//Function Number: 208
struct_arrayspawn()
{
	var_00 = spawnstruct();
	var_00.array = [];
	var_00.lastindex = 0;
	return var_00;
}

//Function Number: 209
structarray_add(param_00,param_01)
{
	param_00.array[param_00.lastindex] = param_01;
	param_01.struct_array_index = param_00.lastindex;
	param_00.lastindex++;
}

//Function Number: 210
structarray_remove(param_00,param_01)
{
	structarray_swaptolast(param_00,param_01);
	param_00.array[param_00.lastindex - 1] = undefined;
	param_00.lastindex--;
}

//Function Number: 211
structarray_remove_index(param_00,param_01)
{
	if(isdefined(param_00.array[param_00.lastindex - 1]))
	{
		param_00.array[param_01] = param_00.array[param_00.lastindex - 1];
		param_00.array[param_01].struct_array_index = param_01;
		param_00.array[param_00.lastindex - 1] = undefined;
		param_00.lastindex = param_00.array.size;
		return;
	}

	param_00.array[param_01] = undefined;
	structarray_remove_undefined(param_00);
}

//Function Number: 212
structarray_remove_undefined(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00.array)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	param_00.array = var_01;
	foreach(var_06, var_03 in param_00.array)
	{
		var_03.struct_array_index = var_06;
	}

	param_00.lastindex = param_00.array.size;
}

//Function Number: 213
structarray_swaptolast(param_00,param_01)
{
	param_00 maps\_utility_code::structarray_swap(param_00.array[param_00.lastindex - 1],param_01);
}

//Function Number: 214
structarray_shuffle(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_01;var_02++)
	{
		param_00 maps\_utility_code::structarray_swap(param_00.array[var_02],param_00.array[randomint(param_00.lastindex)]);
	}
}

//Function Number: 215
get_use_key()
{
	if(level.console)
	{
		return " + usereload";
	}

	return " + activate";
}

//Function Number: 216
custom_battlechatter(param_00)
{
	return animscripts\battlechatter_ai::custom_battlechatter_internal(param_00);
}

//Function Number: 217
get_stop_watch(param_00,param_01)
{
	var_02 = newhudelem();
	if(level.console)
	{
		var_02.x = 68;
		var_02.y = 35;
	}
	else
	{
		var_02.x = 58;
		var_02.y = 95;
	}

	var_02.alignx = "center";
	var_02.aligny = "middle";
	var_02.horzalign = "left";
	var_02.vertalign = "middle";
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}
	else
	{
		var_03 = level.explosiveplanttime;
	}

	var_02 setclock(var_03,param_00,"hudStopwatch",64,64);
	return var_02;
}

//Function Number: 218
objective_is_active(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.active_objective.size;var_02++)
	{
		if(level.active_objective[var_02] != param_00)
		{
			continue;
		}

		var_01 = 1;
		break;
	}

	return var_01;
}

//Function Number: 219
objective_is_inactive(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.inactive_objective.size;var_02++)
	{
		if(level.inactive_objective[var_02] != param_00)
		{
			continue;
		}

		var_01 = 1;
		break;
	}

	return var_01;
}

//Function Number: 220
set_objective_inactive(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.active_objective.size;var_02++)
	{
		if(level.active_objective[var_02] == param_00)
		{
			continue;
		}

		var_01[var_01.size] = level.active_objective[var_02];
	}

	level.active_objective = var_01;
	var_03 = 0;
	for(var_02 = 0;var_02 < level.inactive_objective.size;var_02++)
	{
		if(level.inactive_objective[var_02] != param_00)
		{
			continue;
		}

		var_03 = 1;
	}

	if(!var_03)
	{
		level.inactive_objective[level.inactive_objective.size] = param_00;
	}
}

//Function Number: 221
set_objective_active(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.inactive_objective.size;var_02++)
	{
		if(level.inactive_objective[var_02] == param_00)
		{
			continue;
		}

		var_01[var_01.size] = level.inactive_objective[var_02];
	}

	level.inactive_objective = var_01;
	var_03 = 0;
	for(var_02 = 0;var_02 < level.active_objective.size;var_02++)
	{
		if(level.active_objective[var_02] != param_00)
		{
			continue;
		}

		var_03 = 1;
	}

	if(!var_03)
	{
		level.active_objective[level.active_objective.size] = param_00;
	}
}

//Function Number: 222
missionfailedwrapper()
{
	if(level.missionfailed)
	{
		return;
	}

	if(isdefined(level.nextmission))
	{
		return;
	}

	setsaveddvar("ammoCounterHide",1);
	level.missionfailed = 1;
	common_scripts\utility::flag_set("missionfailed");
	if(arcademode())
	{
		return;
	}

	if(getdvar("failure_disabled") == "1")
	{
		return;
	}

	if(isdefined(level.mission_fail_func))
	{
		thread [[ level.mission_fail_func ]]();
		return;
	}

	maps\_utility_code::mission_recon(0);
	missionfailed();
}

//Function Number: 223
set_mission_failed_override(param_00)
{
	level.mission_fail_func = param_00;
}

//Function Number: 224
script_delay()
{
	if(isdefined(self.script_delay))
	{
		wait(self.script_delay);
		return 1;
	}
	else if(isdefined(self.script_delay_min) && isdefined(self.script_delay_max))
	{
		wait(randomfloatrange(self.script_delay_min,self.script_delay_max));
		return 1;
	}

	return 0;
}

//Function Number: 225
script_wait()
{
	var_00 = gettime();
	if(isdefined(self.script_wait))
	{
		wait(self.script_wait);
		if(isdefined(self.script_wait_add))
		{
			self.script_wait = self.script_wait + self.script_wait_add;
		}
	}
	else if(isdefined(self.script_wait_min) && isdefined(self.script_wait_max))
	{
		wait(randomfloatrange(self.script_wait_min,self.script_wait_max));
		if(isdefined(self.script_wait_add))
		{
			self.script_wait_min = self.script_wait_min + self.script_wait_add;
			self.script_wait_max = self.script_wait_max + self.script_wait_add;
		}
	}

	return gettime() - var_00;
}

//Function Number: 226
guy_enter_vehicle(param_00)
{
	maps\_vehicle_aianim::guy_enter(param_00);
}

//Function Number: 227
guy_runtovehicle_load(param_00,param_01)
{
	maps\_vehicle_aianim::guy_runtovehicle(param_00,param_01);
}

//Function Number: 228
get_force_color_guys(param_00,param_01)
{
	var_02 = getaiarray(param_00);
	var_03 = [];
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_05 = var_02[var_04];
		if(!isdefined(var_05.script_forcecolor))
		{
			continue;
		}

		if(var_05.script_forcecolor != param_01)
		{
			continue;
		}

		var_03[var_03.size] = var_05;
	}

	return var_03;
}

//Function Number: 229
get_all_force_color_friendlies()
{
	var_00 = getaiarray("allies");
	var_01 = [];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_03 = var_00[var_02];
		if(!isdefined(var_03.script_forcecolor))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 230
get_all_target_ents(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.target;
	}

	var_01 = [];
	var_02 = getentarray(param_00,"targetname");
	var_01 = common_scripts\utility::array_combine(var_01,var_02);
	var_02 = getnodearray(param_00,"targetname");
	var_01 = common_scripts\utility::array_combine(var_01,var_02);
	var_02 = common_scripts\utility::getstructarray(param_00,"targetname");
	var_01 = common_scripts\utility::array_combine(var_01,var_02);
	var_02 = getvehiclenodearray(param_00,"targetname");
	var_01 = common_scripts\utility::array_combine(var_01,var_02);
	return var_01;
}

//Function Number: 231
enable_ai_color()
{
	if(isdefined(self.script_forcecolor))
	{
		return;
	}

	if(!isdefined(self.old_forcecolor))
	{
		return;
	}

	set_force_color(self.old_forcecolor);
	self.old_forcecolor = undefined;
}

//Function Number: 232
enable_ai_color_dontmove()
{
	self.dontcolormove = 1;
	enable_ai_color();
}

//Function Number: 233
disable_ai_color()
{
	if(isdefined(self.new_force_color_being_set))
	{
		self endon("death");
		self waittill("done_setting_new_color");
	}

	self clearfixednodesafevolume();
	if(!isdefined(self.script_forcecolor))
	{
		return;
	}

	self.old_forcecolor = self.script_forcecolor;
	maps\_colors::remove_ai_from_colors();
}

//Function Number: 234
clear_force_color()
{
	disable_ai_color();
}

//Function Number: 235
check_force_color(param_00)
{
	var_01 = level.colorchecklist[tolower(param_00)];
	if(isdefined(self.script_forcecolor) && var_01 == self.script_forcecolor)
	{
		return 1;
	}

	return 0;
}

//Function Number: 236
get_force_color()
{
	var_00 = self.script_forcecolor;
	return var_00;
}

//Function Number: 237
set_force_color(param_00)
{
	var_01 = maps\_colors::add_ai_to_colors(param_00);
}

//Function Number: 238
issue_color_orders(param_00,param_01)
{
	maps\_colors::issue_color_orders_generic(param_00,param_01);
}

//Function Number: 239
clear_color_order(param_00,param_01)
{
	maps\_colors::clear_color_order_from_team(param_00,param_01);
}

//Function Number: 240
clear_all_color_orders(param_00)
{
	foreach(var_02 in level.colorlist)
	{
		maps\_colors::clear_color_order_from_team(var_02,param_00);
	}
}

//Function Number: 241
replace_on_death()
{
	thread maps\_colors::colornode_replace_on_death();
}

//Function Number: 242
disable_replace_on_death()
{
	self.replace_on_death = undefined;
	self notify("_disable_reinforcement");
}

//Function Number: 243
stop_replace_on_death()
{
	self notify("_disable_reinforcement");
}

//Function Number: 244
stop_all_replace_on_death(param_00,param_01)
{
	thread maps\_colors::colornode_stop_replace_on_death_group(param_00,param_01);
}

//Function Number: 245
spawn_reinforcement(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = "allies";
	}

	thread maps\_colors::colornode_spawn_reinforcement(param_03,param_00,param_01,param_02);
}

//Function Number: 246
clear_promotion_order()
{
	maps\_colors::colornode_clear_promotion_order();
}

//Function Number: 247
set_promotion_order(param_00,param_01)
{
	maps\_colors::colornode_set_promotion_order(param_00,param_01);
}

//Function Number: 248
set_empty_promotion_order(param_00)
{
	maps\_colors::colornode_set_empty_promotion_order(param_00);
}

//Function Number: 249
has_color()
{
	if(maps\_colors::get_team() == "axis")
	{
		return isdefined(self.script_color_axis) || isdefined(self.script_forcecolor);
	}

	return isdefined(self.script_color_allies) || isdefined(self.script_forcecolor);
}

//Function Number: 250
get_color_volume_from_trigger()
{
	return maps\_colors::get_color_volume_from_trigger_codes();
}

//Function Number: 251
get_color_nodes_from_trigger()
{
	return maps\_colors::get_color_nodes_from_trigger_codes();
}

//Function Number: 252
flashrumbleloop(param_00)
{
	var_01 = gettime() + param_00 * 1000;
	while(gettime() < var_01)
	{
		self playrumbleonentity("damage_heavy");
		wait(0.05);
	}
}

//Function Number: 253
flashmonitorenablehealthshield(param_00)
{
	self endon("death");
	self endon("flashed");
	wait(0.2);
	self enablehealthshield(0);
	wait(param_00 + 2);
	self enablehealthshield(1);
}

//Function Number: 254
ninebanghandler(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [0.8,0.7,0.7,0.6];
	var_06 = [1,0.8,0.6,0.6];
	foreach(var_0C, var_08 in var_06)
	{
		var_09 = param_01 - 0.85 / 0.15;
		if(var_09 > param_02)
		{
			param_02 = var_09;
		}

		if(param_02 < 0.25)
		{
			param_02 = 0.25;
		}

		var_0A = 0.3;
		if(param_01 > 1 - var_0A)
		{
			param_01 = 1;
		}
		else
		{
			param_01 = param_01 / 1 - var_0A;
		}

		if(param_04 != self.team)
		{
			var_0B = param_01 * param_02 * 6;
		}
		else
		{
			var_0B = param_01 * param_02 * 3;
		}

		if(var_0B < 0.25)
		{
			continue;
		}

		var_0B = var_08 * var_0B;
		if(isdefined(self.maxflashedseconds) && var_0B > self.maxflashedseconds)
		{
			var_0B = self.maxflashedseconds;
		}

		self.flashingteam = param_04;
		self notify("flashed");
		self.flashendtime = gettime() + var_0B * 1000;
		self shellshock("flashbang",var_0B);
		common_scripts\utility::flag_set("player_flashed");
		if(param_01 * param_02 > 0.5)
		{
			thread flashmonitorenablehealthshield(var_0B);
		}

		wait(var_05[var_0C]);
	}

	thread maps\_utility_code::unflash_flag(0.05);
}

//Function Number: 255
flashmonitor()
{
	self endon("death");
	for(;;)
	{
		self waittill("flashbang",var_00,var_01,var_02,var_03,var_04);
		if("1" == getdvar("noflash"))
		{
			continue;
		}

		if(is_player_down(self))
		{
			continue;
		}

		if(isdefined(self.threw_ninebang))
		{
			var_05 = 0.8;
			var_06 = 1 - var_05;
			self.threw_ninebang = undefined;
			if(var_01 < var_06)
			{
				continue;
			}

			var_01 = var_01 - var_06 / var_05;
		}

		var_07 = var_01 - 0.85 / 0.15;
		if(var_07 > var_02)
		{
			var_02 = var_07;
		}

		if(var_02 < 0.25)
		{
			var_02 = 0.25;
		}

		var_08 = 0.3;
		if(var_01 > 1 - var_08)
		{
			var_01 = 1;
		}
		else
		{
			var_01 = var_01 / 1 - var_08;
		}

		if(var_04 != self.team)
		{
			var_09 = var_01 * var_02 * 6;
		}
		else
		{
			var_09 = var_01 * var_02 * 3;
		}

		if(var_09 < 0.25)
		{
			continue;
		}

		if(isdefined(self.maxflashedseconds) && var_09 > self.maxflashedseconds)
		{
			var_09 = self.maxflashedseconds;
		}

		self.flashingteam = var_04;
		self notify("flashed");
		self.flashendtime = gettime() + var_09 * 1000;
		self shellshock("flashbang",var_09);
		self lightsetoverrideenableforplayer("flashed",0.1);
		common_scripts\utility::flag_set("player_flashed");
		thread maps\_utility_code::unflash_flag(var_09);
		wait(0.1);
		self lightsetoverrideenableforplayer(var_09 - 0.1);
		if(var_01 * var_02 > 0.5)
		{
			thread flashmonitorenablehealthshield(var_09);
		}

		if(var_09 > 2)
		{
			thread flashrumbleloop(0.75);
		}
		else
		{
			thread flashrumbleloop(0.25);
		}

		if(var_04 != "allies")
		{
			thread flashnearbyallies(var_09,var_04);
		}
	}
}

//Function Number: 256
flashnearbyallies(param_00,param_01)
{
	wait(0.05);
	var_02 = getaiarray("allies");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(distancesquared(var_02[var_03].origin,self.origin) < 122500)
		{
			var_04 = param_00 + randomfloatrange(-1000,1500);
			if(var_04 > 4.5)
			{
				var_04 = 4.5;
			}
			else if(var_04 < 0.25)
			{
				continue;
			}

			var_05 = gettime() + var_04 * 1000;
			if(!isdefined(var_02[var_03].flashendtime) || var_02[var_03].flashendtime < var_05)
			{
				var_02[var_03].flashingteam = param_01;
				var_02[var_03] flashbangstart(var_04);
			}
		}
	}
}

//Function Number: 257
restarteffect()
{
	common_scripts\_createfx::restart_fx_looper();
}

//Function Number: 258
pauseexploder(param_00)
{
	param_00 = param_00 + "";
	if(isdefined(level.createfxexploders))
	{
		var_01 = level.createfxexploders[param_00];
		if(isdefined(var_01))
		{
			foreach(var_03 in var_01)
			{
				var_03 common_scripts\utility::pauseeffect();
			}

			return;
		}

		return;
	}

	foreach(var_06 in level.createfxent)
	{
		if(!isdefined(var_06.v["exploder"]))
		{
			continue;
		}

		if(var_06.v["exploder"] != var_03)
		{
			continue;
		}

		var_06 common_scripts\utility::pauseeffect();
	}
}

//Function Number: 259
restartexploder(param_00)
{
	param_00 = param_00 + "";
	if(isdefined(level.createfxexploders))
	{
		var_01 = level.createfxexploders[param_00];
		if(isdefined(var_01))
		{
			foreach(var_03 in var_01)
			{
				var_03 restarteffect();
			}

			return;
		}

		return;
	}

	foreach(var_06 in level.createfxent)
	{
		if(!isdefined(var_06.v["exploder"]))
		{
			continue;
		}

		if(var_06.v["exploder"] != var_03)
		{
			continue;
		}

		var_06 restarteffect();
	}
}

//Function Number: 260
getfxarraybyid(param_00)
{
	var_01 = [];
	if(isdefined(level.createfxbyfxid))
	{
		var_02 = level.createfxbyfxid[param_00];
		if(isdefined(var_02))
		{
			var_01 = var_02;
		}
	}
	else
	{
		for(var_03 = 0;var_03 < level.createfxent.size;var_03++)
		{
			if(level.createfxent[var_03].v["fxid"] == param_00)
			{
				var_01[var_01.size] = level.createfxent[var_03];
			}
		}
	}

	return var_01;
}

//Function Number: 261
ignoreallenemies(param_00)
{
	self notify("ignoreAllEnemies_threaded");
	self endon("ignoreAllEnemies_threaded");
	if(param_00)
	{
		self.old_threat_bias_group = self getthreatbiasgroup();
		var_01 = undefined;
		createthreatbiasgroup("ignore_everybody");
		self setthreatbiasgroup("ignore_everybody");
		var_02 = [];
		var_02["axis"] = "allies";
		var_02["allies"] = "axis";
		var_03 = getaiarray(var_02[self.team]);
		var_04 = [];
		for(var_05 = 0;var_05 < var_03.size;var_05++)
		{
			var_04[var_03[var_05] getthreatbiasgroup()] = 1;
		}

		var_06 = getarraykeys(var_04);
		for(var_05 = 0;var_05 < var_06.size;var_05++)
		{
			setthreatbias(var_06[var_05],"ignore_everybody",0);
		}

		return;
	}

	var_01 = undefined;
	if(self.old_threat_bias_group != "")
	{
		self setthreatbiasgroup(self.old_threat_bias_group);
	}

	self.old_threat_bias_group = undefined;
}

//Function Number: 262
vehicle_detachfrompath()
{
	maps\_vehicle_code::vehicle_pathdetach();
}

//Function Number: 263
vehicle_resumepath()
{
	thread maps\_vehicle_code::vehicle_resumepathvehicle();
}

//Function Number: 264
vehicle_land(param_00)
{
	maps\_vehicle_code::vehicle_landvehicle(param_00);
}

//Function Number: 265
vehicle_liftoff(param_00)
{
	maps\_vehicle_code::vehicle_liftoffvehicle(param_00);
}

//Function Number: 266
vehicle_dynamicpath(param_00,param_01)
{
	maps\_vehicle::vehicle_paths(param_00,param_01);
}

//Function Number: 267
groundpos(param_00)
{
	return bullettrace(param_00,param_00 + (0,0,-100000),0,self)["position"];
}

//Function Number: 268
change_player_health_packets(param_00)
{
	self.player_health_packets = self.player_health_packets + param_00;
	self notify("update_health_packets");
	if(self.player_health_packets >= 3)
	{
		self.player_health_packets = 3;
	}
}

//Function Number: 269
getvehiclespawner(param_00)
{
	var_01 = getvehiclespawnerarray(param_00);
	return var_01[0];
}

//Function Number: 270
getvehiclespawnerarray(param_00)
{
	return maps\_vehicle_code::_getvehiclespawnerarray(param_00);
}

//Function Number: 271
describe_start(param_00,param_01,param_02,param_03,param_04,param_05)
{
	add_start_assert();
	if(!isdefined(level.start_description))
	{
		level.start_description = [];
	}

	level.start_description[param_00] = add_start_construct(param_00,param_01,param_02,param_03,[param_04],param_05);
}

//Function Number: 272
add_start(param_00,param_01,param_02,param_03,param_04,param_05)
{
	add_start_assert();
	param_00 = tolower(param_00);
	if(isdefined(param_04))
	{
		if(param_04.size > 2)
		{
			var_06 = [];
			var_06[0] = param_04[0];
			var_06[1] = param_04[1];
			param_04 = var_06;
		}

		if(!isdefined(level.start_transients))
		{
			level.start_transients = [];
		}

		foreach(var_08 in param_04)
		{
			if(!common_scripts\utility::array_contains(level.start_transients,var_08))
			{
				level.start_transients[level.start_transients.size] = var_08;
			}
		}
	}

	if(isdefined(level.start_description) && isdefined(level.start_description[param_00]))
	{
		var_0B = level.start_description[param_00];
	}
	else
	{
		var_0B = add_start_construct(param_01,param_02,param_03,param_04,param_05,var_0B);
	}

	if(!isdefined(param_01))
	{
		if(!isdefined(level.start_description))
		{
		}
		else if(!issubstr(param_00,"no_game"))
		{
			if(!isdefined(level.start_description[param_00]))
			{
				return;
			}
		}
	}

	level.start_functions[level.start_functions.size] = var_0B;
	level.start_arrays[param_00] = var_0B;
}

//Function Number: 273
set_start_transients(param_00,param_01)
{
	if(!isdefined(level.start_arrays))
	{
		return;
	}

	if(!isdefined(level.start_arrays[param_00]))
	{
		return;
	}

	param_00 = tolower(param_00);
	if(param_01.size > 2)
	{
		var_02 = [];
		var_02[0] = param_01[0];
		var_02[1] = param_01[1];
		param_01 = var_02;
	}

	if(!isdefined(level.start_transients))
	{
		level.start_transients = [];
	}

	foreach(var_04 in param_01)
	{
		if(!common_scripts\utility::array_contains(level.start_transients,var_04))
		{
			level.start_transients[level.start_transients.size] = var_04;
		}
	}

	level.start_arrays[param_00]["transients_to_load"] = param_01;
}

//Function Number: 274
is_no_game_start()
{
	return issubstr(level.start_point,"no_game");
}

//Function Number: 275
add_start_construct(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = [];
	var_06["name"] = param_00;
	var_06["start_func"] = param_01;
	var_06["start_loc_string"] = param_02;
	var_06["logic_func"] = param_03;
	var_06["transients_to_load"] = param_04;
	var_06["catchup_function"] = param_05;
	return var_06;
}

//Function Number: 276
add_start_assert()
{
	if(!isdefined(level.start_functions))
	{
		level.start_functions = [];
	}
}

//Function Number: 277
level_has_start_points()
{
	return level.start_functions.size > 1;
}

//Function Number: 278
set_default_start(param_00)
{
	level.default_start_override = param_00;
}

//Function Number: 279
default_start(param_00)
{
	level.default_start = param_00;
}

//Function Number: 280
linetime(param_00,param_01,param_02,param_03)
{
	thread maps\_utility_code::linetime_proc(param_00,param_01,param_02,param_03);
}

//Function Number: 281
within_fov_2d(param_00,param_01,param_02,param_03)
{
	var_04 = vectornormalize((param_02[0],param_02[1],0) - (param_00[0],param_00[1],0));
	var_05 = anglestoforward((0,param_01[1],0));
	return vectordot(var_05,var_04) >= param_03;
}

//Function Number: 282
get_dot(param_00,param_01,param_02)
{
	var_03 = vectornormalize(param_02 - param_00);
	var_04 = anglestoforward(param_01);
	var_05 = vectordot(var_04,var_03);
	return var_05;
}

//Function Number: 283
within_fov_of_players(param_00,param_01)
{
	var_02 = undefined;
	for(var_03 = 0;var_03 < level.players.size;var_03++)
	{
		var_04 = level.players[var_03] geteye();
		var_02 = common_scripts\utility::within_fov(var_04,level.players[var_03] getplayerangles(),param_00,param_01);
		if(!var_02)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 284
wait_for_buffer_time_to_pass(param_00,param_01)
{
	var_02 = param_01 * 1000 - gettime() - param_00;
	var_02 = var_02 * 0.001;
	if(var_02 > 0)
	{
		wait(var_02);
	}
}

//Function Number: 285
bcs_scripted_dialogue_start()
{
	anim.scripteddialoguestarttime = gettime();
}

//Function Number: 286
dialogue_queue(param_00)
{
	var_01 = getsndaliasvalue(param_00,"squelchname");
	if(self == level || var_01 != "")
	{
		radio_dialogue(param_00,undefined,var_01);
		return;
	}

	bcs_scripted_dialogue_start();
	maps\_anim::anim_single_queue(self,param_00);
}

//Function Number: 287
generic_dialogue_queue(param_00,param_01)
{
	bcs_scripted_dialogue_start();
	maps\_anim::anim_generic_queue(self,param_00,undefined,undefined,param_01);
}

//Function Number: 288
radio_dialogue(param_00,param_01,param_02)
{
	if(!isdefined(level.player_radio_emitter))
	{
		var_03 = spawn("script_origin",(0,0,0));
		var_03 linkto(level.player,"",(0,0,0),(0,0,0));
		level.player_radio_emitter = var_03;
	}

	bcs_scripted_dialogue_start();
	if(!isdefined(param_01))
	{
		return level.player_radio_emitter function_stack(::radio_dialogue_play,param_00,param_02);
	}

	return level.player_radio_emitter function_stack_timeout(param_01,::radio_dialogue_play,param_00,param_02);
}

//Function Number: 289
radio_dialogue_play(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "none";
	}

	level.player_radio_squelch_out_queued = 0;
	if(param_01 != "none" && isdefined(level.scr_radio["squelches"][param_01]))
	{
		play_sound_on_tag(level.scr_radio["squelches"][param_01]["on"],undefined,1);
	}

	var_02 = 0;
	if(isdefined(level.scr_radio[param_00]))
	{
		var_02 = play_sound_on_tag(level.scr_radio[param_00],undefined,1);
	}
	else
	{
		var_02 = play_sound_on_tag(param_00,undefined,1);
	}

	if(param_01 != "none" && isdefined(level.scr_radio["squelches"][param_01]))
	{
		thread radio_try_squelch_out(param_01);
	}

	return var_02;
}

//Function Number: 290
radio_dialogue_overlap(param_00)
{
	if(!isdefined(level.player_radio_emitter_overlap))
	{
		level.player_radio_emitter_overlap = [];
	}

	var_01 = spawn("script_origin",(0,0,0));
	level.player_radio_emitter_overlap[level.player_radio_emitter_overlap.size] = var_01;
	var_01 endon("death");
	thread delete_on_death_wait_sound(var_01,"sounddone");
	var_01.origin = level.player_radio_emitter.origin;
	var_01.angles = level.player_radio_emitter.angles;
	var_01 linkto(level.player_radio_emitter);
	var_01 playsound(level.scr_radio[param_00],"sounddone");
	if(!isdefined(maps\_utility_code::wait_for_sounddone_or_death(var_01)))
	{
		var_01 stopsounds();
	}

	wait(0.05);
	level.player_radio_emitter_overlap = common_scripts\utility::array_remove(level.player_radio_emitter_overlap,var_01);
	var_01 delete();
}

//Function Number: 291
radio_dialogue_stop()
{
	if(!isdefined(level.player_radio_emitter))
	{
		return;
	}

	level.player_radio_emitter delete();
}

//Function Number: 292
radio_dialogue_overlap_stop()
{
	if(!isdefined(level.player_radio_emitter_overlap))
	{
		return;
	}

	foreach(var_01 in level.player_radio_emitter_overlap)
	{
		if(isdefined(var_01))
		{
			var_01 stopsounds();
			wait(0.05);
			var_01 delete();
		}
	}

	level.player_radio_emitter_overlap = undefined;
}

//Function Number: 293
radio_dialogue_clear_stack()
{
	if(!isdefined(level.player_radio_emitter))
	{
		return;
	}

	level.player_radio_emitter function_stack_clear();
}

//Function Number: 294
radio_dialogue_remove_from_stack(param_00)
{
	if(!isdefined(level.player_radio_emitter))
	{
		return;
	}

	if(!isdefined(level.player_radio_emitter.function_stack))
	{
		return;
	}

	var_01 = [];
	var_02 = 0;
	var_03 = level.player_radio_emitter.function_stack.size;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		if(var_04 == 0 && isdefined(level.player_radio_emitter.function_stack[0].function_stack_func_begun) && isdefined(level.player_radio_emitter.function_stack[0].function_stack_func_begun))
		{
			var_01[var_01.size] = level.player_radio_emitter.function_stack[var_04];
			continue;
		}

		if(isdefined(level.player_radio_emitter.function_stack[var_04].param1) && level.player_radio_emitter.function_stack[var_04].param1 == param_00)
		{
			level.player_radio_emitter.function_stack[var_04] notify("death");
			level.player_radio_emitter.function_stack[var_04] = undefined;
			var_02 = 1;
			continue;
		}

		var_01[var_01.size] = level.player_radio_emitter.function_stack[var_04];
	}

	if(var_02)
	{
		level.player_radio_emitter.function_stack = var_01;
	}
}

//Function Number: 295
radio_dialogue_interupt(param_00)
{
	if(!isdefined(level.player_radio_emitter))
	{
		var_01 = spawn("script_origin",(0,0,0));
		var_01 linkto(level.player,"",(0,0,0),(0,0,0));
		level.player_radio_emitter = var_01;
	}

	level.player_radio_emitter play_sound_on_tag(level.scr_radio[param_00],undefined,1);
}

//Function Number: 296
radio_dialogue_safe(param_00)
{
	return radio_dialogue(param_00,0.05);
}

//Function Number: 297
smart_radio_dialogue(param_00,param_01)
{
	var_02 = getsndaliasvalue(param_00,"squelchname");
	maps\_utility_code::add_to_radio(param_00);
	radio_dialogue(param_00,param_01,var_02);
}

//Function Number: 298
smart_radio_dialogue_interrupt(param_00)
{
	maps\_utility_code::add_to_radio(param_00);
	radio_dialogue_stop();
	radio_dialogue_interupt(param_00);
}

//Function Number: 299
smart_radio_dialogue_overlap(param_00)
{
	maps\_utility_code::add_to_radio(param_00);
	radio_dialogue_overlap(param_00);
}

//Function Number: 300
smart_dialogue(param_00)
{
	maps\_utility_code::add_to_dialogue(param_00);
	dialogue_queue(param_00);
}

//Function Number: 301
smart_dialogue_generic(param_00)
{
	maps\_utility_code::add_to_dialogue_generic(param_00);
	generic_dialogue_queue(param_00);
}

//Function Number: 302
radio_try_squelch_out(param_00,param_01)
{
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = 0.1;
	}

	level.player_radio_squelch_out_queued = 1;
	wait(param_01);
	if(isdefined(level.player_radio_emitter) && level.player_radio_squelch_out_queued == 1)
	{
		level.player_radio_emitter function_stack(::play_sound_on_tag,level.scr_radio["squelches"][param_00]["off"],undefined,1);
	}
}

//Function Number: 303
radio_dialogue_queue(param_00,param_01)
{
	radio_dialogue(param_00,undefined,param_01);
}

//Function Number: 304
hint_create(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	if(isdefined(param_01) && param_01 == 1)
	{
		var_03.bg = newhudelem();
	}

	var_03.elm = newhudelem();
	var_03 hint_position_internal(param_02);
	var_03.elm settext(param_00);
	return var_03;
}

//Function Number: 305
hint_delete()
{
	self notify("death");
	if(isdefined(self.elm))
	{
		self.elm destroy();
	}

	if(isdefined(self.bg))
	{
		self.bg destroy();
	}
}

//Function Number: 306
hint_position_internal(param_00)
{
	if(level.console)
	{
		self.elm.fontscale = 2;
	}
	else
	{
		self.elm.fontscale = 1.6;
	}

	self.elm.x = 0;
	self.elm.y = -40;
	self.elm.alignx = "center";
	self.elm.aligny = "bottom";
	self.elm.horzalign = "center";
	self.elm.vertalign = "middle";
	self.elm.sort = 1;
	self.elm.alpha = 0.8;
	if(!isdefined(self.bg))
	{
		return;
	}

	self.bg.x = 0;
	self.bg.y = -40;
	self.bg.alignx = "center";
	self.bg.aligny = "middle";
	self.bg.horzalign = "center";
	self.bg.vertalign = "middle";
	self.bg.sort = -1;
	if(level.console)
	{
		self.bg setshader("popmenu_bg",650,52);
	}
	else
	{
		self.bg setshader("popmenu_bg",650,42);
	}

	if(!isdefined(param_00))
	{
		param_00 = 0.5;
	}

	self.bg.alpha = param_00;
}

//Function Number: 307
string(param_00)
{
	return "" + param_00;
}

//Function Number: 308
is_string_a_number(param_00)
{
	var_01 = float(param_00);
	return string(var_01) == param_00;
}

//Function Number: 309
ignoreeachother(param_00,param_01)
{
	setignoremegroup(param_00,param_01);
	setignoremegroup(param_01,param_00);
}

//Function Number: 310
add_global_spawn_function(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	var_05["function"] = param_01;
	var_05["param1"] = param_02;
	var_05["param2"] = param_03;
	var_05["param3"] = param_04;
	level.spawn_funcs[param_00][level.spawn_funcs[param_00].size] = var_05;
}

//Function Number: 311
remove_global_spawn_function(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < level.spawn_funcs[param_00].size;var_03++)
	{
		if(level.spawn_funcs[param_00][var_03]["function"] != param_01)
		{
			var_02[var_02.size] = level.spawn_funcs[param_00][var_03];
		}
	}

	level.spawn_funcs[param_00] = var_02;
}

//Function Number: 312
exists_global_spawn_function(param_00,param_01)
{
	if(!isdefined(level.spawn_funcs))
	{
		return 0;
	}

	for(var_02 = 0;var_02 < level.spawn_funcs[param_00].size;var_02++)
	{
		if(level.spawn_funcs[param_00][var_02]["function"] == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 313
remove_spawn_function(param_00)
{
	var_01 = [];
	foreach(var_03 in self.spawn_functions)
	{
		if(var_03["function"] == param_00)
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	self.spawn_functions = var_01;
}

//Function Number: 314
add_spawn_function(param_00,param_01,param_02,param_03,param_04,param_05)
{
	foreach(var_07 in self.spawn_functions)
	{
		if(var_07["function"] == param_00)
		{
			return;
		}
	}

	var_09 = [];
	var_09["function"] = param_00;
	var_09["param1"] = param_01;
	var_09["param2"] = param_02;
	var_09["param3"] = param_03;
	var_09["param4"] = param_04;
	var_09["param5"] = param_05;
	self.spawn_functions[self.spawn_functions.size] = var_09;
}

//Function Number: 315
array_delete(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		param_00[var_01] delete();
	}
}

//Function Number: 316
array_kill(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		param_00[var_01] kill();
	}
}

//Function Number: 317
ignore_triggers(param_00)
{
	self endon("death");
	self.ignoretriggers = 1;
	if(isdefined(param_00))
	{
		wait(param_00);
	}
	else
	{
		wait(0.5);
	}

	self.ignoretriggers = 0;
}

//Function Number: 318
activate_trigger_with_targetname(param_00)
{
	var_01 = getent(param_00,"targetname");
	var_01 activate_trigger();
}

//Function Number: 319
activate_trigger_with_noteworthy(param_00)
{
	var_01 = getent(param_00,"script_noteworthy");
	var_01 activate_trigger();
}

//Function Number: 320
disable_trigger_with_targetname(param_00)
{
	var_01 = getent(param_00,"targetname");
	var_01 common_scripts\utility::trigger_off();
}

//Function Number: 321
disable_trigger_with_noteworthy(param_00)
{
	var_01 = getent(param_00,"script_noteworthy");
	var_01 common_scripts\utility::trigger_off();
}

//Function Number: 322
enable_trigger_with_targetname(param_00)
{
	var_01 = getent(param_00,"targetname");
	var_01 common_scripts\utility::trigger_on();
}

//Function Number: 323
enable_trigger_with_noteworthy(param_00)
{
	var_01 = getent(param_00,"script_noteworthy");
	var_01 common_scripts\utility::trigger_on();
}

//Function Number: 324
is_hero()
{
	return isdefined(level.hero_list[get_ai_number()]);
}

//Function Number: 325
get_ai_number()
{
	if(!isdefined(self.unique_id))
	{
		set_ai_number();
	}

	return self.unique_id;
}

//Function Number: 326
set_ai_number()
{
	self.unique_id = "ai" + level.ai_number;
	level.ai_number++;
}

//Function Number: 327
make_hero()
{
	level.hero_list[self.unique_id] = 1;
}

//Function Number: 328
unmake_hero()
{
	level.hero_list[self.unique_id] = undefined;
}

//Function Number: 329
get_heroes()
{
	var_00 = [];
	var_01 = getaiarray("allies");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02] is_hero())
		{
			var_00[var_00.size] = var_01[var_02];
		}
	}

	return var_00;
}

//Function Number: 330
set_team_pacifist(param_00,param_01)
{
	var_02 = getaiarray(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_02[var_03].pacifist = param_01;
	}
}

//Function Number: 331
remove_dead_from_array(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 332
remove_heroes_from_array(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(param_00[var_02] is_hero())
		{
			continue;
		}

		var_01[var_01.size] = param_00[var_02];
	}

	return var_01;
}

//Function Number: 333
remove_color_from_array(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = param_00[var_03];
		if(!isdefined(var_04.script_forcecolor))
		{
			continue;
		}

		if(var_04.script_forcecolor == param_01)
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	return var_02;
}

//Function Number: 334
remove_noteworthy_from_array(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = param_00[var_03];
		if(!isdefined(var_04.script_noteworthy))
		{
			continue;
		}

		if(var_04.script_noteworthy == param_01)
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	return var_02;
}

//Function Number: 335
get_closest_colored_friendly(param_00,param_01)
{
	var_02 = get_force_color_guys("allies",param_00);
	var_02 = remove_heroes_from_array(var_02);
	if(!isdefined(param_01))
	{
		var_03 = level.player.origin;
	}
	else
	{
		var_03 = var_02;
	}

	return common_scripts\utility::getclosest(var_03,var_02);
}

//Function Number: 336
remove_without_classname(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		if(!issubstr(param_00[var_03].classname,param_01))
		{
			continue;
		}

		var_02[var_02.size] = param_00[var_03];
	}

	return var_02;
}

//Function Number: 337
remove_without_model(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		if(!issubstr(param_00[var_03].model,param_01))
		{
			continue;
		}

		var_02[var_02.size] = param_00[var_03];
	}

	return var_02;
}

//Function Number: 338
get_closest_colored_friendly_with_classname(param_00,param_01,param_02)
{
	var_03 = get_force_color_guys("allies",param_00);
	var_03 = remove_heroes_from_array(var_03);
	if(!isdefined(param_02))
	{
		var_04 = level.player.origin;
	}
	else
	{
		var_04 = var_03;
	}

	var_03 = remove_without_classname(var_03,param_01);
	return common_scripts\utility::getclosest(var_04,var_03);
}

//Function Number: 339
promote_nearest_friendly(param_00,param_01)
{
	for(;;)
	{
		var_02 = get_closest_colored_friendly(param_00);
		if(!isalive(var_02))
		{
			wait(1);
			continue;
		}

		var_02 set_force_color(param_01);
	}
}

//Function Number: 340
instantly_promote_nearest_friendly(param_00,param_01)
{
	for(;;)
	{
		var_02 = get_closest_colored_friendly(param_00);
		if(!isalive(var_02))
		{
			return;
		}

		var_02 set_force_color(param_01);
	}
}

//Function Number: 341
instantly_promote_nearest_friendly_with_classname(param_00,param_01,param_02)
{
	for(;;)
	{
		var_03 = get_closest_colored_friendly_with_classname(param_00,param_02);
		if(!isalive(var_03))
		{
			return;
		}

		var_03 set_force_color(param_01);
	}
}

//Function Number: 342
promote_nearest_friendly_with_classname(param_00,param_01,param_02)
{
	for(;;)
	{
		var_03 = get_closest_colored_friendly_with_classname(param_00,param_02);
		if(!isalive(var_03))
		{
			wait(1);
			continue;
		}

		var_03 set_force_color(param_01);
	}
}

//Function Number: 343
riotshield_lock_orientation(param_00)
{
	self orientmode("face angle",param_00);
	self.lockorientation = 1;
}

//Function Number: 344
riotshield_unlock_orientation()
{
	self.lockorientation = 0;
}

//Function Number: 345
instantly_set_color_from_array_with_classname(param_00,param_01,param_02)
{
	var_03 = 0;
	var_04 = [];
	for(var_05 = 0;var_05 < param_00.size;var_05++)
	{
		var_06 = param_00[var_05];
		if(var_03 || !issubstr(var_06.classname,param_02))
		{
			var_04[var_04.size] = var_06;
			continue;
		}

		var_03 = 1;
		var_06 set_force_color(param_01);
	}

	return var_04;
}

//Function Number: 346
instantly_set_color_from_array(param_00,param_01)
{
	var_02 = 0;
	var_03 = [];
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		var_05 = param_00[var_04];
		if(var_02)
		{
			var_03[var_03.size] = var_05;
			continue;
		}

		var_02 = 1;
		var_05 set_force_color(param_01);
	}

	return var_03;
}

//Function Number: 347
wait_for_script_noteworthy_trigger(param_00)
{
	maps\_utility_code::wait_for_trigger(param_00,"script_noteworthy");
}

//Function Number: 348
wait_for_targetname_trigger(param_00)
{
	maps\_utility_code::wait_for_trigger(param_00,"targetname");
}

//Function Number: 349
wait_for_flag_or_timeout(param_00,param_01)
{
	if(common_scripts\utility::flag(param_00))
	{
		return;
	}

	level endon(param_00);
	wait(param_01);
}

//Function Number: 350
wait_for_notify_or_timeout(param_00,param_01)
{
	self endon(param_00);
	wait(param_01);
}

//Function Number: 351
wait_for_trigger_or_timeout(param_00)
{
	self endon("trigger");
	wait(param_00);
}

//Function Number: 352
wait_for_either_trigger(param_00,param_01)
{
	var_02 = spawnstruct();
	var_03 = [];
	var_03 = common_scripts\utility::array_combine(var_03,getentarray(param_00,"targetname"));
	var_03 = common_scripts\utility::array_combine(var_03,getentarray(param_01,"targetname"));
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_02 thread maps\_utility_code::ent_waits_for_trigger(var_03[var_04]);
	}

	var_02 waittill("done");
}

//Function Number: 353
dronespawn_bodyonly(param_00)
{
	var_01 = maps\_spawner::spawner_dronespawn(param_00);
	return var_01;
}

//Function Number: 354
dronespawn(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self;
	}

	var_01 = maps\_spawner::spawner_dronespawn(param_00);
	var_01 [[ level.drone_spawn_func ]]();
	var_01.spawn_funcs = param_00.spawn_functions;
	var_01 thread maps\_spawner::run_spawn_functions();
	var_01.spawner = param_00;
	return var_01;
}

//Function Number: 355
swap_ai_to_drone(param_00)
{
	return maps\_spawner::spawner_swap_ai_to_drone(param_00);
}

//Function Number: 356
swap_drone_to_ai(param_00)
{
	return maps\_spawner::spawner_swap_drone_to_ai(param_00);
}

//Function Number: 357
get_trigger_flag()
{
	if(isdefined(self.script_flag))
	{
		return self.script_flag;
	}

	if(isdefined(self.script_noteworthy))
	{
		return self.script_noteworthy;
	}
}

//Function Number: 358
set_default_pathenemy_settings()
{
	self.pathenemylookahead = 192;
	self.pathenemyfightdist = 192;
}

//Function Number: 359
cqb_walk(param_00)
{
	if(param_00 == "on")
	{
		enable_cqbwalk();
		return;
	}

	disable_cqbwalk();
}

//Function Number: 360
enable_cqbwalk(param_00)
{
	if(self.type == "dog")
	{
		return;
	}

	if(!isdefined(param_00))
	{
		self.cqbenabled = 1;
	}

	self.cqbwalking = 1;
	self.turnrate = 0.2;
	level thread animscripts\cqb::findcqbpointsofinterest();
}

//Function Number: 361
disable_cqbwalk()
{
	if(self.type == "dog")
	{
		return;
	}

	self.cqbwalking = undefined;
	self.cqbenabled = undefined;
	self.turnrate = 0.3;
	self.cqb_point_of_interest = undefined;
}

//Function Number: 362
enable_readystand()
{
	self.busereadyidle = 1;
}

//Function Number: 363
disable_readystand()
{
	self.busereadyidle = undefined;
}

//Function Number: 364
cqb_aim(param_00)
{
	if(!isdefined(param_00))
	{
		self.cqb_target = undefined;
		return;
	}

	self.cqb_target = param_00;
	if(!isdefined(param_00.origin))
	{
	}
}

//Function Number: 365
set_force_cover(param_00)
{
	if(isdefined(param_00) && param_00)
	{
		self.forcesuppression = 1;
		return;
	}

	self.forcesuppression = undefined;
}

//Function Number: 366
do_in_order(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01))
	{
		[[ param_00 ]](param_01);
	}
	else
	{
		[[ param_00 ]]();
	}

	if(isdefined(param_03))
	{
		[[ param_02 ]](param_03);
		return;
	}

	[[ param_02 ]]();
}

//Function Number: 367
send_notify(param_00,param_01)
{
	if(isdefined(param_01))
	{
		self notify(param_00,param_01);
		return;
	}

	self notify(param_00);
}

//Function Number: 368
waittill_match_or_timeout(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03 endon("complete");
	var_03 delaythread(param_02,::send_notify,"complete");
	self waittillmatch(param_01,param_00);
}

//Function Number: 369
deleteent(param_00)
{
	param_00 notify("deleted");
	param_00 delete();
}

//Function Number: 370
first_touch(param_00)
{
	if(!isdefined(self.touched))
	{
		self.touched = [];
	}

	if(isdefined(self.touched[param_00.unique_id]))
	{
		return 0;
	}

	self.touched[param_00.unique_id] = 1;
	return 1;
}

//Function Number: 371
getanim(param_00)
{
	return level.scr_anim[self.animname][param_00];
}

//Function Number: 372
hasanim(param_00)
{
	return isdefined(level.scr_anim[self.animname][param_00]);
}

//Function Number: 373
getanim_from_animname(param_00,param_01)
{
	return level.scr_anim[param_01][param_00];
}

//Function Number: 374
getanim_generic(param_00)
{
	return level.scr_anim["generic"][param_00];
}

//Function Number: 375
add_hint_string(param_00,param_01,param_02)
{
	if(!isdefined(level.trigger_hint_string))
	{
		level.trigger_hint_string = [];
		level.trigger_hint_func = [];
	}

	level.trigger_hint_string[param_00] = param_01;
	precachestring(param_01);
	if(isdefined(param_02))
	{
		level.trigger_hint_func[param_00] = param_02;
	}
}

//Function Number: 376
show_hint(param_00)
{
	thread maps\_utility_code::showhintprint_struct(param_00);
}

//Function Number: 377
hide_hint(param_00)
{
	param_00.timeout = 1;
}

//Function Number: 378
fire_radius(param_00,param_01)
{
	var_02 = spawn("trigger_radius",param_00,0,param_01,48);
	for(;;)
	{
		var_02 waittill("trigger",var_03);
		level.player dodamage(5,param_00);
	}
}

//Function Number: 379
clearthreatbias(param_00,param_01)
{
	setthreatbias(param_00,param_01,0);
	setthreatbias(param_01,param_00,0);
}

//Function Number: 380
throwgrenadeatplayerasap()
{
	animscripts\combat_utility::throwgrenadeatplayerasap_combat_utility();
}

//Function Number: 381
array_combine_keys(param_00,param_01)
{
	if(!param_00.size)
	{
		return param_01;
	}

	var_02 = getarraykeys(param_01);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		param_00[var_02[var_03]] = param_01[var_02[var_03]];
	}

	return param_00;
}

//Function Number: 382
set_ignoresuppression(param_00)
{
	self.ignoresuppression = param_00;
}

//Function Number: 383
set_goalradius(param_00)
{
	self.goalradius = param_00;
}

//Function Number: 384
try_forever_spawn()
{
	var_00 = self.export;
	for(;;)
	{
		var_01 = self dospawn();
		if(spawn_failed(var_01))
		{
			wait(1);
			continue;
		}

		return var_01;
	}
}

//Function Number: 385
set_allowdeath(param_00)
{
	self.allowdeath = param_00;
}

//Function Number: 386
set_run_anim(param_00,param_01)
{
	if(isdefined(param_01))
	{
		self.alwaysrunforward = param_01;
	}
	else
	{
		self.alwaysrunforward = 1;
	}

	disable_turnanims();
	self.run_overrideanim = level.scr_anim[self.animname][param_00];
	self.walk_overrideanim = self.run_overrideanim;
}

//Function Number: 387
set_dog_walk_anim()
{
	self.a.movement = "walk";
	self.disablearrivals = 1;
	self.disableexits = 1;
	self.script_nobark = 1;
}

//Function Number: 388
set_combat_stand_animset(param_00,param_01,param_02,param_03)
{
	animscripts\animset::init_animset_custom_stand(param_00,param_01,param_02,param_03);
}

//Function Number: 389
set_move_animset(param_00,param_01,param_02)
{
	var_03 = animscripts\utility::lookupanimarray(param_00);
	if(isarray(param_01))
	{
		var_03["straight"] = param_01[0];
		var_03["move_f"] = param_01[0];
		var_03["move_l"] = param_01[1];
		var_03["move_r"] = param_01[2];
		var_03["move_b"] = param_01[3];
	}
	else
	{
		var_03["straight"] = param_01;
		var_03["move_f"] = param_01;
	}

	if(isdefined(param_02))
	{
		var_03["sprint"] = param_02;
	}

	self.custommoveanimset[param_00] = var_03;
}

//Function Number: 390
set_generic_idle_anim(param_00)
{
	var_01 = level.scr_anim["generic"][param_00];
	if(isarray(var_01))
	{
		self.specialidleanim = var_01;
		return;
	}

	self.specialidleanim[0] = var_01;
}

//Function Number: 391
set_idle_anim(param_00)
{
	var_01 = level.scr_anim[self.animname][param_00];
	if(isarray(var_01))
	{
		self.specialidleanim = var_01;
		return;
	}

	self.specialidleanim[0] = var_01;
}

//Function Number: 392
clear_generic_idle_anim()
{
	self.specialidleanim = undefined;
	self notify("stop_specialidle");
}

//Function Number: 393
set_generic_run_anim(param_00,param_01)
{
	set_generic_run_anim_array(param_00,undefined,param_01);
}

//Function Number: 394
clear_generic_run_anim()
{
	self notify("movemode");
	enable_turnanims();
	self.run_overrideanim = undefined;
	self.walk_overrideanim = undefined;
}

//Function Number: 395
set_generic_run_anim_array(param_00,param_01,param_02)
{
	self notify("movemode");
	if(!isdefined(param_02) || param_02)
	{
		self.alwaysrunforward = 1;
	}
	else
	{
		self.alwaysrunforward = undefined;
	}

	disable_turnanims();
	self.run_overrideanim = level.scr_anim["generic"][param_00];
	self.walk_overrideanim = self.run_overrideanim;
	if(isdefined(param_01))
	{
		self.run_override_weights = level.scr_anim["generic"][param_01];
		self.walk_override_weights = self.run_override_weights;
		return;
	}

	self.run_override_weights = undefined;
	self.walk_override_weights = undefined;
}

//Function Number: 396
set_run_anim_array(param_00,param_01,param_02)
{
	self notify("movemode");
	if(!isdefined(param_02) || param_02)
	{
		self.alwaysrunforward = 1;
	}
	else
	{
		self.alwaysrunforward = undefined;
	}

	disable_turnanims();
	self.run_overrideanim = level.scr_anim[self.animname][param_00];
	self.walk_overrideanim = self.run_overrideanim;
	if(isdefined(param_01))
	{
		self.run_override_weights = level.scr_anim[self.animname][param_01];
		self.walk_override_weights = self.run_override_weights;
		return;
	}

	self.run_override_weights = undefined;
	self.walk_override_weights = undefined;
}

//Function Number: 397
clear_run_anim()
{
	self notify("clear_run_anim");
	self notify("movemode");
	if(self.type == "dog")
	{
		self.a.movement = "run";
		self.disablearrivals = 0;
		self.disableexits = 0;
		self.script_nobark = undefined;
		return;
	}

	if(!isdefined(self.casual_killer))
	{
		enable_turnanims();
	}

	self.alwaysrunforward = undefined;
	self.run_overrideanim = undefined;
	self.walk_overrideanim = undefined;
	self.run_override_weights = undefined;
	self.walk_override_weights = undefined;
}

//Function Number: 398
debugvar(param_00,param_01)
{
	setdvarifuninitialized(param_00,param_01);
	return getdvarfloat(param_00);
}

//Function Number: 399
physicsjolt_proximity(param_00,param_01,param_02)
{
	self endon("death");
	self endon("stop_physicsjolt");
	if(!isdefined(param_00) || !isdefined(param_01) || !isdefined(param_02))
	{
		param_00 = 400;
		param_01 = 256;
		param_02 = (0,0,0.075);
	}

	var_03 = param_00 * param_00;
	var_04 = 3;
	var_05 = param_02;
	for(;;)
	{
		wait(0.1);
		param_02 = var_05;
		if(self.code_classname == "script_vehicle")
		{
			var_06 = self vehicle_getspeed();
			if(var_06 < var_04)
			{
				var_07 = var_06 / var_04;
				param_02 = var_05 * var_07;
			}
		}

		var_08 = distancesquared(self.origin,level.player.origin);
		var_07 = var_03 / var_08;
		if(var_07 > 1)
		{
			var_07 = 1;
		}

		param_02 = param_02 * var_07;
		var_09 = param_02[0] + param_02[1] + param_02[2];
		if(var_09 > 0.025)
		{
			physicsjitter(self.origin,param_00,param_01,param_02[2],param_02[2] * 2);
		}
	}
}

//Function Number: 400
set_goal_entity(param_00)
{
	self setgoalentity(param_00);
}

//Function Number: 401
activate_trigger(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		activate_trigger_process(param_02);
		return;
	}

	common_scripts\utility::array_thread(getentarray(param_00,param_01),::activate_trigger_process,param_02);
}

//Function Number: 402
activate_trigger_process(param_00)
{
	self notify("trigger",param_00);
}

//Function Number: 403
self_delete()
{
	self delete();
}

//Function Number: 404
remove_nocolor_from_array(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = param_00[var_02];
		if(var_03 has_color())
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 405
clear_colors()
{
	clear_team_colors("axis");
	clear_team_colors("allies");
}

//Function Number: 406
clear_team_colors(param_00)
{
	level.currentcolorforced[param_00]["r"] = undefined;
	level.currentcolorforced[param_00]["b"] = undefined;
	level.currentcolorforced[param_00]["c"] = undefined;
	level.currentcolorforced[param_00]["y"] = undefined;
	level.currentcolorforced[param_00]["p"] = undefined;
	level.currentcolorforced[param_00]["o"] = undefined;
	level.currentcolorforced[param_00]["g"] = undefined;
}

//Function Number: 407
get_script_palette()
{
	var_00 = [];
	var_00["r"] = (1,0,0);
	var_00["o"] = (1,0.5,0);
	var_00["y"] = (1,1,0);
	var_00["g"] = (0,1,0);
	var_00["c"] = (0,1,1);
	var_00["b"] = (0,0,1);
	var_00["p"] = (1,0,1);
	return var_00;
}

//Function Number: 408
notify_delay(param_00,param_01)
{
	self endon("death");
	if(param_01 > 0)
	{
		wait(param_01);
	}

	if(!isdefined(self))
	{
		return;
	}

	self notify(param_00);
}

//Function Number: 409
gun_remove()
{
	if(isai(self))
	{
		animscripts\shared::placeweaponon(self.weapon,"none");
		return;
	}

	detach_attachments_from_weapon_model(self.weapon);
	self detach(getweaponmodel(self.weapon),"tag_weapon_right");
}

//Function Number: 410
gun_recall()
{
	if(isai(self))
	{
		animscripts\shared::placeweaponon(self.weapon,"right");
		return;
	}

	self attach(getweaponmodel(self.weapon),"tag_weapon_right");
	update_weapon_tag_visibility(self.weapon);
}

//Function Number: 411
update_weapon_tag_visibility(param_00)
{
	if(isdefined(param_00) && param_00 != "none")
	{
		var_01 = getweaponandattachmentmodels(param_00);
		var_02 = array_remove_index(var_01,0);
		foreach(var_04 in var_02)
		{
			self attach(var_04["worldModel"],var_04["attachTag"]);
		}

		self hideweapontags(param_00);
	}
}

//Function Number: 412
detach_attachments_from_weapon_model(param_00)
{
	if(isdefined(param_00) && param_00 != "none")
	{
		var_01 = getweaponandattachmentmodels(param_00);
		var_02 = array_remove_index(var_01,0);
		foreach(var_04 in var_02)
		{
			self detach(var_04["worldModel"],var_04["attachTag"],0);
		}
	}
}

//Function Number: 413
attach_player_current_weapon_to_rig(param_00)
{
	var_01 = level.player getcurrentweapon();
	var_02 = getweaponandattachmentmodels(var_01);
	var_03 = var_02[0]["weapon"];
	var_04 = array_remove_index(var_02,0);
	param_00 attach(var_03,"TAG_WEAPON_RIGHT",1);
	foreach(var_06 in var_04)
	{
		param_00 attach(var_06["attachment"],var_06["attachTag"]);
	}

	param_00 hideweapontags(var_01);
}

//Function Number: 414
place_weapon_on(param_00,param_01)
{
	if(!animscripts\utility::aihasweapon(param_00))
	{
		animscripts\init::initweapon(param_00);
	}

	animscripts\shared::placeweaponon(param_00,param_01);
}

//Function Number: 415
forceuseweapon(param_00,param_01)
{
	if(!animscripts\init::isweaponinitialized(param_00))
	{
		animscripts\init::initweapon(param_00);
	}

	var_02 = self.weapon != "none";
	var_03 = animscripts\utility::usingsidearm();
	var_04 = param_01 == "sidearm";
	var_05 = param_01 == "secondary";
	if(var_02 && var_03 != var_04)
	{
		if(var_03)
		{
			var_06 = "none";
		}
		else if(var_06)
		{
			var_06 = "back";
		}
		else
		{
			var_06 = "chest";
		}

		animscripts\shared::placeweaponon(self.weapon,var_06);
		self.lastweapon = self.weapon;
	}
	else
	{
		self.lastweapon = param_00;
	}

	animscripts\shared::placeweaponon(param_00,"right");
	if(var_04)
	{
		self.sidearm = param_00;
	}
	else if(var_05)
	{
		self.secondaryweapon = param_00;
	}
	else
	{
		self.primaryweapon = param_00;
	}

	self.weapon = param_00;
	self.bulletsinclip = weaponclipsize(self.weapon);
	self notify("weapon_switch_done");
}

//Function Number: 416
lerp_player_view_to_tag(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	maps\_utility_code::lerp_player_view_to_tag_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,0);
}

//Function Number: 417
lerp_player_view_to_tag_and_hit_geo(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	maps\_utility_code::lerp_player_view_to_tag_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,1);
}

//Function Number: 418
lerp_player_view_to_position(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	param_09 = get_player_from_self();
	var_0A = spawn("script_origin",(0,0,0));
	var_0A.origin = param_09.origin;
	var_0A.angles = param_09 getplayerangles();
	if(isdefined(param_08) && param_08)
	{
		param_09 playerlinkto(var_0A,"",param_03,param_04,param_05,param_06,param_07,param_08);
	}
	else if(isdefined(param_04))
	{
		param_09 playerlinkto(var_0A,"",param_03,param_04,param_05,param_06,param_07);
	}
	else if(isdefined(param_03))
	{
		param_09 playerlinkto(var_0A,"",param_03);
	}
	else
	{
		param_09 playerlinkto(var_0A);
	}

	var_0A moveto(param_00,param_02,param_02 * 0.25);
	var_0A rotateto(param_01,param_02,param_02 * 0.25);
	wait(param_02);
	var_0A delete();
}

//Function Number: 419
lerp_player_view_to_tag_oldstyle(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	maps\_utility_code::lerp_player_view_to_tag_oldstyle_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,0);
}

//Function Number: 420
lerp_player_view_to_position_oldstyle(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = get_player_from_self();
	var_0A = spawn("script_origin",(0,0,0));
	var_0A.origin = var_09 get_player_feet_from_view();
	var_0A.angles = var_09 getplayerangles();
	if(isdefined(param_08))
	{
		var_09 playerlinktodelta(var_0A,"",param_03,param_04,param_05,param_06,param_07,param_08);
	}
	else if(isdefined(param_04))
	{
		var_09 playerlinktodelta(var_0A,"",param_03,param_04,param_05,param_06,param_07);
	}
	else if(isdefined(param_03))
	{
		var_09 playerlinktodelta(var_0A,"",param_03);
	}
	else
	{
		var_09 playerlinktodelta(var_0A);
	}

	var_0A moveto(param_00,param_02,param_02 * 0.25);
	var_0A rotateto(param_01,param_02,param_02 * 0.25);
	wait(param_02);
	var_0A delete();
}

//Function Number: 421
player_moves(param_00)
{
	var_01 = level.player.origin;
	for(;;)
	{
		if(distance(var_01,level.player.origin) > param_00)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 422
waittill_either_function(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	thread maps\_utility_code::waittill_either_function_internal(var_04,param_00,param_01);
	thread maps\_utility_code::waittill_either_function_internal(var_04,param_02,param_03);
	var_04 waittill("done");
}

//Function Number: 423
waittill_msg(param_00)
{
	self waittill(param_00);
}

//Function Number: 424
display_hint(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = get_player_from_self();
	if(isdefined(level.trigger_hint_func[param_00]))
	{
		if(var_05 [[ level.trigger_hint_func[param_00] ]]())
		{
			return;
		}

		var_05 thread maps\_utility_code::hintprint(level.trigger_hint_string[param_00],level.trigger_hint_func[param_00],param_01,param_02,param_03,undefined,undefined,param_04);
		return;
	}

	var_05 thread maps\_utility_code::hintprint(level.trigger_hint_string[param_00],undefined,undefined,undefined,undefined,undefined,undefined,param_04);
}

//Function Number: 425
hintdisplayhandler(param_00,param_01,param_02,param_03,param_04,param_05)
{
	maps\_utility_code::hintdisplayhandlersetup(param_00);
	if(!isdefined(param_01))
	{
		display_hint(param_00,param_02,param_03,param_04,param_05);
		return;
	}

	display_hint_timeout(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 426
hintdisplaymintimehandler(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = get_player_from_self();
	if(var_06 [[ level.trigger_hint_func[param_00] ]]())
	{
		return;
	}

	maps\_utility_code::hintdisplayhandlersetup(param_00);
	var_06 thread maps\_utility_code::hintprint(level.trigger_hint_string[param_00],level.trigger_hint_func[param_00],param_03,param_04,param_05,param_01,param_02);
}

//Function Number: 427
add_control_based_hint_strings(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.trigger_hint_string))
	{
		level.trigger_hint_string = [];
		level.trigger_hint_func = [];
	}

	level.trigger_hint_string[param_00] = param_01;
	level.hint_list[param_00]["gamepad"] = param_01;
	level.hint_list[param_00]["pc"] = param_03;
	level.hint_list[param_00]["southpaw"] = param_04;
	precachestring(param_01);
	if(isdefined(param_03))
	{
		precachestring(param_03);
	}

	if(isdefined(param_04))
	{
		precachestring(param_04);
	}

	if(isdefined(param_02))
	{
		level.trigger_hint_func[param_00] = param_02;
	}
}

//Function Number: 428
handletriggerhintinputtypetext()
{
	if(!isdefined(level.hint_triggers))
	{
		level.hint_triggers = [];
	}

	for(;;)
	{
		level.hint_triggers = common_scripts\utility::array_removeundefined(level.hint_triggers);
		if(isdefined(level.hint_triggers) && isdefined(level.player))
		{
			foreach(var_01 in level.hint_triggers)
			{
				if(level.player common_scripts\utility::is_player_gamepad_enabled())
				{
					var_01 sethintstring(var_01.gp_hint_text);
					continue;
				}

				var_01 sethintstring(var_01.pc_hint_text);
			}
		}

		wait(0.1);
	}
}

//Function Number: 429
addhinttrigger(param_00,param_01)
{
	if(!isdefined(level.hint_triggers))
	{
		thread handletriggerhintinputtypetext();
		level.hint_triggers = [];
	}

	var_02 = 0;
	foreach(var_04 in level.hint_triggers)
	{
		if(self == var_04)
		{
			var_04.gp_hint_text = param_00;
			var_04.pc_hint_text = param_01;
			var_02 = 1;
			break;
		}
	}

	if(!var_02)
	{
		self.gp_hint_text = param_00;
		self.pc_hint_text = param_01;
		level.hint_triggers = common_scripts\utility::array_add(level.hint_triggers,self);
	}
}

//Function Number: 430
display_hint_timeout(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = get_player_from_self();
	if(var_06 [[ level.trigger_hint_func[param_00] ]]())
	{
		return;
	}

	var_06 thread maps\_utility_code::hintprint(level.trigger_hint_string[param_00],level.trigger_hint_func[param_00],param_02,param_03,param_04,param_01,undefined,param_05);
}

//Function Number: 431
display_hint_timeout_mintime(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = get_player_from_self();
	if(var_06 [[ level.trigger_hint_func[param_00] ]]())
	{
		return;
	}

	var_06 thread maps\_utility_code::hintprint(level.trigger_hint_string[param_00],level.trigger_hint_func[param_00],param_03,param_04,param_05,param_01,param_02);
}

//Function Number: 432
display_hint_stick(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	var_0A = maps\_utility_code::hint_stick_get_updated(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	thread display_hint(var_0A,param_07,param_08,param_09);
	thread maps\_utility_code::hint_stick_update(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 433
display_hint_stick_timeout(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(!isdefined(param_07))
	{
		param_07 = 0;
	}

	var_0B = maps\_utility_code::hint_stick_get_updated(param_00,param_02,param_03,param_04,param_05,param_06,param_07);
	thread display_hint_timeout(var_0B,param_01,param_08,param_09,param_0A);
	thread maps\_utility_code::hint_stick_update(param_00,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 434
display_hint_stick_timeout_mintime(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(param_08))
	{
		param_08 = 0;
	}

	var_0C = maps\_utility_code::hint_stick_get_updated(param_00,param_03,param_04,param_05,param_06,param_07,param_08);
	thread display_hint_timeout_mintime(var_0C,param_01,param_02,param_09,param_0A,param_0B);
	thread maps\_utility_code::hint_stick_update(param_00,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 435
check_hint_condition(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		return [[ level.trigger_hint_func[param_00] ]](param_01,param_02,param_03);
	}

	if(isdefined(param_02))
	{
		return [[ level.trigger_hint_func[param_00] ]](param_01,param_02);
	}

	if(isdefined(param_01))
	{
		return [[ level.trigger_hint_func[param_00] ]](param_01);
	}

	return [[ level.trigger_hint_func[param_00] ]]();
}

//Function Number: 436
getgenericanim(param_00)
{
	return level.scr_anim["generic"][param_00];
}

//Function Number: 437
enable_careful()
{
	self.script_careful = 1;
}

//Function Number: 438
disable_careful()
{
	self.script_careful = 0;
	self notify("stop_being_careful");
}

//Function Number: 439
enable_sprint()
{
	self.sprint = 1;
}

//Function Number: 440
disable_sprint()
{
	self.sprint = undefined;
}

//Function Number: 441
disable_bulletwhizbyreaction()
{
	self.disablebulletwhizbyreaction = 1;
}

//Function Number: 442
enable_bulletwhizbyreaction()
{
	self.disablebulletwhizbyreaction = undefined;
}

//Function Number: 443
clear_dvar(param_00)
{
	setdvar(param_00,"");
}

//Function Number: 444
set_fixednode_true()
{
	self.fixednode = 1;
}

//Function Number: 445
set_fixednode_false()
{
	self.fixednode = 0;
}

//Function Number: 446
spawn_ai(param_00,param_01)
{
	if(isdefined(self.script_delay_spawn))
	{
		self endon("death");
		wait(self.script_delay_spawn);
	}

	var_02 = undefined;
	var_03 = isdefined(self.script_stealth) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
	if(isdefined(self.script_forcespawn) || isdefined(param_00))
	{
		if(!isdefined(self.script_drone))
		{
			var_02 = self stalingradspawn(var_03);
		}
		else
		{
			var_02 = dronespawn(self);
		}
	}
	else if(!isdefined(self.script_drone))
	{
		var_02 = self dospawn(var_03);
	}
	else
	{
		var_02 = dronespawn(self);
	}

	if(isdefined(param_01) && param_01 && isalive(var_02))
	{
		var_02 magic_bullet_shield();
	}

	if(!isdefined(self.script_drone))
	{
		spawn_failed(var_02);
	}

	if(isdefined(self.script_spawn_once))
	{
		self delete();
	}

	if(isdefined(var_02))
	{
		var_02.spawner = self;
	}

	if(isdefined(var_02) && !isdefined(var_02.targetname))
	{
		if(isdefined(self.targetname))
		{
			var_02.targetname = self.targetname + "_AI";
		}
	}

	return var_02;
}

//Function Number: 447
function_stack(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	var_06 thread maps\_utility_code::function_stack_proc(self,param_00,param_01,param_02,param_03,param_04,param_05);
	return maps\_utility_code::function_stack_wait_finish(var_06);
}

//Function Number: 448
function_stack_timeout(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = spawnstruct();
	var_07 thread maps\_utility_code::function_stack_proc(self,param_01,param_02,param_03,param_04,param_05,param_06);
	if(isdefined(var_07.function_stack_func_begun) || var_07 common_scripts\utility::waittill_any_timeout(param_00,"function_stack_func_begun") != "timeout")
	{
		return maps\_utility_code::function_stack_wait_finish(var_07);
	}

	var_07 notify("death");
	return 0;
}

//Function Number: 449
function_stack_clear()
{
	var_00 = [];
	if(isdefined(self.function_stack[0]) && isdefined(self.function_stack[0].function_stack_func_begun))
	{
		var_00[0] = self.function_stack[0];
	}

	self.function_stack = undefined;
	self notify("clear_function_stack");
	waittillframeend;
	if(!var_00.size)
	{
		return;
	}

	if(!var_00[0].function_stack_func_begun)
	{
		return;
	}

	self.function_stack = var_00;
}

//Function Number: 450
geo_off()
{
	if(isdefined(self.geo_off))
	{
		return;
	}

	self.realorigin = self getorigin();
	self moveto(self.realorigin + (0,0,-10000),0.2);
	self.geo_off = 1;
}

//Function Number: 451
geo_on()
{
	if(!isdefined(self.geo_off))
	{
		return;
	}

	self moveto(self.realorigin,0.2);
	self waittill("movedone");
	self.geo_off = undefined;
}

//Function Number: 452
disable_exits()
{
	self.disableexits = 1;
}

//Function Number: 453
enable_exits()
{
	self.disableexits = undefined;
}

//Function Number: 454
disable_turnanims()
{
	self.noturnanims = 1;
}

//Function Number: 455
enable_turnanims()
{
	self.noturnanims = undefined;
}

//Function Number: 456
disable_arrivals()
{
	self.disablearrivals = 1;
}

//Function Number: 457
enable_arrivals()
{
	self endon("death");
	waittillframeend;
	self.disablearrivals = undefined;
}

//Function Number: 458
set_blur(param_00,param_01)
{
	setblur(param_00,param_01);
}

//Function Number: 459
set_goal_radius(param_00)
{
	self.goalradius = param_00;
}

//Function Number: 460
set_goal_node(param_00)
{
	self.last_set_goalnode = param_00;
	self.last_set_goalpos = undefined;
	self.last_set_goalent = undefined;
	self setgoalnode(param_00);
}

//Function Number: 461
set_goal_node_targetname(param_00)
{
	var_01 = getnode(param_00,"targetname");
	set_goal_node(var_01);
}

//Function Number: 462
set_goal_pos(param_00)
{
	self.last_set_goalnode = undefined;
	self.last_set_goalpos = param_00;
	self.last_set_goalent = undefined;
	self setgoalpos(param_00);
}

//Function Number: 463
set_goal_ent(param_00)
{
	set_goal_pos(param_00.origin);
	self.last_set_goalent = param_00;
}

//Function Number: 464
objective_complete(param_00)
{
	maps\_utility_code::objective_recon(param_00);
	objective_state(param_00,"done");
	level notify("objective_complete" + param_00);
}

//Function Number: 465
handsignal(param_00,param_01,param_02,param_03)
{
	var_04 = 1;
	if(isdefined(param_01))
	{
		var_04 = !param_01;
	}

	if(isdefined(param_02))
	{
		level endon(param_02);
	}

	if(isdefined(param_03))
	{
		level waittill(param_03);
	}

	var_05 = "signal_" + param_00;
	if(self.a.pose == "crouch")
	{
		var_05 = var_05 + "_crouch";
	}
	else if(self.script == "cover_right" || self.script == "cover_multi" && self.cover.state == "right")
	{
		var_05 = var_05 + "_coverR";
	}
	else if(animscripts\utility::iscqbwalking())
	{
		var_05 = var_05 + "_cqb";
	}

	if(var_04)
	{
		self setanimrestart(getgenericanim(var_05),1,0,1.1);
		return;
	}

	maps\_anim::anim_generic(self,var_05);
}

//Function Number: 466
array_spawn(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = [];
	foreach(var_05 in param_00)
	{
		var_05.count = 1;
		if(getsubstr(var_05.classname,7,10) == "veh")
		{
			var_06 = var_05 spawn_vehicle();
			if(isdefined(var_06.target) && !isdefined(var_06.script_moveoverride))
			{
				var_06 thread maps\_vehicle::gopath();
			}

			var_03[var_03.size] = var_06;
			continue;
		}

		var_06 = var_05 spawn_ai(param_01);
		if(!param_02)
		{
		}

		var_03[var_03.size] = var_06;
	}

	if(!param_02)
	{
	}

	return var_03;
}

//Function Number: 467
array_spawn_cg(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_04 = [];
	foreach(var_06 in param_00)
	{
		var_06.count = 1;
		if(getsubstr(var_06.classname,7,10) == "veh")
		{
			var_07 = var_06 spawn_vehicle();
			if(isdefined(var_07.target) && !isdefined(var_07.script_moveoverride))
			{
				var_07 thread maps\_vehicle::gopath();
			}

			var_04[var_04.size] = var_07;
			continue;
		}

		var_07 = var_06 spawn_ai(1);
		var_04 = common_scripts\utility::array_add(var_04,var_07);
		if(isdefined(param_03))
		{
			wait(param_03);
			continue;
		}

		wait 0.05;
	}

	if(!param_02)
	{
	}

	return var_04;
}

//Function Number: 468
array_spawn_targetname(param_00,param_01,param_02,param_03)
{
	var_04 = getentarray(param_00,"targetname");
	if(isdefined(level.spawn_pool_enabled))
	{
		var_05 = common_scripts\utility::getstructarray(param_00,"targetname");
		if(isdefined(param_03) && param_03)
		{
			deletestructarray_ref(var_05);
		}

		var_06 = maps\_spawner::get_pool_spawners_from_structarray(var_05);
		var_04 = common_scripts\utility::array_combine(var_04,var_06);
	}

	return array_spawn(var_04,param_01,param_02);
}

//Function Number: 469
array_spawn_targetname_cg(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getentarray(param_00,"targetname");
	if(isdefined(level.spawn_pool_enabled))
	{
		var_06 = common_scripts\utility::getstructarray(param_00,"targetname");
		if(isdefined(param_04) && param_04)
		{
			deletestructarray_ref(var_06);
		}

		var_07 = maps\_spawner::get_pool_spawners_from_structarray(var_06);
		var_05 = common_scripts\utility::array_combine(var_05,var_07);
	}

	return array_spawn_cg(var_05,param_01,param_03,param_02);
}

//Function Number: 470
array_spawn_noteworthy(param_00,param_01,param_02,param_03)
{
	var_04 = getentarray(param_00,"script_noteworthy");
	if(isdefined(level.spawn_pool_enabled))
	{
		var_05 = common_scripts\utility::getstructarray(param_00,"script_noteworthy");
		if(isdefined(param_03) && param_03)
		{
			deletestructarray_ref(var_05);
		}

		var_06 = maps\_spawner::get_pool_spawners_from_structarray(var_05);
		var_04 = common_scripts\utility::array_combine(var_04,var_06);
	}

	return array_spawn(var_04,param_01,param_02);
}

//Function Number: 471
spawn_script_noteworthy(param_00,param_01)
{
	var_02 = getent(param_00,"script_noteworthy");
	var_03 = var_02 spawn_ai(param_01);
	return var_03;
}

//Function Number: 472
spawn_targetname(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_03 = var_02 spawn_ai(param_01);
	return var_03;
}

//Function Number: 473
add_dialogue_line(param_00,param_01,param_02)
{
	if(getdvarint("loc_warnings",0))
	{
		return;
	}

	if(!isdefined(level.dialogue_huds))
	{
		level.dialogue_huds = [];
	}

	var_03 = 0;
	for(;;)
	{
		if(!isdefined(level.dialogue_huds[var_03]))
		{
			break;
		}

		var_03++;
	}

	var_04 = "^3";
	if(isdefined(param_02))
	{
		switch(param_02)
		{
			case "red":
			case "r":
				break;

			case "green":
			case "g":
				break;

			case "yellow":
			case "y":
				break;

			case "blue":
			case "b":
				break;

			case "cyan":
			case "c":
				break;

			case "purple":
			case "p":
				break;

			case "white":
			case "w":
				break;

			case "black":
			case "bl":
				break;
		}
	}
}

//Function Number: 474
destructible_disable_explosion()
{
	common_scripts\_destructible::disable_explosion();
}

//Function Number: 475
destructible_force_explosion()
{
	common_scripts\_destructible::force_explosion();
}

//Function Number: 476
set_grenadeammo(param_00)
{
	self.grenadeammo = param_00;
}

//Function Number: 477
get_player_feet_from_view()
{
	var_00 = self.origin;
	var_01 = anglestoup(self getplayerangles());
	var_02 = self getplayerviewheight();
	var_03 = var_00 + (0,0,var_02);
	var_04 = var_00 + var_01 * var_02;
	var_05 = var_03 - var_04;
	var_06 = var_00 + var_05;
	return var_06;
}

//Function Number: 478
set_baseaccuracy(param_00)
{
	self.baseaccuracy = param_00;
}

//Function Number: 479
set_console_status()
{
	if(!isdefined(level.console))
	{
		level.console = getdvar("consoleGame") == "true";
	}
	else
	{
	}

	if(!isdefined(level.xenon))
	{
		level.xenon = getdvar("xenonGame") == "true";
	}
	else
	{
	}

	if(!isdefined(level.ps3))
	{
		level.ps3 = getdvar("ps3Game") == "true";
	}
	else
	{
	}

	if(!isdefined(level.wiiugame))
	{
		level.wiiugame = getdvar("wiiuGame") == "true";
	}
	else
	{
	}

	if(!isdefined(level.pccg))
	{
		level.pccg = getdvar("pccgGame") == "true";
	}
	else
	{
	}

	if(!isdefined(level.xb3))
	{
		level.xb3 = getdvar("xb3Game") == "true";
	}
	else
	{
	}

	if(!isdefined(level.ps4))
	{
		level.ps4 = getdvar("ps4Game") == "true";
	}
	else
	{
	}

	if(!isdefined(level.pc))
	{
		level.pc = !level.console && !level.pccg;
	}
	else
	{
	}

	if(!isdefined(level.currentgen))
	{
		level.currentgen = level.ps3 || level.pccg || level.xenon || level.wiiugame;
	}
	else
	{
	}

	if(!isdefined(level.nextgen))
	{
		level.nextgen = level.pc || level.ps4 || level.xb3;
	}
}

//Function Number: 480
is_gen4()
{
	return level.nextgen;
}

//Function Number: 481
autosave_now(param_00)
{
	return maps\_autosave::_autosave_game_now(param_00);
}

//Function Number: 482
autosave_now_silent()
{
	return maps\_autosave::_autosave_game_now(1);
}

//Function Number: 483
set_generic_deathanim(param_00)
{
	self.deathanim = getgenericanim(param_00);
}

//Function Number: 484
set_deathanim(param_00)
{
	self.deathanim = getanim(param_00);
}

//Function Number: 485
clear_deathanim()
{
	self.deathanim = undefined;
}

//Function Number: 486
hunted_style_door_open(param_00)
{
	wait(1.75);
	if(isdefined(param_00))
	{
		self playsound(param_00);
	}
	else
	{
		self playsound("door_wood_slow_open");
	}

	self rotateto(self.angles + (0,70,0),2,0.5,0);
	self connectpaths();
	self waittill("rotatedone");
	self rotateto(self.angles + (0,40,0),2,0,2);
}

//Function Number: 487
palm_style_door_open(param_00)
{
	wait(1.35);
	if(isdefined(param_00))
	{
		self playsound(param_00);
	}
	else
	{
		self playsound("door_wood_slow_open");
	}

	self rotateto(self.angles + (0,70,0),2,0.5,0);
	self connectpaths();
	self waittill("rotatedone");
	self rotateto(self.angles + (0,40,0),2,0,2);
}

//Function Number: 488
lerp_fov_overtime(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		var_03 lerpfov(param_01,param_00);
	}

	wait(param_00);
}

//Function Number: 489
lerp_fovscale_overtime(param_00,param_01)
{
	var_02 = getdvarfloat("cg_fovscale");
	var_03 = int(param_00 / 0.05);
	var_04 = param_01 - var_02 / var_03;
	var_05 = var_02;
	for(var_06 = 0;var_06 < var_03;var_06++)
	{
		var_05 = var_05 + var_04;
		setsaveddvar("cg_fovscale",var_05);
		wait(0.05);
	}

	setsaveddvar("cg_fovscale",param_01);
}

//Function Number: 490
putgunaway()
{
	animscripts\shared::placeweaponon(self.weapon,"none");
	self.weapon = "none";
}

//Function Number: 491
apply_fog()
{
	maps\_art::set_fog_progress(0);
}

//Function Number: 492
apply_end_fog()
{
	maps\_art::set_fog_progress(1);
}

//Function Number: 493
anim_stopanimscripted()
{
	self stopanimscripted();
	self notify("stop_loop");
	self notify("single anim","end");
	self notify("looping anim","end");
}

//Function Number: 494
disable_pain()
{
	self.a.disablepain = 1;
	self.allowpain = 0;
}

//Function Number: 495
enable_pain()
{
	self.a.disablepain = 0;
	self.allowpain = 1;
}

//Function Number: 496
_delete()
{
	self delete();
}

//Function Number: 497
_kill()
{
	self kill();
}

//Function Number: 498
kill_wrapper()
{
	if(isplayer(self))
	{
		if(common_scripts\utility::flag_exist("special_op_terminated") && common_scripts\utility::flag("special_op_terminated"))
		{
			return 0;
		}

		if(is_player_down(self))
		{
			self disableinvulnerability();
		}
	}

	self enabledeathshield(0);
	self kill();
	return 1;
}

//Function Number: 499
_setentitytarget(param_00)
{
	self setentitytarget(param_00);
}

//Function Number: 500
_clearentitytarget()
{
	self clearentitytarget();
}

//Function Number: 501
_unlink()
{
	self unlink();
}

//Function Number: 502
disable_oneshotfx_with_noteworthy(param_00)
{
	var_01 = getarraykeys(level._global_fx_ents[param_00]);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		level._global_fx_ents[param_00][var_01[var_02]].looper delete();
		level._global_fx_ents[param_00][var_01[var_02]] = undefined;
	}
}

//Function Number: 503
_setlightintensity(param_00)
{
	self setlightintensity(param_00);
}

//Function Number: 504
_linkto(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		self linkto(param_00,param_01,param_02,param_03);
		return;
	}

	if(isdefined(param_02))
	{
		self linkto(param_00,param_01,param_02);
		return;
	}

	if(isdefined(param_01))
	{
		self linkto(param_00,param_01);
		return;
	}

	self linkto(param_00);
}

//Function Number: 505
array_wait(param_00,param_01,param_02)
{
	var_03 = getarraykeys(param_00);
	var_04 = [];
	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		var_06 = var_03[var_05];
	}

	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		var_06 = var_03[var_05];
		var_04[var_06] = spawnstruct();
		var_04[var_06]._array_wait = 1;
		var_04[var_06] thread maps\_utility_code::array_waitlogic1(param_00[var_06],param_01,param_02);
	}

	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		var_06 = var_03[var_05];
		if(isdefined(param_00[var_06]) && var_04[var_06]._array_wait)
		{
			var_04[var_06] waittill("_array_wait");
		}
	}
}

//Function Number: 506
die()
{
	self kill((0,0,0));
}

//Function Number: 507
getmodel(param_00)
{
	return level.scr_model[param_00];
}

//Function Number: 508
isads()
{
	return self playerads() > 0.5;
}

//Function Number: 509
waittill_player_lookat(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_05))
	{
		param_05 = level.player;
	}

	var_06 = spawnstruct();
	if(isdefined(param_03))
	{
		var_06 thread notify_delay("timeout",param_03);
	}

	var_06 endon("timeout");
	if(!isdefined(param_00))
	{
		param_00 = 0.92;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_07 = int(param_01 * 20);
	var_08 = var_07;
	self endon("death");
	var_09 = isai(self);
	var_0A = undefined;
	for(;;)
	{
		if(var_09)
		{
			var_0A = self geteye();
		}
		else
		{
			var_0A = self.origin;
		}

		if(param_05 player_looking_at(var_0A,param_00,param_02,param_04))
		{
			var_08--;
			if(var_08 <= 0)
			{
				return 1;
			}
		}
		else
		{
			var_08 = var_07;
		}

		wait(0.05);
	}
}

//Function Number: 510
waittill_player_lookat_for_time(param_00,param_01,param_02,param_03)
{
	waittill_player_lookat(param_01,param_00,param_02,undefined,param_03);
}

//Function Number: 511
player_looking_at(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = 0.8;
	}

	var_04 = get_player_from_self();
	var_05 = var_04 geteye();
	var_06 = vectortoangles(param_00 - var_05);
	var_07 = anglestoforward(var_06);
	var_08 = var_04 getplayerangles();
	var_09 = anglestoforward(var_08);
	var_0A = vectordot(var_07,var_09);
	if(var_0A < param_01)
	{
		return 0;
	}

	if(isdefined(param_02))
	{
		return 1;
	}

	var_0B = bullettrace(param_00,var_05,0,param_03);
	return var_0B["fraction"] == 1;
}

//Function Number: 512
either_player_looking_at(param_00,param_01,param_02,param_03)
{
	for(var_04 = 0;var_04 < level.players.size;var_04++)
	{
		if(level.players[var_04] player_looking_at(param_00,param_01,param_02,param_03))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 513
player_can_see_ai(param_00,param_01)
{
	var_02 = gettime();
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(isdefined(param_00.playerseesmetime) && param_00.playerseesmetime + param_01 >= var_02)
	{
		return param_00.playerseesme;
	}

	param_00.playerseesmetime = var_02;
	if(!common_scripts\utility::within_fov(level.player.origin,level.player.angles,param_00.origin,0.766))
	{
		param_00.playerseesme = 0;
		return 0;
	}

	var_03 = level.player geteye();
	var_04 = param_00.origin;
	if(sighttracepassed(var_03,var_04,1,level.player,param_00))
	{
		param_00.playerseesme = 1;
		return 1;
	}

	var_05 = param_00 geteye();
	if(sighttracepassed(var_03,var_05,1,level.player,param_00))
	{
		param_00.playerseesme = 1;
		return 1;
	}

	var_06 = var_05 + var_04 * 0.5;
	if(sighttracepassed(var_03,var_06,1,level.player,param_00))
	{
		param_00.playerseesme = 1;
		return 1;
	}

	param_00.playerseesme = 0;
	return 0;
}

//Function Number: 514
players_within_distance(param_00,param_01)
{
	var_02 = param_00 * param_00;
	for(var_03 = 0;var_03 < level.players.size;var_03++)
	{
		if(distancesquared(param_01,level.players[var_03].origin) < var_02)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 515
ai_delete_when_out_of_sight(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_02 = 0.75;
	if(issplitscreen())
	{
		var_02 = 0.65;
	}

	while(param_00.size > 0)
	{
		wait(1);
		for(var_03 = 0;var_03 < param_00.size;var_03++)
		{
			if(!isdefined(param_00[var_03]) || !isalive(param_00[var_03]))
			{
				param_00 = common_scripts\utility::array_remove(param_00,param_00[var_03]);
				continue;
			}

			if(players_within_distance(param_01,param_00[var_03].origin))
			{
				continue;
			}

			if(either_player_looking_at(param_00[var_03].origin + (0,0,48),var_02,1))
			{
				continue;
			}

			if(isdefined(param_00[var_03].magic_bullet_shield))
			{
				param_00[var_03] stop_magic_bullet_shield();
			}

			param_00[var_03] delete();
			param_00 = common_scripts\utility::array_remove(param_00,param_00[var_03]);
		}
	}
}

//Function Number: 516
add_wait(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.caller = self;
	var_04.func = param_00;
	var_04.parms = [];
	if(isdefined(param_01))
	{
		var_04.parms[var_04.parms.size] = param_01;
	}

	if(isdefined(param_02))
	{
		var_04.parms[var_04.parms.size] = param_02;
	}

	if(isdefined(param_03))
	{
		var_04.parms[var_04.parms.size] = param_03;
	}

	level.wait_any_func_array[level.wait_any_func_array.size] = var_04;
}

//Function Number: 517
add_abort(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.caller = self;
	var_04.func = param_00;
	var_04.parms = [];
	if(isdefined(param_01))
	{
		var_04.parms[var_04.parms.size] = param_01;
	}

	if(isdefined(param_02))
	{
		var_04.parms[var_04.parms.size] = param_02;
	}

	if(isdefined(param_03))
	{
		var_04.parms[var_04.parms.size] = param_03;
	}

	level.abort_wait_any_func_array[level.abort_wait_any_func_array.size] = var_04;
}

//Function Number: 518
add_func(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	var_06.caller = self;
	var_06.func = param_00;
	var_06.parms = [];
	if(isdefined(param_01))
	{
		var_06.parms[var_06.parms.size] = param_01;
	}

	if(isdefined(param_02))
	{
		var_06.parms[var_06.parms.size] = param_02;
	}

	if(isdefined(param_03))
	{
		var_06.parms[var_06.parms.size] = param_03;
	}

	if(isdefined(param_04))
	{
		var_06.parms[var_06.parms.size] = param_04;
	}

	if(isdefined(param_05))
	{
		var_06.parms[var_06.parms.size] = param_05;
	}

	level.run_func_after_wait_array[level.run_func_after_wait_array.size] = var_06;
}

//Function Number: 519
add_call(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	var_06.caller = self;
	var_06.func = param_00;
	var_06.parms = [];
	if(isdefined(param_01))
	{
		var_06.parms[var_06.parms.size] = param_01;
	}

	if(isdefined(param_02))
	{
		var_06.parms[var_06.parms.size] = param_02;
	}

	if(isdefined(param_03))
	{
		var_06.parms[var_06.parms.size] = param_03;
	}

	if(isdefined(param_04))
	{
		var_06.parms[var_06.parms.size] = param_04;
	}

	if(isdefined(param_05))
	{
		var_06.parms[var_06.parms.size] = param_05;
	}

	level.run_call_after_wait_array[level.run_call_after_wait_array.size] = var_06;
}

//Function Number: 520
add_noself_call(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	var_06.func = param_00;
	var_06.parms = [];
	if(isdefined(param_01))
	{
		var_06.parms[var_06.parms.size] = param_01;
	}

	if(isdefined(param_02))
	{
		var_06.parms[var_06.parms.size] = param_02;
	}

	if(isdefined(param_03))
	{
		var_06.parms[var_06.parms.size] = param_03;
	}

	if(isdefined(param_04))
	{
		var_06.parms[var_06.parms.size] = param_04;
	}

	if(isdefined(param_05))
	{
		var_06.parms[var_06.parms.size] = param_05;
	}

	level.run_noself_call_after_wait_array[level.run_noself_call_after_wait_array.size] = var_06;
}

//Function Number: 521
add_endon(param_00)
{
	var_01 = spawnstruct();
	var_01.caller = self;
	var_01.ender = param_00;
	level.do_wait_endons_array[level.do_wait_endons_array.size] = var_01;
}

//Function Number: 522
do_wait_any()
{
	do_wait(level.wait_any_func_array.size - 1);
}

//Function Number: 523
do_wait(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = spawnstruct();
	var_02 = level.wait_any_func_array;
	var_03 = level.do_wait_endons_array;
	var_04 = level.run_func_after_wait_array;
	var_05 = level.run_call_after_wait_array;
	var_06 = level.run_noself_call_after_wait_array;
	var_07 = level.abort_wait_any_func_array;
	level.wait_any_func_array = [];
	level.run_func_after_wait_array = [];
	level.do_wait_endons_array = [];
	level.abort_wait_any_func_array = [];
	level.run_call_after_wait_array = [];
	level.run_noself_call_after_wait_array = [];
	var_01.count = var_02.size;
	var_01 common_scripts\utility::array_levelthread(var_02,::maps\_utility_code::waittill_func_ends,var_03);
	var_01 thread maps\_utility_code::do_abort(var_07);
	var_01 endon("any_funcs_aborted");
	for(;;)
	{
		if(var_01.count <= param_00)
		{
			break;
		}

		var_01 waittill("func_ended");
	}

	var_01 notify("all_funcs_ended");
	common_scripts\utility::array_levelthread(var_04,::maps\_utility_code::exec_func,[]);
	common_scripts\utility::array_levelthread(var_05,::maps\_utility_code::exec_call);
	common_scripts\utility::array_levelthread(var_06,::maps\_utility_code::exec_call_noself);
}

//Function Number: 524
do_funcs()
{
	var_00 = spawnstruct();
	var_01 = level.run_func_after_wait_array;
	level.run_func_after_wait_array = [];
	foreach(var_03 in var_01)
	{
		level maps\_utility_code::exec_func(var_03,[]);
	}

	var_00 notify("all_funcs_ended");
}

//Function Number: 525
is_default_start()
{
	if(isdefined(level.forced_start_catchup) && level.forced_start_catchup == 1)
	{
		return 0;
	}

	if(isdefined(level.default_start_override) && level.default_start_override == level.start_point)
	{
		return 1;
	}

	if(isdefined(level.default_start))
	{
		return level.start_point == "default";
	}

	if(level_has_start_points())
	{
		return level.start_point == level.start_functions[0]["name"];
	}

	return level.start_point == "default";
}

//Function Number: 526
force_start_catchup()
{
	level.forced_start_catchup = 1;
}

//Function Number: 527
is_first_start()
{
	if(!level_has_start_points())
	{
		return 1;
	}

	return level.start_point == level.start_functions[0]["name"];
}

//Function Number: 528
is_after_start(param_00)
{
	var_01 = 0;
	if(level.start_point == param_00)
	{
		return 0;
	}

	for(var_02 = 0;var_02 < level.start_functions.size;var_02++)
	{
		if(level.start_functions[var_02]["name"] == param_00)
		{
			var_01 = 1;
			continue;
		}

		if(level.start_functions[var_02]["name"] == level.start_point)
		{
			return var_01;
		}
	}
}

//Function Number: 529
_earthquake(param_00,param_01,param_02,param_03)
{
	earthquake(param_00,param_01,param_02,param_03);
}

//Function Number: 530
waterfx(param_00,param_01)
{
	self endon("death");
	var_02 = 0;
	if(isdefined(param_01))
	{
		var_02 = 1;
	}

	if(isdefined(param_00))
	{
		common_scripts\utility::flag_assert(param_00);
		level endon(param_00);
	}

	for(;;)
	{
		wait(randomfloatrange(0.15,0.3));
		var_03 = self.origin + (0,0,150);
		var_04 = self.origin - (0,0,150);
		var_05 = bullettrace(var_03,var_04,0,undefined);
		if(!issubstr(var_05["surfacetype"],"water"))
		{
			continue;
		}

		var_06 = "water_movement";
		if(isplayer(self))
		{
			if(distance(self getvelocity(),(0,0,0)) < 5)
			{
				var_06 = "water_stop";
			}
		}
		else if(isdefined(level._effect["water_" + self.a.movement]))
		{
			var_06 = "water_" + self.a.movement;
		}

		var_07 = common_scripts\utility::getfx(var_06);
		var_03 = var_05["position"];
		var_08 = (0,self.angles[1],0);
		var_09 = anglestoforward(var_08);
		var_0A = anglestoup(var_08);
		playfx(var_07,var_03,var_0A,var_09);
		if(var_06 != "water_stop" && var_02)
		{
			thread common_scripts\utility::play_sound_in_space(param_01,var_03);
		}
	}
}

//Function Number: 531
playersnowfootsteps(param_00)
{
	if(isdefined(param_00))
	{
		common_scripts\utility::flag_assert(param_00);
		level endon(param_00);
	}

	for(;;)
	{
		wait(randomfloatrange(0.25,0.5));
		var_01 = self.origin + (0,0,0);
		var_02 = self.origin - (0,0,5);
		var_03 = bullettrace(var_01,var_02,0,undefined);
		var_04 = anglestoforward(self.angles);
		var_05 = distance(self getvelocity(),(0,0,0));
		if(isdefined(self.vehicle))
		{
			continue;
		}

		if(var_03["surfacetype"] != "snow")
		{
			continue;
		}

		if(var_05 <= 10)
		{
			continue;
		}

		var_06 = "snow_movement";
		if(distance(self getvelocity(),(0,0,0)) <= 154)
		{
			playfx(common_scripts\utility::getfx("footstep_snow_small"),var_03["position"],var_03["normal"],var_04);
		}

		if(distance(self getvelocity(),(0,0,0)) > 154)
		{
			playfx(common_scripts\utility::getfx("footstep_snow"),var_03["position"],var_03["normal"],var_04);
		}
	}
}

//Function Number: 532
mix_up(param_00)
{
	var_01 = 60;
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		self setsoundblend(param_00,param_00 + "_off",var_01 - var_02 / var_01);
		wait(0.05);
	}
}

//Function Number: 533
mix_down(param_00)
{
	var_01 = 60;
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		self setsoundblend(param_00,param_00 + "_off",var_02 / var_01);
		wait(0.05);
	}
}

//Function Number: 534
manual_linkto(param_00,param_01)
{
	param_00 endon("death");
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = (0,0,0);
	}

	for(;;)
	{
		self.origin = param_00.origin + param_01;
		self.angles = param_00.angles;
		wait(0.05);
	}
}

//Function Number: 535
nextmission()
{
	maps\_utility_code::mission_recon();
	maps\_endmission::_nextmission();
}

//Function Number: 536
make_array(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	var_05[var_05.size] = param_00;
	if(isdefined(param_01))
	{
		var_05[var_05.size] = param_01;
	}

	if(isdefined(param_02))
	{
		var_05[var_05.size] = param_02;
	}

	if(isdefined(param_03))
	{
		var_05[var_05.size] = param_03;
	}

	if(isdefined(param_04))
	{
		var_05[var_05.size] = param_04;
	}

	return var_05;
}

//Function Number: 537
fail_on_friendly_fire()
{
	level.failonfriendlyfire = 1;
}

//Function Number: 538
normal_friendly_fire_penalty()
{
	level.failonfriendlyfire = 0;
}

//Function Number: 539
getplayerclaymores()
{
	var_00 = self getweaponslistall();
	var_01 = [];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_03 = var_00[var_02];
		var_01[var_03] = self getweaponammoclip(var_03);
	}

	var_04 = 0;
	if(isdefined(var_01["claymore"]) && var_01["claymore"] > 0)
	{
		var_04 = var_01["claymore"];
	}

	return var_04;
}

//Function Number: 540
_wait(param_00)
{
	wait(param_00);
}

//Function Number: 541
_waittillmatch(param_00,param_01)
{
	self waittillmatch(param_01,param_00);
}

//Function Number: 542
_setsaveddvar(param_00,param_01)
{
	setsaveddvar(param_00,param_01);
}

//Function Number: 543
lerp_saveddvar(param_00,param_01,param_02)
{
	var_03 = getdvarfloat(param_00);
	level notify(param_00 + "_lerp_savedDvar");
	level endon(param_00 + "_lerp_savedDvar");
	var_04 = param_01 - var_03;
	var_05 = 0.05;
	var_06 = int(param_02 / var_05);
	var_07 = var_04 / var_06;
	while(var_06)
	{
		var_03 = var_03 + var_07;
		setsaveddvar(param_00,var_03);
		wait(var_05);
		var_06--;
	}

	setsaveddvar(param_00,param_01);
}

//Function Number: 544
lerp_saveddvar_cg_ng(param_00,param_01,param_02,param_03)
{
	if(is_gen4())
	{
		lerp_saveddvar(param_00,param_02,param_03);
		return;
	}

	lerp_saveddvar(param_00,param_01,param_03);
}

//Function Number: 545
giveachievement_wrapper(param_00)
{
	if(is_demo())
	{
		return;
	}

	foreach(var_02 in level.players)
	{
		var_02 giveachievement(param_00);
	}

	setspmatchdata("achievements_completed",param_00,1);
}

//Function Number: 546
player_giveachievement_wrapper(param_00)
{
	if(is_demo())
	{
		return;
	}

	self giveachievement(param_00);
}

//Function Number: 547
add_jav_glow(param_00)
{
	var_01 = spawn("script_model",(0,0,0));
	var_01 setcontents(0);
	var_01 setmodel("weapon_javelin_obj");
	var_01.origin = self.origin;
	var_01.angles = self.angles;
	add_wait(::delete_on_not_defined);
	if(isdefined(param_00))
	{
		common_scripts\utility::flag_assert(param_00);
		add_wait(::common_scripts\utility::flag_wait,param_00);
	}

	do_wait_any();
	var_01 delete();
}

//Function Number: 548
add_c4_glow(param_00)
{
	var_01 = spawn("script_model",(0,0,0));
	var_01 setcontents(0);
	var_01 setmodel("weapon_c4_obj");
	var_01.origin = self.origin;
	var_01.angles = self.angles;
	add_wait(::delete_on_not_defined);
	if(isdefined(param_00))
	{
		common_scripts\utility::flag_assert(param_00);
		add_wait(::common_scripts\utility::flag_wait,param_00);
	}

	do_wait_any();
	var_01 delete();
}

//Function Number: 549
delete_on_not_defined()
{
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		wait(0.05);
	}
}

//Function Number: 550
slowmo_start()
{
}

//Function Number: 551
slowmo_end()
{
}

//Function Number: 552
slowmo_setspeed_slow(param_00)
{
	level.slowmo.speed_slow = param_00;
}

//Function Number: 553
slowmo_setspeed_norm(param_00)
{
	level.slowmo.speed_norm = param_00;
}

//Function Number: 554
slowmo_setlerptime_in(param_00)
{
	level.slowmo.lerp_time_in = param_00;
}

//Function Number: 555
slowmo_setlerptime_out(param_00)
{
	level.slowmo.lerp_time_out = param_00;
}

//Function Number: 556
slowmo_lerp_in()
{
	if(isdefined(level.no_slowmo) && level.no_slowmo)
	{
		return;
	}

	setslowmotion(level.slowmo.speed_norm,level.slowmo.speed_slow,level.slowmo.lerp_time_in);
}

//Function Number: 557
slowmo_lerp_out()
{
	if(isdefined(level.no_slowmo) && level.no_slowmo)
	{
		return;
	}

	setslowmotion(level.slowmo.speed_slow,level.slowmo.speed_norm,level.slowmo.lerp_time_out);
}

//Function Number: 558
add_earthquake(param_00,param_01,param_02,param_03)
{
	level.earthquake[param_00]["magnitude"] = param_01;
	level.earthquake[param_00]["duration"] = param_02;
	level.earthquake[param_00]["radius"] = param_03;
}

//Function Number: 559
arcademode()
{
	return getdvar("arcademode") == "1";
}

//Function Number: 560
arcademode_stop_timer()
{
	if(!isdefined(level.arcademode_hud_timer))
	{
		return;
	}

	level notify("arcadeMode_remove_timer");
	level.arcademode_stoptime = gettime();
	level.arcademode_hud_timer destroy();
	level.arcademode_hud_timer = undefined;
}

//Function Number: 561
musicplaywrapper(param_00,param_01,param_02)
{
	level._audio.last_song = param_00;
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	musicstop(0);
	musicplay(param_00,0,1,1,param_02);
}

//Function Number: 562
music_loop(param_00,param_01,param_02,param_03,param_04)
{
	thread maps\_utility_code::music_loop_internal(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 563
music_loop_stealth(param_00,param_01,param_02,param_03,param_04)
{
	thread maps\_utility_code::music_loop_internal(param_00,param_01,param_02,param_03,param_04,1);
}

//Function Number: 564
music_play(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01) && param_01 > 0)
	{
		thread maps\_utility_code::music_play_internal_stop_with_fade_then_call(param_00,param_01,param_02,param_03);
		return;
	}

	music_stop();
	musicplaywrapper(param_00,param_02,param_03);
}

//Function Number: 565
music_crossfade(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(isdefined(level._audio.last_song))
	{
		musicstop(param_01,level._audio.last_song,param_03);
	}
	else
	{
		iprintln("^3WARNING!  script music_crossfade(): No previous song was played - no previous song to crossfade from - not fading out anything");
	}

	level._audio.last_song = param_00;
	musicplay(param_00,param_01,param_02,0,param_03);
	level endon("stop_music");
	wait(param_01);
	level notify("done_crossfading");
}

//Function Number: 566
music_stop(param_00)
{
	if(!isdefined(param_00) || param_00 <= 0)
	{
		musicstop();
	}
	else
	{
		musicstop(param_00);
	}

	level notify("stop_music");
}

//Function Number: 567
player_is_near_live_grenade()
{
	var_00 = getentarray("grenade","classname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		if(var_02.model == "weapon_claymore")
		{
			continue;
		}

		for(var_03 = 0;var_03 < level.players.size;var_03++)
		{
			var_04 = level.players[var_03];
			if(distancesquared(var_02.origin,var_04.origin) < 75625)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 568
player_died_recently()
{
	return getdvarint("player_died_recently","0") > 0;
}

//Function Number: 569
all_players_istouching(param_00)
{
	foreach(var_02 in level.players)
	{
		if(!var_02 istouching(param_00))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 570
any_players_istouching(param_00)
{
	foreach(var_02 in level.players)
	{
		if(var_02 istouching(param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 571
getdifficulty()
{
	if(level.gameskill < 1)
	{
		return "easy";
	}

	if(level.gameskill < 2)
	{
		return "medium";
	}

	if(level.gameskill < 3)
	{
		return "hard";
	}

	return "fu";
}

//Function Number: 572
getaverageplayerorigin()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	foreach(var_04 in level.players)
	{
		var_00 = var_00 + var_04.origin[0];
		var_01 = var_01 + var_04.origin[1];
		var_02 = var_02 + var_04.origin[2];
	}

	var_00 = var_00 / level.players.size;
	var_01 = var_01 / level.players.size;
	var_02 = var_02 / level.players.size;
	return (var_00,var_01,var_02);
}

//Function Number: 573
get_average_origin(param_00)
{
	var_01 = (0,0,0);
	foreach(var_03 in param_00)
	{
		var_01 = var_01 + var_03.origin;
	}

	return var_01 * 1 / param_00.size;
}

//Function Number: 574
generic_damage_think()
{
	self.damage_functions = [];
	self endon("entitydeleted");
	self endon("stop_generic_damage_think");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06);
		foreach(var_08 in self.damage_functions)
		{
			thread [[ var_08 ]](var_00,var_01,var_02,var_03,var_04,var_05,var_06);
		}
	}
}

//Function Number: 575
add_damage_function(param_00)
{
	self.damage_functions[self.damage_functions.size] = param_00;
}

//Function Number: 576
remove_damage_function(param_00)
{
	var_01 = [];
	foreach(var_03 in self.damage_functions)
	{
		if(var_03 == param_00)
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	self.damage_functions = var_01;
}

//Function Number: 577
givexp(param_00,param_01)
{
	if(isdefined(level.xp_enable) && level.xp_enable && isdefined(level.xp_give_func))
	{
		self [[ level.xp_give_func ]](param_00,param_01);
	}
}

//Function Number: 578
playlocalsoundwrapper(param_00)
{
	self playlocalsound(param_00);
}

//Function Number: 579
enableplayerweapons(param_00)
{
	if(level.players.size < 1)
	{
		return;
	}

	foreach(var_02 in level.players)
	{
		if(param_00 == 1)
		{
			var_02 enableweapons();
			continue;
		}

		var_02 disableweapons();
	}
}

//Function Number: 580
teleport_players(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_05 in param_00)
	{
		if(isdefined(var_05.script_noteworthy) && var_05.script_noteworthy == "player1")
		{
			var_01 = var_05;
			continue;
		}

		if(isdefined(var_05.script_noteworthy) && var_05.script_noteworthy == "player2")
		{
			var_02 = var_05;
			continue;
		}

		if(!isdefined(var_01))
		{
			var_01 = var_05;
		}

		if(!isdefined(var_02))
		{
			var_02 = var_05;
		}
	}

	foreach(var_08 in level.players)
	{
		if(var_08 == level.player)
		{
			var_03 = var_01;
		}
		else if(var_08 == level.player2)
		{
			var_03 = var_02;
		}

		var_08 setorigin(var_03.origin);
		var_08 setplayerangles(var_03.angles);
	}
}

//Function Number: 581
teleport_player(param_00)
{
	level.player setorigin(param_00.origin);
	if(isdefined(param_00.angles))
	{
		level.player setplayerangles(param_00.angles);
	}
}

//Function Number: 582
translate_local()
{
	var_00 = [];
	if(isdefined(self.entities))
	{
		var_00 = self.entities;
	}

	if(isdefined(self.entity))
	{
		var_00[var_00.size] = self.entity;
	}

	common_scripts\utility::array_levelthread(var_00,::maps\_utility_code::translate_local_on_ent);
}

//Function Number: 583
open_up_fov(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	level.player endon("stop_opening_fov");
	wait(param_00);
	level.player playerlinktodelta(param_01,param_02,1,param_03,param_04,param_05,param_06,1);
}

//Function Number: 584
get_ai_touching_volume(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	if(!isdefined(param_01))
	{
		param_01 = "all";
	}

	var_03 = getaispeciesarray(param_00,param_01);
	var_04 = [];
	foreach(var_06 in var_03)
	{
		if(var_06 istouching(self))
		{
			var_04[var_04.size] = var_06;
		}
	}

	return var_04;
}

//Function Number: 585
get_drones_touching_volume(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	var_01 = [];
	if(param_00 == "all")
	{
		var_01 = array_merge(level.drones["allies"].array,level.drones["axis"].array);
		var_01 = array_merge(var_01,level.drones["neutral"].array);
	}
	else
	{
		var_01 = level.drones[param_00].array;
	}

	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(!isdefined(var_04))
		{
			continue;
		}

		if(var_04 istouching(self))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 586
get_drones_with_targetname(param_00)
{
	var_01 = array_merge(level.drones["allies"].array,level.drones["axis"].array);
	var_01 = array_merge(var_01,level.drones["neutral"].array);
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(!isdefined(var_04))
		{
			continue;
		}

		if(isdefined(var_04.targetname) && var_04.targetname == param_00)
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 587
get_other_player(param_00)
{
	foreach(var_02 in level.players)
	{
		if(param_00 == var_02)
		{
			continue;
		}

		return var_02;
	}
}

//Function Number: 588
set_count(param_00)
{
	self.count = param_00;
}

//Function Number: 589
follow_path(param_00,param_01,param_02,param_03)
{
	self notify("_utility::follow_path");
	self endon("_utility::follow_path");
	self endon("death");
	var_04 = undefined;
	if(!isdefined(param_00.classname))
	{
		if(!isdefined(param_00.type))
		{
			var_04 = "struct";
		}
		else
		{
			var_04 = "node";
		}
	}
	else
	{
		var_04 = "entity";
	}

	if(!isdefined(param_01))
	{
		param_01 = 300;
	}

	var_05 = self.script_forcegoal;
	self.script_forcegoal = 1;
	maps\_spawner::go_to_node(param_00,var_04,param_02,param_01,param_03);
	self.script_forcegoal = var_05;
}

//Function Number: 590
enable_dynamic_run_speed(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_00))
	{
		param_00 = 250;
	}

	if(!isdefined(param_01))
	{
		param_01 = 100;
	}

	if(!isdefined(param_02))
	{
		param_02 = param_00 * 2;
	}

	if(!isdefined(param_03))
	{
		param_03 = param_00 * 1.25;
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	self.dontchangemoveplaybackrate = param_05;
	thread maps\_utility_code::dynamic_run_speed_proc(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 591
disable_dynamic_run_speed()
{
	self notify("stop_dynamic_run_speed");
}

//Function Number: 592
player_seek_enable()
{
	self endon("death");
	self endon("stop_player_seek");
	var_00 = 1200;
	if(has_shotgun())
	{
		var_00 = 250;
	}

	var_01 = distance(self.origin,level.player.origin);
	for(;;)
	{
		wait(2);
		self.goalradius = var_01;
		var_02 = get_closest_player(self.origin);
		self setgoalentity(var_02);
		var_01 = var_01 - 175;
		if(var_01 < var_00)
		{
			var_01 = var_00;
			return;
		}
	}
}

//Function Number: 593
player_seek_disable()
{
	self notify("stop_player_seek");
}

//Function Number: 594
waittill_entity_in_range_or_timeout(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	if(!isdefined(param_02))
	{
		param_02 = 5;
	}

	var_03 = gettime() + param_02 * 1000;
	while(isdefined(param_00))
	{
		if(distance(param_00.origin,self.origin) <= param_01)
		{
			break;
		}

		if(gettime() > var_03)
		{
			break;
		}

		wait(0.1);
	}
}

//Function Number: 595
waittill_entity_in_range(param_00,param_01)
{
	self endon("death");
	param_00 endon("death");
	while(isdefined(param_00))
	{
		if(distance(param_00.origin,self.origin) <= param_01)
		{
			break;
		}

		wait(0.1);
	}
}

//Function Number: 596
waittill_entity_out_of_range(param_00,param_01)
{
	self endon("death");
	param_00 endon("death");
	while(isdefined(param_00))
	{
		if(distance(param_00.origin,self.origin) > param_01)
		{
			break;
		}

		wait(0.1);
	}
}

//Function Number: 597
has_shotgun()
{
	self endon("death");
	if(!isdefined(self.weapon))
	{
		return 0;
	}

	if(weaponclass(self.weapon) == "spread")
	{
		return 1;
	}

	return 0;
}

//Function Number: 598
isprimaryweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(weaponinventorytype(param_00) != "primary")
	{
		return 0;
	}

	switch(weaponclass(param_00))
	{
		case "rifle":
		case "sniper":
		case "smg":
		case "spread":
		case "rocketlauncher":
		case "pistol":
		case "mg":
			break;

		default:
			break;
	}
}

//Function Number: 599
player_has_thermal()
{
	var_00 = self getweaponslistall();
	if(!isdefined(var_00))
	{
		return 0;
	}

	foreach(var_02 in var_00)
	{
		if(issubstr(var_02,"thermal"))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 600
waittill_true_goal(param_00,param_01)
{
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = self.goalradius;
	}

	for(;;)
	{
		self waittill("goal");
		if(distance(self.origin,param_00) < param_01 + 10)
		{
			break;
		}
	}
}

//Function Number: 601
player_speed_percent(param_00,param_01)
{
	var_02 = int(getdvar("g_speed"));
	if(!isdefined(level.player.g_speed))
	{
		level.player.g_speed = var_02;
	}

	var_03 = int(level.player.g_speed * param_00 * 0.01);
	level.player player_speed_set(var_03,param_01);
}

//Function Number: 602
blend_movespeedscale_percent(param_00,param_01)
{
	var_02 = self;
	if(!isplayer(var_02))
	{
		var_02 = level.player;
	}

	if(!isdefined(var_02.movespeedscale))
	{
		var_02.movespeedscale = 1;
	}

	var_03 = param_00 * 0.01;
	var_02 blend_movespeedscale(var_03,param_01);
}

//Function Number: 603
player_speed_set(param_00,param_01)
{
	var_02 = int(getdvar("g_speed"));
	if(!isdefined(level.player.g_speed))
	{
		level.player.g_speed = var_02;
	}

	var_03 = ::maps\_utility_code::g_speed_get_func;
	var_04 = ::maps\_utility_code::g_speed_set_func;
	level.player thread player_speed_proc(param_00,param_01,var_03,var_04,"player_speed_set");
}

//Function Number: 604
player_bob_scale_set(param_00,param_01)
{
	var_02 = ::maps\_utility_code::g_bob_scale_get_func;
	var_03 = ::maps\_utility_code::g_bob_scale_set_func;
	level.player thread player_speed_proc(param_00,param_01,var_02,var_03,"player_bob_scale_set");
}

//Function Number: 605
blend_movespeedscale(param_00,param_01)
{
	var_02 = self;
	if(!isplayer(var_02))
	{
		var_02 = level.player;
	}

	if(!isdefined(var_02.movespeedscale))
	{
		var_02.movespeedscale = 1;
	}

	var_03 = ::maps\_utility_code::movespeed_get_func;
	var_04 = ::maps\_utility_code::movespeed_set_func;
	var_02 thread player_speed_proc(param_00,param_01,var_03,var_04,"blend_movespeedscale");
}

//Function Number: 606
player_speed_proc(param_00,param_01,param_02,param_03,param_04)
{
	self notify(param_04);
	self endon(param_04);
	var_05 = [[ param_02 ]]();
	var_06 = param_00;
	if(isdefined(param_01))
	{
		var_07 = var_06 - var_05;
		var_08 = 0.05;
		var_09 = param_01 / var_08;
		var_0A = var_07 / var_09;
		while(abs(var_06 - var_05) > abs(var_0A * 1.1))
		{
			var_05 = var_05 + var_0A;
			[[ param_03 ]](var_05);
			wait(var_08);
		}
	}

	[[ param_03 ]](var_06);
}

//Function Number: 607
player_speed_default(param_00)
{
	if(!isdefined(level.player.g_speed))
	{
		return;
	}

	level.player player_speed_set(level.player.g_speed,param_00);
	waittillframeend;
	level.player.g_speed = undefined;
}

//Function Number: 608
blend_movespeedscale_default(param_00)
{
	var_01 = self;
	if(!isplayer(var_01))
	{
		var_01 = level.player;
	}

	if(!isdefined(var_01.movespeedscale))
	{
		return;
	}

	var_01 blend_movespeedscale(1,param_00);
	waittillframeend;
	var_01.movespeedscale = undefined;
}

//Function Number: 609
teleport_ent(param_00)
{
	if(isplayer(self))
	{
		self setorigin(param_00.origin);
		self setplayerangles(param_00.angles);
		return;
	}

	self forceteleport(param_00.origin,param_00.angles);
}

//Function Number: 610
teleport_to_ent_tag(param_00,param_01)
{
	var_02 = param_00 gettagorigin(param_01);
	var_03 = param_00 gettagangles(param_01);
	self dontinterpolate();
	if(isplayer(self))
	{
		self setorigin(var_02);
		self setplayerangles(var_03);
		return;
	}

	if(isai(self))
	{
		self forceteleport(var_02,var_03);
		return;
	}

	self.origin = var_02;
	self.angles = var_03;
}

//Function Number: 611
teleport_ai(param_00)
{
	self forceteleport(param_00.origin,param_00.angles);
	self setgoalpos(self.origin);
	self setgoalnode(param_00);
}

//Function Number: 612
move_all_fx(param_00)
{
	foreach(var_02 in level.createfxent)
	{
		var_02.v["origin"] = var_02.v["origin"] + param_00;
	}
}

//Function Number: 613
issliding()
{
	return isdefined(self.slidemodel);
}

//Function Number: 614
beginsliding(param_00,param_01,param_02)
{
	var_03 = self;
	var_03 thread play_sound_on_entity("foot_slide_plr_start");
	if(soundexists("foot_slide_plr_loop"))
	{
		var_03 thread play_loop_sound_on_tag("foot_slide_plr_loop");
	}

	var_04 = isdefined(level.custom_linkto_slide);
	if(!isdefined(param_00))
	{
		param_00 = var_03 getvelocity() + (0,0,-10);
	}

	if(!isdefined(param_01))
	{
		param_01 = 10;
	}

	if(!isdefined(param_02))
	{
		if(isdefined(level.slide_dampening))
		{
			param_02 = level.slide_dampening;
		}
		else
		{
			param_02 = 0.035;
		}
	}

	var_05 = spawn("script_origin",var_03.origin);
	var_05.angles = var_03.angles;
	var_03.slidemodel = var_05;
	var_05 moveslide((0,0,15),15,param_00);
	if(var_04)
	{
		var_03 playerlinktoblend(var_05,undefined,1);
	}
	else
	{
		var_03 playerlinkto(var_05);
	}

	var_03 disableweapons();
	var_03 allowprone(0);
	var_03 allowcrouch(1);
	var_03 allowstand(0);
	var_03 thread maps\_utility_code::doslide(var_05,param_01,param_02);
}

//Function Number: 615
endsliding()
{
	var_00 = self;
	var_00 notify("stop soundfoot_slide_plr_loop");
	var_00 thread play_sound_on_entity("foot_slide_plr_end");
	var_00 unlink();
	var_00 setvelocity(var_00.slidemodel.slidevelocity);
	var_00.slidemodel delete();
	var_00 enableweapons();
	var_00 allowprone(1);
	var_00 allowcrouch(1);
	var_00 allowstand(1);
	var_00 notify("stop_sliding");
}

//Function Number: 616
spawn_vehicle()
{
	return maps\_vehicle::vehicle_spawn(self);
}

//Function Number: 617
getentwithflag(param_00)
{
	var_01 = maps\_trigger::get_load_trigger_classes();
	var_02 = [];
	foreach(var_06, var_04 in var_01)
	{
		if(!issubstr(var_06,"flag"))
		{
			continue;
		}

		var_05 = getentarray(var_06,"classname");
		var_02 = common_scripts\utility::array_combine(var_02,var_05);
	}

	var_07 = maps\_trigger::get_load_trigger_funcs();
	foreach(var_09, var_04 in var_07)
	{
		if(!issubstr(var_09,"flag"))
		{
			continue;
		}

		var_05 = getentarray(var_09,"targetname");
		var_02 = common_scripts\utility::array_combine(var_02,var_05);
	}

	var_0A = undefined;
	foreach(var_0C in var_02)
	{
		if(var_0C.script_flag == param_00)
		{
			return var_0C;
		}
	}
}

//Function Number: 618
getentarraywithflag(param_00)
{
	var_01 = maps\_trigger::get_load_trigger_classes();
	var_02 = [];
	foreach(var_06, var_04 in var_01)
	{
		if(!issubstr(var_06,"flag"))
		{
			continue;
		}

		var_05 = getentarray(var_06,"classname");
		var_02 = common_scripts\utility::array_combine(var_02,var_05);
	}

	var_07 = maps\_trigger::get_load_trigger_funcs();
	foreach(var_09, var_04 in var_07)
	{
		if(!issubstr(var_09,"flag"))
		{
			continue;
		}

		var_05 = getentarray(var_09,"targetname");
		var_02 = common_scripts\utility::array_combine(var_02,var_05);
	}

	var_0A = [];
	foreach(var_0C in var_02)
	{
		if(var_0C.script_flag == param_00)
		{
			var_0A[var_0A.size] = var_0C;
		}
	}

	return var_0A;
}

//Function Number: 619
set_z(param_00,param_01)
{
	return (param_00[0],param_00[1],param_01);
}

//Function Number: 620
add_z(param_00,param_01)
{
	return (param_00[0],param_00[1],param_00[2] + param_01);
}

//Function Number: 621
set_y(param_00,param_01)
{
	return (param_00[0],param_01,param_00[2]);
}

//Function Number: 622
set_x(param_00,param_01)
{
	return (param_01,param_00[1],param_00[2]);
}

//Function Number: 623
player_using_missile()
{
	var_00 = self getcurrentweapon();
	if(!isdefined(var_00))
	{
		return 0;
	}

	if(issubstr(tolower(var_00),"rpg"))
	{
		return 1;
	}

	if(issubstr(tolower(var_00),"stinger"))
	{
		return 1;
	}

	if(issubstr(tolower(var_00),"at4"))
	{
		return 1;
	}

	if(issubstr(tolower(var_00),"javelin"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 624
doinglongdeath()
{
	return isdefined(self.a.doinglongdeath);
}

//Function Number: 625
get_rumble_ent(param_00,param_01)
{
	if(is_coop())
	{
	}

	var_02 = get_player_from_self();
	if(!isdefined(param_00))
	{
		param_00 = "steady_rumble";
	}

	var_03 = spawn("script_origin",var_02 geteye());
	if(!isdefined(param_01) || !isnumber(param_01))
	{
		var_03.intensity = 1;
	}
	else
	{
		var_03.intensity = param_01;
	}

	var_03 thread maps\_utility_code::update_rumble_intensity(var_02,param_00);
	return var_03;
}

//Function Number: 626
set_rumble_intensity(param_00)
{
	self.intensity = param_00;
}

//Function Number: 627
rumble_ramp_on(param_00)
{
	thread rumble_ramp_to(1,param_00);
}

//Function Number: 628
rumble_ramp_off(param_00)
{
	thread rumble_ramp_to(0,param_00);
}

//Function Number: 629
rumble_ramp_to(param_00,param_01)
{
	self notify("new_ramp");
	self endon("new_ramp");
	self endon("death");
	var_02 = param_01 * 20;
	var_03 = param_00 - self.intensity;
	var_04 = var_03 / var_02;
	for(var_05 = 0;var_05 < var_02;var_05++)
	{
		self.intensity = self.intensity + var_04;
		wait(0.05);
	}

	self.intensity = param_00;
}

//Function Number: 630
get_player_from_self()
{
	if(isdefined(self))
	{
		if(!is_in_array(level.players,self))
		{
			return level.player;
		}

		return self;
	}

	return level.player;
}

//Function Number: 631
get_player_gameskill()
{
	return int(self getplayersetting("gameskill"));
}

//Function Number: 632
glow(param_00)
{
	if(isdefined(self.non_glow_model))
	{
		return;
	}

	self.non_glow_model = self.model;
	if(!isdefined(param_00))
	{
		param_00 = self.model + "_obj";
	}

	self setmodel(param_00);
}

//Function Number: 633
stopglow(param_00)
{
	if(!isdefined(self.non_glow_model))
	{
		return;
	}

	self setmodel(self.non_glow_model);
	self.non_glow_model = undefined;
}

//Function Number: 634
array_delete_evenly(param_00,param_01,param_02)
{
	var_03 = [];
	param_01 = param_02 - param_01;
	foreach(var_05 in param_00)
	{
		var_03[var_03.size] = var_05;
		if(var_03.size == param_02)
		{
			var_03 = common_scripts\utility::array_randomize(var_03);
			for(var_06 = param_01;var_06 < var_03.size;var_06++)
			{
				var_03[var_06] delete();
			}

			var_03 = [];
		}
	}

	var_08 = [];
	foreach(var_05 in param_00)
	{
		if(!isdefined(var_05))
		{
			continue;
		}

		var_08[var_08.size] = var_05;
	}

	return var_08;
}

//Function Number: 635
waittill_in_range(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0.5;
	}

	self endon("death");
	while(isdefined(self))
	{
		if(distance(param_00,self.origin) <= param_01)
		{
			break;
		}

		wait(param_02);
	}
}

//Function Number: 636
add_trace_fx(param_00)
{
	var_01 = spawnstruct();
	var_01 thread maps\_utility_code::add_trace_fx_proc(param_00);
	return var_01;
}

//Function Number: 637
tracefx_on_tag(param_00,param_01,param_02)
{
	var_03 = self gettagorigin(param_01);
	var_04 = self gettagangles(param_01);
	tracefx(param_00,var_03,var_04,param_02);
}

//Function Number: 638
tracefx(param_00,param_01,param_02,param_03)
{
	var_04 = anglestoforward(param_02);
	var_05 = bullettrace(param_01,param_01 + var_04 * param_03,0,undefined);
	if(var_05["fraction"] >= 1)
	{
		return;
	}

	var_06 = var_05["surfacetype"];
	if(!isdefined(level.trace_fx[param_00][var_06]))
	{
		var_06 = "default";
	}

	var_07 = level.trace_fx[param_00][var_06];
	if(isdefined(var_07["fx"]))
	{
		playfx(var_07["fx"],var_05["position"],var_05["normal"]);
	}

	if(isdefined(var_07["fx_array"]))
	{
		foreach(var_09 in var_07["fx_array"])
		{
			playfx(var_09,var_05["position"],var_05["normal"]);
		}
	}

	if(isdefined(var_07["sound"]))
	{
		level thread common_scripts\utility::play_sound_in_space(var_07["sound"],var_05["position"]);
	}

	if(isdefined(var_07["rumble"]))
	{
		var_0B = get_player_from_self();
		var_0B playrumbleonentity(var_07["rumble"]);
	}
}

//Function Number: 639
disable_surprise()
{
	self.newenemyreactiondistsq = 0;
}

//Function Number: 640
enable_surprise()
{
	self.newenemyreactiondistsq = squared(512);
}

//Function Number: 641
enable_heat_behavior(param_00)
{
	self.heat = 1;
	self.no_pistol_switch = 1;
	self.usecombatscriptatcover = 1;
	if(!isdefined(param_00) || !param_00)
	{
		self.dontshootwhilemoving = 1;
		self.maxfaceenemydist = 64;
		self.pathenemylookahead = 2048;
		disable_surprise();
	}

	self.specialreloadanimfunc = ::animscripts\animset::heat_reload_anim;
	self.custommoveanimset["run"] = animscripts\utility::lookupanimarray("heat_run");
}

//Function Number: 642
disable_heat_behavior()
{
	self.heat = undefined;
	self.no_pistol_switch = undefined;
	self.dontshootwhilemoving = undefined;
	self.usecombatscriptatcover = 0;
	self.maxfaceenemydist = 512;
	self.specialreloadanimfunc = undefined;
	self.custommoveanimset = undefined;
}

//Function Number: 643
getvehiclearray()
{
	return vehicle_getarray();
}

//Function Number: 644
hint(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = 0.5;
	level endon("clearing_hints");
	if(isdefined(level.hintelement))
	{
		level.hintelement maps\_hud_util::destroyelem();
	}

	level.hintelement = maps\_hud_util::createfontstring("default",1.5);
	level.hintelement maps\_hud_util::setpoint("MIDDLE",undefined,0,30 + param_02);
	level.hintelement.color = (1,1,1);
	level.hintelement settext(param_00);
	level.hintelement.alpha = 0;
	level.hintelement fadeovertime(0.5);
	level.hintelement.alpha = 1;
	wait(0.5);
	level.hintelement endon("death");
	if(isdefined(param_01))
	{
		wait(param_01);
	}
	else
	{
		return;
	}

	level.hintelement fadeovertime(var_03);
	level.hintelement.alpha = 0;
	wait(var_03);
	level.hintelement maps\_hud_util::destroyelem();
}

//Function Number: 645
hint_fade()
{
	var_00 = 1;
	if(isdefined(level.hintelement))
	{
		level notify("clearing_hints");
		level.hintelement fadeovertime(var_00);
		level.hintelement.alpha = 0;
		wait(var_00);
	}
}

//Function Number: 646
kill_deathflag(param_00,param_01,param_02)
{
	if(!isdefined(level.flag[param_00]))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	foreach(var_04 in level.deathflags[param_00])
	{
		foreach(var_06 in var_04)
		{
			if(isalive(var_06))
			{
				var_06 thread maps\_utility_code::kill_deathflag_proc(param_01,param_02);
				continue;
			}

			var_06 delete();
		}
	}
}

//Function Number: 647
get_player_view_controller(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = "player_view_controller";
	}

	if(!isdefined(param_02))
	{
		param_02 = (0,0,0);
	}

	var_04 = param_00 gettagorigin(param_01);
	var_05 = spawnturret("misc_turret",var_04,param_03);
	var_05.angles = param_00 gettagangles(param_01);
	var_05 setmodel("tag_turret");
	var_05 linkto(param_00,param_01,param_02,(0,0,0));
	var_05 makeunusable();
	var_05 hide();
	var_05 setmode("manual");
	return var_05;
}

//Function Number: 648
create_blend(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04 childthread maps\_utility_code::process_blend(param_00,self,param_01,param_02,param_03);
	return var_04;
}

//Function Number: 649
set_unstorable_weapon(param_00,param_01)
{
	if(isdefined(self.unstorable_weapons))
	{
		self.unstorable_weapons = [];
	}

	if(!isdefined(param_01) || param_01)
	{
		self.unstorable_weapons[param_00] = 1;
		return;
	}

	self.unstorable_weapons[param_00] = undefined;
}

//Function Number: 650
is_unstorable_weapon(param_00)
{
	if(!isdefined(self.unstorable_weapons))
	{
		return 0;
	}

	return isdefined(self.unstorable_weapons[param_00]);
}

//Function Number: 651
store_players_weapons(param_00)
{
	if(!isdefined(self.stored_weapons))
	{
		self.stored_weapons = [];
	}

	if(!isdefined(self.unstorable_weapons))
	{
		self.unstorable_weapons = [];
	}

	var_01 = [];
	var_02 = self getweaponslistall();
	var_03 = self getcurrentweapon();
	foreach(var_05 in var_02)
	{
		if(isdefined(self.unstorable_weapons[var_05]))
		{
			continue;
		}

		var_01[var_05] = [];
		var_01[var_05]["clip_left"] = self getweaponammoclip(var_05,"left");
		var_01[var_05]["clip_right"] = self getweaponammoclip(var_05,"right");
		var_01[var_05]["stock"] = self setweaponammostock(var_05);
	}

	if(!isdefined(param_00))
	{
		param_00 = "default";
	}

	self.stored_weapons[param_00] = [];
	if(isdefined(self.unstorable_weapons[var_03]))
	{
		var_07 = self getweaponslistprimaries();
		foreach(var_05 in var_07)
		{
			if(!isdefined(self.unstorable_weapons[var_05]))
			{
				var_03 = var_05;
				break;
			}
		}
	}

	self.stored_weapons[param_00]["current_weapon"] = var_03;
	self.stored_weapons[param_00]["inventory"] = var_01;
}

//Function Number: 652
restore_players_weapons(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "default";
	}

	if(!isdefined(self.stored_weapons) || !isdefined(self.stored_weapons[param_00]))
	{
		return;
	}

	self takeallweapons();
	foreach(var_03, var_02 in self.stored_weapons[param_00]["inventory"])
	{
		if(weaponinventorytype(var_03) != "altmode")
		{
			self giveweapon(var_03);
		}

		self setweaponammoclip(var_03,var_02["clip_left"],"left");
		self setweaponammoclip(var_03,var_02["clip_right"],"right");
		self setweaponammostock(var_03,var_02["stock"]);
	}

	var_04 = self.stored_weapons[param_00]["current_weapon"];
	if(var_04 != "none")
	{
		self switchtoweapon(var_04);
	}
}

//Function Number: 653
get_storable_weapons_list_all()
{
	var_00 = self getweaponslistall();
	if(isdefined(self.unstorable_weapons))
	{
		foreach(var_02 in var_00)
		{
			if(isdefined(self.unstorable_weapons[var_02]))
			{
				var_00 = common_scripts\utility::array_remove(var_00,var_02);
			}
		}
	}

	return var_00;
}

//Function Number: 654
get_storable_weapons_list_primaries()
{
	var_00 = self getweaponslistprimaries();
	if(isdefined(self.unstorable_weapons))
	{
		foreach(var_02 in var_00)
		{
			if(isdefined(self.unstorable_weapons[var_02]))
			{
				var_00 = common_scripts\utility::array_remove(var_00,var_02);
			}
		}
	}

	return var_00;
}

//Function Number: 655
get_storable_current_weapon_primary()
{
	var_00 = self getcurrentprimaryweapon();
	if(isdefined(self.unstorable_weapons) && isdefined(self.unstorable_weapons[var_00]))
	{
		var_00 = get_first_storable_weapon();
	}

	return var_00;
}

//Function Number: 656
get_storable_current_weapon()
{
	var_00 = self getcurrentweapon();
	if(isdefined(self.unstorable_weapons) && isdefined(self.unstorable_weapons[var_00]))
	{
		var_00 = get_first_storable_weapon();
	}

	return var_00;
}

//Function Number: 657
get_first_storable_weapon()
{
	var_00 = get_storable_weapons_list_primaries();
	if(var_00.size > 0)
	{
		var_01 = var_00[0];
	}
	else
	{
		var_01 = "none";
	}

	return var_01;
}

//Function Number: 658
hide_entity()
{
	switch(self.code_classname)
	{
		case "light_spot":
		case "script_vehicle":
		case "script_model":
			break;

		case "script_brushmodel":
			break;

		case "trigger_multiple_flag_looking":
		case "trigger_multiple_flag_lookat":
		case "trigger_multiple_breachIcon":
		case "trigger_multiple_flag_set":
		case "trigger_use_touch":
		case "trigger_use":
		case "trigger_multiple":
		case "trigger_radius":
			break;

		default:
			break;
	}
}

//Function Number: 659
show_entity()
{
	switch(self.code_classname)
	{
		case "light_spot":
		case "script_vehicle":
		case "script_model":
			break;

		case "script_brushmodel":
			break;

		case "trigger_multiple_flag_looking":
		case "trigger_multiple_flag_lookat":
		case "trigger_multiple_breachIcon":
		case "trigger_multiple_flag_set":
		case "trigger_use_touch":
		case "trigger_use":
		case "trigger_multiple":
		case "trigger_radius":
			break;

		default:
			break;
	}
}

//Function Number: 660
_rotateyaw(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		self rotateyaw(param_00,param_01,param_02,param_03);
		return;
	}

	if(isdefined(param_02))
	{
		self rotateyaw(param_00,param_01,param_02);
		return;
	}

	self rotateyaw(param_00,param_01);
}

//Function Number: 661
set_moveplaybackrate(param_00,param_01,param_02)
{
	self notify("set_moveplaybackrate");
	self endon("set_moveplaybackrate");
	if(isdefined(param_02) && param_02)
	{
		thread set_movetransitionrate(param_00,param_01);
	}

	if(!isdefined(self.moveplaybackrate_orig))
	{
		self.moveplaybackrate_orig = self.moveplaybackrate;
	}

	if(isdefined(param_01))
	{
		var_03 = param_00 - self.moveplaybackrate;
		var_04 = 0.05;
		var_05 = param_01 / var_04;
		var_06 = var_03 / var_05;
		while(abs(param_00 - self.moveplaybackrate) > abs(var_06 * 1.1))
		{
			self.moveplaybackrate = self.moveplaybackrate + var_06;
			wait(var_04);
		}
	}

	self.moveplaybackrate = param_00;
}

//Function Number: 662
restore_moveplaybackrate(param_00,param_01)
{
	self notify("set_moveplaybackrate");
	self endon("set_moveplaybackrate");
	if(isdefined(param_01) && param_01)
	{
		thread restore_movetransitionrate(param_00);
	}

	set_moveplaybackrate(self.moveplaybackrate_orig,param_00,0);
	self.moveplaybackrate_orig = undefined;
}

//Function Number: 663
set_movetransitionrate(param_00,param_01)
{
	self notify("set_moveplaybackrate");
	self endon("set_moveplaybackrate");
	if(!isdefined(self.movetransitionrate_orig))
	{
		self.movetransitionrate_orig = self.movetransitionrate;
	}

	if(isdefined(param_01))
	{
		var_02 = param_00 - self.movetransitionrate;
		var_03 = 0.05;
		var_04 = param_01 / var_03;
		var_05 = var_02 / var_04;
		while(abs(param_00 - self.movetransitionrate) > abs(var_05 * 1.1))
		{
			self.movetransitionrate = self.movetransitionrate + var_05;
			wait(var_03);
		}
	}

	self.movetransitionrate = param_00;
}

//Function Number: 664
restore_movetransitionrate(param_00)
{
	self notify("set_moveplaybackrate");
	self endon("set_moveplaybackrate");
	set_movetransitionrate(self.movetransitionrate_orig,param_00);
	self.movetransitionrate_orig = undefined;
}

//Function Number: 665
array_spawn_function(param_00,param_01,param_02,param_03,param_04,param_05)
{
	foreach(var_07 in param_00)
	{
		var_07 thread add_spawn_function(param_01,param_02,param_03,param_04,param_05);
	}
}

//Function Number: 666
array_spawn_function_targetname(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = getentarray(param_00,"targetname");
	array_spawn_function(var_06,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 667
array_spawn_function_noteworthy(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = getentarray(param_00,"script_noteworthy");
	array_spawn_function(var_06,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 668
enable_dontevershoot()
{
	self.dontevershoot = 1;
}

//Function Number: 669
disable_dontevershoot()
{
	self.dontevershoot = undefined;
}

//Function Number: 670
create_sunflare_setting(param_00)
{
	if(!isdefined(level.sunflare_settings))
	{
		level.sunflare_settings = [];
	}

	var_01 = spawnstruct();
	var_01.name = param_00;
	level.sunflare_settings[param_00] = var_01;
	return var_01;
}

//Function Number: 671
create_vision_set_fog(param_00)
{
	if(!isdefined(level.vision_set_fog))
	{
		level.vision_set_fog = [];
	}

	var_01 = spawnstruct();
	var_01.name = param_00;
	var_01.skyfogintensity = 0;
	var_01.skyfogminangle = 0;
	var_01.skyfogmaxangle = 0;
	var_01.heightfogenabled = 0;
	var_01.heightfogbaseheight = 0;
	var_01.heightfoghalfplanedistance = 1000;
	level.vision_set_fog[tolower(param_00)] = var_01;
	return var_01;
}

//Function Number: 672
get_vision_set_fog(param_00)
{
	if(!isdefined(level.vision_set_fog))
	{
		level.vision_set_fog = [];
	}

	var_01 = level.vision_set_fog[tolower(param_00)];
	if(using_hdr_fog() && isdefined(var_01) && isdefined(var_01.hdroverride))
	{
		var_01 = level.vision_set_fog[tolower(var_01.hdroverride)];
	}

	return var_01;
}

//Function Number: 673
create_fog(param_00)
{
	if(!isdefined(level.fog_set))
	{
		level.fog_set = [];
	}

	var_01 = spawnstruct();
	var_01.name = param_00;
	level.fog_set[tolower(param_00)] = var_01;
	return var_01;
}

//Function Number: 674
get_fog(param_00)
{
	if(!isdefined(level.fog_set))
	{
		level.fog_set = [];
	}

	var_01 = level.fog_set[tolower(param_00)];
	return var_01;
}

//Function Number: 675
init_self_fog_transition()
{
	if(!isdefined(self.fog_transition_ent))
	{
		self.fog_transition_ent = spawnstruct();
		self.fog_transition_ent.fogset = "";
		self.fog_transition_ent.time = 0;
	}
}

//Function Number: 676
using_hdr_fog()
{
	if(!isdefined(level.console))
	{
		set_console_status();
	}

	return is_gen4();
}

//Function Number: 677
fog_set_changes(param_00,param_01)
{
	if(!isplayer(self))
	{
		maps\_art::init_fog_transition();
	}
	else
	{
		init_self_fog_transition();
	}

	if(!isdefined(level.fog_set))
	{
		level.fog_set = [];
	}

	var_02 = level.fog_set[tolower(param_00)];
	if(!isdefined(var_02))
	{
		var_02 = level.vision_set_fog[tolower(param_00)];
	}

	if(isdefined(var_02) && isdefined(var_02.hdroverride) && using_hdr_fog())
	{
		if(isdefined(level.fog_set[tolower(var_02.hdroverride)]))
		{
			var_02 = level.fog_set[tolower(var_02.hdroverride)];
		}
		else if(isdefined(level.vision_set_fog))
		{
			var_02 = level.vision_set_fog[tolower(var_02.hdroverride)];
		}
	}

	if(!isdefined(param_01))
	{
		param_01 = var_02.transitiontime;
	}

	if(!isplayer(self))
	{
		common_scripts\utility::set_fog_to_ent_values(var_02,param_01);
		level.fog_transition_ent.fogset = param_00;
		level.fog_transition_ent.time = param_01;
		return;
	}

	if(param_00 != "" && self.fog_transition_ent.fogset == param_00 && self.fog_transition_ent.time == param_01)
	{
		return;
	}

	common_scripts\utility::set_fog_to_ent_values(var_02,param_01);
	self.fog_transition_ent.fogset = param_00;
	self.fog_transition_ent.time = param_01;
}

//Function Number: 678
vision_set_fog_changes(param_00,param_01)
{
	var_02 = vision_set_changes(param_00,param_01);
	if(var_02)
	{
		if(level.currentgen && isdefined(get_vision_set_fog(param_00 + "_cg")))
		{
			fog_set_changes(param_00 + "_cg",param_01);
			return;
		}

		if(isdefined(get_vision_set_fog(param_00)))
		{
			fog_set_changes(param_00,param_01);
			return;
		}

		clearfog(param_01);
		return;
	}
}

//Function Number: 679
init_self_visionset()
{
	if(!isdefined(self.vision_set_transition_ent))
	{
		self.vision_set_transition_ent = spawnstruct();
		self.vision_set_transition_ent.vision_set = "";
		self.vision_set_transition_ent.time = 0;
	}
}

//Function Number: 680
vision_set_changes(param_00,param_01)
{
	if(!isplayer(self))
	{
		var_02 = 1;
		if(!isdefined(level.vision_set_transition_ent))
		{
			level.vision_set_transition_ent = spawnstruct();
			level.vision_set_transition_ent.vision_set = "";
			level.vision_set_transition_ent.time = 0;
			var_02 = 0;
		}

		if(param_00 != "" && level.vision_set_transition_ent.vision_set == param_00 && level.vision_set_transition_ent.time == param_01)
		{
			return 0;
		}

		level.vision_set_transition_ent.vision_set = param_00;
		level.vision_set_transition_ent.time = param_01;
		if(var_02 && getdvarint("scr_art_tweak") != 0)
		{
		}
		else
		{
			visionsetnaked(param_00,param_01);
		}

		level.lvl_visionset = param_00;
		setdvar("vision_set_current",param_00);
	}
	else
	{
		init_self_visionset();
		if(param_00 != "" && self.vision_set_transition_ent.vision_set == param_00 && self.vision_set_transition_ent.time == param_01)
		{
			return 0;
		}

		self.vision_set_transition_ent.vision_set = param_00;
		self.vision_set_transition_ent.time = param_01;
		self visionsetnakedforplayer(param_00,param_01);
	}

	return 1;
}

//Function Number: 681
enable_teamflashbangimmunity()
{
	thread enable_teamflashbangimmunity_proc();
}

//Function Number: 682
enable_teamflashbangimmunity_proc()
{
	self endon("death");
	for(;;)
	{
		self.teamflashbangimmunity = 1;
		wait(0.05);
	}
}

//Function Number: 683
disable_teamflashbangimmunity()
{
	self.teamflashbangimmunity = undefined;
}

//Function Number: 684
_radiusdamage(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		radiusdamage(param_00,param_01,param_02,param_03);
		return;
	}

	radiusdamage(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 685
mask_destructibles_in_volumes(param_00)
{
	var_01 = getentarray("destructible_toy","targetname");
	var_02 = getentarray("destructible_vehicle","targetname");
	var_03 = common_scripts\utility::array_combine(var_01,var_02);
	foreach(var_05 in param_00)
	{
		var_05.destructibles = [];
	}

	foreach(var_08 in var_03)
	{
		foreach(var_05 in param_00)
		{
			if(!var_05 istouching(var_08))
			{
				continue;
			}

			var_05 maps\_utility_code::put_toy_in_volume(var_08);
			break;
		}
	}
}

//Function Number: 686
interactivekeypairs()
{
	var_00 = [];
	var_00[0] = ["interactive_birds","targetname"];
	var_00[1] = ["interactive_vulture","targetname"];
	var_00[2] = ["interactive_fish","script_noteworthy"];
	return var_00;
}

//Function Number: 687
mask_interactives_in_volumes(param_00)
{
	var_01 = interactivekeypairs();
	var_02 = [];
	foreach(var_04 in var_01)
	{
		var_05 = getentarray(var_04[0],var_04[1]);
		var_02 = common_scripts\utility::array_combine(var_02,var_05);
	}

	foreach(var_08 in var_02)
	{
		if(!isdefined(level._interactive[var_08.interactive_type].savetostructfn))
		{
			continue;
		}

		foreach(var_0B in param_00)
		{
			if(!var_0B istouching(var_08))
			{
				continue;
			}

			if(!isdefined(var_0B.interactives))
			{
				var_0B.interactives = [];
			}

			var_0B.interactives[var_0B.interactives.size] = var_08 [[ level._interactive[var_08.interactive_type].savetostructfn ]]();
		}
	}
}

//Function Number: 688
activate_interactives_in_volume()
{
	if(!isdefined(self.interactives))
	{
		return;
	}

	foreach(var_01 in self.interactives)
	{
		var_01 [[ level._interactive[var_01.interactive_type].loadfromstructfn ]]();
	}

	self.interactives = undefined;
}

//Function Number: 689
delete_interactives_in_volumes(param_00)
{
	mask_interactives_in_volumes(param_00);
	foreach(var_02 in param_00)
	{
		var_02.interactives = undefined;
	}
}

//Function Number: 690
mask_exploders_in_volume(param_00)
{
	if(getdvar("createfx") != "")
	{
		return;
	}

	var_01 = getentarray("script_brushmodel","classname");
	var_02 = getentarray("script_model","classname");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_01[var_01.size] = var_02[var_03];
	}

	foreach(var_05 in param_00)
	{
		foreach(var_07 in var_01)
		{
			if(isdefined(var_07.script_prefab_exploder))
			{
				var_07.script_exploder = var_07.script_prefab_exploder;
			}

			if(!isdefined(var_07.script_exploder))
			{
				continue;
			}

			if(!isdefined(var_07.model))
			{
				continue;
			}

			if(var_07.code_classname != "script_model")
			{
				continue;
			}

			if(!var_07 istouching(var_05))
			{
				continue;
			}

			var_07.masked_exploder = 1;
		}
	}
}

//Function Number: 691
activate_exploders_in_volume()
{
	var_00 = spawn("script_origin",(0,0,0));
	foreach(var_02 in level.createfxent)
	{
		if(!isdefined(var_02.v["masked_exploder"]))
		{
			continue;
		}

		var_00.origin = var_02.v["origin"];
		var_00.angles = var_02.v["angles"];
		if(!var_00 istouching(self))
		{
			continue;
		}

		var_03 = var_02.v["masked_exploder"];
		var_04 = var_02.v["masked_exploder_spawnflags"];
		var_05 = var_02.v["masked_exploder_script_disconnectpaths"];
		var_06 = spawn("script_model",(0,0,0),var_04);
		var_06 setmodel(var_03);
		var_06.origin = var_02.v["origin"];
		var_06.angles = var_02.v["angles"];
		var_02.v["masked_exploder"] = undefined;
		var_02.v["masked_exploder_spawnflags"] = undefined;
		var_02.v["masked_exploder_script_disconnectpaths"] = undefined;
		var_06.disconnect_paths = var_05;
		var_06.script_exploder = var_02.v["exploder"];
		common_scripts\_exploder::setup_individual_exploder(var_06);
		var_02.model = var_06;
	}

	var_00 delete();
}

//Function Number: 692
precache_destructible(param_00)
{
	var_01 = common_scripts\_destructible::destructible_getinfoindex(param_00);
	if(var_01 != -1)
	{
		return;
	}

	if(!isdefined(level.destructible_functions))
	{
		level.destructible_functions = [];
	}

	var_02 = spawnstruct();
	var_02.destructibleinfo = common_scripts\_destructible::destructible_gettype(param_00);
	var_02 thread common_scripts\_destructible::precache_destructibles();
	var_02 thread common_scripts\_destructible::add_destructible_fx();
}

//Function Number: 693
delete_destructibles_in_volumes(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		var_03.destructibles = [];
	}

	var_05 = ["destructible_toy","destructible_vehicle"];
	var_06 = 0;
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	foreach(var_08 in var_05)
	{
		var_09 = getentarray(var_08,"targetname");
		foreach(var_0B in var_09)
		{
			foreach(var_03 in param_00)
			{
				if(param_01)
				{
					var_06++;
					var_06 = var_06 % 5;
					if(var_06 == 1)
					{
						wait(0.05);
					}
				}

				if(!var_03 istouching(var_0B))
				{
					continue;
				}

				var_0B delete();
				break;
			}
		}
	}
}

//Function Number: 694
delete_exploders_in_volumes(param_00,param_01)
{
	var_02 = getentarray("script_brushmodel","classname");
	var_03 = getentarray("script_model","classname");
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_02[var_02.size] = var_03[var_04];
	}

	var_05 = [];
	var_06 = spawn("script_origin",(0,0,0));
	var_07 = 0;
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	foreach(var_09 in param_00)
	{
		foreach(var_0B in var_02)
		{
			if(!isdefined(var_0B.script_exploder))
			{
				continue;
			}

			var_06.origin = var_0B getorigin();
			if(!var_09 istouching(var_06))
			{
				continue;
			}

			var_05[var_05.size] = var_0B;
		}
	}

	array_delete(var_05);
	var_06 delete();
}

//Function Number: 695
activate_destructibles_in_volume()
{
	if(!isdefined(self.destructibles))
	{
		return;
	}

	foreach(var_01 in self.destructibles)
	{
		var_02 = spawn("script_model",(0,0,0));
		var_02 setmodel(var_01.toy_model);
		var_02.origin = var_01.origin;
		var_02.angles = var_01.angles;
		var_02.script_noteworthy = var_01.script_noteworthy;
		var_02.targetname = var_01.targetname;
		var_02.target = var_01.target;
		var_02.script_linkto = var_01.script_linkto;
		var_02.destructible_type = var_01.destructible_type;
		var_02.script_noflip = var_01.script_noflip;
		var_02 common_scripts\_destructible::setup_destructibles(1);
	}

	self.destructibles = [];
}

//Function Number: 696
setflashbangimmunity(param_00)
{
	self.flashbangimmunity = param_00;
}

//Function Number: 697
flashbanggettimeleftsec()
{
	var_00 = self.flashendtime - gettime();
	if(var_00 < 0)
	{
		return 0;
	}

	return var_00 * 0.001;
}

//Function Number: 698
flashbangisactive()
{
	return flashbanggettimeleftsec() > 0;
}

//Function Number: 699
flashbangstart(param_00)
{
	if(isdefined(self.flashbangimmunity) && self.flashbangimmunity)
	{
		return;
	}

	var_01 = gettime() + param_00 * 1000;
	if(isdefined(self.flashendtime))
	{
		self.flashendtime = max(self.flashendtime,var_01);
	}
	else
	{
		self.flashendtime = var_01;
	}

	self notify("flashed");
	self setflashbanged(1);
}

//Function Number: 700
waittill_volume_dead()
{
	for(;;)
	{
		var_00 = getaispeciesarray("axis","all");
		var_01 = 0;
		foreach(var_03 in var_00)
		{
			if(!isalive(var_03))
			{
				continue;
			}

			if(var_03 istouching(self))
			{
				var_01 = 1;
				break;
			}

			wait(0.0125);
		}

		if(!var_01)
		{
			var_05 = get_ai_touching_volume("axis");
			if(!var_05.size)
			{
				break;
			}
		}

		wait(0.05);
	}
}

//Function Number: 701
waittill_volume_dead_or_dying()
{
	var_00 = 0;
	for(;;)
	{
		var_01 = getaispeciesarray("axis","all");
		var_02 = 0;
		foreach(var_04 in var_01)
		{
			if(!isalive(var_04))
			{
				continue;
			}

			if(var_04 istouching(self))
			{
				if(var_04 doinglongdeath())
				{
					continue;
				}

				var_02 = 1;
				var_00 = 1;
				break;
			}

			wait(0.0125);
		}

		if(!var_02)
		{
			var_06 = get_ai_touching_volume("axis");
			if(!var_06.size)
			{
				break;
			}
			else
			{
				var_00 = 1;
			}
		}

		wait(0.05);
	}

	return var_00;
}

//Function Number: 702
waittill_volume_dead_then_set_flag(param_00)
{
	waittill_volume_dead();
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 703
waittill_targetname_volume_dead_then_set_flag(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_02 waittill_volume_dead_then_set_flag(param_01);
}

//Function Number: 704
player_can_be_shot()
{
	level.player ent_flag_clear("player_zero_attacker_accuracy");
	level.player.ignorerandombulletdamage = 0;
	level.player maps\_gameskill::update_player_attacker_accuracy();
}

//Function Number: 705
player_cant_be_shot()
{
	level.player ent_flag_set("player_zero_attacker_accuracy");
	level.player.attackeraccuracy = 0;
	level.player.ignorerandombulletdamage = 1;
}

//Function Number: 706
set_player_attacker_accuracy(param_00)
{
	var_01 = get_player_from_self();
	var_01.gs.player_attacker_accuracy = param_00;
	var_01 maps\_gameskill::update_player_attacker_accuracy();
}

//Function Number: 707
array_index_by_parameters(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_01[var_03.script_parameters] = var_03;
	}

	return var_01;
}

//Function Number: 708
array_index_by_classname(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_01[var_03.classname] = var_03;
	}

	return var_01;
}

//Function Number: 709
array_index_by_script_index(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_04 = var_03.script_index;
		if(isdefined(var_04))
		{
			var_01[var_04] = var_03;
		}
	}

	return var_01;
}

//Function Number: 710
add_target_pivot(param_00)
{
	if(isdefined(param_00))
	{
		self.pivot = param_00;
	}
	else
	{
		self.pivot = getent(self.target,"targetname");
	}

	self linkto(self.pivot);
}

//Function Number: 711
flashbangstop()
{
	self.flashendtime = undefined;
	self setflashbanged(0);
}

//Function Number: 712
getent_or_struct(param_00,param_01)
{
	var_02 = getent(param_00,param_01);
	if(isdefined(var_02))
	{
		return var_02;
	}

	return common_scripts\utility::getstruct(param_00,param_01);
}

//Function Number: 713
grenade_earthquake()
{
	thread endondeath();
	self endon("end_explode");
	self waittill("explode",var_00);
	dirt_on_screen_from_position(var_00);
}

//Function Number: 714
endondeath()
{
	self waittill("death");
	waittillframeend;
	self notify("end_explode");
}

//Function Number: 715
dirt_on_screen_from_position(param_00)
{
	playrumbleonposition("grenade_rumble",param_00);
	earthquake(0.3,0.5,param_00,400);
	foreach(var_02 in level.players)
	{
		if(distance(param_00,var_02.origin) > 600)
		{
			continue;
		}

		if(var_02 damageconetrace(param_00))
		{
			var_02 thread dirteffect(param_00);
		}
	}
}

//Function Number: 716
player_rides_shotgun_in_humvee(param_00,param_01,param_02,param_03)
{
	return player_rides_in_humvee("shotgun",level.player,param_00,param_01,param_02,param_03);
}

//Function Number: 717
player_rides_in_humvee(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_01))
	{
		param_01 = level.player;
	}

	param_01 allowcrouch(0);
	param_01 allowprone(0);
	param_01 disableweapons();
	var_06 = common_scripts\utility::spawn_tag_origin();
	var_06 linkto(self,"tag_passenger",player_rides_in_humvee_offset(param_00),(0,0,0));
	var_06.player_dismount = common_scripts\utility::spawn_tag_origin();
	var_06.player_dismount linkto(self,"tag_body",player_rides_humvee_offset_dismount(param_00),(0,0,0));
	if(!isdefined(param_02))
	{
		param_02 = 90;
	}

	if(!isdefined(param_03))
	{
		param_03 = 90;
	}

	if(!isdefined(param_04))
	{
		param_04 = 40;
	}

	if(!isdefined(param_05))
	{
		param_05 = 40;
	}

	param_01 disableweapons();
	param_01 playerlinkto(var_06,"tag_origin",0.8,param_02,param_03,param_04,param_05);
	param_01.humvee_org = var_06;
	return var_06;
}

//Function Number: 718
player_rides_in_humvee_offset(param_00)
{
	switch(param_00)
	{
		case "shotgun":
			break;

		case "backleft":
			break;

		case "backright":
			break;
	}
}

//Function Number: 719
player_rides_humvee_offset_dismount(param_00)
{
	switch(param_00)
	{
		case "shotgun":
			break;

		case "backleft":
			break;

		case "backright":
			break;
	}
}

//Function Number: 720
player_leaves_humvee(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = self;
	var_02 = level.player;
	if(isplayer(self))
	{
		var_02 = self;
		var_01 = var_02.humvee_org;
	}

	var_01 unlink();
	if(!param_00)
	{
		var_03 = 0.6;
		var_01 moveto(var_01.player_dismount.origin,var_03,var_03 * 0.5,var_03 * 0.5);
		wait(var_03);
	}

	var_02 unlink();
	var_02 enableweapons();
	var_02 allowcrouch(1);
	var_02 allowprone(1);
	var_02.humvee_org = undefined;
	var_01.player_dismount delete();
	var_01 delete();
}

//Function Number: 721
dirteffect(param_00,param_01)
{
	var_02 = screen_effect_sides(param_00);
	foreach(var_05, var_04 in var_02)
	{
		thread maps\_gameskill::grenade_dirt_on_screen(var_05);
	}
}

//Function Number: 722
bloodsplateffect(param_00)
{
	if(!isdefined(self.damageattacker))
	{
		return;
	}

	var_01 = screen_effect_sides(self.damageattacker.origin);
	foreach(var_04, var_03 in var_01)
	{
		thread maps\_gameskill::blood_splat_on_screen(var_04);
	}
}

//Function Number: 723
screen_effect_sides(param_00)
{
	var_01 = vectornormalize(anglestoforward(self.angles));
	var_02 = vectornormalize(anglestoright(self.angles));
	var_03 = vectornormalize(param_00 - self.origin);
	var_04 = vectordot(var_03,var_01);
	var_05 = vectordot(var_03,var_02);
	var_06 = [];
	var_07 = self getcurrentweapon();
	if(var_04 > 0 && var_04 > 0.5 && weapontype(var_07) != "riotshield")
	{
		var_06["bottom"] = 1;
	}

	if(abs(var_04) < 0.866)
	{
		if(var_05 > 0)
		{
			var_06["right"] = 1;
		}
		else
		{
			var_06["left"] = 1;
		}
	}

	return var_06;
}

//Function Number: 724
pathrandompercent_set(param_00)
{
	if(!isdefined(self.old_pathrandompercent))
	{
		self.old_pathrandompercent = self.pathrandompercent;
	}

	self.pathrandompercent = param_00;
}

//Function Number: 725
pathrandompercent_zero()
{
	if(isdefined(self.old_pathrandompercent))
	{
		return;
	}

	self.old_pathrandompercent = self.pathrandompercent;
	self.pathrandompercent = 0;
}

//Function Number: 726
pathrandompercent_reset()
{
	self.pathrandompercent = self.old_pathrandompercent;
	self.old_pathrandompercent = undefined;
}

//Function Number: 727
walkdist_zero()
{
	if(isdefined(self.old_walkdistfacingmotion))
	{
		return;
	}

	self.old_walkdist = self.walkdist;
	self.old_walkdistfacingmotion = self.walkdistfacingmotion;
	self.walkdist = 0;
	self.walkdistfacingmotion = 0;
}

//Function Number: 728
walkdist_force_walk()
{
	if(!isdefined(self.old_walkdistfacingmotion))
	{
		self.old_walkdist = self.walkdist;
		self.old_walkdistfacingmotion = self.walkdistfacingmotion;
	}

	self.walkdist = 999999999;
	self.walkdistfacingmotion = 999999999;
}

//Function Number: 729
is_walkdist_override()
{
	return isdefined(self.old_walkdistfacingmotion) || isdefined(self.old_walkdist);
}

//Function Number: 730
walkdist_reset()
{
	self.walkdist = self.old_walkdist;
	self.walkdistfacingmotion = self.old_walkdistfacingmotion;
	self.old_walkdist = undefined;
	self.old_walkdistfacingmotion = undefined;
}

//Function Number: 731
enable_ignorerandombulletdamage_drone()
{
	thread ignorerandombulletdamage_drone_proc();
}

//Function Number: 732
ignorerandombulletdamage_drone_proc()
{
	self endon("disable_ignorerandombulletdamage_drone");
	self endon("death");
	self.ignorerandombulletdamage = 1;
	self.fakehealth = self.health;
	self.health = 1000000;
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		if(!isplayer(var_01) && issentient(var_01))
		{
			if(isdefined(var_01.enemy) && var_01.enemy != self)
			{
				continue;
			}
		}

		self.fakehealth = self.fakehealth - var_00;
		if(self.fakehealth <= 0)
		{
			break;
		}
	}

	self kill();
}

//Function Number: 733
set_brakes(param_00)
{
	self.veh_brake = param_00;
}

//Function Number: 734
disable_ignorerandombulletdamage_drone()
{
	if(!isalive(self))
	{
		return;
	}

	if(!isdefined(self.ignorerandombulletdamage))
	{
		return;
	}

	self notify("disable_ignorerandombulletdamage_drone");
	self.ignorerandombulletdamage = undefined;
	self.health = self.fakehealth;
}

//Function Number: 735
timeoutent(param_00)
{
	var_01 = spawnstruct();
	var_01 delaythread(param_00,::send_notify,"timeout");
	return var_01;
}

//Function Number: 736
delaythread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	thread maps\_utility_code::delaythread_proc(param_01,param_00,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 737
delaychildthread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	childthread maps\_utility_code::delaychildthread_proc(param_01,param_00,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 738
flagwaitthread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	if(!isarray(param_00))
	{
		param_00 = [param_00,0];
	}

	thread maps\_utility_code::flagwaitthread_proc(param_01,param_00,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 739
waittillthread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	if(!isarray(param_00))
	{
		param_00 = [param_00,0];
	}

	thread maps\_utility_code::waittillthread_proc(param_01,param_00,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 740
enable_danger_react(param_00)
{
	param_00 = param_00 * 1000;
	self.dodangerreact = 1;
	self.dangerreactduration = param_00;
	self.neversprintforvariation = undefined;
}

//Function Number: 741
disable_danger_react()
{
	self.dodangerreact = 0;
	self.neversprintforvariation = 1;
}

//Function Number: 742
set_group_advance_to_enemy_parameters(param_00,param_01)
{
	level.advancetoenemyinterval = param_00;
	level.advancetoenemygroupmax = param_01;
}

//Function Number: 743
reset_group_advance_to_enemy_timer(param_00)
{
	level.lastadvancetoenemytime[param_00] = gettime();
}

//Function Number: 744
set_custom_gameskill_func(param_00)
{
	level.custom_gameskill_func = param_00;
	thread maps\_gameskill::resetskill();
}

//Function Number: 745
clear_custom_gameskill_func()
{
	level.custom_gameskill_func = undefined;
	thread maps\_gameskill::resetskill();
}

//Function Number: 746
set_wind(param_00,param_01,param_02)
{
	maps\_animatedmodels::init_wind_if_uninitialized();
	if(isdefined(param_02))
	{
		level.wind.variance = param_02;
	}

	level.wind.rate = param_01;
	level.wind.weight = param_00;
	level notify("windchange","strong");
}

//Function Number: 747
string_is_single_digit_integer(param_00)
{
	if(param_00.size > 1)
	{
		return 0;
	}

	var_01 = [];
	var_01["0"] = 1;
	var_01["1"] = 1;
	var_01["2"] = 1;
	var_01["3"] = 1;
	var_01["4"] = 1;
	var_01["5"] = 1;
	var_01["6"] = 1;
	var_01["7"] = 1;
	var_01["8"] = 1;
	var_01["9"] = 1;
	if(isdefined(var_01[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 748
set_battlechatter_variable(param_00,param_01)
{
	level.battlechatter[param_00] = param_01;
	maps\_utility_code::update_battlechatter_hud();
}

//Function Number: 749
objective_clearadditionalpositions(param_00)
{
	for(var_01 = 0;var_01 < 8;var_01++)
	{
		objective_additionalposition(param_00,var_01,(0,0,0));
	}
}

//Function Number: 750
get_minutes_and_seconds(param_00)
{
	var_01 = [];
	var_01["minutes"] = 0;
	for(var_01["seconds"] = int(param_00 / 1000);var_01["seconds"] >= 60;var_01["seconds"] = var_01["seconds"] - 60)
	{
		var_01["minutes"]++;
	}

	if(var_01["seconds"] < 10)
	{
		var_01["seconds"] = "0" + var_01["seconds"];
	}

	return var_01;
}

//Function Number: 751
player_has_weapon(param_00)
{
	var_01 = level.player getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(var_03 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 752
obj(param_00)
{
	if(!isdefined(level.obj_array))
	{
		level.obj_array = [];
	}

	if(!isdefined(level.obj_array[param_00]))
	{
		level.obj_array[param_00] = level.obj_array.size + 1;
	}

	return level.obj_array[param_00];
}

//Function Number: 753
obj_exists(param_00)
{
	return isdefined(level.obj_array) && isdefined(level.obj_array[param_00]);
}

//Function Number: 754
player_mount_vehicle(param_00)
{
	self mountvehicle(param_00);
	self.drivingvehicle = param_00;
}

//Function Number: 755
player_dismount_vehicle()
{
	self dismountvehicle();
	self.drivingvehicle = undefined;
}

//Function Number: 756
graph_position(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_04 - param_02;
	var_06 = param_03 - param_01;
	var_07 = var_05 / var_06;
	param_00 = param_00 - param_03;
	param_00 = var_07 * param_00;
	param_00 = param_00 + param_04;
	return param_00;
}

//Function Number: 757
enable_achievement_harder_they_fall()
{
	self.rappeller = 1;
}

//Function Number: 758
disable_achievement_harder_they_fall()
{
	self.rappeller = undefined;
}

//Function Number: 759
enable_achievement_harder_they_fall_guy(param_00)
{
	param_00 enable_achievement_harder_they_fall();
}

//Function Number: 760
disable_achievement_harder_they_fall_guy(param_00)
{
	param_00 disable_achievement_harder_they_fall();
}

//Function Number: 761
musiclength(param_00)
{
	var_01 = tablelookup("sound/soundlength.csv",0,param_00,1);
	if(!isdefined(var_01) || var_01 == "")
	{
		return -1;
	}

	var_01 = int(var_01);
	var_01 = var_01 * 0.001;
	return var_01;
}

//Function Number: 762
is_command_bound(param_00)
{
	var_01 = getkeybinding(param_00);
	return var_01["count"];
}

//Function Number: 763
linear_interpolate(param_00,param_01,param_02)
{
	var_03 = param_02 - param_01;
	var_04 = param_00 * var_03;
	var_05 = param_01 + var_04;
	return var_05;
}

//Function Number: 764
define_loadout(param_00)
{
	level.loadout = param_00;
}

//Function Number: 765
template_level(param_00)
{
	define_loadout(param_00);
	level.template_script = param_00;
}

//Function Number: 766
template_so_level(param_00)
{
	level.audio_stringtable_mapname = param_00;
}

//Function Number: 767
fx_volume_pause_noteworthy(param_00,param_01)
{
	thread fx_volume_pause_noteworthy_thread(param_00,param_01);
}

//Function Number: 768
fx_volume_pause_noteworthy_thread(param_00,param_01)
{
	var_02 = getent(param_00,"script_noteworthy");
	var_02 notify("new_volume_command");
	var_02 endon("new_volume_command");
	wait(0.05);
	fx_volume_pause(var_02,param_01);
}

//Function Number: 769
fx_volume_pause(param_00,param_01)
{
	param_00.fx_paused = 1;
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(param_01)
	{
		array_thread_mod_delayed(param_00.fx,::common_scripts\utility::pauseeffect);
		return;
	}

	common_scripts\utility::array_thread(param_00.fx,::common_scripts\utility::pauseeffect);
}

//Function Number: 770
array_thread_mod_delayed(param_00,param_01,param_02)
{
	var_03 = 0;
	if(!isdefined(param_02))
	{
		param_02 = 5;
	}

	var_04 = [];
	foreach(var_06 in param_00)
	{
		var_04[var_04.size] = var_06;
		var_03++;
		var_03 = var_03 % param_02;
		if(param_02 == 0)
		{
			common_scripts\utility::array_thread(var_04,param_01);
			wait(0.05);
			var_04 = [];
		}
	}
}

//Function Number: 771
fx_volume_restart_noteworthy(param_00)
{
	thread fx_volume_restart_noteworthy_thread(param_00);
}

//Function Number: 772
fx_volume_restart_noteworthy_thread(param_00)
{
	var_01 = getent(param_00,"script_noteworthy");
	var_01 notify("new_volume_command");
	var_01 endon("new_volume_command");
	wait(0.05);
	if(!isdefined(var_01.fx_paused))
	{
		return;
	}

	var_01.fx_paused = undefined;
	fx_volume_restart(var_01);
}

//Function Number: 773
fx_volume_restart(param_00)
{
	common_scripts\utility::array_thread(param_00.fx,::restarteffect);
}

//Function Number: 774
flag_count_increment(param_00)
{
	if(!isdefined(level.flag_count))
	{
		level.flag_count = [];
	}

	if(!isdefined(level.flag_count[param_00]))
	{
		level.flag_count[param_00] = 1;
		return;
	}

	level.flag_count[param_00]++;
}

//Function Number: 775
flag_count_decrement(param_00)
{
	level.flag_count[param_00]--;
	level.flag_count[param_00] = int(max(0,level.flag_count[param_00]));
	if(level.flag_count[param_00])
	{
		return;
	}

	common_scripts\utility::flag_set(param_00);
}

//Function Number: 776
flag_count_set(param_00,param_01)
{
	level.flag_count[param_00] = param_01;
}

//Function Number: 777
add_cleanup_ent(param_00,param_01)
{
	if(!isdefined(level.cleanup_ents))
	{
		level.cleanup_ents = [];
	}

	if(!isdefined(level.cleanup_ents[param_01]))
	{
		level.cleanup_ents[param_01] = [];
	}

	level.cleanup_ents[param_01][level.cleanup_ents[param_01].size] = param_00;
}

//Function Number: 778
cleanup_ents(param_00)
{
	var_01 = level.cleanup_ents[param_00];
	var_01 = common_scripts\utility::array_removeundefined(var_01);
	array_delete(var_01);
	level.cleanup_ents[param_00] = undefined;
}

//Function Number: 779
cleanup_ents_removing_bullet_shield(param_00)
{
	if(!isdefined(level.cleanup_ents))
	{
		return;
	}

	if(!isdefined(level.cleanup_ents[param_00]))
	{
		return;
	}

	var_01 = level.cleanup_ents[param_00];
	var_01 = common_scripts\utility::array_removeundefined(var_01);
	foreach(var_03 in var_01)
	{
		if(!isai(var_03))
		{
			continue;
		}

		if(!isalive(var_03))
		{
			continue;
		}

		if(!isdefined(var_03.magic_bullet_shield))
		{
			continue;
		}

		if(!var_03.magic_bullet_shield)
		{
			continue;
		}

		var_03 stop_magic_bullet_shield();
	}

	array_delete(var_01);
	level.cleanup_ents[param_00] = undefined;
}

//Function Number: 780
add_trigger_function(param_00)
{
	if(!isdefined(self.trigger_functions))
	{
		thread maps\_utility_code::add_trigger_func_thread();
	}

	self.trigger_functions[self.trigger_functions.size] = param_00;
}

//Function Number: 781
getallweapons()
{
	var_00 = [];
	var_01 = getentarray();
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.classname))
		{
			continue;
		}

		if(issubstr(var_03.classname,"weapon_"))
		{
			var_00[var_00.size] = var_03;
		}
	}

	return var_00;
}

//Function Number: 782
radio_add(param_00)
{
	level.scr_radio[param_00] = param_00;
}

//Function Number: 783
move_with_rate(param_00,param_01,param_02)
{
	self notify("newmove");
	self endon("newmove");
	if(!isdefined(param_02))
	{
		param_02 = 200;
	}

	var_03 = distance(self.origin,param_00);
	var_04 = var_03 / param_02;
	var_05 = vectornormalize(param_00 - self.origin);
	self moveto(param_00,var_04,0,0);
	self rotateto(param_01,var_04,0,0);
	wait(var_04);
	if(!isdefined(self))
	{
		return;
	}

	self.velocity = var_05 * var_03 / var_04;
}

//Function Number: 784
flag_on_death(param_00)
{
	level endon(param_00);
	self waittill("death");
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 785
enable_damagefeedback_hud()
{
	level.damagefeedbackhud = 1;
}

//Function Number: 786
disable_damagefeedback_hud()
{
	level.damagefeedbackhud = 0;
}

//Function Number: 787
is_damagefeedback_hud_enabled()
{
	return isdefined(level.damagefeedbackhud) && level.damagefeedbackhud;
}

//Function Number: 788
enable_damagefeedback_snd()
{
	level.damagefeedbacksnd = 1;
}

//Function Number: 789
disable_damagefeedback_snd()
{
	level.damagefeedbacksnd = 0;
}

//Function Number: 790
is_damagefeedback_snd_enabled()
{
	return isdefined(level.damagefeedbacksnd) && level.damagefeedbacksnd;
}

//Function Number: 791
add_damagefeedback()
{
	maps\_damagefeedback::monitordamage();
}

//Function Number: 792
remove_damagefeedback()
{
	maps\_damagefeedback::stopmonitordamage();
}

//Function Number: 793
is_demo()
{
	if(getdvar("e3demo") == "1")
	{
		return 1;
	}

	return 0;
}

//Function Number: 794
deletestructarray(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::getstructarray(param_00,param_01);
	deletestructarray_ref(var_03,param_02);
}

//Function Number: 795
deletestruct_ref(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = param_00.script_linkname;
	if(isdefined(var_01) && isdefined(level.struct_class_names["script_linkname"]) && isdefined(level.struct_class_names["script_linkname"][var_01]))
	{
		foreach(var_04, var_03 in level.struct_class_names["script_linkname"][var_01])
		{
			if(isdefined(var_03) && param_00 == var_03)
			{
				level.struct_class_names["script_linkname"][var_01][var_04] = undefined;
			}
		}

		if(level.struct_class_names["script_linkname"][var_01].size == 0)
		{
			level.struct_class_names["script_linkname"][var_01] = undefined;
		}
	}

	var_01 = param_00.script_noteworthy;
	if(isdefined(var_01) && isdefined(level.struct_class_names["script_noteworthy"]) && isdefined(level.struct_class_names["script_noteworthy"][var_01]))
	{
		foreach(var_04, var_03 in level.struct_class_names["script_noteworthy"][var_01])
		{
			if(isdefined(var_03) && param_00 == var_03)
			{
				level.struct_class_names["script_noteworthy"][var_01][var_04] = undefined;
			}
		}

		if(level.struct_class_names["script_noteworthy"][var_01].size == 0)
		{
			level.struct_class_names["script_noteworthy"][var_01] = undefined;
		}
	}

	var_01 = param_00.target;
	if(isdefined(var_01) && isdefined(level.struct_class_names["target"]) && isdefined(level.struct_class_names["target"][var_01]))
	{
		foreach(var_04, var_03 in level.struct_class_names["target"][var_01])
		{
			if(isdefined(var_03) && param_00 == var_03)
			{
				level.struct_class_names["target"][var_01][var_04] = undefined;
			}
		}

		if(level.struct_class_names["target"][var_01].size == 0)
		{
			level.struct_class_names["target"][var_01] = undefined;
		}
	}

	var_01 = param_00.targetname;
	if(isdefined(var_01) && isdefined(level.struct_class_names["targetname"]) && isdefined(level.struct_class_names["targetname"][var_01]))
	{
		foreach(var_04, var_03 in level.struct_class_names["targetname"][var_01])
		{
			if(isdefined(var_03) && param_00 == var_03)
			{
				level.struct_class_names["targetname"][var_01][var_04] = undefined;
			}
		}

		if(level.struct_class_names["targetname"][var_01].size == 0)
		{
			level.struct_class_names["targetname"][var_01] = undefined;
		}
	}

	if(isdefined(level.struct))
	{
		foreach(var_04, var_03 in level.struct)
		{
			if(param_00 == var_03)
			{
				level.struct[var_04] = undefined;
			}
		}
	}
}

//Function Number: 796
deletestructarray_ref(param_00,param_01)
{
	if(!isdefined(param_00) || !isarray(param_00) || param_00.size == 0)
	{
		return;
	}

	param_01 = common_scripts\utility::ter_op(isdefined(param_01),param_01,0);
	param_01 = common_scripts\utility::ter_op(param_01 > 0,param_01,0);
	if(param_01 > 0)
	{
		foreach(var_03 in param_00)
		{
			deletestruct_ref(var_03);
			wait(param_01);
		}

		return;
	}

	foreach(var_03 in param_01)
	{
		deletestruct_ref(var_03);
	}
}

//Function Number: 797
getstruct_delete(param_00,param_01)
{
	var_02 = common_scripts\utility::getstruct(param_00,param_01);
	deletestruct_ref(var_02);
	return var_02;
}

//Function Number: 798
getstructarray_delete(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::getstructarray(param_00,param_01);
	deletestructarray_ref(var_03,param_02);
	return var_03;
}

//Function Number: 799
getent_or_struct_or_node(param_00,param_01)
{
	var_02 = getent_or_struct(param_00,param_01);
	if(!isdefined(var_02))
	{
		var_02 = getnode(param_00,param_01);
	}

	if(!isdefined(var_02))
	{
		var_02 = getvehiclenode(param_00,param_01);
	}

	return var_02;
}

//Function Number: 800
setentityheadicon(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_03))
	{
		self.entityheadiconoffset = param_03;
	}
	else
	{
		self.entityheadiconoffset = (0,0,0);
	}

	if(isdefined(param_04))
	{
		self.entityheadiconreferencefunc = param_04;
	}

	self notify("new_head_icon");
	var_05 = newhudelem();
	var_05.archived = 1;
	var_05.alpha = 0.8;
	var_05 setshader(param_00,param_01,param_02);
	var_05 setwaypoint(0,0,0,1);
	self.entityheadicon = var_05;
	updateentityheadiconorigin();
	thread updateentityheadicon();
	thread destroyentityheadiconondeath();
}

//Function Number: 801
removeentityheadicon()
{
	if(!isdefined(self.entityheadicon))
	{
		return;
	}

	self.entityheadicon destroy();
}

//Function Number: 802
updateentityheadicon()
{
	self endon("new_head_icon");
	self endon("death");
	var_00 = self.origin;
	for(;;)
	{
		if(var_00 != self.origin)
		{
			updateentityheadiconorigin();
			var_00 = self.origin;
		}

		wait(0.05);
	}
}

//Function Number: 803
updateentityheadiconorigin()
{
	if(isdefined(self.entityheadiconreferencefunc))
	{
		var_00 = self [[ self.entityheadiconreferencefunc ]]();
		if(isdefined(var_00))
		{
			self.entityheadicon.x = self.entityheadiconoffset[0] + var_00[0];
			self.entityheadicon.y = self.entityheadiconoffset[1] + var_00[1];
			self.entityheadicon.z = self.entityheadiconoffset[2] + var_00[2];
			return;
		}
	}

	self.entityheadicon.x = self.origin[0] + self.entityheadiconoffset[0];
	self.entityheadicon.y = self.origin[1] + self.entityheadiconoffset[1];
	self.entityheadicon.z = self.origin[2] + self.entityheadiconoffset[2];
}

//Function Number: 804
destroyentityheadiconondeath()
{
	self endon("new_head_icon");
	self waittill("death");
	if(!isdefined(self.entityheadicon))
	{
		return;
	}

	self.entityheadicon destroy();
}

//Function Number: 805
worldtolocalcoords(param_00)
{
	var_01 = param_00 - self.origin;
	return (vectordot(var_01,anglestoforward(self.angles)),-1 * vectordot(var_01,anglestoright(self.angles)),vectordot(var_01,anglestoup(self.angles)));
}

//Function Number: 806
intro_screen_create(param_00,param_01,param_02,param_03,param_04)
{
	level.introscreen = spawnstruct();
	level.introscreen.completed_delay = 3;
	level.introscreen.fade_out_time = 1.5;
	level.introscreen.fade_in_time = undefined;
	if(isdefined(param_03))
	{
		level.introscreen.lines = [param_00,param_01,param_02,param_03];
	}
	else
	{
		level.introscreen.lines = [param_00,param_01,param_02];
	}

	common_scripts\utility::noself_array_call(level.introscreen.lines,::precachestring);
}

//Function Number: 807
intro_screen_custom_func(param_00)
{
	level.introscreen.customfunc = param_00;
}

//Function Number: 808
intro_screen_custom_timing(param_00,param_01,param_02)
{
	level.introscreen.completed_delay = param_00;
	level.introscreen.fade_out_time = param_01;
	level.introscreen.fade_in_time = param_02;
}

//Function Number: 809
set_npc_anims(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_01))
	{
		self.run_overrideanim = param_01;
	}

	if(isdefined(param_02))
	{
		self.walk_overrideanim = param_02;
	}

	if(isdefined(param_03))
	{
		self.specialidleanim = param_03;
	}

	self.animarchetype = param_00;
	var_0A = [];
	if(isdefined(param_04) && isdefined(param_05))
	{
		var_0B = [];
		foreach(var_0D in param_06)
		{
			var_0B[var_0D] = param_04;
		}

		var_0A["cover_trans"] = var_0B;
		var_0F = [];
		foreach(var_0D in param_06)
		{
			var_0F[var_0D] = param_05;
		}

		var_0A["cover_exit"] = var_0F;
	}
	else if(isdefined(param_04) || isdefined(param_05))
	{
	}

	if(isdefined(param_07))
	{
		if(isdefined(param_08))
		{
		}

		var_0A["run_turn"] = param_07;
		var_0A["walk_turn"] = param_08;
		self.noturnanims = undefined;
	}
	else if(isdefined(param_08))
	{
	}
	else
	{
		self.noturnanims = 1;
	}

	if(isdefined(param_09))
	{
		var_12 = [];
		var_12["stairs_up"] = param_09["stairs_up"];
		var_12["stairs_down"] = param_09["stairs_down"];
		var_12["stairs_up_in"] = param_09["stairs_up_in"];
		var_12["stairs_down_in"] = param_09["stairs_down_in"];
		var_12["stairs_up_out"] = param_09["stairs_up_out"];
		var_12["stairs_down_out"] = param_09["stairs_down_out"];
		var_0A["walk"] = var_12;
		var_0A["run"] = var_12;
		self.run_overrideanim_hasstairanimarray = 1;
	}
	else
	{
		self.run_overrideanim_hasstairanimarray = undefined;
	}

	level.archetypes[param_00] = var_0A;
	animscripts\init_move_transitions::inittransdistandanglesforarchetype(param_00);
}

//Function Number: 810
clear_npc_anims(param_00)
{
	self.animarchetype = undefined;
	level.archetypes[param_00] = undefined;
	self.run_overrideanim = undefined;
	self.run_overrideanim_hasstairanimarray = undefined;
	self.walk_overrideanim = undefined;
	self.specialidleanim = undefined;
}

//Function Number: 811
register_archetype(param_00,param_01,param_02)
{
	animscripts\animset::registerarchetype(param_00,param_01,param_02);
}

//Function Number: 812
archetype_exists(param_00)
{
	return animscripts\animset::archetypeexists(param_00);
}

//Function Number: 813
set_archetype(param_00)
{
	self.animarchetype = param_00;
	self notify("move_loop_restart");
	if(param_00 == "creepwalk")
	{
		self.sharpturnlookaheaddist = 72;
	}
}

//Function Number: 814
clear_archetype()
{
	if(isdefined(self.animarchetype) && self.animarchetype == "creepwalk")
	{
		self.sharpturnlookaheaddist = 30;
	}

	self.animarchetype = undefined;
	self notify("move_loop_restart");
}

//Function Number: 815
shot_endangers_any_player(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(var_03 shot_endangers_player(param_00,param_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 816
shot_endangers_player(param_00,param_01)
{
	var_02 = self getpointinbounds(0,0,0);
	var_03 = var_02 - param_00;
	var_04 = length(var_03);
	var_05 = asin(clamp(60 / var_04,0,1));
	if(vectordot(vectornormalize(var_03),vectornormalize(param_01 - param_00)) > cos(var_05))
	{
		return 1;
	}

	return 0;
}

//Function Number: 817
transient_load(param_00)
{
	loadtransient(param_00);
	while(!istransientloaded(param_00))
	{
		wait(0.1);
	}

	common_scripts\utility::flag_set(param_00 + "_loaded");
}

//Function Number: 818
transient_unload(param_00)
{
	unloadtransient(param_00);
	while(istransientloaded(param_00))
	{
		wait(0.1);
	}

	common_scripts\utility::flag_clear(param_00 + "_loaded");
}

//Function Number: 819
transient_init(param_00)
{
	common_scripts\utility::flag_init(param_00 + "_loaded");
}

//Function Number: 820
transient_switch(param_00,param_01)
{
	if(common_scripts\utility::flag(param_00 + "_loaded"))
	{
		transient_unload(param_00);
	}

	if(!common_scripts\utility::flag(param_01 + "_loaded"))
	{
		transient_load(param_01);
	}
}

//Function Number: 821
transient_unloadall_and_load(param_00)
{
	unloadalltransients();
	transient_load(param_00);
}

//Function Number: 822
deep_array_call(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		foreach(var_04 in param_00)
		{
			if(isdefined(var_04))
			{
				if(isarray(var_04))
				{
					deep_array_call(var_04,param_01);
					continue;
				}

				var_04 [[ param_01 ]]();
			}
		}

		return;
	}

	switch(var_05.size)
	{
		case 0:
			break;

		case 1:
			break;

		case 2:
			break;

		case 3:
			break;

		case 4:
			break;

		case 5:
			break;
	}
}

//Function Number: 823
deep_array_thread(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		foreach(var_04 in param_00)
		{
			if(isdefined(var_04))
			{
				if(isarray(var_04))
				{
					deep_array_thread(var_04,param_01,param_02);
					continue;
				}

				var_04 thread [[ param_01 ]]();
			}
		}

		return;
	}

	switch(var_05.size)
	{
		case 0:
			break;

		case 1:
			break;

		case 2:
			break;

		case 3:
			break;

		case 4:
			break;

		case 5:
			break;
	}
}

//Function Number: 824
setdvar_cg_ng(param_00,param_01,param_02)
{
	if(!isdefined(level.console))
	{
		set_console_status();
	}

	if(is_gen4())
	{
		setdvar(param_00,param_02);
		return;
	}

	setdvar(param_00,param_01);
}

//Function Number: 825
setsaveddvar_cg_ng(param_00,param_01,param_02)
{
	if(!isdefined(level.console))
	{
		set_console_status();
	}

	if(is_gen4())
	{
		setsaveddvar(param_00,param_02);
		return;
	}

	setsaveddvar(param_00,param_01);
}

//Function Number: 826
follow_path_and_animate(param_00,param_01)
{
	self endon("death");
	self endon("stop_path");
	self notify("stop_going_to_node");
	self notify("follow_path");
	self endon("follow_path");
	wait(0.1);
	var_02 = param_00;
	var_03 = undefined;
	var_04 = undefined;
	if(!isdefined(param_01))
	{
		param_01 = 300;
	}

	self.current_follow_path = var_02;
	var_02 script_delay();
	if(isdefined(var_02))
	{
		self.current_follow_path = var_02;
		if(isdefined(var_02.lookahead))
		{
			break;
		}

		if(isdefined(level.struct_class_names["targetname"][var_02.targetname]))
		{
			var_04 = ::follow_path_animate_set_struct;
		}
		else if(isdefined(var_02.classname))
		{
			var_04 = ::follow_path_animate_set_ent;
		}
		else
		{
			var_04 = ::follow_path_animate_set_node;
		}

		if(isdefined(var_02.radius) && var_02.radius != 0)
		{
			self.goalradius = var_02.radius;
		}

		if(self.goalradius < 16)
		{
			self.goalradius = 16;
		}

		if(isdefined(var_02.height) && var_02.height != 0)
		{
			self.goalheight = var_02.height;
		}

		var_05 = self.goalradius;
		self childthread [[ var_04 ]](var_02);
		if(isdefined(var_02.animation))
		{
			var_02 waittill(var_02.animation);
		}
		else
		{
			for(;;)
			{
				self waittill("goal");
				if(distance(var_02.origin,self.origin) < var_05 + 10 || self.team != "allies")
				{
					break;
				}
			}
		}

		var_02 notify("trigger",self);
		if(isdefined(var_02.script_flag_set))
		{
			common_scripts\utility::flag_set(var_02.script_flag_set);
		}

		if(isdefined(var_02.script_parameters))
		{
			var_06 = strtok(var_02.script_parameters," ");
			var_07 = 0;
			if(var_07 < var_06.size)
			{
				if(isdefined(level.custom_followpath_parameter_func))
				{
					self [[ level.custom_followpath_parameter_func ]](var_06[var_07],var_02);
				}

				if(self.type == "dog")
				{
					continue;
				}

				switch(var_06[var_07])
				{
					case "enable_cqb":
						break;

					case "disable_cqb":
						break;

					case "deleteme":
						break;
				}
			}
		}
	}
}

//Function Number: 827
follow_path_wait_for_player(param_00,param_01)
{
	if(distance(level.player.origin,param_00.origin) < distance(self.origin,param_00.origin))
	{
		return 1;
	}

	var_02 = undefined;
	var_02 = anglestoforward(self.angles);
	var_03 = vectornormalize(level.player.origin - self.origin);
	if(isdefined(param_00.target))
	{
		var_04 = common_scripts\utility::get_target_ent(param_00.target);
		var_02 = vectornormalize(var_04.origin - param_00.origin);
	}
	else if(isdefined(param_00.angles))
	{
		var_02 = anglestoforward(param_00.angles);
	}
	else
	{
		var_02 = anglestoforward(self.angles);
	}

	if(vectordot(var_02,var_03) > 0)
	{
		return 1;
	}

	if(distance(level.player.origin,self.origin) < param_01)
	{
		return 1;
	}

	return 0;
}

//Function Number: 828
follow_path_animate_set_node(param_00)
{
	self notify("follow_path_new_goal");
	if(isdefined(param_00.animation))
	{
		param_00 maps\_anim::anim_generic_reach(self,param_00.animation);
		self notify("starting_anim",param_00.animation);
		if(isdefined(param_00.script_parameters) && issubstr(param_00.script_parameters,"gravity"))
		{
			param_00 maps\_anim::anim_generic_gravity(self,param_00.animation);
		}
		else
		{
			param_00 maps\_anim::anim_generic_run(self,param_00.animation);
		}

		self setgoalpos(self.origin);
		return;
	}

	set_goal_node(param_00);
}

//Function Number: 829
follow_path_animate_set_ent(param_00)
{
	self notify("follow_path_new_goal");
	if(isdefined(param_00.animation))
	{
		param_00 maps\_anim::anim_generic_reach(self,param_00.animation);
		self notify("starting_anim",param_00.animation);
		if(isdefined(param_00.script_parameters) && issubstr(param_00.script_parameters,"gravity"))
		{
			param_00 maps\_anim::anim_generic_gravity(self,param_00.animation);
		}
		else
		{
			param_00 maps\_anim::anim_generic_run(self,param_00.animation);
		}

		self setgoalpos(self.origin);
		return;
	}

	set_goal_ent(param_00);
}

//Function Number: 830
follow_path_animate_set_struct(param_00)
{
	self notify("follow_path_new_goal");
	if(isdefined(param_00.animation))
	{
		param_00 maps\_anim::anim_generic_reach(self,param_00.animation);
		self notify("starting_anim",param_00.animation);
		disable_exits();
		if(isdefined(param_00.script_parameters) && issubstr(param_00.script_parameters,"gravity"))
		{
			param_00 maps\_anim::anim_generic_gravity(self,param_00.animation);
		}
		else
		{
			param_00 maps\_anim::anim_generic_run(self,param_00.animation);
		}

		delaythread(0.05,::enable_exits);
		self setgoalpos(self.origin);
		return;
	}

	set_goal_pos(param_00.origin);
}

//Function Number: 831
post_load_precache(param_00)
{
	if(!isdefined(level.post_load_funcs))
	{
		level.post_load_funcs = [];
	}

	level.post_load_funcs = common_scripts\utility::array_add(level.post_load_funcs,param_00);
}

//Function Number: 832
game_is_current_gen()
{
	if(level.xenon)
	{
		return 1;
	}

	if(level.ps3)
	{
		return 1;
	}

	return 0;
}

//Function Number: 833
lerpfov_saved(param_00,param_01)
{
	thread lerpfov_saved_thread(param_00,param_01);
}

//Function Number: 834
lerpfov_saved_thread(param_00,param_01)
{
	self notify("new_lerp_Fov_Saved");
	self endon("new_lerp_Fov_Saved");
	self lerpfov(param_00,param_01);
	wait(param_01);
	setsaveddvar("cg_fov",param_00);
}

//Function Number: 835
getdvarfloatdefault(param_00,param_01)
{
	var_02 = getdvar(param_00);
	if(var_02 != "")
	{
		return float(var_02);
	}

	return param_01;
}

//Function Number: 836
getdvarintdefault(param_00,param_01)
{
	var_02 = getdvar(param_00);
	if(var_02 != "")
	{
		return int(var_02);
	}

	return param_01;
}

//Function Number: 837
ui_action_slot_force_active_on(param_00)
{
	var_01 = "ui_actionslot_" + param_00 + "_forceActive";
	setdvar(var_01,"on");
}

//Function Number: 838
ui_action_slot_force_active_off(param_00)
{
	var_01 = "ui_actionslot_" + param_00 + "_forceActive";
	setdvar(var_01,"turn_off");
}

//Function Number: 839
ui_action_slot_force_active_one_time(param_00)
{
	var_01 = "ui_actionslot_" + param_00 + "_forceActive";
	setdvar(var_01,"onetime");
}

//Function Number: 840
hastag(param_00,param_01)
{
	var_02 = getnumparts(param_00);
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		if(tolower(getpartname(param_00,var_03)) == tolower(param_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 841
stylized_center_text(param_00,param_01,param_02,param_03)
{
	if(!isarray(param_00))
	{
		param_00 = [param_00];
	}

	var_04 = 320;
	var_05 = 200;
	var_06 = [];
	foreach(var_0A, var_08 in param_00)
	{
		var_09 = maps\_introscreen::stylized_line(var_08,param_01,var_04,var_05 + var_0A * 20,"center",param_02,param_03);
		var_06 = common_scripts\utility::array_combine(var_09,var_06);
	}

	wait(param_01);
	maps\_introscreen::stylized_fadeout(var_06,var_04,var_05,param_00.size);
}

//Function Number: 842
center_screen_text(param_00)
{
	thread maps\_introscreen::center_screen_lines(param_00);
}

//Function Number: 843
enable_s1_motionset(param_00)
{
	if(!s1_motionset_avaliable())
	{
		return;
	}

	if(isdefined(self.mech) && self.mech)
	{
		return;
	}

	if(!level.nextgen)
	{
		return;
	}

	if(isdefined(param_00) && param_00)
	{
		if(!isdefined(self.animarchetype) || self.animarchetype == "soldier")
		{
			self.animarchetype = "s1_soldier";
			return;
		}

		return;
	}

	if(!isdefined(self.animarchetype) || self.animarchetype == "s1_soldier")
	{
		self.animarchetype = "soldier";
	}
}

//Function Number: 844
s1_motionset_avaliable()
{
	if(level.nextgen)
	{
		return 1;
	}

	return 0;
}

//Function Number: 845
ai_ignore_everything()
{
	if(isdefined(self.script_drone))
	{
		return;
	}

	if(isdefined(self._ignore_settings_old))
	{
		ai_unignore_everything();
	}

	self._ignore_settings_old = [];
	self.disableplayeradsloscheck = maps\_utility_code::ai_save_ignore_setting(self.disableplayeradsloscheck,"disableplayeradsloscheck",1);
	self.ignoreall = maps\_utility_code::ai_save_ignore_setting(self.ignoreall,"ignoreall",1);
	self.ignoreme = maps\_utility_code::ai_save_ignore_setting(self.ignoreme,"ignoreme",1);
	self.grenadeawareness = maps\_utility_code::ai_save_ignore_setting(self.grenadeawareness,"grenadeawareness",0);
	self.badplaceawareness = maps\_utility_code::ai_save_ignore_setting(self.badplaceawareness,"badplaceawareness",0);
	self.ignoreexplosionevents = maps\_utility_code::ai_save_ignore_setting(self.ignoreexplosionevents,"ignoreexplosionevents",1);
	self.ignorerandombulletdamage = maps\_utility_code::ai_save_ignore_setting(self.ignorerandombulletdamage,"ignorerandombulletdamage",1);
	self.ignoresuppression = maps\_utility_code::ai_save_ignore_setting(self.ignoresuppression,"ignoresuppression",1);
	self.dontavoidplayer = maps\_utility_code::ai_save_ignore_setting(self.dontavoidplayer,"dontavoidplayer",1);
	self.newenemyreactiondistsq = maps\_utility_code::ai_save_ignore_setting(self.newenemyreactiondistsq,"newEnemyReactionDistSq",0);
	self.disablebulletwhizbyreaction = maps\_utility_code::ai_save_ignore_setting(self.disablebulletwhizbyreaction,"disableBulletWhizbyReaction",1);
	self.disablefriendlyfirereaction = maps\_utility_code::ai_save_ignore_setting(self.disablefriendlyfirereaction,"disableFriendlyFireReaction",1);
	self.dontmelee = maps\_utility_code::ai_save_ignore_setting(self.dontmelee,"dontMelee",1);
	self.flashbangimmunity = maps\_utility_code::ai_save_ignore_setting(self.flashbangimmunity,"flashBangImmunity",1);
	self.dodangerreact = maps\_utility_code::ai_save_ignore_setting(self.dodangerreact,"doDangerReact",0);
	self.neversprintforvariation = maps\_utility_code::ai_save_ignore_setting(self.neversprintforvariation,"neverSprintForVariation",1);
	self.a.disablepain = maps\_utility_code::ai_save_ignore_setting(self.a.disablepain,"a.disablePain",1);
	self.allowpain = maps\_utility_code::ai_save_ignore_setting(self.allowpain,"allowPain",0);
	self.fixednode = maps\_utility_code::ai_save_ignore_setting(self.fixednode,"fixedNode",1);
	self.script_forcegoal = maps\_utility_code::ai_save_ignore_setting(self.script_forcegoal,"script_forcegoal",1);
	self.goalradius = maps\_utility_code::ai_save_ignore_setting(self.goalradius,"goalradius",5);
	disable_ai_color();
}

//Function Number: 846
ai_unignore_everything(param_00)
{
	if(isdefined(self.script_drone))
	{
		return;
	}

	if(isdefined(param_00) && param_00)
	{
		if(isdefined(self._ignore_settings_old))
		{
			self._ignore_settings_old = undefined;
		}
	}

	self.disableplayeradsloscheck = maps\_utility_code::ai_restore_ignore_setting("disableplayeradsloscheck",0);
	self.ignoreall = maps\_utility_code::ai_restore_ignore_setting("ignoreall",0);
	self.ignoreme = maps\_utility_code::ai_restore_ignore_setting("ignoreme",0);
	self.grenadeawareness = maps\_utility_code::ai_restore_ignore_setting("grenadeawareness",1);
	self.badplaceawareness = maps\_utility_code::ai_restore_ignore_setting("badplaceawareness",1);
	self.ignoreexplosionevents = maps\_utility_code::ai_restore_ignore_setting("ignoreexplosionevents",0);
	self.ignorerandombulletdamage = maps\_utility_code::ai_restore_ignore_setting("ignorerandombulletdamage",0);
	self.ignoresuppression = maps\_utility_code::ai_restore_ignore_setting("ignoresuppression",0);
	self.dontavoidplayer = maps\_utility_code::ai_restore_ignore_setting("dontavoidplayer",0);
	self.newenemyreactiondistsq = maps\_utility_code::ai_restore_ignore_setting("newEnemyReactionDistSq",262144);
	self.disablebulletwhizbyreaction = maps\_utility_code::ai_restore_ignore_setting("disableBulletWhizbyReaction",undefined);
	self.disablefriendlyfirereaction = maps\_utility_code::ai_restore_ignore_setting("disableFriendlyFireReaction",undefined);
	self.dontmelee = maps\_utility_code::ai_restore_ignore_setting("dontMelee",undefined);
	self.flashbangimmunity = maps\_utility_code::ai_restore_ignore_setting("flashBangImmunity",undefined);
	self.dodangerreact = maps\_utility_code::ai_restore_ignore_setting("doDangerReact",1);
	self.neversprintforvariation = maps\_utility_code::ai_restore_ignore_setting("neverSprintForVariation",undefined);
	self.a.disablepain = maps\_utility_code::ai_restore_ignore_setting("a.disablePain",0);
	self.allowpain = maps\_utility_code::ai_restore_ignore_setting("allowPain",1);
	self.fixednode = maps\_utility_code::ai_restore_ignore_setting("fixedNode",0);
	self.script_forcegoal = maps\_utility_code::ai_restore_ignore_setting("script_forcegoal",0);
	self.goalradius = maps\_utility_code::ai_restore_ignore_setting("goalradius",100);
	enable_ai_color();
	self._ignore_settings_old = undefined;
}

//Function Number: 847
attach_player_current_weapon_to_anim_tag(param_00)
{
	var_01 = level.player getcurrentweapon();
	var_02 = getweaponandattachmentmodels(var_01);
	var_03 = var_02[0]["weapon"];
	var_04 = array_remove_index(var_02,0);
	self attach(var_03,param_00,1);
	foreach(var_06 in var_04)
	{
		self attach(var_06["attachment"],var_06["attachTag"]);
	}

	self hideweapontags(var_01);
}

//Function Number: 848
playerallowalternatemelee(param_00,param_01)
{
	_playerallow("altmelee",param_00,param_01,::_allowalternatemelee,0);
}

//Function Number: 849
_allowalternatemelee(param_00)
{
	if(param_00)
	{
		self enablealternatemelee();
		return;
	}

	self disablealternatemelee();
}

//Function Number: 850
playerallowweaponpickup(param_00,param_01)
{
	_playerallow("weaponPickup",param_00,param_01,::_allowweaponpickup,0);
}

//Function Number: 851
_allowweaponpickup(param_00)
{
	if(param_00)
	{
		self enableweaponpickup();
		return;
	}

	self disableweaponpickup();
}

//Function Number: 852
_playerallow(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(self.playerdisableabilitytypes))
	{
		self.playerdisableabilitytypes = [];
	}

	if(!isdefined(self.playerdisableabilitytypes[param_00]))
	{
		self.playerdisableabilitytypes[param_00] = [];
	}

	if(!isdefined(param_02))
	{
		param_02 = "default";
	}

	if(param_01)
	{
		self.playerdisableabilitytypes[param_00] = common_scripts\utility::array_remove(self.playerdisableabilitytypes[param_00],param_02);
		if(!self.playerdisableabilitytypes[param_00].size)
		{
			if(!isdefined(param_04) || param_04)
			{
				self [[ param_03 ]](1);
				return;
			}

			self [[ param_03 ]](1);
			return;
		}

		return;
	}

	if(!isdefined(common_scripts\utility::array_find(self.playerdisableabilitytypes[param_00],param_02)))
	{
		self.playerdisableabilitytypes[param_00] = common_scripts\utility::array_add(self.playerdisableabilitytypes[param_00],param_02);
	}

	if(!isdefined(param_04) || param_04)
	{
		self [[ param_03 ]](0);
		return;
	}

	self [[ param_03 ]](0);
}

//Function Number: 853
pretend_to_be_dead()
{
	if(!isalive(self))
	{
		return;
	}

	self.pretending_to_be_dead = 1;
	self setthreatdetection("disable");
	self disableaimassist();
	self.ignoreme = 1;
	self.ignoresonicaoe = 1;
}

//Function Number: 854
tff_sync_setup()
{
	precacheshader("loading_animation");
	common_scripts\utility::flag_init("tff_sync_complete");
	maps\_utility_code::_tff_sync_triggers();
}

//Function Number: 855
tff_sync(param_00)
{
	if(isdefined(param_00))
	{
		wait(param_00);
	}

	if(aretransientsbusy())
	{
		common_scripts\utility::flag_clear("tff_sync_complete");
		synctransients();
		while(aretransientsbusy())
		{
			wait(0.05);
		}

		common_scripts\utility::flag_set("tff_sync_complete");
	}
}

//Function Number: 856
tff_sync_notetrack(param_00,param_01)
{
	tff_sync(param_01);
}

//Function Number: 857
logbreadcrumbdatasp()
{
	level.player endon("death");
	for(;;)
	{
		var_00 = getspcheckpointdata();
		var_01 = var_00[4];
		var_02 = gettime();
		recordbreadcrumbdataforplayersp(level.player,var_01,var_02);
		wait(2);
	}
}