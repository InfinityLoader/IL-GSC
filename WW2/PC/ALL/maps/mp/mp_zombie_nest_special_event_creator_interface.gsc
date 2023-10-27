/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_zombie_nest_special_event_creator_interface.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 329 ms
 * Timestamp: 10/27/2023 3:20:00 AM
*******************************************************************/

//Function Number: 1
func_8F2A(param_00)
{
	var_01 = isdefined(level.var_8E3) && level.var_8E3.size > 0;
	if(!var_01)
	{
		return 0;
	}

	if(isdefined(param_00))
	{
		var_02 = 0;
		foreach(var_04 in level.var_8E3)
		{
			if(issubstr(var_04.var_695B,param_00))
			{
				return 1;
			}
		}

		return 0;
	}

	return 1;
}

//Function Number: 2
func_ABD2(param_00)
{
	foreach(var_02 in level.var_8CB)
	{
		if(!isdefined(var_02.var_65D6))
		{
			continue;
		}

		foreach(var_04 in var_02.var_65D6)
		{
			if(isdefined(var_04) && isdefined(param_00) && var_04 == param_00)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 3
func_08F4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = common_scripts\utility::func_46B5(param_07,"targetname");
	var_09 = common_scripts\utility::func_46B7(var_08.var_1A2,"targetname");
	foreach(var_0B in var_09)
	{
		var_0B.var_38B2 = param_00.var_38C3;
	}

	param_00.var_65D6 = [];
	param_00.var_ABEA = spawnstruct();
	param_00.var_ABEA.var_5054 = var_09;
	param_00.var_ABEA.var_1176 = param_01;
	param_00.var_ABEA.var_67EA = param_02;
	param_00.var_ABEA.var_AC7C = param_03;
	param_00.var_ABEA.var_38B7 = param_04;
	param_00.var_ABEA.var_38B8 = param_05;
	param_00.var_ABEA.var_29B3 = param_06;
	param_00.var_ABEA.var_504B = param_07;
	var_0D = param_00.var_38C4["zombieObjectiveMax"];
	var_0E = param_00.var_38C4["respawnExclusionRadius"];
	func_52F1(param_00);
	level thread func_7F7C();
}

//Function Number: 4
func_52F1(param_00)
{
	param_00.var_ABEA.var_1176 maps/mp/mp_zombie_nest_ee_tower_battle_zombie_states::func_52DD(param_00);
}

//Function Number: 5
func_7C69(param_00)
{
	func_23C4(param_00);
	param_00.var_ABEA = undefined;
}

//Function Number: 6
func_7F7C()
{
	level notify("new_zombie_defense_event");
	level endon("new_zombie_defense_event");
	maps/mp/mp_zombie_nest_ee_wave_manipulation::func_8606();
	var_00 = 0.125;
	var_01 = 0;
	while(lib_0547::func_795())
	{
		foreach(var_03 in level.var_8CB)
		{
			if(!common_scripts\utility::func_562E(var_03.var_552B))
			{
				continue;
			}

			var_03.var_65D6 = func_23B0(var_03);
			var_01 = func_2C2B(var_03);
			if(var_01)
			{
				break;
			}

			maps/mp/mp_zombie_nest_special_event_creator_util::func_2C2C(var_03,5000);
			func_2C2D(var_03,var_00);
			var_03 func_2E60();
		}

		func_7C82();
		foreach(var_06 in level.var_744A)
		{
			var_06.var_5579 = var_06 maps/mp/mp_zombie_nest_special_event_creator_util::func_600B();
		}

		if(var_01)
		{
			maps/mp/mp_zombie_nest_ee_tower_battle_zombie_states::func_23A0();
			maps/mp/mp_zombie_nest_ee_tower_battle_zombie_states::func_A63F();
		}

		if(lib_0547::func_BC7())
		{
			maps/mp/mp_zombie_nest_ee_wave_manipulation::func_8607();
		}

		if(lib_0547::func_796())
		{
			maps/mp/mp_zombie_nest_ee_wave_manipulation::func_8606();
		}

		wait(var_00);
	}

	maps/mp/mp_zombie_nest_ee_tower_battle_zombie_states::func_23A0();
	maps/mp/mp_zombie_nest_ee_wave_manipulation::func_8607();
}

//Function Number: 7
func_7C82()
{
	var_00 = [];
	foreach(var_02 in level.var_8CB)
	{
		if(!isdefined(var_02) || !isdefined(var_02.var_65D6))
		{
			continue;
		}

		foreach(var_04 in var_02.var_65D6)
		{
			if(!isdefined(var_04))
			{
				continue;
			}

			if(!common_scripts\utility::func_F79(var_00,var_04))
			{
				var_00 = common_scripts\utility::func_F6F(var_00,var_04);
				continue;
			}

			var_02.var_65D6 = common_scripts\utility::func_F93(var_02.var_65D6,var_04);
		}
	}
}

//Function Number: 8
func_2E60()
{
	var_00 = lib_0547::func_408F();
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.var_9B61) && isdefined(var_02.var_9B61.var_38B2))
		{
			if(var_02.var_9B61.var_38B2 == self.var_38C3 && !common_scripts\utility::func_F79(self.var_65D6,var_02))
			{
				self.var_65D6 = common_scripts\utility::func_F6F(self.var_65D6,var_02);
			}

			if(var_02.var_9B61.var_38B2 != self.var_38C3 && common_scripts\utility::func_F79(self.var_65D6,var_02))
			{
				self.var_65D6 = common_scripts\utility::func_F93(self.var_65D6,var_02);
			}
		}
	}
}

//Function Number: 9
func_23B0(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00.var_65D6)
	{
		if(isdefined(var_03) && isalive(var_03))
		{
			var_01 = common_scripts\utility::func_F6F(var_01,var_03);
		}
	}

	return var_01;
}

//Function Number: 10
func_23C4(param_00)
{
	if(isdefined(param_00) && isdefined(param_00.var_65D6))
	{
		foreach(var_02 in param_00.var_65D6)
		{
			if(isdefined(var_02) && isalive(var_02))
			{
				var_02 maps/mp/mp_zombie_nest_ee_tower_battle_zombie_states::func_8605();
			}
		}

		param_00.var_65D6 = [];
	}
}

//Function Number: 11
func_2C2B(param_00)
{
	var_01 = ["zombie_generic","zombie_berserker"];
	var_02 = 0;
	var_03 = maps/mp/mp_zombie_nest_ee_tower_battle_zombie_states::func_4082(param_00.var_ABEA.var_1176);
	var_02 = maps/mp/mp_zombie_nest_ee_tower_battle_zombie_states::func_7C0F(param_00.var_ABEA.var_1176,var_01);
	var_04 = maps/mp/mp_zombie_nest_ee_tower_battle_zombie_states::func_425A(var_01,param_00.var_ABEA.var_38B7);
	if(!var_02)
	{
		param_00 maps/mp/mp_zombie_nest_ee_tower_battle_zombie_states::func_9E0E(var_04,var_03,param_00.var_ABEA.var_5054,var_01,param_00.var_38C4["zombieObjectiveMax"]);
	}

	return var_02;
}

//Function Number: 12
func_2C2D(param_00,param_01)
{
	if(level.var_744A.size > 1)
	{
		var_02 = param_00.var_38C4["objectiveHealth"];
	}
	else
	{
		var_02 = param_01.var_38C4["objectiveHealthSolo"];
	}

	var_03 = param_00.var_ABEA.var_1176;
	var_04 = 0;
	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		var_06 = var_03[var_05] maps/mp/mp_zombie_nest_special_event_creator_util::func_45BC();
		for(var_07 = 0;var_07 < var_06;var_07++)
		{
			var_03[var_05].var_28FF = var_03[var_05].var_28FF - param_01;
			var_03[var_05] thread lib_0378::func_8D74("aud_tower_machine_zombie_hit");
			var_04 = 1;
		}

		[[ param_00.var_ABEA.var_29B3 ]](var_03[var_05],var_02,var_04);
		if(var_03[var_05].var_28FF <= 0)
		{
			var_08 = 1;
			for(var_05 = 0;var_05 < var_03.size;var_05++)
			{
				var_03[var_05].var_28FF = 0;
				var_03[var_05] notify(param_00.var_ABEA.var_67EA.var_39D1);
			}
		}
	}

	maps/mp/mp_zombie_nest_special_event_creator_util::func_11B4(var_03);
}

//Function Number: 13
func_55C0()
{
	if(lib_0547::func_796())
	{
		for(var_00 = 0;var_00 < level.var_8CB.size;var_00++)
		{
			if(distance(self.var_116,level.var_8CB[var_00].var_38B7) < level.var_8CB[var_00].var_38BA)
			{
				return 1;
			}
		}

		return 0;
	}

	return 0;
}

//Function Number: 14
func_9959()
{
	foreach(var_01 in level.var_744A)
	{
		for(var_02 = 0;var_02 < level.var_8CB.size;var_02++)
		{
			if(isalive(var_01) && !common_scripts\utility::func_562E(var_01.var_5378) && var_01 func_55C1(level.var_8CB[var_02]))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 15
func_55C1(param_00)
{
	return distance(self.var_116,param_00.var_38B7) < param_00.var_38BA;
}

//Function Number: 16
func_405B()
{
	var_00 = common_scripts\utility::func_7A33(level.var_8CB);
	return var_00.var_38C2;
}

//Function Number: 17
func_08F3(param_00)
{
	if(!isdefined(level.var_8CB))
	{
		level.var_8CB = [];
	}

	level.var_8CB = common_scripts\utility::func_F6F(level.var_8CB,param_00);
}

//Function Number: 18
func_7C68(param_00)
{
	level.var_8CB = common_scripts\utility::func_F93(level.var_8CB,param_00);
}