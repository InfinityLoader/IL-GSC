/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bot_dem.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 2 ms
 * Timestamp: 10/28/2023 12:10:26 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/bots/_bot;
#include maps/mp/bots/_bot_combat;
#include maps/mp/gametypes/dem;

//Function Number: 1
bot_dem_think()
{
	if(!(IsDefined(level.bombzones[0].dem_nodes)))
	{
		foreach(zone in level.bombzones)
		{
			zone.dem_nodes = [];
			zone.dem_nodes = getnodesinradius(zone.trigger.origin,1024,64,128,"Path");
		}
	}

	if(self.team == game["attackers"])
	{
		bot_dem_attack_think();
	}
	else
	{
		bot_dem_defend_think();
	}
}

//Function Number: 2
bot_dem_attack_think()
{
	zones = dem_get_alive_zones();
	if(!(zones.size))
	{
		return;
	}

	if(!(IsDefined(self.goal_flag)))
	{
		zones = array_randomize(zones);
		foreach(zone in zones)
		{
			if(zones.size == 1 || is_true(zone.bombplanted) && !is_true(zone.bombexploded))
			{
				self.goal_flag = zone;
				break;
			}
			else if(randomint(100) < 50)
			{
				self.goal_flag = zone;
				break;
			}
		}
	}

	if(IsDefined(self.goal_flag))
	{
		if(is_true(self.goal_flag.bombexploded))
		{
			self.goal_flag = undefined;
			self cancelgoal("dem_guard");
			self cancelgoal("bomb");
		}
		else if(is_true(self.goal_flag.bombplanted))
		{
			self bot_dem_guard(self.goal_flag,self.goal_flag.dem_nodes,self.goal_flag.trigger.origin);
		}
		else if(self bot_dem_friend_interacting(self.goal_flag.trigger.origin))
		{
			self bot_dem_guard(self.goal_flag,self.goal_flag.dem_nodes,self.goal_flag.trigger.origin);
		}
		else
		{
			self bot_dem_attack(self.goal_flag);
		}
	}
}

//Function Number: 3
bot_dem_defend_think()
{
	zones = dem_get_alive_zones();
	if(!(zones.size))
	{
		return;
	}

	if(!(IsDefined(self.goal_flag)))
	{
		zones = array_randomize(zones);
		foreach(zone in zones)
		{
			if(zones.size == 1 || is_true(zone.bombplanted) && !is_true(zone.bombexploded))
			{
				self.goal_flag = zone;
				break;
			}
			else if(randomint(100) < 50)
			{
				self.goal_flag = zone;
				break;
			}
		}
	}

	if(IsDefined(self.goal_flag))
	{
		if(is_true(self.goal_flag.bombexploded))
		{
			self.goal_flag = undefined;
			self cancelgoal("dem_guard");
			self cancelgoal("bomb");
		}
		else if(is_true(self.goal_flag.bombplanted) && !self bot_dem_friend_interacting(self.goal_flag.trigger.origin))
		{
			self bot_dem_defuse(self.goal_flag);
		}
		else
		{
			self bot_dem_guard(self.goal_flag,self.goal_flag.dem_nodes,self.goal_flag.trigger.origin);
		}
	}
}

//Function Number: 4
bot_dem_attack(zone)
{
	self cancelgoal("dem_guard");
	if(!(self hasgoal("bomb")))
	{
		self.bomb_goal = self dem_get_bomb_goal(zone.visuals[0]);
		if(IsDefined(self.bomb_goal))
		{
			self addgoal(self.bomb_goal,48,2,"bomb");
		}

		return;
	}

	if(!(self atgoal("bomb")))
	{
		if(!(self maps/mp/bots/_bot_combat::bot_combat_throw_smoke(self.bomb_goal)))
		{
			if(!(self maps/mp/bots/_bot_combat::bot_combat_throw_proximity(self.bomb_goal)))
			{
				self maps/mp/bots/_bot_combat::bot_combat_throw_lethal(self.bomb_goal);
			}
		}

		return;
	}

	self addgoal(self.bomb_goal,48,4,"bomb");
	self setstance("prone");
	self pressusebutton(level.planttime + 1);
	wait(0.5);
	if(is_true(self.isplanting))
	{
		wait(level.planttime + 1);
	}

	self pressusebutton(0);
	defenders = self bot_get_enemies();
	foreach(defender in defenders)
	{
		if(defender is_bot())
		{
			defender.goal_flag = undefined;
		}
	}

	self setstance("crouch");
	wait(0.25);
	self cancelgoal("bomb");
	self setstance("stand");
}

//Function Number: 5
bot_dem_guard(zone,nodes,origin)
{
	self cancelgoal("bomb");
	enemy = self bot_dem_enemy_interacting(origin);
	if(IsDefined(enemy))
	{
		self maps/mp/bots/_bot_combat::bot_combat_throw_lethal(enemy.origin);
		self addgoal(enemy.origin,128,3,"dem_guard");
		return;
	}

	enemy = self bot_dem_enemy_nearby(origin);
	if(IsDefined(enemy))
	{
		self maps/mp/bots/_bot_combat::bot_combat_throw_lethal(enemy.origin);
		self addgoal(enemy.origin,128,3,"dem_guard");
		return;
	}

	if(self hasgoal("dem_guard") && !self atgoal("dem_guard"))
	{
		self maps/mp/bots/_bot_combat::bot_combat_throw_proximity(origin);
		return;
	}

	node = random(nodes);
	self addgoal(node,24,2,"dem_guard");
}

//Function Number: 6
bot_dem_defuse(zone)
{
	self cancelgoal("dem_guard");
	if(!(self hasgoal("bomb")))
	{
		self.bomb_goal = self dem_get_bomb_goal(zone.visuals[0]);
		if(IsDefined(self.bomb_goal))
		{
			self addgoal(self.bomb_goal,48,2,"bomb");
		}

		return;
	}

	if(!(self atgoal("bomb")))
	{
		if(!(self maps/mp/bots/_bot_combat::bot_combat_throw_smoke(self.bomb_goal)))
		{
			if(!(self maps/mp/bots/_bot_combat::bot_combat_throw_proximity(self.bomb_goal)))
			{
				self maps/mp/bots/_bot_combat::bot_combat_throw_lethal(self.bomb_goal);
			}
		}

		if(self.goal_flag.detonatetime - GetTime() < 12000)
		{
			self addgoal(self.bomb_goal,48,4,"bomb");
		}

		return;
	}

	self addgoal(self.bomb_goal,48,4,"bomb");
	if(cointoss())
	{
		self setstance("crouch");
	}
	else
	{
		self setstance("prone");
	}

	self pressusebutton(level.defusetime + 1);
	wait(0.5);
	if(is_true(self.isdefusing))
	{
		wait(level.defusetime + 1);
	}

	self pressusebutton(0);
	self setstance("crouch");
	wait(0.25);
	self cancelgoal("bomb");
	self setstance("stand");
}

//Function Number: 7
bot_dem_enemy_interacting(origin)
{
	enemies = maps/mp/bots/_bot::bot_get_enemies();
	foreach(enemy in enemies)
	{
		if(distancesquared(enemy.origin,origin) > 65536)
		{
		}
		else if(is_true(enemy.isdefusing) || is_true(enemy.isplanting))
		{
			return enemy;
		}
	}

	return undefined;
}

//Function Number: 8
bot_dem_friend_interacting(origin)
{
	friends = maps/mp/bots/_bot::bot_get_friends();
	foreach(friend in friends)
	{
		if(distancesquared(friend.origin,origin) > 65536)
		{
		}
		else if(is_true(friend.isdefusing) || is_true(friend.isplanting))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 9
bot_dem_enemy_nearby(origin)
{
	enemy = maps/mp/bots/_bot::bot_get_closest_enemy(origin,1);
	if(IsDefined(enemy))
	{
		if(distancesquared(enemy.origin,origin) < 1048576)
		{
			return enemy;
		}
	}

	return undefined;
}

//Function Number: 10
dem_get_alive_zones()
{
	zones = [];
	foreach(zone in level.bombzones)
	{
		if(is_true(zone.bombexploded))
		{
		}
		else
		{
			zones[zones.size] = zone;
		}
	}

	return zones;
}

//Function Number: 11
dem_get_bomb_goal(ent)
{
	if(!(IsDefined(ent.bot_goals)))
	{
		goals = [];
		ent.bot_goals = [];
		dir = AnglesToForward(ent.angles);
		dir = VectorScale(dir);
		goals[0] = ent.origin + dir;
		goals[1] = ent.origin - dir;
		dir = AnglesToRight(ent.angles);
		dir = VectorScale(dir);
		goals[2] = ent.origin + dir;
		goals[3] = ent.origin - dir;
		foreach(goal in goals)
		{
			start = 128 + VectorScale((0,0,1));
			trace = bullettrace(start,goal,0,undefined);
			ent.bot_goals[ent.bot_goals.size] = trace["position"];
		}
	}

	goals = array_randomize(ent.bot_goals);
	foreach(goal in goals)
	{
		if(findpath(self.origin,goal,0))
		{
			return goal;
		}
	}

	return undefined;
}