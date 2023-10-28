/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_busing.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:13:43 AM
*******************************************************************/

#include maps/mp/_utility;

//Function Number: 1
businit()
{
/#
	assert(level.clientscripts);
#/
	level.busstate = "";
	registerclientsys("busCmd");
}

//Function Number: 2
setbusstate(state)
{
	if(level.busstate != state)
	{
		setclientsysstate("busCmd",state);
	}

	level.busstate = state;
}