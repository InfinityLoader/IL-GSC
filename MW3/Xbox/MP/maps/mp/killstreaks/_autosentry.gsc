/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_autosentry.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 56
 * Decompile Time: 787 ms
 * Timestamp: 10/27/2023 2:26:44 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.sentrytype = [];
	level.sentrytype["sentry_minigun"] = "sentry";
	level.sentrytype["sam_turret"] = "sam_turret";
	level.killstreakfuncs[level.sentrytype["sentry_minigun"]] = ::tryuseautosentry;
	level.killstreakfuncs[level.sentrytype["sam_turret"]] = ::tryusesam;
	level.sentrysettings = [];
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
	level.sentrysettings["sam_turret"].sentrymodeon = "sentry";
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
	foreach(var_01 in level.sentrysettings)
	{
		precacheitem(var_01.weaponinfo);
		precachemodel(var_01.modelbase);
		precachemodel(var_01.modelplacement);
		precachemodel(var_01.modelplacementfailed);
		precachemodel(var_01.modeldestroyed);
		precachestring(var_01.hintstring);
		if(isdefined(var_01.ownerhintstring))
		{
			precachestring(var_01.ownerhintstring);
		}
	}

	precacheitem("sam_projectile_mp");
	level._effect["sentry_overheat_mp"] = loadfx("smoke/sentry_turret_overheat_smoke");
	level._effect["sentry_explode_mp"] = loadfx("explosions/sentry_gun_explosion");
	level._effect["sentry_smoke_mp"] = loadfx("smoke/car_damage_blacksmoke");
}

//Function Number: 2
tryuseautosentry(param_00)
{
	var_01 = func_2DF2("sentry_minigun");
	if(var_01)
	{
		maps\mp\_matchdata::logkillstreakevent(level.sentrysettings["sentry_minigun"].streakname,self.origin);
	}

	return var_01;
}

//Function Number: 3
tryusesam(param_00)
{
	var_01 = func_2DF2("sam_turret");
	if(var_01)
	{
		maps\mp\_matchdata::logkillstreakevent(level.sentrysettings["sam_turret"].streakname,self.origin);
	}

	return var_01;
}

//Function Number: 4
func_2DF2(param_00)
{
	if(!maps\mp\_utility::func_2DF3())
	{
		return 0;
	}

	self.last_sentry = param_00;
	var_01 = func_2DFD(param_00,self);
	func_2DF8();
	var_02 = func_2DF5(var_01,1);
	thread waitrestoreperks();
	self.iscarrying = 0;
	if(isdefined(var_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
func_2DF5(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	param_00 sentry_setcarried(self);
	common_scripts\utility::_disableweapon();
	self notifyonplayercommand("place_sentry","+attack");
	self notifyonplayercommand("place_sentry","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_sentry","+actionslot 4");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_sentry","+actionslot 5");
		self notifyonplayercommand("cancel_sentry","+actionslot 6");
		self notifyonplayercommand("cancel_sentry","+actionslot 7");
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
				var_03 = maps\mp\killstreaks\_killstreaks::func_2C01(level.sentrysettings[param_00.sentrytype].streakname);
				if(isdefined(self.killstreakindexweapon) && var_03 == maps\mp\killstreaks\_killstreaks::func_2C01(self.pers["killstreaks"][self.killstreakindexweapon].streakname) && !self getweaponslistitems().size)
				{
					maps\mp\_utility::_giveweapon(var_03,0);
					maps\mp\_utility::func_31F3(4,"weapon",var_03);
				}
			}

			param_00 func_2E11();
			common_scripts\utility::_enableweapon();
			return 0;
		}

		if(!param_00.canbeplaced)
		{
			continue;
		}

		param_00 func_2E10();
		common_scripts\utility::_enableweapon();
		return 1;
	}
}

//Function Number: 6
func_2DF6()
{
	if(self hasweapon("riotshield_mp"))
	{
		self.restoreweapon = "riotshield_mp";
		self takeweapon("riotshield_mp");
	}
}

//Function Number: 7
func_2DF8()
{
	if(maps\mp\_utility::func_27AF("specialty_explosivebullets"))
	{
		self.restoreperk = "specialty_explosivebullets";
		maps\mp\_utility::func_282E("specialty_explosivebullets");
	}
}

//Function Number: 8
func_2DFA()
{
	if(isdefined(self.restoreweapon))
	{
		maps\mp\_utility::_giveweapon(self.restoreweapon);
		self.restoreweapon = undefined;
	}
}

//Function Number: 9
func_2DFB()
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
	wait 0.05;
	func_2DFB();
}

//Function Number: 11
func_2DFD(param_00,param_01)
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
		case "gl_turret":
		case "minigun_turret":
			self setleftarc(80);
			self setrightarc(80);
			self setbottomarc(50);
			self setdefaultdroppitch(0);
			self.originalowner = param_01;
			break;

		case "sam_turret":
			self maketurretinoperable();
			self setleftarc(180);
			self setrightarc(180);
			self settoparc(80);
			self setdefaultdroppitch(-89);
			self.laser_on = 0;
			var_02 = spawn("script_model",self gettagorigin("tag_laser"));
			var_02 linkto(self);
			self.killcament = var_02;
			self.killcament setscriptmoverkillcam("explosive");
			break;

		default:
			self maketurretinoperable();
			self setdefaultdroppitch(-89);
			break;
	}

	self setturretmodechangewait(1);
	func_2E19();
	func_2E0F(param_01);
	thread sentry_handledamage();
	thread sentry_handledeath();
	thread sentry_timeout();
	switch(param_00)
	{
		case "minigun_turret":
			self.momentum = 0;
			self.heatlevel = 0;
			self.overheated = 0;
			thread sentry_heatmonitor();
			break;

		case "gl_turret":
			self.momentum = 0;
			self.heatlevel = 0;
			self.cooldownwaittime = 0;
			self.overheated = 0;
			thread func_2E25();
			thread turret_coolmonitor();
			break;

		case "sam_turret":
			thread sentry_handleuse();
			thread func_2E29();
			break;

		default:
			thread sentry_handleuse();
			thread sentry_attacktargets();
			thread func_2E29();
			break;
	}
}

//Function Number: 13
sentry_handledamage()
{
	self endon("death");
	level endon("game_ended");
	self.health = level.sentrysettings[self.sentrytype].health;
	self.maxhealth = level.sentrysettings[self.sentrytype].maxhealth;
	self.damagetaken = 0;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!maps\mp\gametypes\_weapons::func_27A1(self.owner,var_01))
		{
			continue;
		}

		if(isdefined(var_08) && var_08 & level.idflags_penetration)
		{
			self.wasdamagedfrombulletpenetration = 1;
		}

		switch(var_09)
		{
			case "stealth_bomb_mp":
			case "artillery_mp":
				var_00 = var_00 * 4;
				break;
	
			case "bomb_site_mp":
				var_00 = self.maxhealth;
				break;
		}

		if(var_04 == "MOD_MELEE")
		{
			self.damagetaken = self.damagetaken + self.maxhealth;
		}

		var_0A = var_00;
		if(isplayer(var_01))
		{
			var_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("sentry");
			if(var_01 maps\mp\_utility::func_27AF("specialty_armorpiercing"))
			{
				var_0A = var_00 * level.armorpiercingmod;
			}
		}

		if(isdefined(var_01.owner) && isplayer(var_01.owner))
		{
			var_01.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback("sentry");
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "remote_mortar_missile_mp":
				case "javelin_mp":
				case "stinger_mp":
				case "remotemissile_projectile_mp":
				case "ac130_40mm_mp":
				case "ac130_105mm_mp":
					self.largeprojectiledamage = 1;
					var_0A = self.maxhealth + 1;
					break;
	
				case "stealth_bomb_mp":
				case "artillery_mp":
					self.largeprojectiledamage = 0;
					var_0A = var_0A + var_00 * 4;
					break;
	
				case "emp_grenade_mp":
				case "bomb_site_mp":
					self.largeprojectiledamage = 0;
					var_0A = self.maxhealth + 1;
					break;
			}

			maps\mp\killstreaks\_killstreaks::killstreakhit(var_01,var_09,self);
		}

		self.damagetaken = self.damagetaken + var_0A;
		if(self.damagetaken >= self.maxhealth)
		{
			thread maps\mp\gametypes\_missions::vehiclekilled(self.owner,self,undefined,var_01,var_00,var_04,var_09);
			if(isplayer(var_01) && !isdefined(self.owner) || var_01 != self.owner)
			{
				var_01 thread maps\mp\gametypes\_rank::func_2AB3("kill",100,var_09,var_04);
				var_01 notify("destroyed_killstreak");
				if(isdefined(self.uavremotemarkedby) && self.uavremotemarkedby != var_01)
				{
					self.uavremotemarkedby thread maps\mp\killstreaks\_remoteuav::remoteuav_processtaggedassist();
				}
			}

			if(isdefined(self.owner))
			{
				self.owner thread maps\mp\_utility::func_2A60(level.sentrysettings[self.sentrytype].vodestroyed);
			}

			self notify("death");
			return;
		}
	}
}

//Function Number: 14
func_2E05()
{
	self endon("carried");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		playfxontag(common_scripts\utility::func_539("sentry_explode_mp"),self,"tag_aim");
		self setdefaultdroppitch(40);
		self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
		wait var_01;
		self setdefaultdroppitch(-89);
		self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
	}
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
	func_2E19();
	self setdefaultdroppitch(40);
	self setsentryowner(undefined);
	self setturretminimapvisible(0);
	if(isdefined(self.ownertrigger))
	{
		self.ownertrigger delete();
	}

	self playsound("sentry_explode");
	switch(self.sentrytype)
	{
		case "gl_turret":
		case "minigun_turret":
			self.forcedisable = 1;
			self turretfiredisable();
			break;

		default:
			break;
	}

	if(isdefined(self.inuseby))
	{
		playfxontag(common_scripts\utility::func_539("sentry_explode_mp"),self,"tag_origin");
		playfxontag(common_scripts\utility::func_539("sentry_smoke_mp"),self,"tag_aim");
		self.inuseby.turret_overheat_bar maps\mp\gametypes\_hud_util::destroyelem();
		self.inuseby func_2DFB();
		self.inuseby func_2DFA();
		self notify("deleting");
		wait 1;
		stopfxontag(common_scripts\utility::func_539("sentry_explode_mp"),self,"tag_origin");
		stopfxontag(common_scripts\utility::func_539("sentry_smoke_mp"),self,"tag_aim");
	}
	else
	{
		playfxontag(common_scripts\utility::func_539("sentry_explode_mp"),self,"tag_aim");
		wait 1.5;
		self playsound("sentry_explode_smoke");
		var_00 = 8;
		while(var_00 > 0)
		{
			playfxontag(common_scripts\utility::func_539("sentry_smoke_mp"),self,"tag_aim");
			wait 0.4;
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

		var_00 func_2DF5(self,0);
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
					wait 0.05;
				}

				if(var_01 >= 0.5)
				{
					continue;
				}

				var_01 = 0;
				while(!self usebuttonpressed() && var_01 < 0.5)
				{
					var_01 = var_01 + 0.05;
					wait 0.05;
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
				thread func_2DF5(param_00,0);
				param_00.ownertrigger delete();
				return;
			}
		}

		wait 0.05;
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

		var_03 func_2DF8();
		var_03 func_2DF6();
		self.inuseby = var_03;
		self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
		func_2E0F(var_03);
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
				var_03 func_2DFB();
				var_03 func_2DFA();
				self sethintstring(level.sentrysettings[self.sentrytype].hintstring);
				self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
				func_2E0F(self.originalowner);
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
			else if(self.heatlevel > level.sentrysettings[self.sentrytype].overheattime * 0.75 && self.sentrytype == "minigun_turret")
			{
				var_03.turret_overheat_bar.bar.color = var_01;
				if(randomintrange(0,10) < 6)
				{
					self turretfireenable();
				}
				else
				{
					self turretfiredisable();
				}

				if(!var_04)
				{
					var_04 = 1;
					thread func_2E27();
				}
			}
			else
			{
				var_03.turret_overheat_bar.bar.color = var_00;
				self turretfireenable();
				var_04 = 0;
				self notify("not_overheated");
			}

			wait 0.05;
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
func_2E0F(param_00)
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
func_2E10()
{
	self setmodel(level.sentrysettings[self.sentrytype].modelbase);
	if(self getmode() == "manual")
	{
		self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
	}

	self setsentrycarrier(undefined);
	self setcandamage(1);
	switch(self.sentrytype)
	{
		case "gl_turret":
		case "minigun_turret":
			self.angles = self.carriedby.angles;
			if(isalive(self.originalowner))
			{
				self.originalowner maps\mp\_utility::setlowermessage("pickup_hint",level.sentrysettings[self.sentrytype].ownerhintstring,3,undefined,undefined,undefined,undefined,undefined,1);
			}
	
			self.ownertrigger = spawn("trigger_radius",self.origin + (0,0,1),0,105,64);
			self.originalowner thread turret_handlepickup(self);
			thread turret_handleuse();
			break;

		default:
			break;
	}

	func_2E1A();
	self.carriedby forceusehintoff();
	self.carriedby = undefined;
	if(isdefined(self.owner))
	{
		self.owner.iscarrying = 0;
	}

	func_2E18();
	self playsound("sentry_gun_plant");
	self notify("placed");
}

//Function Number: 22
func_2E11()
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
	func_2E1B();
	self.carriedby = param_00;
	param_00.iscarrying = 1;
	param_00 thread updatesentryplacement(self);
	thread sentry_oncarrierdeath(param_00);
	thread sentry_oncarrierdisconnect(param_00);
	thread func_2E16(param_00);
	thread func_2E17();
	self setdefaultdroppitch(-89);
	func_2E19();
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
		var_02 = self canplayerplacesentry();
		param_00.origin = var_02["origin"];
		param_00.angles = var_02["angles"];
		param_00.canbeplaced = self isonground() && var_02["result"] && abs(param_00.origin[2] - self.origin[2]) < 10;
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
		wait 0.05;
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
		func_2E10();
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
func_2E16(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 common_scripts\utility::waittill_any("joined_team","joined_spectators");
	self delete();
}

//Function Number: 28
func_2E17(param_00)
{
	self endon("placed");
	self endon("death");
	level waittill("game_ended");
	self delete();
}

//Function Number: 29
func_2E18()
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
		switch(self.sentrytype)
		{
			case "gl_turret":
			case "minigun_turret":
				self enableplayeruse(var_01);
				break;

			default:
				var_02 = self getentitynumber();
				func_2E1D(var_02);
				if(var_01 == self.owner)
				{
					self enableplayeruse(var_01);
				}
				else
				{
					self disableplayeruse(var_01);
				}
				break;
		}
	}

	if(self.shouldsplash)
	{
		level thread maps\mp\_utility::teamplayercardsplash(level.sentrysettings[self.sentrytype].teamsplash,self.owner,self.owner.team);
		self.shouldsplash = 0;
	}

	if(self.sentrytype == "sam_turret")
	{
		thread func_2E2A();
	}

	thread func_2E05();
}

//Function Number: 30
func_2E19()
{
	self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
	self makeunusable();
	var_00 = self getentitynumber();
	switch(self.sentrytype)
	{
		case "gl_turret":
			break;

		default:
			removefromturretlist(var_00);
			break;
	}

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
func_2E1A()
{
	self maketurretsolid();
}

//Function Number: 32
func_2E1B()
{
	self setcontents(0);
}

//Function Number: 33
func_2E1C(param_00)
{
	if(level.teambased && self.team == param_00.team)
	{
		return 1;
	}

	return 0;
}

//Function Number: 34
func_2E1D(param_00)
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

		func_2E22();
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
		wait 1;
		maps\mp\gametypes\_hostmigration::func_273E();
		if(!isdefined(self.carriedby))
		{
			var_00 = max(0,var_00 - 1);
		}
	}

	if(isdefined(self.owner))
	{
		if(self.sentrytype == "sam_turret")
		{
			self.owner thread maps\mp\_utility::func_2A60("sam_gone");
		}
		else
		{
			self.owner thread maps\mp\_utility::func_2A60("sentry_gone");
		}
	}

	self notify("death");
}

//Function Number: 38
func_2E20()
{
	self endon("death");
	self playsound("sentry_gun_beep");
	wait 0.1;
	self playsound("sentry_gun_beep");
	wait 0.1;
	self playsound("sentry_gun_beep");
}

//Function Number: 39
sentry_spinup()
{
	thread func_2E20();
	while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime)
	{
		self.momentum = self.momentum + 0.1;
		wait 0.1;
	}
}

//Function Number: 40
func_2E22()
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
			wait var_00;
		}

		wait randomfloatrange(var_03,var_04);
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
			wait var_00;
		}
		else
		{
			self.heatlevel = max(0,self.heatlevel - 0.05);
		}

		if(self.heatlevel > var_03)
		{
			self.overheated = 1;
			thread func_2E27();
			switch(self.sentrytype)
			{
				case "minigun_turret":
					playfxontag(common_scripts\utility::func_539("sentry_smoke_mp"),self,"tag_aim");
					break;
	
				default:
					break;
			}

			while(self.heatlevel)
			{
				self.heatlevel = max(0,self.heatlevel - var_04);
				wait 0.1;
			}

			self.overheated = 0;
			self notify("not_overheated");
		}

		var_01 = self.heatlevel;
		wait 0.05;
	}
}

//Function Number: 45
func_2E25()
{
	self endon("death");
	var_00 = level.sentrysettings[self.sentrytype].overheattime;
	for(;;)
	{
		if(self.heatlevel > var_00)
		{
			self.overheated = 1;
			thread func_2E27();
			switch(self.sentrytype)
			{
				case "gl_turret":
					playfxontag(common_scripts\utility::func_539("sentry_smoke_mp"),self,"tag_aim");
					break;
	
				default:
					break;
			}

			while(self.heatlevel)
			{
				wait 0.1;
			}

			self.overheated = 0;
			self notify("not_overheated");
		}

		wait 0.05;
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

		wait 0.05;
	}
}

//Function Number: 47
func_2E27()
{
	self endon("death");
	self endon("not_overheated");
	level endon("game_ended");
	self notify("playing_heat_fx");
	self endon("playing_heat_fx");
	for(;;)
	{
		playfxontag(common_scripts\utility::func_539("sentry_overheat_mp"),self,"tag_flash");
		wait level.sentrysettings[self.sentrytype].fxtime;
	}
}

//Function Number: 48
func_2E28()
{
	self endon("death");
	self endon("not_overheated");
	level endon("game_ended");
	for(;;)
	{
		playfxontag(common_scripts\utility::func_539("sentry_smoke_mp"),self,"tag_aim");
		wait 0.4;
	}
}

//Function Number: 49
func_2E29()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait 3;
		if(!isdefined(self.carriedby))
		{
			self playsound("sentry_gun_beep");
		}
	}
}

//Function Number: 50
func_2E2A()
{
	self endon("carried");
	self endon("death");
	level endon("game_ended");
	self.samtargetent = undefined;
	self.sammissilegroups = [];
	for(;;)
	{
		self.samtargetent = func_2E2D();
		func_2E2F();
		wait 0.05;
	}
}

//Function Number: 51
func_2E2D()
{
	var_00 = self gettagorigin("tag_laser");
	if(!isdefined(self.samtargetent))
	{
		if(level.teambased)
		{
			foreach(var_02 in level.uavmodels[level.otherteam[self.team]])
			{
				if(isdefined(var_02.isleaving) && var_02.isleaving)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_02.origin,0,self))
				{
					return var_02;
				}
			}

			foreach(var_05 in level.littlebirds)
			{
				if(isdefined(var_05.team) && var_05.team == self.team)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_05.origin,0,self))
				{
					return var_05;
				}
			}

			foreach(var_08 in level.helis)
			{
				if(isdefined(var_08.team) && var_08.team == self.team)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_08.origin,0,self))
				{
					return var_08;
				}
			}

			if(level.ac130inuse && isdefined(level.ac130.owner) && level.ac130.owner.team != self.team)
			{
				if(sighttracepassed(var_00,level.ac130.planemodel.origin,0,self))
				{
					return level.ac130.planemodel;
				}
			}

			foreach(var_02 in level.remote_uav)
			{
				if(!isdefined(var_02))
				{
					continue;
				}

				if(isdefined(var_02.team) && var_02.team == self.team)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_02.origin,0,self,var_02))
				{
					return var_02;
				}
			}
		}
		else
		{
			foreach(var_02 in level.uavmodels)
			{
				if(isdefined(var_02.isleaving) && var_02.isleaving)
				{
					continue;
				}

				if(isdefined(var_02.owner) && isdefined(self.owner) && var_02.owner == self.owner)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_02.origin,0,self))
				{
					return var_02;
				}
			}

			foreach(var_05 in level.littlebirds)
			{
				if(isdefined(var_05.owner) && isdefined(self.owner) && var_05.owner == self.owner)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_05.origin,0,self))
				{
					return var_05;
				}
			}

			foreach(var_08 in level.helis)
			{
				if(isdefined(var_08.owner) && isdefined(self.owner) && var_08.owner == self.owner)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_08.origin,0,self))
				{
					return var_08;
				}
			}

			if(level.ac130inuse && isdefined(level.ac130.owner) && isdefined(self.owner) && level.ac130.owner != self.owner)
			{
				if(sighttracepassed(var_00,level.ac130.planemodel.origin,0,self))
				{
					return level.ac130.planemodel;
				}
			}

			foreach(var_02 in level.remote_uav)
			{
				if(!isdefined(var_02))
				{
					continue;
				}

				if(isdefined(var_02.owner) && isdefined(self.owner) && var_02.owner == self.owner)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_02.origin,0,self,var_02))
				{
					return var_02;
				}
			}
		}

		self cleartargetentity();
		return undefined;
	}

	if(!sighttracepassed(var_08,self.samtargetent.origin,0,self))
	{
		self cleartargetentity();
		return undefined;
	}

	return self.samtargetent;
}

//Function Number: 52
func_2E2F()
{
	if(isdefined(self.samtargetent))
	{
		if(self.samtargetent == level.ac130.planemodel && !isdefined(level.ac130player))
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
			thread func_2E32();
			thread func_2E33();
			thread func_2E34();
			thread sam_watchlineofsight();
		}

		wait 2;
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
			var_03 = magicbullet("sam_projectile_mp",var_41[var_02],self.samtargetent.origin,self.owner);
			var_03 missile_settargetent(self.samtargetent);
			var_03 missile_setflightmodedirect();
			var_03.samturret = self;
			var_03.sammissilegroup = var_01;
			self.sammissilegroups[var_01][var_02] = var_03;
			level notify("sam_missile_fired",self.owner,var_03,self.samtargetent,var_41[3],self gettagorigin("tag_ri_missile2"),var_41[2],self gettagorigin("tag_ri_missile1"),var_41[1],self gettagorigin("tag_le_missile2"),var_41[0],self gettagorigin("tag_le_missile1"));
			if(var_02 == 3)
			{
				break;
			}

			wait 0.25;
		}

		level notify("sam_fired",self.owner,self.sammissilegroups[var_01],self.samtargetent);
		wait 3;
	}
}

//Function Number: 53
sam_watchlineofsight()
{
	level endon("game_ended");
	self endon("death");
	while(isdefined(self.samtargetent) && isdefined(self getturrettarget(1)) && self getturrettarget(1) == self.samtargetent)
	{
		var_00 = self gettagorigin("tag_laser");
		if(!sighttracepassed(var_00,self.samtargetent.origin,0,self,self.samtargetent))
		{
			self cleartargetentity();
			self.samtargetent = undefined;
			break;
		}

		wait 0.05;
	}
}

//Function Number: 54
func_2E32()
{
	self endon("death");
	self laseron();
	self.laser_on = 1;
	while(isdefined(self.samtargetent) && isdefined(self getturrettarget(1)) && self getturrettarget(1) == self.samtargetent)
	{
		wait 0.05;
	}

	self laseroff();
	self.laser_on = 0;
}

//Function Number: 55
func_2E33()
{
	self endon("death");
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
func_2E34()
{
	self endon("death");
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