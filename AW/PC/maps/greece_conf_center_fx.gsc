/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_conf_center_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 205 ms
 * Timestamp: 4/22/2024 2:30:53 AM
*******************************************************************/

//Function Number: 1
main()
{
	thread precachefx();
}

//Function Number: 2
precachefx()
{
	level._effect["cc_building_explosion"] = loadfx("vfx/map/greece/greece_explosion_cc_runner");
	level._effect["cc_flashbang"] = loadfx("vfx/map/greece/greece_flashbang");
	level._effect["cc_explosion"] = loadfx("vfx/map/greece/greece_vehicle_explo_small_runner");
	level._effect["cc_fire_small"] = loadfx("vfx/map/greece/greece_fire_ground_01");
	level._effect["cc_room_fire_alarm"] = loadfx("fx/lights/lights_sub_alarm_strobe");
	level._effect["sniper_drone_flash_view"] = loadfx("vfx/muzzleflash/sniper_drone_flash_view");
	level._effect["sniper_drone_tracer"] = loadfx("vfx/muzzleflash/sniper_drone_tracer");
	level._effect["sniper_drone_thruster_view"] = loadfx("vfx/distortion/sniper_drone_runner_idle_view");
	level._effect["sniper_drone_wind_marker"] = loadfx("vfx/map/greece/sniper_drone_wind_marker_runner");
	level._effect["water_movement"] = loadfx("vfx/map/greece/greece_water_wake_small_element");
	level._effect["sniperdrone_cc_explosion_debris_view"] = loadfx("vfx/map/greece/greece_cc_glass_shatter_drone_view");
	level._effect["sniperdrone_cc_death_fx"] = loadfx("vfx/map/greece/greece_sniper_drone_damage");
	level._effect["kamikaze_drone_explosion"] = loadfx("vfx/map/greece/greece_rocket_explosion_default");
	level._effect["kamikaze_drone_trail"] = loadfx("vfx/trail/smoketrail_rpg_greece");
	level._effect["kamikaze_drone_launch"] = loadfx("vfx/muzzleflash/rpg_flash_wv");
	level._effect["knife_kill_fx"] = loadfx("fx/maps/warlord/intro_blood_throat_stab");
	level._effect["truck_brakelight"] = loadfx("vfx/lights/veh_civ_delivery_truck_stop_light");
	level._effect["hades_body_scan_fx"] = loadfx("vfx/map/greece/greece_hades_bodyscan");
	level._effect["technical_muzzle_flash"] = loadfx("vfx/muzzleflash/50cal_flash_wv");
}

//Function Number: 3
confcentergatecharge()
{
	common_scripts\_exploder::exploder(500);
}

//Function Number: 4
confcenterpoolsplash()
{
	common_scripts\_exploder::exploder(600);
}

//Function Number: 5
confcenterpoolallywaterdrip()
{
	var_00 = maps\_utility::get_living_ai("Infiltrator1","script_noteworthy");
	var_00.animname = "infiltrator1";
	playfxontag(common_scripts\utility::getfx("cc_building_character_water_drip_runner"),var_00,"J_SpineUpper");
	playfxontag(common_scripts\utility::getfx("cc_building_character_water_drip_runner"),var_00,"J_Knee_RI");
	playfxontag(common_scripts\utility::getfx("cc_building_character_water_drip_runner"),var_00,"J_Knee_LE");
}

//Function Number: 6
confcenteratriumflashcharge()
{
	common_scripts\_exploder::exploder(700);
}

//Function Number: 7
confcenterlightglowfx()
{
	common_scripts\_exploder::exploder(900);
}

//Function Number: 8
hadesbodyscanfx(param_00)
{
	playfxontag(common_scripts\utility::getfx("hades_body_scan_fx"),param_00,"J_WristTwist_LE");
}

//Function Number: 9
confcenterbossexplode()
{
	common_scripts\_exploder::exploder(1000);
	common_scripts\_exploder::kill_exploder(900);
}

//Function Number: 10
confcenterresidualsmoke()
{
	common_scripts\_exploder::exploder(1001);
}

//Function Number: 11
confcenterexplosion()
{
	var_00 = getent("ConfCenterExplosion","targetname");
	common_scripts\_exploder::exploder(2000);
	maps\_hms_utility::printlnscreenandconsole("KA-BOOM!!!");
	common_scripts\_exploder::kill_exploder(1000);
	common_scripts\_exploder::kill_exploder(130);
}