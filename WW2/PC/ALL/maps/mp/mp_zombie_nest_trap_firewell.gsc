/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_zombie_nest_trap_firewell.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 3:20:06 AM
*******************************************************************/

//Function Number: 1
func_9CAA(param_00)
{
	level notify("firewell_machinery_reset");
	wait(1.5);
	maps/mp/mp_zombie_nest_ee_fire_well::func_9CAB(param_00);
}