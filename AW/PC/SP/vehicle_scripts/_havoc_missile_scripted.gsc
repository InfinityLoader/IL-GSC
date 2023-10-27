/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts/_havoc_missile_scripted.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 48 ms
 * Timestamp: 10/27/2023 2:06:18 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("sidewinder_scripted",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_sidewinder_scripted");
	maps\_vehicle::build_treadfx();
	level._effect["engineeffect"] = loadfx("vfx/trail/jet_thruster_far");
	level._effect["afterburner"] = loadfx("vfx/fire/jet_afterburner_ignite");
	level._effect["contrail"] = loadfx("vfx/trail/jet_contrail");
	maps\_vehicle::build_deathfx("vfx/explosion/vehicle_generic_ai_explo_lrg_runner",undefined,"explo_metal_rand");
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_is_airplane();
}

//Function Number: 2
init_local()
{
	thread playthrustereffects();
}

//Function Number: 3
playthrustereffects()
{
	self endon("death");
	self endon("stop_engineeffects");
	var_00 = common_scripts\utility::getfx("contrail");
	playfxontag(var_00,self,"tag_origin");
}

//Function Number: 4
stop_sound(param_00)
{
	self notify("stop sound" + param_00);
}