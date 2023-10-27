/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_war.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 60 ms
 * Timestamp: 10/27/2023 2:37:24 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_callbacks();
	setup_bot_war();
}

//Function Number: 2
setup_callbacks()
{
	level.bot_funcs["gametype_think"] = ::bot_war_think;
}

//Function Number: 3
setup_bot_war()
{
}

//Function Number: 4
bot_war_think()
{
	self notify("bot_war_think");
	self endon("bot_war_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("owner_disconnect");
	if(isdefined(level.bot_ignore_personality))
	{
		return;
	}

	for(;;)
	{
		self [[ self.personality_update_function ]]();
		wait(0.05);
	}
}