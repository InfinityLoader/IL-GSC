/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_utility_code.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 95
 * Decompile Time: 4349 ms
 * Timestamp: 10/27/2023 12:25:47 AM
*******************************************************************/

//Function Number: 1
func_11166(param_00,param_01)
{
	var_02 = param_00.var_11159;
	var_03 = param_01.var_11159;
	self.var_2274[var_03] = param_00;
	self.var_2274[var_02] = param_01;
	self.var_2274[var_02].var_11159 = var_02;
	self.var_2274[var_03].var_11159 = var_03;
}

//Function Number: 2
func_1368E()
{
	self endon("death");
	self endon("removed from battleChatter");
	while(self.var_9F6B)
	{
		wait(0.05);
	}
}

//Function Number: 3
func_13636(param_00)
{
	self endon("death");
	param_00 endon("trigger");
	self waittill("trigger");
	param_00 notify("trigger");
}

//Function Number: 4
func_13634(param_00,param_01)
{
	var_02 = getentarray(param_00,param_01);
	var_03 = spawnstruct();
	scripts\common\utility::array_thread(var_02,::func_13636,var_03);
	var_03 waittill("trigger");
}

//Function Number: 5
func_65FB(param_00)
{
	self endon("done");
	param_00 waittill("trigger");
	self notify("done");
}

//Function Number: 6
func_12DAC()
{
	self notify("debug_color_update");
	self endon("debug_color_update");
	var_00 = self.var_12BA3;
	self waittill("death");
	level.var_4EBE[var_00] = undefined;
	level notify("updated_color_friendlies");
}

//Function Number: 7
func_12DAB(param_00)
{
	thread func_12DAC();
	if(isdefined(self.var_EDAD))
	{
		level.var_4EBE[param_00] = self.var_EDAD;
	}
	else
	{
		level.var_4EBE[param_00] = undefined;
	}

	level notify("updated_color_friendlies");
}

//Function Number: 8
func_9938()
{
}

//Function Number: 9
func_BF01(param_00)
{
	self notify("new_color_being_set");
	self.var_BF06 = 1;
	scripts\sp\_colors::func_AB3A();
	self endon("new_color_being_set");
	self endon("death");
	waittillframeend;
	waittillframeend;
	if(isdefined(self.var_EDAD))
	{
		self.var_4BDF = level.var_4BE0[scripts\sp\_colors::func_7CE4()][self.var_EDAD];
		if(isdefined(self.var_5955))
		{
			self.var_5955 = undefined;
		}
		else
		{
			thread scripts\sp\_colors::func_8467();
		}
	}

	self.var_BF06 = undefined;
	self notify("done_setting_new_color");
}

//Function Number: 10
func_65FA(param_00,param_01)
{
	self endon(param_00);
	wait(param_01);
}

//Function Number: 11
func_13764(param_00,param_01,param_02)
{
	param_00 endon("done");
	[[ param_01 ]](param_02);
	param_00 notify("done");
}

//Function Number: 12
func_9022(param_00,param_01)
{
	self endon("hint_print_timeout");
	self endon("hint_print_remove");
	param_01 endon("new_hint");
	for(;;)
	{
		self.var_6AB8 = 1;
		if((isdefined(level.var_8FE4) && [[ level.var_8FE4 ]]()) || param_01.var_4B7A != param_00)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 13
func_9014(param_00)
{
	wait(param_00);
	self.var_6AB8 = 1;
	self notify("hint_print_timeout");
}

//Function Number: 14
func_900D(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	return param_00 + func_12DB(param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 15
func_12DB(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = function_00D0();
	if(level.player scripts\common\utility::func_9C70())
	{
		if((isdefined(level.var_DADB) && level.var_DADB) || isdefined(level.var_DADC) && level.var_DADC)
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

//Function Number: 16
func_12DC(param_00,param_01)
{
	var_02 = param_01 + param_00;
	var_03 = level.var_1274F[var_02];
	level.var_8FE4 = var_03;
}

//Function Number: 17
func_12DD(param_00,param_01)
{
	var_02 = param_01 + param_00;
	var_03 = level.var_12750[var_02];
	var_04 = scripts\sp\_utility::func_7B92();
	var_04 sethudtutorialmessage(var_03);
}

//Function Number: 18
func_900E(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	level notify("hint_change_config");
	level endon("hint_change_config");
	var_07 = func_12DB(param_01,param_02,param_03,param_04,param_05,param_06);
	while(isdefined(level.var_4B80) && level.var_4B80)
	{
		var_08 = func_12DB(param_01,param_02,param_03,param_04,param_05,param_06);
		if(var_08 != var_07)
		{
			var_07 = var_08;
			func_12DC(var_07,param_00);
			func_12DD(var_07,param_00);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 19
func_9021(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self notify("new_hint");
	var_07 = gettime();
	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	if(!isalive(self))
	{
		return;
	}

	scripts\sp\_utility::func_65E8("global_hint_in_use");
	if(isdefined(self.var_4B7A))
	{
		if(self.var_4B7A == param_00)
		{
			return;
		}
		else
		{
			self.var_4B7A = param_00;
			scripts\sp\_utility::func_65E1("global_hint_in_use");
			wait(0.05);
		}
	}

	self.var_4B7A = param_00;
	scripts\sp\_utility::func_65E1("global_hint_in_use");
	level.var_4B80 = 1;
	level.var_8FE4 = param_01;
	level endon("friendlyfire_mission_fail");
	self sethudtutorialmessage(param_00);
	var_08 = spawnstruct();
	var_08.var_6AB8 = 0;
	if(isdefined(param_05))
	{
		var_08 thread func_9014(param_05);
	}

	var_08 thread func_52AB();
	var_08 thread func_52AC();
	var_08 thread destroy_hint_on_c6_grab();
	var_08 func_9022(param_00,self);
	if(!scripts\common\utility::istrue(var_08.var_6AB8))
	{
		self clearhudtutorialmessage(1);
	}

	scripts\sp\_utility::func_135AF(var_07,param_06);
	var_08 notify("removing_hint");
	self.var_4B7A = undefined;
	if(var_08.var_6AB8)
	{
		self clearhudtutorialmessage();
	}

	level.var_4B80 = 0;
	scripts\sp\_utility::func_65DD("global_hint_in_use");
}

//Function Number: 20
func_52AB(param_00)
{
	self endon("removing_hint");
	level waittill("friendlyfire_mission_fail");
	self.var_6AB8 = 1;
	self notify("hint_print_remove");
}

//Function Number: 21
destroy_hint_on_c6_grab(param_00)
{
	self endon("removing_hint");
	for(;;)
	{
		if(!isdefined(level.player.var_B55B))
		{
			wait(0.05);
		}
		else if(!isdefined(level.player.var_B55B.var_B5FE))
		{
			wait(0.05);
		}
		else
		{
			break;
		}

		wait(0.05);
	}

	self.var_6AB8 = 1;
	self notify("hint_print_remove");
}

//Function Number: 22
func_52AC(param_00)
{
	self endon("removing_hint");
	level.player waittill("death");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	self.var_6AB8 = 1;
	self notify("hint_print_remove");
}

//Function Number: 23
func_74DE(param_00)
{
	self endon("death");
	param_00 scripts\common\utility::waittill_either("function_done","death");
}

//Function Number: 24
func_74DF(param_00)
{
	func_74DE(param_00);
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

//Function Number: 25
func_74DB(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	if(!isdefined(param_00.var_74D7))
	{
		param_00.var_74D7 = [];
	}

	param_00.var_74D7[param_00.var_74D7.size] = self;
	thread func_74DC(param_00);
	func_74D8(param_00);
	if(isdefined(param_00) && isdefined(param_00.var_74D7))
	{
		self.var_74DA = 1;
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

		if(isdefined(param_00) && isdefined(param_00.var_74D7))
		{
			param_00.var_74D7 = scripts\common\utility::func_22A9(param_00.var_74D7,self);
			param_00 notify("level_function_stack_ready");
		}
	}

	if(isdefined(self))
	{
		self.var_74DA = 0;
		self notify("function_done");
	}
}

//Function Number: 26
func_74DC(param_00)
{
	self endon("function_done");
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00.var_74D7 = scripts\common\utility::func_22A9(param_00.var_74D7,self);
		param_00 notify("level_function_stack_ready");
	}
}

//Function Number: 27
func_74D8(param_00)
{
	param_00 endon("death");
	self endon("death");
	param_00 endon("clear_function_stack");
	while(param_00.var_74D7[0] != self)
	{
		param_00 waittill("level_function_stack_ready");
	}
}

//Function Number: 28
func_1362A(param_00,param_01)
{
	if(isdefined(param_01))
	{
		param_01 endon("death");
	}

	self endon("death");
	param_00 waittill("sounddone");
	return 1;
}

//Function Number: 29
func_22D9(param_00,param_01,param_02)
{
	func_22DA(param_00,param_01,param_02);
	self.var_1187 = 0;
	self notify("_array_wait");
}

//Function Number: 30
func_22DA(param_00,param_01,param_02)
{
	param_00 endon(param_01);
	param_00 endon("death");
	if(isdefined(param_02))
	{
		wait(param_02);
		return;
	}

	param_00 waittill(param_01);
}

//Function Number: 31
func_68CC(param_00)
{
	if(param_00.var_C8FD.size == 0)
	{
		param_00.var_376B [[ param_00.var_74C2 ]]();
	}
	else if(param_00.var_C8FD.size == 1)
	{
		param_00.var_376B [[ param_00.var_74C2 ]](param_00.var_C8FD[0]);
	}
	else if(param_00.var_C8FD.size == 2)
	{
		param_00.var_376B [[ param_00.var_74C2 ]](param_00.var_C8FD[0],param_00.var_C8FD[1]);
	}
	else if(param_00.var_C8FD.size == 3)
	{
		param_00.var_376B [[ param_00.var_74C2 ]](param_00.var_C8FD[0],param_00.var_C8FD[1],param_00.var_C8FD[2]);
	}

	if(param_00.var_C8FD.size == 4)
	{
		param_00.var_376B [[ param_00.var_74C2 ]](param_00.var_C8FD[0],param_00.var_C8FD[1],param_00.var_C8FD[2],param_00.var_C8FD[3]);
	}

	if(param_00.var_C8FD.size == 5)
	{
		param_00.var_376B [[ param_00.var_74C2 ]](param_00.var_C8FD[0],param_00.var_C8FD[1],param_00.var_C8FD[2],param_00.var_C8FD[3],param_00.var_C8FD[4]);
	}
}

//Function Number: 32
func_68CD(param_00)
{
	if(param_00.var_C8FD.size == 0)
	{
		[[ param_00.var_74C2 ]]();
	}
	else if(param_00.var_C8FD.size == 1)
	{
		[[ param_00.var_74C2 ]](param_00.var_C8FD[0]);
	}
	else if(param_00.var_C8FD.size == 2)
	{
		[[ param_00.var_74C2 ]](param_00.var_C8FD[0],param_00.var_C8FD[1]);
	}
	else if(param_00.var_C8FD.size == 3)
	{
		[[ param_00.var_74C2 ]](param_00.var_C8FD[0],param_00.var_C8FD[1],param_00.var_C8FD[2]);
	}

	if(param_00.var_C8FD.size == 4)
	{
		[[ param_00.var_74C2 ]](param_00.var_C8FD[0],param_00.var_C8FD[1],param_00.var_C8FD[2],param_00.var_C8FD[3]);
	}

	if(param_00.var_C8FD.size == 5)
	{
		[[ param_00.var_74C2 ]](param_00.var_C8FD[0],param_00.var_C8FD[1],param_00.var_C8FD[2],param_00.var_C8FD[3],param_00.var_C8FD[4]);
	}
}

//Function Number: 33
func_68CE(param_00,param_01)
{
	if(!isdefined(param_00.var_376B))
	{
		return;
	}

	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		param_01[var_02].var_376B endon(param_01[var_02].var_6317);
	}

	if(param_00.var_C8FD.size == 0)
	{
		param_00.var_376B [[ param_00.var_74C2 ]]();
	}
	else if(param_00.var_C8FD.size == 1)
	{
		param_00.var_376B [[ param_00.var_74C2 ]](param_00.var_C8FD[0]);
	}
	else if(param_00.var_C8FD.size == 2)
	{
		param_00.var_376B [[ param_00.var_74C2 ]](param_00.var_C8FD[0],param_00.var_C8FD[1]);
	}
	else if(param_00.var_C8FD.size == 3)
	{
		param_00.var_376B [[ param_00.var_74C2 ]](param_00.var_C8FD[0],param_00.var_C8FD[1],param_00.var_C8FD[2]);
	}

	if(param_00.var_C8FD.size == 4)
	{
		param_00.var_376B [[ param_00.var_74C2 ]](param_00.var_C8FD[0],param_00.var_C8FD[1],param_00.var_C8FD[2],param_00.var_C8FD[3]);
	}

	if(param_00.var_C8FD.size == 5)
	{
		param_00.var_376B [[ param_00.var_74C2 ]](param_00.var_C8FD[0],param_00.var_C8FD[1],param_00.var_C8FD[2],param_00.var_C8FD[3],param_00.var_C8FD[4]);
	}
}

//Function Number: 34
func_13774(param_00,param_01)
{
	self endon("all_funcs_ended");
	self endon("any_funcs_aborted");
	func_68CE(param_00,param_01);
	self.var_C1--;
	self notify("func_ended");
}

//Function Number: 35
func_13720(param_00,param_01)
{
	self endon("all_funcs_ended");
	self endon("any_funcs_aborted");
	func_68CE(param_00,param_01);
	self.var_1521--;
	self notify("abort_func_ended");
}

//Function Number: 36
func_5767(param_00)
{
	self endon("all_funcs_ended");
	if(!param_00.size)
	{
		return;
	}

	var_01 = 0;
	self.var_1521 = param_00.size;
	var_02 = [];
	scripts\common\utility::func_22A1(param_00,::func_13720,var_02);
	for(;;)
	{
		if(self.var_1521 <= var_01)
		{
			break;
		}

		self waittill("abort_func_ended");
	}

	self notify("any_funcs_aborted");
}

//Function Number: 37
func_12688(param_00)
{
	if(isdefined(self.var_143))
	{
		var_01 = anglestoforward(param_00.angles);
		param_00.origin = param_00.origin + var_01 * self.var_143;
	}

	if(isdefined(self.var_267))
	{
		var_02 = anglestoright(param_00.angles);
		param_00.origin = param_00.origin + var_02 * self.var_267;
	}

	if(isdefined(self.var_367))
	{
		var_03 = anglestoup(param_00.angles);
		param_00.origin = param_00.origin + var_03 * self.var_367;
	}

	if(isdefined(self.var_13E48))
	{
		param_00 method_8004(self.var_13E48);
	}

	if(isdefined(self.var_CBE9))
	{
		param_00 method_8002(self.var_CBE9);
	}

	if(isdefined(self.var_E67D))
	{
		param_00 method_8003(self.var_E67D);
	}
}

//Function Number: 38
func_5F8E(param_00,param_01,param_02,param_03,param_04)
{
	self notify("start_dynamic_run_speed");
	self endon("death");
	self endon("stop_dynamic_run_speed");
	self endon("start_dynamic_run_speed");
	level endon("_stealth_spotted");
	if(scripts\sp\_utility::func_65DF("_stealth_custom_anim"))
	{
		scripts\sp\_utility::func_65E8("_stealth_custom_anim");
	}

	if(!scripts\sp\_utility::func_65DF("dynamic_run_speed_stopped"))
	{
		scripts\sp\_utility::func_65E0("dynamic_run_speed_stopped");
		scripts\sp\_utility::func_65E0("dynamic_run_speed_stopping");
	}
	else
	{
		scripts\sp\_utility::func_65DD("dynamic_run_speed_stopping");
		scripts\sp\_utility::func_65DD("dynamic_run_speed_stopped");
	}

	self.var_E81D = "";
	self.var_C3CB = self.var_BCD6;
	thread func_10FE6();
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
			var_12 = scripts\common\utility::getclosest(var_09.origin,param_04);
			var_11 = distancesquared(var_12.origin,var_09.origin);
		}

		var_13 = 0;
		if(isdefined(self.var_A905))
		{
			var_13 = [[ level.var_5EFB ]](self.var_A905,param_01);
		}
		else if(isdefined(self.var_A906))
		{
			var_13 = [[ level.var_5EFB ]](self.var_A906,param_01);
		}

		if(scripts\anim\utility::func_9D9B() && !self.var_5953)
		{
			self.var_BCD6 = 1;
		}

		if(var_10 < var_06 || var_0F > -0.25 || var_13)
		{
			func_5F8C("sprint");
			wait(0.5);
			continue;
		}
		else if(var_10 < var_05 || var_0F > -0.25)
		{
			func_5F8C("run");
			wait(0.5);
			continue;
		}
		else if(var_11 > var_07)
		{
			if(self.var_1491.var_BCC8 != "stop")
			{
				func_5F8C("stop");
				wait(0.5);
			}

			continue;
		}
		else if(var_10 > var_08)
		{
			func_5F8C("jog");
			wait(0.5);
			continue;
		}
	}
}

//Function Number: 39
func_10FE6()
{
	self endon("start_dynamic_run_speed");
	self endon("death");
	func_10FE7();
	if(!self.var_5953)
	{
		self.var_BCD6 = self.var_C3CB;
	}

	if(isdefined(level.var_EC85["generic"]["DRS_run"]))
	{
		if(isarray(level.var_EC85["generic"]["DRS_run"]))
		{
			scripts\sp\_utility::func_F3CC("DRS_run");
		}
		else
		{
			scripts\sp\_utility::func_F3CB("DRS_run");
		}
	}
	else
	{
		scripts\sp\_utility::func_417A();
	}

	self notify("stop_loop");
	scripts\sp\_utility::func_65DD("dynamic_run_speed_stopping");
	scripts\sp\_utility::func_65DD("dynamic_run_speed_stopped");
}

//Function Number: 40
func_10FE7()
{
	level endon("_stealth_spotted");
	self waittill("stop_dynamic_run_speed");
}

//Function Number: 41
func_5F8C(param_00)
{
	if(self.var_E81D == param_00)
	{
		return;
	}

	self.var_E81D = param_00;
	switch(param_00)
	{
		case "sprint":
			if(scripts\anim\utility::func_9D9B() && !self.var_5953)
			{
				self.var_BCD6 = 1;
			}
			else if(!self.var_5953)
			{
				self.var_BCD6 = 1.15;
			}
	
			if(isarray(level.var_EC85["generic"]["DRS_sprint"]))
			{
				scripts\sp\_utility::func_F3CC("DRS_sprint");
			}
			else
			{
				scripts\sp\_utility::func_F3CB("DRS_sprint");
			}
	
			self notify("stop_loop");
			scripts\sp\_utility::func_1F53();
			scripts\sp\_utility::func_65DD("dynamic_run_speed_stopped");
			break;

		case "run":
			if(!self.var_5953)
			{
				self.var_BCD6 = self.var_C3CB;
			}
	
			if(isdefined(level.var_EC85["generic"]["DRS_run"]))
			{
				if(isarray(level.var_EC85["generic"]["DRS_run"]))
				{
					scripts\sp\_utility::func_F3CC("DRS_run");
				}
				else
				{
					scripts\sp\_utility::func_F3CB("DRS_run");
				}
			}
			else
			{
				scripts\sp\_utility::func_417A();
			}
	
			self notify("stop_loop");
			scripts\sp\_utility::func_1F53();
			scripts\sp\_utility::func_65DD("dynamic_run_speed_stopped");
			break;

		case "stop":
			thread func_5F8F();
			break;

		case "jog":
			if(!self.var_5953)
			{
				self.var_BCD6 = self.var_C3CB;
			}
	
			if(isdefined(level.var_EC85["generic"]["DRS_combat_jog"]))
			{
				if(isarray(level.var_EC85["generic"]["DRS_combat_jog"]))
				{
					scripts\sp\_utility::func_F3CC("DRS_combat_jog");
				}
				else
				{
					scripts\sp\_utility::func_F3CB("DRS_combat_jog");
				}
			}
			else
			{
				scripts\sp\_utility::func_417A();
			}
	
			self notify("stop_loop");
			scripts\sp\_utility::func_1F53();
			scripts\sp\_utility::func_65DD("dynamic_run_speed_stopped");
			break;

		case "crouch":
			break;
	}
}

//Function Number: 42
func_5F8F()
{
	self endon("death");
	if(scripts\sp\_utility::func_65DB("dynamic_run_speed_stopped"))
	{
		return;
	}

	if(scripts\sp\_utility::func_65DB("dynamic_run_speed_stopping"))
	{
		return;
	}

	self endon("stop_dynamic_run_speed");
	scripts\sp\_utility::func_65E1("dynamic_run_speed_stopping");
	scripts\sp\_utility::func_65E1("dynamic_run_speed_stopped");
	self endon("dynamic_run_speed_stopped");
	var_00 = "DRS_run_2_stop";
	lib_0B06::func_1EC8(self,"gravity",var_00);
	scripts\sp\_utility::func_65DD("dynamic_run_speed_stopping");
	while(scripts\sp\_utility::func_65DB("dynamic_run_speed_stopped"))
	{
		var_01 = "DRS_stop_idle";
		thread lib_0B06::func_1ECC(self,var_01);
		if(isdefined(level.var_EC85["generic"]["signal_go"]))
		{
			func_8A0B("go");
		}

		wait(randomfloatrange(12,20));
		if(scripts\sp\_utility::func_65DF("_stealth_stance_handler"))
		{
			scripts\sp\_utility::func_65E8("_stealth_stance_handler");
		}

		self notify("stop_loop");
		if(!scripts\sp\_utility::func_65DB("dynamic_run_speed_stopped"))
		{
			return;
		}

		if(isdefined(level.var_5F8D))
		{
			var_02 = scripts\common\utility::random(level.var_5F8D);
			level thread scripts\sp\_utility::func_DBF3(var_02);
		}

		if(isdefined(level.var_EC85["generic"]["signal_go"]))
		{
			func_8A0B("go");
		}
	}
}

//Function Number: 43
func_8A0B(param_00,param_01,param_02,param_03)
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
	if(self.var_1491.var_D6A5 == "crouch")
	{
		var_05 = var_05 + "_crouch";
	}
	else if(self.script == "cover_right")
	{
		var_05 = var_05 + "_coverR";
	}
	else if(scripts\anim\utility::func_9D9B())
	{
		var_05 = var_05 + "_cqb";
	}

	if(var_04)
	{
		self method_82AE(scripts\sp\_utility::func_7ECF(var_05),1,0,1.1);
		return;
	}

	lib_0B06::func_1EC7(self,var_05);
}

//Function Number: 44
func_764E()
{
	return int(getdvar("g_speed"));
}

//Function Number: 45
func_764F(param_00)
{
	function_01C5("g_speed",int(param_00));
}

//Function Number: 46
func_7647()
{
	return level.player method_810B();
}

//Function Number: 47
func_7648(param_00)
{
	level.player method_82B5(param_00);
}

//Function Number: 48
func_BCF0()
{
	return self.var_BCF5;
}

//Function Number: 49
func_BCF3(param_00)
{
	self.var_BCF5 = param_00;
	self setmovespeedscale(param_00);
}

//Function Number: 50
func_2680()
{
	if(scripts\common\utility::func_6E34("autosave_tactical_player_nade"))
	{
		return;
	}

	scripts\common\utility::flag_init("autosave_tactical_player_nade");
	level.var_267E = 0;
	function_014C("autosave_player_nade","+frag");
	function_014C("autosave_player_nade","-smoke");
	function_014C("autosave_player_nade","+smoke");
	scripts\common\utility::array_thread(level.players,::func_267A);
}

//Function Number: 51
func_267A()
{
	for(;;)
	{
		self waittill("autosave_player_nade");
		scripts\common\utility::flag_set("autosave_tactical_player_nade");
		thread func_267C();
		scripts\common\utility::waittill_any_timeout_1(10,"autosave_grenade_thrown");
		self notify("autosave_grenade_throw_timeout");
		func_267D();
	}
}

//Function Number: 52
func_267C()
{
	self endon("autosave_grenade_throw_timeout");
	self waittill("grenade_fire",var_00);
	thread func_267B(var_00);
	self notify("autosave_grenade_thrown");
}

//Function Number: 53
func_267D()
{
	waittillframeend;
	if(!level.var_267E)
	{
		scripts\common\utility::func_6E2A("autosave_tactical_player_nade");
	}
}

//Function Number: 54
func_267B(param_00)
{
	level.var_267E++;
	param_00 scripts\common\utility::waittill_notify_or_timeout("death",10);
	level.var_267E--;
	func_267D();
}

//Function Number: 55
func_267F()
{
	level notify("autosave_tactical_proc");
	level endon("autosave_tactical_proc");
	level thread scripts\sp\_utility::func_C12D("kill_save",5);
	level endon("kill_save");
	level endon("autosave_tactical_player_nade");
	if(scripts\common\utility::flag("autosave_tactical_player_nade"))
	{
		scripts\common\utility::func_6E5C("autosave_tactical_player_nade",4);
		if(scripts\common\utility::flag("autosave_tactical_player_nade"))
		{
			return;
		}
	}

	var_00 = function_0072("axis");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.var_10C) && isplayer(var_02.var_10C))
		{
			return;
		}
	}

	waittillframeend;
	scripts\sp\_utility::func_2669();
}

//Function Number: 56
func_BDE6(param_00,param_01,param_02,param_03)
{
	scripts\sp\_utility::func_BDEC(param_01);
	level endon("stop_music");
	wait(param_01);
	thread scripts\sp\_utility::func_BDE5(param_00,undefined,param_02,param_03);
}

//Function Number: 57
func_BDE2(param_00,param_01,param_02,param_03,param_04,param_05)
{
	scripts\sp\_utility::func_BDEC(param_02);
	level endon("stop_music");
	wait(param_02);
	thread func_BDE1(param_00,param_01,undefined,param_03,param_04,param_05);
}

//Function Number: 58
func_BDE1(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_02) && param_02 > 0)
	{
		thread func_BDE2(param_00,param_01,param_02,param_03,param_04,param_05);
		return;
	}

	scripts\sp\_utility::func_BDEC();
	level endon("stop_music");
	scripts\sp\_utility::func_BDF2(param_00,param_03,param_04);
	if(isdefined(param_05) && param_05 == 1 && scripts\common\utility::func_6E34("_stealth_spotted"))
	{
		level endon("_stealth_spotted");
		thread func_BDE4(param_00,param_01,param_02);
	}

	var_06 = scripts\sp\_utility::func_BDF1(param_00);
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(param_01 <= 10)
	{
		var_06 = var_06 + param_01;
	}

	wait(var_06);
	scripts\sp\_utility::func_BDDF(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 59
func_BDE4(param_00,param_01,param_02)
{
	level endon("stop_music");
	scripts\common\utility::flag_wait("_stealth_spotted");
	function_0146(0.5);
	while(scripts\common\utility::flag("_stealth_spotted"))
	{
		scripts\common\utility::func_6E5A("_stealth_spotted");
		wait(1);
	}

	thread scripts\sp\_utility::func_BDDF(param_00,param_01,param_02);
}

//Function Number: 60
func_5AAD(param_00,param_01,param_02)
{
	self endon("death");
	self endon("stop_sliding");
	var_03 = self;
	var_04 = undefined;
	var_05 = param_00.origin;
	var_06 = param_00.origin;
	var_07 = undefined;
	for(;;)
	{
		var_08 = var_03 getnormalizedmovement();
		var_09 = anglestoforward(var_03.angles);
		var_0A = anglestoright(var_03.angles);
		var_08 = (var_08[1] * var_0A[0] + var_08[0] * var_09[0],var_08[1] * var_0A[1] + var_08[0] * var_09[1],0);
		param_00.slidevelocity = param_00.slidevelocity + var_08 * param_01;
		var_03.var_7601.origin = param_00.origin + anglestoforward(param_00.var_77BA.angles) * 400;
		wait(0.05);
		param_00.slidevelocity = param_00.slidevelocity * 1 - param_02;
	}
}

//Function Number: 61
func_A5CF(param_00)
{
	self endon("death");
	if(isdefined(param_00))
	{
		wait(randomfloat(param_00));
	}

	playfxontag(scripts\common\utility::getfx("flesh_hit"),self,"tag_eye");
	self method_81D0(level.player.origin);
}

//Function Number: 62
func_12E1F(param_00,param_01)
{
	self endon("death");
	var_02 = 0;
	for(;;)
	{
		if(self.var_99E5 > 0.0001 && gettime() > 300)
		{
			if(!var_02)
			{
				self method_8244(param_01);
				var_02 = 1;
			}
		}
		else if(var_02)
		{
			self stoprumble(param_01);
			var_02 = 0;
		}

		var_03 = 1 - self.var_99E5;
		var_03 = var_03 * 1000;
		self.origin = param_00 geteye() + (0,0,var_03);
		wait(0.05);
	}
}

//Function Number: 63
func_D961(param_00,param_01,param_02,param_03,param_04)
{
	waittillframeend;
	if(!isdefined(self.var_10B89))
	{
		self.var_10B89 = 0;
	}

	if(!isdefined(self.var_62A3))
	{
		self.var_62A3 = 1;
	}

	if(!isdefined(self.var_2857))
	{
		self.var_2857 = 0;
	}

	var_05 = self.time * 20;
	var_06 = self.var_62A3 - self.var_10B89;
	self.var_10FCB = 0;
	if(isdefined(param_04))
	{
		for(var_07 = 0;var_07 <= var_05 && !self.var_10FCB;var_07++)
		{
			var_08 = self.var_2857 + var_07 * var_06 / var_05;
			param_01 thread [[ param_00 ]](var_08,param_02,param_03,param_04);
			wait(0.05);
		}

		return;
	}

	if(isdefined(var_05))
	{
		for(var_07 = 0;var_07 <= var_05 && !self.var_10FCB;var_07++)
		{
			var_08 = self.var_2857 + var_07 * var_06 / var_05;
			param_01 thread [[ param_00 ]](var_08,param_02,param_03);
			wait(0.05);
		}

		return;
	}

	if(isdefined(param_04))
	{
		for(var_07 = 0;var_07 <= var_05 && !self.var_10FCB;var_07++)
		{
			var_08 = self.var_2857 + var_07 * var_06 / var_05;
			param_01 thread [[ param_00 ]](var_08,param_02);
			wait(0.05);
		}

		return;
	}

	for(var_07 = 0;var_07 <= var_05 && !self.var_10FCB;var_07++)
	{
		var_08 = self.var_2857 + var_07 * var_06 / var_05;
		param_01 thread [[ param_00 ]](var_08);
		wait(0.05);
	}
}

//Function Number: 64
func_78D1()
{
	var_00 = "allies";
	if(isdefined(self.var_ED34))
	{
		var_00 = "axis";
	}

	var_00 = scripts\sp\_colors::func_7CE4(var_00);
	var_01 = [];
	if(var_00 == "allies")
	{
		var_02 = scripts\sp\_colors::func_78D9(self.var_ED33,"allies");
		var_01 = var_02["colorCodes"];
	}
	else
	{
		var_02 = scripts\sp\_colors::func_78D9(self.var_ED34,"axis");
		var_01 = var_02["colorCodes"];
	}

	var_03 = [];
	var_03["team"] = var_00;
	var_03["codes"] = var_01;
	return var_03;
}

//Function Number: 65
func_50E5(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	self endon("stop_delay_thread");
	wait(param_01);
	if(isdefined(param_07))
	{
		childthread [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07);
		return;
	}

	if(isdefined(param_06))
	{
		childthread [[ param_00 ]](param_02,param_03,param_04,param_05,param_06);
		return;
	}

	if(isdefined(param_05))
	{
		childthread [[ param_00 ]](param_02,param_03,param_04,param_05);
		return;
	}

	if(isdefined(param_04))
	{
		childthread [[ param_00 ]](param_02,param_03,param_04);
		return;
	}

	if(isdefined(param_03))
	{
		childthread [[ param_00 ]](param_02,param_03);
		return;
	}

	if(isdefined(param_02))
	{
		childthread [[ param_00 ]](param_02);
		return;
	}

	childthread [[ param_00 ]]();
}

//Function Number: 66
func_6E7D(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	scripts\common\utility::flag_wait(param_01[0]);
	scripts\common\utility::func_512D(param_00,param_01[1],param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 67
func_13844(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	self waittill(param_01[0]);
	scripts\common\utility::func_512D(param_00,param_01[1],param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 68
func_178E()
{
	level notify("kill_add_wait_asserter");
	level endon("kill_add_wait_asserter");
	for(var_00 = 0;var_00 < 20;var_00++)
	{
		waittillframeend;
	}
}

//Function Number: 69
func_12D95()
{
}

//Function Number: 70
func_4461(param_00,param_01,param_02,param_03)
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
			var_07 = distance(param_01[var_05[var_06]].var_13125["origin"],param_00);
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
	var_04 = distance(var_07.var_13125["origin"],param_02);
	for(var_06 = 1;var_06 < var_04.size;var_06++)
	{
		var_07 = distance(param_01[var_04[var_06]].var_13125["origin"],param_00);
		if([[ param_03 ]](var_07,param_02))
		{
			continue;
		}

		param_02 = var_07;
		var_05 = param_01[var_04[var_06]];
	}

	return var_05;
}

//Function Number: 71
func_13816()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		waittillframeend;
		if(var_00.var_4BF7 == self)
		{
			return var_00;
		}
	}
}

//Function Number: 72
func_1789()
{
	self.var_1274A = [];
	self waittill("trigger",var_00);
	var_01 = self.var_1274A;
	self.var_1274A = undefined;
	foreach(var_03 in var_01)
	{
		thread [[ var_03 ]](var_00);
	}
}

//Function Number: 73
func_1778(param_00)
{
	if(!isdefined(level.var_EC91[param_00]))
	{
		level.var_EC91[param_00] = param_00;
	}
}

//Function Number: 74
func_1773(param_00)
{
	if(!isdefined(level.var_EC8E[param_00]))
	{
		level.var_EC8E[param_00] = param_00;
	}
}

//Function Number: 75
func_175F(param_00)
{
	if(!isdefined(level.var_EC85[self.var_1FBB]))
	{
		level.var_EC85[self.var_1FBB] = [];
	}

	if(!isdefined(level.scr_sound[self.var_1FBB]))
	{
		level.scr_sound[self.var_1FBB] = [];
	}

	if(!isdefined(level.scr_sound[self.var_1FBB][param_00]))
	{
		level.scr_sound[self.var_1FBB][param_00] = param_00;
	}
}

//Function Number: 76
func_1760(param_00)
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

//Function Number: 77
func_1287(param_00,param_01)
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_02);
		scripts\common\utility::flag_set(param_00);
		if(!param_01)
		{
			return;
		}

		while(var_02 istouching(self))
		{
			wait(0.05);
		}

		scripts\common\utility::func_6E2A(param_00);
	}
}

//Function Number: 78
func_7615(param_00,param_01)
{
	param_00.var_75BA = 1;
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(param_01)
	{
		func_22D4(param_00.var_7542,::scripts\common\utility::func_C9CF);
		return;
	}

	scripts\common\utility::array_thread(param_00.var_7542,::scripts\common\utility::func_C9CF);
}

//Function Number: 79
func_22D4(param_00,param_01,param_02)
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
			scripts\common\utility::array_thread(var_04,param_01);
			wait(0.05);
			var_04 = [];
		}
	}
}

//Function Number: 80
func_28D9(param_00)
{
	level endon("battlechatter_off_thread");
	scripts\anim\battlechatter::func_29C1();
	while(!isdefined(level.var_3D4B))
	{
		wait(0.05);
	}

	anim.var_29B7 = 1;
	wait(1.5);
	if(isdefined(param_00))
	{
		scripts\sp\_utility::func_F2DC(param_00,1);
		var_01 = function_0072(param_00);
	}
	else
	{
		foreach(param_00 in level.var_115E7)
		{
			scripts\sp\_utility::func_F2DC(param_00,1);
		}

		var_01 = function_0072();
	}

	if(isdefined(level.var_A056) && isdefined(level.var_A056.var_1630))
	{
		var_01 = scripts\common\utility::array_combine(var_01,level.var_A056.var_1630);
	}

	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		var_01[var_04] scripts\sp\_utility::func_F2DA(1);
	}
}

//Function Number: 81
func_517B(param_00,param_01)
{
	param_00 endon("death");
	self waittill("death");
	if(isdefined(param_00))
	{
		if(param_00 method_81CB())
		{
			param_00 waittill(param_01);
		}

		param_00 delete();
	}
}

//Function Number: 82
func_F3A7(param_00,param_01)
{
	thread scripts\sp\_utility::func_F3A5(param_00,param_01,::scripts\sp\_utility::func_61B8,"set_flag_on_spawned");
}

//Function Number: 83
func_636E()
{
	self waittill("death");
	waittillframeend;
	self notify("end_explode");
}

//Function Number: 84
func_13757(param_00)
{
	self waittill("death");
	param_00.var_C1--;
	param_00 notify("waittill_dead guy died");
}

//Function Number: 85
func_13756(param_00)
{
	scripts\common\utility::waittill_either("death","pain_death");
	param_00.var_C1--;
	param_00 notify("waittill_dead_guy_dead_or_dying");
}

//Function Number: 86
func_13758(param_00)
{
	wait(param_00);
	self notify("thread_timed_out");
}

//Function Number: 87
dyndof_thread()
{
	level endon("stop_dynDOF");
	for(;;)
	{
		var_00 = dyndof_distance();
		if(var_00 > -1)
		{
			dyndof_set(var_00);
		}

		wait(0.05);
	}
}

//Function Number: 88
dyndof_set(param_00)
{
	var_01 = 800;
	var_02 = param_00 / var_01;
	var_03 = level.dyndof.nearstart * var_02;
	var_04 = level.dyndof.nearend * var_02;
	var_05 = level.dyndof.farstart * var_02;
	var_06 = level.dyndof.farend * var_02;
	var_04 = var_03 + level.dyndof.nearend - level.dyndof.nearstart * var_02;
	var_04 = clamp(var_04,level.dyndof.nearendmindist,level.dyndof.nearendmaxdist);
	var_06 = var_05 + level.dyndof.farend - level.dyndof.farstart * var_02;
	scripts\sp\_art::func_583F(var_03,var_04,level.dyndof.nearblur,var_05,var_06,level.dyndof.farblur,level.dyndof.focusspeed);
}

//Function Number: 89
dyndof_distance()
{
	var_00 = level.dyndof.maxfocusdist * 0.5;
	var_01 = 20;
	var_02 = dyndof_getplayerangles();
	var_03 = dyndof_getplayerorigin() + anglestoforward(var_02) * var_00;
	if(level.dyndof.prevorigin == var_03 && level.dyndof.prevangles == var_02)
	{
		return -1;
	}

	level.dyndof.prevorigin = var_03;
	level.dyndof.prevangles = var_02;
	var_02 = [];
	var_04 = 3;
	var_02[var_02.size] = (var_04 * -1,0,0);
	var_02[var_02.size] = (0,var_04,0);
	var_02[var_02.size] = (0,var_04 * -1,0);
	var_02[var_02.size] = (0,0,0);
	var_05 = [];
	foreach(var_07 in var_02)
	{
		var_08 = dyndof_trace_internal(var_07);
		if(!isdefined(var_08))
		{
			continue;
		}

		var_05[var_05.size] = var_08[0];
	}

	if(var_05.size == 0)
	{
		return level.dyndof.maxfocusdist;
	}

	var_09 = 0;
	var_0A = var_05[var_09];
	for(var_0B = 1;var_0B < var_05.size;var_0B++)
	{
		if(var_05[var_0B]["fraction"] < var_0A["fraction"])
		{
			var_0A = var_05[var_0B];
		}
	}

	return level.dyndof.maxfocusdist * var_0A["fraction"];
}

//Function Number: 90
dyndof_trace_internal(param_00)
{
	param_00 = combineangles(dyndof_getplayerangles(),param_00);
	var_01 = dyndof_getplayerorigin();
	var_02 = dyndof_getplayerorigin() + anglestoforward(param_00) * level.dyndof.maxfocusdist;
	return function_0287(var_01,var_02,level.dyndof.var_457D,[level.player],1,"physicsquery_closest",0);
}

//Function Number: 91
dyndof_getplayerorigin()
{
	if(level.player islinked())
	{
		var_00 = level.player getlinkedparent();
		if(isdefined(var_00.dyndof_hastag))
		{
			if(var_00.dyndof_hastag)
			{
				return var_00 gettagorigin("tag_camera");
			}
		}
		else if(isdefined(var_00.model))
		{
			if(scripts\sp\_utility::func_8C32(var_00.model,"tag_camera"))
			{
				var_00.dyndof_hastag = 1;
			}
			else
			{
				var_00.dyndof_hastag = 0;
			}
		}
	}

	return level.player method_816E();
}

//Function Number: 92
dyndof_getplayerangles()
{
	var_00 = level.player getplayerangles();
	return var_00;
}

//Function Number: 93
create_dyndof()
{
	var_00 = spawnstruct();
	var_00.maxfocusdist = -15536;
	var_00.focusspeed = 0.3;
	var_00.var_457D = get_dyndof_contents();
	var_00.nearstart = 0;
	var_00.nearend = 500;
	var_00.nearblur = 5;
	var_00.farstart = 2000;
	var_00.farend = 5000;
	var_00.farblur = 5;
	var_00.nearendmindist = 30;
	var_00.nearendmaxdist = 1000;
	var_00.farendmindist = 200;
	var_00.farendmaxdist = var_00.maxfocusdist;
	var_00.prevangles = (0,0,0);
	var_00.prevorigin = (0,0,0);
	return var_00;
}

//Function Number: 94
destroy_dyndof()
{
	level.dyndof = undefined;
}

//Function Number: 95
get_dyndof_contents()
{
	var_00 = ["physicscontents_actor","physicscontents_canshootclip","physicscontents_clipshot","physicscontents_corpse","physicscontents_corpseclipshot","physicscontents_detail","physicscontents_foliage","physicscontents_item","physicscontents_itemclip","physicscontents_mantle","physicscontents_player","physicscontents_solid","physicscontents_structural","physicscontents_vehicle","physicscontents_vehicleclip","physicscontents_water"];
	return physics_createcontents(var_00);
}