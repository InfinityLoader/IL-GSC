/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_tank.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 80
 * Decompile Time: 1404 ms
 * Timestamp: 10/27/2023 2:15:26 AM
*******************************************************************/

//Function Number: 1
init()
{
}

//Function Number: 2
func_3869(param_00,param_01,param_02)
{
	var_03 = self dospawn("tank",param_00);
	var_03.health = 3000;
	var_03.targeting_delay = 1;
	var_03.team = param_00.team;
	var_03.pers["team"] = var_03.team;
	var_03.owner = param_00;
	var_03 setcandamage(1);
	var_03.var_386A = 12;
	var_03 thread func_386B();
	var_03 func_38A8();
	var_03.damagecallback = ::callback_vehicledamage;
	return var_03;
}

//Function Number: 3
func_386B()
{
	self endon("death");
	var_00 = self.origin[2];
	for(;;)
	{
		if(var_00 - self.origin[2] > 2048)
		{
			self.health = 0;
			self notify("death");
			return;
		}

		wait 1;
	}
}

//Function Number: 4
func_386C(param_00)
{
	return func_386D();
}

//Function Number: 5
func_386D()
{
	if(isdefined(level.var_386E) && level.var_386E)
	{
		self iprintlnbold("Armor support unavailable.");
		return 0;
	}

	if(!isdefined(getvehiclenode("startnode","targetname")))
	{
		self iprintlnbold("Tank is currently not supported in this level, bug your friendly neighborhood LD.");
		return 0;
	}

	if(!vehicle_getspawnerarray().size)
	{
		return 0;
	}

	if(self.team == "allies")
	{
		var_00 = level.var_386F["allies"] func_3869(self,"vehicle_bradley");
	}
	else
	{
		var_00 = level.var_386F["axis"] func_3869(self,"vehicle_bmp");
	}

	var_00 func_3870();
	return 1;
}

//Function Number: 6
func_3870(param_00)
{
	var_01 = getvehiclenode("startnode","targetname");
	var_02 = getvehiclenode("waitnode","targetname");
	self.var_3871 = getvehiclenodearray("info_vehicle_node","classname");
	level.var_386E = 1;
	thread func_3883(var_01,var_02);
	thread func_3886();
	level.tank = self;
	if(level.teambased)
	{
		var_03 = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(var_03,"invisible",(0,0,0));
		objective_team(var_03,"allies");
		level.tank.objid["allies"] = var_03;
		var_04 = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(var_04,"invisible",(0,0,0));
		objective_team(var_04,"axis");
		level.tank.objid["axis"] = var_04;
		var_05 = self.team;
		level.tank.team = var_05;
		level.tank.pers["team"] = var_05;
	}

	var_06 = spawnturret("misc_turret",self.origin,"abrams_minigun_mp");
	var_06 linkto(self,"tag_engine_left",(0,0,-20),(0,0,0));
	var_06 setmodel("sentry_minigun");
	var_06.angles = self.angles;
	var_06.owner = self.owner;
	var_06 maketurretinoperable();
	self.mgturret = var_06;
	self.mgturret setdefaultdroppitch(0);
	var_07 = self.angles;
	self.angles = (0,0,0);
	var_08 = self gettagorigin("tag_flash");
	self.angles = var_07;
	var_09 = var_08 - self.origin;
	thread func_3875();
	thread func_3876();
	self.var_3873 = gettime();
	var_0A = spawn("script_origin",self gettagorigin("tag_flash"));
	var_0A linkto(self,"tag_origin",var_09,(0,0,0));
	var_0A hide();
	self.var_3874 = var_0A;
	thread func_3893();
	thread func_388F();
	thread func_389F();
	thread func_3881();
	thread func_388C();
}

//Function Number: 7
func_3875()
{
	self endon("death");
	self.owner endon("disconnect");
	self.owner waittill("joined_team");
	self.health = 0;
	self notify("death");
}

//Function Number: 8
func_3876()
{
	self endon("death");
	self.owner waittill("disconnect");
	self.health = 0;
	self notify("death");
}

//Function Number: 9
func_3877(param_00)
{
	if(self.veh_pathdir != param_00)
	{
		if(param_00 == "forward")
		{
			func_3880();
			return;
		}

		func_387F();
	}
}

//Function Number: 10
func_3878()
{
	self endon("death");
	self notify("path_abandoned");
	while(isdefined(self.var_3879))
	{
		wait 0.05;
	}

	var_00 = 2;
	self vehicle_setspeed(var_00,10,10);
	self.var_387A = "engage";
}

//Function Number: 11
func_387B()
{
	self endon("death");
	self notify("path_abandoned");
	while(isdefined(self.var_3879))
	{
		wait 0.05;
	}

	var_00 = 2;
	self vehicle_setspeed(var_00,10,10);
	self.var_387A = "engage";
}

//Function Number: 12
func_387C()
{
	self endon("death");
	while(isdefined(self.var_3879))
	{
		wait 0.05;
	}

	self vehicle_setspeed(self.var_386A,10,10);
	self.var_387A = "standard";
}

//Function Number: 13
func_387D()
{
	self endon("death");
	while(isdefined(self.var_3879))
	{
		wait 0.05;
	}

	self vehicle_setspeed(15,15,15);
	self.var_387A = "evade";
	wait 1.5;
	self vehicle_setspeed(self.var_386A,10,10);
}

//Function Number: 14
func_387E()
{
	self endon("death");
	while(isdefined(self.var_3879))
	{
		wait 0.05;
	}

	self vehicle_setspeed(5,5,5);
	self.var_387A = "danger";
}

//Function Number: 15
func_387F()
{
	func_38D9("tank changing direction at " + gettime());
	self vehicle_setspeed(0,5,6);
	self.var_3879 = 1;
	while(self.veh_speed > 0)
	{
		wait 0.05;
	}

	wait 0.25;
	self.var_3879 = undefined;
	func_38D9("tank done changing direction");
	self.veh_transmission = "reverse";
	self.veh_pathdir = "reverse";
	self vehicle_setspeed(self.var_386A,5,6);
}

//Function Number: 16
func_3880()
{
	func_38D9("tank changing direction at " + gettime());
	self vehicle_setspeed(0,5,6);
	self.var_3879 = 1;
	while(self.veh_speed > 0)
	{
		wait 0.05;
	}

	wait 0.25;
	self.var_3879 = undefined;
	func_38D9("tank done changing direction");
	self.veh_transmission = "forward";
	self.veh_pathdir = "forward";
	self vehicle_setspeed(self.var_386A,5,6);
}

//Function Number: 17
func_3881()
{
	self endon("death");
	var_00 = [];
	var_01 = level.players;
	self.var_3882 = 0;
	for(;;)
	{
		foreach(var_03 in var_01)
		{
			if(!isdefined(var_03))
			{
				continue;
			}

			if(var_03.team == self.team)
			{
				wait 0.05;
				continue;
			}

			var_04 = distance2d(var_03.origin,self.origin);
			if(var_04 < 2048)
			{
				self.var_3882++;
			}

			wait 0.05;
		}

		if(isdefined(self.var_387A) && self.var_387A == "evade" || self.var_387A == "engage")
		{
			self.var_3882 = 0;
			continue;
		}

		if(self.var_3882 > 1)
		{
			thread func_387E();
		}
		else
		{
			thread func_387C();
		}

		self.var_3882 = 0;
		wait 0.05;
	}
}

//Function Number: 18
func_3883(param_00,param_01)
{
	self endon("tankDestroyed");
	self endon("death");
	if(!isdefined(level.var_3884))
	{
		self startpath(param_00);
		return;
	}

	self attachpath(param_00);
	self startpath(param_00);
	param_00 notify("trigger",self,1);
	wait 0.05;
	for(;;)
	{
		while(isdefined(self.var_3879))
		{
			wait 0.05;
		}

		var_02 = func_38AA();
		if(isdefined(var_02))
		{
			self.var_3885 = var_02;
		}
		else
		{
			self.var_3885 = undefined;
		}

		wait 0.65;
	}
}

//Function Number: 19
callback_vehicledamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if((param_01 == self || param_01 == self.mgturret || isdefined(param_01.pers) && param_01.pers["team"] == self.team) && param_01 != self.owner || param_04 == "MOD_MELEE")
	{
		return;
	}

	var_0C = func_388E(param_04,param_02,param_01);
	self vehicle_finishdamage(param_00,param_01,var_0C,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 20
func_3886()
{
	self endon("death");
	self.damagetaken = 0;
	var_00 = self vehicle_getspeed();
	var_01 = self.health;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	for(;;)
	{
		self waittill("damage",var_05,var_06,var_07,var_08,var_09);
		if(isdefined(var_06.classname) && var_06.classname == "script_vehicle")
		{
			if(isdefined(self.besttarget) && self.besttarget != var_06)
			{
				self.var_3887 = var_06;
				thread func_3897();
			}
		}
		else if(isplayer(var_06))
		{
			var_06 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("hitHelicopter");
			if(var_06 maps\mp\_utility::_hasperk("specialty_armorpiercing"))
			{
				var_0A = var_05 * level.armorpiercingmod;
				self.health = self.health - int(var_0A);
			}
		}

		if(self.health <= 0)
		{
			self notify("death");
			return;
		}
		else if(self.health < var_01 / 4 && var_04 == 0)
		{
			var_04 = 1;
		}
		else if(self.health < var_01 / 2 && var_03 == 0)
		{
			var_03 = 1;
		}
		else if(self.health < var_01 / 1.5 && var_02 == 0)
		{
			var_02 = 1;
		}

		if(var_05 > 1000)
		{
			func_3888(var_06);
		}
	}
}

//Function Number: 21
func_3888(param_00)
{
	self endon("death");
	var_01 = randomint(100);
	if(isdefined(self.besttarget) && self.besttarget != param_00 && var_01 > 30)
	{
		var_02 = [];
		func_3897(1,self.besttarget);
		thread func_3895(var_7B);
		return;
	}

	if(!isdefined(self.besttarget) && var_02 > 30)
	{
		var_02 = [];
		thread func_3895(var_7B);
		return;
	}

	if(var_02 < 30)
	{
		playfx(level.var_3889,self.origin);
		thread func_387D();
		return;
	}

	self fireweapon();
	self playsound("bmp_fire");
}

//Function Number: 22
func_388A(param_00)
{
	self endon("death");
	var_01 = func_388B(param_00);
	var_02 = distance(self.origin,param_00.origin);
	if(randomint(4) < 3)
	{
		return;
	}

	if(var_01 == "front" && var_02 < 768)
	{
		thread func_387D();
		return;
	}

	if(var_01 == "rear_side" || var_01 == "rear" && var_02 >= 768)
	{
		playfx(level.var_3889,self.origin);
		thread func_387D();
		return;
	}

	if(var_01 == "rear" && var_02 < 768)
	{
		func_387F();
		func_387D();
		wait 4;
		func_3880();
		return;
	}

	if(var_01 == "front_side" || var_01 == "front")
	{
		playfx(level.var_3889,self.origin);
		func_387F();
		func_387D();
		wait 8;
		func_3880();
		return;
	}
}

//Function Number: 23
func_388B(param_00)
{
	self endon("death");
	param_00 endon("death");
	param_00 endon("disconnect");
	var_01 = anglestoforward(self.angles);
	var_02 = param_00.origin - self.origin;
	var_01 = var_01 * (1,1,0);
	var_02 = var_02 * (1,1,0);
	var_02 = vectornormalize(var_02);
	var_01 = vectornormalize(var_01);
	var_03 = vectordot(var_02,var_01);
	if(var_03 > 0)
	{
		if(var_03 > 0.9)
		{
			return "front";
		}
		else
		{
			return "front_side";
		}
	}
	else if(var_03 < -0.9)
	{
		return "rear";
	}
	else
	{
		return "rear_side";
	}

	param_00 iprintlnbold(var_03);
}

//Function Number: 24
func_388C()
{
	self endon("death");
	for(;;)
	{
		var_00 = [];
		var_01 = level.players;
		foreach(var_03 in var_01)
		{
			if(!isdefined(var_03))
			{
				wait 0.05;
				continue;
			}

			if(!istarget(var_03))
			{
				wait 0.05;
				continue;
			}

			var_04 = var_03 getcurrentweapon();
			if(issubstr(var_04,"at4") || issubstr(var_04,"stinger") || issubstr(var_04,"javelin"))
			{
				thread func_388A(var_03);
				wait 8;
			}

			wait 0.15;
		}
	}
}

//Function Number: 25
func_388D()
{
	if(!isdefined(self.owner) || !isdefined(self.owner.pers["team"]) || self.owner.pers["team"] != self.team)
	{
		self notify("abandoned");
		return 0;
	}

	return 1;
}

//Function Number: 26
drawline(param_00,param_01,param_02,param_03)
{
	var_04 = int(param_02 * 20);
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		wait 0.05;
	}
}

//Function Number: 27
func_388E(param_00,param_01,param_02)
{
	if(param_00 == "MOD_RIFLE_BULLET")
	{
		return param_01;
	}

	if(param_00 == "MOD_PISTOL_BULLET")
	{
		return param_01;
	}

	if(param_00 == "MOD_IMPACT")
	{
		return param_01;
	}

	if(param_00 == "MOD_MELEE")
	{
		return 0;
	}

	if(param_00 == "MOD_EXPLOSIVE_BULLET")
	{
		return param_01;
	}

	if(param_00 == "MOD_GRENADE")
	{
		return param_01 * 5;
	}

	if(param_00 == "MOD_GRENADE_SPLASH")
	{
		return param_01 * 5;
	}

	return param_01 * 10;
}

//Function Number: 28
func_388F()
{
	self waittill("death");
	if(level.teambased)
	{
		var_00 = level.tank.team;
		objective_state(level.tank.objid[var_00],"invisible");
		objective_state(level.tank.objid[level.otherteam[var_00]],"invisible");
	}

	self notify("tankDestroyed");
	self vehicle_setspeed(0,10,10);
	level.var_386E = 0;
	playfx(level.spawnfire,self.origin);
	playfx(level.tankfire,self.origin);
	func_38A9();
	var_01 = spawn("script_model",self.origin);
	var_01 setmodel("vehicle_m1a1_abrams_d_static");
	var_01.angles = self.angles;
	self.mgturret delete();
	self delete();
	wait 4;
	var_01 delete();
}

//Function Number: 29
func_3891()
{
	self notify("onTargOrTimeOut");
	self endon("onTargOrTimeOut");
	self endon("turret_on_target");
	self waittill("turret_pitch_clamped");
	thread func_3897(0,self.besttarget);
}

//Function Number: 30
fireontarget()
{
	self endon("abandonedTarget");
	self endon("killedTarget");
	self endon("death");
	self endon("targetRemoved");
	self endon("lostLOS");
	for(;;)
	{
		func_3891();
		if(!isdefined(self.besttarget))
		{
			continue;
		}

		var_00 = self gettagorigin("tag_flash");
		var_01 = bullettrace(self.origin,var_00,0,self);
		if(var_01["position"] != var_00)
		{
			thread func_3897(0,self.besttarget);
		}

		var_01 = bullettrace(var_00,self.besttarget.origin,1,self);
		var_02 = distance(self.origin,var_01["position"]);
		var_03 = distance(self.besttarget.origin,self.origin);
		if(var_02 < 384 || var_02 + 256 < var_03)
		{
			wait 0.5;
			if(var_02 > 384)
			{
				func_3892();
				self fireweapon();
				self playsound("bmp_fire");
				self.var_3873 = gettime();
			}

			var_04 = func_388B(self.besttarget);
			thread func_3897(0,self.besttarget);
			return;
		}

		func_3892();
		self fireweapon();
		self playsound("bmp_fire");
		self.var_3873 = gettime();
	}
}

//Function Number: 31
func_3892()
{
	self endon("abandonedTarget");
	self endon("killedTarget");
	self endon("death");
	self endon("targetRemoved");
	self endon("lostLOS");
	var_00 = gettime() - self.var_3873;
	if(var_00 < 1499)
	{
		wait 1.5 - var_00 / 1000;
	}
}

//Function Number: 32
func_3893(param_00)
{
	self endon("death");
	self endon("leaving");
	var_01 = [];
	for(;;)
	{
		var_01 = [];
		var_02 = level.players;
		if(isdefined(self.var_3887))
		{
			var_01 = [];
			var_01[0] = self.var_3887;
			func_3895(var_01);
			self.var_3887 = undefined;
		}

		if(isdefined(level.var_3894) && level.var_3894.team != self.team && isalive(level.var_3894))
		{
			if(func_389C(level.tank))
			{
				var_01[var_01.size] = level.tank;
			}
		}

		if(isdefined(level.chopper) && level.chopper.team != self.team && isalive(level.chopper))
		{
			if(func_389C(level.chopper))
			{
				var_01[var_01.size] = level.chopper;
			}
		}

		foreach(var_04 in var_02)
		{
			if(!isdefined(var_04))
			{
				wait 0.05;
				continue;
			}

			if(isdefined(param_00) && var_04 == param_00)
			{
				continue;
			}

			if(istarget(var_04))
			{
				if(isdefined(var_04))
				{
					var_01[var_01.size] = var_04;
				}

				continue;
			}

			continue;
		}

		if(var_01.size > 0)
		{
			func_3895(var_01);
			continue;
		}

		wait 1;
	}
}

//Function Number: 33
func_3895(param_00)
{
	self endon("death");
	if(param_00.size == 1)
	{
		self.besttarget = param_00[0];
	}
	else
	{
		self.besttarget = getbesttarget(param_00);
	}

	thread func_3878();
	thread watchtargetdeath(param_00);
	self setturrettargetent(self.besttarget);
	fireontarget();
	thread func_3896();
}

//Function Number: 34
func_3896()
{
	self endon("death");
	func_387C();
	func_389A();
	self setturrettargetent(self.var_3874);
}

//Function Number: 35
getbesttarget(param_00)
{
	self endon("death");
	var_01 = self gettagorigin("tag_flash");
	var_02 = self.origin;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = 0;
	foreach(var_07 in param_00)
	{
		var_08 = abs(vectortoangles(var_07.origin - self.origin)[1]);
		var_09 = abs(self gettagangles("tag_flash")[1]);
		var_08 = abs(var_08 - var_09);
		if(isdefined(level.chopper) && var_07 == level.chopper)
		{
			return var_07;
		}

		if(isdefined(level.var_3894) && var_07 == level.var_3894)
		{
			return var_07;
		}

		var_0A = var_07 getweaponslistitems();
		foreach(var_0C in var_0A)
		{
			if(issubstr(var_0C,"at4") || issubstr(var_0C,"jav") || issubstr(var_0C,"c4"))
			{
				var_08 = var_08 - 40;
			}
		}

		if(!isdefined(var_03))
		{
			var_03 = var_08;
			var_04 = var_07;
			continue;
		}

		if(var_03 > var_08)
		{
			var_03 = var_08;
			var_04 = var_07;
		}
	}

	return var_04;
}

//Function Number: 36
watchtargetdeath(param_00)
{
	self endon("abandonedTarget");
	self endon("lostLOS");
	self endon("death");
	self endon("targetRemoved");
	var_01 = self.besttarget;
	var_01 endon("disconnect");
	var_01 waittill("death");
	self notify("killedTarget");
	func_389A();
	func_387C();
	thread func_3896();
}

//Function Number: 37
func_3897(param_00,param_01)
{
	self endon("death");
	self notify("abandonedTarget");
	func_387C();
	thread func_3896();
	func_389A();
	if(isdefined(param_01))
	{
		self.var_3898 = param_01;
		func_3899();
	}

	if(isdefined(param_00) && param_00)
	{
	}
}

//Function Number: 38
func_3899()
{
	self endon("death");
	wait 1.5;
	self.var_3898 = undefined;
}

//Function Number: 39
func_389A()
{
	self notify("targetRemoved");
	self.besttarget = undefined;
	self.var_389B = undefined;
}

//Function Number: 40
func_389C(param_00)
{
	if(distance2d(param_00.origin,self.origin) > 4096)
	{
		return 0;
	}

	if(distance(param_00.origin,self.origin) < 512)
	{
		return 0;
	}

	return func_389D(param_00,0);
}

//Function Number: 41
istarget(param_00)
{
	self endon("death");
	var_01 = distancesquared(param_00.origin,self.origin);
	if(!level.teambased && isdefined(self.owner) && param_00 == self.owner)
	{
		return 0;
	}

	if(!isalive(param_00) || param_00.sessionstate != "playing")
	{
		return 0;
	}

	if(var_01 > 16777216)
	{
		return 0;
	}

	if(var_01 < 262144)
	{
		return 0;
	}

	if(!isdefined(param_00.pers["team"]))
	{
		return 0;
	}

	if(param_00 == self.owner)
	{
		return 0;
	}

	if(level.teambased && param_00.pers["team"] == self.team)
	{
		return 0;
	}

	if(param_00.pers["team"] == "spectator")
	{
		return 0;
	}

	if(isdefined(param_00.spawntime) && gettime() - param_00.spawntime / 1000 <= 5)
	{
		return 0;
	}

	if(param_00 maps\mp\_utility::_hasperk("specialty_blindeye"))
	{
		return 0;
	}

	return self vehicle_canturrettargetpoint(param_00.origin,1,self);
}

//Function Number: 42
func_389D(param_00,param_01)
{
	var_02 = param_00 sightconetrace(self gettagorigin("tag_turret"),self);
	if(var_02 < 0.7)
	{
		return 0;
	}

	if(isdefined(param_01) && param_01)
	{
		thread drawline(param_00.origin,self gettagorigin("tag_turret"),10,(1,0,0));
	}

	return 1;
}

//Function Number: 43
func_389E(param_00)
{
	self endon("death");
	if(!isalive(param_00) || param_00.sessionstate != "playing")
	{
		return 0;
	}

	if(!isdefined(param_00.pers["team"]))
	{
		return 0;
	}

	if(param_00 == self.owner)
	{
		return 0;
	}

	if(distancesquared(param_00.origin,self.origin) > 1048576)
	{
		return 0;
	}

	if(level.teambased && param_00.pers["team"] == self.team)
	{
		return 0;
	}

	if(param_00.pers["team"] == "spectator")
	{
		return 0;
	}

	if(isdefined(param_00.spawntime) && gettime() - param_00.spawntime / 1000 <= 5)
	{
		return 0;
	}

	if(isdefined(self))
	{
		var_01 = self.mgturret.origin + (0,0,64);
		var_02 = param_00 sightconetrace(var_01,self);
		if(var_02 < 1)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 44
func_389F()
{
	self endon("death");
	self endon("leaving");
	var_00 = [];
	for(;;)
	{
		var_00 = [];
		var_01 = level.players;
		for(var_02 = 0;var_02 <= var_01.size;var_02++)
		{
			if(func_389E(var_01[var_02]))
			{
				if(isdefined(var_01[var_02]))
				{
					var_00[var_00.size] = var_01[var_02];
				}
			}
			else
			{
				continue;
			}

			wait 0.05;
		}

		if(var_00.size > 0)
		{
			func_38A1(var_00);
			return;
		}
		else
		{
			wait 0.5;
		}
	}
}

//Function Number: 45
func_38A0(param_00)
{
	self endon("death");
	var_01 = self.origin;
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_05 in param_00)
	{
		var_06 = distance(self.origin,var_05.origin);
		var_07 = var_05 getcurrentweapon();
		if(issubstr(var_07,"at4") || issubstr(var_07,"jav") || issubstr(var_07,"c4") || issubstr(var_07,"smart") || issubstr(var_07,"grenade"))
		{
			var_06 = var_06 - 200;
		}

		if(!isdefined(var_02))
		{
			var_02 = var_06;
			var_03 = var_05;
			continue;
		}

		if(var_02 > var_06)
		{
			var_02 = var_06;
			var_03 = var_05;
		}
	}

	return var_03;
}

//Function Number: 46
func_38A1(param_00)
{
	self endon("death");
	if(param_00.size == 1)
	{
		self.var_38A2 = param_00[0];
	}
	else
	{
		self.var_38A2 = func_38A0(param_00);
	}

	if(distance2d(self.origin,self.var_38A2.origin) > 768)
	{
		thread func_387B();
	}

	self notify("acquiringMiniTarget");
	self.mgturret settargetentity(self.var_38A2,(0,0,64));
	wait 0.15;
	thread func_38A3();
	thread func_38A4(param_00);
	thread func_38A5(param_00);
	thread func_38A6(self.var_38A2);
}

//Function Number: 47
func_38A3()
{
	self endon("death");
	self endon("abandonedMiniTarget");
	self endon("killedMiniTarget");
	var_00 = undefined;
	var_01 = gettime();
	if(!isdefined(self.var_38A2))
	{
		return;
	}

	for(;;)
	{
		if(!isdefined(self.mgturret getturrettarget(1)))
		{
			if(!isdefined(var_00))
			{
				var_00 = gettime();
			}

			var_02 = gettime();
			if(var_00 - var_02 > 1)
			{
				var_00 = undefined;
				thread func_38A7();
				return;
			}

			wait 0.5;
			continue;
		}

		if(gettime() > var_01 + 1000 && !isdefined(self.besttarget))
		{
			if(distance2d(self.origin,self.var_38A2.origin) > 768)
			{
				var_01[0] = self.var_38A2;
				func_3895(var_05);
			}
		}

		var_04 = randomintrange(10,16);
		for(var_05 = 0;var_05 < var_04;var_05++)
		{
			self.mgturret shootturret();
			wait 0.1;
		}

		wait randomfloatrange(0.5,3);
	}
}

//Function Number: 48
func_38A4(param_00)
{
	self endon("abandonedMiniTarget");
	self endon("death");
	if(!isdefined(self.var_38A2))
	{
		return;
	}

	self.var_38A2 waittill("death");
	self notify("killedMiniTarget");
	self.var_38A2 = undefined;
	self.mgturret cleartargetentity();
	func_389F();
}

//Function Number: 49
func_38A5(param_00)
{
	self endon("abandonedMiniTarget");
	self endon("death");
	for(;;)
	{
		if(!isdefined(self.var_38A2))
		{
			return;
		}

		var_01 = bullettrace(self.mgturret.origin,self.var_38A2.origin,0,self);
		var_02 = distance(self.origin,var_01["position"]);
		if(var_02 > 1024)
		{
			thread func_38A7();
			return;
		}

		wait 2;
	}
}

//Function Number: 50
func_38A6(param_00)
{
	self endon("abandonedMiniTarget");
	self endon("death");
	self endon("killedMiniTarget");
	for(;;)
	{
		var_01 = [];
		var_02 = level.players;
		for(var_03 = 0;var_03 <= var_02.size;var_03++)
		{
			if(func_389E(var_02[var_03]))
			{
				if(!isdefined(var_02[var_03]))
				{
					continue;
				}

				if(!isdefined(param_00))
				{
					return;
				}

				var_04 = distance(self.origin,param_00.origin);
				var_05 = distance(self.origin,var_02[var_03].origin);
				if(var_05 < var_04)
				{
					thread func_38A7();
					return;
				}
			}

			wait 0.05;
		}

		wait 0.25;
	}
}

//Function Number: 51
func_38A7(param_00)
{
	self notify("abandonedMiniTarget");
	self.var_38A2 = undefined;
	self.mgturret cleartargetentity();
	if(isdefined(param_00) && param_00)
	{
		return;
	}

	thread func_389F();
}

//Function Number: 52
func_38A8()
{
	level.tanks[self getentitynumber()] = self;
}

//Function Number: 53
func_38A9()
{
	level.tanks[self getentitynumber()] = undefined;
}

//Function Number: 54
func_38AA()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(var_02.team == "spectator")
		{
			continue;
		}

		if(var_02.team == self.team)
		{
			continue;
		}

		if(!isalive(var_02))
		{
			continue;
		}

		var_02.dist = 0;
		var_00[var_00.size] = var_02;
	}

	if(!var_00.size)
	{
		return undefined;
	}

	for(var_04 = 0;var_04 < var_00.size;var_04++)
	{
		for(var_05 = var_04 + 1;var_05 < var_00.size;var_05++)
		{
			var_06 = distancesquared(var_00[var_04].origin,var_00[var_05].origin);
			var_00[var_04].dist = var_00[var_04].dist + var_06;
			var_00[var_05].dist = var_00[var_05].dist + var_06;
		}
	}

	var_07 = var_00[0];
	foreach(var_02 in var_00)
	{
		if(var_02.dist < var_07.dist)
		{
			var_07 = var_02;
		}
	}

	var_0A = var_07.origin;
	var_0B = sortbydistance(level.var_3884,var_0A);
	return var_0B[0];
}

//Function Number: 55
func_38AC()
{
	var_00 = [];
	var_01 = [];
	var_02 = [];
	var_03 = [];
	var_04 = getvehiclenode("startnode","targetname");
	var_00[var_00.size] = var_04;
	var_01[var_01.size] = var_04;
	while(isdefined(var_04.target))
	{
		var_05 = var_04;
		var_04 = getvehiclenode(var_04.target,"targetname");
		var_04.var_147B = var_05;
		if(var_04 == var_00[0])
		{
			break;
		}

		var_00[var_00.size] = var_04;
		if(!isdefined(var_04.target))
		{
			return;
		}
	}

	var_00[0].var_38AD = [];
	var_00[0] thread func_38B7("forward");
	var_03[var_03.size] = var_00[0];
	var_06 = getvehiclenodearray("branchnode","targetname");
	foreach(var_08 in var_06)
	{
		var_04 = var_08;
		var_00[var_00.size] = var_04;
		var_01[var_01.size] = var_04;
		while(isdefined(var_04.target))
		{
			var_05 = var_04;
			var_04 = getvehiclenode(var_04.target,"targetname");
			var_00[var_00.size] = var_04;
			var_04.var_147B = var_05;
			if(!isdefined(var_04.target))
			{
				var_02[var_02.size] = var_04;
			}
		}
	}

	foreach(var_04 in var_00)
	{
		var_0B = 0;
		foreach(var_0D in var_01)
		{
			if(var_0D == var_04)
			{
				continue;
			}

			if(var_0D.target == var_04.targetname)
			{
				continue;
			}

			if(isdefined(var_04.target) && var_04.target == var_0D.targetname)
			{
				continue;
			}

			if(distance2d(var_04.origin,var_0D.origin) > 80)
			{
				continue;
			}

			var_0D thread func_38B9(var_04,"reverse");
			var_0D.var_147B = var_04;
			if(!isdefined(var_04.var_38AD))
			{
				var_04.var_38AD = [];
			}

			var_04.var_38AD[var_04.var_38AD.size] = var_0D;
			var_0B = 1;
		}

		if(var_0B)
		{
			var_04 thread func_38B7("forward");
		}

		var_0F = 0;
		foreach(var_11 in var_02)
		{
			if(var_11 == var_04)
			{
				continue;
			}

			if(!isdefined(var_04.target))
			{
				continue;
			}

			if(var_04.target == var_11.targetname)
			{
				continue;
			}

			if(isdefined(var_11.target) && var_11.target == var_04.targetname)
			{
				continue;
			}

			if(distance2d(var_04.origin,var_11.origin) > 80)
			{
				continue;
			}

			var_11 thread func_38B9(var_04,"forward");
			var_11.var_38AE = getvehiclenode(var_04.targetname,"targetname");
			var_11.var_38AF = distance(var_11.origin,var_04.origin);
			if(!isdefined(var_04.var_38AD))
			{
				var_04.var_38AD = [];
			}

			var_04.var_38AD[var_04.var_38AD.size] = var_11;
			var_0F = 1;
		}

		if(var_0F)
		{
			var_04 thread func_38B7("reverse");
		}

		if(var_0F || var_0B)
		{
			var_03[var_03.size] = var_04;
		}
	}

	if(var_03.size < 3)
	{
		level notify("end_tankPathHandling");
		return;
	}

	var_14 = [];
	foreach(var_04 in var_00)
	{
		if(!isdefined(var_04.var_38AD))
		{
			continue;
		}

		var_14[var_14.size] = var_04;
	}

	foreach(var_18 in var_14)
	{
		var_04 = var_18;
		var_19 = 0;
		while(isdefined(var_04.target))
		{
			var_1A = var_04;
			var_04 = getvehiclenode(var_04.target,"targetname");
			var_19 = var_19 + distance(var_04.origin,var_1A.origin);
			if(var_04 == var_18)
			{
				break;
			}

			if(isdefined(var_04.var_38AD))
			{
				break;
			}
		}

		if(var_19 > 1000)
		{
			var_04 = var_18;
			var_1B = 0;
			while(isdefined(var_04.target))
			{
				var_1A = var_04;
				var_04 = getvehiclenode(var_04.target,"targetname");
				var_1B = var_1B + distance(var_04.origin,var_1A.origin);
				if(var_1B < var_19 / 2)
				{
					continue;
				}

				var_04.var_38AD = [];
				var_04 thread func_38B7("forward");
				var_03[var_03.size] = var_04;
				break;
			}
		}
	}

	level.var_3884 = func_38C2(var_03);
	foreach(var_04 in var_00)
	{
		if(!isdefined(var_04.var_38B0))
		{
			var_04 thread func_38BA();
		}
	}
}

//Function Number: 56
func_38B1(param_00)
{
	var_01 = [];
	foreach(var_04, var_03 in self.var_38B2)
	{
		if(self.var_38B3[var_04] != param_00)
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01[randomint(var_01.size)];
}

//Function Number: 57
func_38B4(param_00,param_01)
{
	var_02 = level.var_3884[self.var_38B0];
	var_03 = func_38CA(var_02,param_00,undefined,param_01);
	var_04 = var_03[0].var_38B5;
	var_05 = func_38CA(var_02,param_00,undefined,level.var_38B6[param_01]);
	var_06 = var_05[0].var_38B5;
	if(!getdvarint("tankDebug"))
	{
		var_06 = 9999999;
	}

	if(var_04 <= var_06)
	{
		return var_03[1];
	}
}

//Function Number: 58
func_38B7(param_00)
{
	level endon("end_tankPathHandling");
	for(;;)
	{
		self waittill("trigger",var_01,var_02);
		var_03 = level.var_3884[self.var_38B0];
		var_01.node = self;
		var_04 = undefined;
		if(isdefined(var_01.var_3885) && var_01.var_3885 != var_03)
		{
			var_04 = func_38B4(var_01.var_3885,var_01.veh_pathdir);
			if(!isdefined(var_04))
			{
				var_01 thread func_3877(level.var_38B6[var_01.veh_pathdir]);
			}
		}

		if(!isdefined(var_04) || var_04 == var_03)
		{
			var_04 = var_03 func_38B1(var_01.veh_pathdir);
		}

		var_05 = var_03.var_38B8[var_04.var_38B0];
		if(var_01.veh_pathdir == "forward")
		{
			var_06 = func_38C0();
		}
		else
		{
			var_06 = func_38C1();
		}

		if(var_06 != var_05)
		{
			var_01 startpath(var_05);
		}
	}
}

//Function Number: 59
func_38B9(param_00,param_01)
{
	for(;;)
	{
		self waittill("trigger",var_02);
		if(var_02.veh_pathdir != param_01)
		{
			continue;
		}

		func_38D9("tank starting path at join node: " + param_00.var_38B0);
		var_02 startpath(param_00);
	}
}

//Function Number: 60
func_38BA()
{
	self.var_38BB = func_38BE().var_38B0;
	self.var_38BC = func_38BF().var_38B0;
	for(;;)
	{
		self waittill("trigger",var_00,var_01);
		var_00.node = self;
		var_00.var_38BB = self.var_38BB;
		var_00.var_38BC = self.var_38BC;
		if(!isdefined(self.target) || self.targetname == "branchnode")
		{
			var_02 = "TRANS";
		}
		else
		{
			var_02 = "NODE";
		}

		if(isdefined(var_01))
		{
			func_38DA(self.origin,var_02,(1,0.5,0),1,2,100);
			continue;
		}

		func_38DA(self.origin,var_02,(0,1,0),1,2,100);
	}
}

//Function Number: 61
func_38BD(param_00,param_01,param_02)
{
	param_01 endon("trigger");
	param_00 endon("trigger");
	param_02 endon("death");
	var_03 = distancesquared(param_02.origin,param_01.origin);
	var_04 = param_02.veh_pathdir;
	func_38DA(param_00.origin + (0,0,30),"LAST",(0,0,1),0.5,1,100);
	func_38DA(param_01.origin + (0,0,60),"NEXT",(0,1,0),0.5,1,100);
	var_05 = 0;
	for(;;)
	{
		wait 0.05;
		if(var_04 != param_02.veh_pathdir)
		{
			func_38D9("tank missed node: reversing direction");
			param_02 thread func_38BD(param_01,param_00,param_02);
			return;
		}

		if(var_05)
		{
			func_38D9("... sending notify.");
			param_01 notify("trigger",param_02,1);
			return;
		}

		var_06 = distancesquared(param_02.origin,param_01.origin);
		if(var_06 > var_03)
		{
			var_05 = 1;
			func_38D9("tank missed node: forcing notify in one frame...");
		}

		var_03 = var_06;
	}
}

//Function Number: 62
func_38BE()
{
	for(var_00 = self;!isdefined(var_00.var_38B0);var_00 = var_00 func_38C0())
	{
	}

	return var_00;
}

//Function Number: 63
func_38BF()
{
	for(var_00 = self;!isdefined(var_00.var_38B0);var_00 = var_00 func_38C1())
	{
	}

	return var_00;
}

//Function Number: 64
func_38C0()
{
	if(isdefined(self.target))
	{
		return getvehiclenode(self.target,"targetname");
	}

	return self.var_38AE;
}

//Function Number: 65
func_38C1()
{
	return self.var_147B;
}

//Function Number: 66
func_38C2(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_04 = spawnstruct();
		var_04.var_38C3 = [];
		var_04.var_38B2 = [];
		var_04.var_38C4 = [];
		var_04.var_38B3 = [];
		var_04.var_38B8 = [];
		var_04.node = var_03;
		var_04.origin = var_03.origin;
		var_04.var_38B0 = var_01.size;
		var_03.var_38B0 = var_01.size;
		func_38DA(var_04.origin + (0,0,80),var_04.var_38B0,(1,1,1),0.65,2,100000);
		var_01[var_01.size] = var_04;
	}

	foreach(var_03 in param_00)
	{
		var_07 = var_03.var_38B0;
		var_08 = getvehiclenode(var_03.target,"targetname");
		var_09 = distance(var_03.origin,var_08.origin);
		var_0A = var_08;
		while(!isdefined(var_08.var_38B0))
		{
			var_09 = var_09 + distance(var_08.origin,var_08.var_147B.origin);
			if(isdefined(var_08.target))
			{
				var_08 = getvehiclenode(var_08.target,"targetname");
				continue;
			}

			var_08 = var_08.var_38AE;
		}

		var_01[var_07] func_38C5(var_01[var_08.var_38B0],var_09,"forward",var_0A);
		var_08 = var_03.var_147B;
		var_09 = distance(var_03.origin,var_08.origin);
		var_0A = var_08;
		while(!isdefined(var_08.var_38B0))
		{
			var_09 = var_09 + distance(var_08.origin,var_08.var_147B.origin);
			var_08 = var_08.var_147B;
		}

		var_01[var_07] func_38C5(var_01[var_08.var_38B0],var_09,"reverse",var_0A);
		foreach(var_0C in var_03.var_38AD)
		{
			var_08 = var_0C;
			var_09 = distance(var_03.origin,var_08.origin);
			var_0A = var_08;
			if(var_08.targetname == "branchnode")
			{
				while(!isdefined(var_08.var_38B0))
				{
					if(isdefined(var_08.target))
					{
						var_0D = getvehiclenode(var_08.target,"targetname");
					}
					else
					{
						var_0D = var_08.var_38AE;
					}

					var_09 = var_09 + distance(var_08.origin,var_0D.origin);
					var_08 = var_0D;
				}

				var_01[var_07] func_38C5(var_01[var_08.var_38B0],var_09,"forward",var_0A);
				continue;
			}

			while(!isdefined(var_08.var_38B0))
			{
				var_09 = var_09 + distance(var_08.origin,var_08.var_147B.origin);
				var_08 = var_08.var_147B;
			}

			var_01[var_07] func_38C5(var_01[var_08.var_38B0],var_09,"reverse",var_0A);
		}
	}

	return var_01;
}

//Function Number: 67
func_38C5(param_00,param_01,param_02,param_03)
{
	self.var_38B2[param_00.var_38B0] = param_00;
	self.var_38C4[param_00.var_38B0] = param_01;
	self.var_38B3[param_00.var_38B0] = param_02;
	self.var_38B8[param_00.var_38B0] = param_03;
	var_04 = spawnstruct();
	var_04.var_38C6 = param_00;
	var_04.var_38C7 = param_00.var_38B0;
	var_04.var_38AF = param_01;
	var_04.direction = param_02;
	var_04.var_38C9 = param_03;
	self.var_38C3[param_00.var_38B0] = var_04;
}

//Function Number: 68
func_38CA(param_00,param_01,param_02,param_03)
{
	level.var_38CB = [];
	level.var_38CC = [];
	var_04 = 0;
	var_05 = [];
	if(!isdefined(param_02))
	{
		param_02 = [];
	}

	param_01.var_38B5 = 0;
	param_01.var_38CD = func_38D4(param_01,param_00);
	param_01.var_38CE = param_01.var_38B5 + param_01.var_38CD;
	func_38D3(param_01);
	var_06 = param_01;
	for(;;)
	{
		foreach(var_08 in var_06.var_38B2)
		{
			if(is_in_array(param_02,var_08))
			{
				continue;
			}

			if(is_in_array(level.var_38CC,var_08))
			{
				continue;
			}

			if(isdefined(param_03) && var_08.var_38B3[var_06.var_38B0] != param_03)
			{
				continue;
			}

			if(!is_in_array(level.var_38CB,var_08))
			{
				func_38D0(var_08);
				var_08.var_38CF = var_06;
				var_08.var_38B5 = func_38D5(var_08,var_06);
				var_08.var_38CD = func_38D4(var_08,param_00);
				var_08.var_38CE = var_08.var_38B5 + var_08.var_38CD;
				if(var_08 == param_00)
				{
					var_04 = 1;
				}

				continue;
			}

			if(var_08.var_38B5 < func_38D5(var_06,var_08))
			{
				continue;
			}

			var_08.var_38CF = var_06;
			var_08.var_38B5 = func_38D5(var_08,var_06);
			var_08.var_38CE = var_08.var_38B5 + var_08.var_38CD;
		}

		if(var_04)
		{
			break;
		}

		func_38D3(var_06);
		var_0A = level.var_38CB[0];
		foreach(var_0C in level.var_38CB)
		{
			if(var_0C.var_38CE > var_0A.var_38CE)
			{
				continue;
			}

			var_0A = var_0C;
		}

		func_38D3(var_0A);
		var_06 = var_0A;
	}

	var_06 = param_00;
	while(var_06 != param_01)
	{
		var_05[var_05.size] = var_06;
		var_06 = var_06.var_38CF;
	}

	var_05[var_05.size] = var_06;
	return var_05;
}

//Function Number: 69
func_38D0(param_00)
{
	param_00.var_38D1 = level.var_38CB.size;
	level.var_38CB[level.var_38CB.size] = param_00;
	param_00.var_38D2 = undefined;
}

//Function Number: 70
func_38D3(param_00)
{
	if(isdefined(param_00.var_38D2))
	{
		return;
	}

	param_00.var_38D2 = level.var_38CC.size;
	level.var_38CC[level.var_38CC.size] = param_00;
	if(!is_in_array(level.var_38CB,param_00))
	{
		return;
	}

	level.var_38CB[param_00.var_38D1] = level.var_38CB[level.var_38CB.size - 1];
	level.var_38CB[param_00.var_38D1].var_38D1 = param_00.var_38D1;
	level.var_38CB[level.var_38CB.size - 1] = undefined;
	param_00.var_38D1 = undefined;
}

//Function Number: 71
func_38D4(param_00,param_01)
{
	return distance(param_00.node.origin,param_01.node.origin);
}

//Function Number: 72
func_38D5(param_00,param_01)
{
	return param_00.var_38CF.var_38B5 + param_00.var_38C4[param_01.var_38B0];
}

//Function Number: 73
is_in_array(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(param_00[var_02] == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 74
func_38D6(param_00)
{
	for(var_01 = 1;var_01 < param_00.size;var_01++)
	{
		var_02 = param_00[var_01 - 1];
		var_03 = param_00[var_01];
		if(var_02.var_38B3[var_03.var_38B0] == "reverse")
		{
			level thread func_38D8(var_02.node.origin,var_03.node.origin,(1,0,0));
		}
		else
		{
			level thread func_38D8(var_02.node.origin,var_03.node.origin,(0,1,0));
		}

		var_04 = var_02.var_38B8[var_03.var_38B0];
		level thread func_38D8(var_02.node.origin + (0,0,4),var_04.origin + (0,0,4),(0,0,1));
		if(var_02.var_38B3[var_03.var_38B0] == "reverse")
		{
			while(!isdefined(var_04.var_38B0))
			{
				var_05 = var_04;
				var_04 = var_04.var_147B;
				level thread func_38D8(var_05.origin + (0,0,4),var_04.origin + (0,0,4),(0,1,1));
			}

			continue;
		}

		while(!isdefined(var_04.var_38B0))
		{
			var_05 = var_04;
			if(isdefined(var_04.target))
			{
				var_04 = getvehiclenode(var_04.target,"targetname");
				continue;
			}

			var_04 = var_04.var_38AE;
			level thread func_38D8(var_05.origin + (0,0,4),var_04.origin + (0,0,4),(0,1,1));
		}
	}
}

//Function Number: 75
func_38D7(param_00)
{
}

//Function Number: 76
func_38D8(param_00,param_01,param_02)
{
	level endon("endpath");
	wait 0.05;
}

//Function Number: 77
func_38D9(param_00)
{
}

//Function Number: 78
debugprint(param_00)
{
}

//Function Number: 79
func_38DA(param_00,param_01,param_02,param_03,param_04,param_05)
{
}

//Function Number: 80
func_38DB()
{
}