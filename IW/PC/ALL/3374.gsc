/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3374.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 11 ms
 * Timestamp: 10/27/2023 12:26:47 AM
*******************************************************************/

//Function Number: 1
func_9541()
{
	var_00 = scripts\common\utility::getstructarray("basketball_game","script_noteworthy");
	var_01 = 4;
	var_02 = 7;
	foreach(var_04 in var_00)
	{
		var_04 thread func_F8C9();
		var_04 thread scripts\cp\zombies\arcade_game_utility::func_12962(var_01,var_02);
		wait(0.05);
	}
}

//Function Number: 2
func_94D8()
{
	var_00 = scripts\common\utility::getstructarray("basketball_game_afterlife","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread func_F8C9();
		wait(0.05);
	}
}

//Function Number: 3
func_F8C9()
{
	var_00 = scripts\common\utility::istrue(self.var_E1B9) && isdefined(self.var_D71C);
	var_01 = getentarray(self.target,"targetname");
	foreach(var_03 in var_01)
	{
		if(var_03.classname == "light_spot")
		{
			self.var_1B9 = var_03;
			break;
		}
	}

	var_05 = getentarray(self.target,"targetname");
	foreach(var_03 in var_05)
	{
		if(!isdefined(var_03.script_noteworthy))
		{
			continue;
		}

		switch(var_03.script_noteworthy)
		{
			case "hoop_trig":
				self.var_9084 = var_03;
				break;

			case "hoop":
				self.var_9082 = var_03;
				break;

			case "hoop_clip":
				self.var_9083 = var_03;
				break;

			case "rim":
				self.var_E536 = var_03;
				break;

			case "bball_sound_ent":
				self.var_BDDB = var_03;
				break;
		}
	}

	self.var_9084 enablelinkto();
	self.var_9084 linkto(self.var_9082);
	self.var_9083 linkto(self.var_9082);
	self.var_E536 linkto(self.var_9082);
	self.var_2993 = 0;
	self.var_9082 thread func_BC36(self,var_00);
	for(;;)
	{
		var_08 = "power_on";
		if(var_00)
		{
			var_08 = level scripts\common\utility::waittill_any_return_no_endon_death_3("power_on",self.var_D71C + " power_on","power_off");
		}

		if(var_08 == "power_off" && !scripts\common\utility::istrue(self.var_D776))
		{
			wait(0.25);
			continue;
		}

		if(var_08 != "power_off")
		{
			self.var_D776 = 1;
			if(isdefined(self.var_1B9))
			{
				self.var_1B9 setlightintensity(100);
			}
		}
		else
		{
			self.var_D776 = 0;
			if(isdefined(self.var_1B9))
			{
				self.var_1B9 setlightintensity(0);
			}
		}

		if(!var_00)
		{
			break;
		}
	}
}

//Function Number: 4
func_BC36(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01))
	{
		level scripts\common\utility::waittill_any_3("power_on",param_00.var_D71C + " power_on");
	}

	wait(randomintrange(1,4));
	var_02 = self.origin;
	var_03 = scripts\common\utility::getstructarray(self.target,"targetname");
	for(;;)
	{
		if(scripts\common\utility::istrue(param_01) && param_00.var_D776 == 0)
		{
			self moveto(var_02,2);
			level scripts\common\utility::waittill_any_3("power_on",param_00.var_D71C + " power_on");
		}

		self moveto(var_03[0].origin,4);
		self waittill("movedone");
		self moveto(var_03[1].origin,4);
		self waittill("movedone");
	}
}

//Function Number: 5
func_12FA8(param_00,param_01)
{
	param_01 endon("disconnect");
	if(param_01 getstance() != "stand")
	{
		param_01 scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_MUST_BE_STANDING");
		param_01 scripts\cp\_interaction::func_DE6E();
		return;
	}

	param_01 notify("cancel_sentry");
	param_01 notify("cancel_medusa");
	param_01 notify("cancel_trap");
	param_01 notify("cancel_boombox");
	param_01 notify("cancel_revocator");
	param_01 notify("cancel_ims");
	param_01 notify("cancel_gascan");
	scripts\cp\zombies\arcade_game_utility::func_F2C7(param_01);
	param_01.playing_game = 1;
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	param_00 notify("machine_used");
	level.var_13BD4 = level.wave_num;
	if(!scripts\common\utility::istrue(param_01.in_afterlife_arcade))
	{
		scripts\cp\zombies\zombie_analytics::func_AF8C("basketball_game",param_01);
	}
	else
	{
		scripts\cp\zombies\zombie_analytics::func_AF8C("basketball_game_afterlife",param_01);
	}

	param_01 playlocalsound("arcade_insert_coin_01");
	playsoundatpos(param_00.var_BDDB.origin,"basketball_anc_activate");
	if(!isdefined(param_00.var_28BB))
	{
		if(isdefined(param_00.var_BDDB))
		{
			param_00.var_28BB = param_00.var_BDDB;
		}
		else
		{
			param_00.var_28BB = spawn("script_origin",param_00.origin);
		}
	}

	playsoundatpos(param_00.var_28BB.origin,"mus_arcade_basketball_charge");
	param_00.var_28BB scripts\common\utility::delaycall(2,::playloopsound,"mus_arcade_basketball_game_lp");
	var_02 = undefined;
	switch(param_00.var_EE04)
	{
		case "zombie_bball_game_1_is_active":
			var_02 = 1;
			break;

		case "zombie_bball_game_2_is_active":
			var_02 = 2;
			break;

		case "zombie_bball_game_3_is_active":
			var_02 = 3;
			break;
	}

	param_01 thread func_CCA6(param_00,var_02);
}

//Function Number: 6
func_28BE(param_00,param_01)
{
	param_01 endon("disconnect");
	param_01 setclientomnvar("zombie_arcade_game_time",-1);
	param_01 setclientomnvar("zombie_arcade_game_ticket_earned",0);
	param_01 setclientomnvar("zombie_bball_widget",0);
	param_01.playing_game = undefined;
	if(!param_01 scripts\cp\_utility::func_213E())
	{
		param_01 scripts\cp\_utility::func_1C5D(1);
	}
}

//Function Number: 7
func_CCA6(param_00,param_01)
{
	self notify("arcade_game_over_for_player");
	self endon("arcade_game_over_for_player");
	self endon("spawned");
	self endon("disconnect");
	if(isdefined(level.start_rings_of_saturn_func))
	{
		param_00 thread [[ level.start_rings_of_saturn_func ]](param_00,self);
	}

	param_00.var_2994 = 0;
	if(!scripts\common\utility::istrue(self.in_afterlife_arcade))
	{
		while(self getcurrentprimaryweapon() == "none" || self method_81C2())
		{
			wait(0.1);
		}
	}

	self notify("cancel_sentry");
	self notify("cancel_medusa");
	self notify("cancel_trap");
	self notify("cancel_boombox");
	self notify("cancel_revocator");
	self notify("cancel_ims");
	self notify("cancel_gascan");
	self.var_D7AB = scripts\cp\zombies\arcade_game_utility::func_EB76(self);
	scripts\common\utility::func_1C76(0);
	scripts\cp\zombies\arcade_game_utility::func_11447();
	scripts\cp\zombies\arcade_game_utility::take_player_super_pre_game();
	scripts\common\utility::func_1C6E(0);
	self setclientomnvar("zombie_bball_game_" + param_01 + "_time",15);
	self setclientomnvar("zombie_arcade_game_time",1);
	self setclientomnvar("zombie_bball_widget",1);
	scripts\cp\_utility::func_1C5D(0);
	level thread func_28BC(self,param_01);
	level thread func_28BA(self,param_00,param_01);
	thread scripts\cp\zombies\arcade_game_utility::func_2111(self,param_00,"iw7_cpbasketball_mp",::func_28BE);
	thread scripts\cp\zombies\arcade_game_utility::func_2112(self,param_00,"iw7_cpbasketball_mp",::func_28BE,"mus_arcade_basketball_game_end",undefined,param_01);
	for(;;)
	{
		self giveweapon("iw7_cpbasketball_mp");
		self switchtoweapon("iw7_cpbasketball_mp");
		func_13929(param_00,param_01);
	}
}

//Function Number: 8
func_7A4F(param_00)
{
	if(scripts\common\utility::istrue(param_00.in_afterlife_arcade))
	{
		return "Score ^3 15 ^7 soul power per basket";
	}

	return "Win 15 tickets per basket!";
}

//Function Number: 9
func_28BA(param_00,param_01,param_02)
{
	param_00 notify("basketball_game");
	param_00 endon("basketball_game");
	param_00 endon("disconnect");
	param_00 endon("spawned");
	wait(1);
	param_00 setclientomnvar("zombie_bball_game_" + param_02 + "_score",0);
	param_00 setclientomnvar("zombie_arcade_game_ticket_earned",0);
	param_00 scripts\common\utility::waittill_any_3("bball_timer_expired");
	param_01.var_28BB scripts\common\utility::delaycall(1,::stoploopsound);
	param_01.var_28BB scripts\common\utility::delaycall(1,::playsound,"mus_arcade_basketball_game_end");
	param_00 setclientomnvar("zombie_arcade_game_time",-1);
	param_00 setclientomnvar("zombie_arcade_game_ticket_earned",0);
	param_00 setclientomnvar("zombie_bball_widget",0);
	param_00.playing_game = undefined;
	param_01.var_11911 = undefined;
	param_00 takeweapon("iw7_cpbasketball_mp");
	param_00 scripts\common\utility::func_1C76(1);
	if(!param_00 scripts\common\utility::func_9FBE())
	{
		param_00 scripts\common\utility::func_1C6E(1);
	}

	param_00 scripts\cp\zombies\arcade_game_utility::func_82F5(param_00);
	param_00 scripts\cp\zombies\arcade_game_utility::func_E2CB();
	param_00 notify("arcade_game_over_for_player");
	if(param_01.var_2994 >= 1)
	{
		var_03 = param_01.var_2994 * 15;
		if(param_00.var_210E == "soul_power")
		{
			scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_00,level.var_13BD4,param_01.name,1,var_03,param_00.pers["timesPerWave"].var_11930[level.var_13BD4]["basketball_game_afterlife"]);
		}
		else
		{
			scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_00,level.var_13BD4,param_01.name,0,var_03,param_00.pers["timesPerWave"].var_11930[level.var_13BD4]["basketball_game"]);
			param_00 scripts\cp\zombies\arcade_game_utility::func_8317(param_00,param_01.var_2994 * 15);
		}
	}

	if(param_01.var_2994 * 15 > param_01.var_2993)
	{
		playsoundatpos(param_01.var_BDDB.origin,"basketball_anc_highscore");
		setomnvar("zombie_bball_game_" + param_02 + "_hiscore",param_01.var_2994 * 15);
		param_01.var_2993 = param_01.var_2994 * 15;
	}

	wait(2);
	scripts\cp\_interaction::add_to_current_interaction_list(param_01);
	if(!param_00 scripts\cp\_utility::func_213E())
	{
		param_00 scripts\cp\_utility::func_1C5D(1);
	}
}

//Function Number: 10
func_28BC(param_00,param_01)
{
	param_00 endon("disconnect");
	param_00 endon("death");
	param_00 endon("arcade_game_over_for_player");
	for(var_02 = 15;var_02 > -1;var_02--)
	{
		wait(1);
		param_00 setclientomnvar("zombie_bball_game_" + param_01 + "_time",var_02);
	}

	param_00 notify("bball_timer_expired");
}

//Function Number: 11
func_13929(param_00,param_01)
{
	self endon("arcade_game_over_for_player");
	for(;;)
	{
		self waittill("grenade_pullback",var_02);
		if(var_02 != "iw7_cpbasketball_mp")
		{
			continue;
		}

		self notify("ready_to_throw_next_basketball");
		var_03 = anglestoforward(self getplayerangles());
		var_04["position"] = self geteye() + (0,0,5) + var_03 * 10;
		var_05 = spawn("script_model",var_04["position"]);
		var_05 hide();
		var_07 = gettime();
		self waittill("grenade_fire",var_08,var_02);
		var_08 delete();
		var_09 = gettime() - var_07 / 1000;
		if(var_09 < 0.2)
		{
			wait(0.2 - var_09);
		}

		thread func_117FB(param_00,var_05,param_01);
		self takeweapon("iw7_cpbasketball_mp");
		wait(0.25);
	}
}

//Function Number: 12
func_117FB(param_00,param_01,param_02)
{
	var_03 = anglestoforward(self getplayerangles());
	var_04 = self geteye() + (0,0,5) + var_03 * 10;
	param_01.origin = var_04;
	param_01 setmodel("decor_basketball_zmb");
	param_01 show();
	var_05 = 450;
	var_06 = 0.75;
	param_01 physicslaunchserver(var_04,var_03 + (0,0,var_06) * var_05);
	param_01 thread scripts\cp\_utility::func_DED0();
	param_01 method_84D1();
	scripts\cp\_utility::func_DECF(param_01,::func_28BD);
	param_01 thread func_13928(param_00,self,param_02);
	wait(5);
	if(isdefined(param_01))
	{
		param_01 delete();
	}
}

//Function Number: 13
func_13928(param_00,param_01,param_02)
{
	param_01 endon("arcade_game_over_for_player");
	param_01 endon("death");
	self endon("death");
	param_01 notify("throw_a_basketball");
	for(;;)
	{
		if(self istouching(param_00.var_9084))
		{
			break;
		}

		wait(0.05);
	}

	param_01 notify("score_a_basket");
	param_00.var_9084 playsound("arcade_basketball_basket_point");
	param_00.var_2994++;
	playsoundatpos(param_00.var_BDDB.origin,"basketball_anc_quickshot");
	if(param_00.var_2994 * 15 > level.var_28BF)
	{
		level.var_28BF = param_00.var_2994 * 15;
	}

	if(scripts\common\utility::istrue(param_01.in_afterlife_arcade))
	{
		param_01 scripts\cp\zombies\zombie_afterlife_arcade::func_8334(param_01,15);
	}

	param_01 setclientomnvar("zombie_arcade_game_ticket_earned",param_00.var_2994 * 15);
	param_01 setclientomnvar("zombie_bball_game_" + param_02 + "_score",param_00.var_2994 * 15);
	wait(3);
	self delete();
}

//Function Number: 14
func_28BD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isdefined(param_00.var_D4A9))
	{
		return;
	}

	param_00 endon("death");
	param_00.var_D4A9 = 1;
	var_09 = "arcade_basketball_bounce";
	if(isdefined(param_08) && isdefined(param_08.script_noteworthy) && param_08.script_noteworthy == "rim")
	{
		var_09 = "arcade_basketball_rim";
	}
	else if(isdefined(param_08) && isdefined(param_08.script_noteworthy) && param_08.script_noteworthy == "hoop_clip")
	{
		var_09 = "arcade_basketball_backboard";
	}

	param_00 playsound(var_09);
	wait(lookupsoundlength(var_09) / 1000);
	param_00.var_D4A9 = undefined;
}