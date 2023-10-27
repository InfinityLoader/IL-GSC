/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_friendicons.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 282 ms
 * Timestamp: 10/27/2023 12:20:17 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_5B78 = 0;
	game["headicon_allies"] = scripts\mp\_teams::func_81B0("allies");
	game["headicon_axis"] = scripts\mp\_teams::func_81B0("axis");
	precacheheadicon(game["headicon_allies"]);
	precacheheadicon(game["headicon_axis"]);
	precacheshader("waypoint_revive");
	level thread func_C56E();
	for(;;)
	{
		func_12E97();
		wait(5);
	}
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_C57B();
		var_00 thread func_C577();
	}
}

//Function Number: 3
func_C57B()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread func_10128();
	}
}

//Function Number: 4
func_C577()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("killed_player");
		self.var_16F = "";
	}
}

//Function Number: 5
func_10128()
{
	if(level.var_5B78)
	{
		if(self.pers["team"] == "allies")
		{
			self.var_16F = game["headicon_allies"];
			self.var_170 = "allies";
			return;
		}

		self.var_16F = game["headicon_axis"];
		self.var_170 = "axis";
	}
}

//Function Number: 6
func_12E97()
{
	var_00 = scripts\mp\_utility::func_7F1D("scr_drawfriend",level.var_5B78);
	if(level.var_5B78 != var_00)
	{
		level.var_5B78 = var_00;
		func_12E96();
	}
}

//Function Number: 7
func_12E96()
{
	var_00 = level.players;
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		if(isdefined(var_02.pers["team"]) && var_02.pers["team"] != "spectator" && var_02.sessionstate == "playing")
		{
			if(level.var_5B78)
			{
				if(var_02.pers["team"] == "allies")
				{
					var_02.var_16F = game["headicon_allies"];
					var_02.var_170 = "allies";
				}
				else
				{
					var_02.var_16F = game["headicon_axis"];
					var_02.var_170 = "axis";
				}

				continue;
			}

			var_00 = level.players;
			for(var_01 = 0;var_01 < var_00.size;var_01++)
			{
				var_02 = var_00[var_01];
				if(isdefined(var_02.pers["team"]) && var_02.pers["team"] != "spectator" && var_02.sessionstate == "playing")
				{
					var_02.var_16F = "";
				}
			}
		}
	}
}