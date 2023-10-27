/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\conf.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 15
 * Decompile Time: 276 ms
 * Timestamp: 10/27/2023 1:29:02 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(getdvar("mapname") == "mp_background")
	{
		return;
	}

	maps\mp\gametypes\_globallogic::func_44DF();
	maps\mp\gametypes\_callbacksetup::func_71F0();
	maps\mp\gametypes\_globallogic::func_71F0();
	if(isusingmatchrulesdata())
	{
		level.initializematchrules = ::initializematchrules;
		[[ level.initializematchrules ]]();
		level thread maps\mp\_utility::func_647E();
	}
	else
	{
		maps\mp\_utility::func_6473(level.gametype,0,0,9);
		maps\mp\_utility::func_6476(level.gametype,10);
		maps\mp\_utility::func_6475(level.gametype,65);
		maps\mp\_utility::func_6472(level.gametype,1);
		maps\mp\_utility::func_647C(level.gametype,1);
		maps\mp\_utility::func_6470(level.gametype,0);
		maps\mp\_utility::func_646A(level.gametype,0);
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
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	game["dialog"]["gametype"] = "kill_confirmed";
	game["dialog"]["kill_confirmed"] = "kill_confirmed";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	level.conf_fx["vanish"] = loadfx("fx/impacts/small_snowhit");
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_700A();
	setdynamicdvar("scr_conf_roundswitch",0);
	maps\mp\_utility::func_6473("conf",0,0,9);
	setdynamicdvar("scr_conf_roundlimit",1);
	maps\mp\_utility::func_6472("conf",1);
	setdynamicdvar("scr_conf_winlimit",1);
	maps\mp\_utility::func_647C("conf",1);
	setdynamicdvar("scr_conf_halftime",0);
	maps\mp\_utility::func_646A("conf",0);
	setdynamicdvar("scr_conf_promode",0);
}

//Function Number: 3
onprecachegametype()
{
	precachempanim("mp_dogtag_spin");
	precachematerial("waypoint_dogtags");
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

	maps\mp\_utility::func_7084("allies",&"OBJECTIVES_CONF");
	maps\mp\_utility::func_7084("axis",&"OBJECTIVES_CONF");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_CONF");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_CONF");
	}
	else
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_CONF_SCORE");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_CONF_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_CONF_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_CONF_HINT");
	initspawns();
	level.dogtags = [];
	var_02[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::func_4FDD(var_02);
}

//Function Number: 5
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 6
getspawnpoint()
{
	var_00 = self.pers["team"];
	if(game["switchedsides"])
	{
		var_00 = maps\mp\_utility::getotherteam(var_00);
	}

	if(maps\mp\gametypes\_spawnlogic::func_948D())
	{
		var_01 = maps\mp\gametypes\_spawnlogic::func_3BF6("mp_tdm_spawn_" + var_00 + "_start");
		var_02 = maps\mp\gametypes\_spawnlogic::func_3BF5(var_01);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::func_3C41(var_02);
		var_02 = maps\mp\gametypes\_spawnscoring::func_3BF1(var_02);
	}

	return var_02;
}

//Function Number: 7
onnormaldeath(param_00,param_01,param_02)
{
	level thread func_7868(param_00,param_01);
	if(game["state"] == "postgame" && game["teamScores"][param_01.team] > game["teamScores"][level.otherteam[param_01.team]])
	{
		param_01.finalkill = 1;
	}
}

//Function Number: 8
func_7868(param_00,param_01)
{
	if(param_00 maps\mp\killstreaks\_killstreaks::func_4994())
	{
	}

	var_02 = param_00.pers["team"];
	if(isdefined(level.dogtags[param_00.guid]))
	{
		playfx(level.conf_fx["vanish"],level.dogtags[param_00.guid].curorigin);
		level.dogtags[param_00.guid] notify("reset");
	}
	else
	{
		var_03[0] = spawn("script_model",(0,0,0));
		var_03[0] setmodel("prop_dogtags_foe_iw6");
		var_03[1] = spawn("script_model",(0,0,0));
		var_03[1] setmodel("prop_dogtags_friend_iw6");
		var_04 = spawn("trigger_radius",(0,0,0),0,32,32);
		level.dogtags[param_00.guid] = maps\mp\gametypes\_gameobjects::func_212D("any",var_04,var_03,(0,0,16));
		maps\mp\_utility::_objective_delete(level.dogtags[param_00.guid].teamobjids["allies"]);
		maps\mp\_utility::_objective_delete(level.dogtags[param_00.guid].teamobjids["axis"]);
		maps\mp\gametypes\_objpoints::deleteobjpoint(level.dogtags[param_00.guid].objpoints["allies"]);
		maps\mp\gametypes\_objpoints::deleteobjpoint(level.dogtags[param_00.guid].objpoints["axis"]);
		level.dogtags[param_00.guid] maps\mp\gametypes\_gameobjects::func_720E(0);
		level.dogtags[param_00.guid].onuse = ::onuse;
		level.dogtags[param_00.guid].victim = param_00;
		level.dogtags[param_00.guid].victimteam = var_02;
		level.dogtags[param_00.guid].objid = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(level.dogtags[param_00.guid].objid,"invisible",(0,0,0));
		objective_icon(level.dogtags[param_00.guid].objid,"waypoint_dogtags");
		level thread clearonvictimdisconnect(param_00);
		param_00 thread func_7E72(level.dogtags[param_00.guid]);
	}

	var_05 = param_00.origin + (0,0,14);
	level.dogtags[param_00.guid].curorigin = var_05;
	level.dogtags[param_00.guid].trigger.origin = var_05;
	level.dogtags[param_00.guid].visuals[0].origin = var_05;
	level.dogtags[param_00.guid].visuals[1].origin = var_05;
	level.dogtags[param_00.guid] maps\mp\gametypes\_gameobjects::func_4629();
	level.dogtags[param_00.guid] maps\mp\gametypes\_gameobjects::allowuse("any");
	level.dogtags[param_00.guid].visuals[0] thread func_752A(level.dogtags[param_00.guid],maps\mp\_utility::getotherteam(var_02));
	level.dogtags[param_00.guid].visuals[1] thread func_752A(level.dogtags[param_00.guid],var_02);
	level.dogtags[param_00.guid].attacker = param_01;
	if(isplayer(param_01))
	{
		objective_position(level.dogtags[param_00.guid].objid,var_05);
		objective_state(level.dogtags[param_00.guid].objid,"active");
		objective_player(level.dogtags[param_00.guid].objid,param_01 getentitynumber());
	}

	playsoundatpos(var_05,"mp_killconfirm_tags_drop");
	level notify("new_tag_spawned",level.dogtags[param_00.guid]);
	level.dogtags[param_00.guid].visuals[0] scriptmodelplayanim("mp_dogtag_spin");
	level.dogtags[param_00.guid].visuals[1] scriptmodelplayanim("mp_dogtag_spin");
}

//Function Number: 9
func_752A(param_00,param_01)
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

			if(param_00.victimteam == var_03.team && var_03 == param_00.attacker)
			{
				objective_state(param_00.objid,"invisible");
			}
		}
	}
}

//Function Number: 10
onuse(param_00)
{
	if(isdefined(param_00.owner))
	{
		param_00 = param_00.owner;
	}

	param_00 maps\mp\_events::giveobjectivepointstreaks();
	var_01 = param_00.pers["team"];
	if(var_01 == self.victimteam)
	{
		self.trigger playsound("mp_killconfirm_tags_deny");
		param_00 maps\mp\_utility::func_447B("killsdenied",1);
		param_00 maps\mp\_utility::func_4479("denied",1);
		param_00 maps\mp\gametypes\_persistence::func_7B28("round","denied",param_00.pers["denied"]);
		if(isplayer(param_00))
		{
			param_00 maps\mp\_utility::setextrascore0(param_00.pers["confirmed"] + param_00.pers["denied"]);
		}

		if(self.victim == param_00)
		{
			var_02 = "tags_retrieved";
		}
		else
		{
			var_02 = "kill_denied";
		}

		if(isdefined(self.attacker))
		{
			self.attacker thread maps\mp\gametypes\_rank::func_8E6E("kill_denied");
		}

		param_00 thread onpickup(var_02);
		param_00 maps\mp\gametypes\_missions::func_61CE("ch_denier");
	}
	else
	{
		self.trigger playsound("mp_killconfirm_tags_pickup");
		var_02 = "kill_confirmed";
		param_00 maps\mp\_utility::func_447B("killsconfirmed",1);
		param_00 maps\mp\_utility::func_4479("confirmed",1);
		param_00 maps\mp\gametypes\_persistence::func_7B28("round","confirmed",param_00.pers["confirmed"]);
		if(self.attacker != param_00)
		{
			self.attacker thread onpickup(var_02);
		}

		param_00 onpickup(var_02);
		if(isplayer(param_00))
		{
			param_00 maps\mp\_utility::func_4D35("kill_confirmed");
			param_00 maps\mp\_utility::setextrascore0(param_00.pers["confirmed"] + param_00.pers["denied"]);
		}

		param_00 maps\mp\gametypes\_missions::func_61CE("ch_collector");
		param_00 maps\mp\gametypes\_gamescore::giveteamscoreforobjective(var_01,1);
	}

	func_661E();
}

//Function Number: 11
onpickup(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	while(!isdefined(self.pers))
	{
		wait(0.05);
	}

	thread maps\mp\gametypes\_rank::func_8E6E(param_00);
	maps\mp\gametypes\_gamescore::func_3D00(param_00,self,undefined,1);
	thread maps\mp\gametypes\_rank::giverankxp(param_00);
}

//Function Number: 12
func_661E()
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

//Function Number: 13
func_7E72(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		param_00.victimteam = self.pers["team"];
		param_00 func_661E();
	}
}

//Function Number: 14
clearonvictimdisconnect(param_00)
{
	level endon("game_ended");
	var_01 = param_00.guid;
	param_00 waittill("disconnect");
	if(isdefined(level.dogtags[var_01]))
	{
		level.dogtags[var_01] maps\mp\gametypes\_gameobjects::allowuse("none");
		if(isdefined(level.dogtags[var_01].attacker))
		{
			level.dogtags[var_01].attacker thread maps\mp\gametypes\_rank::func_8E6E("kill_denied");
		}

		playfx(level.conf_fx["vanish"],level.dogtags[var_01].curorigin);
		level.dogtags[var_01] notify("reset");
		wait(0.05);
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

//Function Number: 15
initgametypeawards()
{
}