/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_behavior.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 84 ms
 * Timestamp: 4/22/2024 2:13:33 AM
*******************************************************************/

//Function Number: 1
humanoid_begin_melee()
{
	if(self.ignoreall)
	{
		return 0;
	}

	if(!isdefined(self.curmeleetarget))
	{
		return 0;
	}

	if(self.aistate == "melee" || maps\mp\agents\_scripted_agent_anim_util::isstatelocked())
	{
		return 0;
	}

	if(!maps\mp\zombies\_util::has_entered_game())
	{
		return 0;
	}

	if(maps\mp\agents\humanoid\_humanoid::wanttoattacktargetbutcant())
	{
		return 0;
	}

	if(maps\mp\agents\humanoid\_humanoid::didpastmeleefail())
	{
		return 0;
	}

	var_00 = maps\mp\zombies\_util::is_true(self.lungemeleeenabled) && isdefined(self.lungelast) && gettime() - self.lungelast <= self.lungedebouncems;
	if(maps\mp\agents\humanoid\_humanoid::didpastlungemeleefail() || var_00)
	{
		if(!maps\mp\agents\humanoid\_humanoid::readytomeleetarget("base"))
		{
			return 0;
		}
	}
	else if(!maps\mp\agents\humanoid\_humanoid::readytomeleetarget("normal"))
	{
		return 0;
	}

	if(isdefined(self.meleedebouncetime))
	{
		var_01 = gettime() - self.lastmeleefinishtime;
		if(var_01 < self.meleedebouncetime * 1000)
		{
			return 0;
		}
	}

	if(!isdefined(self.lastmeleepos) || distancesquared(self.lastmeleepos,self.origin) > 256)
	{
		self.meleemovemode = self.movemode;
	}

	self scragentbeginmelee(self.curmeleetarget);
	return 1;
}

//Function Number: 2
humanoid_seek_enemy_melee(param_00)
{
	if(self.ignoreall)
	{
		self.curmeleetarget = undefined;
		return 0;
	}

	var_01 = undefined;
	if(isdefined(self.distractiondrone) && maps\mp\agents\humanoid\_humanoid_util::shouldtargetdistractiondrone())
	{
		var_01 = self.distractiondrone;
	}
	else if(isdefined(level.zmbhighpriorityenemy) && !maps\mp\zombies\_util::shouldignoreent(level.zmbhighpriorityenemy))
	{
		var_01 = level.zmbhighpriorityenemy;
	}
	else if(isdefined(self.enemy) && !maps\mp\zombies\_util::shouldignoreent(self.enemy))
	{
		var_01 = self.enemy;
	}

	if(isdefined(var_01))
	{
		var_02 = self.attackoffset + self.radius * 2;
		var_03 = var_02 * var_02;
		if(maps\mp\zombies\_util::getzombieslevelnum() >= 3)
		{
			var_04 = var_02 - self.attackoffset;
		}
		else
		{
			var_04 = self.attackoffset;
		}

		var_05 = var_04 * var_04;
		self.curmeleetarget = var_01;
		var_06 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(var_01);
		var_07 = var_06.enemysectororigin;
		var_08 = distancesquared(var_06.origin,self.origin);
		var_09 = distancesquared(var_07,self.origin);
		var_0A = self.bhasnopath;
		if(var_09 < squared(self.radius) && distancesquared(var_07,var_06.origin) > squared(self.radius))
		{
			var_0A = 1;
			self notify("attack_anim","end");
		}

		if(isdefined(param_00) && param_00)
		{
			if(!var_0A && var_09 > var_03)
			{
				var_0A = 1;
			}
		}
		else if(!var_0A && var_09 > var_03 && var_08 > var_05)
		{
			var_0A = 1;
		}

		if(var_06.valid)
		{
			if(!var_0A && var_09 <= var_03 && var_08 > squared(self.defaultgoalradius))
			{
				var_0A = 1;
			}

			self scragentsetgoalradius(self.defaultgoalradius);
		}
		else if(!maps\mp\agents\humanoid\_humanoid_util::hasvalidmeleesectorsfortype(var_01,self.meleesectortype))
		{
			self scragentsetgoalradius(self.defaultgoalradius);
			var_0A = 1;
		}
		else
		{
			self scragentsetgoalradius(var_02);
			if(var_09 <= var_03)
			{
				var_06.origin = self.origin;
				var_0A = 1;
			}
		}

		if(var_0A)
		{
			self scragentsetgoalpos(var_06.origin);
		}

		return 1;
	}
	else
	{
		if(isdefined(self.curmeleetarget))
		{
			self.bhasnopath = 1;
		}

		self.curmeleetarget = undefined;
	}

	return 0;
}

//Function Number: 3
humanoid_seek_enemies_all_known()
{
	var_00 = [];
	var_01 = level.characters;
	if(isdefined(level.npcs))
	{
		var_01 = common_scripts\utility::array_combine(var_01,level.npcs);
	}

	foreach(var_03 in var_01)
	{
		if(var_03.ignoreme || isdefined(var_03.owner) && var_03.owner.ignoreme)
		{
			continue;
		}

		if((isagent(var_03) || isplayer(var_03)) && var_03 isnotarget() || isdefined(var_03.owner) && var_03.owner isnotarget())
		{
			continue;
		}

		if(isalliedsentient(self,var_03))
		{
			continue;
		}

		if(maps\mp\zombies\_util::shouldignoreent(var_03))
		{
			continue;
		}

		if(isdefined(var_03.canbetargetedby))
		{
			if(!var_03 [[ var_03.canbetargetedby ]](self))
			{
				continue;
			}
		}
		else if(!isalive(var_03))
		{
			continue;
		}

		var_00[var_00.size] = var_03;
	}

	var_05 = undefined;
	if(var_00.size > 0)
	{
		var_05 = sortbydistance(var_00,self.origin);
	}

	if(isdefined(var_05) && var_05.size > 0)
	{
		var_06 = 300;
		var_07 = distancesquared(var_05[0].origin,self.origin);
		if(var_07 < var_06 * var_06)
		{
			var_06 = 16;
		}

		if(self.bhasnopath || distancesquared(self scragentgetgoalpos(),var_05[0].origin) > var_06 * var_06)
		{
			self scragentsetgoalpos(var_05[0].origin);
			self.bhasnopath = 0;
		}

		return 1;
	}

	return 0;
}

//Function Number: 4
humanoid_seek_random_loc()
{
	var_00 = distancesquared(self scragentgetgoalpos(),self.origin) < self.defaultgoalradius * self.defaultgoalradius;
	if(var_00 || self.bhasnopath)
	{
		self.last_random_path_node = undefined;
		if(!isdefined(self.last_random_path_node))
		{
			var_01 = getnodesinradiussorted(self.origin,1024,256,512,"Path");
			var_02 = maps\mp\agents\humanoid\_humanoid_util::find_valid_pathnodes_for_random_pathing(var_01);
			if(var_02.size > 0)
			{
				self.last_random_path_node = common_scripts\utility::random(var_02);
			}
		}

		if(isdefined(self.last_random_path_node))
		{
			self scragentsetgoalpos(self.last_random_path_node.origin);
			self.bhasnopath = 0;
		}
	}

	return !self.bhasnopath;
}

//Function Number: 5
humanoid_follow(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(self.bhasnopath || distancesquared(self scragentgetgoalpos(),param_00.origin) < 16384)
	{
		self scragentsetgoalpos(param_00.origin);
		self.bhasnopath = 0;
	}

	return 1;
}