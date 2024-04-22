/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _mi17_noai.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 50 ms
 * Timestamp: 4/22/2024 2:05:07 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("mi17_noai",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_mil_mi17");
	maps\_vehicle::build_deathmodel("vehicle_mi17_woodland");
	maps\_vehicle::build_deathmodel("vehicle_mi17_woodland_fly");
	maps\_vehicle::build_deathmodel("vehicle_mi17_woodland_fly_cheap");
	maps\_vehicle::build_deathmodel("vehicle_mi17_woodland_landing");
	var_03 = [];
	var_03["vehicle_mil_mi17"] = "vfx/explosion/vehicle_explosion_heli_piece_impact";
	var_03["vehicle_mi17_woodland"] = "vfx/explosion/vehicle_mi17_explosion_a";
	var_03["vehicle_mi17_woodland_fly"] = "vfx/explosion/vehicle_explosion_heli_piece_impact";
	var_03["vehicle_mi17_woodland_fly_cheap"] = "vfx/explosion/vehicle_mi17_explosion_a";
	var_03["vehicle_mi17_woodland_landing"] = "vfx/explosion/vehicle_mi17_explosion_a";
	var_03["vehicle_mi-28_flying"] = "vfx/explosion/vehicle_mi17_explosion_a";
	var_04 = var_03[param_00];
	maps\_vehicle::build_deathfx("vfx/trail/trail_fire_smoke_l","tag_engine_right","mi17_helicopter_dying_loop",1,0.05,1,0.5,1,undefined);
	maps\_vehicle::build_deathfx("vfx/explosion/helicopter_explosion_secondary_small","tag_engine_right","mi17_helicopter_secondary_exp",undefined,undefined,undefined,2.5,1,undefined);
	maps\_vehicle::build_deathfx("vfx/explosion/helicopter_explosion_secondary_small","tag_deathfx","mi17_helicopter_secondary_exp",undefined,undefined,undefined,4,undefined,undefined);
	maps\_vehicle::build_deathfx(var_04,undefined,"mi17_helicopter_crash",undefined,undefined,undefined,-1,undefined,"stop_crash_loop_sound");
	maps\_vehicle::build_drive(%mi17_heli_rotors,undefined,0);
	maps\_vehicle::build_deathfx("vfx/explosion/helicopter_explosion_secondary_small","tag_engine_left","mi17_helicopter_impact_explo_3d",undefined,undefined,undefined,0.2,1);
	maps\_vehicle::build_deathfx("vfx/explosion/vehicle_mi17_explosion_a","tag_deathfx",undefined,undefined,undefined,undefined,0.5,1);
	maps\_vehicle::build_treadfx();
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_rumble("tank_rumble",0.15,4.5,600,1,1);
	maps\_vehicle::build_team("axis");
	maps\_vehicle::build_bulletshield(1);
	var_05 = randomfloatrange(0,1);
	maps\_vehicle::build_is_helicopter();
}

//Function Number: 2
init_local()
{
	self.originheightoffset = distance(self gettagorigin("tag_origin"),self gettagorigin("tag_ground"));
	self.fastropeoffset = 710;
	self.script_badplace = 0;
	maps\_vehicle::vehicle_lights_on("running");
	maps\_vehicle::vehicle_lights_on("interior");
}