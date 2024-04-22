/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\sr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 257 ms
 * Timestamp: 4/22/2024 2:11:06 AM
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
		maps\mp\_utility::registerroundswitchdvar(level.gametype,3,0,9);
		maps\mp\_utility::registertimelimitdvar(level.gametype,2.5);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,1);
		maps\mp\_utility::registerroundlimitdvar(level.gametype,0);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,4);
		maps\mp\_utility::registernumlivesdvar(level.gametype,1);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	level.assists_disabled = 1;
	level.objectivebased = 1;
	level.teambased = 1;
	level.nobuddyspawns = 1;
	level.onprecachegametype = ::maps\mp\gametypes\common_sd_sr::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	level.onplayerkilled = ::onplayerkilled;
	level.ondeadevent = ::maps\mp\gametypes\common_sd_sr::ondeadevent;
	level.ononeleftevent = ::maps\mp\gametypes\common_sd_sr::ononeleftevent;
	level.ontimelimit = ::maps\mp\gametypes\common_sd_sr::ontimelimit;
	level.onnormaldeath = ::maps\mp\gametypes\common_sd_sr::onnormaldeath;
	level.gamemodemaydropweapon = ::maps\mp\gametypes\common_sd_sr::isplayeroutsideofanybombsite;
	level.allowlatecomers = 0;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	game["dialog"]["gametype"] = "sr_intro";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	game["dialog"]["offense_obj"] = "obj_destroy";
	game["dialog"]["defense_obj"] = "obj_defend";
	game["dialog"]["lead_lost"] = "null";
	game["dialog"]["lead_tied"] = "null";
	game["dialog"]["lead_taken"] = "null";
	game["dialog"]["kill_confirmed"] = "kc_killconfirmed";
	game["dialog"]["revived"] = "sr_rev";
	if(maps\mp\_utility::isgrapplinghookgamemode())
	{
		game["dialog"]["gametype"] = "grap_" + game["dialog"]["gametype"];
	}

	setomnvar("ui_bomb_timer_endtime",0);
	level.conf_fx["vanish"] = loadfx("fx/impacts/small_snowhit");
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	var_00 = getmatchrulesdata("srData","roundLength");
	setdynamicdvar("scr_sr_timelimit",var_00);
	maps\mp\_utility::registertimelimitdvar("sr",var_00);
	var_01 = getmatchrulesdata("srData","roundSwitch");
	setdynamicdvar("scr_sr_roundswitch",var_01);
	maps\mp\_utility::registerroundswitchdvar("sr",var_01,0,9);
	var_02 = getmatchrulesdata("commonOption","scoreLimit");
	setdynamicdvar("scr_sr_winlimit",var_02);
	maps\mp\_utility::registerwinlimitdvar("sr",var_02);
	setdynamicdvar("scr_sr_bombtimer",getmatchrulesdata("srData","bombTimer"));
	setdynamicdvar("scr_sr_planttime",getmatchrulesdata("srData","plantTime"));
	setdynamicdvar("scr_sr_defusetime",getmatchrulesdata("srData","defuseTime"));
	setdynamicdvar("scr_sr_multibomb",getmatchrulesdata("srData","multiBomb"));
	setdynamicdvar("scr_sr_silentplant",getmatchrulesdata("srData","silentPlant"));
	setdynamicdvar("scr_sr_roundlimit",0);
	maps\mp\_utility::registerroundlimitdvar("sr",0);
	setdynamicdvar("scr_sr_scorelimit",1);
	maps\mp\_utility::registerscorelimitdvar("sr",1);
	setdynamicdvar("scr_sr_halftime",0);
	maps\mp\_utility::registerhalftimedvar("sr",0);
}

//Function Number: 3
onstartgametype()
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
	level._effect["bomb_explosion"] = loadfx("vfx/explosion/mp_gametype_bomb");
	level._effect["bomb_light_blinking"] = loadfx("vfx/lights/light_sdbomb_blinking");
	level._effect["bomb_light_planted"] = loadfx("vfx/lights/light_beacon_sdbomb");
	maps\mp\_utility::setobjectivetext(game["attackers"],&"OBJECTIVES_SD_ATTACKER");
	maps\mp\_utility::setobjectivetext(game["defenders"],&"OBJECTIVES_SD_DEFENDER");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"],&"OBJECTIVES_SD_ATTACKER");
		maps\mp\_utility::setobjectivescoretext(game["defenders"],&"OBJECTIVES_SD_DEFENDER");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"],&"OBJECTIVES_SD_ATTACKER_SCORE");
		maps\mp\_utility::setobjectivescoretext(game["defenders"],&"OBJECTIVES_SD_DEFENDER_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext(game["attackers"],&"OBJECTIVES_SD_ATTACKER_HINT");
	maps\mp\_utility::setobjectivehinttext(game["defenders"],&"OBJECTIVES_SD_DEFENDER_HINT");
	initspawns();
	var_02[0] = "sd";
	var_02[1] = "bombzone";
	var_02[2] = "blocker";
	maps\mp\gametypes\_gameobjects::main(var_02);
	maps\mp\gametypes\common_sd_sr::updategametypedvars();
	level.dogtags = [];
	maps\mp\gametypes\common_sd_sr::setspecialloadout();
	thread maps\mp\gametypes\common_sd_sr::bombs();
}

//Function Number: 4
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sd_spawn_attacker");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sd_spawn_defender");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("attacker","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("defender","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 5
getspawnpoint()
{
	var_00 = "defender";
	if(self.pers["team"] == game["attackers"])
	{
		var_00 = "attacker";
	}

	if(maps\mp\gametypes\_spawnlogic::shoulduseteamstartspawn())
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_sd_spawn_" + var_00);
		var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_startspawn(var_01);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_02);
		var_02 = maps\mp\gametypes\_spawnscoring::getspawnpoint_searchandrescue(var_02);
	}

	maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_02);
	return var_02;
}

//Function Number: 6
onspawnplayer()
{
	var_00 = isdefined(self.isrespawningwithbombcarrierclass) && self.isrespawningwithbombcarrierclass;
	self.isplanting = 0;
	self.isdefusing = 0;
	if(!var_00)
	{
		self.isbombcarrier = 0;
		self.objective = 0;
	}

	if(isplayer(self) && !var_00)
	{
		if(level.multibomb && self.pers["team"] == game["attackers"])
		{
			self setclientomnvar("ui_carrying_bomb",1);
		}
		else
		{
			self setclientomnvar("ui_carrying_bomb",0);
		}
	}

	self.isrespawningwithbombcarrierclass = undefined;
	level notify("spawned_player");
	if(self.sessionteam == "axis" || self.sessionteam == "allies")
	{
		level notify("sr_player_joined",self);
		maps\mp\_utility::setextrascore0(0);
		if(isdefined(self.pers["plants"]))
		{
			maps\mp\_utility::setextrascore0(self.pers["plants"]);
		}

		maps\mp\_utility::setextrascore1(0);
		if(isdefined(self.pers["defuses"]))
		{
			maps\mp\_utility::setextrascore1(self.pers["defuses"]);
		}

		self.assists = 0;
		if(isdefined(self.pers["denied"]))
		{
			self.assists = self.pers["denied"];
		}
	}
}

//Function Number: 7
shouldspawntags(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(self.switching_teams))
	{
		return 0;
	}

	if(isdefined(self.wasswitchingteamsforonplayerkilled))
	{
		return 0;
	}

	if(isdefined(param_01) && param_01 == self)
	{
		return 0;
	}

	if(level.teambased && isdefined(param_01) && isdefined(param_01.team) && param_01.team == self.team)
	{
		return 0;
	}

	if(isdefined(param_01) && !isdefined(param_01.team) && param_01.classname == "trigger_hurt" || param_01.classname == "worldspawn")
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isplayer(self))
	{
		self setclientomnvar("ui_carrying_bomb",0);
	}

	if(!maps\mp\_utility::gameflag("prematch_done"))
	{
		maps\mp\gametypes\_playerlogic::mayspawn();
	}
	else
	{
		var_0A = shouldspawntags(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
		if(var_0A)
		{
			var_0A = var_0A && !maps\mp\_utility::isreallyalive(self);
		}

		if(var_0A)
		{
			var_0A = var_0A && !maps\mp\gametypes\_playerlogic::mayspawn();
		}

		if(var_0A)
		{
			level thread spawndogtags(self,param_01);
		}
	}

	thread maps\mp\gametypes\common_sd_sr::checkallowspectating();
}

//Function Number: 9
spawndogtags(param_00,param_01)
{
	if(isagent(param_00))
	{
		return;
	}

	if(isagent(param_01))
	{
		param_01 = param_01.owner;
	}

	var_02 = param_00.origin + (0,0,14);
	if(isdefined(level.dogtags[param_00.guid]))
	{
		playfx(level.conf_fx["vanish"],level.dogtags[param_00.guid].curorigin);
		level.dogtags[param_00.guid] notify("reset");
	}
	else
	{
		var_03[0] = spawn("script_model",(0,0,0));
		var_03[0] setclientowner(param_00);
		var_03[0] setmodel("prop_dogtags_future_enemy_animated");
		var_03[0] method_856C(1);
		var_03[1] = spawn("script_model",(0,0,0));
		var_03[1] setclientowner(param_00);
		var_03[1] setmodel("prop_dogtags_future_friend_animated");
		var_03[1] method_856C(1);
		var_04 = spawn("trigger_radius",(0,0,0),0,32,32);
		level.dogtags[param_00.guid] = maps\mp\gametypes\_gameobjects::createuseobject("any",var_04,var_03,(0,0,16));
		maps\mp\gametypes\_objpoints::deleteobjpoint(level.dogtags[param_00.guid].objpoints["allies"]);
		maps\mp\gametypes\_objpoints::deleteobjpoint(level.dogtags[param_00.guid].objpoints["axis"]);
		maps\mp\gametypes\_objpoints::deleteobjpoint(level.dogtags[param_00.guid].objpoints["mlg"]);
		level.dogtags[param_00.guid] maps\mp\gametypes\_gameobjects::setusetime(0);
		level.dogtags[param_00.guid].onuse = ::onuse;
		level.dogtags[param_00.guid].victim = param_00;
		level.dogtags[param_00.guid].victimteam = param_00.team;
		level thread clearonvictimdisconnect(param_00);
		param_00 thread tagteamupdater(level.dogtags[param_00.guid]);
	}

	level.dogtags[param_00.guid].curorigin = var_02;
	level.dogtags[param_00.guid].trigger.origin = var_02;
	level.dogtags[param_00.guid].visuals[0].origin = var_02;
	level.dogtags[param_00.guid].visuals[1].origin = var_02;
	level.dogtags[param_00.guid] maps\mp\gametypes\_gameobjects::initializetagpathvariables();
	level.dogtags[param_00.guid] maps\mp\gametypes\_gameobjects::allowuse("any");
	level.dogtags[param_00.guid].visuals[0] thread showtoteam(level.dogtags[param_00.guid],maps\mp\_utility::getotherteam(param_00.team));
	level.dogtags[param_00.guid].visuals[1] thread showtoteam(level.dogtags[param_00.guid],param_00.team);
	level.dogtags[param_00.guid].attacker = param_01;
	if(param_00.team == "axis")
	{
		objective_icon(level.dogtags[param_00.guid].objidaxis,"waypoint_dogtags_friendlys");
		objective_team(level.dogtags[param_00.guid].objidaxis,"axis");
		objective_icon(level.dogtags[param_00.guid].objidallies,"waypoint_dogtags");
		objective_team(level.dogtags[param_00.guid].objidallies,"allies");
	}
	else
	{
		objective_icon(level.dogtags[param_00.guid].objidallies,"waypoint_dogtags_friendlys");
		objective_team(level.dogtags[param_00.guid].objidallies,"allies");
		objective_icon(level.dogtags[param_00.guid].objidaxis,"waypoint_dogtags");
		objective_team(level.dogtags[param_00.guid].objidaxis,"axis");
	}

	objective_position(level.dogtags[param_00.guid].objidallies,var_02);
	objective_position(level.dogtags[param_00.guid].objidaxis,var_02);
	objective_state(level.dogtags[param_00.guid].objidallies,"active");
	objective_state(level.dogtags[param_00.guid].objidaxis,"active");
	playsoundatpos(var_02,"mp_killconfirm_tags_drop");
	level notify("sr_player_killed",param_00);
	param_00.tagavailable = 1;
	param_00.objective = 3;
	level.dogtags[param_00.guid].visuals[0] scriptmodelplayanim("mp_dogtag_spin");
	level.dogtags[param_00.guid].visuals[1] scriptmodelplayanim("mp_dogtag_spin");
}

//Function Number: 10
showtoteam(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("reset");
	self hide();
	foreach(var_03 in level.players)
	{
		if(var_03.team == param_01)
		{
			self showtoplayer(var_03);
		}

		if(var_03.team == "spectator" && param_01 == "allies")
		{
			self showtoplayer(var_03);
		}
	}

	for(;;)
	{
		level waittill("joined_team");
		self hide();
		foreach(var_03 in level.players)
		{
			if(var_03.team == param_01)
			{
				self showtoplayer(var_03);
			}

			if(var_03.team == "spectator" && param_01 == "allies")
			{
				self showtoplayer(var_03);
			}
		}
	}
}

//Function Number: 11
sr_respawn()
{
	maps\mp\gametypes\_playerlogic::incrementalivecount(self.team);
	self.alreadyaddedtoalivecount = 1;
	thread waitillcanspawnclient();
}

//Function Number: 12
waitillcanspawnclient()
{
	self endon("started_spawnPlayer");
	for(;;)
	{
		wait(0.05);
		if(isdefined(self) && self.sessionstate == "spectator" || !maps\mp\_utility::isreallyalive(self))
		{
			self.pers["lives"] = 1;
			maps\mp\gametypes\_playerlogic::spawnclient();
			continue;
		}
	}
}

//Function Number: 13
onuse(param_00)
{
	if(isdefined(param_00.owner))
	{
		param_00 = param_00.owner;
	}

	if(param_00.pers["team"] == self.victimteam)
	{
		self.trigger playsound("mp_snd_ally_revive");
		param_00 thread maps\mp\_events::revivetagevent(self.victim);
		if(isdefined(self.victim))
		{
			level notify("sr_player_respawned",self.victim);
			self.victim maps\mp\_utility::leaderdialogonplayer("revived");
		}

		if(isdefined(self.victim))
		{
			if(!level.gameended)
			{
				self.victim thread sr_respawn();
			}
		}

		param_00 maps\mp\gametypes\_missions::processchallenge("ch_rescuer");
		if(!isdefined(param_00.rescuedplayers))
		{
			param_00.rescuedplayers = [];
		}

		param_00.rescuedplayers[self.victim.guid] = 1;
		if(param_00.rescuedplayers.size == 4)
		{
			param_00 maps\mp\gametypes\_missions::processchallenge("ch_helpme");
		}
	}
	else
	{
		self.trigger playsound("mp_killconfirm_tags_pickup");
		param_00 thread maps\mp\_events::eliminatetagevent();
		if(isdefined(self.victim))
		{
			if(!level.gameended)
			{
				self.victim maps\mp\_utility::setlowermessage("spawn_info",game["strings"]["spawn_next_round"]);
				self.victim thread maps\mp\gametypes\_playerlogic::removespawnmessageshortly(3);
			}

			self.victim.tagavailable = undefined;
		}

		param_00 maps\mp\_utility::leaderdialogonplayer("kill_confirmed");
		param_00 maps\mp\gametypes\_missions::processchallenge("ch_hideandseek");
	}

	self.victim.objective = 0;
	level thread maps\mp\_events::monitortagcollector(param_00);
	resettags();
}

//Function Number: 14
resettags()
{
	self.attacker = undefined;
	self notify("reset");
	self.visuals[0] hide();
	self.visuals[1] hide();
	self.curorigin = (0,0,1000);
	self.trigger.origin = (0,0,1000);
	self.visuals[0].origin = (0,0,1000);
	self.visuals[1].origin = (0,0,1000);
	maps\mp\gametypes\_gameobjects::allowuse("none");
	objective_state(self.objidallies,"invisible");
	objective_state(self.objidaxis,"invisible");
}

//Function Number: 15
tagteamupdater(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		param_00.victimteam = self.pers["team"];
		param_00 resettags();
	}
}

//Function Number: 16
clearonvictimdisconnect(param_00)
{
	level endon("game_ended");
	var_01 = param_00.guid;
	param_00 waittill("disconnect");
	if(isdefined(level.dogtags[var_01]))
	{
		level.dogtags[var_01] maps\mp\gametypes\_gameobjects::allowuse("none");
		playfx(level.conf_fx["vanish"],level.dogtags[var_01].curorigin);
		level.dogtags[var_01] notify("reset");
		wait(0.05);
		if(isdefined(level.dogtags[var_01]))
		{
			objective_delete(level.dogtags[var_01].objidallies);
			objective_delete(level.dogtags[var_01].objidallies);
			level.dogtags[var_01].trigger delete();
			for(var_02 = 0;var_02 < level.dogtags[var_01].visuals.size;var_02++)
			{
				level.dogtags[var_01].visuals[var_02] delete();
			}

			level.dogtags[var_01] notify("deleted");
			level.dogtags[var_01] = undefined;
		}
	}
}