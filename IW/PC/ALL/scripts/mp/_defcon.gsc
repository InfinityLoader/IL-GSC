/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_defcon.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 263 ms
 * Timestamp: 10/27/2023 12:15:06 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(level.var_5056) || level.var_5056 == 0)
	{
		return;
	}

	if(!isdefined(game["defcon"]))
	{
		game["defcon"] = 4;
	}

	setdvar("scr_defcon",game["defcon"]);
	level.var_5059[5] = 0;
	level.var_5059[4] = 0;
	level.var_5059[3] = -1;
	level.var_5059[2] = -1;
	level.var_5059[1] = -1;
	level.var_5057[5] = 1;
	level.var_5057[4] = 1;
	level.var_5057[3] = 1;
	level.var_5057[2] = 1;
	level.var_5057[1] = 2;
	func_12E87(game["defcon"]);
	thread func_5054();
}

//Function Number: 2
func_5055(param_00)
{
	for(;;)
	{
		level waittill("player_got_killstreak_" + param_00,var_01);
		level notify("defcon_killstreak",param_00,var_01);
	}
}

//Function Number: 3
func_5054()
{
	level endon("game_ended");
	var_00 = 10;
	level thread func_5055(var_00);
	level thread func_5055(var_00 - 1);
	level thread func_5055(var_00 - 2);
	level thread func_5055(var_00 * 2);
	level thread func_5055(var_00 * 2 - 1);
	level thread func_5055(var_00 * 2 - 2);
	level thread func_5055(var_00 * 3);
	level thread func_5055(var_00 * 3 - 1);
	level thread func_5055(var_00 * 3 - 2);
	for(;;)
	{
		level waittill("defcon_killstreak",var_01,var_02);
		if(game["defcon"] <= 1)
		{
			continue;
		}

		if(var_01 % var_00 == var_00 - 2)
		{
			foreach(var_04 in level.players)
			{
				if(!isalive(var_04))
				{
					continue;
				}

				var_04 thread scripts\mp\_hud_message::func_10151("two_from_defcon",undefined,var_02);
			}

			continue;
		}

		if(var_01 % var_00 == var_00 - 1)
		{
			foreach(var_04 in level.players)
			{
				if(!isalive(var_04))
				{
					continue;
				}

				var_04 thread scripts\mp\_hud_message::func_10151("one_from_defcon",undefined,var_02);
			}

			continue;
		}

		func_12E87(game["defcon"] - 1,var_02,var_01);
	}
}

//Function Number: 4
func_12E87(param_00,param_01,param_02)
{
	param_00 = int(param_00);
	var_03 = game["defcon"];
	game["defcon"] = param_00;
	level.var_C2A7 = level.var_5057[param_00];
	setdvar("scr_defcon",game["defcon"]);
	if(isdefined(param_01))
	{
		param_01 notify("changed_defcon");
	}

	if(param_00 == var_03)
	{
		return;
	}

	if(game["defcon"] == 3 && isdefined(param_01))
	{
		param_01 scripts\mp\killstreaks\_killstreaks::func_8374("airdrop_mega");
		param_01 thread scripts\mp\_hud_message::func_10151("caused_defcon",param_02);
	}

	foreach(var_05 in level.players)
	{
		if(isalive(var_05))
		{
			if(isdefined(param_01))
			{
				var_05 thread scripts\mp\_hud_message::func_10151("changed_defcon",undefined,param_01);
			}
		}
	}
}