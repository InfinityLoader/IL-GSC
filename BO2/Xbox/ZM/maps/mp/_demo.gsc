/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_demo.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:14:23 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.bookmark["kill"] = 0;
	level.bookmark["event"] = 1;
	level.bookmark["zm_round_end"] = 2;
	level.bookmark["zm_player_downed"] = 3;
	level.bookmark["zm_player_revived"] = 4;
	level.bookmark["zm_player_bledout"] = 5;
	level.bookmark["zm_player_use_magicbox"] = 6;
	level.bookmark["score_event"] = 7;
	level.bookmark["medal"] = 8;
	level.bookmark["round_result"] = 9;
	level.bookmark["game_result"] = 10;
	level.bookmark["zm_powerup_dropped"] = 11;
	level.bookmark["zm_player_powerup_grabbed"] = 12;
	level.bookmark["zm_player_perk"] = 13;
	level.bookmark["zm_power"] = 14;
	level.bookmark["zm_player_door"] = 15;
	level.bookmark["zm_player_buildable_placed"] = 16;
	level.bookmark["zm_player_use_packapunch"] = 17;
	level.bookmark["zm_player_rampage"] = 18;
	level.bookmark["zm_player_grenade_special"] = 19;
	level.bookmark["zm_player_grenade_multiattack"] = 20;
	level.bookmark["zm_player_meat_stink"] = 21;
	level.bookmark["zm_player_grabbed_magicbox"] = 22;
	level.bookmark["zm_player_grabbed_packapunch"] = 23;
	level.bookmark["zm_player_grenade_special_long"] = 24;
}

//Function Number: 2
bookmark(type,time,clientent1,clientent2,eventpriority,inflictorent,overrideentitycamera,actorent)
{
/#
	assert(IsDefined(level.bookmark[type]),"Unable to find a bookmark type for type - " + type);
#/
	client1 = 255;
	client2 = 255;
	inflictorentnum = -1;
	inflictorenttype = 0;
	inflictorbirthtime = 0;
	actorentnum = undefined;
	scoreeventpriority = 0;
	if(IsDefined(clientent1))
	{
		client1 = clientent1 getentitynumber();
	}

	if(IsDefined(clientent2))
	{
		client2 = clientent2 getentitynumber();
	}

	if(IsDefined(eventpriority))
	{
		scoreeventpriority = eventpriority;
	}

	if(IsDefined(inflictorent))
	{
		inflictorentnum = inflictorent getentitynumber();
		inflictorenttype = inflictorent getentitytype();
		if(IsDefined(inflictorent.birthtime))
		{
			inflictorbirthtime = inflictorent.birthtime;
		}
	}

	if(!(IsDefined(overrideentitycamera)))
	{
		overrideentitycamera = 0;
	}

	if(IsDefined(actorent))
	{
		actorentnum = actorent getentitynumber();
	}

	adddemobookmark(level.bookmark[type],time,client1,client2,scoreeventpriority,inflictorentnum,inflictorenttype,inflictorbirthtime,overrideentitycamera,actorentnum);
}

//Function Number: 3
gameresultbookmark(type,winningteamindex,losingteamindex)
{
/#
	assert(IsDefined(level.bookmark[type]),"Unable to find a bookmark type for type - " + type);
#/
	client1 = 255;
	client2 = 255;
	scoreeventpriority = 0;
	inflictorentnum = -1;
	inflictorenttype = 0;
	inflictorbirthtime = 0;
	overrideentitycamera = 0;
	actorentnum = undefined;
	if(IsDefined(winningteamindex))
	{
		client1 = winningteamindex;
	}

	if(IsDefined(losingteamindex))
	{
		client2 = losingteamindex;
	}

	adddemobookmark(level.bookmark[type],GetTime(),client1,client2,scoreeventpriority,inflictorentnum,inflictorenttype,inflictorbirthtime,overrideentitycamera,actorentnum);
}