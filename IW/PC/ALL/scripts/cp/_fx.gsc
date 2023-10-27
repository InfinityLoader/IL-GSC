/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\_fx.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 68 ms
 * Timestamp: 10/27/2023 12:23:33 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_95F5();
}

//Function Number: 2
func_95F5()
{
	level._effect["melee_blood"] = loadfx("vfx/core/impacts/small/impact_alien_flesh_hit_b_fatal");
	level._effect["vfx_scrnfx_tocam_slidedust_m"] = loadfx("vfx/core/screen/vfx_scrnfx_tocam_slidedust_m");
	level._effect["vfx_melee_blood_spray"] = loadfx("vfx/core/screen/vfx_melee_blood_spray");
	level._effect["vfx_blood_hit_left"] = loadfx("vfx/core/screen/vfx_blood_hit_left");
	level._effect["vfx_blood_hit_right"] = loadfx("vfx/core/screen/vfx_blood_hit_right");
}