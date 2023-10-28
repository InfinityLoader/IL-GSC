/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\zm_melee.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 6 ms
 * Timestamp: 10/28/2023 12:11:31 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;
#include maps/mp/animscripts/zm_combat;
#include maps/mp/animscripts/zm_utility;

//Function Number: 1
meleecombat()
{
	self endon("end_melee");
	self endon("killanimscript");
/#
	assert(canmeleeanyrange());
#/
	self orientmode("face enemy");
	if(is_true(self.sliding_on_goo))
	{
		self animmode("slide");
	}
	else
	{
		self animmode("zonly_physics");
	}

	for(;;)
	{
		if(IsDefined(self.marked_for_death))
		{
			return;
		}

		if(IsDefined(self.enemy))
		{
			angles = VectorToAngles(self.enemy.origin - self.origin);
			self orientmode("face angle",angles[1]);
		}

		if(IsDefined(self.zmb_vocals_attack))
		{
			self playsound(self.zmb_vocals_attack);
		}

		if(IsDefined(self.nochangeduringmelee) && self.nochangeduringmelee)
		{
			self.safetochangescript = 0;
		}

		if(IsDefined(self.is_inert) && self.is_inert)
		{
			return;
		}

		set_zombie_melee_anim_state(self);
		if(IsDefined(self.melee_anim_func))
		{
			self thread [[ self.melee_anim_func ]]();
		}

		while(1)
		{
			self waittill("melee_anim",note);
			if(note == "end")
			{
				break;
			}
			else
			{
				if(note == "fire")
				{
					if(!(IsDefined(self.enemy)))
					{
						break;
					}

					if(IsDefined(self.dont_die_on_me) && self.dont_die_on_me)
					{
						break;
					}

					self.enemy notify("melee_swipe",self);
					oldhealth = self.enemy.health;
					self melee();
					if(!(IsDefined(self.enemy)))
					{
						break;
					}

					if(self.enemy.health >= oldhealth)
					{
						if(IsDefined(self.melee_miss_func))
						{
							self [[ self.melee_miss_func ]]();
						}
						else if(IsDefined(level.melee_miss_func))
						{
							self [[ level.melee_miss_func ]]();
						}
					}

/#
					if(GetDvarInt(#"7F11F572"))
					{
						if(self.enemy.health < oldhealth)
						{
							zombie_eye = self geteye();
							player_eye = self.enemy geteye();
							trace = bullettrace(zombie_eye,player_eye,1,self);
							hitpos = trace["position"];
							dist = distance(zombie_eye,hitpos);
							iprintln("melee HIT " + dist);
						}
					}
#/
					continue;
				}

				if(note == "stop")
				{
					if(!(cancontinuetomelee()))
					{
						break;
					}
				}
			}
		}

		if(is_true(self.sliding_on_goo))
		{
			self orientmode("face enemy");
		}
		else
		{
			self orientmode("face default");
		}

		if((IsDefined(self.nochangeduringmelee) && self.nochangeduringmelee) || is_true(self.sliding_on_goo))
		{
			if(IsDefined(self.enemy))
			{
				dist_sq = distancesquared(self.origin,self.enemy.origin);
				if(dist_sq > self.meleeattackdist * self.meleeattackdist)
				{
					self.safetochangescript = 1;
					wait(0.1);
					break;
				}

				continue;
			}

			self.safetochangescript = 1;
			wait(0.1);
			break;
		}
	}

	if(is_true(self.sliding_on_goo))
	{
		self animmode("slide");
	}
	else
	{
		self animmode("none");
	}

	self thread maps/mp/animscripts/zm_combat::main();
}

//Function Number: 2
cancontinuetomelee()
{
	return canmeleeinternal("already started");
}

//Function Number: 3
canmeleeanyrange()
{
	return canmeleeinternal("any range");
}

//Function Number: 4
canmeleedesperate()
{
	return canmeleeinternal("long range");
}

//Function Number: 5
canmelee()
{
	return canmeleeinternal("normal");
}

//Function Number: 6
canmeleeinternal(state)
{
	if(!(issentient(self.enemy)))
	{
		return 0;
	}

	if(!(isalive(self.enemy)))
	{
		return 0;
	}

	if(IsDefined(self.disablemelee))
	{
/#
		assert(self.disablemelee);
#/
		return 0;
	}

	yaw = Abs(getyawtoenemy());
	if((yaw > 60 && state != "already started") || yaw > 110)
	{
		return 0;
	}

	enemypoint = self.enemy getorigin();
	vectoenemy = enemypoint - self.origin;
	self.enemydistancesq = lengthsquared(vectoenemy);
	if(self.enemydistancesq <= anim.meleerangesq)
	{
		if(!(ismeleepathclear(vectoenemy,enemypoint)))
		{
			return 0;
		}

		return 1;
	}

	if(state != "any range")
	{
		chargerangesq = anim.chargerangesq;
		if(state == "long range")
		{
			chargerangesq = anim.chargelongrangesq;
		}

		if(self.enemydistancesq > chargerangesq)
		{
			return 0;
		}
	}

	if(state == "already started")
	{
		return 0;
	}

	if(IsDefined(self.check_melee_path) && self.check_melee_path)
	{
		if(!(ismeleepathclear(vectoenemy,enemypoint)))
		{
			self notify("melee_path_blocked");
			return 0;
		}
	}

	if(IsDefined(level.can_melee))
	{
		if(!(self [[ level.can_melee ]]()))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 7
ismeleepathclear(vectoenemy,enemypoint)
{
	dirtoenemy = vectornormalize((vectoenemy[0],vectoenemy[1],0));
	meleepoint = enemypoint - (dirtoenemy[0] * 28,dirtoenemy[1] * 28,0);
	if(!(self isingoal(meleepoint)))
	{
		return 0;
	}

	if(self maymovetopoint(meleepoint))
	{
		return 1;
	}

	trace1 = bullettrace(20 + VectorScale((0,0,1)),self.origin,20 + VectorScale((0,0,1)),meleepoint);
	trace2 = bullettrace(72 + VectorScale((0,0,1)),self.origin,72 + VectorScale((0,0,1)),meleepoint);
	if(IsDefined(trace1["fraction"]) && trace1["fraction"] == 1 && IsDefined(trace2["fraction"]) && trace2["fraction"] == 1)
	{
		return 1;
	}

	if(IsDefined(trace1["entity"]) && trace1["entity"] == self.enemy && IsDefined(trace2["entity"]) && trace2["entity"] == self.enemy)
	{
		return 1;
	}

	if(IsDefined(level.zombie_melee_in_water) && level.zombie_melee_in_water)
	{
		if(IsDefined(trace1["surfacetype"]) && trace1["surfacetype"] == "water" && IsDefined(trace2["fraction"]) && trace2["fraction"] == 1)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 8
set_zombie_melee_anim_state(zombie)
{
	if(IsDefined(level.melee_anim_state))
	{
		melee_anim_state = self [[ level.melee_anim_state ]]();
	}

	if(!(IsDefined(melee_anim_state)))
	{
		if(!zombie.has_legs && zombie.a.gib_ref == "no_legs")
		{
			melee_anim_state = "zm_stumpy_melee";
		}
		else
		{
			switch(zombie.zombie_move_speed)
			{
				case "walk":
					melee_anim_state = append_missing_legs_suffix("zm_walk_melee");
					break;

				case "run":
				case "sprint":
				default:
					melee_anim_state = append_missing_legs_suffix("zm_run_melee");
					break;
			}
		}
	}

	zombie setanimstatefromasd(melee_anim_state);
}