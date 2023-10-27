/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\war.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 106 ms
 * Timestamp: 10/27/2023 3:11:55 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	if(getdvar("1673") == "mp_background")
	{
		return;
	}

	maps\mp\gametypes\_globallogic::func_D5();
	lib_01DD::func_8A0C();
	maps\mp\gametypes\_globallogic::func_8A0C();
	if(isusingmatchrulesdata())
	{
		level.var_5300 = ::func_5300;
		[[ level.var_5300 ]]();
		level thread maps\mp\_utility::func_7C13();
	}
	else
	{
		maps\mp\_utility::func_7BF8(level.var_3FDC,0,0,9);
		maps\mp\_utility::func_7BFA(level.var_3FDC,10);
		maps\mp\_utility::func_7BF9(level.var_3FDC,75);
		maps\mp\_utility::func_7BF7(level.var_3FDC,1);
		maps\mp\_utility::func_7C04(level.var_3FDC,1);
		maps\mp\_utility::func_7BF1(level.var_3FDC,0);
		maps\mp\_utility::func_7BE5(level.var_3FDC,0);
		level.var_6031 = 0;
		level.var_6035 = 0;
	}

	maps\mp\_utility::func_873B(1);
	level.var_6BAF = ::func_6BAF;
	level.var_6B5C = ::func_6B5C;
	if(level.var_6031 || level.var_6035)
	{
		level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
	}

	game["dialog"]["gametype"] = "tdm_intro";
	if(getdvarint("2043"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	game["dialog"]["defense_obj"] = "gbl_start";
	game["dialog"]["offense_obj"] = "gbl_start";
	game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";
	if(level.var_7616)
	{
		game["dialog"]["gametype"] = "ptr_welcome";
		game["dialog"]["ptr_new_best"] = "ptr_new_best";
		game["dialog"]["ptr_assist"] = "ptr_assist";
		game["dialog"]["ptr_headshot"] = "ptr_headshot";
		game["dialog"]["ptr_greatshot"] = "ptr_greatshot";
	}
}

//Function Number: 2
func_5300()
{
	maps\mp\_utility::func_8653();
	setdynamicdvar("scr_war_roundswitch",0);
	maps\mp\_utility::func_7BF8("war",0,0,9);
	setdynamicdvar("scr_war_roundlimit",1);
	maps\mp\_utility::func_7BF7("war",1);
	setdynamicdvar("scr_war_winlimit",1);
	maps\mp\_utility::func_7C04("war",1);
	setdynamicdvar("scr_war_halftime",0);
	maps\mp\_utility::func_7BE5("war",0);
}

//Function Number: 3
func_6BAF()
{
	setclientnamemode("auto_change");
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(game["switchedsides"])
	{
		var_00 = game["attackers"];
		var_01 = game["defenders"];
		game["attackers"] = var_01;
		game["defenders"] = var_00;
	}

	maps\mp\_utility::func_86DC("allies",&"OBJECTIVES_WAR");
	maps\mp\_utility::func_86DC("axis",&"OBJECTIVES_WAR");
	if(level.var_910F)
	{
		maps\mp\_utility::func_86DB("allies",&"OBJECTIVES_WAR");
		maps\mp\_utility::func_86DB("axis",&"OBJECTIVES_WAR");
	}
	else
	{
		maps\mp\_utility::func_86DB("allies",&"OBJECTIVES_WAR_SCORE");
		maps\mp\_utility::func_86DB("axis",&"OBJECTIVES_WAR_SCORE");
	}

	maps\mp\_utility::func_86D8("allies",&"OBJECTIVES_WAR_HINT");
	maps\mp\_utility::func_86D8("axis",&"OBJECTIVES_WAR_HINT");
	lib_050D::func_10E4();
	var_02[0] = level.var_3FDC;
	var_02[1] = "blocker_war";
	maps\mp\gametypes\_gameobjects::func_F9(var_02);
}

//Function Number: 4
func_6B5C(param_00,param_01,param_02)
{
	level maps\mp\gametypes\_gamescore::func_47BD(param_01.var_12C["team"],1,1);
	if(game["state"] == "postgame" && game["teamScores"][param_01.var_1A7] > game["teamScores"][level.var_6C63[param_01.var_1A7]])
	{
		param_01.var_3B4B = 1;
	}
}

//Function Number: 5
func_6BB6()
{
	level.var_3B5C = "none";
	if(game["status"] == "overtime")
	{
		var_00 = "forfeit";
	}
	else if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
	{
		var_00 = "overtime";
	}
	else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
	{
		level.var_3B5C = "axis";
		var_00 = "axis";
	}
	else
	{
		level.var_3B5C = "allies";
		var_00 = "allies";
	}

	if(maps\mp\_utility::func_761E())
	{
		var_00 = "none";
	}

	thread maps\mp\gametypes\_gamelogic::func_36B9(var_00,game["end_reason"]["time_limit_reached"]);
}