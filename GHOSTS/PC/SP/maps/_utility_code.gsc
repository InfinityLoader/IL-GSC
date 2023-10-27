/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_utility_code.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 89
 * Decompile Time: 1595 ms
 * Timestamp: 10/27/2023 1:26:05 AM
*******************************************************************/

//Function Number: 1
func_4E22(param_00,param_01,param_02,param_03)
{
	for(var_04 = 0;var_04 < param_03 * 20;var_04++)
	{
		wait(0.05);
	}
}

//Function Number: 2
func_7D00(param_00,param_01)
{
	var_02 = param_00.var_7CF5;
	var_03 = param_01.var_7CF5;
	self.var_ED8[var_03] = param_00;
	self.var_ED8[var_02] = param_01;
	self.var_ED8[var_02].var_7CF5 = var_02;
	self.var_ED8[var_03].var_7CF5 = var_03;
}

//Function Number: 3
func_8B1B(param_00,param_01)
{
	waittillframeend;
	var_02 = [];
	if(level.var_8AB1 == 1)
	{
		var_02[0] = randomfloatrange(param_00,param_01);
		level.var_8AB0 = var_02;
		level.active_wait_spread = undefined;
	}

	var_02[0] = param_00;
	var_02[var_02.size] = param_01;
	for(var_03 = 1;var_03 < level.var_8AB1 - 1;var_03++)
	{
		var_02 = func_8B1C(var_02);
	}

	level.var_8AB0 = common_scripts\utility::array_randomize(var_02);
	level.active_wait_spread = undefined;
}

//Function Number: 4
func_8B1C(param_00)
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
func_8B82(param_00)
{
	while(level.var_2387[self.script_deathchain] > 0)
	{
		level waittill("spawner_expired" + self.script_deathchain);
	}

	if(param_00)
	{
		self waittill("trigger");
	}

	var_01 = maps\_utility::func_39D6();
	common_scripts\utility::flag_set(var_01);
}

//Function Number: 6
func_8AC4()
{
	self endon("death");
	self endon("removed from battleChatter");
	while(self.var_4968)
	{
		wait(0.05);
	}
}

//Function Number: 7
func_8AA2(param_00)
{
	self endon("death");
	param_00 endon("trigger");
	self waittill("trigger");
	param_00 notify("trigger");
}

//Function Number: 8
func_8AA0(param_00,param_01)
{
	var_02 = getentarray(param_00,param_01);
	var_03 = spawnstruct();
	common_scripts\utility::func_F1B(var_02,::func_8AA2,var_03);
	var_03 waittill("trigger");
}

//Function Number: 9
ent_waits_for_trigger(param_00)
{
	self endon("done");
	param_00 waittill("trigger");
	self notify("done");
}

//Function Number: 10
func_866D()
{
	self notify("debug_color_update");
	self endon("debug_color_update");
	var_00 = self.unique_id;
	self waittill("death");
	level.var_23D4[var_00] = undefined;
	level notify("updated_color_friendlies");
}

//Function Number: 11
func_866C(param_00)
{
	thread func_866D();
	if(isdefined(self.var_6BCF))
	{
		level.var_23D4[param_00] = self.var_6BCF;
	}
	else
	{
		level.var_23D4[param_00] = undefined;
	}

	level notify("updated_color_friendlies");
}

//Function Number: 12
func_4673()
{
}

//Function Number: 13
func_55B1(param_00)
{
	self notify("new_color_being_set");
	self.var_55B5 = 1;
	maps\_colors::func_4D55();
	self endon("new_color_being_set");
	self endon("death");
	waittillframeend;
	waittillframeend;
	if(isdefined(self.var_6BCF))
	{
		self.currentcolorcode = level.currentcolorforced[maps\_colors::func_39C5()][self.var_6BCF];
		if(isdefined(self.dontcolormove))
		{
			self.dontcolormove = undefined;
		}
		else
		{
			thread maps\_colors::func_3D86();
		}
	}

	self.var_55B5 = undefined;
	self notify("done_setting_new_color");
}

//Function Number: 14
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
		}
	}

	self._radio_queue = 1;
	maps\_utility::func_8A74(level.var_4C11,0.5);
	level.player maps\_utility::func_5D23(level.var_6AF5[param_00]);
	self._radio_queue = undefined;
	level.var_4C11 = gettime();
	self notify("finished_radio");
}

//Function Number: 15
ent_wait_for_flag_or_time_elapses(param_00,param_01)
{
	self endon(param_00);
	wait(param_01);
}

//Function Number: 16
func_8B51(param_00,param_01,param_02)
{
	param_00 endon("done");
	[[ param_01 ]](param_02);
	param_00 notify("done");
}

//Function Number: 17
func_4264(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		wait(param_00);
	}

	var_02 = param_00 * 20;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		if([[ param_01 ]]())
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 18
hint_timeout(param_00)
{
	wait(param_00);
	self.var_8119 = 1;
}

//Function Number: 19
func_424D(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	return param_00 + _hint_stick_get_config_suffix(param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 20
_hint_stick_get_config_suffix(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = getsticksconfig();
	if(level.player common_scripts\utility::func_4828())
	{
		if((isdefined(level.ps3) && level.ps3) || isdefined(level.ps4) && level.ps4)
		{
			if(issubstr(var_06,"southpaw") || param_05 && issubstr(var_06,"legacy"))
			{
				return param_04;
			}

			return param_03;
		}

		if(issubstr(var_06,"southpaw") || param_05 && issubstr(var_06,"legacy"))
		{
			return param_02;
		}

		return param_01;
	}

	return param_00;
}

//Function Number: 21
_hint_stick_update_string(param_00,param_01)
{
	var_02 = param_01 + param_00;
	var_03 = level.var_8357[var_02];
	level.hint_breakfunc = var_03;
}

//Function Number: 22
_hint_stick_update_breakfunc(param_00,param_01)
{
	var_02 = param_01 + param_00;
	var_03 = level.var_8358[var_02];
	level.current_hint settext(var_03);
}

//Function Number: 23
func_424E(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	level notify("hint_change_config");
	level endon("hint_change_config");
	var_07 = _hint_stick_get_config_suffix(param_01,param_02,param_03,param_04,param_05,param_06);
	_hint_stick_update_string(var_07,param_00);
	_hint_stick_update_breakfunc(var_07,param_00);
	while(isdefined(level.current_hint))
	{
		var_08 = _hint_stick_get_config_suffix(param_01,param_02,param_03,param_04,param_05,param_06);
		if(var_08 != var_07)
		{
			var_07 = var_08;
			_hint_stick_update_string(var_07,param_00);
			_hint_stick_update_breakfunc(var_07,param_00);
		}

		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 24
func_4263(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = gettime();
	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	if(!isalive(self))
	{
	}

	var_08 = 1;
	var_09 = 0.75;
	var_0A = 0.95;
	var_0B = 0.4;
	var_0C = 2;
	if(isdefined(level.hint_fontscale))
	{
		var_0C = level.hint_fontscale;
	}

	if(isdefined(self.current_global_hint))
	{
		if(self.current_global_hint == param_00)
		{
		}
	}

	maps\_utility::ent_flag_waitopen("global_hint_in_use");
	if(isdefined(self.current_global_hint))
	{
		if(self.current_global_hint == param_00)
		{
		}
	}

	maps\_utility::func_2F48("global_hint_in_use");
	self.current_global_hint = param_00;
	var_0D = maps\_hud_util::func_20D1("default",var_0C);
	level.current_hint = var_0D;
	level.hint_breakfunc = param_01;
	thread destroy_hint_on_friendlyfire(var_0D);
	level endon("friendlyfire_mission_fail");
	var_0D.alpha = 0.9;
	var_0D.x = 0;
	var_0D.y = -68;
	var_0D.alignx = "center";
	var_0D.aligny = "middle";
	var_0D.horzalign = "center";
	var_0D.vertalign = "middle";
	var_0D.foreground = 0;
	var_0D.hidewhendead = 1;
	var_0D.hidewheninmenu = 1;
	var_0D settext(param_00);
	var_0D.alpha = 0;
	var_0D fadeovertime(var_08);
	var_0D.alpha = var_0A;
	func_4264(var_08,level.hint_breakfunc);
	var_0E = 0;
	if(isdefined(param_04))
	{
		var_0E = 3;
	}
	else if(isdefined(param_03))
	{
		var_0E = 2;
	}
	else if(isdefined(param_02))
	{
		var_0E = 1;
	}

	var_0F = spawnstruct();
	var_0F.var_8119 = 0;
	if(isdefined(param_05))
	{
		var_0F thread hint_timeout(param_05);
	}

	if(isdefined(level.hint_breakfunc))
	{
		for(;;)
		{
			var_0D fadeovertime(var_09);
			var_0D.alpha = var_0B;
			func_4264(var_09,level.hint_breakfunc);
			if(var_0E == 3)
			{
				if([[ level.hint_breakfunc ]](param_02,param_03,param_04))
				{
					break;
				}
			}
			else if(var_0E == 2)
			{
				if([[ level.hint_breakfunc ]](param_02,param_03))
				{
					break;
				}
			}
			else if(var_0E == 1)
			{
				if([[ level.hint_breakfunc ]](param_02))
				{
					break;
				}
			}
			else if([[ level.hint_breakfunc ]]())
			{
				break;
			}

			var_0D fadeovertime(var_09);
			var_0D.alpha = var_0A;
			func_4264(var_09,level.hint_breakfunc);
			if(var_0F.var_8119)
			{
				break;
			}

			if(var_0E == 3)
			{
				if([[ level.hint_breakfunc ]](param_02,param_03,param_04))
				{
					break;
				}

				continue;
			}

			if(var_0E == 2)
			{
				if([[ level.hint_breakfunc ]](param_02,param_03))
				{
					break;
				}

				continue;
			}

			if(var_0E == 1)
			{
				if([[ level.hint_breakfunc ]](param_02))
				{
					break;
				}

				continue;
			}

			if([[ level.hint_breakfunc ]]())
			{
				break;
			}
		}
	}
	else
	{
		for(var_10 = 0;var_10 < 1;var_10++)
		{
			var_0D fadeovertime(var_09);
			var_0D.alpha = var_0B;
			func_4264(var_09,level.hint_breakfunc);
			var_0D fadeovertime(var_09);
			var_0D.alpha = var_0A;
			func_4264(var_09,level.hint_breakfunc);
		}
	}

	maps\_utility::func_8A74(var_07,param_06);
	var_0D notify("destroying");
	self.current_global_hint = undefined;
	var_0D destroy();
	level.current_hint = undefined;
	maps\_utility::func_2F44("global_hint_in_use");
}

//Function Number: 25
destroy_hint_on_friendlyfire(param_00)
{
	param_00 endon("destroying");
	level waittill("friendlyfire_mission_fail");
	if(!isdefined(param_00))
	{
	}

	self.current_global_hint = undefined;
	param_00 destroy();
	maps\_utility::func_2F44("global_hint_in_use");
}

//Function Number: 26
func_7513(param_00)
{
	param_00.var_8119 = 0;
	if(!isalive(self))
	{
	}

	var_01 = 1;
	var_02 = 0.75;
	var_03 = 0.95;
	var_04 = 0.4;
	maps\_utility::ent_flag_waitopen("global_hint_in_use");
	maps\_utility::func_2F48("global_hint_in_use");
	if(param_00.var_8119)
	{
	}

	if(isdefined(param_00.timeout))
	{
		param_00 thread hint_timeout(param_00.timeout);
	}

	var_05 = maps\_hud_util::func_20D1("objective",2);
	var_05.alpha = 0.9;
	var_05.x = 0;
	var_05.y = -38;
	var_05.alignx = "center";
	var_05.aligny = "middle";
	var_05.horzalign = "center";
	var_05.vertalign = "middle";
	var_05.foreground = 0;
	var_05.hidewhendead = 1;
	var_05 settext(param_00.var_7CDD);
	var_05.alpha = 0;
	var_05 fadeovertime(var_01);
	var_05.alpha = var_03;
	func_4264(var_01);
	for(;;)
	{
		var_05 fadeovertime(var_02);
		var_05.alpha = var_04;
		func_4264(var_02);
		if(param_00.var_8119)
		{
			break;
		}

		var_05 fadeovertime(var_02);
		var_05.alpha = var_03;
		func_4264(var_02);
		if(param_00.var_8119)
		{
			break;
		}
	}

	var_05 destroy();
	maps\_utility::func_2F44("global_hint_in_use");
}

//Function Number: 27
func_4D8A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isdefined(self.var_3353) && self.var_3353 == gettime())
	{
		wait(0.1);
	}

	var_09 = self gettagorigin(param_01);
	var_0A = self gettagangles(param_01);
	param_00 maps\_utility::func_4D86(var_09,var_0A,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	if(param_08)
	{
	}

	param_00 playerlinkto(self,param_01,param_03,param_04,param_05,param_06,param_07,0);
}

//Function Number: 28
lerp_player_view_to_tag_oldstyle_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isdefined(self.var_3353) && self.var_3353 == gettime())
	{
		wait(0.1);
	}

	var_09 = self gettagorigin(param_01);
	var_0A = self gettagangles(param_01);
	param_00 maps\_utility::func_4D87(var_09,var_0A,param_02,param_03,param_04,param_05,param_06,param_07,1);
	if(param_08)
	{
	}

	param_00 playerlinktodelta(self,param_01,param_03,param_04,param_05,param_06,param_07,0);
}

//Function Number: 29
function_stack_wait(param_00)
{
	self endon("death");
	param_00 common_scripts\utility::func_8B4F("function_done","death");
}

//Function Number: 30
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

//Function Number: 31
func_35BB(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	if(!isdefined(param_00.function_stack))
	{
		param_00.function_stack = [];
	}

	param_00.function_stack[param_00.function_stack.size] = self;
	thread func_35BC(param_00);
	function_stack_caller_waits_for_turn(param_00);
	if(isdefined(param_00) && isdefined(param_00.function_stack))
	{
		self.var_35BA = 1;
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
		self.var_35BA = 0;
		self notify("function_done");
	}
}

//Function Number: 32
func_35BC(param_00)
{
	self endon("function_done");
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00.function_stack = common_scripts\utility::array_remove(param_00.function_stack,self);
		param_00 notify("level_function_stack_ready");
	}
}

//Function Number: 33
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

//Function Number: 34
func_859F(param_00)
{
	level endon("player_flashed");
	wait(param_00);
	common_scripts\utility::func_337C("player_flashed");
}

//Function Number: 35
func_8A9A(param_00)
{
	self endon("death");
	param_00 waittill("sounddone");
	return 1;
}

//Function Number: 36
func_45CA(param_00)
{
	level.lvl_visionset = param_00;
	if(!isdefined(level.vision_cheat_enabled))
	{
		level.vision_cheat_enabled = 0;
	}

	return level.vision_cheat_enabled;
}

//Function Number: 37
func_0F22(param_00,param_01,param_02)
{
	array_waitlogic2(param_00,param_01,param_02);
	self._array_wait = 0;
	self notify("_array_wait");
}

//Function Number: 38
array_waitlogic2(param_00,param_01,param_02)
{
	param_00 endon(param_01);
	param_00 endon("death");
	if(isdefined(param_02))
	{
		wait(param_02);
	}

	param_00 waittill(param_01);
}

//Function Number: 39
func_3047(param_00)
{
	if(param_00.var_5AED.size == 0)
	{
		param_00.caller [[ param_00.func ]]();
	}
	else if(param_00.var_5AED.size == 1)
	{
		param_00.caller [[ param_00.func ]](param_00.var_5AED[0]);
	}
	else if(param_00.var_5AED.size == 2)
	{
		param_00.caller [[ param_00.func ]](param_00.var_5AED[0],param_00.var_5AED[1]);
	}
	else if(param_00.var_5AED.size == 3)
	{
		param_00.caller [[ param_00.func ]](param_00.var_5AED[0],param_00.var_5AED[1],param_00.var_5AED[2]);
	}

	if(param_00.var_5AED.size == 4)
	{
		param_00.caller [[ param_00.func ]](param_00.var_5AED[0],param_00.var_5AED[1],param_00.var_5AED[2],param_00.var_5AED[3]);
	}

	if(param_00.var_5AED.size == 5)
	{
		param_00.caller [[ param_00.func ]](param_00.var_5AED[0],param_00.var_5AED[1],param_00.var_5AED[2],param_00.var_5AED[3],param_00.var_5AED[4]);
	}
}

//Function Number: 40
func_3048(param_00)
{
	if(param_00.var_5AED.size == 0)
	{
		[[ param_00.func ]]();
	}
	else if(param_00.var_5AED.size == 1)
	{
		[[ param_00.func ]](param_00.var_5AED[0]);
	}
	else if(param_00.var_5AED.size == 2)
	{
		[[ param_00.func ]](param_00.var_5AED[0],param_00.var_5AED[1]);
	}
	else if(param_00.var_5AED.size == 3)
	{
		[[ param_00.func ]](param_00.var_5AED[0],param_00.var_5AED[1],param_00.var_5AED[2]);
	}

	if(param_00.var_5AED.size == 4)
	{
		[[ param_00.func ]](param_00.var_5AED[0],param_00.var_5AED[1],param_00.var_5AED[2],param_00.var_5AED[3]);
	}

	if(param_00.var_5AED.size == 5)
	{
		[[ param_00.func ]](param_00.var_5AED[0],param_00.var_5AED[1],param_00.var_5AED[2],param_00.var_5AED[3],param_00.var_5AED[4]);
	}
}

//Function Number: 41
func_3049(param_00,param_01)
{
	if(!isdefined(param_00.caller))
	{
	}

	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		param_01[var_02].caller endon(param_01[var_02].var_2D50);
	}

	if(param_00.var_5AED.size == 0)
	{
		param_00.caller [[ param_00.func ]]();
	}
	else if(param_00.var_5AED.size == 1)
	{
		param_00.caller [[ param_00.func ]](param_00.var_5AED[0]);
	}
	else if(param_00.var_5AED.size == 2)
	{
		param_00.caller [[ param_00.func ]](param_00.var_5AED[0],param_00.var_5AED[1]);
	}
	else if(param_00.var_5AED.size == 3)
	{
		param_00.caller [[ param_00.func ]](param_00.var_5AED[0],param_00.var_5AED[1],param_00.var_5AED[2]);
	}

	if(param_00.var_5AED.size == 4)
	{
		param_00.caller [[ param_00.func ]](param_00.var_5AED[0],param_00.var_5AED[1],param_00.var_5AED[2],param_00.var_5AED[3]);
	}

	if(param_00.var_5AED.size == 5)
	{
		param_00.caller [[ param_00.func ]](param_00.var_5AED[0],param_00.var_5AED[1],param_00.var_5AED[2],param_00.var_5AED[3],param_00.var_5AED[4]);
	}
}

//Function Number: 42
func_8B63(param_00,param_01)
{
	self endon("all_funcs_ended");
	self endon("any_funcs_aborted");
	func_3049(param_00,param_01);
	self.count--;
	self notify("func_ended");
}

//Function Number: 43
func_8B20(param_00,param_01)
{
	self endon("all_funcs_ended");
	self endon("any_funcs_aborted");
	func_3049(param_00,param_01);
	self.abort_count--;
	self notify("abort_func_ended");
}

//Function Number: 44
func_2818(param_00)
{
	self endon("all_funcs_ended");
	if(!param_00.size)
	{
	}

	var_01 = 0;
	self.abort_count = param_00.size;
	var_02 = [];
	common_scripts\utility::array_levelthread(param_00,::func_8B20,var_02);
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

//Function Number: 45
func_8276(param_00)
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

	if(isdefined(self.var_5C59))
	{
		param_00 addpitch(self.var_5C59);
	}

	if(isdefined(self.var_67A3))
	{
		param_00 addroll(self.var_67A3);
	}
}

//Function Number: 46
func_2BB1(param_00,param_01,param_02,param_03,param_04)
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
		maps\_utility::func_2F47("dynamic_run_speed_stopped");
		maps\_utility::func_2F47("dynamic_run_speed_stopping");
	}
	else
	{
		maps\_utility::func_2F44("dynamic_run_speed_stopping");
		maps\_utility::func_2F44("dynamic_run_speed_stopped");
	}

	self.run_speed_state = "";
	self.var_58A2 = self.moveplaybackrate;
	thread func_7C1D();
	var_05 = param_00 * param_00;
	var_06 = param_01 * param_01;
	var_07 = param_02 * param_02;
	var_08 = param_03 * param_03;
	for(;;)
	{
		wait(0.05);
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
			var_12 = common_scripts\utility::func_3A56(var_09.origin,param_04);
			var_11 = distancesquared(var_12.origin,var_09.origin);
		}

		var_13 = 0;
		if(isdefined(self.last_set_goalent))
		{
			var_13 = [[ level.drs_ahead_test ]](self.last_set_goalent,param_01);
		}
		else if(isdefined(self.var_4C22))
		{
			var_13 = [[ level.drs_ahead_test ]](self.var_4C22,param_01);
		}

		if(isdefined(self.var_1FFA) && self.var_1FFA && !self.dontchangemoveplaybackrate)
		{
			self.moveplaybackrate = 1;
		}

		if(var_10 < var_06 || var_0F > -0.25 || var_13)
		{
			func_2BAF("sprint");
			wait(0.5);
			continue;
		}
		else if(var_10 < var_05 || var_0F > -0.25)
		{
			func_2BAF("run");
			wait(0.5);
			continue;
		}
		else if(var_11 > var_07)
		{
			if(self.a.var_5486 != "stop")
			{
				func_2BAF("stop");
				wait(0.5);
			}

			continue;
		}
		else if(var_10 > var_08)
		{
			func_2BAF("jog");
			wait(0.5);
			continue;
		}
	}
}

//Function Number: 47
func_7C1D()
{
	self endon("start_dynamic_run_speed");
	self endon("death");
	func_7C1E();
	if(!self.dontchangemoveplaybackrate)
	{
		self.moveplaybackrate = self.var_58A2;
	}

	if(isdefined(level.scr_anim["generic"]["DRS_run"]))
	{
		if(isarray(level.scr_anim["generic"]["DRS_run"]))
		{
			maps\_utility::func_6EF1("DRS_run");
		}
		else
		{
			maps\_utility::func_6EF0("DRS_run");
		}
	}
	else
	{
		maps\_utility::clear_run_anim();
	}

	self notify("stop_loop");
	maps\_utility::func_2F44("dynamic_run_speed_stopping");
	maps\_utility::func_2F44("dynamic_run_speed_stopped");
}

//Function Number: 48
func_7C1E()
{
	level endon("_stealth_spotted");
	self waittill("stop_dynamic_run_speed");
}

//Function Number: 49
func_2BAE(param_00,param_01)
{
	if(!isdefined(param_00.classname))
	{
		if(!isdefined(param_00.type))
		{
			var_02 = ::maps\_spawner::func_39C4;
		}
		else
		{
			var_02 = ::maps\_spawner::func_39C3;
		}
	}
	else
	{
		var_02 = ::maps\_spawner::get_target_ents;
	}

	return maps\_spawner::func_3D5F(param_00,var_02,param_01);
}

//Function Number: 50
func_2BAF(param_00)
{
	if(self.run_speed_state == param_00)
	{
	}

	self.run_speed_state = param_00;
	switch(param_00)
	{
		case "sprint":
			if(isdefined(self.var_1FFA) && self.var_1FFA && !self.dontchangemoveplaybackrate)
			{
				self.moveplaybackrate = 1;
			}
			else if(!self.dontchangemoveplaybackrate)
			{
				self.moveplaybackrate = 1.15;
			}
	
			if(isarray(level.scr_anim["generic"]["DRS_sprint"]))
			{
				maps\_utility::func_6EF1("DRS_sprint");
			}
			else
			{
				maps\_utility::func_6EF0("DRS_sprint");
			}
	
			self notify("stop_loop");
			maps\_utility::anim_stopanimscripted();
			maps\_utility::func_2F44("dynamic_run_speed_stopped");
			break;

		case "run":
			if(!self.dontchangemoveplaybackrate)
			{
				self.moveplaybackrate = self.var_58A2;
			}
	
			if(isdefined(level.scr_anim["generic"]["DRS_run"]))
			{
				if(isarray(level.scr_anim["generic"]["DRS_run"]))
				{
					maps\_utility::func_6EF1("DRS_run");
				}
				else
				{
					maps\_utility::func_6EF0("DRS_run");
				}
			}
			else
			{
				maps\_utility::clear_run_anim();
			}
	
			self notify("stop_loop");
			maps\_utility::anim_stopanimscripted();
			maps\_utility::func_2F44("dynamic_run_speed_stopped");
			break;

		case "stop":
			thread func_2BB2();
			break;

		case "jog":
			if(!self.dontchangemoveplaybackrate)
			{
				self.moveplaybackrate = self.var_58A2;
			}
	
			if(isdefined(level.scr_anim["generic"]["DRS_combat_jog"]))
			{
				if(isarray(level.scr_anim["generic"]["DRS_combat_jog"]))
				{
					maps\_utility::func_6EF1("DRS_combat_jog");
				}
				else
				{
					maps\_utility::func_6EF0("DRS_combat_jog");
				}
			}
			else
			{
				maps\_utility::clear_run_anim();
			}
	
			self notify("stop_loop");
			maps\_utility::anim_stopanimscripted();
			maps\_utility::func_2F44("dynamic_run_speed_stopped");
			break;

		case "crouch":
			break;
	}
}

//Function Number: 51
func_2BB2()
{
	self endon("death");
	if(maps\_utility::ent_flag("dynamic_run_speed_stopped"))
	{
	}

	if(maps\_utility::ent_flag("dynamic_run_speed_stopping"))
	{
	}

	self endon("stop_dynamic_run_speed");
	maps\_utility::func_2F48("dynamic_run_speed_stopping");
	maps\_utility::func_2F48("dynamic_run_speed_stopped");
	self endon("dynamic_run_speed_stopped");
	var_00 = "DRS_run_2_stop";
	maps\_anim::func_D65(self,"gravity",var_00);
	maps\_utility::func_2F44("dynamic_run_speed_stopping");
	while(maps\_utility::ent_flag("dynamic_run_speed_stopped"))
	{
		var_01 = "DRS_stop_idle";
		thread maps\_anim::anim_generic_loop(self,var_01);
		if(isdefined(level.scr_anim["generic"]["signal_go"]))
		{
			maps\_utility::func_3FAA("go");
		}

		wait(randomfloatrange(12,20));
		if(maps\_utility::ent_flag_exist("_stealth_stance_handler"))
		{
			maps\_utility::ent_flag_waitopen("_stealth_stance_handler");
		}

		self notify("stop_loop");
		if(!maps\_utility::ent_flag("dynamic_run_speed_stopped"))
		{
		}

		if(isdefined(level.var_2BB0))
		{
			var_02 = common_scripts\utility::func_6306(level.var_2BB0);
			level thread maps\_utility::func_62C4(var_02);
		}

		if(isdefined(level.scr_anim["generic"]["signal_go"]))
		{
			maps\_utility::func_3FAA("go");
		}
	}
}

//Function Number: 52
g_speed_get_func()
{
	return int(getdvar("g_speed"));
}

//Function Number: 53
g_speed_set_func(param_00)
{
	setsaveddvar("g_speed",int(param_00));
}

//Function Number: 54
g_bob_scale_get_func()
{
	return level.player getbobrate();
}

//Function Number: 55
g_bob_scale_set_func(param_00)
{
	level.player setbobrate(param_00);
}

//Function Number: 56
func_549E()
{
	return self.movespeedscale;
}

//Function Number: 57
func_54A1(param_00)
{
	self.movespeedscale = param_00;
	self setmovespeedscale(param_00);
}

//Function Number: 58
func_11CC()
{
	if(common_scripts\utility::flag_exist("autosave_tactical_player_nade"))
	{
	}

	common_scripts\utility::func_3385("autosave_tactical_player_nade");
	level.autosave_tactical_player_nades = 0;
	notifyoncommand("autosave_player_nade","+frag");
	notifyoncommand("autosave_player_nade","-smoke");
	notifyoncommand("autosave_player_nade","+smoke");
	common_scripts\utility::func_F1B(level.players,::autosave_tactical_grenade_check);
}

//Function Number: 59
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

//Function Number: 60
autosave_tactical_grenade_check_dieout(param_00)
{
	level.autosave_tactical_player_nades++;
	param_00 common_scripts\utility::waittill_notify_or_timeout("death",10);
	level.autosave_tactical_player_nades--;
	waittillframeend;
	if(!level.autosave_tactical_player_nades)
	{
		common_scripts\utility::func_337C("autosave_tactical_player_nade");
	}
}

//Function Number: 61
autosave_tactical_proc()
{
	level notify("autosave_tactical_proc");
	level endon("autosave_tactical_proc");
	level thread maps\_utility::func_5704("kill_save",5);
	level endon("kill_save");
	level endon("autosave_tactical_player_nade");
	if(common_scripts\utility::flag("autosave_tactical_player_nade"))
	{
		common_scripts\utility::func_33A2("autosave_tactical_player_nade",4);
		if(common_scripts\utility::flag("autosave_tactical_player_nade"))
		{
		}
	}

	var_00 = getaiarray("axis");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.enemy) && isplayer(var_02.enemy))
		{
		}
	}

	waittillframeend;
	maps\_utility::autosave_by_name();
}

//Function Number: 62
func_553B(param_00,param_01,param_02,param_03)
{
	maps\_utility::func_5541(param_01);
	level endon("stop_music");
	wait(param_01);
	thread maps\_utility::music_play(param_00,undefined,param_02,param_03);
}

//Function Number: 63
func_5536(param_00,param_01,param_02,param_03,param_04,param_05)
{
	maps\_utility::func_5541(param_02);
	level endon("stop_music");
	wait(param_02);
	thread func_5535(param_00,param_01,undefined,param_03,param_04,param_05);
}

//Function Number: 64
func_5535(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_02) && param_02 > 0)
	{
		thread func_5536(param_00,param_01,param_02,param_03,param_04,param_05);
	}

	maps\_utility::func_5541();
	level endon("stop_music");
	maps\_utility::func_5545(param_00,param_03,param_04);
	if(isdefined(param_05) && param_05 == 1 && common_scripts\utility::flag_exist("_stealth_spotted"))
	{
		level endon("_stealth_spotted");
		thread func_5538(param_00,param_01,param_02);
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

	wait(var_06);
	maps\_utility::func_5534(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 65
func_5538(param_00,param_01,param_02)
{
	level endon("stop_music");
	common_scripts\utility::flag_wait("_stealth_spotted");
	musicstop(0.5);
	while(common_scripts\utility::flag("_stealth_spotted"))
	{
		common_scripts\utility::func_33A0("_stealth_spotted");
		wait(1);
	}

	thread maps\_utility::func_5534(param_00,param_01,param_02);
}

//Function Number: 66
func_2A0D(param_00,param_01,param_02)
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
		wait(0.05);
		param_00.slidevelocity = param_00.slidevelocity * 1 - param_02;
	}
}

//Function Number: 67
func_4ACA(param_00)
{
	self endon("death");
	if(isdefined(param_00))
	{
		wait(randomfloat(param_00));
	}

	playfxontag(common_scripts\utility::func_3AB9("flesh_hit"),self,"tag_eye");
	self kill(level.player.origin);
}

//Function Number: 68
func_86A5(param_00,param_01)
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
		wait(0.05);
	}
}

//Function Number: 69
func_7A41(param_00)
{
	var_01 = spawn("script_model",self.origin);
	self.glow_model = var_01;
	var_01.angles = self.angles;
	var_01 setmodel(param_00);
	var_01 endon("death");
	self waittill("death");
	var_01 delete();
}

//Function Number: 70
process_blend(param_00,param_01,param_02,param_03,param_04)
{
	waittillframeend;
	if(!isdefined(self.var_79E6))
	{
		self.var_79E6 = 0;
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
	var_06 = self.end - self.var_79E6;
	self.var_7C14 = 0;
	if(isdefined(param_04))
	{
		for(var_07 = 0;var_07 <= var_05 && !self.var_7C14;var_07++)
		{
			var_08 = self.base + var_07 * var_06 / var_05;
			param_01 thread [[ param_00 ]](var_08,param_02,param_03,param_04);
			wait(0.05);
		}
	}

	if(isdefined(var_05))
	{
		for(var_07 = 0;var_07 <= var_05 && !self.var_7C14;var_07++)
		{
			var_08 = self.base + var_07 * var_06 / var_05;
			param_01 thread [[ param_00 ]](var_08,param_02,param_03);
			wait(0.05);
		}
	}

	if(isdefined(param_04))
	{
		for(var_07 = 0;var_07 <= var_05 && !self.var_7C14;var_07++)
		{
			var_08 = self.base + var_07 * var_06 / var_05;
			param_01 thread [[ param_00 ]](var_08,param_02);
			wait(0.05);
		}
	}

	for(var_07 = 0;var_07 <= var_05 && !self.var_7C14;var_07++)
	{
		var_08 = self.base + var_07 * var_06 / var_05;
		param_01 thread [[ param_00 ]](var_08);
		wait(0.05);
	}
}

//Function Number: 71
add_trace_fx_proc(param_00)
{
	waittillframeend;
	if(!isdefined(level.var_81DA))
	{
		level.var_81DA = [];
	}

	if(!isdefined(level.var_81DA))
	{
		level.var_81DA[param_00] = [];
	}

	if(isdefined(self.fx))
	{
		level.var_81DA[param_00][self.var_7D6F]["fx"] = self.fx;
	}

	if(isdefined(self.fx_array))
	{
		level.var_81DA[param_00][self.var_7D6F]["fx_array"] = self.fx_array;
	}

	if(isdefined(self.sound))
	{
		level.var_81DA[param_00][self.var_7D6F]["sound"] = self.sound;
	}

	if(isdefined(self.rumble))
	{
		level.var_81DA[param_00][self.var_7D6F]["rumble"] = self.rumble;
	}

	if(!isdefined(level.var_81DA[param_00]["default"]))
	{
		level.var_81DA[param_00]["default"] = level.var_81DA[param_00][self.var_7D6F];
	}
}

//Function Number: 72
func_6253(param_00)
{
	var_01 = spawnstruct();
	precachemodel(param_00.model);
	var_01.var_81D5 = param_00.model;
	var_01.origin = param_00.origin;
	var_01.angles = param_00.angles;
	var_01.script_noteworthy = param_00.script_noteworthy;
	var_01.script_linkto = param_00.script_linkto;
	var_01.targetname = param_00.targetname;
	var_01.target = param_00.target;
	var_01.destructible_type = param_00.destructible_type;
	var_01.script_noflip = param_00.script_noflip;
	param_00 maps\_utility::func_6104(param_00.destructible_type);
	self.destructibles[self.destructibles.size] = var_01;
	param_00 notify("masking_destructible");
	param_00 delete();
}

//Function Number: 73
func_381B()
{
	var_00 = "allies";
	if(isdefined(self.script_color_axis))
	{
		var_00 = "axis";
	}

	var_00 = maps\_colors::func_39C5(var_00);
	var_01 = [];
	if(var_00 == "allies")
	{
		var_02 = maps\_colors::func_3823(self.var_6B66,"allies");
		var_01 = var_02["colorCodes"];
	}
	else
	{
		var_02 = maps\_colors::func_3823(self.script_color_axis,"axis");
		var_01 = var_02["colorCodes"];
	}

	var_03 = [];
	var_03["team"] = var_00;
	var_03["codes"] = var_01;
	return var_03;
}

//Function Number: 74
delaythread_proc(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	self endon("stop_delay_thread");
	wait(param_01);
	if(isdefined(param_07))
	{
		thread [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07);
	}

	if(isdefined(param_06))
	{
		thread [[ param_00 ]](param_02,param_03,param_04,param_05,param_06);
	}

	if(isdefined(param_05))
	{
		thread [[ param_00 ]](param_02,param_03,param_04,param_05);
	}

	if(isdefined(param_04))
	{
		thread [[ param_00 ]](param_02,param_03,param_04);
	}

	if(isdefined(param_03))
	{
		thread [[ param_00 ]](param_02,param_03);
	}

	if(isdefined(param_02))
	{
		thread [[ param_00 ]](param_02);
	}

	thread [[ param_00 ]]();
}

//Function Number: 75
delaychildthread_proc(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	self endon("stop_delay_thread");
	wait(param_01);
	if(isdefined(param_07))
	{
		childthread [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07);
	}

	if(isdefined(param_06))
	{
		childthread [[ param_00 ]](param_02,param_03,param_04,param_05,param_06);
	}

	if(isdefined(param_05))
	{
		childthread [[ param_00 ]](param_02,param_03,param_04,param_05);
	}

	if(isdefined(param_04))
	{
		childthread [[ param_00 ]](param_02,param_03,param_04);
	}

	if(isdefined(param_03))
	{
		childthread [[ param_00 ]](param_02,param_03);
	}

	if(isdefined(param_02))
	{
		childthread [[ param_00 ]](param_02);
	}

	childthread [[ param_00 ]]();
}

//Function Number: 76
flagwaitthread_proc(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	common_scripts\utility::flag_wait(param_01[0]);
	delaythread_proc(param_00,param_01[1],param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 77
func_8BC4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	self waittill(param_01[0]);
	delaythread_proc(param_00,param_01[1],param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 78
add_wait_asserter()
{
	level notify("kill_add_wait_asserter");
	level endon("kill_add_wait_asserter");
	for(var_00 = 0;var_00 < 20;var_00++)
	{
		waittillframeend;
	}
}

//Function Number: 79
func_8661()
{
}

//Function Number: 80
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
			var_07 = distance(param_01[var_05[var_06]].var_880E["origin"],param_00);
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
	var_04 = distance(var_07.var_880E["origin"],param_02);
	for(var_06 = 1;var_06 < var_04.size;var_06++)
	{
		var_07 = distance(param_01[var_04[var_06]].var_880E["origin"],param_00);
		if([[ param_03 ]](var_07,param_02))
		{
			continue;
		}

		param_02 = var_07;
		var_05 = param_01[var_04[var_06]];
	}

	return var_05;
}

//Function Number: 81
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

//Function Number: 82
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

//Function Number: 83
add_to_radio(param_00)
{
	if(!isdefined(level.var_6AF5[param_00]))
	{
		level.var_6AF5[param_00] = param_00;
	}
}

//Function Number: 84
add_to_dialogue(param_00)
{
	if(!isdefined(level.scr_anim[self.animname]))
	{
		level.scr_anim[self.animname] = [];
	}

	if(!isdefined(level.scr_sound[self.animname]))
	{
		level.scr_sound[self.animname] = [];
	}

	if(!isdefined(level.scr_sound[self.animname][param_00]))
	{
		level.scr_sound[self.animname][param_00] = param_00;
	}
}

//Function Number: 85
add_to_dialogue_generic(param_00)
{
	if(!isdefined(level.scr_sound["generic"]))
	{
		level.scr_sound["generic"] = [];
	}

	if(!isdefined(level.scr_sound["generic"][param_00]))
	{
		level.scr_sound["generic"][param_00] = param_00;
	}
}

//Function Number: 86
func_57D6(param_00)
{
	if(!maps\_utility::func_47DB())
	{
	}

	var_01 = get_leveltime();
	var_02 = var_01;
	if(isdefined(level.var_6407))
	{
		var_02 = var_01 - level.var_6407;
	}

	level.var_6407 = var_01;
	reconevent("script_objective: objective %d, leveltime %d, deltatime %d",param_00,var_01,var_02);
}

//Function Number: 87
mission_recon(param_00)
{
	if(maps\_utility::func_47DB())
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

//Function Number: 88
get_leveltime()
{
	return getlevelticks() * 0.05;
}

//Function Number: 89
_flag_wait_trigger(param_00,param_01)
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_02);
		common_scripts\utility::flag_set(param_00);
		if(!param_01)
		{
		}

		while(var_02 istouching(self))
		{
			wait(0.05);
		}

		common_scripts\utility::func_337C(param_00);
	}
}