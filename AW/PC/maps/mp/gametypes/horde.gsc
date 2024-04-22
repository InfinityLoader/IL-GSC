/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\horde.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 174
 * Decompile Time: 2768 ms
 * Timestamp: 4/22/2024 2:10:57 AM
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
		maps\mp\_utility::registerroundswitchdvar(level.gametype,0,0,9);
		maps\mp\_utility::registertimelimitdvar(level.gametype,0);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,0);
		maps\mp\_utility::registerroundlimitdvar(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::registernumlivesdvar(level.gametype,1);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		setdvarifuninitialized("scr_horde_startinground",0);
		setdvarifuninitialized("scr_horde_difficulty",0);
		setdynamicdvar("scr_horde_hardcore",0);
	}

	setdynamicdvar("r_hudOutlineWidth",2);
	setdynamicdvar("scr_horde_timeLimit",0);
	setdynamicdvar("scr_horde_numLives",1);
	setdvarifuninitialized("horde_set_character_models",0);
	maps\mp\_utility::registertimelimitdvar(level.gametype,0);
	setdvarifuninitialized("scr_waveTableVersion",2);
	setspecialloadouts();
	initpickups();
	loadeffects();
	level.teambased = 1;
	level.ishorde = 1;
	level.disableforfeit = 1;
	level.nobuddyspawns = 1;
	level.alwaysdrawfriendlynames = 1;
	level.scorelimitoverride = 1;
	level.allowlatecomers = 1;
	level.skiplivesxpscalar = 1;
	level.highlightairdrop = 1;
	level.nocratetimeout = 1;
	level.noairdropkills = 1;
	level.allowlaststandai = 1;
	level.enableteamintel = 1;
	level.isteamintelcomplete = 1;
	level.removekillstreakicons = 1;
	level.assists_disabled = 1;
	level.skippointdisplayxp = 1;
	level.forceranking = 1;
	level.allowfauxdeath = 0;
	level.killstreakrewards = 0;
	level.supportintel = 0;
	level.donottrackgamesplayed = 1;
	level.playerteam = "allies";
	level.enemyteam = "axis";
	level.laststandusetime = 2000;
	level.currentteamintelname = "";
	level.timeromnvars = [];
	level.rankedmatch = 0;
	level.grenadegraceperiod = 0;
	level.disableweaponstats = 1;
	level.weaponweightfunc = ::hordeweaponweight;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onnormaldeath = ::onnormaldeath;
	level.onspawnplayer = ::onspawnplayer;
	level.modifyplayerdamage = ::modifyplayerdamagehorde;
	level.callbackplayerlaststand = ::maps\mp\gametypes\_horde_laststand::callback_playerlaststandhorde;
	level.ondeadevent = ::ondeadevent;
	level.customcratefunc = ::maps\mp\gametypes\_horde_crates::createhordecrates;
	level.onsuicidedeath = ::onnormaldeath;
	level.weapondropfunction = ::dropweaponfordeathhorde;
	level.hordevomissionfail = ::maps\mp\gametypes\_horde_dialog::hordevomissionfail;
	level.hordeupdatetimestats = ::maps\mp\gametypes\_horde_util::hordeupdatetimestats;
	level.cb_usedkillstreak = ::maps\mp\gametypes\_horde_util::horderemoveksicon;
	level.custom_giveloadout = ::hordecustomgiveloadout;
	level.hordehandlejuggdeath = ::maps\mp\gametypes\_horde_laststand::hordehandlejuggdeath;
	level.hordegivebackgoliath = ::maps\mp\gametypes\_horde_util::hordegivebackgoliath;
	level.laststandsaveloadoutinfo = ::maps\mp\gametypes\_horde_laststand::laststandsaveloadoutinfo;
	level.hordeonunderwater = ::maps\mp\gametypes\_horde_util::hordeonunderwater;
	level.hordedropandresetuplinkball = ::maps\mp\gametypes\_horde_util::hordedropandresetuplinkball;
	level.hordenumroundscompleted = 0;
	level.wavefirstspawn = 1;
	level.enemiesleft = 0;
	level.activehordedefendlocs = [];
	level.hordedefendlocs = [];
	level.horde_defend_killcount = 10;
	level.horde_collect_count = 20;
	level.horde_defuse_count = 3;
	level.hordecollected = 0;
	level.objdefend = 0;
	level.objcollect = 0;
	level.objintel = 0;
	level.objdefuse = 0;
	level.objuplink = 0;
	level.isobjectiveround = 0;
	level.killssinceinteldrop = 0;
	level.killssinceammodrop = 0;
	level.hordewaveadjust = 0;
	level.hordelevelflip = 1;
	level.hordeempduration = 60;
	level.hordepreviousfailureevent = "None";
	level.hordeweaponsjammed = 0;
	level.zombiesstarted = 0;
	level.onlydronesremaining = 0;
	level.fastesttime = undefined;
	level.numdroneswaitingtospawn = 0;
	level.droneweapon = "remote_turret_mp";
	level.hordeclassic = 1;
	level.players_ready = 0;
	level.noonespawnedyet = 1;
	level.weaponcamoorder = ["0","01","03","05","06","12","09","11","14","13","15","01","03","05","06","12","09","11","14","15","16"];
	level.horderoundstats = [];
	level.horderoundstats["support_drops_earned"] = 0;
	level.horderoundstats["round_time"] = 0;
	level.horderoundstats["objective_points"] = 0;
	level.classsettings = [];
	level.classsettings["light"]["classhealth"] = 125;
	level.classsettings["light"]["classDmgMod"] = 1;
	level.classsettings["light"]["allowDodge"] = 1;
	level.classsettings["light"]["allowSlide"] = 1;
	level.classsettings["light"]["speed"] = 1.15;
	level.classsettings["light"]["killstreak"] = "uav";
	level.classsettings["light"]["exoAbility"] = "exohoverhorde_equipment_mp";
	level.classsettings["light"]["classGrenade"] = "frag_grenade_horde_mp";
	level.classsettings["light"]["battery"] = 100;
	level.classsettings["heavy"]["classhealth"] = 250;
	level.classsettings["heavy"]["classDmgMod"] = 1.15;
	level.classsettings["heavy"]["allowDodge"] = 0;
	level.classsettings["heavy"]["allowSlide"] = 0;
	level.classsettings["heavy"]["speed"] = 0.9;
	level.classsettings["heavy"]["killstreak"] = "heavy_exosuit";
	level.classsettings["heavy"]["exoAbility"] = "exoshieldhorde_equipment_mp";
	level.classsettings["heavy"]["classGrenade"] = "frag_grenade_horde_mp";
	level.classsettings["heavy"]["battery"] = 100;
	level.classsettings["support"]["classhealth"] = 150;
	level.classsettings["support"]["classDmgMod"] = 1;
	level.classsettings["support"]["allowDodge"] = 0;
	level.classsettings["support"]["allowSlide"] = 0;
	level.classsettings["support"]["speed"] = 1;
	level.classsettings["support"]["killstreak"] = "remote_mg_sentry_turret";
	level.classsettings["support"]["exoAbility"] = "exocloakhorde_equipment_mp";
	level.classsettings["support"]["classGrenade"] = "frag_grenade_horde_mp";
	level.classsettings["support"]["battery"] = 100;
	level.classsettings["demolition"]["classhealth"] = 150;
	level.classsettings["demolition"]["classDmgMod"] = 1;
	level.classsettings["demolition"]["allowDodge"] = 0;
	level.classsettings["demolition"]["allowSlide"] = 1;
	level.classsettings["demolition"]["speed"] = 1;
	level.classsettings["demolition"]["killstreak"] = "missile_strike";
	level.classsettings["demolition"]["exoAbility"] = "exorepulsor_equipment_mp";
	level.classsettings["demolition"]["classGrenade"] = "contact_grenade_horde_mp";
	level.classsettings["demolition"]["battery"] = 100;
	level.modifiershieldaitypes = [];
	level.modifierexplosiveaitypes = [];
	level.modifiercompanionaitypes = [];
	level.modifiertoxicaitypes = [];
	level.hordemodedodgers = ["assault","assault_elite","em1","em1_heavy","cloak","rocket","em1_heavy"];
	level.hordemodegrunts = ["shotgun","smg","assault","em1"];
	level.hordemodeelites = ["em1_heavy","assault_elite","rocket","cloak","epm3","handler"];
	level.hordemodespecials = ["Quad","jugg","jugg_handler","em1_heavy"];
	level.hordegetoutsideposition = ::hordegetoutsideposition;
	level.hordedome = getentarray("horde_dome","targetname");
	level thread watchforhostmigrationselectclass();
	level thread hordeexploitclip();
	thread maps\mp\gametypes\_horde_warbird::horde_setup_warbird_pathnode_patch();
}

//Function Number: 2
hordegetoutsideposition()
{
	sortdroplocations();
	var_00 = level.hordedroplocations[0];
	level.hordeuseddroplocations[level.hordeuseddroplocations.size] = var_00;
	level.hordedroplocations = common_scripts\utility::array_remove(level.hordedroplocations,var_00);
	return var_00;
}

//Function Number: 3
hordeautoassign()
{
	thread maps\mp\gametypes\_menus::setteam(level.playerteam);
}

//Function Number: 4
loadeffects()
{
	level._effect["spawn_effect"] = loadfx("fx/maps/mp_siege_dam/mp_siege_spawn");
	level._effect["drone_fan_distortion"] = loadfx("vfx/distortion/drone_fan_distortion");
	level._effect["drone_fan_distortion_large"] = loadfx("vfx/distortion/drone_fan_distortion_large");
	level._effect["drone_thruster_distortion"] = loadfx("vfx/distortion/drone_thruster_distortion");
	level._effect["pdrone_death_explosion"] = loadfx("vfx/explosion/vehicle_pdrone_explosion");
	level._effect["pdrone_large_death_explosion"] = loadfx("vfx/explosion/vehicle_pdrone_large_explosion");
	level._effect["pdrone_emp_death"] = loadfx("vfx/explosion/vehicle_pdrone_explosion");
	level._effect["drone_beacon_red"] = loadfx("vfx/lights/light_drone_beacon_red");
	level._effect["drone_beacon_red_fast"] = loadfx("vfx/lights/light_drone_beacon_red_fast");
	level._effect["drone_beacon_red_slow_nolight"] = loadfx("vfx/lights/light_drone_beacon_red_slow_nolight");
	level._effect["drone_beacon_red_sm_nolight"] = loadfx("vfx/lights/light_drone_beacon_red_sm_nolight");
	level._effect["emp_drone_damage"] = loadfx("vfx/sparks/emp_drone_damage");
	level._effect["tracking_grenade_spray_large"] = loadfx("vfx/trail/tracking_grenade_hovering");
	level._effect["tracking_grenade_spray_small"] = loadfx("vfx/trail/tracking_grenade_spay_small");
	level._effect["tracking_grenade_trail"] = loadfx("vfx/trail/tracking_grenade_trail");
	level._effect["toxic_gas"] = loadfx("vfx/props/flare_ambient_green");
}

//Function Number: 5
initpickups()
{
	level.maxpickupsperround = getmaxpickupsperround();
	level.maxammopickupsperround = 4;
	level.currentpickupcount = 0;
	level.currentammopickupcount = 0;
	level.ammopickupmodel = "mil_grenade_box";
	level.collectpickupmodel = "prop_dogtags_future_enemy_animated";
	level.ammopickupfunc = ::ammopickup;
	level.collectpickupfunc = ::collectpickup;
}

//Function Number: 6
waitthenflashhudtimer(param_00)
{
	level endon("all_players_ready");
	level endon("collect_complete");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_00);
	settimeromnvar("ui_cranked_bomb_timer_final_seconds",1);
}

//Function Number: 7
sethudtimer(param_00,param_01)
{
	level thread waitthenflashhudtimer(param_01 - 5);
	settimeromnvar("ui_cranked_bomb_timer_text",param_00);
	settimeromnvar("ui_cranked_bomb_timer_end_milliseconds",int(gettime() + param_01 * 1000));
}

//Function Number: 8
clearhudtimer()
{
	settimeromnvar("ui_cranked_bomb_timer_end_milliseconds",0);
}

//Function Number: 9
settimeromnvar(param_00,param_01)
{
	level.timeromnvars[param_00] = param_01;
	foreach(var_03 in level.players)
	{
		if(!isagent(var_03))
		{
			var_03 setclientomnvar(param_00,param_01);
		}
	}
}

//Function Number: 10
updatetimeromnvars(param_00)
{
	foreach(var_03, var_02 in level.timeromnvars)
	{
		if(!isagent(param_00))
		{
			param_00 setclientomnvar(var_03,var_02);
		}
	}
}

//Function Number: 11
getmaxpickupsperround()
{
	var_00 = maps\mp\gametypes\_horde_util::getnumplayers() + 1;
	return clamp(var_00,3,5);
}

//Function Number: 12
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	setdynamicdvar("scr_horde_roundswitch",0);
	maps\mp\_utility::registerroundswitchdvar("horde",0,0,9);
	setdynamicdvar("scr_horde_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar("horde",1);
	setdynamicdvar("scr_horde_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("horde",1);
	setdynamicdvar("scr_horde_halftime",0);
	maps\mp\_utility::registerhalftimedvar("horde",0);
	setdynamicdvar("scr_horde_timeLimit",0);
	maps\mp\_utility::registertimelimitdvar(level.gametype,0);
	setdynamicdvar("scr_horde_numLives",1);
	maps\mp\_utility::registernumlivesdvar(level.gametype,1);
	setdynamicdvar("scr_horde_difficulty",getmatchrulesdata("hordeData","difficulty"));
	setdynamicdvar("scr_horde_startinground",getmatchrulesdata("hordeData","startingWave"));
	setdynamicdvar("scr_horde_hardcore",getmatchrulesdata("hordeData","supportDropsOff"));
	setdynamicdvar("r_hudOutlineWidth",2);
}

//Function Number: 13
onstartgametype()
{
	setclientnamemode("auto_change");
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	maps\mp\_utility::setobjectivetext("allies",&"OBJECTIVES_DOM");
	maps\mp\_utility::setobjectivetext("axis",&"OBJECTIVES_DOM");
	maps\mp\_utility::setobjectivescoretext("allies",&"HORDE_OBJECTIVE_SCORE");
	maps\mp\_utility::setobjectivescoretext("axis",&"HORDE_OBJECTIVE_SCORE");
	maps\mp\_utility::setobjectivehinttext("allies",&"HORDE_OBJECTIVE_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"HORDE_OBJECTIVE_HINT");
	initspawns();
	maps\mp\gametypes\_horde_dialog::hordedialoginit();
	var_00[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::main(var_00);
	inithordesettings();
	level thread monitoronlydrones();
	level thread onplayerconnecthorde();
	level thread runhordemode();
	if(!level.hordeishardcore)
	{
		level thread rundroplocations();
	}
}

//Function Number: 14
inithordesettings()
{
	setdvar("g_keyboarduseholdtime",250);
	level.hordedroplocations = common_scripts\utility::getstructarray("horde_drop","targetname");
	level.hordeuseddroplocations = [];
	level.intelminigun = "iw6_minigunjugg_mp";
	level.hordedifficultylevel = int(clamp(getdvarint("scr_horde_difficulty"),0,2));
	level.hordestartinground = getdvarint("scr_horde_startinground");
	level.hordeishardcore = getdvarint("scr_horde_hardcore");
	level.maxrounds = 25;
	level.currentroundnumber = 0;
	level.currentpointtotal = 0;
	level.enemyoutlinecolor = 0;
	level.droplocationindex = 0;
	hordedroplocationtrace();
	level.chancetospawndog = 0;
	level.lastdoground = 0;
	level.pointevents = [];
	level.pointevents["damage_body"] = 10;
	level.pointevents["damage_head"] = 30;
	level.pointevents["kill_normal"] = 20;
	level.pointevents["kill_melee"] = 50;
	level.pointevents["kill_head"] = 50;
	level.pointevents["kill_defend"] = 50;
	level.pointevents["collect"] = 50;
	level.hudleftspace = 50;
	level.huddownspace = 395;
	if(maps\mp\_utility::getmapname() == "mp_prison_z")
	{
		level.maxrounds = 12;
	}
}

//Function Number: 15
hordedroplocationtrace()
{
	foreach(var_01 in level.hordedroplocations)
	{
		var_02 = var_01.origin + (0,0,32);
		var_03 = var_01.origin - (0,0,256);
		var_04 = bullettrace(var_02,var_03,0);
		var_01.tracelocation = var_01.origin;
		if(var_04["fraction"] < 1)
		{
			var_01.tracelocation = var_04["position"];
		}
	}
}

//Function Number: 16
onplayerconnecthorde()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.gamemodefirstspawn = 1;
		level thread createplayervariables(var_00);
		level thread monitorstuck(var_00);
		level thread monitordome(var_00);
		level thread updateoutlines(var_00);
		level thread updateobjectiveui(var_00);
		level thread maps\mp\gametypes\_horde_smart_grenade::monitorsmartgrenade(var_00);
		level thread maps\mp\gametypes\_horde_util::hordeupdatenummatches(var_00);
		level thread monitorplayercamping(var_00);
		level thread monitordisconnect(var_00);
		if(isdefined(level.objdefend) && level.objdefend)
		{
			level thread hordedefendenemyoutline(var_00);
		}

		thread forceclassselection(var_00);
		var_00 thread maps\mp\gametypes\_horde_armory::closehordearmoryonoffhandweapon();
	}
}

//Function Number: 17
forceclassselection(param_00)
{
	param_00 endon("horde_class_change");
	param_00 endon("disconnect");
	param_00.usingarmory = 1;
	param_00.classselection = 1;
	thread monitorclassselection(param_00);
	var_01 = param_00 common_scripts\utility::waittill_any_timeout(60,"death","becameSpectator");
	param_00 setclientomnvar("ui_horde_show_armory",0);
	param_00.usingarmory = 0;
	param_00.classselection = 0;
	if(var_01 == "timeout")
	{
		param_00 notify("luinotifyserver","horde_exo_class",100);
	}
}

//Function Number: 18
monitorclassselection(param_00)
{
	level endon("game_ended");
	param_00 endon("horde_class_change");
	param_00 endon("death");
	param_00 endon("becameSpectator");
	for(;;)
	{
		param_00 waittill("luinotifyserver",var_01,var_02);
		if(var_01 == "horde_armory_closed")
		{
			wait(0.5);
			param_00 setclientomnvar("ui_horde_armory_type","class");
			param_00 setclientomnvar("ui_horde_show_armory",1);
		}
	}
}

//Function Number: 19
monitordisconnect(param_00)
{
	level endon("game_ended");
	param_00 waittill("disconnect");
	level notify("player_disconnected");
}

//Function Number: 20
createplayervariables(param_00)
{
	param_00.horde_perks = [];
	param_00.pointnotifylua = [];
	param_00.beingrevived = 0;
	param_00.wasunderwater = 0;
	param_00.hasselfrevive = 0;
	param_00.saveweapons = [];
	param_00.firstsaveweapon = "none";
	param_00.classselection = 0;
	param_00.killz = 0;
	param_00.numrevives = int(0);
	param_00.numcratesobtained = 0;
	param_00.roundsplayed = 0;
	param_00.horde_score = int(0);
	param_00.deaths = 511;
	param_00 maps\mp\_utility::setpersstat("deaths",param_00.deaths);
	param_00.objectivescompleted = 0;
	param_00.meleekills = 0;
	param_00.headshotkills = 0;
	param_00.numsincesamedroptype = 0;
	param_00.lastdroptype = "none";
	param_00.roundkills = 0;
	param_00.roundheadshots = 0;
	param_00.roundupgradepoints = 0;
	param_00.hordeheadshots = 0;
	param_00.armorypoints = 0;
	param_00.collectcount = 0;
	param_00.classdmgmod = 1;
	param_00.weaponproficiency = 0;
	param_00.hordearmor = 0;
	param_00.hordeexobattery = 0;
	param_00.energydmgmod = 1;
	param_00.weapondmgmod = 1;
	param_00.classabilitytime = 0;
	param_00.classabilityready = 1;
	param_00.classchosen = 0;
	param_00.hordeclassturret = undefined;
	param_00.isrunningarmorycommand = 0;
	param_00.classswitchwaiting = 0;
	param_00.isrunningweapongive = 0;
	param_00.missileweapon = undefined;
	param_00.rocket = undefined;
	param_00.markedformech = [];
	param_00.aerialassaultdrone = undefined;
	param_00.hordeclassweapons["light"]["primary"] = "iw5_kf5_mp";
	param_00.hordeclassweapons["light"]["secondary"] = "iw5_titan45_mp_xmags";
	param_00.hordeclassweapons["support"]["primary"] = "iw5_uts19_mp";
	param_00.hordeclassweapons["support"]["secondary"] = "iw5_vbr_mp_xmags";
	param_00.hordeclassweapons["heavy"]["primary"] = "iw5_em1_mp";
	param_00.hordeclassweapons["heavy"]["secondary"] = "iw5_pbw_mp_xmags";
	param_00.hordeclassweapons["demolition"]["primary"] = "iw5_microdronelaunchercoop_mp";
	param_00.hordeclassweapons["demolition"]["secondary"] = "iw5_titan45_mp_xmags";
	param_00.hordekillstreakmodules = ["sentry_guardian","assault_ugv_ai","assault_ugv_mg"];
	param_00.classsettings = level.classsettings;
	param_00.ignoreme = 1;
	if(1)
	{
		if(0)
		{
			level.playerstartweaponname = "iw5_kf5_mp_none";
		}
		else
		{
			level.playerstartweaponname = "iw5_kf5_mp";
		}

		var_01 = getweaponbasename(level.playerstartweaponname);
	}

	level thread activateplayerhud(param_00);
	level thread monitorpointnotifylua(param_00);
	level thread maps\mp\gametypes\_horde_armory::monitorupgrades(param_00);
	maps\mp\gametypes\_horde_util::hordecleardata(param_00);
	maps\mp\gametypes\_horde_util::hordecompletetu1transition(param_00);
	if(maps\mp\_utility::matchmakinggame())
	{
		monitorinactivity(param_00);
	}
}

//Function Number: 21
monitorinactivity(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	var_01 = 0;
	var_02 = 0;
	for(;;)
	{
		var_03 = param_00 getnormalizedmovement();
		if(param_00 attackbuttonpressed() || param_00 adsbuttonpressed() || param_00 meleebuttonpressed() || param_00 fragbuttonpressed() || param_00 secondaryoffhandbuttonpressed() || param_00 jumpbuttonpressed() || param_00 sprintbuttonpressed() || var_03[0] != 0 || var_03[1] != 0)
		{
			var_01 = 0;
			var_02 = 0;
		}

		if(var_01 >= 180)
		{
			kick(param_00 getentitynumber(),"EXE_PLAYERKICKED_INACTIVE");
			break;
		}
		else if(var_01 >= 170 && !var_02)
		{
			param_00 iprintlnbold(&"GAME_INACTIVEDROPWARNING");
			var_02 = 1;
		}

		if(param_00.sessionstate != "spectator")
		{
			var_01 = var_01 + 0.05;
		}

		if(level.zombiesstarted)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 22
hasweaponstate(param_00,param_01)
{
	return isdefined(param_01) && isdefined(param_00.weaponstate[param_01]);
}

//Function Number: 23
playaispawneffect()
{
	playfx(level._effect["spawn_effect"],self.origin);
}

//Function Number: 24
onspawnplayer()
{
	var_00 = undefined;
	if(self.gamemodefirstspawn)
	{
		self.pers["class"] = "gamemode";
		self.pers["lastClass"] = "";
		self.pers["gamemodeLoadout"] = level.hordeloadouts[level.playerteam];
		self.class = self.pers["class"];
		self.lastclass = self.pers["lastClass"];
		maps\mp\gametypes\_class::giveloadout(self.team,self.class);
		self.maxhealth = 200;
		self.health = self.maxhealth;
	}

	if(isagent(self))
	{
		if(!maps\mp\gametypes\_horde_util::isonhumanteam(self))
		{
			setenemydifficultysettings(self);
			var_00 = self.hordeloadout;
			self.pers["gamemodeLoadout"] = var_00;
			self.horde_type = var_00["type"];
			self.awardpoints = var_00["points"];
			if(var_00["type"] == "zombie")
			{
				self.agentname = undefined;
			}
			else
			{
				self.agentname = var_00["name_localized"];
			}

			thread playaispawneffect();
			self botsetdifficultysetting("allowGrenades",1);
		}
		else
		{
			self.pers["gamemodeLoadout"] = level.hordeloadouts["squadmate"];
			maps\mp\bots\_bots_util::bot_set_personality("camper");
			maps\mp\bots\_bots_util::bot_set_difficulty("regular");
			self botsetdifficultysetting("allowGrenades",1);
		}

		self.avoidkillstreakonspawntimer = 0;
	}

	thread onspawnfinished(var_00);
}

//Function Number: 25
setenemydifficultysettings(param_00)
{
	param_00 maps\mp\bots\_bots_util::bot_set_personality("run_and_gun");
	param_00 maps\mp\bots\_bots_util::bot_set_difficulty("recruit");
	param_00 hordeaddgeneraltuningvalues();
}

//Function Number: 26
onspawnfinished(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(!self.gamemodefirstspawn)
	{
		return;
	}

	self waittill("applyLoadout");
	maps\mp\killstreaks\_killstreaks::clearkillstreaks();
	if(maps\mp\gametypes\_horde_util::isonhumanteam(self))
	{
		self givemaxammo(level.playerstartweaponname);
		if(self.gamemodefirstspawn)
		{
			self setclientomnvar("ui_horde_show_armory",1);
		}

		if(isplayer(self))
		{
			self setweaponammoclip("frag_grenade_mp",1);
			self setweaponammoclip("none",0);
			self setclientomnvar("exo_ability_nrg_total0",0);
			self setclientomnvar("ui_exo_battery_level0",0);
			self takeweapon("frag_grenade_mp");
			self setlethalweapon("frag_grenade_horde_mp");
			self giveweapon("frag_grenade_horde_mp");
			self setweaponammoclip("frag_grenade_horde_mp",4);
			maps\mp\_utility::giveperk("specialty_pistoldeath",0);
			maps\mp\_utility::giveperk("specialty_horde_dualprimary",1,1);
			self loadweapons(["iw5_em1_mp","iw5_kf5_mp","iw5_uts19_mp","iw5_titan45_mp","iw5_vbr_mp","iw5_pbw_mp"]);
			self loadweapons(["iw5_microdronelauncher_mp","iw5_microdronelaunchercoop_mp"]);
			self loadweapons(maps\mp\gametypes\_horde_laststand::hordelaststandweapon());
			childthread updaterespawnsplash(self.gamemodefirstspawn);
			removeperkhud(self);
			updatetimeromnvars(self);
		}

		if(isagent(self))
		{
			self.agentname = &"HORDE_GRUNT";
			self.horde_type = "Buddy";
			childthread ammorefillprimary();
			thread maps\mp\bots\_bots::bot_think_revive();
		}
	}
	else
	{
		childthread ammorefillprimary();
		childthread ammorefillsecondary();
		self.maxhealth = hordegetenemyhealth(param_00);
		self.health = self.maxhealth;
		hordeaddnavigationabilities();
		if(self.horde_type != "zombie")
		{
			hordeapplyaimodifiers();
		}

		switch(self.horde_type)
		{
			case "shotgun":
				self.agentname = &"HORDE_GRUNT";
				self botsetdifficultysetting("maxNonAutoFireDelay",1500);
				self botsetdifficultysetting("minNonAutoFireDelay",800);
				self setagentcostumeindex(randomintrange(1,5));
				break;

			case "smg":
				self.agentname = &"HORDE_GUNNER";
				hordesetcharactermodel("kva_body_smg_mp","kva_head_smg");
				self botsetdifficultysetting("minBurstFireTime",100);
				self botsetdifficultysetting("maxBurstFireTime",600);
				self botsetdifficultysetting("minTimeBetweenBursts",600);
				self botsetdifficultysetting("maxTimeBetweenBursts",1500);
				self botsetdifficultysetting("dodgeChance",0.3);
				self botsetdifficultysetting("dodgeIntelligence",0.8);
				self setagentcostumeindex(randomintrange(5,9));
				break;

			case "cloak":
				self.agentname = &"HORDE_ASSASSIN";
				self.movespeedscaler = param_00["movespeedscale"];
				self botsetdifficultysetting("minBurstFireTime",200);
				self botsetdifficultysetting("maxBurstFireTime",1000);
				self botsetdifficultysetting("minTimeBetweenBursts",500);
				self botsetdifficultysetting("maxTimeBetweenBursts",1200);
				self botsetdifficultysetting("dodgeChance",0.8);
				self botsetdifficultysetting("dodgeIntelligence",1);
				self setagentcostumeindex(10);
				self cloakingenable();
				break;

			case "assault":
				self.agentname = &"HORDE_ASSAULT";
				self botsetdifficultysetting("minBurstFireTime",400);
				self botsetdifficultysetting("maxBurstFireTime",1200);
				self botsetdifficultysetting("minTimeBetweenBursts",400);
				self botsetdifficultysetting("maxTimeBetweenBursts",1200);
				self botsetdifficultysetting("dodgeChance",0.6);
				self botsetdifficultysetting("dodgeIntelligence",0.8);
				if(level.hordelevelflip < 2)
				{
					self botsetdifficultysetting("strafeChance",0.4);
					self botsetdifficultysetting("reactionTime",425);
				}
	
				self setagentcostumeindex(10);
				break;

			case "assault_elite":
				self.agentname = &"HORDE_ELITE";
				self botsetdifficultysetting("minBurstFireTime",600);
				self botsetdifficultysetting("maxBurstFireTime",2400);
				self botsetdifficultysetting("minTimeBetweenBursts",100);
				self botsetdifficultysetting("maxTimeBetweenBursts",600);
				self botsetdifficultysetting("dodgeChance",0.6);
				self botsetdifficultysetting("dodgeIntelligence",0.8);
				self botsetdifficultysetting("reactionTime",100);
				self botsetdifficultysetting("diveChance",0.2);
				if(level.hordelevelflip < 3)
				{
					self botsetdifficultysetting("strafeChance",0.7);
				}
	
				self setagentcostumeindex(randomintrange(19,23));
				if(level.hordelevelflip > 1 || getdvarint("scr_horde_preview") > 0)
				{
					self takeallweapons();
					self giveweapon("turretheadmg_mp");
					self switchtoweaponimmediate("turretheadmg_mp");
				}
				break;

			case "epm3":
				self.agentname = &"HORDE_EPM3";
				self botsetdifficultysetting("dodgeChance",0.4);
				self botsetdifficultysetting("dodgeIntelligence",0.8);
				self botsetdifficultysetting("minInaccuracy",0.1);
				self botsetdifficultysetting("maxInaccuracy",0.15);
				self botsetdifficultysetting("minNonAutoFireDelay",200);
				self botsetdifficultysetting("maxNonAutoFireDelay",400);
				if(level.hordelevelflip < 3)
				{
					self botsetdifficultysetting("reactionTime",200);
				}
	
				if(level.hordelevelflip < 2)
				{
					self botsetdifficultysetting("strafeChance",0.5);
				}
	
				self setagentcostumeindex(15);
				break;

			case "em1":
				self.agentname = &"HORDE_BEAMER";
				hordesetcharactermodel("kva_hazmat_body_a_mp","kva_hazmat_head_a");
				self botsetdifficultysetting("dodgeChance",0.3);
				self botsetdifficultysetting("dodgeIntelligence",0.5);
				self botsetdifficultysetting("maxNonAutoFireDelay",2800);
				self botsetdifficultysetting("minNonAutoFireDelay",1500);
				self setagentcostumeindex(9);
				break;

			case "em1_heavy":
				self.agentname = &"HORDE_BEAMER_HEAVY";
				hordesetcharactermodel("nk_army_assault_body_mp","nk_army_a_head");
				self botsetdifficultysetting("dodgeChance",0.5);
				self botsetdifficultysetting("dodgeIntelligence",0.5);
				self botsetdifficultysetting("maxNonAutoFireDelay",1400);
				self botsetdifficultysetting("minNonAutoFireDelay",750);
				self setagentcostumeindex(18);
				break;

			case "rocket":
				self.agentname = &"HORDE_LAUNCHER";
				hordesetcharactermodel("atlas_arctic_guard_body_mp","atlas_arctic_head_a");
				self botsetdifficultysetting("maxNonAutoFireDelay",2000);
				self botsetdifficultysetting("minNonAutoFireDelay",1000);
				self setagentcostumeindex(17);
				if(level.hordelevelflip > 1 || getdvarint("scr_horde_preview") > 0)
				{
					self takeallweapons();
					self giveweapon("turretheadrocket_mp");
					self switchtoweaponimmediate("turretheadrocket_mp");
				}
				break;

			case "jugg":
				self.agentname = &"HORDE_AST";
				maps\mp\killstreaks\_juggernaut::playersetjuggexomodel();
				self setplayermech(1);
				self botsetstance("stand");
				self allowjump(0);
				self allowladder(0);
				self allowmantle(0);
				self allowcrouch(0);
				self allowprone(0);
				maps\mp\_utility::playerallowhighjump(0,"class");
				maps\mp\_utility::playerallowdodge(0,"class");
				hordeattachminigunbarrel();
				thread hordeaddcompaniondrone(1,1,1);
				thread maps\mp\killstreaks\_juggernaut::playercleanupbarrel();
				thread maps\mp\killstreaks\_juggernaut::play_goliath_death_fx();
				if(maps\mp\_utility::getmapname() == "mp_detroit")
				{
					thread maps\mp\agents\_agents_gametype_horde::handledetroitgoliathtrailerexploit();
				}
				break;

			case "jugg_handler":
				self.agentname = &"HORDE_AST";
				maps\mp\killstreaks\_juggernaut::playersetjuggexomodel();
				self setplayermech(1);
				thread hordeaddcompaniondrone(1,1,1);
				self botsetstance("stand");
				self allowjump(0);
				self allowladder(0);
				self allowmantle(0);
				self allowcrouch(0);
				self allowprone(0);
				maps\mp\_utility::playerallowhighjump(0,"class");
				maps\mp\_utility::playerallowdodge(0,"class");
				hordeattachminigunbarrel();
				thread maps\mp\killstreaks\_juggernaut::playercleanupbarrel();
				thread maps\mp\killstreaks\_juggernaut::play_goliath_death_fx();
				if(maps\mp\_utility::getmapname() == "mp_detroit")
				{
					thread maps\mp\agents\_agents_gametype_horde::handledetroitgoliathtrailerexploit();
				}
	
				if(level.currentroundnumber > 13 || level.hordelevelflip > 1 || getdvarint("scr_horde_preview") > 0)
				{
					thread maps\mp\agents\_agents_gametype_horde::hordejuggrocketswarmthink();
				}
				break;

			case "handler":
				self.agentname = &"HORDE_HANDLER";
				self botsetdifficultysetting("minBurstFireTime",1500);
				self botsetdifficultysetting("maxBurstFireTime",3000);
				self botsetdifficultysetting("dodgeChance",0.2);
				self botsetdifficultysetting("dodgeIntelligence",0.4);
				thread hordeaddcompaniondrone();
				self setagentcostumeindex(randomintrange(11,15));
				break;

			case "zombie":
				maps\mp\gametypes\_horde_zombies::hordesetzombiemodel();
				maps\mp\gametypes\_horde_zombies::hordezombiesounds();
				self botsetstance("stand");
				self allowcrouch(0);
				break;

			default:
				break;
		}

		self setclothtype("cloth");
	}

	self.gamemodefirstspawn = 0;
}

//Function Number: 27
hordeattachminigunbarrel()
{
	self.barrellinker = spawn("script_model",self gettagorigin("tag_barrel"));
	self.barrellinker setmodel("generic_prop_raven");
	self.barrellinker vehicle_jetbikesethoverforcescale(self,"tag_barrel",(12.7,0,-2.9),(90,0,0));
	self.barrel = spawn("script_model",self.barrellinker gettagorigin("j_prop_1"));
	self.barrel setmodel("npc_exo_armor_minigun_barrel");
	self.barrel vehicle_jetbikesethoverforcescale(self.barrellinker,"j_prop_1",(0,0,0),(-90,0,0));
}

//Function Number: 28
hordeaddgeneraltuningvalues()
{
	var_00 = self;
	var_00 botsetdifficultysetting("visionBlinded",0.05);
	var_00 botsetdifficultysetting("hearingDeaf",0.05);
	var_00 botsetdifficultysetting("targetVehicleChance",1);
	var_00 botsetdifficultysetting("meleeReactAllowed",1);
	var_00 botsetdifficultysetting("meleeReactionTime",600);
	var_00 botsetdifficultysetting("meleeDist",85);
	var_00 botsetdifficultysetting("meleeChargeDist",100);
	var_00 botsetdifficultysetting("minBurstFireTime",400);
	var_00 botsetdifficultysetting("maxBurstFireTime",2400);
	var_00 botsetdifficultysetting("minTimeBetweenBursts",400);
	var_00 botsetdifficultysetting("maxTimeBetweenBursts",1200);
	var_00 botsetdifficultysetting("dodgeChance",0);
	var_00 botsetdifficultysetting("dodgeIntelligence",0);
	var_00 botsetdifficultysetting("strafeChance",0.35);
	var_00 botsetdifficultysetting("avoidSkyPercent",0);
	if(level.currentroundnumber > 8 && level.hordelevelflip == 1)
	{
		var_00 botsetdifficultysetting("minInaccuracy",0.75);
		var_00 botsetdifficultysetting("maxInaccuracy",1.5);
	}
	else if(level.hordelevelflip == 1)
	{
		var_00 botsetdifficultysetting("minInaccuracy",2.25);
		var_00 botsetdifficultysetting("maxInaccuracy",4.5);
	}

	if(level.currentroundnumber > 20 || level.hordelevelflip > 1)
	{
		var_00 botsetdifficultysetting("adsAllowed",1);
		var_00 botsetdifficultysetting("diveChance",0.15);
		var_00 botsetdifficultysetting("strafeChance",0.5);
		var_00 botsetdifficultysetting("strategyLevel",1);
	}

	if(level.hordelevelflip == 2)
	{
		var_00 botsetdifficultysetting("reactionTime",200);
		var_00 botsetdifficultysetting("strategyLevel",3);
		var_00 botsetdifficultysetting("cornerFireChance",0.5);
		var_00 botsetdifficultysetting("cornerJumpChance",0.3);
		var_00 botsetdifficultysetting("strafeChance",0.7);
		var_00 botsetdifficultysetting("diveChance",0.2);
		var_00 botsetdifficultysetting("launcherRespawnChance",0.25);
		var_00 botsetdifficultysetting("minInaccuracy",0.5);
		var_00 botsetdifficultysetting("maxInaccuracy",1);
		var_00 botsetdifficultysetting("grenadeCookPrecision",500);
		return;
	}

	if(level.hordelevelflip > 2)
	{
		var_00 botsetdifficultysetting("reactionTime",100);
		var_00 botsetdifficultysetting("strategyLevel",3);
		var_00 botsetdifficultysetting("cornerFireChance",1);
		var_00 botsetdifficultysetting("cornerJumpChance",0.75);
		var_00 botsetdifficultysetting("diveChance",0.2);
		var_00 botsetdifficultysetting("strafeChance",0.9);
		var_00 botsetdifficultysetting("launcherRespawnChance",0.4);
		var_00 botsetdifficultysetting("minInaccuracy",0.25);
		var_00 botsetdifficultysetting("maxInaccuracy",0.75);
		var_00 botsetdifficultysetting("grenadeCookPrecision",100);
	}
}

//Function Number: 29
hordeaddnavigationabilities()
{
	var_00 = self;
	if((isdefined(var_00.horde_type) && var_00.horde_type == "jugg") || var_00.horde_type == "jugg_handler")
	{
		return;
	}

	if(level.hordelevelflip > 1 || level.currentroundnumber >= 8)
	{
		if(isdefined(var_00.horde_type) && !common_scripts\utility::array_contains(level.hordemodedodgers,var_00.horde_type))
		{
			return;
		}

		if(common_scripts\utility::cointoss())
		{
			return;
		}

		var_00 maps\mp\_utility::playerallowdodge(1,"class");
		var_00 botsetdifficultysetting("dodgeChance",0.3);
		var_00 botsetdifficultysetting("dodgeIntelligence",0.8);
		return;
	}

	if(level.currentroundnumber < 3)
	{
		var_00 maps\mp\_utility::playerallowdodge(0,"class");
	}
}

//Function Number: 30
hordeapplyaimodifiers()
{
	if(level.hordelevelflip == 1 && level.currentroundnumber < 12)
	{
		return;
	}

	var_00 = clamp(level.hordelevelflip,1,4);
	switch(int(var_00))
	{
		case 4:
			if(maps\mp\_utility::currentactivevehiclecount(2) < maps\mp\_utility::maxvehiclesallowed())
			{
				if(hordeapplyaimodifiersdiceroll(level.modifiercompanionaitypes,clamp(5 * level.hordelevelflip,5,25)))
				{
					thread hordeaddcompaniondrone();
				}
			}
	
			break;

		case 3:
			if(hordeapplyaimodifiersdiceroll(level.modifierexplosiveaitypes,clamp(10 * level.hordelevelflip,10,45)))
			{
				thread hordeaddexplosivedeath();
			}
	
			break;

		case 2:
			if(hordeapplyaimodifiersdiceroll(level.modifiershieldaitypes,clamp(20 * level.hordelevelflip,20,75)))
			{
				hordeaddexoshield();
			}
	
			break;
	}
}

//Function Number: 31
hordeapplyaimodifiersdiceroll(param_00,param_01)
{
	if(common_scripts\utility::array_contains(param_00,self.horde_type) && maps\mp\gametypes\_horde_util::cointossweighted(param_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 32
hordeaddtoxicgas()
{
	var_00 = spawn("script_model",self.origin);
	var_00 setmodel("tag_origin");
	wait 0.05;
	var_00 linkto(self,"tag_origin",(0,0,16),(0,0,0));
	wait(1);
	foreach(var_02 in level.players)
	{
		playfxontagforclients(common_scripts\utility::getfx("toxic_gas"),var_00,"tag_origin",var_02);
	}

	thread hordeaddtoxicgasthink();
	thread hordeaddtoxicgascleanup(var_00);
}

//Function Number: 33
hordeaddtoxicgascleanup(param_00)
{
	self waittill("death");
	foreach(var_02 in level.players)
	{
		stopfxontagforclient(common_scripts\utility::getfx("toxic_gas"),param_00,"tag_origin",var_02);
	}

	param_00 delete();
}

//Function Number: 34
hordeaddtoxicgasthink()
{
	self endon("death");
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(distance(self.origin,var_01.origin) < 100)
			{
				var_01 shellshock("mp_lab_gas",1);
			}
		}

		wait(1);
	}
}

//Function Number: 35
hordeaddexplosivedeath()
{
	self waittill("death");
	var_00 = self.origin;
	magicgrenademanual("frag_grenade_mp",var_00,(0,0,0),2);
}

//Function Number: 36
hordeaddexoshield()
{
	self botsetdifficultysetting("allowGrenades",1);
	self botsetdifficultysetting("exoTacticalAllowed",1);
	self.pers["numberOfTimesShieldUsed"] = 0;
	self settacticalweapon("exoshieldhorde_equipment_mp");
	self giveweapon("exoshieldhorde_equipment_mp");
	thread maps\mp\_exo_shield::exo_shield_think();
	maps\mp\_utility::giveperk("specialty_extratactical",0);
	var_00 = self getweaponammoclip("exoshieldhorde_equipment_mp");
	self setweaponammoclip("exoshieldhorde_equipment_mp",var_00 + 1);
}

//Function Number: 37
hordeaddcompaniondrone(param_00,param_01,param_02)
{
	self endon("death");
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	for(var_03 = 0;var_03 < param_00;var_03++)
	{
		while(maps\mp\_utility::currentactivevehiclecount(2) >= maps\mp\_utility::maxvehiclesallowed())
		{
			wait(1);
		}

		var_04 = maps\mp\_tracking_drone::createtrackingdrone();
		thread maps\mp\_tracking_drone::starttrackingdrone(var_04);
		var_04 thread handlerdronethink(self,param_01,param_02);
	}
}

//Function Number: 38
handlerdronethink(param_00,param_01,param_02)
{
	self endon("death");
	if(param_01)
	{
		thread respawnhandlerdrone(param_00);
	}

	if(param_02)
	{
		param_00 common_scripts\utility::waittill_any_timeout(30,"damage","weapon_fired");
		if(isdefined(param_00) && isalive(param_00))
		{
			param_00 common_scripts\utility::waittill_any_timeout(randomintrange(10,20),"death");
		}
	}
	else
	{
		param_00 waittill("death");
	}

	self.maxhealth = 1;
	self playloopsound(level.trackingdronesettings.sound_lock);
	self notify("leaving");
	var_03 = maps\mp\gametypes\_horde_util::hordegetclosesthealthyplayer(self.origin);
	if(!isdefined(var_03))
	{
		thread maps\mp\_tracking_drone::trackingdroneexplode();
		return;
	}

	self setdronegoalpos(var_03,(0,0,72));
	thread handlerdronedetonate(var_03);
	common_scripts\utility::waittill_any_timeout(10,"detonate");
	self stoploopsound();
	self playsound("drone_warning_beap");
	wait(1.4);
	self radiusdamage(self.origin,256,200,25,self,"MOD_EXPLOSIVE");
	thread maps\mp\_tracking_drone::trackingdroneexplode();
}

//Function Number: 39
respawnhandlerdrone(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	self waittill("death");
	wait(randomintrange(10,15));
	if(isdefined(param_00))
	{
		param_00 thread hordeaddcompaniondrone(1,1,1);
	}
}

//Function Number: 40
handlerdronedetonate(param_00)
{
	self endon("explode");
	param_00 endon("disconnect");
	param_00 endon("death");
	while(distance(self.origin,param_00.origin) > 150)
	{
		wait(0.1);
	}

	self notify("detonate");
}

//Function Number: 41
updaterespawnsplash(param_00)
{
	self waittill("spawned_player");
	if(!param_00)
	{
		thread maps\mp\gametypes\_hud_message::splashnotify("horde_respawn");
	}
}

//Function Number: 42
monitorstuck(param_00)
{
	param_00 endon("disconnect");
	for(;;)
	{
		param_00 waittill("unresolved_collision");
		maps\mp\_movers::unresolved_collision_nearest_node(param_00,0);
		wait(0.5);
	}
}

//Function Number: 43
monitordome(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	if(!isdefined(level.hordedome[0]))
	{
		return;
	}

	for(;;)
	{
		while(!param_00 maps\mp\_utility::isusingremote())
		{
			wait(0.1);
		}

		foreach(var_02 in level.hordedome)
		{
			var_02 hide();
		}

		foreach(param_00 in level.players)
		{
			if(!param_00 maps\mp\_utility::isusingremote())
			{
				foreach(var_02 in level.hordedome)
				{
					var_02 showtoplayer(param_00);
				}
			}
		}

		while(param_00 maps\mp\_utility::isusingremote())
		{
			wait(0.1);
		}

		foreach(var_02 in level.hordedome)
		{
			var_02 showtoplayer(param_00);
		}
	}
}

//Function Number: 44
monitoronlydrones()
{
	level endon("zombies_start");
	level endon("game_ended");
	for(;;)
	{
		var_00 = 1;
		if(isdefined(level.flying_attack_drones) && level.flying_attack_drones.size > 0 && isdefined(level.currentaliveenemycount) && isdefined(level.numdroneswaitingtospawn) && level.flying_attack_drones.size + level.numdroneswaitingtospawn >= level.currentaliveenemycount)
		{
			foreach(var_02 in level.players)
			{
				if(maps\mp\_utility::isreallyalive(var_02) && !maps\mp\gametypes\_horde_util::isplayerinlaststand(var_02))
				{
					if(var_02.armorypoints > 0)
					{
						var_00 = 0;
						break;
					}

					var_03 = 0;
					var_04 = var_02 getweaponslistprimaries();
					foreach(var_06 in var_04)
					{
						if(var_02 getammocount(var_06) > 0)
						{
							var_03 = 1;
							break;
						}
					}

					if(var_03)
					{
						var_00 = 0;
						break;
					}
				}
			}
		}
		else
		{
			var_00 = 0;
		}

		if(var_00)
		{
			foreach(var_02 in level.players)
			{
				if(maps\mp\_utility::isreallyalive(var_02) && !maps\mp\gametypes\_horde_util::isplayerinlaststand(var_02))
				{
					var_02 thread maps\mp\gametypes\_hud_message::splashnotify("horde_team_restock");
					maps\mp\gametypes\_horde_util::refillammohorde(var_02);
				}
			}
		}

		wait(1);
	}
}

//Function Number: 45
updateoutlines(param_00)
{
	param_00 endon("disconnect");
	if(level.currentroundnumber == 0)
	{
		return;
	}

	if(!isdefined(level.carepackages))
	{
		return;
	}

	foreach(var_02 in level.carepackages)
	{
		if(isdefined(var_02.outlinecolor))
		{
			var_02.friendlymodel hudoutlineenable(var_02.outlinecolor,0);
		}
	}

	wait(0.05);
	if(!isdefined(level.characters))
	{
		return;
	}

	foreach(var_05 in level.characters)
	{
		if(isdefined(var_05.outlinecolor))
		{
			var_05 hudoutlineenable(var_05.outlinecolor,0);
		}
	}

	foreach(var_08 in level.flying_attack_drones)
	{
		if(isdefined(var_08.lasttwoenemies))
		{
			var_08 hudoutlineenable(level.enemyoutlinecolor,0);
			var_08.droneturret hudoutlineenable(level.enemyoutlinecolor,0);
			continue;
		}

		var_08 hudoutlineenable(level.enemyoutlinecolor,1);
		var_08.droneturret hudoutlineenable(level.enemyoutlinecolor,1);
	}

	foreach(var_0B in level.spawnedwarbirds)
	{
		if(isdefined(var_0B.lasttwoenemies))
		{
			var_0B hudoutlineenable(level.enemyoutlinecolor,0);
			var_0B.warbirdturret hudoutlineenable(level.enemyoutlinecolor,0);
			continue;
		}

		var_0B hudoutlineenable(level.enemyoutlinecolor,1);
		var_0B.warbirdturret hudoutlineenable(level.enemyoutlinecolor,1);
	}

	if(isdefined(level.hordearmories))
	{
		foreach(var_0E in level.hordearmories)
		{
			var_0F = "specops_ui_exostore";
			if(var_0E.script_parameters == "specops_ui_equipmentstore")
			{
				var_0F = "specops_ui_weaponstore";
			}

			var_0E.headicon = var_0E maps\mp\_entityheadicons::setheadicon(param_00,var_0F,(0,0,48),4,4,undefined,undefined,0,1,undefined,0);
		}
	}
}

//Function Number: 46
updateobjectiveui(param_00)
{
	if(level.isobjectiveround)
	{
		setomnvar("ui_horde_show_objstatus",1);
		if(level.objdefend)
		{
			param_00 setclientomnvar("ui_horde_count_type","horde_defend");
			setomnvar("ui_horde_objcount_1",level.currentdefendloc.killcount);
			setomnvar("ui_horde_objmax_1",level.horde_defend_killcount);
			return;
		}

		if(level.objcollect || level.objintel)
		{
			var_01 = "horde_collect";
			if(level.objintel)
			{
				var_01 = "horde_intel";
			}

			param_00 setclientomnvar("ui_horde_count_type",var_01);
			setomnvar("ui_horde_objcount_1",level.hordecollected);
			setomnvar("ui_horde_objmax_1",level.horde_collect_count);
			return;
		}

		if(level.objdefuse)
		{
			param_00 setclientomnvar("ui_horde_count_type","horde_defuse");
			setomnvar("ui_horde_objcount_1",level.hordedefused);
			setomnvar("ui_horde_objmax_1",level.horde_defuse_count);
			return;
		}

		if(level.objuplink)
		{
			param_00 setclientomnvar("ui_horde_count_type","horde_uplink");
			setomnvar("ui_horde_objcount_1",level.horde_ball_score);
			setomnvar("ui_horde_objmax_1",level.horde_ball_score_count);
			return;
		}

		return;
	}
}

//Function Number: 47
hordesetcharactermodel(param_00,param_01)
{
	if(getdvarint("horde_set_character_models") == 1 || maps\mp\_utility::getmapname() == "mp_prison_z" && issubstr(param_00,"zombie"))
	{
		self detachall();
		self setmodel(param_00);
		if(isdefined(param_01))
		{
			self.headmodel = param_01;
			self attach(self.headmodel,"",1);
		}
	}
}

//Function Number: 48
ammorefillprimary()
{
	if(self.primaryweapon == "none")
	{
		return;
	}

	for(;;)
	{
		self givemaxammo(self.primaryweapon);
		wait(12);
	}
}

//Function Number: 49
ammorefillsecondary()
{
	if(self.secondaryweapon == "none")
	{
		return;
	}

	for(;;)
	{
		self givemaxammo(self.secondaryweapon);
		wait(8);
	}
}

//Function Number: 50
runhordemode()
{
	level endon("game_ended");
	waituntilmatchstart();
	maps\mp\gametypes\_horde_armory::initarmories();
	thread hordeinitdefuseobjects();
	if(maps\mp\_utility::getmapname() != "mp_prison_z")
	{
		thread hordeinituplinkobjects();
	}

	horderandomizeaimodifiertypes();
	level.turretsettings["mg_turret"].timeout = 120;
	foreach(var_01 in level.players)
	{
		if(var_01.class == "gamemode")
		{
		}

		if(level.players.size < 2)
		{
			var_01.hasselfrevive = 1;
		}
	}

	maps\mp\gametypes\_horde_drones::flying_attack_drone_system_init();
	maps\mp\gametypes\_horde_sentry::hordesentryinit();
	while(level.noonespawnedyet)
	{
		wait(0.05);
	}

	for(;;)
	{
		updatehordesettings();
		shownextroundmessage();
		if(level.currentroundnumber == 3 && level.hordelevelflip == 1 && maps\mp\_utility::getmapname() == "mp_urban")
		{
			level.dynamiceventstartnow = 1;
		}

		runhordeobjective();
		level notify("start_round");
		level.horderoundstats["round_time"] = gettime();
		level childthread monitorroundend();
		level waittill("round_ended");
		while(level.objcollect || level.objdefuse || level.objuplink)
		{
			wait(0.05);
		}

		if(level.currentroundnumber < 25)
		{
			hordeupdateroundstats();
		}

		hordeloadwaveweapons();
		foreach(var_01 in level.players)
		{
			maps\mp\gametypes\_horde_util::awardhorderoundnumber(var_01);
			maps\mp\gametypes\_horde_util::hordeupdatetimestats(var_01);
			maps\mp\gametypes\_horde_util::givegearforwavescompleted(var_01);
			maps\mp\gametypes\_horde_util::givegearformapsplayed(var_01);
		}
	}
}

//Function Number: 51
runhordeobjective()
{
	level.hordeobjectivesuccess = 1;
	if(!isobjectiveround())
	{
		return;
	}

	if(!isdefined(level.hordeobjectiveorder) || level.hordeobjectiveindex >= level.hordeobjectiveorder.size)
	{
		level.hordeobjectiveorder = [1,2,3,4];
		if(maps\mp\_utility::getmapname() != "mp_prison_z")
		{
			level.hordeobjectiveorder = common_scripts\utility::array_add(level.hordeobjectiveorder,5);
		}

		level.hordeobjectiveorder = common_scripts\utility::array_randomize(level.hordeobjectiveorder);
		level.hordeobjectiveindex = 0;
	}

	var_00 = level.hordeobjectiveorder[level.hordeobjectiveindex];
	switch(var_00)
	{
		case 1:
			thread runhordedefend();
			break;

		case 2:
			thread runhordecollect();
			break;

		case 3:
			thread runhordeintel();
			break;

		case 4:
			thread runhordedefuse();
			break;

		case 5:
			thread runhordeuplink();
			break;
	}

	level.hordeobjectiveindex++;
}

//Function Number: 52
isobjectiveround()
{
	var_00 = [3,6,9,13,16,19,22,24];
	if(maps\mp\_utility::getmapname() == "mp_prison_z")
	{
		var_00 = [3,6];
	}

	foreach(var_02 in var_00)
	{
		if(level.currentroundnumber == var_02)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 53
hordeobjectivesuccess()
{
	foreach(var_01 in level.players)
	{
		var_01 thread maps\mp\gametypes\_hud_message::splashnotify("horde_obj_complete");
		thread maps\mp\gametypes\_horde_armory::addarmorypoints(var_01,"objective_complete");
		maps\mp\gametypes\_horde_util::awardhordeobjectivescompleted(var_01);
	}

	maps\mp\gametypes\_horde_util::playsoundtoallplayers("mp_ctf_obj_cap_ally");
	level.hordeobjectivesuccess = 1;
	level.isobjectiveround = 0;
}

//Function Number: 54
hordeinituplinkobjects()
{
	maps\mp\gametypes\horde_ball::setup();
}

//Function Number: 55
runhordeuplink()
{
	level endon("game_ended");
	level endon("uplink_completed");
	setomnvar("ui_horde_show_objstatus",1);
	level.hordeobjectivesuccess = 0;
	level.isobjectiveround = 1;
	level.objuplink = 1;
	foreach(var_01 in level.players)
	{
		var_01 thread maps\mp\gametypes\_hud_message::splashnotify("horde_obj_uplink");
		var_01 maps\mp\_utility::leaderdialogonplayer("coop_gdn_satellite_start","horde",1);
		var_01 setclientomnvar("ui_horde_count_type","horde_uplink");
	}

	level.horde_ball_score_count = int(min(10,3 + 1 * maps\mp\gametypes\_horde_util::getnumplayers() - 1));
	setomnvar("ui_horde_objcount_1",0);
	setomnvar("ui_horde_objmax_1",level.horde_ball_score_count);
	level thread maps\mp\gametypes\horde_ball::run_horde_ball();
	thread hordesuccessmonitor();
	thread hordeuplinkcancel();
	var_03 = level.hordelevelflip - 1 * 25 + level.currentroundnumber;
	var_04 = 120 + floor(var_03 / 12) * 5;
	if(getdvarint("scr_hordenoobjtimers") == 0)
	{
		sethudtimer("uplink_time",var_04);
	}

	if(getdvarint("scr_hordenoobjtimers") > 0)
	{
		level waittill("round_ended");
	}
	else
	{
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_04);
	}

	level notify("uplink_completed");
}

//Function Number: 56
hordesuccessmonitor()
{
	level endon("uplink_completed");
	var_00 = level.horde_ball_score;
	for(;;)
	{
		if(level.horde_ball_score != var_00)
		{
			setomnvar("ui_horde_objcount_1",level.horde_ball_score);
			var_00 = level.horde_ball_score;
		}

		if(level.horde_ball_score >= level.horde_ball_score_count)
		{
			thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_objective_complete","horde",1,1);
			hordeobjectivesuccess();
			level notify("uplink_completed");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 57
hordeuplinkcancel()
{
	level endon("game_ended");
	level waittill("uplink_completed");
	hordecheckobjectivefailure();
	clearhudtimer();
	level thread maps\mp\gametypes\horde_ball::horde_ball_cleanup();
	level.isobjectiveround = 0;
	level.objuplink = 0;
	wait(3);
	setomnvar("ui_horde_show_objstatus",0);
	setomnvar("ui_horde_objcount_1",0);
	setomnvar("ui_horde_objmax_1",0);
}

//Function Number: 58
runhordedefend()
{
	level endon("game_ended");
	setomnvar("ui_horde_show_objstatus",1);
	level.hordeobjectivesuccess = 0;
	level.isobjectiveround = 1;
	level.objdefend = 1;
	if(level.currentroundnumber < 10)
	{
		level.horde_defend_killcount = 10;
	}
	else if(level.currentroundnumber < 20)
	{
		level.horde_defend_killcount = 12;
	}
	else
	{
		level.horde_defend_killcount = 15;
	}

	foreach(var_01 in level.players)
	{
		var_01 thread maps\mp\gametypes\_hud_message::splashnotify("horde_obj_defend");
		var_01 maps\mp\_utility::leaderdialogonplayer("coop_gdn_hardpoint","horde",1);
		var_01 setclientomnvar("ui_horde_count_type","horde_defend");
	}

	if(!isdefined(level.hordedefendlocs) || level.hordedefendlocs.size < 1)
	{
		level.hordedefendlocs = common_scripts\utility::getstructarray("horde_defend","targetname");
		level.hordedefendlocs = common_scripts\utility::array_randomize(level.hordedefendlocs);
	}

	level.currentdefendloc = common_scripts\utility::random(level.hordedefendlocs);
	common_scripts\utility::array_remove(level.hordedefendlocs,level.currentdefendloc);
	var_03 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_03,"active",level.currentdefendloc.origin,"waypoint_defend");
	level.currentdefendloc.index = var_03;
	level.currentdefendloc.killcount = 0;
	foreach(var_01 in level.players)
	{
		if(var_01.sessionstate == "spectator")
		{
			continue;
		}

		level.currentdefendloc.headicon = level.currentdefendloc maps\mp\_entityheadicons::setheadicon(var_01,"waypoint_defend",(0,0,0),4,4,undefined,undefined,undefined,1,undefined,0);
		level thread hordedefendenemyoutline(var_01);
	}

	setomnvar("ui_horde_objcount_1",0);
	setomnvar("ui_horde_objmax_1",level.horde_defend_killcount);
	thread hordedefendcancel();
	level common_scripts\utility::waittill_any("defend_complete","defend_cancel");
	level.isobjectiveround = 0;
	level.objdefend = 0;
	setomnvar("ui_horde_show_objstatus",0);
	foreach(var_01 in level.players)
	{
		level.currentdefendloc maps\mp\_entityheadicons::setheadicon("none","",(0,0,0));
	}

	if(isdefined(level.currentdefendloc.headicon))
	{
		level.currentdefendloc.headicon destroy();
	}

	maps\mp\_utility::_objective_delete(level.currentdefendloc.index);
	setomnvar("ui_horde_objcount_1",0);
	setomnvar("ui_horde_objmax_1",0);
}

//Function Number: 59
hordedefendcancel()
{
	level endon("game_ended");
	level endon("defend_complete");
	level waittill("round_ended");
	level notify("defend_cancel");
	hordecheckobjectivefailure();
}

//Function Number: 60
hordedefendenemyoutline(param_00,param_01)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	if(!isdefined(param_01))
	{
		param_01 = level.currentdefendloc;
	}

	while(level.objdefend)
	{
		foreach(var_03 in level.agentarray)
		{
			if(common_scripts\utility::array_contains(param_00.markedformech,var_03))
			{
				continue;
			}

			if(distance(param_00.origin,param_01.origin) < 800)
			{
				if(level.currentaliveenemycount < 3)
				{
					var_03 hudoutlineenableforclient(param_00,4,0);
				}
				else
				{
					var_03 hudoutlineenableforclient(param_00,4,1);
				}

				continue;
			}

			if(level.currentaliveenemycount < 3)
			{
				var_03 hudoutlineenableforclient(param_00,level.enemyoutlinecolor,0);
			}
			else
			{
				var_03 hudoutlinedisableforclient(param_00);
			}

			var_03.outlinecolor = level.enemyoutlinecolor;
		}

		wait(0.05);
	}

	foreach(var_03 in level.agentarray)
	{
		if(level.currentaliveenemycount < 3)
		{
			var_03 hudoutlineenableforclient(param_00,level.enemyoutlinecolor,0);
			continue;
		}

		var_03 hudoutlinedisableforclient(param_00);
	}
}

//Function Number: 61
hordeinitdefuseobjects()
{
	level.hordebombs = getentarray("horde_defuse_bomb","targetname");
	level.hordedefuseobjects = [];
	for(var_00 = 0;var_00 < level.hordebombs.size;var_00++)
	{
		level.hordebombs[var_00] show();
		level.hordebombs[var_00] initdefuseobject();
		level.hordebombs[var_00] makeusable();
		var_01 = &"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES";
		level.hordebombs[var_00] sethintstring(var_01);
	}
}

//Function Number: 62
initdefuseobject()
{
	var_00[0] = self;
	var_01 = getent(self.target,"targetname");
	var_01 makeunusable();
	var_02 = maps\mp\gametypes\_gameobjects::createuseobject("allies",var_01,var_00,(0,0,32),1);
	var_02 maps\mp\gametypes\_gameobjects::allowuse("friendly");
	var_02 maps\mp\gametypes\_gameobjects::setusetime(5);
	var_02 maps\mp\gametypes\_gameobjects::setusetext(&"MP_DEFUSING_EXPLOSIVE");
	var_02 maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	var_02.onbeginuse = ::hordedefuseonbeginuse;
	var_02.onenduse = ::hordedefuseonenduse;
	var_02.onuse = ::hordeonusedefuseobject;
	var_02.useweapon = "search_dstry_bomb_defuse_mp";
	var_02.visuals[0] hide();
	level.hordedefuseobjects[level.hordedefuseobjects.size] = var_02;
	self.trigger = var_01;
}

//Function Number: 63
defusethink()
{
	level endon("game_ended");
	level endon("defuse_completed");
	for(;;)
	{
		self waittill("trigger",var_00);
		self.trigger notify("trigger",var_00);
	}
}

//Function Number: 64
runhordedefuse()
{
	level endon("game_ended");
	level endon("defuse_completed");
	level.hordedefused = 0;
	level.isobjectiveround = 1;
	level.hordeobjectivesuccess = 0;
	level.objdefuse = 1;
	setomnvar("ui_horde_show_objstatus",1);
	setomnvar("ui_horde_objcount_1",0);
	setomnvar("ui_horde_objmax_1",level.horde_defuse_count);
	foreach(var_01 in level.players)
	{
		var_01 setclientomnvar("ui_horde_count_type","horde_defuse");
		var_01 thread maps\mp\gametypes\_hud_message::splashnotify("horde_obj_defuse");
		var_01 maps\mp\_utility::leaderdialogonplayer("coop_gdn_empbombsshowingonsensors","horde",1);
	}

	level.hordedefuselocs = getentarray("horde_defuse","targetname");
	level.hordedefuselocs = common_scripts\utility::array_randomize(level.hordedefuselocs);
	if(level.hordedefuselocs.size < 3)
	{
		level.hordedefuselocs = level.hordecollectlocs;
	}

	level.hordedefuselocs = common_scripts\utility::array_randomize(level.hordedefuselocs);
	hordemovebaddefuselocations();
	for(var_03 = 0;var_03 < level.hordedefuseobjects.size;var_03++)
	{
		var_04 = maps\mp\gametypes\_gameobjects::getnextobjid();
		level.hordedefuseobjects[var_03].objectiveindex = var_04;
		objective_add(var_04,"active",level.hordedefuselocs[var_03].origin,"objective_sm");
		level.hordedefuseobjects[var_03].curorigin = level.hordedefuselocs[var_03].origin;
		level.hordedefuseobjects[var_03].visuals[0].curorigin = level.hordedefuselocs[var_03].origin;
		level.hordedefuseobjects[var_03].trigger.origin = level.hordedefuselocs[var_03].origin;
		level.hordedefuseobjects[var_03].origin = level.hordedefuselocs[var_03].origin;
		level.hordedefuseobjects[var_03].visuals[0].origin = level.hordedefuselocs[var_03].origin;
		level.hordedefuseobjects[var_03].visuals[0].angles = level.hordedefuselocs[var_03].angles;
		level.hordedefuseobjects[var_03].visuals[0] hudoutlineenable(4,0);
		level.hordedefuseobjects[var_03].visuals[0] show();
		level.hordedefuseobjects[var_03].visuals[0] makeusable();
		level.hordedefuseobjects[var_03].visuals[0] thread defusethink();
	}

	if(getdvarint("scr_hordenoobjtimers") == 0)
	{
		sethudtimer("defuse_time",120);
	}

	thread hordedefusecancel();
	if(getdvarint("scr_hordenoobjtimers") > 0)
	{
		level waittill("round_ended");
	}
	else
	{
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(120);
	}

	level notify("defuse_completed");
}

//Function Number: 65
hordemovebaddefuselocations()
{
	if(maps\mp\_utility::getmapname() == "mp_torqued")
	{
		foreach(var_01 in level.hordedefuselocs)
		{
			if(var_01.origin == (1024.7,-285.7,883))
			{
				var_01.origin = (1209.58,-161.35,862);
				var_01.angles = (0,0,0);
			}
		}
	}
}

//Function Number: 66
hordedefuseonbeginuse(param_00)
{
	param_00 maps\mp\_utility::notify_enemy_bots_bomb_used("defuse");
	param_00 playsound("mp_bomb_defuse");
	param_00.isdefusing = 1;
	self.visuals[0] makeunusable();
	self.visuals[0] hide();
}

//Function Number: 67
hordedefuseonenduse(param_00,param_01,param_02)
{
	self.visuals[0] show();
	self.visuals[0] makeusable();
	if(!isdefined(param_01))
	{
		return;
	}

	if(isalive(param_01))
	{
		param_01.isdefusing = 0;
		param_01.isplanting = 0;
	}
}

//Function Number: 68
hordeplayerdefusing()
{
	level endon("game_ended");
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.isdefusing) && var_01.isdefusing)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 69
hordeonusedefuseobject(param_00)
{
	param_00 thread maps\mp\gametypes\_rank::xppointspopup("horde_defuse",700);
	level thread maps\mp\gametypes\_horde_util::hordeupdatescore(param_00,700);
	level.currentpointtotal = level.currentpointtotal + 700;
	level notify("pointsEarned");
	maps\mp\_utility::_objective_delete(self.objectiveindex);
	self.objectiveindex = undefined;
	self.visuals[0] hide();
	self.visuals[0] makeunusable();
	level.hordedefused++;
	setomnvar("ui_horde_objcount_1",level.hordedefused);
	if(level.hordedefused > 2)
	{
		hordeobjectivesuccess();
		level notify("defuse_completed");
		return;
	}

	level thread maps\mp\gametypes\_horde_util::showteamsplashhorde("horde_defused");
}

//Function Number: 70
hordedefusecancel()
{
	level endon("game_ended");
	level waittill("defuse_completed");
	clearhudtimer();
	while(hordeplayerdefusing())
	{
		wait(0.05);
	}

	hordecheckobjectivefailure();
	foreach(var_01 in level.hordedefuseobjects)
	{
		if(isdefined(var_01.objectiveindex))
		{
			maps\mp\_utility::_objective_delete(var_01.objectiveindex);
		}

		var_01.visuals[0] hide();
		var_01.visuals[0] makeunusable();
		var_01.objectiveindex = undefined;
	}

	level.objdefuse = 0;
	wait(3);
	setomnvar("ui_horde_show_objstatus",0);
}

//Function Number: 71
runhordecollect()
{
	level endon("game_ended");
	level endon("collect_completed");
	level.horde_collect_count = int(min(20,10 + 5 * maps\mp\gametypes\_horde_util::getnumplayers() - 1));
	level.hordecollected = 0;
	level.collectobjects = [];
	level.hordeobjectivesuccess = 0;
	level.isobjectiveround = 1;
	setomnvar("ui_horde_show_objstatus",1);
	foreach(var_01 in level.players)
	{
		var_01 setclientomnvar("ui_horde_count_type","horde_collect");
		var_01 thread maps\mp\gametypes\_hud_message::splashnotify("horde_obj_collect");
		var_01 maps\mp\_utility::leaderdialogonplayer("coop_gdn_dogtagsareinthefield","horde",1);
	}

	level.hordecollectlocs = common_scripts\utility::getstructarray("horde_collect","targetname");
	level.hordecollectlocs = common_scripts\utility::array_randomize(level.hordecollectlocs);
	for(var_03 = 0;var_03 < level.horde_collect_count;var_03++)
	{
		var_04 = spawnpickup(level.hordecollectlocs[var_03].origin,level.collectpickupmodel,level.collectpickupfunc,112,0);
		var_05 = maps\mp\gametypes\_gameobjects::getnextobjid();
		var_04.objectiveindex = var_05;
		objective_add(var_05,"active",level.hordecollectlocs[var_03].origin,"objective_sm");
		level.collectobjects[level.collectobjects.size] = var_04;
	}

	level.objcollect = 1;
	setomnvar("ui_horde_objcount_1",0);
	setomnvar("ui_horde_objmax_1",level.horde_collect_count);
	if(getdvarint("scr_hordenoobjtimers") == 0)
	{
		sethudtimer("collect_time",120);
	}

	thread hordecollectcancel();
	if(getdvarint("scr_hordenoobjtimers") > 0)
	{
		level waittill("round_ended");
	}
	else
	{
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(120);
	}

	level notify("collect_completed");
}

//Function Number: 72
hordecollectcancel()
{
	level endon("game_ended");
	level waittill("collect_completed");
	hordecheckobjectivefailure();
	clearhudtimer();
	foreach(var_01 in level.collectobjects)
	{
		if(isdefined(var_01))
		{
			maps\mp\_utility::_objective_delete(var_01.objectiveindex);
		}
	}

	level.objcollect = 0;
	wait(3);
	setomnvar("ui_horde_show_objstatus",0);
}

//Function Number: 73
runhordeintel()
{
	level endon("game_ended");
	level.objintel = 1;
	level.killssinceinteldrop = 0;
	level.hordecollected = 0;
	level.collectobjects = [];
	if(level.currentroundnumber < 10)
	{
		level.horde_collect_count = 3;
	}
	else if(level.currentroundnumber < 20)
	{
		level.horde_collect_count = 4;
	}
	else
	{
		level.horde_collect_count = 5;
	}

	level.hordeobjectivesuccess = 0;
	level.isobjectiveround = 1;
	setomnvar("ui_horde_show_objstatus",1);
	foreach(var_01 in level.players)
	{
		var_01 thread maps\mp\gametypes\_hud_message::splashnotify("horde_obj_intel");
		var_01 setclientomnvar("ui_horde_count_type","horde_intel");
		var_01 maps\mp\_utility::leaderdialogonplayer("coop_gdn_hostilesincomingsearchdowned","horde",1);
	}

	setomnvar("ui_horde_objcount_1",0);
	setomnvar("ui_horde_objmax_1",level.horde_collect_count);
	thread hordeintelcancel();
	level common_scripts\utility::waittill_any("collect_completed","intel_cancel");
	hordecheckobjectivefailure();
	level.objintel = 0;
	foreach(var_04 in level.collectobjects)
	{
		if(isdefined(var_04))
		{
			maps\mp\_utility::_objective_delete(var_04.objectiveindex);
			var_04 delete();
		}
	}

	wait(3);
	setomnvar("ui_horde_show_objstatus",0);
}

//Function Number: 74
hordeintelcancel()
{
	level endon("game_ended");
	level endon("collect_completed");
	level waittill("round_ended");
	level notify("intel_cancel");
}

//Function Number: 75
checkdefendkill(param_00,param_01)
{
	if(isdefined(param_01) && isplayer(param_01) || isplayer(param_01.owner) && level.currentdefendloc.killcount < level.horde_defend_killcount)
	{
		if(param_01 maps\mp\_utility::isusingremote() && param_01.usingremote == "mg_turret" && isdefined(param_01.turret))
		{
			param_01 = param_01.turret;
		}

		if(isdefined(param_01.tank) && isdefined(param_01.tank.isaerialassaultdrone) && param_01.tank.isaerialassaultdrone && isdefined(param_01.owner))
		{
			param_01 = param_01.owner;
		}

		if(distancesquared(param_01.origin,level.currentdefendloc.origin) <= 640000)
		{
			level.currentdefendloc.killcount++;
			level.currentpointtotal = level.currentpointtotal + 150;
			level notify("pointsEarned");
			setomnvar("ui_horde_objcount_1",level.currentdefendloc.killcount);
			if(isdefined(param_01.owner))
			{
				param_01.owner thread maps\mp\gametypes\_rank::xppointspopup("horde_defend",150);
				level thread maps\mp\gametypes\_horde_util::hordeupdatescore(param_01.owner,150);
				param_01.owner setclientomnvar("ui_horde_count",1);
			}
			else if(isdefined(param_01))
			{
				param_01 setclientomnvar("ui_horde_count",1);
				param_01 thread maps\mp\gametypes\_rank::xppointspopup("horde_defend",150);
				level thread maps\mp\gametypes\_horde_util::hordeupdatescore(param_01,150);
			}

			if(level.currentdefendloc.killcount >= level.horde_defend_killcount)
			{
				thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_locationdefended","horde",1);
				thread hordeobjectivesuccess();
				level notify("defend_complete");
				level.currentdefendloc notify("defended");
				return;
			}
		}
	}
}

//Function Number: 76
hordecheckobjectivefailure()
{
	level.objectivefailureevents = [];
	level.objectivefailureevents[0] = "Emp";
	level.objectivefailureevents[1] = "Smoke";
	level.objectivefailureevents[2] = "Sentry";
	level.objectivefailureevents[3] = "Pistols";
	level.objectivefailureevents[4] = "NanoSwarm";
	if(!level.hordeobjectivesuccess)
	{
		maps\mp\gametypes\_horde_util::playsoundtoallplayers("mp_ctf_obj_cap_enemy");
		for(;;)
		{
			var_00 = common_scripts\utility::random(level.objectivefailureevents);
			if(var_00 != level.hordepreviousfailureevent)
			{
				level.hordepreviousfailureevent = var_00;
				break;
			}
		}

		level thread maps\mp\gametypes\_horde_util::showteamsplashhorde("horde_obj_failed_" + var_00);
		level.isobjectiveround = 0;
		switch(var_00)
		{
			case "Emp":
				thread failureeventemp();
				break;

			case "Smoke":
				thread failureeventsmoke();
				break;

			case "NanoSwarm":
				thread failureeventmissileburst(1);
				break;

			case "Sentry":
				thread failureeventsentry();
				break;

			case "Pistols":
				thread failureeventpistolsonly();
				break;
		}
	}
}

//Function Number: 77
failureeventemp()
{
	foreach(var_01 in level.players)
	{
		var_02 = var_01 getclientomnvar("ui_horde_armory_type");
		if(var_02 != "killstreak_armory" && var_02 != "perk_armory")
		{
			maps\mp\gametypes\_horde_armory::hordecleanuparmory(var_01);
		}
	}

	thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_systemhack","horde",1,1);
	thread maps\mp\gametypes\_horde_armory::hordedisablearmories();
	level.players[0] maps\mp\killstreaks\_emp::emp_jamteam(level.playerteam,["emp_exo_kill","emp_streak_kill","emp_equipment_kill"]);
}

//Function Number: 78
failureeventsmoke()
{
	level endon("game_ended");
	thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_tangosarepoppingsmoke","horde",1,1);
	var_00 = gettime() + int(60000);
	while(gettime() < var_00)
	{
		var_01 = common_scripts\utility::random(level.players);
		var_01 thread failureeventsmokethink();
		wait(randomfloatrange(10,12));
	}
}

//Function Number: 79
failureeventsmokethink()
{
	level endon("game_ended");
	self endon("death");
	for(var_00 = 0;var_00 != 3;var_00++)
	{
		wait(randomfloatrange(0.25,0.85));
		var_01 = _getrandomorginfrontofplayer();
		var_02 = getnodesinradiussorted(var_01,512,32,256,"path");
		var_03 = common_scripts\utility::random(var_02);
		if(!isdefined(var_03))
		{
			continue;
		}

		magicgrenademanual("smoke_grenade_mp",var_03.origin,(0,0,0),1);
	}
}

//Function Number: 80
_getrandomorginfrontofplayer()
{
	var_00 = anglestoforward(self.angles);
	var_01 = anglestoright(self.angles);
	var_02 = self.origin + var_00 * randomfloatrange(128,256);
	var_03 = var_02 + var_01 * randomfloatrange(64,128);
	if(common_scripts\utility::cointoss())
	{
		var_03 = var_02 + var_01 * 128;
	}
	else
	{
		var_03 = var_02 - var_01 * 128;
	}

	return var_03;
}

//Function Number: 81
failureeventmissileburst(param_00)
{
	level endon("game_ended");
	var_01 = getentarray("remoteMissileSpawn","targetname");
	thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_nanostrike","horde",1,1);
	if(param_00)
	{
		var_02 = 3;
		var_03 = 1;
		var_04 = 2;
		var_05 = 5;
		var_06 = 10;
		var_07 = 15;
	}
	else
	{
		var_02 = 3;
		var_03 = 5;
		var_04 = 0.25;
		var_05 = 1.25;
		var_06 = 2;
		var_07 = 5;
	}

	var_08 = gettime() + int(60000);
	while(gettime() < var_08)
	{
		wait(randomfloatrange(3,6));
		foreach(var_0A in level.players)
		{
			if(isdefined(var_0A.laststand) && var_0A.laststand == 1)
			{
				continue;
			}

			var_0A failureeventmissileburstthink(var_01,param_00,var_02,var_03,var_04,var_05,var_06,var_07);
		}
	}
}

//Function Number: 82
failureeventmissileburstthink(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_08 = "warbird_missile_mp";
	for(var_09 = 0;var_09 < param_02;var_09++)
	{
		for(var_0A = 0;var_0A < param_03;var_0A++)
		{
			var_0B = maps\mp\killstreaks\_missile_strike::getbestspawnpoint(param_00);
			var_0C = _getrandomorginfrontofplayer();
			var_0D = magicbullet(var_08,var_0B.origin,var_0C);
			if(param_01)
			{
				var_0D thread hordespawnnanoswarm();
			}

			var_0D missile_settargetpos(var_0C);
			var_0D missile_setflightmodedirect();
			var_0D setmissileminimapvisible(1);
			wait(randomfloatrange(param_04,param_05));
		}

		wait(randomfloatrange(param_06,param_07));
	}
}

//Function Number: 83
hordespawnnanoswarm()
{
	self endon("cancel_swarm");
	common_scripts\utility::waittill_any("death","startSwarm");
	var_00 = spawn("script_model",self.origin);
	var_00 setmodel("tag_origin");
	var_01 = spawn("script_model",var_00.origin);
	var_00.killcament = var_01;
	var_02 = level._missile_strike_setting["Particle_FX"].gas;
	wait 0.05;
	foreach(var_04 in level.players)
	{
		playfxontagforclients(var_02,var_00,"tag_origin",var_04);
	}

	badplace_cylinder("gas_zone" + var_00 getentitynumber(),20,var_00.origin,200,128,level.enemyteam);
	var_00 thread failureeventmissileburstgasdamage();
	wait(20);
	var_00.killcament delete();
	var_00 delete();
}

//Function Number: 84
failureeventmissileburstgasdamage()
{
	self endon("death");
	var_00 = 200;
	var_01 = 12;
	for(;;)
	{
		self.killcament radiusdamage(self.origin,var_00,var_01,var_01,undefined,"MOD_TRIGGER_HURT","killstreak_strike_missile_gas_mp",0);
		wait(1);
	}
}

//Function Number: 85
failureeventsentry()
{
	level endon("game_ended");
	thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_sentryguns","horde",1,1);
	var_00 = ["remote_energy_turret_mp","sentry_minigun_mp"];
	var_01 = common_scripts\utility::random(var_00);
	var_02 = clamp(level.hordesentryspawns.size / 2,1,5);
	level.hordesentryspawns = common_scripts\utility::array_randomize(level.hordesentryspawns);
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = maps\mp\gametypes\_horde_sentry::hordespawnenemyturret(var_01,level.hordesentryspawns[var_03]);
		wait(2.5);
	}
}

//Function Number: 86
failureeventpistolsonly()
{
	level endon("game_ended");
	var_00 = [];
	var_01 = 45;
	level.hordeweaponsjammed = 1;
	setomnvar("ui_horde_allow_classchange",0);
	level thread failureeventpistolsreenabled(var_01);
	thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_weaponsoffline","horde",1,1);
	foreach(var_03 in level.players)
	{
		while(isdefined(var_03.ball_carried))
		{
			wait(0.05);
		}

		var_03 thread failureeventpistolsonlythink(var_01);
		var_03 thread failureeventpistolsonlyjammedbar(var_01,var_00);
		if(var_03 maps\mp\_utility::isusingremote())
		{
			var_03 thread failurepistolshandleremotereturn();
		}
	}
}

//Function Number: 87
failureeventpistolsonlyjammedbar(param_00,param_01)
{
	self endon("disconnect");
	self endon("death");
	var_02 = maps\mp\gametypes\_hud_util::createprimaryprogressbar(0,190);
	var_03 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0,185);
	var_03 settext(&"HORDE_WEAPONS_JAMMED");
	var_02 thread failureeventupdateweaponjammedbar(param_00,param_01);
	thread failureeventpistolonlyjammedbarhide(var_02,var_03);
	var_02 waittill("Clear_JammedBar_UI");
	var_02 maps\mp\gametypes\_hud_util::destroyelem();
	var_03 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 88
failureeventupdateweaponjammedbar(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	var_02 = 0;
	while(var_02 != param_00)
	{
		var_02++;
		maps\mp\gametypes\_hud_util::updatebar(var_02 / param_00);
		wait(1);
	}

	self notify("Clear_JammedBar_UI");
}

//Function Number: 89
failureeventpistolonlyjammedbarhide(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	param_00 endon("Clear_JammedBar_UI");
	var_02 = [param_00,param_01];
	for(;;)
	{
		if(!isdefined(self.inlaststand))
		{
			wait(0.05);
			continue;
		}

		if(isdefined(self.inlaststand) && self.inlaststand == 0)
		{
			foreach(var_04 in var_02)
			{
				var_04 maps\mp\gametypes\_hud_util::showelem();
			}
		}

		if(isdefined(self.inlaststand) && self.inlaststand == 1)
		{
			foreach(var_04 in var_02)
			{
				var_04 maps\mp\gametypes\_hud_util::hideelem();
			}
		}

		wait(0.05);
	}
}

//Function Number: 90
failureeventpistolsonlythink(param_00)
{
	self endon("death");
	self endon("disconnect");
	var_01 = self getclientomnvar("ui_horde_player_class");
	var_02 = self getcurrentprimaryweapon();
	if(maps\mp\_utility::isusingremote())
	{
		var_02 = self.hordeclassweapons[var_01]["primary"];
	}

	if(var_02 == "iw5_carrydrone_mp")
	{
		var_03 = self getweaponslistprimaries();
		var_02 = var_03[0];
	}

	maps\mp\gametypes\_weapons::saveweapon("jam",var_02,maps\mp\gametypes\_horde_laststand::hordelaststandweapon());
	self.weaponjamcompletiontime = gettime() + param_00 * 1000;
	handlejammedpistols(var_02);
	maps\mp\gametypes\_weapons::restoreweapon("jam");
}

//Function Number: 91
handlejammedpistols(param_00)
{
	self notify("horde_handle_jammed_pistols");
	self endon("horde_handle_jammed_pistols");
	if(isdefined(self.isjuggernaut) && self.isjuggernaut)
	{
		return;
	}

	var_01 = maps\mp\gametypes\_horde_laststand::hordelaststandweapon();
	if(!maps\mp\gametypes\_horde_laststand::haslaststandweapon(var_01))
	{
		self giveweapon(var_01);
	}

	if(!isdefined(self.underwater) && !maps\mp\gametypes\_horde_util::isplayerinlaststand(self))
	{
		self switchtoweaponimmediate(var_01);
	}

	self disableweaponswitch();
	var_02 = self setweaponammostock(param_00);
	var_03 = weaponclipsize(param_00);
	if(var_02 < var_03)
	{
		self setweaponammostock(param_00,var_03);
	}

	var_04 = self.weaponjamcompletiontime - gettime() * 0.001;
	wait(var_04);
	if(!isdefined(self.underwater) && !maps\mp\gametypes\_horde_util::isplayerinlaststand(self))
	{
		self enableweaponswitch();
	}

	if(!self.hadlaststandweapon)
	{
		self takeweapon(var_01);
	}
}

//Function Number: 92
failureeventpistolsreenabled(param_00)
{
	level endon("game_ended");
	wait(param_00);
	setomnvar("ui_horde_allow_classchange",1);
	level thread maps\mp\gametypes\_horde_util::showteamsplashhorde("horde_weapons_enabled");
	maps\mp\gametypes\_horde_util::playsoundtoallplayers("mp_ctf_obj_cap_ally");
	wait(0.5);
	level.hordeweaponsjammed = 0;
}

//Function Number: 93
failurepistolshandleremotereturn()
{
	self endon("disconnect");
	level endon("game_ended");
	self waittill("stopped_using_remote");
	if(isdefined(level.hordeweaponsjammed) && level.hordeweaponsjammed)
	{
		self switchtoweaponimmediate("iw5_titan45_mp_xmags");
	}
}

//Function Number: 94
closeclassmenu()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	if(!isagent(self))
	{
		thread maps\mp\gametypes\_playerlogic::setuioptionsmenu(-1);
	}
}

//Function Number: 95
monitorroundend()
{
	level.enemiesleft = level.maxenemycount;
	for(;;)
	{
		level waittill("enemy_death");
		if(level.currentenemycount == level.maxenemycount && level.currentaliveenemycount == 0)
		{
			notifyroundover();
			foreach(var_01 in level.players)
			{
				maps\mp\gametypes\_horde_armory::addarmorypoints(var_01,"round");
			}

			level.enemiesleft = 0;
			setomnvar("ui_horde_enemies_left",level.enemiesleft);
			return;
		}
	}
}

//Function Number: 96
notifyroundover()
{
	level endon("game_ended");
	if(getdvarint("scr_hordenoobjtimers") < 1)
	{
		while(level.objcollect || level.objdefuse || level.objuplink)
		{
			wait(0.05);
		}
	}

	level thread respawneliminatedplayers();
	var_00 = "horde_wave_complete";
	if(level.currentroundnumber == level.maxrounds)
	{
		var_00 = "horde_map_flip";
	}

	waittillframeend;
	if(level.hordeobjectivesuccess)
	{
		if(level.currentroundnumber == 10 && maps\mp\_utility::getmapname() == "mp_prison_z")
		{
			level notify("zombies_start");
			setnojiptime(1);
			thread maps\mp\gametypes\_horde_zombies::runhordezombies();
		}
		else
		{
			level thread maps\mp\gametypes\_horde_util::showteamsplashhorde(var_00);
			thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_roundover","horde",1,1);
		}
	}

	setdvar("bg_compassShowEnemies",0);
	level.hordenumroundscompleted++;
	if(level.currentroundnumber == level.maxrounds)
	{
		wait(10);
	}

	level notify("round_ended");
}

//Function Number: 97
respawneliminatedplayers()
{
	level endon("game_ended");
	foreach(var_01 in level.players)
	{
		if(!maps\mp\gametypes\_horde_util::isonhumanteamorspectator(var_01))
		{
			continue;
		}

		if(!isdefined(self.goliathdeath))
		{
			level thread respawnplayer(var_01);
		}
	}
}

//Function Number: 98
hordecustomgiveloadout(param_00)
{
	if(isdefined(self.isspectator))
	{
		self.loadout = undefined;
		return;
	}

	maps\mp\gametypes\_class::applyloadout();
}

//Function Number: 99
setupplayerafterrevivefromspectator()
{
	self notify("revive");
	var_00 = self getclientomnvar("ui_horde_player_class");
	var_01 = level.classsettings[var_00]["speed"];
	self.laststand = undefined;
	self.inlaststand = 0;
	self.headicon = "";
	self.movespeedscaler = var_01;
	self.ignoreme = 0;
	self.beingrevived = 0;
	self.saveweapons = [];
	self.firstsaveweapon = "none";
	if(maps\mp\_utility::_hasperk("specialty_lightweight"))
	{
		self.movespeedscaler = maps\mp\_utility::lightweightscalar();
	}

	self hudoutlinedisable();
	self laststandrevive();
	self setstance("stand");
	thread maps\mp\gametypes\_horde_util::hordeallowallboost(1,"laststand");
	self allowmelee(1);
	self enableweapons();
	common_scripts\utility::_enableusability();
	self enableoffhandweapons();
	maps\mp\gametypes\_weapons::updatemovespeedscale();
	maps\mp\_utility::clearlowermessage("last_stand");
	maps\mp\_utility::giveperk("specialty_pistoldeath",0);
	maps\mp\_utility::giveperk("specialty_horde_dualprimary",1,1);
	if(maps\mp\killstreaks\_emp::issystemhacked() && !maps\mp\_utility::_hasperk("specialty_empimmune"))
	{
		maps\mp\killstreaks\_emp::applyemp();
	}

	maps\mp\_utility::_setactionslot(1,"");
	maps\mp\_utility::_setactionslot(3,"altMode");
	maps\mp\_utility::_setactionslot(4,"");
	if(!level.console)
	{
		maps\mp\_utility::_setactionslot(5,"");
		maps\mp\_utility::_setactionslot(6,"");
		maps\mp\_utility::_setactionslot(7,"");
		maps\mp\_utility::_setactionslot(8,"");
	}
}

//Function Number: 100
resetwateronrevivefromspectator()
{
	self notify("above_water");
	self.wasunderwater = 0;
	wait(0.1);
}

//Function Number: 101
respawnplayer(param_00)
{
	level endon("game_ended");
	if(isdefined(param_00.isspectator))
	{
		param_00.pers["lives"] = 1;
		param_00.pers["class"] = "gamemode";
		param_00.class = param_00.pers["class"];
		param_00.addtoteam = level.playerteam;
		param_00.alreadyaddedtoalivecount = 1;
		param_00 maps\mp\killstreaks\_killstreaks::clearkillstreaks(1);
		param_00 notify("horde_end_spectate");
		var_01 = param_00 getclientomnvar("ui_horde_player_class");
		if(var_01 == "none")
		{
			var_01 = "light";
			param_00 setclientomnvar("ui_horde_player_class",var_01);
			param_00.classmaxhealth = param_00.classsettings[var_01]["classhealth"];
			var_02 = param_00.hordeclassweapons[var_01]["secondary"];
			param_00.primaryweaponsammo[var_02]["ammoclip"] = 15;
			param_00.primaryweaponsammo[var_02]["ammostock"] = 90;
			param_00 setweaponammoclip(var_02,15);
			param_00.classsettings[var_01]["battery"] = level.classsettings[var_01]["battery"];
			param_00.lasttacticalweapon = param_00.classsettings[var_01]["exoAbility"];
			wait(0.1);
			if(param_00 getclientomnvar("horde_first_spawn") == 1)
			{
				thread maps\mp\gametypes\_horde_armory::hordeclassrunfirstspawn(param_00);
			}
		}

		param_00 maps\mp\gametypes\_playerlogic::spawnplayer(0,0);
		param_00.isspectator = undefined;
		wait(0.1);
		if(param_00.wasunderwater)
		{
			resetwateronrevivefromspectator();
		}

		param_00 setupplayerafterrevivefromspectator();
		param_00 setlethalweapon(param_00.lastlethalweapon);
		param_00 giveweapon(param_00.lastlethalweapon);
		param_00 settacticalweapon(param_00.lasttacticalweapon);
		param_00 giveweapon(param_00.lasttacticalweapon);
		param_00 setweaponammoclip(param_00.lastlethalweapon,param_00.lastlethalweaponammoclip);
		param_00 maps\mp\gametypes\_horde_armory::armorygiveexoability(param_00.lasttacticalweapon,1);
		param_00 maps\mp\_utility::playerallowdodge(param_00.classsettings[var_01]["allowDodge"],"class");
		param_00 maps\mp\_utility::playerallowpowerslide(param_00.classsettings[var_01]["allowSlide"],"class");
		param_00 thread addlastperks();
		var_03 = param_00 getclientomnvar("ui_horde_player_class");
		maps\mp\gametypes\_horde_armory::hordegiveability(param_00,var_03);
		param_00 setclientomnvar("ks_count1",0);
		param_00 setclientomnvar("ks_count_updated",1);
		param_00.maxhealth = param_00.classmaxhealth + param_00.hordearmor * 40;
		param_00.health = param_00.maxhealth;
		if(!param_00.classabilityready && !level.zombiesstarted)
		{
			if(isdefined(param_00.hordeclassgoliathcontroller) || isdefined(param_00.hordeclassgoliathpodinfield))
			{
				level thread maps\mp\gametypes\_horde_armory::hordewaitforgoliathdeath(param_00,maps\mp\gametypes\_horde_armory::getabilitywaittime(param_00));
			}
			else
			{
				level thread maps\mp\gametypes\_horde_armory::hordeabilityregenbar(param_00,maps\mp\gametypes\_horde_armory::getabilitywaittime(param_00));
			}
		}

		param_00.goliathdeath = undefined;
		param_00 maps\mp\gametypes\_horde_laststand::givebackstoredplayerweapons(var_01,1);
		foreach(var_05 in param_00.lastkillstreaks)
		{
			var_06 = maps\mp\gametypes\_horde_util::getslotnumber(param_00);
			if(!isdefined(var_06))
			{
				continue;
			}

			param_00 thread maps\mp\killstreaks\_killstreaks::givekillstreak(var_05["name"],0,0,param_00,var_05["modules"],var_06);
			param_00.currentkillstreaks[var_06] = var_05["name"];
		}

		return;
	}

	if(maps\mp\gametypes\_horde_util::isplayerinlaststand(param_00))
	{
		param_00 notify("revive_trigger",param_00);
	}
}

//Function Number: 102
addlastperks()
{
	self endon("death");
	level endon("game_ended");
	foreach(var_01 in self.lastperks)
	{
		wait(0.1);
		if(!maps\mp\_utility::_hasperk(var_01["name"]))
		{
			maps\mp\gametypes\_horde_armory::hordegiveperk(var_01["name"]);
		}
	}
}

//Function Number: 103
updateachievements()
{
	if(level.hordelevelflip > 1)
	{
		foreach(var_01 in level.players)
		{
			var_01 giveachievement("COOP_EXO_SURVIVOR");
		}
	}

	if(level.hordelevelflip > 2)
	{
		foreach(var_01 in level.players)
		{
			var_01 giveachievement("COOP_FLIP_FLOP");
		}
	}
}

//Function Number: 104
updatehordesettings()
{
	if(level.currentroundnumber == level.maxrounds)
	{
		level.hordelevelflip++;
		setomnvar("ui_horde_flip",level.hordelevelflip);
		horderandomizeaimodifiertypes();
	}

	if(maps\mp\_utility::getmapname() == "mp_prison_z" && level.currentroundnumber == 10)
	{
		level.hordewaveadjust = 15;
	}

	level.currentroundnumber = getnextroundnumber();
	level.maxdronecount = 0;
	level.maxwarbirdcount = 0;
	level.maxalivedronecount = 0;
	level.maxdogcount = 0;
	level.maxalivedogcount = 0;
	level.dogsalive = 0;
	level.wavefirstspawn = 1;
	level.horderoundstats["support_drops_earned"] = 0;
	var_00 = getwavetable();
	level.specialaistats = [];
	level.specialaitypes = strtok(tablelookup(var_00,1,level.currentroundnumber + level.hordewaveadjust,5)," ");
	level.specialaicount = strtok(tablelookup(var_00,1,level.currentroundnumber + level.hordewaveadjust,6)," ");
	for(var_01 = 0;var_01 < level.specialaitypes.size;var_01++)
	{
		level.specialaistats[level.specialaitypes[var_01]]["count"] = 0;
		level.specialaistats[level.specialaitypes[var_01]]["maxCount"] = int(level.specialaicount[var_01]) + getaicountincrease(level.specialaitypes[var_01]);
	}

	level.nonhumantypes = strtok(tablelookup(var_00,1,level.currentroundnumber + level.hordewaveadjust,7)," ");
	for(var_01 = 0;var_01 < level.nonhumantypes.size;var_01++)
	{
		if(issubstr(level.nonhumantypes[var_01],"drone") && !level.hordelevelflip > 1 && level.currentroundnumber == 9)
		{
			level.maxdronecount = getmaxdronecount(level.currentroundnumber);
			level.maxalivedronecount = level.maxdronecount;
			level.droneweapon = tablelookup(getwavetable(),1,level.hordedronetype,4);
			level.dronehealth = int(tablelookup(getwavetable(),1,level.hordedronetype,7));
			level.hordedronemodel = "vehicle_atlas_assault_drone";
			if(level.hordedronetype == "drone_large_energy")
			{
				level.hordedronemodel = "vehicle_atlas_assault_drone_large";
			}
		}

		if(issubstr(level.nonhumantypes[var_01],"warbird") || level.hordelevelflip > 1 && level.currentroundnumber == 9 || level.hordelevelflip == 1 && level.currentroundnumber == 11)
		{
			level.maxwarbirdcount = getmaxwarbirdcount(level.currentroundnumber);
			if((level.hordelevelflip > 1 && level.currentroundnumber == 9) || level.hordelevelflip == 1 && level.currentroundnumber == 11)
			{
				level.maxwarbirdcount = 1;
				level.hordewarbirdtype = "warbird";
			}

			level.warbirdweapon = tablelookup(getwavetable(),1,level.hordewarbirdtype,4);
			level.warbirdhealth = int(tablelookup(getwavetable(),1,level.hordewarbirdtype,7));
			level.hordewarbirdmodel = "vehicle_atlas_assault_warbird";
		}

		if(issubstr(level.nonhumantypes[var_01],"dog") && !level.hordelevelflip == 1 && level.currentroundnumber == 11)
		{
			level.maxdogcount = getmaxdogcount(level.currentroundnumber);
			level.maxalivedogcount = level.maxdogcount;
		}
	}

	level.maxenemycount = getmaxenemycount(level.currentroundnumber);
	level.currentenemycount = 0;
	level.maxaliveenemycount = getmaxaliveenemycount(level.currentroundnumber);
	level.currentaliveenemycount = 0;
	level.enemiesleft = 0;
	level.maxpickupsperround = getmaxpickupsperround();
	level.currentpickupcount = 0;
	level.currentammopickupcount = 0;
	level.chancetospawndog = 0;
	if(level.currentroundnumber == 10 && maps\mp\gametypes\_horde_util::getnumplayers() < 2)
	{
		level.maxenemycount = 1;
		level.maxaliveenemycount = 1;
	}

	if(level.currentroundnumber > 4)
	{
		setnojipscore(1);
	}

	foreach(var_03 in level.players)
	{
		var_03.roundkills = 0;
		var_03.roundheadshots = 0;
		var_03.roundupgradepoints = 0;
	}

	updateachievements();
}

//Function Number: 105
horderandomizeaimodifiertypes()
{
	var_00 = clamp(level.hordelevelflip,1,4);
	switch(int(var_00))
	{
		case 4:
			level.modifiercompanionaitypes = hordereturnrandomaitypes(level.hordemodeelites,undefined,3);
			break;

		case 3:
			level.modifierexplosiveaitypes = hordereturnrandomaitypes(level.hordemodeelites,undefined,2);
			break;

		case 2:
			level.modifiertoxicaitypes = hordereturnrandomaitypes(level.hordemodespecials,level.hordemodeelites,3);
			break;

		case 1:
			level.modifiershieldaitypes = hordereturnrandomaitypes(level.hordemodegrunts,undefined,level.hordemodegrunts.size / 2);
			break;
	}
}

//Function Number: 106
hordereturnrandomaitypes(param_00,param_01,param_02)
{
	var_03 = [];
	if(isdefined(param_01))
	{
		param_00 = common_scripts\utility::array_combine(param_00,param_01);
	}

	for(var_04 = 0;var_04 < param_02;var_04++)
	{
		var_05 = common_scripts\utility::random(param_00);
		var_03 = common_scripts\utility::add_to_array(var_03,var_05);
		param_00 = common_scripts\utility::array_remove(param_00,var_05);
	}

	return var_03;
}

//Function Number: 107
hordeupdateroundstats()
{
	level.horderoundstats["round_time"] = gettime() - level.horderoundstats["round_time"];
	if(!isdefined(level.fastesttime) || level.horderoundstats["round_time"] < level.fastesttime)
	{
		level.fastesttime = level.horderoundstats["round_time"];
	}

	var_00 = int(level.horderoundstats["round_time"] / 1000);
	if(var_00 > 999)
	{
		var_00 = 999;
	}

	setomnvar("ui_horde_round_time",var_00);
	setomnvar("ui_horde_round_drops",level.horderoundstats["support_drops_earned"]);
	foreach(var_02 in level.players)
	{
		var_02 setclientomnvar("ui_horde_round_kills",var_02.roundkills);
		var_02 setclientomnvar("ui_horde_round_headshots",var_02.roundheadshots);
		var_02 setclientomnvar("ui_horde_round_points",var_02.roundupgradepoints);
	}

	if(getomnvar("ui_horde_show_objstatus") > 0)
	{
		setomnvar("ui_horde_show_objstatus",0);
	}

	if(!level.zombiesstarted)
	{
		setomnvar("ui_horde_show_roundstats",1);
	}

	var_04 = 300 - var_00 * 5;
	if(var_04 < 0)
	{
		var_04 = 0;
	}

	foreach(var_02 in level.players)
	{
		var_06 = var_02.roundkills * 50;
		var_07 = level.horderoundstats["support_drops_earned"] * 500;
		var_08 = var_02.roundupgradepoints * 500;
		var_09 = var_02.roundheadshots * 50;
		var_0A = var_04 + var_06 + var_07 + var_08 + var_09;
		level thread maps\mp\gametypes\_horde_util::hordeupdatescore(var_02,var_0A);
		level thread maps\mp\gametypes\_horde_util::awardhordeheadshots(var_02,var_02.roundheadshots);
	}

	thread hordehideroundstats();
}

//Function Number: 108
hordehideroundstats()
{
	level endon("game_ended");
	common_scripts\utility::waittill_any_timeout(15,"all_players_ready","round_begin");
	setomnvar("ui_horde_show_roundstats",0);
	if(level.isobjectiveround)
	{
		setomnvar("ui_horde_show_objstatus",1);
	}
}

//Function Number: 109
getnextroundnumber()
{
	if(level.currentroundnumber == level.maxrounds)
	{
		var_00 = 1;
	}
	else if(level.currentroundnumber == 0)
	{
		var_00 = hordegetstartingroundnum(getdvarint("scr_horde_startinground"));
	}
	else
	{
		var_00 = level.currentroundnumber + 1;
	}

	return var_00;
}

//Function Number: 110
hordegetstartingroundnum(param_00)
{
	var_01 = 1;
	switch(param_00)
	{
		case 0:
			var_01 = 1;
			break;

		case 1:
			var_01 = 5;
			break;

		case 2:
			var_01 = 10;
			break;

		case 3:
			var_01 = 15;
			break;

		case 4:
			var_01 = 20;
			break;

		case 5:
			var_01 = 25;
			break;
	}

	return var_01;
}

//Function Number: 111
getrownumber(param_00)
{
	param_00 = int(clamp(param_00,1,20));
	param_00 = param_00 - 1;
	return param_00 * 4 + maps\mp\gametypes\_horde_util::getnumplayers();
}

//Function Number: 112
getmaxrounds(param_00)
{
	var_01 = 100;
	switch(param_00)
	{
		case 1:
		case 0:
			var_01 = 20;
			break;

		case 2:
			var_01 = 40;
			break;

		case 3:
			var_01 = 100;
			break;

		default:
			var_01 = 100;
			break;
	}

	return var_01;
}

//Function Number: 113
getmaxenemycount(param_00)
{
	var_01 = int(tablelookup(getwavetable(),1,level.currentroundnumber + level.hordewaveadjust,2)) + getaicountincrease();
	return var_01;
}

//Function Number: 114
getmaxdronecount(param_00)
{
	var_01 = getwavetable();
	level.hordedronetype = tablelookup(var_01,1,level.currentroundnumber + level.hordewaveadjust,7);
	var_02 = int(tablelookup(var_01,1,level.currentroundnumber + level.hordewaveadjust,8));
	return var_02;
}

//Function Number: 115
getmaxdogcount(param_00)
{
	level.hordedogtype = tablelookup(getwavetable(),1,level.currentroundnumber + level.hordewaveadjust,7);
	var_01 = int(tablelookup(getwavetable(),1,level.currentroundnumber + level.hordewaveadjust,8));
	return var_01;
}

//Function Number: 116
getmaxwarbirdcount(param_00)
{
	var_01 = getwavetable();
	level.hordewarbirdtype = tablelookup(var_01,1,level.currentroundnumber + level.hordewaveadjust,7);
	var_02 = int(tablelookup(var_01,1,level.currentroundnumber + level.hordewaveadjust,8));
	return var_02;
}

//Function Number: 117
getmaxaliveenemycount(param_00)
{
	var_01 = int(tablelookup(getwavetable(),1,level.currentroundnumber + level.hordewaveadjust,3)) + getaicountincrease();
	return var_01;
}

//Function Number: 118
getaicountincrease(param_00)
{
	if(level.currentroundnumber == 5 || level.currentroundnumber == 10)
	{
		return 0;
	}

	var_01 = maps\mp\gametypes\_horde_util::getnumplayers() - 1;
	if(isdefined(param_00) && issubstr(param_00,"jugg"))
	{
		if(level.currentroundnumber < 14)
		{
			var_01 = 0;
		}
		else if(level.currentroundnumber < 24)
		{
			var_01 = min(1,maps\mp\gametypes\_horde_util::getnumplayers() - 1);
		}
		else if(level.currentroundnumber == 25)
		{
			var_01 = min(2,maps\mp\gametypes\_horde_util::getnumplayers() - 1);
		}
	}

	return var_01;
}

//Function Number: 119
waituntilmatchstart()
{
	maps\mp\_utility::gameflagwait("prematch_done");
	while(!isdefined(level.bot_loadouts_initialized) || level.bot_loadouts_initialized == 0)
	{
		wait(0.05);
	}

	while(!level.players.size)
	{
		wait(0.05);
	}
}

//Function Number: 120
shownextroundmessage()
{
	level.players_ready = 0;
	if(level.currentroundnumber > 1)
	{
		foreach(var_01 in level.players)
		{
			level thread hordemonitordoubletap(var_01,"readyup");
		}

		level thread hordemonitorplayersready();
	}

	setomnvar("ui_horde_round_number_unlock",level.currentroundnumber);
	horderoundintermission();
	foreach(var_01 in level.players)
	{
		var_01 setclientomnvar("ui_horde_show_readyup",0);
	}

	setomnvar("ui_horde_round_number",level.currentroundnumber);
	level thread respawneliminatedplayers();
	var_05 = "horde_wave_start";
	level childthread maps\mp\gametypes\_horde_util::playsoundtoallplayers(var_05);
	if(maps\mp\_utility::getmapname() == "mp_prison_z" && level.currentroundnumber > 10)
	{
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(5);
	}
}

//Function Number: 121
showintermissiontimer()
{
	if(level.currentroundnumber == 1)
	{
		return 0;
	}

	if(maps\mp\_utility::getmapname() == "mp_prison_z" && level.currentroundnumber > 10)
	{
		return 0;
	}

	if(isdefined(level.hordeobjectivesuccess) && !level.hordeobjectivesuccess)
	{
		return 0;
	}

	return 1;
}

//Function Number: 122
hordemonitorplayersready()
{
	level endon("game_ended");
	level endon("start_round");
	while(level.players_ready < level.players.size)
	{
		wait(0.05);
	}

	level notify("all_players_ready");
	setomnvar("ui_horde_show_roundstats",0);
	clearhudtimer();
}

//Function Number: 123
horderoundintermission()
{
	level endon("game_ended");
	level endon("all_players_ready");
	if(showintermissiontimer())
	{
		sethudtimer("start_time",getroundintermissiontimer());
		foreach(var_01 in level.players)
		{
			var_01 setclientomnvar("ui_horde_show_readyup",1);
		}
	}

	if(level.currentroundnumber == 1)
	{
		thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_intro","horde",1,2);
	}

	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(getroundintermissiontimer() - 6);
	if(!level.zombiesstarted)
	{
		level notify("wave_final_countdown");
		foreach(var_01 in level.players)
		{
			var_01 setclientomnvar("ui_horde_show_readyup",0);
		}

		hordeintermissionfinalcountdown();
		thread hordeintermissionclearcountdown();
	}

	level notify("round_begin");
}

//Function Number: 124
hordeintermissionfinalcountdown(param_00)
{
	clearhudtimer();
	if(!isdefined(param_00))
	{
		param_00 = 5;
	}

	setomnvar("ui_match_countdown_toggle",1);
	setomnvar("ui_match_countdown_title",4);
	while(param_00 > 0 && !level.gameended)
	{
		if(getomnvar("ui_match_countdown_title") == 4)
		{
			setomnvar("ui_match_countdown",param_00);
		}

		wait(1);
		param_00--;
	}
}

//Function Number: 125
hordeintermissionclearcountdown()
{
	setomnvar("ui_match_countdown_title",5);
	setomnvar("ui_match_countdown",0);
	setomnvar("ui_match_countdown_toggle",0);
	wait(2);
	setomnvar("ui_match_countdown_title",0);
}

//Function Number: 126
getroundintermissiontimer()
{
	if(!showintermissiontimer())
	{
		return 10;
	}

	return 45;
}

//Function Number: 127
hordemonitordoubletap(param_00,param_01)
{
	param_00 endon("disconnect");
	param_00 endon("death");
	level endon("game_ended");
	if(param_01 == "dismiss_info")
	{
		param_00 endon("info_dismissed");
	}
	else if(param_01 == "readyup")
	{
		param_00 endon("ready");
		level endon("start_round");
		level endon("wave_final_countdown");
	}

	var_02 = 0;
	for(;;)
	{
		if(param_00 usebuttonpressed())
		{
			var_02 = 0;
			while(param_00 usebuttonpressed())
			{
				var_02 = var_02 + 0.05;
				wait(0.05);
			}

			if(var_02 >= 0.5)
			{
				continue;
			}

			var_02 = 0;
			while(!param_00 usebuttonpressed() && var_02 < 0.5)
			{
				var_02 = var_02 + 0.05;
				wait(0.05);
			}

			if(var_02 >= 0.5)
			{
				continue;
			}

			switch(param_01)
			{
				case "readyup":
					if(!param_00 maps\mp\_utility::isusingremote())
					{
						level.players_ready++;
						if(level.players_ready < level.players.size)
						{
							param_00 setclientomnvar("ui_horde_show_readyup",2);
						}
		
						param_00 notify("ready");
					}
					break;
	
				case "dismiss_info":
					param_00 notify("info_dismissed");
					break;
			}
		}

		wait(0.05);
	}
}

//Function Number: 128
rundroplocations()
{
	level endon("game_ended");
	level endon("zombies_start");
	waituntilmatchstart();
	if(!isdefined(level.hordedroplocations) || !level.hordedroplocations.size)
	{
		return;
	}

	level childthread monitorsupportdropprogress();
	for(;;)
	{
		level waittill("airSupport");
		thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_supportdropincoming","horde",1,1);
		level childthread displayincomingairdropmessage();
		for(var_00 = 0;var_00 < level.hordeuseddroplocations.size;var_00++)
		{
			level.hordedroplocations[level.hordedroplocations.size] = level.hordeuseddroplocations[0];
			level.hordeuseddroplocations = common_scripts\utility::array_remove(level.hordeuseddroplocations,level.hordeuseddroplocations[0]);
		}

		foreach(var_02 in level.players)
		{
			if(!maps\mp\_utility::isreallyalive(var_02))
			{
				continue;
			}

			var_03 = var_02 thread maps\mp\killstreaks\_orbital_carepackage::playerlaunchcarepackage("horde_support_drop",var_02.killstreakmodules);
		}

		level.horderoundstats["support_drops_earned"]++;
	}
}

//Function Number: 129
sortdroplocations()
{
	var_00 = (0,0,0);
	var_01 = 0;
	foreach(var_03 in level.players)
	{
		if(!maps\mp\gametypes\_horde_util::isonhumanteam(var_03) || !isalive(var_03))
		{
			continue;
		}

		var_01++;
		var_00 = var_00 + (var_03.origin[0],var_03.origin[1],var_03.origin[2]);
	}

	var_05 = var_00 / var_01;
	level.hordedroplocations = sortbydistance(level.hordedroplocations,var_05);
}

//Function Number: 130
monitorsupportdropprogress()
{
	level.supportbarsize = getsupportbarsize();
	for(;;)
	{
		level common_scripts\utility::waittill_any("pointsEarned","host_migration_end");
		if(level.currentpointtotal >= level.supportbarsize)
		{
			level notify("airSupport");
			foreach(var_01 in level.players)
			{
				maps\mp\gametypes\_horde_armory::addarmorypoints(var_01,"support_bar_filled");
			}

			level.currentpointtotal = level.currentpointtotal - level.supportbarsize;
			level.supportbarsize = getsupportbarsize();
			setomnvar("ui_horde_support_drop_progress",100);
			wait(2.72);
		}

		setomnvar("ui_horde_support_drop_progress",int(level.currentpointtotal / level.supportbarsize * 100));
	}
}

//Function Number: 131
getsupportbarsize()
{
	var_00 = getmaxenemycount(level.currentroundnumber);
	var_01 = int(level.currentroundnumber / 4);
	var_02 = 45 + var_01 * 15;
	var_03 = 1500;
	if(maps\mp\gametypes\_horde_util::getnumplayers() == 2)
	{
		var_03 = 2100;
	}
	else if(maps\mp\gametypes\_horde_util::getnumplayers() == 3)
	{
		var_03 = 3300;
	}
	else if(maps\mp\gametypes\_horde_util::getnumplayers() == 4)
	{
		var_03 = 4100;
	}

	var_03 = var_03 + 800 * level.hordedifficultylevel;
	return var_03 + var_00 * var_02;
}

//Function Number: 132
activateplayerhud(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 waittill("spawned_player");
	wait(0.05);
	if(level.currentroundnumber == 0)
	{
		var_01 = hordegetstartingroundnum(getdvarint("scr_horde_startinground"));
	}
	else
	{
		var_01 = level.currentroundnumber;
	}

	setomnvar("ui_horde_round_number",var_01);
	thread watchforhostmigrationsetround();
}

//Function Number: 133
watchforhostmigrationsetround()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("host_migration_end");
		var_00 = int(max(level.currentroundnumber,1));
		setomnvar("ui_horde_round_number",var_00);
		foreach(var_02 in level.players)
		{
			if(isai(var_02))
			{
				continue;
			}

			if(!isdefined(var_02))
			{
				continue;
			}

			if(!isdefined(var_02.horde_perks))
			{
				continue;
			}

			if(!var_02.horde_perks.size)
			{
				continue;
			}

			var_03 = var_02.horde_perks.size;
			for(var_04 = 0;var_04 < var_03;var_04++)
			{
				if(!isdefined(var_02))
				{
					continue;
				}

				if(!isagent(var_02))
				{
					var_02 setclientomnvar("ui_horde_update_perk",var_02.horde_perks[var_04]["index"]);
				}

				wait(0.05);
			}
		}
	}
}

//Function Number: 134
watchforhostmigrationselectclass()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("host_migration_begin");
		foreach(var_01 in level.players)
		{
			var_02 = var_01 getclientomnvar("ui_horde_show_armory");
			var_03 = var_01 getclientomnvar("ui_horde_armory_type");
			if(var_02 && var_03 != "killstreak_armory" && var_03 != "perk_armory")
			{
				var_01 setclientomnvar("ui_horde_show_armory",0);
				var_01 enableusability();
			}
		}

		level waittill("host_migration_end");
		foreach(var_01 in level.players)
		{
			if(!var_01.classchosen)
			{
				var_01 setclientomnvar("ui_horde_armory_type","class");
				var_01 setclientomnvar("ui_horde_show_armory",1);
			}
		}
	}
}

//Function Number: 135
getweaponfxheight(param_00)
{
	var_01 = param_00 getstance();
	if(var_01 == "stand")
	{
		return 48;
	}

	if(var_01 == "crouch")
	{
		return 32;
	}

	return 12;
}

//Function Number: 136
displayincomingairdropmessage()
{
	wait(0.05);
	foreach(var_01 in level.players)
	{
		if(!maps\mp\gametypes\_horde_util::isonhumanteam(var_01))
		{
			continue;
		}

		if(var_01.sessionstate == "spectator")
		{
			continue;
		}

		var_01 thread maps\mp\gametypes\_hud_message::splashnotify("horde_support_drop");
	}
}

//Function Number: 137
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
	level.spawn_name = "mp_tdm_spawn";
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies",level.spawn_name);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis",level.spawn_name);
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 138
getspawnpoint()
{
	var_00 = self.team;
	if(!maps\mp\gametypes\_horde_util::isonhumanteam(self) && self.agent_type == "player")
	{
		self.hordeloadout = hordegetenemyloadout();
	}

	if(maps\mp\gametypes\_horde_util::isonhumanteam(self))
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_00);
		if(level.ingraceperiod)
		{
			var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_01);
		}
		else
		{
			var_02 = maps\mp\gametypes\_spawnscoring::getspawnpoint_nearteam(var_02);
		}

		return var_02;
	}

	var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_02);
	if(isdefined(self.hordeloadout) && issubstr(self.hordeloadout["type"],"jugg"))
	{
		var_02 = cullbadjuggspawns(var_02);
	}
	else if(isdefined(self.agent_type) && self.agent_type == "dog")
	{
		var_02 = cullbaddogspawns(var_02);
	}

	var_02 = maps\mp\gametypes\_spawnscoring::getspawnpoint_safeguard(var_02);
	return var_02;
}

//Function Number: 139
cullbadjuggspawns(param_00)
{
	if(isarray(param_00))
	{
		foreach(var_02 in param_00)
		{
			if(maps\mp\_utility::getmapname() == "mp_recovery" && distance2dsquared(var_02.origin,(-631,-313.2,38)) < 4096 || distance2dsquared(var_02.origin,(-1276,-129,148)) < 4096)
			{
				param_00 = common_scripts\utility::array_remove(param_00,var_02);
			}

			if(maps\mp\_utility::getmapname() == "mp_refraction" && distance2dsquared(var_02.origin,(-2356,-1208,2304)) < 4096)
			{
				param_00 = common_scripts\utility::array_remove(param_00,var_02);
			}

			if(maps\mp\_utility::getmapname() == "mp_comeback" && distance2dsquared(var_02.origin,(814,-945,239)) < 4096 || distance2dsquared(var_02.origin,(474,788,184)) < 4096)
			{
				param_00 = common_scripts\utility::array_remove(param_00,var_02);
			}
		}
	}

	return param_00;
}

//Function Number: 140
cullbaddogspawns(param_00)
{
	if(isarray(param_00))
	{
		foreach(var_02 in param_00)
		{
			if(maps\mp\_utility::getmapname() == "mp_lab2" && distance2dsquared(var_02.origin,(-529,1378,499)) < 4096)
			{
				param_00 = common_scripts\utility::array_remove(param_00,var_02);
			}
		}
	}

	return param_00;
}

//Function Number: 141
getagentdamagescalar()
{
	var_00 = 0.25;
	var_01 = maps\mp\gametypes\_horde_util::getnumplayers();
	switch(var_01)
	{
		case 0:
			var_00 = 0.015;
			break;

		case 1:
			var_00 = 0.015;
			break;

		case 2:
			var_00 = 0.025;
			break;

		case 3:
			var_00 = 0.05;
			break;

		case 4:
		default:
			var_00 = 0.05;
			break;
	}

	return var_00;
}

//Function Number: 142
getplayerdamagescale()
{
	var_00 = maps\mp\gametypes\_horde_util::getnumplayers();
	var_01 = 0.05;
	switch(var_00)
	{
		case 1:
			var_01 = 0.05;
			break;

		case 2:
			var_01 = 0.14;
			break;

		case 3:
			var_01 = 0.32;
			break;

		case 4:
			var_01 = 0.46;
			break;
	}

	var_01 = var_01 + 0.15 * level.hordedifficultylevel;
	var_01 = var_01 + 0.3 * level.hordelevelflip - 1;
	return var_01;
}

//Function Number: 143
modifyplayerdamagehorde(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if((!isdefined(param_02) || param_02.classname == "worldspawn") && param_00.team == level.enemyteam && isdefined(param_05) && param_05 == "killstreak_strike_missile_gas_mp" || param_05 == "warbird_missile_mp")
	{
		return 0;
	}

	if(isdefined(param_02) && isdefined(param_02.team) && param_02.team == param_00.team)
	{
		if(param_05 == "destructible_toy" || param_05 == "mp_lab_gas_explosion")
		{
			param_03 = 60;
			param_03 = int(min(param_03 + param_03 * getplayerdamagescale(),0.7 * param_00.maxhealth));
			if(isdefined(param_00.horde_perks))
			{
				foreach(var_0A in param_00.horde_perks)
				{
					if(var_0A["name"] == "specialty_class_flakjacket")
					{
						param_03 = param_03 * 0.5;
						break;
					}
				}
			}

			return int(param_03);
		}
		else if(param_05 == "stun_grenade_horde_mp")
		{
			return param_03;
		}
		else
		{
			return 0;
		}
	}

	if(isdefined(param_02) && isplayer(param_02))
	{
		if(param_00 == param_02 && maps\mp\_utility::iskillstreakweapon(param_05))
		{
			param_03 = 0;
		}

		var_0C = getweaponbasename(param_05);
		if(param_00.team == level.enemyteam && param_02.team == level.playerteam)
		{
			if(maps\mp\_utility::ismeleemod(param_04))
			{
				param_03 = param_00.maxhealth + 1;
			}

			var_0D = weaponclass(param_05);
			if(isdefined(param_00.horde_type) && param_00.horde_type == "jugg" || param_00.horde_type == "jugg_handler")
			{
				if(maps\mp\_utility::ismeleemod(param_04))
				{
					param_03 = int(param_03 * 0.25);
				}
				else if(param_05 == "boost_slam_mp")
				{
					param_03 = int(param_03 * 0.25);
				}
				else if(issubstr(param_05,"microdronelauncher"))
				{
					param_03 = int(param_03 * 3);
				}
				else if(issubstr(param_05,"crossbow"))
				{
					param_03 = int(param_03 * 2);
				}
				else if(var_0D == "rocketlauncher")
				{
					if(issubstr(param_05,"stinger"))
					{
						param_03 = int(param_03 * 0.05);
					}
					else if(param_04 == "MOD_PROJECTILE_SPLASH")
					{
						param_03 = param_03 * 0.9;
					}
					else
					{
						param_03 = int(param_03 * 0.1);
					}
				}
				else if(param_05 == "orbital_laser_fov_mp")
				{
					param_03 = int(param_03 * 0.13);
				}
				else if(param_05 == "warbird_remote_turret_mp")
				{
					param_03 = int(param_03 * 4);
				}
				else if(param_05 == "remotemissile_projectile_mp")
				{
					param_03 = int(param_03 * 7);
				}
				else if(param_05 == "stealth_bomb_mp")
				{
					param_03 = int(param_03 * 4);
				}
				else if(issubstr(param_05,"em1"))
				{
					if(randomintrange(0,101) < 50)
					{
						param_03 = 1;
					}
					else
					{
						return 0;
					}
				}
				else if(var_0D == "mg" && param_05 != "iw5_exominigun_mp")
				{
					param_03 = int(param_03 * 0.2);
				}
				else if(issubstr(param_05,"epm3"))
				{
					param_03 = int(param_03 * 2);
				}
				else if(param_05 == "iw5_exominigun_mp")
				{
					param_03 = int(param_03 * 3);
				}
				else if(param_05 == "playermech_rocket_mp" || param_05 == "iw5_juggernautrockets_mp" || param_05 == "playermech_rocket_swarm_mp")
				{
					param_03 = int(param_03 * 0.035);
				}
			}
			else
			{
				param_03 = int(param_03 * param_02.weapondmgmod);
			}

			if(weaponclass(param_05) == "sniper")
			{
				param_03 = param_03 * 2;
			}

			if(weaponclass(param_05) == "rocketlauncher")
			{
				var_0E = 1000;
				if(getweaponbasename(param_05) == "iw5_maaws_mp")
				{
					if(param_04 == "MOD_PROJECTILE_SPLASH")
					{
						param_03 = param_03 * 2;
					}

					if(param_03 > var_0E)
					{
						param_03 = var_0E;
					}
				}

				if(getweaponbasename(param_05) == "iw5_mahem_mp")
				{
					if(param_04 == "MOD_PROJECTILE_SPLASH")
					{
						param_03 = param_03 * 3;
					}

					if(param_03 > var_0E)
					{
						param_03 = var_0E;
					}
				}
			}

			if(maps\mp\_utility::iskillstreakweapon(param_05))
			{
				param_03 = int(param_03 + 0 * level.currentroundnumber);
			}

			if(maps\mp\gametypes\_class::isvalidequipment(param_05,0))
			{
				if(isexplosivedamagemod(param_04))
				{
					param_03 = int(param_00.maxhealth) + 1;
				}

				if(param_05 == "throwingknife_mp")
				{
					param_03 = param_00.maxhealth + 1;
				}
			}

			param_03 = int(param_03 * param_02.classdmgmod);
			if(param_08 == "head" && param_03 >= param_00.health)
			{
				param_02.roundheadshots++;
			}

			param_02 givepointsfordamage(param_00,param_03,param_04,param_05,param_06,param_07,param_08,0);
		}
	}

	if(isdefined(param_02) && isdefined(param_02.owner) && isplayer(param_02.owner))
	{
		var_0F = 0;
		if(maps\mp\_utility::iskillstreakweapon(param_05))
		{
			param_03 = int(param_03 + 0 * level.currentroundnumber);
		}

		if(isagent(param_02))
		{
			param_03 = int(param_03 + param_03 * 0.1 * level.currentroundnumber - 2);
			var_0F = 1;
		}

		if(!isdefined(param_02.chopper) && !isdefined(param_02.ishordeenemysentry))
		{
			param_02.owner givepointsfordamage(param_00,param_03,param_04,param_05,param_06,param_07,param_08,var_0F);
		}
	}

	if(isplayer(param_00) || maps\mp\gametypes\_horde_util::isonhumanteam(param_00))
	{
		if(maps\mp\gametypes\_horde_util::isplayerinlaststand(param_00) && !param_00 maps\mp\_utility::touchingbadtrigger())
		{
			return 0;
		}

		if(param_05 == "semtexproj_mp")
		{
			param_03 = param_03 * 3;
		}

		if(isplayer(param_00))
		{
			if(issubstr(param_05,"_em1"))
			{
				param_03 = int(param_03 * 0.33 + 1);
			}

			if(issubstr(param_05,"microdronelauncher"))
			{
				param_03 = int(param_03 * getplayerdamagescale() + 0.4);
			}
			else if(issubstr(param_05,"exominigun"))
			{
				param_03 = int(param_03 * 0.4);
			}
			else if(issubstr(param_05,"mp11") || issubstr(param_05,"bal27"))
			{
				param_03 = int(param_03 * getplayerdamagescale() + 0.08);
			}
			else if(issubstr(param_05,"maul"))
			{
				param_03 = int(param_03 * getplayerdamagescale() - 0.02);
			}
			else if(issubstr(param_05,"himar"))
			{
				param_03 = int(param_03 * getplayerdamagescale() + 0.16);
			}
			else if(issubstr(param_05,"iw5_em1_mp"))
			{
				param_03 = int(param_03 * getplayerdamagescale() + 0.05);
			}
			else if(issubstr(param_05,"iw5_em1loot8_mp"))
			{
				param_03 = int(param_03 * getplayerdamagescale() + 0.12);
			}
			else if(issubstr(param_05,"iw5_em1loot4_mp"))
			{
				param_03 = int(param_03 * getplayerdamagescale() + 0.08);
			}
			else if(issubstr(param_05,"iw5_em1loot1_mp"))
			{
				param_03 = int(param_03 * getplayerdamagescale() + 0.16);
			}
			else if(issubstr(param_05,"epm3"))
			{
				param_03 = int(param_03 * getplayerdamagescale() + 0.35);
			}
			else if(issubstr(param_05,"remote_turret"))
			{
				param_03 = int(param_03 * getplayerdamagescale() + 0.06);
			}
			else if(issubstr(param_05,"warbird_missile_mp"))
			{
				param_03 = param_03 * 2;
				if(param_03 > 400)
				{
					param_03 = 400;
				}

				param_03 = int(param_03 * getplayerdamagescale());
				if(isdefined(param_00.horde_perks))
				{
					foreach(var_0A in param_00.horde_perks)
					{
						if(var_0A["name"] == "specialty_class_flakjacket")
						{
							param_03 = int(param_03 * 0.5);
							break;
						}
					}
				}
			}
			else if(issubstr(param_05,"remote_energy_turret"))
			{
				param_03 = int(param_03 * getplayerdamagescale() + 0.1);
			}
			else if(param_05 == "frag_grenade_mp")
			{
				param_03 = int(param_03 * getplayerdamagescale() + 0.3);
			}
			else if(param_05 == "iw5_juggernautrockets_mp")
			{
				param_03 = 20 + 30 * level.hordelevelflip - 1;
			}
			else if(isdefined(param_02) && isdefined(param_02.type) && issubstr(param_02.type,"tracking_drone"))
			{
				param_03 = int(min(param_03 * getplayerdamagescale() + 0.35,param_00.maxhealth * 0.8));
			}
			else if(param_05 == "killstreak_strike_missile_gas_mp")
			{
				return int(param_00.maxhealth * 0.1);
			}
			else if(param_04 == "MOD_TRIGGER_HURT" && param_00 maps\mp\_utility::touchingbadtrigger())
			{
				param_00.classselection = 0;
				if(isdefined(param_00.enteringgoliath) && param_00.enteringgoliath)
				{
					maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
					playfx(common_scripts\utility::getfx("goliath_self_destruct"),self.origin,anglestoup(self.angles));
					self thread [[ level.hordehandlejuggdeath ]]();
				}

				if(maps\mp\gametypes\_horde_util::isplayerinlaststand(param_00))
				{
					if(isdefined(param_00.isspectator) && param_00.isspectator)
					{
						return 0;
					}

					self hudoutlinedisable();
					self disableweapons();
					self.movespeedscaler = 0.05;
					if(level.players.size > 1)
					{
						thread maps\mp\gametypes\_horde_laststand::startspectatemode(0,0,0);
					}
					else
					{
						return 10000;
					}

					return 0;
				}

				return 10000;
			}
			else
			{
				param_03 = int(param_03 * getplayerdamagescale());
			}

			if(param_00.classselection)
			{
				return 0;
			}
		}
		else
		{
			param_03 = int(param_03 * getagentdamagescalar());
		}

		if(isdefined(param_02) && isagent(param_02))
		{
			if(maps\mp\_utility::ismeleemod(param_04))
			{
				if(issubstr(param_05,"zombiemelee"))
				{
					param_03 = int(param_00.maxhealth / 8) + 1;
				}
				else
				{
					param_03 = int(param_00.maxhealth / 3) + 1;
				}
			}

			if(param_02.agent_type == "dog")
			{
				param_03 = int(param_03 * 0.5);
				if(isdefined(param_00.isjuggernaut) && param_00.isjuggernaut)
				{
					param_03 = int(param_03 / 4);
				}
			}
		}

		if(issubstr(param_05,"em1"))
		{
			param_03 = param_03 * param_00.energydmgmod;
		}

		if(isdefined(param_00.isreviving) && param_00.isreviving)
		{
			if(isagent(param_00))
			{
				param_03 = 0;
			}

			if(isplayer(param_00))
			{
				param_03 = int(param_03 * 0.7);
			}
		}

		if(param_00 maps\mp\_utility::isusingremote())
		{
			param_03 = int(param_03 * 0.4);
		}
	}

	if(param_03 < 1)
	{
		param_03 = 1;
	}

	return param_03;
}

//Function Number: 144
givepointsfordamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = maps\mp\_utility::isheadshot(param_03,param_06,param_02,self);
	var_09 = maps\mp\_utility::ismeleemod(param_02) || param_02 == "MOD_IMPACT";
	var_0A = param_01 >= param_00.health;
	if(var_09 && param_06 == "shield")
	{
		return;
	}

	var_0B = undefined;
	if(var_0A)
	{
		if(var_09)
		{
			var_0B = "kill_melee";
			maps\mp\gametypes\_horde_util::awardhordemeleekills(self);
		}
		else if(var_08)
		{
			var_0B = "kill_head";
			maps\mp\gametypes\_horde_util::awardhordeheadshotkills(self);
		}
		else
		{
			var_0B = "kill_normal";
		}
	}
	else if(var_08 && isdefined(param_03) && !maps\mp\_utility::iskillstreakweapon(param_03))
	{
		var_0B = "damage_head";
	}
	else
	{
		var_0B = "damage_body";
	}

	givepointsforevent(var_0B,param_03,param_07);
}

//Function Number: 145
givepointsforevent(param_00,param_01,param_02)
{
	if(isdefined(level.empowner))
	{
		return;
	}

	if(level.hordeishardcore)
	{
		return;
	}

	var_03 = level.pointevents[param_00];
	if(issubstr(param_01,"em1") || issubstr(param_01,"turret"))
	{
		var_03 = 4;
	}

	self.pointnotifylua[self.pointnotifylua.size] = var_03;
	level thread maps\mp\gametypes\_rank::awardgameevent(param_00,self);
	level.currentpointtotal = level.currentpointtotal + var_03;
	level notify("pointsEarned");
	if(param_02)
	{
	}
}

//Function Number: 146
monitorpointnotifylua(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("death");
	for(;;)
	{
		if(param_00.pointnotifylua.size > 0)
		{
			if(!isagent(param_00))
			{
				param_00 setclientomnvar("ui_horde_award_points",param_00.pointnotifylua[param_00.pointnotifylua.size - 1]);
			}

			param_00.pointnotifylua = removelastelement(param_00.pointnotifylua);
		}

		wait(0.05);
	}
}

//Function Number: 147
monitorbackbutton(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		if(param_00 buttonpressed("BUTTON_BACK"))
		{
			if((param_00 maps\mp\_utility::isusingremote() && param_00.usingremote == "horde_player_drone") || !param_00 maps\mp\_utility::isusingremote())
			{
				param_00 setclientomnvar("ui_horde_show_armory",1);
			}
		}

		wait(0.05);
	}
}

//Function Number: 148
removelastelement(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size - 1;var_02++)
	{
		var_01[var_02] = param_00[var_02];
	}

	return var_01;
}

//Function Number: 149
onnormaldeath(param_00,param_01,param_02)
{
	removeperkhud(param_00);
	if(isplayer(param_00) && maps\mp\gametypes\_horde_util::isplayerinlaststand(param_00))
	{
		maps\mp\gametypes\_horde_util::hordeupdatescore(self,0);
		if(maps\mp\gametypes\_horde_laststand::gameshouldend(param_00))
		{
			maps\mp\gametypes\_horde_laststand::hordeendgame();
		}
		else
		{
			param_00 maps\mp\gametypes\_horde_laststand::startspectatemode(0,0,0);
		}
	}

	if(!isdefined(param_01))
	{
		return;
	}

	if(game["state"] == "postgame" && game["teamScores"][param_01.team] > game["teamScores"][level.otherteam[param_01.team]])
	{
		param_01.finalkill = 1;
	}
}

//Function Number: 150
removeperkhud(param_00)
{
	if(isplayer(param_00) && !isagent(param_00))
	{
		param_00 setclientomnvar("ui_horde_update_perk",0);
		param_00.horde_perks = [];
	}
}

//Function Number: 151
chancetospawnpickup(param_00)
{
	level endon("game_ended");
	if(param_00.agent_type == "dog" || param_00.horde_type == "zombie")
	{
		return;
	}

	if(level.objintel && level.killssinceinteldrop > 2)
	{
		thread spawnintelpickup(param_00.origin + (0,0,22));
		level.killssinceinteldrop = 0;
		return;
	}

	if(level.hordelevelflip == 1)
	{
		var_01 = 8;
		var_02 = 11;
	}
	else
	{
		var_01 = 11;
		var_02 = 15;
	}

	if(level.currentpickupcount >= level.maxpickupsperround)
	{
		return;
	}

	if(level.killssinceammodrop < randomintrange(var_01,var_02))
	{
		return;
	}

	if(level.currentammopickupcount < level.maxammopickupsperround)
	{
		var_03 = level.ammopickupmodel;
		var_04 = level.ammopickupfunc;
		level.currentammopickupcount++;
		level.killssinceammodrop = 0;
		spawnpickup(param_00.origin + (0,0,22),var_03,var_04,undefined,1);
	}
}

//Function Number: 152
spawnintelpickup(param_00)
{
	var_01 = spawn("script_model",param_00);
	var_01 setmodel("greece_drone_control_pad");
	var_01.angles = (0,0,0) + (randomint(360),randomint(360),randomint(360));
	var_01 physicslaunchserver(var_01.origin,(0,0,-1));
	var_01 makeusable();
	var_01 sethintstring(&"HORDE_PICKUP_INTEL");
	var_01 hudoutlineenable(4,0);
	var_02 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_02,"active",var_01.origin,"objective_sm");
	var_01.objectiveindex = var_02;
	level.collectobjects[level.collectobjects.size] = var_01;
	var_01 waittill("trigger",var_03);
	var_03 playlocalsound("mp_killconfirm_tags_pickup");
	level.hordecollected++;
	setomnvar("ui_horde_objcount_1",level.hordecollected);
	var_03 setclientomnvar("ui_horde_count",1);
	var_03 thread maps\mp\gametypes\_rank::xppointspopup("horde_collect",500);
	level thread maps\mp\gametypes\_horde_util::hordeupdatescore(var_03,500);
	level.currentpointtotal = level.currentpointtotal + 500;
	level notify("pointsEarned");
	if(level.hordecollected == level.horde_collect_count)
	{
		thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_allintelaquired","horde",1,1);
		hordeobjectivesuccess();
		level notify("collect_completed");
		level.hordecollected = 0;
	}

	maps\mp\_utility::_objective_delete(var_02);
	var_01 delete();
}

//Function Number: 153
spawnpickup(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03))
	{
		param_03 = 15;
	}

	var_05[0] = spawn("script_model",(0,0,0));
	var_05[0] setmodel(param_01);
	if(isdefined(param_04) && param_04)
	{
		var_05[0] hudoutlineenable(1,0);
	}

	var_06 = spawn("trigger_radius",(0,0,0),0,32,32);
	var_07 = maps\mp\gametypes\_gameobjects::createuseobject(level.playerteam,var_06,var_05,(0,0,16),1);
	var_08 = param_00;
	var_07.curorigin = var_08;
	var_07.trigger.origin = var_08;
	var_07.visuals[0].origin = var_08;
	var_07 maps\mp\gametypes\_gameobjects::setusetime(0);
	var_07 maps\mp\gametypes\_gameobjects::allowuse("friendly");
	var_07.onuse = param_02;
	level.currentpickupcount++;
	var_07 thread pickupbounce();
	var_07 thread pickuptimer(param_03);
	return var_07;
}

//Function Number: 154
pickupbounce()
{
	level endon("game_ended");
	self endon("deleted");
	self endon("death");
	var_00 = self;
	var_01 = self.curorigin;
	var_02 = self.curorigin + (0,0,12);
	var_03 = 1.25;
	if(isdefined(self.visuals) && isdefined(self.visuals[0]))
	{
		var_00 = self.visuals[0];
	}

	for(;;)
	{
		var_00 moveto(var_02,var_03,0.15,0.15);
		var_00 rotateyaw(180,var_03);
		wait(var_03);
		var_00 moveto(var_01,var_03,0.15,0.15);
		var_00 rotateyaw(180,var_03);
		wait(var_03);
	}
}

//Function Number: 155
pickuptimer(param_00)
{
	self endon("deleted");
	wait(param_00);
	thread pickupstartflashing();
	wait(8);
	level thread removepickup(self);
}

//Function Number: 156
pickupstartflashing()
{
	self endon("deleted");
	for(;;)
	{
		self.visuals[0] hide();
		wait(0.25);
		self.visuals[0] show();
		wait(0.25);
	}
}

//Function Number: 157
removepickup(param_00)
{
	param_00 notify("deleted");
	wait(0.05);
	param_00.trigger delete();
	param_00.visuals[0] delete();
}

//Function Number: 158
ammopickup(param_00)
{
	foreach(var_02 in level.players)
	{
		if(maps\mp\gametypes\_horde_util::isonhumanteam(var_02) && maps\mp\_utility::isreallyalive(var_02))
		{
			var_02 thread maps\mp\gametypes\_hud_message::splashnotify("horde_team_restock");
			maps\mp\gametypes\_horde_util::refillammohorde(var_02);
			var_02.health = var_02.maxhealth;
		}
	}

	param_00 playlocalsound("scavenger_pack_pickup");
	level thread removepickup(self);
}

//Function Number: 159
collectpickup(param_00)
{
	param_00.collectcount++;
	param_00 playlocalsound("mp_killconfirm_tags_pickup");
	level.hordecollected++;
	setomnvar("ui_horde_objcount_1",level.hordecollected);
	param_00 setclientomnvar("ui_horde_count",1);
	param_00 thread maps\mp\gametypes\_rank::xppointspopup("horde_collect",200);
	level thread maps\mp\gametypes\_horde_util::hordeupdatescore(param_00,200);
	level.currentpointtotal = level.currentpointtotal + 200;
	level notify("pointsEarned");
	maps\mp\_utility::_objective_delete(self.objectiveindex);
	level.collectobjects = common_scripts\utility::array_remove(level.collectobjects,self);
	if(level.hordecollected == level.horde_collect_count)
	{
		thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_allgodtagssecured","horde",1,1);
		hordeobjectivesuccess();
		level notify("collect_completed");
		level.hordecollected = 0;
	}

	level thread removepickup(self);
}

//Function Number: 160
dropweaponfordeathhorde(param_00,param_01)
{
	waittillframeend;
}

//Function Number: 161
ondeadevent(param_00)
{
	if(param_00 != level.enemyteam)
	{
		iprintln(&"MP_GHOSTS_ELIMINATED");
		logstring("team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
		level.finalkillcam_winner = "axis";
		level thread maps\mp\gametypes\_gamelogic::endgame("axis",game["end_reason"]["allies_eliminated"]);
	}
}

//Function Number: 162
setspecialloadouts()
{
	level.hordeloadouts["allies"]["loadoutPrimary"] = "iw5_kf5";
	level.hordeloadouts["allies"]["loadoutPrimaryAttachment"] = "none";
	level.hordeloadouts["allies"]["loadoutPrimaryAttachment2"] = "none";
	level.hordeloadouts["allies"]["loadoutPrimaryAttachment3"] = "none";
	level.hordeloadouts["allies"]["loadoutPrimaryBuff"] = "specialty_null";
	level.hordeloadouts["allies"]["loadoutPrimaryCamo"] = "none";
	level.hordeloadouts["allies"]["loadoutPrimaryReticle"] = "none";
	level.hordeloadouts["allies"]["loadoutSecondary"] = "none";
	level.hordeloadouts["allies"]["loadoutSecondaryAttachment"] = "none";
	level.hordeloadouts["allies"]["loadoutSecondaryAttachment2"] = "none";
	level.hordeloadouts["allies"]["loadoutSecondaryAttachment3"] = "none";
	level.hordeloadouts["allies"]["loadoutSecondaryBuff"] = "specialty_null";
	level.hordeloadouts["allies"]["loadoutSecondaryCamo"] = "none";
	level.hordeloadouts["allies"]["loadoutSecondaryReticle"] = "none";
	level.hordeloadouts["allies"]["loadoutEquipment"] = "frag_grenade_mp";
	level.hordeloadouts["allies"]["loadoutOffhand"] = "none";
	level.hordeloadouts["allies"]["loadoutKillstreaks"][0] = "none";
	level.hordeloadouts["allies"]["loadoutKillstreaks"][1] = "none";
	level.hordeloadouts["allies"]["loadoutKillstreaks"][2] = "none";
	level.hordeloadouts["allies"]["loadoutKillstreaks"][3] = "none";
	level.hordeloadouts["allies"]["loadoutJuggernaut"] = 0;
	level.hordeloadouts["allies"]["loadoutPerks"] = ["specialty_falldamage","specialty_null","specialty_null","specialty_null","specialty_null","specialty_null","specialty_null"];
	level.hordeloadouts["allies"]["loadoutWildcards"] = ["specialty_null","specialty_null","specialty_null"];
	level.hordeloadouts["squadmate"]["loadoutPrimary"] = "iw5_ak12";
	level.hordeloadouts["squadmate"]["loadoutPrimaryAttachment"] = "none";
	level.hordeloadouts["squadmate"]["loadoutPrimaryAttachment2"] = "none";
	level.hordeloadouts["squadmate"]["loadoutPrimaryAttachment3"] = "none";
	level.hordeloadouts["squadmate"]["loadoutPrimaryBuff"] = "specialty_null";
	level.hordeloadouts["squadmate"]["loadoutPrimaryCamo"] = "none";
	level.hordeloadouts["squadmate"]["loadoutPrimaryReticle"] = "none";
	level.hordeloadouts["squadmate"]["loadoutSecondary"] = "none";
	level.hordeloadouts["squadmate"]["loadoutSecondaryAttachment"] = "none";
	level.hordeloadouts["squadmate"]["loadoutSecondaryAttachment2"] = "none";
	level.hordeloadouts["squadmate"]["loadoutSecondaryAttachment3"] = "none";
	level.hordeloadouts["squadmate"]["loadoutSecondaryBuff"] = "specialty_null";
	level.hordeloadouts["squadmate"]["loadoutSecondaryCamo"] = "none";
	level.hordeloadouts["squadmate"]["loadoutSecondaryReticle"] = "none";
	level.hordeloadouts["squadmate"]["loadoutEquipment"] = "frag_grenade_mp";
	level.hordeloadouts["squadmate"]["loadoutOffhand"] = "none";
	level.hordeloadouts["squadmate"]["loadoutKillstreaks"][0] = "none";
	level.hordeloadouts["squadmate"]["loadoutKillstreaks"][1] = "none";
	level.hordeloadouts["squadmate"]["loadoutKillstreaks"][2] = "none";
	level.hordeloadouts["squadmate"]["loadoutKillstreaks"][3] = "none";
	level.hordeloadouts["squadmate"]["loadoutJuggernaut"] = 0;
	level.hordeloadouts["squadmate"]["loadoutPerks"] = ["specialty_falldamage","specialty_null","specialty_null","specialty_null","specialty_null","specialty_null","specialty_null"];
	level.hordeloadouts["squadmate"]["loadoutWildcards"] = ["specialty_null","specialty_null","specialty_null"];
}

//Function Number: 163
hordegetenemyloadout()
{
	var_00 = getwavetable();
	var_01 = tablelookup(var_00,1,level.currentroundnumber + level.hordewaveadjust,4);
	if(level.specialaitypes.size > 0)
	{
		for(var_02 = 0;var_02 < level.specialaistats.size;var_02++)
		{
			if(level.wavefirstspawn && level.specialaistats[level.specialaitypes[var_02]]["count"] < level.specialaistats[level.specialaitypes[var_02]]["maxCount"])
			{
				level.specialaistats[level.specialaitypes[var_02]]["count"]++;
				var_01 = level.specialaitypes[var_02];
				break;
			}
			else if(!level.wavefirstspawn && !level.specialaitypes[var_02] == "jugg" || level.specialaitypes[var_02] == "jugg_handler")
			{
				if(maps\mp\gametypes\_horde_util::cointossweighted(hordegetchancetorespawn(level.specialaitypes[var_02])))
				{
					var_01 = level.specialaitypes[var_02];
				}
			}
		}
	}

	if(level.hordelevelflip > 1)
	{
		var_03["loadoutPrimary"] = tablelookup(getwavetable(),1,var_01,10);
		var_03["loadoutPrimaryAttachment"] = tablelookup(getwavetable(),1,var_01,11);
		var_03["loadoutEquipment"] = tablelookup(getwavetable(),1,var_01,12);
		var_03["startinghealth"] = int(tablelookup(getwavetable(),1,var_01,13));
	}
	else
	{
		var_03["loadoutPrimary"] = tablelookup(getwavetable(),1,var_03,4);
		var_03["loadoutPrimaryAttachment"] = "none";
		var_03["loadoutEquipment"] = tablelookup(getwavetable(),1,var_01,5);
		var_03["startinghealth"] = int(tablelookup(getwavetable(),1,var_01,7));
	}

	var_03["loadoutPrimaryAttachment2"] = "none";
	var_03["loadoutPrimaryAttachment3"] = "none";
	var_03["loadoutPrimaryBuff"] = "specialty_null";
	var_03["loadoutPrimaryCamo"] = "none";
	var_03["loadoutPrimaryReticle"] = "none";
	var_03["loadoutSecondary"] = "none";
	var_03["loadoutSecondaryAttachment"] = "none";
	var_03["loadoutSecondaryAttachment2"] = "none";
	var_03["loadoutSecondaryAttachment3"] = "none";
	var_03["loadoutSecondaryBuff"] = "specialty_null";
	var_03["loadoutSecondaryCamo"] = "none";
	var_03["loadoutSecondaryReticle"] = "none";
	var_03["loadoutKillstreaks"][0] = "none";
	var_03["loadoutKillstreaks"][1] = "none";
	var_03["loadoutKillstreaks"][2] = "none";
	var_03["loadoutKillstreaks"][3] = "none";
	var_03["name_localized"] = &"HORDE_HAMMER";
	var_03["type"] = tablelookup(getwavetable(),1,var_01,1);
	var_03["loadoutPerks"] = ["specialty_falldamage","specialty_lightweight","specialty_null","specialty_null","specialty_null","specialty_null","specialty_null"];
	var_03["loadoutWildcards"] = ["specialty_null","specialty_null","specialty_null"];
	if(issubstr(var_03["type"],"jugg"))
	{
		var_03["loadoutJuggernaut"] = 1;
	}
	else
	{
		var_03["loadoutJuggernaut"] = 0;
	}

	if(issubstr(var_03["type"],"elite"))
	{
		var_03["loadoutOffhand"] = "exoshield_equipment_mp";
	}
	else
	{
		var_03["loadoutOffhand"] = "specialty_null";
	}

	var_03["movespeedscale"] = int(tablelookup(getwavetable(),1,var_01,8));
	var_03["points"] = int(tablelookup(getwavetable(),1,var_01,9));
	return var_03;
}

//Function Number: 164
hordegetchancetorespawn(param_00)
{
	var_01 = 70;
	if(param_00 == "handler")
	{
		var_01 = 30;
	}

	return var_01;
}

//Function Number: 165
hordegetenemyhealth(param_00)
{
	var_01 = int(param_00["startinghealth"] + param_00["startinghealth"] * level.hordelevelflip - 1 * 0.5);
	if(maps\mp\gametypes\_horde_util::getnumplayers() == 3)
	{
		var_01 = int(var_01 * 1.2);
	}
	else if(maps\mp\gametypes\_horde_util::getnumplayers() == 4)
	{
		var_01 = int(var_01 * 1.4);
	}

	return var_01;
}

//Function Number: 166
hordeloadwaveweapons()
{
	level.hordewaveweapons = [];
	var_00 = tablelookup(getwavetable(),1,level.currentroundnumber + 1 + level.hordewaveadjust,4);
	level.hordewaveweapons[level.hordewaveweapons.size] = tablelookup(getwavetable(),1,var_00,4) + "_mp";
	level.hordewaveweapons[level.hordewaveweapons.size] = tablelookup(getwavetable(),1,var_00,10) + "_mp";
	var_01 = strtok(tablelookup(getwavetable(),1,level.currentroundnumber + 1 + level.hordewaveadjust,5)," ");
	foreach(var_00 in var_01)
	{
		level.hordewaveweapons[level.hordewaveweapons.size] = tablelookup(getwavetable(),1,var_00,4) + "_mp";
	}

	foreach(var_05 in level.players)
	{
		var_05 loadweapons(level.hordewaveweapons);
		var_05 loadweapons(["iw5_microdronelauncher_mp"]);
	}
}

//Function Number: 167
monitorplayercamping(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	level endon("start_extraction");
	level endon("game_ended");
	while(!isdefined(level.currentroundnumber) || level.currentroundnumber < 5)
	{
		wait(3);
	}

	for(;;)
	{
		wait(10);
		var_01 = param_00.origin;
		var_02 = gettime();
		for(;;)
		{
			wait(1);
			var_03 = distancesquared(param_00.origin,var_01);
			var_04 = gettime() - var_02 / 1000;
			if(var_03 > 16384)
			{
				var_01 = param_00.origin;
				var_02 = gettime();
			}
			else if(var_04 > 30)
			{
				break;
			}

			if(!isdefined(level.currentaliveenemycount) || level.currentaliveenemycount < 1 || maps\mp\gametypes\_horde_util::isplayerinlaststand(param_00) || isdefined(param_00.isspectator) && param_00.isspectator || isdefined(param_00.usingarmory) || param_00 maps\mp\_utility::isusingremote() || isdefined(param_00.isreviving) && param_00.isreviving)
			{
				while(!isdefined(level.currentaliveenemycount) || level.currentaliveenemycount < 1 || maps\mp\gametypes\_horde_util::isplayerinlaststand(param_00) || isdefined(param_00.isspectator) && param_00.isspectator || isdefined(param_00.usingarmory) || param_00 maps\mp\_utility::isusingremote() || isdefined(param_00.isreviving) && param_00.isreviving)
				{
					wait(0.5);
				}

				var_01 = param_00.origin;
				var_02 = gettime();
			}
		}

		var_05 = spawncamperdrone();
		if(!isdefined(var_05))
		{
			continue;
		}

		var_05 vehicle_setminimapvisible(0);
		var_05.health = 50;
		var_05 camperdroneseektarget(param_00);
	}
}

//Function Number: 168
spawncamperdrone()
{
	level endon("game_ended");
	level endon("start_extraction");
	while(maps\mp\_utility::currentactivevehiclecount(2) >= maps\mp\_utility::maxvehiclesallowed())
	{
		wait(1);
	}

	var_00 = hordegetcamperdronespawn();
	if(!isdefined(var_00))
	{
		return undefined;
	}

	var_01 = var_00 maps\mp\_tracking_drone::createtrackingdrone();
	var_00 thread maps\mp\_tracking_drone::starttrackingdrone(var_01);
	return var_01;
}

//Function Number: 169
hordegetcamperdronespawn()
{
	var_00 = common_scripts\utility::array_randomize(level.participants);
	foreach(var_02 in var_00)
	{
		if(!isagent(var_02))
		{
			var_00 = common_scripts\utility::array_remove(var_00,var_02);
			continue;
		}

		var_03 = 1;
		foreach(var_05 in level.players)
		{
			if(spawnsighttrace(var_02,var_02.origin,var_05.origin,0))
			{
				var_03 = 0;
				break;
			}
		}

		if(var_03)
		{
			return var_02;
		}
	}

	if(var_00.size > 0)
	{
		return common_scripts\utility::random(var_00);
	}

	return undefined;
}

//Function Number: 170
camperdroneseektarget(param_00)
{
	level endon("game_ended");
	self endon("death");
	self notify("leaving");
	self setdronegoalpos(param_00,(0,0,72));
	thread handlerdronedetonate(param_00);
	thread hordespawnnanoswarm();
	thread camperdronecancel(param_00,param_00.origin);
	common_scripts\utility::waittill_any_timeout(20,"detonate");
	self stoploopsound();
	self playsound("drone_warning_beap");
	wait(1.4);
	self notify("startSwarm");
	wait 0.05;
	self radiusdamage(self.origin,256,100,25,self,"MOD_EXPLOSIVE");
	thread maps\mp\_tracking_drone::trackingdroneexplode();
}

//Function Number: 171
camperdronecancel(param_00,param_01)
{
	self endon("startSwarm");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(level.currentaliveenemycount) || level.currentaliveenemycount < 1 || maps\mp\gametypes\_horde_util::isplayerinlaststand(param_00) || isdefined(param_00.isspectator) && param_00.isspectator || isdefined(param_00.usingarmory) || param_00 maps\mp\_utility::isusingremote() || isdefined(param_00.isreviving) && param_00.isreviving)
		{
			self notify("cancel_swarm");
			wait 0.05;
			thread maps\mp\_tracking_drone::trackingdroneexplode();
		}

		wait(0.25);
	}
}

//Function Number: 172
hordeexploitclip()
{
	if(maps\mp\_utility::getmapname() == "mp_instinct")
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(236.851,-1405,1016),(0,22.7,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(79,-1339.9,1016),(0,292.7,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(730.1,792.5,1080),(0,241.8,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(681.5,955.9,1080),(0,151.8,0));
	}

	if(maps\mp\_utility::getmapname() == "mp_laser2")
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(526,2476,467),(90,0,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(526,2361,436),(60,90,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(159.5,2473.1,513.5),(70,90,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-102.5,2473.1,513.5),(70,90,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-2336.58,1331.1,936),(0,114.9,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-2162.7,1279.51,936),(0,204.9,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-2232.93,1233.68,936),(0,114.9,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-2059.05,1182.1,936),(0,204.9,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-2135.11,1182.07,936),(0,114.9,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-2047.53,993.406,936),(0,114.9,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-2071.25,885.376,936),(0,114.9,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-2063.75,743.332,936),(0,114.9,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1990.92,909.438,936),(0,204.9,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1998.42,1051.48,936),(0,204.9,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1962.26,1094.72,872),(0,24.9,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-2002.68,1181.8,872),(0,24.9,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-2002.68,1181.8,1000),(0,24.9,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1962.26,1094.72,1000),(0,24.9,0));
	}

	if(maps\mp\_utility::getmapname() == "mp_detroit")
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(147,2272,673),(0,20,0));
	}

	if(maps\mp\_utility::getmapname() == "mp_recovery")
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1200,-1984,32),(0,270,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1456,-1984,32),(0,270,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1712,-1984,32),(0,270,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1200,-1984,288),(0,270,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1456,-1984,288),(0,270,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1712,-1984,288),(0,270,0));
	}

	if(maps\mp\_utility::getmapname() == "mp_venus")
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(496,-2248,384),(0,0,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(496,-2504,384),(0,0,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(496,-2760,384),(0,0,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(496,-2248,640),(0,0,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(496,-2504,640),(0,0,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(496,-2760,640),(0,0,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(496,-2248,896),(0,0,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(496,-2504,896),(0,0,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(496,-2760,896),(0,0,0));
	}

	if(maps\mp\_utility::getmapname() == "mp_prison_z")
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1516,2164,1016),(0,270,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1636,2028,1016),(0,0,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1636,1772,1016),(0,0,0));
	}
}

//Function Number: 173
getwavetable()
{
	var_00 = getdvarint("scr_waveTableVersion");
	var_01 = "mp/hordeWaves.csv";
	switch(var_00)
	{
		case 2:
			var_01 = "mp/hordeWavesV2.csv";
			break;

		case 1:
		default:
			var_01 = "mp/hordeWaves.csv";
			break;
	}

	return var_01;
}

//Function Number: 174
hordeweaponweight(param_00)
{
	var_01 = tablelookup("mp/statstable.csv",4,param_00,8);
	if(!isdefined(var_01) || var_01 == "")
	{
		var_01 = tablelookup("mp/hordeStatsTable.csv",0,param_00,1);
	}

	if(!isdefined(var_01) || var_01 == "")
	{
		var_01 = 4;
	}

	return int(var_01);
}