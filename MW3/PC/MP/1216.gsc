/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1216.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:15:21 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("pavelow_noai",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_pavelow");
	maps\_vehicle::build_deathfx("explosions/helicopter_explosion_secondary_small","tag_engine_left","pavelow_helicopter_secondary_exp",undefined,undefined,undefined,0,1);
	maps\_vehicle::build_deathfx("fire/fire_smoke_trail_L","tag_engine_left","pavelow_helicopter_dying_loop",1,0.05,1,0.5,1);
	maps\_vehicle::build_deathfx("explosions/helicopter_explosion_secondary_small","tag_engine_right","pavelow_helicopter_secondary_exp",undefined,undefined,undefined,2.5,1);
	maps\_vehicle::build_deathfx("explosions/helicopter_explosion_pavelow",undefined,"pavelow_helicopter_crash",undefined,undefined,undefined,-1,undefined,"stop_crash_loop_sound");
	maps\_vehicle::build_rocket_deathfx("explosions/aerial_explosion_pavelow_mp","tag_deathfx","pavelow_helicopter_crash",undefined,undefined,undefined,undefined,1,undefined,0);
	maps\_vehicle::build_treadfx();
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_drive(%bh_rotors,undefined,0);
	var_03 = maps\_vehicle::get_light_model(param_00,param_02);
	maps\_vehicle::build_light(var_03,"cockpit_red_cargo02","tag_light_cargo02","misc/aircraft_light_cockpit_red","interior",0);
	maps\_vehicle::build_light(var_03,"cockpit_blue_cockpit01","tag_light_cockpit01","misc/aircraft_light_cockpit_blue","interior",0.1);
	maps\_vehicle::build_light(var_03,"white_blink","tag_light_belly","misc/aircraft_light_white_blink","running",0.15);
	maps\_vehicle::build_light(var_03,"wingtip_green1","tag_light_L_wing1","misc/aircraft_light_wingtip_green","running",0.3);
	maps\_vehicle::build_light(var_03,"wingtip_red1","tag_light_R_wing1","misc/aircraft_light_wingtip_red","running",0.2);
	maps\_vehicle::build_light(var_03,"solid_tail","tag_light_tail2","misc/aircraft_light_wingtip_red","running",0.25);
	maps\_vehicle::build_light(var_03,"white_blink_tail","tag_light_tail","misc/aircraft_light_red_blink","running",0.05);
}

//Function Number: 2
init_local()
{
	self.originheightoffset = distance(self gettagorigin("tag_origin"),self gettagorigin("tag_ground"));
	self.script_badplace = 0;
	thread maps\_vehicle::lights_on("running");
}