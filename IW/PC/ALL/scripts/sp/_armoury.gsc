/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_armoury.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 1095 ms
 * Timestamp: 10/27/2023 12:23:48 AM
*******************************************************************/

//Function Number: 1
func_952F()
{
	func_2237();
	func_CF6C();
	func_EE1F();
	func_87EC();
	level.var_A03B = getdvar("player_itemUseRadius");
	level.var_A03A = getdvar("player_itemUseFOV");
	var_00 = getentarray("loot_room_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread func_CF73();
	}
}

//Function Number: 2
func_2237()
{
}

//Function Number: 3
func_489F(param_00)
{
	var_01 = [];
	var_02 = [];
	var_03 = [];
	var_01 = scripts\common\utility::getstructarray("loot_weapon_node","targetname");
	var_02 = scripts\common\utility::getstructarray("loot_terminal","targetname");
	var_03 = scripts\common\utility::getstructarray("locker_node","targetname");
	var_04 = level.var_D9E5["equip_upgrades"];
	var_04 = var_04 / level.var_21E2;
	if(isdefined(level.var_FCD6) && level.var_FCD6 == 1)
	{
		var_05 = undefined;
		var_06 = getentarray("loot_room_volume","targetname");
		if(var_06.size > 1)
		{
			foreach(var_05 in var_06)
			{
				if(function_010F(self.origin,var_05))
				{
					break;
				}
			}

			if(isdefined(var_05))
			{
				var_09 = var_01;
				var_0A = var_02;
				var_0B = var_03;
				var_01 = [];
				var_02 = [];
				var_03 = [];
				foreach(var_0D in var_09)
				{
					if(function_010F(var_0D.origin,var_05))
					{
						var_01 = scripts\common\utility::array_add(var_01,var_0D);
					}
				}

				foreach(var_10 in var_0A)
				{
					if(function_010F(var_10.origin,var_05))
					{
						var_02 = scripts\common\utility::array_add(var_02,var_10);
					}
				}

				foreach(var_13 in var_0B)
				{
					if(function_010F(var_13.origin,var_05))
					{
						var_03 = scripts\common\utility::array_add(var_03,var_13);
					}
				}
			}
		}
	}

	func_B080(var_03,0);
	thread func_B098(var_01);
	thread func_B095(param_00,var_02,var_04);
}

//Function Number: 4
func_CF73()
{
	for(;;)
	{
		for(;;)
		{
			if(level.player istouching(self))
			{
				break;
			}

			wait(0.25);
		}

		function_01C5("player_itemUseRadius",100);
		function_01C5("player_itemUseFOV",90);
		for(;;)
		{
			if(!level.player istouching(self))
			{
				break;
			}

			wait(0.25);
		}

		function_01C5("player_itemUseRadius",level.var_A03B);
		function_01C5("player_itemUseFOV",level.var_A03A);
	}
}

//Function Number: 5
func_CF6C()
{
	if(level.script == "sa_assassination")
	{
		if(isdefined(level.var_21E7))
		{
			level [[ level.var_21E7 ]]();
			return;
		}

		return;
	}

	level.var_EC87["player_arms"] = #animtree;
	level.var_EC8C["player_arms"] = "viewmodel_base_viewhands_iw7";
	level.var_EC85["player_arms"]["hack_terminal"] = %vm_gauntlet_armory_hack;
	level.var_EC85["player_arms"]["open_loot_door"] = %door_armory_open_player;
}

//Function Number: 6
func_EE1F()
{
	level.var_EC87["loot_door"] = #animtree;
	level.var_EC87["loot_locker"] = #animtree;
	level.var_EC85["loot_door"]["open_loot_door"] = %door_armory_open_door;
	level.var_EC85["loot_locker"]["open_locker_doors"] = %loot_room_locker_door_open;
}

//Function Number: 7
func_B098(param_00)
{
	param_00 = scripts\common\utility::array_randomize(param_00);
	var_01 = spawnstruct();
	var_01.var_BF1B = 8;
	var_01.var_11A2E = param_00.size;
	var_01.var_10310 = param_00.size;
	var_01.var_C053 = param_00;
	for(var_02 = 0;var_02 < var_01.var_11A2E;var_02++)
	{
		var_01 = func_B097(var_01);
		var_01.var_10310--;
	}
}

//Function Number: 8
func_B095(param_00,param_01,param_02)
{
	var_03 = param_01.size;
	var_04 = param_02;
	foreach(var_08, var_06 in param_01)
	{
		var_07 = 1;
		if(var_04 > var_03)
		{
			var_07 = 2;
		}

		if(isdefined(level.var_B092))
		{
			level.var_B093 = var_06;
			var_06.var_92B9 = 2;
		}
		else
		{
			level.var_B092 = var_06;
			var_06.var_92B9 = 1;
		}

		var_06 thread func_116DD(var_07,param_00,var_08);
		var_04 = var_04 - var_07;
	}
}

//Function Number: 9
func_B080(param_00,param_01)
{
	var_02 = 0;
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = "vault_locker_light_" + var_03 + "_on";
		var_05 = param_00[var_03] func_AF09(var_04,param_01);
	}

	return var_02;
}

//Function Number: 10
func_AF09(param_00,param_01)
{
	var_02 = getentarray(self.target,"targetname");
	var_03 = [];
	var_04 = [];
	var_05 = undefined;
	var_06 = undefined;
	foreach(var_08 in var_02)
	{
		if(var_08.classname == "script_model")
		{
			var_05 = var_08;
			continue;
		}

		if(var_08.classname == "script_brushmodel")
		{
			var_04 = scripts\common\utility::array_add(var_04,var_08);
			continue;
		}

		if(isdefined(var_08.script_noteworthy) && var_08.script_noteworthy == "loot_locker_volume")
		{
			var_06 = var_08;
			continue;
		}

		var_03 = scripts\common\utility::array_add(var_03,var_08);
	}

	thread func_AF0F(param_00,var_03);
	thread func_AF04(param_00,var_05,var_04);
}

//Function Number: 11
func_AF04(param_00,param_01,param_02)
{
	thread lib_0E46::func_48C4(undefined,undefined,undefined,undefined,undefined,undefined,0);
	lib_0E46::func_9016();
	level.player notify("opening_armory_locker");
	level notify(param_00);
	param_01 thread func_AF05(param_02);
	function_0178("loot_locker_open",self.origin);
}

//Function Number: 12
func_AF05(param_00)
{
	var_01 = self;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	foreach(var_06 in param_00)
	{
		if(var_06.script_noteworthy == "left_door")
		{
			var_02 = var_06;
			continue;
		}

		if(var_06.script_noteworthy == "right_door")
		{
			var_03 = var_06;
			continue;
		}

		var_04 = var_06;
	}

	var_01 method_83D0(#animtree);
	var_02 linkto(var_01,"j_door_r");
	var_03 linkto(var_01,"j_door_l");
	var_01.var_1FBB = "loot_locker";
	var_01 lib_0B06::func_1F35(var_01,"open_locker_doors");
	if(isdefined(var_04))
	{
		var_04 delete();
	}
}

//Function Number: 13
func_AF0F(param_00,param_01)
{
	if(!isdefined(self.target))
	{
		return;
	}

	var_02 = 0;
	foreach(var_04 in param_01)
	{
		if(var_02 < 2 && randomint(100) > 25)
		{
			var_04 scripts\sp\_lights::func_9661(undefined,undefined,0.1,0.25,undefined,undefined,undefined,undefined,undefined,param_00,undefined);
			var_02++;
			continue;
		}

		var_04 scripts\sp\_lights::func_9662(undefined,undefined,undefined,undefined,param_00);
	}
}

//Function Number: 14
func_B097(param_00)
{
	param_00 = func_13C4B(param_00);
	var_01 = level.var_D9E5["weapon_pickups"];
	var_02 = level.var_D9E5["optionalunlocks"];
	if(param_00.var_1067C == 1)
	{
		param_00 = func_3E94(param_00);
		if(param_00.var_F1B8 != "none" && lib_0A2F::func_9B49(param_00.var_F1B8))
		{
			var_03 = lib_0A2F::func_3179(param_00.var_F1B8,"random",undefined,0,0,3);
			if(isdefined(var_03))
			{
				param_00.var_F1B8 = param_00.var_F1B8 + "+" + var_03;
			}

			var_04 = spawn("weapon_" + param_00.var_F1B8,param_00.var_F1B5.origin,1);
			var_04.angles = param_00.var_F1B5.angles;
			var_04 thread func_13C65();
			if(getdvarint("progression_on") == 1)
			{
				var_05 = getweaponbasename(param_00.var_F1B8);
				if(scripts\common\utility::func_2286(var_02,var_05))
				{
					var_04 scripts\sp\_utility::func_9196(4,1,0,"new_weapon");
					level.var_D9E5["armoryweapons"][level.var_D9E5["armoryweapons"].size] = var_04;
				}
			}
		}
	}

	return param_00;
}

//Function Number: 15
func_13C65()
{
	self endon("death");
	var_00 = getsubstr(self.classname,7);
	self waittill("trigger");
	level.player givemaxammo(var_00);
}

//Function Number: 16
func_116DF()
{
	var_00 = randomintrange(0,2);
	return var_00;
}

//Function Number: 17
func_13C4B(param_00)
{
	param_00.var_1067C = 1;
	return param_00;
}

//Function Number: 18
func_3E94(param_00,param_01)
{
	if(!isdefined(scripts\common\utility::func_7CF1()))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	param_00.var_3850 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = ["none"];
	if(!param_01)
	{
		var_04 = lib_0A2F::func_D9FA();
	}

	var_04 = scripts\common\utility::array_combine(var_04,lib_0A2F::func_DA0A());
	var_04 = scripts\common\utility::array_combine(var_04,lib_0A2F::func_DA10());
	if(param_00.var_BF1B > 0 && scripts\common\utility::func_7CF1() != "rogue" && scripts\common\utility::func_7CF1() != "moon_port")
	{
		var_05 = randomfloatrange(0,1);
		if(param_00.var_BF1B / 8 >= var_05)
		{
			if(level.var_D9E5["optionalunlocks"].size > 0)
			{
				level.var_D9E5["optionalunlocks"] = scripts\common\utility::array_randomize(level.var_D9E5["optionalunlocks"]);
				foreach(var_07 in level.var_D9E5["optionalunlocks"])
				{
					if(scripts\common\utility::func_2286(level.var_D9E5["loaded_weapons"],var_07))
					{
						var_02 = var_07;
						break;
					}
				}

				if(isdefined(var_02))
				{
					var_03 = func_13C06(var_02,param_00.var_C053);
				}

				if(isdefined(var_03))
				{
					param_00.var_F1B8 = var_02;
					param_00.var_F1B5 = var_03;
					param_00.var_C053 = scripts\common\utility::func_22A9(param_00.var_C053,var_03);
					param_00.var_C053 = scripts\common\utility::array_randomize(param_00.var_C053);
					param_00.var_BF1B--;
					return param_00;
				}
			}
		}
	}

	if(!isdefined(param_00.var_3850))
	{
		param_00.var_3850 = [];
		foreach(var_0A in level.var_D9E5["loaded_weapons"])
		{
			if(!scripts\common\utility::func_2286(var_04,var_0A) && !scripts\common\utility::func_2286(level.var_D9E5["optionalunlocks"],var_0A))
			{
				param_00.var_3850 = scripts\common\utility::array_add(param_00.var_3850,var_0A);
			}
		}
	}

	param_00.var_3850 = scripts\common\utility::array_randomize(param_00.var_3850);
	var_02 = undefined;
	var_03 = undefined;
	if(!isdefined(param_00.var_845F))
	{
		param_00.var_845F = 0;
	}

	for(var_0C = 0;var_0C < param_00.var_3850.size;var_0C++)
	{
		if(scripts\common\utility::func_7CF1() == "rogue")
		{
			if(param_00.var_10310 < param_00.var_11A2E)
			{
				param_00.var_845F = 1;
			}

			if(param_00.var_845F && randomint(100) > 25)
			{
				var_03 = undefined;
				var_02 = undefined;
				break;
			}

			var_02 = param_00.var_3850[var_0C];
			if(weaponclass(var_02) == "spread")
			{
				var_03 = func_13C06(var_02,param_00.var_C053);
				break;
			}

			continue;
		}

		if(scripts\common\utility::func_7CF1() == "moon_port")
		{
			var_02 = param_00.var_3850[var_0C];
			if(!isdefined(param_00.var_8460))
			{
				param_00.var_8460 = 0;
			}

			if(!isdefined(param_00.var_8461))
			{
				param_00.var_8461 = 0;
			}

			if(var_02 == "iw7_devastator" && param_00.var_8461 < 12)
			{
				var_03 = func_13C06(var_02,param_00.var_C053);
				param_00.var_8461++;
				break;
			}
			else if(var_02 == "iw7_mauler" && param_00.var_8460 < 12)
			{
				var_03 = func_13C06(var_02,param_00.var_C053);
				param_00.var_8460++;
				break;
			}

			continue;
		}

		var_02 = param_00.var_3850[var_0C];
		var_03 = func_13C06(var_02,param_00.var_C053);
		break;
	}

	if(isdefined(var_03))
	{
		param_00.var_F1B8 = var_02;
		param_00.var_F1B5 = var_03;
		param_00.var_C053 = scripts\common\utility::func_22A9(param_00.var_C053,var_03);
		param_00.var_C053 = scripts\common\utility::array_randomize(param_00.var_C053);
	}
	else
	{
		param_00.var_F1B8 = "none";
	}

	return param_00;
}

//Function Number: 19
func_13C06(param_00,param_01)
{
	var_02 = scripts\common\utility::func_13C07(param_00);
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = 0;
	if(isdefined(level.var_72A6))
	{
		if(level.var_72A6 == "silencer")
		{
			var_07 = 1;
		}
	}

	if(param_00 == "iw7_sdflmg")
	{
		var_06 = 0.2;
	}
	else if(param_00 == "iw7_ar57")
	{
		if(var_07)
		{
			var_02 = "silenced_smg";
		}

		var_06 = 0;
	}
	else if(param_00 == "iw7_crb")
	{
		if(var_07)
		{
			var_02 = "silenced_smg";
		}

		var_06 = 2.8;
	}
	else if(param_00 == "iw7_devastator")
	{
		var_06 = 0.5;
	}
	else if(param_00 == "iw7_m8")
	{
		var_06 = 0.2;
	}
	else if(param_00 == "iw7_kbs")
	{
		var_06 = 4.8;
	}
	else if(param_00 == "iw7_fmg")
	{
		if(var_07)
		{
			var_02 = "silenced_smg";
		}

		var_06 = -1;
	}
	else if(param_00 == "iw7_ripper")
	{
		var_06 = -1;
	}
	else if(param_00 == "iw7_ump45")
	{
		if(var_07)
		{
			var_02 = "silenced_smg";
		}

		var_06 = -4;
	}
	else if(param_00 == "iw7_erad")
	{
		if(var_07)
		{
			var_02 = "silenced_smg";
		}

		var_06 = 0;
	}
	else if(param_00 == "iw7_fhr")
	{
		if(var_07)
		{
			var_02 = "silenced_smg";
		}

		var_06 = 1;
	}
	else if(param_00 == "iw7_ake")
	{
		var_02 = "sniper";
		var_06 = 0.8;
	}
	else if(param_00 == "iw7_m4")
	{
		var_02 = "sniper";
		var_06 = 0.2;
	}
	else if(param_00 == "iw7_sdfar")
	{
		var_02 = "large_ar";
		var_06 = -0.6;
	}
	else if(param_00 == "iw7_sonic")
	{
		var_02 = "large_shotgun";
		var_06 = -3.2;
	}
	else if(param_00 == "iw7_sdfshotty")
	{
		var_02 = "large_shotgun";
		var_06 = -1.2;
	}
	else if(param_00 == "iw7_mauler")
	{
		var_02 = "extra_large";
	}

	switch(var_02)
	{
		case "extra_large":
			var_05 = "extra_large";
			break;

		case "sniper":
			var_05 = "large";
			break;

		case "large_shotgun":
			var_05 = "large";
			break;

		case "large_ar":
			var_05 = "large";
			break;

		case "mg":
			var_05 = "large";
			break;

		case "pistol":
			var_05 = "pistol";
			break;

		case "beam":
			var_05 = "large";
			break;

		case "silenced_shotgun":
			var_05 = "large";
			break;

		case "silenced_smg":
			var_05 = "large";
			break;
	}

	if(lib_0A2F::func_DA40(param_00))
	{
		var_05 = "heavy";
	}

	var_08 = undefined;
	var_09 = undefined;
	if(isdefined(var_05) && var_05 == "extra_large")
	{
		foreach(var_0B in param_01)
		{
			var_0C = var_0B scripts\sp\_utility::func_7A97();
			if(var_0C.size > 0)
			{
				foreach(var_0E in var_0C)
				{
					if(isdefined(var_0E.script_noteworthy))
					{
						var_0F = var_0E scripts\sp\_utility::func_7A97();
						foreach(var_09 in var_0F)
						{
							if(scripts\common\utility::func_2286(param_01,var_0E))
							{
								if(scripts\common\utility::func_2286(param_01,var_09))
								{
									if(isdefined(var_09.var_EE79) && var_09.var_EE79 == "extra_large")
									{
										var_03 = var_09;
										break;
									}
								}
							}
						}
					}
				}
			}

			if(isdefined(var_03))
			{
				break;
			}
		}
	}
	else if(isdefined(var_06) && var_06 == "large")
	{
		foreach(var_0B in var_02)
		{
			var_15 = 0;
			var_16 = 0;
			if(isdefined(var_0B.var_EE79) && var_0B.var_EE79 == "large")
			{
				var_0C = var_0B scripts\sp\_utility::func_7A97();
				if(var_0C.size > 0)
				{
					foreach(var_0E in var_0C)
					{
						if(!scripts\common\utility::func_2286(param_01,var_0E))
						{
							if(isdefined(var_0B.script_noteworthy) && var_0B.script_noteworthy == "stacked")
							{
								if(isdefined(var_0E.var_EE79) && var_0E.var_EE79 == "extra_large")
								{
									var_15 = 1;
								}
							}
						}

						if(!scripts\common\utility::func_2286(param_01,var_0E) && param_00 == "iw7_sdflmg")
						{
							if(!isdefined(var_0B.script_noteworthy))
							{
								if(isdefined(var_0E.var_EE79) && var_0E.var_EE79 == "extra_large")
								{
									var_16 = 1;
								}
							}
						}
					}
				}
				else
				{
					if(param_00 == "iw7_smg")
					{
						var_16 = 1;
					}

					if(isdefined(var_0B.script_noteworthy) && var_0B.script_noteworthy == "stacked")
					{
						var_15 = 1;
					}
				}

				if(!var_15 && !var_16)
				{
					var_03 = var_0B;
					break;
				}
			}
		}
	}
	else if(isdefined(var_06) && var_06 == "heavy")
	{
		foreach(var_0B in var_02)
		{
			if(isdefined(var_0B.var_EE79) && var_0B.var_EE79 == "heavy")
			{
				var_03 = var_0B;
				break;
			}
		}
	}
	else if(isdefined(var_06) && var_06 == "pistol")
	{
		foreach(var_0B in var_02)
		{
			if(isdefined(var_0B.var_EE79) && var_0B.var_EE79 == "pistol")
			{
				if(isdefined(var_0B.script_noteworthy) && var_0B.script_noteworthy == "locker_weapon")
				{
					var_03 = var_0B;
					break;
				}
				else
				{
					var_04 = var_0B;
				}
			}
		}

		if(!isdefined(var_03))
		{
			var_03 = var_04;
		}
	}
	else
	{
		foreach(var_0B in var_02)
		{
			if(!isdefined(var_0B.var_EE79))
			{
				if(isdefined(var_0B.script_noteworthy) && var_0B.script_noteworthy == "locker_weapon")
				{
					var_03 = var_0B;
					break;
				}
				else
				{
					var_04 = var_0B;
				}
			}
		}

		if(!isdefined(var_03))
		{
			var_03 = var_04;
		}
	}

	if(isdefined(var_06) && isdefined(var_03))
	{
		var_03.origin = var_03.origin + (0,0,var_06);
	}

	return var_03;
}

//Function Number: 20
func_53BE()
{
	var_00 = scripts\common\utility::random(["","small","medium","large"]);
	return var_00;
}

//Function Number: 21
func_116DD(param_00,param_01,param_02)
{
	func_8835();
	setomnvar("ui_inworld_terminal_hack",0);
	if(isdefined(self.var_92B9) && self.var_92B9 == 1)
	{
		func_F3F0("on");
	}
	else
	{
		func_F3F0("on",1);
	}

	if(lib_0A2F::func_DA44(param_01,param_02))
	{
		if(isdefined(self.var_92B9) && self.var_92B9 == 1)
		{
			func_F3F0("hacked");
		}
		else
		{
			func_F3F0("hacked",1);
		}

		return;
	}

	var_03 = scripts\common\utility::spawn_tag_origin(self.origin,self.angles);
	var_03 thread lib_0E46::func_48C4("tag_origin",undefined,undefined,undefined,undefined,35,0);
	var_03 lib_0E46::func_9016();
	var_04 = undefined;
	var_05 = getent(self.target,"targetname");
	var_04 = var_05 scripts\common\utility::spawn_tag_origin();
	level.player playsound("armory_terminal_start_use");
	var_06 = var_04 scripts\sp\_dooruse::func_FA17("hack_terminal");
	thread func_8834(var_06);
	var_06 thread func_116DC("hack_terminal",param_00,param_01);
	var_04 lib_0B06::func_1F35(var_06,"hack_terminal");
	lib_0A2F::func_DA4D(param_01,param_02);
	var_06 delete();
	level.player scripts\sp\_dooruse::func_5990();
	level.player unlink();
	var_03 delete();
	var_04 delete();
}

//Function Number: 22
func_9C55(param_00)
{
	var_01 = lib_0A2F::func_D9F8("items");
	return scripts\common\utility::func_2286(var_01,param_00);
}

//Function Number: 23
func_116DC(param_00,param_01,param_02)
{
	level.player notify("armory_terminal_start");
	var_03 = getanimlength(scripts\sp\_utility::func_7DC1(param_00));
	var_04 = [];
	var_05 = ["frag","antigrav","emp","seeker","frag","seeker","offhandshield","antigrav","emp","hackingdevice","supportdrone","coverwall"];
	level.player playsound("armory_terminal_tick");
	wait(var_03 / 2);
	level.player playsound("armory_terminal_tick");
	wait(var_03 / 2);
	level.player playsound("armory_terminal_got_file");
	for(var_06 = 0;var_06 < param_01;var_06++)
	{
		var_07 = 0;
		var_08 = lib_0A2F::func_D9F8();
		foreach(var_0A in var_08)
		{
			var_0B = level.player method_84C6("equipmentState",var_0A);
			if(!isdefined(var_0B))
			{
				continue;
			}

			if(var_0B == "upgrade2")
			{
				var_07 = var_07 + 2;
				continue;
			}

			if(var_0B == "upgrade1")
			{
				var_07 = var_07 + 1;
			}
		}

		var_0D = var_05[var_07];
		var_0E = level.player method_84C6("equipmentState",var_0D);
		var_0F = "upgrade1";
		if(isdefined(var_0E) && var_0E == "upgrade1")
		{
			var_0F = "upgrade2";
		}

		if(var_0D == "coverwall" && var_0F == "upgrade1")
		{
			if(level.player.var_4759.var_19.size > 0)
			{
				level.player thread scripts\sp\_coverwall::func_B9C4();
			}
		}

		level.player method_84C7("equipmentState",var_0D,var_0F);
		level.var_D9E5["weaponstates"][var_0D] = var_0F;
		lib_0A2F::func_82FE(var_0D,var_0F);
		var_04 = scripts\common\utility::array_add(var_04,var_0D);
	}

	level thread terminal_unlocks_ui(var_04,param_01);
	level.player playsound("armory_terminal_finish");
	level.player notify("armory_terminal_finish");
	lib_0A2F::func_3D6E();
	var_10 = "armory" + param_02;
	scripts\sp\_utility::func_266A(var_10);
}

//Function Number: 24
terminal_unlocks_ui(param_00,param_01)
{
	scripts\common\utility::func_136F7();
	if(scripts\common\utility::flag("game_saving"))
	{
		wait(0.25);
	}

	thread clearomnvaronautosave("ui_loot_unlocked");
	var_02 = param_00.size;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = param_00[var_03];
		setomnvar("ui_loot_unlocked",var_04);
		wait(3);
		if(var_03 < var_02 - 1)
		{
			while(scripts\common\utility::flag("game_saving"))
			{
				scripts\common\utility::func_136F7();
			}
		}
	}

	setomnvar("ui_files_acquired",param_01);
	setomnvar("ui_loot_unlocked","none");
	level notify("ClearOmnvarOnAutoSave_Abort");
}

//Function Number: 25
clearomnvaronautosave(param_00)
{
	level endon("ClearOmnvarOnAutoSave_Abort");
	for(;;)
	{
		level waittill("trying_new_autosave");
		setomnvar(param_00,"none");
	}
}

//Function Number: 26
func_FA17(param_00)
{
	var_01 = scripts\sp\_utility::func_10639("player_arms");
	var_02 = level.player method_84C6("currentViewModel");
	if(isdefined(var_02))
	{
		var_01 setmodel(var_02);
	}

	var_01 hide();
	var_03 = [var_01,self];
	thread lib_0B06::func_1EC3(var_01,param_00);
	var_04 = scripts\common\utility::spawn_tag_origin(level.player.origin,level.player getplayerangles());
	level.player playerlinktoabsolute(var_04,"tag_origin");
	wait(0.05);
	var_05 = 1;
	level.player playerlinktoblend(var_01,"tag_player",var_05,0.25,0.25);
	level.player scripts\sp\_dooruse::func_598D();
	wait(var_05);
	level.player playerlinktodelta(var_01,"tag_player",0,5,5,5,5);
	var_01 show();
	var_04 delete();
	return var_01;
}

//Function Number: 27
func_2246()
{
}

//Function Number: 28
func_8835()
{
	if(!isdefined(self.angles))
	{
		self.angles = (0,0,0);
	}

	self.var_87EB = [];
	var_00 = undefined;
	if(isdefined(self.target))
	{
		var_00 = getent(self.target,"targetname");
	}

	if(isdefined(var_00))
	{
		self.var_87EB["fx_tag"] = var_00 scripts\common\utility::spawn_tag_origin();
		self.var_87EB["fx_tag"].origin = self.var_87EB["fx_tag"].origin + anglestoforward(var_00.angles) * 47.9;
		self.var_87EB["fx_tag"].origin = self.var_87EB["fx_tag"].origin + anglestoup(var_00.angles) * 52;
	}
	else
	{
		self.var_87EB["fx_tag"] = scripts\common\utility::spawn_tag_origin();
	}

	if(!isdefined(var_00))
	{
		self.var_87EB["fx_tag"].origin = self.origin + anglestoforward(self.angles) * -2;
		self.var_87EB["fx_tag"].angles = self.angles + (73,0,0);
	}
}

//Function Number: 29
func_87EC()
{
	level._effect["vfx_ui_terminal_press"] = loadfx("vfx/iw7/core/ui/vfx_ui_terminal_press.vfx");
	level._effect["vfx_ui_terminal_off"] = loadfx("vfx/iw7/core/ui/vfx_ui_terminal_off.vfx");
	level._effect["vfx_ui_terminal_on"] = loadfx("vfx/iw7/core/ui/vfx_ui_terminal_on.vfx");
	level._effect["vfx_ui_terminal_firmware"] = loadfx("vfx/iw7/core/ui/vfx_ui_terminal_firmware.vfx");
	level._effect["vfx_ui_terminal_hack"] = loadfx("vfx/iw7/core/ui/vfx_ui_terminal_hack.vfx");
	level._effect["vfx_ui_terminal_success"] = loadfx("vfx/iw7/core/ui/vfx_ui_terminal_success.vfx");
	level._effect["vfx_ui_terminal_suit"] = loadfx("vfx/iw7/core/ui/vfx_ui_terminal_suit.vfx");
}

//Function Number: 30
func_8834(param_00)
{
	if(isdefined(self.var_92B9) && self.var_92B9 == 1)
	{
		func_F3F0("hack");
	}
	else
	{
		func_F3F0("hack",1);
	}

	setomnvar("ui_inworld_terminal_wrist_ent",param_00);
	setomnvar("ui_wrist_pc",7);
	wait(6);
	setomnvar("ui_wrist_pc",0);
}

//Function Number: 31
func_F3F0(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "on";
	}

	var_02 = self.var_87EB["fx_tag"];
	if(isdefined(param_01) && param_01)
	{
		setomnvar("ui_inworld_terminal_ent_2",var_02);
		setomnvar("ui_inworld_terminal_hack2",1);
		setomnvar("ui_inworld_terminal_hack2",0);
	}
	else
	{
		setomnvar("ui_inworld_terminal_ent",var_02);
		setomnvar("ui_inworld_terminal_hack",1);
		setomnvar("ui_inworld_terminal_hack",0);
	}

	wait(0.3);
	switch(param_00)
	{
		case "on":
			setomnvar("ui_inworld_terminal_on",1);
			if(isdefined(param_01) && param_01)
			{
				setomnvar("ui_inworld_terminal_hack2",0);
			}
			else
			{
				setomnvar("ui_inworld_terminal_hack",0);
			}
			break;

		case "hacked":
			if(!getomnvar("ui_inworld_terminal_on"))
			{
				setomnvar("ui_inworld_terminal_on",1);
			}
	
			if(isdefined(param_01) && param_01)
			{
				setomnvar("ui_inworld_terminal_hack2",2);
			}
			else
			{
				setomnvar("ui_inworld_terminal_hack",2);
			}
			break;

		case "hack":
			if(isdefined(param_01) && param_01)
			{
				setomnvar("ui_inworld_terminal_hack2",1);
			}
			else
			{
				setomnvar("ui_inworld_terminal_hack",1);
			}
			break;

		case "off":
			setomnvar("ui_inworld_terminal_on",0);
			if(isdefined(param_01) && param_01)
			{
				setomnvar("ui_inworld_terminal_hack2",0);
			}
			else
			{
				setomnvar("ui_inworld_terminal_hack",0);
			}
			break;
	}
}