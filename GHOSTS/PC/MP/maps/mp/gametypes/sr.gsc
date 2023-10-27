/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\sr.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 52
 * Decompile Time: 961 ms
 * Timestamp: 10/27/2023 1:20:04 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(getdvar("mapname") == "mp_background")
	{
		return;
	}

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
		maps\mp\_utility::func_6473(level.gametype,3,0,9);
		maps\mp\_utility::func_6476(level.gametype,2.5);
		maps\mp\_utility::func_6475(level.gametype,1);
		maps\mp\_utility::func_6472(level.gametype,0);
		maps\mp\_utility::func_647C(level.gametype,4);
		maps\mp\_utility::func_6470(level.gametype,1);
		maps\mp\_utility::func_646A(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	level.objectivebased = 1;
	level.teambased = 1;
	level.nobuddyspawns = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.var_5976 = ::func_5976;
	level.onplayerkilled = ::onplayerkilled;
	level.ondeadevent = ::ondeadevent;
	level.ononeleftevent = ::ononeleftevent;
	level.ontimelimit = ::ontimelimit;
	level.onnormaldeath = ::onnormaldeath;
	level.initgametypeawards = ::initgametypeawards;
	level.gamemodemaydropweapon = ::maps\mp\_utility::isplayeroutsideofanybombsite;
	level.allowlatecomers = 0;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	game["dialog"]["gametype"] = "searchrescue";
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

	game["dialog"]["offense_obj"] = "obj_destroy";
	game["dialog"]["defense_obj"] = "obj_defend";
	game["dialog"]["lead_lost"] = "null";
	game["dialog"]["lead_tied"] = "null";
	game["dialog"]["lead_taken"] = "null";
	game["dialog"]["kill_confirmed"] = "kill_confirmed";
	game["dialog"]["revived"] = "sr_rev";
	setomnvar("ui_bomb_timer_endtime",0);
	level.conf_fx["vanish"] = loadfx("fx/impacts/small_snowhit");
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_700A();
	var_00 = getmatchrulesdata("srData","roundLength");
	setdynamicdvar("scr_sr_timelimit",var_00);
	maps\mp\_utility::func_6476("sr",var_00);
	var_01 = getmatchrulesdata("srData","roundSwitch");
	setdynamicdvar("scr_sr_roundswitch",var_01);
	maps\mp\_utility::func_6473("sr",var_01,0,9);
	var_02 = getmatchrulesdata("commonOption","scoreLimit");
	setdynamicdvar("scr_sr_winlimit",var_02);
	maps\mp\_utility::func_647C("sr",var_02);
	setdynamicdvar("scr_sr_bombtimer",getmatchrulesdata("srData","bombTimer"));
	setdynamicdvar("scr_sr_planttime",getmatchrulesdata("srData","plantTime"));
	setdynamicdvar("scr_sr_defusetime",getmatchrulesdata("srData","defuseTime"));
	setdynamicdvar("scr_sr_multibomb",getmatchrulesdata("srData","multiBomb"));
	setdynamicdvar("scr_sr_roundlimit",0);
	maps\mp\_utility::func_6472("sr",0);
	setdynamicdvar("scr_sr_scorelimit",1);
	maps\mp\_utility::func_6475("sr",1);
	setdynamicdvar("scr_sr_halftime",0);
	maps\mp\_utility::func_646A("sr",0);
	setdynamicdvar("scr_sr_promode",0);
}

//Function Number: 3
onprecachegametype()
{
	game["bomb_dropped_sound"] = "mp_war_objective_lost";
	game["bomb_recovered_sound"] = "mp_war_objective_taken";
}

//Function Number: 4
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
	level._effect["bomb_explosion"] = loadfx("fx/explosions/tanker_explosion");
	level._effect["vehicle_explosion"] = loadfx("fx/explosions/small_vehicle_explosion_new");
	level._effect["building_explosion"] = loadfx("fx/explosions/building_explosion_gulag");
	maps\mp\_utility::func_7084(game["attackers"],&"OBJECTIVES_SD_ATTACKER");
	maps\mp\_utility::func_7084(game["defenders"],&"OBJECTIVES_SD_DEFENDER");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_7083(game["attackers"],&"OBJECTIVES_SD_ATTACKER");
		maps\mp\_utility::func_7083(game["defenders"],&"OBJECTIVES_SD_DEFENDER");
	}
	else
	{
		maps\mp\_utility::func_7083(game["attackers"],&"OBJECTIVES_SD_ATTACKER_SCORE");
		maps\mp\_utility::func_7083(game["defenders"],&"OBJECTIVES_SD_DEFENDER_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext(game["attackers"],&"OBJECTIVES_SD_ATTACKER_HINT");
	maps\mp\_utility::setobjectivehinttext(game["defenders"],&"OBJECTIVES_SD_DEFENDER_HINT");
	initspawns();
	var_02[0] = "sd";
	var_02[1] = "bombzone";
	var_02[2] = "blocker";
	maps\mp\gametypes\_gameobjects::func_4FDD(var_02);
	func_86F0();
	level.dogtags = [];
	func_70CE();
	thread func_1559();
	thread func_5962();
}

//Function Number: 5
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sd_spawn_attacker");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sd_spawn_defender");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("attacker","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("defender","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 6
getspawnpoint()
{
	var_00 = "defender";
	if(self.pers["team"] == game["attackers"])
	{
		var_00 = "attacker";
	}

	if(maps\mp\gametypes\_spawnlogic::func_948D())
	{
		var_01 = maps\mp\gametypes\_spawnlogic::func_3BF6("mp_sd_spawn_" + var_00);
		var_02 = maps\mp\gametypes\_spawnlogic::func_3BF5(var_01);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::func_3C41(var_02);
		var_02 = maps\mp\gametypes\_spawnscoring::func_3BF4(var_02);
	}

	return var_02;
}

//Function Number: 7
func_5976()
{
	self.isplanting = 0;
	self.isdefusing = 0;
	self.isbombcarrier = 0;
	if(level.multibomb && self.pers["team"] == game["attackers"])
	{
		self setclientomnvar("ui_carrying_bomb",1);
	}
	else
	{
		self setclientomnvar("ui_carrying_bomb",0);
	}

	level notify("spawned_player");
	if(self.sessionteam == "axis" || self.sessionteam == "allies")
	{
		level notify("sr_player_joined",self);
		maps\mp\_utility::setextrascore0(0);
		if(isdefined(self.pers["denied"]))
		{
			maps\mp\_utility::setextrascore0(self.pers["denied"]);
		}

		self.extrascore1 = 0;
	}
}

//Function Number: 8
func_5962()
{
	for(;;)
	{
		level waittill("disconnected",var_00);
		level notify("sr_player_disconnected",var_00);
	}
}

//Function Number: 9
func_948C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(self.switching_teams))
	{
		return 0;
	}

	if(isdefined(self.wasswitchingteamsforonplayerkilled))
	{
		return 0;
	}

	if(isdefined(param_01) && param_01 == self)
	{
		return 0;
	}

	if(level.teambased && isdefined(param_01) && isdefined(param_01.team) && param_01.team == self.team)
	{
		return 0;
	}

	if(isdefined(param_01) && !isdefined(param_01.team) && param_01.classname == "trigger_hurt" || param_01.classname == "worldspawn")
	{
		return 0;
	}

	return 1;
}

//Function Number: 10
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self setclientomnvar("ui_carrying_bomb",0);
	if(!maps\mp\_utility::func_36F1("prematch_done"))
	{
		maps\mp\gametypes\_playerlogic::func_5128();
	}
	else
	{
		var_0A = func_948C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
		if(var_0A)
		{
			var_0A = var_0A && !maps\mp\_utility::func_4945(self);
		}

		if(var_0A)
		{
			var_0A = var_0A && !maps\mp\gametypes\_playerlogic::func_5128();
		}

		if(var_0A)
		{
			level thread func_7868(self,param_01);
		}
	}

	thread func_1B91();
}

//Function Number: 11
func_1B91()
{
	wait(0.05);
	var_00 = 0;
	if(!level.alivecount[game["attackers"]])
	{
		level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
		var_00 = 1;
	}

	if(!level.alivecount[game["defenders"]])
	{
		level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
		var_00 = 1;
	}

	if(var_00)
	{
		maps\mp\gametypes\_spectating::func_8733();
	}
}

//Function Number: 12
func_6D21(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(!isai(var_03))
		{
			var_03 setclientomnvar("ui_bomb_planting_defusing",0);
		}
	}

	level.finalkillcam_winner = param_00;
	if(param_01 == game["end_reason"]["target_destroyed"] || param_01 == game["end_reason"]["bomb_defused"])
	{
		var_05 = 1;
		foreach(var_07 in level.bombzones)
		{
			if(isdefined(level.finalkillcam_killcamentityindex[param_00]) && level.finalkillcam_killcamentityindex[param_00] == var_07.killcamentnum)
			{
				var_05 = 0;
				break;
			}
		}

		if(var_05)
		{
			maps\mp\gametypes\_damage::erasefinalkillcam();
		}
	}

	maps\mp\gametypes\_gamescore::giveteamscoreforobjective(param_00,1);
	thread maps\mp\gametypes\_gamelogic::endgame(param_00,param_01);
}

//Function Number: 13
ondeadevent(param_00)
{
	if(level.bombexploded || level.bombdefused)
	{
	}

	if(param_00 == "all")
	{
		if(level.bombplanted)
		{
			func_6D21(game["attackers"],game["end_reason"][game["defenders"] + "_eliminated"]);
		}

		func_6D21(game["defenders"],game["end_reason"][game["attackers"] + "_eliminated"]);
	}

	if(param_00 == game["attackers"])
	{
		if(level.bombplanted)
		{
		}

		level thread func_6D21(game["defenders"],game["end_reason"][game["attackers"] + "_eliminated"]);
	}

	if(param_00 == game["defenders"])
	{
		level thread func_6D21(game["attackers"],game["end_reason"][game["defenders"] + "_eliminated"]);
	}
}

//Function Number: 14
ononeleftevent(param_00)
{
	if(level.bombexploded || level.bombdefused)
	{
	}

	var_01 = maps\mp\_utility::func_3B09(param_00);
	var_01 thread func_3CF4();
}

//Function Number: 15
onnormaldeath(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_rank::func_3BE0("kill");
	var_04 = param_00.team;
	if(game["state"] == "postgame" && param_00.team == game["defenders"] || !level.bombplanted)
	{
		param_01.finalkill = 1;
	}

	if(param_00.isplanting)
	{
		thread maps\mp\_matchdata::func_4F1A(param_02,"planting");
		param_01 maps\mp\_utility::func_4479("defends",1);
		param_01 maps\mp\gametypes\_persistence::func_7B28("round","defends",param_01.pers["defends"]);
	}
	else if(param_00.isbombcarrier)
	{
		param_01 maps\mp\_utility::func_447B("bombcarrierkills",1);
		thread maps\mp\_matchdata::func_4F1A(param_02,"carrying");
	}
	else if(param_00.isdefusing)
	{
		thread maps\mp\_matchdata::func_4F1A(param_02,"defusing");
		param_01 maps\mp\_utility::func_4479("defends",1);
		param_01 maps\mp\gametypes\_persistence::func_7B28("round","defends",param_01.pers["defends"]);
	}

	if(param_01.isbombcarrier)
	{
		param_01 maps\mp\_utility::func_447B("killsasbombcarrier",1);
	}
}

//Function Number: 16
func_3CF4()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::func_8BBE(3);
	var_00 = maps\mp\_utility::getotherteam(self.pers["team"]);
	level thread maps\mp\_utility::func_7FA0("callout_lastteammemberalive",self,self.pers["team"]);
	level thread maps\mp\_utility::func_7FA0("callout_lastenemyalive",self,var_00);
	level notify("last_alive",self);
	maps\mp\gametypes\_missions::lastmansd();
}

//Function Number: 17
ontimelimit()
{
	func_6D21(game["defenders"],game["end_reason"]["time_limit_reached"]);
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.bombplantweapon))
		{
			var_01 takeweapon(var_01.bombplantweapon);
			break;
		}
	}
}

//Function Number: 18
func_86F0()
{
	level.planttime = maps\mp\_utility::func_2B98("planttime",5,0,20);
	level.defusetime = maps\mp\_utility::func_2B98("defusetime",5,0,20);
	level.bombtimer = maps\mp\_utility::func_2B98("bombtimer",45,1,300);
	level.multibomb = maps\mp\_utility::func_2B99("multibomb",0,0,1);
}

//Function Number: 19
func_657E(param_00)
{
	var_01 = [];
	var_02 = getentarray("script_brushmodel","classname");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.script_gameobjectname) && var_04.script_gameobjectname == "bombzone")
		{
			foreach(var_06 in param_00)
			{
				if(distance(var_04.origin,var_06.origin) < 100 && issubstr(tolower(var_06.script_label),"c"))
				{
					var_06.relatedbrushmodel = var_04;
					var_01[var_01.size] = var_06;
					break;
				}
			}
		}
	}

	foreach(var_0A in var_01)
	{
		var_0A.relatedbrushmodel delete();
		var_0B = getentarray(var_0A.target,"targetname");
		foreach(var_0D in var_0B)
		{
			var_0D delete();
		}

		var_0A delete();
	}

	return common_scripts\utility::array_removeundefined(param_00);
}

//Function Number: 20
func_1559()
{
	level.bombplanted = 0;
	level.bombdefused = 0;
	level.bombexploded = 0;
	var_00 = getent("sd_bomb_pickup_trig","targetname");
	if(!isdefined(var_00))
	{
		common_scripts\utility::error("No sd_bomb_pickup_trig trigger found in map.");
	}

	var_01[0] = getent("sd_bomb","targetname");
	if(!isdefined(var_01[0]))
	{
		common_scripts\utility::error("No sd_bomb script_model found in map.");
	}

	var_01[0] setmodel("weapon_briefcase_bomb_iw6");
	if(!level.multibomb)
	{
		level.sdbomb = maps\mp\gametypes\_gameobjects::func_20CC(game["attackers"],var_00,var_01,(0,0,32));
		level.sdbomb maps\mp\gametypes\_gameobjects::func_B9E("friendly");
		level.sdbomb maps\mp\gametypes\_gameobjects::func_6E14("friendly","waypoint_bomb");
		level.sdbomb maps\mp\gametypes\_gameobjects::func_6E15("friendly","waypoint_bomb");
		level.sdbomb maps\mp\gametypes\_gameobjects::func_7212("friendly");
		level.sdbomb.allowweapons = 1;
		level.sdbomb.onpickup = ::onpickup;
		level.sdbomb.ondrop = ::ondrop;
	}
	else
	{
		var_00 delete();
		var_01[0] delete();
	}

	level.bombzones = [];
	var_02 = getentarray("bombzone","targetname");
	var_02 = func_657E(var_02);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_00 = var_02[var_03];
		var_01 = getentarray(var_02[var_03].target,"targetname");
		var_04 = maps\mp\gametypes\_gameobjects::func_212D(game["defenders"],var_00,var_01,(0,0,64));
		var_04.id = "bomb_zone";
		var_04 maps\mp\gametypes\_gameobjects::allowuse("enemy");
		var_04 maps\mp\gametypes\_gameobjects::func_720E(level.planttime);
		var_04 maps\mp\gametypes\_gameobjects::setwaitweaponchangeonuse(0);
		var_04 maps\mp\gametypes\_gameobjects::func_720D(&"MP_PLANTING_EXPLOSIVE");
		var_04 maps\mp\gametypes\_gameobjects::func_720C(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
		if(!level.multibomb)
		{
			var_04 maps\mp\gametypes\_gameobjects::func_705C(level.sdbomb);
		}

		var_05 = var_04 maps\mp\gametypes\_gameobjects::func_3B06();
		var_04.label = var_05;
		var_04 maps\mp\gametypes\_gameobjects::func_6E14("friendly","waypoint_defend" + var_05);
		var_04 maps\mp\gametypes\_gameobjects::func_6E15("friendly","waypoint_defend" + var_05);
		var_04 maps\mp\gametypes\_gameobjects::func_6E14("enemy","waypoint_target" + var_05);
		var_04 maps\mp\gametypes\_gameobjects::func_6E15("enemy","waypoint_target" + var_05);
		var_04 maps\mp\gametypes\_gameobjects::func_7212("any");
		var_04.onbeginuse = ::onbeginuse;
		var_04.onenduse = ::onenduse;
		var_04.onuse = ::onuseplantobject;
		var_04.oncantuse = ::oncantuse;
		var_04.useweapon = "briefcase_bomb_mp";
		for(var_06 = 0;var_06 < var_01.size;var_06++)
		{
			if(isdefined(var_01[var_06].script_exploder))
			{
				var_04.exploderindex = var_01[var_06].script_exploder;
				var_01[var_06] thread func_71FD(var_04);
				break;
			}
		}

		level.bombzones[level.bombzones.size] = var_04;
		var_04.bombdefusetrig = getent(var_01[0].target,"targetname");
		var_04.bombdefusetrig.origin = var_04.bombdefusetrig.origin + (0,0,-10000);
		var_04.bombdefusetrig.label = var_05;
	}

	for(var_03 = 0;var_03 < level.bombzones.size;var_03++)
	{
		var_07 = [];
		for(var_08 = 0;var_08 < level.bombzones.size;var_08++)
		{
			if(var_08 != var_03)
			{
				var_07[var_07.size] = level.bombzones[var_08];
			}
		}

		level.bombzones[var_03].otherbombzones = var_07;
	}
}

//Function Number: 21
func_71FD(param_00)
{
	var_01 = spawn("script_origin",self.origin);
	var_01.angles = self.angles;
	var_01 rotateyaw(-45,0.05);
	wait(0.05);
	var_02 = undefined;
	if(isdefined(level.srkillcamoverrideposition) && isdefined(level.srkillcamoverrideposition[param_00.label]))
	{
		var_02 = level.srkillcamoverrideposition[param_00.label];
	}
	else
	{
		var_03 = self.origin + (0,0,5);
		var_04 = self.origin + anglestoforward(var_01.angles) * 100 + (0,0,128);
		var_05 = bullettrace(var_03,var_04,0,self);
		var_02 = var_05["position"];
	}

	self.killcament = spawn("script_model",var_02);
	self.killcament setscriptmoverkillcam("explosive");
	param_00.killcamentnum = self.killcament getentitynumber();
	var_01 delete();
}

//Function Number: 22
onbeginuse(param_00)
{
	if(maps\mp\gametypes\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		param_00 maps\mp\_utility::func_5707("defuse");
		param_00.isdefusing = 1;
		if(isdefined(level.var_6D2A))
		{
			level.var_6D2A hide();
		}

		param_00 thread startnpcbombusesound("briefcase_bomb_defuse_mp","weap_suitcase_defuse_button");
	}

	param_00 maps\mp\_utility::func_5707("plant");
	param_00.isplanting = 1;
	param_00.bombplantweapon = self.useweapon;
	param_00 thread startnpcbombusesound("briefcase_bomb_mp","weap_suitcase_raise_button");
	if(level.multibomb)
	{
		for(var_01 = 0;var_01 < self.otherbombzones.size;var_01++)
		{
			self.otherbombzones[var_01] maps\mp\gametypes\_gameobjects::allowuse("none");
			self.otherbombzones[var_01] maps\mp\gametypes\_gameobjects::func_7212("friendly");
		}
	}
}

//Function Number: 23
onenduse(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
	}

	param_01.bombplantweapon = undefined;
	if(isalive(param_01))
	{
		param_01.isdefusing = 0;
		param_01.isplanting = 0;
	}

	if(isplayer(param_01))
	{
		param_01 setclientomnvar("ui_bomb_planting_defusing",0);
		param_01.ui_bomb_planting_defusing = undefined;
	}

	if(maps\mp\gametypes\_gameobjects::isfriendlyteam(param_01.pers["team"]))
	{
		if(isdefined(level.var_6D2A) && !param_02)
		{
			level.var_6D2A show();
		}
	}

	if(level.multibomb && !param_02)
	{
		for(var_03 = 0;var_03 < self.otherbombzones.size;var_03++)
		{
			self.otherbombzones[var_03] maps\mp\gametypes\_gameobjects::allowuse("enemy");
			self.otherbombzones[var_03] maps\mp\gametypes\_gameobjects::func_7212("any");
		}
	}
}

//Function Number: 24
startnpcbombusesound(param_00,param_01)
{
	self endon("death");
	self endon("stopNpcBombSound");
	if(maps\mp\_utility::isanymlgmatch())
	{
	}

	var_02 = "";
	while(var_02 != param_00)
	{
		self waittill("weapon_change",var_02);
	}

	self playsoundtoteam(param_01,self.team,self);
	var_03 = maps\mp\_utility::getotherteam(self.team);
	self playsoundtoteam(param_01,var_03);
	self waittill("weapon_change");
	self notify("stopNpcBombSound");
}

//Function Number: 25
oncantuse(param_00)
{
	param_00 iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

//Function Number: 26
onuseplantobject(param_00)
{
	if(!maps\mp\gametypes\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		level thread bombplanted(self,param_00);
		for(var_01 = 0;var_01 < level.bombzones.size;var_01++)
		{
			if(level.bombzones[var_01] == self)
			{
				continue;
			}

			level.bombzones[var_01] maps\mp\gametypes\_gameobjects::func_27B7();
		}

		param_00 playsound("mp_bomb_plant");
		param_00 notify("bomb_planted");
		param_00 notify("objective","plant");
		param_00 maps\mp\_utility::func_4479("plants",1);
		param_00 maps\mp\gametypes\_persistence::func_7B28("round","plants",param_00.pers["plants"]);
		if(isdefined(level.sd_loadout) && isdefined(level.sd_loadout[param_00.team]))
		{
			param_00 thread func_657D();
		}

		maps\mp\_utility::func_4D30("bomb_planted");
		level thread maps\mp\_utility::func_7FA0("callout_bombplanted",param_00);
		level.bombowner = param_00;
		param_00 thread maps\mp\gametypes\_hud_message::func_794C("plant",maps\mp\gametypes\_rank::func_3BE0("plant"));
		param_00 thread maps\mp\gametypes\_rank::func_8E6E("plant");
		param_00 thread maps\mp\gametypes\_rank::giverankxp("plant");
		param_00.bombplantedtime = gettime();
		maps\mp\gametypes\_gamescore::func_3D00("plant",param_00);
		param_00 thread maps\mp\_matchdata::loggameevent("plant",param_00.origin);
	}
}

//Function Number: 27
applybombcarrierclass()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait(0.05);
	}

	while(self ismantling())
	{
		wait(0.05);
	}

	while(!self isonground())
	{
		wait(0.05);
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		self notify("lost_juggernaut");
		wait(0.05);
	}

	self.pers["gamemodeLoadout"] = level.sd_loadout[self.team];
	if(isdefined(self.setspawnpoint))
	{
		maps\mp\perks\_perkfunctions::deleteti(self.setspawnpoint);
	}

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
}

//Function Number: 28
func_657D()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait(0.05);
	}

	while(self ismantling())
	{
		wait(0.05);
	}

	while(!self isonground())
	{
		wait(0.05);
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		self notify("lost_juggernaut");
		wait(0.05);
	}

	self.pers["gamemodeLoadout"] = undefined;
	if(isdefined(self.setspawnpoint))
	{
		maps\mp\perks\_perkfunctions::deleteti(self.setspawnpoint);
	}

	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00.playerspawnpos = self.origin;
	var_00.notti = 1;
	self.setspawnpoint = var_00;
	self notify("faux_spawn");
	self.faux_spawn_stance = self getstance();
	thread maps\mp\gametypes\_playerlogic::spawnplayer(1);
}

//Function Number: 29
onusedefuseobject(param_00)
{
	param_00 notify("bomb_defused");
	param_00 notify("objective","defuse");
	level thread bombdefused();
	maps\mp\gametypes\_gameobjects::func_27B7();
	maps\mp\_utility::func_4D30("bomb_defused_" + param_00.team);
	level thread maps\mp\_utility::func_7FA0("callout_bombdefused",param_00);
	if(isdefined(level.bombowner) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() && maps\mp\_utility::func_4945(level.bombowner))
	{
		param_00 thread maps\mp\gametypes\_hud_message::func_794C("ninja_defuse",maps\mp\gametypes\_rank::func_3BE0("defuse"));
	}
	else
	{
		param_00 thread maps\mp\gametypes\_hud_message::func_794C("defuse",maps\mp\gametypes\_rank::func_3BE0("defuse"));
	}

	param_00 thread maps\mp\gametypes\_rank::func_8E6E("defuse");
	param_00 thread maps\mp\gametypes\_rank::giverankxp("defuse");
	maps\mp\gametypes\_gamescore::func_3D00("defuse",param_00);
	param_00 maps\mp\_utility::func_4479("defuses",1);
	param_00 maps\mp\gametypes\_persistence::func_7B28("round","defuses",param_00.pers["defuses"]);
	param_00 thread maps\mp\_matchdata::loggameevent("defuse",param_00.origin);
}

//Function Number: 30
ondrop(param_00)
{
	level notify("bomb_dropped");
	setomnvar("ui_bomb_carrier",-1);
	maps\mp\gametypes\_gameobjects::func_6E14("friendly","waypoint_bomb");
	maps\mp\gametypes\_gameobjects::func_6E15("friendly","waypoint_bomb");
	maps\mp\_utility::func_6045(game["bomb_dropped_sound"],game["attackers"]);
}

//Function Number: 31
onpickup(param_00)
{
	param_00.isbombcarrier = 1;
	param_00 maps\mp\_utility::func_447B("bombscarried",1);
	param_00 thread maps\mp\_matchdata::loggameevent("pickup",param_00.origin);
	param_00 setclientomnvar("ui_carrying_bomb",1);
	setomnvar("ui_bomb_carrier",param_00 getentitynumber());
	maps\mp\gametypes\_gameobjects::func_6E14("friendly","waypoint_escort");
	maps\mp\gametypes\_gameobjects::func_6E15("friendly","waypoint_escort");
	if(isdefined(level.sd_loadout) && isdefined(level.sd_loadout[param_00.team]))
	{
		param_00 thread applybombcarrierclass();
	}

	if(!level.bombdefused)
	{
		maps\mp\_utility::func_7FA0("callout_bombtaken",param_00,param_00.team);
		maps\mp\_utility::func_4D30("bomb_taken",param_00.pers["team"]);
	}

	maps\mp\_utility::func_6045(game["bomb_recovered_sound"],game["attackers"]);
}

//Function Number: 32
onreset()
{
}

//Function Number: 33
bombplanted(param_00,param_01)
{
	level notify("bomb_planted",param_00);
	maps\mp\gametypes\_gamelogic::func_5B5D();
	level.bombplanted = 1;
	param_01 setclientomnvar("ui_carrying_bomb",0);
	setomnvar("ui_bomb_carrier",-1);
	param_00.visuals[0] thread maps\mp\gametypes\_gamelogic::playtickingsound();
	level.tickingobject = param_00.visuals[0];
	level.timelimitoverride = 1;
	level.defuseendtime = int(gettime() + level.bombtimer * 1000);
	setgameendtime(level.defuseendtime);
	setomnvar("ui_bomb_timer",1);
	if(!level.multibomb)
	{
		level.sdbomb maps\mp\gametypes\_gameobjects::func_B9E("none");
		level.sdbomb maps\mp\gametypes\_gameobjects::func_7212("none");
		level.sdbomb maps\mp\gametypes\_gameobjects::func_7025();
		level.var_6D2A = level.sdbomb.visuals[0];
	}
	else
	{
		level.var_6D2A = spawn("script_model",param_01.origin);
		level.var_6D2A.angles = param_01.angles;
		level.var_6D2A setmodel("weapon_briefcase_bomb_iw6");
	}

	param_00 maps\mp\gametypes\_gameobjects::allowuse("none");
	param_00 maps\mp\gametypes\_gameobjects::func_7212("none");
	var_02 = param_00 maps\mp\gametypes\_gameobjects::func_3B06();
	var_03 = param_00.bombdefusetrig;
	var_03.origin = level.var_6D2A.origin;
	var_04 = [];
	var_05 = maps\mp\gametypes\_gameobjects::func_212D(game["defenders"],var_03,var_04,(0,0,32));
	var_05.id = "defuse_object";
	var_05 maps\mp\gametypes\_gameobjects::allowuse("friendly");
	var_05 maps\mp\gametypes\_gameobjects::func_720E(level.defusetime);
	var_05 maps\mp\gametypes\_gameobjects::setwaitweaponchangeonuse(0);
	var_05 maps\mp\gametypes\_gameobjects::func_720D(&"MP_DEFUSING_EXPLOSIVE");
	var_05 maps\mp\gametypes\_gameobjects::func_720C(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	var_05 maps\mp\gametypes\_gameobjects::func_7212("any");
	var_05 maps\mp\gametypes\_gameobjects::func_6E14("friendly","waypoint_defuse" + var_02);
	var_05 maps\mp\gametypes\_gameobjects::func_6E14("enemy","waypoint_defend" + var_02);
	var_05 maps\mp\gametypes\_gameobjects::func_6E15("friendly","waypoint_defuse" + var_02);
	var_05 maps\mp\gametypes\_gameobjects::func_6E15("enemy","waypoint_defend" + var_02);
	var_05.label = var_02;
	var_05.onbeginuse = ::onbeginuse;
	var_05.onenduse = ::onenduse;
	var_05.onuse = ::onusedefuseobject;
	var_05.useweapon = "briefcase_bomb_defuse_mp";
	func_1562();
	setomnvar("ui_bomb_timer",0);
	param_00.visuals[0] maps\mp\gametypes\_gamelogic::func_7C73();
	if(level.gameended || level.bombdefused)
	{
	}

	level.bombexploded = 1;
	level notify("bomb_exploded");
	if(isdefined(level.sd_onbombtimerend))
	{
		level thread [[ level.sd_onbombtimerend ]]();
	}

	var_06 = level.var_6D2A.origin;
	level.var_6D2A hide();
	if(isdefined(param_01))
	{
		param_00.visuals[0] radiusdamage(var_06,512,200,20,param_01,"MOD_EXPLOSIVE","bomb_site_mp");
		param_01 maps\mp\_utility::func_4479("destructions",1);
		param_01 maps\mp\gametypes\_persistence::func_7B28("round","destructions",param_01.pers["destructions"]);
	}
	else
	{
		param_00.visuals[0] radiusdamage(var_06,512,200,20,undefined,"MOD_EXPLOSIVE","bomb_site_mp");
	}

	var_07 = randomfloat(360);
	if(isdefined(param_00.trigger.effect))
	{
		var_08 = param_00.trigger.effect;
	}
	else
	{
		var_08 = "bomb_explosion";
	}

	var_09 = var_06 + (0,0,50);
	var_0A = spawnfx(level._effect[var_08],var_09,(0,0,1),(cos(var_07),sin(var_07),0));
	triggerfx(var_0A);
	physicsexplosionsphere(var_09,200,100,3);
	playrumbleonposition("grenade_rumble",var_06);
	earthquake(0.75,2,var_06,2000);
	thread maps\mp\_utility::func_6044("exp_suitcase_bomb_main",var_06);
	if(isdefined(param_00.exploderindex))
	{
		common_scripts\utility::exploder(param_00.exploderindex);
	}

	for(var_0B = 0;var_0B < level.bombzones.size;var_0B++)
	{
		level.bombzones[var_0B] maps\mp\gametypes\_gameobjects::func_27B7();
	}

	var_05 maps\mp\gametypes\_gameobjects::func_27B7();
	setgameendtime(0);
	wait(3);
	func_6D21(game["attackers"],game["end_reason"]["target_destroyed"]);
}

//Function Number: 34
func_463B(param_00)
{
	var_01 = undefined;
	var_02 = getentarray("sd_bombcam_start","targetname");
	foreach(var_04 in var_02)
	{
		if(var_04.script_label == param_00.label)
		{
			var_01 = var_04;
			break;
		}
	}

	var_06 = [];
	if(isdefined(var_01) && isdefined(var_01.target))
	{
		var_07 = getent(var_01.target,"targetname");
		while(isdefined(var_07))
		{
			var_06[var_06.size] = var_07;
			if(isdefined(var_07.target))
			{
				var_07 = getent(var_07.target,"targetname");
				continue;
			}

			break;
		}
	}

	if(isdefined(var_01) && var_06.size)
	{
		var_08 = spawn("script_model",var_01.origin);
		var_08.origin = var_01.origin;
		var_08.angles = var_01.angles;
		var_08.path = var_06;
		var_08 setmodel("tag_origin");
		var_08 hide();
		return var_08;
	}

	return undefined;
}

//Function Number: 35
func_699E()
{
	level notify("objective_cam");
	foreach(var_01 in level.players)
	{
		if(!isai(var_01))
		{
			var_01 maps\mp\_utility::func_350E(1);
			var_01 visionsetnakedforplayer("black_bw",0.5);
		}
	}

	wait(0.5);
	foreach(var_01 in level.players)
	{
		if(!isai(var_01))
		{
			if(isdefined(var_01.disabledoffhandweapons))
			{
				var_01 maps\mp\_utility::func_720F("objective_cam");
				var_01 common_scripts\utility::_disableweapon();
			}

			var_01 playerlinkweaponviewtodelta(self,"tag_player",1,180,180,180,180,1);
			var_01 maps\mp\_utility::func_350E(1);
			var_01 setplayerangles(self.angles);
			var_01 visionsetnakedforplayer("",0.5);
		}
	}

	var_05 = 0;
	if(!getdvarint("g_hardcore"))
	{
		setdynamicdvar("g_hardcore",1);
		var_05 = 1;
	}

	for(var_06 = 0;var_06 < self.path.size;var_06++)
	{
		var_07 = 0;
		if(var_06 == 0)
		{
			var_07 = 5 / self.path.size / 2;
		}

		var_08 = 0;
		if(var_06 == self.path.size - 1)
		{
			var_08 = 5 / self.path.size / 2;
		}

		self moveto(self.path[var_06].origin,5 / self.path.size,var_07,var_08);
		self rotateto(self.path[var_06].angles,5 / self.path.size,var_07,var_08);
		wait(5 / self.path.size);
	}

	if(var_05)
	{
		wait(0.5);
		setdynamicdvar("g_hardcore",0);
	}
}

//Function Number: 36
func_1562()
{
	level endon("game_ended");
	level endon("bomb_defused");
	var_00 = int(level.bombtimer * 1000 + gettime());
	setomnvar("ui_bomb_timer_endtime",var_00);
	level thread handlehostmigration(var_00);
	maps\mp\gametypes\_hostmigration::func_8B0C(level.bombtimer);
}

//Function Number: 37
handlehostmigration(param_00)
{
	level endon("game_ended");
	level endon("bomb_defused");
	level endon("game_ended");
	level endon("disconnect");
	level waittill("host_migration_begin");
	setomnvar("ui_bomb_timer_endtime",0);
	var_01 = maps\mp\gametypes\_hostmigration::func_8BBA();
	if(var_01 > 0)
	{
		setomnvar("ui_bomb_timer_endtime",param_00 + var_01);
	}
}

//Function Number: 38
bombdefused()
{
	level.tickingobject maps\mp\gametypes\_gamelogic::func_7C73();
	level.bombdefused = 1;
	setomnvar("ui_bomb_timer",0);
	level notify("bomb_defused");
	wait(1.5);
	setgameendtime(0);
	func_6D21(game["defenders"],game["end_reason"]["bomb_defused"]);
}

//Function Number: 39
func_7868(param_00,param_01)
{
	if(isagent(param_00))
	{
	}

	if(param_00 maps\mp\killstreaks\_killstreaks::func_4994())
	{
	}

	if(isagent(param_01))
	{
		param_01 = param_01.owner;
	}

	var_02 = maps\mp\_utility::getotherteam(param_00.team);
	var_03 = param_00.origin + (0,0,14);
	if(isdefined(level.dogtags[param_00.guid]))
	{
		playfx(level.conf_fx["vanish"],level.dogtags[param_00.guid].curorigin);
		level.dogtags[param_00.guid] notify("reset");
	}
	else
	{
		var_04[0] = spawn("script_model",(0,0,0));
		var_04[0] setclientowner(param_00);
		var_04[0] setmodel("prop_dogtags_foe_iw6");
		var_04[1] = spawn("script_model",(0,0,0));
		var_04[1] setclientowner(param_00);
		var_04[1] setmodel("prop_dogtags_friend_iw6");
		var_05 = spawn("trigger_radius",(0,0,0),0,32,32);
		level.dogtags[param_00.guid] = maps\mp\gametypes\_gameobjects::func_212D("any",var_05,var_04,(0,0,16));
		maps\mp\gametypes\_objpoints::deleteobjpoint(level.dogtags[param_00.guid].objpoints["allies"]);
		maps\mp\gametypes\_objpoints::deleteobjpoint(level.dogtags[param_00.guid].objpoints["axis"]);
		level.dogtags[param_00.guid] maps\mp\gametypes\_gameobjects::func_720E(0);
		level.dogtags[param_00.guid].onuse = ::onuse;
		level.dogtags[param_00.guid].victim = param_00;
		level.dogtags[param_00.guid].victimteam = param_00.team;
		level thread clearonvictimdisconnect(param_00);
		param_00 thread func_7E72(level.dogtags[param_00.guid]);
	}

	level.dogtags[param_00.guid].curorigin = var_03;
	level.dogtags[param_00.guid].trigger.origin = var_03;
	level.dogtags[param_00.guid].visuals[0].origin = var_03;
	level.dogtags[param_00.guid].visuals[1].origin = var_03;
	level.dogtags[param_00.guid] maps\mp\gametypes\_gameobjects::func_4629();
	level.dogtags[param_00.guid] maps\mp\gametypes\_gameobjects::allowuse("any");
	level.dogtags[param_00.guid].visuals[0] thread func_752A(level.dogtags[param_00.guid],maps\mp\_utility::getotherteam(param_00.team));
	level.dogtags[param_00.guid].visuals[1] thread func_752A(level.dogtags[param_00.guid],param_00.team);
	level.dogtags[param_00.guid].attacker = param_01;
	objective_icon(level.dogtags[param_00.guid].teamobjids[param_00.team],"waypoint_dogtags_friendlys");
	objective_position(level.dogtags[param_00.guid].teamobjids[param_00.team],var_03);
	objective_state(level.dogtags[param_00.guid].teamobjids[param_00.team],"active");
	objective_team(level.dogtags[param_00.guid].teamobjids[param_00.team],param_00.team);
	objective_icon(level.dogtags[param_00.guid].teamobjids[var_02],"waypoint_dogtags");
	objective_position(level.dogtags[param_00.guid].teamobjids[var_02],var_03);
	objective_state(level.dogtags[param_00.guid].teamobjids[var_02],"active");
	objective_team(level.dogtags[param_00.guid].teamobjids[var_02],var_02);
	playsoundatpos(var_03,"mp_killconfirm_tags_drop");
	param_00.extrascore1 = 1;
	level notify("sr_player_killed",param_00);
	param_00.tagavailable = 1;
	level.dogtags[param_00.guid].visuals[0] scriptmodelplayanim("mp_dogtag_spin");
	level.dogtags[param_00.guid].visuals[1] scriptmodelplayanim("mp_dogtag_spin");
}

//Function Number: 40
func_752A(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("reset");
	self hide();
	foreach(var_03 in level.players)
	{
		if(var_03.team == param_01)
		{
			self showtoplayer(var_03);
		}

		if(var_03.team == "spectator" && param_01 == "allies")
		{
			self showtoplayer(var_03);
		}
	}

	for(;;)
	{
		level waittill("joined_team");
		self hide();
		foreach(var_03 in level.players)
		{
			if(var_03.team == param_01)
			{
				self showtoplayer(var_03);
			}

			if(var_03.team == "spectator" && param_01 == "allies")
			{
				self showtoplayer(var_03);
			}
		}
	}
}

//Function Number: 41
func_79A5()
{
	maps\mp\gametypes\_playerlogic::incrementalivecount(self.team);
	self.alreadyaddedtoalivecount = 1;
	thread func_9586();
}

//Function Number: 42
func_9586()
{
	self endon("started_spawnPlayer");
	for(;;)
	{
		wait(0.05);
		if(isdefined(self) && self.sessionstate == "spectator" || !maps\mp\_utility::func_4945(self))
		{
			self.pers["lives"] = 1;
			maps\mp\gametypes\_playerlogic::func_7866();
			continue;
		}
	}
}

//Function Number: 43
func_79A6(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		if(isdefined(param_01) && var_04.team != param_01)
		{
			continue;
		}

		if(isdefined(param_02) && var_04 == param_02)
		{
			continue;
		}

		var_04 thread maps\mp\gametypes\_hud_message::func_794C(param_00);
	}
}

//Function Number: 44
func_79A4(param_00,param_01,param_02)
{
	var_03 = param_02.team;
	var_04 = maps\mp\_utility::getotherteam(var_03);
	foreach(var_06 in level.players)
	{
		if(var_06.team == var_03)
		{
			if(var_06 != param_02)
			{
				var_06 func_79A3(param_00);
			}

			continue;
		}

		if(var_06.team == var_04)
		{
			var_06 func_79A3(param_01);
		}
	}
}

//Function Number: 45
func_79A3(param_00)
{
	thread maps\mp\gametypes\_hud_message::func_794C(param_00);
}

//Function Number: 46
onuse(param_00)
{
	if(isdefined(param_00.owner))
	{
		param_00 = param_00.owner;
	}

	if(param_00.pers["team"] == self.victimteam)
	{
		self.trigger playsound("mp_killconfirm_tags_deny");
		param_00 maps\mp\_utility::func_447B("killsdenied",1);
		param_00 maps\mp\_utility::func_4479("denied",1);
		param_00 maps\mp\gametypes\_persistence::func_7B28("round","denied",param_00.pers["denied"]);
		param_00.pers["rescues"]++;
		param_00 maps\mp\gametypes\_persistence::func_7B28("round","rescues",param_00.pers["rescues"]);
		param_00 maps\mp\_utility::setextrascore0(param_00.pers["denied"]);
		if(self.victim == param_00)
		{
			var_01 = "tags_retrieved";
		}
		else
		{
			var_01 = "kill_denied";
		}

		if(isdefined(self.victim))
		{
			self.victim thread maps\mp\gametypes\_hud_message::func_794C("sr_respawned");
			level notify("sr_player_respawned",self.victim);
			self.victim maps\mp\_utility::func_4D35("revived");
		}

		func_79A4("sr_ally_respawned","sr_enemy_respawned",self.victim);
		if(isdefined(self.victim))
		{
			if(!level.gameended)
			{
				self.victim thread func_79A5();
			}
		}

		if(isdefined(self.attacker))
		{
			self.attacker thread maps\mp\gametypes\_rank::func_8E6E("kill_denied");
		}

		param_00 thread func_597D(var_01);
		param_00 maps\mp\gametypes\_missions::func_61CE("ch_rescuer");
		if(!isdefined(param_00.rescuedplayers))
		{
			param_00.rescuedplayers = [];
		}

		param_00.rescuedplayers[self.victim.guid] = 1;
		if(param_00.rescuedplayers.size == 4)
		{
			param_00 maps\mp\gametypes\_missions::func_61CE("ch_helpme");
		}
	}
	else
	{
		self.trigger playsound("mp_killconfirm_tags_pickup");
		var_01 = "kill_confirmed";
		param_00 maps\mp\_utility::func_447B("killsconfirmed",1);
		param_00 maps\mp\_utility::func_4479("confirmed",1);
		param_00 maps\mp\gametypes\_persistence::func_7B28("round","confirmed",param_00.pers["confirmed"]);
		if(isdefined(self.victim))
		{
			self.victim thread maps\mp\gametypes\_hud_message::func_794C("sr_eliminated");
			level notify("sr_player_eliminated",self.victim);
		}

		func_79A4("sr_ally_eliminated","sr_enemy_eliminated",self.victim);
		if(isdefined(self.victim))
		{
			if(!level.gameended)
			{
				self.victim maps\mp\_utility::setlowermessage("spawn_info",game["strings"]["spawn_next_round"]);
				self.victim thread maps\mp\gametypes\_playerlogic::func_65B0(3);
			}

			self.victim.tagavailable = undefined;
			self.victim.extrascore1 = 2;
		}

		if(self.attacker != param_00)
		{
			self.attacker thread func_597D(var_01);
		}

		param_00 func_597D(var_01);
		param_00 maps\mp\_utility::func_4D35("kill_confirmed");
		param_00 maps\mp\gametypes\_missions::func_61CE("ch_hideandseek");
	}

	func_661E();
}

//Function Number: 47
func_597D(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	while(!isdefined(self.pers))
	{
		wait(0.05);
	}

	thread maps\mp\gametypes\_rank::func_8E6E(param_00);
	maps\mp\gametypes\_gamescore::func_3D00(param_00,self,undefined,1);
	thread maps\mp\gametypes\_rank::giverankxp(param_00);
}

//Function Number: 48
func_661E()
{
	self.attacker = undefined;
	self notify("reset");
	self.visuals[0] hide();
	self.visuals[1] hide();
	self.curorigin = (0,0,1000);
	self.trigger.origin = (0,0,1000);
	self.visuals[0].origin = (0,0,1000);
	self.visuals[1].origin = (0,0,1000);
	maps\mp\gametypes\_gameobjects::allowuse("none");
	objective_state(self.teamobjids[self.victimteam],"invisible");
	objective_state(self.teamobjids[maps\mp\_utility::getotherteam(self.victimteam)],"invisible");
}

//Function Number: 49
func_7E72(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		param_00.victimteam = self.pers["team"];
		param_00 func_661E();
		if(!isalive(self))
		{
			self.extrascore1 = 2;
		}
	}
}

//Function Number: 50
clearonvictimdisconnect(param_00)
{
	level endon("game_ended");
	var_01 = param_00.guid;
	param_00 waittill("disconnect");
	if(isdefined(level.dogtags[var_01]))
	{
		level.dogtags[var_01] maps\mp\gametypes\_gameobjects::allowuse("none");
		if(isdefined(level.dogtags[var_01].attacker))
		{
			level.dogtags[var_01].attacker thread maps\mp\gametypes\_rank::func_8E6E("kill_denied");
		}

		playfx(level.conf_fx["vanish"],level.dogtags[var_01].curorigin);
		level.dogtags[var_01] notify("reset");
		wait(0.05);
		if(isdefined(level.dogtags[var_01]))
		{
			objective_delete(level.dogtags[var_01].teamobjids["allies"]);
			objective_delete(level.dogtags[var_01].teamobjids["axis"]);
			level.dogtags[var_01].trigger delete();
			for(var_02 = 0;var_02 < level.dogtags[var_01].visuals.size;var_02++)
			{
				level.dogtags[var_01].visuals[var_02] delete();
			}

			level.dogtags[var_01] notify("deleted");
			level.dogtags[var_01] = undefined;
		}
	}
}

//Function Number: 51
initgametypeawards()
{
	maps\mp\_awards::func_4652("targetsdestroyed",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::func_4652("bombsplanted",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::func_4652("bombsdefused",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::func_4652("bombcarrierkills",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::func_4652("bombscarried",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::func_4652("killsasbombcarrier",0,::maps\mp\_awards::highestwins);
}

//Function Number: 52
func_70CE()
{
	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses",game["attackers"],5,"class","inUse"))
	{
		level.sd_loadout[game["attackers"]] = maps\mp\_utility::func_3B24(game["attackers"],5);
	}
}