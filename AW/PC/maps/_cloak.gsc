/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _cloak.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 58
 * Decompile Time: 1004 ms
 * Timestamp: 4/22/2024 2:20:16 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachestring(&"cloaking_hud_update");
	precacheshader("overlay_hunted_black");
	precacheshader("overlay_static");
	precacheshader("cinematic");
	precacheshader("qr_noise");
	precacheshader("dpad_icon_cloak");
	precacheshader("dpad_icon_cloak_off");
	precacheshader("nightvision_overlay_goggles");
	precachemodel("viewhands_s1_pmc_cloak");
	precachemodel("viewhands_player_sentinel_cloak");
	if(isdefined(0) && 0)
	{
		precacheshader("hud_temperature_gauge");
	}

	level._cloaked_stealth_settings = spawnstruct();
	level._cloaked_stealth_settings.cloak_on = 0;
	level._cloaked_stealth_settings.visibility_range_version = 1;
	init_cloaked_stealth_settings();
	init_player_cloak_state();
	init_cloak_view_model_anims();
	maps\_utility::add_global_spawn_function("allies",::allies_check_cloak_state);
	maps\_utility::add_global_spawn_function("allies",::clear_stencil_on_death);
	thread cloak_hud();
	do_player_cloak_update_threads();
	if(isdefined(0) && 0)
	{
		thread temp_cloak_gauge();
	}

	createthreatbiasgroup("cloak_friendly_npcs");
	createthreatbiasgroup("cloak_enemy_npcs");
	setignoremegroup("cloak_friendly_npcs","cloak_enemy_npcs");
	common_scripts\utility::flag_init("flag_player_cloak_enabled");
	common_scripts\utility::flag_set("_cloaked_stealth_enabled");
	maps\_stealth_utility::stealth_set_default_stealth_function("cloak_enemy_relaxed",::maps\_cloak_enemy_behavior::cloak_enemy_default_setup);
	setomnvar("ui_cloak",1);
	setomnvar("ui_meterhud_enable",1);
	setomnvar("ui_meterhud_ar_and_2d",1);
}

//Function Number: 2
init_cloak_view_model_anims()
{
	level.scr_animtree["cloak_view_model"] = #animtree;
	level.scr_model["cloak_view_model"] = "viewhands_player_sentinel_cloak";
	level.scr_anim["cloak_view_model"]["cloak_on"] = %vm_turn_on_cloak;
	maps\_anim::addnotetrack_customfunction("cloak_view_model","cloak_on",::_cloak_toggle_internal,"cloak_on");
}

//Function Number: 3
allies_check_cloak_state()
{
	if(level._cloaked_stealth_settings.cloak_on == 1)
	{
		setalertstencilstate();
	}
}

//Function Number: 4
axis_check_cloak_state()
{
	if(level._cloaked_stealth_settings.cloak_on == 1)
	{
		setalertstencilstate_axis();
	}
}

//Function Number: 5
clear_stencil_on_death()
{
	self waittill("death");
	clearstencilstateondeath();
}

//Function Number: 6
cloaked_stealth_enable_lab_hud_cinematic()
{
	level._cloaked_stealth_settings.playing_lab_cinematic = 1;
}

//Function Number: 7
cloaked_stealth_disable_lab_hud_cinematic()
{
	level._cloaked_stealth_settings.playing_lab_cinematic = 0;
}

//Function Number: 8
cloaked_stealth_enable_battery_hud()
{
	level._cloaked_stealth_settings.battery_hud_is_visible = 1;
}

//Function Number: 9
cloaked_stealth_disable_battery_hud()
{
	level._cloaked_stealth_settings.battery_hud_is_visible = 0;
}

//Function Number: 10
cloaked_stealth_player_setup(param_00)
{
	if(isdefined(param_00) && param_00)
	{
		common_scripts\utility::flag_set("flag_player_cloak_enabled");
	}

	maps\_stealth_utility::stealth_default();
}

//Function Number: 11
init_player_cloak_overlay()
{
	level.cloak_overlay = newhudelem();
	level.cloak_overlay.x = 0;
	level.cloak_overlay.y = 0;
	level.cloak_overlay.alignx = "left";
	level.cloak_overlay.aligny = "top";
	level.cloak_overlay.horzalign = "fullscreen";
	level.cloak_overlay.vertalign = "fullscreen";
	level.cloak_overlay.color = (1,0,0);
	level.cloak_overlay setshader("overlay_static",640,480);
	level.cloak_overlay.alpha = 0;
}

//Function Number: 12
_cloak_toggle_internal(param_00)
{
	if(level._cloaked_stealth_settings.cloak_on == 1)
	{
		turn_off_the_cloak_effect();
		level._cloaked_stealth_settings.penalty_timer = 1;
		return;
	}

	turn_on_the_cloak_effect();
}

//Function Number: 13
_play_view_model_cloak_toggle_anim()
{
	level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim = 1;
	level.player disableweapons();
	level.player waittill("weapon_change");
	var_00 = maps\_utility::spawn_anim_model("cloak_view_model");
	level._cloaked_stealth_settings.player_rig = var_00;
	var_00 linktoplayerview(level.player,"tag_origin",(0,0,0),(0,0,0),1);
	var_00 drawpostresolve();
	if(level._cloaked_stealth_settings.cloak_on == 1)
	{
		var_00 setmaterialscriptparam(0,0);
	}
	else
	{
		var_00 setmaterialscriptparam(1,0);
	}

	soundscripts\_snd::snd_message("exo_cloak_button_press");
	level.player maps\_anim::anim_single_solo(var_00,"cloak_on");
	level.player enableweapons();
	var_00 unlink();
	level._cloaked_stealth_settings.player_rig = undefined;
	var_00 delete();
	if(level._cloaked_stealth_settings.cloak_on == 0)
	{
		level.player overrideviewmodelmaterialreset();
	}

	level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim = 0;
}

//Function Number: 14
set_cloak_material_for_vm_weapon()
{
	if(level.player getcurrentweapon() != "iw5_unarmed")
	{
		level.player overrideviewmodelmaterialreset();
		if(issubstr(level.player getcurrentweapon(),"iw5_ak12_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_ak12_base_nocamo","mtl_ak12_base_nocamo_cloak");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_arx160_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_arx160_base_nocamo","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_arx160_iron_sights_base","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_arx160_strap_base","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_asm1_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_asm1_base_nocamo","mtl_asm1_base_nocamo_cloak");
			level.player overrideviewmodelmaterial("mtl_asm1_magazine_02_base","mtl_asm1_magazine_02_base_cloak");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_bal27_sp"))
		{
			level.player overrideviewmodelmaterial("_base_black","mtl_bal27_base_black_cloak");
			level.player overrideviewmodelmaterial("mtl_bal27_screen_a_green","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_bal27_magazine_out","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_bal27_magazine_inside","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_bal27_iron_sights","mtl_bal27_base_black_cloak");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_em1_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_em1_base_nocamo","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_en_base_damage","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_em1_iron_sights_base","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_gm6_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_gm6_base_nocamo","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_gm6_scope_base","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_gm6_sight_base","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_hbra3_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_hbra3_base_nocamo","mtl_hbra3_base_nocamo_cloak");
			level.player overrideviewmodelmaterial("mtl_hbra3_base","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_hbra3_sight","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_hbra3_screen","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_himar_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_himar_base","mtl_himar_base_cloak");
			level.player overrideviewmodelmaterial("mtl_himar_glass_base","mtl_himar_glass_base_cloak");
			level.player overrideviewmodelmaterial("mtl_ar_base_handling_01","mtl_ar_base_handling_01_cloak");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_hmr9_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_hmr9_base_nocamo","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_hmr9_bungee_chord","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_mag_dual_clip_base","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_hmr9_ironsights_base","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_hmr9_screen","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_hmr9_text_decals","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_hmr9_stock_base","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_kf5_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_kf5_base","mtl_kf5_base_nocamo_cloak");
			level.player overrideviewmodelmaterial("mtl_kf5_iron_sights_base","mtl_kf5_iron_sights_base_cloak");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_lsat_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_lsat_base","mtl_lsat_base_cloak");
			level.player overrideviewmodelmaterial("mtl_lsat_iron_sights_base","mtl_lsat_iron_sights_base_cloak");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_m990_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_m990_base_nocamo","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_m990_scope","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_m990_sight","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_maaws_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_maaws_base_nocamo","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_maaws_missile_base","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_maul_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_maul_base_nocamo","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_mdl_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_mdl_base","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_mdl_optic","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_mdl_optic_glass","mtl_mdl_optic_glass");
			level.player overrideviewmodelmaterial("mtl_mdl_optic_glow","mtl_mdl_optic_glow");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_mk14_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_mk14_ebr_base_nocamo","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_mors_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_mors_base_nocamo","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_mors_scope","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_mors_sights","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_mp11_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_cbj_ms_base","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_mp443_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_mp443_base_nocamo","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_rhino_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_rhino_base_nocamo","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_rw1_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_rw1_main_base_nocamo","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_rw1_scope_base","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_sac3_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_sac3_base","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_sn6_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_sn6_base_black","mtl_sn6_base_black_nocamo_cloak");
			level.player overrideviewmodelmaterial("mtl_sn6_iron_sights_black","mtl_sn6_iron_sights_black_nocamo_cloak");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_stinger_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_npc_stingerm7_base_black_nocamo","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_stingerm7_base_bottom_black_nocamo","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_stingerm7_base_top_black_nocamo","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_stingerm7_missile_01","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_stingerm7_screens_green","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_stingerm7_iron_sight_black","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_stingerm7_glass","mtl_stingerm7_glass");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_thor_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_thor_base_nocamo","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_thor_scope_base","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_thor_scope_lens","mtl_thor_scope_lens");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_titan45_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_titan45_base_nocamo","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_uts19_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_uts_19_add_on_nocamo","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"iw5_vbr_sp"))
		{
			level.player overrideviewmodelmaterial("mtl_vbr_base_nocamo","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_vbr_siderail","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"opticsacog2"))
		{
			level.player overrideviewmodelmaterial("mtl_acog2_base","mtl_acog2_base_cloak");
			level.player overrideviewmodelmaterial("mtl_mors_lens","mtl_mors_lens_cloak");
		}

		if(issubstr(level.player getcurrentweapon(),"himarscope"))
		{
			level.player overrideviewmodelmaterial("mtl_himar_computer_base","mtl_himar_computer_base_cloak");
			level.player overrideviewmodelmaterial("mtl_himar_reddot_body","mtl_himar_reddot_body_cloak");
		}

		if(issubstr(level.player getcurrentweapon(),"opticsreddot"))
		{
			level.player overrideviewmodelmaterial("mtl_weapon_reddot_body","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_weapon_reddot_lens","mtl_weapon_reddot_lens");
			level.player overrideviewmodelmaterial("mtl_optics_red_dot_small","mtl_optics_red_dot_small");
			level.player overrideviewmodelmaterial("mtl_weapon_reflex_red_dot","mtl_weapon_reflex_red_dot");
		}

		if(issubstr(level.player getcurrentweapon(),"silencer01") || issubstr(level.player getcurrentweapon(),"silencerpistol"))
		{
			level.player overrideviewmodelmaterial("mtl_weapon_silencer_01","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"opticstargetenhancer"))
		{
			level.player overrideviewmodelmaterial("mtl_optics_target_enhancer_body","mtl_optics_target_enhancer_body_cloak");
		}

		if(issubstr(level.player getcurrentweapon(),"variablereddot"))
		{
			level.player overrideviewmodelmaterial("mtl_optics_variable_red_dot","mtl_optics_variable_red_dot_cloak");
			level.player overrideviewmodelmaterial("mtl_optics_variable_red_dot_square","mtl_optics_variable_red_dot_square");
			level.player overrideviewmodelmaterial("mtl_optics_variable_red_dot_glass02","mtl_optics_variable_red_dot_glass02_nodraw");
			level.player overrideviewmodelmaterial("mtl_optics_variable_red_dot_reticle","mtl_optics_variable_red_dot_reticle");
			level.player overrideviewmodelmaterial("mtl_optics_variable_red_dot_cross_reticle","mtl_optics_variable_red_dot_cross_reticle");
			level.player overrideviewmodelmaterial("mtl_optics_variable_red_dot_small","mtl_optics_variable_red_dot_small");
		}

		if(issubstr(level.player getcurrentweapon(),"directhack"))
		{
			level.player overrideviewmodelmaterial("mtl_directhack","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"foregrip"))
		{
			level.player overrideviewmodelmaterial("mtl_foregrip","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"parabolicmicrophone"))
		{
			level.player overrideviewmodelmaterial("mtl_mic_parabolic","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"detech"))
		{
			level.player overrideviewmodelmaterial("mtl_optics_de_tech","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_optics_de_tech_led","mtl_optics_de_tech_led");
			level.player overrideviewmodelmaterial("mtl_optics_de_tech_lens","mtl_optics_de_tech_lens");
			level.player overrideviewmodelmaterial("mtl_optics_de_tech_reticle_base","mtl_optics_de_tech_reticle_base");
			level.player overrideviewmodelmaterial("mtl_weapon_reflex_red_dot","mtl_weapon_reflex_red_dot");
		}

		if(issubstr(level.player getcurrentweapon(),"lasersight"))
		{
			level.player overrideviewmodelmaterial("mtl_weapon_lasersight_01","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"ironsights"))
		{
			level.player overrideviewmodelmaterial("_iron_sights_black","cloak_generic");
			level.player overrideviewmodelmaterial("_iron_sights_color","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"opticseotech"))
		{
			level.player overrideviewmodelmaterial("mtl_weapon_eotech_body","mtl_weapon_eotech_body_cloak");
			level.player overrideviewmodelmaterial("mtl_weapon_eotech_lense","mtl_weapon_eotech_lense_nodraw");
			level.player overrideviewmodelmaterial("mtl_weapon_reflex_red_dot","mtl_weapon_reflex_red_dot");
		}

		if(issubstr(level.player getcurrentweapon(),"opticsthermal"))
		{
			level.player overrideviewmodelmaterial("mtl_weapon_thermal_scope_iw5","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_weapon_thermal_scope_iw5_lens","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_weapon_thermal_scope_scanlines","mtl_weapon_thermal_scope_scanlines");
			level.player overrideviewmodelmaterial("mtl_weapon_thermal_scope_screen","mtl_weapon_thermal_scope_screen");
			level.player overrideviewmodelmaterial("scope_overlay_m14_night","scope_overlay_m14_night");
			level.player overrideviewmodelmaterial("scope_overlay_m14_night_low_res","scope_overlay_m14_night_low_res");
			level.player overrideviewmodelmaterial("scope_overlay_m14_night_emp","scope_overlay_m14_night_emp");
			level.player overrideviewmodelmaterial("scope_overlay_m14_night_emp_low_res","scope_overlay_m14_night_emp_low_res");
		}

		if(issubstr(level.player getcurrentoffhand(),"grenade"))
		{
			level.player overrideviewmodelmaterial("mtl_variable_grenade_lethal","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_variable_grenade_nonlethal","cloak_generic");
		}

		if(issubstr(level.player getcurrentweapon(),"exo_shield"))
		{
			level.player overrideviewmodelmaterial("mtl_exo_riot_shield_base","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_exo_riot_shield_canvas","cloak_generic");
			level.player overrideviewmodelmaterial("mtl_exo_riot_shield_mesh","cloak_generic");
		}
	}
}

//Function Number: 15
set_cloak_material_for_npc_weapon()
{
	if(self.weapon != "iw5_unarmed")
	{
		if(issubstr(self.weapon,"iw5_ak12_sp"))
		{
			self overridematerial("mtl_ak12_base_nocamo","mtl_ak12_base_nocamo_cloak");
		}

		if(issubstr(self.weapon,"iw5_arx160_sp"))
		{
			level.player overridematerial("mtl_arx160_base_nocamo","cloak_generic");
			self overridematerial("mtl_arx160_iron_sights_base","cloak_generic");
			self overridematerial("mtl_arx160_strap_base","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_asm1_sp"))
		{
			self overridematerial("mtl_asm1_base_nocamo","mtl_asm1_base_nocamo_cloak");
			self overridematerial("mtl_asm1_magazine_02_base","mtl_asm1_magazine_02_base_cloak");
		}

		if(issubstr(self.weapon,"iw5_bal27_sp"))
		{
			self overridematerial("_base_black","mtl_bal27_base_black_cloak");
			self overridematerial("mtl_bal27_screen_a_green","cloak_generic");
			self overridematerial("mtl_bal27_magazine_out","cloak_generic");
			self overridematerial("mtl_bal27_magazine_inside","cloak_generic");
			self overridematerial("mtl_bal27_iron_sights","mtl_bal27_base_black_cloak");
		}

		if(issubstr(self.weapon,"iw5_em1_sp"))
		{
			self overridematerial("mtl_em1_base_nocamo","cloak_generic");
			self overridematerial("mtl_en_base_damage","cloak_generic");
			self overridematerial("mtl_em1_iron_sights_base","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_gm6_sp"))
		{
			self overridematerial("mtl_gm6_base_nocamo","cloak_generic");
			self overridematerial("mtl_gm6_scope_base","cloak_generic");
			self overridematerial("mtl_gm6_sight_base","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_hbra3_sp"))
		{
			self overridematerial("mtl_hbra3_base_nocamo","mtl_hbra3_base_nocamo_cloak");
			self overridematerial("mtl_hbra3_base","mtl_hbra3_base_cloak");
			self overridematerial("mtl_hbra3_sight","mtl_hbra3_sight_cloak");
			self overridematerial("mtl_hbra3_screen","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_himar_sp"))
		{
			self overridematerial("mtl_himar_base","mtl_himar_base_cloak");
			self overridematerial("mtl_himar_glass_base","mtl_himar_glass_base_cloak");
			self overridematerial("mtl_ar_base_handling_01","mtl_ar_base_handling_01_cloak");
			self overridematerial("mtl_himar_iron_sights_base","mtl_himar_iron_sights_base_cloak");
		}

		if(issubstr(self.weapon,"iw5_hmr9_sp"))
		{
			self overridematerial("mtl_hmr9_base_nocamo","cloak_generic");
			self overridematerial("mtl_hmr9_ironsights_base","cloak_generic");
			self overridematerial("mtl_hmr9_screen","cloak_generic");
			self overridematerial("mtl_hmr9_text_decals","cloak_generic");
			self overridematerial("mtl_hmr9_stock_base","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_kf5_sp"))
		{
			self overridematerial("mtl_kf5_base","mtl_kf5_base_nocamo_cloak");
			self overridematerial("mtl_kf5_iron_sights_base","mtl_kf5_iron_sights_base_cloak");
		}

		if(issubstr(self.weapon,"iw5_lsat_sp"))
		{
			self overridematerial("mtl_lsat_base_nocamo","mtl_lsat_base_nocamo_cloak");
			self overridematerial("mtl_lsat_iron_sights_base","mtl_lsat_iron_sights_base_cloak");
		}

		if(issubstr(self.weapon,"iw5_m990_sp"))
		{
			self overridematerial("mtl_m990_base_nocamo","cloak_generic");
			self overridematerial("mtl_m990_scope","cloak_generic");
			self overridematerial("mtl_m990_sight","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_maaws_sp"))
		{
			self overridematerial("mtl_maaws_base_nocamo","cloak_generic");
			self overridematerial("mtl_maaws_missile_base","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_maul_sp"))
		{
			self overridematerial("mtl_maul_base_nocamo","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_mdl_sp"))
		{
			self overridematerial("mtl_mdl_base","cloak_generic");
			self overridematerial("mtl_mdl_optic","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_mk14_sp"))
		{
			self overridematerial("mtl_mk14_ebr_base_nocamo","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_mors_sp"))
		{
			self overridematerial("mtl_mors_base_nocamo","cloak_generic");
			self overridematerial("mtl_mors_scope","cloak_generic");
			self overridematerial("mtl_mors_sights","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_mp11_sp"))
		{
			self overridematerial("mtl_cbj_ms_base","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_mp443_sp"))
		{
			self overridematerial("mtl_mp443_base_nocamo","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_rhino_sp"))
		{
			self overridematerial("mtl_rhino_base_nocamo","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_rw1_sp"))
		{
			self overridematerial("mtl_rw1_main_base_nocamo","cloak_generic");
			self overridematerial("mtl_rw1_scope_base","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_sac3_sp"))
		{
			self overridematerial("mtl_sac3_base","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_sn6_sp"))
		{
			self overridematerial("mtl_sn6_base_black","mtl_sn6_base_black_nocamo_cloak");
			self overridematerial("mtl_sn6_iron_sights_black","mtl_sn6_iron_sights_black_nocamo_cloak");
		}

		if(issubstr(self.weapon,"iw5_stinger_sp"))
		{
			self overridematerial("mtl_npc_stingerm7_base_black_nocamo","cloak_generic");
			self overridematerial("mtl_stingerm7_base_bottom_black_nocamo","cloak_generic");
			self overridematerial("mtl_stingerm7_base_top_black_nocamo","cloak_generic");
			self overridematerial("mtl_stingerm7_missile_01","cloak_generic");
			self overridematerial("mtl_stingerm7_screens_green","cloak_generic");
			self overridematerial("mtl_stingerm7_iron_sight_black","cloak_generic");
			self overridematerial("mtl_stingerm7_glass","mtl_stingerm7_glass");
		}

		if(issubstr(self.weapon,"iw5_thor_sp"))
		{
			self overridematerial("mtl_thor_base_nocamo","cloak_generic");
			self overridematerial("mtl_thor_scope_base","cloak_generic");
			self overridematerial("mtl_thor_scope_lens","mtl_thor_scope_lens");
		}

		if(issubstr(self.weapon,"iw5_titan45_sp"))
		{
			self overridematerial("mtl_titan45_base_nocamo","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_uts19_sp"))
		{
			self overridematerial("mtl_uts_19_add_on_nocamo","cloak_generic");
		}

		if(issubstr(self.weapon,"iw5_vbr_sp"))
		{
			self overridematerial("mtl_vbr_base_nocamo","cloak_generic");
			self overridematerial("mtl_vbr_siderail","cloak_generic");
		}

		if(issubstr(self.weapon,"opticsacog2"))
		{
			self overridematerial("mtl_acog2_base","mtl_acog2_base_cloak");
		}

		if(issubstr(self.weapon,"himarscope"))
		{
			self overridematerial("mtl_himar_computer_base","mtl_himar_computer_base_cloak");
			self overridematerial("mtl_himar_reddot_body","mtl_himar_reddot_body_cloak");
		}

		if(issubstr(self.weapon,"opticsreddot"))
		{
			self overridematerial("mtl_weapon_reddot_body","mtl_weapon_reddot_body_cloak");
		}

		if(issubstr(self.weapon,"silencer01"))
		{
			self overridematerial("mtl_weapon_silencer_01","mtl_weapon_silencer_01_cloak");
		}

		if(issubstr(self.weapon,"opticstargetenhancer"))
		{
			self overridematerial("mtl_optics_target_enhancer_body","mtl_optics_target_enhancer_body_cloak");
		}

		if(issubstr(self.weapon,"variablereddot"))
		{
			self overridematerial("mtl_optics_variable_red_dot","mtl_optics_variable_red_dot_cloak");
			self overridematerial("mtl_optics_variable_red_dot_glass02","mtl_optics_variable_red_dot_glass02_nodraw");
		}

		if(issubstr(self.weapon,"directhack"))
		{
			self overridematerial("mtl_directhack","cloak_generic");
		}

		if(issubstr(self.weapon,"foregrip"))
		{
			self overridematerial("mtl_foregrip","cloak_generic");
		}

		if(issubstr(self.weapon,"parabolicmicrophone"))
		{
			self overridematerial("mtl_mic_parabolic","cloak_generic");
		}

		if(issubstr(self.weapon,"detech"))
		{
			self overridematerial("mtl_optics_de_tech","cloak_generic");
		}

		if(issubstr(self.weapon,"lasersight"))
		{
			self overridematerial("mtl_weapon_lasersight_01","cloak_generic");
		}

		if(issubstr(self.weapon,"ironsights"))
		{
			self overridematerial("_iron_sights_black","cloak_generic");
			self overridematerial("_iron_sights_color","cloak_generic");
		}

		if(issubstr(self.weapon,"opticseotech"))
		{
			self overridematerial("mtl_weapon_eotech_body","mtl_weapon_eotech_body_cloak");
		}

		if(issubstr(self.weapon,"opticsthermal"))
		{
			self overridematerial("mtl_weapon_thermal_scope","mtl_weapon_thermal_scope_cloak");
		}
	}
}

//Function Number: 16
cloak_vm_weapon_instantaneous()
{
	set_cloak_material_for_vm_weapon();
	level.player setviewmodelmaterialscriptparam(0,0);
}

//Function Number: 17
cloak_vm_weapon_blend()
{
	wait(0.1);
	set_cloak_material_for_vm_weapon();
	level.player setviewmodelmaterialscriptparam(1,0);
	wait(0.05);
	level.player setviewmodelmaterialscriptparam(0,0.75);
}

//Function Number: 18
cloak_npc_weapon_instantaneous()
{
	set_cloak_material_for_npc_weapon();
	self setmaterialscriptparam(0,0);
}

//Function Number: 19
monitor_player_weapon_for_cloak()
{
	var_00 = level.player getcurrentweapon();
	for(;;)
	{
		var_01 = level.player getcurrentweapon();
		if(var_01 != var_00)
		{
			if(level._cloaked_stealth_settings.cloak_on)
			{
				wait(0.1);
				cloak_vm_weapon_instantaneous();
			}

			var_00 = var_01;
		}

		if(level.player ismeleeing())
		{
			if(level._cloaked_stealth_settings.cloak_on)
			{
				wait(0.1);
				cloak_vm_weapon_instantaneous();
			}
		}

		wait(0.05);
	}
}

//Function Number: 20
check_for_npc_weapon_cloak_status_update()
{
	self endon("death");
	self notify("check_for_npc_weapon_cloak_status_update");
	self endon("check_for_npc_weapon_cloak_status_update");
	var_00 = self.weapon;
	for(;;)
	{
		if(isdefined(self.cloak))
		{
			var_01 = self.weapon;
			if(var_01 != var_00)
			{
				if(self.cloak == "on")
				{
					wait(0.1);
					cloak_npc_weapon_instantaneous();
				}

				var_00 = var_01;
			}
		}

		wait(0.05);
	}
}

//Function Number: 21
turn_on_the_cloak_effect_when_able()
{
	while(isdefined(level._cloaked_stealth_settings.cloaking_visual_effect_in_progress))
	{
		wait(0.05);
	}

	level._cloaked_stealth_settings.cloaking_visual_effect_in_progress = 1;
	var_00 = 0;
	level.player setviewmodel("viewhands_s1_pmc_cloak");
	thread cloak_vm_weapon_blend();
	level.player drawpostresolve();
	level.player hudoutlineenable(0);
	if(isdefined(level._cloaked_stealth_settings.player_rig))
	{
		level._cloaked_stealth_settings.player_rig setmaterialscriptparam(0,0.3);
		var_00 = 0.3;
		level._cloaked_stealth_settings.player_rig hudoutlineenable(0);
	}

	if(isdefined(level.scr_model["player_rig"]))
	{
		level.scr_model["player_rig"] = "viewbody_sentinel_covert_cloak";
	}

	if(isdefined(level.player_rig))
	{
		level.player_rig setmodel(level.scr_model["player_rig"]);
		level.player_rig drawpostresolve();
		level.player_rig setmaterialscriptparam(0,0.3);
		var_00 = 0.3;
		level.player_rig hudoutlineenable(0);
	}

	wait(var_00);
	level._cloaked_stealth_settings.cloaking_visual_effect_in_progress = undefined;
}

//Function Number: 22
turn_on_the_cloak_effect()
{
	level._cloaked_stealth_settings.cloak_on = 1;
	soundscripts\_snd::snd_message("exo_cloak_enable");
	if(level._cloaked_stealth_settings.visibility_range_version == 1)
	{
		maps\_stealth_utility::stealth_detect_ranges_set(level._cloaked_stealth_settings.ranges["cloak_on_hidden"],level._cloaked_stealth_settings.ranges["cloak_on_spotted"]);
	}

	thread turn_on_the_cloak_effect_when_able();
}

//Function Number: 23
turn_off_the_cloak_effect_when_able()
{
	while(level.player ismeleeing() || isdefined(level._cloaked_stealth_settings.cloaking_visual_effect_in_progress))
	{
		wait(0.05);
	}

	level._cloaked_stealth_settings.cloaking_visual_effect_in_progress = 1;
	var_00 = 0;
	level.player setviewmodel("viewhands_player_sentinel");
	level.player drawpostresolveoff();
	level.player hudoutlinedisable();
	if(isdefined(level._cloaked_stealth_settings.player_rig))
	{
		level._cloaked_stealth_settings.player_rig setmaterialscriptparam(1,0.2);
		var_00 = 0.2;
		level._cloaked_stealth_settings.player_rig hudoutlinedisable();
		soundscripts\_snd::snd_message("exo_cloak_disable");
	}

	level.player overrideviewmodelmaterialreset();
	if(isdefined(level.scr_model["player_rig"]))
	{
		level.scr_model["player_rig"] = "viewbody_sentinel_covert";
	}

	if(isdefined(level.player_rig))
	{
		level.player_rig drawpostresolveoff();
		level.player_rig setmaterialscriptparam(1,0.3);
		var_00 = 0.3;
		level.player_rig setmodel(level.scr_model["player_rig"]);
		level.player_rig hudoutlinedisable();
	}

	wait(var_00);
	level._cloaked_stealth_settings.cloaking_visual_effect_in_progress = undefined;
}

//Function Number: 24
turn_off_the_cloak_effect()
{
	level._cloaked_stealth_settings.cloak_on = 0;
	if(level._cloaked_stealth_settings.visibility_range_version == 1)
	{
		maps\_stealth_utility::stealth_detect_ranges_set(level._cloaked_stealth_settings.ranges["cloak_off_hidden"],level._cloaked_stealth_settings.ranges["cloak_off_spotted"]);
	}

	thread turn_off_the_cloak_effect_when_able();
}

//Function Number: 25
set_player_detection_distance_for_speed(param_00)
{
	if(!isdefined(level._cloaked_stealth_settings.current_speed))
	{
		level._cloaked_stealth_settings.current_speed = -1;
	}

	if(level._cloaked_stealth_settings.current_speed != param_00)
	{
		level._cloaked_stealth_settings.current_speed = param_00;
		if(isdefined(level.player._stealth) && level.player [[ level.player._stealth.logic.getinshadow_func ]]())
		{
			maps\_stealth_utility::stealth_detect_ranges_set(level._cloaked_stealth_settings.visibility_distance["shadow"][param_00],level._cloaked_stealth_settings.visibility_distance["shadow"][param_00]);
		}
		else
		{
			maps\_stealth_utility::stealth_detect_ranges_set(level._cloaked_stealth_settings.visibility_distance[param_00],level._cloaked_stealth_settings.visibility_distance[param_00]);
		}

		if(param_00 == 1000)
		{
			maps\_stealth_visibility_system::system_default_event_distances();
			var_01 = level._stealth.logic.detection_level;
			maps\_stealth_visibility_system::system_event_change(var_01);
		}
		else if(isdefined(level.player._stealth) && level.player [[ level.player._stealth.logic.getinshadow_func ]]())
		{
			maps\_stealth_utility::stealth_ai_event_dist_custom(level._cloaked_stealth_settings.event_distance["shadow"][param_00]);
		}
		else
		{
			maps\_stealth_utility::stealth_ai_event_dist_custom(level._cloaked_stealth_settings.event_distance[param_00]);
		}
	}

	if(level.player maps\_utility::ent_flag_exist("_stealth_in_mute_radius") && level.player maps\_utility::ent_flag("_stealth_in_mute_radius"))
	{
		override_event_distances_for_mute_volume();
	}
}

//Function Number: 26
do_player_cloak_update_threads()
{
	if(level._cloaked_stealth_settings.visibility_range_version == 2)
	{
		thread monitor_player_speed_for_cloak();
	}

	thread monitor_player_weapon_for_cloak();
	thread monitor_player_damage_for_cloak();
	thread monitor_player_fire_for_cloak();
}

//Function Number: 27
monitor_player_damage_for_cloak()
{
	while(!isdefined(level.player))
	{
		wait(0.1);
	}

	for(;;)
	{
		level.player waittill("damage");
		if(level._cloaked_stealth_settings.cloak_on == 1 && !isdefined(level._cloaked_stealth_settings.cloak_disabled))
		{
			cloak_device_hit_by_electro_magnetic_pulse();
		}
	}
}

//Function Number: 28
monitor_player_fire_for_cloak()
{
	while(!isdefined(level.player))
	{
		wait(0.1);
	}

	for(;;)
	{
		level.player waittill("weapon_fired",var_00);
		if(!common_scripts\utility::flag("flag_player_cloak_enabled"))
		{
			return;
		}

		if(issubstr(var_00,"silence"))
		{
			continue;
		}

		if(level._cloaked_stealth_settings.cloak_on == 1 && !isdefined(level._cloaked_stealth_settings.cloak_disabled))
		{
			cloak_device_hit_by_electro_magnetic_pulse();
		}
	}
}

//Function Number: 29
monitor_player_speed_for_cloak()
{
	for(;;)
	{
		if(isdefined(level.player) && isdefined(level._cloaked_stealth_settings))
		{
			if(level._cloaked_stealth_settings.cloak_on == 1 && !isdefined(level._cloaked_stealth_settings.cloak_disabled))
			{
				var_00 = level.player maps\_shg_utility::get_differentiated_speed();
				if(var_00 < 50)
				{
					set_player_detection_distance_for_speed(0);
				}
				else if(var_00 < 100)
				{
					set_player_detection_distance_for_speed(50);
				}
				else if(var_00 < 150)
				{
					set_player_detection_distance_for_speed(100);
				}
				else if(var_00 < 200)
				{
					set_player_detection_distance_for_speed(150);
				}
				else if(var_00 < 250)
				{
					set_player_detection_distance_for_speed(200);
				}
				else if(var_00 < 300)
				{
					set_player_detection_distance_for_speed(250);
				}
				else if(var_00 < 350)
				{
					set_player_detection_distance_for_speed(300);
				}
				else if(var_00 < 400)
				{
					set_player_detection_distance_for_speed(350);
				}
				else
				{
					set_player_detection_distance_for_speed(400);
				}
			}
			else
			{
				set_player_detection_distance_for_speed(1000);
			}
		}

		wait(0.05);
	}
}

//Function Number: 30
cloak_device_hit_by_electro_magnetic_pulse()
{
	level._cloaked_stealth_settings.cloak_battery_level = level._cloaked_stealth_settings.battery_min;
	turn_off_the_cloak_effect();
	soundscripts\_snd::snd_message("exo_cloak_battery_dead");
	level._cloaked_stealth_settings.penalty_timer = 5;
	level._cloaked_stealth_settings.must_wait_for_full_charge = 1;
}

//Function Number: 31
cloak_battery_hud()
{
	self endon("death");
	var_00 = 0.05;
	var_01 = var_00 / 120;
	var_02 = var_00 / 22;
	var_03 = var_00 / 2.5;
	var_04 = var_00 / 90;
	level._cloaked_stealth_settings.battery_min = 0.01;
	level._cloaked_stealth_settings.cloak_battery_level = 1;
	level._cloaked_stealth_settings.penalty_timer = 0;
	level._cloaked_stealth_settings.must_wait_for_full_charge = 0;
	level._cloaked_stealth_settings.auto_recloak = 0;
	var_05 = 0;
	for(;;)
	{
		if(level._cloaked_stealth_settings.cloak_on == 1)
		{
			if(1)
			{
				var_06 = level.player maps\_shg_utility::get_differentiated_speed();
				if(var_06 < 10)
				{
					if(var_05 > 0)
					{
						var_05 = var_05 - var_00;
					}
					else
					{
						level._cloaked_stealth_settings.cloak_battery_level = level._cloaked_stealth_settings.cloak_battery_level + var_04;
						if(level._cloaked_stealth_settings.cloak_battery_level > 1)
						{
							level._cloaked_stealth_settings.cloak_battery_level = 1;
							level._cloaked_stealth_settings.must_wait_for_full_charge = 0;
						}
					}
				}
				else
				{
					var_05 = 1;
					var_07 = var_06 / 500;
					if(var_07 < 0)
					{
						var_07 = 0;
					}
					else if(var_07 > 1)
					{
						var_07 = 1;
					}

					var_08 = 40 * var_07 * var_07 * var_07;
					level._cloaked_stealth_settings.cloak_battery_level = level._cloaked_stealth_settings.cloak_battery_level - var_08 * var_02;
					if(level._cloaked_stealth_settings.cloak_battery_level <= level._cloaked_stealth_settings.battery_min)
					{
						level._cloaked_stealth_settings.cloak_battery_level = level._cloaked_stealth_settings.battery_min;
						turn_off_the_cloak_effect();
						soundscripts\_snd::snd_message("exo_cloak_battery_dead");
						level._cloaked_stealth_settings.penalty_timer = 1;
						level._cloaked_stealth_settings.must_wait_for_full_charge = 1;
						if(0)
						{
							level._cloaked_stealth_settings.auto_recloak = 1;
						}
					}
				}
			}
			else
			{
				level._cloaked_stealth_settings.cloak_battery_level = level._cloaked_stealth_settings.cloak_battery_level - var_02;
				if(level._cloaked_stealth_settings.cloak_battery_level <= level._cloaked_stealth_settings.battery_min)
				{
					level._cloaked_stealth_settings.cloak_battery_level = level._cloaked_stealth_settings.battery_min;
					turn_off_the_cloak_effect();
					soundscripts\_snd::snd_message("exo_cloak_battery_dead");
					level._cloaked_stealth_settings.penalty_timer = 1;
					level._cloaked_stealth_settings.must_wait_for_full_charge = 1;
				}
			}
		}
		else if(1)
		{
			if(var_05 > 0 || level._cloaked_stealth_settings.penalty_timer > 0)
			{
				var_05 = var_05 - var_00;
				level._cloaked_stealth_settings.penalty_timer = level._cloaked_stealth_settings.penalty_timer - var_00;
			}
			else
			{
				level._cloaked_stealth_settings.cloak_battery_level = level._cloaked_stealth_settings.cloak_battery_level + var_03;
				if(level._cloaked_stealth_settings.cloak_battery_level > 1)
				{
					level._cloaked_stealth_settings.cloak_battery_level = 1;
					level._cloaked_stealth_settings.must_wait_for_full_charge = 0;
					if(0 && level._cloaked_stealth_settings.auto_recloak)
					{
						level._cloaked_stealth_settings.auto_recloak = 0;
						turn_on_the_cloak_effect();
					}
				}
			}
		}
		else if(level._cloaked_stealth_settings.penalty_timer > 0)
		{
			level._cloaked_stealth_settings.penalty_timer = level._cloaked_stealth_settings.penalty_timer - var_00;
		}
		else
		{
			level._cloaked_stealth_settings.cloak_battery_level = level._cloaked_stealth_settings.cloak_battery_level + var_03;
			if(level._cloaked_stealth_settings.cloak_battery_level > 1)
			{
				level._cloaked_stealth_settings.cloak_battery_level = 1;
				level._cloaked_stealth_settings.must_wait_for_full_charge = 0;
				if(0 && level._cloaked_stealth_settings.auto_recloak)
				{
					level._cloaked_stealth_settings.auto_recloak = 0;
					turn_on_the_cloak_effect();
				}
			}
		}

		var_09 = int(100 * level._cloaked_stealth_settings.cloak_battery_level);
		if(isdefined(level._cloaked_stealth_settings.battery_hud_is_visible) && level._cloaked_stealth_settings.battery_hud_is_visible == 1)
		{
			level.player setclientomnvar("ui_cloak",common_scripts\utility::flag("flag_player_cloak_enabled"));
			level.player setclientomnvar("ui_cloak_cinematic",0);
			level.player setclientomnvar("ui_cloak_on",level._cloaked_stealth_settings.cloak_on);
			level.player setclientomnvar("ui_cloak_health",var_09);
			level.player setclientomnvar("ui_meterhud_toggle",common_scripts\utility::flag("flag_player_cloak_enabled"));
			level.player setclientomnvar("ui_meterhud_text",level._cloaked_stealth_settings.cloak_on);
			level.player setclientomnvar("ui_meterhud_level",level._cloaked_stealth_settings.cloak_battery_level);
		}
		else
		{
			level.player setclientomnvar("ui_cloak",0);
			level.player setclientomnvar("ui_meterhud_toggle",0);
			level.player setclientomnvar("ui_meterhud_text",level._cloaked_stealth_settings.cloak_on);
		}

		wait(var_00);
	}
}

//Function Number: 32
cloak_hud()
{
	level.player endon("death");
	level.player notifyonplayercommand("cloak_button_pressed","+actionslot 4");
	level.player setweaponhudiconoverride("actionslot4","dpad_icon_cloak");
	thread cloak_battery_hud();
	level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim = 0;
	if(level._cloaked_stealth_settings.cloak_on == 1)
	{
		turn_on_the_cloak_effect();
	}
	else
	{
		turn_off_the_cloak_effect();
	}

	for(;;)
	{
		level.player waittill("cloak_button_pressed");
		if(common_scripts\utility::flag("flag_player_cloak_enabled"))
		{
			if(!common_scripts\utility::flag("flag_player_cloak_on_pressed"))
			{
				common_scripts\utility::flag_set("flag_player_cloak_on_pressed");
			}

			if(!level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim)
			{
				if(level._cloaked_stealth_settings.cloak_on == 1)
				{
					if(!isdefined(level.player_rig))
					{
						thread _play_view_model_cloak_toggle_anim();
					}

					continue;
				}

				if(level._cloaked_stealth_settings.cloak_battery_level > level._cloaked_stealth_settings.battery_min)
				{
					if(level._cloaked_stealth_settings.must_wait_for_full_charge == 0)
					{
						if(!isdefined(level.player_rig))
						{
							thread _play_view_model_cloak_toggle_anim();
						}
					}
				}
			}
		}
	}
}

//Function Number: 33
_ensure_player_is_decloaked()
{
	while(level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim)
	{
		wait(0.05);
	}

	if(level._cloaked_stealth_settings.cloak_on == 1)
	{
		_play_view_model_cloak_toggle_anim();
	}
}

//Function Number: 34
disable_cloak_system(param_00)
{
	common_scripts\utility::flag_clear("flag_player_cloak_enabled");
	cloaked_stealth_disable_battery_hud();
	level.player setweaponhudiconoverride("actionslot4","dpad_icon_cloak_off");
	if(isdefined(param_00) && param_00)
	{
		thread _ensure_player_is_decloaked();
		return;
	}

	if(level._cloaked_stealth_settings.cloak_on == 1)
	{
		turn_off_the_cloak_effect();
	}
}

//Function Number: 35
init_cloaked_stealth_settings()
{
	if(level._cloaked_stealth_settings.visibility_range_version == 1)
	{
		init_cloaked_stealth_visibility_range_v1();
	}
	else
	{
		init_cloaked_stealth_detection_range();
	}

	set_corpse_detection_ranges_for_cloak_system();
	soundscripts\_snd::snd_message("snd_cloak_init");
}

//Function Number: 36
init_player_cloak_state()
{
	if(level._cloaked_stealth_settings.visibility_range_version == 1)
	{
		maps\_stealth_utility::stealth_detect_ranges_set(level._cloaked_stealth_settings.ranges["cloak_off_hidden"],level._cloaked_stealth_settings.ranges["cloak_off_spotted"]);
		return;
	}

	set_player_detection_distance_for_speed(0);
}

//Function Number: 37
init_cloaked_stealth_visibility_range_v1()
{
	level._cloaked_stealth_settings.ranges = [];
	level._cloaked_stealth_settings.ranges["cloak_on_hidden"]["prone"] = 70;
	level._cloaked_stealth_settings.ranges["cloak_on_hidden"]["crouch"] = 90;
	level._cloaked_stealth_settings.ranges["cloak_on_hidden"]["stand"] = 150;
	level._cloaked_stealth_settings.ranges["cloak_on_spotted"]["prone"] = 150;
	level._cloaked_stealth_settings.ranges["cloak_on_spotted"]["crouch"] = 400;
	level._cloaked_stealth_settings.ranges["cloak_on_spotted"]["stand"] = 512;
	level._cloaked_stealth_settings.ranges["cloak_off_hidden"]["prone"] = 70;
	level._cloaked_stealth_settings.ranges["cloak_off_hidden"]["crouch"] = 600;
	level._cloaked_stealth_settings.ranges["cloak_off_hidden"]["stand"] = 1024;
	level._cloaked_stealth_settings.ranges["cloak_off_spotted"]["prone"] = 512;
	level._cloaked_stealth_settings.ranges["cloak_off_spotted"]["crouch"] = 5000;
	level._cloaked_stealth_settings.ranges["cloak_off_spotted"]["stand"] = 8000;
}

//Function Number: 38
get_detection_distance_for_player_speed(param_00)
{
	var_01 = 92;
	var_02 = 200;
	var_03 = 400;
	return var_02 - var_01 * param_00 / var_03 + var_01;
}

//Function Number: 39
init_uncloaked_detection_distance_setting(param_00)
{
	var_01 = 450;
	level._cloaked_stealth_settings.visibility_distance[param_00]["prone"] = var_01 * 0.6;
	level._cloaked_stealth_settings.visibility_distance[param_00]["crouch"] = var_01 * 0.8;
	level._cloaked_stealth_settings.visibility_distance[param_00]["stand"] = var_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistDeath"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistPain"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistBullet"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstep"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstepWalk"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstepSprint"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistNewEnemy"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistGunShot"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistExplosion"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistDeath"]["spotted"] = var_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistDeath"]["hidden"] = var_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistPain"]["spotted"] = var_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistPain"]["hidden"] = var_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistBullet"]["spotted"] = var_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistBullet"]["hidden"] = var_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstep"]["spotted"] = var_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstep"]["hidden"] = var_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstepWalk"]["spotted"] = var_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstepWalk"]["hidden"] = var_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstepSprint"]["spotted"] = var_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstepSprint"]["hidden"] = var_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistNewEnemy"]["spotted"] = var_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistNewEnemy"]["hidden"] = var_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistGunShot"]["spotted"] = 6000;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistGunShot"]["hidden"] = 6000;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistExplosion"]["spotted"] = 6000;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistExplosion"]["hidden"] = 6000;
}

//Function Number: 40
init_detection_distance_setting(param_00,param_01)
{
	level._cloaked_stealth_settings.visibility_distance[param_00]["prone"] = param_01;
	level._cloaked_stealth_settings.visibility_distance[param_00]["crouch"] = param_01;
	level._cloaked_stealth_settings.visibility_distance[param_00]["stand"] = param_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistDeath"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistPain"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistBullet"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstep"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstepWalk"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstepSprint"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistNewEnemy"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistGunShot"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistExplosion"] = [];
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistDeath"]["spotted"] = param_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistDeath"]["hidden"] = param_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistPain"]["spotted"] = param_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistPain"]["hidden"] = param_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistBullet"]["spotted"] = param_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistBullet"]["hidden"] = param_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstep"]["spotted"] = param_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstep"]["hidden"] = param_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstepWalk"]["spotted"] = param_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstepWalk"]["hidden"] = param_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstepSprint"]["spotted"] = param_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistFootstepSprint"]["hidden"] = param_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistNewEnemy"]["spotted"] = param_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistNewEnemy"]["hidden"] = param_01;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistGunShot"]["spotted"] = 6000;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistGunShot"]["hidden"] = 6000;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistExplosion"]["spotted"] = 6000;
	level._cloaked_stealth_settings.event_distance[param_00]["ai_eventDistExplosion"]["hidden"] = 6000;
}

//Function Number: 41
init_uncloaked_detection_distance_setting_for_shadow(param_00)
{
	var_01 = 225;
	level._cloaked_stealth_settings.visibility_distance["shadow"][param_00]["prone"] = var_01 * 0.6;
	level._cloaked_stealth_settings.visibility_distance["shadow"][param_00]["crouch"] = var_01 * 0.8;
	level._cloaked_stealth_settings.visibility_distance["shadow"][param_00]["stand"] = var_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistDeath"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistPain"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistBullet"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstep"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstepWalk"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstepSprint"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistNewEnemy"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistGunShot"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistExplosion"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistDeath"]["spotted"] = var_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistDeath"]["hidden"] = var_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistPain"]["spotted"] = var_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistPain"]["hidden"] = var_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistBullet"]["spotted"] = var_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistBullet"]["hidden"] = var_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstep"]["spotted"] = var_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstep"]["hidden"] = var_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstepWalk"]["spotted"] = var_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstepWalk"]["hidden"] = var_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstepSprint"]["spotted"] = var_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstepSprint"]["hidden"] = var_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistNewEnemy"]["spotted"] = var_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistNewEnemy"]["hidden"] = var_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistGunShot"]["spotted"] = 6000;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistGunShot"]["hidden"] = 6000;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistExplosion"]["spotted"] = 6000;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistExplosion"]["hidden"] = 6000;
}

//Function Number: 42
init_detection_distance_setting_for_shadow(param_00,param_01)
{
	level._cloaked_stealth_settings.visibility_distance["shadow"][param_00]["prone"] = param_01;
	level._cloaked_stealth_settings.visibility_distance["shadow"][param_00]["crouch"] = param_01;
	level._cloaked_stealth_settings.visibility_distance["shadow"][param_00]["stand"] = param_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistDeath"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistPain"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistBullet"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstep"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstepWalk"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstepSprint"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistNewEnemy"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistGunShot"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistExplosion"] = [];
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistDeath"]["spotted"] = param_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistDeath"]["hidden"] = param_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistPain"]["spotted"] = param_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistPain"]["hidden"] = param_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistBullet"]["spotted"] = param_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistBullet"]["hidden"] = param_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstep"]["spotted"] = param_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstep"]["hidden"] = param_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstepWalk"]["spotted"] = param_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstepWalk"]["hidden"] = param_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstepSprint"]["spotted"] = param_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistFootstepSprint"]["hidden"] = param_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistNewEnemy"]["spotted"] = param_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistNewEnemy"]["hidden"] = param_01;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistGunShot"]["spotted"] = 6000;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistGunShot"]["hidden"] = 6000;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistExplosion"]["spotted"] = 6000;
	level._cloaked_stealth_settings.event_distance["shadow"][param_00]["ai_eventDistExplosion"]["hidden"] = 6000;
}

//Function Number: 43
init_computed_detection_distance_setting(param_00)
{
	var_01 = get_detection_distance_for_player_speed(param_00);
	init_detection_distance_setting(param_00,var_01);
	init_detection_distance_setting_for_shadow(param_00,var_01 * 0.5);
}

//Function Number: 44
init_cloaked_stealth_detection_range()
{
	level._cloaked_stealth_settings.visibility_distance = [];
	level._cloaked_stealth_settings.event_distance = [];
	init_computed_detection_distance_setting(0);
	init_computed_detection_distance_setting(50);
	init_computed_detection_distance_setting(100);
	init_computed_detection_distance_setting(150);
	init_computed_detection_distance_setting(200);
	init_computed_detection_distance_setting(250);
	init_computed_detection_distance_setting(300);
	init_computed_detection_distance_setting(350);
	init_computed_detection_distance_setting(400);
	init_uncloaked_detection_distance_setting(1000);
	init_uncloaked_detection_distance_setting_for_shadow(1000);
}

//Function Number: 45
set_corpse_detection_ranges_for_cloak_system()
{
	var_00["player_dist"] = 0;
	var_00["sight_dist"] = 0;
	var_00["detect_dist"] = 0;
	maps\_stealth_utility::stealth_corpse_ranges_custom(var_00);
}

//Function Number: 46
debug_monitor_for_all_cloaked_stealth_enemies(param_00,param_01)
{
	var_02 = 1;
	for(;;)
	{
		if(isdefined(level._cloak_enemy_array))
		{
			level._cloak_enemy_array = maps\_utility::array_removedead(level._cloak_enemy_array);
			foreach(var_04 in level._cloak_enemy_array)
			{
				var_04 thread maps\_stealth_debug::stealth_enemy_minimal_debug_monitor();
				if(isdefined(param_01) && param_01 == 1)
				{
					var_04 thread show_detailed_cloak_enemy_state();
				}

				if(isdefined(param_00) && param_00 == 1)
				{
					var_04 thread maps\_stealth_debug::last_known_position_monitor();
				}
			}
		}

		wait(var_02);
	}
}

//Function Number: 47
show_detailed_cloak_enemy_state()
{
	self notify("show_detailed_cloak_enemy_state");
	self endon("show_detailed_cloak_enemy_state");
	self endon("death");
	for(;;)
	{
		if(isdefined(self._cloak_enemy_state))
		{
			var_00 = "";
			if(self._cloak_enemy_state == "default_stealth_state")
			{
				if(isdefined(self._stealth.debug_state))
				{
					var_00 = self._stealth.debug_state;
				}
				else
				{
					var_00 = "unknown state";
				}
			}
			else
			{
				var_00 = self._cloak_enemy_state;
			}
		}

		wait(0.05);
	}
}

//Function Number: 48
is_player_cloaked()
{
	return level._cloaked_stealth_settings.cloak_on;
}

//Function Number: 49
set_cloak_on_model()
{
	self drawpostresolve();
	self setmaterialscriptparam(0,0.3);
}

//Function Number: 50
set_event_distance(param_00,param_01)
{
	setsaveddvar(param_00,param_01);
	var_02 = "ai_busyEvent" + getsubstr(param_00,8);
	setsaveddvar(var_02,param_01);
}

//Function Number: 51
override_event_distances_for_mute_volume()
{
	set_event_distance("ai_eventDistDeath",1);
	set_event_distance("ai_eventDistPain",1);
	set_event_distance("ai_eventDistBullet",1);
	set_event_distance("ai_eventDistFootstep",1);
	set_event_distance("ai_eventDistFootstepWalk",1);
	set_event_distance("ai_eventDistFootstepSprint",1);
	set_event_distance("ai_eventDistNewEnemy",1);
	set_event_distance("ai_eventDistGunShot",1);
	set_event_distance("ai_eventDistExplosion",1);
}

//Function Number: 52
activate_mute_volume(param_00,param_01)
{
	if(!level.player maps\_utility::ent_flag_exist("_stealth_in_mute_radius"))
	{
		level.player maps\_utility::ent_flag_init("_stealth_in_mute_radius");
	}

	var_02 = 0.05;
	var_03 = self;
	var_04 = param_00 * param_00;
	var_05 = param_01;
	for(;;)
	{
		var_05 = var_05 - var_02;
		if(var_05 < 0)
		{
			level.player maps\_utility::ent_flag_clear("_stealth_in_mute_radius");
			maps\_stealth_visibility_system::system_default_event_distances();
			maps\_stealth_visibility_system::system_event_change(level._stealth.logic.detection_level);
			return;
		}

		if(!isdefined(var_03))
		{
			level.player maps\_utility::ent_flag_clear("_stealth_in_mute_radius");
			maps\_stealth_visibility_system::system_default_event_distances();
			maps\_stealth_visibility_system::system_event_change(level._stealth.logic.detection_level);
			return;
		}

		var_06 = distancesquared(var_03.origin,level.player.origin);
		if(var_06 < var_04)
		{
			mute_event_distances();
			maps\_stealth_visibility_system::system_event_change(level._stealth.logic.detection_level);
			level.player maps\_utility::ent_flag_set("_stealth_in_mute_radius");
		}
		else
		{
			maps\_stealth_visibility_system::system_default_event_distances();
			maps\_stealth_visibility_system::system_event_change(level._stealth.logic.detection_level);
			level.player maps\_utility::ent_flag_clear("_stealth_in_mute_radius");
		}

		wait(var_02);
	}
}

//Function Number: 53
mute_event_distances()
{
	var_00["ai_eventDistDeath"] = [];
	var_00["ai_eventDistPain"] = [];
	var_00["ai_eventDistExplosion"] = [];
	var_00["ai_eventDistBullet"] = [];
	var_00["ai_eventDistFootstep"] = [];
	var_00["ai_eventDistFootstepWalk"] = [];
	var_00["ai_eventDistFootstepSprint"] = [];
	var_00["ai_eventDistGunShot"] = [];
	var_00["ai_eventDistGunShotTeam"] = [];
	var_00["ai_eventDistNewEnemy"] = [];
	var_00["ai_eventDistDeath"]["spotted"] = getdvar("ai_eventDistDeath");
	var_00["ai_eventDistDeath"]["hidden"] = 1;
	var_00["ai_eventDistPain"]["spotted"] = getdvar("ai_eventDistPain");
	var_00["ai_eventDistPain"]["hidden"] = 1;
	var_00["ai_eventDistExplosion"]["spotted"] = 4000;
	var_00["ai_eventDistExplosion"]["hidden"] = 1;
	var_00["ai_eventDistBullet"]["spotted"] = 96;
	var_00["ai_eventDistBullet"]["hidden"] = 1;
	var_00["ai_eventDistFootstep"]["spotted"] = 1;
	var_00["ai_eventDistFootstep"]["hidden"] = 1;
	var_00["ai_eventDistFootstepWalk"]["spotted"] = 256;
	var_00["ai_eventDistFootstepWalk"]["hidden"] = 1;
	var_00["ai_eventDistFootstepSprint"]["spotted"] = 400;
	var_00["ai_eventDistFootstepSprint"]["hidden"] = 1;
	var_00["ai_eventDistGunShot"]["spotted"] = 2048;
	var_00["ai_eventDistGunShot"]["hidden"] = 1;
	var_00["ai_eventDistGunShotTeam"]["spotted"] = 750;
	var_00["ai_eventDistGunShotTeam"]["hidden"] = 1;
	var_00["ai_eventDistNewEnemy"]["spotted"] = 750;
	var_00["ai_eventDistNewEnemy"]["hidden"] = 1;
	maps\_stealth_visibility_system::system_set_event_distances(var_00);
}

//Function Number: 54
setalertstencilstate(param_00)
{
	if(isdefined(param_00))
	{
		setsaveddvar("r_hudoutlinecloaklumscale",0);
		thread maps\_utility::lerp_saveddvar("r_hudoutlinecloaklumscale",0.75,param_00);
	}
	else
	{
		setsaveddvar("r_hudoutlinecloaklumscale",0.75);
	}

	setsaveddvar("r_hudoutlinewidth",1);
	setsaveddvar("r_hudoutlinepostmode",4);
	setsaveddvar("r_hudoutlinecloakblurradius",0.35);
	self hudoutlineenable(6,1);
}

//Function Number: 55
clearalertstencilstate()
{
	if(isdefined(self))
	{
		self hudoutlinedisable();
		self hudoutlineenable(0,0);
		self hudoutlinedisable();
		setsaveddvar("r_hudoutlinewidth",1);
	}
}

//Function Number: 56
clearstencilstateondeath()
{
	if(isdefined(self))
	{
		self hudoutlinedisable();
		self hudoutlineenable(0,0);
	}
}

//Function Number: 57
setalertstencilstate_axis()
{
	self endon("death");
	setsaveddvar("r_hudoutlinewidth",1);
	self hudoutlineenable(4,1);
}

//Function Number: 58
temp_cloak_gauge()
{
	var_00 = 620;
	var_01 = 240;
	var_02 = 156;
	var_03 = int(10);
	var_04 = newhudelem();
	var_04.x = var_00 - 0.5 * 20 - var_03;
	var_04.y = var_01 - int(40);
	var_04.alignx = "right";
	var_04.aligny = "bottom";
	var_04.horzalign = "fullscreen";
	var_04.vertalign = "fullscreen";
	var_04.color = (0.1,0.6,0.1);
	var_04 setshader("white",var_03,int(var_02 * level._cloaked_stealth_settings.cloak_battery_level));
	var_05 = newhudelem();
	var_05.x = var_00;
	var_05.y = var_01;
	var_05.alignx = var_04.alignx;
	var_05.aligny = var_04.aligny;
	var_05.horzalign = var_04.horzalign;
	var_05.vertalign = var_04.vertalign;
	var_05.color = (1,1,1);
	var_05 setshader("hud_temperature_gauge",20,200);
	var_06 = 0.05;
	for(;;)
	{
		if(isdefined(level._cloaked_stealth_settings.battery_hud_is_visible) && level._cloaked_stealth_settings.battery_hud_is_visible == 1)
		{
			var_04.alpha = 1;
			var_05.alpha = 1;
			var_07 = level._cloaked_stealth_settings.cloak_battery_level;
			var_04 scaleovertime(var_06,var_03,int(var_02 * var_07));
			if(var_07 > 0.5)
			{
				var_04.color = (0.1,0.6,0.1);
			}
			else if(var_07 > 0.2)
			{
				var_04.color = (1,1,0.1);
			}
			else
			{
				var_04.color = (1,0.1,0.1);
			}
		}
		else
		{
			var_04.alpha = 0;
			var_05.alpha = 0;
		}

		wait(var_06);
	}
}