/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_war.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 78 ms
 * Timestamp: 10/27/2023 1:41:09 AM
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
	for(;;)
	{
		self [[ self.personality_update_function ]]();
		wait(0.05);
	}
}