/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_grnd.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 92 ms
 * Timestamp: 10/27/2023 1:17:17 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	func_710C();
	setup_bot_grnd();
}

//Function Number: 2
func_710C()
{
	level.bot_funcs["gametype_think"] = ::bot_grnd_think;
}

//Function Number: 3
setup_bot_grnd()
{
	maps/mp/bots/_bots_util::func_16C4(1);
	level.protect_radius = 128;
	level.bot_gametype_precaching_done = 1;
}

//Function Number: 4
bot_grnd_think()
{
	self notify("bot_grnd_think");
	self endon("bot_grnd_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!isdefined(level.bot_gametype_precaching_done))
	{
		wait(0.05);
	}

	self botsetflag("separation",0);
	for(;;)
	{
		wait(0.05);
		if(maps/mp/bots/_bots_strategy::bot_has_tactical_goal())
		{
			continue;
		}

		if(!self bothasscriptgoal())
		{
			self botsetscriptgoal(level.grnd_zone.origin,0,"objective");
			continue;
		}

		if(!maps/mp/bots/_bots_util::bot_is_defending())
		{
			self botclearscriptgoal();
			maps/mp/bots/_bots_strategy::bot_protect_point(level.grnd_zone.origin,level.protect_radius);
		}
	}
}