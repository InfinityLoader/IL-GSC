/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_busing.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 3:03:38 AM
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