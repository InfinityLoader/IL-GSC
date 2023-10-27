/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\ctf.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 57
 * Decompile Time: 996 ms
 * Timestamp: 10/27/2023 1:43:09 AM
*******************************************************************/

//Function Number: 1
main()
{
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
		maps\mp\_utility::registertimelimitdvar(level.gametype,5);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,3);
		maps\mp\_utility::registerroundlimitdvar(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::registernumlivesdvar(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	maps\mp\_utility::setovertimelimitdvar(5);
	if(isdefined(game["round_time_to_beat"]))
	{
		maps\mp\_utility::setovertimelimitdvar(game["round_time_to_beat"]);
		game["round_time_to_beat"] = undefined;
	}

	setspecialloadouts();
	level.assists_disabled = 1;
	level.teambased = 1;
	level.objectivebased = 1;
	level.overtimescorewinoverride = 1;
	level.onlyroundoverride = 1;
	level.pingstate = maps\mp\_utility::getintproperty("scr_ping_carrier",1);
	level.winbycaptures = maps\mp\_utility::getintproperty("scr_win_by_captures",0);
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.ontimelimit = ::ontimelimit;
	level.onhalftime = ::onhalftime;
	if(!isdefined(game["shut_out"]))
	{
		game["shut_out"]["axis"] = 1;
		game["shut_out"]["allies"] = 1;
	}

	if(level.winbycaptures)
	{
		setdynamicdvar("scr_ctf_scorelimit",0);
	}

	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	level.flagreturntime = maps\mp\_utility::getintproperty("scr_ctf_returntime",30);
	game["dialog"]["gametype"] = "ctf_intro";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	game["dialog"]["offense_obj"] = "dom_start";
	game["dialog"]["defense_obj"] = "dom_start";
	if(maps\mp\_utility::isgrapplinghookgamemode())
	{
		game["dialog"]["gametype"] = "grap_" + game["dialog"]["gametype"];
	}

	thread onplayerconnect();
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	setdynamicdvar("scr_ctf_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar("ctf",1);
	setdynamicdvar("scr_ctf_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("ctf",1);
	setdynamicdvar("scr_ctf_halftime",1);
	maps\mp\_utility::registerhalftimedvar("ctf",1);
	setdynamicdvar("scr_ctf_returntime",getmatchrulesdata("ctfData","returnTime"));
	setdynamicdvar("scr_ping_carrier",getmatchrulesdata("ctfData","enemyCarrierIcon"));
	setdynamicdvar("scr_win_by_captures",getmatchrulesdata("ctfData","winByCaptures"));
	setdynamicdvar("scr_ctf_flag_pick_up_time_friendly",getmatchrulesdata("ctfData","pickupTime"));
	setdynamicdvar("scr_ctf_flag_pick_up_time_enemy",getmatchrulesdata("ctfData","pickupTime"));
}

//Function Number: 3
onstartgametype()
{
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(maps\mp\_utility::isovertimetext(game["status"]))
	{
		game["switchedsides"] = !game["switchedsides"];
	}

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

	if(!isdefined(game["original_defenders"]))
	{
		game["original_defenders"] = game["defenders"];
	}

	if(game["switchedsides"])
	{
		var_00 = game["attackers"];
		var_01 = game["defenders"];
		game["attackers"] = var_01;
		game["defenders"] = var_00;
	}

	if(!level.winbycaptures)
	{
		game["teamScores"][game["attackers"]] = 0;
		setteamscore(game["attackers"],0);
		game["teamScores"][game["defenders"]] = 0;
		setteamscore(game["defenders"],0);
	}

	setclientnamemode("auto_change");
	level.flagstowedfxid["sentinel"]["friendly"] = loadfx("vfx/unique/vfx_flag_project_stowed_sentinel_friendly");
	level.flagstowedfxid["sentinel"]["enemy"] = loadfx("vfx/unique/vfx_flag_project_stowed_sentinel_enemy");
	level.flagstowedfxid["atlas"]["friendly"] = loadfx("vfx/unique/vfx_flag_project_stowed_atlas_friendly");
	level.flagstowedfxid["atlas"]["enemy"] = loadfx("vfx/unique/vfx_flag_project_stowed_atlas_enemy");
	level.flaggroundfxid["sentinel"]["friendly"] = loadfx("vfx/unique/vfx_flag_project_sentinel_friendly");
	level.flaggroundfxid["sentinel"]["enemy"] = loadfx("vfx/unique/vfx_flag_project_sentinel_enemy");
	level.flaggroundfxid["atlas"]["friendly"] = loadfx("vfx/unique/vfx_flag_project_atlas_friendly");
	level.flaggroundfxid["atlas"]["enemy"] = loadfx("vfx/unique/vfx_flag_project_atlas_enemy");
	level.flagbasefxid["sentinel"]["friendly"] = loadfx("vfx/unique/vfx_marker_ctf");
	level.flagbasefxid["sentinel"]["enemy"] = loadfx("vfx/unique/vfx_marker_ctf_red");
	level.flagbasefxid["atlas"]["friendly"] = loadfx("vfx/unique/vfx_marker_ctf");
	level.flagbasefxid["atlas"]["enemy"] = loadfx("vfx/unique/vfx_marker_ctf_red");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"],&"OBJECTIVES_ONE_FLAG_ATTACKER");
		maps\mp\_utility::setobjectivescoretext(game["defenders"],&"OBJECTIVES_ONE_FLAG_DEFENDER");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"],&"OBJECTIVES_ONE_FLAG_ATTACKER_SCORE");
		maps\mp\_utility::setobjectivescoretext(game["defenders"],&"OBJECTIVES_ONE_FLAG_DEFENDER_SCORE");
	}

	maps\mp\_utility::setobjectivetext(game["attackers"],&"OBJECTIVES_CTF");
	maps\mp\_utility::setobjectivetext(game["defenders"],&"OBJECTIVES_CTF");
	maps\mp\_utility::setobjectivehinttext(game["attackers"],&"OBJECTIVES_ONE_FLAG_ATTACKER_HINT");
	maps\mp\_utility::setobjectivehinttext(game["defenders"],&"OBJECTIVES_ONE_FLAG_DEFENDER_HINT");
	initspawn();
	var_02[0] = "ctf";
	maps\mp\gametypes\_gameobjects::main(var_02);
	level thread ctf();
	level thread updatescoreboardctf();
}

//Function Number: 4
initspawn()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_ctf_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_ctf_spawn_axis_start");
	level.spawn_name = "mp_ctf_spawn";
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies",level.spawn_name);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis",level.spawn_name);
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 5
getspawnpoint()
{
	var_00 = self.team;
	if(level.usestartspawns && level.ingraceperiod)
	{
		if(!game["switchedsides"])
		{
			var_00 = maps\mp\_utility::getotherteam(var_00);
		}

		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_ctf_spawn_" + var_00 + "_start");
		var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_01);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_02);
		var_02 = maps\mp\gametypes\_spawnscoring::getspawnpoint_ctf(var_02,var_01);
	}

	maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_02);
	return var_02;
}

//Function Number: 6
updatescoreboardctf()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread updatecaptues();
		var_00 thread updatereturns();
		var_00 thread updatedefends();
	}
}

//Function Number: 7
updatecaptues()
{
	waittillframeend;
	maps\mp\_utility::setextrascore0(self.pers["captures"]);
}

//Function Number: 8
updatereturns()
{
	waittillframeend;
	self.assists = self.pers["returns"];
}

//Function Number: 9
updatedefends()
{
	waittillframeend;
	maps\mp\_utility::setextrascore1(self.pers["defends"]);
}

//Function Number: 10
ctf()
{
	level.flagmodel["allies"] = maps\mp\gametypes\_teams::getteamflagmodel("allies");
	level.carryflag["allies"] = maps\mp\gametypes\_teams::getteamflagcarrymodel("allies");
	level.flagmodel["axis"] = maps\mp\gametypes\_teams::getteamflagmodel("axis");
	level.carryflag["axis"] = maps\mp\gametypes\_teams::getteamflagcarrymodel("axis");
	level.iconescort3d = "waypoint_escort";
	level.iconescort2d = "waypoint_escort";
	level.iconkill3d = "waypoint_kill";
	level.iconkill2d = "waypoint_kill";
	level.iconcaptureflag3d = "waypoint_capture_flag";
	level.iconcaptureflag2d = "waypoint_capture_flag";
	level.icondefendflag3d = "waypoint_defend_flag";
	level.icondefendflag2d = "waypoint_defend_flag";
	level.iconreturnflag3d = "waypoint_return_flag";
	level.iconreturnflag2d = "waypoint_return_flag";
	level.iconwaitforflag3d = "waypoint_waitfor_flag";
	level.iconwaitforflag2d = "waypoint_waitfor_flag";
	level.iconawayblue = "waypoint_esports_ctf_taken_blue";
	level.iconawayred = "waypoint_esports_ctf_taken_red";
	level.icondroppedblue = "waypoint_esports_ctf_dropped_blue";
	level.icondroppedred = "waypoint_esports_ctf_dropped_red";
	level.iconatbaseblue = "waypoint_esports_ctf_flag_blue";
	level.iconatbasered = "waypoint_esports_ctf_flag_red";
	level.iconmissingblue = "waypoint_esports_ctf_flag_missing_blue";
	level.iconmissingred = "waypoint_esports_ctf_flag_missing_red";
	level.teamflags[game["defenders"]] = createteamflag(game["defenders"],"allies");
	level.teamflags[game["attackers"]] = createteamflag(game["attackers"],level.otherteam["allies"]);
	level.capzones[game["defenders"]] = createcapzone(game["defenders"],"allies");
	level.capzones[game["attackers"]] = createcapzone(game["attackers"],level.otherteam["allies"]);
	assignteamspawns();
	onresetflaghudstatus("allies");
	onresetflaghudstatus("axis");
}

//Function Number: 11
onresetflaghudstatus(param_00)
{
	if(param_00 == "allies")
	{
		level.alliesflagstatus = 0;
		level.alliesflagcarrierclientnum = -1;
	}
	else
	{
		level.axisflagstatus = 0;
		level.axisflagcarrierclientnum = -1;
	}

	level notify("update_flag_status");
}

//Function Number: 12
onpickupflaghudstatus(param_00)
{
	var_01 = param_00.pers["team"];
	if(var_01 == "allies")
	{
		param_00.objective = 1;
		level.axisflagstatus = 2;
		level.axisflagcarrierclientnum = param_00 getentitynumber();
	}
	else
	{
		param_00.objective = 2;
		level.alliesflagstatus = 2;
		level.alliesflagcarrierclientnum = param_00 getentitynumber();
	}

	level notify("update_flag_status");
}

//Function Number: 13
ondropflaghudstatus(param_00)
{
	if(param_00 == "allies")
	{
		level.alliesflagstatus = 1;
		level.alliesflagcarrierclientnum = -1;
	}
	else
	{
		level.axisflagstatus = 1;
		level.axisflagcarrierclientnum = -1;
	}

	level notify("update_flag_status");
}

//Function Number: 14
playerupdateflagstatus()
{
	if(!isdefined(self.team) || !isdefined(level.alliesflagstatus))
	{
		return;
	}

	var_00 = undefined;
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	if(self.team == "allies" || self.team == "spectator")
	{
		var_00 = level.alliesflagstatus;
		var_01 = level.alliesflagcarrierclientnum;
		var_02 = level.axisflagstatus;
		var_03 = level.axisflagcarrierclientnum;
	}
	else if(self.team == "axis")
	{
		var_00 = level.axisflagstatus;
		var_01 = level.axisflagcarrierclientnum;
		var_02 = level.alliesflagstatus;
		var_03 = level.alliesflagcarrierclientnum;
	}
	else
	{
		return;
	}

	self setclientomnvar("ui_ctf_friendly_status",var_00);
	self setclientomnvar("ui_ctf_friendly_carrier_clientnum",var_01);
	self setclientomnvar("ui_ctf_enemy_status",var_02);
	self setclientomnvar("ui_ctf_enemy_carrier_clientnum",var_03);
	self setclientomnvar("ui_ctf_status_changed",1);
}

//Function Number: 15
playerupdateflagstatusonjointeam()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		playerupdateflagstatus();
	}
}

//Function Number: 16
playerwatchflagstatus()
{
	level endon("game_ended");
	self endon("disconnect");
	playerupdateflagstatus();
	thread playerupdateflagstatusonjointeam();
	for(;;)
	{
		level waittill("update_flag_status");
		playerupdateflagstatus();
	}
}

//Function Number: 17
hidehudelementongameend(param_00)
{
	level waittill("game_ended");
	if(isdefined(param_00))
	{
		param_00.alpha = 0;
	}
}

//Function Number: 18
createteamflag(param_00,param_01)
{
	var_02 = getent("ctf_zone_" + param_01,"targetname");
	if(!isdefined(var_02))
	{
		common_scripts\utility::error("No ctf_zone_" + param_01 + " trigger found in map.");
		return;
	}

	var_03 = getent("ctf_zone_augmented_" + param_01,"targetname");
	if(isdefined(var_03))
	{
		if(maps\mp\_utility::isaugmentedgamemode())
		{
			var_02 delete();
			var_02 = var_03;
		}
		else
		{
			var_03 delete();
		}
	}

	var_04[0] = getent("ctf_flag_" + param_01,"targetname");
	if(!isdefined(var_04[0]))
	{
		common_scripts\utility::error("No ctf_flag_" + param_01 + " script_model found in map.");
		return;
	}

	var_05[0] = getent("ctf_flag_augmented_" + param_01,"targetname");
	if(isdefined(var_05[0]))
	{
		if(maps\mp\_utility::isaugmentedgamemode())
		{
			var_04[0] delete();
			var_04[0] = var_05[0];
		}
		else
		{
			var_05[0] delete();
		}
	}

	var_06 = spawn("trigger_radius",var_02.origin,0,96,var_02.height);
	var_02 = var_06;
	var_04[0] setmodel(level.flagmodel[param_00]);
	var_04[0].oldcontents = var_04[0] setcontents(0);
	var_07 = var_04[0].origin + (0,0,32);
	var_08 = var_04[0].origin + (0,0,-32);
	var_09 = bullettrace(var_07,var_08,0,undefined);
	var_04[0].origin = var_09["position"];
	var_0A = maps\mp\gametypes\_gameobjects::createcarryobject(param_00,var_02,var_04,(0,0,85));
	var_0B = getdvarfloat("scr_ctf_flag_pick_up_time_friendly",0);
	if(var_0B > 0)
	{
		var_0A maps\mp\gametypes\_gameobjects::setteamusetime("friendly",var_0B);
	}

	var_0C = getdvarfloat("scr_ctf_flag_pick_up_time_enemy",0);
	if(var_0C > 0)
	{
		var_0A maps\mp\gametypes\_gameobjects::setteamusetime("enemy",var_0C);
	}

	var_0A maps\mp\gametypes\_gameobjects::setteamusetext("enemy",&"MP_GRABBING_FLAG");
	var_0A maps\mp\gametypes\_gameobjects::setteamusetext("friendly",&"MP_RETURNING_FLAG");
	var_0A maps\mp\gametypes\_gameobjects::allowcarry("enemy");
	var_0A maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	var_0A maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconescort2d);
	var_0A maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconescort3d);
	if(level.pingstate != 2)
	{
		var_0A maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconkill2d);
		var_0A maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.iconkill3d);
	}

	if(maps\mp\_utility::isaugmentedgamemode())
	{
		var_0A.objpingdelay = 2.5;
	}

	var_0A.objidpingfriendly = 1;
	var_0A.allowweapons = 1;
	var_0A.requireslos = 1;
	var_0A.onpickup = ::onpickup;
	var_0A.onpickupfailed = ::onpickup;
	var_0A.ondrop = ::ondrop;
	var_0A.onreset = ::onreset;
	var_0A.goliaththink = ::goliathattachflag;
	var_0A.canuseobject = ::canuse;
	var_0A.goliaththink = ::goliathdropflag;
	var_0A.oldradius = var_02.radius;
	var_0A.origin = var_02.origin;
	var_0A.highestspawndistratio = 0;
	if(level.pingstate == 0)
	{
		var_0A.objidpingfriendly = 0;
	}

	if(param_00 == "allies")
	{
		var_0A maps\mp\gametypes\_gameobjects::set2dicon("mlg",level.iconatbaseblue);
		var_0A maps\mp\gametypes\_gameobjects::set3dicon("mlg",level.iconatbaseblue);
		setomnvar("ui_mlg_game_mode_status_1",0);
	}
	else
	{
		var_0A maps\mp\gametypes\_gameobjects::set2dicon("mlg",level.iconatbasered);
		var_0A maps\mp\gametypes\_gameobjects::set3dicon("mlg",level.iconatbasered);
		setomnvar("ui_mlg_game_mode_status_2",0);
	}

	var_0A thread flageffects();
	return var_0A;
}

//Function Number: 19
createcapzone(param_00,param_01)
{
	var_02 = getent("ctf_zone_" + param_01,"targetname");
	var_03 = getent("ctf_zone_augmented_" + param_01,"targetname");
	if(isdefined(var_03) && maps\mp\_utility::isaugmentedgamemode())
	{
		var_02 = var_03;
	}

	var_04 = [];
	var_05 = maps\mp\gametypes\_gameobjects::createuseobject(param_00,var_02,var_04,(0,0,85));
	var_05 maps\mp\gametypes\_gameobjects::allowuse("friendly");
	var_05 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	var_05 maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.icondefendflag2d);
	var_05 maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.icondefendflag3d);
	var_05 maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconcaptureflag2d);
	var_05 maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconcaptureflag3d);
	var_05 maps\mp\gametypes\_gameobjects::setusetime(0);
	var_05 maps\mp\gametypes\_gameobjects::setkeyobject(level.teamflags[maps\mp\_utility::getotherteam(param_00)]);
	var_05.onuse = ::onuse;
	var_05.oncantuse = ::oncantuse;
	var_06 = var_02.origin + (0,0,32);
	var_07 = var_02.origin + (0,0,-32);
	var_08 = bullettrace(var_06,var_07,0,undefined);
	var_05.baseeffectpos = var_08["position"];
	var_05.baseeffectforward = var_08["normal"];
	var_05 thread capturezoneeffects();
	return var_05;
}

//Function Number: 20
onbeginuse(param_00)
{
	var_01 = param_00.pers["team"];
	if(var_01 == maps\mp\gametypes\_gameobjects::getownerteam())
	{
		self.trigger.radius = 1024;
		return;
	}

	self.trigger.radius = self.oldradius;
}

//Function Number: 21
onenduse(param_00,param_01,param_02)
{
	self.trigger.radius = self.oldradius;
}

//Function Number: 22
onpickup(param_00)
{
	self notify("picked_up");
	var_01 = param_00.pers["team"];
	if(var_01 == "allies")
	{
		var_02 = "axis";
	}
	else
	{
		var_02 = "allies";
	}

	flageffectsstop();
	if(var_01 == maps\mp\gametypes\_gameobjects::getownerteam())
	{
		thread returnflag();
		maps\mp\_utility::leaderdialog("flag_returned",var_01,"status");
		maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_med",var_01);
		maps\mp\_utility::leaderdialog("enemy_flag_returned",var_02,"status");
		maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_med",var_02);
		param_00 thread maps\mp\_events::flagreturnevent();
		onresetflaghudstatus(var_01);
		return;
	}

	if(isdefined(level.ctf_loadouts) && isdefined(level.ctf_loadouts[var_01]))
	{
		param_00 thread applyflagcarrierclass(self);
	}
	else
	{
		param_00 attachflag(self);
	}

	onpickupflaghudstatus(param_00);
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconescort2d);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconescort3d);
	if(level.pingstate != 2)
	{
		maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconkill2d);
		maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.iconkill3d);
	}
	else
	{
		maps\mp\gametypes\_gameobjects::set2dicon("friendly",undefined);
		maps\mp\gametypes\_gameobjects::set3dicon("friendly",undefined);
	}

	level.capzones[var_02] maps\mp\gametypes\_gameobjects::allowuse("none");
	level.capzones[var_02] maps\mp\gametypes\_gameobjects::setvisibleteam("friendly");
	level.capzones[var_02] maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconwaitforflag2d);
	level.capzones[var_02] maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.iconwaitforflag3d);
	var_03 = [param_00];
	maps\mp\_utility::leaderdialog("enemy_flag_taken",var_01,"status");
	maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_sml",var_01,var_03);
	param_00 playlocalsound("mp_ctf_flag_pickup");
	maps\mp\_utility::leaderdialog("flag_taken",var_02,"status");
	maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_sml",var_02);
	if(maps\mp\gametypes\_gameobjects::getownerteam() == "allies")
	{
		level.capzones[var_02] maps\mp\gametypes\_gameobjects::set2dicon("mlg",level.iconmissingblue);
		level.capzones[var_02] maps\mp\gametypes\_gameobjects::set3dicon("mlg",level.iconmissingblue);
		maps\mp\gametypes\_gameobjects::set2dicon("mlg",level.iconawayblue);
		maps\mp\gametypes\_gameobjects::set3dicon("mlg",level.iconawayblue);
		setomnvar("ui_mlg_game_mode_status_1",param_00 getentitynumber());
	}
	else
	{
		level.capzones[var_02] maps\mp\gametypes\_gameobjects::set2dicon("mlg",level.iconmissingred);
		level.capzones[var_02] maps\mp\gametypes\_gameobjects::set3dicon("mlg",level.iconmissingred);
		maps\mp\gametypes\_gameobjects::set2dicon("mlg",level.iconawayred);
		maps\mp\gametypes\_gameobjects::set3dicon("mlg",level.iconawayred);
		setomnvar("ui_mlg_game_mode_status_2",param_00 getentitynumber());
	}

	param_00 thread maps\mp\_events::flagpickupevent();
	thread flagawayvo(param_00,var_01,var_02);
}

//Function Number: 23
flagawayvo(param_00,param_01,param_02)
{
	level endon("game_ended");
	self endon("reset");
	for(;;)
	{
		wait(15);
		if(level.teamflags[param_01] maps\mp\gametypes\_gameobjects::ishome())
		{
			param_00 maps\mp\_utility::leaderdialogonplayer("enemy_flag_bringhome","status");
		}

		maps\mp\_utility::leaderdialog("flag_getback",param_02,"status");
	}
}

//Function Number: 24
returnflag()
{
	maps\mp\gametypes\_gameobjects::returnhome();
}

//Function Number: 25
ondrop(param_00)
{
	var_01 = maps\mp\gametypes\_gameobjects::getownerteam();
	var_02 = level.otherteam[var_01];
	maps\mp\gametypes\_gameobjects::allowcarry("any");
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconreturnflag2d);
	maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.iconreturnflag3d);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconcaptureflag2d);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconcaptureflag3d);
	ondropflaghudstatus(var_01);
	if(var_01 == "allies")
	{
		maps\mp\gametypes\_gameobjects::set2dicon("mlg",level.icondroppedblue);
		maps\mp\gametypes\_gameobjects::set3dicon("mlg",level.icondroppedblue);
		setomnvar("ui_mlg_game_mode_status_1",0 - level.flagreturntime);
	}
	else
	{
		maps\mp\gametypes\_gameobjects::set2dicon("mlg",level.icondroppedred);
		maps\mp\gametypes\_gameobjects::set3dicon("mlg",level.icondroppedred);
		setomnvar("ui_mlg_game_mode_status_2",0 - level.flagreturntime);
	}

	if(isdefined(param_00))
	{
		param_00.objective = 0;
		if(isdefined(param_00.carryflag))
		{
			param_00 detachflag();
		}
	}

	maps\mp\_utility::leaderdialog("flag_dropped",var_01,"status");
	maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_sml",var_01);
	maps\mp\_utility::leaderdialog("enemy_flag_dropped",var_02,"status");
	maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_sml",var_02);
	thread flageffects();
	thread returnaftertime();
}

//Function Number: 26
returnaftertime()
{
	self endon("picked_up");
	self endon("reset");
	wait(level.flagreturntime);
	var_00 = maps\mp\gametypes\_gameobjects::getownerteam();
	var_01 = level.otherteam[var_00];
	maps\mp\_utility::leaderdialog("flag_returned",var_00,"status");
	maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_med",var_00);
	maps\mp\_utility::leaderdialog("enemy_flag_returned",var_01,"status");
	maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_med",var_01);
	thread returnflag();
}

//Function Number: 27
onreset()
{
	var_00 = maps\mp\gametypes\_gameobjects::getownerteam();
	var_01 = level.otherteam[var_00];
	maps\mp\gametypes\_gameobjects::allowcarry("enemy");
	maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconescort2d);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconescort3d);
	if(level.pingstate != 2)
	{
		maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconkill2d);
		maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.iconkill3d);
	}
	else
	{
		maps\mp\gametypes\_gameobjects::set2dicon("friendly",undefined);
		maps\mp\gametypes\_gameobjects::set3dicon("friendly",undefined);
	}

	thread flageffects();
	onresetflaghudstatus(var_00);
	level.capzones[var_00] maps\mp\gametypes\_gameobjects::allowuse("friendly");
	level.capzones[var_00] maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	level.capzones[var_00] maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.icondefendflag2d);
	level.capzones[var_00] maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.icondefendflag3d);
	level.capzones[var_00] maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconcaptureflag2d);
	level.capzones[var_00] maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconcaptureflag3d);
	if(var_00 == "allies")
	{
		level.capzones[var_00] maps\mp\gametypes\_gameobjects::set2dicon("mlg",undefined);
		level.capzones[var_00] maps\mp\gametypes\_gameobjects::set3dicon("mlg",undefined);
		maps\mp\gametypes\_gameobjects::set2dicon("mlg",level.iconatbaseblue);
		maps\mp\gametypes\_gameobjects::set3dicon("mlg",level.iconatbaseblue);
		setomnvar("ui_mlg_game_mode_status_1",0);
		return;
	}

	level.capzones[var_00] maps\mp\gametypes\_gameobjects::set2dicon("mlg",undefined);
	level.capzones[var_00] maps\mp\gametypes\_gameobjects::set3dicon("mlg",undefined);
	maps\mp\gametypes\_gameobjects::set2dicon("mlg",level.iconatbasered);
	maps\mp\gametypes\_gameobjects::set3dicon("mlg",level.iconatbasered);
	setomnvar("ui_mlg_game_mode_status_2",0);
}

//Function Number: 28
onuse(param_00)
{
	var_01 = param_00.pers["team"];
	if(var_01 == "allies")
	{
		var_02 = "axis";
	}
	else
	{
		var_02 = "allies";
	}

	maps\mp\_utility::leaderdialog("enemy_flag_captured",var_01,"status");
	maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_lrg",var_01);
	maps\mp\_utility::leaderdialog("flag_captured",var_02,"status");
	maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_lrg",var_02);
	param_00 thread maps\mp\_events::flagcaptureevent();
	maps\mp\gametypes\_gamescore::giveteamscoreforobjective(var_01,1);
	game["shut_out"][var_02] = 0;
	if(isdefined(param_00))
	{
		param_00.objective = 0;
		if(isdefined(param_00.carryflag))
		{
			param_00 detachflag();
		}
	}

	if(isdefined(level.ctf_loadouts) && isdefined(level.ctf_loadouts[var_01]))
	{
		param_00 thread removeflagcarrierclass();
	}

	level.teamflags[var_02] returnflag();
	if(maps\mp\gametypes\_gameobjects::getownerteam() == "allies")
	{
		setomnvar("ui_mlg_game_mode_status_1",0);
	}
	else
	{
		setomnvar("ui_mlg_game_mode_status_2",0);
	}

	level thread checkroundwin(var_01);
}

//Function Number: 29
checkroundwin(param_00)
{
	var_01 = "roundsWon";
	if(level.winbycaptures)
	{
		var_01 = "teamScores";
	}

	if(maps\mp\_utility::inovertime())
	{
		updateroundswon(param_00);
		if(game["status"] == "overtime")
		{
			game["round_time_to_beat"] = maps\mp\_utility::getminutespassed();
			level thread maps\mp\gametypes\_gamelogic::endgame("overtime_halftime",game["end_reason"]["score_limit_reached"]);
			return;
		}

		if(game["status"] == "overtime_halftime")
		{
			if(game["roundsWon"]["axis"] == game["roundsWon"]["allies"])
			{
				updateroundswon(param_00);
			}

			if(game["teamScores"]["axis"] == game["teamScores"]["allies"])
			{
				game["teamScores"][param_00]++;
			}

			level thread maps\mp\gametypes\_gamelogic::endgame(param_00,game["end_reason"]["score_limit_reached"]);
			return;
		}

		return;
	}

	if(game["teamScores"][param_00] == maps\mp\_utility::getwatcheddvar("scorelimit"))
	{
		updateroundswon(param_00);
		if(game["status"] == "normal")
		{
			game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::gettimepassed();
			level thread maps\mp\gametypes\_gamelogic::endgame("halftime",game["end_reason"]["score_limit_reached"]);
			return;
		}

		if(game["status"] == "halftime")
		{
			var_02 = param_00;
			if(game[var_01]["axis"] == game[var_01]["allies"])
			{
				var_02 = "overtime";
				level.finalkillcam_winner = "none";
			}

			level thread maps\mp\gametypes\_gamelogic::endgame(var_02,game["end_reason"]["switching_sides"]);
			return;
		}

		return;
	}
}

//Function Number: 30
updateroundswon(param_00)
{
	level.finalkillcam_winner = param_00;
	game["roundsWon"][param_00]++;
}

//Function Number: 31
onhalftime(param_00)
{
	ontimelimit();
}

//Function Number: 32
ontimelimit()
{
	level.finalkillcam_winner = "none";
	var_00 = "roundsWon";
	if(level.winbycaptures)
	{
		var_00 = "teamScores";
	}

	if(maps\mp\_utility::inovertime())
	{
		if(game["status"] == "overtime")
		{
			level thread maps\mp\gametypes\_gamelogic::endgame("overtime_halftime",game["end_reason"]["time_limit_reached"]);
			return;
		}

		if(game["status"] == "overtime_halftime")
		{
			var_01 = "tie";
			if(game[var_00]["axis"] > game[var_00]["allies"])
			{
				var_01 = "axis";
			}

			if(game[var_00]["allies"] > game[var_00]["axis"])
			{
				var_01 = "allies";
			}

			level thread maps\mp\gametypes\_gamelogic::endgame(var_01,game["end_reason"]["time_limit_reached"]);
			return;
		}

		return;
	}

	if(game["status"] == "halftime")
	{
		var_01 = "tie";
		if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
		{
			var_01 = "axis";
		}

		if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
		{
			var_01 = "allies";
		}

		if(var_01 == "axis" || var_01 == "allies")
		{
			updateroundswon(var_01);
		}

		if(game[var_00]["axis"] == game[var_00]["allies"])
		{
			var_01 = "overtime";
		}

		level thread maps\mp\gametypes\_gamelogic::endgame(var_01,game["end_reason"]["time_limit_reached"]);
		return;
	}

	if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
	{
		updateroundswon("axis");
	}

	if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
	{
		updateroundswon("allies");
	}

	level thread maps\mp\gametypes\_gamelogic::endgame("halftime",game["end_reason"]["time_limit_reached"]);
}

//Function Number: 33
applyflagcarrierclass(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait(0.05);
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		self notify("lost_juggernaut");
		wait(0.05);
	}

	self.pers["gamemodeLoadout"] = level.ctf_loadouts[self.team];
	self.gamemode_chosenclass = self.class;
	self.gamemode_carrierclass = 1;
	self.pers["class"] = "gamemode";
	self.pers["lastClass"] = "gamemode";
	self.class = "gamemode";
	self.lastclass = "gamemode";
	self notify("faux_spawn");
	maps\mp\gametypes\_class::giveandapplyloadout(self.team,"gamemode");
	if(self.loadoutkeepcurrentkillstreaks)
	{
		maps\mp\killstreaks\_killstreaks::updatekillstreaks(1);
	}

	refillbattery();
	thread waitattachflag(param_00);
}

//Function Number: 34
refillbattery()
{
	var_00 = self getweaponslistoffhands();
	foreach(var_02 in var_00)
	{
		self batteryfullrecharge(var_02);
	}
}

//Function Number: 35
waitattachflag(param_00)
{
	level endon("game_ende");
	self endon("disconnect");
	self endon("death");
	self waittill("spawned_player");
	attachflag(param_00);
}

//Function Number: 36
removeflagcarrierclass()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait(0.05);
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		self notify("lost_juggernaut");
		wait(0.05);
	}

	self.pers["gamemodeLoadout"] = undefined;
	self notify("faux_spawn");
	maps\mp\gametypes\_class::giveandapplyloadout(self.team,self.class);
	if(self.loadoutkeepcurrentkillstreaks)
	{
		maps\mp\killstreaks\_killstreaks::updatekillstreaks(1);
	}

	refillbattery();
}

//Function Number: 37
oncantuse(param_00)
{
}

//Function Number: 38
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_01) && isplayer(param_01) && param_01.pers["team"] != self.pers["team"])
	{
		if(isdefined(param_01.carryflag))
		{
			param_01 thread maps\mp\_events::killwithflagevent();
		}

		if(isdefined(self.carryflag))
		{
			param_01 thread maps\mp\_events::killflagcarrierevent(param_09);
			detachflag();
			return;
		}

		if(isdefined(param_04) && maps\mp\_utility::iskillstreakweapon(param_04))
		{
			return;
		}

		var_0A = 9216;
		foreach(var_0C in level.capzones)
		{
			var_0D = distance2dsquared(param_01.origin,var_0C.curorigin);
			var_0E = distance2dsquared(self.origin,var_0C.curorigin);
			if(var_0C.ownerteam == param_01.team)
			{
				if(var_0D < var_0A || var_0E < var_0A)
				{
					param_01 thread maps\mp\_events::defendobjectiveevent(self,param_09);
					param_01 maps\mp\_utility::setextrascore1(param_01.pers["defends"]);
				}
			}

			if(var_0C.ownerteam == self.team)
			{
				if(var_0D < var_0A || var_0E < var_0A)
				{
					param_01 thread maps\mp\_events::assaultobjectiveevent(self,param_09);
				}
			}
		}

		return;
	}

	if(isdefined(self.carryflag))
	{
		detachflag();
	}
}

//Function Number: 39
attachflag(param_00)
{
	var_01 = level.otherteam[self.pers["team"]];
	self attach(level.carryflag[var_01],"J_SpineUpper",1);
	self.carryflag = level.carryflag[var_01];
	param_00 thread flageffects();
}

//Function Number: 40
goliathattachflag()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("lost_ctf_flag");
	self waittill("goliath_equipped");
	wait(1);
	if(isdefined(self.carryflag))
	{
		self attach(self.carryflag,"J_SpineUpper",1);
	}

	if(isdefined(self.carryobject))
	{
		self.carryobject thread flageffects();
	}
}

//Function Number: 41
canuse(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 maps\mp\_utility::isjuggernaut())
	{
		return 0;
	}

	if(isdefined(param_00.enteringgoliath) && param_00.enteringgoliath == 1)
	{
		return 0;
	}

	return 1;
}

//Function Number: 42
goliathdropflag()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self waittill("goliath_equipped");
	if(isdefined(self.carryobject))
	{
		self.carryflag = undefined;
		self.carryobject thread maps\mp\gametypes\_gameobjects::setdropped();
	}
}

//Function Number: 43
detachflag()
{
	self notify("lost_ctf_flag");
	var_00 = "J_SpineUpper";
	self detach(self.carryflag,var_00);
	self.carryflag = undefined;
}

//Function Number: 44
setspecialloadouts()
{
	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","axis",5,"class","inUse"))
	{
		level.ctf_loadouts["axis"] = maps\mp\_utility::getmatchrulesspecialclass("axis",5);
	}

	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","allies",5,"class","inUse"))
	{
		level.ctf_loadouts["allies"] = maps\mp\_utility::getmatchrulesspecialclass("allies",5);
	}
}

//Function Number: 45
assignteamspawns()
{
	var_00 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_ctf_spawn");
	level.teamspawnpoints["axis"] = [];
	level.teamspawnpoints["allies"] = [];
	foreach(var_02 in var_00)
	{
		var_02.teambase = getnearestflagteam(var_02);
		if(var_02.teambase == "axis")
		{
			level.teamspawnpoints["axis"][level.teamspawnpoints["axis"].size] = var_02;
			continue;
		}

		level.teamspawnpoints["allies"][level.teamspawnpoints["allies"].size] = var_02;
	}
}

//Function Number: 46
reassign_ctf_team_spawns()
{
	var_00 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_ctf_spawn");
	level.teamspawnpoints["axis"] = [];
	level.teamspawnpoints["allies"] = [];
	foreach(var_02 in var_00)
	{
		var_02.teambase = get_nearest_capzone_team(var_02);
		if(var_02.teambase == "axis")
		{
			level.teamspawnpoints["axis"][level.teamspawnpoints["axis"].size] = var_02;
			continue;
		}

		level.teamspawnpoints["allies"][level.teamspawnpoints["allies"].size] = var_02;
	}
}

//Function Number: 47
get_nearest_capzone_team(param_00)
{
	var_01 = maps\mp\gametypes\_spawnlogic::ispathdataavailable();
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_05 in level.capzones)
	{
		var_06 = undefined;
		if(var_01)
		{
			var_06 = getpathdist(param_00.origin,var_05.curorigin,999999);
		}

		if(!isdefined(var_06) || var_06 == -1)
		{
			var_06 = distancesquared(var_05.curorigin,param_00.origin);
		}

		if(!isdefined(var_02) || var_06 < var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	return var_02.ownerteam;
}

//Function Number: 48
getnearestflagteam(param_00)
{
	var_01 = maps\mp\gametypes\_spawnlogic::ispathdataavailable();
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	if(var_01)
	{
		var_03 = getpathdist(param_00.origin,level.teamflags["allies"].origin,999999);
		var_04 = getpathdist(param_00.origin,level.teamflags["axis"].origin,999999);
	}

	if(!isdefined(var_03) || var_03 == -1)
	{
		var_03 = distancesquared(level.teamflags["allies"].origin,param_00.origin);
	}

	if(!isdefined(var_04) || var_04 == -1)
	{
		var_04 = distancesquared(level.teamflags["axis"].origin,param_00.origin);
	}

	if(isdefined(param_00.script_noteworthy))
	{
		if((game["switchedsides"] && param_00.script_noteworthy == "axis_override") || !game["switchedsides"] && param_00.script_noteworthy == "allies_override")
		{
			var_02 = "allies";
			param_00.friendlyflag = level.teamflags["allies"];
			param_00.friendlyflagdist = var_03;
			param_00.enemyflagdist = var_04;
		}
		else if((game["switchedsides"] && param_00.script_noteworthy == "allies_override") || !game["switchedsides"] && param_00.script_noteworthy == "axis_override")
		{
			var_02 = "axis";
			param_00.friendlyflag = level.teamflags["axis"];
			param_00.friendlyflagdist = var_04;
			param_00.enemyflagdist = var_03;
		}
	}

	if(!isdefined(var_02))
	{
		var_02 = common_scripts\utility::ter_op(var_03 < var_04,"allies","axis");
		param_00.friendlyflag = common_scripts\utility::ter_op(var_03 < var_04,level.teamflags["allies"],level.teamflags["axis"]);
		param_00.friendlyflagdist = common_scripts\utility::ter_op(var_03 < var_04,var_03,var_04);
		param_00.enemyflagdist = common_scripts\utility::ter_op(var_03 > var_04,var_03,var_04);
	}

	var_05 = param_00.friendlyflagdist / param_00.enemyflagdist;
	if(param_00.friendlyflag.highestspawndistratio < var_05)
	{
		param_00.friendlyflag.highestspawndistratio = var_05;
	}

	return var_02;
}

//Function Number: 49
flageffectsstop()
{
	friendlyenemyeffectsstop();
}

//Function Number: 50
flageffects()
{
	waittillframeend;
	if(isdefined(self.carrier))
	{
		friendlyenemylinkedeffects(level.flagstowedfxid,self.carrier,"tag_fx_flag");
		return;
	}

	var_00 = self.visuals[0];
	friendlyenemyeffects(level.flaggroundfxid,var_00.origin,anglestoup(var_00.angles));
}

//Function Number: 51
capturezoneeffects()
{
	waittillframeend;
	friendlyenemyeffects(level.flagbasefxid,self.baseeffectpos,self.baseeffectforward);
}

//Function Number: 52
friendlyenemyeffectsstop()
{
	if(isdefined(self.friendlyfx))
	{
		self.friendlyfx delete();
	}

	if(isdefined(self.enemyfx))
	{
		self.enemyfx delete();
	}
}

//Function Number: 53
friendlyenemylinkedeffects(param_00,param_01,param_02)
{
	var_03 = self.ownerteam;
	var_04 = param_00[game[var_03]]["friendly"];
	var_05 = param_00[game[var_03]]["enemy"];
	friendlyenemyeffectsstop();
	self.friendlyfx = spawnlinkedfxshowtoteam(var_04,var_03,param_01,param_02);
	self.enemyfx = spawnlinkedfxshowtoteam(var_05,maps\mp\_utility::getotherteam(var_03),param_01,param_02);
}

//Function Number: 54
friendlyenemyeffects(param_00,param_01,param_02)
{
	var_03 = self.ownerteam;
	var_04 = param_00[game[var_03]]["friendly"];
	var_05 = param_00[game[var_03]]["enemy"];
	friendlyenemyeffectsstop();
	self.friendlyfx = maps\mp\_utility::spawnfxshowtoteam(var_04,var_03,param_01,param_02);
	self.enemyfx = maps\mp\_utility::spawnfxshowtoteam(var_05,maps\mp\_utility::getotherteam(var_03),param_01,param_02);
}

//Function Number: 55
spawnlinkedfxshowtoteam(param_00,param_01,param_02,param_03)
{
	var_04 = spawnlinkedfx(param_00,param_02,param_03);
	var_04 maps\mp\_utility::fxshowtoteam(param_01);
	return var_04;
}

//Function Number: 56
capturezone_reset_base_effects()
{
	foreach(var_01 in level.teamflags)
	{
		if(var_01.visuals.size)
		{
			var_02 = var_01.visuals[0].origin + (0,0,32);
			var_03 = var_01.visuals[0].origin + (0,0,-32);
			var_04 = bullettrace(var_02,var_03,0,undefined);
			var_05 = vectortoangles(var_04["normal"]);
			var_01.baseeffectforward = anglestoforward(var_05);
			var_01.baseeffectpos = var_04["position"];
			var_01 thread flageffects();
			var_06 = level.capzones[var_01.ownerteam];
			var_06.baseeffectforward = var_01.baseeffectforward;
			var_06.baseeffectpos = var_01.baseeffectpos;
			var_06 thread capturezoneeffects();
		}
	}
}

//Function Number: 57
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread playerwatchflagstatus();
	}
}