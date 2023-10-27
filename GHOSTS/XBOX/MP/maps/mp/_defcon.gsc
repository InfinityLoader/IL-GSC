/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_defcon.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 4
 * Decompile Time: 72 ms
 * Timestamp: 10/27/2023 1:29:48 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	if(!isdefined(level.defconmode) || level.defconmode == 0)
	{
		return;
	}

	if(!isdefined(game["defcon"]))
	{
		game["defcon"] = 4;
	}

	setdvar("scr_defcon",game["defcon"]);
	level.defconstreakadd[5] = 0;
	level.defconstreakadd[4] = 0;
	level.defconstreakadd[3] = -1;
	level.defconstreakadd[2] = -1;
	level.defconstreakadd[1] = -1;
	level.defconpointmod[5] = 1;
	level.defconpointmod[4] = 1;
	level.defconpointmod[3] = 1;
	level.defconpointmod[2] = 1;
	level.defconpointmod[1] = 2;
	func_86E3(game["defcon"]);
	thread defconkillstreakthread();
}

//Function Number: 2
defconkillstreakwait(param_00)
{
	for(;;)
	{
		level waittill("player_got_killstreak_" + param_00,var_01);
		level notify("defcon_killstreak",param_00,var_01);
	}
}

//Function Number: 3
defconkillstreakthread()
{
	level endon("game_ended");
	var_00 = 10;
	level thread defconkillstreakwait(var_00);
	level thread defconkillstreakwait(var_00 - 1);
	level thread defconkillstreakwait(var_00 - 2);
	level thread defconkillstreakwait(var_00 * 2);
	level thread defconkillstreakwait(var_00 * 2 - 1);
	level thread defconkillstreakwait(var_00 * 2 - 2);
	level thread defconkillstreakwait(var_00 * 3);
	level thread defconkillstreakwait(var_00 * 3 - 1);
	level thread defconkillstreakwait(var_00 * 3 - 2);
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

				var_04 thread maps\mp\gametypes\_hud_message::func_5F9A("two_from_defcon",var_02);
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

				var_04 thread maps\mp\gametypes\_hud_message::func_5F9A("one_from_defcon",var_02);
			}

			continue;
		}

		func_86E3(game["defcon"] - 1,var_02,var_01);
	}
}

//Function Number: 4
func_86E3(param_00,param_01,param_02)
{
	param_00 = castint(param_00);
	var_03 = game["defcon"];
	game["defcon"] = param_00;
	level.objectivepointsmod = level.defconpointmod[param_00];
	setdvar("scr_defcon",game["defcon"]);
	if(isdefined(param_01))
	{
		param_01 notify("changed_defcon");
	}

	if(param_00 == var_03)
	{
	}

	if(game["defcon"] == 3 && isdefined(param_01))
	{
		param_01 maps\mp\killstreaks\_killstreaks::func_3CF2("airdrop_mega");
		param_01 thread maps\mp\gametypes\_hud_message::func_794C("caused_defcon",param_02);
	}

	foreach(var_05 in level.players)
	{
		if(isalive(var_05))
		{
			var_05 thread maps\mp\gametypes\_hud_message::defconsplashnotify(game["defcon"],param_00 < var_03);
			if(isdefined(param_01))
			{
				var_05 thread maps\mp\gametypes\_hud_message::func_5F9A("changed_defcon",param_01);
			}
		}
	}
}