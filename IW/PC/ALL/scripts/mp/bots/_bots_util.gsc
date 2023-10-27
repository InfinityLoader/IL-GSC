/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\_bots_util.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 77
 * Decompile Time: 3521 ms
 * Timestamp: 10/27/2023 12:27:50 AM
*******************************************************************/

//Function Number: 1
func_2DB1(param_00,param_01,param_02)
{
	var_03 = self method_8533();
	var_04 = getnodesinradius(self.origin,param_00,0,512,"path",var_03);
	var_05 = [];
	var_06 = self getnearestnode();
	var_07 = anglestoforward(self getplayerangles());
	var_08 = vectornormalize(var_07 * (1,1,0));
	foreach(var_0A in var_04)
	{
		var_0B = vectornormalize(var_0A.origin - self.origin * (1,1,0));
		var_0C = vectordot(var_0B,var_08);
		if(var_0C > param_01)
		{
			if(!param_02 || isdefined(var_06) && nodesvisible(var_0A,var_06,1))
			{
				var_05 = scripts\common\utility::array_add(var_05,var_0A);
			}
		}
	}

	return var_05;
}

//Function Number: 2
func_2DBB(param_00,param_01)
{
	if(param_00 == "none")
	{
		return param_01 == "none";
	}
	else if(param_00 == "hunt")
	{
		return param_01 == "hunt" || param_01 == "none";
	}
	else if(param_00 == "guard")
	{
		return param_01 == "guard" || param_01 == "hunt" || param_01 == "none";
	}
	else if(param_00 == "objective")
	{
		return param_01 == "objective" || param_01 == "guard" || param_01 == "hunt" || param_01 == "none";
	}
	else if(param_00 == "critical")
	{
		return param_01 == "critical" || param_01 == "objective" || param_01 == "guard" || param_01 == "hunt" || param_01 == "none";
	}
	else if(param_00 == "tactical")
	{
		return 1;
	}
}

//Function Number: 3
func_2E83(param_00)
{
	self botsetpersonality(param_00);
	scripts\mp\bots\_bots_personality::func_2D0C();
	self botclearscriptgoal();
}

//Function Number: 4
func_2E81(param_00)
{
	if(param_00 == "default")
	{
		param_00 = func_2D30();
	}

	self botsetdifficulty(param_00);
	if(isplayer(self))
	{
		self.pers["rankxp"] = scripts\mp\_utility::func_7BF8();
		scripts\mp\_rank::func_D458();
	}
}

//Function Number: 5
func_2D30()
{
	if(!isdefined(level.var_2D5B))
	{
		level.var_2D5B = [];
		if(level.rankedmatch)
		{
			level.var_2D5B[level.var_2D5B.size] = "regular";
			level.var_2D5B[level.var_2D5B.size] = "hardened";
		}
		else
		{
			level.var_2D5B[level.var_2D5B.size] = "recruit";
			level.var_2D5B[level.var_2D5B.size] = "regular";
			level.var_2D5B[level.var_2D5B.size] = "hardened";
		}
	}

	var_00 = self.var_2D32;
	if(!isdefined(var_00))
	{
		var_01 = [];
		var_02 = self.team;
		if(!isdefined(var_02))
		{
			var_02 = self.var_2EAC;
		}

		if(!isdefined(var_02))
		{
			var_02 = self.pers["team"];
		}

		if(!isdefined(var_02))
		{
			var_02 = "allies";
		}

		foreach(var_04 in level.players)
		{
			if(var_04 == self)
			{
				continue;
			}

			if(!isai(var_04))
			{
				continue;
			}

			var_05 = var_04 botgetdifficulty();
			if(var_05 == "default")
			{
				continue;
			}

			var_06 = var_04.team;
			if(!isdefined(var_06))
			{
				var_06 = var_04.var_2EAC;
			}

			if(!isdefined(var_06))
			{
				var_06 = var_04.pers["team"];
			}

			if(!isdefined(var_06))
			{
				continue;
			}

			if(!isdefined(var_01[var_06]))
			{
				var_01[var_06] = [];
			}

			if(!isdefined(var_01[var_06][var_05]))
			{
				var_01[var_06][var_05] = 1;
				continue;
			}

			var_01[var_06][var_05]++;
		}

		var_08 = -1;
		foreach(var_0A in level.var_2D5B)
		{
			if(!isdefined(var_01[var_02]) || !isdefined(var_01[var_02][var_0A]))
			{
				var_00 = var_0A;
				break;
			}
			else if(var_08 == -1 || var_01[var_02][var_0A] < var_08)
			{
				var_08 = var_01[var_02][var_0A];
				var_00 = var_0A;
			}
		}
	}

	if(isdefined(var_00))
	{
		self.var_2D32 = var_00;
	}

	return var_00;
}

//Function Number: 6
func_2DD5()
{
	if(func_2DD7())
	{
		if(self.var_2D57 == "capture" || self.var_2D57 == "capture_zone")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 7
func_2DDC()
{
	if(func_2DD7())
	{
		if(self.var_2D57 == "patrol")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 8
func_2DDD()
{
	if(func_2DD7())
	{
		if(self.var_2D57 == "protect")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 9
func_2DD4()
{
	if(func_2DD7())
	{
		if(self.var_2D57 == "bodyguard")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 10
func_2DD7()
{
	return isdefined(self.var_2D51);
}

//Function Number: 11
func_2DD8(param_00)
{
	if(func_2DD7())
	{
		if(func_2EC6(self.var_2D52,param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 12
func_2DDA(param_00)
{
	if(func_2DD4() && self.var_2D4D == param_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 13
func_2D19()
{
	var_00 = [];
	var_01 = [];
	var_02 = 0;
	foreach(var_04 in level.var_2C7A)
	{
		var_00[var_02] = scripts\common\utility::random(var_04.var_2EFE).origin;
		var_01[var_02] = "zone" + var_04.label;
		var_02++;
	}

	func_2D18(var_00,var_01);
}

//Function Number: 14
func_2D1A(param_00,param_01)
{
	wait(1);
	var_02 = [];
	var_03 = [];
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		if(isdefined(param_00[var_04].var_2EFD))
		{
			var_02[var_04] = param_00[var_04].var_2EFD.origin;
		}
		else
		{
			param_00[var_04].nearest_node = getclosestnodeinsight(param_00[var_04].origin);
			var_02[var_04] = param_00[var_04].nearest_node.origin;
		}

		var_03[var_04] = param_01 + param_00[var_04].script_label;
	}

	func_2D18(var_02,var_03);
}

//Function Number: 15
func_6655(param_00,param_01,param_02)
{
	var_03 = (0,0,11);
	var_04 = (0,0,40);
	var_05 = undefined;
	if(param_02 == "stand")
	{
		return 1;
	}
	else if(param_02 == "crouch")
	{
		var_05 = var_04;
	}
	else if(param_02 == "prone")
	{
		var_05 = var_03;
	}

	return sighttracepassed(param_01 + var_05,param_00 + var_05,0,undefined);
}

//Function Number: 16
func_2D18(param_00,param_01)
{
	wait(0.1);
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = param_01[var_03];
		var_02[var_04] = findentrances(param_00[var_03]);
		wait(0.05);
		for(var_05 = 0;var_05 < var_02[var_04].size;var_05++)
		{
			var_06 = var_02[var_04][var_05];
			var_06.var_9C8B = 1;
			var_06.var_DA7C[var_04] = func_6655(var_06.origin,param_00[var_03],"prone");
			wait(0.05);
			var_06.var_4A9C[var_04] = func_6655(var_06.origin,param_00[var_03],"crouch");
			wait(0.05);
			for(var_07 = 0;var_07 < param_01.size;var_07++)
			{
				for(var_08 = var_07 + 1;var_08 < param_01.size;var_08++)
				{
					var_06.var_C4B6[param_01[var_07]][param_01[var_08]] = 0;
					var_06.var_C4B6[param_01[var_08]][param_01[var_07]] = 0;
				}
			}
		}
	}

	var_09 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		for(var_05 = var_03 + 1;var_05 < param_00.size;var_05++)
		{
			var_0A = func_79A9(param_00[var_03],param_00[var_05]);
			var_09[param_01[var_03]][param_01[var_05]] = var_0A;
			var_09[param_01[var_05]][param_01[var_03]] = var_0A;
			foreach(var_0C in var_0A)
			{
				var_0C.var_C4B6[param_01[var_03]][param_01[var_05]] = 1;
				var_0C.var_C4B6[param_01[var_05]][param_01[var_03]] = 1;
			}
		}
	}

	if(!isdefined(level.var_D813))
	{
		level.var_D813 = [];
	}

	if(!isdefined(level.var_6650))
	{
		level.var_6650 = [];
	}

	if(!isdefined(level.var_664E))
	{
		level.var_664E = [];
	}

	if(!isdefined(level.var_6651))
	{
		level.var_6651 = [];
	}

	level.var_D813 = scripts\common\utility::func_2283(level.var_D813,var_09);
	level.var_6650 = scripts\common\utility::array_combine(level.var_6650,param_00);
	level.var_664E = scripts\common\utility::array_combine(level.var_664E,param_01);
	level.var_6651 = scripts\common\utility::func_2283(level.var_6651,var_02);
	level.var_6652 = 1;
}

//Function Number: 17
func_79A9(param_00,param_01)
{
	var_02 = func_74C8(param_00,param_01);
	if(isdefined(var_02))
	{
		var_02 = func_E001(var_02);
		var_02 = func_7800(var_02);
	}

	return var_02;
}

//Function Number: 18
func_74C9(param_00,param_01)
{
	return function_00C0(param_00,param_01);
}

//Function Number: 19
func_74C8(param_00,param_01)
{
	return getnodesonpath(param_00,param_01);
}

//Function Number: 20
func_74C3(param_00,param_01,param_02)
{
	return function_0022(param_00,param_01,param_02);
}

//Function Number: 21
func_C037(param_00,param_01)
{
	if(!isdefined(self.var_C4B6) || !isdefined(self.var_C4B6[param_00]) || !isdefined(self.var_C4B6[param_00][param_01]))
	{
		return 0;
	}

	return self.var_C4B6[param_00][param_01];
}

//Function Number: 22
func_7800(param_00)
{
	var_01 = param_00;
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = getlinkednodes(param_00[var_02]);
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			if(!scripts\common\utility::func_2286(var_01,var_03[var_04]))
			{
				var_01 = scripts\common\utility::array_add(var_01,var_03[var_04]);
			}
		}
	}

	return var_01;
}

//Function Number: 23
func_7D4B(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(nodesvisible(var_04,param_01,1))
		{
			var_02 = scripts\common\utility::array_add(var_02,var_04);
		}
	}

	return var_02;
}

//Function Number: 24
func_E001(param_00)
{
	param_00[param_00.size - 1] = undefined;
	param_00[0] = undefined;
	return scripts\common\utility::func_22BC(param_00);
}

//Function Number: 25
func_2ECA(param_00)
{
	var_01 = 1;
	while(!func_2D17(param_00))
	{
		wait(0.5);
	}
}

//Function Number: 26
func_2D17(param_00)
{
	if(function_001F())
	{
		return 1;
	}

	if(func_2EEF(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 27
func_2ECC(param_00)
{
	var_01 = gettime();
	for(;;)
	{
		if(isdefined(param_00))
		{
			if(gettime() > var_01 + param_00)
			{
				return;
			}
		}

		if(!isdefined(self.var_10C))
		{
			return;
		}
		else if(!func_2DCA())
		{
			return;
		}

		wait(0.05);
	}
}

//Function Number: 28
func_2DCA(param_00)
{
	var_01 = gettime() - self.last_enemy_sight_time;
	var_02 = level.var_2E3C;
	if(isdefined(param_00))
	{
		var_02 = param_00;
	}

	return var_01 < var_02;
}

//Function Number: 29
func_2ECB(param_00,param_01,param_02)
{
	if(!isdefined(param_01) && isdefined(param_02))
	{
	}

	var_03 = ["goal","bad_path","no_path","node_relinquished","script_goal_changed"];
	if(isdefined(param_01))
	{
		var_03[var_03.size] = param_01;
	}

	if(isdefined(param_02))
	{
		var_03[var_03.size] = param_02;
	}

	if(isdefined(param_00))
	{
		var_04 = scripts\common\utility::func_1372E(var_03,param_00);
	}
	else
	{
		var_04 = scripts\common\utility::func_13730(var_04);
	}

	return var_04;
}

//Function Number: 30
func_2EBE(param_00,param_01,param_02)
{
	level endon("game_ended");
	childthread func_12FB1();
	var_03 = scripts\common\utility::waittill_any_timeout_1(param_00,param_01,param_02,"use_button_no_longer_pressed","finished_use");
	self notify("stop_usebutton_watcher");
	return var_03;
}

//Function Number: 31
func_12FB1(param_00,param_01)
{
	self endon("stop_usebutton_watcher");
	wait(0.05);
	while(self usebuttonpressed())
	{
		wait(0.05);
	}

	self notify("use_button_no_longer_pressed");
}

//Function Number: 32
func_2EEF(param_00)
{
	foreach(var_02 in level.var_C928)
	{
		if(isai(var_02))
		{
			if(isdefined(param_00) && param_00)
			{
				if(!scripts\mp\_utility::func_9F9D(var_02))
				{
					continue;
				}
			}

			return 1;
		}
	}

	return 0;
}

//Function Number: 33
func_2DA8(param_00,param_01)
{
	if(!isdefined(level.var_6652) && !isdefined(self.var_5091))
	{
		return undefined;
	}

	var_02 = [];
	if(isdefined(self.var_5091))
	{
		var_02 = self.var_5091;
	}
	else
	{
		var_02 = level.var_6651[param_01];
	}

	if(!isdefined(param_00) || param_00 == "stand")
	{
		return var_02;
	}
	else if(param_00 == "crouch")
	{
		var_03 = [];
		foreach(var_05 in var_02)
		{
			if(var_05.var_4A9C[param_01])
			{
				var_03 = scripts\common\utility::array_add(var_03,var_05);
			}
		}

		return var_03;
	}
	else if(var_04 == "prone")
	{
		var_03 = [];
		foreach(var_07 in var_05)
		{
			if(var_07.var_DA7C[var_03])
			{
				var_05 = scripts\common\utility::array_add(var_05,var_07);
			}
		}

		return var_05;
	}

	return undefined;
}

//Function Number: 34
func_2D7A(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = self method_8533();
	var_05 = self.var_2D4D getvelocity();
	if(lengthsquared(var_05) > 100)
	{
		var_06 = getnodesinradius(param_00,param_01 * 1.75,param_01 * 0.5,500,"path",var_04);
		var_07 = [];
		var_08 = vectornormalize(var_05);
		for(var_09 = 0;var_09 < var_06.size;var_09++)
		{
			var_0A = vectornormalize(var_06[var_09].origin - self.var_2D4D.origin);
			if(vectordot(var_0A,var_08) > 0.1)
			{
				var_07[var_07.size] = var_06[var_09];
			}
		}
	}
	else
	{
		var_07 = getnodesinradius(param_01,param_02,0,500,"path",var_05);
	}

	if(isdefined(param_02) && param_02)
	{
		var_0B = vectornormalize(self.var_2D4D.origin - self.origin);
		var_0C = var_07;
		var_07 = [];
		foreach(var_0E in var_0C)
		{
			var_0A = vectornormalize(var_0E.origin - self.var_2D4D.origin);
			if(vectordot(var_0B,var_0A) > 0.2)
			{
				var_07[var_07.size] = var_0E;
			}
		}
	}

	var_10 = [];
	var_11 = [];
	var_12 = [];
	for(var_09 = 0;var_09 < var_07.size;var_09++)
	{
		var_13 = distancesquared(var_07[var_09].origin,param_00) > 10000;
		var_14 = abs(var_07[var_09].origin[2] - self.var_2D4D.origin[2]) < 50;
		if(var_13)
		{
			var_10[var_10.size] = var_07[var_09];
		}

		if(var_14)
		{
			var_11[var_11.size] = var_07[var_09];
		}

		if(var_13 && var_14)
		{
			var_12[var_12.size] = var_07[var_09];
		}

		if(var_09 % 100 == 99)
		{
			wait(0.05);
		}
	}

	if(var_12.size > 0)
	{
		var_03 = self botnodepick(var_12,var_12.size * 0.15,"node_capture",param_00,undefined,self.var_5092);
	}

	if(!isdefined(var_03))
	{
		wait(0.05);
		if(var_11.size > 0)
		{
			var_03 = self botnodepick(var_11,var_11.size * 0.15,"node_capture",param_00,undefined,self.var_5092);
		}

		if(!isdefined(var_03) && var_10.size > 0)
		{
			wait(0.05);
			var_03 = self botnodepick(var_10,var_10.size * 0.15,"node_capture",param_00,undefined,self.var_5092);
		}
	}

	return var_03;
}

//Function Number: 35
func_2D78(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = self method_8533();
	var_05 = getnodesinradius(param_00,param_01,0,500,"path",var_04);
	if(var_05.size > 0)
	{
		var_03 = self botnodepick(var_05,var_05.size * 0.15,"node_capture",param_00,param_02,self.var_5092);
	}

	return var_03;
}

//Function Number: 36
func_2D79(param_00,param_01)
{
	var_02 = undefined;
	if(param_00.size > 0)
	{
		var_02 = self botnodepick(param_00,param_00.size * 0.15,"node_capture",undefined,param_01,self.var_5092);
	}

	return var_02;
}

//Function Number: 37
func_2D77(param_00,param_01)
{
	var_02 = undefined;
	var_03 = self method_8533();
	var_04 = getnodesinradius(param_00,param_01,0,500,"path",var_03);
	if(var_04.size > 0)
	{
		var_02 = self botnodepick(var_04,var_04.size * 0.15,"node_protect",param_00,self.var_5092);
	}

	return var_02;
}

//Function Number: 38
func_2E4A(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = undefined;
	var_06 = self method_8533();
	var_07 = getnodesinradius(param_00,param_01,0,500,"path",var_06);
	if(isdefined(var_07) && var_07.size >= 2)
	{
		var_05 = func_2D7B(var_07,param_02);
	}

	if(!isdefined(var_05))
	{
		if(!isdefined(param_03))
		{
			param_03 = 0;
		}

		if(!isdefined(param_04))
		{
			param_04 = 1;
		}

		var_08 = randomfloatrange(self.var_2D55 * param_03,self.var_2D55 * param_04);
		var_09 = anglestoforward((0,randomint(360),0));
		var_05 = param_00 + var_09 * var_08;
	}

	return var_05;
}

//Function Number: 39
func_2E49(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(param_01.size >= 2)
	{
		var_03 = func_2D7B(param_01,param_02);
	}

	if(!isdefined(var_03))
	{
		var_04 = scripts\common\utility::random(param_01);
		var_05 = var_04.origin - param_00;
		var_03 = param_00 + vectornormalize(var_05) * length(var_05) * randomfloat(1);
	}

	return var_03;
}

//Function Number: 40
func_2D7B(param_00,param_01)
{
	var_02 = undefined;
	var_03 = scripts\common\utility::array_randomize(param_00);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		for(var_05 = var_04 + 1;var_05 < var_03.size;var_05++)
		{
			var_06 = var_03[var_04];
			var_07 = var_03[var_05];
			if(nodesvisible(var_06,var_07,1))
			{
				var_02 = (var_06.origin[0] + var_07.origin[0] * 0.5,var_06.origin[1] + var_07.origin[1] * 0.5,var_06.origin[2] + var_07.origin[2] * 0.5);
				if(isdefined(param_01) && self [[ param_01 ]](var_02) == 1)
				{
					return var_02;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 41
func_507A()
{
	if(isdefined(self.var_2D54))
	{
		return self.var_2D54.origin;
	}
	else if(isdefined(self.var_2D52))
	{
		return self.var_2D52;
	}

	return undefined;
}

//Function Number: 42
func_2D0A()
{
	if(scripts\mp\_utility::func_2DD9())
	{
		if(isdefined(self.var_101B9) && self.var_101B9 == 1)
		{
			return 0;
		}
	}

	if(scripts\mp\_utility::func_9E68())
	{
		return 0;
	}

	if(func_2DE0())
	{
		return 0;
	}

	if(self isusingturret())
	{
		return 0;
	}

	if(isdefined(level.var_C1C4))
	{
		return 0;
	}

	if(isdefined(self.var_12B90) && self.var_12B90)
	{
		return 0;
	}

	if(isdefined(self.var_45D6) && self.var_45D6)
	{
		return 0;
	}

	if(self isoffhandweaponreadytothrow())
	{
		return 0;
	}

	if(!func_2DCA(500))
	{
		return 1;
	}

	if(!isalive(self.var_10C))
	{
		return 1;
	}

	return 0;
}

//Function Number: 43
func_2E62()
{
	var_00 = undefined;
	var_01 = botmemoryflags("investigated","killer_died");
	var_02 = botmemoryflags("investigated");
	var_03 = scripts\common\utility::random(botgetmemoryevents(0,gettime() - 10000,1,"death",var_01,self));
	if(isdefined(var_03))
	{
		var_00 = var_03;
		self.var_2E20 = 10000;
	}
	else
	{
		var_04 = undefined;
		if(self botgetscriptgoaltype() != "none")
		{
			var_04 = self botgetscriptgoal();
		}

		var_05 = botgetmemoryevents(0,gettime() - -20536,1,"kill",var_02,self);
		var_06 = botgetmemoryevents(0,gettime() - -20536,1,"death",var_01,self);
		var_07 = [];
		foreach(var_09 in var_05)
		{
			var_07[var_07.size] = var_09;
		}

		foreach(var_09 in var_06)
		{
			var_07[var_07.size] = var_09;
		}

		var_03 = scripts\common\utility::random(var_07);
		if(isdefined(var_03) > 0 && !isdefined(var_04) || distancesquared(var_04,var_03) > 1000000)
		{
			var_00 = var_03;
			self.var_2E20 = -20536;
		}
	}

	if(isdefined(var_00))
	{
		var_0D = getzonenearest(var_00);
		var_0E = getzonenearest(self.origin);
		if(isdefined(var_0D) && isdefined(var_0E) && var_0E != var_0D)
		{
			var_0F = botzonegetcount(var_0D,self.team,"ally") + botzonegetcount(var_0D,self.team,"path_ally");
			if(var_0F > 1)
			{
				var_00 = undefined;
			}
		}
	}

	if(isdefined(var_00))
	{
		self.var_2E1F = var_00;
	}

	return var_00;
}

//Function Number: 44
func_2D66(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
}

//Function Number: 45
func_2D67(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
}

//Function Number: 46
func_2D65(param_00,param_01,param_02,param_03,param_04)
{
}

//Function Number: 47
func_2DB8()
{
	var_00 = 0;
	var_01 = undefined;
	if(isdefined(self.var_13CA0) && self.var_13CA0.size > 0)
	{
		var_01 = self.var_13CA0;
	}
	else
	{
		var_01 = self getweaponslistprimaries();
	}

	foreach(var_03 in var_01)
	{
		var_00 = var_00 + self getweaponammoclip(var_03);
		var_00 = var_00 + self getweaponammostock(var_03);
	}

	return var_00;
}

//Function Number: 48
func_2E3B()
{
	var_00 = undefined;
	if(isdefined(self.var_13CA0) && self.var_13CA0.size > 0)
	{
		var_00 = self.var_13CA0;
	}
	else
	{
		var_00 = self getweaponslistprimaries();
	}

	foreach(var_02 in var_00)
	{
		if(self getweaponammoclip(var_02) > 0)
		{
			return 0;
		}

		if(self getweaponammostock(var_02) > 0)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 49
func_2DA9()
{
	var_00 = 0;
	var_01 = self getweaponslistoffhands();
	foreach(var_03 in var_01)
	{
		var_00 = var_00 + self getweaponammostock(var_03);
	}

	return var_00;
}

//Function Number: 50
func_2DBD(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return 0;
	}

	switch(param_00)
	{
		case "trap_directional":
			switch(param_01)
			{
				case "claymore_mp":
					return 1;
			}
			break;

		case "trap":
			switch(param_01)
			{
				case "motion_sensor_mp":
				case "proximity_explosive_mp":
				case "trophy_mp":
					return 1;
			}
			break;

		case "c4":
			switch(param_01)
			{
				case "c4_mp":
					return 1;
			}
			break;

		case "tacticalinsertion":
			switch(param_01)
			{
				case "flare_mp":
					return 1;
			}
			break;
	}

	return 0;
}

//Function Number: 51
func_2DAA(param_00)
{
	if(self botgetdifficultysetting("allowGrenades") != 0)
	{
		var_01 = self botfirstavailablegrenade("lethal");
		if(func_2DBD(param_00,var_01))
		{
			return "lethal";
		}

		var_01 = self botfirstavailablegrenade("tactical");
		if(func_2DBD(param_00,var_01))
		{
			return "tactical";
		}
	}
}

//Function Number: 52
func_2ED4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self notify("bot_watch_nodes");
	self endon("bot_watch_nodes");
	self endon("bot_watch_nodes_stop");
	self endon("disconnect");
	self endon("death");
	wait(1);
	var_08 = 1;
	while(var_08)
	{
		if(self bothasscriptgoal() && self botpursuingscriptgoal())
		{
			if(distancesquared(self botgetscriptgoal(),self.origin) < 16)
			{
				var_08 = 0;
			}
		}

		if(var_08)
		{
			wait(0.05);
		}
	}

	var_09 = self.origin;
	if(isdefined(param_00))
	{
		self.var_1395E = [];
		foreach(var_0B in param_00)
		{
			var_0C = 0;
			if(distance2dsquared(self.origin,var_0B.origin) <= 10)
			{
				var_0C = 1;
			}

			var_0D = self geteye();
			var_0E = vectordot((0,0,1),vectornormalize(var_0B.origin - var_0D));
			if(abs(var_0E) > 0.92)
			{
				var_0C = 1;
			}

			if(!var_0C)
			{
				self.var_1395E[self.var_1395E.size] = var_0B;
			}
		}
	}

	if(!isdefined(self.var_1395E))
	{
		return;
	}

	if(isdefined(param_04))
	{
		self endon(param_04);
	}

	if(isdefined(param_05))
	{
		self endon(param_05);
	}

	if(isdefined(param_06))
	{
		self endon(param_06);
	}

	if(isdefined(param_07))
	{
		self endon(param_07);
	}

	thread func_1395F();
	self.var_1395E = scripts\common\utility::array_randomize(self.var_1395E);
	foreach(var_0B in self.var_1395E)
	{
		var_0B.var_1395D[self.var_6640] = 1;
	}

	var_12 = gettime();
	var_13 = var_12;
	var_14 = [];
	var_15 = undefined;
	if(isdefined(param_01))
	{
		var_15 = (0,param_01,0);
	}

	var_16 = isdefined(var_15) && isdefined(param_02);
	var_17 = undefined;
	var_18 = undefined;
	for(;;)
	{
		var_19 = gettime();
		self notify("still_watching_nodes");
		var_1A = self botgetfovdot();
		if(isdefined(param_03) && var_19 >= param_03)
		{
			return;
		}

		if(scripts\mp\bots\_bots_strategy::func_2DC5())
		{
			self botlookatpoint(undefined);
			wait(0.2);
			continue;
		}

		if(!self bothasscriptgoal() || !self botpursuingscriptgoal())
		{
			wait(0.2);
			continue;
		}

		if(isdefined(var_17) && var_17.var_1395D[self.var_6640] == 0)
		{
			var_13 = var_19;
		}

		if(self.var_1395E.size > 0)
		{
			var_1B = 0;
			if(isdefined(self.var_10C))
			{
				var_1C = self lastknownpos(self.var_10C);
				var_1D = self lastknowntime(self.var_10C);
				if(var_1D && var_19 - var_1D < 5000)
				{
					var_1E = vectornormalize(var_1C - self.origin);
					var_1F = 0;
					for(var_20 = 0;var_20 < self.var_1395E.size;var_20++)
					{
						var_21 = vectornormalize(self.var_1395E[var_20].origin - self.origin);
						var_22 = vectordot(var_1E,var_21);
						if(var_22 > var_1F)
						{
							var_1F = var_22;
							var_17 = self.var_1395E[var_20];
							var_1B = 1;
						}
					}
				}
			}

			if(!var_1B && var_19 >= var_13)
			{
				var_23 = [];
				for(var_20 = 0;var_20 < self.var_1395E.size;var_20++)
				{
					var_0B = self.var_1395E[var_20];
					var_24 = var_0B getnodenumber();
					if(var_16 && !scripts\common\utility::func_13D90(self.origin,var_15,var_0B.origin,param_02))
					{
						continue;
					}

					if(!isdefined(var_14[var_24]))
					{
						var_14[var_24] = 0;
					}

					if(scripts\common\utility::func_13D90(self.origin,self.angles,var_0B.origin,var_1A))
					{
						var_14[var_24] = var_19;
					}

					for(var_25 = 0;var_25 < var_23.size;var_25++)
					{
						if(var_14[var_23[var_25] getnodenumber()] > var_14[var_24])
						{
							break;
						}
					}

					var_23 = scripts\common\utility::func_229C(var_23,var_0B,var_25);
				}

				var_17 = undefined;
				for(var_20 = 0;var_20 < var_23.size;var_20++)
				{
					if(randomfloat(1) > var_23[var_20].var_1395D[self.var_6640])
					{
						continue;
					}

					var_0B = var_23[var_20];
					var_26 = (0,0,1);
					var_27 = self geteye();
					var_28 = (0,0,self getplayerviewheight());
					var_18 = var_0B.origin + var_28;
					var_29 = var_18 - var_27;
					var_29 = vectornormalize(var_29);
					var_22 = vectordot(var_29,var_26);
					if(var_22 > 0.939693)
					{
						continue;
					}

					var_17 = var_0B;
					var_13 = var_19 + randomintrange(3000,5000);
					break;
				}
			}

			if(isdefined(var_17))
			{
				var_28 = (0,0,self getplayerviewheight());
				var_18 = var_17.origin + var_28;
				self botlookatpoint(var_18,0.4,"script_search");
			}
		}

		wait(0.2);
	}
}

//Function Number: 53
func_13960()
{
	self notify("bot_watch_nodes_stop");
	self.var_1395E = undefined;
}

//Function Number: 54
func_1395F()
{
	self notify("watch_nodes_aborted");
	self endon("watch_nodes_aborted");
	for(;;)
	{
		var_00 = scripts\common\utility::waittill_any_timeout_1(0.5,"still_watching_nodes");
		if(!isdefined(var_00) || var_00 != "still_watching_nodes")
		{
			func_13960();
			return;
		}
	}
}

//Function Number: 55
func_2DFB(param_00,param_01)
{
	if(isdefined(param_01) && param_01 != (0,0,0))
	{
		if(!scripts\common\utility::func_13D90(self.origin,self.angles,param_01,self botgetfovdot()))
		{
			var_02 = self botpredictseepoint(param_01);
			if(isdefined(var_02))
			{
				self botlookatpoint(var_02 + (0,0,40),1,"script_seek");
			}
		}

		self botmemoryevent("known_enemy",undefined,param_01);
	}
}

//Function Number: 56
func_2DAF(param_00,param_01)
{
	if(isdefined(param_01) && isdefined(param_01.classname))
	{
		if(param_01.classname == "grenade")
		{
			if(!func_2D6E(param_01))
			{
				return param_00;
			}
		}
		else if(param_01.classname == "rocket")
		{
			if(isdefined(param_01.var_131D8))
			{
				return param_01.var_131D8;
			}

			if(isdefined(param_01.type) && param_01.type == "remote" || param_01.type == "odin")
			{
				return param_01;
			}

			if(isdefined(param_01.var_222))
			{
				return param_01.var_222;
			}
		}
		else if(param_01.classname == "worldspawn" || param_01.classname == "trigger_hurt")
		{
			return undefined;
		}

		return param_01;
	}

	return param_00;
}

//Function Number: 57
func_2D6E(param_00)
{
	if(!isdefined(param_00.var_13C2E))
	{
		return 0;
	}

	if(param_00.var_13C2E == "c4_mp")
	{
		return 1;
	}

	if(param_00.var_13C2E == "proximity_explosive_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 58
func_2EC6(param_00,param_01)
{
	return param_00[0] == param_01[0] && param_00[1] == param_01[1] && param_00[2] == param_01[2];
}

//Function Number: 59
func_2D06(param_00)
{
	param_00.var_8EE3 = [];
	if(param_00.var_2DD1 == "use")
	{
		func_2D07(param_00);
		return;
	}

	if(param_00.var_2DD1 == "damage")
	{
		func_2D05(param_00);
		return;
	}
}

//Function Number: 60
func_2E64(param_00)
{
	param_00.var_1D3F = 1;
	level.var_ABE5 = scripts\common\utility::func_22A9(level.var_ABE5,param_00);
}

//Function Number: 61
func_2D07(param_00)
{
	if(!issubstr(param_00.var_9F,"trigger_use"))
	{
		return;
	}

	if(!isdefined(param_00.target))
	{
		return;
	}

	if(isdefined(param_00.var_2EA8))
	{
		return;
	}

	if(!isdefined(param_00.var_13031))
	{
		return;
	}

	var_01 = function_00B4(param_00.target,"targetname");
	if(var_01.size != 1)
	{
		return;
	}

	param_00.var_2EA8 = var_01[0];
	if(!isdefined(level.var_ABE5))
	{
		level.var_ABE5 = [];
	}

	level.var_ABE5 = scripts\common\utility::array_add(level.var_ABE5,param_00);
}

//Function Number: 62
func_2D05(param_00)
{
	if(!issubstr(param_00.var_9F,"trigger_damage"))
	{
		return;
	}

	var_01 = function_00B4(param_00.target,"targetname");
	if(var_01.size != 2)
	{
		return;
	}

	param_00.var_2EAA = var_01;
	if(!isdefined(level.var_ABE5))
	{
		level.var_ABE5 = [];
	}

	level.var_ABE5 = scripts\common\utility::array_add(level.var_ABE5,param_00);
}

//Function Number: 63
func_2DB4(param_00,param_01)
{
	var_02 = 0;
	foreach(var_05, var_04 in param_00)
	{
		if(var_02 == param_01)
		{
			return var_05;
		}

		var_02++;
	}

	return undefined;
}

//Function Number: 64
func_2DB9(param_00,param_01)
{
	for(var_02 = 0;var_02 < level.var_13FBD;var_02++)
	{
		var_03 = getzonenodeforindex(var_02);
		var_03.var_13484 = 0;
	}

	var_04 = getzonenodeforindex(param_00);
	return func_2DBA(var_04,param_01);
}

//Function Number: 65
func_2DBA(param_00,param_01)
{
	var_02 = [];
	var_02[0] = getnodezone(param_00);
	param_00.var_13484 = 1;
	var_03 = getlinkednodes(param_00);
	foreach(var_05 in var_03)
	{
		if(!var_05.var_13484)
		{
			var_06 = distance(param_00.origin,var_05.origin);
			if(var_06 < param_01)
			{
				var_07 = func_2DBA(var_05,param_01 - var_06);
				var_02 = scripts\common\utility::array_combine(var_07,var_02);
			}
		}
	}

	return var_02;
}

//Function Number: 66
func_2D44(param_00)
{
	return isdefined(param_00) && isdefined(param_00.var_441B) && param_00.var_441B;
}

//Function Number: 67
func_2DB5()
{
	return int(func_2DA6() / 2);
}

//Function Number: 68
func_2DA6()
{
	var_00 = getdvarint("party_maxplayers",0);
	var_00 = max(var_00,getdvarint("party_maxPrivatePartyPlayers",0));
	if(var_00 > level.maxclients)
	{
		return level.maxclients;
	}

	return var_00;
}

//Function Number: 69
func_2E59()
{
	self notify("bot_queued_process_level_thread");
	self endon("bot_queued_process_level_thread");
	wait(0.05);
	for(;;)
	{
		if(isdefined(level.var_2E5B) && level.var_2E5B.size > 0)
		{
			var_00 = level.var_2E5B[0];
			if(isdefined(var_00) && isdefined(var_00.var_222))
			{
				var_01 = undefined;
				if(isdefined(var_00.var_C8FC))
				{
					var_01 = var_00.var_222 [[ var_00.var_74C2 ]](var_00.var_C8F9,var_00.var_C8FA,var_00.var_C8FB,var_00.var_C8FC);
				}
				else if(isdefined(var_00.var_C8FB))
				{
					var_01 = var_00.var_222 [[ var_00.var_74C2 ]](var_00.var_C8F9,var_00.var_C8FA,var_00.var_C8FB);
				}
				else if(isdefined(var_00.var_C8FA))
				{
					var_01 = var_00.var_222 [[ var_00.var_74C2 ]](var_00.var_C8F9,var_00.var_C8FA);
				}
				else if(isdefined(var_00.var_C8F9))
				{
					var_01 = var_00.var_222 [[ var_00.var_74C2 ]](var_00.var_C8F9);
				}
				else
				{
					var_01 = var_00.var_222 [[ var_00.var_74C2 ]]();
				}

				var_00.var_222 notify(var_00.var_BE47,var_01);
			}

			var_02 = [];
			for(var_03 = 1;var_03 < level.var_2E5B.size;var_03++)
			{
				var_02[var_03 - 1] = level.var_2E5B[var_03];
			}

			level.var_2E5B = var_02;
		}

		wait(0.05);
	}
}

//Function Number: 70
func_2E58(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.var_2E5B))
	{
		level.var_2E5B = [];
	}

	foreach(var_08, var_07 in level.var_2E5B)
	{
		if(var_07.var_222 == self && var_07.name == param_00)
		{
			self notify(var_07.name);
			level.var_2E5B[var_08] = undefined;
		}
	}

	var_07 = spawnstruct();
	var_07.var_222 = self;
	var_07.name = param_00;
	var_07.var_BE47 = var_07.name + "_done";
	var_07.var_74C2 = param_01;
	var_07.var_C8F9 = param_02;
	var_07.var_C8FA = param_03;
	var_07.var_C8FB = param_04;
	var_07.var_C8FC = param_05;
	level.var_2E5B[level.var_2E5B.size] = var_07;
	if(!isdefined(level.var_2E5A))
	{
		level.var_2E5A = 1;
		level thread func_2E59();
	}

	self waittill(var_07.var_BE47,var_09);
	return var_09;
}

//Function Number: 71
func_2DE0()
{
	return scripts\mp\_utility::func_9FC6() || self islinked();
}

//Function Number: 72
func_2DB0(param_00)
{
	var_01 = undefined;
	if(isdefined(self.var_13CA0) && self.var_13CA0.size > 0)
	{
		var_01 = self.var_13CA0;
	}
	else
	{
		var_01 = self getweaponslistprimaries();
	}

	foreach(var_03 in var_01)
	{
		var_04 = weaponclipsize(var_03);
		var_05 = self getweaponammostock(var_03);
		if(var_05 <= var_04)
		{
			return 1;
		}

		if(self getfractionmaxammo(var_03) <= param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 73
func_2E4E(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 256;
	}

	if(!isdefined(param_02))
	{
		param_02 = 50;
	}

	var_03 = getnodesinradiussorted(param_00,param_01,0,param_02,"Path");
	foreach(var_05 in var_03)
	{
		var_06 = param_00 + (0,0,30);
		var_07 = var_05.origin + (0,0,30);
		var_08 = physicstrace(var_06,var_07);
		if(func_2EC6(var_08,var_07))
		{
			return 1;
		}

		wait(0.05);
	}

	return 0;
}

//Function Number: 74
func_2E21(param_00)
{
	level endon("game_ended");
	self notify("bot_monitor_enemy_camp_spots");
	self endon("bot_monitor_enemy_camp_spots");
	level.var_63E5 = [];
	level.var_63E4 = [];
	level.var_63E3 = [];
	for(;;)
	{
		wait(1);
		var_01 = [];
		if(!isdefined(param_00))
		{
			continue;
		}

		foreach(var_03 in level.var_C928)
		{
			if(!isdefined(var_03.team))
			{
				continue;
			}

			if(var_03 [[ param_00 ]]() && !isdefined(var_01[var_03.team]))
			{
				level.var_63E3[var_03.team] = undefined;
				level.var_63E5[var_03.team] = var_03 getclosestenemysqdist(1);
				if(isdefined(level.var_63E5[var_03.team]))
				{
					if(!isdefined(level.var_63E4[var_03.team]) || !scripts\common\utility::func_2286(level.var_63E5[var_03.team],level.var_63E4[var_03.team]))
					{
						level.var_63E4[var_03.team] = scripts\common\utility::random(level.var_63E5[var_03.team]);
					}

					if(isdefined(level.var_63E4[var_03.team]))
					{
						var_04 = [];
						foreach(var_06 in level.var_C928)
						{
							if(!isdefined(var_06.team))
							{
								continue;
							}

							if(var_06 [[ param_00 ]]() && var_06.team == var_03.team)
							{
								var_04[var_04.size] = var_06;
							}
						}

						var_04 = sortbydistance(var_04,level.var_63E4[var_03.team]);
						if(var_04.size > 0)
						{
							level.var_63E3[var_03.team] = var_04[0];
						}
					}
				}

				var_01[var_03.team] = 1;
			}
		}
	}
}

//Function Number: 75
func_2EBF()
{
	if(!isdefined(self))
	{
		return 0;
	}

	if(!isai(self))
	{
		return 0;
	}

	if(!isdefined(self.team))
	{
		return 0;
	}

	if(self.team == "spectator")
	{
		return 0;
	}

	if(!isalive(self))
	{
		return 0;
	}

	if(!scripts\mp\_utility::func_9D36(self))
	{
		return 0;
	}

	if(self.var_CA79 == "camper")
	{
		return 0;
	}

	return 1;
}

//Function Number: 76
func_2EBD()
{
	if(!isdefined(level.var_63E3))
	{
		return;
	}

	if(!isdefined(level.var_63E3[self.team]))
	{
		return;
	}

	if(level.var_63E3[self.team] == self)
	{
		scripts\mp\bots\_bots_strategy::func_2D4E();
		self botsetscriptgoal(level.var_63E4[self.team],128,"objective",undefined,256);
		func_2ECB();
	}
}

//Function Number: 77
func_2D9C(param_00,param_01)
{
	self notify("bot_force_stance_for_time");
	self endon("bot_force_stance_for_time");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self botsetstance(param_00);
	wait(param_01);
	self botsetstance("none");
}