/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/killstreaks/_marking_util.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 2:09:37 AM
*******************************************************************/

//Function Number: 1
playerprocesstaggedassist(param_00)
{
	if(level.teambased && isdefined(param_00))
	{
		thread maps\mp\_events::processassistevent(param_00);
	}
}