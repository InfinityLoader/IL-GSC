/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_clientids.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:10:28 AM
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