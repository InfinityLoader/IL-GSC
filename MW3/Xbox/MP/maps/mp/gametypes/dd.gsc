/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\dd.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 33
 * Decompile Time: 484 ms
 * Timestamp: 10/27/2023 2:26:07 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvar("mapname") == "mp_background")
	{
		return;
	}

	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::setupcallbacks();
	maps\mp\gametypes\_globallogic::setupcallbacks();
	if(isusingmatchrulesdata())
	{
		level.initializematchrules = ::initializematchrules;
		[[ level.initializematchrules ]]();
		level thread maps\mp\_utility::func_810A();
	}
	else
	{
		maps\mp\_utility::func_330E(level.gametype,1,0,9);
		maps\mp\_utility::func_3315(level.gametype,3);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,0);
		maps\mp\_utility::func_3312(level.gametype,3);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,2);
		maps\mp\_utility::func_3317(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	maps\mp\_utility::func_3318(3);
	level.objectivebased = 1;
	level.teambased = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	level.ondeadevent = ::ondeadevent;
	level.ontimelimit = ::ontimelimit;
	level.onnormaldeath = ::onnormaldeath;
	level.initgametypeawards = ::initgametypeawards;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::func_2D57;
	}

	level.dd = 1;
	level.bombsplanted = 0;
	level.ddbombmodel = [] setbombtimerdvar();
	makedvarserverinfo("ui_bombtimer_a",-1);
	makedvarserverinfo("ui_bombtimer_b",-1);
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
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_334C();
	var_00 = getmatchrulesdata("demData","roundSwitch");
	setdynamicdvar("scr_dd_roundswitch",var_00);
	maps\mp\_utility::func_330E("dd",var_00,0,9);
	setdynamicdvar("scr_dd_bombtimer",getmatchrulesdata("demData","bombTimer"));
	setdynamicdvar("scr_dd_planttime",getmatchrulesdata("demData","plantTime"));
	setdynamicdvar("scr_dd_defusetime",getmatchrulesdata("demData","defuseTime"));
	setdynamicdvar("scr_dd_addtime",getmatchrulesdata("demData","extraTime"));
	setdynamicdvar("scr_dd_roundlimit",3);
	maps\mp\_utility::func_3312("dd",3);
	setdynamicdvar("scr_dd_winlimit",2);
	maps\mp\_utility::registerwinlimitdvar("dd",2);
	setdynamicdvar("scr_dd_halftime",0);
	maps\mp\_utility::registerhalftimedvar("dd",0);
	setdynamicdvar("scr_dd_promode",0);
}

//Function Number: 3
onprecachegametype()
{
	game["bomb_dropped_sound"] = "mp_war_objective_lost";
	game["bomb_recovered_sound"] = "mp_war_objective_taken";
	precacheshader("waypoint_bomb");
	precacheshader("hud_suitcase_bomb");
	precacheshader("waypoint_target");
	precacheshader("waypoint_target_a");
	precacheshader("waypoint_target_b");
	precacheshader("waypoint_defend");
	precacheshader("waypoint_defend_a");
	precacheshader("waypoint_defend_b");
	precacheshader("waypoint_defuse_a");
	precacheshader("waypoint_defuse_b");
	precacheshader("waypoint_target");
	precacheshader("waypoint_target_a");
	precacheshader("waypoint_target_b");
	precacheshader("waypoint_defend");
	precacheshader("waypoint_defend_a");
	precacheshader("waypoint_defend_b");
	precacheshader("waypoint_defuse");
	precacheshader("waypoint_defuse_a");
	precacheshader("waypoint_defuse_b");
	precachestring(&"MP_EXPLOSIVES_RECOVERED_BY");
	precachestring(&"MP_EXPLOSIVES_DROPPED_BY");
	precachestring(&"MP_EXPLOSIVES_PLANTED_BY");
	precachestring(&"MP_EXPLOSIVES_DEFUSED_BY");
	precachestring(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
	precachestring(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	precachestring(&"MP_CANT_PLANT_WITHOUT_BOMB");
	precachestring(&"MP_PLANTING_EXPLOSIVE");
	precachestring(&"MP_DEFUSING_EXPLOSIVE");
	precachestring(&"MP_BOMB_A_TIMER");
	precachestring(&"MP_BOMB_B_TIMER");
	precachestring(&"MP_BOMBSITE_IN_USE");
}

//Function Number: 4
onstartgametype()
{
	if(game["roundsPlayed"] == 2)
	{
		game["status"] = "overtime";
		setdvar("ui_overtime",1);
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

	level.usestartspawns = 1;
	setclientnamemode("manual_change");
	game["strings"]["target_destroyed"] = &"MP_TARGET_DESTROYED";
	game["strings"]["bomb_defused"] = &"MP_BOMB_DEFUSED";
	if(maps\mp\_utility::inovertime())
	{
		game["dialog"]["defense_obj"] = "obj_destroy";
	}

	precachestring(game["strings"]["target_destroyed"]);
	precachestring(game["strings"]["bomb_defused"]);
	level._effect["bombexplosion"] = loadfx("explosions/tanker_explosion");
	maps\mp\_utility::func_3305(game["attackers"],&"OBJECTIVES_DD_ATTACKER");
	maps\mp\_utility::func_3305(game["defenders"],&"OBJECTIVES_DD_DEFENDER");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_3306(game["attackers"],&"OBJECTIVES_DD_ATTACKER");
		maps\mp\_utility::func_3306(game["defenders"],&"OBJECTIVES_DD_DEFENDER");
	}
	else
	{
		maps\mp\_utility::func_3306(game["attackers"],&"OBJECTIVES_DD_ATTACKER_SCORE");
		maps\mp\_utility::func_3306(game["defenders"],&"OBJECTIVES_DD_DEFENDER_SCORE");
	}

	if(maps\mp\_utility::inovertime())
	{
		maps\mp\_utility::setobjectivehinttext(game["attackers"],&"OBJECTIVES_DD_OVERTIME_HINT");
		maps\mp\_utility::setobjectivehinttext(game["defenders"],&"OBJECTIVES_DD_OVERTIME_HINT");
	}
	else
	{
		maps\mp\_utility::setobjectivehinttext(game["attackers"],&"OBJECTIVES_DD_ATTACKER_HINT");
		maps\mp\_utility::setobjectivehinttext(game["defenders"],&"OBJECTIVES_DD_DEFENDER_HINT");
	}

	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::func_2FD0(game["defenders"],"mp_dd_spawn_defender");
	maps\mp\gametypes\_spawnlogic::func_2FD0(game["defenders"],"mp_dd_spawn_defender_a",1);
	maps\mp\gametypes\_spawnlogic::func_2FD0(game["defenders"],"mp_dd_spawn_defender_b",1);
	maps\mp\gametypes\_spawnlogic::func_2FD0(game["attackers"],"mp_tdm_spawn");
	level.favorclosespawnscalardefender = 2;
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_dd_spawn_defender_start");
	maps\mp\gametypes\_spawnlogic::func_2FD0(game["attackers"],"mp_dd_spawn_attacker");
	maps\mp\gametypes\_spawnlogic::func_2FD0(game["attackers"],"mp_dd_spawn_attacker_a",1);
	maps\mp\gametypes\_spawnlogic::func_2FD0(game["attackers"],"mp_dd_spawn_attacker_b",1);
	maps\mp\gametypes\_spawnlogic::func_2FD0(game["attackers"],"mp_tdm_spawn");
	level.favorclosespawnscalarattacker = 2;
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_dd_spawn_attacker_start");
	level.tdmspawns = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_tdm_spawn");
	level.spawn_defenders = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn_defender");
	level.defenderdefaultentorigin = level.spawn_defenders[0];
	level.spawn_defenders = common_scripts\utility::array_combine(level.spawn_defenders,level.tdmspawns);
	level.spawn_defenders_a = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn_defender_a");
	if(isdefined(level.spawn_defenders_a[0]))
	{
		level.defenderaentorigin = level.spawn_defenders_a[0];
	}

	level.spawn_defenders_a = common_scripts\utility::array_combine(level.spawn_defenders,level.spawn_defenders_a);
	level.spawn_defenders_b = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn_defender_b");
	if(isdefined(level.spawn_defenders_b[0]))
	{
		level.defenderbentorigin = level.spawn_defenders_b[0];
	}

	level.spawn_defenders_b = common_scripts\utility::array_combine(level.spawn_defenders,level.spawn_defenders_b);
	level.spawn_attackers = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn_attacker");
	level.attackerdefaultentorigin = level.spawn_attackers[0];
	level.spawn_attackers = common_scripts\utility::array_combine(level.spawn_defenders,level.tdmspawns);
	level.spawn_attackers_a = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn_attacker_a");
	if(isdefined(level.spawn_attackers_a[0]))
	{
		level.attackeraentorigin = level.spawn_attackers_a[0];
	}

	level.spawn_attackers_a = common_scripts\utility::array_combine(level.spawn_attackers,level.spawn_attackers_a);
	level.spawn_attackers_b = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn_attacker_b");
	if(isdefined(level.spawn_attackers_b[0]))
	{
		level.attackerbentorigin = level.spawn_attackers_b[0];
	}

	level.spawn_attackers_b = common_scripts\utility::array_combine(level.spawn_attackers,level.spawn_attackers_b);
	level.spawn_defenders_start = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn_defender_start");
	level.spawn_attackers_start = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn_attacker_start");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::func_2FCD(level.spawnmins,level.spawnmaxs);
	level.aplanted = 0;
	level.bplanted = 0;
	setmapcenter(level.mapcenter);
	maps\mp\gametypes\_rank::registerscoreinfo("win",2);
	maps\mp\gametypes\_rank::registerscoreinfo("loss",1);
	maps\mp\gametypes\_rank::registerscoreinfo("tie",1.5);
	maps\mp\gametypes\_rank::registerscoreinfo("kill",50);
	maps\mp\gametypes\_rank::registerscoreinfo("headshot",50);
	maps\mp\gametypes\_rank::registerscoreinfo("assist",20);
	maps\mp\gametypes\_rank::registerscoreinfo("plant",100);
	maps\mp\gametypes\_rank::registerscoreinfo("defuse",100);
	thread func_2F0E();
	thread func_3593();
	var_02 = maps\mp\_utility::func_18D0("winlimit");
	var_03[0] = "dd";
	maps\mp\gametypes\_gameobjects::main(var_41);
	thread func_348C();
}

//Function Number: 5
func_3593()
{
	level endon("game_end");
	for(;;)
	{
		if(level.ingraceperiod == 0)
		{
			break;
		}

		wait 0.05;
	}

	level.usestartspawns = 0;
}

//Function Number: 6
getspawnpoint()
{
	var_00 = self.pers["team"];
	if(level.usestartspawns)
	{
		if(var_00 == game["attackers"])
		{
			var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(level.spawn_attackers_start);
		}
		else
		{
			var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(level.spawn_defenders_start);
		}
	}
	else
	{
		var_02 = level.tdmspawns;
		if(var_00 == game["attackers"])
		{
			if(maps\mp\_utility::inovertime())
			{
				var_02 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_00);
			}
			else if(!level.aplanted && !level.bplanted)
			{
				level.favorclosespawnentattacker = level.attackerdefaultentorigin;
			}
			else if(level.aplanted && !level.bplanted)
			{
				if(isdefined(level.attackeraentorigin))
				{
					level.favorclosespawnentattacker = level.attackeraentorigin;
				}
				else
				{
					level.favorclosespawnentattacker = level.attackerdefaultentorigin;
				}
			}
			else if(level.bplanted && !level.aplanted)
			{
				if(isdefined(level.attackerbentorigin))
				{
					level.favorclosespawnentattacker = level.attackerbentorigin;
				}
				else
				{
					level.favorclosespawnentattacker = level.attackerdefaultentorigin;
				}
			}
			else if(isdefined(level.attackeraentorigin))
			{
				level.favorclosespawnentattacker = level.attackeraentorigin;
			}
			else if(isdefined(level.attackerbentorigin))
			{
				level.favorclosespawnentattacker = level.attackerbentorigin;
			}
			else
			{
				level.favorclosespawnentattacker = level.attackerdefaultentorigin;
			}

			var_01 = maps\mp\gametypes\_spawnlogic::func_2FE6(var_02);
		}
		else
		{
			if(maps\mp\_utility::inovertime())
			{
				var_02 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_00);
			}
			else if(!level.aplanted && !level.bplanted)
			{
				level.favorclosespawnentdefender = level.defenderdefaultentorigin;
			}
			else if(level.aplanted && !level.bplanted)
			{
				if(isdefined(level.defenderaentorigin))
				{
					level.favorclosespawnentdefender = level.defenderaentorigin;
				}
				else
				{
					level.favorclosespawnentdefender = level.defenderdefaultentorigin;
				}
			}
			else if(level.bplanted && !level.aplanted)
			{
				if(isdefined(level.defenderbentorigin))
				{
					level.favorclosespawnentdefender = level.defenderbentorigin;
				}
				else
				{
					level.favorclosespawnentdefender = level.defenderdefaultentorigin;
				}
			}
			else if(isdefined(level.defenderaentorigin))
			{
				level.favorclosespawnentdefender = level.defenderaentorigin;
			}
			else if(isdefined(level.defenderbentorigin))
			{
				level.favorclosespawnentdefender = level.defenderbentorigin;
			}
			else
			{
				level.favorclosespawnentdefender = level.defenderdefaultentorigin;
			}

			var_01 = maps\mp\gametypes\_spawnlogic::func_2FE6(var_02);
		}
	}

	return var_01;
}

//Function Number: 7
onspawnplayer()
{
	if(maps\mp\_utility::inovertime() || self.pers["team"] == game["attackers"])
	{
		self.isplanting = 0;
		self.isdefusing = 0;
		self.isbombcarrier = 1;
		if(level.splitscreen)
		{
			self.carryicon = maps\mp\gametypes\_hud_util::createicon("hud_suitcase_bomb",33,33);
			self.carryicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM RIGHT","BOTTOM RIGHT",-50,-78);
			self.carryicon.alpha = 0.75;
		}
		else
		{
			self.carryicon = maps\mp\gametypes\_hud_util::createicon("hud_suitcase_bomb",50,50);
			self.carryicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM RIGHT","BOTTOM RIGHT",-50,-65);
			self.carryicon.alpha = 0.75;
		}

		self.carryicon.hidewheninmenu = 1;
		thread func_80F4();
	}
	else
	{
		self.isplanting = 0;
		self.isdefusing = 0;
		self.isbombcarrier = 0;
		if(isdefined(self.carryicon))
		{
			self.carryicon destroy();
		}
	}

	level notify("spawned_player");
}

//Function Number: 8
func_80F4()
{
	self endon("disconnect");
	level waittill("game_ended");
	if(isdefined(self.carryicon))
	{
		self.carryicon.alpha = 0;
	}
}

//Function Number: 9
func_3594(param_00,param_01)
{
	if(param_00 == "tie")
	{
		level.finalkillcam_winner = "none";
	}
	else
	{
		level.finalkillcam_winner = param_00;
	}

	thread maps\mp\gametypes\_gamelogic::endgame(param_00,param_01);
}

//Function Number: 10
ondeadevent(param_00)
{
	if(level.bombexploded || level.bombdefused)
	{
		return;
	}

	if(param_00 == "all")
	{
		if(level.bombplanted)
		{
			func_3594(game["attackers"],game["strings"][game["defenders"] + "_eliminated"]);
			return;
		}

		func_3594(game["defenders"],game["strings"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(param_00 == game["attackers"])
	{
		if(level.bombplanted)
		{
			return;
		}

		level thread func_3594(game["defenders"],game["strings"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(param_00 == game["defenders"])
	{
		level thread func_3594(game["attackers"],game["strings"][game["defenders"] + "_eliminated"]);
		return;
	}
}

//Function Number: 11
onnormaldeath(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
	var_04 = param_00.team;
	if(game["state"] == "postgame" && param_00.team == game["defenders"] || !level.bombplanted)
	{
		param_01.finalkill = 1;
	}

	if(param_00.isplanting)
	{
		thread maps\mp\_matchdata::func_28B4(param_02,"planting");
		param_01 maps\mp\_utility::func_26FB("defends",1);
		param_01 maps\mp\gametypes\_persistence::func_26D8("round","defends",param_01.pers["defends"]);
		return;
	}

	if(param_00.isdefusing)
	{
		thread maps\mp\_matchdata::func_28B4(param_02,"defusing");
		param_01 maps\mp\_utility::func_26FB("defends",1);
		param_01 maps\mp\gametypes\_persistence::func_26D8("round","defends",param_01.pers["defends"]);
	}
}

//Function Number: 12
ontimelimit()
{
	if(maps\mp\_utility::inovertime())
	{
		func_3594("tie",game["strings"]["time_limit_reached"]);
		return;
	}

	func_3594(game["defenders"],game["strings"]["time_limit_reached"]);
}

//Function Number: 13
func_2F0E()
{
	level.planttime = maps\mp\_utility::dvarfloatvalue("planttime",5,0,20);
	level.defusetime = maps\mp\_utility::dvarfloatvalue("defusetime",5,0,20);
	level.bombtimer = maps\mp\_utility::func_32FD("bombtimer",45,1,300);
	level.ddtimetoadd = maps\mp\_utility::dvarfloatvalue("addtime",2,0,5);
}

//Function Number: 14
func_3595(param_00)
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

//Function Number: 15
func_348C()
{
	level.bombplanted = 0;
	level.bombdefused = 0;
	level.bombexploded = 0;
	level.bombzones = [];
	var_00 = getentarray("dd_bombzone","targetname");
	func_3595(var_00);
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		var_03 = getentarray(var_00[var_01].target,"targetname");
		var_04 = var_00[var_01].script_label;
		var_05 = getent("dd_bombzone_clip" + var_04,"targetname");
		if(maps\mp\_utility::inovertime())
		{
			if(var_04 == "_a" || var_04 == "_b")
			{
				var_02 delete();
				var_03[0] delete();
				var_05 delete();
				continue;
			}

			var_06 = maps\mp\gametypes\_gameobjects::func_29E7("neutral",var_02,var_03,(0,0,64));
			var_06 maps\mp\gametypes\_gameobjects::allowuse("any");
		}
		else
		{
			if(var_04 == "_c")
			{
				var_02 delete();
				var_03[0] delete();
				var_05 delete();
				continue;
			}

			var_06 = maps\mp\gametypes\_gameobjects::func_29E7(game["defenders"],var_02,var_03,(0,0,64));
			var_06 maps\mp\gametypes\_gameobjects::allowuse("enemy");
		}

		var_06 maps\mp\gametypes\_gameobjects::setusetime(level.planttime);
		var_06 maps\mp\gametypes\_gameobjects::setusetext(&"MP_PLANTING_EXPLOSIVE");
		var_06 maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
		var_06 maps\mp\gametypes\_gameobjects::func_29EC(level.ddbomb);
		if(maps\mp\_utility::inovertime())
		{
			var_04 = "_a";
		}

		var_06.label = var_04;
		var_06.index = var_01;
		if(maps\mp\_utility::inovertime())
		{
			var_06 maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_target");
			var_06 maps\mp\gametypes\_gameobjects::func_2A25("friendly","waypoint_target");
			var_06 maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_target");
			var_06 maps\mp\gametypes\_gameobjects::func_2A25("enemy","waypoint_target");
		}
		else
		{
			var_06 maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_defend" + var_04);
			var_06 maps\mp\gametypes\_gameobjects::func_2A25("friendly","waypoint_defend" + var_04);
			var_06 maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_target" + var_04);
			var_06 maps\mp\gametypes\_gameobjects::func_2A25("enemy","waypoint_target" + var_04);
		}

		var_06 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		var_06.onbeginuse = ::onbeginuse;
		var_06.onenduse = ::onenduse;
		var_06.onuse = ::func_3597;
		var_06.oncantuse = ::oncantuse;
		var_06.useweapon = "briefcase_bomb_mp";
		var_06.bombplanted = 0;
		var_06.visuals[0] thread func_3491();
		for(var_07 = 0;var_07 < var_03.size;var_07++)
		{
			if(isdefined(var_03[var_07].script_exploder))
			{
				var_06.exploderindex = var_03[var_07].script_exploder;
				break;
			}
		}

		level.bombzones[level.bombzones.size] = var_06;
		var_06.bombdefusetrig = getent(var_03[0].target,"targetname");
		var_06.bombdefusetrig.origin = var_06.bombdefusetrig.origin + (0,0,-10000);
		var_06.bombdefusetrig.label = var_04;
	}

	for(var_01 = 0;var_01 < level.bombzones.size;var_01++)
	{
		var_08 = [];
		for(var_09 = 0;var_09 < level.bombzones.size;var_09++)
		{
			if(var_09 != var_01)
			{
				var_08[var_08.size] = level.bombzones[var_09];
			}
		}

		level.bombzones[var_01].otherbombzones = var_08;
	}
}

//Function Number: 16
func_3491()
{
	var_00 = spawn("script_origin",self.origin);
	var_00.angles = self.angles;
	var_00 rotateyaw(-45,0.05);
	wait 0.05;
	var_01 = self.origin + (0,0,5);
	var_02 = self.origin + anglestoforward(var_00.angles) * 100 + (0,0,128);
	var_03 = bullettrace(var_01,var_02,0,self);
	self.killcament = spawn("script_model",var_03["position"]);
	self.killcament setscriptmoverkillcam("explosive");
	var_00 delete();
}

//Function Number: 17
func_3597(param_00)
{
	var_01 = param_00.pers["team"];
	var_02 = level.otherteam[var_01];
	if((maps\mp\_utility::inovertime() && self.bombplanted == 0) || !maps\mp\_utility::inovertime() && !maps\mp\gametypes\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		self.bombplanted = 1;
		param_00 notify("bomb_planted");
		param_00 playsound("mp_bomb_plant");
		thread maps\mp\_utility::teamplayercardsplash("callout_bombplanted",param_00);
		param_00 notify("objective","plant");
		maps\mp\_utility::func_26E5("bomb_planted");
		param_00 thread maps\mp\gametypes\_hud_message::func_2892("plant",maps\mp\gametypes\_rank::getscoreinfovalue("plant"));
		param_00 thread maps\mp\gametypes\_rank::func_2AB3("plant");
		maps\mp\gametypes\_gamescore::func_26D3("plant",param_00);
		param_00 maps\mp\_utility::incplayerstat("bombsplanted",1);
		param_00 thread maps\mp\_matchdata::loggameevent("plant",param_00.origin);
		param_00.bombplantedtime = gettime();
		param_00 maps\mp\_utility::func_26FB("plants",1);
		param_00 maps\mp\gametypes\_persistence::func_26D8("round","plants",param_00.pers["plants"]);
		level thread bombplanted(self,param_00);
		level.bombowner = param_00;
		self.useweapon = "briefcase_bomb_defuse_mp";
		return;
	}

	self.bombplanted = 0;
	thread bombhandler(param_00,"defused");
	param_00 notify("objective","defuse");
}

//Function Number: 18
resetbombzone()
{
	if(maps\mp\_utility::inovertime())
	{
		maps\mp\gametypes\_gameobjects::setownerteam("neutral");
		maps\mp\gametypes\_gameobjects::allowuse("any");
		var_00 = "waypoint_target";
		var_01 = "waypoint_target";
	}
	else
	{
		maps\mp\gametypes\_gameobjects::allowuse("enemy");
		var_00 = "waypoint_defend" + self.label;
		var_01 = "waypoint_target" + self.label;
	}

	maps\mp\gametypes\_gameobjects::setusetime(level.planttime);
	maps\mp\gametypes\_gameobjects::setusetext(&"MP_PLANTING_EXPLOSIVE");
	maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
	maps\mp\gametypes\_gameobjects::func_29EC(level.ddbomb);
	maps\mp\gametypes\_gameobjects::set2dicon("friendly",var_00);
	maps\mp\gametypes\_gameobjects::func_2A25("friendly",var_00);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy",var_01);
	maps\mp\gametypes\_gameobjects::func_2A25("enemy",var_01);
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	self.useweapon = "briefcase_bomb_mp";
}

//Function Number: 19
func_34B2()
{
	if(maps\mp\_utility::inovertime())
	{
		var_00 = "waypoint_defuse";
		var_01 = "waypoint_defend";
	}
	else
	{
		var_00 = "waypoint_defuse" + self.label;
		var_01 = "waypoint_defend" + self.label;
	}

	maps\mp\gametypes\_gameobjects::allowuse("friendly");
	maps\mp\gametypes\_gameobjects::setusetime(level.defusetime);
	maps\mp\gametypes\_gameobjects::setusetext(&"MP_DEFUSING_EXPLOSIVE");
	maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	maps\mp\gametypes\_gameobjects::func_29EC(undefined);
	maps\mp\gametypes\_gameobjects::set2dicon("friendly",var_00);
	maps\mp\gametypes\_gameobjects::func_2A25("friendly",var_00);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy",var_01);
	maps\mp\gametypes\_gameobjects::func_2A25("enemy",var_01);
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
}

//Function Number: 20
onbeginuse(param_00)
{
	if((maps\mp\_utility::inovertime() && self.bombplanted == 1) || !maps\mp\_utility::inovertime() && maps\mp\gametypes\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		param_00 playsound("mp_bomb_defuse");
		param_00.isdefusing = 1;
		var_01 = 9000000;
		var_02 = undefined;
		if(isdefined(level.ddbombmodel))
		{
			foreach(var_04 in level.ddbombmodel)
			{
				if(!isdefined(var_04))
				{
					continue;
				}

				var_05 = distancesquared(param_00.origin,var_04.origin);
				if(var_05 < var_01)
				{
					var_01 = var_05;
					var_02 = var_04;
				}
			}

			param_00.defusing = var_02;
			var_02 hide();
			return;
		}

		return;
	}

	var_04.isplanting = 1;
}

//Function Number: 21
onenduse(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(param_01.isdefusing)
	{
		if(isdefined(param_01.defusing) && !param_02)
		{
			param_01.defusing show();
		}
	}

	if(isalive(param_01))
	{
		param_01.isdefusing = 0;
		param_01.isplanting = 0;
	}
}

//Function Number: 22
oncantuse(param_00)
{
	param_00 iprintlnbold(&"MP_BOMBSITE_IN_USE");
}

//Function Number: 23
onreset()
{
}

//Function Number: 24
bombplanted(param_00,param_01)
{
	param_00 endon("defused");
	var_02 = param_01.team;
	level.bombsplanted = level.bombsplanted + 1;
	setbombtimerdvar();
	maps\mp\gametypes\_gamelogic::pausetimer();
	level.timepausestart = gettime();
	level.timelimitoverride = 1;
	level.bombplanted = 1;
	level.destroyedobject = param_00;
	if(level.destroyedobject.label == "_a")
	{
		level.aplanted = 1;
	}
	else
	{
		level.bplanted = 1;
	}

	level.destroyedobject.bombplanted = 1;
	param_00.visuals[0] thread func_359D(param_00);
	level.tickingobject = param_00.visuals[0];
	func_35A0(param_01,param_00.label);
	param_00.bombdefused = 0;
	param_00 maps\mp\gametypes\_gameobjects::allowuse("none");
	param_00 maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	if(maps\mp\_utility::inovertime())
	{
		param_00 maps\mp\gametypes\_gameobjects::setownerteam(level.otherteam[param_01.team]);
	}

	param_00 func_34B2();
	param_00 func_349A(param_00);
	param_00 thread bombhandler(param_01,"explode",var_02);
}

//Function Number: 25
bombhandler(param_00,param_01,param_02)
{
	self.visuals[0] notify("stopTicking");
	level.bombsplanted = level.bombsplanted - 1;
	if(self.label == "_a")
	{
		level.aplanted = 0;
	}
	else
	{
		level.bplanted = 0;
	}

	restarttimer();
	setbombtimerdvar();
	setdvar("ui_bombtimer" + self.label,-1);
	if(level.gameended)
	{
		return;
	}

	if(param_01 == "explode")
	{
		level notify("bomb_exploded" + self.label);
		level.bombexploded = level.bombexploded + 1;
		var_03 = self.curorigin;
		level.ddbombmodel[self.label] delete();
		if(isdefined(param_00))
		{
			self.visuals[0] radiusdamage(var_03,512,200,20,param_00,"MOD_EXPLOSIVE","bomb_site_mp");
			param_00 maps\mp\_utility::incplayerstat("targetsdestroyed",1);
			param_00 maps\mp\_utility::func_26FB("destructions",1);
			param_00 maps\mp\gametypes\_persistence::func_26D8("round","destructions",param_00.pers["destructions"]);
		}
		else
		{
			self.visuals[0] radiusdamage(var_03,512,200,20,undefined,"MOD_EXPLOSIVE","bomb_site_mp");
		}

		var_04 = randomfloat(360);
		var_05 = spawnfx(level._effect["bombexplosion"],var_03 + (0,0,50),(0,0,1),(cos(var_04),sin(var_04),0));
		triggerfx(var_05);
		playrumbleonposition("grenade_rumble",var_03);
		earthquake(0.75,2,var_03,2000);
		thread maps\mp\_utility::func_2ED2("exp_suitcase_bomb_main",var_03);
		if(isdefined(self.exploderindex))
		{
			common_scripts\utility::exploder(self.exploderindex);
		}

		maps\mp\gametypes\_gameobjects::disableobject();
		if(!maps\mp\_utility::inovertime() && level.bombexploded < 2 && level.ddtimetoadd > 0)
		{
			foreach(var_07 in level.players)
			{
				var_07 thread maps\mp\gametypes\_hud_message::func_2892("time_added");
			}
		}

		wait 2;
		if(maps\mp\_utility::inovertime() || level.bombexploded > 1)
		{
			func_3594(param_02,game["strings"]["target_destroyed"]);
			return;
		}

		if(level.ddtimetoadd > 0)
		{
			level thread maps\mp\_utility::teamplayercardsplash("callout_time_added",param_00);
			return;
		}

		return;
	}

	param_00 notify("bomb_defused");
	self notify("defused");
	maps\mp\_utility::func_26E5("bomb_defused");
	level thread maps\mp\_utility::teamplayercardsplash("callout_bombdefused",param_00);
	level thread bombdefused(self);
	resetbombzone();
	if(isdefined(level.bombowner) && level.bombowner.bombplantedtime + 4000 + level.defusetime * 1000 > gettime() && maps\mp\_utility::isreallyalive(level.bombowner))
	{
		param_00 thread maps\mp\gametypes\_hud_message::func_2892("ninja_defuse",maps\mp\gametypes\_rank::getscoreinfovalue("defuse"));
	}
	else
	{
		param_00 thread maps\mp\gametypes\_hud_message::func_2892("defuse",maps\mp\gametypes\_rank::getscoreinfovalue("defuse"));
	}

	param_00 thread maps\mp\gametypes\_rank::func_2AB3("defuse");
	maps\mp\gametypes\_gamescore::func_26D3("defuse",param_00);
	param_00 maps\mp\_utility::incplayerstat("bombsdefused",1);
	param_00 maps\mp\_utility::func_26FB("defuses",1);
	param_00 maps\mp\gametypes\_persistence::func_26D8("round","defuses",param_00.pers["defuses"]);
	param_00 thread maps\mp\_matchdata::loggameevent("defuse",param_00.origin);
}

//Function Number: 26
func_359D(param_00)
{
	self endon("death");
	self endon("stopTicking");
	level endon("game_ended");
	for(;;)
	{
		self playsound("ui_mp_suitcasebomb_timer");
		if(!isdefined(param_00.waittime) || param_00.waittime > 10)
		{
			wait 1;
		}
		else if(isdefined(param_00.waittime) && param_00.waittime > 5)
		{
			wait 0.5;
		}
		else
		{
			wait 0.25;
		}

		maps\mp\gametypes\_hostmigration::func_273E();
	}
}

//Function Number: 27
setbombtimerdvar()
{
	if(level.bombsplanted == 1)
	{
		setdvar("ui_bomb_timer",2);
		return;
	}

	if(level.bombsplanted == 2)
	{
		setdvar("ui_bomb_timer",3);
		return;
	}

	setdvar("ui_bomb_timer",0);
}

//Function Number: 28
func_35A0(param_00,param_01)
{
	var_02 = bullettrace(param_00.origin + (0,0,20),param_00.origin - (0,0,2000),0,param_00);
	var_03 = randomfloat(360);
	var_04 = (cos(var_03),sin(var_03),0);
	var_04 = vectornormalize(var_04 - var_02["normal"] * vectordot(var_04,var_02["normal"]));
	var_05 = vectortoangles(var_04);
	level.ddbombmodel[param_01] = spawn("script_model",var_02["position"]);
	level.ddbombmodel[param_01].angles = var_05;
	level.ddbombmodel[param_01] setmodel("prop_suitcase_bomb");
}

//Function Number: 29
restarttimer()
{
	if(level.bombsplanted <= 0)
	{
		maps\mp\gametypes\_gamelogic::resumetimer();
		level.timepaused = gettime() - level.timepausestart;
		level.timelimitoverride = 0;
	}
}

//Function Number: 30
func_349A(param_00)
{
	level endon("game_ended");
	level endon("bomb_defused" + param_00.label);
	if(maps\mp\_utility::inovertime())
	{
		param_00.waittime = level.bombtimer;
	}
	else
	{
		param_00.waittime = level.bombtimer;
	}

	level thread func_30FE(param_00);
	while(param_00.waittime >= 0)
	{
		param_00.waittime--;
		if(param_00.waittime >= 0)
		{
			wait 1;
		}

		maps\mp\gametypes\_hostmigration::func_273E();
	}
}

//Function Number: 31
func_30FE(param_00)
{
	level endon("game_ended");
	level endon("disconnect");
	level endon("bomb_defused" + param_00.label);
	level endon("bomb_exploded" + param_00.label);
	var_01 = param_00.waittime * 1000 + gettime();
	setdvar("ui_bombtimer" + param_00.label,var_01);
	level waittill("host_migration_begin");
	var_02 = maps\mp\gametypes\_hostmigration::func_273E();
	if(var_02 > 0)
	{
		setdvar("ui_bombtimer" + param_00.label,var_01 + var_02);
	}
}

//Function Number: 32
bombdefused(param_00)
{
	level.tickingobject maps\mp\gametypes\_gamelogic::func_2F32();
	param_00.bombdefused = 1;
	setbombtimerdvar();
	setdvar("ui_bombtimer" + param_00.label,-1);
	level notify("bomb_defused" + param_00.label);
}

//Function Number: 33
initgametypeawards()
{
	maps\mp\_awards::func_2D85("targetsdestroyed",0,::maps\mp\_awards::func_2DA7);
	maps\mp\_awards::func_2D85("bombsplanted",0,::maps\mp\_awards::func_2DA7);
	maps\mp\_awards::func_2D85("bombsdefused",0,::maps\mp\_awards::func_2DA7);
	maps\mp\_awards::func_2D85("bombcarrierkills",0,::maps\mp\_awards::func_2DA7);
	maps\mp\_awards::func_2D85("bombscarried",0,::maps\mp\_awards::func_2DA7);
	maps\mp\_awards::func_2D85("killsasbombcarrier",0,::maps\mp\_awards::func_2DA7);
}