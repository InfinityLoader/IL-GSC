/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bot_hq.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 33 ms
 * Timestamp: 10/27/2023 2:59:52 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/bots/_bot;
#include maps/mp/bots/_bot_combat;
#include maps/mp/gametypes/koth;

//Function Number: 1
bot_hq_think()
{
	time = GetTime();
	if(time < self.bot.update_objective)
	{
		return;
	}

	self.bot.update_objective = time + randomintrange(500,1500);
	if(bot_should_patrol_hq())
	{
		self bot_patrol_hq();
	}
	else if(!(bot_has_hq_goal()))
	{
		self bot_move_to_hq();
	}

	if(self bot_is_capturing_hq())
	{
		self bot_capture_hq();
	}

	bot_hq_tactical_insertion();
	bot_hq_grenade();
	if(!bot_is_capturing_hq() && !self atgoal("hq_patrol"))
	{
		mine = getnearestnode(self.origin);
		node = hq_nearest_node();
		if(IsDefined(mine) && nodesvisible(mine,node))
		{
			self lookat(30 + VectorScale((0,0,1)));
		}
	}
}

//Function Number: 2
bot_has_hq_goal()
{
	origin = self getgoal("hq_radio");
	if(IsDefined(origin))
	{
		foreach(node in level.radio.nodes)
		{
			if(distancesquared(origin,node.origin) < 4096)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 3
bot_is_capturing_hq()
{
	return self atgoal("hq_radio");
}

//Function Number: 4
bot_should_patrol_hq()
{
	if(level.radio.gameobject.ownerteam == "neutral")
	{
		return 0;
	}

	if(level.radio.gameobject.ownerteam != self.team)
	{
		return 0;
	}

	if(hq_is_contested())
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
bot_patrol_hq()
{
	self cancelgoal("hq_radio");
	if(self atgoal("hq_patrol"))
	{
		node = getnearestnode(self.origin);
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

		goal = self getgoal("hq_patrol");
		nearest = hq_nearest_node();
		mine = getnearestnode(goal);
		if(IsDefined(mine) && !nodesvisible(mine,nearest))
		{
			self clearlookat();
			self cancelgoal("hq_patrol");
		}

		if(GetTime() > self.bot.update_objective_patrol)
		{
			self clearlookat();
			self cancelgoal("hq_patrol");
		}

		return;
	}

	nearest = hq_nearest_node();
	if(self hasgoal("hq_patrol"))
	{
		goal = self getgoal("hq_patrol");
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
			self cancelgoal("hq_patrol");
		}

		return;
	}

	nodes = getvisiblenodes(nearest);
/#
	assert(nodes.size);
#/
	for(i = randomint(nodes.size);i < nodes.size;i++)
	{
		if(self maps/mp/bots/_bot::bot_friend_goal_in_radius("hq_radio",nodes[i].origin,128) == 0)
		{
			if(self maps/mp/bots/_bot::bot_friend_goal_in_radius("hq_patrol",nodes[i].origin,256) == 0)
			{
				self addgoal(nodes[i],24,3,"hq_patrol");
				return;
			}
		}
	}
}

//Function Number: 6
bot_move_to_hq()
{
	self clearlookat();
	self cancelgoal("hq_radio");
	self cancelgoal("hq_patrol");
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

	nodes = array_randomize(level.radio.nodes);
	foreach(node in nodes)
	{
		if(self maps/mp/bots/_bot::bot_friend_goal_in_radius("hq_radio",node.origin,64) == 0)
		{
			self addgoal(node,24,3,"hq_radio");
			return;
		}
	}

	self addgoal(random(nodes),24,3,"hq_radio");
}

//Function Number: 7
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

	spawn = random(level.spawnpoints);
	node = getvisiblenode(self.origin,spawn.origin);
	if(IsDefined(node) && distancesquared(self.origin,node.origin) > 16384)
	{
		return node.origin;
	}

	return level.radio.baseorigin;
}

//Function Number: 8
bot_capture_hq()
{
	self addgoal(self.origin,24,3,"hq_radio");
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
		self.bot.update_lookat = GetTime() + randomintrange(1500,3000);
	}
}

//Function Number: 9
any_other_team_touching(skip_team)
{
	foreach(team in level.teams)
	{
		if(team == skip_team)
		{
		}
		else if(level.radio.gameobject.numtouching[team])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 10
is_hq_contested(skip_team)
{
	if(any_other_team_touching(skip_team))
	{
		return 1;
	}

	enemy = self maps/mp/bots/_bot::bot_get_closest_enemy(level.radio.baseorigin,1);
	if(IsDefined(enemy) && distancesquared(enemy.origin,level.radio.baseorigin) < 262144)
	{
		return 1;
	}

	return 0;
}

//Function Number: 11
bot_hq_grenade()
{
	enemies = bot_get_enemies();
	if(!(enemies.size))
	{
		return;
	}

	if(self atgoal("hq_patrol") || self atgoal("hq_radio"))
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

	if(!(is_hq_contested(self.team)))
	{
		self maps/mp/bots/_bot_combat::bot_combat_throw_smoke(level.radio.baseorigin);
		return;
	}

	enemy = self maps/mp/bots/_bot::bot_get_closest_enemy(level.radio.baseorigin,0);
	if(IsDefined(enemy))
	{
		origin = enemy.origin;
	}
	else
	{
		origin = level.radio.baseorigin;
	}

	dir = vectornormalize(self.origin - origin);
	dir = (0,dir[1],0);
	origin = 128 + VectorScale(dir);
	if(!(self maps/mp/bots/_bot_combat::bot_combat_throw_lethal(origin)))
	{
		self maps/mp/bots/_bot_combat::bot_combat_throw_tactical(origin);
	}
}

//Function Number: 12
bot_hq_tactical_insertion()
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

	node = hq_nearest_node();
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

//Function Number: 13
hq_nearest_node()
{
	return random(level.radio.nodes);
}

//Function Number: 14
hq_is_contested()
{
	enemy = self maps/mp/bots/_bot::bot_get_closest_enemy(level.radio.baseorigin,0);
	return IsDefined(enemy) && distancesquared(enemy.origin,level.radio.baseorigin) < level.radio.node_radius * level.radio.node_radius;
}