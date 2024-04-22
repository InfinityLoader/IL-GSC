/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_civilians.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 54
 * Decompile Time: 774 ms
 * Timestamp: 4/22/2024 2:31:48 AM
*******************************************************************/

//Function Number: 1
ie_poolhouse_civilian_vignettes()
{
	if(!isdefined(level.civilian_body_and_head_setup))
	{
		civilian_head_and_body_setup();
	}

	common_scripts\utility::flag_init("civilians_pool_alerted");
	maps\_utility::array_spawn_function_targetname("civilian_pool_spawner",::civilian_pool_spawner_setup,"civilians_pool");
	var_00 = maps\_utility::array_spawn_targetname("civilian_pool_spawner",1);
	level.active_civilians = common_scripts\utility::array_combine(level.active_civilians,var_00);
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.script_noteworthy))
		{
			if(var_02.script_noteworthy == "civilian_pool_1")
			{
				var_02 civilian_head_and_body_swap(level.civilian_urban_male_b);
				level.civilian_pool_1 = var_02;
			}

			if(var_02.script_noteworthy == "civilian_pool_2")
			{
				var_02 civilian_head_and_body_swap(level.civilian_urban_male_d);
				level.civilian_pool_2 = var_02;
			}

			if(var_02.script_noteworthy == "civilian_pool_3")
			{
				var_02 civilian_head_and_body_swap(level.civilian_urban_female_a);
				level.civilian_pool_3 = var_02;
			}

			if(var_02.script_noteworthy == "civilian_pool_4")
			{
				var_02 civilian_head_and_body_swap(level.civilian_urban_male_e);
			}
		}
	}

	thread civilian_pool_vo();
	common_scripts\utility::flag_wait("player_in_estate");
	maps\_utility::array_spawn_function_targetname("civilian_poolhouse_spawner",::civilian_pool_spawner_setup,"civilians_poolhouse");
	var_04 = maps\_utility::array_spawn_targetname("civilian_poolhouse_spawner",1);
	level.active_civilians = common_scripts\utility::array_combine(level.active_civilians,var_04);
	foreach(var_02 in var_04)
	{
		if(isdefined(var_02.script_noteworthy))
		{
			if(var_02.script_noteworthy == "civilian_poolhouse_1")
			{
				level.civilian_poolhouse_1 = var_02;
				level.civilian_poolhouse_1.no_below_vo = 1;
			}

			if(var_02.script_noteworthy == "civilian_poolhouse_2")
			{
				level.civilian_poolhouse_2 = var_02;
				level.civilian_poolhouse_2.no_below_vo = 1;
			}

			if(var_02.script_noteworthy == "civilian_poolhouse_3")
			{
				level.civilian_poolhouse_3 = var_02;
				level.civilian_poolhouse_3.no_below_vo = 1;
			}
		}
	}

	thread civilian_poolhouse_vo("emp_detonated");
	common_scripts\utility::flag_wait("penthouse_start");
	if(!common_scripts\utility::flag("civilian_poolhouse_conversation"))
	{
		thread civilian_poolhouse_vo("player_enters_front_yard_save_2");
	}
}

//Function Number: 2
civilian_pool_spawner_setup(param_00)
{
	self endon("death");
	self endon("alerted");
	self.animname = "generic";
	self.allowdeath = 1;
	var_01 = common_scripts\utility::getstruct(self.script_noteworthy + "_struct","targetname");
	thread civilian_alert_watcher("player_enters_front_yard_save_2",param_00,"civilians_pool_alerted");
	thread civilian_alert_behavior("player_enters_front_yard_save_2",var_01);
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "civilian_poolhouse_1")
	{
		civilian_head_and_body_swap(level.civilian_african_male_d);
		var_02 = spawn("script_model",(0,0,0));
		var_02 setmodel("base_pool_stick_01");
		var_02 linkto(self,"tag_weapon_right",(0,0,0),(0,0,0));
		thread poolhouse_prop_cleanup(var_02);
		self.fovcosinez = cos(20);
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "civilian_poolhouse_2")
	{
		civilian_head_and_body_swap(level.civilian_african_male_c);
		var_02 = spawn("script_model",(0,0,0));
		var_02 setmodel("base_pool_stick_01");
		var_02 linkto(self,"tag_weapon_left",(0,0,0),(0,0,0));
		thread poolhouse_prop_cleanup(var_02);
		self.fovcosinez = cos(20);
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "civilian_poolhouse_3")
	{
		civilian_head_and_body_swap(level.civilian_urban_male_e);
		var_03 = spawn("script_model",(0,0,0));
		var_03 setmodel("cellphone_kit_03");
		var_03 linkto(self,"tag_inhand",(0,-1,-3),(0,180,0));
		thread poolhouse_prop_cleanup(var_03);
		self.fovcosinez = cos(20);
	}

	var_01 thread maps\_anim::anim_loop_solo(self,self.script_noteworthy,"stop_loop");
	common_scripts\utility::flag_wait("player_enters_front_yard_save_2");
	self delete();
}

//Function Number: 3
poolhouse_prop_cleanup(param_00)
{
	common_scripts\utility::flag_wait_either("civilians_pool_alerted","player_enters_front_yard_save_2");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 4
civilian_pool_vo()
{
	level endon("emp_detonated");
	level.civilian_pool_1 endon("death");
	level.civilian_pool_2 endon("death");
	level.civilian_pool_3 endon("death");
	common_scripts\utility::flag_wait("civilian_pool_conversation");
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	level endon("_stealth_spotted");
	level.civilian_pool_1 thread stop_civilian_conversation("emp_detonated");
	level.civilian_pool_2 thread stop_civilian_conversation("emp_detonated");
	level.civilian_pool_3 thread stop_civilian_conversation("emp_detonated");
	level.civilian_pool_3 maps\_utility::smart_dialogue("ie_cf1_cleanedup");
	level.civilian_pool_1 maps\_utility::smart_dialogue("ie_cm1_itsamazing");
	level.civilian_pool_1 maps\_utility::smart_dialogue("ie_cf1_radiation");
	level.civilian_pool_1 maps\_utility::smart_dialogue("ie_cm1_newbusinesses");
	level.civilian_pool_3 maps\_utility::smart_dialogue("ie_cf1_bankrupt");
	level.civilian_pool_1 maps\_utility::smart_dialogue("ie_cm1_techsector");
	level.civilian_pool_3 maps\_utility::smart_dialogue("ie_cf1_terroristcell");
	level.civilian_pool_1 maps\_utility::smart_dialogue("ie_cm1_pissedoff");
	level.civilian_pool_3 maps\_utility::smart_dialogue("ie_cf1_the99");
	level.civilian_pool_1 maps\_utility::smart_dialogue("ie_cm1_reinventeddetroit");
	level.civilian_pool_3 maps\_utility::smart_dialogue("ie_cf1_takingcredit");
	level.civilian_pool_1 maps\_utility::smart_dialogue("ie_cm1_notpublicly");
	level.civilian_pool_3 maps\_utility::smart_dialogue("ie_cf1_laughter5");
	level.civilian_pool_1 maps\_utility::smart_dialogue("ie_cm1_fema");
	level.civilian_pool_3 maps\_utility::smart_dialogue("ie_cf1_disgraceful");
}

//Function Number: 5
civilian_poolhouse_vo(param_00)
{
	level endon(param_00);
	level.civilian_poolhouse_1 endon("death");
	level.civilian_poolhouse_2 endon("death");
	level.civilian_poolhouse_3 endon("death");
	common_scripts\utility::flag_wait("civilian_poolhouse_conversation");
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	level endon("_stealth_spotted");
	level.civilian_poolhouse_1 thread stop_civilian_conversation(param_00);
	level.civilian_poolhouse_2 thread stop_civilian_conversation(param_00);
	level.civilian_poolhouse_3 thread stop_civilian_conversation(param_00);
	level.civilian_poolhouse_1 maps\_utility::smart_dialogue("ie_cm1_rematchstill");
	level.civilian_poolhouse_2 maps\_utility::smart_dialogue("ie_cm2_brightearly");
	level.civilian_poolhouse_3 maps\_utility::smart_dialogue("ie_cm3_bettingnow");
	level.civilian_poolhouse_2 maps\_utility::smart_dialogue("ie_cm2_runtennis");
	level.civilian_poolhouse_3 maps\_utility::smart_dialogue("ie_cm3_yelling");
	level.civilian_poolhouse_2 maps\_utility::smart_dialogue("ie_cm2_asskicked");
	level.civilian_poolhouse_3 maps\_utility::smart_dialogue("ie_cm3_playedcollege");
	level.civilian_poolhouse_1 maps\_utility::smart_dialogue("ie_cm1_rightnow");
	level.civilian_poolhouse_3 maps\_utility::smart_dialogue("ie_cm3_thishour");
	level.civilian_poolhouse_2 maps\_utility::smart_dialogue("ie_cm2_sweetsetup");
	level.civilian_poolhouse_1 maps\_utility::smart_dialogue("ie_cm1_fastyoumove");
	level.civilian_poolhouse_3 maps\_utility::smart_dialogue("ie_cm3_thatnice");
	level.civilian_poolhouse_2 maps\_utility::smart_dialogue("ie_cm2_winner");
	level.civilian_poolhouse_3 maps\_utility::smart_dialogue("ie_cm3_youmeanyou");
	level.civilian_poolhouse_2 thread maps\_utility::smart_dialogue("ie_cm2_laughter3");
	wait(0.25);
	level.civilian_poolhouse_3 maps\_utility::smart_dialogue("ie_cm3_laughter1");
	level.civilian_poolhouse_1 maps\_utility::smart_dialogue("ie_cm1_hilarious2");
	level.civilian_poolhouse_2 maps\_utility::smart_dialogue("ie_cm2_calmdown");
}

//Function Number: 6
ie_west_civilian_vignettes()
{
	if(!isdefined(level.civilian_body_and_head_setup))
	{
		civilian_head_and_body_setup();
	}

	thread civilian_walker_phone();
	thread civilian_guesthouse();
	thread civilian_drone_scan_scene();
	thread civilian_garage();
	thread civilian_right_side();
	thread civilian_in_running_car();
	thread civilian_driveway_scene();
}

//Function Number: 7
civilian_walker_phone()
{
	level endon("player_enters_front_yard_save_2");
	common_scripts\utility::flag_init("civilian_walker_phone_alerted");
	common_scripts\utility::flag_init("civilian_walker_phone_delete");
	common_scripts\utility::flag_wait("spawn_civilian_walker_phone");
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	maps\_utility::array_spawn_function_targetname("civilian_walker_phone_spawner",::civilian_walker_phone_spawner_setup);
	var_00 = maps\_utility::array_spawn_targetname("civilian_walker_phone_spawner",1);
	level.active_civilians = common_scripts\utility::array_combine(level.active_civilians,var_00);
	wait 0.05;
	var_01 = spawn("script_model",(0,0,0));
	var_01 setmodel("cellphone_kit_03");
	var_01 linkto(var_00[0],"tag_weapon_right",(0,0,0),(0,0,0));
	common_scripts\utility::flag_wait_any("civilian_walker_phone_delete","civilian_walker_phone_alerted");
	var_01 delete();
}

//Function Number: 8
civilian_walker_phone_spawner_setup()
{
	self endon("death");
	self endon("alerted");
	self.animname = "generic";
	self.allowdeath = 1;
	civilian_head_and_body_swap(level.civilian_urban_female_c);
	thread phone_conversation();
	thread stop_civilian_conversation("civilian_walker_phone_delete");
	maps\_utility::clear_run_anim();
	maps\_utility::set_run_anim("patrol_walk_lady_phone");
	self.patrol_walk_anim = "patrol_walk_lady_phone";
	var_00 = common_scripts\utility::getstruct("civilian_walker_phone_struct","targetname");
	thread civilian_alert_watcher("civilian_walker_phone_delete",undefined,"civilian_walker_phone_alerted");
	thread civilian_alert_behavior("civilian_walker_phone_delete",var_00,1,"civilian_walker_phone");
	common_scripts\utility::flag_wait("civilian_walker_phone");
	var_01 = 0;
	var_02 = getentarray("civilian_walker_phone_delete_volume","targetname");
	foreach(var_04 in var_02)
	{
		if(!level.player istouching(var_04))
		{
			var_01++;
			if(var_01 == 2)
			{
				if(!maps\_utility::player_can_see_ai(self))
				{
					common_scripts\utility::flag_set("civilian_walker_phone_delete");
					self delete();
					return;
				}
			}
		}
	}

	common_scripts\utility::flag_wait("player_enters_front_yard_save_4");
	self delete();
}

//Function Number: 9
phone_conversation()
{
	self endon("death");
	self endon("alerted");
	wait(1);
	maps\_utility::smart_dialogue("ie_lrn_hello");
	wait(1);
	maps\_utility::smart_dialogue("ie_lrn_howareyou");
	wait(2);
	maps\_utility::smart_dialogue("ie_lrn_plentyoftime");
	wait(2);
	maps\_utility::smart_dialogue("ie_lrn_uhhuh");
	wait(2);
	maps\_utility::smart_dialogue("ie_lrn_Iknow");
	wait(2);
	maps\_utility::smart_dialogue("ie_lrn_rightexactly");
	wait(1);
	maps\_utility::smart_dialogue("ie_lrn_somethingstrange");
	wait(3);
	maps\_utility::smart_dialogue("ie_lrn_doesyourhusband");
	wait(1);
	maps\_utility::smart_dialogue("ie_lrn_notaproblem");
	wait(2);
	maps\_utility::smart_dialogue("ie_lrn_uhhuh");
	wait(3);
	maps\_utility::smart_dialogue("ie_lrn_rightexactly");
	wait(4);
	maps\_utility::smart_dialogue("ie_lrn_Iknow");
}

//Function Number: 10
civilian_guesthouse()
{
	common_scripts\utility::flag_init("civilians_guesthouse_alerted");
	maps\_utility::array_spawn_function_targetname("civilian_guesthouse_spawner",::civilian_guesthouse_spawner_setup);
	var_00 = maps\_utility::array_spawn_targetname("civilian_guesthouse_spawner",1);
	level.active_civilians = common_scripts\utility::array_combine(level.active_civilians,var_00);
	thread civilian_guesthouse_vo();
	common_scripts\utility::flag_wait_either("spawn_civilian_guesthouse_walkin","player_enters_front_yard_save_4");
	if(common_scripts\utility::flag("_stealth_spotted") || common_scripts\utility::flag("civilians_guesthouse_alerted") || common_scripts\utility::flag("player_enters_front_yard_save_4"))
	{
		return;
	}

	maps\_utility::array_spawn_function_targetname("civilian_guesthouse_walkin_spawner",::civilian_guesthouse_walkin_spawner_setup);
	var_01 = maps\_utility::array_spawn_targetname("civilian_guesthouse_walkin_spawner",1);
	level.active_civilians = common_scripts\utility::array_combine(level.active_civilians,var_01);
	wait 0.05;
	var_02 = spawn("script_model",(0,0,0));
	var_02 setmodel("cellphone_kit_03");
	var_02 linkto(var_01[0],"tag_inhand",(0,0,0),(0,0,0));
	common_scripts\utility::flag_wait_any("player_enters_front_yard_save_4","civilians_guesthouse_alerted","civilian_guesthouse_walkin_transition");
	if(common_scripts\utility::flag("civilian_guesthouse_walkin_transition"))
	{
		wait(3);
	}

	var_02 delete();
}

//Function Number: 11
civilian_guesthouse_spawner_setup()
{
	self endon("death");
	self endon("alerted");
	self.animname = "generic";
	self.allowdeath = 1;
	var_00 = common_scripts\utility::getstruct(self.script_noteworthy + "_struct","targetname");
	thread civilian_alert_watcher("player_enters_front_yard_save_5","civilians_guesthouse","civilians_guesthouse_alerted");
	thread civilian_alert_behavior("player_enters_front_yard_save_5",var_00,undefined,undefined,1);
	if(self.script_noteworthy == "civilian_guesthouse_1")
	{
		civilian_head_and_body_swap(level.civilian_african_male_d);
		level.civilian_guesthouse_1 = self;
		self.fovcosinez = cos(20);
		self.react_anim = self.script_noteworthy + "_react";
	}

	if(self.script_noteworthy == "civilian_guesthouse_2")
	{
		civilian_head_and_body_swap(level.civilian_urban_male_c);
		level.civilian_guesthouse_2 = self;
		self.fovcosinez = cos(20);
		self.react_anim = self.script_noteworthy + "_react";
	}

	if(self.script_noteworthy == "civilian_guesthouse_3")
	{
		civilian_head_and_body_swap(level.civilian_urban_female_b);
		level.civilian_guesthouse_3 = self;
		self.fovcosinez = cos(20);
		self.react_anim = self.script_noteworthy + "_react";
	}

	var_00 thread maps\_anim::anim_loop_solo(self,self.script_noteworthy,"stop_loop");
	common_scripts\utility::flag_wait("player_enters_front_yard_save_5");
	self delete();
}

//Function Number: 12
civilian_guesthouse_vo()
{
	level endon("player_enters_front_yard_save_5");
	level.civilian_guesthouse_1 endon("death");
	level.civilian_guesthouse_2 endon("death");
	level.civilian_guesthouse_3 endon("death");
	common_scripts\utility::flag_wait("civilian_guesthouse_conversation");
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	level endon("_stealth_spotted");
	level.civilian_guesthouse_1 thread stop_civilian_conversation("player_enters_front_yard_save_5");
	level.civilian_guesthouse_2 thread stop_civilian_conversation("player_enters_front_yard_save_5");
	level.civilian_guesthouse_3 thread stop_civilian_conversation("player_enters_front_yard_save_5");
	level.civilian_guesthouse_1 maps\_utility::smart_dialogue("ie_cm1_stock");
	level.civilian_guesthouse_2 maps\_utility::smart_dialogue("ie_cm2_closeeye");
	level.civilian_guesthouse_3 maps\_utility::smart_dialogue("ie_cf1_evertalk");
	level.civilian_guesthouse_1 maps\_utility::smart_dialogue("ie_cm1_moneyrules");
	level.civilian_guesthouse_2 maps\_utility::smart_dialogue("ie_cm2_damnlucky");
	level.civilian_guesthouse_3 maps\_utility::smart_dialogue("ie_cf1_guylikeirons");
	level.civilian_guesthouse_1 maps\_utility::smart_dialogue("ie_cm1_richashell");
	level.civilian_guesthouse_3 maps\_utility::smart_dialogue("ie_cf1_hopingtosee");
	level.civilian_guesthouse_1 maps\_utility::smart_dialogue("ie_cm1_appearance");
	level.civilian_guesthouse_2 maps\_utility::smart_dialogue("ie_cm2_backhalf");
	level.civilian_guesthouse_3 maps\_utility::smart_dialogue("ie_cf1_moredrinks");
}

//Function Number: 13
civilian_guesthouse_walkin_spawner_setup()
{
	self endon("death");
	self endon("alerted");
	self.animname = "generic";
	self.allowdeath = 1;
	civilian_head_and_body_swap(level.civilian_urban_male_d);
	level.civilian_guesthouse_walkin = self;
	thread civilian_guesthouse_walkin_vo();
	thread stop_civilian_conversation("player_enters_front_yard_save_5");
	var_00 = common_scripts\utility::getstruct("civilian_guesthouse_walkin_transition_struct","targetname");
	thread civilian_alert_watcher("player_enters_front_yard_save_5","civilians_guesthouse","civilians_guesthouse_alerted");
	thread civilian_alert_behavior("civilian_guesthouse_walkin_transition",var_00,1,"civilian_guesthouse_walkin_transition");
	common_scripts\utility::flag_wait("civilian_guesthouse_walkin_transition");
	if(!isdefined(self.alerted))
	{
		self.fovcosine = cos(65);
		self.at_path_end = 1;
		self notify("end patrol");
		wait 0.05;
		thread civilian_alert_behavior("player_enters_front_yard_save_5",var_00,undefined,undefined,1);
		maps\_anim::anim_generic_gravity(self,"ie_frontyard_cellphone_transition");
		thread maps\_anim::anim_loop_solo(self,"hms_greece_market_civ_idle_02","stop_loop");
	}

	common_scripts\utility::flag_wait("player_enters_front_yard_save_5");
	self delete();
}

//Function Number: 14
civilian_guesthouse_walkin_vo()
{
	level endon("player_enters_front_yard_save_5");
	level.civilian_guesthouse_walkin endon("death");
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	level endon("_stealth_spotted");
	level.civilian_guesthouse_walkin thread stop_civilian_conversation("player_enters_front_yard_save_5");
	level.civilian_garage_1 maps\_utility::smart_dialogue("ie_cm1_headingover");
	level.civilian_garage_1 maps\_utility::smart_dialogue("ie_cm1_lovesshow");
	wait(1);
	level.civilian_garage_1 maps\_utility::smart_dialogue("ie_cm1_6season");
	wait(1);
	level.civilian_garage_1 maps\_utility::smart_dialogue("ie_cm1_yeahiknow");
	wait(1);
	level.civilian_garage_1 maps\_utility::smart_dialogue("ie_cm1_explainednumbers");
	level.civilian_garage_1 maps\_utility::smart_dialogue("ie_cm1_gottago");
	wait(1);
	level.civilian_garage_1 maps\_utility::smart_dialogue("ie_cm1_later2");
}

//Function Number: 15
civilian_drone_scan_scene()
{
	common_scripts\utility::flag_init("civilians_drone_scan_alerted");
	common_scripts\utility::flag_init("civilians_drone_scan_start_vo");
	common_scripts\utility::flag_init("civilians_drone_scan_end_vo");
	common_scripts\utility::flag_wait("start_civilian_drone_scan_scene");
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	level.civilian_drone_scan_anim_struct = common_scripts\utility::getstruct("civilian_drone_scan_anim_struct","targetname");
	maps\_utility::array_spawn_function_targetname("drone_scan_civilian",::drone_scan_civilian_setup);
	var_00 = maps\_utility::array_spawn_targetname("drone_scan_civilian",1);
	level.active_civilians = common_scripts\utility::array_combine(level.active_civilians,var_00);
	thread garage_side_door();
	thread civilian_drone_scan_vo();
	var_01 = vehicle_scripts\_pdrone_security::drone_spawn_and_drive("drone_scan_drone");
	common_scripts\utility::flag_wait("drone_scan_drone_scan");
	foreach(var_03 in var_01)
	{
		var_03 thread vehicle_scripts\_pdrone_security::drone_investigate_scan();
		var_03.scantime = 0.4;
		common_scripts\utility::flag_wait("drone_scan_drone_continue");
		var_03 notify("drone_investigate");
	}
}

//Function Number: 16
drone_scan_civilian_setup()
{
	self endon("death");
	self.animname = "generic";
	self.allowdeath = 1;
	self endon("alerted");
	if(self.script_noteworthy == "drone_scan_female")
	{
		civilian_head_and_body_swap(level.civilian_urban_female_a);
		level.civilian_drone_scan_female = self;
	}
	else
	{
		civilian_head_and_body_swap(level.civilian_african_male_b);
		level.civilian_drone_scan_male = self;
	}

	thread civilian_alert_watcher(undefined,"drone_scan_civilians","civilians_drone_scan_alerted");
	thread civilian_alert_behavior(undefined,level.civilian_drone_scan_anim_struct,undefined,undefined,1);
	if(self.script_noteworthy == "drone_scan_female")
	{
		level.civilian_drone_scan_anim_struct maps\_anim::anim_single_solo(self,"civilian_drone_scan_enter_" + self.script_noteworthy);
	}
	else
	{
		level.civilian_drone_scan_anim_struct thread maps\_anim::anim_single_solo(self,"civilian_drone_scan_enter_" + self.script_noteworthy);
		wait(8);
		common_scripts\utility::flag_set("civilians_drone_scan_start_vo");
		self waittillmatch("end","single anim");
	}

	level.civilian_drone_scan_anim_struct thread maps\_anim::anim_loop_solo(self,"civilian_drone_scan_loop_" + self.script_noteworthy,"stop_loop");
	wait(2);
	common_scripts\utility::flag_set("drone_scan_drone_continue");
	wait(1);
	level.civilian_drone_scan_anim_struct notify("stop_loop");
	maps\_utility::anim_stopanimscripted();
	if(self.script_noteworthy == "drone_scan_female")
	{
		level.civilian_drone_scan_anim_struct maps\_anim::anim_single_solo(self,"civilian_drone_scan_exit_" + self.script_noteworthy);
	}
	else
	{
		level.civilian_drone_scan_anim_struct thread maps\_anim::anim_single_solo(self,"civilian_drone_scan_exit_" + self.script_noteworthy);
		wait(4);
		common_scripts\utility::flag_set("civilians_drone_scan_end_vo");
		self waittillmatch("end","single anim");
	}

	self forceteleport(self.origin,(self.angles[0],self.angles[1] + 1,self.angles[2]));
	maps\_anim::anim_single_solo(self,"holding_hands_walk_" + self.script_noteworthy);
	self forceteleport(self.origin,(self.angles[0],self.angles[1] + 1,self.angles[2]));
	maps\_anim::anim_single_solo(self,"holding_hands_walk_" + self.script_noteworthy);
	self forceteleport(self.origin,(self.angles[0],self.angles[1] + 1,self.angles[2]));
	maps\_anim::anim_single_solo(self,"holding_hands_walk_" + self.script_noteworthy);
	self forceteleport(self.origin,(self.angles[0],self.angles[1] + 1,self.angles[2]));
	maps\_anim::anim_single_solo(self,"holding_hands_walk_" + self.script_noteworthy);
	self forceteleport(self.origin,(self.angles[0],self.angles[1] + 1,self.angles[2]));
	maps\_anim::anim_single_solo(self,"holding_hands_walk_" + self.script_noteworthy);
	self forceteleport(self.origin,(self.angles[0],self.angles[1] - 1,self.angles[2]));
	maps\_anim::anim_single_solo(self,"holding_hands_walk_" + self.script_noteworthy);
	self forceteleport(self.origin,(self.angles[0],self.angles[1] - 1,self.angles[2]));
	maps\_anim::anim_single_solo(self,"holding_hands_walk_" + self.script_noteworthy);
	self forceteleport(self.origin,(self.angles[0],self.angles[1] - 1,self.angles[2]));
	maps\_anim::anim_single_solo(self,"holding_hands_walk_" + self.script_noteworthy);
	self forceteleport(self.origin,(self.angles[0],self.angles[1] - 1,self.angles[2]));
	maps\_anim::anim_single_solo(self,"holding_hands_walk_" + self.script_noteworthy);
	self forceteleport(self.origin,(self.angles[0],self.angles[1] - 1,self.angles[2]));
	maps\_anim::anim_single_solo(self,"holding_hands_walk_" + self.script_noteworthy);
	maps\_anim::anim_single_solo(self,"holding_hands_walk_" + self.script_noteworthy);
	maps\_anim::anim_single_solo(self,"holding_hands_walk_" + self.script_noteworthy);
	maps\_anim::anim_single_solo(self,"holding_hands_walk_" + self.script_noteworthy);
	maps\_anim::anim_single_solo(self,"holding_hands_walk_" + self.script_noteworthy);
	maps\_anim::anim_generic_gravity(self,"holding_hands_walk_" + self.script_noteworthy);
	maps\_anim::anim_generic_gravity(self,"holding_hands_end_transition_" + self.script_noteworthy);
	thread maps\_anim::anim_loop_solo(self,"holding_hands_end_" + self.script_noteworthy);
	common_scripts\utility::flag_wait("player_entered_balcony_door");
	self delete();
}

//Function Number: 17
garage_side_door()
{
	var_00 = maps\_utility::spawn_anim_model("drone_scan_prop");
	var_01 = getent("garage_side_door","targetname");
	level.civilian_drone_scan_anim_struct maps\_anim::anim_first_frame_solo(var_00,"drone_scan_enter_door");
	var_02 = getent("garage_side_door_clip","targetname");
	var_02 linkto(var_00,"J_prop_1");
	var_01 linkto(var_00,"J_prop_1");
	level.civilian_drone_scan_anim_struct maps\_anim::anim_single_solo(var_00,"drone_scan_enter_door");
	var_02 connectpaths();
}

//Function Number: 18
civilian_drone_scan_vo()
{
	level endon("player_entered_balcony_door");
	level.civilian_drone_scan_female endon("death");
	level.civilian_drone_scan_male endon("death");
	common_scripts\utility::flag_wait("civilians_drone_scan_start_vo");
	level endon("_stealth_spotted");
	level.civilian_drone_scan_female thread stop_civilian_conversation("player_entered_balcony_door");
	level.civilian_drone_scan_male thread stop_civilian_conversation("player_entered_balcony_door");
	level.civilian_drone_scan_male maps\_utility::smart_dialogue("ie_cm1_holdstill");
	wait(0.5);
	level.civilian_drone_scan_female maps\_utility::smart_dialogue("ie_cf1_whatisitdoing");
	level.civilian_drone_scan_male maps\_utility::smart_dialogue("ie_cm1_dontmove");
	common_scripts\utility::flag_wait("civilians_drone_scan_end_vo");
	level.civilian_drone_scan_male maps\_utility::smart_dialogue("ie_cm1_letsgo");
	wait(0.5);
	level.civilian_drone_scan_female maps\_utility::smart_dialogue("ie_cf1_creepy");
}

//Function Number: 19
civilian_garage()
{
	common_scripts\utility::flag_init("civilian_garage_1");
	common_scripts\utility::flag_init("civilian_garage_2");
	common_scripts\utility::flag_init("civilians_garage_alerted");
	common_scripts\utility::flag_wait("spawn_garage_civilians");
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	level.garage_anim_struct = common_scripts\utility::getstruct("garage_anim_struct","targetname");
	maps\_utility::array_spawn_function_targetname("civilian_garage_spawner",::civilian_garage_spawner_setup);
	var_00 = maps\_utility::array_spawn_targetname("civilian_garage_spawner",1);
	level.active_civilians = common_scripts\utility::array_combine(level.active_civilians,var_00);
	common_scripts\utility::flag_wait("start_car_lift_scene");
	wait(1);
	thread car_lift();
	thread civilian_garage_vo();
}

//Function Number: 20
civilian_garage_spawner_setup()
{
	self endon("death");
	self endon("alerted");
	self.animname = "generic";
	self.allowdeath = 1;
	if(self.script_noteworthy == "civilian_garage_1")
	{
		civilian_head_and_body_swap(level.civilian_urban_male_b);
		level.civilian_garage_1 = self;
	}
	else
	{
		civilian_head_and_body_swap(level.civilian_urban_male_e);
		level.civilian_garage_2 = self;
	}

	thread civilian_alert_watcher("start_car_lift_scene","civilians_garage","civilians_garage_alerted");
	thread civilian_alert_behavior("start_car_lift_scene",level.garage_anim_struct,undefined,undefined,1);
	level.garage_anim_struct thread maps\_anim::anim_loop_solo(self,self.script_noteworthy + "_panel_idle","stop_loop");
	thread car_lift_scene();
	common_scripts\utility::flag_wait("player_entered_balcony_door");
	self delete();
}

//Function Number: 21
civilian_garage_vo()
{
	level endon("player_entered_balcony_door");
	if(!isdefined(level.civilian_garage_1) || isdefined(level.civilian_garage_2))
	{
		return;
	}

	level.civilian_garage_1 endon("death");
	level.civilian_garage_2 endon("death");
	common_scripts\utility::flag_wait("start_car_lift_scene");
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	level endon("_stealth_spotted");
	level.civilian_garage_1 thread stop_civilian_conversation("player_entered_balcony_door");
	level.civilian_garage_2 thread stop_civilian_conversation("player_entered_balcony_door");
	level.civilian_garage_1 maps\_utility::smart_dialogue("ie_cm1_spoiler");
	level.civilian_garage_2 maps\_utility::smart_dialogue("ie_cm2_newfront");
	level.civilian_garage_1 maps\_utility::smart_dialogue("ie_cm1_research");
	level.civilian_garage_2 maps\_utility::smart_dialogue("ie_cm2_alurisseries");
	level.civilian_garage_1 maps\_utility::smart_dialogue("ie_cm1_automatic");
	level.civilian_garage_2 maps\_utility::smart_dialogue("ie_cm2_dumbasses");
	level.civilian_garage_1 maps\_utility::smart_dialogue("ie_cm1_worse");
	wait(1);
	level.civilian_garage_1 maps\_utility::smart_dialogue("ie_cm1_modded");
	level.civilian_garage_2 maps\_utility::smart_dialogue("ie_cm2_knowtheguy");
	level.civilian_garage_1 maps\_utility::smart_dialogue("ie_cm1_trustme");
	level.civilian_garage_2 maps\_utility::smart_dialogue("ie_cm2_notrouble");
	wait(1);
	level.civilian_garage_2 maps\_utility::smart_dialogue("ie_cm2_metryan");
	level.civilian_garage_1 maps\_utility::smart_dialogue("ie_cm1_crazy");
	level.civilian_garage_2 maps\_utility::smart_dialogue("ie_cm2_grabhim");
	level.civilian_garage_1 maps\_utility::smart_dialogue("ie_cm1_messagemike");
	level.civilian_garage_2 maps\_utility::smart_dialogue("ie_cm2_firstgames");
}

//Function Number: 22
car_lift_scene()
{
	self endon("death");
	self endon("alerted");
	common_scripts\utility::flag_wait("start_car_lift_scene");
	thread civilian_alert_watcher("player_entered_balcony_door","civilians_garage","civilians_garage_alerted");
	thread civilian_alert_behavior("player_entered_balcony_door",level.garage_anim_struct,undefined,undefined,1);
	wait(1);
	level.garage_anim_struct notify("stop_loop");
	level.garage_anim_struct maps\_anim::anim_single_solo(self,self.script_noteworthy + "_panel_to_car");
	level.garage_anim_struct thread maps\_anim::anim_loop_solo(self,self.script_noteworthy + "_car_idle","stop_loop");
}

//Function Number: 23
car_lift()
{
	if(common_scripts\utility::flag("civilians_garage_alerted") || common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	var_00 = common_scripts\utility::getstruct("car_lift_struct","targetname");
	var_01 = var_00 common_scripts\utility::spawn_tag_origin();
	var_02 = getent("car_lift_brushes","targetname");
	var_02 linkto(var_01,"tag_origin");
	var_03 = getentarray("car_lift_models","targetname");
	foreach(var_05 in var_03)
	{
		var_05 linkto(var_01,"tag_origin");
	}

	var_01 moveto(var_01.origin + (0,0,132),8);
	soundscripts\_snd::snd_message("aud_garage_lift");
	wait(8);
	var_07 = getent("car_lift_light","targetname");
	var_07 setlightintensity(2050);
	var_08 = common_scripts\utility::getstruct("garage_lift_grapple_magnet_1","targetname");
	maps\_grapple::grapple_magnet_register(var_08);
}

//Function Number: 24
civilian_right_side()
{
	common_scripts\utility::flag_init("civilians_right_side_alerted");
	maps\_utility::array_spawn_function_targetname("civilian_right_side_spawner",::civilian_right_side_setup);
	var_00 = maps\_utility::array_spawn_targetname("civilian_right_side_spawner",1);
	level.active_civilians = common_scripts\utility::array_combine(level.active_civilians,var_00);
	thread civilian_right_side_vo();
	level.lost_civilian_anim_struct = common_scripts\utility::getstruct("lost_civilian_anim_struct","targetname");
	thread lost_civilian_door();
	common_scripts\utility::flag_wait_either("start_civilian_lost","penthouse_end_ready");
	if(common_scripts\utility::flag("_stealth_spotted") || common_scripts\utility::flag("penthouse_end_ready"))
	{
		return;
	}

	maps\_utility::array_spawn_function_targetname("civilian_lost_spawner",::civilian_lost_setup);
	var_01 = maps\_utility::array_spawn_targetname("civilian_lost_spawner",1);
	level.active_civilians = common_scripts\utility::array_combine(level.active_civilians,var_01);
	level waittill("start_guard");
	maps\_utility::array_spawn_function_targetname("civilian_lost_guard_spawner",::civilian_lost_guard_setup);
	var_02 = maps\_utility::array_spawn_targetname("civilian_lost_guard_spawner",1);
}

//Function Number: 25
civilian_right_side_setup()
{
	self.animname = "generic";
	self.allowdeath = 1;
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "civilian_right_side_1")
	{
		civilian_head_and_body_swap(level.civilian_african_male_b);
		level.civilian_right_side_1 = self;
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "civilian_right_side_2")
	{
		civilian_head_and_body_swap(level.civilian_african_male_d);
		level.civilian_right_side_2 = self;
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "civilian_right_side_3")
	{
		civilian_head_and_body_swap(level.civilian_urban_male_c);
		level.civilian_right_side_3 = self;
	}

	var_00 = common_scripts\utility::getstruct(self.script_noteworthy + "_struct","targetname");
	thread civilian_alert_watcher("player_entered_balcony_door","civilians_right_side","civilians_right_side_alerted");
	thread civilian_alert_behavior("player_entered_balcony_door",var_00);
	var_00 thread maps\_anim::anim_loop_solo(self,self.script_noteworthy,"stop_loop");
	common_scripts\utility::flag_wait("player_entered_balcony_door");
	self delete();
}

//Function Number: 26
civilian_right_side_vo()
{
	level endon("player_entered_balcony_door");
	level.civilian_right_side_1 endon("death");
	level.civilian_right_side_2 endon("death");
	level.civilian_right_side_3 endon("death");
	common_scripts\utility::flag_wait("civilian_right_side_conversation");
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	level endon("_stealth_spotted");
	level.civilian_right_side_1 thread stop_civilian_conversation("player_entered_balcony_door");
	level.civilian_right_side_2 thread stop_civilian_conversation("player_entered_balcony_door");
	level.civilian_right_side_3 thread stop_civilian_conversation("player_entered_balcony_door");
	level.civilian_right_side_1 maps\_utility::smart_dialogue("ie_cm5_seat");
	level.civilian_right_side_2 maps\_utility::smart_dialogue("ie_cm6_kidding");
	level.civilian_right_side_3 maps\_utility::smart_dialogue("ie_cm7_amazing");
	level.civilian_right_side_2 maps\_utility::smart_dialogue("ie_cm6_work");
	level.civilian_right_side_1 maps\_utility::smart_dialogue("ie_cm5_noidea");
	level.civilian_right_side_3 maps\_utility::smart_dialogue("ie_cm7_legallyspeaking");
	level.civilian_right_side_2 maps\_utility::smart_dialogue("ie_cm6_getthat");
	level.civilian_right_side_3 maps\_utility::smart_dialogue("ie_cm7_lawyer");
	level.civilian_right_side_2 maps\_utility::smart_dialogue("ie_cm6_thankgod");
	level.civilian_right_side_1 maps\_utility::smart_dialogue("ie_cm5_treatment");
	level.civilian_right_side_3 maps\_utility::smart_dialogue("ie_cm7_wholeidea");
	level.civilian_right_side_2 maps\_utility::smart_dialogue("ie_cm6_smart");
}

//Function Number: 27
lost_civilian_door()
{
	level endon("player_entered_balcony_door");
	var_00 = maps\_utility::spawn_anim_model("lost_civilian_prop");
	var_01 = getent("lost_civilian_door","targetname");
	level.lost_civilian_anim_struct maps\_anim::anim_first_frame_solo(var_00,"ie_frontyard_lost_civ_door");
	var_02 = getent("lost_civilian_door_clip","targetname");
	var_02 linkto(var_00,"J_prop_1");
	var_02 disconnectpaths();
	level waittill("start_guard");
	var_01 linkto(var_00,"J_prop_1");
	level.lost_civilian_anim_struct maps\_anim::anim_single_solo(var_00,"ie_frontyard_lost_civ_door");
}

//Function Number: 28
civilian_lost_setup()
{
	self endon("death");
	self endon("alerted");
	self.animname = "generic";
	self.allowdeath = 1;
	civilian_head_and_body_swap(level.civilian_urban_male_b);
	level.civilian_lost = self;
	thread civilian_alert_watcher("player_entered_balcony_door","lost_civilian_group");
	thread civilian_alert_behavior("player_entered_balcony_door",undefined,undefined,undefined,1);
	self notify("end_patrol");
	wait 0.05;
	level.lost_civilian_anim_struct maps\_anim::anim_single_solo(self,"ie_frontyard_lost_civ_guy");
	var_00 = getent("driveway_monster_clip_5","targetname");
	var_00 notsolid();
	var_00 connectpaths();
	var_01 = common_scripts\utility::getstruct("civilian_lost_escort_start","targetname");
	self.target = var_01.targetname;
	thread maps\_patrol::patrol(self.target);
	self waittill("reached_path_end");
	self delete();
}

//Function Number: 29
civilian_lost_guard_setup()
{
	self endon("death");
	maps\_utility::walkdist_zero();
	self.animname = "generic";
	self.allowdeath = 0;
	level.civilian_lost_guard = self;
	self.ignoreall = 1;
	self.do_not_react_to_whistle = 1;
	self.grapple_magnets = [];
	self notify("end_patrol");
	maps\_utility::gun_remove();
	level.lost_civilian_anim_struct maps\_anim::anim_first_frame_solo(self,"ie_frontyard_lost_civ_guard");
	level.lost_civilian_anim_struct thread maps\_anim::anim_single_solo(self,"ie_frontyard_lost_civ_guard");
	while(self getanimtime(maps\_utility::getanim("ie_frontyard_lost_civ_guard")) < 0.15)
	{
		wait(0.05);
	}

	self.allowdeath = 1;
	self.ignoreall = 0;
	self.script_stealth = 1;
	maps\irons_estate_stealth::irons_estate_stealth_custom();
	thread lost_civilian_guard_watch_for_alert();
	self endon("alerted");
	self waittillmatch("end","single anim");
	maps\_utility::gun_recall();
	maps\_grapple::grapple_magnet_register(self,"j_SpineUpper",undefined,undefined,undefined,undefined,undefined);
	var_00 = common_scripts\utility::getstruct("civilian_lost_guard_escort_start","targetname");
	self.target = var_00.targetname;
	thread maps\_patrol::patrol(self.target);
	self.do_not_react_to_whistle = undefined;
	common_scripts\utility::flag_wait("player_entered_balcony_door");
	self delete();
}

//Function Number: 30
lost_civilian_guard_watch_for_alert()
{
	self endon("death");
	maps\_utility::ent_flag_waitopen("_stealth_normal");
	self notify("alerted");
	self notify("end_patrol");
	if(isdefined(self.do_not_react_to_whistle))
	{
		if(isdefined(self.script_aigroup))
		{
			var_00 = maps\_utility::get_ai_group_ai(self.script_aigroup);
			if(isdefined(var_00))
			{
				foreach(var_02 in var_00)
				{
					if(!isdefined(var_02.alerted))
					{
						var_02 notify("alerted");
						self.alerted = 1;
					}
				}
			}
		}
	}

	maps\_utility::anim_stopanimscripted();
	maps\_utility::gun_recall();
	common_scripts\utility::flag_wait("player_entered_balcony_door");
	self delete();
}

//Function Number: 31
civilian_in_running_car()
{
	level.running_car = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("running_car");
	if(level.currentgen)
	{
		level.running_car thread maps\irons_estate_code::tff_cleanup_vehicle("lower");
	}

	maps\_utility::array_spawn_function_targetname("civilian_in_running_car",::civilian_in_running_car_setup);
	var_00 = maps\_utility::array_spawn_targetname("civilian_in_running_car",1);
	level.active_civilians = common_scripts\utility::array_combine(level.active_civilians,var_00);
}

//Function Number: 32
civilian_in_running_car_setup()
{
	self.animname = "generic";
	civilian_head_and_body_swap(level.civilian_urban_male_e);
	thread civilian_alert_watcher("player_entered_balcony_door");
	self.sight_ignore = level.running_car;
	self.vehicle_ride = level.running_car;
	self linkto(level.running_car,"tag_driver",(0,0,0),(0,0,0));
	level.running_car thread maps\_anim::anim_loop_solo(self,"running_car_driver","stop_loop","tag_driver");
	common_scripts\utility::flag_wait("player_entered_balcony_door");
	self delete();
}

//Function Number: 33
civilian_driveway_scene()
{
	if(!isdefined(level.civilian_body_and_head_setup))
	{
		civilian_head_and_body_setup();
	}

	common_scripts\utility::flag_init("start_civilian_driveway_scene");
	common_scripts\utility::flag_init("driveway_civilians_alerted");
	common_scripts\utility::flag_init("driveway_civilians_female_to_car");
	common_scripts\utility::flag_init("driveway_civilians_male_to_car");
	level.driveway_car_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("driveway_car_1");
	level.driveway_car_1 thread driveway_car("driveway_car_1");
	if(level.currentgen)
	{
		level.driveway_car_1 thread maps\irons_estate_code::tff_cleanup_vehicle("lower");
	}

	level.driveway_car_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("driveway_car_2");
	level.driveway_car_2 thread driveway_car("driveway_car_2");
	if(level.currentgen)
	{
		level.driveway_car_2 thread maps\irons_estate_code::tff_cleanup_vehicle("lower");
	}

	maps\_utility::array_spawn_function_targetname("driveway_car_2_civilian",::driveway_car_2_civilian_setup);
	var_00 = maps\_utility::array_spawn_targetname("driveway_car_2_civilian",1);
	level.active_civilians = common_scripts\utility::array_combine(level.active_civilians,var_00);
	thread driveway_monster_clip("driveway_monster_clip_1");
	thread driveway_monster_clip("driveway_monster_clip_2");
	thread driveway_monster_clip("driveway_monster_clip_3");
	thread driveway_monster_clip("driveway_monster_clip_4");
	thread driveway_monster_clip("driveway_car_1_monster_clip_1");
	maps\_utility::array_spawn_function_targetname("driveway_guard_left",::driveway_guard_setup);
	var_01 = maps\_utility::array_spawn_targetname("driveway_guard_left",1);
	level.driveway_guard_left = var_01[0];
	maps\_utility::array_spawn_function_targetname("driveway_guard_right",::driveway_guard_setup);
	var_02 = maps\_utility::array_spawn_targetname("driveway_guard_right",1);
	level.driveway_guard_right = var_02[0];
	level.civilian_in_car_count = 0;
	maps\_utility::array_spawn_function_targetname("driveway_car_1_civilian",::driveway_car_1_civilian_setup);
	var_03 = maps\_utility::array_spawn_targetname("driveway_car_1_civilian",1);
	level.active_civilians = common_scripts\utility::array_combine(level.active_civilians,var_03);
	if(level.start_point_scripted != "penthouse")
	{
		common_scripts\utility::flag_wait("penthouse_end_ready");
	}

	level.driveway_car_2 soundscripts\_snd_playsound::snd_play_linked("irons_civ_truck_drive_off");
	wait(0.5);
	common_scripts\utility::flag_set("driveway_car_2_drive");
	common_scripts\utility::flag_wait_either("driveway_monster_clip_3","driveway_civilians_alerted");
	common_scripts\utility::flag_set("start_civilian_driveway_scene");
	while(level.civilian_in_car_count < 2)
	{
		wait(0.05);
	}

	wait(0.25);
	common_scripts\utility::flag_set("driveway_car_1_drive");
}

//Function Number: 34
driveway_monster_clip(param_00)
{
	common_scripts\utility::flag_wait_either(param_00,"player_entered_balcony_door");
	param_00 = getent(param_00,"targetname");
	param_00 notsolid();
	param_00 connectpaths();
	wait(1);
	param_00 delete();
}

//Function Number: 35
driveway_car(param_00)
{
	level endon("player_entered_balcony_door");
	thread driveway_car_cleanup(param_00);
	if(param_00 == "driveway_car_1")
	{
		self.animname = "sedan";
		maps\_anim::setanimtree();
		maps\_anim::anim_first_frame_solo(self,"driveway_car_1_enter");
		common_scripts\utility::flag_wait("start_civilian_driveway_scene");
		maps\_anim::anim_single_solo(self,"driveway_car_1_enter");
	}

	common_scripts\utility::flag_wait(param_00 + "_drive");
	if(param_00 == "driveway_car_1")
	{
		self.left_headlight_tag = common_scripts\utility::spawn_tag_origin();
		self.left_headlight_tag linkto(self,"tag_headlight_left",(25,-10,-20),(0,0,0));
		playfxontag(level._effect["ie_civ_sedan_headlight"],self.left_headlight_tag,"tag_origin");
		thread driveway_car_cleanup_fx("driveway_car_1_path_end",self.left_headlight_tag,"ie_civ_sedan_headlight");
		self.right_headlight_tag = common_scripts\utility::spawn_tag_origin();
		self.right_headlight_tag linkto(self,"tag_headlight_right",(25,10,-20),(0,0,0));
		playfxontag(level._effect["ie_civ_sedan_headlight"],self.right_headlight_tag,"tag_origin");
		thread driveway_car_cleanup_fx("driveway_car_1_path_end",self.right_headlight_tag,"ie_civ_sedan_headlight");
		playfxontag(level._effect["ie_civ_sedan_lights"],self,"tag_origin");
		thread driveway_car_cleanup_fx("driveway_car_1_path_end",undefined,"ie_civ_sedan_headlight");
		self.spotlight_tag = common_scripts\utility::spawn_tag_origin();
		self.spotlight_tag linkto(self,"tag_origin",(104,0,44),(0,0,0));
		playfxontag(level._effect["ie_headlight_misc"],self.spotlight_tag,"tag_origin");
		thread driveway_car_cleanup_fx("driveway_car_1_path_end",self.spotlight_tag,"ie_headlight_misc");
		return;
	}

	self.left_headlight_tag = common_scripts\utility::spawn_tag_origin();
	self.left_headlight_tag linkto(self,"tag_headlight_left",(20,0,-15),(0,0,0));
	playfxontag(level._effect["ie_truck_headlight"],self.left_headlight_tag,"tag_origin");
	thread driveway_car_cleanup_fx("driveway_car_2_path_end",self.left_headlight_tag,"ie_truck_headlight");
	self.right_headlight_tag = common_scripts\utility::spawn_tag_origin();
	self.right_headlight_tag linkto(self,"tag_headlight_right",(20,0,-15),(0,0,0));
	playfxontag(level._effect["ie_truck_headlight"],self.right_headlight_tag,"tag_origin");
	thread driveway_car_cleanup_fx("driveway_car_2_path_end",self.right_headlight_tag,"ie_truck_headlight");
	self.left_brakelight_tag = common_scripts\utility::spawn_tag_origin();
	self.left_brakelight_tag linkto(self,"tag_brakelight_left",(10,0,-15),(0,0,0));
	playfxontag(level._effect["ie_truck_tail"],self.left_brakelight_tag,"tag_origin");
	thread driveway_car_cleanup_fx("driveway_car_2_path_end",self.left_brakelight_tag,"ie_truck_tail");
	self.right_brakelight_tag = common_scripts\utility::spawn_tag_origin();
	self.right_brakelight_tag linkto(self,"tag_brakelight_right",(10,0,-15),(0,0,0));
	playfxontag(level._effect["ie_truck_tail"],self.right_brakelight_tag,"tag_origin");
	thread driveway_car_cleanup_fx("driveway_car_2_path_end",self.right_brakelight_tag,"ie_truck_tail");
	self.spotlight_tag = common_scripts\utility::spawn_tag_origin();
	self.spotlight_tag linkto(self,"tag_origin",(104,0,44),(0,0,0));
	playfxontag(level._effect["ie_headlight_misc"],self.spotlight_tag,"tag_origin");
	thread driveway_car_cleanup_fx("driveway_car_2_path_end",self.spotlight_tag,"ie_headlight_misc");
}

//Function Number: 36
driveway_car_cleanup(param_00)
{
	common_scripts\utility::flag_wait_either(param_00 + "_path_end","player_entered_balcony_door");
	wait(1);
	maps\_vehicle::godoff();
	self delete();
}

//Function Number: 37
driveway_car_cleanup_fx(param_00,param_01,param_02)
{
	common_scripts\utility::flag_wait_either(param_00,"player_entered_balcony_door");
	if(isdefined(param_01))
	{
		stopfxontag(level._effect[param_02],param_01,"tag_origin");
		param_01 delete();
		return;
	}

	stopfxontag(level._effect[param_02],self,"tag_origin");
}

//Function Number: 38
driveway_car_2_civilian_setup()
{
	self.animname = "generic";
	civilian_head_and_body_swap(level.civilian_urban_male_b);
	thread civilian_alert_watcher("driveway_car_2_path_end");
	self.sight_ignore = level.driveway_car_2;
	self.vehicle_ride = level.driveway_car_2;
	self linkto(level.driveway_car_2,"tag_driver",(0,0,0),(0,0,0));
	level.driveway_car_2 thread maps\_anim::anim_loop_solo(self,"driveway_car_2_driver","stop_loop","tag_driver");
	common_scripts\utility::flag_wait_either("driveway_car_2_path_end","player_entered_balcony_door");
	self delete();
}

//Function Number: 39
driveway_guard_setup()
{
	self endon("death");
	maps\_utility::walkdist_zero();
	wait 0.05;
	if(self == level.driveway_guard_right)
	{
		thread driveway_guard_anim();
	}

	common_scripts\utility::flag_wait_either("driveway_monster_clip_3","player_entered_balcony_door");
	if(common_scripts\utility::flag("driveway_monster_clip_3"))
	{
		self.script_noteworthy = undefined;
		common_scripts\utility::flag_wait("player_entered_balcony_door");
	}

	self delete();
}

//Function Number: 40
driveway_guard_anim()
{
	self endon("death");
	level endon("player_entered_balcony_door");
	self.ignoreall = 1;
	self.animname = "generic";
	var_00 = common_scripts\utility::getstruct("driveway_guard_anim_struct","targetname");
	var_00 childthread maps\_anim::anim_loop_solo(self,"patrol_unarmed_idle","stop_loop");
	thread driveway_guard_watch_for_alert();
	common_scripts\utility::flag_wait("start_civilian_driveway_scene");
	if(common_scripts\utility::flag("_stealth_spotted") || isdefined(self.alerted))
	{
		var_00 notify("stop_loop");
		maps\_utility::anim_stopanimscripted();
		return;
	}

	var_00 notify("stop_loop");
	maps\_utility::anim_stopanimscripted();
	maps\_utility::gun_remove();
	var_01 = common_scripts\utility::getstruct("driveway_anim_struct","targetname");
	var_01 maps\_anim::anim_single_solo(self,"driveway_car_1_enter_guard");
	maps\_utility::gun_recall();
	self.ignoreall = 0;
}

//Function Number: 41
driveway_guard_watch_for_alert()
{
	self endon("death");
	maps\_utility::ent_flag_waitopen("_stealth_normal");
	maps\_utility::anim_stopanimscripted();
	maps\_utility::gun_recall();
}

//Function Number: 42
driveway_car_1_civilian_setup()
{
	self endon("death");
	level endon("player_entered_balcony_door");
	self.animname = "generic";
	self.allowdeath = 1;
	thread driveway_civilian_cleanup();
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "driveway_female")
	{
		civilian_head_and_body_swap(level.civilian_urban_female_c);
		var_00 = "tag_driver";
		thread civilian_alert_watcher("driveway_civilians_female_to_car","driveway_civilians","driveway_civilians_alerted");
		thread civilian_alert_behavior("driveway_civilians_female_to_car",level.driveway_car_1,undefined,undefined,1);
	}
	else
	{
		civilian_head_and_body_swap(level.civilian_urban_male_d);
		var_00 = "tag_passenger";
		thread civilian_alert_watcher("driveway_civilians_male_to_car","driveway_civilians","driveway_civilians_alerted");
		thread civilian_alert_behavior("driveway_civilians_male_to_car",level.driveway_car_1,undefined,undefined,1);
	}

	level.driveway_car_1 thread maps\_anim::anim_loop_solo(self,"driveway_car_1_idle_" + self.script_noteworthy,"stop_loop",var_00);
	common_scripts\utility::flag_wait("start_civilian_driveway_scene");
	level.driveway_car_1 notify("stop_loop");
	maps\_utility::anim_stopanimscripted();
	if(isdefined(self.alerted))
	{
		return;
	}

	level.driveway_car_1 thread maps\_anim::anim_single_solo(self,"driveway_car_1_enter_" + self.script_noteworthy,var_00);
	maps\_utility::magic_bullet_shield();
	self.allowdeath = 0;
	self.sight_ignore = level.driveway_car_1;
	self.vehicle_ride = level.driveway_car_1;
	level.driveway_car_1 soundscripts\_snd_playsound::snd_play_delayed_linked("irons_civ_car_door_shut_1",9.5);
	level.driveway_car_1 soundscripts\_snd_playsound::snd_play_delayed_linked("irons_civ_car_drive_off",15);
	level.driveway_car_1 soundscripts\_snd_playsound::snd_play_delayed_linked("irons_civ_car_door_shut_2",15.7);
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "driveway_female")
	{
		while(self getanimtime(maps\_utility::getanim("driveway_car_1_enter_driveway_female")) < 0.5)
		{
			wait(0.05);
		}

		common_scripts\utility::flag_set("driveway_civilians_female_to_car");
		self waittillmatch("end","single anim");
		self linkto(level.driveway_car_1,"tag_driver",(0,0,0),(0,0,0));
		level.driveway_car_1 thread maps\_anim::anim_loop_solo(self,"driveway_car_1_driver","stop_loop","tag_driver");
	}
	else
	{
		while(self getanimtime(maps\_utility::getanim("driveway_car_1_enter_driveway_male")) < 0.75)
		{
			wait(0.05);
		}

		common_scripts\utility::flag_set("driveway_civilians_male_to_car");
		self waittillmatch("end","single anim");
		self linkto(level.driveway_car_1,"tag_passenger",(0,0,0),(0,0,0));
		level.driveway_car_1 thread maps\_anim::anim_loop_solo(self,"driveway_car_1_passenger","stop_loop","tag_passenger");
	}

	level.civilian_in_car_count++;
}

//Function Number: 43
driveway_civilian_cleanup()
{
	self endon("death");
	common_scripts\utility::flag_wait_either("driveway_car_1_path_end","player_entered_balcony_door");
	if(isdefined(self.magic_bullet_shield))
	{
		maps\_utility::stop_magic_bullet_shield();
	}

	self delete();
}

//Function Number: 44
civilian_alert_watcher(param_00,param_01,param_02)
{
	self notify("civilian_alert_watcher");
	self endon("civilian_alert_watcher");
	if(isdefined(param_00))
	{
		level endon(param_00);
	}

	self endon("death");
	thread mission_fail_on_civilian_death();
	self.fovcosinez = cos(10);
	self.fovcosine = cos(30);
	self.sonic_aoe_thread = ::civilian_sonic_aoe_thread;
	childthread vehicle_scripts\_pdrone_security::drone_alert_sight("spotted_player",undefined,undefined,0.5);
	childthread civilian_stealth_detect();
	var_03 = common_scripts\utility::waittill_any_return_parms("damage","enemy","alerted","bulletwhizby","grenade danger","explode","spotted_player","witness_kill");
	self notify("alerted");
	self.alerted = 1;
	if(isdefined(self.script_aigroup))
	{
		if(isdefined(param_01))
		{
			var_04 = maps\_utility::get_ai_group_ai(param_01);
		}
		else
		{
			var_04 = maps\_utility::get_ai_group_ai(self.script_aigroup);
		}

		if(isdefined(var_04))
		{
			foreach(var_06 in var_04)
			{
				if(!isdefined(var_06.alerted))
				{
					var_06 notify("alerted");
					self.alerted = 1;
				}
			}
		}
	}

	if(isdefined(param_02) && !common_scripts\utility::flag(param_02))
	{
		common_scripts\utility::flag_set(param_02);
	}

	if(!common_scripts\utility::flag("_stealth_spotted"))
	{
		level.player soundscripts\_snd_playsound::snd_play_2d("irons_spotted_alert");
	}

	common_scripts\utility::flag_set("_stealth_spotted");
	level.stealth_fail_fast = 1;
}

//Function Number: 45
civilian_sonic_aoe_thread()
{
	self notify("alerted");
}

//Function Number: 46
mission_fail_on_civilian_death()
{
	self waittill("death",var_00);
	if(isdefined(var_00) && var_00 == level.player)
	{
		level.friendlyfire["friend_kill_points"] = -10000;
		level.civilian_killed = 1;
	}
}

//Function Number: 47
civilian_stealth_detect()
{
	for(;;)
	{
		if(isdefined(self.threatsightdelay) && self.threatsightdelay > 0)
		{
			level.player maps\_stealth_display::stealth_display_seed(self,self.threatsightdelay,self.canseeplayer);
		}

		wait(0.05);
	}
}

//Function Number: 48
civilian_alert_behavior(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_00))
	{
		level endon(param_00);
	}

	self endon("death");
	self waittill("alerted");
	thread civilian_alert_sound();
	maps\_utility::set_generic_run_anim("patrol_walk_alert");
	maps\_utility::set_generic_idle_anim("patrol_idle_alert");
	if(isdefined(param_01))
	{
		param_01 notify("stop_loop");
		maps\_utility::anim_stopanimscripted();
	}

	if(isdefined(self.react_anim))
	{
		maps\_anim::anim_single_solo(self,self.react_anim);
	}

	if(isdefined(param_02))
	{
		if(!isdefined(self.at_path_end))
		{
			common_scripts\utility::flag_wait(param_03);
		}
	}

	param_01 = common_scripts\utility::getstruct(self.script_noteworthy + "_cower_struct","targetname");
	if(isdefined(param_04))
	{
		thread maps\_anim::anim_loop_solo(self,param_01.animation,"stop_loop");
		return;
	}

	param_01 thread maps\_anim::anim_loop_solo(self,param_01.animation,"stop_loop");
}

//Function Number: 49
civilian_alert_behavior_hangar()
{
	self endon("death");
	self waittill("alerted");
	thread civilian_alert_sound();
	maps\_utility::set_generic_run_anim("patrol_walk_alert");
	maps\_utility::set_generic_idle_anim("patrol_idle_alert");
	if(isdefined(self.welder))
	{
		self.scripted_node notify("stop_welder_loop");
	}
	else
	{
		self.scripted_node notify("stop_loop");
	}

	level notify("aud_stop_welding_loop");
	if(isdefined(self.torch))
	{
		self.torch delete();
	}

	wait(0.05);
	if(self == level.forklift_driver)
	{
		level.forklift thread maps\_anim::anim_generic_loop(self,"forklift_cower_idle","stop_loop","tag_driver");
		return;
	}

	thread maps\_anim::anim_generic_loop(self,"unarmed_covercrouch_hide_idle");
}

//Function Number: 50
civilian_alert_sound_setup(param_00)
{
	if(param_00 == "female")
	{
		var_01 = [];
		var_01[0] = "ie_cf1_startled";
		var_01[1] = "ie_cf1_panic1";
		var_01[2] = "ie_cf1_panic2";
		var_01[3] = "ie_cf2_startled";
		var_01[4] = "ie_cf2_panic1";
		var_01[5] = "ie_cf2_panic2";
	}
	else
	{
		var_01 = [];
		var_01[0] = "ie_cm1_startled1";
		var_01[1] = "ie_cm1_startled2";
		var_01[2] = "ie_cm2_startled1";
		var_01[3] = "ie_cm2_startled2";
		var_01[4] = "ie_cm3_startled1";
		var_01[5] = "ie_cm3_startled2";
	}

	return var_01;
}

//Function Number: 51
civilian_alert_sound()
{
	self endon("death");
	wait(randomfloatrange(0,0.5));
	if(isdefined(self.model))
	{
		if(issubstr(self.model,"female"))
		{
			if(!isdefined(level.female_civilian_alert_sound))
			{
				var_00 = civilian_alert_sound_setup("female");
				var_01 = common_scripts\utility::random(var_00);
				self playsound(var_01);
				level.female_civilian_alert_sound = 1;
				return;
			}

			return;
		}

		if(issubstr(self.model,"male"))
		{
			if(!isdefined(level.male_civilian_alert_sound))
			{
				var_00 = civilian_alert_sound_setup("male");
				var_01 = common_scripts\utility::random(var_01);
				self playsound(var_01);
				level.male_civilian_alert_sound = 1;
				return;
			}

			return;
		}
	}
}

//Function Number: 52
stop_civilian_conversation(param_00,param_01)
{
	if(isdefined(param_00))
	{
		level endon(param_00);
	}

	if(isdefined(param_01))
	{
		level endon(param_01);
	}

	common_scripts\utility::waittill_either("alerted","death");
	if(isdefined(self))
	{
		self stopsounds();
	}
}

//Function Number: 53
civilian_head_and_body_setup()
{
	level.civilian_african_male_b = [];
	level.civilian_african_male_b[0] = "civ_african_male_body_b";
	level.civilian_african_male_b[1] = "head_male_sp_gartei";
	level.civilian_african_male_c = [];
	level.civilian_african_male_c[0] = "civ_african_male_body_c";
	level.civilian_african_male_c[1] = "head_male_mp_brickerson";
	level.civilian_african_male_d = [];
	level.civilian_african_male_d[0] = "civ_african_male_body_d";
	level.civilian_african_male_d[1] = "head_male_mp_sykes";
	level.civilian_urban_male_b = [];
	level.civilian_urban_male_b[0] = "civ_urban_male_body_b";
	level.civilian_urban_male_b[1] = "civ_urban_male_head_kanik";
	level.civilian_urban_male_c = [];
	level.civilian_urban_male_c[0] = "civ_urban_male_body_c";
	level.civilian_urban_male_c[1] = "head_m_gen_cau_anderson";
	level.civilian_urban_male_d = [];
	level.civilian_urban_male_d[0] = "civ_urban_male_body_d";
	level.civilian_urban_male_d[1] = "head_m_gen_cau_clark";
	level.civilian_urban_male_e = [];
	level.civilian_urban_male_e[0] = "civ_urban_male_body_e";
	level.civilian_urban_male_e[1] = "head_m_gen_cau_young";
	level.civilian_urban_female_a = [];
	level.civilian_urban_female_a[0] = "civ_urban_female_body_a_mde";
	level.civilian_urban_female_a[1] = "head_f_gen_mde_halabi";
	level.civilian_urban_female_b = [];
	level.civilian_urban_female_b[0] = "civ_urban_female_body_b";
	level.civilian_urban_female_b[1] = "head_f_act_cau_hamilton_base";
	level.civilian_urban_female_c = [];
	level.civilian_urban_female_c[0] = "civ_urban_female_body_c_afr_dark";
	level.civilian_urban_female_c[1] = "head_f_act_afr_townes";
	level.civilian_body_and_head_setup = 1;
}

//Function Number: 54
civilian_head_and_body_swap(param_00)
{
	if(isdefined(param_00) && isdefined(param_00[0]))
	{
		self setmodel(param_00[0]);
	}

	if(isdefined(param_00) && isdefined(param_00[1]))
	{
		self detach(self.headmodel,"");
		self attach(param_00[1],"",1);
		self.headmodel = param_00[1];
	}
}