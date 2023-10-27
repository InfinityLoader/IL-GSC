/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2857.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 16 ms
 * Timestamp: 10/27/2023 12:24:18 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_66A3 = [];
	level.var_66AC = 1000;
	level.var_66AB = 1000;
	level.player.var_110BD = "";
	level.player.var_110BE = 0;
	level.player.var_110BA = "";
	level.player.var_110BB = 0;
	level.player.var_4B2B = "";
	level.player.var_4B21 = "";
	level.player.var_110C0 = 0;
	thread func_11B9();
	level.player thread func_13FF();
	func_135F();
	thread func_1271();
}

//Function Number: 2
func_F391(param_00,param_01)
{
	var_02 = strtok(param_00,"_");
	var_03 = undefined;
	var_04 = undefined;
	var_05 = level.player getweaponslistoffhands();
	for(var_06 = 0;var_06 < var_05.size;var_06++)
	{
		if(func_12F5(var_05[var_06]))
		{
			var_03 = strtok(var_05[var_06],"_");
		}

		if(func_12F1(var_05[var_06]))
		{
			var_04 = strtok(var_05[var_06],"_");
		}
	}

	var_07 = func_128A(param_01,0,1,-1,1000);
	var_08 = 0;
	if(isdefined(var_03) && var_02[0] == var_03[0])
	{
		if(level.var_66AC > var_07)
		{
			var_08 = 1;
		}

		setomnvar("ui_power_recharge",int(var_07));
		setomnvar("ui_power_consume",var_08);
		level.var_66AC = var_07;
		return;
	}

	if(isdefined(var_04) && var_02[0] == var_04[0])
	{
		if(level.var_66AB > var_07)
		{
			var_08 = 1;
		}

		setomnvar("ui_power_secondary_recharge",int(var_07));
		setomnvar("ui_power_secondary_consume",var_08);
		level.var_66AB = var_07;
		return;
	}
}

//Function Number: 3
func_F392(param_00,param_01)
{
	var_02 = strtok(param_00,"_");
	var_03 = undefined;
	var_04 = undefined;
	var_05 = level.player getweaponslistoffhands();
	for(var_06 = 0;var_06 < var_05.size;var_06++)
	{
		if(func_12F5(var_05[var_06]))
		{
			var_03 = strtok(var_05[var_06],"_");
		}

		if(func_12F1(var_05[var_06]))
		{
			var_04 = strtok(var_05[var_06],"_");
		}
	}

	if(isdefined(var_03) && var_02[0] == var_03[0])
	{
		setomnvar("ui_power_disabled",param_01);
		return;
	}

	if(isdefined(var_04) && var_02[0] == var_04[0])
	{
		setomnvar("ui_power_secondary_disabled",param_01);
		return;
	}
}

//Function Number: 4
func_11456(param_00)
{
	if(self.var_110BD == param_00)
	{
		self.var_110BD = "";
		self.var_110BE = 0;
	}

	if(self.var_110BA == param_00)
	{
		self.var_110BA = "";
		self.var_110BB = 0;
	}
}

//Function Number: 5
func_11427()
{
	self.var_110BD = "";
	self.var_110BE = 0;
	self.var_110BA = "";
	self.var_110BB = 0;
}

//Function Number: 6
func_135F()
{
	level.var_D79A = [];
	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow("sp/powertable.csv",var_00,0);
		if(var_01 == "")
		{
			break;
		}

		var_02 = tablelookupbyrow("sp/powertable.csv",var_00,1);
		level.var_D79A[var_02] = spawnstruct();
		level.var_D79A[var_02].var_92B8 = var_01;
		level.var_D79A[var_02].var_4613 = tablelookupbyrow("sp/powertable.csv",var_00,6);
		level.var_D79A[var_02].var_B486 = tablelookupbyrow("sp/powertable.csv",var_00,7);
		level.var_D79A[var_02].var_1030F = tablelookupbyrow("sp/powertable.csv",var_00,8);
		level.var_D79A[var_02].var_1E4E = tablelookupbyrow("sp/powertable.csv",var_00,9);
		var_00++;
	}
}

//Function Number: 7
func_129C(param_00)
{
	return func_12A4(param_00).var_1E4E;
}

//Function Number: 8
func_12A4(param_00)
{
	var_01 = strtok(param_00,"_");
	if(!isdefined(level.var_D79A[var_01[0]]))
	{
		level.var_D79A[var_01[0]] = level.var_D79A["none"];
		return level.var_D79A[var_01[0]];
	}

	return level.var_D79A[var_01[0]];
}

//Function Number: 9
func_12A3(param_00)
{
	var_01 = func_12A4(param_00);
	return var_01.var_1030F;
}

//Function Number: 10
func_12F5(param_00)
{
	return func_12A3(param_00) == "0";
}

//Function Number: 11
func_12F1(param_00)
{
	return func_12A3(param_00) == "1";
}

//Function Number: 12
func_11B9()
{
	level.player endon("death");
	var_00 = "none";
	var_01 = 0;
	for(;;)
	{
		var_02 = level.player getcurrentprimaryweapon();
		if(!isdefined(var_02))
		{
			wait(0.05);
			continue;
		}

		var_03 = level.player getweaponammostock(var_02);
		if(var_02 != var_00)
		{
			var_00 = var_02;
			var_01 = var_03;
			wait(0.05);
			continue;
		}

		if(var_03 != var_01)
		{
			if(var_03 > var_01)
			{
				level.player notify("current_primary_ammo");
			}

			var_01 = var_03;
		}

		wait(0.05);
	}
}

//Function Number: 13
func_1270(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_04 = level.player method_854C(var_03);
		if(var_04 != "scriptoffhand")
		{
			var_01 = scripts\common\utility::array_add(var_01,var_03);
		}
	}

	if(isdefined(level.player.var_1180A) && level.player.var_1180A == 1)
	{
		var_06 = level.player.var_127C1;
		if(var_06 != level.player.var_4B2B && var_06 != level.player.var_4B21)
		{
			level.player takeweapon(var_06);
			var_01 = scripts\common\utility::func_22A9(var_01,var_06);
		}

		level.player.var_1180A = 0;
		level.player.var_127C1 = "none";
		level.player.var_1180B = "none";
		level.player.var_AA2B = "none";
	}
	else if(level.player.var_1180B != level.player.var_AA2B && level.player.var_AA2B != "none")
	{
		if(level.player.var_AA2B != level.player.var_4B2B && level.player.var_AA2B != level.player.var_4B21)
		{
			level.player takeweapon(level.player.var_AA2B);
			var_01 = scripts\common\utility::func_22A9(var_01,level.player.var_AA2B);
		}
	}
	else if(level.player.var_1180B != "none")
	{
		if(level.player.var_1180B != level.player.var_4B2B && level.player.var_1180B != level.player.var_4B21)
		{
			var_01 = scripts\common\utility::func_22A9(var_01,level.player.var_1180B);
		}
	}

	return var_01;
}

//Function Number: 14
func_1271()
{
	level.player endon("death");
	level.player.var_1180B = "none";
	var_00 = level.player getweaponslistoffhands();
	var_01 = "";
	var_02 = "";
	var_03 = 0;
	var_04 = 0;
	var_05 = "";
	var_06 = "";
	var_07 = 0;
	var_08 = 0;
	var_09 = [];
	var_0A = "";
	var_0B = "";
	var_0C = "";
	var_0D = "";
	for(;;)
	{
		waittillframeend;
		level.player.var_AA2B = level.player.var_1180B;
		level.player.var_1180B = level.player method_8556();
		if(level.player method_8448())
		{
			level.player.var_1180A = 1;
			level.player.var_127C1 = level.player method_8556();
			wait(0.05);
			continue;
		}

		var_09 = level.player getweaponslistoffhands();
		var_09 = func_1270(var_09);
		func_142E(var_09,var_00);
		var_09 = level.player getweaponslistoffhands();
		var_09 = func_1270(var_09);
		var_0A = "";
		var_0B = "";
		var_0E = 0;
		var_0F = 0;
		var_10 = 0;
		var_11 = 0;
		for(var_12 = 0;var_12 < var_09.size;var_12++)
		{
			if(func_12F5(var_09[var_12]))
			{
				var_0A = var_09[var_12];
			}

			if(func_12F1(var_09[var_12]))
			{
				var_0B = var_09[var_12];
			}
		}

		var_0C = level.player.var_110BD;
		var_0D = level.player.var_110BA;
		level.player.var_4B2B = var_0A;
		level.player.var_4B21 = var_0B;
		if(var_0A != var_01)
		{
			var_0E = 1;
			level.player notify("primary_equipment_change",var_0A);
		}

		if(var_0B != var_02)
		{
			var_0F = 1;
			level.player notify("secondary_equipment_change",var_0B);
		}

		if(var_0C != var_05)
		{
			var_10 = 1;
			level.player notify("stored_primary_equipment_change",var_0C);
		}

		if(var_0D != var_06)
		{
			var_11 = 1;
			level.player notify("stored_secondary_equipment_change",var_0D);
		}

		if(var_0E == 1 || var_0F == 1)
		{
			level.player notify("equipment_change");
		}

		if(var_0A == "")
		{
			func_11A6();
		}
		else
		{
			var_13 = level.player method_80FB(var_0A);
			if(var_0E == 0 && var_13 != var_03)
			{
				level.player notify("offhand_ammo");
				var_03 = var_13;
			}

			func_1434(var_0A,var_13,var_0E);
		}

		if(var_0B == "")
		{
			func_11A5();
		}
		else
		{
			var_13 = level.player method_80FB(var_0B);
			if(var_0F == 0 && var_13 != var_04)
			{
				level.player notify("item_ammo");
				var_04 = var_13;
			}

			func_1433(var_0B,var_13,var_0F);
		}

		if(var_0C == "")
		{
			func_11A8();
		}
		else
		{
			func_1436(var_0C,level.player.var_110BE,var_10);
		}

		if(var_0D == "")
		{
			func_11A7();
		}
		else
		{
			func_1435(var_0D,level.player.var_110BB,var_11);
		}

		var_00 = var_09;
		var_01 = var_0A;
		var_02 = var_0B;
		var_05 = var_0C;
		var_06 = var_0D;
		wait(0.05);
	}
}

//Function Number: 15
func_142E(param_00,param_01)
{
	var_02 = [];
	var_03 = [];
	var_04 = 0;
	var_05 = 0;
	for(var_06 = 0;var_06 < param_00.size;var_06++)
	{
		if(func_12F5(param_00[var_06]))
		{
			var_04 = 1;
		}

		if(func_12F1(param_00[var_06]))
		{
			var_05 = 1;
		}
	}

	if(level.player.var_110C0 && var_04 == 0 && level.player.var_110BD != "")
	{
		level.player giveweapon(level.player.var_110BD);
		level.player method_844B(level.player.var_110BD);
		level.player setweaponammoclip(level.player.var_110BD,level.player.var_110BE);
		level.player.var_110BD = "";
		level.player.var_110BE = 0;
	}

	if(level.player.var_110C0 && var_05 == 0 && level.player.var_110BA != "")
	{
		level.player giveweapon(level.player.var_110BA);
		level.player method_844C(level.player.var_110BA);
		level.player setweaponammoclip(level.player.var_110BA,level.player.var_110BB);
		level.player.var_110BA = "";
		level.player.var_110BB = 0;
	}

	foreach(var_08 in param_00)
	{
		if(!scripts\common\utility::func_2286(param_01,var_08))
		{
			if(func_12F5(var_08))
			{
				if(var_02.size > 1)
				{
					level.player takeweapon(var_02[1]);
					var_02[1] = var_08;
					continue;
				}

				var_02[var_02.size] = var_08;
				continue;
			}

			if(func_12F1(var_08))
			{
				if(var_03.size > 1)
				{
					level.player takeweapon(var_03[1]);
					var_03[1] = var_08;
					continue;
				}

				var_03[var_03.size] = var_08;
			}
		}
	}

	var_0A = undefined;
	var_0B = undefined;
	foreach(var_08 in param_01)
	{
		if(!scripts\common\utility::func_2286(param_00,var_08))
		{
			continue;
		}

		if(func_12F5(var_08))
		{
			var_0A = var_08;
			continue;
		}

		if(func_12F1(var_08))
		{
			var_0B = var_08;
		}
	}

	if(var_02.size > 0)
	{
		if(isdefined(var_0A) && level.player.var_110C0)
		{
			if(level.player.var_110BD == "")
			{
				level.player.var_110BE = level.player method_80FB(var_0A);
				level.player.var_110BD = var_0A;
				level.player takeweapon(var_0A);
			}
			else if(var_02[0] == level.player.var_110BD)
			{
				level.player.var_110BE = level.player method_80FB(var_0A);
				level.player.var_110BD = var_0A;
				level.player takeweapon(var_0A);
			}

			level.player takeweapon(var_0A);
		}
		else if(isdefined(var_0A))
		{
			level.player takeweapon(var_0A);
		}

		level.player method_844D();
		level.player method_844B(var_02[0]);
		if(var_02.size > 1)
		{
			if(level.player.var_110C0)
			{
				level.player.var_110BE = level.player method_80FB(var_02[1]);
				level.player.var_110BD = var_02[1];
				level.player takeweapon(var_02[1]);
			}
			else
			{
				level.player takeweapon(var_02[1]);
			}
		}
	}

	if(var_03.size > 0)
	{
		if(isdefined(var_0B) && level.player.var_110C0)
		{
			if(level.player.var_110BA == "")
			{
				level.player.var_110BB = level.player method_80FB(var_0B);
				level.player.var_110BA = var_0B;
				level.player takeweapon(var_0B);
			}
			else if(var_03[0] == level.player.var_110BA)
			{
				level.player.var_110BB = level.player method_80FB(var_0B);
				level.player.var_110BA = var_0B;
				level.player takeweapon(var_0B);
			}

			level.player takeweapon(var_0B);
		}
		else if(isdefined(var_0B))
		{
			level.player takeweapon(var_0B);
		}

		level.player method_844E();
		level.player method_844C(var_03[0]);
		if(var_03.size > 1)
		{
			if(level.player.var_110C0)
			{
				level.player.var_110BB = level.player method_80FB(var_03[1]);
				level.player.var_110BA = var_03[1];
				level.player takeweapon(var_03[1]);
			}
			else
			{
				level.player takeweapon(var_03[1]);
			}
		}
	}

	if(!level.player.var_110C0 && level.player.var_110BD != "")
	{
		level.player.var_110BD = "";
		level.player.var_110BE = 0;
	}

	if(!level.player.var_110C0 && level.player.var_110BA != "")
	{
		level.player.var_110BA = "";
		level.player.var_110BB = 0;
	}
}

//Function Number: 16
func_1434(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	setomnvar("ui_power_num_charges",int(param_01));
	setomnvar("ui_power_id",int(func_12A4(param_00).var_92B8));
	setomnvar("ui_power_disabled",0);
	if(param_02 == 1)
	{
		setomnvar("ui_power_recharge",int(1000));
		setomnvar("ui_power_consume",0);
	}
}

//Function Number: 17
func_1436(param_00,param_01,param_02)
{
	setomnvar("ui_power_stored_show",1);
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	setomnvar("ui_power_stored_num_charges",int(param_01));
	setomnvar("ui_power_id_stored",int(func_12A4(param_00).var_92B8));
	setomnvar("ui_power_stored_disabled",0);
	setomnvar("ui_power_stored_recharge",int(1000));
	setomnvar("ui_power_stored_consume",0);
}

//Function Number: 18
func_1433(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	setomnvar("ui_power_secondary_num_charges",int(param_01));
	setomnvar("ui_power_id_secondary",int(func_12A4(param_00).var_92B8));
	setomnvar("ui_power_secondary_disabled",0);
	if(param_02 == 1)
	{
		setomnvar("ui_power_secondary_recharge",int(1000));
		setomnvar("ui_power_secondary_consume",0);
	}
}

//Function Number: 19
func_1435(param_00,param_01,param_02)
{
	setomnvar("ui_power_secondary_stored_show",1);
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	setomnvar("ui_power_secondary_stored_num_charges",int(param_01));
	setomnvar("ui_power_id_secondary_stored",int(func_12A4(param_00).var_92B8));
	setomnvar("ui_power_secondary_stored_disabled",0);
	setomnvar("ui_power_secondary_stored_recharge",int(1000));
	setomnvar("ui_power_secondary_stored_consume",0);
}

//Function Number: 20
func_11A6()
{
	setomnvar("ui_power_num_charges",0);
	setomnvar("ui_power_id",0);
	setomnvar("ui_power_disabled",0);
	setomnvar("ui_power_recharge",0);
	setomnvar("ui_power_consume",0);
}

//Function Number: 21
func_11A8()
{
	setomnvar("ui_power_stored_show",0);
	setomnvar("ui_power_stored_num_charges",0);
	setomnvar("ui_power_id_stored",0);
	setomnvar("ui_power_stored_disabled",0);
	setomnvar("ui_power_stored_recharge",0);
	setomnvar("ui_power_stored_consume",0);
}

//Function Number: 22
func_11A5()
{
	setomnvar("ui_power_secondary_num_charges",0);
	setomnvar("ui_power_id_secondary",0);
	setomnvar("ui_power_secondary_disabled",0);
	setomnvar("ui_power_secondary_recharge",0);
	setomnvar("ui_power_secondary_consume",0);
}

//Function Number: 23
func_11A7()
{
	setomnvar("ui_power_secondary_stored_show",0);
	setomnvar("ui_power_secondary_stored_num_charges",0);
	setomnvar("ui_power_id_secondary_stored",0);
	setomnvar("ui_power_secondary_stored_disabled",0);
	setomnvar("ui_power_secondary_stored_recharge",0);
	setomnvar("ui_power_secondary_stored_consume",0);
}

//Function Number: 24
func_13FF()
{
	self endon("death");
	thread func_1400();
	thread func_12E3();
	thread func_11A0();
	for(;;)
	{
		scripts\common\utility::waittill_any_3("weapon_fired","aim","melee","reload_start","stand","weapon_change","weapon_swap","hide_hud_omnvar_changed");
		func_1401();
	}
}

//Function Number: 25
func_1400()
{
	self endon("death");
	for(;;)
	{
		scripts\common\utility::waittill_any_3("equipment_change","current_primary_ammo","offhand_ammo","item_ammo","sprint_begin","offhandshield_retract");
		func_1401();
	}
}

//Function Number: 26
func_1401()
{
	var_00 = scripts\sp\_utility::func_7B8C();
	var_01 = self getcurrentprimaryweapon();
	if(var_00 != "safe" && var_01 != "iw7_gunless")
	{
		setomnvar("ui_hide_weapon_info",0);
	}

	self notify("cancel_hide_hud");
	setomnvar("ui_hud_hidden_by_timer",0);
	wait(1);
	thread func_12E3();
}

//Function Number: 27
func_12E3()
{
	self endon("death");
	self endon("cancel_hide_hud");
	wait(30);
	setomnvar("ui_hide_weapon_info",1);
	setomnvar("ui_hud_hidden_by_timer",1);
	thread func_12E0();
}

//Function Number: 28
func_12E0()
{
	self endon("death");
	var_00 = getomnvar("ui_hide_hud");
	var_01 = getomnvar("ui_hide_weapon_info");
	while(getomnvar("ui_hide_hud") == var_00 && getomnvar("ui_hide_weapon_info") == var_01)
	{
		scripts\common\utility::func_136F7();
	}

	self notify("hide_hud_omnvar_changed");
}

//Function Number: 29
func_11A0()
{
	self endon("death");
	for(;;)
	{
		if(self adsbuttonpressed())
		{
			self notify("aim");
		}

		if(self meleebuttonpressed())
		{
			self notify("melee");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 30
func_128A(param_00,param_01,param_02,param_03,param_04)
{
	return param_00 - param_01 / param_02 - param_01 * param_04 - param_03 + param_03;
}

//Function Number: 31
func_1295(param_00)
{
	var_01 = strtok(param_00,"_");
	var_02 = var_01[var_01.size - 1];
	if(issubstr(var_02,"up1") || issubstr(var_02,"up2"))
	{
		var_03 = "";
		for(var_04 = 0;var_04 < var_01.size - 1;var_04++)
		{
			var_03 = var_03 + var_01[var_04];
		}

		return var_03;
	}

	return var_02;
}