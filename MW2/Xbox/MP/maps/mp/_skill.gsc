/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_skill.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	level thread onplayerconnect();
	level thread onplayerdisconnect();
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player.connecttime = gettime();
		player.targets = [];
		player thread onweaponfired();
		player thread ondeath();
	}
}

onplayerdisconnect()
{
	for(;;)
	{
		level waittill("disconnected", player);
		player.targets = [];
	}
}

onweaponfired()
{
	level endon("game_ended");
	self endon("disconnected");
	self waittill("weapon_fired");
}

ondeath()
{
	level endon("game_ended");
	self endon("disconnected");
	self waittill("death");
}

processkill(attacker, defender)
{
	updateskill(attacker, defender, "tdm", 1);
}