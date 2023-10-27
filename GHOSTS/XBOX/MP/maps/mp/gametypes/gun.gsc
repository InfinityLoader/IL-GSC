/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\gun.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 25
 * Decompile Time: 425 ms
 * Timestamp: 10/27/2023 1:29:11 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	maps\mp\gametypes\_globallogic::func_44DF();
	maps\mp\gametypes\_callbacksetup::func_71F0();
	maps\mp\gametypes\_globallogic::func_71F0();
	func_944E();
	if(isusingmatchrulesdata())
	{
		level.initializematchrules = ::initializematchrules;
		[[ level.initializematchrules ]]();
		level thread maps\mp\_utility::func_647E();
	}
	else
	{
		maps\mp\_utility::func_6476(level.gametype,10);
		var_00 = level.gun_guns.size;
		setdynamicdvar("scr_gun_scorelimit",var_00);
		maps\mp\_utility::func_6475(level.gametype,var_00);
		maps\mp\_utility::func_6472(level.gametype,1);
		maps\mp\_utility::func_647C(level.gametype,0);
		maps\mp\_utility::func_6470(level.gametype,0);
		maps\mp\_utility::func_646A(level.gametype,0);
		level.matchrules_randomize = 0;
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	func_70CE();
	setteammode("ffa");
	level.teambased = 0;
	level.doprematch = 1;
	level.killstreakrewards = 0;
	level.supportintel = 0;
	level.supportnuke = 0;
	level.assists_disabled = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.var_5976 = ::func_5976;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.ontimelimit = ::ontimelimit;
	level.onplayerscore = ::onplayerscore;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_700A(1);
	level.matchrules_randomize = getmatchrulesdata("gunData","randomize");
	var_00 = level.gun_guns.size;
	setdynamicdvar("scr_gun_scorelimit",var_00);
	maps\mp\_utility::func_6475(level.gametype,var_00);
	setdynamicdvar("scr_gun_winlimit",1);
	maps\mp\_utility::func_647C("gun",1);
	setdynamicdvar("scr_gun_roundlimit",1);
	maps\mp\_utility::func_6472("gun",1);
	setdynamicdvar("scr_gun_halftime",0);
	maps\mp\_utility::func_646A("gun",0);
	setdynamicdvar("scr_gun_playerrespawndelay",0);
	setdynamicdvar("scr_gun_waverespawndelay",0);
	setdynamicdvar("scr_player_forcerespawn",1);
	setdynamicdvar("scr_gun_promode",0);
}

//Function Number: 3
onprecachegametype()
{
}

//Function Number: 4
onstartgametype()
{
	var_00 = maps\mp\gametypes\_rank::func_3BE0("gained_gun_score");
	maps\mp\gametypes\_rank::registerscoreinfo("dropped_gun_score",-1 * var_00);
	func_944F();
	setclientnamemode("auto_change");
	maps\mp\_utility::func_7084("allies",&"OBJECTIVES_DM");
	maps\mp\_utility::func_7084("axis",&"OBJECTIVES_DM");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_DM");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_DM");
	}
	else
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_DM_SCORE");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_DM_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_DM_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_DM_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_dm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_dm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	var_01 = [];
	maps\mp\gametypes\_gameobjects::func_4FDD(var_01);
	level.quickmessagetoall = 1;
	level.blockweapondrops = 1;
	level thread func_595D();
	level.killstreakrewards = 0;
}

//Function Number: 5
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.gun_firstspawn = 1;
		var_00.gungamegunindex = 0;
		var_00.gungameprevgunindex = 0;
		if(level.matchrules_randomize)
		{
			var_00.gun_nextguns = level.gun_guns;
			var_00.gun_prevguns = [];
		}

		var_00 thread func_6429();
		var_00 thread func_93E9();
		var_00 maps\mp\_utility::setfakeloadoutweaponslot(level.gun_guns[0],1);
	}
}

//Function Number: 6
getspawnpoint()
{
	if(self.gun_firstspawn)
	{
		self.gun_firstspawn = 0;
		self.pers["class"] = "gamemode";
		self.pers["lastClass"] = "";
		self.class = self.pers["class"];
		self.lastclass = self.pers["lastClass"];
		if(common_scripts\utility::func_1DE9())
		{
			lib_05D5::addtoteam("axis",1);
		}
		else
		{
			lib_05D5::addtoteam("allies",1);
		}
	}

	var_00 = maps\mp\gametypes\_spawnlogic::func_3C41(self.pers["team"]);
	var_01 = maps\mp\gametypes\_spawnscoring::func_3BF0(var_00);
	return var_01;
}

//Function Number: 7
func_5976()
{
	self.pers["gamemodeLoadout"] = level.gun_loadouts[self.pers["team"]];
	thread waitloadoutdone();
	level notify("spawned_player");
}

//Function Number: 8
waitloadoutdone()
{
	level endon("game_ended");
	self endon("disconnect");
	self waittill("spawned_player");
	maps\mp\_utility::func_3CFB("specialty_bling",0);
	func_9202(1);
}

//Function Number: 9
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(param_03 == "MOD_FALLING" || isdefined(param_01) && isplayer(param_01))
	{
		var_0A = maps\mp\gametypes\_weapons::func_494E(param_04);
		if(param_03 == "MOD_FALLING" || param_01 == self || param_03 == "MOD_MELEE" && !var_0A)
		{
			self playlocalsound("mp_war_objective_lost");
			self.gungameprevgunindex = self.gungamegunindex;
			self.gungamegunindex = castint(max(0,self.gungamegunindex - 1));
			if(self.gungameprevgunindex > self.gungamegunindex)
			{
				thread maps\mp\gametypes\_rank::func_8E6E("dropped_gun_rank");
				maps\mp\gametypes\_gamescore::func_3D00("dropped_gun_score",self,undefined,1,1);
				maps\mp\_utility::setfakeloadoutweaponslot(level.gun_guns[self.gungamegunindex],1);
			}

			if(param_03 == "MOD_MELEE")
			{
				if(self.gungameprevgunindex)
				{
					param_01 thread maps\mp\gametypes\_rank::func_8E6E("dropped_enemy_gun_rank");
					param_01 thread maps\mp\gametypes\_rank::giverankxp("dropped_enemy_gun_rank");
				}

				param_01.assists++;
				param_01 maps\mp\gametypes\_persistence::func_7B28("round","sguardWave",param_01.assists);
			}
		}

		if(param_03 == "MOD_PISTOL_BULLET" || param_03 == "MOD_RIFLE_BULLET" || param_03 == "MOD_HEAD_SHOT" || param_03 == "MOD_PROJECTILE" || param_03 == "MOD_PROJECTILE_SPLASH" || param_03 == "MOD_IMPACT" || param_03 == "MOD_GRENADE" || param_03 == "MOD_GRENADE_SPLASH" || param_03 == "MOD_MELEE" && var_0A)
		{
			if(param_04 != param_01.primaryweapon && !param_01 func_92B3(param_04))
			{
			}

			param_01.gungameprevgunindex = param_01.gungamegunindex;
			param_01.gungamegunindex++;
			param_01 thread maps\mp\gametypes\_rank::giverankxp("gained_gun_rank");
			maps\mp\gametypes\_gamescore::func_3D00("gained_gun_score",param_01,self,1,1);
			if(param_01.gungamegunindex == level.gun_guns.size - 1)
			{
				maps\mp\_utility::func_6045("mp_enemy_obj_captured");
				level thread maps\mp\_utility::func_7FA0("callout_top_gun_rank",param_01);
			}

			if(param_01.gungamegunindex < level.gun_guns.size)
			{
				param_01 thread maps\mp\gametypes\_rank::func_8E6E("gained_gun_rank");
				param_01 playlocalsound("mp_war_objective_taken");
				param_01 func_9202();
				param_01 maps\mp\_utility::setfakeloadoutweaponslot(level.gun_guns[param_01.gungamegunindex],1);
			}
		}
	}
}

//Function Number: 10
func_9202(param_00)
{
	var_01 = func_91F0();
	self takeallweapons();
	maps\mp\_utility::_giveweapon(var_01);
	if(isdefined(param_00))
	{
		self setspawnweapon(var_01);
	}

	self.pers["primaryWeapon"] = var_01;
	self.primaryweapon = var_01;
	self givestartammo(var_01);
	self switchtoweapon(var_01);
	func_9203(var_01);
	maps\mp\gametypes\_weapons::updatetogglescopestate(var_01);
	if(self.gungameprevgunindex > self.gungamegunindex)
	{
		thread maps\mp\gametypes\_rank::func_8E6E("dropped_gun_rank");
	}
	else if(self.gungameprevgunindex < self.gungamegunindex)
	{
		thread maps\mp\gametypes\_rank::func_8E6E("gained_gun_rank");
	}

	self.gungameprevgunindex = self.gungamegunindex;
}

//Function Number: 11
func_91F0()
{
	var_00 = level.gun_guns[self.gungamegunindex];
	return var_00;
}

//Function Number: 12
ontimelimit()
{
	level.finalkillcam_winner = "none";
	var_00 = gethighestprogressedplayers();
	if(!isdefined(var_00) || !var_00.size)
	{
		thread maps\mp\gametypes\_gamelogic::endgame("tie",game["end_reason"]["time_limit_reached"]);
	}

	if(var_00.size == 1)
	{
		thread maps\mp\gametypes\_gamelogic::endgame(var_00[0],game["end_reason"]["time_limit_reached"]);
	}

	if(var_00[var_00.size - 1].gungamegunindex > var_00[var_00.size - 2].gungamegunindex)
	{
		thread maps\mp\gametypes\_gamelogic::endgame(var_00[var_00.size - 1],game["end_reason"]["time_limit_reached"]);
	}

	thread maps\mp\gametypes\_gamelogic::endgame("tie",game["end_reason"]["time_limit_reached"]);
}

//Function Number: 13
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

//Function Number: 14
func_6429()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("reload");
		self givestartammo(self.primaryweapon);
	}
}

//Function Number: 15
func_93E9()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		if(maps\mp\_utility::func_4945(self) && self.team != "spectator" && isdefined(self.primaryweapon) && self getammocount(self.primaryweapon) == 0)
		{
			wait(2);
			self notify("reload");
			wait(1);
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 16
func_944E()
{
	level.gun_guns = [];
	level.selectedweapons = [];
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
		}
	}

	level.gun_guns[0] = "rand_pistol";
	level.gun_guns[1] = "rand_shotgun";
	level.gun_guns[2] = "rand_smg";
	level.gun_guns[3] = "rand_assault";
	level.gun_guns[4] = "rand_lmg";
	level.gun_guns[5] = "rand_dmr";
	level.gun_guns[6] = "rand_smg";
	level.gun_guns[7] = "rand_assault";
	level.gun_guns[8] = "rand_lmg2";
	level.gun_guns[9] = "rand_launcher";
	level.gun_guns[10] = "rand_sniper";
	level.gun_guns[11] = "rand_smg";
	level.gun_guns[12] = "rand_assault2";
	level.gun_guns[13] = "rand_shotgun2";
	level.gun_guns[14] = "rand_dmr";
	level.gun_guns[15] = "rand_sniper2";
	level.gun_guns[16] = "iw6_magnum_mp_acogpistol_akimbo";
	level.gun_guns[17] = "iw6_knifeonly_mp";
}

//Function Number: 17
func_944F()
{
	level.selectedweapons = [];
	func_9039();
	for(var_00 = 0;var_00 < level.gun_guns.size;var_00++)
	{
		var_01 = level.gun_guns[var_00];
		if(maps\mp\_utility::func_4971(var_01,"rand_"))
		{
			level.gun_guns[var_00] = func_91F3(var_01);
			continue;
		}

		var_02 = maps\mp\_utility::func_3A37(level.gun_guns[var_00]);
		level.selectedweapons[var_02] = 1;
	}

	level.selectedweapons = undefined;
}

//Function Number: 18
func_70CE()
{
	level.gun_loadouts["axis"]["loadoutPrimary"] = "iw6_sc2010";
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
	level.gun_loadouts["axis"]["loadoutStreakType"] = "assault";
	level.gun_loadouts["axis"]["loadoutKillstreak1"] = "none";
	level.gun_loadouts["axis"]["loadoutKillstreak2"] = "none";
	level.gun_loadouts["axis"]["loadoutKillstreak3"] = "none";
	level.gun_loadouts["axis"]["loadoutPerks"] = ["specialty_quickswap","specialty_marathon"];
	level.gun_loadouts["axis"]["loadoutJuggernaut"] = 0;
	level.gun_loadouts["allies"] = level.gun_loadouts["axis"];
}

//Function Number: 19
func_9039()
{
	level.weaponcategories = [];
	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow("mp/gunGameWeapons.csv",var_00,0);
		if(var_01 == "")
		{
			break;
		}

		if(!isdefined(level.weaponcategories[var_01]))
		{
			level.weaponcategories[var_01] = [];
		}

		var_02 = tablelookupbyrow("mp/gunGameWeapons.csv",var_00,5);
		if(var_02 == "" || getdvarint(var_02,0) == 1)
		{
			var_03 = [];
			var_03["weapon"] = tablelookupbyrow("mp/gunGameWeapons.csv",var_00,1);
			var_03["min"] = castint(tablelookupbyrow("mp/gunGameWeapons.csv",var_00,2));
			var_03["max"] = castint(tablelookupbyrow("mp/gunGameWeapons.csv",var_00,3));
			var_03["perk"] = tablelookupbyrow("mp/gunGameWeapons.csv",var_00,4);
			level.weaponcategories[var_01][level.weaponcategories[var_01].size] = var_03;
		}

		var_00++;
	}
}

//Function Number: 20
func_91F3(param_00)
{
	var_01 = level.weaponcategories[param_00];
	if(isdefined(var_01) && var_01.size > 0)
	{
		var_02 = "";
		var_03 = undefined;
		var_04 = 0;
		for(;;)
		{
			var_05 = randomintrange(0,var_01.size);
			var_03 = var_01[var_05];
			var_06 = maps\mp\_utility::func_3A37(var_03["weapon"]);
			if(!isdefined(level.selectedweapons[var_06]) || var_04 > var_01.size)
			{
				level.selectedweapons[var_06] = 1;
				var_02 = var_03["weapon"];
				break;
			}

			var_04++;
		}

		if(var_02 == var_06)
		{
			var_07 = randomintrange(var_03["min"],var_03["max"] + 1);
			var_02 = func_933A(var_02,var_07);
		}

		return var_02;
	}

	return "none";
}

//Function Number: 21
func_933A(param_00,param_01)
{
	var_02 = [];
	var_03 = 0;
	if(param_01 > 0)
	{
		var_04 = maps\mp\_utility::func_3C6F(param_00);
		if(var_04.size > 0)
		{
			var_05 = func_3C61(var_04);
			var_06 = var_05.size;
			for(var_07 = 0;var_07 < param_01;var_07++)
			{
				var_08 = "";
				while(var_08 == "" && var_06 > 0)
				{
					var_06--;
					var_09 = randomint(var_05.size);
					if(maps/mp/gametypes/sotf::attachmentcheck(var_05[var_09],var_02))
					{
						var_08 = maps\mp\_utility::attachmentmap_tounique(var_05[var_09],param_00);
						var_02[var_02.size] = var_08;
						if(maps\mp\_utility::getattachmenttype(var_08) == "rail")
						{
							var_03 = 1;
						}
					}
				}
			}
		}
	}

	var_0A = 0;
	var_0B = 0;
	var_0C = maps\mp\gametypes\_class::buildweaponname(param_00,var_02,var_0A,var_0B);
	return var_0C;
}

//Function Number: 22
func_3C61(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		switch(var_03)
		{
			case "silencer":
			case "ammoslug":
			case "gl":
			case "shotgun":
			case "firetypesingle":
			case "firetypeauto":
			case "firetypeburst":
				break;

			default:
				var_01[var_01.size] = var_03;
				break;
		}
	}

	return var_01;
}

//Function Number: 23
func_9203(param_00)
{
	if(maps\mp\gametypes\_weapons::isknifeonly(param_00))
	{
		maps\mp\_utility::giveperkequipment("throwingknife_mp",1);
		self.loadoutperkequipment = "throwingknife_mp";
		maps\mp\_utility::func_3CFB("specialty_extra_deadly",0);
		maps\mp\_utility::func_3CFB("specialty_scavenger",0);
	}

	self takeweapon("throwingknife_mp");
	maps\mp\_utility::giveperkequipment("specialty_null",1);
}

//Function Number: 24
func_92B3(param_00)
{
	return param_00 == "throwingknife_mp" && isdefined(self.loadoutperkequipment) && self.loadoutperkequipment == "throwingknife_mp";
}

//Function Number: 25
onplayerscore(param_00,param_01,param_02)
{
	var_03 = 0;
	if(param_00 == "gained_gun_score" || param_00 == "dropped_gun_score")
	{
		var_03 = maps\mp\gametypes\_rank::func_3BE0(param_00);
	}

	return var_03;
}