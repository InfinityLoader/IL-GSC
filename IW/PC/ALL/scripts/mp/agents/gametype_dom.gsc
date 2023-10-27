/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\gametype_dom.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 234 ms
 * Timestamp: 10/27/2023 12:11:33 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_F8F4();
}

//Function Number: 2
func_F8F4()
{
	level.agent_funcs["squadmate"]["gametype_update"] = ::func_18FC;
	level.agent_funcs["player"]["think"] = ::func_18F6;
}

//Function Number: 3
func_18F6()
{
	thread scripts\mp\bots\gametype_dom::func_2D64();
}

//Function Number: 4
func_18FC()
{
	var_00 = undefined;
	foreach(var_02 in self.var_222.var_11A46)
	{
		if(var_02.var_130AC.var_92B8 == "domFlag")
		{
			var_00 = var_02;
		}
	}

	if(isdefined(var_00))
	{
		var_04 = var_00 scripts\mp\gametypes\dom::func_7EBB();
		if(var_04 != self.team)
		{
			if(!scripts\mp\bots\gametype_dom::func_2DD6(var_00))
			{
				scripts\mp\bots\gametype_dom::func_3A37(var_00,"critical",1);
			}

			return 1;
		}
	}

	return 0;
}