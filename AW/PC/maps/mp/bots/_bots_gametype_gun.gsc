/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\bots\_bots_gametype_gun.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 80 ms
 * Timestamp: 4/22/2024 2:08:40 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_callbacks();
	setup_bot_gun();
}

//Function Number: 2
setup_callbacks()
{
	level.bot_funcs["gametype_think"] = ::bot_gun_think;
}

//Function Number: 3
setup_bot_gun()
{
}

//Function Number: 4
bot_gun_think()
{
	self notify("bot_gun_think");
	self endon("bot_gun_think");
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