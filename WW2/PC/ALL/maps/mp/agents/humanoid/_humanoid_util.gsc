/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\humanoid\_humanoid_util.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 55
 * Decompile Time: 958 ms
 * Timestamp: 10/27/2023 3:08:45 AM
*******************************************************************/

//Function Number: 1
func_1F51(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 6;
	}

	var_03 = (0,0,1) * param_02;
	var_04 = param_00 + var_03;
	var_05 = param_01 + var_03;
	var_06 = 1;
	if(isdefined(self.var_64AB))
	{
		var_06 = 0;
	}

	return capsuletracepassed(var_04,self.var_14F,self.var_BD - param_02,self,var_06,0,0,var_05);
}

//Function Number: 2
func_45C6()
{
	return 8;
}

//Function Number: 3
func_457C()
{
	return 360 / func_45C6();
}

//Function Number: 4
func_60F4(param_00,param_01,param_02)
{
	var_03 = param_01 * func_457C() - 180;
	var_04 = param_00 + anglestoforward((0,var_03,0)) * param_02;
	return var_04;
}

//Function Number: 5
func_4582(param_00)
{
	return self.var_60F3[param_00];
}

//Function Number: 6
func_A275(param_00)
{
	if(!isdefined(self.var_60F3))
	{
		self.var_60F3 = [];
	}

	if(!isdefined(self.var_60F3[param_00]))
	{
		self.var_60F3[param_00] = [];
		for(var_01 = 0;var_01 < func_45C6();var_01++)
		{
			self.var_60F3[param_00][var_01] = spawnstruct();
			self.var_60F3[param_00][var_01].var_9A18 = 0;
			self.var_60F3[param_00][var_01].var_230B = undefined;
			self.var_60F3[param_00][var_01].var_116 = undefined;
			self.var_60F3[param_00][var_01].var_686A = var_01;
		}
	}
}

//Function Number: 7
func_45DC(param_00)
{
	var_01 = param_00.var_116;
	if(isdefined(param_00.var_4883))
	{
		var_01 = param_00.var_4883;
		if(isdefined(self.var_3043) && param_00 == self.var_3043 && func_4B59())
		{
			var_02 = func_459E();
			if(isdefined(var_02))
			{
				var_01 = var_02.var_116;
			}
		}
	}
	else if(isplayer(param_00) && param_00 method_83B8() || param_00 method_83B9())
	{
		if(!isdefined(param_00.var_73F1))
		{
			param_00.var_73F1 = 0;
		}

		if(gettime() > param_00.var_73F1)
		{
			param_00.var_73F0 = getgroundposition(param_00.var_116,15);
			param_00.var_73F1 = gettime();
		}

		if(isdefined(param_00.var_73F0))
		{
			var_01 = param_00.var_73F0;
		}
	}

	return var_01;
}

//Function Number: 8
func_4BA3(param_00,param_01)
{
	for(var_02 = 0;var_02 < func_45C6();var_02++)
	{
		var_03 = param_00 func_4582(param_01);
		var_04 = var_03[var_02];
		if(isdefined(var_04.var_116))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 9
func_1E52()
{
	var_00 = self getnearestnode();
	if(isdefined(var_00))
	{
		var_01 = nodegetsplitgroup(var_00);
		if(!isdefined(self.var_3043.var_663C))
		{
			self.var_3043.var_663C = [];
		}

		var_02 = 0;
		var_03 = 500;
		var_04 = undefined;
		var_05 = undefined;
		while(!isdefined(var_04) && var_03 <= 1500)
		{
			var_06 = [];
			if(isdefined(level.var_663D))
			{
				var_06 = getnodesinradiussorted(self.var_3043.var_4883,var_03,var_02,level.var_663D);
			}
			else
			{
				var_06 = getnodesinradiussorted(self.var_3043.var_4883,var_03,var_02);
			}

			var_07 = undefined;
			foreach(var_09 in var_06)
			{
				if(nodegetsplitgroup(var_09) == var_01)
				{
					if(!isdefined(var_07) || function_01F4(var_09,var_07,1))
					{
						var_04 = var_09;
						break;
					}
					else if(!isdefined(var_05))
					{
						var_05 = var_09;
					}
				}
			}

			var_02 = var_03;
			var_03 = var_03 + 500;
		}

		if(isdefined(var_04))
		{
			self.var_3043.var_663C[var_01] = var_04;
			return;
		}

		if(isdefined(var_05))
		{
			self.var_3043.var_663C[var_01] = var_05;
			return;
		}

		self.var_3043.var_663C[var_01] = 0;
		return;
	}
}

//Function Number: 10
func_4B59()
{
	var_00 = self getnearestnode();
	if(isdefined(var_00) && isdefined(self.var_3043.var_663C))
	{
		var_01 = self.var_3043.var_663C[nodegetsplitgroup(var_00)];
		if(isdefined(var_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 11
func_459E()
{
	var_00 = self getnearestnode();
	var_01 = self.var_3043.var_663C[nodegetsplitgroup(var_00)];
	if(!function_02A2(var_01))
	{
		return var_01;
	}

	return undefined;
}

//Function Number: 12
func_8BAE()
{
	if(func_4B59())
	{
		var_00 = func_459E();
		if(!isdefined(var_00))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 13
func_56DE(param_00)
{
	if(isdefined(self.var_3043) && param_00 == self.var_3043)
	{
		if(self.var_3044 > 5)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 14
func_4583(param_00,param_01)
{
	param_00 func_A275(self.var_60F5);
	var_02 = param_00 func_4582(self.var_60F5);
	var_04 = param_01;
	var_05 = self.var_116 - var_04;
	var_06 = lengthsquared(var_05);
	if(var_06 < 256)
	{
		var_07 = -1;
		for(var_08 = 0;var_08 < func_45C6();var_08++)
		{
			var_09 = var_02[var_08];
			if(isdefined(var_09.var_230B) && var_09.var_230B == self)
			{
				var_07 = var_09.var_686A;
			}
		}

		if(var_07 < 0)
		{
			var_07 = self getentitynumber() % func_45C6();
		}

		var_0A = var_07;
	}
	else
	{
		var_0B = angleclamp180(vectortoyaw(var_07)) + 180;
		var_0A = var_0B / func_457C();
		var_07 = int(var_0A + 0.5);
	}

	var_0C = undefined;
	var_0D = -1;
	var_0E = 3;
	var_0F = 2;
	if(var_0A > var_07)
	{
		var_0D = var_0D * -1;
		var_0E = var_0E * -1;
		var_0F = var_0F * -1;
	}

	var_10 = func_45C6();
	for(var_11 = 0;var_11 < var_10 / 2 + 1;var_11++)
	{
		for(var_12 = var_0D;var_12 != var_0E;var_12 = var_12 + var_0F)
		{
			var_13 = var_07 + var_11 * var_12;
			if(var_13 >= var_10)
			{
				var_13 = var_13 - var_10;
			}
			else if(var_13 < 0)
			{
				var_13 = var_13 + var_10;
			}

			var_09 = var_02[var_13];
			if(!isdefined(var_0C) && gettime() - var_09.var_9A18 >= self.var_60F6)
			{
				if(isdefined(level.var_9E16) && isdefined(level.var_9E16[self.var_A4B]))
				{
					[[ level.var_9E16[self.var_A4B] ]](var_09,var_04,self.var_11AB,self.var_14F);
				}
				else
				{
					func_9E16(var_09,var_04,self.var_11AB,self.var_14F);
				}
			}

			if(!isdefined(var_0C) && isdefined(var_09.var_116))
			{
				var_14 = 0;
				if(isdefined(var_09.var_230B) && var_09.var_230B != self)
				{
					var_15 = vectornormalize(var_04 - var_09.var_230B.var_116) * self.var_14F * 2;
					var_14 = distancesquared(var_09.var_230B.var_116 + var_15,var_04);
				}

				if(!isalive(var_09.var_230B) || !isdefined(var_09.var_230B.var_28D2) || var_09.var_230B.var_28D2 != param_00 || var_09.var_230B == self || var_06 < var_14)
				{
					if(isdefined(var_09.var_230B) && var_09.var_230B != self)
					{
						var_09.var_230B notify("lostSectorClaim");
						var_09.var_230B.var_836C = undefined;
					}

					if(isdefined(self.var_836C) && self.var_836C != var_09)
					{
						self.var_836C.var_230B = undefined;
					}

					self.var_836C = var_09;
					var_09.var_230B = self;
					var_0C = var_09.var_116;
					thread func_63DD(var_09);
				}
			}

			if(var_11 == 0)
			{
				break;
			}
		}
	}

	return var_0C;
}

//Function Number: 15
func_63DD(param_00)
{
	level endon("game_ended");
	self notify("monitorSectorClaim");
	self endon("monitorSectorClaim");
	self endon("lostSectorClaim");
	common_scripts\utility::knock_off_battery("death","disconnect");
	param_00.var_230B = undefined;
}

//Function Number: 16
func_9E16(param_00,param_01,param_02,param_03)
{
	if(gettime() - param_00.var_9A18 >= 50)
	{
		param_00.var_116 = func_60F4(param_01,param_00.var_686A,param_02);
		param_00.var_116 = func_34AB(param_00.var_116,param_03,self.var_BD - 5);
		param_00.var_9A18 = gettime();
	}
}

//Function Number: 17
func_34AB(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 18;
	}

	var_04 = param_00 + (0,0,param_03);
	var_05 = param_00 + (0,0,param_03 * -1);
	var_06 = self method_83EB(var_04,var_05,param_01,param_02,1);
	if(abs(var_06[2] - var_04[2]) < 0.1)
	{
		return undefined;
	}

	if(abs(var_06[2] - var_05[2]) < 0.1)
	{
		return undefined;
	}

	return var_06;
}

//Function Number: 18
func_56BC()
{
	return isdefined(self.var_2FDA) && self.var_2FDA;
}

//Function Number: 19
func_4580()
{
	if(!isdefined(self.var_5F4C) || self.var_5F4C)
	{
		return self.var_60EF;
	}

	return self.var_60F0;
}

//Function Number: 20
func_4581()
{
	if(!isdefined(self.var_5F4C) || self.var_5F4C)
	{
		return self.var_60F2;
	}

	return self.var_60F1;
}

//Function Number: 21
func_5F4E(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self.var_5F46 = param_00 * 1000;
	self.var_5F47 = param_04;
	self.var_5F45 = param_03;
	self.var_5F44 = isdefined(param_05) && param_05;
	self.var_5F49 = param_06;
	self.var_5F4F = param_02;
	self.var_5F50 = squared(self.var_5F4F);
	lib_0547::func_86C7(param_01);
}

//Function Number: 22
func_5F4B()
{
	if(isdefined(self.var_2F7D) && self.var_2F7D > 0)
	{
		self.var_2F7D--;
		if(self.var_2F7D > 0)
		{
			return;
		}
	}

	self.var_5F4C = 1;
}

//Function Number: 23
func_5F4A()
{
	if(!isdefined(self.var_2F7D))
	{
		self.var_2F7D = 0;
	}

	self.var_2F7D++;
	self.var_5F4C = 0;
}

//Function Number: 24
func_3141(param_00,param_01,param_02,param_03)
{
	self.var_313B = param_00 * 1000;
	self.var_313A = param_01;
	self.var_3139 = param_02;
	self.var_3137 = ["back","right","left"];
	self.var_3138 = [];
	foreach(var_06, var_05 in self.var_3137)
	{
		self.var_3138[var_06] = level.var_611[param_03 + var_05];
	}
}

//Function Number: 25
func_313D()
{
	if(isdefined(self.var_2F77) && self.var_2F77 > 0)
	{
		self.var_2F77--;
		if(self.var_2F77 > 0)
		{
			return;
		}
	}

	self.var_313E = 1;
}

//Function Number: 26
func_313C()
{
	if(!isdefined(self.var_2F77))
	{
		self.var_2F77 = 0;
	}

	self.var_2F77++;
	self.var_313E = 0;
}

//Function Number: 27
func_5C5B(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self.var_5C50 = param_00 * 1000;
	self.var_5C4F = param_01 * 1000;
	self.var_5C4E = param_02;
	self.var_5C57 = param_03;
	self.var_5C58 = squared(self.var_5C57);
	self.var_5C59 = param_04;
	self.var_5C5A = squared(self.var_5C59);
	self.var_5C54 = param_06;
	self.var_5C4D = param_05;
	self.var_5C55 = 0;
	self.var_5C56 = 0;
}

//Function Number: 28
func_5C52()
{
	if(isdefined(self.var_2F7C) && self.var_2F7C > 0)
	{
		self.var_2F7C--;
		if(self.var_2F7C > 0)
		{
			return;
		}
	}

	self.var_5C53 = 1;
}

//Function Number: 29
func_5C51()
{
	if(!isdefined(self.var_2F7C))
	{
		self.var_2F7C = 0;
	}

	self.var_2F7C++;
	self.var_5C53 = 0;
}

//Function Number: 30
func_20C3(param_00,param_01)
{
	self endon("death");
	self scragentsetscripted(1);
	maps/mp/agents/_scripted_agent_anim_util::func_8732(1,"ChangeAnimClass");
	self.var_5381 = 1;
	self scragentsetorientmode("face angle abs",(0,self.var_1D[1],0));
	self method_839C("anim deltas");
	self method_839A(1,1);
	var_02 = maps/mp/agents/_scripted_agent_anim_util::func_434D(param_01);
	var_03 = maps/mp/agents/_scripted_agent_anim_util::func_7A35(var_02);
	maps/mp/agents/_scripted_agent_anim_util::func_71FD(var_02,var_03,"change_anim_class");
	self method_83D5(param_00);
	func_A18C();
	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"ChangeAnimClass");
	self.var_5381 = 0;
	self scragentsetscripted(0);
}

//Function Number: 31
func_20C4(param_00)
{
	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"ChangeAnimClass");
	self.var_5381 = 0;
	self scragentsetscripted(0);
	self method_83D5(param_00);
	func_A18C();
	var_01 = "idle_noncombat";
	var_02 = maps/mp/agents/_scripted_agent_anim_util::func_434D(var_01);
	maps/mp/agents/_scripted_agent_anim_util::func_8415(var_02);
}

//Function Number: 32
func_A18C()
{
	if(maps\mp\_utility::func_585F())
	{
		switch(self method_85A5())
		{
			case "zombie_crawl_animclass":
			case "zombie_missing_left_leg_animclass":
			case "zombie_missing_right_leg_animclass":
				self method_85A1("zombie_crawler");
				break;

			default:
				self method_85A1("zombie");
				break;
		}

		return;
	}

	switch(self method_85A5())
	{
		case "mp_zombie_crawl_animclass":
		case "mp_zombie_missing_left_leg_animclass":
		case "mp_zombie_missing_right_leg_animclass":
			self method_85A1("zombie_crawler");
			break;

		default:
			self method_85A1("zombie");
			break;
	}
}

//Function Number: 33
func_8318(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	self endon("death");
	self endon("ScriptedAnimationInterrupt");
	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	var_0B = [];
	if(!isdefined(param_07))
	{
		param_07 = 0;
	}

	if(param_07)
	{
		if(!lib_0547::func_5816(param_08))
		{
			var_0B = common_scripts\utility::func_F73(var_0B,[level,param_08]);
		}

		if(!lib_0547::func_5816(param_09))
		{
			var_0B = common_scripts\utility::func_F73(var_0B,[self,param_09]);
		}
	}

	var_0C = self method_83DB(param_02);
	param_04 = isdefined(param_04) && param_04;
	if(isdefined(var_0C) && var_0C > 0)
	{
		self scragentsetscripted(1);
		maps/mp/agents/_scripted_agent_anim_util::func_8732(1,"ScriptedAnimation");
		if(param_04)
		{
			self.var_53D9 = 1;
		}

		self method_839C("anim deltas");
		self scragentsetorientmode("face angle abs",param_01);
		self method_839A(1,1);
		var_0D = "noclip";
		if(isdefined(param_0A) && isdefined(param_0A["physMode"]))
		{
			var_0D = param_0A["physMode"];
		}

		self method_839D(var_0D);
		var_0E = undefined;
		if(!isdefined(param_03))
		{
			param_03 = maps/mp/agents/_scripted_agent_anim_util::func_7A35(param_02);
		}
		else if(isdefined(param_0A) && isdefined(param_0A["timeOffset"]))
		{
			var_0E = float(param_0A["timeOffset"]);
		}

		if(!param_06)
		{
			func_5CA6(param_02,param_03);
		}

		self.var_116 = param_00;
		self.var_1D = param_01;
		if(param_07)
		{
			maps/mp/agents/_scripted_agent_anim_util::func_8415(param_02,param_03,1,var_0E);
			common_scripts\utility::func_8133(::common_scripts\utility::func_A70E,var_0B);
		}
		else
		{
			var_0F = "end";
			if(isdefined(param_0A) && isdefined(param_0A["end_notetrack"]))
			{
				var_0F = param_0A["end_notetrack"];
			}

			maps/mp/agents/_scripted_agent_anim_util::func_71FD(param_02,param_03,"scripted_anim",var_0F,param_05,var_0E);
		}

		maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"ScriptedAnimation");
		if(param_04)
		{
			self.var_53D9 = undefined;
			lib_0547::func_84CB();
		}

		self scragentsetscripted(0);
	}
}

//Function Number: 34
func_5429()
{
	self notify("ScriptedAnimationInterrupt");
	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"ScriptedAnimationInterrupt");
	self scragentsetscripted(0);
}

//Function Number: 35
func_5CA6(param_00,param_01)
{
	var_02 = 2;
	var_03 = self method_83D8(param_00,param_01);
	var_04 = func_4552(var_03);
	var_05 = func_462E(var_03,var_04);
	var_06 = func_4718(var_03);
	var_05 = var_05 + (0,0,var_06 + var_02);
	thread func_6F54(var_05,var_04);
}

//Function Number: 36
func_4718(param_00)
{
	var_01 = 50;
	var_02 = 32;
	var_03 = 72;
	var_04 = getmovedelta(param_00);
	var_04 = rotatevector(var_04,self.var_1D);
	var_05 = self.var_116 + var_04;
	var_06 = (0,0,var_01);
	var_07 = self method_83EB(var_05 + var_06,var_05 - var_06,var_02,var_03);
	var_08 = var_07 - var_05;
	return var_08[2];
}

//Function Number: 37
func_462E(param_00,param_01)
{
	var_02 = getanimlength(param_00);
	var_03 = param_01 / var_02;
	var_04 = getmovedelta(param_00,0,var_03);
	var_05 = rotatevector(var_04,self.var_1D);
	return self.var_116 + var_05;
}

//Function Number: 38
func_4552(param_00)
{
	var_01 = 0.2;
	var_02 = getanimlength(param_00);
	return min(var_01,var_02);
}

//Function Number: 39
func_6F54(param_00,param_01)
{
	self endon("death");
	self endon("killanimscript");
	level endon("game_ended");
	self method_83A4(self.var_116,param_00,param_01);
	wait(param_01);
	self method_839C("anim deltas");
}

//Function Number: 40
func_45F8(param_00,param_01)
{
	var_02 = 0;
	if(param_01 > 1)
	{
		var_03 = int(param_01 * 0.5);
		var_04 = var_03 + param_01 % 2;
		if(param_00 < 0)
		{
			var_02 = randomint(var_04);
		}
		else
		{
			var_02 = var_03 + randomint(var_04);
		}
	}

	return var_02;
}

//Function Number: 41
func_56DD(param_00)
{
	var_01 = self.var_116[2] + self.var_BD;
	if(param_00.var_116[2] < var_01)
	{
		return 0;
	}

	var_02 = self.var_116[2] + self.var_BD + 2 * self.var_14F;
	if(param_00.var_116[2] > var_02)
	{
		return 0;
	}

	if(isplayer(param_00))
	{
		var_03 = param_00 getvelocity()[2];
		if(abs(var_03) > 12)
		{
			return 0;
		}
	}

	var_04 = 15;
	if(isdefined(param_00.var_14F))
	{
		var_04 = param_00.var_14F;
	}

	var_05 = self.var_14F + var_04;
	var_05 = var_05 * var_05;
	if(distance2dsquared(self.var_116,param_00.var_116) > var_05)
	{
		return 0;
	}

	return 1;
}

//Function Number: 42
func_867E(param_00)
{
	self.var_94 = param_00;
	self agentsetfavoriteenemy(param_00);
}

//Function Number: 43
func_29CB(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(param_00))
	{
		var_03 = param_00 - self gettagorigin("J_SpineLower");
		var_03 = (var_03[0],var_03[1],0);
		var_04 = vectortoangles(vectornormalize(var_03));
		var_02 = var_04[1];
	}
	else if(isdefined(param_01))
	{
		var_04 = vectortoangles(param_01);
		var_02 = var_04[1] - 180;
	}

	return var_02;
}

//Function Number: 44
func_362B()
{
	if(isdefined(self.var_2F79) && self.var_2F79 > 0)
	{
		self.var_2F79--;
		if(self.var_2F79 > 0)
		{
			return;
		}
	}

	self.var_4B6F = 1;
	func_362D();
	func_8859();
	func_362C();
}

//Function Number: 45
func_2F43()
{
	if(!isdefined(self.var_2F79))
	{
		self.var_2F79 = 0;
	}

	self.var_2F79++;
	func_2F44();
	func_2F45();
}

//Function Number: 46
func_4B31()
{
	return common_scripts\utility::func_562E(self.var_4B6F);
}

//Function Number: 47
func_362D()
{
	self method_8538(1);
}

//Function Number: 48
func_2F45()
{
	self method_8538(0);
}

//Function Number: 49
func_8859()
{
	var_00 = clamp(level.var_A980 / 20,0,1);
	var_01 = lerp(0.35,0.55,var_00);
	var_02 = lerp(0.06,0.12,var_00);
	func_5F4E(5,self.var_60F0 * 2,self.var_60F0 * 1.5,"attack_lunge_boost",level.var_611["boost_lunge"]);
	func_3141(5,var_01,"dodge_boost","boost_dodge_");
	func_5C5B(10,2,var_02,550,350,"leap_boost",level.var_611["boost_jump"]);
}

//Function Number: 50
func_362C()
{
	func_5F4B();
	func_313D();
	func_5C52();
}

//Function Number: 51
func_2F44()
{
	func_5F4A();
	func_313C();
	func_5C51();
}

//Function Number: 52
func_70C9(param_00)
{
	if(!isdefined(self.var_1919))
	{
		return;
	}

	if(self.var_1919 != "no_boost_fx")
	{
		playfxontag(param_00,self,self.var_1919);
	}
}

//Function Number: 53
func_3B85(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_744A)
	{
		if(lib_0547::func_577E(var_03))
		{
			var_01[var_01.size] = var_03;
		}
	}

	var_05 = [];
	foreach(var_07 in param_00)
	{
		if(lib_0547::func_6719(var_07))
		{
			continue;
		}

		var_08 = 0;
		foreach(var_03 in var_01)
		{
			if(distancesquared(var_07.var_116,var_03.var_116) < 65536)
			{
				var_08 = 1;
				break;
			}
		}

		if(var_08)
		{
			continue;
		}

		var_05[var_05.size] = var_07;
	}

	return var_05;
}

//Function Number: 54
func_AA51(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.var_28D2;
	}

	if(func_4580() == self.var_60F0)
	{
		return func_AA52(param_00);
	}

	var_01 = distancesquared(self.var_116,param_00.var_116) <= func_4581();
	return var_01;
}

//Function Number: 55
func_AA52(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.var_28D2;
	}

	var_01 = distancesquared(self.var_116,param_00.var_116) <= self.var_60F1;
	if(!var_01 && isplayer(param_00) || function_01EF(param_00))
	{
		var_02 = param_00 method_8551();
		if(isdefined(var_02) && isdefined(var_02.var_1A5) && var_02.var_1A5 == "care_package")
		{
			var_01 = distancesquared(self.var_116,param_00.var_116) <= self.var_60F1 * 4;
		}
	}

	if(!var_01 && isplayer(param_00) && common_scripts\utility::func_562E(param_00.var_571F))
	{
		if(length(self getvelocity()) < 5)
		{
			var_01 = distancesquared(self.var_116,param_00.var_116) <= self.var_60F1 * 4;
		}
	}

	return var_01;
}