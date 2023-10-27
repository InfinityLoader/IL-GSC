/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_globallogic.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 363 ms
 * Timestamp: 10/27/2023 12:20:30 AM
*******************************************************************/

//Function Number: 1
init()
{
	setdvar("match_running",1);
	level.splitscreen = function_0114();
	scripts\mp\_utility::func_F305();
	level.onlinegame = getdvarint("onlinegame");
	level.rankedmatch = (level.onlinegame && !getdvarint("xblive_privatematch")) || getdvarint("force_ranking");
	scripts\mp\_utility::func_F7F1();
	level.script = tolower(getdvar("mapname"));
	level.gametype = tolower(getdvar("g_gametype"));
	level.teamnamelist = ["axis","allies"];
	level.var_C74B["allies"] = "axis";
	level.var_C74B["axis"] = "allies";
	level.multiteambased = 0;
	level.teambased = 0;
	level.var_C2A1 = 0;
	level.var_6329 = 1;
	level.var_10130 = 0;
	level.var_11946 = getdvarint("scr_tispawndelay");
	if(!isdefined(level.var_12AC9))
	{
		scripts\mp\_tweakables::init();
	}

	level.var_8865 = "halftime";
	level.var_AA1E = 0;
	level.var_1391F = "none";
	level.var_A9F1 = 0;
	level.var_CC1D["allies"] = [];
	level.var_CC1D["axis"] = [];
	level.var_CC1D["all"] = [];
	level.var_D706 = 3.5;
	level.var_D420 = [];
	func_DEEC();
	if(scripts\mp\_utility::func_B3EC())
	{
		var_00 = " LB_MAP_" + getdvar("ui_mapname");
		var_01 = "";
		var_02 = "";
		var_02 = "LB_GB_TOTALXP_AT LB_GB_TOTALXP_LT LB_GB_WINS_AT LB_GB_WINS_LT LB_GB_KILLS_AT LB_GB_KILLS_LT LB_GB_ACCURACY_AT LB_ACCOLADES";
		var_01 = " LB_GM_" + level.gametype;
		if(getdvarint("g_hardcore"))
		{
			var_01 = var_01 + "_HC";
		}

		precacheleaderboards(var_02 + var_01 + var_00);
	}

	level.var_115C6["allies"] = 0;
	level.var_115C6["axis"] = 0;
	level.var_115C6["spectator"] = 0;
	level.var_1BE6["allies"] = 0;
	level.var_1BE6["axis"] = 0;
	level.var_1BE6["spectator"] = 0;
	level.var_AD8D["allies"] = 0;
	level.var_AD8D["axis"] = 0;
	level.var_C50B = [];
	level.var_8C2A["allies"] = 0;
	level.var_8C2A["axis"] = 0;
	var_03 = 9;
	func_9694(var_03);
}

//Function Number: 2
func_6360()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		if(var_00 ishost())
		{
			var_01 = var_00;
			break;
		}
	}

	var_01 waittill("disconnect");
	thread scripts\mp\_gamelogic::endgame("draw",game["end_reason"]["host_ended_game"]);
}

//Function Number: 3
func_9694(param_00)
{
	for(var_01 = 0;var_01 < param_00;var_01++)
	{
		var_02 = "team_" + var_01;
		level.var_CC1D[var_02] = [];
		level.var_115C6[var_02] = 0;
		level.var_1BE6[var_02] = 0;
		level.var_AD8D[var_02] = 0;
		level.var_8C2A[var_02] = 0;
	}
}

//Function Number: 4
func_DEEC()
{
	setomnvar("ui_bomb_timer",0);
	if(getdvar("r_reflectionProbeGenerate") != "1")
	{
		setomnvar("ui_nuke_end_milliseconds",0);
	}

	setdvar("ui_danger_team","");
	setdvar("ui_inhostmigration",0);
	setdvar("ui_override_halftime",0);
	setdvar("camera_thirdPerson",getdvarint("scr_thirdPerson"));
}

//Function Number: 5
func_FA99()
{
	func_F6B7();
	scripts\mp\_callbacksetup::func_FAA2();
	scripts\mp\gametypes\common::func_FA9C();
	level.var_8136 = ::func_2B53;
	level.onspawnplayer = ::scripts\mp\gametypes\common::onspawnplayer;
	level.var_C583 = ::func_2B53;
	level.var_C5B2 = ::scripts\mp\_gamelogic::func_500A;
	level.var_C539 = ::scripts\mp\_gamelogic::func_5008;
	level.var_C4E8 = ::scripts\mp\_gamelogic::func_5007;
	level.var_C564 = ::scripts\mp\_gamelogic::func_5009;
	level.var_C580 = ::func_2B53;
	level.var_C5A4 = ::func_2B53;
	level.var_C577 = ::func_2B53;
	level.var_A6A2 = ::scripts\mp\killstreaks\_init_mp::init;
	level.var_B3E7 = ::scripts\mp\_matchevents::init;
	level.var_9994 = ::scripts\mp\_intel::init;
	level.var_B3F8 = ::scripts\mp\_matchrecording::init;
	level.var_13CA6 = ::scripts\mp\_utility::func_13CA1;
	level.var_97C2 = ::lib_0D65::func_97C2;
	level.var_F635 = ::lib_0D65::func_F290;
	level.var_190A = ::scripts\mp\_utility::func_143A;
	level.var_1908 = ::lib_0D65::func_1908;
	level.var_7EC5 = ::lib_0D65::func_7EC5;
	level.var_184B = ::scripts\mp\_spawnlogic::func_184B;
}

//Function Number: 6
func_F6B7()
{
	level.var_3768 = ::scripts\mp\_gamelogic::func_3757;
	level.var_375F = ::scripts\mp\_playerlogic::func_374C;
	level.var_3761 = ::scripts\mp\_playerlogic::func_374F;
	level.callbackplayerdamage = ::scripts\mp\_damage::func_374D;
	level.var_3762 = ::scripts\mp\_damage::func_3750;
	level.var_3763 = ::scripts\mp\_damage::func_3751;
	level.var_3764 = ::scripts\mp\_damage::func_3752;
	level.var_3766 = ::scripts\mp\_playerlogic::func_3755;
	level.var_375E = ::scripts\mp\_hostmigration::func_3749;
	level.callbackfinishweaponchange = ::scripts\mp\_weapons::callback_finishweaponchange;
}

//Function Number: 7
func_2B53(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
}

//Function Number: 8
func_11757()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		wait(3);
		var_00 = randomint(6);
		for(var_01 = 0;var_01 < var_00;var_01++)
		{
			iprintlnbold(var_00);
			self shellshock("frag_grenade_mp",0.2);
			wait(0.1);
		}
	}
}

//Function Number: 9
func_4F48(param_00,param_01)
{
	for(var_02 = 0;var_02 < 50;var_02++)
	{
		wait(0.05);
	}
}