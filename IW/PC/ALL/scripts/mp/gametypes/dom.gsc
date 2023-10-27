/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\dom.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 1597 ms
 * Timestamp: 10/27/2023 12:12:29 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvar("mapname") == "mp_background")
	{
		return;
	}

	scripts\mp\_globallogic::init();
	scripts\mp\_globallogic::func_FA99();
	if(function_011C())
	{
		level.var_987C = ::func_987C;
		[[ level.var_987C ]]();
		level thread scripts\mp\_utility::func_DF2D();
	}
	else
	{
		scripts\mp\_utility::func_DF11(level.gametype,30);
		scripts\mp\_utility::func_DF0B(level.gametype,200);
		scripts\mp\_utility::func_DF08(level.gametype,2);
		scripts\mp\_utility::func_DF09("dom",1,0,1);
		scripts\mp\_utility::func_DF1A(level.gametype,0);
		scripts\mp\_utility::func_DF02(level.gametype,0);
		scripts\mp\_utility::func_DEF4(level.gametype,0);
		level.var_B40A = 0;
		level.var_B410 = 0;
	}

	func_12E9F();
	level.teambased = 1;
	level.var_C5A4 = ::func_C5A4;
	level.var_8136 = ::func_8136;
	level.var_C577 = ::func_C577;
	level.onspawnplayer = ::onspawnplayer;
	level.var_A94F = gettime();
	level.var_C561 = ::func_C52C;
	level.var_1C28 = [];
	level.var_26F4 = [];
	if(level.var_B40A || level.var_B410)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	game["dialog"]["gametype"] = "domination";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}
	else if(getdvarint("camera_thirdPerson"))
	{
		game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
	}
	else if(getdvarint("scr_diehard"))
	{
		game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
	}
	else if(getdvarint("scr_" + level.gametype + "_promode"))
	{
		game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
	}

	game["dialog"]["offense_obj"] = "capture_objs";
	game["dialog"]["defense_obj"] = "capture_objs";
	thread func_C56E();
}

//Function Number: 2
func_987C()
{
	scripts\mp\_utility::func_F69D();
	setdynamicdvar("scr_dom_flagCaptureTime",getmatchrulesdata("domData","flagCaptureTime"));
	setdynamicdvar("scr_dom_flagsRequiredToScore",getmatchrulesdata("domData","flagsRequiredToScore"));
	setdynamicdvar("scr_dom_pointsPerFlag",getmatchrulesdata("domData","pointsPerFlag"));
	setdynamicdvar("scr_dom_flagNeutralization",getmatchrulesdata("domData","flagNeutralization"));
	setdynamicdvar("scr_dom_halftime",0);
	scripts\mp\_utility::func_DEF4("dom",0);
	setdynamicdvar("scr_dom_promode",0);
}

//Function Number: 3
seticonnames()
{
	level.iconneutral = "waypoint_captureneutral";
	level.iconcapture = "waypoint_capture";
	level.icondefend = "waypoint_defend";
	level.iconcontested = "waypoint_contested";
	level.icontaking = "waypoint_taking";
	level.iconlosing = "waypoint_losing";
}

//Function Number: 4
func_C5A4()
{
	seticonnames();
	scripts\mp\_utility::func_F7C1("allies",&"OBJECTIVES_DOM");
	scripts\mp\_utility::func_F7C1("axis",&"OBJECTIVES_DOM");
	if(level.splitscreen)
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_DOM");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_DOM");
	}
	else
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_DOM_SCORE");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_DOM_SCORE");
	}

	scripts\mp\_utility::func_F7BE("allies",&"OBJECTIVES_DOM_HINT");
	scripts\mp\_utility::func_F7BE("axis",&"OBJECTIVES_DOM_HINT");
	setclientnamemode("auto_change");
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	func_98CE();
	var_00[0] = "dom";
	scripts\mp\_gameobjects::main(var_00);
	thread func_5913();
	thread func_12E88();
	thread func_E0F2();
	thread func_CC13();
}

//Function Number: 5
func_12E9F()
{
	scripts\mp\gametypes\common::func_12E9F();
	level.var_6E65 = scripts\mp\_utility::dvarfloatvalue("flagCaptureTime",10,0,30);
	level.var_6E7B = scripts\mp\_utility::dvarintvalue("flagsRequiredToScore",1,1,3);
	level.var_D649 = scripts\mp\_utility::dvarintvalue("pointsPerFlag",1,1,300);
	level.var_6E68 = scripts\mp\_utility::dvarintvalue("flagNeutralization",0,0,1);
}

//Function Number: 6
func_98CE()
{
	scripts\mp\_spawnlogic::func_F62D("Domination");
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	scripts\mp\_spawnlogic::func_182D("mp_dom_spawn_allies_start");
	scripts\mp\_spawnlogic::func_182D("mp_dom_spawn_axis_start");
	scripts\mp\_spawnlogic::func_1829("allies","mp_dom_spawn");
	scripts\mp\_spawnlogic::func_1829("allies","mp_dom_spawn_secondary",1,1);
	scripts\mp\_spawnlogic::func_1829("axis","mp_dom_spawn");
	scripts\mp\_spawnlogic::func_1829("axis","mp_dom_spawn_secondary",1,1);
	level.var_B32E = scripts\mp\_spawnlogic::func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
}

//Function Number: 7
func_8136()
{
	var_00 = self.pers["team"];
	var_01 = scripts\mp\_utility::getotherteam(var_00);
	if(level.var_130DD)
	{
		if(game["switchedsides"])
		{
			var_02 = scripts\mp\_spawnlogic::func_8140("mp_dom_spawn_" + var_01 + "_start");
			var_03 = scripts\mp\_spawnlogic::func_813F(var_02);
		}
		else
		{
			var_02 = scripts\mp\_spawnlogic::func_8140("mp_dom_spawn_" + var_02 + "_start");
			var_03 = scripts\mp\_spawnlogic::func_813F(var_03);
		}
	}
	else
	{
		var_04 = func_81A7(var_02);
		var_05 = scripts\mp\_utility::getotherteam(var_00);
		var_06 = func_81A7(var_05);
		var_07 = func_8056(var_04,var_06);
		var_02 = scripts\mp\_spawnlogic::func_81BA(var_00);
		var_08 = scripts\mp\_spawnlogic::func_81A9(var_00);
		var_09 = [];
		var_09["preferredDomPoints"] = var_07;
		var_03 = scripts\mp\_spawnscoring::func_8136(var_02,var_08,var_09);
	}

	return var_03;
}

//Function Number: 8
func_81A7(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_5913)
	{
		if(var_03.ownerteam == param_00)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 9
func_8056(param_00,param_01)
{
	var_02 = [];
	var_02[0] = 0;
	var_02[1] = 0;
	var_02[2] = 0;
	var_03 = self.pers["team"];
	if(param_00.size == level.var_5913.size)
	{
		var_04 = var_03;
		var_05 = level.var_2A99[var_03];
		var_02[var_05.var_130AC.var_5922] = 1;
		return var_02;
	}

	if(var_02.size == 1 && var_03.size == 2 && !scripts\mp\_utility::func_9D46())
	{
		var_06 = scripts\mp\_utility::getotherteam(self.team);
		var_07 = scripts\mp\_gamescore::func_12B6(var_06) - scripts\mp\_gamescore::func_12B6(self.team);
		if(var_07 > 15)
		{
			var_08 = func_81CF(var_02[0]);
			var_09 = func_81CF(var_03[0]);
			var_0A = func_81CF(var_03[1]);
			if(var_08 > -25536 && var_09 > -25536 && var_0A > -25536)
			{
				return var_04;
			}
		}
	}

	if(var_02.size > 0)
	{
		foreach(var_0C in var_02)
		{
			var_04[var_0C.var_5922] = 1;
		}

		return var_04;
	}

	if(var_05.size == 0)
	{
		var_04 = var_0D;
		var_05 = level.var_2A99[var_0D];
		if(var_04.size > 0 && var_04.size < level.var_5913.size)
		{
			var_0D = func_81EF(var_0C);
			level.var_2A99[var_0C] = var_0D;
		}

		var_05[var_0D.var_130AC.var_5922] = 1;
		return var_05;
	}

	return var_0C;
}

//Function Number: 10
func_81CF(param_00)
{
	return gettime() - param_00.var_3A40;
}

//Function Number: 11
func_5913()
{
	scripts\mp\_utility::func_98D3();
	var_00 = getentarray("flag_primary","targetname");
	var_01 = getentarray("flag_secondary","targetname");
	if(var_00.size + var_01.size < 2)
	{
		return;
	}

	level.var_134 = [];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		level.var_134[level.var_134.size] = var_00[var_02];
	}

	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		level.var_134[level.var_134.size] = var_01[var_02];
	}

	level.var_5913 = [];
	level.var_C2A8 = level.var_134;
	if(level.var_B335 == "mp_afghan")
	{
		for(var_02 = 0;var_02 < level.var_C2A8.size;var_02++)
		{
			if(level.var_C2A8[var_02].script_label == "_c")
			{
				level.var_C2A8[var_02].script_label = "_b";
				continue;
			}

			if(level.var_C2A8[var_02].script_label == "_b")
			{
				level.var_C2A8[var_02].script_label = "_c";
			}
		}
	}

	for(var_02 = 0;var_02 < level.var_134.size;var_02++)
	{
		var_03 = scripts\mp\gametypes\obj_dom::func_591D(var_02);
		level.var_134[var_02].var_130AC = var_03;
		var_03.var_ABF0 = level.var_134[var_02];
		level.var_5913[level.var_5913.size] = var_03;
	}

	var_04 = scripts\mp\_spawnlogic::func_8140("mp_dom_spawn_axis_start");
	var_05 = scripts\mp\_spawnlogic::func_8140("mp_dom_spawn_allies_start");
	level.var_2C5["allies"] = var_05[0].origin;
	level.var_2C5["axis"] = var_04[0].origin;
	level.var_2A99 = [];
	level.var_2A99["allies"] = func_81EF("allies",undefined);
	level.var_2A99["axis"] = func_81EF("axis",level.var_2A99["allies"]);
	func_6E70();
	thread func_B92E();
}

//Function Number: 12
func_81EF(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	for(var_04 = 0;var_04 < level.var_134.size;var_04++)
	{
		var_05 = level.var_134[var_04];
		if(var_05 func_7EBB() != "neutral")
		{
			continue;
		}

		var_06 = distancesquared(var_05.origin,level.var_2C5[param_00]);
		if((!isdefined(param_01) || var_05 != param_01) && !isdefined(var_02) || var_06 < var_03)
		{
			var_03 = var_06;
			var_02 = var_05;
		}
	}

	return var_02;
}

//Function Number: 13
func_12E88()
{
	level endon("game_ended");
	var_00 = undefined;
	var_01 = undefined;
	while(!level.var_7669)
	{
		var_02 = func_803D();
		if(!isdefined(level.var_EC50))
		{
			level.var_EC50 = [];
		}

		level.var_EC50["allies"] = 0;
		level.var_EC50["axis"] = 0;
		if(var_02.size)
		{
			for(var_03 = 1;var_03 < var_02.size;var_03++)
			{
				var_04 = var_02[var_03];
				var_05 = gettime() - var_04.var_3A40;
				for(var_06 = var_03 - 1;var_06 >= 0 && var_05 > gettime() - var_02[var_06].var_3A40;var_06--)
				{
					var_02[var_06 + 1] = var_02[var_06];
				}

				var_02[var_06 + 1] = var_04;
			}

			foreach(var_04 in var_02)
			{
				var_08 = var_04 scripts\mp\_gameobjects::func_803E();
				var_09 = scripts\mp\_utility::getotherteam(var_08);
				var_00 = getteamscore(var_08);
				var_01 = getteamscore(var_09);
				var_0A = func_81AB(var_08);
				if(var_0A >= level.var_6E7B)
				{
					level.var_EC50[var_08] = level.var_EC50[var_08] + level.var_D649;
				}
			}
		}

		func_12F0C();
		func_3E07(var_02.size);
		wait(5);
		scripts\mp\_hostmigration::func_13834();
	}
}

//Function Number: 14
func_12F0C()
{
	var_00 = level.var_E763;
	var_01 = game["teamScores"]["allies"] + level.var_EC50["allies"];
	var_02 = game["teamScores"]["axis"] + level.var_EC50["axis"];
	var_03 = var_01 >= var_00;
	var_04 = var_02 >= var_00;
	if(var_03 && !var_04)
	{
		level.var_EC50["allies"] = var_00 - game["teamScores"]["allies"];
	}
	else if(var_04 && !var_03)
	{
		level.var_EC50["axis"] = var_00 - game["teamScores"]["axis"];
	}

	if(level.var_EC50["allies"] > 0)
	{
		scripts\mp\_gamescore::func_83B0("allies",level.var_EC50["allies"],1);
	}

	if(level.var_EC50["axis"] > 0)
	{
		scripts\mp\_gamescore::func_83B0("axis",level.var_EC50["axis"],1);
	}
}

//Function Number: 15
func_3E07(param_00)
{
	var_01 = gettime() - level.var_A94F;
	if(scripts\mp\_utility::func_B3EC() && param_00 < 2 && var_01 > 120000)
	{
		level.var_72B3 = 1;
		thread scripts\mp\_gamelogic::endgame("none",game["end_reason"]["time_limit_reached"]);
	}
}

//Function Number: 16
func_C577(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isplayer(param_01) || param_01.team == self.team)
	{
		return;
	}

	if(isdefined(param_04) && scripts\mp\_utility::func_9E6C(param_04))
	{
		return;
	}

	var_0A = 0;
	var_0B = 0;
	var_0C = 0;
	var_0D = self;
	var_0E = var_0D.team;
	var_0F = var_0D.origin;
	var_10 = param_01.team;
	var_11 = param_01.origin;
	var_12 = 0;
	if(isdefined(param_00))
	{
		var_11 = param_00.origin;
		var_12 = param_00 == param_01;
	}

	foreach(var_14 in param_01.var_11A46)
	{
		if(var_14 != level.var_134[0] && var_14 != level.var_134[1] && var_14 != level.var_134[2])
		{
			continue;
		}

		var_15 = var_14.var_130AC.ownerteam;
		if(var_10 != var_15)
		{
			if(!var_0A)
			{
				var_0A = 1;
			}

			continue;
		}
	}

	foreach(var_14 in level.var_134)
	{
		var_15 = var_14.var_130AC.ownerteam;
		if(var_15 == "neutral")
		{
			var_18 = param_01 istouching(var_14);
			var_19 = var_0D istouching(var_14);
			if(var_18 || var_19)
			{
				if(var_14.var_130AC.claimteam == var_0E)
				{
					if(!var_0B)
					{
						if(var_0A)
						{
							param_01 thread scripts\mp\_utility::func_83B4("capture_kill");
						}

						var_0B = 1;
						param_01 thread scripts\mp\_awards::func_8380("mode_x_assault");
						thread scripts\mp\_matchdata::func_AFC5(param_09,"assaulting");
						continue;
					}
				}
				else if(var_14.var_130AC.claimteam == var_10)
				{
					if(!var_0C)
					{
						if(var_0A)
						{
							param_01 thread scripts\mp\_utility::func_83B4("capture_kill");
						}

						var_0C = 1;
						param_01 thread scripts\mp\_awards::func_8380("mode_x_defend");
						param_01 scripts\mp\_utility::func_93DF("defends",1);
						param_01 scripts\mp\_persistence::func_10E56("round","defends",param_01.pers["defends"]);
						param_01 scripts\mp\_utility::func_F6FB(param_01.pers["defends"]);
						thread scripts\mp\_matchdata::func_AFC5(param_09,"defending");
						continue;
					}
				}
			}

			continue;
		}

		if(var_15 != var_10)
		{
			if(!var_0B)
			{
				var_1A = func_5720(var_14,var_11,var_0F);
				if(var_1A)
				{
					if(var_0A)
					{
						param_01 thread scripts\mp\_utility::func_83B4("capture_kill");
					}

					var_0B = 1;
					param_01 thread scripts\mp\_awards::func_8380("mode_x_assault");
					thread scripts\mp\_matchdata::func_AFC5(param_09,"assaulting");
					continue;
				}
			}

			continue;
		}

		if(!var_0C)
		{
			var_1B = func_5720(var_14,var_11,var_0F);
			if(var_1B)
			{
				if(var_0A)
				{
					param_01 thread scripts\mp\_utility::func_83B4("capture_kill");
				}

				var_0C = 1;
				param_01 thread scripts\mp\_awards::func_8380("mode_x_defend");
				param_01 scripts\mp\_utility::func_93DF("defends",1);
				param_01 scripts\mp\_persistence::func_10E56("round","defends",param_01.pers["defends"]);
				param_01 scripts\mp\_utility::func_F6FB(param_01.pers["defends"]);
				thread scripts\mp\_matchdata::func_AFC5(param_09,"defending");
				continue;
			}
		}
	}
}

//Function Number: 17
func_5720(param_00,param_01,param_02)
{
	var_03 = distancesquared(param_00.origin,param_01);
	var_04 = distancesquared(param_00.origin,param_02);
	if(var_03 < 105625 || var_04 < 105625)
	{
		if(!isdefined(param_00.var_B92D))
		{
			return 1;
		}

		if(param_01[2] - param_00.origin[2] < 100 || param_02[2] - param_00.origin[2] < 100)
		{
			return 1;
		}

		return 0;
	}

	return 0;
}

//Function Number: 18
func_803D()
{
	var_00 = [];
	foreach(var_02 in level.var_5913)
	{
		if(var_02 scripts\mp\_gameobjects::func_803E() != "neutral" && isdefined(var_02.var_3A40))
		{
			var_00[var_00.size] = var_02;
		}
	}

	return var_00;
}

//Function Number: 19
func_81AB(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.var_134.size;var_02++)
	{
		if(level.var_5913[var_02] scripts\mp\_gameobjects::func_803E() == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 20
func_7EBB()
{
	return self.var_130AC scripts\mp\_gameobjects::func_803E();
}

//Function Number: 21
func_6E70()
{
	foreach(var_01 in level.var_5913)
	{
		switch(var_01.label)
		{
			case "_a":
				var_01.var_5922 = 0;
				break;

			case "_b":
				var_01.var_5922 = 1;
				break;

			case "_c":
				var_01.var_5922 = 2;
				break;
		}
	}

	var_03 = level.var_108FB;
	foreach(var_05 in var_03)
	{
		var_05.var_591F = 0;
		var_05.var_5920 = 0;
		var_05.var_5921 = 0;
		var_05.var_BE82 = func_7FDC(var_05);
		switch(var_05.var_BE82.var_130AC.var_5922)
		{
			case 0:
				var_05.var_591F = 1;
				break;

			case 1:
				var_05.var_5920 = 1;
				break;

			case 2:
				var_05.var_5921 = 1;
				break;
		}
	}
}

//Function Number: 22
func_7FDC(param_00)
{
	var_01 = scripts\mp\_spawnlogic::func_9ED7();
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_05 in level.var_5913)
	{
		var_06 = undefined;
		if(var_01)
		{
			var_06 = function_00C0(param_00.origin,var_05.var_ABF0.origin,999999);
		}

		if(!isdefined(var_06) || var_06 == -1)
		{
			var_06 = distancesquared(var_05.var_ABF0.origin,param_00.origin);
		}

		if(!isdefined(var_02) || var_06 < var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	return var_02.var_ABF0;
}

//Function Number: 23
func_B92E()
{
	if(level.var_B335 == "mp_frontier")
	{
		foreach(var_01 in level.var_134)
		{
			if(var_01.script_label == "_b")
			{
				var_01.var_B92D = 1;
			}
		}
	}
}

//Function Number: 24
onspawnplayer()
{
}

//Function Number: 25
func_8366(param_00)
{
	level endon("game_ended");
	var_01 = scripts\mp\_gameobjects::func_7E8B();
	if(isdefined(var_01.var_222))
	{
		var_01 = var_01.var_222;
	}

	level.var_A94F = gettime();
	if(isplayer(var_01))
	{
		level thread scripts\mp\_utility::func_115DE("callout_securedposition" + self.label,var_01);
		var_01 thread scripts\mp\_matchdata::func_AFBA("capture",var_01.origin);
	}

	if(self.var_6DE3 == 1)
	{
		var_02 = 1;
	}
	else
	{
		var_02 = 0;
	}

	var_03 = getarraykeys(param_00);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_05 = param_00[var_03[var_04]].player;
		if(isdefined(var_05.var_222))
		{
			var_05 = var_05.var_222;
		}

		if(!isplayer(var_05))
		{
			continue;
		}

		var_05 thread func_12E7F();
		var_05 scripts\mp\_utility::func_93DF("captures",1);
		var_05 scripts\mp\_persistence::func_10E56("round","captures",var_05.pers["captures"]);
		var_05 scripts\mp\_missions::func_D992("ch_domcap");
		var_05 scripts\mp\_utility::func_F6FA(var_05.pers["captures"]);
		if(var_02)
		{
			if(self.label == "_b")
			{
				var_05 thread scripts\mp\_awards::func_8380("mode_dom_secure_b");
			}
			else
			{
				var_05 thread scripts\mp\_awards::func_8380("mode_dom_secure_neutral");
			}
		}
		else if(level.var_6E68)
		{
			var_05 thread scripts\mp\_awards::func_8380("mode_dom_neutralized_cap");
		}
		else
		{
			var_05 thread scripts\mp\_awards::func_8380("mode_dom_secure");
		}

		var_05 scripts\mp\gametypes\obj_dom::func_F6A9(var_05);
		wait(0.05);
	}
}

//Function Number: 26
func_12E7F()
{
	if(!isdefined(self.var_4784))
	{
		self.var_C21D = 0;
		self.var_4784 = 0;
	}

	self.var_C21D++;
	if(scripts\mp\_utility::func_7FB9() < 1)
	{
		return;
	}

	self.var_4784 = self.var_C21D / scripts\mp\_utility::func_7FB9();
}

//Function Number: 27
func_7E1A()
{
	if(self.var_4784 < 4)
	{
		return 1;
	}

	return 0.25;
}

//Function Number: 28
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_12B1D = undefined;
		var_00.var_12B1E = undefined;
		var_00 thread func_C57B();
	}
}

//Function Number: 29
func_C57B(param_00)
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned");
		scripts\mp\_utility::func_F6FA(0);
		if(isdefined(self.pers["captures"]))
		{
			scripts\mp\_utility::func_F6FA(self.pers["captures"]);
		}

		scripts\mp\_utility::func_F6FB(0);
		if(isdefined(self.pers["defends"]))
		{
			scripts\mp\_utility::func_F6FB(self.pers["defends"]);
		}
	}
}

//Function Number: 30
func_C52C(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level.var_130DD = 0;
	var_06 = scripts\mp\_utility::getotherteam(param_03);
	thread scripts\mp\_utility::printandsoundoneveryone(param_03,var_06,undefined,undefined,"mp_dom_flag_captured","mp_dom_flag_lost",param_02);
	if(func_81AB(param_03) < level.var_134.size)
	{
		scripts\mp\_utility::func_10E60("secured" + self.label,param_03,1);
		scripts\mp\_utility::func_10E60("enemy_has" + self.label,var_06,1);
	}
	else
	{
		scripts\mp\_utility::func_10E60("secure_all",param_03);
		scripts\mp\_utility::func_10E60("lost_all",var_06);
		foreach(var_08 in level.players)
		{
			if(var_08.team == param_03)
			{
				var_08 scripts\mp\_missions::func_D992("ch_domdom");
			}
		}
	}

	if(param_05.touchlist[param_03].size == 0)
	{
		param_05.touchlist = param_05.var_C405;
	}

	param_05 thread func_8366(param_05.touchlist[param_03]);
}

//Function Number: 31
func_E0F2()
{
	self endon("game_ended");
	for(;;)
	{
		if(getdvar("scr_devRemoveDomFlag","") != "")
		{
			var_00 = getdvar("scr_devRemoveDomFlag","");
			foreach(var_02 in level.var_5913)
			{
				if(isdefined(var_02.label) && var_02.label == var_00)
				{
					var_02 scripts\mp\_gameobjects::func_1CAF("none");
					var_02.trigger = undefined;
					var_02 notify("deleted");
					var_02.visibleteam = "none";
					var_02 scripts\mp\_gameobjects::setzonestatusicons(undefined);
					var_03 = [];
					for(var_04 = 0;var_04 < level.var_134.size;var_04++)
					{
						if(level.var_134[var_04].script_label != var_00)
						{
							var_03[var_03.size] = level.var_134[var_04];
						}
					}

					level.var_134 = var_03;
					level.var_C2A8 = level.var_134;
					var_03 = [];
					for(var_04 = 0;var_04 < level.var_5913.size;var_04++)
					{
						if(level.var_5913[var_04].label != var_00)
						{
							var_03[var_03.size] = level.var_5913[var_04];
						}
					}

					level.var_5913 = var_03;
					break;
				}
			}

			setdynamicdvar("scr_devRemoveDomFlag","");
		}

		wait(1);
	}
}

//Function Number: 32
func_CC13()
{
	self endon("game_ended");
	for(;;)
	{
		if(getdvar("scr_devPlaceDomFlag","") != "")
		{
			var_00 = getdvar("scr_devPlaceDomFlag","");
			var_01 = spawnstruct();
			var_01.origin = level.players[0].origin;
			var_01.angles = level.players[0].angles;
			var_02 = spawn("trigger_radius",var_01.origin,0,120,128);
			var_01.trigger = var_02;
			var_01.trigger.script_label = var_00;
			var_01.ownerteam = "neutral";
			var_03 = var_01.origin + (0,0,32);
			var_04 = var_01.origin + (0,0,-32);
			var_05 = bullettrace(var_03,var_04,0,undefined);
			var_01.origin = var_05["position"];
			var_01.var_12D77 = vectortoangles(var_05["normal"]);
			var_01.var_143 = anglestoforward(var_01.var_12D77);
			var_01.var_267 = anglestoright(var_01.var_12D77);
			var_01.visuals[0] = spawn("script_model",var_01.origin);
			var_01.visuals[0].angles = var_01.angles;
			level.var_134[level.var_134.size] = var_01;
			level.var_C2A8 = level.var_134;
			var_06 = scripts\mp\_gameobjects::func_4A2E("neutral",var_01.trigger,var_01.visuals,(0,0,100));
			var_06 scripts\mp\_gameobjects::func_1CAF("enemy");
			var_06 scripts\mp\_gameobjects::func_FB08(10);
			var_06 scripts\mp\_gameobjects::func_FB07(&"MP_SECURING_POSITION");
			var_07 = var_00;
			var_06.label = var_07;
			var_06 scripts\mp\_gameobjects::setzonestatusicons(level.icondefend + var_07,level.iconneutral + var_07);
			var_06 scripts\mp\_gameobjects::setvisibleteam("any");
			var_06.var_C5BB = ::scripts\mp\gametypes\obj_dom::func_5917;
			var_06.var_C4CB = ::scripts\mp\gametypes\obj_dom::func_5918;
			var_06.var_C5C8 = ::scripts\mp\gametypes\obj_dom::func_591A;
			var_06.var_C50D = ::scripts\mp\gametypes\obj_dom::func_5919;
			var_06.var_C18B = 1;
			var_06.var_92B8 = "domFlag";
			var_06.var_6DE3 = 1;
			var_06.var_3FF7 = 10000;
			var_06.var_4F5F = 50;
			var_03 = var_01.visuals[0].origin + (0,0,32);
			var_04 = var_01.visuals[0].origin + (0,0,-32);
			var_08 = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
			var_09 = [];
			var_05 = scripts\common\trace::func_DCED(var_03,var_04,var_09,var_08);
			var_06.var_289D = var_05["position"];
			var_0A = vectortoangles(var_05["normal"]);
			var_06.var_289C = anglestoforward(var_0A);
			var_06 scripts\mp\gametypes\obj_dom::func_987B();
			var_06 thread scripts\mp\gametypes\obj_dom::func_5912();
			for(var_0B = 0;var_0B < level.var_134.size;var_0B++)
			{
				level.var_134[var_0B].var_130AC = var_06;
				var_06.var_ABF0 = level.var_134[var_0B];
			}

			level.var_5913[level.var_5913.size] = var_06;
			setdynamicdvar("scr_devPlaceDomFlag","");
		}

		wait(1);
	}
}