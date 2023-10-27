/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_drone_civilian.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 15 ms
 * Timestamp: 10/27/2023 2:34:19 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_1BAB["neutral"]["stand"]["idle"] = %casual_stand_idle;
	level.var_1BAB["neutral"]["stand"]["run"] = %unarmed_scared_run;
	level.var_1BAB["neutral"]["stand"]["death"] = %exposed_death;
	level.var_3B91 = ::animscripts/civilian/civilian_init::func_3B87;
	maps\_drone::func_1B95();
}