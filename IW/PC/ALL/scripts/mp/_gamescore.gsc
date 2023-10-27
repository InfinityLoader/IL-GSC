/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_gamescore.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 34
 * Decompile Time: 1297 ms
 * Timestamp: 10/27/2023 12:20:28 AM
*******************************************************************/

//Function Number: 1
func_7F00()
{
	func_12EEC();
	if(!level.var_CC1D["all"].size)
	{
		return undefined;
	}

	return level.var_CC1D["all"][0];
}

//Function Number: 2
ishighestscoringplayertied()
{
	if(level.var_CC1D["all"].size > 1)
	{
		var_00 = func_12B4(level.var_CC1D["all"][0]);
		var_01 = func_12B4(level.var_CC1D["all"][1]);
		return var_00 == var_01;
	}

	return 0;
}

//Function Number: 3
func_7F83()
{
	func_12EEC();
	var_00 = level.var_CC1D["all"];
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(var_03 == level.var_CC1D["all"][0])
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 4
func_8392(param_00,param_01)
{
	if(isdefined(level.ignorescoring) && !issubstr(param_00,"assist"))
	{
		return;
	}

	if(!level.teambased)
	{
		foreach(var_03 in level.players)
		{
			if(scripts\mp\_utility::issimultaneouskillenabled())
			{
				if(var_03 != self)
				{
					continue;
				}

				if(level.var_E763 > 1 && var_03.pers["score"] >= level.var_E763)
				{
					return;
				}

				continue;
			}

			if(level.var_E763 > 1 && var_03.pers["score"] >= level.var_E763)
			{
				return;
			}
		}
	}

	var_03 = self;
	if(isdefined(self.var_222) && !isbot(self))
	{
		var_03 = self.var_222;
	}

	if(!isplayer(var_03))
	{
		return;
	}

	var_05 = param_01;
	if(isdefined(level.var_C579))
	{
		param_01 = [[ level.var_C579 ]](param_00,var_03,param_01);
	}

	if(param_01 == 0)
	{
		return;
	}

	var_03.pers["score"] = int(max(var_03.pers["score"] + param_01,0));
	var_03 scripts\mp\_persistence::func_10E12("score",var_05);
	if(var_03.pers["score"] >= -536)
	{
		var_03.pers["score"] = -536;
	}

	var_03.var_278 = var_03.pers["score"];
	var_06 = var_03.var_278;
	var_03 scripts\mp\_persistence::func_10E56("round","score",var_06);
	var_03 scripts\mp\_gamelogic::func_3E35();
	thread scripts\mp\_gamelogic::func_3E47();
	if(scripts\mp\_utility::func_B3EC() && isdefined(level.nojip) && !level.nojip && level.gametype != "infect")
	{
		var_03 checkffascorejip();
	}

	var_03 scripts\mp\_utility::func_316C("earned_score_buffered",param_01);
	scripts\mp\_analyticslog::func_AFAD(param_01,gettime(),scripts\mp\_rank::func_8102(param_00,"eventID"));
	var_03 scripts\mp\_matchdata::func_AFD8(param_00);
}

//Function Number: 5
func_13D4(param_00,param_01)
{
	if(param_01 == param_00.pers["score"])
	{
		return;
	}

	if(param_01 < 0)
	{
		return;
	}

	param_00.pers["score"] = param_01;
	param_00.var_278 = param_00.pers["score"];
	thread scripts\mp\_gamelogic::func_3E47();
}

//Function Number: 6
func_12B4(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self;
	}

	return param_00.pers["score"];
}

//Function Number: 7
checkffascorejip()
{
	if(level.var_E763 > 0)
	{
		var_00 = self.var_278 / level.var_E763 * 100;
		if(var_00 > level.var_EC3F)
		{
			function_01BC(1);
			level.nojip = 1;
		}
	}
}

//Function Number: 8
func_83B0(param_00,param_01,param_02)
{
	if(scripts\mp\_utility::cantiebysimultaneouskill())
	{
		param_02 = 1;
	}

	if(isdefined(level.ignorescoring))
	{
		return;
	}

	if(param_02)
	{
		if(level.var_E763 > 1 && game["teamScores"][param_00] >= level.var_E763)
		{
			return;
		}
	}
	else if((level.var_E763 > 1 && game["teamScores"][param_00] >= level.var_E763) || level.var_E763 > 1 && game["teamScores"][level.var_C74B[param_00]] >= level.var_E763)
	{
		return;
	}

	func_13D6(param_00,func_12B6(param_00) + param_01,param_02);
	level notify("update_team_score",param_00,func_12B6(param_00));
	var_03 = func_8242(param_02);
	if(!level.splitscreen && var_03 != "none" && var_03 != level.var_1391F && gettime() - level.var_AA1E > 5000 && scripts\mp\_utility::func_8105() != 1)
	{
		level.var_AA1E = gettime();
		scripts\mp\_utility::func_AAE7("lead_taken",var_03,"status");
		if(level.var_1391F != "none")
		{
			scripts\mp\_utility::func_AAE7("lead_lost",level.var_1391F,"status");
		}
	}

	if(var_03 != "none")
	{
		level.var_1391F = var_03;
		var_04 = func_12B6(var_03);
		var_05 = level.var_E763;
		if(var_04 == 0 || var_05 == 0)
		{
			return;
		}

		var_06 = var_04 / var_05 * 100;
		if(!scripts\mp\_utility::func_9F32() && isdefined(level.nojip) && !level.nojip)
		{
			if(var_06 > level.var_EC3F)
			{
				function_01BC(1);
				level.nojip = 1;
				return;
			}
		}
	}
}

//Function Number: 9
func_8242(param_00)
{
	var_01 = level.teamnamelist;
	if(!isdefined(level.var_1391F))
	{
		level.var_1391F = "none";
	}

	var_02 = "none";
	var_03 = 0;
	if(level.var_1391F != "none")
	{
		var_02 = level.var_1391F;
		var_03 = game["teamScores"][level.var_1391F];
	}

	var_04 = 1;
	foreach(var_06 in var_01)
	{
		if(var_06 == level.var_1391F)
		{
			continue;
		}

		if(game["teamScores"][var_06] > var_03)
		{
			var_02 = var_06;
			var_03 = game["teamScores"][var_06];
			var_04 = 1;
			continue;
		}

		if(game["teamScores"][var_06] == var_03)
		{
			var_04 = var_04 + 1;
			var_02 = "none";
		}
	}

	return var_02;
}

//Function Number: 10
func_13D6(param_00,param_01,param_02)
{
	if(param_01 < 0)
	{
		param_01 = 0;
	}

	if(param_01 == game["teamScores"][param_00])
	{
		return;
	}

	game["teamScores"][param_00] = param_01;
	func_12F3B(param_00);
	thread scripts\mp\_gamelogic::func_E75E(param_00,param_02);
}

//Function Number: 11
func_12F3B(param_00)
{
	var_01 = 0;
	if(!scripts\mp\_utility::func_9F32() || !scripts\mp\_utility::func_9EBD() || scripts\mp\_utility::func_9EA9())
	{
		var_01 = func_12B6(param_00);
	}
	else
	{
		var_01 = game["roundsWon"][param_00];
	}

	setteamscore(param_00,int(var_01));
}

//Function Number: 12
func_12F4A(param_00)
{
	if(!isdefined(game["totalScore"]))
	{
		game["totalScore"] = [];
		game["totalScore"]["axis"] = 0;
		game["totalScore"]["allies"] = 0;
	}

	var_01 = scripts\mp\_utility::func_8240();
	switch(var_01)
	{
		case "roundsWon":
			game["teamScores"][param_00] = game["roundsWon"][param_00];
			break;

		case "teamScores":
			if(scripts\mp\_utility::func_9900())
			{
				game["teamScores"][param_00] = game["preOvertimeScore"][param_00] + game["overtimeScore"][param_00] + game["teamScores"][param_00];
			}
			else if(scripts\mp\_utility::func_E269())
			{
				game["totalScore"][param_00] = game["totalScore"][param_00] + game["teamScores"][param_00];
				game["teamScores"][param_00] = game["totalScore"][param_00];
			}
			break;
	}

	setteamscore(param_00,int(game["teamScores"][param_00]));
}

//Function Number: 13
func_12EE5()
{
	if(game["overtimeRoundsPlayed"] == 0)
	{
		if(!isdefined(game["preOvertimeScore"]))
		{
			game["preOvertimeScore"] = [];
			game["preOvertimeScore"]["allies"] = 0;
			game["preOvertimeScore"]["axis"] = 0;
		}

		game["preOvertimeScore"]["allies"] = game["teamScores"]["allies"] + game["totalScore"]["allies"];
		game["preOvertimeScore"]["axis"] = game["teamScores"]["axis"] + game["totalScore"]["axis"];
	}

	if(!isdefined(game["overtimeScore"]))
	{
		game["overtimeScore"] = [];
		game["overtimeScore"]["allies"] = 0;
		game["overtimeScore"]["axis"] = 0;
	}

	game["overtimeScore"]["allies"] = game["overtimeScore"]["allies"] + game["teamScores"]["allies"] - game["preOvertimeScore"]["allies"];
	game["overtimeScore"]["axis"] = game["overtimeScore"]["axis"] + game["teamScores"]["axis"] - game["preOvertimeScore"]["axis"];
	if(!scripts\mp\_utility::func_A00B())
	{
		game["teamScores"][game["attackers"]] = 0;
		setteamscore(game["attackers"],0);
		game["teamScores"][game["defenders"]] = 0;
		setteamscore(game["defenders"],0);
		if(scripts\mp\_utility::func_9FAB() && game["timeToBeatTeam"] == game["attackers"])
		{
			game["teamScores"][game["attackers"]] = game["timeToBeatScore"];
			func_12F3B(game["attackers"]);
			game["overtimeScore"][game["attackers"]] = game["overtimeScore"][game["attackers"]] - game["timeToBeatScore"];
		}

		if(scripts\mp\_utility::func_9FAB() && game["timeToBeatTeam"] == game["defenders"])
		{
			game["teamScores"][game["defenders"]] = game["timeToBeatScore"];
			func_12F3B(game["defenders"]);
			game["overtimeScore"][game["defenders"]] = game["overtimeScore"][game["defenders"]] - game["timeToBeatScore"];
		}
	}
}

//Function Number: 14
func_12B6(param_00)
{
	return int(game["teamScores"][param_00]);
}

//Function Number: 15
func_E0ED()
{
	var_00 = 0;
	var_01 = level.var_CC1D["all"].size;
	var_02 = 0;
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		if(level.var_CC1D["all"][var_03] == self)
		{
			var_02 = 1;
		}

		if(var_02)
		{
			level.var_CC1D["all"][var_03] = level.var_CC1D["all"][var_03 + 1];
		}
	}

	if(!var_02)
	{
		return;
	}

	level.var_CC1D["all"][var_01 - 1] = undefined;
	if(level.multiteambased)
	{
		func_BD7B();
	}

	if(level.teambased)
	{
		func_12F3A();
	}
}

//Function Number: 16
func_12EEC()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.var_4530))
		{
			continue;
		}

		if(var_02.pers["team"] == "spectator" || var_02.pers["team"] == "none")
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	for(var_04 = 1;var_04 < var_00.size;var_04++)
	{
		var_02 = var_00[var_04];
		var_05 = var_02.var_278;
		for(var_06 = var_04 - 1;var_06 >= 0 && func_7E06(var_02,var_00[var_06]) == var_02;var_06--)
		{
			var_00[var_06 + 1] = var_00[var_06];
		}

		var_00[var_06 + 1] = var_02;
	}

	level.var_CC1D["all"] = var_00;
	if(level.multiteambased)
	{
		func_BD7B();
	}
	else if(level.teambased)
	{
		func_12F3A();
	}
}

//Function Number: 17
func_7E06(param_00,param_01)
{
	if(param_00.var_278 > param_01.var_278)
	{
		return param_00;
	}

	if(param_01.var_278 > param_00.var_278)
	{
		return param_01;
	}

	if(param_00.var_E9 < param_01.var_E9)
	{
		return param_00;
	}

	if(param_01.var_E9 < param_00.var_E9)
	{
		return param_01;
	}

	if(scripts\common\utility::func_4347())
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 18
func_12F3A()
{
	var_00["allies"] = [];
	var_00["axis"] = [];
	var_00["spectator"] = [];
	var_01 = level.var_CC1D["all"];
	var_02 = var_01.size;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = var_01[var_03];
		var_05 = var_04.pers["team"];
		var_00[var_05][var_00[var_05].size] = var_04;
	}

	level.var_CC1D["allies"] = var_00["allies"];
	level.var_CC1D["axis"] = var_00["axis"];
}

//Function Number: 19
func_BD7B()
{
	var_00["spectator"] = [];
	foreach(var_02 in level.teamnamelist)
	{
		var_00[var_02] = [];
	}

	var_04 = level.var_CC1D["all"];
	var_05 = var_04.size;
	for(var_06 = 0;var_06 < var_05;var_06++)
	{
		var_07 = var_04[var_06];
		var_08 = var_07.pers["team"];
		var_00[var_08][var_00[var_08].size] = var_07;
	}

	foreach(var_02 in level.teamnamelist)
	{
		level.var_CC1D[var_02] = var_00[var_02];
	}
}

//Function Number: 20
func_D98C(param_00,param_01,param_02)
{
	if(isdefined(level.var_23E9))
	{
		return;
	}

	func_D98D(param_00,param_01,param_02);
}

//Function Number: 21
func_D98D(param_00,param_01,param_02)
{
	self endon("disconnect");
	param_00 endon("disconnect");
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	if(isdefined(param_00.var_9E92))
	{
		var_04 = param_00.var_2507;
		var_03 = 1;
	}

	if(isdefined(param_00.var_B370))
	{
		var_05 = param_00.var_B370;
	}

	wait(0.05);
	scripts\mp\_utility::func_13842();
	var_06 = self.pers["team"];
	if(var_06 != "axis" && var_06 != "allies")
	{
		return;
	}

	if(var_06 == param_00.pers["team"] && level.teambased)
	{
		return;
	}

	var_07 = undefined;
	var_08 = "assist";
	if(!level.teambased)
	{
		var_08 = "assist_ffa";
	}

	var_09 = scripts\mp\_rank::func_8104(var_08);
	if(!level.teambased)
	{
		if(param_02)
		{
			var_07 = var_09 + var_09;
		}

		thread scripts\mp\_utility::func_83B4("assist_ffa",param_01,var_07);
	}
	else if(scripts\mp\_utility::_hasperk("specialty_mark_targets") && isdefined(var_04) && scripts\common\utility::func_2286(var_04,self))
	{
		if(param_02)
		{
			var_0A = scripts\mp\_rank::func_8104("assistMarked");
			var_07 = var_09 + var_0A;
		}

		thread scripts\mp\_utility::givestreakpointswithtext("assistMarked",param_01,var_07);
		func_8392("assist",var_09);
	}
	else if(isdefined(var_05) && scripts\mp\_utility::func_2287(var_05,scripts\mp\_utility::func_81EC()))
	{
		thread scripts\mp\_utility::givestreakpointswithtext("assistPing",param_01,undefined);
	}
	else
	{
		if(param_02)
		{
			var_07 = var_09 + var_09;
		}

		thread scripts\mp\_utility::func_83B4("assist",param_01,var_07);
	}

	if(level.teambased)
	{
		foreach(var_0C in level.players)
		{
			if(self.team != var_0C.team || self == var_0C)
			{
				continue;
			}

			if(!scripts\mp\_utility::func_9F19(var_0C))
			{
				continue;
			}

			if(distancesquared(self.origin,var_0C.origin) < 90000)
			{
				self.var_B930["buddy_kill"] = 1;
				break;
			}
		}
	}

	if(scripts\mp\_utility::_hasperk("specialty_hardline") && isdefined(self.hardlineactive))
	{
		if(self.hardlineactive["assists"] == 1)
		{
			thread scripts\mp\_utility::givestreakpointswithtext("assist_hardline",param_01,undefined);
		}

		self notify("assist_hardline");
	}

	scripts\mp\_utility::func_93DF("assists",1);
	self.var_4D = scripts\mp\_utility::getpersstat("assists");
	scripts\mp\_persistence::func_10E56("round","assists",self.var_4D);
	scripts\mp\_utility::func_316C("assist_buffered",self.var_B930);
	thread scripts\mp\_missions::func_D366(param_00);
	thread scripts\mp\_intelchallenges::func_99B8(param_00);
	if(level.var_7669)
	{
		scripts\mp\_utility::setpersstat("streakPoints",scripts\common\utility::func_116D7(isdefined(self.var_110EE),self.var_110EE,0));
	}
}

//Function Number: 22
func_D9B5(param_00)
{
	if(isdefined(level.var_23E9))
	{
		return;
	}

	func_D9B6(param_00);
}

//Function Number: 23
func_D9B6(param_00)
{
	self endon("disconnect");
	param_00 endon("disconnect");
	wait(0.05);
	scripts\mp\_utility::func_13842();
	if(self.pers["team"] != "axis" && self.pers["team"] != "allies")
	{
		return;
	}

	if(self.pers["team"] == param_00.pers["team"])
	{
		return;
	}

	thread scripts\mp\_utility::func_83B4("shield_assist");
	scripts\mp\_utility::func_93DF("assists",1);
	self.var_4D = scripts\mp\_utility::getpersstat("assists");
	scripts\mp\_persistence::func_10E56("round","assists",self.var_4D);
	thread scripts\mp\_missions::func_D366(param_00);
}

//Function Number: 24
func_97D2()
{
	self.var_3167 = [];
	self.var_4EA0 = [];
}

//Function Number: 25
func_11ACE(param_00,param_01,param_02)
{
	if(isplayer(param_01))
	{
		if(!isdefined(param_01.var_4EA0[param_02]))
		{
			param_01.var_4EA0[param_02] = [];
		}

		param_01.var_4EA0[param_02][param_00 getentitynumber()] = param_00;
	}
}

//Function Number: 26
func_12D6F(param_00,param_01,param_02)
{
	if(isplayer(param_01) && isdefined(param_01.var_4EA0[param_02]))
	{
		param_01.var_4EA0[param_02][param_00 getentitynumber()] = undefined;
	}
}

//Function Number: 27
func_11ACF(param_00,param_01,param_02,param_03)
{
	param_01 endon("spawned_player");
	param_01 endon("disconnect");
	param_00 endon("disconnect");
	level endon("game_ended");
	func_11ACE(param_00,param_01,param_02);
	wait(param_03);
	func_12D6F(param_00,param_01,param_02);
}

//Function Number: 28
func_8BE1(param_00,param_01)
{
	if(isdefined(param_00.var_4EA0[param_01]))
	{
		param_00.var_4EA0[param_01] = scripts\common\utility::func_22BC(param_00.var_4EA0[param_01]);
		return param_00.var_4EA0[param_01].size > 0;
	}

	return 0;
}

//Function Number: 29
func_7E64(param_00,param_01)
{
	if(isdefined(param_00.var_4EA0[param_01]))
	{
		param_00.var_4EA0[param_01] = scripts\common\utility::func_22BC(param_00.var_4EA0[param_01]);
		if(param_00.var_4EA0[param_01].size > 0)
		{
			return param_00.var_4EA0[param_01];
		}
	}

	return undefined;
}

//Function Number: 30
func_11AC9(param_00,param_01,param_02)
{
	if(param_00 != param_01)
	{
		var_03 = param_01.var_3167[param_02];
		if(!isdefined(param_01.var_3167[param_02]))
		{
			param_01.var_3167[param_02] = [];
		}

		param_01.var_3167[param_02][param_00 getentitynumber()] = param_00;
	}
}

//Function Number: 31
func_12D6E(param_00,param_01,param_02)
{
	if(param_00 != param_01 && isdefined(param_01.var_3167[param_02]))
	{
		param_01.var_3167[param_02][param_00 getentitynumber()] = undefined;
	}
}

//Function Number: 32
func_11ACA(param_00,param_01,param_02,param_03)
{
	param_01 endon("spawned_player");
	param_01 endon("disconnect");
	level endon("game_ended");
	func_11AC9(param_00,param_01,param_02);
	wait(param_03);
	func_12D6E(param_00,param_01,param_02);
}

//Function Number: 33
func_26CD(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_01.var_4EA0)
	{
		foreach(var_06 in var_04)
		{
			if(isdefined(var_06) && var_06.team != "spectator" && var_06 scripts\mp\_utility::func_9DD6(param_01))
			{
				var_07 = var_06.var_86BD;
				if(!isdefined(var_02[var_07]))
				{
					var_02[var_07] = var_06;
				}
			}
		}
	}

	foreach(var_04 in param_00.var_3167)
	{
		foreach(var_06 in var_04)
		{
			if(isdefined(var_06) && var_06.team != "spectator" && var_06 scripts\mp\_utility::func_9DD6(param_01))
			{
				var_07 = var_06.var_86BD;
				if(!isdefined(var_02[var_07]))
				{
					var_02[var_07] = var_06;
				}
			}
		}
	}

	foreach(var_06 in var_02)
	{
		if(!isdefined(param_01.var_24E5) || !isdefined(param_01.var_24E5[var_06.var_86BD]))
		{
			scripts\mp\_damage::func_17AC(param_01,var_06,undefined,"none",0,undefined,undefined,undefined,undefined,undefined);
		}
	}
}

//Function Number: 34
func_767A(param_00)
{
	return param_00 == "dm" || param_00 == "sotf_ffa";
}