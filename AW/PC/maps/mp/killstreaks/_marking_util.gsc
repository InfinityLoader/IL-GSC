/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\_marking_util.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 29 ms
 * Timestamp: 4/22/2024 2:11:55 AM
*******************************************************************/

//Function Number: 1
playerprocesstaggedassist(param_00)
{
	if(level.teambased && isdefined(param_00))
	{
		thread maps\mp\_events::processassistevent(param_00);
	}
}