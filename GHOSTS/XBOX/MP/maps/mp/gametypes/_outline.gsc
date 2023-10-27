/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_outline.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 17
 * Decompile Time: 266 ms
 * Timestamp: 10/27/2023 1:31:22 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.outlineids = 0;
	level.outlineents = [];
	level thread func_5A3E();
	level thread func_5A4D();
}

//Function Number: 2
func_5A46(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_00.outlines))
	{
		param_00.outlines = [];
	}

	var_07 = addstruct();
	var_07.priority = param_04;
	var_07.colorindex = param_01;
	var_07.playersvisibleto = param_02;
	var_07.depthenable = param_03;
	var_07.type = param_05;
	if(param_05 == "TEAM")
	{
		var_07.team = param_06;
	}

	var_08 = func_5A48();
	param_00.outlines[var_08] = var_07;
	func_5A3D(param_00);
	var_09 = [];
	foreach(var_0B in var_07.playersvisibleto)
	{
		var_0C = outlinegethighestinfoforplayer(param_00,var_0B);
		if(!isdefined(var_0C) || var_0C == var_07 || var_0C.priority == var_07.priority)
		{
			var_09[var_09.size] = var_0B;
		}
	}

	if(var_09.size > 0)
	{
		param_00 hudoutlinedisableforclient(var_09,var_07.colorindex,var_07.depthenable);
	}

	return var_08;
}

//Function Number: 3
func_5A41(param_00,param_01)
{
	if(!isdefined(param_01.outlines))
	{
		func_5A50(param_01);
	}
	else if(!isdefined(param_01.outlines[param_00]))
	{
	}

	var_02 = param_01.outlines[param_00];
	var_03 = [];
	foreach(var_06, var_05 in param_01.outlines)
	{
		if(var_05 != var_02)
		{
			var_03[var_06] = var_05;
		}
	}

	if(var_03.size == 0)
	{
		func_5A50(param_01);
	}

	if(isdefined(param_01))
	{
		param_01.outlines = var_03;
		foreach(var_08 in var_02.playersvisibleto)
		{
			if(!isdefined(var_08))
			{
				continue;
			}

			var_09 = outlinegethighestinfoforplayer(param_01,var_08);
			if(isdefined(var_09))
			{
				if(var_09.priority <= var_02.priority)
				{
					param_01 setplanesplineid(var_08,var_09.colorindex,var_09.depthenable);
				}

				continue;
			}

			param_01 hudoutlineenableforclient(var_08);
		}
	}
}

//Function Number: 4
func_5A3E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		level thread outlineonplayerdisconnect(var_00);
	}
}

//Function Number: 5
outlineonplayerdisconnect(param_00)
{
	level endon("game_ended");
	param_00 waittill("disconnect");
	outlineremoveplayerfromvisibletoarrays(param_00);
	func_5A42(param_00);
}

//Function Number: 6
func_5A4D()
{
	for(;;)
	{
		level waittill("joined_team",var_00);
		if(!isdefined(var_00.team) || var_00.team == "spectator")
		{
			continue;
		}

		thread func_5A4E(var_00);
	}
}

//Function Number: 7
func_5A4E(param_00)
{
	param_00 notify("outlineOnPlayerJoinedTeam_onFirstSpawn");
	param_00 endon("outlineOnPlayerJoinedTeam_onFirstSpawn");
	param_00 endon("disconnect");
	param_00 waittill("spawned_player");
	outlineremoveplayerfromvisibletoarrays(param_00);
	func_5A42(param_00);
	func_5A3C(param_00);
}

//Function Number: 8
outlineremoveplayerfromvisibletoarrays(param_00)
{
	level.outlineents = common_scripts\utility::array_removeundefined(level.outlineents);
	foreach(var_02 in level.outlineents)
	{
		var_03 = 0;
		foreach(var_05 in var_02.outlines)
		{
			var_05.playersvisibleto = common_scripts\utility::array_removeundefined(var_05.playersvisibleto);
			if(isdefined(param_00) && common_scripts\utility::array_contains(var_05.playersvisibleto,param_00))
			{
				var_05.playersvisibleto = common_scripts\utility::array_remove(var_05.playersvisibleto,param_00);
				var_03 = 1;
			}
		}

		if(var_03 && isdefined(var_02) && isdefined(param_00))
		{
			var_02 hudoutlineenableforclient(param_00);
		}
	}
}

//Function Number: 9
func_5A3C(param_00)
{
	foreach(var_02 in level.outlineents)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		var_03 = undefined;
		foreach(var_05 in var_02.outlines)
		{
			if(var_05.type == "ALL" || var_05.type == "TEAM" && var_05.team == param_00.team)
			{
				if(!common_scripts\utility::array_contains(var_05.playersvisibleto,param_00))
				{
					var_05.playersvisibleto[var_05.playersvisibleto.size] = param_00;
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
			var_02 setplanesplineid(param_00,var_03.colorindex,var_03.depthenable);
		}
	}
}

//Function Number: 10
func_5A42(param_00)
{
	if(!isdefined(param_00) || !isdefined(param_00.outlines) || param_00.outlines.size == 0)
	{
	}

	foreach(var_03, var_02 in param_00.outlines)
	{
		func_5A41(var_03,param_00);
	}
}

//Function Number: 11
func_5A3D(param_00)
{
	if(!common_scripts\utility::array_contains(level.outlineents,param_00))
	{
		level.outlineents[level.outlineents.size] = param_00;
	}
}

//Function Number: 12
func_5A50(param_00)
{
	level.outlineents = common_scripts\utility::array_remove(level.outlineents,param_00);
}

//Function Number: 13
outlinegethighestpriorityid(param_00)
{
	var_01 = -1;
	if(!isdefined(param_00.outlines) || param_00.size == 0)
	{
		return var_01;
	}

	var_02 = undefined;
	foreach(var_05, var_04 in param_00.outlines)
	{
		if(!isdefined(var_02) || var_04.priority > var_02.priority)
		{
			var_02 = var_04;
			var_01 = var_05;
		}
	}

	return var_01;
}

//Function Number: 14
outlinegethighestinfoforplayer(param_00,param_01)
{
	var_02 = undefined;
	if(isdefined(param_00.outlines) && param_00.outlines.size)
	{
		foreach(var_04 in param_00.outlines)
		{
			if(common_scripts\utility::array_contains(var_04.playersvisibleto,param_01) && !isdefined(var_02) || var_04.priority > var_02.priority)
			{
				var_02 = var_04;
			}
		}
	}

	return var_02;
}

//Function Number: 15
func_5A48()
{
	level.outlineids++;
	return level.outlineids;
}

//Function Number: 16
func_5A4F(param_00)
{
	param_00 = tolower(param_00);
	var_01 = undefined;
	switch(param_00)
	{
		case "level_script":
			var_01 = 0;
			break;

		case "equipment":
			var_01 = 1;
			break;

		case "perk":
			var_01 = 2;
			break;

		case "killstreak":
			var_01 = 3;
			break;

		case "killstreak_personal":
			var_01 = 4;
			break;

		default:
			var_01 = 0;
			break;
	}

	return var_01;
}

//Function Number: 17
func_5A3F(param_00)
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

		default:
			var_01 = 0;
			break;
	}

	return var_01;
}