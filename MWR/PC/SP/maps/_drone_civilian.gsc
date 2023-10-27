/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_drone_civilian.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 29 ms
 * Timestamp: 10/27/2023 2:47:41 AM
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