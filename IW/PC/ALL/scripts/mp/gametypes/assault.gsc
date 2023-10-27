/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\assault.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 1306 ms
 * Timestamp: 10/27/2023 12:12:12 AM
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
		scripts\mp\_utility::func_DF09(level.gametype,1,0,9);
		scripts\mp\_utility::func_DF11(level.gametype,3);
		scripts\mp\_utility::func_DF0B(level.gametype,1);
		scripts\mp\_utility::func_DF08(level.gametype,0);
		scripts\mp\_utility::func_DF1A(level.gametype,3);
		scripts\mp\_utility::func_DF02(level.gametype,0);
		scripts\mp\_utility::func_DEF4(level.gametype,0);
		level.var_B40A = 0;
		level.var_B410 = 0;
	}

	var_00 = scripts\mp\_utility::getwatcheddvar("timelimit");
	scripts\mp\_utility::registerwatchdvarint("addObjectiveTime",var_00);
	func_12E9F();
	level.var_C2A1 = 1;
	level.teambased = 1;
	level.var_C024 = 1;
	level.var_C580 = ::func_C580;
	level.var_C5A4 = ::func_C5A4;
	level.var_8136 = ::func_8136;
	level.onspawnplayer = ::onspawnplayer;
	level.var_C577 = ::func_C577;
	level.var_C5B2 = ::func_C5B2;
	level.var_C55E = ::func_C55E;
	level.var_C561 = ::func_C561;
	level.var_1C9A = 0;
	if(level.var_B40A || level.var_B410)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	game["dialog"]["offense_obj"] = "obj_destroy";
	game["dialog"]["defense_obj"] = "obj_defend";
	game["dialog"]["lead_lost"] = "null";
	game["dialog"]["lead_tied"] = "null";
	game["dialog"]["lead_taken"] = "null";
}

//Function Number: 2
func_987C()
{
	scripts\mp\_utility::func_F69D();
	var_00 = getmatchrulesdata("assaultData","roundLength");
	setdynamicdvar("scr_assault_timelimit",var_00);
	scripts\mp\_utility::func_DF11("assault",var_00);
	var_01 = getmatchrulesdata("assaultData","roundSwitch");
	setdynamicdvar("scr_assault_roundswitch",var_01);
	scripts\mp\_utility::func_DF09("assault",var_01,0,9);
	var_02 = getmatchrulesdata("commonOption","scoreLimit");
	setdynamicdvar("scr_assault_winlimit",var_02);
	scripts\mp\_utility::func_DF1A("assault",var_02);
	setdynamicdvar("scr_assault_bombtimer",getmatchrulesdata("assaultData","bombTimer"));
	setdynamicdvar("scr_assault_planttime",getmatchrulesdata("assaultData","plantTime"));
	setdynamicdvar("scr_assault_defusetime",getmatchrulesdata("assaultData","defuseTime"));
	setdynamicdvar("scr_assault_multibomb",getmatchrulesdata("assaultData","multiBomb"));
	setdynamicdvar("scr_assault_bombResetTimer",getmatchrulesdata("assaultData","bombResetTimer"));
	setdynamicdvar("scr_assault_roundlimit",0);
	scripts\mp\_utility::func_DF08("assault",0);
	setdynamicdvar("scr_assault_scorelimit",1);
	scripts\mp\_utility::func_DF0B("assault",1);
	setdynamicdvar("scr_assault_halftime",0);
	scripts\mp\_utility::func_DEF4("assault",0);
	setdynamicdvar("scr_assault_promode",0);
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
	level._effect["bomb_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
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
	var_02[0] = "sd";
	var_02[1] = "bombzone";
	var_02[2] = "blocker";
	scripts\mp\_gameobjects::main(var_02);
	func_F855();
	thread func_987D();
}

//Function Number: 5
func_98CE()
{
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	scripts\mp\_spawnlogic::func_182D("mp_assault_spawn_attacker_start");
	scripts\mp\_spawnlogic::func_182D("mp_assault_spawn_defender_start");
	level.var_B32E = scripts\mp\_spawnlogic::func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
	level.var_23AA = [];
	func_97DC("attacker");
	func_97DC("defender");
}

//Function Number: 6
func_97DC(param_00)
{
	level.var_23AA[param_00] = [];
	var_01 = "mp_assault_spawn_" + param_00;
	var_02 = scripts\mp\_spawnlogic::func_8140(var_01);
	foreach(var_04 in var_02)
	{
		var_05 = var_04.script_noteworthy;
		if(!isdefined(level.var_23AA[param_00][var_05]))
		{
			level.var_23AA[param_00][var_05] = [];
		}

		level.var_23AA[param_00][var_05][level.var_23AA[param_00][var_05].size] = var_04;
	}
}

//Function Number: 7
func_8136()
{
	var_00 = self.pers["team"];
	var_01 = "defender";
	if(var_00 == game["attackers"])
	{
		var_01 = "attacker";
	}

	if(level.ingraceperiod)
	{
		var_02 = scripts\mp\_spawnlogic::func_8140("mp_assault_spawn_" + var_01 + "_start");
		var_03 = scripts\mp\_spawnlogic::func_813F(var_02);
	}
	else
	{
		var_04 = level.var_4B29.label;
		var_05 = level.var_23AA[var_01][var_04];
		var_03 = scripts\mp\_spawnlogic::func_813C(var_05);
	}

	return var_03;
}

//Function Number: 8
onspawnplayer()
{
	if(scripts\mp\_utility::func_9E0E(self))
	{
		self.var_9EE6 = 0;
		self.var_9DBC = 0;
		self.var_9D6C = 0;
	}

	if(level.var_BDC1 && self.pers["team"] == game["attackers"])
	{
		self setclientomnvar("ui_carrying_bomb",1);
	}
	else
	{
		self setclientomnvar("ui_carrying_bomb",0);
	}

	scripts\mp\_utility::func_F6FA(0);
	if(isdefined(self.pers["plants"]))
	{
		scripts\mp\_utility::func_F6FA(self.pers["plants"]);
	}

	level notify("spawned_player");
	func_FADA();
	var_00 = getdvarint("scr_allow_highjump");
	self method_8413(var_00);
	self method_8413(var_00);
	self method_8414(var_00);
}

//Function Number: 9
func_C577(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self setclientomnvar("ui_carrying_bomb",0);
	thread func_3DE9();
}

//Function Number: 10
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

//Function Number: 11
func_EFFD(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(!isai(var_03))
		{
			var_03 setclientomnvar("ui_objective_state",0);
		}
	}

	level.var_6C6F = param_00;
	if(param_01 == game["end_reason"]["target_destroyed"] || param_01 == game["end_reason"]["bomb_defused"])
	{
		if(!isdefined(level.var_6C67[param_00]) || level.var_6C67[param_00] != level.var_4B29.var_A63C)
		{
			scripts\mp\_final_killcam::func_66BC();
		}
	}

	thread scripts\mp\_gamelogic::endgame(param_00,param_01);
}

//Function Number: 12
func_C55E(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = scripts\mp\_rank::func_8104("kill");
	var_06 = param_00.team;
	if(param_00.var_9EE6)
	{
		thread scripts\mp\_matchdata::func_AFC5(param_02,"planting");
		param_01 scripts\mp\_utility::func_93DF("defends",1);
		param_01 scripts\mp\_persistence::func_10E56("round","defends",param_01.pers["defends"]);
		return;
	}

	if(param_00.var_9D6C)
	{
		thread scripts\mp\_matchdata::func_AFC5(param_02,"carrying");
		return;
	}

	if(param_00.var_9DBC)
	{
		thread scripts\mp\_matchdata::func_AFC5(param_02,"defusing");
		param_01 scripts\mp\_utility::func_93DF("defends",1);
		param_01 scripts\mp\_persistence::func_10E56("round","defends",param_01.pers["defends"]);
		return;
	}
}

//Function Number: 13
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

//Function Number: 14
func_12E9F()
{
	scripts\mp\gametypes\common::func_12E9F();
	level.var_CC52 = scripts\mp\_utility::dvarfloatvalue("planttime",5,0,20);
	level.var_50AB = scripts\mp\_utility::dvarfloatvalue("defusetime",5,0,20);
	level.var_2C6C = scripts\mp\_utility::dvarfloatvalue("bombtimer",45,1,300);
	level.var_BDC1 = scripts\mp\_utility::dvarintvalue("multibomb",0,0,1);
	level.var_2C5F = scripts\mp\_utility::dvarintvalue("bombResetTimer",60,0,180);
}

//Function Number: 15
func_F855()
{
	if(function_011C() && scripts\mp\_utility::func_7F91("defaultClasses",game["attackers"],5,"class","inUse"))
	{
		level.var_F004[game["attackers"]] = scripts\mp\_utility::func_7F92(game["attackers"],5);
	}
}

//Function Number: 16
func_9EF5(param_00)
{
	if(isdefined(level.var_4B19))
	{
		return self istouching(level.var_4B19.trigger);
	}

	return 0;
}

//Function Number: 17
func_987D()
{
	level.var_6DEE = 1;
	var_00 = getentarray("bombzone","targetname");
	level.var_C2A8 = var_00;
	level.var_4B2A = 0;
	level.var_4B29 = func_FAD4(level.var_4B2A);
}

//Function Number: 18
func_FAD4(param_00)
{
	var_01 = level.var_C2A8[param_00];
	var_02 = var_01.script_noteworthy;
	if(!isdefined(var_02))
	{
		var_02 = "bombzone";
	}

	var_03 = undefined;
	switch(var_02)
	{
		case "bombzone":
			if(isdefined(level.var_6DEE))
			{
				scripts\mp\gametypes\obj_bombzone::func_2C77("sd_bomb");
				level.var_6DEE = undefined;
			}
			else
			{
				scripts\mp\gametypes\obj_bombzone::func_18CF();
			}
	
			var_03 = scripts\mp\gametypes\obj_bombzone::func_2C78(param_00);
			scripts\mp\_utility::func_AAE7("offense_obj",game["attackers"]);
			scripts\mp\_utility::func_AAE7("defense_obj",game["defenders"]);
			break;

		case "dompoint":
			var_03 = scripts\mp\gametypes\obj_dom::func_591D(param_00);
			break;

		case "payload":
			break;

		case "ctf":
			break;
	}

	return var_03;
}

//Function Number: 19
func_C561(param_00,param_01,param_02,param_03,param_04)
{
	switch(param_00)
	{
		case "dompoint":
			func_C4F7(param_01,param_02,param_03,param_04);
			break;

		case "bombzone":
			func_C4CE(param_01,param_02,param_03,param_04);
			break;
	}

	if(param_03 == game["attackers"])
	{
		level.var_4B2A++;
		if(level.var_4B2A < level.var_C2A8.size)
		{
			var_05 = scripts\mp\_utility::getwatcheddvar("addObjectiveTime");
			scripts\mp\_utility::setoverridewatchdvar("timelimit",scripts\mp\_utility::func_81CA() + var_05);
			func_E2B5();
			level.var_4B29 = func_FAD4(level.var_4B2A);
			return;
		}

		function_01AF(0);
		wait(3);
		func_EFFD(game["attackers"],game["end_reason"]["target_destroyed"]);
	}
}

//Function Number: 20
func_C4F7(param_00,param_01,param_02,param_03)
{
	var_04 = param_01.team;
	if(param_03 == "neutral")
	{
		var_05 = scripts\mp\_utility::getotherteam(var_04);
		thread scripts\mp\_utility::printandsoundoneveryone(var_04,var_05,undefined,undefined,"mp_dom_flag_captured",undefined,param_01);
		scripts\mp\_utility::func_10E60("secured" + self.label,var_04,1);
		scripts\mp\_utility::func_10E60("enemy_has" + self.label,var_05,1);
	}
}

//Function Number: 21
func_C4CE(param_00,param_01,param_02,param_03)
{
	if(param_02 == game["defenders"])
	{
		func_E2B5();
		thread scripts\mp\gametypes\obj_bombzone::func_E294();
		level.var_4B29 = scripts\mp\gametypes\obj_bombzone::func_2C78(level.var_4B2A);
	}
}

//Function Number: 22
func_E2B5()
{
	scripts\mp\_gamelogic::func_E2FF();
	level.var_11909 = gettime() - level.var_1190A;
	level.var_118FA = 0;
}

//Function Number: 23
func_FADA()
{
	if(isai(self))
	{
		return;
	}

	self notifyonplayercommand("playerPing","+breath_sprint");
	thread func_136D5();
}

//Function Number: 24
func_136D5()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("playerPing");
		if(scripts\mp\_utility::func_9F19(self) && !scripts\mp\_utility::func_9FC6())
		{
			if(self adsbuttonpressed())
			{
				func_5A5F();
				wait(0.5);
			}
		}

		wait(0.1);
	}
}

//Function Number: 25
func_5A5F()
{
	self endon("disconnect");
	level endon("game_ended");
	var_00 = self geteye();
	var_01 = var_00 + anglestoforward(self getplayerangles()) * 2000;
	var_02 = bullettrace(var_00,var_01,1,self);
	var_03 = var_02["entity"];
	var_04 = "WAYPOINT";
	var_05 = (1,1,1);
	if(isdefined(var_03))
	{
		if(isdefined(var_03.team) && var_03.team != self.team)
		{
			var_05 = (1,0,0);
			if(isplayer(var_03))
			{
				var_04 = "KILL";
				self notify("enemy_sighted");
			}
			else
			{
				var_04 = "DESTROY";
			}
		}
		else if(isdefined(var_03.var_EDBF))
		{
			if(var_03.var_EDBF == "bombzone")
			{
				if(self.team == game["attackers"])
				{
					var_04 = "ATTACK";
					var_05 = (1,1,0);
				}
				else
				{
					var_04 = "DEFEND";
					var_05 = (0,0,1);
				}
			}
			else if(var_03.var_EDBF == "sd")
			{
				if(self.team == game["attackers"])
				{
					var_04 = "OBJECTIVE";
					var_05 = (1,1,0);
				}
			}
		}
	}
}