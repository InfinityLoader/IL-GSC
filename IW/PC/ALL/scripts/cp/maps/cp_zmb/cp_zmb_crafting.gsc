/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_zmb\cp_zmb_crafting.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 1143 ms
 * Timestamp: 10/27/2023 12:08:03 AM
*******************************************************************/

//Function Number: 1
init_crafting()
{
	level.var_B426 = 1;
	level.var_C1E2 = 0;
	level.var_A89F = gettime();
	level.var_47C1 = 25000;
	level.var_47C0 = -5536;
	level.var_BF36 = gettime() + 180000;
	level.var_47BE = ::func_13F02;
	level.var_47BD = ::func_13F01;
	level.var_47C2 = func_78F1(level.crafting_table);
	level.var_47A7 = func_78EA(level.crafting_table);
	level.var_47C3 = level.var_47C2;
	level.var_CC0C = [];
	level.crafting_icon_create_func = ::func_4939;
}

//Function Number: 2
func_9596()
{
	var_00 = scripts\common\utility::getstructarray("crafting_station","script_noteworthy");
	foreach(var_03, var_02 in var_00)
	{
		var_02 thread func_47CE(var_03);
	}
}

//Function Number: 3
func_47CE(param_00)
{
	if(param_00 > 0)
	{
		wait(0.1 * param_00);
	}

	var_01 = scripts\common\utility::getstructarray(self.target,"targetname");
	foreach(var_03 in var_01)
	{
		if(var_03.script_noteworthy == "fx_spot")
		{
			self.var_47B8 = var_03;
			continue;
		}

		if(var_03.script_noteworthy == "egg_land_spot")
		{
			self.var_5FF5 = var_03;
		}
	}

	var_01 = getentarray(self.target,"targetname");
	foreach(var_03 in var_01)
	{
		if(var_03.script_noteworthy == "souvenir_light")
		{
			self.var_1B9 = var_03;
			continue;
		}

		if(var_03.script_noteworthy == "souvenir_toy")
		{
			self.var_1048E = var_03;
			continue;
		}

		if(var_03.script_noteworthy == "station")
		{
			self.var_1048C = var_03;
		}
	}

	if(isdefined(self.var_1B9))
	{
		self.var_1B9 setlightintensity(0);
	}

	if(scripts\common\utility::istrue(self.var_E1B9) && isdefined(self.var_D71C))
	{
		level scripts\common\utility::waittill_any_3("power_on",self.var_D71C + " power_on");
	}

	if(isdefined(self.var_1B9))
	{
		self.var_1B9 setlightintensity(0.65);
	}

	self.var_D776 = 1;
	self.var_6261 = 0;
	self.var_269F = 3;
	self.var_94CA = [];
	self.var_10485 = undefined;
	self.var_1048C setscriptablepartstate("body","default_on");
	self.var_1048C setscriptablepartstate("monitor_1","logo");
	self.var_1048C setscriptablepartstate("monitor_2","logo");
	self.var_1048C setscriptablepartstate("monitor_3","logo");
	self.var_5FF5.origin = self.var_5FF5.origin + (0,0,2);
}

//Function Number: 4
func_12FBE(param_00,param_01)
{
	if(!scripts\common\utility::func_2286(level.current_interaction_structs,param_00))
	{
		return;
	}

	if(param_00.var_269F > 0)
	{
		if(!isdefined(param_01.var_4B5E))
		{
			return;
		}

		param_01 playlocalsound("zmb_coin_sounvenir_place");
		param_01 thread scripts\cp\_vo::try_to_play_vo("souvenir_coin_station","zmb_comment_vo","medium",10,0,0,1,50);
		if(getweaponbasename(param_01 getcurrentweapon()) != "iw7_penetrationrail_mp")
		{
			thread scripts\cp\_utility::firegesturegrenade(param_01,"iw7_souvenircoin_zm");
		}

		var_02 = "logo";
		level.var_10490 = param_01.var_4B5E.var_47C9;
		switch(param_01.var_4B5E.var_47C9)
		{
			case "zmb_coin_alien":
				var_02 = "alien";
				break;

			case "zmb_coin_space":
				var_02 = "space";
				break;

			case "zmb_coin_ice":
				var_02 = "ice";
				break;
		}

		switch(param_00.var_269F)
		{
			case 3:
				param_00.var_1048C setscriptablepartstate("monitor_1",var_02);
				break;

			case 2:
				param_00.var_1048C setscriptablepartstate("monitor_2",var_02);
				break;

			case 1:
				param_00.var_1048C setscriptablepartstate("monitor_3",var_02);
				break;
		}

		playsoundatpos(param_00.var_47B8.origin + (0,0,-5),"zmb_souvenir_machine_arm_mvmt");
		param_01 setclientomnvar("zombie_souvenir_piece_index",0);
		param_00.var_94CA = scripts\common\utility::array_add_safe(param_00.var_94CA,param_01.var_4B5E.var_47C9);
		param_01.var_A8D3 = undefined;
		param_01.var_4B5E = undefined;
		param_00.var_269F--;
		param_01 scripts\cp\_merits::func_D9AD("mt_used_crafting");
		if(param_00.var_269F > 0)
		{
			return;
		}

		level notify("quest_crafting_check",param_00);
		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
		level thread func_1048F(param_00);
		wait(0.25);
		playfx(level._effect["crafting_souvenir"],param_00.var_47B8.origin + (0,0,-5));
		playsoundatpos(param_00.var_47B8.origin + (0,0,-5),"zmb_souvenir_machine_craft");
		wait(2);
		if(!isdefined(param_00.var_1048A))
		{
			param_00.var_1048A = param_00.var_1048E.origin;
			param_00.var_10489 = param_00.var_1048E.model;
		}

		param_00.var_1048E movez(-35,0.2);
		param_00.var_1048E waittill("movedone");
		param_00.var_1048E moveto(param_00.var_5FF5.origin,0.2);
		level thread scripts\cp\_vo::func_E01F("nag_use_souvenircoin");
		scripts\cp\zombies\zombie_analytics::func_AF89(level.wave_num,level.var_10490);
		func_47A5(param_00,param_01);
		if(param_01 scripts\cp\_utility::is_valid_player())
		{
			param_01 thread scripts\cp\_vo::try_to_play_vo("souvenir_craft_success","zmb_comment_vo","low",10,0,0,0,50);
		}

		scripts\cp\_vo::func_E01F("dj_souvenircoin_collect_nag");
		param_00.var_1048C setscriptablepartstate("monitor_3","logo");
		wait(0.1);
		param_00.var_1048C setscriptablepartstate("monitor_2","logo");
		wait(0.1);
		param_00.var_1048C setscriptablepartstate("monitor_1","logo");
		wait(0.1);
		scripts\cp\_interaction::add_to_current_interaction_list(param_00);
		while(isdefined(param_00.var_10485))
		{
			wait(0.1);
		}

		playfx(level._effect["souvenir_pickup"],param_00.var_1048E.origin + (0,0,-45));
		param_00.var_269F = 3;
		param_00.var_94CA = [];
		if(param_01 scripts\cp\_utility::is_valid_player())
		{
			param_01.var_A8D3 = undefined;
			return;
		}
	}
}

//Function Number: 5
func_1048F(param_00)
{
	var_01 = func_78EC(param_00);
	var_02 = lookupsoundlength("announcer_crafting_inform");
	playsoundatpos(param_00.var_1048C.origin + (0,0,60),"announcer_crafting_inform");
	wait(var_02 / 1000 + 0.25);
	switch(var_01)
	{
		case "crafted_autosentry":
			playsoundatpos(param_00.var_1048C.origin + (0,0,60),"announcer_crafting_sentry");
			break;

		case "crafted_ims":
			playsoundatpos(param_00.var_1048C.origin + (0,0,60),"announcer_crafting_fireworks");
			break;

		case "crafted_medusa":
			playsoundatpos(param_00.var_1048C.origin + (0,0,60),"announcer_crafting_medusa");
			break;

		case "crafted_electric_trap":
			playsoundatpos(param_00.var_1048C.origin + (0,0,60),"announcer_crafting_electric");
			break;

		case "crafted_boombox":
			playsoundatpos(param_00.var_1048C.origin + (0,0,60),"announcer_crafting_boombox");
			break;

		case "crafted_revocator":
			playsoundatpos(param_00.var_1048C.origin + (0,0,60),"announcer_crafting_revocator");
			break;

		case "crafted_gascan":
			playsoundatpos(param_00.var_1048C.origin + (0,0,60),"announcer_crafting_kindle");
			break;

		case "crafted_windowtrap":
			playsoundatpos(param_00.var_1048C.origin + (0,0,60),"announcer_crafting_laser");
			break;
	}
}

//Function Number: 6
func_13F02(param_00,param_01,param_02)
{
	if(!func_FF3B(param_01))
	{
		return 0;
	}

	level thread func_10697(param_01);
	return 1;
}

//Function Number: 7
func_13F01(param_00,param_01)
{
	level thread func_10697(param_00,param_01);
}

//Function Number: 8
func_10697(param_00,param_01)
{
	level.var_C1E2++;
	level.var_A89F = gettime();
	level.var_BF36 = level.var_A89F + 30000 + randomintrange(level.var_47C1,level.var_47C0);
	var_02 = spawn("script_model",param_00 + (0,0,45));
	var_02.angles = (90,0,0);
	var_02.var_C378 = (90,0,0);
	var_03 = scripts\common\utility::random(level.var_47C3);
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	var_02 setmodel(var_03);
	var_02.script_noteworthy = "crafting_item";
	var_04 = "red";
	if(var_02.model == "zmb_coin_space")
	{
		var_04 = "blue";
	}
	else if(var_02.model == "zmb_coin_ice")
	{
		var_04 = "green";
	}

	var_02 setscriptablepartstate("fx",var_04);
	var_05 = func_48C2(var_02,25);
	var_02 thread func_47C6(var_05);
}

//Function Number: 9
func_48C2(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.script_noteworthy = "crafting_pickup";
	var_02.origin = param_00.origin - (0,0,45);
	var_02.var_195 = param_00;
	var_02.var_E1B9 = 0;
	var_02.var_D776 = 1;
	var_02.var_EE79 = "crafting_pickup";
	var_02.name = "crafting_pickup";
	var_02.var_118D7 = param_01;
	var_02.var_47C9 = param_00.model;
	var_02.var_47BA = "";
	var_02.var_109DA = "souvenir_coin";
	scripts\cp\_interaction::add_to_current_interaction_list(var_02);
	return var_02;
}

//Function Number: 10
func_47C4(param_00,param_01)
{
	if(!isdefined(param_00.var_195))
	{
		return;
	}

	if(isdefined(param_00.var_195.var_2A89))
	{
		return;
	}

	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	if(!isdefined(level.var_4376))
	{
		level.var_4376 = 1;
		level thread scripts\cp\_vo::func_1769("dj_souvenircoin_collect_nag","zmb_dj_vo",60,60,2);
	}

	var_02 = param_00.origin + (0,0,45);
	playfx(level._effect["souvenir_pickup"],param_00.var_195.origin);
	param_00.var_195 delete();
	scripts\common\utility::func_136F7();
	if(isdefined(param_01.var_4B5E))
	{
		param_01 playlocalsound("zmb_coin_swap");
		var_03 = spawnstruct();
		var_03.script_noteworthy = "crafting_pickup";
		var_03.origin = param_00.origin;
		var_03.var_195 = spawn("script_model",var_02);
		var_03.var_195.angles = (90,0,0);
		var_03.var_195.var_C378 = (90,0,0);
		var_03.var_E1B9 = 0;
		var_03.var_D776 = 1;
		var_03.var_EE79 = param_01.var_4B5E.var_EE79;
		var_03.name = param_01.var_4B5E.name;
		var_03.var_118D7 = param_00.var_118D7;
		var_03.var_47C9 = param_01.var_4B5E.var_47C9;
		var_03.var_47BA = "";
		var_03.var_195 setmodel(var_03.var_47C9);
		param_01.var_4B5E = param_00;
		param_01 func_4939(param_00);
		var_03.var_195 thread func_47C6(var_03);
		param_00 = undefined;
		scripts\cp\_interaction::add_to_current_interaction_list(var_03);
		wait(0.3);
		var_04 = "red";
		if(var_03.var_195.model == "zmb_coin_space")
		{
			var_04 = "blue";
		}
		else if(var_03.var_195.model == "zmb_coin_ice")
		{
			var_04 = "green";
		}

		var_03.var_195 setscriptablepartstate("fx",var_04);
		return;
	}

	param_01 playlocalsound("zmb_coin_pickup");
	level.var_C1E2--;
	param_01.var_4B5E = param_00;
	param_01 thread scripts\cp\_vo::try_to_play_vo("pillage_craft","zmb_comment_vo","low",10,0,1,0,40);
	param_01 func_4939(param_00);
	if(isdefined(param_00.var_195))
	{
		param_00.var_195 delete();
	}
}

//Function Number: 11
func_4939(param_00)
{
	var_01 = func_7A27(param_00.var_47C9);
	self setclientomnvar("zombie_souvenir_piece_index",int(var_01));
}

//Function Number: 12
func_47C6(param_00)
{
	self endon("death");
	self endon("vacuum");
	self notify("timeout");
	self endon("timeout");
	var_01 = 25;
	if(isdefined(param_00.var_118D7))
	{
		var_01 = int(param_00.var_118D7);
	}

	var_02 = gettime() + var_01 * 1000;
	var_03 = 0;
	var_04 = 0;
	while(gettime() < var_02)
	{
		if(var_04 == 0)
		{
			self rotateyaw(360,2);
			self movez(5,2);
		}

		if(var_04 == 2)
		{
			self rotateyaw(360,2);
			self movez(-5,2);
		}

		if(var_04 == 4)
		{
			var_04 = 0;
			continue;
		}

		wait(1);
		var_04++;
		param_00.var_118D7 = param_00.var_118D7 - 1;
	}

	playsoundatpos(self.origin,"zmb_coin_disappear");
	playfx(level._effect["souvenir_pickup"],self.origin);
	level.var_C1E2--;
	if(level.var_C1E2 < 0)
	{
		level.var_C1E2 = 0;
	}

	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	self delete();
}

//Function Number: 13
func_FF3B(param_00)
{
	if(level.var_C1E2 >= level.var_B426)
	{
		return 0;
	}

	if(!self.entered_playspace)
	{
		return 0;
	}

	if(isdefined(level.var_164B))
	{
		if(![[ level.var_164B ]](param_00))
		{
			return 0;
		}
	}

	if(isdefined(level.var_9B0B))
	{
		if(!scripts\cp\_weapon::func_9E54(param_00,level.var_9B0B,undefined,undefined,1))
		{
			return 0;
		}
	}
	else if(!scripts\cp\_weapon::func_9E54(param_00,undefined,undefined,undefined,1))
	{
		return 0;
	}

	if(randomint(100) < 30)
	{
		return 0;
	}

	if(level.var_BF36 > gettime())
	{
		return 0;
	}

	return 1;
}

//Function Number: 14
func_47A5(param_00,param_01)
{
	var_02 = func_78EC(param_00);
	if(!isdefined(var_02))
	{
		var_02 = "money";
	}

	switch(var_02)
	{
		case "crafted_gascan":
		case "crafted_revocator":
		case "crafted_boombox":
		case "crafted_electric_trap":
		case "crafted_medusa":
		case "crafted_ims":
		case "crafted_autosentry":
		case "crafted_windowtrap":
			param_00.script_noteworthy = var_02;
			param_00.var_109DA = "craftable";
			param_00.var_E1B9 = 0;
			param_00.var_D776 = 1;
			param_00.var_EE79 = var_02;
			param_00.name = var_02;
			param_00.var_10485 = 1;
			param_00.var_D6B3 = 1;
			param_00.var_47B2 = 1;
			break;

		default:
			foreach(var_04 in level.players)
			{
				var_04 scripts\cp\_persistence::func_82F9(500);
				break;
			}
	
			break;
	}

	scripts\cp\zombies\zombie_analytics::func_AF77(level.wave_num,var_02);
	if(isdefined(param_01) && isalive(param_01))
	{
		param_01.var_A039 = var_02;
	}
}

//Function Number: 15
func_78EC(param_00)
{
	foreach(var_02 in level.var_47A7)
	{
		var_03 = 0;
		var_04 = var_02;
		foreach(var_06 in param_00.var_94CA)
		{
			if(scripts\common\utility::func_2286(var_04,var_06))
			{
				var_03++;
				var_04 = func_E040(var_04,var_06);
			}
		}

		if(var_03 == 3)
		{
			return var_02[0];
		}
	}

	return undefined;
}

//Function Number: 16
func_E040(param_00,param_01)
{
	var_02 = 0;
	var_03 = [];
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		if(!var_02 && param_00[var_04] == param_01)
		{
			var_02 = 1;
			continue;
		}

		var_03[var_03.size] = param_00[var_04];
	}

	return var_03;
}

//Function Number: 17
func_78F1(param_00)
{
	var_01 = [];
	for(var_02 = 1;var_02 < 99;var_02++)
	{
		var_03 = func_113C5(param_00,var_02,1);
		if(var_03 == "")
		{
			break;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 18
func_78EA(param_00)
{
	var_01 = 1;
	var_02 = 2;
	var_03 = [];
	for(var_04 = 100;var_04 <= 199;var_04++)
	{
		var_05 = undefined;
		var_05 = func_113C5(param_00,var_04,var_01);
		if(var_05 == "")
		{
			break;
		}

		var_06 = strtok(func_113C5(param_00,var_04,var_02)," ");
		var_06 = scripts\common\utility::func_229C(var_06,var_05,0);
		var_03[var_03.size] = var_06;
	}

	return var_03;
}

//Function Number: 19
func_113C5(param_00,param_01,param_02)
{
	return tablelookup(param_00,0,param_01,param_02);
}

//Function Number: 20
func_7A27(param_00)
{
	return tablelookup("scripts/cp/maps/cp_zmb/cp_zmb_crafting.csv",1,param_00,0);
}

//Function Number: 21
func_10488(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isdefined(param_00.var_D4A9))
	{
		return;
	}

	param_00 endon("death");
	param_00.var_D4A9 = 1;
	var_09 = "arcade_tooth_hit";
	param_00 playsound(var_09);
	wait(lookupsoundlength(var_09) / 1000);
	param_00.var_D4A9 = undefined;
}