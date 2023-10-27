/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 878.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 18 ms
 * Timestamp: 10/27/2023 2:16:50 AM
*******************************************************************/

//Function Number: 1
func_2B78()
{
	func_2B9C();
	if(!level.placement["all"].size)
	{
		return undefined;
	}

	return level.placement["all"][0];
}

//Function Number: 2
func_2B7A()
{
	func_2B9C();
	var_00 = level.placement["all"];
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(var_03 == level.placement["all"][0])
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 3
func_2B7B(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_05 = param_01.pers["score"];
	func_2B84(param_00,param_01,param_02);
	if(var_05 == param_01.pers["score"])
	{
		return;
	}

	if(!param_01 maps\mp\_utility::rankingenabled() && !level.hardcoremode && !param_04)
	{
		param_01 thread maps\mp\gametypes\_rank::xppointspopup(param_01.pers["score"] - var_05,0,(0.85,0.85,0.85),0);
	}

	param_01 maps\mp\gametypes\_persistance::statadd("score",param_01.pers["score"] - var_05);
	param_01.score = param_01.pers["score"];
	param_01 maps\mp\gametypes\_persistance::statsetchild("round","score",param_01.score);
	if(!level.teambased)
	{
		thread func_2B99();
	}

	if(!param_03)
	{
		param_01 maps\mp\gametypes\_gamelogic::checkplayerscorelimitsoon();
	}

	var_06 = param_01 maps\mp\gametypes\_gamelogic::checkscorelimit();
}

//Function Number: 4
func_2B84(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_rank::getscoreinfovalue(param_00);
	param_01.pers["score"] = param_01.pers["score"] + var_03 * level.objectivepointsmod;
}

//Function Number: 5
func_2B86(param_00,param_01)
{
	if(param_01 == param_00.pers["score"])
	{
		return;
	}

	param_00.pers["score"] = param_01;
	param_00.score = param_00.pers["score"];
	param_00 thread maps\mp\gametypes\_gamelogic::checkscorelimit();
}

//Function Number: 6
func_2B87(param_00)
{
	return param_00.pers["score"];
}

//Function Number: 7
func_2B88(param_00,param_01)
{
	param_01 = param_01 * level.objectivepointsmod;
	var_02 = game["teamScores"][param_00];
	var_03 = level.otherteam[param_00];
	if(game["teamScores"][param_00] > game["teamScores"][var_03])
	{
		level.waswinning = param_00;
	}
	else if(game["teamScores"][var_03] > game["teamScores"][param_00])
	{
		level.waswinning = var_03;
	}

	func_2B8F(param_00,func_2B96(param_00) + param_01);
	var_04 = "none";
	if(game["teamScores"][param_00] > game["teamScores"][var_03])
	{
		var_04 = param_00;
	}
	else if(game["teamScores"][var_03] > game["teamScores"][param_00])
	{
		var_04 = var_03;
	}

	if(!level.splitscreen && var_04 != "none" && var_04 != level.waswinning && gettime() - level.laststatustime > 5000 && maps\mp\_utility::getscorelimit() != 1)
	{
		level.laststatustime = gettime();
		maps\mp\_utility::leaderdialog("lead_taken",var_04,"status");
		if(level.waswinning != "none")
		{
			maps\mp\_utility::leaderdialog("lead_lost",level.waswinning,"status");
		}
	}

	if(var_04 != "none")
	{
		level.waswinning = var_04;
	}
}

//Function Number: 8
func_2B8E()
{
	if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
	{
		return "allies";
	}
	else if(game["teamScores"]["allies"] < game["teamScores"]["axis"])
	{
		return "axis";
	}

	return "none";
}

//Function Number: 9
func_2B8F(param_00,param_01)
{
	if(param_01 == game["teamScores"][param_00])
	{
		return;
	}

	game["teamScores"][param_00] = param_01;
	func_2B93(param_00);
	if((game["status"] == "overtime" && !isdefined(level.overtimescorewinoverride)) || isdefined(level.overtimescorewinoverride) && !level.overtimescorewinoverride)
	{
		thread maps\mp\gametypes\_gamelogic::onscorelimit();
		return;
	}

	thread maps\mp\gametypes\_gamelogic::checkteamscorelimitsoon(param_00);
	thread maps\mp\gametypes\_gamelogic::checkscorelimit();
}

//Function Number: 10
func_2B93(param_00)
{
	var_01 = 0;
	if(!maps\mp\_utility::isroundbased() || !maps\mp\_utility::isobjectivebased())
	{
		var_01 = func_2B96(param_00);
	}
	else
	{
		var_01 = game["roundsWon"][param_00];
	}

	setteamscore(param_00,var_01);
}

//Function Number: 11
func_2B96(param_00)
{
	return game["teamScores"][param_00];
}

//Function Number: 12
func_2B97()
{
	level notify("updating_scores");
	level endon("updating_scores");
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	foreach(var_01 in level.players)
	{
		var_01 updatescores();
	}
}

//Function Number: 13
func_2B99()
{
	level notify("updating_dm_scores");
	level endon("updating_dm_scores");
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00] updatedmscores();
		level.players[var_00].var_2B9A = 1;
	}
}

//Function Number: 14
func_2B9B()
{
	var_00 = 0;
	var_01 = level.placement["all"].size;
	var_02 = 0;
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		if(level.placement["all"][var_03] == self)
		{
			var_02 = 1;
		}

		if(var_02)
		{
			level.placement["all"][var_03] = level.placement["all"][var_03 + 1];
		}
	}

	if(!var_02)
	{
		return;
	}

	level.placement["all"][var_01 - 1] = undefined;
	if(level.teambased)
	{
		func_2B9F();
		return;
	}

	var_01 = level.placement["all"].size;
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		var_04 = level.placement["all"][var_03];
		var_04 notify("update_outcome");
	}
}

//Function Number: 15
func_2B9C()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.connectedpostgame) || var_02.pers["team"] != "allies" && var_02.pers["team"] != "axis")
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	for(var_04 = 1;var_04 < var_00.size;var_04++)
	{
		var_02 = var_00[var_04];
		var_05 = var_02.score;
		for(var_06 = var_04 - 1;var_06 >= 0 && func_2B9E(var_02,var_00[var_06]) == var_02;var_06--)
		{
			var_00[var_06 + 1] = var_00[var_06];
		}

		var_00[var_06 + 1] = var_02;
	}

	level.placement["all"] = var_00;
	if(level.teambased)
	{
		func_2B9F();
	}
}

//Function Number: 16
func_2B9E(param_00,param_01)
{
	if(param_00.score > param_01.score)
	{
		return param_00;
	}

	if(param_01.score > param_00.score)
	{
		return param_01;
	}

	if(param_00.deaths < param_01.deaths)
	{
		return param_00;
	}

	if(param_01.deaths < param_00.deaths)
	{
		return param_01;
	}

	if(common_scripts\utility::cointoss())
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 17
func_2B9F()
{
	var_00["allies"] = [];
	var_01 = level.placement["all"];
	var_02 = var_01.size;
	for(var_03 = 0;var_03 < var_02;var_03++ = var_7B["spectator"])
	{
		var_04 = var_01[var_03];
		var_05 = var_04.pers["team"];
		var_7B[var_05][var_7B[var_05].size] = var_04;
	}

	level.placement["allies"] = var_7B["allies"];
	level.placement["axis"] = var_7B["axis"];
}

//Function Number: 18
func_2BA0()
{
	wait 0.2;
	var_00 = 0;
	for(;;)
	{
		var_01 = 0;
		var_02 = level.players;
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			var_04 = var_02[var_03];
			if(!isdefined(var_04))
			{
				continue;
			}

			if(isdefined(var_04.var_2B9A))
			{
				continue;
			}

			var_04.var_2B9A = 1;
			var_04 updatedmscores();
			var_01 = 1;
			wait 0.5;
		}

		if(!var_01)
		{
			wait 3;
		}
	}
}

//Function Number: 19
func_2BA1(param_00)
{
	self endon("disconnect");
	param_00 endon("disconnect");
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	if(self.pers["team"] != "axis" && self.pers["team"] != "allies")
	{
		return;
	}

	if(self.pers["team"] == param_00.pers["team"])
	{
		return;
	}

	self thread [[ level.onxpevent ]]("assist");
	maps\mp\_utility::incpersstat("assists",1);
	self.assists = maps\mp\_utility::getpersstat("assists");
	maps\mp\_utility::incplayerstat("assists",1);
	maps\mp\gametypes\_persistance::statsetchild("round","assists",self.assists);
	func_2B7B("assist",self,param_00);
	maps\mp\killstreaks\_killstreaks::giveadrenaline("assist");
	thread maps\mp\gametypes\_missions::playerassist();
}

//Function Number: 20
func_2BA8(param_00)
{
	self endon("disconnect");
	param_00 endon("disconnect");
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	if(self.pers["team"] != "axis" && self.pers["team"] != "allies")
	{
		return;
	}

	if(self.pers["team"] == param_00.pers["team"])
	{
		return;
	}

	self thread [[ level.onxpevent ]]("assist");
	self thread [[ level.onxpevent ]]("assist");
	maps\mp\_utility::incpersstat("assists",1);
	self.assists = maps\mp\_utility::getpersstat("assists");
	maps\mp\_utility::incplayerstat("assists",1);
	maps\mp\gametypes\_persistance::statsetchild("round","assists",self.assists);
	func_2B7B("assist",self,param_00);
	thread maps\mp\gametypes\_hud_message::splashnotifydelayed("shield_assist");
	thread maps\mp\gametypes\_missions::playerassist();
}