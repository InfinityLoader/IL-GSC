/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_friendicons.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

init()
{
	level.drawfriend = 0;
	game["headicon_allies"] = maps\mp\gametypes\_teams::getteamheadicon("allies");
	game["headicon_axis"] = maps\mp\gametypes\_teams::getteamheadicon("axis");
	precacheheadicon(game["headicon_allies"]);
	precacheheadicon(game["headicon_axis"]);
	precacheshader("waypoint_revive");
	level thread onplayerconnect();
	for(;;)
	{
		updatefriendiconsettings();
		wait 5;
	}
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player thread onplayerspawned();
		player thread onplayerkilled();
	}
}

onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread showfriendicon();
	}
}

onplayerkilled()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("killed_player");
		self.headicon = "";
	}
}

showfriendicon()
{
	if(level.drawfriend)
	{
		if(self.pers["team"] == "allies")
		{
			self.headicon = game["headicon_allies"];
			self.headiconteam = "allies";
			return;
		}

		self.headicon = game["headicon_axis"];
		self.headiconteam = "axis";
		return;
	}
}

updatefriendiconsettings()
{
	drawfriend = maps\mp\_utility::getintproperty("scr_drawfriend", level.drawfriend);
	if(level.drawfriend != drawfriend)
	{
		level.drawfriend = drawfriend;
		updatefriendicons();
		return;
	}
}

updatefriendicons()
{
	players = level.players;
	for(i = 0;i < players.size;i++)
	{
		player = players[i];
		if(isdefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing")
		{
			if(level.drawfriend)
			{
				if(player.pers["team"] == "allies")
				{
					player.headicon = game["headicon_allies"];
					player.headiconteam = "allies";
				}
				else
				{
					player.headicon = game["headicon_axis"];
					player.headiconteam = "axis";
				}

				continue;
			}

			players = level.players;
			for(i = 0;i < players.size;i++)
			{
				player = players[i];
				if(isdefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing")
				{
					player.headicon = "";
				}
			}
		}
	}
}