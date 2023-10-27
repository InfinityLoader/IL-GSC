/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_agents_gametype_conf.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 78 ms
 * Timestamp: 10/27/2023 1:16:48 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	func_710C();
}

//Function Number: 2
func_710C()
{
	level.agent_funcs["squadmate"]["gametype_update"] = ::func_8F41;
	level.agent_funcs["player"]["think"] = ::func_8F3D;
}

//Function Number: 3
func_8F3D()
{
	thread maps/mp/bots/_bots_gametype_conf::func_8FDE();
}

//Function Number: 4
func_8F41()
{
	if(!isdefined(self.tags_seen_by_owner))
	{
		self.tags_seen_by_owner = [];
	}

	if(!isdefined(self.next_time_check_tags))
	{
		self.next_time_check_tags = gettime() + 500;
	}

	if(gettime() > self.next_time_check_tags)
	{
		self.next_time_check_tags = gettime() + 500;
		var_00 = 0.78;
		var_01 = self.owner getnearestnode();
		if(isdefined(var_01))
		{
			var_02 = self.owner maps/mp/bots/_bots_gametype_conf::func_8FEB(1,var_01,var_00);
			self.tags_seen_by_owner = maps/mp/bots/_bots_gametype_conf::func_8FDD(var_02,self.tags_seen_by_owner);
		}
	}

	self.tags_seen_by_owner = maps/mp/bots/_bots_gametype_conf::func_9008(self.tags_seen_by_owner);
	var_03 = maps/mp/bots/_bots_gametype_conf::func_8FE9(self.tags_seen_by_owner,0);
	if(isdefined(var_03))
	{
		if(!isdefined(self.tag_getting) || distancesquared(var_03.curorigin,self.tag_getting.curorigin) > 1)
		{
			self.tag_getting = var_03;
			maps/mp/bots/_bots_strategy::bot_defend_stop();
			self botsetscriptgoal(self.tag_getting.curorigin,0,"objective",undefined,level.bot_tag_obj_radius);
		}

		return 1;
	}
	else if(isdefined(self.tag_getting))
	{
		self botclearscriptgoal();
		self.tag_getting = undefined;
	}

	return 0;
}