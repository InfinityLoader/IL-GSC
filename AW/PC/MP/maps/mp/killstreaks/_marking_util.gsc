/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/killstreaks/_marking_util.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 15 ms
 * Timestamp: 10/27/2023 1:51:56 AM
*******************************************************************/

//Function Number: 1
playerprocesstaggedassist(param_00)
{
	if(level.teambased && isdefined(param_00))
	{
		thread maps\mp\_events::processassistevent(param_00);
	}
}