/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\conf.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 16
 * Decompile Time: 226 ms
 * Timestamp: 10/27/2023 2:26:03 AM
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
		maps\mp\_utility::func_330E(level.gametype,0,0,9);
		maps\mp\_utility::func_3315(level.gametype,10);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,65);
		maps\mp\_utility::func_3312(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::func_3317(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	level.teambased = 1;
	level.initgametypeawards = ::initgametypeawards;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onnormaldeath = ::onnormaldeath;
	level.onprecachegametype = ::onprecachegametype;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::func_2D57;
	}

	game["dialog"]["gametype"] = "kill_confirmed";
	level.conf_fx["vanish"] = loadfx("impacts/small_snowhit");
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_334C();
	setdynamicdvar("scr_conf_roundswitch",0);
	maps\mp\_utility::func_330E("conf",0,0,9);
	setdynamicdvar("scr_conf_roundlimit",1);
	maps\mp\_utility::func_3312("conf",1);
	setdynamicdvar("scr_conf_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("conf",1);
	setdynamicdvar("scr_conf_halftime",0);
	maps\mp\_utility::registerhalftimedvar("conf",0);
	setdynamicdvar("scr_conf_promode",0);
}

//Function Number: 3
onprecachegametype()
{
	precachemodel("prop_dogtags_friend");
	precachemodel("prop_dogtags_foe");
	precacheshader("waypoint_dogtags");
}

//Function Number: 4
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

	maps\mp\_utility::func_3305("allies",&"OBJECTIVES_CONF");
	maps\mp\_utility::func_3305("axis",&"OBJECTIVES_CONF");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_CONF");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_CONF");
	}
	else
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_CONF_SCORE");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_CONF_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_CONF_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_CONF_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_tdm_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_tdm_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::func_2FD0("allies","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::func_2FD0("axis","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::func_2FCD(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	maps\mp\gametypes\_rank::registerscoreinfo("kill",50);
	maps\mp\gametypes\_rank::registerscoreinfo("kill_confirmed",50);
	maps\mp\gametypes\_rank::registerscoreinfo("kill_denied",50);
	maps\mp\gametypes\_rank::registerscoreinfo("tags_retrieved",250);
	level.dogtags = [];
	var_02[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::main(var_02);
}

//Function Number: 5
getspawnpoint()
{
	var_00 = self.pers["team"];
	if(game["switchedsides"])
	{
		var_00 = maps\mp\_utility::getotherteam(var_00);
	}

	if(level.ingraceperiod)
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var_00 + "_start");
		var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_01);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_02);
		var_02 = maps\mp\gametypes\_spawnlogic::func_2FE6(var_02);
	}

	return var_02;
}

//Function Number: 6
onnormaldeath(param_00,param_01,param_02)
{
	level thread func_3546(param_00,param_01);
	if(game["state"] == "postgame" && game["teamScores"][param_01.team] > game["teamScores"][level.otherteam[param_01.team]])
	{
		param_01.finalkill = 1;
	}
}

//Function Number: 7
func_3546(param_00,param_01)
{
	if(isdefined(level.dogtags[param_00.guid]))
	{
		playfx(level.conf_fx["vanish"],level.dogtags[param_00.guid].curorigin);
		level.dogtags[param_00.guid] notify("reset");
	}
	else
	{
		var_02[0] = spawn("script_model",(0,0,0));
		var_02[0] setmodel("prop_dogtags_foe");
		var_41[1] setmodel("prop_dogtags_friend");
		var_03 = spawn("trigger_radius",(0,0,0),0,32,32);
		level.dogtags[param_01.guid] = maps\mp\gametypes\_gameobjects::func_29E7("any",var_03,var_41,(0,0,16));
		maps\mp\_utility::_objective_delete(level.dogtags[param_01.guid].objidallies);
		maps\mp\_utility::_objective_delete(level.dogtags[param_01.guid].objidaxis);
		maps\mp\gametypes\_objpoints::deleteobjpoint(level.dogtags[param_01.guid].objpoints["allies"]);
		maps\mp\gametypes\_objpoints::deleteobjpoint(level.dogtags[param_01.guid].objpoints["axis"]);
		level.dogtags[param_01.guid] maps\mp\gametypes\_gameobjects::setusetime(0);
		level.dogtags[param_01.guid].onuse = ::onuse;
		level.dogtags[param_01.guid].victim = param_01;
		level.dogtags[param_01.guid].victimteam = param_01.pers["team"];
		level.dogtags[param_01.guid].objid = maps\mp\gametypes\_gameobjects::func_2A31();
		objective_add(level.dogtags[param_01.guid].objid,"invisible",(0,0,0));
		objective_icon(level.dogtags[param_01.guid].objid,"waypoint_dogtags");
		level thread func_354A(param_01);
		param_01 thread tagteamupdater(level.dogtags[param_01.guid]);
	}

	var_04 = param_01.origin + (0,0,14);
	level.dogtags[param_01.guid].curorigin = var_04;
	level.dogtags[param_01.guid].trigger.origin = var_04;
	level.dogtags[param_01.guid].visuals[0].origin = var_04;
	level.dogtags[param_01.guid].visuals[1].origin = var_04;
	level.dogtags[param_01.guid] maps\mp\gametypes\_gameobjects::allowuse("any");
	level.dogtags[param_01.guid].visuals[0] thread func_3548(level.dogtags[param_01.guid],maps\mp\_utility::getotherteam(param_01.pers["team"]));
	level.dogtags[param_01.guid].visuals[1] thread func_3548(level.dogtags[param_01.guid],param_01.pers["team"]);
	level.dogtags[param_01.guid].attacker = var_02;
	objective_position(level.dogtags[param_01.guid].objid,var_04);
	objective_state(level.dogtags[param_01.guid].objid,"active");
	objective_player(level.dogtags[param_01.guid].objid,var_02 getentitynumber());
	playsoundatpos(var_04,"mp_killconfirm_tags_drop");
	level.dogtags[param_01.guid] thread func_3549();
}

//Function Number: 8
func_3548(param_00,param_01)
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

			if(param_00.victimteam == var_03.team && var_03 == param_00.attacker)
			{
				objective_state(param_00.objid,"invisible");
			}
		}
	}
}

//Function Number: 9
onuse(param_00)
{
	if(param_00.pers["team"] == self.victimteam)
	{
		self.trigger playsound("mp_killconfirm_tags_deny");
		param_00 maps\mp\_utility::incplayerstat("killsdenied",1);
		param_00 maps\mp\_utility::func_26FB("denied",1);
		param_00 maps\mp\gametypes\_persistence::func_26D8("round","denied",param_00.pers["denied"]);
		if(self.victim == param_00)
		{
			var_01 = "tags_retrieved";
			var_02 = &"SPLASHES_TAGS_RETRIEVED";
		}
		else
		{
			var_01 = "kill_denied";
			var_02 = &"SPLASHES_KILL_DENIED";
		}

		if(isdefined(self.attacker))
		{
			self.attacker thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_DENIED_KILL",(1,0.5,0.5));
		}
	}
	else
	{
		self.trigger playsound("mp_killconfirm_tags_pickup");
		var_01 = "kill_confirmed";
		var_02 = &"SPLASHES_KILL_CONFIRMED";
		param_00 maps\mp\_utility::incplayerstat("killsconfirmed",1);
		param_00 maps\mp\_utility::func_26FB("confirmed",1);
		param_00 maps\mp\gametypes\_persistence::func_26D8("round","confirmed",param_00.pers["confirmed"]);
		if(self.attacker != param_00)
		{
			self.attacker thread onpickup(var_01,var_02);
		}

		self.trigger playsoundtoplayer(game["voice"][param_00.team] + "kill_confirmed",param_00);
		param_00 maps\mp\gametypes\_gamescore::giveteamscoreforobjective(param_00.pers["team"],1);
	}

	param_00 thread onpickup(var_01,var_02);
	resettags();
}

//Function Number: 10
onpickup(param_00,param_01)
{
	level endon("game_ended");
	self endon("disconnect");
	while(!isdefined(self.pers))
	{
		wait 0.05;
	}

	thread maps\mp\gametypes\_rank::xpeventpopup(param_01);
	maps\mp\gametypes\_gamescore::func_26D3(param_00,self,undefined,1);
	thread maps\mp\gametypes\_rank::func_2AB3(param_00);
}

//Function Number: 11
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
	objective_state(self.objid,"invisible");
}

//Function Number: 12
func_3549()
{
	level endon("game_ended");
	self endon("reset");
	var_00 = self.curorigin;
	var_01 = self.curorigin + (0,0,12);
	for(;;)
	{
		self.visuals[0] moveto(var_01,0.5,0.15,0.15);
		self.visuals[0] rotateyaw(180,0.5);
		self.visuals[1] moveto(var_01,0.5,0.15,0.15);
		self.visuals[1] rotateyaw(180,0.5);
		wait 0.5;
		self.visuals[0] moveto(var_00,0.5,0.15,0.15);
		self.visuals[0] rotateyaw(180,0.5);
		self.visuals[1] moveto(var_00,0.5,0.15,0.15);
		self.visuals[1] rotateyaw(180,0.5);
		wait 0.5;
	}
}

//Function Number: 13
timeout(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	self notify("timeout");
	self endon("timeout");
	level maps\mp\gametypes\_hostmigration::func_2740(30);
	self.visuals[0] hide();
	self.visuals[1] hide();
	self.curorigin = (0,0,1000);
	self.trigger.origin = (0,0,1000);
	self.visuals[0].origin = (0,0,1000);
	self.visuals[1].origin = (0,0,1000);
	maps\mp\gametypes\_gameobjects::allowuse("none");
}

//Function Number: 14
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

//Function Number: 15
func_354A(param_00)
{
	level endon("game_ended");
	var_01 = param_00.guid;
	param_00 waittill("disconnect");
	if(isdefined(level.dogtags[var_01]))
	{
		level.dogtags[var_01] maps\mp\gametypes\_gameobjects::allowuse("none");
		if(isdefined(level.dogtags[var_01].attacker))
		{
			level.dogtags[var_01].attacker thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_DENIED_KILL",(1,0.5,0.5));
		}

		playfx(level.conf_fx["vanish"],level.dogtags[var_01].curorigin);
		level.dogtags[var_01] notify("reset");
		wait 0.05;
		if(isdefined(level.dogtags[var_01]))
		{
			objective_delete(level.dogtags[var_01].objid);
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

//Function Number: 16
initgametypeawards()
{
}