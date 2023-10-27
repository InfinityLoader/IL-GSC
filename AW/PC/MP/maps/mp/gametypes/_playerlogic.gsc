/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/gametypes/_playerlogic.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 71
 * Decompile Time: 1089 ms
 * Timestamp: 10/27/2023 1:50:53 AM
*******************************************************************/

//Function Number: 1
timeuntilwavespawn(param_00)
{
	if(!self.hasspawned)
	{
		return 0;
	}

	var_01 = gettime() + param_00 * 1000;
	var_02 = level.lastwave[self.pers["team"]];
	var_03 = level.wavedelay[self.pers["team"]] * 1000;
	var_04 = var_01 - var_02 / var_03;
	var_05 = ceil(var_04);
	var_06 = var_02 + var_05 * var_03;
	if(isdefined(self.respawntimerstarttime))
	{
		var_07 = gettime() - self.respawntimerstarttime / 1000;
		if(self.respawntimerstarttime < var_02)
		{
			return 0;
		}
	}

	if(isdefined(self.wavespawnindex))
	{
		var_06 = var_06 + 50 * self.wavespawnindex;
	}

	return var_06 - gettime() / 1000;
}

//Function Number: 2
teamkilldelay()
{
	var_00 = self.pers["teamkills"];
	if(var_00 <= level.maxallowedteamkills)
	{
		return 0;
	}

	var_01 = var_00 - level.maxallowedteamkills;
	return maps\mp\gametypes\_tweakables::gettweakablevalue("team","teamkillspawndelay") * var_01;
}

//Function Number: 3
timeuntilspawn(param_00)
{
	if((level.ingraceperiod && !self.hasspawned) || level.gameended)
	{
		return 0;
	}

	var_01 = 0;
	if(self.hasspawned)
	{
		var_02 = self [[ level.onrespawndelay ]]();
		if(isdefined(var_02))
		{
			var_01 = var_02;
		}
		else
		{
			var_01 = getdvarint("scr_" + level.gametype + "_playerrespawndelay");
		}

		if(param_00)
		{
			if(isdefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"])
			{
				var_01 = var_01 + teamkilldelay();
			}

			if(isdefined(self.pers["suicideSpawnDelay"]))
			{
				var_01 = var_01 + self.pers["suicideSpawnDelay"];
			}
		}

		if(isdefined(self.respawntimerstarttime))
		{
			var_03 = gettime() - self.respawntimerstarttime / 1000;
			var_01 = var_01 - var_03;
			if(var_01 < 0)
			{
				var_01 = 0;
			}
		}

		if(isdefined(self.setspawnpoint))
		{
			var_01 = var_01 + level.tispawndelay;
		}
	}

	var_04 = getdvarfloat("scr_" + level.gametype + "_waverespawndelay") > 0;
	if(var_04)
	{
		return timeuntilwavespawn(var_01);
	}

	return var_01;
}

//Function Number: 4
mayspawn()
{
	if(maps\mp\_utility::getgametypenumlives() || isdefined(level.disablespawning))
	{
		if(isdefined(level.disablespawning) && level.disablespawning)
		{
			return 0;
		}

		if(isdefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"])
		{
			return 0;
		}

		if(!self.pers["lives"] && maps\mp\_utility::gamehasstarted())
		{
			return 0;
		}
		else if(maps\mp\_utility::gamehasstarted())
		{
			if(!level.ingraceperiod && !self.hasspawned && isdefined(level.allowlatecomers) && !level.allowlatecomers)
			{
				return 0;
			}
		}

		if(isdefined(level.disablespawningforplayerfunc) && [[ level.disablespawningforplayerfunc ]](self))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 5
spawnclient()
{
	self endon("becameSpectator");
	if(isdefined(self.clientid))
	{
	}
	else
	{
	}

	if(isdefined(self.waitingtoselectclass) && self.waitingtoselectclass)
	{
		self waittill("notWaitingToSelectClass");
	}

	if(isdefined(self.addtoteam))
	{
		maps\mp\gametypes\_menus::addtoteam(self.addtoteam);
		self.addtoteam = undefined;
	}

	if(!mayspawn())
	{
		wait(0.05);
		self notify("attempted_spawn");
		var_00 = self.pers["teamKillPunish"];
		if(isdefined(var_00) && var_00)
		{
			self.pers["teamkills"] = max(self.pers["teamkills"] - 1,0);
			maps\mp\_utility::setlowermessage("friendly_fire",&"MP_FRIENDLY_FIRE_WILL_NOT");
			if(!self.hasspawned && teamkilldelay() <= 0)
			{
				self.pers["teamKillPunish"] = 0;
			}
		}
		else if(maps\mp\_utility::isroundbased() && !maps\mp\_utility::islastround())
		{
			if(isdefined(self.tagavailable) && self.tagavailable)
			{
				maps\mp\_utility::setlowermessage("spawn_info",game["strings"]["spawn_tag_wait"]);
			}
			else
			{
				maps\mp\_utility::setlowermessage("spawn_info",game["strings"]["spawn_next_round"]);
			}

			thread removespawnmessageshortly(3);
		}

		thread spawnspectator();
		return;
	}

	if(self.waitingtospawn)
	{
		return;
	}

	self.waitingtospawn = 1;
	waitandspawnclient();
	if(isdefined(self))
	{
		self.waitingtospawn = 0;
	}
}

//Function Number: 6
streamprimaryweapons()
{
	if(maps\mp\_utility::allowclasschoice() && !isai(self))
	{
		var_00 = [];
		var_01 = ["custom1","custom2","custom3","custom4","custom5","class0","class1","class2","class3","class4"];
		foreach(var_03 in var_01)
		{
			var_04 = maps\mp\gametypes\_class::getloadout(self.team,var_03);
			var_00[var_00.size] = var_04.primaryname;
		}

		self loadweapons(var_00);
	}
}

//Function Number: 7
gatherclassweapons(param_00,param_01)
{
	var_02 = [];
	var_03 = param_01;
	if(!maps\mp\_utility::isvalidclass(var_03))
	{
		var_03 = self.class;
	}

	if(maps\mp\_utility::isvalidclass(var_03))
	{
		var_04 = maps\mp\gametypes\_class::getloadout(self.team,var_03);
		var_02[var_02.size] = var_04.primaryname;
		if(!isdefined(param_00) || !param_00)
		{
			var_02[var_02.size] = var_04.secondaryname;
		}
	}

	return var_02;
}

//Function Number: 8
streamclassweapons(param_00,param_01,param_02)
{
	self.classweaponswait = 0;
	self notify("endStreamClassWeapons");
	self endon("endStreamClassWeapons");
	self endon("death");
	self endon("disconnect");
	if(isai(self) || !isdefined(param_00))
	{
		param_00 = 0;
	}

	var_03 = gatherclassweapons(param_01,param_02);
	if(var_03.size > 0)
	{
		while(isdefined(self.loadingplayerweapons) && self.loadingplayerweapons)
		{
			wait(0.05);
		}

		param_00 = !self loadweapons(var_03) && param_00;
		self onlystreamactiveweapon(1);
		self.classweaponswait = param_00;
		while(param_00)
		{
			wait 0.05;
			param_00 = !self loadweapons(var_03);
		}

		self onlystreamactiveweapon(0);
	}

	self.classweaponswait = 0;
	self notify("streamClassWeaponsComplete");
}

//Function Number: 9
waitandspawnclient()
{
	self endon("disconnect");
	self endon("end_respawn");
	level endon("game_ended");
	self notify("attempted_spawn");
	if(isdefined(self.clientid))
	{
	}
	else
	{
	}

	var_00 = 0;
	var_01 = getentarray("mp_global_intermission","classname");
	var_02 = var_01[randomint(var_01.size)];
	var_03 = self.pers["teamKillPunish"];
	if(isdefined(var_03) && var_03)
	{
		var_04 = teamkilldelay();
		if(var_04 > 0)
		{
			maps\mp\_utility::setlowermessage("friendly_fire",&"MP_FRIENDLY_FIRE_WILL_NOT",var_04,1,1);
			thread respawn_asspectator(var_02.origin,var_02.angles);
			var_00 = 1;
			wait(var_04);
			maps\mp\_utility::clearlowermessage("friendly_fire");
			self.respawntimerstarttime = gettime();
		}

		self.pers["teamKillPunish"] = 0;
	}
	else if(teamkilldelay())
	{
		self.pers["teamkills"] = max(self.pers["teamkills"] - 1,0);
	}

	var_05 = self.pers["suicideSpawnDelay"];
	if(isdefined(var_05) && var_05 > 0)
	{
		maps\mp\_utility::setlowermessage("suicidePenalty",&"MP_SUICIDE_PUNISHED",var_05,1,1);
		if(!var_00)
		{
			thread respawn_asspectator(var_02.origin,var_02.angles);
		}

		var_00 = 1;
		wait(var_05);
		maps\mp\_utility::clearlowermessage("suicidePenalty");
		self.respawntimerstarttime = gettime();
		self.pers["suicideSpawnDelay"] = 0;
	}

	if(maps\mp\_utility::isusingremote())
	{
		self.spawningafterremotedeath = 1;
		self.deathposition = self.origin;
		self waittill("stopped_using_remote");
	}

	if(!isdefined(self.wavespawnindex) && isdefined(level.waveplayerspawnindex[self.team]))
	{
		self.wavespawnindex = level.waveplayerspawnindex[self.team];
		level.waveplayerspawnindex[self.team]++;
	}

	var_06 = timeuntilspawn(0);
	if(var_06 > 0)
	{
		self setclientomnvar("ui_killcam_time_until_spawn",gettime() + var_06 * 1000);
		if(!var_00)
		{
			thread respawn_asspectator(var_02.origin,var_02.angles);
		}

		var_00 = 1;
		maps\mp\_utility::waitfortimeornotify(var_06,"force_spawn");
		self notify("stop_wait_safe_spawn_button");
	}

	if(needsbuttontorespawn())
	{
		maps\mp\_utility::setlowermessage("spawn_info",game["strings"]["press_to_spawn"],undefined,undefined,undefined,undefined,undefined,undefined,1);
		if(!var_00)
		{
			thread respawn_asspectator(var_02.origin,var_02.angles);
		}

		var_00 = 1;
		waitrespawnbutton();
	}

	self.waitingtospawn = 0;
	maps\mp\_utility::clearlowermessage("spawn_info");
	self.wavespawnindex = undefined;
	thread spawnplayer();
}

//Function Number: 10
needsbuttontorespawn()
{
	if(maps\mp\gametypes\_tweakables::gettweakablevalue("player","forcerespawn") != 0)
	{
		return 0;
	}

	if(!self.hasspawned)
	{
		return 0;
	}

	var_00 = getdvarfloat("scr_" + level.gametype + "_waverespawndelay") > 0;
	if(var_00)
	{
		return 0;
	}

	if(self.wantsafespawn)
	{
		return 0;
	}

	return 1;
}

//Function Number: 11
waitrespawnbutton()
{
	self endon("disconnect");
	self endon("end_respawn");
	for(;;)
	{
		if(self usebuttonpressed())
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 12
removespawnmessageshortly(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	waittillframeend;
	self endon("end_respawn");
	wait(param_00);
	maps\mp\_utility::clearlowermessage("spawn_info");
}

//Function Number: 13
laststandrespawnplayer()
{
	self laststandrevive();
	if(maps\mp\_utility::_hasperk("specialty_finalstand") && !level.diehardmode)
	{
		maps\mp\_utility::_unsetperk("specialty_finalstand");
	}

	if(level.diehardmode)
	{
		self.headicon = "";
	}

	self setstance("crouch");
	self.revived = 1;
	self notify("revive");
	if(isdefined(self.standardmaxhealth))
	{
		self.maxhealth = self.standardmaxhealth;
	}

	self.health = self.maxhealth;
	common_scripts\utility::_enableusability();
	if(game["state"] == "postgame")
	{
		maps\mp\gametypes\_gamelogic::freezeplayerforroundend();
	}
}

//Function Number: 14
getdeathspawnpoint()
{
	var_00 = spawn("script_origin",self.origin);
	var_00 hide();
	var_00.angles = self.angles;
	return var_00;
}

//Function Number: 15
showspawnnotifies()
{
}

//Function Number: 16
getspawnorigin(param_00)
{
	if(!positionwouldtelefrag(param_00.origin))
	{
		return param_00.origin;
	}

	if(!isdefined(param_00.alternates))
	{
		return param_00.origin;
	}

	foreach(var_02 in param_00.alternates)
	{
		if(!positionwouldtelefrag(var_02))
		{
			return var_02;
		}
	}

	return param_00.origin;
}

//Function Number: 17
tivalidationcheck()
{
	if(!isdefined(self.setspawnpoint))
	{
		return 0;
	}

	var_00 = getentarray("care_package","targetname");
	foreach(var_02 in var_00)
	{
		if(distancesquared(var_02.origin,self.setspawnpoint.playerspawnpos) > 4096)
		{
			continue;
		}

		maps\mp\perks\_perkfunctions::deleteti(self.setspawnpoint);
		return 0;
	}

	return 1;
}

//Function Number: 18
spawningclientthisframereset()
{
	self notify("spawningClientThisFrameReset");
	self endon("spawningClientThisFrameReset");
	wait(0.05);
	level.numplayerswaitingtospawn--;
}

//Function Number: 19
setuioptionsmenu(param_00)
{
	self endon("disconnect");
	self endon("joined_spectators");
	while(self ismlgspectator() && !maps\mp\_utility::invirtuallobby())
	{
		wait 0.05;
	}

	self setclientomnvar("ui_options_menu",param_00);
}

//Function Number: 20
gather_spawn_weapons()
{
	var_00 = [];
	if(isdefined(self.loadout))
	{
		var_00[var_00.size] = maps\mp\_utility::get_spawn_weapon_name(self.loadout);
		if(isdefined(self.loadout.secondaryname) && self.loadout.secondaryname != "none")
		{
			var_00[var_00.size] = self.loadout.secondaryname;
		}
	}
	else
	{
		if(isdefined(self.primaryweapon) && self.primaryweapon != "none")
		{
			var_00[var_00.size] = self.primaryweapon;
		}

		if(isdefined(self.secondaryweapon) && self.secondaryweapon != "none")
		{
			var_00[var_00.size] = self.secondaryweapon;
		}
	}

	return var_00;
}

//Function Number: 21
spawnplayer(param_00,param_01)
{
	self endon("disconnect");
	self endon("joined_spectators");
	self notify("spawned");
	self notify("end_respawn");
	self notify("started_spawnPlayer");
	if(isdefined(self.clientid))
	{
	}
	else
	{
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(param_01)
	{
		self.spawnplayergivingloadout = 1;
		thread monitordelayedspawnloadouts();
	}

	self.lifeid = maps\mp\_utility::getnextlifeid();
	self.totallifetime = 0;
	var_02 = undefined;
	self.ti_spawn = 0;
	thread setuioptionsmenu(0);
	self setclientomnvar("ui_hud_shake",0);
	self setclientomnvar("ui_exo_cooldown_in_use",0);
	self setdemigod(0);
	self disableforcefirstpersonwhenfollowed();
	if(!level.ingraceperiod && !self.hasdonecombat)
	{
		level.numplayerswaitingtospawn++;
		if(level.numplayerswaitingtospawn > 1)
		{
			self.waitingtospawnamortize = 1;
			wait(0.05 * level.numplayerswaitingtospawn - 1);
		}

		thread spawningclientthisframereset();
		self.waitingtospawnamortize = 0;
	}

	if(param_01)
	{
		var_03 = undefined;
		if(isdefined(level.iszombiegame) && level.iszombiegame)
		{
			var_03 = 0;
		}

		maps\mp\gametypes\_class::giveloadout(self.team,self.class,undefined,var_03);
		var_04 = gather_spawn_weapons();
		self.loadingplayerweapons = 1;
		if(!self hasloadedcustomizationplayerview(self,var_04))
		{
			self.waitingtospawnamortize = 1;
			self onlystreamactiveweapon(1);
			for(;;)
			{
				wait 0.05;
				var_04 = gather_spawn_weapons();
				if(self hasloadedcustomizationplayerview(self,var_04))
				{
					break;
				}
			}

			self onlystreamactiveweapon(0);
			self.waitingtospawnamortize = 0;
		}

		self.loadingplayerweapons = 0;
	}

	if(isdefined(self.forcespawnorigin))
	{
		var_05 = self.forcespawnorigin;
		self.forcespawnorigin = undefined;
		if(isdefined(self.forcespawnangles))
		{
			var_06 = self.forcespawnangles;
			self.forcespawnangles = undefined;
		}
		else
		{
			var_06 = (0,randomfloatrange(0,360),0);
		}
	}
	else if(isdefined(self.setspawnpoint) && isdefined(self.setspawnpoint.notti) || tivalidationcheck())
	{
		var_06 = self.setspawnpoint;
		if(!isdefined(self.setspawnpoint.notti))
		{
			self.ti_spawn = 1;
			self playlocalsound("tactical_spawn");
			if(level.multiteambased)
			{
				foreach(var_08 in level.teamnamelist)
				{
					if(var_08 != self.team)
					{
						self playsoundtoteam("tactical_spawn",var_08);
					}
				}
			}
			else if(level.teambased)
			{
				self playsoundtoteam("tactical_spawn",level.otherteam[self.team]);
			}
			else
			{
				self playsound("tactical_spawn");
			}
		}

		foreach(var_0B in level.ugvs)
		{
			if(distancesquared(var_0B.origin,var_02.playerspawnpos) < 1024)
			{
				var_0B notify("damage",5000,var_0B.owner,(0,0,0),(0,0,0),"MOD_EXPLOSIVE","","","",undefined,"killstreak_emp_mp");
			}
		}

		var_05 = self.setspawnpoint.playerspawnpos;
		var_06 = self.setspawnpoint.angles;
		if(isdefined(self.setspawnpoint.enemytrigger))
		{
			self.setspawnpoint.enemytrigger delete();
		}

		self.setspawnpoint delete();
		var_02 = undefined;
	}
	else if(isdefined(self.isspawningonbattlebuddy) && isdefined(self.battlebuddy))
	{
		var_05 = undefined;
		var_06 = undefined;
		var_0D = maps\mp\gametypes\_battlebuddy::checkbuddyspawn();
		if(var_0D.status == 0)
		{
			var_05 = var_0D.origin;
			var_06 = var_0D.angles;
		}
		else
		{
			var_02 = self [[ level.getspawnpoint ]]();
			var_05 = var_02.origin;
			var_06 = var_02.angles;
		}

		maps\mp\gametypes\_battlebuddy::cleanupbuddyspawn();
		self setclientomnvar("cam_scene_name","battle_spawn");
		self setclientomnvar("cam_scene_lead",self.battlebuddy getentitynumber());
		self setclientomnvar("cam_scene_support",self getentitynumber());
	}
	else if(isdefined(self.helispawning) && !isdefined(self.firstspawn) || isdefined(self.firstspawn) && self.firstspawn && level.prematchperiod > 0 && self.team == "allies")
	{
		while(!isdefined(level.allieschopper))
		{
			wait(0.1);
		}

		var_05 = level.allieschopper.origin;
		var_06 = level.allieschopper.angles;
		self.firstspawn = 0;
	}
	else if(isdefined(self.helispawning) && !isdefined(self.firstspawn) || isdefined(self.firstspawn) && self.firstspawn && level.prematchperiod > 0 && self.team == "axis")
	{
		while(!isdefined(level.axischopper))
		{
			wait(0.1);
		}

		var_05 = level.axischopper.origin;
		var_06 = level.axischopper.angles;
		self.firstspawn = 0;
	}
	else
	{
		var_06 = self [[ level.getspawnpoint ]]();
		var_05 = var_06.origin;
		var_06 = var_05.angles;
	}

	setspawnvariables();
	var_0E = self.hasspawned;
	self.fauxdead = undefined;
	if(!param_00)
	{
		self.killsthislife = [];
		maps\mp\_utility::updatesessionstate("playing");
		maps\mp\_utility::clearkillcamstate();
		self.cancelkillcam = undefined;
		self.maxhealth = maps\mp\gametypes\_tweakables::gettweakablevalue("player","maxhealth");
		self.health = self.maxhealth;
		self.friendlydamage = undefined;
		self.hasspawned = 1;
		self.spawntime = gettime();
		self.spawntimedecisecondsfrommatchstart = maps\mp\_utility::gettimepasseddecisecondsincludingrounds();
		self.wasti = !isdefined(var_02);
		self.afk = 0;
		self.damagedplayers = [];
		self.killstreakscaler = 1;
		self.objectivescaler = 1;
		self.clampedhealth = undefined;
		self.shielddamage = 0;
		self.shieldbullethits = 0;
		self.exocount = [];
		self.exocount["exo_boost"] = 0;
		self.exocount["ground_slam"] = 0;
		self.exocount["exo_dodge"] = 0;
		self.exocount["exo_slide"] = 0;
		self.exomostrecenttimedeciseconds = [];
		thread listenforexomoveevent();
		self.exo_shield_on = 0;
		self.exo_hover_on = 0;
		self.enemyhitcounts = [];
		self.currentfirefightshots = 0;
		if(!isai(self))
		{
			thread maps\mp\gametypes\_damage::clearfirefightshotsoninterval();
		}

		self.scoreatlifestart = self.pers["score"];
		if(isdefined(self.pers["summary"]) && isdefined(self.pers["summary"]["xp"]))
		{
			self.xpatlifestart = self.pers["summary"]["xp"];
		}
	}

	self.movespeedscaler = level.baseplayermovescale;
	self.inlaststand = 0;
	self.laststand = undefined;
	self.infinalstand = undefined;
	self.disabledweapon = 0;
	self.disabledweaponswitch = 0;
	self.disabledoffhandweapons = 0;
	common_scripts\utility::resetusability();
	self.playerdisableabilitytypes = [];
	if(!param_00)
	{
		self.avoidkillstreakonspawntimer = 5;
		var_0F = self.pers["lives"];
		if(var_0F == maps\mp\_utility::getgametypenumlives())
		{
			addtolivescount();
		}

		if(var_0F)
		{
			self.pers["lives"]--;
		}

		addtoalivecount();
		if(!var_0E || maps\mp\_utility::gamehasstarted() || maps\mp\_utility::gamehasstarted() && level.ingraceperiod && self.hasdonecombat)
		{
			removefromlivescount();
		}

		if(!self.wasaliveatmatchstart)
		{
			var_10 = 20;
			if(maps\mp\_utility::gettimelimit() > 0 && var_10 < maps\mp\_utility::gettimelimit() * 60 / 4)
			{
				var_10 = maps\mp\_utility::gettimelimit() * 60 / 4;
			}

			if(level.ingraceperiod || maps\mp\_utility::gettimepassed() < var_10 * 1000)
			{
				self.wasaliveatmatchstart = 1;
			}
		}
	}

	if(level.console)
	{
		self setclientdvar("cg_fov","65");
	}

	resetuidvarsonspawn();
	if(isdefined(var_02))
	{
		maps\mp\gametypes\_spawnlogic::finalizespawnpointchoice(var_02);
		var_05 = getspawnorigin(var_02);
		var_06 = var_02.angles;
	}
	else
	{
		self.lastspawntime = gettime();
	}

	self.spawnpos = var_05;
	self spawn(var_05,var_06);
	maps\mp\_utility::setdof(level.dofdefault);
	if(param_00 && isdefined(self.faux_spawn_stance))
	{
		self setstance(self.faux_spawn_stance);
		self.faux_spawn_stance = undefined;
	}

	[[ level.onspawnplayer ]]();
	if(!param_00)
	{
		maps\mp\gametypes\_missions::playerspawned();
		if(isai(self) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["player_spawned"]))
		{
			self [[ level.bot_funcs["player_spawned"] ]]();
		}
	}

	maps\mp\gametypes\_class::setclass(self.class);
	if(isdefined(level.custom_giveloadout))
	{
		self [[ level.custom_giveloadout ]](param_00);
	}
	else if(param_01)
	{
		maps\mp\gametypes\_class::applyloadout();
		self notify("spawnplayer_giveloadout");
	}

	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::setthirdpersondof(1);
	}

	if(!maps\mp\_utility::gameflag("prematch_done"))
	{
		maps\mp\_utility::freezecontrolswrapper(1);
		self disableammogeneration();
	}
	else
	{
		maps\mp\_utility::freezecontrolswrapper(0);
		self enableammogeneration();
	}

	if(!maps\mp\_utility::gameflag("prematch_done") || !var_0E && game["state"] == "playing")
	{
		var_11 = self.pers["team"];
		if(maps\mp\_utility::inovertime())
		{
			thread maps\mp\gametypes\_hud_message::oldnotifymessage(game["strings"]["overtime"],game["strings"]["overtime_hint"],undefined,(1,0,0),"mp_last_stand");
		}

		thread showspawnnotifies();
	}

	if(maps\mp\_utility::getintproperty("scr_showperksonspawn",1) == 1 && game["state"] != "postgame")
	{
	}

	waittillframeend;
	self.spawningafterremotedeath = undefined;
	self notify("spawned_player");
	level notify("player_spawned",self);
	if(game["state"] == "postgame")
	{
		maps\mp\gametypes\_gamelogic::freezeplayerforroundend();
	}

	if(isdefined(level.matchrules_switchteamdisabled) && level.matchrules_switchteamdisabled)
	{
		self setclientomnvar("ui_disable_team_change",1);
	}
}

//Function Number: 22
monitordelayedspawnloadouts()
{
	common_scripts\utility::waittill_any("disconnected","joined_spectators","spawnplayer_giveloadout");
	self.spawnplayergivingloadout = undefined;
}

//Function Number: 23
listenforexomoveevent()
{
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return("exo_boost","ground_slam","exo_dodge","exo_slide");
		self.exocount[var_00]++;
		self.exomostrecenttimedeciseconds[var_00] = maps\mp\_utility::gettimepasseddecisecondsincludingrounds();
	}
}

//Function Number: 24
spawnspectator(param_00,param_01)
{
	self notify("spawned");
	self notify("end_respawn");
	self notify("joined_spectators");
	in_spawnspectator(param_00,param_01);
}

//Function Number: 25
respawn_asspectator(param_00,param_01)
{
	in_spawnspectator(param_00,param_01);
}

//Function Number: 26
in_spawnspectator(param_00,param_01)
{
	setspawnvariables();
	var_02 = self.pers["team"];
	if(isdefined(var_02) && var_02 == "spectator" && !level.gameended)
	{
		maps\mp\_utility::clearlowermessage("spawn_info");
	}

	maps\mp\_utility::updatesessionstate("spectator");
	maps\mp\_utility::clearkillcamstate();
	self.friendlydamage = undefined;
	self.loadingplayerweapons = undefined;
	resetuidvarsonspectate();
	maps\mp\gametypes\_spectating::setspectatepermissions();
	onspawnspectator(param_00,param_01);
	if(level.teambased && !level.splitscreen && !self issplitscreenplayer())
	{
		self setdepthoffield(0,128,512,4000,6,1.8);
	}
}

//Function Number: 27
getplayerfromclientnum(param_00)
{
	if(param_00 < 0)
	{
		return undefined;
	}

	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		if(level.players[var_01] getentitynumber() == param_00)
		{
			return level.players[var_01];
		}
	}

	return undefined;
}

//Function Number: 28
getrandomspectatorspawnpoint()
{
	var_00 = "mp_global_intermission";
	var_01 = getentarray(var_00,"classname");
	var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_01);
	return var_02;
}

//Function Number: 29
onspawnspectator(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		self setspectatedefaults(param_00,param_01);
		self spawn(param_00,param_01);
		return;
	}

	var_02 = getrandomspectatorspawnpoint();
	self setspectatedefaults(var_02.origin,var_02.angles);
	self spawn(var_02.origin,var_02.angles);
}

//Function Number: 30
spawnintermission()
{
	self endon("disconnect");
	self notify("spawned");
	self notify("end_respawn");
	setspawnvariables();
	maps\mp\_utility::clearlowermessages();
	maps\mp\_utility::freezecontrolswrapper(1);
	self disableammogeneration();
	self setclientdvar("cg_everyoneHearsEveryone",1);
	var_00 = self.pers["postGameChallenges"];
	if(level.rankedmatch && self.postgamepromotion || isdefined(var_00) && var_00)
	{
		if(self.postgamepromotion)
		{
			self playlocalsound("mp_level_up");
		}
		else if(isdefined(var_00))
		{
			self playlocalsound("mp_challenge_complete");
		}

		if(self.postgamepromotion > level.postgamenotifies)
		{
			level.postgamenotifies = 1;
		}

		if(isdefined(var_00) && var_00 > level.postgamenotifies)
		{
			level.postgamenotifies = var_00;
		}

		var_01 = 7;
		if(isdefined(var_00))
		{
			var_01 = 4 + min(var_00,3);
		}

		while(var_01)
		{
			wait(0.25);
			var_01 = var_01 - 0.25;
		}
	}

	maps\mp\_utility::updatesessionstate("intermission");
	maps\mp\_utility::clearkillcamstate();
	self.friendlydamage = undefined;
	var_02 = getentarray("mp_global_intermission","classname");
	var_03 = var_02[0];
	self spawn(var_03.origin,var_03.angles);
	self setdepthoffield(0,128,512,4000,6,1.8);
}

//Function Number: 31
spawnendofgame()
{
	if(1)
	{
		maps\mp\_utility::freezecontrolswrapper(1);
		self disableammogeneration();
		spawnspectator();
		maps\mp\_utility::freezecontrolswrapper(1);
		self disableammogeneration();
		return;
	}

	self notify("spawned");
	self notify("end_respawn");
	setspawnvariables();
	maps\mp\_utility::clearlowermessages();
	self setclientdvar("cg_everyoneHearsEveryone",1);
	maps\mp\_utility::updatesessionstate("dead");
	maps\mp\_utility::clearkillcamstate();
	self.friendlydamage = undefined;
	var_00 = getentarray("mp_global_intermission","classname");
	var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_00);
	self spawn(var_01.origin,var_01.angles);
	var_01 setmodel("tag_origin");
	self playerlinkto(var_01);
	self playerhide();
	maps\mp\_utility::freezecontrolswrapper(1);
	self disableammogeneration();
	self setdepthoffield(0,128,512,4000,6,1.8);
}

//Function Number: 32
setspawnvariables()
{
	self stopshellshock();
	self stoprumble("damage_heavy");
	self.deathposition = undefined;
}

//Function Number: 33
notifyconnecting()
{
	waittillframeend;
	if(isdefined(self))
	{
		level notify("connecting",self);
	}
}

//Function Number: 34
logexostats()
{
	if(isdefined(self.pers["numberOfTimesCloakingUsed"]))
	{
		setmatchdata("players",self.clientid,"numberOfTimesCloakingUsed",maps\mp\_utility::clamptobyte(self.pers["numberOfTimesCloakingUsed"]));
	}

	if(isdefined(self.pers["numberOfTimesHoveringUsed"]))
	{
		setmatchdata("players",self.clientid,"numberOfTimesHoveringUsed",maps\mp\_utility::clamptobyte(self.pers["numberOfTimesHoveringUsed"]));
	}

	if(isdefined(self.pers["numberOfTimesShieldUsed"]))
	{
		setmatchdata("players",self.clientid,"numberOfTimesShieldUsed",maps\mp\_utility::clamptobyte(self.pers["numberOfTimesShieldUsed"]));
	}

	if(isdefined(self.pers["bulletsBlockedByShield"]))
	{
		setmatchdata("players",self.clientid,"bulletsBlockedByShield",self.pers["bulletsBlockedByShield"]);
	}
}

//Function Number: 35
logplayerstats()
{
	logexostats();
	if(isdefined(self.pers["totalKillcamsSkipped"]))
	{
		setmatchdata("players",self.clientid,"totalKillcamsSkipped",maps\mp\_utility::clamptobyte(self.pers["totalKillcamsSkipped"]));
	}

	if(isdefined(self.pers["weaponPickupsCount"]))
	{
		setmatchdata("players",self.clientid,"weaponPickupsCount",maps\mp\_utility::clamptobyte(self.pers["weaponPickupsCount"]));
	}

	if(isdefined(self.pers["suicides"]))
	{
		setmatchdata("players",self.clientid,"suicidesTotal",maps\mp\_utility::clamptobyte(self.pers["suicides"]));
	}

	if(isdefined(self.pers["headshots"]))
	{
		setmatchdata("players",self.clientid,"headshotsTotal",maps\mp\_utility::clamptoshort(self.pers["headshots"]));
	}

	if(isdefined(self.pers["pingAccumulation"]) && isdefined(self.pers["pingSampleCount"]))
	{
		if(self.pers["pingSampleCount"] > 0)
		{
			var_00 = maps\mp\_utility::clamptobyte(self.pers["pingAccumulation"] / self.pers["pingSampleCount"]);
			setmatchdata("players",self.clientid,"averagePing",var_00);
		}
	}

	if(maps\mp\_utility::rankingenabled())
	{
		var_01 = 3;
		var_02 = 0;
		for(var_03 = 0;var_03 < var_01;var_03++)
		{
			var_04 = self getrankedplayerdata("xpMultiplier",var_03);
			if(isdefined(var_04) && var_04 > var_02)
			{
				var_02 = var_04;
			}
		}

		if(var_02 > 0)
		{
			setmatchdata("players",self.clientid,"xpMultiplier",var_02);
		}
	}

	if(isdefined(self.pers["summary"]) && isdefined(self.pers["summary"]["clanWarsXP"]))
	{
		setmatchdata("players",self.clientid,"clanWarsXp",self.pers["summary"]["clanWarsXP"]);
	}

	if(isdefined(level.ishorde) && level.ishorde)
	{
		[[ level.hordeupdatetimestats ]](self);
	}
}

//Function Number: 36
callback_playerdisconnect(param_00)
{
	if(!isdefined(self.connected))
	{
		return;
	}

	setmatchdata("players",self.clientid,"disconnectTimeUTC",getsystemtime());
	setmatchdata("players",self.clientid,"disconnectReason",param_00);
	if(maps\mp\_utility::rankingenabled())
	{
		maps\mp\_matchdata::logfinalstats();
	}

	if(isdefined(self.pers["confirmed"]))
	{
		maps\mp\_matchdata::logkillsconfirmed();
	}

	if(isdefined(self.pers["denied"]))
	{
		maps\mp\_matchdata::logkillsdenied();
	}

	logplayerstats();
	if(maps\mp\_utility::isroundbased())
	{
		var_01 = game["roundsPlayed"] + 1;
		setmatchdata("players",self.clientid,"playerQuitRoundNumber",var_01);
		if(isdefined(self.team) && self.team == "allies" || self.team == "axis")
		{
			if(self.team == "allies")
			{
				setmatchdata("players",self.clientid,"playerQuitTeamScore",game["roundsWon"]["allies"]);
				setmatchdata("players",self.clientid,"playerQuitOpposingTeamScore",game["roundsWon"]["axis"]);
			}
			else
			{
				setmatchdata("players",self.clientid,"playerQuitTeamScore",game["roundsWon"]["axis"]);
				setmatchdata("players",self.clientid,"playerQuitOpposingTeamScore",game["roundsWon"]["allies"]);
			}
		}
	}
	else if(isdefined(self.team) && self.team == "allies" || self.team == "axis" && level.teambased)
	{
		if(self.team == "allies")
		{
			setmatchdata("players",self.clientid,"playerQuitTeamScore",game["teamScores"]["allies"]);
			setmatchdata("players",self.clientid,"playerQuitOpposingTeamScore",game["teamScores"]["axis"]);
		}
		else
		{
			setmatchdata("players",self.clientid,"playerQuitTeamScore",game["teamScores"]["axis"]);
			setmatchdata("players",self.clientid,"playerQuitOpposingTeamScore",game["teamScores"]["allies"]);
		}
	}

	removeplayerondisconnect();
	maps\mp\gametypes\_spawnlogic::removefromparticipantsarray();
	maps\mp\gametypes\_spawnlogic::removefromcharactersarray();
	var_02 = self getentitynumber();
	if(!level.teambased)
	{
		game["roundsWon"][self.guid] = undefined;
	}

	if(!level.gameended)
	{
		maps\mp\_utility::logxpgains();
	}

	if(level.splitscreen)
	{
		var_03 = level.players;
		if(var_03.size <= 1)
		{
			level thread maps\mp\gametypes\_gamelogic::forceend();
		}
	}

	if(isdefined(self.score) && isdefined(self.pers["team"]))
	{
		var_04 = self.score;
		if(maps\mp\_utility::getminutespassed())
		{
			var_04 = self.score / maps\mp\_utility::getminutespassed();
		}

		setplayerteamrank(self,self.clientid,int(var_04));
	}

	reconevent("script_mp_playerquit: player_name %s, player %d, gameTime %d",self.name,self.clientid,gettime());
	var_05 = self getentitynumber();
	var_06 = self.guid;
	logprint("Q;" + var_06 + ";" + var_05 + ";" + self.name + "\n");
	thread maps\mp\_events::disconnected();
	if(level.gameended)
	{
		maps\mp\gametypes\_gamescore::removedisconnectedplayerfromplacement();
	}

	if(isdefined(self.team))
	{
		removefromteamcount();
	}

	if(self.sessionstate == "playing" && !isdefined(self.fauxdead) && self.fauxdead)
	{
		removefromalivecount(1);
		return;
	}

	if(self.sessionstate == "spectator" || self.sessionstate == "dead")
	{
		level thread maps\mp\gametypes\_gamelogic::updategameevents();
	}
}

//Function Number: 37
removeplayerondisconnect()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		if(level.players[var_01] == self)
		{
			var_00 = 1;
			while(var_01 < level.players.size - 1)
			{
				level.players[var_01] = level.players[var_01 + 1];
				var_01++;
			}

			level.players[var_01] = undefined;
			break;
		}
	}
}

//Function Number: 38
initclientdvarssplitscreenspecific()
{
	if(level.splitscreen || self issplitscreenplayer())
	{
		self setclientdvars("cg_hudGrenadeIconHeight","37.5","cg_hudGrenadeIconWidth","37.5","cg_hudGrenadeIconOffset","75","cg_hudGrenadePointerHeight","18","cg_hudGrenadePointerWidth","37.5","cg_hudGrenadePointerPivot","18 40.5","cg_fovscale","0.75");
		return;
	}

	self setclientdvars("cg_hudGrenadeIconHeight","75","cg_hudGrenadeIconWidth","75","cg_hudGrenadeIconOffset","50","cg_hudGrenadePointerHeight","36","cg_hudGrenadePointerWidth","75","cg_hudGrenadePointerPivot","36 81","cg_fovscale","1");
}

//Function Number: 39
initclientdvars()
{
	setdvar("cg_drawTalk",1);
	setdvar("cg_drawCrosshair",1);
	setdvar("cg_drawCrosshairNames",1);
	setdvar("cg_hudGrenadeIconMaxRangeFrag",250);
	if(level.hardcoremode)
	{
		setdvar("cg_drawTalk",3);
		setdvar("cg_drawCrosshair",0);
		setdvar("cg_drawCrosshairNames",1);
		setdvar("cg_hudGrenadeIconMaxRangeFrag",0);
	}

	if(isdefined(level.alwaysdrawfriendlynames) && level.alwaysdrawfriendlynames)
	{
		setdvar("cg_drawFriendlyNamesAlways",1);
	}
	else
	{
		setdvar("cg_drawFriendlyNamesAlways",0);
	}

	initclientdvarssplitscreenspecific();
	if(maps\mp\_utility::getgametypenumlives())
	{
		self setclientdvars("cg_deadChatWithDead",1,"cg_deadChatWithTeam",0,"cg_deadHearTeamLiving",0,"cg_deadHearAllLiving",0);
	}
	else
	{
		self setclientdvars("cg_deadChatWithDead",0,"cg_deadChatWithTeam",1,"cg_deadHearTeamLiving",1,"cg_deadHearAllLiving",0);
	}

	if(level.teambased)
	{
		self setclientdvars("cg_everyonehearseveryone",0);
	}

	if(getdvarint("scr_hitloc_debug"))
	{
		for(var_00 = 0;var_00 < 6;var_00++)
		{
			self setclientdvar("ui_hitloc_" + var_00,"");
		}

		self.hitlocinited = 1;
	}
}

//Function Number: 40
getlowestavailableclientid()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < 30;var_01++)
	{
		foreach(var_03 in level.players)
		{
			if(!isdefined(var_03))
			{
				continue;
			}

			if(var_03.clientid == var_01)
			{
				var_00 = 1;
				break;
			}

			var_00 = 0;
		}

		if(!var_00)
		{
			return var_01;
		}
	}
}

//Function Number: 41
setupsavedactionslots()
{
	self.saved_actionslotdata = [];
	for(var_00 = 1;var_00 <= 4;var_00++)
	{
		self.saved_actionslotdata[var_00] = spawnstruct();
		self.saved_actionslotdata[var_00].type = "";
		self.saved_actionslotdata[var_00].item = undefined;
	}

	if(!level.console)
	{
		for(var_00 = 5;var_00 <= 8;var_00++)
		{
			self.saved_actionslotdata[var_00] = spawnstruct();
			self.saved_actionslotdata[var_00].type = "";
			self.saved_actionslotdata[var_00].item = undefined;
		}
	}
}

//Function Number: 42
logplayerconsoleidandonwifiinmatchdata()
{
	var_00 = getcodanywherecurrentplatform();
	var_01 = self getcommonplayerdata("consoleIDChunkLow",var_00);
	var_02 = self getcommonplayerdata("consoleIDChunkHigh",var_00);
	if(isdefined(var_01) && var_01 != 0)
	{
		setmatchdata("players",self.clientid,"consoleIDChunkLow",var_01);
	}

	if(isdefined(var_02) && var_02 != 0)
	{
		setmatchdata("players",self.clientid,"consoleIDChunkHigh",var_02);
	}

	var_03 = 3;
	var_04 = -1;
	if(isdefined(var_02) && var_02 != 0 && isdefined(var_01) && var_01 != 0)
	{
		for(var_05 = 0;var_05 < var_03;var_05++)
		{
			var_06 = self getcommonplayerdata("deviceConnectionHistory",var_05,"device_id_high");
			var_07 = self getcommonplayerdata("deviceConnectionHistory",var_05,"device_id_low");
			if(var_06 == var_02 && var_07 == var_01)
			{
				var_04 = var_05;
				break;
			}
		}
	}

	if(var_04 == -1)
	{
		var_08 = 0;
		for(var_05 = 0;var_05 < var_03;var_05++)
		{
			var_09 = self getcommonplayerdata("deviceConnectionHistory",var_05,"deviceUseFrequency");
			if(var_09 > var_08)
			{
				var_08 = var_09;
				var_04 = var_05;
			}
		}
	}

	if(var_04 == -1)
	{
		var_04 = 0;
	}

	var_0A = self getcommonplayerdata("deviceConnectionHistory",var_04,"onWifi");
	if(var_0A)
	{
		setmatchdata("players",self.clientid,"playingOnWifi",1);
	}
}

//Function Number: 43
truncateplayername(param_00)
{
	if(level.xb3 && param_00.size > 18)
	{
		var_01 = common_scripts\utility::string_find(param_00,"]");
		if(var_01 >= 0 && common_scripts\utility::string_starts_with(param_00,"["))
		{
			param_00 = getsubstr(param_00,var_01 + 1);
		}
	}

	return param_00;
}

//Function Number: 44
callback_playerconnect()
{
	var_00 = getrandomspectatorspawnpoint();
	self setspectatedefaults(var_00.origin,var_00.angles);
	thread notifyconnecting();
	self waittill("begin");
	self.connecttime = gettime();
	level notify("connected",self);
	self.connected = 1;
	if(self ishost())
	{
		level.player = self;
	}

	if(!level.splitscreen && !isdefined(self.pers["score"]))
	{
		iprintln(&"MP_CONNECTED",self);
	}

	self.usingonlinedataoffline = self isusingonlinedataoffline();
	initclientdvars();
	initplayerstats();
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		level waittill("eternity");
	}

	self.guid = self getguid();
	self.xuid = self getxuid();
	self.totallifetime = 0;
	var_01 = 0;
	if(!isdefined(self.pers["clientid"]))
	{
		if(game["clientid"] >= 30)
		{
			self.pers["clientid"] = getlowestavailableclientid();
		}
		else
		{
			self.pers["clientid"] = game["clientid"];
		}

		if(game["clientid"] < 30)
		{
			game["clientid"]++;
		}

		var_01 = 1;
	}

	if(var_01 && !maps\mp\_utility::invirtuallobby())
	{
		maps\mp\killstreaks\_killstreaks::resetadrenaline(1);
	}

	if(maps\mp\_utility::practiceroundgame() && var_01)
	{
		maps\mp\gametypes\_class::assignpracticeroundclasses();
	}

	if(var_01)
	{
		streamprimaryweapons();
	}

	self.clientid = self.pers["clientid"];
	self.pers["teamKillPunish"] = 0;
	self.pers["suicideSpawnDelay"] = 0;
	if(var_01)
	{
		reconevent("script_mp_playerjoin: player_name %s, player %d, gameTime %d",self.name,self.clientid,gettime());
	}

	logprint("J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\n");
	if(game["clientid"] <= 30 && game["clientid"] != getmatchdata("playerCount"))
	{
		var_02 = 0;
		var_03 = 0;
		if(!isai(self) && maps\mp\_utility::matchmakinggame())
		{
			self registerparty(self.clientid);
		}

		setmatchdata("playerCount",game["clientid"]);
		setmatchdata("players",self.clientid,"playerID","xuid",self getxuid());
		setmatchdata("players",self.clientid,"playerID","ucdIDHigh",self getucdidhigh());
		setmatchdata("players",self.clientid,"playerID","ucdIDLow",self getucdidlow());
		setmatchdata("players",self.clientid,"playerID","clanIDHigh",self getclanidhigh());
		setmatchdata("players",self.clientid,"playerID","clanIDLow",self getclanidlow());
		setmatchdata("players",self.clientid,"gamertag",truncateplayername(self.name));
		setmatchdata("players",self.clientid,"isBot",isai(self));
		var_04 = self getentitynumber();
		setmatchdata("players",self.clientid,"codeClientNum",maps\mp\_utility::clamptobyte(var_04));
		var_05 = getcodanywherecurrentplatform();
		var_03 = self getcommonplayerdata("connectionIDChunkLow",var_05);
		var_02 = self getcommonplayerdata("connectionIDChunkHigh",var_05);
		setmatchdata("players",self.clientid,"connectionIDChunkLow",var_03);
		setmatchdata("players",self.clientid,"connectionIDChunkHigh",var_02);
		setmatchclientip(self,self.clientid);
		setmatchdata("players",self.clientid,"joinType",self getjointype());
		setmatchdata("players",self.clientid,"connectTimeUTC",getsystemtime());
		setmatchdata("players",self.clientid,"isSplitscreen",issplitscreen());
		logplayerconsoleidandonwifiinmatchdata();
		if(self ishost())
		{
			setmatchdata("players",self.clientid,"wasAHost",1);
		}

		if(maps\mp\_utility::rankingenabled())
		{
			maps\mp\_matchdata::loginitialstats();
		}

		if(istestclient(self) || isai(self))
		{
			var_06 = 1;
		}
		else
		{
			var_06 = 0;
		}

		if(maps\mp\_utility::matchmakinggame() && maps\mp\_utility::allowteamchoice() && !var_06)
		{
			setmatchdata("players",self.clientid,"team",self.sessionteam);
		}

		if(maps\mp\_utility::isaiteamparticipant(self))
		{
			if(!isdefined(level.matchdata))
			{
				level.matchdata = [];
			}

			if(!isdefined(level.matchdata["botJoinCount"]))
			{
				level.matchdata["botJoinCount"] = 1;
			}
			else
			{
				level.matchdata["botJoinCount"]++;
			}
		}
	}

	if(!level.teambased)
	{
		game["roundsWon"][self.guid] = 0;
	}

	self.leaderdialogqueue = [];
	self.leaderdialoglocqueue = [];
	self.leaderdialogactive = "";
	self.leaderdialoggroups = [];
	self.leaderdialoggroup = "";
	if(!isdefined(self.pers["cur_kill_streak"]))
	{
		self.pers["cur_kill_streak"] = 0;
		self.killstreakcount = 0;
	}

	if(!isdefined(self.pers["cur_death_streak"]))
	{
		self.pers["cur_death_streak"] = 0;
	}

	if(!isdefined(self.pers["cur_kill_streak_for_nuke"]))
	{
		self.pers["cur_kill_streak_for_nuke"] = 0;
	}

	if(maps\mp\_utility::rankingenabled())
	{
		self.kill_streak = maps\mp\gametypes\_persistence::statget("killStreak");
	}

	self.lastgrenadesuicidetime = -1;
	self.teamkillsthisround = 0;
	self.hasspawned = 0;
	self.waitingtospawn = 0;
	self.wantsafespawn = 0;
	self.wasaliveatmatchstart = 0;
	self.movespeedscaler = level.baseplayermovescale;
	self.killstreakscaler = 1;
	self.objectivescaler = 1;
	self.issniper = 0;
	setupsavedactionslots();
	level thread monitorplayersegments(self);
	thread maps\mp\_flashgrenades::monitorflash();
	resetuidvarsonconnect();
	maps\mp\_snd_common_mp::snd_mp_player_join();
	waittillframeend;
	level.players[level.players.size] = self;
	maps\mp\gametypes\_spawnlogic::addtoparticipantsarray();
	maps\mp\gametypes\_spawnlogic::addtocharactersarray();
	if(level.teambased)
	{
		self updatescores();
	}

	if(game["state"] == "postgame")
	{
		self.connectedpostgame = 1;
		spawnintermission();
		return;
	}

	if(isai(self) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["think"]))
	{
		self thread [[ level.bot_funcs["think"] ]]();
	}

	level endon("game_ended");
	if(isdefined(level.hostmigrationtimer))
	{
		if(!isdefined(self.hostmigrationcontrolsfrozen) || self.hostmigrationcontrolsfrozen == 0)
		{
			self.hostmigrationcontrolsfrozen = 0;
			thread maps\mp\gametypes\_hostmigration::hostmigrationtimerthink();
		}
	}

	if(isdefined(level.onplayerconnectaudioinit))
	{
		[[ level.onplayerconnectaudioinit ]]();
	}

	if(!isdefined(self.pers["team"]))
	{
		if(maps\mp\_utility::matchmakinggame() && self.sessionteam != "none")
		{
			thread spawnspectator();
			if(isdefined(level.waitingforplayers) && level.waitingforplayers)
			{
				maps\mp\_utility::freezecontrolswrapper(1);
			}

			thread maps\mp\gametypes\_menus::setteam(self.sessionteam);
			if(maps\mp\_utility::allowclasschoice())
			{
				thread setuioptionsmenu(2);
			}

			thread kickifdontspawn();
			return;
		}

		if(!maps\mp\_utility::matchmakinggame() && maps\mp\_utility::allowteamchoice())
		{
			maps\mp\gametypes\_menus::menuspectator();
			thread setuioptionsmenu(1);
			return;
		}

		thread spawnspectator();
		self [[ level.autoassign ]]();
		if(maps\mp\_utility::allowclasschoice())
		{
			thread setuioptionsmenu(2);
		}

		if(maps\mp\_utility::matchmakinggame())
		{
			thread kickifdontspawn();
		}

		return;
	}

	maps\mp\gametypes\_menus::addtoteam(self.pers["team"],1);
	if(maps\mp\_utility::isvalidclass(self.pers["class"]))
	{
		thread spawnclient();
		return;
	}

	thread spawnspectator();
	if(self.pers["team"] == "spectator")
	{
		if(maps\mp\_utility::allowteamchoice())
		{
			maps\mp\gametypes\_menus::beginteamchoice();
			return;
		}

		self [[ level.autoassign ]]();
		return;
	}

	maps\mp\gametypes\_menus::beginclasschoice();
}

//Function Number: 45
callback_playermigrated()
{
	if(isdefined(self.connected) && self.connected)
	{
		maps\mp\_utility::updateobjectivetext();
		maps\mp\_utility::updatemainmenu();
		if(level.teambased)
		{
			self updatescores();
		}
	}

	if(self ishost())
	{
		initclientdvarssplitscreenspecific();
		setmatchdata("players",self.clientid,"wasAHost",1);
	}

	var_00 = 0;
	foreach(var_02 in level.players)
	{
		if(!isbot(var_02) && !istestclient(var_02))
		{
			var_00++;
		}
	}

	if(!isbot(self) && !istestclient(self))
	{
		level.hostmigrationreturnedplayercount++;
		if(level.hostmigrationreturnedplayercount >= var_00 * 2 / 3)
		{
			level notify("hostmigration_enoughplayers");
		}

		self notify("player_migrated");
	}
}

//Function Number: 46
forcespawn()
{
	self endon("death");
	self endon("disconnect");
	self endon("spawned");
	wait(60);
	if(self.hasspawned)
	{
		return;
	}

	if(self.pers["team"] == "spectator")
	{
		return;
	}

	if(!maps\mp\_utility::isvalidclass(self.pers["class"]))
	{
		self.pers["class"] = "CLASS_CUSTOM1";
		self.class = self.pers["class"];
		maps\mp\gametypes\_class::clearcopycatloadout();
	}

	thread spawnclient();
}

//Function Number: 47
kickifdontspawn()
{
	self endon("death");
	self endon("disconnect");
	self endon("spawned");
	self endon("attempted_spawn");
	var_00 = getdvarfloat("scr_kick_time",90);
	var_01 = getdvarfloat("scr_kick_mintime",45);
	var_02 = gettime();
	if(self ishost())
	{
		kickwait(120);
	}
	else
	{
		kickwait(var_00);
	}

	var_03 = gettime() - var_02 / 1000;
	if(var_03 < var_00 - 0.1 && var_03 < var_01)
	{
		return;
	}

	if(self.hasspawned)
	{
		return;
	}

	if(self.pers["team"] == "spectator")
	{
		return;
	}

	kick(self getentitynumber(),"EXE_PLAYERKICKED_INACTIVE");
	level thread maps\mp\gametypes\_gamelogic::updategameevents();
}

//Function Number: 48
kickwait(param_00)
{
	level endon("game_ended");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_00);
}

//Function Number: 49
initplayerstats()
{
	maps\mp\gametypes\_persistence::initbufferedstats();
	self.pers["lives"] = maps\mp\_utility::getgametypenumlives();
	if(!isdefined(self.pers["deaths"]))
	{
		maps\mp\_utility::initpersstat("deaths");
		maps\mp\gametypes\_persistence::statsetchild("round","deaths",0);
	}

	self.deaths = maps\mp\_utility::getpersstat("deaths");
	if(!isdefined(self.pers["score"]))
	{
		maps\mp\_utility::initpersstat("score");
		maps\mp\gametypes\_persistence::statsetchild("round","score",0);
		maps\mp\gametypes\_persistence::statsetchildbuffered("round","timePlayed",0);
	}

	self.score = maps\mp\_utility::getpersstat("score");
	self.timeplayed["total"] = maps\mp\gametypes\_persistence::statgetchildbuffered("round","timePlayed");
	if(!isdefined(self.pers["suicides"]))
	{
		maps\mp\_utility::initpersstat("suicides");
	}

	self.suicides = maps\mp\_utility::getpersstat("suicides");
	if(!isdefined(self.pers["kills"]))
	{
		maps\mp\_utility::initpersstat("kills");
		maps\mp\gametypes\_persistence::statsetchild("round","kills",0);
	}

	self.kills = maps\mp\_utility::getpersstat("kills");
	if(!isdefined(self.pers["headshots"]))
	{
		maps\mp\_utility::initpersstat("headshots");
		maps\mp\gametypes\_persistence::statsetchild("round","headshots",0);
	}

	self.headshots = maps\mp\_utility::getpersstat("headshots");
	if(!isdefined(self.pers["assists"]))
	{
		maps\mp\_utility::initpersstat("assists");
		maps\mp\gametypes\_persistence::statsetchild("round","assists",0);
	}

	self.assists = maps\mp\_utility::getpersstat("assists");
	if(!isdefined(self.pers["captures"]))
	{
		maps\mp\_utility::initpersstat("captures");
		maps\mp\gametypes\_persistence::statsetchild("round","captures",0);
	}

	if(!isdefined(self.pers["returns"]))
	{
		maps\mp\_utility::initpersstat("returns");
		maps\mp\gametypes\_persistence::statsetchild("round","returns",0);
	}

	self.returns = maps\mp\_utility::getpersstat("returns");
	if(!isdefined(self.pers["defends"]))
	{
		maps\mp\_utility::initpersstat("defends");
		maps\mp\gametypes\_persistence::statsetchild("round","defends",0);
	}

	if(!isdefined(self.pers["plants"]))
	{
		maps\mp\_utility::initpersstat("plants");
		maps\mp\gametypes\_persistence::statsetchild("round","plants",0);
	}

	if(!isdefined(self.pers["defuses"]))
	{
		maps\mp\_utility::initpersstat("defuses");
		maps\mp\gametypes\_persistence::statsetchild("round","defuses",0);
	}

	if(!isdefined(self.pers["destructions"]))
	{
		maps\mp\_utility::initpersstat("destructions");
		maps\mp\gametypes\_persistence::statsetchild("round","destructions",0);
	}

	if(!isdefined(self.pers["confirmed"]))
	{
		maps\mp\_utility::initpersstat("confirmed");
		maps\mp\gametypes\_persistence::statsetchild("round","confirmed",0);
	}

	if(!isdefined(self.pers["denied"]))
	{
		maps\mp\_utility::initpersstat("denied");
		maps\mp\gametypes\_persistence::statsetchild("round","denied",0);
	}

	if(!isdefined(self.pers["rescues"]))
	{
		maps\mp\_utility::initpersstat("rescues");
		maps\mp\gametypes\_persistence::statsetchild("round","rescues",0);
	}

	if(!isdefined(self.pers["teamkills"]))
	{
		maps\mp\_utility::initpersstat("teamkills");
	}

	if(!isdefined(self.pers["totalTeamKills"]))
	{
		maps\mp\_utility::initpersstat("totalTeamKills");
	}

	if(!isdefined(self.pers["extrascore0"]))
	{
		maps\mp\_utility::initpersstat("extrascore0");
	}

	if(!isdefined(self.pers["extrascore1"]))
	{
		maps\mp\_utility::initpersstat("extrascore1");
	}

	if(!isdefined(self.pers["teamKillPunish"]))
	{
		self.pers["teamKillPunish"] = 0;
	}

	if(!isdefined(self.pers["suicideSpawnDelay"]))
	{
		self.pers["suicideSpawnDelay"] = 0;
	}

	maps\mp\_utility::initpersstat("longestStreak");
	self.pers["lives"] = maps\mp\_utility::getgametypenumlives();
	maps\mp\gametypes\_persistence::statsetchild("round","killStreak",0);
	maps\mp\gametypes\_persistence::statsetchild("round","loss",0);
	maps\mp\gametypes\_persistence::statsetchild("round","win",0);
	maps\mp\gametypes\_persistence::statsetchild("round","scoreboardType","none");
	if(maps\mp\_utility::rankingenabled())
	{
		if(!isdefined(self.pers["previous_shots"]))
		{
			self.pers["previous_shots"] = self getrankedplayerdata("totalShots");
		}

		if(!isdefined(self.pers["previous_hits"]))
		{
			self.pers["previous_hits"] = self getrankedplayerdata("hits");
		}
	}

	if(!isdefined(self.pers["mpWeaponStats"]))
	{
		self.pers["mpWeaponStats"] = [];
	}

	if(!isdefined(self.pers["numberOfTimesCloakingUsed"]))
	{
		self.pers["numberOfTimesCloakingUsed"] = 0;
	}

	if(!isdefined(self.pers["numberOfTimesHoveringUsed"]))
	{
		self.pers["numberOfTimesHoveringUsed"] = 0;
	}

	if(!isdefined(self.pers["numberOfTimesShieldUsed"]))
	{
		self.pers["numberOfTimesShieldUsed"] = 0;
	}

	if(!isdefined(self.pers["bulletsBlockedByShield"]))
	{
		self.pers["bulletsBlockedByShield"] = 0;
	}

	if(!isdefined(self.pers["totalKillcamsSkipped"]))
	{
		self.pers["totalKillcamsSkipped"] = 0;
	}

	if(!isdefined(self.pers["weaponPickupsCount"]))
	{
		self.pers["weaponPickupsCount"] = 0;
	}

	if(!isdefined(self.pers["pingAccumulation"]))
	{
		self.pers["pingAccumulation"] = 0;
	}

	if(!isdefined(self.pers["pingSampleCount"]))
	{
		self.pers["pingSampleCount"] = 0;
	}

	if(!isdefined(self.pers["minPing"]))
	{
		self.pers["minPing"] = 32767;
	}

	if(!isdefined(self.pers["maxPing"]))
	{
		self.pers["maxPing"] = 0;
	}

	if(!isdefined(self.pers["validationInfractions"]))
	{
		self.pers["validationInfractions"] = 0;
	}
}

//Function Number: 50
addtoteamcount()
{
	level.teamcount[self.team]++;
	if(!isdefined(level.teamlist))
	{
		level.teamlist = [];
	}

	if(!isdefined(level.teamlist[self.team]))
	{
		level.teamlist[self.team] = [];
	}

	level.teamlist[self.team][level.teamlist[self.team].size] = self;
	maps\mp\gametypes\_gamelogic::updategameevents();
}

//Function Number: 51
removefromteamcount()
{
	level.teamcount[self.team]--;
	if(isdefined(level.teamlist) && isdefined(level.teamlist[self.team]))
	{
		var_00 = [];
		foreach(var_02 in level.teamlist[self.team])
		{
			if(!isdefined(var_02) || var_02 == self)
			{
				continue;
			}

			var_00[var_00.size] = var_02;
		}

		level.teamlist[self.team] = var_00;
	}
}

//Function Number: 52
addtoalivecount()
{
	var_00 = self.team;
	if(!isdefined(self.alreadyaddedtoalivecount) && self.alreadyaddedtoalivecount)
	{
		level.hasspawned[var_00]++;
		incrementalivecount(var_00);
	}

	self.alreadyaddedtoalivecount = undefined;
	if(level.alivecount["allies"] + level.alivecount["axis"] > level.maxplayercount)
	{
		level.maxplayercount = level.alivecount["allies"] + level.alivecount["axis"];
	}
}

//Function Number: 53
incrementalivecount(param_00)
{
	level.alivecount[param_00]++;
}

//Function Number: 54
removefromalivecount(param_00)
{
	var_01 = self.team;
	if(isdefined(self.switching_teams) && self.switching_teams && isdefined(self.joining_team) && self.joining_team == self.team)
	{
		var_01 = self.leaving_team;
	}

	if(isdefined(self.switching_teams) || isdefined(param_00))
	{
		removeallfromlivescount();
		if(isdefined(self.switching_teams))
		{
			self.pers["lives"] = 0;
		}
	}

	decrementalivecount(var_01);
	return maps\mp\gametypes\_gamelogic::updategameevents();
}

//Function Number: 55
decrementalivecount(param_00)
{
	level.alivecount[param_00]--;
}

//Function Number: 56
addtolivescount()
{
	level.livescount[self.team] = level.livescount[self.team] + self.pers["lives"];
}

//Function Number: 57
removefromlivescount()
{
	level.livescount[self.team]--;
	level.livescount[self.team] = int(max(0,level.livescount[self.team]));
}

//Function Number: 58
removeallfromlivescount()
{
	level.livescount[self.team] = level.livescount[self.team] - self.pers["lives"];
	level.livescount[self.team] = int(max(0,level.livescount[self.team]));
}

//Function Number: 59
resetuidvarsonspawn()
{
	self setclientomnvar("ui_carrying_bomb",0);
	self setclientomnvar("ui_capture_icon",0);
	self setclientomnvar("ui_light_armor",0);
	self setclientomnvar("ui_killcam_end_milliseconds",0);
	self setclientomnvar("ui_uplink_can_pass",0);
	self setclientomnvar("ui_light_armor_percent",0);
	self setclientomnvar("ui_killcam_time_until_spawn",0);
}

//Function Number: 60
resetuidvarsonconnect()
{
	self setclientomnvar("ui_carrying_bomb",0);
	self setclientomnvar("ui_capture_icon",0);
	self setclientomnvar("ui_light_armor",0);
	self setclientomnvar("ui_killcam_end_milliseconds",0);
}

//Function Number: 61
resetuidvarsonspectate()
{
	self setclientomnvar("ui_carrying_bomb",0);
	self setclientomnvar("ui_capture_icon",0);
	self setclientomnvar("ui_light_armor",0);
	self setclientomnvar("ui_killcam_end_milliseconds",0);
}

//Function Number: 62
resetuidvarsondeath()
{
}

//Function Number: 63
monitorplayersegments(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	createplayersegmentstats(param_00);
	for(;;)
	{
		param_00 waittill("spawned_player");
		recordsegemtdata(param_00);
	}
}

//Function Number: 64
createplayersegmentstats(param_00)
{
	if(!isdefined(param_00.pers["segments"]))
	{
		param_00.pers["segments"] = [];
	}

	param_00.segments = param_00.pers["segments"];
	if(!param_00.segments.size)
	{
		param_00.segments["distanceTotal"] = 0;
		param_00.segments["movingTotal"] = 0;
		param_00.segments["movementUpdateCount"] = 0;
		param_00.segments["killDistanceTotal"] = 0;
		param_00.segments["killDistanceCount"] = 0;
	}
}

//Function Number: 65
recordsegemtdata(param_00)
{
	param_00 endon("death");
	while(!maps\mp\_utility::gameflag("prematch_done"))
	{
		wait(0.5);
	}

	wait(4);
	param_00.savedposition = param_00.origin;
	param_00.positionptm = param_00.origin;
	for(;;)
	{
		wait(1);
		if(param_00 maps\mp\_utility::isusingremote())
		{
			param_00 waittill("stopped_using_remote");
			param_00.savedposition = param_00.origin;
			param_00.positionptm = param_00.origin;
			continue;
		}

		param_00.segments["movementUpdateCount"]++;
		param_00.segments["distanceTotal"] = param_00.segments["distanceTotal"] + distance2d(param_00.savedposition,param_00.origin);
		param_00.savedposition = param_00.origin;
		if(param_00.segments["movementUpdateCount"] % 5 == 0)
		{
			var_01 = distance2d(param_00.positionptm,param_00.origin);
			param_00.positionptm = param_00.origin;
			if(var_01 > 16)
			{
				param_00.segments["movingTotal"]++;
			}
		}
	}
}

//Function Number: 66
writesegmentdata(param_00)
{
	if(level.players.size < 2)
	{
		return;
	}

	param_00 endon("disconnect");
	if(param_00.segments["movementUpdateCount"] < 30 || param_00.segments["killDistanceCount"] < 1)
	{
		return;
	}

	var_01 = param_00.segments["movingTotal"] / int(param_00.segments["movementUpdateCount"] / 5) * 100;
	var_02 = param_00.segments["distanceTotal"] / param_00.segments["movementUpdateCount"];
	var_03 = param_00.segments["killDistanceTotal"] / param_00.segments["killDistanceCount"];
	var_01 = min(var_01,float(tablelookup("mp/playerSegments.csv",0,"MAX",3)));
	var_02 = min(var_02,float(tablelookup("mp/playerSegments.csv",0,"MAX",2)));
	var_03 = min(var_03,float(tablelookup("mp/playerSegments.csv",0,"MAX",4)));
	var_04 = calculatematchplaystyle(var_01,var_02,var_03);
	setmatchdata("players",param_00.clientid,"averageSpeedDuringMatch",var_02);
	setmatchdata("players",param_00.clientid,"percentageOfTimeMoving",var_01);
	setmatchdata("players",param_00.clientid,"averageKillDistance",var_03);
	setmatchdata("players",param_00.clientid,"totalDistanceTravelled",param_00.segments["distanceTotal"]);
	setmatchdata("players",param_00.clientid,"playstyle",maps\mp\_utility::clamptobyte(var_04));
	if(isai(param_00))
	{
		return;
	}

	reconevent("script_PlayerSegments: percentTimeMoving %f, averageSpeed %f, averageKillDistance %f, playStyle %d, name %s",var_01,var_02,var_03,var_04,param_00.name);
	if(!param_00 maps\mp\_utility::rankingenabled())
	{
		return;
	}

	var_05 = 50;
	var_06 = param_00 getrankedplayerdata("combatRecord","numPlayStyleTrends");
	var_06++;
	if(var_06 > var_05)
	{
		var_06 = var_05;
		if(var_05 > 1)
		{
			for(var_07 = 0;var_07 < var_05 - 1;var_07++)
			{
				var_08 = param_00 getrankedplayerdata("combatRecord","playStyleTimeStamp",var_07 + 1);
				var_09 = param_00 getrankedplayerdata("combatRecord","playStyle",var_07 + 1);
				param_00 setrankedplayerdata("combatRecord","playStyleTimeStamp",var_07,var_08);
				param_00 setrankedplayerdata("combatRecord","playStyle",var_07,var_09);
			}
		}
	}

	var_08 = maps\mp\_utility::gettimeutc_for_stat_recording();
	param_00 setrankedplayerdata("combatRecord","playStyleTimeStamp",var_06 - 1,var_08);
	param_00 setrankedplayerdata("combatRecord","playStyle",var_06 - 1,var_04);
	param_00 setrankedplayerdata("combatRecord","numPlayStyleTrends",var_06);
}

//Function Number: 67
calculatematchplaystyle(param_00,param_01,param_02)
{
	param_00 = normalizeplayersegment(param_00,float(tablelookup("mp/playerSegments.csv",0,"Mean",3)),float(tablelookup("mp/playerSegments.csv",0,"SD",3)));
	param_01 = normalizeplayersegment(param_01,float(tablelookup("mp/playerSegments.csv",0,"Mean",2)),float(tablelookup("mp/playerSegments.csv",0,"SD",2)));
	param_02 = normalizeplayersegment(param_02,float(tablelookup("mp/playerSegments.csv",0,"Mean",4)),float(tablelookup("mp/playerSegments.csv",0,"SD",4)));
	var_03 = (param_00,param_01,param_02);
	var_04 = ["Camper","Mobile","Run","Sniper","TacCQ"];
	var_05 = "Camper";
	var_06 = 1000;
	foreach(var_08 in var_04)
	{
		var_09 = getcentroiddistance(var_03,var_08);
		if(var_09 < var_06)
		{
			var_05 = var_08;
			var_06 = var_09;
		}
	}

	return int(tablelookup("mp/playerSegments.csv",0,var_05,1));
}

//Function Number: 68
normalizeplayersegment(param_00,param_01,param_02)
{
	return param_00 - param_01 / param_02;
}

//Function Number: 69
getcentroiddistance(param_00,param_01)
{
	var_02 = (float(tablelookup("mp/playerSegments.csv",0,param_01,3)),float(tablelookup("mp/playerSegments.csv",0,param_01,2)),float(tablelookup("mp/playerSegments.csv",0,param_01,4)));
	return distance(param_00,var_02);
}

//Function Number: 70
clearpracticeroundlockoutdata(param_00,param_01)
{
	param_00 setcommonplayerdata("practiceRoundLockoutTime",0);
	for(var_02 = 0;var_02 < param_01;var_02++)
	{
		param_00 setcommonplayerdata("practiceRoundLockoutMatchTimes",var_02,0);
	}
}

//Function Number: 71
checkpracticeroundlockout(param_00)
{
	if(isbot(param_00) || isagent(param_00))
	{
		return;
	}

	var_01 = 10;
	var_02 = 3;
	var_03 = 5;
	var_04 = int(86400);
	var_05 = int(86400);
	var_06 = param_00 getcommonplayerdata("practiceRoundLockoutTime");
	if(var_06 > 0)
	{
		clearpracticeroundlockoutdata(param_00,var_01);
	}

	var_07 = param_00 getcommonplayerdata("round","kills");
	var_08 = param_00 getcommonplayerdata("round","deaths");
	var_08 = max(var_08,1);
	var_09 = var_07 / var_08;
	if(var_09 < var_03)
	{
		clearpracticeroundlockoutdata(param_00,var_01);
		return;
	}

	var_0A = maps\mp\_utility::gettimeutc_for_stat_recording();
	var_0B = var_0A - var_04;
	var_0C = -1;
	var_0D = var_0A;
	var_0E = 1;
	for(var_0F = 0;var_0F < var_01;var_0F++)
	{
		var_10 = param_00 getcommonplayerdata("practiceRoundLockoutMatchTimes",var_0F);
		if(var_10 < var_0D)
		{
			var_0D = var_10;
			var_0C = var_0F;
		}

		if(var_10 >= var_0B)
		{
			var_0E++;
		}
	}

	param_00 setcommonplayerdata("practiceRoundLockoutMatchTimes",var_0C,var_0A);
	if(var_0E >= var_02)
	{
		var_11 = var_0A + var_05;
		param_00 setcommonplayerdata("practiceRoundLockoutTime",var_11);
	}
}