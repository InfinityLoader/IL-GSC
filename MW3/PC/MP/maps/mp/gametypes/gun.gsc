/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\gun.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 311 ms
 * Timestamp: 10/27/2023 2:13:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::setupcallbacks();
	maps\mp\gametypes\_globallogic::setupcallbacks();
	func_3A48();
	if(isusingmatchrulesdata())
	{
		level.initializematchrules = ::initializematchrules;
		[[ level.initializematchrules ]]();
		level thread maps\mp\_utility::reinitializematchrulesonmigration();
	}
	else
	{
		maps\mp\_utility::registertimelimitdvar(level.gametype,10);
		setdynamicdvar("scr_gun_scorelimit",level.gun_guns.size);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,level.gun_guns.size);
		level thread func_01C0();
		maps\mp\_utility::registerroundlimitdvar(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,0);
		maps\mp\_utility::registernumlivesdvar(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_randomize = 0;
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	func_3972();
	level.teambased = 0;
	level.doprematch = 1;
	level.killstreakrewards = 0;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.onspawnplayer = ::onspawnplayer;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.ontimelimit = ::ontimelimit;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata(1);
	level.matchrules_randomize = getmatchrulesdata("gunData","randomize");
	setdynamicdvar("scr_gun_scorelimit",level.gun_guns.size);
	maps\mp\_utility::registerscorelimitdvar(level.gametype,level.gun_guns.size);
	setdynamicdvar("scr_gun_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("gun",1);
	setdynamicdvar("scr_gun_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar("gun",1);
	setdynamicdvar("scr_gun_halftime",0);
	maps\mp\_utility::registerhalftimedvar("gun",0);
	setdynamicdvar("scr_gun_promode",0);
}

//Function Number: 3
func_01C0()
{
	setdynamicdvar("scr_gun_scorelimit",level.gun_guns.size);
	maps\mp\_utility::registerscorelimitdvar(level.gametype,level.gun_guns.size);
}

//Function Number: 4
onprecachegametype()
{
	precachestring(&"MP_GUN");
}

//Function Number: 5
onstartgametype()
{
	setclientnamemode("auto_change");
	maps\mp\_utility::setobjectivetext("allies",&"OBJECTIVES_DM");
	maps\mp\_utility::setobjectivetext("axis",&"OBJECTIVES_DM");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_DM");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_DM");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_DM_SCORE");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_DM_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_DM_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_DM_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_dm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_dm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	maps\mp\gametypes\_rank::registerscoreinfo("kill",0);
	maps\mp\gametypes\_rank::registerscoreinfo("assist",0);
	maps\mp\gametypes\_rank::registerscoreinfo("suicide",0);
	maps\mp\gametypes\_rank::registerscoreinfo("teamkill",0);
	maps\mp\gametypes\_rank::registerscoreinfo("headshot",0);
	maps\mp\gametypes\_rank::registerscoreinfo("execution",0);
	maps\mp\gametypes\_rank::registerscoreinfo("avenger",0);
	maps\mp\gametypes\_rank::registerscoreinfo("defender",0);
	maps\mp\gametypes\_rank::registerscoreinfo("posthumous",0);
	maps\mp\gametypes\_rank::registerscoreinfo("revenge",0);
	maps\mp\gametypes\_rank::registerscoreinfo("double",0);
	maps\mp\gametypes\_rank::registerscoreinfo("triple",0);
	maps\mp\gametypes\_rank::registerscoreinfo("multi",0);
	maps\mp\gametypes\_rank::registerscoreinfo("buzzkill",0);
	maps\mp\gametypes\_rank::registerscoreinfo("firstblood",0);
	maps\mp\gametypes\_rank::registerscoreinfo("comeback",0);
	maps\mp\gametypes\_rank::registerscoreinfo("longshot",0);
	maps\mp\gametypes\_rank::registerscoreinfo("assistedsuicide",0);
	maps\mp\gametypes\_rank::registerscoreinfo("knifethrow",0);
	maps\mp\gametypes\_rank::registerscoreinfo("gained_gun_score",1);
	maps\mp\gametypes\_rank::registerscoreinfo("dropped_gun_score",-1);
	maps\mp\gametypes\_rank::registerscoreinfo("gained_gun_rank",100);
	maps\mp\gametypes\_rank::registerscoreinfo("dropped_enemy_gun_rank",100);
	var_00 = [];
	maps\mp\gametypes\_gameobjects::main(var_00);
	level.quickmessagetoall = 1;
	level.blockweapondrops = 1;
	level thread onplayerconnect();
	level.killstreakrewards = 0;
}

//Function Number: 6
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.gun_firstspawn = 1;
		var_00.gungamegunindex = 0;
		var_00.gungameprevgunindex = 0;
		var_00 func_3A43();
		if(level.matchrules_randomize)
		{
			var_00.gun_nextguns = level.gun_guns;
			var_00.gun_prevguns = [];
		}

		var_00 thread refillammo();
		var_00 thread func_3A42();
	}
}

//Function Number: 7
getspawnpoint()
{
	if(self.gun_firstspawn)
	{
		self.gun_firstspawn = 0;
		self.pers["class"] = "gamemode";
		self.pers["lastClass"] = "";
		self.class = self.pers["class"];
		self.lastclass = self.pers["lastClass"];
		if(common_scripts\utility::cointoss())
		{
			maps\mp\gametypes\_menus::addtoteam("axis",1);
		}
		else
		{
			maps\mp\gametypes\_menus::addtoteam("allies",1);
		}
	}

	var_00 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.pers["team"]);
	var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_dm(var_00);
	return var_01;
}

//Function Number: 8
onspawnplayer()
{
	self.pers["gamemodeLoadout"] = level.gun_loadouts[self.pers["team"]];
	thread func_39EB();
	level notify("spawned_player");
}

//Function Number: 9
func_39EB()
{
	level endon("game_ended");
	self endon("disconnect");
	level waittill("player_spawned");
	maps\mp\_utility::giveperk("specialty_bling",0);
	func_3A3F(1);
}

//Function Number: 10
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(param_03 == "MOD_FALLING" || isdefined(param_01) && isplayer(param_01))
	{
		if(param_03 == "MOD_FALLING" || param_01 == self || param_03 == "MOD_MELEE" && param_04 != "riotshield_mp")
		{
			self playlocalsound("mp_war_objective_lost");
			self.gungameprevgunindex = self.gungamegunindex;
			self.gungamegunindex = int(max(0,self.gungamegunindex - 1));
			if(self.gungameprevgunindex > self.gungamegunindex)
			{
				lib_036E::func_2B7B("dropped_gun_score",self,undefined,1,1);
			}

			if(param_03 == "MOD_MELEE")
			{
				if(self.gungameprevgunindex)
				{
					param_01 thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_DROPPED_ENEMY_GUN_RANK");
					param_01 thread maps\mp\gametypes\_rank::giverankxp("dropped_enemy_gun_rank");
					return;
				}

				return;
			}

			return;
		}

		if(param_03 == "MOD_PISTOL_BULLET" || param_03 == "MOD_RIFLE_BULLET" || param_03 == "MOD_HEAD_SHOT" || param_03 == "MOD_PROJECTILE" || param_03 == "MOD_PROJECTILE_SPLASH" || param_03 == "MOD_IMPACT" || param_03 == "MOD_GRENADE" || param_03 == "MOD_GRENADE_SPLASH" || param_03 == "MOD_MELEE" && param_04 == "riotshield_mp")
		{
			if(param_04 != param_01.primaryweapon)
			{
				return;
			}

			param_01.gungameprevgunindex = param_01.gungamegunindex;
			param_01.gungamegunindex++;
			param_01 thread maps\mp\gametypes\_rank::giverankxp("gained_gun_rank");
			lib_036E::func_2B7B("gained_gun_score",param_01,self,1,1);
			if(param_01.gungamegunindex == level.gun_guns.size - 1)
			{
				maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured");
				level thread maps\mp\_utility::teamplayercardsplash("callout_top_gun_rank",param_01);
			}

			if(param_01.gungamegunindex < level.gun_guns.size)
			{
				param_01 playlocalsound("mp_war_objective_taken");
				param_01 func_3A3F();
				return;
			}

			return;
		}
	}
}

//Function Number: 11
func_3A3F(param_00)
{
	var_01 = func_0173();
	self.gun_curgun = var_01;
	var_01 = func_0174(var_01);
	self takeallweapons();
	maps\mp\_utility::_giveweapon(var_01);
	if(isdefined(param_00))
	{
		self setspawnweapon(var_01);
	}

	var_02 = strtok(var_01,"_");
	if(var_02[0] == "iw5")
	{
		var_03 = var_02[0] + "_" + var_02[1];
	}
	else if(var_03[0] == "alt")
	{
		var_03 = var_03[1] + "_" + var_03[2];
	}
	else
	{
		var_03 = var_03[0];
	}

	self.pers["primaryWeapon"] = var_03;
	self.primaryweapon = var_01;
	self givestartammo(var_01);
	self switchtoweapon(var_01);
	if(self.gungameprevgunindex > self.gungamegunindex)
	{
		thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_DROPPED_GUN_RANK");
	}
	else if(self.gungameprevgunindex < self.gungamegunindex)
	{
		thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_GAINED_GUN_RANK");
	}

	self.gungameprevgunindex = self.gungamegunindex;
	func_3A45();
}

//Function Number: 12
func_0173()
{
	if(level.matchrules_randomize)
	{
		if(self.gungameprevgunindex < self.gungamegunindex)
		{
			var_00 = randomint(self.gun_nextguns.size);
			var_01 = self.gun_nextguns[var_00];
			self.gun_prevguns[self.gun_prevguns.size] = self.gun_nextguns[var_00];
			self.gun_nextguns[var_00] = undefined;
			self.gun_nextguns = common_scripts\utility::array_removeundefined(self.gun_nextguns);
		}
		else if(self.gungameprevgunindex > self.gungamegunindex)
		{
			if(self.gun_prevguns.size > 1)
			{
				for(var_02 = 0;var_02 < self.gun_prevguns.size;var_02++)
				{
					if(self.gun_prevguns[var_02] == self.gun_curgun)
					{
						break;
					}
				}

				self.gun_nextguns[self.gun_nextguns.size] = self.gun_prevguns[var_02];
				self.gun_prevguns[var_02] = undefined;
				self.gun_prevguns = common_scripts\utility::array_removeundefined(self.gun_prevguns);
			}

			var_00 = randomint(self.gun_prevguns.size);
			var_01 = self.gun_prevguns[var_00];
		}
		else if(self.gun_prevguns.size)
		{
			var_00 = randomint(self.gun_prevguns.size);
			var_01 = self.gun_prevguns[var_00];
		}
		else
		{
			var_00 = randomint(self.gun_nextguns.size);
			var_01 = self.gun_nextguns[var_00];
			self.gun_prevguns[self.gun_prevguns.size] = self.gun_nextguns[var_00];
			self.gun_nextguns[var_00] = undefined;
			self.gun_nextguns = common_scripts\utility::array_removeundefined(self.gun_nextguns);
		}
	}
	else
	{
		var_01 = level.gun_guns[self.gungamegunindex];
	}

	return var_01;
}

//Function Number: 13
func_0174(param_00)
{
	if(isdefined(level.gun_attachments[param_00]) && isdefined(level.gun_attachments[param_00]["attach1"]))
	{
		var_01 = level.gun_attachments[param_00]["attach1"];
	}
	else
	{
		var_01 = "none";
	}

	if(isdefined(level.gun_attachments[param_00]) && isdefined(level.gun_attachments[param_00]["attach2"]))
	{
		var_02 = level.gun_attachments[param_00]["attach2"];
	}
	else
	{
		var_02 = "none";
	}

	var_03 = maps\mp\gametypes\_class::buildweaponname(param_00,var_01,var_02,0,0);
	return var_03;
}

//Function Number: 14
ontimelimit()
{
	level.finalkillcam_winner = "none";
	var_00 = func_03B6();
	if(!isdefined(var_00) || !var_00.size)
	{
		thread maps\mp\gametypes\_gamelogic::endgame("tie",game["strings"]["time_limit_reached"]);
		return;
	}

	if(var_00.size == 1)
	{
		thread maps\mp\gametypes\_gamelogic::endgame(var_00[0],game["strings"]["time_limit_reached"]);
		return;
	}

	if(var_00[var_00.size - 1].gungamegunindex > var_00[var_00.size - 2].gungamegunindex)
	{
		thread maps\mp\gametypes\_gamelogic::endgame(var_00[var_00.size - 1],game["strings"]["time_limit_reached"]);
		return;
	}

	thread maps\mp\gametypes\_gamelogic::endgame("tie",game["strings"]["time_limit_reached"]);
}

//Function Number: 15
func_03B6()
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

//Function Number: 16
refillammo()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("reload");
		self givestartammo(self.primaryweapon);
	}
}

//Function Number: 17
func_3A42()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		if(maps\mp\_utility::isreallyalive(self) && self.team != "spectator" && isdefined(self.primaryweapon) && self getammocount(self.primaryweapon) == 0)
		{
			wait 2;
			self notify("reload");
			wait 1;
			continue;
		}

		wait 0.05;
	}
}

//Function Number: 18
func_3A43()
{
	if(level.splitscreen)
	{
		self.gun_progressdisplay[0] = maps\mp\gametypes\_hud_util::createfontstring("small",1.2);
		self.gun_progressdisplay[0] maps\mp\gametypes\_hud_util::setpoint("TOP LEFT","TOP LEFT",80,0);
		self.gun_progressdisplay[0] settext(&"MP_WEAPON");
		self.gun_progressdisplay[0].alpha = 1;
		self.gun_progressdisplay[0].archived = 0;
		self.gun_progressdisplay[0].hidewheninmenu = 1;
		self.gun_progressdisplay[1] = maps\mp\gametypes\_hud_util::createfontstring("small",1.2);
		self.gun_progressdisplay[1] maps\mp\gametypes\_hud_util::setpoint("TOP LEFT","TOP LEFT",80,12);
		self.gun_progressdisplay[1] settext("1 / " + level.gun_guns.size);
		self.gun_progressdisplay[1].alpha = 1;
		self.gun_progressdisplay[1].archived = 0;
		self.gun_progressdisplay[1].hidewheninmenu = 1;
	}
	else
	{
		self.gun_progressdisplay[0] = maps\mp\gametypes\_hud_util::createfontstring("small",1.2);
		self.gun_progressdisplay[0] maps\mp\gametypes\_hud_util::setpoint("TOP LEFT","TOP LEFT",115,5);
		self.gun_progressdisplay[0] settext(&"MP_WEAPON");
		self.gun_progressdisplay[0].alpha = 1;
		self.gun_progressdisplay[0].archived = 0;
		self.gun_progressdisplay[0].hidewheninmenu = 1;
		self.gun_progressdisplay[1] = maps\mp\gametypes\_hud_util::createfontstring("small",1.2);
		self.gun_progressdisplay[1] maps\mp\gametypes\_hud_util::setpoint("TOP LEFT","TOP LEFT",115,17);
		self.gun_progressdisplay[1] settext("1 / " + level.gun_guns.size);
		self.gun_progressdisplay[1].alpha = 1;
		self.gun_progressdisplay[1].archived = 0;
		self.gun_progressdisplay[1].hidewheninmenu = 1;
	}

	thread func_3A47();
	thread hideinkillcam();
}

//Function Number: 19
func_3A45()
{
	self.gun_progressdisplay[1] settext(self.gungamegunindex + 1 + " / " + level.gun_guns.size);
}

//Function Number: 20
hideinkillcam()
{
	self endon("disconnect");
	var_00 = 1;
	for(;;)
	{
		if(var_00 && !isalive(self) || maps\mp\_utility::isinkillcam())
		{
			self.gun_progressdisplay[0].alpha = 0;
			self.gun_progressdisplay[1].alpha = 0;
			var_00 = 0;
		}
		else if(!var_00 && isalive(self) && !maps\mp\_utility::isinkillcam())
		{
			self.gun_progressdisplay[0].alpha = 1;
			self.gun_progressdisplay[1].alpha = 1;
			var_00 = 1;
		}

		wait 0.05;
	}
}

//Function Number: 21
func_3A47()
{
	self endon("disconnect");
	level waittill("game_ended");
	self.gun_progressdisplay[0].alpha = 0;
	self.gun_progressdisplay[1].alpha = 0;
}

//Function Number: 22
func_3A48()
{
	level.gun_guns = [];
	var_00 = 0;
	if(isusingmatchrulesdata())
	{
		var_00 = getmatchrulesdata("gunData","numGuns");
	}

	if(var_00)
	{
		for(var_01 = 0;var_01 < var_00;var_01++)
		{
			level.gun_guns[var_01] = getmatchrulesdata("gunData","guns",var_01);
		}
	}
	else
	{
		level.gun_guns[0] = "iw5_deserteagle";
		level.gun_guns[1] = "iw5_g18";
		level.gun_guns[2] = "iw5_mp9";
		level.gun_guns[3] = "iw5_mp5";
		level.gun_guns[4] = "iw5_p90";
		level.gun_guns[5] = "iw5_mp7";
		level.gun_guns[6] = "iw5_ak47";
		level.gun_guns[7] = "iw5_scar";
		level.gun_guns[8] = "iw5_pecheneg";
		level.gun_guns[9] = "iw5_mg36";
		level.gun_guns[10] = "iw5_spas12";
		level.gun_guns[11] = "iw5_1887";
		level.gun_guns[12] = "iw5_type95";
		level.gun_guns[13] = "iw5_mk14";
		level.gun_guns[14] = "iw5_barrett";
		level.gun_guns[15] = "iw5_msr";
		level.gun_guns[16] = "xm25";
		level.gun_guns[17] = "javelin";
	}

	level.gun_attachments = [];
	level.gun_attachments["iw5_44magnum"]["attach1"] = "tactical";
	level.gun_attachments["iw5_deserteagle"]["attach1"] = "tactical";
	level.gun_attachments["iw5_mp412"]["attach1"] = "tactical";
	level.gun_attachments["iw5_fmg9"]["attach1"] = "reflex";
	level.gun_attachments["iw5_skorpion"]["attach1"] = "reflex";
	level.gun_attachments["iw5_mp9"]["attach1"] = "reflex";
	level.gun_attachments["iw5_g18"]["attach1"] = "reflex";
	level.gun_attachments["iw5_mp5"]["attach1"] = "reflex";
	level.gun_attachments["iw5_m9"]["attach1"] = "reflex";
	level.gun_attachments["iw5_p90"]["attach1"] = "reflex";
	level.gun_attachments["iw5_pp90m1"]["attach1"] = "reflex";
	level.gun_attachments["iw5_ump45"]["attach1"] = "reflex";
	level.gun_attachments["iw5_mp7"]["attach1"] = "reflex";
	level.gun_attachments["iw5_ak47"]["attach1"] = "reflex";
	level.gun_attachments["iw5_m16"]["attach1"] = "reflex";
	level.gun_attachments["iw5_m4"]["attach1"] = "reflex";
	level.gun_attachments["iw5_fad"]["attach1"] = "reflex";
	level.gun_attachments["iw5_acr"]["attach1"] = "reflex";
	level.gun_attachments["iw5_type95"]["attach1"] = "reflex";
	level.gun_attachments["iw5_mk14"]["attach1"] = "reflex";
	level.gun_attachments["iw5_scar"]["attach1"] = "reflex";
	level.gun_attachments["iw5_g36c"]["attach1"] = "reflex";
	level.gun_attachments["iw5_cm901"]["attach1"] = "reflex";
	level.gun_attachments["iw5_ksg"]["attach1"] = "grip";
	level.gun_attachments["iw5_striker"]["attach1"] = "grip";
	level.gun_attachments["iw5_aa12"]["attach1"] = "grip";
	level.gun_attachments["iw5_usas12"]["attach1"] = "grip";
	level.gun_attachments["iw5_spas12"]["attach1"] = "grip";
	level.gun_attachments["iw5_m60"]["attach1"] = "grip";
	level.gun_attachments["iw5_m60"]["attach2"] = "reflex";
	level.gun_attachments["iw5_mk46"]["attach1"] = "grip";
	level.gun_attachments["iw5_mk46"]["attach2"] = "reflex";
	level.gun_attachments["iw5_pecheneg"]["attach1"] = "grip";
	level.gun_attachments["iw5_pecheneg"]["attach2"] = "reflex";
	level.gun_attachments["iw5_sa80"]["attach1"] = "grip";
	level.gun_attachments["iw5_sa80"]["attach2"] = "reflex";
	level.gun_attachments["iw5_mg36"]["attach1"] = "grip";
	level.gun_attachments["iw5_mg36"]["attach2"] = "reflex";
}

//Function Number: 23
func_3972()
{
	level.gun_loadouts["axis"]["loadoutPrimary"] = "iw5_acr";
	level.gun_loadouts["axis"]["loadoutPrimaryAttachment"] = "none";
	level.gun_loadouts["axis"]["loadoutPrimaryAttachment2"] = "none";
	level.gun_loadouts["axis"]["loadoutPrimaryBuff"] = "specialty_null";
	level.gun_loadouts["axis"]["loadoutPrimaryCamo"] = "none";
	level.gun_loadouts["axis"]["loadoutPrimaryReticle"] = "none";
	level.gun_loadouts["axis"]["loadoutSecondary"] = "none";
	level.gun_loadouts["axis"]["loadoutSecondaryAttachment"] = "none";
	level.gun_loadouts["axis"]["loadoutSecondaryAttachment2"] = "none";
	level.gun_loadouts["axis"]["loadoutSecondaryBuff"] = "specialty_null";
	level.gun_loadouts["axis"]["loadoutSecondaryCamo"] = "none";
	level.gun_loadouts["axis"]["loadoutSecondaryReticle"] = "none";
	level.gun_loadouts["axis"]["loadoutEquipment"] = "specialty_null";
	level.gun_loadouts["axis"]["loadoutOffhand"] = "none";
	level.gun_loadouts["axis"]["loadoutPerk1"] = "specialty_null";
	level.gun_loadouts["axis"]["loadoutPerk2"] = "specialty_null";
	level.gun_loadouts["axis"]["loadoutPerk3"] = "specialty_null";
	level.gun_loadouts["axis"]["loadoutDeathstreak"] = "specialty_null";
	level.gun_loadouts["axis"]["loadoutJuggernaut"] = 0;
	level.gun_loadouts["allies"] = level.gun_loadouts["axis"];
}