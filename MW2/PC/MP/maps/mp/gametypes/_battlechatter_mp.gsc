/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_battlechatter_mp.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

init()
{
	level.isteamspeaking["allies"] = 0;
	level.isteamspeaking["axis"] = 0;
	level.speakers["allies"] = [];
	level.speakers["axis"] = [];
	level.bcsounds = [];
	level.bcsounds["reload"] = "inform_reloading_generic";
	level.bcsounds["frag_out"] = "inform_attack_grenade";
	level.bcsounds["flash_out"] = "inform_attack_flashbang";
	level.bcsounds["smoke_out"] = "inform_attack_smoke";
	level.bcsounds["conc_out"] = "inform_attack_stun";
	level.bcsounds["c4_plant"] = "inform_attack_thwc4";
	level.bcsounds["claymore_plant"] = "inform_plant_claymore";
	level.bcsounds["kill"] = "inform_killfirm_infantry";
	level.bcsounds["casualty"] = "inform_casualty_generic";
	level thread onplayerconnect();
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player thread onplayerspawned();
	}
}

onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		if(level.splitscreen)
		{
			continue;
		}

		thread claymoretracking();
		thread reloadtracking();
		thread grenadetracking();
	}
}

claymoretracking()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("begin_firing");
		weaponname = self getcurrentweapon();
		if(weaponname == "claymore_mp")
		{
			level thread saylocalsound(self, "claymore_plant");
		}
	}
}

reloadtracking()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("reload_start");
		level thread saylocalsound(self, "reload");
	}
}

grenadetracking()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire", grenade, weaponname);
		if(weaponname == "frag_grenade_mp")
		{
			level thread saylocalsound(self, "frag_out");
			continue;
		}

		if(weaponname == "flash_grenade_mp")
		{
			level thread saylocalsound(self, "flash_out");
			continue;
		}

		if(weaponname == "concussion_grenade_mp")
		{
			level thread saylocalsound(self, "conc_out");
			continue;
		}

		if(weaponname == "smoke_grenade_mp")
		{
			level thread saylocalsound(self, "smoke_out");
			continue;
		}

		if(weaponname == "c4_mp")
		{
			level thread saylocalsound(self, "c4_plant");
		}
	}
}

saylocalsounddelayed(player, soundtype, delay)
{
	player endon("death");
	player endon("disconnect");
	wait delay;
	saylocalsound(player, soundtype);
}

saylocalsound(player, soundtype)
{
	player endon("death");
	player endon("disconnect");
	if(isspeakerinrange(player))
	{
		return;
	}

	if(player.team != "spectator")
	{
		prefix = maps\mp\gametypes\_teams::getteamvoiceprefix(player.team) + "1_";
		soundalias = prefix + level.bcsounds[soundtype];
		player thread dosound(soundalias);
		return;
	}
}

dosound(soundalias)
{
	team = self.pers["team"];
	level addspeaker(self, team);
	self playsoundtoteam(soundalias, team, self);
	thread timehack(soundalias);
	common_scripts\utility::waittill_any(soundalias, "death", "disconnect");
	level removespeaker(self, team);
}

timehack(soundalias)
{
	self endon("death");
	self endon("disconnect");
	wait 2;
	self notify(soundalias);
}

isspeakerinrange(player)
{
	player endon("death");
	player endon("disconnect");
	distsq = 1000000;
	if(isdefined(player) && isdefined(player.pers["team"]) && player.pers["team"] != "spectator")
	{
		for(index = 0;index < level.speakers[player.pers["team"]].size;index++)
		{
			teammate = level.speakers[player.pers["team"]][index];
			if(teammate == player)
			{
				return 1;
			}

			if(distancesquared(teammate.origin, player.origin) < distsq)
			{
				return 1;
			}
		}
	}

	return 0;
}

addspeaker(player, team)
{
	level.speakers[team][level.speakers[team].size] = player;
}

removespeaker(player, team)
{
	newspeakers = [];
	for(index = 0;index < level.speakers[team].size;index++)
	{
		if(level.speakers[team][index] == player)
		{
			continue;
		}

		newspeakers[newspeakers.size] = level.speakers[team][index];
	}

	level.speakers[team] = newspeakers;
}