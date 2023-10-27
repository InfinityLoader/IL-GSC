/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\zombie_assassin_basic.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 171
 * Decompile Time: 2977 ms
 * Timestamp: 10/27/2023 3:14:08 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	init_scripted_states();
	init_assassin_phase_handler();
	init_assassin_spawns_and_exits();
	init_assassin_vo_flags();
	init_assassin_vfx();
	maps/mp/agents/_scripted_agent_anim_util::func_5159("zombie_assassin");
	var_00 = level.var_A41["zombie"];
	var_00["get_action_params"] = ::assassin_get_action_params;
	var_00["think"] = ::assassin_think;
	var_00["move_mode"] = ::zombie_assassin_move_mode_func;
	var_00["on_damaged"] = ::zombie_assassin_on_damaged;
	var_00["tesla_delayed_dmg"] = ::zombie_assassin_tesla_delayed_dmg;
	level.var_A41["zombie_assassin"] = var_00;
	var_01 = spawnstruct();
	var_01.var_A4B = "zombie_assassin";
	var_01.var_EAE = "zombie_assassin_animclass";
	var_01.var_E88 = "zombie_assassin";
	var_01.var_879 = "zombie_assassin";
	var_01.var_5ED2["default look"]["whole_body"] = "zom_assassin_body";
	var_01.var_5ED2["default look"]["heads"] = ["zom_assassin_head"];
	var_01.var_5ED2["boss look"]["whole_body"] = "zom_elite_assassin_body";
	var_01.var_5ED2["boss look"]["heads"] = ["zom_elite_assassin_head"];
	var_01.var_60E2 = 90;
	var_01.var_4C12 = 25;
	var_01.energyhold = 1;
	var_01.energyholdsecondary = 0;
	var_01.energyholdpain = 7;
	var_01.throwable = 0;
	lib_0547::func_A52(var_01,"zombie_assassin");
	lib_0547::registeranimtree("zombie_assassin",#animtree);
	level.var_611["zmb_assassin_light_frontline_ext"] = loadfx("vfx/zombie/abilities_perks/assn/zmb_dlc1_assn_frontline_ext");
	level.var_611["zmb_assassin_light_freefire_ext"] = loadfx("vfx/zombie/abilities_perks/assn/zmb_dlc1_assn_freefire_ext");
	level.var_611["zmb_assassin_light_shellshock_ext"] = loadfx("vfx/zombie/abilities_perks/assn/zmb_dlc1_assn_shellshok_ext");
	level.var_611["zmb_assassin_light_camoflauge_ext"] = loadfx("vfx/zombie/abilities_perks/assn/zmb_dlc1_assn_camo_ext");
	level.var_611["zmb_assassin_light_frontline_int"] = loadfx("vfx/zombie/abilities_perks/assn/zmb_dlc1_assn_frontline_int");
	level.var_611["zmb_assassin_light_freefire_int"] = loadfx("vfx/zombie/abilities_perks/assn/zmb_dlc1_assn_freefire_int");
	level.var_611["zmb_assassin_light_shellshock_int"] = loadfx("vfx/zombie/abilities_perks/assn/zmb_dlc1_assn_shellshok_int");
	level.var_611["zmb_assassin_light_camoflauge_int"] = loadfx("vfx/zombie/abilities_perks/assn/zmb_dlc1_assn_camo_int");
}

//Function Number: 2
func_A26F(param_00,param_01,param_02)
{
	var_03 = param_00.var_A27C;
	var_04 = "";
	var_05 = 0;
	var_06 = 0;
	if(!isdefined(param_01))
	{
		param_01 = "spawn_drop";
	}

	if(!isdefined(var_03))
	{
		var_03 = spawnstruct();
		var_03.var_9919 = -1;
		var_03.var_ED2 = [];
		var_03.var_886 = [];
		param_00.var_A27C = var_03;
	}

	if(isdefined(var_03.var_886[param_01]))
	{
		return var_03.var_886[param_01];
	}

	var_07 = undefined;
	if(!isdefined(var_07))
	{
		var_07 = 15;
	}

	var_08 = getgroundposition(param_00.var_116,var_07,64,64);
	param_00.var_487C = var_08;
	if(!function_02E6(var_08))
	{
		var_04 = "Sky Spawner not on Nav Mesh for entities of radius " + var_07 + "\n";
		var_09 = getclosestpointonnavmesh(var_08);
		var_05 = 1;
	}

	if(!var_05)
	{
		foreach(var_0B in maps/mp/agents/_scripted_agent_anim_util::func_4081(param_01,"zombie_assassin",#animtree))
		{
			var_0C = getanimname(var_0B);
			var_0D = maps/mp/agents/_scripted_agent_anim_util::func_446A(var_0B);
			if(!animhasnotetrack(var_0B,"jump_start") || !animhasnotetrack(var_0B,"jump_end"))
			{
				continue;
			}

			var_0E = maps/mp/agents/_scripted_agent_anim_util::func_45B9(var_0B,"jump_end");
			if(var_0D <= var_0E)
			{
			}

			var_0F = getmovedelta(var_0B,var_0E,var_0D);
			var_10 = getangledelta(var_0B,var_0E,0);
			var_0F = rotatevector(var_0F,(0,var_10,0));
			var_11 = var_0F + var_08;
			if(function_02E6(var_11) && function_02DE(var_08,var_11))
			{
				var_03.var_ED2[var_0C] = 1;
				var_06++;
				continue;
			}

			var_04 = var_04 + var_0C + " does not fit on mesh for entities of radius " + var_07 + "\n";
		}
	}

	if(var_04 != "")
	{
		if(isdefined(param_02))
		{
			var_04 = param_02 + "\n" + var_04;
		}
	}

	var_03.var_886[param_01] = var_06 > 0;
	return var_03.var_886[param_01];
}

//Function Number: 3
init_assassin_vfx()
{
	common_scripts\utility::func_92C("zmi_assassin_armor_1","vfx/zombie/prototype_fx/zmi_assassin_armor_1");
	common_scripts\utility::func_92C("zmi_assassin_teleport","vfx/zombie/prototype_fx/assassin/teleport");
	common_scripts\utility::func_92C("zmi_assassin_buff","vfx/zombie/prototype_fx/assassin/zmb_buff");
	common_scripts\utility::func_92C("zmi_assassin_critical_hit","vfx/zombie/prototype_fx/assassin/critical_hit");
	common_scripts\utility::func_92C("zmb_assassin_light_frontline","vfx/zombie/prototype_fx/assassin/light_frontline");
	common_scripts\utility::func_92C("zmb_assassin_light_freefire","vfx/zombie/prototype_fx/assassin/light_freefire");
	common_scripts\utility::func_92C("zmb_assassin_light_shellshock","vfx/zombie/prototype_fx/assassin/light_shellshock");
	common_scripts\utility::func_92C("zmb_assassin_light_camoflauge","vfx/zombie/prototype_fx/assassin/light_camoflauge");
}

//Function Number: 4
seek_special_ability_use()
{
	return !common_scripts\utility::func_562E(self.specialoverheated) && there_is_close_player(250);
}

//Function Number: 5
assassin_stunning_burst_notetrack_handler(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.asn_notetrack_count))
	{
		self.asn_notetrack_count = 0;
	}

	switch(param_00)
	{
		case "footstep_walk_left_asn":
			self.asn_notetrack_count++;
			if(self.asn_notetrack_count > 1)
			{
				self.asn_notetrack_count = 0;
				thread spawn_an_aod();
			}
			break;
	}
}

//Function Number: 6
special_assassin_damaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
}

//Function Number: 7
activate_special_ability()
{
	thread recharge_special_ability(8);
}

//Function Number: 8
spawn_an_aod()
{
	var_00 = self.var_116;
	playfx(common_scripts\utility::func_44F5("stunning_burst_aoe"),var_00);
	lib_0378::func_8D74("aud_assassin_use_shell_shock");
	if(isdefined(self.custom_on_shellshock_func))
	{
		self thread [[ self.custom_on_shellshock_func ]]();
	}

	foreach(var_02 in level.var_744A)
	{
		if(!isalive(var_02))
		{
			continue;
		}

		if(common_scripts\utility::func_562E(var_02.var_5728))
		{
			continue;
		}

		if(distance2d(var_00,var_02.var_116) < 265 && abs(self.var_116[2] - var_02.var_116[2]) < 128)
		{
			var_03 = 3 * distance2d(var_00,var_02.var_116) / 265;
			var_04 = 4 * distance2d(var_00,var_02.var_116) / 265;
			var_02 thread run_shellshock(var_04,var_03,self.var_116);
			level notify("survivalist_blood_2_type_2_failed");
		}

		if(distance2d(var_00,var_02.var_116) > 185 || abs(self.var_116[2] - var_02.var_116[2]) > 128)
		{
			continue;
		}

		level notify("survivalist_blood_2_type_2_failed");
		var_02 dodamage(75,var_00);
	}
}

//Function Number: 9
run_shellshock(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 300;
	}

	self endon("death");
	self shellshock("zm_heavy_hit",param_00 * 1.4,param_01);
	self method_8308(0);
	self playrumbleonentity("damage_heavy");
	var_04 = self.var_116 - param_02;
	var_04 = (var_04[0],var_04[1],0);
	var_04 = param_03 * vectornormalize(var_04);
	var_04 = (var_04[0],var_04[1],125);
	self setvelocity(var_04);
	self method_8308(1);
	self.current_fog_state = undefined;
}

//Function Number: 10
init_assassin_phase_handler()
{
	var_00 = spawnstruct();
	var_00.var_3F02 = ::lib_0547::func_4B2C;
	var_00.var_A281 = 0;
	register_assassin_phase("Phase 1: Entrance","Phase 2: IDLE TRANSITION",::prowl_timeout_func,[0.2],["assassin_was_koed","zmb_assassin_is_alarmed"],[var_00]);
	register_assassin_phase("Phase 2: IDLE TRANSITION","Phase 2: IDLE",::assassin_begin_ambush,[],["assassin_was_koed","zmb_assassin_is_alarmed"],[var_00]);
	register_assassin_phase("Phase 2: IDLE","Phase 2: EXIT AMBUSH",::assassin_continue_ambush,[],["assassin_was_koed","zmb_assassin_is_alarmed"],[var_00]);
	register_assassin_phase("Phase 2: EXIT AMBUSH","Phase 3: ATTACK",::assassin_execute_ambush,[],["assassin_was_koed"],[var_00]);
	register_assassin_phase("Phase 3: ATTACK","Phase 4: EXITING",::assassin_continue_attack,[],["assassin_was_koed","zmb_assassin_fish_out_of_water"],[var_00]);
	register_assassin_phase("Phase 4: EXITING","Phase 3: ATTACK",::assassin_revert_to_phase_3,[],undefined,[var_00]);
}

//Function Number: 11
assassin_set_alarmed()
{
	common_scripts\utility::func_379A("zmb_assassin_is_alarmed");
}

//Function Number: 12
move_main()
{
	self endon("killanimscript");
	self method_839D("gravity");
	self.var_5759 = 1;
	if(isdefined(self.assassin_should_execute_voulnerability) && !common_scripts\utility::func_562E(self.isassassindemo))
	{
		setassassinvoulnerable();
	}
	else
	{
		maps/mp/agents/humanoid/_humanoid_move::func_92E9();
	}

	maps/mp/agents/humanoid/_humanoid_move::func_2603();
}

//Function Number: 13
setassassinvoulnerable()
{
	self notify("humanoidmove_endwait_ambush");
	self endon("humanoidmove_endwait_ambush");
	self endon("killanimscript");
	var_00 = 0;
	if(lib_0547::func_5565(self.assassin_should_execute_voulnerability,"idle_to_atk_asn"))
	{
		var_00 = 1;
	}

	var_01 = self.assassin_should_execute_voulnerability;
	self.assassin_should_execute_voulnerability = undefined;
	maps/mp/agents/humanoid/_humanoid_move::func_1F39("");
	self.var_1BB = 1;
	self method_839C("anim deltas");
	self scragentsetorientmode("face angle abs",self.var_1D);
	thread transition_to_motion(var_01);
	if(var_00)
	{
		childthread dodamageonjoints(["J_poker2_RI","J_poker2_LE"],30);
	}

	maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_01,0,1,"move_start");
	self notify("stop_joint_strike");
}

//Function Number: 14
transition_to_motion(param_00)
{
	var_01 = self method_83D8(param_00,0);
	var_02 = getanimlength(var_01);
	wait(var_02 * 0.55);
	self scragentsetorientmode("face enemy");
}

//Function Number: 15
register_assassin_phase(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.zmb_asn_agent_phases))
	{
		level.zmb_asn_agent_phases = [];
	}

	var_06 = spawnstruct();
	var_06.var_109 = param_00;
	var_06.next_phase = param_01;
	var_06.func_and_data = common_scripts\utility::func_F73([param_02],param_03);
	var_06.reasons_to_skip = param_04;
	var_06.reasons_to_block_progress = param_05;
	level.zmb_asn_agent_phases[var_06.var_109] = var_06;
}

//Function Number: 16
assassin_get_action_params()
{
	var_00 = lib_054D::func_AC22();
	var_00["action_table"] = "zombie_assassin";
	var_00["zombie_subtype"] = "zombie_assassin";
	var_00["move_speed"] = self.var_108;
	if(self.prowl_timer < 2 && common_scripts\utility::func_3794("Phase 1: Entrance"))
	{
		var_00["script_var"] = "looking_to_crouch";
	}
	else
	{
		var_00["script_var"] = "walk_to_sprint";
	}

	return var_00;
}

//Function Number: 17
assassin_think()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	common_scripts\utility::func_3799("zombie_passive");
	self method_85A1("zombie_assassin");
	self.phases = level.zmb_asn_agent_phases;
	self.nomutilate = 1;
	self.nopairmelee = 1;
	self.player_hit_list = [];
	self.var_56EB = 1;
	self.var_2FA4 = 0;
	self.var_509A = 1;
	self.var_6816 = 1;
	self.var_55AB = 1;
	self.var_562B = 1;
	self.customrecyclehandling = ::respawnanassassinzombie;
	self.maxstartmovespeed = lib_0547::milesperhour_to_inchespersec(1);
	self.cornerlessturnmindegreeoverride = 70;
	self.useprojectedturnlimiting = 1;
	common_scripts\utility::func_3799("ready_to_attack");
	self.my_ignore_players_list = [];
	lib_0566::func_ABB5();
	lib_0547::func_86C7(80);
	self.attackpointoffset = 28;
	self.var_66EC = 1;
	self.custom_on_melee_func = ::assassin_melee_extension;
	self.var_2FE3[16]["noFx"] = 1;
	childthread override_turn_func();
	childthread ghost_through_passives();
	thread handle_character_sighting_vo();
	self.prowl_timer = 4.75;
	init_my_phase_flags();
	common_scripts\utility::func_3799("Assassin did go idle");
	common_scripts\utility::func_3799("zmb_assassin_is_alarmed");
	common_scripts\utility::func_3799("assassin_was_koed");
	common_scripts\utility::func_3799("zmb_assassin_fish_out_of_water");
	childthread run_alarm_funcs();
	assign_initial_phase();
	var_00 = spawnstruct();
	var_00.check = ::assassin_has_teleported;
	var_00.var_3F02 = ::unset_assassin_has_teleported;
	var_01 = spawnstruct();
	var_01.check = ::assassin_needs_vfx_refresh;
	var_01.var_3F02 = ::assassin_vfx_refreshed;
	self.var_EAD.var_6AFE["move"] = ::move_main;
	self.assassin_melee_side = randomint(2);
	for(;;)
	{
		if(isdefined(self.custom_think_mode))
		{
			self [[ self.custom_think_mode ]]();
		}
		else
		{
			if(isdefined(self.var_3043) && !isdefined(self.has_lost_distractiondrone_interest))
			{
				childthread lose_interest_in_time(4.5,self.var_3043);
			}

			run_assassin_phase_logic();
			if(assassin_execute_attack())
			{
			}
			else if(lib_053C::func_4F9B())
			{
			}
			else if(lib_053C::func_4F9A())
			{
			}
			else
			{
				lib_053C::func_647();
			}
		}

		lib_0566::zombie_generic_think_wait();
	}
}

//Function Number: 18
assassin_needs_vfx_refresh()
{
	return common_scripts\utility::func_562E(self.assassin_should_refresh_boss_vfx);
}

//Function Number: 19
assassin_vfx_refreshed()
{
	self.assassin_should_refresh_boss_vfx = 0;
}

//Function Number: 20
assassin_has_teleported()
{
	return common_scripts\utility::func_562E(self.hasassassinteleported);
}

//Function Number: 21
set_assassin_has_teleported()
{
	self.hasassassinteleported = 1;
}

//Function Number: 22
unset_assassin_has_teleported()
{
	self.hasassassinteleported = 0;
}

//Function Number: 23
assassin_attack_cooldown(param_00)
{
	self endon("death");
	if(common_scripts\utility::func_562E(self.assassinragecooldown) && !common_scripts\utility::func_562E(param_00))
	{
		return;
	}

	self notify("new_assassin_cooldown");
	self endon("new_assassin_cooldown");
	self.assassinragecooldown = 1;
	common_scripts\utility::func_A70D(1.85,self,"damage");
	self.assassinragecooldown = 0;
}

//Function Number: 24
lose_interest_in_time(param_00,param_01)
{
	wait(param_00);
	self.has_lost_distractiondrone_interest = 1;
	while(isdefined(param_01))
	{
		wait 0.05;
	}

	self.has_lost_distractiondrone_interest = undefined;
}

//Function Number: 25
assassin_melee_extension()
{
	self endon("death");
	self endon("assassin_melee_done");
	childthread dodamageonjoints(["J_poker2_RI","J_poker2_LE"],30);
}

//Function Number: 26
play_emerge_fx()
{
	self endon("death");
	self notify("new_emerge_fx");
	self endon("new_emerge_fx");
	if(isdefined(self.my_emerge_fx))
	{
		self.my_emerge_fx delete();
	}

	while(!lib_0547::func_4B2C())
	{
		wait 0.05;
	}

	self.my_emerge_fx = play_fx_on_zmb_assassin("zmb_isl_fog_zmb_emerge_01","tag_origin");
}

//Function Number: 27
stop_emerge_fx()
{
	if(isdefined(self.my_emerge_fx))
	{
		self.my_emerge_fx delete();
		self.my_emerge_fx = undefined;
	}
}

//Function Number: 28
assassin_execute_attack()
{
	if(common_scripts\utility::func_3794("Phase 4: EXITING"))
	{
		return 0;
	}

	if(assassin_activate_special_ability())
	{
		thread assassin_attack_cooldown(1);
		try_to_make_assassin_leave();
		return 1;
	}

	if(assassin_begin_melee())
	{
		return 1;
	}

	if(lib_053C::func_4F84())
	{
		if(!isdefined(self.var_28D2.numstandinghits))
		{
			self.var_28D2.numstandinghits = 0;
		}

		self.var_28D2.numstandinghits++;
		if(self.var_28D2.numstandinghits > 1)
		{
			thread assassin_attack_cooldown();
			assassin_ignore_player(self.var_28D2);
			self.var_28D2.numstandinghits = 0;
		}

		thread finish_assassin_extened_melee();
		return 1;
	}

	return 0;
}

//Function Number: 29
try_to_make_assassin_leave()
{
	if(!isdefined(self.remaining_special_activations))
	{
		self.remaining_special_activations = 0;
	}

	self.remaining_special_activations = 999;
	self.remaining_special_activations--;
	if(self.remaining_special_activations <= 0)
	{
		thread make_assassin_leave_arena(4.5);
	}
}

//Function Number: 30
make_assassin_leave_arena(param_00)
{
	self endon("death");
	self endon("assassin_was_koed");
	if(common_scripts\utility::func_562E(self.assassinabilitysustained))
	{
		param_00 = param_00 / 2;
	}

	while(common_scripts\utility::func_562E(self.assassinabilitysustained))
	{
		wait 0.05;
	}

	self.is_being_asked_to_leave_soon = 1;
	disable_assassin_chest_fx();
	param_00 = lerp(param_00,param_00 * 2.15,1 / level.var_744A.size);
	wait(param_00);
	disable_assassin_chest_fx();
	self.is_being_asked_to_leave_soon = 0;
	self.assassinmuststopattackingandleave = 1;
}

//Function Number: 31
finish_assassin_extened_melee()
{
	self endon("death");
	wait(0.9);
	self notify("assassin_melee_done");
}

//Function Number: 32
enable_assassin_chest_fx()
{
	self.assassin_boss_vfx_disabled = 0;
	restart_assassin_boss_vfx();
}

//Function Number: 33
disable_assassin_chest_fx()
{
	self.assassin_boss_vfx_disabled = 1;
	remove_assassin_boss_vfx();
}

//Function Number: 34
on_boss_assassin_enter_fog()
{
	thread on_assassin_enter_fog();
	display_boss_assassin_chest_fx("ext");
}

//Function Number: 35
on_boss_assassin_exit_fog()
{
	thread on_assassin_exit_fog();
	display_boss_assassin_chest_fx("int");
}

//Function Number: 36
display_boss_assassin_chest_fx(param_00)
{
	if(common_scripts\utility::func_562E(self.assassin_boss_vfx_disabled))
	{
		return;
	}

	thread play_my_assassin_id_fx(param_00);
}

//Function Number: 37
remove_assassin_boss_vfx()
{
	if(isdefined(self.mod_fx))
	{
		self.mod_fx delete();
	}
}

//Function Number: 38
restart_assassin_boss_vfx()
{
	attach_assassin_mod_fx();
}

//Function Number: 39
on_assassin_enter_fog()
{
	thread play_emerge_fx();
}

//Function Number: 40
on_assassin_exit_fog()
{
	thread stop_emerge_fx();
}

//Function Number: 41
assign_initial_phase()
{
	wait 0.05;
	if(isdefined(self.optionalinitialstate))
	{
		set_assassin_phase(self.optionalinitialstate);
		return;
	}

	set_assassin_phase("Phase 1: Entrance");
}

//Function Number: 42
run_assassin_phase_logic()
{
	if(!assassin_is_in_fog())
	{
		if(!common_scripts\utility::func_562E(self.optionaldisablefogsensitivity))
		{
			self.assassinmustleave = 1;
			common_scripts\utility::func_379A("zmb_assassin_fish_out_of_water");
		}
	}

	foreach(var_01 in level.zmb_asn_agent_phases)
	{
		if(common_scripts\utility::func_3794(var_01.var_109))
		{
			phase_handler(var_01);
		}
	}
}

//Function Number: 43
wait_with_endon(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		self endon(var_03);
	}

	wait(param_00);
}

//Function Number: 44
assassin_activate_special_ability()
{
	if(isdefined(self.remaining_special_activations) && self.remaining_special_activations <= 0)
	{
		return 0;
	}

	if(maps/mp/agents/_scripted_agent_anim_util::func_57E2())
	{
		return 0;
	}

	if(!isdefined(self.assassin_special_wait))
	{
		self.assassin_special_wait = 1;
		thread activate_assassin_special_in_time(6.5);
	}

	if(common_scripts\utility::func_562E(self.dontwaitonfirstattack) || !common_scripts\utility::func_562E(self.assassin_special_wait) && (!common_scripts\utility::func_562E(self.assassinmustleave) || common_scripts\utility::func_562E(self.assassinmustneverleave)) && isdefined(self.assassin_seek_func) && [[ self.assassin_seek_func ]]() && common_scripts\utility::func_3794("zmb_assassin_is_alarmed") && !common_scripts\utility::func_3794("Phase 1: Entrance"))
	{
		if(common_scripts\utility::func_562E(self.dontwaitonfirstattack))
		{
			self.dontwaitonfirstattack = 0;
		}

		self thread [[ self.assassin_attack_func ]]();
		if(!common_scripts\utility::func_562E(self.reverse_assassin_specials_visuals))
		{
			disable_assassin_chest_fx();
		}
		else
		{
			enable_assassin_chest_fx();
		}

		lib_0547::func_7D1A("activate_assassin_ability");
		if(common_scripts\utility::func_562E(self.leaveafterspecial))
		{
			self.isassassindemo = 1;
			self.assassinmustleave = 1;
		}

		return 1;
	}

	return 0;
}

//Function Number: 45
activate_assassin_special_in_time(param_00)
{
	common_scripts\utility::func_379C("zmb_assassin_is_alarmed");
	wait(param_00);
	self.assassin_special_wait = 0;
}

//Function Number: 46
run_alarm_funcs()
{
	wait(0.125);
	if(!isdefined(self.aggrofuncsoverride))
	{
		self.aggrofuncs = spawnstruct();
		self.aggrofuncs.var_3F11 = [];
		self.aggrofuncs.var_3F11[self.aggrofuncs.var_3F11.size] = ::assassin_recieved_damage;
		self.aggrofuncs.var_3F11[self.aggrofuncs.var_3F11.size] = ::players_are_too_close;
		self.aggrofuncs.var_3F11[self.aggrofuncs.var_3F11.size] = ::assassin_ambush_has_timed_out;
		self.aggrofuncs.var_3F11[self.aggrofuncs.var_3F11.size] = ::assassin_wakeup_by_gunshot;
		self.aggrofuncs.var_3F11[self.aggrofuncs.var_3F11.size] = ::there_is_no_fog;
	}
	else
	{
		self.aggrofuncs = self.aggrofuncsoverride;
	}

	childthread alarm_assassin_on(self.aggrofuncs.var_3F11);
}

//Function Number: 47
assassin_begin_melee()
{
	if(maps/mp/agents/_scripted_agent_anim_util::func_57E2() || common_scripts\utility::func_562E(self.assassinragecooldown))
	{
		return 0;
	}

	self endon("death");
	if(common_scripts\utility::func_3794("ready_to_attack") && isdefined(self.var_28D2) && isplayer(self.var_28D2) && is_in_strike_range())
	{
		self.start_sprint_override = undefined;
		if(!lib_0547::has_scripted_state_queued("attack_sprint"))
		{
			thread lib_0547::func_7D1A("attack_sprint");
		}

		return 1;
	}

	return 0;
}

//Function Number: 48
is_in_strike_range()
{
	return distance(self.var_116,self.var_28D2.var_116) < 170 && distance(self.var_116,self.var_28D2.var_116) > 140 && maps\mp\_utility::func_3B8E(self,self.var_28D2,60);
}

//Function Number: 49
timeout_attack()
{
	wait(1);
	self notify("timeout");
}

//Function Number: 50
all_players_ignored()
{
	if(isdefined(self.var_A) && self.var_A == level.var_746E)
	{
		return 1;
	}

	if(!lib_053C::humanoid_has_valid_targets())
	{
		self.assassinmuststopattackingandleave = 1;
		return 1;
	}

	return 0;
}

//Function Number: 51
prowl_timeout_func(param_00)
{
	if(!lib_0547::func_5565(self.var_BA4,"traverse"))
	{
		self.prowl_timer = self.prowl_timer - param_00;
	}

	self.readytosprint = 0;
	if(common_scripts\utility::func_562E(self.isassassindemo))
	{
		return 1;
	}

	return self.prowl_timer <= 0;
}

//Function Number: 52
assassin_begin_ambush()
{
	self endon("death");
	if(common_scripts\utility::func_562E(self.optionaldisablecrouchedambush))
	{
		return 1;
	}

	self.ambush_scripted_state = "walk_2_crouch";
	lib_0547::func_7D1A(self.ambush_scripted_state);
	return 1;
}

//Function Number: 53
assassin_continue_ambush()
{
	if(common_scripts\utility::func_562E(self.optionaldisablecrouchedambush))
	{
		return 1;
	}

	self.ambush_scripted_state = get_action_for_assassin("Phase 2: IDLE","idle_stalk_player");
	childthread loop_crouch_position(self.ambush_scripted_state);
	common_scripts\utility::func_379C("zmb_assassin_is_alarmed");
	return 1;
}

//Function Number: 54
assassin_ready_attack(param_00)
{
	self endon("death");
	self endon("ready_to_attack");
	if(isdefined(param_00))
	{
		wait(param_00);
	}

	common_scripts\utility::func_379A("ready_to_attack");
}

//Function Number: 55
assassin_execute_ambush()
{
	self endon("death");
	if(!common_scripts\utility::func_562E(self.readytosprint) && !common_scripts\utility::func_562E(self.isassassindemo))
	{
		self.readytosprint = 1;
	}

	self.assassin_should_execute_voulnerability = "walk_to_sprint_asn";
	if(common_scripts\utility::func_3794("Assassin did go idle"))
	{
		if(should_assassin_lounge())
		{
			self.assassin_should_execute_voulnerability = "idle_to_atk_asn";
		}
		else
		{
			self.assassin_should_execute_voulnerability = "idle_to_vul_asn";
		}
	}

	if(should_move_main())
	{
		move_main();
	}

	if(isdefined(self.ambush_scripted_state))
	{
		preform_assassin_crouch_interrupt(self.ambush_scripted_state);
	}

	assassin_ready_attack();
	thread run_asssassin_active_timer();
	return 1;
}

//Function Number: 56
should_move_main()
{
	if(common_scripts\utility::func_562E(self.noflurry))
	{
		return 0;
	}

	var_00 = self method_8198();
	if(isdefined(var_00))
	{
		var_01 = var_00.var_116;
	}
	else
	{
		var_01 = self method_83E7();
	}

	return isdefined(var_01);
}

//Function Number: 57
run_asssassin_active_timer()
{
	self endon("death");
	self notify("new_timer");
	self endon("new_timer");
	if(!isdefined(self.assassinleveltimer))
	{
		self.assassinleveltimer = 0;
	}

	for(;;)
	{
		self.assassinleveltimer = self.assassinleveltimer + 1;
		wait(1);
	}
}

//Function Number: 58
loop_crouch_position(param_00)
{
	self endon("zmb_assassin_is_alarmed");
	lib_0547::func_7D1A(param_00);
}

//Function Number: 59
get_action_for_assassin(param_00,param_01)
{
	if(!isdefined(self.optionalassassinactionoverrides))
	{
		return param_01;
	}

	foreach(var_03 in self.optionalassassinactionoverrides)
	{
		if(lib_0547::func_5565(var_03.phase_flag,param_00))
		{
			return var_03.override_action;
		}
	}

	return param_01;
}

//Function Number: 60
assassin_continue_attack()
{
	self endon("death");
	if(common_scripts\utility::func_562E(self.isassassindemo))
	{
		self.assassinmustleave = 1;
		return 1;
	}

	if(common_scripts\utility::func_562E(self.assassinmuststopattackingandleave))
	{
		self.assassinmustleave = 1;
		return 1;
	}

	if(!isdefined(self.assassinattacktimeout))
	{
		childthread assassin_attack_timeout();
	}

	return self.assassinattacktimeout > 17.5 || all_players_ignored();
}

//Function Number: 61
assassin_revert_to_phase_3()
{
	if(!common_scripts\utility::func_562E(self.readytosprint))
	{
		self.readytosprint = 1;
	}

	self.assassinattacktimeout = undefined;
	self.has_exited = 1;
	init_assassin_phase_revert();
	var_00 = get_should_revert_to_previous_phase();
	if(common_scripts\utility::func_562E(var_00))
	{
		reset_assassin_intrests();
		self.assassinleveltimer = 0;
		return 1;
	}

	return var_00;
}

//Function Number: 62
get_should_revert_to_previous_phase()
{
	self endon("death");
	self.previoushole = self.var_1928;
	if(has_exits_disabled())
	{
		return 1;
	}

	if(is_close_enough_to_exit())
	{
		if(common_scripts\utility::func_3794("assassin_was_koed") || is_sunlight_exposed() || common_scripts\utility::func_562E(self.isassassindemo) || common_scripts\utility::func_562E(self.isfirstlethalassassin))
		{
			set_assassin_removed_from_game();
		}
		else
		{
			set_new_assassin_origin(self.var_1928);
		}

		return 1;
	}

	if(must_leave_by_exit())
	{
		return 0;
	}

	if(assassin_leave_has_timed_out())
	{
		return 1;
	}

	return 0;
}

//Function Number: 63
set_assassin_removed_from_game()
{
	while(lib_0547::func_5565(self.var_BA4,"traverse"))
	{
		wait 0.05;
	}

	killassassinzombie();
}

//Function Number: 64
killassassinzombie()
{
	self.var_6701 = 1;
	self.var_2A9D = "idle_noncombat";
	self dodamage(self.var_BC + 500000,self.var_116);
}

//Function Number: 65
set_new_assassin_origin(param_00)
{
	self endon("death");
	self.lastexitpoint = param_00;
	var_01 = get_valid_assassin_spawner(undefined,undefined,undefined,undefined,[param_00],1);
	while(lib_0547::func_5565(self.var_BA4,"traverse"))
	{
		wait 0.05;
	}

	var_02 = spawn("script_model",self.var_116);
	var_02 setmodel("tag_origin");
	self linkto(var_02);
	var_02 thread lib_0547::func_2D19(self);
	while(!lib_053C::humanoid_has_valid_targets(1))
	{
		wait 0.05;
	}

	self unlink();
	self setorigin(var_01.var_116);
	if(isdefined(var_02))
	{
		var_02 delete();
	}

	if(isdefined(var_01.var_1D))
	{
		self.var_1D = var_01.var_1D;
	}

	self.previoushole = var_01;
	set_assassin_has_teleported();
	playfxontag(common_scripts\utility::func_44F5("zmb_isl_assassin_spawn_wisp01"),self,"TAG_ORIGIN");
	self.assassinmustleave = undefined;
	if(lib_0547::func_5565(var_01.var_8109,"spawn_riser"))
	{
		self scragentsetscripted(1);
		var_03 = maps/mp/agents/_scripted_agent_anim_util::func_434D("spawn_riser");
		var_04 = maps/mp/agents/_scripted_agent_anim_util::func_7A35(var_03);
		self method_839C("anim deltas");
		self scragentsetorientmode("face angle abs",self.var_1D);
		maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_03,var_04,1,"spawn_riser");
		self scragentsetscripted(0);
	}
}

//Function Number: 66
assassin_attack_timeout()
{
	self notify("new_attack_timeout");
	self endon("new_attack_timeout");
	self.assassinattacktimeout = 0;
	while(isdefined(self.assassinattacktimeout))
	{
		self.assassinattacktimeout++;
		wait(1);
	}
}

//Function Number: 67
init_assassin_phase_revert()
{
	self endon("death");
	self.readytosprint = 1;
	childthread seek_assassin_level_exit();
	if(!isdefined(self.leavetimer))
	{
		thread timeout_assassin_leave();
	}
}

//Function Number: 68
assassin_leave_has_timed_out()
{
	return isdefined(self.leavetimer) && self.leavetimer > 7 && !lib_0547::func_5565(self.var_BA4,"traverse");
}

//Function Number: 69
player_presence_blocked_exit()
{
	return self.leavetimer >= 4.55 && !assassin_is_far_from_players() && !lib_0547::func_5565(self.var_BA4,"traverse");
}

//Function Number: 70
is_sunlight_exposed()
{
	return common_scripts\utility::func_3794("zmb_assassin_fish_out_of_water");
}

//Function Number: 71
has_exits_disabled()
{
	return common_scripts\utility::func_562E(self.optionaldisableexits);
}

//Function Number: 72
blocked_from_melee_lunge()
{
	return common_scripts\utility::func_562E(self.melee_cooldown);
}

//Function Number: 73
is_close_enough_to_exit()
{
	return isdefined(self.var_1928) && distance(self.var_116,self.var_1928.var_116) < 96;
}

//Function Number: 74
must_leave_by_exit()
{
	return common_scripts\utility::func_562E(self.assassinmustleave) || common_scripts\utility::func_562E(self.assassinmuststopattackingandleave);
}

//Function Number: 75
assassin_is_far_from_players()
{
	if(self.leavetimer >= 3.5)
	{
		foreach(var_01 in level.var_744A)
		{
			if(distance(self.var_116,var_01.var_116) < 512)
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 76
timeout_assassin_leave()
{
	self notify("new_timeout");
	self endon("new_timeout");
	self endon("death");
	self.leavetimer = 0;
	while(isdefined(self.leavetimer))
	{
		self.leavetimer = self.leavetimer + 0.1;
		wait(0.1);
	}
}

//Function Number: 77
reset_assassin_intrests()
{
	self.prowl_timer = 4.75;
	self.var_1928 = undefined;
	self.assassin_attack_enable = 0;
	self.leavetimer = undefined;
	self.looking_for_exit = undefined;
	self.assassinmuststopattackingandleave = undefined;
	self.my_ignore_players_list = [];
}

//Function Number: 78
seek_assassin_level_exit()
{
	self endon("death");
	if(isdefined(self.var_1928))
	{
		return;
	}

	self.var_1928 = seek_exit_that_maintains_momentum();
	while(!isdefined(self.var_1928))
	{
		self.var_1928 = seek_exit_that_maintains_momentum();
		wait 0.05;
	}

	self.var_1928 thread assassin_spawn_cooldown();
}

//Function Number: 79
seek_exit_that_maintains_momentum(param_00)
{
	self endon("death");
	var_01 = get_valid_assassin_exit_points(param_00);
	var_01 = common_scripts\utility::func_40B0(self.var_116,var_01);
	var_02 = [];
	var_03 = [];
	var_04 = [];
	var_05 = lib_055A::getagentzone();
	if(isdefined(var_05))
	{
		var_04 = lib_055A::getadjacentzones(var_05);
	}

	foreach(var_07 in var_01)
	{
		var_08 = var_07.var_819A;
		if(lib_0547::func_5565(var_05,var_08))
		{
			var_02 = common_scripts\utility::func_F6F(var_02,var_07);
			continue;
		}

		foreach(var_0A in var_04)
		{
			if(lib_0547::func_5565(var_0A.var_AC8A,var_08))
			{
				var_03 = common_scripts\utility::func_F6F(var_02,var_07);
			}
		}
	}

	if(var_02.size > 0)
	{
		return var_02[0];
	}

	if(var_03.size > 0)
	{
		return var_03[0];
	}

	return common_scripts\utility::func_7A33(var_01);
}

//Function Number: 80
get_valid_assassin_exit_points(param_00)
{
	var_01 = common_scripts\utility::func_46B7("zmb_assassin_spawnpoint","targetname");
	var_02 = [];
	var_03 = 0;
	var_04 = self.forcedzones;
	if(isdefined(level.zmb_locked_spawn_zones) && level.zmb_locked_spawn_zones.size > 0)
	{
		var_04 = level.zmb_locked_spawn_zones;
	}

	while(var_02.size == 0)
	{
		foreach(var_06 in var_01)
		{
			if(!issubstr(var_06.var_8260,"exit"))
			{
				if(common_scripts\utility::func_562E(param_00))
				{
					if(!issubstr(var_06.var_8260,"hc_escape"))
					{
						continue;
					}
				}
				else
				{
					continue;
				}
			}

			if(issubstr(var_06.var_8260,"disable"))
			{
				continue;
			}

			if(common_scripts\utility::func_562E(var_06.isassassincooling))
			{
				continue;
			}

			if(lib_0547::func_5565(self.previoushole,var_06) && distance(self.var_116,self.previoushole.var_116) < 512)
			{
				continue;
			}

			if(!lib_055A::func_586A(var_06.var_819A))
			{
				continue;
			}

			if(isdefined(var_04) && !common_scripts\utility::func_F79(var_04,var_06.var_819A))
			{
				continue;
			}

			var_02 = common_scripts\utility::func_F6F(var_02,var_06);
		}

		if(var_03)
		{
			break;
		}

		var_03 = 1;
	}

	return var_02;
}

//Function Number: 81
assassin_spawn_cooldown()
{
	self.isassassincooling = 1;
	wait(5);
	self.isassassincooling = 0;
}

//Function Number: 82
override_turn_func()
{
	wait 0.05;
}

//Function Number: 83
ghost_through_passives()
{
	for(;;)
	{
		var_00 = lib_0547::func_408F();
		foreach(var_02 in var_00)
		{
			if(common_scripts\utility::func_562E(self.squatting))
			{
				continue;
			}

			if(var_02 == self)
			{
				continue;
			}

			if(distance(self.var_116,var_02.var_116) > 64)
			{
				continue;
			}

			if(lib_0547::func_5565(var_02.var_A4B,"zombie_assassin"))
			{
				continue;
			}

			var_03 = 8 * vectornormalize(anglestoright(self.var_1D));
			var_04 = -8 * vectornormalize(anglestoright(self.var_1D));
			if(distance(var_02.var_116,self.var_116 + var_03) < distance(var_02.var_116,self.var_116 + var_04))
			{
				var_05 = getclosestpointonnavmesh(var_02.var_116 + var_03);
			}
			else
			{
				var_05 = getclosestpointonnavmesh(var_02.var_116 + var_04);
			}

			var_06 = 0;
			var_02 setorigin(var_05,var_06);
		}

		wait 0.05;
	}
}

//Function Number: 84
should_assassin_lounge()
{
	if(isdefined(self.var_A) && self.var_A == level.var_746E)
	{
		return 0;
	}

	foreach(var_01 in level.var_744A)
	{
		if(!isalive(var_01) || common_scripts\utility::func_562E(var_01.var_5728))
		{
			continue;
		}

		if(maps\mp\_utility::func_3B8E(self,var_01,35) && distance(self.var_116,var_01.var_116) < 250)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 85
set_assassin_phase(param_00)
{
	foreach(var_02 in self.phases)
	{
		common_scripts\utility::func_3796(var_02.var_109);
	}

	common_scripts\utility::func_379A(param_00);
}

//Function Number: 86
get_assassin_phase()
{
	foreach(var_01 in self.phases)
	{
		if(common_scripts\utility::func_3794(var_01.var_109))
		{
			return var_01.var_109;
		}
	}
}

//Function Number: 87
wait_for_close_player(param_00,param_01)
{
	self endon("death");
	self endon("zmb_assassin_is_alarmed");
	var_02 = 0;
	var_03 = 0;
	while(!var_03)
	{
		if(!assassin_has_valid_target())
		{
			return undefined;
		}

		foreach(var_05 in level.var_744A)
		{
			if(distance(var_05.var_116,self.var_116) < param_00)
			{
				return var_05;
			}
		}

		var_02 = var_02 + 0.125;
		if(isdefined(param_01))
		{
			if(var_02 >= param_01)
			{
				return;
			}
		}

		wait(0.125);
	}
}

//Function Number: 88
there_is_close_player(param_00)
{
	if(!assassin_has_valid_target())
	{
		return 0;
	}

	foreach(var_02 in level.var_744A)
	{
		if(distance(var_02.var_116,self.var_116) < param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 89
initalize_assassin_despawners()
{
	var_00 = common_scripts\utility::func_46B7("assassin_despawners","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = common_scripts\utility::func_46B7(var_02.var_1A2,"targetname");
		foreach(var_05 in var_03)
		{
			var_05.var_819A = var_02.var_819A;
		}
	}
}

//Function Number: 90
get_all_special_assassins()
{
	var_00 = ["zombie_assassin_frontline","zombie_assassin_freefire","zombie_assassin_shellshock","zombie_assassin_camoflauge"];
	return var_00;
}

//Function Number: 91
zombie_assassin_move_mode_func()
{
	if(!common_scripts\utility::func_562E(self.nochill) && common_scripts\utility::func_562E(self.assassinragecooldown) && !common_scripts\utility::func_3794("Phase 4: EXITING") && !common_scripts\utility::func_562E(self.assassinmustleave) && !common_scripts\utility::func_562E(self.assassinmuststopattackingandleave))
	{
		return "walk";
	}

	if(common_scripts\utility::func_562E(self.bossintroassassin))
	{
		return "walk";
	}

	if(!common_scripts\utility::func_562E(self.readytosprint) || common_scripts\utility::func_562E(self.isassassindemo) && !common_scripts\utility::func_562E(self.isassassindemocansprint))
	{
		return "walk";
	}

	return "sprint";
}

//Function Number: 92
init_my_phase_flags()
{
	foreach(var_01 in level.zmb_asn_agent_phases)
	{
		common_scripts\utility::func_3799(var_01.var_109);
	}
}

//Function Number: 93
is_boss_assassin()
{
	return !common_scripts\utility::func_562E(self.sgboss) && isdefined(self.assassin_modifier) && !lib_0547::func_5565(self.assassin_modifier,"zombie_assassin");
}

//Function Number: 94
func_9A01(param_00)
{
	self endon("assassin_has_meleed_players");
	wait(param_00);
	common_scripts\utility::func_379A("assassin_has_meleed_players");
}

//Function Number: 95
start_assassin_taunt()
{
	self endon("death");
	self endon("stop_assassin_vocals");
	while(isdefined(self))
	{
		var_00 = common_scripts\utility::func_7A33(level.var_744A);
		var_01 = randomint(256) - 128;
		var_02 = randomint(256) - 128;
		var_03 = randomint(256) - 128;
		var_04 = var_00.var_116 + (var_01,var_02,var_03);
		self.alarm = lib_0380::func_6842("zmb_movie_projector",undefined,var_00.var_116);
		wait(0.4);
		self.alarm method_863F(3.75);
		wait(4);
	}
}

//Function Number: 96
handle_character_sighting_vo()
{
}

//Function Number: 97
play_my_assassin_id_fx(param_00)
{
	while(self.var_106 == "tag_origin")
	{
		wait 0.05;
	}

	var_01 = get_my_assassin_fx();
	if(isdefined(var_01))
	{
		self.mod_fx_id = get_my_assassin_fx() + param_00;
		attach_assassin_mod_fx();
	}
}

//Function Number: 98
attach_assassin_mod_fx()
{
	remove_assassin_boss_vfx();
	if(!isdefined(self.mod_fx_id))
	{
		return;
	}

	self.mod_fx = play_fx_on_zmb_assassin(self.mod_fx_id,"J_Spine4");
}

//Function Number: 99
get_my_assassin_fx()
{
	var_00 = undefined;
	if(!isdefined(self.assassin_modifier))
	{
		return var_00;
	}

	switch(self.assassin_modifier)
	{
		case "zombie_assassin_frontline":
			var_00 = "zmb_assassin_light_frontline_";
			break;

		case "zombie_assassin_freefire":
			var_00 = "zmb_assassin_light_freefire_";
			break;

		case "zombie_assassin_shellshock":
			var_00 = "zmb_assassin_light_shellshock_";
			break;

		case "zombie_assassin_camoflauge":
			var_00 = "zmb_assassin_light_camoflauge_";
			break;

		case "zombie_assassin_hc":
			break;
	}

	return var_00;
}

//Function Number: 100
assassin_has_valid_target()
{
	var_00 = lib_053C::func_4F88();
	var_01 = var_00.size > 0 || isdefined(self.var_3043) || isdefined(self.var_1927) || isdefined(self.var_9B61);
	return var_01;
}

//Function Number: 101
alarm_assassin_on(param_00)
{
	self endon("death");
	self endon("zmb_assassin_is_alarmed");
	foreach(var_02 in param_00)
	{
		childthread assassin_alarm_listener(var_02,"zmb_assassin_is_alarmed");
	}
}

//Function Number: 102
assassin_alarm_listener(param_00,param_01)
{
	var_02 = self [[ param_00 ]]();
	self.isassassindemocansprint = 1;
	level notify("assassin_woken",self.var_116);
	common_scripts\utility::func_379A(param_01);
}

//Function Number: 103
assassin_is_in_daylight()
{
	return !assassin_is_in_fog();
}

//Function Number: 104
assassin_is_in_fog()
{
	return 1;
}

//Function Number: 105
there_is_no_fog()
{
	wait(1);
	while(assassin_is_in_fog())
	{
		wait(0.125);
	}

	return "Assassin Alarmed! FOG RECEDED!";
}

//Function Number: 106
assassin_recieved_damage()
{
	self waittill("damage");
	return "Assassin Alarmed! ASSASSIN TOOK DAMAGE!";
}

//Function Number: 107
players_are_too_close()
{
	var_00 = undefined;
	while(!isdefined(var_00) || distance(self.var_116,var_00.var_116) > 235)
	{
		if(isdefined(level.var_744A) && level.var_744A.size > 0)
		{
			var_00 = common_scripts\utility::func_4461(self.var_116,level.var_744A);
		}

		wait 0.05;
	}

	return "Assassin Alarmed! PLAYERS TOO CLOSE";
}

//Function Number: 108
assassin_ambush_has_timed_out()
{
	wait(34);
	return "Assassin Alarmed! PLAYERS TOOK TO LONG TO ALARM";
}

//Function Number: 109
assassin_wakeup_by_gunshot()
{
	self waittill("assassin_gunshot_wakup");
	return "Assassin Alarmed! NEARBY GUNSHOT";
}

//Function Number: 110
assassin_alarm_chain()
{
	for(;;)
	{
		level waittill("assassin_woken",var_00);
		if(distance(self.var_116,var_00) < 512)
		{
			break;
		}
	}
}

//Function Number: 111
assassin_notify_gunshot()
{
	self notify("assassin_gunshot_wakup");
}

//Function Number: 112
recharge_special_ability(param_00)
{
	self endon("death");
	self.specialoverheated = 1;
	wait(param_00 * 0.8);
	if(!common_scripts\utility::func_562E(self.reverse_assassin_specials_visuals))
	{
		enable_assassin_chest_fx();
	}

	wait(param_00 * 0.2);
	self.specialoverheated = 0;
}

//Function Number: 113
do_assassin_attack_anim()
{
	self endon("death");
	set_assassin_state_scripted();
	play_assassin_anim("assassin_activate_attack");
	unset_assassin_state_scripted();
}

//Function Number: 114
phase_handler(param_00)
{
	var_01 = assassin_has_excuse_to_skip(param_00);
	if(!var_01)
	{
		foreach(var_03 in param_00.reasons_to_block_progress)
		{
			if(self [[ var_03.var_3F02 ]]() == var_03.var_A281)
			{
				return;
			}
		}

		var_01 = common_scripts\utility::func_8134(param_00.func_and_data);
	}

	if(var_01)
	{
		set_assassin_phase(param_00.next_phase);
	}
}

//Function Number: 115
assassin_has_excuse_to_skip(param_00)
{
	if(!isdefined(param_00.reasons_to_skip))
	{
		return 0;
	}

	foreach(var_02 in param_00.reasons_to_skip)
	{
		if(common_scripts\utility::func_3794(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 116
assassin_strike_near_players(param_00,param_01)
{
	if(!isplayer(param_00))
	{
		return param_01;
	}

	if(distance(self.var_116,param_00.var_116) > 800)
	{
		return param_01;
	}

	var_02 = self.attackpointoffset * vectornormalize(anglestoforward(param_00 geteyeangles()));
	var_03 = var_02 + self.attackpointoffset * vectornormalize(anglestoright(param_00 geteyeangles()));
	var_04 = getclosestpointonnavmesh(param_00.var_116 + var_03,self);
	var_05 = var_02 + self.attackpointoffset * vectornormalize(anglestoright(param_00 geteyeangles() + (0,180,0)));
	var_06 = getclosestpointonnavmesh(param_00.var_116 + var_05,self);
	if(self.assassin_melee_side > 0)
	{
		return var_06;
	}

	return var_04;
}

//Function Number: 117
is_an_elite_assassin()
{
	return !lib_0547::func_5565(self.assassin_modifier,"zombie_assassin");
}

//Function Number: 118
report_damage(param_00,param_01)
{
	param_00 waittill("damage");
	level notify(param_01);
}

//Function Number: 119
init_assassin_vo_flags()
{
	common_scripts\utility::func_3C87("special_assassin_sighting");
	level.asn_dmg_flags = [];
	level.asn_dmg_flags["zombie_assassin"] = "zombie_assassinasn_damaged";
	level.asn_dmg_flags["zombie_assassin_frontline"] = "zombie_assassin_frontlineasn_damaged";
	level.asn_dmg_flags["zombie_assassin_freefire"] = "zombie_assassin_freefireasn_damaged";
	level.asn_dmg_flags["zombie_assassin_shellshock"] = "zombie_assassin_shellshockasn_damaged";
	level.asn_dmg_flags["zombie_assassin_camoflauge"] = "zombie_assassin_camoflaugeasn_damaged";
	foreach(var_01 in level.asn_dmg_flags)
	{
		common_scripts\utility::func_3C87(var_01);
	}
}

//Function Number: 120
zombie_assassin_on_damaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(common_scripts\utility::func_3794("assassin_was_koed"))
	{
		return;
	}

	if(isdefined(self.on_damage_override))
	{
		[[ self.on_damage_override ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
		return;
	}

	if(isdefined(self.assassin_special_damage_callback))
	{
		[[ self.assassin_special_damage_callback ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	}

	if(param_08 == "head" && param_05 != "panzerschreck_zm" && !issubstr(param_05,"fliegerfaust") && !issubstr(param_05,"tesla") && param_05 != "raven_sword_zm")
	{
		param_02 = param_02 * 0.8;
	}
	else if(param_05 != "panzerschreck_zm" && !issubstr(param_05,"fliegerfaust") && !issubstr(param_05,"tesla") && param_05 != "raven_sword_zm")
	{
		param_02 = param_02 * 0.6;
	}

	if(!is_boss_assassin() && !lib_0547::func_5565(self.var_BA4,"traverse") && common_scripts\utility::func_3794("Phase 3: ATTACK") || common_scripts\utility::func_3794("Phase 2: EXIT AMBUSH"))
	{
		if(!isdefined(self.headshotthreshold))
		{
			self.headshotthreshold = 0;
			thread headshot_drain();
		}

		if(!common_scripts\utility::func_562E(self.assassin_stunned))
		{
			if(lib_0547::func_5565(param_08,"head"))
			{
				self.headshotthreshold = self.headshotthreshold + 2.7 * param_02;
			}
			else
			{
				self.headshotthreshold = self.headshotthreshold + param_02;
			}

			if(!isdefined(self.assassin_stunned))
			{
				self.next_assassin_stun = self.var_FB * 0.15;
			}

			if(self.headshotthreshold > self.next_assassin_stun)
			{
				self.headshotthreshold = 0;
				self.next_assassin_stun = self.next_assassin_stun * 1.7;
				self endon("death");
				if(isdefined(self.var_28D2) && distance(self.var_116,self.var_28D2.var_116) < 170 && lib_0547::func_5565(self.var_BA4,"move"))
				{
					self.overrridehitreact = "s2_zom_asn_sprint_hitreact_left";
					self.overrridehitreact = "pain_sprint_lower";
				}

				lib_0547::func_7D1A("side_stumble_1_forward_left");
				childthread assassin_attack_cooldown(1);
				preform_assassin_ko_interrupt();
				assassin_ignore_player(param_01);
			}
		}
	}

	if(is_boss_assassin() && !common_scripts\utility::func_562E(self.enable_final_death))
	{
		if(!isdefined(self.assassin_boss_health))
		{
			self.assassin_boss_health = self.var_FB;
		}

		if(!isdefined(self.var_3794["assassin_was_koed"]) || common_scripts\utility::func_3794("assassin_was_koed"))
		{
			return;
		}

		if(isdefined(param_01) && isplayer(param_01))
		{
			if(lib_0547::func_5565(param_08,"head"))
			{
				param_01 thread maps\mp\gametypes\_damagefeedback::func_A102("headshot");
			}
			else
			{
				param_01 thread maps\mp\gametypes\_damagefeedback::func_A102("standard");
			}
		}

		self.assassin_boss_health = common_scripts\utility::func_98E7(self.assassin_boss_health - param_02 <= 0,0,self.assassin_boss_health - param_02);
		if(self.assassin_boss_health <= 0)
		{
			disable_assassin_chest_fx();
			self.activeassassinboss = 0;
			set_zombie_assassin_boss_ko();
			lib_0547::func_7D1A("side_stumble_1_forward_left");
		}

		return;
	}

	lib_054D::func_6BD1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
}

//Function Number: 121
should_target_others()
{
	if(level.var_744A.size == 1)
	{
		if(!isdefined(self.solo_ignore_counter))
		{
			self.solo_ignore_counter = 0;
		}

		if(self.solo_ignore_counter < 1)
		{
			self.solo_ignore_counter++;
			return 0;
		}
		else
		{
			self.solo_ignore_counter = 0;
			return 1;
		}
	}

	foreach(var_01 in level.var_744A)
	{
		if(lib_0547::func_5565(var_01,self.var_28D2))
		{
			continue;
		}

		if(common_scripts\utility::func_562E(var_01.var_5728))
		{
			continue;
		}

		if(lib_0547::func_5565(var_01.var_178,"spectator"))
		{
			continue;
		}

		if(distance(self.var_116,var_01.var_116) > 600)
		{
			continue;
		}

		return 1;
	}

	return 0;
}

//Function Number: 122
zombie_assassin_tesla_delayed_dmg(param_00,param_01,param_02)
{
	return param_00;
}

//Function Number: 123
remove_player_from_list_in_time(param_00)
{
	self endon("death");
	wait(6.5);
	if(isdefined(param_00) && isdefined(self.my_ignore_players_list))
	{
		self.my_ignore_players_list = common_scripts\utility::func_F93(self.my_ignore_players_list,param_00);
	}
}

//Function Number: 124
headshot_drain()
{
	self endon("death");
	for(;;)
	{
		self.headshotthreshold = self.headshotthreshold - int(100 * level.var_744A.size);
		if(self.headshotthreshold < 0)
		{
			self.headshotthreshold = 0;
		}

		wait(1);
	}
}

//Function Number: 125
set_zombie_assassin_boss_ko()
{
	self.optionalinitialstate = "Phase 4: EXITING";
	self.assassinmustleave = 1;
	self.assassinkillonexit = 1;
	common_scripts\utility::func_379A("zmb_assassin_is_alarmed");
	common_scripts\utility::func_379A("assassin_was_koed");
}

//Function Number: 126
play_assassin_anim(param_00)
{
	var_01 = param_00;
	var_02 = maps/mp/agents/_scripted_agent_anim_util::func_434D(var_01);
	var_03 = self method_83DB(var_02);
	var_04 = randomint(var_03);
	self scragentsetorientmode("face angle abs",self.var_1D);
	maps/mp/agents/_scripted_agent_anim_util::func_8415(var_02,var_04);
}

//Function Number: 127
set_assassin_state_scripted(param_00)
{
	self method_839C("anim deltas");
	self scragentsetscripted(1);
}

//Function Number: 128
unset_assassin_state_scripted()
{
	self scragentsetscripted(0);
}

//Function Number: 129
preform_assassin_walk_voulnerability()
{
	prepare_assassin_action("walk_2_sprint",undefined,"attack_anim");
	preform_assassin_walk_voulnerability_interrupt();
}

//Function Number: 130
preform_assassin_walk_voulnerability_interrupt()
{
	self scragentsetscripted(0);
	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"walk_2_sprint");
}

//Function Number: 131
preform_assassin_crouch_attack()
{
	prepare_assassin_action("assassin_spawn_attack");
	preform_assassin_crouch_attack_interrupt();
}

//Function Number: 132
preform_assassin_crouch_attack_interrupt()
{
	self scragentsetscripted(0);
	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"assassin_spawn_attack");
}

//Function Number: 133
preform_assassin_worship_1()
{
	prepare_assassin_action("assassin_worship_1");
	preform_assassin_worship_1_interrupt();
}

//Function Number: 134
preform_assassin_worship_1_interrupt()
{
	preform_assassin_crouch_interrupt("assassin_worship_1");
}

//Function Number: 135
preform_assassin_worship_2()
{
	prepare_assassin_action("assassin_worship_2");
	preform_assassin_worship_2_interrupt();
}

//Function Number: 136
preform_assassin_worship_2_interrupt()
{
	preform_assassin_crouch_interrupt("assassin_worship_2");
}

//Function Number: 137
preform_assassin_worship_3()
{
	prepare_assassin_action("assassin_worship_3");
	preform_assassin_worship_3_interrupt();
}

//Function Number: 138
preform_assassin_worship_3_interrupt()
{
	preform_assassin_crouch_interrupt("assassin_worship_3");
}

//Function Number: 139
preform_assassin_crouch_voulnerability()
{
	prepare_assassin_action("assassin_spawn_voulnerability");
	preform_assassin_crouch_voulnerability_interrupt();
}

//Function Number: 140
preform_assassin_crouch_voulnerability_interrupt()
{
	self scragentsetscripted(0);
	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"idle_stalk_player");
}

//Function Number: 141
preform_assassin_trans_to_crouch()
{
	transition_to_assassin_idle();
	preform_assassin_trans_to_crouch_interrupt();
}

//Function Number: 142
transition_to_assassin_idle()
{
	self endon("death");
	self endon("zmb_assassin_is_alarmed");
	if(common_scripts\utility::func_562E(self.skipped_straight_to_idle))
	{
		lib_053C::func_6CE(getclosestpointonnavmesh(self.var_116,self));
	}

	prepare_assassin_action("walk_2_crouch",undefined,undefined);
	common_scripts\utility::func_379A("Assassin did go idle");
}

//Function Number: 143
preform_assassin_trans_to_crouch_interrupt()
{
	common_scripts\utility::func_379A("Assassin did go idle");
	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"walk_2_crouch");
}

//Function Number: 144
preform_assassin_crouch()
{
	thread prepare_assassin_action("idle_stalk_player");
	common_scripts\utility::func_379C("zmb_assassin_is_alarmed");
	preform_assassin_crouch_interrupt();
	return 1;
}

//Function Number: 145
preform_assassin_crouch_interrupt(param_00)
{
	self scragentsetscripted(0);
	if(isdefined(param_00))
	{
		maps/mp/agents/_scripted_agent_anim_util::func_8732(0,param_00);
		return;
	}

	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"idle_stalk_player");
}

//Function Number: 146
preform_assassin_ko()
{
	self.assassin_stunned = 1;
	prepare_assassin_action("side_stumble_1_forward_left");
	preform_assassin_ko_interrupt();
}

//Function Number: 147
preform_assassin_idle()
{
	prepare_assassin_action("idle_noncombat");
	preform_assassin_idle_interrupt();
}

//Function Number: 148
preform_assassin_idle_interrupt()
{
	self scragentsetscripted(0);
	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"idle_noncombat");
}

//Function Number: 149
preform_assassin_ko_interrupt()
{
	self scragentsetscripted(0);
	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"side_stumble_1_forward_left");
	self.assassin_stunned = 0;
}

//Function Number: 150
preform_assassin_ability()
{
	prepare_assassin_action(self.assassinabilityactivateaction,self.assassinabilityactivateactionnotetrackhandler);
	preform_assassin_ability_interrupt();
}

//Function Number: 151
preform_assassin_ability_interrupt()
{
	self.hasassassinspecialed = 1;
	self scragentsetscripted(0);
	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,self.assassinabilityactivateaction);
}

//Function Number: 152
preform_assassin_strike()
{
	prepare_assassin_action("attack_sprint");
	preform_assassin_strike_interrupt();
}

//Function Number: 153
preform_assassin_strike_interrupt()
{
	self scragentsetscripted(0);
	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"attack_sprint");
}

//Function Number: 154
prepare_assassin_action(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = "scripted_anim";
	}

	if(isdefined(self.overrridehitreact))
	{
		param_00 = self.overrridehitreact;
		self.overrridehitreact = undefined;
	}

	self scragentsetscripted(1);
	self.var_1BB = 1;
	maps/mp/agents/_scripted_agent_anim_util::func_8732(1,param_00);
	var_03 = maps/mp/agents/_scripted_agent_anim_util::func_434D(param_00);
	var_04 = self method_83DB(var_03);
	var_05 = randomint(var_04);
	if(!isdefined(self.forcedtarget) && isdefined(self.player_facing_times) && isdefined(self.player_facing_times[param_00]))
	{
		thread handle_facing_player(self.player_facing_times[param_00]);
	}
	else
	{
		self scragentsetorientmode("face angle abs",self.var_1D);
	}

	self method_839C("anim deltas");
	if(isdefined(self.additional_anim) && self.additional_anim[1] == param_00)
	{
		[[ self.additional_anim[0] ]]();
		self.additional_anim = undefined;
	}

	maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_03,var_05,1,param_02,undefined,param_01);
}

//Function Number: 155
handle_facing_player(param_00)
{
	self scragentsetorientmode("face enemy");
	wait(param_00);
	self scragentsetorientmode("face angle abs",self.var_1D);
}

//Function Number: 156
play_fx_on_zmb_assassin(param_00,param_01)
{
	var_02 = spawnlinkedfx(common_scripts\utility::func_44F5(param_00),self,param_01);
	maps/mp/agents/_agent_utility::deleteentonagentdeath(var_02);
	triggerfx(var_02);
	return var_02;
}

//Function Number: 157
init_scripted_states()
{
	var_00 = 3.75;
	var_01 = 4;
	lib_0547::func_7BD0("walk_2_crouch",::preform_assassin_trans_to_crouch,::preform_assassin_trans_to_crouch_interrupt,3.75 + lerp(var_00,var_01,0.04));
	lib_0547::func_7BD0("idle_stalk_player",::preform_assassin_crouch,::preform_assassin_crouch_interrupt,3.75 + lerp(var_00,var_01,0.04));
	lib_0547::func_7BD0("assassin_worship_1",::preform_assassin_worship_1,::preform_assassin_worship_1_interrupt,3.75 + lerp(var_00,var_01,0.04));
	lib_0547::func_7BD0("assassin_worship_2",::preform_assassin_worship_2,::preform_assassin_worship_2_interrupt,3.75 + lerp(var_00,var_01,0.04));
	lib_0547::func_7BD0("assassin_worship_3",::preform_assassin_worship_3,::preform_assassin_worship_3_interrupt,3.75 + lerp(var_00,var_01,0.04));
	lib_0547::func_7BD0("assassin_spawn_voulnerability",::preform_assassin_crouch_voulnerability,::preform_assassin_crouch_voulnerability_interrupt,3.75 + lerp(var_00,var_01,0.08));
	lib_0547::func_7BD0("assassin_spawn_attack",::preform_assassin_crouch_attack,::preform_assassin_crouch_attack_interrupt,3.75 + lerp(var_00,var_01,0.08));
	lib_0547::func_7BD0("walk_2_sprint",::preform_assassin_walk_voulnerability,::preform_assassin_walk_voulnerability_interrupt,3.75 + lerp(var_00,var_01,0.08));
	lib_0547::func_7BD0("activate_assassin_ability",::preform_assassin_ability,::preform_assassin_ability_interrupt,3.75 + lerp(var_00,var_01,0.16));
	lib_0547::func_7BD0("side_stumble_1_forward_left",::preform_assassin_ko,::preform_assassin_ko_interrupt,3.75 + lerp(var_00,var_01,0.2));
	lib_0547::func_7BD0("attack_sprint",::zombie_assassin_charge_run,undefined,3.75 + lerp(var_00,var_01,0.12),::zombie_assassin_charge_cleanup);
	lib_0547::func_7BD0("idle_noncombat",::preform_assassin_idle,::preform_assassin_idle_interrupt,3.75 + lerp(var_00,var_01,0.24));
}

//Function Number: 158
zombie_assassin_charge_run()
{
	self endon("stop assassin strike");
	self endon("death");
	var_00 = self.var_28D2;
	var_01 = self.var_116;
	self scragentsetscripted(1);
	self.var_1BB = 1;
	maps/mp/agents/_scripted_agent_anim_util::func_8732(1,"attack_sprint");
	common_scripts\utility::func_3796("ready_to_attack");
	var_02 = 1;
	var_03 = undefined;
	var_04 = 0;
	childthread dodamageonjoints(["J_poker2_RI","J_poker2_LE"],30,1);
	maps/mp/agents/humanoid/_humanoid_melee::func_3107(var_00,var_00.var_116,"attack_run_asn",0,0,1,var_04,undefined);
	maps/mp/agents/humanoid/_humanoid_move::func_86CF("sprint");
}

//Function Number: 159
assassin_ignore_player(param_00)
{
	if(!should_target_others())
	{
		return;
	}

	if(common_scripts\utility::func_F79(self.my_ignore_players_list,param_00))
	{
		return;
	}

	self.my_ignore_players_list = common_scripts\utility::func_F6F(self.my_ignore_players_list,param_00);
	thread remove_player_from_list_in_time(param_00);
}

//Function Number: 160
dodamageonjoints(param_00,param_01,param_02)
{
	self notify("new_joint_strike");
	self endon("new_joint_strike");
	self endon("stop_joint_strike");
	var_03 = [];
	wait(0.15);
	for(;;)
	{
		wait 0.05;
		foreach(var_05 in param_00)
		{
			var_06 = get_final_joint_origin(var_05);
			foreach(var_08 in level.var_744A)
			{
				var_09 = distance2d(var_08.var_116,var_06);
				var_0A = abs(var_08.var_116[2] - var_06[2]);
				if(!common_scripts\utility::func_F79(var_03,var_08) && var_09 < param_01 && var_0A < 230 && var_08.var_116[2] < var_06[2])
				{
					if(common_scripts\utility::func_562E(param_02) && randomint(100) > 30)
					{
						thread assassin_attack_cooldown();
					}

					var_03 = common_scripts\utility::func_F6F(var_03,var_08);
					var_08 dodamage(90,var_06,self,self,"MOD_IMPACT");
					assassin_ignore_player(var_08);
				}
			}
		}
	}
}

//Function Number: 161
get_final_joint_origin(param_00)
{
	return self gettagorigin(param_00) + 42 * vectornormalize(anglestoforward(self gettagangles(param_00)));
}

//Function Number: 162
zombie_assassin_charge_cleanup()
{
	self scragentsetscripted(0);
	self method_85E0(0);
	self method_839D("gravity");
	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"attack_sprint");
	thread assassin_ready_attack(2.5);
	self notify("stop assassin strike");
}

//Function Number: 163
zombie_assassin_spawn_voulnerability_cleanup()
{
	self scragentsetscripted(0);
	self method_85E0(0);
	self method_839D("gravity");
}

//Function Number: 164
init_assassin_spawns_and_exits()
{
	var_00 = common_scripts\utility::func_46B7("zmb_assassin_spawnpoint","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread wait_for_activation();
	}

	initalize_assassin_despawners();
}

//Function Number: 165
wait_for_activation()
{
	wait 0.05;
	self.assassin_spawn_activated = 0;
	if(isdefined(self.var_819A) && common_scripts\utility::func_3C83(self.var_819A))
	{
		common_scripts\utility::func_3C9F(self.var_819A);
	}

	self.assassin_spawn_activated = 1;
}

//Function Number: 166
spawn_an_assassin(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(param_02))
	{
		var_0C = get_valid_assassin_spawner(undefined,isdefined(param_00) && param_00 != "zombie_assassin",param_0B);
		if(!isdefined(var_0C))
		{
			var_0C = get_valid_assassin_spawner(undefined,isdefined(param_00) && param_00 != "zombie_assassin",param_0B,0);
		}
	}
	else
	{
		var_0C = param_03;
	}

	if(!isdefined(param_00) || param_00 == "zombie_assassin")
	{
		param_0A = "default look";
	}
	else
	{
		param_0A = "boss look";
	}

	var_0C thread cool_down();
	var_0D = lib_054D::func_90BA("zombie_assassin",var_0C,"assassin_spawn",0,1,0,param_0A);
	if(!isdefined(param_00) || param_00 == "zombie_assassin")
	{
		var_0D.assassin_modifier = "zombie_assassin";
	}
	else
	{
		var_0D.assassin_modifier = param_00;
	}

	if(!isdefined(var_0D.var_9024) && isdefined(var_0C.var_819A))
	{
		var_0D.var_9024 = var_0C.var_819A;
	}

	if(isdefined(param_0B))
	{
		var_0D.forcedzones = param_0B;
	}

	if(isdefined(param_07))
	{
		var_0D.optionalassassinactionoverrides = param_07;
	}

	if(isdefined(param_04))
	{
		var_0D.optionalinitialstate = param_04;
	}

	if(isdefined(param_05))
	{
		var_0D.optionaldisablefogsensitivity = param_05;
	}

	if(isdefined(param_06))
	{
		var_0D.optionaldisableexits = param_06;
	}

	if(isdefined(param_08))
	{
		var_0D.aggrofuncsoverride = param_08;
	}

	if(isdefined(param_09))
	{
		var_0D.optionaldisablecrouchedambush = param_09;
	}

	if(isdefined(param_01))
	{
		var_0D.var_FB = int(param_01);
		var_0D.var_BC = int(var_0D.var_FB);
	}
	else if(var_0D.var_BC <= 17500)
	{
		var_0D.var_FB = int(17500);
		var_0D.var_BC = int(var_0D.var_FB);
	}
	else
	{
	}

	if(common_scripts\utility::func_562E(param_03))
	{
		var_0D lib_0547::func_84CB();
	}

	var_0D.previoushole = var_0C;
	var_0D.lastassassinspawner = var_0C;
	var_0D apply_assassin_boss_modifier();
	return var_0D;
}

//Function Number: 167
apply_assassin_boss_modifier()
{
	switch(self.assassin_modifier)
	{
		case "zombie_assassin":
			break;

		case "zombie_assassin_frontline":
			self.var_2A9D = "death_stand_elt";
			self.assassinabilityactivateaction = "assassin_activate_attack";
			self.assassin_seek_func = ::maps/mp/zombies/zombie_assassin_frontline_basic::seek_special_ability_use;
			self.assassin_attack_func = ::maps/mp/zombies/zombie_assassin_frontline_basic::activate_special_ability;
			self.assassin_special_damage_callback = ::maps/mp/zombies/zombie_assassin_frontline_basic::special_assassin_damaged;
			self.mod_fx_id = get_my_assassin_fx() + "ext";
			attach_assassin_mod_fx();
			break;

		case "zombie_assassin_freefire":
			self.var_2A9D = "death_stand_elt";
			self.assassinabilityactivateaction = "assassin_active_shoot_straight";
			self.assassinabilityactivateactionnotetrackhandler = ::maps/mp/zombies/zombie_assassin_freefire_basic::assassin_throw_notetrack_handler;
			self.assassin_seek_func = ::maps/mp/zombies/zombie_assassin_freefire_basic::seek_special_ability_use;
			self.assassin_attack_func = ::maps/mp/zombies/zombie_assassin_freefire_basic::activate_special_ability;
			self.assassin_special_damage_callback = ::special_assassin_damaged;
			self.mod_fx_id = get_my_assassin_fx() + "ext";
			attach_assassin_mod_fx();
			break;

		case "zombie_assassin_shellshock":
			self.var_2A9D = "death_stand_elt";
			self.assassinabilityactivateaction = "assassin_active_stunning_burst";
			self.assassinabilityactivateactionnotetrackhandler = ::maps/mp/zombies/zombie_assassin_shellshock_basic::assassin_stunning_burst_notetrack_handler;
			self.assassin_seek_func = ::maps/mp/zombies/zombie_assassin_shellshock_basic::seek_special_ability_use;
			self.assassin_attack_func = ::maps/mp/zombies/zombie_assassin_shellshock_basic::activate_special_ability;
			self.assassin_special_damage_callback = ::maps/mp/zombies/zombie_assassin_shellshock_basic::special_assassin_damaged;
			self.mod_fx_id = get_my_assassin_fx() + "ext";
			attach_assassin_mod_fx();
			break;

		case "zombie_assassin_camoflauge":
			self.var_2A9D = "death_stand_elt";
			self.assassinabilityactivateaction = "assassin_activate_attack";
			self.assassinabilityactivateactionnotetrackhandler = ::maps/mp/zombies/zombie_assassin_camoflauge_basic::assassin_camo_notetrack_handler;
			self.assassin_seek_func = ::maps/mp/zombies/zombie_assassin_camoflauge_basic::seek_special_ability_use;
			self.assassin_attack_func = ::maps/mp/zombies/zombie_assassin_camoflauge_basic::activate_special_ability;
			self.assassin_special_damage_callback = ::maps/mp/zombies/zombie_assassin_camoflauge_basic::special_assassin_damaged;
			self.mod_fx_id = get_my_assassin_fx() + "ext";
			attach_assassin_mod_fx();
			break;
	}
}

//Function Number: 168
get_valid_assassin_spawner(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_00))
	{
		var_06 = [];
		var_07 = undefined;
		foreach(var_09 in level.var_744A)
		{
			if(!isalive(var_09) || common_scripts\utility::func_562E(var_09.var_5378))
			{
				continue;
			}

			var_06 = common_scripts\utility::func_F6F(var_06,var_09);
		}

		if(var_06.size)
		{
			param_00 = common_scripts\utility::func_7A33(var_06).var_116;
		}
	}

	var_0B = [];
	var_0C = common_scripts\utility::func_46B7("zmb_assassin_spawnpoint","targetname");
	foreach(var_0E in var_0C)
	{
		if(!lib_0547::func_5565(var_0E.var_165,"zombie_sky_spawner") && !lib_0547::func_5565(var_0E.var_165,"zombie_spawner"))
		{
			continue;
		}

		if(isdefined(param_04) && common_scripts\utility::func_F79(param_04,var_0E))
		{
			continue;
		}

		if(!issubstr(var_0E.var_8260,"spawn"))
		{
			continue;
		}

		if(issubstr(var_0E.var_8260,"disable"))
		{
			continue;
		}

		if(issubstr(var_0E.var_8260,"respawn_only") && !common_scripts\utility::func_562E(param_05))
		{
			continue;
		}

		if(common_scripts\utility::func_562E(param_03) && common_scripts\utility::func_562E(var_0E.isassassincooling))
		{
			continue;
		}

		if(common_scripts\utility::func_562E(var_0E.assassin_spawn_activated) || lib_0547::func_5565(var_0E.var_819A,"start_zone"))
		{
			var_0B = common_scripts\utility::func_F6F(var_0B,var_0E);
		}
	}

	var_10 = get_ideal_spawner_near_origin(var_0B,param_00,param_02);
	var_10 thread assassin_spawn_cooldown();
	return var_10;
}

//Function Number: 169
get_ideal_spawner_near_origin(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = [];
	var_05 = [];
	var_06 = undefined;
	var_07 = [];
	if(isdefined(param_01))
	{
		var_03 = common_scripts\utility::func_40B0(param_01,param_00);
		var_06 = lib_055A::func_4562(param_01);
		if(isdefined(var_06))
		{
			var_07 = lib_055A::getadjacentzones(var_06);
		}
	}
	else
	{
		var_03 = common_scripts\utility::func_F92(param_00);
	}

	foreach(var_09 in var_03)
	{
		var_0A = var_09.var_819A;
		if(isdefined(param_02))
		{
			if(common_scripts\utility::func_F79(param_02,var_09.var_819A) && !common_scripts\utility::func_562E(var_09.isassassincooling))
			{
				var_05 = common_scripts\utility::func_F6F(var_05,var_09);
			}

			continue;
		}

		if(lib_0547::func_5565(var_06,var_0A) && !common_scripts\utility::func_562E(var_09.isassassincooling))
		{
			var_04 = common_scripts\utility::func_F6F(var_04,var_09);
			continue;
		}

		foreach(var_0C in var_07)
		{
			if(lib_0547::func_5565(var_0C.var_AC8A,var_0A) && !common_scripts\utility::func_562E(var_09.isassassincooling))
			{
				var_05 = common_scripts\utility::func_F6F(var_05,var_09);
			}
		}
	}

	if(var_04.size > 0)
	{
		return var_04[0];
	}

	if(var_05.size > 0)
	{
		return var_05[0];
	}

	return common_scripts\utility::func_7A33(var_03);
}

//Function Number: 170
cool_down()
{
	self notify("new_cooldown");
	self endon("new_cooldown");
	self.recentspawn = 1;
	wait(4);
	self.recentspawn = 0;
}

//Function Number: 171
respawnanassassinzombie()
{
	var_00 = self.var_BC;
	var_01 = common_scripts\utility::func_46B7("zombie_assassin_pagan_room_spawner","targetname");
	var_02 = spawn_an_assassin(undefined,var_00);
	killassassinzombie();
}