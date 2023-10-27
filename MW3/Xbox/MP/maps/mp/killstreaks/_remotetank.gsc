/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_remotetank.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 43
 * Decompile Time: 730 ms
 * Timestamp: 10/27/2023 2:27:17 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakfuncs["remote_tank"] = ::func_31A5;
	level.tanksettings = [];
	level.tanksettings["remote_tank"] = spawnstruct();
	level.tanksettings["remote_tank"].timeout = 60;
	level.tanksettings["remote_tank"].health = 99999;
	level.tanksettings["remote_tank"].maxhealth = 1000;
	level.tanksettings["remote_tank"].streakname = "remote_tank";
	level.tanksettings["remote_tank"].mgturretinfo = "ugv_turret_mp";
	level.tanksettings["remote_tank"].missileinfo = "remote_tank_projectile_mp";
	level.tanksettings["remote_tank"].sentrymodeoff = "sentry_offline";
	level.tanksettings["remote_tank"].vehicleinfo = "remote_ugv_mp";
	level.tanksettings["remote_tank"].modelbase = "vehicle_ugv_talon_mp";
	level.tanksettings["remote_tank"].modelmgturret = "vehicle_ugv_talon_gun_mp";
	level.tanksettings["remote_tank"].modelplacement = "vehicle_ugv_talon_obj";
	level.tanksettings["remote_tank"].modelplacementfailed = "vehicle_ugv_talon_obj_red";
	level.tanksettings["remote_tank"].modeldestroyed = "vehicle_ugv_talon_mp";
	level.tanksettings["remote_tank"].stringplace = &"MP_REMOTE_TANK_PLACE";
	level.tanksettings["remote_tank"].stringcannotplace = &"MP_REMOTE_TANK_CANNOT_PLACE";
	level.tanksettings["remote_tank"].laptopinfo = "killstreak_remote_tank_laptop_mp";
	level.tanksettings["remote_tank"].remoteinfo = "killstreak_remote_tank_remote_mp";
	makedvarserverinfo("ui_remoteTankUseTime",level.tanksettings["remote_tank"].timeout);
	precachemenu("remotetank_timer");
	foreach(var_01 in level.tanksettings)
	{
		precachemodel(var_01.modelbase);
		precachemodel(var_01.modelmgturret);
		precachemodel(var_01.modelplacement);
		precachemodel(var_01.modelplacementfailed);
		precachemodel(var_01.modeldestroyed);
		precacheturret(var_01.mgturretinfo);
		precachevehicle(var_01.vehicleinfo);
		precachestring(var_01.stringplace);
		precachestring(var_01.stringcannotplace);
		precacheitem(var_01.laptopinfo);
		precacheitem(var_01.remoteinfo);
		precacheitem(var_01.missileinfo);
	}

	level._effect["remote_tank_dying"] = loadfx("explosions/killstreak_explosion_quick");
	level._effect["remote_tank_explode"] = loadfx("explosions/bouncing_betty_explosion");
	level._effect["remote_tank_spark"] = loadfx("impacts/large_metal_painted_hit");
	level._effect["remote_tank_antenna_light_mp"] = loadfx("misc/aircraft_light_red_blink");
	level._effect["remote_tank_camera_light_mp"] = loadfx("misc/aircraft_light_wingtip_green");
	level.remote_tank_armor_bulletdamage = 0.5;
}

//Function Number: 2
func_31A5(param_00)
{
	var_01 = 1;
	if(!maps\mp\_utility::func_2DF3())
	{
		return 0;
	}
	else if(maps\mp\_utility::func_2BEC() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_01 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
		return 0;
	}

	maps\mp\_utility::func_80C7();
	var_02 = func_31A6(param_00,"remote_tank");
	if(var_02)
	{
		maps\mp\_matchdata::logkillstreakevent("remote_tank",self.origin);
		thread maps\mp\_utility::teamplayercardsplash("used_remote_tank",self);
		takekillstreakweapons("remote_tank");
	}
	else
	{
		maps\mp\_utility::func_80C8();
	}

	self.iscarrying = 0;
	return var_02;
}

//Function Number: 3
takekillstreakweapons(param_00)
{
	var_01 = maps\mp\killstreaks\_killstreaks::func_2C01(level.tanksettings[param_00].streakname);
	maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe(var_01);
	self takeweapon(level.tanksettings[param_00].laptopinfo);
	self takeweapon(level.tanksettings[param_00].remoteinfo);
}

//Function Number: 4
func_2DF8()
{
	if(maps\mp\_utility::func_27AF("specialty_explosivebullets"))
	{
		self.restoreperk = "specialty_explosivebullets";
		maps\mp\_utility::func_282E("specialty_explosivebullets");
	}
}

//Function Number: 5
func_2DFB()
{
	if(isdefined(self.restoreperk))
	{
		maps\mp\_utility::giveperk(self.restoreperk,0);
		self.restoreperk = undefined;
	}
}

//Function Number: 6
waitrestoreperks()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait 0.05;
	func_2DFB();
}

//Function Number: 7
func_2DF6()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		var_03 = strtok(var_02,"_");
		if(var_03[0] == "alt")
		{
			self.restoreweaponclipammo[var_02] = self getweaponammoclip(var_02);
			self.restoreweaponstockammo[var_02] = self getweaponammostock(var_02);
			continue;
		}

		self.restoreweaponclipammo[var_02] = self getweaponammoclip(var_02);
		self.restoreweaponstockammo[var_02] = self getweaponammostock(var_02);
	}

	self.weaponstorestore = [];
	foreach(var_02 in var_00)
	{
		var_03 = strtok(var_02,"_");
		self.weaponstorestore[self.weaponstorestore.size] = var_02;
		if(var_03[0] == "alt")
		{
			continue;
		}

		self takeweapon(var_02);
	}
}

//Function Number: 8
func_2DFA()
{
	if(!isdefined(self.restoreweaponclipammo) || !isdefined(self.restoreweaponstockammo) || !isdefined(self.weaponstorestore))
	{
		return;
	}

	var_00 = [];
	foreach(var_02 in self.weaponstorestore)
	{
		var_03 = strtok(var_02,"_");
		if(var_03[0] == "alt")
		{
			var_00[var_00.size] = var_02;
			continue;
		}

		maps\mp\_utility::_giveweapon(var_02);
		if(isdefined(self.restoreweaponclipammo[var_02]))
		{
			self setweaponammoclip(var_02,self.restoreweaponclipammo[var_02]);
		}

		if(isdefined(self.restoreweaponstockammo[var_02]))
		{
			self setweaponammostock(var_02,self.restoreweaponstockammo[var_02]);
		}
	}

	foreach(var_06 in var_00)
	{
		if(isdefined(self.restoreweaponclipammo[var_06]))
		{
			self setweaponammoclip(var_06,self.restoreweaponclipammo[var_06]);
		}

		if(isdefined(self.restoreweaponstockammo[var_06]))
		{
			self setweaponammostock(var_06,self.restoreweaponstockammo[var_06]);
		}
	}

	self.restoreweaponclipammo = undefined;
	self.restoreweaponstockammo = undefined;
}

//Function Number: 9
waitrestoreweapons()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait 0.05;
	func_2DFA();
}

//Function Number: 10
func_31A6(param_00,param_01)
{
	var_02 = func_31A7(param_01,self);
	var_02.lifeid = param_00;
	func_2DF8();
	func_2DF6();
	var_03 = func_31A9(var_02,1);
	thread func_2DFB();
	thread func_2DFA();
	if(!isdefined(var_03))
	{
		var_03 = 0;
	}

	return var_03;
}

//Function Number: 11
func_31A7(param_00,param_01)
{
	var_02 = spawnturret("misc_turret",param_01.origin + (0,0,25),level.tanksettings[param_00].mgturretinfo);
	var_02.angles = param_01.angles;
	var_02.tanktype = param_00;
	var_02.owner = param_01;
	var_02 setmodel(level.tanksettings[param_00].modelbase);
	var_02 maketurretinoperable();
	var_02 setturretmodechangewait(1);
	var_02 setmode("sentry_offline");
	var_02 makeunusable();
	var_02 setsentryowner(param_01);
	return var_02;
}

//Function Number: 12
func_31A9(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	param_00 thread tank_setcarried(self);
	common_scripts\utility::_disableweapon();
	self notifyonplayercommand("place_tank","+attack");
	self notifyonplayercommand("place_tank","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_tank","+actionslot 4");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_tank","+actionslot 5");
		self notifyonplayercommand("cancel_tank","+actionslot 6");
		self notifyonplayercommand("cancel_tank","+actionslot 7");
	}

	for(;;)
	{
		var_02 = common_scripts\utility::waittill_any_return("place_tank","cancel_tank","force_cancel_placement");
		if(var_02 == "cancel_tank" || var_02 == "force_cancel_placement")
		{
			if(!param_01 && var_02 == "cancel_tank")
			{
				continue;
			}

			if(level.console)
			{
				var_03 = maps\mp\killstreaks\_killstreaks::func_2C01(level.tanksettings[param_00.tanktype].streakname);
				if(isdefined(self.killstreakindexweapon) && var_03 == maps\mp\killstreaks\_killstreaks::func_2C01(self.pers["killstreaks"][self.killstreakindexweapon].streakname) && !self getweaponslistitems().size)
				{
					maps\mp\_utility::_giveweapon(var_03,0);
					maps\mp\_utility::func_31F3(4,"weapon",var_03);
				}
			}

			param_00 tank_setcancelled();
			common_scripts\utility::_enableweapon();
			return 0;
		}

		if(!param_00.canbeplaced)
		{
			continue;
		}

		param_00 thread func_31B0();
		common_scripts\utility::_enableweapon();
		return 1;
	}
}

//Function Number: 13
tank_setcarried(param_00)
{
	self setmodel(level.tanksettings[self.tanktype].modelplacement);
	self setsentrycarrier(param_00);
	self setcontents(0);
	self setcandamage(0);
	self.carriedby = param_00;
	param_00.iscarrying = 1;
	param_00 thread func_31AB(self);
	thread tank_oncarrierdeath(param_00);
	thread tank_oncarrierdisconnect(param_00);
	thread tank_ongameended();
	self notify("carried");
}

//Function Number: 14
func_31AB(param_00)
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
		var_02 = self canplayerplacetank(25,25,50,40,80,0.7);
		param_00.origin = var_02["origin"];
		param_00.angles = var_02["angles"];
		param_00.canbeplaced = self isonground() && var_02["result"] && abs(var_02["origin"][2] - self.origin[2]) < 20;
		if(param_00.canbeplaced != var_01)
		{
			if(param_00.canbeplaced)
			{
				param_00 setmodel(level.tanksettings[param_00.tanktype].modelplacement);
				if(self.team != "spectator")
				{
					self forceusehinton(level.tanksettings[param_00.tanktype].stringplace);
				}
			}
			else
			{
				param_00 setmodel(level.tanksettings[param_00.tanktype].modelplacementfailed);
				if(self.team != "spectator")
				{
					self forceusehinton(level.tanksettings[param_00.tanktype].stringcannotplace);
				}
			}
		}

		var_01 = param_00.canbeplaced;
		wait 0.05;
	}
}

//Function Number: 15
tank_oncarrierdeath(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 waittill("death");
	tank_setcancelled();
}

//Function Number: 16
tank_oncarrierdisconnect(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 waittill("disconnect");
	tank_setcancelled();
}

//Function Number: 17
tank_ongameended(param_00)
{
	self endon("placed");
	self endon("death");
	level waittill("game_ended");
	tank_setcancelled();
}

//Function Number: 18
tank_setcancelled()
{
	if(isdefined(self.carriedby))
	{
		self.carriedby forceusehintoff();
	}

	if(isdefined(self.owner))
	{
		self.owner.iscarrying = 0;
	}

	self delete();
}

//Function Number: 19
func_31B0()
{
	self endon("death");
	level endon("game_ended");
	self notify("placed");
	self.carriedby forceusehintoff();
	self.carriedby = undefined;
	if(!isdefined(self.owner))
	{
		return 0;
	}

	var_00 = self.owner;
	var_00.iscarrying = 0;
	var_01 = func_31B2(self);
	if(!isdefined(var_01))
	{
		return 0;
	}

	var_01 playsound("sentry_gun_plant");
	var_01 notify("placed");
	var_01 thread func_31B4();
	self delete();
}

//Function Number: 20
func_31B1()
{
	self endon("death");
	level endon("game_ended");
	if(!isdefined(self.owner))
	{
		return;
	}

	var_00 = self.owner;
	var_00 endon("death");
	self waittill("placed");
	var_00 takekillstreakweapons(self.tanktype);
	var_00 maps\mp\_utility::_giveweapon(level.tanksettings[self.tanktype].laptopinfo);
	var_00 switchtoweaponimmediate(level.tanksettings[self.tanktype].laptopinfo);
}

//Function Number: 21
func_31B2(param_00)
{
	var_01 = param_00.owner;
	var_02 = param_00.tanktype;
	var_03 = param_00.lifeid;
	var_04 = spawnvehicle(level.tanksettings[var_02].modelbase,var_02,level.tanksettings[var_02].vehicleinfo,param_00.origin,param_00.angles,var_01);
	if(!isdefined(var_04))
	{
		return undefined;
	}

	var_05 = var_04 gettagorigin("tag_turret_attach");
	var_06 = spawnturret("misc_turret",var_05,level.tanksettings[var_02].mgturretinfo,0);
	var_06 linkto(var_04,"tag_turret_attach",(0,0,0),(0,0,0));
	var_06 setmodel(level.tanksettings[var_02].modelmgturret);
	var_06.health = level.tanksettings[var_02].health;
	var_06.owner = var_01;
	var_06.angles = var_01.angles;
	var_06.specialdamagecallback = ::callback_vehicledamage;
	var_06.tank = var_04;
	var_06 makeunusable();
	var_06 setdefaultdroppitch(0);
	var_06 setcandamage(0);
	var_04.specialdamagecallback = ::callback_vehicledamage;
	var_04.lifeid = var_03;
	var_04.team = var_01.team;
	var_04.owner = var_01;
	var_04.mgturret = var_06;
	var_04.health = level.tanksettings[var_02].health;
	var_04.maxhealth = level.tanksettings[var_02].maxhealth;
	var_04.damagetaken = 0;
	var_04.destroyed = 0;
	var_04 setcandamage(0);
	var_04.tanktype = var_02;
	var_06 setturretmodechangewait(1);
	var_04 func_31B8();
	var_06 setsentryowner(var_01);
	var_01.using_remote_tank = 0;
	var_01 setplayerdata("ugvMissile",1);
	var_01 setplayerdata("ugvDamageFade",1);
	var_01 setplayerdata("ugvDamaged",0);
	var_01 setplayerdata("ugvDamageState",0);
	var_01 setplayerdata("ugvBullets",0);
	var_01 setplayerdata("ugvMaxBullets",0);
	var_04.empgrenaded = 0;
	var_04.damagefade = 1;
	var_04 thread tank_incrementdamagefade();
	var_04 thread func_31BF();
	var_04 thread func_31B1();
	return var_04;
}

//Function Number: 22
func_31B4()
{
	self endon("death");
	self.owner endon("disconnect");
	level endon("game_ended");
	self makeunusable();
	self.mgturret maketurretsolid();
	self makevehiclesolidcapsule(23,23,23);
	if(!isdefined(self.owner))
	{
		return;
	}

	var_00 = self.owner;
	var_01 = (0,0,20);
	if(level.teambased)
	{
		self.team = var_00.team;
		self.mgturret.team = var_00.team;
		self.mgturret setturretteam(var_00.team);
		foreach(var_03 in level.players)
		{
			if(var_03 != var_00 && var_03.team == var_00.team)
			{
				var_04 = self.mgturret maps\mp\_entityheadicons::func_277C(var_03,maps\mp\gametypes\_teams::func_2770(self.team),var_01,10,10,0,0.05,0,1,0,1);
				if(isdefined(var_04))
				{
					var_04 settargetent(self);
				}
			}
		}
	}

	thread func_31BA();
	thread func_31BB();
	thread tank_handledeath();
	thread tank_handletimeout();
	thread func_31B6();
	thread func_31B7();
	func_31B5();
	var_00 openmenu("remotetank_timer");
}

//Function Number: 23
func_31B5()
{
	var_00 = self.owner;
	var_00 maps\mp\_utility::setusingremote(self.tanktype);
	if(getdvarint("camera_thirdPerson"))
	{
		var_00 maps\mp\_utility::setthirdpersondof(0);
	}

	var_00.restoreangles = var_00.angles;
	var_00 maps\mp\_utility::freezecontrolswrapper(1);
	var_01 = var_00 maps\mp\killstreaks\_killstreaks::initridekillstreak();
	if(var_01 != "success")
	{
		if(var_01 != "disconnect")
		{
			var_00 maps\mp\_utility::clearusingremote();
		}

		if(isdefined(var_00.disabledweapon) && var_00.disabledweapon)
		{
			var_00 common_scripts\utility::_enableweapon();
		}

		self notify("death");
		return 0;
	}

	var_00 maps\mp\_utility::freezecontrolswrapper(0);
	self.mgturret setcandamage(1);
	self setcandamage(1);
	var_00 remotecontrolvehicle(self);
	var_00 remotecontrolturret(self.mgturret);
	var_00 thread tank_watchfiring(self);
	var_00 thread tank_firemissiles(self);
	thread tank_earthquake();
	thread tank_playerexit();
	var_00.using_remote_tank = 1;
	if(var_00 maps\mp\_utility::isjuggernaut())
	{
		var_00.juggernautoverlay.alpha = 0;
	}

	var_00 maps\mp\_utility::_giveweapon(level.tanksettings[self.tanktype].remoteinfo);
	var_00 switchtoweaponimmediate(level.tanksettings[self.tanktype].remoteinfo);
	thread func_31C0();
	self.mgturret thread func_31C1();
}

//Function Number: 24
func_31B6()
{
	self endon("death");
	for(;;)
	{
		playfxontag(common_scripts\utility::func_539("remote_tank_antenna_light_mp"),self.mgturret,"tag_headlight_right");
		wait 1;
		stopfxontag(common_scripts\utility::func_539("remote_tank_antenna_light_mp"),self.mgturret,"tag_headlight_right");
	}
}

//Function Number: 25
func_31B7()
{
	self endon("death");
	for(;;)
	{
		playfxontag(common_scripts\utility::func_539("remote_tank_camera_light_mp"),self.mgturret,"tag_tail_light_right");
		wait 2;
		stopfxontag(common_scripts\utility::func_539("remote_tank_camera_light_mp"),self.mgturret,"tag_tail_light_right");
	}
}

//Function Number: 26
func_31B8()
{
	self.mgturret setmode(level.tanksettings[self.tanktype].sentrymodeoff);
	if(level.teambased)
	{
		maps\mp\_entityheadicons::setteamheadicon("none",(0,0,0));
	}
	else if(isdefined(self.owner))
	{
		maps\mp\_entityheadicons::setplayerheadicon(undefined,(0,0,0));
	}

	if(!isdefined(self.owner))
	{
		return;
	}

	var_00 = self.owner;
	if(isdefined(var_00.using_remote_tank) && var_00.using_remote_tank)
	{
		var_00 notify("end_remote");
		var_00 remotecontrolvehicleoff(self);
		var_00 remotecontrolturretoff(self.mgturret);
		var_00 switchtoweapon(var_00 common_scripts\utility::getlastweapon());
		var_00 maps\mp\_utility::clearusingremote();
		var_00 setplayerangles(var_00.restoreangles);
		if(getdvarint("camera_thirdPerson"))
		{
			var_00 maps\mp\_utility::setthirdpersondof(1);
		}

		if(isdefined(var_00.disabledusability) && var_00.disabledusability)
		{
			var_00 common_scripts\utility::_enableusability();
		}

		var_00 takekillstreakweapons(level.tanksettings[self.tanktype].streakname);
		var_00.using_remote_tank = 0;
		var_00 thread tank_freezebuffer();
	}
}

//Function Number: 27
tank_freezebuffer()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	maps\mp\_utility::freezecontrolswrapper(1);
	wait 0.5;
	maps\mp\_utility::freezecontrolswrapper(0);
}

//Function Number: 28
func_31BA()
{
	self endon("death");
	self.owner waittill("disconnect");
	if(isdefined(self.mgturret))
	{
		self.mgturret notify("death");
	}

	self notify("death");
}

//Function Number: 29
func_31BB()
{
	self endon("death");
	self.owner common_scripts\utility::waittill_any("joined_team","joined_spectators");
	self notify("death");
}

//Function Number: 30
tank_handletimeout()
{
	self endon("death");
	var_00 = level.tanksettings[self.tanktype].timeout;
	setdvar("ui_remoteTankUseTime",var_00);
	maps\mp\gametypes\_hostmigration::func_2740(var_00);
	self notify("death");
}

//Function Number: 31
tank_handledeath()
{
	level endon("game_ended");
	var_00 = self getentitynumber();
	addtougvlist(var_00);
	self waittill("death");
	self playsound("talon_destroyed");
	removefromugvlist(var_00);
	self setmodel(level.tanksettings[self.tanktype].modeldestroyed);
	if(isdefined(self.owner) && self.owner.using_remote_tank || self.owner maps\mp\_utility::isusingremote())
	{
		self.owner setplayerdata("ugvDamageState",0);
		func_31B8();
		self.owner.using_remote_tank = 0;
		if(self.owner maps\mp\_utility::isjuggernaut())
		{
			self.owner.juggernautoverlay.alpha = 1;
		}
	}

	self.mgturret setdefaultdroppitch(40);
	self.mgturret setsentryowner(undefined);
	self playsound("sentry_explode");
	playfxontag(level._effect["remote_tank_dying"],self.mgturret,"tag_aim");
	wait 2;
	playfx(level._effect["remote_tank_explode"],self.origin);
	self.mgturret delete();
	maps\mp\_utility::func_80C8();
	self delete();
}

//Function Number: 32
callback_vehicledamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = self;
	if(isdefined(self.tank))
	{
		var_0C = self.tank;
	}

	if(isdefined(var_0C.alreadydead) && var_0C.alreadydead)
	{
		return;
	}

	if(!maps\mp\gametypes\_weapons::func_27A1(var_0C.owner,param_01))
	{
		return;
	}

	if(isdefined(param_03) && param_03 & level.idflags_penetration)
	{
		var_0C.wasdamagedfrombulletpenetration = 1;
	}

	var_0C.wasdamaged = 1;
	var_0C.damagefade = 0;
	var_0C.owner setplayerdata("ugvDamaged",1);
	playfxontagforclients(level._effect["remote_tank_spark"],var_0C,"tag_player",var_0C.owner);
	if(isdefined(param_05))
	{
		switch(param_05)
		{
			case "stealth_bomb_mp":
			case "artillery_mp":
				param_02 = param_02 * 4;
				break;
		}
	}

	if(param_04 == "MOD_MELEE")
	{
		param_02 = var_0C.maxhealth * 0.5;
	}

	var_0D = param_02;
	if(isplayer(param_01))
	{
		param_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("remote_tank");
		if(param_04 == "MOD_RIFLE_BULLET" || param_04 == "MOD_PISTOL_BULLET")
		{
			if(param_01 maps\mp\_utility::func_27AF("specialty_armorpiercing"))
			{
				var_0D = var_0D + param_02 * level.armorpiercingmod;
			}
		}

		if(isexplosivedamagemod(param_04))
		{
			var_0D = var_0D + param_02;
		}
	}

	if(isexplosivedamagemod(param_04) && isdefined(param_05) && param_05 == "destructible_car")
	{
		var_0D = var_0C.maxhealth;
	}

	if(isdefined(param_01.owner) && isplayer(param_01.owner))
	{
		param_01.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback("remote_tank");
	}

	if(isdefined(param_05))
	{
		switch(param_05)
		{
			case "remote_mortar_missile_mp":
			case "javelin_mp":
			case "stinger_mp":
			case "remotemissile_projectile_mp":
			case "ac130_40mm_mp":
			case "ac130_105mm_mp":
				var_0C.largeprojectiledamage = 1;
				var_0D = var_0C.maxhealth + 1;
				break;

			case "stealth_bomb_mp":
			case "artillery_mp":
				var_0C.largeprojectiledamage = 0;
				var_0D = var_0C.maxhealth * 0.5;
				break;

			case "bomb_site_mp":
				var_0C.largeprojectiledamage = 0;
				var_0D = var_0C.maxhealth + 1;
				break;

			case "emp_grenade_mp":
				var_0D = 0;
				var_0C thread tank_empgrenaded();
				break;

			case "ims_projectile_mp":
				var_0C.largeprojectiledamage = 1;
				var_0D = var_0C.maxhealth * 0.5;
				break;
		}

		maps\mp\killstreaks\_killstreaks::killstreakhit(param_01,param_05,self);
	}

	var_0C.damagetaken = var_0C.damagetaken + var_0D;
	var_0C playsound("talon_damaged");
	if(var_0C.damagetaken >= var_0C.maxhealth)
	{
		if(isplayer(param_01) && !isdefined(var_0C.owner) || param_01 != var_0C.owner)
		{
			var_0C.alreadydead = 1;
			param_01 notify("destroyed_killstreak",param_05);
			thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_remote_tank",param_01);
			param_01 thread maps\mp\gametypes\_rank::func_2AB3("kill",300,param_05,param_04);
			param_01 thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_DESTROYED_REMOTE_TANK");
			thread maps\mp\gametypes\_missions::vehiclekilled(var_0C.owner,var_0C,undefined,param_01,param_02,param_04,param_05);
		}

		var_0C notify("death");
	}
}

//Function Number: 33
tank_empgrenaded()
{
	self notify("tank_EMPGrenaded");
	self endon("tank_EMPGrenaded");
	self endon("death");
	self.owner endon("disconnect");
	level endon("game_ended");
	self.empgrenaded = 1;
	self.owner setplayerdata("ugvDamageFade",0);
	var_00 = self.owner getplayerdata("ugvBullets");
	self.owner setplayerdata("ugvBullets",0);
	self.owner setplayerdata("ugvMissile",0);
	self.mgturret turretfiredisable();
	wait 3.5;
	self.empgrenaded = 0;
	self.owner setplayerdata("ugvBullets",var_00);
	self.owner setplayerdata("ugvMissile",1);
	self.mgturret turretfireenable();
}

//Function Number: 34
tank_incrementdamagefade()
{
	self endon("death");
	level endon("game_ended");
	var_00 = 0;
	for(;;)
	{
		if(!self.empgrenaded)
		{
			if(self.damagefade < 1)
			{
				self.owner setplayerdata("ugvDamageFade",self.damagefade);
				self.damagefade = self.damagefade + 0.1;
				var_00 = 1;
			}
			else if(var_00)
			{
				self.damagefade = 1;
				self.owner setplayerdata("ugvDamageFade",self.damagefade);
				self.owner setplayerdata("ugvDamaged",0);
				var_00 = 0;
			}
		}

		wait 0.1;
	}
}

//Function Number: 35
func_31BF()
{
	self endon("death");
	level endon("game_ended");
	var_00 = 0.1;
	var_01 = 1;
	var_02 = 1;
	for(;;)
	{
		if(var_02)
		{
			if(self.damagetaken > 0)
			{
				var_02 = 0;
				self.owner setplayerdata("ugvDamageState",var_01);
				var_01++;
			}
		}
		else if(self.damagetaken >= self.maxhealth * var_00 * var_01)
		{
			self.owner setplayerdata("ugvDamageState",var_01);
			var_01++;
		}

		wait 0.05;
	}
}

//Function Number: 36
func_31C0()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(self.specialdamagecallback))
		{
			self [[ self.specialdamagecallback ]](undefined,var_01,var_00,var_08,var_04,var_09,var_03,var_02,undefined,undefined,var_05,var_07);
		}
	}
}

//Function Number: 37
func_31C1()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(self.specialdamagecallback) && isdefined(self.tank) && !isexplosivedamagemod(var_04) || isdefined(var_09) && isexplosivedamagemod(var_04) && var_09 == "stealth_bomb_mp" || var_09 == "artillery_mp")
		{
			self.tank [[ self.specialdamagecallback ]](undefined,var_01,var_00,var_08,var_04,var_09,var_03,var_02,undefined,undefined,var_05,var_07);
		}
	}
}

//Function Number: 38
tank_watchfiring(param_00)
{
	self endon("disconnect");
	self endon("end_remote");
	param_00 endon("death");
	var_01 = 50;
	var_02 = var_01;
	self setplayerdata("ugvMaxBullets",var_01);
	self setplayerdata("ugvBullets",var_02);
	var_03 = weaponfiretime(level.tanksettings[param_00.tanktype].mgturretinfo);
	for(;;)
	{
		if(param_00.mgturret isfiringvehicleturret())
		{
			var_02--;
			self setplayerdata("ugvBullets",var_02);
			if(var_02 <= 0)
			{
				param_00.mgturret turretfiredisable();
				wait 2.5;
				param_00 playsound("talon_reload");
				self playlocalsound("talon_reload_plr");
				var_02 = var_01;
				self setplayerdata("ugvBullets",var_02);
				param_00.mgturret turretfireenable();
			}
		}

		wait var_03;
	}
}

//Function Number: 39
tank_firemissiles(param_00)
{
	self endon("disconnect");
	self endon("end_remote");
	level endon("game_ended");
	param_00 endon("death");
	var_01 = 0;
	for(;;)
	{
		if(self fragbuttonpressed() && !param_00.empgrenaded)
		{
			var_02 = param_00.mgturret.origin;
			var_03 = param_00.mgturret.angles;
			switch(var_01)
			{
				case 0:
					var_02 = param_00.mgturret gettagorigin("tag_missile1");
					var_03 = param_00.mgturret gettagangles("tag_player");
					break;
	
				case 1:
					var_02 = param_00.mgturret gettagorigin("tag_missile2");
					var_03 = param_00.mgturret gettagangles("tag_player");
					break;
			}

			param_00 playsound("talon_missile_fire");
			self playlocalsound("talon_missile_fire_plr");
			var_04 = var_02 + anglestoforward(var_03) * 100;
			var_05 = magicbullet(level.tanksettings[param_00.tanktype].missileinfo,var_02,var_04,self);
			var_01 = var_01 + 1 % 2;
			self setplayerdata("ugvMissile",0);
			wait 5;
			param_00 playsound("talon_rocket_reload");
			self playlocalsound("talon_rocket_reload_plr");
			self setplayerdata("ugvMissile",1);
			continue;
		}

		wait 0.05;
	}
}

//Function Number: 40
tank_earthquake()
{
	self endon("death");
	self.owner endon("end_remote");
	for(;;)
	{
		earthquake(0.1,0.25,self.mgturret gettagorigin("tag_player"),50);
		wait 0.25;
	}
}

//Function Number: 41
addtougvlist(param_00)
{
	level.ugvs[param_00] = self;
}

//Function Number: 42
removefromugvlist(param_00)
{
	level.ugvs[param_00] = undefined;
}

//Function Number: 43
tank_playerexit()
{
	if(!isdefined(self.owner))
	{
		return;
	}

	var_00 = self.owner;
	level endon("game_ended");
	var_00 endon("disconnect");
	var_00 endon("end_remote");
	self endon("death");
	for(;;)
	{
		var_01 = 0;
		while(var_00 usebuttonpressed())
		{
			var_01 = var_01 + 0.05;
			if(var_01 > 0.75)
			{
				self notify("death");
				return;
			}

			wait 0.05;
		}

		wait 0.05;
	}
}