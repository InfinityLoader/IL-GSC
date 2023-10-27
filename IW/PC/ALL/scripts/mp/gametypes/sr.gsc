/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\sr.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 1357 ms
 * Timestamp: 10/27/2023 12:13:11 AM
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
		scripts\mp\_utility::func_DF09(level.gametype,3,0,9);
		scripts\mp\_utility::func_DF11(level.gametype,2.5);
		scripts\mp\_utility::func_DF0B(level.gametype,1);
		scripts\mp\_utility::func_DF08(level.gametype,0);
		scripts\mp\_utility::func_DF1A(level.gametype,4);
		scripts\mp\_utility::func_DF02(level.gametype,1);
		scripts\mp\_utility::func_DEF4(level.gametype,0);
		scripts\mp\_utility::func_DF18(level.gametype,1);
		scripts\mp\_utility::func_DF19(level.gametype,4);
		scripts\mp\_utility::func_DEEB(level.gametype,1);
		level.var_B40A = 0;
		level.var_B410 = 0;
	}

	func_12E9F();
	level.var_C2A1 = 1;
	level.teambased = 1;
	level.var_C024 = 1;
	level.var_C580 = ::func_C580;
	level.var_C5A4 = ::func_C5A4;
	level.var_8136 = ::func_8136;
	level.onspawnplayer = ::onspawnplayer;
	level.var_C577 = ::func_C577;
	level.var_C4E8 = ::func_C4E8;
	level.var_C564 = ::func_C564;
	level.var_C5B2 = ::func_C5B2;
	level.var_C55E = ::func_C55E;
	level.var_7677 = ::scripts\mp\_utility::func_9EF4;
	level.var_C561 = ::func_C4CC;
	level.var_1C9A = 0;
	level.var_2C64 = 0;
	level.var_C060 = 1;
	level.var_209F = 0;
	level.var_2F35 = 0;
	if(level.var_B40A || level.var_B410)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	game["dialog"]["gametype"] = "searchrescue";
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
	game["dialog"]["lead_lost"] = "null";
	game["dialog"]["lead_tied"] = "null";
	game["dialog"]["lead_taken"] = "null";
	game["dialog"]["kill_confirmed"] = "kill_confirmed";
	game["dialog"]["revived"] = "sr_rev";
	game["dialog"]["lastalive_revive"] = "lastalive_revive";
	setomnvar("ui_bomb_timer_endtime_a",0);
	setomnvar("ui_bomb_timer_endtime_b",0);
	setomnvar("ui_bomb_planted_a",0);
	setomnvar("ui_bomb_planted_b",0);
	setomnvar("ui_allies_alive",0);
	setomnvar("ui_axis_alive",0);
	level.var_4507["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
	level thread func_C56E();
}

//Function Number: 2
func_987C()
{
	scripts\mp\_utility::func_F69D();
	setdynamicdvar("scr_sr_bombtimer",getmatchrulesdata("bombData","bombTimer"));
	setdynamicdvar("scr_sr_planttime",getmatchrulesdata("bombData","plantTime"));
	setdynamicdvar("scr_sr_defusetime",getmatchrulesdata("bombData","defuseTime"));
	setdynamicdvar("scr_sr_multibomb",getmatchrulesdata("bombData","multiBomb"));
	setdynamicdvar("scr_sr_silentPlant",getmatchrulesdata("bombData","silentPlant"));
	setdynamicdvar("scr_sr_halftime",0);
	scripts\mp\_utility::func_DEF4("sr",0);
	setdynamicdvar("scr_sr_promode",0);
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

	setclientnamemode("manual_change");
	level._effect["bomb_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_bombardment_strike_explosion");
	level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
	level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	scripts\mp\_utility::func_F7C1(game["attackers"],&"OBJECTIVES_SD_ATTACKER");
	scripts\mp\_utility::func_F7C1(game["defenders"],&"OBJECTIVES_SD_DEFENDER");
	if(level.splitscreen)
	{
		scripts\mp\_utility::func_F7C0(game["attackers"],&"OBJECTIVES_SD_ATTACKER");
		scripts\mp\_utility::func_F7C0(game["defenders"],&"OBJECTIVES_SD_DEFENDER");
	}
	else
	{
		scripts\mp\_utility::func_F7C0(game["attackers"],&"OBJECTIVES_SD_ATTACKER_SCORE");
		scripts\mp\_utility::func_F7C0(game["defenders"],&"OBJECTIVES_SD_DEFENDER_SCORE");
	}

	scripts\mp\_utility::func_F7BE(game["attackers"],&"OBJECTIVES_SD_ATTACKER_HINT");
	scripts\mp\_utility::func_F7BE(game["defenders"],&"OBJECTIVES_SD_DEFENDER_HINT");
	func_98CE();
	level.var_58BE = ::func_58BE;
	var_02[0] = "sd";
	var_02[1] = "bombzone";
	var_02[2] = "blocker";
	scripts\mp\_gameobjects::main(var_02);
	func_F855();
	thread func_2C62();
	scripts\mp\_utility::func_98D3();
}

//Function Number: 5
func_98CE()
{
	scripts\mp\_spawnlogic::func_F62D("SearchAndRescue");
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	scripts\mp\_spawnlogic::func_182D("mp_sd_spawn_attacker");
	scripts\mp\_spawnlogic::func_182D("mp_sd_spawn_defender");
	scripts\mp\_spawnlogic::func_1829("attacker","mp_tdm_spawn");
	scripts\mp\_spawnlogic::func_1829("attacker","mp_tdm_spawn_secondary",1,1);
	scripts\mp\_spawnlogic::func_1829("defender","mp_tdm_spawn");
	scripts\mp\_spawnlogic::func_1829("defender","mp_tdm_spawn_secondary",1,1);
	level.var_B32E = scripts\mp\_spawnlogic::func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
}

//Function Number: 6
func_8136()
{
	var_00 = "defender";
	if(self.pers["team"] == game["attackers"])
	{
		var_00 = "attacker";
	}

	if(scripts\mp\_spawnlogic::func_100BA())
	{
		var_01 = scripts\mp\_spawnlogic::func_8140("mp_sd_spawn_" + var_00);
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
onspawnplayer()
{
	self.var_9EE6 = 0;
	self.var_9DBC = 0;
	self.var_9D6C = 0;
	if(level.var_BDC1 && self.pers["team"] == game["attackers"])
	{
		self setclientomnvar("ui_carrying_bomb",1);
	}
	else
	{
		self setclientomnvar("ui_carrying_bomb",0);
		foreach(var_01 in level.var_2C7A)
		{
			var_01.trigger disableplayeruse(self);
		}
	}

	func_12E58();
	level notify("spawned_player");
	if(self.sessionteam == "axis" || self.sessionteam == "allies")
	{
		level notify("sr_player_joined",self);
		scripts\mp\_utility::func_F6FA(0);
		if(isdefined(self.pers["plants"]))
		{
			scripts\mp\_utility::func_F6FA(self.pers["plants"]);
		}

		scripts\mp\_utility::func_F6FB(0);
		if(isdefined(self.pers["rescues"]))
		{
			scripts\mp\_utility::func_F6FB(self.pers["rescues"]);
		}
	}
}

//Function Number: 8
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_C574();
	}
}

//Function Number: 9
func_C574()
{
	for(;;)
	{
		self waittill("disconnect");
		level func_12E58();
	}
}

//Function Number: 10
func_12E58()
{
	if(isdefined(level.var_1BE5["allies"]))
	{
		setomnvar("ui_allies_alive",level.var_1BE5["allies"].size);
	}

	if(isdefined(level.var_1BE5["axis"]))
	{
		setomnvar("ui_axis_alive",level.var_1BE5["axis"].size);
	}
}

//Function Number: 11
func_C577(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self setclientomnvar("ui_carrying_bomb",0);
	func_12E58();
	thread func_3DE9();
}

//Function Number: 12
func_3DE9()
{
	wait(0.05);
	var_00 = 0;
	if(!level.var_1BE6[game["attackers"]])
	{
		level.var_10978[game["attackers"]].var_1C90 = 1;
		var_00 = 1;
	}

	if(!level.var_1BE6[game["defenders"]])
	{
		level.var_10978[game["defenders"]].var_1C90 = 1;
		var_00 = 1;
	}

	if(var_00)
	{
		scripts\mp\_spectating::func_12F21();
	}
}

//Function Number: 13
func_EFFD(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(!isai(var_03))
		{
			var_03 setclientomnvar("ui_objective_state",0);
		}
	}

	thread scripts\mp\_gamelogic::endgame(param_00,param_01);
}

//Function Number: 14
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
			func_EFFD(game["attackers"],game["end_reason"][game["defenders"] + "_eliminated"]);
			return;
		}

		func_EFFD(game["defenders"],game["end_reason"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(param_00 == game["attackers"])
	{
		if(level.var_2C5C)
		{
			return;
		}

		level thread func_EFFD(game["defenders"],game["end_reason"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(param_00 == game["defenders"])
	{
		level thread func_EFFD(game["attackers"],game["end_reason"][game["defenders"] + "_eliminated"]);
		return;
	}
}

//Function Number: 15
func_C564(param_00)
{
	if(level.var_2C58 > 0 || level.var_2C4A)
	{
		return;
	}

	var_01 = scripts\mp\_utility::func_7F5E(param_00);
	var_01 thread func_8378();
}

//Function Number: 16
func_C55E(param_00,param_01,param_02,param_03,param_04)
{
	scripts\mp\gametypes\common::func_C55E(param_00,param_01,param_02,param_03,param_04);
	var_05 = scripts\mp\_rank::func_8104("kill");
	var_06 = param_00.team;
	if(param_00.var_9EE6)
	{
		thread scripts\mp\_matchdata::func_AFC5(param_02,"planting");
		param_01 scripts\mp\_utility::func_93DF("defends",1);
		param_01 scripts\mp\_persistence::func_10E56("round","defends",param_01.pers["defends"]);
	}
	else if(param_00.var_9D6C)
	{
		thread scripts\mp\_matchdata::func_AFC5(param_02,"carrying");
	}
	else if(param_00.var_9DBC)
	{
		thread scripts\mp\_matchdata::func_AFC5(param_02,"defusing");
		param_01 scripts\mp\_utility::func_93DF("defends",1);
		param_01 scripts\mp\_persistence::func_10E56("round","defends",param_01.pers["defends"]);
	}

	scripts\mp\gametypes\obj_bombzone::func_2C6F(param_01,param_00);
}

//Function Number: 17
func_8378()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	scripts\mp\_utility::func_1383E(3);
	var_00 = scripts\mp\_utility::getotherteam(self.pers["team"]);
	level thread scripts\mp\_utility::func_115DE("callout_lastteammemberalive",self,self.pers["team"]);
	level thread scripts\mp\_utility::func_115DE("callout_lastenemyalive",self,var_00);
	foreach(var_02 in level.players)
	{
		if(var_02.pers["team"] == self.pers["team"])
		{
			if(isdefined(var_02.var_113EF) && var_02.var_113EF)
			{
				level.var_C060 = 0;
			}
		}
	}

	scripts\mp\_music_and_dialog::func_C54B(self);
	scripts\mp\_missions::func_A9B5();
}

//Function Number: 18
func_C5B2()
{
	func_EFFD(game["defenders"],game["end_reason"]["time_limit_reached"]);
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.var_2C5E))
		{
			var_01 scripts\mp\_utility::func_141E(var_01.var_2C5E);
			break;
		}
	}
}

//Function Number: 19
func_12E9F()
{
	scripts\mp\gametypes\common::func_12E9F();
	level.var_CC52 = scripts\mp\_utility::dvarfloatvalue("planttime",5,0,20);
	level.var_50AB = scripts\mp\_utility::dvarfloatvalue("defusetime",5,0,20);
	level.var_2C6C = scripts\mp\_utility::dvarfloatvalue("bombtimer",45,1,300);
	level.var_BDC1 = scripts\mp\_utility::dvarintvalue("multibomb",0,0,1);
	level.var_101F7 = scripts\mp\_utility::dvarintvalue("silentPlant",0,0,1);
}

//Function Number: 20
func_E0D8(param_00)
{
	var_01 = [];
	var_02 = getentarray("script_brushmodel","classname");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.var_EDBF) && var_04.var_EDBF == "bombzone")
		{
			foreach(var_06 in param_00)
			{
				if(distance(var_04.origin,var_06.origin) < 100 && issubstr(tolower(var_06.script_label),"c"))
				{
					var_06.var_DF2F = var_04;
					var_01[var_01.size] = var_06;
					break;
				}
			}
		}
	}

	foreach(var_0A in var_01)
	{
		var_0A.var_DF2F delete();
		var_0B = getentarray(var_0A.target,"targetname");
		foreach(var_0D in var_0B)
		{
			var_0D delete();
		}

		var_0A delete();
	}

	return scripts\common\utility::func_22BC(param_00);
}

//Function Number: 21
func_2C62()
{
	scripts\mp\gametypes\obj_bombzone::func_2C77("sd_bomb");
	level.var_2C7A = [];
	var_00 = getentarray("bombzone","targetname");
	var_00 = func_E0D8(var_00);
	level.var_C2A8 = var_00;
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = scripts\mp\gametypes\obj_bombzone::func_2C78(var_01);
		var_02.var_C4CB = ::func_C4CB;
		var_02.var_C50D = ::func_C50D;
		var_02.var_C5BB = ::func_C5C6;
		level.var_2C7A[level.var_2C7A.size] = var_02;
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
}

//Function Number: 22
func_C4CB(param_00)
{
	scripts\mp\gametypes\obj_bombzone::func_2C71(param_00);
	if(!scripts\mp\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		if(level.var_BDC1)
		{
			for(var_01 = 0;var_01 < self.var_C749.size;var_01++)
			{
				self.var_C749[var_01] scripts\mp\_gameobjects::func_1CAF("none");
				self.var_C749[var_01] scripts\mp\_gameobjects::setvisibleteam("friendly");
			}
		}
	}
}

//Function Number: 23
func_C50D(param_00,param_01,param_02)
{
	scripts\mp\gametypes\obj_bombzone::func_2C74(param_00,param_01,param_02);
	if(!scripts\mp\_gameobjects::isfriendlyteam(param_01.pers["team"]))
	{
		if(level.var_BDC1 && !param_02)
		{
			for(var_03 = 0;var_03 < self.var_C749.size;var_03++)
			{
				self.var_C749[var_03] scripts\mp\_gameobjects::func_1CAF("enemy");
				self.var_C749[var_03] scripts\mp\_gameobjects::setvisibleteam("any");
			}
		}
	}
}

//Function Number: 24
func_C5C6(param_00)
{
	if(!scripts\mp\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		for(var_01 = 0;var_01 < level.var_2C7A.size;var_01++)
		{
			if(level.var_2C7A[var_01] == self)
			{
				continue;
			}

			level.var_2C7A[var_01] scripts\mp\_gameobjects::disableobject();
		}
	}

	scripts\mp\gametypes\obj_bombzone::func_2C76(param_00);
}

//Function Number: 25
func_C4CC(param_00,param_01,param_02,param_03,param_04)
{
	if(param_03 == game["attackers"])
	{
		function_01AF(0);
		wait(3);
		func_EFFD(game["attackers"],game["end_reason"]["target_destroyed"]);
		return;
	}

	wait(1.5);
	function_01AF(0);
	func_EFFD(game["defenders"],game["end_reason"]["bomb_defused"]);
}

//Function Number: 26
func_F855()
{
	if(function_011C() && scripts\mp\_utility::func_7F91("defaultClasses",game["attackers"],5,"class","inUse"))
	{
		level.var_F004[game["attackers"]] = scripts\mp\_utility::func_7F92(game["attackers"],5);
	}
}

//Function Number: 27
func_58BE(param_00)
{
	param_00 scripts\mp\_utility::func_F6FB(param_00.pers["rescues"]);
}