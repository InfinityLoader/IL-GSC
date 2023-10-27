/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\ctfpro.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 333 ms
 * Timestamp: 10/27/2023 2:13:10 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::setupcallbacks();
	maps\mp\gametypes\_globallogic::setupcallbacks();
	maps\mp\_utility::registerscorelimitdvar(level.gametype,1000);
	maps\mp\_utility::registertimelimitdvar(level.gametype,6,0,0);
	maps\mp\_utility::registerroundlimitdvar(level.gametype,2,0,0);
	maps\mp\_utility::setoverridewatchdvar("winlimit",2);
	maps\mp\_utility::registerroundswitchdvar(level.gametype,1,0,0);
	maps\mp\_utility::registernumlivesdvar(level.gametype,0,0,0);
	maps\mp\_utility::registerhalftimedvar(level.gametype,1,0,0);
	level.teambased = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.initgametypeawards = ::initgametypeawards;
	level.onhalftime = ::ontimelimit;
	level.ontimelimit = ::ontimelimit;
	level.onspawnplayer = ::onspawnplayer;
	level.scorelimitoverride = 1;
	level.overtimescorewinoverride = 1;
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

//Function Number: 3
onspawnplayer()
{
	if(maps\mp\_utility::inovertime() && !isdefined(self.otspawned))
	{
		thread func_3979();
	}
}

//Function Number: 4
func_3979()
{
	self endon("disconnect");
	wait 0.25;
	self.otspawned = 1;
	var_00 = maps\mp\_utility::getobjectivehinttext(self.team);
	thread maps\mp\gametypes\_hud_message::hintmessage(var_00);
}

//Function Number: 5
onstartgametype()
{
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
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
		if(game["roundsWon"][game["defenders"]] > 0)
		{
			game["teamScores"][game["defenders"]] = 500;
			setteamscore(game["defenders"],500);
		}
		else
		{
			game["teamScores"][game["defenders"]] = 0;
			setteamscore(game["defenders"],0);
		}
	}

	setclientnamemode("auto_change");
	if(level.splitscreen)
	{
		if(maps\mp\_utility::inovertime())
		{
			maps\mp\_utility::setobjectivescoretext(game["attackers"],&"OBJECTIVES_GRAB_FLAG");
			maps\mp\_utility::setobjectivescoretext(game["defenders"],&"OBJECTIVES_GRAB_FLAG");
		}
		else
		{
			maps\mp\_utility::setobjectivescoretext(game["attackers"],&"OBJECTIVES_ONE_FLAG_ATTACKER");
			maps\mp\_utility::setobjectivescoretext(game["defenders"],&"OBJECTIVES_ONE_FLAG_DEFENDER");
		}
	}
	else if(maps\mp\_utility::inovertime())
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"],&"OBJECTIVES_GRAB_FLAG_SCORE");
		maps\mp\_utility::setobjectivescoretext(game["defenders"],&"OBJECTIVES_GRAB_FLAG_SCORE");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"],&"OBJECTIVES_ONE_FLAG_ATTACKER_SCORE");
		maps\mp\_utility::setobjectivescoretext(game["defenders"],&"OBJECTIVES_ONE_FLAG_DEFENDER_SCORE");
	}

	if(maps\mp\_utility::inovertime())
	{
		maps\mp\_utility::setobjectivetext(game["attackers"],&"OBJECTIVES_OVERTIME_CTF");
		maps\mp\_utility::setobjectivetext(game["defenders"],&"OBJECTIVES_OVERTIME_CTF");
		maps\mp\_utility::setobjectivehinttext(game["attackers"],&"OBJECTIVES_GRAB_FLAG_HINT");
		maps\mp\_utility::setobjectivehinttext(game["defenders"],&"OBJECTIVES_GRAB_FLAG_HINT");
	}
	else
	{
		maps\mp\_utility::setobjectivetext(game["attackers"],&"OBJECTIVES_CTF");
		maps\mp\_utility::setobjectivetext(game["defenders"],&"OBJECTIVES_CTF");
		maps\mp\_utility::setobjectivehinttext(game["attackers"],&"OBJECTIVES_ONE_FLAG_ATTACKER_HINT");
		maps\mp\_utility::setobjectivehinttext(game["defenders"],&"OBJECTIVES_ONE_FLAG_DEFENDER_HINT");
	}

	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_ctf_pro_spawn_attackers_start");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_ctf_pro_spawn_defenders_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints(game["attackers"],"mp_ctf_pro_spawn_attackers");
	maps\mp\gametypes\_spawnlogic::addspawnpoints(game["defenders"],"mp_ctf_pro_spawn_defenders");
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
	maps\mp\gametypes\_rank::registerscoreinfo("assault",100);
	maps\mp\gametypes\_rank::registerscoreinfo("assault_assist",100);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("capture",1);
	var_02[0] = "ctf_pro";
	maps\mp\gametypes\_gameobjects::main(var_02);
	thread func_39DC();
}

//Function Number: 6
getspawnpoint()
{
	if(level.ingraceperiod)
	{
		if(self.team == game["attackers"])
		{
			var_00 = "attackers";
		}
		else
		{
			var_00 = "defenders";
		}

		var_01 = getentarray("mp_ctf_pro_spawn_" + var_00 + "_start","classname");
		var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_01);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.team);
		var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(var_02);
	}

	return var_02;
}

//Function Number: 7
func_39DC()
{
	level.flagmodel[game["defenders"]] = maps\mp\gametypes\_teams::getteamflagmodel(game["defenders"]);
	level.icon2d[game["defenders"]] = maps\mp\gametypes\_teams::getteamflagicon(game["defenders"]);
	level.carryflag[game["defenders"]] = maps\mp\gametypes\_teams::getteamflagcarrymodel(game["defenders"]);
	precachemodel(level.flagmodel[game["defenders"]]);
	precachemodel(level.carryflag[game["defenders"]]);
	level.iconescort2d["a"] = "waypoint_escort_a";
	level.iconescort2d["b"] = "waypoint_escort_b";
	level.iconescort3d["a"] = level.iconescort2d["a"];
	level.iconescort3d["b"] = level.iconescort2d["b"];
	precacheshader(level.iconescort2d["a"]);
	precacheshader(level.iconescort2d["b"]);
	level.iconkill2d["a"] = "waypoint_kill_a";
	level.iconkill2d["b"] = "waypoint_kill_b";
	level.iconkill3d["a"] = level.iconkill2d["a"];
	level.iconkill3d["b"] = level.iconkill2d["b"];
	precacheshader(level.iconkill2d["a"]);
	precacheshader(level.iconkill2d["b"]);
	level.iconcaptureflag2d["a"] = "waypoint_capture_flag_a";
	level.iconcaptureflag2d["b"] = "waypoint_capture_flag_b";
	level.iconcaptureflag3d["a"] = level.iconcaptureflag2d["a"];
	level.iconcaptureflag3d["b"] = level.iconcaptureflag2d["b"];
	precacheshader(level.iconcaptureflag2d["a"]);
	precacheshader(level.iconcaptureflag2d["b"]);
	level.icondefendflag2d["a"] = "waypoint_defend_flag_a";
	level.icondefendflag2d["b"] = "waypoint_defend_flag_b";
	level.icondefendflag3d["a"] = level.icondefendflag2d["a"];
	level.icondefendflag3d["b"] = level.icondefendflag2d["b"];
	precacheshader(level.icondefendflag2d["a"]);
	precacheshader(level.icondefendflag2d["b"]);
	level.iconreturnflag2d["a"] = "waypoint_return_flag_a";
	level.iconreturnflag2d["b"] = "waypoint_return_flag_b";
	level.iconreturnflag3d["a"] = level.iconreturnflag2d["a"];
	level.iconreturnflag3d["b"] = level.iconreturnflag2d["b"];
	precacheshader(level.iconreturnflag2d["a"]);
	precacheshader(level.iconreturnflag2d["b"]);
	level.iconflagbase2d = "waypoint_flag_base";
	level.iconflagbase3d = level.iconflagbase2d;
	precacheshader(level.iconflagbase2d);
	precacheshader(level.icon2d[game["defenders"]]);
	precacheshader("waypoint_flag_friendly");
	precacheshader("waypoint_flag_enemy");
	precachestring(&"OBJECTIVES_FLAG_HOME");
	precachestring(&"OBJECTIVES_FLAG_NAME");
	precachestring(&"OBJECTIVES_FLAG_AWAY");
	level.teamflags[game["defenders"]] = func_39DF(game["defenders"]);
	level.capzones[game["attackers"]] = func_39E1(game["attackers"]);
}

//Function Number: 8
ontimelimit()
{
	if(game["switchedsides"] == 1)
	{
		if(game["roundsWon"][game["defenders"]] > 0)
		{
			game["teamScores"][game["defenders"]] = 1;
			setteamscore(game["defenders"],1);
			game["teamScores"][game["attackers"]] = 0;
			setteamscore(game["attackers"],0);
			maps\mp\_utility::setoverridewatchdvar("winlimit",1);
			level.onlyroundoverride = 1;
			thread maps\mp\gametypes\_gamelogic::endgame(game["defenders"],game["strings"]["time_limit_reached"]);
			return;
		}

		game["teamScores"][game["defenders"]] = 0;
		setteamscore(game["defenders"],0);
		game["teamScores"][game["attackers"]] = 0;
		setteamscore(game["attackers"],0);
		thread maps\mp\gametypes\_gamelogic::endgame("tie",game["strings"]["time_limit_reached"]);
		return;
	}

	game["roundsPlayed"]++;
	game["teamScores"][game["attackers"]] = 0;
	setteamscore(game["attackers"],0);
	thread maps\mp\gametypes\_gamelogic::endgame("halftime",game["strings"]["time_limit_reached"]);
}

//Function Number: 9
spawnfxdelay(param_00,param_01,param_02,param_03,param_04)
{
	wait param_04;
	var_05 = spawnfx(param_00,param_01,param_02,param_03);
	triggerfx(var_05);
}

//Function Number: 10
func_39DF(param_00)
{
	var_01 = [];
	var_7B[0].points = 200;
	var_7B[1].points = 200;
	return var_7B;
}

//Function Number: 11
func_39C2(param_00,param_01)
{
	var_02 = getent("ctf_pro_trig_" + param_01,"targetname");
	if(!isdefined(var_02))
	{
		common_scripts\utility::error("No ctf_pro_trig_" + param_01 + " trigger found in map.");
		return;
	}

	var_03 = getent("ctf_pro_flag_" + param_01,"targetname");
	if(!isdefined(var_03))
	{
		common_scripts\utility::error("No ctf_pro_flag_" + param_01 + " script_model found in map.");
		return;
	}

	var_04 = getent("ctf_pro_flag_spawn_" + param_01,"targetname");
	if(!isdefined(var_04))
	{
		common_scripts\utility::error("No ctf_pro_flag_spawn_" + param_01 + " script_origin found in map.");
		return;
	}

	var_03 setmodel(level.flagmodel[param_00]);
	var_05[0] = var_03;
	var_06 = maps\mp\gametypes\_gameobjects::createcarryobject(param_00,var_02,var_05,(0,0,85));
	var_06 maps\mp\gametypes\_gameobjects::setteamusetime("friendly",0.5);
	var_06 maps\mp\gametypes\_gameobjects::setteamusetime("enemy",0.5);
	var_06 maps\mp\gametypes\_gameobjects::setteamusetext("enemy",&"MP_GRABBING_FLAG");
	var_06 maps\mp\gametypes\_gameobjects::setteamusetext("friendly",&"MP_RETURNING_FLAG");
	var_06 maps\mp\gametypes\_gameobjects::allowcarry("enemy");
	var_06 maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	var_06 maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconkill2d[param_01]);
	var_06 maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.iconkill3d[param_01]);
	var_06 maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconescort2d[param_01]);
	var_06 maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconescort3d[param_01]);
	var_06 maps\mp\gametypes\_gameobjects::setcarryicon(level.icon2d[param_00]);
	var_06.objidpingfriendly = 1;
	var_06.allowweapons = 1;
	var_06.onpickup = ::onpickup;
	var_06.onpickupfailed = ::onpickup;
	var_06.ondrop = ::ondrop;
	var_06.onreset = ::onreset;
	var_06.oldradius = var_02.radius;
	var_06.athome = 1;
	var_06.label = param_01;
	var_05 = [];
	var_07 = maps\mp\gametypes\_gameobjects::createuseobject(param_00,var_04,var_05,(0,0,85));
	var_07 maps\mp\gametypes\_gameobjects::allowuse("none");
	var_07 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	var_07 maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.icondefendflag2d[param_01]);
	var_07 maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.icondefendflag3d[param_01]);
	var_07 maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconcaptureflag2d[param_01]);
	var_07 maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconcaptureflag3d[param_01]);
	var_06.marker = var_07;
	var_08 = var_02.origin + (0,0,32);
	var_09 = var_02.origin + (0,0,-32);
	var_0A = bullettrace(var_08,var_09,0,undefined);
	var_0B = maps\mp\gametypes\_teams::getteamflagfx(param_00);
	var_0C = loadfx(var_0B);
	var_0D = vectortoangles(var_0A["normal"]);
	var_0E = anglestoforward(var_0D);
	var_0F = anglestoright(var_0D);
	thread spawnfxdelay(var_0C,var_0A["position"],var_0E,var_0F,0.5);
	return var_06;
}

//Function Number: 12
func_39E1(param_00)
{
	var_01 = [];
	var_01 = getentarray("ctf_pro_zone","targetname");
	if(!isdefined(var_01[0]))
	{
		common_scripts\utility::error("No ctf_pro_zone triggers found in map.");
		return;
	}

	var_02 = [];
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(isdefined(level.teamflags[maps\mp\_utility::getotherteam(param_00)][var_03]))
		{
			var_04 = [];
			var_02[var_03] = maps\mp\gametypes\_gameobjects::createuseobject(param_00,var_01[var_03],var_04,(0,0,0));
			var_02[var_03] maps\mp\gametypes\_gameobjects::allowuse("friendly");
			var_02[var_03] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
			var_02[var_03] maps\mp\gametypes\_gameobjects::setusetime(0);
			var_02[var_03] maps\mp\gametypes\_gameobjects::setkeyobject(level.teamflags[maps\mp\_utility::getotherteam(param_00)][var_03]);
			var_02[var_03].onuse = ::onuse;
			var_02[var_03].oncantuse = ::oncantuse;
		}
	}

	var_02[0].origin = var_01[0].origin;
	var_05 = var_01[0].origin + (0,0,32);
	var_06 = var_01[0].origin + (0,0,-32);
	var_07 = bullettrace(var_05,var_06,0,undefined);
	var_08 = maps\mp\gametypes\_teams::getteamflagfx(param_00);
	var_09 = loadfx(var_08);
	var_0A = vectortoangles(var_07["normal"]);
	var_0B = anglestoforward(var_0A);
	var_0C = anglestoright(var_0A);
	thread spawnfxdelay(var_09,var_07["position"],var_0B,var_0C,0.5);
	return var_02;
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
		thread maps\mp\_utility::teamplayercardsplash("callout_flagreturn",param_00);
		param_00 thread maps\mp\gametypes\_hud_message::splashnotify("flagreturn",maps\mp\gametypes\_rank::getscoreinfovalue("return"));
		lib_036E::func_2B7B("return",param_00);
		param_00 thread [[ level.onxpevent ]]("return");
		thread func_39C4();
		param_00 maps\mp\_utility::incplayerstat("flagsreturned",1);
		param_00 maps\mp\_utility::incpersstat("returns",1);
		param_00 thread maps\mp\_matchdata::loggameevent("return",param_00.origin);
		maps\mp\_utility::printandsoundoneveryone(var_01,maps\mp\_utility::getotherteam(var_01),&"MP_FLAG_RETURNED",&"MP_ENEMY_FLAG_RETURNED","mp_obj_returned","mp_obj_returned","");
		maps\mp\_utility::leaderdialog("enemy_flag_returned",var_02,"status");
		maps\mp\_utility::leaderdialog("flag_returned",var_01,"status");
		return;
	}

	param_00 func_39C5(self);
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconkill2d[self.label]);
	maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.iconkill3d[self.label]);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconescort2d[self.label]);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconescort3d[self.label]);
	self.marker maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	param_00.zoneheadicon = level.capzones[game["attackers"]][0] maps\mp\_entityheadicons::setheadicon(param_00,level.iconflagbase2d,(0,0,0),24,24,undefined,undefined,undefined,undefined,undefined,0);
	param_00.zonemapicon = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(param_00.zonemapicon,"invisible",(0,0,0));
	objective_position(param_00.zonemapicon,level.capzones[game["attackers"]][0].origin);
	objective_state(param_00.zonemapicon,"active");
	objective_player(param_00.zonemapicon,param_00 getentitynumber());
	objective_icon(param_00.zonemapicon,level.iconflagbase2d);
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
	maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconreturnflag2d[self.label]);
	maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.iconreturnflag3d[self.label]);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconcaptureflag2d[self.label]);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconcaptureflag3d[self.label]);
	if(isdefined(param_00))
	{
		if(isdefined(param_00.carryflag))
		{
			param_00 func_39C6();
		}

		maps\mp\_utility::printandsoundoneveryone(var_02,"none",&"MP_ENEMY_FLAG_DROPPED_BY","","mp_war_objective_lost","",param_00);
		if(isdefined(param_00.zoneheadicon))
		{
			param_00.zoneheadicon destroy();
		}

		if(isdefined(param_00.zonemapicon))
		{
			maps\mp\_utility::_objective_delete(param_00.zonemapicon);
			param_00.zonemapicon = undefined;
		}
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
	maps\mp\gametypes\_gameobjects::returnhome();
}

//Function Number: 19
onreset()
{
	var_00 = maps\mp\gametypes\_gameobjects::getownerteam();
	var_01 = level.otherteam[var_00];
	maps\mp\gametypes\_gameobjects::allowcarry("enemy");
	maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconkill2d[self.label]);
	maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.iconkill3d[self.label]);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconescort2d[self.label]);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconescort3d[self.label]);
	self.marker maps\mp\gametypes\_gameobjects::setvisibleteam("any");
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
	func_39E5(var_01,param_00.cappedflag.points);
	param_00 thread maps\mp\gametypes\_hud_message::splashnotify("flag_capture",maps\mp\gametypes\_rank::getscoreinfovalue("capture"));
	lib_036E::func_2B7B("capture",param_00);
	param_00 thread [[ level.onxpevent ]]("capture");
	param_00 maps\mp\_utility::incplayerstat("flagscaptured",1);
	param_00 maps\mp\_utility::incpersstat("captures",1);
	param_00 notify("objective","captured");
	param_00 thread maps\mp\_matchdata::loggameevent("capture",param_00.origin);
	if(isdefined(level.adrenalineinfo["capture"]))
	{
		param_00 maps\mp\killstreaks\_killstreaks::giveadrenaline("capture");
	}

	maps\mp\_utility::printandsoundoneveryone(var_01,var_02,&"MP_ENEMY_FLAG_CAPTURED_BY",&"MP_FLAG_CAPTURED_BY","mp_obj_captured","mp_enemy_obj_captured",param_00);
	if(isdefined(param_00.carryflag))
	{
		param_00 func_39C6();
	}

	if(isdefined(param_00.zoneheadicon))
	{
		param_00.zoneheadicon destroy();
	}

	if(isdefined(param_00.zonemapicon))
	{
		maps\mp\_utility::_objective_delete(param_00.zonemapicon);
		param_00.zonemapicon = undefined;
	}

	param_00.cappedflag func_39C4();
}

//Function Number: 21
func_39E5(param_00,param_01)
{
	lib_036E::func_2B88(param_00,param_01);
	if(game["state"] != "playing")
	{
		return;
	}

	if(game["switchedsides"])
	{
		if(game["teamScores"][game["attackers"]] >= maps\mp\_utility::getwatcheddvar("scorelimit"))
		{
			maps\mp\_utility::setoverridewatchdvar("winlimit",1);
			level.onlyroundoverride = 1;
			if(game["roundsWon"][game["defenders"]] == 0)
			{
				game["teamScores"][game["attackers"]] = 1;
				setteamscore(game["attackers"],1);
				game["teamScores"][game["defenders"]] = 0;
				setteamscore(game["defenders"],0);
				thread maps\mp\gametypes\_gamelogic::endgame(game["attackers"],game["strings"]["score_limit_reached"]);
				return;
			}

			game["teamScores"][game["attackers"]] = 1;
			setteamscore(game["attackers"],1);
			game["teamScores"][game["defenders"]] = 1;
			setteamscore(game["defenders"],1);
			thread maps\mp\gametypes\_gamelogic::endgame("tie",game["strings"]["score_limit_reached"]);
			return;
		}

		return;
	}

	if(game["teamScores"][game["attackers"]] >= maps\mp\_utility::getwatcheddvar("scorelimit"))
	{
		game["roundsPlayed"]++;
		game["teamScores"][game["attackers"]] = 1;
		setteamscore(game["attackers"],1);
		game["teamScores"][game["defenders"]] = 0;
		setteamscore(game["defenders"],0);
		game["roundsWon"][game["attackers"]]++;
		lib_036E::func_2B93(game["attackers"]);
		thread maps\mp\gametypes\_gamelogic::endgame("halftime",game["strings"]["score_limit_reached"]);
	}
}

//Function Number: 22
oncantuse(param_00)
{
}

//Function Number: 23
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
			thread maps\mp\_utility::teamplayercardsplash("callout_killflagcarrier",param_01);
			param_01 thread maps\mp\gametypes\_hud_message::splashnotify("killflagcarrier",maps\mp\gametypes\_rank::getscoreinfovalue("kill_carrier"));
			lib_036E::func_2B7B("kill_carrier",param_01);
			param_01 thread [[ level.onxpevent ]]("kill_carrier");
			param_01 maps\mp\_utility::incpersstat("defends",1);
			thread maps\mp\_matchdata::logkillevent(param_09,"carrying");
			func_39C6();
		}
	}
}

//Function Number: 24
func_39C5(param_00)
{
	var_01 = level.otherteam[self.pers["team"]];
	self attach(level.carryflag[var_01],"J_spine4",1);
	self.carryflag = level.carryflag[var_01];
	self.cappedflag = param_00;
}

//Function Number: 25
func_39C6()
{
	self detach(self.carryflag,"J_spine4");
	self.carryflag = undefined;
}

//Function Number: 26
initgametypeawards()
{
	maps\mp\_awards::initstataward("flagscaptured",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("flagsreturned",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("flagcarrierkills",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("flagscarried",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("killsasflagcarrier",0,::maps\mp\_awards::highestwins);
}