/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bot_ctf.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 12
 * Decompile Time: 9 ms
 * Timestamp: 10/28/2023 12:13:31 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/bots/_bot;
#include maps/mp/bots/_bot_combat;
#include maps/mp/gametypes/_gameobjects;
#include maps/mp/gametypes/ctf;

//Function Number: 1
bot_ctf_think()
{
	time = GetTime();
	if(time < self.bot.update_objective)
	{
		return;
	}

	self.bot.update_objective = time + randomintrange(500,1500);
	if(maps/mp/bots/_bot::bot_get_difficulty() != "easy")
	{
		flag_mine = ctf_get_flag(self.team);
		if(flag_mine ishome() && distancesquared(self.origin,flag_mine.curorigin) < 262144)
		{
			nodes = getnodesinradius(flag_mine.curorigin,256,0,64,"any",8);
			node = random(nodes);
			if(cointoss())
			{
			}
			else
			{
			}

			self maps/mp/bots/_bot_combat::bot_combat_throw_proximity(node.origin);
			if(cointoss())
			{
			}
			else
			{
			}

			self maps/mp/bots/_bot_combat::bot_combat_toss_frag(node.origin);
			if(cointoss())
			{
			}
			else
			{
			}

			self maps/mp/bots/_bot_combat::bot_combat_toss_flash(node.origin);
		}
	}

	if(bot_should_patrol_flag())
	{
		bot_patrol_flag();
		return;
	}

	self cancelgoal("ctf_flag_patrol");
	if(!(bot_ctf_defend()))
	{
		bot_ctf_capture();
	}

	flag_mine = ctf_get_flag(self.team);
	flag_enemy = ctf_get_flag(getotherteam(self.team));
	home_mine = flag_mine ctf_flag_get_home();
	if(ctf_has_flag(flag_enemy) && self issprinting() && distancesquared(self.origin,home_mine) < 36864)
	{
		if(bot_dot_product(home_mine) > 0.9)
		{
			self bot_dive_to_prone("stand");
		}
	}
	else if(!flag_mine ishome() && !IsDefined(flag_mine.carrier))
	{
		if(self issprinting() && distancesquared(self.origin,flag_mine.curorigin) < 36864)
		{
			if(bot_dot_product(flag_mine.curorigin) > 0.9)
			{
				self bot_dive_to_prone("stand");
			}
		}
	}
}

//Function Number: 2
bot_should_patrol_flag()
{
	flag_mine = ctf_get_flag(self.team);
	flag_enemy = ctf_get_flag(getotherteam(self.team));
	home_mine = flag_mine ctf_flag_get_home();
	if(self hasgoal("ctf_flag") && !self atgoal("ctf_flag"))
	{
		return 0;
	}

	if(ctf_has_flag(flag_enemy))
	{
		if(!(flag_mine ishome()))
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}

	if(!(flag_mine ishome()))
	{
		return 0;
	}

	if(distancesquared(self.origin,flag_enemy.curorigin) < 262144)
	{
		return 0;
	}

	if(bot_get_friends().size && self maps/mp/bots/_bot::bot_friend_goal_in_radius("ctf_flag_patrol",home_mine,1024) == 0)
	{
		return 1;
	}
}

//Function Number: 3
ctf_get_flag(team)
{
	foreach(f in level.flags)
	{
		if(f maps/mp/gametypes/_gameobjects::getownerteam() == team)
		{
			return f;
		}
	}

	return undefined;
}

//Function Number: 4
ctf_flag_get_home()
{
	return self.trigger.baseorigin;
}

//Function Number: 5
ctf_has_flag(flag)
{
	return IsDefined(flag.carrier) && flag.carrier == self;
}

//Function Number: 6
bot_ctf_capture()
{
	flag_enemy = ctf_get_flag(getotherteam(self.team));
	flag_mine = ctf_get_flag(self.team);
	home_enemy = flag_enemy ctf_flag_get_home();
	home_mine = flag_mine ctf_flag_get_home();
	if(ctf_has_flag(flag_enemy))
	{
		self addgoal(home_mine,16,4,"ctf_flag");
	}
	else if(IsDefined(flag_enemy.carrier))
	{
		if(self atgoal("ctf_flag"))
		{
			self cancelgoal("ctf_flag");
		}

		goal = self getgoal("ctf_flag");
		if(IsDefined(goal) && distancesquared(goal,flag_enemy.carrier.origin) < 589824)
		{
			return;
		}

		nodes = getnodesinradius(flag_enemy.carrier.origin,512,64,256,"any",8);
		if(nodes.size)
		{
			self addgoal(random(nodes),16,3,"ctf_flag");
		}
		else
		{
			self addgoal(flag_enemy.carrier.origin,16,3,"ctf_flag");
		}
	}
	else if(self maps/mp/bots/_bot::bot_friend_goal_in_radius("ctf_flag",flag_enemy.curorigin,16) <= 1)
	{
		self addgoal(flag_enemy.curorigin,16,3,"ctf_flag");
	}
}

//Function Number: 7
bot_ctf_defend()
{
	flag_enemy = ctf_get_flag(getotherteam(self.team));
	flag_mine = ctf_get_flag(self.team);
	home_enemy = flag_enemy ctf_flag_get_home();
	home_mine = flag_mine ctf_flag_get_home();
	if(flag_mine ishome())
	{
		return 0;
	}

	if(ctf_has_flag(flag_enemy))
	{
		return 0;
	}

	if(!(IsDefined(flag_mine.carrier)))
	{
		if(self maps/mp/bots/_bot::bot_friend_goal_in_radius("ctf_flag",flag_mine.curorigin,16) <= 1)
		{
			return self bot_ctf_add_goal(flag_mine.curorigin,4,"ctf_flag");
		}
	}
	else if(!flag_enemy ishome() || distance2dsquared(self.origin,home_enemy) > 250000)
	{
		return self bot_ctf_add_goal(flag_mine.curorigin,4,"ctf_flag");
	}
	else if(self maps/mp/bots/_bot::bot_friend_goal_in_radius("ctf_flag",home_enemy,16) <= 1)
	{
		self addgoal(home_enemy,16,4,"ctf_flag");
	}

	return 1;
}

//Function Number: 8
bot_ctf_add_goal(origin,goal_priority,goal_name)
{
	goal = undefined;
	if(findpath(self.origin,origin,undefined,0,1))
	{
		goal = origin;
	}
	else
	{
		node = bot_ctf_random_visible_node(origin);
		if(IsDefined(node))
		{
			if(findpath(self.origin,node.origin,undefined,0,1))
			{
				goal = node;
				self.bot.update_objective = self.bot.update_objective + randomintrange(3000,5000);
			}
		}
	}

	if(IsDefined(goal))
	{
		self addgoal(goal,16,goal_priority,goal_name);
		return 1;
	}
}

//Function Number: 9
bot_get_look_at()
{
	enemy = self maps/mp/bots/_bot::bot_get_closest_enemy(self.origin,1);
	if(IsDefined(enemy))
	{
		node = getvisiblenode(self.origin,enemy.origin);
		if(IsDefined(node) && distancesquared(self.origin,node.origin) > 16384)
		{
			return node.origin;
		}
	}

	enemies = self maps/mp/bots/_bot::bot_get_enemies(0);
	if(enemies.size)
	{
		enemy = random(enemies);
	}

	if(IsDefined(enemy))
	{
		node = getvisiblenode(self.origin,enemy.origin);
		if(IsDefined(node) && distancesquared(self.origin,node.origin) > 16384)
		{
			return node.origin;
		}
	}

	flag_mine = ctf_get_flag(self.team);
	home_mine = flag_mine ctf_flag_get_home();
	return home_mine;
}

//Function Number: 10
bot_patrol_flag()
{
	self cancelgoal("ctf_flag");
	flag_mine = ctf_get_flag(self.team);
	if(self atgoal("ctf_flag_patrol"))
	{
		node = getnearestnode(self.origin);
		if(!(IsDefined(node)))
		{
			self clearlookat();
			self cancelgoal("ctf_flag_patrol");
			return;
		}

		if(node.type == "Path")
		{
			self setstance("crouch");
		}
		else
		{
			self setstance("stand");
		}

		if(GetTime() > self.bot.update_lookat)
		{
			origin = self bot_get_look_at();
			z = 20;
			if(distancesquared(origin,self.origin) > 262144)
			{
				z = randomintrange(16,60);
			}

			self lookat(origin + (0,0,z));
			if(distancesquared(origin,self.origin) > 65536)
			{
				dir = vectornormalize(self.origin - origin);
				dir = VectorScale(dir);
				origin = origin + dir;
			}

			self maps/mp/bots/_bot_combat::bot_combat_throw_proximity(origin);
			self.bot.update_lookat = GetTime() + randomintrange(1500,3000);
		}

		goal = self getgoal("ctf_flag_patrol");
		nearest = base_nearest_node(flag_mine);
		mine = getnearestnode(goal);
		if(IsDefined(mine) && !nodesvisible(mine,nearest))
		{
			self clearlookat();
			self cancelgoal("ctf_flag_patrol");
		}

		if(GetTime() > self.bot.update_objective_patrol)
		{
			self clearlookat();
			self cancelgoal("ctf_flag_patrol");
		}

		return;
	}

	nearest = base_nearest_node(flag_mine);
	if(self hasgoal("ctf_flag_patrol"))
	{
		goal = self getgoal("ctf_flag_patrol");
		if(distancesquared(self.origin,goal) < 65536)
		{
			origin = self bot_get_look_at();
			self lookat(origin);
		}

		if(distancesquared(self.origin,goal) < 16384)
		{
			self.bot.update_objective_patrol = GetTime() + randomintrange(3000,6000);
		}

		mine = getnearestnode(goal);
		if(IsDefined(mine) && !nodesvisible(mine,nearest))
		{
			self clearlookat();
			self cancelgoal("ctf_flag_patrol");
		}

		return;
	}

	if(GetTime() < self.bot.update_objective_patrol)
	{
		return;
	}

	nodes = getvisiblenodes(nearest);
/#
	assert(nodes.size);
#/
	for(i = randomint(nodes.size);i < nodes.size;i++)
	{
		if(self maps/mp/bots/_bot::bot_friend_goal_in_radius("ctf_flag_patrol",nodes[i].origin,256) == 0)
		{
			self addgoal(nodes[i],24,3,"ctf_flag_patrol");
			self.bot.update_objective_patrol = GetTime() + randomintrange(3000,6000);
			return;
		}
	}
}

//Function Number: 11
base_nearest_node(flag)
{
	home = flag ctf_flag_get_home();
	nodes = getnodesinradiussorted(home,256,0);
/#
	assert(nodes.size);
#/
	return nodes[0];
}

//Function Number: 12
bot_ctf_random_visible_node(origin)
{
	nodes = getnodesinradius(origin,384,0,256);
	nearest = maps/mp/bots/_bot_combat::bot_nearest_node(origin);
	if(IsDefined(nearest) && nodes.size)
	{
		current = randomintrange(0,nodes.size);
		for(i = 0;i < nodes.size;i++)
		{
			current = current + 1 % nodes.size;
			if(nodesvisible(nodes[current],nearest))
			{
				return nodes[current];
			}
		}
	}

	return undefined;
}