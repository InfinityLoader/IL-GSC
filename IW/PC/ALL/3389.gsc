/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3389.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 75
 * Decompile Time: 22 ms
 * Timestamp: 10/27/2023 12:26:54 AM
*******************************************************************/

//Function Number: 1
func_13010(param_00,param_01)
{
	param_00.var_45C5.in_afterlife_arcade = scripts\common\utility::istrue(param_01.in_afterlife_arcade);
	param_01 playlocalsound("arcade_insert_coin_01");
	if(!scripts\common\utility::istrue(param_00.var_45C5.song_playing))
	{
		scripts\common\utility::func_5127(0.2,::scripts\common\utility::play_sound_in_space,"arcade_horserace_gunshot",param_01.origin);
		scripts\cp\_utility::playsoundatpos_safe(param_00.origin,"shooting_gall_anc_activate");
		level thread scripts\cp\zombies\arcade_game_utility::update_song_playing(param_00.var_45C5,"shooting_gall_anc_activate");
	}

	level.var_13BD4 = level.wave_num;
	if(!scripts\common\utility::istrue(param_01.in_afterlife_arcade))
	{
		scripts\cp\zombies\zombie_analytics::func_AF8C("shooting_gallery",param_01);
	}
	else
	{
		scripts\cp\zombies\zombie_analytics::func_AF8C("shooting_gallery_afterlife",param_01);
	}

	func_5581(param_00);
	if(!func_9CBE(param_00.var_45C5))
	{
		func_E210(param_00.var_45C5);
	}

	func_1771(param_00.var_45C5,param_01);
	func_CE0B(param_00,param_01);
	if(!func_9CBE(param_00.var_45C5))
	{
		func_10D1E(param_00.var_45C5);
	}
}

//Function Number: 2
func_CE0B(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_01.in_afterlife_arcade))
	{
		param_00 notify("machine_used");
	}

	param_01.var_D7AB = param_01 scripts\cp\zombies\arcade_game_utility::func_EB76(param_01);
	var_02 = param_00.var_394;
	param_01.var_7654 = var_02;
	param_01 giveweapon(var_02);
	param_01 switchtoweapon(var_02);
	param_01 scripts\common\utility::func_1C76(0);
	param_01 scripts\common\utility::func_1C6E(0);
	param_01 scripts\cp\powers\coop_powers::func_D728();
	param_01 allowmelee(0);
	param_01 func_FEBF(param_01);
	param_01 func_1298F(param_00.var_45C5,param_01);
	param_01 func_553F(param_01);
	param_01 func_E225(param_01);
	param_01 thread func_FEB3(param_01);
	param_01 thread func_FEBC(param_00.var_45C5,param_00,param_01,30);
	param_01 thread func_FEBB(param_00,param_01);
}

//Function Number: 3
func_973E()
{
	func_9741("shooting_gallery");
	func_9740();
	func_9690();
	level thread func_5555(2);
}

//Function Number: 4
func_94DA()
{
	func_9741("shooting_gallery_afterlife");
}

//Function Number: 5
func_9741(param_00)
{
	var_01 = scripts\common\utility::getstructarray(param_00,"script_noteworthy");
	foreach(var_04, var_03 in var_01)
	{
		var_03 thread func_FA41(var_04);
	}
}

//Function Number: 6
func_FA41(param_00)
{
	self.var_45C5 = scripts\common\utility::getstructarray(self.target,"targetname")[0];
	self.var_13C27 = self.origin;
	self.var_13BFE = self.angles;
	func_CC05(self,param_00);
	var_01 = scripts\common\utility::istrue(self.var_E1B9) && isdefined(self.var_D71C);
	for(;;)
	{
		var_02 = "power_on";
		if(var_01)
		{
			var_02 = level scripts\common\utility::waittill_any_return_no_endon_death_3("power_on",self.var_D71C + " power_on","power_off");
			if(var_02 != "power_off")
			{
				self.var_D776 = 1;
				func_1298B(self.var_45C5);
			}
			else
			{
				self.var_D776 = 0;
				func_12967(self.var_45C5);
			}
		}

		if(!var_01)
		{
			func_1298B(self.var_45C5);
			break;
		}

		wait(0.25);
	}
}

//Function Number: 7
func_9690()
{
	level.var_FEB7 = scripts\common\utility::getstructarray("shooting_gallery_moving_target_path","script_noteworthy");
}

//Function Number: 8
func_10D1E(param_00)
{
	level thread func_10D1F(param_00);
}

//Function Number: 9
func_10D1F(param_00)
{
	param_00 endon("shooting_gallery_game_over");
	param_00 thread func_C927(param_00);
	func_F59C(param_00,1);
	param_00 thread func_10D20(param_00);
	func_96A0(param_00);
	func_12978(param_00);
	thread scripts\common\utility::play_sound_in_space("shooting_gallery_sign_up_start",param_00.origin);
	for(;;)
	{
		var_01 = func_7CE1(param_00);
		switch(var_01)
		{
			case "alien_king":
				param_00 thread func_15EC(param_00,func_784F(param_00),func_77F4(),10,2,55);
				break;
	
			case "alien":
				param_00 thread func_15EC(param_00,func_784F(param_00),func_77F7(),5,4,55);
				break;
	
			case "hostage":
				var_02 = func_7A10();
				var_03 = func_7A11(var_02);
				var_04 = func_7A12(var_02);
				param_00 thread func_15EC(param_00,func_7849(param_00),var_02,var_03,4,var_04);
				break;
	
			case "ufo":
				func_4DCF(param_00);
				func_D7E9();
				func_15D5(param_00);
				break;
		}

		if(var_01 == "ufo")
		{
			param_00 waittill("target_sign_deactivated");
			continue;
		}

		if(func_7B34(param_00) < 3)
		{
			param_00 scripts\common\utility::waittill_any_timeout_1(1.5,"target_sign_deactivated");
			continue;
		}

		param_00 waittill("target_sign_deactivated");
	}
}

//Function Number: 10
func_15EC(param_00,param_01,param_02,param_03,param_04,param_05)
{
	func_12DF7(param_00,1);
	var_06 = func_107E9(param_01,param_02);
	func_BC7A(var_06,param_05);
	var_07 = scripts\cp\_utility::func_1372D(var_06,"movedone",param_00,"shooting_gallery_game_over",param_00,"shooting_gallery_end_stationary");
	if(var_07 == "movedone")
	{
		func_61E9(var_06);
		var_06 thread func_FEC0(param_00,var_06,param_03);
		scripts\cp\_utility::func_1372C(param_04,var_06,"shooting_gallery_sign_hit",param_00,"shooting_gallery_game_over",param_00,"shooting_gallery_end_stationary");
		func_5515(var_06);
	}

	func_BC79(var_06,param_05);
	var_06 delete();
	func_12DF7(param_00,-1);
	param_00 notify("target_sign_deactivated");
}

//Function Number: 11
func_107E9(param_00,param_01)
{
	var_02 = spawn("script_model",param_00.origin);
	var_02.angles = param_00.angles;
	var_02 setmodel(param_01);
	return var_02;
}

//Function Number: 12
func_BC7A(param_00,param_01)
{
	param_00 moveto(param_00.origin + (0,0,param_01),0.2,0.2,0);
	param_00 playsound("shooting_gallery_sign_up");
}

//Function Number: 13
func_15D5(param_00)
{
	var_01 = param_00.var_FEB8[randomint(param_00.var_FEB8.size)];
	var_01 thread func_BD47(param_00,var_01);
}

//Function Number: 14
func_BD47(param_00,param_01)
{
	func_12DF7(param_00,1);
	var_02 = func_10775(param_01);
	var_02 thread func_FEB5(param_00,var_02);
	var_02 thread func_FEB6(param_00,var_02);
}

//Function Number: 15
func_9F4E(param_00)
{
	if(param_00 == "iw7_shootgallery_zm_red" || param_00 == "iw7_shootgallery_zm_blue" || param_00 == "iw7_shootgallery_zm_green" || param_00 == "iw7_shootgallery_zm_yellow")
	{
		return 1;
	}

	return 0;
}

//Function Number: 16
func_FEB5(param_00,param_01)
{
	param_01 endon("death");
	func_61E9(param_01);
	for(;;)
	{
		param_01 waittill("damage",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
		param_01 playsound("shooting_gallery_moving_sign_hit");
		param_01.health = 999999;
		if(func_9F4E(var_0B))
		{
			func_5515(param_01);
			func_56D0(var_03,25,param_00);
			func_12D92(var_03,25);
			param_01 notify("moving_target_hit");
			var_03 notify("moving_target_hit_notify");
			break;
		}
	}
}

//Function Number: 17
func_FEC0(param_00,param_01,param_02)
{
	param_00 endon("shooting_gallery_game_over");
	for(;;)
	{
		param_01 waittill("damage",var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C);
		param_01.health = 999999;
		if(func_9F4E(var_0C))
		{
			break;
		}
	}

	param_01 playsound("shooting_gallery_sign_hit");
	func_56D0(var_04,param_02,param_00);
	func_12D92(var_04,param_02);
	param_01 notify("shooting_gallery_sign_hit");
}

//Function Number: 18
func_FEB6(param_00,param_01)
{
	param_01 notify("moving_target_move_think");
	param_01 endon("moving_target_move_think");
	var_02 = scripts\common\utility::func_782F(param_01.origin,level.var_FEB7);
	var_03 = var_02[0];
	for(;;)
	{
		param_01 moveto(var_03.origin,0.6);
		var_04 = param_01 scripts\cp\_utility::func_1372D(param_01,"movedone",param_01,"moving_target_hit",param_00,"shooting_gallery_game_over");
		if(var_04 == "movedone")
		{
			if(var_02[0] != var_03 && isdefined(var_03.var_EE79) && var_03.var_EE79 == "shooting_gallery_path_end")
			{
				break;
			}

			var_03 = scripts\common\utility::getstructarray(var_03.target,"targetname")[0];
			continue;
		}

		break;
	}

	param_01 moveto(var_03.origin + (0,0,150),0.6);
	param_01 waittill("movedone");
	param_01 delete();
	func_12DF7(param_00,-1);
	param_00 notify("target_sign_deactivated");
}

//Function Number: 19
func_BC79(param_00,param_01)
{
	param_00 moveto(param_00.origin - (0,0,param_01),0.2,0.2,0);
	param_00 waittill("movedone");
}

//Function Number: 20
func_61E9(param_00)
{
	param_00.health = 999999;
	param_00 setcandamage(1);
}

//Function Number: 21
func_5515(param_00)
{
	param_00 setcandamage(0);
}

//Function Number: 22
func_C927(param_00)
{
	level endon("game_ended");
	param_00 endon("shooting_gallery_game_over");
	for(;;)
	{
		param_00 waittill("shooting_gallery_player_left",var_01);
		func_E027(param_00,var_01);
		if(func_7B3A(param_00) == 0)
		{
			func_10173(param_00);
		}
	}
}

//Function Number: 23
func_6961(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		param_02 takeweapon(param_02.var_7654);
		param_02.var_7654 = undefined;
		param_02 scripts\common\utility::func_1C76(1);
		if(!param_02 scripts\common\utility::func_9FBE())
		{
			param_02 scripts\common\utility::func_1C6E(1);
		}

		param_02 allowmelee(1);
		param_02 scripts\cp\powers\coop_powers::func_D72E();
		param_02 scripts\cp\zombies\arcade_game_utility::func_82F5(param_02);
		param_02 func_1296C(param_00,param_02);
		param_02 func_6208(param_02);
		param_02 func_FEBF(param_02);
		param_02 func_832F(param_00,param_02);
	}

	if(!param_01.var_45C5.in_afterlife_arcade)
	{
		level notify("gallery_used");
	}

	func_6237(param_01);
	param_00 notify("shooting_gallery_player_left",param_02);
	param_02 notify("arcade_game_over_for_player");
}

//Function Number: 24
func_FEB3(param_00)
{
	param_00 endon("arcade_game_over_for_player");
	param_00 endon("spawned");
	var_01 = 30;
	param_00 setclientomnvar("zombie_arcade_game_shot_remaining",var_01);
	for(;;)
	{
		param_00 waittill("grenade_fire");
		var_01--;
		param_00 givemaxammo(param_00.var_7654);
		param_00 setweaponammoclip(param_00.var_7654,weaponclipsize(param_00.var_7654));
		param_00 setclientomnvar("zombie_arcade_game_shot_remaining",var_01);
		if(var_01 <= 0)
		{
			break;
		}
	}

	param_00 notify("no_shot_left");
}

//Function Number: 25
func_FEBF(param_00)
{
	param_00 setclientomnvar("zombie_arcade_game_time",-1);
	param_00 setclientomnvar("zombie_arcade_game_ticket_earned",0);
	param_00 setclientomnvar("zombie_arcade_game_shot_remaining",0);
}

//Function Number: 26
func_1298F(param_00,param_01)
{
	param_01 setclientomnvar(param_00.var_EE79,1);
}

//Function Number: 27
func_1296C(param_00,param_01)
{
	param_01 setclientomnvar(param_00.var_EE79,0);
}

//Function Number: 28
func_12D92(param_00,param_01)
{
	param_00.var_FEBA = int(max(0,param_00.var_FEBA + param_01));
	param_00 setclientomnvar("zombie_arcade_game_ticket_earned",param_00.var_FEBA);
}

//Function Number: 29
func_E225(param_00)
{
	param_00.var_FEBA = 0;
}

//Function Number: 30
func_553F(param_00)
{
	param_00 scripts\cp\_utility::func_1C5D(0);
}

//Function Number: 31
func_6208(param_00)
{
	if(!param_00 scripts\cp\_utility::func_213E())
	{
		param_00 scripts\cp\_utility::func_1C5D(1);
	}
}

//Function Number: 32
func_9740()
{
	var_00 = scripts\common\utility::getstructarray("shooting_gallery_controlling_struct","script_noteworthy");
	foreach(var_02 in var_00)
	{
		func_973F(var_02);
	}
}

//Function Number: 33
func_973F(param_00)
{
	func_F59C(param_00,0);
	param_00.var_FEC1 = [];
	param_00.var_FEC2 = [];
	param_00.var_FEB2 = [];
	param_00.var_FEB8 = [];
	param_00.var_FEBD = undefined;
	param_00.var_FEB0 = undefined;
	var_01 = scripts\common\utility::getstructarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		switch(var_03.script_noteworthy)
		{
			case "shooting_gallery_target_row_1":
				param_00.var_FEC1[param_00.var_FEC1.size] = var_03;
				break;

			case "shooting_gallery_target_row_2":
				param_00.var_FEC2[param_00.var_FEC2.size] = var_03;
				break;

			case "shooting_gallery_hostage":
				param_00.var_FEB2[param_00.var_FEB2.size] = var_03;
				break;

			case "shooting_gallery_moving_target":
				param_00.var_FEB8[param_00.var_FEB8.size] = var_03;
				break;
		}
	}

	var_05 = param_00.var_EF20;
	if(isdefined(var_05))
	{
		var_05 = strtok(var_05," ");
		foreach(var_07 in var_05)
		{
			if(issubstr(var_07,"power_on"))
			{
				param_00.var_FEBE = var_07;
			}

			if(issubstr(var_07,"activation"))
			{
				param_00.var_FEB1 = var_07;
			}
		}
	}

	func_F5E4(param_00);
	func_F5E3(param_00);
	func_F5F2(param_00);
}

//Function Number: 34
func_F5E4(param_00)
{
	param_00.var_26A1 = scripts\common\utility::array_combine(param_00.var_FEC1,param_00.var_FEC2);
	param_00.var_26A1 = scripts\common\utility::array_randomize(param_00.var_26A1);
}

//Function Number: 35
func_F5E3(param_00)
{
	param_00.var_269E = scripts\common\utility::array_randomize(param_00.var_FEB2);
}

//Function Number: 36
func_F5F2(param_00)
{
	var_01 = [];
	var_02 = ["alien","alien","alien","alien_king","hostage"];
	for(var_03 = 0;var_03 < 3;var_03++)
	{
		var_01 = scripts\common\utility::array_combine(var_01,scripts\common\utility::array_randomize(var_02));
	}

	var_01[var_01.size] = "ufo";
	param_00.var_1154F = var_01;
}

//Function Number: 37
func_784F(param_00)
{
	if(param_00.var_26A1.size == 0)
	{
		func_F5E4(param_00);
	}

	var_01 = param_00.var_26A1[0];
	param_00.var_26A1 = scripts\common\utility::func_22A9(param_00.var_26A1,var_01);
	return var_01;
}

//Function Number: 38
func_7849(param_00)
{
	if(param_00.var_269E.size == 0)
	{
		func_F5E3(param_00);
	}

	var_01 = param_00.var_269E[0];
	param_00.var_269E = scripts\common\utility::func_22A9(param_00.var_269E,var_01);
	return var_01;
}

//Function Number: 39
func_7CE1(param_00)
{
	if(param_00.var_1154F.size == 0)
	{
		func_F5F2(param_00);
	}

	var_01 = param_00.var_1154F[0];
	param_00.var_1154F = scripts\cp\_utility::func_22B0(param_00.var_1154F,0,0);
	return var_01;
}

//Function Number: 40
func_F59C(param_00,param_01)
{
	param_00.var_FEB4 = param_01;
}

//Function Number: 41
func_9CBE(param_00)
{
	return scripts\common\utility::istrue(param_00.var_FEB4);
}

//Function Number: 42
func_FEBC(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	param_02 endon("arcade_game_over_for_player");
	param_02 thread func_12E3D(param_02,param_03);
	var_04 = param_02 scripts\common\utility::waittill_any_timeout_1(param_03,"disconnect","last_stand","shooting_gallery_player_gets_away","spawned","no_shot_left");
	func_6961(param_00,param_01,param_02);
}

//Function Number: 43
func_12E3D(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("arcade_game_over_for_player");
	for(var_02 = param_01;var_02 >= 0;var_02--)
	{
		param_00 setclientomnvar("zombie_arcade_game_time",var_02);
		wait(1);
	}
}

//Function Number: 44
func_FEBB(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("arcade_game_over_for_player");
	param_01 endon("spawned");
	var_02 = 10000;
	for(;;)
	{
		wait(0.1);
		if(distancesquared(param_01.origin,param_00.origin) > var_02)
		{
			wait(2);
			if(distancesquared(self.origin,param_00.origin) > var_02)
			{
				param_01 notify("shooting_gallery_player_gets_away");
			}
		}
	}
}

//Function Number: 45
func_1771(param_00,param_01)
{
	param_00.var_163B = scripts\common\utility::array_add(param_00.var_163B,param_01);
}

//Function Number: 46
func_E027(param_00,param_01)
{
	param_00.var_163B = scripts\common\utility::func_22A9(param_00.var_163B,param_01);
}

//Function Number: 47
func_7B3A(param_00)
{
	return param_00.var_163B.size;
}

//Function Number: 48
func_E210(param_00)
{
	param_00.var_163B = [];
}

//Function Number: 49
func_10173(param_00)
{
	func_F59C(param_00,0);
	param_00 thread func_1103E(param_00);
	func_12947(param_00);
	param_00 notify("shooting_gallery_game_over");
}

//Function Number: 50
func_77F4()
{
	return "zmb_target_alien01";
}

//Function Number: 51
func_77F7()
{
	var_00 = ["zmb_target_alien02","zmb_target_alien03"];
	return var_00[randomint(var_00.size)];
}

//Function Number: 52
func_7A10()
{
	var_00 = ["zmb_target_civilian01","zmb_target_civilian02","zmb_target_civilian03","zmb_civilian_target_01","zmb_civilian_target_02","zmb_civilian_target_03","zmb_civilian_target_04"];
	return var_00[randomint(var_00.size)];
}

//Function Number: 53
func_7A11(param_00)
{
	switch(param_00)
	{
		case "zmb_target_civilian03":
		case "zmb_target_civilian02":
		case "zmb_target_civilian01":
			return -5;

		case "zmb_civilian_target_04":
		case "zmb_civilian_target_03":
		case "zmb_civilian_target_01":
			return -10;

		case "zmb_civilian_target_02":
			return -15;
	}
}

//Function Number: 54
func_7A12(param_00)
{
	switch(param_00)
	{
		case "zmb_target_civilian03":
		case "zmb_target_civilian02":
		case "zmb_target_civilian01":
			return 40;

		case "zmb_civilian_target_04":
		case "zmb_civilian_target_03":
		case "zmb_civilian_target_02":
		case "zmb_civilian_target_01":
			return 40;
	}
}

//Function Number: 55
func_10775(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	var_01.angles = param_00.angles;
	var_01 setmodel("zmb_target_ship01");
	return var_01;
}

//Function Number: 56
func_56D0(param_00,param_01,param_02)
{
	if(!isdefined(param_02.var_FEC3))
	{
		param_02.var_FEC3 = spawn("script_origin",param_02.origin);
	}

	if(param_01 > 0)
	{
		param_00 iprintlnbold("^3+" + param_01);
		param_02.var_FEC3 playsound("zmb_shooting_gal_bell");
		scripts\cp\_utility::playsoundatpos_safe(param_02.origin,"shooting_gall_anc_hit_target");
	}

	if(param_01 < 0)
	{
		param_00 iprintlnbold("^6" + param_01);
		param_02.var_FEC3 playsound("zmb_shooting_gal_buzz");
	}
}

//Function Number: 57
func_10D20(param_00)
{
	wait(1);
	if(!isdefined(param_00.var_FEB9))
	{
		param_00.var_FEB9 = spawn("script_origin",param_00.origin);
	}
}

//Function Number: 58
func_1103E(param_00)
{
	wait(1);
	if(isdefined(param_00.var_FEB9))
	{
		param_00.var_FEB9 stoploopsound("mus_arcade_alienattack");
	}
}

//Function Number: 59
func_832F(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_00.song_playing))
	{
		if(param_01.var_FEBA <= 0)
		{
			playsoundatpos(param_00.origin,"shooting_gall_anc_failure");
			level thread scripts\cp\zombies\arcade_game_utility::update_song_playing(param_00,"shooting_gall_anc_failure");
		}
		else if(soundexists("shooting_gall_anc_success"))
		{
			playsoundatpos(param_00.origin,"shooting_gall_anc_success");
			level thread scripts\cp\zombies\arcade_game_utility::update_song_playing(param_00,"shooting_gall_anc_success");
		}
	}

	if(param_00.in_afterlife_arcade)
	{
		if(scripts\common\utility::istrue(param_01.in_afterlife_arcade))
		{
			param_01 scripts\cp\zombies\zombie_afterlife_arcade::func_8334(param_01,param_01.var_FEBA);
			scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_01,level.var_13BD4,"shooting_gallery_afterlife",1,param_01.var_FEBA,param_01.pers["timesPerWave"].var_11930[level.var_13BD4]["shooting_gallery_afterlife"]);
			return;
		}

		return;
	}

	param_01 scripts\cp\zombies\arcade_game_utility::func_8317(param_01,param_01.var_FEBA);
	scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_01,level.var_13BD4,"shooting_gallery",0,param_01.var_FEBA,param_01.pers["timesPerWave"].var_11930[level.var_13BD4]["shooting_gallery"]);
}

//Function Number: 60
func_5581(param_00)
{
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	func_E0AB(param_00);
}

//Function Number: 61
func_6237(param_00)
{
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
	func_CC05(param_00);
}

//Function Number: 62
func_CC05(param_00,param_01)
{
	param_00.var_13C2C = spawn("script_model",param_00.var_13C27);
	var_02 = ["weapon_shootinggallery_wm_red","weapon_shootinggallery_wm_blue","weapon_shootinggallery_wm_green","weapon_shootinggallery_wm_yellow"];
	var_03 = ["iw7_shootgallery_zm_red","iw7_shootgallery_zm_blue","iw7_shootgallery_zm_green","iw7_shootgallery_zm_yellow"];
	if(!isdefined(param_00.model))
	{
		param_00.model = var_02[param_01];
	}

	if(!isdefined(param_00.var_394))
	{
		param_00.var_394 = var_03[param_01];
	}

	param_00.var_13C2C setmodel(param_00.model);
	param_00.var_13C2C.angles = param_00.var_13BFE;
}

//Function Number: 63
func_E0AB(param_00)
{
	param_00.var_13C2C delete();
}

//Function Number: 64
func_7B34(param_00)
{
	return param_00.var_C1D6;
}

//Function Number: 65
func_96A0(param_00)
{
	param_00.var_C1D6 = 0;
}

//Function Number: 66
func_12DF7(param_00,param_01)
{
	param_00.var_C1D6 = param_00.var_C1D6 + param_01;
}

//Function Number: 67
func_4DCF(param_00)
{
	param_00 notify("shooting_gallery_end_stationary");
}

//Function Number: 68
func_D7E9()
{
	wait(0.6);
}

//Function Number: 69
func_12978(param_00)
{
	if(!isdefined(param_00.var_FEB1))
	{
		return;
	}

	func_F590(param_00.var_FEB1,"shooting_gallery_light","gallery_light_on");
}

//Function Number: 70
func_12947(param_00)
{
	if(!isdefined(param_00.var_FEB1))
	{
		return;
	}

	func_F590(param_00.var_FEB1,"shooting_gallery_light","gallery_light_off");
}

//Function Number: 71
func_1298B(param_00)
{
	if(!isdefined(param_00.var_FEBE))
	{
		return;
	}

	func_F590(param_00.var_FEBE,"shooting_gallery_light","gallery_light_on");
}

//Function Number: 72
func_12967(param_00)
{
	if(!isdefined(param_00.var_FEBE))
	{
		return;
	}

	func_F590(param_00.var_FEBE,"shooting_gallery_light","gallery_light_off");
}

//Function Number: 73
func_F590(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00,"targetname");
	foreach(var_05 in var_03)
	{
		var_05 setscriptablepartstate(param_01,param_02);
	}
}

//Function Number: 74
func_5555(param_00)
{
	level.var_210D = 0;
	for(;;)
	{
		level waittill("gallery_used");
		level.var_210D++;
		if(level.var_210D == param_00)
		{
			var_01 = scripts\common\utility::getstructarray("shooting_gallery","script_noteworthy");
			foreach(var_03 in var_01)
			{
				var_03.out_of_order = 1;
			}

			level scripts\common\utility::waittill_any_3("regular_wave_starting","event_wave_starting");
			foreach(var_03 in var_01)
			{
				var_03.out_of_order = 0;
			}

			foreach(var_08 in level.players)
			{
				foreach(var_03 in var_01)
				{
					if(isdefined(var_08.var_A8D3) && var_08.var_A8D3 == var_03)
					{
						var_08 thread scripts\cp\_interaction::func_DE6E();
					}
				}
			}

			level.var_210D = 0;
		}
	}
}

//Function Number: 75
register_interactions()
{
	level.interaction_hintstrings["shooting_gallery_afterlife"] = &"CP_ZOMBIE_AFTERLIFE_ARCADE_PLAY_GAME";
	scripts\cp\_interaction::func_DEBB("shooting_gallery","arcade_game",undefined,::scripts\cp\zombies\arcade_game_utility::func_2110,::func_13010,0,1,::func_973E);
	scripts\cp\_interaction::func_DEBB("shooting_gallery_afterlife","afterlife_game",undefined,undefined,::func_13010,0,0,::func_94DA);
}