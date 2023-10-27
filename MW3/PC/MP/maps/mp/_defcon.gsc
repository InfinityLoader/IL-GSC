/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_defcon.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 79 ms
 * Timestamp: 10/27/2023 2:14:56 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(level.defconmode) || level.defconmode == 0)
	{
		return;
	}

	if(!isdefined(game["defcon"]))
	{
		game["defcon"] = 4;
	}

	makedvarserverinfo("scr_defcon",game["defcon"]);
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
	updatedefcon(game["defcon"]);
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

				var_04 thread maps\mp\gametypes\_hud_message::playercardsplashnotify("two_from_defcon",var_02);
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

				var_04 thread maps\mp\gametypes\_hud_message::playercardsplashnotify("one_from_defcon",var_02);
			}

			continue;
		}

		updatedefcon(game["defcon"] - 1,var_02,var_01);
	}
}

//Function Number: 4
updatedefcon(param_00,param_01,param_02)
{
	param_00 = int(param_00);
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
		return;
	}

	if(game["defcon"] == 3 && isdefined(param_01))
	{
		param_01 maps\mp\killstreaks\_killstreaks::givekillstreak("airdrop_mega");
		param_01 thread maps\mp\gametypes\_hud_message::splashnotify("caused_defcon",param_02);
	}

	foreach(var_05 in level.players)
	{
		if(isalive(var_05))
		{
			var_05 thread maps\mp\gametypes\_hud_message::defconsplashnotify(game["defcon"],param_00 < var_03);
			if(isdefined(param_01))
			{
				var_05 thread maps\mp\gametypes\_hud_message::playercardsplashnotify("changed_defcon",param_01);
			}
		}
	}
}