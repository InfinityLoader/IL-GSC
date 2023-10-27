/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_mp_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 47
 * Decompile Time: 1728 ms
 * Timestamp: 10/27/2023 12:21:06 AM
*******************************************************************/

//Function Number: 1
init_agent(param_00)
{
	level.agent_definition = [];
	level.var_18EB = [];
	level.agent_recycle_interval = 500;
	var_01 = [];
	var_01["species"] = 3;
	var_01["traversal_unit_type"] = 4;
	var_01["body_model"] = 5;
	var_01["animclass"] = 6;
	var_01["health"] = 7;
	var_01["xp"] = 8;
	var_01["reward"] = 9;
	var_01["behaviorTree"] = 10;
	var_01["asm"] = 11;
	var_01["radius"] = 12;
	var_01["height"] = 13;
	var_02 = 0;
	var_03 = 50;
	for(var_04 = var_02;var_04 <= var_03;var_04++)
	{
		var_05 = tablelookupbyrow(param_00,var_04,2);
		if(var_05 == "")
		{
			break;
		}

		var_06 = [];
		foreach(var_0B, var_08 in var_01)
		{
			var_09 = tablelookupbyrow(param_00,var_04,var_08);
			if(var_09 == "0")
			{
				var_09 = 0;
			}
			else if(int(var_09) != 0)
			{
				var_0A = var_09 + "";
				if(issubstr(var_0A,"."))
				{
					var_09 = float(var_09);
				}
				else
				{
					var_09 = int(var_09);
				}
			}

			var_06[var_0B] = var_09;
		}

		level.agent_definition[var_05] = var_06;
	}

	level notify("scripted_agents_initialized");
}

//Function Number: 2
func_F8ED()
{
	var_00 = level.agent_definition[self.agent_type];
	if(!isdefined(var_00["behaviorTree"]) || var_00["behaviorTree"] == "")
	{
		return;
	}

	scripts\mp\agents\_scriptedagents::func_197F(var_00["behaviorTree"],var_00["asm"]);
}

//Function Number: 3
func_FAFA(param_00)
{
	self.var_394 = param_00;
	self giveweapon(param_00);
	self method_833B(param_00);
	self.var_3250 = weaponclipsize(param_00);
	self.var_D8E1 = param_00;
}

//Function Number: 4
func_FAED(param_00)
{
	self.spawner = param_00;
}

//Function Number: 5
func_108E8(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = func_7EC5(param_00);
	if(isdefined(var_06))
	{
		if(!isdefined(param_03))
		{
			param_03 = (0,0,0);
		}

		var_06.var_4539 = gettime();
		if(isdefined(param_05))
		{
			var_06 func_FAED(param_05);
		}

		var_06 func_F28D(var_06,param_00);
		var_06 func_F28F(var_06,param_00);
		if(func_9CB3(param_00))
		{
			var_06 = func_107CF(var_06,param_00,param_02,param_03);
		}
		else
		{
			var_06 = func_107B2(var_06,param_02,param_03);
		}

		var_06 func_F8A9(param_00);
		var_06 func_F290(param_01);
		var_06 func_F28E(var_06,param_00);
		var_06 func_F291(var_06,param_00);
		var_06 func_184B();
		if(isdefined(param_04))
		{
			var_06 func_FAFA(param_04);
		}

		if(func_9CF8(param_00))
		{
			var_06 func_F8ED();
		}

		var_06 func_1601();
	}

	return var_06;
}

//Function Number: 6
func_F291(param_00,param_01)
{
	if(!func_384C(param_00))
	{
		return;
	}

	param_00 method_828C(level.agent_definition[param_01]["traversal_unit_type"]);
}

//Function Number: 7
func_384C(param_00)
{
	if(func_9B53(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
func_F28D(param_00,param_01)
{
	var_02 = level.agent_definition[param_01]["setup_model_func"];
	if(isdefined(var_02))
	{
		param_00 [[ var_02 ]](param_01);
		return;
	}

	param_00 detachall();
	param_00 setmodel(level.agent_definition[param_01]["body_model"]);
	param_00 show();
}

//Function Number: 9
func_9CB3(param_00)
{
	return level.agent_definition[param_00]["animclass"] != "";
}

//Function Number: 10
func_9CF8(param_00)
{
	if(!isdefined(level.agent_definition[param_00]))
	{
		return 0;
	}

	return level.agent_definition[param_00]["behaviorTree"] != "";
}

//Function Number: 11
func_107CF(param_00,param_01,param_02,param_03)
{
	param_00.var_C50F = param_00 func_10972("on_enter_animstate");
	param_00.var_9CB3 = 1;
	var_04 = level.agent_definition[param_01]["radius"];
	if(!isdefined(var_04))
	{
		var_04 = 15;
	}

	var_05 = level.agent_definition[param_01]["height"];
	if(!isdefined(var_05))
	{
		var_05 = 50;
	}

	param_00 method_838E(param_02,param_03,level.agent_definition[param_01]["animclass"],var_04,var_05);
	param_00.var_18F4 = var_05;
	param_00.var_18F9 = var_04;
	return param_00;
}

//Function Number: 12
func_107B2(param_00,param_01,param_02)
{
	param_00.var_9CB3 = 0;
	param_00 method_838E(param_01,param_02);
	return param_00;
}

//Function Number: 13
func_9B53(param_00)
{
	return param_00.var_9CB3;
}

//Function Number: 14
func_18F3(param_00,param_01,param_02,param_03,param_04)
{
	if(func_9B53(self))
	{
		self method_8286(param_00);
		return;
	}

	self botsetscriptgoal(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 15
func_F8A9(param_00)
{
	var_01 = level.agent_definition[param_00];
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = var_01["setup_func"];
	if(!isdefined(var_02))
	{
		return;
	}

	self [[ var_02 ]]();
}

//Function Number: 16
func_F28F(param_00,param_01)
{
	if(!isdefined(level.agent_funcs[param_01]))
	{
		level.agent_funcs[param_01] = [];
	}

	param_00.var_1096F = level.agent_definition[param_01]["species"];
	if(!isdefined(level.var_10970[param_00.var_1096F]) || !isdefined(level.var_10970[param_00.var_1096F]["on_enter_animstate"]))
	{
		level.var_10970[param_00.var_1096F] = [];
		level.var_10970[param_00.var_1096F]["on_enter_animstate"] = ::func_5005;
	}

	func_23B2("spawn",::func_5016);
	func_23B2("on_damaged",::func_5003);
	func_23B2("on_damaged_finished",::func_5004);
	func_23B2("on_killed",::func_5006);
}

//Function Number: 17
func_23B2(param_00,param_01)
{
	var_02 = self.agent_type;
	if(!isdefined(level.agent_funcs[var_02][param_00]))
	{
		if(!isdefined(level.var_10970[self.var_1096F]) || !isdefined(level.var_10970[self.var_1096F][param_00]))
		{
			level.agent_funcs[var_02][param_00] = param_01;
			return;
		}

		level.agent_funcs[var_02][param_00] = level.var_10970[self.var_1096F][param_00];
	}
}

//Function Number: 18
func_F28E(param_00,param_01)
{
	param_00 func_F28C(level.agent_definition[param_01]["health"]);
}

//Function Number: 19
func_77D7(param_00)
{
	return param_00.agent_type;
}

//Function Number: 20
func_7EC6()
{
	if(!isdefined(level.var_1900))
	{
		return 0;
	}

	var_00 = gettime();
	var_01 = 0;
	foreach(var_03 in level.var_1900)
	{
		if(!isdefined(var_03.var_9D25) || !var_03.var_9D25)
		{
			if(isdefined(var_03.var_136FD) && var_03.var_136FD)
			{
				continue;
			}

			var_04 = var_03 getentitynumber();
			if(isdefined(level.var_18EB) && isdefined(level.var_18EB[var_04]) && var_00 < level.var_18EB[var_04])
			{
				continue;
			}

			var_01++;
		}
	}

	return var_01;
}

//Function Number: 21
func_7EC5(param_00)
{
	var_01 = undefined;
	var_02 = gettime();
	if(isdefined(level.var_1900))
	{
		foreach(var_04 in level.var_1900)
		{
			if(!isdefined(var_04.var_9D25) || !var_04.var_9D25)
			{
				if(isdefined(var_04.var_136FD) && var_04.var_136FD)
				{
					continue;
				}

				var_05 = var_04 getentitynumber();
				if(isdefined(level.var_18EB) && isdefined(level.var_18EB[var_05]) && var_02 < level.var_18EB[var_05])
				{
					continue;
				}

				level.var_18EB[var_05] = undefined;
				var_01 = var_04;
				var_01.agent_type = param_00;
				var_01 func_97C2();
				var_01 notify("agent_in_use");
				break;
			}
		}
	}

	return var_01;
}

//Function Number: 22
func_97C2()
{
	self.pers = [];
	self.var_8BE2 = 0;
	self.var_9D25 = 0;
	self.var_10916 = 0;
	self.var_6640 = self getentitynumber();
	self.var_18F2 = 0;
	self detachall();
	func_98BB();
}

//Function Number: 23
func_98BB()
{
	self.var_4004 = undefined;
	self.var_BCF6 = undefined;
	self.var_26B9 = undefined;
	self.var_86BD = undefined;
	self.name = undefined;
	self.var_EB6A = undefined;
	self.var_CA5B = undefined;
	self.var_13CA0 = undefined;
	self.var_C2AD = undefined;
	self.sessionteam = undefined;
	self.sessionstate = undefined;
	self.var_55E6 = undefined;
	self.disabledweaponswitch = undefined;
	self.var_55D9 = undefined;
	self.var_55E4 = 1;
	self.nocorpse = undefined;
	self.ignoreme = 0;
	self.var_180 = 0;
	self.var_116D4 = undefined;
	self.var_441A = undefined;
	self.var_4B82 = undefined;
	self.do_immediate_ragdoll = undefined;
	if(isdefined(level.var_768B))
	{
		self [[ level.var_768B ]]();
	}
}

//Function Number: 24
func_F290(param_00,param_01)
{
	self.team = param_00;
	self.var_20 = param_00;
	self.pers["team"] = param_00;
	self.var_222 = param_01;
	self method_831F(param_01);
	self method_82DD(param_01);
}

//Function Number: 25
func_184B()
{
	for(var_00 = 0;var_00 < level.var_3CB5.size;var_00++)
	{
		if(level.var_3CB5[var_00] == self)
		{
			return;
		}
	}

	level.var_3CB5[level.var_3CB5.size] = self;
}

//Function Number: 26
func_1908(param_00)
{
	return level.agent_funcs[self.agent_type][param_00];
}

//Function Number: 27
func_10972(param_00)
{
	return level.var_10970[self.var_1096F][param_00];
}

//Function Number: 28
func_1313C(param_00)
{
	if(isagent(param_00) && !isdefined(param_00.var_9D25) || !param_00.var_9D25)
	{
		return undefined;
	}

	if(isagent(param_00) && !isdefined(param_00.classname))
	{
		return undefined;
	}

	return param_00;
}

//Function Number: 29
func_F28C(param_00)
{
	self.var_1E = param_00;
	self.health = param_00;
	self.maxhealth = param_00;
}

//Function Number: 30
func_5016(param_00,param_01,param_02)
{
}

//Function Number: 31
func_9BEA(param_00,param_01)
{
	if(isdefined(param_01))
	{
		if(isdefined(param_01.team) && param_01.team == param_00.team)
		{
			return 1;
		}

		if(isdefined(param_01.var_222) && isdefined(param_01.var_222.team) && param_01.var_222.team == param_00.team)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 32
func_5003(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = self;
	var_0D = level.agent_funcs[self.agent_type]["gametype_on_damaged"];
	if(isdefined(var_0D))
	{
		[[ var_0D ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
	}

	if(func_9BEA(var_0C,param_00))
	{
		return;
	}

	var_0C [[ level.agent_funcs[var_0C.agent_type]["on_damaged_finished"] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,0,param_0A,param_0B);
}

//Function Number: 33
func_5004(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	var_0D = self.health;
	if(isdefined(param_07))
	{
		var_0E = vectortoyaw(param_07);
		var_0F = self.angles[1];
		self.var_E3 = angleclamp180(var_0E - var_0F);
	}
	else
	{
		self.var_E3 = 0;
	}

	self.var_DD = param_08;
	self.var_DE = param_04;
	self.var_4D3F = param_01;
	self.var_DC = param_07;
	self.var_E1 = param_02;
	self.var_E2 = param_05;
	self.var_4D62 = param_06;
	self method_80E9(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,0,param_0B,param_0C);
	if(self.health > 0 && self.health < var_0D)
	{
		self notify("pain");
	}

	if(isalive(self) && isdefined(self.agent_type))
	{
		var_10 = level.agent_funcs[self.agent_type]["gametype_on_damage_finished"];
		if(isdefined(var_10))
		{
			[[ var_10 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
		}
	}
}

//Function Number: 34
func_5006(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isdefined(level.var_C4BD))
	{
		self [[ level.var_C4BD ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,0);
	}
	else
	{
		func_C4B3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,0);
	}

	var_09 = level.agent_funcs[self.agent_type]["gametype_on_killed"];
	if(isdefined(var_09))
	{
		[[ var_09 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	func_4DDB();
}

//Function Number: 35
func_5005(param_00,param_01)
{
	self.var_1B03 = param_01;
	switch(param_01)
	{
		case "traverse":
			self.do_immediate_ragdoll = 1;
			lib_0F3C::func_5AC0();
			self.do_immediate_ragdoll = 0;
			break;

		default:
			break;
	}

	func_41A5();
}

//Function Number: 36
func_41A5()
{
	self.var_DDC0 = [];
	self.var_4D57 = 0;
}

//Function Number: 37
func_4DDB()
{
	var_00 = self getentitynumber();
	level.var_18EB[var_00] = gettime() + 500;
}

//Function Number: 38
func_8008(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	var_01 = func_7D95(param_00);
	return var_01.size;
}

//Function Number: 39
func_7D95(param_00)
{
	var_01 = [];
	if(!isdefined(level.var_1900))
	{
		return var_01;
	}

	foreach(var_03 in level.var_1900)
	{
		if(isdefined(var_03.var_9D25) && var_03.var_9D25)
		{
			if(param_00 == "all" || var_03.agent_type == param_00)
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 40
func_7DB0(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_1900)
	{
		if(isalive(var_03) && isdefined(var_03.team) && var_03.team == param_00)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 41
func_7D94(param_00)
{
	var_01 = [];
	if(!isdefined(level.var_1900))
	{
		return var_01;
	}

	foreach(var_03 in level.var_1900)
	{
		if(isdefined(var_03.var_9D25) && var_03.var_9D25)
		{
			if(var_03.var_1096F == param_00)
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 42
func_7DAF()
{
	var_00 = [];
	foreach(var_02 in level.var_1900)
	{
		if(isalive(var_02))
		{
			var_00[var_00.size] = var_02;
		}
	}

	return var_00;
}

//Function Number: 43
func_1601()
{
	self.var_9D25 = 1;
	self.var_107F7 = gettime();
}

//Function Number: 44
func_C4B3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = self.var_164D[self.var_238F].var_4BC0;
	var_0B = level.var_2303[self.var_238F].var_10E2F[var_0A];
	if(lib_0A1D::func_2382(self.var_238F,var_0B))
	{
		lib_0A1A::func_231E(self.var_238F,var_0B,var_0A);
	}

	if(isdefined(self.nocorpse))
	{
		return;
	}

	var_0C = self;
	self.var_2C09 = self method_8084(param_08);
	if(func_FF32(self))
	{
		do_immediate_ragdoll(self.var_2C09);
		return;
	}

	thread func_5124(self.var_2C09,param_06,param_05,param_04,param_00,param_03);
}

//Function Number: 45
func_FF32(param_00)
{
	if(isdefined(param_00.do_immediate_ragdoll) && param_00.do_immediate_ragdoll)
	{
		return 1;
	}

	return 0;
}

//Function Number: 46
do_immediate_ragdoll(param_00)
{
	if(isdefined(param_00))
	{
		param_00 method_839A();
	}
}

//Function Number: 47
func_5124(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_00))
	{
		var_06 = param_00 method_8112();
		if(animhasnotetrack(var_06,"ignore_ragdoll"))
		{
			return;
		}
	}

	if(isdefined(level.var_C08A) && level.var_C08A.size)
	{
		foreach(var_08 in level.var_C08A)
		{
			if(distancesquared(param_00.origin,var_08.origin) < 65536)
			{
				return;
			}
		}
	}

	wait(0.2);
	if(!isdefined(param_00))
	{
		return;
	}

	if(param_00 method_81B7())
	{
		return;
	}

	var_06 = param_00 method_8112();
	var_0A = 0.35;
	if(animhasnotetrack(var_06,"start_ragdoll"))
	{
		var_0B = getnotetracktimes(var_06,"start_ragdoll");
		if(isdefined(var_0B))
		{
			var_0A = var_0B[0];
		}
	}

	var_0C = var_0A * getanimlength(var_06) - 0.2;
	if(var_0C > 0)
	{
		wait(var_0C);
	}

	if(isdefined(param_00))
	{
		if(isdefined(param_00.ragdollhitloc) && isdefined(param_00.ragdollimpactvector))
		{
			param_00 method_839B(param_00.ragdollhitloc,param_00.ragdollimpactvector);
			return;
		}

		param_00 method_839A();
	}
}