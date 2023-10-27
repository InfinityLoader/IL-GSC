/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1383.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 23 ms
 * Timestamp: 10/27/2023 3:25:56 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_A41["zombie_heavy"] = level.var_A41["zombie"];
	level.var_A41["zombie_heavy"]["think"] = ::func_ABC8;
	level.var_A41["zombie_heavy"]["on_damaged"] = ::func_ABC4;
	level.var_A41["zombie_heavy"]["on_damaged_finished"] = ::func_ABC5;
	level.var_A41["zombie_heavy"]["move_mode"] = ::func_ABC3;
	level.var_A41["zombie_heavy"]["ragdoll_overrides"] = ::func_ABC6;
	level.var_A41["zombie_heavy"]["is_hit_weak_point"] = ::func_ABC0;
	level.var_A41["zombie_heavy"]["tesla_delayed_dmg"] = ::zombie_heavy_tesla_delayed_dmg;
	var_00 = "default look";
	var_01 = spawnstruct();
	var_01.var_A4B = "zombie_heavy";
	var_01.var_EAE = "zombie_animclass";
	var_01.var_879 = "zombie_generic";
	var_01.var_5ED2[var_00]["whole_body"] = "zom_follower_base";
	var_01.var_4C12 = 10;
	var_01.var_60E2 = 65;
	var_01.var_2F9B = 1;
	var_01.var_8302 = 75;
	var_01.var_8303 = 15;
	var_01.parenttype = "zombie_generic";
	var_01.suppressive_fire_speed_multiplier = 0.5;
	var_01.tacklebycharge = 1;
	var_01.knockbyravensword = 1;
	var_01.energyhold = 1;
	var_01.energyholdsecondary = 0;
	var_01.energyholdpain = 4;
	var_01.throwable = 0;
	if(isdefined(level.var_62AB))
	{
		var_01 = [[ level.var_62AB ]](var_01);
	}

	lib_0547::func_A52(var_01,"zombie_heavy");
	lib_0547::func_7BD0("heavy_charge",::lib_0547::zombie_charge_run,undefined,2.5,::lib_0547::zombie_charge_cleanup);
}

//Function Number: 2
func_408E()
{
	return lib_0547::func_4090("zombie_heavy");
}

//Function Number: 3
func_4305()
{
	return 1;
}

//Function Number: 4
func_ABC2()
{
	self endon("death");
	self endon("stalk_change");
	childthread lib_0547::zombie_monitor_ignored_stalkee(self.var_915D);
	var_00 = self.var_915D common_scripts\utility::func_A715("death","bleedout","disconnect","shouldBeIgnored");
	self.var_915D = undefined;
	func_ABBE();
}

//Function Number: 5
func_ABC7(param_00)
{
	if(lib_0547::func_5565(param_00,self.var_915D))
	{
		return;
	}

	self notify("stalk_change");
	wait 0.05;
	self.var_915D = param_00;
	self agentsetfavoriteenemy(param_00);
	if(isdefined(param_00))
	{
		thread func_ABC2();
	}
}

//Function Number: 6
func_ABDB()
{
	self endon("death");
	for(;;)
	{
		var_00 = common_scripts\utility::func_A717("attack_hit","attack_miss");
		level notify("follower swing",self gettagorigin("J_Wrist_RI"),64);
		var_01 = spawnstruct();
		var_01.var_2434 = 37;
		var_01.var_60C1 = 55;
		var_01.var_3A20 = 82;
		var_01.var_1B70 = 160;
		foreach(var_03 in lib_0547::func_408F())
		{
			var_04 = lib_0547::func_A51(var_03.var_A4B);
			var_05 = isdefined(var_04) && common_scripts\utility::func_562E(var_04.tacklebymelee);
			if(var_03 == self || !var_05 || !maps/mp/agents/humanoid/_humanoid_melee::func_11AF(var_03) || var_03 maps/mp/agents/humanoid/_humanoid_util::func_56BC())
			{
				continue;
			}

			var_06 = var_03 lib_0547::func_43EF(var_01,distance(self.var_116,var_03.var_116));
			lib_0547::func_7D1B(self,var_03,var_06);
		}
	}
}

//Function Number: 7
func_ABBE()
{
	lib_0547::func_84CB();
	if(isdefined(self.var_3043))
	{
		return;
	}

	self.var_66AC = 10;
	common_scripts\utility::func_379A("zombie_passive");
}

//Function Number: 8
func_ABC6()
{
	return 0.3;
}

//Function Number: 9
func_ABC8()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	self method_85A1("zombie_heavy");
	if(!common_scripts\utility::func_562E(level.iszombiesshotgun))
	{
		self.var_6816 = 1;
	}

	self.var_2FA4 = 0;
	self.var_915D = undefined;
	self.var_6EB0 = 350;
	self.var_78D7 = 0;
	self.var_6099 = self.var_FB / 4;
	self.var_60E4 = 1.5;
	self.var_5542 = 0;
	self.var_55AB = 1;
	lib_0566::func_ABB5();
	thread func_ABDB();
	thread zombie_heavy_grudge_think();
	lib_0547::func_86C8(100);
	lib_0547::func_86C7(100);
	var_00 = 0;
	for(;;)
	{
		wait(var_00);
		var_00 = 0.2;
		if(!self.var_5542)
		{
			if(lib_053C::func_4F8C())
			{
				continue;
			}
		}

		if(isdefined(self.custom_think_mode))
		{
			self [[ self.custom_think_mode ]]();
			continue;
		}

		if(common_scripts\utility::func_562E(self.var_57C0))
		{
			continue;
		}

		if(self.var_5542)
		{
			lib_0547::zombie_charge_cleanup(self.var_645E);
		}

		if(lib_053C::func_4F84())
		{
			continue;
		}

		if(!lib_0547::func_4B2C() && lib_053C::func_4F9A())
		{
			continue;
		}

		var_02 = undefined;
		var_03 = undefined;
		var_04 = lib_053C::func_4F88();
		if(var_04.size)
		{
			var_02 = var_04[0];
			var_03 = distance(self.var_116,var_02.var_116);
		}

		if(isdefined(self.var_915D))
		{
			if(lib_0547::func_577E(self.var_915D))
			{
				self.var_28D2 = undefined;
				func_ABBE();
				continue;
			}
			else if(isdefined(var_02) && var_03 < 300 && var_03 + 100 < distance(self.var_116,self.var_915D.var_116))
			{
				func_ABC7(var_02);
				continue;
			}
		}
		else if(isdefined(var_02))
		{
			func_ABC7(var_02);
			continue;
		}

		if(lib_053C::func_4F9B(1))
		{
			continue;
		}

		if(lib_053C::func_4F9A())
		{
			continue;
		}

		lib_053C::func_647();
	}
}

//Function Number: 10
func_ABBF(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_05) || !isdefined(param_06) || !isdefined(param_07))
	{
		return 0;
	}

	if(param_07 != "torso_upper" && param_07 != "torso_lower")
	{
		return 0;
	}

	var_09 = self gettagangles("j_spineupper");
	var_0A = anglestoright(var_09);
	return vectordot(var_0A,param_06) > 0;
}

//Function Number: 11
func_ABC4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(param_08 == "right_hand")
	{
		param_02 = 0;
	}

	if(func_ABBF(param_00,param_01,param_02,param_04,param_05,param_06,param_07,param_08,param_0A))
	{
		if(isdefined(param_04) && param_04 != "MOD_MELEE")
		{
			param_02 = param_02 * 4;
		}
		else
		{
			self.var_14EB = 1;
		}
	}
	else if(param_08 == "head" && param_05 != "panzerschreck_zm" && !issubstr(param_05,"fliegerfaust") && !issubstr(param_05,"tesla") && param_05 != "raven_sword_zm" && !issubstr(param_05,"razergun") && !issubstr(param_05,"throwingknife"))
	{
		param_02 = param_02 * 0.8;
	}
	else if(param_05 != "panzerschreck_zm" && !issubstr(param_05,"fliegerfaust") && !issubstr(param_05,"tesla") && param_05 != "raven_sword_zm" && !issubstr(param_05,"razergun") && !issubstr(param_05,"throwingknife"))
	{
		param_02 = param_02 * 0.6;
	}

	if(param_05 == "bazooka_zm")
	{
		param_02 = self.var_FB;
	}

	lib_054D::func_6BD1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
}

//Function Number: 12
zombie_heavy_set_grudge(param_00)
{
	zombie_heavy_interrupt_grudge();
	self endon("death");
	self endon("grudge_started");
	self.grudgetarget = param_00;
	common_scripts\utility::func_A70D(14,param_00,"death",param_00,"disconnect");
	self.grudgetarget = undefined;
}

//Function Number: 13
zombie_heavy_interrupt_grudge()
{
	self notify("grudge_end");
	self.grudgetarget = undefined;
}

//Function Number: 14
zombie_heavy_grudge_think()
{
	for(;;)
	{
		wait(0.5);
		if(!isdefined(self.grudgetarget))
		{
			continue;
		}

		if(lib_0547::is_in_scripted_state("heavy_charge"))
		{
			zombie_heavy_interrupt_grudge();
			continue;
		}

		if(!zombie_heavy_charge_allowed())
		{
			continue;
		}

		if(lib_0547::has_scripted_state_queued("heavy_charge"))
		{
			continue;
		}

		if(zombie_heavy_valid_charge_target(self.grudgetarget))
		{
			func_ABB7(self.grudgetarget);
			level.var_5B1B = gettime();
		}
	}
}

//Function Number: 15
zombie_heavy_valid_charge_target(param_00)
{
	if(isplayer(param_00) && issentient(param_00) && self agentcanseesentient(param_00) && lib_0547::func_1F5B(self.var_116,param_00.var_116) && common_scripts\utility::func_F79(lib_053C::func_4F88(),param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 16
zombie_heavy_charge_allowed()
{
	return !isdefined(level.var_5B1B) || gettime() - level.var_5B1B > 700;
}

//Function Number: 17
func_ABC5(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(self.var_78D7 < self.var_6099)
	{
		self.var_78D7 = self.var_78D7 + param_02;
	}

	if(self.var_78D7 >= self.var_6099 && zombie_heavy_charge_allowed() && zombie_heavy_valid_charge_target(param_01) && (!isdefined(self.var_3043) || !maps/mp/agents/humanoid/_humanoid_util::func_8BAE()) && !isdefined(self.var_1927) && (!lib_053C::func_5686() || !common_scripts\utility::func_F79(self.var_983C,param_01)) && !common_scripts\utility::func_562E(self.var_57C0))
	{
		func_ABB7(param_01);
		self.var_78D7 = 0;
		level.var_5B1B = gettime();
	}

	lib_054D::func_6BD3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
}

//Function Number: 18
func_ABC3()
{
	if(!isdefined(self.var_64C4))
	{
		self.var_64C4 = 1;
	}

	self.var_64C2 = self.var_64C4 * lib_054D::func_4440();
	return "walk";
}

//Function Number: 19
func_ABB7(param_00)
{
	var_01 = spawnstruct();
	var_01.var_721C = param_00;
	var_01.var_7462 = param_00.var_116;
	var_01.end_notify = "heavy_end_charge";
	var_01.scripted_state = "heavy_charge";
	var_01.stop_run_state_name = "fol_attack_charge";
	var_01.react_state_name = "fol_pain_charge_react";
	var_01.run_state_name = "fol_run_charge";
	var_01.react_anim_rate = 1;
	var_01.extra_lunge_radius = 100;
	var_01.trigger_lerp_deg = 25;
	var_01.trigger_nolerp_deg = 50;
	var_01.var_9DAA = 202;
	var_01.turn_smoothing_thread = ::lib_0547::zombie_charge_turn_smoothing_thread;
	var_01.initial_turn_deg = 200;
	var_01.initial_turn_secs = 0.1;
	var_01.initial_turn_speed = 0.169;
	var_01.var_2434 = 37;
	var_01.var_60C1 = 55;
	var_01.var_3A20 = 82;
	var_01.var_1B70 = 160;
	thread lib_0547::func_7D1A("heavy_charge",[var_01],0.5);
}

//Function Number: 20
func_ABC0(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(func_ABBF(param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09))
	{
		return 1;
	}

	return 0;
}

//Function Number: 21
zombie_heavy_tesla_delayed_dmg(param_00,param_01,param_02)
{
	if(common_scripts\utility::func_562E(param_01))
	{
		param_00 = maps/mp/gametypes/zombies::func_1E59();
	}

	if(isdefined(param_02))
	{
		param_00 = param_02;
	}

	return param_00;
}