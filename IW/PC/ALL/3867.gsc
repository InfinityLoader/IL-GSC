/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3867.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 12:31:04 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_9732();
	scripts\sp\_utility::func_65E0("stealth_enabled");
	scripts\sp\_utility::func_65E1("stealth_enabled");
	scripts\sp\_utility::func_65E0("stealth_override_goal");
	scripts\sp\_utility::func_65E0("stealth_hold_position");
	scripts\sp\_utility::func_65E0("stealth_attack");
	scripts\sp\_utility::func_65E0("stealth_cover_blown");
	lib_0F27::func_868B("stealth_spotted");
	lib_0F27::func_868B("stealth_cover_blown");
	lib_0F27::func_8682();
	self.var_10E6D.var_2A7D = "patrol";
	self.var_527B = "patrol";
	lib_0A1B::func_2980("patrol","unaware");
	lib_0F27::func_F557(::func_D7DD);
	lib_0F1C::func_6854();
	thread func_B960(128,600);
	thread func_10A9E();
	thread func_4DFE();
	thread func_3D64();
	thread func_7346();
	if(isdefined(self.target))
	{
		self.var_15C = 32;
		thread lib_0B77::func_8409(undefined,undefined,undefined,undefined,undefined);
	}

	func_F299("reset");
	self.var_10E6D.var_13529 = scripts\common\utility::array_randomize(["sf1","sf2","sf3","sf4"])[0];
}

//Function Number: 2
func_9732()
{
	self.var_10E6D = spawnstruct();
	self.var_10E6D.var_74D5 = [];
	self.var_10E6D.var_B470 = 2;
	self.var_4409 = self.var_BC;
	self.var_10E6D.var_DD1D = 0;
	scripts\sp\_utility::func_F292("setdef");
	self.var_1FD = squared(level.var_10E6D.var_21["ai_eventDistFootstepSprint"]["hidden"]);
	lib_0F19::func_4682();
}

//Function Number: 3
func_10A9E()
{
	self endon("death");
	for(;;)
	{
		scripts\sp\_utility::func_65E3("stealth_enabled");
		if(lib_0F27::func_8689("stealth_spotted"))
		{
			thread func_10E20();
		}

		lib_0F27::func_868E("stealth_spotted");
		scripts\sp\_utility::func_65E3("stealth_enabled");
		thread func_10E1B();
		scripts\sp\_utility::func_65E3("stealth_enabled");
		lib_0F27::func_868D("stealth_spotted");
	}
}

//Function Number: 4
func_3D64()
{
	self endon("death");
	while(!isdefined(self.var_10E6D.var_C9A8))
	{
		wait(0.05);
	}

	if(lib_0F27::func_8689("stealth_cover_blown"))
	{
		thread func_1272D();
	}
}

//Function Number: 5
func_4DFE()
{
	self waittill("death");
	if(isdefined(self))
	{
		lib_0F26::func_117D4("death");
		if(isdefined(self.stealth_vo_ent))
		{
			self.stealth_vo_ent method_83AD();
			scripts\common\utility::func_136F7();
			self.stealth_vo_ent delete();
			self.stealth_vo_ent = undefined;
		}
	}
}

//Function Number: 6
func_1645()
{
	self notify("active_sense_thread");
	self endon("active_sense_thread");
	self endon("death");
	self endon("pain_death");
	for(;;)
	{
		scripts\sp\_utility::func_65E3("stealth_enabled");
		if(!lib_0F27::func_869D())
		{
			if(!scripts\sp\_utility::func_65DB("stealth_attack"))
			{
				lib_0F19::func_468A();
				func_DAB0();
			}
		}

		wait(0.1);
	}
}

//Function Number: 7
func_DAB0()
{
	if(self.var_180)
	{
		return;
	}

	if(!isdefined(level.var_10E6D))
	{
		return;
	}

	var_00 = self.origin;
	var_01 = (0,0,0);
	if(scripts\sp\_utility::func_8C32(self.model,"j_spine4"))
	{
		var_00 = self gettagorigin("j_spine4");
		var_01 = (0,0,35);
	}

	foreach(var_03 in level.players)
	{
		var_04 = 0;
		if(!isalive(var_03))
		{
			continue;
		}

		if(issentient(var_03) && var_03.ignoreme || var_03.var_204)
		{
			continue;
		}

		var_05 = distancesquared(var_00,var_03.origin + var_01);
		if(isdefined(level.var_10E6D.var_DAB2) && level.var_10E6D.var_DAB2 > 0)
		{
			var_06 = squared(level.var_10E6D.var_DAB2);
			if(var_05 < var_06)
			{
				var_04 = 1;
			}
		}

		if(!var_04 && isdefined(level.var_10E6D.var_DAB3) && level.var_10E6D.var_DAB3 > 0)
		{
			var_07 = squared(level.var_10E6D.var_DAB3);
			if(var_05 < var_07 && self method_805F(var_03,0))
			{
				var_04 = 1;
			}
		}

		if(var_04)
		{
			self method_84F7("proximity",var_03,var_03.origin);
			return;
		}
	}
}

//Function Number: 8
func_F2E0(param_00)
{
	if(!isdefined(self.var_10E6D))
	{
		return;
	}

	if(param_00 && self.var_29 <= 2)
	{
		self.var_10E6D.var_2B96 = 1;
		func_F59D("blind");
		return;
	}

	self.var_10E6D.var_2B96 = undefined;
	if(self.var_29 > 2)
	{
		func_F59D("spotted");
		return;
	}

	func_F59D("hidden");
}

//Function Number: 9
func_F59D(param_00)
{
	switch(param_00)
	{
		case "blind":
			lib_0F26::func_117D4("hidden");
			self.var_145 = 1;
			self.var_146 = 1;
			self.var_147 = 0;
			self.var_297 = 0;
			break;

		case "hidden":
			if(lib_0F22::func_9B2C())
			{
				lib_0F26::func_117D4("investigate");
			}
			else
			{
				lib_0F26::func_117D4("hidden");
			}
	
			self.var_145 = 0.7;
			self.var_146 = 0.86;
			self.var_147 = 0.97;
			self.var_297 = 1;
			break;

		case "spotted":
			lib_0F26::func_117D4("spotted");
			self.var_145 = 0.01;
			self.var_147 = 0;
			self.var_297 = 0;
			break;
	}
}

//Function Number: 10
func_10E1B()
{
	if(scripts\common\utility::istrue(self.var_10E6D.var_2B96))
	{
		func_F59D("blind");
	}
	else
	{
		func_F59D("hidden");
	}

	self.var_12E = undefined;
	self.var_5951 = 1;
	self.var_595D = 1;
	thread scripts\sp\_utility::func_F2DA(0);
	self.var_FED1 = undefined;
	self.var_BC = self.var_4409;
	self.var_10E6D.var_DD1D = 0;
	thread lib_0F19::func_467C();
	lib_0F27::func_F4C9();
	if(!isdefined(self.var_10E6D.var_C3B5))
	{
		self.var_10E6D.var_C3B5 = self.var_BC;
		self.var_BC = "no_cover";
	}

	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01.var_10E6D))
		{
			continue;
		}

		if(!isdefined(var_01.var_10E6D.var_10A9D))
		{
			continue;
		}

		var_01.var_10E6D.var_10A9D[self.var_12BA3] = undefined;
	}

	lib_0F22::func_9B25();
	thread func_1645();
	self.var_10E6D.var_2A7D = "patrol";
	self.var_EF = 1;
	self method_8071();
	func_F299("reset");
	lib_0F1C::func_6839();
}

//Function Number: 11
func_10E20()
{
	func_F59D("spotted");
	self.var_5951 = undefined;
	self.var_595D = undefined;
	self.var_BC = self.var_4409;
	self.var_EF = 0;
	thread scripts\sp\_utility::func_F2DA(1);
	lib_0F22::func_9B25();
	if(isdefined(self.var_10E6D.var_C3B5))
	{
		self.var_BC = self.var_10E6D.var_C3B5;
		self.var_10E6D.var_C3B5 = undefined;
	}

	self notify("active_sense_thread");
	var_00 = undefined;
	var_01 = self.origin;
	if(isdefined(level.var_10E6D.var_8677.var_10A9B))
	{
		var_00 = level.var_10E6D.var_8677.var_10A9B[self.var_EED1];
	}

	if(isdefined(var_00))
	{
		var_01 = var_00.origin;
		self getenemyinfo(var_00);
	}
	else
	{
		var_00 = undefined;
	}

	self method_84F7("combat",var_00,var_01);
}

//Function Number: 12
func_7346()
{
	self endon("death");
	for(;;)
	{
		self.var_296 = 0;
		scripts\sp\_utility::func_65E3("stealth_enabled");
		if(self.var_29 <= 2 && lib_0A1A::func_2354("patrol_move"))
		{
			self.var_296 = 1;
		}

		wait(0.05);
	}
}

//Function Number: 13
func_1B3D(param_00)
{
	thread lib_0F27::func_1284A("hmph");
	func_F299("reset");
	thread func_10E1B();
	lib_0F27::func_8468();
}

//Function Number: 14
func_F5C9()
{
	self endon("death");
	self endon("pain_death");
	self.var_595D = undefined;
	self [[ self.var_10E6D.var_D7DE ]]();
	if(self.ignoreme)
	{
		return;
	}

	lib_0F22::func_9B25();
	var_00 = self.var_10C;
	if(isdefined(var_00))
	{
		level.var_10E6D.var_8677.var_10A9B[self.var_EED1] = var_00;
		if(isdefined(var_00.var_10E6D))
		{
			var_00 lib_0F27::func_868C("stealth_spotted");
		}
	}

	lib_0F27::func_868C("stealth_spotted");
}

//Function Number: 15
func_D7DD()
{
	wait(2);
}

//Function Number: 16
func_F299(param_00)
{
	if(!scripts\sp\_utility::func_65DB("stealth_enabled"))
	{
		return;
	}

	if(isdefined(self.var_1B44) && self.var_1B44 == param_00)
	{
		return;
	}

	self notify("set_alert_level");
	self endon("set_alert_level");
	self endon("death");
	if(param_00 == "attack" || param_00 == "combat")
	{
		thread func_F5C9();
	}

	self.var_1B44 = param_00;
	while(isdefined(self.var_2DC))
	{
		wait(0.05);
	}

	lib_0F27::func_F5B7(param_00);
	self notify("stealth_alertlevel_change",param_00);
	self.var_28 = lib_0F27::func_1B40(param_00);
	var_01 = self.var_29 > 2;
	lib_0F1C::func_6837(!var_01);
	self.var_182 = !var_01;
}

//Function Number: 17
func_F345()
{
	level lib_0F27::func_F5B4("go_to_node_wait",::func_8415);
	level lib_0F27::func_F5B4("go_to_node_arrive",::func_840C);
	level lib_0F27::func_F5B4("reset",::func_1B3D);
	level lib_0F27::func_F5B4("set_patrol_style",::lib_0F27::func_F4C8);
	level lib_0F27::func_F5B4("trigger_cover_blown",::func_1272D);
	level lib_0F27::func_F5B4("set_blind",::func_F2E0);
	level lib_0F27::func_F5B4("investigate",::func_6847);
	level lib_0F27::func_F5B4("cover_blown",::func_6847);
	level lib_0F27::func_F5B4("combat",::func_6847);
}

//Function Number: 18
func_B960(param_00,param_01)
{
	var_02 = undefined;
	var_03 = self.team;
	for(;;)
	{
		if(!isalive(self))
		{
			return;
		}

		self waittill("damage",var_04,var_05,var_06,var_07);
		func_3DAF(var_04,var_05,var_07);
		var_08 = self.origin;
		if(isalive(self) && !scripts\sp\_utility::func_65DB("stealth_enabled"))
		{
			continue;
		}

		if(isalive(var_05))
		{
			var_02 = var_05;
		}

		if(!isdefined(var_02))
		{
			continue;
		}

		if(isplayer(var_02) || isdefined(var_02.team) && var_02.team != var_03)
		{
			break;
		}

		if(isdefined(var_02.classname) && var_02.classname == "script_model")
		{
			if(var_02.var_9D62)
			{
				break;
			}
		}
	}

	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(var_02) && var_02 == level.player && lib_0E29::func_87A7() == "controllingrobot")
	{
		var_02 method_834E();
	}

	if(isdefined(self.var_10E6D.var_C813))
	{
		param_00 = self.var_10E6D.var_C813;
	}
	else if(isdefined(level.var_10E6D.var_C813))
	{
		param_00 = level.var_10E6D.var_C813;
	}

	if(isdefined(self.var_10E6D.var_C814))
	{
		param_01 = self.var_10E6D.var_C814;
	}
	else if(isdefined(level.var_10E6D.var_C814))
	{
		param_01 = level.var_10E6D.var_C814;
	}

	lib_0F1C::func_67FF("attack",var_02,param_00,param_01);
}

//Function Number: 19
func_3DAF(param_00,param_01,param_02)
{
	if(param_00 > 0 && self.var_DE != "MOD_MELEE" && self.var_1B44 != "attack" && self.var_1B44 != "combat")
	{
		var_03 = self geteye();
		if(distancesquared(param_02,var_03) < squared(20))
		{
			self dodamage(self.health,param_02,param_01,param_01,"MOD_HEAD_SHOT");
		}
	}
}

//Function Number: 20
func_6847(param_00)
{
	param_00.var_9B22 = param_00.origin;
	if(isdefined(self.var_10C) && isdefined(param_00.var_114) && param_00.var_114 == self.var_10C)
	{
		param_00.var_9B22 = self lastknownpos(self.var_10C);
	}
	else if(isdefined(param_00.var_114) && param_00.var_12AE9 == "bulletwhizby")
	{
		param_00.var_9B22 = param_00.var_114.origin;
	}

	func_6849(param_00);
	if(func_6848(param_00))
	{
		return;
	}

	self.var_10E6D.var_A908 = gettime();
	if(!func_DD2D(param_00))
	{
		func_DD2C(param_00);
	}

	switch(param_00.type)
	{
		case "investigate":
			thread func_6859(param_00);
			break;

		case "cover_blown":
			thread func_6810(param_00);
			break;

		case "combat":
			thread func_6808(param_00);
			break;
	}

	var_01 = lib_0F18::func_10EBB(param_00.var_12AE9);
	if(isdefined(var_01) && var_01 != ::func_6847)
	{
		self thread [[ var_01 ]](param_00);
	}
}

//Function Number: 21
func_6848(param_00)
{
	var_01 = self.var_10E6D.var_6896;
	if(!isdefined(var_01))
	{
		var_01 = level.var_10E6D.var_6896;
	}

	if(isdefined(var_01))
	{
		var_02 = lib_0F1C::func_6894(var_01,param_00.type);
		if(var_02 > 0)
		{
			return 1;
		}
	}

	if(scripts\common\utility::istrue(level.var_10E6D.var_5659) && func_6872(param_00))
	{
		return 1;
	}

	if(isdefined(param_00.var_114) && param_00.var_114 == level.player && lib_0E29::func_87A7() == "controllingrobot" && func_6871(param_00))
	{
		self.var_10E6D.var_683A[param_00.var_12AE9] = 0;
		self.var_10E6D.var_683A[param_00.type] = 0;
		return 1;
	}

	var_03 = lib_0F18::func_10EBB("event_" + param_00.type);
	if(isdefined(var_03))
	{
		return lib_0F18::func_10E8A("event_" + param_00.type,param_00);
	}

	return 0;
}

//Function Number: 22
func_6872(param_00)
{
	if(issentient(param_00.var_114))
	{
		switch(param_00.var_12AE9)
		{
			case "proximity":
			case "footstep_walk":
			case "footstep_sprint":
			case "footstep":
				thread lib_0F26::func_117C5(param_00.var_114,1);
				return 1;
		}
	}

	return 0;
}

//Function Number: 23
func_6871(param_00)
{
	if(issentient(param_00.var_114))
	{
		switch(param_00.var_12AE9)
		{
			case "proximity":
				return 1;

			case "silenced_shot":
			case "projectile_impact":
			case "gunshot":
			case "bulletwhizby":
			case "grenade danger":
			case "explode":
				param_00.type = "combat";
				return 0;
		}
	}

	if(param_00.type != "combat")
	{
		return 1;
	}

	return 0;
}

//Function Number: 24
func_6849(param_00)
{
	if(!isdefined(param_00) || !isdefined(param_00.var_12AE9))
	{
		return;
	}

	switch(param_00.var_12AE9)
	{
		case "sight":
			if(isdefined(self.var_10E6D.var_117CA) && self.var_10E6D.var_117CA == 0)
			{
				param_00.type = "combat";
			}
			break;
	}
}

//Function Number: 25
func_6859(param_00)
{
	func_F299("warning1");
	thread lib_0F22::func_9B23(param_00);
}

//Function Number: 26
func_6810(param_00)
{
	func_F299("warning2");
	if(scripts\common\utility::istrue(level.var_10E6D.var_5659))
	{
		switch(param_00.var_12AE9)
		{
			case "silenced_shot":
			case "gunshot":
			case "explode":
				lib_0F27::func_F357(0);
				level scripts\common\utility::func_5127(20,::lib_0F27::func_F357,1);
				break;
		}
	}

	thread lib_0F22::func_9B23(param_00);
	if(!lib_0F27::func_8693())
	{
		var_01 = lib_0F27::func_1284A("backup_call",4);
		if(isdefined(var_01) && var_01)
		{
			lib_0F27::func_4F6C("seek_backup",param_00.var_9B22,randomintrange(1,2),800);
		}
	}
}

//Function Number: 27
func_6808(param_00)
{
	self notify("investigate_behavior");
	self notify("stop_going_to_node");
	self notify("investigate_forget");
	if(isdefined(self.var_10E6D.var_92CC) && isdefined(self.var_4E2A))
	{
		self.var_4E2A = undefined;
	}

	self.var_10E6D.var_2A7D = "combat";
	func_F299("attack");
	if(issentient(param_00.var_114) && !isdefined(self.var_10C))
	{
		self getenemyinfo(param_00.var_114);
		lib_0F26::func_117D4("spotted");
	}

	scripts\sp\_utility::func_65E1("stealth_attack");
	lib_0F27::func_10EE4(1);
	lib_0F27::func_F4C8("combat",1,param_00.var_9B22);
}

//Function Number: 28
func_1272D(param_00)
{
	self endon("death");
	var_01 = undefined;
	if(isdefined(param_00))
	{
		var_01 = param_00.origin;
	}

	if(!isdefined(self.var_10E6D))
	{
		return;
	}

	if(scripts\sp\_utility::func_65DB("stealth_cover_blown"))
	{
		return;
	}

	scripts\sp\_utility::func_65E1("stealth_cover_blown");
	lib_0F27::func_868C("stealth_cover_blown");
	var_02 = lib_0F27::func_7B72();
	if(!isdefined(var_02) || var_02 == "unaware")
	{
		if(!isdefined(self.var_10E6D.var_C9A8) || self.var_10E6D.var_C9A8 == "unaware")
		{
			lib_0F27::func_F4C8("alert",isdefined(self.var_10E6D.var_2A7D) && self.var_10E6D.var_2A7D != "investigate",var_01);
		}

		self.var_10E6D.var_500C = "alert";
	}
}

//Function Number: 29
func_DD2C(param_00)
{
	self endon("death");
	var_01 = 0.1;
	switch(param_00.type)
	{
		case "investigate":
			thread lib_0F27::func_1284A("warning1",var_01);
			return 1;

		case "cover_blown":
			thread lib_0F27::func_1284A("warning2",var_01);
			return 1;

		case "combat":
			thread lib_0F27::func_1284A("spotted",var_01);
			return 1;
	}

	return 0;
}

//Function Number: 30
func_DD2D(param_00)
{
	self endon("death");
	if(isdefined(param_00.var_12AE9))
	{
		var_01 = randomfloatrange(0.5,1);
		switch(param_00.var_12AE9)
		{
			case "explode":
				thread lib_0F27::func_1284A("explosion",var_01);
				return 1;

			case "seek_backup":
				thread lib_0F27::func_1284A("acknowledgement",var_01);
				return 1;

			case "found_corpse":
			case "saw_corpse":
				thread lib_0F27::func_1284A(param_00.var_12AE9,var_01);
				thread lib_0F27::func_1698(["saw_corpse","found_corpse"],var_01 + 0.05);
				return 1;
		}
	}

	return 0;
}

//Function Number: 31
func_8417(param_00,param_01,param_02)
{
	self endon("death");
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = !param_02;
	while(lib_0F27::func_10E82() || !var_03)
	{
		lib_0F27::func_10E87();
		self [[ param_00 ]](param_01);
		var_03 = 1;
		self waittill("goal");
	}
}

//Function Number: 32
func_8415(param_00,param_01)
{
	self endon("death");
	func_8417(param_00,param_01);
	if(isdefined(self.var_10E6D.var_92CC))
	{
		lib_0F27::func_413E();
		if(isdefined(self.var_10E6D.var_4C4F))
		{
			lib_0F27::func_CCD4(param_01,"gravity");
		}
	}
}

//Function Number: 33
func_840C(param_00,param_01)
{
	func_8417(param_00,param_01,0);
	if(isdefined(param_01.var_EE2C))
	{
		self.var_BCD6 = param_01.var_EE2C;
	}

	if(isdefined(param_01.var_ECF5))
	{
		if(scripts\common\utility::istrue(param_01.var_ED88) && isdefined(param_01.angles))
		{
			self method_8221("face angle",param_01.angles[1]);
		}

		var_02 = param_01.var_ECF5;
		lib_0B06::func_1EC8(self,"gravity",var_02);
	}
	else if(isdefined(param_01.var_EDDE))
	{
		self [[ level.var_92DE[param_01.var_EDDE] ]](param_01);
	}

	if(isdefined(param_01.var_ECF6))
	{
		lib_0B06::func_1EC8(self,"gravity",param_01.var_ECF6);
	}
}