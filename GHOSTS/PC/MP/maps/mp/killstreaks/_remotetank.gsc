/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_remotetank.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 46
 * Decompile Time: 816 ms
 * Timestamp: 10/27/2023 1:21:31 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killstreakfuncs["remote_tank"] = ::func_844E;
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
	level.tanksettings["remote_tank"].stringplace = &"KILLSTREAKS_REMOTE_TANK_PLACE";
	level.tanksettings["remote_tank"].stringcannotplace = &"KILLSTREAKS_REMOTE_TANK_CANNOT_PLACE";
	level.tanksettings["remote_tank"].laptopinfo = "killstreak_remote_tank_laptop_mp";
	level.tanksettings["remote_tank"].remoteinfo = "killstreak_remote_tank_remote_mp";
	level._effect["remote_tank_dying"] = loadfx("fx/explosions/killstreak_explosion_quick");
	level._effect["remote_tank_explode"] = loadfx("fx/explosions/bouncing_betty_explosion");
	level._effect["remote_tank_spark"] = loadfx("fx/impacts/large_metal_painted_hit");
	level._effect["remote_tank_antenna_light_mp"] = loadfx("fx/misc/aircraft_light_red_blink");
	level._effect["remote_tank_camera_light_mp"] = loadfx("fx/misc/aircraft_light_wingtip_green");
	level.remote_tank_armor_bulletdamage = 0.5;
}

//Function Number: 2
func_844E(param_00,param_01)
{
	var_02 = 1;
	if(maps\mp\_utility::func_21E7() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	maps\mp\_utility::func_4487();
	var_03 = givetank(param_00,"remote_tank");
	if(var_03)
	{
		maps\mp\_matchdata::func_4F1D("remote_tank",self.origin);
		thread maps\mp\_utility::func_7FA0("used_remote_tank",self);
		func_7E88("remote_tank");
	}
	else
	{
		maps\mp\_utility::decrementfauxvehiclecount();
	}

	self.iscarrying = 0;
	return var_03;
}

//Function Number: 3
func_7E88(param_00)
{
	if(!maps\mp\_utility::func_47BB())
	{
		var_01 = maps\mp\_utility::getkillstreakweapon(level.tanksettings[param_00].streakname);
	}
	else
	{
		var_01 = "killstreak_remote_tank_mp";
	}

	maps\mp\killstreaks\_killstreaks::func_7E87(var_01);
	self takeweapon(level.tanksettings[param_00].laptopinfo);
	self takeweapon(level.tanksettings[param_00].remoteinfo);
}

//Function Number: 4
func_65A6()
{
	if(maps\mp\_utility::_hasperk("specialty_explosivebullets"))
	{
		self.restoreperk = "specialty_explosivebullets";
		maps\mp\_utility::_unsetperk("specialty_explosivebullets");
	}
}

//Function Number: 5
func_665E()
{
	if(isdefined(self.restoreperk))
	{
		maps\mp\_utility::func_3CFB(self.restoreperk,0);
		self.restoreperk = undefined;
	}
}

//Function Number: 6
func_8B12()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	func_665E();
}

//Function Number: 7
func_65BE()
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
func_6667()
{
	if(!isdefined(self.restoreweaponclipammo) || !isdefined(self.restoreweaponstockammo) || !isdefined(self.weaponstorestore))
	{
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
func_8B13()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	func_6667();
}

//Function Number: 10
givetank(param_00,param_01)
{
	var_02 = func_2125(param_01,self);
	var_02.lifeid = param_00;
	func_65A6();
	func_65BE();
	var_03 = setcarryingtank(var_02,1);
	thread func_665E();
	thread func_6667();
	if(!isdefined(var_03))
	{
		var_03 = 0;
	}

	return var_03;
}

//Function Number: 11
func_2125(param_00,param_01)
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
setcarryingtank(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	param_00 thread func_7F07(self);
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
		var_02 = common_scripts\utility::func_8B33("place_tank","cancel_tank","force_cancel_placement");
		if(var_02 == "cancel_tank" || var_02 == "force_cancel_placement")
		{
			if(!param_01 && var_02 == "cancel_tank")
			{
				continue;
			}

			if(level.console)
			{
				var_03 = maps\mp\_utility::getkillstreakweapon(level.tanksettings[param_00.tanktype].streakname);
				if(isdefined(self.killstreakindexweapon) && var_03 == maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname) && !self getweaponslistitems().size)
				{
					maps\mp\_utility::_giveweapon(var_03,0);
					maps\mp\_utility::_setactionslot(4,"weapon",var_03);
				}
			}

			param_00 func_7F06();
			common_scripts\utility::_enableweapon();
			return 0;
		}

		if(!param_00.canbeplaced)
		{
			continue;
		}

		param_00 thread func_7F09();
		common_scripts\utility::_enableweapon();
		return 1;
	}
}

//Function Number: 13
func_7F07(param_00)
{
	self setmodel(level.tanksettings[self.tanktype].modelplacement);
	self setsentrycarrier(param_00);
	self setcontents(0);
	self setcandamage(0);
	self.carriedby = param_00;
	param_00.iscarrying = 1;
	param_00 thread func_873B(self);
	thread func_7EF9(param_00);
	thread func_7EFA(param_00);
	thread func_7EFB();
	self notify("carried");
}

//Function Number: 14
func_873B(param_00)
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
		if(maps\mp\_utility::func_47BB())
		{
			param_00.canbeplaced = param_00.canbeplaced && !self.var_465B;
		}

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
					if(!maps\mp\_utility::func_47BB())
					{
						self forceusehinton(level.tanksettings[param_00.tanktype].stringcannotplace);
					}
					else if(!self.var_465B)
					{
						self forceusehinton(level.tanksettings[param_00.tanktype].stringcannotplace);
					}
				}
			}
		}

		var_01 = param_00.canbeplaced;
		wait(0.05);
	}
}

//Function Number: 15
func_7EF9(param_00)
{
	self endon("placed");
	self endon("death");
	if(!maps\mp\_utility::func_47BB())
	{
		param_00 waittill("death");
	}
	else
	{
		param_00 common_scripts\utility::func_8B2A("death","last_stand");
		param_00 notify("cancel_tank");
	}

	func_7F06();
}

//Function Number: 16
func_7EFA(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 waittill("disconnect");
	func_7F06();
}

//Function Number: 17
func_7EFB(param_00)
{
	self endon("placed");
	self endon("death");
	level waittill("game_ended");
	func_7F06();
}

//Function Number: 18
func_7F06()
{
	if(isdefined(self.carriedby))
	{
		self.carriedby forceusehintoff();
	}

	if(isdefined(self.owner))
	{
		self.owner.iscarrying = 0;
	}

	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 19
func_7F09()
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
	var_01 = createtank(self);
	if(!isdefined(var_01))
	{
		return 0;
	}

	var_01 playsound("sentry_gun_plant");
	var_01 notify("placed");
	var_01 thread func_7F05();
	self delete();
}

//Function Number: 20
func_7ED5()
{
	self endon("death");
	level endon("game_ended");
	if(!isdefined(self.owner))
	{
	}

	var_00 = self.owner;
	var_00 endon("death");
	self waittill("placed");
	var_00 func_7E88(self.tanktype);
	var_00 maps\mp\_utility::_giveweapon(level.tanksettings[self.tanktype].laptopinfo);
	var_00 switchtoweaponimmediate(level.tanksettings[self.tanktype].laptopinfo);
}

//Function Number: 21
createtank(param_00)
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
	var_04 setotherent(var_01);
	var_04.mgturret = var_06;
	var_04.health = level.tanksettings[var_02].health;
	var_04.maxhealth = level.tanksettings[var_02].maxhealth;
	var_04.damagetaken = 0;
	var_04.destroyed = 0;
	var_04 setcandamage(0);
	var_04.tanktype = var_02;
	var_04 common_scripts\utility::func_5009(var_04.team);
	var_06 setturretmodechangewait(1);
	var_04 tank_setinactive();
	var_06 setsentryowner(var_01);
	var_01.using_remote_tank = 0;
	var_04.empgrenaded = 0;
	var_04.damagefade = 1;
	var_04 thread func_7EF3();
	var_04 thread tank_watchlowhealth();
	var_04 thread func_7ED5();
	return var_04;
}

//Function Number: 22
func_7F05()
{
	self endon("death");
	self.owner endon("disconnect");
	level endon("game_ended");
	self makeunusable();
	self.mgturret maketurretsolid();
	self makevehiclesolidcapsule(23,23,23);
	if(!isdefined(self.owner))
	{
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
				var_04 = self.mgturret maps\mp\_entityheadicons::setheadicon(var_03,maps\mp\gametypes\_teams::func_3C38(self.team),var_01,10,10,0,0.05,0,1,0,1);
				if(isdefined(var_04))
				{
					var_04 settargetent(self);
				}
			}
		}
	}

	thread func_7EDB();
	thread func_7EDC();
	thread func_7ED8();
	thread tank_handledeath();
	thread func_7EDD();
	thread func_7EB0();
	thread func_7EB1();
	func_7AFE();
}

//Function Number: 23
func_7AFE()
{
	var_00 = self.owner;
	var_00 maps\mp\_utility::func_720F(self.tanktype);
	if(maps\mp\_utility::func_47BB())
	{
		var_00 visionsetthermalforplayer("black_bw",0);
		var_00 visionsetthermalforplayer(game["thermal_vision"],1.5);
		var_00 thermalvisionon();
		var_00 thermalvisionfofoverlayon();
	}

	if(getdvarint("camera_thirdPerson"))
	{
		var_00 maps\mp\_utility::func_70E6(0);
	}

	var_00.restoreangles = var_00.angles;
	var_00 maps\mp\_utility::func_350E(1);
	var_01 = var_00 maps\mp\killstreaks\_killstreaks::func_4649("remote_tank");
	if(var_01 != "success")
	{
		if(var_01 != "disconnect")
		{
			var_00 maps\mp\_utility::func_1D59();
		}

		if(isdefined(var_00.disabledweapon) && var_00.disabledweapon)
		{
			var_00 common_scripts\utility::_enableweapon();
		}

		self notify("death");
		return 0;
	}

	var_00 maps\mp\_utility::func_350E(0);
	self.mgturret setcandamage(1);
	self setcandamage(1);
	var_02 = spawnstruct();
	var_02.playdeathfx = 1;
	var_02.deathoverridecallback = ::func_7EFC;
	thread maps\mp\_movers::func_3F25(var_02);
	var_00 remotecontrolvehicle(self);
	var_00 remotecontrolturret(self.mgturret);
	var_00 thread func_7F1D(self);
	if(maps\mp\_utility::func_47BB())
	{
		var_00 thread tank_dropmines(self);
	}
	else
	{
		var_00 thread func_7ED2(self);
	}

	thread func_7ECE();
	thread func_7EFE();
	var_00.using_remote_tank = 1;
	var_00 maps\mp\_utility::_giveweapon(level.tanksettings[self.tanktype].remoteinfo);
	var_00 switchtoweaponimmediate(level.tanksettings[self.tanktype].remoteinfo);
	thread func_7ED9();
	self.mgturret thread func_7F15();
}

//Function Number: 24
func_7EB0()
{
	self endon("death");
	for(;;)
	{
		playfxontag(common_scripts\utility::func_3AB9("remote_tank_antenna_light_mp"),self.mgturret,"tag_headlight_right");
		wait(1);
		stopfxontag(common_scripts\utility::func_3AB9("remote_tank_antenna_light_mp"),self.mgturret,"tag_headlight_right");
	}
}

//Function Number: 25
func_7EB1()
{
	self endon("death");
	for(;;)
	{
		playfxontag(common_scripts\utility::func_3AB9("remote_tank_camera_light_mp"),self.mgturret,"tag_tail_light_right");
		wait(2);
		stopfxontag(common_scripts\utility::func_3AB9("remote_tank_camera_light_mp"),self.mgturret,"tag_tail_light_right");
	}
}

//Function Number: 26
tank_setinactive()
{
	self.mgturret setmode(level.tanksettings[self.tanktype].sentrymodeoff);
	if(level.teambased)
	{
		maps\mp\_entityheadicons::func_70E0("none",(0,0,0));
	}
	else if(isdefined(self.owner))
	{
		maps\mp\_entityheadicons::func_7099(undefined,(0,0,0));
	}

	if(!isdefined(self.owner))
	{
	}

	var_00 = self.owner;
	if(isdefined(var_00.using_remote_tank) && var_00.using_remote_tank)
	{
		var_00 notify("end_remote");
		if(maps\mp\_utility::func_47BB())
		{
			var_00 thermalvisionoff();
			var_00 thermalvisionfofoverlayoff();
		}

		var_00 remotecontrolvehicleoff(self);
		var_00 remotecontrolturretoff(self.mgturret);
		var_00 switchtoweapon(var_00 common_scripts\utility::func_3B0A());
		var_00 maps\mp\_utility::func_1D59();
		var_00 setplayerangles(var_00.restoreangles);
		if(getdvarint("camera_thirdPerson"))
		{
			var_00 maps\mp\_utility::func_70E6(1);
		}

		if(maps\mp\_utility::func_47BB())
		{
			var_00 visionsetthermalforplayer(game["thermal_vision"],0);
		}

		if(isdefined(var_00.disabledusability) && var_00.disabledusability)
		{
			var_00 common_scripts\utility::_enableusability();
		}

		var_00 func_7E88(level.tanksettings[self.tanktype].streakname);
		var_00.using_remote_tank = 0;
		var_00 thread func_7ED3();
	}
}

//Function Number: 27
func_7ED3()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	maps\mp\_utility::func_350E(1);
	wait(0.5);
	maps\mp\_utility::func_350E(0);
}

//Function Number: 28
func_7EDB()
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
func_7EDC()
{
	self endon("death");
	self.owner waittill("stop_using_remote");
	self notify("death");
}

//Function Number: 30
func_7ED8()
{
	self endon("death");
	self.owner common_scripts\utility::func_8B2A("joined_team","joined_spectators");
	self notify("death");
}

//Function Number: 31
func_7EDD()
{
	self endon("death");
	var_00 = level.tanksettings[self.tanktype].timeout;
	maps\mp\gametypes\_hostmigration::func_8B0D(var_00);
	self notify("death");
}

//Function Number: 32
func_7EFC(param_00)
{
	self notify("death");
}

//Function Number: 33
tank_handledeath()
{
	level endon("game_ended");
	var_00 = self getentitynumber();
	addtougvlist(var_00);
	self waittill("death");
	self playsound("talon_destroyed");
	func_6598(var_00);
	self setmodel(level.tanksettings[self.tanktype].modeldestroyed);
	if(isdefined(self.owner) && self.owner.using_remote_tank || self.owner maps\mp\_utility::func_4995())
	{
		tank_setinactive();
		self.owner.using_remote_tank = 0;
	}

	self.mgturret setdefaultdroppitch(40);
	self.mgturret setsentryowner(undefined);
	self playsound("sentry_explode");
	playfxontag(level._effect["remote_tank_dying"],self.mgturret,"tag_aim");
	wait(2);
	playfx(level._effect["remote_tank_explode"],self.origin);
	self.mgturret delete();
	maps\mp\_utility::decrementfauxvehiclecount();
	self delete();
}

//Function Number: 34
callback_vehicledamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = self;
	if(isdefined(self.tank))
	{
		var_0C = self.tank;
	}

	if(isdefined(var_0C.alreadydead) && var_0C.alreadydead)
	{
	}

	if(!maps\mp\gametypes\_weapons::func_357F(var_0C.owner,param_01))
	{
	}

	if(isdefined(param_03) && param_03 & level.idflags_penetration)
	{
		var_0C.wasdamagedfrombulletpenetration = 1;
	}

	var_0C.wasdamaged = 1;
	var_0C.damagefade = 0;
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
		param_01 maps\mp\gametypes\_damagefeedback::func_86E0("remote_tank");
		if(param_04 == "MOD_RIFLE_BULLET" || param_04 == "MOD_PISTOL_BULLET")
		{
			if(param_01 maps\mp\_utility::_hasperk("specialty_armorpiercing"))
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
		param_01.owner maps\mp\gametypes\_damagefeedback::func_86E0("remote_tank");
	}

	if(isdefined(param_05))
	{
		switch(param_05)
		{
			case "remotemissile_projectile_mp":
			case "ac130_40mm_mp":
			case "ac130_105mm_mp":
			case "javelin_mp":
			case "remote_mortar_missile_mp":
			case "stinger_mp":
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
				var_0C thread func_7ECF();
				break;

			case "ims_projectile_mp":
				var_0C.largeprojectiledamage = 1;
				var_0D = var_0C.maxhealth * 0.5;
				break;
		}

		maps\mp\killstreaks\_killstreaks::func_4B39(param_01,param_05,self);
	}

	var_0C.damagetaken = var_0C.damagetaken + var_0D;
	var_0C playsound("talon_damaged");
	if(var_0C.damagetaken >= var_0C.maxhealth)
	{
		if(isplayer(param_01) && !isdefined(var_0C.owner) || param_01 != var_0C.owner)
		{
			var_0C.alreadydead = 1;
			param_01 notify("destroyed_killstreak",param_05);
			thread maps\mp\_utility::func_7FA0("callout_destroyed_remote_tank",param_01);
			param_01 thread maps\mp\gametypes\_rank::giverankxp("kill",300,param_05,param_04);
			param_01 thread maps\mp\gametypes\_rank::func_8E6E("destroyed_remote_tank");
			thread maps\mp\gametypes\_missions::vehiclekilled(var_0C.owner,var_0C,undefined,param_01,param_02,param_04,param_05);
		}

		var_0C notify("death");
	}
}

//Function Number: 35
func_7ECF()
{
	self notify("tank_EMPGrenaded");
	self endon("tank_EMPGrenaded");
	self endon("death");
	self.owner endon("disconnect");
	level endon("game_ended");
	self.empgrenaded = 1;
	self.mgturret turretfiredisable();
	wait(3.5);
	self.empgrenaded = 0;
	self.mgturret turretfireenable();
}

//Function Number: 36
func_7EF3()
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
				self.damagefade = self.damagefade + 0.1;
				var_00 = 1;
			}
			else if(var_00)
			{
				self.damagefade = 1;
				var_00 = 0;
			}
		}

		wait(0.1);
	}
}

//Function Number: 37
tank_watchlowhealth()
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
				var_01++;
			}
		}
		else if(self.damagetaken >= self.maxhealth * var_00 * var_01)
		{
			var_01++;
		}

		wait(0.05);
	}
}

//Function Number: 38
func_7ED9()
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

//Function Number: 39
func_7F15()
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

//Function Number: 40
func_7F1D(param_00)
{
	self endon("disconnect");
	self endon("end_remote");
	param_00 endon("death");
	var_01 = 50;
	var_02 = var_01;
	var_03 = weaponfiretime(level.tanksettings[param_00.tanktype].mgturretinfo);
	for(;;)
	{
		if(param_00.mgturret isfiringvehicleturret())
		{
			var_02--;
			if(var_02 <= 0)
			{
				param_00.mgturret turretfiredisable();
				wait(2.5);
				param_00 playsound("talon_reload");
				self playlocalsound("talon_reload_plr");
				var_02 = var_01;
				param_00.mgturret turretfireenable();
			}
		}

		wait(var_03);
	}
}

//Function Number: 41
func_7ED2(param_00)
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
			wait(5);
			param_00 playsound("talon_rocket_reload");
			self playlocalsound("talon_rocket_reload_plr");
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 42
tank_dropmines(param_00)
{
	self endon("disconnect");
	self endon("end_remote");
	level endon("game_ended");
	param_00 endon("death");
	for(;;)
	{
		if(self secondaryoffhandbuttonpressed())
		{
			var_01 = bullettrace(param_00.origin + (0,0,4),param_00.origin - (0,0,4),0,param_00);
			var_02 = vectornormalize(var_01["normal"]);
			var_03 = vectortoangles(var_02);
			var_03 = var_03 + (90,0,0);
			var_04 = maps\mp\gametypes\_weapons::func_78AE(param_00.origin,self,"equipment",var_03);
			param_00 playsound("item_blast_shield_on");
			wait(8);
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 43
func_7ECE()
{
	self endon("death");
	self.owner endon("end_remote");
	for(;;)
	{
		earthquake(0.1,0.25,self.mgturret gettagorigin("tag_player"),50);
		wait(0.25);
	}
}

//Function Number: 44
addtougvlist(param_00)
{
	level.ugvs[param_00] = self;
}

//Function Number: 45
func_6598(param_00)
{
	level.ugvs[param_00] = undefined;
}

//Function Number: 46
func_7EFE()
{
	if(!isdefined(self.owner))
	{
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
			}

			wait(0.05);
		}

		wait(0.05);
	}
}