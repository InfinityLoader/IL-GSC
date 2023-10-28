/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bot_koth.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 6 ms
 * Timestamp: 10/28/2023 12:10:27 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/bots/_bot;
#include maps/mp/bots/_bot_combat;
#include maps/mp/gametypes/koth;

//Function Number: 1
bot_koth_think()
{
	if(!(IsDefined(level.zone.trig.goal_radius)))
	{
		maxs = level.zone.trig getmaxs();
		maxs = level.zone.trig.origin + maxs;
		level.zone.trig.goal_radius = distance(level.zone.trig.origin,maxs);
/#
		println("distance: " + level.zone.trig.goal_radius);
#/
		ground = bullettrace(level.zone.gameobject.curorigin,1024 - VectorScale((0,0,1)),level.zone.gameobject.curorigin,0);
		level.zone.trig.goal = 8 + VectorScale((0,0,1));
	}

	if(!(bot_has_hill_goal()))
	{
		self bot_move_to_hill();
	}

	if(self bot_is_at_hill())
	{
		self bot_capture_hill();
	}

	bot_hill_tactical_insertion();
	bot_hill_grenade();
}

//Function Number: 2
bot_has_hill_goal()
{
	origin = self getgoal("koth_hill");
	if(IsDefined(origin))
	{
		if(distance2dsquared(level.zone.gameobject.curorigin,origin) < level.zone.trig.goal_radius * level.zone.trig.goal_radius)
		{
			return 1;
		}
	}
}

//Function Number: 3
bot_is_at_hill()
{
	return self atgoal("koth_hill");
}

//Function Number: 4
bot_move_to_hill()
{
	if(GetTime() < self.bot.update_objective + 4000)
	{
		return;
	}

	self clearlookat();
	self cancelgoal("koth_hill");
	if(self getstance() == "prone")
	{
		self setstance("crouch");
		wait(0.25);
	}

	if(self getstance() == "crouch")
	{
		self setstance("stand");
		wait(0.25);
	}

	nodes = getnodesinradiussorted(level.zone.trig.goal,level.zone.trig.goal_radius,0,128);
	foreach(node in nodes)
	{
		if(self maps/mp/bots/_bot::bot_friend_goal_in_radius("koth_hill",node.origin,64) == 0)
		{
			if(findpath(self.origin,node.origin,self,0,1))
			{
				self addgoal(node,24,3,"koth_hill");
				self.bot.update_objective = GetTime();
				return;
			}
		}
	}
}

//Function Number: 5
bot_get_look_at()
{
	enemy = self maps/mp/bots/_bot::bot_get_closest_enemy(self.origin,1);
	if(IsDefined(enemy))
	{
		node = getvisiblenode(self.origin,enemy.origin);
		if(IsDefined(node) && distancesquared(self.origin,node.origin) > 1024)
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
		if(IsDefined(node) && distancesquared(self.origin,node.origin) > 1024)
		{
			return node.origin;
		}
	}

	spawn = random(level.spawnpoints);
	node = getvisiblenode(self.origin,spawn.origin);
	if(IsDefined(node) && distancesquared(self.origin,node.origin) > 1024)
	{
		return node.origin;
	}

	return level.zone.gameobject.curorigin;
}

//Function Number: 6
bot_capture_hill()
{
	self addgoal(self.origin,24,3,"koth_hill");
	self setstance("crouch");
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
		if(cointoss() && lengthsquared(self getvelocity()) < 2)
		{
			nodes = getnodesinradius(level.zone.trig.goal,level.zone.trig.goal_radius + 128,0,128);
			for(i = randomintrange(0,nodes.size);i < nodes.size;i++)
			{
				node = nodes[i];
				if(distancesquared(node.origin,self.origin) > 1024)
				{
					if(self maps/mp/bots/_bot::bot_friend_goal_in_radius("koth_hill",node.origin,128) == 0)
					{
						if(findpath(self.origin,node.origin,self,0,1))
						{
							self addgoal(node,24,3,"koth_hill");
							self.bot.update_objective = GetTime();
							break;
						}
					}
				}
			}
		}

		self.bot.update_lookat = GetTime() + randomintrange(1500,3000);
	}
}

//Function Number: 7
any_other_team_touching(skip_team)
{
	foreach(team in level.teams)
	{
		if(team == skip_team)
		{
		}
		else if(level.zone.gameobject.numtouching[team])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 8
is_hill_contested(skip_team)
{
	if(any_other_team_touching(skip_team))
	{
		return 1;
	}

	enemy = self maps/mp/bots/_bot::bot_get_closest_enemy(level.zone.gameobject.curorigin,1);
	if(IsDefined(enemy) && distancesquared(enemy.origin,level.zone.gameobject.curorigin) < 262144)
	{
		return 1;
	}

	return 0;
}

//Function Number: 9
bot_hill_grenade()
{
	enemies = bot_get_enemies();
	if(!(enemies.size))
	{
		return;
	}

	if(self atgoal("hill_patrol") || self atgoal("koth_hill"))
	{
		if(self getweaponammostock("proximity_grenade_mp") > 0)
		{
			origin = bot_get_look_at();
			if(self maps/mp/bots/_bot_combat::bot_combat_throw_proximity(origin))
			{
				return;
			}
		}
	}

	if(!(is_hill_contested(self.team)))
	{
		if(!(IsDefined(level.next_smoke_time)))
		{
			level.next_smoke_time = 0;
		}

		if(GetTime() > level.next_smoke_time)
		{
			if(self maps/mp/bots/_bot_combat::bot_combat_throw_smoke(level.zone.gameobject.curorigin))
			{
				level.next_smoke_time = GetTime() + randomintrange(60000,120000);
			}
		}

		return;
	}

	enemy = self maps/mp/bots/_bot::bot_get_closest_enemy(level.zone.gameobject.curorigin,0);
	if(IsDefined(enemy))
	{
		origin = enemy.origin;
	}
	else
	{
		origin = level.zone.gameobject.curorigin;
	}

	dir = vectornormalize(self.origin - origin);
	dir = (0,dir[1],0);
	origin = 128 + VectorScale(dir);
	if(maps/mp/bots/_bot::bot_get_difficulty() == "easy")
	{
		if(!(IsDefined(level.next_grenade_time)))
		{
			level.next_grenade_time = 0;
		}

		if(GetTime() > level.next_grenade_time)
		{
			if(!(self maps/mp/bots/_bot_combat::bot_combat_throw_lethal(origin)))
			{
				self maps/mp/bots/_bot_combat::bot_combat_throw_tactical(origin);
			}
			else
			{
				level.next_grenade_time = GetTime() + randomintrange(60000,120000);
			}
		}
	}
	else if(!(self maps/mp/bots/_bot_combat::bot_combat_throw_lethal(origin)))
	{
		self maps/mp/bots/_bot_combat::bot_combat_throw_tactical(origin);
	}
}

//Function Number: 10
bot_hill_tactical_insertion()
{
	if(!(self hasweapon("tactical_insertion_mp")))
	{
		return;
	}

	dist = self getlookaheaddist();
	dir = self getlookaheaddir();
	if(!IsDefined(dist) || !IsDefined(dir))
	{
		return;
	}

	node = hill_nearest_node();
	mine = getnearestnode(self.origin);
	if(IsDefined(mine) && !nodesvisible(mine,node))
	{
		origin = dist + VectorScale(dir);
		next = getnearestnode(origin);
		if(IsDefined(next) && nodesvisible(next,node))
		{
			bot_combat_tactical_insertion(self.origin);
		}
	}
}

//Function Number: 11
hill_nearest_node()
{
	nodes = getnodesinradiussorted(level.zone.gameobject.curorigin,256,0);
/#
	assert(nodes.size);
#/
	return nodes[0];
}