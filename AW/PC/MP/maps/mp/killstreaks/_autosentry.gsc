/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/killstreaks/_autosentry.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 56
 * Decompile Time: 873 ms
 * Timestamp: 10/27/2023 1:51:33 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(level.sentrytype))
	{
		level.sentrytype = [];
	}

	level.sentrytype["sentry_minigun"] = "sentry";
	level.sentrytype["sam_turret"] = "sam_turret";
	level.killstreakfuncs[level.sentrytype["sentry_minigun"]] = ::tryuseautosentry;
	level.killstreakfuncs[level.sentrytype["sam_turret"]] = ::tryusesam;
	if(!isdefined(level.sentrysettings))
	{
		level.sentrysettings = [];
	}

	level.sentrysettings["sentry_minigun"] = spawnstruct();
	level.sentrysettings["sentry_minigun"].health = 999999;
	level.sentrysettings["sentry_minigun"].maxhealth = 1000;
	level.sentrysettings["sentry_minigun"].burstmin = 20;
	level.sentrysettings["sentry_minigun"].burstmax = 120;
	level.sentrysettings["sentry_minigun"].pausemin = 0.15;
	level.sentrysettings["sentry_minigun"].pausemax = 0.35;
	level.sentrysettings["sentry_minigun"].sentrymodeon = "sentry";
	level.sentrysettings["sentry_minigun"].sentrymodeoff = "sentry_offline";
	level.sentrysettings["sentry_minigun"].timeout = 90;
	level.sentrysettings["sentry_minigun"].spinuptime = 0.05;
	level.sentrysettings["sentry_minigun"].overheattime = 8;
	level.sentrysettings["sentry_minigun"].cooldowntime = 0.1;
	level.sentrysettings["sentry_minigun"].fxtime = 0.3;
	level.sentrysettings["sentry_minigun"].streakname = "sentry";
	level.sentrysettings["sentry_minigun"].weaponinfo = "sentry_minigun_mp";
	level.sentrysettings["sentry_minigun"].modelbase = "sentry_minigun_weak";
	level.sentrysettings["sentry_minigun"].modelplacement = "sentry_minigun_weak_obj";
	level.sentrysettings["sentry_minigun"].modelplacementfailed = "sentry_minigun_weak_obj_red";
	level.sentrysettings["sentry_minigun"].modeldestroyed = "sentry_minigun_weak_destroyed";
	level.sentrysettings["sentry_minigun"].hintstring = &"SENTRY_PICKUP";
	level.sentrysettings["sentry_minigun"].headicon = 1;
	level.sentrysettings["sentry_minigun"].teamsplash = "used_sentry";
	level.sentrysettings["sentry_minigun"].shouldsplash = 0;
	level.sentrysettings["sentry_minigun"].vodestroyed = "sentry_destroyed";
	level.sentrysettings["sam_turret"] = spawnstruct();
	level.sentrysettings["sam_turret"].health = 999999;
	level.sentrysettings["sam_turret"].maxhealth = 1000;
	level.sentrysettings["sam_turret"].burstmin = 20;
	level.sentrysettings["sam_turret"].burstmax = 120;
	level.sentrysettings["sam_turret"].pausemin = 0.15;
	level.sentrysettings["sam_turret"].pausemax = 0.35;
	level.sentrysettings["sam_turret"].sentrymodeon = "sentry_manual";
	level.sentrysettings["sam_turret"].sentrymodeoff = "sentry_offline";
	level.sentrysettings["sam_turret"].timeout = 90;
	level.sentrysettings["sam_turret"].spinuptime = 0.05;
	level.sentrysettings["sam_turret"].overheattime = 8;
	level.sentrysettings["sam_turret"].cooldowntime = 0.1;
	level.sentrysettings["sam_turret"].fxtime = 0.3;
	level.sentrysettings["sam_turret"].streakname = "sam_turret";
	level.sentrysettings["sam_turret"].weaponinfo = "sam_mp";
	level.sentrysettings["sam_turret"].modelbase = "mp_sam_turret";
	level.sentrysettings["sam_turret"].modelplacement = "mp_sam_turret_placement";
	level.sentrysettings["sam_turret"].modelplacementfailed = "mp_sam_turret_placement_failed";
	level.sentrysettings["sam_turret"].modeldestroyed = "mp_sam_turret";
	level.sentrysettings["sam_turret"].hintstring = &"SENTRY_PICKUP";
	level.sentrysettings["sam_turret"].headicon = 1;
	level.sentrysettings["sam_turret"].teamsplash = "used_sam_turret";
	level.sentrysettings["sam_turret"].shouldsplash = 0;
	level.sentrysettings["sam_turret"].vodestroyed = "sam_destroyed";
	level._effect["sentry_overheat_mp"] = loadfx("vfx/distortion/sentrygun_overheat");
	level._effect["sentry_explode_mp"] = loadfx("vfx/explosion/vehicle_pdrone_explosion");
	level._effect["sentry_smoke_mp"] = loadfx("vfx/smoke/vehicle_sentrygun_damaged_smoke");
	level._effect["sentry_stunned"] = loadfx("vfx/sparks/direct_hack_stun");
}

//Function Number: 2
tryuseautosentry(param_00,param_01)
{
	var_02 = givesentry("sentry_minigun");
	if(var_02)
	{
		maps\mp\_matchdata::logkillstreakevent(level.sentrysettings["sentry_minigun"].streakname,self.origin);
	}

	return var_02;
}

//Function Number: 3
tryusesam(param_00,param_01)
{
	var_02 = givesentry("sam_turret");
	if(var_02)
	{
		maps\mp\_matchdata::logkillstreakevent(level.sentrysettings["sam_turret"].streakname,self.origin);
	}

	return var_02;
}

//Function Number: 4
givesentry(param_00)
{
	if(!maps\mp\_utility::validateusestreak())
	{
		return 0;
	}

	self.last_sentry = param_00;
	var_01 = createsentryforplayer(param_00,self);
	removeperks();
	var_02 = setcarryingsentry(var_01,1);
	thread waitrestoreperks();
	self.iscarrying = 0;
	if(isdefined(var_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
setcarryingsentry(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	param_00 sentry_setcarried(self);
	common_scripts\utility::_disableweapon();
	if(!isai(self))
	{
		self notifyonplayercommand("place_sentry","+attack");
		self notifyonplayercommand("place_sentry","+attack_akimbo_accessible");
		self notifyonplayercommand("cancel_sentry","+actionslot 4");
		if(!level.console)
		{
			self notifyonplayercommand("cancel_sentry","+actionslot 5");
			self notifyonplayercommand("cancel_sentry","+actionslot 6");
			self notifyonplayercommand("cancel_sentry","+actionslot 7");
			self notifyonplayercommand("cancel_sentry","+actionslot 8");
		}
	}

	for(;;)
	{
		var_02 = common_scripts\utility::waittill_any_return("place_sentry","cancel_sentry","force_cancel_placement");
		if(var_02 == "cancel_sentry" || var_02 == "force_cancel_placement")
		{
			if(!param_01 && var_02 == "cancel_sentry")
			{
				continue;
			}

			if(level.console)
			{
				var_03 = maps\mp\_utility::getkillstreakweapon(level.sentrysettings[param_00.sentrytype].streakname);
				if(isdefined(self.killstreakindexweapon) && var_03 == maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname) && !self getweaponslistitems().size)
				{
					maps\mp\_utility::_giveweapon(var_03,0);
					maps\mp\_utility::_setactionslot(4,"weapon",var_03);
				}
			}

			param_00 sentry_setcancelled();
			common_scripts\utility::_enableweapon();
			return 0;
		}

		if(!param_00.canbeplaced)
		{
			continue;
		}

		param_00 sentry_setplaced();
		common_scripts\utility::_enableweapon();
		return 1;
	}
}

//Function Number: 6
removeweapons()
{
	if(self hasweapon("riotshield_mp"))
	{
		self.restoreweapon = "riotshield_mp";
		self takeweapon("riotshield_mp");
	}
}

//Function Number: 7
removeperks()
{
	if(maps\mp\_utility::_hasperk("specialty_explosivebullets"))
	{
		self.restoreperk = "specialty_explosivebullets";
		maps\mp\_utility::_unsetperk("specialty_explosivebullets");
	}
}

//Function Number: 8
restoreweapons()
{
	if(isdefined(self.restoreweapon))
	{
		maps\mp\_utility::_giveweapon(self.restoreweapon);
		self.restoreweapon = undefined;
	}
}

//Function Number: 9
restoreperks()
{
	if(isdefined(self.restoreperk))
	{
		maps\mp\_utility::giveperk(self.restoreperk,0);
		self.restoreperk = undefined;
	}
}

//Function Number: 10
waitrestoreperks()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	restoreperks();
}

//Function Number: 11
createsentryforplayer(param_00,param_01)
{
	var_02 = spawnturret("misc_turret",param_01.origin,level.sentrysettings[param_00].weaponinfo);
	var_02.angles = param_01.angles;
	var_02 sentry_initsentry(param_00,param_01);
	return var_02;
}

//Function Number: 12
sentry_initsentry(param_00,param_01)
{
	self.sentrytype = param_00;
	self.canbeplaced = 1;
	self setmodel(level.sentrysettings[self.sentrytype].modelbase);
	self.shouldsplash = 1;
	self setcandamage(1);
	switch(param_00)
	{
		case "sam_turret":
			break;

		default:
			break;
	}
}

//Function Number: 13
sentry_watchdisabled()
{
	self endon("carried");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		playfxontag(common_scripts\utility::getfx("sentry_stunned"),self,"tag_aim");
		self setdefaultdroppitch(40);
		self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
		wait(var_01);
		stopfxontag(common_scripts\utility::getfx("sentry_stunned"),self,"tag_aim");
		self setdefaultdroppitch(-89);
		self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
	}
}

//Function Number: 14
sentry_directhacked()
{
	self endon("death");
	level endon("game_ended");
	self.directhackduration = 0.25;
	if(isdefined(self.directhackendtime) && gettime() < self.directhackendtime)
	{
		self.directhackendtime = gettime() + self.directhackduration * 1000;
		return;
	}

	playfxontag(common_scripts\utility::getfx("sentry_stunned"),self,"tag_aim");
	self.directhackendtime = gettime() + self.directhackduration * 1000;
	self setdefaultdroppitch(40);
	self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
	for(;;)
	{
		if(gettime() > self.directhackendtime)
		{
			break;
		}

		wait(0.05);
	}

	self setdefaultdroppitch(-89);
	self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
	stopfxontag(common_scripts\utility::getfx("sentry_stunned"),self,"tag_aim");
}

//Function Number: 15
sentry_handledeath()
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	self setmodel(level.sentrysettings[self.sentrytype].modeldestroyed);
	sentry_setinactive();
	self setdefaultdroppitch(40);
	self setsentryowner(undefined);
	self setturretminimapvisible(0);
	if(isdefined(self.ownertrigger))
	{
		self.ownertrigger delete();
	}

	self playsound("sentry_explode");
	if(isdefined(self.inuseby))
	{
		playfxontag(common_scripts\utility::getfx("sentry_explode_mp"),self,"tag_origin");
		playfxontag(common_scripts\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
		self.inuseby.turret_overheat_bar maps\mp\gametypes\_hud_util::destroyelem();
		self.inuseby restoreperks();
		self.inuseby restoreweapons();
		self notify("deleting");
		wait(1);
		stopfxontag(common_scripts\utility::getfx("sentry_explode_mp"),self,"tag_origin");
		stopfxontag(common_scripts\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
	}
	else
	{
		playfxontag(common_scripts\utility::getfx("sentry_explode_mp"),self,"tag_aim");
		wait(1.5);
		self playsound("sentry_explode_smoke");
		var_00 = 8;
		while(var_00 > 0)
		{
			playfxontag(common_scripts\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
			wait(0.4);
			var_00 = var_00 - 0.4;
		}

		self notify("deleting");
	}

	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}

	self delete();
}

//Function Number: 16
sentry_handleuse()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!maps\mp\_utility::isreallyalive(var_00))
		{
			continue;
		}

		if(self.sentrytype == "sam_turret")
		{
			self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
		}

		var_00 setcarryingsentry(self,0);
	}
}

//Function Number: 17
turret_handlepickup(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	if(!isdefined(param_00.ownertrigger))
	{
		return;
	}

	var_01 = 0;
	for(;;)
	{
		if(isalive(self) && self istouching(param_00.ownertrigger) && !isdefined(param_00.inuseby) && !isdefined(param_00.carriedby) && self isonground())
		{
			if(self usebuttonpressed())
			{
				if(isdefined(self.using_remote_turret) && self.using_remote_turret)
				{
					continue;
				}

				var_01 = 0;
				while(self usebuttonpressed())
				{
					var_01 = var_01 + 0.05;
					wait(0.05);
				}

				if(var_01 >= 0.5)
				{
					continue;
				}

				var_01 = 0;
				while(!self usebuttonpressed() && var_01 < 0.5)
				{
					var_01 = var_01 + 0.05;
					wait(0.05);
				}

				if(var_01 >= 0.5)
				{
					continue;
				}

				if(!maps\mp\_utility::isreallyalive(self))
				{
					continue;
				}

				if(isdefined(self.using_remote_turret) && self.using_remote_turret)
				{
					continue;
				}

				param_00 setmode(level.sentrysettings[param_00.sentrytype].sentrymodeoff);
				thread setcarryingsentry(param_00,0);
				param_00.ownertrigger delete();
				return;
			}
		}

		wait(0.05);
	}
}

//Function Number: 18
turret_handleuse()
{
	self notify("turret_handluse");
	self endon("turret_handleuse");
	self endon("deleting");
	level endon("game_ended");
	self.forcedisable = 0;
	var_00 = (1,0.9,0.7);
	var_01 = (1,0.65,0);
	var_02 = (1,0.25,0);
	for(;;)
	{
		self waittill("trigger",var_03);
		if(isdefined(self.carriedby))
		{
			continue;
		}

		if(isdefined(self.inuseby))
		{
			continue;
		}

		if(!maps\mp\_utility::isreallyalive(var_03))
		{
			continue;
		}

		var_03 removeperks();
		var_03 removeweapons();
		self.inuseby = var_03;
		self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
		sentry_setowner(var_03);
		self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
		var_03 thread turret_shotmonitor(self);
		var_03.turret_overheat_bar = var_03 maps\mp\gametypes\_hud_util::createbar(var_00,100,6);
		var_03.turret_overheat_bar maps\mp\gametypes\_hud_util::setpoint("CENTER","BOTTOM",0,-70);
		var_03.turret_overheat_bar.alpha = 0.65;
		var_03.turret_overheat_bar.bar.alpha = 0.65;
		var_04 = 0;
		for(;;)
		{
			if(!maps\mp\_utility::isreallyalive(var_03))
			{
				self.inuseby = undefined;
				var_03.turret_overheat_bar maps\mp\gametypes\_hud_util::destroyelem();
				break;
			}

			if(!var_03 isusingturret())
			{
				self notify("player_dismount");
				self.inuseby = undefined;
				var_03.turret_overheat_bar maps\mp\gametypes\_hud_util::destroyelem();
				var_03 restoreperks();
				var_03 restoreweapons();
				self sethintstring(level.sentrysettings[self.sentrytype].hintstring);
				self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
				sentry_setowner(self.originalowner);
				self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
				break;
			}

			if(self.heatlevel >= level.sentrysettings[self.sentrytype].overheattime)
			{
				var_05 = 1;
			}
			else
			{
				var_05 = self.heatlevel / level.sentrysettings[self.sentrytype].overheattime;
			}

			var_03.turret_overheat_bar maps\mp\gametypes\_hud_util::updatebar(var_05);
			if(self.forcedisable || self.overheated)
			{
				self turretfiredisable();
				var_03.turret_overheat_bar.bar.color = var_02;
				var_04 = 0;
			}
			else
			{
				var_03.turret_overheat_bar.bar.color = var_00;
				self turretfireenable();
				var_04 = 0;
				self notify("not_overheated");
			}

			wait(0.05);
		}

		self setdefaultdroppitch(0);
	}
}

//Function Number: 19
sentry_handleownerdisconnect()
{
	self endon("death");
	level endon("game_ended");
	self notify("sentry_handleOwner");
	self endon("sentry_handleOwner");
	self.owner common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	self notify("death");
}

//Function Number: 20
sentry_setowner(param_00)
{
	self.owner = param_00;
	self setsentryowner(self.owner);
	self setturretminimapvisible(1,self.sentrytype);
	if(level.teambased)
	{
		self.team = self.owner.team;
		self setturretteam(self.team);
	}

	thread sentry_handleownerdisconnect();
}

//Function Number: 21
sentry_setplaced()
{
	self setmodel(level.sentrysettings[self.sentrytype].modelbase);
	if(self getmode() == "manual")
	{
		self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
	}

	self setsentrycarrier(undefined);
	self setcandamage(1);
	sentry_makesolid();
	self.carriedby forceusehintoff();
	self.carriedby = undefined;
	if(isdefined(self.owner))
	{
		self.owner.iscarrying = 0;
	}

	sentry_setactive();
	self playsound("sentry_gun_plant");
	self notify("placed");
}

//Function Number: 22
sentry_setcancelled()
{
	self.carriedby forceusehintoff();
	if(isdefined(self.owner))
	{
		self.owner.iscarrying = 0;
	}

	self delete();
}

//Function Number: 23
sentry_setcarried(param_00)
{
	if(isdefined(self.originalowner))
	{
	}
	else
	{
	}

	self setmodel(level.sentrysettings[self.sentrytype].modelplacement);
	self setsentrycarrier(param_00);
	self setcandamage(0);
	sentry_makenotsolid();
	self.carriedby = param_00;
	param_00.iscarrying = 1;
	param_00 thread updatesentryplacement(self);
	thread sentry_oncarrierdeath(param_00);
	thread sentry_oncarrierdisconnect(param_00);
	thread sentry_oncarrierchangedteam(param_00);
	thread sentry_ongameended();
	self setdefaultdroppitch(-89);
	sentry_setinactive();
	self notify("carried");
}

//Function Number: 24
updatesentryplacement(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("placed");
	param_00 endon("death");
	param_00.canbeplaced = 1;
	var_01 = -1;
	for(;;)
	{
		var_02 = self canplayerplacesentry(1,22);
		param_00.origin = var_02["origin"];
		param_00.angles = var_02["angles"];
		param_00.canbeplaced = self isonground() && var_02["result"] && abs(param_00.origin[2] - self.origin[2]) < 30;
		if(param_00.canbeplaced != var_01)
		{
			if(param_00.canbeplaced)
			{
				param_00 setmodel(level.sentrysettings[param_00.sentrytype].modelplacement);
				self forceusehinton(&"SENTRY_PLACE");
			}
			else
			{
				param_00 setmodel(level.sentrysettings[param_00.sentrytype].modelplacementfailed);
				self forceusehinton(&"SENTRY_CANNOT_PLACE");
			}
		}

		var_01 = param_00.canbeplaced;
		wait(0.05);
	}
}

//Function Number: 25
sentry_oncarrierdeath(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 waittill("death");
	if(self.canbeplaced)
	{
		sentry_setplaced();
		return;
	}

	self delete();
}

//Function Number: 26
sentry_oncarrierdisconnect(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 waittill("disconnect");
	self delete();
}

//Function Number: 27
sentry_oncarrierchangedteam(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 common_scripts\utility::waittill_any("joined_team","joined_spectators");
	self delete();
}

//Function Number: 28
sentry_ongameended(param_00)
{
	self endon("placed");
	self endon("death");
	level waittill("game_ended");
	self delete();
}

//Function Number: 29
sentry_setactive()
{
	self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
	self setcursorhint("HINT_NOICON");
	self sethintstring(level.sentrysettings[self.sentrytype].hintstring);
	if(level.sentrysettings[self.sentrytype].headicon)
	{
		if(level.teambased)
		{
			maps\mp\_entityheadicons::setteamheadicon(self.team,(0,0,65));
		}
		else
		{
			maps\mp\_entityheadicons::setplayerheadicon(self.owner,(0,0,65));
		}
	}

	self makeusable();
	foreach(var_01 in level.players)
	{
		var_02 = self getentitynumber();
		addtoturretlist(var_02);
		if(var_01 == self.owner)
		{
			self enableplayeruse(var_01);
			continue;
		}

		self disableplayeruse(var_01);
	}

	if(self.shouldsplash)
	{
		level thread maps\mp\_utility::teamplayercardsplash(level.sentrysettings[self.sentrytype].teamsplash,self.owner,self.owner.team);
		self.shouldsplash = 0;
	}

	if(self.sentrytype == "sam_turret")
	{
		thread sam_attacktargets();
	}

	thread sentry_watchdisabled();
}

//Function Number: 30
sentry_setinactive()
{
	self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
	self makeunusable();
	self freeentitysentient();
	var_00 = self getentitynumber();
	removefromturretlist(var_00);
	if(level.teambased)
	{
		maps\mp\_entityheadicons::setteamheadicon("none",(0,0,0));
		return;
	}

	if(isdefined(self.owner))
	{
		maps\mp\_entityheadicons::setplayerheadicon(undefined,(0,0,0));
	}
}

//Function Number: 31
sentry_makesolid()
{
	self maketurretsolid();
}

//Function Number: 32
sentry_makenotsolid()
{
	self setcontents(0);
}

//Function Number: 33
isfriendlytosentry(param_00)
{
	if(level.teambased && self.team == param_00.team)
	{
		return 1;
	}

	return 0;
}

//Function Number: 34
addtoturretlist(param_00)
{
	level.turrets[param_00] = self;
}

//Function Number: 35
removefromturretlist(param_00)
{
	level.turrets[param_00] = undefined;
}

//Function Number: 36
sentry_attacktargets()
{
	self endon("death");
	level endon("game_ended");
	self.momentum = 0;
	self.heatlevel = 0;
	self.overheated = 0;
	thread sentry_heatmonitor();
	for(;;)
	{
		common_scripts\utility::waittill_either("turretstatechange","cooled");
		if(self isfiringturret())
		{
			thread sentry_burstfirestart();
			continue;
		}

		sentry_spindown();
		thread sentry_burstfirestop();
	}
}

//Function Number: 37
sentry_timeout()
{
	self endon("death");
	level endon("game_ended");
	var_00 = level.sentrysettings[self.sentrytype].timeout;
	while(var_00)
	{
		wait(1);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		if(!isdefined(self.carriedby))
		{
			var_00 = max(0,var_00 - 1);
		}
	}

	if(isdefined(self.owner))
	{
		if(self.sentrytype == "sam_turret")
		{
			self.owner thread maps\mp\_utility::leaderdialogonplayer("sam_gone");
		}
		else
		{
			self.owner thread maps\mp\_utility::leaderdialogonplayer("sentry_gone");
		}
	}

	self notify("death");
}

//Function Number: 38
sentry_targetlocksound()
{
	self endon("death");
	self playsound("sentry_gun_beep");
	wait(0.1);
	self playsound("sentry_gun_beep");
	wait(0.1);
	self playsound("sentry_gun_beep");
}

//Function Number: 39
sentry_spinup()
{
	thread sentry_targetlocksound();
	while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime)
	{
		self.momentum = self.momentum + 0.1;
		wait(0.1);
	}
}

//Function Number: 40
sentry_spindown()
{
	self.momentum = 0;
}

//Function Number: 41
sentry_burstfirestart()
{
	self endon("death");
	self endon("stop_shooting");
	level endon("game_ended");
	sentry_spinup();
	var_00 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
	var_01 = level.sentrysettings[self.sentrytype].burstmin;
	var_02 = level.sentrysettings[self.sentrytype].burstmax;
	var_03 = level.sentrysettings[self.sentrytype].pausemin;
	var_04 = level.sentrysettings[self.sentrytype].pausemax;
	for(;;)
	{
		var_05 = randomintrange(var_01,var_02 + 1);
		for(var_06 = 0;var_06 < var_05 && !self.overheated;var_06++)
		{
			self shootturret();
			self.heatlevel = self.heatlevel + var_00;
			wait(var_00);
		}

		wait(randomfloatrange(var_03,var_04));
	}
}

//Function Number: 42
sentry_burstfirestop()
{
	self notify("stop_shooting");
}

//Function Number: 43
turret_shotmonitor(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("player_dismount");
	var_01 = weaponfiretime(level.sentrysettings[param_00.sentrytype].weaponinfo);
	for(;;)
	{
		param_00 waittill("turret_fire");
		param_00.heatlevel = param_00.heatlevel + var_01;
		param_00.cooldownwaittime = var_01;
	}
}

//Function Number: 44
sentry_heatmonitor()
{
	self endon("death");
	var_00 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
	var_01 = 0;
	var_02 = 0;
	var_03 = level.sentrysettings[self.sentrytype].overheattime;
	var_04 = level.sentrysettings[self.sentrytype].cooldowntime;
	for(;;)
	{
		if(self.heatlevel != var_01)
		{
			wait(var_00);
		}
		else
		{
			self.heatlevel = max(0,self.heatlevel - 0.05);
		}

		if(self.heatlevel > var_03)
		{
			self.overheated = 1;
			thread playheatfx();
			while(self.heatlevel)
			{
				self.heatlevel = max(0,self.heatlevel - var_04);
				wait(0.1);
			}

			self.overheated = 0;
			self notify("not_overheated");
		}

		var_01 = self.heatlevel;
		wait(0.05);
	}
}

//Function Number: 45
turret_heatmonitor()
{
	self endon("death");
	var_00 = level.sentrysettings[self.sentrytype].overheattime;
	for(;;)
	{
		if(self.heatlevel > var_00)
		{
			self.overheated = 1;
			thread playheatfx();
			while(self.heatlevel)
			{
				wait(0.1);
			}

			self.overheated = 0;
			self notify("not_overheated");
		}

		wait(0.05);
	}
}

//Function Number: 46
turret_coolmonitor()
{
	self endon("death");
	for(;;)
	{
		if(self.heatlevel > 0)
		{
			if(self.cooldownwaittime <= 0)
			{
				self.heatlevel = max(0,self.heatlevel - 0.05);
			}
			else
			{
				self.cooldownwaittime = max(0,self.cooldownwaittime - 0.05);
			}
		}

		wait(0.05);
	}
}

//Function Number: 47
playheatfx()
{
	self endon("death");
	self endon("not_overheated");
	level endon("game_ended");
	self notify("playing_heat_fx");
	self endon("playing_heat_fx");
	for(;;)
	{
		playfxontag(common_scripts\utility::getfx("sentry_overheat_mp"),self,"tag_flash");
		wait(level.sentrysettings[self.sentrytype].fxtime);
	}
}

//Function Number: 48
playsmokefx()
{
	self endon("death");
	self endon("not_overheated");
	level endon("game_ended");
	for(;;)
	{
		playfxontag(common_scripts\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
		wait(0.4);
	}
}

//Function Number: 49
sentry_beepsounds()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait(3);
		if(!isdefined(self.carriedby))
		{
			self playsound("sentry_gun_beep");
		}
	}
}

//Function Number: 50
sam_attacktargets()
{
	self endon("carried");
	self endon("death");
	level endon("game_ended");
	self.samtargetent = undefined;
	self.sammissilegroups = [];
	for(;;)
	{
		self.samtargetent = sam_acquiretarget();
		sam_fireontarget();
		wait(0.05);
	}
}

//Function Number: 51
sam_acquiretarget()
{
	var_00 = self gettagorigin("tag_laser");
	if(!isdefined(self.samtargetent))
	{
		if(level.teambased)
		{
			var_01 = [];
			if(level.multiteambased)
			{
				foreach(var_03 in level.teamnamelist)
				{
					if(var_03 != self.team)
					{
						foreach(var_05 in level.uavmodels[var_03])
						{
							var_01[var_01.size] = var_05;
						}
					}
				}
			}
			else if(isdefined(self.team))
			{
				var_01 = level.uavmodels[level.otherteam[self.team]];
			}

			foreach(var_09 in var_01)
			{
				if(isdefined(var_09.isleaving) && var_09.isleaving)
				{
					continue;
				}

				if(isdefined(var_09.orbit) && var_09.orbit)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_09.origin,0,self))
				{
					return var_09;
				}
			}

			foreach(var_0C in level.littlebirds)
			{
				if(isdefined(var_0C.team) && var_0C.team == self.team)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_0C.origin,0,self))
				{
					return var_0C;
				}
			}

			foreach(var_0F in level.helis)
			{
				if(isdefined(var_0F.team) && var_0F.team == self.team)
				{
					continue;
				}

				if(isdefined(var_0F.cloakstate) && var_0F.cloakstate < 1)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_0F.origin,0,self,var_0F))
				{
					return var_0F;
				}
			}

			if(level.orbitalsupportinuse && isdefined(level.orbitalsupport_planemodel.owner) && level.orbitalsupport_planemodel.owner.team != self.team)
			{
				if(sighttracepassed(var_00,level.orbitalsupport_planemodel.origin,0,self))
				{
					return level.orbitalsupport_planemodel;
				}
			}

			if(isdefined(level._orbital_care_pod))
			{
				foreach(var_12 in level._orbital_care_pod)
				{
					if(isdefined(var_12.podrocket) && var_12.owner.team != self.team)
					{
						if(sighttracepassed(var_00,var_12.podrocket.origin,0,self))
						{
							return var_12.podrocket;
						}
					}
				}
			}

			foreach(var_15 in level.planes)
			{
				if(isdefined(var_15.team) && var_15.team == self.team)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_15.origin,0,self))
				{
					return var_15;
				}
			}
		}
		else
		{
			foreach(var_09 in level.uavmodels)
			{
				if(isdefined(var_09.isleaving) && var_09.isleaving)
				{
					continue;
				}

				if(isdefined(var_09.owner) && isdefined(self.owner) && var_09.owner == self.owner)
				{
					continue;
				}

				if(isdefined(var_09.orbit) && var_09.orbit)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_09.origin,0,self))
				{
					return var_09;
				}
			}

			foreach(var_0C in level.littlebirds)
			{
				if(isdefined(var_0C.owner) && isdefined(self.owner) && var_0C.owner == self.owner)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_0C.origin,0,self))
				{
					return var_0C;
				}
			}

			foreach(var_0F in level.helis)
			{
				if(isdefined(var_0F.owner) && isdefined(self.owner) && var_0F.owner == self.owner)
				{
					continue;
				}

				if(isdefined(var_0F.cloakstate) && var_0F.cloakstate < 1)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_0F.origin,0,self,var_0F))
				{
					return var_0F;
				}
			}

			if(level.orbitalsupportinuse && isdefined(level.orbitalsupport_planemodel.owner) && isdefined(self.owner) && level.orbitalsupport_planemodel.owner != self.owner)
			{
				if(sighttracepassed(var_00,level.orbitalsupport_planemodel.owner.origin,0,self))
				{
					return level.orbitalsupport_planemodel.owner;
				}
			}

			if(isdefined(level._orbital_care_pod))
			{
				foreach(var_12 in level._orbital_care_pod)
				{
					if(isdefined(var_12.podrocket) && var_12.owner != self)
					{
						if(sighttracepassed(var_00,var_12.podrocket.origin,0,self))
						{
							return var_12.podrocket;
						}
					}
				}
			}

			foreach(var_15 in level.planes)
			{
				if(isdefined(var_15.team) && var_15.owner == self.owner)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_15.origin,0,self))
				{
					return var_15;
				}
			}
		}

		self cleartargetentity();
		return undefined;
	}

	if(!sighttracepassed(var_15,self.samtargetent.origin,0,self,self.samtargetent))
	{
		self cleartargetentity();
		return undefined;
	}

	return self.samtargetent;
}

//Function Number: 52
sam_fireontarget()
{
	if(isdefined(self.samtargetent))
	{
		if((self.samtargetent == level.ac130.planemodel && !isdefined(level.ac130player)) || isdefined(level.orbitalsupport_planemodel) && self.samtargetent == level.orbitalsupport_planemodel && !isdefined(level.orbitalsupport_player))
		{
			self.samtargetent = undefined;
			self cleartargetentity();
			return;
		}

		self settargetentity(self.samtargetent);
		self waittill("turret_on_target");
		if(!isdefined(self.samtargetent))
		{
			return;
		}

		if(!self.laser_on)
		{
			thread sam_watchlaser();
			thread sam_watchcrashing();
			thread sam_watchleaving();
			thread sam_watchlineofsight();
		}

		wait(2);
		if(!isdefined(self.samtargetent))
		{
			return;
		}

		if(self.samtargetent == level.ac130.planemodel && !isdefined(level.ac130player))
		{
			self.samtargetent = undefined;
			self cleartargetentity();
			return;
		}

		var_00 = [];
		var_00[0] = self gettagorigin("tag_le_missile1");
		var_00[1] = self gettagorigin("tag_le_missile2");
		var_00[2] = self gettagorigin("tag_ri_missile1");
		var_00[3] = self gettagorigin("tag_ri_missile2");
		var_01 = self.sammissilegroups.size;
		for(var_02 = 0;var_02 < 4;var_02++)
		{
			if(!isdefined(self.samtargetent))
			{
				return;
			}

			if(isdefined(self.carriedby))
			{
				return;
			}

			self shootturret();
			var_03 = magicbullet("sam_projectile_mp",var_00[var_02],self.samtargetent.origin,self.owner);
			var_03 missile_settargetent(self.samtargetent);
			var_03 missile_setflightmodedirect();
			var_03.samturret = self;
			var_03.sammissilegroup = var_01;
			self.sammissilegroups[var_01][var_02] = var_03;
			level notify("sam_missile_fired",self.owner,var_03,self.samtargetent);
			if(var_02 == 3)
			{
				break;
			}

			wait(0.25);
		}

		level notify("sam_fired",self.owner,self.sammissilegroups[var_01],self.samtargetent);
		wait(3);
	}
}

//Function Number: 53
sam_watchlineofsight()
{
	level endon("game_ended");
	self endon("death");
	self endon("fakedeath");
	while(isdefined(self.samtargetent) && isdefined(self getturrettarget(1)) && self getturrettarget(1) == self.samtargetent)
	{
		var_00 = self gettagorigin("tag_laser");
		if(!sighttracepassed(var_00,self.samtargetent.origin,0,self,self.samtargetent))
		{
			self cleartargetentity();
			self.samtargetent = undefined;
			break;
		}

		wait(0.05);
	}
}

//Function Number: 54
sam_watchlaser()
{
	self endon("death");
	self laseron();
	self.laser_on = 1;
	self notify("laser_on");
	while(isdefined(self.samtargetent) && isdefined(self getturrettarget(1)) && self getturrettarget(1) == self.samtargetent)
	{
		wait(0.05);
	}

	self laseroff();
	self.laser_on = 0;
	self notify("laser_off");
}

//Function Number: 55
sam_watchcrashing()
{
	self endon("death");
	self endon("fakedeath");
	self.samtargetent endon("death");
	if(!isdefined(self.samtargetent.helitype))
	{
		return;
	}

	self.samtargetent waittill("crashing");
	self cleartargetentity();
	self.samtargetent = undefined;
}

//Function Number: 56
sam_watchleaving()
{
	self endon("death");
	self endon("fakedeath");
	self.samtargetent endon("death");
	if(!isdefined(self.samtargetent.model))
	{
		return;
	}

	if(self.samtargetent.model == "vehicle_uav_static_mp")
	{
		self.samtargetent waittill("leaving");
		self cleartargetentity();
		self.samtargetent = undefined;
	}
}