/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_zombie_dig_02_srv_fx.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 43 ms
 * Timestamp: 10/27/2023 3:18:34 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	level.var_611["test_effect"] = loadfx("vfx/test/test_fx");
	level.var_611["dlc_zmb_dig02_sword_looping"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_sword_looping");
	level.var_611["dlc_zmb_dig_02_spike_trap_on_rnr"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig_02_spike_trap_on_rnr");
	level.var_611["dlc_zmb_dig_02_uber_explode"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig_02_uber_explode");
	level.var_611["dlc_zmb_dig_02_ambuber_leaking"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig_02_ambuber_leaking");
	level.var_611["zmb_1911_pap_explosive_impact"] = loadfx("vfx/weaponimpact/zmb_1911_pap_explosive_impact");
	level.var_611["dlc_zmb_dig02_sword_assmble_flash"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_sword_assmble_flash");
	level.var_611["dlc_zmb_dig02_fire_bowl_sm_nolight"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_fire_bowl_sm_nolight");
	level.var_611["dlc_zmb_dig02_roof_lensflare1"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_roof_lensflare1");
	level.var_611["dlc_zmb_dig02_blood_statue_grit"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_statue_grit");
	level.var_611["dlc_zmb_dig02_dust_falling_line_rnr"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_dust_falling_line_rnr");
	level.var_611["dlc_zmb_dig02_dust_falling_line"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_dust_falling_line");
	level.var_611["dlc_zmb_dig02_geiskraft_light_sm"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_geiskraft_light_sm");
	level.var_611["dlc_zmb_dig02_sword_piece_glow_amb"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_sword_piece_glow_amb");
	level.var_611["dlc_zmb_dig02_rune_reveal"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_rune_reveal");
	level.var_611["dlc_zmb_dig02_geiskraft_amb_edge"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_geiskraft_amb_edge");
	level.var_611["dlc_zmb_dig02_sword_sphere"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_sword_sphere");
	level.var_611["dlc_zmb_dig02_geiskraft_wall_curve"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_geiskraft_wall_curve");
	level.var_611["dlc_zmb_dig02_geiskraft_wall"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_geiskraft_wall");
	level.var_611["dlc_zmb_dig02_geiskraft_ambient"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_geiskraft_ambient");
	level.var_611["dlc_zmb_dig02_sword_combine"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_sword_combine");
	level.var_611["dlc_zmb_dig02_gk_smoke_geotrail"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_gk_smoke_geotrail");
	level.var_611["zmb_receiver_full"] = loadfx("vfx/map/mp_zombie_nest/zmb_receiver_full");
	level.var_611["zmb_zmb_key_light"] = loadfx("vfx/lights/mp_zombie_nest/zmb_zmb_key_light");
	level.var_611["vehicle_warbird_explosion_midair"] = loadfx("vfx/explosion/vehicle_warbird_explosion_midair");
	level.var_611["zmb_death_hand_to_hand_melee_hit"] = loadfx("vfx/zombie/abilities_perks/zmb_death_hand_to_hand_melee_hit");
	level.var_611["dlc_zmb_dig02_blood_plates_sparse"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_plates_sparse");
	level.var_611["dlc_zmb_dig02_generator_malfunc_ger"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_generator_malfunc_ger");
	level.var_611["dlc_zmb_dig02_eq_dust_lrg"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_eq_dust_lrg");
	level.var_611["dlc_zmb_dig02_generator_malfunc"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_generator_malfunc");
	level.var_611["dlc_zmb_dig02_fire_bowl_sm"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_fire_bowl_sm");
	level.var_611["dlc_zmb_dig02_eq_brick_med"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_eq_brick_med");
	level.var_611["dlc_zmb_dig02_eq_basalt_med"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_eq_basalt_med");
	level.var_611["dlc_zmb_dig02_eq_snow_lrg"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_eq_snow_lrg");
	level.var_611["dlc_zmb_dig02_eq_basalt_lrg"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_eq_basalt_lrg");
	level.var_611["dlc_zmb_dig02_eq_brick_lrg"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_eq_brick_lrg");
	level.var_611["dlc_zmb_dig02_snow_vapor"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_vapor");
	level.var_611["dlc_zmb_dig02_snow_fall_smallhole"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_fall_smallhole");
	level.var_611["dlc_zmb_dig02_snow_fall_sacrifice"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_fall_sacrifice");
	level.var_611["dlc_zmb_dig02_snow_ground_skitter"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_ground_skitter");
	level.var_611["dlc_zmb_dig02_snow_ground_wind"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_ground_wind");
	level.var_611["dlc_zmb_dig02_fire_bowl"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_fire_bowl");
	level.var_611["dlc_zmb_dig02_snow_falling_edge"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_falling_edge");
	level.var_611["dlc_zmb_dig02_snow_swirl"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_swirl");
	level.var_611["dlc_zmb_dig02_snow_falling_high"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_falling_high");
	level.var_611["dlc_zmb_dig02_snow_fall"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_fall");
	level.var_611["dlc_zmb_dig02_room_torch"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_room_torch");
	level.var_611["zmb_statue_room_torch"] = loadfx("vfx/map/mp_zombie_berlin/zmb_statue_room_torch");
	level.var_611["tra_roach_run_lrg"] = loadfx("vfx/map/train/tra_roach_run_lrg");
	level.var_611["dlc_zmb_dig02_dust_interior"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_dust_interior");
	level.var_611["dlc_zmb_dig02_blood_decal_sm"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_decal_sm");
	level.var_611["dlc_zmb_dig02_godray_01"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_godray_01");
	level.var_611["zmb_isl_rocks_falling_water_rnr"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_rocks_falling_water_rnr");
	level.var_611["dlc_zmb_dig02_water_trickle"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_water_trickle");
	level.var_611["dlc_zmb_dig02_blood_decal"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_decal");
	level.var_611["zmb_isl_blood_drip_hc_head"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_blood_drip_hc_head");
	level.var_611["dlc_zmb_dig02_waterdrops_lrg"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_waterdrops_lrg");
	level.var_611["dlc_zmb_dig02_blood_waterdrips"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_waterdrips");
	level.var_611["dlc_zmb_dig02_water_drip_fast"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_water_drip_fast");
	level.var_611["dlc_zmb_dig02_steam_sm"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_steam_sm");
	level.var_611["dlc_zmb_dig02_fog_ambient_sm"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_fog_ambient_sm");
	level.var_611["dlc_zmb_dig02_fog_ambient"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_fog_ambient");
	level.var_611["dlc_zmb_dig02_blood_waterfall_splsh"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_waterfall_splsh");
	level.var_611["dlc_zmb_dig02_blood_waterfall_dcl"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_waterfall_dcl");
	level.var_611["dlc_zmb_dig02_blood_waterfall"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_waterfall");
	level.var_611["zmb_dig_snow_fall_fast"] = loadfx("vfx/map/mp_zombie_dig/zmb_dig_snow_fall_fast");
	level.var_611["zmb_dig_snow_fall"] = loadfx("vfx/map/mp_zombie_dig/zmb_dig_snow_fall");
	level.var_611["zmb_receiver_full"] = loadfx("vfx/map/mp_zombie_nest/zmb_receiver_full");
	level.var_611["zmb_receiver_charge_pnt"] = loadfx("vfx/map/mp_zombie_nest/zmb_receiver_charge_pnt");
	level.var_611["ground_impact"] = loadfx("vfx/zombie/zmb_ground_impact");
	level.var_611["zmb_eye_glow"] = loadfx("vfx/zombie/prototype_fx/zombie_eye_glow");
	level.var_611["zmb_jolts_out"] = loadfx("vfx/zombie/zmb_jolts_out");
	level.var_611["zmb_zmb_key_light"] = loadfx("vfx/lights/mp_zombie_nest/zmb_zmb_key_light");
	level.var_611["zmb_nest_generator_light_red"] = loadfx("vfx/map/mp_zombie_nest/zmb_nest_generator_light_red");
	level.var_611["zmb_nest_generator_light_green"] = loadfx("vfx/map/mp_zombie_nest/zmb_nest_generator_light_green");
	level.var_611["zmb_nest_generator_bulb_red"] = loadfx("vfx/map/mp_zombie_nest/zmb_nest_generator_bulb_red");
	level.var_611["zmb_nest_generator_bulb_green"] = loadfx("vfx/map/mp_zombie_nest/zmb_nest_generator_bulb_green");
	level.var_611["zmb_dnk_uber_explode"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_uber_explode");
	level.var_611["zmb_dnk_uber_leak"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_uber_leak");
	level.var_611["dlc_zmb_dig02_sword_piece_glow"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_sword_piece_glow");
	level.var_611["zmb_ber_szlr_geistkraftexplode_1"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_szlr_geistkraftexplode_1");
	level.var_611["zmb_gk_claw_battery_charge_1"] = loadfx("vfx/map/mp_zombie_nest/zmb_gk_claw_battery_charge_1");
	level.var_611["zmb_gk_claw_battery_charge_2"] = loadfx("vfx/map/mp_zombie_nest/zmb_gk_claw_battery_charge_2");
	level.var_611["zmb_gk_claw_battery_charge_3"] = loadfx("vfx/map/mp_zombie_nest/zmb_gk_claw_battery_charge_3");
	level.var_611["zmb_blood_plate_fill"] = loadfx("vfx/zombie/prototype_fx/zmb_blood_plate_fill");
	level.var_611["dlc_zmb_dig02_blood_plates_emis"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_plates_emis");
	level.var_611["dlc_zmb_dig02_blood_plates_emis_lp"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_plates_emis_lp");
	level.var_611["zmb_med_trap_gib"] = loadfx("vfx/zombie/zmb_med_trap_gib");
	level.var_611["dlc_zmb_dig_02_spike_trap_on"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig_02_spike_trap_on");
}