/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3386.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 19 ms
 * Timestamp: 10/27/2023 12:26:53 AM
*******************************************************************/

//Function Number: 1
func_94F0()
{
	scripts\common\utility::flag_init("arcade_race_pregame");
	scripts\common\utility::flag_init("afterlife_race_pregame");
	var_00 = scripts\common\utility::getstructarray("game_race","script_noteworthy");
	var_01 = 2;
	var_02 = 3;
	foreach(var_04 in var_00)
	{
		var_04 thread func_9701(var_00);
	}

	level thread func_5555(var_01,var_02);
	level.var_DBB4 = ["iw7_horseracepistol_zm_blue","iw7_horseracepistol_zm_yellow","iw7_horseracepistol_zm_red","iw7_horseracepistol_zm_green"];
}

//Function Number: 2
func_9701(param_00)
{
	var_01 = getentarray(self.target,"targetname");
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.script_noteworthy) && var_03.script_noteworthy == "horse")
		{
			self.var_9098 = var_03;
			continue;
		}

		if(var_03.classname == "script_model")
		{
			self.var_870F = var_03;
			continue;
		}

		if(var_03.classname == "trigger_damage")
		{
			self.var_325F = var_03;
			continue;
		}

		if(scripts\common\utility::string_starts_with(var_03.classname,"scriptable"))
		{
			self.var_7542 = var_03;
		}
	}

	self.var_9098.var_C38F = self.var_9098.origin;
	self.var_870F.var_C38F = self.var_870F.origin;
	self.var_870F.var_C378 = self.var_870F.angles;
	if(scripts\cp\_interaction::func_9A3A(self) && !isdefined(level.var_DBB8))
	{
		thread func_DBB7(param_00);
	}
}

//Function Number: 3
func_DBB7(param_00)
{
	level.var_DBB8 = 1;
	for(;;)
	{
		var_01 = level scripts\common\utility::waittill_any_return_no_endon_death_3("power_on",self.var_D71C + " power_on","power_off");
		if(var_01 != "power_off")
		{
			setomnvar("zombie_arcade_race_power",1);
			foreach(var_03 in param_00)
			{
				var_03.var_D776 = 1;
			}

			var_05 = getent("arcade_zz_neon_light","targetname");
			var_05 setmodel("zmb_theater_sign_05");
			continue;
		}

		setomnvar("zombie_arcade_race_power",0);
		foreach(var_03 in param_00)
		{
			var_03.var_D776 = 0;
		}
	}
}

//Function Number: 4
func_13003(param_00,param_01)
{
	if(param_01 getstance() != "stand")
	{
		param_01 scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_MUST_BE_STANDING");
		return;
	}

	param_01 notify("cancel_sentry");
	param_01 notify("cancel_medusa");
	param_01 notify("cancel_trap");
	param_01 notify("cancel_boombox");
	param_01 notify("cancel_revocator");
	param_01 notify("cancel_ims");
	param_01 notify("cancel_gascan");
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	if(!scripts\common\utility::istrue(param_01.in_afterlife_arcade))
	{
		while(param_01 getcurrentprimaryweapon() == "none" || param_01 method_81C2())
		{
			wait(0.1);
		}
	}

	param_01 notify("cancel_sentry");
	param_01 notify("cancel_medusa");
	param_01 notify("cancel_trap");
	param_01 notify("cancel_boombox");
	param_01 notify("cancel_revocator");
	param_01 notify("cancel_ims");
	param_01 notify("cancel_gascan");
	level.var_13BD4 = level.wave_num;
	param_01 playlocalsound("arcade_insert_coin_02");
	scripts\common\utility::func_5127(0.2,::scripts\common\utility::play_sound_in_space,"arcade_horserace_gunshot",param_01.origin);
	if(param_00.var_EE04 == "arcade")
	{
		if(!scripts\common\utility::flag("arcade_race_pregame"))
		{
			scripts\common\utility::flag_set("arcade_race_pregame");
			level notify("race_used");
			level thread func_DBB2("arcade",param_00);
		}

		level thread func_D24B(param_01,param_00,"arcade");
		scripts\cp\zombies\zombie_analytics::func_AF8C("game_race",param_01);
		return;
	}

	if(param_00.var_EE04 == "afterlife")
	{
		if(!scripts\common\utility::flag("afterlife_race_pregame"))
		{
			scripts\common\utility::flag_set("afterlife_race_pregame");
			level thread func_DBB2("afterlife",param_00);
		}

		level thread func_D24B(param_01,param_00,"afterlife");
		scripts\cp\zombies\zombie_analytics::func_AF8C("game_race",param_01);
	}
}

//Function Number: 5
func_E1F4(param_00,param_01)
{
	var_02 = scripts\common\utility::getstructarray("game_race","script_noteworthy");
	var_03 = [];
	foreach(var_05 in var_02)
	{
		if(var_05.var_EE04 == param_00)
		{
			var_03[var_03.size] = var_05;
		}
	}

	foreach(var_05 in var_03)
	{
		if(param_00 == "afterlife")
		{
			var_05.var_9098 moveto(var_05.var_9098.var_C38F + (-0.25,0,0),1);
			continue;
		}

		var_05.var_9098 moveto(var_05.var_9098.var_C38F + (0,0.25,0),1);
	}

	if(param_01.origin != param_01.var_C38F)
	{
		thread scripts\common\utility::play_sound_in_space("arcade_horserace_reset",param_01.origin);
	}

	param_01 moveto(param_01.var_C38F,1);
}

//Function Number: 6
func_DBB2(param_00,param_01)
{
	var_02 = getentarray("pace_horse","script_noteworthy");
	var_03 = scripts\common\utility::getclosest(param_01.origin,var_02,500);
	if(!isdefined(var_03.var_C38F))
	{
		var_03.var_C38F = var_03.origin;
	}

	level thread func_E1F4(param_00,var_03);
	wait(1);
	level thread func_E1EE(param_00);
	for(var_04 = 3;var_04 > 0;var_04--)
	{
		setomnvar("zombie_" + param_00 + "_race_countdown",var_04);
		wait(1);
	}

	setomnvar("zombie_" + param_00 + "_race_countdown",-1);
	var_05 = scripts\common\utility::getstructarray("game_race","script_noteworthy");
	foreach(var_07 in var_05)
	{
		if(var_07.var_EE04 != param_00)
		{
			continue;
		}

		scripts\cp\_interaction::remove_from_current_interaction_list(var_07);
	}

	thread func_FBEB(param_01);
	level notify(param_00 + "race_starting");
	switch(var_03.var_EE79)
	{
		case "x":
			var_03 movex(120,10);
			break;

		case "-x":
			var_03 movex(-120,10);
			break;

		case "y":
			var_03 movey(120,10);
			break;

		case "-y":
			var_03 movey(-120,10);
			break;
	}

	wait(1);
	setomnvar("zombie_" + param_00 + "_race_countdown",0);
	wait(9.1);
	level notify(param_00 + "_pace_horse_finished");
	scripts\common\utility::func_6E2A(param_00 + "_race_pregame");
	thread func_FBEA(param_01);
	wait(3);
	var_05 = scripts\common\utility::getstructarray("game_race","script_noteworthy");
	foreach(var_07 in var_05)
	{
		if(var_07.var_EE04 != param_00)
		{
			continue;
		}

		var_07.var_870F show();
		scripts\cp\_interaction::add_to_current_interaction_list(var_07);
	}
}

//Function Number: 7
func_E1EE(param_00)
{
	var_01 = scripts\common\utility::getstructarray("game_race","script_noteworthy");
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(var_04.var_EE04 == param_00)
		{
			var_02[var_02.size] = var_04;
		}
	}

	foreach(var_04 in var_02)
	{
		var_04.var_7542 setscriptablepartstate("game_light","off");
		var_04.var_7542 setscriptablepartstate("light_fx","off");
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 8
func_D24B(param_00,param_01,param_02)
{
	var_03 = undefined;
	param_00.var_D7AB = param_00 scripts\cp\zombies\arcade_game_utility::func_EB76(param_00);
	param_00 setclientomnvar("zombie_arcade_game_time",1);
	param_00 setclientomnvar("zombie_zz_widget",1);
	scripts\common\utility::func_136F7();
	param_01.var_278 = 0;
	param_01.var_870F hide();
	var_04 = strtok(param_01.var_870F.model,"_");
	var_05 = var_04[var_04.size - 1];
	foreach(var_07 in level.var_DBB4)
	{
		var_08 = strtok(var_07,"_");
		if(var_08[var_08.size - 1] == var_05)
		{
			var_03 = var_07;
			break;
		}
	}

	param_00 scripts\cp\zombies\arcade_game_utility::func_11447();
	param_00 giveweapon(var_03);
	param_00 switchtoweapon(var_03);
	param_00 scripts\common\utility::func_1C76(0);
	param_00 scripts\common\utility::func_1C6E(0);
	param_00 thread func_DBB5(param_00,param_01,var_03,::func_E219);
	param_00 thread func_DBB6(param_00,param_01,var_03,::func_E219);
	param_00 scripts\cp\_utility::func_1C5D(0);
	param_00 thread func_DBB1(param_01,param_00,param_02,var_03);
	param_00 thread func_D2D9(param_01,param_02,var_03);
	param_00 thread func_D047(param_01,param_02,var_03);
}

//Function Number: 9
func_D2D9(param_00,param_01,param_02)
{
	self endon("too_far_from_game");
	level waittill(param_01 + "race_starting");
	param_00.var_325F setcandamage(1);
	param_00.var_325F.health = 999999;
	var_03 = gettime();
	self.var_4B87 = param_00;
	level endon(param_01 + "_pace_horse_finished");
	if(isdefined(level.start_zombie_zoom_func))
	{
		param_00 thread [[ level.start_zombie_zoom_func ]](param_00,self);
	}

	for(;;)
	{
		param_00.var_325F waittill("damage",var_04,var_05);
		param_00.var_325F.health = 999999;
		if(var_05 != self)
		{
			continue;
		}

		var_06 = var_05 getcurrentweapon();
		if(var_06 != param_02)
		{
			continue;
		}

		switch(param_00.var_9098.var_EE79)
		{
			case "x":
				param_00.var_9098 movex(2.2,0.1);
				break;
	
			case "-x":
				param_00.var_9098 movex(-2.2,0.1);
				break;
	
			case "y":
				param_00.var_9098 movey(2.2,0.1);
				break;
	
			case "-y":
				param_00.var_9098 movey(-2.2,0.1);
				break;
		}

		if(distance2d(param_00.var_9098.var_C38F,param_00.var_9098.origin) + 2 >= 120)
		{
			param_00.var_7542 setscriptablepartstate("game_light","on");
			param_00.var_7542 setscriptablepartstate("light_fx","on");
			var_07 = param_01 == "afterlife";
			if(!var_07)
			{
				level notify("update_arcade_game_performance","zombie_zoom",gettime() - var_03);
			}

			func_830E(self,var_07,100);
			return;
		}
	}
}

//Function Number: 10
func_D047(param_00,param_01,param_02)
{
	self endon("arcade_game_over_for_player");
	self endon("last_stand");
	self endon("spawned");
	self endon("disconnect");
	level waittill(param_01 + "_pace_horse_finished");
	if(!scripts\cp\_utility::func_213E())
	{
		scripts\cp\_utility::func_1C5D(1);
	}

	self setclientomnvar("zombie_arcade_game_time",-1);
	self setclientomnvar("zombie_zz_widget",0);
	self takeweapon(param_02);
	if(!scripts\common\utility::func_9FBE())
	{
		scripts\common\utility::func_1C6E(1);
	}

	scripts\common\utility::func_1C76(1);
	scripts\cp\zombies\arcade_game_utility::func_82F5(self);
	scripts\cp\zombies\arcade_game_utility::func_E2CB();
	self notify("arcade_game_over_for_player");
}

//Function Number: 11
func_DBB1(param_00,param_01,param_02,param_03)
{
	level endon(param_02 + "_pace_horse_finished");
	param_01 endon("arcade_game_over_for_player");
	param_01 endon("disconnect");
	for(;;)
	{
		param_01 setweaponammoclip(param_03,10);
		wait(0.1);
	}
}

//Function Number: 12
func_E219(param_00,param_01)
{
	param_01 setclientomnvar("zombie_arcade_game_time",-1);
	param_01 setclientomnvar("zombie_zz_widget",0);
	wait(3);
	if(!param_01 scripts\cp\_utility::func_213E())
	{
		param_01 scripts\cp\_utility::func_1C5D(1);
	}
}

//Function Number: 13
func_FF2B(param_00,param_01)
{
	if(param_01 && !scripts\common\utility::istrue(param_00.in_afterlife_arcade))
	{
		return 0;
	}

	return 1;
}

//Function Number: 14
func_830E(param_00,param_01,param_02)
{
	if(param_01)
	{
		if(scripts\common\utility::istrue(param_00.in_afterlife_arcade))
		{
			scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_00,level.var_13BD4,self.var_4B87.name,1,param_02,param_00.pers["timesPerWave"].var_11930[level.var_13BD4][self.var_4B87.name]);
			param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_8334(param_00,param_02);
			return;
		}

		return;
	}

	scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_00,level.var_13BD4,self.var_4B87.name,0,param_02,param_00.pers["timesPerWave"].var_11930[level.var_13BD4][self.var_4B87.name]);
	param_00 scripts\cp\zombies\arcade_game_utility::func_8317(param_00,param_02);
}

//Function Number: 15
func_7A4F(param_00)
{
	return "Shoot the center of the target!";
}

//Function Number: 16
func_DBB3(param_00,param_01)
{
	if(param_00.var_E1B9 && !param_00.var_D776)
	{
		if(isdefined(level.needspowerstring))
		{
			return level.needspowerstring;
		}
		else
		{
			return &"COOP_INTERACTIONS_REQUIRES_POWER";
		}
	}

	if(param_00.var_EE04 == "afterlife")
	{
		param_00.cost = 0;
		return &"COOP_INTERACTIONS_PLAY_GAME";
	}

	if(scripts\common\utility::istrue(param_00.out_of_order))
	{
		return &"CP_ZMB_INTERACTIONS_MACHINE_OUT_OF_ORDER";
	}

	return level.interaction_hintstrings[param_00.script_noteworthy];
}

//Function Number: 17
func_FBEB(param_00)
{
	var_01 = scripts\common\utility::getstructarray("zombiezoom_sound","targetname");
	if(var_01.size > 0)
	{
		var_02 = scripts\common\utility::getclosest(param_00.origin,var_01);
		if(param_00.var_EE04 == "arcade" && !isdefined(level.var_2118))
		{
			level.var_2118 = spawn("script_origin",var_02.origin);
		}
		else if(param_00.var_EE04 != "arcade" && !isdefined(level.var_18E6))
		{
			level.var_18E6 = spawn("script_origin",var_02.origin);
		}

		playsoundatpos(var_02.origin,"arcade_horserace_bell_start");
		wait(0.2);
		playsoundatpos(var_02.origin,"mus_arcade_horserace_bugle");
		wait(0.1);
	}

	if(param_00.var_EE04 == "arcade")
	{
		level.var_2118 playloopsound("arcade_horserace_crowd_lp");
		return;
	}

	level.var_18E6 playloopsound("arcade_horserace_crowd_lp");
}

//Function Number: 18
func_FBEA(param_00)
{
	if(param_00.var_EE04 == "arcade")
	{
		level.var_2118 stoploopsound();
	}
	else
	{
		level.var_18E6 stoploopsound();
	}

	thread scripts\common\utility::play_sound_in_space("arcade_horserace_bell_end",param_00.origin);
}

//Function Number: 19
func_DBB5(param_00,param_01,param_02,param_03)
{
	param_00 endon("arcade_game_over_for_player");
	var_04 = param_00 scripts\common\utility::func_13734("disconnect","last_stand","spawned");
	if(var_04 == "disconnect")
	{
		param_01.var_163D = undefined;
	}
	else
	{
		[[ param_03 ]](param_01,param_00);
		param_00 takeweapon(param_02);
		param_00 scripts\common\utility::func_1C76(1);
		if(!param_00 scripts\common\utility::func_9FBE())
		{
			param_00 scripts\common\utility::func_1C6E(1);
		}
	}

	param_00 notify("arcade_game_over_for_player");
}

//Function Number: 20
func_DBB6(param_00,param_01,param_02,param_03,param_04)
{
	param_00 endon("arcade_game_over_for_player");
	param_00 endon("last_stand");
	param_00 endon("disconnect");
	param_00 endon("spawned");
	var_05 = 576;
	for(;;)
	{
		wait(0.1);
		if(distancesquared(param_00.origin,param_01.origin) > var_05)
		{
			param_00 playlocalsound("purchase_deny");
			wait(1);
			if(distancesquared(param_00.origin,param_01.origin) > var_05)
			{
				if(isdefined(param_02))
				{
					param_00 takeweapon(param_02);
				}

				[[ param_03 ]](param_01,param_00);
				param_01.var_163D = undefined;
				param_00 scripts\common\utility::func_1C76(1);
				if(!param_00 scripts\common\utility::func_9FBE())
				{
					param_00 scripts\common\utility::func_1C6E(1);
				}

				param_00 scripts\cp\zombies\arcade_game_utility::func_82F5(param_00);
				param_00 scripts\cp\zombies\arcade_game_utility::func_E2CB();
				param_00 notify("too_far_from_game");
				param_00 notify("arcade_game_over_for_player");
			}
		}
	}
}

//Function Number: 21
func_5555(param_00,param_01)
{
	level.var_2119 = 0;
	var_02 = randomintrange(param_00,param_01);
	for(;;)
	{
		level waittill("race_used");
		level.var_2119++;
		if(level.var_2119 == var_02)
		{
			var_02 = randomintrange(param_00,param_01);
			var_03 = scripts\common\utility::getstructarray("game_race","script_noteworthy");
			foreach(var_05 in var_03)
			{
				if(var_05.var_EE04 != "arcade")
				{
					continue;
				}

				var_05.out_of_order = 1;
			}

			level scripts\common\utility::waittill_any_3("regular_wave_starting","event_wave_starting");
			level.var_2119 = 0;
			foreach(var_05 in var_03)
			{
				if(var_05.var_EE04 != "arcade")
				{
					continue;
				}

				foreach(var_09 in level.players)
				{
					if(isdefined(var_09.var_A8D3) && var_09.var_A8D3 == var_05)
					{
						var_09 thread scripts\cp\_interaction::func_DE6E();
					}
				}

				var_05.out_of_order = 0;
			}
		}
	}
}