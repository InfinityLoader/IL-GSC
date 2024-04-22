/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: detroit_transients_cg.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 255 ms
 * Timestamp: 4/22/2024 2:28:29 AM
*******************************************************************/

//Function Number: 1
cg_setup_civs_foodtruck()
{
	common_scripts\utility::flag_wait("show_middle_civs_trigger");
	var_00 = [];
	var_01 = getent("org_foodtruck","targetname");
	var_02 = getent("atlas_guard_foodtruck2_spawner","targetname") spawndrone();
	var_00[var_00.size] = var_02;
	var_02.animname = "drone_civs";
	var_02 maps\_anim::setanimtree();
	var_01 thread maps\_anim::anim_loop_solo(var_02,"foodtruck18");
	var_03 = spawn("script_model",var_01.origin);
	var_03 setmodel("det_cargo_box_single_01");
	var_03.animname = "foodtruck_mre";
	var_03 maps\_anim::setanimtree();
	var_00[var_00.size] = var_03;
	thread maps\detroit_refugee_camp::mre_loop(var_03);
	var_01 thread maps\_anim::anim_loop_solo(var_03,"foodtruck_mre2");
	var_04 = ["civ_urban_male_body_b_green_afr_dark","civ_urban_male_body_c_blue_mde","civ_urban_male_body_f_black_pants","civ_urban_male_body_e_solid_red","civ_urban_male_body_b_green_mde","civ_urban_male_body_c_solid_yellow_afr_light","civ_urban_male_body_f_black_pants","civ_urban_male_body_c_solid_yellow","civ_urban_male_body_e","civ_urban_male_body_b_red_afr_light"];
	var_05 = ["head_m_gen_afr_davis","head_m_gen_mde_urena","head_m_act_cau_kanik_base","head_m_gen_cau_anderson","head_m_gen_mde_azzam","head_m_act_afr_brickerson_base","head_m_act_cau_manasi_base","head_m_act_cau_ramsay_base","head_m_gen_cau_anderson","head_m_gen_afr_rice"];
	var_06 = ["civ_foodtruck1_spawner","civ_foodtruck3_spawner","civ_foodtruck5_spawner","civ_foodtruck6_spawner","civ_foodtruck8_spawner","civ_foodtruck9_spawner","civ_foodtruck10_spawner","civ_foodtruck11_spawner","civ_foodtruck13_spawner","civ_foodtruck14_spawner"];
	var_07 = ["foodtruck11","foodtruck1","foodtruck3","foodtruck13","foodtruck9","foodtruck5","foodtruck8","foodtruck10","foodtruck6","foodtruck14"];
	var_08 = [];
	for(var_09 = 0;var_09 < var_04.size;var_09++)
	{
		if(var_09 == 5 || var_09 == 3)
		{
			continue;
		}

		var_0A = common_scripts\utility::getstruct(var_06[var_09],"targetname");
		var_08[var_09] = spawn("script_model",var_0A.origin);
		var_08[var_09] setmodel(var_04[var_09]);
		var_08[var_09] attach(var_05[var_09]);
		var_08[var_09] setcontents(0);
		var_08[var_09].angles = var_0A.angles;
		var_08[var_09].animname = "drone_civs";
		var_08[var_09] maps\_anim::setanimtree();
		var_01 thread maps\_anim::anim_loop_solo(var_08[var_09],var_07[var_09]);
		if(var_09 == 0)
		{
			wait(0.05);
			var_08[var_09] setanimtime(%det_camp_foodtruck_civ_11,0.0331);
		}

		var_00[var_00.size] = var_08[var_09];
	}

	var_0B = getent("foodtruck","targetname");
	var_00[var_00.size] = var_0B;
	var_0B.animname = "foodtruck";
	var_0B maps\_anim::setanimtree();
	var_01 thread maps\_anim::anim_loop_solo(var_0B,"foodtruck_door");
	for(var_09 = 0;var_09 < var_00.size;var_09++)
	{
		if(isdefined(var_00[var_09]))
		{
			thread cg_kill_entity_on_transition(var_00[var_09],"tff_pre_intro_to_middle");
		}
	}

	common_scripts\utility::flag_wait("flag_camp_visibility_04");
	for(var_09 = 0;var_09 < var_08.size;var_09++)
	{
		var_08[var_09] delete();
	}

	var_02 delete();
	var_0B delete();
}

//Function Number: 2
cg_setup_civs_infosign()
{
	common_scripts\utility::flag_wait("flag_camp_visibility_01");
	var_00 = [];
	var_01 = ["civ_urban_male_body_e_solid_teal_afr_light","body_india_female_b"];
	var_02 = ["head_m_act_afr_sykes_base","head_india_female_b"];
	var_03 = ["civ_sign2_spawner","civ_sign3_spawner"];
	var_04 = ["sign2_spawner","sign3_spawner"];
	var_05 = [];
	for(var_06 = 0;var_06 < var_01.size;var_06++)
	{
		var_07 = common_scripts\utility::getstruct(var_03[var_06],"targetname");
		var_05[var_06] = spawn("script_model",var_07.origin);
		var_05[var_06] setmodel(var_01[var_06]);
		var_05[var_06] attach(var_02[var_06]);
		var_05[var_06] setcontents(0);
		var_05[var_06].angles = var_07.angles;
		var_05[var_06].animname = "drone_civs";
		var_05[var_06] maps\_anim::setanimtree();
		var_07 thread maps\_anim::anim_loop_solo(var_05[var_06],var_04[var_06]);
		var_00[var_00.size] = var_05[var_06];
	}

	for(var_06 = 0;var_06 < var_00.size;var_06++)
	{
		if(isdefined(var_00[var_06]))
		{
			thread cg_kill_entity_on_transition(var_00[var_06],"tff_pre_intro_to_middle");
		}
	}

	common_scripts\utility::flag_wait("flag_camp_visibility_04");
	var_05[0] delete();
	var_05[1] delete();
}

//Function Number: 3
cg_setup_civs_fence()
{
	thread cg_setup_civ_fence_special();
	while(!common_scripts\utility::flag("flag_camp_visibility_04"))
	{
		var_00 = [];
		var_01 = ["civ_urban_male_body_c_green_afr_dark","civ_urban_male_body_b_green_asi","civ_urban_male_body_c_solid_teal_afr_light","civ_urban_male_body_b","civ_urban_male_body_f_black_pants","civ_urban_male_body_e_solid_brown_mde","civ_urban_male_body_e_solid_yellow"];
		var_02 = ["head_m_gen_afr_bowman","head_m_act_asi_chen_base","head_m_gen_afr_rice","head_m_act_cau_ramsay_base","head_m_gen_cau_anderson","head_m_gen_mde_urena","head_m_gen_cau_anderson"];
		var_03 = ["civ_fence1_spawner","civ_fence3_spawner","civ_fence4_spawner","civ_fence5_spawner","civ_fence6_spawner","civ_fence7_spawner","civ_fence8_spawner"];
		var_04 = ["fence_spawner1","fence_spawner3","fence_spawner4","fence_spawner5","fence_spawner6","fence_spawner7","fence_spawner8"];
		var_05 = [];
		for(var_06 = 0;var_06 < var_01.size;var_06++)
		{
			var_07 = common_scripts\utility::getstruct(var_03[var_06],"targetname");
			var_05[var_06] = spawn("script_model",var_07.origin);
			var_05[var_06] setmodel(var_01[var_06]);
			var_05[var_06] attach(var_02[var_06]);
			var_05[var_06] setcontents(0);
			var_05[var_06].angles = var_07.angles;
			var_05[var_06].animname = "drone_civs";
			var_05[var_06] maps\_anim::setanimtree();
			var_07 thread maps\_anim::anim_loop_solo(var_05[var_06],var_04[var_06]);
			var_00[var_00.size] = var_05[var_06];
		}

		wait(1);
		for(var_06 = 0;var_06 < var_00.size;var_06++)
		{
			if(isdefined(var_00[var_06]))
			{
				thread cg_kill_entity_on_transition(var_00[var_06],"tff_pre_intro_to_middle");
			}
		}

		common_scripts\utility::flag_wait("flag_camp_visibility_03b");
		common_scripts\utility::flag_clear("flag_camp_visibility_03a");
		for(var_06 = 0;var_06 < var_05.size;var_06++)
		{
			var_05[var_06] delete();
		}

		common_scripts\utility::flag_wait("flag_camp_visibility_03a");
		common_scripts\utility::flag_clear("flag_camp_visibility_03b");
	}
}

//Function Number: 4
cg_setup_civ_fence_special()
{
	var_00 = common_scripts\utility::getstruct("civ_fence9_spawner","targetname");
	var_01 = spawn("script_model",var_00.origin);
	var_01 setmodel("civ_urban_male_body_c_mde");
	var_01 attach("head_m_gen_mde_urena");
	var_01 setcontents(0);
	var_01.angles = var_00.angles;
	var_01.animname = "drone_civs";
	var_01 maps\_anim::setanimtree();
	var_01 thread maps\_anim::anim_loop_solo(var_01,"fence_spawner9_idle_start");
	common_scripts\utility::flag_wait("flag_civ_fence_sit");
	var_01 notify("stop_loop");
	var_01 maps\_anim::anim_single_solo(var_01,"fence_spawner9_transition");
	var_01 thread maps\_anim::anim_loop_solo(var_01,"fence_spawner9_idle_end");
	if(isdefined(var_01))
	{
		thread cg_kill_entity_on_transition(var_01,"tff_pre_intro_to_middle");
	}

	while(!common_scripts\utility::flag("flag_camp_visibility_04"))
	{
		common_scripts\utility::flag_wait("flag_camp_visibility_03b");
		var_01 delete();
		common_scripts\utility::flag_clear("flag_camp_visibility_03a");
		common_scripts\utility::flag_wait("flag_camp_visibility_03a");
		var_01 = spawn("script_model",var_00.origin);
		var_01 setmodel("civ_urban_male_body_c_mde");
		var_01 attach("head_m_gen_mde_urena");
		var_01 setcontents(0);
		var_01.angles = var_00.angles;
		var_01.animname = "drone_civs";
		var_01 maps\_anim::setanimtree();
		var_01 thread maps\_anim::anim_loop_solo(var_01,"fence_spawner9_idle_end");
		common_scripts\utility::flag_clear("flag_camp_visibility_03b");
	}
}

//Function Number: 5
cg_setup_civs_baseball()
{
	common_scripts\utility::flag_wait("flag_camp_visibility_01");
	var_00 = getent("org_baseball","targetname");
	var_01 = [];
	var_02 = ["civ_urban_male_body_g","civ_urban_male_body_e_solid_brown","ehq_baseball_glove_01","ehq_baseball_glove_01"];
	var_03 = ["head_m_act_cau_ramsay_base","head_m_act_cau_manasi_base"];
	var_04 = ["civ_baseball1_spawner","civ_baseball2_spawner","baseball_glove1","baseball_glove2"];
	var_05 = ["baseball2","baseball1","baseball_glove1","baseball_glove2"];
	var_06 = [];
	for(var_07 = 0;var_07 < var_02.size;var_07++)
	{
		var_08 = common_scripts\utility::getstruct(var_04[var_07],"targetname");
		var_06[var_07] = spawn("script_model",var_08.origin);
		var_06[var_07] setmodel(var_02[var_07]);
		if(var_07 < 2)
		{
			var_06[var_07] attach(var_03[var_07]);
			var_06[var_07].animname = "drone_civs";
		}

		if(var_07 >= 2)
		{
			var_06[var_07].animname = "baseball_glove";
		}

		var_06[var_07] setcontents(0);
		var_06[var_07].angles = var_08.angles;
		var_06[var_07] maps\_anim::setanimtree();
		var_00 thread maps\_anim::anim_loop_solo(var_06[var_07],var_05[var_07]);
		var_01[var_01.size] = var_06[var_07];
	}

	var_06[1] attach("ehq_baseball","tag_weapon_chest");
	for(var_07 = 0;var_07 < var_01.size;var_07++)
	{
		if(isdefined(var_01[var_07]))
		{
			thread cg_kill_entity_on_transition(var_01[var_07],"tff_pre_intro_to_middle");
		}
	}

	common_scripts\utility::flag_wait("flag_camp_visibility_04");
	for(var_07 = 0;var_07 < var_06.size;var_07++)
	{
		var_06[var_07] delete();
	}
}

//Function Number: 6
cg_setup_social_groups()
{
	var_00 = [];
	var_01 = ["civilian_smoking_a","civilian_smoking_b","civilian_atm","civilian_stand_idle","london_civ_idle_checkwatch","london_civ_idle_foldarms2","london_civ_idle_lookbehind","london_civ_idle_foldarms_scratchass","london_civ_idle_scratchnose"];
	var_02 = ["civilian_sitting_business_lunch_a_1","civilian_sitting_business_lunch_b_1","civilian_sitting_talking_a_1","civilian_sitting_talking_a_2","civilian_sitting_talking_b_1","civilian_sitting_talking_b_2","civilian_texting_sitting","civilian_reader_1","sitting_guard_loadak_idle","guarda_sit_sleeper_idle","parabolic_leaning_guy_idle","civilian_stand_idle","det_camp_box_seated_civ_guy01","det_camp_box_seated_civ_guy02","det_camp_box_seated_civ_guy02","sitting_guard_loadak_idle","civilian_reader_2"];
	var_03 = ["civ_urban_male_body_c_blue_afr_light","civ_urban_male_body_c_solid_teal_mde","civ_urban_male_body_e_solid_yellow_mde","civ_urban_male_body_e_solid_red","civ_urban_male_body_e_solid_brown_mde","civ_urban_male_body_c_blue_shirt","civ_urban_male_body_c_blue_mde","civ_urban_male_body_c_gray_shirt","civ_urban_male_body_e_solid_brown_mde","civ_urban_male_body_d_afr_light","civ_urban_male_body_e","civ_urban_male_body_c_solid_red_mde","civ_urban_male_body_c_green_afr_dark","civ_urban_male_body_b_green_asi","civ_urban_male_body_c_solid_teal_afr_light","civ_urban_male_body_b","civ_urban_male_body_a_mde","civ_urban_male_body_e_solid_brown_mde","civ_urban_male_body_e_solid_yellow","civ_urban_male_body_e_solid_teal_afr_light"];
	var_04 = ["head_m_act_afr_brickerson_base","head_m_gen_mde_smith","head_m_gen_cau_clark","head_m_gen_cau_barton","head_m_gen_mde_hanks","head_m_gen_cau_young","head_m_gen_mde_smith","head_m_gen_cau_anderson","head_m_gen_mde_hanks","head_m_gen_afr_rice","head_m_act_cau_manasi_base","head_m_gen_mde_urena","head_m_gen_afr_bowman","head_m_act_asi_chen_base","head_m_gen_afr_rice","head_m_act_cau_ramsay_base","head_m_gen_mde_smith","head_m_gen_mde_urena","head_m_gen_cau_anderson","head_m_act_afr_sykes_base"];
	var_05 = getentarray("civ_life_scene_01","targetname");
	var_06 = getentarray("civ_life_scene_02","targetname");
	var_07 = common_scripts\utility::getstructarray("civ_life_scene_01","targetname");
	var_08 = common_scripts\utility::getstructarray("civ_life_scene_02","targetname");
	var_09 = common_scripts\utility::array_combine(var_07,var_08);
	var_0A = getentarray("spnr_civs_food_herd_01","targetname");
	var_0B = getentarray("civ_life_scene_01_orgs","targetname");
	var_09 = common_scripts\utility::array_combine(var_09,var_0B);
	level.section_1_civilians = [];
	var_0C = 0;
	foreach(var_0E in var_09)
	{
		var_0F = spawn("script_model",var_0E.origin);
		if(var_0C >= var_03.size)
		{
			var_0C = 0;
		}

		var_0F setmodel(var_03[var_0C]);
		var_0F attach(var_04[var_0C]);
		var_0F setcontents(0);
		var_0F.origin = var_0E.origin;
		var_0F.angles = var_0E.angles;
		var_0F.animname = "drone_civs";
		var_0F maps\_anim::setanimtree();
		var_0F thread maps\detroit_refugee_camp::delete_me_on_notify();
		level.section_1_civilians[level.section_1_civilians.size] = var_0F;
		if(isdefined(var_0E.script_noteworthy) && var_0E.script_noteworthy == "civ_sitting")
		{
			var_0E thread maps\_anim::anim_loop_solo(var_0F,common_scripts\utility::random(var_02));
		}
		else
		{
			var_0E thread maps\_anim::anim_loop_solo(var_0F,common_scripts\utility::random(var_01));
		}

		var_00[var_00.size] = var_0F;
		var_0C = var_0C + 1;
	}

	level.tent_scene_civilians_01 = [];
	level.tent_scene_civilians_02 = [];
	var_11 = common_scripts\utility::getstructarray("civ_tent_scene_01","targetname");
	var_12 = common_scripts\utility::getstructarray("civ_tent_scene_02","targetname");
	var_0C = 0;
	foreach(var_0E in var_12)
	{
		if(var_0C >= var_03.size)
		{
			var_0C = 0;
		}

		if(maps\_shg_design_tools::percentchance(50))
		{
			var_0F = spawn("script_model",var_0E.origin);
			var_0F setmodel(var_03[var_0C]);
			var_0F attach(var_04[var_0C]);
			var_0F setcontents(0);
			var_0F.origin = var_0E.origin;
			var_0F.angles = var_0E.angles;
			var_0F.animname = "drone_civs";
			var_0F maps\_anim::setanimtree();
			var_0F thread maps\detroit_refugee_camp::delete_me_on_notify();
			level.tent_scene_civilians_02[level.tent_scene_civilians_02.size] = var_0F;
			if(var_0E.animation == "civilian_smoking_b" || var_0E.animation == "civilian_smoking_a")
			{
				var_0F attach("prop_cigarette","tag_inhand",1);
			}

			var_0E thread maps\_anim::anim_loop_solo(var_0F,var_0E.animation);
			var_0C = var_0C + 1;
			var_00[var_00.size] = var_0F;
		}
	}

	while(!common_scripts\utility::flag("flag_camp_visibility_04"))
	{
		var_0C = 0;
		foreach(var_0E in var_11)
		{
			if(var_0C >= var_03.size)
			{
				var_0C = 0;
			}

			if(maps\_shg_design_tools::percentchance(50))
			{
				var_0F = spawn("script_model",var_0E.origin);
				var_0F setmodel(var_03[var_0C]);
				var_0F attach(var_04[var_0C]);
				var_0F setcontents(0);
				var_0F.origin = var_0E.origin;
				var_0F.angles = var_0E.angles;
				var_0F.animname = "drone_civs";
				var_0F maps\_anim::setanimtree();
				var_0F thread maps\detroit_refugee_camp::delete_me_on_notify();
				level.tent_scene_civilians_01[level.tent_scene_civilians_01.size] = var_0F;
				if(var_0E.animation == "civilian_smoking_b" || var_0E.animation == "civilian_smoking_a")
				{
					var_0F attach("prop_cigarette","tag_inhand",1);
				}

				var_0E thread maps\_anim::anim_loop_solo(var_0F,var_0E.animation);
				var_0C = var_0C + 1;
				var_00[var_00.size] = var_0F;
			}
		}

		for(var_0C = 0;var_0C < var_00.size;var_0C++)
		{
			if(isdefined(var_00[var_0C]))
			{
				thread cg_kill_entity_on_transition(var_00[var_0C],"tff_pre_intro_to_middle");
			}
		}

		common_scripts\utility::flag_wait("flag_camp_visibility_03b");
		common_scripts\utility::flag_clear("flag_camp_visibility_03a");
		common_scripts\utility::array_thread(level.tent_scene_civilians_01,::maps\_shg_design_tools::delete_auto);
		common_scripts\utility::flag_wait("flag_camp_visibility_03a");
		common_scripts\utility::flag_clear("flag_camp_visibility_03b");
		wait(0.2);
	}

	for(var_0C = 0;var_0C < var_00.size;var_0C++)
	{
		if(isdefined(var_00[var_0C]))
		{
			thread cg_kill_entity_on_transition(var_00[var_0C],"tff_pre_intro_to_middle");
		}
	}

	common_scripts\utility::array_thread(level.section_1_civilians,::maps\_shg_design_tools::delete_auto);
	common_scripts\utility::array_thread(level.tent_scene_civilians_01,::maps\_shg_design_tools::delete_auto);
	common_scripts\utility::array_thread(level.tent_scene_civilians_02,::maps\_shg_design_tools::delete_auto);
}

//Function Number: 7
cg_civ_conversation_gag1()
{
	var_00 = [];
	var_01 = ["civ_urban_female_body_g_afr_light","civ_african_male_body_d","civ_urban_male_body_c_gray_afr_light","civ_urban_female_body_e_asi"];
	var_02 = ["head_f_gen_afr_rice","head_m_gen_cau_clark","head_m_gen_afr_rice","head_f_gen_asi_lee_base"];
	var_03 = ["sign1_spawner","sign2_spawner","sign3_spawner","sign4_spawner"];
	for(var_04 = 1;var_04 < 5;var_04++)
	{
		var_05 = getent("civ_" + var_04 + "_spawner","targetname");
		var_06 = spawn("script_model",var_05.origin);
		var_06 setmodel(var_01[var_04 - 1]);
		var_06 attach(var_02[var_04 - 1]);
		var_06 setcontents(0);
		var_06.angles = var_05.angles;
		var_06.animname = "drone_civs";
		var_06 maps\_anim::setanimtree();
		var_05 thread maps\_anim::anim_loop_solo(var_06,var_03[var_04 - 1]);
		if(var_04 == 1)
		{
			level.civ1 = var_06;
		}

		if(var_04 == 2)
		{
			level.civ2 = var_06;
		}

		if(var_04 == 3)
		{
			level.civ3 = var_06;
		}

		if(var_04 == 4)
		{
			level.civ4 = var_06;
		}

		var_00[var_00.size] = var_06;
	}

	for(var_04 = 0;var_04 < var_00.size;var_04++)
	{
		if(isdefined(var_00[var_04]))
		{
			thread cg_kill_entity_on_transition(var_00[var_04],"tff_pre_intro_to_middle");
		}
	}

	maps\detroit_school::continue_when_player_near_entity(level.civ1,250);
	common_scripts\utility::flag_set("vo_civ_convo_01");
	common_scripts\utility::flag_wait("flag_camp_visibility_04");
	level.civ1 delete();
	level.civ2 delete();
	level.civ3 delete();
	level.civ4 delete();
}

//Function Number: 8
cg_spraypaint_gag()
{
	if(!istransientloaded("detroit_intro_tr"))
	{
		return;
	}

	var_00 = [];
	var_01 = getent("cg_grafitti_gag_model_clip","targetname");
	var_02 = getent("sparaypaint_animspot","targetname");
	var_03 = common_scripts\utility::getstruct("spraypaint_artist_spawner","targetname");
	var_04 = spawn("script_model",var_03.origin);
	var_04 setmodel("civ_urban_female_body_e_asi");
	var_04 attach("head_f_gen_asi_lee_base");
	var_04 setcontents(0);
	var_04 attach("com_spray_can01","tag_weapon_right");
	var_01.origin = var_04.origin + (0,0,40);
	var_01 linkto(var_04,"J_MainRoot");
	var_04.animname = "generic";
	var_04 useanimtree(#animtree);
	var_02 thread maps\_anim::anim_loop_solo(var_04,"spraypaint_idle");
	var_00[var_00.size] = var_04;
	var_04.goalradius = 15;
	if(isdefined(var_04))
	{
		thread cg_kill_entity_on_transition(var_04,"tff_pre_intro_to_middle");
	}

	common_scripts\utility::flag_wait("flag_gesture_spray_paint");
	var_05 = getent("spraypaint_guard","targetname");
	var_06 = var_05 maps\_utility::spawn_ai(1);
	var_06.ignoreall = 1;
	var_06.ignoreme = 1;
	var_06.goalradius = 15;
	var_06.animname = "generic";
	var_02 thread maps\_anim::anim_first_frame_solo(var_06,"chase_away");
	var_00[var_00.size] = var_05;
	for(var_07 = 0;var_07 < var_00.size;var_07++)
	{
		if(isdefined(var_00[var_07]))
		{
			thread cg_kill_entity_on_transition(var_00[var_07],"tff_pre_intro_to_middle");
		}
	}

	thread cg_spraypaint_runner(var_04,var_02);
	thread maps\detroit_refugee_camp::spraypaint_chaser(var_06,var_02);
	wait(7.31);
	var_06 maps\_utility::dialogue_queue("detroit_atd_heyhey");
	thread maps\detroit_refugee_camp::unload_intro_cinematic_assets();
}

//Function Number: 9
cg_spraypaint_runner(param_00,param_01)
{
	param_01 maps\_anim::anim_single_solo(param_00,"spraypaint");
	param_00 delete();
}

//Function Number: 10
cg_setup_refugee_stage_audience()
{
	var_00 = [];
	common_scripts\utility::flag_wait("flag_camp_visibility_01");
	var_01 = [];
	var_02 = getentarray("civilian_orgs_sitting","targetname");
	var_03 = ["body_india_female_a","body_india_male_b","body_india_female_b","civ_urban_female_body_g_afr_light","civ_urban_male_body_e_solid_red_asi","civ_urban_male_body_e_solid_brown_mde","civ_urban_female_body_e_asi","civ_urban_male_body_c_solid_yellow","civ_urban_male_body_b_green_asi"];
	var_04 = ["head_india_female_a","head_india_male_b","head_india_female_b","head_f_gen_afr_rice","head_m_gen_asi_lee","head_m_gen_mde_hanks","head_f_gen_asi_lee_base","head_m_act_cau_ramsay_base","head_m_act_asi_chen_base"];
	var_05 = ["civilian_sitting_talking_b_1","civilian_sitting_business_lunch_b_1","civilian_sitting_business_lunch_a_1","civilian_sitting_talking_a_2","civilian_stand_idle","civilian_sitting_talking_b_2","civilian_stand_idle","civilian_sitting_talking_a_1","civilian_sitting_talking_b_2"];
	var_06 = 0;
	foreach(var_08 in var_02)
	{
		if(var_06 > var_03.size)
		{
			var_06 = 0;
		}

		if(maps\_shg_design_tools::percentchance(15))
		{
			var_09 = spawn("script_model",var_08.origin);
			var_09 setmodel(var_03[var_06]);
			var_09 attach(var_04[var_06]);
			var_09 setcontents(0);
			var_09.angles = var_08.angles;
			var_09.animname = "drone_civs";
			var_09 maps\_anim::setanimtree();
			var_08 thread maps\_anim::anim_loop_solo(var_09,var_08.animation);
			var_01[var_01.size] = var_09;
			level.refugee_camp_ai[level.refugee_camp_ai.size] = var_09;
			var_06 = var_06 + 1;
			var_00[var_00.size] = var_09;
		}

		wait(randomfloat(0.25));
	}

	for(var_06 = 0;var_06 < var_00.size;var_06++)
	{
		if(isdefined(var_00[var_06]))
		{
			thread cg_kill_entity_on_transition(var_00[var_06],"tff_pre_intro_to_middle");
		}
	}

	common_scripts\utility::flag_wait("flag_camp_visibility_04");
	common_scripts\utility::array_call(var_01,::delete);
}

//Function Number: 11
cg_setup_refugee_stage_speaker()
{
	common_scripts\utility::flag_wait("flag_stage_dialogue_start_audio");
	var_00 = getent("refugee_stage_speaker","targetname");
	var_01 = spawn("script_model",var_00.origin);
	var_01 setmodel("civ_urban_female_body_g_afr_light");
	var_01 attach("head_f_gen_afr_rice");
	var_01 setcontents(0);
	var_01.angles = var_00.angles;
	var_01.animname = "Atlas_Commander";
	var_01 useanimtree(#animtree);
	var_00 = getent("org_stage_speaker","targetname");
	var_00 maps\_anim::anim_single_solo(var_01,"det_camp_stagespeech_guy01");
	var_01 delete();
}

//Function Number: 12
cg_setup_hospital_bodies()
{
	maps\_utility::trigger_wait_targetname("hospital_start");
	var_00 = getent("dead_spot","targetname");
	var_01 = spawn("script_model",(-4738,7089,39.5));
	var_01 setmodel("body_civ_sf_male_b");
	var_01 attach("head_civ_sf_male_b","J_Spine4");
	var_01.animname = "generic";
	var_01 useanimtree(#animtree);
	var_00 maps\_anim::anim_first_frame_solo(var_01,"deadpose_1");
}

//Function Number: 13
cg_kill_entity_on_transition(param_00,param_01)
{
	level waittill(param_01);
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 14
cg_kill_entity_on_flag(param_00,param_01)
{
	common_scripts\utility::flag_wait(param_01);
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 15
detroit_cg_precache_models()
{
	var_00 = ["civ_urban_male_body_b_green_afr_dark","civ_urban_male_body_c_blue_mde","civ_urban_male_body_f_black_pants","civ_urban_male_body_e_solid_red","civ_urban_male_body_b_green_mde","civ_urban_male_body_c_solid_yellow_afr_light","civ_urban_male_body_c_solid_yellow","civ_urban_male_body_e","civ_urban_male_body_b_red_afr_light","civ_urban_male_body_e_solid_teal_afr_light","civ_urban_male_body_e_solid_yellow_mde","civ_urban_male_body_c_green_afr_dark","civ_urban_male_body_b_green_asi","civ_urban_male_body_c_solid_teal_afr_light","civ_urban_male_body_b","civ_urban_male_body_a_mde","civ_urban_male_body_e_solid_brown_mde","civ_urban_male_body_e_solid_yellow","civ_urban_male_body_c_mde","civ_urban_male_body_g","civ_urban_male_body_e_solid_brown","civ_urban_male_body_c_blue_afr_light","civ_urban_male_body_c_solid_teal_mde","civ_urban_male_body_c_blue_shirt","civ_urban_male_body_d_afr_light","civ_urban_male_body_c_solid_red_mde","civ_urban_male_body_c_gray_shirt","civ_urban_female_body_g_afr_light","civ_african_male_body_d","civ_urban_male_body_c_gray_afr_light","body_india_female_a","body_india_male_b","body_india_female_b","civ_urban_male_body_e_solid_red_asi","civ_urban_female_body_e_asi","head_m_act_cau_kanik_base","head_m_gen_cau_anderson","head_m_gen_mde_azzam","head_m_gen_afr_davis","head_m_gen_mde_urena","head_m_act_afr_brickerson_base","head_m_act_cau_manasi_base","head_m_act_cau_ramsay_base","head_m_gen_afr_rice","head_m_act_afr_sykes_base","head_m_gen_afr_bowman","head_m_act_asi_chen_base","head_m_gen_mde_smith","head_m_gen_cau_clark","head_m_gen_cau_barton","head_m_gen_mde_hanks","head_m_gen_cau_young","head_india_female_a","head_india_male_b","head_india_female_b","head_m_gen_asi_lee","head_f_gen_afr_rice","head_f_gen_asi_lee_base","ehq_baseball","ehq_baseball_glove_01","prop_cigarette","body_civ_sf_male_b","head_civ_sf_male_b"];
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		precachemodel(var_00[var_01]);
	}
}