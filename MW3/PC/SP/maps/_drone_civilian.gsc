/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_drone_civilian.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 10 ms
 * Timestamp: 10/27/2023 2:20:05 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.attachpropsfunction["neutral"]["stand"]["idle"] = %casual_stand_idle;
	level.attachpropsfunction["neutral"]["stand"]["run"] = %unarmed_scared_run;
	level.attachpropsfunction["neutral"]["stand"]["death"] = %exposed_death;
	level.var_408D = ::animscripts/civilian/civilian_init::func_4083;
	maps\_drone::initglobals();
}