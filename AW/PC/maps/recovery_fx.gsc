/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: recovery_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 461 ms
 * Timestamp: 4/22/2024 2:34:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachefx();
	maps\createfx\recovery_fx::main();
	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}

	maps\_shg_fx::setup_shg_fx();
	thread maps\_shg_fx::fx_zone_watcher(800,"msg_fx_zone_funeral");
	thread maps\_shg_fx::fx_zone_watcher(1000,"msg_fx_zone_golf_course","msg_fx_zone_golf_course01");
	thread maps\_shg_fx::fx_zone_watcher(1001,"msg_fx_zone_golf_course02","msg_fx_zone_golf_course03");
	thread maps\_shg_fx::fx_zone_watcher(1002,"msg_fx_zone_window_rain","msg_fx_zone_window_rain01");
	thread maps\_shg_fx::fx_zone_watcher(1003,"msg_fx_zone_behind_house");
	thread maps\_shg_fx::fx_zone_watcher(1004,"msg_fx_zone1004_inside_house");
	thread maps\_shg_fx::fx_zone_watcher(2000,"msg_fx_zone_tour");
	thread maps\_shg_fx::fx_zone_watcher(3000,"msg_fx_zone_elevator","msg_fx_zone_elevator","msg_fx_zone_golf_course");
	thread treadfx_override();
	thread golfcourse_treadfx_override();
}

//Function Number: 2
precachefx()
{
	level._effect["flashlight"] = loadfx("vfx/lights/flashlight_recovery");
	level._effect["flesh_hit"] = loadfx("vfx/weaponimpact/flesh_impact_body_fatal_exit");
	level._effect["expround_asphalt_1"] = loadfx("vfx/weaponimpact/expround_asphalt_1");
	level._effect["frag_grenade_default"] = loadfx("vfx/explosion/frag_grenade_default");
	level._effect["recovery_scoring_add1"] = loadfx("vfx/map/recovery/recovery_scoring_add1");
	level._effect["recovery_scoring_add2"] = loadfx("vfx/map/recovery/recovery_scoring_add2");
	level._effect["recovery_scoring_add25"] = loadfx("vfx/map/recovery/recovery_scoring_add25");
	level._effect["recovery_scoring_add50"] = loadfx("vfx/map/recovery/recovery_scoring_add50");
	level._effect["recovery_scoring_add75"] = loadfx("vfx/map/recovery/recovery_scoring_add75");
	level._effect["recovery_scoring_add100"] = loadfx("vfx/map/recovery/recovery_scoring_add100");
	level._effect["recovery_scoring_minus1"] = loadfx("vfx/map/recovery/recovery_scoring_minus1");
	level._effect["recovery_scoring_minus2"] = loadfx("vfx/map/recovery/recovery_scoring_minus2");
	level._effect["recovery_scoring_minus25"] = loadfx("vfx/map/recovery/recovery_scoring_minus25");
	level._effect["recovery_scoring_minus50"] = loadfx("vfx/map/recovery/recovery_scoring_minus50");
	level._effect["recovery_scoring_minus75"] = loadfx("vfx/map/recovery/recovery_scoring_minus75");
	level._effect["recovery_scoring_minus100"] = loadfx("vfx/map/recovery/recovery_scoring_minus100");
	level._effect["recovery_scoring_target_shutter_enemy"] = loadfx("vfx/map/recovery/recovery_scoring_target_shutter");
	level._effect["recovery_scoring_target_shutter_friendly"] = loadfx("vfx/map/recovery/recovery_scoring_hostage_shutter");
	level._effect["firing_range_edge_glow"] = loadfx("vfx/beam/firing_range_edge_glow");
	level._effect["firing_range_edge_glow_off"] = loadfx("vfx/beam/firing_range_edge_glow_off");
	level._effect["firing_range_glow_flicker_rnr_lp"] = loadfx("vfx/beam/firing_range_glow_flicker_rnr_lp");
	level._effect["boost_dust_npc"] = loadfx("vfx/smoke/jetpack_exhaust_npc");
	level._effect["boost_dust_impact_ground"] = loadfx("vfx/smoke/jetpack_ground_impact_runner");
	level._effect["landass_exhaust_smk_rt_npc"] = loadfx("vfx/smoke/landass_exhaust_smk_rt_npc");
	level._effect["landass_exhaust_smk_lf_npc"] = loadfx("vfx/smoke/landass_exhaust_smk_lf_npc");
	level._effect["landass_impact_smk_rnr"] = loadfx("vfx/smoke/landass_impact_smk_rnr");
	level._effect["lightning"] = loadfx("vfx/map/recovery/recovery_lightning_flash");
	level._effect["recovery_sun_flare"] = loadfx("vfx/map/recovery/recovery_sun_flare");
	level._effect["recovery_sun_flare_funeral"] = loadfx("vfx/map/recovery/recovery_sun_flare_funeral");
	level._effect["recovery_skylight_grp_flare"] = loadfx("vfx/map/recovery/recovery_skylight_grp_flare");
	level._effect["recovery_surgical_flare"] = loadfx("vfx/map/recovery/recovery_surgical_flare");
	level._effect["recovery_rectangle_flare"] = loadfx("vfx/map/recovery/recovery_rectangle_flare");
	level._effect["recovery_range_flare"] = loadfx("vfx/map/recovery/recovery_range_flare");
	level._effect["recovery_tv_flare"] = loadfx("vfx/map/recovery/recovery_tv_flare");
	level._effect["recovery_tv_sm_flare"] = loadfx("vfx/map/recovery/recovery_tv_sm_flare");
	level._effect["recovery_ceiling_light_flare_02"] = loadfx("vfx/map/recovery/recovery_ceiling_light_flare_02");
	level._effect["recovery_hanging_light_flare"] = loadfx("vfx/map/recovery/recovery_hanging_light_flare");
	maps\_weather::addlightningexploder(10);
	maps\_weather::addlightningexploder(11);
	maps\_weather::addlightningexploder(12);
	level.nextlightning = gettime() + 1;
	level._effect["petals_fall_cherry_gentlewind_no_physics"] = loadfx("vfx/wind/petals_fall_cherry_gentlewind_no_physics");
	level._effect["leaves_fall_twirl_small_no_physics"] = loadfx("vfx/wind/leaves_fall_twirl_small_no_physics");
	level._effect["petals_fall_cherry_gentlewind_physics"] = loadfx("vfx/wind/petals_fall_cherry_gentlewind_physics");
	level._effect["cg_fx_light_1"] = loadfx("vfx/map/recovery/recov_character_light_1_cg");
	level._effect["cg_fx_light_2"] = loadfx("vfx/map/recovery/recov_character_light_2_cg");
	level._effect["cg_fx_light_3"] = loadfx("vfx/map/recovery/recov_character_light_3_cg");
	level._effect["cg_fx_light_4"] = loadfx("vfx/map/recovery/recov_character_light_4_cg");
	level._effect["cg_fx_light_4a"] = loadfx("vfx/map/recovery/recov_character_light_4a_cg");
	level._effect["cg_fx_light_5"] = loadfx("vfx/map/recovery/recov_character_light_5_cg");
	level._effect["cg_fx_light_5a"] = loadfx("vfx/map/recovery/recov_character_light_5a_cg");
	level._effect["cg_fx_light_jeep_runner"] = loadfx("vfx/map/recovery/recov_character_light_jeep_runner_cg");
	level._effect["raindrop_single"] = loadfx("vfx/rain/raindrop_single");
	level._effect["rain_hvy_dense_windy_01"] = loadfx("vfx/rain/rain_hvy_dense_windy_01");
	level._effect["rain_hvy_dense_windy_outside"] = loadfx("vfx/rain/rain_hvy_dense_windy_outside");
	level._effect["rain_hvy_dense_windy_small"] = loadfx("vfx/rain/rain_hvy_dense_windy_small");
	level._effect["rain_hvy_dense_windy_small_bright"] = loadfx("vfx/rain/rain_hvy_dense_windy_small_bright");
	level._effect["rain_hvy_dense_windy_small_outside"] = loadfx("vfx/rain/rain_hvy_dense_windy_small_outside");
	level._effect["rain_splat_on_lens_med_rnr_night"] = loadfx("vfx/map/recovery/rain_splat_on_lens_med_rnr_night");
	level._effect["rain_hvy_dense_windy_window"] = loadfx("vfx/rain/rain_hvy_dense_windy_window");
	level._effect["raindrop_rings_area_med"] = loadfx("vfx/rain/raindrop_rings_area_med");
	level._effect["raindrop_rings_area"] = loadfx("vfx/rain/raindrop_rings_area");
	level._effect["leaves_fall_gentlewind_no_physics"] = loadfx("vfx/wind/leaves_fall_gentlewind_no_physics");
	level._effect["recovery_amb_ground_mist"] = loadfx("vfx/map/recovery/recovery_amb_ground_mist");
	level._effect["recovery_rain_floor_sheet"] = loadfx("vfx/map/recovery/recovery_rain_floor_sheet");
	level._effect["recovery_wind_gust_mist_distant_lrg"] = loadfx("vfx/map/recovery/recovery_wind_gust_mist_distant_lrg");
	level._effect["recovery_lampost_flare"] = loadfx("vfx/map/recovery/recovery_lampost_flare");
	level._effect["drone_search_lt_recovery"] = loadfx("vfx/lights/drone_search_lt_recovery");
	level._effect["recovery_gideon_hit"] = loadfx("vfx/map/recovery/recovery_gideon_hit");
	level._effect["recovery_dust_falling_debris_single"] = loadfx("vfx/map/recovery/recovery_dust_falling_debris_single");
	level._effect["exo_door_hinge_piece"] = loadfx("vfx/props/exo_door_hinge_piece");
	level._effect["recovery_dust_burst_round"] = loadfx("vfx/map/recovery/recovery_dust_burst_round");
	level._effect["recovery_dust_burst_round_high"] = loadfx("vfx/map/recovery/recovery_dust_burst_round_high");
	level._effect["recovery_dust_burst_round_french"] = loadfx("vfx/map/recovery/recovery_dust_burst_round_french");
	level._effect["recovery_wood_door_break"] = loadfx("vfx/map/recovery/recovery_wood_door_break");
	level._effect["sparks_short_circuits_small"] = loadfx("vfx/sparks/sparks_short_circuits_small");
	level._effect["large_wood"] = loadfx("vfx/weaponimpact/large_wood");
	level._effect["lab_mute_device_plant_vm"] = loadfx("vfx/map/lab/lab_mute_device_plant_vm");
	level._effect["lab_mute_area_distort_player_view"] = loadfx("vfx/map/lab/lab_mute_area_distort_player_view");
	level._effect["lab_mute_device_lights"] = loadfx("vfx/map/lab/lab_mute_device_lights");
	level._effect["mute_breach_distort_vm_enter"] = loadfx("vfx/props/mute_breach_distort_vm_enter");
	level._effect["mute_breach_distort_vm_exit"] = loadfx("vfx/props/mute_breach_distort_vm_exit");
	level._effect["recovery_blood_impact_burst"] = loadfx("vfx/map/recovery/recovery_blood_impact_burst");
	level._effect["heli_dust_rain"] = loadfx("vfx/treadfx/heli_dust_rain");
	level._effect["heli_dust_rain_idle"] = loadfx("vfx/treadfx/heli_dust_rain_idle");
	level._effect["car_tread_water_splash"] = loadfx("vfx/treadfx/car_tread_water_splash");
	level._effect["leaves_windblown_slw"] = loadfx("vfx/wind/leaves_windblown_slw");
	level._effect["recovery_wind_gust_gate_open"] = loadfx("vfx/map/recovery/recovery_wind_gust_gate_open");
	level._effect["splinter_wood_blind_damage"] = loadfx("vfx/map/recovery/splinter_wood_blind_damage");
	level._effect["blind_pieces_fall"] = loadfx("vfx/map/recovery/blind_pieces_fall");
	level._effect["glass_shatter_large"] = loadfx("vfx/glass/glass_shatter_large");
	level._effect["glass_hit_large"] = loadfx("vfx/glass/glass_hit_large");
	level._effect["glass_falling_debris_02"] = loadfx("vfx/glass/glass_falling_debris_02");
	level._effect["walker_tank_footstep_dust"] = loadfx("vfx/treadfx/walker_tank_footstep_dust");
	level._effect["tread_dust_sedan_bright"] = loadfx("vfx/treadfx/tread_dust_sedan_bright");
	level._effect["tread_dust_van_bright"] = loadfx("vfx/treadfx/tread_dust_van_bright");
	level._effect["welding_sparks_oneshot_sml"] = loadfx("vfx/sparks/welding_sparks_oneshot_sml");
	level._effect["sparks_friction"] = loadfx("vfx/sparks/sparks_friction");
	level._effect["tread_dust_sedan_bright"] = loadfx("vfx/treadfx/tread_dust_sedan_bright");
	level._effect["titan_tread_impact"] = loadfx("vfx/treadfx/titan_tread_impact");
	level._effect["truck_tire_tread"] = loadfx("vfx/treadfx/truck_tire_tread");
	level._effect["tread_dust_ft101_tank"] = loadfx("vfx/treadfx/tread_dust_ft101_tank");
	level._effect["veh_default_front_signal_light_l"] = loadfx("vfx/lights/veh_default_front_signal_light_l");
	level._effect["veh_default_front_signal_light_r"] = loadfx("vfx/lights/veh_default_front_signal_light_r");
	level._effect["vehicle_civ_ai_explo_small_runner"] = loadfx("vfx/explosion/vehicle_civ_ai_explo_small_runner");
	level._effect["firelp_small"] = loadfx("vfx/fire/firelp_small");
	level._effect["recovery_spotlight_flare_01"] = loadfx("vfx/map/recovery/recovery_spotlight_flare_01");
	level._effect["recovery_ceiling_light_flare_01"] = loadfx("vfx/map/recovery/recovery_ceiling_light_flare_01");
	level._effect["cloud_bank"] = loadfx("vfx/wind/cloud_bank");
	level._effect["titan_tread_kickup_front"] = loadfx("vfx/treadfx/titan_tread_kickup_front");
	level._effect["titan_tread_kickup_back"] = loadfx("vfx/treadfx/titan_tread_kickup_back");
	level._effect["car_tread_mud"] = loadfx("vfx/treadfx/car_tread_mud");
	level._effect["car_tread_mud_dense"] = loadfx("vfx/treadfx/car_tread_mud_dense");
	level._effect["test_axis_2"] = loadfx("vfx/test/test_axis_2");
}

//Function Number: 3
vfx_raindrop(param_00)
{
	wait(0.3);
	common_scripts\_exploder::exploder("vfx_raindrop");
	wait(9);
	common_scripts\_exploder::kill_exploder("vfx_raindrop");
}

//Function Number: 4
lightning_flash(param_00)
{
	level notify("emp_lighting_flash");
	level endon("emp_lighting_flash");
	if(level.createfx_enabled)
	{
		return;
	}

	var_01 = randomintrange(1,4);
	if(!isdefined(param_00))
	{
		param_00 = (-20,60,0);
	}

	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_03 = randomint(3);
		switch(var_03)
		{
			case 0:
				wait(0.05);
				setsunlight(1,1,1.2);
				wait(0.05);
				setsunlight(2,2,2.5);
				break;

			case 1:
				wait(0.05);
				setsunlight(1,1,1.2);
				wait(0.05);
				setsunlight(2,2,2.5);
				wait(0.05);
				setsunlight(3,3,3.7);
				break;

			case 2:
				wait(0.05);
				setsunlight(1,1,1.2);
				wait(0.05);
				setsunlight(2,2,2.5);
				wait(0.05);
				setsunlight(3,3,3.7);
				wait(0.05);
				setsunlight(2,2,2.5);
				break;
		}

		wait(randomfloatrange(0.05,0.1));
		lightning_normal();
	}

	lightning_normal();
}

//Function Number: 5
lightning_normal()
{
	resetsunlight();
	resetsundirection();
}

//Function Number: 6
drone_search_light_fx()
{
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("drone_search_lt_recovery"),self,"tag_origin");
	soundscripts\_snd::snd_message("rec_drone_scanner");
	playfxontag(common_scripts\utility::getfx("drone_beacon_blue_slow_nolight"),self,"TAG_FX_BEACON_0");
	playfxontag(common_scripts\utility::getfx("drone_beacon_blue_slow_nolight"),self,"TAG_FX_BEACON_1");
	playfxontag(common_scripts\utility::getfx("drone_beacon_blue_fast"),self,"TAG_FX_BEACON_2");
}

//Function Number: 7
mute_fx_on(param_00)
{
	playfxontag(common_scripts\utility::getfx("lab_mute_device_plant_vm"),param_00,"tag_vfx_attach");
	wait(0.15);
	playfxontag(common_scripts\utility::getfx("lab_mute_device_lights"),param_00,"spinner");
	level waittill("disable_mute_breach_fx");
	stopfxontag(common_scripts\utility::getfx("lab_mute_device_lights"),param_00,"spinner");
	stopfxontag(common_scripts\utility::getfx("lab_mute_device_plant_vm"),param_00,"tag_vfx_attach");
}

//Function Number: 8
breach_office_door(param_00)
{
	wait(0.5);
	common_scripts\_exploder::exploder("officedoor_breach");
	wait(10);
	common_scripts\_exploder::kill_exploder("officedoor_breach");
}

//Function Number: 9
kva_hit_glass_impact(param_00)
{
	wait(0.01);
	common_scripts\_exploder::exploder("glass_hit");
	wait(0.4);
	common_scripts\_exploder::exploder("sparks_short_circuits");
	wait(6);
	common_scripts\_exploder::kill_exploder("glass_hit");
	common_scripts\_exploder::kill_exploder("sparks_short_circuits");
}

//Function Number: 10
training_escape_gideon_punch(param_00)
{
	wait(0.005);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"j_mid_le_1",(0,0,0),(0,0,0));
	playfxontag(common_scripts\utility::getfx("recovery_gideon_hit"),var_01,"tag_origin");
	wait(3);
	var_01 delete();
}

//Function Number: 11
training_s1_president_blood(param_00)
{
	playfxontag(common_scripts\utility::getfx("recovery_blood_impact_burst"),level.president,"j_head");
}

//Function Number: 12
training_escape_vehicle_1_fx(param_00)
{
	playfxontag(common_scripts\utility::getfx("car_tread_water_splash"),param_00,"tag_wheel_back_right");
	playfxontag(common_scripts\utility::getfx("car_tread_water_splash"),param_00,"tag_wheel_back_left");
	playfxontag(common_scripts\utility::getfx("car_tread_water_splash"),param_00,"tag_wheel_front_right");
	playfxontag(common_scripts\utility::getfx("car_tread_water_splash"),param_00,"tag_wheel_front_left");
}

//Function Number: 13
tour_jeep_tread(param_00)
{
	wait(1);
	playfxontag(common_scripts\utility::getfx("car_tread_mud_dense"),param_00,"tag_wheel_back_right");
	playfxontag(common_scripts\utility::getfx("car_tread_mud_dense"),param_00,"tag_wheel_back_left");
	playfxontag(common_scripts\utility::getfx("car_tread_mud_dense"),param_00,"tag_wheel_front_right");
	playfxontag(common_scripts\utility::getfx("car_tread_mud_dense"),param_00,"tag_wheel_front_left");
	wait(8.5);
	stopfxontag(common_scripts\utility::getfx("car_tread_mud_dense"),param_00,"tag_wheel_back_right");
	stopfxontag(common_scripts\utility::getfx("car_tread_mud_dense"),param_00,"tag_wheel_back_left");
	stopfxontag(common_scripts\utility::getfx("car_tread_mud_dense"),param_00,"tag_wheel_front_right");
	stopfxontag(common_scripts\utility::getfx("car_tread_mud_dense"),param_00,"tag_wheel_front_left");
}

//Function Number: 14
wind_gate_open(param_00)
{
	wait(13);
	common_scripts\_exploder::exploder("wind_gate_open");
	common_scripts\_exploder::exploder("gate_fx_light");
	wait(5);
	common_scripts\_exploder::exploder("leaves_gate_open");
	wait(3);
	common_scripts\_exploder::exploder("leaves_gate_open_delay");
	wait(15);
	common_scripts\_exploder::kill_exploder("wind_gate_open");
	common_scripts\_exploder::kill_exploder("leaves_gate_open");
	common_scripts\_exploder::kill_exploder("leaves_gate_open_delay");
}

//Function Number: 15
titan_gate_tread_fx(param_00)
{
	wait(2);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"ankle_fr",(-50,0,10),(0,0,0));
	playfxontag(common_scripts\utility::getfx("titan_tread_kickup_front"),var_01,"tag_origin");
	playfxontag(common_scripts\utility::getfx("titan_tread_kickup_front"),param_00,"ankle_fl");
	playfxontag(common_scripts\utility::getfx("titan_tread_kickup_back"),param_00,"ankle_KR");
	playfxontag(common_scripts\utility::getfx("titan_tread_kickup_back"),param_00,"ankle_Kl");
	wait(10);
	var_01 delete();
	common_scripts\_exploder::kill_exploder("gate_fx_light");
}

//Function Number: 16
titan_impact_fx_fl(param_00)
{
	wait(0.3);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"frontWheelTread07_FL",(0,0,0),(-16,180,-10));
	playfxontag(common_scripts\utility::getfx("walker_tank_footstep_dust"),var_01,"tag_origin");
	earthquake(0.15,1.8,param_00.origin,2000);
	level notify("titan_rumble");
	wait(90);
	var_01 delete();
}

//Function Number: 17
titan_impact_fx_fr(param_00)
{
	wait(0.3);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"frontWheelTread07_FR",(0,0,0),(45,0,0));
	playfxontag(common_scripts\utility::getfx("walker_tank_footstep_dust"),var_01,"tag_origin");
	earthquake(0.15,1.8,param_00.origin,2000);
	level notify("titan_rumble");
	wait(90);
	var_01 delete();
}

//Function Number: 18
titan_impact_fx_rr(param_00)
{
	wait(0.3);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"frontWheelTread06_kR",(0,0,0),(0,180,0));
	playfxontag(common_scripts\utility::getfx("walker_tank_footstep_dust"),var_01,"tag_origin");
	earthquake(0.15,1.8,param_00.origin,2000);
	wait(90);
	var_01 delete();
}

//Function Number: 19
titan_impact_fx_rl(param_00)
{
	wait(0.3);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"frontWheelTread06_KL",(100,0,100),(0,180,0));
	playfxontag(common_scripts\utility::getfx("walker_tank_footstep_dust"),var_01,"tag_origin");
	earthquake(0.15,1.8,param_00.origin,2000);
	wait(90);
	var_01 delete();
}

//Function Number: 20
exo_push_sparks01_quake(param_00)
{
	wait(0.01);
	earthquake(0.2,1,param_00.origin,500);
}

//Function Number: 21
exo_push_sparks01(param_00)
{
	level endon("flag_obj_firing_range_pre");
	wait(0.8);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"hook_t",(-46,111,-125),(0,-90,0));
	playfxontag(common_scripts\utility::getfx("sparks_friction"),var_01,"tag_origin");
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(param_00,"hook_t",(-46,-18,-125),(0,-90,0));
	playfxontag(common_scripts\utility::getfx("sparks_friction"),var_02,"tag_origin");
	wait(3.5);
	var_01 delete();
	var_02 delete();
}

//Function Number: 22
exo_push_sparks02_quake(param_00)
{
	wait(0.03);
	earthquake(0.2,1,param_00.origin,500);
}

//Function Number: 23
exo_push_sparks02(param_00)
{
	level endon("flag_obj_firing_range_pre");
	wait(0.6);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"hook_t",(-46,111,-125),(0,-90,0));
	playfxontag(common_scripts\utility::getfx("sparks_friction"),var_01,"tag_origin");
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(param_00,"hook_t",(-46,-15,-125),(0,-90,0));
	playfxontag(common_scripts\utility::getfx("sparks_friction"),var_02,"tag_origin");
	wait(7);
	var_01 delete();
	var_02 delete();
}

//Function Number: 24
helicopter_landing(param_00)
{
	common_scripts\_exploder::exploder("helicopter_landing_small");
	wait(2);
	maps\_utility::stop_exploder("helicopter_landing_small");
	common_scripts\_exploder::exploder("helicopter_landing");
	wait(20);
	maps\_utility::stop_exploder("helicopter_landing");
	common_scripts\_exploder::exploder("helicopter_landing_small");
	wait(4);
	maps\_utility::stop_exploder("helicopter_landing_small");
}

//Function Number: 25
treadfx_override()
{
	wait(1);
	var_00[0] = "script_vehicle_vrap";
	var_01 = "vfx/treadfx/truck_tire_tread";
	foreach(var_03 in var_00)
	{
		maps\_vehicle::set_vehicle_effect(var_03,"brick",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"bark",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"carpet",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"cloth",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"concrete",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"dirt",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"flesh",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"foliage",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"glass",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"grass",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"gravel",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"ice",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"metal",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"mud",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"paper",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"plaster",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"rock",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"sand",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"snow",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"water",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"wood",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"asphalt",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"ceramic",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"plastic",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"rubber",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"cushion",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"fruit",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"paintedmetal",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"riotshield",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"slush",var_01);
		maps\_vehicle::set_vehicle_effect(var_03,"default",var_01);
	}
}

//Function Number: 26
golfcourse_treadfx_override()
{
	wait(1);
	var_00[0] = "script_vehicle_mil_gaz_ai_turret";
	var_01[0] = "script_vehicle_mil_gaz_ai";
	var_02 = "vfx/treadfx/car_tread_mud";
	foreach(var_04 in var_01)
	{
		maps\_vehicle::set_vehicle_effect(var_04,"brick",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"bark",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"carpet",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"cloth",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"concrete",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"dirt",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"flesh",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"foliage",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"glass",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"grass",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"gravel",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"ice",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"metal",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"mud",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"paper",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"plaster",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"rock",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"sand",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"snow",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"water",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"wood",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"asphalt",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"ceramic",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"plastic",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"rubber",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"cushion",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"fruit",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"paintedmetal",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"riotshield",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"slush",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"default",var_02);
	}

	foreach(var_04 in var_00)
	{
		maps\_vehicle::set_vehicle_effect(var_04,"brick",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"bark",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"carpet",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"cloth",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"concrete",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"dirt",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"flesh",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"foliage",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"glass",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"grass",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"gravel",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"ice",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"metal",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"mud",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"paper",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"plaster",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"rock",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"sand",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"snow",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"water",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"wood",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"asphalt",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"ceramic",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"plastic",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"rubber",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"cushion",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"fruit",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"paintedmetal",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"riotshield",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"slush",var_02);
		maps\_vehicle::set_vehicle_effect(var_04,"default",var_02);
	}
}

//Function Number: 27
firing_range_round_1_glow()
{
	wait(0.8);
	common_scripts\_exploder::exploder(2100);
}

//Function Number: 28
firing_range_round_2_glow()
{
	wait(0.8);
	common_scripts\_exploder::exploder(2200);
}

//Function Number: 29
firing_range_round_3_glow()
{
	wait(0.8);
	common_scripts\_exploder::exploder(2300);
}

//Function Number: 30
firing_range_kill_glow()
{
	common_scripts\_exploder::kill_exploder(2100);
	common_scripts\_exploder::kill_exploder(2200);
	common_scripts\_exploder::kill_exploder(2300);
	common_scripts\_exploder::exploder(2101);
	common_scripts\_exploder::exploder(2201);
	common_scripts\_exploder::exploder(2301);
	wait(0.5);
	common_scripts\_exploder::kill_exploder(2101);
	common_scripts\_exploder::kill_exploder(2201);
	common_scripts\_exploder::kill_exploder(2301);
	common_scripts\_exploder::exploder(2102);
	common_scripts\_exploder::exploder(2202);
	common_scripts\_exploder::exploder(2302);
}

//Function Number: 31
training_escape_vehicle_2_fx(param_00)
{
	playfxontag(common_scripts\utility::getfx("car_tread_water_splash"),param_00,"tag_wheel_back_right");
	playfxontag(common_scripts\utility::getfx("car_tread_water_splash"),param_00,"tag_wheel_back_left");
	playfxontag(common_scripts\utility::getfx("car_tread_water_splash"),param_00,"tag_wheel_front_right");
	playfxontag(common_scripts\utility::getfx("car_tread_water_splash"),param_00,"tag_wheel_front_left");
}