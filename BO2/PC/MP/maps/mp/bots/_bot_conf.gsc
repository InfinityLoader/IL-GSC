/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bot_conf.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 7 ms
 * Timestamp: 10/27/2023 2:59:50 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;

//Function Number: 1
bot_conf_think()
{
	time = GetTime();
	if(time < self.bot.update_objective)
	{
		return;
	}

	self.bot.update_objective = time + randomintrange(500,1500);
	goal = self getgoal("conf_dogtag");
	if(IsDefined(goal))
	{
		if(!(conf_tag_in_radius(goal,64)))
		{
			self cancelgoal("conf_dogtag");
		}
	}

	conf_get_tag_in_sight();
}

//Function Number: 2
conf_get_tag_in_sight()
{
	angles = self getplayerangles();
	forward = AnglesToForward(angles);
	forward = vectornormalize(forward);
	closest = 999999;
	foreach(tag in level.dogtags)
	{
		if(is_true(tag.unreachable))
		{
		}
		else
		{
			distsq = distancesquared(tag.curorigin,self.origin);
			if(distsq > closest)
			{
			}
			else
			{
				delta = tag.curorigin - self.origin;
				delta = vectornormalize(delta);
				dot = vectordot(forward,delta);
				if(dot < self.bot.fov && distsq > 40000)
				{
				}
				else if(dot > self.bot.fov && distsq > 1440000)
				{
				}
				else
				{
					nearest = getnearestnode(tag.curorigin);
					if(!(IsDefined(nearest)))
					{
						tag.unreachable = 1;
					}
					else if(tag.curorigin[2] - nearest.origin[2] > 18)
					{
						tag.unreachable = 1;
					}
					else
					{
						if(!IsDefined(tag.unreachable) && !findpath(self.origin,tag.curorigin,tag,0,1))
						{
							tag.unreachable = 1;
						}
						else
						{
							tag.unreachable = 0;
						}

						closest = distsq;
						closetag = tag;
					}
				}
			}
		}
	}

	if(IsDefined(closetag))
	{
		self addgoal(closetag.curorigin,16,3,"conf_dogtag");
	}
}

//Function Number: 3
conf_tag_in_radius(origin,radius)
{
	foreach(tag in level.dogtags)
	{
		if(distancesquared(origin,tag.curorigin) < radius * radius)
		{
			return 1;
		}
	}

	return 0;
}