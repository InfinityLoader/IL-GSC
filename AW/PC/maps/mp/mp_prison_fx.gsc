/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_prison_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 30 ms
 * Timestamp: 4/22/2024 2:18:10 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["light_fluorescent_smoke"] = loadfx("vfx/lights/light_fluorescent_smoke");
	level._effect["fireball_smk_M"] = loadfx("vfx/fire/fireball_lp_smk_M_no_light");
	level._effect["fireball_smk_S"] = loadfx("vfx/fire/fireball_lp_smk_S");
	level._effect["light_godray_beam_4"] = loadfx("vfx/lights/prison/prison_light_godray_beam_4");
	level._effect["light_godray_beam_blurry_large"] = loadfx("vfx/lights/light_godray_beam_blurry_large");
	level._effect["dust_falling_debris_runner"] = loadfx("vfx/dust/dust_falling_debris_runner");
	level._effect["dust_falling_debris_s_runner"] = loadfx("vfx/dust/dust_falling_debris_s_runner_loop");
	level._effect["dust_falling_light_runner"] = loadfx("vfx/dust/dust_falling_light_runner");
	level._effect["light_dust_particles"] = loadfx("vfx/dust/light_dust_particles");
	level._effect["prison_elec_sparks_runner"] = loadfx("vfx/explosion/prison_elec_sparks_runner");
	level._effect["steam_pipe_leak_sml"] = loadfx("vfx/steam/steam_pipe_leak_sml");
	level._effect["wind_blowing_debris"] = loadfx("vfx/wind/wind_blowing_debris");
	level._effect["battlefield_smoke_m"] = loadfx("vfx/smoke/battlefield_smoke_m");
	level._effect["battlefield_smoke_m_thick"] = loadfx("vfx/smoke/battlefield_smoke_m_thick");
	level._effect["insects_light_moths_complex"] = loadfx("vfx/animal/insects_light_moths_complex");
	level._effect["insects_flies_landing"] = loadfx("vfx/animal/insects_flies_landing");
	level._effect["trash_tornado_s_runner"] = loadfx("vfx/wind/trash_tornado_s_runner");
	level._effect["single_drip_runner_frequent"] = loadfx("vfx/water/single_drip_runner_frequent");
	level._effect["light_sedan_police"] = loadfx("vfx/lights/light_sedan_police");
	level._effect["light_fire_alarm_strobe"] = loadfx("vfx/lights/light_fire_alarm_strobe");
	level._effect["fire_hydrant_plume"] = loadfx("vfx/water/fire_hydrant_plume");
	level._effect["falling_water_low"] = loadfx("vfx/water/falling_water_low");
	level._effect["falling_water_low_narrow"] = loadfx("vfx/water/falling_water_low_narrow");
	level._effect["falling_water_low_splashes"] = loadfx("vfx/water/falling_water_low_splashes");
	level._effect["foam_flowing_s"] = loadfx("vfx/water/foam_flowing_s");
	level._effect["heat_distortion_m"] = loadfx("vfx/distortion/heat_distortion_m");
	level._effect["hand_scanner"] = loadfx("vfx/props/hand_scanner");
	level._effect["leaves_fall_gentlewind"] = loadfx("vfx/wind/leaves_small_fall_gentlewind");
	level._effect["gutter_splashes_1"] = loadfx("vfx/water/gutter_splashes_1");
	level._effect["prison_fluorescent_warm"] = loadfx("vfx/lights/prison/prison_fluorescent_warm");
	level._effect["prison_lgt_glow_square"] = loadfx("vfx/lights/prison/prison_lgt_glow_square");
	level._effect["fx_stadium_lgt_flare"] = loadfx("vfx/lensflare/fx_stadium_lgt_flare");
	level._effect["fire_lp_m_light"] = loadfx("vfx/fire/fire_lp_m_light");
	level._effect["fire_lp_m_blacksmk"] = loadfx("vfx/fire/fire_lp_m_blacksmk");
	level._effect["fire_lp_m_whitesmk"] = loadfx("vfx/fire/fire_lp_m_whitesmk");
	level._effect["fire_lp_m_light_blacksmk"] = loadfx("vfx/fire/fire_lp_m_light_blacksmk");
	level._effect["fire_lp_m_light_whitesmk"] = loadfx("vfx/fire/fire_lp_m_light_whitesmk");
	level._effect["fire_lp_m_blacksmk_tall"] = loadfx("vfx/fire/fire_lp_m_blacksmk_tall");
	level._effect["fire_lp_m_whitesmk_tall"] = loadfx("vfx/fire/fire_lp_m_whitesmk_tall");
	level._effect["fire_lp_m_light_blacksmk_tall"] = loadfx("vfx/fire/fire_lp_m_light_blacksmk_tall");
	level._effect["fire_lp_m_light_whitesmk_tall"] = loadfx("vfx/fire/fire_lp_m_light_whitesmk_tall");
	level._effect["fire_lp_m_flat_ground"] = loadfx("vfx/fire/fire_lp_m_flat_ground");
	level._effect["fire_lp_s_base"] = loadfx("vfx/fire/fire_lp_s_base");
	level._effect["fire_lp_s_light"] = loadfx("vfx/fire/fire_lp_s_light");
	level._effect["fire_lp_s_blacksmk"] = loadfx("vfx/fire/fire_lp_s_blacksmk");
	level._effect["fire_lp_s_whitesmk"] = loadfx("vfx/fire/fire_lp_s_whitesmk");
	level._effect["fire_lp_s_light_blacksmk"] = loadfx("vfx/fire/fire_lp_s_light_blacksmk");
	level._effect["fire_lp_s_light_whitesmk"] = loadfx("vfx/fire/fire_lp_s_light_whitesmk");
	level._effect["fire_lp_s_flat_ground"] = loadfx("vfx/fire/fire_lp_s_flat_ground");
	level._effect["fire_lp_xs_base"] = loadfx("vfx/fire/fire_lp_xs_base");
	level._effect["fire_lp_xs_light"] = loadfx("vfx/fire/fire_lp_xs_light");
	level._effect["fire_lp_xs_blacksmk"] = loadfx("vfx/fire/fire_lp_xs_blacksmk");
	level._effect["fire_lp_xs_whitesmk"] = loadfx("vfx/fire/fire_lp_xs_whitesmk");
	level._effect["fire_lp_xs_light_blacksmk"] = loadfx("vfx/fire/fire_lp_xs_light_blacksmk");
	level._effect["fire_lp_xs_light_whitesmk"] = loadfx("vfx/fire/fire_lp_xs_light_whitesmk");
	level._effect["fire_ceiling_md_slow"] = loadfx("vfx/fire/fire_ceiling_md_slow");
	level._effect["fire_falling_runner_box_100x100"] = loadfx("vfx/fire/fire_falling_runner_box_100x100");
	level._effect["fire_falling_runner_point"] = loadfx("vfx/fire/fire_falling_runner_point");
	level._effect["fire_falling_runner_point_infrequent"] = loadfx("vfx/fire/fire_falling_runner_point_infrequent");
	level._effect["insects_moths"] = loadfx("vfx/animal/insects_moths");
	level._effect["poison_gas_sprayer_prison"] = loadfx("vfx/fog/poison_gas_sprayer_prison");
	level._effect["poison_gas_sprayer_ground_contact"] = loadfx("vfx/fog/poison_gas_sprayer_prison_ground_contact");
	level._effect["poison_gas_sprayer_ground_fill"] = loadfx("vfx/fog/poison_gas_prison_ground_fill");
	level._effect["poison_gas_prison_door_spill"] = loadfx("vfx/fog/poison_gas_prison_door_spill");
	level._effect["light_poison_gas_alarm_strobe"] = loadfx("vfx/lights/light_poison_gas_alarm_strobe");
}