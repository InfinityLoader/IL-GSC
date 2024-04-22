/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _idle_smoke.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 27 ms
 * Timestamp: 4/22/2024 2:21:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\_props::add_smoking_notetracks("generic");
	level.scr_anim["generic"]["smoke_idle"][0] = %patrol_bored_idle_smoke;
	level.scr_anim["generic"]["smoke_react"] = %patrol_bored_react_look_advance;
}