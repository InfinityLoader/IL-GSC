/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\traps\_trap_turrets.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 145 ms
 * Timestamp: 4/22/2024 2:13:21 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(level.sentrysettings))
	{
		level.sentrysettings = [];
	}

	level.sentrysettings["zombies_trap"] = spawnstruct();
	level.sentrysettings["zombies_trap"].health = 999999;
	level.sentrysettings["zombies_trap"].maxhealth = 1000;
	level.sentrysettings["zombies_trap"].burstmin = 20;
	level.sentrysettings["zombies_trap"].burstmax = 120;
	level.sentrysettings["zombies_trap"].pausemin = 0.15;
	level.sentrysettings["zombies_trap"].pausemax = 0.35;
	level.sentrysettings["zombies_trap"].sentrymodeon = "sentry";
	level.sentrysettings["zombies_trap"].sentrymodeoff = "sentry_offline";
	level.sentrysettings["zombies_trap"].timeout = 90;
	level.sentrysettings["zombies_trap"].spinuptime = 0.05;
	level.sentrysettings["zombies_trap"].overheattime = 8;
	level.sentrysettings["zombies_trap"].cooldowntime = 0.1;
	level.sentrysettings["zombies_trap"].fxtime = 0.3;
	level.sentrysettings["zombies_trap"].streakname = "sentry";
	level.sentrysettings["zombies_trap"].weaponinfo = "zombie_trap_turret_mp";
	level.sentrysettings["zombies_trap"].modelbase = "zark_trap_turret";
	var_00 = common_scripts\utility::getstructarray("turret_trap","script_noteworthy");
	if(var_00.size > 0)
	{
		thread maps\mp\zombies\_traps::trap_setup_custom_function("turret_trap","active",::begintrap);
		thread maps\mp\zombies\_traps::trap_setup_custom_hints("turret_trap",&"ZOMBIES_TRAP_READY",&"ZOMBIES_TRAP_COOLDOWN");
	}

	foreach(var_02 in level.traps)
	{
		if(!isdefined(var_02.script_noteworthy) || var_02.script_noteworthy != "turret_trap")
		{
			continue;
		}

		var_03 = var_02 trapgetturrets();
		foreach(var_05 in var_03)
		{
			var_05 sentry_initsentry("zombies_trap");
		}
	}
}

//Function Number: 2
begintrap(param_00)
{
	var_01 = "zombies_trap";
	var_02 = param_00 trapgetturrets();
	foreach(var_04 in var_02)
	{
		var_04 sentry_setowner(param_00.owner);
		var_04 sentry_setactive();
		var_04 thread sentry_handlecomplete();
	}

	param_00 thread trapturrettimer(var_02);
	return 1;
}

//Function Number: 3
trapgetturrets()
{
	var_00 = getentarray(self.target,"targetname");
	var_01 = common_scripts\utility::getstructarray(self.target,"targetname");
	var_02 = common_scripts\utility::array_combine(var_00,var_01);
	var_03 = [];
	foreach(var_05 in var_02)
	{
		if(!isdefined(var_05.script_noteworthy))
		{
			continue;
		}

		if(var_05.script_noteworthy == "turret")
		{
			var_03[var_03.size] = var_05;
		}
	}

	return var_03;
}

//Function Number: 4
trapturrettimer(param_00)
{
	self waittill("cooldown");
	foreach(var_02 in param_00)
	{
		var_02 notify("timeout");
	}
}

//Function Number: 5
sentry_setactive()
{
	self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
}

//Function Number: 6
sentry_initsentry(param_00)
{
	self.sentrytype = param_00;
	self setleftarc(180);
	self setrightarc(180);
	self settoparc(89);
	self setbottomarc(89);
	self setmodel(level.sentrysettings[self.sentrytype].modelbase);
	self maketurretinoperable();
	self setdefaultdroppitch(0);
	self setcandamage(0);
	self setcanradiusdamage(0);
	self setturretmodechangewait(1);
	maps\mp\killstreaks\_autosentry::sentry_setinactive();
	thread sentry_attacktargets();
}

//Function Number: 7
sentry_attacktargets()
{
	self endon("death");
	level endon("game_ended");
	self.momentum = 0;
	self.heatlevel = 0;
	self.overheated = 0;
	for(;;)
	{
		common_scripts\utility::waittill_either("turretstatechange","cooled");
		if(self isfiringturret())
		{
			thread maps\mp\killstreaks\_autosentry::sentry_burstfirestart();
			continue;
		}

		maps\mp\killstreaks\_autosentry::sentry_spindown();
		thread maps\mp\killstreaks\_autosentry::sentry_burstfirestop();
	}
}

//Function Number: 8
sentry_handlecomplete()
{
	self waittill("timeout");
	if(!isdefined(self))
	{
		return;
	}

	maps\mp\killstreaks\_autosentry::sentry_setinactive();
	self setsentryowner(undefined);
	self setturretminimapvisible(0);
}

//Function Number: 9
sentry_setowner(param_00)
{
	self.owner = param_00;
	self setsentryowner(self.owner);
	self setturretminimapvisible(1,self.sentrytype);
	self.team = self.owner.team;
	self setturretteam(self.team);
}