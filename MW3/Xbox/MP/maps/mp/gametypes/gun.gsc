/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\gun.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 24
 * Decompile Time: 340 ms
 * Timestamp: 10/27/2023 2:26:13 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::setupcallbacks();
	maps\mp\gametypes\_globallogic::setupcallbacks();
	setguns();
	if(isusingmatchrulesdata())
	{
		level.initializematchrules = ::initializematchrules;
		[[ level.initializematchrules ]]();
		level thread maps\mp\_utility::func_810A();
	}
	else
	{
		maps\mp\_utility::func_3315(level.gametype,10);
		setdynamicdvar("scr_gun_scorelimit",level.gun_guns.size);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,level.gun_guns.size);
		level thread func_810F();
		maps\mp\_utility::func_3312(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,0);
		maps\mp\_utility::func_3317(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_randomize = 0;
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	setspecialloadout();
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
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::func_2D57;
	}
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_334C(1);
	level.matchrules_randomize = getmatchrulesdata("gunData","randomize");
	setdynamicdvar("scr_gun_scorelimit",level.gun_guns.size);
	maps\mp\_utility::registerscorelimitdvar(level.gametype,level.gun_guns.size);
	setdynamicdvar("scr_gun_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("gun",1);
	setdynamicdvar("scr_gun_roundlimit",1);
	maps\mp\_utility::func_3312("gun",1);
	setdynamicdvar("scr_gun_halftime",0);
	maps\mp\_utility::registerhalftimedvar("gun",0);
	setdynamicdvar("scr_gun_playerrespawndelay",0);
	setdynamicdvar("scr_gun_waverespawndelay",0);
	setdynamicdvar("scr_player_forcerespawn",1);
	setdynamicdvar("scr_gun_promode",0);
}

//Function Number: 3
func_810F()
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
	maps\mp\_utility::func_3305("allies",&"OBJECTIVES_DM");
	maps\mp\_utility::func_3305("axis",&"OBJECTIVES_DM");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_DM");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_DM");
	}
	else
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_DM_SCORE");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_DM_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_DM_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_DM_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::func_2FD0("allies","mp_dm_spawn");
	maps\mp\gametypes\_spawnlogic::func_2FD0("axis","mp_dm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::func_2FCD(level.spawnmins,level.spawnmaxs);
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
	if(maps\mp\_utility::matchmakinggame())
	{
		maps\mp\gametypes\_equipment::createkilltriggers();
	}

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
		var_00 func_356D();
		if(level.matchrules_randomize)
		{
			var_00.gun_nextguns = level.gun_guns;
			var_00.gun_prevguns = [];
		}

		var_00 thread func_2E9E();
		var_00 thread func_356C();
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
			maps\mp\gametypes\_menus::func_2AF3("axis",1);
		}
		else
		{
			maps\mp\gametypes\_menus::func_2AF3("allies",1);
		}
	}

	var_00 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.pers["team"]);
	var_01 = maps\mp\gametypes\_spawnlogic::func_2FEF(var_00);
	return var_01;
}

//Function Number: 8
onspawnplayer()
{
	self.pers["gamemodeLoadout"] = level.gun_loadouts[self.pers["team"]];
	thread waitloadoutdone();
	level notify("spawned_player");
}

//Function Number: 9
waitloadoutdone()
{
	level endon("game_ended");
	self endon("disconnect");
	self waittill("spawned_player");
	maps\mp\_utility::giveperk("specialty_bling",0);
	func_3569(1);
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
				maps\mp\gametypes\_gamescore::func_26D3("dropped_gun_score",self,undefined,1,1);
			}

			if(param_03 == "MOD_MELEE")
			{
				if(self.gungameprevgunindex)
				{
					param_01 thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_DROPPED_ENEMY_GUN_RANK");
					param_01 thread maps\mp\gametypes\_rank::func_2AB3("dropped_enemy_gun_rank");
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
			param_01 thread maps\mp\gametypes\_rank::func_2AB3("gained_gun_rank");
			maps\mp\gametypes\_gamescore::func_26D3("gained_gun_score",param_01,self,1,1);
			if(param_01.gungamegunindex == level.gun_guns.size - 1)
			{
				maps\mp\_utility::func_2D68("mp_enemy_obj_captured");
				level thread maps\mp\_utility::teamplayercardsplash("callout_top_gun_rank",param_01);
			}

			if(param_01.gungamegunindex < level.gun_guns.size)
			{
				param_01 playlocalsound("mp_war_objective_taken");
				param_01 func_3569();
				return;
			}

			return;
		}
	}
}

//Function Number: 11
func_3569(param_00)
{
	var_01 = func_8113();
	self.gun_curgun = var_01;
	var_01 = func_8114(var_01);
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
		thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_DROPPED_GUN_RANK");
	}
	else if(self.gungameprevgunindex < self.gungamegunindex)
	{
		thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_GAINED_GUN_RANK");
	}

	self.gungameprevgunindex = self.gungamegunindex;
	showweaponname(var_03);
	updategunhud();
}

//Function Number: 12
func_8113()
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
func_8114(param_00)
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

	var_03 = maps\mp\gametypes\_class::func_32BC(param_00,var_01,var_02,0,0);
	return var_03;
}

//Function Number: 14
ontimelimit()
{
	level.finalkillcam_winner = "none";
	var_00 = func_7FB4();
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
func_7FB4()
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
func_2E9E()
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
func_356C()
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
func_356D()
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

	thread func_3571();
	thread hideinkillcam();
}

//Function Number: 19
updategunhud()
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
		if(var_00 && !isalive(self) || maps\mp\_utility::func_2AF1())
		{
			self.gun_progressdisplay[0].alpha = 0;
			self.gun_progressdisplay[1].alpha = 0;
			var_00 = 0;
		}
		else if(!var_00 && isalive(self) && !maps\mp\_utility::func_2AF1())
		{
			self.gun_progressdisplay[0].alpha = 1;
			self.gun_progressdisplay[1].alpha = 1;
			var_00 = 1;
		}

		wait 0.05;
	}
}

//Function Number: 21
func_3571()
{
	self endon("disconnect");
	level waittill("game_ended");
	self.gun_progressdisplay[0].alpha = 0;
	self.gun_progressdisplay[1].alpha = 0;
}

//Function Number: 22
showweaponname(param_00)
{
	self endon("disconnect");
	maps\mp\_utility::func_274B("prematch_done");
	var_01 = tablelookup("mp/statstable.csv",4,param_00,3);
	switch(var_01)
	{
		case "WEAPON_RIOTSHIELD":
			self iprintlnbold(&"WEAPON_RIOTSHIELD");
			break;

		case "WEAPON_MAGNUM":
			self iprintlnbold(&"WEAPON_MAGNUM");
			break;

		case "WEAPON_USP":
			self iprintlnbold(&"WEAPON_USP");
			break;

		case "WEAPON_DESERTEAGLE":
			self iprintlnbold(&"WEAPON_DESERTEAGLE");
			break;

		case "WEAPON_MP412":
			self iprintlnbold(&"WEAPON_MP412");
			break;

		case "WEAPON_P99":
			self iprintlnbold(&"WEAPON_P99");
			break;

		case "WEAPON_FNFIVESEVEN":
			self iprintlnbold(&"WEAPON_FNFIVESEVEN");
			break;

		case "WEAPON_FMG9":
			self iprintlnbold(&"WEAPON_FMG9");
			break;

		case "WEAPON_SKORPION":
			self iprintlnbold(&"WEAPON_SKORPION");
			break;

		case "WEAPON_MP9":
			self iprintlnbold(&"WEAPON_MP9");
			break;

		case "WEAPON_GLOCK":
			self iprintlnbold(&"WEAPON_GLOCK");
			break;

		case "WEAPON_MP5K":
			self iprintlnbold(&"WEAPON_MP5K");
			break;

		case "WEAPON_UZI":
			self iprintlnbold(&"WEAPON_UZI");
			break;

		case "WEAPON_P90":
			self iprintlnbold(&"WEAPON_P90");
			break;

		case "WEAPON_PP90M1":
			self iprintlnbold(&"WEAPON_PP90M1");
			break;

		case "WEAPON_UMP45":
			self iprintlnbold(&"WEAPON_UMP45");
			break;

		case "WEAPON_MP7":
			self iprintlnbold(&"WEAPON_MP7");
			break;

		case "WEAPON_AK47":
			self iprintlnbold(&"WEAPON_AK47");
			break;

		case "WEAPON_M16":
			self iprintlnbold(&"WEAPON_M16");
			break;

		case "WEAPON_M4":
			self iprintlnbold(&"WEAPON_M4");
			break;

		case "WEAPON_FAD":
			self iprintlnbold(&"WEAPON_FAD");
			break;

		case "WEAPON_ACR":
			self iprintlnbold(&"WEAPON_ACR");
			break;

		case "WEAPON_TYPE95":
			self iprintlnbold(&"WEAPON_TYPE95");
			break;

		case "WEAPON_MK14":
			self iprintlnbold(&"WEAPON_MK14");
			break;

		case "WEAPON_SCAR":
			self iprintlnbold(&"WEAPON_SCAR");
			break;

		case "WEAPON_G36":
			self iprintlnbold(&"WEAPON_G36");
			break;

		case "WEAPON_CM901":
			self iprintlnbold(&"WEAPON_CM901");
			break;

		case "WEAPON_GRENADE_LAUNCHER":
			self iprintlnbold(&"WEAPON_GRENADE_LAUNCHER");
			break;

		case "WEAPON_M320":
			self iprintlnbold(&"WEAPON_M320");
			break;

		case "WEAPON_RPG":
			self iprintlnbold(&"WEAPON_RPG");
			break;

		case "WEAPON_SMAW":
			self iprintlnbold(&"WEAPON_SMAW");
			break;

		case "WEAPON_STINGER":
			self iprintlnbold(&"WEAPON_STINGER");
			break;

		case "WEAPON_JAVELIN":
			self iprintlnbold(&"WEAPON_JAVELIN");
			break;

		case "WEAPON_XM25":
			self iprintlnbold(&"WEAPON_XM25");
			break;

		case "WEAPON_DRAGUNOV":
			self iprintlnbold(&"WEAPON_DRAGUNOV");
			break;

		case "WEAPON_MSR":
			self iprintlnbold(&"WEAPON_MSR");
			break;

		case "WEAPON_BARRETT":
			self iprintlnbold(&"WEAPON_BARRETT");
			break;

		case "WEAPON_RSASS":
			self iprintlnbold(&"WEAPON_RSASS");
			break;

		case "WEAPON_AS50":
			self iprintlnbold(&"WEAPON_AS50");
			break;

		case "WEAPON_L96A1":
			self iprintlnbold(&"WEAPON_L96A1");
			break;

		case "WEAPON_KSG":
			self iprintlnbold(&"WEAPON_KSG");
			break;

		case "WEAPON_MODEL1887":
			self iprintlnbold(&"WEAPON_MODEL1887");
			break;

		case "WEAPON_STRIKER":
			self iprintlnbold(&"WEAPON_STRIKER");
			break;

		case "WEAPON_AA12":
			self iprintlnbold(&"WEAPON_AA12");
			break;

		case "WEAPON_USAS12":
			self iprintlnbold(&"WEAPON_USAS12");
			break;

		case "WEAPON_SPAS12":
			self iprintlnbold(&"WEAPON_SPAS12");
			break;

		case "WEAPON_M60":
			self iprintlnbold(&"WEAPON_M60");
			break;

		case "WEAPON_MK46":
			self iprintlnbold(&"WEAPON_MK46");
			break;

		case "WEAPON_PECHENEG":
			self iprintlnbold(&"WEAPON_PECHENEG");
			break;

		case "WEAPON_SA80":
			self iprintlnbold(&"WEAPON_SA80");
			break;

		case "WEAPON_MG36":
			self iprintlnbold(&"WEAPON_MG36");
			break;

		default:
			break;
	}
}

//Function Number: 23
setguns()
{
	level.gun_guns = [];
	var_00 = 0;
	if(isusingmatchrulesdata())
	{
		var_00 = getmatchrulesdata("gunData","numGuns");
	}

	if(var_00 > 20)
	{
		var_00 = 20;
	}

	if(var_00)
	{
		for(var_01 = 0;var_01 < var_00;var_01++)
		{
			level.gun_guns[var_01] = getmatchrulesdata("gunData","guns",var_01);
			if(level.gun_guns[var_01] == "none")
			{
				level.gun_guns[var_01] = "iw5_mp5";
			}
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

//Function Number: 24
setspecialloadout()
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