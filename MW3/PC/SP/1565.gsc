/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1565.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:21:15 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("mi17_noai",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_mi17_woodland");
	maps\_vehicle::build_deathmodel("vehicle_mi17_woodland_fly");
	maps\_vehicle::build_deathmodel("vehicle_mi17_woodland_fly_cheap");
	maps\_vehicle::build_deathmodel("vehicle_mi17_woodland_landing");
	var_03 = [];
	maps\_vehicle::build_deathfx("fire/fire_smoke_trail_L","tag_engine_right","mi17_helicopter_dying_loop",1,0.05,1,0.5,1);
	maps\_vehicle::build_deathfx("explosions/aerial_explosion","tag_engine_right","mi17_helicopter_secondary_exp",undefined,undefined,undefined,2.5,1);
	maps\_vehicle::build_deathfx("explosions/aerial_explosion","tag_deathfx","mi17_helicopter_secondary_exp",undefined,undefined,undefined,4);
	maps\_vehicle::build_deathfx(var_7B[param_01],undefined,"mi17_helicopter_crash",undefined,undefined,undefined,-1,undefined,"stop_crash_loop_sound");
	maps\_vehicle::build_drive(%mi17_heli_rotors,undefined,0);
	maps\_vehicle::build_deathfx("explosions/grenadeexp_default","tag_engine_left","mi17_helicopter_hit",undefined,undefined,undefined,0.2,1);
	maps\_vehicle::build_deathfx("explosions/grenadeexp_default","tag_engine_right","mi17_helicopter_hit",undefined,undefined,undefined,0.5,1);
	maps\_vehicle::build_treadfx();
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_rumble("tank_rumble",0.15,4.5,600,1,1);
	maps\_vehicle::build_team("axis");
	maps\_vehicle::build_bulletshield(1);
	var_04 = randomfloatrange(0,1);
	var_05 = maps\_vehicle::get_light_model(param_01,var_03);
	maps\_vehicle::build_light(var_05,"cockpit_blue_cargo01","tag_light_cargo01","misc/aircraft_light_cockpit_red","interior",0);
	maps\_vehicle::build_light(var_05,"cockpit_blue_cockpit01","tag_light_cockpit01","misc/aircraft_light_cockpit_blue","interior",0.1);
	maps\_vehicle::build_light(var_05,"white_blink","tag_light_belly","misc/aircraft_light_white_blink","running",var_04);
	maps\_vehicle::build_light(var_05,"white_blink_tail","tag_light_tail","misc/aircraft_light_red_blink","running",var_04);
	maps\_vehicle::build_light(var_05,"wingtip_green","tag_light_L_wing","misc/aircraft_light_wingtip_green","running",var_04);
	maps\_vehicle::build_light(var_05,"wingtip_red","tag_light_R_wing","misc/aircraft_light_wingtip_red","running",var_04);
}

//Function Number: 2
init_local()
{
	self.originheightoffset = distance(self gettagorigin("tag_origin"),self gettagorigin("tag_ground"));
	self.fastropeoffset = 710;
	self.script_badplace = 0;
	maps\_vehicle::lights_on("running");
	maps\_vehicle::lights_on("interior");
}