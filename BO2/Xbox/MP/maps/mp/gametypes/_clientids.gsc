/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_clientids.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 3:04:17 AM
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