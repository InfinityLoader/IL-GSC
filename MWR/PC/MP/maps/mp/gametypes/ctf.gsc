/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\ctf.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 63
 * Decompile Time: 1142 ms
 * Timestamp: 10/27/2023 2:38:06 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::setupcallbacks();
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

	if(!isdefined(game["time_to_beat_axis"]))
	{
		game["time_to_beat_axis"] = 0;
	}

	if(!isdefined(game["time_to_beat_allies"]))
	{
		game["time_to_beat_allies"] = 0;
	}

	maps\mp\_utility::setcarrierloadouts();
	level.assists_count_disabled = 1;
	level.teambased = 1;
	level.objectivebased = 1;
	level.overtimescorewinoverride = 1;
	level.onlyroundoverride = 1;
	level.pingstate = maps\mp\_utility::getintproperty("scr_ctf_ping_carrier",1);
	level.winbycaptures = maps\mp\_utility::getintproperty("scr_ctf_win_by_captures",0);
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.ontimelimit = ::ontimelimit;
	level.onhalftime = ::onhalftime;
	level.onoutcomenotify = ::onoutcomenotify;
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
	game["dialog"]["offense_obj"] = "ctf_start";
	game["dialog"]["defense_obj"] = "ctf_start";
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
	setdynamicdvar("scr_ctf_ping_carrier",getmatchrulesdata("ctfData","enemyCarrierIcon"));
	setdynamicdvar("scr_ctf_win_by_captures",getmatchrulesdata("ctfData","winByCaptures"));
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
	level.flagstowedfxid["marines"]["friendly"] = loadfx("vfx/unique/vfx_ctf_usmc_blue");
	level.flagstowedfxid["marines"]["enemy"] = loadfx("vfx/unique/vfx_ctf_usmc_red");
	level.flagstowedfxid["sas"]["friendly"] = loadfx("vfx/unique/vfx_ctf_sas_blue");
	level.flagstowedfxid["sas"]["enemy"] = loadfx("vfx/unique/vfx_ctf_sas_red");
	level.flagstowedfxid["opfor"]["friendly"] = loadfx("vfx/unique/vfx_ctf_arab_blue");
	level.flagstowedfxid["opfor"]["enemy"] = loadfx("vfx/unique/vfx_ctf_arab_red");
	level.flagstowedfxid["russian"]["friendly"] = loadfx("vfx/unique/vfx_ctf_spet_blue");
	level.flagstowedfxid["russian"]["enemy"] = loadfx("vfx/unique/vfx_ctf_spet_red");
	level.flaggroundfxid["marines"]["friendly"] = loadfx("vfx/unique/vfx_ctf_usmc_blue_grnd");
	level.flaggroundfxid["marines"]["enemy"] = loadfx("vfx/unique/vfx_ctf_usmc_red_grnd");
	level.flaggroundfxid["sas"]["friendly"] = loadfx("vfx/unique/vfx_ctf_sas_blue_grnd");
	level.flaggroundfxid["sas"]["enemy"] = loadfx("vfx/unique/vfx_ctf_sas_red_grnd");
	level.flaggroundfxid["opfor"]["friendly"] = loadfx("vfx/unique/vfx_ctf_arab_blue_grnd");
	level.flaggroundfxid["opfor"]["enemy"] = loadfx("vfx/unique/vfx_ctf_arab_red_grnd");
	level.flaggroundfxid["russian"]["friendly"] = loadfx("vfx/unique/vfx_ctf_spet_blue_grnd");
	level.flaggroundfxid["russian"]["enemy"] = loadfx("vfx/unique/vfx_ctf_spet_red_grnd");
	flagbasefxdefault();
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
flagbasefxdefault()
{
	setflagbasefx("vfx/unique/vfx_marker_ctf","vfx/unique/vfx_marker_ctf_red");
}

//Function Number: 5
flagbasefxdark()
{
	setflagbasefx("vfx/unique/vfx_marker_ctf_drk","vfx/unique/vfx_marker_ctf_red_drk");
}

//Function Number: 6
setflagbasefx(param_00,param_01)
{
	if(!isdefined(level.flagbasefxid))
	{
		level.flagbasefxid = [];
	}

	var_02 = ["marines","sas","opfor","russian"];
	foreach(var_04 in var_02)
	{
		if(!isdefined(level.flagbasefxid[var_04]))
		{
			level.flagbasefxid[var_04] = [];
		}

		if(!isdefined(level.flagbasefxid[var_04]["friendly"]))
		{
			level.flagbasefxid[var_04]["friendly"] = loadfx(param_00);
		}

		if(!isdefined(level.flagbasefxid[var_04]["enemy"]))
		{
			level.flagbasefxid[var_04]["enemy"] = loadfx(param_01);
		}
	}
}

//Function Number: 7
initspawn()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_ctf_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_ctf_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_ctf_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_ctf_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 8
getspawnpoint()
{
	var_00 = self.team;
	if(level.usestartspawns && level.ingraceperiod)
	{
		if(game["switchedsides"])
		{
			var_00 = maps\mp\_utility::getotherteam(var_00);
		}

		var_01 = maps\mp\gametypes\_spawnlogic::getrandomstartspawn("mp_ctf_spawn_" + var_00 + "_start");
	}
	else
	{
		var_02 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_01);
		var_01 = maps\mp\gametypes\_spawnscoring::getspawnpoint_ctf(var_02,var_00);
	}

	maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_01);
	return var_01;
}

//Function Number: 9
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

//Function Number: 10
updatecaptues()
{
	waittillframeend;
	maps\mp\_utility::setextrascore0(self.pers["captures"]);
}

//Function Number: 11
updatereturns()
{
	waittillframeend;
	self.assists = self.pers["returns"];
}

//Function Number: 12
updatedefends()
{
	waittillframeend;
	maps\mp\_utility::setextrascore1(self.pers["defends"]);
}

//Function Number: 13
ctf()
{
	level.flagmodel["allies"] = "tag_origin";
	level.carryflag["allies"] = "tag_origin";
	level.flagmodel["axis"] = "tag_origin";
	level.carryflag["axis"] = "tag_origin";
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
	level.teamflags[game["defenders"]] = createteamflag(game["defenders"]);
	level.teamflags[game["attackers"]] = createteamflag(game["attackers"]);
	level.capzones[game["defenders"]] = createcapzone(game["defenders"]);
	level.capzones[game["attackers"]] = createcapzone(game["attackers"]);
	assignteamspawns();
	onresetflaghudstatus("allies");
	onresetflaghudstatus("axis");
}

//Function Number: 14
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

//Function Number: 15
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

//Function Number: 16
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

//Function Number: 17
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

//Function Number: 18
playerupdateflagstatusonjointeam()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		playerupdateflagstatus();
		playerupdatetimetobeatomnvars();
	}
}

//Function Number: 19
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

//Function Number: 20
hidehudelementongameend(param_00)
{
	level waittill("game_ended");
	if(isdefined(param_00))
	{
		param_00.alpha = 0;
	}
}

//Function Number: 21
createteamflag(param_00)
{
	var_01 = param_00;
	if(game["switchedsides"])
	{
		var_01 = maps\mp\_utility::getotherteam(param_00);
	}

	var_02 = getent("ctf_zone_" + var_01,"targetname");
	if(!isdefined(var_02))
	{
		common_scripts\utility::error("No ctf_zone_" + var_01 + " trigger found in map.");
		return;
	}

	var_03[0] = getent("ctf_flag_" + var_01,"targetname");
	if(!isdefined(var_03[0]))
	{
		common_scripts\utility::error("No ctf_flag_" + var_01 + " script_model found in map.");
		return;
	}

	var_04 = spawn("trigger_radius",var_02.origin,0,96,var_02.height);
	var_02 = var_04;
	var_03[0] setmodel(level.flagmodel[param_00]);
	var_03[0].oldcontents = var_03[0] setcontents(0);
	var_05 = var_03[0].origin + (0,0,32);
	var_06 = var_03[0].origin + (0,0,-32);
	var_07 = bullettrace(var_05,var_06,0,undefined);
	var_03[0].origin = var_07["position"];
	var_08 = maps\mp\gametypes\_gameobjects::createcarryobject(param_00,var_02,var_03,(0,0,85));
	var_09 = getdvarfloat("scr_ctf_flag_pick_up_time_friendly",0);
	if(var_09 > 0)
	{
		var_08 maps\mp\gametypes\_gameobjects::setteamusetime("friendly",var_09);
	}

	var_0A = getdvarfloat("scr_ctf_flag_pick_up_time_enemy",0);
	if(var_0A > 0)
	{
		var_08 maps\mp\gametypes\_gameobjects::setteamusetime("enemy",var_0A);
	}

	var_08 maps\mp\gametypes\_gameobjects::setteamusetext("enemy",&"MP_GRABBING_FLAG");
	var_08 maps\mp\gametypes\_gameobjects::setteamusetext("friendly",&"MP_RETURNING_FLAG");
	var_08 maps\mp\gametypes\_gameobjects::allowcarry("enemy");
	var_08 maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	var_08 maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconescort2d);
	var_08 maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconescort3d);
	if(level.pingstate != 2)
	{
		var_08 maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconkill2d);
		var_08 maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.iconkill3d);
	}
	else
	{
		var_08 maps\mp\gametypes\_gameobjects::set2dicon("friendly",undefined);
		var_08 maps\mp\gametypes\_gameobjects::set3dicon("friendly",undefined);
	}

	if(maps\mp\_utility::isaugmentedgamemode())
	{
		var_08.objpingdelay = 2.5;
	}

	var_08.objidpingfriendly = 1;
	var_08.allowweapons = 1;
	var_08.requireslos = 1;
	var_08.onpickup = ::onpickup;
	var_08.onpickupfailed = ::onpickup;
	var_08.ondrop = ::ondrop;
	var_08.onreset = ::onreset;
	var_08.goliaththink = ::goliathattachflag;
	var_08.canuseobject = ::canuse;
	var_08.goliaththink = ::goliathdropflag;
	var_08.oldradius = var_02.radius;
	var_08.origin = var_02.origin;
	var_08.highestspawndistratio = 0;
	if(level.pingstate == 0)
	{
		var_08.objidpingfriendly = 0;
	}

	if(param_00 == "allies")
	{
		var_08 maps\mp\gametypes\_gameobjects::set2dicon("mlg",level.iconatbaseblue);
		var_08 maps\mp\gametypes\_gameobjects::set3dicon("mlg",level.iconatbaseblue);
		setomnvar("ui_mlg_game_mode_status_1",0);
	}
	else
	{
		var_08 maps\mp\gametypes\_gameobjects::set2dicon("mlg",level.iconatbasered);
		var_08 maps\mp\gametypes\_gameobjects::set3dicon("mlg",level.iconatbasered);
		setomnvar("ui_mlg_game_mode_status_2",0);
	}

	thread maps\mp\_utility::streamcarrierweaponstoplayers(var_08,[maps\mp\_utility::getotherteam(var_01)],::shouldstreamcarrierclasstoplayer);
	var_08 thread flageffects();
	return var_08;
}

//Function Number: 22
shouldstreamcarrierclasstoplayer(param_00,param_01)
{
	if(isdefined(param_00.carrier) && param_00.carrier == param_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 23
createcapzone(param_00)
{
	var_01 = param_00;
	if(game["switchedsides"])
	{
		var_01 = maps\mp\_utility::getotherteam(param_00);
	}

	var_02 = getent("ctf_zone_" + var_01,"targetname");
	var_03 = [];
	var_04 = maps\mp\gametypes\_gameobjects::createuseobject(param_00,var_02,var_03,(0,0,85));
	var_04 maps\mp\gametypes\_gameobjects::allowuse("friendly");
	var_04 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	var_04 maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.icondefendflag2d);
	var_04 maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.icondefendflag3d);
	var_04 maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconcaptureflag2d);
	var_04 maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconcaptureflag3d);
	var_04 maps\mp\gametypes\_gameobjects::setusetime(0);
	var_04 maps\mp\gametypes\_gameobjects::setkeyobject(level.teamflags[maps\mp\_utility::getotherteam(param_00)]);
	var_04.onuse = ::onuse;
	var_04.oncantuse = ::oncantuse;
	var_05 = var_02.origin + (0,0,32);
	var_06 = var_02.origin + (0,0,-32);
	var_07 = bullettrace(var_05,var_06,0,undefined);
	var_04.baseeffectpos = var_07["position"];
	var_04.baseeffectforward = var_07["normal"];
	var_04 thread capturezoneeffects();
	return var_04;
}

//Function Number: 24
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

//Function Number: 25
onenduse(param_00,param_01,param_02)
{
	self.trigger.radius = self.oldradius;
}

//Function Number: 26
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

	if(isdefined(level.carrierloadouts) && isdefined(level.carrierloadouts[var_01]))
	{
		param_00 thread waitattachflag(self);
		param_00 thread maps\mp\_utility::applycarrierclass();
	}
	else
	{
		param_00 attachflag(self);
	}

	thread bringhomeflagvo(param_00,var_01);
	thread getflagbackvo(var_02);
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
	param_00 playlocalsound("h1_mp_flag_grab");
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
}

//Function Number: 27
bringhomeflagvo(param_00,param_01)
{
	level endon("game_ended");
	self endon("reset");
	param_00 endon("death");
	param_00 endon("disconnect");
	for(;;)
	{
		wait(15);
		if(level.teamflags[param_01] maps\mp\gametypes\_gameobjects::ishome())
		{
			param_00 maps\mp\_utility::leaderdialogonplayer("enemy_flag_bringhome","status");
		}
	}
}

//Function Number: 28
getflagbackvo(param_00)
{
	level endon("game_ended");
	self endon("reset");
	var_01 = getflagstatus(param_00);
	if(var_01 == 1)
	{
		return;
	}

	for(;;)
	{
		wait(15);
		maps\mp\_utility::leaderdialog("flag_getback",param_00,"status");
	}
}

//Function Number: 29
getflagstatus(param_00)
{
	if(param_00 == "allies")
	{
		return level.alliesflagstatus;
	}

	if(param_00 == "axis")
	{
		return level.axisflagstatus;
	}
}

//Function Number: 30
returnflag()
{
	maps\mp\gametypes\_gameobjects::returnhome();
}

//Function Number: 31
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

//Function Number: 32
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

//Function Number: 33
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

//Function Number: 34
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
	maps\mp\_utility::playsoundonplayers("h1_mp_war_objective_taken",var_01);
	maps\mp\_utility::leaderdialog("flag_captured",var_02,"status");
	maps\mp\_utility::playsoundonplayers("h1_mp_war_objective_lost",var_02);
	param_00 thread maps\mp\_events::flagcaptureevent();
	if(!maps\mp\_utility::inovertime())
	{
		maps\mp\gametypes\_gamescores::giveteamscoreforobjective(var_01,1);
	}

	game["shut_out"][var_02] = 0;
	if(isdefined(param_00))
	{
		param_00.objective = 0;
		if(isdefined(param_00.carryflag))
		{
			param_00 detachflag();
		}
	}

	if(isdefined(level.carrierloadouts) && isdefined(level.carrierloadouts[var_01]))
	{
		param_00 thread maps\mp\_utility::removecarrierclass();
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

//Function Number: 35
settimetobeat(param_00)
{
	var_01 = maps\mp\_utility::gettimepassed();
	var_02 = "time_to_beat_" + param_00;
	if(!game[var_02] || var_01 < game[var_02])
	{
		game[var_02] = var_01;
		updatetimetobeatomnvar();
	}
}

//Function Number: 36
updatetimetobeatomnvar()
{
	foreach(var_01 in level.players)
	{
		var_01 playerupdatetimetobeatomnvars();
	}
}

//Function Number: 37
playerupdatetimetobeatomnvars()
{
	var_00 = ["allies","axis"];
	foreach(var_02 in var_00)
	{
		if(self.team == var_02)
		{
			self setclientomnvar("ui_friendly_time_to_beat",game["time_to_beat_" + var_02]);
			continue;
		}

		self setclientomnvar("ui_enemy_time_to_beat",game["time_to_beat_" + var_02]);
	}
}

//Function Number: 38
checkroundwin(param_00)
{
	var_01 = "roundsWon";
	if(level.winbycaptures)
	{
		var_01 = "teamScores";
	}

	if(maps\mp\_utility::inovertime())
	{
		level.finalkillcam_winner = param_00;
		settimetobeat(param_00);
		if(game["status"] == "overtime")
		{
			game["teamScoredFirstHalf"] = param_00;
			game["round_time_to_beat"] = maps\mp\_utility::getminutespassed();
			level thread maps\mp\gametypes\_gamelogic::endgame("overtime_halftime",game["end_reason"]["score_limit_reached"]);
			return;
		}

		if(game["status"] == "overtime_halftime")
		{
			updateroundswon(param_00);
			game["teamScores"][param_00]++;
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

			level thread maps\mp\gametypes\_gamelogic::endgame(var_02,game["end_reason"]["score_limit_reached"]);
			return;
		}

		return;
	}
}

//Function Number: 39
updateroundswon(param_00)
{
	level.finalkillcam_winner = param_00;
	game["roundsWon"][param_00]++;
}

//Function Number: 40
onoutcomenotify(param_00,param_01,param_02,param_03)
{
	if(!level.winbycaptures)
	{
		if(maps\mp\_utility::is_true(param_03) || param_00 == "halftime" || param_00 == "overtime")
		{
			setteamscore("allies",game["roundsWon"]["allies"]);
			setteamscore("axis",game["roundsWon"]["axis"]);
		}
	}
}

//Function Number: 41
onhalftime(param_00)
{
	ontimelimit();
}

//Function Number: 42
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
			var_01 = game["teamScoredFirstHalf"];
			if(isdefined(var_01))
			{
				updateroundswon(var_01);
				game["teamScores"][var_01]++;
			}

			var_02 = "tie";
			if(game[var_00]["axis"] > game[var_00]["allies"])
			{
				var_02 = "axis";
			}

			if(game[var_00]["allies"] > game[var_00]["axis"])
			{
				var_02 = "allies";
			}

			level thread maps\mp\gametypes\_gamelogic::endgame(var_02,game["end_reason"]["time_limit_reached"]);
			return;
		}

		return;
	}

	if(game["status"] == "halftime")
	{
		var_02 = "tie";
		if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
		{
			var_02 = "axis";
		}

		if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
		{
			var_02 = "allies";
		}

		if(var_02 == "axis" || var_02 == "allies")
		{
			updateroundswon(var_02);
		}

		if(game[var_01]["axis"] == game[var_01]["allies"])
		{
			var_02 = "overtime";
		}

		level thread maps\mp\gametypes\_gamelogic::endgame(var_02,game["end_reason"]["time_limit_reached"]);
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

//Function Number: 43
waitattachflag(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self waittill("applyLoadout");
	attachflag(param_00);
}

//Function Number: 44
oncantuse(param_00)
{
}

//Function Number: 45
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_01) && isplayer(param_01) && param_01.pers["team"] != self.pers["team"])
	{
		var_0A = isdefined(param_04) && maps\mp\_utility::iskillstreakweapon(param_04);
		if(isdefined(param_01.carryflag) && !var_0A)
		{
			param_01 thread maps\mp\_events::killwithflagevent();
		}

		if(isdefined(self.carryflag))
		{
			param_01 thread maps\mp\_events::killflagcarrierevent(param_09);
			detachflag();
			return;
		}

		if(var_0A)
		{
			return;
		}

		var_0B = 65536;
		foreach(var_0D in level.capzones)
		{
			var_0E = distance2dsquared(param_01.origin,var_0D.curorigin);
			var_0F = distance2dsquared(self.origin,var_0D.curorigin);
			if(var_0D.ownerteam == param_01.team)
			{
				if(var_0E < var_0B || var_0F < var_0B)
				{
					param_01 thread maps\mp\_events::defendobjectiveevent(self,param_09);
					param_01 maps\mp\_utility::setextrascore1(param_01.pers["defends"]);
				}
			}

			if(var_0D.ownerteam == self.team)
			{
				if(var_0E < var_0B || var_0F < var_0B)
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

//Function Number: 46
attachflag(param_00)
{
	var_01 = level.otherteam[self.pers["team"]];
	self attach(level.carryflag[var_01],"J_SpineUpper",1);
	self.carryflag = level.carryflag[var_01];
	param_00 thread flageffects();
}

//Function Number: 47
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

//Function Number: 48
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

	return 1;
}

//Function Number: 49
goliathdropflag()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self waittill("goliath_equipped");
	if(isdefined(self.carryobject))
	{
		self.carryflag = undefined;
		self.carryobject thread maps\mp\gametypes\_gameobjects::setdropped();
	}
}

//Function Number: 50
detachflag()
{
	self notify("lost_ctf_flag");
	var_00 = "J_SpineUpper";
	self detach(self.carryflag,var_00);
	self.carryflag = undefined;
}

//Function Number: 51
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

//Function Number: 52
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

//Function Number: 53
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

//Function Number: 54
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

//Function Number: 55
flageffectsstop()
{
	friendlyenemyeffectsstop();
}

//Function Number: 56
flageffects()
{
	waittillframeend;
	if(isdefined(self.carrier))
	{
		friendlyenemylinkedeffects(level.flagstowedfxid,self.carrier,"J_SpineUpper");
		return;
	}

	var_00 = self.visuals[0];
	friendlyenemyeffects(level.flaggroundfxid,var_00.origin,anglestoforward(var_00.angles));
}

//Function Number: 57
capturezoneeffects()
{
	waittillframeend;
	friendlyenemyeffects(level.flagbasefxid,self.baseeffectpos,self.baseeffectforward);
}

//Function Number: 58
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

//Function Number: 59
friendlyenemylinkedeffects(param_00,param_01,param_02)
{
	var_03 = self.ownerteam;
	var_04 = param_00[game[var_03]]["friendly"];
	var_05 = param_00[game[var_03]]["enemy"];
	friendlyenemyeffectsstop();
	self.friendlyfx = spawnlinkedfxshowtoteam(var_04,var_03,param_01,param_02);
	self.enemyfx = spawnlinkedfxshowtoteam(var_05,maps\mp\_utility::getotherteam(var_03),param_01,param_02);
}

//Function Number: 60
friendlyenemyeffects(param_00,param_01,param_02)
{
	var_03 = self.ownerteam;
	var_04 = param_00[game[var_03]]["friendly"];
	var_05 = param_00[game[var_03]]["enemy"];
	friendlyenemyeffectsstop();
	self.friendlyfx = maps\mp\_utility::spawnfxshowtoteam(var_04,var_03,param_01,param_02);
	self.enemyfx = maps\mp\_utility::spawnfxshowtoteam(var_05,maps\mp\_utility::getotherteam(var_03),param_01,param_02);
}

//Function Number: 61
spawnlinkedfxshowtoteam(param_00,param_01,param_02,param_03)
{
	var_04 = spawnlinkedfx(param_00,param_02,param_03);
	var_04 maps\mp\_utility::fxshowtoteam(param_01);
	return var_04;
}

//Function Number: 62
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

//Function Number: 63
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread playerwatchflagstatus();
	}
}