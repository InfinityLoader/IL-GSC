/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\horde.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 97
 * Decompile Time: 1707 ms
 * Timestamp: 10/27/2023 1:19:45 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
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
		maps\mp\_utility::func_6473(level.gametype,0,0,9);
		maps\mp\_utility::func_6476(level.gametype,0);
		maps\mp\_utility::func_6475(level.gametype,0);
		maps\mp\_utility::func_6472(level.gametype,1);
		maps\mp\_utility::func_647C(level.gametype,1);
		maps\mp\_utility::func_6470(level.gametype,1);
		maps\mp\_utility::func_646A(level.gametype,0);
	}

	setdynamicdvar("r_hudOutlineWidth",1);
	setdynamicdvar("scr_horde_timeLimit",0);
	setdynamicdvar("scr_horde_numLives",1);
	maps\mp\_utility::func_6476(level.gametype,0);
	func_70CF();
	func_463F();
	func_4E96();
	level.enablespecialround = 1;
	level.specialroundtime = 25;
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
	level.allowcamoswap = 0;
	level.allowfauxdeath = 0;
	level.killstreakrewards = 0;
	level.supportintel = 0;
	level.gamehasstarted = 0;
	level.donottrackgamesplayed = 1;
	level.disableweaponstats = 1;
	level.playerteam = "allies";
	level.enemyteam = "axis";
	level.laststandusetime = 2000;
	level.currentteamintelname = "";
	level.timeromnvars = [];
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onnormaldeath = ::onnormaldeath;
	level.var_5976 = ::func_5976;
	level.modifyplayerdamage = ::func_5327;
	level.callbackplayerlaststand = ::maps\mp\gametypes\_horde_laststand::func_194E;
	level.ondeadevent = ::ondeadevent;
	level.customcratefunc = ::maps\mp\gametypes\_horde_crates::createhordecrates;
	level.onsuicidedeath = ::onnormaldeath;
	level.weapondropfunction = ::dropweaponfordeathhorde;
}

//Function Number: 2
func_71F4()
{
	game["dialog"]["gametype"] = "infct_hint";
	game["dialog"]["offense_obj"] = "null";
	game["dialog"]["defense_obj"] = "null";
	game["dialog"]["mission_success"] = "sgd_end";
	game["dialog"]["mission_failure"] = "sgd_end_fail";
	game["dialog"]["mission_draw"] = "sgd_end_fail";
	game["dialog"]["round_end"] = "sgd_rnd_end";
	game["dialog"]["round_start"] = "sgd_rnd_start";
	game["dialog"]["round_loot"] = "sgd_plr_join";
	game["dialog"]["weapon_level"] = "sgd_prf_inc";
	game["dialog"]["max_ammo"] = "sgd_team_restock";
	game["dialog"]["support_drop"] = "sgd_supply_drop";
	game["dialog"]["ally_down"] = "sgd_ally_down";
	game["dialog"]["ally_dead"] = "sgd_ally_dead";
	game["dialog"]["dc"] = "sgd_plr_quit";
	game["dialog"]["squadmate"] = "sgd_squad";
}

//Function Number: 3
func_4E96()
{
	level._effect["dropLocation"] = loadfx("smoke/signal_smoke_airdrop");
	level._effect["spawn_effect"] = loadfx("fx/maps/mp_siege_dam/mp_siege_spawn");
	level._effect["crate_teleport"] = loadfx("vfx/gameplay/mp/core/vfx_teleport_player");
	level._effect["loot_crtae"] = loadfx("vfx/gameplay/mp/core/vfx_marker_base_cyan");
	level._effect["weapon_level"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_3d_world_ping");
}

//Function Number: 4
func_463F()
{
	level.maxpickupsperround = func_3B28();
	level.maxammopickupsperround = 1;
	level.currentpickupcount = 0;
	level.currentammopickupcount = 0;
	level.percentchancetodrop = getpercentchancetodrop();
	level.weaponpickupmodel = "mp_weapon_level_pickup_badge";
	level.weaponpickupfunc = ::func_8DB2;
	level.ammopickupmodel = "prop_mp_max_ammo_pickup";
	level.ammopickupfunc = ::ammopickup;
}

//Function Number: 5
func_8B1F(param_00)
{
	maps\mp\gametypes\_hostmigration::func_8B0D(param_00);
	func_9458("ui_cranked_bomb_timer_final_seconds",1);
}

//Function Number: 6
func_704F(param_00,param_01)
{
	level thread func_8B1F(param_01 - 5);
	func_9458("ui_cranked_bomb_timer_text",param_00);
	func_9458("ui_cranked_bomb_timer_end_milliseconds",int(gettime() + param_01 * 1000));
}

//Function Number: 7
func_1D3F()
{
	func_9458("ui_cranked_bomb_timer_end_milliseconds",0);
}

//Function Number: 8
func_9458(param_00,param_01)
{
	level.timeromnvars[param_00] = param_01;
	foreach(var_03 in level.players)
	{
		var_03 setclientomnvar(param_00,param_01);
	}
}

//Function Number: 9
func_955A(param_00)
{
	foreach(var_03, var_02 in level.timeromnvars)
	{
		param_00 setclientomnvar(var_03,var_02);
	}
}

//Function Number: 10
func_3B28()
{
	var_00 = maps\mp\gametypes\_horde_util::func_3B5B() + 1;
	return clamp(var_00,3,5);
}

//Function Number: 11
getpercentchancetodrop()
{
	var_00 = 0;
	var_01 = maps\mp\gametypes\_horde_util::func_3B5B();
	switch(var_01)
	{
		case 0:
			var_00 = 0;
			break;

		case 1:
			var_00 = 14;
			break;

		case 2:
			var_00 = 13;
			break;

		case 3:
			var_00 = 12;
			break;

		case 4:
		default:
			var_00 = 10;
			break;
	}

	return var_00;
}

//Function Number: 12
initializematchrules()
{
	maps\mp\_utility::func_700A();
	setdynamicdvar("scr_horde_roundswitch",0);
	maps\mp\_utility::func_6473("horde",0,0,9);
	setdynamicdvar("scr_horde_roundlimit",1);
	maps\mp\_utility::func_6472("horde",1);
	setdynamicdvar("scr_horde_winlimit",1);
	maps\mp\_utility::func_647C("horde",1);
	setdynamicdvar("scr_horde_halftime",0);
	maps\mp\_utility::func_646A("horde",0);
	setdynamicdvar("scr_horde_promode",0);
	setdynamicdvar("scr_horde_timeLimit",0);
	maps\mp\_utility::func_6476(level.gametype,0);
	setdynamicdvar("scr_horde_numLives",1);
	maps\mp\_utility::func_6470(level.gametype,1);
	setdynamicdvar("scr_horde_difficulty",getmatchrulesdata("hordeData","difficulty"));
	setdynamicdvar("r_hudOutlineWidth",1);
}

//Function Number: 13
onstartgametype()
{
	setclientnamemode("auto_change");
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	maps\mp\_utility::func_7084("allies",&"HORDE_OBJECTIVE");
	maps\mp\_utility::func_7084("axis",&"HORDE_OBJECTIVE");
	maps\mp\_utility::func_7083("allies",&"HORDE_OBJECTIVE_SCORE");
	maps\mp\_utility::func_7083("axis",&"HORDE_OBJECTIVE_SCORE");
	maps\mp\_utility::setobjectivehinttext("allies",&"HORDE_OBJECTIVE_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"HORDE_OBJECTIVE_HINT");
	initspawns();
	func_71F4();
	var_00[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::func_4FDD(var_00);
	inithordesettings();
	level thread func_5960();
	level thread func_698C();
	level thread func_698B();
}

//Function Number: 14
inithordesettings()
{
	setdvar("g_keyboarduseholdtime",250);
	level.hordedroplocations = common_scripts\utility::func_3C1A("horde_drop","targetname");
	level.blastshieldmod = 0.75;
	level.intelminigun = "iw6_minigunjugg_mp";
	level.hordedifficultylevel = int(clamp(getdvarint("scr_horde_difficulty",3),1,3));
	level.maxrounds = getmaxrounds(level.hordedifficultylevel);
	level.currentroundnumber = 0;
	level.currentpointtotal = 0;
	level.enemyoutlinecolor = 4;
	level.droplocationindex = 0;
	func_42AF();
	level.chancetospawndog = 0;
	level.lastdoground = 0;
	level.pointevents = [];
	level.pointevents["damage_body"] = 10;
	level.pointevents["damage_head"] = 30;
	level.pointevents["kill_normal"] = 20;
	level.pointevents["kill_melee"] = 50;
	level.pointevents["kill_head"] = 50;
	level.hudleftspace = 50;
	level.huddownspace = 395;
}

//Function Number: 15
func_42AF()
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
func_5960()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.gamemodefirstspawn = 1;
		var_00.hasusedsquadmate = 0;
		if(level.currentroundnumber > 10)
		{
			var_00.hasusedsquadmate = 1;
		}

		level thread func_2111(var_00);
		level thread maps\mp\gametypes\_horde_crates::func_5381(var_00);
		level thread func_53CB(var_00);
		level thread func_9558(var_00);
	}
}

//Function Number: 17
func_2111(param_00)
{
	param_00.weaponstate = [];
	param_00.horde_perks = [];
	param_00.pointnotifylua = [];
	param_00.beingrevived = 0;
	param_00.killz = 0;
	param_00.numrevives = 0;
	param_00.numcrtaescaptured = 0;
	param_00.roundsplayed = 0;
	param_00.maxweaponlevel = 1;
	level.playerstartweaponname = "iw6_mp443_mp_xmags";
	var_01 = getweaponbasename(level.playerstartweaponname);
	func_20FA(param_00,level.playerstartweaponname,0);
	func_20FA(param_00,level.intelminigun,0);
	level thread func_8F33(param_00);
	level thread func_53D9(param_00);
	level thread func_9347(param_00);
}

//Function Number: 18
func_20FA(param_00,param_01,param_02)
{
	var_03 = getweaponbasename(param_01);
	if(func_4029(param_00,var_03))
	{
	}

	param_00.weaponstate[var_03]["level"] = 1;
	param_00.weaponstate[var_03]["vaule"] = 0;
	param_00.weaponstate[var_03]["barSize"] = 0;
	if(param_02)
	{
		param_00.weaponstate[var_03]["barSize"] = getweaponbarsize(1,var_03);
	}
}

//Function Number: 19
func_4029(param_00,param_01)
{
	return isdefined(param_01) && isdefined(param_00.weaponstate[param_01]);
}

//Function Number: 20
func_5976()
{
	if(self.gamemodefirstspawn)
	{
		self.pers["class"] = "gamemode";
		self.pers["lastClass"] = "";
		self.pers["gamemodeLoadout"] = level.hordeloadouts[level.playerteam];
		self.class = self.pers["class"];
		self.lastclass = self.pers["lastClass"];
	}

	if(isagent(self))
	{
		if(!maps\mp\gametypes\_horde_util::isonhumanteam(self))
		{
			func_702A(self);
			func_702B(self);
			var_00 = func_3ACD();
			self.pers["gamemodeLoadout"] = var_00;
			self.agentname = var_00["name_localized"];
			self.horde_type = var_00["type"];
			thread maps/mp/agents/_agents_gametype_horde::func_5D3F();
		}
		else
		{
			self.pers["gamemodeLoadout"] = level.hordeloadouts["squadmate"];
			maps/mp/bots/_bots_util::bot_set_personality("camper");
			maps/mp/bots/_bots_util::bot_set_difficulty("regular");
			self botsetdifficultysetting("allowGrenades",1);
		}

		self.avoidkillstreakonspawntimer = 0;
	}

	thread func_5975();
}

//Function Number: 21
func_702B(param_00)
{
	param_00 maps/mp/bots/_bots_util::bot_set_personality("run_and_gun");
	if(level.currentroundnumber < 41)
	{
		param_00 maps/mp/bots/_bots_util::bot_set_difficulty("recruit");
		param_00 botsetdifficultysetting("visionBlinded",0.05);
		param_00 botsetdifficultysetting("hearingDeaf",0.05);
		param_00 botsetdifficultysetting("meleeReactAllowed",1);
		param_00 botsetdifficultysetting("meleeReactionTime",600);
		param_00 botsetdifficultysetting("meleeDist",85);
		param_00 botsetdifficultysetting("meleeChargeDist",100);
		param_00 botsetdifficultysetting("minGraceDelayFireTime",0);
		param_00 botsetdifficultysetting("maxGraceDelayFireTime",0);
		param_00 botsetdifficultysetting("minInaccuracy",1.25);
		param_00 botsetdifficultysetting("maxInaccuracy",1.75);
		param_00 botsetdifficultysetting("strafeChance",0.25);
		if(level.currentroundnumber > 8)
		{
			param_00 botsetdifficultysetting("minInaccuracy",0.75);
			param_00 botsetdifficultysetting("maxInaccuracy",1.5);
		}

		if(level.currentroundnumber > 20)
		{
			param_00 botsetdifficultysetting("adsAllowed",1);
			param_00 botsetdifficultysetting("diveChance",0.15);
		}
	}
	else if(level.currentroundnumber > 50)
	{
		param_00 maps/mp/bots/_bots_util::bot_set_difficulty("veteran");
	}
	else
	{
		param_00 maps/mp/bots/_bots_util::bot_set_difficulty("hardened");
	}

	param_00 botsetdifficultysetting("allowGrenades",0);
	param_00 botsetdifficultysetting("avoidSkyPercent",0);
}

//Function Number: 22
func_3CE8()
{
	if(level.currentroundnumber > 15)
	{
		maps\mp\_utility::func_3CFB("specialty_fastreload",0);
	}

	if(level.currentroundnumber > 20)
	{
		maps\mp\_utility::func_3CFB("specialty_fastsprintrecovery",0);
	}

	if(level.currentroundnumber > 30)
	{
		maps\mp\_utility::func_3CFB("specialty_lightweight",0);
	}

	if(level.currentroundnumber > 35)
	{
		maps\mp\_utility::func_3CFB("specialty_quickdraw",0);
	}

	if(level.currentroundnumber > 40)
	{
		maps\mp\_utility::func_3CFB("specialty_stalker",0);
	}

	if(level.currentroundnumber > 45)
	{
		maps\mp\_utility::func_3CFB("specialty_marathon",0);
	}

	if(level.currentroundnumber > 50)
	{
		maps\mp\_utility::func_3CFB("specialty_regenfaster",0);
	}
}

//Function Number: 23
func_702A(param_00)
{
	param_00.maxhealth = 60 + 20 * level.currentroundnumber;
	param_00.health = param_00.maxhealth;
}

//Function Number: 24
func_5975()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("giveLoadout");
	maps\mp\killstreaks\_killstreaks::clearkillstreaks();
	if(maps\mp\gametypes\_horde_util::isonhumanteam(self))
	{
		self givemaxammo(level.playerstartweaponname);
		thread func_5F94(level.playerstartweaponname);
		if(isplayer(self))
		{
			self setweaponammoclip("proximity_explosive_mp",1);
			self setweaponammoclip("concussion_grenade_mp",1);
			maps\mp\_utility::func_3CFB("specialty_pistoldeath",0);
			if(!self.hasusedsquadmate)
			{
				thread maps\mp\killstreaks\_killstreaks::func_3CF2("agent",0,0,self);
			}

			childthread func_8726(self.gamemodefirstspawn);
			func_65A5(self);
			func_955A(self);
		}

		if(isagent(self))
		{
			self.agentname = &"HORDE_BUDDY";
			self.horde_type = "Buddy";
			childthread ammorefillprimary();
			thread maps/mp/bots/_bots::bot_think_revive();
			if(isdefined(self.owner))
			{
				self.owner.hasusedsquadmate = 1;
			}
		}
	}
	else
	{
		childthread ammorefillprimary();
		childthread ammorefillsecondary();
		switch(self.horde_type)
		{
			case "Ravager":
				func_70AF();
				break;

			case "Enforcer":
				func_702C();
				break;

			case "Striker":
				setstrikermodel();
				self botsetflag("path_traverse_wait",1);
				break;

			case "Blaster":
				func_6FEA();
				self botsetdifficultysetting("maxFireTime",2800);
				self botsetdifficultysetting("minFireTime",1500);
				break;

			case "Hammer":
				func_7047();
				break;

			default:
				break;
		}

		self setviewmodel("viewhands_juggernaut_ally");
		self setclothtype("cloth");
		func_3CE8();
	}

	self.gamemodefirstspawn = 0;
}

//Function Number: 25
func_8726(param_00)
{
	self waittill("spawned_player");
	if(!param_00)
	{
		thread maps\mp\gametypes\_hud_message::func_794C("horde_respawn");
	}
}

//Function Number: 26
func_53CB(param_00)
{
	param_00 endon("disconnect");
	for(;;)
	{
		param_00 waittill("unresolved_collision");
		maps\mp\_movers::func_85CB(param_00,0);
		wait(0.5);
	}
}

//Function Number: 27
func_9558(param_00)
{
	param_00 endon("disconnect");
	if(level.currentroundnumber == 0)
	{
	}

	if(!isdefined(level.carepackages))
	{
	}

	foreach(var_02 in level.carepackages)
	{
		if(isdefined(var_02.outlinecolor))
		{
			var_02.friendlymodel hudoutlineenable(var_02.outlinecolor,0);
		}
	}

	common_scripts\utility::func_8AFE();
	if(!isdefined(level.characters))
	{
	}

	foreach(var_05 in level.characters)
	{
		if(isdefined(var_05.outlinecolor))
		{
			var_05 hudoutlineenable(var_05.outlinecolor,0);
		}
	}
}

//Function Number: 28
func_70AF()
{
	self setmodel("mp_body_infected_a");
	if(isdefined(self.headmodel))
	{
		self detach(self.headmodel,"");
	}

	self.headmodel = "head_mp_infected";
	self attach(self.headmodel,"",1);
}

//Function Number: 29
func_702C()
{
	self setmodel("mp_body_juggernaut_light_black");
	if(isdefined(self.headmodel))
	{
		self detach(self.headmodel,"");
	}

	self.headmodel = "head_juggernaut_light_black";
	self attach(self.headmodel,"",1);
}

//Function Number: 30
setstrikermodel()
{
	self setmodel("mp_body_infected_a");
	if(isdefined(self.headmodel))
	{
		self detach(self.headmodel,"");
	}

	self.headmodel = "head_mp_infected";
	self attach(self.headmodel,"",1);
}

//Function Number: 31
func_6FEA()
{
	self setmodel("mp_fullbody_juggernaut_heavy_black");
	if(isdefined(self.headmodel))
	{
		self detach(self.headmodel,"");
		self.headmodel = undefined;
	}
}

//Function Number: 32
func_7047()
{
	self setmodel("mp_body_juggernaut_light_black");
	if(isdefined(self.headmodel))
	{
		self detach(self.headmodel,"");
	}

	self.headmodel = "head_juggernaut_light_black";
	self attach(self.headmodel,"",1);
}

//Function Number: 33
func_5F94(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		var_04 = weaponclipsize(var_03);
		self setweaponammoclip(var_03,var_04);
	}

	var_06 = 1.5;
	for(;;)
	{
		var_01 = self getweaponslistprimaries();
		foreach(var_03 in var_01)
		{
			if(var_03 == param_00)
			{
				var_08 = self getweaponammostock(var_03);
				self setweaponammostock(var_03,var_08 + 1);
			}
		}

		wait(var_06);
	}
}

//Function Number: 34
ammorefillprimary()
{
	if(self.primaryweapon == "none")
	{
	}

	for(;;)
	{
		self givemaxammo(self.primaryweapon);
		wait(12);
	}
}

//Function Number: 35
ammorefillsecondary()
{
	if(self.secondaryweapon == "none")
	{
	}

	for(;;)
	{
		self givemaxammo(self.secondaryweapon);
		wait(8);
	}
}

//Function Number: 36
func_698C()
{
	level endon("game_ended");
	func_8BC9();
	foreach(var_01 in level.players)
	{
		if(var_01.class == "")
		{
			var_01 notify("luinotifyserver","class_select",0);
			var_01 thread func_9072();
		}
	}

	for(;;)
	{
		func_86F3();
		func_751C();
		level notify("start_round");
		level.gamehasstarted = 1;
		func_8F85();
		level childthread func_53BA();
		level waittill("round_ended");
	}
}

//Function Number: 37
func_9072()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	common_scripts\utility::func_8AFE();
	self setclientomnvar("ui_options_menu",-1);
}

//Function Number: 38
func_8F85()
{
	if(!level.currentroundnumber % 4 && level.isteamintelcomplete)
	{
		level notify("giveTeamIntel",level.playerteam);
	}

	if(level.currentroundnumber == 21 && maps\mp\gametypes\_horde_util::func_3B5B() == 1 && !maps\mp\gametypes\_horde_util::func_3FF9(level.players[0]))
	{
		level.players[0] thread maps\mp\killstreaks\_killstreaks::func_3CF2("agent",0,0,level.players[0]);
	}
}

//Function Number: 39
func_53BA()
{
	if(maps\mp\gametypes\_horde_util::func_496C())
	{
		monitorspecialroundend();
	}

	func_53B0();
}

//Function Number: 40
func_53B0()
{
	for(;;)
	{
		level waittill("enemy_death");
		if(level.currentenemycount == level.maxenemycount && level.currentaliveenemycount == 0)
		{
			notifyroundover();
		}
	}
}

//Function Number: 41
monitorspecialroundend()
{
	var_00 = getspecialroundtimer();
	level thread maps\mp\gametypes\_horde_util::func_7527("horde_special_round");
	func_704F("round_time",var_00);
	maps\mp\gametypes\_hostmigration::func_8B0D(var_00);
	func_1D3F();
	notifyroundover();
}

//Function Number: 42
getspecialroundtimer()
{
	return level.specialroundtime;
}

//Function Number: 43
notifyroundover()
{
	level notify("round_ended");
	level thread respawneliminatedplayers();
	level thread maps\mp\gametypes\_horde_util::func_6047("mp_safe_round_end");
	if(!maps\mp\gametypes\_horde_util::func_496C())
	{
		level thread maps\mp\_utility::func_4D30("round_end",level.playerteam,"status");
	}
}

//Function Number: 44
respawneliminatedplayers()
{
	level endon("game_ended");
	foreach(var_01 in level.players)
	{
		if(!maps\mp\gametypes\_horde_util::isonhumanteam(var_01))
		{
			continue;
		}

		if(maps\mp\gametypes\_horde_util::func_4934(var_01) && !var_01.beingrevived)
		{
			var_01 notify("revive_trigger",var_01);
		}

		if(var_01.sessionstate == "spectator")
		{
			var_01.pers["lives"] = 1;
			var_01 thread maps\mp\gametypes\_playerlogic::func_7866();
		}
	}
}

//Function Number: 45
func_9553()
{
	if(level.currentroundnumber > 19)
	{
		foreach(var_01 in level.players)
		{
			var_01 giveachievement("EXTRA1");
		}
	}
}

//Function Number: 46
func_86F3()
{
	func_9553();
	if(level.currentroundnumber == level.maxrounds)
	{
		level.finalkillcam_winner = level.playerteam;
		level thread maps\mp\gametypes\_gamelogic::endgame(level.playerteam,game["end_reason"][level.enemyteam + "_eliminated"]);
	}

	level.currentroundnumber = func_3B46();
	level.maxenemycount = func_3B27(level.currentroundnumber);
	level.currentenemycount = 0;
	level.maxaliveenemycount = getmaxaliveenemycount(level.currentroundnumber);
	level.currentaliveenemycount = 0;
	level.maxpickupsperround = func_3B28();
	level.percentchancetodrop = getpercentchancetodrop();
	level.currentpickupcount = 0;
	level.currentammopickupcount = 0;
	level.chancetospawndog = 0;
	if(chancefordoground())
	{
		level.chancetospawndog = 55;
		level.lastdoground = level.currentroundnumber;
	}

	if(level.currentroundnumber > 4)
	{
		setnojipscore(1);
	}

	foreach(var_01 in level.players)
	{
		var_01.roundsplayed++;
		if(var_01.roundsplayed != level.currentroundnumber && var_01.roundsplayed > 9)
		{
			var_01.roundsplayed = level.currentroundnumber;
		}

		maps\mp\gametypes\_horde_util::func_8F95(var_01,var_01.roundsplayed);
	}
}

//Function Number: 47
chancefordoground()
{
	if(level.currentroundnumber < 4)
	{
		return 0;
	}

	if(maps\mp\gametypes\_horde_util::func_496C(level.currentroundnumber))
	{
		return 0;
	}

	if(level.lastdoground == level.currentroundnumber - 1)
	{
		return 0;
	}

	if(randomintrange(1,101) < 20)
	{
		return 1;
	}

	if(level.currentroundnumber - level.lastdoground > 4)
	{
		return 1;
	}

	return 0;
}

//Function Number: 48
func_3B46()
{
	var_00 = level.currentroundnumber + 1;
	return var_00;
}

//Function Number: 49
func_3BDA(param_00)
{
	param_00 = int(clamp(param_00,1,20));
	param_00 = param_00 - 1;
	return param_00 * 4 + maps\mp\gametypes\_horde_util::func_3B5B();
}

//Function Number: 50
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

//Function Number: 51
func_3B27(param_00)
{
	var_01 = func_3BDA(param_00);
	var_02 = int(tablelookupbyrow("mp/hordeSettings.csv",var_01,1));
	if(param_00 > 20)
	{
		var_03 = param_00 - 20;
		var_02 = var_02 + var_03;
	}

	return var_02;
}

//Function Number: 52
getmaxaliveenemycount(param_00)
{
	var_01 = func_3BDA(param_00);
	var_02 = int(tablelookupbyrow("mp/hordeSettings.csv",var_01,2));
	if(param_00 > 20)
	{
		var_03 = param_00 - 20;
		var_04 = 1 + int(var_03 / 5);
		var_02 = var_02 + 2 * var_04;
		var_02 = min(var_02,20);
	}

	return var_02;
}

//Function Number: 53
func_8BC9()
{
	maps\mp\_utility::gameflagwait("prematch_done");
	while(!isdefined(level.bot_loadouts_initialized) || level.bot_loadouts_initialized == 0)
	{
		common_scripts\utility::func_8AFE();
	}

	while(!level.players.size)
	{
		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 54
func_751C()
{
	if(func_7517())
	{
		func_704F("start_time",getroundintermissiontimer());
	}

	maps\mp\gametypes\_hostmigration::func_8B0D(getroundintermissiontimer());
	func_1D3F();
	setomnvar("ui_horde_round_number",level.currentroundnumber);
	level thread respawneliminatedplayers();
	if(!maps\mp\gametypes\_horde_util::func_496C())
	{
		var_00 = "mp_safe_round_start";
		if(maps\mp\gametypes\_horde_util::func_48AE())
		{
			var_00 = "mp_safe_round_boss";
		}

		level childthread maps\mp\gametypes\_horde_util::func_6047(var_00);
		level thread maps\mp\_utility::func_4D30("round_start",level.playerteam,"status");
	}

	level thread maps\mp\_utility::func_4D30("round_loot",level.playerteam,"status");
}

//Function Number: 55
func_7517()
{
	if(level.currentroundnumber == 1)
	{
		return 0;
	}

	if(maps\mp\gametypes\_horde_util::func_496C(level.currentroundnumber))
	{
		return 0;
	}

	if(maps\mp\gametypes\_horde_util::func_496C(level.currentroundnumber - 1))
	{
		return 0;
	}

	return 1;
}

//Function Number: 56
getroundintermissiontimer()
{
	if(!func_7517())
	{
		return 5;
	}

	return 20;
}

//Function Number: 57
func_698B()
{
	level endon("game_ended");
	func_8BC9();
	if(!isdefined(level.hordedroplocations) || !level.hordedroplocations.size)
	{
	}

	level childthread monitorsupportdropprogress();
	for(;;)
	{
		level waittill("airSupport");
		level childthread displayincomingairdropmessage();
		var_00 = maps\mp\gametypes\_horde_util::func_3B5B() + 1;
		var_00 = min(var_00,4);
		func_76F8();
		for(var_01 = 0;var_01 < var_00;var_01++)
		{
			var_02 = level.hordedroplocations[level.droplocationindex];
			level thread callairsupport(var_02.tracelocation);
			level.droplocationindex = func_3B3E(level.droplocationindex);
		}
	}
}

//Function Number: 58
func_76F8()
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
	level.droplocationindex = randomint(3);
}

//Function Number: 59
func_3B3E(param_00)
{
	var_01 = param_00 + 1;
	if(var_01 == level.hordedroplocations.size)
	{
		return 0;
	}

	return var_01;
}

//Function Number: 60
monitorsupportdropprogress()
{
	var_00 = func_3C1C();
	for(;;)
	{
		level common_scripts\utility::func_8B2A("pointsEarned","host_migration_end");
		if(level.currentpointtotal >= var_00)
		{
			level notify("airSupport");
			level.currentpointtotal = level.currentpointtotal - var_00;
			var_00 = func_3C1C();
		}

		setomnvar("ui_horde_support_drop_progress",int(level.currentpointtotal / var_00 * 100));
	}
}

//Function Number: 61
func_3C1C()
{
	var_00 = func_3B27(level.currentroundnumber);
	var_01 = int(level.currentroundnumber / 4);
	var_02 = 45 + var_01 * 15;
	return var_00 * var_02;
}

//Function Number: 62
func_8F33(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 waittill("spawned_player");
	common_scripts\utility::func_8AFE();
	var_01 = getarraykeys(param_00.weaponstate);
	foreach(var_03 in var_01)
	{
		param_00.weaponstate[var_03]["barSize"] = getweaponbarsize(1,var_03);
	}

	param_00 setclientomnvar("ui_horde_weapon_progress",0);
	param_00 setclientomnvar("ui_horde_weapon_level",1);
	var_05 = int(max(level.currentroundnumber,1));
	setomnvar("ui_horde_round_number",var_05);
	thread func_9596();
}

//Function Number: 63
func_9596()
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

			var_03 = maps\mp\gametypes\_horde_util::getplayerweaponhorde(var_02);
			var_04 = getweaponbasename(var_03);
			var_05 = var_02.weaponstate[var_04]["barSize"];
			var_02 setclientomnvar("ui_horde_weapon_progress",int(var_02.weaponstate[var_04]["vaule"] / var_05 * 100));
			var_02 setclientomnvar("ui_horde_weapon_level",var_02.weaponstate[var_04]["level"]);
			if(!isdefined(var_02.horde_perks))
			{
				continue;
			}

			if(!var_02.horde_perks.size)
			{
				continue;
			}

			var_06 = var_02.horde_perks.size;
			for(var_07 = 0;var_07 < var_06;var_07++)
			{
				if(!isdefined(var_02))
				{
					continue;
				}

				var_02 setclientomnvar("ui_horde_update_perk",var_02.horde_perks[var_07]["index"]);
				wait(0.05);
			}
		}
	}
}

//Function Number: 64
func_53D9(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	func_8BC9();
	maps\mp\gametypes\_horde_util::func_8F96(param_00,1);
	for(;;)
	{
		param_00 common_scripts\utility::func_8B2A("weaponPointsEarned","weapon_change");
		var_01 = maps\mp\gametypes\_horde_util::getplayerweaponhorde(param_00);
		var_02 = getweaponbasename(var_01);
		if(!func_4029(param_00,var_02))
		{
			continue;
		}

		var_03 = param_00.weaponstate[var_02]["barSize"];
		if(param_00.weaponstate[var_02]["vaule"] >= var_03)
		{
			param_00 playlocalsound("mp_safe_weapon_up");
			playfx(level._effect["weapon_level"],param_00.origin + (0,0,func_3C7A(param_00)));
			level thread func_955B(param_00,var_02,var_01);
			param_00.weaponstate[var_02]["level"]++;
			param_00.weaponstate[var_02]["vaule"] = param_00.weaponstate[var_02]["vaule"] - var_03;
			if(param_00.maxweaponlevel < param_00.weaponstate[var_02]["level"])
			{
				param_00.maxweaponlevel = param_00.weaponstate[var_02]["level"];
				maps\mp\gametypes\_horde_util::func_8F96(param_00,param_00.maxweaponlevel);
			}

			param_00 thread maps\mp\gametypes\_hud_message::func_794C("horde_weapon_level");
			param_00.weaponstate[var_02]["barSize"] = getweaponbarsize(param_00.weaponstate[var_02]["level"],var_02);
		}

		param_00 setclientomnvar("ui_horde_weapon_progress",int(param_00.weaponstate[var_02]["vaule"] / var_03 * 100));
		param_00 setclientomnvar("ui_horde_weapon_level",param_00.weaponstate[var_02]["level"]);
	}
}

//Function Number: 65
func_955B(param_00,param_01,param_02)
{
	if(!allowcamo(param_01))
	{
	}

	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 notify("camo_update");
	param_00 endon("camo_update");
	var_03 = param_00 getweaponammoclip(param_02);
	var_04 = param_00 getweaponammostock(param_02);
	param_00 setweaponmodelvariant(param_02,getcamoindex(param_00.weaponstate[param_01]["level"]));
}

//Function Number: 66
allowcamo(param_00)
{
	if(!level.allowcamoswap)
	{
		return 0;
	}

	switch(param_00)
	{
		case "iw6_m27_mp":
		case "iw6_ak12_mp":
		case "iw6_microtar_mp":
		case "iw6_vepr_mp":
		case "iw6_fp6_mp":
		case "iw6_mts255_mp":
		case "iw6_arx160_mp":
		case "iw6_kac_mp":
		case "iw6_usr_mp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 67
getcamoindex(param_00)
{
	var_01 = 0;
	var_02 = 4;
	switch(param_00)
	{
		case 1:
		case 0:
			var_01 = 0;
			break;

		case 2:
			var_01 = 1;
			break;

		case 3:
			var_01 = 2;
			break;

		case 4:
			var_01 = 3;
			break;

		case 5:
			var_01 = 4;
			break;

		case 7:
		case 6:
			var_01 = 5;
			break;

		case 9:
		case 8:
			var_01 = 6;
			break;

		case 11:
		case 10:
			var_01 = 7;
			break;

		case 13:
		case 12:
			var_01 = 8;
			break;

		case 15:
		case 14:
			var_01 = 9;
			break;

		case 17:
		case 16:
			var_01 = 10;
			break;

		case 19:
		case 18:
			var_01 = 11;
			break;

		case 21:
		case 20:
			var_01 = 12;
			break;

		case 23:
		case 22:
		default:
			var_01 = 13;
			break;
	}

	var_03 = tablelookup("mp/camotable.csv",0,var_01,var_02);
	return int(var_03);
}

//Function Number: 68
func_3C7A(param_00)
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

//Function Number: 69
getweaponbarsize(param_00,param_01)
{
	var_02 = weaponclass(param_01) == "sniper";
	var_03 = func_3B27(param_00);
	var_04 = var_03 * 0.8 * 45;
	if(var_02)
	{
		var_04 = var_04 / 2.5;
	}

	return var_04;
}

//Function Number: 70
displayincomingairdropmessage()
{
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

		var_01 playlocalsound("mp_safe_air_support");
		var_01 thread maps\mp\gametypes\_hud_message::func_794C("horde_support_drop");
	}
}

//Function Number: 71
callairsupport(param_00)
{
	playfx(level._effect["dropLocation"],param_00 + (0,0,2));
	var_01 = "one";
	switch(level.currentroundnumber)
	{
		case 3:
		case 2:
		case 1:
			var_01 = "a";
			break;

		case 6:
		case 5:
		case 4:
			var_01 = "b";
			break;

		case 9:
		case 8:
		case 7:
			var_01 = "c";
			break;

		case 12:
		case 11:
		case 10:
			var_01 = "d";
			break;

		default:
			var_01 = "e";
			break;
	}

	var_02 = level.players[0];
	foreach(var_04 in level.players)
	{
		if(!maps\mp\_utility::func_4945(var_04))
		{
			continue;
		}

		if(maps\mp\gametypes\_horde_util::func_4934(var_04))
		{
			continue;
		}

		var_02 = var_04;
		break;
	}

	if(maps\mp\_utility::func_21E7() > maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 > maps\mp\_utility::maxvehiclesallowed())
	{
	}

	maps\mp\_utility::func_4487();
	level thread maps\mp\killstreaks\_airdrop::func_2896(var_02,param_00,randomfloat(360),var_01);
}

//Function Number: 72
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 73
getspawnpoint()
{
	if(self.gamemodefirstspawn && isplayer(self))
	{
		lib_05D5::addtoteam(level.playerteam,1);
	}

	var_00 = self.team;
	if(maps\mp\gametypes\_horde_util::isonhumanteam(self))
	{
		var_01 = maps\mp\gametypes\_spawnlogic::func_3C41(var_00);
		if(level.ingraceperiod)
		{
			var_02 = maps\mp\gametypes\_spawnlogic::func_3BF2(var_01);
		}
		else
		{
			var_02 = maps\mp\gametypes\_spawnscoring::func_3BF1(var_02);
		}

		return var_02;
	}

	var_01 = maps\mp\gametypes\_spawnlogic::func_3C41(var_02);
	var_02 = maps\mp\gametypes\_spawnscoring::func_3BF3(var_02);
	return var_02;
}

//Function Number: 74
getagentdamagescalar()
{
	var_00 = 0.25;
	var_01 = maps\mp\gametypes\_horde_util::func_3B5B();
	switch(var_01)
	{
		case 0:
			var_00 = 0.09;
			break;

		case 1:
			var_00 = 0.09;
			break;

		case 2:
			var_00 = 0.1;
			break;

		case 3:
			var_00 = 0.125;
			break;

		case 4:
		default:
			var_00 = 0.125;
			break;
	}

	return var_00;
}

//Function Number: 75
func_5327(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(isdefined(param_01) && isdefined(param_01.team) && param_01.team == param_00.team)
	{
		return 0;
	}

	if(isdefined(param_01) && isplayer(param_01))
	{
		if(param_00 == param_01 && maps\mp\_utility::func_48F7(param_04))
		{
			param_02 = 0;
		}

		var_08 = getweaponbasename(param_04);
		if(func_4029(param_01,var_08))
		{
			param_02 = int(param_02 + param_02 * 0.1 * param_01.weaponstate[var_08]["level"] - 1);
		}

		if(param_00.team == level.enemyteam && param_01.team == level.playerteam)
		{
			if(param_03 == "MOD_MELEE")
			{
				param_02 = param_00.maxhealth + 1;
				if(param_00.horde_type == "Blaster")
				{
					param_02 = int(param_00.maxhealth * 0.7);
				}
			}

			if(maps\mp\_utility::func_48F7(param_04))
			{
				param_02 = int(param_02 + 20 * level.currentroundnumber);
			}

			if(isdefined(level.killstreakweildweapons[param_04]) && level.killstreakweildweapons[param_04] == "heli_sniper")
			{
				param_02 = int(param_00.maxhealth) + 1;
			}

			if(maps\mp\gametypes\_class::func_499E(param_04,0))
			{
				if(isexplosivedamagemod(param_03))
				{
					param_02 = int(param_00.maxhealth) + 1;
				}

				if(param_04 == "throwingknife_mp")
				{
					param_02 = param_00.maxhealth + 1;
					if(param_00.horde_type == "Blaster")
					{
						param_02 = int(param_00.maxhealth * 0.7);
					}
				}
			}

			param_01 func_3D02(param_00,param_02,param_03,param_04,param_05,param_06,param_07,0);
		}
	}

	if(isdefined(param_01) && isdefined(param_01.owner) && isplayer(param_01.owner))
	{
		var_09 = 0;
		if(maps\mp\_utility::func_48F7(param_04))
		{
			param_02 = int(param_02 + 20 * level.currentroundnumber);
		}

		if(isagent(param_01))
		{
			param_02 = int(param_02 + param_02 * 0.1 * level.currentroundnumber - 2);
			var_09 = 1;
		}

		param_01.owner func_3D02(param_00,param_02,param_03,param_04,param_05,param_06,param_07,var_09);
	}

	if(isplayer(param_00) || maps\mp\gametypes\_horde_util::isonhumanteam(param_00))
	{
		if(maps\mp\gametypes\_horde_util::func_4934(param_00) && !param_00 maps\mp\_utility::func_818D())
		{
			return 0;
		}

		if(isdefined(param_00.onhelisniper) && param_00.onhelisniper)
		{
			return 0;
		}

		if(param_04 == "semtexproj_mp")
		{
			param_02 = param_02 * 3;
		}

		if(isplayer(param_00))
		{
			param_02 = int(param_02 * 0.125);
		}
		else
		{
			param_02 = int(param_02 * getagentdamagescalar());
		}

		if(isdefined(param_01) && isagent(param_01))
		{
			param_01 hudoutlineenable(level.enemyoutlinecolor,0);
			param_01.outlinecolor = level.enemyoutlinecolor;
			if(param_03 == "MOD_MELEE")
			{
				param_02 = int(param_00.maxhealth / 2) + 1;
			}

			if(param_01.agent_type == "dog")
			{
				param_02 = int(param_00.maxhealth / 4) + 1;
			}
		}

		if(isdefined(param_00.isreviving) && param_00.isreviving)
		{
			if(isagent(param_00))
			{
				param_02 = 0;
			}

			if(isplayer(param_00))
			{
				param_02 = int(param_02 * 0.9);
			}
		}

		if(param_00 maps\mp\_utility::func_4995() && param_00 maps\mp\_utility::func_3BD3() == "remotemissile")
		{
			param_02 = int(param_02 * 0.9);
		}
	}

	return param_02;
}

//Function Number: 76
func_3D02(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = maps\mp\_utility::func_48D2(param_03,param_06,param_02,self);
	var_09 = param_02 == "MOD_MELEE" || param_02 == "MOD_IMPACT";
	var_0A = param_01 >= param_00.health;
	if(var_09 && param_06 == "shield")
	{
	}

	var_0B = undefined;
	if(var_0A)
	{
		if(var_09)
		{
			var_0B = "kill_melee";
		}
		else if(var_08)
		{
			var_0B = "kill_head";
		}
		else
		{
			var_0B = "kill_normal";
		}

		self notify("horde_kill",param_00,param_03,param_02);
	}
	else if(var_08)
	{
		var_0B = "damage_head";
	}
	else
	{
		var_0B = "damage_body";
	}

	givepointsforevent(var_0B,param_03,param_07);
}

//Function Number: 77
givepointsforevent(param_00,param_01,param_02)
{
	var_03 = level.pointevents[param_00];
	self.pointnotifylua[self.pointnotifylua.size] = var_03;
	maps\mp\gametypes\_gamescore::func_3D00(param_00,self,undefined,1,1,1);
	thread maps\mp\gametypes\_rank::giverankxp(param_00);
	level.currentpointtotal = level.currentpointtotal + var_03;
	level notify("pointsEarned");
	if(param_02)
	{
	}

	var_04 = getweaponbasename(param_01);
	if(func_4029(self,var_04))
	{
		self.weaponstate[var_04]["vaule"] = self.weaponstate[var_04]["vaule"] + var_03;
		self notify("weaponPointsEarned");
	}
}

//Function Number: 78
func_9347(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	for(;;)
	{
		if(param_00.pointnotifylua.size > 0)
		{
			param_00 setclientomnvar("ui_horde_award_points",param_00.pointnotifylua[param_00.pointnotifylua.size - 1]);
			param_00.pointnotifylua = func_9402(param_00.pointnotifylua);
		}

		wait(0.05);
	}
}

//Function Number: 79
func_9402(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size - 1;var_02++)
	{
		var_01[var_02] = param_00[var_02];
	}

	return var_01;
}

//Function Number: 80
onnormaldeath(param_00,param_01,param_02)
{
	func_65A5(param_00);
	if(!isdefined(param_01))
	{
	}

	if(game["state"] == "postgame" && game["teamScores"][param_01.team] > game["teamScores"][level.otherteam[param_01.team]])
	{
		param_01.finalkill = 1;
	}
}

//Function Number: 81
func_65A5(param_00)
{
	if(isplayer(param_00))
	{
		param_00 setclientomnvar("ui_horde_update_perk",0);
		param_00.horde_perks = [];
	}
}

//Function Number: 82
chancetospawnpickup(param_00)
{
	if(level.currentpickupcount == level.maxpickupsperround)
	{
	}

	level endon("game_ended");
	var_01 = randomintrange(1,101);
	if(var_01 > level.percentchancetodrop)
	{
	}

	var_02 = level.weaponpickupmodel;
	var_03 = level.weaponpickupfunc;
	if(level.currentammopickupcount < level.maxammopickupsperround && common_scripts\utility::func_1DE9())
	{
		var_02 = level.ammopickupmodel;
		var_03 = level.ammopickupfunc;
		level.currentammopickupcount++;
	}

	func_78B4(param_00.origin + (0,0,14),var_02,var_03);
}

//Function Number: 83
func_78B4(param_00,param_01,param_02)
{
	var_03[0] = spawn("script_model",(0,0,0));
	var_03[0] setmodel(param_01);
	var_03[0] hudoutlineenable(1,0);
	var_04 = spawn("trigger_radius",(0,0,0),0,32,32);
	var_05 = maps\mp\gametypes\_gameobjects::func_212D(level.playerteam,var_04,var_03,(0,0,16));
	maps\mp\_utility::_objective_delete(var_05.teamobjids["allies"]);
	maps\mp\_utility::_objective_delete(var_05.teamobjids["axis"]);
	maps\mp\gametypes\_objpoints::deleteobjpoint(var_05.objpoints["allies"]);
	maps\mp\gametypes\_objpoints::deleteobjpoint(var_05.objpoints["axis"]);
	var_06 = param_00;
	var_05.curorigin = var_06;
	var_05.trigger.origin = var_06;
	var_05.visuals[0].origin = var_06;
	var_05 maps\mp\gametypes\_gameobjects::func_720E(0);
	var_05 maps\mp\gametypes\_gameobjects::allowuse("friendly");
	var_05.onuse = param_02;
	level.currentpickupcount++;
	var_05 thread func_5BFB();
	var_05 thread pickuptimer();
}

//Function Number: 84
func_5BFB()
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

//Function Number: 85
pickuptimer()
{
	self endon("deleted");
	wait(15);
	thread func_5C01();
	wait(8);
	level thread removepickup(self);
}

//Function Number: 86
func_5C01()
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

//Function Number: 87
removepickup(param_00)
{
	param_00 notify("deleted");
	wait(0.05);
	param_00.trigger delete();
	param_00.visuals[0] delete();
}

//Function Number: 88
func_8DB2(param_00)
{
	if(!isplayer(param_00))
	{
	}

	var_01 = maps\mp\gametypes\_horde_util::getplayerweaponhorde(param_00);
	var_02 = getweaponbasename(var_01);
	if(func_4029(param_00,var_02))
	{
		var_03 = param_00.weaponstate[var_02]["barSize"];
		param_00.weaponstate[var_02]["vaule"] = var_03;
		param_00 notify("weaponPointsEarned");
	}

	level thread removepickup(self);
}

//Function Number: 89
ammopickup(param_00)
{
	foreach(var_02 in level.players)
	{
		if(maps\mp\gametypes\_horde_util::isonhumanteam(var_02) && maps\mp\_utility::func_4945(var_02))
		{
			var_02 thread maps\mp\gametypes\_hud_message::func_794C("horde_team_restock");
			maps\mp\gametypes\_horde_util::func_93E8(var_02);
			var_02.health = var_02.maxhealth;
		}
	}

	param_00 playlocalsound("mp_safe_team_ammo");
	playfx(level._effect["weapon_level"],param_00.origin + (0,0,func_3C7A(param_00)));
	level thread removepickup(self);
}

//Function Number: 90
hordemaydropweapon(param_00)
{
	if(param_00 == level.playerstartweaponname)
	{
		return 0;
	}

	return 1;
}

//Function Number: 91
dropweaponfordeathhorde(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_horde_util::getplayerweaponhorde(self);
	if(var_02 == level.intelminigun)
	{
		var_02 = maps\mp\killstreaks\_killstreaks::func_3AAA();
	}

	if(!hordemaydropweapon(var_02))
	{
	}

	var_03 = (0,0,18);
	var_04 = spawn("script_model",self.origin + var_03);
	var_04 hide();
	var_04 setmodel("mp_weapon_crate");
	var_04.owner = self;
	var_04.curorigin = self.origin + var_03;
	var_04.trackingweaponname = var_02;
	var_04 hudoutlineenable(1,0);
	var_04.trigger = spawn("trigger_radius",self.origin + var_03,0,32,32);
	foreach(var_06 in level.players)
	{
		if(var_04.owner == var_06)
		{
			var_04 showtoplayer(var_04.owner);
		}
	}

	var_04 thread func_5BFB();
	var_04 thread watchweaponpickuphorde();
	var_04 thread func_65BD();
}

//Function Number: 92
watchweaponpickuphorde()
{
	self endon("death");
	for(;;)
	{
		self.trigger waittill("trigger",var_00);
		if(var_00 == self.owner)
		{
			break;
		}
	}

	maps\mp\gametypes\_horde_crates::func_83FF(var_00,self.trackingweaponname);
	var_00 thread maps\mp\gametypes\_hud_message::func_794C("horde_recycle");
	var_00 playlocalsound("mp_safe_weapon_up");
	playfx(level._effect["weapon_level"],var_00.origin + (0,0,func_3C7A(var_00)));
	self.trigger delete();
	self delete();
}

//Function Number: 93
func_65BD()
{
	self endon("death");
	level endon("game_ended");
	self.owner common_scripts\utility::func_8B2A("started_spawnPlayer","disconnect");
	wait(22);
	thread func_7B01();
	wait(8);
	if(!isdefined(self))
	{
	}

	self.trigger delete();
	self delete();
}

//Function Number: 94
func_7B01()
{
	self endon("trigger");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self hide();
		wait(0.25);
		self showtoplayer(self.owner);
		wait(0.25);
	}
}

//Function Number: 95
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

//Function Number: 96
func_70CF()
{
	level.hordeloadouts["allies"]["loadoutPrimary"] = "none";
	level.hordeloadouts["allies"]["loadoutPrimaryAttachment"] = "none";
	level.hordeloadouts["allies"]["loadoutPrimaryAttachment2"] = "none";
	level.hordeloadouts["allies"]["loadoutPrimaryBuff"] = "specialty_null";
	level.hordeloadouts["allies"]["loadoutPrimaryCamo"] = "none";
	level.hordeloadouts["allies"]["loadoutPrimaryReticle"] = "none";
	level.hordeloadouts["allies"]["loadoutSecondary"] = "iw6_mp443";
	level.hordeloadouts["allies"]["loadoutSecondaryAttachment"] = "xmags";
	level.hordeloadouts["allies"]["loadoutSecondaryAttachment2"] = "none";
	level.hordeloadouts["allies"]["loadoutSecondaryBuff"] = "specialty_null";
	level.hordeloadouts["allies"]["loadoutSecondaryCamo"] = "none";
	level.hordeloadouts["allies"]["loadoutSecondaryReticle"] = "none";
	level.hordeloadouts["allies"]["loadoutEquipment"] = "proximity_explosive_mp";
	level.hordeloadouts["allies"]["loadoutOffhand"] = "concussion_grenade_mp";
	level.hordeloadouts["allies"]["loadoutStreakType"] = "assault";
	level.hordeloadouts["allies"]["loadoutKillstreak1"] = "none";
	level.hordeloadouts["allies"]["loadoutKillstreak2"] = "none";
	level.hordeloadouts["allies"]["loadoutKillstreak3"] = "none";
	level.hordeloadouts["allies"]["loadoutJuggernaut"] = 0;
	level.hordeloadouts["allies"]["loadoutPerks"] = ["specialty_falldamage"];
	level.hordeloadouts["squadmate"]["loadoutPrimary"] = "iw6_ak12";
	level.hordeloadouts["squadmate"]["loadoutPrimaryAttachment"] = "none";
	level.hordeloadouts["squadmate"]["loadoutPrimaryAttachment2"] = "none";
	level.hordeloadouts["squadmate"]["loadoutPrimaryBuff"] = "specialty_null";
	level.hordeloadouts["squadmate"]["loadoutPrimaryCamo"] = "none";
	level.hordeloadouts["squadmate"]["loadoutPrimaryReticle"] = "none";
	level.hordeloadouts["squadmate"]["loadoutSecondary"] = "none";
	level.hordeloadouts["squadmate"]["loadoutSecondaryAttachment"] = "none";
	level.hordeloadouts["squadmate"]["loadoutSecondaryAttachment2"] = "none";
	level.hordeloadouts["squadmate"]["loadoutSecondaryBuff"] = "specialty_null";
	level.hordeloadouts["squadmate"]["loadoutSecondaryCamo"] = "none";
	level.hordeloadouts["squadmate"]["loadoutSecondaryReticle"] = "none";
	level.hordeloadouts["squadmate"]["loadoutEquipment"] = "proximity_explosive_mp";
	level.hordeloadouts["squadmate"]["loadoutOffhand"] = "concussion_grenade_mp";
	level.hordeloadouts["squadmate"]["loadoutStreakType"] = "assault";
	level.hordeloadouts["squadmate"]["loadoutKillstreak1"] = "none";
	level.hordeloadouts["squadmate"]["loadoutKillstreak2"] = "none";
	level.hordeloadouts["squadmate"]["loadoutKillstreak3"] = "none";
	level.hordeloadouts["squadmate"]["loadoutJuggernaut"] = 0;
	level.hordeloadouts["squadmate"]["loadoutPerks"] = ["specialty_falldamage"];
	level.hordeloadouts["axis"]["a"]["loadoutPrimary"] = "iw6_maul";
	level.hordeloadouts["axis"]["a"]["loadoutPrimaryAttachment"] = "none";
	level.hordeloadouts["axis"]["a"]["loadoutPrimaryAttachment2"] = "none";
	level.hordeloadouts["axis"]["a"]["loadoutPrimaryBuff"] = "specialty_null";
	level.hordeloadouts["axis"]["a"]["loadoutPrimaryCamo"] = "none";
	level.hordeloadouts["axis"]["a"]["loadoutPrimaryReticle"] = "none";
	level.hordeloadouts["axis"]["a"]["loadoutSecondary"] = "none";
	level.hordeloadouts["axis"]["a"]["loadoutSecondaryAttachment"] = "none";
	level.hordeloadouts["axis"]["a"]["loadoutSecondaryAttachment2"] = "none";
	level.hordeloadouts["axis"]["a"]["loadoutSecondaryBuff"] = "specialty_null";
	level.hordeloadouts["axis"]["a"]["loadoutSecondaryCamo"] = "none";
	level.hordeloadouts["axis"]["a"]["loadoutSecondaryReticle"] = "none";
	level.hordeloadouts["axis"]["a"]["loadoutEquipment"] = "specialty_null";
	level.hordeloadouts["axis"]["a"]["loadoutOffhand"] = "none";
	level.hordeloadouts["axis"]["a"]["loadoutStreakType"] = "assault";
	level.hordeloadouts["axis"]["a"]["loadoutKillstreak1"] = "none";
	level.hordeloadouts["axis"]["a"]["loadoutKillstreak2"] = "none";
	level.hordeloadouts["axis"]["a"]["loadoutKillstreak3"] = "none";
	level.hordeloadouts["axis"]["a"]["loadoutJuggernaut"] = 0;
	level.hordeloadouts["axis"]["a"]["name_localized"] = &"HORDE_RAVAGER";
	level.hordeloadouts["axis"]["a"]["type"] = "Ravager";
	level.hordeloadouts["axis"]["a"]["loadoutPerks"] = ["specialty_falldamage"];
	level.hordeloadouts["axis"]["b"]["loadoutPrimary"] = "iw6_vepr";
	level.hordeloadouts["axis"]["b"]["loadoutPrimaryAttachment"] = "none";
	level.hordeloadouts["axis"]["b"]["loadoutPrimaryAttachment2"] = "none";
	level.hordeloadouts["axis"]["b"]["loadoutPrimaryBuff"] = "specialty_null";
	level.hordeloadouts["axis"]["b"]["loadoutPrimaryCamo"] = "none";
	level.hordeloadouts["axis"]["b"]["loadoutPrimaryReticle"] = "none";
	level.hordeloadouts["axis"]["b"]["loadoutSecondary"] = "none";
	level.hordeloadouts["axis"]["b"]["loadoutSecondaryAttachment"] = "none";
	level.hordeloadouts["axis"]["b"]["loadoutSecondaryAttachment2"] = "none";
	level.hordeloadouts["axis"]["b"]["loadoutSecondaryBuff"] = "specialty_null";
	level.hordeloadouts["axis"]["b"]["loadoutSecondaryCamo"] = "none";
	level.hordeloadouts["axis"]["b"]["loadoutSecondaryReticle"] = "none";
	level.hordeloadouts["axis"]["b"]["loadoutEquipment"] = "specialty_null";
	level.hordeloadouts["axis"]["b"]["loadoutOffhand"] = "none";
	level.hordeloadouts["axis"]["b"]["loadoutStreakType"] = "assault";
	level.hordeloadouts["axis"]["b"]["loadoutKillstreak1"] = "none";
	level.hordeloadouts["axis"]["b"]["loadoutKillstreak2"] = "none";
	level.hordeloadouts["axis"]["b"]["loadoutKillstreak3"] = "none";
	level.hordeloadouts["axis"]["b"]["loadoutJuggernaut"] = 0;
	level.hordeloadouts["axis"]["b"]["name_localized"] = &"HORDE_ENFORCER";
	level.hordeloadouts["axis"]["b"]["type"] = "Enforcer";
	level.hordeloadouts["axis"]["b"]["loadoutPerks"] = ["specialty_falldamage"];
	level.hordeloadouts["axis"]["c"]["loadoutPrimary"] = "iw6_riotshield";
	level.hordeloadouts["axis"]["c"]["loadoutPrimaryAttachment"] = "none";
	level.hordeloadouts["axis"]["c"]["loadoutPrimaryAttachment2"] = "none";
	level.hordeloadouts["axis"]["c"]["loadoutPrimaryBuff"] = "specialty_null";
	level.hordeloadouts["axis"]["c"]["loadoutPrimaryCamo"] = "none";
	level.hordeloadouts["axis"]["c"]["loadoutPrimaryReticle"] = "none";
	level.hordeloadouts["axis"]["c"]["loadoutSecondary"] = "none";
	level.hordeloadouts["axis"]["c"]["loadoutSecondaryAttachment"] = "none";
	level.hordeloadouts["axis"]["c"]["loadoutSecondaryAttachment2"] = "none";
	level.hordeloadouts["axis"]["c"]["loadoutSecondaryBuff"] = "specialty_null";
	level.hordeloadouts["axis"]["c"]["loadoutSecondaryCamo"] = "none";
	level.hordeloadouts["axis"]["c"]["loadoutSecondaryReticle"] = "none";
	level.hordeloadouts["axis"]["c"]["loadoutEquipment"] = "specialty_null";
	level.hordeloadouts["axis"]["c"]["loadoutOffhand"] = "none";
	level.hordeloadouts["axis"]["c"]["loadoutStreakType"] = "assault";
	level.hordeloadouts["axis"]["c"]["loadoutKillstreak1"] = "none";
	level.hordeloadouts["axis"]["c"]["loadoutKillstreak2"] = "none";
	level.hordeloadouts["axis"]["c"]["loadoutKillstreak3"] = "none";
	level.hordeloadouts["axis"]["c"]["loadoutJuggernaut"] = 0;
	level.hordeloadouts["axis"]["c"]["name_localized"] = &"HORDE_STRIKER";
	level.hordeloadouts["axis"]["c"]["type"] = "Striker";
	level.hordeloadouts["axis"]["c"]["loadoutPerks"] = ["specialty_falldamage"];
	level.hordeloadouts["axis"]["d"]["loadoutPrimary"] = "none";
	level.hordeloadouts["axis"]["d"]["loadoutPrimaryAttachment"] = "none";
	level.hordeloadouts["axis"]["d"]["loadoutPrimaryAttachment2"] = "none";
	level.hordeloadouts["axis"]["d"]["loadoutPrimaryBuff"] = "specialty_null";
	level.hordeloadouts["axis"]["d"]["loadoutPrimaryCamo"] = "none";
	level.hordeloadouts["axis"]["d"]["loadoutPrimaryReticle"] = "none";
	level.hordeloadouts["axis"]["d"]["loadoutSecondary"] = "iw6_mk32horde";
	level.hordeloadouts["axis"]["d"]["loadoutSecondaryAttachment"] = "none";
	level.hordeloadouts["axis"]["d"]["loadoutSecondaryAttachment2"] = "none";
	level.hordeloadouts["axis"]["d"]["loadoutSecondaryBuff"] = "specialty_null";
	level.hordeloadouts["axis"]["d"]["loadoutSecondaryCamo"] = "none";
	level.hordeloadouts["axis"]["d"]["loadoutSecondaryReticle"] = "none";
	level.hordeloadouts["axis"]["d"]["loadoutEquipment"] = "specialty_null";
	level.hordeloadouts["axis"]["d"]["loadoutOffhand"] = "none";
	level.hordeloadouts["axis"]["d"]["loadoutStreakType"] = "assault";
	level.hordeloadouts["axis"]["d"]["loadoutKillstreak1"] = "none";
	level.hordeloadouts["axis"]["d"]["loadoutKillstreak2"] = "none";
	level.hordeloadouts["axis"]["d"]["loadoutKillstreak3"] = "none";
	level.hordeloadouts["axis"]["d"]["loadoutJuggernaut"] = 0;
	level.hordeloadouts["axis"]["d"]["name_localized"] = &"HORDE_BLASTER";
	level.hordeloadouts["axis"]["d"]["type"] = "Blaster";
	level.hordeloadouts["axis"]["d"]["loadoutPerks"] = ["specialty_falldamage"];
	level.hordeloadouts["axis"]["e"]["loadoutPrimary"] = "iw6_kac";
	level.hordeloadouts["axis"]["e"]["loadoutPrimaryAttachment"] = "flashsuppress";
	level.hordeloadouts["axis"]["e"]["loadoutPrimaryAttachment2"] = "none";
	level.hordeloadouts["axis"]["e"]["loadoutPrimaryBuff"] = "specialty_null";
	level.hordeloadouts["axis"]["e"]["loadoutPrimaryCamo"] = "none";
	level.hordeloadouts["axis"]["e"]["loadoutPrimaryReticle"] = "none";
	level.hordeloadouts["axis"]["e"]["loadoutSecondary"] = "none";
	level.hordeloadouts["axis"]["e"]["loadoutSecondaryAttachment"] = "none";
	level.hordeloadouts["axis"]["e"]["loadoutSecondaryAttachment2"] = "none";
	level.hordeloadouts["axis"]["e"]["loadoutSecondaryBuff"] = "specialty_null";
	level.hordeloadouts["axis"]["e"]["loadoutSecondaryCamo"] = "none";
	level.hordeloadouts["axis"]["e"]["loadoutSecondaryReticle"] = "none";
	level.hordeloadouts["axis"]["e"]["loadoutEquipment"] = "specialty_null";
	level.hordeloadouts["axis"]["e"]["loadoutOffhand"] = "none";
	level.hordeloadouts["axis"]["e"]["loadoutStreakType"] = "assault";
	level.hordeloadouts["axis"]["e"]["loadoutKillstreak1"] = "none";
	level.hordeloadouts["axis"]["e"]["loadoutKillstreak2"] = "none";
	level.hordeloadouts["axis"]["e"]["loadoutKillstreak3"] = "none";
	level.hordeloadouts["axis"]["e"]["loadoutJuggernaut"] = 0;
	level.hordeloadouts["axis"]["e"]["name_localized"] = &"HORDE_HAMMER";
	level.hordeloadouts["axis"]["e"]["type"] = "Hammer";
	level.hordeloadouts["axis"]["e"]["loadoutPerks"] = ["specialty_falldamage"];
}

//Function Number: 97
func_3ACD()
{
	var_00 = level.hordeloadouts["axis"]["a"];
	if(level.currentroundnumber < 5)
	{
		return var_00;
	}

	if(level.currentroundnumber < 9)
	{
		if(common_scripts\utility::func_1DE9())
		{
			var_00 = level.hordeloadouts["axis"]["b"];
		}

		return var_00;
	}

	var_00 = level.hordeloadouts["axis"]["b"];
	if(level.currentroundnumber < 13)
	{
		if(randomintrange(1,11) < 4)
		{
			var_00 = level.hordeloadouts["axis"]["c"];
		}

		return var_00;
	}

	if(level.currentroundnumber < 16)
	{
		var_01 = randomintrange(1,11);
		if(var_01 < 4)
		{
			var_00 = level.hordeloadouts["axis"]["d"];
		}

		return var_00;
	}

	if(level.currentroundnumber < 24)
	{
		var_01 = randomintrange(1,11);
		if(var_01 < 3)
		{
			var_00 = level.hordeloadouts["axis"]["c"];
		}
		else if(var_01 < 5)
		{
			var_00 = level.hordeloadouts["axis"]["d"];
		}

		return var_00;
	}

	var_01 = level.hordeloadouts["axis"]["e"];
	var_01 = randomintrange(1,11);
	if(var_01 < 3)
	{
		var_00 = level.hordeloadouts["axis"]["c"];
	}
	else if(var_01 < 4)
	{
		var_00 = level.hordeloadouts["axis"]["d"];
	}

	var_02 = 0;
	if(var_00["type"] == "Blaster")
	{
		var_03 = 0;
		foreach(var_05 in level.participants)
		{
			if(isai(var_05) && isdefined(var_05.horde_type))
			{
				if(var_05.horde_type == var_00["type"])
				{
					var_03++;
					if(var_03 >= 4)
					{
						var_02 = 1;
						break;
					}
				}
			}
		}
	}

	if(var_02)
	{
		var_00 = level.hordeloadouts["axis"]["a"];
		if(common_scripts\utility::func_1DE9())
		{
			var_00 = level.hordeloadouts["axis"]["b"];
		}
	}

	return var_00;
}