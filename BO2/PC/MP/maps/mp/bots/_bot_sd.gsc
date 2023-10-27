/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bot_sd.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 47 ms
 * Timestamp: 10/27/2023 2:59:53 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/bots/_bot;
#include maps/mp/bots/_bot_combat;
#include maps/mp/gametypes/_gameobjects;
#include maps/mp/gametypes/_globallogic_utils;

//Function Number: 1
bot_sd_think()
{
	foreach(zone in level.bombzones)
	{
		if(!(IsDefined(zone.nearest_node)))
		{
			nodes = getnodesinradiussorted(zone.trigger.origin,256,0);
/#
			assert(nodes.size);
#/
			zone.nearest_node = nodes[0];
		}
	}

	zone = sd_get_planted_zone();
	if(IsDefined(zone))
	{
		self bot_sd_defender(zone,1);
	}
	else if(self.team == game["attackers"])
	{
		if(level.multibomb)
		{
			self.isbombcarrier = 1;
		}

		self bot_sd_attacker();
	}
	else
	{
		zone = random(level.bombzones);
		self bot_sd_defender(zone);
	}
}

//Function Number: 2
bot_sd_attacker()
{
	level endon("game_ended");
	if(!level.multibomb && !IsDefined(level.sdbomb.carrier) && !level.bombplanted)
	{
		self cancelgoal("sd_protect_carrier");
		if(!(level.sdbomb maps/mp/gametypes/_gameobjects::isobjectawayfromhome()))
		{
			if(!(self maps/mp/bots/_bot::bot_friend_goal_in_radius("sd_pickup",level.sdbomb.curorigin,64)))
			{
				self addgoal(level.sdbomb.curorigin,16,4,"sd_pickup");
				return;
			}
		}
		else
		{
			self addgoal(level.sdbomb.curorigin,16,4,"sd_pickup");
			return;
		}
	}
	else
	{
		self cancelgoal("sd_pickup");
	}

	if(is_true(self.isbombcarrier))
	{
		goal = self getgoal("sd_plant");
		if(IsDefined(goal))
		{
			if(distancesquared(self.origin,goal) < 2304)
			{
				self setstance("prone");
				wait(0.5);
				self pressusebutton(level.planttime + 1);
				wait(0.5);
				if(is_true(self.isplanting))
				{
					wait(level.planttime + 1);
				}

				self pressusebutton(0);
				self setstance("crouch");
				wait(0.25);
				self cancelgoal("sd_plant");
				self setstance("stand");
			}

			return;
		}
		else if(GetTime() > self.bot["patrol_update"])
		{
			frac = sd_get_time_frac();
			if(randomint(100) < frac * 100 || frac > 0.85)
			{
				zone = sd_get_closest_bomb();
				goal = sd_get_bomb_goal(zone.visuals[0]);
				if(IsDefined(goal))
				{
					if(frac > 0.85)
					{
						self addgoal(goal,24,4,"sd_plant");
					}
					else
					{
						self addgoal(goal,24,3,"sd_plant");
					}
				}
			}

			self.bot["patrol_update"] = GetTime() + randomintrange(2500,5000);
		}
	}
	else if(IsDefined(level.sdbomb.carrier) && !isplayer(level.sdbomb.carrier))
	{
		if(!(IsDefined(self.protectcarrier)))
		{
			if(randomint(100) > 70)
			{
				self.protectcarrier = 1;
			}
			else
			{
				self.protectcarrier = 0;
			}
		}

		if(self.protectcarrier)
		{
			goal = level.sdbomb.carrier getgoal("sd_plant");
			if(IsDefined(goal))
			{
				nodes = getnodesinradiussorted(goal,256,0);
				if(IsDefined(nodes) && nodes.size > 0 && !IsDefined(self getgoal("sd_protect_carrier")))
				{
					self addgoal(nodes[randomint(nodes.size)],24,3,"sd_protect_carrier");
				}
			}
		}
	}
}

//Function Number: 3
bot_sd_defender(zone,isplanted)
{
	bot_sd_grenade();
	if(IsDefined(isplanted) && isplanted && self hasgoal("sd_defend"))
	{
		goal = self getgoal("sd_defend");
		planted = sd_get_planted_zone();
		foreach(zone in level.bombzones)
		{
			if(planted != zone && distance2d(goal,zone.nearest_node.origin) < distance2d(goal,planted.nearest_node.origin))
			{
				self cancelgoal("sd_defend");
			}
		}
	}

	if(self atgoal("sd_defend") || self bot_need_to_defuse())
	{
		bot_sd_defender_think(zone);
		if(self hasgoal("sd_defend"))
		{
			return;
		}
	}

	if(self hasgoal("enemy_patrol"))
	{
		goal = self getgoal("enemy_patrol");
		closezone = sd_get_closest_bomb();
		if(distancesquared(goal,closezone.nearest_node.origin) < 262144)
		{
			self clearlookat();
			self cancelgoal("sd_defend");
			return;
		}
	}

	if(self hasgoal("sd_defend"))
	{
		self.bot["patrol_update"] = GetTime() + randomintrange(2500,5000);
		return;
	}

	if(self hasgoal("enemy_patrol"))
	{
		return;
	}

	nodes = getvisiblenodes(zone.nearest_node);
	best = undefined;
	highest = -100;
	foreach(node in nodes)
	{
		if(node.type == "BAD NODE")
		{
		}
		else if(!(canclaimnode(node,self.team)))
		{
		}
		else if(distancesquared(node.origin,self.origin) < 65536)
		{
		}
		else if(self maps/mp/bots/_bot::bot_friend_goal_in_radius("sd_defend",node.origin,256) > 0)
		{
		}
		else
		{
			height = node.origin[2] - zone.nearest_node.origin[2];
			if(IsDefined(isplanted) && isplanted)
			{
				dist = distance2d(node.origin,zone.nearest_node.origin);
				score = 10000 - dist + height;
			}
			else
			{
				score = height;
			}

			if(score > highest)
			{
				highest = score;
				best = node;
			}
		}
	}

	if(!(IsDefined(best)))
	{
		return;
	}

	self addgoal(best,24,3,"sd_defend");
}

//Function Number: 4
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

	zone = sd_get_closest_bomb();
	node = getvisiblenode(self.origin,zone.nearest_node.origin);
	if(IsDefined(node) && distancesquared(self.origin,node.origin) > 16384)
	{
		return node.origin;
	}

	forward = AnglesToForward(self getplayerangles());
	origin = self geteye() + forward * 1024;
	return origin;
}

//Function Number: 5
bot_sd_defender_think(zone)
{
	if(self bot_need_to_defuse())
	{
		if(self maps/mp/bots/_bot::bot_friend_goal_in_radius("sd_defuse",level.sdbombmodel.origin,16) > 0)
		{
			return;
		}

		self clearlookat();
		goal = self getgoal("sd_defuse");
		if(IsDefined(goal) && distancesquared(self.origin,goal) < 2304)
		{
			self setstance("prone");
			wait(0.5);
			self pressusebutton(level.defusetime + 1);
			wait(0.5);
			if(is_true(self.isdefusing))
			{
				wait(level.defusetime + 1);
			}

			self pressusebutton(0);
			self setstance("crouch");
			wait(0.25);
			self cancelgoal("sd_defuse");
			self setstance("stand");
			return;
		}

		if(!IsDefined(goal) && distance2dsquared(self.origin,level.sdbombmodel.origin) < 1000000)
		{
			self addgoal(level.sdbombmodel.origin,24,4,"sd_defuse");
		}

		return;
	}

	if(GetTime() > self.bot["patrol_update"])
	{
		if(cointoss())
		{
			self clearlookat();
			self cancelgoal("sd_defend");
			return;
		}

		self.bot["patrol_update"] = GetTime() + randomintrange(2500,5000);
	}

	if(self hasgoal("enemy_patrol"))
	{
		goal = self getgoal("enemy_patrol");
		zone = sd_get_closest_bomb();
		if(distancesquared(goal,zone.nearest_node.origin) < 262144)
		{
			self clearlookat();
			self cancelgoal("sd_defend");
			return;
		}
	}

	if(GetTime() > self.bot["lookat_update"])
	{
		origin = self bot_get_look_at();
		z = 20;
		if(distancesquared(origin,self.origin) > 262144)
		{
			z = randomintrange(16,60);
		}

		self lookat(origin + (0,0,z));
		self.bot["lookat_update"] = GetTime() + randomintrange(1500,3000);
		if(distancesquared(origin,self.origin) > 65536)
		{
			dir = vectornormalize(self.origin - origin);
			dir = VectorScale(dir);
			origin = origin + dir;
		}

		self maps/mp/bots/_bot_combat::bot_combat_throw_proximity(origin);
	}
}

//Function Number: 6
bot_need_to_defuse()
{
	return level.bombplanted && self.team == game["defenders"];
}

//Function Number: 7
sd_get_bomb_goal(ent)
{
	goals = [];
	dir = AnglesToForward(ent.angles);
	dir = VectorScale(dir);
	goals[0] = ent.origin + dir;
	goals[1] = ent.origin - dir;
	dir = AnglesToRight(ent.angles);
	dir = VectorScale(dir);
	goals[2] = ent.origin + dir;
	goals[3] = ent.origin - dir;
	goals = array_randomize(goals);
	foreach(goal in goals)
	{
		if(findpath(self.origin,goal,0))
		{
			return goal;
		}
	}

	return undefined;
}

//Function Number: 8
sd_get_time_frac()
{
	remaining = maps/mp/gametypes/_globallogic_utils::gettimeremaining();
	end = level.timelimit * 60 * 1000;
	if(end == 0)
	{
		end = self.spawntime + 120000;
		remaining = end - GetTime();
	}

	return 1 - remaining / end;
}

//Function Number: 9
sd_get_closest_bomb()
{
	best = undefined;
	distsq = 9999999;
	foreach(zone in level.bombzones)
	{
		d = distancesquared(self.origin,zone.curorigin);
		if(!(IsDefined(best)))
		{
			best = zone;
			distsq = d;
		}
		else if(d < distsq)
		{
			best = zone;
			distsq = d;
		}
	}

	return best;
}

//Function Number: 10
sd_get_planted_zone()
{
	if(level.bombplanted)
	{
		foreach(zone in level.bombzones)
		{
			if(zone.interactteam == "none")
			{
				return zone;
			}
		}
	}

	return undefined;
}

//Function Number: 11
bot_sd_grenade()
{
	enemies = bot_get_enemies();
	if(!(enemies.size))
	{
		return;
	}

	zone = sd_get_closest_bomb();
	foreach(enemy in enemies)
	{
		if(distancesquared(enemy.origin,zone.nearest_node.origin) < 147456)
		{
			if(!(self maps/mp/bots/_bot_combat::bot_combat_throw_lethal(enemy.origin)))
			{
				self maps/mp/bots/_bot_combat::bot_combat_throw_tactical(enemy.origin);
			}

			return;
		}
	}
}