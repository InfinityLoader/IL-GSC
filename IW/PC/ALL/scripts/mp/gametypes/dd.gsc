/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\dd.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 1699 ms
 * Timestamp: 10/27/2023 12:12:25 AM
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
		scripts\mp\_utility::func_DF09(level.gametype,1,0,9);
		scripts\mp\_utility::func_DF11(level.gametype,3);
		scripts\mp\_utility::func_DF0B(level.gametype,0);
		scripts\mp\_utility::func_DF08(level.gametype,3);
		scripts\mp\_utility::func_DF1A(level.gametype,2);
		scripts\mp\_utility::func_DF02(level.gametype,0);
		scripts\mp\_utility::func_DEF4(level.gametype,0);
		scripts\mp\_utility::func_F7D3(2);
		level.var_B40A = 0;
		level.var_B410 = 0;
	}

	func_12E9F();
	level.var_C2A1 = 1;
	level.teambased = 1;
	level.var_C580 = ::func_C580;
	level.var_C5A4 = ::func_C5A4;
	level.var_8136 = ::func_8136;
	level.onspawnplayer = ::onspawnplayer;
	level.var_C4E8 = ::func_C4E8;
	level.var_C5B2 = ::func_C5B2;
	level.var_C55E = ::func_C55E;
	level.var_7677 = ::scripts\mp\_utility::func_9EF4;
	if(level.var_B40A || level.var_B410)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	level.var_4DA2 = 1;
	level.var_2C64 = 0;
	level.var_4DA4 = [];
	level.var_209F = 0;
	level.var_2F35 = 0;
	scripts\mp\gametypes\obj_bombzone::func_F66F();
	game["dialog"]["gametype"] = "demolition";
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

	game["dialog"]["offense_obj"] = "obj_destroy";
	game["dialog"]["defense_obj"] = "obj_defend";
	setomnvar("ui_bomb_timer_endtime_a",0);
	setomnvar("ui_bomb_timer_endtime_b",0);
	setomnvar("ui_bomb_planted_a",0);
	setomnvar("ui_bomb_planted_b",0);
}

//Function Number: 2
func_987C()
{
	scripts\mp\_utility::func_F69D();
	setdynamicdvar("scr_dd_bombtimer",getmatchrulesdata("bombData","bombTimer"));
	setdynamicdvar("scr_dd_planttime",getmatchrulesdata("bombData","plantTime"));
	setdynamicdvar("scr_dd_defusetime",getmatchrulesdata("bombData","defuseTime"));
	setdynamicdvar("scr_dd_silentPlant",getmatchrulesdata("bombData","silentPlant"));
	setdynamicdvar("scr_dd_extratime",getmatchrulesdata("demData","extraTime"));
	setdynamicdvar("scr_dd_overtimeLimit",getmatchrulesdata("demData","overtimeLimit"));
	setdynamicdvar("scr_dd_halftime",0);
	scripts\mp\_utility::func_DEF4("dd",0);
	setdynamicdvar("scr_dd_promode",0);
}

//Function Number: 3
func_C580()
{
	game["bomb_dropped_sound"] = "mp_war_objective_lost";
	game["bomb_recovered_sound"] = "mp_war_objective_taken";
}

//Function Number: 4
func_C5A4()
{
	if(game["roundsPlayed"] == 2)
	{
		game["status"] = "overtime";
		setdvar("ui_overtime",1);
	}

	if(scripts\mp\_utility::func_9900())
	{
		setomnvar("ui_round_hint_override_attackers",1);
		setomnvar("ui_round_hint_override_defenders",1);
	}

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

	level.var_130DD = 1;
	setclientnamemode("manual_change");
	if(scripts\mp\_utility::func_9900())
	{
		game["dialog"]["defense_obj"] = "obj_destroy";
	}

	level._effect["bomb_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_bombardment_strike_explosion");
	level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
	level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	scripts\mp\_utility::func_F7C1(game["attackers"],&"OBJECTIVES_DD_ATTACKER");
	scripts\mp\_utility::func_F7C1(game["defenders"],&"OBJECTIVES_DD_DEFENDER");
	if(level.splitscreen)
	{
		scripts\mp\_utility::func_F7C0(game["attackers"],&"OBJECTIVES_DD_ATTACKER");
		scripts\mp\_utility::func_F7C0(game["defenders"],&"OBJECTIVES_DD_DEFENDER");
	}
	else
	{
		scripts\mp\_utility::func_F7C0(game["attackers"],&"OBJECTIVES_DD_ATTACKER_SCORE");
		scripts\mp\_utility::func_F7C0(game["defenders"],&"OBJECTIVES_DD_DEFENDER_SCORE");
	}

	if(scripts\mp\_utility::func_9900())
	{
		scripts\mp\_utility::func_F7BE(game["attackers"],&"OBJECTIVES_DD_OVERTIME_HINT");
		scripts\mp\_utility::func_F7BE(game["defenders"],&"OBJECTIVES_DD_OVERTIME_HINT");
	}
	else
	{
		scripts\mp\_utility::func_F7BE(game["attackers"],&"OBJECTIVES_DD_ATTACKER_HINT");
		scripts\mp\_utility::func_F7BE(game["defenders"],&"OBJECTIVES_DD_DEFENDER_HINT");
	}

	thread func_13849();
	var_02 = scripts\mp\_utility::getwatcheddvar("winlimit");
	var_03[0] = "dd";
	var_03[1] = "dd_bombzone";
	var_03[2] = "blocker";
	scripts\mp\_gameobjects::main(var_03);
	thread func_2C62();
	scripts\mp\_utility::func_98D3();
}

//Function Number: 5
func_98CE()
{
	scripts\mp\_spawnlogic::func_F62D("TDM");
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	scripts\mp\_spawnlogic::func_182D("mp_dd_spawn_attacker");
	scripts\mp\_spawnlogic::func_182D("mp_dd_spawn_defender");
	if(!isdefined(level.var_10DF1))
	{
		scripts\mp\_spawnlogic::func_182D("mp_sd_spawn_attacker");
		scripts\mp\_spawnlogic::func_182D("mp_sd_spawn_defender");
	}

	scripts\mp\_spawnlogic::func_1829(game["defenders"],"mp_dd_spawn_defender");
	scripts\mp\_spawnlogic::func_1829(game["defenders"],"mp_dd_spawn_defender_a",1);
	scripts\mp\_spawnlogic::func_1829(game["defenders"],"mp_dd_spawn_defender_b",1);
	scripts\mp\_spawnlogic::func_1829(game["attackers"],"mp_dd_spawn_attacker");
	scripts\mp\_spawnlogic::func_1829(game["attackers"],"mp_dd_spawn_attacker_a",1);
	scripts\mp\_spawnlogic::func_1829(game["attackers"],"mp_dd_spawn_attacker_b",1);
	scripts\mp\_spawnlogic::func_1829(game["attackers"],"mp_tdm_spawn");
	level.var_1069E = scripts\mp\_spawnlogic::func_8140("mp_dd_spawn_defender");
	level.var_1069F = scripts\mp\_spawnlogic::func_8140("mp_dd_spawn_defender_a");
	level.var_1069F = scripts\common\utility::array_combine(level.var_1069E,level.var_1069F);
	level.var_106A0 = scripts\mp\_spawnlogic::func_8140("mp_dd_spawn_defender_b");
	level.var_106A0 = scripts\common\utility::array_combine(level.var_1069E,level.var_106A0);
	level.var_106A1 = scripts\common\utility::array_combine(level.var_1069E,level.var_1069F,level.var_106A0);
	level.var_10644 = scripts\mp\_spawnlogic::func_8140("mp_dd_spawn_attacker");
	level.var_10645 = scripts\mp\_spawnlogic::func_8140("mp_dd_spawn_attacker_a");
	level.var_10645 = scripts\common\utility::array_combine(level.var_10644,level.var_10645);
	level.var_10646 = scripts\mp\_spawnlogic::func_8140("mp_dd_spawn_attacker_b");
	level.var_10646 = scripts\common\utility::array_combine(level.var_10644,level.var_10646);
	level.var_10647 = scripts\common\utility::array_combine(level.var_10644,level.var_10645,level.var_10646);
	level.var_106A2 = scripts\mp\_spawnlogic::func_8140("mp_dd_spawn_defender_start");
	level.var_10648 = scripts\mp\_spawnlogic::func_8140("mp_dd_spawn_attacker_start");
	level.var_B32E = scripts\mp\_spawnlogic::func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
}

//Function Number: 6
func_8141(param_00,param_01)
{
	var_02 = function_00C0(param_00.origin,param_01,16000);
	if(var_02 < 0)
	{
		var_02 = distance(param_00.origin,param_01);
	}

	return var_02;
}

//Function Number: 7
func_13849()
{
	level endon("game_end");
	for(;;)
	{
		if(level.ingraceperiod == 0)
		{
			break;
		}

		wait(0.05);
	}

	level.var_130DD = 0;
}

//Function Number: 8
func_8136()
{
	var_00 = self.pers["team"];
	if(level.var_130DD)
	{
		if(var_00 == game["attackers"])
		{
			var_01 = scripts\mp\_spawnlogic::func_813C(level.var_10648);
		}
		else
		{
			var_01 = scripts\mp\_spawnlogic::func_813C(level.var_106A2);
		}
	}
	else
	{
		var_02 = undefined;
		if(var_00 == game["attackers"])
		{
			if(scripts\mp\_utility::func_9900())
			{
				var_02 = level.var_10644;
			}
			else if(!level.var_209F && !level.var_2F35)
			{
				var_02 = level.var_10644;
			}
			else if(level.var_209F && !level.var_2F35)
			{
				var_02 = level.var_10645;
			}
			else if(level.var_2F35 && !level.var_209F)
			{
				var_02 = level.var_10646;
			}
			else
			{
				var_02 = level.var_10644;
			}

			var_03 = level.var_10647;
			var_01 = scripts\mp\_spawnscoring::func_8136(var_02,var_03);
		}
		else
		{
			if(scripts\mp\_utility::func_9900())
			{
				var_03 = level.var_1069E;
			}
			else if(!level.var_209F && !level.var_2F35)
			{
				var_03 = level.var_1069E;
			}
			else if(level.var_209F && !level.var_2F35)
			{
				var_03 = level.var_1069F;
			}
			else if(level.var_2F35 && !level.var_209F)
			{
				var_03 = level.var_106A0;
			}
			else
			{
				var_03 = level.var_1069E;
			}

			var_03 = level.var_106A1;
			var_01 = scripts\mp\_spawnscoring::func_8136(var_02,var_03);
		}
	}

	return var_01;
}

//Function Number: 9
onspawnplayer()
{
	if(scripts\mp\_utility::func_B3EC())
	{
		scripts\mp\gametypes\common::onspawnplayer();
	}

	if(scripts\mp\_utility::func_9900() || self.pers["team"] == game["attackers"])
	{
		self setclientomnvar("ui_carrying_bomb",1);
		self.var_9EE6 = 0;
		self.var_9DBC = 0;
		self.var_9D6C = 1;
	}
	else
	{
		self.var_9EE6 = 0;
		self.var_9DBC = 0;
		self.var_9D6C = 0;
	}

	if(isdefined(self.pers["plants"]))
	{
		scripts\mp\_utility::func_F6FA(self.pers["plants"]);
	}
	else
	{
		scripts\mp\_utility::func_F6FA(0);
	}

	if(isdefined(self.pers["defuses"]))
	{
		scripts\mp\_utility::func_F6FB(self.pers["defuses"]);
	}
	else
	{
		scripts\mp\_utility::func_F6FB(0);
	}

	level notify("spawned_player");
}

//Function Number: 10
func_8EBA()
{
	self endon("disconnect");
	level waittill("game_ended");
	if(isdefined(self.var_3AF5))
	{
		self.var_3AF5.alpha = 0;
	}
}

//Function Number: 11
func_4DA3(param_00,param_01)
{
	thread scripts\mp\_gamelogic::endgame(param_00,param_01);
}

//Function Number: 12
func_C4E8(param_00)
{
	if(level.var_2C58 > 0 || level.var_2C4A)
	{
		return;
	}

	if(param_00 == "all")
	{
		if(level.var_2C5C)
		{
			func_4DA3(game["attackers"],game["end_reason"][game["defenders"] + "_eliminated"]);
			return;
		}

		func_4DA3(game["defenders"],game["end_reason"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(param_00 == game["attackers"])
	{
		if(level.var_2C5C)
		{
			return;
		}

		level thread func_4DA3(game["defenders"],game["end_reason"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(param_00 == game["defenders"])
	{
		level thread func_4DA3(game["attackers"],game["end_reason"][game["defenders"] + "_eliminated"]);
		return;
	}
}

//Function Number: 13
func_C55E(param_00,param_01,param_02,param_03,param_04)
{
	scripts\mp\gametypes\common::func_C55E(param_00,param_01,param_02,param_03,param_04);
	var_05 = param_00.team;
	if(param_00.var_9EE6)
	{
		thread scripts\mp\_matchdata::func_AFC5(param_02,"planting");
		param_01 scripts\mp\_utility::func_93DF("defends",1);
		param_01 scripts\mp\_persistence::func_10E56("round","defends",param_01.pers["defends"]);
	}
	else if(param_00.var_9DBC)
	{
		thread scripts\mp\_matchdata::func_AFC5(param_02,"defusing");
		param_01 scripts\mp\_utility::func_93DF("defends",1);
		param_01 scripts\mp\_persistence::func_10E56("round","defends",param_01.pers["defends"]);
	}

	scripts\mp\gametypes\obj_bombzone::func_2C6F(param_01,param_00);
}

//Function Number: 14
func_C5B2()
{
	if(scripts\mp\_utility::func_9900())
	{
		func_4DA3("tie",game["end_reason"]["time_limit_reached"]);
		return;
	}

	func_4DA3(game["defenders"],game["end_reason"]["time_limit_reached"]);
}

//Function Number: 15
func_12E9F()
{
	scripts\mp\gametypes\common::func_12E9F();
	level.var_CC52 = scripts\mp\_utility::dvarfloatvalue("planttime",5,0,20);
	level.var_50AB = scripts\mp\_utility::dvarfloatvalue("defusetime",5,0,20);
	level.var_2C6C = scripts\mp\_utility::dvarintvalue("bombtimer",45,1,300);
	level.var_4DA5 = scripts\mp\_utility::dvarfloatvalue("extraTime",2,0,5);
	level.var_C82B = scripts\mp\_utility::dvarfloatvalue("overtimeLimit",1,0,5);
	scripts\mp\_utility::func_F7D3(level.var_C82B);
	level.var_101F7 = scripts\mp\_utility::dvarintvalue("silentPlant",0,0,1);
}

//Function Number: 16
func_132A2(param_00)
{
	var_01 = "";
	if(param_00.size != 3)
	{
		var_02 = 0;
		var_03 = 0;
		var_04 = 0;
		foreach(var_06 in param_00)
		{
			if(issubstr(tolower(var_06.script_label),"a"))
			{
				var_02 = 1;
				continue;
			}

			if(issubstr(tolower(var_06.script_label),"b"))
			{
				var_03 = 1;
				continue;
			}

			if(issubstr(tolower(var_06.script_label),"c"))
			{
				var_04 = 1;
			}
		}

		if(!var_02)
		{
			var_01 = var_01 + " A ";
		}

		if(!var_03)
		{
			var_01 = var_01 + " B ";
		}

		if(!var_04)
		{
			var_01 = var_01 + " C ";
		}
	}

	if(var_01 != "")
	{
	}
}

//Function Number: 17
func_2C62()
{
	level.var_2C5C = 0;
	level.var_2C4A = 0;
	level.var_2C58 = 0;
	level.var_BDC1 = 1;
	level.var_2C7A = [];
	var_00 = getentarray("dd_bombzone","targetname");
	level.var_C2A8 = var_00;
	func_132A2(var_00);
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = scripts\mp\gametypes\obj_bombzone::func_2C78(var_01);
		if(isdefined(var_02))
		{
			var_02.var_C4CB = ::func_C4CB;
			var_02.var_C50D = ::func_C50D;
			var_02.var_C5BB = ::func_C5C6;
			level.var_2C7A[level.var_2C7A.size] = var_02;
		}
	}

	for(var_01 = 0;var_01 < level.var_2C7A.size;var_01++)
	{
		var_03 = [];
		for(var_04 = 0;var_04 < level.var_2C7A.size;var_04++)
		{
			if(var_04 != var_01)
			{
				var_03[var_03.size] = level.var_2C7A[var_04];
			}
		}

		level.var_2C7A[var_01].var_C749 = var_03;
	}

	thread func_98CE();
}

//Function Number: 18
func_C4CB(param_00)
{
	scripts\mp\gametypes\obj_bombzone::func_2C71(param_00);
}

//Function Number: 19
func_C50D(param_00,param_01,param_02)
{
	scripts\mp\gametypes\obj_bombzone::func_2C74(param_00,param_01,param_02);
}

//Function Number: 20
func_C5C6(param_00)
{
	scripts\mp\gametypes\obj_bombzone::func_2C76(param_00);
}

//Function Number: 21
func_FAC9()
{
	var_00 = spawn("script_origin",self.origin);
	var_00.angles = self.angles;
	var_00 rotateyaw(-45,0.05);
	wait(0.05);
	var_01 = self.origin + (0,0,5);
	var_02 = self.origin + anglestoforward(var_00.angles) * 100 + (0,0,128);
	var_03 = bullettrace(var_01,var_02,0,self);
	self.var_A63A = spawn("script_model",var_03["position"]);
	self.var_A63A setscriptmoverkillcam("explosive");
	var_00 delete();
}

//Function Number: 22
func_E249()
{
	if(scripts\mp\_utility::func_9900())
	{
		scripts\mp\_gameobjects::func_F7D4("neutral");
		scripts\mp\_gameobjects::func_1CAF("any");
		var_00 = "waypoint_target_b";
		var_01 = "waypoint_target_b";
	}
	else
	{
		scripts\mp\_gameobjects::func_1CAF("enemy");
		var_00 = "waypoint_defend" + self.label;
		var_01 = "waypoint_target" + self.label;
	}

	self.var_92B8 = "bomb_zone";
	scripts\mp\_gameobjects::func_FB08(level.var_CC52);
	scripts\mp\_gameobjects::func_FB07(&"MP_PLANTING_EXPLOSIVE");
	scripts\mp\_gameobjects::func_FB06(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
	scripts\mp\_gameobjects::func_F283("friendly",var_00);
	scripts\mp\_gameobjects::func_F284("friendly",var_00);
	scripts\mp\_gameobjects::func_F283("enemy",var_01);
	scripts\mp\_gameobjects::func_F284("enemy",var_01);
	scripts\mp\_gameobjects::setvisibleteam("any");
	self.var_130F8 = "briefcase_bomb_mp";
	self.var_2C58 = undefined;
}

//Function Number: 23
func_FAAE()
{
	if(scripts\mp\_utility::func_9900())
	{
		var_00 = "waypoint_defuse";
		var_01 = "waypoint_defend";
	}
	else
	{
		var_00 = "waypoint_defuse" + self.label;
		var_01 = "waypoint_defend" + self.label;
	}

	scripts\mp\_gameobjects::func_1CAF("friendly");
	scripts\mp\_gameobjects::func_FB08(level.var_50AB);
	scripts\mp\_gameobjects::func_FB07(&"MP_DEFUSING_EXPLOSIVE");
	scripts\mp\_gameobjects::func_FB06(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	scripts\mp\_gameobjects::func_F76A(undefined);
	scripts\mp\_gameobjects::func_F283("friendly",var_00);
	scripts\mp\_gameobjects::func_F284("friendly",var_00);
	scripts\mp\_gameobjects::func_F283("enemy",var_01);
	scripts\mp\_gameobjects::func_F284("enemy",var_01);
	scripts\mp\_gameobjects::setvisibleteam("any");
}

//Function Number: 24
func_C4D4(param_00)
{
	param_00 iprintlnbold(&"MP_BOMBSITE_IN_USE");
}

//Function Number: 25
func_C581()
{
}

//Function Number: 26
func_2C5C(param_00,param_01)
{
	param_00 endon("defused");
	var_02 = param_01.team;
	level.var_2C64 = level.var_2C64 + 1;
	func_F66E();
	scripts\mp\_gamelogic::func_C9D6();
	level.var_1190A = gettime();
	level.var_118FA = 1;
	level.var_2C5C = 1;
	level.var_52D9 = param_00;
	if(level.var_52D9.label == "_a")
	{
		level.var_209F = 1;
	}
	else
	{
		level.var_2F35 = 1;
	}

	level.var_52D9.var_2C5C = 1;
	level.var_118A0 = param_00.visuals[0];
	func_5D23(param_01,param_00.label);
	param_00.var_2C4A = 0;
	param_00 scripts\mp\_gameobjects::func_1CAF("none");
	param_00 scripts\mp\_gameobjects::setvisibleteam("none");
	if(scripts\mp\_utility::func_9900())
	{
		param_00 scripts\mp\_gameobjects::func_F7D4(level.var_C74B[param_01.team]);
	}

	param_00 func_FAAE();
	param_00 func_2C6D(param_00);
	param_00 thread func_2C59(param_01,"explode",var_02);
}

//Function Number: 27
func_2C59(param_00,param_01,param_02)
{
	level.var_2C64 = level.var_2C64 - 1;
	if(self.label == "_a")
	{
		level.var_209F = 0;
	}
	else
	{
		level.var_2F35 = 0;
	}

	func_E2B5();
	scripts\mp\gametypes\obj_bombzone::func_F66F();
	if(level.var_7669)
	{
		return;
	}

	if(param_01 == "explode")
	{
		self.var_2C58 = 1;
		if(!scripts\mp\_utility::func_9900() && level.var_2C58 < 2 && level.var_4DA5 > 0)
		{
			level.var_6A53 = level.var_2C58 * level.var_4DA5;
			var_03 = scripts\mp\_gamelogic::func_81CD();
			function_01AF(gettime() + int(var_03));
		}

		wait(2);
		if(scripts\mp\_utility::func_9900() || level.var_2C58 > 1)
		{
			func_4DA3(param_02,game["end_reason"]["target_destroyed"]);
			return;
		}

		if(level.var_4DA5 > 0)
		{
			level thread scripts\mp\_utility::func_115DE("callout_time_added",param_00);
			return;
		}

		return;
	}

	param_00 notify("bomb_defused" + self.label);
	self notify("defused");
	func_E249();
}

//Function Number: 28
func_F66E()
{
	if(level.var_2C64 == 1)
	{
		setomnvar("ui_bomb_timer",2);
		return;
	}

	if(level.var_2C64 == 2)
	{
		setomnvar("ui_bomb_timer",3);
		return;
	}

	setomnvar("ui_bomb_timer",0);
}

//Function Number: 29
func_5D23(param_00,param_01)
{
	var_02 = bullettrace(param_00.origin + (0,0,20),param_00.origin - (0,0,2000),0,param_00);
	var_03 = randomfloat(360);
	var_04 = (cos(var_03),sin(var_03),0);
	var_04 = vectornormalize(var_04 - var_02["normal"] * vectordot(var_04,var_02["normal"]));
	var_05 = vectortoangles(var_04);
	level.var_4DA4[param_01] = spawn("script_model",var_02["position"]);
	level.var_4DA4[param_01].angles = var_05;
	level.var_4DA4[param_01] setmodel("prop_suitcase_bomb");
}

//Function Number: 30
func_E2B5()
{
	if(scripts\mp\_utility::func_9900())
	{
		if(level.var_2C58 == 1)
		{
			return;
		}
	}
	else if(level.var_2C58 > 1)
	{
		return;
	}

	if(level.var_2C64 <= 0)
	{
		scripts\mp\_gamelogic::func_E2FF();
		level.var_11909 = gettime() - level.var_1190A;
		level.var_118FA = 0;
	}
}

//Function Number: 31
func_2C6D(param_00)
{
	level endon("game_ended");
	level endon("bomb_defused" + param_00.label);
	if(scripts\mp\_utility::func_9900())
	{
		param_00.var_13845 = level.var_2C6C;
	}
	else
	{
		param_00.var_13845 = level.var_2C6C;
	}

	level thread func_12E43(param_00);
	while(param_00.var_13845 >= 0)
	{
		param_00.var_13845--;
		if(param_00.var_13845 >= 0)
		{
			wait(1);
		}

		scripts\mp\_hostmigration::func_13834();
	}
}

//Function Number: 32
func_12E43(param_00)
{
	level endon("game_ended");
	level endon("disconnect");
	level endon("bomb_defused" + param_00.label);
	level endon("bomb_exploded" + param_00.label);
	var_01 = param_00.var_13845 * 1000 + gettime();
	setdvar("ui_bombtimer" + param_00.label,var_01);
	level waittill("host_migration_begin");
	var_02 = scripts\mp\_hostmigration::func_13834();
	if(var_02 > 0)
	{
		setdvar("ui_bombtimer" + param_00.label,var_01 + var_02);
	}
}

//Function Number: 33
func_2C4A(param_00)
{
	level.var_118A0 scripts\mp\_gamelogic::func_11094();
	param_00.var_2C4A = 1;
	level notify("bomb_defused" + param_00.label);
}