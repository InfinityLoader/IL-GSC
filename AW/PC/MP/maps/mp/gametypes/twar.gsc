/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\twar.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 80
 * Decompile Time: 1362 ms
 * Timestamp: 10/27/2023 1:43:25 AM
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
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	maps\mp\_utility::setovertimelimitdvar(3);
	level.teambased = 1;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onnormaldeath = ::onnormaldeath;
	level.onspawnplayer = ::onspawnplayer;
	level.ontimelimit = ::ontimelimit;
	level.onplayerkilled = ::onplayerkilled;
	level.allowboostingabovetriggerradius = 1;
	level.ai_game_mode = 1;
	level.modifyplayerdamage = ::minion_damage;
	level.on_agent_player_killed = ::on_minion_killed;
	level.spawn_version = 3;
	level.flagfxid = loadfx("vfx/unique/vfx_flag_project_neutral");
	level.boarderfxid = loadfx("vfx/unique/vfx_marker_dom_white");
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	game["dialog"]["gametype"] = "mom_intro";
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

	game["dialog"]["defense_obj"] = "mtm_alert";
	game["dialog"]["offense_obj"] = "mtm_alert";
	game["dialog"]["mtm_taking"] = "mtm_taking";
	game["dialog"]["mtm_etaking"] = "mtm_etaking";
	game["dialog"]["mtm_lastflg"] = "mtm_lastflg";
	game["dialog"]["mtm_elastflg"] = "mtm_elastflg";
	game["dialog"]["mtm_secured"] = "mtm_secured";
	game["dialog"]["mtm_captured"] = "mtm_captured";
	game["dialog"]["mtm_max"] = "mtm_max";
	game["dialog"]["mtm_gain"] = "mtm_gain";
	game["dialog"]["mtm_reset"] = "mtm_reset";
	game["dialog"]["mtm_clrd"] = "mtm_clrd";
	game["dialog"]["mtm_lost"] = "mtm_lost";
	if(maps\mp\_utility::isgrapplinghookgamemode())
	{
		game["dialog"]["gametype"] = "grap_" + game["dialog"]["gametype"];
	}

	if(!isdefined(game["shut_out"]))
	{
		game["shut_out"]["axis"] = 1;
		game["shut_out"]["allies"] = 1;
		game["max_meter"]["axis"] = 0;
		game["max_meter"]["allies"] = 0;
	}

	setdvar("r_hudOutlineWidth",1);
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	setdynamicdvar("scr_twar_roundswitch",0);
	maps\mp\_utility::registerroundswitchdvar("twar",0,0,9);
	setdynamicdvar("scr_twar_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar("twar",1);
	setdynamicdvar("scr_twar_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("twar",1);
	setdynamicdvar("scr_twar_halftime",0);
	maps\mp\_utility::registerhalftimedvar("twar",0);
	setdynamicdvar("scr_twar_halftime",0);
	setdynamicdvar("scr_twar_minionsmax",getmatchrulesdata("twarData","numMinions"));
	setdynamicdvar("scr_twar_capture_time",getmatchrulesdata("twarData","captureTime"));
	setdynamicdvar("scr_twar_zone_count",getmatchrulesdata("twarData","numFlags"));
	setdynamicdvar("scr_twar_ot_zone_count",getmatchrulesdata("twarData","numOTFlags"));
	setdynamicdvar("scr_twar_min_capture_players",1);
	setdynamicdvar("scr_twar_hud_momentum_bar",!getmatchrulesdata("twarData","hideMomentumBar"));
}

//Function Number: 3
onstartgametype()
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

	maps\mp\_utility::setobjectivetext("allies",&"OBJECTIVES_TWAR");
	maps\mp\_utility::setobjectivetext("axis",&"OBJECTIVES_TWAR");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_TWAR");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_TWAR");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_TWAR_SCORE");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_TWAR_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_TWAR_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_TWAR_HINT");
	game["dialog"]["lockouts"]["mtm_taking"] = 5;
	game["dialog"]["lockouts"]["mtm_etaking"] = 5;
	initspawns();
	var_02[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::main(var_02);
	level.zone_radius = getdvarint("scr_twar_zone_radius",150);
	if(!isdefined(level.zone_height))
	{
		level.zone_height = 60;
	}

	level.momentum_multiplier_max = 3;
	find_zones();
	assign_spawns();
	create_active_zone();
	init_momentum("allies");
	init_momentum("axis");
	thread watch_for_joined_team();
	thread updateminions();
	thread update_lua_hud();
}

//Function Number: 4
watch_for_joined_team()
{
	for(;;)
	{
		level waittill("joined_team");
		level notify("update_flag_outline");
		update_minion_hud_outlines();
	}
}

//Function Number: 5
ontimelimit()
{
	level.finalkillcam_winner = "none";
	if(game["status"] == "overtime")
	{
		var_00 = "tie";
	}
	else if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
	{
		var_00 = "overtime";
		game["owned_flags"] = [];
		game["owned_flags"]["allies"] = 0;
		game["owned_flags"]["axis"] = 0;
		foreach(var_02 in level.twar_zones)
		{
			if(var_02.owner == "allies")
			{
				game["owned_flags"]["allies"]++;
				continue;
			}

			if(var_02.owner == "axis")
			{
				game["owned_flags"]["axis"]++;
			}
		}
	}
	else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
	{
		level.finalkillcam_winner = "axis";
		var_00 = "axis";
	}
	else
	{
		level.finalkillcam_winner = "allies";
		var_00 = "allies";
	}

	if(maps\mp\_utility::practiceroundgame())
	{
		var_00 = "none";
	}

	thread maps\mp\gametypes\_gamelogic::endgame(var_00,game["end_reason"]["time_limit_reached"]);
}

//Function Number: 6
spawn_flag_projector(param_00)
{
	var_01 = spawn("script_model",param_00);
	var_01 setmodel("flag_holo_base_ground");
	return var_01;
}

//Function Number: 7
create_active_zone()
{
	var_00[0] = spawn_flag_projector((0,0,0));
	var_01 = spawn("trigger_radius",(0,0,0),0,level.zone_radius,level.zone_height);
	var_01.radius = level.zone_radius;
	var_02 = getdvarfloat("scr_twar_capture_time",20);
	var_03 = maps\mp\gametypes\_gameobjects::createuseobject("neutral",var_01,var_00);
	var_03 maps\mp\gametypes\_gameobjects::allowuse("any");
	var_03 maps\mp\gametypes\_gameobjects::setusetime(var_02);
	var_03 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	var_03.keepprogress = 1;
	var_03.nousebar = 1;
	var_03.id = "twarZone";
	var_03.onbeginuse = ::onbeginuse;
	var_03.onuse = ::onuse;
	var_03.onenduse = ::onenduse;
	var_03.onupdateuserate = ::onupdateuserate;
	level.twar_use_obj = var_03;
	reset_zone_owners();
}

//Function Number: 8
zone_set_waiting()
{
	maps\mp\gametypes\_gameobjects::setownerteam("neutral");
	maps\mp\gametypes\_gameobjects::allowuse("none");
	var_00 = "waypoint_waitfor_flag_neutral";
	maps\mp\gametypes\_gameobjects::set2dicon("friendly",var_00);
	maps\mp\gametypes\_gameobjects::set3dicon("friendly",var_00);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy",var_00);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy",var_00);
	maps\mp\_utility::setmlgicons(self,var_00);
	self.waiting = 1;
	setomnvar("ui_twar_capture_team",3);
}

//Function Number: 9
update_icons(param_00,param_01)
{
	if(isdefined(self.waiting))
	{
		return;
	}

	if(param_00 > 0 && param_01 > 0)
	{
		var_02 = "waypoint_contested";
		maps\mp\gametypes\_gameobjects::set2dicon("friendly",var_02);
		maps\mp\gametypes\_gameobjects::set3dicon("friendly",var_02);
		maps\mp\gametypes\_gameobjects::set2dicon("enemy",var_02);
		maps\mp\gametypes\_gameobjects::set3dicon("enemy",var_02);
		maps\mp\_utility::setmlgicons(self,var_02);
		return;
	}

	if(param_00 == 0 && param_01 == 0)
	{
		var_02 = "waypoint_captureneutral";
		maps\mp\gametypes\_gameobjects::set2dicon("friendly",var_02);
		maps\mp\gametypes\_gameobjects::set3dicon("friendly",var_02);
		maps\mp\gametypes\_gameobjects::set2dicon("enemy",var_02);
		maps\mp\gametypes\_gameobjects::set3dicon("enemy",var_02);
		maps\mp\_utility::setmlgicons(self,var_02);
		return;
	}

	maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_losing");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_losing");
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_taking");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_taking");
	if(self.claimteam == "allies")
	{
		maps\mp\_utility::setmlgicons(self,"waypoint_esports_taking_blue");
		return;
	}

	maps\mp\_utility::setmlgicons(self,"waypoint_esports_taking_red");
}

//Function Number: 10
zone_set_neutral()
{
	maps\mp\gametypes\_gameobjects::setownerteam("neutral");
	maps\mp\gametypes\_gameobjects::allowuse("any");
	self.waiting = undefined;
	setomnvar("ui_twar_capture_team",0);
	update_icons(0,0);
}

//Function Number: 11
zone_flag_effect()
{
	zone_flag_effect_stop();
	var_00 = level.twar_use_obj.visuals[0];
	self.flagfx = spawnlinkedfx(level.flagfxid,var_00,"tag_fx_flag");
	setfxkillondelete(self.flagfx,1);
	triggerfx(self.flagfx);
}

//Function Number: 12
zone_flag_effect_stop()
{
	if(isdefined(self.flagfx))
	{
		self.flagfx delete();
	}
}

//Function Number: 13
zone_boarder_effect()
{
	zone_boarder_effect_stop();
	var_00 = level.twar_use_obj.visuals[0];
	self.boarderfx = spawnfx(level.boarderfxid,var_00.origin,anglestoup(var_00.angles));
	setfxkillondelete(self.boarderfx,1);
	triggerfx(self.boarderfx);
}

//Function Number: 14
zone_boarder_effect_stop()
{
	if(isdefined(self.boarderfx))
	{
		self.boarderfx delete();
	}
}

//Function Number: 15
zone_set_team(param_00)
{
	maps\mp\gametypes\_gameobjects::setownerteam(param_00);
	maps\mp\gametypes\_gameobjects::allowuse("any");
}

//Function Number: 16
update_flag_outline()
{
	for(;;)
	{
		level waittill("update_flag_outline");
		var_00 = getdvarint("scr_twar_flag_outline_color_friendly",-1);
		var_01 = getdvarint("scr_twar_flag_outline_color_enemy",-1);
		var_02 = getdvarint("scr_twar_flag_outline_color_neutral",-1);
		var_03 = getdvarint("scr_twar_flag_outline_depth",0);
		self hudoutlinedisableforclients(level.players);
		var_04 = level.twar_use_obj maps\mp\gametypes\_gameobjects::getclaimteam();
		var_05 = [];
		var_06 = [];
		var_07 = [];
		foreach(var_09 in level.players)
		{
			if((var_04 == "allies" || var_04 == "axis") && var_09.team == "allies" || var_09.team == "axis")
			{
				if(var_04 == var_09.team)
				{
					var_05[var_05.size] = var_09;
				}
				else
				{
					var_06[var_06.size] = var_09;
				}

				continue;
			}

			var_07[var_07.size] = var_09;
		}

		if(var_05.size && var_00 >= 0)
		{
			self hudoutlineenableforclients(var_05,var_00,var_03);
		}

		if(var_06.size && var_01 >= 0)
		{
			self hudoutlineenableforclients(var_06,var_01,var_03);
		}

		if(var_07.size && var_02 >= 0)
		{
			self hudoutlineenableforclients(var_07,var_02,var_03);
		}
	}
}

//Function Number: 17
reset_zone_owners()
{
	var_00 = int(level.twar_zones.size / 2);
	foreach(var_03, var_02 in level.twar_zones)
	{
		if(var_03 < var_00)
		{
			var_02.owner = "allies";
			continue;
		}

		if(var_03 > var_00)
		{
			var_02.owner = "axis";
			continue;
		}

		var_02.owner = "none";
	}

	set_contested_zone(level.twar_zones[var_00]);
}

//Function Number: 18
onbeginuse(param_00)
{
	var_01 = param_00.team;
	var_02 = maps\mp\_utility::getotherteam(var_01);
	zone_set_team(var_01);
	maps\mp\_utility::leaderdialog("mtm_taking",var_01);
	maps\mp\_utility::leaderdialog("mtm_etaking",var_02);
	level notify("update_flag_outline");
}

//Function Number: 19
onuse(param_00)
{
	var_01 = param_00.team;
	var_02 = maps\mp\_utility::getotherteam(var_01);
	var_03 = self.zone;
	var_03.owner = var_01;
	var_04 = var_03.index;
	if(var_01 == "allies")
	{
		var_04++;
	}
	else if(var_01 == "axis")
	{
		var_04--;
	}

	game["shut_out"][var_02] = 0;
	if(getdvarint("scr_twar_momentum_clear_friendly_on_capture",0))
	{
		clear_momentum(var_01);
	}
	else
	{
		add_capture_friendly_momentum(var_01);
	}

	if(getdvarint("scr_twar_momentum_clear_enemy_on_capture",0))
	{
		clear_momentum(var_02);
	}
	else
	{
		add_capture_enemy_momentum(var_02);
	}

	param_00 thread maps\mp\_audio::snd_play_team_splash("mp_obj_notify_pos_lrg","mp_obj_notify_neg_lrg");
	thread givezonecapturexp(self.touchlist[var_01]);
	if(var_04 < 0 || var_04 >= level.num_zones)
	{
		zone_flag_effect_stop();
		zone_boarder_effect_stop();
		level maps\mp\gametypes\_gamescore::giveteamscoreforobjective(var_01,1);
		maps\mp\_utility::leaderdialog("mtm_secured",var_01);
		if(level.gameended)
		{
			maps\mp\gametypes\_gameobjects::disableobject();
		}
		else
		{
			reset_zone_owners();
		}
	}
	else
	{
		set_contested_zone(level.twar_zones[var_04]);
		if(var_04 == 0 || var_04 == level.num_zones - 1)
		{
			leaderdialogwait("mtm_lastflg",var_02);
			leaderdialogwait("mtm_elastflg",var_01);
		}
		else
		{
			leaderdialogwait("mtm_secured",var_01);
		}
	}

	self.nextusetime = gettime() + 50;
}

//Function Number: 20
leaderdialogwait(param_00,param_01)
{
	thread _leaderdialogwait(param_00,param_01);
}

//Function Number: 21
_leaderdialogwait(param_00,param_01)
{
	wait 0.05;
	maps\mp\_utility::leaderdialog(param_00,param_01);
}

//Function Number: 22
givezonecapturexp(param_00)
{
	level endon("game_ended");
	var_01 = maps\mp\gametypes\_gameobjects::getearliestclaimplayer();
	if(isdefined(var_01.owner))
	{
		var_01 = var_01.owner;
	}

	if(isplayer(var_01))
	{
		level thread maps\mp\_utility::teamplayercardsplash("callout_securedposition",var_01);
	}

	var_02 = getarraykeys(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_01 = param_00[var_02[var_03]].player;
		if(isdefined(var_01.owner))
		{
			var_01 = var_01.owner;
		}

		if(!isplayer(var_01))
		{
			continue;
		}

		var_01 thread maps\mp\_events::domcaptureevent(0);
		wait(0.05);
	}
}

//Function Number: 23
onenduse(param_00,param_01,param_02)
{
	zone_set_neutral();
	level notify("update_flag_outline");
}

//Function Number: 24
onupdateuserate()
{
	var_00 = self.userate;
	var_01 = 0;
	var_02 = 0;
	var_03 = maps\mp\_utility::getotherteam(self.claimteam);
	foreach(var_05 in self.touchlist[var_03])
	{
		var_06 = var_05.player;
		if(!isdefined(var_06))
		{
			continue;
		}

		if(var_06.pers["team"] != var_03)
		{
			continue;
		}

		var_02++;
	}

	var_08 = getdvarint("scr_twar_capture_players_max",3);
	foreach(var_05 in self.touchlist[self.claimteam])
	{
		var_06 = var_05.player;
		if(!isdefined(var_06))
		{
			continue;
		}

		if(var_06.pers["team"] != self.claimteam)
		{
			continue;
		}

		var_01++;
		if(var_01 >= var_08)
		{
			break;
		}
	}

	self.userate = 0;
	self.stalemate = var_01 && var_02;
	var_0B = getdvarint("scr_twar_min_capture_players",1);
	if(var_01 && !var_02 && var_01 >= var_0B)
	{
		var_0C = level.twar_team_multiplier[self.claimteam];
		self.userate = var_01 * var_0C;
	}

	var_0D = getdvarint("scr_twar_capture_rate_max",9);
	self.userate = min(self.userate,var_0D);
	if(self.keepprogress && self.lastclaimteam != self.claimteam)
	{
		self.userate = self.userate * -1;
	}

	update_icons(var_01,var_02);
}

//Function Number: 25
set_contested_zone(param_00)
{
	param_00.owner = "none";
	level.twar_use_obj.zone = param_00;
	level.twar_use_obj maps\mp\gametypes\_gameobjects::move_use_object(param_00.origin,(0,0,100));
	foreach(var_02 in level.twar_zones)
	{
		if(var_02 != param_00)
		{
			var_02.projector show();
			continue;
		}

		var_02.projector hide();
	}

	if(level.twar_use_obj.keepprogress)
	{
		level.twar_use_obj.lastclaimteam = "none";
	}

	level thread set_contested_zone_wait(5);
}

//Function Number: 26
set_contested_zone_wait(param_00)
{
	waittillframeend;
	level.twar_use_obj zone_flag_effect_stop();
	level.twar_use_obj zone_boarder_effect();
	level.twar_use_obj zone_set_waiting();
	wait(param_00);
	level.twar_use_obj zone_flag_effect();
	level.twar_use_obj zone_set_neutral();
}

//Function Number: 27
update_lua_hud()
{
	for(;;)
	{
		waittillframeend;
		var_00 = 0;
		foreach(var_02 in level.twar_zones)
		{
			if(var_02.owner == "allies")
			{
				var_00++;
			}
		}

		setomnvar("ui_twar_ally_flag_count",var_00);
		var_04 = 0;
		var_05 = "";
		if(level.twar_use_obj.keepprogress)
		{
			var_05 = level.twar_use_obj.lastclaimteam;
		}
		else
		{
			var_05 = level.twar_use_obj.claimteam;
		}

		if(var_05 == "axis")
		{
			var_04 = 1;
		}
		else if(var_05 == "allies")
		{
			var_04 = 2;
		}

		var_06 = getdvarint("scr_twar_hud_momentum_bar",1);
		setomnvar("ui_twar_momentum_bar_visible",var_06);
		if(getomnvar("ui_twar_capture_team") != 3)
		{
			setomnvar("ui_twar_capture_team",var_04);
		}

		var_07 = 0;
		if(var_05 != "none")
		{
			var_07 = level.twar_use_obj.curprogress / level.twar_use_obj.usetime;
		}

		setomnvar("ui_twar_capture_progress",var_07);
		foreach(var_04 in level.teamnamelist)
		{
			var_09 = 0;
			if(level.twar_use_obj.interactteam == "any")
			{
				var_09 = level.twar_use_obj.numtouching[var_04];
			}

			setomnvar("ui_twar_touching_" + var_04,var_09);
		}

		wait 0.05;
	}
}

//Function Number: 28
is_maxed_momentum(param_00)
{
	return level.twar_team_multiplier[param_00] == level.momentum_multiplier_max;
}

//Function Number: 29
set_maxed_momentum(param_00,param_01)
{
	thread clear_max_momentum_delayed(param_00,param_01);
	set_momentum(param_00,0);
	setomnvar("ui_twar_momentum_maxed_time",param_01);
	setomnvar("ui_twar_momentum_end_time_" + param_00,gettime() + int(1000 * param_01));
}

//Function Number: 30
clear_max_momentum_delayed(param_00,param_01)
{
	level endon("clear_max_momentum_" + param_00);
	wait(param_01);
	thread clear_maxed_momentum(param_00);
}

//Function Number: 31
clear_maxed_momentum(param_00)
{
	level notify("clear_max_momentum_" + param_00);
	if(!is_maxed_momentum(param_00))
	{
		return;
	}

	set_momentum(param_00,0);
	set_momentum_multiplier(param_00,level.momentum_multiplier_max - 1);
	setomnvar("ui_twar_momentum_end_time_" + param_00,0);
}

//Function Number: 32
clear_momentum(param_00)
{
	if(level.twar_team_multiplier[param_00] == 1)
	{
		maps\mp\_utility::leaderdialog("mtm_clrd",param_00,"momentum_down");
	}
	else
	{
		maps\mp\_utility::leaderdialog("mtm_reset",param_00,"momentum_down");
	}

	clear_maxed_momentum(param_00);
	var_01 = level.twar_team_momentum[param_00] + level.twar_team_multiplier[param_00] - 1;
	add_momentum(param_00,-1 * var_01);
}

//Function Number: 33
add_momentum(param_00,param_01,param_02)
{
	if(param_01 == 0)
	{
		return;
	}

	if(level.momentum_multiplier_max <= 1)
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!param_02 && is_maxed_momentum(param_00))
	{
		return;
	}

	var_03 = level.twar_team_momentum[param_00];
	var_04 = level.twar_team_multiplier[param_00];
	var_05 = 0;
	var_03 = var_03 + param_01;
	while(var_03 <= 0 && var_04 > 1)
	{
		var_03 = var_03 + 1;
		var_04--;
		var_05 = 1;
	}

	if(!var_05)
	{
		while(var_03 >= 1 && var_04 < level.momentum_multiplier_max)
		{
			var_03 = var_03 - 1;
			var_04++;
			var_05 = 1;
		}
	}

	set_momentum(param_00,var_03);
	if(var_05)
	{
		set_momentum_multiplier(param_00,var_04);
	}

	if(is_maxed_momentum(param_00))
	{
		var_06 = getdvarfloat("scr_twar_maxed_time",20);
		set_maxed_momentum(param_00,var_06);
		return;
	}

	setomnvar("ui_twar_momentum_" + param_00,level.twar_team_momentum[param_00]);
}

//Function Number: 34
set_momentum(param_00,param_01)
{
	param_01 = clamp(param_01,0,1);
	level.twar_team_momentum[param_00] = param_01;
	setomnvar("ui_twar_momentum_" + param_00,level.twar_team_momentum[param_00]);
}

//Function Number: 35
set_momentum_multiplier(param_00,param_01)
{
	var_02 = level.twar_team_multiplier[param_00];
	level.twar_team_multiplier[param_00] = param_01;
	if(var_02 != param_01)
	{
		setomnvar("ui_twar_momentum_scale_" + param_00,param_01);
		level.twar_use_obj maps\mp\gametypes\_gameobjects::updateuserate();
		if(var_02 > param_01)
		{
			if(var_02 != level.momentum_multiplier_max)
			{
				maps\mp\_utility::leaderdialog("mtm_lost",param_00,"momentum_down");
				return;
			}

			return;
		}

		if(is_maxed_momentum(param_00))
		{
			maps\mp\_utility::leaderdialog("mtm_max",param_00);
			if(!game["max_meter"][param_00])
			{
				game["max_meter"][param_00] = 1;
				foreach(var_04 in level.players)
				{
					if(var_04.team != param_00)
					{
						continue;
					}

					var_04 maps\mp\gametypes\_missions::processchallenge("ch_twar_blitzkrieg");
				}

				return;
			}

			return;
		}

		maps\mp\_utility::leaderdialog("mtm_gain",var_03);
		return;
	}
}

//Function Number: 36
add_kill_enemy_momentum(param_00)
{
	var_01 = getdvarfloat("scr_twar_momentum_kill_enemy",0.1);
	add_momentum(param_00,var_01);
}

//Function Number: 37
add_kill_friendly_momentum(param_00)
{
	var_01 = getdvarfloat("scr_twar_momentum_kill_friendly",-0.1);
	add_momentum(param_00,var_01);
}

//Function Number: 38
add_capture_friendly_momentum(param_00)
{
	var_01 = getdvarfloat("scr_twar_momentum_capture_friendly",0.2);
	add_momentum(param_00,var_01);
}

//Function Number: 39
add_capture_enemy_momentum(param_00)
{
	var_01 = getdvarfloat("scr_twar_momentum_capture_enemy",-0.2);
	add_momentum(param_00,var_01);
}

//Function Number: 40
init_momentum(param_00)
{
	level.twar_team_multiplier[param_00] = 1;
	level.twar_team_momentum[param_00] = 0;
	setomnvar("ui_twar_momentum_end_time_" + param_00,0);
	setomnvar("ui_twar_momentum_" + param_00,level.twar_team_momentum[param_00]);
	setomnvar("ui_twar_momentum_scale_" + param_00,level.twar_team_multiplier[param_00]);
	if(level.momentum_multiplier_max <= 1)
	{
		return;
	}

	level thread init_overtime_momentum(param_00);
}

//Function Number: 41
init_overtime_momentum(param_00)
{
	maps\mp\_utility::gameflagwait("prematch_done");
	if(game["status"] == "overtime")
	{
		var_01 = 0;
		var_02 = game["owned_flags"][param_00];
		if(var_02 == 4)
		{
			var_01 = 2;
		}
		else if(var_02 == 3)
		{
			var_01 = 1;
		}

		add_momentum(param_00,var_01);
	}
}

//Function Number: 42
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	level.start_spawn_prefix = "mp_twar_spawn_";
	level.start_spawn_allies = "mp_twar_spawn_allies_start";
	level.start_spawn_axis = "mp_twar_spawn_axis_start";
	if(!getspawnarray(level.start_spawn_allies).size)
	{
		level.start_spawn_prefix = "mp_tdm_spawn_";
		level.start_spawn_allies = "mp_tdm_spawn_allies_start";
		level.start_spawn_axis = "mp_tdm_spawn_axis_start";
	}

	maps\mp\gametypes\_spawnlogic::addstartspawnpoints(level.start_spawn_allies);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints(level.start_spawn_axis);
	level.spawn_name = "mp_twar_spawn";
	if(!getspawnarray(level.spawn_name).size)
	{
		level.spawn_name = "mp_tdm_spawn";
	}

	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies",level.spawn_name);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis",level.spawn_name);
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 43
getspawnpoint()
{
	var_00 = self.pers["team"];
	if(game["switchedsides"])
	{
		var_00 = maps\mp\_utility::getotherteam(var_00);
	}

	if(level.usestartspawns && level.ingraceperiod)
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpointarray(level.start_spawn_prefix + var_00 + "_start");
		var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_startspawn(var_01);
	}
	else
	{
		var_01 = [];
		var_03 = [];
		if(level.twar_zones.size == 1 && level.spawn_version != 3)
		{
			var_01 = level.single_zone_spawns[var_00];
		}
		else if(level.spawn_version == 1)
		{
			var_04 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_00);
			foreach(var_02 in var_04)
			{
				if(var_02.nearestzone.owner == var_00)
				{
					var_01[var_01.size] = var_02;
					continue;
				}

				if(var_02.nearestzone.owner == "none")
				{
					var_03[var_03.size] = var_02;
				}
			}
		}
		else if(level.spawn_version == 2)
		{
			for(var_07 = 0;var_07 < level.twar_zones.size;var_07++)
			{
				var_08 = var_07;
				if(var_00 == "allies")
				{
					var_08 = level.twar_zones.size - 1 - var_07;
				}

				var_09 = level.twar_zones[var_08];
				if(var_09.owner == var_00)
				{
					var_01 = var_09.nearspawns;
					break;
				}
				else if(var_09.owner == "none")
				{
					var_03 = var_09.nearspawns;
				}
			}
		}
		else if(level.spawn_version == 3)
		{
			var_0A = level.twar_use_obj.zone;
			var_01 = var_0A.nearspawns[var_00];
		}

		if(var_01.size == 0)
		{
			var_01 = var_03;
		}

		var_02 = maps\mp\gametypes\_spawnscoring::getspawnpoint_twar(var_01,level.twar_use_obj.zone);
	}

	maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_02);
	return var_02;
}

//Function Number: 44
onnormaldeath(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		add_kill_enemy_momentum(param_01.team);
	}

	if(isdefined(param_00.team))
	{
		add_kill_friendly_momentum(param_00.team);
	}
}

//Function Number: 45
get_start_spawn_centers(param_00)
{
	var_01 = [];
	var_02 = ["allies","axis"];
	var_03 = [];
	foreach(var_05 in var_02)
	{
		var_03[var_05] = maps\mp\gametypes\_spawnlogic::getspawnpointarray(level.start_spawn_prefix + var_05 + "_start");
	}

	foreach(var_05 in var_02)
	{
		var_08 = (0,0,0);
		foreach(var_0A in var_03[var_05])
		{
			var_08 = var_08 + var_0A.origin;
		}

		var_08 = var_08 / var_03[var_05].size;
		var_01[var_05] = var_08;
	}

	if(param_00)
	{
		var_0D = getallnodes();
		foreach(var_05, var_08 in var_01)
		{
			var_0F = 0;
			for(var_10 = 0;var_10 < 10 && var_10 < var_0D.size;var_10++)
			{
				var_11 = getpathdist(var_08,var_0D[var_10].origin,99999,1);
				if(var_11 > 0)
				{
					var_0F = 1;
					break;
				}
			}

			if(!var_0F)
			{
				var_01[var_05] = var_03[var_05][0].origin;
			}
		}
	}

	return var_01;
}

//Function Number: 46
find_zones()
{
	if(!isdefined(game["zone_origins"]) || game["status"] == "overtime")
	{
		game["zone_origins"] = get_zone_origins();
	}

	var_00 = 5;
	level.num_zones = getdvarint("scr_twar_zone_count",var_00);
	if(level.num_zones <= 0)
	{
		level.num_zones = var_00;
	}

	if(game["status"] == "overtime")
	{
		level.num_zones = getdvarint("scr_twar_ot_zone_count",3);
	}

	if(game["zone_origins"].size > level.num_zones)
	{
		var_01 = int(game["zone_origins"].size - level.num_zones / 2);
		var_02 = [];
		for(var_03 = var_01;var_03 <= game["zone_origins"].size - 1 - var_01;var_03++)
		{
			var_02[var_02.size] = game["zone_origins"][var_03];
		}

		game["zone_origins"] = var_02;
	}

	setomnvar("ui_twar_flag_count",level.num_zones);
	level.twar_zones = [];
	foreach(var_03, var_05 in game["zone_origins"])
	{
		var_06 = twar_zone(var_03,var_05.origin,var_05.angles,color_from_index(var_03));
		level.twar_zones[var_03] = var_06;
	}
}

//Function Number: 47
get_zone_origins()
{
	var_00 = [];
	var_01 = common_scripts\utility::getstructarray("twar_zone","targetname");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.script_index))
		{
			return var_00;
		}
	}

	if(maps\mp\_utility::isaugmentedgamemode())
	{
		var_05 = common_scripts\utility::getstructarray("twar_zone_augmented","targetname");
		foreach(var_07 in var_05)
		{
			if(!isdefined(var_07.script_index))
			{
				continue;
			}

			foreach(var_09, var_03 in var_01)
			{
				if(var_03.script_index == var_07.script_index)
				{
					var_01[var_09] = var_07;
				}
			}
		}
	}

	if(var_01.size < 3 || var_01.size > 7)
	{
		return var_00;
	}

	var_01 = maps\mp\_utility::quicksort(var_01,::quicksort_flag_compare);
	foreach(var_03 in var_01)
	{
		var_0C = twarzoneangleoverride(var_03);
		var_0D = spawnstruct();
		var_0D.origin = var_03.origin;
		if(isdefined(var_0C))
		{
			var_0D.angles = var_0C;
		}
		else
		{
			var_0D.angles = var_03.script_angles;
		}

		var_00[var_00.size] = var_0D;
	}

	level.num_zones = var_00.size;
	return var_00;
}

//Function Number: 48
twarzoneangleoverride(param_00)
{
	var_01 = maps\mp\_utility::getmapname();
	var_02 = undefined;
	var_03 = param_00.script_index;
	switch(var_01)
	{
		case "mp_detroit":
			break;

		case "mp_instinct":
			break;

		default:
			break;
	}
}

//Function Number: 49
quicksort_flag_compare(param_00,param_01)
{
	return param_00.script_index <= param_01.script_index;
}

//Function Number: 50
get_zone_origins_auto()
{
	level.num_zones = getdvarint("scr_twar_zone_count",5);
	var_00 = get_start_spawn_centers(1);
	var_01 = ["allies","axis"];
	var_02 = getallnodes();
	var_03 = level.num_zones;
	var_04 = getdvarfloat("scr_twar_auto_zone_spacing",0.15);
	var_05 = getdvarfloat("scr_twar_auto_zone_zig_zag",0.1);
	var_06 = getdvarint("scr_twar_auto_zone_allow_traversals",0);
	var_07 = getdvarint("scr_twar_auto_zone_sky_only",1);
	var_08 = [];
	for(var_09 = 0;var_09 < level.num_zones;var_09++)
	{
		var_0A = var_09 + 1 / level.num_zones + 1 - var_09 + 1;
		var_0B = 2 * var_09 + 1 - 1 / 2 * level.num_zones + 1 - var_09 + 1 + 1;
		var_0C = 2 * var_09 + 1 + 1 / 2 * level.num_zones + 1 - var_09 + 1 - 1;
		var_08[var_09]["min"] = var_0A - var_04 * var_0A - var_0B;
		var_08[var_09]["max"] = var_0A + var_04 * var_0C - var_0A;
	}

	var_0D = [];
	for(var_09 = 0;var_09 < var_08.size;var_09++)
	{
		var_0D[var_09] = [];
	}

	foreach(var_0F in var_02)
	{
		if(var_07 && !nodeexposedtosky(var_0F,1))
		{
			continue;
		}

		var_10 = [];
		foreach(var_12 in var_01)
		{
			var_10[var_12] = getpathdist(var_00[var_12],var_0F.origin,99999,var_06);
		}

		if(var_10["allies"] <= 0 || var_10["axis"] <= 0)
		{
			continue;
		}

		var_14 = var_10["allies"] / var_10["axis"];
		for(var_09 = 0;var_09 < var_08.size;var_09++)
		{
			if(var_14 > var_08[var_09]["min"] && var_14 < var_08[var_09]["max"])
			{
				var_0D[var_09][var_0D[var_09].size] = var_0F;
			}
		}
	}

	var_16 = [];
	var_17 = var_00["allies"];
	foreach(var_09, var_19 in var_0D)
	{
		var_19 = sortbydistance(var_19,var_17);
		var_1A = int(clamp(2 * var_19.size * var_05 - var_19.size,0,var_19.size));
		var_1B = int(clamp(2 * var_19.size * var_05,0,var_19.size));
		if(var_1A < var_1B)
		{
			var_1C = randomintrange(var_1A,var_1B);
		}
		else
		{
			var_1C = int(clamp(var_1A,0,var_19.size - 1));
		}

		var_1D = spawnstruct();
		var_1D.origin = var_19[var_1C].origin;
		var_16[var_09] = var_1D;
		var_17 = var_19[var_1C].origin;
	}

	return var_16;
}

//Function Number: 51
color_from_index(param_00)
{
	return (param_00 & 4,param_00 & 2,param_00 & 1);
}

//Function Number: 52
twar_zone(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_05 = param_01 + (0,0,32);
	var_06 = param_01 + (0,0,-64);
	var_07 = bullettrace(var_05,var_06,0,undefined);
	var_04.origin = var_07["position"];
	var_04.owner = "none";
	var_04.index = param_00;
	var_04.angles = param_02;
	var_04.debug_color = param_03;
	var_04.projector = spawn_flag_projector(var_04.origin);
	return var_04;
}

//Function Number: 53
draw_spawn_until_notify(param_00,param_01,param_02)
{
	level endon(param_02);
	var_03 = anglestoforward(param_00.angles);
	level thread draw_line_until_notify(param_00.origin,param_00.origin + var_03 * 50,param_01,param_02);
	param_00.debug_draw = 1;
	wait(0.05);
}

//Function Number: 54
draw_line_until_notify(param_00,param_01,param_02,param_03)
{
	level endon(param_03);
	wait(0.05);
}

//Function Number: 55
draw_circle_until_notify(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		var_05 = param_04;
	}
	else
	{
		var_05 = 16;
	}

	var_06 = 360 / var_05;
	var_07 = [];
	for(var_08 = 0;var_08 < var_05;var_08++)
	{
		var_09 = var_06 * var_08;
		var_0A = cos(var_09) * param_01;
		var_0B = sin(var_09) * param_01;
		var_0C = param_00[0] + var_0A;
		var_0D = param_00[1] + var_0B;
		var_0E = param_00[2];
		var_07[var_07.size] = (var_0C,var_0D,var_0E);
	}

	for(var_08 = 0;var_08 < var_07.size;var_08++)
	{
		var_0F = var_07[var_08];
		if(var_08 + 1 >= var_07.size)
		{
			var_10 = var_07[0];
		}
		else
		{
			var_10 = var_07[var_08 + 1];
		}

		thread draw_line_until_notify(var_0F,var_10,param_02,param_03);
	}
}

//Function Number: 56
assign_spawns()
{
	if(level.spawn_version == 2)
	{
		assign_spawns_version_2();
		return;
	}

	if(level.spawn_version == 3)
	{
		assign_spawns_version_3();
	}
}

//Function Number: 57
assign_spawns_version_2()
{
	if(level.twar_zones.size == 1)
	{
		level.single_zone_spawns = [];
		level.single_zone_spawns["allies"] = [];
		level.single_zone_spawns["axis"] = [];
		var_00 = getnearestspawns(level.twar_zones[0],12);
		foreach(var_02 in var_00)
		{
			var_03 = maps\mp\gametypes\_spawnlogic::getspawnpointarray(level.start_spawn_prefix + "allies_start")[0];
			var_04 = twar_dist(var_02.origin,var_03.origin);
			var_03 = maps\mp\gametypes\_spawnlogic::getspawnpointarray(level.start_spawn_prefix + "axis_start")[0];
			var_05 = twar_dist(var_02.origin,var_03.origin);
			var_06 = common_scripts\utility::ter_op(var_04 < var_05,"allies","axis");
			var_07 = level.single_zone_spawns[var_06].size;
			level.single_zone_spawns[var_06][var_07] = var_02;
		}

		return;
	}

	foreach(var_0A in level.twar_zones)
	{
		var_0A.nearspawns = getnearestspawns(var_0A,6);
	}

	var_0C = maps\mp\gametypes\_spawnlogic::getteamspawnpoints("axis");
	foreach(var_0E in var_0C)
	{
		var_0E.nearestzone = getnearestzonepoint(var_0E);
		if(!common_scripts\utility::array_contains(var_0E.nearestzone.nearspawns,var_0E))
		{
			var_07 = var_0E.nearestzone.nearspawns.size;
			var_0E.nearestzone.nearspawns[var_07] = var_0E;
		}
	}
}

//Function Number: 58
get_zone_dir(param_00)
{
	if(isdefined(level.twar_zones[param_00].angles))
	{
		return anglestoforward(level.twar_zones[param_00].angles);
	}

	var_03 = get_start_spawn_centers(0);
	var_04 = var_03["axis"] - var_03["allies"];
	var_04 = (var_04[0],var_04[1],0);
	return vectornormalize(var_04);
}

//Function Number: 59
assign_spawns_version_3()
{
	var_00 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints("axis");
	var_01 = var_00.size;
	foreach(var_0E, var_03 in level.twar_zones)
	{
		var_04 = 9;
		var_03.nearspawns["all"] = getnearestspawns(var_03,24,level.zone_radius * 3,0);
		var_03.dir = get_zone_dir(var_0E);
		foreach(var_06 in var_03.nearspawns["all"])
		{
			var_07 = vectornormalize(var_03.origin - var_06.origin);
			var_06.dot = vectordot(var_07,var_03.dir);
		}

		var_03.nearspawns["all"] = maps\mp\_utility::quicksort(var_03.nearspawns["all"],::twar_spawn_dot);
		var_03.nearspawns["allies"] = [];
		var_03.nearspawns["axis"] = [];
		for(var_09 = 0;var_09 < var_03.nearspawns["all"].size;var_09++)
		{
			var_0A = int(var_09 / 2);
			var_0B = "axis";
			if(var_09 % 2 == 1)
			{
				var_0A = var_03.nearspawns["all"].size - int(var_09 + 1 / 2);
				var_0B = "allies";
			}

			var_0C = undefined;
			var_06 = var_03.nearspawns["all"][var_0A];
			if(var_03.nearspawns[var_0B].size < var_04)
			{
				var_0C = var_0B;
			}
			else if(var_06.dot > 0)
			{
				var_0C = "allies";
			}
			else
			{
				var_0C = "axis";
			}

			if(isdefined(var_0C))
			{
				var_0D = var_03.nearspawns[var_0C].size;
				var_03.nearspawns[var_0C][var_0D] = var_06;
			}
		}
	}
}

//Function Number: 60
twar_dist(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_spawnlogic::ispathdataavailable();
	var_03 = -1;
	if(var_02)
	{
		var_03 = getpathdist(param_00,param_01,999999);
	}

	if(var_03 == -1)
	{
		var_03 = distance(param_00,param_01);
	}

	return var_03;
}

//Function Number: 61
getnearestspawns(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_04 = maps\mp\gametypes\_spawnlogic::ispathdataavailable();
	var_05 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints("axis");
	foreach(var_07 in var_05)
	{
		var_07.dist = -1;
		if(var_04)
		{
			var_07.dist = getpathdist(var_07.origin,param_00.origin,999999);
		}

		if(var_07.dist == -1)
		{
			var_07.dist = distance(param_00.origin,var_07.origin);
		}
	}

	var_05 = maps\mp\_utility::quicksort(var_05,::twar_spawn_dist);
	var_09 = maps\mp\_utility::getmapname();
	var_0A = game["status"] == "overtime";
	var_0B = param_00.index;
	if(var_0A)
	{
		var_0B = var_0B + 1;
	}

	var_0C = [];
	var_0D = 0;
	if(var_0D < var_05.size && var_0C.size < param_01)
	{
		var_07 = var_05[var_0D];
		if(var_07.dist < param_02)
		{
			continue;
		}

		switch(var_09)
		{
			case "mp_instinct":
				break;
		}
	}
}

//Function Number: 62
twar_spawn_dot(param_00,param_01)
{
	return param_00.dot <= param_01.dot;
}

//Function Number: 63
twar_spawn_dist(param_00,param_01)
{
	return param_00.dist <= param_01.dist;
}

//Function Number: 64
getnearestzonepoint(param_00)
{
	var_01 = maps\mp\gametypes\_spawnlogic::ispathdataavailable();
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_05 in level.twar_zones)
	{
		var_06 = undefined;
		if(var_01)
		{
			var_06 = getpathdist(param_00.origin,var_05.origin,999999);
		}

		if(!isdefined(var_06) || var_06 == -1)
		{
			var_06 = distance(var_05.origin,param_00.origin);
		}

		if(!isdefined(var_02) || var_06 < var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	return var_02;
}

//Function Number: 65
onspawnplayer()
{
	self.minionstreak = 0;
}

//Function Number: 66
updateminions()
{
	level endon("game_ended");
	while(!isdefined(level.agentarray))
	{
		wait 0.05;
	}

	maps\mp\_utility::gameflagwait("prematch_done");
	var_00 = getdvarint("scr_twar_minionsmax",18);
	if(var_00 <= 0)
	{
		return;
	}

	update_minion_hud_outlines();
	var_01 = ["allies","axis"];
	var_02 = getdvarfloat("scr_twar_minionspawndelay",10);
	var_03 = [];
	var_04 = undefined;
	var_05 = undefined;
	var_06 = getdvarint("scr_twar_minionspawnhud",0);
	if(var_06 > 0)
	{
		var_04 = minion_spawn_timer_hud();
		var_04 hud_set_visible();
		if(var_06 > 1)
		{
			var_05 = minion_max_hud();
			foreach(var_08 in var_01)
			{
				foreach(var_0A in var_01)
				{
					var_03[var_08][var_0A] = minion_count_hud(var_08,var_0A);
				}
			}
		}
	}

	if(!level.gameended)
	{
		if(isdefined(var_04))
		{
			var_04 settimer(var_02);
		}

		wait(var_02);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		var_0D = getminioncount();
		var_0E = level.num_zones - 1;
		if(var_0D + var_0E < var_00)
		{
			var_0F = [];
			foreach(var_11 in var_01)
			{
				var_0F[var_11] = 0;
			}

			var_13 = level.twar_zones;
			var_1B = getfirstarraykey(var_13);
			if(isdefined(var_1B))
			{
				var_14 = var_13[var_1B];
				var_11 = var_14.owner;
				if(var_11 != "allies" && var_11 != "axis")
				{
					continue;
				}

				var_15 = undefined;
				var_16 = undefined;
				var_17 = maps\mp\agents\_agents::add_humanoid_agent("player",var_11,"minion",var_15,var_16,undefined,0,0,"recruit");
				if(isdefined(var_17))
				{
					var_17 takeallweapons();
					var_18 = getdvarint("scr_twar_minionweapon",0);
					var_19 = "";
					switch(var_18)
					{
						case 2:
							break;

						case 1:
							break;

						case 0:
						default:
							break;
					}
				}
			}
		}
	}
}

//Function Number: 67
is_minion()
{
	return self hasperk("specialty_minion",1);
}

//Function Number: 68
hud_set_visible()
{
	self.alpha = 1;
}

//Function Number: 69
hud_set_invisible()
{
	self.alpha = 0;
}

//Function Number: 70
minion_max_hud()
{
	var_00 = maps\mp\gametypes\_hud_util::createserverfontstring("hudbig",1);
	var_00 maps\mp\gametypes\_hud_util::setpoint("BOTTOM",undefined,0,-20);
	var_00.label = &"MP_DOMAI_MINIONS_SPAWNED_MAX";
	var_00.color = (1,0,0);
	var_00.archived = 1;
	var_00.showinkillcam = 1;
	var_00.alpha = 0;
	return var_00;
}

//Function Number: 71
minion_count_hud(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_hud_util::createserverfontstring("hudbig",1,param_00);
	var_02 maps\mp\gametypes\_hud_util::setpoint("BOTTOM",undefined,0,common_scripts\utility::ter_op(param_00 == param_01,-40,-20));
	var_02.label = common_scripts\utility::ter_op(param_00 == param_01,&"MP_DOMAI_MINIONS_SPAWNED_FRIENDLY",&"MP_DOMAI_MINIONS_SPAWNED_ENEMY");
	var_02.color = common_scripts\utility::ter_op(param_00 == param_01,(0.157,0.392,0.784),(0.784,0.49,0.157));
	var_02.archived = 1;
	var_02.showinkillcam = 1;
	var_02.alpha = 0;
	return var_02;
}

//Function Number: 72
minion_spawn_timer_hud()
{
	var_00 = maps\mp\gametypes\_hud_util::createservertimer("hudbig",1);
	var_00 maps\mp\gametypes\_hud_util::setpoint("BOTTOM",undefined,0,-60);
	var_00.label = &"MP_DOMAI_MINIONS_SPAWN_TIMER";
	var_00.color = (1,1,1);
	var_00.archived = 1;
	var_00.showinkillcam = 1;
	return var_00;
}

//Function Number: 73
update_minion_hud_outlines()
{
	var_00 = [];
	var_01 = [];
	var_02 = getdvarint("scr_twar_minionoutline",0);
	foreach(var_04 in level.players)
	{
		if(var_04.team == "allies")
		{
			var_00[var_00.size] = var_04;
			continue;
		}

		var_01[var_01.size] = var_04;
	}

	foreach(var_07 in level.agentarray)
	{
		if(var_07 is_minion())
		{
			if(level.players.size > 0)
			{
				var_07 hudoutlinedisableforclients(level.players);
			}

			if(var_02)
			{
				if(var_00.size > 0)
				{
					var_07 hudoutlineenableforclients(var_00,common_scripts\utility::ter_op(var_07.team == "allies",2,3),1);
				}

				if(var_01.size > 0)
				{
					var_07 hudoutlineenableforclients(var_01,common_scripts\utility::ter_op(var_07.team == "axis",2,3),1);
				}
			}
		}
	}
}

//Function Number: 74
minion_ai()
{
	self endon("death");
	for(;;)
	{
		if(isdefined(level.twar_use_obj))
		{
			var_00 = level.twar_use_obj.trigger.origin;
			self botsetscriptgoal(var_00,level.zone_radius * 0.9,"objective");
		}

		wait(0.1);
	}
}

//Function Number: 75
getminioncount()
{
	var_00 = 0;
	foreach(var_02 in level.agentarray)
	{
		if(isdefined(var_02.isactive) && var_02.isactive && var_02.agent_type == "player" && var_02 is_minion())
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 76
minion_damage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isdefined(param_02) && isdefined(param_02.damage_scale))
	{
		param_03 = int(param_03 * param_02.damage_scale);
	}

	return param_03;
}

//Function Number: 77
on_minion_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isplayer(param_01) && is_minion() && param_01.team != self.team)
	{
		var_09 = getdvarfloat("scr_twar_score_kill_minion_multipler",0);
		if(var_09 > 0)
		{
			var_0A = getdvarfloat("scr_twar_score_kill_minion_base",10);
			var_0B = int(param_01.minionstreak * var_09 + var_0A);
			var_0B = min(var_0B,getdvarint("scr_twar_score_kill_minion_max",150));
			setdvar("scr_twar_score_kill_minion",var_0B);
		}

		param_01.minionstreak++;
		level thread maps\mp\gametypes\_rank::awardgameevent("kill_minion",param_01,param_04,self,param_03);
		if(isdefined(param_01))
		{
			add_kill_enemy_minion_momentum(param_01.team);
		}

		if(isdefined(self.team))
		{
			add_kill_friendly_minion_momentum(self.team);
		}
	}
}

//Function Number: 78
add_kill_enemy_minion_momentum(param_00)
{
	var_01 = getdvarfloat("scr_twar_momentum_kill_enemy_minion",0.1);
	add_momentum(param_00,var_01);
}

//Function Number: 79
add_kill_friendly_minion_momentum(param_00)
{
	var_01 = getdvarfloat("scr_twar_momentum_kill_friendly_minion",-0.1);
	add_momentum(param_00,var_01);
}

//Function Number: 80
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isplayer(param_01))
	{
		return;
	}

	if(maps\mp\gametypes\_damage::isfriendlyfire(self,param_01))
	{
		return;
	}

	if(param_01 == self)
	{
		return;
	}

	if(isdefined(param_04) && maps\mp\_utility::iskillstreakweapon(param_04))
	{
		return;
	}

	var_0A = 0;
	var_0B = self;
	foreach(var_0D in param_01.touchtriggers)
	{
		if(var_0D != level.twar_use_obj.trigger)
		{
			continue;
		}

		param_01 thread maps\mp\_events::killwhilecapture(var_0B,param_09);
		var_0A = 1;
		break;
	}

	if(!var_0A)
	{
		foreach(var_0D in var_0B.touchtriggers)
		{
			if(var_0D != level.twar_use_obj.trigger)
			{
				continue;
			}

			param_01 thread maps\mp\_events::assaultobjectiveevent(self,param_09);
		}
	}
}