/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2935.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 136
 * Decompile Time: 78 ms
 * Timestamp: 10/27/2023 12:24:56 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.var_10707 = [];
	level.var_10707["allies"] = [];
	level.var_10707["axis"] = [];
	level.var_10707["team3"] = [];
	level.var_10707["neutral"] = [];
	thread func_8438();
	var_00 = getentarray("flood_and_secure","targetname");
	scripts\common\utility::array_thread(var_00,::func_6F4C);
	if(!isdefined(level.var_19C9))
	{
		level.var_19C9 = 0;
	}

	if(getdvar("fallback") == "")
	{
		setdvar("fallback","0");
	}

	if(getdvar("noai") == "")
	{
		setdvar("noai","off");
	}

	precachemodel("grenade_bag");
	function_004E("allies");
	function_004E("axis");
	function_004E("team3");
	function_004E("civilian");
	function_004E("equipment");
	function_01D1("axis","equipment",250);
	function_01D1("allies","equipment",250);
	function_01D1("team3","equipment",-1000);
	lib_0B5F::func_965A();
	foreach(var_02 in level.players)
	{
		var_02 method_834E("allies");
	}

	level.var_1162 = [];
	level.var_76F3 = [];
	if(!isdefined(level.var_4E3F))
	{
		level.var_4E3F = [];
	}

	level.var_1086A = 0;
	if(!isdefined(level.var_12BA5))
	{
		level.var_12BA5 = [];
	}

	var_04 = function_00C8();
	foreach(var_06 in var_04)
	{
	}

	level.var_12BA5["soldier"] = ::func_10804;
	level.var_12BA5["c8"] = ::func_10803;
	level.var_115BE = [];
	level.var_115BE["axis"] = ::func_107ED;
	level.var_115BE["allies"] = ::func_107EC;
	level.var_115BE["team3"] = ::func_107EF;
	level.var_115BE["neutral"] = ::func_107EE;
	if(!isdefined(level.var_4FF6))
	{
		level.var_4FF6 = 2048;
	}

	if(!isdefined(level.var_4FF5))
	{
		level.var_4FF5 = 512;
	}

	level.var_D66F = "J_Shoulder_RI";
	level.var_1349 = 0;
	var_08 = function_0074();
	scripts\common\utility::array_thread(var_08,::func_AD8E);
	level.var_1923 = [];
	level.var_5C63 = [];
	var_09 = function_00C8();
	for(var_0A = 0;var_0A < var_09.size;var_0A++)
	{
		var_09[var_0A] thread func_107AB();
	}

	level.var_5C63 = undefined;
	scripts\sp\_utility::func_9189("tracker",1,"default");
	thread func_D970();
	scripts\common\utility::array_thread(var_08,::func_107F2);
	var_0B = getarraykeys(level.var_1923);
	for(var_0A = 0;var_0A < var_0B.size;var_0A++)
	{
		var_0C = tolower(var_0B[var_0A]);
		if(!issubstr(var_0C,"rpg"))
		{
			continue;
		}

		var_0D = "iw7_lockon";
		precacheitem(var_0D);
		break;
	}

	var_0B = undefined;
}

//Function Number: 2
func_1B09()
{
}

//Function Number: 3
func_D970()
{
	foreach(var_02, var_01 in level.var_4E3F)
	{
		if(!isdefined(level.flag[var_02]))
		{
			scripts\common\utility::flag_init(var_02);
		}
	}
}

//Function Number: 4
func_10729()
{
	self endon("death");
	for(;;)
	{
		if(self.var_C1 > 0)
		{
			self waittill("spawned");
		}

		waittillframeend;
		if(!self.var_C1)
		{
			return;
		}
	}
}

//Function Number: 5
func_1936()
{
	level.var_4E3F[self.var_ED48]["ai"][self.var_12BA3] = self;
	var_00 = self.var_12BA3;
	var_01 = self.var_ED48;
	if(isdefined(self.var_ED49))
	{
		func_1382D();
	}
	else
	{
		self waittill("death");
	}

	level.var_4E3F[var_01]["ai"][var_00] = undefined;
	func_12DAA(var_01);
}

//Function Number: 6
func_131C1()
{
	var_00 = self.var_12BA3;
	var_01 = self.var_ED48;
	if(!isdefined(level.var_4E3F) || !isdefined(level.var_4E3F[self.var_ED48]))
	{
		waittillframeend;
		if(!isdefined(self))
		{
			return;
		}
	}

	level.var_4E3F[var_01]["vehicles"][var_00] = self;
	self waittill("death");
	level.var_4E3F[var_01]["vehicles"][var_00] = undefined;
	func_12DAA(var_01);
}

//Function Number: 7
func_1085A()
{
	level.var_4E3F[self.var_ED48] = [];
	waittillframeend;
	if(!isdefined(self) || self.var_C1 == 0)
	{
		return;
	}

	self.var_1086A = level.var_1086A;
	level.var_1086A++;
	level.var_4E3F[self.var_ED48]["spawners"][self.var_1086A] = self;
	var_00 = self.var_ED48;
	var_01 = self.var_1086A;
	func_10729();
	level.var_4E3F[var_00]["spawners"][var_01] = undefined;
	func_12DAA(var_00);
}

//Function Number: 8
func_1323D()
{
	level.var_4E3F[self.var_ED48] = [];
	waittillframeend;
	if(!isdefined(self))
	{
		return;
	}

	self.var_1086A = level.var_1086A;
	level.var_1086A++;
	level.var_4E3F[self.var_ED48]["vehicle_spawners"][self.var_1086A] = self;
	var_00 = self.var_ED48;
	var_01 = self.var_1086A;
	func_10729();
	level.var_4E3F[var_00]["vehicle_spawners"][var_01] = undefined;
	func_12DAA(var_00);
}

//Function Number: 9
func_12DAA(param_00)
{
	level notify("updating_deathflag_" + param_00);
	level endon("updating_deathflag_" + param_00);
	waittillframeend;
	foreach(var_02 in level.var_4E3F[param_00])
	{
		if(getarraykeys(var_02).size > 0)
		{
			return;
		}
	}

	scripts\common\utility::flag_set(param_00);
}

//Function Number: 10
func_C75A(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isai(var_01))
		{
			continue;
		}

		var_01 thread scripts\sp\_utility::func_931D(0.15);
		var_01 scripts\sp\_utility::func_5514();
	}
}

//Function Number: 11
func_9409(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isai(var_01))
		{
			continue;
		}

		var_01 thread scripts\sp\_utility::func_931D(0.15);
		var_01 scripts\sp\_utility::func_61E7();
	}
}

//Function Number: 12
func_12797(param_00)
{
	param_00 waittill("trigger");
	var_01 = param_00.var_DC8F;
	var_02 = param_00.target;
	param_00 scripts\sp\_utility::script_delay();
	if(isdefined(var_01))
	{
		waittillframeend;
	}

	var_03 = scripts\common\utility::array_combine(function_00C8(var_02),vehicle_getspawnerarray(var_02));
	foreach(var_05 in var_03)
	{
		if(!function_02A8(var_05) && var_05.var_9F == "script_vehicle")
		{
			if((isdefined(var_05.var_EE2B) && var_05.var_EE2B == 1) || !isdefined(var_05.target))
			{
				thread scripts\sp\_vehicle::func_13237(var_05);
			}
			else
			{
				var_05 thread scripts\sp\_vehicle::func_1080B();
			}

			continue;
		}

		var_05 thread func_12799();
	}

	if(isdefined(level.var_107A7))
	{
		func_12781(var_02);
	}
}

//Function Number: 13
func_12781(param_00)
{
	var_01 = scripts\common\utility::getstructarray(param_00,"targetname");
	if(getentarray(param_00,"target").size <= 1)
	{
		scripts\sp\_utility::func_51D6(var_01);
	}

	var_02 = func_7BC6(var_01);
	scripts\common\utility::array_thread(var_02,::func_12799);
}

//Function Number: 14
func_7BC6(param_00)
{
	var_01 = [];
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(!isdefined(var_04.var_EEB6))
		{
			continue;
		}

		if(!isdefined(var_02[var_04.var_EEB6]))
		{
			var_02[var_04.var_EEB6] = [];
		}

		var_02[var_04.var_EEB6][var_02[var_04.var_EEB6].size] = var_04;
	}

	foreach(var_07 in var_02)
	{
		foreach(var_04 in var_07)
		{
			var_09 = func_7C86(var_04,var_07.size);
			var_01[var_01.size] = var_09;
		}
	}

	return var_01;
}

//Function Number: 15
func_7C86(param_00,param_01)
{
	if(!isdefined(level.var_1086B))
	{
		level.var_1086B = [];
	}

	if(!isdefined(level.var_1086B[param_00.var_EEB6]))
	{
		level.var_1086B[param_00.var_EEB6] = func_492A(param_00.var_EEB6);
	}

	var_02 = level.var_1086B[param_00.var_EEB6];
	var_03 = var_02.var_D651[var_02.var_D653];
	var_02.var_D653++;
	var_02.var_D653 = var_02.var_D653 % var_02.var_D651.size;
	var_03.origin = param_00.origin;
	if(isdefined(param_00.angles))
	{
		var_03.angles = param_00.angles;
	}
	else if(isdefined(param_00.target))
	{
		var_04 = function_00B3(param_00.target,"targetname");
		if(isdefined(var_04))
		{
			var_03.angles = vectortoangles(var_04.origin - var_03.origin);
		}
	}

	if(isdefined(level.var_107A6))
	{
		var_03 [[ level.var_107A6 ]](param_00);
	}

	if(isdefined(param_00.target))
	{
		var_03.target = param_00.target;
	}

	var_03.var_C1 = 1;
	return var_03;
}

//Function Number: 16
func_492A(param_00)
{
	var_01 = function_00C8();
	var_02 = spawnstruct();
	var_03 = [];
	foreach(var_05 in var_01)
	{
		if(!isdefined(var_05.var_EEB6))
		{
			continue;
		}

		if(var_05.var_EEB6 != param_00)
		{
			continue;
		}

		var_03[var_03.size] = var_05;
	}

	var_02.var_D653 = 0;
	var_02.var_D651 = var_03;
	return var_02;
}

//Function Number: 17
func_12799()
{
	self endon("death");
	scripts\sp\_utility::script_delay();
	if(!isdefined(self))
	{
		return undefined;
	}

	if(isdefined(self.var_ED6E))
	{
		var_00 = scripts\sp\_utility::func_5CC8(self);
		return undefined;
	}
	else if(isdefined(self.var_ED8A))
	{
		var_00 = scripts\sp\_utility::func_6B47(self);
		return undefined;
	}
	else if(isdefined(self.var_ED1B))
	{
		var_00 = scripts\sp\_utility::func_2C17(self);
		return undefined;
	}
	else if(!issubstr(self.classname,"actor"))
	{
		return undefined;
	}

	var_01 = isdefined(self.var_EED1) && scripts\common\utility::flag("stealth_enabled") && !scripts\common\utility::flag("stealth_spotted");
	if(isdefined(self.var_EDB3))
	{
		var_00 = self method_8393(var_01);
	}
	else
	{
		var_00 = self method_80B5(var_01);
	}

	if(!scripts\sp\_utility::func_106ED(var_01))
	{
		if(isdefined(self.var_ED39))
		{
			if(self.var_ED39 == "heat")
			{
				var_01 scripts\sp\_utility::func_61FF();
			}

			if(self.var_ED39 == "cqb")
			{
				var_01 scripts\sp\_utility::func_61E7();
			}
		}
	}

	return var_01;
}

//Function Number: 18
func_12798(param_00)
{
	var_01 = param_00.target;
	var_02 = 0;
	var_03 = function_00C8(var_01);
	foreach(var_05 in var_03)
	{
		if(!isdefined(var_05.target))
		{
			continue;
		}

		var_06 = getspawner(var_05.target,"targetname");
		if(!isdefined(var_06))
		{
			if(!isdefined(var_05.var_EE01))
			{
				continue;
			}

			var_06 = getspawner(var_05.var_EE01,"script_linkname");
			if(!isdefined(var_06))
			{
				var_06 = var_05 scripts\sp\_utility::func_7A8E();
			}

			if(!isdefined(var_06))
			{
				continue;
			}

			if(!isspawner(var_06))
			{
				continue;
			}
		}

		var_02 = 1;
		break;
	}

	param_00 waittill("trigger");
	param_00 scripts\sp\_utility::script_delay();
	var_03 = function_00C8(var_01);
	foreach(var_05 in var_03)
	{
		var_05 thread func_1278A();
	}
}

//Function Number: 19
func_1278A()
{
	var_00 = func_12789();
	var_01 = func_12799();
	if(!isdefined(var_01))
	{
		self delete();
		if(isdefined(var_00))
		{
			var_01 = var_00 func_12799();
			var_00 delete();
			if(!isdefined(var_01))
			{
				return;
			}
		}
		else
		{
			return;
		}
	}

	if(!isdefined(var_00))
	{
		return;
	}

	var_01 waittill("death");
	if(!isdefined(var_00))
	{
		return;
	}

	if(!isdefined(var_00.var_C1))
	{
		var_00.var_C1 = 1;
	}

	for(;;)
	{
		if(!isdefined(var_00))
		{
			break;
		}

		var_02 = var_00 func_12799();
		if(!isdefined(var_02))
		{
			var_00 delete();
			break;
		}

		var_02 thread func_DF23(var_00);
		var_02 waittill("death",var_03);
		if(!func_D27A(var_02,var_03))
		{
			if(!isdefined(var_00))
			{
				break;
			}

			var_00.var_C1++;
		}

		if(!isdefined(var_02))
		{
			continue;
		}

		if(!isdefined(var_00))
		{
			break;
		}

		if(!isdefined(var_00.var_C1))
		{
			break;
		}

		if(var_00.var_C1 <= 0)
		{
			break;
		}

		if(!scripts\sp\_utility::func_EF15())
		{
			wait(randomfloatrange(1,3));
		}
	}

	if(isdefined(var_00))
	{
		var_00 delete();
	}
}

//Function Number: 20
func_12789()
{
	if(isdefined(self.target))
	{
		var_00 = getspawner(self.target,"targetname");
		if(isdefined(var_00) && isspawner(var_00))
		{
			return var_00;
		}
	}

	if(isdefined(self.var_EE01))
	{
		var_00 = getspawner(self.var_EE01,"script_linkname");
		if(!isdefined(var_00))
		{
			var_00 = scripts\sp\_utility::func_7A8E();
		}

		if(isdefined(var_00) && isspawner(var_00))
		{
			return var_00;
		}
	}

	return undefined;
}

//Function Number: 21
func_6F5A(param_00)
{
	scripts\common\utility::array_thread(param_00,::func_6F59);
	scripts\common\utility::array_thread(param_00,::func_6F5C);
}

//Function Number: 22
func_DF23(param_00)
{
	param_00 endon("death");
	if(isdefined(self.var_EDAA))
	{
		if(self.var_EDAA)
		{
			return;
		}
	}

	self waittill("death");
	if(!isdefined(self))
	{
		param_00.var_C1++;
	}
}

//Function Number: 23
func_A617(param_00)
{
	var_01 = param_00.var_EDF7;
	param_00 waittill("trigger");
	waittillframeend;
	waittillframeend;
	func_A67F(var_01);
	func_A622(param_00);
}

//Function Number: 24
func_A67F(param_00)
{
	var_01 = function_00C8();
	var_02 = vehicle_getspawnerarray();
	var_03 = scripts\common\utility::array_combine(var_01,var_02);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if(isdefined(var_03[var_04].var_EDF7) && param_00 == var_03[var_04].var_EDF7)
		{
			if(function_02A8(var_03[var_04]))
			{
				var_03[var_04] notify("death");
			}

			var_03[var_04] delete();
		}
	}
}

//Function Number: 25
func_A622(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(param_00.var_336) && param_00.var_336 != "flood_spawner")
	{
		return;
	}

	param_00 delete();
}

//Function Number: 26
func_DC8F(param_00)
{
	param_00 endon("death");
	var_01 = param_00.var_EE90;
	waittillframeend;
	if(!isdefined(level.var_A67E))
	{
		level.var_A67E = [];
	}

	if(!isdefined(level.var_A67E[var_01]))
	{
		return;
	}

	param_00 waittill("trigger");
	func_4B09(var_01);
}

//Function Number: 27
func_4B09(param_00)
{
	if(!isdefined(level.var_A67E))
	{
		level.var_A67E = [];
	}

	if(!isdefined(level.var_A67E[param_00]))
	{
		return;
	}

	var_01 = level.var_A67E[param_00];
	var_02 = getarraykeys(var_01);
	if(var_02.size <= 1)
	{
		return;
	}

	var_03 = scripts\common\utility::random(var_02);
	var_01[var_03] = undefined;
	foreach(var_09, var_05 in var_01)
	{
		foreach(var_07 in var_05)
		{
			if(isdefined(var_07))
			{
				var_07 delete();
			}
		}

		level.var_A67E[param_00][var_09] = undefined;
	}
}

//Function Number: 28
func_61BD(param_00)
{
	var_01 = param_00.var_ED77;
	param_00 waittill("trigger");
	var_02 = function_00C8();
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(!isdefined(var_02[var_03].var_ED77))
		{
			continue;
		}

		if(var_01 != var_02[var_03].var_ED77)
		{
			continue;
		}

		var_02[var_03] scripts\sp\_utility::func_F311(0);
		var_02[var_03] notify("emptied spawner");
	}

	param_00 notify("deleted spawners");
}

//Function Number: 29
func_A618(param_00)
{
	var_01 = function_00C8();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isdefined(var_01[var_02].var_EDF7))
		{
			continue;
		}

		if(param_00 != var_01[var_02].var_EDF7)
		{
			continue;
		}

		var_01[var_02] delete();
	}
}

//Function Number: 30
func_1071F(param_00,param_01)
{
	var_02 = spawn("weapon_frag",param_00);
	var_02 thread add_to_grenade_cache(param_01);
	return var_02;
}

//Function Number: 31
add_to_grenade_cache(param_00)
{
	if(!isdefined(level.var_8580) || !isdefined(level.var_8580[param_00]))
	{
		level.var_8581[param_00] = 0;
		level.var_8580[param_00] = [];
	}

	var_01 = level.var_8581[param_00];
	var_02 = level.var_8580[param_00][var_01];
	if(isdefined(var_02))
	{
		var_02 delete();
	}

	level.var_8580[param_00][var_01] = self;
	level.var_8581[param_00] = var_01 + 1 % 16;
}

//Function Number: 32
func_1382D()
{
	self endon("death");
	self waittill("pain_death");
}

//Function Number: 33
func_5CEE()
{
	func_1382D();
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.var_C05C))
	{
		return;
	}

	self.var_183 = 1;
	if(scripts\sp\_utility::func_93A6())
	{
		if(lib_0B78::spawn_nanoshot())
		{
			return;
		}
	}

	if(self.var_162 <= 0)
	{
		return;
	}

	if(level.player scripts\sp\_utility::func_65DF("zero_gravity") && level.player scripts\sp\_utility::func_65DB("zero_gravity"))
	{
		return;
	}

	level.var_BF83--;
	if(level.var_BF83 > 0)
	{
		return;
	}

	level.var_BF83 = 2 + randomint(2);
	var_00 = 25;
	var_01 = 12;
	var_02 = self.origin + (randomint(var_00) - var_01,randomint(var_00) - var_01,2) + (0,0,42);
	var_03 = (0,randomint(360),90);
	thread func_10720(var_02,var_03,self.team);
}

//Function Number: 34
func_10720(param_00,param_01,param_02)
{
	if(isdefined(level.var_D9E5["mandatoryunlocks"]) && scripts\common\utility::func_2286(level.var_D9E5["mandatoryunlocks"],"frag"))
	{
		return;
	}

	var_03 = func_1071F(param_00,param_02);
	var_03 setmodel("grenade_bag");
	var_03.angles = param_01;
	var_03 hide();
	wait(0.7);
	if(!isdefined(var_03))
	{
		return;
	}

	var_03 show();
}

//Function Number: 35
func_5CCA()
{
	scripts\sp\_drone_base::func_5C3A();
}

//Function Number: 36
func_6B48()
{
	lib_0B2B::func_6B44();
}

//Function Number: 37
func_107AB()
{
	level.var_1923[self.classname] = 1;
	if(isdefined(self.var_ED5B))
	{
		switch(self.var_ED5B)
		{
			case "easy":
				if(level.var_7683 > 1)
				{
					scripts\sp\_utility::func_F311(0);
				}
				break;

			case "hard":
				if(level.var_7683 < 2)
				{
					scripts\sp\_utility::func_F311(0);
				}
				break;
		}
	}

	func_9769();
	if(isdefined(self.var_ED6E))
	{
		thread func_5CCA();
	}

	if(isdefined(self.var_ED8A))
	{
		thread func_6B48();
	}

	if(isdefined(self.var_ECE7))
	{
		var_00 = self.var_ECE7;
		if(!isdefined(level.var_1162[var_00]))
		{
			func_1A12(var_00);
		}

		thread func_1A17(level.var_1162[var_00]);
	}

	if(isdefined(self.var_ED54))
	{
		var_01 = 0;
		if(isdefined(level.var_1160))
		{
			if(isdefined(level.var_1160[self.var_ED54]))
			{
				var_01 = level.var_1160[self.var_ED54].size;
			}
		}

		level.var_1160[self.var_ED54][var_01] = self;
	}

	if(isdefined(self.var_EDD7))
	{
		if(self.var_EDD7 > level.var_1349)
		{
			level.var_1349 = self.var_EDD7;
		}

		var_01 = 0;
		if(isdefined(level.var_1164))
		{
			if(isdefined(level.var_1164[self.var_EDD7]))
			{
				var_01 = level.var_1164[self.var_EDD7].size;
			}
		}

		level.var_1164[self.var_EDD7][var_01] = self;
	}

	if(isdefined(self.var_ED48))
	{
		thread func_1085A();
	}

	if(isdefined(self.target))
	{
		func_486E(self.target);
	}

	if(isdefined(self.var_EEBA))
	{
		func_177E();
	}

	if(isdefined(self.var_EE90))
	{
		func_1732();
	}

	if(!isdefined(self.var_10708))
	{
		self.var_10708 = [];
	}

	for(;;)
	{
		self waittill("spawned",var_02);
		if(!isalive(var_02))
		{
			continue;
		}

		if(isdefined(level.var_10877))
		{
			self thread [[ level.var_10877 ]](var_02);
		}

		if(isdefined(self.var_ED54))
		{
			for(var_03 = 0;var_03 < level.var_1160[self.var_ED54].size;var_03++)
			{
				if(level.var_1160[self.var_ED54][var_03] != self)
				{
					level.var_1160[self.var_ED54][var_03] delete();
				}
			}
		}

		var_02.var_10707 = self.var_10708;
		var_02.var_10708 = undefined;
		var_02.spawner = self;
		if(isdefined(self.var_336))
		{
			var_02 thread func_107F2(self.var_336);
			continue;
		}

		var_02 thread func_107F2();
	}
}

//Function Number: 38
func_9769()
{
	if(!isdefined(self.var_EECE) && !isdefined(self.var_EED1))
	{
		return;
	}

	if(isdefined(self.var_EECE) && !isdefined(self.var_EED1))
	{
		self.var_EED1 = self.var_EECE;
	}

	self.var_EECE = undefined;
}

//Function Number: 39
func_107F2(param_00)
{
	level.var_1923[self.classname] = 1;
	if(isdefined(self.var_238F) && self.var_238F == "seeker")
	{
		return;
	}

	func_107F3(param_00);
	self endon("death");
	if(func_1003C())
	{
		self delete();
	}

	thread func_E81A();
	self.var_6CDA = 1;
	self notify("finished spawning");
}

//Function Number: 40
func_1003C()
{
	if(!isdefined(self.var_ED5B))
	{
		return 0;
	}

	var_00 = 0;
	switch(self.var_ED5B)
	{
		case "easy":
			if(level.var_7683 > 1)
			{
				var_00 = 1;
			}
			break;

		case "hard":
			if(level.var_7683 < 2)
			{
				var_00 = 1;
			}
			break;
	}

	return var_00;
}

//Function Number: 41
func_E81A()
{
	if(!isdefined(self.var_10707))
	{
		self.spawner = undefined;
		return;
	}

	for(var_00 = 0;var_00 < self.var_10707.size;var_00++)
	{
		var_01 = self.var_10707[var_00];
		if(isdefined(var_01["param5"]))
		{
			thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"],var_01["param4"],var_01["param5"]);
			continue;
		}

		if(isdefined(var_01["param4"]))
		{
			thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"],var_01["param4"]);
			continue;
		}

		if(isdefined(var_01["param3"]))
		{
			thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"]);
			continue;
		}

		if(isdefined(var_01["param2"]))
		{
			thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"]);
			continue;
		}

		if(isdefined(var_01["param1"]))
		{
			thread [[ var_01["function"] ]](var_01["param1"]);
			continue;
		}

		thread [[ var_01["function"] ]]();
	}

	var_02 = scripts\common\utility::func_116D7(isdefined(level.var_131A0.var_10709) && level.var_131A0.var_10709 && self.var_9F == "script_vehicle",self.var_EEDE,self.team);
	if(isdefined(var_02))
	{
		for(var_00 = 0;var_00 < level.var_10707[var_02].size;var_00++)
		{
			var_01 = level.var_10707[var_02][var_00];
			if(isdefined(var_01["param5"]))
			{
				thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"],var_01["param4"],var_01["param5"]);
				continue;
			}

			if(isdefined(var_01["param4"]))
			{
				thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"],var_01["param4"]);
				continue;
			}

			if(isdefined(var_01["param3"]))
			{
				thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"]);
				continue;
			}

			if(isdefined(var_01["param2"]))
			{
				thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"]);
				continue;
			}

			if(isdefined(var_01["param1"]))
			{
				thread [[ var_01["function"] ]](var_01["param1"]);
				continue;
			}

			thread [[ var_01["function"] ]]();
		}
	}

	self.var_10707 = undefined;
	self.spawner = undefined;
}

//Function Number: 42
func_4E47()
{
	self waittill("death",var_00,var_01,var_02);
	level notify("ai_killed",self,var_00,var_01,var_02);
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(var_00))
	{
		scripts\anim\utility_common::func_E191(var_02,var_00,self);
		if(self.team == "axis" || self.team == "team3")
		{
			var_03 = undefined;
			if(isdefined(var_00.var_4F))
			{
				if(isdefined(var_00.var_9F45) && var_00.var_9F45)
				{
					var_03 = "sentry";
				}

				if(isdefined(var_00.var_ED))
				{
					var_03 = "destructible";
				}

				var_00 = var_00.var_4F;
			}
			else if(isdefined(var_00.var_222))
			{
				if(isai(var_00) && isplayer(var_00.var_222))
				{
					var_03 = "friendly";
				}

				var_00 = var_00.var_222;
			}
			else if(isdefined(var_00.var_4D5C))
			{
				if(isdefined(var_00.var_ED))
				{
					var_03 = "destructible";
				}

				var_00 = var_00.var_4D5C;
			}

			var_04 = 0;
			if(isplayer(var_00))
			{
				var_04 = 1;
			}

			if(isdefined(level.var_D5ED) && level.var_D5ED)
			{
				var_04 = 1;
			}

			if(var_04)
			{
				var_00 scripts\sp\_player_stats::func_DEBD(self,var_01,var_02,var_03);
				return;
			}
		}
	}
}

//Function Number: 43
func_1931()
{
	self.var_4CF5 = [];
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		self.var_C873 = var_00;
		if(isdefined(var_01) && isplayer(var_01))
		{
			var_0A = var_01 getcurrentweapon();
			if(isdefined(var_0A) && scripts\sp\_utility::func_9F0E(var_0A) && isdefined(var_04) && var_04 == "MOD_PISTOL_BULLET" || var_04 == "MOD_RIFLE_BULLET")
			{
				var_01 thread scripts\sp\_player_stats::func_DED8();
			}

			var_0B = getweaponbasename(var_0A);
			if(isdefined(var_0B) && var_0B == "iw7_m4" && scripts\sp\_utility::func_9FFE(var_0A))
			{
				thread func_11AD7(var_03);
			}
		}

		foreach(var_0D in self.var_4CF5)
		{
			thread [[ var_0D ]](var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		}

		if(!isalive(self) || self.var_EB)
		{
			break;
		}
	}
}

//Function Number: 44
func_AD8E()
{
	func_9769();
	if(isdefined(self.target))
	{
		func_486E(self.target);
	}
}

//Function Number: 45
func_486E(param_00)
{
	var_01 = func_7CDA(param_00);
	if(var_01.size == 0)
	{
		return;
	}

	var_02 = -1;
	for(;;)
	{
		var_02++;
		if(var_02 >= var_01.size)
		{
			break;
		}

		var_03 = var_01[var_02];
		if(isdefined(var_03.var_4871))
		{
			continue;
		}

		var_03.var_4871 = 1;
		level thread func_DFE2(var_03);
		if(isdefined(var_03.var_ED9E))
		{
			if(!isdefined(level.flag[var_03.var_ED9E]))
			{
				scripts\common\utility::flag_init(var_03.var_ED9E);
			}
		}

		if(isdefined(var_03.var_EDA0))
		{
			if(!isdefined(level.flag[var_03.var_EDA0]))
			{
				scripts\common\utility::flag_init(var_03.var_EDA0);
			}
		}

		if(isdefined(var_03.var_ED9B))
		{
			if(!isdefined(level.flag[var_03.var_ED9B]))
			{
				scripts\common\utility::flag_init(var_03.var_ED9B);
			}
		}

		if(isdefined(var_03.target))
		{
			var_04 = func_7CDA(var_03.target);
			foreach(var_06 in var_04)
			{
				if(!isdefined(var_06.var_4871))
				{
					var_01[var_01.size] = var_06;
				}
			}
		}
	}
}

//Function Number: 46
func_DFE2(param_00)
{
	waittillframeend;
	if(isdefined(param_00))
	{
		param_00.var_4871 = undefined;
	}
}

//Function Number: 47
func_107EC()
{
	self.var_36B = 0;
	func_3DF4();
}

//Function Number: 48
func_107ED()
{
	if(self.var_12BA4 == "soldier" && !isdefined(level.var_55F0))
	{
		thread func_5CEE();
	}

	func_3DF4();
	scripts\sp\_utility::func_16B7(::scripts\sp\_gameskill::func_2627);
	if(isdefined(self.var_ED3A))
	{
		self.var_BC = self.var_ED3A;
	}
}

//Function Number: 49
func_3DF4()
{
	var_00["crew"] = 1;
	var_00["no_boost"] = 1;
	if(isdefined(self.var_111A4) && isdefined(var_00[self.var_111A4]))
	{
		self method_8504(0,"soldier_boost");
	}
}

//Function Number: 50
func_107EF()
{
	func_107ED();
	func_3DF4();
}

//Function Number: 51
func_107EE()
{
	func_3DF4();
}

//Function Number: 52
func_10804()
{
}

//Function Number: 53
func_10803()
{
	self.var_C05C = 1;
	self.var_2894 = 1000;
	self.var_50 = 0.1;
}

//Function Number: 54
func_107F4()
{
	scripts\sp\_gameskill::func_4FE9();
	scripts\sp\_gameskill::func_163();
}

//Function Number: 55
func_19BB()
{
	if(!isalive(self))
	{
		return;
	}

	if(self.health <= 1)
	{
		return;
	}

	self method_81D6();
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	self method_81D5();
}

//Function Number: 56
func_107F5()
{
	if(isdefined(self.var_ED6B))
	{
		self.var_596C = 1;
		self.var_ED6B = undefined;
	}

	if(isdefined(self.var_ED48))
	{
		thread func_1936();
	}

	if(isdefined(self.var_ECFD))
	{
		self.var_50 = self.var_ECFD;
		self.var_ECFD = undefined;
	}

	if(isdefined(self.var_EECC))
	{
		thread func_10CC6();
		self.var_EECC = undefined;
	}

	if(isdefined(self.var_ED4B))
	{
		thread func_4E72();
	}

	if(isdefined(self.var_EE62))
	{
		scripts\sp\_utility::func_558D();
		self.var_EE62 = undefined;
	}

	if(isdefined(self.var_EE57))
	{
		self.var_10264 = 1;
		self.var_EE57 = undefined;
	}

	if(isdefined(self.var_ECF8))
	{
		self.var_1FBB = self.var_ECF8;
		self.var_ECF8 = undefined;
	}

	if(isdefined(self.var_EDFC))
	{
		thread func_19BB();
	}

	if(isdefined(self.var_ED42))
	{
		var_00 = self.var_ED42;
		if(var_00 == 1)
		{
			var_00 = 8;
		}

		scripts\sp\_utility::func_61EB(var_00);
	}

	if(isdefined(self.var_ED89))
	{
		self.var_1D0 = self.var_ED89;
	}
	else if(!self.var_2A6)
	{
		self.var_1D0 = 512;
	}

	if(isdefined(self.var_EDAD))
	{
		scripts\sp\_utility::func_F3B5(self.var_EDAD);
	}

	if(isdefined(self.var_595C))
	{
		self.var_102 = 0;
	}

	if(isdefined(self.var_ED99))
	{
		self.var_132 = self.var_ED99 == 1;
		self.var_ED99 = undefined;
	}
	else
	{
		self.var_132 = self.team == "allies";
	}

	if(isdefined(self.var_EE54) && self.var_EE54 == 1)
	{
		self.var_C010 = 1;
		self.var_EE54 = undefined;
	}

	self.var_251 = self.team == "allies" && self.var_132;
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "mgpair")
	{
		thread scripts\sp\_mg_penetration::func_491C();
	}

	if(isdefined(self.var_EDCF) && !(isdefined(self.var_EE2B) && self.var_EE2B == 1) || isdefined(self.var_EED1))
	{
		thread func_F3DE();
	}

	if(isdefined(self.var_EEE2))
	{
		self method_834E(self.var_EEE2);
	}
	else if(self.team == "neutral")
	{
		self method_834E("civilian");
	}
	else
	{
		self method_834E(self.team);
	}

	if(isdefined(self.var_ED17))
	{
		scripts\sp\_utility::func_F2DA(self.var_ED17);
	}

	if(isdefined(self.var_ECE5))
	{
		self.var_2894 = self.var_ECE5;
		self.var_ECE5 = undefined;
	}

	if(isdefined(self.var_EDE4))
	{
		self.ignoreme = 1;
		self.var_EDE4 = undefined;
	}

	if(isdefined(self.var_EDE2))
	{
		self.var_186 = 1;
		self.var_EDE2 = undefined;
	}

	if(isdefined(self.var_EDE3))
	{
		self.var_180 = 1;
		self method_8071();
	}

	if(isdefined(self.var_EE55))
	{
		self.var_C012 = 1;
		self.var_EE55 = undefined;
	}

	if(isdefined(self.var_ED90))
	{
		if(self.var_ED90 == "player")
		{
			self.var_12E = level.player;
			level.player.var_336 = "player";
		}
	}

	if(isdefined(self.var_EEAA))
	{
		self.maxsightdistsqrd = self.var_EEAA;
		self.var_EEAA = undefined;
	}

	if(isdefined(self.var_ED92))
	{
		self.var_231 = self.var_ED92;
		self.var_ED92 = undefined;
	}

	if(isdefined(self.var_EE10))
	{
		self.var_232 = self.var_EE10;
		self.var_EE10 = undefined;
	}

	if(isdefined(self.var_EE05))
	{
		self.var_1491.var_55FC = 1;
		self.var_EE05 = undefined;
	}

	if(isdefined(self.var_ED5A))
	{
		self.var_EF = 1;
		self.var_ED5A = undefined;
	}

	if(isdefined(self.var_EE5F))
	{
		self.var_C089 = 1;
		self.var_EE5F = undefined;
	}

	if(isdefined(self.var_EE71))
	{
		self.var_223 = 1;
		self.var_EE71 = undefined;
	}

	if(isdefined(self.var_ED22))
	{
		scripts\sp\_utility::func_B14F();
		self.var_ED22 = undefined;
	}

	if(isdefined(self.var_EEC8))
	{
		self.health = self.var_EEC8;
		self.var_EEC8 = undefined;
	}

	if(isdefined(self.var_EE5A))
	{
		self.var_C05C = self.var_EE5A;
		self.var_EE5A = undefined;
	}

	if(isdefined(self.var_ED56))
	{
		scripts\sp\_utility::func_51E1(self.var_ED56);
		self.var_ED56 = undefined;
	}

	if(scripts\sp\_utility::func_93A6() && self.team == "axis")
	{
		self.var_2894 = self.var_2894 * 3.25;
		self.accuracy = self.accuracy * 3.25;
	}
}

//Function Number: 57
func_10662()
{
	if(isdefined(self.var_EEA6))
	{
		self.var_3135.var_72DD = gettime() + self.var_EEA6 * 1000;
		self.var_EEA6 = undefined;
		return;
	}

	if(isdefined(self.var_EEA5))
	{
		self.var_3135.var_72DD = 1;
		self.var_EEA5 = undefined;
	}
}

//Function Number: 58
func_107F3(param_00)
{
	thread func_1931();
	thread func_114E6();
	if(!isdefined(level.var_193D))
	{
		self method_83BC();
	}

	self.var_1086A = undefined;
	if(!isdefined(self.var_12BA3))
	{
		scripts\sp\_utility::func_F294();
	}

	thread func_4E47();
	level thread scripts\sp\_friendlyfire::func_73B1(self);
	self.var_391 = 16;
	func_9709();
	func_107F4();
	func_107F5();
	switch(self.var_12BA4)
	{
		case "c6":
			func_10662();
			break;
	}

	[[ level.var_115BE[self.team] ]]();
	if(isdefined(level.var_12BA5[self.var_12BA4]))
	{
		self thread [[ level.var_12BA5[self.var_12BA4] ]]();
	}

	thread scripts\sp\_damagefeedback::func_B9C6();
	func_F3D8();
	if(isdefined(self.var_EE87))
	{
		self method_82ED(level.player);
		return;
	}

	if(isdefined(self.var_EED1))
	{
		lib_0F18::func_10E8B("do_stealth");
		return;
	}

	if(isdefined(self.var_EE7E) && !isdefined(self.var_EE2B))
	{
		thread scripts\sp\_patrol::func_C97C();
		return;
	}

	if(isdefined(self.var_EE93) && self.var_EE93 == 1)
	{
		scripts\sp\_utility::func_622F();
	}

	if(isdefined(self.var_ED53))
	{
		if(!isdefined(self.var_EE8F))
		{
			self.var_15C = 800;
		}

		self method_82ED(level.player);
		level thread func_50F5(self);
		return;
	}

	if(isdefined(self.var_1305C))
	{
		return;
	}

	if(isdefined(self.var_EE2B) && self.var_EE2B == 1)
	{
		func_F3D7();
		self method_82EF(self.origin);
		return;
	}

	if(!isdefined(self.var_EED1))
	{
	}

	func_F3D7();
	if(isdefined(self.target))
	{
		thread func_8409();
	}
}

//Function Number: 59
func_9709()
{
	scripts\sp\_utility::func_F340();
	if(isdefined(self.var_EDD2))
	{
		self.var_162 = self.var_EDD2;
	}
	else
	{
		self.var_162 = 3;
	}

	if(isdefined(self.var_D8E1))
	{
		self.noattackeraccuracymod = scripts\anim\utility_common::func_9D4D();
	}

	self.var_BEFA = 1;
}

//Function Number: 60
func_EF8C()
{
	if(self.team == "neutral")
	{
		self method_834E("civilian");
	}
	else
	{
		self method_834E(self.team);
	}

	func_9709();
	self.var_2894 = 1;
	scripts\sp\_gameskill::func_163();
	scripts\sp\_utility::func_414F();
	self.var_190 = 96;
	self.var_55B0 = undefined;
	self.ignoreme = 0;
	self.var_180 = 0;
	self.var_33F = 0;
	self.var_223 = 0;
	self.var_224 = 20;
	self.var_185 = 0;
	self.var_253 = 1;
	self.var_282 = 1;
	self.var_30 = 0;
	self.var_40 = 540;
	self.var_5E = 0.75;
	self.var_FE = 0;
	self.var_101 = 1;
	self.var_102 = 1;
	self.var_15C = level.var_4FF6;
	self.var_15A = level.var_4FF5;
	self.var_186 = 0;
	self method_8250(0);
	if(isdefined(self.var_B14F) && self.var_B14F)
	{
		scripts\sp\_utility::func_1101B();
	}

	scripts\sp\_utility::func_5575();
	self.maxsightdistsqrd = 67108864;
	self.var_EDB1 = 0;
	self.var_391 = 16;
	self.var_253 = 1;
	self.var_282 = 1;
	scripts\anim\init::func_F2B0();
	self.var_132 = self.team == "allies";
}

//Function Number: 61
func_50F5(param_00)
{
	param_00 endon("death");
	while(isalive(param_00))
	{
		if(param_00.var_15C > 200)
		{
			param_00.var_15C = param_00.var_15C - 200;
		}

		wait(6);
	}
}

//Function Number: 62
func_6E4B(param_00)
{
	self endon("death");
	if(!self.var_6E66)
	{
		param_00.var_1305C = 1;
		self.var_6E66 = 1;
		param_00 waittill("death");
		self.var_6E66 = 0;
		self notify("get new user");
	}
}

//Function Number: 63
func_F3DE()
{
	self endon("death");
	waittillframeend;
	if(isdefined(self.team) && self.team == "allies")
	{
		self.var_132 = 0;
	}

	var_00 = level.var_8438[self.var_EDCF];
	if(!isdefined(var_00))
	{
		return;
	}

	if(isdefined(var_00.target))
	{
		var_01 = function_00B3(var_00.target,"targetname");
		var_02 = getent(var_00.target,"targetname");
		var_03 = scripts\common\utility::getstruct(var_00.target,"targetname");
		var_04 = undefined;
		if(isdefined(var_01))
		{
			var_04 = var_01;
			self method_82EE(var_04);
		}
		else if(isdefined(var_02))
		{
			var_04 = var_02;
			self method_82EF(var_04.origin);
		}
		else if(isdefined(var_03))
		{
			var_04 = var_03;
			self method_82EF(var_04.origin);
		}

		if(isdefined(var_04.var_257) && var_04.var_257 != 0)
		{
			self.var_15C = var_04.var_257;
		}

		if(isdefined(var_04.var_15A) && var_04.var_15A != 0)
		{
			self.var_15A = var_04.var_15A;
		}
	}

	if(isdefined(self.target))
	{
		self method_82F0(var_00);
		return;
	}

	self method_82F1(var_00);
}

//Function Number: 64
func_7CDA(param_00)
{
	var_01 = function_00B4(param_00,"targetname");
	var_02 = scripts\common\utility::getstructarray(param_00,"targetname");
	foreach(var_04 in var_02)
	{
		var_01[var_01.size] = var_04;
	}

	var_02 = getentarray(param_00,"targetname");
	foreach(var_04 in var_02)
	{
		if(isspawner(var_04) || var_04.var_9F == "trigger_multiple" || var_04.var_9F == "trigger_once" || var_04.var_9F == "trigger_radius")
		{
			continue;
		}

		var_01[var_01.size] = var_04;
	}

	return var_01;
}

//Function Number: 65
func_C035(param_00)
{
	return isdefined(param_00.var_257) && param_00.var_257 != 0;
}

//Function Number: 66
func_8409(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(self.var_1305C))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		var_05 = func_7CDA(self.target);
		if(var_05.size == 0)
		{
			self notify("reached_path_end");
			return;
		}
	}
	else if(isarray(param_01))
	{
		var_05 = param_01;
	}
	else
	{
		param_00[0] = param_01;
	}

	func_8414(var_05,param_02,param_03,param_04);
}

//Function Number: 67
func_7A7B(param_00)
{
	if(param_00.size == 1)
	{
		return param_00[0];
	}

	param_00 = scripts\common\utility::array_randomize(param_00);
	var_01 = param_00[0];
	if(!isdefined(var_01.var_13070))
	{
		var_01.var_13070 = 0;
	}

	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03.var_13070))
		{
			var_03.var_13070 = 0;
		}

		if(var_03.var_13070 < var_01.var_13070)
		{
			var_01 = var_03;
		}
	}

	var_01.var_13070 = gettime();
	return var_01;
}

//Function Number: 68
func_8414(param_00,param_01,param_02,param_03)
{
	self notify("stop_going_to_node");
	self endon("stop_going_to_node");
	self endon("death");
	var_04 = scripts\common\utility::func_116D7(isdefined(param_02),param_02,300);
	for(;;)
	{
		param_00 = func_7A7B(param_00);
		if(isdefined(param_00.var_EE95))
		{
			if(param_00.var_EE95 > 1)
			{
				var_04 = param_00.var_EE95;
			}

			param_00.var_EE95 = 0;
		}

		if(func_C035(param_00))
		{
			self.var_15C = param_00.var_257;
		}

		if(isdefined(param_00.height))
		{
			self.var_15A = param_00.height;
		}

		if(isdefined(param_00.var_ED56))
		{
			scripts\sp\_utility::func_51E1(param_00.var_ED56);
		}

		if(isdefined(param_00.var_EE71))
		{
			self.var_223 = param_00.var_EE71;
		}

		if(isdefined(param_00.var_EDE3))
		{
			self.var_180 = param_00.var_EDE3;
		}

		if(isdefined(param_00.var_EDE4))
		{
			self.ignoreme = param_00.var_EDE4;
		}

		if(isdefined(self.var_10E6D))
		{
			lib_0F18::func_10E8A("go_to_node_wait",::func_840F,param_00);
		}
		else
		{
			func_840F(param_00);
			self waittill("goal");
		}

		param_00 notify("trigger",self);
		if(isdefined(self.var_10E6D))
		{
			lib_0F18::func_10E8A("go_to_node_arrive",::func_840F,param_00);
		}

		if(isdefined(param_01))
		{
			[[ param_01 ]](param_00);
		}

		if(isdefined(param_00.var_ED9E))
		{
			scripts\common\utility::flag_set(param_00.var_ED9E);
		}

		if(isdefined(param_00.var_ED80))
		{
			scripts\sp\_utility::func_65E1(param_00.var_ED80);
		}

		if(isdefined(param_00.var_ED9B))
		{
			scripts\common\utility::func_6E2A(param_00.var_ED9B);
		}

		if(func_1157F(param_00))
		{
			return 1;
		}

		param_00 scripts\sp\_utility::script_delay();
		if(isdefined(param_00.var_EEB1))
		{
			self playsound(param_00.var_EEB1);
		}

		if(isdefined(param_00.var_EDC7))
		{
			thread scripts\sp\_utility::func_77B7(param_00.var_EDC7);
		}

		if(isdefined(param_00.var_EDA0))
		{
			scripts\common\utility::flag_wait(param_00.var_EDA0);
		}

		if(isdefined(param_00.var_ED81))
		{
			scripts\sp\_utility::func_65E3(param_00.var_ED81);
		}

		param_00 scripts\sp\_utility::func_EF15();
		if(isdefined(self.var_D6EE))
		{
			[[ self.var_D6EE ]]();
		}

		if(isdefined(param_00.var_ED51))
		{
			wait(param_00.var_ED51);
		}

		while(isdefined(param_00.var_EE95))
		{
			param_00.var_EE95 = 0;
			if(func_8416(param_00,::func_7CDA,var_04))
			{
				param_00.var_EE95 = 1;
				param_00 notify("script_requires_player");
				break;
			}

			wait(0.1);
		}

		if(isdefined(param_00.var_ED57))
		{
			scripts\sp\_utility::func_51E1(param_00.var_ED57);
		}

		if(isdefined(param_03))
		{
			[[ param_03 ]](param_00);
		}

		if(isdefined(param_00.var_ED43) && param_00.var_ED43)
		{
			scripts\sp\_utility::func_54C6();
		}

		if(isdefined(param_00.var_ED54) && param_00.var_ED54)
		{
			if(isdefined(self.var_B14F))
			{
				scripts\sp\_utility::func_1101B();
			}

			self delete();
		}

		if(!isdefined(param_00.target))
		{
			break;
		}

		var_05 = func_7CDA(param_00.target);
		if(!var_05.size)
		{
			break;
		}

		param_00 = var_05;
	}

	self notify("reached_path_end");
	if(isdefined(self.var_EDB0))
	{
		return;
	}

	if(isdefined(self.var_527B) && self.var_527B == "patrol")
	{
		return;
	}

	if(isdefined(self method_812A()))
	{
		self method_82F1(self method_812A());
		return;
	}

	self.var_15C = level.var_4FF6;
}

//Function Number: 69
func_8416(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		if(distancesquared(var_04.origin,param_00.origin) < distancesquared(self.origin,param_00.origin))
		{
			return 1;
		}
	}

	if(!isdefined(param_00.var_ED5F))
	{
		var_06 = anglestoforward(self.angles);
		if(isdefined(param_00.target))
		{
			var_07 = [[ param_01 ]](param_00.target);
			if(var_07.size == 1)
			{
				var_06 = vectornormalize(var_07[0].origin - param_00.origin);
			}
			else if(isdefined(param_00.angles))
			{
				var_06 = anglestoforward(param_00.angles);
			}
		}
		else if(isdefined(param_00.angles))
		{
			var_06 = anglestoforward(param_00.angles);
		}

		var_08 = [];
		foreach(var_04 in level.players)
		{
			var_08[var_08.size] = vectornormalize(var_04.origin - self.origin);
		}

		foreach(var_0C in var_08)
		{
			if(vectordot(var_06,var_0C) > 0)
			{
				return 1;
			}
		}
	}

	var_0E = param_02 * param_02;
	foreach(var_04 in level.players)
	{
		if(distancesquared(var_04.origin,self.origin) < var_0E)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 70
func_8413(param_00)
{
	if(!isdefined(param_00))
	{
		return 1;
	}

	if(!isdefined(param_00.target))
	{
		return 1;
	}

	if(isdefined(param_00.script_delay))
	{
		return 1;
	}

	if(isdefined(param_00.var_EF15))
	{
		return 1;
	}

	if(isdefined(param_00.var_EF1A))
	{
		return 1;
	}

	if(isdefined(param_00.var_EF1C))
	{
		return 1;
	}

	if(isdefined(param_00.var_EF1B))
	{
		return 1;
	}

	if(isdefined(param_00.var_EDA0))
	{
		return 1;
	}

	if(isdefined(param_00.var_ED81))
	{
		return 1;
	}

	if(isdefined(param_00.var_ED51))
	{
		return 1;
	}

	if(isdefined(param_00.var_EE95))
	{
		return 1;
	}

	return 0;
}

//Function Number: 71
func_840F(param_00)
{
	if(function_02A7(param_00))
	{
		func_8411(param_00);
	}
	else if(function_02A4(param_00))
	{
		func_8412(param_00);
	}
	else if(function_02A6(param_00))
	{
		func_8410(param_00);
	}

	if(function_02A4(param_00) || function_02A7(param_00))
	{
		param_00.var_C9A7 = func_8413(param_00);
	}
}

//Function Number: 72
func_8410(param_00)
{
	if(param_00.classname == "info_volume")
	{
		self method_82F1(param_00);
		self notify("go_to_node_new_goal");
		return;
	}

	func_8412(param_00);
}

//Function Number: 73
func_8412(param_00)
{
	scripts\sp\_utility::func_F3D3(param_00);
	self notify("go_to_node_new_goal");
}

//Function Number: 74
func_8411(param_00)
{
	scripts\sp\_utility::func_F3D9(param_00);
	self notify("go_to_node_new_goal");
}

//Function Number: 75
func_1157F(param_00)
{
	if(!isdefined(param_00.target))
	{
		return 0;
	}

	var_01 = getentarray(param_00.target,"targetname");
	if(!var_01.size)
	{
		return 0;
	}

	var_02 = var_01[0];
	if(!issubstr(var_02.classname,"misc_turret"))
	{
		return 0;
	}

	thread func_12F9C(var_02);
	return 1;
}

//Function Number: 76
func_F3D8()
{
	if(isdefined(self.var_EDCD))
	{
		self.var_15A = self.var_EDCD;
		return;
	}

	self.var_15A = level.var_4FF5;
}

//Function Number: 77
func_F3D7(param_00)
{
	if(isdefined(self.var_EE8F))
	{
		self.var_15C = self.var_EE8F;
		return;
	}

	if(isdefined(self.var_EDB0))
	{
		if(isdefined(param_00) && isdefined(param_00.var_257))
		{
			self.var_15C = param_00.var_257;
			return;
		}
	}

	if(!isdefined(self method_812A()))
	{
		if(self.type == "civilian")
		{
			self.var_15C = 128;
			return;
		}

		self.var_15C = level.var_4FF6;
	}
}

//Function Number: 78
func_2697(param_00)
{
	for(;;)
	{
		var_01 = self method_8165();
		if(!isalive(var_01))
		{
			wait(1.5);
			continue;
		}

		if(!isdefined(var_01.var_10C))
		{
			self method_8347(scripts\common\utility::random(param_00));
			self notify("startfiring");
			self method_8398();
		}

		wait(2 + randomfloat(1));
	}
}

//Function Number: 79
func_B321(param_00)
{
	for(;;)
	{
		self method_8347(scripts\common\utility::random(param_00));
		self notify("startfiring");
		self method_8398();
		wait(2 + randomfloat(1));
	}
}

//Function Number: 80
func_12F9C(param_00)
{
	self endon("stop_using_turret");
	self endon("death");
	if(self method_8198() && self.health == 150)
	{
		self.health = 100;
		self.var_1491.var_55FC = 1;
	}

	lib_0A1B::func_296E(param_00);
	while(!isdefined(self method_8164()) || self method_8164() != param_00)
	{
		wait(0.05);
	}

	if(isdefined(param_00.target) && param_00.target != param_00.var_336)
	{
		var_01 = getentarray(param_00.target,"targetname");
		var_02 = [];
		for(var_03 = 0;var_03 < var_01.size;var_03++)
		{
			if(var_01[var_03].classname == "script_origin")
			{
				var_02[var_02.size] = var_01[var_03];
			}
		}

		if(isdefined(param_00.var_ED0F))
		{
			param_00 thread func_2697(var_02);
		}
		else if(isdefined(param_00.var_EE07))
		{
			param_00 method_830F("manual_ai");
			param_00 thread func_B321(var_02);
		}
		else if(var_02.size > 0)
		{
			if(var_02.size == 1)
			{
				param_00.var_B319 = var_02[0];
				param_00 method_8347(var_02[0]);
				thread scripts\sp\_mgturret::func_B31A(param_00);
			}
			else
			{
				param_00 thread scripts\sp\_mgturret::func_B6A8(var_02);
			}
		}
	}

	thread func_D31C(param_00);
	thread scripts\sp\_mgturret::func_B6A3(param_00);
	param_00 notify("startfiring");
}

//Function Number: 81
func_D31C(param_00)
{
	self endon("death");
	if(self.team != "allies")
	{
		return;
	}

	var_01 = spawn("trigger_radius",param_00.origin,0,56,56);
	thread scripts\common\utility::func_5179(var_01);
	var_02 = 0;
	while(!var_02)
	{
		var_01 waittill("trigger");
		while(level.player istouching(var_01))
		{
			if(level.player usebuttonpressed())
			{
				var_02 = 1;
				break;
			}

			wait(0.05);
		}
	}

	var_01 delete();
	func_11054();
}

//Function Number: 82
func_11054()
{
	self notify("stop_using_turret");
	self notify("stop_using_built_in_burst_fire");
	var_00 = self method_8164();
	if(!isdefined(var_00))
	{
		return;
	}

	self method_83AF();
	lib_0A1B::func_296E(undefined);
	self method_83A1();
	var_00 method_83A3();
}

//Function Number: 83
func_73D9(param_00)
{
	var_01 = function_00B3(param_00.target,"targetname");
	var_02 = getent(var_01.target,"targetname");
	var_02 method_830F("auto_ai");
	var_02 method_807E();
	var_03 = 0;
	for(;;)
	{
		param_00 waittill("trigger",var_04);
		if(!isai(var_04))
		{
			continue;
		}

		if(!isdefined(var_04.team))
		{
			continue;
		}

		if(var_04.team != "allies")
		{
			continue;
		}

		if(isdefined(var_04.var_EF00) && var_04.var_EF00 == 0)
		{
			continue;
		}

		if(var_04 thread func_73D7(var_02,var_01))
		{
			var_04 thread func_73D6(var_02,var_01);
			var_02 waittill("friendly_finished_using_mg42");
			if(isalive(var_04))
			{
				var_04.var_12A4D = gettime() + 10000;
			}
		}

		wait(1);
	}
}

//Function Number: 84
func_73D2(param_00,param_01)
{
	param_01 endon("friendly_finished_using_mg42");
	param_00 waittill("death");
	param_01 notify("friendly_finished_using_mg42");
}

//Function Number: 85
func_73D8(param_00)
{
	param_00 endon("friendly_finished_using_mg42");
	self.var_369 = 1;
	self setcursorhint("HINT_NOICON");
	self sethintstring(&"PLATFORM_USEAIONMG42");
	self waittill("trigger");
	self.var_369 = 0;
	self sethintstring("");
	self method_83AF();
	self notify("stopped_use_turret");
	param_00 notify("friendly_finished_using_mg42");
}

//Function Number: 86
func_73D7(param_00,param_01)
{
	if(self.var_369)
	{
		return 0;
	}

	if(isdefined(self.var_12A4D) && gettime() < self.var_12A4D)
	{
		return 0;
	}

	if(distance(level.player.origin,param_01.origin) < 100)
	{
		return 0;
	}

	return 1;
}

//Function Number: 87
func_73D4(param_00,param_01)
{
	param_00 endon("friendly_finished_using_mg42");
	self waittill("trigger");
	param_00 notify("friendly_finished_using_mg42");
}

//Function Number: 88
func_73D5()
{
	if(!isdefined(self.var_73D0))
	{
		return;
	}

	self.var_73D0 notify("friendly_finished_using_mg42");
}

//Function Number: 89
func_C05F()
{
	self endon("death");
	self waittill("goal");
	self.var_15C = self.var_C402;
	if(self.var_15C < 32)
	{
		self.var_15C = 400;
	}
}

//Function Number: 90
func_73D6(param_00,param_01)
{
	self endon("death");
	param_00 endon("friendly_finished_using_mg42");
	level thread func_73D2(self,param_00);
	self.var_C402 = self.var_15C;
	self.var_15C = 28;
	thread func_C05F();
	self method_82EE(param_01);
	self.var_186 = 1;
	self waittill("goal");
	self.var_15C = self.var_C402;
	if(self.var_15C < 32)
	{
		self.var_15C = 400;
	}

	self.var_186 = 0;
	self.var_15C = self.var_C402;
	if(distance(level.player.origin,param_01.origin) < 32)
	{
		param_00 notify("friendly_finished_using_mg42");
		return;
	}

	self.var_73D0 = param_00;
	thread func_73D8(param_00);
	thread func_73D1(param_00);
	self method_83D7(param_00);
	if(isdefined(param_00.target))
	{
		var_02 = getent(param_00.target,"targetname");
		if(isdefined(var_02))
		{
			var_02 thread func_73D4(param_00,self);
		}
	}

	for(;;)
	{
		if(distance(self.origin,param_01.origin) < 32)
		{
			self method_83D7(param_00);
		}
		else
		{
			break;
		}

		wait(1);
	}

	param_00 notify("friendly_finished_using_mg42");
}

//Function Number: 91
func_73D1(param_00)
{
	self endon("death");
	param_00 waittill("friendly_finished_using_mg42");
	func_73D3();
}

//Function Number: 92
func_73D3()
{
	self endon("death");
	var_00 = self.var_73D0;
	self.var_73D0 = undefined;
	self method_83AF();
	self notify("stopped_use_turret");
	self.var_369 = 0;
	self.var_15C = self.var_C402;
	if(!isdefined(var_00))
	{
		return;
	}

	if(!isdefined(var_00.target))
	{
		return;
	}

	var_01 = function_00B3(var_00.target,"targetname");
	var_02 = self.var_15C;
	self.var_15C = 8;
	self method_82EE(var_01);
	wait(2);
	self.var_15C = 384;
	self waittill("goal");
	if(isdefined(self.target))
	{
		var_01 = function_00B3(self.target,"targetname");
		if(isdefined(var_01.target))
		{
			var_01 = function_00B3(var_01.target,"targetname");
		}

		if(isdefined(var_01))
		{
			self method_82EE(var_01);
		}
	}

	self.var_15C = var_02;
}

//Function Number: 93
func_114E6()
{
	if(isdefined(level.var_C0B5))
	{
		return;
	}

	if(isdefined(level.var_131A0.var_8BBA) && !level.var_131A0.var_8BBA)
	{
		return;
	}

	scripts\sp\_utility::func_16B7(::func_114E7);
}

//Function Number: 94
func_114E7(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(self))
	{
		return;
	}

	if(isalive(self))
	{
		return;
	}

	if(!isalive(param_01))
	{
		return;
	}

	if(!isdefined(param_01.var_380))
	{
		return;
	}

	if(param_01 scripts\sp\_vehicle::func_9E2C())
	{
		return;
	}

	if(!isdefined(self.var_C089))
	{
		if(isdefined(self.var_71C8))
		{
			self [[ self.var_71C8 ]]();
		}

		self method_839A();
	}

	if(!isdefined(self))
	{
		return;
	}

	scripts\sp\_utility::func_DFE6(::func_114E7);
}

//Function Number: 95
func_6F4C(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "instant_respawn")
	{
		param_00 = 1;
	}

	level.var_10881 = [];
	var_01 = function_00C8(self.target);
	scripts\common\utility::array_thread(var_01,::func_6F50,param_00);
	var_02 = 0;
	var_03 = 0;
	for(;;)
	{
		self waittill("trigger",var_04);
		if(!var_03)
		{
			var_03 = 1;
			scripts\sp\_utility::script_delay();
		}

		if(self istouching(level.player))
		{
			var_02 = 1;
		}
		else
		{
			if(!isalive(var_04))
			{
				continue;
			}

			if(isplayer(var_04))
			{
				var_02 = 1;
			}
			else if(!isdefined(var_04.var_9F73) || !var_04.var_9F73)
			{
				continue;
			}
		}

		var_01 = function_00C8(self.target);
		if(isdefined(var_01[0]))
		{
			if(isdefined(var_01[0].var_EE91))
			{
				func_4B09(var_01[0].var_EE91);
			}
		}

		var_01 = function_00C8(self.target);
		for(var_05 = 0;var_05 < var_01.size;var_05++)
		{
			var_01[var_05].var_D43F = var_02;
			var_01[var_05] notify("flood_begin");
		}

		if(var_02)
		{
			wait(5);
			continue;
		}

		wait(0.1);
	}
}

//Function Number: 96
func_6F50(param_00)
{
	if(isdefined(self.var_F0DC))
	{
		return;
	}

	self.var_F0DC = 1;
	self.var_127CC = 1;
	var_01 = self.target;
	var_02 = self.var_336;
	if(!isdefined(var_01) && !isdefined(self.var_EE2B))
	{
		waittillframeend;
	}

	var_03 = [];
	if(isdefined(var_01))
	{
		var_04 = function_00C8(var_01);
		for(var_05 = 0;var_05 < var_04.size;var_05++)
		{
			if(!issubstr(var_04[var_05].classname,"actor"))
			{
				continue;
			}

			var_03[var_03.size] = var_04[var_05];
		}
	}

	var_06 = spawnstruct();
	var_07 = self.origin;
	func_6F51(var_06,var_03.size > 0,param_00);
	if(isalive(var_06.var_1912))
	{
		var_06.var_1912 waittill("death");
	}

	if(!isdefined(var_01))
	{
		return;
	}

	var_04 = function_00C8(var_01);
	if(!var_04.size)
	{
		return;
	}

	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		if(!issubstr(var_04[var_05].classname,"actor"))
		{
			continue;
		}

		var_04[var_05].var_336 = var_02;
		var_08 = var_01;
		if(isdefined(var_04[var_05].target))
		{
			var_09 = getspawner(var_04[var_05].target,"targetname");
			if(!isdefined(var_09) || !issubstr(var_09.classname,"actor"))
			{
				var_08 = var_04[var_05].target;
			}
		}

		var_04[var_05].target = var_08;
		var_04[var_05] thread func_6F50(param_00);
		var_04[var_05].var_D43F = 1;
		var_04[var_05] notify("flood_begin");
	}
}

//Function Number: 97
func_6F51(param_00,param_01,param_02)
{
	self endon("death");
	var_03 = self.var_C1;
	if(!param_01)
	{
		param_01 = isdefined(self.script_noteworthy) && self.script_noteworthy == "delete";
	}

	scripts\sp\_utility::func_F311(2);
	if(isdefined(self.script_delay))
	{
		var_04 = self.script_delay;
	}
	else
	{
		var_04 = 0;
	}

	for(;;)
	{
		self waittill("flood_begin");
		if(self.var_D43F)
		{
			break;
		}

		if(var_04)
		{
			continue;
		}

		break;
	}

	var_05 = distance(level.player.origin,self.origin);
	while(var_03)
	{
		self.var_12844 = var_03;
		scripts\sp\_utility::func_F311(2);
		wait(var_04);
		var_06 = isdefined(self.var_EED1) && scripts\common\utility::flag("stealth_enabled") && !scripts\common\utility::flag("stealth_spotted");
		if(isdefined(self.var_EDB3))
		{
			var_07 = self method_8393(var_06);
		}
		else
		{
			var_07 = self method_80B5(var_06);
		}

		if(scripts\sp\_utility::func_106ED(var_07))
		{
			var_08 = 0;
			if(var_04 < 2)
			{
				wait(2);
			}

			continue;
		}
		else
		{
			if(isdefined(self.var_ED39))
			{
				if(self.var_ED39 == "heat")
				{
					var_07 scripts\sp\_utility::func_61FF();
				}

				if(self.var_ED39 == "cqb")
				{
					var_07 scripts\sp\_utility::func_61E7();
				}
			}

			thread func_1865(var_07);
			var_07 thread func_6F4D(self);
			if(isdefined(self.var_ECE5))
			{
				var_07.var_2894 = self.var_ECE5;
			}

			param_00.var_1912 = var_07;
			param_00 notify("got_ai");
			self waittill("spawn_died",var_09,var_08);
			if(var_04 > 2)
			{
				var_04 = randomint(4) + 2;
			}
			else
			{
				var_04 = 0.5 + randomfloat(0.5);
			}
		}

		if(var_09)
		{
			func_13840(var_05);
			continue;
		}

		if(func_D462(var_08 || param_01,param_00.var_1912))
		{
			var_03--;
		}

		if(!param_02)
		{
			func_13851();
		}
	}

	self delete();
}

//Function Number: 98
func_1382E(param_00)
{
	self endon("death");
	param_00 waittill("death");
}

//Function Number: 99
func_1865(param_00)
{
	var_01 = self.var_336;
	if(!isdefined(level.var_10881[var_01]))
	{
		level.var_10881[var_01] = spawnstruct();
		level.var_10881[var_01] scripts\sp\_utility::func_F311(0);
		level.var_10881[var_01].var_11A1D = 0;
	}

	if(!isdefined(self.var_17C5))
	{
		self.var_17C5 = 1;
		level.var_10881[var_01].var_11A1D++;
	}

	level.var_10881[var_01].var_C1++;
	func_1382E(param_00);
	level.var_10881[var_01].var_C1--;
	if(!isdefined(self))
	{
		level.var_10881[var_01].var_11A1D--;
	}

	if(level.var_10881[var_01].var_11A1D)
	{
		if(level.var_10881[var_01].var_C1 / level.var_10881[var_01].var_11A1D < 0.32)
		{
			level.var_10881[var_01] notify("waveReady");
		}
	}
}

//Function Number: 100
func_13851()
{
	var_00 = self.var_336;
	if(level.var_10881[var_00].var_C1)
	{
		level.var_10881[var_00] waittill("waveReady");
	}
}

//Function Number: 101
func_D462(param_00,param_01)
{
	if(param_00)
	{
		return 1;
	}

	if(isdefined(param_01) && isdefined(param_01.origin))
	{
		var_02 = param_01.origin;
	}
	else
	{
		var_02 = self.origin;
	}

	if(distance(level.player.origin,var_02) < 700)
	{
		return 1;
	}

	return bullettracepassed(level.player geteye(),param_01 geteye(),0,undefined);
}

//Function Number: 102
func_13840(param_00)
{
	self endon("flood_begin");
	param_00 = param_00 * 0.75;
	while(distance(level.player.origin,self.origin) > param_00)
	{
		wait(1);
	}
}

//Function Number: 103
func_6F4D(param_00)
{
	thread func_6F4E();
	self waittill("death",var_01);
	var_02 = isalive(var_01) && isplayer(var_01);
	if(!var_02 && isdefined(var_01) && var_01.classname == "worldspawn")
	{
		var_02 = 1;
	}

	var_03 = !isdefined(self);
	param_00 notify("spawn_died",var_03,var_02);
}

//Function Number: 104
func_6F4E()
{
	if(isdefined(self.var_EE2B))
	{
		return;
	}

	self endon("death");
	var_00 = function_00B3(self.target,"targetname");
	if(isdefined(var_00))
	{
		self method_82EE(var_00);
	}
	else
	{
		var_00 = getent(self.target,"targetname");
		if(isdefined(var_00))
		{
			self method_82EF(var_00.origin);
		}
	}

	if(isdefined(level.var_6BDF))
	{
		self.var_231 = level.var_6BDF;
		self.var_232 = level.var_B491;
	}

	if(isdefined(var_00.var_257) && var_00.var_257 >= 0)
	{
		self.var_15C = var_00.var_257;
	}
	else
	{
		self.var_15C = 256;
	}

	self waittill("goal");
	while(isdefined(var_00.target))
	{
		var_01 = function_00B3(var_00.target,"targetname");
		if(isdefined(var_01))
		{
			var_00 = var_01;
		}
		else
		{
			break;
		}

		self method_82EE(var_00);
		if(func_C035(var_00))
		{
			self.var_15C = var_00.var_257;
		}
		else
		{
			self.var_15C = 256;
		}

		self waittill("goal");
	}

	if(isdefined(self.script_noteworthy))
	{
		if(self.script_noteworthy == "delete")
		{
			self method_81D0();
			return;
		}
	}

	if(isdefined(var_00.target))
	{
		var_02 = getent(var_00.target,"targetname");
		if(isdefined(var_02) && var_02.var_9F == "misc_turret")
		{
			self method_82EE(var_00);
			self.var_15C = 4;
			self waittill("goal");
			if(!isdefined(self.var_EDB0))
			{
				self.var_15C = level.var_4FF6;
			}

			func_12F9C(var_02);
		}
	}

	if(isdefined(self.script_noteworthy))
	{
		if(self.script_noteworthy == "hide")
		{
			thread scripts\sp\_utility::func_F2DA(0);
			return;
		}
	}

	if(!isdefined(self.var_EDB0) && !isdefined(self method_812A()))
	{
		self.var_15C = level.var_4FF6;
	}
}

//Function Number: 105
func_8438()
{
	var_00 = getentarray("info_volume","classname");
	level.var_4E32 = [];
	level.var_8438 = [];
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		if(isdefined(var_02.var_ED47))
		{
			level.var_4E32[var_02.var_ED47] = var_02;
		}

		if(isdefined(var_02.var_EDCF))
		{
			level.var_8438[var_02.var_EDCF] = var_02;
		}
	}
}

//Function Number: 106
func_1A12(param_00)
{
	level.var_1162[param_00] = spawnstruct();
	level.var_1162[param_00].var_1A09 = 0;
	level.var_1162[param_00].var_1A0D = 0;
	level.var_1162[param_00].var_10878 = 0;
	level.var_1162[param_00].var_1912 = [];
	level.var_1162[param_00].var_1087B = [];
}

//Function Number: 107
func_1A17(param_00)
{
	self endon("death");
	self.var_4FC0 = 0;
	param_00.var_10878++;
	param_00.var_1087B = scripts\common\utility::array_add(param_00.var_1087B,self);
	thread func_1A15(param_00);
	thread func_1A16(param_00);
	while(self.var_C1)
	{
		self waittill("spawned",var_01);
		if(scripts\sp\_utility::func_106ED(var_01))
		{
			continue;
		}

		var_01 thread func_1A14(param_00);
	}

	waittillframeend;
	if(self.var_4FC0)
	{
		return;
	}

	self.var_4FC0 = 1;
	param_00.var_10878--;
}

//Function Number: 108
func_1A15(param_00)
{
	self waittill("death");
	if(isdefined(self) && self.var_4FC0)
	{
		return;
	}

	param_00.var_10878--;
}

//Function Number: 109
func_1A16(param_00)
{
	self endon("death");
	self waittill("emptied spawner");
	waittillframeend;
	if(self.var_4FC0)
	{
		return;
	}

	self.var_4FC0 = 1;
	param_00.var_10878--;
}

//Function Number: 110
func_1A14(param_00)
{
	param_00.var_1A09++;
	param_00.var_1912[param_00.var_1912.size] = self;
	if(isdefined(self.var_ED49))
	{
		func_1382D();
	}
	else
	{
		self waittill("death");
	}

	param_00.var_1A09--;
	param_00.var_1A0D++;
}

//Function Number: 111
func_37EC(param_00)
{
	var_01 = strtok(param_00.var_EE01," ");
	var_02 = [];
	var_03 = [];
	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		var_05 = var_01[var_04];
		var_06 = getspawner(var_05,"script_linkname");
		if(isdefined(var_06))
		{
			var_02 = scripts\common\utility::array_add_safe(var_02,var_06);
			continue;
		}

		var_07 = function_00B3(var_05,"script_linkname");
		if(!isdefined(var_07))
		{
			continue;
		}

		var_03 = scripts\common\utility::array_add_safe(var_03,var_07);
	}

	param_00 waittill("trigger");
	var_03 = scripts\common\utility::array_randomize(var_03);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_03[var_04].var_3FF2 = 0;
	}

	var_08 = 0;
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_09 = var_02[var_04];
		if(!isdefined(var_09))
		{
			continue;
		}

		if(isdefined(var_09.var_EEB3))
		{
			continue;
		}

		while(isdefined(var_03[var_08].script_noteworthy) && var_03[var_08].script_noteworthy == "dont_spawn")
		{
			var_08++;
		}

		var_09.origin = var_03[var_08].origin;
		var_09.angles = var_03[var_08].angles;
		var_09 scripts\sp\_utility::func_1747(::func_3FEF,var_03[var_08]);
		var_08++;
	}

	scripts\common\utility::array_thread(var_02,::scripts\sp\_utility::func_1747,::func_37E9);
	scripts\common\utility::array_thread(var_02,::scripts\sp\_utility::func_1747,::func_BC9F,var_03);
	scripts\common\utility::array_thread(var_02,::scripts\sp\_utility::func_10619);
}

//Function Number: 112
func_37E9()
{
	self.var_15C = 8;
	self.var_132 = 1;
}

//Function Number: 113
func_BC9F(param_00)
{
	self endon("death");
	var_01 = 0;
	for(;;)
	{
		if(!isalive(self.var_10C))
		{
			self waittill("enemy");
			var_01 = 0;
			continue;
		}

		if(isplayer(self.var_10C))
		{
			if(self.var_10C scripts\sp\_utility::func_65DB("player_has_red_flashing_overlay") || scripts\common\utility::flag("player_flashed"))
			{
				self.var_132 = 0;
				for(;;)
				{
					self.var_15C = 180;
					self method_82EF(level.player.origin);
					wait(1);
				}

				return;
			}
		}

		if(var_01)
		{
			if(self method_805F(self.var_10C))
			{
				wait(0.05);
				continue;
			}

			var_01 = 0;
		}
		else
		{
			if(self method_805F(self.var_10C))
			{
				var_01 = 1;
			}

			wait(0.05);
			continue;
		}

		if(randomint(3) > 0)
		{
			var_02 = func_6CA6(param_00);
			if(isdefined(var_02))
			{
				func_3FEF(var_02,self.var_3FF3);
				self waittill("goal");
			}
		}
	}
}

//Function Number: 114
func_3FEF(param_00,param_01)
{
	self method_82EE(param_00);
	self.var_3FF3 = param_00;
	param_00.var_3FF2 = 1;
	if(isdefined(param_01))
	{
		param_01.var_3FF2 = 0;
	}
}

//Function Number: 115
func_6CA6(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		if(param_00[var_01].var_3FF2)
		{
			continue;
		}
		else
		{
			return param_00[var_01];
		}
	}

	return undefined;
}

//Function Number: 116
func_6F5D(param_00)
{
	var_01 = function_00C8(param_00.target);
	scripts\common\utility::array_thread(var_01,::func_6F59);
	param_00 waittill("trigger");
	var_01 = function_00C8(param_00.target);
	scripts\common\utility::array_thread(var_01,::func_6F5C,param_00);
}

//Function Number: 117
func_6F59()
{
}

//Function Number: 118
func_1278B(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	return isdefined(param_00.var_EE95);
}

//Function Number: 119
func_6F5C(param_00)
{
	if(!isdefined(level.var_107A7) || isspawner(self))
	{
		self endon("death");
	}

	self notify("stop current floodspawner");
	self endon("stop current floodspawner");
	if(func_9C98())
	{
		func_DB3D(param_00);
		return;
	}

	var_01 = func_1278B(param_00);
	scripts\sp\_utility::script_delay();
	if(isdefined(level.var_107A7))
	{
		if(!isspawner(self))
		{
			self.var_C1 = 1;
		}
	}

	while(self.var_C1 > 0)
	{
		while(var_01 && !level.player istouching(param_00))
		{
			wait(0.5);
		}

		var_02 = isdefined(self.var_EED1) && scripts\common\utility::flag("stealth_enabled") && !scripts\common\utility::flag("stealth_spotted");
		var_03 = self;
		if(isdefined(level.var_107A7))
		{
			if(!isspawner(self))
			{
				var_03 = func_7C86(self,1);
			}
		}

		if(isdefined(self.var_EDB3))
		{
			var_04 = var_03 method_8393(var_02);
		}
		else
		{
			var_04 = var_03 method_80B5(var_02);
		}

		if(scripts\sp\_utility::func_106ED(var_04))
		{
			wait(2);
			continue;
		}

		if(isdefined(self.var_ED39))
		{
			if(self.var_ED39 == "heat")
			{
				var_04 scripts\sp\_utility::func_61FF();
			}

			if(self.var_ED39 == "cqb")
			{
				var_04 scripts\sp\_utility::func_61E7();
			}
		}

		var_04 thread func_DF23(self);
		var_04 waittill("death",var_05);
		if(!func_D27A(var_04,var_05))
		{
			self.var_C1++;
		}

		if(!isdefined(var_04))
		{
			continue;
		}

		if(!scripts\sp\_utility::func_EF15())
		{
			wait(randomfloatrange(5,9));
		}
	}
}

//Function Number: 120
func_D27A(param_00,param_01)
{
	if(isdefined(self.var_EDAA))
	{
		if(self.var_EDAA)
		{
			return 1;
		}
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(isalive(param_01))
	{
		if(isplayer(param_01))
		{
			return 1;
		}

		if(distance(param_01.origin,level.player.origin) < 200)
		{
			return 1;
		}
	}
	else if(isdefined(param_01))
	{
		if(param_01.classname == "worldspawn")
		{
			return 0;
		}

		if(distance(param_01.origin,level.player.origin) < 200)
		{
			return 1;
		}
	}

	if(distance(param_00.origin,level.player.origin) < 200)
	{
		return 1;
	}

	return bullettracepassed(level.player geteye(),param_00 geteye(),0,undefined);
}

//Function Number: 121
func_9C98()
{
	if(!isdefined(self.target))
	{
		return 0;
	}

	var_00 = function_00C8(self.target);
	if(!var_00.size)
	{
		return 0;
	}

	return issubstr(var_00[0].classname,"actor");
}

//Function Number: 122
func_DB3C(param_00)
{
	param_00.var_1060E waittill("death");
	self notify("death_report");
}

//Function Number: 123
func_DB3D(param_00)
{
	self endon("death");
	var_01 = func_1278B(param_00);
	scripts\sp\_utility::script_delay();
	if(var_01)
	{
		while(!level.player istouching(param_00))
		{
			wait(0.5);
		}
	}

	var_02 = function_00C8(self.target);
	self.var_1087B = 0;
	scripts\common\utility::array_thread(var_02,::func_DB3F,self);
	var_04 = randomint(var_02.size);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(self.var_C1 <= 0)
		{
			return;
		}

		var_04++;
		if(var_04 >= var_02.size)
		{
			var_04 = 0;
		}

		var_05 = var_02[var_04];
		var_05 scripts\sp\_utility::func_F311(1);
		var_06 = var_05 scripts\sp\_utility::func_10619();
		if(scripts\sp\_utility::func_106ED(var_06))
		{
			wait(2);
			continue;
		}

		self.var_C1--;
		var_05.var_1060E = var_06;
		var_06 thread func_DF23(self);
		var_06 thread func_6985(param_00);
		thread func_DB3C(var_05);
	}

	var_07 = 0.01;
	while(self.var_C1 > 0)
	{
		self waittill("death_report");
		scripts\sp\_utility::func_EF15();
		var_04 = randomint(var_02.size);
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			var_02 = scripts\common\utility::func_22BC(var_02);
			if(!var_02.size)
			{
				if(isdefined(self))
				{
					self delete();
				}

				return;
			}

			var_04++;
			if(var_04 >= var_02.size)
			{
				var_04 = 0;
			}

			var_05 = var_02[var_04];
			if(isalive(var_05.var_1060E))
			{
				continue;
			}

			if(isdefined(var_05.target))
			{
				self.target = var_05.target;
			}
			else
			{
				self.target = undefined;
			}

			var_06 = scripts\sp\_utility::func_10619();
			if(scripts\sp\_utility::func_106ED(var_06))
			{
				wait(2);
				continue;
			}

			var_06 thread func_DF23(self);
			var_06 thread func_6985(param_00);
			var_05.var_1060E = var_06;
			thread func_DB3C(var_05);
			if(self.var_C1 <= 0)
			{
				return;
			}
		}
	}
}

//Function Number: 124
func_DB3F(param_00)
{
	param_00 endon("death");
	param_00.var_1087B++;
	self waittill("death");
	param_00.var_1087B--;
	if(!param_00.var_1087B)
	{
		param_00 delete();
	}
}

//Function Number: 125
func_6985(param_00)
{
	if(isdefined(self.var_EDB0))
	{
		return;
	}

	var_01 = level.var_4FF6;
	if(isdefined(param_00))
	{
		if(isdefined(param_00.var_EE8F))
		{
			if(param_00.var_EE8F == -1)
			{
				return;
			}

			var_01 = param_00.var_EE8F;
		}
	}

	if(isdefined(self.var_EDB0))
	{
		return;
	}

	self endon("death");
	self waittill("goal");
	self.var_15C = var_01;
}

//Function Number: 126
func_100C6()
{
}

//Function Number: 127
func_DC9B(param_00)
{
	param_00 waittill("trigger");
	var_01 = function_00C8(param_00.target);
	if(!var_01.size)
	{
		return;
	}

	var_02 = scripts\common\utility::random(var_01);
	var_01 = [];
	var_01[var_01.size] = var_02;
	if(isdefined(var_02.var_EE01))
	{
		var_03 = strtok(var_02.var_EE01," ");
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			var_01[var_01.size] = getspawner(var_03[var_04],"script_linkname");
		}
	}

	waittillframeend;
	scripts\common\utility::array_thread(var_01,::scripts\sp\_utility::func_1747,::func_2BD0);
	scripts\common\utility::array_thread(var_01,::scripts\sp\_utility::func_10619);
}

//Function Number: 128
func_2BD0()
{
	if(isdefined(self.var_EDB0))
	{
		return;
	}

	self endon("death");
	self waittill("reached_path_end");
	if(!isdefined(self method_812A()))
	{
		self.var_15C = level.var_4FF6;
	}
}

//Function Number: 129
func_1085E(param_00)
{
	var_01 = param_00 method_838F();
	if(var_01.var_394 != "none")
	{
		var_02 = function_00EA(var_01.var_394);
		var_01 attach(var_02,"tag_weapon_right");
		var_03 = function_00E9(var_01.var_394);
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			var_01 method_8187(var_03[var_04],var_02);
		}
	}

	var_01.spawner = param_00;
	var_01.var_5BF2 = isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "drone_delete_on_unload";
	var_01.var_6CDA = 1;
	var_01 notify("finished spawning");
	param_00 notify("drone_spawned",var_01);
	return var_01;
}

//Function Number: 130
func_10869(param_00,param_01)
{
	if(!isdefined(param_00.spawner))
	{
	}

	var_02 = param_00.spawner.origin;
	var_03 = param_00.spawner.angles;
	var_04 = param_00.spawner.target;
	param_00.spawner.origin = param_00.origin;
	param_00.spawner.angles = param_00.angles;
	if(isdefined(param_01))
	{
		param_00.spawner.target = param_01;
	}

	param_00.spawner.var_C1 = param_00.spawner.var_C1 + 1;
	var_05 = param_00.spawner method_8393();
	var_06 = scripts\sp\_utility::func_106ED(var_05);
	if(var_06)
	{
	}

	var_05.var_131F5 = param_00.var_131F5;
	var_05.var_1321D = param_00.var_1321D;
	var_05.var_10B71 = param_00.var_10B71;
	var_05.var_72A4 = param_00.var_72A4;
	param_00.spawner.origin = var_02;
	param_00.spawner.angles = var_03;
	param_00.spawner.target = var_04;
	param_00 delete();
	return var_05;
}

//Function Number: 131
func_10868(param_00,param_01)
{
	if(!isdefined(param_00.spawner))
	{
	}

	var_02 = param_00.spawner.origin;
	var_03 = param_00.spawner.angles;
	var_04 = param_00.spawner.target;
	param_00.spawner.origin = param_00.origin;
	param_00.spawner.angles = param_00.angles;
	if(isdefined(param_01))
	{
		param_00.spawner.target = param_01;
	}

	param_00.spawner.var_C1 = param_00.spawner.var_C1 + 1;
	var_05 = scripts\sp\_utility::func_6B47(param_00.spawner);
	var_06 = scripts\sp\_utility::func_106ED(var_05);
	if(var_06)
	{
	}

	var_05.var_131F5 = param_00.var_131F5;
	var_05.var_1321D = param_00.var_1321D;
	var_05.var_10B71 = param_00.var_10B71;
	var_05.var_72A4 = param_00.var_72A4;
	param_00.spawner.origin = var_02;
	param_00.spawner.angles = var_03;
	param_00.spawner.target = var_04;
	param_00 delete();
	return var_05;
}

//Function Number: 132
func_1732()
{
	var_00 = self.var_EE90;
	var_01 = self.var_EE91;
	if(!isdefined(level.var_A67E))
	{
		level.var_A67E = [];
	}

	if(!isdefined(level.var_A67E[var_00]))
	{
		level.var_A67E[var_00] = [];
	}

	if(!isdefined(level.var_A67E[var_00][var_01]))
	{
		level.var_A67E[var_00][var_01] = [];
	}

	level.var_A67E[var_00][var_01][self.var_6A0B] = self;
}

//Function Number: 133
func_177E()
{
	var_00 = self.var_EEBA;
	var_01 = self.var_EEBB;
	if(!isdefined(level.var_10727[var_00]))
	{
		level.var_10727[var_00] = [];
	}

	if(!isdefined(level.var_10727[var_00][var_01]))
	{
		level.var_10727[var_00][var_01] = [];
	}

	level.var_10727[var_00][var_01][self.var_6A0B] = self;
}

//Function Number: 134
func_10CC6()
{
	self endon("death");
	self.var_55ED = 1;
	wait(3);
	self.var_55ED = 0;
}

//Function Number: 135
func_4E72()
{
	self endon("death");
	wait(self.var_ED4B);
	wait(randomfloat(10));
	self method_81D0();
}

//Function Number: 136
func_11AD7(param_00)
{
	self notify("tracker_bullet_hit");
	self endon("tracker_bullet_hit");
	if(self.team != "axis")
	{
		return;
	}

	if(!isalive(self))
	{
		return;
	}

	scripts\sp\_utility::func_9196(1,0,1,"tracker");
	scripts\common\utility::waittill_notify_or_timeout("death",5);
	scripts\sp\_utility::func_9193("tracker");
	if(isalive(self))
	{
		for(var_01 = 0;var_01 < 3;var_01++)
		{
			wait(0.2);
			scripts\sp\_utility::func_9196(1,0,1,"tracker");
			wait(0.15);
			scripts\sp\_utility::func_9193("tracker");
		}
	}
}