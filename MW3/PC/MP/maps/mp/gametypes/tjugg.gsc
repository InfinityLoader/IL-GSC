/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\tjugg.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 255 ms
 * Timestamp: 10/27/2023 2:13:36 AM
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
		maps\mp\_utility::registerroundlimitdvar(level.gametype,1);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,7500);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::registernumlivesdvar(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_juggswitchtime = 90;
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	func_3989();
	level.teambased = 1;
	level.doprematch = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	level.matchrules_juggswitchtime = getmatchrulesdata("tjuggData","juggSwitchTime");
	setdynamicdvar("scr_tjugg_roundswitch",0);
	maps\mp\_utility::registerroundswitchdvar("tjugg",0,0,9);
	setdynamicdvar("scr_tjugg_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar("tjugg",1);
	setdynamicdvar("scr_tjugg_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("tjugg",1);
	setdynamicdvar("scr_tjugg_halftime",0);
	maps\mp\_utility::registerhalftimedvar("tjugg",0);
	setdynamicdvar("scr_team_fftype",0);
	setdynamicdvar("scr_tjugg_promode",0);
}

//Function Number: 3
onprecachegametype()
{
	precachestring(&"MP_JUGG_NEXT_JUGG_IN");
}

//Function Number: 4
onstartgametype()
{
	setclientnamemode("auto_change");
	maps\mp\_utility::setobjectivetext("allies",&"OBJECTIVES_TJUGG");
	maps\mp\_utility::setobjectivetext("axis",&"OBJECTIVES_TJUGG");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_TJUGG");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_TJUGG");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_TJUGG_SCORE");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_TJUGG_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_TJUGG_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_TJUGG_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_tdm_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_tdm_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	maps\mp\gametypes\_rank::registerscoreinfo("got_juggernaut",250);
	maps\mp\gametypes\_rank::registerscoreinfo("kill_juggernaut",250);
	maps\mp\gametypes\_rank::registerscoreinfo("kill_as_juggernaut",100);
	maps\mp\gametypes\_rank::registerscoreinfo("jugg_on_jugg",400);
	var_00[0] = "tjugg";
	maps\mp\gametypes\_gameobjects::main(var_00);
	level.quickmessagetoall = 1;
	level.blockweapondrops = 1;
	level.respawnoldjugg_fx = loadfx("explosions/bouncing_betty_explosion");
	level.jugg_available = [];
	level.jugg_available["axis"] = 1;
	level.jugg_available["allies"] = 1;
	level.jugg_attackers = [];
	level.jugg_attackers["axis"] = [];
	level.jugg_attackers["allies"] = [];
	level.jugg_currjugg = [];
	level.jugg_currjugg["axis"] = undefined;
	level.jugg_currjugg["allies"] = undefined;
	level.tjugg_timerdisplay = [];
	level.tjugg_timerdisplay["allies"] = maps\mp\gametypes\_hud_util::createservertimer("objective",1.4,"allies");
	level.tjugg_timerdisplay["allies"] maps\mp\gametypes\_hud_util::setpoint("TOPLEFT","TOPLEFT",115,5);
	level.tjugg_timerdisplay["allies"].label = &"MP_JUGG_NEXT_JUGG_IN";
	level.tjugg_timerdisplay["allies"].alpha = 0;
	level.tjugg_timerdisplay["allies"].archived = 0;
	level.tjugg_timerdisplay["allies"].hidewheninmenu = 1;
	level.tjugg_timerdisplay["axis"] = maps\mp\gametypes\_hud_util::createservertimer("objective",1.4,"axis");
	level.tjugg_timerdisplay["axis"] maps\mp\gametypes\_hud_util::setpoint("TOPLEFT","TOPLEFT",115,5);
	level.tjugg_timerdisplay["axis"].label = &"MP_JUGG_NEXT_JUGG_IN";
	level.tjugg_timerdisplay["axis"].alpha = 0;
	level.tjugg_timerdisplay["axis"].archived = 0;
	level.tjugg_timerdisplay["axis"].hidewheninmenu = 1;
	thread func_39A2(level.tjugg_timerdisplay["allies"]);
	thread func_39A2(level.tjugg_timerdisplay["axis"]);
	level.favorclosespawnscalar = 5;
	level thread onplayerconnect();
}

//Function Number: 5
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.jugg_alligience = 0;
	}
}

//Function Number: 6
getspawnpoint()
{
	if(level.ingraceperiod)
	{
		var_00 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_tdm_spawn_" + self.pers["team"] + "_start");
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_00);
	}
	else
	{
		level.favorclosespawnent = level.jugg_currjugg[self.pers["team"]];
		var_00 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.pers["team"]);
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(var_01);
	}

	return var_01;
}

//Function Number: 7
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(param_03 == "MOD_SUICIDE" && param_04 == "none")
	{
		return;
	}

	var_0A = self;
	if(isdefined(param_01) && isplayer(param_01))
	{
		var_0B = 0;
		var_0C = 0;
		var_0D = 0;
		var_0E = 0;
		var_0F = 0;
		var_10 = 0;
		var_11 = 0;
		if(param_01 == var_0A)
		{
			if(isdefined(var_0A.isjuggmodejuggernaut))
			{
				var_0C = 1;
			}
		}
		else if(param_01.team != var_0A.team)
		{
			var_11 = var_11 + maps\mp\gametypes\_rank::getscoreinfovalue("kill");
			if(isdefined(var_0A.isjuggmodejuggernaut))
			{
				var_0C = 1;
				if(isdefined(param_01.isjuggmodejuggernaut))
				{
					var_0D = 1;
				}
				else
				{
					var_0E = 1;
				}
			}
			else if(isdefined(param_01.isjuggmodejuggernaut))
			{
				var_0F = 1;
			}

			if(level.jugg_available[param_01.team])
			{
				var_0B = 1;
			}
		}
		else if(isdefined(var_0A.isjuggmodejuggernaut) && param_01.team == var_0A.team)
		{
			var_0A thread func_3A39();
			return;
		}

		if(var_0B)
		{
			func_3A38(param_01);
		}

		if(var_0C)
		{
			var_12 = func_3A56(var_0A.team,0);
			if(!isdefined(var_12))
			{
				var_12 = func_3A56(var_0A.team,1);
			}

			if(!isdefined(var_12))
			{
				var_12 = var_0A;
			}

			func_3A38(var_12,var_0A);
		}

		if(var_0B || var_0C)
		{
			maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured");
		}

		if(param_01 != var_0A && param_01.team != var_0A.team && !isdefined(param_01.isjuggmodejuggernaut))
		{
			param_01.jugg_alligience = param_01.jugg_alligience + 50;
			if(var_0E)
			{
				param_01.jugg_alligience = param_01.jugg_alligience + 100;
			}

			if(isdefined(level.jugg_attackers[param_01.team][var_0A.guid]))
			{
				var_10 = 1;
				param_01.jugg_alligience = param_01.jugg_alligience + 100;
				level.jugg_attackers[param_01.team][var_0A.guid] = undefined;
			}
		}

		if(var_0E)
		{
			var_13 = maps\mp\gametypes\_rank::getscoreinfovalue("kill_juggernaut");
			var_11 = var_11 + var_13;
			param_01 thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_KILLED_JUGGERNAUT");
			lib_036E::func_2B7B("kill_juggernaut",param_01,var_0A,1);
			param_01 thread maps\mp\gametypes\_rank::giverankxp("kill_juggernaut");
		}
		else if(var_0D)
		{
			var_11 = var_11 + maps\mp\gametypes\_rank::getscoreinfovalue("jugg_on_jugg");
			param_01 thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_JUGGERNAUT_KILL_JUGGERNAUT");
			lib_036E::func_2B7B("jugg_on_jugg",param_01,var_0A,1);
			param_01 thread maps\mp\gametypes\_rank::giverankxp("jugg_on_jugg");
		}
		else if(var_0F)
		{
			var_11 = var_11 + maps\mp\gametypes\_rank::getscoreinfovalue("kill_as_juggernaut");
			param_01 thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_JUGGERNAUT_KILL");
			lib_036E::func_2B7B("kill_as_juggernaut",param_01,var_0A,1);
			param_01 thread maps\mp\gametypes\_rank::giverankxp("kill_as_juggernaut");
		}

		if(var_11)
		{
			param_01 lib_036E::func_2B88(param_01.pers["team"],var_11);
		}

		if(param_01.team != var_0A.team && game["state"] == "postgame" && game["teamScores"][param_01.team] > game["teamScores"][level.otherteam[param_01.team]])
		{
			param_01.finalkill = 1;
			return;
		}

		return;
	}

	if(isdefined(var_0A.isjuggmodejuggernaut))
	{
		var_12 = func_3A56(var_0A.team,0);
		if(!isdefined(var_12))
		{
			var_12 = func_3A56(var_0A.team,1);
		}

		if(!isdefined(var_12))
		{
			var_12 = var_0A;
		}

		func_3A38(var_12,var_0A);
	}
}

//Function Number: 8
func_3A38(param_00,param_01)
{
	if(isdefined(param_01))
	{
		param_01.isjuggmodejuggernaut = undefined;
	}
	else
	{
		level.jugg_available[param_00.team] = 0;
	}

	level.jugg_currjugg[param_00.team] = undefined;
	level.tjugg_timerdisplay[param_00.team].alpha = 0;
	level.jugg_attackers[param_00.team] = [];
	foreach(var_03 in level.players)
	{
		if(var_03.team == param_00.team)
		{
			var_03.jugg_alligience = 0;
		}
	}

	param_00 thread func_3A39();
}

//Function Number: 9
func_3A39()
{
	if(!maps\mp\_utility::isreallyalive(self) || maps\mp\_utility::isusingremote())
	{
		self endon("disconnect");
		thread func_3A55(0);
		while(!maps\mp\_utility::isreallyalive(self) || maps\mp\_utility::isusingremote())
		{
			wait 0.05;
		}

		self notify("end_resetJuggLoadoutOnDisconnect");
	}

	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait 0.05;
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		self notify("lost_juggernaut");
		wait 0.05;
	}

	self.isjuggmodejuggernaut = 1;
	level.jugg_currjugg[self.team] = self;
	self.pers["gamemodeLoadout"] = level.tjugg_loadouts[self.pers["team"]];
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
	self.faux_spawn_stance = self getstance();
	thread maps\mp\gametypes\_playerlogic::spawnplayer(1);
	var_01 = maps\mp\gametypes\_rank::getscoreinfovalue("got_juggernaut");
	thread maps\mp\gametypes\_hud_message::splashnotify("got_juggernaut",var_01);
	lib_036E::func_2B7B("got_juggernaut",self,undefined,1);
	thread func_3A55(1);
	thread resetjuggloadoutonchangeteam();
	thread func_3A53();
	thread func_3A54();
	thread func_3A51();
}

//Function Number: 10
func_3A51()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	level.tjugg_timerdisplay[self.team].label = &"MP_JUGG_NEXT_JUGG_IN";
	level.tjugg_timerdisplay[self.team] settimer(level.matchrules_juggswitchtime);
	level.tjugg_timerdisplay[self.team].alpha = 1;
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(level.matchrules_juggswitchtime);
	level.tjugg_timerdisplay[self.team].alpha = 0;
	var_00 = func_3A56(self.team,0);
	if(!isdefined(var_00))
	{
		var_00 = func_3A56(self.team,1);
	}

	if(!isdefined(var_00))
	{
		var_00 = self;
	}

	maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured");
	func_3A38(var_00,self);
	if(var_00 != self)
	{
		thread func_3A52();
	}
}

//Function Number: 11
func_3A52()
{
	level endon("game_ended");
	self endon("disconnect");
	while(!maps\mp\_utility::isreallyalive(self) || maps\mp\_utility::isusingremote())
	{
		wait 0.05;
	}

	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait 0.05;
	}

	playfx(level.respawnoldjugg_fx,self.origin);
	self notify("lost_juggernaut");
	wait 0.05;
	self notify("faux_spawn");
	self.faux_spawn_stance = self getstance();
	thread maps\mp\gametypes\_playerlogic::spawnplayer(1);
}

//Function Number: 12
func_3A53()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		wait 1;
		foreach(var_01 in level.players)
		{
			if(maps\mp\_utility::isreallyalive(var_01) && !var_01 maps\mp\_utility::isusingremote() && var_01 != self && var_01.team == self.team && distancesquared(var_01.origin,self.origin) < -17136)
			{
				var_01.jugg_alligience = var_01.jugg_alligience + 25;
			}
		}
	}
}

//Function Number: 13
func_3A54()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		if(isplayer(var_01) && var_01.team != self.team)
		{
			if(!isdefined(level.jugg_attackers[self.team][var_01.guid]))
			{
				level.jugg_attackers[self.team][var_01.guid] = 1;
			}
		}
	}
}

//Function Number: 14
func_3A55(param_00)
{
	level endon("game_ended");
	if(param_00)
	{
		self endon("death");
	}
	else
	{
		self endon("end_resetJuggLoadoutOnDisconnect");
	}

	var_01 = self.team;
	self waittill("disconnect");
	var_02 = func_3A56(var_01,0);
	if(!isdefined(var_02))
	{
		var_02 = func_3A56(var_01,1);
	}

	if(isdefined(var_02))
	{
		maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured");
		func_3A38(var_02);
		return;
	}

	level.jugg_available[var_01] = 1;
	level.jugg_currjugg[var_01] = undefined;
	level.tjugg_timerdisplay[var_01].alpha = 0;
	level.jugg_attackers[var_01] = [];
	foreach(var_04 in level.players)
	{
		if(var_04.team == var_01)
		{
			var_04.jugg_alligience = 0;
		}
	}
}

//Function Number: 15
resetjuggloadoutonchangeteam()
{
	level endon("game_ended");
	self endon("disconnect");
	var_00 = self.team;
	common_scripts\utility::waittill_any("joined_team","joined_spectators");
	self.isjuggmodejuggernaut = undefined;
	var_01 = func_3A56(var_00,0);
	if(!isdefined(var_01))
	{
		var_01 = func_3A56(var_00,1);
	}

	if(isdefined(var_01))
	{
		maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured");
		func_3A38(var_01);
		return;
	}

	level.jugg_available[var_00] = 1;
	level.jugg_currjugg[var_00] = undefined;
	level.tjugg_timerdisplay[var_00].alpha = 0;
	level.jugg_attackers[var_00] = [];
	foreach(var_03 in level.players)
	{
		if(var_03.team == var_00)
		{
			var_03.jugg_alligience = 0;
		}
	}
}

//Function Number: 16
func_3A56(param_00,param_01)
{
	var_02 = undefined;
	var_03 = -1;
	foreach(var_05 in level.players)
	{
		if((param_01 || !var_05 maps\mp\_utility::isusingremote()) && var_05 != self && var_05.team == param_00 && var_05.jugg_alligience > var_03)
		{
			var_02 = var_05;
			var_03 = var_05.jugg_alligience;
		}
	}

	return var_02;
}

//Function Number: 17
func_39A2(param_00)
{
	level waittill("game_ended");
	param_00.alpha = 0;
}

//Function Number: 18
func_3989()
{
	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","axis",5,"class","inUse"))
	{
		level.tjugg_loadouts["axis"] = maps\mp\_utility::getmatchrulesspecialclass("axis",5);
		level.tjugg_loadouts["axis"]["loadoutJuggernaut"] = 1;
	}
	else
	{
		level.tjugg_loadouts["axis"]["loadoutPrimary"] = "iw5_scar";
		level.tjugg_loadouts["axis"]["loadoutPrimaryAttachment"] = "none";
		level.tjugg_loadouts["axis"]["loadoutPrimaryAttachment2"] = "none";
		level.tjugg_loadouts["axis"]["loadoutPrimaryBuff"] = "specialty_bulletpenetration";
		level.tjugg_loadouts["axis"]["loadoutPrimaryCamo"] = "none";
		level.tjugg_loadouts["axis"]["loadoutPrimaryReticle"] = "none";
		level.tjugg_loadouts["axis"]["loadoutSecondary"] = "rpg";
		level.tjugg_loadouts["axis"]["loadoutSecondaryAttachment"] = "none";
		level.tjugg_loadouts["axis"]["loadoutSecondaryAttachment2"] = "none";
		level.tjugg_loadouts["axis"]["loadoutSecondaryBuff"] = "specialty_null";
		level.tjugg_loadouts["axis"]["loadoutSecondaryCamo"] = "none";
		level.tjugg_loadouts["axis"]["loadoutSecondaryReticle"] = "none";
		level.tjugg_loadouts["axis"]["loadoutEquipment"] = "frag_grenade_mp";
		level.tjugg_loadouts["axis"]["loadoutOffhand"] = "smoke_grenade_mp";
		level.tjugg_loadouts["axis"]["loadoutPerk1"] = "specialty_scavenger";
		level.tjugg_loadouts["axis"]["loadoutPerk2"] = "_specialty_blastshield";
		level.tjugg_loadouts["axis"]["loadoutPerk3"] = "specialty_bulletaccuracy";
		level.tjugg_loadouts["axis"]["loadoutDeathstreak"] = "specialty_null";
		level.tjugg_loadouts["axis"]["loadoutJuggernaut"] = 1;
	}

	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","allies",5,"class","inUse"))
	{
		level.tjugg_loadouts["allies"] = maps\mp\_utility::getmatchrulesspecialclass("allies",5);
		level.tjugg_loadouts["allies"]["loadoutJuggernaut"] = 1;
		return;
	}

	level.tjugg_loadouts["allies"]["loadoutPrimary"] = "iw5_scar";
	level.tjugg_loadouts["allies"]["loadoutPrimaryAttachment"] = "none";
	level.tjugg_loadouts["allies"]["loadoutPrimaryAttachment2"] = "none";
	level.tjugg_loadouts["allies"]["loadoutPrimaryBuff"] = "specialty_bulletpenetration";
	level.tjugg_loadouts["allies"]["loadoutPrimaryCamo"] = "none";
	level.tjugg_loadouts["allies"]["loadoutPrimaryReticle"] = "none";
	level.tjugg_loadouts["allies"]["loadoutSecondary"] = "rpg";
	level.tjugg_loadouts["allies"]["loadoutSecondaryAttachment"] = "none";
	level.tjugg_loadouts["allies"]["loadoutSecondaryAttachment2"] = "none";
	level.tjugg_loadouts["allies"]["loadoutSecondaryBuff"] = "specialty_null";
	level.tjugg_loadouts["allies"]["loadoutSecondaryCamo"] = "none";
	level.tjugg_loadouts["allies"]["loadoutSecondaryReticle"] = "none";
	level.tjugg_loadouts["allies"]["loadoutEquipment"] = "frag_grenade_mp";
	level.tjugg_loadouts["allies"]["loadoutOffhand"] = "smoke_grenade_mp";
	level.tjugg_loadouts["allies"]["loadoutPerk1"] = "specialty_scavenger";
	level.tjugg_loadouts["allies"]["loadoutPerk2"] = "_specialty_blastshield";
	level.tjugg_loadouts["allies"]["loadoutPerk3"] = "specialty_bulletaccuracy";
	level.tjugg_loadouts["allies"]["loadoutDeathstreak"] = "specialty_null";
	level.tjugg_loadouts["allies"]["loadoutJuggernaut"] = 1;
}