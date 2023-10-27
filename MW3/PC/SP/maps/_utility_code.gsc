/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_utility_code.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 80
 * Decompile Time: 1611 ms
 * Timestamp: 10/27/2023 2:21:48 AM
*******************************************************************/

//Function Number: 1
linetime_proc(param_00,param_01,param_02,param_03)
{
	for(var_04 = 0;var_04 < param_03 * 20;var_04++)
	{
		wait 0.05;
	}
}

//Function Number: 2
structarray_swap(param_00,param_01)
{
	var_02 = param_00.struct_array_index;
	var_03 = param_01.struct_array_index;
	self.array[var_03] = param_00;
	self.array[var_02] = param_01;
	self.array[var_02].struct_array_index = var_02;
	self.array[var_03].struct_array_index = var_03;
}

//Function Number: 3
waitspread_code(param_00,param_01)
{
	waittillframeend;
	var_02 = [];
	if(level.wait_spreaders == 1)
	{
		level.wait_spreader_allotment = var_7B;
		level.active_wait_spread = undefined;
		return;
	}

	var_03 = 1;
	while(var_03 < level.wait_spreaders - 1)
	{
		var_7B = waitspread_insert(var_7B);
		var_03++ = var_7B[var_7B.size];
	}

	level.wait_spreader_allotment = maps\_utility::array_randomize(var_7B);
	level.active_wait_spread = undefined;
}

//Function Number: 4
waitspread_insert(param_00)
{
	var_01 = -1;
	var_02 = 0;
	for(var_03 = 0;var_03 < param_00.size - 1;var_03++)
	{
		var_04 = param_00[var_03 + 1] - param_00[var_03];
		if(var_04 <= var_02)
		{
			continue;
		}

		var_02 = var_04;
		var_01 = var_03;
	}

	var_05 = [];
	for(var_06 = 0;var_06 < param_00.size;var_06++)
	{
		if(var_01 == var_06 - 1)
		{
			var_05[var_05.size] = randomfloatrange(param_00[var_01],param_00[var_01 + 1]);
		}

		var_05[var_05.size] = param_00[var_06];
	}

	return var_05;
}

//Function Number: 5
waittill_objective_event_proc(param_00)
{
	while(level.deathspawner[self.script_deathchain] > 0)
	{
		level waittill("spawner_expired" + self.script_deathchain);
	}

	if(param_00)
	{
		self waittill("trigger");
	}

	var_01 = maps\_utility::get_trigger_flag();
	common_scripts\utility::flag_set(var_01);
}

//Function Number: 6
wait_until_done_speaking()
{
	self endon("death");
	while(self.isspeaking)
	{
		wait 0.05;
	}
}

//Function Number: 7
wait_for_trigger_think(param_00)
{
	self endon("death");
	param_00 endon("trigger");
	self waittill("trigger");
	param_00 notify("trigger");
}

//Function Number: 8
wait_for_trigger(param_00,param_01)
{
	var_02 = getentarray(param_00,param_01);
	var_03 = spawnstruct();
	common_scripts\utility::array_thread(var_02,::wait_for_trigger_think,var_03);
	var_03 waittill("trigger");
}

//Function Number: 9
ent_waits_for_level_notify(param_00)
{
	level waittill(param_00);
	self notify("done");
}

//Function Number: 10
ent_waits_for_notify(param_00,param_01)
{
	param_00 waittill(param_01);
	self notify("done");
}

//Function Number: 11
ent_waits_for_trigger(param_00)
{
	param_00 waittill("trigger");
	self notify("done");
}

//Function Number: 12
ent_times_out(param_00)
{
	wait param_00;
	self notify("done");
}

//Function Number: 13
update_debug_friendlycolor_on_death()
{
	self notify("debug_color_update");
	self endon("debug_color_update");
	var_00 = self.unique_id;
	self waittill("death");
	level.debug_color_friendlies[var_00] = undefined;
	level notify("updated_color_friendlies");
}

//Function Number: 14
update_debug_friendlycolor(param_00)
{
	thread update_debug_friendlycolor_on_death();
	if(isdefined(self.script_forcecolor))
	{
		level.debug_color_friendlies[param_00] = self.script_forcecolor;
	}
	else
	{
		level.debug_color_friendlies[param_00] = undefined;
	}

	level notify("updated_color_friendlies");
}

//Function Number: 15
insure_player_does_not_set_forcecolor_twice_in_one_frame()
{
}

//Function Number: 16
new_color_being_set(param_00)
{
	self notify("new_color_being_set");
	self.new_force_color_being_set = 1;
	maps\_colors::left_color_node();
	self endon("new_color_being_set");
	self endon("death");
	waittillframeend;
	waittillframeend;
	if(isdefined(self.script_forcecolor))
	{
		self.currentcolorcode = level.currentcolorforced[maps\_colors::get_team()][self.script_forcecolor];
		if(isdefined(self.dontcolormove))
		{
			self.dontcolormove = undefined;
		}
		else
		{
			thread maps\_colors::goto_current_colorindex();
		}
	}

	self.new_force_color_being_set = undefined;
	self notify("done_setting_new_color");
}

//Function Number: 17
radio_queue_thread(param_00)
{
	var_01 = gettime();
	for(;;)
	{
		if(!isdefined(self._radio_queue))
		{
			break;
		}

		self waittill("finished_radio");
		if(gettime() > var_01 + 7500)
		{
			return;
		}
	}

	self._radio_queue = 1;
	maps\_utility::wait_for_buffer_time_to_pass(level.last_mission_sound_time,0.5);
	level.player maps\_utility::play_sound_on_entity(level.scr_radio[param_00]);
	self._radio_queue = undefined;
	level.last_mission_sound_time = gettime();
	self notify("finished_radio");
}

//Function Number: 18
ent_wait_for_flag_or_time_elapses(param_00,param_01)
{
	self endon(param_00);
	wait param_01;
}

//Function Number: 19
waittill_either_function_internal(param_00,param_01,param_02)
{
	param_00 endon("done");
	[[ param_01 ]](param_02);
	param_00 notify("done");
}

//Function Number: 20
hintprintwait(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		wait param_00;
		return;
	}

	var_02 = param_00 * 20;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		if([[ param_01 ]]())
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 21
hint_timeout(param_00)
{
	wait param_00;
	self.timed_out = 1;
}

//Function Number: 22
hintprint(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isalive(self))
	{
		return;
	}

	var_06 = 1;
	var_07 = 0.75;
	var_08 = 0.95;
	var_09 = 0.4;
	var_0A = 2;
	if(isdefined(level.hint_fontscale))
	{
		var_0A = level.hint_fontscale;
	}

	if(isdefined(self.current_global_hint))
	{
		if(self.current_global_hint == param_00)
		{
			return;
		}
	}

	maps\_utility::ent_flag_waitopen("global_hint_in_use");
	if(isdefined(self.current_global_hint))
	{
		if(self.current_global_hint == param_00)
		{
			return;
		}
	}

	maps\_utility::ent_flag_set("global_hint_in_use");
	self.current_global_hint = param_00;
	var_0B = maps\_hud_util::createclientfontstring("default",var_0A);
	level.current_hint = var_0B;
	thread destroy_hint_on_friendlyfire(var_0B);
	level endon("friendlyfire_mission_fail");
	var_0B.alpha = 0.9;
	var_0B.x = 0;
	var_0B.y = -68;
	var_0B.alignx = "center";
	var_0B.aligny = "middle";
	var_0B.horzalign = "center";
	var_0B.vertalign = "middle";
	var_0B.foreground = 0;
	var_0B.hidewhendead = 1;
	var_0B.hidewheninmenu = 1;
	var_0B settext(param_00);
	var_0B.alpha = 0;
	var_0B fadeovertime(var_06);
	var_0B.alpha = var_08;
	hintprintwait(var_06,param_01);
	var_0C = 0;
	if(isdefined(param_04))
	{
		var_0C = 3;
	}
	else if(isdefined(param_03))
	{
		var_0C = 2;
	}
	else if(isdefined(param_02))
	{
		var_0C = 1;
	}

	var_0D = spawnstruct();
	var_0D.timed_out = 0;
	if(isdefined(param_05))
	{
		var_0D thread hint_timeout(param_05);
	}

	if(isdefined(param_01))
	{
		for(;;)
		{
			var_0B fadeovertime(var_07);
			var_0B.alpha = var_09;
			hintprintwait(var_07,param_01);
			if(var_0C == 3)
			{
				if([[ param_01 ]](param_02,param_03,param_04))
				{
					break;
				}
			}
			else if(var_0C == 2)
			{
				if([[ param_01 ]](param_02,param_03))
				{
					break;
				}
			}
			else if(var_0C == 1)
			{
				if([[ param_01 ]](param_02))
				{
					break;
				}
			}
			else if([[ param_01 ]]())
			{
				break;
			}

			var_0B fadeovertime(var_07);
			var_0B.alpha = var_08;
			hintprintwait(var_07,param_01);
			if(var_0D.timed_out)
			{
				break;
			}

			if(var_0C == 3)
			{
				if([[ param_01 ]](param_02,param_03,param_04))
				{
					break;
				}

				continue;
			}

			if(var_0C == 2)
			{
				if([[ param_01 ]](param_02,param_03))
				{
					break;
				}

				continue;
			}

			if(var_0C == 1)
			{
				if([[ param_01 ]](param_02))
				{
					break;
				}

				continue;
			}

			if([[ param_01 ]]())
			{
				break;
			}
		}
	}
	else
	{
		for(var_0E = 0;var_0E < 1;var_0E++)
		{
			var_0B fadeovertime(var_07);
			var_0B.alpha = var_09;
			hintprintwait(var_07,param_01);
			var_0B fadeovertime(var_07);
			var_0B.alpha = var_08;
			hintprintwait(var_07,param_01);
		}
	}

	var_0B notify("destroying");
	self.current_global_hint = undefined;
	var_0B destroy();
	level.current_hint = undefined;
	maps\_utility::ent_flag_clear("global_hint_in_use");
}

//Function Number: 23
destroy_hint_on_friendlyfire(param_00)
{
	param_00 endon("destroying");
	level waittill("friendlyfire_mission_fail");
	if(!isdefined(param_00))
	{
		return;
	}

	self.current_global_hint = undefined;
	param_00 destroy();
	maps\_utility::ent_flag_clear("global_hint_in_use");
}

//Function Number: 24
showhintprint_struct(param_00)
{
	param_00.timed_out = 0;
	if(!isalive(self))
	{
		return;
	}

	var_01 = 1;
	var_02 = 0.75;
	var_03 = 0.95;
	var_04 = 0.4;
	maps\_utility::ent_flag_waitopen("global_hint_in_use");
	maps\_utility::ent_flag_set("global_hint_in_use");
	if(param_00.timed_out)
	{
		return;
	}

	if(isdefined(param_00.timeout))
	{
		param_00 thread hint_timeout(param_00.timeout);
	}

	var_05 = maps\_hud_util::createclientfontstring("objective",2);
	var_05.alpha = 0.9;
	var_05.x = 0;
	var_05.y = -38;
	var_05.alignx = "center";
	var_05.aligny = "middle";
	var_05.horzalign = "center";
	var_05.vertalign = "middle";
	var_05.foreground = 0;
	var_05.hidewhendead = 1;
	var_05 settext(param_00.string);
	var_05.alpha = 0;
	var_05 fadeovertime(var_01);
	var_05.alpha = var_03;
	hintprintwait(var_01);
	for(;;)
	{
		var_05 fadeovertime(var_02);
		var_05.alpha = var_04;
		hintprintwait(var_02);
		if(param_00.timed_out)
		{
			break;
		}

		var_05 fadeovertime(var_02);
		var_05.alpha = var_03;
		hintprintwait(var_02);
		if(param_00.timed_out)
		{
			break;
		}
	}

	var_05 destroy();
	maps\_utility::ent_flag_clear("global_hint_in_use");
}

//Function Number: 25
lerp_player_view_to_tag_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isdefined(self.first_frame_time) && self.first_frame_time == gettime())
	{
		wait 0.1;
	}

	var_09 = self gettagorigin(param_01);
	var_0A = self gettagangles(param_01);
	param_00 maps\_utility::lerp_player_view_to_position(var_09,var_0A,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	if(param_08)
	{
		return;
	}

	param_00 playerlinkto(self,param_01,param_03,param_04,param_05,param_06,param_07,0);
}

//Function Number: 26
lerp_player_view_to_tag_oldstyle_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isdefined(self.first_frame_time) && self.first_frame_time == gettime())
	{
		wait 0.1;
	}

	var_09 = self gettagorigin(param_01);
	var_0A = self gettagangles(param_01);
	param_00 maps\_utility::lerp_player_view_to_position_oldstyle(var_09,var_0A,param_02,param_03,param_04,param_05,param_06,param_07,1);
	if(param_08)
	{
		return;
	}

	param_00 playerlinktodelta(self,param_01,param_03,param_04,param_05,param_06,param_07,0);
}

//Function Number: 27
function_stack_wait(param_00)
{
	self endon("death");
	param_00 common_scripts\utility::waittill_either("function_done","death");
}

//Function Number: 28
function_stack_wait_finish(param_00)
{
	function_stack_wait(param_00);
	if(!isdefined(self))
	{
		return 0;
	}

	if(!issentient(self))
	{
		return 1;
	}

	if(isalive(self))
	{
		return 1;
	}

	return 0;
}

//Function Number: 29
function_stack_proc(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	if(!isdefined(param_00.function_stack))
	{
		param_00.function_stack = [];
	}

	param_00.function_stack[param_00.function_stack.size] = self;
	thread function_stack_self_death(param_00);
	function_stack_caller_waits_for_turn(param_00);
	if(isdefined(param_00) && isdefined(param_00.function_stack))
	{
		self.function_stack_func_begun = 1;
		self notify("function_stack_func_begun");
		if(isdefined(param_06))
		{
			param_00 [[ param_01 ]](param_02,param_03,param_04,param_05,param_06);
		}
		else if(isdefined(param_05))
		{
			param_00 [[ param_01 ]](param_02,param_03,param_04,param_05);
		}
		else if(isdefined(param_04))
		{
			param_00 [[ param_01 ]](param_02,param_03,param_04);
		}
		else if(isdefined(param_03))
		{
			param_00 [[ param_01 ]](param_02,param_03);
		}
		else if(isdefined(param_02))
		{
			param_00 [[ param_01 ]](param_02);
		}
		else
		{
			param_00 [[ param_01 ]]();
		}

		if(isdefined(param_00) && isdefined(param_00.function_stack))
		{
			param_00.function_stack = common_scripts\utility::array_remove(param_00.function_stack,self);
			param_00 notify("level_function_stack_ready");
		}
	}

	if(isdefined(self))
	{
		self.function_stack_func_begun = 0;
		self notify("function_done");
	}
}

//Function Number: 30
function_stack_self_death(param_00)
{
	self endon("function_done");
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00.function_stack = common_scripts\utility::array_remove(param_00.function_stack,self);
		param_00 notify("level_function_stack_ready");
	}
}

//Function Number: 31
function_stack_caller_waits_for_turn(param_00)
{
	param_00 endon("death");
	self endon("death");
	param_00 endon("clear_function_stack");
	while(param_00.function_stack[0] != self)
	{
		param_00 waittill("level_function_stack_ready");
	}
}

//Function Number: 32
unflash_flag(param_00)
{
	level endon("player_flashed");
	wait param_00;
	common_scripts\utility::flag_clear("player_flashed");
}

//Function Number: 33
wait_for_sounddone_or_death(param_00)
{
	self endon("death");
	param_00 waittill("sounddone");
	return 1;
}

//Function Number: 34
init_vision_set(param_00)
{
	level.var_13EE = param_00;
	if(!isdefined(level.vision_cheat_enabled))
	{
		level.vision_cheat_enabled = 0;
	}

	return level.vision_cheat_enabled;
}

//Function Number: 35
array_waitlogic1(param_00,param_01,param_02)
{
	array_waitlogic2(param_00,param_01,param_02);
	self._array_wait = 0;
	self notify("_array_wait");
}

//Function Number: 36
array_waitlogic2(param_00,param_01,param_02)
{
	param_00 endon(param_01);
	param_00 endon("death");
	if(isdefined(param_02))
	{
		wait param_02;
		return;
	}

	param_00 waittill(param_01);
}

//Function Number: 37
exec_call(param_00)
{
	if(param_00.parms.size == 0)
	{
		param_00.caller [[ param_00.func ]]();
	}
	else if(param_00.parms.size == 1)
	{
		param_00.caller [[ param_00.func ]](param_00.parms[0]);
	}
	else if(param_00.parms.size == 2)
	{
		param_00.caller [[ param_00.func ]](param_00.parms[0],param_00.parms[1]);
	}
	else if(param_00.parms.size == 3)
	{
		param_00.caller [[ param_00.func ]](param_00.parms[0],param_00.parms[1],param_00.parms[2]);
	}

	if(param_00.parms.size == 4)
	{
		param_00.caller [[ param_00.func ]](param_00.parms[0],param_00.parms[1],param_00.parms[2],param_00.parms[3]);
	}

	if(param_00.parms.size == 5)
	{
		param_00.caller [[ param_00.func ]](param_00.parms[0],param_00.parms[1],param_00.parms[2],param_00.parms[3],param_00.parms[4]);
	}
}

//Function Number: 38
exec_call_noself(param_00)
{
	if(param_00.parms.size == 0)
	{
		[[ param_00.func ]]();
	}
	else if(param_00.parms.size == 1)
	{
		[[ param_00.func ]](param_00.parms[0]);
	}
	else if(param_00.parms.size == 2)
	{
		[[ param_00.func ]](param_00.parms[0],param_00.parms[1]);
	}
	else if(param_00.parms.size == 3)
	{
		[[ param_00.func ]](param_00.parms[0],param_00.parms[1],param_00.parms[2]);
	}

	if(param_00.parms.size == 4)
	{
		[[ param_00.func ]](param_00.parms[0],param_00.parms[1],param_00.parms[2],param_00.parms[3]);
	}

	if(param_00.parms.size == 5)
	{
		[[ param_00.func ]](param_00.parms[0],param_00.parms[1],param_00.parms[2],param_00.parms[3],param_00.parms[4]);
	}
}

//Function Number: 39
exec_func(param_00,param_01)
{
	if(!isdefined(param_00.caller))
	{
		return;
	}

	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		param_01[var_02].caller endon(param_01[var_02].ender);
	}

	if(param_00.parms.size == 0)
	{
		param_00.caller [[ param_00.func ]]();
	}
	else if(param_00.parms.size == 1)
	{
		param_00.caller [[ param_00.func ]](param_00.parms[0]);
	}
	else if(param_00.parms.size == 2)
	{
		param_00.caller [[ param_00.func ]](param_00.parms[0],param_00.parms[1]);
	}
	else if(param_00.parms.size == 3)
	{
		param_00.caller [[ param_00.func ]](param_00.parms[0],param_00.parms[1],param_00.parms[2]);
	}

	if(param_00.parms.size == 4)
	{
		param_00.caller [[ param_00.func ]](param_00.parms[0],param_00.parms[1],param_00.parms[2],param_00.parms[3]);
	}

	if(param_00.parms.size == 5)
	{
		param_00.caller [[ param_00.func ]](param_00.parms[0],param_00.parms[1],param_00.parms[2],param_00.parms[3],param_00.parms[4]);
	}
}

//Function Number: 40
waittill_func_ends(param_00,param_01)
{
	self endon("all_funcs_ended");
	self endon("any_funcs_aborted");
	exec_func(param_00,param_01);
	self.count--;
	self notify("func_ended");
}

//Function Number: 41
waittill_abort_func_ends(param_00,param_01)
{
	self endon("all_funcs_ended");
	self endon("any_funcs_aborted");
	exec_func(param_00,param_01);
	self.abort_count--;
	self notify("abort_func_ended");
}

//Function Number: 42
do_abort(param_00)
{
	self endon("all_funcs_ended");
	if(!param_00.size)
	{
		return;
	}

	var_01 = 0;
	self.abort_count = param_00.size;
	var_02 = [];
	common_scripts\utility::array_levelthread(param_00,::waittill_abort_func_ends,var_02);
	for(;;)
	{
		if(self.abort_count <= var_01)
		{
			break;
		}

		self waittill("abort_func_ended");
	}

	self notify("any_funcs_aborted");
}

//Function Number: 43
translate_local_on_ent(param_00)
{
	if(isdefined(self.forward))
	{
		var_01 = anglestoforward(param_00.angles);
		param_00.origin = param_00.origin + var_01 * self.forward;
	}

	if(isdefined(self.right))
	{
		var_02 = anglestoright(param_00.angles);
		param_00.origin = param_00.origin + var_02 * self.right;
	}

	if(isdefined(self.up))
	{
		var_03 = anglestoup(param_00.angles);
		param_00.origin = param_00.origin + var_03 * self.up;
	}

	if(isdefined(self.yaw))
	{
		param_00 addyaw(self.yaw);
	}

	if(isdefined(self.pitch))
	{
		param_00 addpitch(self.pitch);
	}

	if(isdefined(self.roll))
	{
		param_00 addroll(self.roll);
	}
}

//Function Number: 44
dynamic_run_speed_proc(param_00,param_01,param_02,param_03,param_04)
{
	self notify("start_dynamic_run_speed");
	self endon("death");
	self endon("stop_dynamic_run_speed");
	self endon("start_dynamic_run_speed");
	level endon("_stealth_spotted");
	if(maps\_utility::ent_flag_exist("_stealth_custom_anim"))
	{
		maps\_utility::ent_flag_waitopen("_stealth_custom_anim");
	}

	if(!maps\_utility::ent_flag_exist("dynamic_run_speed_stopped"))
	{
		maps\_utility::ent_flag_init("dynamic_run_speed_stopped");
		maps\_utility::ent_flag_init("dynamic_run_speed_stopping");
	}
	else
	{
		maps\_utility::ent_flag_clear("dynamic_run_speed_stopping");
		maps\_utility::ent_flag_clear("dynamic_run_speed_stopped");
	}

	self.run_speed_state = "";
	self.old_moveplaybackrate = self.moveplaybackrate;
	thread stop_dynamic_run_speed();
	var_05 = param_00 * param_00;
	var_06 = param_01 * param_01;
	var_07 = param_02 * param_02;
	var_08 = param_03 * param_03;
	for(;;)
	{
		wait 0.05;
		var_09 = level.players[0];
		foreach(var_0B in level.players)
		{
			if(distancesquared(var_09.origin,self.origin) > distancesquared(var_0B.origin,self.origin))
			{
				var_09 = var_0B;
			}
		}

		var_0D = anglestoforward(self.angles);
		var_0E = vectornormalize(var_09.origin - self.origin);
		var_0F = vectordot(var_0D,var_0E);
		var_10 = distancesquared(self.origin,var_09.origin);
		var_11 = var_10;
		if(isdefined(param_04))
		{
			var_12 = maps\_utility::getclosest(var_09.origin,param_04);
			var_11 = distancesquared(var_12.origin,var_09.origin);
		}

		var_13 = 0;
		if(isdefined(self.last_set_goalent))
		{
			var_13 = [[ level.drs_ahead_test ]](self.last_set_goalent,param_01);
		}
		else if(isdefined(self.last_set_goalnode))
		{
			var_13 = [[ level.drs_ahead_test ]](self.last_set_goalnode,param_01);
		}

		if(isdefined(self.cqbwalking) && self.cqbwalking && !self.dontchangemoveplaybackrate)
		{
			self.moveplaybackrate = 1;
		}

		if(var_10 < var_06 || var_0F > -0.25 || var_13)
		{
			dynamic_run_set("sprint");
			wait 0.5;
			continue;
		}
		else if(var_10 < var_05 || var_0F > -0.25)
		{
			dynamic_run_set("run");
			wait 0.5;
			continue;
		}
		else if(var_11 > var_07)
		{
			if(self.a.movement != "stop")
			{
				dynamic_run_set("stop");
				wait 0.5;
			}

			continue;
		}
		else if(var_10 > var_08)
		{
			dynamic_run_set("jog");
			wait 0.5;
			continue;
		}
	}
}

//Function Number: 45
stop_dynamic_run_speed()
{
	self endon("start_dynamic_run_speed");
	self endon("death");
	stop_dynamic_run_speed_wait();
	if(!self.dontchangemoveplaybackrate)
	{
		self.moveplaybackrate = self.old_moveplaybackrate;
	}

	if(isdefined(level.scr_anim["generic"]["DRS_run"]))
	{
		if(isarray(level.scr_anim["generic"]["DRS_run"]))
		{
			maps\_utility::set_generic_run_anim_array("DRS_run");
		}
		else
		{
			maps\_utility::set_generic_run_anim("DRS_run");
		}
	}
	else
	{
		maps\_utility::clear_run_anim();
	}

	self notify("stop_loop");
	maps\_utility::ent_flag_clear("dynamic_run_speed_stopping");
	maps\_utility::ent_flag_clear("dynamic_run_speed_stopped");
}

//Function Number: 46
stop_dynamic_run_speed_wait()
{
	level endon("_stealth_spotted");
	self waittill("stop_dynamic_run_speed");
}

//Function Number: 47
dynamic_run_ahead_test(param_00,param_01)
{
	if(!isdefined(param_00.classname))
	{
		if(!isdefined(param_00.type))
		{
			var_02 = ::maps\_spawner::get_target_structs;
		}
		else
		{
			var_02 = ::maps\_spawner::get_target_nodes;
		}
	}
	else
	{
		var_02 = ::maps\_spawner::get_target_ents;
	}

	return maps\_spawner::go_to_node_wait_for_player(param_00,var_02,param_01);
}

//Function Number: 48
dynamic_run_set(param_00)
{
	if(self.run_speed_state == param_00)
	{
		return;
	}

	self.run_speed_state = param_00;
	switch(param_00)
	{
		case "sprint":
			if(isdefined(self.cqbwalking) && self.cqbwalking && !self.dontchangemoveplaybackrate)
			{
				self.moveplaybackrate = 1;
			}
			else if(!self.dontchangemoveplaybackrate)
			{
				self.moveplaybackrate = 1.15;
			}
	
			if(isarray(level.scr_anim["generic"]["DRS_sprint"]))
			{
				maps\_utility::set_generic_run_anim_array("DRS_sprint");
			}
			else
			{
				maps\_utility::set_generic_run_anim("DRS_sprint");
			}
	
			self notify("stop_loop");
			maps\_utility::anim_stopanimscripted();
			maps\_utility::ent_flag_clear("dynamic_run_speed_stopped");
			break;

		case "run":
			if(!self.dontchangemoveplaybackrate)
			{
				self.moveplaybackrate = self.old_moveplaybackrate;
			}
	
			if(isdefined(level.scr_anim["generic"]["DRS_run"]))
			{
				if(isarray(level.scr_anim["generic"]["DRS_run"]))
				{
					maps\_utility::set_generic_run_anim_array("DRS_run");
				}
				else
				{
					maps\_utility::set_generic_run_anim("DRS_run");
				}
			}
			else
			{
				maps\_utility::clear_run_anim();
			}
	
			self notify("stop_loop");
			maps\_utility::anim_stopanimscripted();
			maps\_utility::ent_flag_clear("dynamic_run_speed_stopped");
			break;

		case "stop":
			thread dynamic_run_speed_stopped();
			break;

		case "jog":
			if(!self.dontchangemoveplaybackrate)
			{
				self.moveplaybackrate = self.old_moveplaybackrate;
			}
	
			if(isdefined(level.scr_anim["generic"]["DRS_combat_jog"]))
			{
				if(isarray(level.scr_anim["generic"]["DRS_combat_jog"]))
				{
					maps\_utility::set_generic_run_anim_array("DRS_combat_jog");
				}
				else
				{
					maps\_utility::set_generic_run_anim("DRS_combat_jog");
				}
			}
			else
			{
				maps\_utility::clear_run_anim();
			}
	
			self notify("stop_loop");
			maps\_utility::anim_stopanimscripted();
			maps\_utility::ent_flag_clear("dynamic_run_speed_stopped");
			break;

		case "crouch":
			break;
	}
}

//Function Number: 49
dynamic_run_speed_stopped()
{
	self endon("death");
	if(maps\_utility::ent_flag("dynamic_run_speed_stopped"))
	{
		return;
	}

	if(maps\_utility::ent_flag("dynamic_run_speed_stopping"))
	{
		return;
	}

	self endon("stop_dynamic_run_speed");
	maps\_utility::ent_flag_set("dynamic_run_speed_stopping");
	maps\_utility::ent_flag_set("dynamic_run_speed_stopped");
	self endon("dynamic_run_speed_stopped");
	var_00 = "DRS_run_2_stop";
	maps\_anim::anim_generic_custom_animmode(self,"gravity",var_00);
	maps\_utility::ent_flag_clear("dynamic_run_speed_stopping");
	if(isdefined(self.loops) && self.loops > 0)
	{
		return;
	}

	while(maps\_utility::ent_flag("dynamic_run_speed_stopped"))
	{
		var_01 = "DRS_stop_idle";
		thread maps\_anim::anim_generic_loop(self,var_01);
		if(isdefined(level.scr_anim["generic"]["signal_go"]))
		{
			maps\_utility::handsignal("go");
		}

		wait randomfloatrange(12,20);
		if(maps\_utility::ent_flag_exist("_stealth_stance_handler"))
		{
			maps\_utility::ent_flag_waitopen("_stealth_stance_handler");
		}

		self notify("stop_loop");
		if(!maps\_utility::ent_flag("dynamic_run_speed_stopped"))
		{
			return;
		}

		if(isdefined(level.dynamic_run_speed_dialogue))
		{
			var_02 = common_scripts\utility::random(level.dynamic_run_speed_dialogue);
			level thread maps\_utility::radio_dialogue_queue(var_02);
		}

		if(isdefined(level.scr_anim["generic"]["signal_go"]))
		{
			maps\_utility::handsignal("go");
		}
	}
}

//Function Number: 50
g_speed_get_func()
{
	return int(getdvar("g_speed"));
}

//Function Number: 51
g_speed_set_func(param_00)
{
	setsaveddvar("g_speed",int(param_00));
}

//Function Number: 52
movespeed_get_func()
{
	return self.movespeedscale;
}

//Function Number: 53
movespeed_set_func(param_00)
{
	self.movespeedscale = param_00;
	self setmovespeedscale(param_00);
}

//Function Number: 54
autosave_tactical_setup()
{
	if(common_scripts\utility::flag_exist("autosave_tactical_player_nade"))
	{
		return;
	}

	common_scripts\utility::flag_init("autosave_tactical_player_nade");
	level.autosave_tactical_player_nades = 0;
	notifyoncommand("autosave_player_nade","+frag");
	notifyoncommand("autosave_player_nade","-smoke");
	notifyoncommand("autosave_player_nade","+smoke");
	common_scripts\utility::array_thread(level.players,::autosave_tactical_grenade_check);
}

//Function Number: 55
autosave_tactical_grenade_check()
{
	for(;;)
	{
		self waittill("autosave_player_nade");
		common_scripts\utility::flag_set("autosave_tactical_player_nade");
		self waittill("grenade_fire",var_00);
		thread autosave_tactical_grenade_check_dieout(var_00);
	}
}

//Function Number: 56
autosave_tactical_grenade_check_dieout(param_00)
{
	level.autosave_tactical_player_nades++;
	param_00 common_scripts\utility::waittill_notify_or_timeout("death",10);
	level.autosave_tactical_player_nades--;
	waittillframeend;
	if(!level.autosave_tactical_player_nades)
	{
		common_scripts\utility::flag_clear("autosave_tactical_player_nade");
	}
}

//Function Number: 57
autosave_tactical_proc()
{
	level notify("autosave_tactical_proc");
	level endon("autosave_tactical_proc");
	level thread maps\_utility::notify_delay("kill_save",5);
	level endon("kill_save");
	level endon("autosave_tactical_player_nade");
	if(common_scripts\utility::flag("autosave_tactical_player_nade"))
	{
		common_scripts\utility::flag_waitopen_or_timeout("autosave_tactical_player_nade",4);
		if(common_scripts\utility::flag("autosave_tactical_player_nade"))
		{
			return;
		}
	}

	var_00 = getaiarray("axis");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.enemy) && isplayer(var_02.enemy))
		{
			return;
		}
	}

	waittillframeend;
	maps\_utility::autosave_by_name();
}

//Function Number: 58
music_play_internal_stop_with_fade_then_call(param_00,param_01,param_02,param_03)
{
	maps\_utility::music_stop(param_01);
	level endon("stop_music");
	wait param_01;
	thread maps\_utility::music_play(param_00,undefined,param_02,param_03);
}

//Function Number: 59
music_loop_internal_stop_with_fade_then_call(param_00,param_01,param_02,param_03,param_04,param_05)
{
	maps\_utility::music_stop(param_02);
	level endon("stop_music");
	wait param_02;
	thread music_loop_internal(param_00,param_01,undefined,param_03,param_04,param_05);
}

//Function Number: 60
music_loop_internal(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_02) && param_02 > 0)
	{
		thread music_loop_internal_stop_with_fade_then_call(param_00,param_01,param_02,param_03,param_04,param_05);
		return;
	}

	maps\_utility::music_stop();
	level endon("stop_music");
	maps\_utility::musicplaywrapper(param_00,param_03,param_04);
	if(isdefined(param_05) && param_05 == 1 && common_scripts\utility::flag_exist("_stealth_spotted"))
	{
		level endon("_stealth_spotted");
		thread music_loop_stealth_pause(param_00,param_01,param_02);
	}

	var_06 = maps\_utility::musiclength(param_00);
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(param_01 <= 10)
	{
		var_06 = var_06 + param_01;
	}

	wait var_06;
	maps\_utility::music_loop(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 61
music_loop_stealth_pause(param_00,param_01,param_02)
{
	level endon("stop_music");
	common_scripts\utility::flag_wait("_stealth_spotted");
	musicstop(0.5);
	while(common_scripts\utility::flag("_stealth_spotted"))
	{
		common_scripts\utility::flag_waitopen("_stealth_spotted");
		wait 1;
	}

	thread maps\_utility::music_loop(param_00,param_01,param_02);
}

//Function Number: 62
doslide(param_00,param_01,param_02)
{
	self endon("death");
	self endon("stop_sliding");
	var_03 = self;
	var_04 = undefined;
	for(;;)
	{
		var_05 = var_03 getnormalizedmovement();
		var_06 = anglestoforward(var_03.angles);
		var_07 = anglestoright(var_03.angles);
		var_05 = (var_05[1] * var_07[0] + var_05[0] * var_06[0],var_05[1] * var_07[1] + var_05[0] * var_06[1],0);
		param_00.slidevelocity = param_00.slidevelocity + var_05 * param_01;
		wait 0.05;
		param_00.slidevelocity = param_00.slidevelocity * 1 - param_02;
	}
}

//Function Number: 63
kill_deathflag_proc(param_00)
{
	self endon("death");
	if(isdefined(param_00))
	{
		wait randomfloat(param_00);
	}

	playfxontag(common_scripts\utility::getfx("flesh_hit"),self,"tag_eye");
	self kill(level.player.origin);
}

//Function Number: 64
update_rumble_intensity(param_00,param_01)
{
	self endon("death");
	var_02 = 0;
	for(;;)
	{
		if(self.intensity > 0.0001 && gettime() > 300)
		{
			if(!var_02)
			{
				self playrumblelooponentity(param_01);
				var_02 = 1;
			}
		}
		else if(var_02)
		{
			self stoprumble(param_01);
			var_02 = 0;
		}

		var_03 = 1 - self.intensity;
		var_03 = var_03 * 1000;
		self.origin = param_00 geteye() + (0,0,var_03);
		wait 0.05;
	}
}

//Function Number: 65
start_glow(param_00)
{
	var_01 = spawn("script_model",self.origin);
	self.glow_model = var_01;
	var_01.angles = self.angles;
	var_01 setmodel(param_00);
	var_01 endon("death");
	self waittill("death");
	var_01 delete();
}

//Function Number: 66
blend_default_dof(param_00,param_01,param_02)
{
	foreach(var_05, var_04 in level.dofdefault)
	{
		level.dofdefault[var_05] = param_01[var_05] * 1 - param_00 + param_02[var_05] * param_00;
	}
}

//Function Number: 67
process_blend(param_00,param_01,param_02,param_03,param_04)
{
	waittillframeend;
	if(!isdefined(self.start))
	{
		self.start = 0;
	}

	if(!isdefined(self.end))
	{
		self.end = 1;
	}

	if(!isdefined(self.base))
	{
		self.base = 0;
	}

	var_05 = self.time * 20;
	var_06 = self.end - self.start;
	if(isdefined(param_04))
	{
		for(var_07 = 0;var_07 <= var_05;var_07++)
		{
			var_08 = self.base + var_07 * var_06 / var_05;
			param_01 thread [[ param_00 ]](var_08,param_02,param_03,param_04);
			wait 0.05;
		}

		return;
	}

	if(isdefined(var_05))
	{
		for(var_07 = 0;var_07 <= var_05;var_07++)
		{
			var_08 = self.base + var_07 * var_06 / var_05;
			param_01 thread [[ param_00 ]](var_08,param_02,param_03);
			wait 0.05;
		}

		return;
	}

	if(isdefined(param_04))
	{
		for(var_07 = 0;var_07 <= var_05;var_07++)
		{
			var_08 = self.base + var_07 * var_06 / var_05;
			param_01 thread [[ param_00 ]](var_08,param_02);
			wait 0.05;
		}

		return;
	}

	for(var_07 = 0;var_07 <= var_05;var_07++)
	{
		var_08 = self.base + var_07 * var_06 / var_05;
		param_01 thread [[ param_00 ]](var_08);
		wait 0.05;
	}
}

//Function Number: 68
add_trace_fx_proc(param_00)
{
	waittillframeend;
	if(!isdefined(level.trace_fx))
	{
		level.trace_fx = [];
	}

	if(!isdefined(level.trace_fx))
	{
		level.trace_fx[param_00] = [];
	}

	if(isdefined(self.fx))
	{
		level.trace_fx[param_00][self.surface]["fx"] = self.fx;
	}

	if(isdefined(self.fx_array))
	{
		level.trace_fx[param_00][self.surface]["fx_array"] = self.fx_array;
	}

	if(isdefined(self.sound))
	{
		level.trace_fx[param_00][self.surface]["sound"] = self.sound;
	}

	if(isdefined(self.rumble))
	{
		level.trace_fx[param_00][self.surface]["rumble"] = self.rumble;
	}

	if(!isdefined(level.trace_fx[param_00]["default"]))
	{
		level.trace_fx[param_00]["default"] = level.trace_fx[param_00][self.surface];
	}
}

//Function Number: 69
put_interactive_in_volume(param_00)
{
	var_01 = spawnstruct();
	precachemodel(param_00.model);
	var_01.toy_model = param_00.model;
	var_01.origin = param_00.origin;
	var_01.angles = param_00.angles;
	var_01.script_noteworthy = param_00.script_noteworthy;
	var_01.target = param_00.target;
	var_01.targetname = param_00.targetname;
	self.interactives[self.interactives.size] = var_01;
	param_00 delete();
}

//Function Number: 70
put_toy_in_volume(param_00)
{
	var_01 = spawnstruct();
	precachemodel(param_00.model);
	var_01.toy_model = param_00.model;
	var_01.origin = param_00.origin;
	var_01.angles = param_00.angles;
	var_01.script_noteworthy = param_00.script_noteworthy;
	var_01.script_linkto = param_00.script_linkto;
	var_01.targetname = param_00.targetname;
	var_01.target = param_00.target;
	var_01.destructible_type = param_00.destructible_type;
	var_01.script_noflip = param_00.script_noflip;
	param_00 maps\_utility::precache_destructible(param_00.destructible_type);
	self.destructibles[self.destructibles.size] = var_01;
	param_00 notify("masking_destructible");
	param_00 delete();
}

//Function Number: 71
get_color_info_from_trigger()
{
	var_00 = "allies";
	if(isdefined(self.script_color_axis))
	{
		var_00 = "axis";
	}

	var_00 = maps\_colors::get_team(var_00);
	var_01 = [];
	if(var_00 == "allies")
	{
		var_02 = maps\_colors::get_colorcodes_from_trigger(self.script_color_allies,"allies");
		var_01 = var_02["colorCodes"];
	}
	else
	{
		var_02 = maps\_colors::get_colorcodes_from_trigger(self.script_color_axis,"axis");
		var_01 = var_02["colorCodes"];
	}

	var_03 = [];
	return var_7B;
}

//Function Number: 72
delaythread_proc(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	wait param_01;
	if(!isdefined(param_02))
	{
		thread [[ param_00 ]]();
		return;
	}

	if(!isdefined(param_03))
	{
		thread [[ param_00 ]](param_02);
		return;
	}

	if(!isdefined(param_04))
	{
		thread [[ param_00 ]](param_02,param_03);
		return;
	}

	if(!isdefined(param_05))
	{
		thread [[ param_00 ]](param_02,param_03,param_04);
		return;
	}

	if(!isdefined(param_06))
	{
		thread [[ param_00 ]](param_02,param_03,param_04,param_05);
		return;
	}

	if(!isdefined(param_07))
	{
		thread [[ param_00 ]](param_02,param_03,param_04,param_05,param_06);
		return;
	}

	thread [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 73
add_wait_asserter()
{
	level notify("kill_add_wait_asserter");
	level endon("kill_add_wait_asserter");
	for(var_00 = 0;var_00 < 20;var_00++)
	{
		waittillframeend;
	}
}

//Function Number: 74
update_battlechatter_hud()
{
}

//Function Number: 75
comparesizesfx(param_00,param_01,param_02,param_03)
{
	if(!param_01.size)
	{
		return undefined;
	}

	if(isdefined(param_02))
	{
		var_04 = undefined;
		var_05 = getarraykeys(param_01);
		for(var_06 = 0;var_06 < var_05.size;var_06++)
		{
			var_07 = distance(param_01[var_05[var_06]].v["origin"],param_00);
			if([[ param_03 ]](var_07,param_02))
			{
				continue;
			}

			param_02 = var_07;
			var_04 = param_01[var_05[var_06]];
		}

		return var_04;
	}

	var_05 = getarraykeys(var_05);
	var_04 = var_04[var_07[0]];
	var_04 = distance(var_07.v["origin"],param_02);
	for(var_06 = 1;var_06 < var_04.size;var_06++)
	{
		var_07 = distance(param_01[var_04[var_06]].v["origin"],param_00);
		if([[ param_03 ]](var_07,param_02))
		{
			continue;
		}

		param_02 = var_07;
		var_05 = param_01[var_04[var_06]];
	}

	return var_05;
}

//Function Number: 76
waittill_triggered_current()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		waittillframeend;
		if(var_00.currentnode == self)
		{
			return var_00;
		}
	}
}

//Function Number: 77
add_trigger_func_thread()
{
	self.trigger_functions = [];
	self waittill("trigger",var_00);
	var_01 = self.trigger_functions;
	self.trigger_functions = undefined;
	foreach(var_03 in var_01)
	{
		thread [[ var_03 ]](var_00);
	}
}

//Function Number: 78
objective_recon(param_00)
{
	if(!maps\_utility::is_default_start())
	{
		return;
	}

	var_01 = get_leveltime();
	var_02 = var_01;
	if(isdefined(level.recon_objective_lasttime))
	{
		var_02 = var_01 - level.recon_objective_lasttime;
	}

	level.recon_objective_lasttime = var_01;
	reconevent("script_objective: objective %d, leveltime %d, deltatime %d",param_00,var_01,var_02);
}

//Function Number: 79
mission_recon(param_00)
{
	if(maps\_utility::is_default_start())
	{
		if(!isdefined(param_00))
		{
			param_00 = 1;
		}

		var_01 = get_leveltime();
		var_02 = var_01;
		reconevent("script_level: leveltime %d, deltatime %d, success %d",var_02,var_01,param_00);
	}
}

//Function Number: 80
get_leveltime()
{
	return getlevelticks() * 0.05;
}