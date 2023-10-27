/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\sd.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 38
 * Decompile Time: 659 ms
 * Timestamp: 10/27/2023 1:29:24 AM
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

	game["dialog"]["gametype"] = "searchdestroy";
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
	setomnvar("ui_bomb_timer_endtime",0);
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_700A();
	var_00 = getmatchrulesdata("sdData","roundLength");
	setdynamicdvar("scr_sd_timelimit",var_00);
	maps\mp\_utility::func_6476("sd",var_00);
	var_01 = getmatchrulesdata("sdData","roundSwitch");
	setdynamicdvar("scr_sd_roundswitch",var_01);
	maps\mp\_utility::func_6473("sd",var_01,0,9);
	var_02 = getmatchrulesdata("commonOption","scoreLimit");
	setdynamicdvar("scr_sd_winlimit",var_02);
	maps\mp\_utility::func_647C("sd",var_02);
	setdynamicdvar("scr_sd_bombtimer",getmatchrulesdata("sdData","bombTimer"));
	setdynamicdvar("scr_sd_planttime",getmatchrulesdata("sdData","plantTime"));
	setdynamicdvar("scr_sd_defusetime",getmatchrulesdata("sdData","defuseTime"));
	setdynamicdvar("scr_sd_multibomb",getmatchrulesdata("sdData","multiBomb"));
	setdynamicdvar("scr_sd_roundlimit",0);
	maps\mp\_utility::func_6472("sd",0);
	setdynamicdvar("scr_sd_scorelimit",1);
	maps\mp\_utility::func_6475("sd",1);
	setdynamicdvar("scr_sd_halftime",0);
	maps\mp\_utility::func_646A("sd",0);
	setdynamicdvar("scr_sd_promode",0);
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
	func_70CE();
	thread func_1559();
}

//Function Number: 5
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sd_spawn_attacker");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sd_spawn_defender");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 6
getspawnpoint()
{
	var_00 = "mp_sd_spawn_defender";
	if(self.pers["team"] == game["attackers"])
	{
		var_00 = "mp_sd_spawn_attacker";
	}

	var_01 = maps\mp\gametypes\_spawnlogic::func_3BF6(var_00);
	var_02 = maps\mp\gametypes\_spawnlogic::func_3BF5(var_01);
	return var_02;
}

//Function Number: 7
func_5976()
{
	if(maps\mp\_utility::func_48CE(self))
	{
		self.isplanting = 0;
		self.isdefusing = 0;
		self.isbombcarrier = 0;
	}

	if(level.multibomb && self.pers["team"] == game["attackers"])
	{
		self setclientomnvar("ui_carrying_bomb",1);
	}
	else
	{
		self setclientomnvar("ui_carrying_bomb",0);
	}

	maps\mp\_utility::setextrascore0(0);
	if(isdefined(self.pers["plants"]))
	{
		maps\mp\_utility::setextrascore0(self.pers["plants"]);
	}

	level notify("spawned_player");
}

//Function Number: 8
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self setclientomnvar("ui_carrying_bomb",0);
	thread func_1B91();
}

//Function Number: 9
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

//Function Number: 10
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

	thread maps\mp\gametypes\_gamelogic::endgame(param_00,param_01);
}

//Function Number: 11
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

//Function Number: 12
ononeleftevent(param_00)
{
	if(level.bombexploded || level.bombdefused)
	{
	}

	var_01 = maps\mp\_utility::func_3B09(param_00);
	var_01 thread func_3CF4();
}

//Function Number: 13
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

//Function Number: 14
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

//Function Number: 15
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

//Function Number: 16
func_86F0()
{
	level.planttime = maps\mp\_utility::func_2B98("planttime",5,0,20);
	level.defusetime = maps\mp\_utility::func_2B98("defusetime",5,0,20);
	level.bombtimer = maps\mp\_utility::func_2B98("bombtimer",45,1,300);
	level.multibomb = maps\mp\_utility::func_2B99("multibomb",0,0,1);
}

//Function Number: 17
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

//Function Number: 18
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

//Function Number: 19
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

//Function Number: 20
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

//Function Number: 21
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

//Function Number: 22
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

//Function Number: 23
oncantuse(param_00)
{
	param_00 iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

//Function Number: 24
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
		param_00 maps\mp\_utility::setextrascore0(param_00.pers["plants"]);
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
		if(isplayer(param_00))
		{
			param_00 thread maps\mp\_matchdata::loggameevent("plant",param_00.origin);
		}
	}
}

//Function Number: 25
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

//Function Number: 26
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

//Function Number: 27
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
	if(isplayer(param_00))
	{
		param_00 thread maps\mp\_matchdata::loggameevent("defuse",param_00.origin);
	}
}

//Function Number: 28
ondrop(param_00)
{
	level notify("bomb_dropped");
	setomnvar("ui_bomb_carrier",-1);
	maps\mp\gametypes\_gameobjects::func_6E14("friendly","waypoint_bomb");
	maps\mp\gametypes\_gameobjects::func_6E15("friendly","waypoint_bomb");
	maps\mp\_utility::func_6045(game["bomb_dropped_sound"],game["attackers"]);
}

//Function Number: 29
onpickup(param_00)
{
	param_00.isbombcarrier = 1;
	param_00 maps\mp\_utility::func_447B("bombscarried",1);
	if(isplayer(param_00))
	{
		param_00 thread maps\mp\_matchdata::loggameevent("pickup",param_00.origin);
	}

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

//Function Number: 30
onreset()
{
}

//Function Number: 31
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
	level.defuseendtime = castint(gettime() + level.bombtimer * 1000);
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
		param_00.visuals[0] entityradiusdamage(var_06,512,200,20,param_01,"MOD_EXPLOSIVE","bomb_site_mp");
		param_01 maps\mp\_utility::func_4479("destructions",1);
		param_01 maps\mp\gametypes\_persistence::func_7B28("round","destructions",param_01.pers["destructions"]);
	}
	else
	{
		param_00.visuals[0] entityradiusdamage(var_06,512,200,20,undefined,"MOD_EXPLOSIVE","bomb_site_mp");
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

//Function Number: 32
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

//Function Number: 33
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
			var_01 setangles(self.angles);
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

//Function Number: 34
func_1562()
{
	level endon("game_ended");
	level endon("bomb_defused");
	var_00 = castint(level.bombtimer * 1000 + gettime());
	setomnvar("ui_bomb_timer_endtime",var_00);
	level thread handlehostmigration(var_00);
	maps\mp\gametypes\_hostmigration::func_8B0C(level.bombtimer);
}

//Function Number: 35
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

//Function Number: 36
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

//Function Number: 37
initgametypeawards()
{
	maps\mp\_awards::func_4652("targetsdestroyed",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::func_4652("bombsplanted",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::func_4652("bombsdefused",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::func_4652("bombcarrierkills",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::func_4652("bombscarried",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::func_4652("killsasbombcarrier",0,::maps\mp\_awards::highestwins);
}

//Function Number: 38
func_70CE()
{
	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses",game["attackers"],5,"class","inUse"))
	{
		level.sd_loadout[game["attackers"]] = maps\mp\_utility::func_3B24(game["attackers"],5);
	}
}