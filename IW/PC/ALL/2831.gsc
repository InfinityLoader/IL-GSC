/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2831.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 47
 * Decompile Time: 22 ms
 * Timestamp: 10/27/2023 12:23:53 AM
*******************************************************************/

//Function Number: 1
func_9543()
{
	setdvarifuninitialized("skyambient_off",0);
	func_9745();
	func_94E4();
}

//Function Number: 2
func_9745()
{
	level.var_1027E = [];
	level.var_11A24 = 0;
	if(!isdefined(level.var_10281))
	{
		level.var_10281 = [];
		if(!isdefined(level.var_10281["axis"]))
		{
			level.var_10281["axis"] = "veh_mil_air_ca_jackal_01";
		}

		if(!isdefined(level.var_10281["allies"]))
		{
			level.var_10281["allies"] = "veh_mil_air_un_jackal_02";
		}
	}

	scripts\common\utility::array_thread(getentarray("skyambient_on","targetname"),::func_10285);
	scripts\common\utility::array_thread(getentarray("skyambient_off","targetname"),::func_10284);
}

//Function Number: 3
func_10285()
{
	self endon("entitydeleted");
	func_9746(self.target);
	for(;;)
	{
		self waittill("trigger");
		if(level.var_1027E[self.target].var_10E19)
		{
			continue;
		}

		var_00 = undefined;
		if(isdefined(self.var_EE6B))
		{
			var_00 = self.var_EE6B;
		}

		if(isdefined(self.var_EF1C) && isdefined(self.var_EF1B))
		{
			var_00 = [self.var_EF1C,self.var_EF1B];
		}

		var_01 = undefined;
		if(isdefined(self.var_EE11))
		{
			var_01 = self.var_EE11;
		}

		func_10D23(self.target,var_00,var_01);
	}
}

//Function Number: 4
func_10284()
{
	self endon("entitydeleted");
	for(;;)
	{
		self waittill("trigger");
		if(!level.var_1027E[self.target].var_10E19)
		{
			continue;
		}

		var_00 = 0;
		if(func_C8ED("immediate",""))
		{
			var_00 = 1;
		}

		var_01 = 0;
		if(func_C8ED("forGood",""))
		{
			var_01 = 1;
		}

		thread func_1103F(self.target,var_00,var_01);
	}
}

//Function Number: 5
func_10D23(param_00,param_01,param_02)
{
	level endon("stop_" + param_00);
	if(getdvarint("skyambient_off"))
	{
		return;
	}

	func_9746(param_00);
	if(level.var_1027E[param_00].var_10E19)
	{
		return;
	}

	level.var_1027E[param_00].var_10E19 = 1;
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_03 = 15;
	if(isdefined(level.var_B460))
	{
		var_03 = level.var_B460;
	}

	var_04 = level.var_1027E[param_00].var_108D5;
	for(;;)
	{
		if(isdefined(level.var_B460))
		{
			var_03 = level.var_B460;
		}

		foreach(var_06 in var_04)
		{
			if(isdefined(var_06.var_4613) && isdefined(var_06.var_A9F6))
			{
				if(gettime() - var_06.var_A9F6 <= var_06.var_4613)
				{
					continue;
				}
			}

			var_07 = func_10283(var_06.var_1087B);
			if(!isdefined(var_07))
			{
				continue;
			}

			if(level.var_11A24 >= var_03)
			{
				continue;
			}

			var_06.var_A9F6 = gettime();
			var_08 = undefined;
			if(!isdefined(var_07.target))
			{
				var_08 = scripts\sp\_vehicle::func_13237(var_07);
			}
			else
			{
				var_08 = var_07 scripts\sp\_vehicle::func_1080B();
			}

			var_08 notsolid();
			var_08 method_80B3();
			var_08.var_1326A = var_07;
			level.var_1027E[param_00].var_2AD = scripts\common\utility::array_add(level.var_1027E[param_00].var_2AD,var_08);
			var_08 thread func_E02B(param_00);
			var_09 = 0;
			if(function_00FD(var_08) && !var_07 func_C8ED("no_chase"," "))
			{
				var_0A = 1;
				if(level.var_11A24 >= var_03)
				{
					var_0A = 0;
				}
				else if(!var_07 func_C8ED("always_chase"," ") && !scripts\common\utility::func_4347())
				{
					var_0A = 0;
				}

				if(var_0A)
				{
					var_09 = 1;
					var_08 thread func_48B2(var_07,undefined,param_00);
				}
			}

			if(isdefined(var_07.var_EE11) && !var_09)
			{
				var_0B = ["right","left"];
				var_0B = scripts\common\utility::array_randomize(var_0B);
				var_0C = randomint(var_07.var_EE11 + 1);
				for(var_0D = 0;var_0D < var_0C;var_0D++)
				{
					var_0E = var_0B[var_0D];
					wait(0.1);
					var_08 thread func_4958(var_0E);
				}
			}
		}

		if(isarray(param_01))
		{
			wait(randomfloatrange(param_01[0],param_01[1]));
			continue;
		}

		wait(param_01);
	}
}

//Function Number: 6
func_1103F(param_00,param_01,param_02)
{
	if(level.var_1027E.size == 0)
	{
		return;
	}

	if(!level.var_1027E[param_00].var_10E19)
	{
		return;
	}

	level.var_1027E[param_00].var_10E19 = 0;
	level notify("stop_" + param_00);
	if(isdefined(param_01) && param_01)
	{
		foreach(var_04 in level.var_1027E[param_00].var_2AD)
		{
			if(!isdefined(var_04))
			{
				continue;
			}

			if(isdefined(var_04.var_3D38))
			{
				if(isdefined(var_04.var_3D38.var_B911))
				{
					var_04.var_3D38.var_B911 delete();
				}

				var_04.var_3D38 delete();
			}

			if(isdefined(var_04.var_A420))
			{
				foreach(var_06 in var_04.var_A420)
				{
					var_06 delete();
				}
			}

			var_04 delete();
		}
	}

	if(isdefined(param_02) && param_02)
	{
		func_40C5(param_00);
	}
}

//Function Number: 7
func_40C5(param_00)
{
	if(!isdefined(level.var_1027E[param_00]))
	{
		return;
	}

	level notify("delete_" + param_00);
	scripts\sp\_utility::func_228A(getentarray(param_00,"targetname"));
	level.var_1027E[param_00] = undefined;
}

//Function Number: 8
func_10283(param_00)
{
	var_01 = undefined;
	var_02 = scripts\common\utility::array_randomize(param_00);
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.var_55BA))
		{
			continue;
		}

		if(isdefined(var_04.var_C374) && isdefined(var_04.var_A9F3))
		{
			if(gettime() - var_04.var_A9F3 < var_04.var_C374)
			{
				continue;
			}
		}

		var_01 = var_04;
		var_01.var_A9F3 = gettime();
		break;
	}

	return var_01;
}

//Function Number: 9
func_10282(param_00,param_01,param_02)
{
	level.var_1027E[param_00].var_108D5[param_01].var_4613 = param_02 * 1000;
}

//Function Number: 10
func_9746(param_00)
{
	if(isdefined(level.var_1027E[param_00]))
	{
		return;
	}

	level.var_1027E[param_00] = spawnstruct();
	level.var_1027E[param_00].var_10E19 = 0;
	level.var_1027E[param_00].var_1087B = [];
	level.var_1027E[param_00].var_2AD = [];
	var_01 = func_9747(param_00);
	level.var_1027E[param_00].var_108D5 = var_01;
}

//Function Number: 11
func_9747(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	var_02 = 0;
	var_03 = [];
	foreach(var_05 in var_01)
	{
		var_06 = "group_" + var_02;
		if(isdefined(var_05.var_86A2))
		{
			var_06 = var_05.var_86A2;
		}
		else
		{
			var_02++;
		}

		if(!isdefined(var_03[var_06]))
		{
			var_03[var_06] = spawnstruct();
			var_03[var_06].var_1087B = [];
		}

		var_05.var_C374 = 4;
		if(isdefined(var_05.var_EE6B))
		{
			var_05.var_C374 = var_05.var_EE6B;
		}

		var_05.var_C374 = var_05.var_C374 * 1000;
		var_03[var_06].var_1087B = scripts\common\utility::array_add(var_03[var_06].var_1087B,var_05);
	}

	return var_03;
}

//Function Number: 12
func_E02B(param_00)
{
	level endon("delete_" + param_00);
	var_01 = 0;
	if(function_00FD(self))
	{
		level.var_11A24++;
		var_01 = 1;
	}

	self waittill("death");
	level.var_1027E[param_00].var_2AD = scripts\common\utility::func_22A9(level.var_1027E[param_00].var_2AD,self);
	if(isdefined(self.var_3D38))
	{
		level.var_1027E[param_00].var_3D3A = scripts\common\utility::func_22A9(level.var_1027E[param_00].var_3D3A,self);
	}

	if(var_01)
	{
		level.var_11A24--;
	}
}

//Function Number: 13
func_5582(param_00)
{
	var_01 = getentarray(param_00,"script_noteworthy");
	foreach(var_03 in var_01)
	{
		if(isspawner(var_03))
		{
			var_03.var_55BA = 1;
		}
	}
}

//Function Number: 14
func_6238(param_00)
{
	var_01 = getentarray(param_00,"script_noteworthy");
	foreach(var_03 in var_01)
	{
		if(isspawner(var_03))
		{
			var_03.var_55BA = undefined;
		}
	}
}

//Function Number: 15
func_48B2(param_00,param_01,param_02)
{
	wait(randomfloatrange(0.5,1.2));
	if(!isdefined(self))
	{
		return;
	}

	thread func_A147();
	var_03 = getcsplineid(param_00.target);
	var_04 = function_008C(var_03,0);
	var_05 = function_008D(var_03,0);
	var_06 = level.var_10281["axis"];
	var_07 = "axis";
	if(param_00.var_EEDE == "axis")
	{
		var_06 = level.var_10281["allies"];
		var_07 = "allies";
	}

	var_08 = spawnvehicle(var_06,param_00.target + "_chase","jackal_un",var_04,var_05);
	var_08.var_EEDE = param_00.var_EEDE;
	var_08.origin = param_00.origin;
	var_08.angles = param_00.angles;
	var_08 method_8184();
	var_08 notsolid();
	var_08 method_80B3();
	var_08 lib_0C24::func_10A49();
	var_08 thread lib_0C24::func_517E();
	self.var_3D38 = var_08;
	if(!isdefined(level.var_1027E[param_02].var_3D3A))
	{
		level.var_1027E[param_02].var_3D3A = [];
		thread func_3D39(param_02);
	}

	var_09 = level.var_1027E[param_02].var_3D3A;
	var_09[var_09.size] = self;
	level.var_1027E[param_02].var_3D3A = var_09;
	level.var_1027E[param_00.var_336].var_2AD = scripts\common\utility::array_add(level.var_1027E[param_00.var_336].var_2AD,var_08);
	var_08 thread func_E02B(param_00.var_336);
	var_0A = func_4921(var_08.origin,var_08.angles,var_07);
	var_08.var_B921 = var_0A;
	var_0B = 1000;
	param_01 = (randomint(var_0B),randomint(500),randomint(var_0B));
	var_0A linkto(var_08,"tag_origin",param_01,(0,0,0));
	var_08 thread lib_0BDC::func_A342(var_03);
	var_08 waittill("death");
	var_0A delete();
}

//Function Number: 16
func_3D39(param_00)
{
	level endon("stop_" + param_00);
	var_01 = cos(25);
	for(;;)
	{
		wait(randomfloatrange(5,7));
		var_02 = level.var_1027E[param_00].var_3D3A;
		var_03 = undefined;
		var_04 = undefined;
		foreach(var_03 in var_02)
		{
			if(scripts\common\utility::func_13D90(level.player.origin,level.player getplayerangles(),var_03.origin,var_01))
			{
				var_04 = var_03;
				break;
			}
		}

		if(!isdefined(var_04))
		{
			continue;
		}

		var_04 scripts\sp\_utility::func_54C6();
	}
}

//Function Number: 17
func_4958(param_00)
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(self.var_A420))
	{
		self.var_A420 = [];
	}

	if(function_00FD(self))
	{
		var_01 = func_4921(self.origin,self.angles,self.var_EEDE);
	}
	else
	{
		var_01 = self.var_1326A scripts\sp\_utility::func_10808();
	}

	self.var_A420[param_00] = var_01;
	var_02 = (0,0,randomintrange(-500,500));
	var_03 = randomintrange(-1000,-500);
	if(scripts\common\utility::func_4347())
	{
		var_03 = var_03 * -1;
	}

	var_04 = randomintrange(800,1300);
	if(param_00 == "left")
	{
		var_04 = var_04 * -1;
	}

	var_02 = (var_03,var_04,var_02[2]);
	var_01 linkto(self,"tag_origin",var_02,(0,0,0));
	self waittill("death");
	if(isdefined(var_01))
	{
		var_01 delete();
	}
}

//Function Number: 18
func_4921(param_00,param_01,param_02)
{
	var_03 = level.var_10281[param_02];
	var_04 = undefined;
	if(!isdefined(level.var_1027F) || isdefined(level.var_1027F) && level.var_1027F)
	{
		var_04 = %jackal_vehicle_strike_state_idle;
		if(param_02 == "axis")
		{
			var_04 = %jackal_ca_vehicle_strike_state_idle;
		}
	}

	var_05 = spawn("script_model",param_00);
	var_05 setmodel(var_03);
	var_05 notsolid();
	var_05 method_80B3();
	var_05 method_83D0(#animtree);
	var_05.angles = param_01;
	var_05.var_EEDE = param_02;
	var_05.var_380 = self.var_380;
	var_05 lib_0C20::func_7598(0);
	var_05 lib_0C1A::func_25C5();
	if(isdefined(var_04))
	{
		var_05 method_82A4(var_04,1,0.2);
	}

	var_05 method_82A2(%jackal_motion_idle_ai,1,0);
	var_05 lib_0C24::func_10A49();
	var_05 lib_0C20::func_11132();
	var_05.var_284B = 0;
	var_05.var_284C[0] = "tag_flash_left";
	var_05.var_284C[1] = "tag_flash_right";
	return var_05;
}

//Function Number: 19
func_A147()
{
	self endon("death");
	if(scripts\common\utility::func_4347())
	{
		return;
	}

	wait(randomfloatrange(3,8));
	if(isdefined(self) && isalive(self))
	{
		scripts\sp\_utility::func_54C6();
	}
}

//Function Number: 20
func_A1C2(param_00)
{
	self endon("stop_firing_turrets_scripted");
	self endon("death");
	self endon("entitydeleted");
	param_00 endon("death");
	for(;;)
	{
		wait(randomfloatrange(2,4));
		var_01 = gettime();
		var_02 = randomfloatrange(1,3);
		while(gettime() - var_01 <= var_02)
		{
			func_B912(param_00);
			wait(0.1);
		}
	}
}

//Function Number: 21
func_B912(param_00)
{
	var_01 = self gettagorigin(self.var_284C[self.var_284B]);
	var_02 = param_00.origin;
	magicbullet("magic_spaceship_30mm_projectile_fake",var_01,var_02);
	self.var_284B = self.var_284B + 1 % self.var_284C.size;
}

//Function Number: 22
func_94E4()
{
	scripts\common\utility::array_thread(getentarray("aiAmbient_on","script_noteworthy"),::func_1A01);
}

//Function Number: 23
func_1A01()
{
	self endon("entitydeleted");
	for(;;)
	{
		self waittill("trigger");
		if(func_9B57())
		{
			continue;
		}

		func_19FF();
	}
}

//Function Number: 24
func_19FF(param_00)
{
	var_01 = self;
	if(isdefined(param_00))
	{
		var_01 = getent(param_00,"targetname");
	}

	if(var_01 func_9B57())
	{
		return;
	}

	if(!isdefined(var_01.var_1087B))
	{
		var_01.var_1087B = [];
		var_02 = getentarray(var_01.target,"targetname");
		var_03 = function_00C8(var_01.target);
		var_02 = scripts\common\utility::array_combine(var_02,var_03);
		var_04 = 0;
		foreach(var_06 in var_02)
		{
			var_07 = var_06.script_noteworthy;
			if(!isdefined(var_07))
			{
				var_07 = "spawner_" + var_04;
				var_04++;
			}

			var_01.var_1087B[var_07] = var_06;
		}
	}

	if(!isdefined(var_01.var_1B04))
	{
		var_01.var_1B04 = var_01 scripts\common\utility::getstructarray(var_01.target,"targetname");
	}

	if(!isdefined(var_01.var_C375))
	{
		var_01.var_C375 = var_01 scripts\sp\_utility::func_7A8F();
	}

	if(!isdefined(var_01.var_C5B7))
	{
		var_01.var_C5B7 = [];
		var_09 = getentarray("aiAmbient_on","script_noteworthy");
		foreach(var_0B in var_09)
		{
			if(var_0B == var_01)
			{
				continue;
			}

			if(var_0B.target != var_01.target)
			{
				continue;
			}

			var_01.var_C5B7[var_01.var_C5B7.size] = var_0B;
		}
	}

	if(!isdefined(var_01.var_1E08))
	{
		var_01.var_1E08 = [];
	}

	var_01.var_6261 = 1;
	foreach(var_0B in var_01.var_C5B7)
	{
		var_0B.var_6261 = 1;
	}

	var_06 = var_01.spawner;
	var_0F = var_01.var_1B04;
	var_10 = var_01.var_C375;
	foreach(var_12 in var_0F)
	{
		var_13 = var_12 func_489B(var_01.var_1087B,var_01);
		var_13 hide();
		var_01.var_1E08[var_01.var_1E08.size] = var_13;
		wait(0.05);
	}

	var_01 notify("aiAmbient_spawned");
	scripts\common\utility::array_thread(var_10,::func_1A00,var_01);
}

//Function Number: 25
func_489B(param_00,param_01)
{
	var_02 = undefined;
	var_03 = self.script_noteworthy;
	if(isdefined(var_03) && isdefined(param_00[var_03]))
	{
		var_02 = param_00[var_03];
	}
	else
	{
		var_02 = scripts\common\utility::random(param_00);
	}

	var_02.var_C1 = 1;
	var_04 = var_02 scripts\sp\_utility::func_10619();
	var_04 dontinterpolate();
	if(!isai(var_04))
	{
		var_04.var_6B14 = 1;
	}

	if(func_C8ED("notsolid"," "))
	{
		var_04 notsolid();
	}

	if(func_C8ED("gun_remove"," "))
	{
		var_04 scripts\sp\_utility::func_86E4();
	}

	if(func_C8ED("friendname"," "))
	{
		var_04 func_2C16();
	}

	if(func_C8ED("explo_ragdoll"," "))
	{
		var_04 thread func_DC18();
	}

	if(func_C8ED("friendlyfire"," "))
	{
		var_04 thread func_19FC(issubstr(var_02.classname,"civilian"),1);
	}

	if(isdefined(self.script_sound))
	{
		var_04 thread func_489C(self.script_sound,self.var_257,param_01);
	}

	if(isdefined(self.var_1FA2))
	{
		var_04 thread func_1E09(param_01,self);
	}

	if(func_C8ED("bloodpool"," "))
	{
		var_04 thread func_19FD();
	}

	return var_04;
}

//Function Number: 26
func_1E09(param_00,param_01)
{
	param_00 endon("entitydeleted");
	param_00 waittill("aiAmbient_spawned");
	var_02 = param_01.var_1FA2;
	if(issubstr(self.model,"female"))
	{
		var_02 = func_79B6(var_02);
	}

	var_03 = 0;
	if(func_9DB6(var_02))
	{
		var_03 = 1;
	}

	lib_0A1E::func_236C(self);
	if(var_03)
	{
		if(!isdefined(self.var_1FBB))
		{
			if(isdefined(level.var_EC85["generic"][var_02]))
			{
				self.var_1FBB = "generic";
			}
		}

		if(!isdefined(self.angles))
		{
			param_01.angles = (0,0,0);
		}

		thread lib_0B06::func_1EC2(self,var_02,param_01.origin,param_01.angles);
	}
	else
	{
		param_01 thread lib_0B06::func_1ECC(self,var_02);
	}

	self show();
}

//Function Number: 27
func_79B6(param_00)
{
	var_01 = self.var_1FBB;
	if(!isdefined(var_01))
	{
		var_01 = "generic";
	}

	if(isdefined(level.var_EC85[var_01][param_00 + "_fem"]))
	{
		return param_00 + "_fem";
	}

	return param_00;
}

//Function Number: 28
func_489C(param_00,param_01,param_02)
{
	param_02 waittill("aiAmbient_spawned");
	scripts\common\utility::func_136F7();
	var_03 = spawn("trigger_radius",self.origin,0,param_01,param_01);
	var_03 scripts\sp\_utility::func_178D(::scripts\sp\_utility::func_137AA,"trigger");
	scripts\sp\_utility::func_178D(::scripts\sp\_utility::func_137AA,"entitydeleted");
	scripts\sp\_utility::func_57D6();
	var_03 delete();
	if(isdefined(self))
	{
		function_0178(param_00,self.origin);
	}
}

//Function Number: 29
func_DC18()
{
	self endon("death");
	self setcandamage(1);
	self.health = 500;
	wait(2);
	for(;;)
	{
		self waittill("damage",var_00,var_00,var_00,var_00,var_01);
		if(isdefined(var_01) && function_0107(var_01))
		{
			if(isdefined(self.var_71C8))
			{
				self [[ self.var_71C8 ]]();
			}

			self method_839A();
			return;
		}
	}
}

//Function Number: 30
func_2C16()
{
	scripts\sp\_names::func_7B05();
	self method_8307(self.name,&"");
}

//Function Number: 31
func_9DB6(param_00)
{
	if(issubstr(param_00,"dead"))
	{
		return 1;
	}

	if(issubstr(param_00,"death"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 32
func_19FD()
{
	wait(0.05);
	var_00 = spawn("trigger_radius",self.origin,0,512,64);
	var_00 scripts\sp\_utility::func_178D(::scripts\sp\_utility::func_137AA,"trigger");
	scripts\sp\_utility::func_178D(::scripts\sp\_utility::func_137AA,"entitydeleted");
	scripts\sp\_utility::func_57D6();
	var_00 delete();
	if(isdefined(self))
	{
		lib_0C60::func_CCAA();
	}
}

//Function Number: 33
func_19FC(param_00,param_01)
{
	self endon("entitydeleted");
	self setcandamage(1);
	thread scripts\sp\_utility::func_7748();
	scripts\sp\_utility::func_16B7(::scripts\sp\_damagefeedback::func_4D4C);
	if(isdefined(param_00) && param_00)
	{
		self.type = "civilian";
	}

	thread scripts\sp\_friendlyfire::func_73B1(self);
	if(!isdefined(param_01) || !param_01)
	{
		return;
	}

	self waittill("death");
	self method_839A();
}

//Function Number: 34
func_1A00(param_00)
{
	param_00 endon("aiAmbient_off");
	self waittill("trigger");
	param_00 func_19FE();
}

//Function Number: 35
func_19FE(param_00)
{
	var_01 = self;
	if(isdefined(param_00))
	{
		var_01 = getent(param_00,"targetname");
	}

	if(!var_01 func_9B57())
	{
		return;
	}

	var_01.var_6261 = 0;
	foreach(var_03 in var_01.var_1E08)
	{
		if(isdefined(var_03.var_3122))
		{
			var_03.var_3122 delete();
		}

		var_03 delete();
	}

	var_01.var_1E08 = [];
	self notify("aiAmbient_off");
}

//Function Number: 36
func_9B57()
{
	if(!isdefined(self.var_6261))
	{
		self.var_6261 = 0;
	}

	if(self.var_6261)
	{
		return 1;
	}

	return 0;
}

//Function Number: 37
func_1D84()
{
	var_00 = scripts\common\utility::getstructarray(self.target,"targetname");
	var_01 = func_39D3(var_00);
	var_02 = func_39D2();
	self.var_B8B4 = var_01;
	self.var_B8B2 = var_02;
}

//Function Number: 38
func_39BC()
{
	self endon("reached_end_node");
	self endon("death");
	func_1D84();
	var_00 = undefined;
	for(;;)
	{
		self waittill("noteworthy",var_01);
		var_02 = strtok(var_01," ");
		foreach(var_04 in var_02)
		{
			switch(var_04)
			{
				case "start_entry":
					var_00 = scripts\common\utility::spawn_tag_origin();
					var_00 linkto(self,"fx_entryburn_1",(0,0,0),(0,0,0));
					playfxontag(scripts\common\utility::getfx("enemy_entry_fireball_base_a"),var_00,"tag_origin");
					break;
	
				case "stop_entry":
					stopfxontag(scripts\common\utility::getfx("enemy_entry_fireball_base_a"),var_00,"tag_origin");
					var_00 delete();
					break;
	
				case "fire_missiles":
					self notify("stop_fire_missiles");
					var_05 = self.var_4BF7;
					var_06 = var_05 scripts\sp\_utility::func_7A97();
					var_07 = func_39D3(var_06);
					foreach(var_09 in var_07)
					{
						thread func_3987(var_09,[1,3],[0.25,0.5]);
					}
					break;
	
				case "stop_fire_missiles":
					self notify("stop_fire_missiles");
					break;
			}
		}
	}
}

//Function Number: 39
func_1D83()
{
	scripts\common\utility::waittill_either("death","ambient_capitalship_cleanup");
	self notify("stop_fire_missiles");
	scripts\sp\_utility::func_228A(self.var_B8B4);
}

//Function Number: 40
func_3987(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	self endon("stop_fire_missiles");
	if(isdefined(param_03))
	{
		self endon(param_03);
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	for(;;)
	{
		if(isarray(param_01))
		{
			var_07 = randomintrange(param_01[0],param_01[1]);
		}
		else
		{
			var_07 = param_01;
		}

		for(var_08 = 0;var_08 <= var_07;var_08++)
		{
			if(isarray(param_00))
			{
				var_09 = scripts\common\utility::random(param_00);
			}
			else
			{
				var_09 = param_00;
			}

			var_0A = undefined;
			if(isdefined(var_09.var_EE8F) && var_09.var_EE8F)
			{
				var_0A = spawnstruct();
				var_0A.var_FF23 = var_09.var_FF23;
				var_0A.var_FF3E = var_09.var_FF3E;
				var_0A.origin = func_E45E(var_09.origin,var_09.var_257);
				var_09 = var_0A;
			}

			func_3986(var_09,param_04,param_05,param_06);
			wait(randomfloatrange(0.45,0.9));
		}

		wait(randomfloatrange(param_02[0],param_02[1]));
	}
}

//Function Number: 41
func_3986(param_00,param_01,param_02,param_03)
{
	var_04 = 1;
	if(isdefined(param_00.var_FF23))
	{
		var_04 = param_00.var_FF23;
	}

	var_05 = 1;
	if(isdefined(param_00.var_FF3E))
	{
		var_05 = param_00.var_FF3E;
	}

	var_06 = undefined;
	if(isdefined(param_02))
	{
		var_06 = [];
		var_06[0] = param_02;
		var_06[1] = param_03;
		var_06[2] = 5;
	}

	thread lib_0BB6::func_3989(param_00,param_01,var_06,var_04,var_05);
}

//Function Number: 42
func_39B9(param_00)
{
	var_01 = self.origin;
	while(isdefined(self))
	{
		var_01 = self.origin;
		wait(0.05);
	}

	earthquake(0.25,1,var_01,5000);
	if(isdefined(param_00))
	{
		playfx(scripts\common\utility::getfx(param_00),var_01);
	}
}

//Function Number: 43
func_39D2()
{
	var_00 = ["l","r"];
	var_01 = [];
	foreach(var_03 in var_00)
	{
		var_01[var_03] = [];
		for(var_04 = 1;var_04 < 25;var_04++)
		{
			var_05 = "amb_missile_" + var_03 + "_" + var_04;
			if(!scripts\sp\_utility::func_8C32(self.model,var_05))
			{
				break;
			}

			var_01[var_03][var_04] = var_05;
		}
	}

	return var_01;
}

//Function Number: 44
func_39D3(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_04 = var_03;
		var_04.var_F1 = 0;
		if(var_04 func_C8ED("direct"))
		{
			var_04.var_F1 = 1;
		}

		if(isdefined(var_03.var_ED41))
		{
			if(!int(var_03.var_ED41))
			{
				var_04.var_FF23 = int(var_03.var_ED41);
			}
		}

		if(isdefined(var_03.var_ED76))
		{
			if(!int(var_03.var_ED76))
			{
				var_04.var_FF3E = int(var_03.var_ED76);
			}
		}

		var_05 = var_03.script_noteworthy;
		if(!isdefined(var_01[var_05]))
		{
			var_01[var_05] = [];
		}

		var_01[var_05] = scripts\common\utility::array_add(var_01[var_05],var_04);
	}

	return var_01;
}

//Function Number: 45
func_C120(param_00,param_01)
{
	if(!isdefined(self.script_noteworthy))
	{
		return 0;
	}

	param_00 = tolower(param_00);
	var_02 = tolower(self.script_noteworthy);
	if(!isdefined(param_01))
	{
		if(var_02 == param_00)
		{
			return 1;
		}

		return 0;
	}

	var_03 = strtok(var_02,param_01);
	foreach(var_05 in var_03)
	{
		if(var_05 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 46
func_C8ED(param_00,param_01)
{
	if(!isdefined(self.var_EE79))
	{
		return 0;
	}

	param_00 = tolower(param_00);
	var_02 = tolower(self.var_EE79);
	if(!isdefined(param_01))
	{
		if(var_02 == param_00)
		{
			return 1;
		}

		return 0;
	}

	var_03 = strtok(var_02,param_01);
	foreach(var_05 in var_03)
	{
		if(var_05 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 47
func_E45E(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	if(isdefined(param_03))
	{
		var_05 = param_03 / param_01;
		var_04 = param_01 - param_01 * randomfloat(var_05);
	}
	else
	{
		var_04 = param_01 * randomfloat(1);
	}

	var_06 = randomfloat(360);
	var_07 = sin(var_06);
	var_08 = cos(var_06);
	var_09 = var_04 * var_08;
	var_0A = var_04 * var_07;
	var_0B = 0;
	if(isdefined(param_02))
	{
		var_0B = randomfloatrange(param_02 * -1,param_02);
	}

	var_09 = var_09 + param_00[0];
	var_0A = var_0A + param_00[1];
	var_0B = var_0B + param_00[2];
	return (var_09,var_0A,var_0B);
}