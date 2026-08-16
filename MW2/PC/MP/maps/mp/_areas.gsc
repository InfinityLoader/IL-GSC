/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_areas.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

init()
{
	level.softlandingtriggers = getentarray("trigger_multiple_softlanding", "classname");
	destructibles = getentarray("destructible_vehicle", "targetname");
	foreach(trigger in level.softlandingtriggers)
	{
		if(trigger.script_type != "car")
		{
			continue;
		}

		foreach(destructible in destructibles)
		{
			if(distance(trigger.origin, destructible.origin) > 64)
			{
				continue;
			}

			trigger.destructible = destructible;
		}
	}

	thread onplayerconnect();
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player.softlanding = undefined;
		player thread softlandingwaiter();
	}
}

playerentersoftlanding(trigger)
{
	self.softlanding = trigger;
}

playerleavesoftlanding(trigger)
{
	self.softlanding = undefined;
}

softlandingwaiter()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("soft_landing", trigger, damage);
		if(!isdefined(trigger.destructible))
		{
			continue;
		}
	}
}