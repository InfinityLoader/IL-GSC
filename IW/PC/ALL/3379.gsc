/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3379.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 23 ms
 * Timestamp: 10/27/2023 12:26:49 AM
*******************************************************************/

//Function Number: 1
func_957A()
{
	var_00 = 4;
	var_01 = 7;
	var_02 = scripts\common\utility::getstructarray("clown_tooth_game","script_noteworthy");
	foreach(var_04 in var_02)
	{
		var_04 thread func_F918();
		var_04 thread scripts\cp\zombies\arcade_game_utility::func_12962(var_00,var_01);
		wait(0.05);
	}
}

//Function Number: 2
func_94D9()
{
	var_00 = scripts\common\utility::getstructarray("clown_tooth_game_afterlife","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread func_F918("afterlife");
		var_02.in_afterlife_arcade = 1;
		wait(0.05);
	}
}

//Function Number: 3
func_F918(param_00)
{
	var_01 = scripts\common\utility::istrue(self.var_E1B9) && isdefined(self.var_D71C);
	var_02 = getentarray(self.target,"targetname");
	self.var_115FB = [];
	foreach(var_04 in var_02)
	{
		if(var_04.classname == "light_spot")
		{
			self.var_1B9 = var_04;
			continue;
		}

		if(var_04.classname == "script_model")
		{
			var_04.var_12D72 = var_04.angles;
			self.var_115FB[self.var_115FB.size] = var_04;
		}
	}

	if(isdefined(self.var_1B9))
	{
		self.var_1B9 setlightintensity(0);
	}

	for(;;)
	{
		var_06 = "power_on";
		if(var_01)
		{
			var_06 = level scripts\common\utility::waittill_any_return_no_endon_death_3("power_on",self.var_D71C + " power_on","power_off");
		}

		if(var_06 == "power_off" && !scripts\common\utility::istrue(self.var_D776))
		{
			setomnvar("zombie_arcade_clowntooth_power_" + self.var_EE04,0);
			wait(0.25);
			continue;
		}

		if(var_06 != "power_off" && !isdefined(param_00))
		{
			self.var_D776 = 1;
			setomnvar("zombie_arcade_clowntooth_power_" + self.var_EE04,1);
			if(isdefined(self.var_1B9))
			{
				self.var_1B9 setlightintensity(2);
			}

			getent("cryptid_attack_arcade","targetname") setmodel("park_game_cryptid_attack");
		}
		else
		{
			self.var_D776 = 0;
			if(isdefined(self.var_1B9))
			{
				self.var_1B9 setlightintensity(0);
			}
		}

		if(!var_01)
		{
			break;
		}
	}
}

//Function Number: 4
func_12FBC(param_00,param_01)
{
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
	level.var_13BD4 = level.wave_num;
	if(!scripts\common\utility::istrue(param_01.in_afterlife_arcade))
	{
		scripts\cp\zombies\zombie_analytics::func_AF8C("clown_tooth_game",param_01);
	}
	else
	{
		scripts\cp\zombies\zombie_analytics::func_AF8C("clown_tooth_game_afterlife",param_01);
	}

	if(!scripts\common\utility::istrue(param_01.in_afterlife_arcade))
	{
		param_00 notify("machine_used");
	}

	param_01.var_D7AB = param_01 scripts\cp\zombies\arcade_game_utility::func_EB76(param_01);
	var_02 = scripts\common\utility::getstructarray("cryptid_sound","targetname");
	if(var_02.size > 0)
	{
		var_03 = scripts\common\utility::getclosest(param_00.origin,var_02);
		playsoundatpos(var_03.origin,"arcade_cryptid_attack_start");
	}

	param_01 setclientomnvar("zombie_arcade_game_time",1);
	param_01 setclientomnvar("zombie_ca_widget",1);
	scripts\common\utility::func_136F7();
	param_00.var_278 = 0;
	setomnvar("zombie_arcade_clowntooth_score_" + param_00.var_EE04,param_00.var_278);
	if(scripts\common\utility::istrue(param_01.in_afterlife_arcade))
	{
		setomnvar("zombie_afterlife_clowntooth_balls",6);
	}
	else
	{
		setomnvar("zombie_arcade_clowntooth_balls",6);
	}

	param_01 scripts\cp\zombies\arcade_game_utility::func_11447();
	param_01 giveweapon("iw7_cpclowntoothball_mp");
	param_01 switchtoweapon("iw7_cpclowntoothball_mp");
	param_01 scripts\common\utility::func_1C76(0);
	param_01 scripts\cp\_utility::func_1C5D(0);
	param_01 thread func_42D7(param_00,param_01);
	param_00 thread func_F917(param_00,param_01);
	param_01 thread func_D040(param_00,param_01);
	param_01 thread func_D09E(param_00,param_01);
	if(isdefined(level.start_cryptid_attack_func))
	{
		param_00 thread [[ level.start_cryptid_attack_func ]](param_00,param_01);
	}
}

//Function Number: 5
func_F917(param_00,param_01)
{
	param_00.remaining_teeth = param_00.var_115FB;
	foreach(var_03 in self.var_115FB)
	{
		if(var_03.angles != var_03.var_12D72)
		{
			var_03 playsound("arcade_tooth_reset");
			var_03 rotateto(var_03.var_12D72,0.1);
		}

		var_03 setcandamage(1);
		var_03 setcanradiusdamage(1);
		var_03.health = 999999;
		var_03 thread func_13633(param_00,param_01);
		wait(0.05);
	}
}

//Function Number: 6
func_13633(param_00,param_01)
{
	param_01 endon("arcade_game_over_for_player");
	for(;;)
	{
		self waittill("damage",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
		self.health = 999999;
		if(!isdefined(var_0B) || var_0B != "iw7_cpclowntoothball_mp")
		{
			continue;
		}

		param_00.var_278++;
		self playsound("arcade_cryptid_attack_tooth_hit");
		if(isdefined(self.script_noteworthy))
		{
			self playsound("arcade_" + self.script_noteworthy);
		}
		else
		{
			self playsound("zmb_wheel_spin_tick");
		}

		if(param_00.var_278 == 6)
		{
			param_00.var_278 = 10;
		}

		setomnvar("zombie_arcade_clowntooth_score_" + param_00.var_EE04,param_00.var_278 * 10);
		self rotateto(scripts\common\utility::getstruct(self.target,"targetname").angles,0.1);
		param_00.remaining_teeth = scripts\common\utility::func_22A9(param_00.remaining_teeth,self);
		param_01 notify("hit_a_cryptid_tooth",self);
	}
}

//Function Number: 7
func_42D7(param_00,param_01)
{
	self endon("last_stand");
	self endon("disconnect");
	self endon("arcade_game_over_for_player");
	self endon("player_too_far");
	var_02 = 6;
	for(;;)
	{
		self waittill("grenade_pullback",var_03);
		if(var_03 != "iw7_cpclowntoothball_mp")
		{
			continue;
		}

		if(!isdefined(self.var_55E4) || self.var_55E4 == 0)
		{
			scripts\common\utility::func_1C6E(0);
		}

		self waittill("grenade_fire",var_04,var_03);
		if(var_03 == "iw7_cpclowntoothball_mp")
		{
			self notify("throw_a_ball_at_cryptid_attack");
			var_02--;
			if(scripts\common\utility::istrue(param_01.in_afterlife_arcade))
			{
				setomnvar("zombie_afterlife_clowntooth_balls",var_02);
			}
			else
			{
				setomnvar("zombie_arcade_clowntooth_balls",var_02);
			}
		}

		if(var_02 == 0)
		{
			break;
		}

		wait(0.1);
	}

	wait(1);
	func_6946(param_00,self);
}

//Function Number: 8
func_D040(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("arcade_game_over_for_player");
	var_02 = param_01 scripts\common\utility::func_13734("disconnect","last_stand","player_too_far","spawned");
	func_6946(param_00,param_01,var_02);
}

//Function Number: 9
func_D09E(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("arcade_game_over_for_player");
	param_01 endon("spawned");
	param_01 endon("disconnect");
	var_02 = 10000;
	for(;;)
	{
		wait(0.1);
		if(distancesquared(param_01.origin,param_00.origin) > var_02)
		{
			param_01 playlocalsound("purchase_deny");
			wait(1);
			if(distancesquared(self.origin,param_00.origin) > var_02)
			{
				param_01 notify("player_too_far");
				return;
			}
		}
	}
}

//Function Number: 10
func_6946(param_00,param_01,param_02)
{
	if(isdefined(param_01) && isalive(param_01))
	{
		param_01 takeweapon("iw7_cpclowntoothball_mp");
		param_01 lib_0D3D::func_FEBF(param_01);
		param_01 setclientomnvar("zombie_arcade_game_time",-1);
		param_01 setclientomnvar("zombie_arcade_game_ticket_earned",0);
		param_01 setclientomnvar("zombie_ca_widget",0);
		param_01.playing_game = undefined;
		param_01 scripts\common\utility::func_1C76(1);
		if(!param_01 scripts\common\utility::func_9FBE())
		{
			param_01 scripts\common\utility::func_1C6E(1);
		}

		param_01 scripts\cp\zombies\arcade_game_utility::func_82F5(param_01);
		param_01 scripts\cp\zombies\arcade_game_utility::func_E2CB();
		if(param_00.var_278 > 0)
		{
			playsoundatpos(param_00.origin,"mp_slot_machine_coins");
		}

		if(param_00.var_278 == 6)
		{
			wait(1);
			param_01 playlocalsound("purchase_perk");
			param_00.var_278 = 10;
		}

		var_03 = param_00.var_278 * 10;
		if(param_01.var_210E == "soul_power")
		{
			param_01 scripts\cp\zombies\zombie_afterlife_arcade::func_8334(param_01,var_03);
			scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_01,level.var_13BD4,"clown_tooth_game_afterlife",1,var_03,param_01.pers["timesPerWave"].var_11930[level.var_13BD4]["clown_tooth_game_afterlife"]);
		}
		else
		{
			level notify("update_arcade_game_performance","cryptid_attack",var_03);
			param_01 scripts\cp\zombies\arcade_game_utility::func_8317(param_01,var_03);
			scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_01,level.var_13BD4,"clown_tooth_game",0,var_03,param_01.pers["timesPerWave"].var_11930[level.var_13BD4]["clown_tooth_game"]);
		}

		if(!param_01 scripts\cp\_utility::func_213E())
		{
			param_01 scripts\cp\_utility::func_1C5D(1);
		}
	}

	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
	param_01 notify("arcade_game_over_for_player");
}