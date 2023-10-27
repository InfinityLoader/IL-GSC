/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_agents_gametype_dom.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 84 ms
 * Timestamp: 10/27/2023 1:16:50 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	func_710C();
}

//Function Number: 2
func_710C()
{
	level.agent_funcs["squadmate"]["gametype_update"] = ::func_8F42;
	level.agent_funcs["player"]["think"] = ::agent_player_dom_think;
}

//Function Number: 3
agent_player_dom_think()
{
	thread maps/mp/bots/_bots_gametype_dom::func_8FE6();
}

//Function Number: 4
func_8F42()
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
		var_04 = var_00 maps/mp/gametypes/dom::func_3AAB();
		if(var_04 != self.team)
		{
			if(!maps/mp/bots/_bots_gametype_dom::func_8FF8(var_00))
			{
				maps/mp/bots/_bots_gametype_dom::func_9053(var_00,"critical",1);
			}

			return 1;
		}
	}

	return 0;
}