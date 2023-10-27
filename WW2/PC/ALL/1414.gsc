/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1414.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 61
 * Decompile Time: 95 ms
 * Timestamp: 10/27/2023 3:26:07 AM
*******************************************************************/

//Function Number: 1
func_AC73()
{
	level.var_ABE4 = [];
	level.zm_grenade_funcs = [];
	level.weaponmaxammofuncs = [];
	level.var_6092 = 2;
	level.var_6B83 = ::func_AC75;
	if(isdefined(level.var_AC71))
	{
		[[ level.var_AC71 ]]();
	}

	lib_0547::func_7BA9(::func_ABD7);
	thread func_AC74();
	level.var_61E0 = 0.3;
	level.var_61E2 = 100;
	level.var_61E1 = 20;
	level.var_61DE = 256;
	level.var_61DC = 350;
	level.var_61DB = 1000;
	level.var_61D9 = 46;
	level.var_61EF = -1;
	level.var_61CC = common_scripts\utility::func_44F5("mine_launch");
	level.var_61CF = common_scripts\utility::func_44F5("mine_spin");
	level.var_61C8 = common_scripts\utility::func_44F5("mine_explode");
	level.var_61C2["enemy"] = common_scripts\utility::func_44F5("mine_beacon_enemy");
	level.var_61C2["friendly"] = common_scripts\utility::func_44F5("mine_beacon_friendly");
	level thread maps/mp/zombies/weapons/_zombie_type_38::func_D5();
	level thread maps/mp/zombies/weapons/_zombie_funderbuss::func_D5();
	level thread maps/mp/zombies/weapons/_zombie_de_lisle_carbine::func_D5();
	level thread maps/mp/zombies/weapons/_zombies_scripted_lmg_upgrades::func_D5();
	level thread maps/mp/zombies/weapons/_zombies_scripted_mtx_9_paps::func_D5();
	level thread maps/mp/zombies/weapons/_zombies_scripted_mtx_20_paps::func_D5();
}

//Function Number: 2
func_AC74()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_A92B();
		var_00 thread func_A918();
		var_00 thread func_A926();
		var_00 thread func_5371();
		var_00 thread func_4AAA();
	}
}

//Function Number: 3
func_AC75()
{
	if(isdefined(level.var_AC72))
	{
		[[ level.var_AC72 ]]();
	}
}

//Function Number: 4
func_09E0(param_00)
{
	level.var_ABE4[level.var_ABE4.size] = param_00;
}

//Function Number: 5
func_5776(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	foreach(var_02 in level.var_ABE4)
	{
		if(var_02 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 6
func_478A(param_00)
{
	if(isdefined(param_00))
	{
		var_01 = [param_00];
	}
	else
	{
		var_01 = level.var_744A;
	}

	foreach(param_00 in var_01)
	{
		var_03 = param_00 method_834A();
		var_04 = param_00 method_831F();
		if(0)
		{
			var_05 = [var_03,var_04];
		}
		else
		{
			var_05 = [var_03];
		}

		foreach(var_07 in var_05)
		{
			if(var_07 == "none" || maps\mp\zombies\_zombies_magicbox::is_grenadier_immune_weapon(var_07))
			{
				continue;
			}

			param_00 method_82FA(var_07,param_00 getweaponammoclip(var_07) + 1);
		}
	}
}

//Function Number: 7
func_A92B()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("missile_fire",var_00,var_01);
		var_00.var_3C1D = self getstance();
	}
}

//Function Number: 8
func_A918()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(isdefined(level.zm_grenade_funcs[var_01]))
		{
			var_02 = [[ level.zm_grenade_funcs[var_01] ]](var_00);
			if(var_02)
			{
				continue;
			}
		}

		if(!isdefined(self.equipmentused))
		{
			self.equipmentused = 0;
		}

		if(lib_0547::func_585C(var_01))
		{
			self.equipmentused++;
		}

		var_00.var_3BE1 = self.var_569F;
	}
}

//Function Number: 9
func_0667(param_00)
{
	var_01 = function_01D4(param_00);
	if(var_01 != "primary" && var_01 != "altmode")
	{
		return 0;
	}

	if(maps\mp\_utility::func_5670(param_00))
	{
		return 1;
	}

	if(param_00 == self method_82D5())
	{
		return 1;
	}

	var_02 = getweapondisplayname(param_00);
	if(lib_0547::func_5865(var_02))
	{
		return 1;
	}

	if(lib_0547::func_585B(var_02))
	{
		return 1;
	}

	if(lib_0547::iszombieconsumableweapon(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
func_0639()
{
	var_00 = func_063A();
	return var_00.size;
}

//Function Number: 11
func_063A()
{
	var_00 = [];
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(!func_0667(var_03))
		{
			var_00[var_00.size] = var_03;
		}
	}

	return var_00;
}

//Function Number: 12
func_0635()
{
	if(lib_0547::func_4BA7("specialty_class_mule_kick_zm"))
	{
		return 3;
	}

	return 2;
}

//Function Number: 13
func_05DF(param_00)
{
	if(func_0667(param_00))
	{
		return 1;
	}

	return func_0635() > func_0639();
}

//Function Number: 14
func_0637()
{
	var_00 = func_063A();
	var_01 = self getcurrentprimaryweapon();
	if(common_scripts\utility::func_F79(var_00,var_01))
	{
		return var_01;
	}

	if(var_00.size == 0)
	{
		return "none";
	}

	var_02 = common_scripts\utility::func_4550();
	if(common_scripts\utility::func_F79(var_00,var_02))
	{
		return var_02;
	}

	return var_00[0];
}

//Function Number: 15
func_A926()
{
	self endon("disconnect");
	lib_0556::func_A6B8();
	for(;;)
	{
		var_00 = self method_82D5();
		if(!isdefined(var_00) || var_00 == "none")
		{
			lib_0556::func_5F16("melee");
			maps\mp\_utility::func_6D0(4,"");
		}
		else
		{
			lib_0556::func_5F16(var_00);
			lib_0556::func_24DD(var_00,var_00,"melee");
			maps\mp\_utility::func_6D0(4,"weapon",var_00);
		}

		common_scripts\utility::knock_off_battery("weapon_given","weapon_taken","zombie_player_spawn_finished","melee_weapon_change");
	}
}

//Function Number: 16
func_5371()
{
	var_00 = spawnstruct();
	self.var_AB4A = var_00;
	var_00.var_8DF = [];
	var_00.var_A9E7 = [];
	thread clear_weapon_inventory_on_death();
	thread func_A88C();
}

//Function Number: 17
clear_weapon_inventory_on_death()
{
	var_00 = self;
	var_00 endon("disconnect");
	for(;;)
	{
		var_00 waittill("death");
		if(!isdefined(var_00.var_AB4A))
		{
			continue;
		}

		var_00.var_AB4A.var_A9E7 = [];
	}
}

//Function Number: 18
func_A88C()
{
	self endon("disconnect");
	for(;;)
	{
		common_scripts\utility::knock_off_battery("weapon_given","weapon_taken");
		if(self.var_178 == "spectator" || self.var_178 == "dead")
		{
			continue;
		}

		var_00 = func_063A();
		foreach(var_02 in var_00)
		{
			var_03 = function_01A9(var_02);
			if(var_03 == "melee")
			{
				continue;
			}

			var_04 = lib_0547::func_AAF9(var_02);
			var_05 = self.var_AB4A.var_A9E7[var_04];
			if(!isdefined(var_05))
			{
				func_078D(var_02);
				continue;
			}

			var_06 = var_05.var_5B9F;
			if(!isdefined(var_06))
			{
				var_06 = "(removed) " + var_05.var_2953;
			}

			if(stricmp(var_02,var_06) != 0)
			{
				if(isdefined(var_05.var_5B9F))
				{
					self takeweapon(var_05.var_5B9F);
				}

				func_078D(var_02);
			}
		}

		var_08 = [];
		foreach(var_0A, var_05 in self.var_AB4A.var_A9E7)
		{
			if(isdefined(var_05.var_5B9F) && !self hasweapon(var_05.var_5B9F))
			{
				var_08[var_08.size] = var_0A;
			}
		}

		foreach(var_0C in var_08)
		{
			self.var_AB4A.var_A9E7[var_0C] = undefined;
		}
	}
}

//Function Number: 19
func_7BDB(param_00,param_01,param_02)
{
	if(!isdefined(level.var_AB4B))
	{
		level.var_AB4B = [];
	}

	var_03 = spawnstruct();
	level.var_AB4B[param_00] = var_03;
	var_03.var_9AF = param_01;
	var_03.var_2381 = param_02;
}

//Function Number: 20
func_0680(param_00)
{
	var_01 = spawnstruct();
	var_01.var_6C57 = param_00;
	var_01.var_F20 = [];
	var_01.var_2953 = param_00;
	var_01.var_5B9F = undefined;
	return var_01;
}

//Function Number: 21
func_4129(param_00)
{
	var_01 = spawnstruct();
	var_02 = param_00;
	var_03 = lib_0547::func_AAF9(param_00);
	var_04 = self.var_AB4A.var_A9E7[var_03];
	if(isdefined(var_04))
	{
		var_02 = var_04.var_5B9F;
	}
	else
	{
		func_AC13("get_current_ammo_info: pulling ammo from weapon that isn\'t in our inventory!  Double-check that this weapon was given to the player through _zm_give_weapon: " + param_00);
	}

	var_01.var_DB3 = self getweaponammoclip(var_02);
	if(issubstr(var_02,"akimbo"))
	{
		var_01.var_DB4 = self getweaponammoclip(var_02,"left");
	}

	if(!function_01D8(param_00))
	{
		var_01.var_DBB = self getweaponammostock(var_02);
	}

	return var_01;
}

//Function Number: 22
func_0F21(param_00,param_01)
{
	var_02 = lib_0547::func_AAF9(param_00);
	var_03 = self.var_AB4A.var_A9E7[var_02];
	var_04 = param_00;
	if(isdefined(var_03))
	{
		var_04 = var_03.var_5B9F;
	}
	else
	{
		func_AC13("apply_ammo_info: setting ammo on weapon that isn\'t in our inventory!  Double-check that this weapon was given to the player through _zm_give_weapon: " + param_00);
	}

	var_05 = 0;
	var_06 = 0;
	var_07 = weaponclipsize(var_04,self);
	var_05 = int(max(0,param_01.var_DB3 - var_07));
	var_06 = var_06 + var_05;
	self method_82FA(var_04,param_01.var_DB3 - var_05,"right");
	if(issubstr(var_04,"akimbo"))
	{
		if(isdefined(param_01.var_DB4))
		{
			var_05 = int(max(0,param_01.var_DB4 - var_07));
			var_06 = var_06 + var_05;
			self method_82FA(var_04,param_01.var_DB4 - var_05,"left");
		}
		else
		{
			self method_82FA(var_04,0,"left");
		}
	}
	else if(isdefined(param_01.var_DB4))
	{
		var_05 = param_01.var_DB4;
		var_06 = var_06 + var_05;
	}

	if(isdefined(param_01.var_DBB))
	{
		var_08 = param_01.var_DBB + var_06;
		var_09 = weaponmaxammo(var_04,self);
		if(var_08 > var_09)
		{
			func_AC13("^3apply_ammo_info: Weapon max ammo isn\'t large enough to hold stored ammo bullets! Losing some ammo.");
			var_08 = var_09;
		}

		self setweaponammostock(var_04,var_08);
	}
}

//Function Number: 23
func_0736(param_00,param_01)
{
	var_02 = 0;
	var_03 = undefined;
	if(isdefined(param_00.var_5B9F))
	{
		if(param_00.var_2953 == param_00.var_5B9F)
		{
			return;
		}

		var_03 = func_4129(param_00.var_5B9F);
		self notify("zm_weap_take_" + param_00.var_5B9F);
		self takeweapon(param_00.var_5B9F);
	}
	else
	{
	}

	thread func_0641(param_00.var_2953,param_01,param_00.var_A6DF,param_00.weaponcharmguid);
	param_00.var_5B9F = param_00.var_2953;
	if(isdefined(var_03))
	{
		func_0F21(param_00.var_2953,var_03);
	}
}

//Function Number: 24
func_078D(param_00)
{
	func_078C(param_00,undefined,0);
}

//Function Number: 25
_zm_give_weapon_mp_api(param_00,param_01,param_02,param_03)
{
	func_078C(param_00,param_01,undefined,param_03);
}

//Function Number: 26
func_078C(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_05 = function_01D4(param_00);
	var_06 = function_01A9(param_00);
	var_07 = lib_0547::func_AAF9(param_00);
	self notify("zm_stream_cancel_" + var_07);
	if((var_05 != "primary" && var_05 != "altmode") || var_06 == "melee")
	{
		thread func_0641(param_00,var_07,param_02,param_03,param_04);
		if(common_scripts\utility::func_562E(param_02))
		{
			common_scripts\utility::knock_off_battery("zm_stream_cancel_" + var_07,"zm_stream_finish_" + var_07);
		}

		return;
	}

	var_08 = self.var_AB4A.var_A9E7[var_07];
	if(isdefined(var_08))
	{
		func_0790(var_08.var_5B9F);
		var_08 = undefined;
	}

	if(!isdefined(var_08))
	{
		var_08 = func_0680(param_00);
		self.var_AB4A.var_A9E7[var_07] = var_08;
	}

	var_08.var_A6DF = param_02;
	var_08.weaponcharmguid = param_03;
	foreach(var_0C, var_0A in self.var_AB4A.var_8DF)
	{
		var_0B = level.var_AB4B[var_0C];
		if(isdefined(var_0B.var_9AF))
		{
			self [[ var_0B.var_9AF ]](var_08);
		}
	}

	func_0736(var_08,var_07);
	if(param_02)
	{
		common_scripts\utility::knock_off_battery("zm_stream_cancel_" + var_07,"zm_stream_finish_" + var_07);
	}
}

//Function Number: 27
func_AC13(param_00)
{
}

//Function Number: 28
func_0632(param_00)
{
	var_01 = lib_0547::func_AAF9(param_00);
	var_02 = self.var_AB4A.var_A9E7[var_01];
	if(isdefined(var_02))
	{
		return var_02.var_6C57;
	}

	return param_00;
}

//Function Number: 29
func_078F()
{
	var_00 = getarraykeys(self.var_AB4A.var_A9E7);
	foreach(var_02 in var_00)
	{
		func_0790(var_02);
	}

	self takeallweapons();
}

//Function Number: 30
func_0641(param_00,param_01,param_02,param_03,param_04)
{
	self notify("zm_stream_change_" + param_01);
	self endon("zm_stream_cancel_" + param_01);
	self endon("zm_stream_change_" + param_01);
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_05 = 0;
	var_05 = self method_8512([param_00]);
	if(param_02)
	{
		wait(0);
		while(!var_05)
		{
			wait 0.05;
			var_05 = self method_8512([param_00]);
		}
	}

	var_06 = 0;
	var_07 = undefined;
	if(!common_scripts\utility::func_562E(param_04))
	{
		var_07 = lib_056C::getzombiepaintjob(self,param_00);
	}

	maps\mp\_utility::func_642(param_00,var_06,var_07,param_03);
	if(!param_02 && !var_05)
	{
		childthread func_A8C2(param_00,param_01);
		return;
	}

	self notify("zm_stream_finish_" + param_01);
}

//Function Number: 31
func_A8C2(param_00,param_01)
{
	for(;;)
	{
		var_02 = self method_8512([param_00]);
		if(var_02)
		{
			break;
		}

		wait 0.05;
	}

	self notify("zm_stream_finish_" + param_01);
}

//Function Number: 32
func_0790(param_00)
{
	if(!isdefined(param_00) || param_00 == "none")
	{
		return;
	}

	var_01 = function_01D4(param_00);
	var_02 = function_01A9(param_00);
	var_03 = lib_0547::func_AAF9(param_00);
	if((var_01 != "primary" && var_01 != "altmode") || var_02 == "melee")
	{
		self notify("zm_stream_cancel_" + var_03);
		self takeweapon(param_00);
		return;
	}

	var_04 = [];
	if(isdefined(self.var_AB4A.var_A9E7[var_03]))
	{
		var_04[var_03] = 1;
	}

	if(var_04.size != 1)
	{
	}

	foreach(var_11, var_0F in var_04)
	{
		var_10 = self.var_AB4A.var_A9E7[var_11];
		if(isdefined(var_10.var_5B9F))
		{
			self takeweapon(var_10.var_5B9F);
		}

		self.var_AB4A.var_A9E7[var_11] = undefined;
	}

	self notify("zm_stream_cancel_" + var_03);
}

//Function Number: 33
func_098F(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_04 = level.var_AB4B[var_03];
		if(!isdefined(var_04))
		{
			continue;
		}

		var_01[var_01.size] = var_04;
		self.var_AB4A.var_8DF[var_03] = 1;
	}

	var_06 = self getcurrentprimaryweapon();
	foreach(var_0B, var_08 in self.var_AB4A.var_A9E7)
	{
		foreach(var_04 in var_01)
		{
			if(isdefined(var_04.var_9AF))
			{
				self [[ var_04.var_9AF ]](var_08);
			}
		}

		func_0736(var_08,var_0B);
	}

	func_11BB(var_06);
}

//Function Number: 34
func_098E(param_00)
{
	func_098F([param_00]);
}

//Function Number: 35
func_7CC9(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_04 = level.var_AB4B[var_03];
		if(!isdefined(var_04))
		{
			continue;
		}

		var_01[var_01.size] = var_04;
		self.var_AB4A.var_8DF[var_03] = undefined;
	}

	var_06 = self getcurrentprimaryweapon();
	foreach(var_0B, var_08 in self.var_AB4A.var_A9E7)
	{
		foreach(var_04 in var_01)
		{
			if(isdefined(var_04.var_2381))
			{
				self [[ var_04.var_2381 ]](var_08);
			}
		}

		func_0736(var_08,var_0B);
	}

	func_11BB(var_06);
}

//Function Number: 36
func_11BB(param_00)
{
	var_01 = self getcurrentprimaryweapon();
	if((!isdefined(var_01) || var_01 == "none") && isdefined(param_00) && param_00 != "none")
	{
		func_078E(param_00,1);
	}
}

//Function Number: 37
func_7CC8(param_00)
{
	func_7CC9([param_00]);
}

//Function Number: 38
func_078E(param_00,param_01,param_02)
{
	var_03 = lib_0547::func_AAF9(param_00);
	var_04 = self.var_AB4A.var_A9E7[var_03];
	if(isdefined(var_04))
	{
		param_00 = var_04.var_5B9F;
	}

	if(common_scripts\utility::func_562E(param_02))
	{
		self method_86A5(param_00);
		return;
	}

	if(common_scripts\utility::func_562E(param_01))
	{
		self switchtoweaponimmediate(param_00);
		return;
	}

	self switchtoweapon(param_00);
}

//Function Number: 39
func_2BA2(param_00)
{
	if(!self adsbuttonpressed())
	{
		return 0;
	}

	return 1;
}

//Function Number: 40
func_0791(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(!isdefined(param_05))
	{
		param_05 = 1;
	}

	if(!param_02 && !param_03 && !param_04 && !param_05)
	{
		return stricmp(param_00,param_01) == 0;
	}

	if((param_00 == "none" || param_01 == "none") && stricmp(param_00,param_01) != 0)
	{
		return 0;
	}

	var_06 = function_03A5(param_00);
	var_07 = function_03A5(param_01);
	if(param_04)
	{
		var_06["weapon"] = lib_0569::func_40BD(var_06["weapon"]);
		var_07["weapon"] = lib_0569::func_40BD(var_07["weapon"]);
	}

	if(param_03)
	{
		var_06["weapon"] = lib_0547::func_9469(var_06["weapon"]);
		var_07["weapon"] = lib_0547::func_9469(var_07["weapon"]);
	}

	if(param_05)
	{
		var_06["weapon"] = lib_0547::func_9475(var_06["weapon"]);
		var_07["weapon"] = lib_0547::func_9475(var_07["weapon"]);
	}

	if(param_02)
	{
		return stricmp(var_06["weapon"],var_07["weapon"]) == 0;
	}

	param_00 = lib_0547::func_62F(var_06);
	param_01 = lib_0547::func_62F(var_07);
	return stricmp(param_00,param_01) == 0;
}

//Function Number: 41
func_078A(param_00)
{
	if(self hasweapon(param_00))
	{
		return param_00;
	}

	var_01 = lib_0547::func_AAF9(param_00);
	var_02 = self.var_AB4A.var_A9E7[var_01];
	if(isdefined(var_02) && isdefined(var_02.var_5B9F))
	{
		return var_02.var_5B9F;
	}

	var_03 = self getweaponslistall();
	foreach(var_05 in var_03)
	{
		if(func_0791(param_00,var_05))
		{
			return var_05;
		}
	}

	return undefined;
}

//Function Number: 42
func_078B(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_04 = self;
	if(param_01)
	{
		var_04 = undefined;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	if(issubstr(param_00,"_pap_zm"))
	{
		return param_00;
	}

	var_05 = lib_0547::func_AAF9(param_00,undefined,1);
	var_06 = lib_0547::func_9475(var_05) + "_pap_zm";
	if(!param_02)
	{
		if(param_00 == "zom_dlc2_1_zm" || param_00 == "zom_dlc2_2_zm" || param_00 == "zom_dlc2_3_zm")
		{
			if(!common_scripts\utility::func_3C83("dlc2_melee_packable"))
			{
				return;
			}

			if(common_scripts\utility::func_3C83("dlc2_melee_packable") && !common_scripts\utility::func_3C77("dlc2_melee_packable"))
			{
				return;
			}

			var_06 = lib_0547::func_9475(param_00) + "hc_zm";
		}
	}

	if(!lib_0547::func_5843(var_06))
	{
		return;
	}

	if(!param_02)
	{
		if(issubstr(param_00,"razergun_zm") && !common_scripts\utility::func_3C77("ripsaw_punch_active"))
		{
			return;
		}

		if(issubstr(param_00,"teslagun"))
		{
			if(!common_scripts\utility::func_3C83("teslagun_punch_active"))
			{
				return;
			}

			if(!common_scripts\utility::func_3C77("teslagun_punch_active"))
			{
				return;
			}
		}

		if(issubstr(param_00,"zom_dlc2_1"))
		{
			if(!common_scripts\utility::func_3C83("dlc2_melee_packable"))
			{
				return;
			}

			if(!common_scripts\utility::func_3C77("dlc2_melee_packable"))
			{
				return;
			}
		}
	}

	var_07 = "pap";
	if(isdefined(level.pap_camo_ref_override))
	{
		var_07 = level.pap_camo_ref_override;
	}

	if(common_scripts\utility::func_562E(level.iszombiesshotgun))
	{
		var_08 = lib_0547::func_AAF9(param_00,0,0);
		var_09 = function_02FF(var_08,"_zm") + "_mp";
		if(isdefined(level.var_A9CB[var_09]) && isdefined(var_04) && isplayer(var_04))
		{
			var_0A = var_04 getrankedplayerdata(common_scripts\utility::func_46A8(),"weaponBuildKits",var_09,"bossupgrade");
			if(common_scripts\utility::func_562E(var_0A) && isdefined(level.loot_pap_camo_ref_override))
			{
				var_07 = level.loot_pap_camo_ref_override;
			}
		}
	}

	var_0B = getitemguidfromref(var_07);
	var_0C = [];
	var_0D = undefined;
	var_0E = undefined;
	var_0F = undefined;
	if(issubstr(param_00,"classic"))
	{
		var_0B = getitemguidfromref("chrome");
		var_10 = lib_056C::getattachmentforzombieweapon(var_06,"extended_mag");
		var_11 = getitemguidfromref(var_10);
		var_0C = common_scripts\utility::func_F6F(var_0C,var_11);
	}

	if(issubstr(param_00,"vintage"))
	{
		var_0B = getitemguidfromref("chrome");
		var_10 = lib_056C::getattachmentforzombieweapon(var_06,"extended_mag_mg42_zm");
		var_11 = getitemguidfromref(var_10);
		var_0C = common_scripts\utility::func_F6F(var_0C,var_11);
	}

	if(issubstr(param_00,"m1911"))
	{
		var_12 = lib_056C::getattachmentforzombieweapon(var_06,"akimbo");
		var_13 = getitemguidfromref(var_12);
		var_0C = common_scripts\utility::func_F6F(var_0C,var_13);
	}

	if(!param_01)
	{
		var_14 = lib_056C::func_4735(var_04,param_00);
		if(isdefined(var_14))
		{
			if(var_14.var_A9F8)
			{
				var_0D = getweaponconditionid(var_14.var_A9F8);
				var_06 = getitemreffromguid(var_14.var_A9F8);
				var_06 = function_02FF(var_06,"_mp");
				var_06 = var_06 + "_pap_zm";
			}

			if(var_14.var_7E18)
			{
				var_0E = var_14.var_7E18;
			}

			if(var_14.var_297C)
			{
				var_0F = var_14.var_297C;
			}

			var_0C = common_scripts\utility::func_F73(var_0C,var_14.var_114C);
		}

		if(common_scripts\utility::func_562E(param_03) && isdefined(var_14) && isdefined(var_14.var_1EC0))
		{
			var_0B = var_14.var_1EC0;
		}
	}

	while(var_0C.size < 6)
	{
		var_0C = common_scripts\utility::func_F6F(var_0C,0);
	}

	var_15 = maps\mp\gametypes\_class::func_1D66(var_06,var_0C[0],var_0C[1],var_0C[2],var_0C[3],var_0C[4],var_0C[5],var_0D,var_0B,0,var_0E,var_0F,var_04,undefined);
	return var_15;
}

//Function Number: 43
func_AB31(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "neck":
		case "helmet":
		case "head":
			return 1;
	}

	return 0;
}

//Function Number: 44
func_ABD6(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = func_43EE(param_01,param_04);
	if(func_176D(var_08,8))
	{
		if(func_AB31(param_07))
		{
			param_02 = func_0975(1,param_02,param_04,param_07,param_01);
		}
		else if(param_07 != "none")
		{
			param_02 = func_0975(-0.2,param_02,param_04,param_07,param_01);
		}
	}

	if(func_176D(var_08,16))
	{
		if(func_AB31(param_07))
		{
			param_02 = func_0975(-1,param_02,param_04,param_07,param_01);
		}
		else if(param_07 != "none")
		{
			param_02 = func_0975(0.2,param_02,param_04,param_07,param_01);
		}
	}

	if(func_176D(var_08,64))
	{
		param_02 = param_02 * 1.75;
	}

	return param_02;
}

//Function Number: 45
func_0975(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_04 method_850B(param_02,param_03);
	if(var_05 == 0)
	{
		return 0;
	}

	param_01 = param_01 / var_05 * max(var_05 + param_00,0);
	return param_01;
}

//Function Number: 46
func_ABD5(param_00,param_01)
{
	maps\mp\zombies\_zombies_roles::func_6B84(param_00,param_01);
}

//Function Number: 47
func_ABD7(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isdefined(param_04) && param_04 == "drag_explosive_zombie_zm")
	{
		param_01 = level.var_ABA1.var_117;
		if(!isdefined(param_01) || !isplayer(param_01) || !isdefined(level.var_ABA1.var_9DBF))
		{
			return;
		}

		param_04 = level.var_ABA1.var_9DBF;
	}

	if(!isplayer(param_01) || !isdefined(param_04))
	{
		return;
	}

	var_09 = param_01 method_82D5();
	if(param_04 == "frag_skull_zm")
	{
		param_04 = param_01 getcurrentprimaryweapon();
	}

	if(param_04 == var_09)
	{
		param_04 = param_01 getcurrentprimaryweapon();
	}

	var_0A = func_43EE(param_01,param_04);
	if(maps\mp\_utility::func_5755(param_03))
	{
		if(func_176D(var_0A,2))
		{
			param_01 func_ABD5(20,"rip_and_tear");
		}
	}
	else
	{
		if(func_176D(var_0A,1))
		{
			if(func_AB31(param_06))
			{
				param_01 func_ABD5(10,"head_hunter");
			}
		}

		if(func_176D(var_0A,128))
		{
			if(lib_054D::func_2EF2())
			{
				param_01 maps/mp/gametypes/zombies::func_47AE("one_shot_one_kill");
			}
		}

		if(func_176D(var_0A,4))
		{
			func_9B91(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
		}
	}

	if(func_176D(var_0A,256))
	{
		param_01 func_50FA(param_04,self);
	}
}

//Function Number: 48
func_176D(param_00,param_01)
{
	return param_00 & param_01 != 0;
}

//Function Number: 49
func_43EE(param_00,param_01)
{
	var_02 = lib_0547::func_AAF9(param_01,0,1);
	var_03 = param_00.var_AC30[var_02];
	if(!isdefined(var_03))
	{
		level.promisenottogiveweapon = 1;
		var_04 = lib_056C::func_4735(param_00,var_02);
		level.promisenottogiveweapon = undefined;
		if(isdefined(var_04))
		{
			if(var_04.var_A9F8)
			{
				var_05 = function_031A(var_04.var_A9F8,43);
				if(isdefined(var_05))
				{
					var_03 = int(var_05);
				}
				else
				{
					var_03 = 0;
				}

				param_00.var_AC30[var_02] = var_03;
			}
		}
	}

	if(!isdefined(var_03))
	{
		var_03 = 0;
		param_00.var_AC30[var_02] = 0;
	}

	return var_03;
}

//Function Number: 50
func_9B91(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = param_01.var_5BDC;
	var_0A = gettime();
	if(isdefined(self.var_6730))
	{
		var_0A = self.var_6730;
	}

	if(!isdefined(var_09))
	{
		var_09 = spawnstruct();
		param_01.var_5BDC = var_09;
		var_09.var_8B34 = [];
	}

	var_0B = undefined;
	foreach(var_0D in var_09.var_8B34)
	{
		if(param_01 == var_0D.var_356A && var_0A == var_0D.var_2AB8 && lib_054D::func_5574(param_04,var_0D.var_953E))
		{
			var_0B = var_0D;
			break;
		}
	}

	if(!isdefined(var_0B))
	{
		var_0B = spawnstruct();
		var_09.var_8B34[var_09.var_8B34.size] = var_0B;
		var_0B.var_356A = param_01;
		var_0B.var_2AB8 = var_0A;
		var_0B.var_953E = param_04;
		var_0B.var_5C = 1;
	}
	else
	{
		var_0B.var_5C++;
	}

	param_01 thread func_1453();
}

//Function Number: 51
func_1453()
{
	self notify("efficient_kill");
	self endon("death");
	self endon("disconnect");
	self endon("efficient_kill");
	waittillframeend;
	while(isdefined(level.var_AB27) && level.var_AB29 > 0)
	{
		wait 0.05;
	}

	if(!isdefined(self.var_5BDC))
	{
		return;
	}

	foreach(var_01 in self.var_5BDC.var_8B34)
	{
		if(var_01.var_5C == 2)
		{
			func_ABD5(50,"efficient");
			continue;
		}

		if(var_01.var_5C > 2)
		{
			var_02 = var_01.var_5C * 30;
			func_ABD5(var_02,"efficient");
		}
	}

	self.var_5BDC = undefined;
}

//Function Number: 52
func_4AAA()
{
	self endon("disconnect");
	for(;;)
	{
		self.var_18AD = [];
		common_scripts\utility::knock_off_battery("death","begin_last_stand");
	}
}

//Function Number: 53
func_50FA(param_00,param_01)
{
	var_02 = lib_0547::func_AAF9(param_00,0);
	var_03 = self.var_18AD[var_02];
	if(!isdefined(var_03))
	{
		var_03 = 0;
	}

	var_03++;
	if(var_03 >= 150)
	{
		var_03 = var_03 - 150;
		var_04 = anglestoforward(self.var_1D) * 60;
		var_05 = getgroundposition(self.var_116 + var_04,16);
		var_05 = getclosestpointonnavmesh(var_05,self);
		var_06 = navtrace(self.var_116,var_05,self,1);
		if(var_06["fraction"] < 1)
		{
			var_05 = self.var_116 + anglestoforward(self.var_1D);
		}

		var_07 = maps/mp/gametypes/zombies::func_3B9B(var_05);
		maps/mp/gametypes/zombies::func_281C("nuke",var_07,"body_count",1,0);
	}

	self.var_18AD[var_02] = var_03;
}

//Function Number: 54
func_72C3()
{
	return isplayer(self) && (common_scripts\utility::func_562E(self.var_56A5) || common_scripts\utility::func_562E(self.isswitchingtoblimppart)) && self hasweapon("blimp_battery_zm");
}

//Function Number: 55
player_is_holding_baby_statue()
{
	return isplayer(self) && self hasweapon("stone_baby_zm");
}

//Function Number: 56
zombies_hit_by_melee_cone(param_00,param_01,param_02)
{
	var_03 = self geteye();
	var_04 = self geteyeangles();
	var_05 = min(90 - param_01 / 2,var_04[0]);
	var_06 = anglestoforward((var_05,var_04[1],var_04[2]));
	var_07 = func_43F1(var_03,var_06,param_00,param_01,param_02);
	return var_07;
}

//Function Number: 57
func_43F1(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = lib_0547::func_408F();
	}

	var_05 = [];
	var_06 = cos(param_03 / 2);
	foreach(var_08 in param_04)
	{
		var_09 = var_08.var_8302;
		var_0A = var_08.var_8303;
		var_0B = var_08.var_116 + (0,0,var_09 * 0.5);
		var_0C = closestpointonconicsectionofspheretopoint(param_00,-1 * param_01,var_06,param_02,var_0B);
		if(distance2dsquared(var_0C,var_0B) > var_0A * var_0A || abs(var_0B[2] - var_0C[2]) > var_09 * 0.5)
		{
			continue;
		}

		if(var_08 method_81D7(param_00,self) == 0)
		{
			continue;
		}

		var_05[var_05.size] = var_08;
	}

	return var_05;
}

//Function Number: 58
create_streamed_world_weapon_model(param_00,param_01)
{
	var_02 = spawn("weapon_" + param_00,param_01,1);
	var_02.var_A9E0 = param_00;
	var_02 makeunusable();
	var_02 method_86B3(0);
	var_02 endon("entitydeleted");
	var_02 endon("death");
	var_02 endon("streamed_world_weapon_changed");
	childthread maps\mp\_utility::func_6F74(::show_streamed_world_weapon_to_player,var_02);
	return var_02;
}

//Function Number: 59
change_streamed_world_weapon_model(param_00)
{
	var_01 = self;
	var_01 method_848E(param_00);
	var_01 makeunusable();
	var_01.var_A9E0 = param_00;
	var_01 notify("streamed_world_weapon_changed");
	var_01 endon("entitydeleted");
	var_01 endon("death");
	var_01 endon("streamed_world_weapon_changed");
	childthread maps\mp\_utility::func_6F74(::show_streamed_world_weapon_to_player,var_01);
}

//Function Number: 60
show_streamed_world_weapon_to_player(param_00)
{
	var_01 = self;
	param_00 endon("entitydeleted");
	param_00 endon("death");
	param_00 endon("streamed_world_weapon_changed");
	var_01 endon("disconnect");
	if(var_01 method_8530(param_00.var_A9E0))
	{
		return;
	}

	param_00 hidefromclient(var_01);
	var_02 = spawn("weapon_" + param_00.var_A9E0,param_00.var_116,1);
	var_02.var_A9E0 = param_00.var_A9E0;
	var_02 makeunusable();
	var_02 method_86B3(0);
	var_02 method_8511();
	var_01 thread cleanup_streamed_world_weapon(var_02,param_00);
	while(!var_01 method_8530(var_02.var_A9E0))
	{
		wait 0.05;
		var_02.var_116 = param_00.var_116;
	}

	param_00 showtoclient(var_01);
	var_02 notify("streamed_world_weapon");
	var_02 delete();
}

//Function Number: 61
cleanup_streamed_world_weapon(param_00,param_01)
{
	var_02 = self;
	param_00 endon("streamed_world_weapon");
	common_scripts\utility::func_A70C(var_02,"disconnect",param_01,"entitydeleted",param_01,"death",param_01,"streamed_world_weapon_changed");
	param_00 delete();
}