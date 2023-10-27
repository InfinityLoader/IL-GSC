/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\oneflag.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 321 ms
 * Timestamp: 10/27/2023 2:13:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::setupcallbacks();
	maps\mp\gametypes\_globallogic::setupcallbacks();
	maps\mp\_utility::registertimelimitdvar(level.gametype,3,0,1440);
	maps\mp\_utility::registerscorelimitdvar(level.gametype,1,0,10000);
	maps\mp\_utility::registerroundlimitdvar(level.gametype,0,0,30);
	maps\mp\_utility::registerwinlimitdvar(level.gametype,4,0,10);
	maps\mp\_utility::registerroundswitchdvar(level.gametype,3,0,30);
	maps\mp\_utility::registernumlivesdvar(level.gametype,0,0,10);
	maps\mp\_utility::registerhalftimedvar(level.gametype,0,0,1);
	level.objectivebased = 1;
	level.teambased = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	level.onplayerkilled = ::onplayerkilled;
	level.ontimelimit = ::ontimelimit;
	level.initgametypeawards = ::initgametypeawards;
	game["dialog"]["gametype"] = "oneflag";
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

	if(getdvar("scr_oneflag_returntime") == "")
	{
		setdvar("scr_oneflag_returntime","15");
	}

	level.flagreturntime = getdvarint("scr_oneflag_returntime");
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
}

//Function Number: 3
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
	}

	setclientnamemode("auto_change");
	maps\mp\_utility::setobjectivetext(game["attackers"],&"OBJECTIVES_CTF");
	maps\mp\_utility::setobjectivetext(game["defenders"],&"OBJECTIVES_CTF");
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
	var_02[0] = "ctf";
	maps\mp\gametypes\_gameobjects::main(var_02);
	maps\mp\gametypes\_rank::registerscoreinfo("kill",100);
	maps\mp\gametypes\_rank::registerscoreinfo("headshot",100);
	maps\mp\gametypes\_rank::registerscoreinfo("assist",20);
	maps\mp\gametypes\_rank::registerscoreinfo("pickup",100);
	maps\mp\gametypes\_rank::registerscoreinfo("return",50);
	maps\mp\gametypes\_rank::registerscoreinfo("capture",500);
	maps\mp\gametypes\_rank::registerscoreinfo("kill_carrier",100);
	maps\mp\gametypes\_rank::registerscoreinfo("defend",100);
	maps\mp\gametypes\_rank::registerscoreinfo("defend_assist",100);
	maps\mp\gametypes\_rank::registerscoreinfo("assault",200);
	maps\mp\gametypes\_rank::registerscoreinfo("assault_assist",40);
	thread func_39B6();
}

//Function Number: 4
getspawnpoint()
{
	var_00 = self.pers["team"];
	if(game["switchedsides"])
	{
		var_00 = maps\mp\_utility::getotherteam(var_00);
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

//Function Number: 5
onspawnplayer()
{
	self.usingobj = undefined;
}

//Function Number: 6
func_39B6()
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
	level.iconcapture3d = "waypoint_capture";
	level.iconcapture2d = "compass_waypoint_capture";
	level.icondefend3d = "waypoint_defend";
	level.icondefend2d = "compass_waypoint_defend";
	level.icontarget3d = "waypoint_target";
	level.icontarget2d = "compass_waypoint_target";
	precacheshader(level.icon2d["axis"]);
	precacheshader(level.icon2d["allies"]);
	precacheshader(level.iconcapture3d);
	precacheshader(level.icondefend3d);
	precacheshader(level.iconcapture2d);
	precacheshader(level.icondefend2d);
	precacheshader(level.icontarget3d);
	precacheshader(level.icontarget2d);
	precacheshader("waypoint_kill");
	level.teamflags[game["defenders"]] = func_39C2(game["defenders"]);
	level.capzones[game["attackers"]] = func_39C3(game["attackers"]);
	level.flagcaptured = 0;
}

//Function Number: 7
spawnfxdelay(param_00,param_01,param_02,param_03,param_04)
{
	wait param_04;
	var_05 = spawnfx(param_00,param_01,param_02,param_03);
	triggerfx(var_05);
}

//Function Number: 8
func_39C2(param_00)
{
	var_01 = game["original_defenders"];
	var_02 = getent("ctf_trig_" + var_01,"targetname");
	if(!isdefined(var_02))
	{
		common_scripts\utility::error("No ctf_trig_" + var_01 + " trigger found in map.");
		return;
	}

	var_03[0] = getent("ctf_flag_" + var_01,"targetname");
	if(!isdefined(var_03[0]))
	{
		common_scripts\utility::error("No ctf_flag_" + var_01 + " script_model found in map.");
		return;
	}

	var_04 = spawn("trigger_radius",var_02.origin,0,96,var_02.height);
	var_02 delete();
	var_02 = var_04;
	var_03[0] setmodel(level.flagmodel[param_00]);
	var_05 = maps\mp\gametypes\_gameobjects::createcarryobject(param_00,var_02,var_03,(0,0,85));
	var_05 maps\mp\gametypes\_gameobjects::setteamusetime("friendly",15);
	var_05 maps\mp\gametypes\_gameobjects::setteamusetime("enemy",0);
	var_05 maps\mp\gametypes\_gameobjects::setteamusetext("enemy",&"MP_CAPTURING_FLAG");
	var_05 maps\mp\gametypes\_gameobjects::setteamusetext("friendly",&"MP_RETURNING_FLAG");
	var_05 maps\mp\gametypes\_gameobjects::allowcarry("enemy");
	var_05 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	var_05 maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.icondefend2d);
	var_05 maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.icondefend3d);
	var_05 maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconcapture2d);
	var_05 maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconcapture3d);
	var_05 maps\mp\gametypes\_gameobjects::setcarryicon(level.icon2d[param_00]);
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

//Function Number: 9
func_39C3(param_00)
{
	var_01 = level.otherteam[game["original_defenders"]];
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

	var_03[0] hide();
	var_03 = [];
	var_04 = maps\mp\gametypes\_gameobjects::createuseobject(param_00,var_02,var_03,(0,0,85));
	var_04 maps\mp\gametypes\_gameobjects::allowuse("friendly");
	var_04 maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	var_04 maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.icontarget2d);
	var_04 maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.icontarget3d);
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

//Function Number: 10
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

//Function Number: 11
onenduse(param_00,param_01,param_02)
{
	self.trigger.radius = self.oldradius;
}

//Function Number: 12
onpickup(param_00)
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

	if(var_01 == maps\mp\gametypes\_gameobjects::getownerteam())
	{
		param_00 thread maps\mp\gametypes\_hud_message::splashnotify("flagreturn",maps\mp\gametypes\_rank::getscoreinfovalue("pickup"));
		param_00 thread [[ level.onxpevent ]]("pickup");
		thread func_39C4();
		param_00 maps\mp\_utility::incplayerstat("flagsreturned",1);
		param_00 thread maps\mp\_matchdata::loggameevent("return",param_00.origin);
		return;
	}

	param_00 func_39C5();
	level.capzones[var_01] maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_defend");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_kill");
	maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.icontarget2d);
	maps\mp\_utility::printandsoundoneveryone(var_01,var_02,&"MP_ENEMY_FLAG_TAKEN_BY",&"MP_FLAG_TAKEN_BY","mp_obj_taken","mp_enemy_obj_taken",param_00);
	maps\mp\_utility::leaderdialog("enemy_flag_taken",var_01,"status");
	maps\mp\_utility::leaderdialog("flag_taken",var_02,"status");
	param_00 thread maps\mp\gametypes\_hud_message::splashnotify("flagpickup",maps\mp\gametypes\_rank::getscoreinfovalue("pickup"));
	lib_036E::func_2B7B("pickup",param_00);
	param_00 thread [[ level.onxpevent ]]("pickup");
	param_00 maps\mp\_utility::incplayerstat("flagscarried",1);
	param_00 thread maps\mp\_matchdata::loggameevent("pickup",param_00.origin);
}

//Function Number: 13
func_39C4()
{
	var_00 = maps\mp\gametypes\_gameobjects::getownerteam();
	var_01 = level.otherteam[var_00];
	maps\mp\gametypes\_gameobjects::returnhome();
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	maps\mp\gametypes\_gameobjects::allowcarry("enemy");
	level.capzones[var_01] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	maps\mp\_utility::printandsoundoneveryone(var_00,maps\mp\_utility::getotherteam(var_00),&"MP_FLAG_RETURNED",&"MP_ENEMY_FLAG_RETURNED","mp_obj_returned","mp_obj_returned","");
	maps\mp\_utility::leaderdialog("enemy_flag_returned",var_01,"status");
	maps\mp\_utility::leaderdialog("flag_returned",var_00,"status");
}

//Function Number: 14
ondrop(param_00)
{
	var_01 = maps\mp\gametypes\_gameobjects::getownerteam();
	var_02 = level.otherteam[var_01];
	maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.icondefend3d);
	maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.icondefend2d);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconcapture3d);
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	maps\mp\gametypes\_gameobjects::allowcarry("any");
	level.capzones[var_02] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
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
}

//Function Number: 15
onreset()
{
	self notify("flag_reset");
	var_00 = maps\mp\gametypes\_gameobjects::getownerteam();
	var_01 = level.otherteam[var_00];
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.icondefend3d);
	maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.icondefend2d);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconcapture3d);
	level.capzones[var_01] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
}

//Function Number: 16
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
	lib_036E::func_2B7B("capture",param_00);
	param_00 thread [[ level.onxpevent ]]("capture");
	param_00 maps\mp\_utility::incplayerstat("flagscaptured",1);
	param_00 notify("objective","captured");
	param_00 thread maps\mp\_matchdata::loggameevent("capture",param_00.origin);
	maps\mp\_utility::printandsoundoneveryone(var_01,var_02,&"MP_ENEMY_FLAG_CAPTURED_BY",&"MP_FLAG_CAPTURED_BY","mp_obj_captured","mp_enemy_obj_captured",param_00);
	thread flagcaptured(var_01,&"MP_DOM_NEUTRAL_FLAG_CAPTURED");
	level.teamflags[var_02] maps\mp\gametypes\_gameobjects::allowcarry("none");
	level.teamflags[var_02] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	level.teamflags[var_02] maps\mp\gametypes\_gameobjects::disableobject();
	level.capzones[var_01] maps\mp\gametypes\_gameobjects::allowuse("none");
	if(isdefined(param_00.carryflag))
	{
		param_00 func_39C6();
	}
}

//Function Number: 17
flagcaptured(param_00,param_01)
{
	maps\mp\gametypes\_gamelogic::endgame(param_00,param_01);
	level.flagcaptured = 1;
}

//Function Number: 18
ontimelimit()
{
	if(level.flagcaptured)
	{
		return;
	}

	maps\mp\gametypes\_gamelogic::endgame(game["defenders"],game["strings"]["time_limit_reached"]);
}

//Function Number: 19
oncantuse(param_00)
{
}

//Function Number: 20
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
			thread maps\mp\_matchdata::logkillevent(param_09,"carrying");
			func_39C6();
		}
	}
}

//Function Number: 21
func_39C5()
{
	var_00 = level.otherteam[self.pers["team"]];
	self attach(level.carryflag[var_00],"J_spine4",1);
	self.carryflag = level.carryflag[var_00];
}

//Function Number: 22
func_39C6()
{
	self detach(self.carryflag,"J_spine4");
	self.carryflag = undefined;
}

//Function Number: 23
initgametypeawards()
{
	maps\mp\_awards::initstataward("flagscaptured",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("flagsreturned",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("flagcarrierkills",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("flagscarried",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("killsasflagcarrier",0,::maps\mp\_awards::highestwins);
}