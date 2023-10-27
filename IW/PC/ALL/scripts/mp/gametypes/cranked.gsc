/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\cranked.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 950 ms
 * Timestamp: 10/27/2023 12:12:21 AM
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
		scripts\mp\_utility::func_DF0B(level.gametype,100);
		scripts\mp\_utility::func_DF08(level.gametype,1);
		scripts\mp\_utility::func_DF1A(level.gametype,1);
		scripts\mp\_utility::func_DF02(level.gametype,0);
		scripts\mp\_utility::func_DEF4(level.gametype,0);
		level.var_B40A = 0;
		level.var_B410 = 0;
	}

	level.teambased = getdvarint("scr_cranked_teambased",1) == 1;
	level.var_C5A4 = ::func_C5A4;
	level.var_8136 = ::func_8136;
	level.var_C55E = ::func_C55E;
	if(!level.teambased)
	{
		level.var_C579 = ::func_C579;
		setdvar("scr_cranked_scorelimit",getdvarint("scr_cranked_scorelimit_ffa",60));
		function_01CC("ffa");
	}

	if(level.var_B40A || level.var_B410)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	game["dialog"]["gametype"] = "cranked";
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

	game["dialog"]["offense_obj"] = "crnk_hint";
	game["dialog"]["begin_cranked"] = "crnk_cranked";
	game["dialog"]["five_seconds_left"] = "crnk_det";
	game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";
	level thread func_C56E();
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_C57B();
	}
}

//Function Number: 3
func_C57B()
{
	self endon("disconnect");
	self waittill("spawned_player");
}

//Function Number: 4
func_987C()
{
	scripts\mp\_utility::func_F69D();
	setdynamicdvar("scr_cranked_roundswitch",0);
	scripts\mp\_utility::func_DF09("cranked",0,0,9);
	setdynamicdvar("scr_cranked_roundlimit",1);
	scripts\mp\_utility::func_DF08("cranked",1);
	setdynamicdvar("scr_cranked_winlimit",1);
	scripts\mp\_utility::func_DF1A("cranked",1);
	setdynamicdvar("scr_cranked_halftime",0);
	scripts\mp\_utility::func_DEF4("cranked",0);
	setdynamicdvar("scr_cranked_promode",0);
}

//Function Number: 5
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

	var_02 = &"OBJECTIVES_WAR";
	var_03 = &"OBJECTIVES_WAR_SCORE";
	var_04 = &"OBJECTIVES_WAR_HINT";
	if(!level.teambased)
	{
		var_02 = &"OBJECTIVES_DM";
		var_03 = &"OBJECTIVES_DM_SCORE";
		var_04 = &"OBJECTIVES_DM_HINT";
	}

	scripts\mp\_utility::func_F7C1("allies",var_02);
	scripts\mp\_utility::func_F7C1("axis",var_02);
	if(level.splitscreen)
	{
		scripts\mp\_utility::func_F7C0("allies",var_02);
		scripts\mp\_utility::func_F7C0("axis",var_02);
	}
	else
	{
		scripts\mp\_utility::func_F7C0("allies",var_03);
		scripts\mp\_utility::func_F7C0("axis",var_03);
	}

	scripts\mp\_utility::func_F7BE("allies",var_04);
	scripts\mp\_utility::func_F7BE("axis",var_04);
	func_98CE();
	func_47ED();
	var_05[0] = level.gametype;
	scripts\mp\_gameobjects::main(var_05);
}

//Function Number: 6
func_98CE()
{
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	if(level.teambased)
	{
		scripts\mp\_spawnlogic::func_F62D("TDM");
		scripts\mp\_spawnlogic::func_182D("mp_tdm_spawn_allies_start");
		scripts\mp\_spawnlogic::func_182D("mp_tdm_spawn_axis_start");
		scripts\mp\_spawnlogic::func_1829("allies","mp_tdm_spawn");
		scripts\mp\_spawnlogic::func_1829("axis","mp_tdm_spawn");
	}
	else
	{
		scripts\mp\_spawnlogic::func_F62D("FreeForAll");
		scripts\mp\_spawnlogic::func_1829("allies","mp_dm_spawn");
		scripts\mp\_spawnlogic::func_1829("axis","mp_dm_spawn");
	}

	level.var_B32E = scripts\mp\_spawnlogic::func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
}

//Function Number: 7
func_8136()
{
	if(level.teambased)
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
			var_01 = scripts\mp\_spawnlogic::func_81BA(var_00);
			var_02 = scripts\mp\_spawnscoring::func_8136(var_01);
		}
	}
	else
	{
		var_01 = scripts\mp\_spawnlogic::func_81BA(self.team);
		if(level.ingraceperiod)
		{
			var_02 = scripts\mp\_spawnlogic::func_813C(var_02);
		}
		else
		{
			var_02 = scripts\mp\_spawnscoring::func_8136(var_02);
		}
	}

	return var_02;
}

//Function Number: 8
func_C55E(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_00.var_47ED) && param_01 scripts\mp\_utility::func_9DD6(param_00))
	{
		param_01 scripts\mp\_missions::func_D992("ch_cranky");
	}

	param_00 func_40F0();
	var_05 = scripts\mp\_rank::func_8104("score_increment");
	if(isdefined(param_01.var_47ED))
	{
		if(param_01.var_47EE - gettime() <= 1000)
		{
			param_01 scripts\mp\_missions::func_D992("ch_cranked_reset");
		}

		var_05 = var_05 * 2;
		var_06 = "kill_cranked";
		param_01 thread func_C544(var_06);
		param_01.pers["killChains"]++;
		param_01 scripts\mp\_persistence::func_10E56("round","killChains",param_01.pers["killChains"]);
	}
	else if(scripts\mp\_utility::func_9F19(param_01))
	{
		param_01 func_B29F("begin_cranked");
	}

	if(isdefined(param_00.var_2507) && !isdefined(level.var_23E9))
	{
		foreach(var_08 in param_00.var_2507)
		{
			if(!isdefined(scripts\mp\_utility::func_143A(var_08)))
			{
				continue;
			}

			if(var_08 == param_01)
			{
				continue;
			}

			if(param_00 == var_08)
			{
				continue;
			}

			if(!isdefined(var_08.var_47ED))
			{
				continue;
			}

			var_08 thread func_C4C4("assist_cranked");
		}
	}

	if(level.teambased)
	{
		level scripts\mp\_gamescore::func_83B0(param_01.pers["team"],var_05,0);
		return;
	}

	var_0A = 0;
	foreach(var_08 in level.players)
	{
		if(isdefined(var_08.var_278) && var_08.var_278 > var_0A)
		{
			var_0A = var_08.var_278;
		}
	}
}

//Function Number: 9
func_40F0()
{
	self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",0);
	self.var_47ED = undefined;
	self.var_47EE = undefined;
}

//Function Number: 10
func_C5B2()
{
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
		var_00 = "axis";
	}
	else
	{
		var_00 = "allies";
	}

	thread scripts\mp\_gamelogic::endgame(var_00,game["end_reason"]["time_limit_reached"]);
}

//Function Number: 11
func_C579(param_00,param_01)
{
	if(param_00 != "super_kill" && issubstr(param_00,"kill"))
	{
		var_02 = scripts\mp\_rank::func_8104("score_increment");
		if(isdefined(param_01.var_47ED))
		{
			var_02 = var_02 * 2;
		}

		return var_02;
	}

	return 0;
}

//Function Number: 12
func_47ED()
{
	level.var_47EF = 30;
}

//Function Number: 13
func_B29F(param_00)
{
	scripts\mp\_utility::func_AAEC(param_00);
	thread scripts\mp\_rank::func_EC2D(param_00);
	func_F6A6("kill");
	self.var_47ED = 1;
	scripts\mp\_utility::func_8387("specialty_fastreload");
	scripts\mp\_utility::func_8387("specialty_quickdraw");
	scripts\mp\_utility::func_8387("specialty_fastoffhand");
	scripts\mp\_utility::func_8387("specialty_fastsprintrecovery");
	scripts\mp\_utility::func_8387("specialty_marathon");
	scripts\mp\_utility::func_8387("specialty_quickswap");
	scripts\mp\_utility::func_8387("specialty_stalker");
	self.var_BCF6 = 1.2;
	scripts\mp\_weapons::func_12ED5();
}

//Function Number: 14
func_C544(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	while(!isdefined(self.pers))
	{
		wait(0.05);
	}

	thread scripts\mp\_utility::func_83B4(param_00);
	func_F6A6("kill");
}

//Function Number: 15
func_C4C4(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	thread scripts\mp\_rank::func_EC2D(param_00);
	func_F6A6("assist");
}

//Function Number: 16
func_139B4(param_00)
{
	self notify("watchBombTimer");
	self endon("watchBombTimer");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_01 = 5;
	scripts\mp\_hostmigration::func_13708(param_00 - var_01 - 1);
	scripts\mp\_utility::func_AAEC("five_seconds_left");
	scripts\mp\_hostmigration::func_13708(1);
	self setclientomnvar("ui_cranked_bomb_timer_final_seconds",1);
	while(var_01 > 0)
	{
		self playsoundtoplayer("mp_cranked_countdown",self);
		scripts\mp\_hostmigration::func_13708(1);
		var_01--;
	}

	if(isdefined(self) && scripts\mp\_utility::func_9F19(self))
	{
		self playsound("frag_grenade_explode");
		playfx(level.var_B761,self.origin + (0,0,32));
		scripts\mp\_utility::func_1417();
		self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",0);
	}
}

//Function Number: 17
func_F6A6(param_00)
{
	var_01 = level.var_47EF;
	if(param_00 == "assist")
	{
		var_01 = int(min(self.var_47EE - gettime() / 1000 + level.var_47EF * 0.5,level.var_47EF));
	}

	var_02 = var_01 * 1000 + gettime();
	self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",var_02);
	self.var_47EE = var_02;
	thread func_139E2();
	thread func_139B4(var_01);
	thread func_13A15();
}

//Function Number: 18
func_139E2()
{
	self notify("watchCrankedHostMigration");
	self endon("watchCrankedHostMigration");
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	level waittill("host_migration_begin");
	self setclientomnvar("ui_cranked_timer_stopped",1);
	var_00 = scripts\mp\_hostmigration::func_13834();
	self setclientomnvar("ui_cranked_timer_stopped",0);
	if(self.var_47EE + var_00 < 5)
	{
		self setclientomnvar("ui_cranked_bomb_timer_final_seconds",1);
	}

	if(var_00 > 0)
	{
		self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",self.var_47EE + var_00);
		return;
	}

	self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",self.var_47EE);
}

//Function Number: 19
func_13A15()
{
	self notify("watchEndGame");
	self endon("watchEndGame");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		if(game["state"] == "postgame" || level.var_7669)
		{
			self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",0);
			break;
		}

		wait(0.1);
	}
}