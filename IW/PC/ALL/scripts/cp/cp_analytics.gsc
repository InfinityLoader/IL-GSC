/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_analytics.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 44
 * Decompile Time: 2093 ms
 * Timestamp: 10/27/2023 12:09:16 AM
*******************************************************************/

//Function Number: 1
func_10C5A(param_00,param_01,param_02)
{
	init(param_02);
	func_9679(param_00,param_01);
}

//Function Number: 2
func_9679(param_00,param_01)
{
	setmatchdatadef(param_00);
	function_01A9(param_01);
	setmatchdata("commonMatchData","map",level.script);
	setmatchdata("commonMatchData","gametype",getdvar("ui_gametype"));
	setmatchdata("commonMatchData","buildVersion",function_007F());
	setmatchdata("commonMatchData","buildNumber",function_007E());
	setmatchdata("commonMatchData","utcStartTimeSeconds",function_00D2());
	setmatchdata("commonMatchData","isPrivateMatch",getdvarint("xblive_privatematch"));
	setmatchdata("commonMatchData","isRankedMatch",1);
	setmatchdataid();
	level thread func_13663();
}

//Function Number: 3
init(param_00)
{
	var_01 = spawnstruct();
	var_02 = [];
	var_01.var_1020C = var_02;
	var_03 = [];
	var_01.var_3C1F = var_03;
	level.var_13F0B = var_01;
	func_94FA(param_00);
	level.player_count = 0;
	level.player_count_left = 0;
}

//Function Number: 4
func_13663()
{
	level endon("gameEnded");
	level waittill("prematch_done");
	setmatchdata("commonMatchData","playerCountStart",func_13134(level.players.size));
}

//Function Number: 5
func_C4B8()
{
	func_D0F6();
	set_player_count();
	func_F5AC();
	func_F443();
	setmatchdata("players",self.var_41F0,"playerID","xuid",scripts\cp\_utility::func_81EC());
	setmatchdata("players",self.var_41F0,"gamertag",self.name);
	setmatchdata("players",self.var_41F0,"waveStart",level.wave_num);
	setmatchdata("players",self.var_41F0,"quit",0);
	level.player_count = level.player_count + 1;
}

//Function Number: 6
on_player_disconnect(param_00)
{
	setmatchdata("players",self.var_41F0,"disconnectReason",param_00);
	setmatchdata("players",self.var_41F0,"quit",param_00 == "EXE_DISCONNECTED");
	set_custom_stats();
	level.player_count_left = level.player_count_left + 1;
}

//Function Number: 7
func_D0F6()
{
	var_00 = spawnstruct();
	var_01 = [];
	var_01["cashSpentOnWeapon"] = func_7C6B(0,"int");
	var_01["cashSpentOnAbility"] = func_7C6B(0,"int");
	var_01["cashSpentOnTrap"] = func_7C6B(0,"int");
	var_00.var_1020C = var_01;
	var_02 = [];
	var_02["timesDowned"] = [];
	var_02["timesRevived"] = [];
	var_02["timesBledOut"] = [];
	var_00.var_AA03 = var_02;
	self.var_13F0B = var_00;
}

//Function Number: 8
set_player_count()
{
	if(!isdefined(level.max_concurrent_player_count))
	{
		level.max_concurrent_player_count = 0;
	}

	if(level.players.size >= level.max_concurrent_player_count)
	{
		level.max_concurrent_player_count = level.players.size + 1;
	}
}

//Function Number: 9
func_F5AC()
{
	setmatchdata("players",self.var_41F0,"isSplitscreen",self issplitscreenplayer());
}

//Function Number: 10
func_F443()
{
	if(func_D84A())
	{
		setmatchdata("players",self.var_41F0,"joinInProgress",1);
	}
}

//Function Number: 11
func_D84A()
{
	if(scripts\common\utility::func_6E34("introscreen_over") && scripts\common\utility::flag("introscreen_over"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
func_12D9F(param_00,param_01)
{
	if(level.var_13F0B.var_3C1F.size > 25)
	{
		return;
	}

	var_02 = spawnstruct();
	var_02.var_3C1B = param_00;
	var_02.var_264 = param_01;
	level.var_13F0B.var_3C1F[level.var_13F0B.var_3C1F.size] = var_02;
}

//Function Number: 13
func_93C1()
{
	func_93C4("timesDowned");
}

//Function Number: 14
func_93C7()
{
	func_93C4("timesRevived");
}

//Function Number: 15
func_93BE()
{
	func_93C4("timesBledOut");
}

//Function Number: 16
func_93C4(param_00)
{
	if(!isdefined(self.var_13F0B.var_AA03[param_00][level.wave_num]))
	{
		self.var_13F0B.var_AA03[param_00][level.wave_num] = 0;
	}

	self.var_13F0B.var_AA03[param_00][level.wave_num]++;
}

//Function Number: 17
func_12E2E(param_00,param_01)
{
	switch(param_01)
	{
		case "weapon":
			self.var_13F0B.var_1020C["cashSpentOnWeapon"].var_13153 = self.var_13F0B.var_1020C["cashSpentOnWeapon"].var_13153 + param_00;
			break;

		case "ability":
			self.var_13F0B.var_1020C["cashSpentOnAbility"].var_13153 = self.var_13F0B.var_1020C["cashSpentOnAbility"].var_13153 + param_00;
			break;

		case "trap":
			self.var_13F0B.var_1020C["cashSpentOnTrap"].var_13153 = self.var_13F0B.var_1020C["cashSpentOnTrap"].var_13153 + param_00;
			break;

		default:
			break;
	}
}

//Function Number: 18
endgame(param_00,param_01)
{
	func_F3C5(param_00,param_01);
	func_13DFF();
	log_matchdata_at_game_end();
	foreach(var_04, var_03 in level.players)
	{
		scripts\cp\_persistence::increment_player_career_total_waves(var_03);
		scripts\cp\_persistence::increment_player_career_total_score(var_03);
		var_03 set_player_data(param_01);
		var_03 func_F52B();
		var_03 func_13DFD(var_03,var_04);
	}

	if(isdefined(level.var_1E5F))
	{
		[[ level.var_1E5F ]]();
	}

	sendmatchdata();
	function_01A3();
}

//Function Number: 19
set_player_data(param_00)
{
	var_01 = self getplayerdata("cp","coopCareerStats","totalGameplayTime");
	var_02 = self getplayerdata("cp","coopCareerStats","gamesPlayed");
	if(!isdefined(var_01))
	{
		var_01 = 0;
	}

	if(!isdefined(var_02))
	{
		var_02 = 0;
	}

	var_01 = var_01 + param_00 / 1000;
	var_02 = var_02 + 1;
	self setplayerdata("cp","coopCareerStats","totalGameplayTime",int(var_01));
	self setplayerdata("cp","coopCareerStats","gamesPlayed",int(var_02));
}

//Function Number: 20
func_F3C5(param_00,param_01)
{
	var_02 = "challengesCompleted";
	var_03 = level.var_13F0B;
	foreach(var_05 in var_03.var_1020C)
	{
		var_06 = func_13137(var_05.var_13153,var_05.var_13155);
	}

	foreach(var_09 in var_03.var_3C1F)
	{
	}

	setmatchdata("commonMatchData","playerCountEnd",level.players.size);
	setmatchdata("commonMatchData","utcEndTimeSeconds",function_00D2());
	setmatchdata("commonMatchData","playerCount",func_13134(level.player_count));
	setmatchdata("commonMatchData","playerCountLeft",func_13134(level.player_count_left));
	setmatchdata("playerCountMaxConcurrent",func_13134(level.max_concurrent_player_count));
}

//Function Number: 21
func_F52B()
{
	func_4642();
	func_F44C();
	func_F59E();
	set_custom_stats();
}

//Function Number: 22
get_player_matchdata(param_00,param_01)
{
	if(isdefined(level.var_B3DF["player"][self.var_41F0]) && isdefined(level.var_B3DF["player"][self.var_41F0][param_00]))
	{
		return level.var_B3DF["player"][self.var_41F0][param_00];
	}

	return param_01;
}

//Function Number: 23
set_custom_stats()
{
	var_00 = self getplayerdata("cp","coopCareerStats","totalGameplayTime");
	var_01 = self getplayerdata("cp","coopCareerStats","gamesPlayed");
	var_02 = self getplayerdata("cp","progression","playerLevel","rank");
	var_03 = self getplayerdata("cp","progression","playerLevel","prestige");
	if(isdefined(self.wave_num_when_joined))
	{
		setmatchdata("players",self.var_41F0,"waveEnd",level.wave_num - self.wave_num_when_joined);
	}
	else
	{
		setmatchdata("players",self.var_41F0,"waveEnd",level.wave_num);
	}

	setmatchdata("players",self.var_41F0,"doorsOpened",get_player_matchdata("opening_the_doors",0));
	setmatchdata("players",self.var_41F0,"moneyEarned",int(get_player_matchdata("currency_earned",0)));
	setmatchdata("players",self.var_41F0,"kills",get_player_matchdata("zombie_death",0));
	setmatchdata("players",self.var_41F0,"downs",get_player_matchdata("dropped_to_last_stand",0));
	setmatchdata("players",self.var_41F0,"revives",get_player_matchdata("revived_another_player",0));
	setmatchdata("players",self.var_41F0,"headShots",self.var_11A25);
	setmatchdata("players",self.var_41F0,"shots",self.accuracy_shots_fired);
	setmatchdata("players",self.var_41F0,"hits",self.var_154B);
	setmatchdata("players",self.var_41F0,"rank",func_13134(var_02));
	setmatchdata("players",self.var_41F0,"prestige",func_13134(var_03));
	setmatchdata("players",self.var_41F0,"totalGameplayTime",func_13135(var_00));
	setmatchdata("players",self.var_41F0,"gamesPlayed",func_13135(var_01));
}

//Function Number: 24
func_4642()
{
}

//Function Number: 25
func_F44C()
{
}

//Function Number: 26
func_F59E()
{
}

//Function Number: 27
func_13137(param_00,param_01)
{
	switch(param_01)
	{
		case "byte":
			return func_13134(param_00);

		case "short":
			return func_13136(param_00);

		case "int":
			return func_13135(param_00);

		default:
			break;
	}
}

//Function Number: 28
func_13134(param_00)
{
	return int(min(param_00,127));
}

//Function Number: 29
func_13136(param_00)
{
	return int(min(param_00,32767));
}

//Function Number: 30
func_13135(param_00)
{
	return int(min(param_00,2147483647));
}

//Function Number: 31
func_7C6B(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_13153 = param_00;
	var_02.var_13155 = param_01;
	return var_02;
}

//Function Number: 32
func_94FA(param_00)
{
	var_01 = 0;
	var_02 = 1;
	var_03 = 2;
	var_04 = 1;
	var_05 = 2;
	var_06 = 3;
	var_07 = 4;
	var_08 = 5;
	var_09 = 6;
	var_0A = 1;
	var_0B = 100;
	var_0C = 101;
	var_0D = 300;
	level.var_2B23 = [];
	level.var_B3E2 = [];
	level.var_B3E0 = [];
	level.var_B3DF = [];
	level.var_41F3 = [];
	level.var_41F2 = [];
	level.var_41F1 = [];
	for(var_0E = var_0C;var_0E <= var_0D;var_0E++)
	{
		var_0F = tablelookup(param_00,var_01,var_0E,var_04);
		if(var_0F == "")
		{
			continue;
		}

		var_10 = tablelookup(param_00,var_01,var_0E,var_05);
		if(var_10 != "")
		{
			level.var_2B23[var_0F] = var_10;
		}

		var_11 = tablelookup(param_00,var_01,var_0E,var_06);
		if(var_11 != "")
		{
			level.var_B3E0[var_0F] = var_11;
		}

		var_12 = tablelookup(param_00,var_01,var_0E,var_07);
		if(var_12 != "")
		{
			level.var_B3E2[var_0F] = [];
			level.var_B3DF[var_0F] = [];
		}

		var_13 = tablelookup(param_00,var_01,var_0E,var_08);
		if(var_13 != "")
		{
			level.var_41F2[var_0F] = var_13;
		}

		var_14 = tablelookup(param_00,var_01,var_0E,var_09);
		if(var_14 != "")
		{
			level.var_41F3[var_0F] = [];
			level.var_41F1[var_0F] = [];
		}
	}

	level.var_1E5C = [];
	for(var_0E = var_0A;var_0E <= var_0B;var_0E++)
	{
		var_15 = tablelookup(param_00,var_01,var_0E,var_02);
		if(var_15 == "")
		{
			break;
		}

		var_16 = tablelookup(param_00,var_01,var_0E,var_03);
		level.var_1E5C[var_15] = var_16;
		var_17 = strtok(var_16," ");
		foreach(var_19 in var_17)
		{
			if(isdefined(level.var_B3E2[var_19]))
			{
				level.var_B3E2[var_19][var_15] = 0;
			}

			if(isdefined(level.var_41F3[var_19]) && isdefined(level.var_41F2[var_15]))
			{
				level.var_41F3[var_19][var_15] = 0;
			}
		}
	}
}

//Function Number: 33
func_AF6A(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_7925(param_00);
	func_AF7A(param_00,var_05,param_01,param_03);
	func_AF65(param_00,var_05,param_01,param_04);
}

//Function Number: 34
log_matchdata_at_game_end()
{
	foreach(var_08, var_01 in level.var_B3DF)
	{
		foreach(var_07, var_03 in var_01)
		{
			foreach(var_06, var_05 in var_03)
			{
				if(var_08 == "match")
				{
					setmatchdata("matchData",var_06,int(var_05));
					continue;
				}

				setmatchdata("players",int(var_07),var_06,int(var_05));
			}
		}
	}
}

//Function Number: 35
func_AF60(param_00,param_01,param_02)
{
	var_03 = func_785B(param_01);
	var_04 = "analytics_cp_";
	switch(param_02.size)
	{
		case 1:
			bbprint(var_04 + param_00,var_03,param_02[0]);
			break;

		case 2:
			bbprint(var_04 + param_00,var_03,param_02[0],param_02[1]);
			break;

		case 3:
			bbprint(var_04 + param_00,var_03,param_02[0],param_02[1],param_02[2]);
			break;

		case 4:
			bbprint(var_04 + param_00,var_03,param_02[0],param_02[1],param_02[2],param_02[3]);
			break;

		case 5:
			bbprint(var_04 + param_00,var_03,param_02[0],param_02[1],param_02[2],param_02[3],param_02[4]);
			break;

		case 6:
			bbprint(var_04 + param_00,var_03,param_02[0],param_02[1],param_02[2],param_02[3],param_02[4],param_02[5]);
			break;

		case 7:
			bbprint(var_04 + param_00,var_03,param_02[0],param_02[1],param_02[2],param_02[3],param_02[4],param_02[5],param_02[6]);
			break;

		case 8:
			bbprint(var_04 + param_00,var_03,param_02[0],param_02[1],param_02[2],param_02[3],param_02[4],param_02[5],param_02[6],param_02[7]);
			break;

		case 9:
			bbprint(var_04 + param_00,var_03,param_02[0],param_02[1],param_02[2],param_02[3],param_02[4],param_02[5],param_02[6],param_02[7],param_02[8]);
			break;

		case 10:
			bbprint(var_04 + param_00,var_03,param_02[0],param_02[1],param_02[2],param_02[3],param_02[4],param_02[5],param_02[6],param_02[7],param_02[8],param_02[9]);
			break;
	}
}

//Function Number: 36
func_785B(param_00)
{
	var_01 = "";
	foreach(var_04, var_03 in param_00)
	{
		var_01 = var_01 + var_03 + " " + level.var_2B23[var_03];
		if(var_04 != param_00.size - 1)
		{
			var_01 = var_01 + " ";
		}
	}

	return var_01;
}

//Function Number: 37
func_7925(param_00)
{
	var_01 = level.var_1E5C[param_00];
	return strtok(var_01," ");
}

//Function Number: 38
func_AF7A(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	foreach(var_06 in param_01)
	{
		if(func_9C41(var_06))
		{
			var_07 = param_03[var_04];
			if(!isdefined(level.var_B3DF[var_06][var_07]))
			{
				level.var_B3DF[var_06][var_07] = level.var_B3E2[var_06];
			}

			level.var_B3DF[var_06][var_07][param_00] = level.var_B3DF[var_06][var_07][param_00] + param_02;
			var_04++;
		}
	}
}

//Function Number: 39
func_AF65(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		return;
	}

	var_04 = 0;
	if(func_9B8E(param_00))
	{
		foreach(var_06 in param_01)
		{
			if(func_9B8F(var_06))
			{
				var_07 = param_03[var_04];
				if(!isdefined(level.var_41F1[var_06][var_07]))
				{
					level.var_41F1[var_06][var_07] = level.var_41F3[var_06];
				}

				level.var_41F1[var_06][var_07][param_00] = level.var_41F1[var_06][var_07][param_00] + param_02;
				var_04++;
			}
		}
	}
}

//Function Number: 40
func_9C41(param_00)
{
	return isdefined(level.var_B3E2[param_00]);
}

//Function Number: 41
func_9B8F(param_00)
{
	return isdefined(level.var_41F3[param_00]);
}

//Function Number: 42
func_9B8E(param_00)
{
	return isdefined(level.var_41F2[param_00]);
}

//Function Number: 43
func_13DFF()
{
	setclientmatchdata("waves_survived",level.wave_num);
	setclientmatchdata("time_survived",level.var_118DB);
	setclientmatchdata("scoreboardPlayerCount",level.players.size);
	setclientmatchdata("map",level.script);
	if(isdefined(level.write_global_clientmatchdata_func))
	{
		[[ level.write_global_clientmatchdata_func ]]();
	}
}

//Function Number: 44
func_13DFD(param_00,param_01)
{
	setclientmatchdata("player",param_01,"username",param_00.name);
	setclientmatchdata("player",param_01,"rank",param_00 scripts\cp\_persistence::func_7BAA());
	if(!isdefined(param_00.var_CFC3))
	{
		return;
	}

	setclientmatchdata("player",param_01,"characterIndex",param_00.var_CFC3);
	var_02 = level.var_41F1["player"][param_00.var_41F0];
	if(isdefined(var_02))
	{
		foreach(var_05, var_04 in var_02)
		{
			setclientmatchdata("player",param_01,var_05,int(var_04));
		}
	}

	if(isdefined(level.var_6324))
	{
		[[ level.var_6324 ]](param_00,param_01);
	}
}