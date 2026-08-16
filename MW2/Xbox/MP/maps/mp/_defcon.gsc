/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_defcon.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

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

	makedvarserverinfo("scr_defcon", game["defcon"]);
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

defconkillstreakwait(streakcount)
{
	for(;;)
	{
		level waittill("player_got_killstreak_" + streakcount, player);
		level notify("defcon_killstreak", streakcount, player);
	}
}

defconkillstreakthread()
{
	level endon("game_ended");
	requiredkillcount = 10;
	level thread defconkillstreakwait(requiredkillcount);
	level thread defconkillstreakwait(requiredkillcount - 1);
	level thread defconkillstreakwait(requiredkillcount - 2);
	level thread defconkillstreakwait(requiredkillcount * 2);
	level thread defconkillstreakwait(requiredkillcount * 2 - 1);
	level thread defconkillstreakwait(requiredkillcount * 2 - 2);
	level thread defconkillstreakwait(requiredkillcount * 3);
	level thread defconkillstreakwait(requiredkillcount * 3 - 1);
	level thread defconkillstreakwait(requiredkillcount * 3 - 2);
	for(;;)
	{
		level waittill("defcon_killstreak", streakcount, changingplayer);
		if(game["defcon"] <= 1)
		{
			continue;
		}

		if(streakcount % requiredkillcount == requiredkillcount - 2)
		{
			foreach(player in level.players)
			{
				if(!isalive(player))
				{
					continue;
				}

				player thread maps\mp\gametypes\_hud_message::playercardsplashnotify("two_from_defcon", changingplayer);
			}

			continue;
		}

		if(streakcount % requiredkillcount == requiredkillcount - 1)
		{
			foreach(player in level.players)
			{
				if(!isalive(player))
				{
					continue;
				}

				player thread maps\mp\gametypes\_hud_message::playercardsplashnotify("one_from_defcon", changingplayer);
			}

			continue;
		}

		updatedefcon(game["defcon"] - 1, changingplayer, streakcount);
	}
}

updatedefcon(param_C07, changingplayer, streakcount)
{
	param_C07 = int(param_C07);
	olddefcon = game["defcon"];
	game["defcon"] = param_C07;
	level.objectivepointsmod = level.defconpointmod[param_C07];
	setdvar("scr_defcon", game["defcon"]);
	if(isdefined(changingplayer))
	{
		changingplayer notify("changed_defcon");
	}

	if(param_C07 == olddefcon)
	{
		return;
	}

	if(game["defcon"] == 3 && isdefined(changingplayer))
	{
		changingplayer maps\mp\killstreaks\_killstreaks::givekillstreak("airdrop_mega");
		changingplayer thread maps\mp\gametypes\_hud_message::splashnotify("caused_defcon", streakcount);
	}

	foreach(player in level.players)
	{
		if(isalive(player))
		{
			player thread maps\mp\gametypes\_hud_message::defconsplashnotify(game["defcon"], param_C07 < olddefcon);
			if(isdefined(changingplayer))
			{
				player thread maps\mp\gametypes\_hud_message::playercardsplashnotify("changed_defcon", changingplayer);
			}
		}
	}
}