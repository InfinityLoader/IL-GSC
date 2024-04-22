/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\_agents_gametype_dom.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 83 ms
 * Timestamp: 4/22/2024 2:08:19 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_callbacks();
}

//Function Number: 2
setup_callbacks()
{
	level.agent_funcs["squadmate"]["gametype_update"] = ::agent_squadmember_dom_think;
	level.agent_funcs["player"]["think"] = ::agent_player_dom_think;
}

//Function Number: 3
agent_player_dom_think()
{
	thread maps\mp\bots\_bots_gametype_dom::bot_dom_think();
}

//Function Number: 4
agent_squadmember_dom_think()
{
	var_00 = undefined;
	foreach(var_02 in self.owner.touchtriggers)
	{
		if(var_02.useobj.id == "domFlag")
		{
			var_00 = var_02;
		}
	}

	if(isdefined(var_00))
	{
		var_04 = var_00 maps\mp\gametypes\dom::getflagteam();
		if(var_04 != self.team)
		{
			if(!maps\mp\bots\_bots_gametype_dom::bot_is_capturing_flag(var_00))
			{
				maps\mp\bots\_bots_gametype_dom::capture_flag(var_00,"critical",1);
			}

			return 1;
		}
	}

	return 0;
}