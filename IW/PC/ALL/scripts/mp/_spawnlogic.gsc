/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_spawnlogic.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 70
 * Decompile Time: 2747 ms
 * Timestamp: 10/27/2023 12:21:36 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_108D1 = spawnstruct();
	if(scripts\mp\_utility::func_9D46())
	{
		level.killstreakspawnshielddelayms = 0;
	}
	else
	{
		level.killstreakspawnshielddelayms = 4000;
	}

	level.var_72A2 = 0;
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	level.var_55B6 = 0;
	level.var_C23D = 0;
	level.var_C23C = 0;
	level.players = [];
	level.var_C928 = [];
	level.var_3CB5 = [];
	level.var_108F8 = [];
	level.var_85D5 = [];
	level.var_B898 = [];
	level.var_3A59 = [];
	level.var_8DD3 = [];
	level.var_12A83 = [];
	level.var_114E3 = [];
	level.var_EC9F = [];
	level.var_935F = [];
	level.var_12B14 = [];
	level.var_27EF = [];
	level.var_105EA = [];
	level.var_D3CC = [];
	level.var_108D1.lowerlimitfullsights = getdvarfloat("scr_lowerLimitFullSights");
	level.var_108D1.lowerlimitcornersights = getdvarfloat("scr_lowerLimitCornerSights");
	level.var_108D1.lastteamspawnpoints = [];
	level.var_108D1.lastbadspawntime = [];
	level thread func_C56E();
	level thread func_108FE();
	level thread func_11ADC();
	level thread func_11B00();
	level thread func_11ACB();
	level thread func_11ADD();
	thread func_D91D();
	level thread func_AFB8();
	for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
	{
		level.var_115EA[level.teamnamelist[var_00]] = [];
		level.var_115CA[level.teamnamelist[var_00]] = [];
	}

	scripts\mp\_spawnfactor::func_9758();
	func_AEAE();
}

//Function Number: 2
func_11ADD()
{
	self waittill("host_migration_end");
}

//Function Number: 3
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		func_FAD6(var_00);
	}
}

//Function Number: 4
func_FAD6(param_00)
{
	if(isdefined(level.var_C7B3))
	{
		foreach(var_02 in level.var_C7B3)
		{
			param_00 thread func_139B5(var_02);
		}
	}
}

//Function Number: 5
func_139B5(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(var_01 != self)
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9F19(var_01))
		{
			continue;
		}

		if(scripts\mp\_utility::func_9FAE(var_01))
		{
			continue;
		}

		if(scripts\mp\_utility::istouchingboundsnullify(var_01))
		{
			continue;
		}

		var_01 thread func_13B84(param_00);
	}
}

//Function Number: 6
func_13B84(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	if(!isdefined(self.lastboundstimelimit))
	{
		self.lastboundstimelimit = scripts\mp\_utility::func_7F9B();
	}

	var_01 = gettime() + int(self.lastboundstimelimit * 1000);
	self.var_1D44 = 1;
	self setclientomnvar("ui_out_of_bounds_countdown",var_01);
	self method_859E("mp_out_of_bounds");
	var_02 = 0;
	var_03 = self.lastboundstimelimit;
	while(self istouching(param_00))
	{
		if(!scripts\mp\_utility::func_9F19(self) || scripts\mp\_utility::func_9FB3(level.var_7669))
		{
			break;
		}

		if(var_03 <= 0)
		{
			var_02 = 1;
			break;
		}

		scripts\common\utility::func_136F7();
		var_03 = var_03 - 0.05;
	}

	self setclientomnvar("ui_out_of_bounds_countdown",0);
	self method_859E("");
	self.var_1D44 = undefined;
	if(scripts\mp\_utility::func_9FB3(var_02))
	{
		self.lastboundstimelimit = undefined;
		scripts\mp\_utility::func_1417();
	}
	else
	{
		self.lastboundstimelimit = var_03;
		thread watchtimelimitcooldown();
	}

	if(scripts\mp\_utility::func_9F19(self) && scripts\mp\_utility::func_9FB3(level.var_C1BB) && !scripts\mp\_utility::func_9FB3(level.var_C1B2))
	{
		thread scripts\mp\killstreaks\_nuke::func_FB0F(0.05);
	}
}

//Function Number: 7
watchtimelimitcooldown()
{
	self endon("disconnect");
	self notify("start_time_limit_cooldown");
	self endon("start_time_limit_cooldown");
	var_00 = scripts\mp\_utility::getmaxoutofboundscooldown();
	while(var_00 > 0)
	{
		scripts\common\utility::func_136F7();
		var_00 = var_00 - 0.05;
	}

	self.lastboundstimelimit = undefined;
}

//Function Number: 8
func_F62D(param_00)
{
	var_01 = [param_00];
	var_02 = [0];
	foreach(var_04 in level.var_108D1.var_AFBF)
	{
		var_05 = strtok(var_04,"_");
		if(var_05.size == 3 && var_05[0] == param_00 && var_05[1] == "v")
		{
			var_01[var_01.size] = var_04;
			var_02[var_02.size] = int(var_05[2]);
		}
	}

	var_07 = randomint(var_01.size);
	param_00 = var_01[var_07];
	level.var_108D1.var_AFC0 = var_02[var_07];
	level.var_108D1.var_1677 = param_00;
}

//Function Number: 9
func_AEAE()
{
	level.var_108D1.var_10882 = [];
	level.var_108D1.var_AFBF = [];
	var_00 = -1;
	for(;;)
	{
		var_00++;
		var_01 = tablelookupbyrow("mp/spawnweights.csv",var_00,0);
		if(!isdefined(var_01) || var_01 == "")
		{
			break;
		}

		if(!isdefined(level.var_108D1.var_10882[var_01]))
		{
			level.var_108D1.var_10882[var_01] = [];
			level.var_108D1.var_AFBF[level.var_108D1.var_AFBF.size] = var_01;
		}

		var_02 = tablelookupbyrow("mp/spawnweights.csv",var_00,1);
		var_03 = tablelookupbyrow("mp/spawnweights.csv",var_00,2);
		var_03 = float(var_03);
		level.var_108D1.var_10882[var_01][var_02] = var_03;
	}
}

//Function Number: 10
func_EC46(param_00,param_01)
{
	foreach(var_04, var_03 in level.var_108D1.var_10882[level.var_108D1.var_1677])
	{
		scripts\mp\_spawnfactor::func_3710(param_00,var_04,var_03,param_01);
	}
}

//Function Number: 11
func_182D(param_00,param_01)
{
	var_02 = func_8140(param_00);
	var_03 = [];
	if(isdefined(level.modifiedspawnpoints))
	{
		for(var_04 = 0;var_04 < var_02.size;var_04++)
		{
			if(checkmodifiedspawnpoint(var_02[var_04]))
			{
				continue;
			}

			var_03[var_03.size] = var_02[var_04];
		}
	}
	else
	{
		var_03 = var_02;
	}

	if(!var_03.size)
	{
		if(!scripts\mp\_utility::func_9FB3(param_01))
		{
		}

		return;
	}

	if(!isdefined(level.var_10DF1))
	{
		level.var_10DF1 = [];
	}

	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_03[var_04] func_108FA();
		var_03[var_04].var_F1AE = 0;
		var_03[var_04].var_94C6 = 0;
		level.var_10DF1[level.var_10DF1.size] = var_03[var_04];
	}

	if(level.teambased)
	{
		foreach(var_06 in var_03)
		{
			var_06.var_94C6 = 1;
			var_07 = anglestoforward(var_06.angles);
			foreach(var_09 in var_03)
			{
				if(var_06 == var_09)
				{
					continue;
				}

				var_0A = vectornormalize(var_09.origin - var_06.origin);
				var_0B = vectordot(var_07,var_0A);
				if(var_0B > 0.86)
				{
					var_06.var_94C6 = 0;
					break;
				}
			}
		}
	}
}

//Function Number: 12
func_1829(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_04 = func_8140(param_01);
	if(!var_04.size)
	{
		return;
	}

	func_DF0D(param_00,var_04,param_03);
}

//Function Number: 13
func_DF0D(param_00,param_01,param_02)
{
	if(!isdefined(level.var_108FB))
	{
		level.var_108FB = [];
	}

	if(!isdefined(level.var_115EA[param_00]))
	{
		level.var_115EA[param_00] = [];
	}

	if(!isdefined(level.var_115CA[param_00]))
	{
		level.var_115CA[param_00] = [];
	}

	foreach(var_04 in param_01)
	{
		if(checkmodifiedspawnpoint(var_04))
		{
			continue;
		}

		if(!isdefined(var_04.var_9800))
		{
			var_04 func_108FA();
			level.var_108FB[level.var_108FB.size] = var_04;
		}

		if(scripts\mp\_utility::func_9FB3(param_02))
		{
			level.var_115CA[param_00][level.var_115CA[param_00].size] = var_04;
			var_04.var_9DF0 = 1;
			continue;
		}

		level.var_115EA[param_00][level.var_115EA[param_00].size] = var_04;
	}
}

//Function Number: 14
func_108FA()
{
	var_00 = self;
	level.var_108E4 = func_6988(level.var_108E4,var_00.origin);
	level.var_108E2 = func_6987(level.var_108E2,var_00.origin);
	var_00.var_143 = anglestoforward(var_00.angles);
	var_00.var_101E9 = var_00.origin + (0,0,50);
	var_00.var_A9F6 = gettime();
	var_00.var_C7DA = 1;
	var_00.var_9800 = 1;
	var_00.var_1D53 = [];
	var_00.var_A9E9 = [];
	var_01 = 1024;
	if(!bullettracepassed(var_00.var_101E9,var_00.var_101E9 + (0,0,var_01),0,undefined))
	{
		var_02 = var_00.var_101E9 + var_00.var_143 * 100;
		if(!bullettracepassed(var_02,var_02 + (0,0,var_01),0,undefined))
		{
			var_00.var_C7DA = 0;
		}
	}

	var_03 = anglestoright(var_00.angles);
	var_04 = 1;
	if(scripts\mp\_utility::func_9FB3(var_00.noalternates))
	{
		var_04 = 0;
	}

	if(var_04)
	{
		func_17A7(var_00,var_00.origin + var_03 * 45);
		func_17A7(var_00,var_00.origin - var_03 * 45);
	}

	if(func_100B9() || getdvarint("sv_generateLOSData",0) == 1)
	{
		var_00.var_DC0A = func_80AA(var_00.origin);
		if(var_00.var_DC0A.size <= 0)
		{
		}
	}

	func_98CD(var_00);
}

//Function Number: 15
func_17A7(param_00,param_01)
{
	var_02 = playerphysicstrace(param_00.origin,param_00.origin + (0,0,18));
	var_03 = var_02[2] - param_00.origin[2];
	var_04 = (param_01[0],param_01[1],param_01[2] + var_03);
	var_05 = playerphysicstrace(var_02,var_04);
	if(var_05 != var_04)
	{
		return;
	}

	var_06 = playerphysicstrace(var_04,param_01);
	param_00.var_1D53[param_00.var_1D53.size] = var_06;
}

//Function Number: 16
func_8140(param_00)
{
	if(!isdefined(level.var_108F8))
	{
		level.var_108F8 = [];
	}

	if(!isdefined(level.var_108F8[param_00]))
	{
		level.var_108F8[param_00] = [];
		level.var_108F8[param_00] = getspawnarray(param_00);
		foreach(var_02 in level.var_108F8[param_00])
		{
			var_02.classname = param_00;
		}
	}

	return level.var_108F8[param_00];
}

//Function Number: 17
func_813C(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_01 = undefined;
	param_00 = scripts\mp\_spawnscoring::func_3E05(param_00);
	param_00 = scripts\common\utility::array_randomize(param_00);
	foreach(var_03 in param_00)
	{
		var_01 = var_03;
		if(canspawn(var_01.origin) && !positionwouldtelefrag(var_01.origin))
		{
			break;
		}
	}

	return var_01;
}

//Function Number: 18
func_813F(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_02 = undefined;
	param_00 = scripts\mp\_spawnscoring::func_3E05(param_00);
	foreach(var_04 in param_00)
	{
		if(!isdefined(var_04.var_F1AE))
		{
			continue;
		}

		if(var_04.var_F1AE)
		{
			continue;
		}

		if(var_04.var_94C6)
		{
			var_02 = var_04;
			break;
		}

		var_02 = var_04;
	}

	if(!isdefined(var_02))
	{
		if(scripts\mp\_utility::func_9FB3(param_01))
		{
			return undefined;
		}

		var_02 = func_813C(param_00);
	}

	if(isdefined(var_02))
	{
		var_02.var_F1AE = 1;
	}

	return var_02;
}

//Function Number: 19
func_11ADC()
{
	for(;;)
	{
		level.var_85D5 = getentarray("grenade","classname");
		wait(0.05);
	}
}

//Function Number: 20
func_11B00()
{
	for(;;)
	{
		level.var_B898 = getentarray("rocket","classname");
		wait(0.05);
	}
}

//Function Number: 21
func_11ACB()
{
	for(;;)
	{
		level.var_3A59 = getentarray("care_package","targetname");
		wait(0.05);
	}
}

//Function Number: 22
func_81BA(param_00)
{
	return level.var_115EA[param_00];
}

//Function Number: 23
func_81A9(param_00)
{
	return level.var_115CA[param_00];
}

//Function Number: 24
func_9ED7()
{
	if(!isdefined(level.var_C96A))
	{
		var_00 = function_0076();
		level.var_C96A = isdefined(var_00) && var_00.size > 150;
	}

	return level.var_C96A;
}

//Function Number: 25
func_1855()
{
	level.var_C928[level.var_C928.size] = self;
}

//Function Number: 26
func_E113()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < level.var_C928.size;var_01++)
	{
		if(level.var_C928[var_01] == self)
		{
			var_00 = 1;
			while(var_01 < level.var_C928.size - 1)
			{
				level.var_C928[var_01] = level.var_C928[var_01 + 1];
				var_01++;
			}

			level.var_C928[var_01] = undefined;
			break;
		}
	}
}

//Function Number: 27
func_184B()
{
	level.var_3CB5[level.var_3CB5.size] = self;
}

//Function Number: 28
func_E106()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < level.var_3CB5.size;var_01++)
	{
		if(level.var_3CB5[var_01] == self)
		{
			var_00 = 1;
			while(var_01 < level.var_3CB5.size - 1)
			{
				level.var_3CB5[var_01] = level.var_3CB5[var_01 + 1];
				var_01++;
			}

			level.var_3CB5[var_01] = undefined;
			break;
		}
	}
}

//Function Number: 29
func_108FE()
{
	while(!isdefined(level.var_108FB) || level.var_108FB.size == 0)
	{
		wait(0.05);
	}

	level thread func_108FC();
	if(func_100B9() || getdvarint("sv_generateLOSData",0) == 1)
	{
		var_00 = [];
		if(level.var_108FB.size == 0)
		{
			scripts\common\utility::func_66BD("Spawn System Failure. No Spawnpoints found.");
		}

		for(var_01 = 0;var_01 < level.var_108FB.size;var_01++)
		{
			for(var_02 = 0;var_02 < level.var_108FB[var_01].var_DC0A.size;var_02++)
			{
				var_00[var_00.size] = level.var_108FB[var_01].var_DC0A[var_02];
			}
		}

		if(var_00.size > 0)
		{
			function_029F(var_00);
		}
		else
		{
			scripts\common\utility::func_66BD("Spawn System Failure. There are no pathnodes near any spawnpoints.");
		}
	}

	for(;;)
	{
		level.var_55B6 = getdvarint("scr_disableClientSpawnTraces") > 0;
		wait(0.05);
	}
}

//Function Number: 30
func_7D9A()
{
	var_00 = [];
	foreach(var_02 in level.var_3CB5)
	{
		if(!scripts\mp\_utility::func_9F19(var_02))
		{
			continue;
		}

		if(isplayer(var_02) && var_02.sessionstate != "playing")
		{
			continue;
		}

		if(var_02 scripts\mp\killstreaks\_killstreaks::func_9FC3() && isdefined(var_02.var_3F14) && !isdefined(var_02.var_3F14.var_BCB4) || !var_02.var_3F14.var_BCB4)
		{
			continue;
		}

		if(var_02 scripts\mp\killstreaks\_killstreaks::func_9FC4())
		{
			continue;
		}

		var_02.var_108DF = func_8143(var_02);
		if(var_02.var_108DF == "spectator")
		{
			continue;
		}

		if(isagent(var_02) && var_02.agent_type == "seeker")
		{
			continue;
		}

		var_03 = func_8083(var_02);
		var_04 = var_02 geteye();
		var_04 = (var_04[0],var_04[1],var_02.origin[2] + var_03);
		var_02.var_108E0 = var_03;
		var_02.var_10917 = var_04;
		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 31
func_12F1F()
{
	level.var_1091D = func_7D9A();
	foreach(var_01 in level.var_1091D)
	{
		var_01.var_1091E = undefined;
	}

	foreach(var_04 in level.var_12A83)
	{
		if(!isdefined(var_04))
		{
			continue;
		}

		var_04.var_108DF = func_8143(var_04);
		level.var_1091D[level.var_1091D.size] = var_04;
		var_04.var_1091E = undefined;
	}

	foreach(var_07 in level.var_12B14)
	{
		if(!isdefined(var_07))
		{
			continue;
		}

		var_07.var_108DF = func_8143(var_07);
		level.var_1091D[level.var_1091D.size] = var_07;
		var_07.var_1091E = undefined;
	}

	foreach(var_0A in level.var_105EA)
	{
		if(!isdefined(var_0A))
		{
			continue;
		}

		var_0A.var_108DF = func_8143(var_0A);
		level.var_1091D[level.var_1091D.size] = var_0A;
		var_0A.var_1091E = undefined;
	}

	foreach(var_0D in level.var_27EF)
	{
		if(!isdefined(var_0D))
		{
			continue;
		}

		var_0D.var_108DF = func_8143(var_0D);
		level.var_1091D[level.var_1091D.size] = var_0D;
		var_0D.var_1091E = undefined;
	}
}

//Function Number: 32
func_108FC()
{
	if(func_100B9())
	{
		level waittill("spawn_restart_trace_system");
	}

	var_00 = 18;
	var_01 = 0;
	var_02 = 0;
	var_03 = func_7D9A();
	for(;;)
	{
		if(var_02)
		{
			wait(0.05);
			var_01 = 0;
			var_02 = 0;
			var_03 = func_7D9A();
		}

		var_04 = level.var_108FB;
		var_04 = scripts\mp\_spawnscoring::func_3E05(var_04);
		var_02 = 1;
		foreach(var_06 in var_04)
		{
			func_41DF(var_06);
			foreach(var_08 in var_03)
			{
				if(var_06.var_74BC[var_08.var_108DF])
				{
					continue;
				}

				var_09 = function_01E7(var_06,var_06.var_101E9,var_08.var_10917);
				var_01++;
				if(!var_09)
				{
					continue;
				}

				if(var_09 > 0.95)
				{
					var_06.var_74BC[var_08.var_108DF]++;
					var_06.var_AFD9[var_08.var_108DF]++;
					continue;
				}

				var_06.var_466B[var_08.var_108DF]++;
			}

			func_17DC(var_06,level.var_12A83);
			func_17DC(var_06,level.var_12B14);
			func_17DC(var_06,level.var_105EA);
			func_17DC(var_06,level.var_27EF);
			func_AFDA(var_06);
			if(var_00 < var_01)
			{
				wait(0.05);
				var_01 = 0;
				var_02 = 0;
				var_03 = func_7D9A();
			}
		}
	}
}

//Function Number: 33
func_AFDA(param_00)
{
	if(scripts\mp\_utility::func_9FB3(param_00.var_3165) || scripts\mp\_utility::func_9FB3(param_00.var_9DCF))
	{
		return;
	}

	if(isdefined(level.var_B3FB))
	{
		if(isdefined(level.var_B3F3) && !isdefined(param_00.var_AFC1))
		{
			param_00.var_AFC1 = [[ level.var_B3F3 ]]();
		}

		if(isdefined(param_00.var_AFC1))
		{
			var_01 = 3;
			if(level.teambased)
			{
				var_02 = param_00.var_AFD9["allies"] == 0;
				var_03 = param_00.var_AFD9["axis"] == 0;
				if(var_02 && var_03)
				{
					var_01 = 0;
				}
				else if(var_02)
				{
					var_01 = 1;
				}
				else if(var_03)
				{
					var_01 = 2;
				}
			}
			else
			{
				var_01 = scripts\common\utility::func_116D7(param_00.var_74BC["all"] == 0,0,3);
			}

			if(!isdefined(param_00.var_AFBB) || param_00.var_AFBB != var_01)
			{
				[[ level.var_B3FB ]](param_00.var_AFC1,"allies","SPAWN_ENTITY",param_00.origin[0],param_00.origin[1],gettime(),var_01);
				param_00.var_AFBB = var_01;
				return;
			}
		}
	}
}

//Function Number: 34
func_108F9(param_00,param_01)
{
	func_41DE(param_00);
	foreach(var_03 in param_01)
	{
		var_04 = distancesquared(var_03.origin,param_00.origin);
		if(var_04 < param_00.var_B75F[var_03.var_108DF])
		{
			param_00.var_B75F[var_03.var_108DF] = var_04;
		}

		if(var_03.var_108DF == "spectator")
		{
			continue;
		}

		param_00.var_5722[var_03.var_108DF] = param_00.var_5722[var_03.var_108DF] + var_04;
		param_00.var_5723[var_03.var_108DF] = param_00.var_5723[var_03.var_108DF] + min(var_04,scripts\mp\_spawnfactor::func_B4BD());
		param_00.var_11A39[var_03.var_108DF]++;
		param_00.var_5721[var_03.var_108DF][var_03 getentitynumber()] = var_04;
	}
}

//Function Number: 35
func_8143(param_00)
{
	var_01 = "all";
	if(level.teambased)
	{
		var_01 = param_00.team;
	}

	return var_01;
}

//Function Number: 36
func_98CD(param_00)
{
	func_41DF(param_00);
	func_41DE(param_00);
}

//Function Number: 37
func_41DF(param_00)
{
	if(level.teambased)
	{
		foreach(var_02 in level.teamnamelist)
		{
			func_41E6(param_00,var_02);
		}

		return;
	}

	func_41E6(param_00,"all");
}

//Function Number: 38
func_FADD(param_00)
{
}

//Function Number: 39
func_41DE(param_00)
{
	if(level.teambased)
	{
		foreach(var_02 in level.teamnamelist)
		{
			func_41E5(param_00,var_02);
		}

		return;
	}

	func_41E5(param_00,"all");
}

//Function Number: 40
func_41E6(param_00,param_01)
{
	param_00.var_74BC[param_01] = 0;
	param_00.var_466B[param_01] = 0;
	param_00.var_AFD9[param_01] = 0;
	param_00.var_B4C4[param_01] = 0;
	param_00.var_B4A6[param_01] = 0;
}

//Function Number: 41
func_41E5(param_00,param_01)
{
	param_00.var_5722[param_01] = 0;
	param_00.var_5723[param_01] = 0;
	param_00.var_B75F[param_01] = 9999999;
	param_00.var_11A39[param_01] = 0;
	param_00.var_5721[param_01] = [];
}

//Function Number: 42
func_8083(param_00,param_01)
{
	if(isdefined(param_01) && param_01)
	{
		return 64;
	}

	var_02 = param_00 getstance();
	if(var_02 == "stand")
	{
		return 64;
	}

	if(var_02 == "crouch")
	{
		return 44;
	}

	return 32;
}

//Function Number: 43
func_17DC(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_04 = func_8143(var_03);
		if(param_00.var_74BC[var_04])
		{
			continue;
		}

		var_05 = var_03.origin + (0,0,50);
		var_06 = 0;
		if(!var_06)
		{
			var_06 = function_01E7(param_00,param_00.var_101E9,var_05);
		}

		if(!var_06)
		{
			continue;
		}

		if(var_06 > 0.95)
		{
			param_00.var_74BC[var_04]++;
			continue;
		}

		param_00.var_466B[var_04]++;
	}
}

//Function Number: 44
func_6C5B(param_00)
{
	if(!isplayer(self))
	{
		return;
	}

	var_01 = gettime();
	self.var_A9F4 = param_00;
	self.var_A9F6 = var_01;
	param_00.var_A9F6 = var_01;
	param_00.var_A9F5 = self.team;
	level.var_108D1.lastteamspawnpoints[self.team] = param_00;
}

//Function Number: 45
func_6989(param_00)
{
	var_01 = func_8140(param_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		level.var_108E4 = func_6988(level.var_108E4,var_01[var_02].origin);
		level.var_108E2 = func_6987(level.var_108E2,var_01[var_02].origin);
	}
}

//Function Number: 46
func_6988(param_00,param_01)
{
	if(param_00[0] > param_01[0])
	{
		param_00 = (param_01[0],param_00[1],param_00[2]);
	}

	if(param_00[1] > param_01[1])
	{
		param_00 = (param_00[0],param_01[1],param_00[2]);
	}

	if(param_00[2] > param_01[2])
	{
		param_00 = (param_00[0],param_00[1],param_01[2]);
	}

	return param_00;
}

//Function Number: 47
func_6987(param_00,param_01)
{
	if(param_00[0] < param_01[0])
	{
		param_00 = (param_01[0],param_00[1],param_00[2]);
	}

	if(param_00[1] < param_01[1])
	{
		param_00 = (param_00[0],param_01[1],param_00[2]);
	}

	if(param_00[2] < param_01[2])
	{
		param_00 = (param_00[0],param_00[1],param_01[2]);
	}

	return param_00;
}

//Function Number: 48
func_6CAF(param_00,param_01)
{
	var_02 = (0,0,0);
	var_02 = param_01 - param_00;
	var_02 = (var_02[0] / 2,var_02[1] / 2,var_02[2] / 2) + param_00;
	return var_02;
}

//Function Number: 49
func_F78E()
{
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	func_6989("mp_tdm_spawn_allies_start");
	func_6989("mp_tdm_spawn_axis_start");
	level.var_B32E = func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
}

//Function Number: 50
func_100BA()
{
	if(getdvarint("scr_forceStartSpawns",0) == 1)
	{
		return 1;
	}

	if(scripts\mp\_utility::func_9FB3(level.var_5614))
	{
		return 0;
	}

	return level.ingraceperiod && !isdefined(level.var_C234) || level.var_C234 == 0;
}

//Function Number: 51
func_8053(param_00,param_01)
{
	if(param_01)
	{
		var_02 = 0;
		var_03 = func_7E2D();
	}
	else
	{
		var_02 = func_7E2D();
		var_03 = 250;
	}

	return getnodesinradius(param_00,var_03,var_02,512,"path");
}

//Function Number: 52
func_80AA(param_00)
{
	var_01 = [];
	var_02 = getclosestnodeinsight(param_00);
	if(isdefined(var_02))
	{
		var_01[0] = var_02;
	}

	if(!isdefined(var_02))
	{
		var_01 = getnodesinradius(param_00,func_7E2D(),0,256,"path");
		if(var_01.size == 0)
		{
			var_01 = getnodesinradius(param_00,250,0,256,"path");
		}
	}

	return var_01;
}

//Function Number: 53
func_67D3(param_00,param_01)
{
	if(!func_100B9())
	{
		return;
	}

	var_02 = "all";
	if(level.teambased)
	{
		var_02 = scripts\mp\_gameobjects::getenemyteam(param_01);
	}

	func_41E6(param_00,var_02);
	var_03 = 0.95;
	var_04 = 0;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = func_9FB6();
	var_03 = level.var_108D1.lowerlimitfullsights;
	var_04 = level.var_108D1.lowerlimitcornersights;
	foreach(var_09 in level.var_1091D)
	{
		if(level.teambased && var_09.var_108DF != var_02)
		{
			continue;
		}

		if(param_00.var_74BC[var_09.var_108DF])
		{
			break;
		}

		if(!isdefined(var_09.var_1091E))
		{
			var_09.var_1091E = var_09 method_8480(func_7EB3());
			if(!isdefined(var_09.var_1091E) || var_09.var_1091E.size == 0)
			{
				if(isdefined(level.var_B3FC) && var_07 && isplayer(var_09))
				{
					if(!isdefined(var_09.var_A9CC) || var_09.var_A9CC != gettime())
					{
						[[ level.var_B3FC ]]("LOG_GENERIC_MESSAGE",gettime(),"WARNING: Could not use TTLOS data for player " + var_09.name);
						var_09.var_A9CC = gettime();
					}
				}
			}
		}

		if(var_07 && isdefined(var_09.var_1091E) && var_09.var_1091E.size > 0)
		{
			var_0A = _precomputedlosdatatest(var_09,param_00);
			var_05 = var_0A[0];
			var_06 = var_0A[1];
		}

		if(!isdefined(var_05))
		{
			var_0B = undefined;
			if(isplayer(var_09))
			{
				var_0B = var_09 geteye();
			}
			else
			{
				var_0B = var_09.origin + (0,0,50);
			}

			var_05 = func_54EC(param_00,var_09,var_0B);
			var_06 = var_05;
		}

		if(!isdefined(param_00.var_B4C4[var_09.var_108DF]) || var_05 > param_00.var_B4C4[var_09.var_108DF])
		{
			param_00.var_B4C4[var_09.var_108DF] = var_05;
		}

		if(isdefined(var_06) && isplayer(var_09))
		{
			if(!isdefined(param_00.var_B4A6[var_09.var_108DF]) || var_05 > param_00.var_B4A6[var_09.var_108DF])
			{
				param_00.var_B4A6[var_09.var_108DF] = var_06;
			}
		}

		if(var_05 > var_03)
		{
			param_00.var_74BC[var_09.var_108DF]++;
			param_00.var_AFD9[var_09.var_108DF]++;
			continue;
		}

		if(var_05 > var_04)
		{
			param_00.var_466B[var_09.var_108DF]++;
		}
	}

	func_AFDA(param_00);
}

//Function Number: 54
_precomputedlosdatatest(param_00,param_01)
{
	var_02 = checkttlosoverrides(param_00,param_01);
	if(!isdefined(var_02))
	{
		var_02 = function_0295(param_00.var_1091E,param_01.var_DC0A);
	}

	return var_02;
}

//Function Number: 55
checkttlosoverrides(param_00,param_01)
{
	if(!isdefined(level.var_108D1.ttlosoverrides))
	{
		return;
	}

	foreach(var_03 in param_00.var_1091E)
	{
		var_04 = var_03 getnodenumber();
		if(isdefined(level.var_108D1.ttlosoverrides[var_04]))
		{
			foreach(var_06 in param_01.var_DC0A)
			{
				var_07 = var_06 getnodenumber();
				if(isdefined(level.var_108D1.ttlosoverrides[var_04][var_07]))
				{
					return level.var_108D1.ttlosoverrides[var_04][var_07];
				}
			}
		}
	}
}

//Function Number: 56
addttlosoverride(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	for(;;)
	{
		if(isdefined(level.var_108D1))
		{
			break;
		}

		scripts\common\utility::func_136F7();
	}

	if(!isdefined(level.var_108D1.ttlosoverrides))
	{
		level.var_108D1.ttlosoverrides = [];
	}

	if(!isdefined(level.var_108D1.ttlosoverrides[param_00]))
	{
		level.var_108D1.ttlosoverrides[param_00] = [];
	}

	level.var_108D1.ttlosoverrides[param_00][param_01] = [param_02,param_03];
	if(!isdefined(level.var_108D1.ttlosoverrides[param_01]))
	{
		level.var_108D1.ttlosoverrides[param_01] = [];
	}

	level.var_108D1.ttlosoverrides[param_01][param_00] = [param_02,param_03];
}

//Function Number: 57
func_7E2D()
{
	return 130;
}

//Function Number: 58
func_7EB3()
{
	return 250;
}

//Function Number: 59
func_54EC(param_00,param_01,param_02)
{
	var_03 = param_00.var_101E9;
	var_04 = param_02;
	var_05 = physics_createcontents(["physicscontents_aiavoid","physicscontents_solid","physicscontents_structural"]);
	var_06 = function_0287(var_03,var_04,var_05,param_01,0,"physicsquery_any");
	return scripts\common\utility::func_116D7(var_06,0,1);
}

//Function Number: 60
func_7F98()
{
	return 2550;
}

//Function Number: 61
func_100B9()
{
	return getdvarint("sv_usePrecomputedLOSData",0) == 1 && !isdefined(level.var_560C) && getdvarint("sv_generateLOSData",0) != 1;
}

//Function Number: 62
func_9FB6()
{
	return function_0296();
}

//Function Number: 63
func_D91D()
{
	level waittill("prematch_done");
	if(getdvarint("scr_playtest",0) == 1 && isdefined(level.players))
	{
		foreach(var_01 in level.players)
		{
			if(var_01 ishost())
			{
				if(func_100B9())
				{
					var_01 iprintlnbold("Attempting to use NEW Spawn System...");
				}
				else
				{
					var_01 iprintlnbold("Using OLD Spawn System...");
				}

				break;
			}
		}
	}

	if(isdefined(level.var_B3FC))
	{
		if(func_100B9())
		{
			[[ level.var_B3FC ]]("LOG_GENERIC_MESSAGE",gettime(),"Attempting to use TTLOS Spawning Data...");
			return;
		}

		[[ level.var_B3FC ]]("LOG_GENERIC_MESSAGE",gettime(),"Using Corner-Trace Spawning System...");
	}
}

//Function Number: 64
func_E2B6()
{
	level notify("spawn_restart_trace_system");
}

//Function Number: 65
func_9DF1(param_00)
{
	return scripts\mp\_utility::func_9FB3(param_00.var_9DF0);
}

//Function Number: 66
func_AFB8()
{
	if(getdvarint("scr_extra_spawn_logging",0) != 1)
	{
		return;
	}

	level waittill("prematch_done");
	var_00 = undefined;
	var_01 = undefined;
	if(isdefined(level.var_B3F3))
	{
		var_00 = [[ level.var_B3F3 ]]();
		var_01 = [[ level.var_B3F3 ]]();
	}

	for(;;)
	{
		if(!func_100B9())
		{
			break;
		}

		func_AFB7("allies",var_00);
		wait(0.5);
		func_AFB7("axis",var_01);
		wait(0.5);
	}
}

//Function Number: 67
func_AFB7(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.team = param_00;
	var_02.pers = [];
	var_02.pers["team"] = param_00;
	var_02.var_5612 = 1;
	var_02.var_9DCF = 1;
	var_03 = var_02 [[ level.var_8136 ]]();
	if(isdefined(level.var_B3FB) && isdefined(var_03) && isdefined(param_01))
	{
		var_04 = scripts\common\utility::func_116D7(param_00 == "allies","BEST_SPAWN_ALLIES","BEST_SPAWN_AXIS");
		[[ level.var_B3FB ]](param_01,param_00,var_04,var_03.origin[0],var_03.origin[1],gettime());
	}
}

//Function Number: 68
clearlastteamspawns()
{
	level.var_108D1.lastteamspawnpoints = [];
}

//Function Number: 69
getoriginidentifierstring(param_00)
{
	return int(param_00.origin[0]) + " " + int(param_00.origin[1]) + " " + int(param_00.origin[2]);
}

//Function Number: 70
checkmodifiedspawnpoint(param_00)
{
	if(!isdefined(level.modifiedspawnpoints))
	{
		return 0;
	}

	var_01 = undefined;
	var_02 = getoriginidentifierstring(param_00);
	if(isdefined(level.modifiedspawnpoints[var_02]))
	{
		var_01 = level.modifiedspawnpoints[var_02][param_00.classname];
	}

	if(!isdefined(var_01))
	{
		return 0;
	}

	if(scripts\mp\_utility::func_9FB3(var_01["remove"]))
	{
		return 1;
	}

	if(isdefined(var_01["origin"]))
	{
		param_00.origin = var_01["origin"];
	}

	if(isdefined(var_01["angles"]))
	{
		param_00.angles = var_01["angles"];
	}

	if(scripts\mp\_utility::func_9FB3(var_01["no_alternates"]))
	{
		param_00.noalternates = 1;
	}

	return 0;
}