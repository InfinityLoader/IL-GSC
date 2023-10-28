/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_friendicons.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:10:30 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(level.createfx_enabled || sessionmodeiszombiesgame())
	{
		return;
	}

	if(GetDvar(#"5CCEB632") == "")
	{
		setdvar("scr_drawfriend","0");
	}

	level.drawfriend = GetDvarInt(#"5CCEB632");
/#
	assert(IsDefined(game["headicon_allies"]),"Allied head icons are not defined.  Check the team set for the level.");
#/
/#
	assert(IsDefined(game["headicon_axis"]),"Axis head icons are not defined.  Check the team set for the level.");
#/
	precacheheadicon(game["headicon_allies"]);
	precacheheadicon(game["headicon_axis"]);
	level thread onplayerconnect();
	for(;;)
	{
		updatefriendiconsettings();
		wait(5);
	}
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connecting",player);
		player thread onplayerspawned();
		player thread onplayerkilled();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self thread showfriendicon();
	}
}

//Function Number: 4
onplayerkilled()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("killed_player");
		self.headicon = "";
	}
}

//Function Number: 5
showfriendicon()
{
	if(level.drawfriend)
	{
		team = self.pers["team"];
		self.headicon = game["headicon_" + team];
		self.headiconteam = team;
	}
}

//Function Number: 6
updatefriendiconsettings()
{
	drawfriend = GetDvarFloat(#"5CCEB632");
	if(level.drawfriend != drawfriend)
	{
		level.drawfriend = drawfriend;
		updatefriendicons();
	}
}

//Function Number: 7
updatefriendicons()
{
	players = level.players;
	for(i = 0;i < players.size;i++)
	{
		player = players[i];
		if(IsDefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing")
		{
			if(level.drawfriend)
			{
				team = self.pers["team"];
				self.headicon = game["headicon_" + team];
				self.headiconteam = team;
			}
			else
			{
				players = level.players;
				for(i = 0;i < players.size;i++)
				{
					player = players[i];
					if(IsDefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing")
					{
						player.headicon = "";
					}
				}
			}
		}
	}
}