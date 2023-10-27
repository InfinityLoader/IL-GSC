/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\gun.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 458 ms
 * Timestamp: 10/27/2023 2:38:13 AM
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
		maps\mp\_utility::registertimelimitdvar(level.gametype,10);
		level thread reinitializescorelimitonmigration();
		maps\mp\_utility::registerroundlimitdvar(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,0);
		maps\mp\_utility::registernumlivesdvar(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
		setdynamicdvar("scr_game_hardpoints",0);
	}

	level.gun_cyclecount = maps\mp\_utility::getintproperty("scr_gun_cycleCount",1);
	level.gun_weaponlist = maps\mp\_utility::getintproperty("scr_gun_weaponList",0);
	level.gun_weaponorder = maps\mp\_utility::getintproperty("scr_gun_weaponOrder",0);
	level.gun_weaponattachments = maps\mp\_utility::getintproperty("scr_gun_weaponAttachments",0);
	level.gun_weaponlistend = maps\mp\_utility::getintproperty("scr_gun_weaponListEnd",0);
	setguns();
	setscorelimit();
	level.teambased = 0;
	level.doprematch = 1;
	level.onstartgametype = ::onstartgametype;
	level.onspawnplayer = ::onspawnplayer;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.ontimelimit = ::ontimelimit;
	level.onplayerscore = ::onplayerscore;
	level.bypassclasschoicefunc = ::gungameclass;
	level.streamprimariesfunc = ::streamprimariesfunc;
	level.assists_disabled = 1;
	level.setbacklevel = maps\mp\_utility::getintproperty("scr_gun_setBackLevels",1);
	level.lastguntimevo = 0;
	if(level.matchrules_damagemultiplier)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	setteammode("ffa");
	game["dialog"]["gametype"] = "gg_intro";
	game["dialog"]["defense_obj"] = "gbl_start";
	game["dialog"]["offense_obj"] = "gbl_start";
	game["dialog"]["humiliation"] = "gg_humiliation";
	game["dialog"]["lastgun"] = "gg_lastgun";
}

//Function Number: 2
gundebug()
{
	var_00 = "scr_gun_force_next";
	var_01 = "scr_gun_force_prev";
	setdvar(var_00,0);
	setdvar(var_01,0);
	while(!isdefined(level.player))
	{
		wait 0.05;
	}

	for(;;)
	{
		wait(0.1);
		if(getdvarint(var_00,0))
		{
			level.player.gungameprevgunindex = level.player.gungamegunindex;
			level.player.gungamegunindex++;
			level.player givenextgun();
			setdvar(var_00,0);
			continue;
		}

		if(getdvarint(var_01,0))
		{
			level.player.gungameprevgunindex = level.player.gungamegunindex;
			level.player.gungamegunindex--;
			while(level.player.gungamegunindex < 0)
			{
				level.player.gungamegunindex = level.player.gungamegunindex + level.gun_guns.size;
			}

			level.player givenextgun();
			setdvar(var_01,0);
		}
	}
}

//Function Number: 3
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata(1);
	setdynamicdvar("scr_gun_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("gun",1);
	setdynamicdvar("scr_gun_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar("gun",1);
	setdynamicdvar("scr_gun_halftime",0);
	maps\mp\_utility::registerhalftimedvar("gun",0);
	setdynamicdvar("scr_gun_playerrespawndelay",0);
	setdynamicdvar("scr_gun_waverespawndelay",0);
	setdynamicdvar("scr_player_forcerespawn",1);
	setdynamicdvar("scr_gun_setBackLevels",getmatchrulesdata("gunData","setbackLevels"));
	setdynamicdvar("scr_gun_cycleCount",getmatchrulesdata("gunData","cycleCount"));
	setdynamicdvar("scr_gun_weaponList",getmatchrulesdata("gunData","weaponList"));
	setdynamicdvar("scr_gun_weaponOrder",getmatchrulesdata("gunData","weaponOrder"));
	setdynamicdvar("scr_gun_weaponAttachments",getmatchrulesdata("gunData","weaponAttachments"));
	setdynamicdvar("scr_gun_weaponListEnd",getmatchrulesdata("gunData","weaponListEnd"));
	setdynamicdvar("scr_game_hardpoints",0);
}

//Function Number: 4
setscorelimit()
{
	setdynamicdvar("scr_gun_scorelimit",level.gun_guns.size * level.gun_cyclecount);
	maps\mp\_utility::registerscorelimitdvar(level.gametype,level.gun_guns.size * level.gun_cyclecount);
}

//Function Number: 5
reinitializescorelimitonmigration()
{
	for(;;)
	{
		level waittill("host_migration_begin");
		setscorelimit();
		setdynamicdvar("scr_game_hardpoints",0);
	}
}

//Function Number: 6
onstartgametype()
{
	setclientnamemode("auto_change");
	maps\mp\_utility::setobjectivetext("allies",&"OBJECTIVES_GUN");
	maps\mp\_utility::setobjectivetext("axis",&"OBJECTIVES_GUN");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_GUN");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_GUN");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_GUN_SCORE");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_GUN_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_GUN_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_GUN_HINT");
	initspawns();
	var_00 = [];
	maps\mp\gametypes\_gameobjects::main(var_00);
	level.quickmessagetoall = 1;
	level.blockweapondrops = 1;
	level thread onplayerconnect();
}

//Function Number: 7
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_dm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_dm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 8
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.gungamegunindex = 0;
		var_00.gungameprevgunindex = 0;
		var_00.stabs = 0;
		var_00.mysetbacks = 0;
		var_00.lastleveluptime = 0;
		var_00.showsetbacksplash = 0;
		var_00 thread refillammo();
		var_00 thread refillsinglecountammo();
	}
}

//Function Number: 9
getspawnpoint()
{
	if(level.ingraceperiod)
	{
		var_00 = maps\mp\gametypes\_spawnlogic::getstartspawnffa(self.pers["team"]);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.pers["team"]);
		var_00 = maps\mp\gametypes\_spawnscoring::getspawnpoint_freeforall(var_01);
	}

	maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_00);
	return var_00;
}

//Function Number: 10
gungameclass()
{
	self.pers["class"] = "gamemode";
	self.pers["lastClass"] = "";
	self.class = self.pers["class"];
	self.lastclass = self.pers["lastClass"];
	gungameclassupdate(level.gun_guns[0]);
}

//Function Number: 11
gungameclassupdate(param_00)
{
	self.pers["gamemodeLoadout"] = maps\mp\gametypes\_class::getemptyloadout();
	if(!maps\mp\gametypes\_class::isvalidprimary(param_00.basename))
	{
		self.pers["loadoutSecondary"] = param_00.fullname;
		return;
	}

	self.pers["loadoutPrimary"] = param_00.fullname;
}

//Function Number: 12
streamprimariesfunc()
{
	var_00 = [];
	foreach(var_02 in level.gun_guns)
	{
		var_00[var_00.size] = var_02.fullname;
	}

	var_04 = [];
	foreach(var_02 in var_00)
	{
		var_06 = ["axis","allies"];
		foreach(var_08 in var_06)
		{
			var_09 = spawnstruct();
			var_09.team = var_08;
			var_09.weapon = var_02;
			var_04[var_04.size] = var_09;
		}
	}

	self method_8420(var_04,var_00);
}

//Function Number: 13
onspawnplayer()
{
	thread waitloadoutdone();
}

//Function Number: 14
waitloadoutdone()
{
	level endon("game_ended");
	self endon("disconnect");
	level waittill("player_spawned");
	givenextgun(1);
	if(self.showsetbacksplash)
	{
		self.showsetbacksplash = 0;
		thread maps\mp\_events::decreasegunlevelevent();
	}
}

//Function Number: 15
onplayerscore(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_rank::getscoreinfovalue(param_00);
	param_01 maps\mp\_utility::setextrascore0(param_01.extrascore0 + var_03);
	param_01 maps\mp\gametypes\_gamescores::updatescorestatsffa(param_01,var_03);
	if(param_00 == "gained_gun_score")
	{
		return 1;
	}

	if(param_00 == "dropped_gun_score")
	{
		var_04 = min(level.setbacklevel,self.score);
		return int(var_04 * -1);
	}

	return 0;
}

//Function Number: 16
isdedicatedmeleeweapon(param_00)
{
	if(weaponinventorytype(param_00) == "melee")
	{
		return 1;
	}

	return 0;
}

//Function Number: 17
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(param_03 == "MOD_TRIGGER_HURT" && !isplayer(param_01))
	{
		param_01 = self;
	}

	if(isdefined(param_04) && maps\mp\_utility::isdestructibleweapon(param_04) && param_01 != self)
	{
		return;
	}

	if(isdefined(param_04) && maps\mp\_utility::isenvironmentweapon(param_04))
	{
		return;
	}

	if(param_03 == "MOD_FALLING" || isplayer(param_01))
	{
		if(param_03 == "MOD_FALLING" || param_01 == self || maps\mp\_utility::ismeleemod(param_03) && !isdedicatedmeleeweapon(param_04))
		{
			self playlocalsound("mp_war_objective_lost");
			self.gungameprevgunindex = self.gungamegunindex;
			self.gungamegunindex = int(max(0,self.gungamegunindex - level.setbacklevel));
			if(self.gungameprevgunindex > self.gungamegunindex)
			{
				self.mysetbacks++;
				maps\mp\_utility::setextrascore1(self.mysetbacks);
				self.showsetbacksplash = 1;
				if(maps\mp\_utility::ismeleemod(param_03))
				{
					param_01.stabs++;
					param_01.assists = param_01.stabs;
					param_01 thread maps\mp\_events::setbackenemygunlevelevent();
					if(self.gungameprevgunindex == level.gun_guns.size * level.gun_cyclecount - 1)
					{
						param_01 thread maps\mp\_events::setbackfirstplayergunlevelevent();
						param_01 maps\mp\_utility::leaderdialogonplayer("humiliation","status");
						return;
					}

					return;
				}

				param_01.gungamesuicidetime = gettime();
				return;
			}

			if(maps\mp\_utility::ismeleemod(param_03))
			{
				param_01.stabs++;
				param_01.assists = param_01.stabs;
				param_01 thread maps\mp\_events::setbackenemygunlevelevent();
				return;
			}

			return;
		}

		if(param_03 == "MOD_PISTOL_BULLET" || param_03 == "MOD_RIFLE_BULLET" || param_03 == "MOD_HEAD_SHOT" || param_03 == "MOD_PROJECTILE" || param_03 == "MOD_PROJECTILE_SPLASH" || param_03 == "MOD_EXPLOSIVE" || param_03 == "MOD_IMPACT" || param_03 == "MOD_GRENADE" || param_03 == "MOD_GRENADE_SPLASH" || maps\mp\_utility::ismeleemod(param_03) && isdedicatedmeleeweapon(param_04))
		{
			waittillframeend;
			if(isdefined(param_01.gungamesuicidetime) && gettime() - param_01.gungamesuicidetime <= 50)
			{
				return;
			}

			if(isdefined(param_01.lastleveluptime) && param_01.lastleveluptime == gettime())
			{
				return;
			}

			if(maps\mp\_utility::ismeleemod(param_03))
			{
				param_01.stabs++;
				param_01.assists = param_01.stabs;
				param_01 thread maps\mp\_events::setbackenemygunlevelevent();
			}

			param_04 = maps\mp\_utility::getbaseweaponname(param_04);
			if(param_01.lastleveluptime + 3000 > gettime())
			{
				param_01 thread maps\mp\_events::quickgunlevelevent();
			}

			param_01.lastleveluptime = gettime();
			param_01.gungameprevgunindex = param_01.gungamegunindex;
			param_01.gungamegunindex++;
			param_01 thread maps\mp\_events::increasegunlevelevent();
			if(param_01.gungamegunindex == level.gun_guns.size * level.gun_cyclecount - 1)
			{
				maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured");
				level thread maps\mp\_utility::teamplayercardsplash("callout_top_gun_rank",param_01);
				var_0A = gettime();
				if(level.lastguntimevo + 4500 < var_0A)
				{
					level thread maps\mp\_utility::leaderdialogonplayers("lastgun",level.players,"status");
					level.lastguntimevo = var_0A;
				}
			}

			if(param_01.gungamegunindex < level.gun_guns.size * level.gun_cyclecount || !level.gun_cyclecount)
			{
				param_01 givenextgun();
				return;
			}

			return;
		}
	}
}

//Function Number: 18
givenextgun(param_00)
{
	self endon("disconnect");
	self notify("giveNextGun");
	self endon("giveNextGun");
	waittillframeend;
	var_01 = getnextgun();
	gungameclassupdate(var_01);
	var_02 = var_01.fullname;
	var_03 = common_scripts\utility::ter_op(var_01.altfireonly,weaponaltweaponname(var_02),var_02);
	while(!self method_8508(var_02))
	{
		wait 0.05;
	}

	self takeallweapons();
	maps\mp\_utility::_giveweapon(var_03);
	if(isdefined(param_00))
	{
		self setspawnweapon(var_03);
	}

	var_04 = maps\mp\_utility::getbaseweaponname(var_02);
	self.pers["primaryWeapon"] = var_04;
	self.primaryweapon = var_02;
	self.primaryweaponalt = var_03;
	self givestartammo(self.primaryweapon);
	self.primaryweaponstartammo = self getweaponammostock(self.primaryweapon);
	if(self.primaryweaponalt != "none")
	{
		self.primaryweaponaltstartammo = self getweaponammostock(self.primaryweaponalt);
	}

	var_05 = !maps\mp\_utility::is_true(param_00);
	if(var_01.altfireonly)
	{
		self setweaponammoclip(self.primaryweapon,0);
		self setweaponammostock(self.primaryweapon,0);
		self.primaryweaponstartammo = 0;
		self switchtoweapon(var_03,var_05);
	}
	else
	{
		self switchtoweapon(var_02,var_05);
	}

	self.gungameprevgunindex = self.gungamegunindex;
}

//Function Number: 19
getnextgun()
{
	var_00 = level.gun_guns;
	var_01 = [];
	var_02 = undefined;
	var_02 = var_00[self.gungamegunindex % var_00.size];
	var_01[var_01.size] = var_02.fullname;
	if(self.gungamegunindex + 1 < var_00.size * level.gun_cyclecount)
	{
		var_01[var_01.size] = var_00[self.gungamegunindex + 1 % var_00.size].fullname;
	}

	if(self.gungamegunindex > 0)
	{
		var_01[var_01.size] = var_00[self.gungamegunindex - 1 % var_00.size].fullname;
	}

	self method_8508(var_01);
	return var_02;
}

//Function Number: 20
addattachments(param_00)
{
	if(param_00 == "h1_rpg")
	{
		var_01 = "h1_rpg_mp";
	}
	else
	{
		var_01 = maps\mp\gametypes\_class::buildweaponname(var_01,"none","none");
	}

	return var_01;
}

//Function Number: 21
ontimelimit()
{
	level.finalkillcam_winner = "none";
	var_00 = gethighestprogressedplayers();
	if(!isdefined(var_00) || !var_00.size)
	{
		thread maps\mp\gametypes\_gamelogic::endgame("tie",game["end_reason"]["time_limit_reached"]);
		return;
	}

	if(var_00.size == 1)
	{
		thread maps\mp\gametypes\_gamelogic::endgame(var_00[0],game["end_reason"]["time_limit_reached"]);
		return;
	}

	if(var_00[var_00.size - 1].gungamegunindex > var_00[var_00.size - 2].gungamegunindex)
	{
		thread maps\mp\gametypes\_gamelogic::endgame(var_00[var_00.size - 1],game["end_reason"]["time_limit_reached"]);
		return;
	}

	thread maps\mp\gametypes\_gamelogic::endgame("tie",game["end_reason"]["time_limit_reached"]);
}

//Function Number: 22
gethighestprogressedplayers()
{
	var_00 = -1;
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(isdefined(var_03.gungamegunindex) && var_03.gungamegunindex >= var_00)
		{
			var_00 = var_03.gungamegunindex;
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 23
refillammo()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("reload");
		self setweaponammostock(self.primaryweapon,self.primaryweaponstartammo);
		if(self.primaryweaponalt != "none")
		{
			self setweaponammostock(self.primaryweaponalt,self.primaryweaponaltstartammo);
		}
	}
}

//Function Number: 24
refillsinglecountammo()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		if(maps\mp\_utility::isreallyalive(self) && self.team != "spectator" && isdefined(self.primaryweapon) && self getammocount(self.primaryweapon) == 0)
		{
			wait(2);
			self notify("reload");
			wait(1);
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 25
guninfo(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = spawnstruct();
	var_04.basename = param_00;
	var_04.altfireonly = param_03;
	var_05 = param_01;
	if(level.gun_weaponattachments)
	{
		var_05 = common_scripts\utility::random(param_02);
	}

	if(param_00 == "h1_rpg")
	{
		var_04.fullname = "h1_rpg_mp";
	}
	else
	{
		var_04.fullname = maps\mp\gametypes\_class::buildweaponname(param_00,var_05,"none");
	}

	level.gun_guns[level.gun_guns.size] = var_04;
}

//Function Number: 26
setguns()
{
	var_00 = "h1_meleeshovel";
	var_01 = ["none"];
	level.gun_guns = [];
	switch(level.gun_weaponlist)
	{
		case 0:
		default:
			break;

		case 1:
			break;

		case 2:
			break;

		case 3:
			break;

		case 4:
			break;

		case 5:
			break;

		case 6:
			break;

		case 7:
			break;

		case 8:
			break;

		case 9:
			break;
	}
}