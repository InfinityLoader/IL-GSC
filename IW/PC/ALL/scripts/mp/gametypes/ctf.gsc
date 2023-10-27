/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\ctf.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 46
 * Decompile Time: 2385 ms
 * Timestamp: 10/27/2023 12:12:23 AM
*******************************************************************/

//Function Number: 1
main()
{
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
		scripts\mp\_utility::func_DF11(level.gametype,5);
		scripts\mp\_utility::func_DF0B(level.gametype,3);
		scripts\mp\_utility::func_DF08(level.gametype,2);
		scripts\mp\_utility::func_DF1A(level.gametype,1);
		scripts\mp\_utility::func_DF02(level.gametype,0);
		scripts\mp\_utility::func_DEF4(level.gametype,0);
		scripts\mp\_utility::func_DF09(level.gametype,1,0,1);
		level.var_B40A = 0;
		level.var_B410 = 0;
	}

	func_12E9F();
	if(level.var_13D8D)
	{
		level.var_13D7C = "teamScores";
	}
	else
	{
		level.var_13D7C = "roundsWon";
	}

	level.teambased = 1;
	level.var_C2A1 = 1;
	level.var_C82C = 1;
	level.var_C5A4 = ::func_C5A4;
	level.var_8136 = ::func_8136;
	level.var_C577 = ::func_C577;
	level.onspawnplayer = ::onspawnplayer;
	level.var_108EB = "mp_ctf_spawn";
	if(level.var_B40A || level.var_B410)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	game["dialog"]["gametype"] = "captureflag";
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

	game["dialog"]["offense_obj"] = "capture_obj";
	game["dialog"]["defense_obj"] = "capture_obj";
	setomnvar("ui_ctf_flag_axis",-2);
	setomnvar("ui_ctf_flag_allies",-2);
	thread func_C56E();
}

//Function Number: 2
func_987C()
{
	scripts\mp\_utility::func_F69D();
	setdynamicdvar("scr_ctf_winRule",getmatchrulesdata("ctfData","winRule"));
	setdynamicdvar("scr_ctf_showEnemyCarrier",getmatchrulesdata("ctfData","showEnemyCarrier"));
	setdynamicdvar("scr_ctf_idleResetTime",getmatchrulesdata("ctfData","idleResetTime"));
	setdynamicdvar("scr_ctf_captureCondition",getmatchrulesdata("ctfData","captureCondition"));
	setdynamicdvar("scr_ctf_pickupTime",getmatchrulesdata("ctfData","pickupTime"));
	setdynamicdvar("scr_ctf_returnTime",getmatchrulesdata("ctfData","returnTime"));
	setdynamicdvar("scr_ctf_halftime",0);
	scripts\mp\_utility::func_DEF4("ctf",0);
	setdynamicdvar("scr_ctf_promode",0);
}

//Function Number: 3
onspawnplayer()
{
}

//Function Number: 4
func_C5A4()
{
	var_00 = scripts\mp\_utility::func_9900();
	var_01 = game["overtimeRoundsPlayed"] == 0;
	var_02 = scripts\mp\_utility::func_9FAB();
	if(var_00)
	{
		if(var_01)
		{
			setomnvar("ui_round_hint_override_attackers",1);
			setomnvar("ui_round_hint_override_defenders",1);
		}
		else if(var_02)
		{
			setomnvar("ui_round_hint_override_attackers",scripts\common\utility::func_116D7(game["timeToBeatTeam"] == game["attackers"],2,3));
			setomnvar("ui_round_hint_override_defenders",scripts\common\utility::func_116D7(game["timeToBeatTeam"] == game["defenders"],2,3));
		}
		else
		{
			setomnvar("ui_round_hint_override_attackers",4);
			setomnvar("ui_round_hint_override_defenders",4);
		}
	}

	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(scripts\mp\_utility::func_9900())
	{
		setdvar("ui_override_halftime",0);
	}
	else if(game["switchedsides"])
	{
		setdvar("ui_override_halftime",2);
	}
	else
	{
		setdvar("ui_override_halftime",1);
	}

	if(!isdefined(game["original_defenders"]))
	{
		game["original_defenders"] = game["defenders"];
	}

	if(game["switchedsides"])
	{
		var_03 = game["attackers"];
		var_04 = game["defenders"];
		game["attackers"] = var_04;
		game["defenders"] = var_03;
	}

	setclientnamemode("auto_change");
	if(level.splitscreen)
	{
		scripts\mp\_utility::func_F7C0(game["attackers"],&"OBJECTIVES_ONE_FLAG_ATTACKER");
		scripts\mp\_utility::func_F7C0(game["defenders"],&"OBJECTIVES_ONE_FLAG_DEFENDER");
	}
	else
	{
		scripts\mp\_utility::func_F7C0(game["attackers"],&"OBJECTIVES_ONE_FLAG_ATTACKER_SCORE");
		scripts\mp\_utility::func_F7C0(game["defenders"],&"OBJECTIVES_ONE_FLAG_DEFENDER_SCORE");
	}

	scripts\mp\_utility::func_F7C1(game["attackers"],&"OBJECTIVES_CTF");
	scripts\mp\_utility::func_F7C1(game["defenders"],&"OBJECTIVES_CTF");
	scripts\mp\_utility::func_F7BE(game["attackers"],&"OBJECTIVES_ONE_FLAG_ATTACKER_HINT");
	scripts\mp\_utility::func_F7BE(game["defenders"],&"OBJECTIVES_ONE_FLAG_DEFENDER_HINT");
	func_6E31();
	var_05[0] = "ctf";
	scripts\mp\_gameobjects::main(var_05);
	func_6E44();
	func_49B1();
	func_98CE();
	thread func_E0F9();
	thread func_CC19();
}

//Function Number: 5
func_12E9F()
{
	scripts\mp\gametypes\common::func_12E9F();
	level.var_13D8D = scripts\mp\_utility::dvarintvalue("winRule",0,0,1);
	level.var_10120 = scripts\mp\_utility::dvarintvalue("showEnemyCarrier",5,0,6);
	level.var_92F7 = scripts\mp\_utility::dvarfloatvalue("idleResetTime",30,0,60);
	level.var_3A3C = scripts\mp\_utility::dvarintvalue("captureCondition",0,0,1);
	level.var_CB48 = scripts\mp\_utility::dvarfloatvalue("pickupTime",0,0,10);
	level.var_E479 = scripts\mp\_utility::dvarfloatvalue("returnTime",0,-1,25);
}

//Function Number: 6
func_49B1()
{
	level.var_6E67["allies"] = "ctf_game_flag_unsa_open_wm";
	level.var_6E61["allies"] = "ctf_game_flag_unsa_base_wm";
	level.var_3AF4["allies"] = "ctf_game_flag_unsa_close_wm";
	level.var_6E67["axis"] = "ctf_game_flag_sdf_open_wm";
	level.var_6E61["axis"] = "ctf_game_flag_sdf_base_wm";
	level.var_3AF4["axis"] = "ctf_game_flag_sdf_close_wm";
	level.var_4282 = [];
	level.var_4282["allies"] = undefined;
	level.var_4282["axis"] = undefined;
	level.var_92A9 = "waypoint_escort";
	level.var_92A8 = "waypoint_escort";
	level.var_92AD = "waypoint_capture_kill";
	level.var_92AC = "waypoint_capture_kill";
	level.var_929C = "waypoint_capture_take";
	level.var_929B = "waypoint_capture_take";
	level.var_92A2 = "waypoint_blitz_defend";
	level.var_92A1 = "waypoint_blitz_defend";
	level.var_92B3 = "waypoint_capture_recover";
	level.var_92B2 = "waypoint_capture_recover";
	level.var_115CC[game["defenders"]] = func_4A21(game["defenders"],"axis");
	level.var_115CC[game["attackers"]] = func_4A21(game["attackers"],"allies");
	level.var_3A42[game["defenders"]] = func_4991(game["defenders"],"axis");
	level.var_3A42[game["attackers"]] = func_4991(game["attackers"],"allies");
}

//Function Number: 7
func_6E44()
{
	level.var_6E63["friendly"] = loadfx("vfx/iw7/core/mp/vfx_ctf_base_glow_fr.vfx");
	level.var_6E63["enemy"] = loadfx("vfx/iw7/core/mp/vfx_ctf_base_glow_en.vfx");
	level.var_6E6A["friendly"] = loadfx("vfx/core/mp/core/vfx_marker_flag_cyan.vfx");
	level.var_6E6A["enemy"] = loadfx("vfx/core/mp/core/vfx_marker_flag_orng.vfx");
}

//Function Number: 8
func_98CE()
{
	scripts\mp\_spawnlogic::func_F62D("AwayFromEnemies");
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	scripts\mp\_spawnlogic::func_182D("mp_ctf_spawn_allies_start");
	scripts\mp\_spawnlogic::func_182D("mp_ctf_spawn_axis_start");
	scripts\mp\_spawnlogic::func_1829("allies","mp_ctf_spawn");
	scripts\mp\_spawnlogic::func_1829("axis","mp_ctf_spawn");
	level.var_B32E = scripts\mp\_spawnlogic::func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
	func_23E3();
}

//Function Number: 9
func_23E3()
{
	var_00 = scripts\mp\_spawnlogic::func_8140(level.var_108EB);
	var_01 = scripts\mp\_spawnlogic::func_9ED7();
	level.var_115EA["axis"] = [];
	level.var_115EA["allies"] = [];
	level.var_115EA["neutral"] = [];
	if(level.var_115CC.size == 2)
	{
		var_02 = level.var_115CC["allies"];
		var_03 = level.var_115CC["axis"];
		var_04 = (var_02.var_4B2C[0],var_02.var_4B2C[1],0);
		var_05 = (var_03.var_4B2C[0],var_03.var_4B2C[1],0);
		var_06 = var_05 - var_04;
		var_07 = length2d(var_06);
		foreach(var_09 in var_00)
		{
			var_0A = (var_09.origin[0],var_09.origin[1],0);
			var_0B = var_0A - var_04;
			var_0C = vectordot(var_0B,var_06);
			var_0D = var_0C / var_07 * var_07;
			if(var_0D < 0.33)
			{
				var_09.var_115C2 = var_02.ownerteam;
				level.var_115EA[var_09.var_115C2][level.var_115EA[var_09.var_115C2].size] = var_09;
				continue;
			}

			if(var_0D > 0.67)
			{
				var_09.var_115C2 = var_03.ownerteam;
				level.var_115EA[var_09.var_115C2][level.var_115EA[var_09.var_115C2].size] = var_09;
				continue;
			}

			var_0E = undefined;
			var_0F = undefined;
			if(var_01)
			{
				var_0E = function_00C0(var_09.origin,var_02.var_4B2C,999999);
			}

			if(isdefined(var_0E) && var_0E != -1)
			{
				var_0F = function_00C0(var_09.origin,var_03.var_4B2C,999999);
			}

			if(!isdefined(var_0F) || var_0F == -1)
			{
				var_0E = distance2d(var_02.var_4B2C,var_09.origin);
				var_0F = distance2d(var_03.var_4B2C,var_09.origin);
			}

			var_10 = max(var_0E,var_0F);
			var_11 = min(var_0E,var_0F);
			var_12 = var_11 / var_10;
			if(var_12 > 0.5)
			{
				level.var_115EA["neutral"][level.var_115EA["neutral"].size] = var_09;
			}
		}

		return;
	}

	foreach(var_09 in var_01)
	{
		var_09.var_115C2 = func_7FDD(var_09);
		if(var_09.var_115C2 == "axis")
		{
			level.var_115EA["axis"][level.var_115EA["axis"].size] = var_09;
			continue;
		}

		level.var_115EA["allies"][level.var_115EA["allies"].size] = var_09;
	}
}

//Function Number: 10
func_7FDD(param_00)
{
	var_01 = scripts\mp\_spawnlogic::func_9ED7();
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_05 in level.var_115CC)
	{
		var_06 = undefined;
		if(var_01)
		{
			var_06 = function_00C0(param_00.origin,var_05.var_4B2C,999999);
		}

		if(!isdefined(var_06) || var_06 == -1)
		{
			var_06 = distancesquared(var_05.var_4B2C,param_00.origin);
		}

		if(!isdefined(var_02) || var_06 < var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	return var_02.ownerteam;
}

//Function Number: 11
func_8136()
{
	var_00 = self.pers["team"];
	var_01 = scripts\mp\_utility::getotherteam(var_00);
	if(scripts\mp\_spawnlogic::func_100BA())
	{
		if(game["switchedsides"])
		{
			var_02 = scripts\mp\_spawnlogic::func_8140("mp_ctf_spawn_" + var_01 + "_start");
			var_03 = scripts\mp\_spawnlogic::func_813F(var_02);
		}
		else
		{
			var_02 = scripts\mp\_spawnlogic::func_8140("mp_ctf_spawn_" + var_02 + "_start");
			var_03 = scripts\mp\_spawnlogic::func_813F(var_03);
		}
	}
	else
	{
		var_04 = level.var_115EA["neutral"].size > 0;
		var_02 = scripts\mp\_spawnlogic::func_81BA(var_00);
		var_03 = scripts\mp\_spawnscoring::func_8136(var_02,undefined,undefined,var_04);
		if(!isdefined(var_03) && var_04)
		{
			var_02 = scripts\mp\_spawnlogic::func_81BA("neutral");
			var_03 = scripts\mp\_spawnscoring::func_8136(var_02);
		}
	}

	return var_03;
}

//Function Number: 12
func_6E31()
{
	level.var_4FF4 = [];
	level.var_134 = getentarray("flag_primary","targetname");
	foreach(var_01 in level.var_134)
	{
		switch(var_01.script_label)
		{
			case "_a":
				level.var_4FEF[game["attackers"]] = var_01.origin;
				break;

			case "_b":
				level.var_4FDB = var_01.origin;
				break;

			case "_c":
				level.var_4FEF[game["defenders"]] = var_01.origin;
				break;
		}
	}
}

//Function Number: 13
func_6E30(param_00)
{
	var_01 = 0;
	var_02 = undefined;
	if(isdefined(var_02))
	{
		var_02 func_6E36();
		var_02.origin = var_02.var_862F;
	}
	else
	{
		var_02 = spawnstruct();
		switch(level.script)
		{
			default:
				break;
		}

		if(!isdefined(var_02.origin))
		{
			var_02.origin = level.var_4FEF[param_00];
		}

		var_02 func_6E36();
		var_02.origin = var_02.var_862F;
	}

	var_02.var_257 = 30;
	var_02.team = param_00;
	var_02.var_279B = 0;
	var_02.var_8EE8 = 0;
	return var_02;
}

//Function Number: 14
func_6E36(param_00)
{
	var_01 = self.origin + (0,0,32);
	var_02 = self.origin + (0,0,-1000);
	var_03 = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
	var_04 = [];
	var_05 = scripts\common\trace::func_DCED(var_01,var_02,var_04,var_03);
	self.var_862F = var_05["position"];
	return var_05["fraction"] != 0 && var_05["fraction"] != 1;
}

//Function Number: 15
func_10127(param_00,param_01,param_02)
{
	if(isdefined(param_01.var_1289[param_00]))
	{
		param_01.var_1289[param_00] delete();
	}

	var_03 = undefined;
	var_04 = param_01.team;
	var_05 = param_01 ismlgspectator();
	if(var_05)
	{
		var_04 = param_01 method_813B();
	}
	else if(var_04 == "spectator")
	{
		var_04 = "allies";
	}

	if(var_04 == param_00)
	{
		var_06 = function_01E1(level.var_6E6A["friendly"],param_02,param_01,(0,0,1));
		var_06 method_82EC();
	}
	else
	{
		var_06 = function_01E1(level.var_6E6A["enemy"],var_03,param_02,(0,0,1));
		var_06 method_82EC();
	}

	param_01.var_1289[param_00] = var_06;
	triggerfx(var_06);
}

//Function Number: 16
func_10110(param_00,param_01)
{
	if(isdefined(param_01.var_1288[param_00]))
	{
		param_01.var_1288[param_00] delete();
	}

	var_02 = undefined;
	var_03 = param_01.team;
	var_04 = param_01 ismlgspectator();
	if(var_04)
	{
		var_03 = param_01 method_813B();
	}
	else if(var_03 == "spectator")
	{
		var_03 = "allies";
	}

	if(var_03 == param_00)
	{
		var_05 = function_01E1(level.var_6E63["friendly"],self.origin,param_01,self.var_289C);
		var_05 method_82EC();
	}
	else
	{
		var_05 = function_01E1(level.var_6E63["enemy"],self.origin,var_02,self.var_289C);
		var_05 method_82EC();
	}

	param_01.var_1288[param_00] = var_05;
	triggerfx(var_05);
}

//Function Number: 17
func_E0FB(param_00)
{
	if(param_00 == self.team)
	{
		if(isdefined(self.var_1289[self.team]))
		{
			self.var_1289[self.team] delete();
			return;
		}

		return;
	}

	if(isdefined(self.var_1289[level.var_C74B[self.team]]))
	{
		self.var_1289[level.var_C74B[self.team]] delete();
	}
}

//Function Number: 18
setteaminhuddatafromteamname(param_00)
{
	if(param_00 == "axis")
	{
		self method_85AA(1);
		return;
	}

	if(param_00 == "allies")
	{
		self method_85AA(2);
		return;
	}

	self method_85AA(0);
}

//Function Number: 19
func_D018(param_00)
{
	if(param_00 == self.team)
	{
		if(isdefined(self.var_1288[self.team]))
		{
			self.var_1288[self.team] delete();
			return;
		}

		return;
	}

	if(isdefined(self.var_1288[level.var_C74B[self.team]]))
	{
		self.var_1288[level.var_C74B[self.team]] delete();
	}
}

//Function Number: 20
func_7EBA(param_00)
{
	var_01 = getent("ctf_flag_" + param_00,"targetname");
	return var_01.origin;
}

//Function Number: 21
func_4A21(param_00,param_01)
{
	var_02 = 0;
	var_03 = getent("ctf_zone_" + param_01,"targetname");
	if(!isdefined(var_03))
	{
		var_04 = func_6E30(param_00);
		var_03 = spawn("trigger_radius",var_04.origin - (0,0,var_04.var_257 / 2),0,var_04.var_257,80);
		var_03.var_C000 = 1;
		var_03.var_AD48 = 1;
		var_03.var_28AC = var_03.origin;
		var_02 = 1;
		var_05[0] = spawn("script_model",var_04.origin);
		var_05[0] method_8588();
		var_05[0] setteaminhuddatafromteamname(param_01);
	}
	else
	{
		var_05[0] = getent("ctf_flag_" + var_02,"targetname");
	}

	if(!isdefined(var_05[0]))
	{
	}

	if(!var_02)
	{
		var_06 = 15;
		if(level.var_CB48 > 0 || level.var_E479 > 0)
		{
			var_06 = var_06 * 2;
		}

		var_07 = spawn("trigger_radius",var_03.origin,0,var_06,var_03.height);
		var_03 = var_07;
	}

	var_05[0] setmodel(level.var_6E67[param_00]);
	var_05[0] method_8588();
	var_05[0] setteaminhuddatafromteamname(param_01);
	var_08 = scripts\mp\_gameobjects::func_4993(param_00,var_03,var_05,(0,0,85));
	var_08 scripts\mp\_gameobjects::func_F87C("enemy",&"MP_GRABBING_FLAG");
	var_08 scripts\mp\_gameobjects::func_F87C("friendly",&"MP_RETURNING_FLAG");
	var_08 scripts\mp\_gameobjects::func_1C7C("enemy");
	var_08 scripts\mp\_gameobjects::func_F87D("enemy",level.var_CB48);
	var_08 scripts\mp\_gameobjects::func_F87D("friendly",level.var_E479);
	var_08 scripts\mp\_gameobjects::setvisibleteam("none");
	var_08 scripts\mp\_gameobjects::func_F283("friendly",level.var_92AC);
	var_08 scripts\mp\_gameobjects::func_F284("friendly",level.var_92AD);
	var_08 scripts\mp\_gameobjects::func_F283("enemy",level.var_92A8);
	var_08 scripts\mp\_gameobjects::func_F284("enemy",level.var_92A9);
	var_08.var_1CB3 = 1;
	var_08.var_C566 = ::func_C566;
	var_08.var_C567 = ::func_C566;
	var_08.var_C4F9 = ::func_C4F9;
	var_08.var_C581 = ::func_C581;
	if(isdefined(level.var_10120))
	{
		switch(level.var_10120)
		{
			case 0:
				var_08.var_C2BE = 1;
				var_08.var_C2BD = 0;
				var_08.var_C2BF = 60;
				break;

			case 1:
				var_08.var_C2BE = 0;
				var_08.var_C2BD = 0;
				var_08.var_C2BF = 0.05;
				break;

			case 2:
				var_08.var_C2BE = 1;
				var_08.var_C2BD = 0;
				var_08.var_C2BF = 1;
				break;

			case 3:
				var_08.var_C2BE = 1;
				var_08.var_C2BD = 0;
				var_08.var_C2BF = 1.5;
				break;

			case 4:
				var_08.var_C2BE = 1;
				var_08.var_C2BD = 0;
				var_08.var_C2BF = 2;
				break;

			case 5:
				var_08.var_C2BE = 1;
				var_08.var_C2BD = 0;
				var_08.var_C2BF = 3;
				break;

			case 6:
				var_08.var_C2BE = 1;
				var_08.var_C2BD = 0;
				var_08.var_C2BF = 4;
				break;
		}
	}
	else
	{
		var_08.var_C2BE = 1;
		var_08.var_C2BD = 0;
		var_08.var_C2BF = 3;
	}

	var_08.var_C402 = var_03.var_257;
	var_09 = var_03.origin + (0,0,32);
	var_0A = var_03.origin + (0,0,-32);
	var_0B = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
	var_0C = [];
	var_0D = scripts\common\trace::func_DCED(var_09,var_0A,var_0C,var_0B);
	var_08.var_289D = var_08.visuals[0].origin;
	var_0E = anglestoup(var_08.visuals[0].angles);
	var_08.var_289C = anglestoforward(var_0E);
	level.var_115CB[param_00] = func_4A22(param_00,var_08);
	return var_08;
}

//Function Number: 22
func_4A22(param_00,param_01)
{
	var_02 = param_01.visuals[0].origin;
	var_03 = spawn("script_model",var_02);
	var_03 setmodel(level.var_6E61[param_00]);
	var_03.ownerteam = param_00;
	var_03 method_8588();
	var_03 setteaminhuddatafromteamname(param_00);
	var_03.var_289D = var_02;
	var_04 = anglestoup(param_01.visuals[0].angles);
	var_03.var_289C = anglestoforward(var_04);
	foreach(var_06 in level.players)
	{
		var_03 func_10110(param_00,var_06);
	}

	return var_03;
}

//Function Number: 23
func_4991(param_00,param_01)
{
	var_02 = func_6E30(param_00);
	var_03 = getent("ctf_zone_" + param_01,"targetname");
	if(!isdefined(var_03))
	{
		var_03 = spawn("trigger_radius",var_02.origin - (0,0,var_02.var_257 / 2),0,var_02.var_257,80);
		var_03.var_C000 = 1;
		var_03.var_AD48 = 1;
		var_03.var_28AC = var_03.origin;
		var_03.height = 80;
	}

	var_04 = spawn("trigger_radius",var_03.origin,0,15,var_03.height);
	var_03 = var_04;
	var_05 = [];
	var_06 = scripts\mp\_gameobjects::func_4A2E(param_00,var_03,var_05,(0,0,85));
	var_06 scripts\mp\_gameobjects::func_1CAF("friendly");
	var_06 scripts\mp\_gameobjects::setvisibleteam("any");
	var_06 scripts\mp\_gameobjects::func_F283("friendly",level.var_92A1);
	var_06 scripts\mp\_gameobjects::func_F284("friendly",level.var_92A2);
	var_06 scripts\mp\_gameobjects::func_F283("enemy",level.var_929B);
	var_06 scripts\mp\_gameobjects::func_F284("enemy",level.var_929C);
	var_06 scripts\mp\_gameobjects::func_FB08(0);
	var_06 scripts\mp\_gameobjects::func_F76A(level.var_115CC[scripts\mp\_utility::getotherteam(param_00)]);
	var_06.var_C5BB = ::func_C5BB;
	var_06.var_C4D4 = ::func_C4D4;
	var_07 = var_03.origin + (0,0,32);
	var_08 = var_03.origin + (0,0,-32);
	var_09 = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
	var_0A = [];
	var_0B = scripts\common\trace::func_DCED(var_07,var_08,var_0A,var_09);
	var_0C = vectortoangles(var_0B["normal"]);
	var_0D = anglestoforward(var_0C);
	var_0E = anglestoright(var_0C);
	return var_06;
}

//Function Number: 24
func_C4CB(param_00)
{
	var_01 = param_00.pers["team"];
	if(var_01 == scripts\mp\_gameobjects::func_803E())
	{
		self.trigger.var_257 = 1024;
		return;
	}

	self.trigger.var_257 = self.var_C402;
}

//Function Number: 25
func_C50D(param_00,param_01,param_02)
{
	self.trigger.var_257 = self.var_C402;
}

//Function Number: 26
func_C566(param_00)
{
	self notify("picked_up");
	param_00 notify("obj_picked_up");
	var_01 = param_00.pers["team"];
	if(var_01 == "allies")
	{
		var_02 = "axis";
	}
	else
	{
		var_02 = "allies";
	}

	if(var_01 == scripts\mp\_gameobjects::func_803E())
	{
		if(isdefined(level.var_4282[param_00.team]) && level.var_4282[param_00.team] == param_00)
		{
			param_00 thread scripts\mp\_awards::func_8380("mode_ctf_nope");
		}

		scripts\mp\_utility::func_F79E(11,param_00.team,param_00 getentitynumber());
		level.var_4282[param_00.team] = undefined;
		param_00 thread scripts\mp\_utility::func_83B4("flag_return");
		thread func_E471();
		param_00 thread scripts\mp\_matchdata::func_AFBA("obj_return",param_00.origin);
		scripts\mp\_utility::printandsoundoneveryone(var_01,scripts\mp\_utility::getotherteam(var_01),&"MP_FLAG_RETURNED",&"MP_ENEMY_FLAG_RETURNED","mp_obj_returned","mp_obj_returned",param_00);
		scripts\mp\_utility::func_AAE7("enemy_flag_returned",var_02,"status");
		scripts\mp\_utility::func_AAE7("flag_returned",var_01,"status");
		param_00 scripts\mp\_utility::func_93DF("returns",1);
		param_00 scripts\mp\_persistence::func_10E56("round","returns",param_00.pers["returns"]);
		if(isplayer(param_00))
		{
			param_00 scripts\mp\_utility::func_F6FB(param_00.pers["returns"]);
		}

		if(var_01 == "allies")
		{
			setomnvar("ui_ctf_flag_allies",-2);
			return;
		}

		setomnvar("ui_ctf_flag_axis",-2);
		return;
	}

	if(isdefined(level.var_4B05) && isdefined(level.var_4B05[var_01]))
	{
		param_00 thread func_20C9();
	}
	else
	{
		param_00 func_2480();
	}

	scripts\mp\_utility::func_F79E(8,param_00.team,param_00 getentitynumber());
	level.var_4282[var_02] = undefined;
	if(param_00.team == "allies")
	{
		setomnvar("ui_ctf_flag_axis",param_00 getentitynumber());
	}
	else
	{
		setomnvar("ui_ctf_flag_allies",param_00 getentitynumber());
	}

	param_00 setclientomnvar("ui_ctf_flag_carrier",1);
	if(isdefined(level.var_10120))
	{
		if(level.var_10120 == 0)
		{
			scripts\mp\_gameobjects::setvisibleteam("enemy");
		}
		else
		{
			scripts\mp\_gameobjects::setvisibleteam("any");
		}
	}

	scripts\mp\_gameobjects::func_F283("friendly",level.var_92AC);
	scripts\mp\_gameobjects::func_F284("friendly",level.var_92AD);
	scripts\mp\_gameobjects::func_F283("enemy",level.var_92A8);
	scripts\mp\_gameobjects::func_F284("enemy",level.var_92A9);
	if(level.var_3A3C == 0)
	{
		level.var_3A42[var_02] scripts\mp\_gameobjects::func_1CAF("none");
	}

	level.var_3A42[var_02] scripts\mp\_gameobjects::setvisibleteam("none");
	scripts\mp\_utility::printandsoundoneveryone(var_01,var_02,&"MP_ENEMY_FLAG_TAKEN_BY",&"MP_FLAG_TAKEN_BY","mp_obj_taken","mp_enemy_obj_taken",param_00);
	scripts\mp\_utility::func_AAE7("enemy_flag_taken",var_01);
	scripts\mp\_utility::func_AAE7("flag_getback",var_02);
	thread scripts\mp\_utility::func_115DE("callout_flagpickup",param_00);
	if(!isdefined(self.previouscarrier) || self.previouscarrier != param_00)
	{
		param_00 thread scripts\mp\_utility::func_83B4("flag_grab");
	}

	param_00 thread scripts\mp\_matchdata::func_AFBA("pickup",param_00.origin);
	self.previouscarrier = param_00;
	if(getdvarint("com_codcasterEnabled",0) == 1)
	{
		param_00 method_80C1(1);
	}

	param_00 thread func_11237();
}

//Function Number: 27
func_E471()
{
	scripts\mp\_utility::func_F79E(11,scripts\mp\_gameobjects::func_803E());
	scripts\mp\_gameobjects::func_E472();
}

//Function Number: 28
func_C4F9(param_00)
{
	var_01 = scripts\mp\_gameobjects::func_803E();
	var_02 = level.var_C74B[var_01];
	scripts\mp\_gameobjects::func_1C7C("any");
	scripts\mp\_gameobjects::setvisibleteam("any");
	if(level.var_E479 >= 0)
	{
		scripts\mp\_gameobjects::func_F283("friendly",level.var_92B2);
		scripts\mp\_gameobjects::func_F284("friendly",level.var_92B3);
	}
	else
	{
		scripts\mp\_gameobjects::func_F283("friendly",level.var_92A1);
		scripts\mp\_gameobjects::func_F284("friendly",level.var_92A2);
	}

	scripts\mp\_gameobjects::func_F283("enemy",level.var_929B);
	scripts\mp\_gameobjects::func_F284("enemy",level.var_929C);
	if(var_01 == "allies")
	{
		setomnvar("ui_ctf_flag_allies",-1);
	}
	else
	{
		setomnvar("ui_ctf_flag_axis",-1);
	}

	if(isdefined(param_00))
	{
		param_00 setclientomnvar("ui_ctf_flag_carrier",0);
	}

	var_03 = self.visuals[0] gettagorigin("tag_origin");
	level.var_3A42[var_02].trigger scripts\mp\_entityheadicons::func_F73D("none","",(0,0,0));
	if(isdefined(param_00))
	{
		if(!scripts\mp\_utility::func_9F19(param_00))
		{
			param_00.var_3AF7.previouscarrier = undefined;
		}

		if(isdefined(param_00.var_3AF4))
		{
			param_00 func_5391();
		}

		scripts\mp\_utility::printandsoundoneveryone(var_02,"none",&"MP_ENEMY_FLAG_DROPPED_BY","","mp_war_objective_lost","",param_00);
		if(getdvarint("com_codcasterEnabled",0) == 1)
		{
			param_00 method_80C1(0);
		}
	}
	else
	{
		scripts\mp\_utility::playsoundonplayers("mp_war_objective_lost",var_02);
	}

	scripts\mp\_utility::func_AAE7("enemy_flag_dropped",var_02,"status");
	scripts\mp\_utility::func_AAE7("flag_dropped",var_01,"status");
	if(level.var_92F7 > 0)
	{
		thread func_E46B();
	}
}

//Function Number: 29
func_E46B()
{
	self endon("picked_up");
	var_00 = 0;
	while(var_00 < level.var_92F7)
	{
		wait(0.05);
		if(self.claimteam == "none")
		{
			var_00 = var_00 + 0.05;
		}
	}

	var_01 = scripts\mp\_gameobjects::func_803E();
	var_02 = level.var_C74B[var_01];
	scripts\mp\_utility::playsoundonplayers("mp_war_objective_taken",var_01);
	scripts\mp\_utility::playsoundonplayers("mp_war_objective_lost",var_02);
	scripts\mp\_utility::func_F79E(11,scripts\mp\_gameobjects::func_803E());
	scripts\mp\_gameobjects::func_E472();
}

//Function Number: 30
func_C581()
{
	var_00 = scripts\mp\_gameobjects::func_803E();
	var_01 = level.var_C74B[var_00];
	scripts\mp\_gameobjects::func_1C7C("enemy");
	scripts\mp\_gameobjects::setvisibleteam("none");
	scripts\mp\_gameobjects::func_F283("friendly",level.var_92AC);
	scripts\mp\_gameobjects::func_F284("friendly",level.var_92AD);
	scripts\mp\_gameobjects::func_F283("enemy",level.var_92A8);
	scripts\mp\_gameobjects::func_F284("enemy",level.var_92A9);
	if(var_00 == "allies")
	{
		setomnvar("ui_ctf_flag_allies",-2);
	}
	else
	{
		setomnvar("ui_ctf_flag_axis",-2);
	}

	level.var_3A42[var_00] scripts\mp\_gameobjects::func_1CAF("friendly");
	level.var_3A42[var_00] scripts\mp\_gameobjects::setvisibleteam("any");
	level.var_3A42[var_00] scripts\mp\_gameobjects::func_F283("friendly",level.var_92A1);
	level.var_3A42[var_00] scripts\mp\_gameobjects::func_F284("friendly",level.var_92A2);
	level.var_3A42[var_00] scripts\mp\_gameobjects::func_F283("enemy",level.var_929B);
	level.var_3A42[var_00] scripts\mp\_gameobjects::func_F284("enemy",level.var_929C);
	level.var_3A42[var_00].trigger scripts\mp\_entityheadicons::func_F73D("none","",(0,0,0));
	self.previouscarrier = undefined;
}

//Function Number: 31
func_C5BB(param_00)
{
	if(!level.var_7669)
	{
		var_01 = param_00.pers["team"];
		if(var_01 == "allies")
		{
			var_02 = "axis";
		}
		else
		{
			var_02 = "allies";
		}

		param_00 setclientomnvar("ui_ctf_flag_carrier",0);
		scripts\mp\_utility::func_AAE7("enemy_flag_captured",var_01,"status");
		scripts\mp\_utility::func_AAE7("flag_captured",var_02,"status");
		thread scripts\mp\_utility::func_115DE("callout_flagcapture",param_00);
		param_00 thread scripts\mp\_awards::func_8380("mode_ctf_cap");
		param_00 notify("objective","captured");
		param_00 thread scripts\mp\_matchdata::func_AFBA("capture",param_00.origin);
		if(getdvarint("com_codcasterEnabled",0) == 1)
		{
			param_00 method_80C1(0);
		}

		param_00 scripts\mp\_utility::func_93DF("captures",1);
		param_00 scripts\mp\_persistence::func_10E56("round","captures",param_00.pers["captures"]);
		if(isplayer(param_00))
		{
			param_00 scripts\mp\_utility::func_F6FA(param_00.pers["captures"]);
		}

		scripts\mp\_utility::printandsoundoneveryone(var_01,var_02,&"MP_ENEMY_FLAG_CAPTURED_BY",&"MP_FRIENDLY_FLAG_CAPTURED_BY","mp_obj_captured","mp_enemy_obj_captured",param_00);
		if(isdefined(param_00.var_3AF4))
		{
			param_00 func_5391();
		}

		if(isdefined(level.var_4B05) && isdefined(level.var_4B05[var_01]))
		{
			param_00 thread func_E0FA();
		}

		level.var_4282[var_01] = undefined;
		level.var_4282[var_02] = undefined;
		level.var_115CC[var_02] func_E471();
		scripts\mp\_utility::func_F79E(9,var_01,param_00 getentitynumber());
		level scripts\mp\_gamescore::func_83B0(var_01,1,0);
	}
}

//Function Number: 32
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_1288 = [];
		var_00.var_1289 = [];
		var_00 thread func_C57B();
	}
}

//Function Number: 33
func_C57B()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned");
		self setclientomnvar("ui_ctf_flag_carrier",0);
		scripts\mp\_utility::func_F6FA(0);
		if(isdefined(self.pers["captures"]))
		{
			scripts\mp\_utility::func_F6FA(self.pers["captures"]);
		}

		scripts\mp\_utility::func_F6FB(0);
		if(isdefined(self.pers["returns"]))
		{
			scripts\mp\_utility::func_F6FB(self.pers["returns"]);
		}

		if(isdefined(self.team))
		{
			foreach(var_01 in level.var_115CB)
			{
				if(isdefined(var_01))
				{
					var_01 func_10110(var_01.ownerteam,self);
				}
			}
		}
	}
}

//Function Number: 34
func_20C9()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.var_9D81) && self.var_9D81 == 1)
	{
		self notify("force_cancel_placement");
		wait(0.05);
	}

	while(self ismantling())
	{
		wait(0.05);
	}

	while(!self isonground())
	{
		wait(0.05);
	}

	if(scripts\mp\_utility::func_9E59())
	{
		self notify("lost_juggernaut");
		wait(0.05);
	}

	self.pers["gamemodeLoadout"] = level.var_4B05[self.team];
	if(isdefined(self.var_F851))
	{
		scripts\mp\perks\_perkfunctions::func_51D7(self.var_F851);
	}

	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00.var_D424 = self.origin;
	var_00.var_C188 = 1;
	self.var_F851 = var_00;
	self.var_7673 = self.var_4004;
	self.pers["class"] = "gamemode";
	self.pers["lastClass"] = "gamemode";
	self.var_4004 = "gamemode";
	self.var_A95C = "gamemode";
	self notify("faux_spawn");
	self.var_767C = 1;
	self.var_6BA6 = self getstance();
	thread scripts\mp\_playerlogic::func_108F2(1);
	thread func_1369F();
}

//Function Number: 35
func_11237()
{
	self notify("superWatcher");
	self endon("superWatcher");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("drop_object");
	var_00 = self.pers["team"];
	if(var_00 == "allies")
	{
		var_01 = "axis";
	}
	else
	{
		var_01 = "allies";
	}

	level.var_115CC[var_01] endon("reset");
	for(;;)
	{
		self waittill("super_started");
		var_02 = level.var_115CC[var_01];
		if(!isdefined(var_02))
		{
			continue;
		}

		var_03 = self.var_11234;
		switch(var_03.var_10E47.var_DE3F)
		{
			case "super_phaseshift":
				var_02 thread scripts\mp\_gameobjects::func_F6D8();
				break;
	
			case "super_teleport":
			case "super_rewind":
				scripts\common\utility::waittill_any_3("teleport_success","rewind_success");
				var_02.ftldrop = 1;
				var_02 thread scripts\mp\_gameobjects::func_F6D8();
				break;
		}
	}
}

//Function Number: 36
func_1369F()
{
	level endon("game_ende");
	self endon("disconnect");
	self endon("death");
	self waittill("spawned_player");
	func_2480();
}

//Function Number: 37
func_E0FA()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.var_9D81) && self.var_9D81 == 1)
	{
		self notify("force_cancel_placement");
		wait(0.05);
	}

	while(self ismantling())
	{
		wait(0.05);
	}

	while(!self isonground())
	{
		wait(0.05);
	}

	if(scripts\mp\_utility::func_9E59())
	{
		self notify("lost_juggernaut");
		wait(0.05);
	}

	self.pers["gamemodeLoadout"] = undefined;
	if(isdefined(self.var_F851))
	{
		scripts\mp\perks\_perkfunctions::func_51D7(self.var_F851);
	}

	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00.var_D424 = self.origin;
	var_00.var_C188 = 1;
	self.var_F851 = var_00;
	self notify("faux_spawn");
	self.var_6BA6 = self getstance();
	thread scripts\mp\_playerlogic::func_108F2(1);
}

//Function Number: 38
func_C4D4(param_00)
{
}

//Function Number: 39
func_C577(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = 0;
	var_0B = param_01.origin;
	var_0C = 0;
	if(isdefined(param_00))
	{
		var_0B = param_00.origin;
		var_0C = param_00 == param_01;
	}

	if(isdefined(param_01) && isplayer(param_01) && param_01.pers["team"] != self.pers["team"])
	{
		if(isdefined(param_01.var_3AF4) && var_0C)
		{
			param_01 thread scripts\mp\_awards::func_8380("mode_ctf_kill_with_flag");
			var_0A = 1;
		}

		if(isdefined(self.var_3AF4))
		{
			var_0D = distancesquared(self.origin,level.var_3A42[self.team].trigger.origin);
			if(var_0D < 90000)
			{
				level.var_4282[param_01.team] = param_01;
			}
			else
			{
				level.var_4282[param_01.team] = undefined;
			}

			param_01 thread scripts\mp\_awards::func_8380("mode_ctf_kill_carrier");
			scripts\mp\_utility::func_F79E(10,param_01.team,param_01 getentitynumber());
			param_01 scripts\mp\_utility::func_93DF("defends",1);
			param_01 scripts\mp\_persistence::func_10E56("round","defends",param_01.pers["defends"]);
			thread scripts\mp\_matchdata::func_AFC5(param_09,"carrying");
			var_0A = 1;
		}

		if(!var_0A)
		{
			var_0E = 0;
			var_0F = 0;
			foreach(var_11 in level.var_115CC)
			{
				var_12 = func_5720(var_0B,self.origin,var_11.var_4B2C);
				if(var_12)
				{
					if(var_11.ownerteam == self.team)
					{
						var_0E = 1;
						continue;
					}

					var_0F = 1;
				}
			}

			if(var_0E)
			{
				param_01 thread scripts\mp\_awards::func_8380("mode_x_assault");
				thread scripts\mp\_matchdata::func_AFC5(param_09,"defending");
			}
			else if(var_0F)
			{
				param_01 thread scripts\mp\_awards::func_8380("mode_x_defend");
				param_01 scripts\mp\_utility::func_93DF("defends",1);
				param_01 scripts\mp\_persistence::func_10E56("round","defends",param_01.pers["defends"]);
				thread scripts\mp\_matchdata::func_AFC5(param_09,"assaulting");
			}
		}
	}

	if(isdefined(self.var_3AF4))
	{
		func_5391();
	}
}

//Function Number: 40
func_5720(param_00,param_01,param_02)
{
	var_03 = distancesquared(param_02,param_00);
	var_04 = distancesquared(param_02,param_01);
	if(var_03 < 90000 || var_04 < 90000)
	{
		return 1;
	}

	return 0;
}

//Function Number: 41
func_2480()
{
	var_00 = level.var_C74B[self.pers["team"]];
	self attach(level.var_3AF4[var_00],"J_spine4",1);
	self.var_3AF4 = level.var_3AF4[var_00];
}

//Function Number: 42
func_5391()
{
	self detach(self.var_3AF4,"J_spine4");
	self.var_3AF4 = undefined;
}

//Function Number: 43
func_F856()
{
	if(function_011C() && getmatchrulesdata("defaultClasses","axis",5,"class","inUse"))
	{
		level.var_4B05["axis"] = scripts\mp\_utility::func_7F92("axis",5);
	}

	if(function_011C() && getmatchrulesdata("defaultClasses","allies",5,"class","inUse"))
	{
		level.var_4B05["allies"] = scripts\mp\_utility::func_7F92("allies",5);
	}
}

//Function Number: 44
func_E0F9()
{
	level endon("game_ended");
	for(;;)
	{
		if(getdvar("scr_devRemoveDomFlag","") != "")
		{
			var_00 = getdvar("scr_devRemoveDomFlag","");
			if(var_00 == "_a")
			{
				var_01 = "allies";
			}
			else
			{
				var_01 = "axis";
			}

			if(var_01 == "allies")
			{
				if(game["switchedsides"])
				{
					var_01 = game["defenders"];
				}
				else
				{
					var_01 = game["attackers"];
				}
			}
			else if(game["switchedsides"])
			{
				var_01 = game["attackers"];
			}
			else
			{
				var_01 = game["defenders"];
			}

			level.var_115CC[var_01].trigger notify("move_gameobject");
			level.var_115CC[var_01] scripts\mp\_gameobjects::func_1CAF("none");
			level.var_115CC[var_01].trigger = undefined;
			level.var_115CC[var_01] notify("deleted");
			level.var_115CC[var_01].visuals[0] delete();
			level.var_115CB[var_01] delete();
			level.var_3A42[var_01] scripts\mp\_gameobjects::func_1CAF("none");
			level.var_3A42[var_01].trigger = undefined;
			level.var_3A42[var_01] notify("deleted");
			foreach(var_03 in level.players)
			{
				var_03 func_D018(var_01);
			}

			level.var_115CC[var_01].visibleteam = "none";
			level.var_115CC[var_01] scripts\mp\_gameobjects::func_F283("friendly",undefined);
			level.var_115CC[var_01] scripts\mp\_gameobjects::func_F284("friendly",undefined);
			level.var_115CC[var_01] scripts\mp\_gameobjects::func_F283("enemy",undefined);
			level.var_115CC[var_01] scripts\mp\_gameobjects::func_F284("enemy",undefined);
			level.var_3A42[var_01].visibleteam = "none";
			level.var_3A42[var_01] scripts\mp\_gameobjects::func_F283("friendly",undefined);
			level.var_3A42[var_01] scripts\mp\_gameobjects::func_F284("friendly",undefined);
			level.var_3A42[var_01] scripts\mp\_gameobjects::func_F283("enemy",undefined);
			level.var_3A42[var_01] scripts\mp\_gameobjects::func_F284("enemy",undefined);
			level.var_115CC[var_01] = undefined;
			setdynamicdvar("scr_devRemoveDomFlag","");
		}

		wait(1);
	}
}

//Function Number: 45
func_CC19()
{
	level endon("game_ended");
	for(;;)
	{
		if(getdvar("scr_devPlaceDomFlag","") != "")
		{
			var_00 = getdvar("scr_devPlaceDomFlag","");
			if(var_00 == "_a")
			{
				var_01 = "allies";
			}
			else
			{
				var_01 = "axis";
			}

			if(var_01 == "allies")
			{
				if(game["switchedsides"])
				{
					var_01 = game["defenders"];
				}
				else
				{
					var_01 = game["attackers"];
				}
			}
			else if(game["switchedsides"])
			{
				var_01 = game["attackers"];
			}
			else
			{
				var_01 = game["defenders"];
			}

			var_02 = undefined;
			var_02 = spawnstruct();
			var_02 func_53DD();
			var_02.origin = var_02.var_862F;
			var_02.var_257 = 30;
			var_02.team = var_01;
			var_03 = spawn("trigger_radius",var_02.origin,0,30,80);
			var_04[0] = spawn("script_model",var_02.origin);
			var_04[0] setmodel(level.var_6E67[var_01]);
			var_05 = scripts\mp\_gameobjects::func_4993(var_01,var_03,var_04,(0,0,85));
			var_05 scripts\mp\_gameobjects::func_F87C("enemy",&"MP_GRABBING_FLAG");
			var_05 scripts\mp\_gameobjects::func_F87C("friendly",&"MP_RETURNING_FLAG");
			var_05 scripts\mp\_gameobjects::func_1C7C("enemy");
			var_05 scripts\mp\_gameobjects::setvisibleteam("none");
			var_05 scripts\mp\_gameobjects::func_F283("friendly",level.var_92AC);
			var_05 scripts\mp\_gameobjects::func_F284("friendly",level.var_92AD);
			var_05 scripts\mp\_gameobjects::func_F283("enemy",level.var_92A8);
			var_05 scripts\mp\_gameobjects::func_F284("enemy",level.var_92A9);
			var_05.var_C2BE = 1;
			var_05.var_1CB3 = 1;
			var_05.var_C566 = ::func_C566;
			var_05.var_C567 = ::func_C566;
			var_05.var_C4F9 = ::func_C4F9;
			var_05.var_C581 = ::func_C581;
			var_05.var_C402 = var_03.var_257;
			var_05.origin = var_02.origin;
			var_05.label = var_01;
			var_05.previouscarrier = undefined;
			var_06 = var_03.origin + (0,0,32);
			var_07 = var_03.origin + (0,0,-32);
			var_08 = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
			var_09 = [];
			var_0A = scripts\common\trace::func_DCED(var_06,var_07,var_09,var_08);
			var_05.var_289D = var_0A["position"];
			var_0B = vectortoangles(var_0A["normal"]);
			var_05.var_289C = anglestoforward(var_0B);
			level.var_115CB[var_01] = func_4A22(var_01,var_05);
			if(var_01 == "allies")
			{
				if(game["switchedsides"])
				{
					level.var_115CC[game["defenders"]] = var_05;
				}
				else
				{
					level.var_115CC[game["attackers"]] = var_05;
				}
			}
			else if(game["switchedsides"])
			{
				level.var_115CC[game["attackers"]] = var_05;
			}
			else
			{
				level.var_115CC[game["defenders"]] = var_05;
			}

			var_04 = [];
			var_03 = spawn("trigger_radius",var_02.origin - (0,0,var_02.var_257 / 2),0,var_02.var_257,80);
			var_03.var_C000 = 1;
			var_03.var_AD48 = 1;
			var_03.var_28AC = var_03.origin;
			var_0C = scripts\mp\_gameobjects::func_4A2E(var_01,var_03,var_04,(0,0,115));
			var_0C scripts\mp\_gameobjects::func_1CAF("friendly");
			var_0C scripts\mp\_gameobjects::setvisibleteam("any");
			var_0C scripts\mp\_gameobjects::func_F283("friendly",level.var_92A1);
			var_0C scripts\mp\_gameobjects::func_F284("friendly",level.var_92A2);
			var_0C scripts\mp\_gameobjects::func_F283("enemy",level.var_929B);
			var_0C scripts\mp\_gameobjects::func_F284("enemy",level.var_929C);
			var_0C scripts\mp\_gameobjects::func_FB08(0);
			var_0C scripts\mp\_gameobjects::func_F76A(level.var_115CC[scripts\mp\_utility::getotherteam(var_01)]);
			level.var_3A42[level.var_C74B[var_01]] scripts\mp\_gameobjects::func_F76A(var_05);
			var_0C.var_C5BB = ::func_C5BB;
			var_0C.var_C4D4 = ::func_C4D4;
			var_06 = var_03.origin + (0,0,32);
			var_07 = var_03.origin + (0,0,-32);
			var_08 = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
			var_09 = [];
			var_0A = scripts\common\trace::func_DCED(var_06,var_07,var_09,var_08);
			var_0B = vectortoangles(var_0A["normal"]);
			var_0D = anglestoforward(var_0B);
			var_0E = anglestoright(var_0B);
			if(var_01 == "allies")
			{
				if(game["switchedsides"])
				{
					level.var_3A42[game["defenders"]] = var_0C;
				}
				else
				{
					level.var_3A42[game["attackers"]] = var_0C;
				}
			}
			else if(game["switchedsides"])
			{
				level.var_3A42[game["attackers"]] = var_0C;
			}
			else
			{
				level.var_3A42[game["defenders"]] = var_0C;
			}

			setdynamicdvar("scr_devPlaceDomFlag","");
		}

		wait(1);
	}
}

//Function Number: 46
func_53DD()
{
	var_00 = level.players[0].origin + (0,0,32);
	var_01 = level.players[0].origin + (0,0,-1000);
	var_02 = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
	var_03 = [];
	var_04 = scripts\common\trace::func_DCED(var_00,var_01,var_03,var_02);
	self.var_862F = var_04["position"];
	return var_04["fraction"] != 0 && var_04["fraction"] != 1;
}