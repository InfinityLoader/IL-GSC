/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\zombie_boss_oz_stage1_traps.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 72
 * Decompile Time: 1195 ms
 * Timestamp: 4/22/2024 2:15:02 AM
*******************************************************************/

//Function Number: 1
init_traps()
{
	level.stage1traps = [];
	level.invalidationtrapsequence = [];
	level.invalidationtrapwarningtime = [-1,5,4.25,3.5];
	level.invalidationtrapdamagetime = [-1,40,34,28];
	level.trapsequencetime = [-1,50,42.5,35];
	var_00 = spawnstruct();
	var_00.type = "aerial_lasers";
	var_00.weight = 1;
	var_00.lasers = aeriallaser_init();
	var_00.istrapactivefunc = ::aeriallaser_istrapactive;
	var_00.canruntrapfunc = ::aeriallaser_canruntrap;
	var_00.runtrapfunc = ::aeriallaser_runtrap;
	var_00.gettraptriggersfunc = ::aeriallaser_gettriggers;
	var_00 setup_trap_overlap(["electricity","gas"],["electricity","gas"],["electricity"],["electricity"]);
	level.stage1traps[var_00.type] = var_00;
	var_00 = spawnstruct();
	var_00.type = "electricity";
	var_00.weight = 1;
	var_00.electricity = electrotrap_init();
	var_00.istrapactivefunc = ::electrotrap_istrapactive;
	var_00.canruntrapfunc = ::electrotrap_canruntrap;
	var_00.runtrapfunc = ::electrotrap_runtrap;
	var_00 setup_trap_overlap(["aerial_lasers","gas"],["aerial_lasers","gas"],["aerial_lasers","gas"],["aerial_lasers"]);
	level.stage1traps[var_00.type] = var_00;
	var_00 = spawnstruct();
	var_00.type = "gas";
	var_00.weight = 1;
	var_00.gas = gastrap_init();
	var_00.istrapactivefunc = ::gastrap_istrapactive;
	var_00.canruntrapfunc = ::gastrap_canruntrap;
	var_00.runtrapfunc = ::gastrap_runtrap;
	var_00.gettraptriggersfunc = ::gastrap_gettriggers;
	var_00 setup_trap_overlap(["aerial_lasers","electricity"],["aerial_lasers","electricity"],["electricity"],[]);
	level.stage1traps[var_00.type] = var_00;
	var_00 = spawnstruct();
	var_00.type = "stationary_turrets";
	var_00.weight = 1;
	var_00.turretdoors = stationaryturret_init();
	var_00.canruntrapfunc = ::stationaryturret_canrunturrettrap;
	var_00.runtrapfunc = ::stationaryturret_runturrettrap;
	level.stage1traps[var_00.type] = var_00;
	var_00 = spawnstruct();
	var_00.type = "mounted_turrets";
	var_00.weight = 1;
	var_00.turrets = mountedturret_init();
	var_00.canruntrapfunc = ::mountedturret_canrunturrettrap;
	var_00.runtrapfunc = ::mountedturret_runturrettrap;
	level.stage1traps[var_00.type] = var_00;
	var_00 = spawnstruct();
	var_00.type = "zombies";
	var_00.weight = 1;
	var_00.canruntrapfunc = ::zombietrap_canruntrap;
	var_00.runtrapfunc = ::zombietrap_runtrap;
	level.stage1traps[var_00.type] = var_00;
}

//Function Number: 2
begin_round_init_traps()
{
	var_00 = getentarray("boss_oz_mounted_turret","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 3
setup_trap_overlap(param_00,param_01,param_02,param_03)
{
	self.nooverlapwith[0] = param_00;
	self.nooverlapwith[1] = param_01;
	self.nooverlapwith[2] = param_02;
	self.nooverlapwith[3] = param_03;
}

//Function Number: 4
run_trap_sequence(param_00)
{
	level endon("game_ended");
	level endon("zombie_wave_interrupt");
	level endon("zombie_boss_wave_ended");
	var_01 = ["aerial_lasers","electricity","gas"];
	var_02[0] = ["stationary_turrets","mounted_turrets"];
	var_02[1] = ["zombies"];
	var_03 = maps\mp\zombies\zombie_boss_oz_stage1::getstage1phase();
	maps\mp\zombies\_util::waittillzombiegameunpaused();
	wait(0.5);
	var_0A = level.trapsequencetime[var_03] / 3;
	for(var_09 = 0;var_09 < param_00;var_09++)
	{
		if(level.invalidationtrapsequence.size == 0)
		{
			level.invalidationtrapsequence = var_01;
		}

		if(level.invalidationtrapsequence.size > 0)
		{
			var_0B = level.invalidationtrapsequence[0];
			var_0C = level.stage1traps[var_0B];
			level thread [[ var_0C.runtrapfunc ]](var_0C,level.invalidationtrapwarningtime[var_03],level.invalidationtrapdamagetime[var_03]);
			thread maps\mp\zombies\zombie_boss_oz_stage1::ozplaytrapanim(var_0A);
			level.invalidationtrapsequence = common_scripts\utility::array_remove(level.invalidationtrapsequence,var_0B);
			level childthread playozrandomvo(var_0A);
		}

		wait(var_0A);
		maps\mp\zombies\_util::waittillzombiegameunpaused();
		var_02 = common_scripts\utility::array_randomize(var_02);
		run_trap_from_list(var_02[0]);
		thread maps\mp\zombies\zombie_boss_oz_stage1::ozplaytrapanim(var_0A);
		level childthread playozrandomvo(var_0A);
		wait(var_0A);
		maps\mp\zombies\_util::waittillzombiegameunpaused();
		run_trap_from_list(var_02[1]);
		thread maps\mp\zombies\zombie_boss_oz_stage1::ozplaytrapanim(var_0A);
		level childthread playozrandomvo(var_0A);
		wait(var_0A);
		maps\mp\zombies\_util::waittillzombiegameunpaused();
	}
}

//Function Number: 5
playozrandomvo(param_00)
{
	var_01 = 8;
	var_02 = param_00 - 5;
	if(var_02 < 0 || var_01 > param_00 || var_01 > var_02)
	{
		return;
	}

	wait(randomfloatrange(var_01,var_02));
	maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("rand1",0,undefined,undefined,undefined,1);
}

//Function Number: 6
run_trap_from_list(param_00)
{
	var_01 = pick_trap_from_named_list(param_00);
	if(isdefined(var_01))
	{
		level thread [[ var_01.runtrapfunc ]](var_01);
	}
}

//Function Number: 7
pick_trap_from_named_list(param_00)
{
	var_01 = [];
	foreach(var_03 in level.stage1traps)
	{
		if(common_scripts\utility::array_contains(param_00,var_03.type))
		{
			var_01[var_01.size] = var_03;
		}
	}

	var_05 = undefined;
	while(!isdefined(var_05) && var_01.size > 0)
	{
		var_06 = 0;
		foreach(var_03 in var_01)
		{
			var_06 = var_06 + var_03.weight;
		}

		var_09 = randomfloat(var_06);
		foreach(var_03 in var_01)
		{
			if(var_09 < var_03.weight)
			{
				var_05 = var_03;
				break;
			}
			else
			{
				var_09 = var_09 - var_03.weight;
			}
		}

		var_0C = [[ var_05.canruntrapfunc ]](var_05);
		if(var_0C)
		{
			var_0C = !trapoverlapsactiveillegaltrap(var_05);
		}

		if(!var_0C)
		{
			var_01 = common_scripts\utility::array_remove(var_01,var_05);
			var_05 = undefined;
		}
	}

	return var_05;
}

//Function Number: 8
trapoverlapsactiveillegaltrap(param_00)
{
	if(!isdefined(param_00.nooverlapwith))
	{
		return 0;
	}

	var_01 = maps\mp\zombies\zombie_boss_oz_stage1::getstage1phase();
	var_02 = param_00.nooverlapwith[var_01];
	if(!isdefined(var_02))
	{
		return 0;
	}

	foreach(var_04 in var_02)
	{
		var_05 = level.stage1traps[var_04];
		if([[ var_05.istrapactivefunc ]](var_05))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 9
waittilltimeorroundend(param_00)
{
	var_01 = level common_scripts\utility::waittill_any_timeout(param_00,"game_ended","zombie_wave_interrupt","zombie_boss_wave_ended","stop_all_boss_traps");
	return var_01 == "timeout";
}

//Function Number: 10
turrethandledeath()
{
	var_00 = self getentitynumber();
	self waittill("death",var_01,var_02,var_03);
	if(isremovedentity(self))
	{
		return;
	}

	self.isalive = 0;
	self.damagecallback = undefined;
	self setcandamage(0);
	self setdamagecallbackon(0);
	self freeentitysentient();
	self setmode("sentry_offline");
	self setdefaultdroppitch(35);
	self setsentryowner(undefined);
	self setturretminimapvisible(0);
	var_04 = self.owner;
	self.waitingtodie = 1;
	self playsound("sentry_explode");
	playfxontag(common_scripts\utility::getfx("sentry_explode_mp"),self,"tag_aim");
	self playsound("sentry_explode_smoke");
	wait(0.5);
	self notify("deleting");
	self delete();
}

//Function Number: 11
turretsetupdamagecallback()
{
	self.damagecallback = ::turrethandledamagecallback;
	self setcandamage(1);
	self setdamagecallbackon(1);
}

//Function Number: 12
turrethandledamagecallback(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(param_01) || param_01.classname == "worldspawn")
	{
		return;
	}

	if(param_01.team == self.team)
	{
		return;
	}

	var_0C = maps\mp\zombies\zombie_boss_oz_stage1::ozscaledamageforkillstreakorweaponlevel(param_00,param_01,param_05,param_04,param_02);
	self.wasdamaged = 1;
	self.damagefade = 0;
	if(isplayer(param_01))
	{
		param_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("remote_turret");
	}

	self finishentitydamage(param_00,param_01,var_0C,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 13
turretgetenemy(param_00,param_01)
{
	var_02 = (0,0,72);
	var_03 = [];
	foreach(var_05 in level.players)
	{
		if(var_05.ignoreme || var_05 isnotarget())
		{
			continue;
		}

		if(var_05.sessionstate == "spectator")
		{
			continue;
		}

		var_03[var_03.size] = var_05;
	}

	var_07 = 500000000;
	var_08 = undefined;
	foreach(var_05 in var_03)
	{
		var_0A = distancesquared(var_05.origin,param_00.origin);
		if(var_0A < var_07)
		{
			if(sighttracepassed(var_05.origin + var_02,param_00.origin + param_01,0,undefined))
			{
				var_07 = var_0A;
				var_08 = var_05;
			}
		}
	}

	return var_08;
}

//Function Number: 14
stationaryturret_init()
{
	level._effect["stationary_turret_teleport"] = loadfx("vfx/unique/dlc_teleport_soldier_bad");
	var_00 = common_scripts\utility::getstructarray("arena_turret_door","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread init_arena_turret_door();
	}

	return var_00;
}

//Function Number: 15
stationaryturret_getnumtoactivate()
{
	if(maps\mp\zombies\_util::getnumplayers() <= 2)
	{
		return 1;
	}

	return 2;
}

//Function Number: 16
stationaryturret_canrunturrettrap(param_00)
{
	var_01 = 0;
	foreach(var_03 in param_00.turretdoors)
	{
		if(!var_03.open)
		{
			var_01++;
		}
	}

	return var_01 > stationaryturret_getnumtoactivate();
}

//Function Number: 17
stationaryturret_runturrettrap(param_00)
{
	var_01 = common_scripts\utility::array_randomize(param_00.turretdoors);
	if(level.currentgen)
	{
		var_02 = 0;
		for(var_03 = 0;var_03 < var_01.size;var_03++)
		{
			if(var_01[var_03].open)
			{
				var_02++;
			}
		}

		if(var_02 >= 2)
		{
			return;
		}
	}

	var_04 = 0;
	for(var_03 = 0;var_03 < var_01.size && var_04 < stationaryturret_getnumtoactivate();var_03++)
	{
		if(!var_01[var_03].open)
		{
			var_01[var_03] thread open_door();
			var_05 = stationaryturret_spawnenemyturret("boss_oz_sentry_minigun_mp",var_01[var_03]);
			var_05 thread closedooronturretdeath(var_01[var_03]);
			var_05 thread destroyturretonroundend();
			var_04++;
		}
	}

	level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("sentry",0);
}

//Function Number: 18
destroyturretonroundend()
{
	self endon("death");
	level common_scripts\utility::waittill_any("game_ended","zombie_wave_interrupt","zombie_boss_wave_ended");
	self notify("death");
}

//Function Number: 19
stationaryturret_spawnenemyturret(param_00,param_01)
{
	var_02 = spawnturret("misc_turret",param_01.origin,param_00);
	var_02.angles = param_01.angles;
	var_02.owner = undefined;
	var_02.health = 1000;
	var_02.maxhealth = 1000;
	var_02.turrettype = "mg_turret";
	var_02.stunned = 0;
	var_02.directhacked = 0;
	var_02.stunnedtime = 5;
	var_02.issentry = 1;
	var_02.weaponinfo = param_00;
	var_02.energyturret = 0;
	var_02.rocketturret = 0;
	var_02.guardian = 0;
	var_02.isalive = 1;
	var_02 setmodel("npc_sentry_minigun_turret_base");
	var_02 setmode("sentry_manual");
	var_02 setturretteam("axis");
	var_02 setsentryowner(undefined);
	var_02 setturretminimapvisible(1,param_00);
	var_02 setleftarc(48);
	var_02 setrightarc(48);
	var_02 setdefaultdroppitch(-89);
	var_02.damagefade = 1;
	var_02 laseron("trap_zm");
	playfx(common_scripts\utility::getfx("stationary_turret_teleport"),var_02.origin,(1,0,0),(0,0,1));
	var_02 thread stationaryturret_picktarget();
	var_02 thread stationaryturret_shoot();
	var_02 thread stationaryturret_setactive();
	return var_02;
}

//Function Number: 20
stationaryturret_shoot()
{
	self endon("death");
	self endon("deleting");
	level endon("game_ended");
	wait(3);
	for(;;)
	{
		wait(0.05);
		if(isdefined(self.targetplayer) && isplayer(self.targetplayer) && self.targetplayer.ignoreme)
		{
			continue;
		}

		if(isdefined(self.targetplayer))
		{
			if(isdefined(self getturrettarget(1)))
			{
				var_00 = randomintrange(25,50);
				for(var_01 = 0;var_01 < var_00;var_01++)
				{
					self shootturret();
					wait(0.1);
				}

				wait(randomintrange(3,5));
				continue;
			}

			wait(randomintrange(1,3));
		}
	}
}

//Function Number: 21
stationaryturret_picktarget()
{
	self endon("death");
	self endon("deleting");
	level endon("game_ended");
	for(;;)
	{
		var_00 = turretgetenemy(self,(0,0,40));
		if(!isdefined(self.waitingtodie) && isdefined(var_00))
		{
			if(isdefined(var_00.isaerialassaultdrone) && var_00.isaerialassaultdrone)
			{
				self settargetentity(var_00,(0,0,-20));
			}
			else
			{
				self settargetentity(var_00);
			}

			self.targetplayer = var_00;
		}
		else
		{
			self cleartargetentity();
			self.targetplayer = undefined;
		}

		wait(0.1);
	}
}

//Function Number: 22
stationaryturret_setactive()
{
	self endon("death");
	self setdefaultdroppitch(0);
	self makeunusable();
	self maketurretsolid();
	self.team = "axis";
	self setturretteam("axis");
	thread turrethandledeath();
	thread turretsetupdamagecallback();
}

//Function Number: 23
closedooronturretdeath(param_00)
{
	self waittill("death");
	while(!param_00.open)
	{
		wait(0.05);
	}

	param_00 close_door();
}

//Function Number: 24
init_arena_turret_door()
{
	self.mover = getent(self.target,"targetname");
	self.mover.closed_pos = self.mover.origin;
	var_00 = common_scripts\utility::getstruct(self.mover.target,"targetname");
	self.mover.open_pos = var_00.origin;
	var_01 = getent(self.mover.target,"targetname");
	var_01 linkto(self.mover);
	if(level.nextgen)
	{
		var_02 = getscriptablearray("light_pluse_turret_mp_zombie_h2o","targetname");
		self.scriptablelight = common_scripts\utility::get_array_of_closest(self.mover.origin,var_02)[0];
		self.scriptablelight setscriptablepartstate(0,0);
	}

	self.open = 0;
}

//Function Number: 25
open_door()
{
	level endon("game_ended");
	if(level.nextgen)
	{
		self.scriptablelight setscriptablepartstate(0,1);
	}

	self.mover activate_door("open",3);
	self.open = 1;
}

//Function Number: 26
close_door()
{
	level endon("game_ended");
	if(level.nextgen)
	{
		self.scriptablelight setscriptablepartstate(0,0);
	}

	self.mover activate_door("close",0.5);
	self.open = 0;
}

//Function Number: 27
activate_door(param_00,param_01)
{
	if(param_00 == "open")
	{
		self moveto(self.open_pos,param_01);
	}
	else if(param_00 == "close")
	{
		self moveto(self.closed_pos,param_01);
	}

	self playsound("interact_door");
	wait(param_01);
	if(maps\mp\_movers::script_mover_is_dynamic_path())
	{
		if(param_00 == "open")
		{
			self connectpaths();
			return;
		}

		if(param_00 == "close")
		{
			self disconnectpaths();
			return;
		}
	}
}

//Function Number: 28
mountedturret_init()
{
	level._effect["mounted_turret_teleport"] = loadfx("vfx/unique/dlc_teleport_soldier_bad");
	if(!isdefined(level.sentrysettings))
	{
		level.sentrysettings = [];
	}

	var_00 = "boss_oz_mounted_turret";
	level.sentrysettings[var_00] = spawnstruct();
	level.sentrysettings[var_00].health = 250;
	level.sentrysettings[var_00].maxhealth = 250;
	level.sentrysettings[var_00].burstmin = 20;
	level.sentrysettings[var_00].burstmax = 120;
	level.sentrysettings[var_00].pausemin = 0.15;
	level.sentrysettings[var_00].pausemax = 0.35;
	level.sentrysettings[var_00].sentrymodeon = "sentry_manual";
	level.sentrysettings[var_00].sentrymodeoff = "sentry_offline";
	level.sentrysettings[var_00].timeout = 90;
	level.sentrysettings[var_00].spinuptime = 0.05;
	level.sentrysettings[var_00].overheattime = 8;
	level.sentrysettings[var_00].cooldowntime = 0.1;
	level.sentrysettings[var_00].fxtime = 0.3;
	level.sentrysettings[var_00].streakname = "sentry";
	level.sentrysettings[var_00].weaponinfo = "boss_oz_mounted_turret_mp";
	level.sentrysettings[var_00].modelbase = "boss_oz_mounted_turret";
	return common_scripts\utility::getstructarray("boss_turret_elevated","targetname");
}

//Function Number: 29
mountedturret_initsentry()
{
	self.sentrytype = "boss_oz_mounted_turret";
	self setleftarc(180);
	self setrightarc(180);
	self settoparc(89);
	self setbottomarc(89);
	self setmodel(level.sentrysettings[self.sentrytype].modelbase);
	self maketurretinoperable();
	self setdefaultdroppitch(0);
	self setcandamage(0);
	self.team = "axis";
	self setturretteam("axis");
	self.aimingorg = common_scripts\utility::getstruct(self.target,"targetname");
	self setturretmodechangewait(1);
	maps\mp\killstreaks\_autosentry::sentry_setinactive();
}

//Function Number: 30
mountedturret_spawnturret()
{
	self.turret = spawnturret("misc_turret",self.origin,level.sentrysettings["boss_oz_mounted_turret"].weaponinfo);
	self.turret.angles = self.angles;
	self.turret.weaponinfo = level.sentrysettings["boss_oz_mounted_turret"].weaponinfo;
	self.turret setmodel(level.sentrysettings["boss_oz_mounted_turret"].modelbase);
	self.turret.target = self.target;
	self.turret.targetname = "boss_oz_mounted_turret";
	self.turret mountedturret_initsentry();
	playfx(common_scripts\utility::getfx("mounted_turret_teleport"),self.turret.origin,(1,0,0),(0,0,1));
}

//Function Number: 31
mountedturret_activateturret()
{
	self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
	thread mountedturret_handletargeting();
	self.isalive = 1;
	self.health = level.sentrysettings[self.sentrytype].health;
	self.maxhealth = level.sentrysettings[self.sentrytype].maxhealth;
	self makeunusable();
	self maketurretsolid();
	thread turrethandledeath();
	thread turretsetupdamagecallback();
	self laseron("trap_zm");
}

//Function Number: 32
mountedturret_handletargeting()
{
	self endon("death");
	self endon("deleting");
	self endon("disable_turret");
	level endon("game_ended");
	self.momentum = 0;
	self.heatlevel = 0;
	self.overheated = 0;
	childthread maps\mp\killstreaks\_autosentry::sentry_heatmonitor();
	var_00 = undefined;
	for(;;)
	{
		var_01 = turretgetenemy(self.aimingorg,(0,0,0));
		if(!isdefined(var_00) && isdefined(var_01))
		{
			childthread maps\mp\killstreaks\_autosentry::sentry_burstfirestart();
		}
		else if(isdefined(var_00) && !isdefined(var_01))
		{
			childthread maps\mp\killstreaks\_autosentry::sentry_burstfirestop();
		}

		var_00 = var_01;
		if(isdefined(var_01))
		{
			self settargetentity(var_01);
		}
		else
		{
			self cleartargetentity();
		}

		wait(0.5);
	}
}

//Function Number: 33
mountedturret_getnumtoactivate()
{
	if(maps\mp\zombies\_util::getnumplayers() <= 2)
	{
		return 1;
	}

	return 2;
}

//Function Number: 34
mountedturret_canrunturrettrap(param_00)
{
	var_01 = 0;
	foreach(var_03 in param_00.turrets)
	{
		if(!isdefined(var_03.turret) && isalive(var_03.turret))
		{
			var_01++;
		}
	}

	return var_01 >= mountedturret_getnumtoactivate();
}

//Function Number: 35
mountedturret_runturrettrap(param_00)
{
	var_01 = common_scripts\utility::array_randomize(param_00.turrets);
	if(level.currentgen)
	{
		var_02 = 0;
		for(var_03 = 0;var_03 < var_01.size;var_03++)
		{
			if(isdefined(var_01[var_03].turret) && isalive(var_01[var_03].turret))
			{
				var_02++;
			}
		}

		if(var_02 >= 4)
		{
			return;
		}
	}

	var_04 = 0;
	for(var_03 = 0;var_03 < var_01.size && var_04 < mountedturret_getnumtoactivate();var_03++)
	{
		if(!isdefined(var_01[var_03].turret) && isalive(var_01[var_03].turret))
		{
			var_01[var_03] mountedturret_spawnturret();
			var_01[var_03].turret mountedturret_activateturret();
			var_01[var_03].turret thread deactivateturretonroundend();
			var_04++;
		}
	}

	level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("turret",0);
}

//Function Number: 36
deactivateturretonroundend()
{
	self endon("death");
	level common_scripts\utility::waittill_any("game_ended","zombie_wave_interrupt","zombie_boss_wave_ended");
	self cleartargetentity();
	self laseroff();
	self notify("disable_turret");
	mountedturret_initsentry();
}

//Function Number: 37
aeriallaser_init()
{
	var_00 = getentarray("boss_oz_air_laser","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = common_scripts\utility::getstructarray(var_02.target,"targetname");
		var_02.laser_ents = [];
		foreach(var_05 in var_03)
		{
			var_02.laser_ents[var_02.laser_ents.size] = setup_laser_trap(var_05);
		}

		var_02.enabled = 0;
	}

	return var_00;
}

//Function Number: 38
setup_laser_trap(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	var_01.angles = param_00.angles;
	var_01.start_origin = var_01.origin;
	var_01.start_angles = var_01.angles;
	var_01 setmodel("tag_laser");
	return var_01;
}

//Function Number: 39
aeriallaser_istrapactive(param_00)
{
	foreach(var_02 in param_00.lasers)
	{
		if(var_02.enabled)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 40
aeriallaser_canruntrap(param_00)
{
	return !aeriallaser_istrapactive(param_00);
}

//Function Number: 41
aeriallaser_runtrap(param_00,param_01,param_02,param_03)
{
	level thread aeriallaser_fx(param_01,param_02);
	foreach(var_05 in param_00.lasers)
	{
		var_05 thread start_laser(param_01,param_02);
	}

	if(!isdefined(param_03))
	{
		level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("laser",0);
	}
}

//Function Number: 42
aeriallaser_gettriggers(param_00)
{
	return param_00.lasers;
}

//Function Number: 43
aeriallaser_fx(param_00,param_01)
{
	var_02 = 91;
	var_03 = 92;
	activatepersistentclientexploder(var_02);
	var_04 = waittilltimeorroundend(param_00);
	if(var_04)
	{
		stopclientexploder(var_02);
		activatepersistentclientexploder(var_03);
		waittilltimeorroundend(param_01);
		stopclientexploder(var_03);
		return;
	}

	stopclientexploder(var_02);
}

//Function Number: 44
start_laser(param_00,param_01)
{
	self.enabled = 1;
	start_laser_sounds();
	var_02 = waittilltimeorroundend(param_00);
	if(var_02)
	{
		childthread start_laser_damage();
		waittilltimeorroundend(param_01);
	}

	stop_laser_sounds();
	self notify("cooldown");
	self.enabled = 0;
}

//Function Number: 45
start_laser_damage()
{
	self endon("cooldown");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(isplayer(var_00))
		{
			if(isdefined(var_00.nextlasertrapdamagetime) && var_00.nextlasertrapdamagetime > gettime())
			{
				continue;
			}

			var_00.nextlasertrapdamagetime = gettime() + 2500;
			var_00 dodamage(40,var_00.origin,undefined,undefined,"MOD_TRIGGER_HURT");
			if(isdefined(var_00.exosuitonline) && var_00.exosuitonline && !isdefined(var_00.nextlasertrapemptime) && var_00.nextlasertrapemptime > gettime())
			{
				var_00.nextlasertrapemptime = gettime() + 2500;
				var_00 thread maps\mp\zombies\_mutators::mutatoremz_applyemp();
				playfx(level._effect["mut_emz_attack_sm"],var_00.origin);
				var_00 playlocalsound("zmb_emz_impact");
			}
		}
	}
}

//Function Number: 46
start_laser_sounds()
{
	playsoundatpos((0,0,0),"zom_boss_grid_trap_on");
	foreach(var_01 in self.laser_ents)
	{
	}
}

//Function Number: 47
stop_laser_sounds()
{
	playsoundatpos((0,0,0),"zom_boss_grid_trap_off");
	foreach(var_01 in self.laser_ents)
	{
	}
}

//Function Number: 48
electrotrap_init()
{
	level._effect["trap_electric_floor_shock_warning"] = loadfx("vfx/map/mp_zombie_h2o/electrified_floor_warning");
	level._effect["trap_electric_floor_shock_active"] = loadfx("vfx/map/mp_zombie_brg/electrified_floor");
	var_00 = common_scripts\utility::getstructarray("trap_electricity","targetname");
	foreach(var_02 in var_00)
	{
		var_02.damage_triggers = [];
		var_02.fx_structs = [];
		var_02.enabled = 0;
		var_03 = common_scripts\utility::array_combine(getentarray(var_02.target,"targetname"),common_scripts\utility::getstructarray(var_02.target,"targetname"));
		foreach(var_05 in var_03)
		{
			if(var_05.script_noteworthy == "damage_over_time")
			{
				var_02.damage_triggers[var_02.damage_triggers.size] = var_05;
				continue;
			}

			if(var_05.script_noteworthy == "fx_trap")
			{
				var_02.fx_structs[var_02.fx_structs.size] = var_05;
			}
		}
	}

	return var_00;
}

//Function Number: 49
electrotrap_istrapactive(param_00)
{
	foreach(var_02 in param_00.electricity)
	{
		if(var_02.enabled)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 50
electrotrap_canruntrap(param_00)
{
	return !electrotrap_istrapactive(param_00);
}

//Function Number: 51
electrotrap_runtrap(param_00,param_01,param_02,param_03)
{
	thread electrotrap_startelectricity(param_00.electricity,param_01,param_02);
	if(!isdefined(param_03))
	{
		level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("elect",0);
	}
}

//Function Number: 52
electrotrap_startelectricity(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::array_randomize(param_00);
	var_03 = common_scripts\utility::array_combine(var_03,var_03);
	foreach(var_05 in param_00)
	{
		var_05 start_electricity_warning_fx();
	}

	var_07 = waittilltimeorroundend(param_01);
	foreach(var_05 in param_00)
	{
		var_05 stop_electricity_fx();
	}

	if(!var_07)
	{
		return;
	}

	foreach(var_05 in var_03)
	{
		var_05.enabled = 1;
		foreach(var_0C in var_05.damage_triggers)
		{
			var_0C thread start_electricity_damage();
		}

		var_05 start_electricity_fx();
		var_05 start_electricity_sound();
		var_07 = waittilltimeorroundend(param_02 / 4);
		foreach(var_0C in var_05.damage_triggers)
		{
			var_0C stop_electricity_damage();
		}

		var_05 stop_electricity_fx();
		var_05 stop_electricity_sound();
		var_05.enabled = 0;
		if(!var_07)
		{
			return;
		}
	}
}

//Function Number: 53
start_electricity_damage()
{
	self endon("cooldown");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(isplayer(var_00))
		{
			if(isdefined(var_00.nextelectricitytrapdamagetime) && var_00.nextelectricitytrapdamagetime > gettime())
			{
				continue;
			}

			var_00.nextelectricitytrapdamagetime = gettime() + 1000;
			var_00 dodamage(17,var_00.origin,undefined,undefined,"MOD_TRIGGER_HURT");
		}
	}
}

//Function Number: 54
stop_electricity_damage()
{
	self notify("cooldown");
}

//Function Number: 55
start_electricity_warning_fx()
{
	foreach(var_01 in self.fx_structs)
	{
		var_01.fx = spawnfx(common_scripts\utility::getfx("trap_electric_floor_shock_warning"),var_01.origin,anglestoforward(var_01.angles),anglestoup(var_01.angles));
		triggerfx(var_01.fx);
	}
}

//Function Number: 56
start_electricity_fx()
{
	foreach(var_01 in self.fx_structs)
	{
		var_01.fx = spawnfx(common_scripts\utility::getfx("trap_electric_floor_shock_active"),var_01.origin,anglestoforward(var_01.angles),anglestoup(var_01.angles));
		triggerfx(var_01.fx);
	}
}

//Function Number: 57
stop_electricity_fx()
{
	foreach(var_01 in self.fx_structs)
	{
		var_01.fx delete();
	}
}

//Function Number: 58
start_electricity_sound()
{
	self.electricity_sound = spawn("script_origin",self.origin);
	playsoundatpos(self.electricity_sound.origin,"electric_floor_start");
	self.electricity_sound playloopsound("electric_floor_loop");
}

//Function Number: 59
stop_electricity_sound()
{
	playsoundatpos(self.electricity_sound.origin,"electric_floor_stop");
	self.electricity_sound scalevolume(0,0.25);
	wait(0.25);
	self.electricity_sound stoploopsound();
	wait 0.05;
	self.electricity_sound delete();
}

//Function Number: 60
gastrap_init()
{
	var_00 = getentarray("boss_oz_gas","targetname");
	foreach(var_02 in var_00)
	{
		var_02.enabled = 0;
	}

	return var_00;
}

//Function Number: 61
gastrap_istrapactive(param_00)
{
	foreach(var_02 in param_00.gas)
	{
		if(var_02.enabled)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 62
gastrap_canruntrap(param_00)
{
	return !gastrap_istrapactive(param_00);
}

//Function Number: 63
gastrap_runtrap(param_00,param_01,param_02,param_03)
{
	foreach(var_05 in param_00.gas)
	{
		var_05 thread start_gas(param_01,param_02);
	}

	if(!isdefined(param_03))
	{
		level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("gas",0);
	}
}

//Function Number: 64
gastrap_gettriggers(param_00)
{
	return param_00.gas;
}

//Function Number: 65
start_gas(param_00,param_01)
{
	self.enabled = 1;
	start_gas_fx();
	var_02 = waittilltimeorroundend(param_00);
	if(var_02)
	{
		childthread start_gas_damage();
		waittilltimeorroundend(param_01);
	}

	stop_gas_fx();
	self notify("cooldown");
	self.enabled = 0;
}

//Function Number: 66
start_gas_fx()
{
	activatepersistentclientexploder(90);
	playsoundatpos((0,0,0),"zom_boss_gas_trap_on");
}

//Function Number: 67
stop_gas_fx()
{
	stopclientexploder(90);
	playsoundatpos((0,0,0),"zom_boss_gas_trap_off");
}

//Function Number: 68
start_gas_damage()
{
	self endon("cooldown");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(isplayer(var_00))
		{
			if(isdefined(var_00.nextgastrapdamagetime) && var_00.nextgastrapdamagetime > gettime())
			{
				continue;
			}

			var_00.nextgastrapdamagetime = gettime() + 2000;
			if(!var_00 maps\mp\_utility::isjuggernaut() && !maps\mp\zombies\_util::isplayerinlaststand(var_00))
			{
				if(!maps\mp\zombies\_util::isplayerinfected(var_00) && !var_00 isgod())
				{
					var_00 thread maps\mp\zombies\_zombies_laststand::hostzombielaststand();
					var_00.lastinfectdamagetime = gettime();
					continue;
				}

				var_00 dodamage(50,var_00.origin,undefined,undefined,"MOD_TRIGGER_HURT");
			}
		}
	}
}

//Function Number: 69
zombietrap_canruntrap(param_00)
{
	return 1;
}

//Function Number: 70
zombietrap_runtrap(param_00)
{
	var_01 = getarraykeys(level.special_mutators);
	var_01[var_01.size] = "zombie_dog";
	var_01[var_01.size] = "zombie_host";
	level.nextbosswavezombietype = common_scripts\utility::random(var_01);
	var_02["limitedSpawns"] = 1;
	var_02["forceSpawnDelay"] = 1;
	if(level.nextbosswavezombietype == "zombie_dog" || level.nextbosswavezombietype == "zombie_host")
	{
		var_02["overrideSpawnType"] = level.nextbosswavezombietype;
		level childthread maps\mp\zombies\zombies_spawn_manager::spawnzombies(zombietrap_getnumzombiestospawn(),0.05,var_02);
	}
	else
	{
		var_02["mutatorFunc"] = ::zombietrap_applymutator;
		level childthread maps\mp\zombies\zombies_spawn_manager::spawnzombies(zombietrap_getnumzombiestospawn(),0.05,var_02);
	}

	if(level.nextbosswavezombietype == "zombie_dog")
	{
		level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("dog",0);
		return;
	}

	if(level.nextbosswavezombietype == "zombie_host")
	{
		level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("host",0);
		return;
	}

	if(issubstr(level.nextbosswavezombietype,"combo"))
	{
		level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("mut",0);
		return;
	}

	level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("zomb",0);
}

//Function Number: 71
zombietrap_applymutator(param_00)
{
	param_00 thread maps\mp\zombies\_mutators::mutator_apply("exo");
	param_00 thread maps\mp\zombies\_mutators::mutator_apply(level.nextbosswavezombietype);
}

//Function Number: 72
zombietrap_getnumzombiestospawn()
{
	var_00 = maps\mp\zombies\zombie_boss_oz_stage1::getstage1phase();
	var_01 = 1;
	if(var_00 == 2)
	{
		var_01 = 2;
	}
	else if(var_00 == 3)
	{
		var_01 = 3;
	}

	return int(var_01 * maps\mp\zombies\_util::getnumplayers());
}