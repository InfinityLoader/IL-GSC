/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3428.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 121
 * Decompile Time: 92 ms
 * Timestamp: 10/27/2023 12:27:25 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\common\utility::flag_init("dischord_glasses_pickedup");
	scripts\common\utility::flag_init("green_crystal_placed");
	scripts\common\utility::flag_init("red_crystal_placed");
	scripts\common\utility::flag_init("blue_crystal_placed");
	scripts\common\utility::flag_init("yellow_crystal_placed");
	scripts\common\utility::flag_init("dj_wor_use_nag_init");
	scripts\common\utility::flag_wait("pre_game_over");
	level.var_13E09["iw7_headcutter_zm"] = &"CP_QUEST_WOR_TAKE_HC";
	level.var_13E09["iw7_shredder_zm"] = &"CP_QUEST_WOR_TAKE_SHREDDER";
	level.var_13E09["iw7_facemelter_zm"] = &"CP_QUEST_WOR_TAKE_FACEMELTER";
	level.var_13E09["iw7_dischord_zm"] = &"CP_QUEST_WOR_TAKE_DISCHORD";
	level thread func_97AB();
	level.var_8C5C = 0;
	level.var_1E90 = 0;
	level.var_10A04 = 0;
	level.var_E5D7 = 0;
	level.var_11A20 = 0;
	level.var_562D = 0;
	level.var_B7BF = [];
	level.var_DB5A = ::func_13DB8;
	level.var_DB5B = ::func_13DB9;
	level.var_DB5C = ::func_13DBA;
	level.var_DB59 = ::func_13DB7;
	level.var_4297 = ::func_E46C;
	level.var_4ADD = ::func_65F4;
	level.var_4ADE = "kill_near_crystal";
	level.var_10249 = 0;
	level thread func_13DB6();
	level thread func_5623();
	level thread func_573C();
	level thread func_95AF();
	level thread func_8C69();
	level thread func_7DD0();
}

//Function Number: 2
func_7DD0()
{
	var_00 = scripts\common\utility::getstructarray("interaction","targetname");
	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02.script_noteworthy))
		{
			continue;
		}

		if(var_02.script_noteworthy == "ark_quest_station")
		{
			level.var_215B = var_02;
			break;
		}
	}
}

//Function Number: 3
wor_init()
{
	thread func_AD60();
	thread func_97AB();
	thread func_AD57();
}

//Function Number: 4
func_97AB()
{
	if(isdefined(level.var_13DB1))
	{
		return;
	}

	level.var_13DB1 = [];
	level.var_13DB1["iw7_headcutter_zm"] = [];
	level.var_13DB1["iw7_headcutter_zm"]["toy"] = 0;
	level.var_13DB1["iw7_headcutter_zm"]["crystal"] = 0;
	level.var_13DB1["iw7_headcutter_zm"]["battery"] = 0;
	level.var_13DB1["iw7_headcutter_zm"]["weapon"] = 0;
	level.var_13DB1["iw7_facemelter_zm"] = [];
	level.var_13DB1["iw7_facemelter_zm"]["toy"] = 0;
	level.var_13DB1["iw7_facemelter_zm"]["crystal"] = 0;
	level.var_13DB1["iw7_facemelter_zm"]["battery"] = 0;
	level.var_13DB1["iw7_facemelter_zm"]["weapon"] = 0;
	level.var_13DB1["iw7_shredder_zm"] = [];
	level.var_13DB1["iw7_shredder_zm"]["toy"] = 0;
	level.var_13DB1["iw7_shredder_zm"]["crystal"] = 0;
	level.var_13DB1["iw7_shredder_zm"]["battery"] = 0;
	level.var_13DB1["iw7_shredder_zm"]["weapon"] = 0;
	level.var_13DB1["iw7_dischord_zm"] = [];
	level.var_13DB1["iw7_dischord_zm"]["toy"] = 0;
	level.var_13DB1["iw7_dischord_zm"]["crystal"] = 0;
	level.var_13DB1["iw7_dischord_zm"]["battery"] = 0;
	level.var_13DB1["iw7_dischord_zm"]["weapon"] = 0;
	level.var_13DB2 = [];
	level.var_13DB2["iw7_headcutter_zm"] = [];
	level.var_13DB2["iw7_headcutter_zm"]["toy"] = 0;
	level.var_13DB2["iw7_headcutter_zm"]["crystal"] = 0;
	level.var_13DB2["iw7_headcutter_zm"]["battery"] = 0;
	level.var_13DB2["iw7_headcutter_zm"]["weapon"] = 0;
	level.var_13DB2["iw7_facemelter_zm"] = [];
	level.var_13DB2["iw7_facemelter_zm"]["toy"] = 0;
	level.var_13DB2["iw7_facemelter_zm"]["crystal"] = 0;
	level.var_13DB2["iw7_facemelter_zm"]["battery"] = 0;
	level.var_13DB2["iw7_facemelter_zm"]["weapon"] = 0;
	level.var_13DB2["iw7_shredder_zm"] = [];
	level.var_13DB2["iw7_shredder_zm"]["toy"] = 0;
	level.var_13DB2["iw7_shredder_zm"]["crystal"] = 0;
	level.var_13DB2["iw7_shredder_zm"]["battery"] = 0;
	level.var_13DB2["iw7_shredder_zm"]["weapon"] = 0;
	level.var_13DB2["iw7_dischord_zm"] = [];
	level.var_13DB2["iw7_dischord_zm"]["toy"] = 0;
	level.var_13DB2["iw7_dischord_zm"]["crystal"] = 0;
	level.var_13DB2["iw7_dischord_zm"]["battery"] = 0;
	level.var_13DB2["iw7_dischord_zm"]["weapon"] = 0;
}

//Function Number: 5
func_9765(param_00,param_01)
{
	self.var_86E6 = spawnstruct();
	self.var_86E6.var_10B6C = self.var_10B6C;
	self.var_86E6.var_6CD8 = 0;
	self.var_86E6.var_86C1 = param_01;
	self.var_86E6 func_FA51(param_01);
	var_02 = [1,2,3];
	foreach(var_04 in var_02)
	{
		level thread [[ param_00 ]](self.var_86E6,var_04);
	}
}

//Function Number: 6
func_DB24(param_00,param_01,param_02,param_03)
{
	level notify("gun_replaced " + param_01);
	if(isdefined(param_02))
	{
		var_04 = isdefined(param_03) && isdefined(param_03.var_6670) && issubstr(param_03.var_6670,param_01);
		if(issubstr(param_02,"pap1") && !var_04)
		{
			param_00.var_10B6C.var_12F76 = 1;
		}
		else
		{
			param_00.var_10B6C.var_12F76 = 0;
		}
	}
	else
	{
		param_00.var_10B6C.var_12F76 = 0;
	}

	param_00.var_10B6C.var_86DC = 1;
	param_00.var_10B6C setscriptablepartstate("zapper","craft_zapper",1);
}

//Function Number: 7
func_10B6E(param_00,param_01)
{
	var_02 = param_00.var_10B6C;
	if(level.var_13DB2[var_02.script_noteworthy]["toy"] && level.var_13DB2[var_02.script_noteworthy]["battery"] && level.var_13DB2[var_02.script_noteworthy]["crystal"])
	{
		if(var_02.var_86DC)
		{
			return level.var_13E09[var_02.script_noteworthy];
		}
		else
		{
			var_03 = param_01 getcurrentweapon();
			var_04 = getweaponbasename(var_03);
			if(issubstr(var_04,param_00.var_86E6.var_86C1))
			{
				return param_00.var_86E6.var_CBFE;
			}
			else
			{
				return "";
			}
		}
	}

	if(level.var_13DB1[var_02.script_noteworthy]["toy"] && !level.var_13DB2[var_02.script_noteworthy]["toy"])
	{
		return &"CP_QUEST_WOR_PLACE_PART";
	}
	else if(level.var_13DB1[var_02.script_noteworthy]["battery"] && !level.var_13DB2[var_02.script_noteworthy]["battery"])
	{
		return &"CP_QUEST_WOR_PLACE_PART";
	}
	else if(level.var_13DB1[var_02.script_noteworthy]["crystal"] && !level.var_13DB2[var_02.script_noteworthy]["crystal"])
	{
		return &"CP_QUEST_WOR_PLACE_PART";
	}

	return &"CP_QUEST_WOR_ASSEMBLY";
}

//Function Number: 8
func_10B6D(param_00,param_01)
{
	var_02 = param_00.var_10B6C;
	if(level.var_13DB2[var_02.script_noteworthy]["toy"] && level.var_13DB2[var_02.script_noteworthy]["battery"] && level.var_13DB2[var_02.script_noteworthy]["crystal"])
	{
		if(var_02.var_86DC)
		{
			var_02.var_86DC = 0;
			var_02 setscriptablepartstate("zapper","hide_zapper",1);
			param_01 notify("weapon_purchased");
			func_13DAD(param_01,var_02.script_noteworthy,param_00.var_86E6);
			param_01 thread func_13A82(param_01,var_02.script_noteworthy,param_00.var_86E6);
			param_01 thread func_13A59(param_01,var_02.script_noteworthy,param_00.var_86E6);
			param_01 thread func_11B03(param_01,var_02.script_noteworthy,param_00.var_86E6);
		}
		else
		{
			var_03 = param_01 getcurrentweapon();
			var_04 = getweaponbasename(var_03);
			if(issubstr(var_04,param_00.var_86E6.var_86C1))
			{
				var_05 = param_01 scripts\cp\_utility::getvalidtakeweapon();
				param_01 takeweapon(var_05);
				var_06 = param_01 getweaponslistprimaries();
				var_07 = 0;
				for(var_08 = 0;var_08 < var_06.size;var_08++)
				{
					if(var_06[var_08] == "none")
					{
						continue;
					}
					else if(scripts\common\utility::func_2286(level.additional_laststand_weapon_exclusion,var_06[var_08]))
					{
						continue;
					}
					else if(scripts\common\utility::func_2286(level.additional_laststand_weapon_exclusion,getweaponbasename(var_06[var_08])))
					{
						continue;
					}
					else if(scripts\cp\_utility::func_9C42(var_06[var_08],1))
					{
						continue;
					}

					var_07 = 1;
					param_01 switchtoweapon(var_06[var_08]);
					break;
				}

				if(!var_07)
				{
					var_09 = "iw7_fists_zm";
					param_01 scripts\cp\_utility::func_12C6(var_09,undefined,undefined,1);
					param_01 method_83B6(var_09);
				}

				thread func_DB24(param_00.var_86E6,param_00.var_86E6.var_86C1,var_03,param_01);
				param_01 scripts\cp\_utility::func_12EBE();
			}
		}
	}

	if(level.var_13DB1[var_02.script_noteworthy]["toy"] && !level.var_13DB2[var_02.script_noteworthy]["toy"])
	{
		level.var_13DB2[var_02.script_noteworthy]["toy"] = 1;
		var_02 func_CBFF("toy");
		if(level.var_13DB2[var_02.script_noteworthy]["toy"] && level.var_13DB2[var_02.script_noteworthy]["battery"] && level.var_13DB2[var_02.script_noteworthy]["crystal"])
		{
			var_02 setscriptablepartstate("zapper","craft_zapper",1);
			return;
		}

		return;
	}

	if(level.var_13DB1[var_02.script_noteworthy]["battery"] && !level.var_13DB2[var_02.script_noteworthy]["battery"])
	{
		level.var_13DB2[var_02.script_noteworthy]["battery"] = 1;
		var_02 func_CBFF("battery");
		if(level.var_13DB2[var_02.script_noteworthy]["toy"] && level.var_13DB2[var_02.script_noteworthy]["battery"] && level.var_13DB2[var_02.script_noteworthy]["crystal"])
		{
			var_02 setscriptablepartstate("zapper","craft_zapper",1);
			return;
		}

		return;
	}

	if(level.var_13DB1[var_02.script_noteworthy]["crystal"] && !level.var_13DB2[var_02.script_noteworthy]["crystal"])
	{
		level.var_13DB2[var_02.script_noteworthy]["crystal"] = 1;
		var_02 func_CBFF("crystal");
		if(level.var_13DB2[var_02.script_noteworthy]["toy"] && level.var_13DB2[var_02.script_noteworthy]["battery"] && level.var_13DB2[var_02.script_noteworthy]["crystal"])
		{
			var_02 setscriptablepartstate("zapper","craft_zapper",1);
			return;
		}

		return;
	}
}

//Function Number: 9
func_CBFF(param_00)
{
	self setscriptablepartstate(param_00,"part_placed");
	wait(1);
	self setscriptablepartstate(param_00,"part_placed_no_fx");
}

//Function Number: 10
func_E46C(param_00)
{
	return scripts\common\utility::getclosest(param_00.origin,level.var_B7BF);
}

//Function Number: 11
func_65F4(param_00,param_01)
{
	if(level.var_B7BF.size < 1)
	{
		return 0;
	}

	if(!scripts\cp\_utility::func_13C90(param_01,"arcane_base"))
	{
		return 0;
	}

	var_02 = 0;
	foreach(var_04 in level.var_B7BF)
	{
		var_05 = 562500;
		if(!isdefined(var_04) || scripts\common\utility::istrue(var_04.var_74BE))
		{
			continue;
		}

		if(distancesquared(var_04.origin,param_00.origin) < var_05)
		{
			var_02 = 1;
		}

		if(var_02)
		{
			break;
		}
	}

	if(var_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
func_6AE3(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_7B6A(param_01,param_03);
	param_00 setmodel(var_05);
	wait(0.25);
	var_06 = param_01.var_CC1E;
	param_00 makeusable();
	param_00 method_84A2(64);
	param_00 method_84A5(120);
	var_07 = playfxontag(var_06,param_00,"tag_origin");
	param_00 sethintstring(&"CP_QUEST_WOR_PART");
	param_00 waittill("trigger",var_08);
	stopfxontag(var_06,param_00,"tag_origin");
	level.var_13DB1[param_01.var_86C1][param_04] = 1;
}

//Function Number: 13
func_12E41(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 endon("fully_charged");
	for(;;)
	{
		param_00 waittill("next_position_found",var_06,var_07);
		var_08 = vectortoangles(var_07.origin - var_06.origin) + (180,0,0);
		param_00 rotateto(var_08,0.5,0.05,0.05);
	}
}

//Function Number: 14
func_10C09(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = scripts\common\utility::getclosest(param_06.origin,scripts\common\utility::getstructarray("essence_ufo_path","script_noteworthy"));
	var_08 = 0;
	var_09 = var_07;
	var_0A = 1;
	var_0B = undefined;
	for(var_0C = func_7B1B(param_06,var_09);var_0A;var_0C = var_0F)
	{
		if(isdefined(var_09.var_EEBE))
		{
			var_0D = var_09.var_EEBE;
		}
		else
		{
			var_0D = undefined;
		}

		var_0E = func_7AF8(param_06,var_09.origin,var_0C.origin,var_0D);
		var_0F = var_0C;
		var_0F = func_7B1B(param_06,var_0F);
		thread func_3C51(param_06,var_0E,var_0F,var_09,var_0C);
		param_06 moveto(var_0C.origin,var_0E);
		var_10 = param_06 scripts\common\utility::func_13734("movedone","fully_charged");
		if(scripts\common\utility::istrue(param_06.var_74BE))
		{
			for(;;)
			{
				var_0E = func_7AF8(param_06,param_06.origin,var_0C.origin,2000);
				param_06 moveto(var_0C.origin,var_0E);
				if(func_386B(param_00,var_0C))
				{
					var_11 = scripts\common\utility::func_5D14(var_0C.origin,0,-400) + (0,0,40);
					var_12 = magicbullet("bolasprayprojhome_mp",param_06.origin,var_11);
					scripts\common\utility::play_sound_in_space("miniufo_fire",param_06.origin,0,param_06);
					param_00 dontinterpolate();
					param_00.origin = var_11;
					param_06.var_74BE = undefined;
					param_06 thread func_BD1F(param_06,param_06.origin,param_01);
					var_12 scripts\common\utility::waittill_any_timeout_1(1.25,"death");
					if(isdefined(var_12))
					{
						var_12 delete();
					}

					param_00.var_240A = 1;
					var_0A = 0;
					break;
				}
				else
				{
					param_06 waittill("movedone");
					var_09 = var_0C;
					var_0C = func_7B1B(param_06,var_09);
					param_06 notify("next_position_found",var_09,var_0C);
				}
			}

			continue;
		}

		var_09 = var_0C;
	}
}

//Function Number: 15
func_3C51(param_00,param_01,param_02,param_03,param_04)
{
	wait(max(0.05,param_01 - 0.35));
	param_00 notify("next_position_found",param_04,param_02);
}

//Function Number: 16
func_BD1F(param_00,param_01,param_02)
{
	param_00 waittill("movedone");
	param_00 setscriptablepartstate("miniufo","mini_ufo");
	var_03 = scripts\common\utility::random(param_02.var_10DAF);
	param_00 setmodel("tag_origin");
	param_00.origin = var_03.origin;
	param_00.angles = var_03.angles;
}

//Function Number: 17
func_386B(param_00,param_01)
{
	if(isdefined(param_01.name))
	{
		if(isdefined(param_01.name == "cant_stop_wont_stop"))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 18
func_7B1B(param_00,param_01)
{
	var_02 = scripts\common\utility::getstructarray(param_01.target,"targetname");
	var_03 = [];
	var_04 = undefined;
	var_04 = scripts\common\utility::random(var_02);
	return var_04;
}

//Function Number: 19
func_7AF8(param_00,param_01,param_02,param_03)
{
	var_04 = distance(param_01,param_02);
	if(!isdefined(param_03))
	{
		param_03 = int(clamp(level.wave_num * 15,75,150));
	}

	var_05 = var_04 / param_03;
	if(var_05 < 0.05)
	{
		var_05 = 0.05;
	}

	return var_05;
}

//Function Number: 20
func_BC1E(param_00)
{
	var_01 = scripts\common\utility::func_5D14(param_00.origin,0,-400) + (0,0,40);
	var_02 = distance(param_00.origin,var_01);
	var_03 = 2000;
	var_04 = var_02 / var_03;
	if(var_04 < 0.05)
	{
		var_04 = 0.05;
	}

	wait(2);
	param_00 moveto(var_01,var_04);
	param_00.var_240A = 1;
}

//Function Number: 21
func_7FB6(param_00)
{
	if(param_00.var_4AE0 == "zmb_weapon_crystal_green" && isdefined(level.var_54AD))
	{
		return level.var_54AD;
	}

	if(param_00.var_4AE0 == "zmb_weapon_crystal_blue" && isdefined(level.var_7047))
	{
		return level.var_7047;
	}

	if(param_00.var_4AE0 == "zmb_weapon_crystal_yellow" && isdefined(level.var_8C55))
	{
		return level.var_8C55;
	}

	return scripts\common\utility::random(param_00.var_10DAF);
}

//Function Number: 22
func_7FB8(param_00,param_01)
{
	switch(param_00)
	{
		case "blue":
			if(!isdefined(level.var_E5CE))
			{
				var_02 = spawn("script_model",param_01.origin);
				var_02 setmodel("tag_origin_mini_ufo");
				scripts\common\utility::func_136F7();
			}
			else
			{
				var_02 = level.var_E5CE;
				if(var_02.model != "tag_origin_mini_ufo")
				{
					var_02 setmodel("tag_origin_mini_ufo");
					var_02 dontinterpolate();
					var_02.origin = param_01.origin;
					scripts\common\utility::func_136F7();
				}
			}
			break;

		case "green":
			if(!isdefined(level.var_562C))
			{
				var_02 = spawn("script_model",var_02.origin);
				var_02 setmodel("tag_origin_mini_ufo");
				scripts\common\utility::func_136F7();
			}
			else
			{
				var_02 = level.var_562C;
				if(var_02.model != "tag_origin_mini_ufo")
				{
					var_02 setmodel("tag_origin_mini_ufo");
					var_02 dontinterpolate();
					var_02.origin = param_01.origin;
					scripts\common\utility::func_136F7();
				}
			}
			break;

		case "yellow":
			if(!isdefined(level.var_10F72))
			{
				var_02 = spawn("script_model",var_02.origin);
				var_02 setmodel("tag_origin_mini_ufo");
				scripts\common\utility::func_136F7();
			}
			else
			{
				var_02 = level.var_10F72;
				if(var_02.model != "tag_origin_mini_ufo")
				{
					var_02 setmodel("tag_origin_mini_ufo");
					var_02 dontinterpolate();
					var_02.origin = param_01.origin;
					scripts\common\utility::func_136F7();
				}
			}
			break;

		case "red":
			if(!isdefined(level.var_3F2A))
			{
				var_02 = spawn("script_model",var_02.origin);
				var_02 setmodel("tag_origin_mini_ufo");
				scripts\common\utility::func_136F7();
			}
			else
			{
				var_02 = level.var_3F2A;
				if(var_02.model != "tag_origin_mini_ufo")
				{
					var_02 setmodel("tag_origin_mini_ufo");
					var_02 dontinterpolate();
					var_02.origin = param_01.origin;
					scripts\common\utility::func_136F7();
				}
			}
			break;

		default:
			var_02 = spawn("script_model",var_02.origin);
			var_02 setmodel("tag_origin_mini_ufo");
			var_02 dontinterpolate();
			var_02.origin = param_01.origin;
			scripts\common\utility::func_136F7();
			break;
	}

	return var_02;
}

//Function Number: 23
func_4374(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = func_7FB6(param_01);
	var_07 = param_01.var_A858;
	var_08 = func_7FB8(var_07,var_06);
	var_08 setscriptablepartstate("miniufo",var_07);
	scripts\common\utility::flag_set("mini_ufo_" + param_01.color + "_collecting");
	var_08 thread func_10C09(param_00,param_01,param_02,param_03,param_04,param_05,var_08);
	var_08 thread func_12E41(var_08,param_01,param_02,param_03,param_04,param_05);
	level.var_B7BF[level.var_B7BF.size] = var_08;
	func_135BD(param_00,param_01,var_08,var_07);
	param_00 makeusable();
	param_00 method_84A2(64);
	param_00 method_84A5(120);
	param_00.var_86E6 = param_01;
	if(scripts\common\utility::istrue(param_05))
	{
		param_00 thread func_11902(param_00,param_01,param_03,var_08);
	}

	param_00 endon("death");
	func_48DB(param_00);
	for(;;)
	{
		param_00 waittill("mini_ufo_completed",var_09);
		param_00 setscriptablepartstate("miniufo","neutral");
		param_00 notify("picked_up");
		switch(param_01.color)
		{
			case "blue":
				var_09 thread scripts\cp\_vo::try_to_play_vo("quest_arcane_blue_essence","zmb_comment_vo","highest",10,1,0,0,100);
				break;
	
			case "red":
				var_09 thread scripts\cp\_vo::try_to_play_vo("quest_arcane_red_essence","zmb_comment_vo","highest",10,1,0,0,100);
				break;
	
			case "green":
				var_09 thread scripts\cp\_vo::try_to_play_vo("quest_arcane_green_essence","zmb_comment_vo","highest",10,1,0,0,100);
				break;
	
			case "yellow":
				var_09 thread scripts\cp\_vo::try_to_play_vo("quest_arcane_yellow_essence","zmb_comment_vo","highest",10,1,0,0,100);
				break;
	
			default:
				var_09 thread scripts\cp\_vo::try_to_play_vo("arcane_core_success","zmb_comment_vo","highest",10,0,0,0,50);
				break;
		}

		level thread waittillnextwave(var_08,param_01);
		func_E239(param_00,param_01,param_03);
		param_00 makeunusable();
		if(scripts\common\utility::istrue(param_05))
		{
			param_00 delete();
		}
		else
		{
			param_00 setmodel("tag_origin");
		}

		break;
	}
}

//Function Number: 24
waittillnextwave(param_00,param_01)
{
	level waittill("regular_wave_starting");
	if(param_00.model != "tag_origin_mini_ufo")
	{
		param_00 setmodel("tag_origin_mini_ufo");
	}

	scripts\common\utility::func_6E2A("mini_ufo_" + param_01.color + "_collecting");
}

//Function Number: 25
func_6742(param_00,param_01)
{
	if(!isdefined(param_00.var_240A))
	{
		return;
	}

	if(!scripts\cp\_utility::func_13C90(param_01 getcurrentweapon(),"arcane_base"))
	{
		return;
	}

	param_00 notify("mini_ufo_completed",param_01);
	param_01 playlocalsound("part_pickup");
	func_E008(param_00);
	param_01 thread func_3CC6(param_01,param_00.var_86E6);
}

//Function Number: 26
func_48DB(param_00)
{
	param_00.script_noteworthy = "spawned_essence";
	param_00.var_E1B9 = 0;
	param_00.var_D776 = 1;
	param_00.var_EE79 = "default";
	param_00.var_4C72 = 96;
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
}

//Function Number: 27
func_E008(param_00)
{
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	param_00.script_noteworthy = undefined;
	param_00.var_E1B9 = undefined;
	param_00.var_D776 = undefined;
	param_00.var_EE79 = undefined;
	param_00.var_4C72 = undefined;
}

//Function Number: 28
func_D56E(param_00,param_01)
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_02);
		thread func_CF35(param_00,param_01,var_02);
	}
}

//Function Number: 29
func_CF35(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_02 endon("disconnect");
	param_02 waittill("spawned_player");
	playfxontag(param_00,param_01,"tag_origin");
}

//Function Number: 30
func_5607(param_00,param_01)
{
	param_00 disableplayeruse(param_01);
	wait(1);
	param_00 enableplayeruse(param_01);
}

//Function Number: 31
func_E804(param_00,param_01,param_02,param_03,param_04)
{
	param_00 endon("timed_out");
	var_05 = scripts\common\utility::func_782F(param_00.origin,level.players,undefined,4,512);
	foreach(var_07 in var_05)
	{
		var_07 thread scripts\cp\_vo::try_to_play_vo("arcane_core_event","zmb_comment_vo","highest",10,0,0,1);
	}

	param_00 func_4374(param_00,param_01,param_02,param_03,param_04);
	var_09 = param_01.var_4AE1;
	func_1115F(var_09,param_01.var_4AE0,param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 32
func_11902(param_00,param_01,param_02,param_03)
{
	param_00 endon("picked_up");
	wait(30);
	level thread waittillnextwave(param_03,param_01);
	playsoundatpos(param_00.origin,"zmb_coin_disappear");
	playfx(level._effect["souvenir_pickup"],param_00.origin);
	func_E008(param_00);
	func_E239(param_00,param_01,param_02);
	param_00 setscriptablepartstate("miniufo","neutral");
	param_00 makeunusable();
	param_00 setmodel("tag_origin");
	param_00 delete();
}

//Function Number: 33
func_E239(param_00,param_01,param_02)
{
	var_03 = param_01.var_4AE0;
	switch(var_03)
	{
		case "zmb_weapon_crystal_red":
			level.var_1E90 = 0;
			scripts\common\utility::func_6E2A("mini_ufo_red_ready");
			break;

		case "zmb_weapon_crystal_blue":
			level.var_E5D7 = 0;
			scripts\common\utility::func_6E2A("mini_ufo_blue_ready");
			break;

		case "zmb_weapon_crystal_green":
			level.var_562D = 0;
			scripts\common\utility::func_6E2A("mini_ufo_green_ready");
			break;

		case "zmb_weapon_crystal_yellow":
			level.var_8C5C = 0;
			scripts\common\utility::func_6E2A("mini_ufo_yellow_ready");
			break;

		default:
			break;
	}

	thread func_4ADF(param_01,param_02);
}

//Function Number: 34
func_4ADF(param_00,param_01)
{
	var_02 = func_7B6B(param_01);
	var_03 = undefined;
	level waittill("ww_" + param_00.var_86C1 + "_" + var_02 + "_dropped",var_04);
	var_05 = spawn("script_model",var_04 + (0,0,30));
	var_06 = func_7B6A(param_00,param_01);
	if(scripts\common\utility::istrue(level.var_10249))
	{
		level.var_10249 = 0;
		func_6AE3(var_05,param_00,var_04,param_01,var_02);
		return;
	}

	var_05 func_4374(var_05,param_00,var_04,param_01,var_02,1);
}

//Function Number: 35
func_1115F(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	scripts\common\utility::flag_wait("gator_tooth_broken");
	var_07 = strtok(param_01,"_");
	var_08 = var_07[3];
	var_09 = level.var_215B;
	var_0A = scripts\common\utility::getstruct("slot_" + param_00,"script_noteworthy");
	param_02.origin = var_0A.origin;
	param_02.angles = anglestoup(var_0A.angles);
	param_02 setmodel(param_01);
	var_0B = getent("crystal_damage_trigger_" + param_00,"targetname");
	var_0B.origin = var_0B.origin + (0,0.25,0);
	var_0B setcandamage(1);
	var_0B.team = "axis";
	var_0B.var_B43C = 100;
	var_0B.health = 100;
	for(;;)
	{
		wait(0.05);
		scripts\common\utility::flag_wait("gator_gold_tooth_placed");
		var_0B waittill("damage",var_0C,var_0D,var_0E,var_0F,var_10,var_11,var_12,var_13,var_14,var_15,var_16,var_17,var_18);
		if(!isdefined(var_0D))
		{
			continue;
		}

		if(!isdefined(var_15))
		{
			var_15 = var_0D getcurrentweapon();
		}

		if(!scripts\cp\_utility::func_13C90(var_15,"ark" + var_08))
		{
			continue;
		}

		playsoundatpos(param_02.origin,"arc_machine_door_shoot_off");
		var_0B setcandamage(0);
		var_0B hide();
		if(!isdefined(var_09.var_4AE2))
		{
			var_09.var_4AE2 = [];
		}

		var_09.var_4AE2[var_09.var_4AE2.size] = param_02;
		scripts\common\utility::flag_wait(var_08 + "_crystal_placed");
		break;
	}

	level.var_13DB1[param_03.var_86C1][param_06] = 1;
	if(isplayer(var_0D))
	{
		switch(param_03.var_86C1)
		{
			case "iw7_headcutter_zm":
				var_0D thread scripts\cp\_vo::try_to_play_vo("quest_cutter_crystal_yellow","zmb_comment_vo","highest",10,1,0,0,100);
				break;

			case "iw7_facemelter_zm":
				var_0D thread scripts\cp\_vo::try_to_play_vo("quest_melter_crystal_blue","zmb_comment_vo","highest",10,1,0,0,100);
				break;

			case "iw7_shredder_zm":
				var_0D thread scripts\cp\_vo::try_to_play_vo("quest_shredder_crystal_red","zmb_comment_vo","highest",10,1,0,0,100);
				break;

			case "iw7_dischord_zm":
				var_0D thread scripts\cp\_vo::try_to_play_vo("quest_dischord_crystal_green","zmb_comment_vo","highest",10,1,0,0,100);
				break;

			default:
				var_0D thread scripts\cp\_vo::try_to_play_vo("part_collect_wor","zmb_comment_vo");
				break;
		}
	}
}

//Function Number: 36
func_E7DD(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_7B6A(param_01,param_03);
	param_00 setmodel(var_05);
	if(param_01.var_86C1 == "iw7_dischord_zm")
	{
		var_06 = "dischord";
		if(scripts\common\utility::istrue(level.var_10248))
		{
			level.var_10248 = 0;
			wait(0.25);
		}
		else
		{
			param_00 func_5620();
		}
	}
	else if(param_02.var_86C1 == "iw7_facemelter_zm")
	{
		var_06 = "melter";
		level.var_6A73 = param_00;
		wait(0.25);
	}
	else if(param_02.var_86C1 == "iw7_shredder_zm")
	{
		var_06 = "shredder";
		level.shredder_battery = param_00;
		wait(0.25);
	}
	else
	{
		var_06 = "cutter";
		wait(0.25);
	}

	param_00 setscriptablepartstate("model",param_01.var_11A76);
	param_00 thread func_E725();
	param_00 makeusable();
	param_00 method_84A2(64);
	param_00 method_84A5(120);
	param_00 sethintstring(&"CP_QUEST_WOR_PART");
	param_00 waittill("trigger",var_07);
	var_07 thread scripts\cp\_vo::try_to_play_vo("quest_" + var_06 + "_battery","zmb_comment_vo","highest",10,1,0,0,100);
	param_00 setscriptablepartstate("pickup_piece","pickup_piece");
	level.var_13DB1[param_01.var_86C1][param_04] = 1;
	wait(0.25);
	param_00 setscriptablepartstate("model","neutral");
}

//Function Number: 37
func_E725()
{
	self endon("death");
	for(;;)
	{
		self rotateyaw(360,2);
		self movez(-5,2);
		self waittill("movedone");
		self rotateyaw(360,2);
		self movez(5,2);
		self waittill("movedone");
	}
}

//Function Number: 38
func_E82A(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = (0,0,0);
	var_06 = (0,0,0);
	switch(param_01.var_86C1)
	{
		case "iw7_shredder_zm":
			var_07 = getent("toy_angry_mike","targetname");
			var_05 = var_07.origin;
			var_06 = var_07.angles;
			var_07 hide();
			break;

		case "iw7_facemelter_zm":
			var_07 = getent("toy_shuttle","targetname");
			var_05 = var_07.origin;
			var_06 = var_07.angles;
			var_07 hide();
			break;

		case "iw7_dischord_zm":
			var_07 = getent("toy_disco_ball","targetname");
			var_05 = var_07.origin;
			var_06 = var_07.angles;
			var_07 hide();
			break;

		case "iw7_headcutter_zm":
			var_07 = getent("toy_yeti","targetname");
			var_05 = var_07.origin;
			var_06 = var_07.angles;
			var_07 hide();
			break;
	}

	param_00 setmodel(param_01.var_11A75);
	param_00.origin = var_05;
	param_00.angles = var_06;
	wait(0.1);
	param_00 setscriptablepartstate("model",param_01.var_11A76);
	var_08 = scripts\common\utility::getstructarray("interaction","targetname");
	var_09 = scripts\common\utility::getclosest(param_00.origin,var_08);
	if(!isdefined(var_09.angles))
	{
		var_09.angles = (0,0,0);
	}

	param_00 func_722E(var_09,var_05,var_06);
	param_00 makeusable();
	param_00 method_84A2(64);
	param_00 method_84A5(120);
	param_00 sethintstring(&"CP_QUEST_WOR_PART");
	param_00 thread func_109FF();
	param_00 waittill("trigger",var_0A);
	switch(param_00.model)
	{
		case "zmb_ice_monster_toy":
			var_0A thread scripts\cp\_vo::try_to_play_vo("quest_cutter_icemonster","zmb_comment_vo","highest",10,1,0,0,100);
			break;

		case "decor_spaceshuttle_boosters_toy":
			var_0A thread scripts\cp\_vo::try_to_play_vo("quest_melter_rocket","zmb_comment_vo","highest",10,1,0,0,100);
			break;

		case "zmb_spaceland_discoball_toy":
			var_0A thread scripts\cp\_vo::try_to_play_vo("quest_dischord_discoball","zmb_comment_vo","highest",10,1,0,0,100);
			break;

		case "statue_angry_mike_toy":
			var_0A thread scripts\cp\_vo::try_to_play_vo("quest_shredder_monster","zmb_comment_vo","highest",10,1,0,0,100);
			break;

		default:
			var_0A thread scripts\cp\_vo::try_to_play_vo("part_collect_wor","zmb_comment_vo");
			break;
	}

	param_00 setscriptablepartstate("pickup_piece","pickup_piece");
	level.var_13DB1[param_01.var_86C1][param_04] = 1;
	wait(0.25);
	param_00 setscriptablepartstate("model","neutral");
	param_00 setmodel("tag_origin");
}

//Function Number: 39
func_C920(param_00,param_01)
{
	var_02 = func_7B6B(param_01);
	var_03 = undefined;
	level waittill("ww_" + param_00.var_86C1 + "_" + var_02 + "_dropped",var_04);
	var_05 = param_00.var_86C1;
	var_06 = (0,0,30);
	if(param_00.var_86C1 == "iw7_headcutter_zm" && var_02 == "battery")
	{
		var_06 = (0,0,0);
	}

	var_07 = spawn("script_model",var_04 + var_06);
	var_08 = func_7B6A(param_00,param_01);
	switch(var_02)
	{
		case "crystal":
			if(level.var_10249)
			{
				level.var_10249 = 0;
				func_6AE3(var_07,param_00,var_04,param_01,var_02);
			}
			else
			{
				func_E804(var_07,param_00,var_04,param_01,var_02);
			}
			break;

		case "toy":
			func_E82A(var_07,param_00,var_04,param_01,var_02);
			break;

		case "battery":
			func_E7DD(var_07,param_00,var_04,param_01,var_02);
			break;
	}

	var_07 delete();
	level thread scripts\cp\_vo::func_1769("dj_wor_use_nag","zmb_dj_vo",60,30,2,1);
	var_09 = func_7B4A(param_00.var_86C1,param_01);
	level notify("ww_" + param_00.var_86C1 + "_" + var_02 + "_picked_up");
	level scripts\cp\_utility::set_quest_icon(var_09);
}

//Function Number: 40
func_135BD(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	param_02.var_E866 = 0;
	param_02.expected_souls = 0;
	var_05 = 25;
	while(var_04 < var_05)
	{
		level waittill("kill_near_crystal",var_06,var_07,var_08);
		param_02.expected_souls--;
		if(param_02 != var_08)
		{
			continue;
		}

		if(!scripts\cp\_utility::func_13C90(var_07,"arcane_base"))
		{
			continue;
		}

		thread func_4AE3(var_06,param_02);
		param_02.var_E866++;
		var_04++;
	}

	while(param_02.var_E866 >= 1)
	{
		wait(0.05);
	}

	param_02.var_74BE = 1;
	param_02 notify("fully_charged");
	while(!isdefined(param_00.var_240A))
	{
		wait(0.1);
	}

	param_00 setmodel("tag_origin_ground_essence",param_03);
	scripts\cp\_vo::try_to_play_vo_on_all_players("quest_arcane_ufo_start");
	scripts\common\utility::func_136F7();
	param_00 setscriptablepartstate("miniufo",param_03);
	if(isdefined(param_02) && scripts\common\utility::func_2286(level.var_B7BF,param_02))
	{
		level.var_B7BF = scripts\common\utility::func_22A9(level.var_B7BF,param_02);
	}
}

//Function Number: 41
func_4AE3(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_02 setmodel("tag_origin_soultrail");
	var_03 = param_01.origin;
	var_04 = param_00 + (0,0,40);
	for(;;)
	{
		var_05 = distance(var_04,var_03);
		var_06 = 1500;
		var_07 = var_05 / var_06;
		if(var_07 < 0.05)
		{
			var_07 = 0.05;
		}

		var_02 moveto(var_03,var_07);
		var_02 waittill("movedone");
		if(distance(var_02.origin,param_01.origin) > 16)
		{
			var_03 = param_01.origin;
			var_04 = var_02.origin;
			continue;
		}

		break;
	}

	param_01 setscriptablepartstate("sparks","sparks");
	wait(0.25);
	param_01 setscriptablepartstate("sparks","neutral");
	param_01.var_E866--;
	var_02 delete();
}

//Function Number: 42
func_3CC6(param_00,param_01)
{
	var_02 = strtok(param_01.var_4AE0,"_");
	var_03 = var_02[3];
	var_04 = "ark" + var_03;
	param_00 setscriptablepartstate("arcane","arcane_absorb",0);
	wait(0.25);
	param_00 scripts\common\utility::func_1C76(0);
	var_05 = param_00 getcurrentweapon();
	param_00 scripts\cp\_weapon::func_169D(var_04,var_05,1);
	while(param_00 method_81C2())
	{
		wait(0.05);
	}

	param_00 scripts\common\utility::func_1C76(1);
	level thread func_CC91(param_00);
	param_00 scripts\cp\_persistence::give_player_xp(500,1);
}

//Function Number: 43
func_CC91(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("last_stand");
	wait(10);
	param_00 thread scripts\cp\_vo::try_to_play_vo("quest_arcane_ufo_success","zmb_comment_vo","highest",10,0,0,1);
	wait(7);
	level thread scripts\cp\_vo::try_to_play_vo("ww_arcane_corecharged_complete","zmb_ww_vo","highest",60,0,0,1);
}

//Function Number: 44
func_F3EF(param_00,param_01)
{
	switch(param_01)
	{
		case 1:
			param_00.var_C90A = 1;
			break;

		case 2:
			param_00.var_C90B = 1;
			break;

		case 3:
			param_00.var_C91F = 1;
			break;
	}
}

//Function Number: 45
func_FA51(param_00)
{
	var_01 = getweaponbasename(param_00);
	switch(var_01)
	{
		case "iw7_headcutter_zm":
			func_9618();
			break;

		case "iw7_facemelter_zm":
			func_95D7();
			break;

		case "iw7_dischord_zm":
			func_95AE();
			break;

		case "iw7_shredder_zm":
			func_9742();
			break;
	}
}

//Function Number: 46
func_9618()
{
	self.var_11A75 = "zmb_ice_monster_toy";
	self.var_11A76 = "ice_monster";
	self.var_28C5 = "alien_crafting_battery_single_01";
	self.var_4AE0 = "zmb_weapon_crystal_yellow";
	self.color = "yellow";
	self.var_1263B = "weapon_zappers_headcutter_wm";
	self.var_86D7 = "weapon_zappers_headcutter_wm";
	self.var_A858 = "yellow";
	self.var_CC1E = level._effect["part_glow_yellow"];
	self.var_CC1F = level._effect["part_glow_yellow_complete"];
	self.var_10DAF = scripts\common\utility::getstructarray("hc_start_struct","targetname");
	self.var_3CBE = 750;
	self.var_4AE1 = 0;
	self.var_CBFE = &"CP_QUEST_WOR_PLACE_HC";
}

//Function Number: 47
func_95D7()
{
	self.var_11A75 = "decor_spaceshuttle_boosters_toy";
	self.var_11A76 = "spaceshuttle";
	self.var_28C5 = "alien_crafting_battery_single_01";
	self.var_4AE0 = "zmb_weapon_crystal_blue";
	self.color = "blue";
	self.var_1263B = "weapon_zappers_facemelter_wm";
	self.var_86D7 = "weapon_zappers_facemelter_wm";
	self.var_A858 = "blue";
	self.var_CC1E = level._effect["part_glow_blue"];
	self.var_CC1F = level._effect["part_glow_blue_complete"];
	self.var_10DAF = scripts\common\utility::getstructarray("fm_start_struct","targetname");
	self.var_3CBE = 750;
	self.var_4AE1 = 1;
	self.var_CBFE = &"CP_QUEST_WOR_PLACE_FACEMELTER";
}

//Function Number: 48
func_95AE()
{
	self.var_11A75 = "zmb_spaceland_discoball_toy";
	self.var_11A76 = "discoball";
	self.var_28C5 = "alien_crafting_battery_single_01";
	self.var_4AE0 = "zmb_weapon_crystal_green";
	self.color = "green";
	self.var_1263B = "weapon_zappers_dischord_wm";
	self.var_86D7 = "weapon_zappers_dischord_wm";
	self.var_A858 = "green";
	self.var_CC1E = level._effect["part_glow_green"];
	self.var_CC1F = level._effect["part_glow_green_complete"];
	self.var_10DAF = scripts\common\utility::getstructarray("dischord_start_struct","targetname");
	self.var_3CBE = 750;
	self.var_4AE1 = 2;
	self.var_CBFE = &"CP_QUEST_WOR_PLACE_DISCHORD";
}

//Function Number: 49
func_9742()
{
	self.var_11A75 = "statue_angry_mike_toy";
	self.var_11A76 = "angry_mike";
	self.var_28C5 = "alien_crafting_battery_single_01";
	self.var_4AE0 = "zmb_weapon_crystal_red";
	self.color = "red";
	self.var_1263B = "weapon_zappers_shredder_wm";
	self.var_86D7 = "weapon_zappers_shredder_wm";
	self.var_A858 = "red";
	self.var_CC1E = level._effect["part_glow_red"];
	self.var_CC1F = level._effect["part_glow_red_complete"];
	self.var_10DAF = scripts\common\utility::getstructarray("shredder_start_struct","targetname");
	self.var_3CBE = 750;
	self.var_4AE1 = 3;
	self.var_CBFE = &"CP_QUEST_WOR_PLACE_SHREDDER";
}

//Function Number: 50
func_7B6B(param_00)
{
	switch(param_00)
	{
		case 1:
			return "toy";

		case 2:
			return "battery";

		case 3:
			return "crystal";
	}

	return undefined;
}

//Function Number: 51
func_7B4A(param_00,param_01)
{
	var_02 = getweaponbasename(param_00);
	switch(var_02)
	{
		case "iw7_headcutter_zm":
			switch(param_01)
			{
				case 1:
					return 10;
	
				case 2:
					return 11;
	
				case 3:
					return 12;
			}
			break;

		case "iw7_facemelter_zm":
			switch(param_01)
			{
				case 1:
					return 13;
	
				case 2:
					return 14;
	
				case 3:
					return 15;
			}
			break;

		case "iw7_dischord_zm":
			switch(param_01)
			{
				case 1:
					return 16;
	
				case 2:
					return 17;
	
				case 3:
					return 18;
			}
			break;

		case "iw7_shredder_zm":
			switch(param_01)
			{
				case 1:
					return 19;
	
				case 2:
					return 20;
	
				case 3:
					return 21;
			}
			break;
	}

	return undefined;
}

//Function Number: 52
func_7B6A(param_00,param_01)
{
	switch(param_01)
	{
		case 1:
			return param_00.var_11A75;

		case 2:
			return param_00.var_28C5;

		case 3:
			return param_00.var_4AE0;
	}

	return undefined;
}

//Function Number: 53
func_7D11(param_00)
{
	var_01 = getweaponbasename(param_00.var_86C1);
	switch(var_01)
	{
		case "iw7_headcutter_zm":
			return (0,-90,0);

		case "iw7_facemelter_zm":
			return (0,0,0);

		case "iw7_dischord_zm":
			return (0,0,0);

		case "iw7_shredder_zm":
			return (0,0,0);
	}

	return undefined;
}

//Function Number: 54
func_7D12(param_00)
{
	var_01 = getweaponbasename(param_00.var_86C1);
	switch(var_01)
	{
		case "iw7_headcutter_zm":
			return (-4,1,3);

		case "iw7_facemelter_zm":
			return (0,0,0);

		case "iw7_dischord_zm":
			return (0,0,10);

		case "iw7_shredder_zm":
			return (0,0,0);
	}

	return undefined;
}

//Function Number: 55
func_13DB8(param_00,param_01)
{
	if(scripts\common\utility::flag("mini_ufo_yellow_ready") && level.var_8C5C >= 15)
	{
		level notify("ww_iw7_headcutter_zm_crystal_dropped",param_00.origin);
	}

	if(scripts\common\utility::flag("mini_ufo_red_ready") && level.var_1E90 >= 15)
	{
		level notify("ww_iw7_shredder_zm_crystal_dropped",param_00.origin);
	}

	if(scripts\common\utility::flag("mini_ufo_green_ready") && level.var_562D >= 15)
	{
		level notify("ww_iw7_dischord_zm_crystal_dropped",param_00.origin);
	}

	if(scripts\common\utility::flag("mini_ufo_blue_ready") && level.var_E5D7 >= 15)
	{
		level notify("ww_iw7_facemelter_zm_crystal_dropped",param_00.origin);
	}
}

//Function Number: 56
func_13DB6()
{
	level.var_8C66 = ["zmb_coin_ice","zmb_coin_ice","zmb_coin_ice"];
	level.var_10164 = ["zmb_coin_alien","zmb_coin_alien","zmb_coin_alien"];
	level.var_5621 = ["zmb_coin_alien","zmb_coin_space","zmb_coin_ice"];
	level.var_6A75 = ["zmb_coin_space","zmb_coin_space","zmb_coin_space"];
	var_00 = "europa_tunnel";
	var_01 = "moon_outside_begin";
	var_02 = "mars_3";
	var_03 = "moon_bumpercars";
	var_04 = [];
	while(var_04.size < 4)
	{
		level waittill("quest_crafting_check",var_05);
		if(scripts\cp\_utility::is_codxp())
		{
			continue;
		}

		if(!isdefined(var_04["iw7_headcutter_zm"]) && func_94CB(var_05.var_94CA,level.var_8C66))
		{
			if(isdefined(var_05.var_D71C) && var_05.var_D71C == var_00)
			{
				level notify("ww_iw7_headcutter_zm_toy_dropped",var_05.origin);
				var_04["iw7_headcutter_zm"] = 1;
			}
		}

		if(!isdefined(var_04["iw7_shredder_zm"]) && func_94CB(var_05.var_94CA,level.var_10164))
		{
			if(isdefined(var_05.var_D71C) && var_05.var_D71C == var_02)
			{
				level notify("ww_iw7_shredder_zm_toy_dropped",var_05.origin);
				var_04["iw7_shredder_zm"] = 1;
			}
		}

		if(!isdefined(var_04["iw7_dischord_zm"]) && func_94CB(var_05.var_94CA,level.var_5621))
		{
			if(isdefined(var_05.var_D71C) && var_05.var_D71C == var_03)
			{
				level notify("ww_iw7_dischord_zm_toy_dropped",var_05.origin);
				var_04["iw7_dischord_zm"] = 1;
			}
		}

		if(!isdefined(var_04["iw7_facemelter_zm"]) && func_94CB(var_05.var_94CA,level.var_6A75))
		{
			if(isdefined(var_05.var_D71C) && var_05.var_D71C == var_01)
			{
				level notify("ww_iw7_facemelter_zm_toy_dropped",var_05.origin);
				var_04["iw7_facemelter_zm"] = 1;
			}
		}
	}
}

//Function Number: 57
func_94CB(param_00,param_01)
{
	if(param_01.size == 0)
	{
		return 0;
	}

	foreach(var_03 in param_00)
	{
		var_04 = undefined;
		foreach(var_06 in param_01)
		{
			if(var_03 == var_06)
			{
				var_04 = var_06;
				break;
			}
		}

		if(!isdefined(var_04))
		{
			return 0;
		}
		else
		{
			param_01 = func_22B7(param_01,var_04);
		}
	}

	return 1;
}

//Function Number: 58
func_22B7(param_00,param_01)
{
	var_02 = 0;
	var_03 = [];
	foreach(var_05 in param_00)
	{
		if(var_02)
		{
			var_03[var_03.size] = var_05;
			continue;
		}

		if(var_05 != param_01)
		{
			var_03[var_03.size] = var_05;
			continue;
		}

		var_02 = 1;
	}

	return var_03;
}

//Function Number: 59
func_722E(param_00,param_01,param_02)
{
	var_03 = scripts\common\utility::getstructarray("toy_trail_start","targetname");
	var_04 = scripts\common\utility::getclosest(self.origin,var_03);
	wait(0.5);
	self moveto(var_04.origin,0.5);
	self waittill("movedone");
	var_05 = scripts\common\utility::getstruct(var_04.target,"targetname");
	self moveto(var_05.origin,0.5);
	self waittill("movedone");
	while(isdefined(var_05.target))
	{
		var_05 = scripts\common\utility::getstruct(var_05.target,"targetname");
		if(!isdefined(var_05.target))
		{
			var_06 = var_05.origin - var_04.origin;
			var_06 = vectornormalize(var_06);
			var_06 = var_06 * 40;
			var_06 = (var_06[0],var_06[1],0);
			var_05.origin = var_05.origin + var_06;
		}

		self moveto(var_05.origin,0.75);
		self waittill("movedone");
	}

	self movez(-10,0.5);
	wait(0.5);
}

//Function Number: 60
func_109FF()
{
	self endon("death");
	self endon("trigger");
	for(;;)
	{
		self rotateyaw(360,2);
		self movez(5,2);
		self waittill("movedone");
		self movez(-5,2);
		self rotateyaw(360,2);
		self waittill("movedone");
	}
}

//Function Number: 61
func_AD5F()
{
	level.var_10162 = 1;
	level notify("ww_iw7_shredder_zm_battery_dropped",self.origin);
}

//Function Number: 62
func_AD57()
{
	if(scripts\cp\_utility::is_codxp())
	{
		return;
	}

	self endon("disconnect");
	while(!scripts\common\utility::func_6E34("fast_travel_init_done"))
	{
		wait(0.1);
	}

	scripts\common\utility::flag_wait("fast_travel_init_done");
	var_00 = getentarray("portal_grenade_volume","targetname");
	for(;;)
	{
		self waittill("grenade_fire",var_01,var_02);
		if(isdefined(var_01) && isdefined(var_02))
		{
			var_01 thread func_135DE(var_00[0],var_02,self);
		}
	}
}

//Function Number: 63
func_3D85(param_00,param_01,param_02)
{
	self endon("death");
	scripts\common\utility::func_136F7();
	if(!isdefined(level.var_90C0))
	{
		level.var_90C0 = 0;
	}

	for(;;)
	{
		if(level.var_90C0 == 0)
		{
			if(!level.var_6A7A.var_D67A && !level.var_6A7A.var_D677)
			{
				wait(0.1);
				continue;
			}

			if(self istouching(param_00))
			{
				level.var_90C0 = 1;
				level thread func_10C81(self,param_00,param_01,param_02);
			}
		}
		else if(isdefined(level.var_90BF) && param_02 == level.var_90BF && func_9CE6(param_02))
		{
			self.var_D717 = 1;
			level.var_90BF = undefined;
			level.last_potato_carrier = param_02;
			if(self istouching(param_00))
			{
				level thread func_117FC(self,param_02);
			}
		}

		if(scripts\common\utility::istrue(self.var_D717))
		{
			if(self istouching(param_00))
			{
				level thread func_117FC(self,param_02);
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 64
func_10C81(param_00,param_01,param_02,param_03)
{
	level endon("end_hot_potato_stage_1");
	level.var_D718 = 1;
	var_04 = param_00 func_117FD(param_01,param_02,param_03,5);
	param_00 delete();
	var_04 thread func_C143();
	var_04 thread func_AD5C();
	var_05 = level scripts\common\utility::func_13734("hot_potato_timed_out");
	if(var_05 == "hot_potato_timed_out")
	{
		if(isdefined(level.last_potato_carrier))
		{
			level thread func_CD0D(level.last_potato_carrier,2);
		}

		level.var_90BF = undefined;
		level.last_potato_carrier = undefined;
		level.var_90C0 = 0;
	}
}

//Function Number: 65
func_CD0D(param_00,param_01)
{
	param_00 endon("death");
	wait(param_01);
	param_00 playlocalsound("zapper_grenade_toss_fail");
}

//Function Number: 66
func_AD5C()
{
	level endon("hot_potato_timed_out");
	self waittill("trigger",var_00);
	level.var_90BF = var_00;
}

//Function Number: 67
func_117FC(param_00,param_01)
{
	level.var_90C0 = 2;
	level notify("ww_iw7_facemelter_zm_battery_dropped",param_01.origin);
	param_00 delete();
}

//Function Number: 68
func_C143()
{
	self waittill("explode");
	level.var_90C0 = 0;
	level notify("hot_potato_timed_out");
}

//Function Number: 69
func_117FD(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 5;
	}

	var_04 = (3756,1379,115);
	var_05 = (-200,0,0);
	var_05 = var_05 + (randomintrange(-100,100),randomintrange(-10,10),0);
	var_06 = param_00 method_8449("frag_grenade_zm",var_04,var_05,param_03);
	var_06 method_818E(1,1,1);
	var_06.var_D717 = 1;
	return var_06;
}

//Function Number: 70
func_9CE6(param_00)
{
	if(!isdefined(param_00.var_11817))
	{
		return 1;
	}

	return 0;
}

//Function Number: 71
func_C14F(param_00)
{
	self waittill(param_00,var_01,var_02,var_03,var_04,var_05);
	var_06 = 0;
}

//Function Number: 72
func_135DE(param_00,param_01,param_02)
{
	self endon("death");
	var_03 = 20;
	var_04 = var_03 * var_03;
	var_05 = scripts\common\utility::getstructarray("freeze_breath_struct","targetname");
	var_05 = scripts\common\utility::func_782F(self.origin,var_05);
	var_06 = var_05[0];
	if(!isdefined(level.var_6A7A))
	{
		level.var_6A7A = scripts\common\utility::getclosest(param_00.origin,level.fast_travel_spots);
	}

	if(facemelter_grenade_check(param_01))
	{
		if(!isdefined(level.var_90C0) || level.var_90C0 < 1)
		{
			thread func_3D85(param_00,param_01,param_02);
		}
		else if(level.var_90C0 < 2)
		{
			if(isdefined(level.var_90BF) && level.var_90BF == param_02)
			{
				self.var_D717 = 1;
				level.var_90BF = undefined;
				thread func_C143();
				thread func_AD5C();
				param_00 = getent("center_portal_grenade_volume","targetname");
				thread func_3D85(param_00,param_01,param_02);
			}
		}
	}

	thread func_AD59(var_04,var_06,param_02);
}

//Function Number: 73
facemelter_grenade_check(param_00)
{
	switch(param_00)
	{
		case "cluster_grenade_zm":
		case "semtex_zm":
		case "frag_grenade_zm":
			return 1;
	}

	return 0;
}

//Function Number: 74
func_AD59(param_00,param_01,param_02)
{
	if(!isdefined(self.var_13C2E) || self.var_13C2E != "zfreeze_semtex_mp")
	{
		return;
	}

	self waittill("explode",var_03);
	var_04 = getent("headcutter_grenade_vol","targetname");
	if(function_010F(var_03,var_04))
	{
		param_01 notify("cryo_hit");
		if(isdefined(param_02))
		{
			param_02 thread scripts\cp\_vo::try_to_play_vo("quest_icemonster_grenade","zmb_comment_vo","highest",10,1,0,0,100);
		}
	}
}

//Function Number: 75
func_AD60()
{
	level scripts\common\utility::func_13734("power_on","europa_tunnel power_on");
	scripts\common\utility::flag_init("listen_for_cryo_hit");
	scripts\common\utility::flag_set("listen_for_cryo_hit");
}

//Function Number: 76
func_13DAC(param_00)
{
	if(!isdefined(level.var_13DB5) || level.var_13DB5 < 5)
	{
		level.var_13DB5 = 5;
	}

	while(level.var_13DB5 > 0)
	{
		level.var_13DB5--;
		wait(1);
	}
}

//Function Number: 77
func_13685()
{
	level waittill("player_entering_wor_changed_portal",var_00);
	var_01 = scripts\common\utility::getstruct("facemelter_battery_org","targetname");
	level notify("ww_iw7_facemelter_zm_battery_dropped",var_01.origin);
	while(!isdefined(level.var_6A73))
	{
		wait(0.1);
	}

	level thread func_6A74();
}

//Function Number: 78
func_6A74()
{
	level endon("ww_iw7_facemelter_zm_battery_picked_up");
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(!var_01 func_9C17())
			{
				level.var_6A73 method_8429(var_01);
				level.var_6A73 disableplayeruse(var_01);
				continue;
			}

			level.var_6A73 showtoplayer(var_01);
			level.var_6A73 enableplayeruse(var_01);
		}

		wait(0.1);
	}
}

//Function Number: 79
func_9C17()
{
	return scripts\common\utility::istrue(self.var_13DB4);
}

//Function Number: 80
func_5623()
{
	level.var_13DAE = 0;
	level.var_5629 = 0;
	var_00 = getentarray("dischord_target","targetname");
	var_00 = scripts\common\utility::array_randomize(var_00);
	var_01 = 0;
	var_02 = scripts\common\utility::getclosest((3504,-1297,172),var_00,500);
	var_03 = scripts\common\utility::getclosest((1865,-2068,1046),var_00,500);
	level.var_5628 = [5];
	foreach(var_05 in var_00)
	{
		if(var_01 < 5)
		{
			level.var_5628[var_01] = var_05;
			level thread func_5627(var_05);
		}

		if(var_05 == var_02)
		{
			var_05.origin = var_05.origin + (0,-25,5);
		}

		if(var_05 == var_03)
		{
			var_05.origin = (1866,-2107,835);
			var_05.angles = (74,117,0);
		}

		var_05 hide();
		var_01++;
	}

	level thread func_562A();
	level waittill("ww_iw7_dischord_zm_battery_dropped");
}

//Function Number: 81
func_5627(param_00)
{
	param_00 method_818E(1,1,0);
	param_00 setcandamage(1);
	var_01 = 0;
	while(!var_01)
	{
		param_00 waittill("damage",var_02,var_03);
		if(isplayer(var_03) && scripts\common\utility::istrue(var_03.var_13CE5) || level.var_4EC4)
		{
			level.var_5629++;
			var_01 = 1;
			if(level.var_5629 >= 5)
			{
				level notify("ww_iw7_dischord_zm_battery_dropped",param_00.origin - (0,0,50));
			}
		}
	}

	playfx(level._effect["pickup"],param_00.origin);
	param_00 notify("stop_visibility_listener");
	if(scripts\common\utility::func_2286(level.var_5628,param_00))
	{
		level.var_5628 = scripts\common\utility::func_22A9(level.var_5628,param_00);
	}

	param_00 delete();
}

//Function Number: 82
func_562A()
{
	self endon("stop_visibility_listener");
	if(!isdefined(level.var_4EC4))
	{
		level.var_4EC4 = 0;
	}

	for(;;)
	{
		foreach(var_01 in level.var_5628)
		{
			foreach(var_03 in level.players)
			{
				if(scripts\common\utility::istrue(var_03.var_13CE5) || level.var_4EC4)
				{
					var_01 showtoplayer(var_03);
					var_01 method_818E(1,1,0);
					continue;
				}

				var_01 method_8429(var_03);
			}
		}

		wait(1);
	}
}

//Function Number: 83
func_4F19()
{
	if(!isdefined(level.var_4EC4))
	{
		level.var_4EC4 = 0;
	}

	for(;;)
	{
		var_00 = getdvarint("scr_show_dischord_targets",0);
		if(var_00 != 0)
		{
			if(level.var_4EC4)
			{
				level.var_4EC4 = 0;
				func_4EF2();
			}
			else
			{
				func_4EF3();
				level.var_4EC4 = 1;
			}

			setdvar("scr_show_dischord_targets",0);
		}

		wait(0.1);
	}
}

//Function Number: 84
func_4EF3()
{
	var_00 = getentarray("dischord_target","targetname");
	foreach(var_02 in var_00)
	{
		var_02 show();
		var_02 method_818E(1,0,0);
	}
}

//Function Number: 85
func_4EF2()
{
	var_00 = getentarray("dischord_target","targetname");
	foreach(var_02 in var_00)
	{
		var_02 method_818E(1,1,0);
		var_02 hide();
	}
}

//Function Number: 86
func_5620()
{
	var_00 = scripts\common\utility::getstruct("dischord_battery_end_loc","targetname");
	self moveto(var_00.origin,5,0.1,0.1);
	self waittill("movedone");
}

//Function Number: 87
func_13DB9()
{
	if(!isdefined(level.glasses_drop_change_increase))
	{
		level.glasses_drop_change_increase = 0;
	}

	var_00 = randomint(100);
	var_01 = 10 + level.glasses_drop_change_increase;
	if(var_00 < var_01 && !level.var_13DAE)
	{
		level.glasses_drop_change_increase = 0;
		return "quest";
	}
	else
	{
		level.glasses_drop_change_increase = level.glasses_drop_change_increase + 10;
	}

	return undefined;
}

//Function Number: 88
func_13DBA(param_00,param_01,param_02)
{
	playfx(level._effect["souvenir_pickup"],param_02.origin + (0,0,30));
	param_00 func_82D2();
	param_00 scripts\cp\_utility::setlowermessage("msg_power_hint",&"CP_QUEST_WOR_GLASSES_TOGGLE",4);
	param_02 notify("all_players_searched");
}

//Function Number: 89
func_82D2()
{
	var_00 = spawnstruct();
	var_00.var_D742 = "power_glasses";
	scripts\cp\powers\coop_powers::func_8319(var_00,self);
	var_00 = undefined;
}

//Function Number: 90
func_13DB7(param_00,param_01)
{
	param_00.type = "quest";
	param_00.var_195 = "quest";
	param_01.var_5FDF = spawnfx(level._effect["quest_glasses_drop"],param_01.origin);
	level.var_13DAE = 1;
	param_00 thread func_12BF9(param_01.var_5FDF);
	scripts\common\utility::func_136F7();
	triggerfx(param_01.var_5FDF);
}

//Function Number: 91
func_12BF9(param_00)
{
	self endon("picked_up");
	self waittill("stop_pillage_spot_think");
	level.var_13DAE = 0;
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 92
func_82D3()
{
	self.var_8B71 = 1;
	self.var_594F = "power_glasses";
	thread func_AD63();
	thread func_E1EC();
	scripts\common\utility::flag_set("dischord_glasses_pickedup");
}

//Function Number: 93
func_DB22(param_00)
{
	var_01 = "ges_visor_up";
	if(!self isgestureplaying())
	{
		var_02 = 0;
		self setweaponammostock("iw7_sunglasses_zm_on",1);
		self giveandfireoffhand("iw7_sunglasses_zm_on");
	}

	thread func_DB21();
	scripts\common\utility::flag_set("dischord_glasses_pickedup");
}

//Function Number: 94
func_E030()
{
	self notify("removing_glasses_from_player");
	self.var_13CE5 = 0;
	self.var_8B71 = 0;
	self visionsetnakedforplayer("",0.1);
	self.var_594F = undefined;
}

//Function Number: 95
func_DB21()
{
	wait(1);
	self.var_13CE5 = 1;
	self visionsetnakedforplayer("cp_zmb_bw",0.1);
	thread func_13681();
	thread reapply_visionset_after_host_migration();
	thread scripts\cp\_vo::try_to_play_vo("sunglasses","zmb_comment_vo","low",30,0,0,0,30);
}

//Function Number: 96
reapply_visionset_after_host_migration()
{
	self endon("death");
	self endon("disconnect");
	self endon("removing_glasses_from_player");
	level waittill("host_migration_begin");
	level waittill("host_migration_end");
	if(scripts\common\utility::istrue(self.var_13CE5))
	{
		self visionsetnakedforplayer("cp_zmb_bw");
		thread func_13681();
	}
}

//Function Number: 97
func_1143A(param_00)
{
	if(param_00)
	{
		thread func_AA7A();
		return;
	}

	self.var_13CE5 = 0;
	if(isdefined(level.var_13445))
	{
		self visionsetnakedforplayer(level.var_13445,0.1);
	}
	else
	{
		self visionsetnakedforplayer("",0.1);
	}

	var_01 = "ges_visor_down";
	if(!self isgestureplaying())
	{
		var_02 = 0;
		self setweaponammostock("iw7_sunglasses_zm_off",1);
		self giveandfireoffhand("iw7_sunglasses_zm_off");
	}
}

//Function Number: 98
func_AA7A()
{
	self endon("deleting_glasses");
	scripts\cp\powers\coop_powers::func_E15E("power_glasses");
	var_00 = 400;
	var_01 = self gettagorigin("tag_eye");
	var_02 = self gettagangles("tag_eye");
	var_02 = anglestoforward(var_02);
	var_03 = vectornormalize(var_02) + (0,0,0.25);
	var_03 = var_03 * var_00;
	var_04 = self getvelocity();
	var_03 = var_03 + var_04;
	var_05 = spawn("script_model",var_01);
	var_05 setmodel("zmb_sunglass_01_wm");
	var_05 physicslaunchserver(var_01,var_03);
	wait(0.1);
	var_05 thread func_CB22();
	var_05 thread func_5157(10);
	var_05 waittill("trigger",var_06);
	var_06 func_82D2();
	var_05 notify("glasses_picked_up");
	var_05 delete();
}

//Function Number: 99
func_13681()
{
	level endon("ww_iw7_dischord_zm_battery_dropped");
	self notify("waiting_for_knock_off");
	self endon("waiting_for_knock_off");
	while(self.var_8B71)
	{
		self waittill("damage",var_00,var_01);
		if(isdefined(var_01.team) && var_01.team != self.team)
		{
			if(scripts\common\utility::istrue(self.var_13CE5))
			{
				func_1143A(1);
				wait(0.1);
				break;
			}
		}
	}
}

//Function Number: 100
func_AD63()
{
	self endon("removing_glasses_from_player");
	while(self.var_8B71)
	{
		self waittill("glasses_change");
		if(scripts\common\utility::istrue(self.var_13CE5))
		{
			func_1143A(0);
			continue;
		}

		func_DB22(self);
	}
}

//Function Number: 101
func_E1EC()
{
	self notify("glasses_flag_check_reset");
	self endon("glasses_flag_check_reset");
	self waittill("death");
	self.var_13CE5 = 0;
	self.var_8B71 = 0;
	self.var_594F = undefined;
}

//Function Number: 102
func_5157(param_00)
{
	self endon("glasses_picked_up");
	wait(param_00);
	self notify("deleting_glasses");
	level.var_13DAE = 0;
	self delete();
}

//Function Number: 103
func_CB22()
{
	self method_818E(2,1,0);
	self makeusable();
	var_00 = &"CP_QUEST_WOR_PART";
	self sethintstring(var_00);
}

//Function Number: 104
func_95AF()
{
	while(!scripts\common\utility::func_6E34("powers_init_done"))
	{
		wait(0.1);
	}

	while(!scripts\common\utility::flag("powers_init_done"))
	{
		wait(0.1);
	}

	scripts\cp\powers\coop_powers::func_D787("power_glasses",::func_F6C6,::func_12CA2,::func_13076,"powers_glasses_update",undefined,undefined);
}

//Function Number: 105
func_F6C6(param_00)
{
	func_82D3();
}

//Function Number: 106
func_12CA2()
{
	func_E030();
}

//Function Number: 107
func_13076()
{
	self notify("glasses_change");
	self.var_D782["power_glasses"].var_3D23 = 1;
}

//Function Number: 108
func_8C69()
{
	level.var_8C6B = scripts\common\utility::getstruct("headcutter_battery_loc","targetname");
	if(scripts\cp\_utility::is_codxp())
	{
		return;
	}

	level thread func_1367D();
	var_00 = scripts\common\utility::getstructarray("freeze_breath_struct","targetname");
	foreach(var_02 in var_00)
	{
		if(var_02.target == "freeze_volume_1")
		{
			var_02 thread func_8C68();
			var_02 thread func_7376();
			var_02 thread func_AD55();
		}
	}
}

//Function Number: 109
func_8C68()
{
	level endon("hc_freeze_done");
	self.var_7372 = 1;
}

//Function Number: 110
func_7376()
{
	self endon("stop_feeze_loop");
	self.var_7382 = getent(self.target,"targetname");
	var_00 = getent("main_street_monster","targetname");
	var_01 = 10;
	for(;;)
	{
		self waittill("cryo_hit");
		if(self.var_7372)
		{
			var_00 setscriptablepartstate("main","breath_attack_in");
			thread func_7374(var_01);
			func_15AF(var_01);
			var_00 setscriptablepartstate("main","idle2");
		}

		wait(0.1);
	}
}

//Function Number: 111
func_15AF(param_00)
{
	var_01 = gettime() + param_00 * 1000;
	while(gettime() < var_01)
	{
		foreach(var_03 in level.spawned_enemies)
		{
			if(isdefined(var_03.agent_type) && var_03.agent_type == "generic_zombie" || var_03.agent_type == "zombie_cop")
			{
				if(var_03 istouching(self.var_7382))
				{
					var_03.var_7381 = self;
					var_03 dodamage(1,var_03.origin,level.players[0],level.players[0],"MOD_GRENADE_SPLASH","zfreeze_semtex_mp");
				}
			}
		}

		wait(0.1);
	}
}

//Function Number: 112
func_7374(param_00)
{
	var_01 = getent("main_street_monster","targetname");
	var_02 = spawnfx(level._effect["coaster_ice_frost"],self.origin,anglestoforward(self.angles),anglestoup(self.angles));
	wait(2);
	var_01 playsound("yeti_frost_breath");
	triggerfx(var_02);
	wait(param_00 - 1);
	var_02 delete();
}

//Function Number: 113
func_AD55()
{
	var_00 = 0;
	var_01 = 10;
	while(var_00 < var_01)
	{
		self waittill("headcutter_cryo_kill",var_02,var_03);
		var_00++;
		level.var_11A20++;
	}

	var_04 = getent("main_street_monster","targetname");
	var_04 playsound("yeti_growl");
}

//Function Number: 114
func_1367D()
{
	for(;;)
	{
		if(level.var_11A20 >= 10)
		{
			level notify("ww_iw7_headcutter_zm_battery_dropped",level.var_8C6B.origin);
		}

		wait(0.25);
	}
}

//Function Number: 115
func_573C()
{
	wait(1000);
	level thread scripts\cp\_vo::func_1769("dj_quest_ufo_partsrecovery_hint","zmb_dj_vo",60,15,2,1);
}

//Function Number: 116
func_13DAD(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	if(scripts\cp\zombies\zmb_zombies_weapons::func_FFA6(param_00))
	{
		var_03 = param_00 scripts\cp\_utility::getvalidtakeweapon();
		var_04 = scripts\cp\_utility::func_80D8(var_03);
		param_00 takeweapon(var_03);
		if(isdefined(param_00.var_C8A2[var_04]))
		{
			param_00.var_C8A2[var_04] = undefined;
			param_00 notify("weapon_level_changed");
		}
	}

	var_05 = scripts\cp\_utility::func_80D8(param_01);
	if(param_00 hasweapon("iw7_fists_zm"))
	{
		param_00 takeweapon("iw7_fists_zm");
	}

	if(scripts\common\utility::istrue(param_02.var_10B6C.var_12F76))
	{
		switch(param_01)
		{
			case "iw7_facemelter_zm":
				param_01 = "iw7_facemelter_zm_pap1+fmpap1+camo22";
				break;

			case "iw7_shredder_zm":
				param_01 = "iw7_shredder_zm_pap1+shredderpap1+camo23";
				break;

			case "iw7_headcutter_zm":
				param_01 = "iw7_headcutter_zm_pap1+hcpap1+camo21";
				break;

			case "iw7_dischord_zm":
				param_01 = "iw7_dischord_zm_pap1+dischordpap1+camo20";
				break;
		}
	}

	param_01 = param_00 scripts\cp\_utility::func_12C6(param_01,undefined,undefined,0);
	if(issubstr(param_01,"emc"))
	{
		param_00.var_8BA0 = 1;
	}

	param_00 notify("wor_item_pickup",param_01);
	var_06 = 1;
	if(isdefined(param_02.clip))
	{
		var_06 = 0;
		param_00 setweaponammoclip(param_01,param_02.clip);
	}

	if(isdefined(param_02.var_10FAF))
	{
		var_06 = 0;
		param_00 setweaponammostock(param_01,param_02.var_10FAF);
	}

	param_00 switchtoweapon(param_01);
	if(var_06)
	{
		param_00 givemaxammo(param_01);
	}

	var_07 = scripts\cp\_utility::func_80D8(param_01);
	if(issubstr(param_01,"dischord"))
	{
		if(param_00.var_134FD == "p3_")
		{
			param_00 thread scripts\cp\_vo::try_to_play_vo("receive_wor_fav","zmb_comment_vo","highest",10,0,0,1);
		}
		else
		{
			param_00 thread scripts\cp\_vo::try_to_play_vo("receive_wor","zmb_comment_vo","highest",10,0,0,1);
		}

		scripts\cp\zombies\zombie_analytics::log_crafted_wor_dischord(level.wave_num);
	}
	else if(issubstr(param_01,"facemelter"))
	{
		if(param_00.var_134FD == "p2_")
		{
			param_00 thread scripts\cp\_vo::try_to_play_vo("receive_wor_fav","zmb_comment_vo","highest",10,0,0,1);
		}
		else
		{
			param_00 thread scripts\cp\_vo::try_to_play_vo("receive_wor","zmb_comment_vo","highest",10,0,0,1);
		}

		scripts\cp\zombies\zombie_analytics::log_crafted_wor_facemelter(level.wave_num);
	}
	else if(issubstr(param_01,"shredder"))
	{
		if(param_00.var_134FD == "p4_")
		{
			param_00 thread scripts\cp\_vo::try_to_play_vo("receive_wor_fav","zmb_comment_vo","highest",10,0,0,1);
		}
		else
		{
			param_00 thread scripts\cp\_vo::try_to_play_vo("receive_wor","zmb_comment_vo","highest",10,0,0,1);
		}

		scripts\cp\zombies\zombie_analytics::log_crafted_wor_shredder(level.wave_num);
	}
	else if(issubstr(param_01,"headcutter"))
	{
		if(param_00.var_134FD == "p1_")
		{
			param_00 thread scripts\cp\_vo::try_to_play_vo("receive_wor_fav","zmb_comment_vo","highest",10,0,0,1);
		}
		else
		{
			param_00 thread scripts\cp\_vo::try_to_play_vo("receive_wor","zmb_comment_vo","highest",10,0,0,1);
		}

		scripts\cp\zombies\zombie_analytics::log_crafted_wor_headcutter(level.wave_num);
	}

	param_00 lib_0D2A::func_12D7C("ROCK_ON",1);
	level thread scripts\cp\_vo::func_E01F("dj_wor_use_nag");
	var_08 = spawnstruct();
	var_08.var_B111 = 1;
	param_00.var_C8A2[var_05] = var_08;
	param_00 notify("weapon_level_changed");
}

//Function Number: 117
func_11B03(param_00,param_01,param_02)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	level endon("gun_replaced " + param_01);
	param_02.var_10FAF = param_00 getweaponammostock(param_01);
	param_02.clip = param_00 getweaponammoclip(param_01);
	for(;;)
	{
		param_00 scripts\common\utility::waittill_any_3("weapon_fired","reload");
		if(scripts\common\utility::istrue(param_00.inlaststand))
		{
			continue;
		}

		if(scripts\common\utility::istrue(level.var_94A4))
		{
			continue;
		}

		var_03 = param_00 getcurrentweapon();
		var_04 = getweaponbasename(var_03);
		if(var_04 == param_01 || var_04 == param_01 + "_pap1")
		{
			param_02.var_10FAF = param_00 getweaponammostock(var_03);
			param_02.clip = param_00 getweaponammoclip(var_03);
		}
	}
}

//Function Number: 118
func_13A59(param_00,param_01,param_02)
{
	level thread func_13A5A(param_00,param_01,param_02);
	level endon("gun_replaced " + param_01);
	level endon("game_ended");
	param_00 endon("disconnect");
	var_03 = getweaponbasename(param_01);
	var_04 = 1;
	for(;;)
	{
		if(!var_04)
		{
			break;
		}

		var_05 = undefined;
		param_00 waittill("last_stand");
		var_04 = 0;
		var_06 = param_00 scripts\common\utility::waittill_any_return_no_endon_death_3("player_entered_ala","revive","death");
		if(var_06 != "revive")
		{
			var_05 = param_00 scripts\common\utility::func_13734("lost_and_found_collected","lost_and_found_time_out");
			if(isdefined(var_05) && var_05 == "lost_and_found_time_out")
			{
				continue;
			}
		}

		var_07 = param_00 getweaponslistall();
		foreach(var_09 in var_07)
		{
			var_0A = getweaponbasename(var_09);
			if(var_0A == var_03)
			{
				param_00 thread func_13A82(param_00,param_01,param_02);
				var_04 = 1;
				break;
			}
		}
	}

	thread func_DB24(param_02,var_03,undefined,param_00);
	param_00 scripts\cp\_utility::func_12EBE();
}

//Function Number: 119
func_9764()
{
	var_00 = scripts\common\utility::getstructarray("wor_standee","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.target))
		{
			var_03 = getscriptablearray(var_02.target,"targetname");
			if(var_03.size > 0)
			{
				var_02.var_10B6C = var_03[0];
				var_02.var_10B6C.var_86DC = 1;
				var_02 thread func_9765(::func_C920,var_02.var_10B6C.script_noteworthy);
			}
		}
	}
}

//Function Number: 120
func_13A82(param_00,param_01,param_02)
{
	level thread func_13A5A(param_00,param_01,param_02);
	level endon("gun_replaced " + param_01);
	level endon("game_ended");
	param_00 endon("last_stand");
	param_00 endon("disconnect");
	var_03 = getweaponbasename(param_01);
	var_04 = 1;
	for(;;)
	{
		if(!var_04)
		{
			break;
		}

		param_00 scripts\common\utility::waittill_any_3("weapon_purchased","mule_munchies_sold");
		var_04 = 0;
		var_05 = param_00 getweaponslistall();
		foreach(var_07 in var_05)
		{
			var_08 = getweaponbasename(var_07);
			if(issubstr(var_08,var_03))
			{
				var_04 = 1;
				break;
			}
		}
	}

	thread func_DB24(param_02,var_03,undefined,param_00);
	param_00 scripts\cp\_utility::func_12EBE();
}

//Function Number: 121
func_13A5A(param_00,param_01,param_02)
{
	level endon("gun_replaced " + param_01);
	param_00 waittill("disconnect");
	thread func_DB24(param_02,param_01,undefined,param_00);
	param_00 scripts\cp\_utility::func_12EBE();
}