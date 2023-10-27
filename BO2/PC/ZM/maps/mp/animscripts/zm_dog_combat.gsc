/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\zm_dog_combat.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 116 ms
 * Timestamp: 10/27/2023 3:02:08 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/animscripts/dog_stop;
#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;
#include maps/mp/animscripts/zm_shared;

//Function Number: 1
main()
{
	debug_anim_print("dog_combat::main() ");
	self endon("killanimscript");
	self setaimanimweights(0,0);
/#
	combatidle();
debug_allow_combat()
#/
	if(IsDefined(level.hostmigrationtimer))
	{
		combatidle();
		return;
	}

/#
	assert(IsDefined(self.enemy));
#/
	if(!(isalive(self.enemy)))
	{
		combatidle();
		return;
	}

	if(isplayer(self.enemy))
	{
		self meleebiteattackplayer(self.enemy);
	}
}

//Function Number: 2
combatidle()
{
	self set_orient_mode("face enemy");
	self animmode("zonly_physics");
	idleanim = "zm_combat_attackidle";
	debug_anim_print("dog_combat::combatIdle() - Setting " + idleanim);
	self setanimstatefromasd(idleanim);
	maps/mp/animscripts/zm_shared::donotetracks("attack_combat");
	debug_anim_print("dog_combat::combatIdle() - " + idleanim + " notify done.");
}

//Function Number: 3
shouldwaitincombatidle()
{
	if(IsDefined(level.hostmigrationtimer))
	{
		return 1;
	}

/#
	assert(IsDefined(self.enemy) && isalive(self.enemy));
#/
	return IsDefined(self.enemy.dogattackallowtime) && GetTime() < self.enemy.dogattackallowtime;
}

//Function Number: 4
setnextdogattackallowtime(time)
{
	self.dogattackallowtime = GetTime() + time;
}

//Function Number: 5
meleebiteattackplayer(player)
{
	self animmode("gravity",0);
	self.safetochangescript = 0;
	prepareattackplayer(player);
	attack_time = 1.2 + randomfloat(0.4);
	debug_anim_print("dog_combat::meleeBiteAttackPlayer() - Setting  combat_run_attack");
	self setanimstatefromasd("zm_combat_attackidle");
	maps/mp/animscripts/zm_shared::donotetracksfortime(attack_time,"attack_combat",::handlemeleebiteattacknotetracks,player);
	debug_anim_print("dog_combat::meleeBiteAttackPlayer() - combat_attack_run notify done.");
	self.safetochangescript = 1;
	self animmode("none",0);
}

//Function Number: 6
meleebiteattackplayer2(player)
{
	attackrangebuffer = 30;
	for(;;)
	{
		if(!(isalive(self.enemy)))
		{
			break;
		}

		meleerange = self.meleeattackdist + attackrangebuffer;
		if(IsDefined(player.syncedmeleetarget) && player.syncedmeleetarget != self)
		{
			if(checkendcombat(meleerange))
			{
				break;
			}
			else
			{
				combatidle();
				continue;
			}
		}

		if(self shouldwaitincombatidle())
		{
			combatidle();
			continue;
		}

		self set_orient_mode("face enemy");
		self animmode("gravity");
		self.safetochangescript = 0;
/#
		iprintln("dog " + self getentnum() + " attack player " + GetTime());
	GetDvarInt(#"7B06BF0D")
#/
		player setnextdogattackallowtime(200);
		if(dog_cant_kill_in_one_hit(player))
		{
			level.lastdogmeleeplayertime = GetTime();
			level.dogmeleeplayercounter++;
			if(use_low_attack())
			{
				self animmode("angle deltas");
				self setanimstatefromasd("zm_combat_attack_player_close_range");
				domeleeafterwait(0.1);
				maps/mp/animscripts/zm_shared::donotetracksfortime(1.4,"attack_combat");
				self animmode("gravity");
				continue;
			}

			attack_time = 1.2 + randomfloat(0.4);
			debug_anim_print("dog_combat::meleeBiteAttackPlayer() - Setting  combat_run_attack");
			self setanimstatefromasd("zm_combat_attackidle");
			domeleeafterwait(0.1);
			maps/mp/animscripts/zm_shared::donotetracksfortime(attack_time,"attack_combat",::handlemeleebiteattacknotetracks,player);
			debug_anim_print("dog_combat::meleeBiteAttackPlayer() - combat_attack_run notify done.");
		}
		else
		{
			self thread dog_melee_death(player);
			player.attacked_by_dog = 1;
			self thread clear_player_attacked_by_dog_on_death(player);
			debug_anim_print("dog_combat::meleeBiteAttackPlayer() - Setting  combat_attack_player");
			self setanimstate("combat_attack_player");
			self maps/mp/animscripts/shared::donotetracks("done",::handlemeleefinishattacknotetracks,player);
			debug_anim_print("dog_combat::meleeBiteAttackPlayer() - combat_attack_player notify done.");
			self notify("dog_no_longer_melee_able");
			self setcandamage(1);
			self unlink();
		}

		self.safetochangescript = 1;
		if(checkendcombat(meleerange))
		{
			break;
		}
	}

	self.safetochangescript = 1;
	self animmode("none");
}

//Function Number: 7
domeleeafterwait(time)
{
	self endon("death");
	wait(time);
	hitent = self melee();
	if(IsDefined(hitent))
	{
		if(isplayer(hitent))
		{
			hitent shellshock("dog_bite",1);
		}
	}
}

//Function Number: 8
handlemeleebiteattacknotetracks2(note,player)
{
	if(note == "dog_melee")
	{
		self melee(AnglesToForward(self.angles));
	}
}

//Function Number: 9
handlemeleebiteattacknotetracks(note,player)
{
	switch(note)
	{
		case "dog_melee":
			level.dogmeleebiteattacktime = GetTime() - level.dogmeleebiteattacktimestart;
			level.dogmeleebiteattacktime = level.dogmeleebiteattacktime + 50;
			hitent = self melee(AnglesToForward(self.angles));
			hitent shellshock("dog_bite",1);
			continue;
			self [[ level.dog_melee_miss ]](player);
			break;
	IsDefined(level.dog_melee_miss)
	isplayer(hitent)
	IsDefined(hitent)
	IsDefined(level.dogmeleebiteattacktime)
			break;

		case "stop_tracking":
			melee_time = 200;
			level.dogmeleebiteattacktimestart = GetTime();
			melee_time = level.dogmeleebiteattacktime;
			self thread orienttoplayerdeadreckoning(player,melee_time);
			break;
	Stack-Empty ? Stack-Empty : IsDefined(level.dogmeleebiteattacktime)
			break;
	}
}

//Function Number: 10
handlemeleefinishattacknotetracks(note,player)
{
	switch(note)
	{
		case "dog_melee":
			level.dogmeleefinishattacktime = GetTime() - level.dogmeleefinishattacktimestart;
			level.dogmeleefinishattacktime = level.dogmeleefinishattacktime + 50;
			hitent = self melee(AnglesToForward(self.angles));
			break;
			attackmiss();
			return 1;
	(IsDefined(level.dogmeleefinishattacktime)) ? IsDefined(hitent) && isalive(player) : hitent == player
			break;

		case "dog_early":
			self notify("dog_early_notetrack");
			debug_anim_print("dog_combat::handleMeleeFinishAttackNoteTracks() - Setting  combat_attack_player_early");
			self setanimstate("combat_attack_player_early");
			break;

		case "dog_lunge":
			thread set_melee_timer(player);
			debug_anim_print("dog_combat::handleMeleeFinishAttackNoteTracks() - Setting  combat_attack_player_lunge");
			self setanimstate("combat_attack_player_lunge");
			break;

		case "dogbite_damage":
			self thread killplayer(player);
			break;

		case "stop_tracking":
			melee_time = 200;
			level.dogmeleefinishattacktimestart = GetTime();
			melee_time = level.dogmeleefinishattacktime;
			self thread orienttoplayerdeadreckoning(player,melee_time);
			break;
	Stack-Empty ? Stack-Empty : IsDefined(level.dogmeleefinishattacktime)
			break;
	}
}

//Function Number: 11
orienttoplayerdeadreckoning(player,time_till_bite)
{
	enemy_attack_current_origin = player.origin;
	enemy_attack_current_time = GetTime();
	enemy_motion_time_delta = enemy_attack_current_time - self.enemy_attack_start_time;
	enemy_motion_direction = enemy_attack_current_origin - self.enemy_attack_start_origin;
	if(enemy_motion_time_delta == 0)
	{
		enemy_predicted_position = player.origin;
	}
	else
	{
		enemy_velocity = enemy_motion_direction / enemy_motion_time_delta;
		enemy_predicted_position = player.origin + enemy_velocity * time_till_bite;
	}

	self set_orient_mode("face point",enemy_predicted_position);
}

//Function Number: 12
checkendcombat(meleerange)
{
	if(!(IsDefined(self.enemy)))
	{
		return 0;
	}

	disttotargetsq = distancesquared(self.origin,self.enemy.origin);
	return disttotargetsq > meleerange * meleerange;
}

//Function Number: 13
use_low_attack(player)
{
	height_diff = self.enemy_attack_start_origin[2] - self.origin[2];
	low_enough = 30;
	if(height_diff < low_enough && self.enemy_attack_start_stance == "prone")
	{
		return 1;
	}

	melee_origin = (self.origin[0],self.origin[1],self.origin[2] + 65);
	enemy_origin = (self.enemy.origin[0],self.enemy.origin[1],self.enemy.origin[2] + 32);
	if(!(bullettracepassed(melee_origin,enemy_origin,0,self)))
	{
		return 1;
	}

	return 0;
}

//Function Number: 14
prepareattackplayer(player)
{
	level.dog_death_quote = &"SCRIPT_PLATFORM_DOG_DEATH_DO_NOTHING";
	distancetotarget = distance(self.origin,self.enemy.origin);
	targetheight = Abs(self.enemy.origin[2] - self.origin[2]);
	self.enemy_attack_start_distance = distancetotarget;
	self.enemy_attack_start_origin = player.origin;
	self.enemy_attack_start_time = GetTime();
	self.enemy_attack_start_stance = player getstance();
}

//Function Number: 15
attackteleportthread(offset)
{
	self endon("death");
	self endon("killanimscript");
	reps = 5;
	increment = (offset[0] / reps,offset[1] / reps,offset[2] / reps);
	for(i = 0;i < reps;i++)
	{
		self teleport(self.origin + increment);
		wait(0.05);
	}
}

//Function Number: 16
player_attacked()
{
	return isalive(self) && self meleebuttonpressed();
}

//Function Number: 17
set_melee_timer(player)
{
	wait(0.15);
	self.melee_able_timer = GetTime();
}

//Function Number: 18
clear_player_attacked_by_dog_on_death(player)
{
	self waittill("death");
	player.attacked_by_dog = undefined;
}

//Function Number: 19
dog_cant_kill_in_one_hit(player)
{
	return 1;
	if(IsDefined(player.dogs_dont_instant_kill))
	{
/#
		assert(player.dogs_dont_instant_kill,"Dont set player.dogs_dont_instant_kill to false, set to undefined");
#/
		return 1;
	}

	if(GetTime() - level.lastdogmeleeplayertime > 8000)
	{
		level.dogmeleeplayercounter = 0;
	}

	return level.dogmeleeplayercounter < level.dog_hits_before_kill && player.health > 25;
}

//Function Number: 20
dog_melee_death(player)
{
	self endon("killanimscript");
	self endon("dog_no_longer_melee_able");
	pressed = 0;
	press_time = anim.dog_presstime;
	self waittill("dog_early_notetrack");
	while(player player_attacked())
	{
		wait(0.05);
	}

	for(;;)
	{
		if(!(pressed))
		{
			if(player player_attacked())
			{
				pressed = 1;
				if(IsDefined(self.melee_able_timer) && isalive(player))
				{
					if(GetTime() - self.melee_able_timer <= press_time)
					{
						player.player_view.custom_dog_save = "neck_snap";
						self notify("melee_stop");
						debug_anim_print("dog_combat::dog_melee_death() - Setting  combat_player_neck_snap");
						self setanimstate("combat_player_neck_snap");
						self waittillmatch
						return "done";
						("dog_death");
						debug_anim_print("dog_combat::dog_melee_death() - combat_player_neck_snap notify done.");
						self playsound("aml_dog_neckbreak");
						self setcandamage(1);
						self.a.nodeath = 1;
						dif = player.origin - self.origin;
						dif = (dif[0],dif[1],0);
						self dodamage(self.health + 503,self geteye() - dif,player);
						self notify("killanimscript");
					}
					else
					{
						debug_anim_print("dog_combat::dog_melee_death() - Setting  combat_player_neck_snap");
						self setanimstate("combat_attack_player");
						level.dog_death_quote = &"SCRIPT_PLATFORM_DOG_DEATH_TOO_LATE";
					}

					return;
				}

				level.dog_death_quote = &"SCRIPT_PLATFORM_DOG_DEATH_TOO_SOON";
				debug_anim_print("dog_combat::dog_melee_death() - Setting  combat_player_neck_miss");
				self setanimstate("combat_player_neck_miss");
				return;
			}
		}
		else if(!(player player_attacked()))
		{
			pressed = 0;
		}

		wait(0.05);
	}
}

//Function Number: 21
attackmiss()
{
	if(IsDefined(self.enemy))
	{
		forward = AnglesToForward(self.angles);
		dirtoenemy = self.origin - 50 + VectorScale(forward);
		if(vectordot(dirtoenemy,forward) > 0)
		{
			debug_anim_print("dog_combat::attackMiss() - Setting  combat_attack_miss");
			self setanimstate("combat_attack_miss");
			self thread maps/mp/animscripts/dog_stop::lookattarget("normal");
		}
		else
		{
			self.skipstartmove = 1;
			self thread attackmisstracktargetthread();
			if(dirtoenemy[0] * forward[1] - dirtoenemy[1] * forward[0] > 0)
			{
				debug_anim_print("dog_combat::attackMiss() - Setting  combat_attack_miss_right");
				self setanimstate("combat_attack_miss_right");
			}
			else
			{
				debug_anim_print("dog_combat::attackMiss() - Setting  combat_attack_miss_left");
				self setanimstate("combat_attack_miss_left");
			}
		}
	}
	else
	{
		debug_anim_print("dog_combat::attackMiss() - Setting  combat_attack_miss");
		self setanimstate("combat_attack_miss");
	}

	self maps/mp/animscripts/shared::donotetracks("done");
	debug_anim_print("dog_combat::attackMiss() - attackMiss notify done.");
	self notify("stop tracking",self.enemy.origin);
	debug_anim_print("dog_combat::attackMiss() - Stopped tracking");
}

//Function Number: 22
attackmisstracktargetthread()
{
	self endon("killanimscript");
	wait(0.6);
	self set_orient_mode("face enemy");
}

//Function Number: 23
killplayer(player)
{
	self endon("pvd_melee_interrupted");
	player.specialdeath = 1;
	player setcandamage(1);
	wait(1);
	damage = player.health + 1;
	if(!(isalive(player)))
	{
	}