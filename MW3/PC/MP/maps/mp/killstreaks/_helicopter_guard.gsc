/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_helicopter_guard.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 750 ms
 * Timestamp: 10/27/2023 2:14:13 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakfuncs["littlebird_support"] = ::tryuselbsupport;
	level.heliguardsettings = [];
	level.heliguardsettings["littlebird_support"] = spawnstruct();
	level.heliguardsettings["littlebird_support"].timeout = 60;
	level.heliguardsettings["littlebird_support"].health = 999999;
	level.heliguardsettings["littlebird_support"].maxhealth = 2000;
	level.heliguardsettings["littlebird_support"].streakname = "littlebird_support";
	level.heliguardsettings["littlebird_support"].vehicleinfo = "attack_littlebird_mp";
	level.heliguardsettings["littlebird_support"].weaponinfo = "littlebird_guard_minigun_mp";
	level.heliguardsettings["littlebird_support"].weaponmodelleft = "vehicle_little_bird_minigun_left";
	level.heliguardsettings["littlebird_support"].weaponmodelright = "vehicle_little_bird_minigun_right";
	level.heliguardsettings["littlebird_support"].weapontagleft = "tag_minigun_attach_left";
	level.heliguardsettings["littlebird_support"].weapontagright = "tag_minigun_attach_right";
	level.heliguardsettings["littlebird_support"].sentrymode = "auto_nonai";
	level.heliguardsettings["littlebird_support"].modelbase = "vehicle_little_bird_armed";
	level.heliguardsettings["littlebird_support"].teamsplash = "used_littlebird_support";
	foreach(var_01 in level.heliguardsettings)
	{
		precachevehicle(var_01.vehicleinfo);
		precacheturret(var_01.weaponinfo);
		precachemodel(var_01.weaponmodelleft);
		precachemodel(var_01.weaponmodelright);
		precachemodel(var_01.modelbase);
	}

	lbsupport_setairstartnodes();
	lbsupport_setairnodemesh();
}

//Function Number: 2
tryuselbsupport(param_00)
{
	var_01 = "littlebird_support";
	var_02 = 1;
	if(isdefined(level.civilianjetflyby))
	{
		self iprintlnbold(&"MP_CIVILIAN_AIR_TRAFFIC");
		return 0;
	}
	else if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}
	else if(isdefined(level.littlebirdguard) || maps\mp\killstreaks\_helicopter::exceededmaxlittlebirds(var_01))
	{
		self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(!level.air_node_mesh.size)
	{
		self iprintlnbold(&"MP_UNAVAILABLE_IN_LEVEL");
		return 0;
	}
	else if(maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
		return 0;
	}

	maps\mp\_utility::incrementfauxvehiclecount();
	var_03 = createlbguard(var_01);
	if(!isdefined(var_03))
	{
		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	thread startlbsupport(var_03);
	level thread maps\mp\_utility::teamplayercardsplash(level.heliguardsettings[var_01].teamsplash,self,self.team);
	return 1;
}

//Function Number: 3
createlbguard(param_00)
{
	var_01 = lbsupport_getcloseststartnode(self.origin);
	if(isdefined(var_01.angles))
	{
		var_02 = var_01.angles;
	}
	else
	{
		var_02 = (0,0,0);
	}

	var_03 = maps\mp\killstreaks\_airdrop::getflyheightoffset(self.origin);
	var_04 = lbsupport_getclosestnode(self.origin);
	var_04 = lbsupport_tu0_new_incoming_position(var_04);
	var_05 = anglestoforward(self.angles);
	var_06 = var_04.origin * (1,1,0) + (0,0,1) * var_03 + var_05 * -100;
	var_07 = var_01.origin;
	var_08 = spawnhelicopter(self,var_07,var_02,level.heliguardsettings[param_00].vehicleinfo,level.heliguardsettings[param_00].modelbase);
	if(!isdefined(var_08))
	{
		return;
	}

	var_08 maps\mp\killstreaks\_helicopter::addtolittlebirdlist();
	var_08 thread maps\mp\killstreaks\_helicopter::removefromlittlebirdlistondeath();
	var_08.health = level.heliguardsettings[param_00].health;
	var_08.maxhealth = level.heliguardsettings[param_00].maxhealth;
	var_08.damagetaken = 0;
	var_08.speed = 100;
	var_08.followspeed = 40;
	var_08.owner = self;
	var_08.team = self.team;
	var_08 setmaxpitchroll(45,45);
	var_08 vehicle_setspeed(var_08.speed,100,40);
	var_08 setyawspeed(120,60);
	var_08 setneargoalnotifydist(512);
	var_08.killcount = 0;
	var_08.helitype = "littlebird";
	var_08.heliguardtype = "littlebird_support";
	var_08.targettingradius = 2000;
	var_08.targetpos = var_06;
	var_08.currentnode = var_04;
	var_09 = spawnturret("misc_turret",var_08.origin,level.heliguardsettings[param_00].weaponinfo);
	var_09 linkto(var_08,level.heliguardsettings[param_00].weapontagleft,(0,0,0),(0,0,0));
	var_09 setmodel(level.heliguardsettings[param_00].weaponmodelleft);
	var_09.angles = var_08.angles;
	var_09.owner = var_08.owner;
	var_09.team = self.team;
	var_09 maketurretinoperable();
	var_09.vehicle = var_08;
	var_08.mgturretleft = var_09;
	var_08.mgturretleft setdefaultdroppitch(0);
	var_0A = var_08.origin + anglestoforward(var_08.angles) * -100 + anglestoright(var_08.angles) * -100 + (0,0,50);
	var_09.killcament = spawn("script_model",var_0A);
	var_09.killcament setscriptmoverkillcam("explosive");
	var_09.killcament linkto(var_08,"tag_origin");
	var_09 = spawnturret("misc_turret",var_08.origin,level.heliguardsettings[param_00].weaponinfo);
	var_09 linkto(var_08,level.heliguardsettings[param_00].weapontagright,(0,0,0),(0,0,0));
	var_09 setmodel(level.heliguardsettings[param_00].weaponmodelright);
	var_09.angles = var_08.angles;
	var_09.owner = var_08.owner;
	var_09.team = self.team;
	var_09 maketurretinoperable();
	var_09.vehicle = var_08;
	var_08.mgturretright = var_09;
	var_08.mgturretright setdefaultdroppitch(0);
	var_0A = var_08.origin + anglestoforward(var_08.angles) * -100 + anglestoright(var_08.angles) * 100 + (0,0,50);
	var_09.killcament = spawn("script_model",var_0A);
	var_09.killcament setscriptmoverkillcam("explosive");
	var_09.killcament linkto(var_08,"tag_origin");
	if(level.teambased)
	{
		var_08.mgturretleft setturretteam(self.team);
		var_08.mgturretright setturretteam(self.team);
	}

	var_08.mgturretleft setmode(level.heliguardsettings[param_00].sentrymode);
	var_08.mgturretright setmode(level.heliguardsettings[param_00].sentrymode);
	var_08.mgturretleft setsentryowner(self);
	var_08.mgturretright setsentryowner(self);
	var_08.mgturretleft thread lbsupport_attacktargets();
	var_08.mgturretright thread lbsupport_attacktargets();
	var_08.attract_strength = 10000;
	var_08.attract_range = 150;
	var_08.attractor = missile_createattractorent(var_08,var_08.attract_strength,var_08.attract_range);
	var_08.hasdodged = 0;
	var_08.empgrenaded = 0;
	var_08 thread lbsupport_handledamage();
	var_08 thread lbsupport_watchdeath();
	var_08 thread lbsupport_watchtimeout();
	var_08 thread lbsupport_watchownerloss();
	var_08 thread lbsupport_watchownerdamage();
	var_08 thread lbsupport_watchroundend();
	var_08 thread lbsupport_lightfx();
	level.littlebirdguard = var_08;
	var_08.owner maps\mp\_matchdata::logkillstreakevent(level.heliguardsettings[var_08.heliguardtype].streakname,var_08.targetpos);
	return var_08;
}

//Function Number: 4
lbsupport_lightfx()
{
	playfxontag(level.chopper_fx["light"]["left"],self,"tag_light_nose");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["belly"],self,"tag_light_belly");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["tail"],self,"tag_light_tail1");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["tail"],self,"tag_light_tail2");
}

//Function Number: 5
startlbsupport(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 setlookatent(self);
	param_00 setvehgoalpos(param_00.targetpos);
	param_00 waittill("near_goal");
	param_00 vehicle_setspeed(param_00.speed,60,30);
	param_00 waittill("goal");
	param_00 setvehgoalpos(param_00.currentnode.origin,1);
	param_00 waittill("goal");
	param_00 thread lbsupport_followplayer();
	param_00 thread maps\mp\killstreaks\_helicopter::handleincomingsam(::lbsupport_watchsamproximity);
	param_00 thread maps\mp\killstreaks\_helicopter::handleincomingstinger(::lbsupport_watchstingerproximity);
}

//Function Number: 6
lbsupport_followplayer()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	if(!isdefined(self.owner))
	{
		thread lbsupport_leave();
		return;
	}

	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	self vehicle_setspeed(self.followspeed,20,20);
	for(;;)
	{
		if(isdefined(self.owner) && isalive(self.owner))
		{
			var_00 = lbsupport_getclosestlinkednode(self.owner.origin);
			if(isdefined(var_00) && var_00 != self.currentnode)
			{
				self.currentnode = var_00;
				lbsupport_movetoplayer();
				continue;
			}
		}

		wait 1;
	}
}

//Function Number: 7
lbsupport_movetoplayer()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("death");
	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	self notify("lbSupport_moveToPlayer");
	self endon("lbSupport_moveToPlayer");
	self.intransit = 1;
	self setvehgoalpos(self.currentnode.origin,1);
	self waittill("goal");
	self.intransit = 0;
	self notify("hit_goal");
}

//Function Number: 8
lbsupport_watchdeath()
{
	level endon("game_ended");
	self endon("gone");
	self waittill("death");
	thread helidestroyed();
}

//Function Number: 9
lbsupport_watchtimeout()
{
	level endon("game_ended");
	self endon("death");
	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	var_00 = level.heliguardsettings[self.heliguardtype].timeout;
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_00);
	thread lbsupport_leave();
}

//Function Number: 10
lbsupport_watchownerloss()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	thread lbsupport_leave();
}

//Function Number: 11
lbsupport_watchownerdamage()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	for(;;)
	{
		self.owner waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isplayer(var_01))
		{
			if(var_01 != self.owner && distance2d(var_01.origin,self.origin) <= self.targettingradius && !var_01 maps\mp\_utility::_hasperk("specialty_blindeye") && !level.hardcoremode && level.teambased && var_01.team == self.team)
			{
				self setlookatent(var_01);
				self.mgturretleft settargetentity(var_01);
				self.mgturretright settargetentity(var_01);
			}
		}
	}
}

//Function Number: 12
lbsupport_watchroundend()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	level waittill("round_end_finished");
	thread lbsupport_leave();
}

//Function Number: 13
lbsupport_leave()
{
	self endon("death");
	self notify("leaving");
	level.littlebirdguard = undefined;
	self clearlookatent();
	var_00 = maps\mp\killstreaks\_airdrop::getflyheightoffset(self.origin);
	var_01 = self.origin + (0,0,var_00);
	self vehicle_setspeed(self.speed,60);
	self setmaxpitchroll(45,180);
	self setvehgoalpos(var_01);
	self waittill("goal");
	var_01 = var_01 + anglestoforward(self.angles) * 15000;
	var_02 = spawn("script_origin",var_01);
	if(isdefined(var_02))
	{
		self setlookatent(var_02);
		var_02 thread wait_and_delete(3);
	}

	self setvehgoalpos(var_01);
	self waittill("goal");
	self notify("gone");
	removelittlebird();
}

//Function Number: 14
wait_and_delete(param_00)
{
	self endon("death");
	level endon("game_ended");
	wait param_00;
	self delete();
}

//Function Number: 15
lbsupport_handledamage()
{
	self endon("death");
	level endon("game_ended");
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner,var_01))
		{
			continue;
		}

		if(!isdefined(self))
		{
			return;
		}

		if(isdefined(var_08) && var_08 & level.idflags_penetration)
		{
			self.wasdamagedfrombulletpenetration = 1;
		}

		self.wasdamaged = 1;
		var_0A = var_00;
		if(isplayer(var_01))
		{
			if(var_01 != self.owner && distance2d(var_01.origin,self.origin) <= self.targettingradius && !var_01 maps\mp\_utility::_hasperk("specialty_blindeye") && !level.hardcoremode && level.teambased && var_01.team == self.team)
			{
				self setlookatent(var_01);
				self.mgturretleft settargetentity(var_01);
				self.mgturretright settargetentity(var_01);
			}

			var_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("helicopter");
			if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET")
			{
				if(var_01 maps\mp\_utility::_hasperk("specialty_armorpiercing"))
				{
					var_0A = var_0A + var_00 * level.armorpiercingmod;
				}
			}
		}

		if(isdefined(var_01.owner) && isplayer(var_01.owner))
		{
			var_01.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback("helicopter");
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "javelin_mp":
				case "stinger_mp":
				case "remote_mortar_missile_mp":
				case "remotemissile_projectile_mp":
				case "ac130_40mm_mp":
				case "ac130_105mm_mp":
					self.var_30C8 = 1;
					var_0A = self.maxhealth + 1;
					break;
	
				case "sam_projectile_mp":
					self.var_30C8 = 1;
					var_0A = self.maxhealth * 0.25;
					break;
	
				case "emp_grenade_mp":
					var_0A = 0;
					thread lbsupport_empgrenaded();
					break;
	
				case "osprey_player_minigun_mp":
					self.var_30C8 = 0;
					var_0A = var_0A * 2;
					break;
			}
		}

		self.damagetaken = self.damagetaken + var_0A;
		if(self.damagetaken >= self.maxhealth)
		{
			if(isplayer(var_01) && !isdefined(self.owner) || var_01 != self.owner)
			{
				var_01 notify("destroyed_helicopter");
				var_01 notify("destroyed_killstreak",var_09);
				thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_little_bird",var_01);
				var_01 thread maps\mp\gametypes\_rank::giverankxp("kill",300,var_09,var_04);
				var_01 thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_DESTROYED_LITTLE_BIRD");
				thread maps\mp\gametypes\_missions::vehiclekilled(self.owner,self,undefined,var_01,var_00,var_04,var_09);
			}

			if(isdefined(self.owner))
			{
				self.owner thread maps\mp\_utility::leaderdialogonplayer("lbguard_destroyed");
			}

			self notify("death");
			return;
		}
	}
}

//Function Number: 16
lbsupport_empgrenaded()
{
	self notify("lbSupport_EMPGrenaded");
	self endon("lbSupport_EMPGrenaded");
	self endon("death");
	self.owner endon("disconnect");
	level endon("game_ended");
	self.empgrenaded = 1;
	self.mgturretright notify("stop_shooting");
	self.mgturretleft notify("stop_shooting");
	if(isdefined(level._effect["ims_sensor_explode"]))
	{
		playfxontag(common_scripts\utility::getfx("ims_sensor_explode"),self.mgturretright,"tag_aim");
		playfxontag(common_scripts\utility::getfx("ims_sensor_explode"),self.mgturretleft,"tag_aim");
	}

	wait 3.5;
	self.empgrenaded = 0;
	self.mgturretright notify("turretstatechange");
	self.mgturretleft notify("turretstatechange");
}

//Function Number: 17
helidestroyed()
{
	level.littlebirdguard = undefined;
	if(!isdefined(self))
	{
		return;
	}

	self vehicle_setspeed(25,5);
	thread lbspin(randomintrange(180,220));
	wait randomfloatrange(0.5,1.5);
	lbexplode();
}

//Function Number: 18
lbexplode()
{
	var_00 = self.origin + (0,0,1) - self.origin;
	var_01 = self gettagangles("tag_deathfx");
	playfx(level.chopper_fx["explode"]["air_death"]["littlebird"],self gettagorigin("tag_deathfx"),anglestoforward(var_01),anglestoup(var_01));
	self playsound("cobra_helicopter_crash");
	self notify("explode");
	removelittlebird();
}

//Function Number: 19
lbspin(param_00)
{
	self endon("explode");
	playfxontag(level.chopper_fx["explode"]["medium"],self,"tail_rotor_jnt");
	thread trail_fx(level.chopper_fx["smoke"]["trail"],"tail_rotor_jnt","stop tail smoke");
	self setyawspeed(param_00,param_00,param_00);
	while(isdefined(self))
	{
		self settargetyaw(self.angles[1] + param_00 * 0.9);
		wait 1;
	}
}

//Function Number: 20
trail_fx(param_00,param_01,param_02)
{
	self notify(param_02);
	self endon(param_02);
	self endon("death");
	for(;;)
	{
		playfxontag(param_00,self,param_01);
		wait 0.05;
	}
}

//Function Number: 21
removelittlebird()
{
	level.var_3589 = 0;
	if(isdefined(self.mgturretleft))
	{
		if(isdefined(self.mgturretleft.killcament))
		{
			self.mgturretleft.killcament delete();
		}

		self.mgturretleft delete();
	}

	if(isdefined(self.mgturretright))
	{
		if(isdefined(self.mgturretright.killcament))
		{
			self.mgturretright.killcament delete();
		}

		self.mgturretright delete();
	}

	if(isdefined(self.marker))
	{
		self.marker delete();
	}

	maps\mp\_utility::decrementfauxvehiclecount();
	self delete();
}

//Function Number: 22
lbsupport_watchsamproximity(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	param_02 endon("death");
	for(var_04 = 0;var_04 < param_03.size;var_04++)
	{
		if(isdefined(param_03[var_04]) && !param_02.hasdodged)
		{
			param_02.hasdodged = 1;
			var_05 = spawn("script_origin",param_02.origin);
			var_05.angles = param_02.angles;
			var_05 movegravity(anglestoright(param_03[var_04].angles) * -1000,0.05);
			var_05 thread maps\mp\killstreaks\_helicopter::deleteaftertime(5);
			for(var_06 = 0;var_06 < param_03.size;var_06++)
			{
				if(isdefined(param_03[var_06]))
				{
					param_03[var_06] missile_settargetent(var_05);
				}
			}

			var_07 = param_02.origin + anglestoright(param_03[var_04].angles) * 200;
			param_02 vehicle_setspeed(param_02.speed,100,40);
			param_02 setvehgoalpos(var_07,1);
			wait 2;
			param_02 vehicle_setspeed(param_02.followspeed,20,20);
			break;
		}
	}
}

//Function Number: 23
lbsupport_watchstingerproximity(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_02 endon("death");
	if(isdefined(self) && !param_02.hasdodged)
	{
		param_02.hasdodged = 1;
		var_03 = spawn("script_origin",param_02.origin);
		var_03.angles = param_02.angles;
		var_03 movegravity(anglestoright(self.angles) * -1000,0.05);
		var_03 thread maps\mp\killstreaks\_helicopter::deleteaftertime(5);
		self missile_settargetent(var_03);
		var_04 = param_02.origin + anglestoright(self.angles) * 200;
		param_02 vehicle_setspeed(param_02.speed,100,40);
		param_02 setvehgoalpos(var_04,1);
		wait 2;
		param_02 vehicle_setspeed(param_02.followspeed,20,20);
	}
}

//Function Number: 24
lbsupport_getcloseststartnode(param_00)
{
	var_01 = undefined;
	var_02 = 999999;
	foreach(var_04 in level.air_start_nodes)
	{
		var_05 = distance(var_04.origin,param_00);
		if(var_05 < var_02)
		{
			var_01 = var_04;
			var_02 = var_05;
		}
	}

	return var_01;
}

//Function Number: 25
lbsupport_getclosestnode(param_00)
{
	var_01 = undefined;
	var_02 = 999999;
	foreach(var_04 in level.air_node_mesh)
	{
		var_05 = distance(var_04.origin,param_00);
		if(var_05 < var_02)
		{
			var_01 = var_04;
			var_02 = var_05;
		}
	}

	return var_01;
}

//Function Number: 26
lbsupport_getclosestlinkednode(param_00)
{
	var_01 = undefined;
	var_02 = distance2d(self.currentnode.origin,param_00);
	var_03 = var_02;
	foreach(var_05 in self.currentnode.neighbors)
	{
		var_06 = distance2d(var_05.origin,param_00);
		if(var_06 < var_02 && var_06 < var_03)
		{
			var_01 = var_05;
			var_03 = var_06;
		}
	}

	return var_01;
}

//Function Number: 27
lbsupport_arraycontains(param_00,param_01)
{
	if(param_00.size <= 0)
	{
		return 0;
	}

	foreach(var_03 in param_00)
	{
		if(var_03 == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 28
lbsupport_getlinkedstructs()
{
	var_00 = [];
	if(isdefined(self.script_linkto))
	{
		var_01 = common_scripts\utility::get_links();
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = common_scripts\utility::getstruct(var_01[var_02],"script_linkname");
			if(isdefined(var_03))
			{
				var_00[var_00.size] = var_03;
			}
		}
	}

	return var_00;
}

//Function Number: 29
lbsupport_setairstartnodes()
{
	level.air_start_nodes = common_scripts\utility::getstructarray("chopper_boss_path_start","targetname");
	foreach(var_01 in level.air_start_nodes)
	{
		var_01.neighbors = var_01 lbsupport_getlinkedstructs();
	}
}

//Function Number: 30
lbsupport_setairnodemesh()
{
	level.air_node_mesh = common_scripts\utility::getstructarray("so_chopper_boss_path_struct","script_noteworthy");
	lbsupport_tu0_raise_positions();
	foreach(var_01 in level.air_node_mesh)
	{
		var_01.neighbors = var_01 lbsupport_getlinkedstructs();
		foreach(var_03 in level.air_node_mesh)
		{
			if(var_01 == var_03)
			{
				continue;
			}

			if(!lbsupport_arraycontains(var_01.neighbors,var_03) && lbsupport_arraycontains(var_03 lbsupport_getlinkedstructs(),var_01))
			{
				var_01.neighbors[var_01.neighbors.size] = var_03;
			}
		}
	}
}

//Function Number: 31
lbsupport_tu0_raise_positions()
{
	switch(getdvar("mapname"))
	{
		case "mp_lambeth":
			var_00 = [];
			var_01 = [];
			var_02 = 0;
			while(var_02 < level.air_node_mesh.size)
			{
				foreach(var_04 in var_7B)
				{
					if(int(level.air_node_mesh[var_02].origin[0]) == int(var_04[0]) && int(level.air_node_mesh[var_02].origin[1]) == int(var_04[1]) && int(level.air_node_mesh[var_02].origin[2]) == int(var_04[2]))
					{
						level.air_node_mesh[var_02].origin = level.air_node_mesh[var_02].origin + (0,0,192);
						break;
					}
				}
	
				foreach(var_04 in var_01)
				{
					if(int(level.air_node_mesh[var_02].origin[0]) == int(var_04[0]) && int(level.air_node_mesh[var_02].origin[1]) == int(var_04[1]) && int(level.air_node_mesh[var_02].origin[2]) == int(var_04[2]))
					{
						level.air_node_mesh[var_02].origin = level.air_node_mesh[var_02].origin + (0,0,300);
						break;
					}
				}
	
				var_02++ = var_7B[var_01.size];
			}
	
			break;
	(-1027.1,-1180.7,312)
	var_7B[var_7B.size]
	(2732.9,83.3,376)
	var_7B[var_7B.size]
	(2748.9,963.3,328)
	var_7B[var_7B.size]
	(956.9,2931.3,216)
	var_7B[var_7B.size]
	(-467.1,-316.7,184)
	var_7B[var_7B.size]
	(-1155.1,1187.3,344)
	var_7B[var_7B.size]
	(-947.1,1859.3,376)
	var_7B[var_00.size]
	(-291.1,1587.3,184)
			break;

		case "mp_village":
			var_08 = [];
			var_09 = [];
			var_0A = [];
			var_0B = (-1155.1,-1260.7,1096);
			var_02 = 0;
			while(var_02 < level.air_node_mesh.size)
			{
				foreach(var_04 in var_7B)
				{
					if(int(level.air_node_mesh[var_02].origin[0]) == int(var_04[0]) && int(level.air_node_mesh[var_02].origin[1]) == int(var_04[1]) && int(level.air_node_mesh[var_02].origin[2]) == int(var_04[2]))
					{
						level.air_node_mesh[var_02].origin = level.air_node_mesh[var_02].origin + (0,0,200);
						break;
					}
				}
	
				foreach(var_04 in var_09)
				{
					if(int(level.air_node_mesh[var_02].origin[0]) == int(var_04[0]) && int(level.air_node_mesh[var_02].origin[1]) == int(var_04[1]) && int(level.air_node_mesh[var_02].origin[2]) == int(var_04[2]))
					{
						level.air_node_mesh[var_02].origin = level.air_node_mesh[var_02].origin + (0,0,250);
						break;
					}
				}
	
				foreach(var_04 in var_0A)
				{
					if(int(level.air_node_mesh[var_02].origin[0]) == int(var_04[0]) && int(level.air_node_mesh[var_02].origin[1]) == int(var_04[1]) && int(level.air_node_mesh[var_02].origin[2]) == int(var_04[2]))
					{
						level.air_node_mesh[var_02].origin = level.air_node_mesh[var_02].origin + (0,0,400);
						break;
					}
				}
	
				if(int(level.air_node_mesh[var_02].origin[0]) == int(var_0B[0]) && int(level.air_node_mesh[var_02].origin[1]) == int(var_0B[1]) && int(level.air_node_mesh[var_02].origin[2]) == int(var_0B[2]))
				{
					level.air_node_mesh[var_02].origin = (-1003,-1035,986);
					continue;
				}
	
				var_02++ = var_7B[var_0A.size];
			}
	
			break;
	(1100.9,1155.3,632)
	var_7B[var_09.size]
	(1600,352,752)
	var_7B[var_09.size]
	(352,800,736)
	var_7B[var_7B.size]
	(412.9,67.3,680)
	var_7B[var_7B.size]
	(1756.9,-444.7,744)
	var_7B[var_7B.size]
	(972.9,163.3,744)
	var_7B[var_7B.size]
	(60.9,1363.3,728)
	var_7B[var_08.size]
	(684.9,2227.3,680)
			break;

		case "mp_interchange":
			var_12 = [];
			var_02 = 0;
			while(var_02 < level.air_node_mesh.size)
			{
				foreach(var_04 in var_7B)
				{
					if(int(level.air_node_mesh[var_02].origin[0]) == int(var_04[0]) && int(level.air_node_mesh[var_02].origin[1]) == int(var_04[1]) && int(level.air_node_mesh[var_02].origin[2]) == int(var_04[2]))
					{
						level.air_node_mesh[var_02].origin = level.air_node_mesh[var_02].origin + (0,0,100);
						break;
					}
				}
	
				var_02++ = var_7B[var_12.size];
			}
	
			break;
	(-755.1,-1788.7,360)
			break;

		default:
			break;
	}
}

//Function Number: 32
lbsupport_tu0_new_incoming_position(param_00)
{
	switch(getdvar("mapname"))
	{
		case "mp_interchange":
			var_01 = [];
			var_02 = [];
			var_01[var_02.size][0] = (1340.9,1299.3,360);
			var_01[var_02.size][1] = (2220.9,115.3,408);
			var_02[var_7B.size][0] = (-755.1,-588.7,728);
			var_02[var_7B.size][1] = (-2563.1,-1580.7,1192);
			var_02[var_7B.size][0] = (-35.1,-2492.7,488);
			var_02[var_7B.size][1] = (396.9,-1884.7,696);
			var_03 = randomintrange(0,100) > 50;
			var_04 = 0;
			while(var_04 < var_7B.size)
			{
				if(int(var_01.origin[0]) == int(var_7B[var_04][0]) && int(var_01.origin[1]) == int(var_7B[var_04][1]) && int(var_01.origin[2]) == int(var_7B[var_04][2]))
				{
					var_05 = 0;
					while(var_05 < level.air_node_mesh.size)
					{
						if(int(level.air_node_mesh[var_05].origin[0]) == int(var_02[var_04][var_03][0]) && int(level.air_node_mesh[var_05].origin[1]) == int(var_02[var_04][var_03][1]) && int(level.air_node_mesh[var_05].origin[2]) == int(var_02[var_04][var_03][2]))
						{
							return level.air_node_mesh[var_05];
						}
	
						var_05++ = var_7B[var_7B.size];
					}
				}
	
				var_04++ = (-755.1,-1788.7,460);
			}
	
			break;
	var_7B[var_7B.size]
	(-1363.1,-1164.7,472)
	var_7B[var_02.size]
	(1884.9,787.3,312)
			break;

		default:
			break;
	}

	return var_01;
}

//Function Number: 33
lbsupport_attacktargets()
{
	self.vehicle endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("turretstatechange");
		if(self isfiringturret() && !self.vehicle.empgrenaded)
		{
			thread lbsupport_burstfirestart();
			continue;
		}

		thread lbsupport_burstfirestop();
	}
}

//Function Number: 34
lbsupport_burstfirestart()
{
	self.vehicle endon("death");
	self.vehicle endon("leaving");
	self endon("stop_shooting");
	level endon("game_ended");
	var_00 = 0.1;
	var_01 = 40;
	var_02 = 80;
	var_03 = 1;
	var_04 = 2;
	for(;;)
	{
		var_05 = randomintrange(var_01,var_02 + 1);
		for(var_06 = 0;var_06 < var_05;var_06++)
		{
			var_07 = self getturrettarget(0);
			if(isdefined(var_07) && !isdefined(var_07.spawntime) || gettime() - var_07.spawntime / 1000 > 5 && isdefined(var_07.team) && var_07.team != "spectator" && maps\mp\_utility::isreallyalive(var_07))
			{
				self.vehicle setlookatent(var_07);
				self shootturret();
			}

			wait var_00;
		}

		wait randomfloatrange(var_03,var_04);
	}
}

//Function Number: 35
lbsupport_burstfirestop()
{
	self notify("stop_shooting");
	if(isdefined(self.vehicle.owner))
	{
		self.vehicle setlookatent(self.vehicle.owner);
	}
}