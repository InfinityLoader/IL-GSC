/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\civ_generic.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 119 ms
 * Timestamp: 4/22/2024 2:14:48 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.agent_funcs["civ_generic"] = level.agent_funcs["civilian"];
	level.agent_funcs["civ_generic"]["think"] = ::civilian_generic_think;
	var_00[0] = ["zombies_body_civ_cau_a"];
	var_01[0] = ["zombies_head_cau_a"];
	var_02 = spawnstruct();
	var_02.agent_type = "civ_generic";
	var_02.animclass = "zombie_animclass";
	var_02.model_bodies = var_00;
	var_02.model_heads = var_01;
	var_02.health_scale = 1;
	maps\mp\zombies\_util::agentclassregister(var_02,var_02.agent_type);
}

//Function Number: 2
civilian_generic_think()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	maps\mp\agents\humanoid\_humanoid::setuphumanoidstate();
	thread maps\mp\zombies\_util::waitforbadpath();
	for(;;)
	{
		if(civilian_evacuate())
		{
			wait(0.05);
			continue;
		}

		if(isalive(self.foundby) && maps\mp\zombies\_behavior::humanoid_follow(self.foundby))
		{
			wait(0.05);
			continue;
		}

		if(civilian_wait_used(&"ZOMBIES_CIV_FOLLOW"))
		{
			wait(0.05);
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 3
civilian_wait_used(param_00)
{
	if(isalive(self.foundby))
	{
		return 0;
	}

	self.foundby = undefined;
	if(!self.ignoreme)
	{
		self takeallweapons();
		self allowcrouch(0);
		self.ignoreme = 1;
		thread maps\mp\zombies\_util::zombies_make_usable(param_00);
		thread civilian_use_waiter();
		self scragentsetgoalpos(self.origin);
	}

	return 1;
}

//Function Number: 4
civilian_use_waiter()
{
	self waittill("player_used",var_00);
	self.foundby = var_00;
	self.ignoreme = 0;
	self allowcrouch(1);
	thread maps\mp\zombies\_util::zombies_make_unusable();
}

//Function Number: 5
civilian_evacuate()
{
	if(!isdefined(self.evac_point) && isdefined(level.evac_points))
	{
		var_00 = sortbydistance(level.evac_points,self.origin,500);
		if(isdefined(var_00) && var_00.size > 0)
		{
			self.evac_point = var_00[0];
		}
	}

	if(!isdefined(self.evac_point))
	{
		self.evac_goal = undefined;
		self notify("civilian_evac_waiter");
		return 0;
	}

	if(!isdefined(self.evac_goal))
	{
		self scragentsetgoalpos(self.evac_point.origin);
		self.evac_goal = self.evac_point;
		thread civilian_evac_waiter();
	}

	return 1;
}

//Function Number: 6
civilian_evac_waiter()
{
	self notify("civilian_evac_waiter");
	self endon("civilian_evac_waiter");
	self endon("death");
	level endon("game_ended");
	var_00 = common_scripts\utility::waittill_any_return("goal","goal_reached","bad_path");
	self.evac_point = undefined;
	if(var_00 == "goal" || var_00 == "goal_reached")
	{
		self notify("rescued");
		iprintlnbold("Civilian Rescued!");
		maps\mp\zombies\_util::zombies_make_nonobjective();
		if(maps\mp\gametypes\_hostmigration::waittillhostmigrationdone())
		{
			wait(0.05);
		}

		self suicide();
	}
}