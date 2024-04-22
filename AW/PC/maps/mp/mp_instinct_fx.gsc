/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_instinct_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 185 ms
 * Timestamp: 4/22/2024 2:17:34 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["mp_ins_cave_flames_swap"] = loadfx("vfx/map/mp_instinct/mp_ins_cave_flames_swap");
	level._effect["river_splashes_1"] = loadfx("vfx/water/river_splashes_1");
	level._effect["light_godray_beam_9"] = loadfx("vfx/lights/light_godray_beam_9");
	level._effect["light_godray_beam_8"] = loadfx("vfx/lights/light_godray_beam_8");
	level._effect["mp_ins_cave_dust_lrg"] = loadfx("vfx/map/mp_instinct/mp_ins_cave_dust_lrg");
	level._effect["insects_flies_landing"] = loadfx("vfx/animal/insects_flies_landing");
	level._effect["insects_dragonfly_runner_a"] = loadfx("vfx/animal/insects_dragonfly_runner_a");
	level._effect["insects_moths"] = loadfx("vfx/animal/insects_moths");
	level._effect["ambient_particles"] = loadfx("vfx/dust/ambient_particles_bright");
	level._effect["rocks_fake_impacts_3sec"] = loadfx("vfx/rock/rocks_fake_impacts_3sec");
	level._effect["rocks_rolling_down_hill_3sec"] = loadfx("vfx/rock/rocks_rolling_down_hill_3sec");
	level._effect["mp_ins_cave_dust_lrg"] = loadfx("vfx/map/mp_instinct/mp_ins_cave_dust_lrg");
	level._effect["falling_water_exterior_thin"] = loadfx("vfx/water/falling_water_exterior_thin");
	level._effect["falling_water_exterior_narrow"] = loadfx("vfx/water/falling_water_exterior_narrow");
	level._effect["boulder_spurt"] = loadfx("vfx/rock/boulder_spurt");
	level._effect["exploding_boulder"] = loadfx("vfx/rock/exploding_boulder");
	level._effect["dirt_slide_bottom"] = loadfx("vfx/dust/dirt_slide_bottom");
	level._effect["pigeon_flock_runner_lrg2"] = loadfx("vfx/animal/pigeon_flock_runner_lrg2");
	level._effect["dmg_fire_box"] = loadfx("vfx/fire/dmg_fire_box");
	level._effect["dmg_fire_cylinder"] = loadfx("vfx/fire/dmg_fire_cylinder");
	level._effect["mp_ins_pyramid_fire_glow"] = loadfx("vfx/map/mp_instinct/mp_ins_pyramid_fire_glow");
	level._effect["mp_ins_cave_drill_impact_lp"] = loadfx("vfx/map/mp_instinct/mp_ins_cave_drill_impact_lp");
	level._effect["diesel_drill_dmg_smk_1"] = loadfx("vfx/smoke/diesel_drill_dmg_smk_1");
	level._effect["diesel_drill_smk_ring_lt_lp"] = loadfx("vfx/smoke/diesel_drill_smk_ring_lt_lp");
	level._effect["diesel_drill_smk_lt"] = loadfx("vfx/smoke/diesel_drill_smk_lt");
	level._effect["mp_ins_cave_dust_directional"] = loadfx("vfx/map/mp_instinct/mp_ins_cave_dust_directional");
	level._effect["mp_ins_smk_dirty_column"] = loadfx("vfx/map/mp_instinct/mp_ins_smk_dirty_column");
	level._effect["mp_ins_thick_cave_debris"] = loadfx("vfx/map/mp_instinct/mp_ins_thick_cave_debris");
	level._effect["cave_explosion_long_runner"] = loadfx("vfx/explosion/cave_explosion_long_runner");
	level._effect["cave_explosion_runner"] = loadfx("vfx/explosion/cave_explosion_runner");
	level._effect["cave_explosion_1"] = loadfx("vfx/explosion/cave_explosion_1");
	level._effect["gas_distortion_strip"] = loadfx("vfx/distortion/gas_distortion_strip");
	level._effect["ground_rock_impacts"] = loadfx("vfx/rock/ground_rock_impacts");
	level._effect["natural_gas_burst_lp"] = loadfx("vfx/gas/natural_gas_burst_lp");
	level._effect["lrg_rubble_fire_strip"] = loadfx("vfx/fire/lrg_rubble_fire_strip");
	level._effect["lrg_rubble_fire"] = loadfx("vfx/fire/lrg_rubble_fire");
	level._effect["fire_lrg_100x100_runner2"] = loadfx("vfx/fire/fire_lrg_100x100_runner2");
	level._effect["mp_ins_pyramid_smoke_column2"] = loadfx("vfx/map/mp_instinct/mp_ins_pyramid_smoke_column2");
	level._effect["pyramid_pre_explosion"] = loadfx("vfx/map/mp_instinct/pyramid_pre_explosion");
	level._effect["pyramid_explosion"] = loadfx("vfx/map/mp_instinct/pyramid_explosion");
	level._effect["pyramid_dirt_slide"] = loadfx("vfx/map/mp_instinct/pyramid_dirt_slide");
	level._effect["pyramid_exterior_explosion_rocks"] = loadfx("vfx/map/mp_instinct/pyramid_exterior_explosion_rocks");
	level._effect["mp_ins_gas_leak_ambient"] = loadfx("vfx/map/mp_instinct/mp_ins_gas_leak_ambient");
	level._effect["leaves_fall_twirl_no_physics_3"] = loadfx("vfx/wind/leaves_fall_twirl_no_physics_3");
	level._effect["diesel_drill_smk_ring"] = loadfx("vfx/smoke/diesel_drill_smk_ring");
	level._effect["diesel_drill_smk_loop"] = loadfx("vfx/smoke/diesel_drill_smk_loop");
	level._effect["drill_impact_dust"] = loadfx("vfx/dust/drill_impact_dust");
	level._effect["diesel_drill_smoke_puffs"] = loadfx("vfx/smoke/diesel_drill_smoke_puffs");
	level._effect["mp_ins_pyramid_smoke_column"] = loadfx("vfx/map/mp_instinct/mp_ins_pyramid_smoke_column");
	level._effect["small_generator_dmg_fire"] = loadfx("vfx/fire/small_generator_dmg_fire");
	level._effect["generator_damage_runner"] = loadfx("vfx/explosion/generator_damage_runner");
	level._effect["electrical_sparks_runner"] = loadfx("vfx/explosion/electrical_sparks_runner");
	level._effect["fire_lrg_100x20_runner"] = loadfx("vfx/fire/fire_lrg_100x20_runner");
	level._effect["fire_lrg_100x100_runner"] = loadfx("vfx/fire/fire_lrg_100x100_runner");
	level._effect["fire_med_50x50_runner"] = loadfx("vfx/fire/fire_med_50x50_runner");
	level._effect["fire_med_50x10_runner"] = loadfx("vfx/fire/fire_med_50x10_runner");
	level._effect["fire_lp_sm_radius10"] = loadfx("vfx/fire/fire_lp_sm_radius10");
	level._effect["fire_lp_med_radius10"] = loadfx("vfx/fire/fire_lp_med_radius10");
	level._effect["gas_pipe_leak_fire_burst"] = loadfx("vfx/fire/gas_pipe_leak_fire_burst");
	level._effect["dust_falling_cave_debris"] = loadfx("vfx/dust/dust_falling_cave_debris");
	level._effect["gas_distortion_oriented_lrg"] = loadfx("vfx/distortion/gas_distortion_oriented_lrg");
	level._effect["sfa_oil_tanker_explosion"] = loadfx("vfx/map/sanfran_a/sfa_oil_tanker_explosion");
	level._effect["fireball_hallway_1"] = loadfx("vfx/fire/fireball_hallway_1");
	level._effect["natural_gas_burst"] = loadfx("vfx/gas/natural_gas_burst");
	level._effect["rain_forest_dripping_leaves_100x100_runner"] = loadfx("vfx/water/rain_forest_dripping_leaves_100x100_runner");
	level._effect["cloud_shadows_lrg_blur"] = loadfx("vfx/cloud/cloud_shadows_lrg_blur");
	level._effect["diesel_drill_smk_puff_lp"] = loadfx("vfx/smoke/diesel_drill_smk_puff_lp");
	level._effect["diesel_drill_smk_puff"] = loadfx("vfx/smoke/diesel_drill_smk_puff");
	level._effect["fog_rising_patch_ground_narrow"] = loadfx("vfx/fog/fog_rising_patch_ground_narrow");
	level._effect["fog_rising_patch_ground"] = loadfx("vfx/fog/fog_rising_patch_ground");
	level._effect["large_shadows"] = loadfx("vfx/cloud/cloud_shadows_lrg");
	level._effect["foliage_tree_shadows_02"] = loadfx("vfx/foliage/foliage_tree_shadows_02");
	level._effect["foliage_tree_shadows_03"] = loadfx("vfx/foliage/foliage_tree_shadows_03");
	level._effect["foliage_tree_shadows_04"] = loadfx("vfx/foliage/foliage_tree_shadows_04");
	level._effect["foliage_tree_shadows_05"] = loadfx("vfx/foliage/foliage_tree_shadows_05");
	level._effect["foliage_tree_shadows_06"] = loadfx("vfx/foliage/foliage_tree_shadows_06");
	level._effect["rock_drill_debris_smk"] = loadfx("vfx/dust/rock_drill_debris_smk");
	level._effect["fog_rising_patch"] = loadfx("vfx/fog/fog_rising_patch");
	level._effect["dust_falling_debris_05_runner"] = loadfx("vfx/dust/dust_falling_debris_05_runner");
	level._effect["exterior_ground_steam_lp"] = loadfx("vfx/steam/exterior_ground_steam_lp");
	level._effect["light_dust_particles_far_lrg"] = loadfx("vfx/dust/light_dust_particles_far_lrg");
	level._effect["dust_falling_light_runner"] = loadfx("vfx/dust/dust_falling_light_runner");
	level._effect["exterior_ground_steam_far_lp"] = loadfx("vfx/steam/exterior_ground_steam_far_lp");
	level._effect["flare_ambient"] = loadfx("vfx/props/flare_ambient");
	level._effect["flare_ambient_02"] = loadfx("vfx/props/flare_ambient_02");
	level._effect["light_godray_beam_7"] = loadfx("vfx/lights/light_godray_beam_7");
	level._effect["light_godray_beam_6"] = loadfx("vfx/lights/light_godray_beam_6");
	level._effect["plastic_shreds_hanging_e_slow"] = loadfx("vfx/wind/plastic_shreds_hanging_e_slow");
	level._effect["falling_water_drip_100x100_runner_slow"] = loadfx("vfx/water/falling_water_drip_100x100_runner_slow");
	level._effect["falling_water_drip_100x100_runner"] = loadfx("vfx/water/falling_water_drip_100x100_runner");
	level._effect["instinct_red_glow"] = loadfx("vfx/lights/mp_instinct/instinct_red_glow");
	level._effect["fx_sunflare_instinct"] = loadfx("vfx/lensflare/fx_sunflare_instinct");
	thread cave_falling_debris_fx();
	thread ambient_flare_fx();
	thread cave_drill_fx();
	thread drill_dust_fx();
}

//Function Number: 2
cave_falling_debris_fx()
{
	wait(1);
	common_scripts\_exploder::activate_clientside_exploder(105);
}

//Function Number: 3
cave_drill_fx()
{
	wait(2.5);
	common_scripts\_exploder::activate_clientside_exploder(201);
	common_scripts\_exploder::activate_clientside_exploder(202);
	common_scripts\_exploder::activate_clientside_exploder(203);
	common_scripts\_exploder::activate_clientside_exploder(204);
}

//Function Number: 4
cave_drill_pounding_fx()
{
	common_scripts\_exploder::activate_clientside_exploder(172);
}

//Function Number: 5
drill_damage_fx()
{
	wait(2);
	common_scripts\_exploder::activate_clientside_exploder(171);
}

//Function Number: 6
cave_drill_rock_impact_fx()
{
	wait(0.4);
	common_scripts\_exploder::activate_clientside_exploder(172);
}

//Function Number: 7
ambient_flare_fx()
{
	wait(1);
	common_scripts\_exploder::activate_clientside_exploder(200);
}

//Function Number: 8
stop_ambient_flare_fx()
{
	stopclientexploder(200);
}

//Function Number: 9
drill_dust_fx()
{
	wait(5.7);
	common_scripts\_exploder::activate_clientside_exploder(172);
}