/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_vlobby_room_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 346 ms
 * Timestamp: 4/22/2024 2:18:46 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["vlobby_dust"] = loadfx("vfx/map/mp_vlobby_room/vlobby_dust");
	level._effect["vlobby_steam"] = loadfx("vfx/map/mp_vlobby_room/vlobby_steam");
	level._effect["expround_asphalt_1"] = loadfx("vfx/weaponimpact/expround_asphalt_1");
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
	level._effect["mp_ref_elev_rain_inner"] = loadfx("vfx/map/mp_refraction/mp_ref_elev_rain_inner");
	level._effect["steam_cylinder_lrg"] = loadfx("vfx/steam/steam_cylinder_lrg");
	level._effect["electrical_sparks_runner"] = loadfx("vfx/explosion/electrical_sparks_runner");
	level._effect["emergency_lt_red_off"] = loadfx("vfx/lights/emergency_lt_red_off");
	level._effect["emergency_lt_red_on"] = loadfx("vfx/lights/emergency_lt_red_on");
	level._effect["sparks_burst_b"] = loadfx("vfx/explosion/sparks_burst_b");
	level._effect["emergency_lt_red_pulse_lp"] = loadfx("vfx/lights/emergency_lt_red_pulse_lp");
	level._effect["vlobby_spt_shadow"] = loadfx("vfx/lights/mp_vlobby_refraction/vlobby_spt_shadow");
	thread elevator_rain_on_fx();
	thread elevator_steam_on_fx();
	thread lightning_bolt_fx();
	maps\mp\_utility::delaythread(0.1,::warning_sign_hide_fx);
}

//Function Number: 2
elevator_ascend_fx()
{
	wait(1);
	level thread common_scripts\_exploder::activate_clientside_exploder(213);
}

//Function Number: 3
elevator_rain_on_fx()
{
	wait(1);
	level.rain_elevator_fx = common_scripts\utility::spawn_tag_origin();
	level.rain_elevator_fx show();
	wait(1);
	level.rain_elevator_fx.origin = (24,1144,6459);
	level.rain_elevator_fx.angles = (270,0,0);
	playfxontag(common_scripts\utility::getfx("mp_ref_elev_rain_inner"),level.rain_elevator_fx,"tag_origin");
}

//Function Number: 4
elevator_rain_off_fx()
{
	wait(8);
	stopfxontag(common_scripts\utility::getfx("mp_ref_elev_rain_inner"),level.rain_elevator_fx,"tag_origin");
	level.rain_elevator_fx delete();
}

//Function Number: 5
elevator_steam_on_fx()
{
	wait(1);
	level.steam_elevator_fx = common_scripts\utility::spawn_tag_origin();
	level.steam_elevator_fx show();
	wait(1);
	level.steam_elevator_fx.origin = (-10,1150,1482);
	level.steam_elevator_fx.angles = (270,0,0);
	playfxontag(common_scripts\utility::getfx("steam_cylinder_lrg"),level.steam_elevator_fx,"tag_origin");
}

//Function Number: 6
elevator_steam_off_fx()
{
	wait(8);
	stopfxontag(common_scripts\utility::getfx("steam_cylinder_lrg"),level.steam_elevator_fx,"tag_origin");
	level.steam_elevator_fx delete();
}

//Function Number: 7
elevator_descend_spark_fx()
{
	wait(7);
	level thread common_scripts\_exploder::activate_clientside_exploder(201);
}

//Function Number: 8
elevator_cage_steam_fx()
{
	wait(2);
	level thread common_scripts\_exploder::activate_clientside_exploder(202);
}

//Function Number: 9
elevator_clamps_spark_fx()
{
	wait(1);
	level thread common_scripts\_exploder::activate_clientside_exploder(203);
}

//Function Number: 10
elevator_wall_steam_rise_fx()
{
	wait(13);
	level thread common_scripts\_exploder::activate_clientside_exploder(204);
}

//Function Number: 11
elevator_rm_dripping_water_fx()
{
	wait(10);
	level thread common_scripts\_exploder::activate_clientside_exploder(205);
}

//Function Number: 12
elevator_arrival_wind_gust_fx()
{
	wait(10);
	level thread common_scripts\_exploder::activate_clientside_exploder(206);
}

//Function Number: 13
elevator_outer_vent_lights_fx()
{
	wait(9);
	level thread common_scripts\_exploder::activate_clientside_exploder(207);
}

//Function Number: 14
elevator_shaft_fake_light_rays()
{
	wait(7.5);
	level thread common_scripts\_exploder::activate_clientside_exploder(211);
}

//Function Number: 15
steam_vent_burst_fx()
{
	wait(12);
	level thread common_scripts\_exploder::activate_clientside_exploder(214);
}

//Function Number: 16
attach_fx_to_mechanism()
{
	wait(1);
	var_00 = getent("elevator_lock_b","targetname");
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_off"),var_00,"TAG_VFX_LIGHT1");
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_off"),var_00,"TAG_VFX_LIGHT2");
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_off"),var_00,"TAG_VFX_LIGHT3");
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_off"),var_00,"TAG_VFX_LIGHT4");
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_off"),var_00,"TAG_VFX_LIGHT5");
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_off"),var_00,"TAG_VFX_LIGHT6");
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_off"),var_00,"TAG_VFX_LIGHT7");
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_off"),var_00,"TAG_VFX_LIGHT8");
}

//Function Number: 17
part_b_mechanism_light_pulse_fx()
{
	wait(6);
	var_00 = getent("elevator_lock_b","targetname");
	level thread common_scripts\_exploder::activate_clientside_exploder(212);
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_pulse_lp"),var_00,"TAG_VFX_LIGHT7");
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_pulse_lp"),var_00,"TAG_VFX_LIGHT6");
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_pulse_lp"),var_00,"TAG_VFX_LIGHT2");
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_pulse_lp"),var_00,"TAG_VFX_LIGHT3");
	wait(0.55);
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_pulse_lp"),var_00,"TAG_VFX_LIGHT8");
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_pulse_lp"),var_00,"TAG_VFX_LIGHT5");
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_pulse_lp"),var_00,"TAG_VFX_LIGHT4");
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_pulse_lp"),var_00,"TAG_VFX_LIGHT1");
}

//Function Number: 18
part_b_mechanism_light_glow_fx()
{
	wait(1);
	var_00 = getent("elevator_lock_b","targetname");
	wait(2);
	stopfxontag(common_scripts\utility::getfx("emergency_lt_red_pulse_lp"),var_00,"TAG_VFX_LIGHT1");
	stopfxontag(common_scripts\utility::getfx("emergency_lt_red_pulse_lp"),var_00,"TAG_VFX_LIGHT2");
	stopfxontag(common_scripts\utility::getfx("emergency_lt_red_pulse_lp"),var_00,"TAG_VFX_LIGHT3");
	stopfxontag(common_scripts\utility::getfx("emergency_lt_red_pulse_lp"),var_00,"TAG_VFX_LIGHT4");
	wait(0.55);
	stopfxontag(common_scripts\utility::getfx("emergency_lt_red_pulse_lp"),var_00,"TAG_VFX_LIGHT5");
	stopfxontag(common_scripts\utility::getfx("emergency_lt_red_pulse_lp"),var_00,"TAG_VFX_LIGHT6");
	stopfxontag(common_scripts\utility::getfx("emergency_lt_red_pulse_lp"),var_00,"TAG_VFX_LIGHT7");
	stopfxontag(common_scripts\utility::getfx("emergency_lt_red_pulse_lp"),var_00,"TAG_VFX_LIGHT8");
	wait(8);
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_on"),var_00,"TAG_VFX_LIGHT1");
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_on"),var_00,"TAG_VFX_LIGHT8");
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_on"),var_00,"TAG_VFX_LIGHT2");
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_on"),var_00,"TAG_VFX_LIGHT7");
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("sparks_burst_b"),var_00,"TAG_VFX_LIGHT3");
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_on"),var_00,"TAG_VFX_LIGHT6");
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_on"),var_00,"TAG_VFX_LIGHT4");
	playfxontag(common_scripts\utility::getfx("emergency_lt_red_on"),var_00,"TAG_VFX_LIGHT5");
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("electrical_sparks_runner"),var_00,"TAG_VFX_LIGHT3");
}

//Function Number: 19
elevator_mechanism_steam_fx()
{
	wait(10.2);
	level thread common_scripts\_exploder::activate_clientside_exploder(208);
}

//Function Number: 20
warning_sign_hide_fx()
{
	var_00 = getentarray("warning_signs","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}
}

//Function Number: 21
warning_sign_show_fx()
{
	var_00 = getentarray("warning_signs","targetname");
	foreach(var_02 in var_00)
	{
		var_02 show();
	}

	level thread common_scripts\_exploder::activate_clientside_exploder(210);
}

//Function Number: 22
lightning_bolt_fx()
{
	for(;;)
	{
		wait(randomfloatrange(2,6));
		var_00 = 220 + randomint(8);
		activateclientexploder(var_00);
	}
}