/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_friendicons.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 130 ms
 * Timestamp: 10/27/2023 1:18:07 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.drawfriend = 0;
	game["headicon_allies"] = maps\mp\gametypes\_teams::func_3C38("allies");
	game["headicon_axis"] = maps\mp\gametypes\_teams::func_3C38("axis");
	precacheheadicon(game["headicon_allies"]);
	precacheheadicon(game["headicon_axis"]);
	precacheshader("waypoint_revive");
	level thread func_595D();
	for(;;)
	{
		func_86EC();
		wait(5);
	}
}

//Function Number: 2
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
		var_00 thread onplayerkilled();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread func_7510();
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
func_7510()
{
	if(level.drawfriend)
	{
		if(self.pers["team"] == "allies")
		{
			self.headicon = game["headicon_allies"];
			self.headiconteam = "allies";
		}

		self.headicon = game["headicon_axis"];
		self.headiconteam = "axis";
	}
}

//Function Number: 6
func_86EC()
{
	var_00 = maps\mp\_utility::func_3ADD("scr_drawfriend",level.drawfriend);
	if(level.drawfriend != var_00)
	{
		level.drawfriend = var_00;
		func_86EB();
	}
}

//Function Number: 7
func_86EB()
{
	var_00 = level.players;
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		if(isdefined(var_02.pers["team"]) && var_02.pers["team"] != "spectator" && var_02.sessionstate == "playing")
		{
			if(level.drawfriend)
			{
				if(var_02.pers["team"] == "allies")
				{
					var_02.headicon = game["headicon_allies"];
					var_02.headiconteam = "allies";
				}
				else
				{
					var_02.headicon = game["headicon_axis"];
					var_02.headiconteam = "axis";
				}

				continue;
			}

			var_00 = level.players;
			for(var_01 = 0;var_01 < var_00.size;var_01++)
			{
				var_02 = var_00[var_01];
				if(isdefined(var_02.pers["team"]) && var_02.pers["team"] != "spectator" && var_02.sessionstate == "playing")
				{
					var_02.headicon = "";
				}
			}
		}
	}
}