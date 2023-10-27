/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1204.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 3:22:26 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	level.var_611["raid_bulge_med_fire_smoke_mp"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_med_fire_smoke_mp");
	level.var_611["raid_bulge_large_fire_smoke_mp"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_large_fire_smoke_mp");
	level.var_611["raid_bulge_dest_wood_crate"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_dest_wood_crate");
	level.var_611["raid_bulge_trench_collapse"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_trench_collapse");
	level.var_611["raid_bulge_tiger_tread_snow_viz"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_tiger_tread_snow_viz");
	level.var_611["raid_bulge_tank_treads_exp"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_tank_treads_exp");
	level.var_611["raid_bulge_tank_treads_hit"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_tank_treads_hit");
	level.var_611["raid_vista_bridge_charge_sml"] = loadfx("vfx/map/mp_raid_bulge/raid_vista_bridge_charge_sml");
	level.var_611["raid_vista_bridge_charge"] = loadfx("vfx/map/mp_raid_bulge/raid_vista_bridge_charge");
	level.var_611["raid_vista_bridge_splashes"] = loadfx("vfx/map/mp_raid_bulge/raid_vista_bridge_splashes");
	level.var_611["raid_vista_bridge_splash_xlarge"] = loadfx("vfx/map/mp_raid_bulge/raid_vista_bridge_splash_xlarge");
	level.var_611["raid_vista_bridge_dust_trail"] = loadfx("vfx/map/mp_raid_bulge/raid_vista_bridge_dust_trail");
	level.var_611["raid_bulge_cavein_snow_slide"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_cavein_snow_slide");
	level.var_611["raid_bulge_cavein_dust"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_cavein_dust");
	level.var_611["raid_fire_torch_small"] = loadfx("vfx/map/mp_raid_cobra/raid_fire_torch_small");
	level.var_611["raid_bulge_tank_muzzle_rnr"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_tank_muzzle_rnr");
	level.var_611["raid_bulge_dripping_fire"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_dripping_fire");
	level.var_611["raid_bulge_fire_small"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_fire_small");
	level.var_611["raid_bulge_bridge_explosion_c"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_bridge_explosion_c");
	level.var_611["raid_bulge_bridge_explosion_b"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_bridge_explosion_b");
	level.var_611["raid_bulge_bridge_explosion_a"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_bridge_explosion_a");
	level.var_611["ambient_cloud_mist_lg_oriented"] = loadfx("vfx/map/mp_raid_bulge/ambient_cloud_mist_lg_oriented");
	level.var_611["fx_sunflare_mp_raid_bulge"] = loadfx("vfx/lensflare/fx_sunflare_mp_raid_bulge");
	level.var_611["fire_wreckage_tank"] = loadfx("vfx/map/remagen/fire_wreckage_tank");
	level.var_611["raid_bulge_vent_steam_sml"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_vent_steam_sml");
	level.var_611["raid_bulge_vista_explosion_rnr"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_vista_explosion_rnr");
	level.var_611["raid_cobra_fire_smoke_stack_l"] = loadfx("vfx/map/mp_raid_cobra/raid_cobra_fire_smoke_stack_l");
	level.var_611["krem_vista_smk_stack_dark"] = loadfx("vfx/map/mp_kremlin/krem_vista_smk_stack_dark");
	level.var_611["vista_fog_oriented"] = loadfx("vfx/fog/vista_fog_oriented");
	level.var_611["raid_bulge_fire_tree_02"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_fire_tree_02");
	level.var_611["raid_bulge_campfire_smolder"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_campfire_smolder");
	level.var_611["raid_bulge_campfire_fire"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_campfire_fire");
	level.var_611["raid_bulge_cold_breath_emitter"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_cold_breath_emitter");
	level.var_611["raid_bulge_artillery_snow_impact_rnr"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_artillery_snow_impact_rnr");
	level.var_611["snow_tornado_m_runner"] = loadfx("vfx/snow/snow_tornado_m_runner");
	level.var_611["raid_bulge_snow_ground_light_wind_lp"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_snow_ground_light_wind_lp");
	level.var_611["raid_bulge_snow_wind_lrg"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_snow_wind_lrg");
	level.var_611["raid_bulge_intro_cut_snow"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_intro_cut_snow");
	level.var_611["raid_bulge_tower_dest_fire_core"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_tower_dest_fire_core");
	level.var_611["raid_bulge_tower_dest_fire"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_tower_dest_fire");
	level.var_611["raid_bulge_tower_dest_smoke"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_tower_dest_smoke");
	level.var_611["raid_bulge_tower_impact_03"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_tower_impact_03");
	level.var_611["raid_bulge_tower_impact_02"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_tower_impact_02");
	level.var_611["raid_bulge_tower_impact_01"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_tower_impact_01");
	level.var_611["raid_bulge_snow_ground_skitter"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_snow_ground_skitter");
	level.var_611["raid_bulge_snow_fall_particles_dense"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_snow_fall_particles_dense");
	level.var_611["raid_bulge_snow_blowing"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_snow_blowing");
	level.var_611["raid_bulge_60mm_mortar_muzzle"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_60mm_mortar_muzzle");
	level.var_611["raid_bulge_artillery_snow_impact"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_artillery_snow_impact");
	level.var_611["raid_bulge_artillery_snow_impact_lrg"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_artillery_snow_impact_lrg");
	level.var_611["vf_wind_mp_raid_bulge"] = loadfx("vfx/vectorfield/vf_wind_mp_raid_bulge");
	level.var_611["us_tank_sherman_muzzle"] = loadfx("vfx/muzzleflash/us_tank_sherman_muzzle");
	level.var_611["veh_opel_blitz_explo_1_rnr"] = loadfx("vfx/destructible/veh_opel_blitz_explo_1_rnr");
	level.var_611["raid_bulge_water_drip"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_water_drip");
	level.var_611["raid_bulge_birds"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_birds");
	level.var_611["test_fx"] = loadfx("vfx/test/test_fx");
	level.var_611["raid_bulge_falling_dist"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_falling_dust");
	level.var_611["raid_bulge_bridge_collapse_tower"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_bridge_collapse_tower");
	level.var_611["raid_bulge_bridge_dust_linger"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_bridge_dust_linger");
	level.var_611["raid_bulge_bridge_collapse_debris"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_bridge_collapse_debris");
	level.var_611["raid_bulge_bridge_collapse_splashes"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_bridge_collapse_splashes");
	level.var_611["raid_bulge_bridge_smoke"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_bridge_smoke");
	level.var_611["raid_bulge_bridge_sim_debris"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_bridge_sim_debris");
	level.var_611["raid_bulge_bridge_sim_debris_close"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_bridge_sim_debris_close");
	level.var_611["raid_bulge_bridge_tower_debris"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_bridge_tower_debris");
	level.var_611["raid_bulge_bridge_splash_xlarge"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_bridge_splash_xlarge");
	level.var_611["raid_bulge_bridge_splash_large"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_bridge_splash_large");
	level.var_611["raid_bulge_bridge_dust_rise"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_bridge_dust_rise");
	level.var_611["raid_bulge_bridge_smoke_dark"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_bridge_smoke_dark");
	level.var_611["raid_bulge_bridge_dust_detail"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_bridge_dust_detail");
	level.var_611["raid_bulge_truck_tread"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_truck_tread");
	level.var_611["vehicle_tank_zone2_side_r_damage_2_heavysmoke"] = loadfx("vfx/vehicle/vehicle_tank_zone2_side_r_damage_2_heavysmoke");
	level.var_611["vehicle_tank_zone1_side_l_damage_2_heavysmoke"] = loadfx("vfx/vehicle/vehicle_tank_zone1_side_l_damage_2_heavysmoke");
	level.var_611["vehicle_tank_engine_damage_2_heavysmoke"] = loadfx("vfx/vehicle/vehicle_tank_engine_damage_2_heavysmoke");
	level.var_611["raid_bulge_snow_pile"] = loadfx("vfx/map/mp_raid_bulge/raid_bulge_snow_pile");
	level.var_611["tkn_snow_pile"] = loadfx("vfx/destructible/tkn_snow_pile");
}

//Function Number: 2
func_A476()
{
	var_00 = 56.4225;
	var_01 = common_scripts\utility::func_44F5("raid_vista_bridge_splash_xlarge");
	var_02 = common_scripts\utility::func_44F5("raid_vista_bridge_dust_trail");
	var_03 = (0,0,0);
	wait(2.4);
	playfxontag(var_02,self,"j_section1_p3");
	playfxontag(var_02,self,"j_section1_p4");
	var_03 = self gettagorigin("j_section2_p1");
	playfx(var_01,(var_03[0],var_03[1],var_00));
	wait(0.1);
	playfxontag(var_02,self,"j_section3_p1");
	playfxontag(var_02,self,"j_section3_p2");
	var_03 = self gettagorigin("j_section2_p3");
	playfx(var_01,(var_03[0],var_03[1],var_00));
	wait(0.2);
	playfxontag(var_02,self,"j_section5_p1");
	playfxontag(var_02,self,"j_section5_p2");
	var_03 = self gettagorigin("j_section2_p2");
	playfx(var_01,(var_03[0],var_03[1],var_00));
	var_03 = self gettagorigin("j_section4_p1");
	playfx(var_01,(var_03[0],var_03[1],var_00));
	var_03 = self gettagorigin("j_section4_p4");
	playfx(var_01,(var_03[0],var_03[1],var_00));
	wait(0.1);
	var_03 = self gettagorigin("j_section2_p4");
	playfx(var_01,(var_03[0],var_03[1],var_00));
	wait(0.2);
	var_03 = self gettagorigin("j_section4_p2");
	playfx(var_01,(var_03[0],var_03[1],var_00));
	var_03 = self gettagorigin("j_section4_p3");
	playfx(var_01,(var_03[0],var_03[1],var_00));
	wait(1.1);
	var_03 = self gettagorigin("j_section1_p1");
	playfx(var_01,(var_03[0],var_03[1],var_00));
	wait(0.1);
	var_03 = self gettagorigin("j_section1_p2");
	playfx(var_01,(var_03[0],var_03[1],var_00));
	var_03 = self gettagorigin("j_section5_p3");
	playfx(var_01,(var_03[0],var_03[1],var_00));
	wait(0.2);
	var_03 = self gettagorigin("j_section5_p4");
	playfx(var_01,(var_03[0],var_03[1],var_00));
	wait(0.6);
	stopfxontag(var_02,self,"j_section3_p1");
	var_03 = self gettagorigin("j_section3_p1");
	playfx(var_01,(var_03[0],var_03[1],var_00));
	wait(0.9);
	stopfxontag(var_02,self,"j_section1_p3");
	var_03 = self gettagorigin("j_section1_p3");
	playfx(var_01,(var_03[0],var_03[1],var_00));
	wait(0.6);
	stopfxontag(var_02,self,"j_section3_p2");
	var_03 = self gettagorigin("j_section3_p2");
	playfx(var_01,(var_03[0],var_03[1],var_00));
	wait(0.9);
	stopfxontag(var_02,self,"j_section1_p4");
	var_03 = self gettagorigin("j_section1_p4");
	playfx(var_01,(var_03[0],var_03[1],var_00));
	wait(0.5);
	stopfxontag(var_02,self,"j_section5_p2");
	var_03 = self gettagorigin("j_section5_p2");
	playfx(var_01,(var_03[0],var_03[1],var_00));
	wait(0.4);
	stopfxontag(var_02,self,"j_section5_p1");
	var_03 = self gettagorigin("j_section5_p1");
	playfx(var_01,(var_03[0],var_03[1],var_00));
}