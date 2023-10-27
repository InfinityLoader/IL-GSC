/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_gamescore.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 357 ms
 * Timestamp: 10/27/2023 3:23:12 AM
*******************************************************************/

//Function Number: 1
func_450A()
{
	func_A14D();
	if(!level.var_7006["all"].size)
	{
		return undefined;
	}

	return level.var_7006["all"][0];
}

//Function Number: 2
func_450B(param_00)
{
	var_01 = [];
	if(param_00 < 0)
	{
		return var_01;
	}

	func_A14D();
	for(var_02 = 0;var_02 < param_00;var_02++)
	{
		if(level.var_7006["all"].size == var_02)
		{
			break;
		}

		var_01[var_02] = level.var_7006["all"][var_02];
	}

	return var_01;
}

//Function Number: 3
gettiedplayerarray(param_00)
{
	var_01 = level.var_7006["all"][param_00];
	var_02 = [];
	if(!isdefined(var_01))
	{
		return var_02;
	}

	foreach(var_04 in level.var_7006["all"])
	{
		if(var_04 != var_01)
		{
			if(var_04.var_15C == var_01.var_15C && var_04.var_70 == var_01.var_70)
			{
				var_02[var_02.size] = var_04;
			}
		}
	}

	return var_02;
}

//Function Number: 4
func_4568()
{
	func_A14D();
	var_00 = level.var_7006["all"];
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(var_03 == level.var_7006["all"][0])
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 5
func_A161(param_00,param_01)
{
	if(level.var_984D)
	{
		return;
	}

	param_00 maps\mp\gametypes\_persistence::func_933A("round","score",param_00.var_8F);
	param_00 maps\mp\gametypes\_persistence::func_9314("score",param_01);
	if(param_01 > 0)
	{
		param_00 maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_veteran",param_01);
	}
}

//Function Number: 6
func_47A7(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_01.var_117))
	{
		param_01 = param_01.var_117;
	}

	if(!isplayer(param_01))
	{
		return;
	}

	if(issubstr(param_00,"assist") && isdefined(param_03))
	{
		if(param_03 == "agent_raid_fighters_mp")
		{
			param_00 = "raid_fighters_assist";
		}

		if(param_03 == "killstreak_flak_gun_raids")
		{
			if(maps\mp\_utility::isdogfightgametype())
			{
				param_00 = "dogfight_flak_assist";
			}
			else
			{
				param_00 = "raid_flak_assist";
			}
		}
	}

	if(!maps\mp\_utility::func_579B() || getdvarint("raid_allow_scorestreaks",0))
	{
		param_01 maps\mp\killstreaks\_killstreaks::func_4770(param_00);
	}

	if(!maps\mp\_utility::func_579B() && param_01 maps\mp\_utility::func_649("specialty_perkstreaks"))
	{
		param_01 maps\mp\perks\_perkfunctions::processspecialistevent(param_00);
	}

	var_05 = param_01.var_12C["score"];
	func_6B7F(param_00,param_01,param_02,param_03,param_04);
	var_06 = param_01.var_12C["score"] - var_05;
	if(var_06 == 0)
	{
		return;
	}

	if(param_01.var_12C["score"] < -1)
	{
		param_01.var_15C = param_01.var_12C["score"];
	}

	if(level.var_984D)
	{
		param_01 maps\mp\gametypes\_persistence::func_933A("round","score",param_01.var_15C);
		param_01 maps\mp\gametypes\_persistence::func_9314("score",var_06);
		if(var_06 > 0)
		{
			param_01 maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_veteran",var_06);
		}
	}

	if(!level.var_984D)
	{
		level thread func_83E2();
		param_01 maps\mp\gametypes\_gamelogic::func_21D2();
		param_01 maps\mp\gametypes\_gamelogic::func_21E3();
	}
}

//Function Number: 7
func_6B7F(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = undefined;
	if(isdefined(level.var_6B7F))
	{
		var_05 = [[ level.var_6B7F ]](param_00,param_01,param_02,param_03,param_04);
	}

	if(!isdefined(var_05))
	{
		if(param_01 maps\mp\_utility::func_649("specialty_killstreaks") && param_00 == "airdrop_kill" || param_00 == "fritzx_kill" || param_00 == "mortar_strike_kill" || param_00 == "missile_strike_kill" || param_00 == "airstrike_kill" || param_00 == "firebomb_kill" || param_00 == "fighter_strike_kill" || param_00 == "plane_gunner_kill" || param_00 == "flamethrower_kill" || param_00 == "attack_dogs_kill" || param_00 == "paratroopers_kill" || param_00 == "molotovs_kill" || param_00 == "v2_rocket_kill")
		{
			var_05 = maps\mp\gametypes\_rank::func_4671("kill");
		}
		else
		{
			var_05 = maps\mp\gametypes\_rank::func_4671(param_00);
		}
	}

	param_01.var_12C["score"] = param_01.var_12C["score"] + var_05 * level.var_696A;
}

//Function Number: 8
func_06D8(param_00,param_01)
{
	if(param_01 == param_00.var_12C["score"])
	{
		return;
	}

	param_00.var_12C["score"] = param_01;
	param_00.var_15C = param_00.var_12C["score"];
	if(!level.var_984D)
	{
		param_00 thread maps\mp\gametypes\_gamelogic::func_21E3();
	}
}

//Function Number: 9
func_0638(param_00)
{
	return param_00.var_12C["score"];
}

//Function Number: 10
func_47BD(param_00,param_01,param_02)
{
	param_01 = param_01 * level.var_696A;
	func_06DB(param_00,func_063E(param_00) + param_01,param_02);
	level notify("update_team_score",param_00,func_063E(param_00));
	function_00F5("script_mp_scoring: gameTime %d, team %s, score %d",gettime(),param_00,param_01);
	thread func_47BE();
}

//Function Number: 11
func_47BE()
{
	level endon("update_team_score");
	level endon("game_ended");
	waittillframeend;
	var_00 = func_473F();
	if(!level.var_910F && var_00 != "none" && var_00 != level.var_A87B && gettime() - level.var_5C00 > 5000 && maps\mp\_utility::func_4672() != 1 && level.var_3FDC != "demo")
	{
		level.var_5C00 = gettime();
		maps\mp\_utility::func_5C39("lead_taken",var_00,"status");
		if(level.var_A87B != "none")
		{
			maps\mp\_utility::func_5C39("lead_lost",level.var_A87B,"status");
		}
	}

	if(var_00 != "none")
	{
		level.var_A87B = var_00;
		var_01 = func_063E(var_00);
		var_02 = maps\mp\_utility::func_471A("scorelimit");
		if(maps\mp\_utility::func_579B())
		{
			return;
		}

		if(var_01 == 0 || var_02 == 0)
		{
			return;
		}

		var_03 = var_01 / var_02 * 100;
		if(var_03 > level.var_80AC)
		{
			setnojipscore(1);
		}
	}
}

//Function Number: 12
func_473F()
{
	if(maps\mp\_utility::func_761E())
	{
		return "none";
	}

	var_00 = level.var_985B;
	var_01 = var_00[0];
	var_02 = game["teamScores"][var_00[0]];
	var_03 = 1;
	for(var_04 = 1;var_04 < var_00.size;var_04++)
	{
		if(game["teamScores"][var_00[var_04]] > var_02)
		{
			var_01 = var_00[var_04];
			var_02 = game["teamScores"][var_00[var_04]];
			var_03 = 1;
			continue;
		}

		if(game["teamScores"][var_00[var_04]] == var_02)
		{
			var_03 = var_03 + 1;
			var_01 = "none";
		}
	}

	return var_01;
}

//Function Number: 13
func_06DB(param_00,param_01,param_02)
{
	if(param_01 == game["teamScores"][param_00])
	{
		return;
	}

	game["teamScores"][param_00] = param_01;
	func_A174(param_00);
	if((maps\mp\_utility::func_5380() && !isdefined(level.var_6CD1)) || isdefined(level.var_6CD1) && !level.var_6CD1)
	{
		thread maps\mp\gametypes\_gamelogic::func_6B9B();
		return;
	}

	thread maps\mp\gametypes\_gamelogic::func_21EA(param_00);
	if(param_02)
	{
		thread maps\mp\gametypes\_gamelogic::func_21E3();
	}
}

//Function Number: 14
func_A174(param_00)
{
	var_01 = 0;
	if(!maps\mp\_utility::func_57B2() || !maps\mp\_utility::func_5760())
	{
		var_01 = func_063E(param_00);
	}
	else
	{
		var_01 = game["roundsWon"][param_00];
	}

	setteamscore(param_00,var_01);
}

//Function Number: 15
func_063E(param_00)
{
	return game["teamScores"][param_00];
}

//Function Number: 16
func_83E3()
{
	level notify("updating_scores");
	level endon("updating_scores");
	wait 0.05;
	maps\mp\_utility::func_A790();
	foreach(var_01 in level.var_744A)
	{
		var_01 method_82A3();
	}
}

//Function Number: 17
func_83E2()
{
	level notify("updating_dm_scores");
	level endon("updating_dm_scores");
	wait 0.05;
	maps\mp\_utility::func_A790();
	for(var_00 = 0;var_00 < level.var_744A.size;var_00++)
	{
		level.var_744A[var_00] method_82A4();
		level.var_744A[var_00].var_A105 = 1;
	}
}

//Function Number: 18
func_7CD8()
{
	var_00 = 0;
	var_01 = level.var_7006["all"].size;
	var_02 = 0;
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		if(level.var_7006["all"][var_03] == self)
		{
			var_02 = 1;
		}

		if(var_02)
		{
			level.var_7006["all"][var_03] = level.var_7006["all"][var_03 + 1];
		}
	}

	if(!var_02)
	{
		return;
	}

	level.var_7006["all"][var_01 - 1] = undefined;
	if(level.var_6520)
	{
		func_650D();
	}

	if(level.var_984D)
	{
		func_A173();
		return;
	}

	var_01 = level.var_7006["all"].size;
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		var_04 = level.var_7006["all"][var_03];
		var_04 notify("update_outcome");
	}
}

//Function Number: 19
func_A14D()
{
	var_00 = [];
	foreach(var_02 in level.var_744A)
	{
		if(isdefined(var_02.var_2583))
		{
			continue;
		}

		if(var_02.var_12C["team"] == "spectator" || var_02.var_12C["team"] == "none")
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	for(var_04 = 1;var_04 < var_00.size;var_04++)
	{
		var_02 = var_00[var_04];
		var_05 = var_02.var_15C;
		if(!level.var_984D)
		{
			var_05 = var_02.var_8F;
		}

		for(var_06 = var_04 - 1;var_06 >= 0 && func_4438(var_02,var_00[var_06]) == var_02;var_06--)
		{
			var_00[var_06 + 1] = var_00[var_06];
		}

		var_00[var_06 + 1] = var_02;
	}

	level.var_7006["all"] = var_00;
	if(level.var_6520)
	{
		func_650D();
		return;
	}

	if(level.var_984D)
	{
		func_A173();
	}
}

//Function Number: 20
func_4438(param_00,param_01)
{
	if(param_00.var_15C > param_01.var_15C)
	{
		return param_00;
	}

	if(param_01.var_15C > param_00.var_15C)
	{
		return param_01;
	}

	if(param_00.var_70 < param_01.var_70)
	{
		return param_00;
	}

	if(param_01.var_70 < param_00.var_70)
	{
		return param_01;
	}

	if(common_scripts\utility::func_24A6())
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 21
func_A173()
{
	var_00["allies"] = [];
	var_00["axis"] = [];
	var_00["spectator"] = [];
	var_01 = level.var_7006["all"];
	var_02 = var_01.size;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = var_01[var_03];
		var_05 = var_04.var_12C["team"];
		var_00[var_05][var_00[var_05].size] = var_04;
	}

	level.var_7006["allies"] = var_00["allies"];
	level.var_7006["axis"] = var_00["axis"];
}

//Function Number: 22
func_650D()
{
	var_00["spectator"] = [];
	foreach(var_02 in level.var_985B)
	{
		var_00[var_02] = [];
	}

	var_04 = level.var_7006["all"];
	var_05 = var_04.size;
	for(var_06 = 0;var_06 < var_05;var_06++)
	{
		var_07 = var_04[var_06];
		var_08 = var_07.var_12C["team"];
		var_00[var_08][var_00[var_08].size] = var_07;
	}

	foreach(var_02 in level.var_985B)
	{
		level.var_7006[var_02] = var_00[var_02];
	}
}

//Function Number: 23
func_52DA()
{
	wait(0.2);
	var_00 = 0;
	for(;;)
	{
		var_01 = 0;
		var_02 = level.var_744A;
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			var_04 = var_02[var_03];
			if(!isdefined(var_04))
			{
				continue;
			}

			if(isdefined(var_04.var_A105))
			{
				continue;
			}

			var_04.var_A105 = 1;
			var_04 method_82A4();
			var_01 = 1;
			wait(0.5);
		}

		if(!var_01)
		{
			wait(3);
		}
	}
}