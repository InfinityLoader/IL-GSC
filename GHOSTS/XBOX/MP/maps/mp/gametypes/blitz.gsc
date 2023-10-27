/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\blitz.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 47
 * Decompile Time: 842 ms
 * Timestamp: 10/27/2023 1:29:00 AM
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
		maps\mp\_utility::func_6475(level.gametype,16);
		maps\mp\_utility::func_6476(level.gametype,5);
		maps\mp\_utility::func_6472(level.gametype,2);
		maps\mp\_utility::func_6473(level.gametype,1,0,1);
		maps\mp\_utility::func_647C(level.gametype,0);
		maps\mp\_utility::func_6470(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
	}

	level.teambased = 1;
	level.objectivebased = 0;
	level.supportbuddyspawn = 0;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.ontimelimit = ::ontimelimit;
	level.onnormaldeath = ::onnormaldeath;
	level.onplayerkilled = ::onplayerkilled;
	level.var_5976 = ::func_5976;
	level.initgametypeawards = ::initgametypeawards;
	level.spawnnodetype = common_scripts\utility::func_803F(getdvarint("scr_altBlitzSpawns",0) == 1,"mp_tdm_spawn","mp_blitz_spawn");
	if(level.matchrules_damagemultiplier)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	game["dialog"]["gametype"] = "blitz";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	game["dialog"]["offense_obj"] = "bltz_hint";
	game["dialog"]["defense_obj"] = "bltz_hint";
	game["dialog"]["bltz_e_scored"] = "bltz_e_scored";
	game["dialog"]["bltz_scored"] = "bltz_scored";
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_700A();
	setdynamicdvar("scr_blitz_roundswitch",1);
	maps\mp\_utility::func_6473("blitz",1,0,1);
	setdynamicdvar("scr_blitz_roundlimit",2);
	maps\mp\_utility::func_6472("blitz",2);
	setdynamicdvar("scr_blitz_winlimit",0);
	maps\mp\_utility::func_647C("blitz",0);
	setdynamicdvar("scr_blitz_promode",0);
}

//Function Number: 3
func_460C()
{
	level._effect["portal_fx_defend"] = loadfx("vfx/gameplay/mp/core/vfx_marker_base_cyan");
	level._effect["portal_fx_goal"] = loadfx("vfx/gameplay/mp/core/vfx_marker_base_orange");
	level._effect["portal_fx_closed"] = loadfx("vfx/gameplay/mp/core/vfx_marker_base_grey");
	level._effect["blitz_teleport"] = loadfx("vfx/gameplay/mp/core/vfx_teleport_player");
}

//Function Number: 4
onstartgametype()
{
	maps\mp\_utility::func_7084("allies",&"OBJECTIVES_BLITZ");
	maps\mp\_utility::func_7084("axis",&"OBJECTIVES_BLITZ");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_BLITZ");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_BLITZ");
	}
	else
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_BLITZ_ATTACKER_SCORE");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_BLITZ_ATTACKER_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_BLITZ_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_BLITZ_HINT");
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

	initspawns();
	func_460C();
	var_02[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::func_4FDD(var_02);
	createportals();
	level thread func_595D();
	assignteamspawns();
	level thread func_6987();
}

//Function Number: 5
func_595D()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 func_9493();
		var_00 thread func_93EB();
		var_00 thread onplayerspawned();
	}
}

//Function Number: 6
onplayerspawned()
{
	self waittill("spawned_player");
	func_7526();
	thread func_643D();
	thread refreshspectatorportalfx();
	thread func_1D3E();
}

//Function Number: 7
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_blitz_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_blitz_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies",level.spawnnodetype);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis",level.spawnnodetype);
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 8
createportals()
{
	level.portals = [];
	if(game["switchedsides"])
	{
		var_00 = getent("allies_portal","targetname");
		var_01 = getent("axis_portal","targetname");
	}
	else
	{
		var_00 = getent("axis_portal","targetname");
		var_01 = getent("allies_portal","targetname");
	}

	level.portallist["axis"] = createportal(var_00,"axis");
	level.portallist["allies"] = createportal(var_01,"allies");
}

//Function Number: 9
createportal(param_00,param_01)
{
	var_02 = addstruct();
	var_02.origin = param_00.origin;
	var_02.ownerteam = param_01;
	var_02.open = 1;
	var_02.guarded = 0;
	var_02.trigger = param_00;
	if(isdefined(level.matchrecording_generateid) && isdefined(level.matchrecording_logevent))
	{
		if(!isdefined(game["blitzPortalLogIDs"]))
		{
			game["blitzPortalLogIDs"] = [];
		}

		if(!isdefined(game["blitzPortalLogIDs"][param_01]))
		{
			game["blitzPortalLogIDs"][param_01] = [[ level.matchrecording_generateid ]]();
		}

		var_03 = common_scripts\utility::func_803F(param_01 == "allies",0,1);
		[[ level.matchrecording_logevent ]](game["blitzPortalLogIDs"][param_01],undefined,"PORTAL",var_02.origin[0],var_02.origin[1],gettime(),var_03);
	}

	return var_02;
}

//Function Number: 10
assignteamspawns()
{
	var_00 = maps\mp\gametypes\_spawnlogic::func_3BF6(level.spawnnodetype);
	var_01 = maps\mp\gametypes\_spawnlogic::func_4928();
	level.teamspawnpoints["axis"] = [];
	level.teamspawnpoints["allies"] = [];
	level.teamspawnpoints["neutral"] = [];
	if(getdvarint("scr_altBlitzSpawns",0) == 1 && level.portallist.size == 2)
	{
		var_02 = level.portallist["allies"];
		var_03 = level.portallist["axis"];
		var_04 = (var_02.origin[0],var_02.origin[1],0);
		var_05 = (var_03.origin[0],var_03.origin[1],0);
		var_06 = var_05 - var_04;
		var_07 = length2d(var_06);
		foreach(var_09 in var_00)
		{
			var_0A = (var_09.origin[0],var_09.origin[1],0);
			var_0B = var_0A - var_04;
			var_0C = vectordot(var_0B,var_06);
			var_0D = var_0C / var_07 * var_07;
			if(var_0D < 0.33)
			{
				var_09.teambase = var_02.ownerteam;
				level.teamspawnpoints[var_09.teambase][level.teamspawnpoints[var_09.teambase].size] = var_09;
				continue;
			}

			if(var_0D > 0.67)
			{
				var_09.teambase = var_03.ownerteam;
				level.teamspawnpoints[var_09.teambase][level.teamspawnpoints[var_09.teambase].size] = var_09;
				continue;
			}

			var_0E = undefined;
			var_0F = undefined;
			if(var_01)
			{
				var_0E = badplace_global(var_09.origin,var_02.origin,999999);
			}

			if(isdefined(var_0E) && var_0E != -1)
			{
				var_0F = badplace_global(var_09.origin,var_03.origin,999999);
			}

			if(!isdefined(var_0F) || var_0F == -1)
			{
				var_0E = distance2d(var_02.origin,var_09.origin);
				var_0F = distance2d(var_03.origin,var_09.origin);
			}

			var_10 = max(var_0E,var_0F);
			var_11 = min(var_0E,var_0F);
			var_12 = var_11 / var_10;
			if(var_12 > 0.5)
			{
				level.teamspawnpoints["neutral"][level.teamspawnpoints["neutral"].size] = var_09;
			}
		}
	}

	foreach(var_09 in var_01)
	{
		var_09.teambase = func_3B3B(var_09);
		if(var_09.teambase == "axis")
		{
			level.teamspawnpoints["axis"][level.teamspawnpoints["axis"].size] = var_09;
			continue;
		}

		level.teamspawnpoints["allies"][level.teamspawnpoints["allies"].size] = var_09;
	}
}

//Function Number: 11
func_3B3B(param_00)
{
	var_01 = maps\mp\gametypes\_spawnlogic::func_4928();
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_05 in level.portallist)
	{
		var_06 = undefined;
		if(var_01)
		{
			var_06 = badplace_global(param_00.origin,var_05.origin,999999);
		}

		if(!isdefined(var_06) || var_06 == -1)
		{
			var_06 = distancesquared(var_05.origin,param_00.origin);
		}

		if(!isdefined(var_02) || var_06 < var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	return var_02.ownerteam;
}

//Function Number: 12
onnormaldeath(param_00,param_01,param_02)
{
	param_01 thread maps\mp\gametypes\_rank::func_8E6E("kill");
}

//Function Number: 13
func_6987()
{
	func_7AEC(level.portallist["axis"]);
	func_7AEC(level.portallist["allies"]);
}

//Function Number: 14
func_7AEC(param_00)
{
	level thread func_69A3(param_00);
	level thread runportalstatus(param_00);
	level thread func_69A5(param_00);
}

//Function Number: 15
func_69A3(param_00)
{
	level endon("final_score_teleport");
	level endon("halftime_score_teleport");
	level endon("time_ended");
	level endon("force_end");
	var_01 = blitzgetteam(param_00);
	param_00 childthread func_596B(var_01);
	param_00 childthread func_596A(var_01);
}

//Function Number: 16
func_596B(param_00)
{
	for(;;)
	{
		level waittill("portal_used",var_01);
		if(var_01 != param_00)
		{
			continue;
		}

		func_420A(param_00);
		showclosedportalfx(param_00);
	}
}

//Function Number: 17
func_596A(param_00)
{
	for(;;)
	{
		level waittill("portal_ready",var_01);
		if(var_01 != param_00)
		{
			continue;
		}

		if(!self.open)
		{
			continue;
		}

		func_4202(param_00);
		func_7520(param_00);
	}
}

//Function Number: 18
func_420A(param_00)
{
	foreach(var_02 in level.players)
	{
		if(!isdefined(var_02) || !isdefined(var_02.team))
		{
			continue;
		}

		if(var_02.team == "allies" || var_02.team == "axis")
		{
			if(var_02.team == param_00)
			{
				if(isdefined(var_02.defend_fx_ent))
				{
					var_02.defend_fx_ent delete();
				}
			}
			else if(isdefined(var_02.goal_fx_ent))
			{
				var_02.goal_fx_ent delete();
			}

			continue;
		}

		var_03 = var_02 setmlgcameradefaults();
		if((var_03 && param_00 == var_02 setmlgspectator()) || !var_03 && param_00 == "allies")
		{
			if(isdefined(var_02.defend_fx_ent))
			{
				var_02.defend_fx_ent delete();
			}
		}
		else if(isdefined(var_02.goal_fx_ent))
		{
			var_02.goal_fx_ent delete();
		}
	}
}

//Function Number: 19
func_7520(param_00)
{
	foreach(var_02 in level.players)
	{
		if(!isdefined(var_02) || !isdefined(var_02.team))
		{
			continue;
		}

		if(var_02.team == "allies" || var_02.team == "axis")
		{
			if(var_02.team == param_00)
			{
				if(!isdefined(var_02.defend_fx_ent))
				{
					var_02.defend_fx_ent = botgetteamlimit(level._effect["portal_fx_defend"],self.origin,var_02);
					triggerfx(var_02.defend_fx_ent);
				}
			}
			else if(!isdefined(var_02.goal_fx_ent))
			{
				var_02.goal_fx_ent = botgetteamlimit(level._effect["portal_fx_goal"],self.origin,var_02);
				triggerfx(var_02.goal_fx_ent);
			}

			continue;
		}

		var_03 = var_02 setmlgcameradefaults();
		if((var_03 && param_00 == var_02 setmlgspectator()) || !var_03 && param_00 == "allies")
		{
			if(!isdefined(var_02.defend_fx_ent))
			{
				var_02.defend_fx_ent = botgetteamlimit(level._effect["portal_fx_defend"],self.origin,var_02);
				triggerfx(var_02.defend_fx_ent);
			}
		}
		else if(!isdefined(var_02.goal_fx_ent))
		{
			var_02.goal_fx_ent = botgetteamlimit(level._effect["portal_fx_goal"],self.origin,var_02);
			triggerfx(var_02.goal_fx_ent);
		}
	}
}

//Function Number: 20
func_4202(param_00)
{
	foreach(var_02 in level.players)
	{
		if(!isdefined(var_02) || !isdefined(var_02.team))
		{
			continue;
		}

		if(var_02.team == "allies" || var_02.team == "axis")
		{
			if(var_02.team == param_00)
			{
				if(isdefined(var_02.closed_defend_fx_ent))
				{
					var_02.closed_defend_fx_ent delete();
				}
			}
			else if(isdefined(var_02.closed_goal_fx_ent))
			{
				var_02.closed_goal_fx_ent delete();
			}

			continue;
		}

		var_03 = var_02 setmlgcameradefaults();
		if((var_03 && param_00 == var_02 setmlgspectator()) || !var_03 && param_00 == "allies")
		{
			if(isdefined(var_02.closed_defend_fx_ent))
			{
				var_02.closed_defend_fx_ent delete();
			}
		}
		else if(isdefined(var_02.closed_goal_fx_ent))
		{
			var_02.closed_goal_fx_ent delete();
		}
	}
}

//Function Number: 21
showclosedportalfx(param_00)
{
	foreach(var_02 in level.players)
	{
		if(!isdefined(var_02) || !isdefined(var_02.team))
		{
			continue;
		}

		if(var_02.team == "allies" || var_02.team == "axis")
		{
			if(var_02.team == param_00)
			{
				if(!isdefined(var_02.closed_defend_fx_ent))
				{
					var_02.closed_defend_fx_ent = botgetteamlimit(level._effect["portal_fx_closed"],self.origin,var_02);
					triggerfx(var_02.closed_defend_fx_ent);
				}
			}
			else if(!isdefined(var_02.closed_goal_fx_ent))
			{
				var_02.closed_goal_fx_ent = botgetteamlimit(level._effect["portal_fx_closed"],self.origin,var_02);
				triggerfx(var_02.closed_goal_fx_ent);
			}

			continue;
		}

		var_03 = var_02 setmlgcameradefaults();
		if((var_03 && param_00 == var_02 setmlgspectator()) || !var_03 && param_00 == "allies")
		{
			if(!isdefined(var_02.closed_defend_fx_ent))
			{
				var_02.closed_defend_fx_ent = botgetteamlimit(level._effect["portal_fx_closed"],self.origin,var_02);
				triggerfx(var_02.closed_defend_fx_ent);
			}
		}
		else if(!isdefined(var_02.closed_goal_fx_ent))
		{
			var_02.closed_goal_fx_ent = botgetteamlimit(level._effect["portal_fx_closed"],self.origin,var_02);
			triggerfx(var_02.closed_goal_fx_ent);
		}
	}
}

//Function Number: 22
func_643D()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("joined_team");
		func_7526();
	}
}

//Function Number: 23
refreshspectatorportalfx()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("joined_spectators");
		func_9493();
	}
}

//Function Number: 24
func_93EB()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "mlg_view_change")
		{
			func_9493();
		}
	}
}

//Function Number: 25
func_1D3E()
{
	self waittill("disconnect");
	clearportalfx();
}

//Function Number: 26
func_7526()
{
	if(self.team != "allies" && self.team != "axis")
	{
	}

	var_00 = self.team;
	var_01 = maps\mp\_utility::getotherteam(var_00);
	clearportalfx();
	if(isdefined(level.portallist[var_00]) && isdefined(level.portallist[var_01]))
	{
		if(level.portallist[var_00].open && !level.portallist[var_00].guarded)
		{
			self.defend_fx_ent = botgetteamlimit(level._effect["portal_fx_defend"],level.portallist[var_00].origin,self);
			triggerfx(self.defend_fx_ent);
		}
		else
		{
			self.closed_defend_fx_ent = botgetteamlimit(level._effect["portal_fx_closed"],level.portallist[var_00].origin,self);
			triggerfx(self.closed_defend_fx_ent);
		}

		if(level.portallist[var_01].open && !level.portallist[var_01].guarded)
		{
			self.goal_fx_ent = botgetteamlimit(level._effect["portal_fx_goal"],level.portallist[var_01].origin,self);
			triggerfx(self.goal_fx_ent);
		}

		self.closed_goal_fx_ent = botgetteamlimit(level._effect["portal_fx_closed"],level.portallist[var_01].origin,self);
		triggerfx(self.closed_goal_fx_ent);
	}
}

//Function Number: 27
func_9493()
{
	clearportalfx();
	var_00 = "allies";
	var_01 = "axis";
	var_02 = self setmlgcameradefaults();
	if(var_02)
	{
		var_00 = self setmlgspectator();
		var_01 = maps\mp\_utility::getotherteam(var_00);
	}

	if(isdefined(level.portallist[var_00]) && isdefined(level.portallist[var_01]))
	{
		if(level.portallist[var_00].open && !level.portallist[var_00].guarded)
		{
			self.defend_fx_ent = botgetteamlimit(level._effect["portal_fx_defend"],level.portallist[var_00].origin,self);
			triggerfx(self.defend_fx_ent);
		}
		else
		{
			self.closed_defend_fx_ent = botgetteamlimit(level._effect["portal_fx_closed"],level.portallist[var_00].origin,self);
			triggerfx(self.closed_defend_fx_ent);
		}

		if(level.portallist[var_01].open && !level.portallist[var_01].guarded)
		{
			self.goal_fx_ent = botgetteamlimit(level._effect["portal_fx_goal"],level.portallist[var_01].origin,self);
			triggerfx(self.goal_fx_ent);
		}

		self.closed_goal_fx_ent = botgetteamlimit(level._effect["portal_fx_closed"],level.portallist[var_01].origin,self);
		triggerfx(self.closed_goal_fx_ent);
	}
}

//Function Number: 28
clearportalfx()
{
	if(isdefined(self.defend_fx_ent))
	{
		self.defend_fx_ent delete();
	}

	if(isdefined(self.closed_defend_fx_ent))
	{
		self.closed_defend_fx_ent delete();
	}

	if(isdefined(self.goal_fx_ent))
	{
		self.goal_fx_ent delete();
	}

	if(isdefined(self.closed_goal_fx_ent))
	{
		self.closed_goal_fx_ent delete();
	}
}

//Function Number: 29
runportalstatus(param_00,param_01)
{
	level endon("final_score_teleport");
	level endon("halftime_score_teleport");
	level endon("time_ended");
	level endon("force_end");
	var_02 = (0,0,72);
	var_03 = blitzgetteam(param_00);
	var_04 = maps\mp\_utility::getotherteam(var_03);
	param_00.ownerteamid = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(param_00.ownerteamid,"active",param_00.origin + var_02,"waypoint_blitz_defend");
	objective_team(param_00.ownerteamid,var_03);
	param_00.enemyteamid = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(param_00.enemyteamid,"active",param_00.origin + var_02,"waypoint_blitz_goal");
	objective_team(param_00.enemyteamid,var_04);
	for(;;)
	{
		if(param_00.open)
		{
			param_00.teamheadicon = param_00 maps\mp\_entityheadicons::setheadicon(var_03,"waypoint_blitz_defend",var_02,4,4,undefined,undefined,undefined,1,undefined,0);
			param_00.enemyheadicon = param_00 maps\mp\_entityheadicons::setheadicon(var_04,"waypoint_blitz_goal",var_02,4,4,undefined,undefined,undefined,1,undefined,0);
			objective_icon(param_00.ownerteamid,"waypoint_blitz_defend");
			objective_icon(param_00.enemyteamid,"waypoint_blitz_goal");
		}
		else if(!isdefined(param_00.waiticonactive) || !param_00.waiticonactive)
		{
			param_00.waiticonactive = 1;
			param_00 childthread func_643E(param_00,var_03,var_04,var_02);
		}

		level common_scripts\utility::func_8B2A("portal_used","portal_ready");
	}
}

//Function Number: 30
func_643E(param_00,param_01,param_02,param_03)
{
	var_04 = 10;
	for(var_05 = var_04;var_05 > 0;var_05--)
	{
		if(var_05 == var_04)
		{
			param_00.teamheadicon = param_00 maps\mp\_entityheadicons::setheadicon(param_01,"blitz_time_" + var_05 + "_blue",param_03,4,4,undefined,undefined,undefined,1,undefined,0);
			objective_icon(param_00.ownerteamid,"blitz_time_" + var_05 + "_blue");
		}
		else
		{
			param_00.teamheadicon = param_00 maps\mp\_entityheadicons::setheadicon(param_01,"blitz_time_0" + var_05 + "_blue",param_03,4,4,undefined,undefined,undefined,1,undefined,0);
			objective_icon(param_00.ownerteamid,"blitz_time_0" + var_05 + "_blue");
		}

		if(var_05 == var_04)
		{
			param_00.enemyheadicon = param_00 maps\mp\_entityheadicons::setheadicon(param_02,"blitz_time_" + var_05 + "_orng",param_03,4,4,undefined,undefined,undefined,1,undefined,0);
			objective_icon(param_00.enemyteamid,"blitz_time_" + var_05 + "_orng");
		}
		else
		{
			param_00.enemyheadicon = param_00 maps\mp\_entityheadicons::setheadicon(param_02,"blitz_time_0" + var_05 + "_orng",param_03,4,4,undefined,undefined,undefined,1,undefined,0);
			objective_icon(param_00.enemyteamid,"blitz_time_0" + var_05 + "_orng");
		}

		maps\mp\gametypes\_hostmigration::func_8B0D(1);
	}

	param_00.waiticonactive = 0;
}

//Function Number: 31
func_69A5(param_00)
{
	level endon("final_score_teleport");
	level endon("halftime_score_teleport");
	level endon("time_ended");
	level endon("force_end");
	var_01 = blitzgetteam(param_00);
	var_02 = getdvarfloat("scr_blitz_scoredelay",10);
	param_00 childthread guardwatch(var_01);
	for(;;)
	{
		param_00.trigger waittill("trigger",var_03);
		if(func_9566(var_03,param_00,var_01))
		{
			param_00.open = 0;
			level notify("portal_used",var_01);
			func_93AE(var_03,param_00,var_01);
			maps\mp\gametypes\_hostmigration::func_8B0D(var_02);
			param_00.open = 1;
			level notify("portal_ready",var_01);
		}
	}
}

//Function Number: 32
func_9566(param_00,param_01,param_02)
{
	if(!isplayer(param_00))
	{
		return 0;
	}

	if(param_00.team == param_02 || param_00.team == "spectator")
	{
		return 0;
	}

	if(checkguardedportal(param_01,param_02))
	{
		return 0;
	}

	if(param_00 islinked())
	{
		return 0;
	}

	if(isdefined(param_00.iscarrying) && param_00.iscarrying)
	{
		return 0;
	}

	return 1;
}

//Function Number: 33
func_93AE(param_00,param_01,param_02)
{
	maps\mp\_utility::func_4D30("bltz_e_scored",param_02);
	maps\mp\_utility::func_4D30("bltz_scored",maps\mp\_utility::getotherteam(param_02));
	maps\mp\gametypes\_gamescore::func_3D00("capture",param_00);
	param_00 thread maps\mp\gametypes\_rank::giverankxp("capture");
	param_00 maps\mp\killstreaks\_killstreaks::func_3CDB("capture");
	func_3D13(param_00.team);
	param_00 maps\mp\_utility::func_447B("pointscaptured",1);
	param_00 maps\mp\_utility::func_4479("captures",1);
	param_00 maps\mp\gametypes\_persistence::func_7B28("round","captures",param_00.pers["captures"]);
	param_00 maps\mp\gametypes\_missions::func_61CE("ch_blitz_score");
	if(param_00 maps\mp\gametypes\_missions::playerissprintsliding())
	{
		param_00 maps\mp\gametypes\_missions::func_61CE("ch_saafe");
	}

	if(isdefined(param_00.stuckbygrenade) && isdefined(param_00.stuckbygrenade.owner))
	{
		param_00.stuckbygrenade.owner maps\mp\gametypes\_missions::func_61CE("ch_telefragged");
	}

	param_00 maps\mp\_utility::setextrascore0(param_00.pers["captures"]);
	var_03 = param_00 getspawnpoint();
	param_00 thread func_7FFD(var_03.origin,var_03.angles);
}

//Function Number: 34
guardwatch(param_00)
{
	for(;;)
	{
		if(checkguardedportal(self,param_00))
		{
			level notify("portal_used",param_00);
			self.guarded = 1;
		}
		else
		{
			level notify("portal_ready",param_00);
			self.guarded = 0;
		}

		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 35
checkguardedportal(param_00,param_01)
{
	foreach(var_03 in level.participants)
	{
		if(!isdefined(var_03) || !isdefined(var_03.team))
		{
			continue;
		}

		if(var_03.team == param_01 && isalive(var_03) && !isdefined(var_03.fauxdead))
		{
			if(distancesquared(param_00.origin,var_03.origin) < 4300)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 36
func_3D13(param_00)
{
	maps\mp\gametypes\_gamescore::giveteamscoreforobjective(param_00,1);
	foreach(var_02 in level.players)
	{
		var_03 = var_02.team;
		if(var_02.team == "spectator")
		{
			var_04 = var_02 getspectatingplayer();
			if(isdefined(var_04))
			{
				var_03 = var_04.team;
			}
			else
			{
				var_02 thread maps\mp\gametypes\_hud_message::func_794E("blitz_score_team");
				continue;
			}
		}

		if(var_03 == param_00)
		{
			var_02 thread maps\mp\gametypes\_hud_message::func_794E("blitz_score_team");
			continue;
		}

		var_02 thread maps\mp\gametypes\_hud_message::func_794E("blitz_score_enemy");
	}
}

//Function Number: 37
func_7FFD(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self.teleporting = 1;
	func_1BD7();
	var_02 = 1;
	var_03 = create_client_overlay("white",1,self);
	var_03 thread func_3147(0,var_02);
	var_03 thread huddelete(var_02);
	var_04 = self gettagorigin("j_SpineUpper");
	playfx(level._effect["blitz_teleport"],var_04);
	if(isdefined(self.setspawnpoint))
	{
		maps\mp\perks\_perkfunctions::deleteti(self.setspawnpoint);
	}

	self playsoundonmovingent();
	self setorigin(param_00);
	self setangles(param_01);
	self setstance("stand");
	wait(var_02);
	self.teleporting = 0;
}

//Function Number: 38
create_client_overlay(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		var_03 = newclienthudelem(param_02);
	}
	else
	{
		var_03 = newhudelem();
	}

	var_03.x = 0;
	var_03.y = 0;
	var_03 setmaterial(param_00,640,480);
	var_03.alignx = "left";
	var_03.aligny = "top";
	var_03.sort = 1;
	var_03.horzalign = "fullscreen";
	var_03.vertalign = "fullscreen";
	var_03.alpha = param_01;
	var_03.foreground = 1;
	return var_03;
}

//Function Number: 39
func_3147(param_00,param_01)
{
	if(isdefined(param_01) && param_01 > 0)
	{
		self fadeovertime(param_01);
	}

	self.alpha = param_00;
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}
}

//Function Number: 40
huddelete(param_00)
{
	self endon("death");
	wait(param_00);
	self destroy();
}

//Function Number: 41
getspawnpoint()
{
	var_00 = blitzgetteam(self);
	var_01 = maps\mp\_utility::getotherteam(var_00);
	if(maps\mp\gametypes\_spawnlogic::func_948D())
	{
		if(game["switchedsides"])
		{
			var_02 = maps\mp\gametypes\_spawnlogic::func_3BF6("mp_blitz_spawn_" + var_01 + "_start");
			var_03 = maps\mp\gametypes\_spawnlogic::func_3BF5(var_02);
		}
		else
		{
			var_02 = maps\mp\gametypes\_spawnlogic::func_3BF6("mp_blitz_spawn_" + var_02 + "_start");
			var_03 = maps\mp\gametypes\_spawnlogic::func_3BF5(var_03);
		}
	}
	else
	{
		var_04 = level.teamspawnpoints["neutral"].size > 0;
		var_02 = maps\mp\gametypes\_spawnlogic::func_3C41(var_00);
		var_03 = maps\mp\gametypes\_spawnscoring::func_3BEE(var_02,var_00,var_04);
		if(!isdefined(var_03) && var_04)
		{
			var_02 = maps\mp\gametypes\_spawnlogic::func_3C41("neutral");
			var_03 = maps\mp\gametypes\_spawnscoring::func_3BEE(var_02,var_00,0);
		}
	}

	return var_03;
}

//Function Number: 42
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(param_01) || !isplayer(param_01))
	{
	}

	var_0A = self;
	var_0B = blitzgetteam(var_0A);
	var_0C = blitzgetteam(param_01);
	if(var_0C == var_0B)
	{
	}

	var_0D = level.portallist[var_0C].origin;
	var_0E = level.portallist[var_0B].origin;
	var_0F = 0;
	var_10 = 0;
	var_11 = 90000;
	if(function_0210(var_0A.origin,var_0D) < var_11)
	{
		var_10++;
	}

	if(function_0210(var_0A.origin,var_0E) < var_11)
	{
		var_0F++;
	}

	if(var_10)
	{
		param_01 thread maps\mp\gametypes\_hud_message::func_794C("defend",maps\mp\gametypes\_rank::func_3BE0("defend"));
		param_01 maps\mp\_utility::func_4479("defends",1);
		param_01 thread maps\mp\gametypes\_rank::giverankxp("defend");
		maps\mp\gametypes\_gamescore::func_3D00("defend",param_01);
		param_01 maps\mp\gametypes\_missions::func_61CE("ch_denied");
		var_0A thread maps\mp\_matchdata::func_4F1A(param_09,"assaulting");
	}

	if(var_0F)
	{
		param_01 thread maps\mp\gametypes\_hud_message::func_794C("assault",maps\mp\gametypes\_rank::func_3BE0("assault"));
		param_01 thread maps\mp\gametypes\_rank::giverankxp("assault");
		maps\mp\gametypes\_gamescore::func_3D00("assault",param_01);
		var_0A thread maps\mp\_matchdata::func_4F1A(param_09,"defending");
	}
}

//Function Number: 43
blitzgetteam(param_00)
{
	var_01 = param_00.team;
	if(!isdefined(var_01))
	{
		var_01 = param_00.ownerteam;
	}

	return var_01;
}

//Function Number: 44
ontimelimit()
{
	level notify("time_ended");
	level.finalkillcam_winner = "none";
	if(game["teamScores"]["axis"] == game["teamScores"]["allies"])
	{
		var_00 = "tie";
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

	thread maps\mp\gametypes\_gamelogic::endgame(var_00,game["end_reason"]["time_limit_reached"]);
}

//Function Number: 45
func_1BD7()
{
	if(game["switchedsides"])
	{
		var_00 = getdvarint("scr_blitz_scorelimit",16);
		if(getteamscore(self.team) == var_00)
		{
			level notify("final_score_teleport");
			level.finalkillcam_winner = self.team;
			var_01 = maps\mp\_utility::getotherteam(self.team);
			if(var_00 >= 16 && getteamscore(var_01) == 0)
			{
				maps\mp\gametypes\_missions::processchallengeforteam("ch_lockdown",self.team);
			}
		}
	}

	var_00 = getdvarint("scr_blitz_scorelimit",16) / 2;
	if(getteamscore(self.team) == var_01)
	{
		level notify("halftime_score_teleport");
		level.finalkillcam_winner = self.team;
		thread maps\mp\gametypes\_gamelogic::endgame("roundend",game["end_reason"]["score_limit_reached"]);
		if(var_01 >= 8)
		{
			maps\mp\gametypes\_missions::processchallengeforteam("ch_clocking",self.team);
		}
	}
}

//Function Number: 46
func_5976()
{
	self.teleporting = 0;
	maps\mp\_utility::setextrascore0(0);
	if(isdefined(self.pers["captures"]))
	{
		maps\mp\_utility::setextrascore0(self.pers["captures"]);
	}
}

//Function Number: 47
initgametypeawards()
{
	maps\mp\_awards::func_4652("pointscaptured",0,::maps\mp\_awards::highestwins);
}