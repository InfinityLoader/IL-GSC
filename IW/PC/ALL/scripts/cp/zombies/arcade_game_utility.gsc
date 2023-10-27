/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\arcade_game_utility.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 681 ms
 * Timestamp: 10/27/2023 12:26:46 AM
*******************************************************************/

//Function Number: 1
update_player_tickets_earned(param_00)
{
	if(param_00.var_1189F > 0)
	{
		level thread func_D2FE(param_00);
	}
}

//Function Number: 2
func_D2FE(param_00)
{
	param_00 notify("ticket_queue");
	param_00 endon("ticket_queue");
	param_00 endon("disconnect");
	if(gettime() > param_00.var_118DE)
	{
		var_01 = param_00.var_1189F;
		if(var_01 > 10)
		{
			var_01 = 10;
		}

		param_00.var_118DE = gettime() + var_01 / 1.5 * 1000 + 500;
		var_02 = param_00.var_1189F;
		param_00.var_1189F = 0;
		func_8317(param_00,var_02);
		return;
	}

	while(gettime() < param_00.var_118DE && param_00.var_1189F > 0)
	{
		wait(0.1);
	}

	if(param_00.var_1189F > 0)
	{
		var_01 = param_00.var_1189F;
		if(var_01 > 10)
		{
			var_01 = 10;
		}

		param_00.var_118DE = gettime() + var_01 / 1.5 * 1000 + 500;
		var_02 = param_00.var_1189F;
		param_00.var_1189F = 0;
		func_8317(param_00,var_02);
	}
}

//Function Number: 3
func_8317(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.no_ticket_machine))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_00.var_5AD6))
	{
		param_01 = param_01 * 2;
	}

	if(!isdefined(param_00.num_tickets))
	{
		param_00.num_tickets = 0;
	}

	if(param_01 < 0)
	{
		param_01 = max(param_00.num_tickets * -1,param_01);
	}

	param_00.num_tickets = param_00.num_tickets + param_01;
	if(param_00.num_tickets < 0)
	{
		param_00.num_tickets = 0;
	}

	param_01 = int(param_01);
	if(param_01 == 0)
	{
		return;
	}

	if(param_01 > 0 && !scripts\common\utility::istrue(param_03))
	{
		param_00 playlocalsound("zmb_ui_earn_tickets");
	}

	param_00 setclientomnvar("zombie_number_of_ticket",int(param_00.num_tickets));
	if(!scripts\common\utility::istrue(param_03))
	{
		param_00 thread func_10101(param_01);
	}

	param_00 scripts\cp\_persistence::func_666A("tickettotal",int(param_00.num_tickets),1);
	lib_0D5A::func_12E3B(param_00,param_01);
}

//Function Number: 4
func_2110(param_00,param_01)
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

	if(scripts\common\utility::istrue(param_00.out_of_order))
	{
		return &"CP_ZMB_INTERACTIONS_MACHINE_OUT_OF_ORDER";
	}

	return level.interaction_hintstrings[param_00.script_noteworthy];
}

//Function Number: 5
func_10101(param_00)
{
	self endon("disconnect");
	if(param_00 < 0)
	{
		return;
	}

	self setclientomnvar("zm_tickets_dispersed",param_00);
	if(param_00 > 10)
	{
		param_00 = 10;
	}

	wait(2.5);
	self setclientomnvar("zm_tickets_dispersed",-1);
}

//Function Number: 6
func_2111(param_00,param_01,param_02,param_03)
{
	param_00 endon("arcade_game_over_for_player");
	var_04 = param_00 scripts\common\utility::waittill_any_return_no_endon_death_3("disconnect","last_stand","spawned");
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

	scripts\cp\_interaction::add_to_current_interaction_list(param_01);
	param_00 notify("arcade_game_over_for_player");
}

//Function Number: 7
func_2112(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_00 endon("arcade_game_over_for_player");
	param_00 endon("stop_too_far_check");
	param_00 endon("last_stand");
	param_00 endon("disconnect");
	param_00 endon("spawned");
	var_07 = 10000;
	if(isdefined(param_05))
	{
		var_07 = param_05;
	}

	for(;;)
	{
		wait(0.1);
		if(distancesquared(param_00.origin,param_01.origin) > var_07 || param_00 getstance() == "prone")
		{
			param_00 playlocalsound("purchase_deny");
			wait(0.5);
			if(distancesquared(self.origin,param_01.origin) > var_07 || param_00 getstance() == "prone")
			{
				if(isdefined(param_01.var_28BB))
				{
					if(isdefined(param_04))
					{
						param_01.var_28BB scripts\common\utility::delaycall(1,::playsound,param_04);
					}

					param_01.var_28BB scripts\common\utility::delaycall(1,::stoploopsound);
				}

				if(isdefined(param_02))
				{
					param_00 takeweapon(param_02);
				}

				[[ param_03 ]](param_01,param_00);
				param_01.var_163D = undefined;
				scripts\cp\_interaction::add_to_current_interaction_list(param_01);
				param_00 scripts\common\utility::func_1C76(1);
				if(!param_00 scripts\common\utility::func_9FBE())
				{
					param_00 scripts\common\utility::func_1C6E(1);
				}

				param_00 func_82F5(param_00);
				param_00 func_E2CB();
				if(param_00.var_210E == "tickets")
				{
					if(isdefined(param_01.var_2994) && param_01.var_2994 >= 1)
					{
						var_08 = param_01.var_2994 * 15;
						param_00 func_8317(param_00,param_01.var_2994 * 15);
						if(param_01.var_2994 * 15 > param_01.var_2993)
						{
							playsoundatpos(param_01.var_BDDB.origin,"basketball_anc_highscore");
							setomnvar("zombie_bball_game_" + param_06 + "_hiscore",param_01.var_2994 * 15);
							param_01.var_2993 = param_01.var_2994 * 15;
						}
					}

					if(isdefined(param_01.var_10227) && param_01.var_10227 >= 1)
					{
						var_08 = param_01.var_10227 * 1;
						param_00 func_8317(param_00,var_08);
					}

					if(isdefined(param_01.var_10227) && param_01.var_10227 >= 1)
					{
						var_08 = param_01.var_10227 * 1;
						param_00 func_8317(param_00,var_08);
					}
				}

				param_00 notify("too_far_from_game");
				param_00 notify("arcade_game_over_for_player");
			}
		}
	}
}

//Function Number: 8
func_12962(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 4;
	}

	if(!isdefined(param_01))
	{
		param_01 = 7;
	}

	for(;;)
	{
		var_02 = 1;
		self.out_of_order = 0;
		var_03 = 0;
		var_04 = randomintrange(param_00,param_01 + 1);
		while(var_02)
		{
			self waittill("machine_used");
			var_03++;
			if(var_03 >= var_04)
			{
				self.out_of_order = 1;
				var_02 = 0;
				level scripts\common\utility::waittill_any_3("regular_wave_starting","event_wave_starting");
			}

			foreach(var_06 in level.players)
			{
				if(isdefined(var_06.var_A8D3) && var_06.var_A8D3 == self)
				{
					var_06 thread scripts\cp\_interaction::func_DE6E();
				}
			}
		}
	}
}

//Function Number: 9
func_EB76(param_00)
{
	if(scripts\common\utility::istrue(param_00.in_afterlife_arcade))
	{
		return;
	}

	var_01 = param_00 getcurrentweapon();
	var_02 = 0;
	if(var_01 == "none")
	{
		var_02 = 1;
	}
	else if(scripts\common\utility::func_2286(level.additional_laststand_weapon_exclusion,var_01))
	{
		var_02 = 1;
	}
	else if(scripts\common\utility::func_2286(level.additional_laststand_weapon_exclusion,getweaponbasename(var_01)))
	{
		var_02 = 1;
	}
	else if(scripts\cp\_utility::func_9C42(var_01,1))
	{
		var_02 = 1;
	}

	if(var_02)
	{
		param_00.var_4643 = param_00 getweaponslistall();
		var_01 = param_00 scripts\cp\_laststand::func_3E88(level.additional_laststand_weapon_exclusion,1,1);
	}

	param_00.var_4643 = undefined;
	if(isdefined(var_01))
	{
		return var_01;
	}

	return param_00 getcurrentweapon();
}

//Function Number: 10
func_82F5(param_00)
{
	if(scripts\cp\_laststand::player_in_laststand(param_00))
	{
		return;
	}

	if(isdefined(param_00.var_D7AB))
	{
		if(param_00 hasweapon(param_00.var_D7AB))
		{
			param_00 switchtoweapon(param_00.var_D7AB);
		}
	}
	else
	{
		var_01 = param_00 getweaponslistprimaries();
		if(isdefined(var_01[1]))
		{
			param_00 switchtoweapon(var_01[1]);
		}
	}

	param_00.var_D7AC = undefined;
	param_00.var_D7AD = undefined;
	param_00.var_D7AB = undefined;
}

//Function Number: 11
func_11447()
{
	if(scripts\cp\_laststand::player_in_laststand(self))
	{
		return;
	}

	var_00 = scripts\cp\powers\coop_powers::func_13CFC("primary");
	var_01 = scripts\cp\powers\coop_powers::func_13CFC("secondary");
	self.var_D7AE = var_00;
	self.var_D7B0 = var_01;
	if(isdefined(var_00))
	{
		self.var_D7AF = self.var_D782[self.var_D7AE].var_3D23;
		scripts\cp\powers\coop_powers::func_E15E(var_00);
	}

	if(isdefined(var_01))
	{
		self.var_D7B1 = self.var_D782[self.var_D7B0].var_3D23;
		scripts\cp\powers\coop_powers::func_E15E(var_01);
	}
}

//Function Number: 12
take_player_super_pre_game()
{
	if(scripts\cp\_laststand::player_in_laststand(self))
	{
		return;
	}

	self method_84C3();
	self takeweapon("super_default_zm");
}

//Function Number: 13
func_E2CB()
{
	scripts\cp\_utility::func_E2D4();
	if(scripts\cp\_laststand::player_in_laststand(self))
	{
		return;
	}

	if(isdefined(self.var_D7AE))
	{
		var_00 = level.var_D782[self.var_D7AE].var_504B;
		scripts\cp\powers\coop_powers::func_4171(var_00);
		scripts\cp\powers\coop_powers::func_8397(self.var_D7AE,var_00,undefined,undefined,undefined,undefined,1);
		scripts\cp\powers\coop_powers::func_D71A(self.var_D7AF,var_00,1);
	}

	if(isdefined(self.var_D7B0))
	{
		var_00 = level.var_D782[self.var_D7B0].var_504B;
		scripts\cp\powers\coop_powers::func_4171(var_00);
		scripts\cp\powers\coop_powers::func_8397(self.var_D7B0,var_00,undefined,undefined,undefined,undefined,0);
		scripts\cp\powers\coop_powers::func_D71A(self.var_D7B1,var_00,1);
	}

	self.var_D7AE = undefined;
	self.var_D7AF = undefined;
	self.var_D7B0 = undefined;
	self.var_D7B1 = undefined;
}

//Function Number: 14
func_F2C7(param_00)
{
	if(scripts\common\utility::istrue(param_00.in_afterlife_arcade))
	{
		param_00.var_210E = "soul_power";
		return;
	}

	param_00.var_210E = "tickets";
}

//Function Number: 15
update_song_playing(param_00,param_01)
{
	param_00.song_playing = 1;
	var_02 = lookupsoundlength(param_01);
	wait(var_02 / 1000);
	param_00.song_playing = 0;
}