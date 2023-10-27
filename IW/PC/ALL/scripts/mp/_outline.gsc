/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_outline.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 866 ms
 * Timestamp: 10/27/2023 12:21:09 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_C79F = 0;
	level.var_C797 = [];
	level.outlineidspending = [];
	level thread func_C788();
	level thread func_C7A4();
	level thread outlineidswatchpending();
}

//Function Number: 2
func_C796(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(param_00.var_C7AE))
	{
		param_00.var_C7AE = [];
	}

	var_08 = spawnstruct();
	var_08.isdisabled = 0;
	var_08.priority = param_05;
	var_08.var_43A6 = param_01;
	var_08.var_D432 = param_02;
	var_08.playersvisibletopending = [];
	var_08.var_525C = param_03;
	var_08.var_6C10 = param_04;
	var_08.type = param_06;
	if(param_06 == "TEAM")
	{
		var_08.team = param_07;
	}

	var_09 = func_C79A();
	param_00.var_C7AE[var_09] = var_08;
	func_C787(param_00);
	var_0A = [];
	foreach(var_0C in var_08.var_D432)
	{
		if(!canoutlineforplayer(var_0C))
		{
			var_08.playersvisibletopending[var_08.playersvisibletopending.size] = var_0C;
			level.outlineidspending[var_09] = param_00;
			continue;
		}

		var_0D = func_C79B(param_00,var_0C);
		if(!isdefined(var_0D) || var_0D == var_08 || var_0D.priority == var_08.priority)
		{
			var_0A[var_0A.size] = var_0C;
		}
	}

	if(var_0A.size > 0)
	{
		param_00 _hudoutlineenableforclients(var_0A,var_08.var_43A6,var_08.var_525C,var_08.var_6C10);
	}

	return var_09;
}

//Function Number: 3
func_C790(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		level.var_C797 = scripts\common\utility::func_22BC(level.var_C797);
		return;
	}
	else if(!isdefined(param_01.var_C7AE))
	{
		func_C7AC(param_01);
		return;
	}

	var_02 = param_01.var_C7AE[param_00];
	if(!isdefined(var_02) || var_02.isdisabled)
	{
		return;
	}

	var_02.isdisabled = 1;
	foreach(var_04 in var_02.var_D432)
	{
		if(!isdefined(var_04))
		{
			continue;
		}

		if(!canoutlineforplayer(var_04))
		{
			var_02.playersvisibletopending[var_02.playersvisibletopending.size] = var_04;
			level.outlineidspending[param_00] = param_01;
			continue;
		}

		var_05 = func_C79B(param_01,var_04);
		if(isdefined(var_05))
		{
			if(var_05.priority <= var_02.priority)
			{
				param_01 _hudoutlineenableforclient(var_04,var_05.var_43A6,var_05.var_525C,var_05.var_6C10);
			}

			continue;
		}

		param_01 hudoutlinedisableforclient(var_04);
	}

	if(var_02.playersvisibletopending.size == 0)
	{
		param_01.var_C7AE[param_00] = undefined;
		if(param_01.var_C7AE.size == 0)
		{
			func_C7AC(param_01);
		}
	}
}

//Function Number: 4
func_C7AB(param_00)
{
	if(!isdefined(param_00.var_C7AE) || param_00.var_C7AE.size == 0)
	{
		return;
	}

	foreach(var_02 in param_00.var_C7AE)
	{
		if(!isdefined(var_02) || var_02.isdisabled)
		{
			continue;
		}

		foreach(var_04 in var_02.var_D432)
		{
			if(!isdefined(var_04))
			{
				continue;
			}

			var_05 = func_C79B(param_00,var_04);
			if(isdefined(var_05))
			{
				param_00 _hudoutlineenableforclient(var_04,var_05.var_43A6,var_05.var_525C,var_05.var_6C10);
			}
		}
	}
}

//Function Number: 5
func_C788()
{
	for(;;)
	{
		level waittill("connected",var_00);
		level thread func_C7A3(var_00);
	}
}

//Function Number: 6
func_C7A3(param_00)
{
	level endon("game_ended");
	param_00 waittill("disconnect");
	func_C7AD(param_00);
	func_C791(param_00);
}

//Function Number: 7
func_C7A4()
{
	for(;;)
	{
		level waittill("joined_team",var_00);
		if(!isdefined(var_00.team) || var_00.team == "spectator")
		{
			continue;
		}

		thread func_C7A5(var_00);
	}
}

//Function Number: 8
func_C7A5(param_00)
{
	param_00 notify("outlineOnPlayerJoinedTeam_onFirstSpawn");
	param_00 endon("outlineOnPlayerJoinedTeam_onFirstSpawn");
	param_00 endon("disconnect");
	param_00 waittill("spawned_player");
	func_C7AD(param_00);
	func_C791(param_00);
	func_C786(param_00);
}

//Function Number: 9
func_C7AD(param_00)
{
	level.var_C797 = scripts\common\utility::func_22BC(level.var_C797);
	foreach(var_02 in level.var_C797)
	{
		var_03 = 0;
		foreach(var_05 in var_02.var_C7AE)
		{
			var_05.var_D432 = scripts\common\utility::func_22BC(var_05.var_D432);
			if(isdefined(param_00) && scripts\common\utility::func_2286(var_05.var_D432,param_00))
			{
				var_05.var_D432 = scripts\common\utility::func_22A9(var_05.var_D432,param_00);
				var_03 = 1;
			}
		}

		if(var_03 && isdefined(var_02) && isdefined(param_00))
		{
			var_02 hudoutlinedisableforclient(param_00);
		}
	}
}

//Function Number: 10
func_C786(param_00)
{
	foreach(var_02 in level.var_C797)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		var_03 = undefined;
		foreach(var_05 in var_02.var_C7AE)
		{
			if(var_05.type == "ALL" || var_05.type == "TEAM" && var_05.team == param_00.team)
			{
				if(!scripts\common\utility::func_2286(var_05.var_D432,param_00))
				{
					var_05.var_D432[var_05.var_D432.size] = param_00;
				}
				else
				{
				}

				if(!isdefined(var_03) || var_05.priority > var_03.priority)
				{
					var_03 = var_05;
				}
			}
		}

		if(isdefined(var_03))
		{
			var_02 _hudoutlineenableforclient(param_00,var_03.var_43A6,var_03.var_525C,var_03.var_6C10);
		}
	}
}

//Function Number: 11
func_C791(param_00)
{
	if(!isdefined(param_00) || !isdefined(param_00.var_C7AE) || param_00.var_C7AE.size == 0)
	{
		return;
	}

	foreach(var_03, var_02 in param_00.var_C7AE)
	{
		func_C790(var_03,param_00);
	}
}

//Function Number: 12
func_C787(param_00)
{
	if(!scripts\common\utility::func_2286(level.var_C797,param_00))
	{
		level.var_C797[level.var_C797.size] = param_00;
	}
}

//Function Number: 13
func_C7AC(param_00)
{
	level.var_C797 = scripts\common\utility::func_22A9(level.var_C797,param_00);
}

//Function Number: 14
func_C79C(param_00)
{
	var_01 = -1;
	if(!isdefined(param_00.var_C7AE) || param_00.size == 0)
	{
		return var_01;
	}

	var_02 = undefined;
	foreach(var_05, var_04 in param_00.var_C7AE)
	{
		if(!isdefined(var_04) || var_04.isdisabled)
		{
			continue;
		}

		if(!isdefined(var_02) || var_04.priority > var_02.priority)
		{
			var_02 = var_04;
			var_01 = var_05;
		}
	}

	return var_01;
}

//Function Number: 15
func_C79B(param_00,param_01)
{
	var_02 = undefined;
	if(!isdefined(param_00.var_C7AE) || param_00.size == 0)
	{
		return var_02;
	}

	foreach(var_04 in param_00.var_C7AE)
	{
		if(!isdefined(var_04) || var_04.isdisabled)
		{
			continue;
		}

		if(scripts\common\utility::func_2286(var_04.var_D432,param_01) && !isdefined(var_02) || var_04.priority > var_02.priority)
		{
			var_02 = var_04;
		}
	}

	return var_02;
}

//Function Number: 16
func_C79A()
{
	level.var_C79F++;
	return level.var_C79F;
}

//Function Number: 17
func_C7A9(param_00)
{
	param_00 = tolower(param_00);
	var_01 = undefined;
	switch(param_00)
	{
		case "lowest":
			var_01 = 0;
			break;

		case "level_script":
			var_01 = 1;
			break;

		case "equipment":
			var_01 = 2;
			break;

		case "perk":
			var_01 = 3;
			break;

		case "perk_superior":
			var_01 = 4;
			break;

		case "killstreak":
			var_01 = 5;
			break;

		case "killstreak_personal":
			var_01 = 6;
			break;

		default:
			var_01 = 0;
			break;
	}

	return var_01;
}

//Function Number: 18
func_C78A(param_00)
{
	param_00 = tolower(param_00);
	var_01 = undefined;
	switch(param_00)
	{
		case "white":
			var_01 = 0;
			break;

		case "red":
			var_01 = 1;
			break;

		case "green":
			var_01 = 2;
			break;

		case "cyan":
			var_01 = 3;
			break;

		case "orange":
			var_01 = 4;
			break;

		case "yellow":
			var_01 = 5;
			break;

		case "blue":
			var_01 = 6;
			break;

		case "none":
			var_01 = 7;
			break;

		default:
			var_01 = 0;
			break;
	}

	return var_01;
}

//Function Number: 19
outlineidswatchpending()
{
	for(;;)
	{
		waittillframeend;
		foreach(var_03, var_01 in level.outlineidspending)
		{
			if(!isdefined(var_01))
			{
				continue;
			}

			if(!isdefined(var_01.var_C7AE))
			{
				continue;
			}

			var_02 = var_01.var_C7AE[var_03];
			if(!isdefined(var_02))
			{
				continue;
			}

			if(var_02.playersvisibletopending.size > 0)
			{
				if(outlinerefreshpending(var_01,var_03))
				{
					level.outlineidspending[var_03] = undefined;
				}
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 20
outlinerefreshpending(param_00,param_01)
{
	var_02 = param_00.var_C7AE[param_01];
	foreach(var_06, var_04 in var_02.playersvisibletopending)
	{
		if(!isdefined(var_04))
		{
			continue;
		}

		if(canoutlineforplayer(var_04))
		{
			var_05 = func_C79B(param_00,var_04);
			if(isdefined(var_05))
			{
				param_00 hudoutlineenableforclient(var_04,var_05.var_43A6,var_05.var_525C,var_05.var_6C10);
			}
			else
			{
				param_00 hudoutlinedisableforclient(var_04);
			}

			var_02.playersvisibletopending[var_06] = undefined;
		}
	}

	var_02.playersvisibletopending = scripts\common\utility::func_22BC(var_02.playersvisibletopending);
	if(var_02.playersvisibletopending.size == 0)
	{
		if(var_02.isdisabled)
		{
			param_00.var_C7AE[param_01] = undefined;
		}

		if(param_00.var_C7AE.size == 0)
		{
			func_C7AC(param_00);
		}

		return 1;
	}

	return 0;
}

//Function Number: 21
canoutlineforplayer(param_00)
{
	return param_00.sessionstate != "spectator";
}

//Function Number: 22
_hudoutlineenableforclient(param_00,param_01,param_02,param_03)
{
	if(param_01 == 7)
	{
		self hudoutlinedisableforclient(param_00);
		return;
	}

	self hudoutlineenableforclient(param_00,param_01,param_02,param_03);
}

//Function Number: 23
_hudoutlineenableforclients(param_00,param_01,param_02,param_03)
{
	if(param_01 == 7)
	{
		self method_818D(param_00);
		return;
	}

	self method_8190(param_00,param_01,param_02,param_03);
}