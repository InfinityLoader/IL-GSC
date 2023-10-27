/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_tank.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 78
 * Decompile Time: 3709 ms
 * Timestamp: 10/27/2023 12:29:45 AM
*******************************************************************/

//Function Number: 1
init()
{
}

//Function Number: 2
func_1082D(param_00,param_01,param_02)
{
	var_03 = self method_83DA("tank",param_00);
	var_03.health = 3000;
	var_03.var_11568 = 1;
	var_03.team = param_00.team;
	var_03.pers["team"] = var_03.team;
	var_03.var_222 = param_00;
	var_03 setcandamage(1);
	var_03.var_10B68 = 12;
	var_03 thread func_51CB();
	var_03 func_185E();
	var_03.var_4D2E = ::func_3758;
	return var_03;
}

//Function Number: 3
func_51CB()
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

		wait(1);
	}
}

//Function Number: 4
func_130E4(param_00)
{
	return func_12907();
}

//Function Number: 5
func_12907()
{
	if(isdefined(level.var_114E2) && level.var_114E2)
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
		var_00 = level.var_114E5["allies"] func_1082D(self,"vehicle_bradley");
	}
	else
	{
		var_00 = level.var_114E5["axis"] func_1082D(self,"vehicle_bmp");
	}

	var_00 func_10DF8();
	return 1;
}

//Function Number: 6
func_10DF8(param_00)
{
	var_01 = getvehiclenode("startnode","targetname");
	var_02 = getvehiclenode("waitnode","targetname");
	self.var_C053 = getvehiclenodearray("info_vehicle_node","classname");
	level.var_114E2 = 1;
	thread func_114E9(var_01,var_02);
	thread func_114D9();
	level.var_114B1 = self;
	if(level.teambased)
	{
		var_03 = scripts\mp\objidpoolmanager::requestminimapid(1);
		if(var_03 != -1)
		{
			scripts\mp\objidpoolmanager::minimap_objective_add(var_03,"invisible",(0,0,0));
			scripts\mp\objidpoolmanager::minimap_objective_team(var_03,"allies");
		}

		level.var_114B1.var_C2B5["allies"] = var_03;
		var_04 = scripts\mp\objidpoolmanager::requestminimapid(1);
		if(var_04 != -1)
		{
			scripts\mp\objidpoolmanager::minimap_objective_add(var_04,"invisible",(0,0,0));
			scripts\mp\objidpoolmanager::minimap_objective_team(var_04,"axis");
		}

		level.var_114B1.var_C2B5["axis"] = var_04;
		var_05 = self.team;
		level.var_114B1.team = var_05;
		level.var_114B1.pers["team"] = var_05;
	}

	var_06 = spawnturret("misc_turret",self.origin,"abrams_minigun_mp");
	var_06 linkto(self,"tag_engine_left",(0,0,-20),(0,0,0));
	var_06 setmodel("sentry_minigun");
	var_06.angles = self.angles;
	var_06.var_222 = self.var_222;
	var_06 method_81F5();
	self.var_B6BD = var_06;
	self.var_B6BD method_82D1(0);
	var_07 = self.angles;
	self.angles = (0,0,0);
	var_08 = self gettagorigin("tag_flash");
	self.angles = var_07;
	var_09 = var_08 - self.origin;
	thread func_136B0();
	thread func_136B8();
	self.var_118F3 = gettime();
	var_0A = spawn("script_origin",self gettagorigin("tag_flash"));
	var_0A linkto(self,"tag_origin",var_09,(0,0,0));
	var_0A hide();
	self.var_BEF5 = var_0A;
	thread func_114E1();
	thread func_5329();
	thread func_114DF();
	thread func_3E02();
	thread func_13A78();
}

//Function Number: 7
func_136B0()
{
	self endon("death");
	self.var_222 endon("disconnect");
	self.var_222 waittill("joined_team");
	self.health = 0;
	self notify("death");
}

//Function Number: 8
func_136B8()
{
	self endon("death");
	self.var_222 waittill("disconnect");
	self.health = 0;
	self notify("death");
}

//Function Number: 9
func_F6C4(param_00)
{
	if(self.var_376 != param_00)
	{
		if(param_00 == "forward")
		{
			func_11096();
			return;
		}

		func_11097();
	}
}

//Function Number: 10
func_F6E3()
{
	self endon("death");
	self notify("path_abandoned");
	while(isdefined(self.var_3C61))
	{
		wait(0.05);
	}

	var_00 = 2;
	self method_83E5(var_00,10,10);
	self.var_109C6 = "engage";
}

//Function Number: 11
func_F799()
{
	self endon("death");
	self notify("path_abandoned");
	while(isdefined(self.var_3C61))
	{
		wait(0.05);
	}

	var_00 = 2;
	self method_83E5(var_00,10,10);
	self.var_109C6 = "engage";
}

//Function Number: 12
func_F85D()
{
	self endon("death");
	while(isdefined(self.var_3C61))
	{
		wait(0.05);
	}

	self method_83E5(self.var_10B68,10,10);
	self.var_109C6 = "standard";
}

//Function Number: 13
func_F6ED()
{
	self endon("death");
	while(isdefined(self.var_3C61))
	{
		wait(0.05);
	}

	self method_83E5(15,15,15);
	self.var_109C6 = "evade";
	wait(1.5);
	self method_83E5(self.var_10B68,10,10);
}

//Function Number: 14
func_F6B0()
{
	self endon("death");
	while(isdefined(self.var_3C61))
	{
		wait(0.05);
	}

	self method_83E5(5,5,5);
	self.var_109C6 = "danger";
}

//Function Number: 15
func_11097()
{
	func_4F52("tank changing direction at " + gettime());
	self method_83E5(0,5,6);
	self.var_3C61 = 1;
	while(self.var_37A > 0)
	{
		wait(0.05);
	}

	wait(0.25);
	self.var_3C61 = undefined;
	func_4F52("tank done changing direction");
	self.var_37D = "reverse";
	self.var_376 = "reverse";
	self method_83E5(self.var_10B68,5,6);
}

//Function Number: 16
func_11096()
{
	func_4F52("tank changing direction at " + gettime());
	self method_83E5(0,5,6);
	self.var_3C61 = 1;
	while(self.var_37A > 0)
	{
		wait(0.05);
	}

	wait(0.25);
	self.var_3C61 = undefined;
	func_4F52("tank done changing direction");
	self.var_37D = "forward";
	self.var_376 = "forward";
	self method_83E5(self.var_10B68,5,6);
}

//Function Number: 17
func_3E02()
{
	self endon("death");
	var_00 = [];
	var_01 = level.players;
	self.var_C225 = 0;
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
				self.var_C225++;
			}

			wait(0.05);
		}

		if(isdefined(self.var_109C6) && self.var_109C6 == "evade" || self.var_109C6 == "engage")
		{
			self.var_C225 = 0;
			continue;
		}

		if(self.var_C225 > 1)
		{
			thread func_F6B0();
		}
		else
		{
			thread func_F85D();
		}

		self.var_C225 = 0;
		wait(0.05);
	}
}

//Function Number: 18
func_114E9(param_00,param_01)
{
	self endon("tankDestroyed");
	self endon("death");
	if(!isdefined(level.var_848E))
	{
		self startpath(param_00);
		return;
	}

	self attachpath(param_00);
	self startpath(param_00);
	param_00 notify("trigger",self,1);
	wait(0.05);
	for(;;)
	{
		while(isdefined(self.var_3C61))
		{
			wait(0.05);
		}

		var_02 = func_7FFB();
		if(isdefined(var_02))
		{
			self.var_6366 = var_02;
		}
		else
		{
			self.var_6366 = undefined;
		}

		wait(0.65);
	}
}

//Function Number: 19
func_3758(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if((param_01 == self || param_01 == self.var_B6BD || isdefined(param_01.pers) && param_01.pers["team"] == self.team) && param_01 != self.var_222 || param_04 == "MOD_MELEE")
	{
		return;
	}

	var_0C = func_B938(param_04,param_02,param_01);
	self method_83DB(param_00,param_01,var_0C,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 20
func_114D9()
{
	self endon("death");
	self.var_E1 = 0;
	var_00 = self method_83DD();
	var_01 = self.health;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	for(;;)
	{
		self waittill("damage",var_05,var_06,var_07,var_08,var_09);
		if(isdefined(var_06.classname) && var_06.classname == "script_vehicle")
		{
			if(isdefined(self.var_2A9A) && self.var_2A9A != var_06)
			{
				self.var_72B8 = var_06;
				thread func_698D();
			}
		}
		else if(isplayer(var_06))
		{
			var_06 scripts\mp\_damagefeedback::func_12E84("hitHelicopter");
			if(var_06 scripts\mp\_utility::_hasperk("specialty_armorpiercing"))
			{
				var_0A = var_05 * level.var_218B;
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
			func_89F2(var_06);
		}
	}
}

//Function Number: 21
func_89F2(param_00)
{
	self endon("death");
	var_01 = randomint(100);
	if(isdefined(self.var_2A9A) && self.var_2A9A != param_00 && var_01 > 30)
	{
		var_02 = [];
		var_02[0] = self.var_2A9A;
		func_698D(1,self.var_2A9A);
		thread func_1572(var_02);
		return;
	}

	if(!isdefined(self.var_2A9A) && var_01 > 30)
	{
		var_02 = [];
		var_02[0] = param_00;
		thread func_1572(var_02);
		return;
	}

	if(var_01 < 30)
	{
		playfx(level.var_114D8,self.origin);
		thread func_F6ED();
		return;
	}

	self method_80EB();
	self playsound("bmp_fire");
}

//Function Number: 22
func_89D4(param_00)
{
	self endon("death");
	var_01 = func_DF30(param_00);
	var_02 = distance(self.origin,param_00.origin);
	if(randomint(4) < 3)
	{
		return;
	}

	if(var_01 == "front" && var_02 < 768)
	{
		thread func_F6ED();
		return;
	}

	if(var_01 == "rear_side" || var_01 == "rear" && var_02 >= 768)
	{
		playfx(level.var_114D8,self.origin);
		thread func_F6ED();
		return;
	}

	if(var_01 == "rear" && var_02 < 768)
	{
		func_11097();
		func_F6ED();
		wait(4);
		func_11096();
		return;
	}

	if(var_01 == "front_side" || var_01 == "front")
	{
		playfx(level.var_114D8,self.origin);
		func_11097();
		func_F6ED();
		wait(8);
		func_11096();
		return;
	}
}

//Function Number: 23
func_DF30(param_00)
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
func_13A78()
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

			if(!func_9F97(var_03))
			{
				wait(0.05);
				continue;
			}

			var_04 = var_03 getcurrentweapon();
			if(issubstr(var_04,"at4") || issubstr(var_04,"stinger") || issubstr(var_04,"javelin"))
			{
				thread func_89D4(var_03);
				wait(8);
			}

			wait(0.15);
		}
	}
}

//Function Number: 25
func_3E2E()
{
	if(!isdefined(self.var_222) || !isdefined(self.var_222.pers["team"]) || self.var_222.pers["team"] != self.team)
	{
		self notify("abandoned");
		return 0;
	}

	return 1;
}

//Function Number: 26
func_B938(param_00,param_01,param_02)
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
func_5329()
{
	self waittill("death");
	if(level.teambased)
	{
		var_00 = level.var_114B1.team;
		if(level.var_114B1.var_C2B5[var_00] != -1)
		{
			scripts\mp\objidpoolmanager::minimap_objective_state(level.var_114B1.var_C2B5[var_00],"invisible");
		}

		if(level.var_114B1.var_C2B5[level.var_C74B[var_00]] != -1)
		{
			scripts\mp\objidpoolmanager::minimap_objective_state(level.var_114B1.var_C2B5[level.var_C74B[var_00]],"invisible");
		}
	}

	self notify("tankDestroyed");
	self method_83E5(0,10,10);
	level.var_114E2 = 0;
	playfx(level.var_10888,self.origin);
	playfx(level.var_114DD,self.origin);
	func_E11C();
	var_01 = spawn("script_model",self.origin);
	var_01 setmodel("vehicle_m1a1_abrams_d_static");
	var_01.angles = self.angles;
	self.var_B6BD delete();
	self delete();
	wait(4);
	var_01 delete();
}

//Function Number: 28
func_C53C()
{
	self notify("onTargOrTimeOut");
	self endon("onTargOrTimeOut");
	self endon("turret_on_target");
	self waittill("turret_pitch_clamped");
	thread func_698D(0,self.var_2A9A);
}

//Function Number: 29
func_6D7A()
{
	self endon("abandonedTarget");
	self endon("killedTarget");
	self endon("death");
	self endon("targetRemoved");
	self endon("lostLOS");
	for(;;)
	{
		func_C53C();
		if(!isdefined(self.var_2A9A))
		{
			continue;
		}

		var_00 = self gettagorigin("tag_flash");
		var_01 = bullettrace(self.origin,var_00,0,self);
		if(var_01["position"] != var_00)
		{
			thread func_698D(0,self.var_2A9A);
		}

		var_01 = bullettrace(var_00,self.var_2A9A.origin,1,self);
		var_02 = distance(self.origin,var_01["position"]);
		var_03 = distance(self.var_2A9A.origin,self.origin);
		if(var_02 < 384 || var_02 + 256 < var_03)
		{
			wait(0.5);
			if(var_02 > 384)
			{
				func_136F4();
				self method_80EB();
				self playsound("bmp_fire");
				self.var_118F3 = gettime();
			}

			var_04 = func_DF30(self.var_2A9A);
			thread func_698D(0,self.var_2A9A);
			return;
		}

		func_136F4();
		self method_80EB();
		self playsound("bmp_fire");
		self.var_118F3 = gettime();
	}
}

//Function Number: 30
func_136F4()
{
	self endon("abandonedTarget");
	self endon("killedTarget");
	self endon("death");
	self endon("targetRemoved");
	self endon("lostLOS");
	var_00 = gettime() - self.var_118F3;
	if(var_00 < 1499)
	{
		wait(1.5 - var_00 / 1000);
	}
}

//Function Number: 31
func_114E1(param_00)
{
	self endon("death");
	self endon("leaving");
	var_01 = [];
	for(;;)
	{
		var_01 = [];
		var_02 = level.players;
		if(isdefined(self.var_72B8))
		{
			var_01 = [];
			var_01[0] = self.var_72B8;
			func_1572(var_01);
			self.var_72B8 = undefined;
		}

		if(isdefined(level.var_8B55) && level.var_8B55.team != self.team && isalive(level.var_8B55))
		{
			if(func_9FF1(level.var_114B1))
			{
				var_01[var_01.size] = level.var_114B1;
			}
		}

		if(isdefined(level.var_3F14) && level.var_3F14.team != self.team && isalive(level.var_3F14))
		{
			if(func_9FF1(level.var_3F14))
			{
				var_01[var_01.size] = level.var_3F14;
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

			if(func_9F97(var_04))
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
			func_1572(var_01);
			continue;
		}

		wait(1);
	}
}

//Function Number: 32
func_1572(param_00)
{
	self endon("death");
	if(param_00.size == 1)
	{
		self.var_2A9A = param_00[0];
	}
	else
	{
		self.var_2A9A = func_7E05(param_00);
	}

	thread func_F6E3();
	thread func_13B74(param_00);
	self method_835C(self.var_2A9A);
	func_6D7A();
	thread func_F7B8();
}

//Function Number: 33
func_F7B8()
{
	self endon("death");
	func_F85D();
	func_E17A();
	self method_835C(self.var_BEF5);
}

//Function Number: 34
func_7E05(param_00)
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
		if(isdefined(level.var_3F14) && var_07 == level.var_3F14)
		{
			return var_07;
		}

		if(isdefined(level.var_8B55) && var_07 == level.var_8B55)
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
func_13B74(param_00)
{
	self endon("abandonedTarget");
	self endon("lostLOS");
	self endon("death");
	self endon("targetRemoved");
	var_01 = self.var_2A9A;
	var_01 endon("disconnect");
	var_01 waittill("death");
	self notify("killedTarget");
	func_E17A();
	func_F85D();
	thread func_F7B8();
}

//Function Number: 36
func_698D(param_00,param_01)
{
	self endon("death");
	self notify("abandonedTarget");
	func_F85D();
	thread func_F7B8();
	func_E17A();
	if(isdefined(param_01))
	{
		self.var_275E = param_01;
		func_275F();
	}

	if(isdefined(param_00) && param_00)
	{
	}
}

//Function Number: 37
func_275F()
{
	self endon("death");
	wait(1.5);
	self.var_275E = undefined;
}

//Function Number: 38
func_E17A()
{
	self notify("targetRemoved");
	self.var_2A9A = undefined;
	self.var_A9AF = undefined;
}

//Function Number: 39
func_9FF1(param_00)
{
	if(distance2d(param_00.origin,self.origin) > 4096)
	{
		return 0;
	}

	if(distance(param_00.origin,self.origin) < 512)
	{
		return 0;
	}

	return func_12A8F(param_00,0);
}

//Function Number: 40
func_9F97(param_00)
{
	self endon("death");
	var_01 = distancesquared(param_00.origin,self.origin);
	if(!level.teambased && isdefined(self.var_222) && param_00 == self.var_222)
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

	if(param_00 == self.var_222)
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

	if(isdefined(param_00.var_10916) && gettime() - param_00.var_10916 / 1000 <= 5)
	{
		return 0;
	}

	if(param_00 scripts\mp\_utility::_hasperk("specialty_blindeye"))
	{
		return 0;
	}

	return self method_83D9(param_00.origin,1,self);
}

//Function Number: 41
func_12A8F(param_00,param_01)
{
	var_02 = param_00 method_838A(self gettagorigin("tag_turret"),self);
	if(var_02 < 0.7)
	{
		return 0;
	}

	if(isdefined(param_01) && param_01)
	{
		thread scripts\mp\_utility::drawline(param_00.origin,self gettagorigin("tag_turret"),10,(1,0,0));
	}

	return 1;
}

//Function Number: 42
func_9EA1(param_00)
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

	if(param_00 == self.var_222)
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

	if(isdefined(param_00.var_10916) && gettime() - param_00.var_10916 / 1000 <= 5)
	{
		return 0;
	}

	if(isdefined(self))
	{
		var_01 = self.var_B6BD.origin + (0,0,64);
		var_02 = param_00 method_838A(var_01,self);
		if(var_02 < 1)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 43
func_114DF()
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
			if(func_9EA1(var_01[var_02]))
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
			func_1571(var_00);
			return;
		}
		else
		{
			wait(0.5);
		}
	}
}

//Function Number: 44
func_7DFD(param_00)
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
func_1571(param_00)
{
	self endon("death");
	if(param_00.size == 1)
	{
		self.var_2A97 = param_00[0];
	}
	else
	{
		self.var_2A97 = func_7DFD(param_00);
	}

	if(distance2d(self.origin,self.var_2A97.origin) > 768)
	{
		thread func_F799();
	}

	self notify("acquiringMiniTarget");
	self.var_B6BD method_8347(self.var_2A97,(0,0,64));
	wait(0.15);
	thread func_6D74();
	thread func_13AD1(param_00);
	thread func_13AD2(param_00);
	thread func_13AD3(self.var_2A97);
}

//Function Number: 46
func_6D74()
{
	self endon("death");
	self endon("abandonedMiniTarget");
	self endon("killedMiniTarget");
	var_00 = undefined;
	var_01 = gettime();
	if(!isdefined(self.var_2A97))
	{
		return;
	}

	for(;;)
	{
		if(!isdefined(self.var_B6BD method_8166(1)))
		{
			if(!isdefined(var_00))
			{
				var_00 = gettime();
			}

			var_02 = gettime();
			if(var_00 - var_02 > 1)
			{
				var_00 = undefined;
				thread func_698C();
				return;
			}

			wait(0.5);
			continue;
		}

		if(gettime() > var_01 + 1000 && !isdefined(self.var_2A9A))
		{
			if(distance2d(self.origin,self.var_2A97.origin) > 768)
			{
				var_01[0] = self.var_2A97;
				func_1572(var_05);
			}
		}

		var_04 = randomintrange(10,16);
		for(var_05 = 0;var_05 < var_04;var_05++)
		{
			self.var_B6BD method_837E();
			wait(0.1);
		}

		wait(randomfloatrange(0.5,3));
	}
}

//Function Number: 47
func_13AD1(param_00)
{
	self endon("abandonedMiniTarget");
	self endon("death");
	if(!isdefined(self.var_2A97))
	{
		return;
	}

	self.var_2A97 waittill("death");
	self notify("killedMiniTarget");
	self.var_2A97 = undefined;
	self.var_B6BD method_807E();
	func_114DF();
}

//Function Number: 48
func_13AD2(param_00)
{
	self endon("abandonedMiniTarget");
	self endon("death");
	for(;;)
	{
		if(!isdefined(self.var_2A97))
		{
			return;
		}

		var_01 = bullettrace(self.var_B6BD.origin,self.var_2A97.origin,0,self);
		var_02 = distance(self.origin,var_01["position"]);
		if(var_02 > 1024)
		{
			thread func_698C();
			return;
		}

		wait(2);
	}
}

//Function Number: 49
func_13AD3(param_00)
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
			if(func_9EA1(var_02[var_03]))
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
					thread func_698C();
					return;
				}
			}

			wait(0.05);
		}

		wait(0.25);
	}
}

//Function Number: 50
func_698C(param_00)
{
	self notify("abandonedMiniTarget");
	self.var_2A97 = undefined;
	self.var_B6BD method_807E();
	if(isdefined(param_00) && param_00)
	{
		return;
	}

	thread func_114DF();
}

//Function Number: 51
func_185E()
{
	level.var_114E3[self getentitynumber()] = self;
}

//Function Number: 52
func_E11C()
{
	level.var_114E3[self getentitynumber()] = undefined;
}

//Function Number: 53
func_7FFB()
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

		var_02.var_56E8 = 0;
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
			var_00[var_04].var_56E8 = var_00[var_04].var_56E8 + var_06;
			var_00[var_05].var_56E8 = var_00[var_05].var_56E8 + var_06;
		}
	}

	var_07 = var_00[0];
	foreach(var_02 in var_00)
	{
		if(var_02.var_56E8 < var_07.var_56E8)
		{
			var_07 = var_02;
		}
	}

	var_0A = var_07.origin;
	var_0B = sortbydistance(level.var_848E,var_0A);
	return var_0B[0];
}

//Function Number: 54
func_FAD8()
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
		var_04.var_D886 = var_05;
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

	var_00[0].var_2F45 = [];
	var_00[0] thread func_897F("forward");
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
			var_04.var_D886 = var_05;
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

			if(var_0D.target == var_04.var_336)
			{
				continue;
			}

			if(isdefined(var_04.target) && var_04.target == var_0D.var_336)
			{
				continue;
			}

			if(distance2d(var_04.origin,var_0D.origin) > 80)
			{
				continue;
			}

			var_0D thread func_8982(var_04,"reverse");
			var_0D.var_D886 = var_04;
			if(!isdefined(var_04.var_2F45))
			{
				var_04.var_2F45 = [];
			}

			var_04.var_2F45[var_04.var_2F45.size] = var_0D;
			var_0B = 1;
		}

		if(var_0B)
		{
			var_04 thread func_897F("forward");
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

			if(var_04.target == var_11.var_336)
			{
				continue;
			}

			if(isdefined(var_11.target) && var_11.target == var_04.var_336)
			{
				continue;
			}

			if(distance2d(var_04.origin,var_11.origin) > 80)
			{
				continue;
			}

			var_11 thread func_8982(var_04,"forward");
			var_11.var_BF2E = getvehiclenode(var_04.var_336,"targetname");
			var_11.var_AB5D = distance(var_11.origin,var_04.origin);
			if(!isdefined(var_04.var_2F45))
			{
				var_04.var_2F45 = [];
			}

			var_04.var_2F45[var_04.var_2F45.size] = var_11;
			var_0F = 1;
		}

		if(var_0F)
		{
			var_04 thread func_897F("reverse");
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
		if(!isdefined(var_04.var_2F45))
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

			if(isdefined(var_04.var_2F45))
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

				var_04.var_2F45 = [];
				var_04 thread func_897F("forward");
				var_03[var_03.size] = var_04;
				break;
			}
		}
	}

	level.var_848E = func_98A6(var_03);
	foreach(var_04 in var_00)
	{
		if(!isdefined(var_04.var_848D))
		{
			var_04 thread func_C059();
		}
	}
}

//Function Number: 55
func_80B4(param_00)
{
	var_01 = [];
	foreach(var_04, var_03 in self.var_AD40)
	{
		if(self.var_AD17[var_04] != param_00)
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01[randomint(var_01.size)];
}

//Function Number: 56
func_7FE9(param_00,param_01)
{
	var_02 = level.var_848E[self.var_848D];
	var_03 = func_7732(var_02,param_00,undefined,param_01);
	var_04 = var_03[0].var_7646;
	var_05 = func_7732(var_02,param_00,undefined,level.var_C74A[param_01]);
	var_06 = var_05[0].var_7646;
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
func_897F(param_00)
{
	level endon("end_tankPathHandling");
	for(;;)
	{
		self waittill("trigger",var_01,var_02);
		var_03 = level.var_848E[self.var_848D];
		var_01.var_205 = self;
		var_04 = undefined;
		if(isdefined(var_01.var_6366) && var_01.var_6366 != var_03)
		{
			var_04 = func_7FE9(var_01.var_6366,var_01.var_376);
			if(!isdefined(var_04))
			{
				var_01 thread func_F6C4(level.var_C74A[var_01.var_376]);
			}
		}

		if(!isdefined(var_04) || var_04 == var_03)
		{
			var_04 = var_03 func_80B4(var_01.var_376);
		}

		var_05 = var_03.var_AD41[var_04.var_848D];
		if(var_01.var_376 == "forward")
		{
			var_06 = func_7FE8();
		}
		else
		{
			var_06 = func_809A();
		}

		if(var_06 != var_05)
		{
			var_01 startpath(var_05);
		}
	}
}

//Function Number: 58
func_8982(param_00,param_01)
{
	for(;;)
	{
		self waittill("trigger",var_02);
		if(var_02.var_376 != param_01)
		{
			continue;
		}

		func_4F52("tank starting path at join node: " + param_00.var_848D);
		var_02 startpath(param_00);
	}
}

//Function Number: 59
func_C059()
{
	self.var_7334 = func_7EC4().var_848D;
	self.var_E492 = func_80EF().var_848D;
	for(;;)
	{
		self waittill("trigger",var_00,var_01);
		var_00.var_205 = self;
		var_00.var_7334 = self.var_7334;
		var_00.var_E492 = self.var_E492;
		if(!isdefined(self.target) || self.var_336 == "branchnode")
		{
			var_02 = "TRANS";
		}
		else
		{
			var_02 = "NODE";
		}

		if(isdefined(var_01))
		{
			func_4F50(self.origin,var_02,(1,0.5,0),1,2,100);
			continue;
		}

		func_4F50(self.origin,var_02,(0,1,0),1,2,100);
	}
}

//Function Number: 60
func_72EA(param_00,param_01,param_02)
{
	param_01 endon("trigger");
	param_00 endon("trigger");
	param_02 endon("death");
	var_03 = distancesquared(param_02.origin,param_01.origin);
	var_04 = param_02.var_376;
	func_4F50(param_00.origin + (0,0,30),"LAST",(0,0,1),0.5,1,100);
	func_4F50(param_01.origin + (0,0,60),"NEXT",(0,1,0),0.5,1,100);
	var_05 = 0;
	for(;;)
	{
		wait(0.05);
		if(var_04 != param_02.var_376)
		{
			func_4F52("tank missed node: reversing direction");
			param_02 thread func_72EA(param_01,param_00,param_02);
			return;
		}

		if(var_05)
		{
			func_4F52("... sending notify.");
			param_01 notify("trigger",param_02,1);
			return;
		}

		var_06 = distancesquared(param_02.origin,param_01.origin);
		if(var_06 > var_03)
		{
			var_05 = 1;
			func_4F52("tank missed node: forcing notify in one frame...");
		}

		var_03 = var_06;
	}
}

//Function Number: 61
func_7EC4()
{
	for(var_00 = self;!isdefined(var_00.var_848D);var_00 = var_00 func_7FE8())
	{
	}

	return var_00;
}

//Function Number: 62
func_80EF()
{
	for(var_00 = self;!isdefined(var_00.var_848D);var_00 = var_00 func_809A())
	{
	}

	return var_00;
}

//Function Number: 63
func_7FE8()
{
	if(isdefined(self.target))
	{
		return getvehiclenode(self.target,"targetname");
	}

	return self.var_BF2E;
}

//Function Number: 64
func_809A()
{
	return self.var_D886;
}

//Function Number: 65
func_98A6(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_04 = spawnstruct();
		var_04.var_AD35 = [];
		var_04.var_AD40 = [];
		var_04.var_AD36 = [];
		var_04.var_AD17 = [];
		var_04.var_AD41 = [];
		var_04.var_205 = var_03;
		var_04.origin = var_03.origin;
		var_04.var_848D = var_01.size;
		var_03.var_848D = var_01.size;
		func_4F50(var_04.origin + (0,0,80),var_04.var_848D,(1,1,1),0.65,2,100000);
		var_01[var_01.size] = var_04;
	}

	foreach(var_03 in param_00)
	{
		var_07 = var_03.var_848D;
		var_08 = getvehiclenode(var_03.target,"targetname");
		var_09 = distance(var_03.origin,var_08.origin);
		var_0A = var_08;
		while(!isdefined(var_08.var_848D))
		{
			var_09 = var_09 + distance(var_08.origin,var_08.var_D886.origin);
			if(isdefined(var_08.target))
			{
				var_08 = getvehiclenode(var_08.target,"targetname");
				continue;
			}

			var_08 = var_08.var_BF2E;
		}

		var_01[var_07] func_17EC(var_01[var_08.var_848D],var_09,"forward",var_0A);
		var_08 = var_03.var_D886;
		var_09 = distance(var_03.origin,var_08.origin);
		var_0A = var_08;
		while(!isdefined(var_08.var_848D))
		{
			var_09 = var_09 + distance(var_08.origin,var_08.var_D886.origin);
			var_08 = var_08.var_D886;
		}

		var_01[var_07] func_17EC(var_01[var_08.var_848D],var_09,"reverse",var_0A);
		foreach(var_0C in var_03.var_2F45)
		{
			var_08 = var_0C;
			var_09 = distance(var_03.origin,var_08.origin);
			var_0A = var_08;
			if(var_08.var_336 == "branchnode")
			{
				while(!isdefined(var_08.var_848D))
				{
					if(isdefined(var_08.target))
					{
						var_0D = getvehiclenode(var_08.target,"targetname");
					}
					else
					{
						var_0D = var_08.var_BF2E;
					}

					var_09 = var_09 + distance(var_08.origin,var_0D.origin);
					var_08 = var_0D;
				}

				var_01[var_07] func_17EC(var_01[var_08.var_848D],var_09,"forward",var_0A);
				continue;
			}

			while(!isdefined(var_08.var_848D))
			{
				var_09 = var_09 + distance(var_08.origin,var_08.var_D886.origin);
				var_08 = var_08.var_D886;
			}

			var_01[var_07] func_17EC(var_01[var_08.var_848D],var_09,"reverse",var_0A);
		}
	}

	return var_01;
}

//Function Number: 66
func_17EC(param_00,param_01,param_02,param_03)
{
	self.var_AD40[param_00.var_848D] = param_00;
	self.var_AD36[param_00.var_848D] = param_01;
	self.var_AD17[param_00.var_848D] = param_02;
	self.var_AD41[param_00.var_848D] = param_03;
	var_04 = spawnstruct();
	var_04.var_119D3 = param_00;
	var_04.var_119D2 = param_00.var_848D;
	var_04.var_AB5D = param_01;
	var_04.var_F2 = param_02;
	var_04.var_10DCD = param_03;
	self.var_AD35[param_00.var_848D] = var_04;
}

//Function Number: 67
func_7732(param_00,param_01,param_02,param_03)
{
	level.var_C62D = [];
	level.var_428F = [];
	var_04 = 0;
	var_05 = [];
	if(!isdefined(param_02))
	{
		param_02 = [];
	}

	param_01.var_7646 = 0;
	param_01.var_877B = func_7F0A(param_01,param_00);
	param_01.var_6A62 = param_01.var_7646 + param_01.var_877B;
	func_184C(param_01);
	var_06 = param_01;
	for(;;)
	{
		foreach(var_08 in var_06.var_AD40)
		{
			if(scripts\common\utility::func_2286(param_02,var_08))
			{
				continue;
			}

			if(scripts\common\utility::func_2286(level.var_428F,var_08))
			{
				continue;
			}

			if(isdefined(param_03) && var_08.var_AD17[var_06.var_848D] != param_03)
			{
				continue;
			}

			if(!scripts\common\utility::func_2286(level.var_C62D,var_08))
			{
				func_1854(var_08);
				var_08.var_C8F6 = var_06;
				var_08.var_7646 = func_7EED(var_08,var_06);
				var_08.var_877B = func_7F0A(var_08,param_00);
				var_08.var_6A62 = var_08.var_7646 + var_08.var_877B;
				if(var_08 == param_00)
				{
					var_04 = 1;
				}

				continue;
			}

			if(var_08.var_7646 < func_7EED(var_06,var_08))
			{
				continue;
			}

			var_08.var_C8F6 = var_06;
			var_08.var_7646 = func_7EED(var_08,var_06);
			var_08.var_6A62 = var_08.var_7646 + var_08.var_877B;
		}

		if(var_04)
		{
			break;
		}

		func_184C(var_06);
		var_0A = level.var_C62D[0];
		foreach(var_0C in level.var_C62D)
		{
			if(var_0C.var_6A62 > var_0A.var_6A62)
			{
				continue;
			}

			var_0A = var_0C;
		}

		func_184C(var_0A);
		var_06 = var_0A;
	}

	var_06 = param_00;
	while(var_06 != param_01)
	{
		var_05[var_05.size] = var_06;
		var_06 = var_06.var_C8F6;
	}

	var_05[var_05.size] = var_06;
	return var_05;
}

//Function Number: 68
func_1854(param_00)
{
	param_00.var_C62E = level.var_C62D.size;
	level.var_C62D[level.var_C62D.size] = param_00;
	param_00.var_4290 = undefined;
}

//Function Number: 69
func_184C(param_00)
{
	if(isdefined(param_00.var_4290))
	{
		return;
	}

	param_00.var_4290 = level.var_428F.size;
	level.var_428F[level.var_428F.size] = param_00;
	if(!scripts\common\utility::func_2286(level.var_C62D,param_00))
	{
		return;
	}

	level.var_C62D[param_00.var_C62E] = level.var_C62D[level.var_C62D.size - 1];
	level.var_C62D[param_00.var_C62E].var_C62E = param_00.var_C62E;
	level.var_C62D[level.var_C62D.size - 1] = undefined;
	param_00.var_C62E = undefined;
}

//Function Number: 70
func_7F0A(param_00,param_01)
{
	return distance(param_00.var_205.origin,param_01.var_205.origin);
}

//Function Number: 71
func_7EED(param_00,param_01)
{
	return param_00.var_C8F6.var_7646 + param_00.var_AD36[param_01.var_848D];
}

//Function Number: 72
func_5B83(param_00)
{
	for(var_01 = 1;var_01 < param_00.size;var_01++)
	{
		var_02 = param_00[var_01 - 1];
		var_03 = param_00[var_01];
		if(var_02.var_AD17[var_03.var_848D] == "reverse")
		{
			level thread func_5B7C(var_02.var_205.origin,var_03.var_205.origin,(1,0,0));
		}
		else
		{
			level thread func_5B7C(var_02.var_205.origin,var_03.var_205.origin,(0,1,0));
		}

		var_04 = var_02.var_AD41[var_03.var_848D];
		level thread func_5B7C(var_02.var_205.origin + (0,0,4),var_04.origin + (0,0,4),(0,0,1));
		if(var_02.var_AD17[var_03.var_848D] == "reverse")
		{
			while(!isdefined(var_04.var_848D))
			{
				var_05 = var_04;
				var_04 = var_04.var_D886;
				level thread func_5B7C(var_05.origin + (0,0,4),var_04.origin + (0,0,4),(0,1,1));
			}

			continue;
		}

		while(!isdefined(var_04.var_848D))
		{
			var_05 = var_04;
			if(isdefined(var_04.target))
			{
				var_04 = getvehiclenode(var_04.target,"targetname");
				continue;
			}

			var_04 = var_04.var_BF2E;
			level thread func_5B7C(var_05.origin + (0,0,4),var_04.origin + (0,0,4),(0,1,1));
		}
	}
}

//Function Number: 73
func_5B79(param_00)
{
}

//Function Number: 74
func_5B7C(param_00,param_01,param_02)
{
	level endon("endpath");
	wait(0.05);
}

//Function Number: 75
func_4F52(param_00)
{
}

//Function Number: 76
func_4F51(param_00)
{
}

//Function Number: 77
func_4F50(param_00,param_01,param_02,param_03,param_04,param_05)
{
}

//Function Number: 78
func_5B8B()
{
}