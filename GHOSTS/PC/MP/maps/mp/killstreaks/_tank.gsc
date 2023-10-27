/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_tank.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 79
 * Decompile Time: 1395 ms
 * Timestamp: 10/27/2023 1:21:43 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
}

//Function Number: 2
spawnarmor(param_00,param_01,param_02)
{
	var_03 = self vehicle_dospawn("tank",param_00);
	var_03.health = 3000;
	var_03.targeting_delay = 1;
	var_03.team = param_00.team;
	var_03.pers["team"] = var_03.team;
	var_03.owner = param_00;
	var_03 setcandamage(1);
	var_03.standardspeed = 12;
	var_03 thread func_2593();
	var_03 addtotanklist();
	var_03.damagecallback = ::callback_vehicledamage;
	return var_03;
}

//Function Number: 3
func_2593()
{
	self endon("death");
	var_00 = self.origin[2];
	for(;;)
	{
		if(var_00 - self.origin[2] > 2048)
		{
			self.health = 0;
			self notify("death");
		}

		wait(1);
	}
}

//Function Number: 4
func_87D8(param_00)
{
	return func_8457();
}

//Function Number: 5
func_8457()
{
	if(isdefined(level.tankinuse) && level.tankinuse)
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
		var_00 = level.tankspawner["allies"] spawnarmor(self,"vehicle_bradley");
	}
	else
	{
		var_00 = level.tankspawner["axis"] spawnarmor(self,"vehicle_bmp");
	}

	var_00 func_7AF6();
	return 1;
}

//Function Number: 6
func_7AF6(param_00)
{
	var_01 = getvehiclenode("startnode","targetname");
	var_02 = getvehiclenode("waitnode","targetname");
	self.nodes = getvehiclenodearray("info_vehicle_node","classname");
	level.tankinuse = 1;
	thread tankupdate(var_01,var_02);
	thread func_7F22();
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
	thread waitforchangeteams();
	thread func_8ADF();
	self.timelastfired = gettime();
	var_0A = spawn("script_origin",self gettagorigin("tag_flash"));
	var_0A linkto(self,"tag_origin",var_09,(0,0,0));
	var_0A hide();
	self.neutraltarget = var_0A;
	thread func_7F2C();
	thread func_265A();
	thread func_7F2A();
	thread func_1B9A();
	thread func_8CF1();
}

//Function Number: 7
waitforchangeteams()
{
	self endon("death");
	self.owner endon("disconnect");
	self.owner waittill("joined_team");
	self.health = 0;
	self notify("death");
}

//Function Number: 8
func_8ADF()
{
	self endon("death");
	self.owner waittill("disconnect");
	self.health = 0;
	self notify("death");
}

//Function Number: 9
setdirection(param_00)
{
	if(self.veh_pathdir != param_00)
	{
		if(param_00 == "forward")
		{
			func_7C74();
		}

		func_7C75();
	}
}

//Function Number: 10
func_702D()
{
	self endon("death");
	self notify("path_abandoned");
	while(isdefined(self.changingdirection))
	{
		wait(0.05);
	}

	var_00 = 2;
	self vehicle_setspeed(var_00,10,10);
	self.speedtype = "engage";
}

//Function Number: 11
func_7070()
{
	self endon("death");
	self notify("path_abandoned");
	while(isdefined(self.changingdirection))
	{
		wait(0.05);
	}

	var_00 = 2;
	self vehicle_setspeed(var_00,10,10);
	self.speedtype = "engage";
}

//Function Number: 12
setstandardspeed()
{
	self endon("death");
	while(isdefined(self.changingdirection))
	{
		wait(0.05);
	}

	self vehicle_setspeed(self.standardspeed,10,10);
	self.speedtype = "standard";
}

//Function Number: 13
func_702F()
{
	self endon("death");
	while(isdefined(self.changingdirection))
	{
		wait(0.05);
	}

	self vehicle_setspeed(15,15,15);
	self.speedtype = "evade";
	wait(1.5);
	self vehicle_setspeed(self.standardspeed,10,10);
}

//Function Number: 14
func_7011()
{
	self endon("death");
	while(isdefined(self.changingdirection))
	{
		wait(0.05);
	}

	self vehicle_setspeed(5,5,5);
	self.speedtype = "danger";
}

//Function Number: 15
func_7C75()
{
	debugprintln2("tank changing direction at " + gettime());
	self vehicle_setspeed(0,5,6);
	self.changingdirection = 1;
	while(self.veh_speed > 0)
	{
		wait(0.05);
	}

	wait(0.25);
	self.changingdirection = undefined;
	debugprintln2("tank done changing direction");
	self.veh_transmission = "reverse";
	self.veh_pathdir = "reverse";
	self vehicle_setspeed(self.standardspeed,5,6);
}

//Function Number: 16
func_7C74()
{
	debugprintln2("tank changing direction at " + gettime());
	self vehicle_setspeed(0,5,6);
	self.changingdirection = 1;
	while(self.veh_speed > 0)
	{
		wait(0.05);
	}

	wait(0.25);
	self.changingdirection = undefined;
	debugprintln2("tank done changing direction");
	self.veh_transmission = "forward";
	self.veh_pathdir = "forward";
	self vehicle_setspeed(self.standardspeed,5,6);
}

//Function Number: 17
func_1B9A()
{
	self endon("death");
	var_00 = [];
	var_01 = level.players;
	self.numenemiesclose = 0;
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
				wait(0.05);
				continue;
			}

			var_04 = distance2d(var_03.origin,self.origin);
			if(var_04 < 2048)
			{
				self.numenemiesclose++;
			}

			wait(0.05);
		}

		if(isdefined(self.speedtype) && self.speedtype == "evade" || self.speedtype == "engage")
		{
			self.numenemiesclose = 0;
			continue;
		}

		if(self.numenemiesclose > 1)
		{
			thread func_7011();
		}
		else
		{
			thread setstandardspeed();
		}

		self.numenemiesclose = 0;
		wait(0.05);
	}
}

//Function Number: 18
tankupdate(param_00,param_01)
{
	self endon("tankDestroyed");
	self endon("death");
	if(!isdefined(level.graphnodes))
	{
		self startpath(param_00);
	}

	self attachpath(param_00);
	self startpath(param_00);
	param_00 notify("trigger",self,1);
	wait(0.05);
	for(;;)
	{
		while(isdefined(self.changingdirection))
		{
			wait(0.05);
		}

		var_02 = func_3B4F();
		if(isdefined(var_02))
		{
			self.endnode = var_02;
		}
		else
		{
			self.endnode = undefined;
		}

		wait(0.65);
	}
}

//Function Number: 19
callback_vehicledamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if((param_01 == self || param_01 == self.mgturret || isdefined(param_01.pers) && param_01.pers["team"] == self.team) && param_01 != self.owner || param_04 == "MOD_MELEE")
	{
	}

	var_0C = modifydamage(param_04,param_02,param_01);
	self vehicle_finishdamage(param_00,param_01,var_0C,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 20
func_7F22()
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
				self.forcedtarget = var_06;
				thread explicitabandontarget();
			}
		}
		else if(isplayer(var_06))
		{
			var_06 maps\mp\gametypes\_damagefeedback::func_86E0("hitHelicopter");
			if(var_06 maps\mp\_utility::_hasperk("specialty_armorpiercing"))
			{
				var_0A = var_05 * level.armorpiercingmod;
				self.health = self.health - int(var_0A);
			}
		}

		if(self.health <= 0)
		{
			self notify("death");
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
			func_3F9C(var_06);
		}
	}
}

//Function Number: 21
func_3F9C(param_00)
{
	self endon("death");
	var_01 = randomint(100);
	if(isdefined(self.besttarget) && self.besttarget != param_00 && var_01 > 30)
	{
		var_02 = [];
		var_02[0] = self.besttarget;
		explicitabandontarget(1,self.besttarget);
		thread acquiretarget(var_02);
	}

	if(!isdefined(self.besttarget) && var_01 > 30)
	{
		var_02 = [];
		var_02[0] = param_00;
		thread acquiretarget(var_02);
	}

	if(var_01 < 30)
	{
		playfx(level.tankcover,self.origin);
		thread func_702F();
	}

	self fireweapon();
	self playsound("bmp_fire");
}

//Function Number: 22
func_3F92(param_00)
{
	self endon("death");
	var_01 = func_6482(param_00);
	var_02 = distance(self.origin,param_00.origin);
	if(randomint(4) < 3)
	{
	}

	if(var_01 == "front" && var_02 < 768)
	{
		thread func_702F();
	}

	if(var_01 == "rear_side" || var_01 == "rear" && var_02 >= 768)
	{
		playfx(level.tankcover,self.origin);
		thread func_702F();
	}

	if(var_01 == "rear" && var_02 < 768)
	{
		func_7C75();
		func_702F();
		wait(4);
		func_7C74();
	}

	if(var_01 == "front_side" || var_01 == "front")
	{
		playfx(level.tankcover,self.origin);
		func_7C75();
		func_702F();
		wait(8);
		func_7C74();
	}
}

//Function Number: 23
func_6482(param_00)
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
func_8CF1()
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
				wait(0.05);
				continue;
			}

			if(!func_497E(var_03))
			{
				wait(0.05);
				continue;
			}

			var_04 = var_03 getcurrentweapon();
			if(issubstr(var_04,"at4") || issubstr(var_04,"stinger") || issubstr(var_04,"javelin"))
			{
				thread func_3F92(var_03);
				wait(8);
			}

			wait(0.15);
		}
	}
}

//Function Number: 25
checkowner()
{
	if(!isdefined(self.owner) || !isdefined(self.owner.pers["team"]) || self.owner.pers["team"] != self.team)
	{
		self notify("abandoned");
		return 0;
	}

	return 1;
}

//Function Number: 26
modifydamage(param_00,param_01,param_02)
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

//Function Number: 27
func_265A()
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
	level.tankinuse = 0;
	playfx(level.spawnfire,self.origin);
	playfx(level.tankfire,self.origin);
	removefromtanklist();
	var_01 = spawn("script_model",self.origin);
	var_01 setmodel("vehicle_m1a1_abrams_d_static");
	var_01.angles = self.angles;
	self.mgturret delete();
	self delete();
	wait(4);
	var_01 delete();
}

//Function Number: 28
onhitpitchclamp()
{
	self notify("onTargOrTimeOut");
	self endon("onTargOrTimeOut");
	self endon("turret_on_target");
	self waittill("turret_pitch_clamped");
	thread explicitabandontarget(0,self.besttarget);
}

//Function Number: 29
fireontarget()
{
	self endon("abandonedTarget");
	self endon("killedTarget");
	self endon("death");
	self endon("targetRemoved");
	self endon("lostLOS");
	for(;;)
	{
		onhitpitchclamp();
		if(!isdefined(self.besttarget))
		{
			continue;
		}

		var_00 = self gettagorigin("tag_flash");
		var_01 = bullettrace(self.origin,var_00,0,self);
		if(var_01["position"] != var_00)
		{
			thread explicitabandontarget(0,self.besttarget);
		}

		var_01 = bullettrace(var_00,self.besttarget.origin,1,self);
		var_02 = distance(self.origin,var_01["position"]);
		var_03 = distance(self.besttarget.origin,self.origin);
		if(var_02 < 384 || var_02 + 256 < var_03)
		{
			wait(0.5);
			if(var_02 > 384)
			{
				func_8AFD();
				self fireweapon();
				self playsound("bmp_fire");
				self.timelastfired = gettime();
			}

			var_04 = func_6482(self.besttarget);
			thread explicitabandontarget(0,self.besttarget);
		}

		func_8AFD();
		self fireweapon();
		self playsound("bmp_fire");
		self.timelastfired = gettime();
	}
}

//Function Number: 30
func_8AFD()
{
	self endon("abandonedTarget");
	self endon("killedTarget");
	self endon("death");
	self endon("targetRemoved");
	self endon("lostLOS");
	var_00 = gettime() - self.timelastfired;
	if(var_00 < 1499)
	{
		wait(1.5 - var_00 / 1000);
	}
}

//Function Number: 31
func_7F2C(param_00)
{
	self endon("death");
	self endon("leaving");
	var_01 = [];
	for(;;)
	{
		var_01 = [];
		var_02 = level.players;
		if(isdefined(self.forcedtarget))
		{
			var_01 = [];
			var_01[0] = self.forcedtarget;
			acquiretarget(var_01);
			self.forcedtarget = undefined;
		}

		if(isdefined(level.harrier) && level.harrier.team != self.team && isalive(level.harrier))
		{
			if(func_49B1(level.tank))
			{
				var_01[var_01.size] = level.tank;
			}
		}

		if(isdefined(level.chopper) && level.chopper.team != self.team && isalive(level.chopper))
		{
			if(func_49B1(level.chopper))
			{
				var_01[var_01.size] = level.chopper;
			}
		}

		foreach(var_04 in var_02)
		{
			if(!isdefined(var_04))
			{
				wait(0.05);
				continue;
			}

			if(isdefined(param_00) && var_04 == param_00)
			{
				continue;
			}

			if(func_497E(var_04))
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
			acquiretarget(var_01);
			continue;
		}

		wait(1);
	}
}

//Function Number: 32
acquiretarget(param_00)
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

	thread func_702D();
	thread func_8D2A(param_00);
	self setturrettargetent(self.besttarget);
	fireontarget();
	thread func_707D();
}

//Function Number: 33
func_707D()
{
	self endon("death");
	setstandardspeed();
	func_65B2();
	self setturrettargetent(self.neutraltarget);
}

//Function Number: 34
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

		if(isdefined(level.harrier) && var_07 == level.harrier)
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

//Function Number: 35
func_8D2A(param_00)
{
	self endon("abandonedTarget");
	self endon("lostLOS");
	self endon("death");
	self endon("targetRemoved");
	var_01 = self.besttarget;
	var_01 endon("disconnect");
	var_01 waittill("death");
	self notify("killedTarget");
	func_65B2();
	setstandardspeed();
	thread func_707D();
}

//Function Number: 36
explicitabandontarget(param_00,param_01)
{
	self endon("death");
	self notify("abandonedTarget");
	setstandardspeed();
	thread func_707D();
	func_65B2();
	if(isdefined(param_01))
	{
		self.badtarget = param_01;
		badtargetreset();
	}

	if(isdefined(param_00) && param_00)
	{
	}
}

//Function Number: 37
badtargetreset()
{
	self endon("death");
	wait(1.5);
	self.badtarget = undefined;
}

//Function Number: 38
func_65B2()
{
	self notify("targetRemoved");
	self.besttarget = undefined;
	self.lastlosttime = undefined;
}

//Function Number: 39
func_49B1(param_00)
{
	if(distance2d(param_00.origin,self.origin) > 4096)
	{
		return 0;
	}

	if(distance(param_00.origin,self.origin) < 512)
	{
		return 0;
	}

	return func_8535(param_00,0);
}

//Function Number: 40
func_497E(param_00)
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

	if(isdefined(param_00.var_78C4) && gettime() - param_00.var_78C4 / 1000 <= 5)
	{
		return 0;
	}

	if(param_00 maps\mp\_utility::_hasperk("specialty_blindeye"))
	{
		return 0;
	}

	return self vehicle_canturrettargetpoint(param_00.origin,1,self);
}

//Function Number: 41
func_8535(param_00,param_01)
{
	var_02 = param_00 sightconetrace(self gettagorigin("tag_turret"),self);
	if(var_02 < 0.7)
	{
		return 0;
	}

	if(isdefined(param_01) && param_01)
	{
		thread maps\mp\_utility::func_2A7E(param_00.origin,self gettagorigin("tag_turret"),10,(1,0,0));
	}

	return 1;
}

//Function Number: 42
isminitarget(param_00)
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

	if(isdefined(param_00.var_78C4) && gettime() - param_00.var_78C4 / 1000 <= 5)
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

//Function Number: 43
func_7F2A()
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
			if(isminitarget(var_01[var_02]))
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

			wait(0.05);
		}

		if(var_00.size > 0)
		{
			acquireminitarget(var_00);
			continue;
		}

		wait(0.5);
	}
}

//Function Number: 44
getbestminitarget(param_00)
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

//Function Number: 45
acquireminitarget(param_00)
{
	self endon("death");
	if(param_00.size == 1)
	{
		self.bestminitarget = param_00[0];
	}
	else
	{
		self.bestminitarget = getbestminitarget(param_00);
	}

	if(distance2d(self.origin,self.bestminitarget.origin) > 768)
	{
		thread func_7070();
	}

	self notify("acquiringMiniTarget");
	self.mgturret settargetentity(self.bestminitarget,(0,0,64));
	wait(0.15);
	thread func_330C();
	thread func_8D03(param_00);
	thread func_8D04(param_00);
	thread func_8D05(self.bestminitarget);
}

//Function Number: 46
func_330C()
{
	self endon("death");
	self endon("abandonedMiniTarget");
	self endon("killedMiniTarget");
	var_00 = undefined;
	var_01 = gettime();
	if(!isdefined(self.bestminitarget))
	{
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
				thread explicitabandonminitarget();
			}

			wait(0.5);
			continue;
		}

		if(gettime() > var_01 + 1000 && !isdefined(self.besttarget))
		{
			if(distance2d(self.origin,self.bestminitarget.origin) > 768)
			{
				var_01[0] = self.bestminitarget;
				acquiretarget(var_05);
			}
		}

		var_04 = randomintrange(10,16);
		for(var_05 = 0;var_05 < var_04;var_05++)
		{
			self.mgturret shootturret();
			wait(0.1);
		}

		wait(randomfloatrange(0.5,3));
	}
}

//Function Number: 47
func_8D03(param_00)
{
	self endon("abandonedMiniTarget");
	self endon("death");
	if(!isdefined(self.bestminitarget))
	{
	}

	self.bestminitarget waittill("death");
	self notify("killedMiniTarget");
	self.bestminitarget = undefined;
	self.mgturret cleartargetentity();
	func_7F2A();
}

//Function Number: 48
func_8D04(param_00)
{
	self endon("abandonedMiniTarget");
	self endon("death");
	for(;;)
	{
		if(!isdefined(self.bestminitarget))
		{
		}

		var_01 = bullettrace(self.mgturret.origin,self.bestminitarget.origin,0,self);
		var_02 = distance(self.origin,var_01["position"]);
		if(var_02 > 1024)
		{
			thread explicitabandonminitarget();
		}

		wait(2);
	}
}

//Function Number: 49
func_8D05(param_00)
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
			if(isminitarget(var_02[var_03]))
			{
				if(!isdefined(var_02[var_03]))
				{
					continue;
				}

				if(!isdefined(param_00))
				{
				}

				var_04 = distance(self.origin,param_00.origin);
				var_05 = distance(self.origin,var_02[var_03].origin);
				if(var_05 < var_04)
				{
					thread explicitabandonminitarget();
				}
			}

			wait(0.05);
		}

		wait(0.25);
	}
}

//Function Number: 50
explicitabandonminitarget(param_00)
{
	self notify("abandonedMiniTarget");
	self.bestminitarget = undefined;
	self.mgturret cleartargetentity();
	if(isdefined(param_00) && param_00)
	{
	}

	thread func_7F2A();
}

//Function Number: 51
addtotanklist()
{
	level.tanks[self getentitynumber()] = self;
}

//Function Number: 52
removefromtanklist()
{
	level.tanks[self getentitynumber()] = undefined;
}

//Function Number: 53
func_3B4F()
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
	var_0B = sortbydistance(level.graphnodes,var_0A);
	return var_0B[0];
}

//Function Number: 54
setuppaths()
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
		var_04.var_6154 = var_05;
		if(var_04 == var_00[0])
		{
			break;
		}

		var_00[var_00.size] = var_04;
		if(!isdefined(var_04.target))
		{
		}
	}

	var_00[0].branchnodes = [];
	var_00[0] thread handlebranchnode("forward");
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
			var_04.var_6154 = var_05;
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

			var_0D thread func_3F72(var_04,"reverse");
			var_0D.var_6154 = var_04;
			if(!isdefined(var_04.branchnodes))
			{
				var_04.branchnodes = [];
			}

			var_04.branchnodes[var_04.branchnodes.size] = var_0D;
			var_0B = 1;
		}

		if(var_0B)
		{
			var_04 thread handlebranchnode("forward");
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

			var_11 thread func_3F72(var_04,"forward");
			var_11.next = getvehiclenode(var_04.targetname,"targetname");
			var_11.length = distance(var_11.origin,var_04.origin);
			if(!isdefined(var_04.branchnodes))
			{
				var_04.branchnodes = [];
			}

			var_04.branchnodes[var_04.branchnodes.size] = var_11;
			var_0F = 1;
		}

		if(var_0F)
		{
			var_04 thread handlebranchnode("reverse");
		}

		if(var_0F || var_0B)
		{
			var_03[var_03.size] = var_04;
		}
	}

	if(var_03.size < 3)
	{
		level notify("end_tankPathHandling");
	}

	var_14 = [];
	foreach(var_04 in var_00)
	{
		if(!isdefined(var_04.branchnodes))
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

			if(isdefined(var_04.branchnodes))
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

				var_04.branchnodes = [];
				var_04 thread handlebranchnode("forward");
				var_03[var_03.size] = var_04;
				break;
			}
		}
	}

	level.graphnodes = func_4639(var_03);
	foreach(var_04 in var_00)
	{
		if(!isdefined(var_04.var_3D93))
		{
			var_04 thread func_565A();
		}
	}
}

//Function Number: 55
func_3BB5(param_00)
{
	var_01 = [];
	foreach(var_04, var_03 in self.links)
	{
		if(self.linkdirs[var_04] != param_00)
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01[randomint(var_01.size)];
}

//Function Number: 56
func_3B43(param_00,param_01)
{
	var_02 = level.graphnodes[self.var_3D93];
	var_03 = func_377F(var_02,param_00,undefined,param_01);
	var_04 = var_03[0].g;
	var_05 = func_377F(var_02,param_00,undefined,level.otherdir[param_01]);
	var_06 = var_05[0].g;
	if(!getdvarint("tankDebug"))
	{
		var_06 = 9999999;
	}

	if(var_04 <= var_06)
	{
		return var_03[1];
	}
}

//Function Number: 57
handlebranchnode(param_00)
{
	level endon("end_tankPathHandling");
	for(;;)
	{
		self waittill("trigger",var_01,var_02);
		var_03 = level.graphnodes[self.var_3D93];
		var_01.node = self;
		var_04 = undefined;
		if(isdefined(var_01.endnode) && var_01.endnode != var_03)
		{
			var_04 = func_3B43(var_01.endnode,var_01.veh_pathdir);
			if(!isdefined(var_04))
			{
				var_01 thread setdirection(level.otherdir[var_01.veh_pathdir]);
			}
		}

		if(!isdefined(var_04) || var_04 == var_03)
		{
			var_04 = var_03 func_3BB5(var_01.veh_pathdir);
		}

		var_05 = var_03.linkstartnodes[var_04.var_3D93];
		if(var_01.veh_pathdir == "forward")
		{
			var_06 = func_3B42();
		}
		else
		{
			var_06 = func_3BA6();
		}

		if(var_06 != var_05)
		{
			var_01 startpath(var_05);
		}
	}
}

//Function Number: 58
func_3F72(param_00,param_01)
{
	for(;;)
	{
		self waittill("trigger",var_02);
		if(var_02.veh_pathdir != param_01)
		{
			continue;
		}

		debugprintln2("tank starting path at join node: " + param_00.var_3D93);
		var_02 startpath(param_00);
	}
}

//Function Number: 59
func_565A()
{
	self.forwardgraphid = func_3AB3().var_3D93;
	self.reversegraphid = getreversegraphnode().var_3D93;
	for(;;)
	{
		self waittill("trigger",var_00,var_01);
		var_00.node = self;
		var_00.forwardgraphid = self.forwardgraphid;
		var_00.reversegraphid = self.reversegraphid;
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
			debugprint3d(self.origin,var_02,(1,0.5,0),1,2,100);
			continue;
		}

		debugprint3d(self.origin,var_02,(0,1,0),1,2,100);
	}
}

//Function Number: 60
forcetrigger(param_00,param_01,param_02)
{
	param_01 endon("trigger");
	param_00 endon("trigger");
	param_02 endon("death");
	var_03 = distancesquared(param_02.origin,param_01.origin);
	var_04 = param_02.veh_pathdir;
	debugprint3d(param_00.origin + (0,0,30),"LAST",(0,0,1),0.5,1,100);
	debugprint3d(param_01.origin + (0,0,60),"NEXT",(0,1,0),0.5,1,100);
	var_05 = 0;
	for(;;)
	{
		wait(0.05);
		if(var_04 != param_02.veh_pathdir)
		{
			debugprintln2("tank missed node: reversing direction");
			param_02 thread forcetrigger(param_01,param_00,param_02);
		}

		if(var_05)
		{
			debugprintln2("... sending notify.");
			param_01 notify("trigger",param_02,1);
		}

		var_06 = distancesquared(param_02.origin,param_01.origin);
		if(var_06 > var_03)
		{
			var_05 = 1;
			debugprintln2("tank missed node: forcing notify in one frame...");
		}

		var_03 = var_06;
	}
}

//Function Number: 61
func_3AB3()
{
	for(var_00 = self;!isdefined(var_00.var_3D93);var_00 = var_00 func_3B42())
	{
	}

	return var_00;
}

//Function Number: 62
getreversegraphnode()
{
	for(var_00 = self;!isdefined(var_00.var_3D93);var_00 = var_00 func_3BA6())
	{
	}

	return var_00;
}

//Function Number: 63
func_3B42()
{
	if(isdefined(self.target))
	{
		return getvehiclenode(self.target,"targetname");
	}

	return self.next;
}

//Function Number: 64
func_3BA6()
{
	return self.var_6154;
}

//Function Number: 65
func_4639(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_04 = spawnstruct();
		var_04.linkinfos = [];
		var_04.links = [];
		var_04.linklengths = [];
		var_04.linkdirs = [];
		var_04.linkstartnodes = [];
		var_04.node = var_03;
		var_04.origin = var_03.origin;
		var_04.var_3D93 = var_01.size;
		var_03.var_3D93 = var_01.size;
		debugprint3d(var_04.origin + (0,0,80),var_04.var_3D93,(1,1,1),0.65,2,100000);
		var_01[var_01.size] = var_04;
	}

	foreach(var_03 in param_00)
	{
		var_07 = var_03.var_3D93;
		var_08 = getvehiclenode(var_03.target,"targetname");
		var_09 = distance(var_03.origin,var_08.origin);
		var_0A = var_08;
		while(!isdefined(var_08.var_3D93))
		{
			var_09 = var_09 + distance(var_08.origin,var_08.var_6154.origin);
			if(isdefined(var_08.target))
			{
				var_08 = getvehiclenode(var_08.target,"targetname");
				continue;
			}

			var_08 = var_08.next;
		}

		var_01[var_07] addlinknode(var_01[var_08.var_3D93],var_09,"forward",var_0A);
		var_08 = var_03.var_6154;
		var_09 = distance(var_03.origin,var_08.origin);
		var_0A = var_08;
		while(!isdefined(var_08.var_3D93))
		{
			var_09 = var_09 + distance(var_08.origin,var_08.var_6154.origin);
			var_08 = var_08.var_6154;
		}

		var_01[var_07] addlinknode(var_01[var_08.var_3D93],var_09,"reverse",var_0A);
		foreach(var_0C in var_03.branchnodes)
		{
			var_08 = var_0C;
			var_09 = distance(var_03.origin,var_08.origin);
			var_0A = var_08;
			if(var_08.targetname == "branchnode")
			{
				while(!isdefined(var_08.var_3D93))
				{
					if(isdefined(var_08.target))
					{
						var_0D = getvehiclenode(var_08.target,"targetname");
					}
					else
					{
						var_0D = var_08.next;
					}

					var_09 = var_09 + distance(var_08.origin,var_0D.origin);
					var_08 = var_0D;
				}

				var_01[var_07] addlinknode(var_01[var_08.var_3D93],var_09,"forward",var_0A);
				continue;
			}

			while(!isdefined(var_08.var_3D93))
			{
				var_09 = var_09 + distance(var_08.origin,var_08.var_6154.origin);
				var_08 = var_08.var_6154;
			}

			var_01[var_07] addlinknode(var_01[var_08.var_3D93],var_09,"reverse",var_0A);
		}
	}

	return var_01;
}

//Function Number: 66
addlinknode(param_00,param_01,param_02,param_03)
{
	self.links[param_00.var_3D93] = param_00;
	self.linklengths[param_00.var_3D93] = param_01;
	self.linkdirs[param_00.var_3D93] = param_02;
	self.linkstartnodes[param_00.var_3D93] = param_03;
	var_04 = spawnstruct();
	var_04.tographnode = param_00;
	var_04.tographid = param_00.var_3D93;
	var_04.length = param_01;
	var_04.direction = param_02;
	var_04.startnode = param_03;
	self.linkinfos[param_00.var_3D93] = var_04;
}

//Function Number: 67
func_377F(param_00,param_01,param_02,param_03)
{
	level.openlist = [];
	level.closedlist = [];
	var_04 = 0;
	var_05 = [];
	if(!isdefined(param_02))
	{
		param_02 = [];
	}

	param_01.g = 0;
	param_01.h = gethvalue(param_01,param_00);
	param_01.f = param_01.g + param_01.h;
	addtoclosedlist(param_01);
	var_06 = param_01;
	for(;;)
	{
		foreach(var_08 in var_06.links)
		{
			if(func_4803(param_02,var_08))
			{
				continue;
			}

			if(func_4803(level.closedlist,var_08))
			{
				continue;
			}

			if(isdefined(param_03) && var_08.linkdirs[var_06.var_3D93] != param_03)
			{
				continue;
			}

			if(!func_4803(level.openlist,var_08))
			{
				addtoopenlist(var_08);
				var_08.parentnode = var_06;
				var_08.g = getgvalue(var_08,var_06);
				var_08.h = gethvalue(var_08,param_00);
				var_08.f = var_08.g + var_08.h;
				if(var_08 == param_00)
				{
					var_04 = 1;
				}

				continue;
			}

			if(var_08.g < getgvalue(var_06,var_08))
			{
				continue;
			}

			var_08.parentnode = var_06;
			var_08.g = getgvalue(var_08,var_06);
			var_08.f = var_08.g + var_08.h;
		}

		if(var_04)
		{
			break;
		}

		addtoclosedlist(var_06);
		var_0A = level.openlist[0];
		foreach(var_0C in level.openlist)
		{
			if(var_0C.f > var_0A.f)
			{
				continue;
			}

			var_0A = var_0C;
		}

		addtoclosedlist(var_0A);
		var_06 = var_0A;
	}

	var_06 = param_00;
	while(var_06 != param_01)
	{
		var_05[var_05.size] = var_06;
		var_06 = var_06.parentnode;
	}

	var_05[var_05.size] = var_06;
	return var_05;
}

//Function Number: 68
addtoopenlist(param_00)
{
	param_00.openlistid = level.openlist.size;
	level.openlist[level.openlist.size] = param_00;
	param_00.closedlistid = undefined;
}

//Function Number: 69
addtoclosedlist(param_00)
{
	if(isdefined(param_00.closedlistid))
	{
	}

	param_00.closedlistid = level.closedlist.size;
	level.closedlist[level.closedlist.size] = param_00;
	if(!func_4803(level.openlist,param_00))
	{
	}

	level.openlist[param_00.openlistid] = level.openlist[level.openlist.size - 1];
	level.openlist[param_00.openlistid].openlistid = param_00.openlistid;
	level.openlist[level.openlist.size - 1] = undefined;
	param_00.openlistid = undefined;
}

//Function Number: 70
gethvalue(param_00,param_01)
{
	return distance(param_00.node.origin,param_01.node.origin);
}

//Function Number: 71
getgvalue(param_00,param_01)
{
	return param_00.parentnode.g + param_00.linklengths[param_01.var_3D93];
}

//Function Number: 72
func_4803(param_00,param_01)
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

//Function Number: 73
drawpath(param_00)
{
	for(var_01 = 1;var_01 < param_00.size;var_01++)
	{
		var_02 = param_00[var_01 - 1];
		var_03 = param_00[var_01];
		if(var_02.linkdirs[var_03.var_3D93] == "reverse")
		{
			level thread func_2A7F(var_02.node.origin,var_03.node.origin,(1,0,0));
		}
		else
		{
			level thread func_2A7F(var_02.node.origin,var_03.node.origin,(0,1,0));
		}

		var_04 = var_02.linkstartnodes[var_03.var_3D93];
		level thread func_2A7F(var_02.node.origin + (0,0,4),var_04.origin + (0,0,4),(0,0,1));
		if(var_02.linkdirs[var_03.var_3D93] == "reverse")
		{
			while(!isdefined(var_04.var_3D93))
			{
				var_05 = var_04;
				var_04 = var_04.var_6154;
				level thread func_2A7F(var_05.origin + (0,0,4),var_04.origin + (0,0,4),(0,1,1));
			}

			continue;
		}

		while(!isdefined(var_04.var_3D93))
		{
			var_05 = var_04;
			if(isdefined(var_04.target))
			{
				var_04 = getvehiclenode(var_04.target,"targetname");
				continue;
			}

			var_04 = var_04.next;
			level thread func_2A7F(var_05.origin + (0,0,4),var_04.origin + (0,0,4),(0,1,1));
		}
	}
}

//Function Number: 74
drawgraph(param_00)
{
}

//Function Number: 75
func_2A7F(param_00,param_01,param_02)
{
	level endon("endpath");
	wait(0.05);
}

//Function Number: 76
debugprintln2(param_00)
{
}

//Function Number: 77
func_2429(param_00)
{
}

//Function Number: 78
debugprint3d(param_00,param_01,param_02,param_03,param_04,param_05)
{
}

//Function Number: 79
func_2A8E()
{
}