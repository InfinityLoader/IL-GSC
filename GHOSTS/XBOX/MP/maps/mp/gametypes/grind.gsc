/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\grind.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 27
 * Decompile Time: 472 ms
 * Timestamp: 10/27/2023 1:29:08 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
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
		maps\mp\_utility::func_6475(level.gametype,500);
		maps\mp\_utility::func_6472(level.gametype,1);
		maps\mp\_utility::func_647C(level.gametype,1);
		maps\mp\_utility::func_6470(level.gametype,0);
		maps\mp\_utility::func_646A(level.gametype,0);
	}

	level.teambased = 1;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onnormaldeath = ::onnormaldeath;
	level.onprecachegametype = ::onprecachegametype;
	level.var_5976 = ::func_5976;
}

//Function Number: 2
onprecachegametype()
{
	level.flagbasefxid["friendly"] = loadfx("vfx/gameplay/mp/core/vfx_marker_base_cyan");
}

//Function Number: 3
initializematchrules()
{
	maps\mp\_utility::func_700A();
	setdynamicdvar("scr_grind_roundswitch",0);
	maps\mp\_utility::func_6473("grind",0,0,9);
	setdynamicdvar("scr_grind_roundlimit",1);
	maps\mp\_utility::func_6472("grind",1);
	setdynamicdvar("scr_grind_winlimit",1);
	maps\mp\_utility::func_647C("grind",1);
	setdynamicdvar("scr_grind_halftime",0);
	maps\mp\_utility::func_646A("grind",0);
	setdynamicdvar("scr_grind_promode",0);
}

//Function Number: 4
onstartgametype()
{
	setclientnamemode("auto_change");
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	maps\mp\_utility::func_7084("allies",&"OBJECTIVES_WAR");
	maps\mp\_utility::func_7084("axis",&"OBJECTIVES_WAR");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_WAR");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_WAR");
	}
	else
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_WAR_SCORE");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_WAR_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_WAR_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_WAR_HINT");
	initspawns();
	createtags();
	var_00[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::func_4FDD(var_00);
	createzones();
	level thread func_595D();
	level thread func_69BD();
	level thread removetagsongameended();
}

//Function Number: 5
func_5976()
{
	if(isdefined(self.tagscarried))
	{
		self setclientomnvar("ui_grind_tags",self.tagscarried);
	}
}

//Function Number: 6
createtags()
{
	level.dogtags = [];
	for(var_00 = 0;var_00 < 50;var_00++)
	{
		var_01 = spawn("script_model",(0,0,0));
		var_01 setmodel("prop_dogtags_foe_iw6");
		var_01.baseorigin = var_01.origin;
		var_01 scriptmodelplayanim("mp_dogtag_spin");
		var_01 hide();
		var_02 = spawn("trigger_radius",(0,0,0),0,32,32);
		var_02.targetname = "trigger_dogtag";
		var_02 hide();
		var_03 = addstruct();
		var_03.type = "useObject";
		var_03.curorigin = var_02.origin;
		var_03.entnum = var_02 getentitynumber();
		var_03.lastusedtime = 0;
		var_03.visual = var_01;
		var_03.offset3d = (0,0,16);
		var_03.trigger = var_02;
		var_03.triggertype = "proximity";
		var_03 maps\mp\gametypes\_gameobjects::allowuse("none");
		level.dogtags[level.dogtags.size] = var_03;
	}
}

//Function Number: 7
func_3C1E()
{
	var_00 = level.dogtags[0];
	var_01 = gettime();
	foreach(var_03 in level.dogtags)
	{
		if(var_03.interactteam == "none")
		{
			var_00 = var_03;
			break;
		}

		if(var_03.lastusedtime < var_01)
		{
			var_01 = var_03.lastusedtime;
			var_00 = var_03;
		}
	}

	var_00 notify("reset");
	var_00 maps\mp\gametypes\_gameobjects::func_4629();
	var_00.lastusedtime = gettime();
	return var_00;
}

//Function Number: 8
func_78C3(param_00,param_01)
{
	var_02 = param_00 + (0,0,14);
	if(isdefined(param_01) && param_01)
	{
		var_03 = (0,randomfloat(360),0);
		var_04 = anglestoforward(var_03);
		var_05 = randomfloatrange(40,300);
		var_06 = var_02 + var_05 * var_04;
		var_02 = playerphysicstrace(var_02,var_06);
	}

	var_07 = func_3C1E();
	var_07.curorigin = var_02;
	var_07.trigger.origin = var_02;
	var_07.visual.origin = var_02;
	var_07.trigger show();
	var_07.visual show();
	var_07 maps\mp\gametypes\_gameobjects::allowuse("any");
	playsoundatpos(var_02,"mp_grind_token_drop");
	return var_07;
}

//Function Number: 9
func_53D1(param_00)
{
	level endon("game_ended");
	param_00 endon("deleted");
	param_00 endon("reset");
	for(;;)
	{
		param_00.trigger waittill("trigger",var_01);
		if(!maps\mp\_utility::func_4945(var_01))
		{
			continue;
		}

		if(var_01 maps\mp\_utility::func_4995() || isdefined(var_01.var_78A7))
		{
			continue;
		}

		if(isdefined(var_01.classname) && var_01.classname == "script_vehicle")
		{
			continue;
		}

		if(isbot(var_01) && isdefined(var_01.owner))
		{
			var_01 = var_01.owner;
		}

		param_00.visual hide();
		param_00.trigger hide();
		param_00.curorigin = (0,0,1000);
		param_00.trigger.origin = (0,0,1000);
		param_00.visual.origin = (0,0,1000);
		param_00 maps\mp\gametypes\_gameobjects::allowuse("none");
		var_01 thread maps\mp\gametypes\_rank::giverankxp("tag");
		var_01 func_93AC(var_01.tagscarried + 1);
		var_01 playsound("mp_killconfirm_tags_pickup");
		playsoundatpos(var_01.origin,"mp_grind_token_pickup");
		break;
	}
}

//Function Number: 10
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.isscoring = 0;
		var_00 thread func_9345();
	}
}

//Function Number: 11
func_93AC(param_00)
{
	self.tagscarried = param_00;
	self.game_extrainfo = param_00;
	if(param_00 > 999)
	{
		param_00 = 999;
	}

	self setclientomnvar("ui_grind_tags",param_00);
}

//Function Number: 12
func_9345()
{
	self endon("disconnect");
	for(;;)
	{
		common_scripts\utility::func_8B2A("joined_team","joined_spectators");
		if(level.ingraceperiod)
		{
			func_93AC(1);
			continue;
		}

		func_93AC(0);
	}
}

//Function Number: 13
hidehudelementongameend(param_00)
{
	level waittill("game_ended");
	if(isdefined(param_00))
	{
		param_00.alpha = 0;
	}
}

//Function Number: 14
createzones()
{
	level.zonelist = [];
	game["flagmodels"] = [];
	game["flagmodels"]["neutral"] = "prop_flag_neutral";
	game["flagmodels"]["allies"] = maps\mp\gametypes\_teams::getteamflagmodel("allies");
	game["flagmodels"]["axis"] = maps\mp\gametypes\_teams::getteamflagmodel("axis");
	var_00 = getentarray("grind_location","targetname");
	foreach(var_02 in var_00)
	{
		level.zonelist[level.zonelist.size] = addzone(var_02);
	}
}

//Function Number: 15
addzone(param_00)
{
	var_01 = addstruct();
	var_01.origin = param_00.origin;
	var_01.angles = param_00.angles;
	var_01.trigger = param_00;
	var_01.ownerteam = "neutral";
	var_02 = var_01.origin + (0,0,32);
	var_03 = var_01.origin + (0,0,-32);
	var_04 = bullettrace(var_02,var_03,0,undefined);
	var_01.origin = var_04["position"];
	var_01.upangles = vectortoangles(var_04["normal"]);
	var_01.forward = anglestoforward(var_01.upangles);
	var_01.right = anglestoright(var_01.upangles);
	var_01.visuals[0] = spawn("script_model",var_01.origin);
	var_01.visuals[0].angles = var_01.angles;
	var_01.visuals[0] setmodel(game["flagmodels"]["neutral"]);
	return var_01;
}

//Function Number: 16
func_69BD()
{
	foreach(var_01 in level.zonelist)
	{
		level thread func_7B03(var_01,var_01.trigger.script_label);
	}
}

//Function Number: 17
func_7B03(param_00,param_01)
{
	level thread func_69BC(param_00);
	level thread func_69BE(param_00,param_01);
	level thread func_69BF(param_00);
}

//Function Number: 18
func_69BC(param_00)
{
	maps\mp\_utility::gameflagwait("prematch_done");
	var_01 = spawnfx(level.flagbasefxid["friendly"],param_00.origin,param_00.forward,param_00.upangles);
	triggerfx(var_01);
}

//Function Number: 19
func_69BE(param_00,param_01)
{
	var_02 = (0,0,100);
	param_00.objid_axis = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(param_00.objid_axis,"active",param_00.origin + var_02,"waypoint_target_" + param_01);
	objective_team(param_00.objid_axis,"axis");
	param_00.objid_allies = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(param_00.objid_allies,"active",param_00.origin + var_02,"waypoint_target_" + param_01);
	objective_team(param_00.objid_allies,"allies");
	var_03 = 0;
	var_04 = "none";
	for(;;)
	{
		var_05 = "neutral";
		foreach(var_07 in level.players)
		{
			if(!maps\mp\_utility::func_4945(var_07))
			{
				continue;
			}

			if(!var_07.tagscarried)
			{
				continue;
			}

			if(var_07.team == var_05)
			{
				continue;
			}

			if(isinzone(var_07,param_00))
			{
				if(var_05 == "neutral")
				{
					var_05 = var_07.team;
					continue;
				}

				var_05 = "contested";
				break;
			}
		}

		param_00.ownerteam = var_05;
		if(var_04 == var_05)
		{
			common_scripts\utility::func_8AFE();
			continue;
		}

		switch(var_05)
		{
			case "neutral":
				if(var_03 + 1250 > gettime())
				{
					break;
				}
		
				var_04 = var_05;
				param_00.grind_headicon_allies = param_00 maps\mp\_entityheadicons::setheadicon("allies","waypoint_bank_" + param_01,var_02,4,4,undefined,undefined,undefined,1,undefined,0);
				param_00.grind_headicon_axis = param_00 maps\mp\_entityheadicons::setheadicon("axis","waypoint_bank_" + param_01,var_02,4,4,undefined,undefined,undefined,1,undefined,0);
				objective_icon(param_00.objid_allies,"waypoint_bank_" + param_01);
				objective_icon(param_00.objid_axis,"waypoint_bank_" + param_01);
				break;
	
			case "contested":
				var_04 = var_05;
				param_00.grind_headicon_allies = param_00 maps\mp\_entityheadicons::setheadicon("allies","waypoint_contested_" + param_01,var_02,4,4,undefined,undefined,undefined,1,undefined,0);
				param_00.grind_headicon_axis = param_00 maps\mp\_entityheadicons::setheadicon("axis","waypoint_contested_" + param_01,var_02,4,4,undefined,undefined,undefined,1,undefined,0);
				objective_icon(param_00.objid_allies,"waypoint_contested_" + param_01);
				objective_icon(param_00.objid_axis,"waypoint_contested_" + param_01);
				break;
	
			case "axis":
				var_04 = var_05;
				param_00.grind_headicon_allies = param_00 maps\mp\_entityheadicons::setheadicon("allies","waypoint_scoring_foe_" + param_01,var_02,4,4,undefined,undefined,undefined,1,undefined,0);
				param_00.grind_headicon_axis = param_00 maps\mp\_entityheadicons::setheadicon("axis","waypoint_scoring_friend_" + param_01,var_02,4,4,undefined,undefined,undefined,1,undefined,0);
				objective_icon(param_00.objid_allies,"waypoint_scoring_foe_" + param_01);
				objective_icon(param_00.objid_axis,"waypoint_scoring_friend_" + param_01);
				var_03 = gettime();
				break;
	
			case "allies":
				var_04 = var_05;
				param_00.grind_headicon_allies = param_00 maps\mp\_entityheadicons::setheadicon("allies","waypoint_scoring_friend_" + param_01,var_02,4,4,undefined,undefined,undefined,1,undefined,0);
				param_00.grind_headicon_axis = param_00 maps\mp\_entityheadicons::setheadicon("axis","waypoint_scoring_foe_" + param_01,var_02,4,4,undefined,undefined,undefined,1,undefined,0);
				objective_icon(param_00.objid_allies,"waypoint_scoring_friend_" + param_01);
				objective_icon(param_00.objid_axis,"waypoint_scoring_foe_" + param_01);
				var_03 = gettime();
				break;
		}

		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 20
isinzone(param_00,param_01)
{
	if(maps\mp\_utility::func_4945(param_00) && param_00 istouching(param_01.trigger))
	{
		return 1;
	}

	return 0;
}

//Function Number: 21
func_69BF(param_00)
{
	level endon("game_ended");
	for(;;)
	{
		param_00.trigger waittill("trigger",var_01);
		if(isbot(var_01))
		{
			continue;
		}

		if(!isplayer(var_01))
		{
			continue;
		}

		if(var_01.isscoring)
		{
			continue;
		}

		var_01.isscoring = 1;
		level thread func_61D5(var_01,param_00);
	}
}

//Function Number: 22
removetagsongameended()
{
	level waittill("game_ended");
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		if(!isdefined(var_01.tagscarried))
		{
			continue;
		}

		var_01.tagscarried = 0;
	}
}

//Function Number: 23
func_61D5(param_00,param_01)
{
	while(param_00.tagscarried && isinzone(param_00,param_01))
	{
		param_00 playsoundtoplayer("mp_grind_token_banked",param_00);
		param_00 func_93AC(param_00.tagscarried - 1);
		maps\mp\gametypes\_gamescore::giveteamscoreforobjective(param_00.team,1);
		param_00 maps\mp\_utility::setextrascore0(param_00.extrascore0 + 1);
		maps\mp\gametypes\_gamescore::func_3D00("tagScore",param_00);
		param_00 maps\mp\_events::giveobjectivepointstreaks();
		param_00 maps\mp\gametypes\_missions::func_61CE("ch_grinder");
		wait(2);
	}

	param_00.isscoring = 0;
}

//Function Number: 24
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

//Function Number: 25
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

//Function Number: 26
onnormaldeath(param_00,param_01,param_02)
{
	level thread func_2B5E(param_00,param_01);
	if(game["state"] == "postgame" && game["teamScores"][param_01.team] > game["teamScores"][level.otherteam[param_01.team]])
	{
		param_01.finalkill = 1;
	}
}

//Function Number: 27
func_2B5E(param_00,param_01)
{
	if(isbot(param_00))
	{
	}

	var_02 = 1;
	var_03 = 0;
	for(var_04 = 0;var_04 < var_02;var_04++)
	{
		if(var_04 > 0)
		{
			var_03 = 1;
		}

		var_05 = func_78C3(param_00.origin,var_03);
		var_05.victim = param_00;
		var_05.attacker = param_01;
		level notify("new_tag_spawned",var_05);
		level thread func_53D1(var_05);
	}

	playsoundatpos(param_00.origin,"mp_killconfirm_tags_drop");
	var_06 = param_00.tagscarried - var_02;
	var_06 = castint(max(0,var_06));
	param_00 func_93AC(var_06);
}