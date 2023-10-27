/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hodgepodge_ph.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 101
 * Decompile Time: 1760 ms
 * Timestamp: 10/27/2023 2:37:54 AM
*******************************************************************/

//Function Number: 1
ph_init()
{
	if(maps\mp\_utility::invirtuallobby())
	{
		return;
	}

	setupdvars();
	level.objectivebased = 1;
	level.teambased = 1;
	level.onspawnplayer = ::onspawnplayer;
	level.ononeleftevent = ::ononeleftevent;
	level.ontimelimit = ::ontimelimit;
	level.onplayerkilled = ::onplayerkilled;
	level.ondeadevent = ::ondeadevent;
	level.checkforovertime = ::ph_checkforovertime;
	level.customplaydamagesound = ::playdamagesoundph;
	level.customplaydeathsound = ::playdeathsoundph;
	level.modifyplayerdamage = ::gamemodemodifyplayerdamage;
	if(level.madpropsmode)
	{
		if(!isdefined(game["roundsPlayed"]))
		{
			game["roundsPlayed"] = 0;
		}

		level.getspawnpoint = ::getpkspawnpoint;
	}
	else
	{
		level.getspawnpoint = ::getspawnpoint;
		level.bypassclasschoicefunc = ::phclass;
	}

	level.proplist = [];
	level.spawnproplist = [];
	level.abilities = ["FLASH"];
	level.allowlatecomers = 0;
	level.startcheck = 0;
	populateproplist();
	ph_precache();
	initializegametypesettings();
	level.ph_linker = spawn("script_model",(0,0,0));
	level.ph_linker setmodel("tag_player");
	onstartgametype();
	if(!level.madpropsmode)
	{
		level checkmapofflimits();
	}

	level thread stillalivexp();
	level thread watchhostmigration();
	level thread disablejipaftermatchstart();
}

//Function Number: 2
disablejipaftermatchstart()
{
	maps\mp\_utility::gameflagwait("prematch_done");
	setnojiptime(1);
}

//Function Number: 3
setupdvars()
{
	if(level.madpropsmode)
	{
		setdynamicdvar("scr_game_hardpoints",0);
		setdynamicdvar("scr_war_timelimit",4);
		setdynamicdvar("scr_war_scorelimit",0);
		setdynamicdvar("scr_war_roundlimit",4);
		setdynamicdvar("scr_war_winlimit",3);
		setdynamicdvar("scr_war_numlives",4);
		maps\mp\_utility::registerwinlimitdvar("war",3);
		setdynamicdvar("scr_war_roundswitch",1);
		maps\mp\_utility::registerroundswitchdvar("war",1,0,9);
		setdynamicdvar("scr_war_halftime",0);
		return;
	}

	setdynamicdvar("scr_game_hardpoints",0);
	setdynamicdvar("scr_war_timelimit",4);
	setdynamicdvar("scr_war_scorelimit",0);
	setdynamicdvar("scr_war_roundlimit",4);
	setdynamicdvar("scr_war_winlimit",3);
	setdynamicdvar("scr_war_numlives",1);
	maps\mp\_utility::registerwinlimitdvar("war",3);
	setdynamicdvar("scr_war_roundswitch",1);
	maps\mp\_utility::registerroundswitchdvar("war",1,0,9);
	setdynamicdvar("scr_war_halftime",0);
	setdynamicdvar("scr_player_healthregen",0);
	level.roundswitch = getdvarint("scr_war_roundswitch");
	if(maps\mp\_utility::getmapname() == "mp_shipment")
	{
		setdynamicdvar("g_oldschool",1);
		setdynamicdvar("scr_war_timelimit",2.2);
	}
}

//Function Number: 4
watchhostmigration()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("host_migration_begin");
		setupdvars();
		level waittill("host_migration_end");
		setupdvars();
	}
}

//Function Number: 5
ph_precache()
{
	foreach(var_01 in level.proplist)
	{
		precachemodel(var_01.modelname);
	}
}

//Function Number: 6
onprecachegametype()
{
	ph_precache();
}

//Function Number: 7
initializegametypesettings()
{
	var_00 = 29;
	var_01 = 20;
	var_02 = 2;
	var_03 = 29;
	var_04 = 6;
	if(maps\mp\_utility::getmapname() == "mp_shipment")
	{
		var_00 = 11;
		var_02 = 1;
	}

	level.phsettings = spawnstruct();
	level.phsettings.prophidetime = getdvarfloat("scr_ph_propHideTime",var_00);
	if(level.madpropsmode)
	{
		level.madpropssettings = spawnstruct();
		level.madpropssettings.madpropshidetime = getdvarfloat("scr_ph_madpropsHideTime",var_03);
		level.madpropssettings.propinvulntime = getdvarfloat("scr_ph_madpropsInvulnTime",var_04);
		return;
	}

	level.phsettings.propwhistletime = getdvarfloat("scr_ph_propWhistleTime",var_01);
	level.phsettings.propchangecount = getdvarint("scr_ph_propChangeCount",var_02);
}

//Function Number: 8
onstartgametype()
{
	if([[ level.checkforovertime ]]())
	{
		game["status"] = "overtime";
		setdvar("ui_overtime",1);
		setdvar("overtimeTimeLimit",3.5);
	}

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
	else
	{
		level.prematchperiod = 30;
	}

	setspecialloadouts();
	setclientnamemode("manual_change");
	if(level.madpropsmode)
	{
		maps\mp\_utility::setobjectivetext(game["attackers"],&"OBJECTIVES_PK_ATTACKER");
		maps\mp\_utility::setobjectivetext(game["defenders"],&"OBJECTIVES_PK_DEFENDER");
		maps\mp\_utility::setobjectivescoretext(game["attackers"],&"OBJECTIVES_PK_ATTACKER_SCORE");
		maps\mp\_utility::setobjectivescoretext(game["defenders"],&"OBJECTIVES_PK_DEFENDER_SCORE");
		maps\mp\_utility::setobjectivehinttext(game["attackers"],&"OBJECTIVES_PK_ATTACKER_HINT");
		maps\mp\_utility::setobjectivehinttext(game["defenders"],&"OBJECTIVES_PK_DEFENDER_HINT");
	}
	else
	{
		maps\mp\_utility::setobjectivetext(game["attackers"],&"OBJECTIVES_PH_ATTACKER");
		maps\mp\_utility::setobjectivetext(game["defenders"],&"OBJECTIVES_PH_DEFENDER");
		maps\mp\_utility::setobjectivescoretext(game["attackers"],&"OBJECTIVES_PH_ATTACKER_SCORE");
		maps\mp\_utility::setobjectivescoretext(game["defenders"],&"OBJECTIVES_PH_DEFENDER_SCORE");
		maps\mp\_utility::setobjectivehinttext(game["attackers"],&"OBJECTIVES_PH_ATTACKER_HINT");
		maps\mp\_utility::setobjectivehinttext(game["defenders"],&"OBJECTIVES_PH_DEFENDER_HINT");
	}

	if(level.madpropsmode)
	{
		level.spawnmins = (0,0,0);
		level.spawnmaxs = (0,0,0);
		maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
		maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
		maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_tdm_spawn");
		maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_tdm_spawn");
	}
	else
	{
		level.spawnmins = (0,0,0);
		level.spawnmaxs = (0,0,0);
		maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sd_spawn_attacker");
		maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sd_spawn_defender");
	}

	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	var_02[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::main(var_02);
	level._effect["propFlash"] = loadfx("vfx/explosion/flashbang_h1");
	level._effect["propDeathFX"] = loadfx("vfx/explosion/prop_explosion");
	if(!level.madpropsmode)
	{
		level thread setuproundstarthud();
		level thread propwhistle();
		level thread propspectateing();
		level thread hidehudintermission();
	}
	else
	{
		level.propsinvuln = 1;
		level thread setupmadpropsstarthud();
	}

	level thread monitortimers();
	level thread deleteallglass();
	level thread setphteamscores();
}

//Function Number: 9
setspecialloadouts()
{
	if(level.madpropsmode)
	{
		var_00 = game["defenders"];
		level.ph_loadouts[var_00] = maps\mp\gametypes\_class::getemptyloadout();
		level.ph_loadouts[var_00]["loadoutPrimary"] = "h1_ak47";
		level.ph_loadouts[var_00]["loadoutPerks"] = ["specialty_null","specialty_null","specialty_longersprint"];
		level.ph_loadouts[var_00]["loadoutEquipment"] = "h1_fraggrenade_mp";
		level.ph_loadouts[var_00]["loadoutOffhand"] = "h1_flashgrenade_mp";
		return;
	}

	var_00 = game["defenders"];
	level.ph_loadouts[var_00] = maps\mp\gametypes\_class::getemptyloadout();
	level.ph_loadouts[var_00]["loadoutPrimary"] = "h1_ak47";
	level.ph_loadouts[var_00]["loadoutPerks"] = ["specialty_null","specialty_null","specialty_quieter"];
	level.ph_loadouts[var_00]["loadoutEquipment"] = "h1_fraggrenade_mp";
	level.ph_loadouts[var_00]["loadoutOffhand"] = "h1_flashgrenade_mp";
	if(maps\mp\_utility::getmapname() == "mp_shipment")
	{
		var_01 = game["attackers"];
		level.ph_loadouts[var_01] = maps\mp\gametypes\_class::getemptyloadout();
		level.ph_loadouts[var_01]["loadoutSecondary"] = "h1_deserteagle";
		level.ph_loadouts[var_01]["loadoutPrimary"] = "h1_p90";
		level.ph_loadouts[var_01]["loadoutPerks"] = ["rpg_mp","specialty_null","specialty_null"];
		level.ph_loadouts[var_01]["loadoutEquipment"] = "h1_fraggrenade_mp";
		level.ph_loadouts[var_01]["loadoutOffhand"] = "h1_concussiongrenade_mp";
		return;
	}

	var_01 = game["attackers"];
	level.ph_loadouts[var_01] = maps\mp\gametypes\_class::getemptyloadout();
	level.ph_loadouts[var_01]["loadoutSecondary"] = "h1_deserteagle";
	level.ph_loadouts[var_01]["loadoutPrimary"] = "h1_p90";
	level.ph_loadouts[var_01]["loadoutEquipment"] = "h1_fraggrenade_mp";
	level.ph_loadouts[var_01]["loadoutOffhand"] = "h1_concussiongrenade_mp";
}

//Function Number: 10
phclass()
{
	self.pers["class"] = "gamemode";
	self.pers["lastClass"] = "";
	self.pers["gamemodeLoadout"] = level.ph_loadouts[self.pers["team"]];
	self.class = self.pers["class"];
	self.lastclass = self.pers["lastClass"];
}

//Function Number: 11
getspawnpoint()
{
	if(self.pers["team"] == game["attackers"])
	{
		var_00 = "mp_sd_spawn_attacker";
	}
	else
	{
		var_00 = "mp_sd_spawn_defender";
	}

	var_01 = maps\mp\gametypes\_spawnlogic::getspawnpointarray(var_00);
	var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_01);
	return var_02;
}

//Function Number: 12
getpkspawnpoint()
{
	var_00 = self.pers["team"];
	if(game["roundsPlayed"] >= 2)
	{
		var_00 = maps\mp\_utility::getotherteam(var_00);
	}

	if(level.usestartspawns && level.ingraceperiod)
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getbeststartspawn("mp_tdm_spawn_" + var_00 + "_start");
	}
	else
	{
		var_02 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_01);
		var_01 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(var_02,var_00);
	}

	maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_01);
	return var_01;
}

//Function Number: 13
propspectateing()
{
	level endon("game_ended");
	level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
	maps\mp\gametypes\_spectating::updatespectatesettings();
}

//Function Number: 14
setupkeybindings()
{
	if(level.madpropsmode)
	{
		self notifyonplayercommand("explode","+attack");
		self notifyonplayercommand("explode","+attack_akimbo_accessible");
		self notifyonplayercommand("zoomin","+actionslot 3");
		self notifyonplayercommand("zoomout","+actionslot 4");
		return;
	}

	self notifyonplayercommand("lock","+attack");
	self notifyonplayercommand("lock","+attack_akimbo_accessible");
	self notifyonplayercommand("spin","+toggleads_throw");
	self notifyonplayercommand("spin","+speed_throw");
	self notifyonplayercommand("spin","+speed");
	self notifyonplayercommand("spin","+ads_akimbo_accessible");
	self notifyonplayercommand("changeProp","weapnext");
	self notifyonplayercommand("setToSlope","+usereload");
	self notifyonplayercommand("setToSlope","+activate");
	self notifyonplayercommand("propAbility","+smoke");
	self notifyonplayercommand("zoomin","+actionslot 3");
	self notifyonplayercommand("zoomout","+actionslot 4");
}

//Function Number: 15
propcontrolshud()
{
	level endon("game_ended");
	self endon("disconnect");
	var_00 = 26;
	self.propchangecounter = maps\mp\gametypes\_hud_util::createfontstring("objective",0.9);
	self.propchangecounter.label = &"MP_PH_CHANGESLEFT";
	self.propchangecounter setvalue(0);
	self.propchangecounter.x = -5;
	self.propchangecounter.y = var_00;
	self.propchangecounter.alignx = "right";
	self.propchangecounter.aligny = "top";
	self.propchangecounter.horzalign = "right_adjustable";
	self.propchangecounter.vertalign = "top_adjustable";
	self.propchangecounter.archived = 1;
	self.propchangecounter.fontscale = 1;
	self.propchangecounter.alpha = 1;
	self.propchangecounter.glowalpha = 0;
	self.propchangecounter.hidewheninmenu = 0;
	var_00 = var_00 + 12;
	self.changepropkey = maps\mp\gametypes\_hud_util::createfontstring("objective",0.9);
	self.changepropkey.label = &"MP_PH_CHANGE";
	self.changepropkey.x = -5;
	self.changepropkey.y = var_00;
	self.changepropkey.alignx = "right";
	self.changepropkey.aligny = "top";
	self.changepropkey.horzalign = "right_adjustable";
	self.changepropkey.vertalign = "top_adjustable";
	self.changepropkey.archived = 1;
	self.changepropkey.fontscale = 1;
	self.changepropkey.alpha = 1;
	self.changepropkey.glowalpha = 0;
	self.changepropkey.hidewheninmenu = 0;
	var_00 = var_00 + 12;
	self.lockpropkey = maps\mp\gametypes\_hud_util::createfontstring("objective",0.9);
	self.lockpropkey.label = &"MP_PH_LOCK";
	self.lockpropkey.x = -5;
	self.lockpropkey.y = var_00;
	self.lockpropkey.alignx = "right";
	self.lockpropkey.aligny = "top";
	self.lockpropkey.horzalign = "right_adjustable";
	self.lockpropkey.vertalign = "top_adjustable";
	self.lockpropkey.archived = 1;
	self.lockpropkey.fontscale = 1;
	self.lockpropkey.alpha = 1;
	self.lockpropkey.glowalpha = 0;
	self.lockpropkey.hidewheninmenu = 0;
	var_00 = var_00 + 12;
	self.matchslopekey = maps\mp\gametypes\_hud_util::createfontstring("objective",0.9);
	if(common_scripts\utility::is_player_gamepad_enabled())
	{
		self.matchslopekey.label = &"MP_PH_SLOPE";
	}
	else
	{
		self.matchslopekey.label = &"MP_PH_SLOPE_PC";
	}

	self.matchslopekey.x = -5;
	self.matchslopekey.y = var_00;
	self.matchslopekey.alignx = "right";
	self.matchslopekey.aligny = "top";
	self.matchslopekey.horzalign = "right_adjustable";
	self.matchslopekey.vertalign = "top_adjustable";
	self.matchslopekey.archived = 1;
	self.matchslopekey.fontscale = 1;
	self.matchslopekey.alpha = 1;
	self.matchslopekey.glowalpha = 0;
	self.matchslopekey.hidewheninmenu = 0;
	var_00 = var_00 + 12;
	self.abilitykey = maps\mp\gametypes\_hud_util::createfontstring("objective",0.9);
	setnewabilityhud();
	self.abilitykey.x = -5;
	self.abilitykey.y = var_00;
	self.abilitykey.alignx = "right";
	self.abilitykey.aligny = "top";
	self.abilitykey.horzalign = "right_adjustable";
	self.abilitykey.vertalign = "top_adjustable";
	self.abilitykey.archived = 1;
	self.abilitykey.fontscale = 1;
	self.abilitykey.alpha = 1;
	self.abilitykey.glowalpha = 0;
	self.abilitykey.hidewheninmenu = 0;
	thread updatetextongamepadchange();
}

//Function Number: 16
pkcontrolshud()
{
	level endon("game_ended");
	self endon("disconnect");
	var_00 = 38;
	self.pkexplodekey = maps\mp\gametypes\_hud_util::createfontstring("objective",0.9);
	self.pkexplodekey.label = &"MP_PK_EXPLODELKEY";
	self.pkexplodekey.x = -5;
	self.pkexplodekey.y = var_00;
	self.pkexplodekey.alignx = "right";
	self.pkexplodekey.aligny = "top";
	self.pkexplodekey.horzalign = "right_adjustable";
	self.pkexplodekey.vertalign = "top_adjustable";
	self.pkexplodekey.archived = 1;
	self.pkexplodekey.fontscale = 1;
	self.pkexplodekey.alpha = 0;
	self.pkexplodekey.glowalpha = 0;
	self.pkexplodekey.hidewheninmenu = 0;
	var_00 = var_00 + 12;
	self.pklivesleft = maps\mp\gametypes\_hud_util::createfontstring("objective",0.9);
	self.pklivesleft.label = &"MP_PK_LIVESLEFT";
	self.pklivesleft setvalue(3);
	self.pklivesleft.x = -5;
	self.pklivesleft.y = var_00;
	self.pklivesleft.alignx = "right";
	self.pklivesleft.aligny = "top";
	self.pklivesleft.horzalign = "right_adjustable";
	self.pklivesleft.vertalign = "top_adjustable";
	self.pklivesleft.archived = 1;
	self.pklivesleft.fontscale = 1;
	self.pklivesleft.alpha = 1;
	self.pklivesleft.glowalpha = 0;
	self.pklivesleft.hidewheninmenu = 0;
}

//Function Number: 17
updatetextongamepadchange()
{
	level endon("game_ended");
	self endon("disconnect");
	if(level.console)
	{
		return;
	}

	var_00 = common_scripts\utility::is_player_gamepad_enabled();
	for(;;)
	{
		var_01 = common_scripts\utility::is_player_gamepad_enabled();
		if(var_01 != var_00)
		{
			var_00 = var_01;
			if(var_01)
			{
				if(!maps\mp\_utility::is_true(self.slopelocked))
				{
					self.matchslopekey.label = &"MP_PH_SLOPE";
				}
				else
				{
					self.matchslopekey.label = &"MP_PH_SLOPED";
				}
			}
			else if(!maps\mp\_utility::is_true(self.slopelocked))
			{
				self.matchslopekey.label = &"MP_PH_SLOPE_PC";
			}
			else
			{
				self.matchslopekey.label = &"MP_PH_SLOPED_PC";
			}
		}

		wait 0.05;
	}
}

//Function Number: 18
setuproundstarthud()
{
	level.phcountdowntimer = maps\mp\gametypes\_hud_util::createservertimer("objective",1.4);
	level.phcountdowntimer maps\mp\gametypes\_hud_util::setpoint("CENTER",undefined,0,50);
	level.phcountdowntimer.label = &"MP_PH_STARTS_IN";
	level.phcountdowntimer.alpha = 0;
	level.phcountdowntimer.archived = 0;
	level.phcountdowntimer.hidewheninmenu = 1;
	level.phcountdowntimer.sort = 1;
	level.phwhistletimer = maps\mp\gametypes\_hud_util::createservertimer("objective",0.9);
	level.phwhistletimer.x = -6;
	level.phwhistletimer.y = 2;
	level.phwhistletimer.alignx = "right";
	level.phwhistletimer.aligny = "top";
	level.phwhistletimer.horzalign = "right_adjustable";
	level.phwhistletimer.vertalign = "top_adjustable";
	level.phwhistletimer.label = &"MP_PH_WHISTILE_IN";
	level.phwhistletimer.alpha = 0;
	level.phwhistletimer.archived = 0;
	level.phwhistletimer.hidewheninmenu = 1;
	level.phwhistletimer settimer(120);
	level.whistling = maps\mp\gametypes\_hud_util::createserverfontstring("objective",1);
	level.whistling.label = &"MP_PH_WHISTLING";
	level.whistling.x = -5;
	level.whistling.y = 2;
	level.whistling.alignx = "right";
	level.whistling.aligny = "top";
	level.whistling.horzalign = "right_adjustable";
	level.whistling.vertalign = "top_adjustable";
	level.whistling.archived = 1;
	level.whistling.alpha = 0;
	level.whistling.glowalpha = 0.2;
	level.whistling.hidewheninmenu = 0;
	if(!isdefined(level.elim_hud))
	{
		level.elim_hud = [];
	}

	level.elim_hud = maps\mp\gametypes\_hud_util::createserverfontstring("objective",0.9);
	level.elim_hud.label = &"MP_PH_ALIVE";
	level.elim_hud setvalue(0);
	level.elim_hud.x = -5;
	level.elim_hud.y = 14;
	level.elim_hud.alignx = "right";
	level.elim_hud.aligny = "top";
	level.elim_hud.horzalign = "right_adjustable";
	level.elim_hud.vertalign = "top_adjustable";
	level.elim_hud.archived = 1;
	level.elim_hud.fontscale = 1;
	level.elim_hud.alpha = 1;
	level.elim_hud.glowalpha = 0;
	level.elim_hud.hidewheninmenu = 0;
	level thread eliminatedhudmonitor();
}

//Function Number: 19
setupmadpropsstarthud()
{
	if(!isdefined(level.elim_hud))
	{
		level.elim_hud = [];
	}

	level.elim_hud = maps\mp\gametypes\_hud_util::createserverfontstring("objective",0.9);
	level.elim_hud.label = &"MP_PK_ALIVE";
	level.elim_hud setvalue(0);
	level.elim_hud.x = -5;
	level.elim_hud.y = 14;
	level.elim_hud.alignx = "right";
	level.elim_hud.aligny = "top";
	level.elim_hud.horzalign = "right_adjustable";
	level.elim_hud.vertalign = "top_adjustable";
	level.elim_hud.archived = 1;
	level.elim_hud.fontscale = 1;
	level.elim_hud.alpha = 1;
	level.elim_hud.glowalpha = 0;
	level.elim_hud.hidewheninmenu = 0;
	if(!isdefined(level.elim_hud_humans))
	{
		level.elim_hud_humans = [];
	}

	level.elim_hud_humans = maps\mp\gametypes\_hud_util::createserverfontstring("objective",0.9);
	level.elim_hud_humans.label = &"MP_PK_HUMANSALIVE";
	level.elim_hud_humans setvalue(0);
	level.elim_hud_humans.x = -5;
	level.elim_hud_humans.y = 26;
	level.elim_hud_humans.alignx = "right";
	level.elim_hud_humans.aligny = "top";
	level.elim_hud_humans.horzalign = "right_adjustable";
	level.elim_hud_humans.vertalign = "top_adjustable";
	level.elim_hud_humans.archived = 1;
	level.elim_hud_humans.fontscale = 1;
	level.elim_hud_humans.alpha = 1;
	level.elim_hud_humans.glowalpha = 0;
	level.elim_hud_humans.hidewheninmenu = 0;
	level thread eliminatedhudmonitor();
	level.phcountdowntimer = maps\mp\gametypes\_hud_util::createservertimer("objective",1.4);
	level.phcountdowntimer maps\mp\gametypes\_hud_util::setpoint("CENTER",undefined,0,50);
	level.phcountdowntimer.label = &"MP_PK_STARTS_IN";
	level.phcountdowntimer.alpha = 0;
	level.phcountdowntimer.archived = 0;
	level.phcountdowntimer.hidewheninmenu = 1;
	level.phcountdowntimer.sort = 1;
	level.pkinvuln = maps\mp\gametypes\_hud_util::createservertimer("objective",1.4);
	level.pkinvuln maps\mp\gametypes\_hud_util::setpoint("CENTER",undefined,0,50);
	level.pkinvuln.label = &"MP_PK_PROPSINVULN";
	level.pkinvuln.alpha = 0;
	level.pkinvuln.archived = 0;
	level.pkinvuln.hidewheninmenu = 1;
	level.pkinvuln.sort = 1;
}

//Function Number: 20
eliminatedhudmonitor()
{
	level endon("game_ended");
	for(;;)
	{
		if(level.madpropsmode)
		{
			var_00 = get_alive_nonspecating_players(game["attackers"]);
			level.elim_hud_humans setvalue(var_00.size);
		}

		var_01 = get_alive_nonspecating_players(game["defenders"]);
		level.elim_hud setvalue(var_01.size);
		level common_scripts\utility::waittill_any("player_spawned","player_killed","player_eliminated","playerCountChanged","propCountChanged");
	}
}

//Function Number: 21
get_alive_nonspecating_players(param_00)
{
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(isdefined(var_03) && isalive(var_03) && !isdefined(var_03.sessionstate) || var_03.sessionstate == "playing")
		{
			if(!isdefined(param_00) || var_03.team == param_00)
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 22
weaponusagecheck()
{
	var_00 = common_scripts\utility::waittill_any_return("weapon_fired","sprint_begin","specialGrenade","end_weapon_check_usage");
	if(var_00 == "end_weapon_check_usage")
	{
		if(maps\mp\_utility::is_true(self.hashitplayer))
		{
			return 1;
		}

		kick(self getentitynumber(),"EXE_PLAYERKICKED_INACTIVE");
		return 0;
	}

	return 1;
}

//Function Number: 23
positioncheck(param_00,param_01)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	if(!isdefined(param_00))
	{
		param_00 = 45;
	}

	if(!isdefined(param_01))
	{
		param_01 = 300;
	}

	var_02 = self.origin;
	var_03 = squared(param_01);
	var_04 = 0;
	for(var_05 = 0;var_05 < param_00;var_05++)
	{
		if(!var_04)
		{
			var_06 = distancesquared(var_02,self.origin);
			if(var_06 >= var_03)
			{
				var_04 = 1;
			}
		}

		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
	}

	if(var_04)
	{
		return 1;
	}

	return 0;
}

//Function Number: 24
startcheck()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self.doingcheck = 1;
	maps\mp\_utility::gameflagwait("prematch_done");
	while(!level.startcheck)
	{
		wait(1);
	}

	if(!level.madpropsmode)
	{
		childthread weaponusagecheck();
	}

	if(!positioncheck(45,300))
	{
		if(maps\mp\_utility::is_true(self.hashitplayer))
		{
			return;
		}

		kick(self getentitynumber(),"EXE_PLAYERKICKED_INACTIVE");
		return;
	}

	if(!positioncheck(75,150))
	{
		if(maps\mp\_utility::is_true(self.hashitplayer))
		{
			return;
		}

		kick(self getentitynumber(),"EXE_PLAYERKICKED_INACTIVE");
		return;
	}

	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(30);
	self notify("end_weapon_check_usage");
}

//Function Number: 25
onconnect()
{
	if(level.madpropsmode)
	{
		thread watchthrownflash();
	}

	thread attackerswaittime();
}

//Function Number: 26
onspawnplayer()
{
	self.breathingstoptime = 0;
	if(self.team == game["defenders"])
	{
		if(level.madpropsmode)
		{
			self.concussionimmune = 1;
			self.flashimmune = 1;
			thread handleprop();
			thread updateprop();
			if(!isdefined(self.pkexplodekey))
			{
				thread pkcontrolshud();
			}

			if(!isdefined(self.doingcheck))
			{
				thread startcheck();
			}

			self disableoffhandweapons();
			return;
		}

		self.concussionimmune = 1;
		setownedtaunt();
		self.isangleoffset = 0;
		self.changesleft = int(level.phsettings.propchangecount);
		if(!isdefined(self.pers["ability"]))
		{
			self.pers["ability"] = 0;
		}

		self.currentability = level.abilities[self.pers["ability"]];
		self.abilitylocked = 0;
		setnewabilitycount();
		thread playerlastvalidpositionwatch();
		thread propcontrolshud();
		thread handleprop();
		thread updateprop();
		return;
	}

	if(level.madpropsmode)
	{
		self.pers["lives"] = 0;
		level.livescount[self.team] = 0;
		return;
	}

	if(!isdefined(self.hasthrownspecial))
	{
		self.hasthrownspecial = 0;
	}

	thread givecustomloadout();
	if(!isdefined(self.doingcheck))
	{
		thread startcheck();
		return;
	}
}

//Function Number: 27
playerlastvalidpositionwatch()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("stop_watch_last_valid_pos");
	self.lastvalidpos = undefined;
	self.lastnodeinsight = undefined;
	for(;;)
	{
		var_00 = playerphysicstraceinfo(self.origin,self.origin + (0,0,1),self);
		if(var_00["fraction"] == 1)
		{
			self.lastvalidpos = self.origin;
		}

		var_01 = getclosestnodeinsight(self.origin);
		if(isdefined(var_01))
		{
			self.lastnodeinsight = var_01;
		}

		wait 0.05;
	}
}

//Function Number: 28
monitortimers()
{
	level endon("game_ended");
	maps\mp\_utility::gameflagwait("prematch_done");
	if(level.madpropsmode)
	{
		level thread pausepktimerformigration();
		level.phcountdowntimer settimer(level.madpropssettings.madpropshidetime);
		level.phcountdowntimer.alpha = 1;
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(level.madpropssettings.madpropshidetime);
	}
	else
	{
		level thread pausephtimerformigration();
		level.phcountdowntimer settimer(level.phsettings.prophidetime);
		level.phcountdowntimer.alpha = 1;
		level.phwhistletimer settimer(level.phsettings.propwhistletime + level.phsettings.prophidetime);
		level.phwhistletimer.alpha = 1;
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(level.phsettings.prophidetime);
	}

	level notify("props_hide_over");
	if(!level.madpropsmode)
	{
		level.phwhistletimer.alpha = 1;
		level.phcountdowntimer.alpha = 0;
		foreach(var_01 in level.players)
		{
			if(isdefined(var_01.abilitylocked))
			{
				var_01.abilitylocked = 1;
			}
		}

		return;
	}

	level.phcountdowntimer.alpha = 0;
	level.pkinvuln settimer(level.madpropssettings.propinvulntime);
	level.pkinvuln.alpha = 1;
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(level.madpropssettings.propinvulntime);
	level.pkinvuln.alpha = 0;
	level.propsinvuln = 0;
	foreach(var_01 in level.players)
	{
		if(var_01.team == game["defenders"] && isdefined(var_01.pkexplodekey) && maps\mp\_utility::isreallyalive(var_01))
		{
			var_01.concussionimmune = 0;
			var_01.flashimmune = 0;
			var_01.pkexplodekey.alpha = 1;
		}
	}
}

//Function Number: 29
pausephtimerformigration()
{
	level endon("game_ended");
	level endon("props_hide_over");
	var_00 = int(level.phsettings.prophidetime + gettime() / 1000);
	var_01 = 0;
	for(;;)
	{
		level waittill("host_migration_begin");
		level.phcountdowntimer.alpha = 0;
		level.phwhistletimer.alpha = 0;
		var_02 = int(maps\mp\gametypes\_hostmigration::waittillhostmigrationdone() / 1000);
		var_01 = var_01 + var_02;
		var_02 = var_01;
		var_03 = var_00 + var_02 - int(gettime() / 1000);
		level.phcountdowntimer settimer(var_03);
		level.phwhistletimer settimer(level.phsettings.propwhistletime + var_03);
		level.phcountdowntimer.alpha = 1;
		level.phwhistletimer.alpha = 1;
	}
}

//Function Number: 30
pausepktimerformigration()
{
	level endon("game_ended");
	level endon("props_hide_over");
	var_00 = int(level.madpropssettings.madpropshidetime + gettime() / 1000);
	var_01 = 0;
	for(;;)
	{
		level waittill("host_migration_begin");
		level.pkcountdowntimer.alpha = 0;
		var_02 = int(maps\mp\gametypes\_hostmigration::waittillhostmigrationdone() / 1000);
		var_01 = var_01 + var_02;
		var_02 = var_01;
		var_03 = var_00 + var_02 - int(gettime() / 1000);
		level.pkcountdowntimer settimer(var_03);
		level.pkcountdowntimer.alpha = 1;
	}
}

//Function Number: 31
setownedtaunt()
{
	var_00 = "prop_whistle_01";
	self.playtaunt = var_00;
}

//Function Number: 32
handleprop()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("applyLoadout");
		if(level.madpropsmode)
		{
			self takeallweapons();
			if(!isdefined(self.prop))
			{
				thread setupmadprops();
			}

			continue;
		}

		self takeallweapons();
		self allowsprint(0);
		self allowspectateteam(game["attackers"],1);
		self setmovespeedscale(1.5);
		if(!isdefined(self.prop))
		{
			thread setupprop();
		}
	}
}

//Function Number: 33
setupprop()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = common_scripts\utility::random(level.proplist);
	self playerhide(1);
	self.propanchor = spawn("script_model",self.origin);
	self.propanchor method_8442(self);
	self.propanchor method_8581();
	self.propanchor setcontents(0);
	self.propent = spawn("script_model",self.origin);
	self.propent method_8442(self.propanchor);
	self.propent method_8581();
	self.propent setcontents(0);
	self.prop = spawn("script_model",self.propent.origin);
	self.prop setmodel(var_00.modelname);
	self.prop setcandamage(1);
	self.prop.xyzoffset = var_00.xyzoffset;
	self.prop.anglesoffset = var_00.anglesoffset;
	self.prop.angles = self.angles;
	applyxyzoffset();
	applyanglesoffset();
	self.prop method_8442(self.propent);
	self.prop method_8581();
	self.prop.owner = self;
	self.prop.health = 10000;
	self.prop method_8491(1);
	self.prop.info = var_00;
	self.health = var_00.propsize;
	self.maxhealth = self.health;
	thread setupkeybindings();
	thread setupdamage();
	childthread proplockwatch();
	thread propwatchdeath();
	thread propwatchdeletedisconnect();
	thread propwatchdeleteroundend();
	self notify("propSetup");
}

//Function Number: 34
setupmadprops()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = common_scripts\utility::random(level.proplist);
	self playerhide(1);
	self.propanchor = spawn("script_model",self.origin);
	self.propanchor method_8442(self);
	self.propanchor method_8581();
	self.propanchor setcontents(0);
	self.propent = spawn("script_model",self.origin);
	self.propent method_8442(self.propanchor);
	self.propent method_8581();
	self.propent setcontents(0);
	self.prop = spawn("script_model",self.propent.origin);
	self.prop setmodel(var_00.modelname);
	self.prop setcandamage(1);
	self.prop.xyzoffset = var_00.xyzoffset;
	self.prop.anglesoffset = var_00.anglesoffset;
	self.prop.angles = self.angles;
	applyxyzoffset();
	applyanglesoffset();
	self.prop method_8442(self.propent);
	self.prop method_8581();
	self.prop.owner = self;
	self.prop.health = 10000;
	self.prop method_8491(1);
	self.prop.info = var_00;
	self.health = var_00.propsize;
	self.maxhealth = self.health;
	thread setupkeybindings();
	thread setupdamage();
	childthread madpropswatch();
	thread propwatchdeath();
	thread propwatchdeletedisconnect();
	thread propwatchdeleteroundend();
	self notify("propSetup");
}

//Function Number: 35
applyxyzoffset()
{
	if(!isdefined(self.prop.xyzoffset))
	{
		return;
	}

	self.prop.angles = self.angles;
	var_00 = anglestoforward(self.prop.angles) * self.prop.xyzoffset[0];
	var_01 = anglestoright(self.prop.angles) * self.prop.xyzoffset[1];
	var_02 = anglestoup(self.prop.angles) * self.prop.xyzoffset[2];
	self.prop.origin = self.prop.origin + var_00;
	self.prop.origin = self.prop.origin + var_01;
	self.prop.origin = self.prop.origin + var_02;
}

//Function Number: 36
applyanglesoffset()
{
	if(!isdefined(self.prop.anglesoffset))
	{
		return;
	}

	self.prop.angles = self.angles;
	self.prop.angles = self.prop.angles + self.prop.anglesoffset;
	self.isangleoffset = 1;
}

//Function Number: 37
propwhistle()
{
	level endon("game_ended");
	maps\mp\_utility::gameflagwait("prematch_done");
	var_00 = gettime();
	var_01 = level.phsettings.propwhistletime * 1000;
	var_02 = var_01;
	var_03 = 5000;
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(level.phsettings.prophidetime + level.phsettings.propwhistletime);
	for(;;)
	{
		if(var_00 + var_01 < gettime())
		{
			foreach(var_05 in level.players)
			{
				if(!isdefined(var_05))
				{
					continue;
				}

				level.phwhistletimer.alpha = 0;
				level.whistling.alpha = 0.6;
				if(var_05.team == game["defenders"] && isalive(var_05))
				{
					level.whistling.alpha = 1;
					level.whistling fadeovertime(0.75);
					level.whistling.alpha = 0.6;
					playsoundatpos(var_05.origin,var_05.playtaunt);
					maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1.5);
				}
			}

			var_00 = gettime();
			if(var_02 >= maps\mp\gametypes\_gamelogic::gettimeremaining() - var_03)
			{
				level.whistling.alpha = 0;
				return;
			}
			else
			{
				if(var_02 * 2 + getteamplayersalive(game["defenders"]) * 2500 >= maps\mp\gametypes\_gamelogic::gettimeremaining() - var_03)
				{
					level.phwhistletimer.label = &"MP_PH_FINAL_WHISTLE";
					var_02 = var_02 + getteamplayersalive(game["defenders"]) * 2500;
				}

				level.phwhistletimer settimer(int(var_01 / 1000));
				level.whistling.alpha = 0;
				level.phwhistletimer.alpha = 1;
			}
		}

		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
	}
}

//Function Number: 38
getlivingplayersonteam(param_00)
{
	var_01 = [];
	foreach(var_03 in level.participants)
	{
		if(!isdefined(var_03.team))
		{
			continue;
		}

		if(maps\mp\_utility::isreallyalive(var_03) && maps\mp\_utility::isteamparticipant(var_03) && var_03.team == param_00)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 39
createpropspeclist()
{
	self.spectatableprops = getlivingplayersonteam(game["defenders"]);
}

//Function Number: 40
proplockwatch()
{
	if(isbot(self))
	{
		return;
	}

	self.lock = 0;
	self.slopelocked = 0;
	var_00 = level.proplist;
	self.propchangecounter setvalue(self.changesleft);
	maps\mp\_utility::gameflagwait("prematch_done");
	childthread propmoveunlock();
	childthread propcamerazoom();
	self.propspectating = 0;
	self.endingpropspecate = 0;
	var_01 = 1;
	for(;;)
	{
		var_02 = common_scripts\utility::waittill_any_return("lock","spin","changeProp","setToSlope","propAbility");
		if(!isdefined(var_02))
		{
			continue;
		}

		if(self.propspectating)
		{
			continue;
		}

		if(self.endingpropspecate)
		{
			continue;
		}

		if(var_02 == "lock")
		{
			if(self ismantling())
			{
				continue;
			}

			if(self.lock)
			{
				unlockprop();
			}
			else
			{
				lockprop();
			}

			continue;
		}

		if(var_02 == "spin")
		{
			self.propent unlink();
			self.propent.angles = self.propent.angles + (0,45,0);
			self.propent.origin = self.propanchor.origin;
			if(self.slopelocked && maps\mp\_utility::is_true(self.lock))
			{
				self.propent set_pitch_roll_for_ground_normal(self.prop);
			}

			self.propent method_8442(self.propanchor);
			continue;
		}

		if(var_02 == "changeProp")
		{
			if(var_00.size == 1)
			{
				var_00 = level.proplist;
			}

			if(self.changesleft > 0)
			{
				self notify("changed_prop");
				var_00 = common_scripts\utility::array_remove(var_00,self.prop.info);
				self.prop.info = common_scripts\utility::random(var_00);
				self.prop setmodel(self.prop.info.modelname);
				self.prop.xyzoffset = self.prop.info.xyzoffset;
				self.prop.anglesoffset = self.prop.info.anglesoffset;
				self.prop unlink();
				self.propent unlink();
				self.propent.origin = self.propanchor.origin;
				self.prop.origin = self.propent.origin;
				self.propent.angles = (self.angles[0],self.propent.angles[1],self.angles[2]);
				self.prop.angles = self.propent.angles;
				if(maps\mp\_utility::is_true(self.isangleoffset))
				{
					self.prop.angles = self.angles;
					self.isangleoffset = 0;
				}

				applyxyzoffset();
				applyanglesoffset();
				self.prop method_8442(self.propent);
				if(self.slopelocked && maps\mp\_utility::is_true(self.lock))
				{
					self.propent set_pitch_roll_for_ground_normal(self.prop);
				}

				self.propent method_8442(self.propanchor);
				var_03 = self.health / self.maxhealth;
				self.maxhealth = int(self.prop.info.propsize);
				self.health = int(self.prop.info.propsize * var_03);
				setnewabilitycount();
				self.abilitykey.alpha = 1;
				self.changesleft--;
				self.propchangecounter setvalue(self.changesleft);
				if(self.changesleft <= 0)
				{
					self.changepropkey.alpha = 0;
				}
			}

			continue;
		}

		if(var_02 == "setToSlope")
		{
			if(!maps\mp\_utility::is_true(self.slopelocked))
			{
				self.slopelocked = 1;
				if(maps\mp\_utility::is_true(self.lock))
				{
					self.propent unlink();
					self.propent set_pitch_roll_for_ground_normal(self.prop);
					self.propent linkto(self.propanchor);
				}

				if(common_scripts\utility::is_player_gamepad_enabled())
				{
					self.matchslopekey.label = &"MP_PH_SLOPED";
				}
				else
				{
					self.matchslopekey.label = &"MP_PH_SLOPED_PC";
				}
			}
			else
			{
				self.slopelocked = 0;
				if(maps\mp\_utility::is_true(self.lock))
				{
					self.propent unlink();
					self.propent.angles = (self.angles[0],self.prop.angles[1],self.angles[2]);
					self.propent.origin = self.propanchor.origin;
					self.propent method_8442(self.propanchor);
				}

				if(common_scripts\utility::is_player_gamepad_enabled())
				{
					self.matchslopekey.label = &"MP_PH_SLOPE";
				}
				else
				{
					self.matchslopekey.label = &"MP_PH_SLOPE_PC";
				}
			}

			continue;
		}

		if(var_02 == "propAbility")
		{
			if(!self.abilitylocked)
			{
				self.abilitylocked = 1;
			}

			if(self.abilityleft > 0)
			{
				thread useability();
				if(self.abilityleft <= 0)
				{
					self.abilitykey.alpha = 0;
				}
			}
		}
	}
}

//Function Number: 41
madpropswatch()
{
	self endon("death");
	level endon("game_ended");
	if(isbot(self))
	{
		return;
	}

	maps\mp\_utility::gameflagwait("prematch_done");
	childthread propcamerazoom();
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return("explode");
		if(!isdefined(var_00))
		{
			continue;
		}

		if(level.propsinvuln)
		{
			continue;
		}

		self playsound("prop_whistle_01");
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
		if(var_00 == "explode")
		{
			magicgrenademanual("h1_fraggrenade_mp",self.origin + (0,0,5),(0,0,0),0,self,1);
			self suicide();
		}
	}
}

//Function Number: 42
set_pitch_roll_for_ground_normal(param_00)
{
	if(!isdefined(param_00))
	{
		var_01 = self;
	}
	else
	{
		var_01 = var_01;
	}

	var_02 = bullettrace(self.origin + (0,0,4),self.origin + (0,0,-16),0,var_01,1,0,0,0,0,0,0);
	if(var_02["fraction"] >= 1)
	{
		return;
	}

	var_03 = var_02["normal"];
	var_04 = anglestoforward(self.angles);
	var_05 = anglestoright(self.angles);
	var_06 = vectortoangles(var_03);
	var_07 = angleclamp180(var_06[0] + 90);
	var_06 = (0,var_06[1],0);
	var_08 = anglestoforward(var_06);
	var_09 = vectordot(var_08,var_05);
	if(var_09 < 0)
	{
		var_09 = -1;
	}
	else
	{
		var_09 = 1;
	}

	var_0A = vectordot(var_08,var_04);
	var_0B = var_0A * var_07;
	var_0C = 1 - abs(var_0A) * var_07 * var_09;
	self.angles = (var_0B,self.angles[1],var_0C);
}

//Function Number: 43
propmoveunlock()
{
	for(;;)
	{
		wait 0.05;
		var_00 = self getnormalizedmovement();
		if(!isdefined(var_00))
		{
			continue;
		}

		if(self.propspectating)
		{
			continue;
		}

		if(self.lock && var_00[0] != 0 || var_00[1] != 0)
		{
			unlockprop();
		}
	}
}

//Function Number: 44
allowmove(param_00)
{
	if(param_00)
	{
		self playerlinkto(level.ph_linker,"tag_player");
		return;
	}

	self unlink();
}

//Function Number: 45
unlockprop()
{
	self unlink();
	if(self.slopelocked)
	{
		self.propent unlink();
		self.propent.angles = (self.angles[0],self.propent.angles[1],self.angles[2]);
		self.propent.origin = self.propanchor.origin;
		self.propent method_8442(self.propanchor);
	}

	self.propanchor method_8442(self);
	self.lock = 0;
	self.lockpropkey.label = &"MP_PH_LOCK";
}

//Function Number: 46
lockprop()
{
	self.propanchor unlink();
	self.propanchor.origin = self.origin;
	self playerlinkto(self.propanchor);
	if(self.slopelocked)
	{
		self.propent unlink();
		self.propent set_pitch_roll_for_ground_normal(self.prop);
		self.propent method_8442(self.propanchor);
	}

	self.lock = 1;
	self.lockpropkey.label = &"MP_PH_LOCKED";
	self notify("locked");
}

//Function Number: 47
propspectate()
{
	level endon("noPropsToSpectate");
	self.propspectating = 0;
	self.endingpropspecate = 0;
	if(!isdefined(self.spectatenumber))
	{
		self.spectatenumber = 0;
	}

	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return("spectate");
		if(self.endingpropspecate)
		{
			continue;
		}

		if(var_00 == "spectate")
		{
			if(self.propspectating)
			{
				self notify("endPropSpectate");
				continue;
			}

			createpropspeclist();
			if(self.spectatableprops.size <= 1)
			{
				continue;
			}

			self.propspectating = 1;
			propabilitykeysvisible(0);
			thread propspectateendwatch();
			childthread propspectatekeys();
		}
	}
}

//Function Number: 48
propspectatekeys()
{
	self endon("endPropSpectate");
	if(checkifvalidpropspectate())
	{
		spectateprop();
	}
	else
	{
		findvalidspectateprop(1);
		spectateprop();
	}

	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return("zoomin","zoomout");
		if(self.endingpropspecate)
		{
			continue;
		}

		if(var_00 == "zoomin")
		{
			findvalidspectateprop(1);
			checkifvalidpropspectate();
			movetonewprop();
		}

		if(var_00 == "zoomout")
		{
			findvalidspectateprop(0);
			checkifvalidpropspectate();
			movetonewprop();
		}
	}
}

//Function Number: 49
checkifvalidpropspectate()
{
	var_00 = self.spectatableprops[self.spectatenumber];
	if(!isdefined(var_00))
	{
		return 0;
	}

	if(var_00 == self)
	{
		return 0;
	}

	if(maps\mp\_utility::isreallyalive(var_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 50
findvalidspectateprop(param_00)
{
	var_01 = self.spectatenumber;
	for(;;)
	{
		if(maps\mp\_utility::is_true(param_00))
		{
			self.spectatenumber++;
		}
		else
		{
			self.spectatenumber--;
		}

		if(param_00 && self.spectatableprops.size <= self.spectatenumber)
		{
			self.spectatenumber = 0;
		}
		else if(self.spectatenumber < 0)
		{
			self.spectatenumber = self.spectatableprops.size - 1;
		}

		if(self.spectatenumber == var_01)
		{
			break;
		}

		if(checkifvalidpropspectate())
		{
			break;
		}
	}
}

//Function Number: 51
propspectateendwatch()
{
	self endon("disconnect");
	self endon("death");
	createpropspecatehud();
	common_scripts\utility::waittill_any_ents(self,"endPropSpectate",level,"noPropsToSpectate");
	if(maps\mp\_utility::is_true(self.endingpropspecate))
	{
		return;
	}

	self.endingpropspecate = 1;
	destroypropspecatehud();
	returntoprop();
	waittillframeend;
	propabilitykeysvisible(1);
	self.propspectating = 0;
	self.endingpropspecate = 0;
}

//Function Number: 52
createpropspecatehud()
{
	self.spectatecommands = maps\mp\gametypes\_hud_util::createfontstring("objective",1);
	self.spectatecommands.label = &"MP_PH_SPECCOMMANDS";
	self.spectatecommands.x = 20;
	self.spectatecommands.y = -80;
	self.spectatecommands.alignx = "center";
	self.spectatecommands.aligny = "middle";
	self.spectatecommands.horzalign = "center_adjustable";
	self.spectatecommands.vertalign = "bottom_adjustable";
	self.spectatecommands.archived = 1;
	self.spectatecommands.fontscale = 1;
	self.spectatecommands.alpha = 1;
	self.spectatecommands.glowalpha = 0.5;
	self.spectatecommands.hidewheninmenu = 0;
}

//Function Number: 53
destroypropspecatehud()
{
	if(isdefined(self.spectatecommands))
	{
		self.spectatecommands destroy();
	}
}

//Function Number: 54
spectateprop()
{
	var_00 = self.spectatableprops[self.spectatenumber];
	self.spectatingthisplayer = var_00;
	self.propanchor unlink();
	self.propanchor.origin = self.origin;
	self setorigin(var_00.origin);
	self.angles = var_00.angles;
	self playerlinkto(var_00.propanchor);
}

//Function Number: 55
movetonewprop()
{
	var_00 = self.spectatableprops[self.spectatenumber];
	self unlink();
	self.origin = var_00.origin;
	self.angles = var_00.angles;
	self playerlinkto(var_00.propanchor);
}

//Function Number: 56
returntoprop()
{
	self unlink();
	self setorigin(self.propanchor.origin);
	if(self.lock)
	{
		self playerlinkto(self.propanchor);
		return;
	}

	self.propanchor method_8442(self);
	self.propanchor.origin = self.origin;
}

//Function Number: 57
nospectatablepropswatch()
{
	level endon("game_ended");
	level waittill("noPropsToSpectate");
	if(isdefined(self.spectatekey))
	{
		self.spectatekey destroy();
	}
}

//Function Number: 58
propcamerazoom()
{
	self.thirdpersonrange = 120;
	self.actualthirdpersonrange = 120;
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return("zoomin","zoomout");
		if(maps\mp\_utility::is_true(self.endingpropspecate))
		{
			continue;
		}

		if(!isdefined(var_00))
		{
			continue;
		}

		if(maps\mp\_utility::is_true(self.propspectating))
		{
			continue;
		}

		if(var_00 == "zoomin")
		{
			if(self.thirdpersonrange <= 60)
			{
				continue;
			}

			self.thirdpersonrange = self.thirdpersonrange - 15;
			self method_8582(1,self.thirdpersonrange);
			continue;
		}

		if(var_00 == "zoomout")
		{
			if(self.thirdpersonrange >= 240)
			{
				continue;
			}

			self.thirdpersonrange = self.thirdpersonrange + 15;
			self method_8582(1,self.thirdpersonrange);
		}
	}
}

//Function Number: 59
setnewabilityhud()
{
	switch(self.currentability)
	{
		case "FLASH":
			break;

		default:
			break;
	}
}

//Function Number: 60
setnewabilitycount()
{
	self.abilityleft = 1;
}

//Function Number: 61
useability()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	if(self.abilityleft > 0)
	{
		switch(self.currentability)
		{
			case "FLASH":
				break;

			default:
				break;
		}
	}
}

//Function Number: 62
flashtheprops(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	thread maps\mp\gametypes\_shellshock::endondeath();
	self endon("end_explode");
	self waittill("explode",var_01);
	if(!isdefined(param_00))
	{
		return;
	}

	flashenemies(param_00,var_01);
}

//Function Number: 63
watchthrownflash()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(isdefined(var_00) && isdefined(var_01) && var_01 == "h1_flashgrenade_mp")
		{
			var_00 thread flashtheprops(self);
		}
	}
}

//Function Number: 64
flashenemies(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = self;
	}

	if(!isdefined(param_01))
	{
		param_01 = self.origin;
	}

	if(!level.madpropsmode)
	{
		playfx(common_scripts\utility::getfx("propFlash"),param_01 + (0,0,4));
		playsoundatpos(param_01,"prop_flashbang");
	}

	foreach(var_0C, var_03 in level.players)
	{
		if(var_03 == param_00)
		{
			continue;
		}

		if(maps\mp\_utility::is_true(var_03.flashimmune))
		{
			continue;
		}

		if(level.madpropsmode)
		{
			if(!isdefined(var_03) || !isalive(var_03) || !isdefined(var_03.team) || var_03.team != game["defenders"])
			{
				continue;
			}
		}
		else if(!isdefined(var_03) || !isalive(var_03) || !isdefined(var_03.team) || var_03.team != game["attackers"])
		{
			continue;
		}

		var_04 = param_01 + (0,0,4) - var_03 geteye();
		var_05 = length(var_04);
		var_06 = 500;
		var_07 = 150;
		if(var_05 <= var_06)
		{
			if(var_05 <= var_07)
			{
				var_08 = 1;
			}
			else
			{
				var_08 = 1 - var_06 - var_0C / var_07 - var_0C;
			}

			var_09 = vectornormalize(var_04);
			var_0A = anglestoforward(var_03 getplayerangles());
			var_0B = vectordot(var_0A,var_09);
			var_03 notify("flashbang",param_01 + (0,0,4),var_08,var_0B,param_00);
			param_00 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("standard",param_00);
		}
	}
}

//Function Number: 65
setupdamage()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
	self.prop.damagecallback = ::damagewatch;
}

//Function Number: 66
damagewatch(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(!isdefined(self.owner))
	{
		return;
	}

	if(isplayer(param_01))
	{
		if(param_01.pers["team"] == self.owner.pers["team"])
		{
			return;
		}

		param_01 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("standard",self);
	}

	self.owner dodamage(param_02,param_06,param_01,param_00,param_04,param_05,param_08);
}

//Function Number: 67
propcleanup()
{
	if(isdefined(self.prop))
	{
		self.prop delete();
	}

	if(isdefined(self.propanchor))
	{
		self.propanchor delete();
	}

	if(isdefined(self.propent))
	{
		self.propent delete();
	}
}

//Function Number: 68
propwatchdeath()
{
	level endon("game_ended");
	self endon("disconnect");
	self.deathnoise = "prop_death";
	self.propdeathfx = "propDeathFX";
	self waittill("death");
	var_00 = self.body;
	playsoundatpos(self.prop.origin + (0,0,4),self.deathnoise);
	playfx(common_scripts\utility::getfx(self.propdeathfx),self.prop.origin + (0,0,4));
	if(isdefined(var_00))
	{
		var_00 delete();
	}

	propcleanup();
	self method_8582(0,0);
}

//Function Number: 69
propwatchdeletedisconnect()
{
	self endon("death");
	level endon("round_end_finished");
	self waittill("disconnect");
	foreach(var_01 in level.players)
	{
		if(maps\mp\_utility::is_true(var_01.propspectating) && isdefined(var_01.spectatingthisplayer) && self == var_01.spectatingthisplayer)
		{
			var_01 notify("endPropSpectate");
		}
	}

	propcleanup();
}

//Function Number: 70
propwatchdeleteroundend()
{
	self endon("death");
	self endon("disconnect");
	level waittill("round_end_finished");
	propcleanup();
}

//Function Number: 71
deleteallglass()
{
	level endon("game_ended");
	level waittill("prematch_over");
	var_00 = function_030A();
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		deleteglass(var_01);
	}
}

//Function Number: 72
checkmapofflimits()
{
	if(maps\mp\_utility::getmapname() == "mp_citystreets")
	{
		level thread districtrestrictedarea();
	}
}

//Function Number: 73
districtrestrictedarea()
{
	level endon("game_ended");
	var_00 = spawn("trigger_radius",(5648,68,-1176),0,150,900);
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(!isplayer(var_01))
		{
			continue;
		}

		if(!isalive(var_01))
		{
			continue;
		}

		if(maps\mp\_utility::is_true(var_01.propspectating))
		{
			var_01 notify("endPropSpectate");
			continue;
		}

		var_01 suicide();
	}
}

//Function Number: 74
populateproplist()
{
	if(level.madpropsmode)
	{
		addproptolist("com_cardboardbox06",100,0,undefined,undefined);
		addproptolist("me_banana_box1",100,0,undefined,undefined);
		addproptolist("fs_h1_mwr_com_tv1_cinematic",100,0,undefined,undefined);
		addproptolist("com_computer_case",100,0,undefined,undefined);
		addproptolist("com_trashbag2_white",100,0,undefined,undefined);
		addproptolist("com_trashbag",100,0,undefined,undefined);
		addproptolist("com_propane_tank",100,0,undefined,undefined);
		return;
	}

	var_00 = maps\mp\_utility::getmapname();
	var_01 = "mp/ph_props_" + var_00 + ".csv";
	var_02 = tablegetrowcount(var_01);
	var_03 = 0;
	if(var_03 < var_02)
	{
		var_04 = tablelookupbyrow(var_01,var_03,0);
		var_05 = tablelookupbyrow(var_01,var_03,1);
		var_06 = tablelookupbyrow(var_01,var_03,2);
		var_07 = int(tablelookupbyrow(var_01,var_03,3));
		var_08 = int(tablelookupbyrow(var_01,var_03,4));
		var_09 = int(tablelookupbyrow(var_01,var_03,5));
		var_0A = int(tablelookupbyrow(var_01,var_03,6));
		var_0B = int(tablelookupbyrow(var_01,var_03,7));
		var_0C = int(tablelookupbyrow(var_01,var_03,8));
		var_0D = undefined;
		if(isdefined(var_07) && isdefined(var_08) && isdefined(var_09))
		{
			var_0D = (var_07,var_08,var_09);
		}

		var_0E = undefined;
		if(isdefined(var_0A) && isdefined(var_0B) && isdefined(var_0C))
		{
			var_0E = (var_0A,var_0B,var_0C);
		}

		var_0F = 0;
		switch(var_05)
		{
			case "xsmall":
				break;

			case "small":
				break;

			case "medium":
				break;

			case "large":
				break;

			default:
				break;
		}
	}
}

//Function Number: 75
addproptolist(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	var_05.modelname = param_00;
	var_05.propsize = int(param_01);
	var_05.packid = param_02;
	if(isdefined(param_03))
	{
		var_05.xyzoffset = param_03;
	}

	if(isdefined(param_04))
	{
		var_05.anglesoffset = param_04;
	}

	if(!isdefined(level.proplist))
	{
		level.proplist = [];
	}

	level.proplist[level.proplist.size] = var_05;
}

//Function Number: 76
ph_endgame(param_00,param_01)
{
	if(maps\mp\_utility::is_true(level.endingph))
	{
		return;
	}

	level.endingph = 1;
	level.finalkillcam_winner = param_00;
	thread maps\mp\gametypes\_gamelogic::endgame(param_00,param_01);
	level thread givephteamscore(param_00);
}

//Function Number: 77
givephteamscore(param_00)
{
	level endon("game_ended");
	var_01 = game["roundsWon"][param_00] + 1;
	setteamscore(param_00,var_01);
}

//Function Number: 78
setphteamscores()
{
	level endon("game_ended");
	var_00 = game["roundsWon"][game["defenders"]];
	var_01 = game["roundsWon"][game["attackers"]];
	setteamscore(game["defenders"],var_00);
	setteamscore(game["attackers"],var_01);
}

//Function Number: 79
ononeleftevent(param_00)
{
	if(maps\mp\_utility::is_true(level.gameended))
	{
		return;
	}

	if(param_00 == game["attackers"])
	{
		return;
	}

	var_01 = undefined;
	foreach(var_03 in level.players)
	{
		if(isdefined(param_00) && var_03.team != param_00)
		{
			continue;
		}

		if(!maps\mp\_utility::isreallyalive(var_03) && !var_03 maps\mp\gametypes\_playerlogic::mayspawn())
		{
			continue;
		}

		if(isdefined(var_01))
		{
			return;
		}

		var_01 = var_03;
	}

	if(!isdefined(var_01))
	{
		return;
	}

	var_01 thread givelastonteamwarning();
}

//Function Number: 80
givelastonteamwarning()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::waittillrecoveredhealth(3);
	var_00 = maps\mp\_utility::getotherteam(self.pers["team"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive",self,self.pers["team"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive",self,var_00);
	if(self.team == game["defenders"])
	{
		level notify("noPropsToSpectate");
		level.nopropsspectate = 1;
	}

	level notify("last_alive",self);
}

//Function Number: 81
ontimelimit()
{
	var_00 = [];
	var_01 = undefined;
	var_02 = undefined;
	if(!maps\mp\_utility::is_true(level.gameending))
	{
		foreach(var_04 in level.players)
		{
			if(!isalive(var_04))
			{
				continue;
			}

			if((var_04.team == game["defenders"] && !level.madpropsmode) || var_04.team == game["attackers"] && level.madpropsmode)
			{
				var_00[var_00.size] = var_04;
				continue;
			}

			if(!isdefined(var_01))
			{
				var_01 = var_04;
			}
		}

		if(var_00.size > 0)
		{
			var_02 = common_scripts\utility::random(var_00);
		}

		if(isdefined(var_01) && isdefined(var_02))
		{
			if(maps\mp\_utility::isgameparticipant(var_02))
			{
				var_06 = var_02 getentitynumber();
			}
			else
			{
				var_06 = -1;
			}

			var_01.deathtime = gettime() - 1000;
			maps\mp\gametypes\_damage::recordfinalkillcam(5,var_01,var_02,var_06,-1,0,"none",0,0,0,0,0,"none","normal",0);
		}

		if(level.madpropsmode)
		{
			ph_endgame(game["attackers"],game["end_reason"]["time_limit_reached"]);
			return;
		}

		ph_endgame(game["defenders"],game["end_reason"]["time_limit_reached"]);
		return;
	}
}

//Function Number: 82
ph_checkforovertime()
{
	if(game["roundsWon"]["allies"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1 && game["roundsWon"]["axis"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 83
givecustomloadout()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("applyLoadout");
		self method_8582(0,0);
		self allowprone(1);
		self allowcrouch(1);
		if(!maps\mp\_utility::is_true(self.hasthrownspecial))
		{
			thread watchspecialgrenadethrow();
		}

		thread attackerregenammo();
		thread playertakegrenades();
	}
}

//Function Number: 84
playertakegrenades()
{
	var_00 = self getweaponslistoffhands();
	foreach(var_02 in var_00)
	{
		if(var_02 == "h1_concussiongrenade_mp")
		{
			if(!maps\mp\_utility::is_true(self.hasthrownspecial))
			{
				continue;
			}
		}

		self setweaponammoclip(var_02,0);
	}
}

//Function Number: 85
stillalivexp()
{
	level endon("game_ended");
	level.xpeventinfo["kill"]["value"] = 300;
	level waittill("props_hide_over");
	for(;;)
	{
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(10);
		foreach(var_01 in level.players)
		{
			if(var_01.team == game["attackers"] && !level.madpropsmode)
			{
				continue;
			}

			if(var_01.team == game["defenders"] && level.madpropsmode)
			{
				continue;
			}

			if(!maps\mp\_utility::isreallyalive(var_01))
			{
				continue;
			}

			level thread maps\mp\gametypes\_rank::awardgameevent("still_alive",var_01);
		}
	}
}

//Function Number: 86
updateprop()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("spawned_player");
		if(!isdefined(self.thirdpersonrange))
		{
			self.thirdpersonrange = 120;
		}

		self method_8582(1,self.thirdpersonrange);
		self allowprone(0);
		self allowcrouch(1);
		self method_8583();
		self disableweaponpickup();
		if(!level.madpropsmode)
		{
			self allowsprint(0);
		}
	}
}

//Function Number: 87
gamemodemodifyplayerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(maps\mp\_utility::is_true(self.propspectating))
	{
		self notify("endPropSpectate");
		if(param_03 == "MOD_TRIGGER_HURT")
		{
			return 0;
		}
	}

	if(maps\mp\_utility::is_true(level.propsinvuln) && isdefined(param_00.team) && param_00.team == game["defenders"])
	{
		return 0;
	}

	if(isdefined(param_01) && isplayer(param_01) && isalive(param_01))
	{
		if(!isdefined(param_01.hashitplayer))
		{
			param_01.hashitplayer = 1;
		}

		if(level.matchrules_damagemultiplier)
		{
			param_02 = param_02 * level.matchrules_damagemultiplier;
		}

		if(level.matchrules_vampirism)
		{
			param_01.health = int(min(float(param_01.maxhealth),float(param_01.health + 20)));
		}
	}

	if(self.team == game["defenders"] && isdefined(param_03) && param_03 == "MOD_FALLING")
	{
		param_02 = 0;
	}

	return param_02;
}

//Function Number: 88
attackerswaittime()
{
	level endon("game_ended");
	self endon("disconnect");
	self waittill("spawned_player");
	if(self.team == game["defenders"] && !level.madpropsmode)
	{
		return;
	}

	if(self.team == game["attackers"] && level.madpropsmode)
	{
		return;
	}

	maps\mp\_utility::gameflagwait("prematch_done");
	while(!isdefined(level.starttime))
	{
		wait(0.05);
	}

	while(isdefined(self.controlsfrozen) && self.controlsfrozen)
	{
		wait(0.05);
	}

	if(level.madpropsmode)
	{
		var_00 = level.madpropssettings.madpropshidetime - gettime() - level.starttime / 1000;
	}
	else
	{
		var_00 = level.phsettings.prophidetime - gettime() - level.starttime / 1000;
	}

	if(var_00 > 0)
	{
		maps\mp\_utility::freezecontrolswrapper(1);
		self.phfrozen = 1;
		thread fadetoblackforxsec(var_00);
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_00);
	}

	self.phfrozen = undefined;
	level.startcheck = 1;
	maps\mp\_utility::freezecontrolswrapper(0);
}

//Function Number: 89
fadetoblackforxsec(param_00,param_01,param_02)
{
	level endon("game_ended");
	self endon("disconnect");
	if(!isdefined(param_00))
	{
		param_00 = 5;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = newclienthudelem(self);
	var_03.foreground = 0;
	var_03.x = 0;
	var_03.y = 0;
	var_03 setshader("black",640,480);
	var_03.alignx = "left";
	var_03.aligny = "top";
	var_03.horzalign = "fullscreen";
	var_03.vertalign = "fullscreen";
	var_03.alpha = 0;
	wait 0.05;
	var_03 fadeovertime(param_01);
	var_03.alpha = 1;
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_00 - param_02);
	var_03 fadeovertime(param_02);
	var_03.alpha = 0;
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_02);
	wait 0.05;
	if(isdefined(var_03))
	{
		var_03 destroy();
	}
}

//Function Number: 90
watchspecialgrenadethrow()
{
	self endon("death");
	self endon("disconnect");
	self notifyonplayercommand("specialGrenade","+smoke");
	self waittill("specialGrenade");
	self.hasthrownspecial = 1;
}

//Function Number: 91
attackerregenammo()
{
	self endon("death");
	self endon("disconnect");
	self notify("attackerRegenAmmo");
	self endon("attackerRegenAmmo");
	level endon("game_ended");
	var_00 = 0.15;
	self.ammoregen = 1;
	for(;;)
	{
		if(isalive(self))
		{
			var_01 = self getcurrentprimaryweapon();
			if(var_01 != "none")
			{
				var_02 = self getweaponammostock(var_01);
				self setweaponammostock(var_01,var_02 + 1);
			}

			if(self.health < 100 && self.health > 0)
			{
				self.health = 100;
			}
		}

		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_00);
	}
}

//Function Number: 92
hidehudintermission()
{
	level waittill("game_ended");
	level.elim_hud.alpha = 0;
	level.phwhistletimer.alpha = 0;
	level.whistling.alpha = 0;
	foreach(var_01 in level.players)
	{
		var_01 propabilitykeysvisible(0);
	}
}

//Function Number: 93
propabilitykeysvisible(param_00)
{
	if(maps\mp\_utility::is_true(param_00))
	{
		var_01 = 1;
	}
	else
	{
		var_01 = 0;
	}

	if(isdefined(self.propchangecounter))
	{
		self.propchangecounter.alpha = var_01;
	}

	if(isdefined(self.changepropkey))
	{
		self.changepropkey.alpha = var_01;
	}

	if(isdefined(self.lockpropkey))
	{
		self.lockpropkey.alpha = var_01;
	}

	if(isdefined(self.matchslopekey))
	{
		self.matchslopekey.alpha = var_01;
	}

	if(isdefined(self.abilitykey))
	{
		self.abilitykey.alpha = var_01;
	}
}

//Function Number: 94
checkkillrespawn()
{
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.1);
	if(self.pers["lives"] == 1)
	{
		self.pers["lives"]--;
		level.livescount[self.team]--;
		if(isdefined(self.pklivesleft))
		{
			self.pklivesleft setvalue(0);
		}

		maps\mp\gametypes\_gamelogic::updategameevents();
		level notify("propCountChanged");
		return;
	}

	if(isdefined(self.pklivesleft))
	{
		self.pklivesleft setvalue(self.pers["lives"] - 1);
	}
}

//Function Number: 95
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = self;
	var_0B = 0;
	level notify("playerCountChanged");
	if(level.madpropsmode)
	{
		if(var_0A.team == game["attackers"] && param_01.team == game["defenders"])
		{
			if(param_01.pers["lives"] == 1)
			{
				param_01.pers["lives"]++;
				level.livescount[param_01.team]++;
			}
		}
		else if(var_0A.team == game["defenders"])
		{
			var_0A thread checkkillrespawn();
		}

		return;
	}

	if(var_0A.team == game["attackers"])
	{
		thread respawnattacker();
	}
	else
	{
		thread maps\mp\gametypes\_deathicons::adddeathicon(var_0A.body,var_0A,var_0A.team,5,param_01,0);
	}

	if(isdefined(param_01) && isplayer(param_01) && param_01 != var_0A && var_0A.team != param_01.team)
	{
		var_0B = 1;
	}

	if(var_0B)
	{
		param_01 thread maps\mp\gametypes\_hud_message::splashnotify("prop_finalblow");
	}

	foreach(var_0D in level.players)
	{
		if(maps\mp\_utility::is_true(var_0D.propspectating) && isdefined(var_0D.spectatingthisplayer) && var_0A == var_0D.spectatingthisplayer)
		{
			var_0D notify("endPropSpectate");
		}

		if(var_0D != param_01 && var_0D.team == game["defenders"] && isalive(var_0D) && var_0A.team == game["defenders"])
		{
			var_0D thread maps\mp\gametypes\_hud_message::splashnotify("prop_survived");
			continue;
		}

		if(var_0D != param_01 && var_0D.team == game["attackers"] && var_0A.team == game["defenders"])
		{
			var_0D thread maps\mp\gametypes\_hud_message::splashnotify("prop_killed");
		}
	}
}

//Function Number: 96
respawnattacker()
{
	maps\mp\gametypes\_playerlogic::incrementalivecount(self.team);
	self.alreadyaddedtoalivecount = 1;
	thread waitillcanspawnclient();
}

//Function Number: 97
waitillcanspawnclient()
{
	self endon("started_spawnPlayer");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		wait(0.05);
		if(isdefined(self) && self.sessionstate == "spectator" || !maps\mp\_utility::isreallyalive(self))
		{
			self.pers["lives"] = 1;
			maps\mp\gametypes\_playerlogic::spawnclient();
			continue;
		}
	}
}

//Function Number: 98
ondeadevent(param_00)
{
	if(param_00 == game["attackers"])
	{
		if(level.madpropsmode)
		{
			thread ph_endgame(game["defenders"],game["end_reason"][game["attackers"] + "_eliminated"]);
			return;
		}

		return;
	}

	level thread propkilledend();
}

//Function Number: 99
propkilledend()
{
	if(maps\mp\_utility::is_true(level.hunterswonending))
	{
		return;
	}

	if(maps\mp\_utility::is_true(level.gameending))
	{
		return;
	}

	level.hunterswonending = 1;
	level.gameending = 1;
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(3);
	thread ph_endgame(game["attackers"],game["end_reason"][game["defenders"] + "_eliminated"]);
}

//Function Number: 100
playdamagesoundph(param_00)
{
	if(self.team == game["defenders"])
	{
		return;
	}

	if(isdefined(self.damage_sound_time) && self.damage_sound_time + 5000 > param_00)
	{
		return;
	}

	self.damage_sound_time = param_00;
	var_01 = randomintrange(1,8);
	if(self.team == "axis")
	{
		if(self hasfemalecustomizationmodel())
		{
			self playsound("generic_pain_enemy_fm_" + var_01);
			return;
		}

		self playsound("generic_pain_enemy_" + var_01);
		return;
	}

	if(self hasfemalecustomizationmodel())
	{
		self playsound("generic_pain_friendly_fm_" + var_01);
		return;
	}

	self playsound("generic_pain_friendly_" + var_01);
}

//Function Number: 101
playdeathsoundph()
{
	var_00 = randomintrange(1,8);
	if(self.team == game["attackers"])
	{
		if(self hasfemalecustomizationmodel())
		{
			self playsound("generic_death_enemy_fm_" + var_00);
			return;
		}

		self playsound("generic_death_enemy_" + var_00);
	}
}