/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bot_hack.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 2:59:51 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/bots/_bot;
#include maps/mp/gametypes/ctf;

//Function Number: 1
bot_hack_tank_get_goal_origin(tank)
{
	nodes = getnodesinradiussorted(tank.origin,256,0,64,"Path");
	foreach(node in nodes)
	{
		dir = vectornormalize(node.origin - tank.origin);
		dir = VectorScale(dir);
		goal = tank.origin + dir;
		if(findpath(self.origin,goal,0))
		{
			return goal;
		}
	}

	return undefined;
}

//Function Number: 2
bot_hack_has_goal(tank)
{
	goal = self getgoal("hack");
	if(IsDefined(goal))
	{
		if(distancesquared(goal,tank.origin) < 16384)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 3
bot_hack_at_goal()
{
	if(self atgoal("hack"))
	{
		return 1;
	}

	goal = self getgoal("hack");
	if(IsDefined(goal))
	{
		tanks = getentarray("talon","targetname");
		tanks = arraysort(tanks,self.origin);
		foreach(tank in tanks)
		{
			if(distancesquared(goal,tank.origin) < 16384)
			{
				if(IsDefined(tank.trigger) && self istouching(tank.trigger))
				{
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 4
bot_hack_goal_pregame(tanks)
{
	foreach(tank in tanks)
	{
		if(IsDefined(tank.owner))
		{
		}
		else if(IsDefined(tank.team) && tank.team == self.team)
		{
		}
		else
		{
			goal = self bot_hack_tank_get_goal_origin(tank);
			if(IsDefined(goal))
			{
				if(self addgoal(goal,24,2,"hack"))
				{
					self.goal_flag = tank;
					return;
				}
			}
		}
	}
}

//Function Number: 5
bot_hack_think()
{
	if(bot_hack_at_goal())
	{
		self setstance("crouch");
		wait(0.25);
		self addgoal(self.origin,24,4,"hack");
		self pressusebutton(level.drone_hack_time + 1);
		wait(level.drone_hack_time + 1);
		self setstance("stand");
		self cancelgoal("hack");
	}

	tanks = getentarray("talon","targetname");
	tanks = arraysort(tanks,self.origin);
	if(!(is_true(level.drones_spawned)))
	{
		self bot_hack_goal_pregame(tanks);
	}
	else
	{
		foreach(tank in tanks)
		{
			if(IsDefined(tank.owner) && tank.owner == self)
			{
			}
			else
			{
				if(!(IsDefined(tank.owner)))
				{
					if(self bot_hack_has_goal(tank))
					{
						return;
					}

					goal = self bot_hack_tank_get_goal_origin(tank);
					if(IsDefined(goal))
					{
						self addgoal(goal,24,2,"hack");
						return;
					}
				}

				if(tank.isstunned && distancesquared(self.origin,tank.origin) < 262144)
				{
					goal = self bot_hack_tank_get_goal_origin(tank);
					if(IsDefined(goal))
					{
						self addgoal(goal,24,3,"hack");
						return;
					}
				}
			}
		}

		if(!(maps/mp/bots/_bot::bot_vehicle_weapon_ammo("emp_grenade_mp")))
		{
			ammo = getentarray("weapon_scavenger_item_hack_mp","classname");
			ammo = arraysort(ammo,self.origin);
			foreach(bag in ammo)
			{
				if(findpath(self.origin,bag.origin,0))
				{
					self addgoal(bag.origin,24,2,"hack");
					return;
				}
			}

			return;
		}

		foreach(tank in tanks)
		{
			if(IsDefined(tank.owner) && tank.owner == self)
			{
			}
			else if(tank.isstunned)
			{
			}
			else if(self throwgrenade("emp_grenade_mp",tank.origin))
			{
				self waittill(_k122,_k162,"grenade_fire");
				goal = self bot_hack_tank_get_goal_origin(tank);
				if(IsDefined(goal))
				{
					self addgoal(goal,24,3,"hack");
					wait(0.5);
					return;
				}
			}
		}
	}
}