/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\ball.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 53
 * Decompile Time: 2723 ms
 * Timestamp: 10/27/2023 12:12:18 AM
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
		scripts\mp\_utility::func_DF0B(level.gametype,20);
		scripts\mp\_utility::func_DF11(level.gametype,5);
		scripts\mp\_utility::func_DF08(level.gametype,2);
		scripts\mp\_utility::func_DF09(level.gametype,1,0,1);
		scripts\mp\_utility::func_DF1A(level.gametype,0);
		scripts\mp\_utility::func_DF02(level.gametype,0);
		level.var_B40A = 0;
	}

	level.var_3AEC = 100;
	func_12E9F();
	level.teambased = 1;
	level.var_C2A1 = 0;
	level.var_112BF = 0;
	level.var_C580 = ::func_C580;
	level.var_C5A4 = ::func_C5A4;
	level.var_8136 = ::func_8136;
	level.var_C577 = ::func_C577;
	level.onspawnplayer = ::onspawnplayer;
	level.var_108EB = "mp_ball_spawn";
	level.var_27FC = 1;
	level.var_EC39 = 0;
	level.var_27F9 = 0;
	if(level.var_B40A)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	game["dialog"]["gametype"] = "uplink";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	game["dialog"]["drone_reset"] = "ul_obj_respawned";
	game["dialog"]["you_own_drone"] = "ally_own_drone";
	game["dialog"]["ally_own_drone"] = "ally_own_drone";
	game["dialog"]["enemy_own_drone"] = "enemy_own_drone";
	game["dialog"]["ally_throw_score"] = "ally_throw_score";
	game["dialog"]["ally_carry_score"] = "ally_carry_score";
	game["dialog"]["enemy_throw_score"] = "enemy_throw_score";
	game["dialog"]["enemy_carry_score"] = "enemy_carry_score";
	game["dialog"]["pass_complete"] = "friendly_pass";
	game["dialog"]["pass_intercepted"] = "pass_intercepted";
	game["dialog"]["ally_drop_drone"] = "ally_drop_drone";
	game["dialog"]["enemy_drop_drone"] = "enemy_drop_drone";
	game["dialog"]["ally_drone_half"] = "halfway_enemy";
	game["dialog"]["enemy_drone_half"] = "halfway_friendly";
	game["dialog"]["offense_obj"] = "capture_obj";
	game["dialog"]["defense_obj"] = "capture_obj";
}

//Function Number: 2
func_987C()
{
	scripts\mp\_utility::func_F69D();
	setdynamicdvar("scr_ball_scoreCarry",getmatchrulesdata("ballData","scoreCarry"));
	setdynamicdvar("scr_ball_scoreThrow",getmatchrulesdata("ballData","scoreThrow"));
	setdynamicdvar("scr_ball_satelliteCount",getmatchrulesdata("ballData","satelliteCount"));
	setdynamicdvar("scr_ball_practiceMode",getmatchrulesdata("ballData","practiceMode"));
	setdynamicdvar("scr_ball_possessionResetCondition",getmatchrulesdata("ballCommonData","possessionResetCondition"));
	setdynamicdvar("scr_ball_possessionResetTime",getmatchrulesdata("ballCommonData","possessionResetTime"));
	setdynamicdvar("scr_ball_idleResetTime",getmatchrulesdata("ballCommonData","idleResetTime"));
	setdynamicdvar("scr_ball_explodeOnExpire",getmatchrulesdata("ballCommonData","explodeOnExpire"));
	setdynamicdvar("scr_ball_armorMod",getmatchrulesdata("ballCommonData","armorMod"));
	setdynamicdvar("scr_ball_showEnemyCarrier",getmatchrulesdata("ballCommonData","showEnemyCarrier"));
	setdynamicdvar("scr_ball_promode",0);
}

//Function Number: 3
func_C580()
{
	game["bomb_dropped_sound"] = "mp_uplink_ball_pickedup_enemy";
	game["bomb_recovered_sound"] = "mp_uplink_ball_pickedup_friendly";
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

	if(game["switchedsides"])
	{
		var_03 = game["attackers"];
		var_04 = game["defenders"];
		game["attackers"] = var_04;
		game["defenders"] = var_03;
	}

	scripts\mp\_utility::func_F7C1("allies",&"OBJECTIVES_BALL");
	scripts\mp\_utility::func_F7C1("axis",&"OBJECTIVES_BALL");
	if(level.splitscreen)
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_BALL");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_BALL");
	}
	else
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_BALL_SCORE");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_BALL_SCORE");
	}

	scripts\mp\_utility::func_F7BE("allies",&"OBJECTIVES_BALL_HINT");
	scripts\mp\_utility::func_F7BE("axis",&"OBJECTIVES_BALL_HINT");
	setclientnamemode("auto_change");
	scripts\mp\gametypes\obj_ball::func_2782();
	var_05[0] = level.gametype;
	var_05[1] = "dom";
	var_05[2] = "ball";
	scripts\mp\_gameobjects::main(var_05);
	level thread func_E7DC();
	level thread func_C56E();
	if(level.var_D6AF != 0)
	{
		scripts\mp\gametypes\obj_ball::func_97D6();
	}
}

//Function Number: 5
func_12E9F()
{
	scripts\mp\gametypes\common::func_12E9F();
	level.var_EC25 = scripts\mp\_utility::dvarintvalue("scoreCarry",2,1,9);
	level.var_EC4F = scripts\mp\_utility::dvarintvalue("scoreThrow",1,1,9);
	level.var_EB50 = scripts\mp\_utility::dvarintvalue("satelliteCount",1,1,5);
	level.var_D7A6 = scripts\mp\_utility::dvarintvalue("practiceMode",0,0,1);
	level.var_D6AF = scripts\mp\_utility::dvarintvalue("possessionResetCondition",0,0,2);
	level.var_D6B0 = scripts\mp\_utility::dvarfloatvalue("possessionResetTime",0,0,150);
	level.var_69A1 = scripts\mp\_utility::dvarintvalue("explodeOnExpire",0,0,1);
	level.var_92F7 = scripts\mp\_utility::dvarfloatvalue("idleResetTime",15,0,60);
	level.var_218A = scripts\mp\_utility::dvarfloatvalue("armorMod",1,0,2);
	level.var_10120 = scripts\mp\_utility::dvarintvalue("showEnemyCarrier",5,0,6);
	level.var_3AEC = int(level.var_3AEC * level.var_218A);
}

//Function Number: 6
func_2797()
{
	foreach(var_02, var_01 in level.var_2798)
	{
		var_01.trigger = spawn("trigger_radius",var_01.origin - (0,0,var_01.var_257),0,var_01.var_257,var_01.var_257 * 2);
		var_01.var_130AD = scripts\mp\_gameobjects::func_4A2E(var_02,var_01.trigger,[],(0,0,var_01.var_257 * 2.1));
		var_01.var_130AD.var_155 = var_01;
		var_01.var_130AD scripts\mp\_gameobjects::func_F283("friendly","waypoint_blitz_defend");
		var_01.var_130AD scripts\mp\_gameobjects::func_F283("enemy","waypoint_blitz_goal");
		var_01.var_130AD scripts\mp\_gameobjects::func_F284("friendly","waypoint_blitz_defend");
		var_01.var_130AD scripts\mp\_gameobjects::func_F284("enemy","waypoint_blitz_goal");
		var_01.var_130AD scripts\mp\_gameobjects::setvisibleteam("any");
		var_01.var_130AD scripts\mp\_gameobjects::func_1CAF("enemy");
		var_01.var_130AD scripts\mp\_gameobjects::func_F76A(level.var_2800);
		var_01.var_130AD scripts\mp\_gameobjects::func_FB08(0);
		var_01.var_130AD scripts\mp\_gameobjects::cancontestclaim(1);
		var_01.var_130AD.var_C5BB = ::func_2779;
		var_01.var_130AD.var_393A = ::func_2794;
		var_01.var_130AD.var_C4D9 = ::ball_goal_contested;
		var_01.var_130AD.var_C5B9 = ::ball_goal_uncontested;
		var_01.var_A63A = spawn("script_model",var_01.origin + (0,0,20));
		var_01.var_A63A setscriptmoverkillcam("explosive");
	}
}

//Function Number: 7
func_2791(param_00,param_01)
{
	if(scripts\mp\_spawnlogic::func_9ED7())
	{
		var_02 = function_00C0(param_00,param_01,999999);
		if(isdefined(var_02) && var_02 >= 0)
		{
			return var_02;
		}
	}

	return distance(param_00,param_01);
}

//Function Number: 8
func_2795()
{
	foreach(var_01 in level.var_2798)
	{
		var_01.var_EC1B["friendly"] = spawnfx(scripts\common\utility::getfx("ball_goal_activated_friendly"),var_01.origin,(1,0,0));
		var_01.var_EC1B["enemy"] = spawnfx(scripts\common\utility::getfx("ball_goal_activated_enemy"),var_01.origin,(1,0,0));
	}

	level thread func_27B7();
	foreach(var_04 in level.players)
	{
		func_2796(var_04);
	}

	thread goal_watch_game_ended();
}

//Function Number: 9
func_C56E()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		thread func_C57B(var_00);
		if(scripts\mp\_utility::func_9FB3(level.var_D7A6) && var_00 ishost())
		{
			var_00 thread scripts\mp\gametypes\obj_ball::func_D7A7();
			var_00 thread scripts\mp\gametypes\obj_ball::func_BCA9();
		}
	}
}

//Function Number: 10
func_C57B(param_00)
{
	param_00 waittill("spawned");
	param_00 scripts\mp\_utility::func_F6FA(0);
	if(isdefined(param_00.pers["touchdowns"]))
	{
		param_00 scripts\mp\_utility::func_F6FA(param_00.pers["touchdowns"]);
	}

	param_00 scripts\mp\_utility::func_F6FB(0);
	if(isdefined(param_00.pers["fieldgoals"]))
	{
		param_00 scripts\mp\_utility::func_F6FB(param_00.pers["fieldgoals"]);
	}
}

//Function Number: 11
func_98CE()
{
	scripts\mp\_spawnlogic::func_F62D("Uplink");
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	scripts\mp\_spawnlogic::func_182D("mp_ball_spawn_allies_start");
	scripts\mp\_spawnlogic::func_182D("mp_ball_spawn_axis_start");
	level.var_B32E = scripts\mp\_spawnlogic::func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
	var_00 = scripts\mp\_spawnlogic::func_8140(level.var_108EB);
	var_01 = scripts\mp\_spawnlogic::func_8140(level.var_108EB + "_secondary");
	var_02 = func_23E3(var_00);
	var_03 = func_23E3(var_01);
	scripts\mp\_spawnlogic::func_DF0D("allies",var_02["allies"]);
	scripts\mp\_spawnlogic::func_DF0D("allies",var_03["allies"],1);
	scripts\mp\_spawnlogic::func_DF0D("axis",var_02["axis"]);
	scripts\mp\_spawnlogic::func_DF0D("axis",var_03["axis"],1);
}

//Function Number: 12
func_23E3(param_00)
{
	var_01 = [];
	var_01["allies"] = [];
	var_01["axis"] = [];
	if(!isdefined(level.var_B4C6))
	{
		level.var_B4C6 = [];
		level.var_B4C6["allies"] = 0;
		level.var_B4C6["axis"] = 0;
	}

	var_02 = level.var_2798["allies"].origin;
	var_03 = level.var_2798["axis"].origin;
	foreach(var_05 in param_00)
	{
		var_06 = func_8141(var_05,var_02);
		var_07 = func_8141(var_05,var_03);
		var_05.var_5724 = [];
		var_05.var_5724["allies"] = var_06;
		var_05.var_5724["axis"] = var_07;
		var_08 = max(var_06,var_07);
		var_09 = min(var_06,var_07);
		if(abs(var_08 - var_09) / var_08 < 0.2)
		{
			var_01["allies"][var_01["allies"].size] = var_05;
			var_01["axis"][var_01["axis"].size] = var_05;
		}
		else if(var_07 < var_06)
		{
			var_01["axis"][var_01["axis"].size] = var_05;
		}
		else
		{
			var_01["allies"][var_01["allies"].size] = var_05;
		}

		if(var_06 > level.var_B4C6["allies"])
		{
			level.var_B4C6["allies"] = var_06;
		}

		if(var_07 > level.var_B4C6["axis"])
		{
			level.var_B4C6["axis"] = var_07;
		}
	}

	return var_01;
}

//Function Number: 13
func_8141(param_00,param_01)
{
	var_02 = function_00C0(param_00.origin,param_01,16000);
	if(var_02 < 0)
	{
		var_02 = distance(param_00.origin,param_01);
	}

	return var_02;
}

//Function Number: 14
func_8136()
{
	var_00 = self.pers["team"];
	if(scripts\mp\_spawnlogic::func_100BA())
	{
		if(game["switchedsides"])
		{
			var_00 = scripts\mp\_utility::getotherteam(var_00);
		}

		var_01 = scripts\mp\_spawnlogic::func_8140(level.var_108EB + "_" + var_00 + "_start");
		var_02 = scripts\mp\_spawnlogic::func_813F(var_01);
	}
	else
	{
		var_01 = scripts\mp\_spawnlogic::func_81BA(var_02);
		var_03 = scripts\mp\_spawnlogic::func_81A9(var_01);
		var_04 = [];
		var_05["homeBaseTeam"] = var_00;
		var_05["maxDistToHomeBase"] = level.var_B4C6[var_00];
		var_02 = scripts\mp\_spawnscoring::func_8136(var_01,var_03,var_05);
	}

	return var_02;
}

//Function Number: 15
func_E7DC()
{
	level.var_27C6 = [];
	level.var_2800 = [];
	level.var_27D2 = [];
	scripts\mp\_utility::func_98D3();
	func_2781("allies");
	func_2781("axis");
	level._effect["ball_trail"] = loadfx("vfx/core/mp/core/vfx_uplink_ball_trail.vfx");
	level._effect["ball_idle"] = loadfx("vfx/core/mp/core/vfx_uplink_ball_idle.vfx");
	level._effect["ball_download_end"] = loadfx("vfx/core/mp/core/vfx_uplink_ball_download_end.vfx");
	level._effect["ball_goal_enemy"] = loadfx("vfx/core/mp/core/vfx_uplink_goal_orng.vfx");
	level._effect["ball_goal_friendly"] = loadfx("vfx/core/mp/core/vfx_uplink_goal_cyan.vfx");
	level._effect["ball_goal_activated_enemy"] = loadfx("vfx/core/mp/core/vfx_uplink_goal_actv_orng.vfx");
	level._effect["ball_goal_activated_friendly"] = loadfx("vfx/core/mp/core/vfx_uplink_goal_actv_cyan.vfx");
	level._effect["ball_teleport"] = loadfx("vfx/core/mp/core/vfx_uplink_ball_teleport.vfx");
	level thread func_277D();
	scripts\mp\gametypes\obj_ball::func_279C();
	scripts\mp\gametypes\obj_ball::func_277F();
	for(var_00 = 0;var_00 < level.var_EB50;var_00++)
	{
		scripts\mp\gametypes\obj_ball::func_27C4(var_00);
	}

	thread scripts\mp\gametypes\obj_ball::hideballsongameended();
	func_2797();
	func_2795();
	func_98CE();
	thread func_E189();
	thread func_CC2B();
	level.var_276E = level.var_2800[0];
}

//Function Number: 16
func_278A(param_00)
{
	var_01 = self.origin + (0,0,32);
	var_02 = self.origin + (0,0,-1000);
	var_03 = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
	var_04 = [];
	var_05 = scripts\common\trace::func_DCED(var_01,var_02,var_04,var_03);
	self.var_862F = var_05["position"];
	return var_05["fraction"] != 0 && var_05["fraction"] != 1;
}

//Function Number: 17
func_2781(param_00)
{
	var_01 = param_00;
	if(game["switchedsides"])
	{
		var_01 = scripts\mp\_utility::getotherteam(var_01);
	}

	var_02 = scripts\common\utility::getstruct("ball_goal_" + var_01,"targetname");
	if(isdefined(var_02))
	{
		var_02 = checkpostshipgoalplacement(var_02,param_00);
		var_02 func_278A();
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
			var_02.origin = level.var_4FF4[param_00];
		}

		var_02 func_278A();
	}

	if(scripts\mp\_utility::func_9FB3(level.tactical))
	{
		var_02.origin = var_02.var_862F + (0,0,130);
	}
	else if(scripts\mp\_utility::func_9FB3(level.var_112C1))
	{
		if(level.var_B335 == "mp_frontier")
		{
			var_02.origin = var_02.var_862F + (0,0,180);
		}
		else
		{
			var_02.origin = var_02.var_862F + (0,0,190);
		}
	}
	else
	{
		var_02.origin = var_02.var_862F + (0,0,130);
	}

	var_02.var_257 = 60;
	var_02.team = param_00;
	var_02.var_279B = 0;
	var_02.var_8EE8 = 0;
	level.var_2798[param_00] = var_02;
}

//Function Number: 18
checkpostshipgoalplacement(param_00,param_01)
{
	if(level.var_B335 == "mp_desert")
	{
		var_02 = (2125,71,370.344);
		if(!game["switchedsides"] && param_01 == "axis")
		{
			param_00.origin = var_02;
		}
		else if(game["switchedsides"] && param_01 == "allies")
		{
			param_00.origin = var_02;
		}
	}

	if(level.var_B335 == "mp_metropolis")
	{
		if(!game["switchedsides"] && param_01 == "axis")
		{
			param_00.origin = (-2039,-1464,123);
		}
		else if(game["switchedsides"] && param_01 == "allies")
		{
			param_00.origin = (-2039,-1464,123);
		}
	}

	if(level.var_B335 == "mp_fallen")
	{
		if(!game["switchedsides"] && param_01 == "axis")
		{
			param_00.origin = (2752,1429,988);
		}
		else if(game["switchedsides"] && param_01 == "allies")
		{
			param_00.origin = (2752,1429,988);
		}

		if(!game["switchedsides"] && param_01 == "allies")
		{
			param_00.origin = (-1866,1698,988);
		}
		else if(game["switchedsides"] && param_01 == "axis")
		{
			param_00.origin = (-1866,1698,988);
		}
	}

	return param_00;
}

//Function Number: 19
func_277D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread scripts\mp\gametypes\obj_ball::func_27BA();
	}
}

//Function Number: 20
func_27B6()
{
	var_00 = self.visuals[0];
	self endon("pass_end");
	self endon("pickup_object");
	self endon("physics_finished");
	if(level.gametype != "tdef")
	{
		func_27C7(var_00);
	}
}

//Function Number: 21
func_27AC()
{
	var_00 = self.visuals[0];
	self endon("pass_end");
	if(level.gametype != "tdef")
	{
		func_27C7(var_00);
	}
}

//Function Number: 22
func_27C7(param_00)
{
	self endon("pass_end");
	self endon("pickup_object");
	self endon("physics_finished");
	for(;;)
	{
		foreach(var_05, var_02 in level.var_2798)
		{
			if(self.var_A958 == var_05)
			{
				continue;
			}

			if(!var_02.var_130AD func_2794())
			{
				continue;
			}

			var_03 = distance(param_00.origin,var_02.origin);
			if(var_03 <= var_02.var_257)
			{
				thread func_27C8(var_02);
				param_00 notify("pass_end");
				return;
			}

			if(isdefined(param_00.var_C71B))
			{
				var_04 = func_ACE6(param_00.var_C71B,param_00.origin,var_02.origin,var_02.var_257);
				if(var_04)
				{
					thread func_27C8(var_02);
					param_00 notify("pass_end");
					return;
				}
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 23
func_2794(param_00)
{
	var_01 = self.var_155;
	if(var_01.var_279B)
	{
		return 0;
	}

	return 1;
}

//Function Number: 24
ball_goal_contested()
{
	ball_waypoint_contest();
}

//Function Number: 25
ball_goal_uncontested(param_00)
{
	goal_waypoint();
}

//Function Number: 26
func_2779(param_00)
{
	if(!isdefined(param_00) || !isdefined(param_00.var_3AF7))
	{
		return;
	}

	if(isdefined(level.var_EC39) && level.var_EC39 > gettime())
	{
		return;
	}

	if(istimeup())
	{
		return;
	}

	if(level.var_7669)
	{
		return;
	}

	param_00 notify("goal_scored");
	var_01 = level.var_EC25;
	param_00 thread scripts\mp\_awards::func_8380("mode_uplink_dunk");
	func_277A(param_00,1);
	param_00 scripts\mp\_utility::func_93DF("touchdowns",1);
	param_00 scripts\mp\_persistence::func_10E56("round","touchdowns",param_00.pers["touchdowns"]);
	if(isplayer(param_00))
	{
		param_00 scripts\mp\_utility::func_F6FA(param_00.pers["touchdowns"]);
		param_00 thread scripts\mp\_matchdata::func_AFBA("dunk",param_00.origin);
	}

	var_02 = self.var_155.team;
	var_03 = scripts\mp\_utility::getotherteam(var_02);
	scripts\mp\_utility::func_10E60("enemy_carry_score",var_02,1);
	scripts\mp\_utility::func_10E60("ally_carry_score",var_03,1);
	func_27B9(self.var_155);
	func_27C0(var_03,1);
	var_04 = param_00.var_3AF7;
	var_04.var_A957 = 1;
	var_04 scripts\mp\gametypes\obj_ball::func_27C1(1,self.trigger.origin,1);
	var_04 thread func_27BF(self.var_155);
	func_2793(var_03,var_01);
	scripts\mp\_utility::func_F79E(1,var_03,param_00 getentitynumber());
}

//Function Number: 27
func_FF82(param_00,param_01)
{
	var_02 = scripts\mp\_gamescore::func_12B6(param_00);
	var_03 = scripts\mp\_gamescore::func_12B6(scripts\mp\_utility::getotherteam(param_00));
	return var_02 + param_01 >= var_03;
}

//Function Number: 28
func_ACE6(param_00,param_01,param_02,param_03)
{
	var_04 = vectornormalize(param_01 - param_00);
	var_05 = vectordot(var_04,param_00 - param_02);
	var_05 = var_05 * var_05;
	var_06 = param_00 - param_02;
	var_06 = var_06 * var_06;
	var_07 = param_03 * param_03;
	return var_05 - var_06 + var_07 >= 0;
}

//Function Number: 29
func_27C8(param_00)
{
	if(isdefined(level.var_EC39) && level.var_EC39 > gettime())
	{
		return;
	}

	if(istimeup())
	{
		return;
	}

	if(level.var_7669)
	{
		return;
	}

	func_27B9(param_00);
	var_01 = level.var_EC4F;
	var_02 = param_00.team;
	var_03 = scripts\mp\_utility::getotherteam(var_02);
	scripts\mp\_utility::func_10E60("enemy_throw_score",var_02,1);
	scripts\mp\_utility::func_10E60("ally_throw_score",var_03,1);
	if(isdefined(self.var_A956))
	{
		self.var_A957 = 1;
		self.var_A956 thread scripts\mp\_awards::func_8380("mode_uplink_fieldgoal");
		func_277A(self.var_A956,0);
		self.var_A956 scripts\mp\_utility::func_93DF("fieldgoals",1);
		self.var_A956 scripts\mp\_persistence::func_10E56("round","fieldgoals",self.var_A956.pers["fieldgoals"]);
		if(isplayer(self.var_A956))
		{
			self.var_A956 scripts\mp\_utility::func_F6FB(self.var_A956.pers["fieldgoals"]);
			self.var_A956 thread scripts\mp\_matchdata::func_AFBA("fieldgoal",self.var_A956.origin);
		}
	}

	if(isdefined(self.var_A63A))
	{
		self.var_A63A unlink();
	}

	func_27C0(var_03,0);
	thread func_27BF(param_00);
	func_2793(var_03,var_01);
	if(isdefined(self.var_A956))
	{
		scripts\mp\_utility::func_F79E(0,var_03,self.var_A956 getentitynumber());
		return;
	}

	scripts\mp\_utility::func_F79E(0,var_03);
}

//Function Number: 30
istimeup()
{
	var_00 = scripts\mp\_utility::getwatcheddvar("timelimit");
	if(var_00 != 0)
	{
		var_01 = scripts\mp\_gamelogic::func_81CD();
		if(var_01 <= 0)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 31
func_2793(param_00,param_01)
{
	level scripts\mp\_gamescore::func_83B0(param_00,param_01,0);
}

//Function Number: 32
func_27BF(param_00)
{
	level thread scorefrozentimer();
	self notify("score_event");
	if(scripts\mp\_utility::func_9FB3(level.var_D7A6))
	{
		foreach(var_02 in level.players)
		{
			if(var_02 ishost())
			{
				var_02 thread scripts\mp\gametypes\obj_ball::func_BCA9();
				break;
			}
		}
	}

	self.var_9398 = 1;
	param_00.var_279B = 1;
	var_04 = self.visuals[0];
	if(isdefined(self.var_DA5A))
	{
		self.var_DA5A delete();
	}

	var_04 physicslaunchserver(var_04.origin,(0,0,0));
	var_04 method_851B();
	scripts\mp\_gameobjects::func_1C7C("none");
	scripts\mp\gametypes\obj_ball::func_27CF();
	var_05 = 0.4;
	var_06 = 1.2;
	var_07 = 1;
	var_08 = var_05 + var_07;
	var_09 = var_08 + var_06;
	var_04 moveto(param_00.origin,var_05,0,var_05);
	var_04 rotatevelocity((1080,1080,0),var_09,var_09,0);
	wait(var_08);
	var_04 movez(4000,var_06,var_06 * 0.1,0);
	wait(var_06);
	param_00.var_279B = 0;
	scripts\mp\gametypes\obj_ball::func_27BD(0,0);
}

//Function Number: 33
func_277A(param_00,param_01)
{
	if(!isdefined(param_00.var_C94C) || !isdefined(param_00.var_C94A))
	{
		return;
	}

	if(param_00.var_C94C + 3000 < gettime())
	{
		return;
	}

	if(param_01)
	{
		param_00.var_C94A thread scripts\mp\_awards::func_8380("mode_uplink_allyoop");
	}
}

//Function Number: 34
func_27B9(param_00)
{
	param_00.var_EC1B["friendly"] hide();
	param_00.var_EC1B["enemy"] hide();
	foreach(var_02 in level.players)
	{
		var_03 = func_2792(var_02);
		if(var_03 == param_00.team)
		{
			param_00.var_EC1B["friendly"] showtoplayer(var_02);
			continue;
		}

		param_00.var_EC1B["enemy"] showtoplayer(var_02);
	}

	triggerfx(param_00.var_EC1B["friendly"]);
	triggerfx(param_00.var_EC1B["enemy"]);
}

//Function Number: 35
ball_waypoint_reset()
{
	scripts\mp\_gameobjects::func_F283("friendly","waypoint_reset_marker");
	scripts\mp\_gameobjects::func_F283("enemy","waypoint_reset_marker");
	scripts\mp\_gameobjects::func_F284("friendly","waypoint_reset_marker");
	scripts\mp\_gameobjects::func_F284("enemy","waypoint_reset_marker");
}

//Function Number: 36
ball_waypoint_contest()
{
	scripts\mp\_gameobjects::func_F283("friendly","waypoint_uplink_contested");
	scripts\mp\_gameobjects::func_F283("enemy","waypoint_uplink_contested");
	scripts\mp\_gameobjects::func_F284("friendly","waypoint_uplink_contested");
	scripts\mp\_gameobjects::func_F284("enemy","waypoint_uplink_contested");
}

//Function Number: 37
goal_waypoint()
{
	scripts\mp\_gameobjects::func_F283("friendly","waypoint_blitz_defend");
	scripts\mp\_gameobjects::func_F283("enemy","waypoint_blitz_goal");
	scripts\mp\_gameobjects::func_F284("friendly","waypoint_blitz_defend");
	scripts\mp\_gameobjects::func_F284("enemy","waypoint_blitz_goal");
}

//Function Number: 38
func_27C0(param_00,param_01)
{
	if(param_01)
	{
		scripts\mp\gametypes\obj_ball::func_27B8(param_00,"mp_uplink_goal_carried_friendly","mp_uplink_goal_carried_enemy");
		return;
	}

	scripts\mp\gametypes\obj_ball::func_27B8(param_00,"mp_uplink_goal_friendly","mp_uplink_goal_enemy");
}

//Function Number: 39
scorefrozentimer()
{
	level endon("game_ended");
	level.var_EC39 = gettime() + 10000;
	foreach(var_01 in level.var_2798)
	{
		var_01 thread dogoalreset();
	}
}

//Function Number: 40
dogoalreset()
{
	self.var_130AD ball_waypoint_reset();
	level scripts\common\utility::waittill_any_timeout_1(10,"goal_ready");
	self.var_130AD goal_waypoint();
}

//Function Number: 41
func_27A2()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_2795 = [];
		var_00 thread func_D210();
	}
}

//Function Number: 42
func_D210()
{
	self waittill("disconnect");
	func_D017();
}

//Function Number: 43
func_2796(param_00)
{
	var_01 = func_2792(param_00);
	param_00 func_D017();
	foreach(var_06, var_03 in level.var_2798)
	{
		var_04 = scripts\common\utility::func_116D7(var_06 == var_01,"ball_goal_friendly","ball_goal_enemy");
		var_05 = function_01E1(scripts\common\utility::getfx(var_04),var_03.origin,param_00,(1,0,0));
		var_05 method_82EC();
		param_00.var_2795[var_04] = var_05;
		triggerfx(var_05);
	}
}

//Function Number: 44
func_2792(param_00)
{
	var_01 = param_00.team;
	if(var_01 != "allies" && var_01 != "axis")
	{
		if(param_00 ismlgspectator())
		{
			var_01 = param_00 method_813B();
		}
		else
		{
			var_01 = "allies";
		}
	}

	return var_01;
}

//Function Number: 45
func_D017()
{
	if(isdefined(self.var_2795))
	{
		foreach(var_01 in self.var_2795)
		{
			if(isdefined(var_01))
			{
				var_01 delete();
			}
		}
	}
}

//Function Number: 46
goal_watch_game_ended()
{
	level waittill("bro_shot_start");
	foreach(var_01 in level.players)
	{
		var_01 func_D017();
	}
}

//Function Number: 47
func_27B7()
{
	for(;;)
	{
		level waittill("joined_team",var_00);
		func_2796(var_00);
	}
}

//Function Number: 48
func_C577(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = self;
	var_0B = 0;
	if(!isdefined(param_01) || !isdefined(param_01.team) || !isdefined(var_0A) || !isdefined(var_0A.team))
	{
		return;
	}

	if(param_01 == var_0A)
	{
		return;
	}

	if(param_01.team == var_0A.team)
	{
		return;
	}

	var_0C = param_01.origin;
	var_0D = 0;
	if(isdefined(param_00))
	{
		var_0C = param_00.origin;
		var_0D = param_00 == param_01;
	}

	if(isdefined(param_01) && isplayer(param_01) && param_01.pers["team"] != var_0A.pers["team"])
	{
		if(isdefined(param_01.var_2777) && var_0D)
		{
			param_01 thread scripts\mp\_awards::func_8380("mode_uplink_kill_with_ball");
			var_0B = 1;
		}

		if(isdefined(var_0A.var_2777))
		{
			param_01 thread scripts\mp\_awards::func_8380("mode_uplink_kill_carrier");
			param_01 scripts\mp\_utility::func_93DF("defends",1);
			param_01 scripts\mp\_persistence::func_10E56("round","defends",param_01.pers["defends"]);
			thread scripts\mp\_matchdata::func_AFC5(param_09,"carrying");
			scripts\mp\gametypes\obj_ball::func_12F46("neutral",1,0);
			var_0B = 1;
		}
	}

	if(!var_0B)
	{
		var_0E = 0;
		foreach(var_10 in level.var_2800)
		{
			var_0E = func_5720(var_0C,var_0A.origin,var_10.var_4B2C);
			if(var_0E && param_01.team != var_0A.team)
			{
				if(var_10.ownerteam == var_0A.team)
				{
					param_01 thread scripts\mp\_awards::func_8380("mode_x_assault");
				}
				else if(var_10.ownerteam == param_01.team)
				{
					param_01 thread scripts\mp\_awards::func_8380("mode_x_defend");
				}

				break;
			}
		}

		if(!var_0E)
		{
			foreach(var_15, var_13 in level.var_2798)
			{
				var_14 = func_5720(var_0C,var_0A.origin,var_13.trigger.origin);
				if(var_14)
				{
					if(var_15 == var_0A.team)
					{
						param_01 thread scripts\mp\_awards::func_8380("mode_x_assault");
						continue;
					}

					param_01 thread scripts\mp\_awards::func_8380("mode_x_defend");
				}
			}
		}
	}
}

//Function Number: 49
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

//Function Number: 50
onspawnplayer()
{
	self.var_1165E = 0;
}

//Function Number: 51
func_8EC5(param_00)
{
	level waittill("game_ended");
	if(isdefined(param_00))
	{
		param_00.alpha = 0;
	}
}

//Function Number: 52
func_E189()
{
	self endon("game_ended");
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

			level.var_2798[var_01].var_130AD scripts\mp\_gameobjects::func_1CAF("none");
			level.var_2798[var_01].var_130AD.trigger = undefined;
			level.var_2798[var_01].var_130AD notify("deleted");
			foreach(var_03 in level.players)
			{
				var_03 func_D017();
			}

			level.var_2798[var_01].var_130AD.visibleteam = "none";
			level.var_2798[var_01].var_130AD scripts\mp\_gameobjects::func_F283("friendly",undefined);
			level.var_2798[var_01].var_130AD scripts\mp\_gameobjects::func_F284("friendly",undefined);
			level.var_2798[var_01].var_130AD scripts\mp\_gameobjects::func_F283("enemy",undefined);
			level.var_2798[var_01].var_130AD scripts\mp\_gameobjects::func_F284("enemy",undefined);
			setdynamicdvar("scr_devRemoveDomFlag","");
		}

		wait(1);
	}
}

//Function Number: 53
func_CC2B()
{
	self endon("game_ended");
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

			var_02 = spawnstruct();
			var_02.origin = level.players[0].origin;
			var_02.origin = var_02.origin + (0,0,190);
			var_02.var_257 = 50;
			var_02.team = var_01;
			var_02.var_279B = 0;
			var_02.var_8EE8 = 0;
			level.var_2798[var_01] = var_02;
			var_02.trigger = spawn("trigger_radius",var_02.origin - (0,0,var_02.var_257),0,var_02.var_257,var_02.var_257 * 2);
			var_02.var_130AD = scripts\mp\_gameobjects::func_4A2E(var_01,var_02.trigger,[],(0,0,var_02.var_257 * 2.1));
			var_02.var_130AD.var_155 = var_02;
			var_02.var_130AD scripts\mp\_gameobjects::func_F283("friendly","waypoint_blitz_defend");
			var_02.var_130AD scripts\mp\_gameobjects::func_F283("enemy","waypoint_blitz_goal");
			var_02.var_130AD scripts\mp\_gameobjects::func_F284("friendly","waypoint_blitz_defend");
			var_02.var_130AD scripts\mp\_gameobjects::func_F284("enemy","waypoint_blitz_goal");
			var_02.var_130AD scripts\mp\_gameobjects::setvisibleteam("any");
			var_02.var_130AD scripts\mp\_gameobjects::func_1CAF("enemy");
			var_02.var_130AD scripts\mp\_gameobjects::func_F76A(level.var_2800);
			var_02.var_130AD scripts\mp\_gameobjects::func_FB08(0);
			var_02.var_130AD scripts\mp\_gameobjects::cancontestclaim(1);
			var_02.var_130AD.var_C5BB = ::func_2779;
			var_02.var_130AD.var_393A = ::func_2794;
			var_02.var_130AD.var_C4D9 = ::ball_goal_contested;
			var_02.var_130AD.var_C5B9 = ::ball_goal_uncontested;
			var_02.var_A63A = spawn("script_model",var_02.origin + (0,0,20));
			var_02.var_A63A setscriptmoverkillcam("explosive");
			func_2795();
			setdynamicdvar("scr_devPlaceDomFlag","");
		}

		wait(1);
	}
}