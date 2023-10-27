/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\sd.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 143 ms
 * Timestamp: 10/27/2023 2:38:22 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvar("mapname") == "mp_background")
	{
		return;
	}

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
		maps\mp\_utility::registerroundswitchdvar(level.gametype,1,0,9);
		maps\mp\_utility::registertimelimitdvar(level.gametype,2.5);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,1);
		maps\mp\_utility::registerroundlimitdvar(level.gametype,0);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,4);
		maps\mp\_utility::registernumlivesdvar(level.gametype,1);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
		setdynamicdvar("scr_killcount_persists",0);
	}

	level.objectivebased = 1;
	level.teambased = 1;
	level.classicgamemode = 1;
	level.onprecachegametype = ::maps\mp\gametypes\common_sd_sr::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	level.onplayerkilled = ::onplayerkilled;
	level.ondeadevent = ::maps\mp\gametypes\common_sd_sr::ondeadevent;
	level.ononeleftevent = ::maps\mp\gametypes\common_sd_sr::ononeleftevent;
	level.ontimelimit = ::maps\mp\gametypes\common_sd_sr::ontimelimit;
	level.onnormaldeath = ::maps\mp\gametypes\common_sd_sr::onnormaldeath;
	level.gamemodemaydropweapon = ::maps\mp\gametypes\common_sd_sr::isplayeroutsideofanybombsite;
	level.allowlatecomers = 0;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	game["dialog"]["gametype"] = "searchdestroy";
	game["dialog"]["offense_obj"] = "obj_destroy";
	game["dialog"]["defense_obj"] = "obj_defend";
	maps\mp\gametypes\common_sd_sr::setbombendtime(0,0);
	maps\mp\gametypes\common_sd_sr::setbombendtime(0,1);
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	var_00 = getmatchrulesdata("sdData","roundLength");
	setdynamicdvar("scr_sd_timelimit",var_00);
	maps\mp\_utility::registertimelimitdvar("sd",var_00);
	var_01 = getmatchrulesdata("sdData","roundSwitch");
	setdynamicdvar("scr_sd_roundswitch",var_01);
	maps\mp\_utility::registerroundswitchdvar("sd",var_01,0,9);
	var_02 = getmatchrulesdata("commonOption","scoreLimit");
	setdynamicdvar("scr_sd_winlimit",var_02);
	maps\mp\_utility::registerwinlimitdvar("sd",var_02);
	setdynamicdvar("scr_sd_bombtimer",getmatchrulesdata("sdData","bombTimer"));
	setdynamicdvar("scr_sd_planttime",getmatchrulesdata("sdData","plantTime"));
	setdynamicdvar("scr_sd_defusetime",getmatchrulesdata("sdData","defuseTime"));
	setdynamicdvar("scr_sd_multibomb",getmatchrulesdata("sdData","multiBomb"));
	setdynamicdvar("scr_sd_silentplant",getmatchrulesdata("sdData","silentPlant"));
	setdynamicdvar("scr_sd_roundlimit",0);
	maps\mp\_utility::registerroundlimitdvar("sd",0);
	setdynamicdvar("scr_sd_scorelimit",1);
	maps\mp\_utility::registerscorelimitdvar("sd",1);
	setdynamicdvar("scr_sd_halftime",0);
	maps\mp\_utility::registerhalftimedvar("sd",0);
}

//Function Number: 3
onstartgametype()
{
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

	setclientnamemode("manual_change");
	maps\mp\gametypes\common_bomb_gameobject::loadbombfx();
	maps\mp\_utility::setobjectivetext(game["attackers"],&"OBJECTIVES_SD_ATTACKER");
	maps\mp\_utility::setobjectivetext(game["defenders"],&"OBJECTIVES_SD_DEFENDER");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"],&"OBJECTIVES_SD_ATTACKER");
		maps\mp\_utility::setobjectivescoretext(game["defenders"],&"OBJECTIVES_SD_DEFENDER");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"],&"OBJECTIVES_SD_ATTACKER_SCORE");
		maps\mp\_utility::setobjectivescoretext(game["defenders"],&"OBJECTIVES_SD_DEFENDER_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext(game["attackers"],&"OBJECTIVES_SD_ATTACKER_HINT");
	maps\mp\_utility::setobjectivehinttext(game["defenders"],&"OBJECTIVES_SD_DEFENDER_HINT");
	initspawns();
	var_02[0] = "sd";
	var_02[1] = "bombzone";
	var_02[2] = "blocker";
	maps\mp\gametypes\_gameobjects::main(var_02);
	thread maps\mp\gametypes\common_sd_sr::updategametypedvars();
	maps\mp\_utility::setcarrierloadouts();
	thread maps\mp\gametypes\common_sd_sr::bombs();
	thread maps\mp\gametypes\_spectating::allowallyteamspectating();
}

//Function Number: 4
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sd_spawn_attacker");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sd_spawn_defender");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 5
getspawnpoint()
{
	var_00 = "mp_sd_spawn_defender";
	if(self.pers["team"] == game["attackers"])
	{
		var_00 = "mp_sd_spawn_attacker";
	}

	var_01 = maps\mp\gametypes\_spawnlogic::getbeststartspawn(var_00);
	maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_01);
	return var_01;
}

//Function Number: 6
onspawnplayer()
{
	var_00 = maps\mp\_utility::is_true(self.isrespawningwithbombcarrierclass);
	if(maps\mp\_utility::isgameparticipant(self))
	{
		self.isplanting = 0;
		self.isdefusing = 0;
		if(!var_00)
		{
			self.isbombcarrier = 0;
			self.objective = 0;
		}
	}

	if(isplayer(self) && !var_00)
	{
		if(level.multibomb && self.pers["team"] == game["attackers"])
		{
			self setclientomnvar("ui_carrying_bomb",1);
		}
		else
		{
			self setclientomnvar("ui_carrying_bomb",0);
		}
	}

	maps\mp\_utility::setextrascore0(0);
	if(isdefined(self.pers["plants"]))
	{
		maps\mp\_utility::setextrascore0(self.pers["plants"]);
	}

	maps\mp\_utility::setextrascore1(0);
	if(isdefined(self.pers["defuses"]))
	{
		maps\mp\_utility::setextrascore1(self.pers["defuses"]);
	}

	self.isrespawningwithbombcarrierclass = undefined;
	level notify("spawned_player");
	thread maps\mp\gametypes\common_sd_sr::onplayerdisconnect();
}

//Function Number: 7
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isplayer(self))
	{
		self setclientomnvar("ui_carrying_bomb",0);
	}

	thread maps\mp\gametypes\common_sd_sr::checkallowspectating();
}