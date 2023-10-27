/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\conf.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 542 ms
 * Timestamp: 10/27/2023 12:12:20 AM
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
		scripts\mp\_utility::func_DF09(level.gametype,0,0,9);
		scripts\mp\_utility::func_DF11(level.gametype,10);
		scripts\mp\_utility::func_DF0B(level.gametype,65);
		scripts\mp\_utility::func_DF08(level.gametype,1);
		scripts\mp\_utility::func_DF1A(level.gametype,1);
		scripts\mp\_utility::func_DF02(level.gametype,0);
		scripts\mp\_utility::func_DEF4(level.gametype,0);
		scripts\mp\_utility::func_DEEB(level.gametype,1);
		level.var_B40A = 0;
		level.var_B410 = 0;
	}

	func_12E9F();
	level.teambased = 1;
	level.var_C5A4 = ::func_C5A4;
	level.var_8136 = ::func_8136;
	level.var_C55E = ::func_C55E;
	level.onspawnplayer = ::onspawnplayer;
	if(level.var_B40A || level.var_B410)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	game["dialog"]["gametype"] = "kill_confirmed";
	game["dialog"]["kill_confirmed"] = "kill_confirmed";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	level.var_4507["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
}

//Function Number: 2
func_987C()
{
	scripts\mp\_utility::func_F69D();
	setdynamicdvar("scr_conf_pointsPerConfirm",getmatchrulesdata("confData","pointsPerConfirm"));
	setdynamicdvar("scr_conf_pointsPerDeny",getmatchrulesdata("confData","pointsPerDeny"));
	setdynamicdvar("scr_conf_halftime",0);
	scripts\mp\_utility::func_DEF4("conf",0);
	setdynamicdvar("scr_conf_promode",0);
}

//Function Number: 3
func_C5A4()
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

	scripts\mp\_utility::func_F7C1("allies",&"OBJECTIVES_CONF");
	scripts\mp\_utility::func_F7C1("axis",&"OBJECTIVES_CONF");
	if(level.splitscreen)
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_CONF");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_CONF");
	}
	else
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_CONF_SCORE");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_CONF_SCORE");
	}

	scripts\mp\_utility::func_F7BE("allies",&"OBJECTIVES_CONF_HINT");
	scripts\mp\_utility::func_F7BE("axis",&"OBJECTIVES_CONF_HINT");
	func_98CE();
	level.var_58BE = ::func_58BE;
	level.var_58BF = ::func_58BF;
	var_02[0] = level.gametype;
	scripts\mp\_gameobjects::main(var_02);
}

//Function Number: 4
func_98CE()
{
	scripts\mp\_spawnlogic::func_F62D("TDM");
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	scripts\mp\_spawnlogic::func_182D("mp_tdm_spawn_allies_start");
	scripts\mp\_spawnlogic::func_182D("mp_tdm_spawn_axis_start");
	scripts\mp\_spawnlogic::func_1829("allies","mp_tdm_spawn");
	scripts\mp\_spawnlogic::func_1829("allies","mp_tdm_spawn_secondary",1,1);
	scripts\mp\_spawnlogic::func_1829("axis","mp_tdm_spawn");
	scripts\mp\_spawnlogic::func_1829("axis","mp_tdm_spawn_secondary",1,1);
	level.var_B32E = scripts\mp\_spawnlogic::func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
}

//Function Number: 5
func_12E9F()
{
	scripts\mp\gametypes\common::func_12E9F();
	level.var_EC26 = scripts\mp\_utility::dvarintvalue("pointsPerConfirm",1,0,25);
	level.var_EC27 = scripts\mp\_utility::dvarintvalue("pointsPerDeny",0,0,25);
}

//Function Number: 6
func_8136()
{
	var_00 = self.pers["team"];
	if(game["switchedsides"])
	{
		var_00 = scripts\mp\_utility::getotherteam(var_00);
	}

	if(scripts\mp\_spawnlogic::func_100BA())
	{
		var_01 = scripts\mp\_spawnlogic::func_8140("mp_tdm_spawn_" + var_00 + "_start");
		var_02 = scripts\mp\_spawnlogic::func_813F(var_01);
	}
	else
	{
		var_01 = scripts\mp\_spawnlogic::func_81BA(var_02);
		var_03 = scripts\mp\_spawnlogic::func_81A9(var_01);
		var_02 = scripts\mp\_spawnscoring::func_8136(var_01,var_03);
	}

	return var_02;
}

//Function Number: 7
func_C55E(param_00,param_01,param_02,param_03,param_04)
{
	scripts\mp\gametypes\common::func_C55E(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 8
onspawnplayer()
{
	scripts\mp\_utility::func_98D4();
}

//Function Number: 9
func_58BE(param_00)
{
	if(isplayer(param_00))
	{
		param_00 scripts\mp\_utility::func_F6FB(param_00.pers["denied"]);
		param_00 scripts\mp\_gamescore::func_83B0(param_00.pers["team"],level.var_EC27,0);
	}
}

//Function Number: 10
func_58BF(param_00)
{
	if(isplayer(param_00))
	{
		param_00 scripts\mp\_utility::func_AAEC("kill_confirmed",undefined,undefined,undefined,4);
		param_00 scripts\mp\_utility::func_F6FA(param_00.pers["confirmed"]);
	}

	param_00 scripts\mp\_gamescore::func_83B0(param_00.pers["team"],level.var_EC26,0);
}