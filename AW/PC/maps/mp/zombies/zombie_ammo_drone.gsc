/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\zombie_ammo_drone.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 45
 * Decompile Time: 895 ms
 * Timestamp: 4/22/2024 2:14:53 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["ammo_drone_drops_credits"] = loadfx("vfx/props/dlc_cash_drone_drop");
	level._effect["ammo_drone_drops_ammo"] = loadfx("vfx/shelleject/dlc_drone_drop_shell_eject_loop");
	level._effect["ammo_drone_thruster"] = loadfx("vfx/vehicle/dlc_drone_thrusters_small");
	level._effect["ammo_drone_drops_explode"] = loadfx("vfx/sparks/welding_sparks_a");
	level._effect["ammo_drone_explode"] = loadfx("vfx/explosion/tracking_drone_explosion");
	level thread findammodronespawnlocations();
	level thread roundlogic();
}

//Function Number: 2
findammodronespawnlocations()
{
	while(!isdefined(level.zone_data))
	{
		wait 0.05;
	}

	while(!isdefined(level.closetpathnodescalculated) || !level.closetpathnodescalculated)
	{
		wait 0.05;
	}

	foreach(var_01 in level.zone_data.zones)
	{
		if(!isdefined(var_01.volumes))
		{
			continue;
		}

		if(isdefined(level.ammodroneillegalzones))
		{
			if(common_scripts\utility::array_contains(level.ammodroneillegalzones,var_01.zone_name))
			{
				continue;
			}
		}

		var_02 = var_01.volumes[randomint(var_01.volumes.size)];
		var_03 = getnodesintrigger(var_02);
		if(!isdefined(var_01.ammodronespawnnodes))
		{
			var_01.ammodronespawnnodes = [];
		}

		foreach(var_05 in var_03)
		{
			if(!var_05 nodeisdisconnected() && isdefined(var_05.zombieszone))
			{
				var_01.ammodronespawnnodes[var_01.ammodronespawnnodes.size] = var_05;
			}
		}

		if(!isdefined(var_01.ammodroneleavenodes))
		{
			var_01.ammodroneleavenodes = [];
		}

		foreach(var_05 in var_03)
		{
			if(nodegetremotemissilename(var_05) != "none")
			{
				var_01.ammodroneleavenodes[var_01.ammodroneleavenodes.size] = var_05;
			}
		}
	}
}

//Function Number: 3
roundlogic()
{
	var_00 = randomintrange(3,5);
	level.ammodroneactive = 0;
	for(;;)
	{
		level waittill("zombie_wave_started");
		if(level.wavecounter >= var_00 && !atvehiclelimit())
		{
			var_01 = startammodrone();
			if(var_01)
			{
				var_00 = level.wavecounter + randomintrange(3,5);
			}
		}
	}
}

//Function Number: 4
atvehiclelimit()
{
	return maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed();
}

//Function Number: 5
startammodrone(param_00,param_01,param_02,param_03)
{
	level.ammodroneactive = 1;
	if(!isdefined(level.numammodronesencountered))
	{
		level.numammodronesencountered = 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = getstartzone();
	}

	if(!isdefined(param_01))
	{
		param_01 = param_00.ammodronespawnnodes[randomint(param_00.ammodronespawnnodes.size)];
	}

	maps\mp\_utility::incrementfauxvehiclecount();
	level.numammodronesencountered++;
	level.ammodrone = spawnammodrone(param_01.origin,(0,0,0));
	if(!isdefined(level.ammodrone))
	{
		maps\mp\_utility::decrementfauxvehiclecount();
		level.numammodronesencountered--;
		return 0;
	}

	if(isdefined(level.players[0]))
	{
		level.players[0] thread maps\mp\_matchdata::loggameevent("zm_tr_drone_spawn",param_01.origin);
	}

	level.ammodrone.startnode = param_01;
	level.ammodrone.startzone = param_00;
	level.ammodrone.linegunignore = 1;
	level notify("zombie_ammo_drone_spawn",level.ammodrone,param_00,param_01);
	var_04 = waittillactivate(level.ammodrone,param_00);
	if(isdefined(var_04))
	{
		var_04 playerspottreasuredrone();
	}

	var_05 = getdestinationzone(param_00);
	var_06 = getdestinationnode(var_05,param_01);
	if(isdefined(param_02))
	{
		var_05 = param_02;
	}

	if(isdefined(param_03))
	{
		var_06 = param_03;
	}

	level.ammodrone.endnode = var_06;
	level.ammodrone.endzone = var_05;
	if(isdefined(level.players[0]))
	{
		level.players[0] thread maps\mp\_matchdata::loggameevent("zm_tr_drone_active",param_01.origin);
	}

	level notify("zombie_ammo_drone_activate",level.ammodrone,var_05,var_06);
	droneactivate(level.ammodrone,var_05,var_06);
	level.ammodroneactive = 0;
	level.ammodrone = undefined;
	return 1;
}

//Function Number: 6
getstartzone()
{
	var_00 = [];
	var_01 = [];
	foreach(var_03 in level.zone_data.zones)
	{
		if(isdefined(var_03.ammodronespawnnodes) && isdefined(var_03.ammodroneleavenodes))
		{
			var_00[var_00.size] = var_03;
			if(var_03.ammodronespawnnodes.size > 0 && var_03.ammodroneleavenodes.size == 0)
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	var_05 = [];
	foreach(var_03 in var_01)
	{
		if(!maps\mp\zombies\_zombies_zone_manager::isplayerinzone(var_03.zone_name))
		{
			var_05[var_05.size] = var_03;
		}
	}

	var_08 = undefined;
	if(var_05.size > 0)
	{
		var_08 = var_05[randomint(var_05.size)];
	}
	else if(var_01.size > 0)
	{
		var_08 = var_01[randomint(var_01.size)];
	}
	else
	{
		var_08 = common_scripts\utility::random(var_00);
	}

	return var_08;
}

//Function Number: 7
getdestinationzone(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.zone_data.zones)
	{
		if(var_04.zone_name != param_00.zone_name && !isdefined(param_01) || var_04.zone_name != param_01.zone_name && maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_04.zone_name) && isdefined(var_04.ammodroneleavenodes) && var_04.ammodroneleavenodes.size > 0)
		{
			var_02[var_02.size] = var_04;
		}
	}

	var_06 = [];
	foreach(var_04 in var_02)
	{
		if(!maps\mp\zombies\_zombies_zone_manager::isplayerinzone(var_04.zone_name))
		{
			var_06[var_06.size] = var_04;
		}
	}

	var_09 = undefined;
	if(var_06.size > 0)
	{
		var_09 = var_06[randomint(var_06.size)];
	}
	else if(var_02.size > 0)
	{
		var_09 = var_02[randomint(var_02.size)];
	}
	else
	{
		var_09 = level.zone_data.zones[randomint(level.zone_data.zones.size)];
	}

	return var_09;
}

//Function Number: 8
getdestinationnode(param_00,param_01)
{
	var_02 = 90000;
	var_03 = -1;
	var_04 = param_00.ammodroneleavenodes[randomint(param_00.ammodroneleavenodes.size)];
	var_05 = distancesquared(var_04.origin,param_01.origin);
	if(var_05 < var_02)
	{
		foreach(var_07 in param_00.ammodroneleavenodes)
		{
			var_05 = distancesquared(param_01.origin,var_07.origin);
			if(var_05 > var_03)
			{
				var_03 = var_05;
				var_04 = var_07;
			}
		}
	}

	if(!isdefined(var_04))
	{
		return param_00.ammodroneleavenodes[randomint(param_00.ammodroneleavenodes.size)];
	}

	return var_04;
}

//Function Number: 9
spawnammodrone(param_00,param_01)
{
	var_02 = getactiveplayer();
	var_03 = spawnhelicopter(var_02,param_00,(0,0,0),"orbital_carepackage_drone_mp","vehicle_treasure_drone_01_ai");
	if(!isdefined(var_03))
	{
		return undefined;
	}

	var_03.owner = var_02;
	var_03.team = level.enemyteam;
	var_03 vehicle_turnengineoff();
	var_03 thread trackpreviousorigin();
	setupdamagecallback(var_03);
	playfx(common_scripts\utility::getfx("teleport_post_fx"),param_00);
	return var_03;
}

//Function Number: 10
trackpreviousorigin()
{
	self endon("death");
	for(;;)
	{
		waittillframeend;
		self.prevorigin = self.origin;
		wait 0.05;
	}
}

//Function Number: 11
setupdamagecallback(param_00)
{
	param_00.health = getdronehealth();
	param_00.maxhealth = param_00.health;
	param_00 setcandamage(1);
	param_00.damagecallback = ::dronehandledamagecallback;
}

//Function Number: 12
getdronehealth()
{
	var_00 = 2;
	if(level.players.size > 2)
	{
		var_00 = 3;
	}

	var_01 = 1500 + level.wavecounter - 1 * 200 * var_00;
	return var_01;
}

//Function Number: 13
disabledamagecallback(param_00)
{
	param_00 setcandamage(0);
	param_00.damagecallback = undefined;
}

//Function Number: 14
dronehandledamagecallback(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!maps\mp\zombies\_zombies_zone_manager::iszoneenabled(self.startzone.zone_name))
	{
		return;
	}

	var_0C = dronemodifydamage(param_01,param_05,param_04,param_02);
	self.health = self.health - var_0C;
	self notify("droneDamaged",var_0C);
	param_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("ammo_drone");
	thread dronedodamageoutline();
	if(self.health <= 0)
	{
		var_0D = param_01;
		if(!isplayer(var_0D))
		{
			var_0D = level.players[0];
		}

		if(isdefined(var_0D))
		{
			var_0D thread maps\mp\_matchdata::loggameevent("zm_tr_drone_kill",self.origin);
		}

		if(isdefined(param_01) && isplayer(param_01) && !maps\mp\zombies\_util::is_true(self.skipplayervo))
		{
			param_01 thread playerdestroytreasuredrone();
		}

		disabledamagecallback(self);
		self notify("disabled",self.origin);
	}

	return 0;
}

//Function Number: 15
dronedodamageoutline()
{
	self notify("droneDoDamageOutline");
	self endon("droneDoDamageOutline");
	self endon("disabled");
	self hudoutlineenable(5,0);
	wait(1);
	self hudoutlinedisable();
}

//Function Number: 16
dronemodifydamage(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	var_04 = maps\mp\gametypes\_damage::handleempdamage(param_01,param_02,var_04,param_00);
	var_04 = maps\mp\gametypes\_damage::handlemissiledamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handlegrenadedamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handleapdamage(param_01,param_02,var_04,param_00);
	if(issubstr(param_01,"iw5_fusionzm"))
	{
		var_04 = int(var_04 * 0.4);
	}
	else if(issubstr(param_01,"iw5_rhinozm"))
	{
		var_04 = int(var_04 * 0.4);
	}
	else if(issubstr(param_01,"iw5_linegunzm"))
	{
		var_04 = int(var_04 * 0.4);
	}

	return var_04;
}

//Function Number: 17
waittillactivate(param_00,param_01)
{
	param_00 endon("droneDamaged");
	level endon("activateAmmoDrone");
	var_02 = undefined;
	for(;;)
	{
		wait 0.05;
		if(!maps\mp\zombies\_zombies_zone_manager::iszoneenabled(param_01.zone_name))
		{
			continue;
		}

		var_03 = maps\mp\zombies\_zombies_zone_manager::getplayersinzone(param_01.zone_name,1);
		if(var_03.size == 0)
		{
			continue;
		}

		var_02 = getplayerclosetodrone(param_00,var_03);
		if(isdefined(var_02))
		{
			break;
		}

		var_02 = getplayerlookingatdronetoolong(param_00,var_03);
		if(isdefined(var_02))
		{
			break;
		}
	}

	foreach(var_05 in level.players)
	{
		var_05.lookingatammodrone = undefined;
	}

	return var_02;
}

//Function Number: 18
getplayerclosetodrone(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		var_04 = distancesquared(param_00.origin,var_03.origin);
		if(var_04 < 160000)
		{
			return var_03;
		}
	}
}

//Function Number: 19
getplayerlookingatdronetoolong(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		if(!isdefined(var_03.lookingatammodrone))
		{
			var_03.lookingatammodrone = [];
		}

		if(!common_scripts\utility::array_contains(param_01,var_03))
		{
			var_03.lookingatammodrone[param_00 getentitynumber()] = undefined;
			continue;
		}

		var_04 = anglestoforward(var_03 getplayerangles());
		var_05 = vectornormalize(param_00.origin - var_03.origin);
		var_06 = vectordot(var_04,var_05);
		if(var_06 < 0.7)
		{
			var_03.lookingatammodrone[param_00 getentitynumber()] = undefined;
			continue;
		}

		var_07 = var_03 geteye();
		var_08 = param_00.origin + (0,0,40);
		var_09 = bullettrace(var_07,var_08,0,param_00,0,0,0,0,0,0,0);
		var_0A = var_09["entity"];
		if(var_09["fraction"] != 1 && !isdefined(var_0A) || var_0A != param_00)
		{
			var_03.lookingatammodrone[param_00 getentitynumber()] = undefined;
			continue;
		}

		if(!isdefined(var_03.lookingatammodrone[param_00 getentitynumber()]))
		{
			var_03.lookingatammodrone[param_00 getentitynumber()] = gettime();
			continue;
		}

		var_0B = gettime() - var_03.lookingatammodrone[param_00 getentitynumber()];
		if(var_0B > 1500)
		{
			return var_03;
		}
	}
}

//Function Number: 20
getdronespeed(param_00)
{
	if(isdefined(param_00.speedoverride))
	{
		return param_00.speedoverride;
	}

	return 9;
}

//Function Number: 21
droneactivate(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	setupdrone(param_00);
	param_00.active = 1;
	param_00 thread drone_thrusterfx();
	param_00 thread dronebeep();
	if(param_03)
	{
		param_00 thread dronehandledrops();
		param_00 thread dronehandlepickup();
	}

	param_00 setvehgoalpos(param_00.origin + (0,0,10));
	param_00.currentspeed = getdronespeed(param_00);
	param_00 vehicle_setspeed(param_00.currentspeed,10,10);
	param_00 sethoverparams(30,5,5);
	param_00 setmaxpitchroll(15,15);
	wait(0.5);
	var_04 = param_00 dronepathtogoal(param_01,param_02);
	if(isdefined(param_00))
	{
		param_00 drone_stopthrustereffects();
	}

	maps\mp\zombies\_util::waitnetworkframe();
	if(isdefined(param_00))
	{
		param_00 droneexplode();
	}

	return var_04;
}

//Function Number: 22
droneexplode()
{
	self notify("explode");
	playfx(common_scripts\utility::getfx("ammo_drone_explode"),self.origin);
	playsoundatpos(self.origin,"treasure_drone_exp");
	playsoundatpos(self.origin,"treasure_drone_exp_credits");
	maps\mp\_utility::decrementfauxvehiclecount();
	self delete();
}

//Function Number: 23
dronehandledrops()
{
	self endon("stopSpeedIncreasing");
	self endon("disabled");
	var_00 = min(level.numammodronesencountered,3);
	var_01 = self.maxhealth / var_00 + 1;
	var_02 = self.maxhealth - var_01;
	var_03 = self.origin;
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		if(self.health <= var_02)
		{
			var_04 = self.origin;
			thread dronedodrop(var_04);
			var_02 = var_02 - var_01;
			if(var_02 <= 0)
			{
				return;
			}
		}

		wait 0.05;
	}
}

//Function Number: 24
dronedodrop(param_00)
{
	var_01 = getnextdroptype();
	var_02 = "";
	var_03 = 0;
	var_04 = 0;
	if(var_01 == "credits")
	{
		var_02 = "zark_money_01_obj";
		var_03 = common_scripts\utility::getfx("ammo_drone_drops_credits");
		var_04 = 1000;
	}
	else
	{
		var_02 = "zark_grenadebag_01_obj";
		var_03 = common_scripts\utility::getfx("ammo_drone_drops_ammo");
		var_04 = 20;
	}

	var_05 = param_00 + (0,0,40);
	var_06 = (randomfloatrange(-1 * var_04,var_04),randomfloatrange(-1 * var_04,var_04),var_04);
	var_07 = vectornormalize(var_06);
	var_08 = spawn("script_model",var_05);
	var_08 setmodel(var_02);
	var_08 physicslaunchserver(var_05,var_06);
	var_08 hudoutlineenable(3,0);
	playfx(common_scripts\utility::getfx("ammo_drone_drops_explode"),var_05 + (0,0,5));
	var_09 = var_08 common_scripts\utility::waittill_notify_or_timeout_return("physics_finished",5);
	if(!isdefined(var_09) || var_09 != "timeout")
	{
		var_0A = spawnfx(var_03,var_08.origin + (0,0,10),(0,0,1),(1,0,0));
		triggerfx(var_0A);
		var_08 dropdobonus(var_01);
		var_0A delete();
	}

	var_08 delete();
}

//Function Number: 25
getnextdroptype()
{
	if(!isdefined(level.ammodronedropschedule))
	{
		level.ammodronedropschedule = [];
		level.ammodronedropschedule[level.ammodronedropschedule.size] = "ammo";
		level.ammodronedropschedule[level.ammodronedropschedule.size] = "credits";
		level.ammodronedropschedule[level.ammodronedropschedule.size] = "ammo";
		level.ammodronedropschedule[level.ammodronedropschedule.size] = "credits";
		level.ammodronedropschedule = common_scripts\utility::array_randomize(level.ammodronedropschedule);
		level.ammodronedropindex = 0;
	}

	if(level.ammodronedropindex >= level.ammodronedropschedule.size)
	{
		level.ammodronedropschedule = common_scripts\utility::array_randomize(level.ammodronedropschedule);
		level.ammodronedropindex = 0;
	}

	var_00 = level.ammodronedropschedule[level.ammodronedropindex];
	level.ammodronedropindex++;
	return var_00;
}

//Function Number: 26
dropdobonus(param_00)
{
	var_01 = 10000;
	var_02 = 10000;
	var_03 = gettime() + var_01;
	while(gettime() < var_03)
	{
		foreach(var_05 in level.players)
		{
			var_06 = distancesquared(var_05.origin,self.origin);
			if(var_06 < var_02)
			{
				if(param_00 == "ammo")
				{
					var_05 thread playergiveammo();
					continue;
				}

				if(param_00 == "credits")
				{
					var_05 thread playergivecredits();
				}
			}
		}

		wait(0.5);
	}
}

//Function Number: 27
playergiveammo()
{
	self endon("death");
	self endon("disconnect");
	var_00 = self getcurrentprimaryweapon();
	if(!isdefined(var_00) || var_00 == "none" || maps\mp\zombies\_util::isrippedturretweapon(var_00) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_00) || maps\mp\zombies\_util::iszombieequipment(var_00))
	{
		return;
	}

	if(issubstr(var_00,"em1"))
	{
		waittillframeend;
		var_01 = maps\mp\zombies\_util::playergetem1ammo();
		var_02 = maps\mp\gametypes\zombies::getem1maxammo();
		if(var_01 >= var_02)
		{
			return;
		}

		var_01 = getnewammoamount(var_01,var_02);
		maps\mp\zombies\_util::playerrecordem1ammo(var_01);
		maps\mp\gametypes\zombies::playerupdateem1omnvar();
		return;
	}

	var_01 = self setweaponammostock(var_02);
	var_02 = weaponmaxammo(var_01);
	if(var_01 < var_02)
	{
		var_01 = getnewammoamount(var_01,var_02);
		self setweaponammostock(var_00,var_01);
		return;
	}

	var_01 = self getweaponammoclip(var_00,"right");
	var_02 = weaponclipsize(var_00);
	if(var_01 < var_02)
	{
		var_01 = getnewammoamount(var_01,var_02);
		self setweaponammoclip(var_00,var_01,"right");
	}

	if(issubstr(var_00,"akimbo"))
	{
		var_01 = self getweaponammoclip(var_00,"left");
		if(var_01 < var_02)
		{
			var_01 = getnewammoamount(var_01,var_02);
			self setweaponammoclip(var_00,var_01,"left");
			return;
		}
	}
}

//Function Number: 28
getnewammoamount(param_00,param_01)
{
	var_02 = 0.02;
	var_03 = int(max(1,param_01 * var_02));
	if(param_00 + var_03 <= param_01)
	{
		param_00 = param_00 + var_03;
	}
	else if(param_00 < param_01)
	{
		param_00 = param_01;
	}

	return param_00;
}

//Function Number: 29
playergivecredits()
{
	var_00 = 20;
	maps\mp\gametypes\zombies::givepointsforevent("treasureDrone",var_00,0);
}

//Function Number: 30
dronehandlespeed()
{
	self endon("stopSpeedIncreasing");
	self endon("disabled");
	for(;;)
	{
		self waittill("droneDamaged",var_00);
		self.currentspeed = min(self.currentspeed + 1,30);
		self vehicle_setspeed(self.currentspeed,10,10);
	}
}

//Function Number: 31
dronebeep()
{
	self playloopsound("treasure_drone_vox_lp");
	common_scripts\utility::waittill_any("disabled","stopBeeping");
	self stoploopsound();
}

//Function Number: 32
dronehandlepickup()
{
	self endon("explode");
	var_00 = maps\mp\gametypes\zombies::selectnextvalidpickup();
	var_01 = level.pickup[var_00]["fx"];
	var_02 = level.pickup[var_00]["model"];
	var_03 = level.pickup[var_00]["outline"];
	var_04 = undefined;
	if(isdefined(var_01))
	{
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx(var_01),self,"tag_trophy");
	}
	else
	{
		var_04 = spawn("script_model",self.origin);
		var_04 setmodel(var_02);
		var_04 hudoutlineenable(2,0);
		var_04 linkto(self,"tag_origin",(0,0,60),(0,0,0));
		thread dronecleanuppickupmodel(var_04);
	}

	self waittill("disabled",var_05);
	if(isdefined(var_01))
	{
		maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx(var_01),self,"tag_trophy");
	}

	if(isdefined(self.lastgroundposition))
	{
		var_05 = self.lastgroundposition;
	}

	if(!isdefined(var_05))
	{
		var_05 = self.origin;
	}

	maps\mp\gametypes\zombies::createpickup(var_00,var_05,"Ammo Drone");
}

//Function Number: 33
dronecleanuppickupmodel(param_00)
{
	common_scripts\utility::waittill_any("disabled","explode");
	param_00 delete();
}

//Function Number: 34
getactiveplayer()
{
	foreach(var_01 in level.players)
	{
		if(var_01.sessionstate == "spectator")
		{
			continue;
		}

		if(isalive(var_01))
		{
			return var_01;
		}
	}

	return level.players[0];
}

//Function Number: 35
dronepathtogoal(param_00,param_01)
{
	self endon("disabled");
	var_02 = 22500;
	var_03 = gettime();
	self.goalent = spawn("script_origin",param_01.origin);
	self.goalent.health = 1;
	self.goalent.maxhealth = 1;
	thread dronecleanupgoalent();
	self setdronegoalpos(self.goalent,(0,0,30));
	for(;;)
	{
		var_04 = distancesquared(self.origin,self.goalent.origin + (0,0,30));
		if(var_04 < var_02)
		{
			break;
		}

		wait 0.05;
	}

	if(!nodehasremotemissileset(param_01))
	{
		return 1;
	}

	self.lastgroundposition = self.origin;
	var_05 = maps\mp\killstreaks\_aerial_utility::getentorstructarray("remoteMissileSpawn","targetname");
	var_06 = maps\mp\killstreaks\_orbital_util::nodegetremotemissileorigin(param_01,var_05);
	self setvehgoalpos(var_06,0);
	thread droneincreaseexitspeed();
	common_scripts\utility::waittill_any("near_goal","goal");
	if(isdefined(self.goalent))
	{
		self.goalent delete();
	}

	return 1;
}

//Function Number: 36
dronecleanupgoalent()
{
	common_scripts\utility::waittill_any("disabled","death");
	if(isdefined(self.goalent))
	{
		self.goalent delete();
	}
}

//Function Number: 37
droneincreaseexitspeed()
{
	self endon("death");
	wait(7);
	self notify("stopSpeedIncreasing");
	self notify("stopBeeping");
	disabledamagecallback(self);
	self vehicle_setspeed(100,10,10);
	level thread dotreasuredroneleavevo(self);
}

//Function Number: 38
drone_thrusterfx()
{
	self endon("death");
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("ammo_drone_thruster"),self,"j_thruster_fl");
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("ammo_drone_thruster"),self,"j_thruster_fr");
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("ammo_drone_thruster"),self,"j_thruster_kl");
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("ammo_drone_thruster"),self,"j_thruster_kr");
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("ocp_exhaust"),self,"tag_fx");
	for(;;)
	{
		level waittill("connected",var_00);
		thread drone_thrusterplayerconnected(var_00);
	}
}

//Function Number: 39
drone_thrusterplayerconnected(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	param_00 waittill("spawned_player");
	if(isdefined(param_00) && isdefined(self))
	{
		drone_thrusterplayer(param_00);
	}
}

//Function Number: 40
drone_thrusterplayer(param_00)
{
	maps\mp\zombies\_util::playfxontagforclientnetwork(common_scripts\utility::getfx("ammo_drone_thruster"),self,"j_thruster_fl",param_00);
	maps\mp\zombies\_util::playfxontagforclientnetwork(common_scripts\utility::getfx("ammo_drone_thruster"),self,"j_thruster_fr",param_00);
	maps\mp\zombies\_util::playfxontagforclientnetwork(common_scripts\utility::getfx("ammo_drone_thruster"),self,"j_thruster_kl",param_00);
	maps\mp\zombies\_util::playfxontagforclientnetwork(common_scripts\utility::getfx("ammo_drone_thruster"),self,"j_thruster_kr",param_00);
	maps\mp\zombies\_util::playfxontagforclientnetwork(common_scripts\utility::getfx("ocp_exhaust"),self,"tag_fx",param_00);
}

//Function Number: 41
drone_stopthrustereffects()
{
	maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("ammo_drone_thruster"),self,"j_thruster_fl");
	maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("ammo_drone_thruster"),self,"j_thruster_fr");
	maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("ammo_drone_thruster"),self,"j_thruster_kl");
	maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("ammo_drone_thruster"),self,"j_thruster_kr");
	maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("ocp_exhaust"),self,"tag_fx");
}

//Function Number: 42
setupdrone(param_00)
{
	param_00 makevehiclenotcollidewithplayers(1);
	param_00.speed = getdronespeed(param_00);
	param_00.followspeed = param_00.speed;
	param_00 vehicle_setspeed(param_00.speed,10,10);
	param_00 setyawspeed(120,90);
	param_00 setneargoalnotifydist(64);
	param_00 sethoverparams(4,5,5);
	param_00 vehicle_turnengineon();
	var_01 = 45;
	var_02 = 45;
	param_00 setmaxpitchroll(var_01,var_02);
	var_03 = 10000;
	var_04 = 150;
	param_00.attractor = missile_createattractorent(param_00,var_03,var_04);
	param_00.stunned = 0;
}

//Function Number: 43
playerspottreasuredrone()
{
	maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","td_spot");
}

//Function Number: 44
playerdestroytreasuredrone()
{
	self endon("disconnect");
	wait(2);
	maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","td_win");
}

//Function Number: 45
dotreasuredroneleavevo(param_00)
{
	if(maps\mp\zombies\_util::is_true(param_00.skipplayervo))
	{
		return;
	}

	var_01 = sortbydistance(level.players,param_00.origin);
	var_02 = undefined;
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(!maps\mp\zombies\_util::isplayerinlaststand(var_01[var_03]) && isalive(var_01[var_03]))
		{
			var_02 = var_01[var_03];
			break;
		}
	}

	if(isdefined(var_02))
	{
		var_04 = var_02 maps\mp\zombies\_zombies_zone_manager::getplayerzone();
		if(var_04 == param_00.endzone.zone_name)
		{
			var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","td_lose");
		}
	}
}