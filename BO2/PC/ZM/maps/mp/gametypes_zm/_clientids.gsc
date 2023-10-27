/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes_zm\_clientids.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 3:02:26 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.clientid = 0;
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connecting",player);
		player.clientid = level.clientid;
		level.clientid++;
	}
}