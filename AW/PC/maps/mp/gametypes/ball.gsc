/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\ball.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 96
 * Decompile Time: 1435 ms
 * Timestamp: 4/22/2024 2:10:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvar("mapname") == "mp_background")
	{
		return;
	}

	maps\mp\gametypes\_globallogic::init();
	lib_0540::setupcallbacks();
	maps\mp\gametypes\_globallogic::setupcallbacks();
	if(isusingmatchrulesdata())
	{
		level.initializematchrules = ::initializematchrules;
		[[ level.initializematchrules ]]();
		level thread maps\mp\_utility::reinitializematchrulesonmigration();
	}
	else
	{
		maps\mp\_utility::registerroundswitchdvar(level.gametype,0,0,9);
		maps\mp\_utility::registertimelimitdvar(level.gametype,10);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,75);
		maps\mp\_utility::registerroundlimitdvar(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::registernumlivesdvar(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,1);
		setdynamicdvar("scr_ball_num_balls",1);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	var_00 = getdvarint("scr_ball_num_balls",1);
	setomnvar("ui_uplink_num_balls",var_00);
	maps\mp\_utility::setovertimelimitdvar(3);
	if(isdefined(game["round_time_to_beat"]))
	{
		maps\mp\_utility::setovertimelimitdvar(game["round_time_to_beat"]);
		game["round_time_to_beat"] = undefined;
	}

	level.teambased = 1;
	level.onhalftime = ::onhalftime;
	level.ontimelimit = ::ontimelimit;
	level.halftimeonscorelimit = 1;
	level.overtimescorewinoverride = 1;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onnormaldeath = ::onnormaldeath;
	level.gamemodeonunderwater = ::onunderwater;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	game["dialog"]["drone_reset"] = "upl_dronereset";
	game["dialog"]["you_own_drone"] = "upl_allyowndrone";
	game["dialog"]["ally_own_drone"] = "upl_friend_holds";
	game["dialog"]["enemy_own_drone"] = "upl_enemyowndrone";
	game["dialog"]["ally_throw_score"] = "upl_uplinksuccess";
	game["dialog"]["ally_carry_score"] = "upl_dronedelievered";
	game["dialog"]["enemy_throw_score"] = "upl_enm_score_remote";
	game["dialog"]["enemy_carry_score"] = "upl_enm_score";
	game["dialog"]["pass_complete"] = "upl_dronetransfered";
	game["dialog"]["pass_intercepted"] = "upl_droneintercepted";
	game["dialog"]["ally_drop_drone"] = "upl_dronedropped";
	game["dialog"]["enemy_drop_drone"] = "upl_dronedropped";
	game["dialog"]["gametype"] = "upl_intro";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	game["dialog"]["offense_obj"] = "upl_deliverdrone";
	game["dialog"]["defense_obj"] = "upl_deliverdrone";
	if(maps\mp\_utility::isgrapplinghookgamemode())
	{
		game["dialog"]["gametype"] = "grap_" + game["dialog"]["gametype"];
	}

	level thread ball_on_connect();
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	setdynamicdvar("scr_ball_roundswitch",0);
	maps\mp\_utility::registerroundswitchdvar("ball",0,0,9);
	setdynamicdvar("scr_ball_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar("ball",1);
	setdynamicdvar("scr_ball_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("ball",1);
	setdynamicdvar("scr_ball_halftime",1);
	maps\mp\_utility::registerhalftimedvar("ball",1);
	var_00 = getmatchrulesdata("ballData","numBalls");
	var_00 = max(1,var_00);
	setdynamicdvar("scr_ball_num_balls",var_00);
	setdynamicdvar("scr_ball_reset_time",getmatchrulesdata("ballData","ballResetTime"));
	setdynamicdvar("scr_ball_points_touchdown",getmatchrulesdata("ballData","carryScore"));
	setdynamicdvar("scr_ball_points_fieldgoal",getmatchrulesdata("ballData","throwScore"));
	setdynamicdvar("scr_ball_armor",getmatchrulesdata("ballData","armorValue"));
}

//Function Number: 3
onstartgametype()
{
	setclientnamemode("auto_change");
	if(game["status"] == "halftime")
	{
		setomnvar("ui_current_round",2);
	}
	else if(game["status"] == "overtime")
	{
		setomnvar("ui_current_round",3);
	}
	else if(game["status"] == "overtime_halftime")
	{
		setomnvar("ui_current_round",4);
	}

	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(maps\mp\_utility::isovertimetext(game["status"]))
	{
		game["switchedsides"] = !game["switchedsides"];
	}

	if(game["switchedsides"])
	{
		var_00 = game["attackers"];
		var_01 = game["defenders"];
		game["attackers"] = var_01;
		game["defenders"] = var_00;
	}

	if(game["status"] == "overtime")
	{
		game["teamScores"]["allies"] = 0;
		setteamscore("allies",0);
		game["teamScores"]["axis"] = 0;
		setteamscore("axis",0);
	}

	maps\mp\_utility::setobjectivetext("allies",&"OBJECTIVES_BALL");
	maps\mp\_utility::setobjectivetext("axis",&"OBJECTIVES_BALL");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_BALL");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_BALL");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_BALL_SCORE");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_BALL_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_BALL_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_BALL_HINT");
	ball_default_origins();
	var_02[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::main(var_02);
	level thread run_ball();
	initspawns();
}

//Function Number: 4
onhalftime(param_00)
{
	foreach(var_02 in level.balls)
	{
		var_02.visuals[0] physicsstop();
	}

	maps\mp\gametypes\_gamelogic::default_onhalftime(param_00);
}

//Function Number: 5
ontimelimit()
{
	var_00 = undefined;
	level.finalkillcam_winner = "none";
	foreach(var_02 in level.balls)
	{
		var_02.visuals[0] physicsstop();
	}

	if(game["status"] == "halftime" || game["status"] == "overtime_halftime")
	{
		if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
		{
			level.finalkillcam_winner = "axis";
			var_00 = "axis";
		}
		else if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
		{
			level.finalkillcam_winner = "allies";
			var_00 = "allies";
		}
		else if(game["status"] == "halftime")
		{
			var_00 = "overtime";
		}
		else if(isdefined(game["ball_overtime_team"]))
		{
			var_00 = game["ball_overtime_team"];
		}
		else
		{
			var_00 = "tie";
		}
	}
	else if(game["status"] == "overtime")
	{
		var_00 = "overtime_halftime";
	}

	logstring("time limit, win: " + var_00 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	level thread maps\mp\gametypes\_gamelogic::endgame(var_00,game["end_reason"]["time_limit_reached"]);
}

//Function Number: 6
initspawns()
{
	if(level.script == "mp_refraction")
	{
		setdvar("scr_disableClientSpawnTraces","1");
	}

	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	level.allies_start_spawn_name = "mp_ball_spawn_allies_start";
	level.axis_start_spawn_name = "mp_ball_spawn_axis_start";
	if(!getspawnarray(level.allies_start_spawn_name).size)
	{
		level.allies_start_spawn_name = "mp_dom_spawn_allies_start";
		level.axis_start_spawn_name = "mp_dom_spawn_axis_start";
	}

	maps\mp\gametypes\_spawnlogic::addstartspawnpoints(level.allies_start_spawn_name);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints(level.axis_start_spawn_name);
	level.spawn_name = "mp_ball_spawn";
	if(!getspawnarray(level.spawn_name).size)
	{
		level.spawn_name = "mp_dom_spawn";
	}

	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies",level.spawn_name);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis",level.spawn_name);
	var_00 = level.ball_goals[game["attackers"]].origin;
	var_01 = 0;
	var_02 = maps\mp\gametypes\_spawnlogic::getspawnpointarray(level.allies_start_spawn_name);
	foreach(var_04 in var_02)
	{
		var_01 = var_01 + distance(var_04.origin,var_00);
	}

	var_06 = 0;
	var_02 = maps\mp\gametypes\_spawnlogic::getspawnpointarray(level.axis_start_spawn_name);
	foreach(var_04 in var_02)
	{
		var_06 = var_06 + distance(var_04.origin,var_00);
	}

	level.start_spawns_near_attackers = var_01 < var_06;
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 7
getspawnpoint()
{
	var_00 = self.pers["team"];
	if(level.usestartspawns && level.ingraceperiod)
	{
		if(game["switchedsides"])
		{
			var_00 = maps\mp\_utility::getotherteam(var_00);
		}

		if(!level.start_spawns_near_attackers)
		{
			var_00 = maps\mp\_utility::getotherteam(var_00);
		}

		var_01 = level.allies_start_spawn_name;
		if(var_00 == "axis")
		{
			var_01 = level.axis_start_spawn_name;
		}

		var_02 = maps\mp\gametypes\_spawnlogic::getspawnpointarray(var_01);
		var_03 = maps\mp\gametypes\_spawnlogic::getspawnpoint_startspawn(var_02);
	}
	else
	{
		var_02 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_03);
		var_03 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(var_03,var_02);
	}

	maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_03);
	return var_03;
}

//Function Number: 8
onunderwater(param_00)
{
	foreach(var_02 in level.balls)
	{
		if(isdefined(var_02.carrier) && var_02.carrier == self)
		{
			self.water_last_weapon = maps\mp\gametypes\_gameobjects::getcarrierweaponcurrent(var_02);
			var_02 thread maps\mp\gametypes\_gameobjects::setdropped();
			return;
		}
	}

	if(self getcurrentweapon() == "iw5_carrydrone_mp" && isdefined(self.changingweapon))
	{
		self.water_last_weapon = self.changingweapon;
	}
	else if(isdefined(self.pass_or_throw_active) && self.pass_or_throw_active)
	{
		var_04 = self getweaponslistprimaries();
		self.water_last_weapon = common_scripts\utility::ter_op(var_04.size,var_04[0],undefined);
	}

	self.balldropdelay = undefined;
}

//Function Number: 9
onnormaldeath(param_00,param_01,param_02)
{
	if(game["state"] == "postgame" && game["teamScores"][param_01.team] > game["teamScores"][level.otherteam[param_01.team]])
	{
		param_01.finalkill = 1;
	}
}

//Function Number: 10
ball_connect_watch()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread ball_player_on_connect();
		var_00 thread ball_update_extrascore0();
	}
}

//Function Number: 11
ball_player_on_connect()
{
	foreach(var_01 in level.balls)
	{
		var_01 ball_fx_start_player(self);
	}
}

//Function Number: 12
run_ball()
{
	level.ball_starts = [];
	level.balls = [];
	var_00 = getdvarint("scr_ball_num_balls",1);
	ball_create_ball_starts(var_00);
	ball_create_team_goal("allies");
	ball_create_team_goal("axis");
	level._effect["ball_trail"] = loadfx("vfx/trail/vfx_uplink_ball_trl");
	level._effect["ball_idle"] = loadfx("vfx/unique/vfx_uplink_ball_idle");
	level._effect["ball_download"] = loadfx("vfx/trail/vfx_uplink_ball_trl2");
	level._effect["ball_download_end"] = loadfx("vfx/unique/vfx_uplink_ball_impact");
	level._effect["ball_goal_enemy"] = loadfx("vfx/unique/vfx_uplink_goal");
	level._effect["ball_goal_friendly"] = loadfx("vfx/unique/vfx_uplink_goal_friendly");
	level._effect["ball_goal_activated_enemy"] = loadfx("vfx/unique/vfx_uplink_ball_score");
	level._effect["ball_goal_activated_friendly"] = loadfx("vfx/unique/vfx_uplink_ball_score_friendly");
	level._effect["ball_teleport"] = loadfx("vfx/unique/vfx_uplink_ball_glow");
	level._effect["ball_physics_impact"] = loadfx("vfx/treadfx/footstep_dust");
	level thread ball_connect_watch();
	ball_init_map_min_max();
	for(var_01 = 0;var_01 < var_00 && var_01 < level.ball_starts.size;var_01++)
	{
		ball_spawn(var_01);
	}

	ball_goal_useobject();
	ball_goal_fx();
	maps\mp\_utility::gameflagwait("prematch_done");
	ball_assign_team_spawns();
}

//Function Number: 13
ball_default_origins()
{
	level.default_goal_origins = [];
	var_00 = getentarray("flag_primary","targetname");
	foreach(var_02 in var_00)
	{
		switch(var_02.script_label)
		{
			case "_a":
				level.default_goal_origins[game["attackers"]] = var_02.origin;
				break;

			case "_b":
				level.default_ball_origin = var_02.origin;
				break;

			case "_c":
				level.default_goal_origins[game["defenders"]] = var_02.origin;
				break;
		}
	}
}

//Function Number: 14
ball_init_map_min_max()
{
	level.ball_mins = (1000,1000,1000);
	level.ball_maxs = (-1000,-1000,-1000);
	var_00 = getallnodes();
	if(var_00.size > 0)
	{
		foreach(var_02 in var_00)
		{
			level.ball_mins = maps\mp\gametypes\_spawnlogic::expandmins(level.ball_mins,var_02.origin);
			level.ball_maxs = maps\mp\gametypes\_spawnlogic::expandmaxs(level.ball_maxs,var_02.origin);
		}

		return;
	}

	level.ball_mins = level.spawnmins;
	level.ball_maxs = level.spawnmaxs;
}

//Function Number: 15
ball_goal_useobject()
{
	foreach(var_02, var_01 in level.ball_goals)
	{
		var_01.trigger = spawn("trigger_radius",var_01.origin - (0,0,var_01.radius),0,var_01.radius,var_01.radius * 2);
		var_01.useobject = maps\mp\gametypes\_gameobjects::createuseobject(var_02,var_01.trigger,[],(0,0,var_01.radius * 2.1));
		var_01.useobject.goal = var_01;
		var_01.useobject maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_ball_defend");
		var_01.useobject maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_ball_goal");
		var_01.useobject maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_ball_defend");
		var_01.useobject maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_ball_goal");
		if(var_02 == "allies")
		{
			maps\mp\_utility::setmlgicons(var_01.useobject,"waypoint_esports_uplink_blue");
		}
		else
		{
			maps\mp\_utility::setmlgicons(var_01.useobject,"waypoint_esports_uplink_red");
		}

		var_01.useobject maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		var_01.useobject maps\mp\gametypes\_gameobjects::allowuse("enemy");
		var_01.useobject maps\mp\gametypes\_gameobjects::setkeyobject(level.balls);
		var_01.useobject maps\mp\gametypes\_gameobjects::setusetime(0);
		var_01.useobject.onuse = ::ball_carrier_touched_goal;
		var_01.useobject.canuseobject = ::ball_goal_can_use;
		var_01.killcament = spawn("script_model",var_01.origin);
		var_01.killcament setscriptmoverkillcam("large explosive");
	}
}

//Function Number: 16
ball_assign_team_spawns()
{
	var_00 = maps\mp\gametypes\_spawnlogic::getspawnpointarray(level.spawn_name);
	level.teamspawnpoints["axis"] = [];
	level.teamspawnpoints["allies"] = [];
	var_01 = level.ball_goals["allies"].ground_origin;
	var_02 = level.ball_goals["axis"].ground_origin;
	foreach(var_04 in var_00)
	{
		var_04.teambase = undefined;
		var_05 = ball_get_path_dist(var_01,var_04.origin);
		var_06 = ball_get_path_dist(var_02,var_04.origin);
		if(isdefined(var_04.script_noteworthy))
		{
			if((game["switchedsides"] && var_04.script_noteworthy == "axis_override") || !game["switchedsides"] && var_04.script_noteworthy == "allies_override")
			{
				var_04.teambase = "allies";
				var_04.friendlyflag = level.ball_goals["allies"];
				var_04.friendlyflagdist = var_05;
				var_04.enemyflagdist = var_06;
			}
			else if((game["switchedsides"] && var_04.script_noteworthy == "allies_override") || !game["switchedsides"] && var_04.script_noteworthy == "axis_override")
			{
				var_04.teambase = "axis";
				var_04.friendlyflag = level.ball_goals["axis"];
				var_04.friendlyflagdist = var_06;
				var_04.enemyflagdist = var_05;
			}
		}

		if(!isdefined(var_04.teambase))
		{
			var_04.teambase = common_scripts\utility::ter_op(var_05 < var_06,"allies","axis");
			var_04.friendlyflag = common_scripts\utility::ter_op(var_05 < var_06,level.ball_goals["allies"],level.ball_goals["axis"]);
			var_04.friendlyflagdist = common_scripts\utility::ter_op(var_05 < var_06,var_05,var_06);
			var_04.enemyflagdist = common_scripts\utility::ter_op(var_05 > var_06,var_05,var_06);
		}

		var_07 = var_04.friendlyflagdist / var_04.enemyflagdist;
		if(var_04.friendlyflag.highestspawndistratio < var_07)
		{
			var_04.friendlyflag.highestspawndistratio = var_07;
		}

		level.teamspawnpoints[var_04.teambase][level.teamspawnpoints[var_04.teambase].size] = var_04;
	}
}

//Function Number: 17
ball_get_path_dist(param_00,param_01)
{
	if(maps\mp\gametypes\_spawnlogic::ispathdataavailable())
	{
		var_02 = getpathdist(param_00,param_01,999999);
		if(isdefined(var_02) && var_02 >= 0)
		{
			return var_02;
		}
	}

	return distance(param_00,param_01);
}

//Function Number: 18
ball_goal_fx()
{
	foreach(var_01 in level.ball_goals)
	{
		var_01.score_fx["friendly"] = spawnfx(common_scripts\utility::getfx("ball_goal_activated_friendly"),var_01.origin,(1,0,0));
		var_01.score_fx["enemy"] = spawnfx(common_scripts\utility::getfx("ball_goal_activated_enemy"),var_01.origin,(1,0,0));
	}

	level thread ball_play_fx_joined_team();
	foreach(var_04 in level.players)
	{
		ball_goal_fx_for_player(var_04);
	}
}

//Function Number: 19
ball_spawn(param_00)
{
	var_01 = level.ball_starts[param_00];
	var_02 = spawn("script_model",var_01.origin);
	var_02 setmodel("prop_drone_sphere");
	var_02 thread physics_impact_watch();
	var_03 = 24;
	var_04 = getent("ball_pickup_" + param_00 + 1,"targetname");
	if(isdefined(var_04))
	{
		var_04.origin = var_02.origin;
	}
	else
	{
		var_04 = spawn("trigger_radius",var_02.origin - (0,0,var_03 / 2),0,var_03,var_03);
	}

	var_04 enablelinkto();
	var_04 linkto(var_02);
	var_04.no_moving_platfrom_unlink = 1;
	var_05 = [var_02];
	var_06 = maps\mp\gametypes\_gameobjects::createcarryobject("any",var_04,var_05,(0,0,32));
	var_06.objectiveonvisuals = 1;
	var_06 maps\mp\gametypes\_gameobjects::allowcarry("any");
	var_06 ball_waypoint_neutral();
	var_06 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	var_06.objidpingenemy = 1;
	var_06.objpingdelay = 1;
	var_06.allowweapons = 0;
	var_06.carryweapon = "iw5_carrydrone_mp";
	var_06.keepcarryweapon = 1;
	var_06.waterbadtrigger = 0;
	var_06.visualgroundoffset = (0,0,30);
	var_06.canuseobject = ::ball_can_pickup;
	var_06.onpickup = ::ball_on_pickup;
	var_06.setdropped = ::ball_set_dropped;
	var_06.onreset = ::ball_on_reset;
	var_06.carryweaponthink = ::ball_pass_or_shoot;
	var_06.in_goal = 0;
	var_06.lastcarrierscored = 0;
	var_06.requireslos = 1;
	var_06 ball_assign_start(var_01);
	level.balls[level.balls.size] = var_06;
	var_06 ball_fx_start();
	var_06 thread ball_location_hud(param_00);
	setomnvar("ui_mlg_game_mode_status_1",-1);
	setomnvar("ui_mlg_game_mode_status_2",-1);
	setomnvar("ui_mlg_game_mode_status_3",3);
}

//Function Number: 20
physics_impact_watch()
{
	self endon("death");
	for(;;)
	{
		self waittill("physics_impact",var_00,var_01,var_02,var_03);
		var_04 = level._effect["ball_physics_impact"];
		if(isdefined(var_03) && isdefined(level._effect["ball_physics_impact_" + var_03]))
		{
			var_04 = level._effect["ball_physics_impact_" + var_03];
		}

		playfx(var_04,var_00,var_01);
		wait(0.3);
	}
}

//Function Number: 21
ball_location_hud(param_00)
{
	if(param_00 > 4 || param_00 < 0)
	{
		return;
	}

	for(;;)
	{
		var_01 = common_scripts\utility::waittill_any_return("pickup_object","dropped","reset");
		switch(var_01)
		{
			case "pickup_object":
				setomnvar("ui_uplink_ball_carrier" + param_00 + 1,self.carrier getentitynumber());
				break;
	
			case "dropped":
				setomnvar("ui_uplink_ball_carrier" + param_00 + 1,-2);
				break;
	
			case "reset":
				setomnvar("ui_uplink_ball_carrier" + param_00 + 1,-1);
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 22
ball_waypoint_neutral()
{
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_ball");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_ball");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_ball");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_ball");
	maps\mp\_utility::setmlgicons(self,"waypoint_esports_uplink_ball_white");
}

//Function Number: 23
ball_waypoint_held()
{
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_ball_friendly");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_ball_enemy");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_ball_friendly");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_ball_enemy");
	if(self.ownerteam == "allies")
	{
		maps\mp\_utility::setmlgicons(self,"waypoint_esports_uplink_ball_blue");
		return;
	}

	maps\mp\_utility::setmlgicons(self,"waypoint_esports_uplink_ball_red");
}

//Function Number: 24
ball_waypoint_download()
{
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_ball_download");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_ball_download");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_ball_download");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_ball_download");
	maps\mp\_utility::setmlgicons(self,"waypoint_esports_uplink_ball_white");
}

//Function Number: 25
ball_waypoint_upload()
{
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_ball_upload");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_ball_upload");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_ball_upload");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_ball_upload");
	maps\mp\_utility::setmlgicons(self,"waypoint_esports_uplink_ball_white");
}

//Function Number: 26
ball_dont_interpolate()
{
	self.visuals[0] dontinterpolate();
	self.ball_fx_active = 0;
}

//Function Number: 27
ball_fx_start()
{
	if(!ball_fx_active())
	{
		var_00 = self.visuals[0];
		playfxontag(common_scripts\utility::getfx("ball_trail"),var_00,"tag_origin");
		playfxontag(common_scripts\utility::getfx("ball_idle"),var_00,"tag_origin");
		self.ball_fx_active = 1;
	}
}

//Function Number: 28
ball_fx_start_player(param_00)
{
	if(ball_fx_active())
	{
		var_01 = self.visuals[0];
		playfxontagforclients(common_scripts\utility::getfx("ball_trail"),var_01,"tag_origin",param_00);
		playfxontagforclients(common_scripts\utility::getfx("ball_idle"),var_01,"tag_origin",param_00);
	}
}

//Function Number: 29
ball_fx_stop()
{
	if(ball_fx_active())
	{
		var_00 = self.visuals[0];
		stopfxontag(common_scripts\utility::getfx("ball_trail"),var_00,"tag_origin");
		killfxontag(common_scripts\utility::getfx("ball_idle"),var_00,"tag_origin");
	}

	self.ball_fx_active = 0;
}

//Function Number: 30
ball_fx_active()
{
	return isdefined(self.ball_fx_active) && self.ball_fx_active;
}

//Function Number: 31
ball_pass_or_shoot()
{
	self endon("disconnect");
	thread ball_pass_watch();
	thread ball_shoot_watch();
	self.carryobject waittill("dropped");
}

//Function Number: 32
ball_pass_watch()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	for(;;)
	{
		self waittill("ball_pass",var_00);
		if(var_00 != "iw5_carrydrone_mp")
		{
			continue;
		}

		if(!isdefined(self.pass_target))
		{
			self iprintlnbold("No Pass Target");
			continue;
		}

		break;
	}

	if(isdefined(self.carryobject))
	{
		thread ball_pass_or_throw_active();
		var_01 = self.pass_target;
		var_02 = self.pass_target.origin;
		wait(0.15);
		if(isdefined(self.pass_target))
		{
			var_01 = self.pass_target;
		}

		self.carryobject thread ball_pass_projectile(self,var_01,var_02);
	}
}

//Function Number: 33
ball_pass_projectile(param_00,param_01,param_02)
{
	ball_set_dropped(1);
	if(isdefined(param_01))
	{
		param_02 = param_01.origin;
	}

	var_03 = (0,0,40);
	var_04 = vectornormalize(param_02 + var_03 - self.visuals[0].origin);
	var_05 = var_04 * 1000;
	self.projectile = magicgrenademanual("gamemode_ball",self.visuals[0].origin,var_05,30,param_00,1);
	if(isdefined(param_01))
	{
		self.projectile missile_settargetent(param_01);
	}

	self.visuals[0] linkto(self.projectile);
	ball_dont_interpolate();
	ball_create_killcam_ent();
	ball_clear_contents();
	thread ball_on_projectile_hit_client();
	thread ball_on_projectile_death();
	thread ball_pass_touch_goal();
}

//Function Number: 34
ball_create_killcam_ent()
{
	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}

	self.killcament = spawn("script_model",self.visuals[0].origin);
	self.killcament linkto(self.visuals[0]);
	self.killcament setcontents(0);
	self.killcament setscriptmoverkillcam("explosive");
}

//Function Number: 35
ball_clear_contents()
{
	self.visuals[0].old_contents = self.visuals[0] setcontents(0);
}

//Function Number: 36
ball_restore_contents()
{
	if(isdefined(self.visuals[0].old_contents))
	{
		self.visuals[0] setcontents(self.visuals[0].old_contents);
		self.visuals[0].old_contents = undefined;
	}
}

//Function Number: 37
ball_on_projectile_hit_client()
{
	self endon("pass_end");
	self.projectile waittill("projectile_impact_player",var_00);
	self.trigger notify("trigger",var_00);
}

//Function Number: 38
ball_on_projectile_death()
{
	self.projectile waittill("death");
	var_00 = self.visuals[0];
	if(!isdefined(self.carrier) && !self.in_goal)
	{
		if(var_00.origin != var_00.baseorigin + (0,0,4000))
		{
			ball_physics_launch((0,0,10));
		}
	}

	ball_restore_contents();
	var_00 notify("pass_end");
}

//Function Number: 39
ball_shoot_watch()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	var_00 = getdvarfloat("scr_ball_shoot_extra_pitch",-12);
	var_01 = getdvarfloat("scr_ball_shoot_force",320);
	for(;;)
	{
		self waittill("weapon_fired",var_02);
		if(var_02 != "iw5_carrydrone_mp")
		{
			continue;
		}

		break;
	}

	if(isdefined(self.carryobject))
	{
		var_03 = self getplayerangles();
		var_03 = var_03 + (var_00,0,0);
		var_03 = (clamp(var_03[0],-85,85),var_03[1],var_03[2]);
		var_04 = anglestoforward(var_03);
		thread ball_pass_or_throw_active();
		wait(0.25);
		self playsound("mp_ul_ball_throw");
		thread ball_check_pass_kill_pickup(self.carryobject);
		self.carryobject ball_create_killcam_ent();
		self.carryobject thread ball_physics_launch_drop(var_04 * var_01,self);
	}
}

//Function Number: 40
ball_pass_or_throw_active()
{
	self endon("death");
	self endon("disconnect");
	self.pass_or_throw_active = 1;
	self allowmelee(0);
	while("iw5_carrydrone_mp" == self getcurrentweapon())
	{
		wait 0.05;
	}

	self allowmelee(1);
	self.pass_or_throw_active = 0;
}

//Function Number: 41
ball_physics_launch_drop(param_00,param_01)
{
	ball_set_dropped(1);
	ball_physics_launch(param_00,param_01);
}

//Function Number: 42
ball_physics_launch(param_00,param_01)
{
	var_02 = self.visuals[0];
	var_02.origin_prev = undefined;
	ball_fx_start();
	var_02 physicslaunchserver(var_02.origin,param_00);
	thread ball_physics_out_of_level();
	thread ball_physics_timeout(param_01);
	thread ball_physics_bad_trigger_watch();
	thread ball_physics_touch_goal();
	thread ball_physics_touch_cant_pickup_player(param_01);
}

//Function Number: 43
ball_return_home()
{
	self.in_goal = 0;
	var_00 = self.visuals[0];
	playsoundatpos(var_00.origin,"uplink_out_of_bounds");
	playfx(common_scripts\utility::getfx("ball_teleport"),var_00.origin);
	if(isdefined(self.carrier))
	{
		self.carrier maps\mp\_utility::delaythread(0.05,::player_update_pass_target_hudoutline);
	}

	thread maps\mp\gametypes\_gameobjects::returnhome();
}

//Function Number: 44
ball_physics_out_of_level()
{
	self endon("reset");
	self endon("pickup_object");
	var_00 = self.visuals[0];
	var_01[0] = 200;
	var_01[1] = 200;
	var_01[2] = 1000;
	var_02[0] = 200;
	var_02[1] = 200;
	var_02[2] = 200;
	for(;;)
	{
		for(var_03 = 0;var_03 < 2;var_03++)
		{
			if(var_00.origin[var_03] > level.ball_maxs[var_03] + var_01[var_03])
			{
				ball_return_home();
				return;
			}

			if(var_00.origin[var_03] < level.ball_mins[var_03] - var_02[var_03])
			{
				ball_return_home();
				return;
			}
		}

		wait 0.05;
	}
}

//Function Number: 45
ball_physics_timeout(param_00)
{
	self endon("reset");
	self endon("pickup_object");
	self endon("score_event");
	var_01 = getdvarfloat("scr_ball_reset_time",15);
	var_02 = 10;
	var_03 = 3;
	if(var_01 >= var_02)
	{
		setomnvar("ui_mlg_game_mode_status_1",var_03);
		setomnvar("ui_mlg_game_mode_status_2",-1);
		var_04 = getomnvar("ui_mlg_game_mode_status_3");
		if(!isdefined(param_00))
		{
			if(var_04 == 1 || var_04 == 4 || var_04 == 5)
			{
				setomnvar("ui_mlg_game_mode_status_3",5);
			}
			else
			{
				setomnvar("ui_mlg_game_mode_status_3",7);
			}
		}
		else if(var_04 == 1 || var_04 == 4 || var_04 == 5)
		{
			setomnvar("ui_mlg_game_mode_status_3",4);
		}
		else
		{
			setomnvar("ui_mlg_game_mode_status_3",6);
		}

		wait(var_03);
		var_01 = var_01 - var_03;
	}

	setomnvar("ui_mlg_game_mode_status_1",int(var_01));
	setomnvar("ui_mlg_game_mode_status_2",-1);
	setomnvar("ui_mlg_game_mode_status_3",0);
	wait(var_01);
	ball_return_home();
}

//Function Number: 46
ball_physics_bad_trigger_watch()
{
	self.visuals[0] endon("physics_finished");
	thread ball_physics_bad_trigger_at_rest();
	wait(0.1);
	for(;;)
	{
		if(maps\mp\gametypes\_gameobjects::istouchingbadtrigger())
		{
			ball_return_home();
			return;
		}

		wait 0.05;
	}
}

//Function Number: 47
ball_physics_bad_trigger_at_rest()
{
	self endon("pickup_object");
	self endon("reset");
	self endon("score_event");
	var_00 = self.visuals[0];
	var_00 endon("death");
	var_00 waittill("physics_finished");
	if(maps\mp\gametypes\_gameobjects::istouchingbadtrigger())
	{
		ball_return_home();
	}
}

//Function Number: 48
ball_physics_touch_goal()
{
	var_00 = self.visuals[0];
	var_00 endon("physics_finished");
	ball_touch_goal_watch(var_00);
}

//Function Number: 49
ball_physics_touch_cant_pickup_player(param_00)
{
	var_01 = self.visuals[0];
	var_02 = self.trigger;
	var_01 endon("physics_finished");
	for(;;)
	{
		var_02 waittill("trigger",var_03);
		if(isdefined(param_00) && param_00 == var_03 && var_03 player_no_pickup_time())
		{
			continue;
		}

		if(self.droptime >= gettime())
		{
			continue;
		}

		if(var_01.origin == var_01.baseorigin + (0,0,4000))
		{
			continue;
		}

		if(!ball_can_pickup(var_03))
		{
			thread ball_physics_fake_bounce();
		}
	}
}

//Function Number: 50
ball_physics_fake_bounce()
{
	var_00 = self.visuals[0];
	if(!var_00 physicsisactive())
	{
		return;
	}

	var_01 = var_00 physicsgetlinvel();
	var_02 = length(var_01) / 10;
	var_03 = -1 * vectornormalize(var_01);
	var_00 physicsstop();
	var_00 physicslaunchserver(var_00.origin,var_03 * var_02);
}

//Function Number: 51
ball_pass_touch_goal()
{
	var_00 = self.visuals[0];
	var_00 endon("pass_end");
	ball_touch_goal_watch(var_00);
}

//Function Number: 52
ball_touch_goal_watch(param_00)
{
	for(;;)
	{
		foreach(var_05, var_02 in level.ball_goals)
		{
			if(self.lastcarrierteam == var_05)
			{
				continue;
			}

			if(!var_02.useobject ball_goal_can_use())
			{
				continue;
			}

			var_03 = distance(param_00.origin,var_02.origin);
			if(var_03 <= var_02.radius)
			{
				thread ball_touched_goal(var_02);
				return;
			}

			if(isdefined(param_00.origin_prev))
			{
				var_04 = line_interect_sphere(param_00.origin_prev,param_00.origin,var_02.origin,var_02.radius);
				if(var_04)
				{
					thread ball_touched_goal(var_02);
					return;
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 53
ball_goal_can_use(param_00)
{
	var_01 = self.goal;
	if(var_01.ball_in_goal)
	{
		return 0;
	}

	return 1;
}

//Function Number: 54
ball_carrier_touched_goal(param_00)
{
	var_01 = getdvarint("scr_ball_points_touchdown",2);
	if(!isdefined(param_00) || !isdefined(param_00.carryobject))
	{
		return;
	}

	if(isdefined(param_00.carryobject.scorefrozenuntil) && param_00.carryobject.scorefrozenuntil > gettime())
	{
		return;
	}

	param_00.carryobject.scorefrozenuntil = gettime() + 10000;
	param_00 maps\mp\_events::touchdownevent(var_01);
	ball_check_assist(param_00,1);
	param_00 thread ball_update_extrascore0();
	var_02 = self.goal.team;
	var_03 = maps\mp\_utility::getotherteam(var_02);
	maps\mp\_utility::leaderdialog("enemy_carry_score",var_02,"status");
	maps\mp\_utility::leaderdialog("ally_carry_score",var_03,"status");
	if(should_record_final_score_cam(var_03,var_01))
	{
		var_04 = self.goal.killcament;
		var_05 = var_04 getentitynumber();
		var_06 = var_04.birthtime;
		if(!isdefined(var_06))
		{
			var_06 = 0;
		}

		param_00.deathtime = gettime();
		maps\mp\gametypes\_damage::recordfinalkillcam(5,param_00,param_00,param_00 getentitynumber(),var_05,var_06,"none",0,0,undefined,"score");
	}

	ball_play_score_fx(self.goal);
	ball_score_sound(var_03);
	if(isdefined(param_00.shoot_charge_bar))
	{
		param_00.shoot_charge_bar.inuse = 0;
	}

	var_07 = param_00.carryobject;
	var_07.lastcarrierscored = 1;
	var_07 ball_set_dropped(1);
	var_07 thread ball_score_event(self.goal);
	ball_give_score(var_03,var_01);
}

//Function Number: 55
ball_update_extrascore0()
{
	waittillframeend;
	var_00 = maps\mp\_utility::getplayerstat("fieldgoal");
	var_01 = maps\mp\_utility::getplayerstat("touchdown");
	var_02 = getdvarint("scr_ball_points_fieldgoal",1);
	var_03 = getdvarint("scr_ball_points_touchdown",2);
	maps\mp\_utility::setextrascore0(var_00 * var_02 + var_01 * var_03);
}

//Function Number: 56
should_record_final_score_cam(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_gamescore::_getteamscore(param_00);
	var_03 = maps\mp\gametypes\_gamescore::_getteamscore(maps\mp\_utility::getotherteam(param_00));
	return var_02 + param_01 >= var_03;
}

//Function Number: 57
line_interect_sphere(param_00,param_01,param_02,param_03)
{
	var_04 = vectornormalize(param_01 - param_00);
	var_05 = vectordot(var_04,param_00 - param_02);
	var_05 = var_05 * var_05;
	var_06 = param_00 - param_02;
	var_06 = var_06 * var_06;
	var_07 = param_03 * param_03;
	return var_05 - var_06 + var_07 >= 0;
}

//Function Number: 58
ball_touched_goal(param_00)
{
	ball_play_score_fx(param_00);
	var_01 = getdvarint("scr_ball_points_fieldgoal",1);
	if(isdefined(self.scorefrozenuntil) && self.scorefrozenuntil > gettime())
	{
		return;
	}

	self.scorefrozenuntil = gettime() + 10000;
	var_02 = param_00.team;
	var_03 = maps\mp\_utility::getotherteam(var_02);
	maps\mp\_utility::leaderdialog("enemy_throw_score",var_02,"status");
	maps\mp\_utility::leaderdialog("ally_throw_score",var_03,"status");
	if(isdefined(self.lastcarrier))
	{
		self.lastcarrierscored = 1;
		self.lastcarrier maps\mp\_events::fieldgoalevent(var_01);
		ball_check_assist(self.lastcarrier,0);
		self.lastcarrier thread ball_update_extrascore0();
		if(isdefined(self.killcament) && should_record_final_score_cam(var_03,var_01))
		{
			var_04 = self.killcament;
			var_05 = var_04 getentitynumber();
			var_06 = var_04.birthtime;
			if(!isdefined(var_06))
			{
				var_06 = 0;
			}

			var_07 = self.lastcarrier;
			param_00.killcament.deathtime = gettime();
			maps\mp\gametypes\_damage::recordfinalkillcam(5,param_00.killcament,var_07,var_07 getentitynumber(),var_05,var_06,"none",0,0,undefined,"score");
		}
	}

	if(isdefined(self.killcament))
	{
		self.killcament unlink();
	}

	ball_score_sound(var_03);
	thread ball_score_event(param_00);
	ball_give_score(var_03,var_01);
	setomnvar("ui_mlg_game_mode_status_1",-1);
	if(isdefined(self.lastcarrier))
	{
		setomnvar("ui_mlg_game_mode_status_2",self.lastcarrier getentitynumber());
	}
	else
	{
		setomnvar("ui_mlg_game_mode_status_2",-1);
	}

	if(var_03 == "allies")
	{
		setomnvar("ui_mlg_game_mode_status_3",1);
		return;
	}

	setomnvar("ui_mlg_game_mode_status_3",2);
}

//Function Number: 59
ball_give_score(param_00,param_01)
{
	level maps\mp\gametypes\_gamescore::giveteamscoreforobjective(param_00,param_01);
	if(game["status"] == "overtime")
	{
		game["ball_overtime_team"] = param_00;
		game["round_time_to_beat"] = maps\mp\_utility::getminutespassed();
		level thread maps\mp\gametypes\_gamelogic::endgame("overtime_halftime",game["end_reason"]["switching_sides"]);
		return;
	}

	if(game["status"] == "overtime_halftime")
	{
		var_02 = maps\mp\gametypes\_gamescore::_getteamscore(param_00);
		var_03 = maps\mp\gametypes\_gamescore::_getteamscore(maps\mp\_utility::getotherteam(param_00));
		if(var_02 >= var_03)
		{
			level thread maps\mp\gametypes\_gamelogic::endgame(param_00,game["end_reason"]["score_limit_reached"]);
			return;
		}
	}
}

//Function Number: 60
ball_score_event(param_00)
{
	self notify("score_event");
	self.in_goal = 1;
	param_00.ball_in_goal = 1;
	var_01 = self.visuals[0];
	if(isdefined(self.projectile))
	{
		self.projectile delete();
	}

	var_01 physicsstop();
	maps\mp\gametypes\_gameobjects::allowcarry("none");
	ball_waypoint_upload();
	var_02 = 0.4;
	var_03 = 1.2;
	var_04 = 1;
	playsoundatpos(param_00.origin,"uplink_goal_point");
	var_05 = var_02 + var_04;
	var_06 = var_05 + var_03;
	var_01 moveto(param_00.origin,var_02,0,var_02);
	var_01 rotatevelocity((1080,1080,0),var_06,var_06,0);
	wait(var_05);
	param_00.ball_in_goal = 0;
	var_01 movez(4000,var_03,var_03 * 0.1,0);
	wait(var_03);
	maps\mp\gametypes\_gameobjects::allowcarry("any");
	ball_return_home();
}

//Function Number: 61
ball_check_assist(param_00,param_01)
{
	if(!isdefined(param_00.passtime) || !isdefined(param_00.passplayer))
	{
		return;
	}

	if(param_00.passtime + 3000 < gettime())
	{
		return;
	}

	param_00.passplayer maps\mp\_events::ballscoreassistevent();
	if(param_01)
	{
		param_00 maps\mp\gametypes\_missions::processchallenge("ch_ball_alleyoop");
	}
}

//Function Number: 62
ball_play_score_fx(param_00)
{
	param_00.score_fx["friendly"] hide();
	param_00.score_fx["enemy"] hide();
	foreach(var_02 in level.players)
	{
		var_03 = ball_get_view_team(var_02);
		if(var_03 == param_00.team)
		{
			param_00.score_fx["friendly"] showtoplayer(var_02);
			continue;
		}

		param_00.score_fx["enemy"] showtoplayer(var_02);
	}

	triggerfx(param_00.score_fx["friendly"]);
	triggerfx(param_00.score_fx["enemy"]);
}

//Function Number: 63
ball_score_sound(param_00)
{
	ball_play_local_team_sound(param_00,"mp_obj_notify_pos_lrg","mp_obj_notify_neg_lrg");
}

//Function Number: 64
ball_play_local_team_sound(param_00,param_01,param_02)
{
	var_03 = maps\mp\_utility::getotherteam(param_00);
	foreach(var_05 in level.players)
	{
		if(var_05.team == param_00)
		{
			var_05 playlocalsound(param_01);
			continue;
		}

		if(var_05.team == var_03)
		{
			var_05 playlocalsound(param_02);
		}
	}
}

//Function Number: 65
ball_can_pickup(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(isdefined(param_00.underwater) && param_00.underwater)
	{
		return 0;
	}

	if(isdefined(self.droptime) && self.droptime >= gettime())
	{
		return 0;
	}

	if(!param_00 common_scripts\utility::isweaponenabled())
	{
		return 0;
	}

	if(param_00 isusingturret())
	{
		return 0;
	}

	if(isdefined(param_00.manuallyjoiningkillstreak) && param_00.manuallyjoiningkillstreak)
	{
		return 0;
	}

	if(isdefined(param_00.using_remote_turret) && param_00.using_remote_turret)
	{
		return 0;
	}

	var_01 = param_00 getcurrentweapon();
	if(isdefined(var_01))
	{
		if(!valid_ball_pickup_weapon(var_01))
		{
			return 0;
		}
	}

	var_02 = param_00.changingweapon;
	if(isdefined(var_02) && param_00 isreloading())
	{
		if(!valid_ball_pickup_weapon(var_02))
		{
			return 0;
		}
	}

	if(isdefined(param_00.exo_shield_on) && param_00.exo_shield_on == 1)
	{
		return 0;
	}

	if(param_00 maps\mp\_utility::isjuggernaut())
	{
		return 0;
	}

	if(param_00 player_no_pickup_time())
	{
		return 0;
	}

	return 1;
}

//Function Number: 66
valid_ball_pickup_weapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(param_00 == "iw5_carrydrone_mp")
	{
		return 0;
	}

	if(maps\mp\_utility::iskillstreakweapon(param_00))
	{
		return 0;
	}

	if(param_00 == "iw5_combatknifegoliath_mp")
	{
		return 0;
	}

	return 1;
}

//Function Number: 67
player_no_pickup_time()
{
	return isdefined(self.nopickuptime) && self.nopickuptime > gettime();
}

//Function Number: 68
ball_on_pickup(param_00)
{
	level.usestartspawns = 0;
	var_01 = self.visuals[0] getlinkedparent();
	if(isdefined(var_01))
	{
		self.visuals[0] unlink();
	}

	self.visuals[0] physicsstop();
	self.visuals[0] maps\mp\_movers::notify_moving_platform_invalid();
	self.visuals[0] show();
	self.visuals[0] ghost();
	self.visuals[0] method_8568(0);
	self.trigger maps\mp\_movers::stop_handling_moving_platforms();
	self.current_start.in_use = 0;
	var_02 = 0;
	if(isdefined(self.projectile))
	{
		var_02 = 1;
		self.projectile delete();
	}

	var_03 = param_00.team;
	var_04 = maps\mp\_utility::getotherteam(param_00.team);
	if(var_02)
	{
		if(self.lastcarrierteam == param_00.team)
		{
			maps\mp\_utility::leaderdialog("pass_complete",var_03,"status");
			param_00.passtime = gettime();
			param_00.passplayer = self.lastcarrier;
		}
		else
		{
			maps\mp\_utility::leaderdialog("pass_intercepted",var_03,"status");
			param_00 maps\mp\_events::interceptionevent();
		}
	}
	else
	{
		maps\mp\_utility::leaderdialog("ally_own_drone",var_03,"status",[param_00]);
		param_00 maps\mp\_utility::leaderdialogonplayer("you_own_drone","status");
		maps\mp\_utility::leaderdialog("enemy_own_drone",var_04,"status");
	}

	param_00 playsound("mp_ul_ball_catch");
	ball_play_local_team_sound(var_03,"mp_obj_notify_pos_sml","mp_obj_notify_neg_sml");
	ball_fx_stop();
	self.lastcarrierscored = 0;
	self.lastcarrier = param_00;
	self.lastcarrierteam = param_00.team;
	self.ownerteam = param_00.team;
	ball_waypoint_held();
	param_00 setweaponammoclip("iw5_carrydrone_mp",1);
	param_00.balldropdelay = getdvarint("scr_ball_water_drop_delay",10);
	param_00 maps\mp\_utility::giveperk("specialty_ballcarrier",0);
	param_00.ball_carried = self;
	param_00.objective = 1;
	setomnvar("ui_mlg_game_mode_status_1",-1);
	setomnvar("ui_mlg_game_mode_status_2",self.carrier getentitynumber());
	if(self.carrier.team == "allies")
	{
		setomnvar("ui_mlg_game_mode_status_3",1);
	}
	else
	{
		setomnvar("ui_mlg_game_mode_status_3",2);
	}

	param_00.hasperksprintfire = param_00 hasperk("specialty_sprintfire",1);
	param_00 maps\mp\_utility::giveperk("specialty_sprintfire",0);
	param_00 common_scripts\utility::_disableusability();
	param_00 maps\mp\killstreaks\_coop_util::playerstoppromptforstreaksupport();
	var_05 = getdvarint("scr_ball_armor",100);
	if(var_05 > 0)
	{
		param_00 thread maps\mp\perks\_perkfunctions::setlightarmor(var_05);
	}
	else
	{
		param_00 thread maps\mp\perks\_perkfunctions::unsetlightarmor();
	}

	param_00 thread player_update_pass_target(self);
	maps\mp\gametypes\_gamelogic::sethasdonecombat(param_00,1);
}

//Function Number: 69
ball_check_pass_kill_pickup(param_00)
{
	self endon("death");
	self endon("disconnect");
	param_00 endon("reset");
	var_01 = spawnstruct();
	var_01 endon("timer_done");
	var_01 thread timer_run(1.5);
	param_00 waittill("pickup_object");
	var_01 timer_cancel();
	if(!isdefined(param_00.carrier) || param_00.carrier.team == self.team)
	{
		return;
	}

	param_00.carrier endon("disconnect");
	var_01 thread timer_run(5);
	param_00.carrier waittill("death",var_02);
	var_01 timer_cancel();
	if(!isdefined(var_02) || var_02 != self)
	{
		return;
	}

	var_01 thread timer_run(2);
	param_00 waittill("pickup_object");
	var_01 timer_cancel();
	if(isdefined(param_00.carrier) && param_00.carrier == self)
	{
		maps\mp\_events::passkillpickupevent();
	}
}

//Function Number: 70
timer_run(param_00)
{
	self endon("cancel_timer");
	wait(param_00);
	self notify("timer_done");
}

//Function Number: 71
timer_cancel()
{
	self notify("cancel_timer");
}

//Function Number: 72
player_update_pass_target(param_00)
{
	self endon("disconnect");
	self endon("cancel_update_pass_target");
	player_update_pass_target_hudoutline();
	childthread player_joined_update_pass_target_hudoutline();
	var_01 = 0.8;
	for(;;)
	{
		var_02 = undefined;
		if(!self isonladder())
		{
			var_03 = anglestoforward(self getplayerangles());
			var_04 = self geteye();
			var_05 = [];
			foreach(var_07 in level.players)
			{
				if(var_07.team != self.team)
				{
					continue;
				}

				if(!maps\mp\_utility::isreallyalive(var_07))
				{
					continue;
				}

				if(!param_00 ball_can_pickup(var_07))
				{
					continue;
				}

				var_08 = var_07 geteye();
				var_09 = distancesquared(var_08,var_04);
				if(var_09 > 1000000)
				{
					continue;
				}

				var_0A = vectornormalize(var_08 - var_04);
				var_0B = vectordot(var_03,var_0A);
				if(var_0B > var_01)
				{
					var_07.pass_dot = var_0B;
					var_07.pass_origin = var_08;
					var_05[var_05.size] = var_07;
				}
			}

			var_05 = maps\mp\_utility::quicksort(var_05,::compare_player_pass_dot);
			foreach(var_07 in var_05)
			{
				if(sighttracepassed(var_04,var_07.pass_origin,0,self,var_07))
				{
					var_02 = var_07;
					break;
				}
			}
		}

		player_set_pass_target(var_02);
		wait 0.05;
	}
}

//Function Number: 73
player_joined_update_pass_target_hudoutline()
{
	for(;;)
	{
		level waittill("joined_team",var_00);
		player_update_pass_target_hudoutline();
	}
}

//Function Number: 74
player_update_pass_target_hudoutline()
{
	if(!isdefined(self))
	{
		return;
	}

	self hudoutlinedisableforclients(level.players);
	foreach(var_01 in level.players)
	{
		var_01 hudoutlinedisableforclient(self);
	}

	var_03 = [];
	var_04 = [];
	var_05 = maps\mp\_utility::getotherteam(self.team);
	foreach(var_01 in level.players)
	{
		if(var_01 == self)
		{
			continue;
		}

		if(var_01.team == self.team)
		{
			var_03[var_03.size] = var_01;
			continue;
		}

		if(var_01.team == var_05)
		{
			var_04[var_04.size] = var_01;
		}
	}

	if(isdefined(self.carryobject))
	{
		foreach(var_01 in var_03)
		{
			var_09 = isdefined(self.pass_target) && self.pass_target == var_01;
			if(!var_09)
			{
				var_01 hudoutlineenableforclient(self,4,0);
			}
		}

		if(isdefined(self.pass_target))
		{
			self.pass_target hudoutlineenableforclient(self,5,0);
		}

		if(var_04.size > 0)
		{
			self hudoutlineenableforclients(var_04,0,1);
		}

		if(var_03.size > 0)
		{
			self hudoutlineenableforclients(var_03,5,0);
		}
	}
}

//Function Number: 75
player_set_pass_target(param_00)
{
	if(isdefined(self.pass_target) && isdefined(param_00) && self.pass_target == param_00)
	{
		return;
	}

	if(!isdefined(self.pass_target) && !isremovedentity(self.pass_target) && !isdefined(param_00))
	{
		return;
	}

	player_clear_pass_target();
	if(isdefined(param_00))
	{
		var_01 = (0,0,80);
		self.pass_icon = param_00 maps\mp\_entityheadicons::setheadicon(self,"waypoint_ball_pass",var_01,10,10,0,0.05,0,1,0,0,"tag_origin");
		self.pass_target = param_00;
		var_02 = [];
		foreach(var_04 in level.players)
		{
			if(var_04.team == self.team && var_04 != self && var_04 != param_00)
			{
				var_02[var_02.size] = var_04;
			}
		}

		self setclientomnvar("ui_uplink_can_pass",1);
		self setballpassallowed(1);
	}

	player_update_pass_target_hudoutline();
}

//Function Number: 76
player_clear_pass_target()
{
	if(isdefined(self.pass_icon))
	{
		self.pass_icon destroy();
	}

	self setclientomnvar("ui_uplink_can_pass",0);
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(var_02.team == self.team && var_02 != self)
		{
			var_00[var_00.size] = var_02;
		}
	}

	self.pass_target = undefined;
	self setballpassallowed(0);
	player_update_pass_target_hudoutline();
}

//Function Number: 77
compare_player_pass_dot(param_00,param_01)
{
	return param_00.pass_dot >= param_01.pass_dot;
}

//Function Number: 78
ball_set_dropped(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	self.isresetting = 1;
	self.droptime = gettime();
	self notify("dropped");
	var_01 = self.carrier;
	if(isdefined(var_01) && var_01.team != "spectator")
	{
		var_02 = var_01.origin;
	}
	else
	{
		var_02 = self.safeorigin;
	}

	var_02 = var_02 + (0,0,40);
	var_03 = (0,0,0);
	for(var_04 = 0;var_04 < self.visuals.size;var_04++)
	{
		self.visuals[var_04].origin = var_02;
		self.visuals[var_04].angles = var_03;
		self.visuals[var_04] show();
		self.visuals[var_04] method_8568(1);
	}

	self.trigger.origin = var_02;
	ball_dont_interpolate();
	self.curorigin = self.trigger.origin;
	ball_carrier_cleanup();
	ball_fx_start();
	self.ownerteam = "any";
	ball_waypoint_neutral();
	maps\mp\gametypes\_gameobjects::clearcarrier();
	if(isdefined(var_01))
	{
		var_01 player_update_pass_target_hudoutline();
	}

	maps\mp\gametypes\_gameobjects::updatecompassicons();
	maps\mp\gametypes\_gameobjects::updateworldicons();
	self.isresetting = 0;
	if(!param_00)
	{
		var_05 = self.lastcarrierteam;
		var_06 = maps\mp\_utility::getotherteam(var_05);
		maps\mp\_utility::leaderdialog("ally_drop_drone",var_05,"status");
		maps\mp\_utility::leaderdialog("enemy_drop_drone",var_06,"status");
		ball_physics_launch((0,0,80));
	}

	var_07 = spawnstruct();
	var_07.carryobject = self;
	var_07.deathoverridecallback = ::ball_overridemovingplatformdeath;
	self.trigger thread maps\mp\_movers::handle_moving_platforms(var_07);
	return 1;
}

//Function Number: 79
ball_overridemovingplatformdeath(param_00)
{
}

//Function Number: 80
ball_assign_random_start()
{
	var_00 = undefined;
	var_01 = common_scripts\utility::array_randomize(level.ball_starts);
	foreach(var_03 in var_01)
	{
		if(var_03.in_use)
		{
			continue;
		}

		var_00 = var_03;
		break;
	}

	if(!isdefined(var_00))
	{
		return;
	}

	ball_assign_start(var_00);
}

//Function Number: 81
ball_assign_start(param_00)
{
	foreach(var_02 in self.visuals)
	{
		var_02.baseorigin = param_00.origin;
	}

	self.trigger.baseorigin = param_00.origin;
	self.current_start = param_00;
	param_00.in_use = 1;
}

//Function Number: 82
ball_on_reset()
{
	ball_assign_random_start();
	var_00 = self.visuals[0];
	var_00 maps\mp\_movers::notify_moving_platform_invalid();
	var_01 = var_00 getlinkedparent();
	if(isdefined(var_01))
	{
		var_00 unlink();
	}

	var_00 physicsstop();
	ball_dont_interpolate();
	if(isdefined(self.projectile))
	{
		self.projectile delete();
	}

	var_02 = "none";
	var_03 = self.lastcarrierteam;
	if(isdefined(var_03))
	{
		var_02 = maps\mp\_utility::getotherteam(var_03);
	}

	ball_carrier_cleanup();
	setomnvar("ui_mlg_game_mode_status_1",-1);
	setomnvar("ui_mlg_game_mode_status_2",-1);
	setomnvar("ui_mlg_game_mode_status_3",3);
	self.trigger maps\mp\_movers::stop_handling_moving_platforms();
	ball_waypoint_download();
	maps\mp\gametypes\_gameobjects::setposition(var_00.baseorigin + (0,0,4000),(0,0,0));
	var_04 = 3;
	var_00 moveto(var_00.baseorigin,var_04,0,var_04);
	var_00 rotatevelocity((0,720,0),var_04,0,var_04);
	playsoundatpos(var_00.baseorigin,"uplink_ball_reset");
	if(!self.lastcarrierscored && isdefined(var_03) && isdefined(var_02))
	{
		maps\mp\_utility::leaderdialog("drone_reset",var_03,"status");
		maps\mp\_utility::leaderdialog("drone_reset",var_02,"status");
		if(isdefined(self.lastcarrier))
		{
			thread maps\mp\_utility::teamplayercardsplash("callout_ballreset",self.lastcarrier);
		}
	}

	self.ownerteam = "any";
	ball_waypoint_download();
	thread ball_download_wait(var_04);
	thread ball_download_fx(var_00,var_04);
}

//Function Number: 83
ball_download_fx(param_00,param_01)
{
	playfxontag(level._effect["ball_download"],param_00,"tag_origin");
	common_scripts\utility::waittill_notify_or_timeout("pickup_object",param_01);
	stopfxontag(level._effect["ball_download"],param_00,"tag_origin");
	self.scorefrozenuntil = 0;
}

//Function Number: 84
ball_download_wait(param_00)
{
	self endon("pickup_object");
	wait(param_00);
	ball_waypoint_neutral();
	playfx(level._effect["ball_download_end"],self.current_start.ground_origin);
	ball_fx_start();
}

//Function Number: 85
ball_carrier_cleanup()
{
	if(isdefined(self.carrier))
	{
		self.carrier.balldropdelay = undefined;
		self.carrier.nopickuptime = gettime() + 500;
		self.carrier player_clear_pass_target();
		self.carrier notify("cancel_update_pass_target");
		self.carrier maps\mp\_utility::_unsetperk("specialty_ballcarrier");
		self.carrier.ball_carried = undefined;
		self.carrier thread maps\mp\perks\_perkfunctions::unsetlightarmor();
		if(!self.carrier.hasperksprintfire)
		{
			self.carrier maps\mp\_utility::_unsetperk("specialty_sprintfire");
		}

		self.carrier common_scripts\utility::_enableusability();
		self.carrier maps\mp\killstreaks\_coop_util::playerstartpromptforstreaksupport();
		self.carrier setballpassallowed(0);
		self.carrier setclientomnvar("ui_uplink_can_pass",0);
		self.carrier.objective = 0;
	}
}

//Function Number: 86
ball_find_ground(param_00)
{
	var_01 = self.origin + (0,0,32);
	var_02 = self.origin + (0,0,-1000);
	var_03 = bullettrace(var_01,var_02,0,undefined);
	self.ground_origin = var_03["position"];
	return var_03["fraction"] != 0 && var_03["fraction"] != 1;
}

//Function Number: 87
ball_create_team_goal(param_00)
{
	var_01 = param_00;
	if(game["switchedsides"])
	{
		var_01 = maps\mp\_utility::getotherteam(var_01);
	}

	var_02 = 0;
	var_03 = common_scripts\utility::getstruct("ball_goal_" + var_01,"targetname");
	if(!maps\mp\_utility::isaugmentedgamemode())
	{
		var_04 = common_scripts\utility::getstruct("ball_goal_non_augmented_" + var_01,"targetname");
		if(isdefined(var_04))
		{
			var_03 = var_04;
		}
		else
		{
			var_02 = 1;
		}
	}

	if(isdefined(var_03))
	{
		var_03 ball_find_ground();
		if(var_02)
		{
			var_03.origin = var_03.ground_origin + (0,0,90);
		}
	}
	else
	{
		var_03 = spawnstruct();
		switch(level.script)
		{
			default:
				break;
		}

		if(!isdefined(var_03.origin))
		{
			var_03.origin = level.default_goal_origins[param_00];
		}

		var_03 ball_find_ground();
		if(maps\mp\_utility::isaugmentedgamemode())
		{
			var_03.origin = var_03.ground_origin + (0,0,220);
		}
		else
		{
			var_03.origin = var_03.ground_origin + (0,0,90);
		}
	}

	var_03.radius = 70;
	var_03.team = param_00;
	var_03.ball_in_goal = 0;
	var_03.highestspawndistratio = 0;
	level.ball_goals[param_00] = var_03;
}

//Function Number: 88
ball_create_ball_starts(param_00)
{
	var_01 = common_scripts\utility::getstructarray("ball_start","targetname");
	if(!maps\mp\_utility::isaugmentedgamemode())
	{
		var_02 = common_scripts\utility::getstructarray("ball_start_non_augmented","targetname");
		if(var_02.size > 0)
		{
			var_01 = var_02;
		}
	}

	var_01 = common_scripts\utility::array_randomize(var_01);
	foreach(var_04 in var_01)
	{
		if(!isdefined(var_04.script_index))
		{
			var_04.script_index = 100;
		}
	}

	var_01 = maps\mp\_utility::quicksort(var_01,::compare_script_index);
	foreach(var_04 in var_01)
	{
		ball_add_start(var_04.origin);
	}

	var_08 = 30;
	if(var_01.size == 0)
	{
		var_09 = (0,0,0);
		switch(level.script)
		{
			default:
				break;
		}

		if(!isdefined(var_09))
		{
			var_09 = level.default_ball_origin;
		}

		ball_add_start(var_09);
	}

	var_0A = param_00 - level.ball_starts.size;
	if(var_0A <= 0)
	{
		return;
	}

	var_0B = level.ball_starts[0].origin;
	var_0C = getnodesinradius(var_0B,200,20,50);
	var_0C = common_scripts\utility::array_randomize(var_0C);
	for(var_0D = 0;var_0D < var_0A && var_0D < var_0C.size;var_0D++)
	{
		ball_add_start(var_0C[var_0D].origin);
	}
}

//Function Number: 89
ball_add_start(param_00)
{
	var_01 = 30;
	var_02 = spawnstruct();
	var_02.origin = param_00;
	var_02 ball_find_ground();
	var_02.origin = var_02.ground_origin + (0,0,var_01);
	var_02.in_use = 0;
	level.ball_starts[level.ball_starts.size] = var_02;
}

//Function Number: 90
compare_script_index(param_00,param_01)
{
	return param_00.script_index <= param_01.script_index;
}

//Function Number: 91
ball_on_connect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.ball_goal_fx = [];
		var_00 thread player_on_disconnect();
	}
}

//Function Number: 92
player_on_disconnect()
{
	self waittill("disconnect");
	player_delete_ball_goal_fx();
}

//Function Number: 93
ball_goal_fx_for_player(param_00)
{
	var_01 = ball_get_view_team(param_00);
	param_00 player_delete_ball_goal_fx();
	foreach(var_06, var_03 in level.ball_goals)
	{
		var_04 = common_scripts\utility::ter_op(var_06 == var_01,"ball_goal_friendly","ball_goal_enemy");
		var_05 = spawnfxforclient(common_scripts\utility::getfx(var_04),var_03.origin,param_00,(1,0,0));
		setfxkillondelete(var_05,1);
		param_00.ball_goal_fx[var_04] = var_05;
		triggerfx(var_05);
	}
}

//Function Number: 94
ball_get_view_team(param_00)
{
	var_01 = param_00.team;
	if(var_01 != "allies" && var_01 != "axis")
	{
		var_01 = "allies";
	}

	return var_01;
}

//Function Number: 95
player_delete_ball_goal_fx()
{
	foreach(var_01 in self.ball_goal_fx)
	{
		if(isdefined(var_01))
		{
			var_01 delete();
		}
	}
}

//Function Number: 96
ball_play_fx_joined_team()
{
	for(;;)
	{
		level waittill("joined_team",var_00);
		ball_goal_fx_for_player(var_00);
	}
}