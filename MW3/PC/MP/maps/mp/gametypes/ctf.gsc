/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\ctf.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 576 ms
 * Timestamp: 10/27/2023 2:13:09 AM
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

	maps\mp\_utility::setovertimelimitdvar(4);
	func_3989();
	level.teambased = 1;
	level.objectivebased = 1;
	level.overtimescorewinoverride = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.initgametypeawards = ::initgametypeawards;
	level.ontimelimit = ::ontimelimit;
	level.onspawnplayer = ::onspawnplayer;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	level.flagreturntime = maps\mp\_utility::getintproperty("scr_ctf_returntime",30);
	game["dialog"]["gametype"] = "captureflag";
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

	game["dialog"]["offense_obj"] = "capture_obj";
	game["dialog"]["defense_obj"] = "capture_obj";
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	setdynamicdvar("scr_ctf_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar("ctf",1);
	setdynamicdvar("scr_ctf_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("ctf",1);
	setdynamicdvar("scr_ctf_halftime",0);
	maps\mp\_utility::registerhalftimedvar("ctf",0);
	setdynamicdvar("scr_ctf_returntime",30);
	setdynamicdvar("scr_ctf_promode",0);
}

//Function Number: 3
onprecachegametype()
{
	precachestring(&"MP_FLAG_TAKEN_BY");
	precachestring(&"MP_ENEMY_FLAG_TAKEN_BY");
	precachestring(&"MP_FLAG_CAPTURED_BY");
	precachestring(&"MP_ENEMY_FLAG_CAPTURED_BY");
	precachestring(&"MP_FLAG_RETURNED");
	precachestring(&"MP_ENEMY_FLAG_RETURNED");
	precachestring(&"MP_YOUR_FLAG_RETURNING_IN");
	precachestring(&"MP_ENEMY_FLAG_RETURNING_IN");
	precachestring(&"MP_ENEMY_FLAG_DROPPED_BY");
	precachestring(&"MP_DOM_NEUTRAL_FLAG_CAPTURED");
	precachestring(&"MP_GRABBING_FLAG");
	precachestring(&"MP_RETURNING_FLAG");
}

//Function Number: 4
onspawnplayer()
{
}

//Function Number: 5
func_3979()
{
	self endon("disconnect");
	wait 0.25;
	self.otspawned = 1;
	var_00 = maps\mp\_utility::getobjectivehinttext(self.team);
	thread maps\mp\gametypes\_hud_message::hintmessage(var_00);
}

//Function Number: 6
onstartgametype()
{
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(maps\mp\_utility::inovertime())
	{
		setdvar("ui_override_halftime",0);
	}
	else if(game["switchedsides"])
	{
		setdvar("ui_override_halftime",2);
	}
	else
	{
		setdvar("ui_override_halftime",1);
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

	game["teamScores"][game["attackers"]] = 0;
	setteamscore(game["attackers"],0);
	game["teamScores"][game["defenders"]] = 0;
	setteamscore(game["defenders"],0);
	setclientnamemode("auto_change");
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
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_ctf_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_ctf_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_ctf_spawn_allies");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_ctf_spawn_axis");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	maps\mp\gametypes\_rank::registerscoreinfo("kill",50);
	maps\mp\gametypes\_rank::registerscoreinfo("headshot",50);
	maps\mp\gametypes\_rank::registerscoreinfo("assist",20);
	maps\mp\gametypes\_rank::registerscoreinfo("pickup",50);
	maps\mp\gametypes\_rank::registerscoreinfo("return",50);
	maps\mp\gametypes\_rank::registerscoreinfo("capture",250);
	maps\mp\gametypes\_rank::registerscoreinfo("kill_carrier",50);
	maps\mp\gametypes\_rank::registerscoreinfo("defend",100);
	maps\mp\gametypes\_rank::registerscoreinfo("defend_assist",100);
	maps\mp\gametypes\_rank::registerscoreinfo("assault",200);
	maps\mp\gametypes\_rank::registerscoreinfo("assault_assist",40);
	var_02[0] = "ctf";
	maps\mp\gametypes\_gameobjects::main(var_02);
	thread func_39C8();
}

//Function Number: 7
getspawnpoint()
{
	if(self.team == "axis")
	{
		var_00 = game["attackers"];
	}
	else
	{
		var_00 = game["defenders"];
	}

	if(level.ingraceperiod)
	{
		var_01 = getentarray("mp_ctf_spawn_" + var_00 + "_start","classname");
		var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_01);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_02);
		var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(var_02);
	}

	return var_02;
}

//Function Number: 8
func_39C8()
{
	level.flagmodel["allies"] = maps\mp\gametypes\_teams::getteamflagmodel("allies");
	level.icon2d["allies"] = maps\mp\gametypes\_teams::getteamflagicon("allies");
	level.carryflag["allies"] = maps\mp\gametypes\_teams::getteamflagcarrymodel("allies");
	precachemodel(level.flagmodel["allies"]);
	precachemodel(level.carryflag["allies"]);
	level.flagmodel["axis"] = maps\mp\gametypes\_teams::getteamflagmodel("axis");
	level.icon2d["axis"] = maps\mp\gametypes\_teams::getteamflagicon("axis");
	level.carryflag["axis"] = maps\mp\gametypes\_teams::getteamflagcarrymodel("axis");
	precachemodel(level.flagmodel["axis"]);
	precachemodel(level.carryflag["axis"]);
	level.iconescort3d = "waypoint_escort";
	level.iconescort2d = "waypoint_escort";
	precacheshader(level.iconescort3d);
	precacheshader(level.iconescort2d);
	level.iconkill3d = "waypoint_kill";
	level.iconkill2d = "waypoint_kill";
	precacheshader(level.iconkill3d);
	precacheshader(level.iconkill2d);
	level.iconcaptureflag3d = "waypoint_capture_flag";
	level.iconcaptureflag2d = "waypoint_capture_flag";
	precacheshader(level.iconcaptureflag3d);
	precacheshader(level.iconcaptureflag2d);
	level.icondefendflag3d = "waypoint_defend_flag";
	level.icondefendflag2d = "waypoint_defend_flag";
	precacheshader(level.icondefendflag3d);
	precacheshader(level.icondefendflag2d);
	level.iconreturnflag3d = "waypoint_return_flag";
	level.iconreturnflag2d = "waypoint_return_flag";
	precacheshader(level.iconreturnflag3d);
	precacheshader(level.iconreturnflag2d);
	level.iconwaitforflag3d = "waypoint_waitfor_flag";
	level.iconwaitforflag2d = "waypoint_waitfor_flag";
	precacheshader(level.iconwaitforflag3d);
	precacheshader(level.iconwaitforflag2d);
	precacheshader(level.icon2d["axis"]);
	precacheshader(level.icon2d["allies"]);
	precacheshader("waypoint_flag_friendly");
	precacheshader("waypoint_flag_enemy");
	precachestring(&"OBJECTIVES_FLAG_HOME");
	precachestring(&"OBJECTIVES_FLAG_NAME");
	precachestring(&"OBJECTIVES_FLAG_AWAY");
	level.teamflags[game["defenders"]] = func_39C2(game["defenders"],"allies");
	level.teamflags[game["attackers"]] = func_39C2(game["attackers"],level.otherteam["allies"]);
	level.capzones[game["defenders"]] = func_39C3(game["defenders"],"allies");
	level.capzones[game["attackers"]] = func_39C3(game["attackers"],level.otherteam["allies"]);
	if(level.splitscreen)
	{
		var_00 = 0;
	}
	else
	{
		var_00 = 0.85;
	}

	level.friendlyflagstatusicon["allies"] = maps\mp\gametypes\_hud_util::createservericon("waypoint_flag_friendly",32,32,"allies");
	level.friendlyflagstatusicon["allies"] maps\mp\gametypes\_hud_util::setpoint("TOP LEFT","TOP LEFT",132,0);
	level.friendlyflagstatusicon["allies"].alpha = var_00;
	level.friendlyflagstatusicon["allies"].hidewheninmenu = 1;
	level thread func_3A0B(level.friendlyflagstatusicon["allies"]);
	level.friendlyflagstatustext["allies"] = maps\mp\gametypes\_hud_util::createserverfontstring("small",1.6,"allies");
	level.friendlyflagstatustext["allies"] maps\mp\gametypes\_hud_util::setparent(level.friendlyflagstatusicon["allies"]);
	level.friendlyflagstatustext["allies"] maps\mp\gametypes\_hud_util::setpoint("LEFT","RIGHT",4);
	level.friendlyflagstatustext["allies"] settext(&"OBJECTIVES_FLAG_HOME");
	level.friendlyflagstatustext["allies"].alpha = var_00;
	level.friendlyflagstatustext["allies"].color = (1,1,1);
	level.friendlyflagstatustext["allies"].glowalpha = 1;
	level.friendlyflagstatustext["allies"].hidewheninmenu = 1;
	level thread func_3A0B(level.friendlyflagstatustext["allies"]);
	level.enemyflagstatusicon["allies"] = maps\mp\gametypes\_hud_util::createservericon("waypoint_flag_enemy",24,24,"allies");
	level.enemyflagstatusicon["allies"] maps\mp\gametypes\_hud_util::setpoint("TOP LEFT","TOP LEFT",132,26);
	level.enemyflagstatusicon["allies"].alpha = var_00;
	level.enemyflagstatusicon["allies"].hidewheninmenu = 1;
	level thread func_3A0B(level.enemyflagstatusicon["allies"]);
	level.enemyflagstatustext["allies"] = maps\mp\gametypes\_hud_util::createserverfontstring("small",1.6,"allies");
	level.enemyflagstatustext["allies"] maps\mp\gametypes\_hud_util::setparent(level.enemyflagstatusicon["allies"]);
	level.enemyflagstatustext["allies"] maps\mp\gametypes\_hud_util::setpoint("LEFT","RIGHT",4);
	level.enemyflagstatustext["allies"] settext(&"OBJECTIVES_FLAG_HOME");
	level.enemyflagstatustext["allies"].alpha = var_00;
	level.enemyflagstatustext["allies"].color = (1,1,1);
	level.enemyflagstatustext["allies"].glowalpha = 1;
	level.enemyflagstatustext["allies"].hidewheninmenu = 1;
	level thread func_3A0B(level.enemyflagstatustext["allies"]);
	level.friendlyflagstatusicon["axis"] = maps\mp\gametypes\_hud_util::createservericon("waypoint_flag_friendly",32,32,"axis");
	level.friendlyflagstatusicon["axis"] maps\mp\gametypes\_hud_util::setpoint("TOP LEFT","TOP LEFT",132,0);
	level.friendlyflagstatusicon["axis"].alpha = var_00;
	level.friendlyflagstatusicon["axis"].hidewheninmenu = 1;
	level thread func_3A0B(level.friendlyflagstatusicon["axis"]);
	level.friendlyflagstatustext["axis"] = maps\mp\gametypes\_hud_util::createserverfontstring("small",1.6,"axis");
	level.friendlyflagstatustext["axis"] maps\mp\gametypes\_hud_util::setparent(level.friendlyflagstatusicon["axis"]);
	level.friendlyflagstatustext["axis"] maps\mp\gametypes\_hud_util::setpoint("LEFT","RIGHT",4);
	level.friendlyflagstatustext["axis"] settext(&"OBJECTIVES_FLAG_HOME");
	level.friendlyflagstatustext["axis"].alpha = var_00;
	level.friendlyflagstatustext["axis"].color = (1,1,1);
	level.friendlyflagstatustext["axis"].glowalpha = 1;
	level.friendlyflagstatustext["axis"].hidewheninmenu = 1;
	level thread func_3A0B(level.friendlyflagstatustext["axis"]);
	level.enemyflagstatusicon["axis"] = maps\mp\gametypes\_hud_util::createservericon("waypoint_flag_enemy",24,24,"axis");
	level.enemyflagstatusicon["axis"] maps\mp\gametypes\_hud_util::setpoint("TOP LEFT","TOP LEFT",132,26);
	level.enemyflagstatusicon["axis"].alpha = var_00;
	level.enemyflagstatusicon["axis"].hidewheninmenu = 1;
	level thread func_3A0B(level.enemyflagstatusicon["axis"]);
	level.enemyflagstatustext["axis"] = maps\mp\gametypes\_hud_util::createserverfontstring("small",1.6,"axis");
	level.enemyflagstatustext["axis"] maps\mp\gametypes\_hud_util::setparent(level.enemyflagstatusicon["axis"]);
	level.enemyflagstatustext["axis"] maps\mp\gametypes\_hud_util::setpoint("LEFT","RIGHT",4);
	level.enemyflagstatustext["axis"] settext(&"OBJECTIVES_FLAG_HOME");
	level.enemyflagstatustext["axis"].alpha = var_00;
	level.enemyflagstatustext["axis"].color = (1,1,1);
	level.enemyflagstatustext["axis"].glowalpha = 1;
	level.enemyflagstatustext["axis"].hidewheninmenu = 1;
	level thread func_3A0B(level.enemyflagstatustext["axis"]);
}

//Function Number: 9
func_3A0B(param_00)
{
	level waittill("game_ended");
	if(isdefined(param_00))
	{
		param_00.alpha = 0;
	}
}

//Function Number: 10
spawnfxdelay(param_00,param_01,param_02,param_03,param_04)
{
	wait param_04;
	var_05 = spawnfx(param_00,param_01,param_02,param_03);
	triggerfx(var_05);
}

//Function Number: 11
func_39C2(param_00,param_01)
{
	var_02 = getent("ctf_zone_" + param_01,"targetname");
	if(!isdefined(var_02))
	{
		common_scripts\utility::error("No ctf_zone_" + param_01 + " trigger found in map.");
		return;
	}

	var_03[0] = getent("ctf_flag_" + param_01,"targetname");
	if(!isdefined(var_03[0]))
	{
		common_scripts\utility::error("No ctf_flag_" + param_01 + " script_model found in map.");
		return;
	}

	var_04 = spawn("trigger_radius",var_02.origin,0,96,var_02.height);
	var_02 = var_04;
	var_03[0] setmodel(level.flagmodel[param_00]);
	var_05 = maps\mp\gametypes\_gameobjects::createcarryobject(param_00,var_02,var_03,(0,0,85));
	var_05 maps\mp\gametypes\_gameobjects::setteamusetime("friendly",0.5);
	var_05 maps\mp\gametypes\_gameobjects::setteamusetime("enemy",0.5);
	var_05 maps\mp\gametypes\_gameobjects::setteamusetext("enemy",&"MP_GRABBING_FLAG");
	var_05 maps\mp\gametypes\_gameobjects::setteamusetext("friendly",&"MP_RETURNING_FLAG");
	var_05 maps\mp\gametypes\_gameobjects::allowcarry("enemy");
	var_05 maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	var_05 maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconkill2d);
	var_05 maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.iconkill3d);
	var_05 maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconescort2d);
	var_05 maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconescort3d);
	var_05 maps\mp\gametypes\_gameobjects::setcarryicon(level.icon2d[param_00]);
	var_05.objidpingfriendly = 1;
	var_05.allowweapons = 1;
	var_05.onpickup = ::onpickup;
	var_05.onpickupfailed = ::onpickup;
	var_05.ondrop = ::ondrop;
	var_05.onreset = ::onreset;
	var_05.oldradius = var_02.radius;
	var_06 = var_02.origin + (0,0,32);
	var_07 = var_02.origin + (0,0,-32);
	var_08 = bullettrace(var_06,var_07,0,undefined);
	var_09 = maps\mp\gametypes\_teams::getteamflagfx(param_00);
	var_0A = loadfx(var_09);
	var_0B = vectortoangles(var_08["normal"]);
	var_0C = anglestoforward(var_0B);
	var_0D = anglestoright(var_0B);
	thread spawnfxdelay(var_0A,var_08["position"],var_0C,var_0D,0.5);
	return var_05;
}

//Function Number: 12
func_39C3(param_00,param_01)
{
	var_02 = getent("ctf_zone_" + param_01,"targetname");
	if(!isdefined(var_02))
	{
		common_scripts\utility::error("No ctf_zone_" + param_01 + " trigger found in map.");
		return;
	}

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
	var_08 = maps\mp\gametypes\_teams::getteamflagfx(param_00);
	var_09 = loadfx(var_08);
	var_0A = vectortoangles(var_07["normal"]);
	var_0B = anglestoforward(var_0A);
	var_0C = anglestoright(var_0A);
	thread spawnfxdelay(var_09,var_07["position"],var_0B,var_0C,0.5);
	return var_04;
}

//Function Number: 13
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

//Function Number: 14
onenduse(param_00,param_01,param_02)
{
	self.trigger.radius = self.oldradius;
}

//Function Number: 15
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

	if(var_01 == maps\mp\gametypes\_gameobjects::getownerteam())
	{
		param_00 thread maps\mp\gametypes\_hud_message::splashnotify("flagreturn",maps\mp\gametypes\_rank::getscoreinfovalue("return"));
		param_00 thread [[ level.onxpevent ]]("return");
		thread func_39C4();
		param_00 maps\mp\_utility::incplayerstat("flagsreturned",1);
		param_00 thread maps\mp\_matchdata::loggameevent("return",param_00.origin);
		maps\mp\_utility::printandsoundoneveryone(var_01,maps\mp\_utility::getotherteam(var_01),&"MP_FLAG_RETURNED",&"MP_ENEMY_FLAG_RETURNED","mp_obj_returned","mp_obj_returned","");
		maps\mp\_utility::leaderdialog("enemy_flag_returned",var_02,"status");
		maps\mp\_utility::leaderdialog("flag_returned",var_01,"status");
		param_00 maps\mp\_utility::incpersstat("returns",1);
		param_00 maps\mp\gametypes\_persistance::statsetchild("round","returns",param_00.pers["returns"]);
		level.friendlyflagstatustext[var_01] settext(&"OBJECTIVES_FLAG_HOME");
		level.friendlyflagstatustext[var_01].glowcolor = (1,1,1);
		level.friendlyflagstatustext[var_01].glowalpha = 0;
		level.enemyflagstatustext[var_02] settext(&"OBJECTIVES_FLAG_HOME");
		level.enemyflagstatustext[var_02].glowcolor = (1,1,1);
		level.enemyflagstatustext[var_02].glowalpha = 0;
		return;
	}

	if(isdefined(level.ctf_loadouts) && isdefined(level.ctf_loadouts[var_01]))
	{
		param_00 thread func_39DA();
	}
	else
	{
		param_00 func_39C5();
	}

	level.friendlyflagstatustext[var_02] setplayernamestring(param_00);
	level.friendlyflagstatustext[var_02].glowcolor = (0.75,0.25,0.25);
	level.friendlyflagstatustext[var_02].glowalpha = 1;
	level.enemyflagstatustext[var_01] setplayernamestring(param_00);
	level.enemyflagstatustext[var_01].glowcolor = (0.25,0.75,0.25);
	level.enemyflagstatustext[var_01].glowalpha = 1;
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconkill2d);
	maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.iconkill3d);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconescort2d);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconescort3d);
	level.capzones[var_02] maps\mp\gametypes\_gameobjects::allowuse("none");
	level.capzones[var_02] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	if(!level.teamflags[var_01] maps\mp\gametypes\_gameobjects::ishome())
	{
		level.capzones[var_01].trigger maps\mp\_entityheadicons::setheadicon(param_00,level.iconwaitforflag2d,(0,0,85),undefined,undefined,undefined,undefined,undefined,undefined,undefined,0);
		if(isdefined(level.teamflags[var_01].carrier))
		{
			level.capzones[var_02].trigger maps\mp\_entityheadicons::setheadicon(level.teamflags[var_01].carrier,level.iconwaitforflag2d,(0,0,85),undefined,undefined,undefined,undefined,undefined,undefined,undefined,0);
		}
	}

	maps\mp\_utility::printandsoundoneveryone(var_01,var_02,&"MP_ENEMY_FLAG_TAKEN_BY",&"MP_FLAG_TAKEN_BY","mp_obj_taken","mp_enemy_obj_taken",param_00);
	maps\mp\_utility::leaderdialog("enemy_flag_taken",var_01,"status");
	maps\mp\_utility::leaderdialog("flag_taken",var_02,"status");
	thread maps\mp\_utility::teamplayercardsplash("callout_flagpickup",param_00);
	param_00 thread maps\mp\gametypes\_hud_message::splashnotify("flagpickup",maps\mp\gametypes\_rank::getscoreinfovalue("pickup"));
	lib_036E::func_2B7B("pickup",param_00);
	param_00 thread [[ level.onxpevent ]]("pickup");
	param_00 maps\mp\_utility::incplayerstat("flagscarried",1);
	param_00 thread maps\mp\_matchdata::loggameevent("pickup",param_00.origin);
}

//Function Number: 16
func_39C4()
{
	maps\mp\gametypes\_gameobjects::returnhome();
}

//Function Number: 17
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
	level.friendlyflagstatustext[var_01] settext(&"OBJECTIVES_FLAG_AWAY");
	level.friendlyflagstatustext[var_01].glowcolor = (1,1,1);
	level.friendlyflagstatustext[var_01].glowalpha = 0;
	level.enemyflagstatustext[var_02] settext(&"OBJECTIVES_FLAG_AWAY");
	level.enemyflagstatustext[var_02].glowcolor = (1,1,1);
	level.enemyflagstatustext[var_02].glowalpha = 0;
	level.capzones[var_02].trigger maps\mp\_entityheadicons::setheadicon("none","",(0,0,0));
	if(isdefined(param_00))
	{
		if(isdefined(param_00.carryflag))
		{
			param_00 func_39C6();
		}

		maps\mp\_utility::printandsoundoneveryone(var_02,"none",&"MP_ENEMY_FLAG_DROPPED_BY","","mp_war_objective_lost","",param_00);
	}
	else
	{
		maps\mp\_utility::playsoundonplayers("mp_war_objective_lost",var_02);
	}

	maps\mp\_utility::leaderdialog("enemy_flag_dropped",var_02,"status");
	maps\mp\_utility::leaderdialog("flag_dropped",var_01,"status");
	thread func_39D9();
}

//Function Number: 18
func_39D9()
{
	self endon("picked_up");
	wait level.flagreturntime;
	var_00 = maps\mp\gametypes\_gameobjects::getownerteam();
	var_01 = level.otherteam[var_00];
	maps\mp\_utility::playsoundonplayers("mp_war_objective_taken",var_00);
	maps\mp\_utility::playsoundonplayers("mp_war_objective_lost",var_01);
	maps\mp\gametypes\_gameobjects::returnhome();
}

//Function Number: 19
onreset()
{
	var_00 = maps\mp\gametypes\_gameobjects::getownerteam();
	var_01 = level.otherteam[var_00];
	maps\mp\gametypes\_gameobjects::allowcarry("enemy");
	maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconkill2d);
	maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.iconkill3d);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconescort2d);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconescort3d);
	level.friendlyflagstatustext[var_00] settext(&"OBJECTIVES_FLAG_HOME");
	level.friendlyflagstatustext[var_00].glowcolor = (1,1,1);
	level.friendlyflagstatustext[var_00].glowalpha = 0;
	level.enemyflagstatustext[var_01] settext(&"OBJECTIVES_FLAG_HOME");
	level.enemyflagstatustext[var_01].glowcolor = (1,1,1);
	level.enemyflagstatustext[var_01].glowalpha = 0;
	level.capzones[var_00] maps\mp\gametypes\_gameobjects::allowuse("friendly");
	level.capzones[var_00] maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	level.capzones[var_00] maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.icondefendflag2d);
	level.capzones[var_00] maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.icondefendflag3d);
	level.capzones[var_00] maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconcaptureflag2d);
	level.capzones[var_00] maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconcaptureflag3d);
	level.capzones[var_00].trigger maps\mp\_entityheadicons::setheadicon("none","",(0,0,0));
}

//Function Number: 20
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
	maps\mp\_utility::leaderdialog("flag_captured",var_02,"status");
	thread maps\mp\_utility::teamplayercardsplash("callout_flagcapture",param_00);
	lib_036E::func_2B88(var_01,1);
	param_00 thread maps\mp\gametypes\_hud_message::splashnotify("flag_capture",maps\mp\gametypes\_rank::getscoreinfovalue("capture"));
	lib_036E::func_2B7B("capture",param_00);
	param_00 thread [[ level.onxpevent ]]("capture");
	param_00 maps\mp\_utility::incplayerstat("flagscaptured",1);
	param_00 notify("objective","captured");
	param_00 thread maps\mp\_matchdata::loggameevent("capture",param_00.origin);
	param_00 maps\mp\_utility::incpersstat("captures",1);
	param_00 maps\mp\gametypes\_persistance::statsetchild("round","captures",param_00.pers["captures"]);
	maps\mp\_utility::printandsoundoneveryone(var_01,var_02,&"MP_ENEMY_FLAG_CAPTURED_BY",&"MP_FLAG_CAPTURED_BY","mp_obj_captured","mp_enemy_obj_captured",param_00);
	if(isdefined(param_00.carryflag))
	{
		param_00 func_39C6();
	}

	if(isdefined(level.ctf_loadouts) && isdefined(level.ctf_loadouts[var_01]))
	{
		param_00 thread func_39DB();
	}

	level.teamflags[var_02] func_39C4();
	level thread func_441A(var_01);
}

//Function Number: 21
func_441A(param_00)
{
	if(maps\mp\_utility::inovertime())
	{
		game["roundsWon"][param_00]++;
		level.finalkillcam_winner = param_00;
		game["teamScores"]["axis"] = game["roundsWon"]["axis"];
		game["teamScores"]["allies"] = game["roundsWon"]["allies"];
		setteamscore("axis",game["teamScores"]["axis"]);
		setteamscore("allies",game["teamScores"]["allies"]);
		thread maps\mp\gametypes\_gamelogic::endgame(param_00,game["strings"]["score_limit_reached"]);
		return;
	}

	if(game["switchedsides"])
	{
		if(game["teamScores"][param_00] == maps\mp\_utility::getwatcheddvar("scorelimit"))
		{
			game["roundsWon"][param_00]++;
			game["teamScores"]["axis"] = game["roundsWon"]["axis"];
			game["teamScores"]["allies"] = game["roundsWon"]["allies"];
			setteamscore("axis",game["teamScores"]["axis"]);
			setteamscore("allies",game["teamScores"]["allies"]);
			if(game["roundsWon"][param_00] > game["roundsWon"][level.otherteam[param_00]])
			{
				level.finalkillcam_winner = param_00;
				thread maps\mp\gametypes\_gamelogic::endgame(param_00,game["strings"]["score_limit_reached"]);
				return;
			}

			level.finalkillcam_winner = "none";
			thread maps\mp\gametypes\_gamelogic::endgame("overtime",game["strings"]["score_limit_reached"]);
			return;
		}

		return;
	}

	if(game["teamScores"][param_00] == maps\mp\_utility::getwatcheddvar("scorelimit"))
	{
		game["roundsWon"][param_00]++;
		level.finalkillcam_winner = param_00;
		game["teamScores"]["axis"] = game["roundsWon"]["axis"];
		game["teamScores"]["allies"] = game["roundsWon"]["allies"];
		setteamscore("axis",game["teamScores"]["axis"]);
		setteamscore("allies",game["teamScores"]["allies"]);
		thread maps\mp\gametypes\_gamelogic::endgame("halftime",game["strings"]["score_limit_reached"]);
		return;
	}
}

//Function Number: 22
ontimelimit()
{
	if(maps\mp\_utility::inovertime())
	{
		game["teamScores"]["axis"] = game["roundsWon"]["axis"];
		game["teamScores"]["allies"] = game["roundsWon"]["allies"];
		setteamscore("axis",game["teamScores"]["axis"]);
		setteamscore("allies",game["teamScores"]["allies"]);
		level.finalkillcam_winner = "none";
		thread maps\mp\gametypes\_gamelogic::endgame("tie",game["strings"]["time_limit_reached"]);
		return;
	}

	if(game["switchedsides"])
	{
		if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
		{
			game["roundsWon"]["axis"]++;
		}
		else if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
		{
			game["roundsWon"]["allies"]++;
		}

		game["teamScores"]["axis"] = game["roundsWon"]["axis"];
		game["teamScores"]["allies"] = game["roundsWon"]["allies"];
		setteamscore("axis",game["teamScores"]["axis"]);
		setteamscore("allies",game["teamScores"]["allies"]);
		if(game["roundsWon"]["axis"] > game["roundsWon"]["allies"])
		{
			level.finalkillcam_winner = "axis";
			thread maps\mp\gametypes\_gamelogic::endgame("axis",game["strings"]["time_limit_reached"]);
			return;
		}

		if(game["roundsWon"]["allies"] > game["roundsWon"]["axis"])
		{
			level.finalkillcam_winner = "allies";
			thread maps\mp\gametypes\_gamelogic::endgame("allies",game["strings"]["time_limit_reached"]);
			return;
		}

		level.finalkillcam_winner = "none";
		thread maps\mp\gametypes\_gamelogic::endgame("overtime",game["strings"]["time_limit_reached"]);
		return;
	}

	if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
	{
		game["roundsWon"]["axis"]++;
		level.finalkillcam_winner = "axis";
	}
	else if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
	{
		game["roundsWon"]["allies"]++;
		level.finalkillcam_winner = "allies";
	}
	else
	{
		level.finalkillcam_winner = "none";
	}

	game["teamScores"]["axis"] = game["roundsWon"]["axis"];
	game["teamScores"]["allies"] = game["roundsWon"]["allies"];
	setteamscore("axis",game["teamScores"]["axis"]);
	setteamscore("allies",game["teamScores"]["allies"]);
	thread maps\mp\gametypes\_gamelogic::endgame("halftime",game["strings"]["time_limit_reached"]);
}

//Function Number: 23
func_39DA()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait 0.05;
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		self notify("lost_juggernaut");
		wait 0.05;
	}

	self.pers["gamemodeLoadout"] = level.ctf_loadouts[self.team];
	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00.playerspawnpos = self.origin;
	var_00.notti = 1;
	self.setspawnpoint = var_00;
	self.gamemode_chosenclass = self.class;
	self.pers["class"] = "gamemode";
	self.pers["lastClass"] = "gamemode";
	self.class = "gamemode";
	self.lastclass = "gamemode";
	self notify("faux_spawn");
	self.gameobject_fauxspawn = 1;
	self.faux_spawn_stance = self getstance();
	thread maps\mp\gametypes\_playerlogic::spawnplayer(1);
	thread waitattachflag();
}

//Function Number: 24
waitattachflag()
{
	level endon("game_ende");
	self endon("disconnect");
	self endon("death");
	self waittill("spawned_player");
	func_39C5();
}

//Function Number: 25
func_39DB()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait 0.05;
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		self notify("lost_juggernaut");
		wait 0.05;
	}

	self.pers["gamemodeLoadout"] = undefined;
	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00.playerspawnpos = self.origin;
	var_00.notti = 1;
	self.setspawnpoint = var_00;
	self notify("faux_spawn");
	self.faux_spawn_stance = self getstance();
	thread maps\mp\gametypes\_playerlogic::spawnplayer(1);
}

//Function Number: 26
oncantuse(param_00)
{
}

//Function Number: 27
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_01) && isplayer(param_01) && param_01.pers["team"] != self.pers["team"])
	{
		if(isdefined(param_01.carryflag))
		{
			param_01 maps\mp\_utility::incplayerstat("killsasflagcarrier",1);
		}

		if(isdefined(self.carryflag))
		{
			param_01 thread [[ level.onxpevent ]]("kill_carrier");
			lib_036E::func_2B7B("kill_carrier",param_01);
			param_01 maps\mp\_utility::incplayerstat("flagcarrierkills",1);
			param_01 maps\mp\_utility::incpersstat("defends",1);
			param_01 maps\mp\gametypes\_persistance::statsetchild("round","defends",param_01.pers["defends"]);
			thread maps\mp\_matchdata::logkillevent(param_09,"carrying");
			func_39C6();
			return;
		}

		return;
	}

	if(isdefined(self.carryflag))
	{
		func_39C6();
	}
}

//Function Number: 28
func_39C5()
{
	var_00 = level.otherteam[self.pers["team"]];
	self attach(level.carryflag[var_00],"J_spine4",1);
	self.carryflag = level.carryflag[var_00];
}

//Function Number: 29
func_39C6()
{
	self detach(self.carryflag,"J_spine4");
	self.carryflag = undefined;
}

//Function Number: 30
initgametypeawards()
{
	maps\mp\_awards::initstataward("flagscaptured",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("flagsreturned",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("flagcarrierkills",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("flagscarried",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("killsasflagcarrier",0,::maps\mp\_awards::highestwins);
}

//Function Number: 31
func_3989()
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