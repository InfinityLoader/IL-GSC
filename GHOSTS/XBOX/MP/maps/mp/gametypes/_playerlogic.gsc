/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_playerlogic.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 60
 * Decompile Time: 1107 ms
 * Timestamp: 10/27/2023 1:31:28 AM
*******************************************************************/

//Function Number: 1
func_813B(param_00)
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
	if(level.maxallowedteamkills < 0 || var_00 <= level.maxallowedteamkills)
	{
		return 0;
	}

	var_01 = var_00 - level.maxallowedteamkills;
	return maps\mp\gametypes\_tweakables::func_3C5B("team","teamkillspawndelay") * var_01;
}

//Function Number: 3
func_813A(param_00)
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

		if(param_00 && isdefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"])
		{
			var_01 = var_01 + teamkilldelay();
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

	var_04 = getdvarint("scr_" + level.gametype + "_waverespawndelay") > 0;
	if(var_04)
	{
		return func_813B(var_01);
	}

	return var_01;
}

//Function Number: 4
func_5128()
{
	if(maps\mp\_utility::func_3ABB() || isdefined(level.disablespawning))
	{
		if(isdefined(level.disablespawning) && level.disablespawning)
		{
			return 0;
		}

		if(isdefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"])
		{
			return 0;
		}

		if(self.pers["lives"] <= 0 && maps\mp\_utility::gamehasstarted())
		{
			return 0;
		}
		else if(maps\mp\_utility::gamehasstarted())
		{
			if(!level.ingraceperiod && !self.hasspawned && isdefined(level.allowlatecomers) && !level.allowlatecomers)
			{
				if(isdefined(self.siegelatecomer) && !self.siegelatecomer)
				{
					return 1;
				}

				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 5
func_7866()
{
	self endon("becameSpectator");
	if(isdefined(self.waitingtoselectclass) && self.waitingtoselectclass)
	{
		self waittill("okToSpawn");
	}

	if(isdefined(self.addtoteam))
	{
		lib_05D5::addtoteam(self.addtoteam);
		self.addtoteam = undefined;
	}

	if(!func_5128())
	{
		wait(0.05);
		var_00 = self.origin;
		var_01 = self.angles;
		self notify("attempted_spawn");
		var_02 = self.pers["teamKillPunish"];
		if(isdefined(var_02) && var_02)
		{
			self.pers["teamkills"] = max(self.pers["teamkills"] - 1,0);
			maps\mp\_utility::setlowermessage("friendly_fire",&"MP_FRIENDLY_FIRE_WILL_NOT");
			if(!self.hasspawned && self.pers["teamkills"] <= level.maxallowedteamkills)
			{
				self.pers["teamKillPunish"] = 0;
			}
		}
		else if(maps\mp\_utility::func_4950() && !maps\mp\_utility::islastround())
		{
			if(isdefined(self.tagavailable) && self.tagavailable)
			{
				maps\mp\_utility::setlowermessage("spawn_info",game["strings"]["spawn_tag_wait"]);
			}
			else if(level.gametype == "siege")
			{
				maps\mp\_utility::setlowermessage("spawn_info",game["strings"]["spawn_flag_wait"]);
			}
			else
			{
				maps\mp\_utility::setlowermessage("spawn_info",game["strings"]["spawn_next_round"]);
			}

			thread func_65B0(3);
		}

		if(self.sessionstate != "spectator")
		{
			var_00 = var_00 + (0,0,60);
		}

		thread spawnspectator(var_00,var_01);
	}

	if(self.waitingtospawn)
	{
	}

	self.waitingtospawn = 1;
	func_8AD0();
	if(isdefined(self))
	{
		self.waitingtospawn = 0;
	}
}

//Function Number: 6
func_8AD0()
{
	self endon("disconnect");
	self endon("end_respawn");
	level endon("game_ended");
	self notify("attempted_spawn");
	var_00 = 0;
	var_01 = self.pers["teamKillPunish"];
	if(isdefined(var_01) && var_01)
	{
		var_02 = teamkilldelay();
		if(var_02 > 0)
		{
			maps\mp\_utility::setlowermessage("friendly_fire",&"MP_FRIENDLY_FIRE_WILL_NOT",var_02,1,1);
			thread respawn_asspectator(self.origin + (0,0,60),self.angles);
			var_00 = 1;
			wait(var_02);
			maps\mp\_utility::func_1D47("friendly_fire");
			self.respawntimerstarttime = gettime();
		}

		self.pers["teamKillPunish"] = 0;
	}
	else if(!maps\mp\_utility::func_47BB() && teamkilldelay())
	{
		self.pers["teamkills"] = max(self.pers["teamkills"] - 1,0);
	}

	if(maps\mp\_utility::func_4995())
	{
		self.var_78A7 = 1;
		self.deathposition = self.origin;
		self waittill("stopped_using_remote");
	}

	if(!isdefined(self.wavespawnindex) && isdefined(level.waveplayerspawnindex[self.team]))
	{
		self.wavespawnindex = level.waveplayerspawnindex[self.team];
		level.waveplayerspawnindex[self.team]++;
	}

	var_03 = func_813A(0);
	thread func_611F(var_03);
	if(var_03 > 0)
	{
		maps\mp\_utility::setlowermessage("spawn_info",game["strings"]["waiting_to_spawn"],var_03,1,1);
		if(!var_00)
		{
			thread respawn_asspectator(self.origin + (0,0,60),self.angles);
		}

		var_00 = 1;
		maps\mp\_utility::waitfortimeornotify(var_03,"force_spawn");
		self notify("stop_wait_safe_spawn_button");
	}

	if(func_5591())
	{
		maps\mp\_utility::setlowermessage("spawn_info",game["strings"]["press_to_spawn"],undefined,undefined,undefined,undefined,undefined,undefined,1);
		if(!var_00)
		{
			thread respawn_asspectator(self.origin + (0,0,60),self.angles);
		}

		var_00 = 1;
		func_8B11();
	}

	self.waitingtospawn = 0;
	maps\mp\_utility::func_1D47("spawn_info");
	self.wavespawnindex = undefined;
	thread spawnplayer();
}

//Function Number: 7
func_5591()
{
	if(maps\mp\gametypes\_tweakables::func_3C5B("player","forcerespawn") != 0)
	{
		return 0;
	}

	if(!self.hasspawned)
	{
		return 0;
	}

	var_00 = getdvarint("scr_" + level.gametype + "_waverespawndelay") > 0;
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

//Function Number: 8
func_8B11()
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

//Function Number: 9
func_65B0(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	waittillframeend;
	self endon("end_respawn");
	wait(param_00);
	maps\mp\_utility::func_1D47("spawn_info");
}

//Function Number: 10
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
		maps\mp\gametypes\_gamelogic::func_350F();
	}
}

//Function Number: 11
func_3A77()
{
	var_00 = spawn("script_origin",self.origin);
	var_00 hide();
	var_00.angles = self.angles;
	return var_00;
}

//Function Number: 12
showspawnnotifies()
{
	if(isdefined(game["defcon"]))
	{
		thread maps\mp\gametypes\_hud_message::defconsplashnotify(game["defcon"],0);
	}

	if(!maps\mp\_utility::func_47BB() && maps\mp\_utility::func_494B())
	{
		thread maps\mp\gametypes\_hud_message::func_794C("rested");
	}
}

//Function Number: 13
func_611F(param_00)
{
	if(!0)
	{
	}

	self endon("disconnect");
	self endon("spawned");
	self endon("used_predicted_spawnpoint");
	self notify("predicting_about_to_spawn_player");
	self endon("predicting_about_to_spawn_player");
	if(param_00 <= 0)
	{
	}

	if(param_00 > 1)
	{
		wait(param_00 - 1);
	}

	func_611E();
	self predictstreampos(self.predictedspawnpoint.origin + (0,0,60),self.predictedspawnpoint.angles);
	self.predictedspawnpointtime = gettime();
	for(var_01 = 0;var_01 < 30;var_01++)
	{
		wait(0.4);
		var_02 = self.predictedspawnpoint;
		func_611E();
		if(self.predictedspawnpoint != var_02)
		{
			self predictstreampos(self.predictedspawnpoint.origin + (0,0,60),self.predictedspawnpoint.angles);
			self.predictedspawnpointtime = gettime();
		}
	}
}

//Function Number: 14
func_611E()
{
	if(func_813A(1) > 1)
	{
		self.predictedspawnpoint = getspectatepoint();
	}

	if(isdefined(self.setspawnpoint))
	{
		self.predictedspawnpoint = self.setspawnpoint;
	}

	var_00 = self [[ level.getspawnpoint ]]();
	self.predictedspawnpoint = var_00;
}

//Function Number: 15
checkpredictedspawnpointcorrectness(param_00)
{
	self notify("used_predicted_spawnpoint");
	self.predictedspawnpoint = undefined;
}

//Function Number: 16
func_5B79(param_00,param_01)
{
	return param_00 + " (" + castint(param_00 / param_01 * 100) + "%)";
}

//Function Number: 17
func_61AE()
{
}

//Function Number: 18
func_3BEC(param_00)
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

//Function Number: 19
func_8145()
{
	if(!isdefined(self.setspawnpoint))
	{
		return 0;
	}

	var_00 = getentarray("care_package","targetname");
	foreach(var_02 in var_00)
	{
		if(distance(var_02.origin,self.setspawnpoint.playerspawnpos) > 64)
		{
			continue;
		}

		if(isdefined(var_02.owner))
		{
			maps\mp\gametypes\_hud_message::func_5F9A("destroyed_insertion",var_02.owner);
		}

		maps\mp\perks\_perkfunctions::deleteti(self.setspawnpoint);
		return 0;
	}

	if(!bullettracepassed(self.setspawnpoint.origin + (0,0,60),self.setspawnpoint.origin,0,self.setspawnpoint))
	{
		return 0;
	}

	var_04 = self.setspawnpoint.origin + (0,0,1);
	var_05 = playerphysicstrace(var_04,self.setspawnpoint.origin + (0,0,-16));
	if(var_04[2] == var_05[2])
	{
		return 0;
	}

	return 1;
}

//Function Number: 20
func_78A8()
{
	self notify("spawningClientThisFrameReset");
	self endon("spawningClientThisFrameReset");
	wait(0.05);
	level.numplayerswaitingtospawn--;
}

//Function Number: 21
spawnplayer(param_00)
{
	self endon("disconnect");
	self endon("joined_spectators");
	self notify("spawned");
	self notify("end_respawn");
	self notify("started_spawnPlayer");
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = undefined;
	self.ti_spawn = 0;
	self setclientomnvar("ui_options_menu",0);
	self setclientomnvar("ui_hud_shake",0);
	self.lastkillsplash = undefined;
	if(!level.ingraceperiod && !self.hasdonecombat)
	{
		level.numplayerswaitingtospawn++;
		if(level.numplayerswaitingtospawn > 1)
		{
			self.waitingtospawnamortize = 1;
			wait(0.05 * level.numplayerswaitingtospawn - 1);
		}

		thread func_78A8();
		self.waitingtospawnamortize = 0;
	}

	if(!self turretsetbarrelspinenabled(self))
	{
		var_02 = gettime() + 5000;
		self.waitingtospawnamortize = 1;
		wait(0.1);
		while(!self turretsetbarrelspinenabled(self))
		{
			wait(0.1);
			if(gettime() > var_02)
			{
				break;
			}
		}

		self.waitingtospawnamortize = 0;
	}

	if(isdefined(self.forcespawnorigin))
	{
		var_03 = self.forcespawnorigin;
		self.forcespawnorigin = undefined;
		if(isdefined(self.forcespawnangles))
		{
			var_04 = self.forcespawnangles;
			self.forcespawnangles = undefined;
		}
		else
		{
			var_04 = (0,randomfloatrange(0,360),0);
		}
	}
	else if(isdefined(self.setspawnpoint) && isdefined(self.setspawnpoint.notti) || func_8145())
	{
		var_04 = self.setspawnpoint;
		if(!isdefined(self.setspawnpoint.notti))
		{
			self.ti_spawn = 1;
			self playlocalsound("tactical_spawn");
			if(level.multiteambased)
			{
				foreach(var_06 in level.teamnamelist)
				{
					if(var_06 != self.team)
					{
						self playsoundtoteam("tactical_spawn",var_06);
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

		foreach(var_09 in level.ugvs)
		{
			if(distancesquared(var_09.origin,var_01.playerspawnpos) < 1024)
			{
				var_09 notify("damage",5000,var_09.owner,(0,0,0),(0,0,0),"MOD_EXPLOSIVE","","","",undefined,"killstreak_emp_mp");
			}
		}

		var_03 = self.setspawnpoint.playerspawnpos;
		var_04 = self.setspawnpoint.angles;
		if(isdefined(self.setspawnpoint.enemytrigger))
		{
			self.setspawnpoint.enemytrigger delete();
		}

		self.setspawnpoint delete();
		var_01 = undefined;
	}
	else if(isdefined(self.isspawningonbattlebuddy) && isdefined(self.battlebuddy))
	{
		var_03 = undefined;
		var_04 = undefined;
		var_0B = maps\mp\gametypes\_battlebuddy::func_1B96();
		if(var_0B.var_7B2A == 0)
		{
			var_03 = var_0B.origin;
			var_04 = var_0B.angles;
		}
		else
		{
			var_01 = self [[ level.getspawnpoint ]]();
			var_03 = var_01.origin;
			var_04 = var_01.angles;
		}

		maps\mp\gametypes\_battlebuddy::func_1CEA();
		self setclientomnvar("cam_scene_name","battle_spawn");
		self setclientomnvar("cam_scene_lead",self.battlebuddy getentitynumber());
		self setclientomnvar("cam_scene_support",self getentitynumber());
	}
	else if(isdefined(self.helispawning) && !isdefined(self.var_336E) || isdefined(self.var_336E) && self.var_336E && level.var_6130 > 0 && self.team == "allies")
	{
		while(!isdefined(level.allieschopper))
		{
			wait(0.1);
		}

		var_03 = level.allieschopper.origin;
		var_04 = level.allieschopper.angles;
		self.var_336E = 0;
	}
	else if(isdefined(self.helispawning) && !isdefined(self.var_336E) || isdefined(self.var_336E) && self.var_336E && level.var_6130 > 0 && self.team == "axis")
	{
		while(!isdefined(level.axischopper))
		{
			wait(0.1);
		}

		var_03 = level.axischopper.origin;
		var_04 = level.axischopper.angles;
		self.var_336E = 0;
	}
	else
	{
		var_04 = self [[ level.getspawnpoint ]]();
		var_03 = var_04.origin;
		var_04 = var_03.angles;
	}

	func_70CD();
	var_0C = self.hasspawned;
	self.fauxdead = undefined;
	if(!param_00)
	{
		self.var_4B2E = [];
		self.killsthislifeperweapon = [];
		maps\mp\_utility::func_8730("playing");
		maps\mp\_utility::clearkillcamstate();
		self.var_19A0 = undefined;
		self.maxhealth = maps\mp\gametypes\_tweakables::func_3C5B("player","maxhealth");
		self.health = self.maxhealth;
		self.var_3571 = undefined;
		self.hasspawned = 1;
		self.var_78C4 = gettime();
		self.var_8C4D = !isdefined(var_01);
		self.afk = 0;
		self.var_2305 = [];
		self.var_4B42 = 1;
		self.var_8E7B = 1;
		self.objectivescaler = 1;
		self.clampedhealth = undefined;
		self.var_7402 = 0;
		self.var_7401 = 0;
		self.var_63FF = 0;
	}

	self.movespeedscaler = 1;
	self.var_465B = 0;
	self.laststand = undefined;
	self.var_44CB = undefined;
	self.inc4death = undefined;
	self.disabledweapon = 0;
	self.var_27AB = 0;
	self.disabledoffhandweapons = 0;
	common_scripts\utility::func_6623();
	if(!param_00)
	{
		self.avoidkillstreakonspawntimer = 5;
		if(!maps\mp\_utility::func_47BB())
		{
			var_0D = self.pers["lives"];
			if(var_0D == maps\mp\_utility::func_3ABB())
			{
				addtolivescount();
			}

			if(var_0D)
			{
				self.pers["lives"]--;
			}
		}

		func_098E();
		if(!var_0C || maps\mp\_utility::gamehasstarted() || maps\mp\_utility::gamehasstarted() && level.ingraceperiod && self.hasdonecombat)
		{
			func_6591();
		}

		if(!self.var_8C3F)
		{
			var_0E = 20;
			if(maps\mp\_utility::func_3C4A() > 0 && var_0E < maps\mp\_utility::func_3C4A() * 60 / 4)
			{
				var_0E = maps\mp\_utility::func_3C4A() * 60 / 4;
			}

			if(level.ingraceperiod || maps\mp\_utility::func_3C4B() < var_0E * 1000)
			{
				self.var_8C3F = 1;
			}
		}
	}

	self setdepthoffield(0,0,512,512,4,0);
	if(level.console)
	{
		self setclientdvar("cg_fov","65");
	}

	func_6621();
	if(isdefined(var_01))
	{
		maps\mp\gametypes\_spawnlogic::func_3247(var_01);
		var_03 = func_3BEC(var_01);
		var_04 = var_01.angles;
	}
	else if(!isdefined(self.faux_spawn_infected))
	{
		self.lastspawntime = gettime();
	}

	self.spawnpos = var_03;
	self spawn(var_03,var_04);
	if(param_00 && isdefined(self.faux_spawn_stance))
	{
		self setstance(self.faux_spawn_stance);
		self.faux_spawn_stance = undefined;
	}

	if(isai(self))
	{
		maps\mp\_utility::func_350E(1);
	}

	[[ level.var_5976 ]]();
	if(isdefined(var_01))
	{
		checkpredictedspawnpointcorrectness(var_01.origin);
	}

	if(!param_00)
	{
		maps\mp\gametypes\_missions::func_5FD9();
		if(isai(self) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["player_spawned"]))
		{
			self [[ level.bot_funcs["player_spawned"] ]]();
		}

		if(!isai(self))
		{
			thread func_8CEE();
		}
	}

	maps\mp\gametypes\_class::func_7003(self.class);
	if(isdefined(level.custom_giveloadout))
	{
		self [[ level.custom_giveloadout ]](param_00);
	}
	else
	{
		maps\mp\gametypes\_class::giveloadout(self.team,self.class);
	}

	if(isdefined(game["roundsPlayed"]) && game["roundsPlayed"] > 0)
	{
		if(!isdefined(self.classrefreshed) || !self.classrefreshed)
		{
			if(isdefined(self.class_num))
			{
				self setclientomnvar("ui_loadout_selected",self.class_num);
				self.classrefreshed = 1;
			}
		}
	}

	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::func_70E6(1);
	}

	if(!maps\mp\_utility::func_36F1("prematch_done"))
	{
		maps\mp\_utility::func_350E(1);
	}
	else
	{
		maps\mp\_utility::func_350E(0);
	}

	if(!maps\mp\_utility::func_36F1("prematch_done") || !var_0C && game["state"] == "playing")
	{
		if(!maps\mp\_utility::func_47BB())
		{
			if(game["status"] == "overtime")
			{
				thread maps\mp\gametypes\_hud_message::func_58CB(game["strings"]["overtime"],game["strings"]["overtime_hint"],undefined,(1,0,0),"mp_last_stand");
			}
		}

		thread showspawnnotifies();
	}

	if(maps\mp\_utility::func_3ADD("scr_showperksonspawn",1) == 1 && game["state"] != "postgame")
	{
		if(!maps\mp\_utility::func_47BB())
		{
			self setclientomnvar("ui_spawn_abilities_show",1);
		}
	}

	waittillframeend;
	self.var_78A7 = undefined;
	self notify("spawned_player");
	level notify("player_spawned",self);
	if(game["state"] == "postgame")
	{
		maps\mp\gametypes\_gamelogic::func_350F();
	}
}

//Function Number: 22
spawnspectator(param_00,param_01)
{
	self notify("spawned");
	self notify("end_respawn");
	self notify("joined_spectators");
	in_spawnspectator(param_00,param_01);
}

//Function Number: 23
respawn_asspectator(param_00,param_01)
{
	in_spawnspectator(param_00,param_01);
}

//Function Number: 24
in_spawnspectator(param_00,param_01)
{
	func_70CD();
	var_02 = self.pers["team"];
	if(isdefined(var_02) && var_02 == "spectator" && !level.gameended)
	{
		maps\mp\_utility::func_1D47("spawn_info");
	}

	maps\mp\_utility::func_8730("spectator");
	maps\mp\_utility::clearkillcamstate();
	self.var_3571 = undefined;
	func_6622();
	if(isdefined(var_02) && var_02 == "spectator")
	{
		self.statusicon = "";
	}
	else
	{
		self.statusicon = "hud_status_dead";
	}

	maps\mp\gametypes\_spectating::func_70D0();
	func_5977(param_00,param_01);
	if(level.teambased && !level.splitscreen && !self issplitscreenplayer())
	{
		self setdepthoffield(0,128,512,4000,6,1.8);
	}
}

//Function Number: 25
func_3B97(param_00)
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

//Function Number: 26
func_5977(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		self setspectatedefaults(param_00,param_01);
		self spawn(param_00,param_01);
		checkpredictedspawnpointcorrectness(param_00);
	}

	var_02 = getspectatepoint();
	if(!maps\mp\_utility::func_47BB())
	{
		var_03 = getentarray("mp_mlg_camera","classname");
		if(isdefined(var_03) && var_03.size)
		{
			for(var_04 = 0;var_04 < var_03.size && var_04 < 4;var_04++)
			{
				self queuedialogforplayer(var_04,var_03[var_04].origin,var_03[var_04].angles);
				level.cameramapobjs[var_04].origin = var_03[var_04].origin;
				level.cameramapobjs[var_04].angles = var_03[var_04].angles;
			}
		}
		else if(isdefined(level.camera3pos))
		{
			var_05 = tolower(getdvar("mapname"));
			if(var_05 == "mp_strikezone" && isdefined(level.teleport_zone_current) && level.teleport_zone_current != "start")
			{
				self queuedialogforplayer(0,level.camera5pos,level.camera5ang);
				level.cameramapobjs[0].origin = level.camera5pos;
				level.cameramapobjs[0].angles = level.camera5ang;
				self queuedialogforplayer(1,level.camera6pos,level.camera6ang);
				level.cameramapobjs[1].origin = level.camera6pos;
				level.cameramapobjs[1].angles = level.camera6ang;
				self queuedialogforplayer(2,level.camera7pos,level.camera7ang);
				level.cameramapobjs[2].origin = level.camera7pos;
				level.cameramapobjs[2].angles = level.camera7ang;
				self queuedialogforplayer(3,level.camera8pos,level.camera8ang);
				level.cameramapobjs[3].origin = level.camera8pos;
				level.cameramapobjs[3].angles = level.camera8ang;
			}
			else
			{
				self queuedialogforplayer(0,level.camera1pos,level.camera1ang);
				level.cameramapobjs[0].origin = level.camera1pos;
				level.cameramapobjs[0].angles = level.camera1ang;
				self queuedialogforplayer(1,level.camera2pos,level.camera2ang);
				level.cameramapobjs[1].origin = level.camera2pos;
				level.cameramapobjs[1].angles = level.camera2ang;
				self queuedialogforplayer(2,level.camera3pos,level.camera3ang);
				level.cameramapobjs[2].origin = level.camera3pos;
				level.cameramapobjs[2].angles = level.camera3ang;
				self queuedialogforplayer(3,level.camera4pos,level.camera4ang);
				level.cameramapobjs[3].origin = level.camera4pos;
				level.cameramapobjs[3].angles = level.camera4ang;
			}
		}
		else
		{
			for(var_04 = 0;var_04 < 4;var_04++)
			{
				self queuedialogforplayer(var_04,var_02.origin,var_02.angles);
			}
		}
	}

	self setspectatedefaults(var_02.origin,var_02.angles);
	self spawn(var_02.origin,var_02.angles);
	checkpredictedspawnpointcorrectness(var_02.origin);
}

//Function Number: 27
getspectatepoint()
{
	var_00 = getentarray("mp_global_intermission","classname");
	var_01 = maps\mp\gametypes\_spawnlogic::func_3BF2(var_00);
	return var_01;
}

//Function Number: 28
func_78AA()
{
	self endon("disconnect");
	self notify("spawned");
	self notify("end_respawn");
	func_70CD();
	maps\mp\_utility::func_1D48();
	maps\mp\_utility::func_350E(1);
	self setclientdvar("cg_everyoneHearsEveryone",1);
	var_00 = self.pers["postGameChallenges"];
	if(!maps\mp\_utility::func_47BB() && level.rankedmatch && self.postgamepromotion || isdefined(var_00) && var_00)
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

	if(isdefined(level.finalkillcam_winner) && level.finalkillcam_winner != "none" && isdefined(level.match_end_delay) && maps\mp\_utility::func_8C49())
	{
		wait(level.match_end_delay);
	}

	maps\mp\_utility::func_8730("intermission");
	maps\mp\_utility::clearkillcamstate();
	self.var_3571 = undefined;
	var_02 = getentarray("mp_global_intermission","classname");
	var_02 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(var_02);
	var_03 = var_02[0];
	if(!isdefined(level.custom_ending))
	{
		self spawn(var_03.origin,var_03.angles);
		checkpredictedspawnpointcorrectness(var_03.origin);
		self setdepthoffield(0,128,512,4000,6,1.8);
	}

	level notify("scoreboard_displaying");
}

//Function Number: 29
spawnendofgame()
{
	if(1)
	{
		if(isdefined(level.custom_ending) && maps\mp\_utility::func_8C49())
		{
			level notify("start_custom_ending");
		}

		maps\mp\_utility::func_350E(1);
		spawnspectator();
		maps\mp\_utility::func_350E(1);
	}

	self notify("spawned");
	self notify("end_respawn");
	func_70CD();
	maps\mp\_utility::func_1D48();
	self setclientdvar("cg_everyoneHearsEveryone",1);
	maps\mp\_utility::func_8730("dead");
	maps\mp\_utility::clearkillcamstate();
	self.var_3571 = undefined;
	var_00 = getspectatepoint();
	spawnspectator(var_00.origin,var_00.angles);
	checkpredictedspawnpointcorrectness(var_00.origin);
	maps\mp\_utility::func_350E(1);
	self setdepthoffield(0,0,512,512,4,0);
}

//Function Number: 30
func_70CD()
{
	self stopshellshock();
	self stoprumble("damage_heavy");
	self.deathposition = undefined;
}

//Function Number: 31
func_5720()
{
	waittillframeend;
	if(isdefined(self))
	{
		level notify("connecting",self);
	}
}

//Function Number: 32
func_194A(param_00)
{
	if(!isdefined(self.connected))
	{
	}

	var_01 = getmatchdata("gameLength");
	var_01 = var_01 + castint(maps\mp\_utility::func_3BE4());
	setmatchdata("players",self.clientid,"disconnectTime",var_01);
	setmatchdata("players",self.clientid,"disconnectReason",param_00);
	if(maps\mp\_utility::func_634C() && !maps\mp\_utility::func_47BB())
	{
		maps\mp\_matchdata::logfinalstats();
	}

	if(isdefined(self.pers["confirmed"]))
	{
		maps\mp\_matchdata::logkillsconfirmed();
	}

	if(isdefined(self.pers["denied"]))
	{
		maps\mp\_matchdata::func_4F1C();
	}

	func_65AA();
	maps\mp\gametypes\_spawnlogic::func_6592();
	maps\mp\gametypes\_spawnlogic::func_658C();
	var_02 = self getentitynumber();
	if(!level.teambased)
	{
		game["roundsWon"][self.guid] = undefined;
	}

	if(level.splitscreen)
	{
		var_03 = level.players;
		if(var_03.size <= 1)
		{
			level thread maps\mp\gametypes\_gamelogic::func_34D1();
		}
	}

	if(isdefined(self.score) && isdefined(self.pers["team"]))
	{
		var_04 = self.score;
		if(maps\mp\_utility::func_3B2E())
		{
			var_04 = self.score / maps\mp\_utility::func_3B2E();
		}

		setplayerteamrank(self,self.clientid,castint(var_04));
	}

	var_05 = self getentitynumber();
	var_06 = self.guid;
	logprint("Q;" + var_06 + ";" + var_05 + ";" + self.name + "\n");
	thread maps\mp\_events::func_27CA();
	if(level.gameended)
	{
		maps\mp\gametypes\_gamescore::func_6587();
	}

	if(isdefined(self.team))
	{
		func_6596();
	}

	if(self.sessionstate == "playing" && !isdefined(self.fauxdead) && self.fauxdead)
	{
		func_6589(1);
	}

	if(self.sessionstate == "spectator" || self.sessionstate == "dead")
	{
		level thread maps\mp\gametypes\_gamelogic::func_86EE();
	}
}

//Function Number: 33
func_65AA()
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

//Function Number: 34
func_45FA()
{
	if(level.splitscreen || self issplitscreenplayer())
	{
		self setclientdvars("cg_hudGrenadeIconHeight","37.5","cg_hudGrenadeIconWidth","37.5","cg_hudGrenadeIconOffset","75","cg_hudGrenadePointerHeight","18","cg_hudGrenadePointerWidth","37.5","cg_hudGrenadePointerPivot","18 40.5","cg_fovscale","0.75");
		setdvar("r_materialBloomHQScriptMasterEnable",0);
	}

	self setclientdvars("cg_hudGrenadeIconHeight","25","cg_hudGrenadeIconWidth","25","cg_hudGrenadeIconOffset","50","cg_hudGrenadePointerHeight","12","cg_hudGrenadePointerWidth","25","cg_hudGrenadePointerPivot","12 27","cg_fovscale","1");
}

//Function Number: 35
func_45F9()
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

	self setclientdvars("cg_drawSpectatorMessages",1,"cg_scoreboardPingGraph",1);
	func_45FA();
	if(maps\mp\_utility::func_3ABB())
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

	self setclientdvar("ui_altscene",0);
	if(getdvarint("scr_hitloc_debug"))
	{
		for(var_00 = 0;var_00 < 6;var_00++)
		{
			self setclientdvar("ui_hitloc_" + var_00,"");
		}

		self.hitlocinited = 1;
	}
}

//Function Number: 36
func_3B1E()
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

//Function Number: 37
func_7208()
{
	self.saved_actionslotdata = [];
	for(var_00 = 1;var_00 <= 4;var_00++)
	{
		self.saved_actionslotdata[var_00] = addstruct();
		self.saved_actionslotdata[var_00].type = "";
		self.saved_actionslotdata[var_00].item = undefined;
	}

	if(!level.console)
	{
		for(var_00 = 5;var_00 <= 8;var_00++)
		{
			self.saved_actionslotdata[var_00] = addstruct();
			self.saved_actionslotdata[var_00].type = "";
			self.saved_actionslotdata[var_00].item = undefined;
		}
	}
}

//Function Number: 38
callback_playerconnect()
{
	thread func_5720();
	self.statusicon = "hud_status_connecting";
	self waittill("begin");
	self.statusicon = "";
	self.connecttime = undefined;
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
	func_45F9();
	if(!maps\mp\_utility::func_47BB())
	{
		initplayerstats();
	}

	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		level waittill("eternity");
	}

	self.guid = maps\mp\_utility::getuniqueid();
	var_00 = 0;
	if(!isdefined(self.pers["clientid"]))
	{
		if(game["clientid"] >= 30)
		{
			self.pers["clientid"] = func_3B1E();
		}
		else
		{
			self.pers["clientid"] = game["clientid"];
		}

		if(game["clientid"] < 30)
		{
			game["clientid"]++;
		}

		var_00 = 1;
	}

	if(var_00)
	{
		maps\mp\killstreaks\_killstreaks::func_6604();
	}

	self.clientid = self.pers["clientid"];
	self.pers["teamKillPunish"] = 0;
	logprint("J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\n");
	if(game["clientid"] <= 30 && game["clientid"] != getmatchdata("playerCount"))
	{
		var_01 = 0;
		var_02 = 0;
		if(!isai(self) && maps\mp\_utility::func_50C1())
		{
			self registerparty(self.clientid);
		}

		setmatchdata("playerCount",game["clientid"]);
		setmatchdata("players",self.clientid,"playerID","xuid",self getxuid());
		setmatchdata("players",self.clientid,"playerID","ucdIDHigh",self getucdidhigh());
		setmatchdata("players",self.clientid,"playerID","ucdIDLow",self getucdidlow());
		setmatchdata("players",self.clientid,"playerID","clanIDHigh",self getclanidhigh());
		setmatchdata("players",self.clientid,"playerID","clanIDLow",self getclanidlow());
		setmatchdata("players",self.clientid,"gamertag",self.name);
		var_02 = self getcommonplayerdata("connectionIDChunkLow",0);
		var_01 = self getcommonplayerdata("connectionIDChunkHigh",0);
		setmatchdata("players",self.clientid,"connectionIDChunkLow",var_02);
		setmatchdata("players",self.clientid,"connectionIDChunkHigh",var_01);
		setmatchclientip(self,self.clientid);
		var_03 = getmatchdata("gameLength");
		var_03 = var_03 + castint(maps\mp\_utility::func_3BE4());
		setmatchdata("players",self.clientid,"joinType",self setcoopplayerdatareservedint());
		setmatchdata("players",self.clientid,"connectTime",var_03);
		if(maps\mp\_utility::func_634C() && !maps\mp\_utility::func_47BB())
		{
			maps\mp\_matchdata::loginitialstats();
		}

		if((isdefined(self.pers["isBot"]) && self.pers["isBot"]) || isai(self))
		{
			var_04 = 1;
		}
		else
		{
			var_04 = 0;
		}

		if(maps\mp\_utility::func_50C1() && maps\mp\_utility::allowteamchoice() && !var_04)
		{
			setmatchdata("players",self.clientid,"team",self.sessionteam);
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
	}

	if(!isdefined(self.pers["cur_death_streak"]))
	{
		self.pers["cur_death_streak"] = 0;
	}

	if(!isdefined(self.pers["assistsToKill"]))
	{
		self.pers["assistsToKill"] = 0;
	}

	if(!isdefined(self.pers["cur_kill_streak_for_nuke"]))
	{
		self.pers["cur_kill_streak_for_nuke"] = 0;
	}

	if(!isdefined(self.pers["objectivePointStreak"]))
	{
		self.pers["objectivePointStreak"] = 0;
	}

	if(maps\mp\_utility::func_634C() && !maps\mp\_utility::func_47BB())
	{
		self.kill_streak = maps\mp\gametypes\_persistence::func_7B16("killStreak");
	}

	self.lastgrenadesuicidetime = -1;
	self.teamkillsthisround = 0;
	self.hasspawned = 0;
	self.waitingtospawn = 0;
	self.wantsafespawn = 0;
	self.var_8C3F = 0;
	self.movespeedscaler = 1;
	self.var_4B42 = 1;
	self.var_8E7B = 1;
	self.objectivescaler = 1;
	self.issniper = 0;
	if(!maps\mp\_utility::func_47BB())
	{
		func_70B5();
	}

	func_7208();
	thread maps\mp\_flashgrenades::func_538C();
	func_661F();
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
		self setclientdvars("cg_drawSpectatorMessages",0);
		func_78AA();
	}

	if(isai(self) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["think"]))
	{
		self thread [[ level.bot_funcs["think"] ]]();
	}

	level endon("game_ended");
	if(isdefined(level.hostmigrationtimer))
	{
		thread maps\mp\gametypes\_hostmigration::func_42CB();
	}

	if(isdefined(level.onplayerconnectaudioinit))
	{
		[[ level.onplayerconnectaudioinit ]]();
	}

	if(maps\mp\_utility::bot_is_fireteam_mode() && !isai(self))
	{
		thread spawnspectator();
		self setclientomnvar("ui_options_menu",0);
	}

	if(!isdefined(self.pers["team"]))
	{
		if(maps\mp\_utility::func_50C1() && self.sessionteam != "none")
		{
			thread spawnspectator();
			thread lib_05D5::func_70DF(self.sessionteam);
			if(maps\mp\_utility::allowclasschoice() || maps\mp\_utility::showfakeloadout() && !isai(self))
			{
				self setclientomnvar("ui_options_menu",2);
			}

			thread func_4AAF();
		}

		if(getactiveclientcount() && getdvarint("onlinegame") == 0 && level.gametype != "horde" && botsentientswap(self) == 0)
		{
			thread spawnspectator();
			thread lib_05D5::func_70DF("allies");
			self setclientomnvar("ui_options_menu",2);
		}

		if(!maps\mp\_utility::func_50C1() && maps\mp\_utility::allowteamchoice())
		{
			lib_05D5::menuspectator();
			self setclientomnvar("ui_options_menu",1);
		}

		thread spawnspectator();
		lib_05D5::autoassign();
		if(maps\mp\_utility::allowclasschoice() || maps\mp\_utility::showfakeloadout() && !isai(self))
		{
			self setclientomnvar("ui_options_menu",2);
		}

		if(maps\mp\_utility::func_50C1())
		{
			thread func_4AAF();
		}
	}

	lib_05D5::addtoteam(self.pers["team"],1);
	if(maps\mp\_utility::func_499C(self.pers["class"]))
	{
		thread func_7866();
	}

	thread spawnspectator();
	if(self.pers["team"] == "spectator")
	{
		if(isdefined(self.pers["mlgSpectator"]) && self.pers["mlgSpectator"])
		{
			self usemodelcollisionbounds(1);
			thread maps\mp\gametypes\_spectating::func_9452(1);
			thread maps\mp\gametypes\_spectating::func_70D0();
		}

		if(maps\mp\_utility::allowteamchoice())
		{
			lib_05D5::beginteamchoice();
		}

		self [[ level.autoassign ]]();
	}

	lib_05D5::beginclasschoice();
}

//Function Number: 39
callback_playermigrated()
{
	if(isdefined(self.connected) && self.connected)
	{
		maps\mp\_utility::updateobjectivetext();
		maps\mp\_utility::func_86FF();
		if(level.teambased)
		{
			self updatescores();
		}
	}

	if(self ishost())
	{
		func_45FA();
	}

	var_00 = 0;
	foreach(var_02 in level.players)
	{
		if(!isdefined(var_02.pers["isBot"]) || var_02.pers["isBot"] == 0)
		{
			var_00++;
		}
	}

	if(!isdefined(self.pers["isBot"]) || self.pers["isBot"] == 0)
	{
		level.hostmigrationreturnedplayercount++;
		if(level.hostmigrationreturnedplayercount >= var_00 * 2 / 3)
		{
			level notify("hostmigration_enoughplayers");
		}
	}
}

//Function Number: 40
addlevelstoexperience(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_rank::getrankforxp(param_00);
	var_03 = maps\mp\gametypes\_rank::func_3BC7(var_02);
	var_04 = maps\mp\gametypes\_rank::func_3BC6(var_02);
	var_02 = var_02 + param_00 - var_03 / var_04 - var_03;
	var_02 = var_02 + param_01;
	if(var_02 < 0)
	{
		var_02 = 0;
		var_05 = 0;
	}
	else if(var_03 >= level.maxrank + 1)
	{
		var_03 = level.maxrank;
		var_05 = 1;
	}
	else
	{
		var_05 = var_03 - floor(var_03);
		var_02 = castint(floor(var_02));
	}

	var_03 = maps\mp\gametypes\_rank::func_3BC7(var_02);
	var_04 = maps\mp\gametypes\_rank::func_3BC6(var_02);
	return castint(var_05 * var_04 - var_03) + var_03;
}

//Function Number: 41
func_3BD6(param_00)
{
	var_01 = getdvarfloat("scr_restxp_cap");
	return addlevelstoexperience(param_00,var_01);
}

//Function Number: 42
func_70B5()
{
	if(!maps\mp\_utility::func_634C())
	{
	}

	if(!getdvarint("scr_restxp_enable"))
	{
		self setrankedplayerdata("restXPGoal",0);
	}

	var_00 = self getrestedtime();
	var_01 = var_00 / 3600;
	var_02 = self getrankedplayerdata("experience");
	var_03 = getdvarfloat("scr_restxp_minRestTime");
	var_04 = getdvarfloat("scr_restxp_levelsPerDay") / 24;
	var_05 = func_3BD6(var_02);
	var_06 = self getrankedplayerdata("restXPGoal");
	if(var_06 < var_02)
	{
		var_06 = var_02;
	}

	var_07 = var_06;
	var_08 = 0;
	if(var_01 > var_03)
	{
		var_08 = var_04 * var_01;
		var_06 = addlevelstoexperience(var_06,var_08);
	}

	var_09 = "";
	if(var_06 >= var_05)
	{
		var_06 = var_05;
		var_09 = " (hit cap)";
	}

	self setrankedplayerdata("restXPGoal",var_06);
}

//Function Number: 43
func_34DD()
{
	self endon("death");
	self endon("disconnect");
	self endon("spawned");
	wait(60);
	if(self.hasspawned)
	{
	}

	if(self.pers["team"] == "spectator")
	{
	}

	if(!maps\mp\_utility::func_499C(self.pers["class"]))
	{
		self.pers["class"] = "CLASS_CUSTOM1";
		self.class = self.pers["class"];
	}

	thread func_7866();
}

//Function Number: 44
func_4AAF()
{
	self endon("death");
	self endon("disconnect");
	self endon("spawned");
	self endon("attempted_spawn");
	var_00 = getdvarfloat("scr_kick_time",90);
	var_01 = getdvarfloat("scr_kick_mintime",45);
	var_02 = getdvarfloat("scr_kick_hosttime",120);
	var_03 = gettime();
	if(self ishost())
	{
		func_4AB0(var_02);
	}
	else
	{
		func_4AB0(var_00);
	}

	var_04 = gettime() - var_03 / 1000;
	if(var_04 < var_00 - 0.1 && var_04 < var_01)
	{
	}

	if(self.hasspawned)
	{
	}

	if(self.pers["team"] == "spectator")
	{
	}

	kickplayer(self getentitynumber(),"EXE_PLAYERKICKED_INACTIVE");
	level thread maps\mp\gametypes\_gamelogic::func_86EE();
}

//Function Number: 45
func_4AB0(param_00)
{
	level endon("game_ended");
	maps\mp\gametypes\_hostmigration::func_8B0D(param_00);
}

//Function Number: 46
initplayerstats()
{
	maps\mp\gametypes\_persistence::func_45F6();
	self.pers["lives"] = maps\mp\_utility::func_3ABB();
	if(!isdefined(self.pers["deaths"]))
	{
		maps\mp\_utility::func_463E("deaths");
		maps\mp\gametypes\_persistence::func_7B28("round","deaths",0);
	}

	self.deaths = maps\mp\_utility::func_3B8D("deaths");
	if(!isdefined(self.pers["score"]))
	{
		maps\mp\_utility::func_463E("score");
		maps\mp\gametypes\_persistence::func_7B28("round","score",0);
	}

	self.score = maps\mp\_utility::func_3B8D("score");
	if(!isdefined(self.pers["suicides"]))
	{
		maps\mp\_utility::func_463E("suicides");
	}

	self.suicides = maps\mp\_utility::func_3B8D("suicides");
	if(!isdefined(self.pers["kills"]))
	{
		maps\mp\_utility::func_463E("kills");
		maps\mp\gametypes\_persistence::func_7B28("round","kills",0);
	}

	self.kills = maps\mp\_utility::func_3B8D("kills");
	if(!isdefined(self.pers["headshots"]))
	{
		maps\mp\_utility::func_463E("headshots");
	}

	self.headshots = maps\mp\_utility::func_3B8D("headshots");
	if(!isdefined(self.pers["assists"]))
	{
		maps\mp\_utility::func_463E("assists");
		maps\mp\gametypes\_persistence::func_7B28("round","assists",0);
	}

	self.assists = maps\mp\_utility::func_3B8D("assists");
	if(!isdefined(self.pers["captures"]))
	{
		maps\mp\_utility::func_463E("captures");
		maps\mp\gametypes\_persistence::func_7B28("round","captures",0);
	}

	self.captures = maps\mp\_utility::func_3B8D("captures");
	if(!isdefined(self.pers["returns"]))
	{
		maps\mp\_utility::func_463E("returns");
		maps\mp\gametypes\_persistence::func_7B28("round","returns",0);
	}

	self.returns = maps\mp\_utility::func_3B8D("returns");
	if(!isdefined(self.pers["defends"]))
	{
		maps\mp\_utility::func_463E("defends");
		maps\mp\gametypes\_persistence::func_7B28("round","defends",0);
	}

	self.defends = maps\mp\_utility::func_3B8D("defends");
	if(!isdefined(self.pers["plants"]))
	{
		maps\mp\_utility::func_463E("plants");
		maps\mp\gametypes\_persistence::func_7B28("round","plants",0);
	}

	self.plants = maps\mp\_utility::func_3B8D("plants");
	if(!isdefined(self.pers["defuses"]))
	{
		maps\mp\_utility::func_463E("defuses");
		maps\mp\gametypes\_persistence::func_7B28("round","defuses",0);
	}

	self.defuses = maps\mp\_utility::func_3B8D("defuses");
	if(!isdefined(self.pers["destructions"]))
	{
		maps\mp\_utility::func_463E("destructions");
		maps\mp\gametypes\_persistence::func_7B28("round","destructions",0);
	}

	self.destructions = maps\mp\_utility::func_3B8D("destructions");
	if(!isdefined(self.pers["confirmed"]))
	{
		maps\mp\_utility::func_463E("confirmed");
		maps\mp\gametypes\_persistence::func_7B28("round","confirmed",0);
	}

	self.confirmed = maps\mp\_utility::func_3B8D("confirmed");
	if(!isdefined(self.pers["denied"]))
	{
		maps\mp\_utility::func_463E("denied");
		maps\mp\gametypes\_persistence::func_7B28("round","denied",0);
	}

	self.denied = maps\mp\_utility::func_3B8D("denied");
	if(!isdefined(self.pers["rescues"]))
	{
		maps\mp\_utility::func_463E("rescues");
		maps\mp\gametypes\_persistence::func_7B28("round","rescues",0);
	}

	self.rescues = maps\mp\_utility::func_3B8D("rescues");
	if(!isdefined(self.pers["killChains"]))
	{
		maps\mp\_utility::func_463E("killChains");
		maps\mp\gametypes\_persistence::func_7B28("round","killChains",0);
	}

	self.killchains = maps\mp\_utility::func_3B8D("killChains");
	if(!isdefined(self.pers["killsAsSurvivor"]))
	{
		maps\mp\_utility::func_463E("killsAsSurvivor");
		maps\mp\gametypes\_persistence::func_7B28("round","killsAsSurvivor",0);
	}

	self.killsassurvivor = maps\mp\_utility::func_3B8D("killsAsSurvivor");
	if(!isdefined(self.pers["killsAsInfected"]))
	{
		maps\mp\_utility::func_463E("killsAsInfected");
		maps\mp\gametypes\_persistence::func_7B28("round","killsAsInfected",0);
	}

	self.killsasinfected = maps\mp\_utility::func_3B8D("killsAsInfected");
	if(!isdefined(self.pers["teamkills"]))
	{
		maps\mp\_utility::func_463E("teamkills");
	}

	if(!isdefined(self.pers["extrascore0"]))
	{
		maps\mp\_utility::func_463E("extrascore0");
	}

	if(!isdefined(self.pers["hordeKills"]))
	{
		maps\mp\_utility::func_463E("hordeKills");
		maps\mp\gametypes\_persistence::func_7B28("round","squardKills",0);
	}

	if(!isdefined(self.pers["hordeRevives"]))
	{
		maps\mp\_utility::func_463E("hordeRevives");
		maps\mp\gametypes\_persistence::func_7B28("round","squardRevives",0);
	}

	if(!isdefined(self.pers["hordeCrates"]))
	{
		maps\mp\_utility::func_463E("hordeCrates");
		maps\mp\gametypes\_persistence::func_7B28("round","squardCrates",0);
	}

	if(!isdefined(self.pers["hordeRound"]))
	{
		maps\mp\_utility::func_463E("hordeRound");
		maps\mp\gametypes\_persistence::func_7B28("round","sguardWave",0);
	}

	if(!isdefined(self.pers["hordeWeapon"]))
	{
		maps\mp\_utility::func_463E("hordeWeapon");
		maps\mp\gametypes\_persistence::func_7B28("round","sguardWeaponLevel",0);
	}

	if(!isdefined(self.pers["teamKillPunish"]))
	{
		self.pers["teamKillPunish"] = 0;
	}

	maps\mp\_utility::func_463E("longestStreak");
	self.pers["lives"] = maps\mp\_utility::func_3ABB();
	maps\mp\gametypes\_persistence::func_7B28("round","killStreak",0);
	maps\mp\gametypes\_persistence::func_7B28("round","loss",0);
	maps\mp\gametypes\_persistence::func_7B28("round","win",0);
	maps\mp\gametypes\_persistence::func_7B28("round","scoreboardType","none");
	maps\mp\gametypes\_persistence::func_7B29("round","timePlayed",0);
}

//Function Number: 47
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
	maps\mp\gametypes\_gamelogic::func_86EE();
}

//Function Number: 48
func_6596()
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

//Function Number: 49
func_098E()
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

//Function Number: 50
incrementalivecount(param_00)
{
	level.alivecount[param_00]++;
}

//Function Number: 51
func_6589(param_00)
{
	if(maps\mp\_utility::func_47BB())
	{
	}

	var_01 = self.team;
	if(isdefined(self.switching_teams) && self.switching_teams && isdefined(self.joining_team) && self.joining_team == self.team)
	{
		var_01 = self.leaving_team;
	}

	if(isdefined(param_00))
	{
		func_6577();
	}
	else if(isdefined(self.switching_teams))
	{
		self.pers["lives"]--;
	}

	decrementalivecount(var_01);
	return maps\mp\gametypes\_gamelogic::func_86EE();
}

//Function Number: 52
decrementalivecount(param_00)
{
	level.alivecount[param_00]--;
}

//Function Number: 53
addtolivescount()
{
	level.livescount[self.team] = level.livescount[self.team] + self.pers["lives"];
}

//Function Number: 54
func_6591()
{
	level.livescount[self.team]--;
	level.livescount[self.team] = castint(max(0,level.livescount[self.team]));
}

//Function Number: 55
func_6577()
{
	level.livescount[self.team] = level.livescount[self.team] - self.pers["lives"];
	level.livescount[self.team] = castint(max(0,level.livescount[self.team]));
}

//Function Number: 56
func_6621()
{
	self setclientomnvar("ui_carrying_bomb",0);
	self setclientomnvar("ui_dom_securing",0);
	self setclientomnvar("ui_securing",0);
	self setclientomnvar("ui_bomb_planting_defusing",0);
	self setclientomnvar("ui_light_armor",0);
	self setclientdvar("ui_juiced_end_milliseconds",0);
	self setclientomnvar("ui_killcam_end_milliseconds",0);
	self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",0);
}

//Function Number: 57
func_661F()
{
	self setclientomnvar("ui_carrying_bomb",0);
	self setclientomnvar("ui_dom_securing",0);
	self setclientomnvar("ui_securing",0);
	self setclientomnvar("ui_bomb_planting_defusing",0);
	self setclientomnvar("ui_light_armor",0);
	self setclientomnvar("ui_killcam_end_milliseconds",0);
	self setclientdvar("ui_juiced_end_milliseconds",0);
	self setclientdvar("ui_eyes_on_end_milliseconds",0);
	self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",0);
}

//Function Number: 58
func_6622()
{
	self setclientomnvar("ui_carrying_bomb",0);
	self setclientomnvar("ui_dom_securing",0);
	self setclientomnvar("ui_securing",0);
	self setclientomnvar("ui_bomb_planting_defusing",0);
	self setclientomnvar("ui_light_armor",0);
	self setclientomnvar("ui_killcam_end_milliseconds",0);
	self setclientdvar("ui_juiced_end_milliseconds",0);
	self setclientdvar("ui_eyes_on_end_milliseconds",0);
	self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",0);
}

//Function Number: 59
resetuidvarsondeath()
{
}

//Function Number: 60
func_8CEE()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("sprint_slide_begin");
		self playfx(level._effect["slide_dust"],self geteye());
	}
}