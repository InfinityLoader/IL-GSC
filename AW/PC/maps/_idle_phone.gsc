/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _idle_phone.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 28 ms
 * Timestamp: 4/22/2024 2:21:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\_props::add_cellphone_notetracks("generic");
	level.scr_anim["generic"]["phone_idle"][0] = %patrol_bored_idle_cellphone;
	level.scr_anim["generic"]["phone_react"] = %patrol_bored_react_look_retreat;
}