/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_dev.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player thread updatereflectionprobe();
	}
}

updatereflectionprobe()
{
}

reflectionprobebuttons()
{
}