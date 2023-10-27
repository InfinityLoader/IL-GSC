/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_gamelogic.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 115
 * Decompile Time: 4528 ms
 * Timestamp: 10/27/2023 12:20:22 AM
*******************************************************************/

//Function Number: 1
func_C530(param_00)
{
	if(isdefined(level.var_72F2))
	{
		return;
	}

	level endon("abort_forfeit");
	level thread func_72F3();
	level.var_72F2 = 1;
	if(!level.teambased && level.players.size > 1)
	{
		wait(10);
	}
	else
	{
		wait(1.05);
	}

	level.var_72F1 = 0;
	var_01 = 20;
	func_B3EA(var_01);
	var_02 = &"";
	if(!isdefined(param_00))
	{
		var_02 = game["end_reason"]["players_forfeited"];
		var_03 = level.players[0];
	}
	else if(var_01 == "axis")
	{
		var_03 = game["end_reason"]["allies_forfeited"];
		var_03 = "axis";
	}
	else if(var_01 == "allies")
	{
		var_03 = game["end_reason"]["axis_forfeited"];
		var_03 = "allies";
	}
	else if(level.multiteambased && issubstr(var_01,"team_"))
	{
		var_03 = var_01;
	}
	else
	{
		var_03 = "tie";
	}

	level.var_72B3 = 1;
	if(isplayer(var_03))
	{
		function_0132("forfeit, win: " + var_03 getxuid() + "(" + var_03.name + ")");
	}
	else
	{
		function_0132("forfeit, win: " + var_03 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	}

	thread endgame(var_03,var_02);
}

//Function Number: 2
func_72F3()
{
	level endon("game_ended");
	level waittill("abort_forfeit");
	level.var_72F1 = 1;
	setomnvar("ui_match_start_countdown",0);
}

//Function Number: 3
func_B3EB(param_00)
{
	waittillframeend;
	level endon("match_forfeit_timer_beginning");
	while(param_00 > 0 && !level.var_7669 && !level.var_72F1 && !level.ingraceperiod)
	{
		setomnvar("ui_match_start_countdown",param_00);
		param_00--;
		scripts\mp\_hostmigration::func_13708(1);
	}

	setomnvar("ui_match_start_countdown",0);
}

//Function Number: 4
func_B3EA(param_00)
{
	level notify("match_forfeit_timer_beginning");
	var_01 = int(param_00);
	setomnvar("ui_match_start_text","opponent_forfeiting_in");
	func_B3EB(var_01);
}

//Function Number: 5
func_5007(param_00)
{
	if(param_00 == "allies")
	{
		iprintln(&"MP_FACTION_UNSA_ELIMINATED");
		function_0132("team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
		thread endgame("axis",game["end_reason"]["allies_eliminated"]);
		return;
	}

	if(param_00 == "axis")
	{
		iprintln(&"MP_FACTION_SDF_ELIMINATED");
		function_0132("team eliminated, win: allies, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
		thread endgame("allies",game["end_reason"]["axis_eliminated"]);
		return;
	}

	function_0132("tie, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	if(level.teambased)
	{
		thread endgame("tie",game["end_reason"]["tie"]);
		return;
	}

	thread endgame(undefined,game["end_reason"]["tie"]);
}

//Function Number: 6
func_5009(param_00)
{
	if(level.teambased)
	{
		var_01 = scripts\mp\_utility::func_7F5E(param_00);
		if(isdefined(var_01))
		{
			var_01 thread func_8378();
		}
	}
	else
	{
		var_01 = scripts\mp\_utility::func_7F5E();
		function_0132("last one alive, win: " + var_01.name);
		thread endgame(var_01,game["end_reason"]["enemies_eliminated"]);
	}

	return 1;
}

//Function Number: 7
func_E75E(param_00,param_01)
{
	func_3E53(param_00);
	if(scripts\mp\_utility::func_9FB3(param_01))
	{
		level notify("roundEnd_CheckScoreLimit");
		level endon("roundEnd_CheckScoreLimit");
		scripts\common\utility::func_136F7();
	}

	var_02 = scripts\mp\_utility::func_8240();
	if(scripts\mp\_utility::func_9900())
	{
		if(scripts\mp\_utility::func_9FAA())
		{
			if(scripts\mp\_utility::func_F88C(param_00))
			{
				foreach(var_04 in level.players)
				{
					var_04 setclientomnvar("ui_friendly_time_to_beat",scripts\common\utility::func_116D7(var_04.team == game["timeToBeatTeam"],game["timeToBeat"],game["timeToBeatOld"]));
					var_04 setclientomnvar("ui_enemy_time_to_beat",scripts\common\utility::func_116D7(var_04.team != game["timeToBeatTeam"],game["timeToBeat"],game["timeToBeatOld"]));
				}

				thread endgame(param_00,game["end_reason"]["score_limit_reached"]);
				return;
			}

			return;
		}

		thread endgame(var_03,game["end_reason"]["score_limit_reached"]);
		return;
	}

	var_06 = game["teamScores"]["allies"];
	var_07 = game["teamScores"]["axis"];
	var_08 = var_06 >= level.var_E763;
	var_09 = var_07 >= level.var_E763;
	if(level.var_E763 > 0)
	{
		if(var_08 && var_09)
		{
			if(var_06 == var_07)
			{
				thread endgame("tie",game["end_reason"]["score_limit_reached"]);
				return;
			}

			if(var_06 > var_07)
			{
				thread endgame("allies",game["end_reason"]["score_limit_reached"]);
				return;
			}

			thread endgame("axis",game["end_reason"]["score_limit_reached"]);
			return;
		}

		if(var_08)
		{
			thread endgame("allies",game["end_reason"]["score_limit_reached"]);
			return;
		}

		if(var_09)
		{
			thread endgame("axis",game["end_reason"]["score_limit_reached"]);
			return;
		}

		return;
	}
}

//Function Number: 8
func_500A()
{
	var_00 = "tie";
	if(level.teambased)
	{
		if(scripts\mp\_utility::func_9900())
		{
			if(scripts\mp\_utility::func_9FAB())
			{
				var_00 = game["timeToBeatTeam"];
			}
		}
		else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
		{
			var_00 = "axis";
		}
		else if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
		{
			var_00 = "allies";
		}

		function_0132("time limit, win: " + var_00 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	}
	else
	{
		var_00 = scripts\mp\_gamescore::func_7F00();
		if(scripts\mp\_gamescore::ishighestscoringplayertied())
		{
			var_00 = "tie";
		}

		if(isdefined(var_00) && isplayer(var_00))
		{
			function_0132("time limit, win: " + var_00.name);
		}
		else
		{
			function_0132("time limit, tie");
		}
	}

	thread endgame(var_00,game["end_reason"]["time_limit_reached"]);
}

//Function Number: 9
func_5008()
{
	var_00 = undefined;
	thread endgame("halftime",game["end_reason"]["time_limit_reached"]);
}

//Function Number: 10
func_72BE(param_00)
{
	if(level.var_90A1 || level.var_72B3)
	{
		return;
	}

	scripts\mp\_gamescore::func_12EEC();
	if(level.teambased)
	{
		scripts\mp\_gamescore::func_12F4A("axis");
		scripts\mp\_gamescore::func_12F4A("allies");
	}

	var_01 = undefined;
	if(level.teambased)
	{
		if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
		{
			var_01 = "tie";
		}
		else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
		{
			var_01 = "axis";
		}
		else
		{
			var_01 = "allies";
		}

		function_0132("host ended game, win: " + var_01 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	}
	else
	{
		var_01 = scripts\mp\_gamescore::func_7F00();
		if(isdefined(var_01))
		{
			function_0132("host ended game, win: " + var_01.name);
		}
		else
		{
			function_0132("host ended game, tie");
		}
	}

	level.var_72B3 = 1;
	level.var_90A1 = 1;
	if(level.splitscreen)
	{
		var_02 = game["end_reason"]["ended_game"];
	}
	else
	{
		var_02 = game["end_reason"]["host_ended_game"];
	}

	if(isdefined(param_00) && param_00 == 2)
	{
		var_02 = game["end_reason"]["allies_forfeited"];
	}

	level notify("force_end");
	thread endgame(var_01,var_02);
}

//Function Number: 11
func_C587(param_00)
{
	var_01 = game["end_reason"]["score_limit_reached"];
	var_02 = "tie";
	if(level.multiteambased)
	{
		var_02 = scripts\mp\_gamescore::func_8242();
		if(var_02 == "none")
		{
			var_02 = "tie";
		}
	}
	else if(level.teambased)
	{
		if(game["teamScores"]["axis"] != game["teamScores"]["allies"])
		{
			if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
			{
				var_02 = "axis";
			}
			else
			{
				var_02 = "allies";
			}
		}

		function_0132("scorelimit, win: " + var_02 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	}
	else
	{
		var_02 = scripts\mp\_gamescore::func_7F00();
		if(scripts\mp\_utility::func_9FB3(param_00) && scripts\mp\_gamescore::ishighestscoringplayertied())
		{
			var_02 = "tie";
		}

		if(isdefined(var_02) && isplayer(var_02))
		{
			function_0132("scorelimit, win: " + var_02.name);
		}
		else
		{
			function_0132("scorelimit, tie");
		}
	}

	thread endgame(var_02,var_01);
	return 1;
}

//Function Number: 12
func_12E9D()
{
	if(scripts\mp\_utility::func_B3EC() && !level.ingraceperiod && !isdefined(level.var_55EE) || !level.var_55EE)
	{
		if(level.multiteambased)
		{
			var_00 = 0;
			var_01 = 0;
			for(var_02 = 0;var_02 < level.teamnamelist.size;var_02++)
			{
				var_00 = var_00 + level.var_115C6[level.teamnamelist[var_02]];
				if(level.var_115C6[level.teamnamelist[var_02]])
				{
					var_01 = var_01 + 1;
				}
			}

			for(var_02 = 0;var_02 < level.teamnamelist.size;var_02++)
			{
				if(var_00 == level.var_115C6[level.teamnamelist[var_02]] && game["state"] == "playing")
				{
					thread func_C530(level.teamnamelist[var_02]);
					return;
				}
			}

			if(var_01 > 1)
			{
				level.var_72F2 = undefined;
				level notify("abort_forfeit");
			}
		}
		else if(level.teambased)
		{
			if(level.var_115C6["allies"] < 1 && level.var_115C6["axis"] > 0 && game["state"] == "playing")
			{
				thread func_C530("axis");
				return;
			}

			if(level.var_115C6["axis"] < 1 && level.var_115C6["allies"] > 0 && game["state"] == "playing")
			{
				thread func_C530("allies");
				return;
			}

			if(level.var_115C6["axis"] > 0 && level.var_115C6["allies"] > 0)
			{
				level.var_72F2 = undefined;
				level notify("abort_forfeit");
			}
		}
		else
		{
			if(level.var_115C6["allies"] + level.var_115C6["axis"] == 1 && level.var_B4BC > 1)
			{
				thread func_C530();
				return;
			}

			if(level.var_115C6["axis"] + level.var_115C6["allies"] > 1)
			{
				level.var_72F2 = undefined;
				level notify("abort_forfeit");
			}
		}
	}

	if(!scripts\mp\_utility::func_7ECE() && !isdefined(level.var_5611) || !level.var_5611)
	{
		return;
	}

	if(!scripts\mp\_utility::func_7672())
	{
		return;
	}

	if(level.ingraceperiod)
	{
		return;
	}

	if(level.multiteambased)
	{
		return;
	}

	if(level.teambased)
	{
		var_03["allies"] = 0;
		var_03["axis"] = 0;
		foreach(var_05 in level.players)
		{
			if(var_05.team == "spectator" || !isdefined(var_05.var_8C2A) || isdefined(var_05.var_8C2A) && !var_05.var_8C2A)
			{
				continue;
			}

			var_03[var_05.team] = var_03[var_05.team] + var_05.pers["lives"];
		}

		if(scripts\mp\_utility::func_9FB3(level.var_5611))
		{
			var_03["allies"] = 0;
			var_03["axis"] = 0;
		}

		if(!level.var_1BE6["allies"] && !level.var_1BE6["axis"] && !var_03["allies"] && !var_03["axis"])
		{
			return [[ level.var_C4E8 ]]("all");
		}

		if(!level.var_1BE6["allies"] && !var_03["allies"])
		{
			return [[ level.var_C4E8 ]]("allies");
		}

		if(!level.var_1BE6["axis"] && !var_03["axis"])
		{
			return [[ level.var_C4E8 ]]("axis");
		}

		var_07 = level.var_1BE6["allies"] == 1;
		var_08 = level.var_1BE6["axis"] == 1;
		if(var_07 || var_08)
		{
			var_09 = 0;
			var_0A = undefined;
			if(var_07)
			{
				foreach(var_05 in level.players)
				{
					if(var_05.team == "allies")
					{
						if(!isalive(var_05))
						{
							var_09 = var_09 + var_05.pers["lives"];
						}
					}
				}

				if(var_09 == 0)
				{
					if(!isdefined(level.var_C50B["allies"]) || gettime() > level.var_C50B["allies"] + 5000)
					{
						level.var_C50B["allies"] = gettime();
						var_0D = [[ level.var_C564 ]]("allies");
						if(isdefined(var_0D))
						{
							if(!isdefined(var_0A))
							{
								var_0A = var_0D;
							}

							var_0A = var_0A || var_0D;
						}
					}
				}
			}

			if(var_08)
			{
				foreach(var_05 in level.players)
				{
					if(var_05.team == "axis")
					{
						if(!isalive(var_05))
						{
							var_09 = var_09 + var_05.pers["lives"];
						}
					}
				}

				if(var_09 == 0)
				{
					if(!isdefined(level.var_C50B["axis"]) || gettime() > level.var_C50B["axis"] + 5000)
					{
						level.var_C50B["axis"] = gettime();
						var_10 = [[ level.var_C564 ]]("axis");
						if(isdefined(var_10))
						{
							if(!isdefined(var_0A))
							{
								var_0A = var_10;
							}

							var_0A = var_0A || var_10;
						}
					}
				}
			}

			return var_0A;
		}

		return;
	}

	var_03 = 0;
	foreach(var_06 in level.players)
	{
		if(var_06.team == "spectator")
		{
			continue;
		}

		var_04 = var_04 + var_06.pers["lives"];
	}

	if(!level.var_1BE6["allies"] && !level.var_1BE6["axis"] && !var_04)
	{
		return [[ level.var_C4E8 ]]("all");
	}

	var_13 = scripts\mp\_utility::func_808A();
	if(var_13.size == 1)
	{
		return [[ level.var_C564 ]]("all");
	}
}

//Function Number: 13
func_13830()
{
	if(!isdefined(level.var_6C6F))
	{
		return 0;
	}

	level waittill("final_killcam_done");
	return 1;
}

//Function Number: 14
func_118F8(param_00)
{
	function_01AF(gettime() + int(param_00 * 1000));
	var_01 = spawn("script_origin",(0,0,0));
	var_01 hide();
	if(param_00 >= 10)
	{
		wait(param_00 - 10);
	}

	for(;;)
	{
		var_01 playsound("ui_mp_timer_countdown");
		wait(1);
	}
}

//Function Number: 15
func_136D7(param_00)
{
	var_01 = gettime();
	var_02 = var_01 + param_00 * 1000 - 200;
	if(param_00 > 5)
	{
		var_03 = gettime() + getdvarint("min_wait_for_players") * 1000;
	}
	else
	{
		var_03 = 0;
	}

	var_04 = level.var_4533 / 3;
	for(;;)
	{
		if(isdefined(game["roundsPlayed"]) && game["roundsPlayed"])
		{
			break;
		}

		var_05 = level.var_B4BC;
		var_06 = gettime();
		if((var_05 >= var_04 && var_06 > var_03) || var_06 > var_02)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 16
func_D84D()
{
	level endon("game_ended");
	level.var_4533 = getdvarint("party_partyPlayerCountNum");
	if(level.var_D84D > 0)
	{
		func_B415();
	}
	else
	{
		func_B414();
	}

	scripts\mp\_hostmigration::func_13834();
	foreach(var_01 in level.players)
	{
		scripts\mp\_playerlogic::func_41D1(var_01);
		var_01 scripts\mp\_utility::func_7385(0,1);
		if(!isdefined(var_01.pers["team"]))
		{
			continue;
		}

		var_02 = var_01.pers["team"];
		var_03 = scripts\mp\_utility::func_801A(var_02);
		if(!isdefined(var_03) || !var_01.var_8C2A)
		{
			continue;
		}

		var_04 = 0;
		if(game["defenders"] == var_02)
		{
			var_04 = 1;
		}

		var_01 setclientomnvar("ui_objective_text",var_04);
	}

	if(game["state"] != "playing")
	{
	}
}

//Function Number: 17
func_8487()
{
	level endon("game_ended");
	if(!isdefined(game["clientActive"]))
	{
		while(function_0071() == 0)
		{
			wait(0.05);
		}

		game["clientActive"] = 1;
	}

	while(level.ingraceperiod > 0)
	{
		wait(1);
		level.ingraceperiod--;
	}

	level notify("grace_period_ending");
	wait(0.05);
	scripts\mp\_utility::func_766F("graceperiod_done");
	level.ingraceperiod = 0;
	if(game["state"] != "playing")
	{
		return;
	}

	if(scripts\mp\_utility::func_7ECE())
	{
		var_00 = level.players;
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			var_02 = var_00[var_01];
			if(!var_02.var_8C2A && var_02.sessionteam != "spectator" && !isalive(var_02))
			{
				var_02.var_2C7 = "hud_status_dead";
			}
		}
	}

	level thread func_12E9D();
}

//Function Number: 18
func_F73B(param_00,param_01)
{
	param_00.var_8BE9 = param_01;
	var_02 = !scripts\mp\_utility::func_9FB3(param_00.pers["hasDoneAnyCombat"]);
	if(var_02 && param_01)
	{
		param_00.pers["hasDoneAnyCombat"] = 1;
		if(isdefined(param_00.pers["hasMatchLoss"]) && param_00.pers["hasMatchLoss"])
		{
			return;
		}

		func_12EC3(param_00);
	}
}

//Function Number: 19
func_12F66(param_00)
{
	if(!param_00 scripts\mp\_utility::func_DCD5())
	{
		return;
	}

	if(!scripts\mp\_utility::func_9FB3(param_00.pers["hasDoneAnyCombat"]))
	{
		return;
	}

	if(scripts\mp\_utility::func_9FB3(param_00.pers["recordedLoss"]))
	{
		param_00 scripts\mp\_persistence::func_10E12("losses",-1);
	}

	param_00 scripts\mp\_persistence::func_10E12("wins",1);
	param_00 scripts\mp\_utility::func_12EE8("winLossRatio","wins","losses");
	param_00 scripts\mp\_persistence::func_10E12("currentWinStreak",1);
	var_01 = param_00 scripts\mp\_persistence::func_10E33("currentWinStreak");
	if(var_01 > param_00 scripts\mp\_persistence::func_10E33("winStreak"))
	{
		param_00 scripts\mp\_persistence::func_10E54("winStreak",var_01);
	}

	param_00 scripts\mp\_persistence::func_10E56("round","win",1);
	param_00 scripts\mp\_persistence::func_10E56("round","loss",0);
}

//Function Number: 20
func_12EC3(param_00)
{
	if(!param_00 scripts\mp\_utility::func_DCD5())
	{
		return;
	}

	if(!scripts\mp\_utility::func_9FB3(param_00.pers["hasDoneAnyCombat"]))
	{
		return;
	}

	param_00.pers["hasMatchLoss"] = 1;
	if(!scripts\mp\_utility::func_9FB3(self.var_A49D))
	{
		param_00 scripts\mp\_persistence::func_10E12("losses",1);
		param_00 scripts\mp\_utility::func_12EE8("winLossRatio","wins","losses");
		param_00.pers["recordedLoss"] = 1;
	}

	param_00 scripts\mp\_persistence::func_10E12("gamesPlayed",1);
	param_00 scripts\mp\_persistence::func_10E56("round","loss",1);
}

//Function Number: 21
func_12F42(param_00)
{
	if(!param_00 scripts\mp\_utility::func_DCD5())
	{
		return;
	}

	if(!scripts\mp\_utility::func_9FB3(param_00.pers["hasDoneAnyCombat"]))
	{
		return;
	}

	if(scripts\mp\_utility::func_9FB3(param_00.pers["recordedLoss"]))
	{
		param_00 scripts\mp\_persistence::func_10E12("losses",-1);
		param_00 scripts\mp\_persistence::func_10E54("currentWinStreak",0);
	}

	param_00 scripts\mp\_persistence::func_10E12("ties",1);
	param_00 scripts\mp\_utility::func_12EE8("winLossRatio","wins","losses");
	param_00 scripts\mp\_persistence::func_10E56("round","loss",0);
}

//Function Number: 22
func_12F65(param_00)
{
	if(scripts\mp\_utility::func_D957())
	{
		return;
	}

	if(!scripts\mp\_utility::func_13916())
	{
		return;
	}

	level.processedwinloss = 1;
	var_01 = level.players;
	foreach(var_03 in level.players)
	{
		if(!isdefined(var_03) || !var_03 scripts\mp\_utility::func_DCD5())
		{
			continue;
		}

		if(isai(var_03))
		{
			continue;
		}

		var_03 giveachievement("MP_ACHIEVEMENT_1");
	}

	func_12EF0();
	if(!isdefined(param_00) || isdefined(param_00) && isstring(param_00) && param_00 == "tie")
	{
		foreach(var_03 in level.players)
		{
			if(isdefined(var_03.var_4530))
			{
				continue;
			}

			if(level.var_90A1 && var_03 ishost())
			{
				var_03 scripts\mp\_persistence::func_10E54("currentWinStreak",0);
				continue;
			}

			func_12F42(var_03);
		}

		return;
	}

	if(isplayer(param_00))
	{
		if(level.var_90A1 && param_00 ishost())
		{
			param_00 scripts\mp\_persistence::func_10E54("currentWinStreak",0);
			return;
		}

		for(var_07 = 0;var_07 < min(level.var_CC1D["all"].size,3);var_07++)
		{
			func_12F66(level.var_CC1D["all"][var_07]);
		}

		return;
	}

	if(isstring(param_00))
	{
		foreach(var_03 in level.players)
		{
			if(isdefined(var_03.var_4530))
			{
				continue;
			}

			if(level.var_90A1 && var_03 ishost())
			{
				var_03 scripts\mp\_persistence::func_10E54("currentWinStreak",0);
				continue;
			}

			if(param_00 == "tie")
			{
				func_12F42(var_03);
				continue;
			}

			if(var_03.pers["team"] == param_00)
			{
				func_12F66(var_03);
				continue;
			}

			if(scripts\mp\_utility::func_9FB3(var_03.pers["recordedLoss"]))
			{
				var_03 scripts\mp\_persistence::func_10E54("currentWinStreak",0);
			}
		}

		return;
	}
}

//Function Number: 23
func_12EF0()
{
	if(level.gametype != "infect")
	{
		return;
	}

	foreach(var_01 in level.players)
	{
		if(var_01.sessionstate == "spectator" && !var_01.var_2B0)
		{
			continue;
		}
		else if(scripts\mp\_utility::func_9FB3(var_01.pers["hasDoneAnyCombat"]))
		{
			continue;
		}
		else if(var_01.team == "axis")
		{
			continue;
		}
		else
		{
			var_01 func_F73B(var_01,1);
		}
	}
}

//Function Number: 24
func_7386(param_00)
{
	self endon("disconnect");
	scripts\mp\_utility::clearlowermessages();
	if(!isdefined(param_00))
	{
		param_00 = 0.05;
	}

	wait(param_00);
	scripts\mp\_utility::func_7385(1);
}

//Function Number: 25
func_12ECA(param_00)
{
	if(!game["timePassed"])
	{
		return;
	}

	if(!scripts\mp\_utility::func_B3EC())
	{
		return;
	}

	if(!scripts\mp\_utility::func_81CA() || level.var_72B3)
	{
		var_01 = scripts\mp\_utility::func_81CB() / 1000;
		var_01 = min(var_01,1200);
	}
	else
	{
		var_01 = scripts\mp\_utility::func_81CA() * 60;
	}

	if(level.teambased)
	{
		if(param_00 == "allies")
		{
			var_02 = "allies";
			var_03 = "axis";
		}
		else if(var_02 == "axis")
		{
			var_02 = "axis";
			var_03 = "allies";
		}
		else
		{
			var_02 = "tie";
			var_03 = "tie";
		}

		if(var_02 != "tie")
		{
			setwinningteam(var_02);
		}

		foreach(var_05 in level.players)
		{
			if(isdefined(var_05.var_4530))
			{
				continue;
			}

			if(!var_05 scripts\mp\_utility::func_DCD5())
			{
				continue;
			}

			if(var_05.var_1190E["total"] < 1 || var_05.pers["participation"] < 1)
			{
				continue;
			}

			if(level.var_90A1 && var_05 ishost())
			{
				continue;
			}

			if(!scripts\mp\_utility::func_9FB3(var_05.pers["hasDoneAnyCombat"]))
			{
				continue;
			}

			if(var_02 == "tie")
			{
				var_06 = var_05 func_3716("tie",var_01);
				var_05 thread func_837D("tie",var_06);
				var_05.var_B3DD = var_06;
				continue;
			}

			if(isdefined(var_05.pers["team"]) && var_05.pers["team"] == var_02)
			{
				var_06 = var_05 func_3716("win",var_01);
				var_05 thread func_837D("win",var_06);
				var_05.var_B3DD = var_06;
				continue;
			}

			if(isdefined(var_05.pers["team"]) && var_05.pers["team"] == var_03)
			{
				var_06 = var_05 func_3716("loss",var_01);
				var_05 thread func_837D("loss",var_06);
				var_05.var_B3DD = var_06;
			}
		}

		return;
	}

	var_08 = "win";
	var_09 = "loss";
	if(!isdefined(param_00))
	{
		var_08 = "tie";
		var_09 = "tie";
	}

	foreach(var_05 in level.players)
	{
		if(isdefined(var_05.var_4530))
		{
			continue;
		}

		if(var_05.var_1190E["total"] < 1 || var_05.pers["participation"] < 1)
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9FB3(var_05.pers["hasDoneAnyCombat"]))
		{
			continue;
		}

		var_0B = 0;
		for(var_0C = 0;var_0C < min(level.var_CC1D["all"].size,3);var_0C++)
		{
			if(level.var_CC1D["all"][var_0C] != var_05)
			{
				continue;
			}

			var_0B = 1;
		}

		if(var_0B)
		{
			var_06 = var_05 func_3716(var_08,var_01);
			var_05 thread func_837D("win",var_06);
			var_05.var_B3DD = var_06;
			continue;
		}

		var_06 = var_05 func_3716(var_09,var_01);
		var_05 thread func_837D("loss",var_06);
		var_05.var_B3DD = var_06;
	}
}

//Function Number: 26
func_3716(param_00,param_01)
{
	var_02 = scripts\mp\_rank::func_8104(param_00);
	var_03 = scripts\mp\_rank::func_7F8F();
	var_04 = param_01 / 60 * var_03;
	var_05 = self.var_1190E["total"] / param_01;
	var_06 = int(var_02 * var_04 * var_05);
	return var_06;
}

//Function Number: 27
func_837D(param_00,param_01)
{
	self endon("disconnect");
	level waittill("give_match_bonus");
	scripts\mp\_rank::func_839A(param_00,param_01);
	if(scripts\mp\_utility::func_13916())
	{
		if(param_00 == "win")
		{
			thread scripts\mp\_awards::func_8380("match_complete_win");
			return;
		}

		thread scripts\mp\_awards::func_8380("match_complete");
	}
}

//Function Number: 28
func_FB23(param_00)
{
	var_01 = level.players;
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		if(!isdefined(var_03.var_278) || !isdefined(var_03.pers["team"]))
		{
			continue;
		}
	}

	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		if(!isdefined(var_03.var_1AB) || !isdefined(var_03.var_E9))
		{
			continue;
		}

		if(120 > var_03.var_1190E["total"])
		{
			continue;
		}

		var_04 = var_03.var_1AB - var_03.var_E9 / var_03.var_1190E["total"] / 60;
		setplayerteamrank(var_03,var_03.var_41F0,var_04);
	}
}

//Function Number: 29
func_3E54(param_00)
{
	if(isdefined(level.var_118FA) && level.var_118FA)
	{
		return;
	}

	if(game["state"] != "playing")
	{
		function_01AF(0);
		return;
	}

	runjiprules();
	if(scripts\mp\_utility::func_81CA() <= 0)
	{
		if(isdefined(level.var_10DFF))
		{
			function_01AF(level.var_10DFF);
		}
		else
		{
			function_01AF(0);
		}

		return;
	}

	if(!scripts\mp\_utility::func_766C("prematch_done"))
	{
		function_01AF(0);
		return;
	}

	if(!isdefined(level.var_10DFF))
	{
		return;
	}

	var_01 = func_81CD();
	function_01AF(gettime() + int(var_01));
	if(var_01 > 0)
	{
		return;
	}

	[[ level.var_C5B2 ]]();
}

//Function Number: 30
runjiprules()
{
	if(!isdefined(level.nojip))
	{
		level.nojip = 0;
	}

	if(!level.nojip)
	{
		if(scripts\mp\_utility::func_9F32() && !level.nojip)
		{
			switch(level.gametype)
			{
				case "front":
				case "dom":
					var_00 = checkdomjiprules();
					break;

				case "sd":
				case "sr":
				case "siege":
					var_00 = checksdjiprules();
					break;

				case "ctf":
					var_00 = checkctfjiprules();
					break;

				case "ball":
					var_00 = checkballjiprules();
					break;

				case "dd":
					var_00 = checkddjiprules();
					break;

				default:
					var_00 = checkdefaultjiprules();
					break;
			}

			if(var_00)
			{
				function_01BD(1);
				level.nojip = 1;
				return;
			}

			return;
		}

		if(scripts\mp\_utility::func_81CC() > level.var_1190B)
		{
			function_01BD(1);
			level.nojip = 1;
			return;
		}
	}
}

//Function Number: 31
checkdomjiprules()
{
	if(!scripts\mp\_utility::func_9DF6())
	{
		if(getteamscoreint("axis") > 150 || getteamscoreint("allies") > 150)
		{
			return 1;
		}

		if(scripts\mp\_utility::func_81CC() > 75)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 32
checksdjiprules()
{
	var_00 = scripts\mp\_utility::func_80F9("axis");
	var_01 = scripts\mp\_utility::func_80F9("allies");
	var_02 = 3;
	if(scripts\mp\_utility::func_9D46())
	{
		var_02 = 5;
	}

	if(var_00 >= var_02 || var_01 >= var_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 33
checkctfjiprules()
{
	if(!scripts\mp\_utility::func_9DF6())
	{
		if(scripts\mp\_utility::func_81CC() > level.var_1190B)
		{
			return 1;
		}
	}

	var_00 = abs(getteamscoreint("axis") - getteamscoreint("allies"));
	if(var_00 > 10)
	{
		return 1;
	}

	return 0;
}

//Function Number: 34
checkballjiprules()
{
	if(!scripts\mp\_utility::func_9DF6())
	{
		if(scripts\mp\_utility::func_81CC() > level.var_1190B)
		{
			return 1;
		}
	}

	var_00 = abs(getteamscoreint("axis") - getteamscoreint("allies"));
	if(var_00 > 15)
	{
		return 1;
	}

	return 0;
}

//Function Number: 35
checkddjiprules()
{
	var_00 = scripts\mp\_utility::func_80F9("axis");
	var_01 = scripts\mp\_utility::func_80F9("allies");
	if(var_00 + var_01 >= 3)
	{
		return 1;
	}

	return 0;
}

//Function Number: 36
checkdefaultjiprules()
{
	if(scripts\mp\_utility::func_BFA7())
	{
		if(scripts\mp\_utility::func_81CC() > level.var_1190B)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 37
getteamscoreint(param_00)
{
	return int(game["teamScores"][param_00]);
}

//Function Number: 38
func_81CD()
{
	return scripts\mp\_utility::func_81CA() * 60 * 1000 - scripts\mp\_utility::func_81CB();
}

//Function Number: 39
func_81CE()
{
	var_00 = scripts\mp\_utility::func_81CA() * 60 * 1000;
	return var_00 - scripts\mp\_utility::func_81CB() / var_00;
}

//Function Number: 40
func_3E53(param_00)
{
	if(level.var_E763 <= 0 || scripts\mp\_utility::func_9EBD())
	{
		return;
	}

	if(isdefined(level.var_EC3C) && level.var_EC3C)
	{
		return;
	}

	if(level.gametype == "conf" || level.gametype == "jugg")
	{
		return;
	}

	if(!level.teambased)
	{
		return;
	}

	level.var_CF33 = 0;
	var_01 = 0;
	if(level.gametype == "dom" || level.gametype == "tdef")
	{
		var_01 = func_42AC(param_00);
	}
	else if(scripts\mp\_utility::func_81CB() > -5536)
	{
		var_01 = func_6747(param_00) < 1;
	}

	if(!level.var_CF33 && var_01)
	{
		level.var_CF33 = 1;
		level notify("match_ending_soon","score");
	}

	if(!level.var_CF33 && scripts\mp\_utility::func_38F3())
	{
		if(getteamscore(param_00) >= int(level.var_EC3B * level.var_4BFF - level.var_EC3B / 2))
		{
			scripts\mp\_utility::func_AAE7("halfway_friendly_boost",param_00,"status");
			scripts\mp\_utility::func_AAE7("halfway_enemy_boost",scripts\mp\_utility::getotherteam(param_00),"status");
			level.var_54BB = 1;
		}
	}
}

//Function Number: 41
func_3E35()
{
	if(level.var_E763 <= 0 || scripts\mp\_utility::func_9EBD())
	{
		return;
	}

	if(level.teambased)
	{
		return;
	}

	if(scripts\mp\_utility::func_81CB() < -5536)
	{
		return;
	}

	if(level.gametype == "gun")
	{
		if(self.var_278 == 14)
		{
			level notify("match_ending_soon","score");
			return;
		}

		return;
	}

	var_00 = func_6747();
	if(var_00 < 2)
	{
		level notify("match_ending_soon","score");
	}
}

//Function Number: 42
func_3E47(param_00)
{
	if(scripts\mp\_utility::cantiebysimultaneouskill())
	{
		param_00 = 1;
	}

	if(scripts\mp\_utility::func_9FB3(param_00))
	{
		level notify("checkScoreLimit");
		level endon("checkScoreLimit");
		scripts\common\utility::func_136F7();
	}

	if(scripts\mp\_utility::func_9EBD())
	{
		return 0;
	}

	if(isdefined(level.var_EC3C) && level.var_EC3C)
	{
		return 0;
	}

	if(game["state"] != "playing")
	{
		return 0;
	}

	if(level.var_E763 <= 0)
	{
		return 0;
	}

	var_01 = 0;
	if(level.teambased)
	{
		for(var_02 = 0;var_02 < level.teamnamelist.size;var_02++)
		{
			if(game["teamScores"][level.teamnamelist[var_02]] >= level.var_E763)
			{
				var_01 = 1;
				break;
			}
		}
	}
	else
	{
		foreach(var_04 in level.players)
		{
			if(var_04.var_278 >= level.var_E763)
			{
				var_01 = 1;
				break;
			}
		}
	}

	if(!var_01)
	{
		return 0;
	}

	return func_C587(param_00);
}

//Function Number: 43
func_12E9F()
{
	level endon("game_ended");
	while(game["state"] == "playing")
	{
		if(isdefined(level.var_10DFF))
		{
			if(func_81CD() < 3000)
			{
				wait(0.1);
				continue;
			}
		}

		wait(1);
	}
}

//Function Number: 44
func_B415()
{
	thread func_B412("match_starting_in",level.var_D84D + level.var_D84E);
	func_136D7(level.var_D84D);
	if(level.var_D84E > 0 && !isdefined(level.var_90A9))
	{
		var_00 = level.var_D84E;
		if((scripts\mp\_utility::func_9F32() && !scripts\mp\_utility::func_9DF6()) || scripts\mp\_utility::func_9EA6())
		{
			var_00 = level.var_D84D;
		}

		level notify("match_start_real_countdown",var_00);
		func_B412("match_starting_in",var_00);
	}
}

//Function Number: 45
func_B413(param_00)
{
	waittillframeend;
	level endon("match_start_timer_beginning");
	while(param_00 > 0 && !level.var_7669)
	{
		setomnvar("ui_match_start_countdown",param_00);
		if(param_00 == 0)
		{
			function_0237("",0);
		}

		param_00--;
		wait(1);
	}

	setomnvar("ui_match_start_countdown",0);
}

//Function Number: 46
func_B412(param_00,param_01)
{
	self notify("matchStartTimer");
	self endon("matchStartTimer");
	level notify("match_start_timer_beginning");
	var_02 = int(param_01);
	if(var_02 >= 2)
	{
		setomnvar("ui_match_start_text",param_00);
		func_B413(var_02);
	}

	function_0237("",0);
}

//Function Number: 47
func_B414()
{
	function_0237("",0);
}

//Function Number: 48
func_C585(param_00)
{
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(param_00)
	{
		level.var_8865 = "overtime";
		if(scripts\mp\_utility::func_9E74())
		{
			var_01 = func_7E07();
			if(var_01 != game["defenders"])
			{
				game["switchedsides"] = !game["switchedsides"];
				level.var_11374 = 1;
				return;
			}

			level.var_11374 = undefined;
			return;
		}

		game["switchedsides"] = !game["switchedsides"];
		level.var_11374 = 1;
		return;
	}

	level.var_8865 = "halftime";
	game["switchedsides"] = !game["switchedsides"];
	level.var_11374 = 1;
}

//Function Number: 49
func_3E43(param_00)
{
	if(!level.teambased)
	{
		return 0;
	}

	if(!isdefined(level.var_E765) || !level.var_E765)
	{
		return 0;
	}

	if(game["roundsPlayed"] % level.var_E765 == 0 || param_00)
	{
		func_C585(param_00);
		return 1;
	}

	return 0;
}

//Function Number: 50
func_11939()
{
	if(level.var_7669)
	{
		var_00 = gettime() - level.var_766B / 1000;
		var_01 = level.var_D706 - var_00;
		if(var_01 < 0)
		{
			return 0;
		}

		return var_01;
	}

	if(scripts\mp\_utility::func_81CA() <= 0)
	{
		return undefined;
	}

	if(!isdefined(level.var_10DFF))
	{
		return undefined;
	}

	var_02 = scripts\mp\_utility::func_81CA();
	var_00 = gettime() - level.var_10DFF / 1000;
	var_01 = level.var_561F / 1000 + scripts\mp\_utility::func_81CA() * 60 - var_02;
	if(isdefined(level.var_11909))
	{
		var_02 = var_02 + level.var_11909;
	}

	return var_02 + level.var_D706;
}

//Function Number: 51
func_736F()
{
	if(isdefined(self.var_CA52))
	{
		if(isdefined(self.var_CA52[0]))
		{
			self.var_CA52[0] scripts\mp\_hud_util::destroyelem();
			self.var_CA53[0] scripts\mp\_hud_util::destroyelem();
		}

		if(isdefined(self.var_CA52[1]))
		{
			self.var_CA52[1] scripts\mp\_hud_util::destroyelem();
			self.var_CA53[1] scripts\mp\_hud_util::destroyelem();
		}

		if(isdefined(self.var_CA52[2]))
		{
			self.var_CA52[2] scripts\mp\_hud_util::destroyelem();
			self.var_CA53[2] scripts\mp\_hud_util::destroyelem();
		}
	}

	self notify("perks_hidden");
	if(!level.var_5828)
	{
		self.lowermessage scripts\mp\_hud_util::destroyelem();
		self.lowertimer scripts\mp\_hud_util::destroyelem();
	}

	if(isdefined(self.var_DAAE))
	{
		self.var_DAAE scripts\mp\_hud_util::destroyelem();
	}

	if(isdefined(self.var_DAAF))
	{
		self.var_DAAF scripts\mp\_hud_util::destroyelem();
	}
}

//Function Number: 52
func_7F07()
{
	var_00 = getentarray("player","classname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(var_00[var_01] ishost())
		{
			return var_00[var_01];
		}
	}
}

//Function Number: 53
func_90A2()
{
	var_00 = func_7F07();
	if(isdefined(var_00) && !var_00.var_8C2A && !isdefined(var_00.var_F1BA))
	{
		return 1;
	}

	return 0;
}

//Function Number: 54
func_E761(param_00,param_01)
{
	var_02 = 0;
	while(!var_02)
	{
		var_03 = level.players;
		var_02 = 1;
		foreach(var_05 in var_03)
		{
			if(!var_05 scripts\mp\_hud_message::func_9DC6())
			{
				continue;
			}

			var_02 = 0;
		}

		wait(0.5);
	}

	if(!level.var_5828)
	{
		setomnvarforallclients("post_game_state",2);
	}

	foreach(var_05 in level.players)
	{
		var_05 thread scripts\mp\_utility::func_F8A0(0);
	}

	if(!param_01)
	{
		wait(param_00);
	}
	else
	{
		wait(param_00 / 2);
		level notify("give_match_bonus");
		wait(param_00 / 2);
		var_02 = 0;
		while(!var_02)
		{
			var_03 = level.players;
			var_02 = 1;
			foreach(var_05 in var_03)
			{
				if(!var_05 scripts\mp\_hud_message::func_9DC6())
				{
					continue;
				}

				var_02 = 0;
			}

			wait(0.5);
		}
	}

	setomnvarforallclients("post_game_state",1);
	level notify("round_end_finished");
}

//Function Number: 55
func_E760(param_00)
{
	self setdepthoffield(0,128,512,4000,6,1.8);
}

//Function Number: 56
initwaypointbackgrounds()
{
	level.waypointcolors["koth_enemy"] = "enemy";
	level.waypointbgtype["koth_enemy"] = 2;
	level.waypointcolors["koth_friendly"] = "friendly";
	level.waypointbgtype["koth_friendly"] = 2;
	level.waypointcolors["koth_neutral"] = "neutral";
	level.waypointbgtype["koth_neutral"] = 2;
	level.waypointcolors["waypoint_hardpoint_contested"] = "contest";
	level.waypointbgtype["waypoint_hardpoint_contested"] = 2;
	level.waypointcolors["waypoint_hardpoint_losing"] = "contest";
	level.waypointbgtype["waypoint_hardpoint_losing"] = 2;
	level.waypointcolors["waypoint_hardpoint_target"] = "neutral";
	level.waypointbgtype["waypoint_hardpoint_target"] = 2;
	level.waypointcolors["waypoint_taking_chevron"] = "contest";
	level.waypointbgtype["waypoint_taking_chevron"] = 2;
	level.waypointcolors["waypoint_ball_download"] = "neutral";
	level.waypointbgtype["waypoint_ball_download"] = 1;
	level.waypointcolors["waypoint_ball_pass"] = "friendly";
	level.waypointbgtype["waypoint_ball_pass"] = 1;
	level.waypointcolors["waypoint_ball_upload"] = "neutral";
	level.waypointbgtype["waypoint_ball_upload"] = 1;
	level.waypointcolors["waypoint_neutral_ball"] = "neutral";
	level.waypointbgtype["waypoint_neutral_ball"] = 1;
	level.waypointcolors["waypoint_capture_a"] = "enemy";
	level.waypointbgtype["waypoint_capture_a"] = 2;
	level.waypointcolors["waypoint_capture_b"] = "enemy";
	level.waypointbgtype["waypoint_capture_b"] = 2;
	level.waypointcolors["waypoint_capture_c"] = "enemy";
	level.waypointbgtype["waypoint_capture_c"] = 2;
	level.waypointcolors["waypoint_defend_a"] = "friendly";
	level.waypointbgtype["waypoint_defend_a"] = 2;
	level.waypointcolors["waypoint_defend_b"] = "friendly";
	level.waypointbgtype["waypoint_defend_b"] = 2;
	level.waypointcolors["waypoint_defend_c"] = "friendly";
	level.waypointbgtype["waypoint_defend_c"] = 2;
	level.waypointcolors["waypoint_losing_a"] = "contest";
	level.waypointbgtype["waypoint_losing_a"] = 2;
	level.waypointcolors["waypoint_losing_b"] = "contest";
	level.waypointbgtype["waypoint_losing_b"] = 2;
	level.waypointcolors["waypoint_losing_c"] = "contest";
	level.waypointbgtype["waypoint_losing_c"] = 2;
	level.waypointcolors["waypoint_bomb"] = "neutral";
	level.waypointbgtype["waypoint_bomb"] = 2;
	level.waypointcolors["waypoint_bomb_defusing"] = "contest";
	level.waypointbgtype["waypoint_bomb_defusing"] = 2;
	level.waypointcolors["waypoint_bomb_planting"] = "contest";
	level.waypointbgtype["waypoint_bomb_planting"] = 2;
	level.waypointcolors["waypoint_defuse_a"] = "enemy";
	level.waypointbgtype["waypoint_defuse_a"] = 2;
	level.waypointcolors["waypoint_defuse_b"] = "enemy";
	level.waypointbgtype["waypoint_defuse_b"] = 2;
	level.waypointcolors["waypoint_bank_a"] = "neutral";
	level.waypointbgtype["waypoint_bank_a"] = 2;
	level.waypointcolors["waypoint_bank_b"] = "neutral";
	level.waypointbgtype["waypoint_bank_b"] = 2;
	level.waypointcolors["waypoint_blitz_defend"] = "friendly";
	level.waypointbgtype["waypoint_blitz_defend"] = 2;
	level.waypointcolors["waypoint_blitz_defend_round"] = "friendly";
	level.waypointbgtype["waypoint_blitz_defend_round"] = 1;
	level.waypointcolors["waypoint_defend_round"] = "friendly";
	level.waypointbgtype["waypoint_defend_round"] = 1;
	level.waypointcolors["waypoint_blitz_goal"] = "enemy";
	level.waypointbgtype["waypoint_blitz_goal"] = 2;
	level.waypointcolors["waypoint_uplink_contested"] = "contest";
	level.waypointbgtype["waypoint_uplink_contested"] = 2;
	level.waypointcolors["waypoint_dogtags"] = "enemy";
	level.waypointcolors["waypoint_dogtags_friendlys"] = "friendly";
	level.waypointcolors["waypoint_taking_flag"] = "contest";
	level.waypointbgtype["waypoint_taking_flag"] = 2;
	level.waypointcolors["waypoint_capture_kill"] = "enemy";
	level.waypointbgtype["waypoint_capture_kill"] = 2;
	level.waypointcolors["waypoint_capture_kill_round"] = "enemy";
	level.waypointbgtype["waypoint_capture_kill_round"] = 1;
	level.waypointcolors["waypoint_capture_recover"] = "friendly";
	level.waypointbgtype["waypoint_capture_recover"] = 2;
	level.waypointcolors["waypoint_capture_take"] = "enemy";
	level.waypointbgtype["waypoint_capture_take"] = 2;
	level.waypointcolors["waypoint_captureneutral_a"] = "neutral";
	level.waypointbgtype["waypoint_captureneutral_a"] = 2;
	level.waypointcolors["waypoint_captureneutral_b"] = "neutral";
	level.waypointbgtype["waypoint_captureneutral_b"] = 2;
	level.waypointcolors["waypoint_captureneutral_c"] = "neutral";
	level.waypointbgtype["waypoint_captureneutral_c"] = 2;
	level.waypointcolors["waypoint_contested_a"] = "contest";
	level.waypointbgtype["waypoint_contested_a"] = 2;
	level.waypointcolors["waypoint_contested_b"] = "contest";
	level.waypointbgtype["waypoint_contested_b"] = 2;
	level.waypointcolors["waypoint_contested_c"] = "contest";
	level.waypointbgtype["waypoint_contested_c"] = 2;
	level.waypointcolors["waypoint_escort"] = "friendly";
	level.waypointbgtype["waypoint_escort"] = 1;
	level.waypointcolors["waypoint_reset_marker"] = "contest";
	level.waypointbgtype["waypoint_reset_marker"] = 2;
	level.waypointcolors["waypoint_returning_flag"] = "contest";
	level.waypointbgtype["waypoint_returning_flag"] = 2;
	level.waypointcolors["waypoint_scoring_foe_a"] = "enemy";
	level.waypointbgtype["waypoint_scoring_foe_a"] = 2;
	level.waypointcolors["waypoint_scoring_foe_b"] = "enemy";
	level.waypointbgtype["waypoint_scoring_foe_b"] = 2;
	level.waypointcolors["waypoint_scoring_friend_a"] = "friendly";
	level.waypointbgtype["waypoint_scoring_friend_a"] = 2;
	level.waypointcolors["waypoint_scoring_friend_b"] = "friendly";
	level.waypointbgtype["waypoint_scoring_friend_b"] = 2;
	level.waypointcolors["waypoint_taking_a"] = "contest";
	level.waypointbgtype["waypoint_taking_a"] = 2;
	level.waypointcolors["waypoint_taking_b"] = "contest";
	level.waypointbgtype["waypoint_taking_b"] = 2;
	level.waypointcolors["waypoint_taking_c"] = "contest";
	level.waypointbgtype["waypoint_taking_c"] = 2;
	level.waypointcolors["waypoint_target_a"] = "enemy";
	level.waypointbgtype["waypoint_target_a"] = 2;
	level.waypointcolors["waypoint_target_b"] = "enemy";
	level.waypointbgtype["waypoint_target_b"] = 2;
}

//Function Number: 57
func_3757()
{
	scripts\mp\_load::main();
	scripts\mp\_utility::func_ABF2("round_over",0);
	scripts\mp\_utility::func_ABF2("game_over",0);
	scripts\mp\_utility::func_ABF2("block_notifies",0);
	scripts\mp\_utility::func_ABF2("post_game_level_event_active",0);
	level.var_D84D = 0;
	level.var_D84E = 0;
	level.var_D701 = 0;
	level.var_18F = 0;
	setdvar("bg_compassShowEnemies",getdvar("scr_game_forceuav"));
	if(scripts\mp\_utility::func_B3EC())
	{
		setdvar("isMatchMakingGame",1);
	}
	else
	{
		setdvar("isMatchMakingGame",0);
	}

	if(level.multiteambased)
	{
		setdvar("ui_numteams",level.var_C246);
	}

	if(!isdefined(game["gamestarted"]))
	{
		game["clientid"] = 0;
		game["truncated_killcams"] = 0;
		if(!isdefined(game["attackers"]) || !isdefined(game["defenders"]))
		{
			thread scripts\common\utility::func_66BD("No attackers or defenders team defined in level .gsc.");
		}

		if(!isdefined(game["attackers"]))
		{
			game["attackers"] = "allies";
		}

		if(!isdefined(game["defenders"]))
		{
			game["defenders"] = "axis";
		}

		if(!isdefined(game["state"]))
		{
			game["state"] = "playing";
		}

		game["allies"] = "UNSA";
		game["axis"] = "SDF";
		game["strings"]["press_to_spawn"] = &"PLATFORM_PRESS_TO_SPAWN";
		game["strings"]["spawn_next_round"] = &"MP_SPAWN_NEXT_ROUND";
		game["strings"]["spawn_flag_wait"] = &"MP_SPAWN_FLAG_WAIT";
		game["strings"]["spawn_point_capture_wait"] = &"MP_SPAWN_POINT_CAPTURE_WAIT";
		game["strings"]["spawn_tag_wait"] = &"MP_SPAWN_TAG_WAIT";
		game["strings"]["waiting_to_spawn"] = &"MP_WAITING_TO_SPAWN";
		game["strings"]["waiting_to_safespawn"] = &"MP_WAITING_TO_SAFESPAWN";
		game["strings"]["match_starting"] = &"MP_MATCH_STARTING";
		game["strings"]["change_class"] = &"MP_CHANGE_CLASS_NEXT_SPAWN";
		game["strings"]["change_rig"] = &"LUA_MENU_MP_CHANGE_RIG_NEXT_SPAWN";
		game["strings"]["last_stand"] = &"MPUI_LAST_STAND";
		game["strings"]["final_stand"] = &"MPUI_FINAL_STAND";
		game["strings"]["c4_death"] = &"MPUI_C4_DEATH";
		game["strings"]["must_select_loadout_to_spawn"] = &"MP_INGAME_ONLY_SELECT_LOADOUT_TO_SPAWN";
		game["strings"]["cowards_way"] = &"PLATFORM_COWARDS_WAY_OUT";
		game["colors"]["black"] = (0,0,0);
		game["colors"]["white"] = (1,1,1);
		game["colors"]["grey"] = (0.5,0.5,0.5);
		game["colors"]["cyan"] = (0.35,0.7,0.9);
		game["colors"]["orange"] = (0.9,0.6,0);
		game["colors"]["blue"] = (0.2,0.3,0.7);
		game["colors"]["red"] = (0.75,0.25,0.25);
		game["colors"]["green"] = (0.25,0.75,0.25);
		game["colors"]["yellow"] = (0.65,0.65,0);
		game["strings"]["allies_name"] = scripts\mp\_teams::func_81B5("allies");
		game["icons"]["allies"] = scripts\mp\_teams::func_81B2("allies");
		game["colors"]["allies"] = scripts\mp\_teams::func_81A4("allies");
		game["strings"]["axis_name"] = scripts\mp\_teams::func_81B5("axis");
		game["icons"]["axis"] = scripts\mp\_teams::func_81B2("axis");
		game["colors"]["axis"] = scripts\mp\_teams::func_81A4("axis");
		game["colors"]["friendly"] = (0.2588235,0.6392157,0.8745098);
		game["colors"]["enemy"] = (0.9294118,0.2313726,0.1411765);
		game["colors"]["contest"] = (1,0.8588235,0);
		game["colors"]["neutral"] = (1,1,1);
		initwaypointbackgrounds();
		if(game["colors"]["allies"] == game["colors"]["black"])
		{
			game["colors"]["allies"] = game["colors"]["grey"];
		}

		if(game["colors"]["axis"] == game["colors"]["black"])
		{
			game["colors"]["axis"] = game["colors"]["grey"];
		}

		[[ level.var_C580 ]]();
		setdvarifuninitialized("min_wait_for_players",5);
		if(level.console)
		{
			if(!level.splitscreen)
			{
				if(scripts\mp\_utility::func_9EA6() || function_0103())
				{
					level.var_D84D = scripts\mp\_tweakables::func_81E7("game","graceperiod_comp");
				}
				else
				{
					level.var_D84D = scripts\mp\_tweakables::func_81E7("game","graceperiod");
				}

				level.var_D84E = scripts\mp\_tweakables::func_81E7("game","matchstarttime");
			}
		}
		else
		{
			if(scripts\mp\_utility::func_9EA6() || function_0103())
			{
				level.var_D84D = scripts\mp\_tweakables::func_81E7("game","playerwaittime_comp");
			}
			else
			{
				level.var_D84D = scripts\mp\_tweakables::func_81E7("game","playerwaittime");
			}

			level.var_D84E = scripts\mp\_tweakables::func_81E7("game","matchstarttime");
		}

		function_01BC(0);
		function_01BD(0);
	}
	else
	{
		setdvarifuninitialized("min_wait_for_players",5);
		if(level.console)
		{
			if(!level.splitscreen)
			{
				level.var_D84D = 5;
				level.var_D84E = scripts\mp\_tweakables::func_81E7("game","matchstarttime");
			}
		}
		else
		{
			level.var_D84D = 5;
			level.var_D84E = scripts\mp\_tweakables::func_81E7("game","matchstarttime");
		}
	}

	if(!isdefined(game["status"]))
	{
		game["status"] = "normal";
	}

	setdvar("ui_overtime",scripts\mp\_utility::func_9900());
	if(game["status"] != "overtime" && game["status"] != "halftime")
	{
		if(!isdefined(game["switchedsides"]) && game["switchedsides"] == 1 && scripts\mp\_utility::func_9EA9())
		{
			game["teamScores"]["allies"] = 0;
			game["teamScores"]["axis"] = 0;
		}

		if(level.multiteambased)
		{
			for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
			{
				game["teamScores"][level.teamnamelist[var_00]] = 0;
			}
		}
	}

	if(!isdefined(game["timePassed"]))
	{
		game["timePassed"] = 0;
	}

	if(!isdefined(game["roundsPlayed"]))
	{
		game["roundsPlayed"] = 0;
	}

	if(!isdefined(game["overtimeRoundsPlayed"]))
	{
		game["overtimeRoundsPlayed"] = 0;
	}

	if(!isdefined(game["finalRound"]))
	{
		game["finalRound"] = 0;
	}

	setomnvar("ui_last_round",game["finalRound"]);
	if(!isdefined(game["roundsWon"]))
	{
		game["roundsWon"] = [];
	}

	if(!isdefined(game["timeToBeat"]))
	{
		game["timeToBeat"] = 0;
	}

	if(!isdefined(game["timeToBeatOld"]))
	{
		game["timeToBeatOld"] = 0;
	}

	if(!isdefined(game["timeToBeatTeam"]))
	{
		game["timeToBeatTeam"] = "none";
	}

	if(!isdefined(game["timeToBeatScore"]))
	{
		game["timeToBeatScore"] = 0;
	}

	if(level.teambased)
	{
		if(!isdefined(game["roundsWon"]["axis"]))
		{
			game["roundsWon"]["axis"] = 0;
		}

		if(!isdefined(game["roundsWon"]["allies"]))
		{
			game["roundsWon"]["allies"] = 0;
		}

		if(level.multiteambased)
		{
			for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
			{
				if(!isdefined(game["roundsWon"][level.teamnamelist[var_00]]))
				{
					game["roundsWon"][level.teamnamelist[var_00]] = 0;
				}
			}
		}
	}

	level.var_7669 = 0;
	level.var_72B3 = 0;
	level.var_90A1 = 0;
	level.var_8B38 = getdvarint("g_hardcore");
	level.tactical = (scripts\mp\_utility::func_B3EC() && getdvarint("scr_tactical")) || getdvarint("scr_game_tacticalmode");
	var_01 = scripts\mp\_utility::func_9D46() || level.tactical;
	setdvar("disable_energy_bullet_ricochet",var_01);
	if(level.tactical)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
		setdvar("jump_slowdownEnable",1);
		setdvar("sprintLeap_enabled",0);
		setdvar("scr_" + level.gametype + "_doubleJump",1);
		setdvar("scr_game_doubleJump",1);
		level.var_112C1 = 1;
	}

	if(level.var_8B38)
	{
		function_0132("game mode: hardcore");
	}

	level.var_54CC = getdvarint("scr_diehard");
	level.var_3B1E = getdvarint("scr_game_casualScoreStreaks");
	if(!isdefined(level.var_47EF))
	{
		level.var_47EF = getdvarint("scr_" + level.gametype + "_crankedBombTimer",0);
	}

	level.var_112C0 = scripts\common\utility::func_116D7(getdvarint("scr_" + level.gametype + "_crankedBombTimer") > 0,1,0);
	if(!level.teambased)
	{
		level.var_54CC = 0;
	}

	if(level.var_54CC)
	{
		function_0132("game mode: diehard");
	}

	level.var_1C98 = scripts\mp\_utility::func_803C("scr_" + level.gametype + "_allowKillstreaks","scr_game_allowKillstreaks");
	level.var_1CA1 = scripts\mp\_utility::func_803C("scr_" + level.gametype + "_allowPerks","scr_game_allowPerks");
	level.var_1CAA = scripts\mp\_utility::func_803C("scr_" + level.gametype + "_allowSupers","scr_game_allowSupers");
	level.var_11260 = scripts\mp\_utility::func_803C("scr_" + level.gametype + "_superFastChargeRate","scr_game_superFastChargeRate");
	level.superpointsmod = scripts\mp\_utility::func_803B("scr_" + level.gametype + "_superPointsMod","scr_game_superPointsMod");
	if(!level.tactical)
	{
		level.var_112C1 = scripts\mp\_utility::func_803C("scr_" + level.gametype + "_doubleJump","scr_game_doubleJump");
	}

	level.var_112C6 = scripts\mp\_utility::func_803C("scr_" + level.gametype + "_wallRun","scr_game_wallRun");
	level.var_10903 = scripts\mp\_utility::func_803B("scr_" + level.gametype + "_spawnProtectionTimer","scr_game_spawnProtectionTimer");
	level.var_EC3D = [];
	level.var_EC3D["kill"] = getdvarint("scr_" + level.gametype + "_pointsPerKill");
	level.var_EC3D["death"] = getdvarint("scr_" + level.gametype + "_pointsPerDeath");
	level.var_EC3D["headshot"] = getdvarint("scr_" + level.gametype + "_pointsHeadshotBonus");
	level.var_B4A1 = 5;
	level.var_B4A0 = 32;
	level.var_130DD = 1;
	level.var_B47A = scripts\mp\_utility::func_803C("scr_" + level.gametype + "_ffPunishLimit","scr_game_ffPunishLimit");
	thread scripts\mp\_powerloot::init();
	thread scripts\mp\_healthoverlay::init();
	thread scripts\mp\_killcam::init();
	thread scripts\mp\_final_killcam::func_9807();
	thread scripts\mp\_battlechatter_mp::init();
	thread scripts\mp\_music_and_dialog::init();
	thread [[ level.var_9994 ]]();
	thread scripts\mp\_class::init();
	thread scripts\mp\_persistence::init();
	thread scripts\mp\_missions::init();
	thread scripts\mp\_rank::init();
	thread scripts\mp\_playercards::init();
	thread scripts\mp\_menus::init();
	thread scripts\mp\_hud::init();
	thread scripts\mp\_serversettings::init();
	thread scripts\mp\_teams::init();
	thread scripts\mp\_weapons::init();
	thread scripts\mp\_outline::init();
	thread scripts\mp\_shellshock::init();
	thread scripts\mp\_deathicons::init();
	thread scripts\mp\_damagefeedback::init();
	thread scripts\mp\_lightarmor::init();
	thread scripts\mp\killstreaks\_chill_common::func_3E6E();
	thread scripts\mp\_objpoints::init();
	thread scripts\mp\_gameobjects::init();
	thread scripts\mp\_spectating::init();
	thread scripts\mp\_spawnlogic::init();
	thread scripts\mp\_matchdata::init();
	thread scripts\mp\_clientmatchdata::init();
	thread scripts\mp\_awards::init();
	thread scripts\mp\_areas::init();
	thread scripts\mp\_adrenaline::init();
	thread scripts\mp\_killstreak_loot::init();
	thread [[ level.var_A6A2 ]]();
	thread scripts\mp\_passives::init();
	thread scripts\mp\perks\_perks::init();
	thread scripts\mp\_events::init();
	thread scripts\mp\_defcon::init();
	thread [[ level.var_B3E7 ]]();
	thread scripts\mp\_zipline::init();
	thread lib_0D69::init();
	thread scripts\mp\_powers::init();
	thread scripts\mp\_drone_pet::init();
	thread scripts\mp\_whizby::init();
	thread scripts\mp\_analyticslog::init();
	thread scripts\mp\_loot::init();
	thread scripts\mp\_supers::init();
	thread scripts\mp\_callouts::init();
	thread func_1C74();
	thread ismp_init();
	thread scripts\mp\_weapons::func_13AB2();
	thread scripts\mp\_supers::func_13B6B();
	thread scripts\mp\_gestures_mp::init();
	thread scripts\mp\sentientpoolmanager::init();
	thread scripts\mp\objidpoolmanager::init();
	thread scripts\mp\contracts::init();
	thread scripts\mp\_utility::initarbitraryuptriggers();
	thread scripts\mp\_broshot::initbroshotfx();
	if(level.teambased)
	{
		thread scripts\mp\_friendicons::init();
	}

	thread scripts\mp\_hud_message::init();
	if(scripts\mp\_codcasterclientmatchdata::func_10036())
	{
		thread scripts\mp\_codcasterclientmatchdata::init();
	}

	game["gamestarted"] = 1;
	level.var_4BFF = game["roundsPlayed"] + 1;
	level.var_B4BC = 0;
	level.var_13BDE["allies"] = 0;
	level.var_13BDE["axis"] = 0;
	level.var_AA44["allies"] = 0;
	level.var_AA44["axis"] = 0;
	level.var_13BE0["allies"] = 0;
	level.var_13BE0["axis"] = 0;
	level.var_1BE7["allies"] = [];
	level.var_1BE7["axis"] = [];
	level.var_1659 = [];
	if(level.multiteambased)
	{
		for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
		{
			level.var_1461[level.teamnamelist[var_00]] = 0;
			level.var_1301[level.teamnamelist[var_00]] = 0;
			level.var_1462[level.teamnamelist[var_00]] = 0;
			level.var_1168[level.teamnamelist[var_00]] = [];
		}
	}

	setomnvar("ui_scorelimit",0);
	setdvar("ui_allow_teamchange",1);
	setomnvar("ui_round_hint_override_attackers",0);
	setomnvar("ui_round_hint_override_defenders",0);
	if(scripts\mp\_utility::func_7ECE())
	{
		setdvar("g_deadChat",0);
	}
	else
	{
		setdvar("g_deadChat",1);
	}

	var_02 = getdvarint("scr_" + level.gametype + "_waverespawndelay");
	if(var_02)
	{
		level.var_13BDE["allies"] = var_02;
		level.var_13BDE["axis"] = var_02;
		level.var_AA44["allies"] = 0;
		level.var_AA44["axis"] = 0;
		if(level.multiteambased)
		{
			for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
			{
				level.var_1461[level.teamnamelist[var_00]] = var_02;
				level.var_1301[level.teamnamelist[var_00]] = 0;
			}
		}

		level thread func_13BE6();
	}

	scripts\mp\_utility::func_766E("prematch_done",0);
	level.var_8487 = 15;
	level.ingraceperiod = level.var_8487;
	scripts\mp\_utility::func_766E("graceperiod_done",0);
	level.var_D4ED = 0;
	level.var_E75F = 6;
	level.var_6C71 = 3;
	level.var_8864 = 3;
	level.var_C08A = getentarray("noragdoll","targetname");
	level.var_EC3B = scripts\mp\_utility::getwatcheddvar("scorelimit");
	level.var_E762 = scripts\mp\_utility::getwatcheddvar("roundlimit");
	level.var_13D89 = scripts\mp\_utility::getwatcheddvar("winlimit");
	if(level.var_E762 != 1)
	{
		setomnvar("ui_current_round",level.var_4BFF);
	}

	if(level.var_EC3B == 1)
	{
		level.var_E763 = 1;
		level.var_11A3C = level.var_13D89;
	}
	else
	{
		level.var_E763 = level.var_EC3B * game["roundsPlayed"] + 1;
		level.var_11A3C = level.var_EC3B * level.var_E762;
	}

	if(scripts\mp\_utility::func_E269())
	{
		level.var_E763 = level.var_EC3B;
		level.var_11A3C = level.var_EC3B;
		game["teamScores"][game["attackers"]] = 0;
		setteamscore(game["attackers"],0);
		game["teamScores"][game["defenders"]] = 0;
		setteamscore(game["defenders"],0);
	}

	if(scripts\mp\_utility::func_9ECF() && scripts\mp\_utility::func_9900())
	{
		scripts\mp\_gamescore::func_12EE5();
	}

	if(level.teambased)
	{
		scripts\mp\_gamescore::func_12F3B("axis");
		scripts\mp\_gamescore::func_12F3B("allies");
		if(level.multiteambased)
		{
			for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
			{
				scripts\mp\_gamescore::func_12F3B(level.teamnamelist[var_00]);
			}
		}
	}

	thread func_12F54();
	level notify("update_scorelimit");
	if(isdefined(level.var_B3F8))
	{
		level thread [[ level.var_B3F8 ]]();
	}

	[[ level.var_C5A4 ]]();
	level.var_EC3F = getdvarint("scr_" + level.gametype + "_score_percentage_cut_off",80);
	level.var_1190B = getdvarint("scr_" + level.gametype + "_time_percentage_cut_off",80);
	if(!level.console && getdvar("dedicated") == "dedicated LAN server" || getdvar("dedicated") == "dedicated internet server")
	{
		thread func_132A3();
	}

	thread func_10D9F();
	level thread scripts\mp\_utility::func_12F5B();
	level thread func_118FB();
	level thread scripts\mp\_final_killcam::func_5853();
	level thread updateleaderboardstatscontinuous();
}

//Function Number: 58
func_132A3()
{
	for(;;)
	{
		if(level.rankedmatch)
		{
			exitlevel(0);
		}

		if(!getdvarint("xblive_privatematch"))
		{
			exitlevel(0);
		}

		if(getdvar("dedicated") != "dedicated LAN server" && getdvar("dedicated") != "dedicated internet server")
		{
			exitlevel(0);
		}

		wait(5);
	}
}

//Function Number: 59
func_118FB()
{
	level endon("game_ended");
	var_00 = scripts\mp\_utility::func_81CB();
	while(game["state"] == "playing")
	{
		thread func_3E54(var_00);
		var_00 = scripts\mp\_utility::func_81CB();
		if(isdefined(level.var_10DFF))
		{
			if(func_81CD() < 3000)
			{
				wait(0.1);
				continue;
			}
		}

		wait(1);
	}
}

//Function Number: 60
func_12F54()
{
	for(;;)
	{
		level scripts\common\utility::waittill_either("update_scorelimit","update_winlimit");
		if(scripts\mp\_utility::func_9900())
		{
			if(scripts\mp\_utility::func_9FAA())
			{
				foreach(var_01 in level.players)
				{
					var_01 setclientomnvar("ui_friendly_time_to_beat",scripts\common\utility::func_116D7(var_01.team == game["timeToBeatTeam"],game["timeToBeat"],game["timeToBeatOld"]));
					var_01 setclientomnvar("ui_enemy_time_to_beat",scripts\common\utility::func_116D7(var_01.team != game["timeToBeatTeam"],game["timeToBeat"],game["timeToBeatOld"]));
				}

				setomnvar("ui_scorelimit",scripts\common\utility::func_116D7(scripts\mp\_utility::func_9FAB(),game["timeToBeatScore"],1));
			}
			else if(scripts\mp\_utility::func_A00B())
			{
				var_03 = game["roundsWon"][game["defenders"]];
				var_04 = game["roundsWon"][game["attackers"]];
				var_05 = 0;
				if(var_03 == var_04)
				{
					var_05 = var_03 + 2;
				}
				else if(var_03 > var_04)
				{
					var_05 = var_03 + 1;
				}
				else
				{
					var_05 = var_04 + 1;
				}

				setomnvar("ui_scorelimit",var_05);
			}
			else
			{
				func_130AB();
			}

			continue;
		}

		func_130AB();
	}
}

//Function Number: 61
func_130AB()
{
	if(!scripts\mp\_utility::func_9F32() || !scripts\mp\_utility::func_9EBD() || scripts\mp\_utility::func_9EA9())
	{
		setomnvar("ui_scorelimit",level.var_11A3C);
		thread func_3E47();
		return;
	}

	setomnvar("ui_scorelimit",level.var_13D89);
}

//Function Number: 62
func_D54F()
{
	self endon("death");
	self endon("stop_ticking");
	level endon("game_ended");
	var_00 = level.var_2C6C;
	for(;;)
	{
		self playsound("ui_mp_suitcasebomb_timer");
		if(var_00 > 10)
		{
			var_00 = var_00 - 1;
			wait(1);
		}
		else if(var_00 > 4)
		{
			var_00 = var_00 - 0.5;
			wait(0.5);
		}
		else if(var_00 > 1)
		{
			var_00 = var_00 - 0.4;
			wait(0.4);
		}
		else
		{
			var_00 = var_00 - 0.3;
			wait(0.3);
		}

		scripts\mp\_hostmigration::func_13834();
	}
}

//Function Number: 63
func_11094()
{
	self notify("stop_ticking");
}

//Function Number: 64
func_118F7()
{
	level endon("game_ended");
	wait(0.05);
	var_00 = spawn("script_origin",(0,0,0));
	var_00 hide();
	var_01 = scripts\common\utility::func_116D7(scripts\mp\_utility::func_9D46(),5,2);
	while(game["state"] == "playing")
	{
		if(!level.var_1191F && scripts\mp\_utility::func_81CA())
		{
			var_02 = func_81CD() / 1000;
			var_03 = int(var_02 + 0.5);
			if(var_03 >= 30 && var_03 <= 60)
			{
				level notify("match_ending_soon","time");
			}

			if(var_03 <= 10 || var_03 <= 30 && var_03 % var_01 == 0)
			{
				level notify("match_ending_very_soon");
				if(var_03 == 0)
				{
					break;
				}

				var_00 playsound("ui_mp_timer_countdown");
			}

			if(var_02 - floor(var_02) >= 0.05)
			{
				wait(var_02 - floor(var_02));
			}
		}

		wait(1);
	}
}

//Function Number: 65
func_7687()
{
	level endon("game_ended");
	if(isdefined(game["startTimeFromMatchStart"]))
	{
		level.var_10E00 = game["startTimeFromMatchStart"];
	}

	level waittill("prematch_over");
	level.var_10DFF = gettime();
	level.var_561F = 0;
	if(!isdefined(game["startTimeFromMatchStart"]))
	{
		game["startTimeFromMatchStart"] = gettime();
		level.var_10E00 = gettime();
		scripts\mp\_matchdata::func_C558();
	}

	if(isdefined(game["roundMillisecondsAlreadyPassed"]))
	{
		level.var_10DFF = level.var_10DFF - game["roundMillisecondsAlreadyPassed"];
		game["roundMillisecondsAlreadyPassed"] = undefined;
	}

	if(game["roundsPlayed"] < 24)
	{
		setmatchdata("utcRoundStartTimeSeconds",game["roundsPlayed"],function_00D2());
	}

	var_00 = gettime();
	while(game["state"] == "playing")
	{
		if(!level.var_1191F)
		{
			game["timePassed"] = game["timePassed"] + gettime() - var_00;
		}

		var_00 = gettime();
		wait(1);
	}
}

//Function Number: 66
func_12F45(param_00)
{
	var_01 = level.var_11920 || isdefined(level.var_90A9);
	if(!scripts\mp\_utility::func_766C("prematch_done"))
	{
		var_01 = 0;
	}

	if(!level.var_1191F && var_01)
	{
		level.var_1191F = 1;
		level.var_1191E = gettime();
		var_02 = func_81CD();
		if(isdefined(param_00))
		{
			function_01AF(param_00);
		}
		else
		{
			function_01AF(gettime() + int(var_02));
		}

		setomnvar("ui_match_timer_stopped",1);
		return;
	}

	if(level.var_1191F && !var_01)
	{
		level.var_1191F = 0;
		level.var_561F = level.var_561F + gettime() - level.var_1191E;
		var_02 = func_81CD();
		if(isdefined(param_00))
		{
			function_01AF(param_00);
		}
		else
		{
			function_01AF(gettime() + int(var_02));
		}

		setomnvar("ui_match_timer_stopped",0);
	}
}

//Function Number: 67
func_C9D6(param_00)
{
	level.var_11920 = 1;
	func_12F45(param_00);
}

//Function Number: 68
func_E2FF(param_00)
{
	level.var_11920 = 0;
	func_12F45(param_00);
}

//Function Number: 69
func_10D9F()
{
	setslowmotion(1,1,0);
	thread func_7687();
	level.var_1191F = 0;
	level.var_11920 = 0;
	setomnvar("ui_prematch_period",1);
	func_D84D();
	function_026C("MatchStarted: Completed");
	thread scripts\mp\_analyticslog::func_AFB1();
	scripts\mp\_utility::func_766F("prematch_done");
	level notify("prematch_over");
	setomnvar("ui_prematch_period",0);
	func_12F45();
	if(scripts\mp\_utility::func_81CA() > 0)
	{
		setomnvar("ui_match_timer_hidden",0);
	}
	else
	{
		setomnvar("ui_match_timer_hidden",1);
	}

	thread func_118F7();
	thread func_8487();
	thread scripts\mp\_missions::func_E75B();
}

//Function Number: 70
func_13BE6()
{
	level endon("game_ended");
	while(game["state"] == "playing")
	{
		var_00 = gettime();
		if(var_00 - level.var_AA44["allies"] > level.var_13BDE["allies"] * 1000)
		{
			level notify("wave_respawn_allies");
			level.var_AA44["allies"] = var_00;
			level.var_13BE0["allies"] = 0;
		}

		if(var_00 - level.var_AA44["axis"] > level.var_13BDE["axis"] * 1000)
		{
			level notify("wave_respawn_axis");
			level.var_AA44["axis"] = var_00;
			level.var_13BE0["axis"] = 0;
		}

		if(level.multiteambased)
		{
			for(var_01 = 0;var_01 < level.teamnamelist.size;var_01++)
			{
				if(var_00 - level.var_AA44[level.teamnamelist[var_01]] > level.var_1461[level.teamnamelist[var_01]] * 1000)
				{
					var_02 = "wave_rewpawn_" + level.teamnamelist[var_01];
					level notify(var_02);
					level.var_AA44[level.teamnamelist[var_01]] = var_00;
					level.var_13BE0[level.teamnamelist[var_01]] = 0;
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 71
func_7E07()
{
	var_00["allies"] = 0;
	var_00["axis"] = 0;
	var_01["allies"] = 0;
	var_01["axis"] = 0;
	foreach(var_03 in level.players)
	{
		var_04 = var_03.pers["team"];
		if(isdefined(var_04) && var_04 == "allies" || var_04 == "axis")
		{
			var_00[var_04] = var_00[var_04] + var_03.var_1AB;
			var_01[var_04] = var_01[var_04] + var_03.var_E9;
		}
	}

	if(var_00["allies"] > var_00["axis"])
	{
		return "allies";
	}
	else if(var_00["axis"] > var_00["allies"])
	{
		return "axis";
	}

	if(var_01["allies"] < var_01["axis"])
	{
		return "allies";
	}
	else if(var_01["axis"] < var_01["allies"])
	{
		return "axis";
	}

	if(randomint(2) == 0)
	{
		return "allies";
	}

	return "axis";
}

//Function Number: 72
func_DCD3(param_00)
{
	if(scripts\mp\_utility::func_B3EC())
	{
		func_FB23();
		if(func_90A2())
		{
			level.var_90A1 = 1;
			function_0132("host idled out");
			function_0063();
		}

		func_12ECA(param_00);
	}

	func_12F65(param_00);
}

//Function Number: 73
func_56E0(param_00,param_01)
{
	if(level.var_8865 == "halftime" && level.var_E762 && game["roundsPlayed"] * 2 == level.var_E762)
	{
		foreach(var_03 in level.players)
		{
			var_03 method_8461("mus_mp_halftime");
		}
	}
	else if(level.var_D4ED)
	{
		foreach(var_03 in level.players)
		{
			var_03 method_8461("mus_mp_halftime");
		}
	}
	else if(level.var_8865 == "halftime" && !level.var_E762)
	{
		foreach(var_03 in level.players)
		{
			var_03 method_8461("mus_mp_halftime");
		}
	}

	if(!level.var_5828 && scripts\mp\_utility::func_9EA9() && game["finalRound"] == 0)
	{
		param_00 = "roundend";
	}

	foreach(var_03 in level.players)
	{
		if(level.teambased)
		{
			var_03 thread scripts\mp\_hud_message::func_115DD(param_00,1,param_01);
			continue;
		}

		var_03 thread scripts\mp\_hud_message::func_C752(param_00,param_01);
	}
}

//Function Number: 74
func_56DA(param_00,param_01)
{
	setomnvar("ui_match_over",1);
	foreach(var_03 in level.players)
	{
		if(level.teambased)
		{
			var_03 thread scripts\mp\_hud_message::func_115DD(param_00,0,param_01);
			continue;
		}

		var_03 thread scripts\mp\_hud_message::func_C752(param_00,param_01);
	}

	level notify("game_win",param_00);
}

//Function Number: 75
func_56E1()
{
	level notify("spawning_intermission");
	foreach(var_01 in level.players)
	{
		var_01 thread scripts\mp\_playerlogic::func_108DD();
	}

	var_03 = level.var_8865;
	if(var_03 == "halftime")
	{
		if(level.var_E762)
		{
			if(game["roundsPlayed"] * 2 == level.var_E762)
			{
				var_03 = "halftime";
			}
			else
			{
				var_03 = "intermission";
			}
		}
		else
		{
			var_03 = "intermission";
		}
	}

	level notify("round_switch",var_03);
	if(game["finalRound"] == 1)
	{
		var_03 = "finalround";
	}

	var_04 = 0;
	if(isdefined(level.var_11374))
	{
		var_04 = game["end_reason"]["switching_sides"];
	}

	foreach(var_01 in level.players)
	{
		var_01 thread scripts\mp\_hud_message::func_115DD(var_03,1,var_04);
	}

	func_E761(level.var_8864,0);
}

//Function Number: 76
func_7384(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(param_00 > 0 && param_03)
	{
		thread func_1032D(param_00);
	}

	if(param_00 > 1 && !scripts\mp\_utility::func_9FB3(level.var_C1C3))
	{
		thread func_636B(param_00);
	}

	thread func_F22F(param_00);
	foreach(var_05 in level.players)
	{
		var_05 thread func_7386(param_00);
		var_05 thread func_E760(4);
		var_05 func_736F();
		var_05 setclientdvars("cg_everyoneHearsEveryone",1,"cg_drawSpectatorMessages",0);
		if(isdefined(param_01) && isdefined(param_02))
		{
			if(param_01 == "cg_fovScale" && var_05 issplitscreenplayer())
			{
				var_05 setclientdvars(param_01,0.75);
			}

			var_05 setclientdvars(param_01,param_02);
		}
	}

	foreach(var_08 in level.var_1900)
	{
		var_08 scripts\mp\_utility::func_7385(1);
	}
}

//Function Number: 77
func_636B(param_00)
{
	var_01 = param_00 * 1.3;
	function_0235("bw",var_01);
	scripts\mp\_hostmigration::func_13708(var_01);
}

//Function Number: 78
func_1032D(param_00)
{
	setslowmotion(1,0.4,param_00);
	func_F6DF();
	scripts\mp\_hostmigration::func_13708(param_00);
	setslowmotion(1,1,0);
	func_E26E();
}

//Function Number: 79
func_F6DF()
{
	soundsettimescalefactor("music_lr",0);
	soundsettimescalefactor("music_lsrs",0);
	soundsettimescalefactor("voice_air_3d",0);
	soundsettimescalefactor("voice_radio_3d",0);
	soundsettimescalefactor("voice_radio_2d",0);
	soundsettimescalefactor("voice_narration_2d",0);
	soundsettimescalefactor("voice_special_2d",0);
	soundsettimescalefactor("voice_bchatter_1_3d",0);
	soundsettimescalefactor("plr_ui_ingame_unres_2d",0);
	soundsettimescalefactor("hurt_nofilter_2d",0.15);
	soundsettimescalefactor("amb_bed_2d",0.25);
	soundsettimescalefactor("amb_elm_ext_unres_3d",0.25);
	soundsettimescalefactor("amb_elm_int_unres_3d",0.25);
	soundsettimescalefactor("amb_elm_unres_3d",0.25);
	soundsettimescalefactor("weap_plr_fire_1_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_2_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_3_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_4_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_overlap_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_lfe_2d",0);
	soundsettimescalefactor("weap_plr_fire_alt_1_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_alt_2_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_alt_3_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_alt_4_2d",0.25);
	soundsettimescalefactor("reload_plr_res_2d",0.3);
	soundsettimescalefactor("reload_plr_unres_2d",0.3);
	soundsettimescalefactor("scn_fx_unres_3d",0.25);
	soundsettimescalefactor("scn_fx_unres_2d",0.25);
	soundsettimescalefactor("scn_lfe_unres_2d",0);
	soundsettimescalefactor("scn_lfe_unres_3d",0);
	soundsettimescalefactor("spear_refl_close_unres_3d_lim",0.25);
	soundsettimescalefactor("spear_refl_unres_3d_lim",0.25);
	soundsettimescalefactor("weap_npc_main_3d",0.25);
	soundsettimescalefactor("weap_npc_mech_3d",0.25);
	soundsettimescalefactor("weap_npc_mid_3d",0.25);
	soundsettimescalefactor("weap_npc_lfe_3d",0);
	soundsettimescalefactor("weap_npc_dist_3d",0.25);
	soundsettimescalefactor("weap_npc_lo_3d",0.25);
	soundsettimescalefactor("melee_npc_3d",0.25);
	soundsettimescalefactor("melee_plr_2d",0.25);
	soundsettimescalefactor("special_hi_unres_1_3d",0.25);
	soundsettimescalefactor("special_lo_unres_1_2d",0);
	soundsettimescalefactor("bulletflesh_npc_1_unres_3d_lim",0.25);
	soundsettimescalefactor("bulletflesh_npc_2_unres_3d_lim",0.25);
	soundsettimescalefactor("bulletflesh_1_unres_3d_lim",0.25);
	soundsettimescalefactor("bulletflesh_2_unres_3d_lim",0.25);
	soundsettimescalefactor("foley_plr_mvmt_unres_2d_lim",0.3);
	soundsettimescalefactor("scn_fx_unres_2d_lim",0.3);
	soundsettimescalefactor("menu_1_2d_lim",0);
	soundsettimescalefactor("shock1_nofilter_3d",0.25);
	soundsettimescalefactor("equip_use_unres_3d",0.3);
	soundsettimescalefactor("explo_1_3d",0.3);
	soundsettimescalefactor("explo_2_3d",0.3);
	soundsettimescalefactor("explo_3_3d",0.3);
	soundsettimescalefactor("explo_4_3d",0.3);
	soundsettimescalefactor("explo_5_3d",0.3);
	soundsettimescalefactor("explo_lfe_3d",0.3);
	soundsettimescalefactor("vehicle_air_loops_3d_lim",0.3);
	soundsettimescalefactor("projectile_loop_close",0.3);
	soundsettimescalefactor("projectile_loop_mid",0.3);
	soundsettimescalefactor("projectile_loop_dist",0.3);
}

//Function Number: 80
func_E26E()
{
	soundsettimescalefactor("music_lr",0);
	soundsettimescalefactor("music_lsrs",0);
	soundsettimescalefactor("weap_plr_fire_1_2d",0);
	soundsettimescalefactor("weap_plr_fire_2_2d",0);
	soundsettimescalefactor("weap_plr_fire_3_2d",0);
	soundsettimescalefactor("weap_plr_fire_4_2d",0);
	soundsettimescalefactor("weap_plr_fire_overlap_2d",0);
	soundsettimescalefactor("weap_plr_fire_lfe_2d",0);
	soundsettimescalefactor("weap_plr_fire_alt_1_2d",0);
	soundsettimescalefactor("weap_plr_fire_alt_2_2d",0);
	soundsettimescalefactor("weap_plr_fire_alt_3_2d",0);
	soundsettimescalefactor("weap_plr_fire_alt_4_2d",0);
	soundsettimescalefactor("scn_fx_unres_3d",0);
	soundsettimescalefactor("scn_fx_unres_2d",0);
	soundsettimescalefactor("spear_refl_close_unres_3d_lim",0);
	soundsettimescalefactor("spear_refl_unres_3d_lim",0);
	soundsettimescalefactor("weap_npc_main_3d",0);
	soundsettimescalefactor("weap_npc_mech_3d",0);
	soundsettimescalefactor("weap_npc_mid_3d",0);
	soundsettimescalefactor("weap_npc_lfe_3d",0);
	soundsettimescalefactor("weap_npc_dist_3d",0);
	soundsettimescalefactor("weap_npc_lo_3d",0);
	soundsettimescalefactor("melee_npc_3d",0);
	soundsettimescalefactor("melee_plr_2d",0);
	soundsettimescalefactor("special_hi_unres_1_3d",0);
	soundsettimescalefactor("special_lo_unres_1_2d",0);
	soundsettimescalefactor("bulletflesh_npc_1_unres_3d_lim",0);
	soundsettimescalefactor("bulletflesh_npc_2_unres_3d_lim",0);
	soundsettimescalefactor("bulletflesh_1_unres_3d_lim",0);
	soundsettimescalefactor("bulletflesh_2_unres_3d_lim",0);
	soundsettimescalefactor("foley_plr_mvmt_unres_2d_lim",0);
	soundsettimescalefactor("scn_fx_unres_2d_lim",0);
	soundsettimescalefactor("menu_1_2d_lim",0);
	soundsettimescalefactor("equip_use_unres_3d",0);
	soundsettimescalefactor("explo_1_3d",0);
	soundsettimescalefactor("explo_2_3d",0);
	soundsettimescalefactor("explo_3_3d",0);
	soundsettimescalefactor("explo_4_3d",0);
	soundsettimescalefactor("explo_5_3d",0);
	soundsettimescalefactor("explo_lfe_3d",0);
	soundsettimescalefactor("vehicle_air_loops_3d_lim",0);
	soundsettimescalefactor("projectile_loop_close",0);
	soundsettimescalefactor("projectile_loop_mid",0);
	soundsettimescalefactor("projectile_loop_dist",0);
}

//Function Number: 81
func_F22F(param_00)
{
	wait(param_00);
	level notify("game_ended_frozen");
}

//Function Number: 82
func_E2A9()
{
	setomnvarforallclients("post_game_state",0);
	level notify("restarting");
	game["state"] = "playing";
	map_restart(1);
}

//Function Number: 83
endgame(param_00,param_01,param_02)
{
	if(isdefined(level.endgame))
	{
		[[ level.endgame ]](param_00,param_01);
		return;
	}

	func_6322(param_00,param_01,param_02);
}

//Function Number: 84
func_6322(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(level.var_7669)
	{
		return;
	}

	if(game["roundsPlayed"] < 24)
	{
		setmatchdata("utcRoundEndTimeSeconds",game["roundsPlayed"],function_00D2());
	}

	scripts\mp\_matchdata::func_C557();
	var_03 = 0;
	if(level.var_90A1 || level.var_72B3)
	{
		var_03 = 1;
	}

	if(scripts\mp\_utility::func_9900())
	{
		if(game["overtimeRoundsPlayed"] == 0)
		{
			setmatchdata("firstOvertimeRoundIndex",game["roundsPlayed"]);
		}

		if(!var_03)
		{
			game["overtimeRoundsPlayed"]++;
		}
	}

	if(level.teambased)
	{
		if(param_00 == "axis" || param_00 == "allies")
		{
			if(!var_03)
			{
				game["roundsWon"][param_00]++;
			}

			if(!isdefined(level.var_6C6F))
			{
				level.var_6C6F = param_00;
			}
		}
		else if(!isdefined(level.var_6C6F))
		{
			level.var_6C6F = "none";
		}

		scripts\mp\_gamescore::func_12F3B("axis");
		scripts\mp\_gamescore::func_12F3B("allies");
		if(scripts\mp\_utility::func_9F32() && game["roundsPlayed"] < 24 && level.gametype != "koth")
		{
			setmatchdata("alliesRoundScore",game["roundsPlayed"],getteamscore("allies"));
			setmatchdata("axisRoundScore",game["roundsPlayed"],getteamscore("axis"));
		}
	}
	else
	{
		if(isdefined(param_00) && isplayer(param_00) && !var_03)
		{
			game["roundsWon"][param_00.var_86BD]++;
		}

		if(!isdefined(level.var_6C6F))
		{
			if(isstring(param_00) && param_00 == "tie")
			{
				level.var_6C6F = "none";
			}
			else
			{
				level.var_6C6F = param_00.var_86BD;
			}
		}
	}

	scripts\mp\_gamescore::func_12EEC();
	if(!var_03)
	{
		game["roundsPlayed"]++;
	}

	level.var_D4ED = scripts\mp\_utility::func_1004B();
	if(scripts\mp\_utility::func_BFA7())
	{
		game["finalRound"] = 1;
	}

	if(scripts\mp\_utility::func_13916())
	{
		param_00 = checkmodeoverridetie(param_00);
	}

	var_04 = func_6321(param_00,param_01,param_02);
	if(var_04 && scripts\mp\_utility::func_13916())
	{
		func_6320(param_00,param_01,param_02);
	}
}

//Function Number: 85
checkmodeoverridetie(param_00)
{
	if(level.gametype == "ctf" && param_00 == "tie" && !level.var_13D8D)
	{
		scripts\mp\_gamescore::func_12F4A("axis");
		scripts\mp\_gamescore::func_12F4A("allies");
		var_01 = getteamscore("allies");
		var_02 = getteamscore("axis");
		if(var_01 != var_02)
		{
			param_00 = scripts\common\utility::func_116D7(var_01 > var_02,"allies","axis");
		}
	}

	return param_00;
}

//Function Number: 86
func_6323()
{
	if(isdefined(level.var_6C6F))
	{
		level.var_6C6C[level.var_6C6F] = scripts\mp\_utility::func_810C();
		level notify("game_cleanup");
		level waittill("final_killcam_done");
	}
}

//Function Number: 87
func_6321(param_00,param_01,param_02)
{
	level.var_766B = gettime();
	level.var_7669 = 1;
	level.ingraceperiod = 0;
	level.var_5828 = 0;
	if(getdvarint("scr_eom_combat"))
	{
		if(scripts\mp\_utility::func_13916())
		{
			level.var_5828 = 1;
		}
	}

	scripts\common\utility::func_136F7();
	scripts\mp\_gamescore::func_12EEC();
	level.var_DDEE = 0;
	level.ignorescoring = 1;
	level.var_561D = 1;
	scripts\mp\_final_killcam::preloadfinalkillcam();
	if(scripts\mp\_utility::func_13916())
	{
		level notify("round_end_music",param_00);
	}

	if(level.var_5828)
	{
		setomnvarforallclients("post_game_state",1);
		setomnvarforallclients("post_game_state",2);
		foreach(var_04 in level.players)
		{
			if(level.teambased)
			{
				var_04 thread scripts\mp\_hud_message::func_115DD(param_00,0,param_01);
				continue;
			}

			var_04 thread scripts\mp\_hud_message::func_C752(param_00,param_01);
		}

		func_7384(3,"cg_fovScale",1,1);
		scripts\mp\_hostmigration::func_13708(3);
		game["state"] = "postgame";
		level notify("game_ended",param_00);
		scripts\mp\_utility::func_ABF4("game_over");
		scripts\mp\_utility::func_ABF4("block_notifies");
		scripts\common\utility::func_136F7();
		foreach(var_04 in level.players)
		{
			var_04 setclientdvar("ui_opensummary",1);
			if(scripts\mp\_utility::func_13918() || scripts\mp\_utility::func_13916())
			{
				var_04 scripts\mp\killstreaks\_killstreaks::func_41C0();
			}
		}
	}
	else
	{
		setomnvarforallclients("post_game_state",1);
		game["state"] = "postgame";
		level notify("game_ended",param_01);
		scripts\mp\_utility::func_ABF4("game_over");
		scripts\mp\_utility::func_ABF4("block_notifies");
		scripts\common\utility::func_136F7();
		foreach(var_04 in level.players)
		{
			var_04 setclientdvar("ui_opensummary",1);
			if(scripts\mp\_utility::func_13918() || scripts\mp\_utility::func_13916())
			{
				var_04 scripts\mp\killstreaks\_killstreaks::func_41C0();
			}
		}

		func_7384(1,"cg_fovScale",1,0);
	}

	function_01AF(0);
	thread scripts\mp\_analyticslog::func_AFB1();
	scripts\mp\_playerlogic::func_D919();
	if(scripts\mp\_analyticslog::func_1E6A())
	{
		scripts\mp\_analyticslog::func_1E6B();
	}

	if(isdefined(level.var_B3F0))
	{
		[[ level.var_B3F0 ]]();
	}

	func_DCD3(param_00);
	setdvar("g_deadChat",1);
	setdvar("ui_allow_teamchange",0);
	setdvar("bg_compassShowEnemies",0);
	func_56E0(param_00,param_01);
	if(!scripts\mp\_utility::func_13916())
	{
		level notify("round_win",param_00);
		func_E761(level.var_E75F,1);
	}
	else
	{
		func_E761(0,1);
	}

	func_6323();
	setslowmotion(1,1,0);
	func_E26E();
	if(level.teambased)
	{
		scripts\mp\_gamescore::func_12F4A("axis");
		scripts\mp\_gamescore::func_12F4A("allies");
	}

	if(!scripts\mp\_utility::func_13918() && !param_02)
	{
		if(!scripts\mp\_utility::func_13916())
		{
			if(level.var_D4ED)
			{
				param_00 = "overtime";
				game["status"] = "overtime";
			}

			scripts\mp\_utility::func_ABF1("block_notifies");
			if(func_3E43(level.var_D4ED))
			{
				func_56E1();
			}

			foreach(var_04 in level.players)
			{
				var_04.pers["stats"] = var_04.var_10E53;
			}

			func_E2A9();
			return 0;
		}

		if(!level.var_72B3)
		{
			var_04 = func_12F07(param_02);
		}
	}

	return 1;
}

//Function Number: 88
func_6320(param_00,param_01,param_02)
{
	if(!scripts\mp\_utility::func_9FB3(level.processedwinloss) && scripts\mp\_utility::func_9FB3(level.var_72F2) || level.var_72B3)
	{
		func_12F65(param_00);
	}

	scripts\mp\_missions::func_E75D(param_00);
	scripts\mp\_intel::updatemissionteamperformancestats();
	func_3E16();
	func_12F23();
	scripts\mp\_persistence::func_13E03();
	level notify("stop_leaderboard_stats");
	updateleaderboardstats();
	level.var_58D7 = scripts\mp\_broshot::func_97E0(param_00);
	if(!level.var_58D7)
	{
		level notify("spawning_intermission");
		foreach(var_04 in level.players)
		{
			var_04 thread scripts\mp\_utility::func_F8A0(0);
			var_04 thread scripts\mp\_playerlogic::func_108DD();
		}
	}

	if(scripts\mp\_utility::func_9FB3(param_02) && !scripts\mp\_utility::func_9FB3(level.var_C1B2))
	{
		scripts\mp\_utility::func_144F(level.var_C1D0,0);
		function_0235("",0.75);
	}
	else
	{
		scripts\mp\_utility::func_144F("",0);
		function_0235("",0.75);
	}

	func_56DA(param_00,param_01);
	scripts\mp\_utility::func_ABF1("block_notifies");
	level.var_18F = 1;
	if(!level.var_58D7)
	{
		setomnvarforallclients("post_game_state",4);
		func_E761(level.var_D706,1);
	}

	func_D9AA();
	if(level.var_58D7)
	{
		setomnvarforallclients("post_game_state",6);
		wait(0.1);
		var_06 = scripts\mp\_broshot::func_10D73(param_00);
		var_07 = undefined;
		foreach(var_04 in level.players)
		{
			if(var_04 ishost())
			{
				var_07 = var_04;
				break;
			}
		}

		if(isdefined(var_07))
		{
			var_07 scripts\common\utility::waittill_notify_or_timeout("dev_skip_broshot",var_06);
		}
		else
		{
			wait(var_06);
		}

		scripts\mp\_broshot::func_6311();
	}

	if(level.teambased)
	{
		if(param_00 == "axis" || param_00 == "allies")
		{
			setmatchdata("victor",param_00);
		}
		else
		{
			setmatchdata("victor","none");
		}

		setmatchdata("alliesScore",getteamscore("allies"));
		setmatchdata("axisScore",getteamscore("axis"));
	}
	else
	{
		setmatchdata("victor","none");
	}

	foreach(var_04 in level.players)
	{
		var_04 setplayerdata("common","round","endReasonTextIndex",param_01);
		if(var_04 scripts\mp\_utility::func_DCD5())
		{
			var_04 scripts\mp\_matchdata::func_AFB9();
		}

		if(isalive(var_04) && isdefined(var_04.var_B3E3))
		{
			var_04 scripts\mp\_matchdata::logxpscoreearnedinlife(var_04.var_B3E3);
		}

		if(level.teambased)
		{
			if(param_00 == "axis" || param_00 == "allies")
			{
				if(isdefined(var_04.team))
				{
					if(var_04.team == param_00)
					{
						var_04 method_859C(var_04.var_41F0,"win");
					}
					else
					{
						var_04 method_859C(var_04.var_41F0,"loss");
					}
				}
				else
				{
					var_04 method_859C(var_04.var_41F0,"none");
				}
			}
			else if(getteamscore("allies") == getteamscore("axis"))
			{
				var_04 method_859C(var_04.var_41F0,"draw");
			}
			else
			{
				var_04 method_859C(var_04.var_41F0,"none");
			}

			continue;
		}

		if(isplayer(param_00) && param_00.var_41F0 == var_04.var_41F0)
		{
			var_04 method_859C(var_04.var_41F0,"win");
			continue;
		}

		var_04 method_859C(var_04.var_41F0,"loss");
	}

	setmatchdata("host",level.var_90AE);
	if(scripts\mp\_utility::func_B3EC())
	{
		setmatchdata("playlistVersion",function_00C2());
		setmatchdata("playlistID",function_00C1());
		setmatchdata("isDedicated",function_0103());
	}

	sendmatchdata();
	foreach(var_04 in level.players)
	{
		var_04.pers["stats"] = var_04.var_10E53;
	}

	if(!param_02 && !level.var_D701)
	{
		if(!level.var_58D7)
		{
			if(!scripts\mp\_utility::func_13918())
			{
				wait(6);
			}
			else
			{
				wait(min(5,4 + level.var_D701));
			}
		}
	}
	else
	{
		wait(min(10,4 + level.var_D701));
	}

	if(function_0303())
	{
		for(var_0E = getgamebattlematchreportstate();var_0E != 3 && var_0E != 4;var_0E = getgamebattlematchreportstate())
		{
			wait(1);
		}

		setomnvarforallclients("post_game_state",5);
		wait(5);
	}

	setomnvarforallclients("post_game_state",1);
	scripts\mp\_utility::func_ABF6("post_game_level_event_active");
	function_01BC(0);
	function_01BD(0);
	level notify("exitLevel_called");
	exitlevel(0);
}

//Function Number: 89
func_12F07(param_00)
{
	if(!level.teambased)
	{
		return 1;
	}

	if(scripts\mp\_utility::func_9EA9())
	{
		if(scripts\mp\_utility::func_9044())
		{
			return game["end_reason"]["score_limit_reached"];
		}

		if(scripts\mp\_utility::func_9049())
		{
			return game["end_reason"]["time_limit_reached"];
		}
	}
	else if(scripts\mp\_utility::func_9041())
	{
		return game["end_reason"]["round_limit_reached"];
	}

	if(scripts\mp\_utility::func_904A())
	{
		return game["end_reason"]["score_limit_reached"];
	}

	return game["end_reason"]["objective_completed"];
}

//Function Number: 90
func_6747(param_00)
{
	if(!scripts\mp\_utility::func_9EA9())
	{
		var_01 = func_8106(param_00);
		var_02 = func_8108(param_00);
		var_03 = 999999;
		if(var_01)
		{
			var_03 = var_02 / var_01;
		}

		return var_03;
	}

	var_01 = func_8106(var_03);
	var_02 = func_8106(var_02);
	var_03 = 999999;
	if(var_01)
	{
		var_03 = var_02 / var_01;
	}

	return var_03;
}

//Function Number: 91
func_42AC(param_00)
{
	var_01 = 10;
	var_02 = 20;
	if(level.gametype == "tdef")
	{
		var_01 = 20;
	}

	if(level.gametype == "dom")
	{
		var_02 = 20;
	}

	var_03 = level.var_E763;
	var_04 = getteamscore(param_00);
	var_05 = var_03 - var_04;
	if(var_05 <= scripts\common\utility::func_116D7(scripts\mp\_utility::func_9FB3(game["finalRound"]),var_02,var_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 92
func_8106(param_00)
{
	var_01 = scripts\mp\_utility::func_81CB() / -5536 + 0.0001;
	if(isplayer(self))
	{
		var_02 = self.var_278 / var_01;
	}
	else
	{
		var_02 = getteamscore(var_01) / var_02;
	}

	return var_02;
}

//Function Number: 93
func_8108(param_00)
{
	var_01 = level.var_E763;
	if(isplayer(self))
	{
		var_02 = var_01 - self.var_278;
	}
	else
	{
		var_02 = var_02 - getteamscore(var_01);
	}

	return var_02;
}

//Function Number: 94
func_8107(param_00)
{
	var_01 = level.var_E763;
	if(!game["switchedsides"])
	{
		var_01 = var_01 / 2;
		var_02 = scripts\mp\_utility::func_81CB() / -5536 + 0.0001;
		var_03 = getteamscore(param_00) / var_02;
	}
	else
	{
		var_03 = int(var_03 / 2);
		var_02 = scripts\mp\_utility::func_81CB() / -5536 + 0.0001;
		var_04 = getteamscore(var_01);
		if(var_04 >= var_01)
		{
			var_03 = var_04 - var_01 / var_02;
		}
		else
		{
			return 0;
		}
	}

	return var_03;
}

//Function Number: 95
func_8378()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	scripts\mp\_utility::func_1383E(3);
	thread scripts\mp\_utility::func_115DE("callout_lastteammemberalive",self,self.pers["team"]);
	foreach(var_01 in level.teamnamelist)
	{
		if(self.pers["team"] != var_01)
		{
			thread scripts\mp\_utility::func_115DE("callout_lastenemyalive",self,var_01);
		}
	}

	scripts\mp\_music_and_dialog::func_C54B(self);
}

//Function Number: 96
func_D9AA()
{
	var_00 = 0;
	foreach(var_02 in level.players)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		var_02.var_41F4 = var_00;
		var_00++;
		if(level.var_DADB && var_02.name.size > level.var_B4B3)
		{
			var_03 = "";
			for(var_04 = 0;var_04 < level.var_B4B3 - 3;var_04++)
			{
				var_03 = var_03 + var_02.name[var_04];
			}

			var_03 = var_03 + "...";
		}
		else
		{
			var_03 = var_02.name;
		}

		setclientmatchdata("players",var_02.var_41F4,"username",var_03);
		setclientmatchdata("players",var_02.var_41F4,"clanTag",var_02 method_8567());
		setclientmatchdata("players",var_02.var_41F4,"xuidHigh",var_02 method_8565());
		setclientmatchdata("players",var_02.var_41F4,"xuidLow",var_02 method_8566());
		setclientmatchdata("players",var_02.var_41F4,"isBot",isbot(var_02));
		setclientmatchdata("players",var_02.var_41F4,"uniqueClientId",var_02.var_41F0);
		var_02 setplayerdata("common","round","clientMatchIndex",var_02.var_41F4);
	}

	scripts\mp\_scoreboard::func_D9AB();
	function_01A3();
	if(scripts\mp\_codcasterclientmatchdata::func_10036())
	{
		thread scripts\mp\_codcasterclientmatchdata::func_F22C();
	}
}

//Function Number: 97
func_11AF7(param_00,param_01)
{
	thread func_117B7(param_00,1,"deaths");
}

//Function Number: 98
func_11AC8(param_00,param_01)
{
	if(isdefined(self) && isplayer(self))
	{
		if(param_01 != "MOD_FALLING")
		{
			if(param_01 == "MOD_MELEE" && issubstr(param_00,"tactical"))
			{
				scripts\mp\_matchdata::func_AF94("tactical","kills",1);
				scripts\mp\_matchdata::func_AF94("tactical","hits",1);
				scripts\mp\_persistence::func_93F9("tactical","kills",1);
				scripts\mp\_persistence::func_93F9("tactical","hits",1);
				return;
			}

			if(param_01 == "MOD_MELEE" && !scripts\mp\_weapons::func_9F2D(param_00) && !scripts\mp\_weapons::func_9E6D(param_00) && !scripts\mp\_weapons::isaxeweapon(param_00))
			{
				scripts\mp\_matchdata::func_AF94("none","kills",1);
				scripts\mp\_matchdata::func_AF94("none","hits",1);
				scripts\mp\_persistence::func_93F9("none","kills",1);
				scripts\mp\_persistence::func_93F9("none","hits",1);
				return;
			}

			thread func_117B7(param_00,1,"kills");
		}

		if(param_01 == "MOD_HEAD_SHOT")
		{
			thread func_117B7(param_00,1,"headShots");
		}
	}
}

//Function Number: 99
func_FB1D(param_00,param_01,param_02)
{
	if(!param_01)
	{
		return;
	}

	var_03 = scripts\mp\_utility::func_8225(param_00);
	var_04 = function_02C4(param_00);
	if(var_03 == "killstreak" || var_03 == "other" && param_00 != "trophy_mp" || var_03 == "other" && param_00 != "player_trophy_system_mp" || var_03 == "other" && param_00 != "super_trophy_mp")
	{
		return;
	}

	if(scripts\mp\_utility::func_9DE2(param_00))
	{
		return;
	}

	if(var_03 == "weapon_grenade" || var_03 == "weapon_explosive" || param_00 == "trophy_mp" || param_00 == "adrenaline_mist_mp" || param_00 == "domeshield_mp" || param_00 == "copycat_grenade_mp" || param_00 == "speed_strip_mp" || param_00 == "forcepush_mp" || param_00 == "portal_generator_mp")
	{
		var_05 = scripts\mp\_utility::strip_suffix(param_00,"_mp");
		scripts\mp\_persistence::func_93FC(var_05,param_02,param_01);
		scripts\mp\_matchdata::func_AFDC(var_05,param_02,param_01,var_04);
		return;
	}

	if(!isdefined(self.var_11AF0))
	{
		self.var_11AF0 = param_01;
	}

	if(param_01 != self.var_11AF0)
	{
		scripts\mp\_persistence::func_12F5E();
		self.var_11AF0 = param_01;
	}

	switch(var_03)
	{
		case "shots":
			self.var_11AF1++;
			break;

		case "hits":
			self.var_11AEE++;
			break;

		case "headShots":
			self.var_11AED++;
			break;

		case "kills":
			self.var_11AEF++;
			break;
	}

	if(var_03 == "deaths")
	{
		var_06 = undefined;
		var_07 = scripts\mp\_utility::func_8234(param_01);
		if(!scripts\mp\_utility::func_9D78(var_07) && !scripts\mp\_utility::func_9D79(var_07))
		{
			return;
		}

		var_08 = scripts\mp\_utility::func_821A(param_01);
		scripts\mp\_persistence::func_93FC(var_07,var_03,param_02);
		scripts\mp\_matchdata::func_AFDC(var_07,"deaths",param_02,var_05);
		foreach(var_0A in var_08)
		{
			scripts\mp\_persistence::func_93F9(var_0A,var_03,param_02);
			scripts\mp\_matchdata::func_AF94(var_0A,var_03,param_02);
		}
	}
}

//Function Number: 100
func_F759(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_01 func_FB1D(param_02,1,"hits");
		return;
	}

	if(!isdefined(param_00.var_D35E))
	{
		param_00.var_D35E = [];
	}

	var_03 = 1;
	for(var_04 = 0;var_04 < param_00.var_D35E.size;var_04++)
	{
		if(param_00.var_D35E[var_04] == self)
		{
			var_03 = 0;
			break;
		}
	}

	if(var_03)
	{
		param_00.var_D35E[param_00.var_D35E.size] = self;
		param_01 func_FB1D(param_02,1,"hits");
	}
}

//Function Number: 101
func_117B7(param_00,param_01,param_02)
{
	self endon("disconnect");
	waittillframeend;
	func_FB1D(param_00,param_01,param_02);
}

//Function Number: 102
func_12F23()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 scripts\mp\_utility::func_DCD5())
		{
			var_02 = getmatchspm(var_01);
			var_03 = var_01 getplayerdata("mp","globalSPM");
			var_04 = var_01 getplayerdata("mp","gamesPlayed");
			var_05 = var_01 getplayerdata("mp","dlcEggStatus");
			if(var_05 > 0)
			{
				var_04 = int(max(var_04 - var_05,1));
			}

			var_03 = var_03 * var_04 - 1;
			var_06 = var_02;
			if(var_04 > 0)
			{
				var_06 = var_03 + var_02 / var_04;
			}

			var_01 setplayerdata("mp","globalSPM",int(var_06));
			var_07 = function_009F(level.gametype);
			if(var_07 >= 0 && var_07 < level.var_B4A0)
			{
				var_08 = var_01 getplayerdata("mp","gameModeScoreHistory",var_07,"index");
				var_01 setplayerdata("mp","gameModeScoreHistory",var_07,"scores",var_08,int(var_02));
				var_08 = var_08 + 1 % level.var_B4A1;
				var_01 setplayerdata("mp","gameModeScoreHistory",var_07,"index",var_08);
			}
		}
	}
}

//Function Number: 103
func_3E16()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 scripts\mp\_utility::func_DCD5())
		{
			var_02 = var_01 getplayerdata("common","round","kills");
			var_03 = var_01 getplayerdata("common","round","deaths");
			var_04 = var_01.pers["summary"]["xp"];
			var_05 = var_01 getplayerdata("mp","bestKills");
			var_06 = var_01 getplayerdata("mp","mostDeaths");
			var_07 = var_01 getplayerdata("mp","mostXp");
			var_08 = var_01 getplayerdata("mp","bestSPM","score");
			var_09 = var_01 getplayerdata("mp","bestKD","score");
			if(var_02 > var_05)
			{
				var_01 setplayerdata("mp","bestKills",var_02);
			}

			if(var_04 > var_07)
			{
				var_01 setplayerdata("mp","mostXp",var_04);
			}

			if(var_03 > var_06)
			{
				var_01 setplayerdata("mp","mostDeaths",var_03);
			}

			var_0A = var_02;
			if(var_03 > 1)
			{
				var_0A = var_0A / var_03;
			}

			var_0A = int(var_0A * 1000);
			if(var_0A > var_09)
			{
				var_01 setplayerdata("mp","bestKD","score",var_0A);
				var_01 setplayerdata("mp","bestKD","time",function_00D2());
			}

			var_0B = getmatchspm(var_01);
			if(var_0B > var_08)
			{
				var_01 setplayerdata("mp","bestSPM","score",int(var_0B));
				var_01 setplayerdata("mp","bestSPM","time",function_00D2());
			}

			var_01 func_3E0C();
			var_01 scripts\mp\_matchdata::func_AFD7(var_04,"totalXp");
			var_01 scripts\mp\_matchdata::func_AFD7(var_01.pers["summary"]["score"],"scoreXp");
			var_01 scripts\mp\_matchdata::func_AFD7(var_01.pers["summary"]["challenge"],"challengeXp");
			var_01 scripts\mp\_matchdata::func_AFD7(var_01.pers["summary"]["match"],"matchXp");
			var_01 scripts\mp\_matchdata::func_AFD7(var_01.pers["summary"]["misc"],"miscXp");
			var_01 scripts\mp\_matchdata::func_AFD7(var_01.pers["summary"]["medal"],"medalXp");
			var_01 scripts\mp\_matchdata::func_AFD7(var_01.pers["summary"]["bonusXP"],"bonusXp");
		}

		if(isdefined(var_01.pers["confirmed"]))
		{
			var_01 scripts\mp\_matchdata::func_AFC6();
		}

		if(isdefined(var_01.pers["denied"]))
		{
			var_01 scripts\mp\_matchdata::func_AFC7();
		}
	}
}

//Function Number: 104
updateleaderboardstatscontinuous()
{
	level endon("game_ended");
	level endon("stop_leaderboard_stats");
	var_00 = 0;
	for(;;)
	{
		while(!isdefined(level.players) || level.players.size == 0)
		{
			scripts\common\utility::func_136F7();
		}

		if(var_00 >= level.players.size)
		{
			var_00 = 0;
		}

		var_01 = level.players[var_00];
		if(!isdefined(var_01) || isai(var_01))
		{
			scripts\common\utility::func_136F7();
		}
		else
		{
			if(var_01 scripts\mp\_utility::func_DCD5())
			{
				var_01 updateplayerleaderboardstats();
			}

			wait(0.1);
		}

		var_00++;
	}
}

//Function Number: 105
updateleaderboardstats()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01) || isai(var_01))
		{
			continue;
		}

		if(var_01 scripts\mp\_utility::func_DCD5())
		{
			var_01 updateplayerleaderboardstats();
		}
	}
}

//Function Number: 106
updateplayerleaderboardstats()
{
	var_00 = undefined;
	if(level.var_8B38)
	{
		var_00 = "hc";
	}
	else
	{
		var_00 = "";
	}

	var_00 = var_00 + level.gametype;
	var_01 = scripts\common\utility::func_116D7(level.teambased,self.var_278,self.pers["gamemodeScore"]);
	incrementleaderboardstat(var_00 + "Score",var_01);
	var_02 = scripts\mp\_persistence::func_10E36("round","timePlayed",0);
	incrementleaderboardstat(var_00 + "TimePlayed",var_02);
	incrementleaderboardstat(var_00 + "Kills",self.pers["kills"]);
	incrementleaderboardstat(var_00 + "Deaths",self.pers["deaths"]);
	switch(level.gametype)
	{
		case "war":
			incrementleaderboardstat(var_00 + "Assists",self.pers["assists"]);
			break;

		case "front":
			incrementleaderboardstat(var_00 + "Assists",self.pers["assists"]);
			break;

		case "dm":
			updateleaderboardstatmaximum(var_00 + "Streak",self.pers["killChains"]);
			break;

		case "dom":
			incrementleaderboardstat(var_00 + "Captures",self.pers["captures"]);
			incrementleaderboardstat(var_00 + "Defends",self.pers["defends"]);
			break;

		case "sd":
			incrementleaderboardstat(var_00 + "Plants",self.pers["plants"]);
			incrementleaderboardstat(var_00 + "Defuses",self.pers["defuses"]);
			break;

		case "conf":
			incrementleaderboardstat(var_00 + "Confirms",self.pers["confirmed"]);
			incrementleaderboardstat(var_00 + "Denies",self.pers["denied"]);
			break;

		case "koth":
			incrementleaderboardstat(var_00 + "ObjTime",self.pers["objTime"]);
			incrementleaderboardstat(var_00 + "Defends",self.pers["defends"]);
			break;

		case "tdef":
			incrementleaderboardstat(var_00 + "ObjTime",self.pers["objTime"]);
			incrementleaderboardstat(var_00 + "Captures",self.pers["defends"]);
			break;

		case "ball":
			incrementleaderboardstat(var_00 + "Throws",self.pers["fieldgoals"]);
			incrementleaderboardstat(var_00 + "Carries",self.pers["touchdowns"]);
			break;

		case "ctf":
			incrementleaderboardstat(var_00 + "Captures",self.pers["captures"]);
			incrementleaderboardstat(var_00 + "Returns",self.pers["returns"]);
			break;

		case "sr":
			incrementleaderboardstat(var_00 + "Plants",self.pers["plants"]);
			incrementleaderboardstat(var_00 + "Rescues",self.pers["rescues"]);
			break;

		case "siege":
			incrementleaderboardstat(var_00 + "Captures",self.pers["captures"]);
			incrementleaderboardstat(var_00 + "Revives",self.pers["rescues"]);
			break;

		case "grind":
			incrementleaderboardstat(var_00 + "Banks",self.pers["confirmed"]);
			incrementleaderboardstat(var_00 + "Denies",self.pers["denied"]);
			break;

		case "infect":
			incrementleaderboardstat(var_00 + "Time",scripts\mp\_utility::getpersstat("extrascore0"));
			incrementleaderboardstat(var_00 + "Infected",self.pers["killsAsInfected"]);
			break;

		case "gun":
			incrementleaderboardstat(var_00 + "Stabs",self.pers["stabs"]);
			incrementleaderboardstat(var_00 + "SetBacks",self.pers["setbacks"]);
			break;

		case "grnd":
			incrementleaderboardstat(var_00 + "ObjTime",self.pers["objTime"]);
			incrementleaderboardstat(var_00 + "Defends",self.pers["defends"]);
			break;
	}
}

//Function Number: 107
incrementleaderboardstat(param_00,param_01)
{
	if(!isdefined(self.leaderboardstartvalues))
	{
		self.leaderboardstartvalues = [];
	}

	if(!isdefined(self.leaderboardstartvalues[param_00]))
	{
		self.leaderboardstartvalues[param_00] = self getplayerdata("mp","leaderBoardData",param_00);
	}

	var_02 = int(max(self.leaderboardstartvalues[param_00] + param_01,self.leaderboardstartvalues[param_00]));
	self setplayerdata("mp","leaderBoardData",param_00,var_02);
}

//Function Number: 108
updateleaderboardstatmaximum(param_00,param_01)
{
	var_02 = self getplayerdata("mp","leaderBoardData",param_00);
	if(param_01 > var_02)
	{
		self setplayerdata("mp","leaderBoardData",param_00,param_01);
	}
}

//Function Number: 109
getmatchspm(param_00)
{
	var_01 = scripts\common\utility::func_116D7(level.teambased,param_00.var_278,param_00.pers["gamemodeScore"]);
	var_02 = param_00 scripts\mp\_persistence::func_10E36("round","timePlayed",0);
	if(isdefined(var_02) && var_02 > 0)
	{
		var_03 = var_02 / 60;
		var_01 = var_01 / var_03;
	}

	return var_01;
}

//Function Number: 110
func_9FD2(param_00)
{
	var_01 = scripts\mp\_utility::func_8225(param_00);
	return isdefined(param_00) && param_00 != "" && !scripts\mp\_utility::func_9E6C(param_00) && var_01 != "killstreak" && var_01 != "other";
}

//Function Number: 111
func_3E0C()
{
	var_00 = scripts\mp\_matchdata::func_322A();
	var_01 = "";
	var_02 = -1;
	for(var_03 = 0;var_03 < var_00.size;var_03++)
	{
		var_04 = var_00[var_03];
		var_04 = scripts\mp\_utility::func_8234(var_04);
		if(func_9FD2(var_04))
		{
			var_05 = self getplayerdata("mp","weaponStats",var_04,"kills");
			if(var_05 > var_02)
			{
				var_01 = var_04;
				var_02 = var_05;
			}
		}
	}

	var_06 = self getplayerdata("mp","weaponStats",var_01,"shots");
	var_07 = self getplayerdata("mp","weaponStats",var_01,"headShots");
	var_08 = self getplayerdata("mp","weaponStats",var_01,"hits");
	var_09 = self getplayerdata("mp","weaponStats",var_01,"deaths");
	var_0A = 0;
	self setplayerdata("mp","bestWeapon","kills",var_02);
	self setplayerdata("mp","bestWeapon","shots",var_06);
	self setplayerdata("mp","bestWeapon","headShots",var_07);
	self setplayerdata("mp","bestWeapon","hits",var_08);
	self setplayerdata("mp","bestWeapon","deaths",var_09);
	self setplayerdata("mp","bestWeaponXP",var_0A);
	var_0B = int(tablelookup("mp/statstable.csv",4,var_01,0));
	self setplayerdata("mp","bestWeaponIndex",var_0B);
}

//Function Number: 112
func_1C73(param_00)
{
	self notify("allow_weapon_mp()");
	if(param_00)
	{
		if(isdefined(self.var_1CB2) && !self hasweapon(self.var_1CB2))
		{
			scripts\mp\_utility::func_1136C(self.var_A978);
		}

		self.var_1CB2 = undefined;
		return;
	}

	self.var_1CB2 = self getcurrentprimaryweapon();
	thread func_13AAA();
}

//Function Number: 113
func_1C74()
{
	level.var_1C73 = ::func_1C73;
}

//Function Number: 114
func_13AAA()
{
	self endon("death");
	self endon("disconnect");
	self endon("allow_weapon_mp()");
	for(;;)
	{
		self waittill("weapon_switch_invalid",var_00);
		self.var_1CB2 = var_00;
	}
}

//Function Number: 115
ismp_init()
{
	level.ismp = 1;
}