/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_perplayer.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 11
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:13:35 AM
*******************************************************************/

#include maps/mp/_utility;

//Function Number: 1
init(id,playerbegincallback,playerendcallback)
{
	precacheshader("objpoint_default");
	handler = spawnstruct();
	handler.id = id;
	handler.playerbegincallback = playerbegincallback;
	handler.playerendcallback = playerendcallback;
	handler.enabled = 0;
	handler.players = [];
	thread onplayerconnect(handler);
	level.handlerglobalflagval = 0;
	return handler;
}

//Function Number: 2
enable(handler)
{
	if(handler.enabled)
	{
		return;
	}

	handler.enabled = 1;
	level.handlerglobalflagval++;
	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		players[i].handlerflagval = level.handlerglobalflagval;
	}

	players = handler.players;
	for(i = 0;i < players.size;i++)
	{
		if(players[i].handlerflagval != level.handlerglobalflagval)
		{
		}
		else if(players[i].handlers[handler.id].ready)
		{
			players[i] handleplayer(handler);
		}
	}
}

//Function Number: 3
disable(handler)
{
	if(!(handler.enabled))
	{
		return;
	}

	handler.enabled = 0;
	level.handlerglobalflagval++;
	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		players[i].handlerflagval = level.handlerglobalflagval;
	}

	players = handler.players;
	for(i = 0;i < players.size;i++)
	{
		if(players[i].handlerflagval != level.handlerglobalflagval)
		{
		}
		else if(players[i].handlers[handler.id].ready)
		{
			players[i] unhandleplayer(handler,0,0);
		}
	}
}

//Function Number: 4
onplayerconnect(handler)
{
	for(;;)
	{
		level waittill("connecting",player);
		if(!(IsDefined(player.handlers)))
		{
			player.handlers = [];
		}

		player.handlers[handler.id] = spawnstruct();
		player.handlers[handler.id].ready = 0;
		player.handlers[handler.id].handled = 0;
		player.handlerflagval = -1;
		handler.players[handler.players.size] = player;
		player thread onplayerdisconnect(handler);
		player thread onplayerspawned(handler);
		player thread onjoinedteam(handler);
		player thread onjoinedspectators(handler);
		player thread onplayerkilled(handler);
	}
}

//Function Number: 5
onplayerdisconnect(handler)
{
	self waittill("disconnect");
	newplayers = [];
	for(i = 0;i < handler.players.size;i++)
	{
		if(handler.players[i] != self)
		{
			newplayers[newplayers.size] = handler.players[i];
		}
	}

	handler.players = newplayers;
	self thread unhandleplayer(handler,1,1);
}

//Function Number: 6
onjoinedteam(handler)
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		self thread unhandleplayer(handler,1,0);
	}
}

//Function Number: 7
onjoinedspectators(handler)
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_spectators");
		self thread unhandleplayer(handler,1,0);
	}
}

//Function Number: 8
onplayerspawned(handler)
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self thread handleplayer(handler);
	}
}

//Function Number: 9
onplayerkilled(handler)
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("killed_player");
		self thread unhandleplayer(handler,1,0);
	}
}

//Function Number: 10
handleplayer(handler)
{
	self.handlers[handler.id].ready = 1;
	if(!(handler.enabled))
	{
		return;
	}

	if(self.handlers[handler.id].handled)
	{
		return;
	}

	self.handlers[handler.id].handled = 1;
	self thread [[ handler.playerbegincallback ]]();
}

//Function Number: 11
unhandleplayer(handler,unsetready,disconnected)
{
	if(!disconnected && unsetready)
	{
		self.handlers[handler.id].ready = 0;
	}

	if(!(self.handlers[handler.id].handled))
	{
		return;
	}

	if(!(disconnected))
	{
		self.handlers[handler.id].handled = 0;
	}

	self thread [[ handler.playerendcallback ]](disconnected);
}