/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_scripted_agent_anim_util.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 519 ms
 * Timestamp: 10/27/2023 3:09:04 AM
*******************************************************************/

//Function Number: 1
func_5159(param_00)
{
	var_01 = "actiontables/" + param_00 + ".csv";
	var_02 = [];
	var_03 = function_027A(var_01);
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		var_02[var_02.size] = func_5DE0(param_00,var_01,var_04);
	}

	if(!isdefined(level.var_87B))
	{
		level.var_87B = [];
	}

	foreach(var_06 in var_02)
	{
		foreach(var_08 in var_06["actions"])
		{
			if(!isdefined(level.var_87B[param_00]))
			{
				level.var_87B[param_00] = [];
			}

			if(!isdefined(level.var_87B[param_00][var_08]))
			{
				level.var_87B[param_00][var_08] = [];
			}

			level.var_87B[param_00][var_08][level.var_87B[param_00][var_08].size] = var_06;
		}
	}

	var_0B = [];
	foreach(var_06 in var_02)
	{
		foreach(var_0E in ["move_style","anims","actions"])
		{
			var_0F = var_06[var_0E];
			if(!isarray(var_0F))
			{
				var_0F = [var_0F];
			}

			foreach(var_11 in var_0F)
			{
				if(var_11 != "")
				{
					if(!isdefined(var_0B[var_0E]))
					{
						var_0B[var_0E] = [];
					}

					if(isdefined(var_0B[var_0E][var_11]))
					{
						var_0B[var_0E][var_11]++;
						continue;
					}

					var_0B[var_0E][var_11] = 1;
				}
			}
		}
	}

	level.var_87E[param_00] = var_0B;
}

//Function Number: 2
func_5DE0(param_00,param_01,param_02)
{
	var_03 = [];
	var_03["table"] = param_00;
	var_03["actions"] = strtok(tablelookupbyrow(param_01,param_02,0)," ");
	var_03["state"] = tablelookupbyrow(param_01,param_02,1);
	var_03["flags"] = strtok(tablelookupbyrow(param_01,param_02,2)," ");
	var_03["anims"] = strtok(tablelookupbyrow(param_01,param_02,3)," ");
	var_03["dismember_states"] = strtok(tablelookupbyrow(param_01,param_02,4)," ");
	var_03["zombie_subtypes"] = strtok(tablelookupbyrow(param_01,param_02,5)," ");
	var_03["source_project"] = tablelookupbyrow(param_01,param_02,6);
	var_03["script_var"] = tablelookupbyrow(param_01,param_02,7);
	var_03["move_style"] = tablelookupbyrow(param_01,param_02,8);
	var_03["move_speed"] = tablelookupbyrow(param_01,param_02,9);
	return var_03;
}

//Function Number: 3
func_82D0(param_00,param_01)
{
	var_02 = param_00["script_var"];
	if(lib_0547::func_5816(var_02))
	{
		return 1;
	}

	var_03 = param_01["script_var"];
	if(lib_0547::func_5816(var_03))
	{
		return 1;
	}

	return var_02 == var_03;
}

//Function Number: 4
func_087A(param_00,param_01)
{
	var_02 = level.var_87B[param_01];
	if(!isdefined(var_02))
	{
		return undefined;
	}

	return var_02[param_00];
}

//Function Number: 5
func_087C(param_00,param_01,param_02)
{
	var_03 = func_087A(param_00,param_01["action_table"]);
	if(!isdefined(var_03))
	{
		return undefined;
	}

	foreach(var_05 in var_03)
	{
		if(isdefined(param_01["dismember_state"]) && !common_scripts\utility::func_F79(var_05["dismember_states"],param_01["dismember_state"]))
		{
			continue;
		}

		if(isdefined(param_01["zombie_subtype"]) && !common_scripts\utility::func_F79(var_05["zombie_subtypes"],param_01["zombie_subtype"]))
		{
			continue;
		}

		if(isdefined(param_01["source_project"]) && var_05["source_project"] != param_01["source_project"])
		{
			continue;
		}

		if(!func_82D0(var_05,param_01))
		{
			continue;
		}

		if(isdefined(param_01["move_speed"]) && !lib_0547::func_5816(var_05["move_speed"]) && var_05["move_speed"] != param_01["move_speed"])
		{
			continue;
		}

		if(isdefined(param_01["move_style"]) && var_05["move_style"] != param_01["move_style"])
		{
			continue;
		}

		return var_05["state"];
	}

	if(isdefined(param_01["move_style"]))
	{
		var_07 = param_01;
		var_07["move_style"] = undefined;
		var_05 = func_087C(param_00,var_07,param_02);
		if(isdefined(var_05))
		{
			return var_05;
		}
	}

	var_08 = func_6E76(param_01["zombie_subtype"]);
	if(isdefined(var_08))
	{
		var_07 = param_01;
		var_07["zombie_subtype"] = var_08;
		var_05 = func_087C(param_00,var_07,param_02);
		if(isdefined(var_05))
		{
			return var_05;
		}
	}

	if(isdefined(param_01["source_project"]))
	{
		var_09 = common_scripts\utility::func_F7E(level.var_87D,param_01["source_project"]);
		var_0A = level.var_87D[var_09 + 1];
		var_07 = param_01;
		var_07["source_project"] = var_0A;
		var_05 = func_087C(param_00,var_07,param_02);
		if(isdefined(var_05))
		{
			return var_05;
		}
	}

	if(isdefined(param_01["move_speed"]))
	{
		var_07 = param_01;
		var_07["move_speed"] = undefined;
		var_05 = func_087C(param_00,var_07,param_02);
		if(isdefined(var_05))
		{
			return var_05;
		}
	}

	return undefined;
}

//Function Number: 6
func_6E76(param_00)
{
	var_01 = lib_0547::func_A51(param_00);
	var_02 = var_01.parenttype;
	return var_02;
}

//Function Number: 7
func_4081(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = func_087A(param_00,param_01);
	if(isdefined(var_04))
	{
		foreach(var_06 in var_04)
		{
			foreach(var_08 in var_06["anims"])
			{
				var_09 = getanimationfromname(param_02,var_08);
				if(!common_scripts\utility::func_F79(var_03,var_09))
				{
					var_03[var_03.size] = var_09;
				}
			}
		}
	}

	return var_03;
}

//Function Number: 8
func_71FA(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("disconnect");
	self endon("death");
	if(isdefined(param_00) && !common_scripts\utility::func_562E(self.frozen))
	{
		if(!isdefined(param_01))
		{
			param_01 = 0;
		}

		var_07 = self method_83D8(param_00,param_01);
		var_08 = getanimlength(var_07);
		var_09 = var_08;
		if(isdefined(param_06))
		{
			var_09 = var_08 - param_06;
			if(var_09 < 0)
			{
				var_09 = 0;
			}
		}

		var_09 = var_09 * 1 / param_02;
		childthread func_678A(param_03,var_09,param_04);
	}

	func_71F9(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	self notify("Notetrack_Timeout");
}

//Function Number: 9
func_71FD(param_00,param_01,param_02,param_03,param_04,param_05)
{
	func_71FA(param_00,param_01,1,param_02,param_03,param_04,param_05);
}

//Function Number: 10
func_71F9(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	func_8415(param_00,param_01,param_02,param_06);
	if(!isdefined(param_04))
	{
		param_04 = "end";
	}

	func_A79E(param_03,param_04,param_00,param_01,param_05);
}

//Function Number: 11
func_A79F(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("death");
	if(isdefined(param_02))
	{
		childthread func_678A(param_00,param_02,param_01);
	}

	func_A79E(param_00,param_01);
	self notify("Notetrack_Timeout");
}

//Function Number: 12
func_A79E(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = gettime();
	var_06 = undefined;
	var_07 = undefined;
	if(isdefined(param_02) && isdefined(param_03))
	{
		var_07 = getanimlength(self method_83D8(param_02,param_03));
	}

	for(;;)
	{
		self waittill(param_00,var_08);
		if(isdefined(var_07))
		{
			var_06 = gettime() - var_05 * 0.001 / var_07;
		}

		if(!isdefined(var_07) || var_06 > 0)
		{
			if(var_08 == param_01 || var_08 == "end" || var_08 == "anim_will_finish" || var_08 == "finish")
			{
				break;
			}
		}

		if(isdefined(param_04))
		{
			[[ param_04 ]](var_08,param_02,param_03,var_06);
		}
	}
}

//Function Number: 13
func_678A(param_00,param_01,param_02)
{
	self notify("Notetrack_Timeout");
	self endon("Notetrack_Timeout");
	param_01 = max(0.05,param_01);
	wait(param_01);
	if(isdefined(param_02))
	{
		self notify(param_00,param_02);
		return;
	}

	self notify(param_00,"end");
}

//Function Number: 14
func_71F8(param_00,param_01,param_02,param_03)
{
	func_8415(param_00,param_01,param_02);
	wait(param_03);
}

//Function Number: 15
func_5ED7(param_00,param_01,param_02)
{
	for(;;)
	{
		var_03 = func_7A35(param_00);
		func_8415(param_00,var_03,param_01);
		var_04 = getanimlength(self method_83D8(param_00,var_03)) * 1 / param_01;
		func_A79F(param_02,"end",var_04);
	}
}

//Function Number: 16
func_434D(param_00,param_01,param_02)
{
	var_03 = self [[ maps/mp/agents/_agent_utility::func_A59("get_action_params") ]]();
	if(isdefined(param_01))
	{
		foreach(var_06, var_05 in param_01)
		{
			var_03[var_06] = var_05;
		}
	}

	var_07 = 0;
	var_08 = func_087C(param_00,var_03,var_07);
	return var_08;
}

//Function Number: 17
func_8410(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_03 = func_434D(param_00);
	func_8415(var_03,undefined,param_01,param_02);
}

//Function Number: 18
func_4156()
{
	var_00 = self method_85A5();
	if(isendstr(var_00,"_animclass"))
	{
		var_00 = getsubstr(var_00,0,var_00.size - 10);
	}

	return var_00;
}

//Function Number: 19
func_8415(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		self method_83D7(param_00,param_01,param_02,param_03);
	}
	else if(isdefined(param_02))
	{
		self method_83D7(param_00,param_01,param_02);
	}
	else if(isdefined(param_01))
	{
		self method_83D7(param_00,param_01);
	}
	else
	{
		self method_83D7(param_00);
	}

	var_04 = self method_83D9();
	self.var_28ED = func_43C9(var_04);
	lib_0378::func_8D74("zombie_set_anim_state",param_00,var_04);
	if(isdefined(self.var_1142))
	{
		self thread [[ self.var_1142 ]](param_00,param_01,param_02,param_03);
	}
}

//Function Number: 20
func_4416(param_00,param_01)
{
	if(param_01 <= 1)
	{
		return 0;
	}

	var_03 = 360 / param_01 - 1;
	var_04 = var_03 * 0.2222222;
	if(param_00 < 0)
	{
		return int(ceil(180 + param_00 - var_04 / var_03));
	}

	return int(floor(180 + param_00 + var_04 / var_03));
}

//Function Number: 21
func_441C(param_00,param_01,param_02)
{
	var_03 = length2d(param_00);
	var_04 = param_00[2];
	var_05 = length2d(param_01);
	var_06 = param_01[2];
	var_07 = 1;
	var_08 = 1;
	if(isdefined(param_02) && param_02)
	{
		var_09 = (param_01[0],param_01[1],0);
		var_0A = vectornormalize(var_09);
		if(vectordot(var_0A,param_00) < 0)
		{
			var_07 = 0;
		}
		else if(var_05 > 0)
		{
			var_07 = var_03 / var_05;
		}
	}
	else if(var_05 > 0)
	{
		var_07 = var_03 / var_05;
	}

	if(abs(var_06) > 0.001 && var_04 != 0 && var_06 * var_04 > 0)
	{
		var_08 = var_04 / var_06;
	}

	var_0B = spawnstruct();
	var_0B.var_AAE3 = var_07;
	var_0B.var_1D9 = var_08;
	return var_0B;
}

//Function Number: 22
func_6AFF(param_00,param_01)
{
	self notify("killanimscript");
	if(isdefined(self.var_EAD.var_6B2F[param_00]))
	{
		self [[ self.var_EAD.var_6B2F[param_00] ]]();
	}

	func_38ED(param_00);
	if(!isdefined(self.var_EAD.var_6AFE[param_01]))
	{
		return;
	}

	if(param_00 == param_01 && param_01 != "traverse")
	{
		return;
	}

	self.var_BA4 = param_01;
	func_37B8(param_01);
	self [[ self.var_EAD.var_6AFE[param_01] ]]();
}

//Function Number: 23
func_37B8(param_00)
{
	self.var_BA4 = param_00;
	switch(param_00)
	{
		case "idle":
			self.var_173C = 0;
			break;

		default:
			break;
	}
}

//Function Number: 24
func_38ED(param_00)
{
	switch(param_00)
	{
		default:
			break;
	}
}

//Function Number: 25
func_57E2()
{
	return self.var_18F;
}

//Function Number: 26
func_8732(param_00,param_01)
{
	self.var_18F = param_00;
}

//Function Number: 27
func_43C9(param_00)
{
	var_01 = strtok(param_00,"_");
	if(var_01.size > 1)
	{
		var_02 = var_01[var_01.size - 1];
		if(var_02.size > 0 && var_02[0] == "v")
		{
			var_03 = getsubstr(var_02,1);
			var_04 = int(var_03);
			if(common_scripts\utility::func_9AAD(var_04) == var_03)
			{
				return var_04;
			}
		}
	}

	return undefined;
}

//Function Number: 28
func_7A35(param_00)
{
	var_01 = self method_83DB(param_00);
	if(isdefined(self.var_28ED))
	{
		for(var_03 = 0;var_03 < var_01;var_03++)
		{
			var_04 = self method_83D9(param_00,var_03);
			var_05 = func_43C9(var_04);
			if(isdefined(var_05) && var_05 == self.var_28ED)
			{
				return var_03;
			}
		}
	}

	return randomint(var_01);
}

//Function Number: 29
getnotetracktimeinsecs(param_00,param_01,param_02)
{
	var_03 = func_45B9(param_00,param_01,param_02);
	return var_03 * getanimlength(param_00);
}

//Function Number: 30
func_45B9(param_00,param_01,param_02)
{
	var_03 = getnotetracktimes(param_00,param_01);
	if(isdefined(param_02) && var_03.size == 0)
	{
		return param_02;
	}

	return var_03[0];
}

//Function Number: 31
func_446A(param_00)
{
	if(animhasnotetrack(param_00,"code_move"))
	{
		return func_45B9(param_00,"code_move");
	}

	return 1;
}