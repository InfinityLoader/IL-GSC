/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_helicopter_guard.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 537 ms
 * Timestamp: 10/27/2023 1:20:57 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killstreakfuncs["littlebird_support"] = ::func_8440;
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
	level.heliguardsettings["littlebird_support"].weapontagleft = "tag_flash";
	level.heliguardsettings["littlebird_support"].weapontagright = "tag_flash_2";
	level.heliguardsettings["littlebird_support"].sentrymode = "auto_nonai";
	level.heliguardsettings["littlebird_support"].modelbase = level.littlebird_model;
	level.heliguardsettings["littlebird_support"].teamsplash = "used_littlebird_support";
	func_4D1C();
	func_4D1B();
}

//Function Number: 2
func_8440(param_00,param_01)
{
	var_02 = "littlebird_support";
	var_03 = 1;
	if(isdefined(level.littlebirdguard) || maps\mp\killstreaks\_helicopter::func_3041(var_02))
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(!level.air_node_mesh.size)
	{
		self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_IN_LEVEL");
		return 0;
	}
	else if(maps\mp\_utility::func_21E7() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_03 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	maps\mp\_utility::func_4487();
	var_04 = createlbguard(var_02);
	if(!isdefined(var_04))
	{
		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	thread startlbsupport(var_04);
	level thread maps\mp\_utility::func_7FA0(level.heliguardsettings[var_02].teamsplash,self,self.team);
	return 1;
}

//Function Number: 3
createlbguard(param_00)
{
	var_01 = func_4D15(self.origin);
	if(isdefined(var_01.angles))
	{
		var_02 = var_01.angles;
	}
	else
	{
		var_02 = (0,0,0);
	}

	var_03 = maps\mp\killstreaks\_airdrop::func_3AB0(self.origin);
	var_04 = lbsupport_getclosestnode(self.origin);
	var_05 = anglestoforward(self.angles);
	var_06 = var_04.origin * (1,1,0) + (0,0,1) * var_03 + var_05 * -100;
	var_07 = var_01.origin;
	var_08 = spawnhelicopter(self,var_07,var_02,level.heliguardsettings[param_00].vehicleinfo,level.heliguardsettings[param_00].modelbase);
	if(!isdefined(var_08))
	{
	}

	var_08 maps\mp\killstreaks\_helicopter::addtolittlebirdlist();
	var_08 thread maps\mp\killstreaks\_helicopter::func_6590();
	var_08.health = level.heliguardsettings[param_00].health;
	var_08.maxhealth = level.heliguardsettings[param_00].maxhealth;
	var_08.damagetaken = 0;
	var_08.speed = 100;
	var_08.followspeed = 40;
	var_08.owner = self;
	var_08 setotherent(self);
	var_08.team = self.team;
	var_08 setmaxpitchroll(45,45);
	var_08 vehicle_setspeed(var_08.speed,100,40);
	var_08 setyawspeed(120,60);
	var_08 setneargoalnotifydist(512);
	var_08.killcount = 0;
	var_08.helitype = "littlebird";
	var_08.heliguardtype = "littlebird_support";
	var_08.targettingradius = 2000;
	var_08 common_scripts\utility::func_5009(var_08.team);
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
	var_08 thread func_4D17();
	var_08 thread func_4D1D();
	var_08 thread func_4D23();
	var_08 thread func_4D1F();
	var_08 thread lbsupport_watchownerdamage();
	var_08 thread func_4D20();
	var_08 thread func_4D19();
	level.littlebirdguard = var_08;
	var_08.owner maps\mp\_matchdata::func_4F1D(level.heliguardsettings[var_08.heliguardtype].streakname,var_08.targetpos);
	return var_08;
}

//Function Number: 4
func_4D19()
{
	playfxontag(level.chopper_fx["light"]["left"],self,"tag_light_nose");
	wait(0.05);
	playfxontag(level.chopper_fx["light"]["belly"],self,"tag_light_belly");
	wait(0.05);
	playfxontag(level.chopper_fx["light"]["tail"],self,"tag_light_tail1");
	wait(0.05);
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
	param_00 thread func_4D12();
	param_00 thread maps\mp\killstreaks\_flares::func_33D8(::func_4D21);
	param_00 thread maps\mp\killstreaks\_flares::func_33D9(::func_4D22);
}

//Function Number: 6
func_4D12()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	if(!isdefined(self.owner))
	{
		thread func_4D18();
	}

	self.owner endon("disconnect");
	self endon("owner_gone");
	self vehicle_setspeed(self.followspeed,20,20);
	for(;;)
	{
		if(isdefined(self.owner) && isalive(self.owner))
		{
			var_00 = func_4D13(self.owner.origin);
			if(isdefined(var_00) && var_00 != self.currentnode)
			{
				self.currentnode = var_00;
				func_4D1A();
				continue;
			}
		}

		wait(1);
	}
}

//Function Number: 7
func_4D1A()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	self notify("lbSupport_moveToPlayer");
	self endon("lbSupport_moveToPlayer");
	self.intransit = 1;
	self setvehgoalpos(self.currentnode.origin + (0,0,100),1);
	self waittill("goal");
	self.intransit = 0;
	self notify("hit_goal");
}

//Function Number: 8
func_4D1D()
{
	level endon("game_ended");
	self endon("gone");
	self waittill("death");
	thread maps\mp\killstreaks\_helicopter::func_4D0A();
}

//Function Number: 9
func_4D23()
{
	level endon("game_ended");
	self endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	var_00 = level.heliguardsettings[self.heliguardtype].timeout;
	maps\mp\gametypes\_hostmigration::func_8B0D(var_00);
	thread func_4D18();
}

//Function Number: 10
func_4D1F()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner waittill("killstreak_disowned");
	self notify("owner_gone");
	thread func_4D18();
}

//Function Number: 11
lbsupport_watchownerdamage()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("disconnect");
	self endon("owner_gone");
	for(;;)
	{
		self.owner waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isplayer(var_01))
		{
			if(var_01 != self.owner && distance2d(var_01.origin,self.origin) <= self.targettingradius && !var_01 maps\mp\_utility::_hasperk("specialty_blindeye") && !level.hardcoremode && level.teambased && var_01.team == self.team)
			{
				self setlookatent(var_01);
				if(isdefined(self.mgturretleft))
				{
					self.mgturretleft settargetentity(var_01);
				}

				if(isdefined(self.mgturretright))
				{
					self.mgturretright settargetentity(var_01);
				}
			}
		}
	}
}

//Function Number: 12
func_4D20()
{
	self endon("death");
	self endon("leaving");
	self.owner endon("disconnect");
	self endon("owner_gone");
	level common_scripts\utility::func_8B2A("round_end_finished","game_ended");
	thread func_4D18();
}

//Function Number: 13
func_4D18()
{
	self endon("death");
	self notify("leaving");
	level.littlebirdguard = undefined;
	self clearlookatent();
	var_00 = maps\mp\killstreaks\_airdrop::func_3AB0(self.origin);
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
		var_02 thread func_8A65(3);
	}

	self setvehgoalpos(var_01);
	self waittill("goal");
	self notify("gone");
	maps\mp\killstreaks\_helicopter::func_659E();
}

//Function Number: 14
func_8A65(param_00)
{
	self endon("death");
	level endon("game_ended");
	wait(param_00);
	self delete();
}

//Function Number: 15
func_4D17()
{
	self endon("death");
	level endon("game_ended");
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!maps\mp\gametypes\_weapons::func_357F(self.owner,var_01))
		{
			continue;
		}

		if(!isdefined(self))
		{
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
				if(isdefined(self.mgturretleft))
				{
					self.mgturretleft settargetentity(var_01);
				}

				if(isdefined(self.mgturretright))
				{
					self.mgturretright settargetentity(var_01);
				}
			}

			var_01 maps\mp\gametypes\_damagefeedback::func_86E0("helicopter");
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
			var_01.owner maps\mp\gametypes\_damagefeedback::func_86E0("helicopter");
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "remotemissile_projectile_mp":
				case "ac130_40mm_mp":
				case "ac130_105mm_mp":
				case "javelin_mp":
				case "remote_mortar_missile_mp":
				case "stinger_mp":
					self.largeprojectiledamage = 1;
					var_0A = self.maxhealth + 1;
					break;
	
				case "sam_projectile_mp":
					self.largeprojectiledamage = 1;
					var_0A = self.maxhealth * 0.25;
					break;
	
				case "emp_grenade_mp":
					var_0A = 0;
					thread func_4D11();
					break;
	
				case "osprey_player_minigun_mp":
					self.largeprojectiledamage = 0;
					var_0A = var_0A * 2;
					break;
			}

			maps\mp\killstreaks\_killstreaks::func_4B39(var_01,var_09,self);
		}

		self.damagetaken = self.damagetaken + var_0A;
		if(self.damagetaken >= self.maxhealth)
		{
			if(isplayer(var_01) && !isdefined(self.owner) || var_01 != self.owner)
			{
				var_01 notify("destroyed_helicopter");
				var_01 notify("destroyed_killstreak",var_09);
				thread maps\mp\_utility::func_7FA0("callout_destroyed_little_bird",var_01);
				var_01 thread maps\mp\gametypes\_rank::giverankxp("kill",300,var_09,var_04);
				var_01 thread maps\mp\gametypes\_rank::func_8E6E("destroyed_little_bird");
				thread maps\mp\gametypes\_missions::vehiclekilled(self.owner,self,undefined,var_01,var_00,var_04,var_09);
			}

			if(isdefined(self.owner))
			{
				self.owner thread maps\mp\_utility::func_4D35("lbguard_destroyed");
			}

			self notify("death");
		}
	}
}

//Function Number: 16
func_4D11()
{
	self notify("lbSupport_EMPGrenaded");
	self endon("lbSupport_EMPGrenaded");
	self endon("death");
	self.owner endon("disconnect");
	level endon("game_ended");
	self.empgrenaded = 1;
	if(isdefined(self.mgturretright))
	{
		self.mgturretright notify("stop_shooting");
	}

	if(isdefined(self.mgturretleft))
	{
		self.mgturretleft notify("stop_shooting");
	}

	if(isdefined(level._effect["ims_sensor_explode"]))
	{
		if(isdefined(self.mgturretright))
		{
			playfxontag(common_scripts\utility::func_3AB9("ims_sensor_explode"),self.mgturretright,"tag_aim");
		}

		if(isdefined(self.mgturretleft))
		{
			playfxontag(common_scripts\utility::func_3AB9("ims_sensor_explode"),self.mgturretleft,"tag_aim");
		}
	}

	wait(3.5);
	self.empgrenaded = 0;
	if(isdefined(self.mgturretright))
	{
		self.mgturretright notify("turretstatechange");
	}

	if(isdefined(self.mgturretleft))
	{
		self.mgturretleft notify("turretstatechange");
	}
}

//Function Number: 17
func_4D21(param_00,param_01,param_02,param_03)
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
			var_05 thread maps\mp\killstreaks\_flares::func_33D0(5);
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
			wait(2);
			param_02 vehicle_setspeed(param_02.followspeed,20,20);
			break;
		}
	}
}

//Function Number: 18
func_4D22(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_02 endon("death");
	if(isdefined(self) && !param_02.hasdodged)
	{
		param_02.hasdodged = 1;
		var_03 = spawn("script_origin",param_02.origin);
		var_03.angles = param_02.angles;
		var_03 movegravity(anglestoright(self.angles) * -1000,0.05);
		var_03 thread maps\mp\killstreaks\_flares::func_33D0(5);
		self missile_settargetent(var_03);
		var_04 = param_02.origin + anglestoright(self.angles) * 200;
		param_02 vehicle_setspeed(param_02.speed,100,40);
		param_02 setvehgoalpos(var_04,1);
		wait(2);
		param_02 vehicle_setspeed(param_02.followspeed,20,20);
	}
}

//Function Number: 19
func_4D15(param_00)
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

//Function Number: 20
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

//Function Number: 21
func_4D13(param_00)
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

//Function Number: 22
func_4D0D(param_00,param_01)
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

//Function Number: 23
func_4D16()
{
	var_00 = [];
	if(isdefined(self.script_linkto))
	{
		var_01 = common_scripts\utility::get_links();
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = common_scripts\utility::func_3C18(var_01[var_02],"script_linkname");
			if(isdefined(var_03))
			{
				var_00[var_00.size] = var_03;
			}
		}
	}

	return var_00;
}

//Function Number: 24
func_4D1C()
{
	level.air_start_nodes = common_scripts\utility::func_3C1A("chopper_boss_path_start","targetname");
	foreach(var_01 in level.air_start_nodes)
	{
		var_01.neighbors = var_01 func_4D16();
	}
}

//Function Number: 25
func_4D1B()
{
	level.air_node_mesh = common_scripts\utility::func_3C1A("so_chopper_boss_path_struct","script_noteworthy");
	foreach(var_01 in level.air_node_mesh)
	{
		var_01.neighbors = var_01 func_4D16();
		foreach(var_03 in level.air_node_mesh)
		{
			if(var_01 == var_03)
			{
				continue;
			}

			if(!func_4D0D(var_01.neighbors,var_03) && func_4D0D(var_03 func_4D16(),var_01))
			{
				var_01.neighbors[var_01.neighbors.size] = var_03;
			}
		}
	}
}

//Function Number: 26
lbsupport_attacktargets()
{
	self.vehicle endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("turretstatechange");
		if(self isfiringturret() && !self.vehicle.empgrenaded)
		{
			thread func_4D0F();
			continue;
		}

		thread lbsupport_burstfirestop();
	}
}

//Function Number: 27
func_4D0F()
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
			if(isdefined(var_07) && !isdefined(var_07.var_78C4) || gettime() - var_07.var_78C4 / 1000 > 5 && isdefined(var_07.team) && var_07.team != "spectator" && maps\mp\_utility::func_4945(var_07))
			{
				self.vehicle setlookatent(var_07);
				self shootturret();
			}

			wait(var_00);
		}

		wait(randomfloatrange(var_03,var_04));
	}
}

//Function Number: 28
lbsupport_burstfirestop()
{
	self notify("stop_shooting");
	if(isdefined(self.vehicle.owner))
	{
		self.vehicle setlookatent(self.vehicle.owner);
	}
}