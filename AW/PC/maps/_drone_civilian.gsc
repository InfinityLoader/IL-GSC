/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _drone_civilian.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 36 ms
 * Timestamp: 4/22/2024 2:20:47 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.drone_anims["neutral"]["stand"]["idle"] = %casual_stand_idle;
	level.drone_anims["neutral"]["stand"]["run"] = %unarmed_scared_run;
	level.drone_anims["neutral"]["stand"]["death"] = %exposed_death;
	level.attachpropsfunction = ::animscripts\civilian\civilian_init::attachprops;
	maps\_drone::initglobals();
}