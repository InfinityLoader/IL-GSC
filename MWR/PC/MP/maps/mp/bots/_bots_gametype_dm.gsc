/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_dm.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 69 ms
 * Timestamp: 10/27/2023 2:37:11 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_callbacks();
	setup_bot_dm();
}

//Function Number: 2
setup_callbacks()
{
	level.bot_funcs["gametype_think"] = ::bot_dm_think;
}

//Function Number: 3
setup_bot_dm()
{
}

//Function Number: 4
bot_dm_think()
{
	self notify("bot_dm_think");
	self endon("bot_dm_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("owner_disconnect");
	for(;;)
	{
		self [[ self.personality_update_function ]]();
		wait(0.05);
	}
}